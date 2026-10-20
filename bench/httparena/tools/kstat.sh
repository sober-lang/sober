#!/usr/bin/env bash
# kstat.sh [conns] [secs] [env…] — rt の数え口（--rt-mutant=4 — report-699 / 701）を limited-conn の形（-r 10）で 1 回取って集計する。
# KA=1 で keep-alive の形（-r を外す — baseline 4096 の形: 接続の起動の配置が生涯固定される側 — report-706 / 709）。PER=1 でワーカーごとの行も出す。
# サーバは dlsrv.sober（Serve を期限 8 秒の scope で包んだ形 — 数え口は正常終了の出力の頭にしか出ないので期限で終わらせる）を
# `--rt-mutant=4` で建てたもの（通常の build の IR は不変 — 変異 4 のときだけ数え口が出る）。負荷は secs 秒（既定 6 — 期限 8 秒より前に終わる）。
# 数え口（ワーカーごと `#w <k> <16 語>` — 語の意味は src/compiler/lower/mn.sober の WK_K0 の注）を要求 / 接続あたりに割って 1 行に。
# 版どうしの比較は STAGE2=<sober2> で建てる側を差し替えて交互に（計器の分だけ遅い — req/s は比で読む）。SRV=<実行ファイル> で建てずにそれを使う。
# 列: resp・rps・conns（spawn）| run/req・steal/conn・hold（溜め → 提出 µs）・sqe/flush | startlat（spawn → 走り出し µs）|
#     rsleep/req・ring / futex の眠り（秒 / ワーカー）| cqe/enter・enter/req・sqe/req・recv/req | acc/conn（ring の ACCEPT の完了 / 接続 — accept4 直の acceptor では 0）|
#     受けの分布 = 接続の task を spawn したワーカー（ワーカー 0 の割合・spawn したワーカーの数・最大の割合 — acceptor の置き場の散り方）|
#     持ち分 = task を走り始めさせたワーカー（語 12 — 盗んだ分も含む。max / min と max/min 比 — 配置の均等さ・report-709）
. "$(dirname "$0")/env.sh"   # GC・R・W — env.sh の注
c=${1:-4096}; d=${2:-6}; shift 2 2>/dev/null
S2=${STAGE2:-$(dirname "$0")/../../../out/stage2/sober2}
srv=${SRV:-$W/ksrv}
if [ -z "${SRV:-}" ]; then
  "$S2" build "$(dirname "$0")/dlsrv.sober" --emit=elf --passes --rt-mutant=4 -o $srv > $W/k.build 2>&1 || { echo "kstat: FAIL build"; exit 1; }
fi
port=$((30000 + RANDOM % 20000))
RR=$( [ -n "${KA:-}" ] || echo "-r 10" )   # keep-alive は -r を渡さない（gcannon の既定 = 張り直さない）
env SOBER_WORKERS=12 "$@" taskset -c 0-11 timeout 25 $srv $port > $W/k.srv 2>&1 &
SP=$!
for k in $(seq 50); do grep -q ready $W/k.srv 2>/dev/null && break; sleep 0.05; done
taskset -c 12-23 $GC http://localhost:$port --raw $R/get.raw -p 1 $RR -c $c -t 12 -d ${d}s > $W/k.gc 2>&1
wait $SP
resp=$(sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p' $W/k.gc)
awk -v resp=${resp:-0} -v d=$d -v c=$c -v per="${PER:-}" '/^#w / { k = $2; for (j = 0; j < 16; j++) { v[j] += $(j + 3); w[k, j] = $(j + 3) } n++ }
  END {
    if (n == 0 || resp == 0) { print "kstat c=" c ": no data (hung or no responses — " n " workers, resp " resp ")"; exit 1 }
    conn = v[14]; fl = v[2] > 0 ? v[2] : 1; st = v[12] > 0 ? v[12] : 1; en = v[11] > 0 ? v[11] : 1; cn = conn > 0 ? conn : 1
    an = 0; amax = 0; for (k = 0; k < n; k++) { if (w[k, 14] > 0) an++; if (w[k, 14] + 0 > amax) amax = w[k, 14] + 0 }
    smax = 0; smin = -1; for (k = 0; k < n; k++) { s = w[k, 12] + 0; if (s > smax) smax = s; if (smin < 0 || s < smin) smin = s }
    printf "kstat c=%d resp=%d rps=%.0f conns=%d | run/req=%.2f steal/conn=%.2f hold=%.0fus sqe/flush=%.1f | startlat=%.1fus | rsleep/req=%.3f rsleep_s/wk=%.2f fsleep_s/wk=%.2f | cqe/enter=%.1f enter/req=%.3f sqe/req=%.2f recv/req=%.2f | acc/conn=%.2f | spawn: w0=%.0f%% workers=%d/%d max=%.0f%% | start: max=%d min=%d ratio=%.2f\n",
      c, resp, resp / d, conn, v[0] / resp, v[1] / (conn > 0 ? conn : 1), v[15] / fl / 1000, v[10] / fl, v[13] / st / 1000,
      v[3] / resp, v[4] / n / 1e9, v[6] / n / 1e9, v[7] / en, v[11] / resp, v[10] / resp, v[9] / resp, v[8] / cn,
      100 * w[0, 14] / cn, an, n, 100 * amax / cn, smax, smin, (smin > 0 ? smax / smin : 999)
    if (per != "") for (k = 0; k < n; k++) printf "  w%-2d start=%d spawn=%d steal=%d run=%d rsleep=%d fsleep=%d cqe=%d\n", k, w[k, 12], w[k, 14], w[k, 1], w[k, 0], w[k, 3], w[k, 5], w[k, 7] }' $W/k.srv
