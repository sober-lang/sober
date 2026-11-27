#!/usr/bin/env bash
# r11lint: 最適化のバックエンドで r11 を割り当てに使う条件（docs/regalloc.md の r11 の節）の機械的な検査。
#   ① src/compiler/lower/x86.sober の生の `x86.R11` は、決めた関数の中にだけある（ほかは r11 を作業に使う口 xT11 を通す — xT11 は今の位置で
#      r11 に生きた値が載っていればビルドを止める）。決めた関数 = 割り当ての表（xAllocReg）・中継の本体（xKeepAllBody）・フレームを立てる前の
#      入口（xAreaProlog・xAreaFar — 値がまだ r11 に無い）・syscall（xSyscall — 跨いで r11 に載る値を自分で積む）・写しのバックエンドの循環の
#      解消（xParallelMove）・口そのもの（xT11・xR11Busy・xInsUsesR11 の比較）・割り当ての空きの判定（xPrioPick・xPrioEvict・xEvictMaybe・xAnyFree）
#   ② xT11 が自分を呼ばない（口の中は x86.R11 を返す）
#   scripts/r11lint.sh
set -u
cd "$(dirname "$0")/.."
F=src/compiler/lower/x86.sober
allow=" xAllocReg xKeepAllBody xAreaProlog xAreaFar xSyscall xParallelMove xT11 xR11Busy xInsUsesR11 xPrioPick xPrioEvict xEvictMaybe xAnyFree "
bad=$(awk -v allow="$allow" '/^func [A-Za-z0-9_]+/ { f = $2; sub(/\(.*/, "", f) } /x86\.R11\>/ { if (index(allow, " " f " ") == 0) printf "%s:%d (%s)\n", FILENAME, NR, f }' $F)
self=$(awk '/^func xT11\(/ { on = 1; next } on && /^func / { on = 0 } on && /xT11\(/ { print FILENAME ":" NR }' $F)
fail=0
[ -n "$bad" ] && { echo "r11lint: FAIL 生の x86.R11 が決めた関数の外にある（xT11 を通す）:"; echo "$bad" | head -10; fail=1; }
[ -n "$self" ] && { echo "r11lint: FAIL xT11 が自分を呼んでいる: $self"; fail=1; }
n=$(grep -c "xT11(mut e)" $F)
[ $fail = 0 ] && echo "r11lint: PASS（xT11 の口 $n 箇所・生の x86.R11 は決めた関数の中だけ）"
exit $fail
