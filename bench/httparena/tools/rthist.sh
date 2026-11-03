#!/usr/bin/env bash
# rthist.sh <srv> <形>… — 変異 4（--rt-mutant=4）の dlsrv を形ごとに 1 回走らせ、`#w` の 25〜48 列目
# （環の深さ・取った task の環での待ち・off-CPU — src/compiler/lower/mn.sober の WK_KD / WK_KA / WK_KO の注）を集計して出す。
# 形: churn（limited-conn の形 — -r 10・get / post_cl / post_chunked の巡回・4096 接続）/ ka（keep-alive — get・4096 接続）/
#     async（GET /delay/10 — $ASYNC_CONNS 接続・既定 32000）
# 環境: GCANNON（gcannon の実行ファイル — 無ければ PATH）・ARENA_REQ（requests/*.raw — 無ければ GitHub から取る）・
#       SERVER_CPUS / LOAD_CPUS（既定 = cpus.sh — local.sh と同じ割り）・C（churn / ka の接続数・既定 4096）・SECS（既定 5）
set -uo pipefail
cd "$(dirname "$0")/.."
. ./cpus.sh
GC=${GCANNON:-$(command -v gcannon || true)}
[ -x "$GC" ] || { echo "rthist.sh: gcannon not found (PATH or \$GCANNON)" >&2; exit 2; }
SRV=$1; shift
[ $# -ge 1 ] || { echo "usage: rthist.sh <srv> <churn|ka|async>…" >&2; exit 2; }
W=$(mktemp -d)
REQ=${ARENA_REQ:-$W/req}
if [ ! -f "$REQ/get.raw" ]; then
    mkdir -p "$REQ"
    for f in get.raw post_cl.raw post_chunked.raw async-delay.raw; do
        curl -fsSL -o "$REQ/$f" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/$f" || { echo "rthist.sh: cannot fetch requests/$f" >&2; exit 2; }
    done
fi
d=${SECS:-5}
for form in "$@"; do
    case $form in
        churn) c=${C:-4096}; RAW=$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw; RR="-r 10" ;;
        ka)    c=${C:-4096}; RAW=$REQ/get.raw; RR="" ;;
        async) c=${ASYNC_CONNS:-32000}; RAW=$REQ/async-delay.raw; RR="" ;;
        *) echo "rthist.sh: unknown form $form" >&2; exit 2 ;;
    esac
    port=$((18100 + RANDOM % 800))
    O=$W/srv.$form
    env SOBER_WORKERS=$nsrv taskset -c "$SERVER_CPUS" "$SRV" $port > "$O" 2>&1 &
    SP=$!
    for k in $(seq 100); do grep -q ready "$O" 2>/dev/null && break; sleep 0.05; done
    taskset -c "$LOAD_CPUS" "$GC" "http://localhost:$port" --raw "$RAW" -p 1 $RR -c $c -t $nload -d ${d}s > "$O.gc" 2>&1
    wait $SP 2>/dev/null
    req=$(sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p' "$O.gc")
    echo "=== $form  conns=$c W=$nsrv secs=$d req=${req:-0}"
    awk '/^#w / { for (j = 0; j < 8; j++) { h[j] += $(j + 27); a[j] += $(j + 35); o[j] += $(j + 43) } } END {
      tot = 0; for (j = 0; j < 8; j++) tot += h[j]
      if (!tot) { print "  (no #w lines — not a --rt-mutant=4 build?)"; exit }
      lab[0]="0"; lab[1]="1-3"; lab[2]="4-15"; lab[3]="16-63"; lab[4]="64-255"; lab[5]="256-511"; lab[6]="512-1023"; lab[7]=">=1024"
      alb[0]="<5us"; alb[1]="<22us"; alb[2]="<87us"; alb[3]="<0.35ms"; alb[4]="<1.4ms"; alb[5]="<5.6ms"; alb[6]="<22ms"; alb[7]=">=22ms"
      printf "  %-9s %-20s | %-9s %-9s %-9s\n", "depth", "picks", "t(3GHz)", "ringwait", "offcpu"
      for (j = 0; j < 8; j++) printf "  %-9s %11d %6.2f%% | %-9s %6.2f%%  %6.2f%%\n", lab[j], h[j], 100 * h[j] / tot, alb[j], 100 * a[j] / tot, 100 * o[j] / tot
      printf "  picks=%d  gate_open(>=256)=%.2f%%  cold(offcpu>=1.4ms)=%.2f%%  cold(>=5.6ms)=%.2f%%\n", tot, 100 * (h[5] + h[6] + h[7]) / tot, 100 * (o[5] + o[6] + o[7]) / tot, 100 * (o[6] + o[7]) / tot }' "$O"
done
