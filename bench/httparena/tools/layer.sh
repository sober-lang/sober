#!/usr/bin/env bash
# layer.sh <srvbin> <raw files,> [conns] [secs] [pipeline] [env…] — 要求あたりの instructions:u・user / sys の CPU µs・応答数（report-673 — 置き換えの層別）。
# サーバを perf stat の下で立て（スレッドを継承）、gcannon で負荷 → SIGTERM で止めて perf の数を読む。起動と終わりの固定費も入る（数十万要求で薄まる）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業） — env.sh の注
P=$(ls -d /nix/store/*perf-linux*/bin/perf | head -n1)
b=$1; raw=$2; c=${3:-4096}; d=${4:-5}; p=${5:-1}; rq=${RPC:-0}; shift $(( $# < 5 ? $# : 5 ))   # 引数が N 未満でも位置引数を残さない（shift N の失敗で "$@" にサーバのパスが残り env の後ろで起動を壊す — report-689）
port=$((30000 + RANDOM % 20000))
env SOBER_WORKERS=12 "$@" taskset -c 0-11 $P stat -x, -e instructions:u -o $W/layer.perf "$b" $port > $W/layer.srv 2>&1 &
PP=$!
for i in $(seq 100); do grep -q ready $W/layer.srv 2>/dev/null && break; sleep 0.05; done
out=$(taskset -c 12-23 $GC http://localhost:$port --raw "$raw" -c $c -t 12 -d ${d}s -p $p $( [ "$rq" -gt 0 ] && echo -r $rq) 2>&1)
SV=$(pgrep -P $PP -x "$(basename $b)")
read ut stt < <(awk '{ print $14, $15 }' /proc/$SV/stat)
kill -TERM $SV; wait $PP 2>/dev/null
tck=$(getconf CLK_TCK)
resp=$(echo "$out" | sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p')
rps=$(echo "$out" | sed -n 's/^ *Throughput: *//p')
awk -F, -v r=$resp -v rps="$rps" -v u=$ut -v s=$stt -v t=$tck '/instructions/ { i = $1 }
  END { printf "resp=%d (%s)  inst/req=%.0f  user µs/req=%.2f  sys µs/req=%.2f\n", r, rps, i / r, u / t * 1e6 / r, s / t * 1e6 / r }' $W/layer.perf
