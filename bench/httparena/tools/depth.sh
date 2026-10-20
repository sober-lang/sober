#!/usr/bin/env bash
# depth.sh <srvbin> <raw> [conns] [secs] [p] [env…] — サーバの中の溜まりの深さ（report-683）。layer4.sh と同じ形で perf の事象を取りながら、
# 負荷の途中で ss を 3 回（1 秒おき・CPU 23 で）サンプリングし、接続ごとの未読（Recv-Q > 0）の数を数える:
#   srvq = サーバ側のソケットで未読の接続（カーネルに届いたが rt がまだ読んでいない — epoll / 9c の「起こし待ち・取り込み待ち」）
#   cliq = クライアント側のソケットで未読の接続（応答が届いたが gcannon がまだ読んでいない — 負荷の側の溜まり）
#   little = gcannon の平均遅延 × req/s。**溜まりの推定には使えない**（report-683 — 閉じたループなら ≈ 接続数のはずが、epoll の 4096 接続では
#            700〜1,700 しか出ない: gcannon の遅延は周期の一部しか覆わない場面がある）— 参考の列。溜まりは srvq（直接の観測）で読む
#   zero / top25 = 公平さ（report-684）: ss -tni の接続ごとの segs_out を 1 秒あけて 2 回取り、その 1 秒に応答（送りのセグメント）が 0 だった接続の
#            割合と、上位 25% の接続が運んだ割合。公平な一巡なら zero ≈ 0%・top25 ≈ 25〜35%（epoll の道は 4096 接続で zero ≈ 70%・top25 ≈ 98% —
#            一部の接続だけを温かく回し残りを飢えさせる。その速さは小さい作業集合から来る）
# 注: main の ring は multishot でカーネルが先に PBUF へ写すので、rt の中に溜まる分は srvq に出ない（≈ 接続数 − srvq − cliq）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業） — env.sh の注
P=$(ls -d /nix/store/*perf-linux*/bin/perf | head -n1)
EV=${EV:-cycles:u,instructions:u}
b=$1; raw=$2; c=${3:-4096}; d=${4:-5}; p=${5:-1}; shift $(( $# < 5 ? $# : 5 ))   # 引数が N 未満でも位置引数を残さない（shift N の失敗で "$@" にサーバのパスが残り env の後ろで起動を壊す — report-689）
port=$((30000 + RANDOM % 20000))
env SOBER_WORKERS=12 "$@" taskset -c 0-11 $P stat -x, -e $EV -o $W/d.perf "$b" $port > $W/d.srv 2>&1 &
PP=$!
for i in $(seq 100); do grep -q ready $W/d.srv 2>/dev/null && break; sleep 0.05; done
taskset -c 12-23 $GC http://localhost:$port --raw "$raw" -c $c -t 12 -d ${d}s -p $p > $W/d.gc 2>&1 &
GP=$!
sleep 1.5
: > $W/d.ss
for k in 1 2 3; do
  taskset -c 23 ss -tniH state established "( sport = :$port )" > $W/d.si$k
  awk '/^[0-9]/ { print }' $W/d.si$k > $W/d.ss$k
  awk -v k=$k '{ n++; if ($1 > 0) q++ } END { printf "srv %d %d %d\n", k, n, q }' $W/d.ss$k >> $W/d.ss
  taskset -c 23 ss -tnH state established "( dport = :$port )" | awk -v k=$k '{ n++; if ($1 > 0) q++ } END { printf "cli %d %d %d\n", k, n, q }' >> $W/d.ss
  sleep 1
done
wait $GP
# 公平さ: 1 回目と 2 回目（1 秒あけ）の接続ごとの segs_out の差
fair=$(awk 'FNR == 1 { f++ } /^[0-9]/ { peer = $4; next } { if (match($0, /segs_out:[0-9]+/)) { v = substr($0, RSTART + 9, RLENGTH - 9); if (f == 1) a[peer] = v; else if (peer in a) d[++n] = v - a[peer] } }
  END { z = 0; t = 0; for (i = 1; i <= n; i++) { if (d[i] == 0) z++; t += d[i] } asort(d); top = 0; for (i = n; i > n - int(n / 4); i--) top += d[i]
        printf "zero=%.0f%% top25=%.0f%%", 100 * z / n, 100 * top / (t > 0 ? t : 1) }' $W/d.si1 $W/d.si2)
SV=$(pgrep -P $PP -x "$(basename $b)")
kill -TERM $SV; wait $PP 2>/dev/null
out=$(cat $W/d.gc)
resp=$(echo "$out" | sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p')
rps=$(echo "$out" | sed -n 's/^ *Throughput: *\([0-9.]*\)\([KM]*\) req\/s.*/\1 \2/p' | awk '{ m = $2 == "M" ? 1e6 : $2 == "K" ? 1e3 : 1; printf "%.0f", $1 * m }')
lat=$(echo "$out" | awk '$1 == "Latency" { v = $2; m = v ~ /ms$/ ? 1e-3 : v ~ /us$/ ? 1e-6 : 1; sub(/[a-z]+$/, "", v); print v * m; exit }')
p99=$(echo "$out" | awk '$1 == "Latency" { print $5; exit }')
awk -F, -v r=$resp -v rps=$rps -v lat=$lat -v p99=$p99 -v p=$p -v fair="$fair" -v ssf=$W/d.ss '$3 ~ /:u/ { n = $3; sub(/:u/, "", n); v[n] = $1 }
  END {
    while ((getline l < ssf) > 0) { split(l, f, " "); if (f[1] == "srv") { sq += f[4]; sn++ } else { cq += f[4] } }
    sq /= sn; cq /= sn; lit = lat * rps / p
    printf "rps=%.0fK cyc/req=%.0f lat=%.2fms p99=%s little=%.0f srvq=%.0f cliq=%.0f %s\n", rps / 1e3, v["cycles"] / r, lat * 1e3, p99, lit, sq, cq, fair }' $W/d.perf
