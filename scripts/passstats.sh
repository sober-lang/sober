#!/usr/bin/env bash
# passstats（段 5 の仕上げ便 — 自己 build の時間 / RSS の帰属）: `build --emit=elf --passes` の経路を段ごとに止めて（--stop-after=<段>）、
# 各段までの累積の wall / user / peak RSS を測り、前の段との差を段の費用として出す。最後の行 = 最後まで（x86 のバックエンド込み）。
#   scripts/passstats.sh [-n 回数] [--no-verify] [<entry>]   既定 entry = compiler/app（std を写した作業木で — bench.sh の self/build と同じ形）
# 回数の中央値（既定 3）。RSS は region の高水位なので段の差 = その段が積んだ量（region を捨てない限り減らない）。--no-verify で IR の検証器を外した形も測れる
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=3
NV=""
entry=""
while [ $# -gt 0 ]; do
    case "$1" in
        -n) N=$2; shift ;;
        --no-verify) NV=--no-verify ;;
        *) entry=$1 ;;
    esac
    shift
done
S2=$(scripts/stage2.sh) || exit 1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
if [ -z "$entry" ]; then
    T=$W/tree
    mkdir -p "$T"
    cp -r src/compiler/. "$T/"
    cp -r src/std "$T/std"
    entry=app
else
    T=$ROOT
fi
med() { sort -n | awk '{a[NR]=$1} END {print a[int((NR+1)/2)]}'; }
one() { # $1 = 旗 → 「wall user rssMB」の中央値
    local i w=() u=() r=()
    for i in $(seq 1 "$N"); do
        /usr/bin/time -f "%e %U %M" -o "$W/t" "$S2" build "$entry" --emit=elf --passes $NV $1 -o "$W/out" > /dev/null 2> "$W/err" < /dev/null \
            || { echo "passstats: FAIL $1: $(head -c 200 "$W/err")" >&2; exit 1; }
        read -r a b c < "$W/t"
        w+=("$a"); u+=("$b"); r+=("$c")
    done
    echo "$(printf '%s\n' "${w[@]}" | med) $(printf '%s\n' "${u[@]}" | med) $(( $(printf '%s\n' "${r[@]}" | med) / 1024 ))"
}
echo "passstats: $entry (N=$N${NV:+, $NV}) loadavg $(cut -d' ' -f1 /proc/loadavg)"
printf '| 段まで | wall s | user s | RSS MB | 段の wall | 段の RSS |\n|---|---|---|---|---|---|\n'
pw=0; pr=0
for s in lower design sroa mem2reg gvn bce licm depth elide rlight aprune llight rtlower inline all; do
    fl=--stop-after=$s
    [ "$s" = all ] && fl=""
    read -r w u r <<< "$(cd "$T" && one "$fl")"
    printf '| %s | %s | %s | %s | %+.2f | %+d |\n' "$s" "$w" "$u" "$r" "$(echo "$w - $pw" | bc)" "$((r - pr))"
    pw=$w; pr=$r
done
