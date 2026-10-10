#!/usr/bin/env bash
# task の罠の単体の網（段 6 P3a-2a — compiler/lower/trap.sober・docs/ir.md「罠」）: `sober build --trap-probe` は入口が main の代わりに
# trap.probe を呼ぶ（子 = 戻る・index の死〔101〕・region の死〔102〕・ゼロ除算・罠の入れ子・深い再帰の中の死・罠を跨ぐ値・最後に罠の外の死）。
#   1. 3 つの経路（--passes〔SOBER_VERIFY=each — 段ごとの IR の検証器〕・既定〔パスなし〕・--no-opt）で建てて実行し、stdout / 終了コード / stderr を
#      期待値 testdata/trapprobe/expected.{out,exit,stderr} と照合（3 経路が同じ観測 — optdiff の流儀）
#   2. lower 直後の IR テキストを黄金 testdata/trapprobe/probe.ir と照合（trap / unwind の印字の形 — irtext の流儀）
#   3. その IR テキストが stage1 の語彙の外（gatelib の beyond_stage1）と判定されること（罠のモジュールは stage1 の照合から外れる）
#   scripts/trapprobe.sh --regen    期待値と黄金を作り直す（意図した変更の後だけ — 差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
S2=${STAGE2:-out/stage2/sober2}
D=testdata/trapprobe
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = "--regen" ] && regen=1
fail=0
"$S2" build "$D/main.sober" --emit=ir --trap-probe -o "$W/probe.ir" || { echo "FAIL: --emit=ir --trap-probe"; exit 1; }
if [ $regen = 1 ]; then cp "$W/probe.ir" "$D/probe.ir"; fi
cmp -s "$W/probe.ir" "$D/probe.ir" || { echo "FAIL: IR text differs from $D/probe.ir"; diff "$D/probe.ir" "$W/probe.ir" | head -8; fail=1; }
beyond_stage1 "$W/probe.ir" || { echo "FAIL: beyond_stage1 does not recognize trap / unwind"; fail=1; }
for m in passes plain noopt; do
    case $m in
        passes) SOBER_VERIFY=each "$S2" build "$D/main.sober" --emit=elf --passes --trap-probe -o "$W/p.$m" ;;
        plain) "$S2" build "$D/main.sober" --emit=elf --trap-probe -o "$W/p.$m" ;;
        noopt) "$S2" build "$D/main.sober" --emit=elf --no-opt --trap-probe -o "$W/p.$m" ;;
    esac || { echo "FAIL: build ($m)"; fail=1; continue; }
    chmod +x "$W/p.$m"
    ec=0
    "$W/p.$m" > "$W/o.$m" 2> "$W/e.$m" || ec=$?
    echo "$ec" > "$W/x.$m"
    if [ $regen = 1 ] && [ $m = passes ]; then
        cp "$W/o.$m" "$D/expected.out"; cp "$W/x.$m" "$D/expected.exit"; cp "$W/e.$m" "$D/expected.stderr"
    fi
    for k in out:o exit:x stderr:e; do
        if ! cmp -s "$W/${k#*:}.$m" "$D/expected.${k%%:*}"; then
            echo "FAIL: $m: ${k%%:*} differs from $D/expected.${k%%:*}"; diff "$D/expected.${k%%:*}" "$W/${k#*:}.$m" | head -6; fail=1
        fi
    done
done
echo "trapprobe: 3 paths (passes / plain / no-opt) + IR text, fail=$fail"
[ "$fail" = 0 ]
