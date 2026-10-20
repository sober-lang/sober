#!/usr/bin/env bash
# iterregion（反復の region の約束 — language.md「while の本体・文形 for の本体は反復ごとの region を持つ」と llight〔compiler/lower/rlight.sober の
# loopLightModule — 確保しない反復の enter を消す〕の網）: enter を消すかは観測に出ない（出力は同じ・メモリだけが積もる）ので、出力の照合
# （obs / optdiff）では外れても鳴らない（report-620 — routing の RSS 110.9 MB が行数に比例していた・m4 の形）。
#   ① 形: `--stop-after=llight --dump-ir` で main の反復の enter の残り（region.enter・軽い enter の呼び出し — 関数の入口の 1 つを含む）を数えて照合する
#      - iter_region_inner（routing の形 — 外の反復の確保が内側のループの後ろ）: 入口 + 外の反復 = 2（L1 — 本体の範囲が内側のループの頭で止まると 1）
#      - iter_region_outer_assign（logagg の形 — 外の反復の変数へ内側のループの中で代入）: 入口 + 行の反復 = 2（P1 — 外の反復の深度への写しを
#        語の反復の確保と数えると 3）
#   ② RSS: iter_region_inner を行数 N と 10N で走らせ、最大 RSS が比例しないこと（10N の RSS ≤ N の RSS + 1 MiB。比例すると +10 MB を超える）
#   ③ RSS: iter_region_inline_dest（inline 展開の本体の宛先構築 — report-689・std/http.ServeConn の形）も同じ形で（壊れると 2000 → 20000 で +2.3 MB）
#   ⑤ 形: inline_dest_direct（展開の宛先の直結 — report-693 / 694）— 展開の呼び出し点に呼び手の印があるとき、本体の印つきの確保は呼び手の宛先に作る。
#      `--stop-after=llight --dump-ir` の ranks で、region.enter の後に読んだ region.depth（展開入口の深度）を深度に使う region.alloc が 0 本であること
#      （展開入口に作る形 = 1 本 — 結果を呼び手の return でもう一度写す二重の写し。写しの有無は実行時の深度の比較なので relocate の数には出ない）
#   ⑥ RSS: task_spawn_discard（handle を捨てた子の枠は子の寿命 — report-696 / 697・net.Serve の accept のループの形）: 返らない scope で子を生み続けても
#      枠が scope の region に積もらないこと。W1（10N ≤ N + 1 MiB — 壊れると 20000 → 200000 で 3.0 → 31 MB）と W4（盗まれた子の枠が持ち主へ戻る道 —
#      生きている task の高水位がやや伸びるので 10N ≤ N + 4 MiB。壊れると 3.8 → 32 MB）
#   ⑦ RSS: task_spawn_discard_die（handle を捨てた子の死は枠を残さない — report-704 B / 705）: 返らない scope で捨てた子が死に続けても、記録に残るのは
#      (番号の最小, 死因) の 2 語だけ。W1 / W4 とも ⑥ と同じ余白（壊れると 20000 → 200000 で 5.0 → 50 MB — 1 死 ≈ 256 B の塊）
#   ⑧ RSS: lease_iter（ワーカー局所の lease — region-domain-pool.md 4d 節・report-719b）: 窓を n 回借りても置き場の区画は使い回され、窓の値は反復の
#      region に作られて積もらない（main の反復と子 task の反復）。W1 / W4 とも 10N ≤ N + 1 MiB
#   ④ RSS: iter_region_dest_reg（宛先の深度のレジスタ W_DEST の残り — report-692）も同じ形で（壊れると 2000 → 20000 で 7.9 → 80 MB）
#   ⑨ 形 + RSS: iter_region_nonret（戻らない関数は「確保しうる」に数えない — #8 report-725 / 726）: task のプログラムで、反復の本体の確保が
#      死ぬ道の panic の値（ラベル panic の冷たい関数 — binary.outOfRange）だけのループは enter が消える（入口 + 0 = 1。旧形 = 2 が負例 —
#      flate の longest / lazy の lloop ≈ 20 命令 / 反復の税）。RSS は N と 10N で比例しない（消した enter の region への漏れの番）
#   ⑩ 形 + RSS: iter_region_writer（入口で region を開く関数の自分の深度での呼び出しは「確保しうる」を伝えない — report-874）: 外の io.Writer へ
#      1 バイトずつ書く反復は enter が消え、反復の中で作る Writer の反復は残る（入口 + 1 = 2。旧形 = 3 が負例 — writerByteSlow の枠の空けを
#      数えて反復ごとに軽い enter）。RSS は N と 10N で比例しない（反復の中の Writer の枠が関数の region に積もらないこと）
#   ⑪ 形 + RSS: map_dest（map の宛先構築 — report-875・knucleotide の frequencies の形）: return に流れ着く `mut map[string]V{}` の空のヘッダは
#      呼び手の宛先の深度に作る — build / counts の最初の region.bump の深度が enter の後に読んだ region.depth（自分の深度）でないこと（旧形 = 自分の
#      深度に作って戻りでセル列を写す — 負例）。RSS は呼び手の反復の N と 10N で比例しない（宛先 = 呼び手の反復の region に積もらない）
#   scripts/iterregion.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
for want in iter_region_inner:2 iter_region_outer_assign:2 iter_region_nonret:1 iter_region_writer:2; do
    e=${want%%:*}; n=${want#*:}
    "$S2" build "examples/$e.sober" --emit=elf --passes --stop-after=llight --dump-ir -o "$W/$e.ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir $e"; fail=$((fail + 1)); continue; }
    got=$(awk '/^func @main.main\(/,/^}/' "$W/$e.ir" | grep -cE 'region\.enter$|call @rt\.region_enter')
    if [ "$got" != "$n" ]; then
        echo "FAIL: $e: main keeps $got region enters after llight (want $n)"
        fail=$((fail + 1))
    fi
