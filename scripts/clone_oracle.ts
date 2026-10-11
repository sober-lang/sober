// builtin clone(x) の差分オラクル — Go の slices.Clone / maps.Clone を真実として期待値を作る（docs/oracles.md・strings_oracle.ts と同じ形）。
//
// 1 つのケース表から 2 本を生成する:
//   - examples/clone_std.sober … Sober 側（clone(x) で写し、写した後に元と写しを書き換えて両方を println）
//   - Go の双子プログラム     … 同じ操作を Go で。その出力が examples/clone_std.out
//
// 再生成手順（リポジトリルートで。要件: node 22.6+、go 1.21+）:
//   node scripts/clone_oracle.ts examples/clone_std.sober /tmp/clone_oracle.go
//   go run /tmp/clone_oracle.go > examples/clone_std.out
// 突き合わせは scripts/obs.sh（.out と実行出力の一致）と `sober check examples/clone_std.sober` が担う。
// map の印字はケース表の鍵の順で引く（Go の map の列挙は乱択 — 列挙の順の約束〔Sober は初回挿入の順〕は Sober 側が keys の列の一致を自分で見て
// `order true` を出し、Go 側は同じ行を定数で出す）
import { writeFileSync } from "node:fs";

// 列のケース: [名前, 要素, 写した後に元へ足す要素, 写した後に元の添字 0 へ書く値（無ければ null）]
type SCase = [name: string, xs: number[], add: number[], set: number | null];
const sliceCases: SCase[] = [
  ["empty", [], [], null],
  ["one", [7], [8], 70],
  ["many", [1, 2, 3, 4, 5], [6, 7], 100],
  ["neg", [-1, 0, -9007199254740991], [], -5],
  ["grow", Array.from({ length: 40 }, (_, i) => i * i), [41, 42, 43], 999],
];
// 文字列の列のケース（要素が imm の string — 写しは要素のヘッダの写し）
const strCases: [string, string[], string[]][] = [
  ["words", ["a", "bb", "ccc"], ["dddd"]],
  ["utf8", ["あ", "いう", ""], ["え"]],
];
// map のケース: [名前, 挿入 [鍵, 値]…, 写す前に消す鍵, 写した後に元へ書く [鍵, 値]…, 写した後に元から消す鍵]
type MCase = [name: string, ins: [string, number][], delBefore: string[], after: [string, number][], delAfter: string[]];
const mapCases: MCase[] = [
  ["empty", [], [], [["x", 1]], []],
  ["small", [["a", 1], ["b", 2], ["c", 3]], [], [["a", 10], ["d", 4]], ["b"]],
  ["tomb", [["k1", 1], ["k2", 2], ["k3", 3], ["k4", 4]], ["k2"], [["k2", 22]], ["k4"]],
  ["long", Array.from({ length: 12 }, (_, i) => [`long-key-for-the-clone-test-${i}`, i] as [string, number]), ["long-key-for-the-clone-test-3"], [["long-key-for-the-clone-test-0", 100]], ["long-key-for-the-clone-test-5"]],
];

const [, , soberPath, goPath] = process.argv;
if (!soberPath || !goPath) {
  console.error("usage: node scripts/clone_oracle.ts <out.sober> <out.go>");
  process.exit(2);
}
const q = (s: string) => JSON.stringify(s);
const allKeys = (c: MCase) => [...new Set([...c[1].map((e) => e[0]), ...c[3].map((e) => e[0])])];

