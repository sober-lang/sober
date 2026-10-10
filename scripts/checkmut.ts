// selfhost の型検査器の差分オラクル用: コア AST JSON の変異体（負例の供給源）を作る（scripts/selfhost_check.sh が使う）。
//
//   node scripts/checkmut.ts <out-dir> <input.json>...
//
// 各入力に、下の表の置換を 1 か所ずつ当てた変異体を <out-dir>/<入力名>.<規則番号>.json に書く。当てる位置は出現の中ほど
// （決定的 — 入力と表が同じなら同じ変異体）。変異体の多くは Lean が拒否する（型の取り違え・region / mut の食い違い・添字のずれ）が、
// 受理されるものもある — 照合は「Lean と Sober 版の判定が一致するか」だけを見るので、どちらでもよい。
// 入力は Zig 版の脱糖器の出力（キーの順が固定 — "k" が先頭）を前提に綴りで当てる。
// node 22.6+（型ストリップで .ts を直接実行）。
import { readFileSync, writeFileSync } from "node:fs";
import { basename } from "node:path";

type Rule = [re: RegExp, rep: (m: RegExpExecArray) => string];
const bump = (i: number) => (m: RegExpExecArray) => m[0].replace(m[i], String(Number(m[i]) + 1));
const rules: Rule[] = [
  [/"k":"int"\}/g, () => `"k":"bool"}`],
  [/"k":"bool"\}/g, () => `"k":"int"}`],
  [/"k":"unit"\}/g, () => `"k":"int"}`],
  [/"m":false/g, () => `"m":true`],
  [/"m":true/g, () => `"m":false`],
  [/"mut":true/g, () => `"mut":false`],
  [/"mut":false/g, () => `"mut":true`],
  [/"r":(\d+),/g, bump(1)],
  [/"r":([1-9]\d*),/g, (m) => `"r":${Number(m[1]) - 1},`],
  [/"k":"var","i":(\d+)/g, bump(1)],
  [/"k":"triv"\}/g, () => `"k":"lit","n":0}`],
  [/"k":"lit","n":-?\d+\}/g, () => `"k":"true"}`],
  [/"k":"call","f":(\d+)/g, bump(1)],
  [/"k":"call",/g, () => `"k":"callm",`],
  [/"k":"callm",/g, () => `"k":"call",`],
  [/"k":"lt",/g, () => `"k":"add",`],
  [/"k":"deref",/g, () => `"k":"freeze",`],
  [/"k":"jump","n":(\d+)/g, bump(1)],
  [/"k":"block","e":/g, () => `"k":"let","e":{"k":"triv"},"body":`],
  [/"k":"ann","e":/g, () => `"k":"ann","t":{"k":"int"},"e":`],
];

const [outDir, ...inputs] = process.argv.slice(2);
let n = 0;
for (const path of inputs) {
  const src = readFileSync(path, "utf8");
  const name = basename(path, ".json");
  rules.forEach(([re, rep], ri) => {
    const ms = [...src.matchAll(re)];
    if (ms.length === 0) return;
    const m = ms[Math.floor(ms.length / 2)] as RegExpExecArray;
    const out = src.slice(0, m.index) + rep(m) + src.slice(m.index + m[0].length);
    writeFileSync(`${outDir}/${name}.${ri}.json`, out);
    n++;
  });
}
console.log(`checkmut: ${n} mutants`);
