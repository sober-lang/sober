// std/strings の差分オラクル — Go の strings パッケージを真実として期待値を作る（docs/oracles.md）。
//
// 1 つのケース表から 2 本を生成する:
//   - examples/strings_std.sober … Sober 側（`import "std/strings"` で各関数を呼んで println）
//   - Go の双子プログラム       … 同じ呼び出しを Go の strings で。その出力が examples/strings_std.out
//
// 再生成手順（リポジトリルートで。要件: node 22.6+（型ストリップで .ts を直接実行）、go 1.21+）:
//   node scripts/strings_oracle.ts examples/strings_std.sober /tmp/strings_oracle.go
//   go run /tmp/strings_oracle.go > examples/strings_std.out
// 突き合わせは scripts/obs.sh（.out と実行出力の一致）と
// `sober check examples/strings_std.sober` が担う。ケースを足すときはこの表に足して再生成する。
// node / go は開発時依存（GNU as オラクルと同格）。ビルドには使わない。
import { writeFileSync } from "node:fs";

type Case = [fn: string, a: string, b: string | number];
const cases: Case[] = [
  // HasPrefix
  ["HasPrefix", "hello world", "hello"], ["HasPrefix", "hello world", "world"],
  ["HasPrefix", "hi", "hello"], ["HasPrefix", "hello", ""], ["HasPrefix", "", ""],
  ["HasPrefix", "", "a"], ["HasPrefix", "abc", "abc"], ["HasPrefix", "abc", "abcd"],
  // HasSuffix
  ["HasSuffix", "hello world", "world"], ["HasSuffix", "hello world", "hello"],
  ["HasSuffix", "lo", "hello"], ["HasSuffix", "abc", ""], ["HasSuffix", "", ""],
  ["HasSuffix", "abc", "abc"], ["HasSuffix", "abcabc", "cabc"],
  // Index
  ["Index", "chicken", "ken"], ["Index", "chicken", "dmr"], ["Index", "abc", ""],
  ["Index", "", ""], ["Index", "", "a"], ["Index", "abc", "abc"], ["Index", "ab", "abc"],
  ["Index", "aaab", "aab"], ["Index", "abcabc", "cab"], ["Index", "xxxxx", "x"],
  ["Index", "あいう", "い"], ["Index", "あいう", "え"],
  // Contains
  ["Contains", "seafood", "foo"], ["Contains", "seafood", "bar"], ["Contains", "seafood", ""],
  ["Contains", "", ""], ["Contains", "", "a"], ["Contains", "ab", "ba"],
  // Count
  ["Count", "cheese", "e"], ["Count", "five", ""], ["Count", "", ""], ["Count", "aaaa", "aa"],
  ["Count", "aaaaa", "aa"], ["Count", "abc", "abcd"], ["Count", "abcabcab", "abc"],
  ["Count", "あいう", ""], ["Count", "ababab", "bab"],
  // IndexByte
  ["IndexByte", "golang", 108], ["IndexByte", "gophers", 104], ["IndexByte", "golang", 120],
  ["IndexByte", "", 97], ["IndexByte", "aaa", 97], ["IndexByte", "abc", 99],
  // TrimPrefix
  ["TrimPrefix", ":id", ":"], ["TrimPrefix", "id", ":"], ["TrimPrefix", "abc", ""], ["TrimPrefix", "", ""],
  ["TrimPrefix", "ab", "abc"], ["TrimPrefix", "あいう", "あ"], ["TrimPrefix", "abcabc", "abc"],
  // Cut（3 つの結果 — 助け手 showCut が並べて印字）
  ["Cut", "k=v", "="], ["Cut", "k=v=w", "="], ["Cut", "kv", "="], ["Cut", "", "="], ["Cut", "abc", ""],
  ["Cut", "=v", "="], ["Cut", "k=", "="], ["Cut", "あ=い", "="], ["Cut", "aXXbXXc", "XX"], ["Cut", "あいう", "い"],
  // CutLast（Go に無い — 双子は strings.LastIndex で同じ形を書く）
  ["CutLast", "a/b/c", "/"], ["CutLast", "abc", "/"], ["CutLast", "/abc", "/"], ["CutLast", "abc/", "/"], ["CutLast", "abc", ""],
  ["CutLast", "", ""], ["CutLast", "aXXbXXc", "XX"], ["CutLast", "あ/い/う", "/"], ["CutLast", "aaa", "aa"],
];

const q = (s: string) => JSON.stringify(s); // 両言語とも "..." のエスケープで足りる範囲に留める
const arg = (b: string | number) => (typeof b === "number" ? String(b) : q(b));

// 3 つの結果を返す Cut / CutLast は助け手（showCut / showCutLast）が並べて印字する（両言語とも空白区切り）
const multi = (f: string) => f === "Cut" || f === "CutLast";
const sober = [
  "package main", "", "// Go の strings パッケージとの突き合わせ。生成物 — scripts/strings_oracle.ts から再生成する",
  "", 'import "std/strings"', "",
  "func showCut(s string, sep string) {", "    a, b, ok := strings.Cut(s, sep)", "    println(a, b, ok)", "}", "",
  "func showCutLast(s string, sep string) {", "    a, b, ok := strings.CutLast(s, sep)", "    println(a, b, ok)", "}", "",
  "func main() {",
  ...cases.map(([f, a, b]) => multi(f) ? `    show${f}(${q(a)}, ${arg(b)})` : `    println(strings.${f}(${q(a)}, ${arg(b)}))`),
  "}", "",
].join("\n");

// IndexByte の c は両言語とも byte（範囲外の定数は Sober でもコンパイルエラー — std 命名規則 5）
const goCall = ([f, a, b]: Case) => f === "CutLast" ? `cutLast(${q(a)}, ${arg(b)})` : `strings.${f}(${q(a)}, ${arg(b)})`;
const go = [
  "package main", "", 'import (\n\t"fmt"\n\t"strings"\n)', "",
  "func cutLast(s, sep string) (string, string, bool) {",
  "\ti := strings.LastIndex(s, sep)", "\tif i < 0 {", "\t\treturn s, \"\", false", "\t}", "\treturn s[:i], s[i+len(sep):], true", "}", "",
  "func main() {",
  ...cases.map((c) => `\tfmt.Println(${goCall(c)})`),
  "}", "",
].join("\n");

const [soberPath, goPath] = process.argv.slice(2);
if (!soberPath || !goPath) {
  console.error("usage: node scripts/strings_oracle.ts <out.sober> <out.go>");
  process.exit(1);
}
writeFileSync(soberPath, sober);
writeFileSync(goPath, go);
console.log(`${cases.length} cases`);
