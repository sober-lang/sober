// lparcfg.ts（段 4 後半 ラウンド 9: 移し器の lParCfg の棚卸しの網）: lower の束（B1 = optimizeSsa・B2 = 展開の後の cfgClean〜cmpDup）の
// 関数ごとの入口から呼び出しの閉包をとり、閉包の関数が読み書きする St の欄（`st.〈欄〉`）を列挙して許しの表（下の ALLOW）と照合する。
// 群の子へ束を配るとき、子の St に写すのは許しの表の欄だけ — 表の外の欄を新しく読むと子では空の値を読む（黙って変わる）ので、ここで落とす。
// 閉包は字句の近似（`名前(` の呼び出しを lower の関数の定義に引き当てる — 関数値の呼び出し・別 package の関数は辿らない）。
//   node scripts/lparcfg.ts [-v]   （-v = 欄ごとに読む関数を出す）。fail = 0 がゲート
import { readFileSync, readdirSync } from "fs";

const DIR = new URL("../src/compiler/lower/", import.meta.url).pathname;
// 関数ごとの入口（群の子の束の列 lB1Func / lB2Func — move.sober — と、〜Module が関数ごとに呼ぶもの）
const ENTRIES = ["lB1Func", "lB2Func", "sroaFunc", "m2rFunc", "gvnFunc", "hdrFunc", "bceFunc", "licmFunc", "depthFlowFunc", "cfgCleanFunc", "mfFunc", "vecFunc", "cmpDupFunc"];
// 子の St に写してよい欄（読みの種類: cfg = 親の値を写す・work = 子では空から〔作業域〕・fn = 子では渡した関数・tbl = kindsInit が組む・
// ro = 子では既定〔偽 / 空〕のまま — x86 の読み口 xg は xro が偽ならヒープ st.d.h を読む）
const ALLOW: Record<string, string> = {
  fn: "fn",
  rtPanic: "cfg", rtPanicMem: "cfg", rtMapfind: "cfg", mapFinds: "cfg", rtRenterL: "cfg", rtRenterLL: "cfg",
  d: "work",   // ヒープ（st.d.h — 子では詰めた形を積んだ自前のヒープ）
  optw: "work", optb: "work", dcew: "work", dceN: "work",
  opk: "tbl", tmk: "tbl",
  hfOn: "ro", hf: "ro",   // x86 の読み口 xg — 束の子では既定の偽（ヒープを読む）
  noVec: "cfg",
  ubCheck: "cfg", ubBound: "cfg",   // UTF-8 の境界の畳み（ubf.sober — Check の呼び出しの点・boundary の写しの印の有無）
  lkid: "kid", lret: "kid",   // 群の子の印と呼び先の戻りの型の表（lFnRet — move.sober）
};

