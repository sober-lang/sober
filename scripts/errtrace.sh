#!/usr/bin/env bash
# error 網羅 analyzer の動的オラクル（A2）: 「観測 ⊆ 導出」。
#
#   scripts/errtrace.sh [--no-self]
#
# 導出 = `sober check <entry> --errors-dump`（関数ごとの `fi=<関数の表の添字> tags=<タグの列 — T は TOP>`）。
# 観測 = 計装つきのビルド（stage2 の `build --emit=ir [--passes] --trace-errors` — error を返して出る関数の出口ごとに
# `#errtrace <添字> <タグ>`、error の switch の subject ごとに `#errsw <ファイル> <字句> <タグ>`）を実行した出力。
# 述語: 観測した (関数, タグ) ごとに導出のその関数の戻りの集合が、(switch, タグ) ごとにその switch の subject の集合 S が、タグか TOP を含む
# （戻りはRの、switchは仮引数P・cause C・局所の合併の照合 — 片方だけではanalyzerのミュータントの半分を見逃す）。
# 導出は全経路の上界なので、実行されない経路の分だけ導出が広いのは正しい（逆向きの違反 = 導出の健全性の穴だけが FAIL）。
# 入力: examples/*.sober（.out を持つもの — 実行は obs と同じくリポのルートを cwd に）・testdata/*/app・testdata/pool/*・
# testdata/errtrace/*（このオラクル専用 — フィールド・sliceの要素・仮引数・causeを通る流れ。field / sliceはcheckが def error の形 = buildだけ通る）。
# 自己適用（--no-selfで飛ばす）: compiler/ を計装つきでビルドし、そのsober2に負例（testdata/loader_neg・testdata/checkneg・
# ゴールデンのEXCLUDEDのentry — 拒否の経路を踏む）と例のcheck / buildを掛けて、compiler/ 自身の導出と照合する。
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
self=1
[ "${1:-}" = "--no-self" ] && self=0
fail=0
progs=0
beyond=0
obs=0
nofn=0

# judge <dump> <trace> <名前>: 観測を導出に照らす（違反は 1 行ずつ出して fail）
judge() {
    local dump=$1 trace=$2 name=$3
    declare -A tags=() stags=()
    local line fi t
    while read -r line; do
        fi=$(sed -n 's/.* fi=\([0-9]*\) tags=\([^ ]*\) .*/\1/p' <<< "$line")
        t=$(sed -n 's/.* fi=\([0-9]*\) tags=\([^ ]*\) .*/\2/p' <<< "$line")
        [ -n "$fi" ] && tags[$fi]=",$t,"
    done < <(grep ' errors .* fi=' "$dump")
    while read -r line; do
        fi=$(sed -n 's/.* switch at=\([0-9]*:[0-9]*\) tags=\([^ ]*\) .*/\1/p' <<< "$line")
        t=$(sed -n 's/.* switch at=\([0-9]*:[0-9]*\) tags=\([^ ]*\) .*/\2/p' <<< "$line")
        [ -n "$fi" ] && stags[$fi]=",$t,"
    done < <(grep ' switch at=' "$dump")
    local f tok
    while read -r _ f tok t; do
        obs=$((obs + 1))
        if [ -z "${stags[$f:$tok]+x}" ]; then
            nofn=$((nofn + 1))
            continue
        fi
        case "${stags[$f:$tok]}" in
            *",$t,"*|*",T,"*) ;;
            *) echo "VIOLATION $name: switch $f:$tok saw tag $t — derived S $(grep " switch at=$f:$tok " "$dump" | sed 's/.* S=//;s/ covered=.*//')"; fail=1 ;;
        esac
    done < <(grep -a '^#errsw ' "$trace" | sort -u)
    while read -r _ fi t; do
        obs=$((obs + 1))
        if [ -z "${tags[$fi]+x}" ]; then
            nofn=$((nofn + 1))
            continue
        fi
        case "${tags[$fi]}" in
            *",$t,"*|*",T,"*) ;;
            *) echo "VIOLATION $name: fn $fi returned tag $t — derived $(grep " fi=$fi " "$dump" | sed 's/.*errors //')"; fail=1 ;;
        esac
    done < <(grep -a '^#errtrace ' "$trace" | sort -u)
}

