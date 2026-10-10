#!/usr/bin/env bash
# G-f（3'' 第 2 段 C2）: 小分けの check のキャッシュを 1 つの置き場で 3 回 — 冷（空の置き場）・温（全部当たりのはず）・
# 検証（SOBER_CACHE_VERIFY=1 — 当たりでも検査し直して値をバイト比較・違えば stale と名指して落ちる）— 回し、3 回とも G-e の黄金
# （testdata/checkverdict — 一括の判定）と一致すること。温で当たりが実際に出ていること（置き場の値の数 > 0・温の run の外れ 0）も見る。
# L0（std の焼き込み — 3'' 第 2 段の 1.5）: ①std の全 package を import する entry を検証モードで小分けに通し、焼き込みの値 ≡ 計算し直し（13 package）
# ②L0 を切った（SOBER_L0=0）一括と小分けも黄金と一致（焼き込みの経路と焼き込み無しの経路の判定が同じ）
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
{ echo "package main"; echo; for d in src/std/*/; do echo "import \"std/$(basename "$d")\""; done; echo; echo "func main() {"; echo "}"; } > "$tmp/l0/all.sober"
nl0=$(SOBER_CACHE= SOBER_CACHE_VERIFY=1 "$STAGE2" check "$tmp/l0/all.sober" --split --cache-trace 2>&1 >/dev/null | grep -c '^cache: std/.* hit$')
SOBER_CACHE= SOBER_CACHE_VERIFY=1 "$STAGE2" check "$tmp/l0/all.sober" --split > "$tmp/l0/out" 2>&1 || { echo "FAIL: L0 verify: $(head -2 "$tmp/l0/out")"; fail=$((fail + 1)); }
[ "$nl0" -ge 1 ] || { echo "FAIL: L0 is empty (no std package hit — stage2 built without the L0 bake?)"; fail=$((fail + 1)); }
# L0 ②
for m in whole split; do
    out=$(SOBER_L0=0 SOBER_CACHE= scripts/checkverdict.sh $( [ $m = split ] && echo --split ) 2>&1)
    echo "$out" | grep '^FAIL' | head -3
    echo "$out" | tail -1 | grep -q 'fail=0$' || { echo "FAIL: SOBER_L0=0 $m: $(echo "$out" | tail -1)"; fail=$((fail + 1)); }
done
for phase in cold warm verify; do
    if [ $phase = verify ]; then export SOBER_CACHE_VERIFY=1; fi
    out=$(scripts/checkverdict.sh --split 2>&1)
    last=$(echo "$out" | tail -1)
    echo "$out" | grep '^FAIL' | head -5
    echo "$last" | grep -q 'fail=0$' || { echo "FAIL: $phase: $last"; fail=$((fail + 1)); }
    [ $phase = cold ] && n=$(find "$SOBER_CACHE" -type f -not -name '*.tmp' | wc -l)
done
unset SOBER_CACHE_VERIFY
[ "${n:-0}" -gt 0 ] || { echo "FAIL: the cold run wrote no entries"; fail=$((fail + 1)); }
# 温の外れ 0: 置き場の値の数が温・検証の後も増えていない（外れて受理なら書くので、外れがあれば増える）
m=$(find "$SOBER_CACHE" -type f -not -name '*.tmp' | wc -l)
[ "$m" = "$n" ] || { echo "FAIL: warm / verify runs missed ($n entries after cold, $m after)"; fail=$((fail + 1)); }
echo "cachesplit: cold / warm / verify match testdata/checkverdict, $n cache entries, L0 $nl0 std packages verified + L0-off whole / split match, fail=$fail"
[ "$fail" = 0 ]
