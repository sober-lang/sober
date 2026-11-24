// bakepick.ts — 焼き込みの入力の例題を選ぶ（貪欲法）。例題ごとの鍵（`sober build <例> --emit=cachekeys --passes` の出力 — `@名前 a=… b=…`）の
// ディレクトリから、std・rt の関数の β の鍵を、ほかの例題が使う重み（その鍵を使う例題の数）で覆う順に並べ、覆う割合を印字する。
//   node scripts/bakepick.ts <鍵のディレクトリ> [本数（既定20）] → 標準出力に scripts/bake.list の本体（examples/<名前>.sober）
import { readdirSync, readFileSync } from "node:fs";
const dir = process.argv[2];
const n = Number(process.argv[3] ?? "20");
const sets = new Map<string, Set<string>>();
const freq = new Map<string, number>();
for (const f of readdirSync(dir).filter((x) => x.endsWith(".keys"))) {
  const s = new Set<string>();
  for (const l of readFileSync(`${dir}/${f}`, "utf8").split("\n")) {
    const m = /^@(\S+) a=\S+ b=(\S+)/.exec(l);
    if (!m || m[1].startsWith("main.") || !m[1].includes(".")) continue;
    s.add(m[2]);
  }
  sets.set(f.replace(/\.keys$/, ""), s);
  for (const k of s) freq.set(k, (freq.get(k) ?? 0) + 1);
}
const total = [...freq.values()].reduce((a, b) => a + b, 0);
const covered = new Set<string>();
let cov = 0;
const chosen: string[] = [];
while (chosen.length < n) {
  let best = "", gain = -1;
  for (const [f, s] of sets) {
    if (chosen.includes(f)) continue;
    let g = 0;
    for (const k of s) if (!covered.has(k)) g += freq.get(k)!;
    if (g > gain) { gain = g; best = f; }
  }
  if (best === "") break;
  chosen.push(best);
  for (const k of sets.get(best)!) if (!covered.has(k)) { covered.add(k); cov += freq.get(k)!; }
}
console.error(`bakepick: ${chosen.length} of ${sets.size} examples cover ${(100 * cov / total).toFixed(1)}% of the std / rt beta keys the examples use`);
for (const f of chosen) console.log(`examples/${f}`);
