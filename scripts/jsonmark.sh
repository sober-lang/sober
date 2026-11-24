#!/usr/bin/env bash
# jsonmark（ゼロで初期化しないバッファの拡張の検査。std/internal/jsonwのGrowは、拡張した領域をゼロで初期化しない）: json.Encodeを使う題材を、ふつうのビルドと
# 特定の値で埋めるビルド（開発用 --rt-mutant=94。拡張した領域を0xA5で埋める）で走らせ、出力がバイト一致すること。書き込まれていないバイトが残る
# （書き込んでいないバイトを越えて位置が進む）と、0xA5で埋めるビルドの出力にその値が出て一致しない。題材 = testdata/jsonmark（乱択の型と値・httparenaと同じ型の本文）と、
# json.Encodeを使うexamplesの全部。続けて検査の自己確認: 合成のテンプレートが列の閉じ括弧の後で1バイト書き込まずに位置を進める形（開発用のSOBER_JSONW_MUT=1）で
# ビルドした0xA5で埋めるビルドの出力が、ふつうのビルドと違うこと。テンプレートがPutの位置を進める量を1多く出す形は、生成の時点の検査で止まること（SOBER_JSONW_MUT=2）と、
# その検査を外した形（=3）の出力が、ふつうのビルドと違うこと
#   scripts/jsonmark.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0
n=0
progs=(testdata/jsonmark/main.sober $(grep -l 'json\.Encode' examples/*.sober | grep -v '_neg_' | sort))
for p in "${progs[@]}"; do
    b=$(basename "$(dirname "$p")")-$(basename "$p" .sober)
    "$S2" build "$p" --emit=elf -o "$W/$b.n" > /dev/null 2>&1 || { echo "jsonmark: FAIL build $p"; fail=$((fail + 1)); continue; }
    "$S2" build "$p" --emit=elf --rt-mutant=94 -o "$W/$b.m" > /dev/null 2>&1 || { echo "jsonmark: FAIL build --rt-mutant=94 $p"; fail=$((fail + 1)); continue; }
    i=/dev/null
    [ -f "${p%.sober}.in" ] && i="${p%.sober}.in"
    timeout -s KILL 120 "$W/$b.n" < "$i" > "$W/$b.n.out" 2>&1
    timeout -s KILL 120 "$W/$b.m" < "$i" > "$W/$b.m.out" 2>&1
    cmp -s "$W/$b.n.out" "$W/$b.m.out" || { echo "FAIL: $p: the marker build differs (a skipped byte in the JSON writer)"; fail=$((fail + 1)); }
    n=$((n + 1))
done
lines=$(wc -l < "$W/jsonmark-main.n.out")
[ "$lines" -gt 3000 ] || { echo "FAIL: testdata/jsonmark printed $lines lines"; fail=$((fail + 1)); }
# 検査の自己確認（書き込まずに位置を進めるテンプレート。ビルドのキャッシュは使わない: 合成のファイルが環境変数で変わる）
SOBER_BUILD_CACHE=0 SOBER_JSONW_MUT=1 "$S2" build testdata/jsonmark/main.sober --emit=elf --rt-mutant=94 -o "$W/mut" > /dev/null 2>&1 || { echo "jsonmark: FAIL build (mutant)"; exit 1; }
timeout -s KILL 120 "$W/mut" > "$W/mut.out" 2>&1
if cmp -s "$W/jsonmark-main.n.out" "$W/mut.out"; then echo "FAIL: the skipping mutant was not caught"; fail=$((fail + 1)); fi
# 0xA5が出たこと（題材の文字列にも0xA5〔¥ の2バイト目〕があるので、数が増えたことで見る）
a5() { tr -cd '\245' < "$1" | wc -c; }
[ "$(a5 "$W/mut.out")" -gt "$(a5 "$W/jsonmark-main.n.out")" ] || { echo "FAIL: the mutant output has no extra marker byte"; fail=$((fail + 1)); }
# 生成の時点の検査: テンプレートが位置を進める量を1多く出すと（SOBER_JSONW_MUT=2）コンパイルが止まる。検査を外した同じミュータント（=3）は出力の差で見つかる
if SOBER_BUILD_CACHE=0 SOBER_JSONW_MUT=2 "$S2" build testdata/jsonmark/main.sober --emit=elf --rt-mutant=94 -o "$W/mut2" > /dev/null 2>&1; then
    echo "FAIL: the generator did not stop on an advance past the written width"; fail=$((fail + 1))
fi
SOBER_BUILD_CACHE=0 SOBER_JSONW_MUT=3 "$S2" build testdata/jsonmark/main.sober --emit=elf --rt-mutant=94 -o "$W/mut3" > /dev/null 2>&1 || { echo "jsonmark: FAIL build (mutant 3)"; exit 1; }
timeout -s KILL 120 "$W/mut3" > "$W/mut3.out" 2>&1
if cmp -s "$W/jsonmark-main.n.out" "$W/mut3.out"; then echo "FAIL: the over-advancing mutant was not caught"; fail=$((fail + 1)); fi
echo "jsonmark: $n programs, normal ≡ marker build ($lines lines of testdata/jsonmark); skipping mutant caught; over-advance stopped at generation (mut 2) and caught by output (mut 3), fail=$fail"
[ $fail = 0 ]