let sb = `package main

// 生成物 — scripts/clone_oracle.ts（期待値 clone_std.out は Go の slices.Clone / maps.Clone の双子の出力）。手で直さない。
// 写した後に元を書き換えても写しは変わらないこと・元は凍らずに書き続けられること（clone は写すだけ — 元を凍らせない）・
// 写しは書ける（mut — imm の列からも書ける写しが取れる）・imm の位置に置いた clone(x) はその場で凍ること（showInts(…, clone(xs)) の形）を見る

func showInts(tag string, xs []int) {
    mut line := "\${tag} \${len(xs)}:"
    for x <- xs {
        line = line + " \${x}"
    }
    println(line)
}

func showStrs(tag string, xs []string) {
    mut line := "\${tag} \${len(xs)}:"
    for x <- xs {
        line = line + " [" + x + "]"
    }
    println(line)
}

func showMap(tag string, m map[string]int, ks []string) {
    mut line := "\${tag} \${len(m)}:"
    for k <- ks {
        v := m[k]
        if v != nil {
            line = line + " " + k + "=\${v}"
        }
    }
    println(line)
}

func showIntMap(tag string, m map[int]int, ks []int) {
    mut line := "\${tag} \${len(m)}:"
    for k <- ks {
        v := m[k]
        if v != nil {
            line = line + " \${k}=\${v}"
        }
    }
    println(line)
}

func sameOrder(a []string, b []string) bool {
    if len(a) != len(b) {
        return false
    }
    mut i := 0
    while i < len(a) {
        if a[i] != b[i] {
            return false
        }
        i += 1
    }
    return true
}

func main() {
`;
let gb = `package main

// 生成物 — scripts/clone_oracle.ts（Sober の examples/clone_std.sober の双子）

import (
\t"fmt"
\t"maps"
\t"slices"
)

func showInts(tag string, xs []int) {
\tline := fmt.Sprintf("%s %d:", tag, len(xs))
\tfor _, x := range xs {
\t\tline += fmt.Sprintf(" %d", x)
\t}
\tfmt.Println(line)
}

func showStrs(tag string, xs []string) {
\tline := fmt.Sprintf("%s %d:", tag, len(xs))
\tfor _, x := range xs {
\t\tline += " [" + x + "]"
\t}
\tfmt.Println(line)
}

func showMap(tag string, m map[string]int, ks []string) {
\tline := fmt.Sprintf("%s %d:", tag, len(m))
\tfor _, k := range ks {
\t\tif v, ok := m[k]; ok {
\t\t\tline += fmt.Sprintf(" %s=%d", k, v)
\t\t}
\t}
\tfmt.Println(line)
}

func showIntMap(tag string, m map[int]int, ks []int) {
\tline := fmt.Sprintf("%s %d:", tag, len(m))
\tfor _, k := range ks {
\t\tif v, ok := m[k]; ok {
\t\t\tline += fmt.Sprintf(" %d=%d", k, v)
\t\t}
\t}
\tfmt.Println(line)
}

func main() {
`;
for (const [name, xs, add, set] of sliceCases) {
  const v = `s_${name}`;
  sb += `    mut ${v} := mut []int{}\n`;
  for (const x of xs) sb += `    ${v} = append(${v}, ${x})\n`;
  sb += `    showInts("${name}.view", clone(${v}))\n    c_${name} := clone(${v})\n`;
  for (const x of add) sb += `    ${v} = append(${v}, ${x})\n`;
  if (set !== null) sb += `    ${v}[0] = ${set}\n`;
  sb += `    showInts("${name}.orig", freeze(${v}))\n    showInts("${name}.clone", c_${name})\n`;
  gb += `\t${v} := []int{${xs.join(", ")}}\n\tshowInts("${name}.view", slices.Clone(${v}))\n\tc_${name} := slices.Clone(${v})\n`;
  for (const x of add) gb += `\t${v} = append(${v}, ${x})\n`;
  if (set !== null) gb += `\t${v}[0] = ${set}\n`;
  gb += `\tshowInts("${name}.orig", ${v})\n\tshowInts("${name}.clone", c_${name})\n`;
  // imm の列から書ける写し: 写しの先頭を書き換えても元（凍った列）は変わらない
  if (xs.length > 0) {
    sb += `    mut w_${name} := clone(c_${name})\n    w_${name}[0] = 4242\n    w_${name} = append(w_${name}, 1)\n    showInts("${name}.rewrite", freeze(w_${name}))\n    showInts("${name}.clone2", c_${name})\n`;
    gb += `\tw_${name} := slices.Clone(c_${name})\n\tw_${name}[0] = 4242\n\tw_${name} = append(w_${name}, 1)\n\tshowInts("${name}.rewrite", w_${name})\n\tshowInts("${name}.clone2", c_${name})\n`;
  }
}
for (const [name, xs, add] of strCases) {
  const v = `t_${name}`;
  sb += `    mut ${v} := mut []string{}\n`;
  for (const x of xs) sb += `    ${v} = append(${v}, ${q(x)})\n`;
  sb += `    d_${name} := clone(${v})\n`;
  for (const x of add) sb += `    ${v} = append(${v}, ${q(x)})\n`;
  sb += `    ${v}[0] = "changed"\n    showStrs("${name}.orig", freeze(${v}))\n    showStrs("${name}.clone", d_${name})\n`;
  gb += `\t${v} := []string{${xs.map(q).join(", ")}}\n\td_${name} := slices.Clone(${v})\n`;
  for (const x of add) gb += `\t${v} = append(${v}, ${q(x)})\n`;
  gb += `\t${v}[0] = "changed"\n\tshowStrs("${name}.orig", ${v})\n\tshowStrs("${name}.clone", d_${name})\n`;
}
for (const c of mapCases) {
  const [name, ins, delBefore, after, delAfter] = c;
  const v = `m_${name}`;
  const ks = `[]string{${allKeys(c).map(q).join(", ")}}`;
  sb += `    mut ${v} := mut map[string]int{}\n`;
  for (const [k, x] of ins) sb += `    ${v}[${q(k)}] = ${x}\n`;
  for (const k of delBefore) sb += `    delete(${v}, ${q(k)})\n`;
  sb += `    n_${name} := clone(${v})\n`;
  sb += `    println("${name}.order", sameOrder(keys(${v}), keys(n_${name})))\n`;
  for (const [k, x] of after) sb += `    ${v}[${q(k)}] = ${x}\n`;
  for (const k of delAfter) sb += `    delete(${v}, ${q(k)})\n`;
  sb += `    showMap("${name}.orig", freeze(${v}), ${ks})\n    showMap("${name}.clone", n_${name}, ${ks})\n`;
  gb += `\t${v} := map[string]int{}\n`;
  for (const [k, x] of ins) gb += `\t${v}[${q(k)}] = ${x}\n`;
  for (const k of delBefore) gb += `\tdelete(${v}, ${q(k)})\n`;
  gb += `\tn_${name} := maps.Clone(${v})\n\tfmt.Println("${name}.order", true)\n`;
  for (const [k, x] of after) gb += `\t${v}[${q(k)}] = ${x}\n`;
  for (const k of delAfter) gb += `\tdelete(${v}, ${q(k)})\n`;
  gb += `\tshowMap("${name}.orig", ${v}, ${ks})\n\tshowMap("${name}.clone", n_${name}, ${ks})\n`;
}
// int を鍵に持つ map
{
  const ins: [number, number][] = [[3, 30], [1, 10], [2, 20], [100, 1000]];
  const ks = `[]int{3, 1, 2, 100, 7}`;
  sb += `    mut im := mut map[int]int{}\n`;
  for (const [k, x] of ins) sb += `    im[${k}] = ${x}\n`;
  sb += `    delete(im, 1)\n    ic := clone(im)\n    im[7] = 70\n    im[3] = 33\n`;
  sb += `    showIntMap("int.orig", freeze(im), ${ks})\n    showIntMap("int.clone", ic, ${ks})\n`;
  gb += `\tim := map[int]int{}\n`;
  for (const [k, x] of ins) gb += `\tim[${k}] = ${x}\n`;
  gb += `\tdelete(im, 1)\n\tic := maps.Clone(im)\n\tim[7] = 70\n\tim[3] = 33\n`;
  gb += `\tshowIntMap("int.orig", im, ${ks})\n\tshowIntMap("int.clone", ic, ${ks})\n`;
}
sb += `}\n`;
gb += `}\n`;
writeFileSync(soberPath, sb);
writeFileSync(goPath, gb);
