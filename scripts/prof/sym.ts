// sym.ts — samp の標本を nm で関数名に直し、self / inclusive の上位を出す（使い方は samp.c の冒頭）
// usage: node --experimental-strip-types sym.ts <binary> <samples> [topN]
import { execSync } from "child_process";
import { readFileSync } from "fs";
const [bin, samp, topS] = process.argv.slice(2);
const top = Number(topS ?? 30);
const syms = execSync(`nm -n ${bin}`, { maxBuffer: 1 << 28 }).toString().split("\n")
  .map(l => l.split(" ")).filter(p => p.length === 3 && /[tT]/.test(p[1]))
  .map(p => ({ a: BigInt("0x" + p[0]), n: p[2] }));
const find = (x: bigint) => { let lo = 0, hi = syms.length - 1; if (x < syms[0].a) return "?"; while (lo < hi) { const m = (lo + hi + 1) >> 1; if (syms[m].a <= x) lo = m; else hi = m - 1; } return syms[lo].n; };
const self = new Map<string, number>(), incl = new Map<string, number>();
const lines = readFileSync(samp, "utf8").trim().split("\n");
for (const l of lines) {
  const fs = l.split(" ").map(h => find(BigInt("0x" + h)));
  self.set(fs[0], (self.get(fs[0]) ?? 0) + 1);
  for (const f of new Set(fs)) incl.set(f, (incl.get(f) ?? 0) + 1);
}
const N = lines.length;
const show = (m: Map<string, number>, t: string) => { console.log(`== ${t} (N=${N})`); [...m].sort((a, b) => b[1] - a[1]).slice(0, top).forEach(([f, c]) => console.log(`${(100 * c / N).toFixed(1).padStart(5)}% ${f}`)); };
show(self, "self"); show(incl, "inclusive");
