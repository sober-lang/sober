#!/usr/bin/env bash
# slowcheck（受けと送りの期限。language.md 28節のhttpの項）: testdata/slowcheck/srv.sober（conns: 4・頭1秒・本文2秒・送りの間隔1秒）を立て、
# testdata/slowcheck/check.tsが遅い攻撃の4つの形（何も送らない・頭を少しずつ・本文を少しずつ・レスポンスを読まない）とTLSのClientHelloの途中で止まる形で
# 期限の内に黙って閉じられること、正常な遅いクライアント（期限の内に送り終える・少しずつ読み続ける・keep-aliveの間隔・長いハンドラ・Delayed）が通ることを見る。
# 構成 = W8（カーネルが受ければnetのring）・W1（epollのパス）・W8のepollのパス（SOBER_IO=2 — ringを作れない構成の模造。Dockerの既定のseccompの形）・SOBER_NET_FUSE=0・TLS（W8・W1）
# 受信バッファの固定（rcvbuf・各構成）と、一斉の到着でランタイムの列が上限で止まること（flood）と、署名の列（sign queue）と、epoll の経路の受信バッファの固定（unshare -rn の netem で RTT 20 ms）も見る
# SLOW_FULL=1の構成（W8・W1・TLSのW8・W1）は天井が4本の予約で埋まる構成で、check.ts --fullが、読まない相手の接続が天井で切られてcutに数えられることと、
# 同時に4本（TLSは握手から）が切られずに通ることを見る
#   scripts/slowcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
"$S2" build testdata/slowcheck/srv.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "slowcheck: FAIL build ($(head -c 300 "$W/build.log"))"; exit 1; }
# 署名の列（language.md 28節）の題材: W2 の TLS のサーバー（握手の headWait 100 ms）へ、素の TCP で ClientHello を送り続ける相手（signflood.ts）を掛ける。
# loop = 3,000 本が返事を受けるたびに繋ぎ直す（その最中に確立済みの TLS の接続 1 本のリクエストの応答の最大 = probe max）・burst = 12,000 本を一度に繋ぐ。
# sig <名前> <ELF> → signflood.ts の出力と "server exit=<終了コード> <stderr の頭>"
sig() {
    local m=$1 bin=$2 tp out rc
    tp=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')
    (ulimit -n 65536; exec env SLOW_TLS_PORT=$tp SLOW_CONNS=30000 SLOW_TLS_HW=100 SOBER_WORKERS=2 SLOW_NOWATCH=1 "$bin" > "$W/sg.$m.out" 2> "$W/sg.$m.err") &
    SP=$!
    for i in $(seq 100); do grep -q tls-ready "$W/sg.$m.out" && (exec 3<>/dev/tcp/127.0.0.1/$tp) 2>/dev/null && break; sleep 0.05; done
    sleep 0.3
    out=$(ulimit -n 65536; timeout 90 node --experimental-strip-types --no-warnings testdata/slowcheck/signflood.ts "$tp" 3000 12000 2>&1)
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    rc=$?
    SP=
    echo "$out"
    echo "server exit=$rc $(head -c 200 "$W/sg.$m.err" | tr '\n' ' ')"
}
# --probe（レベル3のゲート signprobe）: probe max が 400 ms 以下（静かな箱で 10 ms 前後・ゲートの負荷の下で 200 ms 前後。署名の列の無い形〔ミュータント111〕は 500 ms 前後）。
# 壁時計の量で、全件のゲートの負荷の下では越えることがあるので、レベル1の slowcheck では判定しない（保証そのものは下の検査のビルドが決定的に照合する）
if [ "${1:-}" = --probe ]; then
    sgo=$(sig 0 "$W/srv")
    spm=$(echo "$sgo" | sed -n 's/^probe max=\([0-9]*\) .*/\1/p')
    if [ -z "$spm" ] || [ "$spm" -gt 400 ]; then
        echo "signprobe: FAIL probe max ${spm:-none} ms (want ≤ 400) ($(echo "$sgo" | tr '\n' ' '))"; exit 1
    fi
    echo "signprobe: PASS (probe max ${spm} ms ≤ 400 · $(echo "$sgo" | sed -n 's/^\(burst .*\)/\1/p'))"
    exit 0
