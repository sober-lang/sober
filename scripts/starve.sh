#!/usr/bin/env bash
# starve（飽和下の待ちの上限の網 — language.md 28 節 ring の道「飽和下の待ちの上限」・report-1142）: testdata/starve/starve.sober（echo の net.Serve +
# 閉ループの客 512 本を同じプロセスに・Serve 3 秒）を SOBER_WORKERS=2 で走らせ、終わりの task.Ledger() を読む。
# 判定: aged > 0（飽和した — 0 なら SKIP: 網が飽和を作れなかった機械では判定しない）かつ maxWait ≤ 1000 ms かつ late ≥ aged（底を期限で救った task は D を越えて走った task）（接続の D = 10 ms・客の task は既定の 100 ms）。
# 的は D = ∞ のクラス（特定の task が秒単位で走らない — 上限の無い rt は 1.7〜7.3 s）で、D の精密な守りではない。10 倍の余白は OS の奪い
# （gates の並列）で D を越える数十 ms の揺れを偽赤にしないため。
#   scripts/starve.sh            網（ROUNDS 回 — 既定 1）
#   scripts/starve.sh --mutants  検出率の確認: 変異 23（上限を切る）・24（上限 + 受け箱の先取りを切る = da59f340 の形）が赤になること。
#                                28（走れる積みの環の容量 8 — 溢れの道を毎回通す）は緑のまま（report-1168 — 溢れの順の変異 29 は schedfuzz の readyspill が捕まえる。
#                                maxWait は底を取った回だけ測るので、溢れの順が崩れても環が空になるたびに頭から掃けるこの題材では赤にならない）
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
    local lt
    lt=$(echo "$out" | sed -n 's/^late=\([0-9]*\) maxLate_ms=[0-9]*$/\1/p')
    # 底を期限で救った task は D を越えて走った task（aged ⊆ late）
    if [ -z "$lt" ] || [ "$lt" -lt "$ag" ]; then echo "starve: RED $tag — late ${lt:-?} < aged $ag"; return 1; fi
    if [ "$ag" = 0 ] && [ "$mw" -le "$LIMIT" ]; then echo "starve: SKIP $tag — not saturated (aged 0, maxWait ${mw} ms)"; return 2; fi
    if [ "$mw" -gt "$LIMIT" ]; then echo "starve: RED $tag — maxWait ${mw} ms > ${LIMIT} ms (aged $ag)"; return 1; fi
    echo "starve: ok $tag — maxWait ${mw} ms (aged $ag, late $lt)"; return 0
}
if [ "${1:-}" = "--mutants" ]; then
    fail=0
    for m in 23 24; do
        for r in $(seq ${ROUNDS:-3}); do
            run m$m-$r --rt-mutant=$m; ec=$?
            [ $ec = 1 ] || { echo "starve: mutant $m not detected (round $r)"; fail=1; }
        done
    done
    for r in $(seq ${ROUNDS:-3}); do
        run spill-$r --rt-mutant=28; ec=$?
        [ $ec = 1 ] && { echo "starve: the spill path (ring capacity 8) is red (round $r)"; fail=1; }
    done
    [ $fail = 0 ] && echo "starve: mutants detected" || exit 1
    exit 0
fi
# 浅い積みの越え（testdata/starve/late.sober — 3 本の task が CPU を 300 ms 以上握り合う）: late ≥ 1・maxLate > 0（底を期限で救わない越えも数える）
late() {
    "$S2" build testdata/starve/late.sober --emit=elf --passes -o "$W/late" > "$W/late.blog" 2>&1 || { echo "starve: FAIL build late ($(head -c 200 "$W/late.blog"))"; return 1; }
    local out ec=0 lt ml
    out=$(SOBER_WORKERS=2 timeout 60 "$W/late" 2> "$W/late.err") || ec=$?
    lt=$(echo "$out" | sed -n 's/^late=\([0-9]*\) maxLate_ms=\([0-9]*\) aged=[0-9]*$/\1/p')
    ml=$(echo "$out" | sed -n 's/^late=\([0-9]*\) maxLate_ms=\([0-9]*\) aged=[0-9]*$/\2/p')
    if [ "$ec" != 0 ] || [ -z "$lt" ]; then echo "starve: FAIL late — exit $ec ($(head -c 200 "$W/late.err"))"; return 1; fi
    if [ "$lt" -lt 1 ] || [ "$ml" -lt 1 ]; then echo "starve: RED late — late $lt maxLate ${ml} ms (a task that waited past D was not counted)"; return 1; fi
    echo "starve: ok late — late $lt maxLate ${ml} ms"; return 0
}
fail=0
for r in $(seq ${ROUNDS:-1}); do
    run base-$r; ec=$?
    [ $ec = 1 ] && fail=1
done
late || fail=1
[ $fail = 0 ] && echo "starve: PASS" || { echo "starve: FAIL"; exit 1; }
