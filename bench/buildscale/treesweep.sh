#!/usr/bin/env bash
# 冷えたビルドのプロセスの木のRSSの合計の最大（treerss.ts）を、言語 × コア数で1回ずつ取る
# 使い方: bench/buildscale/treesweep.sh <題材のdir> "<言語…>" "<コア数…>"  （SoberはSOBER_REGION_MBを環境から受け取る）
set -u
here=$(cd "$(dirname "$0")" && pwd)
d=$1; langs=$2; cores=$3
S2=$here/../../out/stage2/sober2
T="node $here/treerss.ts"
for l in $langs; do for c in $cores; do
    case $l in
    sober) rm -rf "$d/.work/tree-sober"; ( cd "$d/sober" && env SOBER_CACHE="$d/.work/tree-sober" XDG_CACHE_HOME="$d/.work/tree-xdg" SOBER_WORKERS=$c $T "$S2" build app/main.sober --emit=elf --passes -o app.bin ) ;;
    go) GOCACHE="$d/.work/tree-go" go clean -cache 2>/dev/null; rm -rf "$d/.work/tree-go"; ( cd "$d/go" && env GOCACHE="$d/.work/tree-go" GOMAXPROCS=$c $T go build -p $c -o app.bin ./app ) ;;
    rust) rm -rf "$d/rust/target-tree"; ( cd "$d/rust" && env CARGO_TARGET_DIR=target-tree $T cargo build -q --offline --release -j $c ) ;;
    rustdebug) rm -rf "$d/rust/target-tree"; ( cd "$d/rust" && env CARGO_TARGET_DIR=target-tree $T cargo build -q --offline -j $c ) ;;
    esac 2>&1 | grep treerss | sed "s#^#$(basename "$d") $l $c #"
done; done
rm -rf "$d/rust/target-tree"
