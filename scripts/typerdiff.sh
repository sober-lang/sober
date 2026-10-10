#!/usr/bin/env bash
# 表層型検査器（compiler/desugar/typer.sober — C1 B1）の差分オラクル: irtext と同じ entry（+ compiler/ の自己適用）を
# `sober build --typer-diff` に通し、式ごとの「表層型 × lower の型」の突き合わせの数を合計する。不一致は位置つきで並べる。
#
#   scripts/typerdiff.sh           合計と不一致の一覧（不一致が 1 件でもあれば exit 1）
#   scripts/typerdiff.sh -v        entry ごとの数も出す
# 数の意味: match = 一致・mismatch = 不一致・absent = lower が下ろした式が表に無い（検査器の断片外）・skip = 比べない（不明の成分を含む・never・合成の節）
# check の経路（typer-sty）: same = exprSty と一致・gain = 表だけ分かる（exprSty は SUNK）・loss = exprSty だけ分かる・mismatch = 食い違い・
# skip = 比べない（型なしの定数・合成の節）・targs-same / targs-diff = ジェネリック関数の型引数（inferTs × 表の YTArgsOf）の一致 / 食い違い
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
# stage2 を直に呼ぶ（bin/sober は build のフラグを絞る — gates の $SOBER は見ない）。古ければ作り直す
scripts/stage2.sh > /dev/null
SOBER=./out/stage2/sober2
verbose=0
[ "${1:-}" = "-v" ] && verbose=1
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
: > "$tmp/mis"
: > "$tmp/abs"
: > "$tmp/absat"
tm=0; tx=0; ta=0; ts=0
run() {
    local e=$1 dir=$2
    if ! (cd "$dir" && ulimit -s unlimited && "$SOBER" build "$e" --typer-diff) > "$tmp/o" 2> "$tmp/err"; then
        [ $verbose = 1 ] && echo "$dir/$e: rejected: $(head -n 1 "$tmp/err")"
        return 0
    fi
    read -r _ m x a s < <(head -n 1 "$tmp/o" | tr '=' ' ' | awk '{print $1, $3, $5, $7, $9}')
    tm=$((tm + m)); tx=$((tx + x)); ta=$((ta + a)); ts=$((ts + s))
    [ $verbose = 1 ] && echo "$dir/$e: match=$m mismatch=$x absent=$a skip=$s"
    grep '^  absent kind=' "$tmp/o" >> "$tmp/abs" || true
    tail -n +2 "$tmp/o" | grep -v '^  absent kind=' | grep -v ' y=-' >> "$tmp/mis" || true
    tail -n +2 "$tmp/o" | grep ' y=-' >> "$tmp/absat" || true
}
# check の経路（desugar の exprSty × 表）: `sober check --typer-diff` の合計。loss（exprSty だけ分かる）と mismatch は位置つきで
csame=0; cgain=0; closs=0; cmis=0; cskip=0; ctsame=0; ctdiff=0
: > "$tmp/cmis"
runc() {
    local e=$1 dir=$2
    if ! (cd "$dir" && ulimit -s unlimited && "$SOBER" check "$e" --typer-diff) > "$tmp/o" 2> "$tmp/err"; then
        [ $verbose = 1 ] && echo "$dir/$e: check rejected: $(head -n 1 "$tmp/err")"
        return 0
    fi
    read -r a b c d f g h < <(head -n 1 "$tmp/o" | tr '=' ' ' | awk '{print $3, $5, $7, $9, $11, $13, $15}')
    csame=$((csame + a)); cgain=$((cgain + b)); closs=$((closs + c)); cmis=$((cmis + d)); cskip=$((cskip + f))
    ctsame=$((ctsame + g)); ctdiff=$((ctdiff + h))
    tail -n +2 "$tmp/o" >> "$tmp/cmis"
}
root=$(pwd)
SOBER=$(realpath "$SOBER")
for e in $(scripts/irtext.sh --list); do
    run "$e" "$root"
    runc "$e" "$root"
done
# 自己適用（compiler/ の import は compiler/ 相対 — std は compiler/std に写す）
w="$tmp/self"
mkdir -p "$w"
cp -r src/compiler "$w/compiler"
cp -r src/std "$w/compiler/std"
run app/main.sober "$w/compiler"
runc app/main.sober "$w/compiler"
echo "typer total: match=$tm mismatch=$tx absent=$ta skip=$ts"
echo "typer-sty total: same=$csame gain=$cgain loss=$closs mismatch=$cmis skip=$cskip targs-same=$ctsame targs-diff=$ctdiff"
if [ $verbose = 1 ] && [ -s "$tmp/cmis" ]; then
    echo "check-side loss / mismatch (先頭 80):"
    head -n 80 "$tmp/cmis"
fi
if [ $verbose = 1 ]; then
    echo "absent by node kind (src/compiler/ast/ast.sober の番号):"
    tr '=' ' ' < "$tmp/abs" | awk '{n[$3] += $5} END {for (k in n) print n[k], "kind", k}' | sort -rn
    echo "absent samples (y=-節の種類, t = lower の型の種類):"
    head -n 200 "$tmp/absat"
fi
# 1 件も突き合わせられなければ道具の故障（フラグの受け渡し・全 entry の拒否）
[ "$tm" -gt 0 ] && [ "$csame" -gt 0 ] && [ "$ctsame" -gt 0 ] || { echo "error: no expression was compared"; exit 1; }
# check の経路: 表が exprSty の分かることを全部分かって（loss 0）、食い違わない（mismatch 0）
# 型引数（inferTs × 表の YTArgsOf — C1 B3-3 の持ち越しの間の常設の照合）: 決まる / 決まらないと region を持たない型引数のコア型が一致
if [ "$closs" -gt 0 ] || [ "$cmis" -gt 0 ] || [ "$ctdiff" -gt 0 ]; then
    [ $verbose = 1 ] || head -n 40 "$tmp/cmis"
    exit 1
fi
if [ -s "$tmp/mis" ]; then
    echo "by kind (y = 表層型の種類, t = lower の型の種類):"
    awk '{print $2, $3}' "$tmp/mis" | sort | uniq -c | sort -rn
    awk '{print $2, $3}' "$tmp/mis" | sort -u | while read -r y t; do
        echo "-- $y $t:"
        grep " $y $t\$" "$tmp/mis" | head -n 5
    done
    exit 1
fi