done
"$S2" build examples/inline_dest_direct.sober --emit=elf --passes --stop-after=llight --dump-ir -o "$W/idd.ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir inline_dest_direct"; fail=$((fail + 1)); }
got=$(awk '/^func @main\.ranks\(/ { on = 1; ent = 0; n = 0; delete d; next }
    on && /^}/ { print n; on = 0 }
    on && /region\.enter$/ { ent = 1 }
    on && ent && /= region\.depth$/ { d[$1] = 1 }
    on && /= region\.alloc / { x = $4; sub(/,$/, "", x); if (x in d) n++ }' "$W/idd.ir")
if [ "$got" != "0" ]; then
    echo "FAIL: inline_dest_direct: ranks allocates the expansion result at the expansion entry depth ($got allocs — want 0: build it at the caller's destination)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_inner.sober -o "$W/inner" > /dev/null 2>&1 || { echo "FAIL: build iter_region_inner"; exit 1; }
/usr/bin/time -f %M -o "$W/r1" "$W/inner" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/r2" "$W/inner" 200000 > /dev/null || fail=$((fail + 1))
r1=$(cat "$W/r1"); r2=$(cat "$W/r2")
if [ "$r2" -gt $((r1 + 1024)) ]; then
    echo "FAIL: iter_region_inner: RSS grows with the iterations ($r1 KB at 20000 → $r2 KB at 200000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_inline_dest.sober -o "$W/idest" > /dev/null 2>&1 || { echo "FAIL: build iter_region_inline_dest"; exit 1; }
/usr/bin/time -f %M -o "$W/d1" "$W/idest" 2000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/d2" "$W/idest" 20000 > /dev/null || fail=$((fail + 1))
d1=$(cat "$W/d1"); d2=$(cat "$W/d2")
if [ "$d2" -gt $((d1 + 1024)) ]; then
    echo "FAIL: iter_region_inline_dest: RSS grows with the iterations ($d1 KB at 2000 → $d2 KB at 20000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_dest_reg.sober -o "$W/dreg" > /dev/null 2>&1 || { echo "FAIL: build iter_region_dest_reg"; exit 1; }
/usr/bin/time -f %M -o "$W/g1" "$W/dreg" 2000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/g2" "$W/dreg" 20000 > /dev/null || fail=$((fail + 1))
g1=$(cat "$W/g1"); g2=$(cat "$W/g2")
if [ "$g2" -gt $((g1 + 1024)) ]; then
    echo "FAIL: iter_region_dest_reg: RSS grows with the iterations ($g1 KB at 2000 → $g2 KB at 20000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_nonret.sober -o "$W/nonret" > /dev/null 2>&1 || { echo "FAIL: build iter_region_nonret"; exit 1; }
/usr/bin/time -f %M -o "$W/n1" "$W/nonret" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/n2" "$W/nonret" 200000 > /dev/null || fail=$((fail + 1))
n1=$(cat "$W/n1"); n2=$(cat "$W/n2")
if [ "$n2" -gt $((n1 + 1024)) ]; then
    echo "FAIL: iter_region_nonret: RSS grows with the iterations ($n1 KB at 20000 → $n2 KB at 200000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_writer.sober -o "$W/writer" > /dev/null 2>&1 || { echo "FAIL: build iter_region_writer"; exit 1; }
/usr/bin/time -f %M -o "$W/w1" "$W/writer" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/w2" "$W/writer" 200000 > /dev/null || fail=$((fail + 1))
w1=$(cat "$W/w1"); w2=$(cat "$W/w2")
if [ "$w2" -gt $((w1 + 1024)) ]; then
    echo "FAIL: iter_region_writer: RSS grows with the iterations ($w1 KB at 20000 → $w2 KB at 200000)"
    fail=$((fail + 1))
