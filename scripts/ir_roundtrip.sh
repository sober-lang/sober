#!/usr/bin/env bash
# backend レーン所有: IR テキストの往復不動点（B-6）。examples/*.out の各例について
#   sober build x.sober --emit=ir → a.ir、sober build a.ir --emit=ir → b.ir で a.ir ≡ b.ir（print(parse(t)) == t）、
#   sober build a.ir --emit=ll ≡ sober build x.sober --emit=ll（テキストを経由しても同じ .ll — コンポーネント境界の成立）
# IR パスの出力（--opt: mem2reg）も同じく往復すること（c.ir ≡ d.ir）を確かめる。実行: リポジトリルートで `zig build` 済みの状態から scripts/ir_roundtrip.sh [例名 ...]
cd "$(dirname "$0")/.." || exit 1
STAGE1=./src/stage1/zig-out/bin/sober
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
names=("$@")
if [ ${#names[@]} = 0 ]; then
  for f in examples/*.out; do names+=("$(basename "$f" .out)"); done
fi
n=0
fail=0
for name in "${names[@]}"; do
  n=$((n + 1))
  src=examples/$name.sober
  if ! "$STAGE1" build "$src" --emit=ir -o "$W/a.ir" 2>"$W/err" || ! "$STAGE1" build "$src" --emit=ll -o "$W/a.ll" 2>>"$W/err" ||
     ! "$STAGE1" build "$W/a.ir" --emit=ir -o "$W/b.ir" 2>>"$W/err" || ! "$STAGE1" build "$W/a.ir" --emit=ll -o "$W/b.ll" 2>>"$W/err" ||
     ! "$STAGE1" build "$src" --emit=ir --opt -o "$W/c.ir" 2>>"$W/err" || ! "$STAGE1" build "$W/c.ir" --emit=ir -o "$W/d.ir" 2>>"$W/err"; then
    echo "FAIL $name: $(head -1 "$W/err")"
    fail=$((fail + 1))
    continue
  fi
  if ! cmp -s "$W/a.ir" "$W/b.ir"; then
    echo "FAIL $name: IR text is not a fixpoint"; diff "$W/a.ir" "$W/b.ir" | head -5
    fail=$((fail + 1))
  elif ! cmp -s "$W/c.ir" "$W/d.ir"; then
    echo "FAIL $name: IR text after --opt is not a fixpoint"; diff "$W/c.ir" "$W/d.ir" | head -5
    fail=$((fail + 1))
  elif ! cmp -s "$W/a.ll" "$W/b.ll"; then
    echo "FAIL $name: .ll differs after the IR text round trip"; diff "$W/a.ll" "$W/b.ll" | head -5
    fail=$((fail + 1))
  fi
done
echo "ir roundtrip: $n programs, fail=$fail"
[ $fail = 0 ]
