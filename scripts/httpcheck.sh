#!/usr/bin/env bash
# httpcheck（net段階4c — std/http・report-670）: testdata/httpcheck/srv.sober（HttpArenaの題材の端点 /baseline11・/pipeline・/delay/{ms}）をビルドして立て、
# testdata/httpcheck/check.ts（HttpArenaのvalidate.sh / validate-frag.pyを模した検査 — baselineのGET / POST〔Content-Lengthとchunked〕・乱数の入力・
# 小文字のヘッダ・断片化〔CR と LF の間・Content-Length の桁の途中・chunk の 16 進の途中・ヘッダ名の途中 + 乱数の位置 100〕・1 バイトずつの送り・
# パイプライン16本と混ぜた列・keep-aliveの張り直し50 × 10・HTTP/1.0・誤り〔400 / 413 / 431 / 501 / 505 — レスポンスの後に閉じる〕・上限ちょうど・/delayの待ち・
# /json/{count}?m= の全フィールドをdataset〔testdata/httpcheck/dataset.json = HttpArenaのdata/dataset.json・MIT〕と照合 — 本家validate.shのjsonの検査の形）を掛ける。
# 構成 = W8（netのring — カーネルが受ければ）とW1（協調形・epollのパス）。番号は空いているものをサーバが選んで "ready <port>" で知らせる
#   scripts/httpcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
# Dateは実の時計で見る（check.tsのdateHdrが今の時刻 ±5秒を見る。gates.shの固定の値を外す）
unset SOBER_DATE_SEC
source scripts/gatelib.sh
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
# 出所の動的オラクルの前提: srv は analyzer が受理したプログラム（共有のルートは源に届かない — check.ts の originEp が観測 ⊆ 導出を見る）
"$S2" check testdata/httpcheck/srv.sober > "$W/check.log" 2>&1 || { echo "httpcheck: FAIL check — srv must pass the analyzer ($(head -c 300 "$W/check.log"))"; exit 1; }
"$S2" build testdata/httpcheck/srv.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "httpcheck: FAIL build ($(head -c 200 "$W/build.log"))"; exit 1; }
fail=0
sum=
# 構成 = ワーカー数 × 符号器の作業域（SRV_WORK=1 = ServeConn の work: — ワーカー局所の lease・report-720）+ echo の大きい本文（SRV_MAXBODY = 128 KiB の
# maxBody: で check.ts --echo-big — HttpArena の 8gbit の validate の 100 KB と上限ちょうどの 128 KiB を Content-Length と chunked で・超えた 1 本〔+1 B・1 MB〕は 413。
# 上限はbench/httparenaのentryと同じ値。W8 / W1 — report-848 / 849）。W8の受けは増分消費の環（カーネル6.12以上）が既定 — SOBER_PBUF_INC=0の2構成で固定スロットの環のパスも見る。
# 平文のkeep-aliveのレスポンスの送りは次の受けの待ちと畳む（rt.netop 9 — 既定）— SOBER_NET_FUSE=0の構成で畳まないパスも見る。
# TLS の構成（SRV_TLS=1 — srv が tls.Serve + ServeWith の put: で立ち、check.ts --tls が生の送受の群〔パイプライン・stream を挟むパイプライン・誤り・echo〕を TLS の上で掛ける）
for cfg in "SOBER_WORKERS=8" "SOBER_WORKERS=1" "SOBER_WORKERS=8 SRV_WORK=1" "SOBER_WORKERS=1 SRV_WORK=1" "SOBER_WORKERS=8 SRV_MAXBODY=131072" "SOBER_WORKERS=1 SRV_MAXBODY=131072" "SOBER_WORKERS=8 SOBER_PBUF_INC=0" "SOBER_WORKERS=8 SRV_MAXBODY=131072 SOBER_PBUF_INC=0" "SOBER_WORKERS=8 SRV_MAXBODY=131072 SRV_TLS=1" "SOBER_WORKERS=1 SRV_TLS=1" "SOBER_WORKERS=8 SRV_TLS=1" "SOBER_WORKERS=8 SRV_TLS=1 SOBER_NET_FUSE=0" "SOBER_WORKERS=8 SOBER_NET_FUSE=0" "SOBER_WORKERS=8 SRV_FRESH=1"; do
    rm -rf "$W/static" && mkdir -p "$W/static/www"
    rm -f "$W/flight"
    tlsenv=
    tlsarg=
    case "$cfg" in *SRV_TLS=1*)
        tlsenv="SRV_TLS_PORT=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')"
        tlsarg=--tls ;;
    esac
    env $cfg $tlsenv SOBER_FLIGHT="$W/flight" DATASET_PATH=testdata/httpcheck/dataset.json STATIC_ROOT="$W/static/www" "$W/srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    port=
    for i in $(seq 100); do
        if [ -n "$tlsenv" ]; then
            # tls.Serve は "tls-ready" の後に待ち受けを張る — 繋がるまで待つ
            p=$(sed -n 's/^tls-ready \([0-9]*\)$/\1/p' "$W/srv.out")
            [ -n "$p" ] && (exec 3<>/dev/tcp/127.0.0.1/$p) 2>/dev/null && port=$p
        else
            port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
        fi
        [ -n "$port" ] && break
        sleep 0.05
    done
    if [ -z "$port" ]; then
        echo "httpcheck: FAIL $cfg — server did not start ($(head -c 200 "$W/srv.err"))"; fail=1
    else
        big=
        case "$cfg" in *SRV_MAXBODY*) big="--echo-big --rss-pid $SP" ;; esac
        out=$(timeout 120 node --experimental-strip-types --experimental-eventsource --no-warnings testdata/httpcheck/check.ts "$port" --frag-random 100 $big $tlsarg --static "$W/static" 2>&1) || { echo "httpcheck: FAIL $cfg (port $port)"; echo "$out" | tail -20; echo "--- srv stderr（末尾）"; tail -c 2000 "$W/srv.err"; ss -Hltnp "sport = :$port" 2>/dev/null | head -5; FL_KEEP=1; fail=1; }
        sum="$sum [$cfg: $(echo "$out" | sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p')]"
    fi
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    SP=
    # 落ちた構成の飛行記録（SOBER_FLIGHT — report-1176）: 読み（--anomaly と落ちの lport= ごとの --conn の頭）を出し、HTTPCHECK_KEEP があればファイルをそこへ
    if [ -n "${FL_KEEP:-}" ] && [ -f "$W/flight" ]; then
        echo "--- flight（scripts/flight.ts — $cfg）"
        node --experimental-strip-types --no-warnings scripts/flight.ts "$W/flight" --summary
        node --experimental-strip-types --no-warnings scripts/flight.ts "$W/flight" --anomaly | head -20
        for lp in $(echo "$out" | sed -n 's/.* lport=\([1-9][0-9]*\).*/\1/p' | head -3); do
            node --experimental-strip-types --no-warnings scripts/flight.ts "$W/flight" --conn "$lp" | tail -40
        done
        [ -n "${HTTPCHECK_KEEP:-}" ] && mkdir -p "$HTTPCHECK_KEEP" && cp "$W/flight" "$HTTPCHECK_KEEP/flight-$(echo "$cfg" | tr ' =' '_-').bin"
    fi
    FL_KEEP=
