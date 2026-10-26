#!/usr/bin/env bash
# flightcheck（report-1176 — 飛行記録の検収の網）: 壊す変異（--rt-mutant=31 = epoll の道の起こしを落とす・32 = 短く送って頼んだ長さを返す）で
# testdata/httpcheck/srv.sober を建て、SOBER_FLIGHT つきの W1 で check.ts を掛ける。網が落ちた回ごとに、飛行記録（scripts/flight.ts）が落ちの
# 原因を名指せるかを見る: 31 = 最初の落ちの直前 15 s に「起こしの取りこぼし」か「起こされない PARK」が在る・32 = 直前 1 s に「短い SEND」が在る。lport= の付いた落ち（undici）はその接続の
# ACCEPT からの列が引ける。網が 1 回も落ちなかった変異は判定できない（種を足す）
#   scripts/flightcheck.sh [回数（変異ごと・既定 4）]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
N=${1:-4}
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
FT=(node --experimental-strip-types --no-warnings scripts/flight.ts)
bad=0
sum=
for m in 31 32; do
    "$S2" build testdata/httpcheck/srv.sober --emit=elf --passes --rt-mutant=$m -o "$W/srv$m" > "$W/b.log" 2>&1 || { echo "flightcheck: FAIL build m$m ($(head -c 200 "$W/b.log"))"; exit 1; }
    runs=0; fails=0; named=0; conns=0; connok=0
    for i in $(seq "$N"); do
        rm -rf "$W/static" "$W/fl" && mkdir -p "$W/static/www"
        env SOBER_WORKERS=1 SOBER_CHAOS_SEED=$((i * 7919)) SOBER_FLIGHT="$W/fl" DATASET_PATH=testdata/httpcheck/dataset.json STATIC_ROOT="$W/static/www" "$W/srv$m" 0 > "$W/srv.out" 2> "$W/srv.err" &
        SP=$!
        port=
        for _ in $(seq 100); do
            port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
            [ -n "$port" ] && break
            sleep 0.05
        done
        [ -z "$port" ] && { echo "flightcheck: FAIL m$m — server did not start"; bad=1; kill $SP 2>/dev/null; SP=; continue; }
        timeout 180 node --experimental-strip-types --experimental-eventsource --no-warnings testdata/httpcheck/check.ts "$port" --frag-random 100 --static "$W/static" > "$W/check.out" 2>&1
        rc=$?
        kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
        runs=$((runs + 1))
        [ $rc = 0 ] && continue
        fails=$((fails + 1))
        [ -f "$W/fl" ] || { echo "flightcheck: FAIL m$m run $i — no flight record"; bad=1; continue; }
        "${FT[@]}" "$W/fl" --anomaly > "$W/an.txt"
        # 最初の落ちの時刻（t=）より前に変異の跡が在るか
        t1=$(grep '^  FAIL' "$W/check.out" | sed -n 's/.* t=\([0-9]*\).*/\1/p' | sort -n | head -1)
        want=$([ $m = 31 ] && echo "lost-wake|stuck-park" || echo short-send)
        # 窓 = 落ちの直前（31 は 15 s — 相手の時間切れ 5 s に、1 バイトずつの送りの検査の長さ〔数秒〕を足す。32 は 1 s）。t= の無い落ち（check の時間切れ）は記録の全体
        win=$([ $m = 31 ] && echo 15000000000 || echo 1000000000)
        if awk -v k="^($want)\$" -v t="${t1:-0}" -v w=$win '$1 ~ k { split($2, a, "="); if (t == 0 || (a[2] + 0 <= t + 0 && a[2] + 0 >= t - w)) f = 1 } END { exit !f }' "$W/an.txt"; then
            named=$((named + 1))
        else
            echo "flightcheck: m$m run $i — no $want before t=$t1"; grep '^  FAIL' "$W/check.out" | head -3; head -5 "$W/an.txt"
        fi
        # undici の落ち（lport=）はその接続の列が引ける（ACCEPT + 送り / 受けが 1 つ以上）
        for lp in $(grep '^  FAIL' "$W/check.out" | sed -n 's/.* lport=\([1-9][0-9]*\).*/\1/p'); do
            conns=$((conns + 1))
            "${FT[@]}" "$W/fl" --conn "$lp" > "$W/conn.txt"
            if grep -q ' ACCEPT ' "$W/conn.txt" && grep -qE ' (SEND|RECV) ' "$W/conn.txt"; then connok=$((connok + 1)); else echo "flightcheck: m$m run $i — lport=$lp has no chain"; fi
        done
    done
    sum="$sum [m$m: runs $runs · failed $fails · named $named/$fails · conns $connok/$conns]"
    [ $fails = 0 ] && { echo "flightcheck: m$m never failed in $runs runs — add runs"; bad=1; }
    [ $named != $fails ] && bad=1
    [ $connok != $conns ] && bad=1
done
echo "flightcheck:$sum fail=$bad"
exit $bad
