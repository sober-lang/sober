// check.ts <port> [--frag-random N] [--echo-big] — HttpArenaのvalidate.sh / validate-frag.pyを模した検査（net 4c — gate httpcheck）。
// 相手 = testdata/httpcheck/srv.sober（/baseline11・/pipeline・/delay/{ms}・/json/{count}?m=・POST /echo・POST /upload・/sse）。node --experimental-strip-types check.ts 18080
// --echo-big: echo の大きい本文の格子だけ（100 KB・上限ちょうどの 128 KiB を Content-Length と chunked で + 上限を超えた 128 KiB + 1 B と 1 MB は 413 —
// 相手は SRV_MAXBODY = 131072 の srv〔bench/httparena の entry と同じ上限〕。report-848 / 849）
import * as net from "node:net";
import * as tls from "node:tls";
import * as http from "node:http";
import { spawnSync } from "node:child_process";
import { randomBytes } from "node:crypto";
import { mkdirSync, readFileSync, statSync, symlinkSync, utimesSync, writeFileSync } from "node:fs";
import { constants as zc, createGunzip, gunzipSync, gzipSync } from "node:zlib";

const port = Number(process.argv[2]);
const echoBig = process.argv.includes("--echo-big");
// --tls: 生の送受を TLS の上で（相手 = srv の SRV_TLS_PORT — tls.Serve + ServeWith の put:）。fetch / curl / EventSource の受け手を使う群は飛ばす
const useTls = process.argv.includes("--tls");
const CONNECT = useTls ? "secureConnect" : "connect";
function dial(): net.Socket {
    return useTls ? tls.connect({ port, host: "127.0.0.1", rejectUnauthorized: false }) : net.createConnection({ port, host: "127.0.0.1" });
}
const staticDir = process.argv.includes("--static") ? process.argv[process.argv.indexOf("--static") + 1] : "";
const fragRandom = Number(process.argv[process.argv.indexOf("--frag-random") + 1] ?? 100) || 100;
let pass = 0;
let fail = 0;
const fails: string[] = [];
function ok(name: string, cond: boolean, detail = "") {
    if (cond) pass++;
    else {
        fail++;
        // 落ちた時刻（CLOCK_MONOTONIC — サーバの飛行記録のウィンドウを引く。詳細に既にt= があれば足さない）
        fails.push(`${name}${detail ? " — " + detail : ""}${detail.includes("t=") ? "" : ` t=${process.hrtime.bigint()}`}`);
    }
}

type Resp = { status: number; headers: Map<string, string>; body: string; chunks?: number[] };

// parseAllは受けたバイト列のレスポンスを順に読む（Content-Length・chunked〔chunks = chunkの長さの列 — 終端の0は含まない・trailerは無い前提〕・
// 閉じで区切る〔Content-LengthもTransfer-Encodingも無い本文つきのレスポンス — 相手が閉じた後だけ: closed〕— タスク8の段階8-2）
let headOnly = false;
function parseAll(buf: Buffer, closed = false): { resps: Resp[]; rest: number } {
    const resps: Resp[] = [];
    let p = 0;
    for (;;) {
        const he = buf.indexOf("\r\n\r\n", p);
        if (he < 0) break;
        const lines = buf.subarray(p, he).toString("latin1").split("\r\n");
        const status = Number(lines[0].split(" ")[1]);
        const headers = new Map<string, string>();
        for (const l of lines.slice(1)) {
            const i = l.indexOf(":");
            headers.set(l.slice(0, i).toLowerCase(), l.slice(i + 1).trim());
        }
        const noBody = headOnly || status < 200 || status === 204 || status === 304;
        if (!noBody && headers.get("transfer-encoding") === "chunked") {
            const chunks: number[] = [];
            const parts: Buffer[] = [];
            let q = he + 4;
            let done = false;
            for (;;) {
                const le = buf.indexOf("\r\n", q);
                if (le < 0) break;
                const size = parseInt(buf.subarray(q, le).toString("latin1"), 16);
                if (Number.isNaN(size)) break;
                if (size === 0) {
                    if (buf.length < le + 4) break;
                    if (buf.subarray(le + 2, le + 4).toString("latin1") !== "\r\n") break;
                    q = le + 4;
                    done = true;
                    break;
                }
                if (buf.length < le + 2 + size + 2) break;
                parts.push(buf.subarray(le + 2, le + 2 + size));
                chunks.push(size);
                q = le + 2 + size + 2;
            }
            if (!done) break;
            resps.push({ status, headers, body: Buffer.concat(parts).toString("latin1"), chunks });
            p = q;
            continue;
        }
        if (!noBody && !headers.has("content-length") && !headers.has("transfer-encoding")) {
            // 閉じで区切る — 相手が閉じるまで本文
            if (!closed) break;
            resps.push({ status, headers, body: buf.subarray(he + 4).toString("latin1") });
            p = buf.length;
            break;
        }
        const cl = noBody ? 0 : Number(headers.get("content-length") ?? "0");
        if (he + 4 + cl > buf.length) break;
        resps.push({ status, headers, body: buf.subarray(he + 4, he + 4 + cl).toString("latin1") });
        p = he + 4 + cl;
    }
    return { resps, rest: p };
}

// exchangeはpartsを間隔 gap ms で書き、want件のレスポンスが揃うか相手が閉じるまで読む → レスポンスと閉じられたか
// lport = 手元の port（サーバの飛行記録の ACCEPT の相手の port と 1:1 — 落ちの詳細に出す）
function exchange(parts: (string | Buffer)[], want: number, gap = 20, timeout = 5000): Promise<{ resps: Resp[]; closed: boolean; raw: Buffer; lport: number }> {
    return new Promise((resolve) => {
        const s = dial();
        s.setNoDelay(true);
        let buf = Buffer.alloc(0);
        let done = false;
        let lport = 0;
        const finish = (closed: boolean) => {
            if (done) return;
            done = true;
            clearTimeout(t);
            s.destroy();
            resolve({ resps: parseAll(buf, closed).resps, closed, raw: buf, lport });
        };
        const t = setTimeout(() => finish(false), timeout);
        s.on("data", (d) => {
            buf = Buffer.concat([buf, d]);
            if (want > 0 && parseAll(buf).resps.length >= want && want < 1000) {
                // 揃った — こちらの書きを閉じて（FIN）相手の閉じを少しだけ待つ（keep の検査は呼び手が closed を見る。
                // 誤りのレスポンスの後のサーバは残りを読み捨ててから閉じる — lingering close）
                s.end();
                setTimeout(() => finish(false), 300);
            }
        });
        s.on("end", () => finish(true));
        s.on("close", () => finish(true));
        s.on("error", () => finish(true));
        s.on(CONNECT, async () => {
            lport = s.localPort ?? 0;
            for (let i = 0; i < parts.length; i++) {
                if (i > 0) await new Promise((r) => setTimeout(r, gap));
                if (!s.destroyed) s.write(parts[i]);
            }
        });
    });
}

const rnd = (a: number, b: number) => a + Math.floor(Math.random() * (b - a + 1));

// monoは今のCLOCK_MONOTONIC（ns — Linuxのprocess.hrtime。サーバの飛行記録〔SOBER_FLIGHT — report-1175〕の時刻と同じ時計で、落ちた瞬間のウィンドウを引く）
const mono = () => `t=${process.hrtime.bigint()}`;

// errWhy は失敗した fetch の理由（undici は接続の誤りを err.cause に持つ — 名前・code・message）+ 時刻と、undici の SocketError なら手元の port
// （cause.socket.localPort — サーバの飛行記録の ACCEPT の相手の port と 1:1）
function errWhy(err: any): string {
    const c = err?.cause;
    const lp = c?.socket?.localPort;
    return `${err?.name ?? "?"}: ${err?.message ?? ""}${c ? ` (cause ${c.code ?? c.name ?? "?"}: ${c.message ?? ""})` : ""} ${mono()}${lp !== undefined ? ` lport=${lp}` : ""}`;
}

async function one(name: string, req: string | Buffer, wantStatus: number, wantBody: string | null, opts: { closed?: boolean; ctype?: string } = {}) {
    const r = await exchange([req], 1);
    const x = r.resps[0];
    if (!x) {
        ok(name, false, `no response (closed=${r.closed} raw=${JSON.stringify(r.raw.toString("latin1").slice(0, 80))}) lport=${r.lport}`);
        return;
    }
    let good = x.status === wantStatus && (wantBody === null || x.body === wantBody);
    if (opts.ctype !== undefined) good &&= (x.headers.get("content-type") ?? "").startsWith(opts.ctype);
    if (opts.closed !== undefined) good &&= r.closed === opts.closed;
    ok(name, good, `got ${x.status} ${JSON.stringify(x.body)} ct=${x.headers.get("content-type")} closed=${r.closed} lport=${r.lport}`);
}

const H = "Host: localhost\r\n";

