// summary.ts <result.tsv> — local.sh の結果を種目ごとの中央値と比（Sober / Go）の markdown の表に（GH Actions の job summary にもそのまま）
import { readFileSync } from "node:fs";
const rows = readFileSync(process.argv[2], "utf8").trim().split("\n").slice(1).map((l) => l.split("\t"));
const med = (xs: number[]) => { const s = [...xs].sort((a, b) => a - b); const m = s.length >> 1; return s.length % 2 ? s[m] : (s[m - 1] + s[m]) / 2; };
const profs = [...new Set(rows.map((r) => r[1]))];
let md = "| profile | Sober req/s | Go req/s | ratio (Sober/Go) | Sober CPU µs/req | Go CPU µs/req | Sober p99 | Go p99 | Sober p99.9 | Go p99.9 | non-2xx (S/G) |\n|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|\n";
for (const p of profs) {
    const g = (n: string, i: number) => rows.filter((r) => r[0] === n && r[1] === p).map((r) => Number(r[i]));
    const l = (n: string, i = 7) => rows.filter((r) => r[0] === n && r[1] === p).map((r) => r[i] ?? "-").join(" ");
    const s = med(g("sober", 3)), o = med(g("go", 3));
    md += `| ${p} | ${Math.round(s).toLocaleString("en")} | ${Math.round(o).toLocaleString("en")} | ${(s / o).toFixed(2)} | ${med(g("sober", 6)).toFixed(2)} | ${med(g("go", 6)).toFixed(2)} | ${l("sober")} | ${l("go")} | ${l("sober", 8)} | ${l("go", 8)} | ${g("sober", 5).reduce((a, b) => a + b, 0)}/${g("go", 5).reduce((a, b) => a + b, 0)} |\n`;
}
console.log(md);
