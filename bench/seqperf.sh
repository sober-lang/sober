#!/usr/bin/env bash
# seqperf.sh（bench/README.md の逐次の表）: scripts/bench.sh が建てた逐次 9 題材の双子（out/bench/<題材>-sober / -go）を perf stat で測る。
# 各題材 N 回（Sober → Go の交互）で、cycles:u の最小・instructions:u（決定的）・wall の最小（EPOCHREALTIME の差 — perf の起動を含む）・最大 RSS（perf → time → 本体の順なので taskset の床なし）。
# 規模は bench.sh の既定と同じ。先に scripts/bench.sh を一度走らせて実行ファイルと入力を置くこと
#   bench/seqperf.sh [-n 回数] [-o 結果の TSV] [--cpu K] [--rust]
# --rust: Rust の双子（bench/<題材>/rust — bench/rust/build.sh が out/rust/release/ に建てる）も Sober → Go → Rust素 の交互で測り、3 実装の表にする
# bench/<題材>/rustopt/main.rs がある題材（負け組の慣用チューニング版）は
# out/rust/release/<題材>-opt も同じ輪に Rust慣 として足し、表の末尾に「Rust慣 cycles」「Sober/Rust慣」列を追加する（無い題材は "-"）
# 規律: 同じ 1 つの論理 CPU に固定（既定は bench.sh と同じ最後のコア）・bench と gates を同時に回さない・出力の一致（Sober ≡ Go）を毎回
set -uo pipefail
# map のハッシュの種を固定（既定は乱数 — 探査の長さが揺れて命令・cycles が揺れる。出力は種に依らない）
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
ROOT=$PWD
N=5
CPU=$(( $(nproc) - 1 ))
res=""
RUST=0
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -o) res=$2; shift ;;
        --cpu) CPU=$2; shift ;;
        --rust) RUST=1 ;;
        *) echo "seqperf.sh: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "seqperf.sh: perf が無い（PERF で指す）" >&2; exit 2; }
B=$ROOT/out/bench
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/seqperf-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
IN=$B/measurements-10000000.txt
FIN=$B/fasta-2500000.txt
for f in "$IN" "$FIN"; do [ -s "$f" ] || { echo "seqperf.sh: $f が無い（先に scripts/bench.sh）" >&2; exit 2; }; done
: > "$res"
one() { # one <名前> <実行ファイル> <引数>: `名前 wall user rssKB cycles insts load` を足す
    local name=$1 exe=$2 a=$3 ld t0 t1
    ld=$(cut -d' ' -f1 /proc/loadavg)
    t0=$EPOCHREALTIME
    # 逐次の表はワーカー 1（std の内側の並列を逐次の列に混ぜない。Go 側には効かない）
    SOBER_WORKERS=1 taskset -c "$CPU" "$PERF" stat -x, -e cycles:u,instructions:u -o "$W/p" /usr/bin/time -f "%U %M" -o "$W/t" "$exe" "$a" > "$W/out" 2> "$W/err" || { echo "seqperf.sh: FAIL $name" >&2; head -c 200 "$W/err" >&2; exit 1; }
    t1=$EPOCHREALTIME
    echo "$name $(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.4f", b - a }') $(cat "$W/t") $(grep cycles "$W/p" | cut -d, -f1) $(grep instructions "$W/p" | cut -d, -f1) $ld" >> "$res"
}
PS="1brc binarytrees fannkuch fasta revcomp knucleotide nbody spectralnorm mandelbrot"
arg() { case $1 in 1brc) echo "$IN" ;; binarytrees) echo 18 ;; fannkuch) echo 11 ;; fasta) echo 2500000 ;; revcomp|knucleotide) echo "$FIN" ;; nbody) echo 5000000 ;; spectralnorm) echo 2000 ;; mandelbrot) echo 4000 ;; esac; }
for r in $(seq "$N"); do
    for p in $PS; do
        a=$(arg "$p")
        one "$p-sober" "$B/$p-sober" "$a"; cp "$W/out" "$W/s"
        one "$p-go" "$B/$p-go" "$a"
        cmp -s "$W/s" "$W/out" || { echo "seqperf.sh: output mismatch $p" >&2; exit 1; }
        if [ "$RUST" = 1 ]; then
            one "$p-rust" "$ROOT/out/rust/release/$p" "$a"
            cmp -s "$W/s" "$W/out" || { echo "seqperf.sh: output mismatch rust $p" >&2; exit 1; }
            if [ -x "$ROOT/out/rust/release/$p-opt" ]; then
                one "$p-ropt" "$ROOT/out/rust/release/$p-opt" "$a"
                cmp -s "$W/s" "$W/out" || { echo "seqperf.sh: output mismatch ropt $p" >&2; exit 1; }
            fi
        fi
    done
