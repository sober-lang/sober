#!/usr/bin/env bash
# テストの構成の差し替え（language.md 41 節 — loader/doubles.sober）の照合:
#   ① testdata/doubles/handler のテストが @doubles の double（store/fake）で走り、出力が handler.expect と一致
#   ② 本番の読み（testdata/doubles/app）は _double.sober を 1 つも読まず、本物の store で動く
#   ③ check --test と `sober check <double>`（相手との契約だけ）が受理する
#   ④ 拒否の一式（testdata/doubles/neg/k* — 位置と文面が neg.expect と一致）
#   ⑤ double の導出の効果が本物の @effects を越えると check --test と check <double> が拒否する（neg/leak — analyzer の照合に本物の宣言を写す）
#   ⑥ 本物の宣言の変更でテストの結果の再生が外れる（契約の検査が読んだ本物のファイルが照合に入る）
#   ⑦ 状態を貯める fake（std/testing/cell — 41 節）: logger の spy で greet のテストが走り（出力 ≡ greet.expect）・check --test と check <double> が受理・
#      置き場の読み書き / 並行の Update / quick の試行ごとの空（testdata/cells — 出力 ≡ cells.expect・check --test が受理）・
#      拒否（neg/c0* は ④ の表・Update のラムダの効果 = analyzer・置けない型・Set / Update の値の型の食い違い = check と build の両方）
#   ⑧ 配線の印字（test --wiring）・--cover-pkg が double のファイルに計器を打たない・double の中の panic の位置が double の実パスで出る（crashed）
#   ⑨ キャッシュ: 同じ置き場で本物の build（app）と double つきのテスト（handler）を交互に建て、検証モード（SOBER_CACHE_VERIFY=1 / 2）で stale が出ない
#      （差し替えに固有の鍵の成分は無い — 中身で別の項目になることの確かめ。再生の鍵の変異の網 = scripts/doublesmut.sh）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
case $SOBER in /*) SA=$SOBER ;; *) SA=$PWD/$SOBER ;; esac
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$SOBER" test testdata/doubles/handler > "$W/out" 2>&1 || { echo "FAIL: sober test handler"; cat "$W/out"; fail=1; }
diff "$W/out" testdata/doubles/handler.expect > /dev/null || { echo "FAIL: handler output"; diff "$W/out" testdata/doubles/handler.expect | head -5; fail=1; }
"$SOBER" parse --loader-json testdata/doubles/app > "$W/lj" || { echo "FAIL: loader-json app"; fail=1; }
grep -q '_double\.sober' "$W/lj" && { echo "FAIL: the normal build read a _double.sober file"; fail=1; }
"$SOBER" build testdata/doubles/app -o "$W/app" > /dev/null && [ "$("$W/app")" = none ] || { echo "FAIL: app"; fail=1; }
"$SOBER" check testdata/doubles/handler --test > /dev/null || { echo "FAIL: check --test handler"; fail=1; }
"$SOBER" check testdata/doubles/store/fake > /dev/null || { echo "FAIL: check <double>"; fail=1; }
while IFS=$'\t' read -r name want; do
    "$SOBER" test "testdata/doubles/neg/$name/t" > "$W/n" 2>&1 && { echo "FAIL: $name accepted"; fail=1; continue; }
    grep -qxF "sober: load error at $want" "$W/n" || { echo "FAIL: $name diagnostic"; head -3 "$W/n"; fail=1; }
done < testdata/doubles/neg.expect
leak='testdata/doubles/neg/leak/r/fake/f_double.sober:16:6: error: '"'"'testdata/doubles/neg/leak/r.Show'"'"' may have the effect panic via the call of '"'"'panic'"'"', which its @effects does not allow (allowed: io) (Analyzer)'
"$SOBER" check testdata/doubles/neg/leak/t --test > "$W/l1" 2>&1 && { echo "FAIL: leak accepted (check --test)"; fail=1; }
grep -qxF "$leak" "$W/l1" || { echo "FAIL: leak diagnostic (check --test)"; head -3 "$W/l1"; fail=1; }
"$SOBER" check testdata/doubles/neg/leak/r/fake > "$W/l2" 2>&1 && { echo "FAIL: leak accepted (check <double>)"; fail=1; }
grep -qxF "$leak" "$W/l2" || { echo "FAIL: leak diagnostic (check <double>)"; head -3 "$W/l2"; fail=1; }
"$SOBER" test testdata/doubles/greet > "$W/g" 2>&1 || { echo "FAIL: sober test greet"; cat "$W/g"; fail=1; }
diff "$W/g" testdata/doubles/greet.expect > /dev/null || { echo "FAIL: greet output"; diff "$W/g" testdata/doubles/greet.expect | head -5; fail=1; }
"$SOBER" check testdata/doubles/greet --test > /dev/null || { echo "FAIL: check --test greet"; fail=1; }
"$SOBER" check testdata/doubles/logger/spy > /dev/null || { echo "FAIL: check <double> spy"; fail=1; }
"$SOBER" test testdata/cells > "$W/c" 2>&1 || { echo "FAIL: sober test cells"; cat "$W/c"; fail=1; }
diff "$W/c" testdata/cells.expect > /dev/null || { echo "FAIL: cells output"; diff "$W/c" testdata/cells.expect | head -5; fail=1; }
"$SOBER" check testdata/cells --test > /dev/null || { echo "FAIL: check --test cells"; fail=1; }
# 脱糖の拒否 diag.Cell の文面は check キャッシュの道（外れ → 当たり）でも切った道と同じ（diag.Words — 化けると CoreFragment の token 0）
for m in 0 1 1; do SOBER_CHECK_CACHE=$m "$SOBER" check testdata/cellneg --test 2>&1 | tail -1; done > "$W/cn"
[ "$(sort -u "$W/cn" | wc -l)" = 1 ] && grep -q '(Cell): a cell holds plain data' "$W/cn" || { echo "FAIL: cellneg verdict differs on the check cache path"; cat "$W/cn"; fail=1; }
cfx='testdata/doubles/neg/cfx/t/t_test.sober:8:36: error: the function given to cell.Update may have the effect io via the call of '"'"'println'"'"': it runs holding the cell'"'"'s lock, so it has no effects (Analyzer)'
"$SOBER" check testdata/doubles/neg/cfx/t --test > "$W/x" 2>&1 && { echo "FAIL: cfx accepted"; fail=1; }
grep -qxF "$cfx" "$W/x" || { echo "FAIL: cfx diagnostic"; head -3 "$W/x"; fail=1; }
"$SOBER" test testdata/doubles/neg/cty/t > "$W/x" 2>&1 && { echo "FAIL: cty accepted"; fail=1; }
grep -qF "error at testdata/doubles/neg/cty/t/t_test.sober:8:26 (Cell): a cell holds plain data" "$W/x" || { echo "FAIL: cty diagnostic"; head -3 "$W/x"; fail=1; }
for c in cset:8:21 cupd:8:24; do
    n=${c%%:*}; at=testdata/doubles/neg/$n/t/t_test.sober:${c#*:}
    "$SOBER" check testdata/doubles/neg/$n/t --test > "$W/x" 2>&1 && { echo "FAIL: $n accepted (check)"; fail=1; }
    grep -qxF "sober: type error at $at" "$W/x" || { echo "FAIL: $n diagnostic (check)"; head -3 "$W/x"; fail=1; }
    "$SOBER" test testdata/doubles/neg/$n/t > "$W/x" 2>&1 && { echo "FAIL: $n accepted (build)"; fail=1; }
    grep -qxF "sober: type error at $at" "$W/x" || { echo "FAIL: $n diagnostic (build — check と同じ行)"; head -3 "$W/x"; fail=1; }
done
mkdir -p "$W/rp/testdata" && cp -r testdata/doubles "$W/rp/testdata/"
( cd "$W/rp" && SOBER_CHECK_REPLAY=1 SOBER_CACHE="$W/cache" "$SA" test testdata/doubles/handler > o1 2>&1
  sed -i 's/^func Get(c Conn, k string) string?/func Get(c Conn, k int) string?/; s#io.ReadFile(c.dir + "/" + k)#io.ReadFile(c.dir + "/${k}")#' testdata/doubles/store/store.sober
  SOBER_CHECK_REPLAY=1 SOBER_CACHE="$W/cache" "$SA" test testdata/doubles/handler > o2 2>&1; echo $? > ec )
[ "$(cat "$W/rp/ec")" = 1 ] && grep -q "signature differs" "$W/rp/o2" || { echo "FAIL: the replay did not see the real package change"; cat "$W/rp/o2" | head -3; fail=1; }
"$SOBER" test testdata/doubles/greet testdata/doubles/handler testdata/doubles/crashed testdata/cells --wiring > "$W/w" 2>&1 || { echo "FAIL: --wiring"; cat "$W/w"; fail=1; }
printf '%s\n' "testdata/doubles/greet: testdata/doubles/logger <= testdata/doubles/logger/spy" "testdata/doubles/handler: testdata/doubles/store <= testdata/doubles/store/fake" \
    "testdata/doubles/crashed: testdata/doubles/logger <= testdata/doubles/logger/crash" | diff - "$W/w" > /dev/null || { echo "FAIL: --wiring output"; cat "$W/w"; fail=1; }
"$SOBER" test testdata/doubles/greet --fresh --cover-pkg 'testdata/doubles/...' --cover-out "$W/cov" > /dev/null 2>&1 || { echo "FAIL: --cover-pkg greet"; fail=1; }
grep -q '^testdata/doubles/greet/greet.sober:' "$W/cov" && ! grep -q '_double\.sober' "$W/cov" || { echo "FAIL: --cover-pkg measured a double"; cat "$W/cov"; fail=1; }
"$SOBER" test testdata/doubles/crashed > "$W/p" 2>&1 && { echo "FAIL: crashed passed"; fail=1; }
grep -qxF "panic: index out of range at testdata/doubles/logger/crash/crash_double.sober:9:10" "$W/p" || { echo "FAIL: the panic position in a double"; head -3 "$W/p"; fail=1; }
for v in 0 1 2; do
    SOBER_CACHE="$W/alt" SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=$v "$SOBER" build testdata/doubles/app -o "$W/altapp" > "$W/a" 2>&1 && [ "$("$W/altapp")" = none ] || { echo "FAIL: alternate build (verify $v)"; head -3 "$W/a"; fail=1; }
    SOBER_CACHE="$W/alt" SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=$v "$SOBER" test testdata/doubles/handler --fresh > "$W/a" 2>&1 || { echo "FAIL: alternate test (verify $v)"; head -3 "$W/a"; fail=1; }
done
echo "doubles: fail=$fail"
[ "$fail" = 0 ]
