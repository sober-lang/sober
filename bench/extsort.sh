#!/usr/bin/env bash
# extsort.sh（実証便 その 2 — 外部ソートの題材・report-612〜614）: bench/extsort の Sober / Go / Rust素 と GNU sort を同じ窓 W で交互に測る。
# seqperf に載せない理由: 引数が 2〜3 つ（入力・一時 dir・窓）・GNU sort の 4 つ目の列・run の片付け・RSS の図（入力の大きさを振る）が要る
#   bench/extsort.sh [-n 回数] [-w 窓 MiB] [--size バイト] [--chart "バイト…"] [--cpu K] [-o 結果の TSV]
# 1. 看板の表: 入力 --size（既定 1 GiB）を 4 実装 × n 回（既定 5）の交互で。cycles:u / instructions:u / task-clock / wall / 最大 RSS
#    （perf → time → 本体 — seqperf と同じ並び）。出力の md5 を毎回 `LC_ALL=C sort` の出力の md5 と照合する
# 2. RSS の図: --chart の大きさ（既定 256 MiB / 1 GiB / 4 GiB）で各実装 1 回ずつ — 「RSS は窓 × 定数で、入力の大きさに比例しない」の確認
# 規律: warm（入力はページキャッシュに載る大きさ — デバイスは測らない。WSL2 の VHD はデバイス縛りを歪める）・同じ 1 つの論理 CPU に固定・
# ワーカー 1（SOBER_WORKERS=1 — 逐次の土俵。GNU sort も --parallel=1）・gates と同時に回さない。
# cycles:u は利用者の空間だけを数える（写し・ページフォールト・ファイルの読み書きのカーネルの費用は task-clock と wall に出る — report-610 の注）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=5
WM=64
SIZE=1073741824
CHART="268435456 1073741824 4294967296"
CPU=$(( $(nproc) - 1 ))
res=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -w) WM=$2; shift ;;
        --size) SIZE=$2; shift ;;
        --chart) CHART=$2; shift ;;
        --cpu) CPU=$2; shift ;;
        -o) res=$2; shift ;;
        *) echo "extsort.sh: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "extsort.sh: perf が無い（PERF で指す）" >&2; exit 2; }
B=$ROOT/out/bench
mkdir -p "$B"
[ -n "$res" ] || res=$B/extsort-$(date +%Y%m%d-%H%M%S).tsv
res=$(realpath -m "$res")
: > "$res"
# 実行ファイル（Sober = bin/sober・Go = go build・Rust素 = bench/rust/build.sh の out/rust/release/extsort）
bin/sober build bench/extsort/main.sober -o "$B/extsort-sober" > /dev/null || { echo "extsort.sh: FAIL build sober" >&2; exit 1; }
(cd bench && go build -o "$B/extsort-go" ./extsort/go) || { echo "extsort.sh: FAIL build go" >&2; exit 1; }
[ -x out/rust/release/extsort ] || bench/rust/build.sh > /dev/null || { echo "extsort.sh: FAIL build rust" >&2; exit 1; }
# 入力（bench/extsort/gen — 決定的。一度作れば使い回す）と正解の md5（`LC_ALL=C sort` — 一度だけ）
input() {
    local f=$B/extsort-$1.txt
    if [ ! -s "$f" ]; then
        (cd bench && go run ./extsort/gen "$1" "$f.tmp") && mv "$f.tmp" "$f" || exit 1
    fi
    if [ ! -s "$f.md5" ]; then
        LC_ALL=C sort -S 1G -T "$B" "$f" | md5sum | cut -d' ' -f1 > "$f.md5"
    fi
}
TMP=$B/extsort-tmp
# one <名前> <入力の大きさ>: 一時 dir を作り直して 1 回測り、`名前 大きさ wall user rssKB cycles insts task-clock-ms` を足す
one() {
    local name=$1 n=$2 in=$B/extsort-$2.txt t0 t1
    rm -rf "$TMP"
    mkdir -p "$TMP/runs"
    local cmd
    case $name in
        sober) cmd=("$B/extsort-sober" "$in" "$TMP/runs" "$WM") ;;
        go) cmd=("$B/extsort-go" "$in" "$TMP/runs" "$WM") ;;
        rust) cmd=("$ROOT/out/rust/release/extsort" "$in" "$TMP/runs" "$WM") ;;
        gnu) cmd=(env LC_ALL=C sort -S "${WM}M" --parallel=1 -T "$TMP/runs" "$in") ;;
    esac
    t0=$EPOCHREALTIME
    SOBER_WORKERS=1 taskset -c "$CPU" "$PERF" stat -x, -e cycles:u,instructions:u,task-clock -o "$TMP/p" /usr/bin/time -f "%U %M" -o "$TMP/t" "${cmd[@]}" > "$TMP/out" 2> "$TMP/err" || { echo "extsort.sh: FAIL $name $n" >&2; head -c 300 "$TMP/err" >&2; exit 1; }
    t1=$EPOCHREALTIME
    local sum
    sum=$(md5sum < "$TMP/out" | cut -d' ' -f1)
    [ "$sum" = "$(cat "$in.md5")" ] || { echo "extsort.sh: output mismatch $name $n" >&2; exit 1; }
    echo "$name $n $(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.3f", b - a }') $(cat "$TMP/t") $(grep cycles "$TMP/p" | cut -d, -f1) $(grep instructions "$TMP/p" | cut -d, -f1) $(grep task-clock "$TMP/p" | cut -d, -f1)" >> "$res"
}
IMPLS="sober go rust gnu"
input "$SIZE"
for r in $(seq "$N"); do
    for p in $IMPLS; do
        one "$p" "$SIZE"
    done
