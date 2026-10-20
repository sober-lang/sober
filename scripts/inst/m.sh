#!/usr/bin/env bash
# m.sh <compiler tag> <tree tag> [loader]: 自己 build の instructions:u（bench.sh の物差し — W1・HASH_SEED 0・--emit=elf --passes）を G で印字。
# 3 つ目に loader を渡すと `parse --loader-json` だけ（loader 単体の段の目印 — report-780 の主犯の段）。出力の ELF は $INST_WORK/o/elf-<S>-<T>
set -uo pipefail
R=$(cd "$(dirname "$0")/../.." && pwd)
D=${INST_WORK:-$R/out/inst}
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2> /dev/null | head -n 1)}
mkdir -p "$D/o"
cd "$D/t/$2" || exit 1
if [ "${3:-}" = loader ]; then
    SOBER_HASH_SEED=0 SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$D/o/i-$1-$2" "$D/s2/$1" parse --loader-json app/main.sober > /dev/null 2>&1 || { echo "$1 $2 FAIL"; exit 1; }
else
    SOBER_HASH_SEED=0 SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$D/o/i-$1-$2" "$D/s2/$1" build app/main.sober --emit=elf --passes -o "$D/o/elf-$1-$2" > /dev/null 2>&1 || { echo "$1 $2 FAIL"; exit 1; }
fi
echo "$1 $2 ${3:-build} $(awk -F, '/instructions/ { printf "%.3f", $1 / 1e9 }' "$D/o/i-$1-$2")"
