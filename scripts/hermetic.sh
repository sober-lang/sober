#!/usr/bin/env bash
# hermeticity 検査（V5-1 C1 — ブートストラップ固定点の前提）。
#
#   scripts/hermetic.sh [対象…]    stage1（凍結した Zig 版 — ELF を比べる。gates の hermetic_zig は凍結コーパスだけを渡す）
#   scripts/hermetic.sh --stage2   主の sober の stage2（out/stage2/sober2 — Sober の正規バックエンドの ELF（--emit=elf --passes = bin/sober の既定の形 — B-4）と
#                                  .ll を比べる。gates の hermetic）
#
# 出力が入力（ソースとコンパイラ）だけで決まることを確かめる。stage2 ≡ stage3 の固定点
# （docs/design-dev.md selfhost 項）は、コンパイラの出力に path・時刻・環境が混ざると偶然にしか成り立たない。
# 対象: examples/*.out を持つ全例 + 複数 package の testdata（pkgdemo / errpkg / iface / minic）。
# 観測: ELF（sober build）と脱糖後のコア JSON（sober check --core-json）をバイト比較。
#
# 基準 A = リポのルートで相対 path。比べる相手:
#   B  同じ条件でもう 1 回（非決定性）
#   C  別の深さの path へソース木とコンパイラ自身をコピーし、絶対 path で渡す。
#      環境も変える: env -i・TZ・LANG・umask・HOME・SOURCE_DATE_EPOCH
# 対象外: stage1 バイナリ自身（Zig のデバッグ情報が絶対 path を持つ — 固定点の対象ではない）、診断メッセージ
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
EMIT=()
EMIT2=()
if [ "${1:-}" = "--stage2" ]; then
    SOBER=$(scripts/stage2.sh) || exit 1   # 主の sober の本体（bin/sober はラッパーで写せない — 写すのは stage2 の ELF）
    EMIT=(--emit=ll)
    EMIT2=(--emit=elf --passes)
else
    SOBER=$(realpath "${STAGE1:-src/stage1/zig-out/bin/sober}")   # 検査する stage（既定は stage1）
fi

W=$(mktemp -d)
C=$W/elsewhere/deeper/tree
mkdir -p "$C/bin"
cp -r examples testdata "$C/"
cp "$SOBER" "$C/bin/sober-copy"

targets=$(for f in examples/*.out; do echo "examples/$(basename "$f" .out).sober"; done)
targets="$targets testdata/pkgdemo/app testdata/errpkg/app testdata/minic/app testdata/jsonpkg/app"
# testdata/iface は stage1 専用の .sobi の題材（iface / --pkg は Zig にしか無い）で、byte の段 S4 の前の言語のまま凍結してある（[]int のバイト列）—
# 主の sober（--stage2）の対象からは外す（2026-10-01）
[ "${1:-}" = "--stage2" ] || targets="$targets testdata/iface/app"
# stage1 の列は対象を引数で絞れる（gates の hermetic_zig は凍結コーパスだけを渡す — obs の名前: examples/X.sober → X、testdata/D/app → そのまま。G1）
if [ "${1:-}" != "--stage2" ] && [ $# -gt 0 ]; then
    targets=$(for a in "$@"; do case "$a" in */*) echo "$a" ;; *) echo "examples/$a.sober" ;; esac; done)
fi

run_a() { (cd "$ROOT" && "$SOBER" "$@"); }
run_c() {
    (cd "$C" && umask 077 && env -i PATH=/usr/bin:/bin HOME=/nonexistent TZ=Pacific/Chatham LANG=ja_JP.UTF-8 \
        LC_ALL=C SOURCE_DATE_EPOCH=0 "$C/bin/sober-copy" "$@")
}

fail=0
n=0
for t in $targets; do
    k=$(echo "$t" | tr '/' '_')
    run_a build "$t" "${EMIT[@]}" -o "$W/$k.a" > /dev/null 2>&1 || { echo "BUILD FAIL $t"; fail=1; continue; }
    if [ -n "${EMIT2[*]}" ]; then
        run_a build "$t" "${EMIT2[@]}" -o "$W/$k.ea" > /dev/null 2>&1 || { echo "BUILD FAIL (ELF) $t"; fail=1; continue; }
        run_a build "$t" "${EMIT2[@]}" -o "$W/$k.eb" > /dev/null 2>&1
        run_c build "$C/$t" "${EMIT2[@]}" -o "$W/$k.ec" > /dev/null 2>&1
        cmp -s "$W/$k.ea" "$W/$k.eb" || { echo "NONDETERMINISTIC ELF (stage2) $t"; fail=1; }
        cmp -s "$W/$k.ea" "$W/$k.ec" || { echo "ENV/PATH-DEPENDENT ELF (stage2) $t"; fail=1; }
    fi
    run_a build "$t" "${EMIT[@]}" -o "$W/$k.b" > /dev/null 2>&1
    run_c build "$C/$t" "${EMIT[@]}" -o "$W/$k.c" > /dev/null 2>&1
    cmp -s "$W/$k.a" "$W/$k.b" || { echo "NONDETERMINISTIC ELF $t"; fail=1; }
    cmp -s "$W/$k.a" "$W/$k.c" || { echo "ENV/PATH-DEPENDENT ELF $t"; fail=1; }
    # コア JSON: 失敗する例（check の断片外）も「同じ失敗」なら一致とみなす — 出力と終了状態の両方を比べる
    run_a check "$t" --core-json > "$W/$k.ja" 2> /dev/null; ea=$?
    run_c check "$C/$t" --core-json > "$W/$k.jc" 2> /dev/null; ec=$?
    { [ "$ea" = "$ec" ] && cmp -s "$W/$k.ja" "$W/$k.jc"; } || { echo "ENV/PATH-DEPENDENT CORE JSON $t"; fail=1; }
    n=$((n + 1))
done
rm -r "$W"
echo "hermetic: $n targets, fail=$fail"
exit $fail