// ── baseline（validate.sh 1236〜）
async function baseline() {
    await one("GET baseline", `GET /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, "55", { ctype: "text/plain", closed: true });
    await one("POST CL", `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Type: text/plain\r\nContent-Length: 2\r\nConnection: close\r\n\r\n20`, 200, "75", { ctype: "text/plain" });
    await one("POST chunked", `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Type: text/plain\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n2\r\n20\r\n0\r\n\r\n`, 200, "75");
    for (let k = 0; k < 20; k++) {
        const a = rnd(100, 999), b = rnd(100, 999), body = rnd(100, 999);
        await one(`GET random ${a},${b}`, `GET /baseline11?a=${a}&b=${b} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, String(a + b));
        await one(`POST random body ${body}`, `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Length: ${String(body).length}\r\nConnection: close\r\n\r\n${body}`, 200, String(55 + body));
    }
    await one("lower-cased headers", `POST /baseline11?a=13&b=42 HTTP/1.1\r\nhost: localhost\r\ncontent-type: text/plain\r\ncontent-length: 2\r\nconnection: close\r\n\r\n20`, 200, "75");
    await one("pipeline", `GET /pipeline HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, "ok", { ctype: "text/plain" });
    await one("404", `GET /nope HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 404, "");
    // 保存の方針の既定（effectのマイルストーンの段階4a — cacheの無い動的なレスポンスはCache-Control: private・404も。Staticはcache: 省略でno-cache — staticEp）
    const cp = await exchange([`GET /pipeline HTTP/1.1\r\n${H}\r\nGET /nope HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 2);
    ok("default cache-control private", cp.resps.length === 2 && cp.resps.every((x) => x.headers.get("cache-control") === "private"),
        JSON.stringify(cp.resps.map((x) => x.headers.get("cache-control"))));
    headOnly = true;
    await one("HEAD no body", `HEAD /pipeline HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, "");
    headOnly = false;
    await one("leading CRLF", `\r\n\r\nGET /pipeline HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, "ok");
    await one("bare LF lines", `GET /pipeline HTTP/1.1\n${H.replace("\r", "")}Connection: close\n\n`, 200, "ok");
    await one("chunk ext + trailer", `POST /baseline11?a=1&b=2 HTTP/1.1\r\n${H}Transfer-Encoding: Chunked\r\nConnection: close\r\n\r\n1;x=y\r\n7\r\n0\r\nX-T: 1\r\n\r\n`, 200, "10");
    await one("HTTP/1.0 closes", `GET /pipeline HTTP/1.0\r\n${H}\r\n`, 200, "ok", { closed: true });
}

// ── 断片化（validate-frag.py の 9 通りの形 — 代表点 + 乱数の位置）
function shapes(): [string, string, string][] {
    const RA = rnd(100, 999), RB = rnd(100, 999), RBODY = rnd(10, 99);
    return [
        ["GET, minimal", `GET /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, "55"],
        ["GET, several headers", `GET /baseline11?a=13&b=42 HTTP/1.1\r\n${H}User-Agent: arena-frag/1.0\r\nAccept: text/plain\r\nAccept-Encoding: identity\r\nConnection: close\r\n\r\n`, "55"],
        ["GET, lower-cased", `GET /baseline11?a=13&b=42 HTTP/1.1\r\nhost: localhost\r\nuser-agent: arena-frag/1.0\r\nconnection: close\r\n\r\n`, "55"],
        ["GET, randomized", `GET /baseline11?a=${RA}&b=${RB} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, String(RA + RB)],
        ["POST, CL", `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Type: text/plain\r\nContent-Length: 2\r\nConnection: close\r\n\r\n20`, "75"],
        ["POST, lower CL", `POST /baseline11?a=13&b=42 HTTP/1.1\r\nhost: localhost\r\ncontent-type: text/plain\r\ncontent-length: 2\r\nconnection: close\r\n\r\n20`, "75"],
        ["POST, randomized", `POST /baseline11?a=${RA}&b=${RB} HTTP/1.1\r\n${H}Content-Type: text/plain\r\nContent-Length: ${String(RBODY).length}\r\nConnection: close\r\n\r\n${RBODY}`, String(RA + RB + RBODY)],
        ["POST, chunked", `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Type: text/plain\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n2\r\n20\r\n0\r\n\r\n`, "75"],
        ["POST, chunked x2", `POST /baseline11?a=13&b=42 HTTP/1.1\r\n${H}Content-Type: text/plain\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n1\r\n2\r\n1\r\n0\r\n0\r\n\r\n`, "75"],
    ];
}

// 代表点: CR と LF の間・Content-Length の桁の途中・chunk の 16 進の途中・ヘッダ名の途中・空行の途中
function repPoints(req: string): number[] {
    const pts = new Set<number>();
    for (let i = 0; i < req.length - 1; i++) {
        if (req[i] === "\r" && req[i + 1] === "\n") pts.add(i + 1);
    }
    const clm = /content-length: (\d+)/i.exec(req);
    if (clm) pts.add(clm.index + clm[0].length - 1);
    const hn = req.search(/\r\n[A-Za-z-]{4,}:/);
    if (hn >= 0) pts.add(hn + 4);
    const ch = req.indexOf("\r\n\r\n");
    if (/chunked/i.test(req)) {
        pts.add(ch + 4); // 本文の手前
        pts.add(ch + 5); // 最初の chunk の 16 進の後
        pts.add(req.length - 3); // 最後の空行の途中
    }
    pts.add(1);
    pts.add(req.length - 1);
    return [...pts].filter((p) => p > 0 && p < req.length).sort((a, b) => a - b);
}

async function frag() {
    const jobs: [string, string, string, number][] = [];
    for (const [name, req, want] of shapes()) {
        for (const p of repPoints(req)) jobs.push([name, req, want, p]);
    }
    const all = shapes();
    for (let k = 0; k < fragRandom; k++) {
        const [name, req, want] = all[k % all.length];
        jobs.push([name, req, want, rnd(1, req.length - 1)]);
    }
    // 3 分割も少し（CR | LF | 残り）
    let reps = 0;
    const batch = 64;
    for (let i = 0; i < jobs.length; i += batch) {
        await Promise.all(jobs.slice(i, i + batch).map(async ([name, req, want, p]) => {
            const r = await exchange([req.slice(0, p), req.slice(p)], 1, 100);
            const x = r.resps[0];
            reps++;
            ok(`frag ${name} @${p}`, !!x && x.status === 200 && x.body === want, x ? `got ${x.status} ${x.body}` : "no response");
        }));
    }
    // 1 バイトずつ（chunked の形 — 全位置の境界を 1 本で）
    for (const [name, req, want] of all.filter((s) => /chunked|POST, CL/.test(s[0]))) {
        const r = await exchange(req.split(""), 1, 2, 10000);
        ok(`bytewise ${name}`, r.resps[0]?.body === want, `got ${r.resps[0]?.status} ${r.resps[0]?.body}`);
    }
    return jobs.length;
}

// ── パイプライン 16 本・keep-alive の張り直し（limited-conn）
async function pipeline() {
    const one = `GET /pipeline HTTP/1.1\r\n${H}\r\n`;
    const r = await exchange([one.repeat(16)], 16);
    ok("pipelined 16", r.resps.length === 16 && r.resps.every((x) => x.body === "ok"), `n=${r.resps.length} closed=${r.closed}`);
    // 混ぜたパイプライン（GET / POST CL / chunked / 最後に close）
    const mix = `GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}\r\n` +
        `POST /baseline11?a=1&b=2 HTTP/1.1\r\n${H}Content-Length: 1\r\n\r\n4` +
        `POST /baseline11?a=1&b=2 HTTP/1.1\r\n${H}Transfer-Encoding: chunked\r\n\r\n1\r\n5\r\n0\r\n\r\n` +
        `GET /pipeline HTTP/1.1\r\n${H}Connection: close\r\n\r\n` +
        `GET /pipeline HTTP/1.1\r\n${H}\r\n`;
    const m = await exchange([mix], 1000);
    ok("pipelined mix + close", m.resps.map((x) => x.body).join(",") === "3,7,8,ok" && m.closed, `${m.resps.map((x) => x.body).join(",")} closed=${m.closed}`);
    // limited-conn: 10リクエストずつ張り直し × 50
    let good = 0;
    for (let c = 0; c < 50; c++) {
        const s = dial();
        await new Promise((r) => s.on(CONNECT, r));
        let buf = Buffer.alloc(0);
        let n = 0;
        for (let i = 0; i < 10; i++) {
            const a = rnd(1, 99);
            s.write(`GET /baseline11?a=${a}&b=1 HTTP/1.1\r\n${H}\r\n`);
            await new Promise<void>((res) => {
                const on = (d: Buffer) => {
                    buf = Buffer.concat([buf, d]);
                    const { resps, rest } = parseAll(buf);
                    if (resps.length > 0) {
                        if (resps[0].body === String(a + 1)) n++;
                        buf = buf.subarray(rest);
                        s.off("data", on);
                        res();
                    }
                };
                s.on("data", on);
            });
        }
        s.end();
        if (n === 10) good++;
    }
    ok("limited-conn 50x10", good === 50, `good=${good}`);
    // HTTP/1.0 keep-alive
    const k = await exchange([`GET /pipeline HTTP/1.0\r\nConnection: keep-alive\r\n\r\n`, `GET /pipeline HTTP/1.0\r\n\r\n`], 1000, 100);
    ok("HTTP/1.0 keep-alive", k.resps.length === 2 && k.resps[0].headers.get("connection") === "keep-alive" && k.closed, `n=${k.resps.length} closed=${k.closed}`);
}

// ── 誤り（400 / 413 / 431 / 501 / 505 — レスポンスの後は閉じる）
async function errors() {
    const e = async (name: string, req: string | Buffer, st: number) => one(name, req, st, "", { closed: true });
    await e("garbage request line", "HELLO\r\n\r\n", 400);
    await e("two spaces", "GET  / HTTP/1.1\r\n\r\n", 400);
    await e("extra token", "GET / HTTP/1.1 x\r\n\r\n", 400);
    await e("HTTP/2.0", "GET / HTTP/2.0\r\n\r\n", 505);
    await e("obs-fold", `GET / HTTP/1.1\r\n${H}X-A: 1\r\n  continued\r\n\r\n`, 400);
    await e("space before colon", `GET / HTTP/1.1\r\nHost : x\r\n\r\n`, 400);
    await e("no colon", `GET / HTTP/1.1\r\nHost\r\n\r\n`, 400);
    await e("bare CR", `GET / HTTP/1.1\r\nX-A: a\rb\r\n\r\n`, 400);
    await e("CL not digits", `POST / HTTP/1.1\r\nContent-Length: 1x\r\n\r\n1`, 400);
    await e("CL twice differ", `POST / HTTP/1.1\r\nContent-Length: 1\r\nContent-Length: 2\r\n\r\n12`, 400);
    await e("CL + TE", `POST / HTTP/1.1\r\nContent-Length: 1\r\nTransfer-Encoding: chunked\r\n\r\n0\r\n\r\n`, 400);
    await e("TE gzip", `POST / HTTP/1.1\r\nTransfer-Encoding: gzip\r\n\r\n`, 501);
    await e("chunk size bad", `POST / HTTP/1.1\r\nTransfer-Encoding: chunked\r\n\r\nzz\r\n`, 400);
    await e("chunk no CRLF after data", `POST / HTTP/1.1\r\nTransfer-Encoding: chunked\r\n\r\n1\r\nab\r\n0\r\n\r\n`, 400);
    await e("invalid UTF-8 path", Buffer.concat([Buffer.from("GET /\xff HTTP/1.1\r\n", "latin1"), Buffer.from("\r\n")]), 400);
    await e("CL > 16 KiB", `POST / HTTP/1.1\r\nContent-Length: 16385\r\n\r\n`, 413);
    await e("chunked > 16 KiB", `POST / HTTP/1.1\r\nTransfer-Encoding: chunked\r\n\r\n4001\r\n`, 413);
    await e("head > 8 KiB", `GET / HTTP/1.1\r\nX-Big: ${"a".repeat(9000)}\r\n\r\n`, 431);
    // 上限ちょうどは通る（本文 16384）
    const big = "1".repeat(16384);
    await one("CL = 16 KiB ok", `POST /pipeline HTTP/1.1\r\nContent-Length: 16384\r\nConnection: close\r\n\r\n${big}`, 200, "ok");
    const fb = await exchange([`POST /pipeline HTTP/1.1\r\nContent-Length: 16384\r\nConnection: close\r\n\r\n${big.slice(0, 5000)}`, big.slice(5000, 9000), big.slice(9000, 16000), big.slice(16000)], 1, 30);
    ok("CL = 16 KiB fragmented ok", fb.resps[0]?.body === "ok", `got ${fb.resps[0]?.status}`);
    const r = await exchange([`POST /pipeline HTTP/1.1\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n`, ...Array.from({ length: 16 }, () => `400\r\n${"x".repeat(1024)}\r\n`), "0\r\n\r\n"], 1, 5);
    ok("chunked 16 x 1 KiB ok", r.resps[0]?.body === "ok", `got ${r.resps[0]?.status}`);
}

// ── Delayed（/stamp — 256接続のkeep-alive〔ワーカー1本でも送り場のチャンクの数を越えて待つ〕。本文 = ハンドラのos.Monotonic〔ns〕。受けた時刻はprocess.hrtime = 同じCLOCK_MONOTONIC）: どのレスポンスもmsを待たずに出ない・
// レスポンスの前に次のリクエストを切片を分けて送る客では、後のリクエストのハンドラは前のDelayedの満了の後に走る
async function delayed() {
    const ds = [5, 10, 20];
    const conns = 256, per = 20;
    let n = 0;
    const early: string[] = [];
    await Promise.all(Array.from({ length: conns }, (_, c) => new Promise<void>((done) => {
        const s = dial();
        s.setNoDelay(true);
        let buf = Buffer.alloc(0);
        let k = 0;
        const ms = ds[c % ds.length];
        const send = () => s.write(`GET /stamp/${ms} HTTP/1.1\r\n${H}\r\n`);
        const t = setTimeout(() => { s.destroy(); done(); }, 20000);
        s.on("data", (d) => {
            const now = process.hrtime.bigint();
            buf = Buffer.concat([buf, d]);
            const r = parseAll(buf);
            if (r.resps.length === 0) return;
            buf = buf.subarray(r.rest);
            for (const x of r.resps) {
                n++;
                const dt = Number(now - BigInt(x.body)) / 1e6;
                if (!(dt >= ms)) early.push(`${ms} ms: ${dt.toFixed(3)} ms`);
                k++;
            }
            if (k < per) send();
            else { clearTimeout(t); s.destroy(); done(); }
        });
        s.on("error", () => { clearTimeout(t); done(); });
        s.on(CONNECT, send);
    })));
    ok("delayed keep-alive all", n === conns * per, `${n} / ${conns * per}`);
    ok("delayed keep-alive never early", early.length === 0, early.slice(0, 5).join(", "));
    // 切片を分けた後のリクエスト: ハンドラは満了の後（接続のtaskは満了まで次の受けを返さない）。1切片の2件: 後のリクエストのハンドラは待ちの前に走る
    // （待つのはリクエストのループを出てから — 順番を保つのはレスポンスだけ）ので、レスポンスが2件・順に揃うことだけを見る
    const parts = [`GET /stamp/50 HTTP/1.1\r\n${H}\r\n`, `GET /stamp/0 HTTP/1.1\r\n${H}\r\n`];
    const r1 = await exchange(parts, 2, 10);
    const a = BigInt(r1.resps[0]?.body ?? "0"), b = BigInt(r1.resps[1]?.body ?? "0");
    ok("delayed next handler after expiry", r1.resps.length === 2 && Number(b - a) / 1e6 >= 50, `${r1.resps.length} resps ${(Number(b - a) / 1e6).toFixed(3)} ms`);
    const r0 = await exchange([parts.join("")], 2);
    ok("delayed pipelined in one chunk", r0.resps.length === 2 && r0.resps.every((x) => x.status === 200), `${r0.resps.length} resps`);
}

// ── async（/delay — 待ちの下限と 32 本の並び）
async function delay() {
    const t0 = performance.now();
    await one("delay 0", `GET /delay/0 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, "0");
    const ms = rnd(10, 90);
    const t1 = performance.now();
    await one(`delay ${ms}`, `GET /delay/${ms} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 200, String(ms));
    ok(`delay ${ms} waits`, performance.now() - t1 >= 0.9 * ms, `${(performance.now() - t1).toFixed(1)} ms`);
    const ds = Array.from({ length: 32 }, () => rnd(100, 499));
    const t2 = performance.now();
    const rs = await Promise.all(ds.map(async (d) => {
        const s = performance.now();
        const r = await exchange([`GET /delay/${d} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
        return { d, body: r.resps[0]?.body, el: performance.now() - s };
    }));
    ok("delay x32", rs.every((x) => x.body === String(x.d) && x.el >= 0.9 * x.d), JSON.stringify(rs.filter((x) => !(x.body === String(x.d) && x.el >= 0.9 * x.d))));
    ok("delay x32 concurrent", performance.now() - t2 < 1500, `${(performance.now() - t2).toFixed(0)} ms`);
    void t0;
}

