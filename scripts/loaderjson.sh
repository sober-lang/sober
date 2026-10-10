#!/usr/bin/env bash
# selfhost の第 2 黄金（loader 黄金 — testdata/loaderjson/）の照合。
#
#   scripts/loaderjson.sh            黄金との diff（scripts/loaderjson.list の各 entry を `sober parse --loader-json` に通して比較）。
#                                    加えて 2 回吐いてバイト一致を確かめる（決定性 — import 表は hash map なので特に）
#   scripts/loaderjson.sh --regen    黄金を再生成する（loader / emitter / スキーマの意図した変更後に使い、diff を見てからコミットする）
#
# 黄金の置き場: testdata/loaderjson/<entry の / を _ にした名前>.json。
# 前提: zig build 済み（$SOBER で差し替え可）。load は cwd = リポジトリルート（import パスはルート相対）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

SOBER=${SOBER:-./bin/sober}   # 黄金の生成元 = 主の sober（主役交代 R39 — それまでは Zig 版。付け替え時にバイト不変を確認済み）
GOLDEN=testdata/loaderjson
LIST=scripts/loaderjson.list
[ -x "$SOBER" ] || { echo "error: $SOBER not found (zig build)"; exit 1; }
# 差分スキップ（$GATECACHE — scripts/gates.sh が立てる）: sober バイナリ・このスクリプト・入力の木の内容ハッシュが前回の成功時と同じなら照合しない
if [ $# -eq 0 ] && cache_hit loaderjson "$SOBER" "$(stage2_key)" "$0" scripts/loaderjson.list examples testdata src/std; then
    echo "SKIP: inputs unchanged since the last pass (scripts/.gatecache/loaderjson.key)"
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

regen=0
[ "${1:-}" = "--regen" ] && regen=1

mkdir -p "$tmp/out"
fail=0
n=0
while IFS= read -r e; do
    k=$(echo "$e" | tr '/' '_')
    k=${k%.sober}
    if ! "$SOBER" parse --loader-json "$e" > "$tmp/out/$k.json" 2> "$tmp/err"; then
        echo "FAIL: $e: $(head -n 1 "$tmp/err")"
        fail=1
        continue
    fi
    "$SOBER" parse --loader-json "$e" > "$tmp/again"
    cmp -s "$tmp/out/$k.json" "$tmp/again" || { echo "FAIL: $e: output is not deterministic"; fail=1; }
    n=$((n + 1))
done < <(grep -v '^#' "$LIST" | grep -v '^[[:space:]]*$')

if [ "$regen" = 1 ]; then
    [ "$fail" = 0 ] || exit 1
    rm -rf "$GOLDEN"
    mkdir -p "$GOLDEN"
    cp -r "$tmp/out/." "$GOLDEN/"
    echo "regenerated $GOLDEN ($n entries)"
    exit 0
fi

[ -d "$GOLDEN" ] || { echo "error: $GOLDEN not found (--regen)"; exit 1; }
if ! diff -r "$tmp/out" "$GOLDEN" > "$tmp/diff"; then
    echo "FAIL: loader JSON differs from $GOLDEN"
    echo "  (loader / emitter / スキーマのどれかが変わった。意図した変更なら --regen)"
    head -n 40 "$tmp/diff"
    exit 1
fi
[ "$fail" = 0 ] || exit 1
[ $# -eq 0 ] && cache_store
echo "OK: $n entries match $GOLDEN (deterministic)"
