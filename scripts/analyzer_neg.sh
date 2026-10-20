#!/usr/bin/env bash
# analyzer の負例の照合: testdata/analyzer_neg/*.sober を主の `sober check` に掛け、標準エラー（指摘の行 — `(Analyzer)`）が
# 期待の <name>.err とバイト一致すること（判定 JSON は出ない・終了コード 1）。acquire / release の負例は pool_oracle.sh（Zig 版とも照合）。
# <name>.exit があれば build（analyzer を走らせない — 決定 E4-B）して実行し、終了コードと標準出力（<name>.out）を照合する
# （網羅していない error の switch は build が受理し、覆っていないラベルが来たら exit 101）。
# <name>.warn があれば警告の例（性能の lint — 受理は変えない）: 終了コード 0・判定 JSON が出て・標準エラーが <name>.warn とバイト一致。
# <name>.build があれば build も拒否すること（健全性の規則 — freeze の U1〜U3〔language.md 17 節〕は build でも走る）: 終了コード 1・標準エラーが同じ <name>.err。
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
    if [ -f "${s%.sober}.warn" ]; then
        [ "$ec" = 0 ] || { echo "FAIL $s: exit $ec (want 0 — warnings do not reject)"; fail=1; }
        grep -q '"ok":true' "$W/out" || { echo "FAIL $s: no accepting verdict"; fail=1; }
        diff -q "$W/err" "${s%.sober}.warn" > /dev/null || { echo "FAIL $s:"; diff "$W/err" "${s%.sober}.warn" | head -5; fail=1; }
        continue
    fi
    [ "$ec" = 1 ] || { echo "FAIL $s: exit $ec (want 1)"; fail=1; }
    [ -s "$W/out" ] && { echo "FAIL $s: a verdict was printed"; fail=1; }
    diff -q "$W/err" "${s%.sober}.err" > /dev/null || { echo "FAIL $s:"; diff "$W/err" "${s%.sober}.err" | head -5; fail=1; }
    if [ -f "${s%.sober}.build" ]; then
        "$SOBER" build "$s" -o "$W/bin" > "$W/bout" 2> "$W/berr"
        bec=$?
        [ "$bec" = 1 ] || { echo "FAIL $s: build exit $bec (want 1 — soundness rule)"; fail=1; }
        diff -q "$W/berr" "${s%.sober}.err" > /dev/null || { echo "FAIL $s: build diagnostics:"; diff "$W/berr" "${s%.sober}.err" | head -5; fail=1; }
    fi
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
