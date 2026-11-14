// areacheck.ts <srv> <syms> — 接続のtaskのエリアの保存則の検査（scripts/areacheck.shから）。
// srv（testdata/areacheck/srv.soberのELF）を子で起こし（/proc/pid/memを読むため — ptrace_scope=1は子孫だけ）、接続のtaskに4つのパス
// （普通に返る・ディープスリープの後に返る・panicで死ぬ・Serveの期限でスリープしたまま捨てられる）を踏ませ、相ごとに静まった所で全チャンクのTC_AREAと
// 全ワーカーのWK_AREA（rt.mnのMN_WKの列から — symsの `=rt.mn` 行）を読む。保存則 = 所有エリアの多重集合が「チャンクのスタックの領域の頂上
// （チャンクのページ0の底）の全部 ∪ ワーカーのエリア〔ガードの上の1 MiBの写像〕の全部」とちょうど一致（数 = チャンクの数 + W・重複なし・持ち主のないエリアなし）。
// 定数はsrc/compiler/lowerのconstから引く。印字: 相ごとに1行・最後に "areacheck-ok <交換済みのチャンクの最大> <シャロースリープしているチャンクの最大>" か "areacheck-bad <理由>"
import * as net from "node:net";
import * as fs from "node:fs";
import { spawn } from "node:child_process";

const [srv, symf] = process.argv.slice(2);
const W = +(process.env.AC_WORKERS ?? "2");
// AC_FAR=1: 本体の太い形（srvのargv[3] = far — 遠いパス）。AC_REF=1: エリアを使わないELF（ミュータント66 — 段1の前のスタックの形）— 保存則は見ず署名だけ
const FAR = process.env.AC_FAR === "1", REF = process.env.AC_REF === "1";
const src = ["task", "mn", "ir"].map((f) => fs.readFileSync(`src/compiler/lower/${f}.sober`, "utf8")).join("\n");
const cache = new Map<string, number>();
function cval(name: string): number {
  if (cache.has(name)) return cache.get(name)!;
  const m = new RegExp(`^const ${name} = ([^/\\n]+)`, "m").exec(src);
  if (!m) throw new Error(`const ${name} not found`);
  const v = m[1].trim().split(/\s*\+\s*/).reduce((a, t) => a + (/^\d+$/.test(t) ? +t : cval(t)), 0);
  cache.set(name, v);
  return v;
}
const TC_AREA = cval("TC_AREA"), TC_ONW = cval("TC_ONW"), SPARK = cval("AREA_SPARK"), ROOM = cval("TCB_TOP_ROOM"), STACK = cval("TASK_STACK"), GUARD = cval("TASK_GUARD");
const HEAD = cval("TASK_HEAD"), TC_ENTRY = cval("TC_ENTRY");
// エリアの予約ページ（task.sober）: フィールドrのWSP_AREA・深度BASE + 1 + rの退避の対（TC_SAVE + 2k = 表の基底〔予約ページの偽の基底〕・+1 = bump）
const TC_WSP = cval("TC_WSP"), TC_SAVE = cval("TC_SAVE"), TC_BASE = cval("TC_BASE"), TC_SLOTSZ = cval("TC_SLOTSZ");
const WSP_AREA = cval("WSP_AREA"), WIN_N = cval("WIN_N"), WIN_SZ = cval("WIN_SZ");
const MN_N = cval("MN_N"), MN_WK = cval("MN_WK"), WK_AREA = cval("WK_AREA");
const mnLine = fs.readFileSync(symf, "utf8").split("\n").find((l) => l.endsWith(" =rt.mn"));
if (!mnLine) { console.log("areacheck-bad no =rt.mn line in syms (SOBER_SYMS_MN=1)"); process.exit(1); }
const MN = parseInt(mnLine.split(" ")[0], 16);
// シャロースリープしているチャンクの数の相ごとの最大（TC_ONWのAREA_SPARK — 受けでスリープする接続）
let smx = 0;
// エリアの予約ページの深度を見た数の相ごとの最大（0ならエリアの予約ページが使われていない）
let awMax = 0;
// 機械語の範囲（シャロースリープの記し — TCBのワード0に本体の戻り先が残る: シャロースリープしているチャンクと、記して普通に返ったチャンク）
const codeHi = Math.max(...fs.readFileSync(symf, "utf8").split("\n").filter((l) => /^[0-9a-f]+ /.test(l)).map((l) => parseInt(l.split(" ")[0], 16)));

