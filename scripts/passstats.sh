#!/usr/bin/env bash
# passstats（段階5の仕上げのタスク — 自己buildの時間 / RSSの内訳）: `build --emit=elf --passes` の経路をステージごとに止めて（--stop-after=<ステージ>）、
# 各ステージまでの累積のwall / user / peak RSS を測り、前のステージとの差をステージの費用として出す。最後の行 = 最後まで（x86のバックエンド込み）。
#   scripts/passstats.sh [-n 回数] [--no-verify] [<entry>]   既定entry = compiler/app（stdをコピーした作業木で — bench.shのself/buildと同じ形）
# 回数の中央値（既定3）。RSSはregionの高水位なのでステージの差 = そのステージが積んだ量（regionを捨てない限り減らない）。--no-verifyでIRの検証器を外した形も測れる
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
