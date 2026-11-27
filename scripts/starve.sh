#!/usr/bin/env bash
# starve（実行待ちの列のFIFOの保証の網）: testdata/starve/starve.sober（echoのnet.Serve + 閉ループの客512本を同じプロセスに・Serve 3秒）を
# SOBER_WORKERS=2で走らせ、終わりのtask.Ledger().maxWaitと往復の数を読む。
# 保証: 実行待ちの列はFIFOなので、飽和した閉ループではどのtaskも列の1周の時間の定数倍の内に走る。1周の時間 = 往復1回の平均
# （Serveの時間 × 往復した客の数 ÷ 往復の和）。
# 判定: maxWait ≤ STARVE_FLOOR_MS + STARVE_K × 1周の時間（既定60 ms + 100 × 1周）。maxWaitは起動の山（512本のspawn・dial・acceptの集中）を含み、
# FIFOでも1周の数十倍になる。床は、その山とOSの奪い（gatesの並列）の数十msの揺れを偽赤にしないため。的は1周の数百倍以上待つtaskが出るクラス。
# 往復が0（客が走らなかった）はFAIL。客のtaskは未着手の子の列を通るので、1回以上往復した客がCLIENTS本に満たなければ赤
# （飽和の間も未着手の子がN周に1回走る保証。language.md 28節「実行待ちの列の順」）。
#   scripts/starve.sh            網（ROUNDS回。既定1）
#   scripts/starve.sh --mutants  検出率の確認: 変異29（溢れの列の順を崩す・環の容量8）が赤になること。28（環の容量8で溢れのパスを毎回通す）は緑のまま。
#                                照合のビルド: 157（未着手の子の列と実行待ちの列の順の照合だけ — 緑のまま）・158（99 = 未着手の子の列をN周に1回取らない + 照合）・
#                                159（93 = 新しい側から取る + 照合）・160（98 = 新しい側から取り、1024周に1回だけ底から取る + 照合）が、
#                                1回の実行で照合に捕まり終了コード103（mn.sober bkGapTick・fifoCheck）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
need_nofile starve 8192; rc=$?
[ $rc = 2 ] && exit 1
[ $rc = 1 ] && exit 0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
FLOOR=${STARVE_FLOOR_MS:-60}
K=${STARVE_K:-100}
CLIENTS=512   # testdata/starve/starve.soberのCLIENTS
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
    if [ "$ac" -lt "$CLIENTS" ]; then echo "starve: RED $tag: only ${ac} of ${CLIENTS} clients made a round trip (unstarted children starve)"; return 1; fi
    # 1周（µs）と上限（µs）
    local cyc lim
    cyc=$((sm * 1000 * ac / rd))
    lim=$((FLOOR * 1000 + K * cyc))
    if [ "$mw" -gt "$lim" ]; then echo "starve: RED $tag: maxWait ${mw} µs > ${lim} µs (cycle ${cyc} µs · ${ac} clients · ${rd} round trips)"; return 1; fi
    echo "starve: ok $tag: maxWait ${mw} µs ≤ ${lim} µs (cycle ${cyc} µs · ${ac} clients · ${rd} round trips)"; return 0
}
if [ "${1:-}" = "--mutants" ]; then
    fail=0
    run bk157 --rt-mutant=157 || { echo "starve: the backlog check build (mutant 157) is red"; fail=1; }
    for mk in 158:backlog 159:fifo 160:fifo; do
        m=${mk%%:*}; k=${mk#*:}
        if "$S2" build testdata/starve/starve.sober --emit=elf --passes --rt-mutant=$m -o "$W/m$m" > "$W/m$m.blog" 2>&1; then
            SOBER_WORKERS=2 timeout 60 "$W/m$m" > /dev/null 2> "$W/m$m.err"; ec=$?
            if [ $ec = 103 ] && grep -q "^$k-check: " "$W/m$m.err"; then echo "starve: mutant $m caught by the check ($(grep -m1 "^$k-check: " "$W/m$m.err"))"
            else echo "starve: mutant $m not caught by the $k check (exit $ec)"; fail=1; fi
        else echo "starve: FAIL build m$m"; fail=1; fi
    done
    for m in 29; do
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
