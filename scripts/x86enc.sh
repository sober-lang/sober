#!/usr/bin/env bash
# x86 エンコーダ（compiler/x86）の GNU as オラクル（正規バックエンドの Sober 化 B-1b）。
# compiler/tools/x86encdump が全レジスタ × disp / imm の境界値の組み合わせを「hex<TAB>Intel 構文」で吐く → asm の列を as + objcopy で
# 一度に機械語にし、hex の連結とバイト一致を照合する。ずれたら先頭から 1 命令ずつ as に通して最初の食い違いを名指す。
# 依存: as / objcopy（x86_64.oracle.test.zig と同じ — zig build test の前提として既に PATH にある）
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
SOBER=${SOBER:-$ROOT/bin/sober}
T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
if [ -n "${SELFHOST_BIN:-}" ] && [ -x "$SELFHOST_BIN/x86encdump" ]; then
    DUMP=$SELFHOST_BIN/x86encdump
else
    (cd "$ROOT/src/compiler" && "$SOBER" build tools/x86encdump/main.sober -o "$T/x86encdump") || { echo "FAIL: build x86encdump"; exit 1; }
    DUMP=$T/x86encdump
fi
"$DUMP" > "$T/enc.tsv" || { echo "FAIL: x86encdump exited $?"; exit 1; }
n=$(wc -l < "$T/enc.tsv")
[ "$n" -gt 0 ] || { echo "FAIL: x86encdump printed nothing"; exit 1; }
asm1() { # $1 = asm の行の列のファイル → hex（1 行）
    { echo ".intel_syntax noprefix"; echo ".text"; cat "$1"; } > "$T/in.s"
    as --64 -o "$T/o.o" "$T/in.s" 2> "$T/as.err" || { cat "$T/as.err"; return 1; }
    objcopy -O binary -j .text "$T/o.o" "$T/o.bin" && od -An -v -tx1 "$T/o.bin" | tr -d ' \n'
}
cut -f2 "$T/enc.tsv" > "$T/asm.txt"
want=$(asm1 "$T/asm.txt") || { echo "FAIL: as rejected the generated asm"; exit 1; }
got=$(cut -f1 "$T/enc.tsv" | tr -d '\n')
if [ "$want" = "$got" ]; then
    echo "x86enc: $n instructions match GNU as"
    exit 0
fi
# 最初の食い違いを探す（1 命令ずつ）
while IFS=$'\t' read -r h a; do
    echo "$a" > "$T/one.txt"
    w=$(asm1 "$T/one.txt")
    if [ "$w" != "$h" ]; then
        echo "FAIL: '$a': sober $h, as $w"
        exit 1
    fi
done < "$T/enc.tsv"
echo "FAIL: concatenation differs but no single instruction does"
exit 1
