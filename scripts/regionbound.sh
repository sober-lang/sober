#!/usr/bin/env bash
# 脱糖器と lower の region 境界の一致（G2 — 掃除枠 B 2026-10-02）。irtext の対象の各 entry について
#   コア（stage2 の `check --core-json-expanded` — compiler/desugar。E2-S で上げない全部展開の形 — lower のパスなしと同じ粒度）の block の数 = IR（stage2 の `build --emit=ir` — compiler/lower。パスなし）の
#   関数の中の region.enter の数 − region.enter を持つ関数の数（関数入口の 1 つずつ）+ 1（コアの根の block = main の入口）
# を見る。脱糖器と lower は表層 AST から別々に region の境界を引くので、どちらかがブロックを数え落とす / 余分に囲むと数がずれる。
# ループ本体の反復の region（while の本体 — 宛先構築レーン M4 / M5）は両側から除く（総称の単相化で IR だけ複製される）。数はプログラム全体の合計（関数の対応はとらない — コアの Def と IR の関数は 1:1 でない）。@rt.* の関数は数えない。
# check が拒否する entry（コアが無い）と lower が拒否する entry は飛ばす（件数に出す）。
#
#   scripts/regionbound.sh [entry…]
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
STAGE2=${STAGE2:-./out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

one() {
    local w=${PAR_W:-$tmp} e=$1 cb ir
    "$STAGE2" check "$e" --core-json-expanded > "$w/c.json" 2> /dev/null || { echo "@@ skip"; return; }
    "$STAGE2" build "$e" --emit=ir -o "$w/p.ir" 2> /dev/null || { echo "@@ lskip"; return; }   # check ⊃ build の形は F 台帳と他のゲートが見る
    # ループ本体の反復の region（宛先構築レーン M4 / M5）は両側から除く — 総称関数の単相化で IR 側だけループが複製されるので数が合わない。
    # コア = while の本体の block・IR = ラベルの直後の region.enter（式ブロックと関数の入口の enter は必ず直前に region.depth がある）
    # 段 6 P3a: コアの scope は block と同じく region を 1 段開く（lower = task.Run の enter）。spawn の子の region は子の関数の入口（lower/task.sober の kid#N）
    # 数えるのは main の式から呼び出し（call / callm / fnref の f）で届く Def だけ — lower は届く関数しか下ろさない。読み込んだ std の届かない Def
    # （std/utf8 の内側の par の Scope 等 — 全プログラムに暗黙で読み込まれる）は IR に現れない（並列 1.0× 便）
    cb=$(jq '
        def calls: [.. | objects | select(.k == "call" or .k == "callm" or .k == "fnref") | .f] | unique;
        def reach($defs; $set): ($set | map($defs[.] | calls) | add // []) as $new | (($set + $new) | unique) as $s2
            | if ($s2 | length) == ($set | length) then $set else reach($defs; $s2) end;
        (.defs // []) as $defs | del(.defs) as $root | ([$root] + (reach($defs; ($root | calls)) | map($defs[.]))) as $live
        | [$live[] | .. | objects | select(.k == "block" or .k == "scope")] | length as $b
        | [$live[] | .. | objects | select(.k == "while") | .body | select(.k == "block")] | length as $wb
        | $b - $wb' "$w/c.json")
    ir=$(awk '/^func /{inf=1; rt=($2 ~ /^@rt\./); n=0; lab=0; next} /^}/{if(inf&&!rt){if(n>0) fe++; tot+=n}; inf=0} inf&&/^b[0-9]+:/{lab=1; next} inf&&/region\.enter/{if(!lab) n++} inf{lab=0} END{print tot - fe + 1}' "$w/p.ir")
    if [ "$cb" != "$ir" ]; then
        echo "FAIL: $e: core has $cb blocks, IR has $ir region boundaries (region.enter − function entries + 1)"
        echo "@@ fail"
        return
    fi
    echo "@@ ok"
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    for e in "$@"; do par_run one "$e"; done
else
    while IFS= read -r e; do par_run one "$e"; done < <(scripts/irtext.sh --list)
fi
par_wait > "$tmp/list"
grep -v '^@@ ' "$tmp/list" || true
ok=$(par_count ok "$tmp/list")
skip=$(par_count skip "$tmp/list")
lskip=$(par_count lskip "$tmp/list")
fail=$(par_count fail "$tmp/list")
echo "regionbound: $ok entries match, skip=$skip (check rejects) + $lskip (lower rejects), fail=$fail"
[ "$fail" = 0 ]
