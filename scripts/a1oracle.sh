#!/usr/bin/env bash
# a1oracle（再帰型の差分オラクル — report-rec-15）: 再帰の型宣言を使う題材ごとに、ネイティブの build（再帰型の lowering）と
# A1 への書き換え（src/compiler/tools/a1dump — 値ごとに自分の部分木の表 + 根・再帰型の無い今の言語）の build を走らせ、
# stdout と終了コードが一致すること。A1 側は「出力に再帰の組が残っていない」（a1dump --groups = 0）も見る。
# 断片の外（a1dump の exit 2）は題材の列にある限り赤。負例 testdata/a1/neg は逆に exit 2 + `a1: unsupported:` で名指されること。
#   scripts/a1oracle.sh            題材の列の全部
#   scripts/a1oracle.sh --list     題材の列を出す
#   scripts/a1oracle.sh --mut      網の確かめ: a1dump の変異 2 本（A1_MUT=shift / kids）でそれぞれ少なくとも 1 題材が赤になること
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
LIST=(examples/type_recursive.sober examples/type_recursive_tree.sober examples/type_recursive_mutual.sober
      examples/type_recursive_group.sober examples/type_recursive_generic.sober examples/type_recursive_opt_mutual.sober testdata/a1/*.sober)
[ "${1:-}" = --list ] && { printf '%s\n' "${LIST[@]}"; exit 0; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
if [ -n "${SELFHOST_BIN:-}" ] && [ -x "$SELFHOST_BIN/a1dump" ]; then
    cp "$SELFHOST_BIN/a1dump" "$W/a1dump"
else
    (cd src/compiler && "$SOBER" build tools/a1dump/main.sober -o "$W/a1dump") > "$W/tb" 2>&1 || { echo "a1oracle: FAIL build src/compiler/tools/a1dump"; cat "$W/tb"; exit 1; }
fi
# 1 題材: native ≡ A1。出力 = 空（一致）か理由の 1 行
one() { # $1 = 題材 $2 = 置き場
    local f=$1 d=$2 nc ac
    mkdir -p "$d"
    "$SOBER" build "$f" -o "$d/n" > "$d/nb" 2>&1 || { echo "native build: $(head -1 "$d/nb")"; return; }
    timeout -s KILL 20 "$d/n" > "$d/n.out" 2>&1; nc=$?
    "$W/a1dump" src/std "$f" > "$d/a1.sober" 2> "$d/ae"; local rc=$?
    [ $rc = 0 ] || { echo "a1dump exit $rc: $(head -1 "$d/ae")"; return; }
    local g; g=$("$W/a1dump" --groups src/std "$d/a1.sober" 2>&1)
    [ "$g" = 0 ] || { echo "recursive groups left in the A1 output: $g"; return; }
    "$SOBER" build "$d/a1.sober" -o "$d/a" > "$d/ab" 2>&1 || { echo "A1 build: $(head -1 "$d/ab")"; return; }
    timeout -s KILL 20 "$d/a" > "$d/a.out" 2>&1; ac=$?
    [ "$nc" = "$ac" ] || { echo "exit code native $nc ≠ A1 $ac"; return; }
    cmp -s "$d/n.out" "$d/a.out" || { echo "stdout differs: $(diff "$d/n.out" "$d/a.out" | head -2 | tr '\n' ' ')"; return; }
}
run() { # $1 = 印 — 題材ごとの判定を $W/<印>/res に
    local i=0 f
    for f in "${LIST[@]}"; do
        ( r=$(one "$f" "$W/$1/$i"); echo "$f	$r" > "$W/$1/$i.res" ) &
        i=$((i + 1))
    done
    wait
    cat "$W/$1"/*.res > "$W/$1.res"
}
if [ "${1:-}" = --mut ]; then
    fail=0
    for m in shift kids; do
        mkdir -p "$W/m-$m"
        A1_MUT=$m run "m-$m"
        red=$(awk -F'\t' '$2 != ""' "$W/m-$m.res" | wc -l)
        if [ "$red" -gt 0 ]; then echo "ok: mutant $m caught by $red / ${#LIST[@]} subjects"; else echo "FAIL: mutant $m survives"; fail=1; fi
    done
    exit $fail
fi
mkdir -p "$W/base"
run base
fail=$(awk -F'\t' '$2 != ""' "$W/base.res" | wc -l)
awk -F'\t' '$2 != "" { print "FAIL: " $1 ": " $2 }' "$W/base.res"
# 負例（testdata/a1/neg）: 断片の外を a1dump が exit 2 と `a1: unsupported:` で名指す（黙って書き換えずに通さない）
nneg=0
for f in testdata/a1/neg/*.sober; do
    nneg=$((nneg + 1))
    "$W/a1dump" src/std "$f" > /dev/null 2> "$W/neg.err"; rc=$?
    if [ $rc != 2 ] || ! grep -q '^a1: unsupported:' "$W/neg.err"; then echo "FAIL: $f: a1dump exit $rc (want 2 + a1: unsupported)"; fail=$((fail + 1)); fi
done
echo "a1oracle: ${#LIST[@]} subjects — native ≡ A1 (stdout + exit code, no recursive group left) + $nneg negatives named, fail=$fail"
[ "$fail" = 0 ]
