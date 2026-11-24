#!/usr/bin/env bash
# stage3: stage2（scripts/stage2.sh）で、今のソースのコンパイラ自身をELFにする。配るバイナリ（.github/workflows/release.yml）はこれ。
# 木を組み、stage2でstdのL0を焼き、後段の関数キャッシュの値を焼き（stagelib.sh の stage_bake — 仮のstage3で例題をビルドしたパック）、
# stage2でcompiler/appをビルドする。手順はscripts/stagelib.shの関数で、L0までは scripts/stages.sh の stage3（固定点の左辺）と同じ。
#
#   scripts/stage3.sh [-o <出力>]           既定の出力 = out/stage3/sober
#   scripts/stage3.sh --check [-o <出力>]   続けて、できたstage3で同じ手順を踏み（L0も焼き込みもstage3が作る）、得たELFが出力とバイト一致することを確かめる
#                                          （固定点。一致しなければ終了コード1）
#   scripts/stage3.sh --release ...         ローカルのリリースの手順: 建てる前に、このコミットでリリースの組が通った記録（scripts/releaseok.sh）を確かめ、
#                                          無ければ建てない（焼き込む値はリリースの組の検査を通ったものだけ — report-cold-11）。Release CI は渡さない
#                                          （CI には記録が無い — 同じジョブで、stage3 の前にリリースの組のゲートを回して通す）
# SOBER_BAKE=0 で焼き込みの段を飛ばす。焼き込みの鍵（selfkey/key.txt）はソースと bake.list から決める（stage3 と、それが建てる stage4 で同じ —
# 仮のstage3と本番のstage3が同じ鍵を持ち、焼き込みの γ の値が当たる）
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/stagelib.sh

out=out/stage3/sober
check=0
release=0
while [ $# -gt 0 ]; do
    case "$1" in
        -o) out=$2; shift 2 ;;
        --check) check=1; shift ;;
        --release) release=1; shift ;;
        *) echo "stage3.sh: unknown argument $1" >&2; exit 2 ;;
    esac
done
if [ "$release" = 1 ]; then
    [ -z "$(git status --porcelain --untracked-files=no)" ] || { echo "stage3.sh: --release needs a clean work tree" >&2; exit 1; }
    scripts/releaseok.sh >&2 || { echo "stage3.sh: FAIL --release: no passing run of the release gates for this commit (scripts/releaseok.sh)" >&2; exit 1; }
fi
mkdir -p "$(dirname "$out")"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
unset SOBER_VERIFY
export SOBER_WORKERS=1 SOBER_HASH_SEED=0 SOBER_BUILD_CACHE=0 SOBER_CHECK_CACHE=0
S2=$(scripts/stage2.sh)
k3=$(find src/compiler src/std scripts/bake.list -type f -print0 | LC_ALL=C sort -z | xargs -0 sha256sum | { cat; echo stage3; } | sha256sum | cut -c1-64)
# <コンパイラ> で <木> から <出力> を建てる: L0 → 仮の形（焼き込みなし）→ 仮の形で焼き込み → 本番
build3() {
    local cc=$1 root=$2 w=$3 o=$4
    mkdir -p "$w"
    stage_tree "$root"
    printf '%s' "$k3" > "$root/selfkey/key.txt"
    stage_l0 "$cc" "$root" "$w"
    if [ "${SOBER_BAKE:-1}" != 0 ]; then
        stage_build "$cc" "$root" "$w/prov"
        chmod +x "$w/prov"
        stage_bake "$w/prov" "$root" "$w"
    fi
    stage_build "$cc" "$root" "$o"
    chmod +x "$o"
}
build3 "$S2" "$W/root3" "$W/w3" "$W/stage3"
cp "$W/stage3" "$out"
echo "stage3: $out ($(stat -c %s "$out") bytes)" >&2
if [ "$check" = 1 ]; then
    build3 "$W/stage3" "$W/root4" "$W/w4" "$W/stage4"
    if cmp -s "$W/stage3" "$W/stage4"; then
        echo "stage3: fixed point (stage3 builds itself to the same ELF)" >&2
    else
        echo "stage3.sh: FAIL fixed point: stage3 and the stage4 it builds differ ($(stat -c %s "$W/stage3") / $(stat -c %s "$W/stage4") bytes)" >&2
        exit 1
    fi
fi
