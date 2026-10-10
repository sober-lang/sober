#!/usr/bin/env bash
# btpar.sh（段 6 の総取り — bench/par/README.md の binary-trees の表）: binary-trees の逐次（bench/binarytrees）と並列（bench/binarytreespar — 深さごとに 1 つの子 /
# Go は深さごとに goroutine）を Sober と Go の双子で、ワーカー数（SOBER_WORKERS / GOMAXPROCS）1 / 2 / 4 / 8 ごとに測る。並列アロケーションの競合の計器
# （Go = 並列のミューテータ × GC・Sober = task ごとの region で確保の共有点なし）。物差しと規律は bench/par/sky.sh と同じ（cycles:u の最小の回・物理コアごとに 1 論理 CPU）
#   bench/par/btpar.sh [-n 回数] [-o 結果の TSV] [--depth N（既定 21 = benchmarks game の値）]
set -uo pipefail
cd "$(dirname "$0")/../.."
ROOT=$PWD
N=3
DEP=21
res=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -o) res=$2; shift ;;
        --depth) DEP=$2; shift ;;
        *) echo "btpar.sh: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "btpar.sh: perf が無い（PERF で指す）" >&2; exit 2; }
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/btpar-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
CPUS=$(lscpu -p=CPU,CORE | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
echo "btpar.sh: building … (cpus $CPUS)" >&2
bin/sober build -o "$W/bt-sober" bench/binarytrees/main.sober || exit 1
bin/sober build -o "$W/btpar-sober" bench/binarytreespar/main.sober || exit 1
(cd bench && go build -o "$W/bt-go" ./binarytrees/go && go build -o "$W/btpar-go" ./binarytreespar/go) || exit 1
: > "$res"
# run <名前> <W> <コマンド…>: N 回のうち cycles:u の最小の回を `名前 W wall user sys rssKB cycles insts load` で足す
run() {
    local name=$1 w=$2; shift 2
    local r cyc ins ld best="" bc=""
    for r in $(seq "$N"); do
        ld=$(cut -d' ' -f1 /proc/loadavg)
        t0=$EPOCHREALTIME
        env SOBER_WORKERS="$w" GOMAXPROCS="$w" taskset -c "$CPUS" "$PERF" stat -x, -e cycles:u,instructions:u -o "$W/p" \
            /usr/bin/time -f "%e %U %S %M" -o "$W/t" "$@" > "$W/o" 2> "$W/e" || { echo "btpar.sh: FAIL $name W$w: $(head -c 200 "$W/e")" >&2; exit 1; }
        t1=$EPOCHREALTIME
        cyc=$(grep cycles "$W/p" | cut -d, -f1); ins=$(grep instructions "$W/p" | cut -d, -f1)
        echo "$name $w ans $(head -c 40 "$W/o" | tr '\n' ' ')" >> "$res.ans"
        if [ -z "$bc" ] || [ "$cyc" -lt "$bc" ]; then bc=$cyc; best="$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.4f", b - a }') $(cut -d' ' -f2- "$W/t") $cyc $ins $ld"; fi
    done
    echo "$name $w $best" >> "$res"
}
"$W/bt-go" "$DEP" > "$W/ref"
: > "$res.ans"
run bt-sober 1 "$W/bt-sober" "$DEP"
run bt-go 1 "$W/bt-go" "$DEP"
for w in 1 2 4 8; do
    run btpar-sober "$w" "$W/btpar-sober" "$DEP"
    cmp -s "$W/o" "$W/ref" || { echo "btpar.sh: output mismatch btpar-sober W$w" >&2; exit 1; }
    run btpar-go "$w" "$W/btpar-go" "$DEP"
    cmp -s "$W/o" "$W/ref" || { echo "btpar.sh: output mismatch btpar-go W$w" >&2; exit 1; }
done
awk '
{ k = $1 " " $2; wall[k] = $3; usr[k] = $4; sys[k] = $5; rss[k] = $6; cyc[k] = $7; ins[k] = $8; ld[k] = $9; if (!($1 in seen)) { seen[$1] = 1; order[++n] = $1 } }
END {
    printf "| 題材 | W | wall s | user s | sys s | 最大 RSS MB | cycles:u G | 命令 G | load |\n|---|---|---|---|---|---|---|---|---|\n"
    for (i = 1; i <= n; i++) for (w = 1; w <= 8; w *= 2) { k = order[i] " " w; if (k in wall) printf "| %s | %d | %.3f | %.2f | %.2f | %.1f | %.2f | %.2f | %s |\n", order[i], w, wall[k], usr[k], sys[k], rss[k] / 1024, cyc[k] / 1e9, ins[k] / 1e9, ld[k] }
}' "$res"
echo "btpar.sh: raw = $res" >&2
