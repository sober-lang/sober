#!/usr/bin/env bash
# maprepr（map の表現の差分オラクル — compiler/lower/maprepr.sober）: map の表現は観測等価な実装詳細なので、string 鍵の map を使う
# entry を既定の表現（MR_PRE — 前置きつきのセル）と旧表現（MR_BASE — 開発用 --rt-mutant=11）で建て、stdout と終了コードが一致することを照合する。
# 列 = examples/*.out・testdata/*/app.out のうち IR に string 鍵の引き（rt.map_find.1.）を持つもの + 題材 2 本（1brc・knucleotide — 入力が
# out/bench に置いてあれば）。網の自己検査は examples/map_fuzz（参照の連想リストと毎回突き合わせる）・examples/map_order（22 節の約束）
#   scripts/maprepr.sh
set -uo pipefail
# map のハッシュの種を固定（既定は乱数 — 探査の長さが揺れて命令・cycles が揺れる。出力は種に依らない）
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0; n=0
one() {
    local src=$1 inp=$2; shift 2
    local k
    k=$(echo "$src" | tr '/' '_')
    "$S2" build "$src" --emit=elf --passes -o "$W/$k.new" > /dev/null 2>&1 || { echo "FAIL build $src"; fail=$((fail + 1)); return; }
    "$S2" build "$src" --emit=elf --passes --rt-mutant=11 -o "$W/$k.old" > /dev/null 2>&1 || { echo "FAIL build (old) $src"; fail=$((fail + 1)); return; }
    timeout -s KILL 60 "$W/$k.new" "$@" < "$inp" > "$W/$k.o1" 2> /dev/null; e1=$?
    timeout -s KILL 60 "$W/$k.old" "$@" < "$inp" > "$W/$k.o2" 2> /dev/null; e2=$?
    n=$((n + 1))
    if [ $e1 != $e2 ] || ! cmp -s "$W/$k.o1" "$W/$k.o2"; then echo "FAIL $src (exit $e1 / $e2)"; fail=$((fail + 1)); fi
}
ents=()
for f in examples/*.out; do ents+=("examples/$(basename "$f" .out).sober"); done
for f in testdata/*/app.out; do ents+=("${f%.out}"); done
for e in "${ents[@]}"; do
    "$S2" build "$e" --emit=ir -o "$W/ir" > /dev/null 2>&1 || continue
    grep -q 'rt\.map_find\.1\.' "$W/ir" || continue
    inp=/dev/null
    [ -f "${e%.sober}.in" ] && inp=${e%.sober}.in
    one "$e" "$inp"
done
[ -f out/bench/measurements-1000000.txt ] && one bench/1brc/main.sober /dev/null out/bench/measurements-1000000.txt
[ -f out/bench/fasta-250000.txt ] && one bench/knucleotide/main.sober /dev/null out/bench/fasta-250000.txt
echo "maprepr: $n entries with string-keyed maps — new ≡ old representation (stdout + exit), fail=$fail"
[ $fail = 0 ]
