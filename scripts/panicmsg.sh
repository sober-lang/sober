#!/usr/bin/env bash
# panicの観測性（最初のタスク）: 死ぬ例のstderr（`panic: <種類> at <file>:<line>:<col>` / regionの超過の死亡ダンプ）をゴールデン <例>.stderrと照合する。
# obsは終了コードとstdoutだけを見る（stderrは捨てる）ので、ここがstderrの検査。対象 = examples/*.exitとtestdata/*/app.exitのうち .stderrを持つもの。
#   scripts/panicmsg.sh            照合
#   scripts/panicmsg.sh --regen    .exit を持つ例全部の .stderr を作り直す（文面を意図して変えたとき — 差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
regen=0
[ "${1:-}" = "--regen" ] && regen=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
n=0; fail=0
for x in examples/*.exit testdata/*/app.exit; do
    [ -f "$x" ] || continue
    e=${x%.exit}
    src=$e.sober; [ -d "$e" ] && src=$e
    [ -e "$src" ] || continue
    [ $regen = 1 ] || [ -f "$e.stderr" ] || continue
    "$SOBER" build "$src" -o "$W/x" > /dev/null 2>&1 || { echo "FAIL: $src: build"; fail=$((fail + 1)); continue; }
    "$W/x" > /dev/null 2> "$W/err" < /dev/null
    if [ $regen = 1 ]; then cp "$W/err" "$e.stderr"; n=$((n + 1)); continue; fi
    if cmp -s "$W/err" "$e.stderr"; then n=$((n + 1)); else echo "FAIL: $src: stderr differs from $e.stderr"; diff "$e.stderr" "$W/err" | head -4; fail=$((fail + 1)); fi
done
echo "panicmsg: $n programs' stderr match, fail=$fail"
[ "$fail" = 0 ]
