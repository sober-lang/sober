#!/usr/bin/env bash
# jcleancheck（JSON のエスケープの要らない区間の核 rt.jclean の網 — SIMD の核 段 2・report-1165）: testdata/jclean を最適化のバックエンド（--passes —
# x86 の手書きの本体 xJCleanBody）と最適化なし（--no-opt — rt.jclean の IR の本体 = 参照の意味）で建てて走らせ、失敗が 0 で 2 つの出力が一致すること。
# 続けて変異の自己検査: 開発用 --rt-mutant=25（'\' の判定を省く）・26（n ≥ 16 の端数の重ねた読みを省く）・27（8〜15 バイトの後ろの語の位置を p + k に）で
# 建てた本体を網が捕まえること
#   scripts/jcleancheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0
for v in opt noopt m25 m26 m27; do
    f="--passes"
    [ $v = noopt ] && f="--no-opt"
    [ ${v:0:1} = m ] && f="--passes --rt-mutant=${v:1}"
    "$S2" build testdata/jclean/main.sober --emit=elf $f -o "$W/$v" > /dev/null || { echo "jcleancheck: FAIL build ($v)"; exit 1; }
    chmod +x "$W/$v"
    timeout -s KILL 120 "$W/$v" > "$W/$v.out" 2>&1
    echo $? > "$W/$v.rc"
done
[ "$(cat "$W/opt.rc")" = 0 ] && [ "$(tail -n 2 "$W/opt.out" | head -n 1)" = 0 ] || { echo "FAIL: failing cases (--passes)"; grep -a FAIL "$W/opt.out" | head -5; fail=$((fail + 1)); }
cmp -s "$W/opt.out" "$W/noopt.out" || { echo "FAIL: --passes and --no-opt differ (hand-written body ≢ IR body)"; fail=$((fail + 1)); }
for m in m25 m26 m27; do
    [ "$(cat "$W/$m.rc")" != 0 ] || { echo "FAIL: mutant $m was not caught"; fail=$((fail + 1)); }
done
echo "jcleancheck: $(tail -n 3 "$W/opt.out" | head -n 1) cases × {--passes, --no-opt} — hand-written body ≡ IR body (checksum $(tail -n 1 "$W/opt.out")); mutants 25 / 26 / 27 caught, fail=$fail"
[ $fail = 0 ]
