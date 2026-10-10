#!/usr/bin/env bash
# uniqfreeze（F-al の修理便① — language.md 17 節 U1〜U3）: analyzer の freeze の規則と、Lean の実行できる述語 uniqFreeze
# （lean/FeatherweightSober/UniqFreeze.lean — `sober-check --uniq-batch`）の照合。
#   ① testdata/analyzer_neg/freeze_*.sober と ifreeze_*.sober（暗黙の freeze の形 — 便② 段 2 から脱糖器が CFreeze を差す）（analyzer が拒否する負例）→
#     述語も全部拒否すること（述語の検出力）
#   ② scripts/uniqfreeze.list の代表（analyzer が受理する正例）→ 述語も全部受理すること（照合の向き analyzer ⊆ uniqFreeze）
#   GATES_ALL=1（gates --all）なら ② を examples / bench の全部（analyzer が受理するもの — 約 280 本・2 分半）に広げる
#   scripts/uniqfreeze.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$(pwd)
SOBER=${SOBER:-./bin/sober}
SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$SOBER_CHECK" ] || { echo "error: $SOBER_CHECK not found (cd lean && lake build)"; exit 1; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
: > "$W/neg.ndjson"; : > "$W/neg.names"
for s in testdata/analyzer_neg/freeze_*.sober testdata/analyzer_neg/ifreeze_*.sober; do
    "$SOBER" check "$s" --core-json > "$W/one" 2> /dev/null || { echo "FAIL $s: no core JSON"; fail=1; continue; }
    tr -d '\n' < "$W/one" >> "$W/neg.ndjson"; echo >> "$W/neg.ndjson"; echo "$s" >> "$W/neg.names"
done
if [ "${GATES_ALL:-0}" = 1 ]; then
    ls examples/*.sober bench/*/main.sober > "$W/pos.list"
else
    grep -v '^#' scripts/uniqfreeze.list | grep . > "$W/pos.list"
fi
: > "$W/pos.ndjson"; : > "$W/pos.names"
while read -r s; do
    # analyzer が受理するものだけ（拒否は analyzer_neg の側の網）
    "$SOBER" check "$s" > /dev/null 2>&1 || { [ "${GATES_ALL:-0}" = 1 ] && continue; echo "FAIL $s: analyzer / check rejects a representative"; fail=1; continue; }
    "$SOBER" check "$s" --core-json > "$W/one" 2> /dev/null || continue
    head -c 8 "$W/one" | grep -q '{"defs"' || continue
    tr -d '\n' < "$W/one" >> "$W/pos.ndjson"; echo >> "$W/pos.ndjson"; echo "$s" >> "$W/pos.names"
done < "$W/pos.list"
cat "$W/neg.ndjson" "$W/pos.ndjson" | "$SOBER_CHECK" --uniq-batch > "$W/out" || { echo "FAIL: sober-check --uniq-batch"; exit 1; }
nn=$(wc -l < "$W/neg.names"); np=$(wc -l < "$W/pos.names")
head -n "$nn" "$W/out" | paste "$W/neg.names" - | while IFS=$'\t' read -r s v; do
    case "$v" in *'"uniq":false'*) ;; *) echo "FAIL $s: the predicate accepts a negative ($v)";; esac
done > "$W/negfail"
tail -n "$np" "$W/out" | paste "$W/pos.names" - | while IFS=$'\t' read -r s v; do
    case "$v" in *'"uniq":true'*) ;; *) echo "FAIL $s: the analyzer accepts but the predicate rejects ($v)";; esac
done > "$W/posfail"
cat "$W/negfail" "$W/posfail"
[ -s "$W/negfail" ] && fail=1
[ -s "$W/posfail" ] && fail=1
echo "uniqfreeze: negatives $nn (rejected by the predicate), positives $np (accepted by both), fail=$fail"
exit $fail
