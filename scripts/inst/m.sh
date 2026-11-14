#!/usr/bin/env bash
# m.sh <compiler tag> <tree tag> [loader]: 自己buildのinstructions:u（bench.shの基準 — W1・HASH_SEED 0・--emit=elf --passes）をGで印字。
# 3つ目にloaderを渡すと `parse --loader-json` だけ（loader単体の段階の目印 — report-780の主犯の段階）。出力のELFは $INST_WORK/o/elf-<S>-<T>
set -uo pipefail
R=$(cd "$(dirname "$0")/../.." && pwd)
D=${INST_WORK:-$R/out/inst}
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2> /dev/null | head -n 1)}
mkdir -p "$D/o"
cd "$D/t/$2" || exit 1
if [ "${3:-}" = loader ]; then
    SOBER_HASH_SEED=0 SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$D/o/i-$1-$2" "$D/s2/$1" parse --loader-json app > /dev/null 2>&1 || { echo "$1 $2 FAIL"; exit 1; }
else
    SOBER_HASH_SEED=0 SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$D/o/i-$1-$2" "$D/s2/$1" build app --emit=elf --passes -o "$D/o/elf-$1-$2" > /dev/null 2>&1 || { echo "$1 $2 FAIL"; exit 1; }
fi
echo "$1 $2 ${3:-build} $(awk -F, '/instructions/ { printf "%.3f", $1 / 1e9 }' "$D/o/i-$1-$2")"