done
for n in $CHART; do
    input "$n"
    for p in $IMPLS; do
        one "$p" "$n"
    done
done
rm -rf "$TMP"
awk -v size="$SIZE" -v ps="$IMPLS" -v wm="$WM" '
$2 == size { k = $1; if (!(k in c) || $6 < c[k]) c[k] = $6; if (!(k in w) || $3 < w[k]) w[k] = $3; tc[k, ++nt[k]] = $8; if ($5 > m[k]) m[k] = $5; i[k] = $7 }
{ rss[$1, $2] = $5; sz[$2] = 1 }
END {
    n = split(ps, p, " ")
    printf "入力 %.0f MiB・窓 %d MiB（W1・warm）\n\n", size / 1048576, wm
    printf "| 実装 | wall 最小 s | task-clock 中央 s | cycles:u 最小 G | 命令 G | 最大 RSS MB | wall 対 Rust素 |\n|---|---|---|---|---|---|---|\n"
    for (x = 1; x <= n; x++) { k = p[x]
        cnt = nt[k]; for (a = 1; a <= cnt; a++) v[a] = tc[k, a]
        for (a = 1; a <= cnt; a++) for (b = a + 1; b <= cnt; b++) if (v[b] < v[a]) { t = v[a]; v[a] = v[b]; v[b] = t }
        med = v[int((cnt + 1) / 2)]
        printf "| %s | %.3f | %.3f | %.3f | %.2f | %.1f | %.2fx |\n", k, w[k], med / 1000, c[k] / 1e9, i[k] / 1e9, m[k] / 1024, w[k] / w["rust"] }
    printf "\nRSS MB（入力の大きさごと — 1 回）\n\n| 実装 |"
    ns = 0; for (s in sz) ss[++ns] = s + 0
    for (a = 1; a <= ns; a++) for (b = a + 1; b <= ns; b++) if (ss[b] < ss[a]) { t = ss[a]; ss[a] = ss[b]; ss[b] = t }
    for (a = 1; a <= ns; a++) printf " %.0f MiB |", ss[a] / 1048576
    printf "\n|---|"; for (a = 1; a <= ns; a++) printf "---|"; printf "\n"
    for (x = 1; x <= n; x++) { printf "| %s |", p[x]; for (a = 1; a <= ns; a++) printf " %.1f |", rss[p[x], ss[a]] / 1024; printf "\n" }
}' "$res"
echo "extsort.sh: raw = $res" >&2
