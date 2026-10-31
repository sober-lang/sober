#!/usr/bin/env bash
# `sober test` の骨格の照合:
#   ① testdata/sobertest/calc のテストの出力（1 テスト 1 サブプロセス・列挙の規則・失敗の集計）が testdata/sobertest/calc.expect と一致し、終了コード 1
#   ③ 署名の合わない Test… は位置つきで拒否（T3）・④ check --test（T12）・⑤ --run（T8）・⑥ power assert（T5）・⑦ std/quick の写し・⑧ quick の掛け戻しとコーパス・⑨ sober fuzz
#   ② 通常のビルド（testdata/sobertest/app — calc を import）は calc_test.sober を読まない（loader の JSON の関数の一覧に TestAdd / must が無く half がある）・実行の出力 42
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
# 別の cwd から呼ぶ用の絶対パス
case $SOBER in /*) SA=$SOBER ;; *) SA=$PWD/$SOBER ;; esac
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
# ⑦ std/quick の写し（loader の quickx）: 縮めた反例の再生でだけ性質の値の式を power assert の形で印字・テストの名前の種・Assume の捨てた数の行
"$SOBER" test testdata/sobertest/props > "$W/qp" 2>&1 && { echo "FAIL: props passed"; fail=1; }
diff "$W/qp" testdata/sobertest/props.expect > "$W/qpd" || { echo "FAIL: props output"; head -10 "$W/qpd"; fail=1; }
"$SOBER" check testdata/sobertest/props --test > /dev/null || { echo "FAIL: check --test props"; fail=1; }
# 性質のラムダの中の assert は位置つきで拒否（check も build も）
# ⑧ std/quick の掛け戻し: 性質の中の panic は駆動役で縮め直した報告に置き換わる・testdata/fuzz のコーパスの列は試行の前に再生される（書き足さない）
# （std/quick の中の位置は std/quick を編集するたびに動くので消して照合）
"$SOBER" test testdata/sobertest/propsfuzz > "$W/qf0" 2>&1 && { echo "FAIL: propsfuzz passed"; fail=1; }
sed 's#at std/quick/[a-z_]*\.sober:[0-9]*:[0-9]*#at std/quick#' "$W/qf0" > "$W/qf"
diff "$W/qf" testdata/sobertest/propsfuzz.expect > "$W/qfd" || { echo "FAIL: propsfuzz output"; head -10 "$W/qfd"; fail=1; }
[ "$(ls testdata/sobertest/propsfuzz/testdata/fuzz/TestCorpus)" = 0-hand ] || { echo "FAIL: sober test wrote to the corpus"; fail=1; }
# ⑨ sober fuzz: 見つけた panic を縮めてコーパスへ書き（exit 1）、次の sober test がその列を先に再生する・見つからなければ exit 0・名前が無ければ exit 2
mkdir -p "$W/fz/propsfuzz" && cp testdata/sobertest/propsfuzz/*.sober "$W/fz/propsfuzz/"
( cd "$W/fz" && "$SA" fuzz propsfuzz --run TestPanic --time 5s > out 2>&1; echo $? > ec )
[ "$(cat "$W/fz/ec")" = 1 ] || { echo "FAIL: fuzz TestPanic exit $(cat "$W/fz/ec") (want 1)"; fail=1; }
ls "$W/fz/propsfuzz/testdata/fuzz/TestPanic/"0-* > /dev/null 2>&1 || { echo "FAIL: fuzz wrote no corpus"; head -5 "$W/fz/out"; fail=1; }
( cd "$W/fz" && "$SA" test propsfuzz > tout 2>&1 )
grep -q '^quick: panic in the corpus case propsfuzz/testdata/fuzz/TestPanic/0-' "$W/fz/tout" || { echo "FAIL: sober test did not replay the corpus"; head -5 "$W/fz/tout"; fail=1; }
( cd "$W/fz" && "$SA" fuzz propsfuzz --run TestOk --time 300ms > /dev/null 2>&1; echo $? > ec )
[ "$(cat "$W/fz/ec")" = 0 ] || { echo "FAIL: fuzz TestOk exit $(cat "$W/fz/ec") (want 0)"; fail=1; }
( cd "$W/fz" && "$SA" fuzz propsfuzz --run TestNone > /dev/null 2>&1; echo $? > ec )
[ "$(cat "$W/fz/ec")" = 2 ] || { echo "FAIL: fuzz TestNone exit $(cat "$W/fz/ec") (want 2)"; fail=1; }
"$SOBER" test testdata/sobertest/propsbad > "$W/qb" 2>&1 && { echo "FAIL: propsbad accepted"; fail=1; }
grep -q 'propsbad_test.sober:9:9: assert inside a quick.Check property' "$W/qb" || { echo "FAIL: propsbad diagnostic"; cat "$W/qb"; fail=1; }
"$SOBER" check testdata/sobertest/propsbad --test > /dev/null 2>&1 && { echo "FAIL: check --test propsbad accepted"; fail=1; }
# ⑤ --run は名前の接頭辞で絞る（T8）
[ "$("$SOBER" test testdata/sobertest/calc --run TestH)" = "$(printf 'ok   testdata/sobertest/calc.TestHalf\n1 passed, 0 failed')" ] || { echo "FAIL: --run"; fail=1; }
# ③ 署名の合わない Test…（T3）は loader の拒否（位置つき）・④ check --test（T12）はテストのビルドを検査する
"$SOBER" test testdata/sobertest/badsig > "$W/bad" 2>&1 && { echo "FAIL: badsig accepted"; fail=1; }
grep -q 'badsig_test.sober:3:6: a test function' "$W/bad" || { echo "FAIL: badsig diagnostic"; cat "$W/bad"; fail=1; }
"$SOBER" check testdata/sobertest/calc --test > "$W/chk" || { echo "FAIL: check --test calc"; cat "$W/chk"; fail=1; }
"$SOBER" check testdata/sobertest/badsig --test > /dev/null 2>&1 && { echo "FAIL: check --test badsig accepted"; fail=1; }
echo "sobertest: fail=$fail"
[ "$fail" = 0 ]
