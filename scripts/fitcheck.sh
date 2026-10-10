#!/usr/bin/env bash
# 線の跨ぎの詰め物の網（配置の便 案 A）: 詰め物の量が決まるまで、落ちない点からの窓を別の表へ本番として吐き、本表へ継ぐ
# （compiler/lower/x86.sober の xFitSplice — 窓の中で積んだ位置の記録〔ブロックの番地・飛び・ゼロ除算・外置きの辺・fx〕に継いだ位置を足す）。
# `build --fit-check`（窓を作るが詰めない）と `build --fit-off`（窓を作らない）の ELF がバイト一致すること = 継ぎの足し直しに漏れが無いこと。
# 列 = obs の列（examples/*.out・testdata/*/app.out）+ bench の 9 題材 + Web コア + 粒度の葉 + compiler 自身（compiler/ + std/ の木）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
entries=()
for f in examples/*.out; do entries+=("examples/$(basename "$f" .out).sober"); done
for f in testdata/*/app.out; do entries+=("${f%.out}"); done
for b in 1brc binarytrees fannkuch fasta revcomp knucleotide nbody spectralnorm mandelbrot jsonapi routing logagg skynet/gran; do entries+=("bench/$b/main.sober"); done
n=0; fail=0
one() { # $1 = cwd $2 = src $3 = 名前
    if ! (cd "$1" && "$S2" build "$2" --emit=elf --passes --fit-off -o "$W/off") > "$W/err" 2>&1; then
        return 0 # 受理しない entry（負例）は照合の対象外
    fi
    n=$((n + 1))
    if ! (cd "$1" && "$S2" build "$2" --emit=elf --passes --fit-check -o "$W/chk") > "$W/err" 2>&1; then
        echo "FAIL: $3: --fit-check: $(head -c 200 "$W/err")"; fail=$((fail + 1)); return 0
    fi
    cmp -s "$W/off" "$W/chk" || { echo "FAIL: $3: --fit-check ≢ --fit-off ($(cmp "$W/off" "$W/chk" 2>&1 | head -c 120))"; fail=$((fail + 1)); }
}
for src in "${entries[@]}"; do
    [ -f "$src" ] || src=$src.sober
    [ -f "$src" ] || continue
    one . "$src" "$src"
done
mkdir -p "$W/tree"; cp -r src/compiler/. "$W/tree/"; cp -r src/std "$W/tree/std"
one "$W/tree" app/main.sober src/compiler/app
echo "fitcheck: $n entries — ELF with windows spliced (no padding) ≡ ELF without windows, fail=$fail"
[ "$fail" = 0 ]
