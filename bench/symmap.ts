// symmap.ts: Sober の ELF の関数単位の帰属 — `sober build <src> --emit=syms -o syms.txt` の表と `perf script -F ip` の番地の列から、
// 関数ごとのサンプルの割合（上位 12）を出す。関数単位なので AMD の skid の影響は小さい（区間の帰属は誤る）
//   node --experimental-strip-types bench/symmap.ts <syms.txt> <ips.txt>
import { readFileSync } from "node:fs";
const [symf, ipf] = process.argv.slice(2);
const syms = readFileSync(symf, "utf8").trim().split("\n").map((l) => { const [a, n] = l.trim().split(/\s+/); return [parseInt(a, 16), n] as [number, string]; }).sort((x, y) => x[0] - y[0]);
const c: Record<string, number> = {}; let t = 0;
for (const l of readFileSync(ipf, "utf8").split("\n")) { if (!l.trim()) continue; const a = parseInt(l.trim(), 16); t++; let lo = 0, hi = syms.length - 1, k = "?";
  while (lo <= hi) { const m = (lo + hi) >> 1; if (syms[m][0] <= a) { k = syms[m][1]; lo = m + 1; } else hi = m - 1; } c[k] = (c[k] ?? 0) + 1; }
for (const [k, v] of Object.entries(c).sort((x, y) => y[1] - x[1]).slice(0, 12)) console.log((100 * v / t).toFixed(1).padStart(5) + "% " + k);
