#!/usr/bin/env bash
# strix（文字列の rodata の索引の網 — 段 6 R0 の小便・report-1244 1.4）: lower の strGlobal は綴り → rodata のグローバルを開番地の索引
# （compiler/lower/cont.sober — 枠 = [記録 + 1, ハッシュ]・埋まり 1/4 で倍へ）で引く。索引は引きの速さだけで、str.N の番号と並び（= ELF）を
# 変えないこと: 既定の ELF ≡ 開発の口 SOBER_STRIX=1（ハッシュを全部 0 に潰す — 全部が衝突して探りの列を最後まで歩く道）≡ SOBER_STRIX=2
# （2 枠から始めて伸長の境を全部踏む）。証人 = 口のある build の `#strix` の行（伸長ごとに 1 行 — 2 の道は自己 build で 10 回以上）。
# 母集団: 自己 build（compiler/ + std/ の木 — 文字列 ≈2 千・建たなければ赤）+ examples（4 本に 1 本 — 並びの添字 mod 4 = 0）
# 変異で確かめた（report-1245）: 伸長が鎖を入れ直さない形 → 123 本が名指し・伸長しない形（満杯で探りが終わらない）→ 自己 build が timeout で赤
#   scripts/strix.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
export SOBER_HASH_SEED=0 SOBER_WORKERS=1
ulimit -s unlimited
fail=0; n=0
# one <cwd> <入力> <名前> <下限の伸長の数（2 の道）>
one() {
    local dir=$1 src=$2 k=$3 lo=$4 m
    (cd "$dir" && timeout -s KILL 120 "$S2" build "$src" --emit=elf --passes -o "$W/$k.0" > /dev/null 2>&1) || {
        # 例は建たないものを飛ばす（拒否の例）・自己 build は建たなければ赤（索引の探りが終わらない形 — 満杯 — は timeout で落ちる）
        if [ "$k" = self ]; then echo "FAIL self: build (default)"; fail=$((fail + 1)); fi
        return 0
    }
    n=$((n + 1))
    for m in 1 2; do
        if ! (cd "$dir" && SOBER_STRIX=$m timeout -s KILL 120 "$S2" build "$src" --emit=elf --passes -o "$W/$k.$m" > /dev/null 2> "$W/$k.log$m"); then
            echo "FAIL $k: build with SOBER_STRIX=$m"; fail=$((fail + 1)); continue
        fi
        if ! cmp -s "$W/$k.0" "$W/$k.$m"; then
            echo "FAIL $k: ELF differs with SOBER_STRIX=$m"; fail=$((fail + 1))
        fi
    done
    local g
    g=$(grep -c '^#strix mode=2' "$W/$k.log2")
    if [ "$g" -lt "$lo" ]; then
        echo "FAIL $k: SOBER_STRIX=2 grew $g times (want >= $lo — the witness lost the growth path)"; fail=$((fail + 1))
    fi
}
one "$W/tree" app self 10
i=0
for f in examples/*.sober; do
    if [ $((i % 4)) -eq 0 ]; then
        one "$ROOT" "$f" "$(basename "$f" .sober)" 0
    fi
    i=$((i + 1))
done
echo "strix: $n entries — ELF ≡ under SOBER_STRIX=1 (all-collide) / 2 (grow from 2 slots), fail=$fail"
[ "$fail" = 0 ]
