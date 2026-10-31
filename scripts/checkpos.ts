// checkpos.ts — 位置の網（scripts/checkpos.sh）の変異の題材: 受理する例題の本体の整数のリテラルを 1 か所 `(1 < 2)`（bool）に置き換え、
// 検査器の型の拒否を作る。置き換える位置は本体の行（字下げつき・文字列とコメントを含まない行）の整数のリテラルの出現の中ほど（決定的）。
//   node scripts/checkpos.ts <out-dir> <input.sober>...
// <out-dir>/<入力名> に変異体を書き、標準出力に「<変異体のパス> <置き換えた行>」を 1 行ずつ出す（当てる場所が無い入力は出さない）
import { readFileSync, writeFileSync } from "node:fs";
import { basename, join } from "node:path";

const [out, ...inputs] = process.argv.slice(2);
const lit = /(?<![\w.$])\d+(?![\w.])/g;
for (const f of inputs) {
    const lines = readFileSync(f, "utf8").split("\n");
    const sites: [number, number, number][] = [];
    lines.forEach((l, i) => {
        if (!/^\s+\S/.test(l) || l.includes('"') || l.includes("'") || l.includes("//") || l.includes("`")) return;
        for (const m of l.matchAll(lit)) sites.push([i, m.index!, m[0].length]);
    });
    if (sites.length === 0) continue;
    const [i, at, n] = sites[Math.floor(sites.length / 2)];
    lines[i] = lines[i].slice(0, at) + "(1 < 2)" + lines[i].slice(at + n);
    const p = join(out, basename(f));
    writeFileSync(p, lines.join("\n"));
    console.log(`${p} ${i + 1}`);
}
