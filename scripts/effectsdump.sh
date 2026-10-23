#!/usr/bin/env bash
# 関数の効果の導出の網（effect の波 段 5a — language.md 12 節「関数の効果の宣言」）: `sober check <entry> --effects-dump`（本体のある関数ごとの効果のビット・
# 名前付き関数型の合併・違反・要約）を testdata/effectsdump/<名前>.txt とバイト一致で照合する。
# 入力 = examples/effects_*.sober（負例の違反の表を含む）と std の全 package（合成の main — 宣言の違反 0 件の証人）と compiler/ 自身（要約の行だけ — 自己 check の受理の証人）。
#
#   scripts/effectsdump.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
G=testdata/effectsdump
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = "--regen" ] && regen=1
mkdir -p "$G"
fail=0
n=0
for e in examples/effects_*.sober; do
    n=$((n + 1))
    k=$(basename "$e" .sober)
    "$S2" check "$e" --effects-dump 2>&1 | grep -v ': effects std/' > "$W/$k.txt"
    if [ $regen = 1 ]; then cp "$W/$k.txt" "$G/$k.txt"; continue; fi
    diff -q "$W/$k.txt" "$G/$k.txt" > /dev/null 2>&1 || { echo "FAIL $e:"; diff "$W/$k.txt" "$G/$k.txt" | head -5; fail=1; }
done
# std: std の全 package（std/internal は std の中からだけ）を import する合成の main の表（std の関数の効果の黄金・違反 0 件）
mkdir -p "$W/std/app" && cp -r src/std "$W/std/std"
{ echo "package main"; echo; for d in $(cd src && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$W/std/app/main.sober"
(cd "$W/std" && "$S2" check app/main.sober --effects-dump 2>&1) > "$W/std.txt"
# 自己: compiler/ の木（std を写した — checkverdict の自己適用と同じ形）の要約の行
mkdir -p "$W/self" && cp -r src/compiler "$W/self/compiler" && cp -r src/std "$W/self/compiler/std"
(cd "$W/self/compiler" && ulimit -s unlimited && "$S2" check app/main.sober --effects-dump 2>&1 | tail -1) > "$W/self.txt"
for k in std self; do
    if [ $regen = 1 ]; then cp "$W/$k.txt" "$G/$k.txt"; continue; fi
    diff -q "$W/$k.txt" "$G/$k.txt" > /dev/null 2>&1 || { echo "FAIL $k:"; diff "$W/$k.txt" "$G/$k.txt" | head -5; fail=1; }
done
grep -q ' violations=0$' "$W/std.txt" || { echo "FAIL std: violations"; grep -m3 '^.*violation ' "$W/std.txt"; fail=1; }
grep -q ' violations=0$' "$W/self.txt" || { echo "FAIL self: violations"; cat "$W/self.txt"; fail=1; }
echo "effectsdump: $n examples + std ($(tail -1 "$W/std.txt")) + self ($(cat "$W/self.txt")), fail=$fail"
exit $fail
