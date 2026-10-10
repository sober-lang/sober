// regiondrop: 2 本の IR テキスト（.ir）または LLVM テキスト（.ll）の差が「region 操作の行の除去と値の番号の振り直しだけ」かを照合する
// （黄金の例外 3 件目 — lower の閉包の本体の `{ }` を region で囲まなくした修正）。
//
//   node scripts/regiondrop.ts OLD NEW    exit 0 = 一致、1 = 不一致（理由を stderr に 1 行）
//
// 照合: 両方の値の番号（%12・%v12・%st3 …）と .ll の分岐の補助ラベルの連番を伏せ字にしてから、NEW が OLD の部分列で、OLD から落ちた行がすべて region 操作の行であることを見る。
// region 操作の行: .ir = `%_ = region.depth`・`region.enter`・`region.setdepth %_`。.ll = rtlower の下ろし（深度の語 @rt.meta[0] の読み・書きと
// rt.region_enter の呼び出し）。番号を伏せるのでデータの流れは見ない — 落ちるのが region 操作だけで、残りの命令列が同じことを見る
import { readFileSync } from "node:fs";

const [oldPath, newPath] = process.argv.slice(2);
// 伏せ字: 値の番号（%12・%v12・%st3・%v3.p）と .ll の分岐の補助ラベルの連番（b15.t39・b15.e40 — condbr の割り方の通し番号）
const norm = (s: string) => s.split("\n").map((l) => l.replace(/%(v|st|s)?[0-9]+(\.[a-z]+)?/g, "%$1_$2").replace(/\b(b[0-9]+)\.(t|e)[0-9]+\b/g, "$1.$2_"));
const DROP = new Set([
  "  %_ = region.depth",
  "  region.enter",
  "  region.setdepth %_",
  '  %v_ = getelementptr i64, ptr @"rt.meta", i64 0',
  "  %v_.p = getelementptr i64, ptr %v_, i64 0",
  "  %v_ = load i64, ptr %v_.p",
  '  call void @"rt.region_enter"()',
  "  %st_ = getelementptr i64, ptr %v_, i64 0",
  "  store i64 %v_, ptr %st_",
]);

const a = norm(readFileSync(oldPath, "utf8"));
const b = norm(readFileSync(newPath, "utf8"));
let i = 0, j = 0, dropped = 0;
while (j < b.length) {
  if (i >= a.length) {
    console.error(`regiondrop: NEW has extra line ${j + 1}: ${JSON.stringify(b[j])}`);
    process.exit(1);
  }
  if (a[i] === b[j]) { i++; j++; continue; }
  if (!DROP.has(a[i])) {
    console.error(`regiondrop: OLD line ${i + 1} is not a region op and is missing from NEW (NEW line ${j + 1}): ${JSON.stringify(a[i])} vs ${JSON.stringify(b[j])}`);
    process.exit(1);
  }
  i++; dropped++;
}
for (; i < a.length; i++, dropped++) {
  if (!DROP.has(a[i])) {
    console.error(`regiondrop: OLD trailing line ${i + 1} is not a region op: ${JSON.stringify(a[i])}`);
    process.exit(1);
  }
}
console.log(`regiondrop: ok (${dropped} region-op lines dropped)`);
