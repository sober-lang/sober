#!/usr/bin/env bash
# parkres: 待っている Serve の接続の入場の予約が、待っている間だけ PARK_RES（固定費 + 待ちの深さの上界 = 16 KiB）に縮み、閉じた後に台帳が元へ戻ること
# （admit.sober parkShrink / parkRestore — Ledger の used は「走っている接続の予約 + 待っている接続の PARK_RES」）。
#   ① testdata/parkres/main.sober（budget 省略 = 64 KiB + 固定費 8 KiB の予約）に 2,000本を張って1回ずつ GET し、待たせたときの Ledger の used の増えが
#      1本あたり 24 KiB 以下（縮めなければ 72 KiB）。② 全部を閉じた後、used が張る前の値に戻る（縮めと戻しの勘定が合う）。ワーカー4 × 経路 {自動〔ring〕, SOBER_IO=1〔epoll〕}
#   ③ 自己点検: ミュータント122（縮めない）では ① の増えが 1本あたり 60 KiB を越える
#   scripts/parkres.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
# サーバーは接続を2,000本持つので、fd の soft の上限を上げる（多くの環境の既定は1024で、届くと受け付けが止まり本数も台帳も崩れる）
need_nofile parkres 4096; rc=$?
[ $rc = 2 ] && exit 1
[ $rc = 1 ] && exit 0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
N=2000
"$S2" build testdata/parkres/main.sober --emit=elf --passes -o "$W/ok" > "$W/b.log" 2>&1 || { echo "parkres: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
"$S2" build testdata/parkres/main.sober --emit=elf --passes --rt-mutant=122 -o "$W/m122" > "$W/b.log" 2>&1 || { echo "parkres: FAIL build mutant 122"; exit 1; }
# run <bin> [env…] → "<1本あたりの増え B> <閉じた後の差 B>"
run() {
    local bin=$1
    shift
    env "$@" "$bin" > "$W/srv.out" 2>&1 &
    local p=$! port="" u0 u1 u2
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.1; done
    sleep 0.5; u0=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}')
    rm -f "$W/in"; mkfifo "$W/in"
    node --experimental-strip-types --no-warnings scripts/mapcap.ts "$port" hold $N < "$W/in" > "$W/hold.out" 2>&1 &
    local h=$!
    exec 7> "$W/in"
    for _ in $(seq 600); do grep -q held "$W/hold.out" && break; sleep 0.1; done
    sleep 1; u1=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}')
    exec 7>&-
    wait $h; sleep 1.5
    u2=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}')
    kill $p 2> /dev/null; wait $p 2> /dev/null
    echo "$(( (u1 - u0) / N )) $(( u2 - u0 )) $(cat "$W/hold.out")"
}
for io in "" 1; do
    read -r per back held <<< "$(run "$W/ok" SOBER_WORKERS=4 ${io:+SOBER_IO=$io})"
    if [ -z "${back:-}" ] || [ "$per" -gt 24576 ] || [ "$back" != 0 ]; then
        echo "parkres: FAIL SOBER_IO=${io:-auto}: per-connection $per B (want ≤ 24576), after close $back B (want 0) ($held)"; fail=1
    fi
    echo "  SOBER_IO=${io:-auto}: $per B/conn waiting · after close $back" >> "$W/sum"
done
read -r per back held <<< "$(run "$W/m122" SOBER_WORKERS=4)"
[ "${per:-0}" -gt 61440 ] || { echo "parkres: FAIL mutant 122 not caught: $per B/conn"; fail=1; }
echo "parkres: $(tr '\n' ' ' < "$W/sum")· mutant 122: $per B/conn, fail=$fail"
exit $fail
