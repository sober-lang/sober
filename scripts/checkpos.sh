#!/usr/bin/env bash
# checkpos（便 1 — 検査器の拒否の位置）: `sober check` が検査器の型の拒否（判定 JSON の ok:false）のときに stderr に出す位置の行
# （`sober: type error at <where>` — 落ちた節の出所。app/cmd_check.sober の rejLines）の網。題材 =
#   ① testdata/checkverdict の黄金のうち検査器の拒否（ok:false）の entry 全部
#   ② 変異: 受理する例題（.out 持ち）の 4 本に 1 本の本体の整数のリテラルを 1 か所 bool にしたもの（scripts/checkpos.ts）— 検査器で落ちたものだけ
# 赤: 検査器の拒否なのに位置の行が無い・位置が `(no source position)`・経路（一括 W1 / W8・1 本の道〔SOBER_DESUGAR_PAR=0〕・--split）で行が違う。
# 観測（赤にしない）: ② で位置の行が変異した行を指す割合・build も拒否する題材で build の `lower error` の位置と一致する割合。
#   scripts/checkpos.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
export SOBER_CACHE="" SOBER_BUILD_CACHE=0
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0 n=0 hit=0 nmut=0 bsame=0 bboth=0
# line <check の引数…> → stderr の位置の行（無ければ空）・判定が ok:false でなければ "-"
line() {
    local o e
    o=$("$@" 2> "$W/e")
    case "$o" in
        *'"ok":false'*) grep -m1 '^sober: type error' "$W/e" ;;
        *) echo - ;;
    esac
}
one() { # $1 = entry（ファイルかディレクトリ）・$2 = 変異した行（無ければ空）
    local e=$1 ml=${2:-} a b c d
    a=$(SOBER_WORKERS=1 line "$STAGE2" check "$e")
    [ "$a" = - ] && return 0
    n=$((n + 1))
    if [ -z "$a" ] || [ "${a#*no source position}" != "$a" ]; then
        echo "FAIL $e: checker rejection without a position (${a:-no line})"; fail=1; return 0
    fi
    b=$(SOBER_WORKERS=8 line "$STAGE2" check "$e")
    c=$(SOBER_WORKERS=1 SOBER_DESUGAR_PAR=0 line "$STAGE2" check "$e")
    d=$(SOBER_WORKERS=1 line "$STAGE2" check "$e" --split)
    if [ "$a" != "$b" ] || [ "$a" != "$c" ] || [ "$a" != "$d" ]; then
        echo "FAIL $e: positions differ by path: W1 [$a] W8 [$b] seq [$c] split [$d]"; fail=1
    fi
    if [ -n "$ml" ]; then
        nmut=$((nmut + 1))
        case "$a" in *":$ml:"*) hit=$((hit + 1)) ;; *) echo "  note: $e mutated line $ml, reported [$a]" ;; esac
    fi
    local bl
    bl=$("$STAGE2" build "$e" -o "$W/a.out" 2>&1 > /dev/null | grep -m1 '^sober: lower error at ' | sed 's/^sober: lower error at \([^ ]*\) .*/\1/')
    if [ -n "$bl" ]; then
        bboth=$((bboth + 1))
        [ "$a" = "sober: type error at $bl" ] && bsame=$((bsame + 1))
    fi
}
# ① 黄金の検査器の拒否（黄金の名前 = entry の / を _ に — 先頭から / に戻して実在する形を引く）
for g in testdata/checkverdict/*.txt; do
    grep -q '"ok":false' "$g" || continue
    k=$(basename "$g" .txt) e=""
    for pre in examples testdata/checkneg testdata/iface testdata; do
        p=${pre//\//_}_
        if [ "${k#"$p"}" != "$k" ] && [ -e "$pre/${k#"$p"}" ]; then e=$pre/${k#"$p"}; break; fi
    done
    [ -n "$e" ] || { echo "FAIL $g: cannot map the golden to an entry"; fail=1; continue; }
    one "$e"
done
# ② 変異
mkdir -p "$W/mut"
ls examples/*.out | sed 's/\.out$/.sober/' | awk 'NR % 4 == 1' | while read -r s; do [ -f "$s" ] && echo "$s"; done > "$W/src.list"
node scripts/checkpos.ts "$W/mut" $(cat "$W/src.list") > "$W/mut.list"
while read -r m ml; do
    one "$m" "$ml"
done < "$W/mut.list"
echo "checkpos: checker rejections $n (mutants $nmut — the position names the mutated line in $hit) · build also rejects $bboth — same position $bsame"
[ $fail = 0 ] && echo "checkpos: ok" || echo "checkpos: FAIL"
exit $fail