fi
"$S2" build examples/map_dest.sober --emit=elf --passes --stop-after=llight --dump-ir -o "$W/md.ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir map_dest"; fail=$((fail + 1)); }
for fn in build counts; do
    at=$(awk -v fn="$fn" '$0 ~ "^func @main\\." fn "\\(" { on = 1; ent = 0; delete d; next }
        on && /region\.enter$/ { ent = 1 }
        on && ent && /= region\.depth$/ { d[$1] = 1 }
        on && /= region\.bump / { x = $4; print (x in d) ? "own" : "dest"; exit }' "$W/md.ir")
    if [ "$at" != "dest" ]; then
        echo "FAIL: map_dest: $fn builds the returned map at its own depth ($at — want the caller's destination)"
        fail=$((fail + 1))
    fi
done
"$S2" build examples/map_dest.sober -o "$W/mdest" > /dev/null 2>&1 || { echo "FAIL: build map_dest"; exit 1; }
/usr/bin/time -f %M -o "$W/m1" "$W/mdest" 2000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/m2" "$W/mdest" 20000 > /dev/null || fail=$((fail + 1))
m1=$(cat "$W/m1"); m2=$(cat "$W/m2")
if [ "$m2" -gt $((m1 + 1024)) ]; then
    echo "FAIL: map_dest: RSS grows with the caller's iterations ($m1 KB at 2000 → $m2 KB at 20000)"
    fail=$((fail + 1))
fi
"$S2" build examples/task_spawn_discard.sober -o "$W/psd" > /dev/null 2>&1 || { echo "FAIL: build task_spawn_discard"; exit 1; }
for wm in 1:1024 4:4096; do
    w=${wm%%:*}; slack=${wm#*:}
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/p1" "$W/psd" 20000 > /dev/null || fail=$((fail + 1))
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/p2" "$W/psd" 200000 > /dev/null || fail=$((fail + 1))
    p1=$(cat "$W/p1"); p2=$(cat "$W/p2")
    if [ "$p2" -gt $((p1 + slack)) ]; then
        echo "FAIL: task_spawn_discard (W$w): RSS grows with the discarded children ($p1 KB at 20000 → $p2 KB at 200000)"
        fail=$((fail + 1))
    fi
    eval "pd$w=\"$p1 → $p2\""
done
"$S2" build examples/task_spawn_discard_die.sober -o "$W/psdd" > /dev/null 2>&1 || { echo "FAIL: build task_spawn_discard_die"; exit 1; }
for wm in 1:1024 4:4096; do
    w=${wm%%:*}; slack=${wm#*:}
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/q1" "$W/psdd" 20000 > /dev/null || fail=$((fail + 1))
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/q2" "$W/psdd" 200000 > /dev/null || fail=$((fail + 1))
    q1=$(cat "$W/q1"); q2=$(cat "$W/q2")
    if [ "$q2" -gt $((q1 + slack)) ]; then
        echo "FAIL: task_spawn_discard_die (W$w): RSS grows with the deaths of discarded children ($q1 KB at 20000 → $q2 KB at 200000)"
        fail=$((fail + 1))
    fi
    eval "pe$w=\"$q1 → $q2\""
done
"$S2" build examples/lease_iter.sober -o "$W/lsi" > /dev/null 2>&1 || { echo "FAIL: build lease_iter"; exit 1; }
for w in 1 4; do
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/l1" "$W/lsi" 2000 > /dev/null || fail=$((fail + 1))
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/l2" "$W/lsi" 20000 > /dev/null || fail=$((fail + 1))
    l1=$(cat "$W/l1"); l2=$(cat "$W/l2")
    if [ "$l2" -gt $((l1 + 1024)) ]; then
        echo "FAIL: lease_iter (W$w): RSS grows with the leases ($l1 KB at 2000 → $l2 KB at 20000)"
        fail=$((fail + 1))
    fi
    eval "pl$w=\"$l1 → $l2\""
done
echo "iterregion: 4 loop shapes (enters kept/removed after llight) + inline dest direct (entry-depth allocs ${got}) + RSS $r1 → $r2 KB at 10x iterations + nonret RSS $n1 → $n2 KB + writer RSS $w1 → $w2 KB + map dest RSS $m1 → $m2 KB + inline dest RSS $d1 → $d2 KB + dest reg RSS $g1 → $g2 KB + discarded spawn RSS W1 $pd1 / W4 $pd4 KB + discarded deaths RSS W1 $pe1 / W4 $pe4 KB + lease RSS W1 $pl1 / W4 $pl4 KB, fail=$fail"
[ "$fail" = 0 ]