const p = spawn(srv, [process.env.AC_SERVE_MS ?? "6000", process.env.AC_HOLD_MS ?? "3000", ...(FAR ? ["far"] : [])],
  { env: { ...process.env, SOBER_WORKERS: String(W), SOBER_PAR_STATS: "1" }, stdio: ["ignore", "pipe", "pipe"] });
const pid = p.pid!;
let out = "", err = "";
p.stdout.on("data", (d) => { out += d; });
p.stderr.on("data", (d) => { err += d; });
const exited = new Promise<number>((r) => p.on("exit", (c) => r(c ?? -1)));
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
async function until(f: () => boolean, ms: number, what: string) {
  for (let t = 0; t < ms; t += 20) { if (f()) return; await sleep(20); }
  bad(`timeout waiting for ${what}`);
}
function bad(why: string): never {
  console.log(`areacheck-bad ${why}`);
  p.kill("SIGKILL");
  process.exit(1);
}

// 静まった所の所有エリアを読んで保存則を見る → 交換済み（所有エリアが自分の領域でない）チャンクの数
function snap(tag: string): number {
  const maps = fs.readFileSync(`/proc/${pid}/maps`, "utf8").split("\n").map((l) => /^([0-9a-f]+)-([0-9a-f]+) (\S+)/.exec(l)).filter((m) => m !== null)
    .map((m) => ({ s: parseInt(m![1], 16), e: parseInt(m![2], 16), perm: m![3] }));
  const chunkTops: number[] = [], wkTops: number[] = [], cands: number[] = [];
  maps.forEach((m, i) => {
    if (m.perm !== "rw-p") return;
    const guarded = i > 0 && maps[i - 1].e === m.s && maps[i - 1].perm === "---p" && maps[i - 1].e - maps[i - 1].s === GUARD;
    if (!guarded) return;
    // チャンクとワーカーのエリアは同じ並び（エリアの予約ページが頂上 + AWIN_OFFに来る）— ページ0のTCBの入口のワードで分ける（ワーカーのエリアのページ0は触らない）
    if (m.e - m.s === STACK + 4096 + HEAD) cands.push(m.s + STACK);
    else if (m.e - m.s === STACK) wkTops.push(m.e);
  });
  const mem = fs.openSync(`/proc/${pid}/mem`, "r"), pm = fs.openSync(`/proc/${pid}/pagemap`, "r");
  const word = (a: number) => { const b = Buffer.alloc(8); fs.readSync(mem, b, 0, 8, a); return Number(b.readBigUInt64LE(0)); };
  for (const h of cands) { if (word(h + ROOM + 8 * TC_ENTRY) !== 0) chunkTops.push(h); else wkTops.push(h); }
  // 署名: スリープしているチャンクごとの「スタックの深さ（TCB − 退避rsp）: 常駐のページ（ページ0からの相対 −4〜10）」の多重集合 — スリープしている接続のスタックの形
  const sig = new Map<string, number>();
  const pages = (h: number) => { const b = Buffer.alloc(8 * 15); fs.readSync(pm, b, 0, b.length, (h / 4096 - 4) * 8);
    const r: number[] = []; for (let i = 0; i < 15; i++) if (b.readBigUInt64LE(i * 8) >> 63n) r.push(i - 4); return r.join(","); };
  const n = word(MN + 8 * MN_N);
  const held: number[] = [];
  let swapped = 0;
  let shallow = 0;
  const strays: string[] = [];
  const awBad: string[] = [];
  let awSeen = 0;
  for (const h of chunkTops) {
    const a = REF ? h : word(h + ROOM + 8 * TC_AREA); held.push(a); if (a !== h) swapped++;
    // 退避rsp（TCBのワード0 — 止まった / 終わったtaskが最後にスタックを離れた点）は持つエリアの中。自分の領域を持つときだけページ0も
    // （連続の形 — ページ0から下へ続く）。本体の後に持つエリアへ戻らない終わりのパスは、交換で他人の持ち物になったページ0で止まる
    if (word(h + ROOM + 8 * TC_ONW) & SPARK) shallow++;
    const w0 = word(h + ROOM);
    const rsp = w0 <= codeHi ? 0 : w0;
    const inArea = rsp >= a - STACK && rsp < a, onPage0 = a === h && rsp >= h && rsp < h + ROOM;
    // ページ0より512 B以上深く止まっているチャンク（スリープしている接続 — 終わったチャンクは出口形でエリアの頂上のすぐ下に止まる）
    if (rsp !== 0 && h + ROOM - rsp >= ROOM + 512) { const k = `${h + ROOM - rsp}:${pages(h)}`; sig.set(k, (sig.get(k) ?? 0) + 1); }
    if (rsp !== 0 && !inArea && !onPage0) strays.push(`${h.toString(16)}:rsp ${rsp.toString(16)} area ${a.toString(16)}`);
    // エリアの予約ページの不変条件: シャロースリープしているtaskの予約ページの深度は全部空（ディープスリープしているtaskの予約ページの中身が守られることは /holdの答えが見る）
    const T = h + ROOM, wsp = BigInt.asUintN(64, BigInt(word(T + 8 * TC_WSP))), base = word(T + 8 * TC_BASE), sz = word(T + 8 * TC_SLOTSZ);
    for (let r = 0; r < WIN_N; r++) {
      if (((wsp >> BigInt(16 * (WIN_N - 1 - r))) & BigInt(WSP_AREA)) === 0n) continue;
      const k = base + 1 + r, sb = word(T + 8 * (TC_SAVE + 2 * k)), bump = word(T + 8 * (TC_SAVE + 2 * k + 1));
      if (word(T + 8 * TC_ONW) & SPARK) { if (bump !== sb + sz - WIN_SZ) awBad.push(`${h.toString(16)}:shallow r${r} not empty`); }
      awSeen++;
    }
  }
  for (let k = 0; k < n; k++) held.push(word(word(MN + 8 * (MN_WK + k)) + 8 * WK_AREA));
  fs.closeSync(mem); fs.closeSync(pm);
  console.log(`sig ${tag} ${[...sig.entries()].sort((x, y) => (x[0] < y[0] ? -1 : 1)).map(([k, c]) => `${c}×[${k}]`).join(" ")}`);
  if (REF) return 0;
  const line = `${tag}: chunks ${chunkTops.length} workers ${n} worker-areas ${wkTops.length} swapped ${swapped} shallow ${shallow} left-off-area ${strays.length}`;
  console.log(line);
  if (n !== W || wkTops.length !== W) bad(`${line} — expected ${W} workers with one area each`);
  if (strays.length) bad(`${tag}: a chunk left its stack outside the area it holds [${strays.slice(0, 3).join(" · ")}]`);
  if (awBad.length) bad(`${tag}: area window invariant broken [${awBad.slice(0, 3).join(" · ")}]`);
  awMax = Math.max(awMax, awSeen);
  const want = new Set([...chunkTops, ...wkTops]);
  const seen = new Map<number, number>();
  for (const a of held) seen.set(a, (seen.get(a) ?? 0) + 1);
  const dup = [...seen.entries()].filter(([, c]) => c > 1).map(([a]) => a.toString(16));
  const stray = [...seen.keys()].filter((a) => !want.has(a)).map((a) => a.toString(16));
  const orphan = [...want].filter((a) => !seen.has(a)).map((a) => a.toString(16));
  if (dup.length || stray.length || orphan.length)
    bad(`${tag}: conservation broken — held twice [${dup.slice(0, 4)}] · not an area [${stray.slice(0, 4)}] · held by nobody [${orphan.slice(0, 4)}]`);
  smx = Math.max(smx, shallow);
  return swapped;
}

