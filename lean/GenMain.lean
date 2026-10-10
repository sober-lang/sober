import FeatherweightSober.Gen
import FeatherweightSober.TyVec

/-!
# sober-gen: 差分テストベクタ生成バイナリ

`lake exe sober-gen <seed> <count>` — stdout に JSONL を吐く。
各行 `{"e": <コア AST JSON>, "v": <判定 JSON>}`。v は sober-check と同じ形
（`{"ok":true,"ty":…}` / `{"ok":false,"errors":[…]}`）で、Lean 製検査器の golden 判定。

同じ seed / count / toolchain なら出力は同一（StdGen は決定的）。
golden セットの再生成と照合は scripts/corevec.sh。
-/
def main (args : List String) : IO UInt32 := do
  -- `sober-gen --tyvec <seed> <count>`: 型の関数の差分ベクタ（FeatherweightSober/TyVec.lean — 抽出器 E1b）
  if args.head? == some "--tyvec" then
    let seed := (args[1]?.bind String.toNat?).getD 42
    let count := (args[2]?.bind String.toNat?).getD 1000
    let stdout ← IO.getStdout
    for line in FS.TyVec.vectors seed count do
      stdout.putStrLn line
    return 0
  let seed := (args[0]?.bind String.toNat?).getD 42
  let count := (args[1]?.bind String.toNat?).getD 300
  let stdout ← IO.getStdout
  for line in FS.Gen.vectors seed count do
    stdout.putStrLn line
  return 0