done
# IPv6: srv をホストを省いた ":port"（SRV_LISTEN=dual — dual-stack）で立て、代表の群（check.ts --quick: baseline・パイプライン・誤り・json）を
# 127.0.0.1 と ::1 の両方から掛ける（W8・W1）。IPv6 のループバックが無い環境は FAIL（外すのは SOBER_GATES_ALLOW_SKIP=ipv6 だけ）
need_ipv6 httpcheck "the dual-stack listener over ::1"; v6=$?
[ $v6 = 2 ] && fail=1
if [ $v6 = 0 ]; then
    for w in 8 1; do
        env SOBER_WORKERS=$w SRV_LISTEN=dual DATASET_PATH=testdata/httpcheck/dataset.json "$W/srv" 0 > "$W/srvd.out" 2> "$W/srvd.err" &
        SP=$!
        port=
        for i in $(seq 100); do port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srvd.out"); [ -n "$port" ] && break; sleep 0.05; done
        if [ -z "$port" ]; then
            echo "httpcheck: FAIL dual W$w — server did not start ($(head -c 200 "$W/srvd.err"))"; fail=1
        else
            for h in 127.0.0.1 ::1; do
                out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/httpcheck/check.ts "$port" --quick --host "$h" 2>&1) || { echo "httpcheck: FAIL dual W$w host $h (port $port)"; echo "$out" | tail -20; fail=1; }
                sum="$sum [dual W$w $h: $(echo "$out" | sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p')]"
            done
        fi
        kill $SP 2>/dev/null
        wait $SP 2>/dev/null
        SP=
    done
