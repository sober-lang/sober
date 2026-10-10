#!/usr/bin/env bash
# メモリの天井の実働のグラフ（README の 3 枚目）: bench/budget を天井あり / なしで走らせ、RSS の時系列（scripts/rsssample.ts）を
# out/bench/budget-<日時>.tsv に取り、出力の一致を確かめて scripts/benchchart.ts で docs/assets/bench-budget-{light,dark}.svg を描く。
#   bench/budget/run.sh [-w ワーカー数（既定 8）]
set -uo pipefail
cd "$(dirname "$0")/../.."
WK=8
[ "${1:-}" = -w ] && WK=$2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
bin/sober build -o "$W/budget" bench/budget/main.sober || exit 1
mkdir -p out/bench
res=out/bench/budget-$(date +%Y%m%d-%H%M%S).tsv
echo "#cap=128" > "$res"
for s in cap nocap; do
    a=""; [ "$s" = nocap ] && a=nobudget
    SOBER_WORKERS=$WK node --experimental-strip-types scripts/rsssample.ts "$s" "$res" 5 -- "$W/budget" $a || { echo "budget: FAIL run $s"; exit 1; }
done
cmp -s "$res.cap.out" "$res.nocap.out" || { echo "budget: FAIL output differs between budget / no budget"; exit 1; }
echo "budget: outputs equal ($(cat "$res.cap.out")) — peak RSS cap $(awk '$1=="cap"{if($3>m)m=$3}END{print int(m/1024)}' "$res") MB / nocap $(awk '$1=="nocap"{if($3>m)m=$3}END{print int(m/1024)}' "$res") MB"
node --experimental-strip-types scripts/benchchart.ts --budget "$res" -o docs/assets
echo "budget: raw = $res"
