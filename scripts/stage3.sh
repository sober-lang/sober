#!/usr/bin/env bash
# stage3: stage2（scripts/stage2.sh）で、今のソースのコンパイラ自身をELFにする。配るバイナリ（.github/workflows/release.yml）はこれ。
# 木を組み、stage2でstdのL0を焼き、stage2でcompiler/appをビルドする。手順はscripts/stagelib.shの関数で、scripts/stages.shの
# stage3（固定点の左辺）と同じ。
#
#   scripts/stage3.sh [-o <出力>]           既定の出力 = out/stage3/sober
#   scripts/stage3.sh --check [-o <出力>]   続けて、できたstage3で同じ手順を踏み（L0もstage3が焼く）、得たELFが出力とバイト一致することを確かめる
#                                          （固定点。一致しなければ終了コード1）
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/stagelib.sh

out=out/stage3/sober
check=0
while [ $# -gt 0 ]; do
    case "$1" in
        -o) out=$2; shift 2 ;;
        --check) check=1; shift ;;
        *) echo "stage3.sh: unknown argument $1" >&2; exit 2 ;;
    esac
done
mkdir -p "$(dirname "$out")"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT

# 配る形: ステージごとの検証器は掛けない（掛けても出力は同じ）・ワーカー1・mapのハッシュの種0（出力はどちらにも依らないが、揺れの少ない形で作る）
unset SOBER_VERIFY
export SOBER_WORKERS=1 SOBER_HASH_SEED=0 SOBER_BUILD_CACHE=0 SOBER_CHECK_CACHE=0

S2=$(scripts/stage2.sh)
stage_tree "$W/root3"
stage_l0 "$S2" "$W/root3" "$W"
stage_build "$S2" "$W/root3" "$W/stage3"
chmod +x "$W/stage3"
cp "$W/stage3" "$out"
echo "stage3: $out ($(stat -c %s "$out") bytes)" >&2

if [ "$check" = 1 ]; then
    mkdir -p "$W/l4"
    stage_tree "$W/root4"
    stage_l0 "$W/stage3" "$W/root4" "$W/l4"
    stage_build "$W/stage3" "$W/root4" "$W/stage4"
    if cmp -s "$W/stage3" "$W/stage4"; then
        echo "stage3: fixed point (stage3 builds itself to the same ELF)" >&2
    else
        echo "stage3.sh: FAIL fixed point: stage3 and the stage4 it builds differ ($(stat -c %s "$W/stage3") / $(stat -c %s "$W/stage4") bytes)" >&2
        exit 1
    fi
fi
