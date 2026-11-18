#!/usr/bin/env bash
# genmono: lower の単相コピーと、型引数を手で代入した単相の関数の照合。testdata/genmono/<名前>.g.sober（総称）と <名前>.m.sober（単相）の組ごとに
#   1. IR（`build --emit=ir`・パスなし）: 単相コピーは手で書いた関数と一字一句同じ。呼び手の側は、総称の呼び出しが実引数と戻り値をスロットへ写す
#      ヘッダのコピーだけ違ってよい（region の命令と呼び出しの列は同じ — scripts/genmono.ts）
#   2. 実行の出力と終了コードが同じ
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fail=0
n=0
for g in testdata/genmono/*.g.sober; do
    b=$(basename "$g" .g.sober)
    m=testdata/genmono/$b.m.sober
    n=$((n + 1))
    for v in g m; do
        src=testdata/genmono/$b.$v.sober
        "$STAGE2" build --emit=ir "$src" -o "$tmp/$b.$v.ir" 2> "$tmp/$b.$v.err" || { echo "FAIL $b: build --emit=ir of $src"; cat "$tmp/$b.$v.err"; fail=$((fail + 1)); continue 2; }
        "$STAGE2" build "$src" -o "$tmp/$b.$v.exe" 2> "$tmp/$b.$v.err" || { echo "FAIL $b: build of $src"; cat "$tmp/$b.$v.err"; fail=$((fail + 1)); continue 2; }
        "$tmp/$b.$v.exe" > "$tmp/$b.$v.out" 2>&1
        echo "exit=$?" >> "$tmp/$b.$v.out"
    done
    r=$(node --experimental-strip-types scripts/genmono.ts "$tmp/$b.g.ir" "$tmp/$b.m.ir" "$m")
    if [ $? != 0 ]; then
        echo "FAIL $b: IR"
        echo "$r"
        fail=$((fail + 1))
    else
        echo "$b: $(echo "$r" | tail -n 1)"
    fi
    if ! cmp -s "$tmp/$b.g.out" "$tmp/$b.m.out"; then
        echo "FAIL $b: the outputs differ"
        diff "$tmp/$b.g.out" "$tmp/$b.m.out" | head -n 6
        fail=$((fail + 1))
    fi
done
echo "genmono: $n pairs, fail=$fail"
[ "$fail" = 0 ]
