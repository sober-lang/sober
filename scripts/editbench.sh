#!/usr/bin/env bash
# 編集ループの bench（3'' 第 2 段 C3・M4 の裁定材料）: 固定のコンパイラ（今の stage2）で、自己適用（compiler/app の写し）に
# 決まった編集を当てて、一括の check と小分けの check（温 — 編集前の木で温めた置き場の写し）を交互に測る。冷（空の置き場）も 1 回ずつ。
# 編集（std はコンパイラに焼き込み — std の編集はコンパイラの作り直しで鍵が全部変わるので、std の代役に ast〔ほぼ全 package が import〕を使う）:
#   none          変更なし
#   lower-body    lower/lower.sober の最初の `return nil` の前に 1 文
#   desugar-body  desugar/surface.sober の最初の `return nil` の前に 1 文
#   ast-body      ast.ListAt の本体の式（.sobi に載らない — 早期打ち切り）
#   ast-sig       ast.ListLen の仮引数名（.sobi が変わる — ast に依る全 package が外れる）
# 使い方: scripts/editbench.sh [回数（既定 3）]  — 出力 = 1 行 1 計測（編集 種類 秒 KB 外れの数）。長い（約 15 分）— 背景で回して出力をファイルで読む
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
N=${1:-3}
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
export SOBER_SELF_KEY=$(cat "$(dirname "$STAGE2")/.key")
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/base"
cp -r src/compiler "$W/base/compiler"
cp -r src/std "$W/base/compiler/std"
ulimit -s unlimited
# 温めた置き場（編集前の木）
( cd "$W/base/compiler" && SOBER_CACHE=$W/warm "$STAGE2" check app --split > /dev/null 2>&1 )
edit() { # $1 = 編集・$2 = 木の compiler/
    case "$1" in
        none) ;;
        lower-body) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$2/lower/lower.sober" ;;
        desugar-body) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$2/desugar/surface.sober" ;;
        ast-body) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[1 + l + i]|' "$2/ast/ast.sober" ;;
        ast-sig) sed -i 's|^func ListLen(t Tree, l int) int {$|func ListLen(t Tree, n int) int {|; /^func ListLen/{n;s|    return t.data\[l\]|    return t.data[n]|}' "$2/ast/ast.sober" ;;
    esac
}
meas() { # $1 = 編集・$2 = 種類（whole / warm / cold）
    local t=$W/t.txt tr=$W/tr.txt c miss=-
    case "$2" in
        whole) ( cd "$W/tree/compiler" && SOBER_CACHE= /usr/bin/time -o "$t" -f '%e %M' "$STAGE2" check app > /dev/null 2>&1 ) ;;
        warm) rm -rf "$W/c"; cp -r "$W/warm" "$W/c"; ( cd "$W/tree/compiler" && SOBER_CACHE=$W/c /usr/bin/time -o "$t" -f '%e %M' "$STAGE2" check app --split --cache-trace > /dev/null 2> "$tr" ); miss=$(grep -c ' miss$' "$tr") ;;
        cold) rm -rf "$W/c"; ( cd "$W/tree/compiler" && SOBER_CACHE=$W/c /usr/bin/time -o "$t" -f '%e %M' "$STAGE2" check app --split > /dev/null 2>&1 ) ;;
    esac
    echo "$1 $2 $(tail -1 "$t") $miss"
}
for r in $(seq 1 "$N"); do
    for e in none lower-body desugar-body ast-body ast-sig; do
        rm -rf "$W/tree"; mkdir -p "$W/tree"; cp -r "$W/base/compiler" "$W/tree/compiler"
        edit "$e" "$W/tree/compiler"
        if [ "$e" != none ] && diff -rq "$W/base/compiler" "$W/tree/compiler" > /dev/null; then echo "editbench: edit $e did not apply" >&2; exit 1; fi
        meas "$e" whole
        meas "$e" warm
        if [ "$r" = 1 ]; then meas "$e" cold; fi
    done
done
