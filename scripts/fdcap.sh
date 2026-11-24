#!/usr/bin/env bash
# fdcap: 番号の大きい fd（65,536 を越える番号）で net と tls の Serve が受けて応答すること（rt の FD_CAP = 2^FD_BITS・io_uring の user_data の fd の欄）。
#   ① 定数の照合: src/compiler/lower/rt.sober の 2^FD_BITS と src/std/net/net.sober の fdCap が同じ値
#   ② testdata/fdcap/main.sober を、先に fd を約66,000本開いたシェル（次に開く fd の番号が 65,536 を越える）で、ワーカー {1, 4} × 経路 {自動〔ring〕, SOBER_IO=1〔epoll〕} で
#      走らせ、平文と TLS の全部の応答（/t・/d〔時刻つきの送り〕・/t）が返る。fd を開かない形でも同じ出力
#   ③ 自己点検: ミュータント119（user_data / epoll の data から fd を取り出すマスクを16ビットに戻す）を、fd を開いた状態で走らせると出力が変わる
#      （ring = W4 の自動・epoll = W1 の SOBER_IO=1。W4 の SOBER_IO=1 では、どの接続の受けも TCB の番地で起きるので、fd の欄を読むのは listener の1か所だけで、出力が変わらないことがある）
#   scripts/fdcap.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
need_nofile fdcap 70000; rc=$?
[ $rc = 2 ] && exit 1
[ $rc = 1 ] && exit 0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bits=$(sed -n 's/^const FD_BITS = \([0-9]*\)$/\1/p' src/compiler/lower/rt.sober)
cap=$(sed -n 's/^const fdCap = \([0-9]*\)$/\1/p' src/std/net/net.sober)
if [ -z "$bits" ] || [ -z "$cap" ] || [ $((1 << bits)) != "$cap" ]; then
    echo "fdcap: FAIL constants: 2^FD_BITS (FD_BITS=$bits) != std/net fdCap ($cap)"; fail=1
fi
"$S2" build testdata/fdcap/main.sober --emit=elf --passes -o "$W/ok" > "$W/b.log" 2>&1 || { echo "fdcap: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
"$S2" build testdata/fdcap/main.sober --emit=elf --passes --rt-mutant=119 -o "$W/m119" > "$W/b.log" 2>&1 || { echo "fdcap: FAIL build mutant 119 ($(head -c 200 "$W/b.log"))"; exit 1; }
want=$(printf 'plain: 72 / 72\ntls: 72 / 72')
# TLS の Serve は自分で listen するので、ポートは一時ポートの範囲（ip_local_port_range）の外から選ぶ（範囲の中だと、並べて走る別のゲートのクライアントの
# 送信元ポートと重なって listen できず、TLS の応答が全部失敗することがある）
lo=$(cut -f1 /proc/sys/net/ipv4/ip_local_port_range)
port=$((2000 + RANDOM % (lo > 2100 ? lo - 2100 : 1)))
# run <bin> <occupy 0|1> [env…] → 出力（終了コードと、occupy のときは最後に開いた fd の番号を足す）
run() {
    local bin=$1 occ=$2
    shift 2
    (
        if [ "$occ" = 1 ]; then
            for _ in $(seq 66000); do exec {x}< /dev/null; done
            [ "$x" -ge 65600 ] || { echo "occupy: last fd $x"; exit 9; }
        fi
        port=$((port + 1))
        env "$@" timeout 60 "$bin" $port testdata/crypto/httparena-server.crt testdata/crypto/httparena-server.key 2>&1
    )
}
n=0
for occ in 0 1; do
    for w in 1 4; do
        for io in "" 1; do
            port=$((port + 2))
            got=$(run "$W/ok" $occ SOBER_WORKERS=$w ${io:+SOBER_IO=$io})
            n=$((n + 1))
            [ "$got" = "$want" ] || { echo "fdcap: FAIL occupy=$occ W$w SOBER_IO=${io:-auto}: $(echo "$got" | head -3 | tr '\n' '|')"; fail=1; }
        done
    done
done
caught=0
for cfg in "SOBER_WORKERS=4" "SOBER_WORKERS=1 SOBER_IO=1"; do
    port=$((port + 2))
    got=$(run "$W/m119" 1 $cfg)
    if [ "$got" = "$want" ]; then
        echo "fdcap: FAIL mutant 119 not caught ($cfg)"; fail=1
    else
        caught=$((caught + 1))
    fi
done
echo "fdcap: constants 2^$bits = $cap · $n runs (fd ≥ 65,536 and low fds · W1/W4 · ring/epoll) · mutant 119 caught $caught/2, fail=$fail"
exit $fail
