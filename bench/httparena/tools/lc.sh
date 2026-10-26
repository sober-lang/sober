#!/usr/bin/env bash
# lc.sh <srv…> — churn（limited-conn の形: -r 10・get / post_cl / post_chunked の巡回）を版どうし交互に ROUNDS 周（既定 5）回して、周ごとの行と中央値を出す
# （report-706〜709 — churn は周ごとに 0.66〜2.14M と揺れる: 5 周以上の中央値で読む）。KA=1 で keep-alive の形（-r を外して get だけ — baseline の形）。
# 列: resp（応答 / SECS 秒）・p99 / p99.9（gcannon の Latency の行 — 列 = Avg p50 p90 p99 p99.9）・
#     stall = 客側のソケットのうち SYN-SENT の割合（負荷の途中の 5 点の平均 — report-698: 何も運べずに SYN の再送を待っている接続の枠）・
#     aq = listen ソケットの accept キューの深さ（同じ 5 点の平均・最大 — ss の Recv-Q。SO_REUSEPORT の listener が複数なら和 — report-1172）・ovf = ListenOverflows の増分（/proc/net/netstat）
# 環境: C（接続数・既定 4096）・SECS（既定 5）・ROUNDS・KA・サーバの env は SRVENV（例 SRVENV="SOBER_NET=1"）。CPU 割りは他の計器と同じ（サーバ 0-11 / 負荷 12-23）
. "$(dirname "$0")/env.sh"   # GC・R・W — env.sh の注
[ $# -ge 1 ] || { echo "usage: lc.sh <srv…>" >&2; exit 2; }
c=${C:-4096}; d=${SECS:-5}
if [ -n "${KA:-}" ]; then RR=""; RAW=$R/get.raw; else RR="-r 10"; RAW=$R/get.raw,$R/post_cl.raw,$R/post_chunked.raw; fi
ovf() { awk '/^TcpExt:/ { if (!h) { for (i = 1; i <= NF; i++) n[i] = $i; h = 1 } else for (i = 1; i <= NF; i++) if (n[i] == "ListenOverflows") print $i }' /proc/net/netstat; }
for r in $(seq 1 ${ROUNDS:-5}); do for b in "$@"; do
  port=$((18100 + RANDOM % 800))   # 18000 番台（ephemeral の範囲に当たらない — async.sh の注）
  env SOBER_WORKERS=12 ${SRVENV:-} taskset -c 0-11 "$b" $port > $W/lc.srv 2>&1 & SP=$!
  for k in $(seq 100); do grep -q ready $W/lc.srv 2>/dev/null && break; sleep 0.05; done
  o0=$(ovf)
  taskset -c 12-23 $GC http://localhost:$port --raw $RAW -p 1 $RR -c $c -t 12 -d ${d}s > $W/lc.gc 2>&1 & GP=$!
  : > $W/lc.ss
  for k in 1 2 3 4 5; do
    sleep $(awk -v d=$d 'BEGIN { print d / 6 }')
    echo "$(ss -Htn state syn-sent "dport = :$port" | wc -l) $(ss -Hltn "sport = :$port" | awk '{ s += $2 } END { print s + 0 }')" >> $W/lc.ss
  done
  wait $GP
  o1=$(ovf)
  kill $SP; wait $SP 2>/dev/null
  resp=$(sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p' $W/lc.gc)
  lat=$(awk '/^ *Latency +[0-9]/ { print "p99=" $5 " p99.9=" $6; exit }' $W/lc.gc)
  st=$(awk -v c=$c '{ s += $1; q += $2; if ($2 > m) m = $2; n++ } END { printf "stall=%.1f%% aq=%.0f/%d", 100 * s / n / c, q / n, m }' $W/lc.ss)
  echo "r$r $(basename "$b") resp=${resp:-0} $lat $st ovf=$((o1 - o0))"
done; done | tee $W/lc.out
echo "--- 中央値（resp）"
awk '{ split($3, a, "="); v[$2] = v[$2] " " a[2] } END { for (b in v) { n = split(v[b], x, " "); asort(x); printf "%s median=%d (n=%d min=%d max=%d)\n", b, n % 2 ? x[(n + 1) / 2] : (x[n / 2] + x[n / 2 + 1]) / 2, n, x[1], x[n] } }' $W/lc.out
