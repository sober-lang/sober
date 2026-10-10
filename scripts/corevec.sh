#!/usr/bin/env bash
# 差分テストベクタ（testdata/corevec.jsonl）の照合。
#
#   scripts/corevec.sh            golden との diff（sober-gen を同じシードで再実行して比較）。
#                                 typecheck / 生成器 / JSON 境界の意図しない変化を検出する
#   scripts/corevec.sh --binary   加えて全数を sober-check バイナリ（gatelib の lean_batch — 1 プロセスのバッチ経路）に通し、
#                                 golden の判定と一致するか照合（プロセス境界の検査）
#   scripts/corevec.sh --regen    golden を再生成する（typecheck の意図した変更後に使い、
#                                 diff を見てからコミットする）
#
# golden の一致の後に scripts/corevec_cov.ts（被覆ラチェット + 生成器の自己検査 + 分布表 — corevec v2）を通す。
# 各行は {"e": コア AST, "g": 出自 typed | mut:<種別> | chaos, "v": 判定}（消費者は e / v だけ読む）。
#
# 前提: lean/ で `lake build sober-gen sober-check` 済み。
set -euo pipefail
cd "$(dirname "$0")/.."

GEN=lean/.lake/build/bin/sober-gen
CHECK=lean/.lake/build/bin/sober-check
GOLDEN=testdata/corevec.jsonl
SEED=42
COUNT=1000

[ -x "$GEN" ] || { echo "error: $GEN not found (cd lean && lake build sober-gen)"; exit 1; }

if [ "${1:-}" = "--regen" ]; then
    "$GEN" "$SEED" "$COUNT" > "$GOLDEN"
    echo "regenerated $GOLDEN ($(wc -l < "$GOLDEN") vectors)"
    exit 0
fi

"$GEN" "$SEED" "$COUNT" | diff - "$GOLDEN" > /dev/null || {
    echo "FAIL: sober-gen output differs from $GOLDEN"
    echo "  (typecheck / 生成器 / JSON 境界のどれかが変わった。意図した変更なら --regen)"
    exit 1
}
echo "OK: $COUNT vectors match $GOLDEN"
node scripts/corevec_cov.ts "$GOLDEN"

if [ "${1:-}" = "--binary" ]; then
    [ -x "$CHECK" ] || { echo "error: $CHECK not found (cd lean && lake build)"; exit 1; }
    source scripts/gatelib.sh
    tmp=$(mktemp -d)
    trap 'rm -rf "$tmp"' EXIT
    mkdir -p "$tmp/in"
    python3 - "$GOLDEN" "$tmp/in" "$tmp/want" <<'PY'
import json, sys
with open(sys.argv[3], "w") as w:
    for n, line in enumerate(open(sys.argv[1])):
        o = json.loads(line)
        p = f"{sys.argv[2]}/v{n:05d}.json"
        with open(p, "w") as f:
            f.write(json.dumps(o["e"], separators=(",", ":")))
        w.write(f"{p} {o['v']['ok']}\n")
PY
    cut -d' ' -f1 "$tmp/want" > "$tmp/list"
    SOBER_CHECK=$CHECK lean_batch "$tmp/list" "$tmp/out"
    n=0
    while read -r f want; do
        n=$((n + 1))
        if lean_result "$f" "$tmp/out" | grep -q '"ok":true'; then got=True; else got=False; fi
        if [ "$want" != "$got" ]; then
            echo "FAIL: vector $n: golden ok=$want but sober-check says ok=$got"
            exit 1
        fi
    done < "$tmp/want"
    echo "OK: sober-check agrees with the golden verdicts on all $n vectors"
fi
