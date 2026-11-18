#!/usr/bin/env bash
# kindwit: 推論した kind が Def ごとに最小であることの立会い。
# examples の全部について `check --emit=kinddrops`（推論した kind の旗を 1 つ外し、含意する旗も外した列でコアの JSON を作り直す）を出させ、
# どの行も Lean の sober-check が拒否することを見る。std の総称関数は、名前ごとに届く例を 1 つ選んで --emit=kinddropsall から取る
# （例ごとに同じ Def を繰り返すと、入力が全体のコアの JSON × 例の数になる）。check が拒否する例は数えるだけ。
# 覆うもの: 型パラメータごとに、他の行を固定して旗を 1 つ外すと型付かない（行ごとの最小）。成分の全体の最小は覆わない。
# 受理の側（推論した kind で Lean が受理する）は corejson・leanbatch が見る。
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
export SOBER_CACHE="${SOBER_CACHE-}"
[ -x "$CHECK" ] || { echo "error: $CHECK not found (cd lean && lake build sober-check)"; exit 1; }
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/kd" "$tmp/kn"
# 1 周目: 例ごとに、その例の package の Def の行（std の Def は出さない）と、届く総称関数の名前（--emit=kinds）
ls examples/*.sober | xargs -P "${JOBS:-8}" -I{} sh -c '
    f={}; k=$(basename "$f" .sober)
    if "$1" check --emit=kinddrops "$f" > "$2/kd/$k.txt" 2> /dev/null; then
        "$1" check --emit=kinds "$f" 2> /dev/null | sed -n "s/^\(std\/[^:]*\):.*/\1/p" > "$2/kn/$k.txt"
    else
        rm -f "$2/kd/$k.txt"; echo "$f" >> "$2/skip.$$"
    fi
' _ "$STAGE2" "$tmp"
# 2 周目: std の総称関数の名前ごとに、届く例を 1 つ選んで（名前の順に貪欲に）、--emit=kinddropsall のその名前の行だけを使う
for f in "$tmp"/kn/*.txt; do k=$(basename "$f" .txt); sed "s/^/$k /" "$f"; done | sort -k2 -s | awk '!seen[$2]++' > "$tmp/stdpick"
mkdir -p "$tmp/kda"
cut -d' ' -f1 "$tmp/stdpick" | sort -u | xargs -P "${JOBS:-8}" -I{} sh -c '
    k={}
    "$1" check --emit=kinddropsall "examples/$k.sober" 2> /dev/null | awk -v want="$(awk -v k="$k" "\$1 == k { print \$2 }" "$2/stdpick" | tr "\n" " ")" "
        BEGIN { n = split(want, w, \" \"); for (i = 1; i <= n; i++) ok[w[i]] = 1 }
        NF > 0 && (\$4 in ok)" > "$2/kda/$k.txt"
' _ "$STAGE2" "$tmp"

# 行 = 「<例> <Def> <型パラメータ> <旗> <package.名前>」と JSON を別のファイルへ（同じ順）
: > "$tmp/keys"
: > "$tmp/in"
for f in "$tmp"/kd/*.txt "$tmp"/kda/*.txt; do
    [ -e "$f" ] || continue
    k=$(basename "$f" .txt)
    awk -v k="$k" -v keys="$tmp/keys" -v in_="$tmp/in" 'NF > 0 {
        print k, $1, $2, $3, $4 >> keys
        print substr($0, length($1 $2 $3 $4) + 5) >> in_
    }' "$f"
done
n=$(wc -l < "$tmp/keys")
"$CHECK" --batch < "$tmp/in" > "$tmp/out"
m=$(wc -l < "$tmp/out")
[ "$n" = "$m" ] || { echo "FAIL: sober-check returned $m verdicts for $n inputs"; exit 1; }
paste -d' ' "$tmp/keys" "$tmp/out" | grep '"ok":true' > "$tmp/acc"
skip=$(cat "$tmp"/skip.* 2> /dev/null | wc -l)
ex=$(cut -d' ' -f1 "$tmp/keys" | sort -u | wc -l)
nstd=$(wc -l < "$tmp/stdpick")
for fl in rf kf cov mf cf; do
    printf '%s=%s ' "$fl" "$(awk -v f="$fl" '$4 == f' "$tmp/keys" | wc -l)"
done
echo
if [ -s "$tmp/acc" ]; then
    echo "FAIL: Lean accepts a kind with a flag dropped (the inferred kind is not minimal for that row):"
    cut -d' ' -f1-5 "$tmp/acc" | head -20
    exit 1
fi
echo "kindwit: $n dropped kinds in $ex examples ($nstd std generic functions) all rejected by sober-check (skipped $skip examples that check rejects)"
