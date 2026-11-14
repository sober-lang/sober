#!/usr/bin/env bash
# 関数のエフェクトの動的オラクル（effect のマイルストーン 段階5a — language.md 12 節「関数のエフェクトの宣言」）: 「観測 ⊆ 導出」。
#
#   scripts/efftrace.sh
#
# 導出 = `sober check <entry> --effects-dump`（関数ごとの `fi=<添字> bits=<語の列>`）。観測 = 計装つきの実行ファイル（`build --emit=elf --passes --trace-effects`
# — 関数の入口 / 出口とエフェクトの葉の印字）をW1で走らせた出力。判定 = scripts/efftrace.ts（呼び出しのスタックを組み直し、葉をスタックの上の全部の関数に数える）。
# 導出は全経路の上界なので、走らない経路の分だけ導出が広いのは正しい（逆向き = 導出の健全性の穴だけが FAIL）。
# 入力: examples/*.sober（.out を持つもの — 実行は obs と同じくリポのルートを cwd に）・testdata/*/app。自己適用はしない（関数の出入りの全部を印字するので
# compiler/ の実行は出力が巨大 — errtraceと違い、葉の観測を関数の出口でまとめるバッファをrtに持たない形を選んだ・report-1084）
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
entries=()
for s in examples/*.sober; do [ -f "${s%.sober}.out" ] && entries+=("$s"); done
for d in testdata/*/app; do entries+=("$d"); done
fail=0
progs=0
judge_one() {
    local e=$1 n
    n=$(echo "$e" | tr '/.' '__')
    "$S2" check "$e" --effects-dump > "$W/$n.dump" 2> /dev/null || { : > "$W/$n.omit"; return 0; }
    # build が拒否する entry（testdata の .sobi だけの package 等 — 計装なしの build も同じ）は飛ばす。飛ばした entry は scripts/omit/efftrace.list と照合する
    "$S2" build "$e" --emit=elf --passes --trace-effects -o "$W/$n.bin" > /dev/null 2>&1 || { : > "$W/$n.omit"; return 0; }
    chmod +x "$W/$n.bin"
    timeout 20 "$W/$n.bin" > "$W/$n.trace" 2> /dev/null < /dev/null
    node --experimental-strip-types scripts/efftrace.ts "$W/$n.dump" "$W/$n.trace" "$e" > "$W/$n.res" 2>&1
}
J=${JOBS:-$(( $(nproc) / 2 ))}
for e in "${entries[@]}"; do
    judge_one "$e" &
    while [ "$(jobs -rp | wc -l)" -ge "$J" ]; do wait -n; done
done
wait
: > "$W/omitted"
printf '%s\n' "${entries[@]}" > "$W/tried"
for e in "${entries[@]}"; do
    n=$(echo "$e" | tr '/.' '__')
    [ -f "$W/$n.omit" ] && echo "$e" >> "$W/omitted"
    [ -f "$W/$n.res" ] || continue
    progs=$((progs + 1))
    grep '^VIOLATION' "$W/$n.res" && fail=1
done
leaves=$(cat "$W"/*.res 2> /dev/null | sed -n 's/.* leaves \([0-9]*\) .*/\1/p' | awk '{ s += $1 } END { print s + 0 }')
omit_judge efftrace scripts/omit/efftrace.list "$W/tried" "$W/omitted" || fail=1
echo "efftrace: programs $progs, leaves $leaves, fail=$fail"
exit $fail
