#!/usr/bin/env bash
# mapcap: 新しい接続の task のチャンクが作れないとき（写像の数の上限 vm.max_map_count に届いた形 — 開発用 SOBER_MAPCAP で模造）、Serve はその接続だけを
# 断り、入場済みの接続は応答し続けること（rt.task_new_in の失敗は呼んだ受け付けのループを死なせず、その子だけの shed）。
#   ① testdata/mapcap/main.sober を SOBER_MAPCAP=300 で走らせ、scripts/mapcap.ts が接続を足していって断られる接続を20本出した後、保持した接続の全部に
#      GET をもう1回送り、全部が 200 で答える（ワーカー4 × 経路 {自動〔ring〕, SOBER_IO=1〔epoll〕}）
#   ② 自己点検: ミュータント120（SpawnIn でもチャンクの失敗で死ぬ — 直しの前の形）では、保持した接続の一部しか答えない
#   ③ 写像の数: SOBER_MAPCAP なしで3,000本を保持したとき、サーバーの写像（/proc/<pid>/maps の行）の増えが100未満（task のチャンクとエリアは
#      アリーナから切り出し、ガードは MADV_GUARD_INSTALL で置くので、写像は接続の数に依らない）。カーネルが MADV_GUARD_INSTALL を持たない（6.13 より前）なら
#      ③ は飛ばす。自己点検: ミュータント121（ガードを常に mprotect で置く）では増えが3,000以上
#   scripts/mapcap.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
# サーバーは接続を3,000本持つので、fd の soft の上限を上げる（多くの環境の既定は1024で、届くと受け付けが止まり本数も台帳も崩れる）
need_nofile mapcap 4096; rc=$?
[ $rc = 2 ] && exit 1
[ $rc = 1 ] && exit 0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$S2" build testdata/mapcap/main.sober --emit=elf --passes -o "$W/ok" > "$W/b.log" 2>&1 || { echo "mapcap: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
"$S2" build testdata/mapcap/main.sober --emit=elf --passes --rt-mutant=120 -o "$W/m120" > "$W/b.log" 2>&1 || { echo "mapcap: FAIL build mutant 120 ($(head -c 200 "$W/b.log"))"; exit 1; }
# run <bin> [env…] → mapcap.ts の出力（held H shed S recheck R）
run() {
    local bin=$1
    shift
    env "$@" SOBER_MAPCAP=300 "$bin" > "$W/srv.out" 2>&1 &
    local p=$! port=""
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.1; done
    [ -n "$port" ] && timeout 120 node --experimental-strip-types --no-warnings scripts/mapcap.ts "$port"
    kill $p 2> /dev/null; wait $p 2> /dev/null
}
for io in "" 1; do
    got=$(run "$W/ok" SOBER_WORKERS=4 ${io:+SOBER_IO=$io})
    read -r _ h _ s _ r <<< "$got"
    if [ -z "${r:-}" ] || [ "$h" -le 0 ] || [ "$s" -le 0 ] || [ "$r" != "$h" ]; then
        echo "mapcap: FAIL SOBER_IO=${io:-auto}: $got (want shed > 0 and recheck = held)"; fail=1
    fi
    echo "  SOBER_IO=${io:-auto}: $got" >> "$W/sum"
done
got=$(run "$W/m120" SOBER_WORKERS=4)
read -r _ h _ s _ r <<< "$got"
if [ -n "${r:-}" ] && [ "$r" = "$h" ]; then
    echo "mapcap: FAIL mutant 120 not caught: $got"; fail=1
fi
# vmas <bin>: SOBER_MAPCAP なしで3,000本を保持したときの写像の行の増え
vmas() {
    SOBER_WORKERS=4 "$1" > "$W/srv.out" 2>&1 &
    local p=$! port="" m0 m1
    for _ in $(seq 100); do port=$(sed -n 's/^ready //p' "$W/srv.out"); [ -n "$port" ] && break; sleep 0.1; done
    m0=$(wc -l < /proc/$p/maps)
    mkfifo "$W/in"
    node --experimental-strip-types --no-warnings scripts/mapcap.ts "$port" hold 3000 < "$W/in" > "$W/hold.out" 2>&1 &
    local h=$!
    exec 7> "$W/in"
    for _ in $(seq 600); do grep -q held "$W/hold.out" && break; sleep 0.1; done
    m1=$(wc -l < /proc/$p/maps)
    exec 7>&-
    wait $h; kill $p 2> /dev/null; wait $p 2> /dev/null; rm -f "$W/in"
    echo "$(cat "$W/hold.out") maps +$((m1 - m0))"
}
guard=$(uname -r | awk -F. '{print ($1 > 6 || ($1 == 6 && $2 >= 13)) ? 1 : 0}')
if [ "$guard" = 1 ]; then
    "$S2" build testdata/mapcap/main.sober --emit=elf --passes --rt-mutant=121 -o "$W/m121" > "$W/b.log" 2>&1 || { echo "mapcap: FAIL build mutant 121"; exit 1; }
    va=$(vmas "$W/ok"); vm=$(vmas "$W/m121")
    da=$(echo "$va" | sed -n 's/.*maps +\([0-9]*\)/\1/p'); dm=$(echo "$vm" | sed -n 's/.*maps +\([0-9]*\)/\1/p')
    [[ "$va" == "held 3000 "* ]] && [ "${da:-999999}" -lt 100 ] || { echo "mapcap: FAIL vmas: $va (want held 3000 and maps +< 100)"; fail=1; }
    [ "${dm:-0}" -ge 3000 ] || { echo "mapcap: FAIL mutant 121 not caught: $vm"; fail=1; }
    echo "  vmas: $va · mutant 121: $vm" >> "$W/sum"
else
    echo "  vmas: skipped (kernel $(uname -r) < 6.13 — no MADV_GUARD_INSTALL)" >> "$W/sum"
fi
echo "mapcap: $(tr '\n' ' ' < "$W/sum")· mutant 120: ${got:-no output}, fail=$fail"
exit $fail
