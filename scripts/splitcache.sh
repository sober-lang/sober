#!/usr/bin/env bash
# splitcache（リリースの組 — gates.sh --release。取り込みのたびの --full には入らない）: 小分けのcheck（`check --split` — L0の生成とpkgcheckの照合の経路。
# 既定の経路はwatch・checkとも関数単位キャッシュ）のキャッシュを1つの配置先で3回 — 冷（空の配置先）・温（全部当たりのはず）・
# 検証（SOBER_CACHE_VERIFY=1 — 当たりでも検査し直して値をバイト比較・違えばstaleと特定して落ちる）— 回し、3回ともG-eのゴールデン
# （testdata/checkverdict — 一括の判定）と一致すること。温で当たりが実際に出ていること（配置先の値の数 > 0・温のrunの外れ0）も見る。
# 利用者の package の .sobi（testdata/splitcatch）の冷・温・検証も。もとは scripts/cachesplit.sh の後半（L0 の照合は cachesplit に残る）
#   scripts/splitcache.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export SOBER_CACHE=$tmp/cache
export SOBER_SELF_KEY=$(cat "$(dirname "$STAGE2")/.key")
fail=0
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
echo "splitcache: cold / warm / verify match testdata/checkverdict, $n cache entries + user-package .sobi (testdata/splitcatch) cold / warm / verify, fail=$fail"
[ "$fail" = 0 ]
