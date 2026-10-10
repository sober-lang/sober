#!/usr/bin/env bash
# selfhost の parser 差分オラクル: Sober 版（compiler/parser + compiler/ast + compiler/tools/parsedump）の AST JSON を
# Zig 版（stage1）の `sober parse --ast-json` の出力とバイト比較する（主役交代 R39 までは C4 黄金 testdata/astjson/ と比べていた —
# 黄金の生成元が Sober に替わったので、Zig ≡ Sober は凍結コーパスで stage1 を直接呼んで見る）。
#
#   scripts/selfhost_parse.sh            到達リスト（scripts/frozen/parse.list — 凍結）の全ファイル。リスト内 fail=0 がゲート
#   scripts/selfhost_parse.sh --all      黄金の全ファイルを回し、一致 / 不一致を一覧する（リストの外は情報のみ）
#   scripts/selfhost_parse.sh FILE...    指定のソースだけ
#
# リストは 1 行 1 ソース（リポジトリルート相対、# はコメント）。段が進むたびに足す。
# 黄金から除外したソース（EXCLUDED.txt）は Sober 版も拒否することを確かめる。
# 加えて compiler/ 全体（lexdump と parsedump）が sober check に通ることを確かめる（sober-check があるとき）。
# 前提: zig build 済み（$STAGE1 で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

STAGE1=${STAGE1:-$PWD/src/stage1/zig-out/bin/sober}
LIST=scripts/frozen/parse.list   # 凍結コーパス（主役交代 R39）
GOLDEN=testdata/astjson
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin parsedump "$tmp/parsedump" || { echo "FAIL: build src/compiler/tools/parsedump"; exit 1; }
CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
if [ -n "${SELFHOST_TOOLCHECKED:-}" ]; then
    echo "selfhost_parse: tool check skipped (done by scripts/gates.sh toolcheck)"
elif [ -x "$CHECK" ]; then
    for entry in tools/lexdump/main.sober tools/parsedump/main.sober; do
        (cd src/compiler && SOBER_CHECK="$CHECK" "$GATELIB_ROOT/bin/sober" check "$entry" --lean > /dev/null) || { echo "FAIL: sober check src/compiler/$entry"; exit 1; }
    done
    echo "selfhost_parse: sober check src/compiler/tools/{lexdump,parsedump} ok"
else
    echo "selfhost_parse: sober-check not found — check skipped"
fi

all=0
if [ "${1:-}" = "--all" ]; then
    all=1
    mapfile -t files < <(find "$GOLDEN" -name '*.json' | LC_ALL=C sort | sed "s|^$GOLDEN/||; s|\.json\$|.sober|")
elif [ $# -gt 0 ]; then
    files=("$@")
else
    mapfile -t files < <(grep -v '^#' "$LIST" | grep -v '^[[:space:]]*$')
fi

fail=0
ok=0
for f in "${files[@]}"; do
    g="$tmp/zig.json"
    "$STAGE1" parse --ast-json "$f" > "$g" 2> /dev/null || { echo "FAIL: $f: Zig rejects it"; fail=$((fail + 1)); continue; }
    # 綴りの正規化（決定 16 の α 改名と同じ「同一入力の照合を保つ」扱い）: `string(b)` の合成名は 2026-10-02 に utf8.FromBytes → utf8.Parse
    # （裁定 N1）。凍結した Zig 版は旧名を合成するので、比べる前に Zig 側の出力を新名へ揃える
    sed -i 's/"field": "FromBytes"/"field": "Parse"/g' "$g"
    if ! timeout 20 "$tmp/parsedump" < "$f" > "$tmp/out.json" 2> "$tmp/err"; then
        echo "FAIL: $f: parsedump failed or timed out"
        fail=$((fail + 1))
    elif ! cmp -s "$tmp/out.json" "$g"; then
        echo "FAIL: $f: $(head -n 1 "$tmp/out.json")"
        [ "$all" = 1 ] || diff "$tmp/out.json" "$g" | head -n 10
        fail=$((fail + 1))
    else
        ok=$((ok + 1))
        [ "$all" = 1 ] && echo "ok: $f"
    fi
done
# 黄金から除外したソース（Zig 版の cst_to_ast が拒否するもの — testdata/astjson/EXCLUDED.txt）は Sober 版も拒否すること
if [ $# -eq 0 ] || [ "$all" = 1 ]; then
    while IFS=$'\t' read -r f _; do
        [ -n "$f" ] || continue
        got=$(timeout 20 "$tmp/parsedump" < "$f" 2>&1 || true)
        if [ "$got" != "parsedump: parse error" ]; then
            echo "FAIL: $f: excluded from the golden but the Sober parser did not reject it"
            fail=$((fail + 1))
        fi
    done < <(grep -v "^#" scripts/frozen/parse-excluded.list)
fi
echo "selfhost_parse: ${#files[@]} files, ok=$ok, fail=$fail"
[ "$all" = 1 ] || [ "$fail" = 0 ]
