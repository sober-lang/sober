#!/usr/bin/env bash
# iterregion（反復の region の約束 — language.md「while の本体・文形 for の本体は反復ごとの region を持つ」と llight〔compiler/lower/rlight.sober の
# loopLightModule — 確保しない反復の enter を消す〕の網）: enter を消すかは観測に出ない（出力は同じ・メモリだけが積もる）ので、出力の照合
# （obs / optdiff）では外れても鳴らない（report-620 — routing の RSS 110.9 MB が行数に比例していた・m4 の形）。
#   ① 形: `--stop-after=llight --dump-ir` で main の反復の enter の残り（region.enter・軽い enter の呼び出し — 関数の入口の 1 つを含む）を数えて照合する
#      - iter_region_inner（routing の形 — 外の反復の確保が内側のループの後ろ）: 入口 + 外の反復 = 2（L1 — 本体の範囲が内側のループの頭で止まると 1）
#      - iter_region_outer_assign（logagg の形 — 外の反復の変数へ内側のループの中で代入）: 入口 + 行の反復 = 2（P1 — 外の反復の深度への写しを
#        語の反復の確保と数えると 3）
#   ② RSS: iter_region_inner を行数 N と 10N で走らせ、最大 RSS が比例しないこと（10N の RSS ≤ N の RSS + 1 MiB。比例すると +10 MB を超える）
#   scripts/iterregion.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
for want in iter_region_inner:2 iter_region_outer_assign:2; do
    e=${want%%:*}; n=${want#*:}
    "$S2" build "examples/$e.sober" --emit=elf --passes --stop-after=llight --dump-ir -o "$W/$e.ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir $e"; fail=$((fail + 1)); continue; }
    got=$(awk '/^func @main.main\(/,/^}/' "$W/$e.ir" | grep -cE 'region\.enter$|call @rt\.region_enter')
    if [ "$got" != "$n" ]; then
        echo "FAIL: $e: main keeps $got region enters after llight (want $n)"
        fail=$((fail + 1))
    fi
done
"$S2" build examples/iter_region_inner.sober -o "$W/inner" > /dev/null 2>&1 || { echo "FAIL: build iter_region_inner"; exit 1; }
/usr/bin/time -f %M -o "$W/r1" "$W/inner" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/r2" "$W/inner" 200000 > /dev/null || fail=$((fail + 1))
r1=$(cat "$W/r1"); r2=$(cat "$W/r2")
if [ "$r2" -gt $((r1 + 1024)) ]; then
    echo "FAIL: iter_region_inner: RSS grows with the iterations ($r1 KB at 20000 → $r2 KB at 200000)"
    fail=$((fail + 1))
fi
echo "iterregion: 2 loop shapes (enters kept after llight) + RSS $r1 → $r2 KB at 10x iterations, fail=$fail"
[ "$fail" = 0 ]
