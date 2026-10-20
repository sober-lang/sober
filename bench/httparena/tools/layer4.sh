#!/usr/bin/env bash
# layer4.sh <srvbin> <raw> [conns] [secs] [pipeline] [env…] — layer.sh の perf の事象版（偵察 675〜678 の写し・report-680）: EV（既定 = cycles / instructions /
# cache-misses / dTLB-load-misses — すべて :u）を要求あたりで出し、gcannon の p99 も添える。EV_ALL=1 なら EV の全事象を名前つきで
# （例 EV=cycles:u,ls_dmnd_fills_from_sys.dram_io_all:u,dTLB-load-misses:u EV_ALL=1 — DRAM からのフィル / 要求 = 公平な一巡の冷えの物差し・report-684）。W12（サーバ CPU 0-11・負荷 12-23）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業） — env.sh の注
P=$(ls -d /nix/store/*perf-linux*/bin/perf | head -n1)
EV=${EV:-cycles:u,instructions:u,cache-misses:u,dTLB-load-misses:u}
b=$1; raw=$2; c=${3:-4096}; d=${4:-4}; p=${5:-1}; shift $(( $# < 5 ? $# : 5 ))   # 引数が N 未満でも位置引数を残さない（shift N の失敗で "$@" にサーバのパスが残り env の後ろで起動を壊す — report-689）
port=$((30000 + RANDOM % 20000))
env SOBER_WORKERS=12 "$@" taskset -c 0-11 $P stat -x, -e $EV -o $W/l4.perf "$b" $port > $W/l4.srv 2>&1 &
PP=$!
for i in $(seq 100); do grep -q ready $W/l4.srv 2>/dev/null && break; sleep 0.05; done
out=$(taskset -c 12-23 $GC http://localhost:$port --raw "$raw" -c $c -t 12 -d ${d}s -p $p 2>&1)
SV=$(pgrep -P $PP -x "$(basename $b)")
kill -TERM $SV; wait $PP 2>/dev/null
resp=$(echo "$out" | sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p')
p99=$(echo "$out" | awk '$1 == "Latency" { print $5; exit }')
if [ -n "${EV_ALL:-}" ]; then
  # EV の全事象を要求あたりでそのまま（フィル元の事象等 — ls_*_fills_from_sys.* の頭は落とす・report-684 / 686 の l4fill の取り込み）
  awk -F, -v r=$resp -v p99="$p99" '$1 ~ /^[0-9.]+$/ { n = $3; sub(/^ls_dmnd_fills_from_sys\./, "dmnd.", n); sub(/^ls_any_fills_from_sys\./, "any.", n); printf "%s=%.2f ", n, $1 / r } END { printf "resp=%d p99=%s\n", r, p99 }' $W/l4.perf
  exit 0
fi
awk -F, -v r=$resp -v p99="$p99" '$3 ~ /:u/ { n = $3; sub(/:u/, "", n); v[n] = $1 }
  END { printf "resp=%d cyc/req=%.0f inst/req=%.0f cmiss/req=%.1f dtlb/req=%.2f p99=%s\n", r, v["cycles"] / r, v["instructions"] / r, v["cache-misses"] / r, v["dTLB-load-misses"] / r, p99 }' $W/l4.perf
