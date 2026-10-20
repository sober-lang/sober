#!/usr/bin/env bash
# mk.sh <commit | ディレクトリ> <tag>: 木（コミットなら git archive の src/compiler + src/std・ディレクトリなら compiler/* + std を並べた木）を
# 鎖の最後の boot で stage2 に建てる（scripts/stage2.sh と同じ 2 段 = L0 の焼き込み込み — HEAD を建てると out/stage2/sober2 とバイト一致・report-780）。
# 置き場: $INST_WORK（既定 out/inst）/s2/<tag>（stage2）・/t/<tag>（自己 build 用の木）。tag は同じ長さに揃えなくてよい（自己 build の命令はパス長に鈍い）
set -euo pipefail
src=$1; tag=$2
R=$(cd "$(dirname "$0")/../.." && pwd)
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
"$BOOT" build app/main.sober --emit=elf --passes -o "$W/s2a" && chmod +x "$W/s2a"
e=$W/l0all.sober
{ echo "package main"; echo; for d in $(find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$e"
SOBER_CACHE= SOBER_L0=0 "$W/s2a" check "$e" --split --l0-out "$W/l0" > "$W/l0.out" 2>&1 || { cat "$W/l0.out"; exit 1; }
"$BOOT" build app/main.sober --emit=elf --passes -o "$D/s2/$tag" && chmod +x "$D/s2/$tag"
cd /; rm -rf "$W"
echo "built $tag ($src)"
