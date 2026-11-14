#!/usr/bin/env bash
# dqbcheck — 盗みの門（rt.mnのMN_DQB）の検査の自己検査。gatesには入れない（wallの比で見るので並走の負荷に弱い — 静かなウィンドウで手で回す）。
#   scripts/dqbcheck.sh [-n 周]
# testdata/dqbfan（子 4 本がそれぞれ重い仕事）を同じバイナリの W1 と W4 で走らせ、wall の比（W4 / W1）を見る:
#   通常のbuild = 比 < 0.7（盗みで並ぶ）・ミュータント44（ビットを立てない）/ 45（積んだ直後に倒す）= 比 ≥ 0.85（盗みが止まりW1と同じ）
# ミュータントのbuildは通常のbuildと機械語が変わる（wallの絶対値をbuild間で比べない — 比は同じバイナリの中だけ）。
# 立て損ね・倒しすぎは盗みを失うだけで、デッドロックの判定（rt.mn_anydq_all）はMN_DQBを見ないので死には倒れない — 検査が見るのは並びの消失
set -uo pipefail
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
N=3
[ "${1:-}" = -n ] && N=$2
"$ROOT/scripts/stage2.sh" --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
wall() { /usr/bin/time -f %e -o "$W/t" env SOBER_WORKERS=$2 taskset -c 0-3 "$1" > /dev/null || return 1; cat "$W/t"; }
fail=0
for m in 0 44 45; do
    "$S2" build "$ROOT/testdata/dqbfan/main.sober" --emit=elf $([ $m = 0 ] || echo --rt-mutant=$m) -o "$W/b$m" > /dev/null 2>&1 || { echo "FAIL: build $m"; fail=1; continue; }
    rs=()
    for r in $(seq "$N"); do
        w1=$(wall "$W/b$m" 1) && w4=$(wall "$W/b$m" 4) || { echo "FAIL: run $m"; fail=1; continue 2; }
        rs+=("$(awk -v a="$w4" -v b="$w1" 'BEGIN { printf "%.2f", a / b }')")
    done
    med=$(printf '%s\n' "${rs[@]}" | sort -n | awk '{ a[NR] = $1 } END { print a[int((NR + 1) / 2)] }')
    echo "dqbcheck: build $m W4/W1 = ${rs[*]} (median $med)"
    if [ $m = 0 ]; then
        awk -v x="$med" 'BEGIN { exit !(x < 0.7) }' || { echo "FAIL: the normal build does not run the children side by side (W4/W1 $med)"; fail=1; }
    else
        awk -v x="$med" 'BEGIN { exit !(x >= 0.85) }' || { echo "FAIL: mutant $m was not caught (W4/W1 $med)"; fail=1; }
    fi
done
[ $fail = 0 ] && echo "dqbcheck: ok" || exit 1
