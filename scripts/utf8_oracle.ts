// std/utf8 の差分オラクル — Go の unicode/utf8 を真実として期待値を作る（strings_oracle.ts と同じ作法）。
//
// 1 つのケース表（バイト列）から 2 本を生成する:
//   - examples/utf8_std.sober … Sober 側（utf8.Invalid / utf8.Valid と `string(b)` を呼んで println）
//   - Go の双子プログラム     … 同じバイト列を Go で。その出力が examples/utf8_std.out
//
// 再生成手順（リポジトリルートで。要件: node 22.6+、go 1.21+）:
//   node scripts/utf8_oracle.ts examples/utf8_std.sober /tmp/utf8_oracle.go
//   go run /tmp/utf8_oracle.go > examples/utf8_std.out
// Invalid の Go 側 = 先頭から DecodeRune して、RuneError かつ幅 1 の最初の位置（U+FFFD 自体は幅 3 で妥当）
import { writeFileSync } from "node:fs";

const cases: number[][] = [
  [], [104, 105], [0], [127],
  [0xc3, 0xa9], [0xc2, 0x80], [0xdf, 0xbf], [0xc0, 0x80], [0xc1, 0xbf], [0xc2], [0xc2, 0x41],
  [0xe0, 0xa0, 0x80], [0xe0, 0x9f, 0xbf], [0xe3, 0x81, 0x82], [0xed, 0x9f, 0xbf], [0xed, 0xa0, 0x80],
  [0xee, 0x80, 0x80], [0xef, 0xbf, 0xbf], [0xef, 0xbf, 0xbd], [0xe3, 0x81], [0x41, 0xe3, 0x81, 0x41],
  [0xf0, 0x90, 0x80, 0x80], [0xf0, 0x8f, 0xbf, 0xbf], [0xf0, 0x9f, 0x98, 0x80], [0xf4, 0x8f, 0xbf, 0xbf],
  [0xf4, 0x90, 0x80, 0x80], [0xf5, 0x80, 0x80, 0x80], [0xf0, 0x9f, 0x98], [0xff], [0xfe], [0x80], [0xbf],
  [0x61, 0xc3, 0xa9, 0xe2, 0x82, 0xac, 0xf0, 0x9f, 0x98, 0x80], [0x61, 0x62, 0x80, 0x63],
];
// 塊の境目をまたぐ長いケース（UTF-8 の SIMD 速い道便: 最適化のバックエンドの検査器は 16 バイトの塊ずつ読む）。前置き（ASCII の
// 12〜17・28〜33 バイト・多バイト文字の連なり）の後に列（妥当・不正・特別な頭・切れ）を置き、ASCII で 40 バイト前後まで埋める
const seqs: number[][] = [
  [0xc3, 0xa9], [0xe3, 0x81, 0x82], [0xef, 0xbf, 0xbd], [0xf0, 0x9f, 0x98, 0x80], [0xc3], [0xc3, 0x41], [0xe3, 0x81, 0x41],
  [0xe0, 0x9f, 0xbf], [0xe0, 0xa0, 0x80], [0xed, 0xa0, 0x80], [0xed, 0x9f, 0xbf], [0xc0, 0x80], [0xff], [0x80], [0xf4, 0x90, 0x80, 0x80],
];
const pres: number[][] = [12, 13, 14, 15, 16, 17, 28, 31, 32, 33].map((k) => Array(k).fill(0x61));
for (const m of [6, 7, 8, 15]) pres.push(Array.from({ length: m }, () => [0xc3, 0xa9]).flat());
pres.push(Array.from({ length: 5 }, () => [0xe3, 0x81, 0x82]).flat());
for (const pre of pres) {
  for (const q of seqs) {
    const b = [...pre, ...q];
    while (b.length < 40) b.push(0x62);
    cases.push(b);
  }
}
cases.push([...Array(30).fill(0x61), 0xe3, 0x81]);
cases.push([...Array(15).fill(0x61), 0xe3]);
cases.push(Array.from({ length: 12 }, () => [0xe3, 0x81, 0x82]).flat());

const sl = (b: number[]) => `[]byte{${b.join(", ")}}`;
const sober = [
  "package main", "", "// Go の unicode/utf8 との突き合わせ。生成物 — scripts/utf8_oracle.ts から再生成する",
  "", 'import "std/utf8"', "",
  "func show(b []byte) {",
  "    s, err := string(b)",
  "    if err != nil {",
  "        switch err {",
  '        case utf8.InvalidUtf8{pos}: println("bad", pos)',
  "        }",
  "    } else {",
  '        println("ok", s)',
  "    }",
  "}", "", "func main() {",
  ...cases.flatMap((b) => [`    println(utf8.IndexInvalid(${sl(b)}), utf8.Valid(${sl(b)}))`, `    show(${sl(b)})`]),
  "}", "",
].join("\n");

const gb = (b: number[]) => `[]byte{${b.join(", ")}}`;
const go = [
  "package main", "", 'import (\n\t"fmt"\n\t"unicode/utf8"\n)', "",
  "func invalid(b []byte) int {",
  "\tfor i := 0; i < len(b); {",
  "\t\tr, n := utf8.DecodeRune(b[i:])",
  "\t\tif r == utf8.RuneError && n <= 1 {",
  "\t\t\treturn i",
  "\t\t}",
  "\t\ti += n",
  "\t}",
  "\treturn -1",
  "}", "",
  "func show(b []byte) {",
  "\tif at := invalid(b); at >= 0 {",
  '\t\tfmt.Println("bad", at)',
  "\t} else {",
  '\t\tfmt.Println("ok", string(b))',
  "\t}",
  "}", "", "func main() {",
  ...cases.flatMap((b) => [`\tfmt.Println(invalid(${gb(b)}), utf8.Valid(${gb(b)}))`, `\tshow(${gb(b)})`]),
  "}", "",
].join("\n");

const [soberPath, goPath] = process.argv.slice(2);
writeFileSync(soberPath, sober);
writeFileSync(goPath, go);
