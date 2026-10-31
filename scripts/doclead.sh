#!/usr/bin/env bash
# doclead（gates）: 宣言の doc コメントが宣言自身の名前で始まらないこと（src/compiler・src/std・examples）。宣言と doc の見つけ方は
# `sober outline` と同じ（doc = 宣言の直前の `//` の行の最初の段落）。判定は scripts/doclead.ts。負例 1 本（名前で始まる doc が名指しされる）
set -uo pipefail
cd "$(dirname "$0")/.."
scripts/stage2.sh --quiet || exit 1
S2=$PWD/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$S2" outline src/compiler --depth 9 --format=json > "$W/compiler.json" || fail=1
"$S2" outline src/std --depth 9 --format=json > "$W/std.json" || fail=1
"$S2" outline examples --format=json > "$W/examples.json" 2> /dev/null   # examples には拒否の例（parse できない題材）がある — 終了 1 は見ない
node --experimental-strip-types --no-warnings scripts/doclead.ts "$W/compiler.json" "$W/std.json" "$W/examples.json" || fail=1
printf 'package main\n\n// neg は名前で始まる doc\nfunc neg() int {\n    return 0\n}\n' > "$W/neg.sober"
"$S2" outline "$W/neg.sober" --format=json > "$W/neg.json"
node --experimental-strip-types --no-warnings scripts/doclead.ts "$W/neg.json" > "$W/neg.out"
grep -q "^FAIL .*neg.sober:4: the doc comment of neg" "$W/neg.out" || { echo "FAIL negative: a doc starting with its own name was not named"; fail=1; }
echo "doclead: fail=$fail"
exit $fail
