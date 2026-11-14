#!/usr/bin/env bash
# vecchk（手書きのSIMDのチャンクのウィンドウ — compiler/lower/x86.soberのxWinChk / xWinChkRem）:
# ① 開発用 `sober build --vec-check`（ミューテーション56）で、scanb・UTF-8の検査器・数え上げ・crcfoldの検査の例をビルドして走らせ、出力と終了コードがゴールデンどおり
#   （チャンクのウィンドウの読みはどれも列の内側 — 外ならexit 103）
# ② ミューテーションの自己検査: 57 = scanbの端数のウィンドウを1後ろ・58 = UTF-8の検査器の端数のウィンドウを1後ろ（どちらも列の直後1バイトの範囲外読み — 出力は変わらない形もある）・
#   59 = scanb の入口の符号の検査を外す（負の始点・始点 + 16 のあふれ）→ どれもどこかの例が exit 103 で止まる
#   scripts/vecchk.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
CASES=(opt_vec_scan opt_vec_scan_neg opt_vec_scan_panic opt_vec_scan_tail opt_vec_scan_wrap utf8_simd utf8_simd_tail opt_count crc32_slice crc32_sum)
# run <例> <ミューテーション> → 終了コード（出力は $W/<例>.<ミューテーション>.out）
run() {
    "$S2" build "examples/$1.sober" --emit=elf --passes --rt-mutant="$2" -o "$W/$1.$2" > /dev/null 2>&1 || { echo build; return; }
    chmod +x "$W/$1.$2"
    timeout 60 "$W/$1.$2" > "$W/$1.$2.out" 2> /dev/null < /dev/null
    echo $?
}
for e in "${CASES[@]}"; do
    want=0
    [ -f "examples/$e.exit" ] && want=$(cat "examples/$e.exit")
    ec=$(run "$e" 56)
    [ "$ec" = "$want" ] && cmp -s "$W/$e.56.out" "examples/$e.out" || { echo "FAIL: --vec-check $e (exit $ec, want $want) — a window outside the slice or the output differs"; fail=$((fail + 1)); }
done
for m in 57 58 59; do
    caught=""
    for e in "${CASES[@]}"; do
        ec=$(run "$e" $m)
        [ "$ec" = 103 ] && { caught=$e; break; }
    done
    [ -n "$caught" ] || { echo "FAIL: mutant $m was not caught — no example read a window outside the slice"; fail=$((fail + 1)); }
done
echo "vecchk: ${#CASES[@]} examples under --vec-check + 3 mutants, fail=$fail"
[ $fail = 0 ]
