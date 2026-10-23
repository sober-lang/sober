#!/usr/bin/env bash
# 逐次の符号器の Go 双子の計測（段 8-4b — 線は張らない・数字は報告へ）: std/internal/deflate の TestStreamBench（Sober）と testdata/flatecheck/go/stream.go（Go の
# compress/gzip の Write + Flush）を、同じ入力（1 MiB）・同じ切り方・同じ level で交互に perf stat し、命令 / 入力バイトと cycles / 入力バイトを並べる。
# 起動の固定費は回数 0 の走りを引いて落とす。
#   testdata/flatecheck/streambench.sh [回数=20] [周=3] [level=6] [切片…=1048576 65536 4096 256]（1048576 = 1 回の emit — 一括に近い形）
set -uo pipefail
cd "$(dirname "$0")/../.."
P=$(ls -d /nix/store/*perf-linux*/bin/perf | head -n1)
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
reps=${1:-20}; rounds=${2:-3}; lv=${3:-6}; shift $(( $# < 3 ? $# : 3 ))
cuts=${*:-1048576 65536 4096 256}
S2=${STAGE2:-out/stage2/sober2}
"$S2" test std/internal/deflate --work "$W" -run TestStreamBench > /dev/null || { echo "streambench: FAIL build"; exit 1; }
(cd testdata/flatecheck/go && go build -o "$W/g" stream.go) || { echo "streambench: FAIL go build"; exit 1; }
# one <名前> <切片> <回数> → "命令 cycles"（単一コア・GOMAXPROCS=1 — Go の GC の助手も同じコアに）
one() {
    if [ "$1" = s ]; then
        DEFLATE_BENCH="$2 $3 $lv" SOBER_WORKERS=1 taskset -c 2 $P stat -x, -e instructions:u,cycles:u -o "$W/p" "$W/t" TestStreamBench > /dev/null
    else
        GOMAXPROCS=1 taskset -c 2 $P stat -x, -e instructions:u,cycles:u -o "$W/p" "$W/g" "$2" "$3" "$lv" > /dev/null
    fi
    awk -F, '/instructions/ { i = $1 } /cycles/ { c = $1 } END { print i, c }' "$W/p"
}
n=$((1 << 20))
printf "%-7s %-6s %12s %12s %10s\n" cut impl inst/byte cyc/byte out
for c in $cuts; do
    for impl in s g; do : > "$W/r.$impl"; done
    for r in $(seq "$rounds"); do
        for impl in s g; do
            read i0 c0 < <(one $impl "$c" 0)
            read i1 c1 < <(one $impl "$c" "$reps")
            echo "$(( (i1 - i0) )) $(( (c1 - c0) ))" >> "$W/r.$impl"
        done
    done
    for impl in s g; do
        o=$(if [ $impl = s ]; then DEFLATE_BENCH="$c 1 $lv" "$W/t" TestStreamBench; else "$W/g" "$c" 1 "$lv"; fi | sed -n 's/.* out //p')
        mi=$(cut -d' ' -f1 "$W/r.$impl" | sort -n | awk '{ a[NR] = $1 } END { print a[int((NR + 1) / 2)] }')
        mc=$(cut -d' ' -f2 "$W/r.$impl" | sort -n | awk '{ a[NR] = $1 } END { print a[int((NR + 1) / 2)] }')
        awk -v n=$n -v reps="$reps" -v cut="$c" -v impl=$( [ $impl = s ] && echo sober || echo go ) -v o="$o" -v mi="$mi" -v mc="$mc" \
            'BEGIN { printf "%-7s %-6s %12.2f %12.2f %10d\n", cut, impl, mi / (n * reps), mc / (n * reps), o }'
    done
done
