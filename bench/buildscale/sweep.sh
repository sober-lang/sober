#!/usr/bin/env bash
# 1つの規模の題材を、言語 × コア数 × 場面で測る（run.tsを順に呼ぶ）。gq.sh --excl の中で使う
# 使い方: bench/buildscale/sweep.sh <題材のdir> <TSV> "<言語…>" "<コア数…>" "<場面…>" [reps]
#   例: bench/buildscale/sweep.sh /tmp/bs/10k /tmp/bs/out.tsv "sober go rust rustdebug" "1 8 32" "cold coldapp leaf root"
# coldappはRustでは意味が無い（標準ライブラリはビルド済みで配られる）ので飛ばす
set -u
here=$(cd "$(dirname "$0")" && pwd)
dir=$1; tsv=$2; langs=$3; cores=$4; scenes=$5; reps=${6:-3}
for l in $langs; do for c in $cores; do for s in $scenes; do
    case "$l:$s" in rust*:coldapp) continue ;; esac
    node "$here/run.ts" --dir "$dir" --lang "$l" --cores "$c" --scene "$s" --reps "$reps" --sober "$here/../../out/stage2/sober2" --tsv "$tsv" ${SWEEP_LABEL:+--label "$SWEEP_LABEL"} >/dev/null || echo "sweep: FAIL $l $c $s" >&2
done; done; done
