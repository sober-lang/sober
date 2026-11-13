#!/usr/bin/env bash
# fusecheck（送り置きの網 — 旧 report-fuse-1 の畳みの網を作り直した）: testdata/httpcheck/srv.sober を W2（net の ring の道）で立て、1 本の keep-alive の接続で
# 要求を N 本順に送り（curl の URL の列 — 前の応答を読んでから次を送る）、飛行記録（SOBER_FLIGHT — scripts/flight.ts --summary）で
# 1 要求あたりの ENTER（io_uring_enter）と RUN（task の走り）を数える。送り置きなら ≈ 1 回ずつ・送り置きしない道（SOBER_NET_FUSE=0）は ≈ 2 回ずつ。
# 判定: 既定 ≤ 1.4 かつ FUSE=0 ≥ 1.6（物差しが効いていること）・全応答が揃うこと（8 本の接続を並べた回も）。
# 遅い読み手（testdata/httpcheck/slowread.py）: 受けの窓の小さい相手が要求を 1 本ずつ送りながら作りより遅く読む keep-alive の接続 1 本（送りのバッファが満ちたまま
# 送り置きが短くなる）。送り残しの後の眠りが保険の timeout まで滞ると 1 本ごとに ≈100 ms 伸びる — 30 秒以内に全応答を読み切ること。
# 記録の詰め: NR_QS（頭の読んだバイト数と送りの状態）を素で読み書きするのは qoff* / sst* の 4 関数だけ。
# 留める相手を混ぜた溢れ（testdata/httpcheck/hold.py — 受けの窓 2 KB で ≈8 KB の応答の要求を 900 本送り一切読まない接続 4 本 → 満ちた後の送り置きが未完で留まる）:
# その間に keep-alive の接続 2 本で N × 10 本を送り、送り場に入らなかった送り置き（飛行記録の POST の b = 0・長さ ≤ 16384）が 0 であること
# --mutants: 変異 40（送り置きの MSG_WAITALL を落とす — 短い完了が誤りになり接続が切れる）・41（印を消費しても送り置きしない）・42（塊を空きへ返さない）で建てた srv に
#   判定を掛け、どれも落ちることを確かめる
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
# 記録の詰めの網: NR_QS の素の読み書きが qoff* / sst* の外に無いこと
raw=$(awk '/^func /{f=$2} /NR_QS/ && !/^const NR_QS/ && f !~ /^(qoffGet|qoffSet|sstGet|sstSet)\(/' src/compiler/lower/netring.sober | grep -v '^ *//')
[ -n "$raw" ] && { echo "fusecheck: FAIL — raw NR_QS access outside qoff*/sst*: $raw"; bad=1; }
judge base "$W/srv" || { echo "fusecheck: FAIL — the posted send is not taken or loses responses"; bad=1; }
# slow <名前> <srv> → 0 = 遅い読み手の接続で全応答を 30 秒以内に読み切る
slow() {
    local name=$1 srv=$2 port= r rc
    env SOBER_WORKERS=2 DATASET_PATH=testdata/httpcheck/dataset.json "$srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    for _ in $(seq 100); do port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.05; done
    r=$(SINGLES=1200 READ=4096 timeout 30 python3 -I testdata/httpcheck/slowread.py "$port" 1 2 2>&1 | tail -1); rc=${PIPESTATUS[0]}
    kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
    echo "fusecheck: $name — slow reader: $r"
    case $r in "read ms:"*) return 0 ;; *) return 1 ;; esac
}
slow base "$W/srv" || { echo "fusecheck: FAIL — a slow reader stalls or loses the connection"; bad=1; }
# held <名前> <srv> → 0 = 留める相手を混ぜても送り置きが溢れない
held() {
    local name=$1 srv=$2 port= k ov
    rm -f "$W/fl"
    env SOBER_WORKERS=2 SOBER_FLIGHT="$W/fl" DATASET_PATH=testdata/httpcheck/dataset.json "$srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    for _ in $(seq 100); do port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.05; done
    for k in 1 2 3 4; do timeout 20 python3 -I testdata/httpcheck/hold.py "$port" 900 3 12 > /dev/null 2>&1 & done
    sleep 3.5
    for k in 1 2; do for _ in $(seq 10); do timeout 20 curl -s -m 15 "${urls[@]//PORT/$port}" > /dev/null; done & done
    wait $(jobs -p | grep -vx "$SP") 2>/dev/null
    kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
    ov=$(node --experimental-strip-types --no-warnings scripts/flight.ts "$W/fl" | awk '/ POST / { split($6, w, "="); t++; if ($NF == "res=0" && w[2] + 0 <= 16384) o++ } END { printf "%d %d", t, o }')
    echo "fusecheck: $name — held readers: posts/overflow ${ov}"
    [ "${ov#* }" = 0 ] && [ "${ov% *}" -gt 0 ]
}
held base "$W/srv" || { echo "fusecheck: FAIL — a held slow reader makes other connections' posted sends overflow"; bad=1; }
if [ $MUT = 1 ]; then
    for m in 40 41 42; do
        "$S2" build testdata/httpcheck/srv.sober --emit=elf --passes --rt-mutant=$m -o "$W/srv$m" > "$W/b.log" 2>&1 || { echo "fusecheck: FAIL build m$m"; exit 1; }
        case $m in 41) judge "m$m" "$W/srv$m" ;; 42) held "m$m" "$W/srv$m" ;; *) slow "m$m" "$W/srv$m" ;; esac && { echo "fusecheck: FAIL — mutant $m was not caught"; bad=1; } || echo "fusecheck: m$m caught"
    done
fi
[ $bad = 0 ] && echo "fusecheck: PASS"
exit $bad
