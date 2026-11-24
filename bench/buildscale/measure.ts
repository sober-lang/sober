// Soberのソースの木から、生成器のパラメータの元になる分布を測る。
// 使い方: node bench/buildscale/measure.ts src/compiler。_test.soberは除く
import { readFileSync, readdirSync, statSync } from "node:fs";
import { join, relative } from "node:path";

const root = process.argv[2];
if (!root) throw new Error("usage: measure.ts <dir>");

function walk(d: string): string[] {
  return readdirSync(d).flatMap((n) => {
    const p = join(d, n);
    return statSync(p).isDirectory() ? walk(p) : p.endsWith(".sober") && !p.endsWith("_test.sober") ? [p] : [];
  });
}

// 空行と行コメントだけの行を除く（ブロックコメントはSoberに無い）
const isCode = (l: string) => { const t = l.trim(); return t !== "" && !t.startsWith("//"); };
const KW = new Set(["if", "for", "while", "switch", "return", "func", "catch", "case", "len", "append", "freeze", "clone", "bytes", "string", "int", "byte", "println", "panic", "assert", "bool", "mut", "yield", "else", "u8", "i32", "u32", "i64", "u64", "f64", "float", "Some"]);

type Fn = { pkg: string; lines: number; calls: number; xcalls: number; generic: boolean; exported: boolean };
const fns: Fn[] = [];
const pkgImports = new Map<string, Set<string>>();
const filesPerPkg = new Map<string, number>();
const fnsPerFile: number[] = [];
let typeDecls = 0, unionDecls = 0, structDecls = 0, codeLines = 0;

for (const f of walk(root)) {
  const pkg = relative(root, f).split("/").slice(0, -1).join("/") || ".";
  filesPerPkg.set(pkg, (filesPerPkg.get(pkg) ?? 0) + 1);
  const src = readFileSync(f, "utf8").split("\n");
  codeLines += src.filter(isCode).length;
  const imps = pkgImports.get(pkg) ?? new Set<string>();
  pkgImports.set(pkg, imps);
  let nf = 0;
  for (let i = 0; i < src.length; i++) {
    const l = src[i];
    const im = l.match(/^import\s+(.*)$/);
    if (im) for (const m of im[1].matchAll(/"([^"]+)"/g)) if (!m[1].startsWith("std/")) imps.add(m[1]);
    if (/^type\s+\w+(\[[^\]]*\])?\s+union\b/.test(l)) unionDecls++;
    else if (/^type\s+\w+(\[[^\]]*\])?\s+struct\b/.test(l)) structDecls++;
    if (/^type\s/.test(l)) typeDecls++;
    const fm = l.match(/^func\s+(\w+)(\[)?/);
    if (!fm) continue;
    // 本体 = 次の行頭の "}" まで
    let j = i;
    while (j < src.length && src[j] !== "}") j++;
    const body = src.slice(i, j + 1);
    const text = body.join("\n");
    let calls = 0, xcalls = 0;
    for (const m of text.matchAll(/([A-Za-z_][\w.]*)\s*(\[[^\]\n]*\])?\(/g)) {
      const name = m[1];
      if (KW.has(name) || /^[A-Z]/.test(name) && !name.includes(".")) continue; // 構造体や型変換らしいもの
      if (name.includes(".")) {
        const head = name.split(".")[0];
        if (/^[a-z]/.test(head)) xcalls++;
      }
      calls++;
    }
    calls--; // 宣言の行の自分自身
    fns.push({ pkg, lines: body.filter(isCode).length, calls, xcalls, generic: !!fm[2], exported: /^[A-Z]/.test(fm[1]) });
    nf++;
    i = j;
  }
  fnsPerFile.push(nf);
}

// 依存の深さ（compiler/の中のpackageだけ）
const local = new Set(pkgImports.keys());
const depth = new Map<string, number>();
const dep = (p: string, seen = new Set<string>()): number => {
  if (depth.has(p)) return depth.get(p)!;
  if (seen.has(p)) return 0;
  seen.add(p);
  const ds = [...(pkgImports.get(p) ?? [])].filter((q) => local.has(q));
  const d = ds.length === 0 ? 0 : 1 + Math.max(...ds.map((q) => dep(q, seen)));
  depth.set(p, d);
  return d;
};
for (const p of local) dep(p);

const q = (xs: number[], ps = [0.1, 0.25, 0.5, 0.75, 0.9, 0.99]) => {
  const s = [...xs].sort((a, b) => a - b);
  return Object.fromEntries(ps.map((p) => [`p${Math.round(p * 100)}`, s[Math.min(s.length - 1, Math.floor(p * s.length))]]));
};
const mean = (xs: number[]) => +(xs.reduce((a, b) => a + b, 0) / xs.length).toFixed(2);
// 呼び出しの種類（同じpackage・他package・std）。宣言の行とコメントの行を除き、式の中の呼び出しも数える
const callKinds = { local: 0, xpkg: 0, std: 0 };
const localRoots = new Set([...local].map((p) => p.split("/")[0]));
for (const f of walk(root)) {
  const src = readFileSync(f, "utf8");
  const stdAliases = new Set([...src.matchAll(/"std\/([\w/]+)"/g)].map((m) => m[1].split("/").pop()!));
  for (const l of src.split("\n")) {
    if (/^\s*\/\//.test(l) || /^func /.test(l)) continue;
    for (const m of l.matchAll(/([A-Za-z_][\w.]*)\s*(\[[^\]\n]*\])?\(/g)) {
      const n = m[1];
      if (KW.has(n)) continue;
      if (!n.includes(".")) { if (!/^[A-Z]/.test(n)) callKinds.local++; continue; }
      const h = n.split(".")[0];
      if (stdAliases.has(h)) callKinds.std++; else if (localRoots.has(h)) callKinds.xpkg++;
    }
  }
}

const out = {
  root, files: fnsPerFile.length, packages: local.size, codeLines, functions: fns.length,
  fnLines: { mean: mean(fns.map((f) => f.lines)), ...q(fns.map((f) => f.lines)) },
  callsPerFn: { mean: mean(fns.map((f) => f.calls)), ...q(fns.map((f) => f.calls)) },
  crossPkgCallsPerFn: mean(fns.map((f) => f.xcalls)),
  genericFraction: +(fns.filter((f) => f.generic).length / fns.length).toFixed(4),
  exportedFraction: +(fns.filter((f) => f.exported).length / fns.length).toFixed(3),
  fnsPerFile: { mean: mean(fnsPerFile), ...q(fnsPerFile) },
  filesPerPkg: { mean: mean([...filesPerPkg.values()]), ...q([...filesPerPkg.values()]) },
  callKinds, userCallsPerLine: +((callKinds.local + callKinds.xpkg) / codeLines).toFixed(3), xpkgCallFrac: +(callKinds.xpkg / (callKinds.local + callKinds.xpkg)).toFixed(3),
  typeDecls, structDecls, unionDecls,
  localImportsPerPkg: mean([...pkgImports.entries()].map(([, s]) => [...s].filter((x) => local.has(x)).length)),
  depDepthMax: Math.max(...depth.values()),
  depDepth: Object.fromEntries([...depth.entries()].sort()),
};
console.log(JSON.stringify(out, null, 2));
