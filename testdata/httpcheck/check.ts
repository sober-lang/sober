// check.ts <port> [--frag-random N] [--echo-big] — HttpArena の validate.sh / validate-frag.py を模した網（net 4c — gate httpcheck）。
// 相手 = testdata/httpcheck/srv.sober（/baseline11・/pipeline・/delay/{ms}・/json/{count}?m=・POST /echo）。node --experimental-strip-types check.ts 18080
// --echo-big: echo の大きい本文の格子だけ（100 KB・上限ちょうどの 128 KiB を Content-Length と chunked で + 上限を超えた 128 KiB + 1 B と 1 MB は 413 —
// 相手は SRV_MAXBODY = 131072 の srv〔bench/httparena の entry と同じ上限〕。report-848 / 849）
import * as net from "node:net";
import { randomBytes } from "node:crypto";
import { readFileSync } from "node:fs";
import { gunzipSync } from "node:zlib";

const port = Number(process.argv[2]);
const echoBig = process.argv.includes("--echo-big");
const fragRandom = Number(process.argv[process.argv.indexOf("--frag-random") + 1] ?? 100) || 100;
let pass = 0;
let fail = 0;
const fails: string[] = [];
function ok(name: string, cond: boolean, detail = "") {
    if (cond) pass++;
    else {
        fail++;
        fails.push(`${name}${detail ? " — " + detail : ""}`);
    }
}

type Resp = { status: number; headers: Map<string, string>; body: string };

// parseAll は受けたバイト列の応答を順に読む（Content-Length だけ — std/http の応答は常に Content-Length）
let headOnly = false;
function parseAll(buf: Buffer): { resps: Resp[]; rest: number } {
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
        const cl = headOnly ? 0 : Number(headers.get("content-length") ?? "0");
        if (he + 4 + cl > buf.length) break;
        resps.push({ status, headers, body: buf.subarray(he + 4, he + 4 + cl).toString("latin1") });
        p = he + 4 + cl;
    }
    return { resps, rest: p };
}

// exchange は parts を間隔 gap ms で書き、want 件の応答が揃うか相手が閉じるまで読む → 応答と閉じられたか
function exchange(parts: (string | Buffer)[], want: number, gap = 20, timeout = 5000): Promise<{ resps: Resp[]; closed: boolean; raw: Buffer }> {
    return new Promise((resolve) => {
        const s = net.createConnection({ port, host: "127.0.0.1" });
        s.setNoDelay(true);
        let buf = Buffer.alloc(0);
        let done = false;
        const finish = (closed: boolean) => {
            if (done) return;
            done = true;
            clearTimeout(t);
            s.destroy();
            resolve({ resps: parseAll(buf).resps, closed, raw: buf });
        };
        const t = setTimeout(() => finish(false), timeout);
        s.on("data", (d) => {
            buf = Buffer.concat([buf, d]);
            if (want > 0 && parseAll(buf).resps.length >= want && want < 1000) {
                // 揃った — こちらの書きを閉じて（FIN）相手の閉じを少しだけ待つ（keep の検査は呼び手が closed を見る。
                // 誤りの応答の後のサーバは残りを読み捨ててから閉じる — lingering close）
                s.end();
                setTimeout(() => finish(false), 300);
            }
        });
        s.on("end", () => finish(true));
        s.on("close", () => finish(true));
        s.on("error", () => finish(true));
        s.on("connect", async () => {
            for (let i = 0; i < parts.length; i++) {
                if (i > 0) await new Promise((r) => setTimeout(r, gap));
                if (!s.destroyed) s.write(parts[i]);
            }
        });
    });
}

const rnd = (a: number, b: number) => a + Math.floor(Math.random() * (b - a + 1));

