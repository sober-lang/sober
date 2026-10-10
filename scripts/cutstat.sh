#!/usr/bin/env bash
# cutstat（検査点の間引き — compiler/lower/cancel.sober cutThin・language.md 11 節「キャンセル」）:
# ① 間引きの表（`sober build --cut-stat` — 利用者のループの頭ごとに 本体の重み B・N・形〔count / every〕）を testdata/cutstat/*.cut の黄金と照合
#   （同時に表の行ごとに N × B ≤ K = 1024 — 約束の内側の検査）
# ② 間引いた検査点がまだ切ること: examples/par_cancel_spin（切られなければ終わらない純な子 2 つ — 帰納変数のあるループと無いループ）がワーカー 1 / 2 / 8 で時間内に
#   終わり、出力が黄金どおり
# ③ 変異の自己検査（1 件で足りる）: 3 = 検査点なし・9 = 数え口が 0 に戻らない → ② が終わらない（timeout）。10 = 間引かない → ① の表が食い違う
#   scripts/cutstat.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = --regen ] && regen=1
fail=0
CASES=(examples/par_cancel_spin.sober examples/par_cancel.sober examples/par_cancel_map.sober bench/skynet/gran/main.sober bench/par/failfast/main.sober)
gold() { echo "testdata/cutstat/$(echo "$1" | sed 's|/main.sober$||; s|\.sober$||; s|/|_|g').cut"; }
for e in "${CASES[@]}"; do
    "$S2" build "$e" --emit=elf --cut-stat -o "$W/t" > /dev/null 2>&1 || { echo "FAIL: cut-stat $e"; fail=$((fail + 1)); continue; }
    g=$(gold "$e")
    if [ $regen = 1 ]; then cp "$W/t" "$g"; continue; fi
    cmp -s "$W/t" "$g" || { echo "FAIL: $e: the thinning table differs from $g"; diff "$g" "$W/t" | head -8; fail=$((fail + 1)); }
    awk '{ b = substr($3, 3); n = substr($4, 3); if (b > 0 && n * b > 1024) { print "FAIL: N × B > K: " $0; bad = 1 } } END { exit bad }' "$W/t" || fail=$((fail + 1))
done
[ $regen = 1 ] && { echo "cutstat: regenerated ${#CASES[@]} tables"; exit 0; }
SP=examples/par_cancel_spin.sober
"$S2" build "$SP" --emit=elf -o "$W/spin" > /dev/null 2>&1 || { echo "FAIL: build $SP"; fail=$((fail + 1)); }
chmod +x "$W/spin"
for w in 1 2 8; do
    SOBER_WORKERS=$w timeout 60 "$W/spin" > "$W/out" 2> /dev/null < /dev/null
    ec=$?
    [ $ec = 0 ] && cmp -s "$W/out" examples/par_cancel_spin.out || { echo "FAIL: $SP W$w (exit $ec) — the thinned checkpoints did not cut"; fail=$((fail + 1)); }
done
for m in 3 9; do
    "$S2" build "$SP" --emit=elf --rt-mutant=$m -o "$W/mut" > /dev/null 2>&1 || { echo "FAIL: build mutant $m"; fail=$((fail + 1)); continue; }
    chmod +x "$W/mut"
    caught=0
    for w in 2 1; do
        SOBER_WORKERS=$w timeout 5 "$W/mut" > /dev/null 2>&1 < /dev/null
        [ $? = 124 ] && { caught=1; break; }
    done
    [ $caught = 1 ] || { echo "FAIL: mutant $m was not caught — $SP finished without the checkpoints"; fail=$((fail + 1)); }
done
"$S2" build "$SP" --emit=elf --cut-stat --rt-mutant=10 -o "$W/t10" > /dev/null 2>&1 || { echo "FAIL: cut-stat mutant 10"; fail=$((fail + 1)); }
cmp -s "$W/t10" "$(gold "$SP")" && { echo "FAIL: mutant 10 (no thinning) was not caught — the table did not change"; fail=$((fail + 1)); }
echo "cutstat: ${#CASES[@]} tables + $SP × workers {1, 2, 8} + 3 mutants, fail=$fail"
[ $fail = 0 ]
