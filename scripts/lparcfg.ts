// lparcfg.ts（段階4 後半 ラウンド 9: 移し器のlParCfgの棚卸しの検査）: lowerの束（B1 = optimizeSsa・B2 = 展開の後のcfgClean〜cmpDup）の
// 関数ごとの入口から呼び出しの閉包をとり、閉包の関数が読み書きするStのフィールド（`st.〈欄〉`）を列挙して許しの表（下のALLOW）と照合する。
// 群の子へ束を配るとき、子のStにコピーするのは許しの表のフィールドだけ — 表の外のフィールドを新しく読むと子では空の値を読む（黙って変わる）ので、ここで落とす。
// 閉包は字句の近似（`名前(` の呼び出しを lower の関数の定義に引き当てる — 関数値の呼び出し・別 package の関数は辿らない）。
// 段階3 R3（後段の関数キャッシュ — report-1194 4 節2）: x86の群の子が読める外の値 = cfgの列（xParCfg — β の鍵に入る）+ 扉（xAddr = 番地取りのフラグ・
// hf = ヒープの読みインターフェースxg）だけであること・キャッシュする単位（束の子の入口・xFunc・cutFunc）の閉包が環境変数を読まないこと（開発のオプションはcfgに上げる）も落とす。
// 扉の監査（SOBER_CACHE_VERIFY=2 — bcache.sober の bcAud*）の記録の関数は `if st.bcAud {` の下だけで呼ぶこと（監査は束・群の子を外し凍結もしない —
// 子と凍結の後の閉包からは外して数える）。
//   node scripts/lparcfg.ts [-v]   （-v = フィールドごとに読む関数を出す）。fail = 0がゲート
import { readFileSync, readdirSync } from "fs";