fi
# 時刻つきの送信バッファリング（Delayed — rt.netop 9のms）の検査一式の自己検査: ミュータント84（受けが満了を待たない）・87（格納場所の容量2で溢れた送りが待たずに出る）でビルドした
# srvはDelayedの検査で落ちる・88（容量2 — 溢れてrt.sleepに倒す正しい形）は通る。examples/http_delayed_cut.soberは既定でゴールデン（.out）どおり、
# ミュータント85（期限で切ったマークを見ない）・86（閉じが送らないマークを付けない）はW8・87はW1（ringのパスでない送りの待ち）でゴールデンから外れる
for m in 84 87 88; do
    "$S2" build testdata/httpcheck/srv.sober --emit=elf --passes --rt-mutant=$m -o "$W/srv.m$m" > "$W/build.m$m.log" 2>&1 || { echo "httpcheck: FAIL build srv mutant $m"; fail=1; continue; }
    for w in 1 8; do
        env SOBER_WORKERS=$w DATASET_PATH=testdata/httpcheck/dataset.json "$W/srv.m$m" 0 > "$W/srvm.out" 2> /dev/null &
        SP=$!
        port=
        for i in $(seq 100); do port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srvm.out"); [ -n "$port" ] && break; sleep 0.05; done
        rc=0
        timeout 60 node --experimental-strip-types --no-warnings testdata/httpcheck/check.ts "$port" --delayed-only > "$W/m$m.$w.log" 2>&1 || rc=$?
        kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
        if [ $m = 88 ] && [ $rc != 0 ]; then echo "httpcheck: FAIL delayed with pool capacity 2 (mutant 88) W$w"; tail -5 "$W/m$m.$w.log"; fail=1; fi
        if [ $m != 88 ] && [ $w = 8 ] && [ $rc = 0 ]; then echo "httpcheck: FAIL — mutant $m was not caught by the delayed check W$w"; fail=1; fi
    done
done
"$S2" build examples/http_delayed_cut.sober --emit=elf --passes -o "$W/cut" > /dev/null 2>&1 || { echo "httpcheck: FAIL build http_delayed_cut"; fail=1; }
for w in 1 8; do
    env SOBER_WORKERS=$w timeout 30 "$W/cut" > "$W/cut.$w" 2>&1
    cmp -s "$W/cut.$w" examples/http_delayed_cut.out || { echo "httpcheck: FAIL http_delayed_cut W$w"; diff examples/http_delayed_cut.out "$W/cut.$w" | head -5; fail=1; }
done
for mw in "85 8" "86 8" "87 1"; do
    set -- $mw
    "$S2" build examples/http_delayed_cut.sober --emit=elf --passes --rt-mutant=$1 -o "$W/cut.m$1" > /dev/null 2>&1 || { echo "httpcheck: FAIL build http_delayed_cut mutant $1"; fail=1; continue; }
    env SOBER_WORKERS=$2 timeout 30 "$W/cut.m$1" > "$W/cut.m$1.out" 2>&1
    cmp -s "$W/cut.m$1.out" examples/http_delayed_cut.out && { echo "httpcheck: FAIL — mutant $1 was not caught by http_delayed_cut W$2"; fail=1; }
