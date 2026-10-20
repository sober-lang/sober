#!/usr/bin/env bash
# httpcheck（net 段 4c — std/http・report-670）: testdata/httpcheck/srv.sober（HttpArena の題材の端点 /baseline11・/pipeline・/delay/{ms}）を建てて立て、
# testdata/httpcheck/check.ts（HttpArena の validate.sh / validate-frag.py を模した網 — baseline の GET / POST〔Content-Length と chunked〕・乱数の入力・
# 小文字のヘッダ・断片化〔CR と LF の間・Content-Length の桁の途中・chunk の 16 進の途中・ヘッダ名の途中 + 乱数の位置 100〕・1 バイトずつの送り・
# パイプライン 16 本と混ぜた列・keep-alive の張り直し 50 × 10・HTTP/1.0・誤り〔400 / 413 / 431 / 501 / 505 — 応答の後に閉じる〕・上限ちょうど・/delay の待ち・
# /json/{count}?m= の全欄を dataset〔testdata/httpcheck/dataset.json = HttpArena の data/dataset.json・MIT〕と照合 — 本家 validate.sh の json の検査の形）を掛ける。
# 構成 = W8（net の ring — カーネルが受ければ）と W1（協調形・epoll の道）。番号は空いているものをサーバが選んで "ready <port>" で知らせる
#   scripts/httpcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
"$S2" build testdata/httpcheck/srv.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "httpcheck: FAIL build ($(head -c 200 "$W/build.log"))"; exit 1; }
fail=0
sum=
# 構成 = ワーカー数 × 符号器の作業域（SRV_WORK=1 = ServeConn の work: — ワーカー局所の lease・report-720）+ echo の大きい本文（SRV_MAXBODY = 128 KiB の
# maxBody: で check.ts --echo-big — HttpArena の 8gbit の validate の 100 KB と上限ちょうどの 128 KiB を Content-Length と chunked で・超えた 1 本〔+1 B・1 MB〕は 413。
# 上限は bench/httparena の entry と同じ値。W8 / W1 — report-848 / 849）
for cfg in "SOBER_WORKERS=8" "SOBER_WORKERS=1" "SOBER_WORKERS=8 SRV_WORK=1" "SOBER_WORKERS=1 SRV_WORK=1" "SOBER_WORKERS=8 SRV_MAXBODY=131072" "SOBER_WORKERS=1 SRV_MAXBODY=131072"; do
    env $cfg DATASET_PATH=testdata/httpcheck/dataset.json "$W/srv" 0 > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    port=
    for i in $(seq 100); do
        port=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/srv.out")
        [ -n "$port" ] && break
        sleep 0.05
    done
    if [ -z "$port" ]; then
        echo "httpcheck: FAIL $cfg — server did not start ($(head -c 200 "$W/srv.err"))"; fail=1
    else
        big=
        case "$cfg" in *SRV_MAXBODY*) big=--echo-big ;; esac
        out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/httpcheck/check.ts "$port" --frag-random 100 $big 2>&1) || { echo "httpcheck: FAIL $cfg"; echo "$out" | tail -20; fail=1; }
        sum="$sum [$cfg: $(echo "$out" | sed -n 's/^check: \([0-9]* passed, [0-9]* failed\).*/\1/p')]"
    fi
    kill $SP 2>/dev/null
    wait $SP 2>/dev/null
    SP=
done
if [ $fail = 0 ]; then
    echo "httpcheck:$sum fail=0"
else
    echo "httpcheck: FAIL"
fi
exit $fail
