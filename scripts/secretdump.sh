#!/usr/bin/env bash
# 秘密の値の流れの導出の網（effect の波 段 3c-1 — language.md 13 節の補 2）と出所の表の網（段 4c — 13 節の補 3・下の origin の節）: `sober check <entry> --secret-dump`（表 T = 秘密の値を演算子・添字・
# 呼び出しの実引数に使う関数・秘密を持つ欄のスロット・違反・要約）を testdata/secretdump/<名前>.txt とバイト一致で照合する。
# 入力 = examples/secret_*.sober と std の全 package（合成の main — 違反 0 件の証人）と compiler/ 自身（自己の要約の行だけ — 源が 0 本 = 「compiler/ は秘密に触らない」の証人）。
#
#   scripts/secretdump.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
G=testdata/secretdump
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = "--regen" ] && regen=1
mkdir -p "$G"
fail=0
n=0
for e in examples/secret_*.sober; do
    n=$((n + 1))
    k=$(basename "$e" .sober)
    "$S2" check "$e" --secret-dump > "$W/$k.txt" 2>&1
    if [ $regen = 1 ]; then cp "$W/$k.txt" "$G/$k.txt"; continue; fi
    diff -q "$W/$k.txt" "$G/$k.txt" > /dev/null 2>&1 || { echo "FAIL $e:"; diff "$W/$k.txt" "$G/$k.txt" | head -5; fail=1; }
done
# std: std の全 package（std/internal は std の中からだけ — 使う package を通して読まれる）を import する合成の main の dump（std の印・表 T・秘密の欄・
# 違反 0 件の証人 — 段 3b-2。stage2.sh の L0 焼き込みも std の check で違反を拒否するが、表の形をここで黄金に残す）
mkdir -p "$W/std/app" && cp -r src/std "$W/std/std"
{ echo "package main"; echo; for d in $(cd src && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$W/std/app/main.sober"
(cd "$W/std" && "$S2" check app/main.sober --secret-dump 2>&1) > "$W/std.txt"
if [ $regen = 1 ]; then
    cp "$W/std.txt" "$G/std.txt"
else
    diff -q "$W/std.txt" "$G/std.txt" > /dev/null 2>&1 || { echo "FAIL std:"; diff "$W/std.txt" "$G/std.txt" | head -5; fail=1; }
fi
grep -q ' violations=0 ' "$W/std.txt" || { echo "FAIL std: violations"; grep -m3 violation "$W/std.txt"; fail=1; }
# 自己: compiler/ の木（std を写した — checkverdict の自己適用と同じ形）の要約の行
mkdir -p "$W/self" && cp -r src/compiler "$W/self/compiler" && cp -r src/std "$W/self/compiler/std"
(cd "$W/self/compiler" && ulimit -s unlimited && "$S2" check app/main.sober --secret-dump 2>&1 | tail -1) > "$W/self.txt"
if [ $regen = 1 ]; then
    cp "$W/self.txt" "$G/self.txt"
else
    diff -q "$W/self.txt" "$G/self.txt" > /dev/null 2>&1 || { echo "FAIL self:"; diff "$W/self.txt" "$G/self.txt"; fail=1; }
fi
# 出所の表（段 4c — `check --origin-dump`: 源の口・Eff の関数・SH の variant と欄・出会いの口・違反）: 出所の例（examples/http_origin・origin_neg_*）・
# std（同じ合成の main — 源の口と SH の表の黄金・違反 0 件）・compiler/ 自身（源 0 本 = 表が空の証人）
no=0
for e in examples/http_origin.sober examples/origin_*.sober; do
    no=$((no + 1))
    k=origin_$(basename "$e" .sober)
    "$S2" check "$e" --origin-dump > "$W/$k.txt" 2>&1
    if [ $regen = 1 ]; then cp "$W/$k.txt" "$G/$k.txt"; continue; fi
    diff -q "$W/$k.txt" "$G/$k.txt" > /dev/null 2>&1 || { echo "FAIL $e (origin):"; diff "$W/$k.txt" "$G/$k.txt" | head -5; fail=1; }
done
(cd "$W/std" && "$S2" check app/main.sober --origin-dump 2>&1) > "$W/origin_std.txt"
(cd "$W/self/compiler" && ulimit -s unlimited && "$S2" check app/main.sober --origin-dump 2>&1 | tail -1) > "$W/origin_self.txt"
for k in origin_std origin_self; do
    if [ $regen = 1 ]; then cp "$W/$k.txt" "$G/$k.txt"; continue; fi
    diff -q "$W/$k.txt" "$G/$k.txt" > /dev/null 2>&1 || { echo "FAIL $k:"; diff "$W/$k.txt" "$G/$k.txt" | head -5; fail=1; }
done
grep -q ' violations=0 ' "$W/origin_std.txt" || { echo "FAIL origin std: violations"; fail=1; }
grep -q '^summary atoms=0 ' "$W/origin_self.txt" || { echo "FAIL origin self: compiler/ has credential sources"; cat "$W/origin_self.txt"; fail=1; }
echo "secretdump: $n examples + std ($(tail -1 "$W/std.txt")) + self ($(cat "$W/self.txt")); origin: $no examples + std ($(tail -1 "$W/origin_std.txt")) + self ($(cat "$W/origin_self.txt")), fail=$fail"
exit $fail
