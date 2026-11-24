#!/usr/bin/env bash
# 既定の上限（SOBER_REGION_MBなし）でSoberのbuildが通る最大の関数の数を二分探索する
# 使い方: bench/buildscale/bisect.sh <作業のdir> <通る関数の数> <落ちる関数の数> [刻み=250]
# 各点で gen.ts --lang sober で題材を作り、冷えた置き場でbuildする。行・終了コード・最後の行（panicの文面）を印字する
set -u
here=$(cd "$(dirname "$0")" && pwd)
work=$1; lo=$2; hi=$3; step=${4:-250}
S2=$here/../../out/stage2/sober2
try() {
    local n=$1 d=$work/b$1
    rm -rf "$d"
    node "$here/gen.ts" --fns "$n" --lang sober --out "$d" >/dev/null
    local lines; lines=$(node -e "console.log(require('$d/stats.json').lines.sober)")
    ( cd "$d/sober" && /usr/bin/time -f "%e %M" -o "$d/time.txt" env SOBER_CACHE="$d/cache" XDG_CACHE_HOME="$d/xdg" "$S2" build app/main.sober --emit=elf --passes -o app.bin > "$d/log.txt" 2>&1 )
    local code=$?
    echo "bisect: fns=$n lines=$lines exit=$code time_rss=$(tail -1 "$d/time.txt") $(grep -m1 panic "$d/log.txt")"
    rm -rf "$d"
    return $code
}
while [ $((hi - lo)) -gt "$step" ]; do
    mid=$(( (lo + hi) / 2 ))
    if try $mid; then lo=$mid; else hi=$mid; fi
done
echo "bisect: pass at fns=$lo, fail at fns=$hi"
