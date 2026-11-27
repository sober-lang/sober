#!/usr/bin/env bash
# parkres: 待っている Serve の接続の入場の予約が、待っている間だけ PARK_RES（固定費 + 待ちの深さの上界 = 16 KiB）に縮み、閉じた後に台帳が元へ戻ること
# （admit.sober parkShrink / parkRestore — Ledger の used は「走っている接続の予約 + 待っている接続の PARK_RES」）。
#   ① testdata/parkres/main.sober（budget 省略 = 64 KiB + 固定費 8 KiB の予約）に 2,000本を張って1回ずつ GET し、待たせたときの Ledger の used の増えが
#      1本あたり 24 KiB 以下（縮めなければ 72 KiB）。② 全部を閉じた後、used が張る前の値に戻る（縮めと戻しの勘定が合う）。ワーカー4 × 経路 {自動〔ring〕, SOBER_IO=1〔epoll〕}
#   ③ 自己点検: ミュータント122（縮めない）では ① の増えが 1本あたり 60 KiB を越える
#   ④ 要求ごとに子を1本走らせる（接続の task が生む子の返しはワーカーごとに溜めて反映する — admit.sober admitReturn / parkFlush）: 閉じた後に Serve の節の
#      task の数も張る前の値に戻る。自己点検: ミュータント131（反映でプールの節から子の task の数も引く）では戻らない
#   ⑤ 照合のbuild（ミュータント134〜137 — 子の返しの溜めの不変条件を照合し、破れたら exit 103）: 134（照合だけ）は 64 本・8 本を張って閉じても破れない
#      （PARKRES_CONNS=8 で天井が埋まり受け付けのループが入場の待ちに入る構成でも）。自己点検: 135（= 130 待ち手がいても溜める）は天井が埋まる構成で、
#      136（= 132 暇の点で反映しない）は子の返しを溜めたまま眠る点で、137（= 133 打ち消しの前にあふれを見ない — 照合のbuildは打ち消しの点の根の語を
#      あふれて見せる）は打ち消しの点で、exit 103
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
for m in 131 134 135 136 137; do
    "$S2" build testdata/parkres/main.sober --emit=elf --passes --rt-mutant=$m -o "$W/m$m" > "$W/b.log" 2>&1 || { echo "parkres: FAIL build mutant $m"; exit 1; }
done
# run <bin> [env…] → "<1本あたりの増え B> <閉じた後の差 B> <閉じた後の Serve の節の task の数の差> …"
run() {
    local bin=$1
    shift
    env "$@" "$bin" > "$W/srv.out" 2>&1 &
    local p=$! port="" u0 u1 u2 t0 t2
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.1; done
    sleep 0.5; u0=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}'); t0=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $4}')
    rm -f "$W/in"; mkfifo "$W/in"
    node --experimental-strip-types --no-warnings scripts/mapcap.ts "$port" hold $N < "$W/in" > "$W/hold.out" 2>&1 &
    local h=$!
    exec 7> "$W/in"
    for _ in $(seq 600); do grep -q held "$W/hold.out" && break; sleep 0.1; done
    sleep 1; u1=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}')
    exec 7>&-
    wait $h; sleep 1.5
    u2=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $2}'); t2=$(grep '^ledger' "$W/srv.out" | tail -1 | awk '{print $4}')
    kill $p 2> /dev/null; wait $p 2> /dev/null
    echo "$(( (u1 - u0) / N )) $(( u2 - u0 )) $(( t2 - t0 )) $(cat "$W/hold.out")"
}
for io in "" 1; do
    read -r per back tb held <<< "$(run "$W/ok" SOBER_WORKERS=4 ${io:+SOBER_IO=$io})"
    if [ -z "${tb:-}" ] || [ "$per" -gt 24576 ] || [ "$back" != 0 ] || [ "$tb" != 0 ]; then
        echo "parkres: FAIL SOBER_IO=${io:-auto}: per-connection $per B (want ≤ 24576), after close $back B (want 0), Serve tasks after close $tb (want 0) ($held)"; fail=1
    fi
    echo "  SOBER_IO=${io:-auto}: $per B/conn waiting · after close $back · tasks $tb" >> "$W/sum"
done
read -r per back tb held <<< "$(run "$W/m122" SOBER_WORKERS=4)"
[ "${per:-0}" -gt 61440 ] || { echo "parkres: FAIL mutant 122 not caught: $per B/conn"; fail=1; }
read -r per2 back2 tb2 held <<< "$(run "$W/m131" SOBER_WORKERS=4)"
[ -n "${tb2:-}" ] && [ "$tb2" != 0 ] || { echo "parkres: FAIL mutant 131 not caught: Serve tasks after close $tb2"; fail=1; }
# chk <本数> <bin> [env…] → サーバーの終了コード（張って閉じた後も生きていれば alive）。136 は 8 本で見る（多く張ると、待ちの縮めの溜めが 1 MiB に
# 達して眠る前に反映され、子の返しが溜めに残らない）
chk() {
    local n=$1 bin=$2
    shift 2
    env "$@" "$bin" > "$W/c.out" 2>&1 &
    local p=$! port="" h
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/c.out"); [ -n "$port" ] && break; sleep 0.1; done
    rm -f "$W/in"; mkfifo "$W/in"
    timeout 30 node --experimental-strip-types --no-warnings scripts/mapcap.ts "$port" hold "$n" < "$W/in" > "$W/c.hold" 2>&1 &
    h=$!
    exec 7> "$W/in"
    for _ in $(seq 300); do grep -q held "$W/c.hold" && break; kill -0 $p 2> /dev/null || break; sleep 0.1; done
    exec 7>&-
    wait $h 2> /dev/null; sleep 1.5
    if kill -0 $p 2> /dev/null; then kill $p 2> /dev/null; wait $p 2> /dev/null; echo alive; else wait $p 2> /dev/null; echo $?; fi
}
r134a=$(chk 64 "$W/m134" SOBER_WORKERS=4); r134b=$(chk 64 "$W/m134" SOBER_WORKERS=4 PARKRES_CONNS=8); r134c=$(chk 8 "$W/m134" SOBER_WORKERS=4)
r135=$(chk 64 "$W/m135" SOBER_WORKERS=4 PARKRES_CONNS=8); r136=$(chk 8 "$W/m136" SOBER_WORKERS=4); r137=$(chk 64 "$W/m137" SOBER_WORKERS=4)
[ "$r134a" = alive ] && [ "$r134b" = alive ] && [ "$r134c" = alive ] || { echo "parkres: FAIL check build 134 broke an invariant (exit $r134a / $r134b / $r134c)"; fail=1; }
[ "$r135" = 103 ] || { echo "parkres: FAIL mutant 135 (130 + check) not caught: $r135"; fail=1; }
[ "$r136" = 103 ] || { echo "parkres: FAIL mutant 136 (132 + check) not caught: $r136"; fail=1; }
[ "$r137" = 103 ] || { echo "parkres: FAIL mutant 137 (133 + check) not caught: $r137"; fail=1; }
echo "parkres: $(tr '\n' ' ' < "$W/sum")· mutant 122: $per B/conn · mutant 131: tasks $tb2 · check 134: $r134a/$r134b/$r134c · 135/136/137: $r135/$r136/$r137, fail=$fail"
exit $fail
