#!/usr/bin/env bash
# 実験3の計測: 題材を mainのツリーのbin/soberでbuildし、instructions:u を数える（決定的なので1回）
# 使い方: run.sh <出力ディレクトリ> [build の追加の引数…]
set -uo pipefail
OUT=$1; shift
HERE=$(cd "$(dirname "$0")" && pwd)
SOBER=/home/kr9ly/projects/sober/bin/sober
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
mkdir -p "$OUT"
for s in f4 f16 f32 nest2; do
  for f in ${FORMS:-json straight walk base}; do
    exe="$OUT/$s-$f"
    if ! "$SOBER" build "$HERE/$s/$f/main.sober" -o "$exe" "$@" > "$OUT/$s-$f.build.log" 2>&1; then
      echo "$s $f BUILD-FAIL"; continue
    fi
    SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$OUT/$s-$f.inst" "$exe" > "$OUT/$s-$f.out" 2>&1
    inst=$(awk -F, '/instructions/ { print $1 }' "$OUT/$s-$f.inst")
    echo "$s $f $inst $(tail -n 1 "$OUT/$s-$f.out") $(stat -c %s "$exe")"
  done
done
