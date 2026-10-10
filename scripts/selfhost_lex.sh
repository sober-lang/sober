#!/usr/bin/env bash
# selfhost の lexer 差分オラクル: Zig 版 `sober lex <f>` と Sober 版（compiler/lexer + compiler/tools/lexdump）の
# トークン列（1 行 1 字句: 種類 開始 終わり 綴り）を、コーパス全部で突き合わせる。
#
#   scripts/selfhost_lex.sh           examples/*.sober・testdata/**/*.sober・std/**/*.sober・compiler/**/*.sober と
#                                     字句の異常系集 testdata/selfhost_lex/*.lex（.sober でないので他のゲートのコーパスに入らない）で diff
#   scripts/selfhost_lex.sh FILE...   指定のファイルだけ
#
# Sober 版は compiler/ をモジュールルートにしてビルドする（import "lexer" = compiler/lexer）。
# lexdump は argv を取らない（io のスコープ外）ので、入力は stdin から渡す。
# 加えて Sober 版（lexdump + lexer package）が sober check に通ることを確かめる（sober-check があるとき）。
# 前提: zig build 済み（$STAGE1 で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

STAGE1=${STAGE1:-$PWD/src/stage1/zig-out/bin/sober}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin lexdump "$tmp/lexdump" || { echo "FAIL: build src/compiler/tools/lexdump"; exit 1; }
# Sober 版自体も型検査に通す（sober-check が無ければ飛ばす — 探索順は sober check と同じ）
CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
if [ -n "${SELFHOST_TOOLCHECKED:-}" ]; then
    echo "selfhost_lex: tool check skipped (done by scripts/gates.sh toolcheck)"
elif [ -x "$CHECK" ]; then
    (cd src/compiler && SOBER_CHECK="$CHECK" "$GATELIB_ROOT/bin/sober" check tools/lexdump/main.sober --lean > /dev/null) || { echo "FAIL: sober check src/compiler/tools/lexdump"; exit 1; }
    echo "selfhost_lex: sober check src/compiler/tools/lexdump ok"
else
    echo "selfhost_lex: sober-check not found — check skipped"
fi

if [ $# -gt 0 ]; then
    files=("$@")
else
    mapfile -t files < <(frozen_list lex)   # 凍結コーパス（主役交代 R39）
fi

fail=0
for f in "${files[@]}"; do
    "$STAGE1" lex "$f" > "$tmp/zig.txt"
    if ! "$tmp/lexdump" < "$f" > "$tmp/sober.txt"; then
        echo "FAIL: $f: lexdump exited with $?"
        fail=$((fail + 1))
        continue
    fi
    if ! cmp -s "$tmp/zig.txt" "$tmp/sober.txt"; then
        echo "FAIL: $f: token streams differ"
        diff "$tmp/zig.txt" "$tmp/sober.txt" | head -n 10
        fail=$((fail + 1))
    fi
done
echo "selfhost_lex: ${#files[@]} files, fail=$fail"
[ "$fail" = 0 ]