// keep-aliveの接続1本（リクエスト → レスポンスの本文〔Content-Length〕・閉じられたらnull）
// リクエスト1つの答えの待ちの上限（正常な実行の最長は約0.5秒・Serveの期限で捨てられる接続の答え〔null〕はAC_SERVE_MS以内 — その3倍以上）
const GET_MS = 3 * Math.max(5000, +(process.env.AC_SERVE_MS ?? "6000"));
class Conn {
  s: net.Socket; buf = ""; closed = false; wait: ((v: string | null) => void) | null = null;
  constructor(port: number) {
    this.s = net.connect(port, "127.0.0.1");
    this.s.on("data", (d) => { this.buf += d.toString("latin1"); this.pump(); });
    this.s.on("close", () => { this.closed = true; this.pump(); });
    this.s.on("error", () => {});
  }
  pump() {
    if (!this.wait) return;
    const i = this.buf.indexOf("\r\n\r\n");
    if (i >= 0) {
      const m = /content-length:\s*(\d+)/i.exec(this.buf.slice(0, i));
      const n = m ? +m[1] : 0;
      if (this.buf.length >= i + 4 + n) {
        const st = this.buf.slice(9, 12), body = this.buf.slice(i + 4, i + 4 + n);
        this.buf = this.buf.slice(i + 4 + n);
        const w = this.wait; this.wait = null; w(`${st} ${body}`); return;
      }
    }
    if (this.closed) { const w = this.wait; this.wait = null; w(null); }
  }
  get(path: string): Promise<string | null> {
    return this.answer(path, () => this.s.write(`GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`));
  }
  // リクエストをcutバイトで割って送る（前半を送った後ms待って後半 — 受けのregionに途中のリクエストを持ったまま待つ）
  split(path: string, cut: number, ms: number): Promise<string | null> {
    const q = `GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`;
    return this.answer(path, () => { this.s.write(q.slice(0, cut)); setTimeout(() => this.s.write(q.slice(cut)), ms); });
  }
  // 答え1つを待つ（GET_MSを越えたらbad — 答えずに止まったサーバ〔ミュータントの未定義の動作でありうる〕を待ち続けて外側のtimeoutに切られ、結果が空になるのを防ぐ）
  answer(path: string, send: () => void): Promise<string | null> {
    return new Promise((r) => {
      const t = setTimeout(() => bad(`timeout waiting for the answer to ${path}`), GET_MS);
      this.wait = (v) => { clearTimeout(t); r(v); };
      send();
    });
  }
}

