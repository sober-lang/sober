#!/usr/bin/env bash
# async.sh <srv> [conns] [secs] [env…] — async の形（GET /delay/10 を conns 接続で保持 — 本家の async 種目・天井 = conns / 10 ms）を 1 回掛けて、
# req/s・p50 / p99・サーバの CPU µs / 要求（utime + stime）を 1 行に（report-691 3 節 — 眠りの器〔rt.sleep・期限・タイマー〕を触ったら前後を交互に）。
# 既定 4096 接続 × 8 秒（本家は 32000 — 手元の ephemeral の範囲〔32768〜60999 = 28K〕では張れない。GHA の local.sh async で）。
# サーバの port は 18000 番台（ephemeral の範囲の外 — 乱数の port が ephemeral に当たると TIME_WAIT の客側 port と衝突して起動できない: 691 で 1024 の 3 回が
# これで落ちた。local.sh と同じ穴・同じ直し）。要求の raw は $R/async-delay.raw（HttpArena の requests/ — env.sh の注）
. "$(dirname "$0")/env.sh"   # GC・R・W — env.sh の注
srv=$1; c=${2:-4096}; d=${3:-8}; shift 3 2>/dev/null || shift $#
[ -f "$R/async-delay.raw" ] || { echo "async.sh: $R/async-delay.raw not found（HttpArena の requests/async-delay.raw）" >&2; exit 2; }
port=$((18000 + RANDOM % 900))
for try in 1 2 3; do
  port=$((port + 1))
  env SOBER_WORKERS=12 "$@" taskset -c 0-11 "$srv" $port > $W/a.srv 2>&1 &
  SP=$!
  for k in $(seq 50); do grep -q ready $W/a.srv 2>/dev/null && break; sleep 0.05; done
  grep -q ready $W/a.srv 2>/dev/null && break
  kill $SP 2>/dev/null; wait $SP 2>/dev/null; SP=
done
[ -n "${SP:-}" ] || { echo "async.sh: server did not start ($(head -c 200 $W/a.srv))" >&2; exit 1; }
t0=$(awk '{ print $14 + $15 }' /proc/$SP/stat)
taskset -c 12-23 $GC http://localhost:$port --raw "$R/async-delay.raw" -p 1 -c $c -t 12 -d ${d}s > $W/a.gc 2>&1
t1=$(awk '{ print $14 + $15 }' /proc/$SP/stat 2>/dev/null || echo $t0)
kill $SP 2>/dev/null; wait $SP 2>/dev/null
resp=$(sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p' $W/a.gc)
ok=$(sed -n 's/.*2xx=\([0-9]*\).*/\1/p' $W/a.gc)
awk -v c=$c -v d=$d -v resp=${resp:-0} -v ok=${ok:-0} -v dt=$((t1 - t0)) -v hz=$(getconf CLK_TCK) '
  /^ *Latency +[0-9]/ { p50 = $3; p99 = $5 }
  END { if (resp == 0) { print "async c=" c ": no responses"; exit 1 }
        printf "async c=%d rps=%.0f p50=%s p99=%s cpu_us=%.1f non2xx=%d\n", c, resp / d, p50, p99, dt / hz * 1e6 / resp, resp - ok }' $W/a.gc
