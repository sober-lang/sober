#!/usr/bin/env bash
# G-f（3'' 第2段階C2）: 小分けのcheckのキャッシュを1つの配置先で3回 — 冷（空の配置先）・温（全部当たりのはず）・
# 検証（SOBER_CACHE_VERIFY=1 — 当たりでも検査し直して値をバイト比較・違えばstaleと特定して落ちる）— 回し、3回ともG-eのゴールデン
# （testdata/checkverdict — 一括の判定）と一致すること。温で当たりが実際に出ていること（配置先の値の数 > 0・温のrunの外れ0）も見る。
# L0（stdの焼き込み — 3'' 第2段階の1.5）: ①stdの全packageをimportするentryを検証モードで小分けに通し、焼き込みの値 ≡ 計算し直し（13 package）
# ②L0を切った（SOBER_L0=0）一括と小分けもゴールデンと一致（焼き込みの経路と焼き込み無しの経路の判定が同じ — stdの推移的な依存が大きい題材 + compilerの題材の抜き取り）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export SOBER_CACHE=$tmp/cache
export SOBER_SELF_KEY=$(cat "$(dirname "$STAGE2")/.key")
fail=0
# L0 ①
mkdir -p "$tmp/l0"
{ echo "package main"; echo; for d in $(cd src && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' ! -path 'std/testing/cell/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$tmp/l0/all.sober"
nl0=$(SOBER_CACHE= SOBER_CACHE_VERIFY=1 "$STAGE2" check "$tmp/l0/all.sober" --split --cache-trace 2>&1 >/dev/null | grep -c '^cache: std/.* hit$')
SOBER_CACHE= SOBER_CACHE_VERIFY=1 "$STAGE2" check "$tmp/l0/all.sober" --split > "$tmp/l0/out" 2>&1 || { echo "FAIL: L0 verify: $(head -2 "$tmp/l0/out")"; fail=$((fail + 1)); }
[ "$nl0" -ge 1 ] || { echo "FAIL: L0 is empty (no std package hit — stage2 built without the L0 bake?)"; fail=$((fail + 1)); }
# L0 ②
for m in whole split; do
    out=$(SOBER_L0=0 SOBER_CACHE= CV_SAMPLE=std scripts/checkverdict.sh $( [ $m = split ] && echo --split ) 2>&1)
    echo "$out" | grep '^FAIL' | head -3
    grep -q 'fail=0$' <<< "$(tail -n 1 <<< "$out")" || { echo "FAIL: SOBER_L0=0 $m: $(echo "$out" | tail -1)"; fail=$((fail + 1)); }
done
for phase in cold warm verify; do
    if [ $phase = verify ]; then export SOBER_CACHE_VERIFY=1; fi
    out=$(scripts/checkverdict.sh --split 2>&1)
    last=$(echo "$out" | tail -1)
    echo "$out" | grep '^FAIL' | head -5
    grep -q 'fail=0$' <<< "$last" || { echo "FAIL: $phase: $last"; fail=$((fail + 1)); }
    [ $phase = cold ] && n=$(find "$SOBER_CACHE" -type f -not -name '*.tmp' | wc -l)
done
unset SOBER_CACHE_VERIFY
# 利用者の package の .sobi（F-s ② — report-1242）: 例題は 1 ファイルなので小分けの check は std の .sobi しか書かない。2 package の題材
# （展開される関数の本体にcatch）を別の配置先で冷・温（書いた .sobiの読み戻し）・検証の3回 — 一括のcheckと同じ判定
want=$(SOBER_CACHE= "$STAGE2" check testdata/splitcatch/app 2>&1)
for phase in cold warm verify; do
    got=$(SOBER_CACHE=$tmp/cache_pkg SOBER_CACHE_VERIFY=$([ $phase = verify ] && echo 1 || echo 0) "$STAGE2" check testdata/splitcatch/app --split 2>&1)
    [ "$got" = "$want" ] || { echo "FAIL: splitcatch $phase: $(echo "$got" | head -2)"; fail=$((fail + 1)); }
done
[ "${n:-0}" -gt 0 ] || { echo "FAIL: the cold run wrote no entries"; fail=$((fail + 1)); }
# 温の外れ0: 配置先の値の数が温・検証の後も増えていない（外れて受理なら書くので、外れがあれば増える）
m=$(find "$SOBER_CACHE" -type f -not -name '*.tmp' | wc -l)
[ "$m" = "$n" ] || { echo "FAIL: warm / verify runs missed ($n entries after cold, $m after)"; fail=$((fail + 1)); }
echo "cachesplit: cold / warm / verify match testdata/checkverdict, $n cache entries, L0 $nl0 std packages verified + L0-off whole / split match + user-package .sobi (testdata/splitcatch) cold / warm / verify, fail=$fail"
[ "$fail" = 0 ]