# 1. 例と testdata
# io_open_under は作業域が既にあるとき EEXIST を読み捨てる経路を踏む — 先に作っておき、観測を out/ の残りに依らせない
mkdir -p out/io_open_under
entries=()
for s in examples/*.sober; do [ -f "${s%.sober}.out" ] && entries+=("$s"); done
for d in testdata/*/app; do entries+=("$d"); done
for s in testdata/pool/*.sober testdata/errtrace/*.sober; do entries+=("$s"); done
# ビルドして走らせるフェーズはentryごとに独立（格納場所はentryごとに別名）なので $JOBS本ずつ並列に。照合（judge）と件数はentryの順に直列で
# （失敗の行の順と件数は直列のときと同じ）。フェーズの結果 = $W/<名>.st（prog / beyond / bfail。無ければcheckかbuildが落ちて飛ばしたentry）
runone() {
    local e=$1 n
    n=$(echo "$e" | tr '/.' '__')
    "$S2" check "$e" --errors-dump > "$W/$n.dump" 2> /dev/null || { echo omit > "$W/$n.st"; return 0; }
    "$S2" build "$e" --emit=ir --passes --trace-errors -o "$W/$n.ir" > /dev/null 2>&1 || { echo omit > "$W/$n.st"; return 0; }
    # stage1のIRの語彙を越えるentry（floatの段階 — gatelibのbeyond_stage1）は計装の実行をstage1でビルドできない — 飛ばす
    if beyond_stage1 "$W/$n.ir"; then echo beyond > "$W/$n.st"; return 0; fi
    "$STAGE1" build "$W/$n.ir" -o "$W/$n.bin" > /dev/null 2>&1 || { echo bfail > "$W/$n.st"; return 0; }
    timeout 20 "$W/$n.bin" > "$W/$n.trace" 2> /dev/null < /dev/null
    echo prog > "$W/$n.st"
}
par_init "$W"
for e in "${entries[@]}"; do par_run runone "$e"; done
par_wait
: > "$W/omitted"
printf '%s\n' "${entries[@]}" > "$W/tried"
for e in "${entries[@]}"; do
    n=$(echo "$e" | tr '/.' '__')
    case "$(cat "$W/$n.st" 2> /dev/null)" in
        omit) echo "$e" >> "$W/omitted" ;;
        beyond) beyond=$((beyond + 1)) ;;
        bfail) echo "BUILD FAIL $e (stage1 backend)"; fail=1 ;;
        prog) progs=$((progs + 1)); judge "$W/$n.dump" "$W/$n.trace" "$e" ;;
    esac
done
# check か build が失敗して飛ばした entry は、失敗してよい一覧と照合する（件数の減少に失敗が隠れない）
omit_judge errtrace scripts/omit/errtrace.list "$W/tried" "$W/omitted" || fail=1
echo "errtrace: programs $progs (beyond the stage1 IR vocabulary: ${beyond:-0})"

# 2. 自己適用: 計装つきの compiler/ に負例と例を掛ける
if [ "$self" = 1 ]; then
    mkdir -p "$W/root"
    cp -r src/compiler/* "$W/root/"
    cp -r src/std "$W/root/std"
    (cd "$W/root" && ulimit -s unlimited && "$S2" check app --errors-dump > "$W/self.dump" 2> /dev/null) || { echo "errtrace: self dump FAIL"; exit 1; }
    # 計装つきのcompiler/ はstage2が実行ファイルまでビルドする（段階6 P6-1 — compiler/ がstd/taskを使い、そのIRはstage1の語彙を越えた。以前は
    # IR テキスト → stage1 の build x.ir）
    (cd "$W/root" && "$S2" build app --emit=elf --passes --trace-errors -o "$W/sober2t") > /dev/null 2>&1 || { echo "errtrace: self build FAIL"; exit 1; }
    chmod +x "$W/sober2t"
    : > "$W/self.trace"
    inputs=()
    for d in testdata/loader_neg/*; do inputs+=("$d"); done
    for s in testdata/checkneg/*.sober; do inputs+=("$s"); done
    for x in testdata/corejson/EXCLUDED.txt testdata/irtext/EXCLUDED.txt; do
        [ -f "$x" ] && while read -r p _; do [ -e "$p" ] && inputs+=("$p"); done < <(grep -v '^#' "$x" | awk '{print $1}')
    done
    inputs+=("${entries[@]}")
    # 入力ごとに独立 — 観測は入力ごとのファイルに受けて入力の順に連ねる（judge は観測を sort -u で読むので、順は結果に効かない）
    selfone() {
        (ulimit -s unlimited; timeout 60 "$W/sober2t" check "$1" < /dev/null > "$PAR_W/t" 2> /dev/null)
        (ulimit -s unlimited; timeout 60 "$W/sober2t" build "$1" --emit=ir -o /dev/null < /dev/null >> "$PAR_W/t" 2> /dev/null)
        cat "$PAR_W/t"
    }
    par_init "$W/self"
    for e in "${inputs[@]}"; do par_run selfone "$e"; done
    par_wait >> "$W/self.trace"
    k=${#inputs[@]}
    judge "$W/self.dump" "$W/self.trace" "compiler (self, $k inputs)"
    echo "errtrace: self inputs $k, observation lines $(grep -a -c '^#err' "$W/self.trace" | tr -d ' ')"
fi
echo "errtrace: observations $obs (unmatched $nofn), fail=$fail"
exit $fail
