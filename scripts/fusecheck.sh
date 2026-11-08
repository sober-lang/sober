#!/usr/bin/env bash
# fusecheck（report-fuse-1 — 送りと次の受けの畳みの網）: testdata/httpcheck/srv.sober を W2（net の ring の道）で立て、1 本の keep-alive の接続で
# 要求を N 本順に送り（curl の URL の列 — 前の応答を読んでから次を送る）、飛行記録（SOBER_FLIGHT — scripts/flight.ts --summary）で
# 1 要求あたりの ENTER（io_uring_enter）と RUN（task の走り）を数える。畳めば ≈ 1 回ずつ・畳まない道（SOBER_NET_FUSE=0）は ≈ 2 回ずつ。
# 判定: 既定 ≤ 1.4 かつ FUSE=0 ≥ 1.6（物差しが効いていること）・全応答が揃うこと（8 本の接続を並べた回も — 受けの待ちへ移る道）。
# --mutants: 変異 40（受けの待ちへ移さない — 次の要求で眠ったまま）・41（印を消費しても畳まない）で建てた srv に同じ判定を掛け、両方が落ちることを確かめる
#   scripts/fusecheck.sh [--mutants] [本数（既定 200）]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
MUT=0
[ "${1:-}" = --mutants ] && { MUT=1; shift; }
N=${1:-200}
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
urls=()
for i in $(seq "$N"); do urls+=("http://127.0.0.1:PORT/baseline11?a=$i&b=1"); done
# run <srv> <env…> → "<応答の数> <enter/req> <run/req>"
run() {
    local srv=$1; shift
    rm -f "$W/fl"
    env SOBER_WORKERS=2 SOBER_FLIGHT="$W/fl" DATASET_PATH=testdata/httpcheck/dataset.json "$@" "$srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    local port=
    for _ in $(seq 100); do
        port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
        [ -n "$port" ] && break
        sleep 0.05
    done
    [ -z "$port" ] && { kill $SP 2>/dev/null; SP=; echo "0 0 0"; return; }
    if [ -n "${PAR:-}" ]; then
        # 並ぶ接続（同じワーカーに 2 本以上が載る — 送りの完了が受けより先に取り込まれ、受けの待ちへ移る道を通る）
        local k
        for k in $(seq "$PAR"); do timeout 20 curl -s -m 15 -w '\n' "${urls[@]//PORT/$port}" > "$W/resp.$k" 2>/dev/null & done
        wait $(jobs -p | grep -vx "$SP")
        cat "$W"/resp.* > "$W/resp"; rm -f "$W"/resp.*
    else
        timeout 20 curl -s -m 15 -w '\n' "${urls[@]//PORT/$port}" > "$W/resp" 2>/dev/null
    fi
    kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
    local got
    got=$(grep -c '^[0-9]' "$W/resp")
    [ -f "$W/fl" ] || { echo "$got 0 0"; return; }
    node --experimental-strip-types --no-warnings scripts/flight.ts "$W/fl" --summary | tail -1 |
        awk -v got="$got" '{ for (i = 1; i <= NF; i++) { split($i, a, "="); c[a[1]] = a[2] } } END { n = got > 0 ? got : 1; printf "%d %.3f %.3f\n", got, c["ENTER"] / n, c["RUN"] / n }'
}
# judge <名前> <srv> → 0 = 畳みの判定が通る
judge() {
    local name=$1 srv=$2 a b
    read -r ga ea ra <<< "$(run "$srv")"
    read -r gb eb rb <<< "$(run "$srv" SOBER_NET_FUSE=0)"
    read -r gc ec rc <<< "$(PAR=8 run "$srv")"
    echo "fusecheck: $name — fuse: resp $ga/$N enter/req $ea run/req $ra · SOBER_NET_FUSE=0: resp $gb/$N enter/req $eb run/req $rb · 8 conns: resp $gc/$((8 * N)) enter/req $ec run/req $rc"
    [ "$ga" = "$N" ] && [ "$gb" = "$N" ] && [ "$gc" = "$((8 * N))" ] && awk -v ea="$ea" -v eb="$eb" -v ra="$ra" 'BEGIN { exit !(ea <= 1.4 && ra <= 1.4 && eb >= 1.6) }'
}
"$S2" build testdata/httpcheck/srv.sober --emit=elf --passes -o "$W/srv" > "$W/b.log" 2>&1 || { echo "fusecheck: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
bad=0
judge base "$W/srv" || { echo "fusecheck: FAIL — the fused path is not taken or loses responses"; bad=1; }
if [ $MUT = 1 ]; then
    for m in 40 41; do
        "$S2" build testdata/httpcheck/srv.sober --emit=elf --passes --rt-mutant=$m -o "$W/srv$m" > "$W/b.log" 2>&1 || { echo "fusecheck: FAIL build m$m"; exit 1; }
        if judge "m$m" "$W/srv$m"; then echo "fusecheck: FAIL — mutant $m was not caught"; bad=1; else echo "fusecheck: m$m caught"; fi
    done
fi
[ $bad = 0 ] && echo "fusecheck: PASS"
exit $bad
