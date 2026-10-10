#!/usr/bin/env bash
# sober-check のバッチ入力（`--batch` — lean/Main.lean）の回帰検査: バッチ出力の各行が、同じ入力の 1 件ずつの実行の stdout とバイト一致すること。
#
#   scripts/leanbatch.sh          第 3 黄金・corevec・compiler/tools・端の入力（約 400 本）
#   scripts/leanbatch.sh --all    加えて変異体（約 1,000 本 — 拒否の経路を厚く）
#
# 入力: 第 3 黄金 testdata/corejson/*.json・corevec 300 本・compiler/tools/* のコア AST（大きい入力）・scripts/checkmut.ts の変異体（拒否の多い入力）・
# 端の入力（空・壊れた JSON・改行を含む整形済みの JSON・受理しない kind）。バッチは gatelib.sh の lean_batch（ゲートが使う経路そのもの）で流す。
# 前提: lean で lake build 済み（$SOBER_CHECK で差し替え可）・zig build 済み
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}   # src/compiler/tools のコア AST は主の sober（Sober の脱糖器）が作る — 主役交代 R39
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$SOBER_CHECK" ] || { echo "error: $SOBER_CHECK not found (cd lean && lake build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/in"

cp testdata/corejson/*.json "$tmp/in/"
python3 - testdata/corevec.jsonl "$tmp/in/corevec" <<'EOF'
import json, sys
for n, line in enumerate(open(sys.argv[1])):
    with open(f"{sys.argv[2]}.{n:04d}.json", "w") as f:
        f.write(json.dumps(json.loads(line)["e"], separators=(",", ":")))
EOF
for t in src/compiler/tools/*/; do
    t=$(basename "$t")
    (cd src/compiler && "$SOBER" check "tools/$t/main.sober" --core-json) > "$tmp/in/tool_$t.json" &
done
wait
if [ "${1:-}" = "--all" ]; then
    mkdir -p "$tmp/mut"
    node scripts/checkmut.ts "$tmp/mut" testdata/corejson/*.json > /dev/null
    cp "$tmp/mut"/*.json "$tmp/in/"
fi
# 端の入力
: > "$tmp/in/edge_empty.json"
printf '{"k":"lit","n":' > "$tmp/in/edge_truncated.json"
printf 'not json at all' > "$tmp/in/edge_garbage.json"
printf '{"k":"ref","m":true}\n' > "$tmp/in/edge_unknown_kind.json"
jq . testdata/corejson/examples_fib.json > "$tmp/in/edge_pretty_fib.json"
printf '{\n  "k": "lit",\n  "n": 1\n' > "$tmp/in/edge_pretty_truncated.json"
printf '{"k":"lit","n":1} {"k":"triv"}' > "$tmp/in/edge_two_values.json"

find "$tmp/in" -type f | LC_ALL=C sort > "$tmp/list"
n=$(wc -l < "$tmp/list")
JOBS=${JOBS:-8}
lean_batch "$tmp/list" "$tmp/batch"

# 1 件ずつ（並列 — 起動のコストは並べて吸う）
par_init "$tmp"
single() {
    local f=$1 want got
    want=$("$SOBER_CHECK" < "$f" || true)
    got=$(cat "$tmp/batch/$(lean_key "$f").out" 2> /dev/null || echo "<no batch output>")
    # 判定 JSON でない出力（検査器が起動しない・落ちる）は一致していても失敗
    if [ "${want:0:1}" != "{" ]; then echo "FAIL: $(basename "$f"): the single run printed no verdict: $(printf '%s' "$want" | head -c 100)"; echo "@@ fail"; return; fi
    if [ "$want" = "$got" ]; then echo "@@ ok"; else echo "FAIL: $(basename "$f"): single $(printf '%s' "$want" | head -c 100) / batch $(printf '%s' "$got" | head -c 100)"; echo "@@ fail"; fi
}
while IFS= read -r f; do par_run single "$f"; done < "$tmp/list"
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
ok=$(par_count ok "$tmp/all")
fail=$(par_count fail "$tmp/all")
echo "leanbatch: $n inputs, ok=$ok, fail=$fail"
[ "$fail" = 0 ] && [ "$ok" = "$n" ]
