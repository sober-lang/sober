// areacheck.ts <srv> <syms> — 接続の task の区画の保存則の網（scripts/areacheck.sh から）。
// srv（testdata/areacheck/srv.sober の ELF）を子で起こし（/proc/pid/mem を読むため — ptrace_scope=1 は子孫だけ）、接続の task に 4 つの道
// （普通に返る・深い待ちの後に返る・panic で死ぬ・Serve の期限で寝たまま捨てられる）を踏ませ、相ごとに静まった所で全塊の TC_AREA と
// 全ワーカーの WK_AREA（rt.mn の MN_WK の列から — syms の `=rt.mn` 行）を読む。保存則 = 持ち札の多重集合が「塊の積みの領域の頂上
// （塊の頁 0 の底）の全部 ∪ ワーカーの区画〔ガードの上の 1 MiB の写像〕の全部」とちょうど一致（数 = 塊の数 + W・重複なし・持ち主のない区画なし）。
// 定数は src/compiler/lower の const から引く。印字: 相ごとに 1 行・最後に "areacheck-ok <交換済みの塊の最大> <浅く寝ている塊の最大>" か "areacheck-bad <理由>"
import * as net from "node:net";
import * as fs from "node:fs";
import { spawn } from "node:child_process";

const [srv, symf] = process.argv.slice(2);
const W = +(process.env.AC_WORKERS ?? "2");
// AC_FAR=1: 本体の太い形（srv の argv[3] = far — 遠い道）。AC_REF=1: 区画を使わない ELF（変異 66 — 段 1 の前の積みの形）— 保存則は見ず署名だけ
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
// 区画の窓（task.sober）: 欄 r の WSP_AREA・深度 BASE + 1 + r の退避の対（TC_SAVE + 2k = 表の基底〔窓の偽の基底〕・+1 = bump）
const TC_WSP = cval("TC_WSP"), TC_SAVE = cval("TC_SAVE"), TC_BASE = cval("TC_BASE"), TC_SLOTSZ = cval("TC_SLOTSZ");
const WSP_AREA = cval("WSP_AREA"), WIN_N = cval("WIN_N"), WIN_SZ = cval("WIN_SZ");
const MN_N = cval("MN_N"), MN_WK = cval("MN_WK"), WK_AREA = cval("WK_AREA");
const mnLine = fs.readFileSync(symf, "utf8").split("\n").find((l) => l.endsWith(" =rt.mn"));
if (!mnLine) { console.log("areacheck-bad no =rt.mn line in syms (SOBER_SYMS_MN=1)"); process.exit(1); }
const MN = parseInt(mnLine.split(" ")[0], 16);
// 浅く寝ている塊の数の相ごとの最大（TC_ONW の AREA_SPARK — 受けで寝る接続）
let smx = 0;
// 区画の窓の深度を見た数の相ごとの最大（0 なら区画の窓が使われていない）
let awMax = 0;
// 機械語の範囲（浅い待ちの記し — TCB の語 0 に本体の戻り先が残る: 浅く寝ている塊と、記して普通に返った塊）
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

