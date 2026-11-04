#!/usr/bin/env bash
# memcheck（メモリの上界の網）: `sober build --mem-report` の main.main の上界（H = region の論理バイト・S = スタック）と、
# rt の変異 39（`--rt-mutant=39`）の実測を照合する。実測 = region を捨てる点の手前と exit で Σ_深度 (bump − スロットの先頭) の最大を標本・
# main の前に main を呼ぶ rsp の下を模様で塗り、main が返った直後に最も低く書き換わった語を数える — stderr の `memhw <最大> <入口の Σ> <スタック>`。
# 比べるのは 最大 − 入口の Σ ≤ H と スタック ≤ S（上界が top なら見ない・スタック = -1 は数えていない道〔panic〕・塗りの上端より浅い使用は
# MEMCHECK_SFLOOR と読めるのでそれ以下は判定しない）。
# 題材と上界は黄金（testdata/memcheck/expect.txt — `<題材> H=<バイト|top> S=<バイト|top>`）: examples のうち H が数字で出るものの全部
# + testdata/memcheck/ の手組み（写し・反復の region — 上界が top でもよい: 変異が偽の数字を出したときに実測が越える網）。
# 上界の数字が動けば赤（rt / std の変更が上界の退行として見える）。数字の出る例が増えた・減ったときは --regen（減るのは解析か rt / std の退行 — 理由を確かめてから）。
#   scripts/memcheck.sh            照合（黄金 + 実測 ≤ 上界 + 緩さの分布）
#   scripts/memcheck.sh --regen    黄金を作り直す
#   scripts/memcheck.sh --mut      網の確かめ: 解析の変異 8 本（SOBER_MEMREP_MUT=1..8 — memrep.sober の mrMut）でそれぞれ少なくとも 1 題材が赤になること
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${STAGE2:-out/stage2/sober2}   # 開発の旗（--mem-report・--rt-mutant）は stage2 が直に受ける
case "$SOBER" in /*) ;; *) SOBER=$ROOT/$SOBER ;; esac
GOLD=testdata/memcheck/expect.txt
SFLOOR=${MEMCHECK_SFLOOR:-88}   # rt.stack_paint の塗りの上端（MH_UP + MH_MARGIN — panic.sober）
J=${MEMCHECK_J:-8}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1

# 上界: `<H> <S>`（main.main の行が無ければ `- -`）。$1 = 題材（.sober を除いたパス）
bounds() {
    "$SOBER" build "$1.sober" --mem-report 2> /dev/null | awk '
        $1 == "mem" && $2 == "main.main" { h = substr($3, 3) }
        $1 == "stack" && $2 == "main.main" { s = substr($3, 3) }
        END { print (h == "" ? "-" : h), (s == "" ? "-" : s) }'
}
# 実測: `<最大 − 入口の Σ> <スタック>`（memhw の行が無ければ `NA NA`）。$1 = 題材 $2 = 置き場
measure() {
    local d=$2 inp=/dev/null
    mkdir -p "$d"
    "$SOBER" build "$1.sober" --rt-mutant=39 -o "$d/x" > "$d/b" 2>&1 || { echo "BUILD BUILD"; return; }
    [ -f "$1.in" ] && inp=$1.in
    timeout -s KILL 60 "$d/x" > /dev/null 2> "$d/e" < "$inp"
    awk '$1 == "memhw" { r = ($2 - $3) " " $4 } END { print (r == "" ? "NA NA" : r) }' "$d/e"
}
# 判定: 空（ok）か理由。$1 = 題材 $2 = H $3 = S $4 = 実測の H $5 = 実測の S
judge() {
    [ "$4" = NA ] && { echo "no memhw line (the mutant build did not reach the exit or a panic)"; return; }
    [ "$4" = BUILD ] && { echo "the rt-mutant build failed"; return; }
    if [ "$2" != top ] && [ "$4" -gt "$2" ]; then echo "region high water $4 > H=$2"; return; fi
    if [ "$3" != top ] && [ "$5" != -1 ] && [ "$5" -gt "$SFLOOR" ] && [ "$5" -gt "$3" ]; then echo "stack $5 > S=$3"; fi
}
row() { echo "$1 $(bounds "$1")"; }
export -f bounds measure row; export SOBER W

if [ "${1:-}" = --regen ]; then
    mkdir -p "$(dirname "$GOLD")"
    for f in examples/*.out; do echo "examples/$(basename "$f" .out)"; done > "$W/ex"
    for f in testdata/memcheck/*.sober; do echo "${f%.sober}"; done > "$W/td"
    { xargs -P "$J" -I{} bash -c 'row {}' < "$W/ex" | awk '$2 ~ /^[0-9]+$/'
      xargs -P "$J" -I{} bash -c 'row {}' < "$W/td"; } | sort | awk '{ print $1, "H=" $2, "S=" $3 }' > "$GOLD"
    echo "memcheck: regen $(wc -l < "$GOLD") subjects ($(grep -c '^examples/' "$GOLD") of $(wc -l < "$W/ex") examples with .out + $(wc -l < "$W/td") in testdata/memcheck)"
    exit 0
fi

[ -s "$GOLD" ] || { echo "memcheck: FAIL missing $GOLD (scripts/memcheck.sh --regen)"; exit 1; }
awk '{ print $1 }' "$GOLD" > "$W/list"
# 実測は解析の変異と独立（同じ ELF）— 1 回だけ取る
xargs -P "$J" -I{} bash -c 'echo "{} $(measure {} "$W/m/{}")"' < "$W/list" | sort > "$W/meas"

if [ "${1:-}" = --mut ]; then
    fail=0
    for m in 1 2 3 4 5 6 7 8; do
        SOBER_MEMREP_MUT=$m xargs -P "$J" -I{} bash -c 'row {}' < "$W/list" | sort > "$W/b$m"
        red=0
        while read -r n h s mh ms; do
            [ -n "$(judge "$n" "$h" "$s" "$mh" "$ms")" ] && red=$((red + 1))
        done < <(join "$W/b$m" "$W/meas")
        if [ "$red" -gt 0 ]; then echo "ok: mutant $m caught by $red / $(wc -l < "$W/list") subjects"; else echo "FAIL: mutant $m survives"; fail=1; fi
    done
    exit $fail
fi

xargs -P "$J" -I{} bash -c 'row {}' < "$W/list" | sort > "$W/bnd"
fail=0
awk '{ print $1, substr($2, 3), substr($3, 3) }' "$GOLD" | sort > "$W/gold"
if ! cmp -s "$W/gold" "$W/bnd"; then
    echo "FAIL: the bounds moved from $GOLD (an analysis or rt / std change — --regen if intended):"
    diff "$W/gold" "$W/bnd" | grep '^[<>]' | head -20 | sed 's/^/    /'
    fail=1
fi
nh=0; tight=0; ns=0
while read -r n h s mh ms; do
    r=$(judge "$n" "$h" "$s" "$mh" "$ms")
    if [ -n "$r" ]; then echo "FAIL: $n: $r"; fail=1; continue; fi
    [ "$h" != top ] && [ "$mh" -gt 0 ] && { nh=$((nh + 1)); [ "$mh" = "$h" ] && tight=$((tight + 1)); echo "$h $mh" >> "$W/hr"; }
    [ "$s" != top ] && [ "$ms" -gt "$SFLOOR" ] && { ns=$((ns + 1)); echo "$s $ms" >> "$W/sr"; }
done < <(join "$W/bnd" "$W/meas")
# 緩さの分布（上界 / 実測 — 実測 0 と塗りの床以下の題材は除く）
ratio() { [ -s "$1" ] && awk '{ print $1 / $2 }' "$1" | sort -g | awk '{ a[NR] = $1 } END { printf "min %.2f median %.2f max %.2f", a[1], a[int((NR + 1) / 2)], a[NR] }'; }
echo "memcheck: $(wc -l < "$W/list") subjects, H measured > 0 in $nh (bound = measured in $tight; bound/measured $(ratio "$W/hr")), S measured in $ns ($(ratio "$W/sr")), fail=$fail"
exit $fail