type Fn = { name: string; file: string; body: string };
const fns = new Map<string, Fn>();
for (const f of readdirSync(DIR)) {
  if (!f.endsWith(".sober") || f.endsWith("_test.sober")) continue;
  const src = readFileSync(DIR + f, "utf8");
  const re = /^func ([A-Za-z_][A-Za-z0-9_]*)\(/gm;
  const heads: [string, number][] = [];
  for (let m; (m = re.exec(src)); ) heads.push([m[1], m.index]);
  heads.forEach(([n, at], k) => {
    const end = k + 1 < heads.length ? heads[k + 1][1] : src.length;
    fns.set(n, { name: n, file: f, body: src.slice(at, end).replace(/\/\/.*$/gm, "") });
  });
}
function closure(entries: string[], stop: Set<string> = new Set()): Set<string> {
  const seen = new Set<string>();
  const work = [...entries];
  while (work.length) {
    const n = work.pop()!;
    if (seen.has(n) || !fns.has(n)) continue;
    seen.add(n);
    if (stop.has(n)) continue;
    for (const m of fns.get(n)!.body.matchAll(/([A-Za-z_][A-Za-z0-9_]*)\(/g)) {
      if (m[1] !== n && fns.has(m[1]) && !seen.has(m[1])) work.push(m[1]);
    }
  }
  return seen;
}
const seen = closure(ENTRIES);
const missing = ENTRIES.filter(e => !fns.has(e));
const verbose = process.argv.includes("-v");
const fields = new Map<string, Set<string>>();
for (const n of seen) {
  for (const m of fns.get(n)!.body.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*)/g)) {
    if (!fields.has(m[1])) fields.set(m[1], new Set());
    fields.get(m[1])!.add(n);
  }
}
// 外の関数の記録を読む候補（子のヒープには渡した関数の記録しかない）: 閉包の中の `irFn〈欄〉(mut st, x)` / `irInsFn` の結果を関数の記録として読む形。
// x が自分の関数（f・st.fn・g = 引数）のものは除けないので、字句で見える候補を全部出して許しの表（FNREAD — 読み方を確かめた箇所）と照合する
const FNREAD = new Set<string>([
  // m2r / gvn / 検証器の値の型: 呼び出しの結果の型を呼び先の F_RET から読む — 群の子は親の表 st.lret から（lFnRet の !st.lkid の枝だけがヒープを読む）
  "lFnRet: irFnRet(g)",
]);
const fnReads: string[] = [];
for (const n of seen) {
  for (const m of fns.get(n)!.body.matchAll(/\b(irFn[A-Za-z]+)\(mut st, ([^)]*)\)/g)) {
    if (m[1] === "irFnNext") continue;
    const arg = m[2].trim();
    if (arg === "f" || arg === "st.fn") continue;
    fnReads.push(`${n}: ${m[1]}(${arg})`);
  }
}
// 関数の記録の欄の読み（自分の関数・外の関数とも — 子へ配るとき子のヒープに組む関数の記録の欄）
const fnFields = new Map<string, Set<string>>();
for (const n of seen) {
  for (const m of fns.get(n)!.body.matchAll(/\b(?:irFn|irSetFn|xf)([A-Z][A-Za-z]*)\(/g)) {
    if (!fnFields.has(m[1])) fnFields.set(m[1], new Set());
    fnFields.get(m[1])!.add(n);
  }
  for (const m of fns.get(n)!.body.matchAll(/\b(F_[A-Z]+)\b/g)) {
    if (!fnFields.has(m[1])) fnFields.set(m[1], new Set());
    fnFields.get(m[1])!.add(n);
  }
}
if (process.argv.includes("-f")) for (const [k, u] of [...fnFields].sort()) console.log(`fn-field ${k}: ${[...u].sort().join(" ")}`);
let heapFail = 0;
let frozenN = 0;
let fail = missing.length;
for (const r of fnReads) {
  const ok = FNREAD.has(r);
  if (!ok) fail += 1;
  if (!ok || verbose) console.log(`${ok ? "ok  " : "FAIL"} reads another function's record? ${r}`);
}
for (const e of missing) console.log(`FAIL: entry ${e} is not defined in src/compiler/lower`);
for (const [k, users] of [...fields].sort()) {
  const ok = k in ALLOW;
  if (!ok) fail += 1;
  if (!ok || verbose) console.log(`${ok ? "ok  " : "FAIL"} st.${k} (${ok ? ALLOW[k] : "not in lParCfg"}): ${[...users].sort().join(" ")}`);
}
// x86 の段の凍結の後（xModuleFrozen）の閉包がヒープを凍結の読み口（xg）以外で触る箇所 — 0 であること（凍結の口 — 仮裁定 2026-10-07 夜間・
// 凍結の後のヒープは空の表 — 読めば添字の範囲外で落ち、積めば凍らせた表に届かず黙って食い違う）
{
  const xs = closure(["xModuleFrozen"], new Set(["xg"]));
  if (!fns.has("xModuleFrozen")) { console.log("FAIL: xModuleFrozen is not defined in src/compiler/lower"); heapFail += 1; }
  for (const n of [...xs].sort()) {
    const b = fns.get(n)!.body;
    const hits = [...b.matchAll(/\b(hget|hset|hpush|hlen|recN|listN|rec4|list[0-9]|dat|hgetS|hgetN|hgetL)\(|st\.d\.h\b|st\.d\b/g)].map(m => m[0]);
    if (hits.length && n !== "xg") { console.log(`FAIL heap-touch after the freeze ${fns.get(n)!.file}:${n}: ${[...new Set(hits)].join(" ")}`); heapFail += 1; }
    const ext = [...b.matchAll(/\b(desugar|loader|ast)\.[A-Za-z_]+\(/g)].map(m => m[0]);
    if (ext.length) { console.log(`FAIL ext-call after the freeze ${fns.get(n)!.file}:${n}: ${[...new Set(ext)].join(" ")}`); heapFail += 1; }
  }
  if (verbose) console.log(`xModuleFrozen closure: ${xs.size} functions`);
  frozenN = xs.size;
}
fail += heapFail;
// x86 の群の子（xParGroup — 関数ごとの xFunc を並列に吐く）: xFunc の閉包（読み口 xg で止める）が読む St の欄が、xParGroup が子の St に
// 写す欄（`st.〈欄〉 =`）に入っていること。外の欄は子では St{} の既定値を読み、W1 と ELF が黙って食い違う（呼び出し規約の段 1 / 2 — rt.panic の欄が
// 写されず、群の中だけ panic の call を見分けられなかった 2026-10-10）
let x86Fields = 0;
{
  if (!fns.has("xParGroup")) { console.log("FAIL: xParGroup is not defined in src/compiler/lower"); fail += 1; }
  else {
    const set = new Set([...fns.get("xParGroup")!.body.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*) =/g)].map(m => m[1]));
    const xs = closure(["xFunc"], new Set(["xg"]));
    const xf = new Map<string, Set<string>>();
    for (const n of xs) for (const m of fns.get(n)!.body.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*)/g)) {
      if (!xf.has(m[1])) xf.set(m[1], new Set());
      xf.get(m[1])!.add(n);
    }
    for (const [k, users] of [...xf].sort()) {
      const ok = set.has(k);
      if (!ok) fail += 1;
      if (!ok || verbose) console.log(`${ok ? "ok  " : "FAIL"} x86 group st.${k} (${ok ? "set by xParGroup" : "not copied by xParGroup"}): ${[...users].sort().join(" ")}`);
    }
    x86Fields = xf.size;
  }
}
console.log(`lparcfg: ${seen.size} functions reachable from ${ENTRIES.length} entries, ${fields.size} St fields; ${frozenN} functions after the heap freeze (xModuleFrozen); ${x86Fields} St fields read by the x86 group (xFunc), fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
