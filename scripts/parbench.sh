#!/usr/bin/env bash
# parbench（段 6 P4-6 — 並列の数字）: 1BRC の並列版（bench/1brcpar）と Skynet（bench/skynet）を Sober と Go の双子で、ワーカー数
# （SOBER_WORKERS / GOMAXPROCS）1 / 2 / 4 / 8 の曲線で測る。逐次の 1BRC（bench/1brc）を基準の列に添える（並列化の配当を逐次との連続で見る）。
#   scripts/parbench.sh [-n 回数] [--rows N] [--sky N] [-o 結果の TSV] [--load-max L]
# 規律（bench.sh と同じ）: 全部を同じ 8 コアに固定（taskset -c — 物理コアごとに 1 論理 CPU の最後の 8 つ）・各行の前に loadavg（1 分）を見て上限を越えていたら警告・
# 1 周ごとに Sober → Go の交互・回数の中央値。wall と RSS は /usr/bin/time・命令数（instructions:u）は perf で 1 回（M:N は回る分の揺れを含む）。
# 検査点の税率（相談 B の再訪材料）: Sober の並列版を --rt-mutant=3（検査点を置かない）でも建て、同じワーカー数の命令数と wall を並べる。
# 出力の一致（Sober ≡ Go ≡ 逐次）も毎回確かめる。運用の規律: bench と gates を同時に回さない
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=3
ROWS=10000000
SKY=1000000
res=""
LMAX=$(( $(nproc) / 2 ))
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        --rows) ROWS=$2; shift ;;
        --sky) SKY=$2; shift ;;
        -o) res=$2; shift ;;
        --load-max) LMAX=$2; shift ;;
        *) echo "parbench: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/par-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
