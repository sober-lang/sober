#!/usr/bin/env bash
# starve（飽和下の待ちの上限の網 — language.md 28 節 ring の道「飽和下の待ちの上限」・report-1142）: testdata/starve/starve.sober（echo の net.Serve +
# 閉ループの客 512 本を同じプロセスに・Serve 3 秒）を SOBER_WORKERS=2 で走らせ、終わりの task.Ledger() を読む。
# 判定: aged > 0（飽和した — 0 なら SKIP: 網が飽和を作れなかった機械では判定しない）かつ maxWait ≤ 1000 ms（接続の D = 10 ms・客の task は既定の 100 ms）。
# 的は D = ∞ のクラス（特定の task が秒単位で走らない — 上限の無い rt は 1.7〜7.3 s）で、D の精密な守りではない。10 倍の余白は OS の奪い
# （gates の並列）で D を越える数十 ms の揺れを偽赤にしないため。
#   scripts/starve.sh            網（ROUNDS 回 — 既定 1）
#   scripts/starve.sh --mutants  検出率の確認: 変異 23（上限を切る）・24（上限 + 受け箱の先取りを切る = da59f340 の形）が赤になること
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
LIMIT=${STARVE_LIMIT_MS:-1000}
# run <tag> [build の引数…] → 0 = 緑・1 = 赤・2 = SKIP（各回の行を出す）
run() {
    local tag=$1; shift
    "$S2" build testdata/starve/starve.sober --emit=elf --passes "$@" -o "$W/$tag" > "$W/$tag.blog" 2>&1 || { echo "starve: FAIL build $tag ($(head -c 200 "$W/$tag.blog"))"; return 1; }
    local out ec=0
    out=$(SOBER_WORKERS=2 timeout 60 "$W/$tag" 2> "$W/$tag.err") || ec=$?
    local mw ag
    mw=$(echo "$out" | sed -n 's/^maxWait_ms=\([0-9]*\) aged=\([0-9]*\)$/\1/p')
    ag=$(echo "$out" | sed -n 's/^maxWait_ms=\([0-9]*\) aged=\([0-9]*\)$/\2/p')
    if [ "$ec" != 0 ] || [ -z "$mw" ]; then echo "starve: FAIL $tag — exit $ec ($(head -c 200 "$W/$tag.err"))"; return 1; fi
    if [ "$ag" = 0 ] && [ "$mw" -le "$LIMIT" ]; then echo "starve: SKIP $tag — not saturated (aged 0, maxWait ${mw} ms)"; return 2; fi
    if [ "$mw" -gt "$LIMIT" ]; then echo "starve: RED $tag — maxWait ${mw} ms > ${LIMIT} ms (aged $ag)"; return 1; fi
    echo "starve: ok $tag — maxWait ${mw} ms (aged $ag)"; return 0
}
if [ "${1:-}" = "--mutants" ]; then
    fail=0
    for m in 23 24; do
        for r in $(seq ${ROUNDS:-3}); do
            run m$m-$r --rt-mutant=$m; ec=$?
            [ $ec = 1 ] || { echo "starve: mutant $m not detected (round $r)"; fail=1; }
        done
    done
    [ $fail = 0 ] && echo "starve: mutants detected" || exit 1
    exit 0
fi
fail=0
for r in $(seq ${ROUNDS:-1}); do
    run base-$r; ec=$?
    [ $ec = 1 ] && fail=1
done
[ $fail = 0 ] && echo "starve: PASS" || { echo "starve: FAIL"; exit 1; }