done
if [ "$RUST" = 1 ]; then
    awk -v ps="$PS" '
    { k = $1; if (!(k in c) || $5 < c[k]) c[k] = $5; if (!(k in w) || $2 < w[k]) w[k] = $2; if ($4 > m[k]) m[k] = $4; i[k] = $6 }
    END {
        printf "| 題材 | cycles:u G Sober / Go / Rust素 | Sober/Rust素 | Go/Rust素 | 命令 G Sober / Go / Rust素 | Sober/Rust素 | wall 最小 s Sober / Go / Rust素 | 最大 RSS MB Sober / Go / Rust素 | Rust慣 cycles:u G | Sober/Rust慣 |\n|---|---|---|---|---|---|---|---|---|---|\n"
        n = split(ps, p, " ")
        for (x = 1; x <= n; x++) { s = p[x] "-sober"; g = p[x] "-go"; r = p[x] "-rust"; ro = p[x] "-ropt"
            if (ro in c) { roc = sprintf("%.3f", c[ro] / 1e9); ror = sprintf("%.2fx", c[s] / c[ro]) } else { roc = "-"; ror = "-" }
            printf "| %s | %.3f / %.3f / %.3f | %.2fx | %.2fx | %.2f / %.2f / %.2f | %.2fx | %.3f / %.3f / %.3f | %.1f / %.1f / %.1f | %s | %s |\n", p[x], c[s] / 1e9, c[g] / 1e9, c[r] / 1e9, c[s] / c[r], c[g] / c[r], i[s] / 1e9, i[g] / 1e9, i[r] / 1e9, i[s] / i[r], w[s], w[g], w[r], m[s] / 1024, m[g] / 1024, m[r] / 1024, roc, ror }
    }' "$res"
    echo "seqperf.sh: raw = $res" >&2
    exit 0
fi
awk -v ps="$PS" '
{ k = $1; if (!(k in c) || $5 < c[k]) c[k] = $5; if (!(k in w) || $2 < w[k]) w[k] = $2; if ($4 > m[k]) m[k] = $4; i[k] = $6 }
END {
    printf "| 題材 | wall 最小 s Sober / Go | 比 | cycles:u G Sober / Go | 比 | 命令 G Sober / Go | 比 | 最大 RSS MB Sober / Go | 比 |\n|---|---|---|---|---|---|---|---|---|\n"
    n = split(ps, p, " ")
    for (x = 1; x <= n; x++) { s = p[x] "-sober"; g = p[x] "-go"
        printf "| %s | %.3f / %.3f | %.2fx | %.2f / %.2f | %.2fx | %.2f / %.2f | %.2fx | %.1f / %.1f | %.2fx |\n", p[x], w[s], w[g], w[s] / w[g], c[s] / 1e9, c[g] / 1e9, c[s] / c[g], i[s] / 1e9, i[g] / 1e9, i[s] / i[g], m[s] / 1024, m[g] / 1024, m[s] / m[g] }
}' "$res"
echo "seqperf.sh: raw = $res" >&2
