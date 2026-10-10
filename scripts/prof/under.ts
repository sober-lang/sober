// under.ts — samp の標本のうち関数 func を含むものに絞り、func より内側（callee）の inclusive と最も外側の func の呼び手を出す（使い方は samp.c の冒頭）
// usage: node --experimental-strip-types under.ts <binary> <samples> <func> [topN] — func を含む標本で、func より callee 側（スタックの内側）の関数の inclusive
import { execSync } from "child_process";
import { readFileSync } from "fs";
const [bin, samp, fn, topS] = process.argv.slice(2);
const top = Number(topS ?? 25);
const syms = execSync(`nm -n ${bin}`, { maxBuffer: 1 << 28 }).toString().split("\n")
  .map(l => l.split(" ")).filter(p => p.length === 3 && /[tT]/.test(p[1]))
  .map(p => ({ a: BigInt("0x" + p[0]), n: p[2] }));
const find = (x: bigint) => { let lo = 0, hi = syms.length - 1; if (x < syms[0].a) return "?"; while (lo < hi) { const m = (lo + hi + 1) >> 1; if (syms[m].a <= x) lo = m; else hi = m - 1; } return syms[lo].n; };
const lines = readFileSync(samp, "utf8").trim().split("\n");
const incl = new Map<string, number>(); let hit = 0;
const parent = new Map<string, number>();
for (const l of lines) {
  const fs = l.split(" ").map(h => find(BigInt("0x" + h)));
  const i = fs.lastIndexOf(fn); // 最も外側の fn
  if (i < 0) continue;
  hit++;
  if (i + 1 < fs.length) parent.set(fs[i + 1], (parent.get(fs[i + 1]) ?? 0) + 1);
  for (const f of new Set(fs.slice(0, i))) incl.set(f, (incl.get(f) ?? 0) + 1);
}
console.log(`== under ${fn}: ${hit}/${lines.length}`);
[...incl].sort((a, b) => b[1] - a[1]).slice(0, top).forEach(([f, c]) => console.log(`${(100 * c / hit).toFixed(1).padStart(5)}% ${f}`));
console.log(`== callers of outermost ${fn}`);
[...parent].sort((a, b) => b[1] - a[1]).slice(0, 12).forEach(([f, c]) => console.log(`${(100 * c / hit).toFixed(1).padStart(5)}% ${f}`));