// ── json（/json/{count}?m= — 本家validate.shのjsonの検査の形: 乱数のcount × mを4組・全フィールドをdatasetと照合〔作ったitemの自己整合では通らない〕・
// Content-Type。加えて go-stdlib と同じ寛容さの端: count 0 / 本数超え・m が数でない / 0 → 1）
async function jsonEp() {
    const src = JSON.parse(readFileSync(new URL("./dataset.json", import.meta.url), "utf8"));
    const cases: [string, number, number][] = [];
    for (let i = 0; i < 4; i++) {
        const c = rnd(1, 50), m = rnd(2, 97);
        cases.push([`${c}?m=${m}`, c, m]);
    }
    cases.push(["0?m=3", 0, 3], ["60?m=2", 50, 2], ["5?m=x", 5, 1], ["7?m=0", 7, 1], ["9", 9, 1]);
    for (const [q, want, m] of cases) {
        const r = await exchange([`GET /json/${q} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
        const x = r.resps[0];
        let good = x?.status === 200 && (x.headers.get("content-type") ?? "").startsWith("application/json");
        let detail = `got ${x?.status} ct=${x?.headers.get("content-type")}`;
        if (good) {
            try {
                const d = JSON.parse(x!.body);
                const items = d.items as any[];
                good = d.count === want && items.length === want && items.every((it, i) => {
                    const s0 = src[i];
                    return it.id === s0.id && it.name === s0.name && it.category === s0.category && it.price === s0.price && it.quantity === s0.quantity &&
                        it.active === s0.active && JSON.stringify(it.tags) === JSON.stringify(s0.tags) && it.rating?.score === s0.rating.score &&
                        it.rating?.count === s0.rating.count && it.total === s0.price * s0.quantity * m;
                });
                detail = `count=${d.count} items=${items.length}`;
            } catch (e) {
                good = false;
                detail = `bad JSON: ${String(e).slice(0, 80)}`;
            }
        }
        ok(`json ${q}`, good, detail);
    }
}

// ── json-comp（/json/{count}?m= のgzip — 本家validate.shのjson-compの3検査〔Accept-Encoding: gzip, brでContent-Encodingが付き、解くと全フィールドが
// dataset と一致・Accept-Encoding なしで Content-Encoding を付けない〕+ Accept-Encoding の解釈〔token・q=0・x-gzip・*・複数の行〕・閾値 1024・Vary・
// HEAD の Content-Length・パイプライン — report-714）
function itemsOk(src: any[], body: string, want: number, m: number): string {
    try {
        const d = JSON.parse(body);
        const items = d.items as any[];
        const good = d.count === want && items.length === want && items.every((it, i) => {
            const s0 = src[i];
            return it.id === s0.id && it.name === s0.name && it.category === s0.category && it.price === s0.price && it.quantity === s0.quantity &&
                it.active === s0.active && JSON.stringify(it.tags) === JSON.stringify(s0.tags) && it.rating?.score === s0.rating.score &&
                it.rating?.count === s0.rating.count && it.total === s0.price * s0.quantity * m;
        });
        return good ? "" : `count=${d.count} items=${items.length}`;
    } catch (e) {
        return `bad JSON: ${String(e).slice(0, 80)}`;
    }
}
const gunzipStr = (b: string) => gunzipSync(Buffer.from(b, "latin1")).toString("utf8");
async function jsonComp() {
    const src = JSON.parse(readFileSync(new URL("./dataset.json", import.meta.url), "utf8"));
    const get = async (q: string, ae: string | null, method = "GET") => {
        const r = await exchange([`${method} /json/${q} HTTP/1.1\r\n${H}${ae === null ? "" : ae}Connection: close\r\n\r\n`], 1);
        return r.resps[0];
    };
    // ① validate.sh の 3 検査（50?m=1 + 乱数の count × m）
    const cases: [string, number, number][] = [["50?m=1", 50, 1]];
    for (let i = 0; i < 3; i++) {
        const c = rnd(20, 50), m = rnd(2, 97);
        cases.push([`${c}?m=${m}`, c, m]);
    }
    for (const [q, want, m] of cases) {
        const x = await get(q, "Accept-Encoding: gzip, br\r\n");
        let good = x?.status === 200 && x.headers.get("content-encoding") === "gzip" && x.headers.get("vary") === "Accept-Encoding" &&
            (x.headers.get("content-type") ?? "").startsWith("application/json");
        let detail = `got ${x?.status} ce=${x?.headers.get("content-encoding")} vary=${x?.headers.get("vary")}`;
        if (good) {
            try {
                detail = itemsOk(src, gunzipStr(x!.body), want, m);
                good = detail === "";
            } catch (e) {
                good = false;
                detail = `gunzip: ${String(e).slice(0, 80)}`;
            }
        }
        ok(`json-comp gzip ${q}`, good, detail);
        const y = await get(q, null);
        ok(`json-comp plain ${q}`, y?.status === 200 && !y.headers.has("content-encoding") && y.headers.get("vary") === "Accept-Encoding" && itemsOk(src, y.body, want, m) === "",
            `got ${y?.status} ce=${y?.headers.get("content-encoding")} vary=${y?.headers.get("vary")}`);
    }
    // ② Accept-Encoding の解釈（RFC 9110 12.5.3 — 期待 = gzip を付けるか）
    const aes: [string, boolean][] = [
        ["Accept-Encoding: gzip\r\n", true], ["Accept-Encoding: GZIP\r\n", true], ["Accept-Encoding: x-gzip\r\n", true], ["Accept-Encoding: *\r\n", true],
        ["Accept-Encoding: br\r\n", false], ["Accept-Encoding: identity\r\n", false], ["Accept-Encoding: \r\n", false], ["Accept-Encoding: gzipx, xgzip\r\n", false],
        ["Accept-Encoding: gzip;q=0\r\n", false], ["Accept-Encoding: gzip; q=0.000\r\n", false], ["Accept-Encoding: gzip;Q=0.\r\n", false],
        ["Accept-Encoding: gzip;q=0.001\r\n", true], ["Accept-Encoding: gzip;q=1\r\n", true], ["Accept-Encoding: gzip;q=x\r\n", true],
        ["Accept-Encoding: *;q=0\r\n", false], ["Accept-Encoding: gzip;q=0, *\r\n", false], ["Accept-Encoding: br;q=1, *;q=0.1\r\n", true],
        ["Accept-Encoding: deflate, gzip;q=0.5\r\n", true], ["Accept-Encoding:  br ,  gzip  ;  q=0.2 \r\n", true],
        ["Accept-Encoding: br\r\nAccept-Encoding: gzip\r\n", true], ["accept-encoding: gzip\r\n", true], ["Accept-Encodings: gzip\r\n", false],
    ];
    for (const [ae, want] of aes) {
        const x = await get("30?m=2", ae);
        const ce = x?.headers.get("content-encoding");
        let good = x?.status === 200 && (want ? ce === "gzip" : ce === undefined);
        if (good) good = itemsOk(src, want ? gunzipStr(x!.body) : x!.body, 30, 2) === "";
        ok(`json-comp ae ${JSON.stringify(ae)}`, good, `got ${x?.status} ce=${ce}`);
    }
    // ③ 閾値 1024（本文がそれ未満なら圧縮も Vary も付けない — 境目の前後の count を素の長さで判定）
    for (const c of [1, 5, 6, 7, 8]) {
        const p = await get(`${c}?m=1`, null);
        const x = await get(`${c}?m=1`, "Accept-Encoding: gzip\r\n");
        const big = (p?.body.length ?? 0) >= 1024;
        const good = p !== undefined && x !== undefined && (big ? x.headers.get("content-encoding") === "gzip" && gunzipStr(x.body) === p.body
            : !x.headers.has("content-encoding") && !x.headers.has("vary") && x.body === p.body);
        ok(`json-comp threshold ${c} (${p?.body.length} B)`, good, `ce=${x?.headers.get("content-encoding")} vary=${x?.headers.get("vary")}`);
    }
    ok("json-comp text/plain small", await (async () => {
        const r = await exchange([`GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}Accept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 1);
        const x = r.resps[0];
        return x?.body === "3" && !x.headers.has("content-encoding") && !x.headers.has("vary");
    })());
    // ④ HEAD は GET と同じ頭（Content-Length = 圧縮した長さ・本文なし）
    const g = await get("50?m=3", "Accept-Encoding: gzip\r\n");
    headOnly = true;
    const h = await get("50?m=3", "Accept-Encoding: gzip\r\n", "HEAD");
    headOnly = false;
    ok("json-comp HEAD", h?.status === 200 && h.headers.get("content-encoding") === "gzip" && h.headers.get("content-length") === String(g?.body.length) && g?.body.length! > 0,
        `head cl=${h?.headers.get("content-length")} get=${g?.body.length}`);
    // ⑤ パイプライン（1 回の書きに 3 本 — 圧縮・素・圧縮）
    const pr = await exchange([`GET /json/40?m=8 HTTP/1.1\r\n${H}Accept-Encoding: gzip, br\r\n\r\nGET /json/25?m=4 HTTP/1.1\r\n${H}\r\nGET /json/50?m=6 HTTP/1.1\r\n${H}Accept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 3);
    const [a, b, c] = pr.resps;
    let pg = a !== undefined && b !== undefined && c !== undefined && a.headers.get("content-encoding") === "gzip" && !b.headers.has("content-encoding") && c.headers.get("content-encoding") === "gzip";
    if (pg) {
        try {
            pg = itemsOk(src, gunzipStr(a.body), 40, 8) === "" && itemsOk(src, b.body, 25, 4) === "" && itemsOk(src, gunzipStr(c.body), 50, 6) === "";
        } catch {
            pg = false;
        }
    }
    ok("json-comp pipeline", pg, `n=${pr.resps.length}`);
}

// ── stream（Response の stream — report-763: Content-Length = length・本文は stream が emit したバイト列・HEAD は呼ばない・
// streamの後ろのパイプラインのリクエストも処理する）
function genBody(n: number): string {
    let s = "";
    for (let i = 0; i < n; i++) s += String.fromCharCode(97 + (i % 26));
    return s;
}
async function streamEp() {
    for (const n of [0, 1, 999, 1000, 1001, 5000, 200000]) {
        const r = await exchange([`GET /stream/${n} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
        const x = r.resps[0];
        ok(`stream ${n}`, x?.status === 200 && x.headers.get("content-length") === String(n) && x.body === genBody(n) && r.closed,
            `got ${x?.status} cl=${x?.headers.get("content-length")} len=${x?.body.length} closed=${r.closed}`);
    }
    // 圧縮しうるstream（text/plain・length ≥ 1024）: gzipを受けないリクエストにはContent-LengthのままVaryだけ・gzMin未満はVaryも無い
    // （受けるリクエストの圧縮はgzipStream — compress + streamの段階8-5）
    const g = await exchange([`GET /stream/3000 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
    ok("stream plain has Vary", g.resps[0]?.status === 200 && !g.resps[0].headers.has("content-encoding") && g.resps[0].headers.get("vary") === "Accept-Encoding" &&
        g.resps[0].headers.get("content-length") === "3000" && g.resps[0].body === genBody(3000), `ce=${g.resps[0]?.headers.get("content-encoding")} vary=${g.resps[0]?.headers.get("vary")}`);
    const g2 = await exchange([`GET /stream/1023 HTTP/1.1\r\n${H}Accept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 1);
    ok("stream below gzMin not gzipped", g2.resps[0]?.status === 200 && !g2.resps[0].headers.has("content-encoding") && !g2.resps[0].headers.has("vary") &&
        g2.resps[0].headers.get("content-length") === "1023" && g2.resps[0].body === genBody(1023), `ce=${g2.resps[0]?.headers.get("content-encoding")}`);
    // HEAD: 頭だけ（Content-Length は GET と同じ）
    headOnly = true;
    const h = await exchange([`HEAD /stream/777 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
    headOnly = false;
    ok("stream HEAD", h.resps[0]?.status === 200 && h.resps[0].headers.get("content-length") === "777" && h.raw.length === h.raw.indexOf("\r\n\r\n") + 4,
        `raw=${h.raw.length}`);
    // パイプライン: streamの前後のリクエスト（同じ切片）
    const p = await exchange([`GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}\r\nGET /stream/2500 HTTP/1.1\r\n${H}\r\nGET /stream/7 HTTP/1.1\r\n${H}\r\nGET /baseline11?a=3&b=4 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 4);
    ok("stream pipeline", p.resps.length === 4 && p.resps[0].body === "3" && p.resps[1].body === genBody(2500) && p.resps[2].body === genBody(7) && p.resps[3].body === "7",
        `n=${p.resps.length}`);
    // keep-alive: 同じ接続で stream を 2 回（間隔あり — 別の切片）
    const k = await exchange([`GET /stream/1500 HTTP/1.1\r\n${H}\r\n`, `GET /stream/10 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 2, 50);
    ok("stream keep-alive", k.resps.length === 2 && k.resps[0].body === genBody(1500) && k.resps[1].body === genBody(10), `n=${k.resps.length}`);
    // /file: dataset のバイト列そのもの（stream の中で開く — io.Chunks の切片）
    const src = readFileSync(new URL("./dataset.json", import.meta.url));
    const f = await exchange([`GET /file HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
    ok("stream file", f.resps[0]?.status === 200 && f.resps[0].headers.get("content-length") === String(src.length) && f.resps[0].body === src.toString("latin1"),
        `cl=${f.resps[0]?.headers.get("content-length")} want=${src.length}`);
}

// ── chunked（長さ不定のstream — タスク8の段階8-2・language.md 28 節w2の「レスポンスの枠」: Transfer-Encoding: chunked・emit 1回 = chunk 1つ・空のemitは送らない・
// 終端 0 CRLF CRLF・HEAD は頭だけ・HTTP/1.0 は閉じで区切る・途中の誤りは終端なしで閉じる。受け手 = 手組みの読み・undici〔fetch〕・node:http・curl）
function splits(n: number, k: number): number[] {
    const out: number[] = [];
    for (let i = 0; i < n; i += k) out.push(Math.min(k, n - i));
    return out;
}
async function chunkedEp() {
    const isChunked = (x: Resp | undefined) => x?.headers.get("transfer-encoding") === "chunked" && !x.headers.has("content-length");
    for (const n of [0, 1, 999, 1000, 1001, 5000, 200000]) {
        const r = await exchange([`GET /chunked/${n} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
        const x = r.resps[0];
        ok(`chunked ${n}`, x?.status === 200 && isChunked(x) && x.body === genBody(n) && JSON.stringify(x.chunks) === JSON.stringify(splits(n, 1000)) && r.closed,
            `got ${x?.status} te=${x?.headers.get("transfer-encoding")} cl=${x?.headers.get("content-length")} len=${x?.body.length} chunks=${x?.chunks?.length} closed=${r.closed}`);
    }
    // 空の emit は chunk にならない（長さ 0 の chunk は終端 — 挟むと後ろが切れる）
    const e = (await exchange([`GET /chunked/3500?e=1 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("chunked empty emits", isChunked(e) && e?.body === genBody(3500) && JSON.stringify(e?.chunks) === JSON.stringify(splits(3500, 1000)), `chunks=${JSON.stringify(e?.chunks)}`);
    // 1 バイトずつ（chunk の長さの 16 進 1 桁）・大きい chunk（16 進の多桁 — 0x10000 ちょうどと前後）
    const one1 = (await exchange([`GET /chunked/50?k=1 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("chunked k=1", one1?.body === genBody(50) && one1?.chunks?.length === 50, `chunks=${one1?.chunks?.length}`);
    for (const k of [15, 16, 255, 256, 65535, 65536, 65537]) {
        const x = (await exchange([`GET /chunked/${k + 3}?k=${k} HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1)).resps[0];
        ok(`chunked hex ${k}`, x?.body === genBody(k + 3) && JSON.stringify(x?.chunks) === JSON.stringify(splits(k + 3, k)), `chunks=${JSON.stringify(x?.chunks)}`);
    }
    // HEAD: 頭だけ（Transfer-Encoding: chunked・Content-Length なし・本文も終端も無い）
    headOnly = true;
    const h = await exchange([`HEAD /chunked/777 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
    headOnly = false;
    ok("chunked HEAD", h.resps[0]?.status === 200 && isChunked(h.resps[0]) && h.raw.length === h.raw.indexOf("\r\n\r\n") + 4, `raw=${h.raw.length}`);
    // パイプライン: chunkedの前後のリクエスト（同じ切片）・長さ0のchunked・長さ既知のstreamと混ぜる
    const p = await exchange([`GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}\r\nGET /chunked/2500 HTTP/1.1\r\n${H}\r\nGET /stream/7 HTTP/1.1\r\n${H}\r\nGET /chunked/0 HTTP/1.1\r\n${H}\r\nGET /baseline11?a=3&b=4 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 5);
    ok("chunked pipeline", p.resps.length === 5 && p.resps[0].body === "3" && p.resps[1].body === genBody(2500) && isChunked(p.resps[1]) && p.resps[2].body === genBody(7) &&
        p.resps[3].body === "" && isChunked(p.resps[3]) && p.resps[4].body === "7", `n=${p.resps.length}`);
    // keep-alive: 同じ接続で chunked を 2 回（別の切片）— 閉じない
    const k = await exchange([`GET /chunked/1500 HTTP/1.1\r\n${H}\r\n`, `GET /chunked/10 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 2, 50);
    ok("chunked keep-alive", k.resps.length === 2 && k.resps[0].body === genBody(1500) && k.resps[1].body === genBody(10), `n=${k.resps.length}`);
    // HTTP/1.0: 閉じで区切る（Content-Length も Transfer-Encoding も無い・Connection: close・keep-alive を頼まれても閉じる）
    for (const ka of ["", "Connection: keep-alive\r\n"]) {
        const r = await exchange([`GET /chunked/3000 HTTP/1.0\r\n${H}${ka}\r\n`], 1);
        const x = r.resps[0];
        ok(`chunked HTTP/1.0 close-delimited${ka ? " (keep-alive asked)" : ""}`, x?.status === 200 && !x.headers.has("content-length") && !x.headers.has("transfer-encoding") &&
            x.headers.get("connection") === "close" && x.body === genBody(3000) && r.closed, `got ${x?.status} te=${x?.headers.get("transfer-encoding")} len=${x?.body.length} closed=${r.closed}`);
    }
    // 途中の誤り: 終端を書かずに閉じる（送れたchunkは届く・レスポンスは完結しない）
    const f = await exchange([`GET /chunked/5000?fail=2500 HTTP/1.1\r\n${H}\r\n`], 1);
    const fr = f.raw.toString("latin1");
    ok("chunked failure has no terminator", f.resps.length === 0 && f.closed && fr.includes("Transfer-Encoding: chunked") && fr.endsWith(genBody(3000).slice(2000) + "\r\n") && !fr.includes("\r\n0\r\n\r\n"),
        `closed=${f.closed} tail=${JSON.stringify(fr.slice(-12))}`);
    // emit 1 回 = 送り 1 回: "first" は stream が返る前（300 ms 待つ前）に届く
    const t0 = performance.now();
    let tFirst = -1;
    let tEnd = -1;
    await new Promise<void>((resolve) => {
        const s = net.createConnection({ port, host: "127.0.0.1" });
        let buf = "";
        const t = setTimeout(() => { s.destroy(); resolve(); }, 5000);
        s.on("data", (d) => {
            buf += d.toString("latin1");
            if (tFirst < 0 && buf.includes("first")) tFirst = performance.now() - t0;
            if (buf.endsWith("0\r\n\r\n")) { tEnd = performance.now() - t0; clearTimeout(t); s.destroy(); resolve(); }
        });
        s.on("error", () => { clearTimeout(t); resolve(); });
        s.on("connect", () => s.write(`GET /chunked-slow HTTP/1.1\r\n${H}Connection: close\r\n\r\n`));
    });
    ok("chunked emit is sent before the stream returns", tFirst >= 0 && tEnd >= 0 && tEnd - tFirst >= 200, `first=${tFirst.toFixed(0)} end=${tEnd.toFixed(0)}`);
    // 実物の受け手: undici（fetch）・node:http・curl（HTTP/1.1 = chunked・HTTP/1.0 = 閉じで区切る）
    const base = `http://127.0.0.1:${port}`;
    let fxOk = false;
    let fxWhy = "";
    try {
        const fx = await fetch(`${base}/chunked/200000?k=4096`, { signal: AbortSignal.timeout(5000) });
        const tx = await fx.text();
        fxOk = fx.status === 200 && fx.headers.get("transfer-encoding") === "chunked" && tx === genBody(200000);
        fxWhy = `status=${fx.status} te=${fx.headers.get("transfer-encoding")} len=${tx.length} ${mono()}`;
    } catch (err) {
        fxOk = false;
        fxWhy = errWhy(err);
    }
    ok("chunked undici", fxOk, fxWhy);
    let fxFail = "";
    try {
        await (await fetch(`${base}/chunked/50000?fail=20000`, { signal: AbortSignal.timeout(5000) })).text();
        fxFail = "no error";
    } catch (err) {
        fxFail = "error";
    }
    ok("chunked undici sees the cut", fxFail === "error", fxFail);
    const nh = await new Promise<{ te: string | undefined; body: string }>((resolve) => {
        http.get(`${base}/chunked/77777?k=1000&e=1`, { timeout: 5000 }, (res) => {
            let b = "";
            res.setEncoding("latin1");
            res.on("data", (d) => (b += d));
            res.on("end", () => resolve({ te: res.headers["transfer-encoding"], body: b }));
            res.on("error", () => resolve({ te: undefined, body: "" }));
            res.on("aborted", () => resolve({ te: undefined, body: "" }));
        }).on("timeout", function (this: http.ClientRequest) {
            this.destroy();
            resolve({ te: undefined, body: "" });
        }).on("error", () => resolve({ te: undefined, body: "" }));
    });
    ok("chunked node:http", nh.te === "chunked" && nh.body === genBody(77777), `te=${nh.te} len=${nh.body.length}`);
    for (const v of ["--http1.1", "--http1.0"]) {
        const c = spawnSync("curl", ["-s", "-S", "--fail", "-m", "5", v, "-o", "-", `${base}/chunked/123457?k=3000`], { encoding: "latin1", maxBuffer: 1 << 24 });
        ok(`chunked curl ${v}`, c.status === 0 && c.stdout === genBody(123457), `rc=${c.status} len=${c.stdout?.length} err=${c.stderr?.slice(0, 80)}`);
    }
    const cf = spawnSync("curl", ["-s", "-m", "5", "-o", "/dev/null", `${base}/chunked/50000?fail=20000`], { encoding: "latin1" });
    ok("chunked curl sees the cut", cf.status !== 0, `rc=${cf.status}`);
}

// ── compress + stream（段階8-5 — language.md 28 節: compression: があり・Content-Typeが圧縮向き・リクエストがgzipを受け・codedが無いstreamのレスポンス〔長さ既知なら
// length ≥ 1024〕を gzip の chunked で送る。emit 1 回 = deflate の sync flush 1 回 = chunk 1 つ — 各 chunk までの接頭辞で、そこまでの平文が復号できる〔node:zlib の
// Z_SYNC_FLUSH の読み〕・最後の chunk は最後のブロックと CRC-32 と長さ・HTTP/1.0 は閉じの区切り・長さ既知の stream の合計の検査〔不足 / 超過は終端なしで閉じる〕）
function gzOk(x: Resp | undefined): boolean {
    return x?.status === 200 && x.headers.get("content-encoding") === "gzip" && x.headers.get("vary") === "Accept-Encoding" &&
        x.headers.get("transfer-encoding") === "chunked" && !x.headers.has("content-length");
}
// prefixes は chunk ごとの接頭辞を sync flush の読みで解いた平文の長さの列（ひとつでも解けなければ null）
function prefixes(x: Resp): number[] | null {
    const body = Buffer.from(x.body, "latin1");
    const out: number[] = [];
    let at = 0;
    for (const c of x.chunks ?? []) {
        at += c;
        try {
            out.push(gunzipSync(body.subarray(0, at), { finishFlush: zc.Z_SYNC_FLUSH }).length);
        } catch {
            return null;
        }
    }
    return out;
}
function cum(xs: number[]): number[] {
    let s = 0;
    return xs.map((x) => (s += x));
}
function unzip(b: string): string {
    try {
        return gunzipSync(Buffer.from(b, "latin1")).toString("latin1");
    } catch {
        return "<bad gzip>";
    }
}
async function gzipStream() {
    const AE = "Accept-Encoding: gzip\r\n";
    // 長さ不定（/chunked/{n}）と長さ既知（/stream/{n}）: 本文は gzip・chunk = emit 1 回 + 最後の 1 つ・接頭辞ごとに emit の合計まで解ける
    for (const [path, n] of [["/chunked/0", 0], ["/chunked/1", 1], ["/chunked/1000", 1000], ["/chunked/5000", 5000], ["/chunked/200000", 200000],
        ["/stream/1024", 1024], ["/stream/3000", 3000], ["/stream/200000", 200000]] as [string, number][]) {
        const r = await exchange([`GET ${path} HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1);
        const x = r.resps[0];
        const em = splits(n, 1000);
        const want = [...cum(em), n];
        const pf = x ? prefixes(x) : null;
        ok(`gzip stream ${path}`, gzOk(x) && x!.chunks?.length === em.length + 1 && JSON.stringify(pf) === JSON.stringify(want) && unzip(x!.body) === genBody(n) && r.closed,
            `ce=${x?.headers.get("content-encoding")} te=${x?.headers.get("transfer-encoding")} chunks=${x?.chunks?.length} pf=${JSON.stringify(pf)?.slice(0, 60)} closed=${r.closed}`);
    }
    // 空の emit は chunk にならない（sync flush の空打ちを送らない）・1 バイトずつの emit
    const e = (await exchange([`GET /chunked/3500?e=1 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("gzip stream empty emits", gzOk(e) && e!.chunks?.length === 5 && unzip(e!.body) === genBody(3500), `chunks=${e?.chunks?.length}`);
    const k1 = (await exchange([`GET /chunked/40?k=1 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("gzip stream k=1", gzOk(k1) && k1!.chunks?.length === 41 && JSON.stringify(k1 ? prefixes(k1) : null) === JSON.stringify([...cum(splits(40, 1)), 40]) && unzip(k1!.body) === genBody(40),
        `chunks=${k1?.chunks?.length}`);
    // ウィンドウはemitをまたいで持ち越す: 本文は26バイトの周期 — 2つ目以降のemitは頭からウィンドウの中への一致だけで書ける（持ち越さなければ頭の26バイトは字のまま
    // ≈ 40 バイト/chunk）
    const w = (await exchange([`GET /chunked/26000?k=1000 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1)).resps[0];
    const wc = w?.chunks ?? [];
    ok("gzip stream window carries over emits", gzOk(w) && wc.length === 27 && wc.slice(1, 26).every((c) => c < 30) && unzip(w!.body) === genBody(26000),
        `chunks=${JSON.stringify(wc.slice(0, 6))}`);
    // 受けないリクエスト・圧縮向きでないContent-Type・gzMin未満の長さ既知・SSEは圧縮しない
    const nz = (await exchange([`GET /chunked/3000 HTTP/1.1\r\n${H}Accept-Encoding: br\r\nConnection: close\r\n\r\n`], 1)).resps[0];
    ok("gzip stream not accepted: plain chunked + Vary", nz?.headers.get("transfer-encoding") === "chunked" && !nz.headers.has("content-encoding") &&
        nz.headers.get("vary") === "Accept-Encoding" && nz.body === genBody(3000), `ce=${nz?.headers.get("content-encoding")}`);
    const bn = (await exchange([`GET /chunked/3000?bin=1 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("gzip stream octet-stream not gzipped", bn?.headers.get("transfer-encoding") === "chunked" && !bn.headers.has("content-encoding") && !bn.headers.has("vary") &&
        bn.body === genBody(3000), `ce=${bn?.headers.get("content-encoding")} vary=${bn?.headers.get("vary")}`);
    const sm = (await exchange([`GET /chunked/3000?len=1023&k=1023 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1));
    ok("gzip stream length < gzMin not gzipped", !sm.resps[0]?.headers.has("content-encoding") && sm.resps[0]?.headers.get("content-length") === "1023" &&
        sm.resps[0]?.body === genBody(1023) && sm.closed, `ce=${sm.resps[0]?.headers.get("content-encoding")}`);
    // HEAD: 頭は GET と同じ（gzip の chunked）・本文なし
    headOnly = true;
    const h = await exchange([`HEAD /stream/3000 HTTP/1.1\r\n${H}${AE}Connection: close\r\n\r\n`], 1);
    headOnly = false;
    ok("gzip stream HEAD", gzOk(h.resps[0]) && h.raw.length === h.raw.indexOf("\r\n\r\n") + 4, `raw=${h.raw.length}`);
    // HTTP/1.0: 閉じで区切る gzip（Content-Length も Transfer-Encoding も無い・keep-alive を頼まれても閉じる）
    for (const p of ["/chunked/3000", "/stream/3000"]) {
        const r = await exchange([`GET ${p} HTTP/1.0\r\n${H}${AE}Connection: keep-alive\r\n\r\n`], 1);
        const x = r.resps[0];
        ok(`gzip stream HTTP/1.0 ${p}`, x?.status === 200 && x.headers.get("content-encoding") === "gzip" && !x.headers.has("content-length") &&
            !x.headers.has("transfer-encoding") && x.headers.get("connection") === "close" && unzip(x.body) === genBody(3000) && r.closed,
            `te=${x?.headers.get("transfer-encoding")} closed=${r.closed}`);
    }
    // パイプライン・keep-alive: 圧縮したstreamの前後のリクエスト
    const pp = await exchange([`GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}\r\nGET /chunked/2500 HTTP/1.1\r\n${H}${AE}\r\nGET /stream/2000 HTTP/1.1\r\n${H}${AE}\r\nGET /baseline11?a=3&b=4 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 4);
    ok("gzip stream pipeline", pp.resps.length === 4 && pp.resps[0].body === "3" && gzOk(pp.resps[1]) && unzip(pp.resps[1].body) === genBody(2500) &&
        gzOk(pp.resps[2]) && unzip(pp.resps[2].body) === genBody(2000) && pp.resps[3].body === "7", `n=${pp.resps.length}`);
    // 途中の誤り: 終端も最後のブロックも書かずに閉じる（送れた chunk は解ける）
    const f = await exchange([`GET /chunked/5000?fail=2500 HTTP/1.1\r\n${H}${AE}\r\n`], 1);
    ok("gzip stream failure has no terminator", f.resps.length === 0 && f.closed && f.raw.toString("latin1").includes("Content-Encoding: gzip") && !f.raw.toString("latin1").includes("\r\n0\r\n\r\n"),
        `closed=${f.closed}`);
    // 長さ既知の合計の検査: ちょうど = 完結・不足 / 超過 = 終端なしで閉じる（超過の emit は送らない — 解ける平文は length まで）
    const lx = await exchange([`GET /chunked/3000?len=3000 HTTP/1.1\r\n${H}${AE}\r\n`, `GET /baseline11?a=1&b=1 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 2, 100);
    ok("gzip stream length exact", lx.resps.length === 2 && gzOk(lx.resps[0]) && unzip(lx.resps[0].body) === genBody(3000) && lx.resps[1].body === "2", `n=${lx.resps.length}`);
    for (const [ln, keep] of [[4000, 3000], [2000, 2000], [2500, 2000]]) {
        const r = await exchange([`GET /chunked/3000?len=${ln} HTTP/1.1\r\n${H}${AE}\r\n`, `GET /baseline11?a=1&b=1 HTTP/1.1\r\n${H}\r\n`], 2, 100);
        const raw = r.raw.toString("latin1");
        const he = raw.indexOf("\r\n\r\n");
        const parts: Buffer[] = [];
        let q = he + 4;
        for (;;) {
            const le = raw.indexOf("\r\n", q);
            if (le < 0) break;
            const size = parseInt(raw.slice(q, le), 16);
            if (!(size > 0) || le + 2 + size > raw.length) break;
            parts.push(Buffer.from(raw.slice(le + 2, le + 2 + size), "latin1"));
            q = le + 2 + size + 2;
        }
        let plain = "";
        try {
            plain = gunzipSync(Buffer.concat(parts), { finishFlush: zc.Z_SYNC_FLUSH }).toString("latin1");
        } catch {
            plain = "<bad>";
        }
        ok(`gzip stream length ${ln} vs 3000 closes without terminator`, r.resps.length === 0 && r.closed && !raw.includes("\r\n0\r\n\r\n") && plain === genBody(keep),
            `n=${r.resps.length} closed=${r.closed} plain=${plain.length}`);
    }
    // 圧縮しない長さ既知の stream の合計の検査（Content-Length の枠 — 超過の emit は送らず・不足 / 超過とも閉じる）
    for (const [ln, keep] of [[4000, 3000], [2000, 2000], [2500, 2000]]) {
        const r = await exchange([`GET /chunked/3000?len=${ln} HTTP/1.1\r\n${H}\r\n`, `GET /baseline11?a=1&b=1 HTTP/1.1\r\n${H}\r\n`], 2, 100);
        const raw = r.raw.toString("latin1");
        const he = raw.indexOf("\r\n\r\n");
        ok(`stream length ${ln} vs 3000 closes`, r.closed && raw.includes(`Content-Length: ${ln}\r\n`) && raw.slice(he + 4) === genBody(keep),
            `closed=${r.closed} body=${raw.length - he - 4}`);
    }
    // 実物の受け手: undici（fetch は gzip を頼んで解く）・node:http + createGunzip・curl --compressed（HTTP/1.1 = chunked・HTTP/1.0 = 閉じの区切り）
    const base = `http://127.0.0.1:${port}`;
    let fz = "";
    try {
        const fx = await fetch(`${base}/chunked/200000?k=4096`, { signal: AbortSignal.timeout(5000) });
        const zt = (await fx.text()) === genBody(200000);
        fz = `${fx.headers.get("content-encoding")} ${zt}`;
        if (!zt) fz += ` ${mono()}`;
    } catch (err) {
        fz = `error ${errWhy(err)}`;
    }
    ok("gzip stream undici", fz === "gzip true", fz);
    const nh = await new Promise<string>((resolve) => {
        http.get(`${base}/stream/77777`, { timeout: 5000, headers: { "Accept-Encoding": "gzip" } }, (res) => {
            const parts: Buffer[] = [];
            const z = res.pipe(createGunzip());
            z.on("data", (d: Buffer) => parts.push(d));
            z.on("end", () => resolve(`${res.headers["content-encoding"]} ${Buffer.concat(parts).toString("latin1") === genBody(77777)}`));
            z.on("error", () => resolve("gunzip error"));
        }).on("timeout", function (this: http.ClientRequest) {
            this.destroy();
            resolve("timeout");
        }).on("error", () => resolve("error"));
    });
    ok("gzip stream node:http", nh === "gzip true", nh);
    for (const v of ["--http1.1", "--http1.0"]) {
        const c = spawnSync("curl", ["-s", "-S", "--fail", "--compressed", "-m", "5", v, "-o", "-", `${base}/chunked/123457?k=3000`], { encoding: "latin1", maxBuffer: 1 << 24 });
        ok(`gzip stream curl ${v}`, c.status === 0 && c.stdout === genBody(123457), `rc=${c.status} len=${c.stdout?.length} err=${c.stderr?.slice(0, 80)}`);
    }
}

// ── SSE（GET /sse?n= — text/event-streamのstream・Last-Event-IDの次から・1つ目の後に300 ms・retry: 100の終わりのイベント / GET /sse-body — タスク8の段階8-3）
function sseEv(i: number): string {
    return `event: tick\nid: ${i}\ndata: n=${i}\ndata: sq=${i * i}\n\n`;
}
const sseEnd = "event: end\nretry: 100\ndata: \n\n";

async function sseEp() {
    // 頭（chunked・no-store・Accept-Encoding: gzip でも圧縮しない — Content-Encoding も Vary も無い）と本文（イベント 1 つ = chunk 1 つ）
    const r = await exchange([`GET /sse HTTP/1.1\r\n${H}Accept: text/event-stream\r\nAccept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 1);
    const x = r.resps[0];
    const want = sseEv(1) + sseEv(2) + sseEnd;
    ok("sse head", x?.status === 200 && x.headers.get("content-type") === "text/event-stream" && x.headers.get("transfer-encoding") === "chunked" &&
        !x.headers.has("content-length") && x.headers.get("cache-control") === "no-store" && !x.headers.has("content-encoding") && !x.headers.has("vary"),
        `got ${x?.status} ${JSON.stringify(x ? [...x.headers] : [])}`);
    ok("sse body", x?.body === want && JSON.stringify(x?.chunks) === JSON.stringify([sseEv(1).length, sseEv(2).length, sseEnd.length]),
        `body=${JSON.stringify(x?.body)} chunks=${JSON.stringify(x?.chunks)}`);
    // Last-Event-ID の次から
    const l = (await exchange([`GET /sse?n=3 HTTP/1.1\r\n${H}Last-Event-ID: 41\r\nConnection: close\r\n\r\n`], 1)).resps[0];
    ok("sse Last-Event-ID", l?.body === sseEv(42) + sseEv(43) + sseEv(44) + sseEnd, `body=${JSON.stringify(l?.body)}`);
    // 1 つ目のイベントは stream が返る前（300 ms 待つ前）に届く
    const t0 = performance.now();
    let tFirst = -1;
    let tEnd = -1;
    await new Promise<void>((resolve) => {
        const s = net.createConnection({ port, host: "127.0.0.1" });
        let buf = "";
        const t = setTimeout(() => { s.destroy(); resolve(); }, 5000);
        s.on("data", (d) => {
            buf += d.toString("latin1");
            if (tFirst < 0 && buf.includes("data: sq=1\n\n")) tFirst = performance.now() - t0;
            if (buf.endsWith("0\r\n\r\n")) { tEnd = performance.now() - t0; clearTimeout(t); s.destroy(); resolve(); }
        });
        s.on("error", () => { clearTimeout(t); resolve(); });
        s.on("connect", () => s.write(`GET /sse HTTP/1.1\r\n${H}Connection: close\r\n\r\n`));
    });
    ok("sse first event arrives before the stream returns", tFirst >= 0 && tEnd >= 0 && tEnd - tFirst >= 200, `first=${tFirst.toFixed(0)} end=${tEnd.toFixed(0)}`);
    // text/event-streamのbodyのレスポンスもcompression: の対象外（gzMin以上・gzipを受けるリクエストでも）
    const b = (await exchange([`GET /sse-body HTTP/1.1\r\n${H}Accept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 1)).resps[0];
    ok("sse body response not compressed", b?.status === 200 && !b.headers.has("content-encoding") && !b.headers.has("vary") && (b.body.length ?? 0) >= 2000 && b.body.startsWith(": pad\n\n"),
        `ce=${b?.headers.get("content-encoding")} vary=${b?.headers.get("vary")} len=${b?.body.length}`);
    // 実物の受け手: EventSource（undici — node --experimental-eventsource）。tick の data の 2 行は LF で繋がる・lastEventId・event の種類・
    // 流れが終わると retry: 100 の後に Last-Event-ID: 2 で繋ぎ直して id 3 から受ける
    const ES = (globalThis as any).EventSource;
    if (!ES) {
        ok("sse EventSource available", false, "run node with --experimental-eventsource");
        return;
    }
    // 繋ぎ直しの error（流れの終わり — 正常）も数えるので、比較の列でなく詳細にだけ載せる
    const esErr: string[] = [];
    const got = await new Promise<string[]>((resolve) => {
        const seen: string[] = [];
        const es = new ES(`http://127.0.0.1:${port}/sse`);
        const t = setTimeout(() => { es.close(); resolve(seen); }, 5000);
        es.addEventListener("error", (e: any) => esErr.push(`${e?.message ?? "error"} ${mono()}`));
        es.addEventListener("tick", (e: any) => {
            seen.push(`${e.lastEventId}:${e.data}`);
            if (e.lastEventId === "3") { clearTimeout(t); es.close(); resolve(seen); }
        });
        es.addEventListener("end", (e: any) => seen.push(`end:${JSON.stringify(e.data)}`));
    });
    ok("sse EventSource", JSON.stringify(got) === JSON.stringify(["1:n=1\nsq=1", "2:n=2\nsq=4", 'end:""', "3:n=3\nsq=9"]), `${JSON.stringify(got)} errors=${JSON.stringify(esErr)} ${mono()}`);
}

// ── echo（POST /echo — HttpArena の 8gbit の端点〔validate.sh の 8gbit の節〕。乱数の本文を byte 一致で: Content-Length と chunked〔乱数の切り方・
// 16進の大小・chunk-ext・trailer〕・乱数の位置で断片化した送り・パイプライン。本文はレスポンスのContent-Type = application/octet-streamで返る。report-848）
// chunkedOf は body を乱数の大きさの chunk に切った chunked の本文（終わりの 0 の chunk・時々 chunk-ext と trailer）
function chunkedOf(body: Buffer, maxChunk: number): Buffer {
    const parts: Buffer[] = [];
    let p = 0;
    while (p < body.length) {
        const n = Math.min(body.length - p, rnd(1, maxChunk));
        const hex = n.toString(16);
        const sz = Math.random() < 0.5 ? hex : hex.toUpperCase();
        const ext = Math.random() < 0.1 ? ";x=y" : "";
        parts.push(Buffer.from(`${sz}${ext}\r\n`, "latin1"), body.subarray(p, p + n), Buffer.from("\r\n", "latin1"));
        p += n;
    }
    parts.push(Buffer.from(Math.random() < 0.2 ? "0\r\nX-T: 1\r\n\r\n" : "0\r\n\r\n", "latin1"));
    return Buffer.concat(parts);
}

// echoReqはbodyを送るPOST /echoのリクエスト（chunkedならchunkedOf・そうでなければContent-Length）
function echoReq(body: Buffer, chunked: boolean, maxChunk: number, close = true): Buffer {
    const conn = close ? "Connection: close\r\n" : "";
    const head = chunked
        ? `POST /echo HTTP/1.1\r\n${H}Content-Type: application/octet-stream\r\nTransfer-Encoding: chunked\r\n${conn}\r\n`
        : `POST /echo HTTP/1.1\r\n${H}Content-Type: application/octet-stream\r\nContent-Length: ${body.length}\r\n${conn}\r\n`;
    return Buffer.concat([Buffer.from(head, "latin1"), chunked ? chunkedOf(body, maxChunk) : body]);
}

// cuts は buf を k 個の乱数の位置で切った列（断片化の送り）
function cuts(buf: Buffer, k: number): Buffer[] {
    const at = [...new Set(Array.from({ length: k }, () => rnd(1, buf.length - 1)))].sort((a, b) => a - b);
    const out: Buffer[] = [];
    let p = 0;
    for (const q of at) {
        out.push(buf.subarray(p, q));
        p = q;
    }
    out.push(buf.subarray(p));
    return out;
}

function echoOk(name: string, x: Resp | undefined, body: Buffer) {
    ok(name, x?.status === 200 && x.headers.get("content-type") === "application/octet-stream" && x.headers.get("content-length") === String(body.length) &&
        x.body === body.toString("latin1"), `got ${x?.status} ct=${x?.headers.get("content-type")} len=${x?.body.length} want=${body.length}`);
}

async function echoEp(sizes: number[], timeout: number) {
    for (const n of sizes) {
        const b = randomBytes(n);
        echoOk(`echo cl ${n}`, (await exchange([echoReq(b, false, 0)], 1, 20, timeout)).resps[0], b);
        if (n > 0) {
            for (const mc of [1 + (n >> 6), 4096]) {
                const c = randomBytes(n);
                echoOk(`echo chunked ${n} (chunks ≤ ${mc})`, (await exchange([echoReq(c, true, mc)], 1, 20, timeout)).resps[0], c);
            }
            const f = randomBytes(n);
            const req = echoReq(f, true, 1 + (n >> 4));
            echoOk(`echo chunked ${n} fragmented`, (await exchange(cuts(req, Math.min(12, req.length - 1)), 1, 5, timeout)).resps[0], f);
        }
    }
    // 空の chunked = 200 の空（411 でも待ちでもない — validate.sh の empty body）
    echoOk("echo chunked empty", (await exchange([echoReq(Buffer.alloc(0), true, 1)], 1)).resps[0], Buffer.alloc(0));
}

// echoPipeは同じ切片にCLとchunkedのechoを並べた列（レスポンスの順と本文の境界）
async function echoPipe() {
    const bs = [randomBytes(700), randomBytes(3000), randomBytes(1), randomBytes(5000)];
    const reqs = bs.map((b, i) => echoReq(b, i % 2 === 1, 512, i === bs.length - 1));
    const r = await exchange([Buffer.concat(reqs)], bs.length);
    bs.forEach((b, i) => echoOk(`echo pipeline ${i}`, r.resps[i], b));
}

const t = performance.now();
// ── upload（POST /upload — http.Multipart。node の FormData〔undici — WHATWG の符号化の実物〕・Chrome / Firefox の境界の形を手で組んだ本文・
// chunked と断片化で送る・壊れた本文は 400。srv は部分ごとに name TAB filename〔無ければ -〕TAB Content-Type TAB 長さ TAB 和 の行を返す — report-1022）
type UpPart = { name: string; filename: string | null; ctype: string; body: Buffer };
function upLine(p: UpPart): string {
    let sum = 0;
    for (let i = 0; i < p.body.length; i++) sum = (sum + p.body[i] * (i + 1)) % 1000000007;
    return `${p.name}\t${p.filename ?? "-"}\t${p.ctype}\t${p.body.length}\t${sum}\n`;
}
function upReq(ct: string, body: Buffer, chunked = false): Buffer {
    const te = chunked ? "Transfer-Encoding: chunked\r\n" : `Content-Length: ${body.length}\r\n`;
    const head = Buffer.from(`POST /upload HTTP/1.1\r\n${H}Content-Type: ${ct}\r\n${te}Connection: close\r\n\r\n`, "latin1");
    return Buffer.concat([head, chunked ? chunkedOf(body, 97) : body]);
}
// mpBodyは境界bdの本文（partsの各頭は手で書いた行 — ブラウザの形をコピーする）
function mpBody(bd: string, parts: { head: string; body: Buffer }[]): Buffer {
    const xs: Buffer[] = [];
    for (const p of parts) xs.push(Buffer.from(`--${bd}\r\n${p.head}\r\n`, "utf8"), p.body, Buffer.from("\r\n"));
    xs.push(Buffer.from(`--${bd}--\r\n`));
    return Buffer.concat(xs);
}
async function uploadEp() {
    // node の FormData（undici）: テキスト・日本語・'"' の入った名前（%22 — 生のまま返る）・ファイル（乱数のバイト列）・名前の空のファイル
    const bin = randomBytes(4000);
    const fd = new FormData();
    fd.append("title", "hello");
    fd.append("名前", "こんにちは");
    fd.append('q"x', "v");
    fd.append("file", new Blob([bin], { type: "application/octet-stream" }), 'a"b.bin');
    fd.append("empty", new Blob([], { type: "application/octet-stream" }), "");
    const rq = new Request("http://localhost/", { method: "POST", body: fd });
    const ub = Buffer.from(await rq.arrayBuffer());
    const uct = rq.headers.get("content-type") ?? "";
    const want = [
        { name: "title", filename: null, ctype: "", body: Buffer.from("hello") },
        { name: "名前", filename: null, ctype: "", body: Buffer.from("こんにちは") },
        { name: "q%22x", filename: null, ctype: "", body: Buffer.from("v") },
        { name: "file", filename: "a%22b.bin", ctype: "application/octet-stream", body: bin },
        // undici は名前の空のファイルに filename を書かない（ブラウザは filename="" — 下の Chrome の形で見る）
        { name: "empty", filename: null, ctype: "application/octet-stream", body: Buffer.alloc(0) },
    ].map(upLine).join("");
    // レスポンスの本文はlatin1で読まれる（parseAll）— 期待もUTF-8のバイト列をlatin1で
    const wantL = Buffer.from(want, "utf8").toString("latin1");
    await one("upload formdata", upReq(uct, ub), 200, wantL);
    await one("upload formdata chunked", upReq(uct, ub, true), 200, wantL);
    const fr = await exchange(cuts(upReq(uct, ub, true), 12), 1, 5);
    ok("upload formdata fragmented", fr.resps[0]?.status === 200 && fr.resps[0]?.body === wantL, `got ${fr.resps[0]?.status}`);
    // Chrome（WebKitFormBoundary）と Firefox（geckoformboundary / 旧形）の形
    for (const bd of ["----WebKitFormBoundaryq8rB2KfUu3XzLd9M", "----geckoformboundary4f1c9a0b7e2d6c3a5b8e1f0d2c4a6b9e", "---------------------------9051914041544843365972754266"]) {
        const f = randomBytes(1500);
        const ps: UpPart[] = [
            { name: "text", filename: null, ctype: "", body: Buffer.from("text default") },
            { name: "file1", filename: "a.txt", ctype: "text/plain", body: Buffer.from("--\r\n--" + bd.slice(1) + "\r\n") },
            { name: "file2", filename: "x.bin", ctype: "application/octet-stream", body: f },
            { name: "none", filename: "", ctype: "application/octet-stream", body: Buffer.alloc(0) },
        ];
        const body = mpBody(bd, ps.map((p) => ({ head: `Content-Disposition: form-data; name="${p.name}"${p.filename === null ? "" : `; filename="${p.filename}"`}\r\n${p.ctype ? `Content-Type: ${p.ctype}\r\n` : ""}`, body: p.body })));
        await one(`upload ${bd.slice(0, 16)}`, upReq(`multipart/form-data; boundary=${bd}`, body), 200, ps.map(upLine).join(""));
    }
    // 壊れた本文は 400（閉じの境界なし・boundary なし・媒体の型が違う・境界が本文に出る・LF だけの行）
    const good = mpBody("x", [{ head: 'Content-Disposition: form-data; name="a"\r\n', body: Buffer.from("v") }]);
    await one("upload no close 400", upReq("multipart/form-data; boundary=x", good.subarray(0, good.length - 8)), 400, null);
    await one("upload no boundary 400", upReq("multipart/form-data", good), 400, null);
    await one("upload not multipart 400", upReq("application/x-www-form-urlencoded", good), 400, null);
    await one("upload boundary in body 400", upReq("multipart/form-data; boundary=x", Buffer.from('--x\r\nContent-Disposition: form-data; name="a"\r\n\r\nv\r\n--xy\r\n--x--\r\n')), 400, null);
    await one("upload bare LF 400", upReq("multipart/form-data; boundary=x", Buffer.from('--x\nContent-Disposition: form-data; name="a"\n\nv\n--x--\n')), 400, null);
    await one("upload no content-type 400", Buffer.from(`POST /upload HTTP/1.1\r\n${H}Content-Length: ${good.length}\r\nConnection: close\r\n\r\n${good.toString("latin1")}`, "latin1"), 400, null);
    await one("upload GET 405", `GET /upload HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 405, null);
}

// 分割受信の接続の常駐（--rss-pid <srvのpid> — echo-bigの構成で）: リクエストの頭を2回に割って送った接続をn本開いたまま、srvのVmRSSの増えを
// 割らない接続n本の増えと比べる。持ち越しの列は未完のリクエストの長さだけ取る約束（maxHead + 2 × maxBodyの一括確保なら1本 ≈ 270 KB増える）
const rssPid = process.argv.includes("--rss-pid") ? Number(process.argv[process.argv.indexOf("--rss-pid") + 1]) : 0;
async function splitRss(pid: number, n: number) {
    const rss = () => Number(/VmRSS:\s+(\d+)/.exec(readFileSync(`/proc/${pid}/status`, "utf8"))![1]);
    const req = `GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}X-Pad: ${"p".repeat(200)}\r\n\r\n`;
    const cut = 40;
    const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
    async function batch(split: boolean): Promise<{ kb: number; good: number; socks: net.Socket[] }> {
        const r0 = rss();
        const socks: net.Socket[] = [];
        const done = Array.from({ length: n }, () => {
            const s = dial();
            socks.push(s);
            return new Promise<boolean>((res) => {
                let got = "";
                s.on("data", (d) => {
                    got += d.toString("latin1");
                    if (got.includes("\r\n\r\n3")) res(true);
                });
                s.on("error", () => res(false));
                s.on("close", () => res(false));
                s.on(CONNECT, () => {
                    if (!split) s.write(req);
                    else {
                        s.write(req.slice(0, cut));
                        setTimeout(() => s.write(req.slice(cut)), 50);
                    }
                });
            });
        });
        const good = (await Promise.all(done)).filter((x) => x).length;
        await sleep(100);
        return { kb: rss() - r0, good, socks };
    }
    const whole = await batch(false);
    const split = await batch(true);
    for (const s of [...whole.socks, ...split.socks]) s.destroy();
    await sleep(200);
    ok(`split-receive ${n} conns resident`, whole.good === n && split.good === n && split.kb - whole.kb < n * 32,
        `whole +${whole.kb} KB split +${split.kb} KB good=${whole.good}/${split.good}`);
}

if (echoBig) {
    // 8gbit の validate の大きさ（1 / 1 KB / 10 KB / 100 KB・chunked 10 KB / 100 KB）+ 上限ちょうど（128 KiB）
    await echoEp([1, 1024, 10240, 102400, 131072], 30000);
    if (rssPid) await splitRss(rssPid, 200);
    // 上限を超えたら413（頭だけ送る — 本文を送り切ると lingering close の上限〔64 KiB〕の後のRSTでレスポンスが落ちうる。既存の「CL > 16 KiB」と同じ形）
    for (const n of [131073, 1048576]) {
        await one(`echo CL ${n} 413`, `POST /echo HTTP/1.1\r\n${H}Content-Length: ${n}\r\n\r\n`, 413, null);
        await one(`echo chunked ${n} 413`, `POST /echo HTTP/1.1\r\n${H}Transfer-Encoding: chunked\r\n\r\n${n.toString(16)}\r\n`, 413, null);
    }
    console.log(`check: ${pass} passed, ${fail} failed (echo-big) in ${((performance.now() - t) / 1000).toFixed(1)} s`);
    for (const f of fails.slice(0, 30)) console.log("  FAIL " + f);
    process.exit(fail ? 1 : 0);
}
// ── static（http.Static — report-956: GET /static/*path を STATIC_ROOT〔= --static の dir — ここで中身を作る〕の下から・precompressed・根の外は 404・
// 毎リクエストディスクを読む〔キャッシュなし〕・compression: の外）
async function staticEp() {
    if (!staticDir) return;
    const big = randomBytes(200000);
    const js = "function f(){return 1}\n".repeat(80);
    const css = "body{margin:0}\n".repeat(200);
    mkdirSync(`${staticDir}/www/sub`, { recursive: true });
    writeFileSync(`${staticDir}/www/big.bin`, big);
    writeFileSync(`${staticDir}/www/app.js`, js);
    writeFileSync(`${staticDir}/www/app.js.gz`, gzipSync(Buffer.from(js)));
    writeFileSync(`${staticDir}/www/app.js.br`, Buffer.from("[pretend br bytes]"));
    writeFileSync(`${staticDir}/www/style.css`, css);
    writeFileSync(`${staticDir}/www/index.html`, "<p>hi</p>");
    writeFileSync(`${staticDir}/www/.hidden`, "dot");
    writeFileSync(`${staticDir}/www/sub/x.txt`, "x");
    writeFileSync(`${staticDir}/outside.txt`, "secret");
    symlinkSync("../outside.txt", `${staticDir}/www/esc`);
    symlinkSync("sub/x.txt", `${staticDir}/www/in`);
    const get = async (path: string, extra = "", method = "GET") => (await exchange([`${method} ${path} HTTP/1.1\r\n${H}${extra}Connection: close\r\n\r\n`], 1)).resps[0];
    const b = await get("/static/big.bin");
    ok("static big", b?.status === 200 && b.headers.get("content-length") === "200000" && b.body === big.toString("latin1") &&
        b.headers.get("content-type") === "application/octet-stream" && b.headers.get("vary") === "Accept-Encoding" && !b.headers.has("content-encoding"), `status=${b?.status}`);
    const c = await get("/static/style.css", "Accept-Encoding: gzip\r\n");
    ok("static css not compressed", c?.status === 200 && c.body === css && !c.headers.has("content-encoding") && c.headers.get("content-type") === "text/css; charset=utf-8", `ce=${c?.headers.get("content-encoding")}`);
    const pick = async (name: string, ae: string, want: string, enc: string | null) => {
        const x = await get("/static/app.js", ae ? `Accept-Encoding: ${ae}\r\n` : "");
        ok(`static precompressed ${name}`, x?.status === 200 && x.body === want && (x.headers.get("content-encoding") ?? null) === enc &&
            x.headers.get("vary") === "Accept-Encoding" && x.headers.get("content-type") === "text/javascript; charset=utf-8", `ce=${x?.headers.get("content-encoding")} len=${x?.body.length}`);
    };
    const gz = readFileSync(`${staticDir}/www/app.js.gz`).toString("latin1");
    await pick("br", "gzip, br", "[pretend br bytes]", "br");
    await pick("gzip", "gzip", gz, "gzip");
    await pick("br q=0", "br;q=0, gzip", gz, "gzip");
    await pick("none", "", js, null);
    await pick("all q=0", "br;q=0, gzip;q=0", js, null);
    await pick("star", "*", "[pretend br bytes]", "br");
    ok("static gz roundtrip", gunzipSync(Buffer.from(gz, "latin1")).toString() === js);
    headOnly = true;
    const h = await get("/static/big.bin", "", "HEAD");
    headOnly = false;
    ok("static HEAD", h?.status === 200 && h.headers.get("content-length") === "200000", `status=${h?.status}`);
    const i = await get("/static/index.html");
    ok("static html", i?.status === 200 && i.body === "<p>hi</p>" && i.headers.get("content-type") === "text/html; charset=utf-8");
    for (const [p, want] of [["/static/.hidden", 200], ["/static/in", 200], ["/static/sub/x.txt", 200], ["/static/", 404], ["/static/nope", 404],
        ["/static/../outside.txt", 404], ["/static/sub/../../outside.txt", 404], ["/static/esc", 404], ["/static/sub", 404], ["/static//etc/passwd", 404],
        ["/static/%2e%2e/outside.txt", 404], ["/static/sub/../index.html", 200]] as [string, number][]) {
        const x = await get(p);
        ok(`static ${p} ${want}`, x?.status === want, `status=${x?.status}`);
    }
    const post = await get("/static/index.html", "Content-Length: 0\r\n", "POST");
    ok("static POST 405", post?.status === 405 && post.headers.get("allow") === "GET, HEAD", `status=${post?.status}`);
    // ディスクに追従（キャッシュしない）
    writeFileSync(`${staticDir}/www/live.txt`, "one");
    const l1 = await get("/static/live.txt");
    writeFileSync(`${staticDir}/www/live.txt`, "second version");
    const l2 = await get("/static/live.txt");
    ok("static follows disk", l1?.body === "one" && l2?.body === "second version", `${l1?.body} / ${l2?.body}`);
    // 条件付き GET（report-961 / 962）: 弱い ETag = W/"<mtime ns の 16 進>-<大きさの 16 進>[-br|-gz]"・Last-Modified・Cache-Control（srv は cache: 省略 = no-cache）・
    // 304 は ETag・Cache-Control・Vary だけ（Content-Length・Content-Type・Content-Encoding・本文なし）・If-Modified-Since はちょうどの一致だけ・If-Match が偽なら 412
    const T = 1700000000;
    const imf = (sec: number) => new Date(sec * 1000).toUTCString();
    const tagOf = (file: string, sfx = "") => {
        const st = statSync(`${staticDir}/www/${file}`, { bigint: true });
        return `W/"${st.mtimeNs.toString(16)}-${st.size.toString(16)}${sfx}"`;
    };
    for (const [f, t] of [["index.html", T], ["app.js", T + 1], ["app.js.gz", T + 2], ["app.js.br", T + 3], ["big.bin", T]] as [string, number][]) {
        utimesSync(`${staticDir}/www/${f}`, t, t);
    }
    const ix = tagOf("index.html");
    const c0 = await get("/static/index.html");
    ok("static etag 200", c0?.status === 200 && c0.headers.get("etag") === ix && c0.headers.get("last-modified") === imf(T) &&
        c0.headers.get("cache-control") === "no-cache", `etag=${c0?.headers.get("etag")} lm=${c0?.headers.get("last-modified")} cc=${c0?.headers.get("cache-control")}`);
    const is304 = (x: Resp | undefined, tag: string) => x?.status === 304 && x.headers.get("etag") === tag && x.headers.get("cache-control") === "no-cache" &&
        x.headers.get("vary") === "Accept-Encoding" && !x.headers.has("content-length") && !x.headers.has("content-type") && !x.headers.has("content-encoding") &&
        !x.headers.has("last-modified") && x.body === "";
    const show = (x: Resp | undefined) => `status=${x?.status} h=${JSON.stringify([...(x?.headers ?? new Map())])}`;
    const n1 = await get("/static/index.html", `If-None-Match: ${ix}\r\n`);
    ok("static 304 if-none-match", is304(n1, ix), show(n1));
    const n2 = await get("/static/index.html", `If-None-Match: "a", W/"b", ${ix.slice(2)}\r\n`);
    ok("static 304 if-none-match list weak", is304(n2, ix), show(n2));
    const n3 = await get("/static/index.html", `If-None-Match: *\r\n`);
    ok("static 304 if-none-match star", is304(n3, ix), show(n3));
    const n4 = await get("/static/index.html", `If-None-Match: W/"nope"\r\nIf-Modified-Since: ${imf(T)}\r\n`);
    ok("static if-none-match wins over ims", n4?.status === 200 && n4.body === "<p>hi</p>", show(n4));
    const m1 = await get("/static/index.html", `If-Modified-Since: ${imf(T)}\r\n`);
    ok("static 304 ims exact", is304(m1, ix), show(m1));
    const m2 = await get("/static/index.html", `If-Modified-Since: ${imf(T + 60)}\r\n`);
    ok("static ims later is 200 (exact)", m2?.status === 200 && m2.body === "<p>hi</p>", show(m2));
    const m3 = await get("/static/index.html", `If-Modified-Since: garbage\r\n`);
    ok("static ims broken is 200", m3?.status === 200, show(m3));
    headOnly = true;
    const hd = await get("/static/index.html", `If-None-Match: ${ix}\r\n`, "HEAD");
    headOnly = false;
    ok("static HEAD 304", is304(hd, ix), show(hd));
    const p1 = await get("/static/index.html", `If-Match: ${ix}\r\n`);
    ok("static if-match weak is 412", p1?.status === 412, show(p1));
    const p2 = await get("/static/index.html", `If-Match: *\r\n`);
    ok("static if-match star is 200", p2?.status === 200, show(p2));
    const p3 = await get("/static/index.html", `If-Unmodified-Since: ${imf(T - 1)}\r\n`);
    const p4 = await get("/static/index.html", `If-Unmodified-Since: ${imf(T)}\r\n`);
    ok("static if-unmodified-since", p3?.status === 412 && p4?.status === 200, `${p3?.status} / ${p4?.status}`);
    // 変種ごとの ETag（選んだ後に比べる — 違う変種の ETag は 200）・304 にも Vary
    const vt = { br: tagOf("app.js.br", "-br"), gzip: tagOf("app.js.gz", "-gz"), none: tagOf("app.js") };
    const vae = { br: "br", gzip: "gzip", none: "" } as Record<string, string>;
    const tags = new Set<string>();
    for (const v of ["br", "gzip", "none"]) {
        const ae = vae[v] ? `Accept-Encoding: ${vae[v]}\r\n` : "";
        const x = await get("/static/app.js", ae);
        tags.add(x?.headers.get("etag") ?? "");
        ok(`static variant ${v} etag`, x?.status === 200 && x.headers.get("etag") === (vt as Record<string, string>)[v], show(x));
        const y = await get("/static/app.js", `${ae}If-None-Match: ${(vt as Record<string, string>)[v]}\r\n`);
        ok(`static variant ${v} 304`, is304(y, (vt as Record<string, string>)[v]), show(y));
        const other = v === "br" ? vt.none : vt.br;
        const z = await get("/static/app.js", `${ae}If-None-Match: ${other}\r\n`);
        ok(`static variant ${v} other etag is 200`, z?.status === 200, show(z));
    }
    ok("static variant etags differ", tags.size === 3, [...tags].join(" "));
    // 巻き戻しのデプロイの模擬: 新しい版（T+100）を持つクライアントの If-Modified-Since に、古い版（T+50 — mtime が過去へ戻る）は 200
    writeFileSync(`${staticDir}/www/roll.txt`, "new version");
    utimesSync(`${staticDir}/www/roll.txt`, T + 100, T + 100);
    const r1 = await get("/static/roll.txt");
    writeFileSync(`${staticDir}/www/roll.txt`, "old version");
    utimesSync(`${staticDir}/www/roll.txt`, T + 50, T + 50);
    const r2 = await get("/static/roll.txt", `If-Modified-Since: ${r1?.headers.get("last-modified")}\r\n`);
    ok("static rollback ims is 200", r1?.headers.get("last-modified") === imf(T + 100) && r2?.status === 200 && r2.body === "old version", show(r2));
    const r3 = await get("/static/roll.txt", `If-None-Match: ${r1?.headers.get("etag")}\r\n`);
    ok("static rollback inm is 200", r3?.status === 200 && r3.headers.get("etag") !== r1?.headers.get("etag"), show(r3));
    // 304の後のパイプライン（本文の無いレスポンスのframing — 次のレスポンスが崩れない）
    const cp = await exchange([`GET /static/index.html HTTP/1.1\r\n${H}If-None-Match: ${ix}\r\n\r\nGET /static/big.bin HTTP/1.1\r\n${H}\r\n` +
        `GET /static/app.js HTTP/1.1\r\n${H}Accept-Encoding: br\r\nIf-None-Match: ${vt.br}\r\n\r\nGET /static/index.html HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 4);
    ok("static 304 pipeline", cp.resps.length === 4 && is304(cp.resps[0], ix) && cp.resps[1].body === big.toString("latin1") && is304(cp.resps[2], vt.br) &&
        cp.resps[3].body === "<p>hi</p>", `n=${cp.resps.length} ${cp.resps.map((x) => x.status).join(",")}`);
    // パイプライン: staticのstreamの前後のリクエスト
    const pp = await exchange([`GET /baseline11?a=1&b=2 HTTP/1.1\r\n${H}\r\nGET /static/big.bin HTTP/1.1\r\n${H}\r\nGET /static/nope HTTP/1.1\r\n${H}\r\nGET /static/index.html HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 4);
    ok("static pipeline", pp.resps.length === 4 && pp.resps[0].body === "3" && pp.resps[1].body === big.toString("latin1") && pp.resps[2].status === 404 && pp.resps[3].body === "<p>hi</p>",
        `n=${pp.resps.length}`);
}

// ── 出所の動的オラクル（effectのマイルストーンの段階4c — language.md 12 節「出所の依存」）: 共有キャッシュも保存してよいと宣言したレスポンス（Cache-Controlにpublicか
// private / no-storeの無いmax-age）は、リクエストの認証の頭（Cookie・Authorization）を変えても同じでなければならない（非干渉の観測 — analyzerが受理した
// srvで、観測した依存 ⊆ 導出〔共有のルートは源に届かない〕）。検査が鳴る証明 = /me（Cookieを読む・共有の宣言なし）は頭でレスポンスが変わり、private
async function originEp() {
    const creds = ["", "Cookie: sid=alice; theme=dark\r\n", "Authorization: Bearer t0k\r\nCookie: sid=bob\r\n"];
    const shared = (x: Resp | undefined) => {
        const cc = x?.headers.get("cache-control") ?? "";
        return /public|max-age/.test(cc) && !/private|no-store/.test(cc);
    };
    const paths = staticDir ? ["/shared/index.html", "/shared/app.js", "/shared/nope", "/pub", "/pub?x=1", "/me"] : ["/pub", "/pub?x=1", "/me"];
    for (const p of paths) {
        const rs: (Resp | undefined)[] = [];
        for (const c of creds) {
            rs.push((await exchange([`GET ${p} HTTP/1.1\r\n${H}${c}Connection: close\r\n\r\n`], 1)).resps[0]);
        }
        const key = (x: Resp | undefined) => `${x?.status} ${JSON.stringify([...(x?.headers ?? new Map())])} ${x?.body}`;
        if (rs.some((x) => shared(x))) {
            ok(`origin shared ${p} independent of credentials`, rs.every((x) => key(x) === key(rs[0])), rs.map((x) => `${x?.status}:${x?.body?.slice(0, 20)}`).join(" | "));
        }
    }
    const m = await Promise.all(creds.map(async (c) => (await exchange([`GET /me HTTP/1.1\r\n${H}${c}Connection: close\r\n\r\n`], 1)).resps[0]));
    ok("origin /me depends on credentials and is private", m[0]?.body === "sid=-" && m[1]?.body === "sid=alice" && m.every((x) => x?.headers.get("cache-control") === "private"),
        m.map((x) => `${x?.body}/${x?.headers.get("cache-control")}`).join(" | "));
    const pub = (await exchange([`GET /pub HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1)).resps[0];
    ok("origin /pub is shared (Fresh)", pub?.headers.get("cache-control") === "max-age=60", `cc=${pub?.headers.get("cache-control")}`);
    if (staticDir) {
        const s = (await exchange([`GET /shared/index.html HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1)).resps[0];
        ok("origin /shared is shared (Shared)", s?.headers.get("cache-control") === "public, max-age=60, s-maxage=600", `cc=${s?.headers.get("cache-control")}`);
    }
}

// --delayed-only: Delayedの検査だけ（httpcheck.shのミューテーションの自己検査 — 時刻つきの送信バッファリングのrtのミュータント84 / 87 / 88でビルドしたsrvに掛ける）
if (process.argv.includes("--delayed-only")) {
    await delayed();
    console.log(`check: ${pass} passed, ${fail} failed (delayed only)`);
    for (const f of fails.slice(0, 30)) console.log("  FAIL " + f);
    process.exit(fail ? 1 : 0);
}
await baseline();
const nfrag = await frag();
await pipeline();
await errors();
await delay();
await delayed();
await jsonEp();
await jsonComp();
await streamEp();
if (!useTls) {
    await chunkedEp();
    await gzipStream();
    await sseEp();
}
await staticEp();
await originEp();
await uploadEp();
await echoEp([0, 1, 1024, 10240, 16384], 5000);
await echoPipe();
await one("echo GET 405", `GET /echo HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 405, null);
await one("echo CL > max 413", Buffer.concat([Buffer.from(`POST /echo HTTP/1.1\r\n${H}Content-Length: 16385\r\n\r\n`, "latin1"), randomBytes(16385)]), 413, null);
console.log(`check: ${pass} passed, ${fail} failed (frag jobs ${nfrag}) in ${((performance.now() - t) / 1000).toFixed(1)} s`);
for (const f of fails.slice(0, 30)) console.log("  FAIL " + f);
process.exit(fail ? 1 : 0);
