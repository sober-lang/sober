#!/usr/bin/env bash
# httpprobe（report-1175 — 低確率の httpcheck の赤の再現網）: httpcheck の 1 構成（既定 W1）だけを、通常の build とカオスの build（--rt-mutant=30 —
# 非 ring の道の偽の EAGAIN・短い書き / 読み・ep_poll の受け皿の縮めと sched_yield。種 = SOBER_CHAOS_SEED）で交互に、時間の許す限り回す。
# 落ちた回は <out>/fail-<回>-<plain|chaos>/ に check の出力・srv の stderr・listener の ss・env と、飛行記録（SOBER_FLIGHT — flight.bin と
# scripts/flight.ts の --anomaly / 落ちの lport= ごとの --conn の読み）を残す（CI は upload-artifact で拾う）
#   scripts/httpprobe.sh <srv-plain> <srv-chaos|-> <分> <out> [構成の env …]
#   例: scripts/httpprobe.sh out/srv out/srv30 10 /tmp/probe SOBER_WORKERS=1
set -uo pipefail
cd "$(dirname "$0")/.."
SRV0=$1; SRV1=$2; MIN=$3; OUT=$4; shift 4
CFG=("$@")
[ ${#CFG[@]} = 0 ] && CFG=(SOBER_WORKERS=1)
SEED0=${PROBE_SEED_BASE:-1}
mkdir -p "$OUT"
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
end=$(( $(date +%s) + MIN * 60 ))
i=0; np=0; fp=0; nc=0; fc=0
while [ "$(date +%s)" -lt $end ]; do
    i=$((i + 1))
    kind=plain; srv=$SRV0; extra=()
    if [ "$SRV1" != - ] && [ $((i % 2)) = 0 ]; then
        kind=chaos; srv=$SRV1; extra=(SOBER_CHAOS_SEED=$((SEED0 + i)))
    fi
    rm -rf "$W/static" && mkdir -p "$W/static/www"
    rm -f "$W/flight"
    env "${CFG[@]}" "${extra[@]}" SOBER_FLIGHT="$W/flight" DATASET_PATH=testdata/httpcheck/dataset.json STATIC_ROOT="$W/static/www" "$srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    port=
    for _ in $(seq 100); do
        port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
        [ -n "$port" ] && break
        sleep 0.05
    done
    rc=0
    if [ -z "$port" ]; then
        echo "server did not start" > "$W/check.out"; rc=99
    else
        timeout 120 node --experimental-strip-types --experimental-eventsource --no-warnings testdata/httpcheck/check.ts "$port" --frag-random 100 --static "$W/static" > "$W/check.out" 2>&1 || rc=$?
    fi
    if [ $rc != 0 ]; then
        d="$OUT/fail-$i-$kind"
        mkdir -p "$d"
        cp "$W/check.out" "$W/srv.err" "$d/"
        { echo "cfg: ${CFG[*]} ${extra[*]}"; echo "port: $port rc: $rc"; date -u +%FT%TZ; } > "$d/env"
        [ -n "$port" ] && ss -Htanp "sport = :$port" > "$d/ss" 2>/dev/null
    fi
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    SP=
    if [ $rc != 0 ] && [ -f "$W/flight" ]; then
        cp "$W/flight" "$d/flight.bin"
        node --experimental-strip-types --no-warnings scripts/flight.ts "$d/flight.bin" --anomaly > "$d/flight-anomaly.txt" 2>&1
        for lp in $(sed -n 's/.* lport=\([1-9][0-9]*\).*/\1/p' "$d/check.out"); do
            node --experimental-strip-types --no-warnings scripts/flight.ts "$d/flight.bin" --conn "$lp" > "$d/flight-conn-$lp.txt" 2>&1
        done
    fi
    if [ $kind = plain ]; then np=$((np + 1)); [ $rc != 0 ] && fp=$((fp + 1)); else nc=$((nc + 1)); [ $rc != 0 ] && fc=$((fc + 1)); fi
    echo "$i $kind rc=$rc $(sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p' "$W/check.out")"
done
echo "httpprobe: plain $fp/$np failed · chaos $fc/$nc failed (${CFG[*]})"
[ $((fp + fc)) = 0 ]
