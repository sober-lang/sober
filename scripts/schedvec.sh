#!/usr/bin/env bash
# schedvec の駆動（gates — タグ lower backend）: scripts/schedvec.list の例を建てて scripts/schedvec.ts に渡す（全スケジュールの観測が 1 つ）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
bins=()
while read -r e; do
    case "$e" in ''|'#'*) continue ;; esac
    b="$W/$(basename "$e" .sober)"
    "$S2" build "$e" --emit=elf --passes -o "$b" || { echo "FAIL: build $e"; exit 1; }
    chmod +x "$b"
    bins+=("$b")
done < scripts/schedvec.list
node --experimental-strip-types scripts/schedvec.ts "${bins[@]}" --depth 12 --budget 400
