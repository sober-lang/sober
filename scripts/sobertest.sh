#!/usr/bin/env bash
# `sober test` の骨格の照合:
#   ① testdata/sobertest/calc のテストの出力（1 テスト 1 サブプロセス・列挙の規則・失敗の集計）が testdata/sobertest/calc.expect と一致し、終了コード 1
#   ③ 署名の合わない Test… は位置つきで拒否（T3）・④ check --test（T12）・⑤ -run（T8）・⑥ power assert（T5）
#   ② 通常のビルド（testdata/sobertest/app — calc を import）は calc_test.sober を読まない（loader の JSON の関数の一覧に TestAdd / must が無く half がある）・実行の出力 42
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$SOBER" test testdata/sobertest/calc > "$W/out" 2>&1
ec=$?
[ "$ec" = 1 ] || { echo "FAIL: sober test exit $ec (want 1)"; fail=1; }
diff "$W/out" testdata/sobertest/calc.expect > "$W/diff" || { echo "FAIL: sober test output"; head -10 "$W/diff"; fail=1; }
"$SOBER" parse --loader-json testdata/sobertest/app > "$W/lj" || { echo "FAIL: loader-json app"; fail=1; }
grep -q '"TestAdd"\|"must"' "$W/lj" && { echo "FAIL: the normal build read calc_test.sober"; fail=1; }
grep -q '"half"' "$W/lj" || { echo "FAIL: the normal build did not read calc.sober"; fail=1; }
"$SOBER" build testdata/sobertest/app -o "$W/app" > /dev/null && [ "$("$W/app")" = 42 ] || { echo "FAIL: app"; fail=1; }
# ⑥ power assert（T5）の失敗の印字（式の綴り + 部分式の値 — 標準エラー）
"$SOBER" test testdata/sobertest/asserts > "$W/as" 2>&1 && { echo "FAIL: asserts passed"; fail=1; }
diff "$W/as" testdata/sobertest/asserts.expect > "$W/asd" || { echo "FAIL: asserts output"; head -10 "$W/asd"; fail=1; }
"$SOBER" check testdata/sobertest/asserts --test > /dev/null || { echo "FAIL: check --test asserts"; fail=1; }
# ⑤ -run は名前の接頭辞で絞る（T8）
[ "$("$SOBER" test testdata/sobertest/calc -run TestH)" = "$(printf 'ok   testdata/sobertest/calc.TestHalf\n1 passed, 0 failed')" ] || { echo "FAIL: -run"; fail=1; }
# ③ 署名の合わない Test…（T3）は loader の拒否（位置つき）・④ check --test（T12）はテストのビルドを検査する
"$SOBER" test testdata/sobertest/badsig > "$W/bad" 2>&1 && { echo "FAIL: badsig accepted"; fail=1; }
grep -q 'badsig_test.sober:3:6: a test function' "$W/bad" || { echo "FAIL: badsig diagnostic"; cat "$W/bad"; fail=1; }
"$SOBER" check testdata/sobertest/calc --test > "$W/chk" || { echo "FAIL: check --test calc"; cat "$W/chk"; fail=1; }
"$SOBER" check testdata/sobertest/badsig --test > /dev/null 2>&1 && { echo "FAIL: check --test badsig accepted"; fail=1; }
echo "sobertest: fail=$fail"
[ "$fail" = 0 ]
