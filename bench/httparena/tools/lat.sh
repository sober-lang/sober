#!/usr/bin/env bash
# lat.sh <srv> [conns=1024] [rate=500000] [secs=10] [env…] — latency-500k-8cpu の形（サーバ = CPU 0-7〔4 コア + SMT〕・SOBER_WORKERS=8・zrk のレート固定・
# GET /baseline11?a=1&b=2）で、温め 5 秒の後の secs 秒だけ perf stat -p（:u の事象 — EV で上書き）と /proc の utime / stime を要求あたりに（report-1049〜1053）。
# 既定の事象は記憶の取り込みの元（L2 / 同 CCX の L3 / DRAM）と L2 TLB の外れ — 1 要求が冷えた行をいくつ触るかの物差し（report-1053 4 節: 接続数を 256 / 1024 / 4096 で振ると
# L2 の外から取る行は一定のまま取り先が DRAM へ移る）。zrk = $ZRK（local.sh が $W/zrk に落とす v2.3.0）。負荷 = CPU 12-23。版どうしは交互に
Z=${ZRK:?set ZRK to the zrk binary (local.sh downloads it to its work dir)}
P=$(ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n1); P=${P:-perf}
srv=$1; c=${2:-1024}; rate=${3:-500000}; secs=${4:-10}; shift $(( $# < 4 ? $# : 4 ))
EV=${EV:-cycles:u,instructions:u,ls_dmnd_fills_from_sys.local_l2:u,ls_dmnd_fills_from_sys.local_ccx:u,ls_dmnd_fills_from_sys.dram_io_all:u,ls_l1_d_tlb_miss.all_l2_miss:u}
W=${HTTP_WORK:-$(mktemp -d)}; mkdir -p "$W"
for try in 1 2 3 4 5; do
    port=$((30000 + RANDOM % 20000))
    env SOBER_WORKERS=8 GOMAXPROCS=8 "$@" taskset -c 0-7 "$srv" $port $((port + 1)) > "$W/lat.srv" 2>&1 &
    pid=$!; sleep 0.5; kill -0 $pid 2>/dev/null && break
done
url="http://localhost:$port/baseline11?a=1&b=2"
taskset -c 12-23 "$Z" -t 12 -c $c -d 5s -R $rate --format json --plain "$url" > /dev/null 2>&1
read u0 s0 < <(awk '{ print $14, $15 }' /proc/$pid/stat)
$P stat -x, -p $pid -e "$EV" -o "$W/lat.perf" -- sleep $secs &
pp=$!
out=$(taskset -c 12-23 "$Z" -t 12 -c $c -d ${secs}s -R $rate --format json --plain "$url" 2>/dev/null)
wait $pp
read u1 s1 < <(awk '{ print $14, $15 }' /proc/$pid/stat)
hwm=$(awk '/VmHWM/ { print $2 }' /proc/$pid/status)
kill -TERM $pid; wait $pid 2>/dev/null
req=$(echo "$out" | grep -oE "\"requests\": *[0-9]+" | head -1 | grep -oE "[0-9]+$")
awk -F, -v r=$req -v u=$((u1 - u0)) -v s=$((s1 - s0)) -v t=$(getconf CLK_TCK) -v c=$c -v hwm=$hwm '$3 ~ /:u$/ { v[$3] = $1 } END {
  printf "c=%d req=%d hwm=%dMB user=%.2f sys=%.2f µs/req", c, r, hwm / 1024, u / t * 1e6 / r, s / t * 1e6 / r
  for (k in v) { n = k; sub(/:u$/, "", n); sub(/^ls_dmnd_fills_from_sys\./, "fill.", n); printf "  %s=%.0f", n, v[k] / r }
  printf "\n" }' "$W/lat.perf"
