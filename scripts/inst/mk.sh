#!/usr/bin/env bash
# mk.sh <commit | ディレクトリ> <tag>: 木（コミットなら git archive の src/compiler + src/std・ディレクトリなら compiler/* + std を並べた木）を
# ブートストラップチェーンの最後のbootでstage2にビルドする（scripts/stage2.shと同じ2ステージ = L0の焼き込み込み — HEADをビルドするとout/stage2/sober2とバイト一致・report-780）。
# 格納場所: $INST_WORK（既定out/inst）/s2/<tag>（stage2）・/t/<tag>（自己build用の木）。tagは同じ長さに揃えなくてよい（自己buildの命令はパス長に鈍い）
set -euo pipefail
src=$1; tag=$2
R=$(cd "$(dirname "$0")/../.." && pwd)
source "$R/scripts/gatelib.sh"
source "$R/scripts/stagelib.sh"
D=${INST_WORK:-$R/out/inst}
N=$(grep -v '^#' "$R/bootstrap/chain.txt" | awk 'NF' | wc -l)
BOOT=$R/out/stage2/boot/sober-boot-$((N - 1))
[ -x "$BOOT" ] || { echo "mk.sh: $BOOT が無い（scripts/stage2.sh を先に）" >&2; exit 1; }
mkdir -p "$D/s2" "$D/t"
T=$D/t/$tag
rm -rf "$T" && mkdir -p "$T"
if [ -d "$src" ]; then
    cp -r "$src/." "$T/"
else
    X=$(mktemp -d)
    git -C "$R" archive "$src" src/compiler src/std | tar -x -C "$X"
    cp -r "$X/src/compiler/." "$T/"; cp -r "$X/src/std" "$T/std"
    rm -rf "$X"
fi
W=$(mktemp -d)
cp -r "$T/." "$W/"
cd "$W"
"$BOOT" build app --emit=elf --passes -o "$W/s2a" && chmod +x "$W/s2a"
stage_l0 "$W/s2a" "$W" "$W" || exit 1
"$BOOT" build app --emit=elf --passes -o "$D/s2/$tag" && chmod +x "$D/s2/$tag"
cd /; rm -rf "$W"
echo "built $tag ($src)"
