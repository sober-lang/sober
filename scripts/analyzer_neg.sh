#!/usr/bin/env bash
# analyzer の負例の照合: testdata/analyzer_neg/*.sober を主の `sober check` に掛け、標準エラー（指摘の行 — `(Analyzer)`）が
# 期待の <name>.err とバイト一致すること（判定 JSON は出ない・終了コード 1）。acquire / release の負例は pool_oracle.sh（Zig 版とも照合）。
# <name>.exit があれば build（analyzer を走らせない — 決定 E4-B）して実行し、終了コードと標準出力（<name>.out）を照合する
# （網羅していない error の switch は build が受理し、覆っていないラベルが来たら exit 101）。
#
#   scripts/analyzer_neg.sh
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
for s in testdata/analyzer_neg/*.sober; do
    n=$((n + 1))
    "$SOBER" check "$s" > "$W/out" 2> "$W/err"
    ec=$?
    [ "$ec" = 1 ] || { echo "FAIL $s: exit $ec (want 1)"; fail=1; }
    [ -s "$W/out" ] && { echo "FAIL $s: a verdict was printed"; fail=1; }
    diff -q "$W/err" "${s%.sober}.err" > /dev/null || { echo "FAIL $s:"; diff "$W/err" "${s%.sober}.err" | head -5; fail=1; }
    if [ -f "${s%.sober}.exit" ]; then
        "$SOBER" build "$s" -o "$W/bin" > /dev/null 2>&1 || { echo "FAIL $s: build"; fail=1; continue; }
        "$W/bin" > "$W/run" 2> /dev/null
        rec=$?
        [ "$rec" = "$(cat "${s%.sober}.exit")" ] || { echo "FAIL $s: run exit $rec"; fail=1; }
        diff -q "$W/run" "${s%.sober}.out" > /dev/null || { echo "FAIL $s: run output"; fail=1; }
    fi
done
echo "analyzer_neg: $n files, fail=$fail"
exit $fail
