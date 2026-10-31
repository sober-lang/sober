#!/usr/bin/env bash
# error 網羅 analyzer の動的オラクル（A2）: 「観測 ⊆ 導出」。
#
#   scripts/errtrace.sh [--no-self]
#
# 導出 = `sober check <entry> --errors-dump`（関数ごとの `fi=<関数の表の添字> tags=<タグの列 — T は TOP>`）。
# 観測 = 計装つきのビルド（stage2 の `build --emit=ir [--passes] --trace-errors` — error を返して出る関数の出口ごとに
# `#errtrace <添字> <タグ>`、error の switch の subject ごとに `#errsw <ファイル> <字句> <タグ>`）を実行した出力。
# 述語: 観測した (関数, タグ) ごとに導出のその関数の戻りの集合が、(switch, タグ) ごとにその switch の subject の集合 S が、タグか TOP を含む
# （戻りは R の、switch は仮引数 P・cause C・局所の合併の照合 — 片方だけでは analyzer の変異の半分を見逃す）。
# 導出は全経路の上界なので、実行されない経路の分だけ導出が広いのは正しい（逆向きの違反 = 導出の健全性の穴だけが FAIL）。
# 入力: examples/*.sober（.out を持つもの — 実行は obs と同じくリポのルートを cwd に）・testdata/*/app・testdata/pool/*・
# testdata/errtrace/*（このオラクル専用 — 欄・slice の要素・仮引数・cause を通る流れ。field / slice は check が def error の形 = build だけ通る）。
# 自己適用（--no-self で飛ばす）: compiler/ を計装つきで建て、その sober2 に負例（testdata/loader_neg・testdata/checkneg・
# 黄金の EXCLUDED の entry — 拒否の経路を踏む）と例の check / build を掛けて、compiler/ 自身の導出と照合する。
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
entries=()
for s in examples/*.sober; do [ -f "${s%.sober}.out" ] && entries+=("$s"); done
for d in testdata/*/app; do entries+=("$d"); done
for s in testdata/pool/*.sober testdata/errtrace/*.sober; do entries+=("$s"); done
for e in "${entries[@]}"; do
    n=$(echo "$e" | tr '/.' '__')
    "$S2" check "$e" --errors-dump > "$W/$n.dump" 2> /dev/null || continue
    "$S2" build "$e" --emit=ir --passes --trace-errors -o "$W/$n.ir" > /dev/null 2>&1 || continue
    # stage1 の IR の語彙を越える entry（float の段 — gatelib の beyond_stage1）は計装の実行を stage1 で建てられない — 飛ばす
    if beyond_stage1 "$W/$n.ir"; then beyond=$((beyond + 1)); continue; fi
    "$STAGE1" build "$W/$n.ir" -o "$W/$n.bin" > /dev/null 2>&1 || { echo "BUILD FAIL $e (stage1 backend)"; fail=1; continue; }
    timeout 20 "$W/$n.bin" > "$W/$n.trace" 2> /dev/null < /dev/null
    progs=$((progs + 1))
    judge "$W/$n.dump" "$W/$n.trace" "$e"
done
echo "errtrace: programs $progs (beyond the stage1 IR vocabulary: ${beyond:-0})"

# 2. 自己適用: 計装つきの compiler/ に負例と例を掛ける
if [ "$self" = 1 ]; then
    mkdir -p "$W/root"
    cp -r src/compiler/* "$W/root/"
    cp -r src/std "$W/root/std"
    (cd "$W/root" && ulimit -s unlimited && "$S2" check app --errors-dump > "$W/self.dump" 2> /dev/null) || { echo "errtrace: self dump FAIL"; exit 1; }
    # 計装つきの compiler/ は stage2 が実行ファイルまで建てる（段 6 P6-1 — compiler/ が std/task を使い、その IR は stage1 の語彙を越えた。以前は
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
    k=0
    for e in "${inputs[@]}"; do
        (ulimit -s unlimited; timeout 60 "$W/sober2t" check "$e" < /dev/null >> "$W/self.trace" 2> /dev/null)
        (ulimit -s unlimited; timeout 60 "$W/sober2t" build "$e" --emit=ir -o /dev/null < /dev/null >> "$W/self.trace" 2> /dev/null)
        k=$((k + 1))
    done
    judge "$W/self.dump" "$W/self.trace" "compiler (self, $k inputs)"
    echo "errtrace: self inputs $k, observation lines $(grep -a -c '^#err' "$W/self.trace" | tr -d ' ')"
fi
echo "errtrace: observations $obs (unmatched $nofn), fail=$fail"
exit $fail
