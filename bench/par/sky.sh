#!/usr/bin/env bash
# sky.sh（段 6 の総取り — bench/par/README.md の Skynet・粒度・spawn の表）: Skynet 100 万の葉（bench/skynet）・粒度の対照（bench/skynet/gran — 100 万の葉 × 葉の仕事 L 回）・
# spawn の往復（bench/spawn — loop / wide）を Sober と Go の双子で、ワーカー数（SOBER_WORKERS / GOMAXPROCS）1 / 2 / 4 / 8 ごとに測る。
# wall は 2 列: N 回の最小と cycles 最小の回の値。EPOCHREALTIME の差（perf の起動を含む — ms 級の上乗せ・time の %e は 10 ms 刻みで粒度の小さい点に足りない）。物差し = cycles:u と instructions:u（perf stat — M:N は回る分を含む）・wall / user / sys / 最大 RSS（/usr/bin/time）。各点 N 回（Sober → Go の交互）で cycles:u の最小の回を採る。
#   bench/par/sky.sh [-n 回数] [-o 結果の TSV] [--gran "L…"] [--sky N]
# 以前の計測台の改良版: Go の双子・W4・粒度の点・spawn を足し、表を出す。規律: 物理コアごとに 1 論理 CPU の最後の 8 つに固定・
# loadavg を各行に記録・答えの一致を毎回（Sober ≡ Go）・bench と gates を同時に回さない
set -uo pipefail
cd "$(dirname "$0")/../.."
ROOT=$PWD
N=3
SKY=1000000
GL="0 200 500 1000 2000 5000 20000"
GN=1000000
res=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -o) res=$2; shift ;;
        --gran) GL=$2; shift ;;
        --sky) SKY=$2; shift ;;
        *) echo "sky.sh: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "sky.sh: perf が無い（PERF で指す）" >&2; exit 2; }
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/sky-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
CPUS=$(lscpu -p=CPU,CORE | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
echo "sky.sh: building … (cpus $CPUS)" >&2
bin/sober build -o "$W/sky-sober" bench/skynet/main.sober || exit 1
bin/sober build -o "$W/gran-sober" bench/skynet/gran/main.sober || exit 1
bin/sober build -o "$W/spawn-sober" bench/spawn/main.sober || exit 1
(cd bench && go build -o "$W/sky-go" ./skynet/go && go build -o "$W/gran-go" ./skynet/gran/go) || exit 1
: > "$res"
# run <名前> <W> <コマンド…>: N 回のうち cycles:u の最小の回を `名前 W wall user sys rssKB cycles insts load` で足す
run() {
    local name=$1 w=$2; shift 2
    local r cyc ins ld wl best="" bc="" bw=""
    for r in $(seq "$N"); do
        ld=$(cut -d' ' -f1 /proc/loadavg)
        t0=$EPOCHREALTIME
        env SOBER_WORKERS="$w" GOMAXPROCS="$w" taskset -c "$CPUS" "$PERF" stat -x, -e cycles:u,instructions:u -o "$W/p" \
            /usr/bin/time -f "%e %U %S %M" -o "$W/t" "$@" > "$W/o" 2> "$W/e" || { echo "sky.sh: FAIL $name W$w: $(head -c 200 "$W/e")" >&2; exit 1; }
        t1=$EPOCHREALTIME
        cyc=$(grep cycles "$W/p" | cut -d, -f1); ins=$(grep instructions "$W/p" | cut -d, -f1)
        echo "$name $w ans $(head -c 40 "$W/o" | tr '\n' ' ')" >> "$res.ans"
        wl=$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.4f", b - a }')
        if [ -z "$bw" ] || awk -v a="$wl" -v b="$bw" 'BEGIN { exit !(a < b) }'; then bw=$wl; fi
        if [ -z "$bc" ] || [ "$cyc" -lt "$bc" ]; then bc=$cyc; best="$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.4f", b - a }') $(cut -d' ' -f2- "$W/t") $cyc $ins $ld"; fi
    done
    echo "$name $w $best $bw" >> "$res"
}
: > "$res.ans"
for w in 1 2 4 8; do
    run sky-sober "$w" "$W/sky-sober" "$SKY"
    run sky-go "$w" "$W/sky-go" "$SKY"
done
for l in $GL; do
    for w in 1 2 4 8; do
        run "gran-L$l-sober" "$w" "$W/gran-sober" "$GN" "$l"
        run "gran-L$l-go" "$w" "$W/gran-go" "$GN" "$l"
    done
done
for m in loop wide; do
    for w in 1 2 4 8; do run "spawn-$m-sober" "$w" "$W/spawn-sober" "$m" 1000000; done
done
# 答えの一致（Sober ≡ Go — 名前の -sober / -go を落として比べる）
awk '{ k = $1; sub(/-(sober|go)$/, "", k); a = ""; for (i = 4; i <= NF; i++) a = a " " $i; if (k in A && A[k] != a) { print "sky.sh: answer mismatch " $1 " W" $2 ":" a " vs" A[k]; bad = 1 } A[k] = a } END { exit bad }' "$res.ans" || exit 1
awk -v sky="$SKY" -v gn="$GN" '
{ name = $1; w = $2; k = name " " w; wall[k] = $3; usr[k] = $4; sys[k] = $5; rss[k] = $6; cyc[k] = $7; ins[k] = $8; ld[k] = $9; mw[k] = $10; if (!(name in seen)) { seen[name] = 1; order[++n] = name } }
END {
    printf "| 題材 | W | wall 最小 s | wall s（cycles 最小の回） | user s | sys s | 最大 RSS MB | cycles:u G | 命令 G | cycles:u / task | load |\n|---|---|---|---|---|---|---|---|---|---|---|\n"
    for (i = 1; i <= n; i++) for (w = 1; w <= 8; w *= 2) { k = order[i] " " w; if (!(k in wall)) continue
        t = (order[i] ~ /^sky/) ? sky * 1.111111 : (order[i] ~ /^gran/) ? gn * 1.111111 : 1000000
        printf "| %s | %d | %.3f | %.3f | %.2f | %.2f | %.1f | %.3f | %.3f | %.0f | %s |\n", order[i], w, mw[k], wall[k], usr[k], sys[k], rss[k] / 1024, cyc[k] / 1e9, ins[k] / 1e9, cyc[k] / t, ld[k] }
}' "$res"
echo "sky.sh: raw = $res" >&2