fi
fail=0
sum=
for cfg in "SOBER_WORKERS=8" "SOBER_WORKERS=1" "SOBER_WORKERS=8 SOBER_IO=2" "SOBER_WORKERS=8 SOBER_NET_FUSE=0" "SOBER_WORKERS=8 SLOW_TLS=1" "SOBER_WORKERS=1 SLOW_TLS=1" \
           "SOBER_WORKERS=8 SLOW_FULL=1" "SOBER_WORKERS=1 SLOW_FULL=1" "SOBER_WORKERS=8 SLOW_TLS=1 SLOW_FULL=1" "SOBER_WORKERS=1 SLOW_TLS=1 SLOW_FULL=1" \
           "SOBER_WORKERS=8 SLOW_V6=1"; do
    tlsenv=
    tlsarg=
    fullarg=
    hostarg=
    # SLOW_V6: srv を [::1] で立て、check.ts を ::1 から掛ける。Serve のワーカーごとの listener が IPv6 でも足されること（同じ port の LISTEN が 2 本以上）も見る。
    # IPv6 のループバックが無い環境は FAIL（外すのは SOBER_GATES_ALLOW_SKIP=ipv6 だけ）
    case "$cfg" in *SLOW_V6=1*)
        need_ipv6 slowcheck "the slow peers over ::1"; v6=$?
        [ $v6 = 2 ] && fail=1
        [ $v6 = 0 ] || continue
        hostarg="--host ::1" ;;
    esac
    case "$cfg" in *SLOW_FULL=1*) fullarg=--full ;; esac
    case "$cfg" in *SLOW_TLS=1*)
        tlsenv="SLOW_TLS_PORT=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')"
        tlsarg=--tls ;;
    esac
    env $cfg $tlsenv "$W/srv" > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    port=
    for i in $(seq 100); do
        if [ -n "$tlsenv" ]; then
            p=$(sed -n 's/^tls-ready \([0-9]*\)$/\1/p' "$W/srv.out")
            [ -n "$p" ] && (exec 3<>/dev/tcp/127.0.0.1/$p) 2>/dev/null && port=$p
        else
            port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
        fi
        [ -n "$port" ] && break
        sleep 0.05
    done
    if [ -z "$port" ]; then
        echo "slowcheck: FAIL $cfg: server did not start ($(head -c 200 "$W/srv.err"))"; fail=1
    else
        if [ -n "$hostarg" ]; then
            nl=$(ss -Hltn "sport = :$port" 2> /dev/null | wc -l)
            [ "$nl" -ge 2 ] || { echo "slowcheck: FAIL $cfg: $nl IPv6 listener(s) on port $port (want one per worker, ≥ 2)"; fail=1; }
            sum="$sum[v6 listeners $nl]"
        fi
        out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/slowcheck/check.ts "$port" $tlsarg $fullarg $hostarg 2>&1) || { echo "slowcheck: FAIL $cfg (port $port)"; echo "$out" | grep -v '^ok' | tail -20; echo "--- srv stderr（末尾）"; tail -c 1000 "$W/srv.err"; fail=1; }
        sum="$sum [$cfg: $(echo "$out" | sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p')]"
        # net.Waiting: wait-full の間に待っている接続の数が 2 以上になり、上限は 1 以上（io_uring の経路では待ちが短いので、待っている接続のために
        # 枠を取り戻した〔evicted ≥ 1〕ことでも、待っている接続があったと見る）
        wmax=$(sed -n 's/^waiting \([0-9]*\) [0-9]*$/\1/p' "$W/srv.err" | sort -n | tail -1)
        evm=$(sed -n 's/^evicted \([0-9]*\)$/\1/p' "$W/srv.err" | sort -n | tail -1)
        [ "${evm:-0}" -ge 1 ] && [ "${wmax:-0}" -lt 2 ] && wmax=2
        wlim=$(sed -n 's/^waiting [0-9]* \([0-9]*\)$/\1/p' "$W/srv.err" | sort -n | tail -1)
        # SLOW_FULL の構成は check.ts --full が wait-full を走らせないので見ない
        if [ -z "$fullarg" ] && { [ "${wmax:-0}" -lt 2 ] || [ "${wlim:-0}" -lt 1 ]; }; then
            echo "slowcheck: FAIL $cfg: net.Waiting max ${wmax:-none} limit ${wlim:-none} (want ≥ 2 and ≥ 1)"; fail=1
        fi
        sum="$sum[waiting ${wmax:-0}/${wlim:-0} evicted ${evm:-0}]"
    fi
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    SP=
done
# 一斉の到着: 箱を小さくした（SOBER_BUDGET_MB=1024）TLS のサーバー（W2・conns: 2000 — 入場の本数の天井は conns: を書いたときだけ）へ、2,000 本の握手を始めて
# ワーカーを握手で埋めた最中に、素の TCP を 20,000 本一度に繋ぐ（相手は node を6本に分ける）。サーバーの側の established の最大が、
# 入場 A（= conns:）+ 待ち行列とランタイムの列（listener ごとに 2·(B + 1)）+ 余白（listener ごとに 2·B）+ 手に持つ分を越えないこと（limit = Σ B — net.Waiting）。
# ランタイムの列に上限が無いと、受け付けのループが握手の task の後ろで待つ間に ACCEPT の完了が積まれ、到着のほぼ全部が列へ移る（変異で約16,000本）
# 経路ごとに回す: $1 = 足す環境（空 = ringの経路）・$2 = 記録の名前の添え字
flood() {
    tp=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')
    (ulimit -n 65536; exec env $1 SLOW_TLS_PORT=$tp SLOW_CONNS=2000 SOBER_WORKERS=2 SOBER_BUDGET_MB=1024 "$W/srv" > "$W/fl$2.out" 2> "$W/fl$2.err") &
    SP=$!
    for i in $(seq 100); do grep -q tls-ready "$W/fl$2.out" && (exec 3<>/dev/tcp/127.0.0.1/$tp) 2>/dev/null && break; sleep 0.05; done
    sleep 0.3
    cps=()
    for k in 1 2; do (ulimit -n 65536; node --experimental-strip-types --no-warnings testdata/slowcheck/tlsflood.ts hs $tp 1000 4000 >> "$W/fl$2.c") & cps+=($!); done
    sleep 0.3
    for k in 1 2 3 4; do (ulimit -n 65536; node --experimental-strip-types --no-warnings testdata/slowcheck/tlsflood.ts raw $tp 5000 3000 >> "$W/fl$2.c") & cps+=($!); done
    est=0
    for i in $(seq 30); do n=$(ss -tnH state established "( sport = :$tp )" | wc -l); [ "$n" -gt "$est" ] && est=$n; sleep 0.1; done
    wait "${cps[@]}" 2>/dev/null
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    SP=
    acap=2000
    lim=$(sed -n 's/^waiting [0-9]* \([0-9]*\)$/\1/p' "$W/fl$2.err" | tail -1)
    # 握手の相手は2本とも結果を出すこと（終わった握手の数は記録に残す。列で長く待った握手は、後から来た素の TCP に押し出されて古い順に閉じられうる —
    # 満杯のときに列で待たせる既定の性質で、全部が終わることは求めない）
    hs=$(grep -c '^hs 1000 done [0-9]*$' "$W/fl$2.c")
    hsn=$(sed -n 's/^hs 1000 done \([0-9]*\)$/\1/p' "$W/fl$2.c" | tr '\n' '+' | sed 's/+$//')
    # 余白: ACCEPT は止めないので、ワーカーが握手で忙しい間は、受けた接続の完了が ring の完了の列に積まれたまま取り込まれていない分がある（列の上限で閉じる前の分）。
    # listener ごとに 2·B を許す（conns: 2000 で実測 4580 = A + 3·Σ B + 114。列の上限を外した変異は約 14,000 本で、この上限でも落ちる）
    bound=$((${acap:-0} + 4 * ${lim:-0} + 6))
    if [ -z "$acap" ] || [ -z "$lim" ] || [ "$est" -gt "$bound" ] || [ "$hs" != 2 ]; then
        echo "slowcheck: FAIL flood$2: established max $est > bound $bound (A ${acap:-none} limit ${lim:-none}) or handshakes not done ($(tr '\n' ' ' < "$W/fl$2.c"))"; fail=1
    else
        sum="$sum [flood$2: $est ≤ $bound · handshakes $hsn / 2000]"
    fi
}
flood "" ""
# epollの経路（SOBER_IO=2）でも、受け付けを止めずに列の上限で止まること
flood SOBER_IO=2 -epoll
# 署名の列: (1) 保証の照合 = 検査のビルド（ミュータント123 — rt.mn_next が、実行待ちの列が空でないときに署名の列から取るのは MN_BACKLOG_EVERY 周に1本までかを
#     取るたびに照合し、外れたら印字して終了コード103）で loop と burst を通して103が出ない。自己点検: ミュータント124（123 + 毎周まず署名の列から取る）では103が出る。
# (2) burst で、署名の列で待つ間に期限の過ぎた接続が、何も送られずに閉じられる（empty ≥ 1。ふつうは数千本。ミュータント110 = 期限の走査が署名の列を見ない形・
#     ミュータント111 = 署名の列の無い形は、時間に依らず捕まえるため149 = 111 + 照合〔M:Nでは署名はいつも署名の列を通る〕にして、103で捕まえる）。probe max は判定しない（--probe・ゲート signprobe）
sgx() { echo "$1" | sed -n "$2"; }
for m in 123 124 110 149; do
    "$S2" build testdata/slowcheck/srv.sober --emit=elf --passes --rt-mutant=$m -o "$W/srv.m$m" > "$W/build.m$m.log" 2>&1 || { echo "slowcheck: FAIL build srv mutant $m"; fail=1; continue; }
    mo=$(sig m$m "$W/srv.m$m")
    me=$(sgx "$mo" 's/^burst flights=[0-9]* empty=\([0-9]*\) .*/\1/p')
    mx=$(sgx "$mo" 's/^server exit=\([0-9]*\) .*/\1/p')
    case $m in
    123)
        if [ -z "$me" ] || [ "$mx" = 103 ] || [ "$me" -lt 1 ]; then
            echo "slowcheck: FAIL sign queue: exit ${mx:-none} (want not 103 — the check build) · expired in the queue ${me:-none} (want ≥ 1) ($(echo "$mo" | tr '\n' ' '))"; fail=1
        else
            sum="$sum [sign queue: one signature per $(sed -n 's/^const MN_BACKLOG_EVERY = \([0-9]*\)$/\1/p' src/compiler/lower/mn.sober) rounds · expired ${me} · probe $(sgx "$mo" 's/^probe max=\([0-9]*\) .*/\1/p') ms]"
        fi ;;
    124|149)
        [ "$mx" = 103 ] || { echo "slowcheck: FAIL — mutant $m was not caught by the sign queue check build (exit ${mx:-none})"; fail=1; } ;;
    *)
        if [ -n "$me" ] && [ "$me" -ge 1 ]; then
            echo "slowcheck: FAIL — mutant $m was not caught by the sign queue check ($(echo "$mo" | tr '\n' ' '))"; fail=1
        fi ;;
    esac
