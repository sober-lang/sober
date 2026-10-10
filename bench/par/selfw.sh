#!/usr/bin/env bash
# selfw.sh（段 6 の総取り — bench/par/README.md の自己 check / build の表）: compiler/ + std を写した木で
# `sober check app/main.sober` と `sober build app/main.sober --emit=elf --passes` をワーカー数 1 / 2 / 4 / 8 で測る（stage2 = 今のコンパイラ）。
# 各点 N 回（W の順に交互）の wall の最小・その回の user と最大 RSS。命令数（instructions:u — 決定的）は W1 で 1 回。判定 / ELF は W ごとに一致を確かめる
#   bench/par/selfw.sh [-n 回数] [-o 結果の TSV]
# 規律: 物理コアごとに 1 論理 CPU の最後の 8 つに固定・bench と gates を同時に回さない
set -uo pipefail
cd "$(dirname "$0")/../.."
ROOT=$PWD
N=2
res=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -o) res=$2; shift ;;
        *) echo "selfw.sh: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
S2=$(scripts/stage2.sh) || exit 1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$ROOT/out/bench/selfw-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
CPUS=$(lscpu -p=CPU,CORE | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
T=$W/tree
mkdir -p "$T"
cp -r src/compiler/. "$T/"
cp -r src/std "$T/std"
: > "$res"
# one <check|build> <W>: 1 回走らせて `種 W wall user rssKB load` を足す（出力は W1 の参照と照合）
one() {
    local k=$1 w=$2 ld t0 t1
    ld=$(cut -d' ' -f1 /proc/loadavg)
    t0=$EPOCHREALTIME
    if [ "$k" = check ]; then
        (cd "$T" && env SOBER_WORKERS="$w" /usr/bin/time -f "%U %M" -o "$W/t" taskset -c "$CPUS" "$S2" check app/main.sober > "$W/out" 2>&1) || { echo "selfw.sh: FAIL check W$w" >&2; exit 1; }
    else
        (cd "$T" && env SOBER_WORKERS="$w" /usr/bin/time -f "%U %M" -o "$W/t" taskset -c "$CPUS" "$S2" build app/main.sober --emit=elf --passes -o "$W/out" > "$W/log" 2>&1) || { echo "selfw.sh: FAIL build W$w" >&2; exit 1; }
    fi
    t1=$EPOCHREALTIME
    if [ -f "$W/ref-$k" ]; then cmp -s "$W/out" "$W/ref-$k" || { echo "selfw.sh: $k W$w differs from W1" >&2; exit 1; }; else cp "$W/out" "$W/ref-$k"; fi
    echo "$k $w $(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.3f", b - a }') $(cat "$W/t") $ld" >> "$res"
}
for r in $(seq "$N"); do
    for k in check build; do
        for w in 1 2 4 8; do one "$k" "$w"; done
    done
done
for k in check build; do
    if [ "$k" = check ]; then args=(check app/main.sober); else args=(build app/main.sober --emit=elf --passes -o "$W/x"); fi
    i=$(cd "$T" && SOBER_WORKERS=1 taskset -c "$CPUS" "$PERF" stat -x, -e instructions:u "$S2" "${args[@]}" 2>&1 > /dev/null | grep instructions | cut -d, -f1)
    echo "$k 1 inst $i" >> "$res"
done
awk '
$3 == "inst" { I[$1] = $4; next }
{ k = $1 " " $2; if (!(k in wall) || $3 < wall[k]) { wall[k] = $3; usr[k] = $4; rss[k] = $5 } }
END {
    printf "| | W1 | W2 | W4 | W8 | 命令（W1） | peak RSS W1 / W8 |\n|---|---|---|---|---|---|---|\n"
    split("check build", ks, " ")
    for (x = 1; x <= 2; x++) { k = ks[x]; printf "| %s | %.1f s | %.1f | %.1f | %.1f | %.1f G | %.0f / %.0f MB |\n", k, wall[k " 1"], wall[k " 2"], wall[k " 4"], wall[k " 8"], I[k] / 1e9, rss[k " 1"] / 1024, rss[k " 8"] / 1024 }
    printf "\n| | user W1 | W2 | W4 | W8 |\n|---|---|---|---|---|\n"
    for (x = 1; x <= 2; x++) { k = ks[x]; printf "| %s | %.1f | %.1f | %.1f | %.1f |\n", k, usr[k " 1"], usr[k " 2"], usr[k " 4"], usr[k " 8"] }
}' "$res"
echo "selfw.sh: raw = $res" >&2
