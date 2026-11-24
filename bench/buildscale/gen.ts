// 同じ構造のプログラムを Sober・Go・Rust の3つの言語で出す生成器。
// 使い方: node gen.ts --fns <関数の数> --out <dir> [--seed N] [--generic X] [--lang sober,go,rust]
//   --fns      構造の単位（総称関数を含む関数の数）。行数はおよそ fns × 21（Sober）
//   --generic  総称関数の割合の倍率（既定1 = 下のGENERIC_FRAC）
// 出力: <dir>/sober/{mNNN/*.sober,app/main.sober}・<dir>/go/{go.mod,mNNN/*.go,app/main.go}・
//       <dir>/rust/{Cargo.toml,mNNN/{Cargo.toml,src/*.rs},app/{Cargo.toml,src/main.rs}}・<dir>/stats.json
// パラメータの根拠は README.md（src/compilerの実測）
import { mkdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";

// ---- パラメータ（src/compiler の実測から。README.md） ----
const FNS_PER_MODULE = 200; // 5,891関数 / 30 package
const FILES_PER_MODULE = 8; // 1 packageあたりのファイルの平均 8.07
const FN_LINES_MEDIAN = 10; // 関数の行数の中央値 10・p90 45・p99 167
const FN_LINES_SIGMA = Math.log(45 / 10) / 1.2816;
const FN_LINES_MAX = 300;
const CALLS_PER_LINE = 0.55; // 利用者の関数の呼び出し（local + 他package）/ コードの行
const XPKG_CALL_FRAC = 0.12; // 呼び出しのうち他packageへの割合
const IMPORTS_PER_MODULE = 3; // 1 packageが import するcompiler/の中のpackageの数の平均 3.13
const MAX_LAYERS = 8; // 依存の深さの最大 7
const EXPORTED_FRAC = 0.1; // 公開する関数の割合 0.101
const FNS_PER_TYPE = 28; // 型の宣言 213 struct / 5,891関数
const UNION_FRAC = 0.25; // 型のうちunionの割合（compiler/は0・std は 11/201。題材の網羅のため1/4にする）
const GENERIC_FRAC = 0.025; // 総称関数の割合（compiler/は 3/5,891 と少なすぎるので std の 59/2,371 を採る）

// ---- 引数 ----
const args = new Map<string, string>();
for (let i = 2; i < process.argv.length; i += 2) args.set(process.argv[i].replace(/^--/, ""), process.argv[i + 1]);
const NFNS = Number(args.get("fns") ?? "50");
const OUT = args.get("out") ?? "out";
const SEED = Number(args.get("seed") ?? "1");
const GSCALE = Number(args.get("generic") ?? "1");
const LANGS = new Set((args.get("lang") ?? "sober,go,rust").split(","));

// ---- 乱数（mulberry32 — 種が同じなら同じ出力） ----
let st = SEED >>> 0;
const rnd = () => {
  st = (st + 0x6d2b79f5) >>> 0;
  let t = st;
  t = Math.imul(t ^ (t >>> 15), t | 1);
  t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
  return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
};
const ri = (n: number) => Math.floor(rnd() * n);
const pick = <T>(xs: T[]) => xs[ri(xs.length)];
const gauss = () => Math.sqrt(-2 * Math.log(1 - rnd())) * Math.cos(2 * Math.PI * rnd());

// ---- 構造（言語に依らない中間の形） ----
type Ty = { name: string; union: boolean };
type Blk =
  | { k: "arith"; c: number }
  | { k: "branch"; c1: number; c2: number; c3: number; c4: number }
  | { k: "slice"; c: number }
  | { k: "map"; c: number }
  | { k: "call"; callee: Callee[] }
  | { k: "struct"; ty: string }
  | { k: "union"; ty: string; c: number }
  | { k: "gint"; g: string }
  | { k: "grec"; g: string; ty: string };
type Callee = { mod: number | null; name: string }; // mod = null は同じmodule
type Fn = { name: string; exported: boolean; generic: boolean; blocks: Blk[]; file: number };
type Mod = { id: number; layer: number; imports: number[]; types: Ty[]; fns: Fn[]; exported: string[]; generics: string[] };

const OTHER_LINES = 0.3 * 1 + 0.2 * 5 + 0.15 * 7 + 0.1 * 8 + 0.12 * 2 + 0.13 * 6; // 下の非呼び出しのブロックの行数の期待値
const P_CALL = (OTHER_LINES * CALLS_PER_LINE) / (2 + (OTHER_LINES - 1) * CALLS_PER_LINE);
const P_GEN = Math.min(0.3, 2 * GENERIC_FRAC * GSCALE); // 総称関数の呼び出しの頻度（総称関数の割合に比例させる）
const nmods = Math.max(2, Math.round(NFNS / FNS_PER_MODULE));
const nlayers = Math.min(MAX_LAYERS, nmods);
const mods: Mod[] = [];
for (let m = 0; m < nmods; m++) {
  // 層は下（0）から順に割り当てる。各層に少なくとも1つ
  const layer = Math.min(nlayers - 1, Math.floor((m * nlayers) / nmods));
  const lower = mods.filter((x) => x.layer < layer).map((x) => x.id);
  const imports: number[] = [];
  if (lower.length > 0) {
    // 1つは直下の層から（深さを保つ）。残りは下の層から無作為に
    const below = mods.filter((x) => x.layer === layer - 1).map((x) => x.id);
    imports.push(pick(below));
    const want = Math.min(lower.length, Math.max(1, Math.round(IMPORTS_PER_MODULE + gauss())));
    while (imports.length < want) {
      const c = pick(lower);
      if (!imports.includes(c)) imports.push(c);
    }
  }
  imports.sort((a, b) => a - b);
  mods.push({ id: m, layer, imports, types: [], fns: [], exported: [], generics: [] });
}

// 関数をmoduleに配る
const per = Math.floor(NFNS / nmods);
let rest = NFNS - per * nmods;
const mname = (m: number) => `m${String(m).padStart(3, "0")}`;
const sampleLines = () => Math.min(FN_LINES_MAX, Math.max(3, Math.round(FN_LINES_MEDIAN * Math.exp(FN_LINES_SIGMA * gauss()))));

// 1ブロックのSoberでの行数（行数の予算を配るのに使う）
const blkLines: Record<Blk["k"], number> = { arith: 1, branch: 5, slice: 7, map: 8, call: 1, struct: 2, union: 6, gint: 1, grec: 2 };

for (const md of mods) {
  const nf = per + (rest-- > 0 ? 1 : 0);
  const ntypes = Math.max(2, Math.round(nf / FNS_PER_TYPE));
  for (let t = 0; t < ntypes; t++) md.types.push({ name: `${rnd() < UNION_FRAC ? "U" : "R"}${t}`, union: false });
  for (const t of md.types) t.union = t.name.startsWith("U");
  if (!md.types.some((t) => !t.union)) md.types[0] = { name: "R0", union: false };
  const recs = md.types.filter((t) => !t.union).map((t) => t.name);
  const unions = md.types.filter((t) => t.union).map((t) => t.name);
  const ngen = Math.min(nf - 1, Math.round(nf * GENERIC_FRAC * GSCALE + rnd() - 0.5));
  const nexp = Math.max(1, Math.round((nf - ngen) * EXPORTED_FRAC));
  const nplain = nf - ngen;
  // 総称関数は先頭（呼び出しを持たない）・ふつうの関数はその後。公開する関数は末尾
  for (let g = 0; g < ngen; g++) md.generics.push(`g${g}`);
  const fname = (i: number) => (i >= nplain - nexp ? `X${i}` : `f${i}`);
  for (let i = 0; i < nplain; i++) md.exported.push(...(i >= nplain - nexp ? [fname(i)] : []));
  const mk = (name: string, generic: boolean, idx: number): Fn => {
    let budget = sampleLines() - 3; // 宣言・前置きの判定・return
    const blocks: Blk[] = [];
    if (!generic && idx > 0) {
      // すべての関数が生きているように、1つ前の関数を必ず呼ぶ
      blocks.push({ k: "call", callee: [{ mod: null, name: fname(idx - 1) }] });
      budget -= 1;
    }
    while (budget > 0) {
      const r = rnd();
      let b: Blk;
      // 呼び出しのブロックは1行で、1〜3本（平均2本）の呼び出しを持つ。ほかのブロックは平均OTHER_LINES行。
      // 呼び出しの本数 / 行 = CALLS_PER_LINE になる頻度 P_CALL を選ぶ（総称関数の呼び出しはこの外で数える）
      if (!generic && md.generics.length > 0 && r < P_GEN) {
        b = rnd() < 0.5 ? { k: "gint", g: pick(md.generics) } : { k: "grec", g: pick(md.generics), ty: pick(recs) };
      } else if (!generic && rnd() < P_CALL) {
        const callee: Callee[] = [];
        const ncalls = 1 + ri(3);
        for (let c = 0; c < ncalls; c++) {
          if (md.imports.length > 0 && rnd() < XPKG_CALL_FRAC) {
            const tm = mods[pick(md.imports)];
            callee.push({ mod: tm.id, name: pick(tm.exported) });
          } else if (idx > 0) callee.push({ mod: null, name: fname(ri(idx)) });
        }
        if (callee.length === 0) continue;
        b = { k: "call", callee };
      } else {
        const r2 = rnd();
        if (r2 < 0.3) b = { k: "arith", c: 1 + ri(997) };
        else if (r2 < 0.5) b = { k: "branch", c1: 2 + ri(97), c2: ri(50), c3: 1 + ri(997), c4: 2 + ri(29) };
        else if (r2 < 0.65) b = { k: "slice", c: 1 + ri(97) };
        else if (r2 < 0.75) b = { k: "map", c: 1 + ri(97) };
        else if (r2 < 0.87 || unions.length === 0) b = { k: "struct", ty: pick(recs) };
        else b = { k: "union", ty: pick(unions), c: 1 + ri(97) };
      }
      blocks.push(b);
      budget -= blkLines[b.k];
    }
    return { name, exported: name.startsWith("X"), generic, blocks, file: ri(FILES_PER_MODULE) };
  };
  for (let g = 0; g < ngen; g++) md.fns.push(mk(`g${g}`, true, g));
  for (let i = 0; i < nplain; i++) md.fns.push(mk(fname(i), false, i));
}

const M = 1000003;

// ---- 共通の小道具 ----
const files = new Map<string, string>();
const put = (p: string, s: string) => files.set(p, s);
const filesOf = (md: Mod) => Array.from({ length: FILES_PER_MODULE }, (_, f) => md.fns.filter((fn) => fn.file === f));
const usesMod = (fns: Fn[]) => {
  const s = new Set<number>();
  for (const fn of fns) for (const b of fn.blocks) if (b.k === "call") for (const c of b.callee) if (c.mod !== null) s.add(c.mod);
  return [...s].sort((a, b) => a - b);
};
const has = (fns: Fn[], ks: Blk["k"][]) => fns.some((fn) => fn.blocks.some((b) => ks.includes(b.k)));
const callExpr = (c: Callee, qual: (m: number) => string) => `${c.mod === null ? "" : qual(c.mod) + "."}${c.name}(acc % 100, d - 1)`;

// ---- Sober ----
function sober() {
  for (const md of mods) {
    const mn = mname(md.id);
    const tys: string[] = [`package ${mn}`, "", `const M = ${M}`, ""];
    for (const t of md.types) {
      if (t.union) tys.push(`type ${t.name} union {`, `    ${t.name}a { x int }`, `    ${t.name}b { y, z int }`, "}", "");
      else tys.push(`type ${t.name} struct {`, "    a, b int", "}", "");
    }
    put(`sober/${mn}/types.sober`, tys.join("\n"));
    filesOf(md).forEach((fns, f) => {
      const out: string[] = [`package ${mn}`, ""];
      if (has(fns, ["slice", "map"])) out.push(`import "std/iter"`);
      for (const u of usesMod(fns)) out.push(`import "${mname(u)}"`);
      out.push("");
      for (const fn of fns) {
        out.push(fn.generic ? `func ${fn.name}[T](x0 T, x1 T, n int, d int) T {` : `func ${fn.name}(n int, d int) int {`);
        if (!fn.generic) out.push(`    if d <= 0 { return (n * 7 + 1) % M }`);
        out.push(`    mut acc := n % M`);
        fn.blocks.forEach((b, j) => {
          const I = "    ";
          switch (b.k) {
            case "arith": out.push(`${I}acc = (acc * 31 + n + ${b.c}) % M`); break;
            case "branch": out.push(`${I}if acc % ${b.c1} < ${b.c2} {`, `${I}    acc = (acc + ${b.c3}) % M`, `${I}} else {`, `${I}    acc = (acc * ${b.c4}) % M`, `${I}}`); break;
            case "slice": out.push(`${I}mut xs${j} := mut []int{}`, `${I}for i <- iter.Range(0, n % 5 + 2) {`, `${I}    xs${j} = append(xs${j}, (i * ${b.c} + acc) % M)`, `${I}}`, `${I}for i <- iter.Range(0, len(xs${j})) {`, `${I}    acc = (acc + xs${j}[i]) % M`, `${I}}`); break;
            case "map": out.push(`${I}mut mp${j} := mut map[int]int{}`, `${I}for i <- iter.Range(0, n % 4 + 2) {`, `${I}    mp${j}[(acc + i) % 7] = i * ${b.c}`, `${I}}`, `${I}v${j} := mp${j}[${b.c % 7}]`, `${I}if v${j} != nil {`, `${I}    acc = (acc + v${j}) % M`, `${I}}`); break;
            case "call": out.push(`${I}acc = (acc + ${b.callee.map((c) => callExpr(c, mname)).join(" + ")}) % M`); break;
            case "struct": out.push(`${I}r${j} := ${b.ty}{a: acc, b: n}`, `${I}acc = (r${j}.a * 3 + r${j}.b) % M`); break;
            case "union": out.push(`${I}s${j} := if acc % 2 == 0 { ${b.ty}a{x: acc} } else { ${b.ty}b{y: acc, z: ${b.c}} }`, `${I}t${j} := switch s${j} {`, `${I}case ${b.ty}a{x}: x * 3`, `${I}case ${b.ty}b{y, z}: y + z`, `${I}}`, `${I}acc = (acc + t${j}) % M`); break;
            case "gint": out.push(`${I}acc = (acc + ${b.g}(acc, n, acc, d)) % M`); break;
            case "grec": out.push(`${I}q${j} := ${b.g}(${b.ty}{a: acc, b: 1}, ${b.ty}{a: n, b: 2}, acc, d)`, `${I}acc = (acc + q${j}.a + q${j}.b) % M`); break;
          }
        });
        out.push(fn.generic ? `    return if acc % 2 == 0 { x0 } else { x1 }` : `    return acc`, "}", "");
      }
      put(`sober/${mn}/f${f}.sober`, out.join("\n"));
    });
    put(`sober/${mn}/entry.sober`, [`package ${mn}`, "", "func Entry(n int) int {", "    mut acc := n % M", ...md.exported.map((x) => `    acc = (acc + ${x}(acc % 100, 2)) % M`), "    return acc", "}", ""].join("\n"));
  }
  put("sober/app/main.sober", ["package main", "", ...mods.map((m) => `import "${mname(m.id)}"`), "", "func main() int {", "    mut s := 1", ...mods.map((m) => `    s = (s * 7 + ${mname(m.id)}.Entry(s % 100)) % ${M}`), "    println(s)", "    return 0", "}", ""].join("\n"));
}

// ---- Go ----
function golang() {
  put("go/go.mod", "module buildscale\n\ngo 1.23\n");
  for (const md of mods) {
    const mn = mname(md.id);
    const tys: string[] = [`package ${mn}`, "", `const M = ${M}`, ""];
    for (const t of md.types) {
      if (t.union) tys.push(`type ${t.name} interface{ is${t.name}() }`, "", `type ${t.name}a struct{ x int }`, "", `type ${t.name}b struct{ y, z int }`, "", `func (${t.name}a) is${t.name}() {}`, `func (${t.name}b) is${t.name}() {}`, "");
      else tys.push(`type ${t.name} struct {`, "\ta, b int", "}", "");
    }
    put(`go/${mn}/types.go`, tys.join("\n"));
    filesOf(md).forEach((fns, f) => {
      const out: string[] = [`package ${mn}`, ""];
      const us = usesMod(fns);
      if (us.length > 0) out.push("import (", ...us.map((u) => `\t"buildscale/${mname(u)}"`), ")", "");
      for (const fn of fns) {
        out.push(fn.generic ? `func ${fn.name}[T any](x0 T, x1 T, n int, d int) T {` : `func ${fn.name}(n int, d int) int {`);
        if (!fn.generic) out.push("\tif d <= 0 {", "\t\treturn (n*7 + 1) % M", "\t}");
        out.push("\tacc := n % M");
        fn.blocks.forEach((b, j) => {
          const I = "\t";
          switch (b.k) {
            case "arith": out.push(`${I}acc = (acc*31 + n + ${b.c}) % M`); break;
            case "branch": out.push(`${I}if acc%${b.c1} < ${b.c2} {`, `${I}\tacc = (acc + ${b.c3}) % M`, `${I}} else {`, `${I}\tacc = (acc * ${b.c4}) % M`, `${I}}`); break;
            case "slice": out.push(`${I}xs${j} := []int{}`, `${I}for i := 0; i < n%5+2; i++ {`, `${I}\txs${j} = append(xs${j}, (i*${b.c}+acc)%M)`, `${I}}`, `${I}for i := 0; i < len(xs${j}); i++ {`, `${I}\tacc = (acc + xs${j}[i]) % M`, `${I}}`); break;
            case "map": out.push(`${I}mp${j} := map[int]int{}`, `${I}for i := 0; i < n%4+2; i++ {`, `${I}\tmp${j}[(acc+i)%7] = i * ${b.c}`, `${I}}`, `${I}if v${j}, ok := mp${j}[${b.c % 7}]; ok {`, `${I}\tacc = (acc + v${j}) % M`, `${I}}`); break;
            case "call": out.push(`${I}acc = (acc + ${b.callee.map((c) => callExpr(c, mname)).join(" + ")}) % M`); break;
            case "struct": out.push(`${I}r${j} := ${b.ty}{a: acc, b: n}`, `${I}acc = (r${j}.a*3 + r${j}.b) % M`); break;
            case "union": out.push(`${I}var s${j} ${b.ty}`, `${I}if acc%2 == 0 {`, `${I}\ts${j} = ${b.ty}a{x: acc}`, `${I}} else {`, `${I}\ts${j} = ${b.ty}b{y: acc, z: ${b.c}}`, `${I}}`, `${I}t${j} := 0`, `${I}switch v := s${j}.(type) {`, `${I}case ${b.ty}a:`, `${I}\tt${j} = v.x * 3`, `${I}case ${b.ty}b:`, `${I}\tt${j} = v.y + v.z`, `${I}}`, `${I}acc = (acc + t${j}) % M`); break;
            case "gint": out.push(`${I}acc = (acc + ${b.g}(acc, n, acc, d)) % M`); break;
            case "grec": out.push(`${I}q${j} := ${b.g}(${b.ty}{a: acc, b: 1}, ${b.ty}{a: n, b: 2}, acc, d)`, `${I}acc = (acc + q${j}.a + q${j}.b) % M`); break;
          }
        });
        if (fn.generic) out.push("\tif acc%2 == 0 {", "\t\treturn x0", "\t}", "\treturn x1", "}", "");
        else out.push("\treturn acc", "}", "");
      }
      put(`go/${mn}/f${f}.go`, out.join("\n"));
    });
    put(`go/${mn}/entry.go`, [`package ${mn}`, "", "func Entry(n int) int {", "\tacc := n % M", ...md.exported.map((x) => `\tacc = (acc + ${x}(acc%100, 2)) % M`), "\treturn acc", "}", ""].join("\n"));
  }
  put("go/app/main.go", ["package main", "", "import (", '\t"fmt"', "", ...mods.map((m) => `\t"buildscale/${mname(m.id)}"`), ")", "", "func main() {", "\ts := 1", ...mods.map((m) => `\ts = (s*7 + ${mname(m.id)}.Entry(s%100)) % ${M}`), "\tfmt.Println(s)", "}", ""].join("\n"));
}

// ---- Rust ----
function rust() {
  put("rust/Cargo.toml", ["[workspace]", 'resolver = "2"', `members = [${["app", ...mods.map((m) => mname(m.id))].map((x) => `"${x}"`).join(", ")}]`, "", "[profile.release]", "", ""].join("\n"));
  for (const md of mods) {
    const mn = mname(md.id);
    put(`rust/${mn}/Cargo.toml`, ["[package]", `name = "${mn}"`, 'version = "0.1.0"', 'edition = "2021"', "", "[dependencies]", ...md.imports.map((u) => `${mname(u)} = { path = "../${mname(u)}" }`), ""].join("\n"));
    const lib: string[] = ["#![allow(non_snake_case, unused_mut, unused_imports, unused_variables, dead_code)]", "", `pub const M: i64 = ${M};`, ""];
    for (const t of md.types) {
      if (t.union) lib.push(`pub enum ${t.name} {`, `    ${t.name}a { x: i64 },`, `    ${t.name}b { y: i64, z: i64 },`, "}", "");
      else lib.push(`pub struct ${t.name} {`, "    pub a: i64,", "    pub b: i64,", "}", "");
    }
    for (let f = 0; f < FILES_PER_MODULE; f++) lib.push(`mod f${f};`, `pub use f${f}::*;`);
    lib.push("mod entry;", "pub use entry::*;", "");
    put(`rust/${mn}/src/lib.rs`, lib.join("\n"));
    filesOf(md).forEach((fns, f) => {
      const out: string[] = ["use crate::*;"];
      if (has(fns, ["map"])) out.push("use std::collections::HashMap;");
      out.push("");
      for (const fn of fns) {
        out.push(fn.generic ? `pub fn ${fn.name}<T>(x0: T, x1: T, n: i64, d: i64) -> T {` : `pub fn ${fn.name}(n: i64, d: i64) -> i64 {`);
        if (!fn.generic) out.push("    if d <= 0 {", "        return (n * 7 + 1) % M;", "    }");
        out.push("    let mut acc = n % M;");
        fn.blocks.forEach((b, j) => {
          const I = "    ";
          switch (b.k) {
            case "arith": out.push(`${I}acc = (acc * 31 + n + ${b.c}) % M;`); break;
            case "branch": out.push(`${I}if acc % ${b.c1} < ${b.c2} {`, `${I}    acc = (acc + ${b.c3}) % M;`, `${I}} else {`, `${I}    acc = (acc * ${b.c4}) % M;`, `${I}}`); break;
            case "slice": out.push(`${I}let mut xs${j}: Vec<i64> = Vec::new();`, `${I}for i in 0..(n % 5 + 2) {`, `${I}    xs${j}.push((i * ${b.c} + acc) % M);`, `${I}}`, `${I}for i in 0..xs${j}.len() {`, `${I}    acc = (acc + xs${j}[i]) % M;`, `${I}}`); break;
            case "map": out.push(`${I}let mut mp${j}: HashMap<i64, i64> = HashMap::new();`, `${I}for i in 0..(n % 4 + 2) {`, `${I}    mp${j}.insert((acc + i) % 7, i * ${b.c});`, `${I}}`, `${I}if let Some(v${j}) = mp${j}.get(&${b.c % 7}) {`, `${I}    acc = (acc + v${j}) % M;`, `${I}}`); break;
            case "call": out.push(`${I}acc = (acc + ${b.callee.map((c) => (c.mod === null ? "" : mname(c.mod) + "::") + `${c.name}(acc % 100, d - 1)`).join(" + ")}) % M;`); break;
            case "struct": out.push(`${I}let r${j} = ${b.ty} { a: acc, b: n };`, `${I}acc = (r${j}.a * 3 + r${j}.b) % M;`); break;
            case "union": out.push(`${I}let s${j} = if acc % 2 == 0 {`, `${I}    ${b.ty}::${b.ty}a { x: acc }`, `${I}} else {`, `${I}    ${b.ty}::${b.ty}b { y: acc, z: ${b.c} }`, `${I}};`, `${I}let t${j} = match s${j} {`, `${I}    ${b.ty}::${b.ty}a { x } => x * 3,`, `${I}    ${b.ty}::${b.ty}b { y, z } => y + z,`, `${I}};`, `${I}acc = (acc + t${j}) % M;`); break;
            case "gint": out.push(`${I}acc = (acc + ${b.g}(acc, n, acc, d)) % M;`); break;
            case "grec": out.push(`${I}let q${j} = ${b.g}(${b.ty} { a: acc, b: 1 }, ${b.ty} { a: n, b: 2 }, acc, d);`, `${I}acc = (acc + q${j}.a + q${j}.b) % M;`); break;
          }
        });
        if (fn.generic) out.push("    if acc % 2 == 0 {", "        x0", "    } else {", "        x1", "    }", "}", "");
        else out.push("    acc", "}", "");
      }
      put(`rust/${mn}/src/f${f}.rs`, out.join("\n"));
    });
    put(`rust/${mn}/src/entry.rs`, ["use crate::*;", "", "pub fn Entry(n: i64) -> i64 {", "    let mut acc = n % M;", ...md.exported.map((x) => `    acc = (acc + ${x}(acc % 100, 2)) % M;`), "    acc", "}", ""].join("\n"));
  }
  put("rust/app/Cargo.toml", ["[package]", 'name = "app"', 'version = "0.1.0"', 'edition = "2021"', "", "[dependencies]", ...mods.map((m) => `${mname(m.id)} = { path = "../${mname(m.id)}" }`), ""].join("\n"));
  put("rust/app/src/main.rs", ["fn main() {", "    let mut s: i64 = 1;", ...mods.map((m) => `    s = (s * 7 + ${mname(m.id)}::Entry(s % 100)) % ${M};`), '    println!("{}", s);', "}", ""].join("\n"));
}

if (LANGS.has("sober")) sober();
if (LANGS.has("go")) golang();
if (LANGS.has("rust")) rust();

// ---- 書き出しと集計（空行とコメントを除いた行） ----
const lines: Record<string, number> = {};
for (const [p, s] of files) {
  const dst = join(OUT, p);
  mkdirSync(join(dst, ".."), { recursive: true });
  writeFileSync(dst, s);
  if (/\.(sober|go|rs)$/.test(p)) {
    const lang = p.split("/")[0];
    lines[lang] = (lines[lang] ?? 0) + s.split("\n").filter((l) => l.trim() !== "" && !l.trim().startsWith("//")).length;
  }
}
const allFns = mods.flatMap((m) => m.fns);
const stats = {
  seed: SEED, fns: allFns.length, generic: allFns.filter((f) => f.generic).length, modules: nmods, layers: nlayers,
  files: Object.fromEntries(Object.keys(lines).map((l) => [l, [...files.keys()].filter((p) => p.startsWith(l + "/") && /\.(sober|go|rs)$/.test(p)).length])),
  lines,
  ratio: lines.sober ? Object.fromEntries(Object.entries(lines).map(([l, n]) => [l, +(n / lines.sober).toFixed(3)])) : {},
  calls: allFns.reduce((a, f) => a + f.blocks.filter((b) => b.k === "call").reduce((x, b) => x + (b.k === "call" ? b.callee.length : 0), 0), 0),
};
writeFileSync(join(OUT, "stats.json"), JSON.stringify(stats, null, 2) + "\n");
console.log(JSON.stringify(stats));