async function main() {
  await until(() => /^ready \d+/m.test(out), 5000, "ready");
  const port = +/^ready (\d+)/m.exec(out)![1];
  const N = 16, ROUNDS = 3;
  const cs = Array.from({ length: N }, () => new Conn(port));
  // (a) 普通に返る（keep-aliveのリクエスト → 接続のtaskは受けのディープスリープで止まる）
  for (let r = 0; r < ROUNDS; r++) {
    const rs = await Promise.all(cs.map((c) => c.get("/ok")));
    if (rs.some((x) => x !== "200 ok")) bad(`/ok answered ${rs.find((x) => x !== "200 ok")}`);
  }
  await sleep(200);
  let mx = snap("parked");
  // 客が閉じた接続は handler が普通に返って task が終わる
  for (const c of cs.splice(12)) c.s.destroy();
  await sleep(200);
  mx = Math.max(mx, snap("returned"));
  // (d) ディープスリープの後に返る（待ちの最中と後）
  const sl = Promise.all(cs.slice(0, 8).map((c) => c.get("/sleep/800")));
  await sleep(300);
  mx = Math.max(mx, snap("deep-wait"));
  const rs = await sl;
  if (rs.some((x) => x !== "200 800")) bad(`/sleep/800 answered ${rs.find((x) => x !== "200 800")}`);
  const r2 = await Promise.all(cs.map((c) => c.get("/ok")));
  if (r2.some((x) => x !== "200 ok")) bad(`/ok after the sleep answered ${r2.find((x) => x !== "200 ok")}`);
  await sleep(200);
  mx = Math.max(mx, snap("after-deep-wait"));
  // ディープスリープの後の受けは所有エリアとワーカーのエリアを交換してからシャロースリープする（LedgerのparkSwap）
  const led = await cs[0].get("/ledger");
  const swaps = +(/parkSwap=(\d+)/.exec(led ?? "")?.[1] ?? "-1");
  if (swaps < 0) bad(`/ledger answered ${led}`);
  // もう一度ディープスリープ（交換してシャロースリープした接続がワーカーのエリアの上でスリープする — 退避rspは持つエリアの中）
  const sl2 = Promise.all(cs.slice(0, 8).map((c) => c.get("/sleep/600")));
  await sleep(300);
  mx = Math.max(mx, snap("deep-again"));
  const rs2 = await sl2;
  if (rs2.some((x) => x !== "200 600")) bad(`/sleep/600 answered ${rs2.find((x) => x !== "200 600")}`);
  // (e) エリアの予約ページ: ディープスリープする接続（/hold — 受けのregionの中身 = pathを持ってスリープする）と、シャロースリープしてウェイクアップする接続（/okの連打 — ウェイクアップした点で
  // ワーカーのエリアが替わっていれば予約ページの深度を付け替える）が同じワーカーで混ざる。スリープしていた側のpathが答えにそのまま返る
  const hold = Promise.all(cs.slice(0, 6).map((c, i) => c.get(`/hold/400/h${i}x${"y".repeat(40 * i)}`)));
  for (let r = 0; r < 12; r++) {
    const ro = await Promise.all(cs.slice(6, 12).map((c) => c.get("/ok")));
    if (ro.some((x) => x !== "200 ok")) bad(`/ok beside /hold answered ${ro.find((x) => x !== "200 ok")}`);
  }
  const hr = await hold;
  hr.forEach((x, i) => { if (x !== `200 /hold/400/h${i}x${"y".repeat(40 * i)}`) bad(`/hold answered ${x} (area window content lost while sleeping deep)`); });
  // (g) 予約ページから小さいスロットへ移った深度（大きい本文）は、リクエストの後で空ならシャロースリープする — parkDeepWinが増えない
  const pdw0 = +(/parkDeepWin=(\d+)/.exec((await cs[0].get("/ledger")) ?? "")?.[1] ?? "-1");
  for (let r = 0; r < 5; r++) {
    const rb = await Promise.all(cs.slice(0, 6).map((c) => c.get("/big/9000")));
    if (rb.some((x) => x === null || x.length !== 4 + 9000)) bad(`/big/9000 answered ${rb.find((x) => x === null || x.length !== 4 + 9000)?.slice(0, 40)}`);
  }
  const pdw1 = +(/parkDeepWin=(\d+)/.exec((await cs[0].get("/ledger")) ?? "")?.[1] ?? "-1");
  if (pdw1 !== pdw0) bad(`parkDeepWin ${pdw0} → ${pdw1} over /big — a depth moved out of the area window parked deep while empty`);
  // (f) 途中のリクエストを受けのregionに持ったまま待つ接続（エリアの予約ページの深度に中身 — シャロースリープせずディープスリープする: LedgerのparkDeepWin）。待っている間に
  // 同じワーカーで /okを連打して、その予約ページを次のtaskが使う
  const part = Promise.all(cs.slice(0, 6).map((c, i) => c.split(`/hold/100/p${i}${"z".repeat(30 * i)}`, 20 + 7 * i, 400)));
  await sleep(150);
  mx = Math.max(mx, snap("partial"));
  for (let r = 0; r < 12; r++) {
    const ro = await Promise.all(cs.slice(6, 12).map((c) => c.get("/ok")));
    if (ro.some((x) => x !== "200 ok")) bad(`/ok beside a partial request answered ${ro.find((x) => x !== "200 ok")}`);
  }
  const pr0 = await part;
  pr0.forEach((x, i) => { if (x !== `200 /hold/100/p${i}${"z".repeat(30 * i)}`) bad(`a split request answered ${x} (the partial request in the area window was overwritten)`); });
  const led2 = await cs[0].get("/ledger");
  const pdw = +(/parkDeepWin=(\d+)/.exec(led2 ?? "")?.[1] ?? "-1");
  // (b) panicで死ぬ（エリアの上のスタックで死んで罠へ戻る）
  const ps = Array.from({ length: 6 }, () => new Conn(port));
  await Promise.all(ps.map((c) => c.get("/ok")));
  const pr = await Promise.all(ps.map((c) => c.get("/panic")));
  if (pr.some((x) => x !== null && !x.startsWith("500"))) bad(`/panic answered ${pr.find((x) => x !== null && !x.startsWith("500"))}`);
  await sleep(200);
  mx = Math.max(mx, snap("died"));
  // (c) スリープしたままServeの期限で捨てられる
  const ls = Array.from({ length: 6 }, () => new Conn(port));
  await Promise.all(ls.map((c) => c.get("/ok")));
  for (const c of ls) void c.get("/sleep/60000");
  await sleep(300);
  mx = Math.max(mx, snap("long-wait"));
  await until(() => /^drained/m.test(out), 20000, "drained");
  await sleep(300);
  mx = Math.max(mx, snap("discarded"));
  for (const c of [...cs, ...ps, ...ls]) c.s.destroy();
  const code = await exited;
  const af = /area_far=(\d+)/.exec(err);
  if (code !== 0) bad(`server exit ${code} (${err.slice(0, 200)})`);
  console.log(`areacheck-ok swapped-max ${mx} shallow-max ${smx} area_far ${af ? af[1] : "none"} parkswap ${swaps} awin ${awMax} deepwin ${pdw}`);
  process.exit(0);
}
main();
