#!/usr/bin/env bash
# nextgen（report-1086）: 次世代バイナリの網 — HEAD の rt を積んだコンパイラで W ≥ 2 の自己 build / check を回す。
# stage2 の rt は stage2 を建てた boot の lower が下ろすので、rt を触った便は鎖の段を足すまで compiler 自身の並列の道を通らない
# （L1-R の park の穴 — 9aac6f67 — は鎖の段 35 で初めて露出した）。ここでは段を待たずに:
#   1. B  = stage2 で今の木を建てる（lower = 今の木・rt = stage2 の）
#   2. B2 = B で今の木を建てる（rt = 今の木 — rt.slot_new の常設の検査つき: 深度を飛ばしたら exit 81・report-1088）
#   3. B2 の自己 build: W1 ≡ W2（1 本の経路）≡ W8 ≡ W8（1 本の経路）の ELF・全部 rc 0
#   4. B2 の自己 check: W1 ≡ W8 の判定
#   5. 網の自己検査: 変異 20（park が task の基底より深い region を全部手放して毒を塗る）・21（read_file を今の深度を宛先へ切り替えて呼ぶ旧形 — report-1086 の穴）— どちらも常設の検査つき — で
#      建てた B2 では W2（1 本の経路）の自己 build が割れる（rc ≠ 0 か ELF の食い違い）
# 実行ファイルは毎回別の名前で建てる（M:N で走らせた直後に同じパスへ書くと ETXTBSY — NOTES の地雷）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
S2=$(cd "$(dirname "$S2")" && pwd)/$(basename "$S2")
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
ulimit -s unlimited
fail=0
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
T=$W/tree
(cd "$T" && SOBER_WORKERS=1 "$S2" build app --emit=elf --passes -o "$W/B") > "$W/b.log" 2>&1 || { echo "FAIL: nextgen — stage2 で今の木が建たない: $(head -c 300 "$W/b.log")"; exit 1; }
chmod +x "$W/B"
gen() { # gen <名前> [変異の番号]: B で今の木を（変異つきで）建てる
    (cd "$T" && SOBER_WORKERS=1 "$W/B" build app ${2:+"--rt-mutant=$2"} -o "$W/$1") > "$W/$1.log" 2>&1 || { echo "FAIL: nextgen — B で $1 が建たない: $(head -c 300 "$W/$1.log")"; return 1; }
    chmod +x "$W/$1"
}
gen B2 || exit 1
self() { # self <バイナリ> <出力の名前> <環境…>: 自己 build（rc を返す）
    local b=$1 o=$2
    shift 2
    (cd "$T" && env "$@" "$b" build app --emit=elf --passes -o "$W/$o") > "$W/$o.log" 2>&1
}
self "$W/B2" e1 SOBER_WORKERS=1 || { echo "FAIL: nextgen — B2 の自己 build（W1）rc=$?: $(head -c 300 "$W/e1.log")"; exit 1; }
for v in "e2p SOBER_WORKERS=2 SOBER_BUILD_PAR=0" "e8 SOBER_WORKERS=8" "e8p SOBER_WORKERS=8 SOBER_BUILD_PAR=0"; do
    set -- $v
    o=$1
    shift
    if ! self "$W/B2" "$o" "$@"; then
        echo "FAIL: nextgen — B2 の自己 build（$*）rc=$?（81 = 深度を飛ばした enter）: $(head -c 300 "$W/$o.log")"; fail=$((fail + 1))
    elif ! cmp -s "$W/e1" "$W/$o"; then
        echo "FAIL: nextgen — B2 の自己 build（$*）の ELF が W1 と食い違う"; fail=$((fail + 1))
    fi
done
(cd "$T" && SOBER_WORKERS=1 "$W/B2" check app > "$W/c1" 2>&1)
(cd "$T" && SOBER_WORKERS=8 "$W/B2" check app > "$W/c8" 2>&1)
grep -q '"ok":true' "$W/c1" || { echo "FAIL: nextgen — B2 の自己 check（W1）が通らない: $(head -c 200 "$W/c1")"; fail=$((fail + 1)); }
cmp -s "$W/c1" "$W/c8" || { echo "FAIL: nextgen — B2 の自己 check の判定が W1 と W8 で食い違う"; fail=$((fail + 1)); }
# 網の自己検査（変異は割れなければならない）
for m in 20 21; do
    gen "M$m" "$m" || { fail=$((fail + 1)); continue; }
    if self "$W/M$m" "m$m" SOBER_WORKERS=2 SOBER_BUILD_PAR=0 && cmp -s "$W/e1" "$W/m$m"; then
        echo "FAIL: nextgen — 変異 $m の B2 で W2 の自己 build が割れない（網が穴を捕まえない）"; fail=$((fail + 1))
    fi
done
if [ "$fail" -gt 0 ]; then
    exit 1
fi
echo "nextgen: ok（B2 = 今の rt — 自己 build W1 ≡ W2 ≡ W8 ≡ W8 1 本・自己 check W1 ≡ W8・変異 20 / 21 は割れる）"