done
# 受信バッファの固定（epoll の経路 — SOBER_IO=2）: ユーザーとネットワークの名前空間（unshare -rn）の中で lo に netem の遅延 10 ms（RTT 20 ms）を置き、
# 4 MiB の pipelined の GET を読ませた後もサーバーの側の rb が 131072 のまま（受けた時点の SO_RCVBUF 64 KiB を外すと約 340 KB に広がる）
rbo=$(unshare -rn bash -c '
ip link set lo up && tc qdisc add dev lo root netem delay 10ms limit 100000 || { echo "netem: unavailable"; exit 0; }
SOBER_WORKERS=2 SOBER_IO=2 "$1" > "$2/rb.out" 2>&1 &
p=$!
for i in $(seq 100); do port=$(sed -n "s/^ready \([0-9]*\)$/\1/p" "$2/rb.out"); [ -n "$port" ] && break; sleep 0.05; done
timeout 120 node --experimental-strip-types --no-warnings testdata/slowcheck/rbdelay.ts "$port" 4194304
kill $p
' _ "$W/srv" "$W" 2>&1)
rbe=$(echo "$rbo" | sed -n 's/.*rb_end=\([0-9,]*\) rb_max=\([0-9]*\)$/\1 \2/p')
if [ "$rbe" != "131072 131072" ]; then
    echo "slowcheck: FAIL rcvbuf (epoll, RTT 20 ms): ${rbo:-no output} (want rb_end=131072 rb_max=131072)"; fail=1
else
    sum="$sum [rcvbuf epoll RTT 20ms: 131072]"
fi
if [ $fail -ne 0 ]; then
    echo "slowcheck: FAIL$sum"
    exit 1
fi
echo "slowcheck: PASS$sum"
