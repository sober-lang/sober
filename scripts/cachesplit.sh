#!/usr/bin/env bash
# L0の照合（3'' 第2段階の1.5 — 毎回のゲート）。小分けのcheckのキャッシュの冷・温・検証の照合は scripts/splitcache.sh（リリースの組 — gates.sh --release）。
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
echo "cachesplit: L0 $nl0 std packages verified + L0-off whole / split match testdata/checkverdict, fail=$fail"
[ "$fail" = 0 ]
