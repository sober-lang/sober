// implicitfreeze.ts — 暗黙 ≡ 明示のオラクルの書き換え（scripts/implicitfreeze.sh）: `sober check --freeze-sites` の位置（`freeze(` の `(` の字句 —
// path:行:列）ごとに `freeze(x)` を `x` に書き換える。引数 = 位置の一覧のファイル・書き換え先の根（同じ相対パスに書く）
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";

// 第 3 引数 --compact: 列を保たずに `freeze(x)` を `x` に詰める（移行用 — 書き換え先の根に "." を渡せばその場で）
const [sitesFile, outRoot, mode] = process.argv.slice(2);
const compact = mode === "--compact";
const byFile = new Map<string, { line: number; col: number }[]>();
for (const l of readFileSync(sitesFile, "utf8").split("\n").filter((x) => x)) {
  const m = /^(.*):(\d+):(\d+)$/.exec(l);
  // 合成した木（json の shape など — 位置が `token N`）の点は書き換えられない — 飛ばす
  if (!m) continue;
  const a = byFile.get(m[1]) ?? [];
  a.push({ line: Number(m[2]), col: Number(m[3]) });
  byFile.set(m[1], a);
}
let n = 0;
for (const [file, sites] of byFile) {
  const lines = readFileSync(file, "utf8").split("\n");
  // 同じ行の複数は右から（列がずれない）
  sites.sort((a, b) => b.line - a.line || b.col - a.col);
  for (const { line, col } of sites) {
    const s = lines[line - 1];
    const open = col - 1; // 列は 1 始まり・バイトでなく文字（ASCII の行を前提 — 外れたら止める）
    // 文字列の補間の中の式は位置が補間の字句を指す — 書き換えずに飛ばす（オラクルの対象外）
    if (s[open] !== "(" || !s.slice(0, open).endsWith("freeze")) continue;
    let d = 0;
    let close = -1;
    for (let i = open; i < s.length; i++) {
      if (s[i] === "(") d++;
      else if (s[i] === ")" && --d === 0) {
        close = i;
        break;
      }
    }
    if (close < 0) throw new Error(`${file}:${line}:${col}: unbalanced`);
    // 列を保つ（panic の位置の表に列が入る）: `freeze(` を空白 7 個・`)` を空白 1 個に — x とその後ろの字句は同じ列に残る
    lines[line - 1] = compact
      ? s.slice(0, open - "freeze".length) + s.slice(open + 1, close) + s.slice(close + 1)
      : s.slice(0, open - "freeze".length) + " ".repeat("freeze(".length) + s.slice(open + 1, close) + " " + s.slice(close + 1);
    n++;
  }
  const out = join(outRoot, file);
  mkdirSync(dirname(out), { recursive: true });
  writeFileSync(out, lines.join("\n"));
}
console.log(n);