# 物理コアごとに 1 論理 CPU（SMT の兄弟を避ける: 最後の 8 論理 CPU は物理 4 コア × 2 だった）の最後の 8 つ
CPUS=$(lscpu -p=CPU,CORE 2>/dev/null | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
[ -n "$CPUS" ] || CPUS=0-$(( $(nproc) - 1 ))
PIN=(taskset -c "$CPUS")
IN=$B/measurements-$ROWS.txt
if [ ! -f "$IN" ]; then
    echo "parbench: generating $IN …" >&2
    (cd bench && go run ./1brc/gen "$ROWS" "$IN.tmp") && mv "$IN.tmp" "$IN" || exit 1
fi
echo "parbench: building …" >&2
bin/sober build -o "$W/brc-sober" bench/1brc/main.sober || exit 1
bin/sober build -o "$W/brcpar-sober" bench/1brcpar/main.sober || exit 1
out/stage2/sober2 build bench/1brcpar/main.sober --emit=elf --rt-mutant=3 -o "$W/brcpar-sober-nocut" > /dev/null || exit 1
bin/sober build -o "$W/sky-sober" bench/skynet/main.sober || exit 1
out/stage2/sober2 build bench/skynet/main.sober --emit=elf --rt-mutant=3 -o "$W/sky-sober-nocut" > /dev/null || exit 1
(cd bench && go build -o "$W/brc-go" ./1brc/go && go build -o "$W/brcpar-go" ./1brcpar/go && go build -o "$W/sky-go" ./skynet/go) || exit 1
: > "$res"

# one <名前> <ワーカー数> <コマンド…>: 1 回走らせて `名前 ワーカー数 wall user rss_kb load` を結果に足す
one() {
    local name=$1 w=$2; shift 2
    local ld
    ld=$(cut -d' ' -f1 /proc/loadavg)
    if awk -v a="$ld" -v b="$LMAX" 'BEGIN { exit !(a > b) }'; then echo "parbench: warning: loadavg $ld > $LMAX ($name W$w)" >&2; fi
    env SOBER_WORKERS="$w" GOMAXPROCS="$w" /usr/bin/time -f "%e %U %M" -o "$W/t" "${PIN[@]}" "$@" > "$W/out" 2> "$W/err" || { echo "parbench: FAIL $name W$w: $*" >&2; cat "$W/err" >&2; exit 1; }
    echo "$name $w $(cat "$W/t") $ld" >> "$res"
}
# inst <名前> <ワーカー数> <コマンド…>: 命令数（instructions:u — 1 回）を `名前 ワーカー数 inst 命令数` で足す
inst() {
    local name=$1 w=$2; shift 2
    [ -n "$PERF" ] || return 0
    local i
    i=$(env SOBER_WORKERS="$w" GOMAXPROCS="$w" "${PIN[@]}" "$PERF" stat -x, -e instructions:u "$@" 2>&1 > /dev/null | cut -d, -f1)
    echo "$name $w inst $i" >> "$res"
}
# 出力の一致
"$W/brc-go" "$IN" > "$W/ref1"
for w in 1 2 4 8; do
    for b in brc-sober brcpar-sober brcpar-sober-nocut brcpar-go; do
        env SOBER_WORKERS=$w GOMAXPROCS=$w "$W/$b" "$IN" | cmp -s - "$W/ref1" || { echo "parbench: output mismatch $b W$w" >&2; exit 1; }
    done
    for b in sky-sober sky-sober-nocut; do
        env SOBER_WORKERS=$w "$W/$b" "$SKY" > /dev/null || { echo "parbench: skynet wrong answer $b W$w" >&2; exit 1; }
    done
done
for r in $(seq "$N"); do
    one brc-sober 1 "$W/brc-sober" "$IN"
    one brc-go 1 "$W/brc-go" "$IN"
    for w in 1 2 4 8; do
        one brcpar-sober "$w" "$W/brcpar-sober" "$IN"
        one brcpar-go "$w" "$W/brcpar-go" "$IN"
        one brcpar-sober-nocut "$w" "$W/brcpar-sober-nocut" "$IN"
        one sky-sober "$w" "$W/sky-sober" "$SKY"
        one sky-go "$w" "$W/sky-go" "$SKY"
        one sky-sober-nocut "$w" "$W/sky-sober-nocut" "$SKY"
    done
done
inst brc-sober 1 "$W/brc-sober" "$IN"
inst brc-go 1 "$W/brc-go" "$IN"
for w in 1 2 4 8; do
    inst brcpar-sober "$w" "$W/brcpar-sober" "$IN"
    inst brcpar-sober-nocut "$w" "$W/brcpar-sober-nocut" "$IN"
    inst brcpar-go "$w" "$W/brcpar-go" "$IN"
    inst sky-sober "$w" "$W/sky-sober" "$SKY"
    inst sky-sober-nocut "$w" "$W/sky-sober-nocut" "$SKY"
    inst sky-go "$w" "$W/sky-go" "$SKY"
done
# 表（中央値）
awk -v n="$N" '
$3 == "inst" { I[$1 " " $2] = $4; next }
{ k = $1 " " $2; c[k]++; wall[k, c[k]] = $3; rss[k] = ($5 > rss[k] ? $5 : rss[k]); keys[k] = 1 }
function med(k,   m, i, j, t, a) { m = c[k]; for (i = 1; i <= m; i++) a[i] = wall[k, i]; for (i = 1; i <= m; i++) for (j = i + 1; j <= m; j++) if (a[j] < a[i]) { t = a[i]; a[i] = a[j]; a[j] = t }; return a[int((m + 1) / 2)] }
END {
    printf "| 題材 | W | wall（中央値 s） | 最大 RSS（MB） | 命令数（G） |\n|---|---|---|---|---|\n"
    split("brc-sober brc-go brcpar-sober brcpar-sober-nocut brcpar-go sky-sober sky-sober-nocut sky-go", ns, " ")
    for (x = 1; x <= 8; x++) for (w = 1; w <= 8; w *= 2) { k = ns[x] " " w; if (k in keys) printf "| %s | %d | %.2f | %.0f | %s |\n", ns[x], w, med(k), rss[k] / 1024, (k in I) ? sprintf("%.2f", I[k] / 1e9) : "—" }
}' "$res"
echo "parbench: raw = $res" >&2