async function one(name: string, req: string | Buffer, wantStatus: number, wantBody: string | null, opts: { closed?: boolean; ctype?: string } = {}) {
    const r = await exchange([req], 1);
    const x = r.resps[0];
    if (!x) {
        ok(name, false, `no response (closed=${r.closed} raw=${JSON.stringify(r.raw.toString("latin1").slice(0, 80))})`);
        return;
    }
    let good = x.status === wantStatus && (wantBody === null || x.body === wantBody);
    if (opts.ctype !== undefined) good &&= (x.headers.get("content-type") ?? "").startsWith(opts.ctype);
    if (opts.closed !== undefined) good &&= r.closed === opts.closed;
    ok(name, good, `got ${x.status} ${JSON.stringify(x.body)} ct=${x.headers.get("content-type")} closed=${r.closed}`);
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
    // limited-conn: 10 要求ずつ張り直し × 50
    let good = 0;
    for (let c = 0; c < 50; c++) {
        const s = net.createConnection({ port, host: "127.0.0.1" });
        await new Promise((r) => s.on("connect", r));
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

// ── 誤り（400 / 413 / 431 / 501 / 505 — 応答の後は閉じる）
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

// ── json（/json/{count}?m= — 本家 validate.sh の json の検査の形: 乱数の count × m を 4 組・全欄を dataset と照合〔作った item の自己整合では通らない〕・
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

// ── json-comp（/json/{count}?m= の gzip — 本家 validate.sh の json-comp の 3 検査〔Accept-Encoding: gzip, br で Content-Encoding が付き、解くと全欄が
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

// ── stream（Response の stream — report-763: Content-Length = length・本文は stream が emit したバイト列・圧縮しない・HEAD は呼ばない・
// stream の後ろのパイプラインの要求も処理する）
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
    // 圧縮しない（Accept-Encoding: gzip でも Content-Encoding / Vary なし）
    const g = await exchange([`GET /stream/3000 HTTP/1.1\r\n${H}Accept-Encoding: gzip\r\nConnection: close\r\n\r\n`], 1);
    ok("stream no gzip", g.resps[0]?.status === 200 && !g.resps[0].headers.has("content-encoding") && !g.resps[0].headers.has("vary") && g.resps[0].body === genBody(3000),
        `ce=${g.resps[0]?.headers.get("content-encoding")}`);
    // HEAD: 頭だけ（Content-Length は GET と同じ）
    headOnly = true;
    const h = await exchange([`HEAD /stream/777 HTTP/1.1\r\n${H}Connection: close\r\n\r\n`], 1);
    headOnly = false;
    ok("stream HEAD", h.resps[0]?.status === 200 && h.resps[0].headers.get("content-length") === "777" && h.raw.length === h.raw.indexOf("\r\n\r\n") + 4,
        `raw=${h.raw.length}`);
    // パイプライン: stream の前後の要求（同じ切片）
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

// ── echo（POST /echo — HttpArena の 8gbit の端点〔validate.sh の 8gbit の節〕。乱数の本文を byte 一致で: Content-Length と chunked〔乱数の切り方・
// 16 進の大小・chunk-ext・trailer〕・乱数の位置で断片化した送り・パイプライン。本文は応答の Content-Type = application/octet-stream で返る。report-848）
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

// echoReq は body を送る POST /echo の要求（chunked なら chunkedOf・そうでなければ Content-Length）
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

// echoPipe は同じ切片に CL と chunked の echo を並べた列（応答の順と本文の境界）
async function echoPipe() {
    const bs = [randomBytes(700), randomBytes(3000), randomBytes(1), randomBytes(5000)];
    const reqs = bs.map((b, i) => echoReq(b, i % 2 === 1, 512, i === bs.length - 1));
    const r = await exchange([Buffer.concat(reqs)], bs.length);
    bs.forEach((b, i) => echoOk(`echo pipeline ${i}`, r.resps[i], b));
}

const t = performance.now();
if (echoBig) {
    // 8gbit の validate の大きさ（1 / 1 KB / 10 KB / 100 KB・chunked 10 KB / 100 KB）+ 上限ちょうど（128 KiB）
    await echoEp([1, 1024, 10240, 102400, 131072], 30000);
    // 上限を超えたら 413（頭だけ送る — 本文を送り切ると lingering close の上限〔64 KiB〕の後の RST で応答が落ちうる。既存の「CL > 16 KiB」と同じ形）
    for (const n of [131073, 1048576]) {
        await one(`echo CL ${n} 413`, `POST /echo HTTP/1.1\r\n${H}Content-Length: ${n}\r\n\r\n`, 413, null);
        await one(`echo chunked ${n} 413`, `POST /echo HTTP/1.1\r\n${H}Transfer-Encoding: chunked\r\n\r\n${n.toString(16)}\r\n`, 413, null);
    }
    console.log(`check: ${pass} passed, ${fail} failed (echo-big) in ${((performance.now() - t) / 1000).toFixed(1)} s`);
    for (const f of fails.slice(0, 30)) console.log("  FAIL " + f);
    process.exit(fail ? 1 : 0);
}
await baseline();
const nfrag = await frag();
await pipeline();
await errors();
await delay();
await jsonEp();
await jsonComp();
await streamEp();
await echoEp([0, 1, 1024, 10240, 16384], 5000);
await echoPipe();
await one("echo GET 405", `GET /echo HTTP/1.1\r\n${H}Connection: close\r\n\r\n`, 405, null);
await one("echo CL > max 413", Buffer.concat([Buffer.from(`POST /echo HTTP/1.1\r\n${H}Content-Length: 16385\r\n\r\n`, "latin1"), randomBytes(16385)]), 413, null);
console.log(`check: ${pass} passed, ${fail} failed (frag jobs ${nfrag}) in ${((performance.now() - t) / 1000).toFixed(1)} s`);
for (const f of fails.slice(0, 30)) console.log("  FAIL " + f);
process.exit(fail ? 1 : 0);
