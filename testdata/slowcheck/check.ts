// 受けと送りの期限の検査（scripts/slowcheck.sh）: testdata/slowcheck/srv.sober（conns: 4・頭1秒・本文2秒・送りの間隔1秒）に、
// 遅い攻撃の4つの形と、期限の内に終える正常な遅いクライアントを掛ける。期限は粗い時刻で最大約2.1秒遅れて効く（早くは効かない）ので、許す遅れは2.5秒。
// 期限で閉じるときは何も送らない（408も送らない）。
// --full: サーバーは天井が4本の予約で埋まる構成（SLOW_FULL）。読まない相手の接続が天井を越えて切られ、Ledgerのcutに数えられること・
// 同時に4本が（TLSなら握手から）通って切られないこと・待っている接続の借りがワーカーごとに単位1つまでであることを見る
//   node check.ts <port> [--tls] [--full]
import { execFileSync } from "node:child_process";
import fs from "node:fs";
import net from "node:net";
import tls from "node:tls";

const port = +process.argv[2];
const useTls = process.argv.includes("--tls");
const full = process.argv.includes("--full");
const SLACK = 2500;
const HEAD = 1000;
const BODY = 2000;
const SEND = 1000;
let failed = 0;
let passed = 0;

const sleep = (ms: number) => new Promise<void>((r) => setTimeout(r, ms));

function connect(): Promise<net.Socket> {
  return new Promise((res, rej) => {
    const s: net.Socket = useTls
      ? tls.connect({ port, host: "127.0.0.1", rejectUnauthorized: false, ALPNProtocols: ["http/1.1"] }, () => res(s))
      : net.connect(port, "127.0.0.1", () => res(s));
    s.on("error", (e) => rej(e));
  });
}

function rawConnect(): Promise<net.Socket> {
  return new Promise((res, rej) => {
    const s = net.connect(port, "127.0.0.1", () => res(s));
    s.on("error", (e) => rej(e));
  });
}

// 相手が閉じるまでの時間（ms）と受けたバイト数。limit msを過ぎたら -1
function closedWithin(s: net.Socket, limit: number): Promise<{ ms: number; bytes: number }> {
  const t0 = Date.now();
  let bytes = 0;
  return new Promise((res) => {
    const tm = setTimeout(() => res({ ms: -1, bytes }), limit);
    s.on("data", (d: Buffer) => { bytes += d.length; });
    s.on("error", () => {});
    s.on("close", () => { clearTimeout(tm); res({ ms: Date.now() - t0, bytes }); });
  });
}

function check(name: string, ok: boolean, detail: string) {
  if (ok) {
    passed++;
    console.log(`ok   ${name}: ${detail}`);
  } else {
    failed++;
    console.log(`FAIL ${name}: ${detail}`);
  }
}

// クライアントの側で実際にかかった時間（負荷の下ではタイマーとイベントループが遅れる）: span = 最初の断片から最後の断片を送るまで・
// maxStall = 受けたデータを次に読むまでの最長（読みを止めた時間と、イベントループが回らなかった時間を含む）
// reads = 読んだ時刻（最初の読みからの ms）と大きさの最後の12件（落ちたときの調べの材料）
type Took = { span: number; maxStall: number; reads?: string[]; t0?: number };

// 1本の接続でリクエストを送り、レスポンスの本文を1つ読む（Content-Length）。pieces = 送る断片と、断片の間の待ち
async function exchange(s: net.Socket, pieces: string[], gap: number, readGap = 0, took?: Took): Promise<string> {
  let buf = Buffer.alloc(0);
  const done = new Promise<string>((res, rej) => {
    let last = 0;
    const on = (d: Buffer) => {
      const now = Date.now();
      if (took && last > 0) took.maxStall = Math.max(took.maxStall, now - last);
      if (took) { took.t0 ??= now; (took.reads ??= []).push(`${now - took.t0}:${d.length}`); if (took.reads.length > 12) took.reads.shift(); }
      last = now;
      buf = Buffer.concat([buf, d]);
      if (readGap > 0) {
        s.pause();
        setTimeout(() => s.resume(), readGap);
      }
      const h = buf.indexOf("\r\n\r\n");
      if (h < 0) return;
      const m = /content-length: *(\d+)/i.exec(buf.subarray(0, h).toString());
      const n = m ? +m[1] : 0;
      if (buf.length >= h + 4 + n) {
        s.off("data", on);
        const out = buf.subarray(0, h + 4 + n).toString("latin1");
        buf = buf.subarray(h + 4 + n);
        res(out);
      }
    };
    s.on("data", on);
    s.on("close", () => rej(new Error(`closed after ${buf.length} bytes`)));
  });
  done.catch(() => {});
  const w0 = Date.now();
  for (let i = 0; i < pieces.length; i++) {
    if (i > 0) await sleep(gap);
    s.write(pieces[i]);
  }
  if (took) took.span = Date.now() - w0;
  return done;
}

