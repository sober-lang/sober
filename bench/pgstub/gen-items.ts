// 代役の固定の表（bench/pgstub/table.sober）を seed から焼く: 既定の引数（price 10〜50・limit 50）で本物の PG が返す 50 行
// = seed の items の順に price ∈ [10, 50] の先頭 50 行（price に索引が無く、本物は heap の順 = seed の順に読む）。
//   node --experimental-strip-types --no-warnings bench/pgstub/gen-items.ts <data/pgdb-seed.sql> > bench/pgstub/table.sober
import { readFileSync } from "node:fs";

const src = readFileSync(process.argv[2], "utf8").split("\n");
const at = src.findIndex((l) => l.startsWith("COPY items"));
const rows: string[][] = [];
for (const l of src.slice(at + 1)) {
    if (l === "\\.") break;
    const f = l.split("\t");
    if (Number(f[3]) >= 10 && Number(f[3]) <= 50) rows.push(f);
    if (rows.length === 50) break;
}
const q = (s: string) => {
    if (!/^[\x20-\x7e]*$/.test(s)) throw new Error(`non-ASCII: ${s}`);
    return JSON.stringify(s).replace(/\$/g, "\\$");
};
const out = [
    "package main",
    "",
    "// 生成物（bench/pgstub/gen-items.ts — seed の items の順に price ∈ [10, 50] の先頭 50 行）。手で直さない",
    "",
    "func table() []Item {",
    "    return []Item{",
    ...rows.map((f) => `        Item{id: ${f[0]}, name: ${q(f[1])}, category: ${q(f[2])}, price: ${f[3]}, quantity: ${f[4]}, active: ${f[5] === "t"}, tags: ${q(f[6])}, score: ${f[7]}, count: ${f[8]}},`),
    "    }",
    "}",
    "",
];
process.stdout.write(out.join("\n"));