// 静まった所の持ち札を読んで保存則を見る → 交換済み（持ち札が自分の領域でない）塊の数
function snap(tag: string): number {
  const maps = fs.readFileSync(`/proc/${pid}/maps`, "utf8").split("\n").map((l) => /^([0-9a-f]+)-([0-9a-f]+) (\S+)/.exec(l)).filter((m) => m !== null)
    .map((m) => ({ s: parseInt(m![1], 16), e: parseInt(m![2], 16), perm: m![3] }));
  const chunkTops: number[] = [], wkTops: number[] = [], cands: number[] = [];
  maps.forEach((m, i) => {
    if (m.perm !== "rw-p") return;
    const guarded = i > 0 && maps[i - 1].e === m.s && maps[i - 1].perm === "---p" && maps[i - 1].e - maps[i - 1].s === GUARD;
    if (!guarded) return;
    // 塊とワーカーの区画は同じ並び（区画の窓が頂上 + AWIN_OFF に来る）— 頁 0 の TCB の入口の語で分ける（ワーカーの区画の頁 0 は触らない）
    if (m.e - m.s === STACK + 4096 + HEAD) cands.push(m.s + STACK);
    else if (m.e - m.s === STACK) wkTops.push(m.e);
  });
  const mem = fs.openSync(`/proc/${pid}/mem`, "r"), pm = fs.openSync(`/proc/${pid}/pagemap`, "r");
  const word = (a: number) => { const b = Buffer.alloc(8); fs.readSync(mem, b, 0, 8, a); return Number(b.readBigUInt64LE(0)); };
  for (const h of cands) { if (word(h + ROOM + 8 * TC_ENTRY) !== 0) chunkTops.push(h); else wkTops.push(h); }
  // 署名: 寝ている塊ごとの「積みの深さ（TCB − 退避 rsp）: 常駐の頁（頁 0 からの相対 −4〜10）」の多重集合 — 寝ている接続の積みの形
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
    // 退避 rsp（TCB の語 0 — 止まった / 終わった task が最後に積みを離れた点）は持つ区画の中。自分の領域を持つときだけ頁 0 も
    // （連続の形 — 頁 0 から下へ続く）。本体の後に持つ区画へ戻らない終わりの道は、交換で他人の持ち物になった頁 0 で止まる
    if (word(h + ROOM + 8 * TC_ONW) & SPARK) shallow++;
    const w0 = word(h + ROOM);
    const rsp = w0 <= codeHi ? 0 : w0;
    const inArea = rsp >= a - STACK && rsp < a, onPage0 = a === h && rsp >= h && rsp < h + ROOM;
    // 頁 0 より 512 B 以上深く止まっている塊（寝ている接続 — 終わった塊は出口形で区画の頂上のすぐ下に止まる）
    if (rsp !== 0 && h + ROOM - rsp >= ROOM + 512) { const k = `${h + ROOM - rsp}:${pages(h)}`; sig.set(k, (sig.get(k) ?? 0) + 1); }
    if (rsp !== 0 && !inArea && !onPage0) strays.push(`${h.toString(16)}:rsp ${rsp.toString(16)} area ${a.toString(16)}`);
    // 区画の窓の不変条件: 浅く寝ている task の窓の深度は全部空（深く寝ている task の窓の中身が守られることは /hold の答えが見る）
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

// keep-alive の接続 1 本（要求 → 応答の本文〔Content-Length〕・閉じられたら null）
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
    return new Promise((r) => { this.wait = r; this.s.write(`GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`); });
  }
  // 要求を cut バイトで割って送る（前半を送った後 ms 待って後半 — 受けの region に途中の要求を持ったまま待つ）
  split(path: string, cut: number, ms: number): Promise<string | null> {
    const q = `GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`;
    return new Promise((r) => { this.wait = r; this.s.write(q.slice(0, cut)); setTimeout(() => this.s.write(q.slice(cut)), ms); });
  }
}

