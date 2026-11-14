#!/usr/bin/env bash
# matchlencheck（一致の長さの核binary.MatchLen / rt.matchlenの検査 — SIMD の核 段階1・report-1137）: testdata/matchlenを最適化のバックエンド（--passes —
# x86の手書きの本体xMatchLenBody）と最適化なし（--no-opt — rt.matchlenのIRの本体 = 参照の意味）でビルドして走らせ、失敗が0で2つの出力が一致すること。
# 続けてミュータントの自己検査: 開発用 --rt-mutant=13（16 バイトのチャンクの食い違いの位置 +1）・14（端数の重ねた読みを省く）でビルドした本体を検査が捕まえること
#   scripts/matchlencheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0
for v in opt noopt m13 m14; do
    f="--passes"
    [ $v = noopt ] && f="--no-opt"
    [ $v = m13 ] && f="--passes --rt-mutant=13"
    [ $v = m14 ] && f="--passes --rt-mutant=14"
    "$S2" build testdata/matchlen/main.sober --emit=elf $f -o "$W/$v" > /dev/null || { echo "matchlencheck: FAIL build ($v)"; exit 1; }
    chmod +x "$W/$v"
    timeout -s KILL 120 "$W/$v" > "$W/$v.out" 2>&1
    echo $? > "$W/$v.rc"
done
[ "$(cat "$W/opt.rc")" = 0 ] && [ "$(tail -n 2 "$W/opt.out" | head -n 1)" = 0 ] || { echo "FAIL: failing cases (--passes)"; grep FAIL "$W/opt.out" | head -5; fail=$((fail + 1)); }
cmp -s "$W/opt.out" "$W/noopt.out" || { echo "FAIL: --passes and --no-opt differ (hand-written body ≢ IR body)"; fail=$((fail + 1)); }
for m in m13 m14; do
    [ "$(cat "$W/$m.rc")" != 0 ] || { echo "FAIL: mutant $m was not caught"; fail=$((fail + 1)); }
done
echo "matchlencheck: $(tail -n 3 "$W/opt.out" | head -n 1) cases × {--passes, --no-opt} — hand-written body ≡ IR body (checksum $(tail -n 1 "$W/opt.out")); mutants 13 / 14 caught, fail=$fail"
[ $fail = 0 ]
