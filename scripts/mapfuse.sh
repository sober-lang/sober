#!/usr/bin/env bash
# mapfuse（map の更新の引きの融合 — compiler/lower/mapfuse.sober・M16 ②）の網: `c := m[k]; m[k] = <c の式>` の引きが 1 回であることを、
# examples/map_update.sober を最適化のバックエンドの経路の IR（--stop-after=inline --dump-ir — cfgclean / mapfuse の後）に下ろして関数ごとの
# rt.map_find の呼び出しの数で照合する。融合は観測に出ない最適化なので、出力の照合（obs / optdiff）では外れても鳴らない — 2026-10-04 の宛先構築
# レーン M5（格納点の写しを引きの前に置いた）で黙って外れ、knucleotide の命令が 41.7 → 57.5 G に戻っていた退行への答え
#   scripts/mapfuse.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
E=examples/map_update.sober
"$S2" build "$E" --emit=elf --passes --stop-after=inline --dump-ir -o "$W/ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir $E"; exit 1; }
# 関数 → 期待する map_find の呼び出しの数（updVal / updCat の 2 は今の限界と保守側の拒否 — examples/map_update.sober の注記）
for want in updStr:1 updInt:1 updVal:2 updCat:2; do
    fn=${want%%:*}; n=${want#*:}
    got=$(awk "/^func @main.$fn\\(/,/^}/" "$W/ir" | grep -c 'call @rt.map_find')
    if [ "$got" != "$n" ]; then
        echo "FAIL: $fn: $got map_find calls (want $n)"
        fail=$((fail + 1))
    fi
done
echo "mapfuse: 4 update shapes in $E — map_find calls per function, fail=$fail"
[ "$fail" = 0 ]
