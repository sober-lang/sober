#!/usr/bin/env bash
# idiomgap（イディオムギャップ零化レーンの計器 — docs/bench.md「イディオムギャップ」）: 同じ題材を
#   (a) 回避術の形（mut out 引数など — 速いが書き味を曲げた形）
#   (b) 素直な形（作って返す等 — 書きたい形）
# の 2 本で書いた双子を建て、命令数と cycles（perf stat — 交互に N 回・中央値）と出力の一致を見て、ギャップ = (b) / (a) − 1 を出す。
# 機構（宛先構築〔RVO〕・チャネル限定透過 …）を入れるたびに 0 へ近づくのを追う。命令数を正に（cycles・wall は時間帯で揺れる）。
#   scripts/idiomgap.sh [--quick] [-n 回数]
# perf は環境変数 PERF（既定 `perf`）。双子の表は下の PAIRS（名前 (a) の entry (b) の entry 引数）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=5
FA=2500000
JN=200000
while [ $# -gt 0 ]; do
    case "$1" in
        --quick) FA=250000; JN=20000; N=3 ;;
        -n) N=$2; shift ;;
        *) echo "idiomgap: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
FIN=$B/fasta-$FA.txt
if [ ! -s "$FIN" ]; then
    echo "idiomgap: generating $FIN …" >&2
    (cd bench && go run ./fasta/go "$FA" > "$FIN.tmp") && mv "$FIN.tmp" "$FIN" || exit 1
fi
JIN=$B/jsondecode-$JN.json
if [ ! -s "$JIN" ]; then
    echo "idiomgap: generating $JIN …" >&2
    (cd bench && go run ./jsondecode/gen "$JN" > "$JIN.tmp") && mv "$JIN.tmp" "$JIN" || exit 1
fi
# 名前 (a) (b) 引数
PAIRS="knucleotide/map-return bench/knucleotide/mutout/main.sober bench/knucleotide/main.sober $FIN
jsondecode/struct-return bench/jsondecode/mutout/main.sober bench/jsondecode/main.sober $JIN
serializer/pieces-d2 bench/jsonencode/builder/main.sober bench/jsonencode/pieces/main.sober 2
serializer/pieces-d4 bench/jsonencode/builder/main.sober bench/jsonencode/pieces/main.sober 4
serializer/pieces-d6 bench/jsonencode/builder/main.sober bench/jsonencode/pieces/main.sober 6
append/alternate bench/growalt/seq/main.sober bench/growalt/main.sober 2000000
map/alternate bench/growalt/map/seq/main.sober bench/growalt/map/main.sober 200000
concat/loop bench/concat/bytes/main.sober bench/concat/main.sober 2000000
io/stream bench/iostream/accum/main.sober bench/iostream/main.sober 20000000"

echo "| 双子 | (a) 命令 G | (b) 命令 G | 命令のギャップ | (a) cycles G | (b) cycles G | cycles のギャップ |"
echo "|---|---|---|---|---|---|---|"
set -- $PAIRS
while [ $# -ge 4 ]; do
    name=$1 ea=$2 eb=$3 arg=$4
    shift 4
    ./bin/sober build "$ea" -o "$W/a" > /dev/null || exit 1
    ./bin/sober build "$eb" -o "$W/b" > /dev/null || exit 1
    "$W/a" "$arg" > "$W/a.out" && "$W/b" "$arg" > "$W/b.out" || { echo "idiomgap: FAIL $name: run" >&2; exit 1; }
    cmp -s "$W/a.out" "$W/b.out" || { echo "idiomgap: FAIL $name: (a) and (b) outputs differ" >&2; exit 1; }
    : > "$W/r"
    for i in $(seq 1 "$N"); do
        for v in a b; do
            "$PERF" stat -x, -e instructions:u,cycles:u -o "$W/p" "$W/$v" "$arg" > /dev/null || exit 1
            echo "$v $(awk -F, '/instructions/ { i = $1 } /cycles/ { c = $1 } END { print i, c }' "$W/p")" >> "$W/r"
        done
    done
    awk -v name="$name" '
    { n[$1]++; ins[$1, n[$1]] = $2; cyc[$1, n[$1]] = $3 }
    function med(a, v, c,   i, j, t, x) { for (i = 1; i <= c; i++) x[i] = a[v, i]; for (i = 2; i <= c; i++) { t = x[i]; for (j = i - 1; j >= 1 && x[j] > t; j--) x[j + 1] = x[j]; x[j + 1] = t } return x[int((c + 1) / 2)] }
    END {
        ia = med(ins, "a", n["a"]); ib = med(ins, "b", n["b"]); ca = med(cyc, "a", n["a"]); cb = med(cyc, "b", n["b"])
        printf "| %s | %.3f | %.3f | %+.2f%% | %.2f | %.2f | %+.1f%% |\n", name, ia / 1e9, ib / 1e9, (ib / ia - 1) * 100, ca / 1e9, cb / 1e9, (cb / ca - 1) * 100
    }' "$W/r"
done
