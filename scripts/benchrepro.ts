// benchrepro: 公式ベンチの run 同士の比の再現性の照合（基線の取り直しの検収 — report-922 の条件）。
//   node --experimental-strip-types scripts/benchrepro.ts <official.tsv> <official.tsv> [...]   （scripts/benchfetch.sh --dry が out/bench/gha-<run>/official.tsv を作る）
// 比 = scripts/benchsync.ts と同じ推定量（同じ周の対の task-clock の比の中央）。題材ごとに Sober/Go・Sober/Rust の run 間の幅（max/min − 1）と
// ±5% の勝敗の分類の割れを出す。線 = 幅 ±3% 以内かつ分類の割れなし（全部満たせば exit 0）
import { readFileSync } from "node:fs";

const median = (xs: number[]) => { const s = [...xs].sort((a, b) => a - b); return s[Math.floor((s.length - 1) / 2)]; };
const files = process.argv.slice(2);
if (files.length < 2) { console.error("usage: benchrepro.ts <official.tsv> <official.tsv> [...]"); process.exit(2); }
const runs = files.map((f) => {
  const all = readFileSync(f, "utf8").split("\n");
  const cpu = all.map((l) => l.match(/^# env: (?:.*; )?cpu=([^;]*)/)).find((m) => m)?.[1] ?? "?";
  const ls = all.filter((l) => l.trim() !== "" && !l.startsWith("#"));
  const h = ls[0].split("\t");
  const rounds = new Map<string, number[]>();
  for (const l of ls.slice(1)) {
    const v = Object.fromEntries(h.map((k, i) => [k, l.split("\t")[i]]));
    if ((v.run === "seqperf" || (v.run === "extsort" && v.bench === "extsort-1024m")) && v.tc_rounds_ns && v.tc_rounds_ns !== "-")
      rounds.set(`${v.bench}|${v.impl}`, v.tc_rounds_ns.split(",").map(Number));
  }
  if (rounds.size === 0) { console.error(`benchrepro: ${f} に tc_rounds_ns が無い（task-clock のレジームの official.tsv ではない）`); process.exit(2); }
  return { f, cpu, rounds };
});
const benches = [...new Set([...runs[0].rounds.keys()].map((k) => k.split("|")[0]))];
const rel = (r: (typeof runs)[number], b: string, vs: string) => {
  const s = r.rounds.get(`${b}|sober`), o = r.rounds.get(`${b}|${vs}`);
  return s && o ? median(s.map((v, i) => v / o[i])) : NaN;
};
const cls = (v: number) => { const r = Math.round(v * 100) / 100; return r < 0.95 ? "勝" : r > 1.05 ? "負" : "互"; };
console.log(`run: ${runs.map((r, i) => `[${i + 1}] ${r.f}（${r.cpu}）`).join("  ")}`);
if (new Set(runs.map((r) => r.cpu)).size > 1) console.log("注意: 型番が run で違う — 比は型番をまたいで比べられない");
console.log("| 題材 | 対 | 比（run 順） | 幅 | 分類 | 判定 |\n|---|---|---|---|---|---|");
let bad = 0;
for (const b of benches) for (const vs of ["go", "rust"]) {
  const xs = runs.map((r) => rel(r, b, vs));
  if (xs.some((v) => !Number.isFinite(v))) continue;
  const w = (Math.max(...xs) / Math.min(...xs) - 1) * 100;
  const c = xs.map(cls);
  const ok = w <= 3 && new Set(c).size === 1;
  if (!ok) bad++;
  console.log(`| ${b} | ${vs} | ${xs.map((v) => v.toFixed(3)).join(" / ")} | ${w.toFixed(1)}% | ${c.join("")} | ${ok ? "ok" : "外れ"} |`);
}
console.log(`\nbenchrepro: 外れ ${bad} 本（線 = 幅 ±3% 以内・±5% の分類が一致）`);
process.exit(bad === 0 ? 0 : 1);