// サーバーの台帳: timeout = 期限で切った接続の数・shed = 入れずに閉じた接続の数・tasks = 今いる接続のtaskの数（この問い合わせの接続を含む）
async function ledger(): Promise<{ timeout: number; shed: number; tasks: number; fail: number; evicted: number }> {
  const s = await connect();
  try {
    const r = await exchange(s, ["GET /ledger HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
    const [timeout, shed, tasks, fail, evicted] = r.slice(r.indexOf("\r\n\r\n") + 4).trim().split(" ").map(Number);
    return { timeout, shed, tasks, fail, evicted };
  } finally {
    s.destroy();
  }
}

// 前の検査の接続のtaskが全部出るまで待つ（conns: 4 の枠が空いてから次を始める。空く前に繋ぐと、接続は入れずに閉じられ〔shed〕、
// 期限で閉じられたのと見分けがつかない）。時間ではなく、台帳のtasksが問い合わせの接続1本だけになることで待つ
let baseTasks = -1;
async function quiesce() {
  for (let i = 0; i < 600; i++) {
    const l = await ledger();
    if (baseTasks < 0) baseTasks = l.tasks;
    if (l.tasks <= baseTasks) return;
    await sleep(50);
  }
  throw new Error("the server did not release the previous connections");
}

// 正常なクライアントの検査: クライアント自身が期限より長く止まった（負荷でタイマーが遅れた）ときは、サーバーが閉じてよいので判定に使わず、やり直す（5回まで）
async function legit(name: string, limit: number, f: (took: Took) => Promise<{ ok: boolean; detail: string }>) {
  let slow = 0;
  for (;;) {
    await quiesce();
    const took: Took = { span: 0, maxStall: 0 };
    const r = await f(took);
    const clientSlow = Math.max(took.span, took.maxStall) >= limit;
    if (r.ok || !clientSlow || slow >= 4) {
      check(name, r.ok, r.detail + (slow > 0 ? ` (redone ${slow}x: the client itself stalled past ${limit}ms)` : ""));
      return;
    }
    slow++;
  }
}

async function normal(name: string) {
  const s = await connect();
  try {
    const r = await exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
    check(name, r.startsWith("HTTP/1.1 200") && r.endsWith("ok\n"), r.split("\r\n")[0]);
  } catch (e) {
    check(name, false, String(e));
  }
  s.destroy();
}

// 攻撃: 何も送らない接続4本（conns: 4を全部占める）
// 期限は早く効かないので、頭の期限より早く0バイトで閉じた接続（TLSなら握手の前に閉じた接続）は、期限ではなく枠に入れなかった接続（shed）。
// 前の段の接続（quiesce が最後に使った台帳の問い合わせの接続を含む）のtaskが出る前に繋ぐと起きる。その回は判定に使わず、やり直す（3回まで）。
// 期限で閉じた数と shed の数は、台帳の照合（ledger-timeout）の期待に足す
let idleTimed = 0, idleShed = 0;
async function idle() {
  for (let a = 0; ; a++) {
    if (a > 0) await quiesce();
    const ss = await Promise.all([0, 1, 2, 3].map(() => connect().catch(() => null)));
    const rs = await Promise.all(ss.map((s) => (s ? closedWithin(s, HEAD + SLACK + 1000) : Promise.resolve({ ms: 0, bytes: 0 }))));
    for (const s of ss) s?.destroy();
    const shed = rs.filter((r) => r.ms >= 0 && r.ms < HEAD && r.bytes === 0).length;
    const timed = rs.filter((r) => r.ms >= HEAD && r.ms <= HEAD + SLACK && r.bytes === 0).length;
    idleShed += shed;
    idleTimed += timed;
    if (shed === 0 || a >= 2) {
      check("idle", timed === 4, rs.map((r) => `${r.ms}ms/${r.bytes}B`).join(" ") + (a > 0 ? ` (redone ${a}x: ${idleShed} connection(s) were shed before the previous tasks left)` : ""));
      return;
    }
  }
}

// 攻撃: 頭を200 msおきに1行ずつ送り続ける
async function slowHead() {
  const s = await connect();
  const w = closedWithin(s, HEAD + SLACK + 1000);
  s.write("GET / HTTP/1.1\r\nHost: x\r\n");
  let stop = false;
  (async () => { while (!stop && !s.destroyed) { await sleep(200); if (!s.destroyed) s.write("X-A: b\r\n"); } })();
  const r = await w;
  stop = true;
  check("slow-head", r.ms >= 0 && r.ms <= HEAD + SLACK && r.bytes === 0, `${r.ms}ms/${r.bytes}B`);
  s.destroy();
}

// 攻撃: 頭を送った後、本文を200 msおきに1バイト
async function slowBody() {
  const s = await connect();
  s.write("POST /echo HTTP/1.1\r\nHost: x\r\nContent-Length: 1000\r\n\r\n");
  const w = closedWithin(s, BODY + SLACK + 1000);
  let stop = false;
  (async () => { while (!stop && !s.destroyed) { await sleep(200); if (!s.destroyed) s.write("a"); } })();
  const r = await w;
  stop = true;
  check("slow-body", r.ms >= 0 && r.ms <= BODY + SLACK && r.bytes === 0, `${r.ms}ms/${r.bytes}B`);
  s.destroy();
}

// 攻撃: パイプラインで1 MiBのレスポンスを40本頼み、読まない。送りが進まなくなってから送りの間隔の上限で閉じられる。
// 読まないので相手の閉じは見えない。待った後に読み始め、全部（40 MiB）が届く前に接続が終わることで確かめる
async function unread() {
  const s = await connect();
  s.write("GET /big HTTP/1.1\r\nHost: x\r\n\r\n".repeat(40));
  s.pause();
  await sleep(SEND + SLACK + 1000);
  const r = await new Promise<{ end: boolean; bytes: number }>((res) => {
    let bytes = 0;
    const tm = setTimeout(() => res({ end: false, bytes }), 3000);
    s.on("data", (d: Buffer) => { bytes += d.length; });
    s.on("error", () => { clearTimeout(tm); res({ end: true, bytes }); });
    s.on("close", () => { clearTimeout(tm); res({ end: true, bytes }); });
    s.resume();
  });
  check("unread", r.end && r.bytes < 40 * 1048576, `${r.end ? "closed" : "open"} after ${(r.bytes / 1048576).toFixed(1)} MiB`);
  s.destroy();
}

// 攻撃（TLS）: ClientHelloの途中で止まる（recordの頭5バイトと本文の一部だけ）
async function partialHello() {
  const s = await rawConnect();
  const w = closedWithin(s, HEAD + SLACK + 1000);
  s.write(Buffer.from([0x16, 0x03, 0x01, 0x01, 0x00, 0x01, 0x00, 0x00, 0xfc, 0x03, 0x03]));
  const r = await w;
  check("tls-partial-hello", r.ms >= 0 && r.ms <= HEAD + SLACK && r.bytes === 0, `${r.ms}ms/${r.bytes}B`);
  s.destroy();
}

// 正常: 頭を0.75秒かけて送る（4断片・0.25秒おき）
async function legitSlowHead(took: Took) {
  const s = await connect();
  let out;
  try {
    const r = await exchange(s, ["GET / HT", "TP/1.1\r\nHo", "st: x\r\n", "\r\n"], 250, 0, took);
    out = { ok: r.startsWith("HTTP/1.1 200"), detail: r.split("\r\n")[0] };
  } catch (e) {
    out = { ok: false, detail: `${e} (client: longest gap between reads ${took.maxStall}ms, send span ${took.span}ms, last reads [ms:bytes] ${(took.reads ?? []).join(" ")}, closed at ${took.t0 ? Date.now() - took.t0 : -1}ms)` };
  }
  s.destroy();
  return out;
}

// 正常: 本文を1.2秒かけて送る（頭の後に4断片・0.4秒おき）
async function legitSlowBody(took: Took) {
  const s = await connect();
  let out;
  try {
    const r = await exchange(s, ["POST /echo HTTP/1.1\r\nHost: x\r\nContent-Length: 40\r\n\r\n", "a".repeat(10), "a".repeat(10), "a".repeat(10), "a".repeat(10)], 400, 0, took);
    out = { ok: r.startsWith("HTTP/1.1 200") && r.endsWith("40\n"), detail: r.split("\r\n")[0] };
  } catch (e) {
    out = { ok: false, detail: `${e} (client: longest gap between reads ${took.maxStall}ms, send span ${took.span}ms, last reads [ms:bytes] ${(took.reads ?? []).join(" ")}, closed at ${took.t0 ? Date.now() - took.t0 : -1}ms)` };
  }
  s.destroy();
  return out;
}

// 正常: /big をパイプラインで k 本頼み、64 KiB あたり 50 ms の速さで止まりながら全部読む。k は送りのバッファの上限（net.ipv4.tcp_wmem の3つ目）を越える分 —
// レスポンスの送りが送りのバッファに入りきらずに待ち、頭の期限（リクエストの前から数える）を過ぎても、読み続ける相手は切られない（送りの間隔の期限で数える）
const WMEM = (() => { try { return +fs.readFileSync("/proc/sys/net/ipv4/tcp_wmem", "utf8").trim().split(/\s+/)[2]; } catch { return 4194304; } })();
async function legitSlowPipeline(took: Took, fixedPause = false) {
  const k = Math.floor(WMEM / 1048576) + 1;
  const s = await connect();
  const want = k * 1048576;
  let body = 0, last = 0, closed = false;
  const t0 = Date.now();
  const done = new Promise<void>((res) => {
    s.on("data", (d: Buffer) => {
      const now = Date.now();
      if (last > 0) took.maxStall = Math.max(took.maxStall, now - last);
      last = now;
      body += d.length;
      // 止まる時間は読んだ大きさに比例（64 KiB あたり 50 ms — 平文の切片は約 64 KiB・TLS の切片は record の約 16 KiB。どちらも同じ速さで読む）
      s.pause();
      setTimeout(() => s.resume(), fixedPause ? 50 : Math.max(1, Math.round((50 * d.length) / 65536)));
      if (body >= want) res();
    });
    s.on("close", () => { closed = true; res(); });
  });
  s.write("GET /big HTTP/1.1\r\nHost: x\r\n\r\n".repeat(k));
  await done;
  s.destroy();
  return { ok: !closed || body >= want, detail: `${k} x /big (tcp_wmem max ${WMEM}): ${closed && body < want ? "closed" : "read"} ${body} bytes in ${Date.now() - t0}ms (longest gap between reads ${took.maxStall}ms)` };
}

// 正常: 1 MiBを少しずつ読む（切片ごとに0.3秒止まる。全体は送りの間隔の上限より長いが、送りは進み続ける）
async function legitSlowRead(took: Took) {
  const s = await connect();
  const t0 = Date.now();
  let out;
  try {
    const r = await exchange(s, ["GET /big HTTP/1.1\r\nHost: x\r\n\r\n"], 0, 300, took);
    out = { ok: r.startsWith("HTTP/1.1 200") && r.length > 1048576, detail: `${r.split("\r\n")[0]} in ${Date.now() - t0}ms` };
  } catch (e) {
    out = { ok: false, detail: `${e} (client: longest gap between reads ${took.maxStall}ms, send span ${took.span}ms, last reads [ms:bytes] ${(took.reads ?? []).join(" ")}, closed at ${took.t0 ? Date.now() - took.t0 : -1}ms)` };
  }
  s.destroy();
  return out;
}

// 正常: keep-aliveで0.8秒おきに4本（期限はレスポンスを送り終えるたびに張り直される）
async function legitKeepAlive(took: Took) {
  const s = await connect();
  let out = { ok: true, detail: "4 requests 0.8s apart" };
  try {
    for (let i = 0; i < 4; i++) {
      if (i > 0) {
        const t0 = Date.now();
        await sleep(800);
        took.span = Math.max(took.span, Date.now() - t0);
      }
      const r = await exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
      out.ok = out.ok && r.startsWith("HTTP/1.1 200");
    }
  } catch (e) {
    out = { ok: false, detail: `${e} (client: longest gap between reads ${took.maxStall}ms, send span ${took.span}ms, last reads [ms:bytes] ${(took.reads ?? []).join(" ")}, closed at ${took.t0 ? Date.now() - took.t0 : -1}ms)` };
  }
  s.destroy();
  return out;
}

// 正常: ハンドラが期限より長く走る・Delayedが期限より長く待つ
async function legitLong(path: string, body: string) {
  await quiesce();
  const s = await connect();
  try {
    const r = await exchange(s, [`GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`], 0);
    check(`legit-${path.slice(1)}`, r.startsWith("HTTP/1.1 200") && r.endsWith(body), r.split("\r\n")[0]);
  } catch (e) {
    check(`legit-${path.slice(1)}`, false, String(e));
    s.destroy();
    return;
  }
  // 長い待ちの後も、次の頭の期限の内のリクエストは通る（0.5秒置く。クライアントが頭の期限より長く止まったら、やり直しの外なので判定に使わない）
  const t0 = Date.now();
  await sleep(500);
  const stalled = Date.now() - t0 >= HEAD;
  try {
    const r2 = await exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
    check(`legit-${path.slice(1)}-next`, r2.startsWith("HTTP/1.1 200"), r2.split("\r\n")[0]);
  } catch (e) {
    check(`legit-${path.slice(1)}-next`, stalled, String(e) + (stalled ? ` (the client itself stalled past ${HEAD}ms — not judged)` : ""));
  }
  s.destroy();
}

// 受信バッファ: 1本の接続で約1 MiBのリクエストをpipelinedで読ませた後も、サーバーの側のソケットの受信バッファ（ss の rb）は
// SO_RCVBUF 64 KiB の値（カーネルが2倍した131072）のまま（自動調整で広がらない。ringの経路は累計32 KiBを越えた時点・epollの経路は受けた時点で置く）
async function rcvbuf() {
  const s = await connect();
  try {
    const one = "GET / HTTP/1.1\r\nHost: x\r\n\r\n";
    const n = Math.ceil(1048576 / one.length);
    let buf = "";
    let got = 0;
    const done = new Promise<void>((res, rej) => {
      s.on("data", (d: Buffer) => {
        buf += d.toString("latin1");
        let i;
        while ((i = buf.indexOf("ok\n")) >= 0) { got++; buf = buf.slice(i + 3); }
        if (got >= n) res();
      });
      s.on("close", () => rej(new Error(`closed after ${got} responses`)));
    });
    done.catch(() => {});
    for (let k = 0; k < n; k += 256) s.write(one.repeat(Math.min(256, n - k)));
    await done;
    const out = execFileSync("ss", ["-tmnH", "state", "established", `( sport = :${port} )`]).toString();
    const rb = [...out.matchAll(/rb(\d+)/g)].map((m) => +m[1]);
    check("rcvbuf", rb.length >= 1 && rb.every((v) => v === 131072), `${n} requests, server rb=${rb.join(",")} (want 131072)`);
  } catch (e) {
    check("rcvbuf", false, String(e));
  }
  s.destroy();
}

// 入場が埋まったとき（reject: なし）: 何も送らない接続4本で conns: 4 を埋めた後に繋いだ2本は、閉じられずに列で待ち、
// 埋めた接続が切られるか閉じられて枠が空いた後に処理される（io_uring の経路では、入場を待つ接続があるとき rt が受けの無い入場済みの接続から切る。
// epoll の経路〔W1〕は頭の期限で閉じられた後。どちらでも応答が返ることを見て、待った時間は記録に出す）
async function waitFull() {
  const ss = await Promise.all([0, 1, 2, 3].map(() => rawConnect()));
  await sleep(200);
  const t0 = Date.now();
  const rs = await Promise.all([0, 1].map(async () => {
    try {
      const s = await connect();
      const r = await exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
      s.destroy();
      return { ok: r.startsWith("HTTP/1.1 200") && r.endsWith("ok\n"), ms: Date.now() - t0, d: r.split("\r\n")[0] };
    } catch (e) {
      return { ok: false, ms: Date.now() - t0, d: String(e) };
    }
  }));
  check("wait-full", rs.every((r) => r.ok), rs.map((r) => `${r.ms}ms ${r.d}`).join(" / "));
  for (const s of ss) s.destroy();
}

// 待っている間に相手が去った接続: 何も送らずに RST で去った接続は、入場しても handler を走らせない（走らせると Recv が ECONNRESET を返し fail が1つ増える）。
// 同じ埋め方（何も送らない4本を、待っている接続を積んだ後に閉じる）だけの対照の回と fail の増えを比べる。リクエストを送ってから送る側だけを閉じた接続には応答する
async function waitGone(withGone: boolean): Promise<number> {
  const l0 = await ledger();
  const ss = await Promise.all([0, 1, 2, 3].map(() => rawConnect()));
  await sleep(200);
  const extra: Promise<unknown>[] = [];
  if (withGone) {
    // 繋いだ直後にリセットする（入場を待つ接続があると、rt は約0.27秒ごとの走査で埋めた接続を切って枠を空ける — その前に去っている形）
    const r = await rawConnect();
    r.resetAndDestroy();
    const f = await rawConnect();
    f.end();
    extra.push(closedWithin(f, HEAD + SLACK + 3000));
    const h = await rawConnect();
    let got = "";
    h.on("data", (d: Buffer) => { got += d.toString("latin1"); });
    const hc = new Promise<void>((res) => { h.on("close", () => res()); h.on("end", () => res()); });
    h.end("GET / HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n");
    extra.push(hc.then(() => check("wait-halfclose", got.startsWith("HTTP/1.1 200") && got.endsWith("ok\n"), got.split("\r\n")[0] || "no response")));
  }
  // 埋めた4本は待っている接続を積んだ後に閉じる（閉じた後か、枠を取り戻すために切られた後に、待っていた接続が入場する）
  await sleep(200);
  for (const s of ss) s.destroy();
  await Promise.all(extra);
  await quiesce();
  // 入場を待つ接続があるとき、rt は受けの無い入場済みの接続（埋めた接続）を切って枠を取り戻す。切られた接続の handler は
  // 期限切れの誤りで終わって fail に数えられるので、その数（evicted の増え）を引く。残りがリセットした接続の handler の分
  const l1 = await ledger();
  return (l1.fail - l0.fail) - (l1.evicted - l0.evicted);
}

// 各段の前に、前の段の接続のtaskが出るのを待つ（quiesce）
const step = async (f: () => Promise<void>) => { await quiesce(); await f(); };
// Ledgerの "cut died borrowed workers"
async function cutLedger(): Promise<number[]> {
  const s = await connect();
  try {
    const r = await exchange(s, ["GET /cut HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
    return r.slice(r.indexOf("\r\n\r\n") + 4).trim().split(" ").map(Number);
  } finally {
    s.destroy();
  }
}

// 天井が埋まった構成: 読まない相手の接続（送りの列で予約を越えて伸びる）は天井を越えて切られ、cutに数えられる
async function unreadCut() {
  const [c0, d0] = await cutLedger();
  const s = await connect();
  const w = closedWithin(s, SEND + SLACK + 3000);
  s.write("GET /big HTTP/1.1\r\nHost: x\r\n\r\n".repeat(40));
  s.pause();
  const r = await w;
  s.destroy();
  await sleep(200);
  const [c1, d1] = await cutLedger();
  check("unread-cut", r.ms >= 0 && c1 - c0 === 1 && d1 - d0 === 1, `${r.ms}ms cut ${c0}→${c1} died ${d0}→${d1}`);
}

// 同時に4本（conns: 4の全部。TLSなら握手から同時）が応答を受け、どれも切られない。待っている間の借りは0
async function concurrent4() {
  const [c0] = await cutLedger();
  const ss: net.Socket[] = [];
  try {
    // 接続の失敗（切られた接続のリセット）は、その1本の失敗として数える
    const st = await Promise.allSettled([0, 1, 2, 3].map(async () => {
      const s = await connect();
      ss.push(s);
      return exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0);
    }));
    const all = st.map((r) => (r.status === "fulfilled" ? r.value : `error: ${r.reason}`));
    const ok = all.every((r) => r.startsWith("HTTP/1.1 200"));
    for (const s of ss) s.destroy();
    await sleep(300);
    const [c1] = await cutLedger();
    check("concurrent-4", ok && c1 === c0, `${all.filter((r) => r.startsWith("HTTP/1.1 200")).length}/4 ok · cut ${c0}→${c1}`);
  } catch (e) {
    for (const s of ss) s.destroy();
    check("concurrent-4", false, String(e));
  }
}

// 握手と1リクエストの後に待っている接続3本と、/cutを読む1本: 借りを持てるのはワーカーが手元に持つtask（ワーカーごとに1本）だけで、
// 借りは単位1つ（64 KiB）に収まる。切り替えて待つtaskは借りを返す。借りの和 ≤ min(ワーカー数, 4) × 64 KiB
async function idleBorrow() {
  const ss = await Promise.all([0, 1, 2].map(() => connect()));
  await Promise.all(ss.map((s) => exchange(s, ["GET / HTTP/1.1\r\nHost: x\r\n\r\n"], 0)));
  await sleep(300);
  const [, , b, w] = await cutLedger();
  check("idle-borrowed", b <= Math.min(w, 4) * 65536, `borrowed=${b} workers=${w}`);
  for (const s of ss) s.destroy();
  await sleep(200);
}

if (full) {
  await normal("normal-before");
  await concurrent4();
  await idleBorrow();
  await unreadCut();
  await normal("normal-after-cut");
  await concurrent4();
  console.log(`check: ${passed} passed, ${failed} failed`);
  process.exit(failed > 0 ? 1 : 0);
}


await step(() => normal("normal-before"));
await step(idle);
await step(() => normal("normal-after-idle"));
await step(slowHead);
await step(slowBody);
await step(unread);
if (useTls) await step(partialHello);
await step(() => normal("normal-after-attacks"));
await step(rcvbuf);
// Ledger: 攻撃の接続（何も送らない4本・頭・本文・読まない〔・TLSのhandshakeの途中〕）は、どれもプールの節のtimeoutに数えられ、
// 枠に入れずに閉じた接続（shed）の数は idle の段で見た数と一致する（ほかの段の接続は shed されない）
try {
  await quiesce();
  const l = await ledger();
  const want = idleTimed + (useTls ? 4 : 3);
  check("ledger-timeout", l.timeout === want && l.shed === idleShed, `timeout=${l.timeout} shed=${l.shed} (want ${want} and ${idleShed})`);
} catch (e) {
  check("ledger-timeout", false, String(e));
}
await legit("legit-slow-head", HEAD, legitSlowHead);
await legit("legit-slow-body", BODY, legitSlowBody);
await legit("legit-slow-read", SEND, legitSlowRead);
await legit("legit-slow-pipeline", SEND, legitSlowPipeline);
// TLS: 切片（record 約 16 KiB）ごとに 50 ms 止まる遅い読み。サーバーの接続の task は深い深度で待ちながら region の上限を上げる。
// その後の wait-full で、待たせた接続の task がその深度へ入っても、前の task が上げた上限を自分の計上に数えず、天井で切られないこと（ledger-cut）
if (useTls) await legit("legit-slow-pipeline-fixed", SEND, (t) => legitSlowPipeline(t, true));
await legit("legit-keepalive", HEAD, legitKeepAlive);
await legitLong("/sleep", "slept\n");
await legitLong("/delay", "late\n");
await step(waitFull);
if (!useTls) {
  try {
    await quiesce();
    const d0 = await waitGone(false);
    const d1 = await waitGone(true);
    check("wait-gone", d1 === d0, `fail +${d1} with a reset connection, +${d0} without (want equal)`);
  } catch (e) {
    check("wait-gone", false, String(e));
  }
}
try {
  await quiesce();
  const l = await ledger();
  check("wait-full-noshed", l.shed === 0, `shed=${l.shed} (want 0)`);
} catch (e) {
  check("wait-full-noshed", false, String(e));
}
// 天井に空きがある構成: 期限で切った接続のほかに、天井で切られた接続は無い
{
  const [c] = await cutLedger();
  check("ledger-cut", c === 0, `cut=${c}`);
}
console.log(`check: ${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