done
# TLSのPutの送信バッファの予約（rt.netop 12・13）: ミュータント95のsrvで、TLSの検査一式がW2で通る。ミュータント95は送信バッファをチャンク2つに見る。意味は変えずに、送信バッファが尽きて同期の送りへ戻る経路を通す
"$S2" build testdata/httpcheck/srv.sober --emit=elf --passes --rt-mutant=95 -o "$W/srv.m95" > "$W/build.m95.log" 2>&1 || { echo "httpcheck: FAIL build srv mutant 95"; fail=1; }
if [ -f "$W/srv.m95" ]; then
    tp=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')
    env SOBER_WORKERS=2 SRV_TLS_PORT=$tp DATASET_PATH=testdata/httpcheck/dataset.json STATIC_ROOT="$W/static95/www" "$W/srv.m95" 0 > "$W/srv95.out" 2> /dev/null &
    SP=$!
    for i in $(seq 100); do grep -q '^tls-ready' "$W/srv95.out" && (exec 3<>/dev/tcp/127.0.0.1/$tp) 2>/dev/null && break; sleep 0.05; done
    out=$(timeout 120 node --experimental-strip-types --experimental-eventsource --no-warnings testdata/httpcheck/check.ts "$tp" --frag-random 100 --tls --static "$W/static95" 2>&1) || { echo "httpcheck: FAIL TLS with sink capacity 2 (mutant 95) W2"; echo "$out" | tail -10; fail=1; }
    kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
    sum="$sum [TLS sink capacity 2 (mutant 95) W2: $(echo "$out" | sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p')]"
fi
# 公開のtls.Send / tls.Put / tls.Flushの送りの失敗（testdata/tlserr）: 相手がRSTで切った後の送りの失敗を、その呼び出しが返す（W2・W8）。
# ミュータント96（op 13がいつも完了を待たない）のsrvでは、handlerの最後のtls.Sendの失敗がhandlerに返らないこと
tlserr() { # tlserr <srv> <mode> <W> → handlerが書いた行
    local tp out
    tp=$(node -e 'const s=require("net").createServer().listen(0,"127.0.0.1",()=>{console.log(s.address().port);s.close()})')
    out="$W/tlserr.$1.$2.$3"; rm -f "$out"
    env SOBER_WORKERS=$3 TLSERR_MODE=$2 TLSERR_PORT=$tp TLSERR_OUT="$out" "$W/$1" > "$W/$1.out" 2>&1 &
    local sp=$!
    for i in $(seq 100); do grep -q '^tls-ready' "$W/$1.out" && break; sleep 0.05; done
    timeout 20 node --experimental-strip-types --no-warnings testdata/tlserr/client.ts "$tp" > /dev/null 2>&1
    for i in $(seq 60); do [ -f "$out" ] && grep -q "send\|flush\|recv" "$out" && break; sleep 0.05; done
    kill $sp 2>/dev/null; wait $sp 2>/dev/null
    tr '\n' '|' < "$out" 2>/dev/null
}
"$S2" build testdata/tlserr/srv.sober --emit=elf --passes -o "$W/tlserr" > "$W/build.tlserr.log" 2>&1 || { echo "httpcheck: FAIL build tlserr"; fail=1; }
"$S2" build testdata/tlserr/srv.sober --emit=elf --passes --rt-mutant=96 -o "$W/tlserr96" > "$W/build.tlserr96.log" 2>&1 || { echo "httpcheck: FAIL build tlserr mutant 96"; fail=1; }
if [ -f "$W/tlserr" ] && [ -f "$W/tlserr96" ]; then
    for w in 2 8; do
        for m in "L:L send: closed|" "F:F put: ok flush: closed|" "R:R put: ok|R recv: closed|"; do
            got=$(tlserr tlserr "${m%%:*}" $w)
            [ "$got" = "${m#*:}" ] || { echo "httpcheck: FAIL tlserr ${m%%:*} W$w: got '$got' want '${m#*:}'"; fail=1; }
        done
    done
    got=$(tlserr tlserr96 L 2)
    [ "$got" = "L send: ok|" ] || { echo "httpcheck: FAIL: mutant 96 was not caught by tlserr L W2 (got '$got')"; fail=1; }
    sum="$sum [tlserr L F R × W2 W8 + mutant 96]"
