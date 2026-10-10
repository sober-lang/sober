#!/usr/bin/env bash
# selfhost の自己不動点オラクル: Sober 製 printer（compiler/printer + compiler/tools/fmtdump）が
# 「parse → print → 再 parse」で AST を保つことを、コーパス全本で確かめる。
#
#   scripts/selfhost_fmt.sh            コーパス全本（C4 黄金の対象 = examples / testdata / std の parse できるもの + compiler/ 自身
#                                      + testdata/selfhost_fmt/*.fmt — 既存コーパスが踏まない形の parse 専用の追加）
#   scripts/selfhost_fmt.sh FILE...    指定のソースだけ
#
# 1 ファイルごとの検査（どれか 1 つでも崩れたら FAIL）:
#   (1) 不動点（Sober）: parsedump(src) と parsedump(print(src)) の AST JSON が、位置のフィールドを除いて一致
#   (2) 冪等: print(print(src)) = print(src)（バイト一致）
#   (3) 相互（Zig）: `sober parse --ast-json` でも src と print(src) の AST が位置を除いて一致（両 parser が印字を同じに読む）
# 位置の正規化は比較の側だけでやる（黄金と emitter は触らない）: tok / span / sig_end の行を落とし、行末の ',' を剥がす。
# 補間の穴の tok（文字列リテラルで代表）・span・sig_end は印字で位置が変わるので構造だけを比べる。
# 前提: zig build 済み（$STAGE1 で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

STAGE1=${STAGE1:-$PWD/src/stage1/zig-out/bin/sober}
GOLDEN=testdata/astjson
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin fmtdump "$tmp/fmtdump" || { echo "FAIL: build src/compiler/tools/fmtdump"; exit 1; }
tool_bin parsedump "$tmp/parsedump" || { echo "FAIL: build src/compiler/tools/parsedump"; exit 1; }
CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
if [ -n "${SELFHOST_TOOLCHECKED:-}" ]; then
    echo "selfhost_fmt: tool check skipped (done by scripts/gates.sh toolcheck)"
elif [ -x "$CHECK" ]; then
    (cd src/compiler && SOBER_CHECK="$CHECK" "$GATELIB_ROOT/bin/sober" check tools/fmtdump/main.sober --lean > /dev/null) || { echo "FAIL: sober check src/compiler/tools/fmtdump"; exit 1; }
    echo "selfhost_fmt: sober check src/compiler/tools/fmtdump ok"
else
    echo "selfhost_fmt: sober-check not found — check skipped"
fi

norm() { sed -E '/"span": \{/,/\}/d; /"(tok|sig_end)": -?[0-9]+,?$/d; s/,$//' "$1"; }

if [ $# -gt 0 ]; then
    files=("$@")
else
    mapfile -t files < <(frozen_list fmt)   # 凍結コーパス（主役交代 R39）
fi

fmtone() {
    local f=$1 w=${PAR_W:-$tmp}
    if ! timeout 20 "$tmp/fmtdump" < "$f" > "$w/p1.sober" 2> "$w/err" || grep -q '^fmtdump: ' "$w/p1.sober"; then
        echo "FAIL: $f: fmtdump: $(head -n 1 "$w/p1.sober")"
        echo "@@ fail"; return
    fi
    timeout 20 "$tmp/parsedump" < "$f" > "$w/a.json"
    timeout 20 "$tmp/parsedump" < "$w/p1.sober" > "$w/b.json"
    if ! diff -q <(norm "$w/a.json") <(norm "$w/b.json") > /dev/null; then
        echo "FAIL: $f: fixed point (Sober parser): $(head -n 1 "$w/b.json")"
        diff <(norm "$w/a.json") <(norm "$w/b.json") | head -n 10
        echo "@@ fail"; return
    fi
    timeout 20 "$tmp/fmtdump" < "$w/p1.sober" > "$w/p2.sober"
    if ! cmp -s "$w/p1.sober" "$w/p2.sober"; then
        echo "FAIL: $f: not idempotent (print(print(src)) != print(src))"
        diff "$w/p1.sober" "$w/p2.sober" | head -n 10
        echo "@@ fail"; return
    fi
    # sober parse は拡張子を見る（.sobi は interface）ので、.fmt は .sober の名前で写して読ませる
    cp "$f" "$w/src.sober"
    "$STAGE1" parse --ast-json "$w/src.sober" > "$w/za.json" 2> "$w/err" || { echo "FAIL: $f: sober parse (src): $(head -n 1 "$w/err")"; echo "@@ fail"; return; }
    if ! "$STAGE1" parse --ast-json "$w/p1.sober" > "$w/zb.json" 2> "$w/err"; then
        echo "FAIL: $f: sober parse rejects the printed source: $(head -n 1 "$w/err")"
        echo "@@ fail"; return
    fi
    if ! diff -q <(norm "$w/za.json") <(norm "$w/zb.json") > /dev/null; then
        echo "FAIL: $f: fixed point (Zig parser)"
        diff <(norm "$w/za.json") <(norm "$w/zb.json") | head -n 10
        echo "@@ fail"; return
    fi
    echo "@@ ok"
}

par_init "$tmp"
for f in "${files[@]}"; do par_run fmtone "$f"; done
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
ok=$(par_count ok "$tmp/all"); fail=$(par_count fail "$tmp/all")
echo "selfhost_fmt: ${#files[@]} files, ok=$ok, fail=$fail"
[ "$fail" = 0 ]
