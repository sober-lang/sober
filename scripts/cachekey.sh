#!/usr/bin/env bash
# G-f0（3'' 第 2 段 C1）: 小分けの check のキャッシュの鍵（`check --split --cache-trace` — 鍵と当否を標準エラーへ）の照合。
#   1. 決定性: 多 package の entry（examples の import を持つもの + testdata/*/app）で 2 回回して鍵の列がバイト一致
#   2. 共有: 同じ std の package の鍵が entry をまたいで 1 つ（std の package の入力は entry に依らない — gates の中の共有の前提）
#   3. 変異（testdata/cachekey の写しの上で — leaf ← mid ← main・leaf に @embed）:
#      a. leaf の本体のコメントだけ → leaf の鍵だけ変わる（.sobi は不変 — 依存の項は .sobi の中身のハッシュ = 早期打ち切り）
#      b. leaf の関数本体の式 → leaf の鍵だけ変わる（非展開の関数の本体は .sobi に載らない）
#      c. leaf の公開関数の署名 → leaf・mid・main の全部が変わる
#      d. @embed のファイルの中身 → leaf の鍵が変わる・ファイルを足す（パターンの一致の集合）→ leaf の鍵が変わる
#      e. コンパイラの鍵（SOBER_SELF_KEY）→ 全部が変わる
#   4. 当否: 置き場（SOBER_CACHE）に鍵のファイルを置くとその package だけ hit
#   6. G-h（(c) — 視点の生の木を書き出しに使う形の網）: 小分けが置き場に書いた .sobi が、`sober iface`（ソースを読み直して書く経路）の .sobi と
#      バイト一致（多 package の entry 全部 + compiler/app — 判定のゲートでは下流が読まない部分の取り違えを捕まえられない）
#   5. G-g（C2 — 本当の置き場で）: 温の置き場で変異を当てたときの外れの集合 = 期待。本体の変異 → leaf だけ（早期打ち切り）・署名の変異 → leaf の
#      逆依存の閉包（題材の import 文から機械で出す — side は外れない）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
SELF=$(cat "$(dirname "$STAGE2")/.key" 2>/dev/null || echo none)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
# trace <cwd> <entry> [SOBER_SELF_KEY]: 鍵の列（`<path> <鍵>` — 当否は落とす）
trace() { ( cd "$1" && SOBER_SELF_KEY=${3:-$SELF} "$STAGE2" check "$2" --split --cache-trace 2>&1 >/dev/null | grep '^cache: ' | awk '{print $2, $3}' ); }

# 1・2
n=0
: > "$tmp/all"
for e in $( (grep -l '^import' examples/*.sober; ls -d testdata/*/app) | sort ); do
    "$STAGE2" check "$e" > /dev/null 2>&1 || continue
    a=$(trace "$ROOT" "$e")
    b=$(trace "$ROOT" "$e")
    [ "$a" = "$b" ] || bad "keys not deterministic: $e"
    echo "$a" | grep '^std/' >> "$tmp/all"
    n=$((n + 1))
done
multi=$(sort -u "$tmp/all" | awk '{print $1}' | uniq -d)
[ -z "$multi" ] || bad "std package with more than one key across entries: $multi"
nstd=$(sort -u "$tmp/all" | wc -l)

# 3
W=$tmp/w
fresh() { rm -rf "$W"; mkdir -p "$W/testdata"; cp -r testdata/cachekey "$W/testdata/cachekey"; }
keyof() { echo "$1" | awk -v p="$2" '$1 == p {print $2}'; }
E=testdata/cachekey/app
L=testdata/cachekey/leaf
M=testdata/cachekey/mid
fresh
base=$(trace "$W" "$E")
[ "$(echo "$base" | wc -l)" = 4 ] || bad "cachekey: expected 4 packages, got: $base"
# changed <変異後の鍵の列> <変わるべき package…>: 変わった集合が期待と一致するか
changed() {
    local after=$1 what=$2; shift 2
    local got="" p
    for p in "$L" "$M" testdata/cachekey/side main; do
        [ "$(keyof "$base" "$p")" = "$(keyof "$after" "$p")" ] || got="$got $p"
    done
    [ "$got" = " $*" ] || bad "cachekey $what: changed packages = [${got# }] (want [$*])"
}
fresh; sed -i 's|// Inc は 1 足す|// Inc は 1 足す（コメントだけの編集）|' "$W/$L/leaf.sober"
changed "$(trace "$W" "$E")" "comment" "$L"
fresh; sed -i 's|    return x + 1|    return 1 + x|' "$W/$L/leaf.sober"
changed "$(trace "$W" "$E")" "body" "$L"
fresh; sed -i 's|func Inc(x int) int {|func Inc(y int) int {|; s|    return x + 1|    return y + 1|' "$W/$L/leaf.sober"
changed "$(trace "$W" "$E")" "signature" "$L" "$M" main
fresh; echo "two" > "$W/$L/data/a.txt"
changed "$(trace "$W" "$E")" "embed content" "$L"
fresh; echo "three" > "$W/$L/data/b.txt"
changed "$(trace "$W" "$E")" "embed match set" "$L"
fresh
changed "$(trace "$W" "$E" other-compiler)" "compiler key" "$L" "$M" testdata/cachekey/side main

