#!/usr/bin/env bash
# ubfstat（UTF-8 の検査消去便 段 1 — report-478 / 479 の網の裁定）: UTF-8 の境界の畳み（compiler/lower/ubf.sober — Str の写しの境界の判定を
# 呼び手の事実から畳む）が畳めた数を、開発の口 `--ubf-stat`（1 本の経路で建て `ubf <関数> <数>` を stdout へ）で数え、scripts/ubfstat.list の
# 数とちょうど一致することを照合する。畳みは lower の束縛の事実（`v := utf8.Check(b) catch <脱出>` — lower.sober の ubBind）と展開の形に依るので、
# 形が変わると黙って効かなくなる（畳まないだけで出力は変わらない — optdiff では鳴らない）— その黙った退行の網
#   scripts/ubfstat.sh
set -uo pipefail
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0; n=0
while read -r src want; do
    case "$src" in ''|'#'*) continue ;; esac
    "$S2" build "$src" --emit=elf --passes --ubf-stat -o "$W/x" > "$W/out" 2> "$W/err" || { echo "FAIL build $src"; cat "$W/err"; fail=$((fail + 1)); continue; }
    got=$(awk '$1 == "ubf" { s += $3 } END { print s + 0 }' "$W/out")
    n=$((n + 1))
    if [ "$got" != "$want" ]; then echo "FAIL $src: folded $got (want $want)"; cat "$W/out"; fail=$((fail + 1)); fi
done < scripts/ubfstat.list
echo "ubfstat: $n sources — folded utf8 boundary checks match scripts/ubfstat.list, fail=$fail"
[ $fail = 0 ]