async function main() {
  await until(() => /^ready \d+/m.test(out), 5000, "ready");
  const port = +/^ready (\d+)/m.exec(out)![1];
  const N = 16, ROUNDS = 3;
  const cs = Array.from({ length: N }, () => new Conn(port));
  // (a) 普通に返る（keep-alive の要求 → 接続の task は受けの深い待ちで止まる）
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
  // (d) 深い待ちの後に返る（待ちの最中と後）
  const sl = Promise.all(cs.slice(0, 8).map((c) => c.get("/sleep/800")));
  await sleep(300);
  mx = Math.max(mx, snap("deep-wait"));
  const rs = await sl;
  if (rs.some((x) => x !== "200 800")) bad(`/sleep/800 answered ${rs.find((x) => x !== "200 800")}`);
  const r2 = await Promise.all(cs.map((c) => c.get("/ok")));
  if (r2.some((x) => x !== "200 ok")) bad(`/ok after the sleep answered ${r2.find((x) => x !== "200 ok")}`);
  await sleep(200);
  mx = Math.max(mx, snap("after-deep-wait"));
  // 深い待ちの後の受けは持ち札とワーカーの区画を交換してから浅く寝る（Ledger の parkSwap）
  const led = await cs[0].get("/ledger");
  const swaps = +(/parkSwap=(\d+)/.exec(led ?? "")?.[1] ?? "-1");
  if (swaps < 0) bad(`/ledger answered ${led}`);
  // もう一度深い待ち（交換して浅く寝た接続がワーカーの区画の上で寝る — 退避 rsp は持つ区画の中）
  const sl2 = Promise.all(cs.slice(0, 8).map((c) => c.get("/sleep/600")));
  await sleep(300);
  mx = Math.max(mx, snap("deep-again"));
  const rs2 = await sl2;
  if (rs2.some((x) => x !== "200 600")) bad(`/sleep/600 answered ${rs2.find((x) => x !== "200 600")}`);
  // (e) 区画の窓: 深く寝る接続（/hold — 受けの region の中身 = path を持って寝る）と、浅く寝て起きる接続（/ok の連打 — 起きた点で
  // ワーカーの区画が替わっていれば窓の深度を付け替える）が同じワーカーで混ざる。寝ていた側の path が答えにそのまま返る
  const hold = Promise.all(cs.slice(0, 6).map((c, i) => c.get(`/hold/400/h${i}x${"y".repeat(40 * i)}`)));
  for (let r = 0; r < 12; r++) {
    const ro = await Promise.all(cs.slice(6, 12).map((c) => c.get("/ok")));
    if (ro.some((x) => x !== "200 ok")) bad(`/ok beside /hold answered ${ro.find((x) => x !== "200 ok")}`);
  }
  const hr = await hold;
  hr.forEach((x, i) => { if (x !== `200 /hold/400/h${i}x${"y".repeat(40 * i)}`) bad(`/hold answered ${x} (area window content lost while sleeping deep)`); });
  // (g) 窓から小さいスロットへ移った深度（大きい本文）は、要求の後で空なら浅く寝る — parkDeepWin が増えない
  const pdw0 = +(/parkDeepWin=(\d+)/.exec((await cs[0].get("/ledger")) ?? "")?.[1] ?? "-1");
  for (let r = 0; r < 5; r++) {
    const rb = await Promise.all(cs.slice(0, 6).map((c) => c.get("/big/9000")));
    if (rb.some((x) => x === null || x.length !== 4 + 9000)) bad(`/big/9000 answered ${rb.find((x) => x === null || x.length !== 4 + 9000)?.slice(0, 40)}`);
  }
  const pdw1 = +(/parkDeepWin=(\d+)/.exec((await cs[0].get("/ledger")) ?? "")?.[1] ?? "-1");
  if (pdw1 !== pdw0) bad(`parkDeepWin ${pdw0} → ${pdw1} over /big — a depth moved out of the area window parked deep while empty`);
  // (f) 途中の要求を受けの region に持ったまま待つ接続（区画の窓の深度に中身 — 浅く寝ず深く寝る: Ledger の parkDeepWin）。待っている間に
  // 同じワーカーで /ok を連打して、その窓を次の task が使う
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
  // (b) panic で死ぬ（区画の上の積みで死んで罠へ戻る）
  const ps = Array.from({ length: 6 }, () => new Conn(port));
  await Promise.all(ps.map((c) => c.get("/ok")));
  const pr = await Promise.all(ps.map((c) => c.get("/panic")));
  if (pr.some((x) => x !== null && !x.startsWith("500"))) bad(`/panic answered ${pr.find((x) => x !== null && !x.startsWith("500"))}`);
  await sleep(200);
  mx = Math.max(mx, snap("died"));
  // (c) 寝たまま Serve の期限で捨てられる
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
