#!/usr/bin/env bash
# starve（実行待ちの列のFIFOの保証の網）: testdata/starve/starve.sober（echoのnet.Serve + 閉ループの客512本を同じプロセスに・Serve 3秒）を
# SOBER_WORKERS=2で走らせ、終わりのtask.Ledger().maxWaitと往復の数を読む。
# 保証: 実行待ちの列はFIFOなので、飽和した閉ループではどのtaskも列の1周の時間の定数倍の内に走る。1周の時間 = 往復1回の平均
# （Serveの時間 × 往復した客の数 ÷ 往復の和）。
# 判定: maxWait ≤ STARVE_FLOOR_MS + STARVE_K × 1周の時間（既定60 ms + 100 × 1周）。maxWaitは起動の山（512本のspawn・dial・acceptの集中）を含み、
# FIFOでも1周の数十倍になる。床は、その山とOSの奪い（gatesの並列）の数十msの揺れを偽赤にしないため。的は1周の数百倍以上待つtaskが出るクラス。
# 往復が0（客が走らなかった）はFAIL。
#   scripts/starve.sh            網（ROUNDS回。既定1）
#   scripts/starve.sh --mutants  検出率の確認: 変異93（新しい側から取る）・98（新しい側から取り、1024周に1回だけ底から取る。待ちは有界だが
#                                1周の定数倍で抑えられない）・29（溢れの列の順を崩す・環の容量8）が赤になること。28（環の容量8で溢れのパスを毎回通す）は緑のまま
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
FLOOR=${STARVE_FLOOR_MS:-60}
K=${STARVE_K:-100}
# run <tag> [buildの引数…] → 0 = 緑・1 = 赤（各回の行を出す）
run() {
    local tag=$1; shift
    "$S2" build testdata/starve/starve.sober --emit=elf --passes "$@" -o "$W/$tag" > "$W/$tag.blog" 2>&1 || { echo "starve: FAIL build $tag ($(head -c 200 "$W/$tag.blog"))"; return 1; }
    local out ec=0
    out=$(SOBER_WORKERS=2 timeout 60 "$W/$tag" 2> "$W/$tag.err") || ec=$?
    local line
    line=$(echo "$out" | grep '^maxWait_us=')
    local mw rd ac sm
    mw=$(echo "$line" | sed -n 's/^maxWait_us=\([0-9]*\) rounds=[0-9]* active=[0-9]* serve_ms=[0-9]*$/\1/p')
    rd=$(echo "$line" | sed -n 's/^maxWait_us=[0-9]* rounds=\([0-9]*\) active=[0-9]* serve_ms=[0-9]*$/\1/p')
    ac=$(echo "$line" | sed -n 's/^maxWait_us=[0-9]* rounds=[0-9]* active=\([0-9]*\) serve_ms=[0-9]*$/\1/p')
    sm=$(echo "$line" | sed -n 's/^maxWait_us=[0-9]* rounds=[0-9]* active=[0-9]* serve_ms=\([0-9]*\)$/\1/p')
    if [ "$ec" != 0 ] || [ -z "$mw" ]; then echo "starve: FAIL $tag — exit $ec ($(head -c 200 "$W/$tag.err"))"; return 1; fi
    if [ "$rd" = 0 ]; then echo "starve: FAIL $tag: no round trip (not saturated)"; return 1; fi
    # 1周（µs）と上限（µs）
    local cyc lim
    cyc=$((sm * 1000 * ac / rd))
    lim=$((FLOOR * 1000 + K * cyc))
    if [ "$mw" -gt "$lim" ]; then echo "starve: RED $tag: maxWait ${mw} µs > ${lim} µs (cycle ${cyc} µs · ${ac} clients · ${rd} round trips)"; return 1; fi
    echo "starve: ok $tag: maxWait ${mw} µs ≤ ${lim} µs (cycle ${cyc} µs · ${ac} clients · ${rd} round trips)"; return 0
}
if [ "${1:-}" = "--mutants" ]; then
    fail=0
    for m in 93 98 29; do
        for r in $(seq ${ROUNDS:-3}); do
            run m$m-$r --rt-mutant=$m; ec=$?
            [ $ec = 1 ] || { echo "starve: mutant $m not detected (round $r)"; fail=1; }
        done
    done
    for r in $(seq ${ROUNDS:-3}); do
        run spill-$r --rt-mutant=28; ec=$?
        [ $ec = 1 ] && { echo "starve: the spill path (ring capacity 8) is red (round $r)"; fail=1; }
    done
    [ $fail = 0 ] && echo "starve: mutants detected" || exit 1
    exit 0
fi
fail=0
for r in $(seq ${ROUNDS:-1}); do
    run base-$r || fail=1
done
[ $fail = 0 ] && echo "starve: PASS" || { echo "starve: FAIL"; exit 1; }