const DIR = new URL("../src/compiler/lower/", import.meta.url).pathname;
// 関数ごとの入口（群の子の束の列 lB1Func / lB2Func — move.sober — と、〜Module が関数ごとに呼ぶもの）
const ENTRIES = ["optFunc", "lB1Func", "lB2Func", "sroaFunc", "m2rFunc", "gvnFunc", "hdrFunc", "bceFunc", "licmFunc", "depthFlowFunc", "cfgCleanFunc", "mfFunc", "vecFunc", "slpFunc", "cmpDupFunc"];
// 子のStにコピーしてよいフィールド（読みの種類: cfg = 親の値をコピーする・work = 子では空から〔作業域〕・fn = 子では渡した関数・tbl = kindsInitが組む・
// ro = 子では既定〔偽 / 空〕のまま — x86の読みインターフェースxgはxroが偽ならヒープst.d.hを読む）
const ALLOW: Record<string, string> = {
  fn: "fn",
  rtPanic: "cfg", rtPanicMem: "cfg", rtMapfind: "cfg", mapFinds: "cfg", rtRenterL: "cfg", rtRenterLL: "cfg",
  d: "work",   // ヒープ（st.d.h — 子では詰めた形を積んだ自前のヒープ）
  optw: "work", optb: "work", dcew: "work", dceN: "work",
  opk: "tbl", tmk: "tbl",
  hfOn: "ro", hf: "ro",   // x86の読みインターフェースxg — 束の子では既定の偽（ヒープを読む）
  noVec: "cfg",
  taskUse: "cfg",   // SLP（slp.sober）を task のプログラムで外す — lParCfg の 5 番の bit 1
  winOn: "cfg",     // ウィンドウを組むか — 展開の予算の確保の重み（unroll.soberのUR_RALLOCW）— lParCfgの5番のbit 2
  areaOn: "cfg",    // 接続のtaskのスタックの形を組むか — 子の本体の入口のフラグ（lower.sober funcBody）— lParCfgの5番のbit 3
  ubCheck: "cfg", ubBound: "cfg",
  rtGrow: "cfg", rtGrow8: "cfg", rtRalloc: "cfg", rtAlloc8: "cfg",
  meta: "cfg",
  rtMatchLen: "cfg", rtJClean: "cfg",   // 展開後のフィールドの読みの巻き上げ（ldhoist.sober — ループの中で許す読むだけのrt）・lParCfgの15 / 16番
  rtStreq: "cfg",   // コピーの転送（cpfwd.sober — 読むだけのrt.str_eq）   // 展開後の上限の巻き上げ（rlim.sober — 種の番地 @rt.meta）   // ヘッダのループ昇格（hloop.sober — 許すrtの呼び出し・確保の根）   // UTF-8の境界の畳み（ubf.sober — Checkの呼び出しの点・boundaryのコピーのフラグの有無）
  lkid: "kid", lret: "kid",   // 群の子のフラグと呼び先の戻りの型の表（lFnRet — move.sober）
  bcAud: "ro",   // 扉の監査のフラグ（子では既定の偽 — 監査は束を回さない: lParOn）
};
// 扉の監査の記録の関数（`if st.bcAud {` の下だけで呼ぶ — 下の照合。閉包はここで止める）
const AUD = new Set(["bcAudRet", "bcAudHeap", "bcAudAddr", "bcAudReport"]);

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
function closure(entries: string[], stop0: Set<string> = new Set()): Set<string> {
  const stop = new Set([...stop0, ...AUD]);
  const seen = new Set<string>();
  const work = [...entries];
  while (work.length) {
    const n = work.pop()!;
    if (seen.has(n) || !fns.has(n)) continue;
    seen.add(n);
    if (stop.has(n)) { if (AUD.has(n)) seen.delete(n); continue; }
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
// xが自分の関数（f・st.fn・g = 引数）のものは除けないので、字句で見える候補を全部出して許しの表（FNREAD — 読み方を確認した箇所）と照合する
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
// 関数の記録のフィールドの読み（自分の関数・外の関数とも — 子へ配るとき子のヒープに組む関数の記録のフィールド）
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
// x86の段階の凍結の後（xModuleFrozen）の閉包がヒープを凍結の読みインターフェース（xg）以外で触る箇所 — 0であること（凍結のインターフェース — 仮決定2026-10-07夜間・
// 凍結の後のヒープは空の表 — 読めば添字の範囲外で落ち、積めば凍らせた表に届かず黙って食い違う）
{
  const xs = closure(["xModuleFrozen"], new Set(["xg"]));
  if (!fns.has("xModuleFrozen")) { console.log("FAIL: xModuleFrozen is not defined in src/compiler/lower"); heapFail += 1; }
  for (const n of [...xs].sort()) {
    const b = fns.get(n)!.body;
    const hits = [...b.matchAll(/\b(hget|hset|hpush|hlen|recN|listN|rec4|list[0-9]|dat|hgetS|hgetN|hgetL)\(|st\.d\.h\b|st\.d\b/g)].map(m => m[0]);
    if (hits.length && n !== "xg") { console.log(`FAIL heap-touch after the freeze ${fns.get(n)!.file}:${n}: ${[...new Set(hits)].join(" ")}`); heapFail += 1; }
    // 読みインターフェースxgは凍結の前の分岐でdesugar.HeapGet(mut st.d, …) を呼ぶ（フィールドの私有 — language.md 20 節。分岐はst.hfOnで凍結の後には通らない）
    // loader.Stage（ステージのフラグ — report-1184）は環境変数を読んで標準エラーへ書くだけでヒープに触らないので許す・loader.Varints（格納場所の値の
    // 符号化のインターフェース — 段階3' R1・report-1236）はワードの列を受けてバイト列を返す純関数（Stもヒープも受けない）なので許す
    const ext = n === "xg" ? [] : [...b.matchAll(/\b(desugar|loader|ast)\.[A-Za-z_]+\(/g)].map(m => m[0]).filter(c => c !== "loader.Stage(" && c !== "loader.Varints(");
    if (ext.length) { console.log(`FAIL ext-call after the freeze ${fns.get(n)!.file}:${n}: ${[...new Set(ext)].join(" ")}`); heapFail += 1; }
  }
  if (verbose) console.log(`xModuleFrozen closure: ${xs.size} functions`);
  frozenN = xs.size;
}
fail += heapFail;
// x86の群の子（xParGroup — 関数ごとのxFuncを並列に吐く）: xFuncの閉包（読みインターフェースxgで止める）が読むStのフィールドが、xParGroupが子のStに
// コピーするフィールド（`st.〈欄〉 =`）に入っていること。外のフィールドは子ではSt{} の既定値を読み、W1とELFが黙って食い違う（呼び出し規約の段階1 / 2 — rt.panicのフィールドが
// コピーされず、群の中だけpanicのcallを見分けられなかった2026-10-10）
let x86Fields = 0;
{
  if (!fns.has("xParGroup")) { console.log("FAIL: xParGroup is not defined in src/compiler/lower"); fail += 1; }
  else {
    const set = new Set([...fns.get("xParGroup")!.body.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*) =/g)].map(m => m[1]));
    const xs = closure(["xFunc"], new Set(["xg"]));
    const xf = new Map<string, Set<string>>();
    for (const n of xs) for (const m of fns.get(n)!.body.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*)/g)) {
      // 読みインターフェースxgのst.dは凍結の前の分岐だけ（群の子は凍結の後 — st.hfを読む）
      if (n === "xg" && m[1] === "d") continue;
      if (!xf.has(m[1])) xf.set(m[1], new Set());
      xf.get(m[1])!.add(n);
    }
    // 子では既定値のまま読んでよいフィールド（扉の監査のフラグ — 監査は群の子を外す: xParEmitの呼び手のseq）
    const XRO = new Set(["bcAud"]);
    for (const [k, users] of [...xf].sort()) {
      const ok = set.has(k) || XRO.has(k);
      if (!ok) fail += 1;
      if (!ok || verbose) console.log(`${ok ? "ok  " : "FAIL"} x86 group st.${k} (${ok ? "set by xParGroup" : "not copied by xParGroup"}): ${[...users].sort().join(" ")}`);
    }
    x86Fields = xf.size;
    // 子のStにコピーするフィールドの出所 = cfgの列（xParCfg — β の鍵のx86のcfg）か扉（下のDOOR）。外の値を新しくコピーするならcfgに足す（鍵に入る）
    // xXmm は子の作業域（0 から積んで結果で返す — 外の値ではない）
    // memFr も子の作業域（--mem-report のフレーム — 空から積んで XPar.frs で返す）
    const DOOR: Record<string, RegExp> = { hf: /^hf$/, hfOn: /^true$/, xAddr: /^addr$/, xXmm: /^(0|all)$/, memFr: /^table\.Table\[int\]\{\}$/ };
    const pg = fns.get("xParGroup")!.body;
    const pc = fns.get("xParCfg");
    // 要素の数 = `return []int{…}` の一番外の括弧の中のカンマ + 1（SOBER_XDBG の値を後ろへ足す包み `return xdbgCfg([]int{…}, …)` も同じ — 足す分は
    // 末尾のワード〔値の長さ〕で決まり、読み手はcfg[末尾のワード] を経て読む）
    let ncfg = 0;
    if (pc) {
      const hm = pc.body.match(/return (?:xdbgCfg\()?\[\]int\{/);
      const at = hm ? hm.index! : -1;
      if (at >= 0) {
        let d = 0, n = 1;
        for (const ch of pc.body.slice(at + hm![0].length)) {
          if ("([{".includes(ch)) d += 1;
          else if (")]}".includes(ch)) { if (d === 0) break; d -= 1; }
          else if (ch === "," && d === 0) n += 1;
        }
        ncfg = n;
      }
    }
    if (!pc || ncfg === 0) { console.log("FAIL: xParCfg is not a single []int{…} list"); fail += 1; }
    for (const m of pg.matchAll(/\bst\.([A-Za-z_][A-Za-z0-9_]*) = ([^\n]*)/g)) {
      const rhs = m[2].trim();
      const ks = [...rhs.matchAll(/\bcfg\[(\d+)\]/g)].map(x => +x[1]);
      const ok = ks.length > 0 ? ks.every(k => k < ncfg) : (DOOR[m[1]]?.test(rhs) ?? false);
      if (!ok) fail += 1;
      if (!ok || verbose) console.log(`${ok ? "ok  " : "FAIL"} x86 group st.${m[1]} = ${rhs} (${ks.length ? "cfg" : DOOR[m[1]] ? "door" : "not from xParCfg or a door"})`);
    }
    const xsrc = readFileSync(DIR + "x86.sober", "utf8");
    for (const need of ["cfg := xParCfg(mut st)", "ckTab(mut st, xParCfg(mut st))"]) {
      if (!xsrc.includes(need)) { console.log(`FAIL: x86.sober lost \`${need}\` (the x86 group cfg must be the keyed list)`); fail += 1; }
    }
  }
}
// キャッシュする単位の閉包が環境変数を読まない（読むならcfgに上げる — 鍵に入らない開発のオプションはstaleの穴）: os.Getenvの直の呼び出しと、
// src/compiler の他の package の Getenv を呼ぶ関数（`<package>.<関数>`）の呼び出しを落とす
let envN = 0;
{
  const CROOT = new URL("../src/compiler/", import.meta.url).pathname;
  const envFns = new Set<string>();
  const walk = (d: string) => {
    for (const e of readdirSync(d, { withFileTypes: true })) {
      if (e.isDirectory()) { walk(d + e.name + "/"); continue; }
      if (!e.name.endsWith(".sober") || e.name.endsWith("_test.sober")) continue;
      const src = readFileSync(d + e.name, "utf8");
      const pkg = d.slice(CROOT.length).replace(/\/$/, "").split("/").pop()!;
      const heads = [...src.matchAll(/^func ([A-Za-z_][A-Za-z0-9_]*)\(/gm)];
      heads.forEach((h, k) => {
        const body = src.slice(h.index!, k + 1 < heads.length ? heads[k + 1].index! : src.length).replace(/\/\/.*$/gm, "");
        if (/\bos\.Getenv\(/.test(body)) envFns.add(`${pkg}.${h[1]}`);
      });
    }
  };
  walk(CROOT);
  const units = new Set([...closure(ENTRIES), ...closure(["xFunc"], new Set(["xg"])), ...closure(["cutFunc"])]);
  for (const n of [...units].sort()) {
    const b = fns.get(n)!.body;
    const hits = [...b.matchAll(/\b(os\.Getenv|[a-z][a-z0-9]*\.[A-Za-z_][A-Za-z0-9_]*)\(/g)].map(m => m[1]).filter(c => c === "os.Getenv" || envFns.has(c));
    if (hits.length) { console.log(`FAIL env-read in a cached unit ${fns.get(n)!.file}:${n}: ${[...new Set(hits)].join(" ")}`); fail += 1; }
  }
  envN = units.size;
}
// 扉の監査の記録の関数は `if st.bcAud {` の下だけで呼ぶ（監査でない build の子・凍結の後の閉包で呼ばれない — 上の閉包はここで止めている）
for (const [n, f] of fns) {
  const lines = f.body.split("\n");
  lines.forEach((l, k) => {
    for (const m of l.matchAll(/\b(bcAud[A-Za-z]+)\(/g)) {
      if (!AUD.has(m[1]) || l.includes("func " + m[1] + "(")) continue;
      if (!/if st\.bcAud \{\s*$/.test(lines[k - 1] ?? "")) { console.log(`FAIL audit call outside \`if st.bcAud {\`: ${f.file}:${n}: ${l.trim()}`); fail += 1; }
    }
  });
}
// 関数の記録のフィールド（ir.soberのF_〈欄〉）を運ぶ箇所の照合: フィールドを足したとき、運ぶ箇所の全部に出るか、運ばない理由が下の表にあること。
// 運ぶ箇所 = 並列の受け渡し（move.sober lPack → lParGroup）・分割のパス（split.sober lsEntry → lsMkFn）・キャッシュの鍵（ckey.sober ckFact）・
// 扉の監査の許し（bcache.sober bcAudHeap — ckFactと同じフィールドの集合であること）。運び忘れると、群の子や分割の子で呼ぶ関数のフィールドが初期値になり、
// 1本の経路とELFが割れる（selfparが事後に見つける — P7のF_REFP）か、鍵に入らないフィールドをキャッシュが読む
const CARRIERS = ["lPack", "lParGroup", "lsEntry", "lsMkFn", "ckFact"];
// フィールド → { 運ぶ箇所: 運ばない理由 }（ここに無い運ぶ箇所はフィールドを明示すること — F_〈欄〉 か irFn〈欄〉 / irSetFn〈欄〉）
const BODY = "関数の本体の一部（詰めた本体 mvPack / mvUnpack が運び、呼び手からは読まない）";
const LOCAL = "印字・最適化の作業の表で、関数を越えて読まない";
const FNOTE: Record<string, Record<string, string>> = {
  NEXT: { lPack: "記録の鎖 — 子で組み直す", lParGroup: "同左", lsEntry: "同左", lsMkFn: "同左（addFunc が繋ぐ）", ckFact: "鎖の位置は鍵の外" },
  NAME: { lPack: "子では名前を使わない", lParGroup: "同左", lsMkFn: "addFunc の引数で渡す", ckFact: "鍵は関数の記録の番号で引く" },
  PTYS: { lsMkFn: "addFunc の引数で渡す", ckFact: "自分の引数の型の列は ckFn が混ぜる・他の関数の列の読みは監査のはみ出し（BA_FSIG）" },
  RET: { lsMkFn: "addFunc の引数で渡す" },
  NVAL: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  BHEAD: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  BTAIL: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  NBLK: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  SHEAD: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  STAIL: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  NSLOT: { lPack: BODY, lParGroup: BODY, lsEntry: BODY, lsMkFn: BODY, ckFact: BODY },
  EXPORT: { lPack: ".ll の印字（llvm.sober）だけが読む", lParGroup: "同左", lsEntry: "同左", lsMkFn: "同左", ckFact: "同左" },
  RFREE: { lPack: "親のモジュール単位の段（opt.sober の P0・rlight の〜Module）だけが読み書きする", lParGroup: "同左", lsEntry: "同左", lsMkFn: "同左", ckFact: "同左" },
  LLVT: { lPack: LOCAL, lParGroup: LOCAL, lsEntry: LOCAL, lsMkFn: LOCAL, ckFact: LOCAL },
  LLINC: { lPack: LOCAL, lParGroup: LOCAL, lsEntry: LOCAL, lsMkFn: LOCAL, ckFact: LOCAL },
  LLCS: { lPack: LOCAL, lParGroup: LOCAL, lsEntry: LOCAL, lsMkFn: LOCAL, ckFact: LOCAL },
};
let fieldN = 0;
{
  const ir = readFileSync(DIR + "ir.sober", "utf8");
  const F = [...ir.matchAll(/^const F_([A-Z]+) = \d+/gm)].map(m => m[1]).filter(x => x !== "SRET");
  fieldN = F.length;
  const names = (body: string, x: string) =>
    new RegExp(`\\bF_${x}\\b`).test(body) || [...body.matchAll(/\birS?e?t?Fn([A-Z][A-Za-z]*)\(/g)].some(m => m[1].toUpperCase() === x);
  for (const x of F) {
    const note = FNOTE[x] ?? {};
    for (const c of CARRIERS) {
      if (!fns.has(c)) { console.log(`FAIL: carrier ${c} is not defined in src/compiler/lower`); fail += 1; continue; }
      const has = names(fns.get(c)!.body, x);
      if (!has && !(c in note)) { console.log(`FAIL record field F_${x} is not carried by ${fns.get(c)!.file}:${c} (carry it, or give the reason in FNOTE)`); fail += 1; }
      if (has && c in note) { console.log(`FAIL record field F_${x} is carried by ${fns.get(c)!.file}:${c} but FNOTE says it is not (${note[c]})`); fail += 1; }
    }
  }
  for (const x of Object.keys(FNOTE)) if (!F.includes(x)) { console.log(`FAIL: FNOTE names F_${x}, which ir.sober does not define`); fail += 1; }
  // 扉の監査の許し（bcAudHeap の `i - g == F_〈欄〉`）≡ 鍵に入れた記録の事実（ckFact）
  const allow = new Set([...(fns.get("bcAudHeap")?.body ?? "").matchAll(/i - g == F_([A-Z]+)/g)].map(m => m[1]));
  const keyed = new Set(F.filter(x => names(fns.get("ckFact")?.body ?? "", x)));
  for (const x of keyed) if (!allow.has(x)) { console.log(`FAIL record field F_${x} is in the cache key (ckFact) but not in the audit allow list (bcache.sober bcAudHeap)`); fail += 1; }
  for (const x of allow) if (!keyed.has(x)) { console.log(`FAIL record field F_${x} is in the audit allow list (bcAudHeap) but not in the cache key (ckFact)`); fail += 1; }
}
console.log(`lparcfg: ${seen.size} functions reachable from ${ENTRIES.length} entries, ${fields.size} St fields; ${frozenN} functions after the heap freeze (xModuleFrozen); ${x86Fields} St fields read by the x86 group (xFunc); ${envN} functions in the cached units without env reads; ${fieldN} record fields × ${CARRIERS.length} carriers, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
