// stages.tsの出力を段ごとの時間（前の印からこの印まで）とRSSにして並べる。2つ目以降のファイルは、1つ目に対する時間の比と、
// 行数の比に対する両対数の傾き（--lines a,b,… を渡したとき）を出す。同じ名前の印（kinds・taskuse）は出現の順で区別する
// 使い方: node bench/buildscale/stagediff.ts a.tsv b.tsv [--lines 108364,1069432]
import { readFileSync } from "node:fs";
const argv = process.argv.slice(2);
const li = argv.indexOf("--lines");
const lines = li >= 0 ? argv[li + 1].split(",").map(Number) : [];
const files = li >= 0 ? argv.filter((_, i) => i !== li && i !== li + 1) : argv;
type St = { name: string; dt: number; rss: number; hwm: number };
const read = (f: string): St[] => {
  const rs = readFileSync(f, "utf8").trim().split("\n").slice(1).map((l) => l.split("\t"));
  const seen = new Map<string, number>();
  let prev = 0;
  return rs.map(([n, s, r, h]) => {
    const c = (seen.get(n) ?? 0) + 1; seen.set(n, c);
    const t = Number(s); const dt = t - prev; prev = t;
    return { name: c > 1 ? `${n}#${c}` : n, dt, rss: Number(r) || 0, hwm: Number(h) || 0 };
  });
};
const all = files.map(read);
const names = [...new Set(all.flatMap((x) => x.map((s) => s.name)))].filter((n) => !/^taskuse#[2-9]/.test(n));
console.log(`| 段 | ${files.map((f) => `${f.split("/").pop()} 秒 / RSS MB`).join(" | ")} |${lines.length > 1 ? " 傾き |" : ""}`);
console.log(`|---|${files.map(() => "---").join("|")}|${lines.length > 1 ? "---|" : ""}`);
for (const n of names) {
  const cs = all.map((x) => x.find((s) => s.name === n));
  const sl = lines.length > 1 && cs[0] && cs[1] && cs[0].dt > 0.005 ? (Math.log(cs[1].dt / cs[0].dt) / Math.log(lines[1] / lines[0])).toFixed(2) : "";
  console.log(`| ${n} | ${cs.map((c) => (c ? `${c.dt.toFixed(3)} / ${c.rss}` : "-")).join(" | ")} |${lines.length > 1 ? ` ${sl} |` : ""}`);
}
