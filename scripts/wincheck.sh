#!/usr/bin/env bash
# wincheck: 浅い region の窓（language.md 11 節「接続の task の小さいスロット」）の網。testdata/wincheck/win.sober（net.Serve の region: 1 MiB の接続の
# task が窓を越えて小さいスロットへ移る道 — 持続する深度の積み・先端の 1 バイト伸長・map の成長・ファイルの読み・深い再帰・region: の境）を
# W2 / W8 × {既定・SOBER_TASK_WIN=0（窓を張らない）・SOBER_MADV_MB=0（深度の入りの返しを毎回走らせる — 窓の守りを踏む）} で走らせ、
# stdout が testdata/wincheck/win.out と一致することを確かめる（窓の有無で出力は変わらない — region: の上限も窓の有無でちょうど同じ）。
# W1 は窓を張らない（小さいスロットの task は M:N のときだけ）ので回さない。
# --mutants: 変異 42（窓を移さない — 溢れで死 102）・43（深度の入りと lease の返しの窓の守りを外す）で建てた題材がどこかの構成で黄金と外れることを確かめる
#   scripts/wincheck.sh [--mutants]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
MUT=0
[ "${1:-}" = --mutants ] && MUT=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
GOLD=testdata/wincheck/win.out
# judge <実行ファイル> <名前> → 0 = 全構成で黄金と一致（外れた構成を印字）
judge() {
    local x=$1 name=$2 w e bad=0
    for w in 2 8; do
        for e in "" SOBER_TASK_WIN=0 SOBER_MADV_MB=0; do
            env SOBER_WORKERS=$w $e timeout 60 "$x" > "$W/out" 2> "$W/err"
            local ec=$?
            if [ $ec != 0 ] || ! cmp -s "$GOLD" "$W/out"; then
                echo "wincheck: $name W$w ${e:-default}: exit $ec"
                diff "$GOLD" "$W/out" | head -8
                head -3 "$W/err"
                bad=1
            fi
        done
    done
    return $bad
}
"$S2" build testdata/wincheck/win.sober --emit=elf --passes -o "$W/win" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
fail=0
judge "$W/win" base || { echo "wincheck: FAIL — output differs from $GOLD"; fail=1; }
if [ $MUT = 1 ]; then
    for m in 42 43; do
        "$S2" build testdata/wincheck/win.sober --emit=elf --passes --rt-mutant=$m -o "$W/win$m" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build m$m"; exit 1; }
        if judge "$W/win$m" "m$m" > "$W/m$m.log"; then echo "wincheck: FAIL — mutant $m was not caught"; fail=1; else echo "wincheck: m$m caught ($(head -1 "$W/m$m.log"))"; fi
    done
fi
[ $fail = 0 ] && echo "wincheck: PASS"
exit $fail
