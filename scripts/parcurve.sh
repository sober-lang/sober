#!/usr/bin/env bash
# parcurve（段 6 P5-5 —「劣化曲線」・language.md 11 節「予算と admission」）: 天井を振ったときの劣化の形を Sober と Go の双子で。
# Sober = 根の天井 SOBER_BUDGET_MB（入場できない子は逐次へ縮退 — 値は不変・並列が細る）・Go = GOMEMLIMIT（ソフトな上限 — 届くと GC が回り続ける）。
# 題材 = 1BRC 並列（bench/1brcpar — 64 区間 × task.Map）と Skynet（bench/skynet — 100 万の葉）。ワーカー数は固定（既定 8）。
# 各点で wall・user・最大 RSS（/usr/bin/time）と Sober の `#par admit` の縮退の数（SOBER_PAR_STATS=1 の 1 回）を、Sober → Go の交互で N 回・最小を表に。
#   scripts/parcurve.sh [-n 回数] [-w ワーカー数] [--rows N] [--sky N] [-o 結果の TSV] [--load-max L]
# 規律（bench.sh / parbench.sh と同じ）: 同じ 8 コアに固定（物理コアごとに 1 論理 CPU）・loadavg の警告・出力の一致を毎回・bench と gates を同時に回さない
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=3
WK=8
ROWS=10000000
SKY=1000000
res=""
LMAX=$(( $(nproc) / 2 ))
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        -w) WK=$2; shift ;;
        --rows) ROWS=$2; shift ;;
        --sky) SKY=$2; shift ;;
        -o) res=$2; shift ;;
        --load-max) LMAX=$2; shift ;;
        *) echo "parcurve: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/parcurve-$(date +%Y%m%d-%H%M%S).tsv
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
CPUS=$(lscpu -p=CPU,CORE 2>/dev/null | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
[ -n "$CPUS" ] || CPUS=0-$(( $(nproc) - 1 ))
PIN=(taskset -c "$CPUS")
IN=$B/measurements-$ROWS.txt
if [ ! -f "$IN" ]; then
    echo "parcurve: generating $IN …" >&2
    (cd bench && go run ./1brc/gen "$ROWS" "$IN.tmp") && mv "$IN.tmp" "$IN" || exit 1
fi
echo "parcurve: building …" >&2
bin/sober build -o "$W/brcpar-sober" bench/1brcpar/main.sober || exit 1
bin/sober build -o "$W/sky-sober" bench/skynet/main.sober || exit 1
(cd bench && go build -o "$W/brcpar-go" ./1brcpar/go && go build -o "$W/sky-go" ./skynet/go) || exit 1
: > "$res"
# 天井の点（MiB — "" = 既定〔Sober = プロセスの天井・Go = 上限なし〕）
PTS=(0 1 4 16 64 256 "")
"$W/brcpar-go" "$IN" > "$W/ref1"
"$W/sky-go" "$SKY" > "$W/ref2"

# one <名前> <天井> <環境…> -- <コマンド…>: 1 回走らせて `名前 天井 wall user rss_kb load` を結果に足す（出力は参照と照合）
one() {
    local name=$1 cap=$2 ref=$3; shift 3
    local envs=()
    while [ "$1" != -- ]; do envs+=("$1"); shift; done
    shift
    local ld
    ld=$(cut -d' ' -f1 /proc/loadavg)
    if awk -v a="$ld" -v b="$LMAX" 'BEGIN { exit !(a > b) }'; then echo "parcurve: warning: loadavg $ld > $LMAX ($name $cap)" >&2; fi
    env SOBER_WORKERS="$WK" GOMAXPROCS="$WK" "${envs[@]}" /usr/bin/time -f "%e %U %M" -o "$W/t" timeout 120 "${PIN[@]}" "$@" > "$W/out" 2> "$W/err" || { echo "parcurve: FAIL $name $cap: $*" >&2; head -3 "$W/err" >&2; echo "$name ${cap:-dflt} fail - - $ld" >> "$res"; return 0; }
    cmp -s "$W/out" "$ref" || { echo "parcurve: output mismatch $name $cap" >&2; exit 1; }
    echo "$name ${cap:-dflt} $(cat "$W/t") $ld" >> "$res"
}
# inl <名前> <天井> <コマンド…>: 縮退の数（`#par admit inline=` — 1 回）を `名前 天井 inline 数` で足す
inl() {
    local name=$1 cap=$2; shift 2
    local i
    i=$(env SOBER_WORKERS="$WK" SOBER_PAR_STATS=1 ${cap:+SOBER_BUDGET_MB=$cap} "${PIN[@]}" "$@" 2>&1 > /dev/null | grep '^#par admit' | tr ' ' '\n' | sed -n 's/^inline=//p')
    echo "$name ${cap:-dflt} inline ${i:-0}" >> "$res"
}
for r in $(seq "$N"); do
    for c in "${PTS[@]}"; do
        one brcpar-sober "$c" "$W/ref1" ${c:+SOBER_BUDGET_MB=$c} -- "$W/brcpar-sober" "$IN"
        one brcpar-go "$c" "$W/ref1" ${c:+GOMEMLIMIT=${c}MiB} -- "$W/brcpar-go" "$IN"
        one sky-sober "$c" "$W/ref2" ${c:+SOBER_BUDGET_MB=$c} -- "$W/sky-sober" "$SKY"
        one sky-go "$c" "$W/ref2" ${c:+GOMEMLIMIT=${c}MiB} -- "$W/sky-go" "$SKY"
    done
done
for c in "${PTS[@]}"; do
    inl brcpar-sober "$c" "$W/brcpar-sober" "$IN"
    inl sky-sober "$c" "$W/sky-sober" "$SKY"
done
# 表（最小 — 交互の最小: 同居の負荷の揺れを削る）
awk -v wk="$WK" '
$3 == "inline" { I[$1 " " $2] = $4; next }
$3 == "fail" { F[$1 " " $2]++; keys[$1 " " $2] = 1; next }
{ k = $1 " " $2; if (!(k in wall) || $3 < wall[k]) { wall[k] = $3; usr[k] = $4 }; rss[k] = ($5 > rss[k] ? $5 : rss[k]); keys[k] = 1 }
END {
    printf "| 題材 | 天井（MiB） | wall（最小 s） | user（s） | 最大 RSS（MB） | 縮退の数 |\n|---|---|---|---|---|---|\n"
    split("brcpar-sober brcpar-go sky-sober sky-go", ns, " ")
    split("0 1 4 16 64 256 dflt", cs, " ")
    for (x = 1; x <= 4; x++) for (y = 1; y <= 7; y++) { k = ns[x] " " cs[y]; if (k in keys) { if (k in wall) printf "| %s W%d | %s | %.2f | %.2f | %.0f | %s |\n", ns[x], wk, cs[y], wall[k], usr[k], rss[k] / 1024, (k in I) ? I[k] : "—"; else printf "| %s W%d | %s | 120 s で打ち切り（%d 回） | — | — | — |\n", ns[x], wk, cs[y], F[k] } }
}' "$res"
echo "parcurve: raw = $res" >&2