# 4（置き場の値は先頭の行の鍵・長さ・値のハッシュが合うものだけが当たり — 冷の run で書いた本物の値を mid の分だけ残す）
C=$tmp/cache
fresh
( cd "$W" && SOBER_SELF_KEY=$SELF SOBER_CACHE=$C "$STAGE2" check "$E" --split > /dev/null 2>&1 )
k=$(keyof "$base" "$M")
find "$C" -type f -not -name "$k" -delete
echo x > "$C/sobercache-1/${k:0:2}/$k.junk"
hits=$( ( cd "$W" && SOBER_SELF_KEY=$SELF SOBER_CACHE=$C "$STAGE2" check "$E" --split --cache-trace 2>&1 >/dev/null ) | awk '$4 == "hit" {print $2}')
[ "$hits" = "$M" ] || bad "cachekey hit: got [$hits] (want [$M])"
# 壊れた値（先頭の行は合うが中身を書き換え）は外れ — 計算し直して上書きされる
f=$(find "$C" -type f -name "$k")
sed -i '2,$ s/func/fonc/' "$f"
hits=$( ( cd "$W" && SOBER_SELF_KEY=$SELF SOBER_CACHE=$C "$STAGE2" check "$E" --split --cache-trace 2>&1 >/dev/null ) | awk '$4 == "hit" {print $2}')
echo "$hits" | grep -qx "$M" && bad "cachekey corrupted value: $M still hits"
grep -q fonc "$f" && bad "cachekey corrupted value was not overwritten"

# 5
# misses <cwd> <置き場>: 外れた package の列（trace の順）
misses() { ( cd "$1" && SOBER_SELF_KEY=$SELF SOBER_CACHE=$2 "$STAGE2" check "$E" --split --cache-trace 2>&1 >/dev/null ) | awk '$4 == "miss" {print $2}' | tr '\n' ' '; }
# rdeps <package>: 題材の中で <package> を推移的に import する package と自分（main は import の行で引く — 題材のパスは testdata/cachekey/<名前>）
rdeps() {
    local set=" $1 " grew=1 f p
    while [ $grew = 1 ]; do
        grew=0
        for f in "$W"/testdata/cachekey/*/*.sober; do
            p=$(dirname "${f#$W/}"); [ "$p" = testdata/cachekey/app ] && p=main
            case "$set" in *" $p "*) continue ;; esac
            for q in $set; do
                if grep -q "^import \"$q\"" "$f"; then set="$set$p "; grew=1; break; fi
            done
        done
    done
    echo "$set"
}
inorder() { local want=$1 p out=""; for p in $(echo "$base" | awk '{print $1}'); do case "$want" in *" $p "*) out="$out$p " ;; esac; done; echo "$out"; }
G=$tmp/gcache
fresh; misses "$W" "$G" > /dev/null
[ "$(misses "$W" "$G")" = "" ] || bad "G-g: warm run missed: $(misses "$W" "$G")"
sed -i 's|    return x + 1|    return 1 + x|' "$W/$L/leaf.sober"
got=$(misses "$W" "$G")
[ "$got" = "$L " ] || bad "G-g body: misses = [$got] (want [$L ])"
fresh; misses "$W" "$G" > /dev/null
sed -i 's|func Inc(x int) int {|func Inc(y int) int {|; s|    return x + 1|    return y + 1|' "$W/$L/leaf.sober"
got=$(misses "$W" "$G")
want=$(inorder "$(rdeps "$L")")
[ "$got" = "$want" ] || bad "G-g signature: misses = [$got] (want the reverse closure [$want])"
case "$want" in *testdata/cachekey/side*) bad "G-g: the reverse closure should not contain side" ;; esac

# 6
H=$tmp/h
nh=0
sobicmp() { # $1 = cwd・$2 = entry
    rm -rf "$H"; mkdir -p "$H"
    ( cd "$1" && SOBER_SELF_KEY=$SELF SOBER_CACHE=$H/c "$STAGE2" check "$2" --split > /dev/null 2>&1 ) || return 0
    ( cd "$1" && "$ROOT/bin/sober" iface "$2" -o "$H/i" > /dev/null 2>&1 ) || { bad "G-h: iface failed: $2"; return 0; }
    local f g found
    for f in $(find "$H/c" -type f); do
        tail -c +$(( $(head -1 "$f" | wc -c) + 1 )) "$f" > "$H/v"
        head -1 "$H/v" | grep -q '^// sobi 1' || continue
        nh=$((nh + 1)); found=0
        for g in $(find "$H/i" -name '*.sobi'); do cmp -s "$H/v" "$g" && { found=1; break; }; done
        [ $found = 1 ] || bad "G-h: $2: split-written .sobi differs from iface ($(sed -n 2p "$H/v"))"
    done
}
for e in $( (grep -l '^import "[^s]' examples/*.sober; ls -d testdata/*/app) | sort -u ); do sobicmp "$ROOT" "$e"; done
mkdir -p "$tmp/self"; cp -r src/compiler "$tmp/self/compiler"; cp -r src/std "$tmp/self/compiler/std"
ulimit -s unlimited
sobicmp "$tmp/self/compiler" app/main.sober

echo "cachekey: $n entries deterministic, $nstd std package keys shared across entries, mutations 6 + hit 1, G-g miss sets 3, G-h $nh .sobi equal to iface, fail=$fail"
[ "$fail" = 0 ]