fi
# 読まない相手への常駐（testdata/httpcheck/unread）: 8本の接続でGET /big（256 KiB）を400本ずつパイプラインで送って受けない。サーバーのRSSの増えが64 MiB以下
# （正しい形で約24 MiB。列に上限が無い形では約270 MiB）
"$S2" build testdata/httpcheck/unread.sober --emit=elf --passes -o "$W/unread" > "$W/build.unread.log" 2>&1 || { echo "httpcheck: FAIL build unread"; fail=1; }
if [ -f "$W/unread" ]; then
    for w in 1 8; do
        SOBER_WORKERS=$w "$W/unread" > "$W/unread.out" 2>&1 &
        up=$!
        p=""
        for i in $(seq 200); do
            p=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/unread.out")
            [ -n "$p" ] && break
            sleep 0.05
        done
        if [ -z "$p" ]; then
            echo "httpcheck: FAIL unread W$w: server did not start"; fail=1
        else
            r=$(timeout 60 node --experimental-strip-types --no-warnings testdata/httpcheck/unread.ts "$p" $up 64 2>&1) || { echo "httpcheck: FAIL unread W$w: $r"; fail=1; }
        fi
        kill $up 2>/dev/null
        wait $up 2>/dev/null
    done
    sum="$sum [unread W1 W8]"
fi
# 天井で死ぬ形（testdata/httpcheck/ceiling — language.md 11 節「予算と admission」）: conns: 256のServeで、① 予約を越えて32 MiBを積む接続は何も送らずに閉じられ
# ② 120,000バイトの本文を1回受けてアイドルになった接続を8本と40本の2点にして（使い捨ての32本で温めた後）、RSSの傾き ≤ Ledgerの傾き（予約 + 借り = 固定費 + 計上済みの上限の和）≤ 1.5 × RSSの傾き（W1だけ — W8の傾きはワーカーの間の配り方で揺れる）
# ③ アイドルの接続40本を残したまま、新しい接続16本が全部応答し ④ プールのdied = cut = 1 ⑤ アイドルの接続を閉じた後、温めた後からのRSSの増え ≤ 根の計上（W1だけ）。W1 / W8。
# ミュータント109（借りた分を返さない — 死んだ接続の借りが残り、後の接続が天井で死ぬ）のsrvはW1で落ちる
"$S2" build testdata/httpcheck/ceiling.sober --emit=elf --passes -o "$W/ceil" > "$W/build.ceil.log" 2>&1 || { echo "httpcheck: FAIL build ceiling"; fail=1; }
"$S2" build testdata/httpcheck/ceiling.sober --emit=elf --passes --rt-mutant=109 -o "$W/ceil.m109" > "$W/build.ceil109.log" 2>&1 || { echo "httpcheck: FAIL build ceiling mutant 109"; fail=1; }
ceilrun() {   # ceilrun <bin> <ワーカー数> [slope] → 相手の終了コード（出力は $W/ceil.log）
    SOBER_WORKERS=$2 "$1" > "$W/ceil.out" 2>&1 &
    local cp=$! p="" rc=0 i
    for i in $(seq 200); do
        p=$(sed -n "s/^ready \([0-9]*\)$/\1/p" "$W/ceil.out")
        [ -n "$p" ] && break
        sleep 0.05
    done
    if [ -z "$p" ]; then echo "server did not start" > "$W/ceil.log"; rc=1
    else timeout 60 node --experimental-strip-types --no-warnings testdata/httpcheck/ceiling.ts "$p" $cp ${3:-} > "$W/ceil.log" 2>&1 || rc=$?; fi
    kill $cp 2>/dev/null
    wait $cp 2>/dev/null
    return $rc
}
if [ -f "$W/ceil" ] && [ -f "$W/ceil.m109" ]; then
    for w in 1 8; do
        ceilrun "$W/ceil" $w $([ $w = 1 ] && echo slope) || { echo "httpcheck: FAIL ceiling W$w: $(head -c 300 "$W/ceil.log")"; fail=1; }
    done
    ceilrun "$W/ceil.m109" 1 && { echo "httpcheck: FAIL: mutant 109 (borrow never returned) was not caught by ceiling W1"; fail=1; }
    sum="$sum [ceiling W1 W8 + mutant 109]"
fi
if [ $fail = 0 ]; then
    echo "httpcheck:$sum + Delayed mutants 84〜87 caught, 88 ok fail=0"
else
    echo "httpcheck: FAIL"
fi
exit $fail
