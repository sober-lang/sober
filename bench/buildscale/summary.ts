// results.tsvを、規模 × 言語 × コア数 × 場面の中央値の表にする。両対数の傾き（10万→100万行・1万→10万行）と1秒あたりの行数・1行あたりのバイト数も出す
// 使い方: node bench/buildscale/summary.ts <results.tsv>
import { readFileSync } from "node:fs";
const rows = readFileSync(process.argv[2], "utf8").trim().split("\n").slice(1).map((l) => l.split("\t"));
type K = string;
const g = new Map<K, { lines: number; wall: number[]; cpu: number[]; rss: number[]; bin: number }>();
for (const r of rows) {
  const [size, , lines, lang, cores, scene, , wall, user, sys, rss, bin, code] = r;
  if (code !== "0") continue;
  const k = [size, lang, cores, scene].join("|");
  const e = g.get(k) ?? { lines: +lines, wall: [], cpu: [], rss: [], bin: +bin };
  e.wall.push(+wall); e.cpu.push(+user + +sys); e.rss.push(+rss / 1024);
  g.set(k, e);
}
const med = (xs: number[]) => { const s = [...xs].sort((a, b) => a - b); return s[Math.floor(s.length / 2)]; };
const sizes = ["1k", "10k", "100k", "1m"], langs = ["sober", "go", "rust", "rustdebug"], cores = ["1", "8", "32"], scenes = ["cold", "coldapp", "leaf", "root"];
const f = (x: number | undefined, d = 2) => (x === undefined ? "-" : x >= 100 ? x.toFixed(0) : x.toFixed(d));
for (const sc of scenes) {
  console.log(`\n### ${sc}（wall秒 / CPU秒 / peak RSS MB）\n`);
  console.log(`| 規模 | 言語 | ${cores.map((c) => `${c}コア`).join(" | ")} |`);
  console.log(`|---|---|${cores.map(() => "---").join("|")}|`);
  for (const s of sizes) for (const l of langs) {
    const cells = cores.map((c) => { const e = g.get([s, l, c, sc].join("|")); return e ? `${f(med(e.wall))} / ${f(med(e.cpu))} / ${f(med(e.rss), 0)}` : "-"; });
    if (cells.every((c) => c === "-")) continue;
    console.log(`| ${s} | ${l} | ${cells.join(" | ")} |`);
  }
}
console.log(`\n### 両対数の傾き（wall・peak RSS。cold・8コア）\n`);
console.log("| 言語 | wall 1万→10万 | wall 10万→100万 | RSS 1万→10万 | RSS 10万→100万 | 100万行の行/秒（wall） | 100万行の1行あたりのRSS（バイト） |");
console.log("|---|---|---|---|---|---|---|");
for (const l of langs) {
  const e = (s: string) => g.get([s, l, "8", "cold"].join("|"));
  const sl = (a: string, b: string, m: (x: NonNullable<ReturnType<typeof e>>) => number) => { const x = e(a), y = e(b); return x && y ? (Math.log(m(y) / m(x)) / Math.log(y.lines / x.lines)).toFixed(2) : "-"; };
  const w = (x: NonNullable<ReturnType<typeof e>>) => med(x.wall), r = (x: NonNullable<ReturnType<typeof e>>) => med(x.rss);
  const m1 = e("1m");
  console.log(`| ${l} | ${sl("10k", "100k", w)} | ${sl("100k", "1m", w)} | ${sl("10k", "100k", r)} | ${sl("100k", "1m", r)} | ${m1 ? Math.round(m1.lines / w(m1)) : "-"} | ${m1 ? Math.round((r(m1) * 1048576) / m1.lines) : "-"} |`);
}
console.log(`\n### 出力のバイナリ（バイト・cold・8コア）\n`);
for (const s of sizes) console.log(`- ${s}: ${langs.map((l) => `${l} ${g.get([s, l, "8", "cold"].join("|"))?.bin ?? "-"}`).join("・")}`);
