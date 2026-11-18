#!/usr/bin/env bash
# kindbuild: build と check が同じ kind を使い、同じ型引数を拒否すること。examples の全部について
#   1. kind の照合: `check --emit=kinds`（ソースから推論）≡ `check --emit=kindsl0`（std は焼き込みの @kind）、
#      かつ `build --emit=kinds`（build が使う kind）と名前の共通部分で同じ。3 つとも通る例だけを比べる。
#      build は L0 の package の総称関数の行を全部持ち、展開する関数の行を持たないので、行の集合は比べない
#   2. 拒否の照合: check か build のどちらかが KindArg で拒否する例では、両方の終了コードと標準エラーが同じ
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

ls examples/*.sober | xargs -P "${JOBS:-8}" -I{} sh -c '
    f={}; k=$(basename "$f" .sober); o=$2/$k
    "$1" check --emit=kinds "$f" > "$o.k" 2> /dev/null; echo $? > "$o.krc"
    "$1" check --emit=kindsl0 "$f" > "$o.l" 2> /dev/null; echo $? > "$o.lrc"
    "$1" build --emit=kinds "$f" -o "$o.b" 2> /dev/null; echo $? > "$o.brc"
    "$1" check "$f" > /dev/null 2> "$o.ce"; echo $? > "$o.crc"
    "$1" build "$f" -o "$o.exe" 2> "$o.be"; echo $? > "$o.berc"
    rm -f "$o.exe"
' _ "$STAGE2" "$tmp"

fail=0
cmp_n=0
common=0
konly=0
kind_n=0
for f in "$tmp"/*.krc; do
    o=${f%.krc}
    k=$(basename "$o")
    if [ "$(cat "$o.krc")" = 0 ] && [ "$(cat "$o.lrc")" = 0 ] && [ "$(cat "$o.brc")" = 0 ]; then
        cmp_n=$((cmp_n + 1))
        if ! cmp -s <(sort "$o.k") <(sort "$o.l"); then
            echo "FAIL $k: check --emit=kinds and --emit=kindsl0 differ"
            diff <(sort "$o.k") <(sort "$o.l") | head -n 6
            fail=$((fail + 1))
        fi
        # 名前ごとに: check の行と build の行（名前が両方にあるもの）
        bad=$(awk '{ i = index($0, ": "); n = substr($0, 1, i - 1); v = substr($0, i + 2) }
            FILENAME == ARGV[1] { b[n] = v; next }
            (n in b) { c++; if (b[n] != v) print n ": check " v " / build " b[n] }
            !(n in b) { o++ }
            END { print "#", c + 0, o + 0 }' "$o.b" "$o.k")
        common=$((common + $(echo "$bad" | awk '/^#/ { print $2 }')))
        konly=$((konly + $(echo "$bad" | awk '/^#/ { print $3 }')))
        if echo "$bad" | grep -qv '^#'; then
            echo "FAIL $k: check and build use different kinds"
            echo "$bad" | grep -v '^#' | head -n 6
            fail=$((fail + 1))
        fi
    fi
    if grep -q '(KindArg)' "$o.ce" "$o.be"; then
        kind_n=$((kind_n + 1))
        if [ "$(cat "$o.crc")" != "$(cat "$o.berc")" ] || ! cmp -s "$o.ce" "$o.be"; then
            echo "FAIL $k: check and build reject the type argument differently (exit $(cat "$o.crc") / $(cat "$o.berc"))"
            diff "$o.ce" "$o.be" | head -n 8
            fail=$((fail + 1))
        fi
    fi
done
echo "kindbuild: kinds compared in $cmp_n examples ($common rows in both check and build, $konly rows only in check), KindArg rejections compared in $kind_n examples, fail=$fail"
[ "$fail" = 0 ]
