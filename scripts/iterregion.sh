#!/usr/bin/env bash
# iterregion（反復の region の約束 — language.md「while の本体・文形 for の本体は反復ごとの region を持つ」と llight〔compiler/lower/rlight.sober の
# loopLightModule — 確保しない反復のenterを消す〕の検査）: enterを消すかは観測に出ない（出力は同じ・メモリだけが積もる）ので、出力の照合
# （obs / optdiff）では外れても鳴らない（report-620 — routing の RSS 110.9 MB が行数に比例していた・m4 の形）。
#   ① 形: `--stop-after=llight --dump-ir` で main の反復の enter の残り（region.enter・軽い enter の呼び出し — 関数の入口の 1 つを含む）を数えて照合する
#      - iter_region_inner（routing の形 — 外の反復の確保が内側のループの後ろ）: 入口 + 外の反復 = 2（L1 — 本体の範囲が内側のループの頭で止まると 1）
#      - iter_region_outer_assign（logaggの形 — 外の反復の変数へ内側のループの中で代入）: 入口 + 行の反復 = 2（P1 — 外の反復の深度へのコピーを
#        ワードの反復の確保と数えると3）
#      - iter_region_errcont（失敗の戻りのパスだけで確保する呼び先の失敗をcatchして回すループ）: 入口 + 反復 = 2（失敗の辺が頭へ戻る —
#        失敗の辺がループの外へ出る形は数えない精密化〔rlight の llErrEdge〕の負例。RSS も N と 10N で比例しない — 壊すと 192 → 1536 KB）
#   ② RSS: iter_region_inner を行数 N と 10N で走らせ、最大 RSS が比例しないこと（10N の RSS ≤ N の RSS + 1 MiB。比例すると +10 MB を超える）
#   ③ RSS: iter_region_inline_dest（inline 展開の本体の宛先構築 — report-689・std/http.ServeConn の形）も同じ形で（壊れると 2000 → 20000 で +2.3 MB）
#   ⑤ 形: inline_dest_direct（展開の宛先の直結 — report-693 / 694）— 展開の呼び出し点に呼び手のフラグがあるとき、本体のフラグつきの確保は呼び手の宛先に作る。
#      `--stop-after=llight --dump-ir` の ranks で、region.enter の後に読んだ region.depth（展開入口の深度）を深度に使う region.alloc が 0 本であること
#      （展開入口に作る形 = 1本 — 結果を呼び手のreturnでもう一度コピーする二重のコピー。コピーの有無は実行時の深度の比較なのでrelocateの数には出ない）
#   ⑥ RSS: task_spawn_discard（handle を捨てた子の枠は子の寿命 — report-696 / 697・net.Serve の accept のループの形）: 返らない scope で子を生み続けても
#      枠がscopeのregionに積もらないこと。W1（10N ≤ N + 1 MiB — 壊れると20000 → 200000で3.0 → 31 MB）とW4（盗まれた子の枠が持ち主へ戻るパス —
#      生きている task の高水位がやや伸びるので 10N ≤ N + 4 MiB。壊れると 3.8 → 32 MB）。W1 / W4 とも RSS から未着手の子の積み残しを引いた残差で比べる（下の resid）
#   ⑦ RSS: task_spawn_discard_die（handle を捨てた子の死は枠を残さない — report-704 B / 705）: 返らない scope で捨てた子が死に続けても、記録に残るのは
#      (番号の最小, 死因) の2ワードだけ。W1 / W4とも ⑥ と同じ余白（壊れると20000 → 200000で5.0 → 50 MB — 1死 ≈ 256 Bのチャンク）
#   ⑧ RSS: lease_iter（ワーカー局所のlease — region-domain-pool.md 4d節・report-719b）: ウィンドウをn回借りても格納場所のエリアは使い回され、ウィンドウの値は反復の
#      region に作られて積もらない（main の反復と子 task の反復）。W1 / W4 とも 10N ≤ N + 1 MiB
#   ④ RSS: iter_region_dest_reg（宛先の深度のレジスタ W_DEST の残り — report-692）も同じ形で（壊れると 2000 → 20000 で 7.9 → 80 MB）
#   ⑨ 形 + RSS: iter_region_nonret（戻らない関数は「確保しうる」に数えない — #8 report-725 / 726）: task のプログラムで、反復の本体の確保が
#      死ぬパスのpanicの値（ラベルpanicの冷たい関数 — binary.outOfRange）だけのループはenterが消える（入口 + 0 = 1。旧形 = 2が負例 —
#      flate の longest / lazy の lloop ≈ 20 命令 / 反復の税）。RSS は N と 10N で比例しない（消した enter の region への漏れの番）
#   ⑫ RSS: iter_region_fnval_dest（関数値の呼び出しの宛先の深度のレジスタ — report-1006 a1 / a2・report-1007）: フラグのある関数値の呼び出しは呼び手の
#      宛先を書くので、関数値の呼び先（関数値として使われる名前付き関数・持ち上げたラムダ）は入口で読んで 0 に戻す。読まない呼び先が残すと ④ と同じ形で
#      反復ごとに外の region へ積もる（2000 → 20000 で 24 → 240 MB / ラムダの読みだけ外すと 8 → 80 MB — 負例は確認済み）。nested = 持ち上げたラムダの
#      本体の中で展開されるラムダ（フェーズ2のラムダのフラグは展開の本体では使わない — 使うと8 → 80 MB）。nores = 結果の無い持ち上げたラムダ（形: 末尾の式の
#      連結〔rt.cat8〕の深度が入口で読んだ region.depth = 呼び手の region でないこと — report-1008。反復の region があるので RSS には出ない）
#   ⑩ 形 + RSS: iter_region_writer（入口で region を開く関数の自分の深度での呼び出しは「確保しうる」を伝えない — report-874）: 外の io.Writer へ
#      1 バイトずつ書く反復は enter が消え、反復の中で作る Writer の反復は残る（入口 + 1 = 2。旧形 = 3 が負例 — writerByteSlow の枠の空けを
#      数えて反復ごとに軽い enter）。RSS は N と 10N で比例しない（反復の中の Writer の枠が関数の region に積もらないこと）
#   ⑪ 形 + RSS: map_dest（map の宛先構築 — report-875・knucleotide の frequencies の形）: return に流れ着く `mut map[string]V{}` の空のヘッダは
#      呼び手の宛先の深度に作る — build / counts の最初の region.bump の深度が enter の後に読んだ region.depth（自分の深度）でないこと（旧形 = 自分の
#      深度に作って戻りでセル列をコピーする — 負例）。RSSは呼び手の反復のNと10Nで比例しない（宛先 = 呼び手の反復のregionに積もらない）
#   ⑫ RSS: iter_region_rcell（関数型のmut仮引数へ渡す64語以上の集合値の束縛 — 旧 (α-L1) のregion置きのセル〔report-1068〕は2026-11-04に撤去し、
#      束縛は普通のセル〔フレームの枠〕）: RSS は N と 10N で比例しない（反復ごとの束縛が関数の region に積もらない）
#   ⑬ RSS: iter_region_reccons（再帰型の境界コピーの補助の作業域 — report-repr-1）: 反復を越えるconsのチェーンのコピーの作業スタックが
#      反復ごとに外のregionへ積もらないこと。チェーンは保持する値なので増分は節点の数に比例する — 20000 → 200000で節点あたり128 B以下
#      （壊れると 1.6 KB / 節点）
#   ⑮ RSS: iter_region_optcons（optの中身を通る再帰型 — フィールドは1セルの箱・report-repr2-2）: ⑬ と同じ形・同じ基準（箱のセルとコピーの作業域が反復ごとに積もらない）
#   ⑯ RSS: iter_region_domain_mut（mut の器を持つ domain の状態 — 本体はその場で書く）: 呼び出しを 10 倍にしても RSS は 1 MiB 以内
#   ⑭ RSS: dest_append_rec（宛先構築の返る列への追記 — loader/dest.soberのフラグ3・report-repr-2）: `ks = append(ks, mk(…))` の再帰で組む深さnのチェーンが
#      深さの数だけコピーされないこと — 90 → 900レベルで +16 MB以下（深度ごとのregionのページ ≈ 4 KB / レベルだけ。壊れると1.7 → 135 MB）
#   scripts/iterregion.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
for want in iter_region_inner:2 iter_region_outer_assign:2 iter_region_nonret:1 iter_region_writer:2 iter_region_errcont:2; do
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
"$S2" build examples/iter_region_rcell.sober -o "$W/rcell" > /dev/null 2>&1 || { echo "FAIL: build iter_region_rcell"; exit 1; }
/usr/bin/time -f %M -o "$W/c1" "$W/rcell" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/c2" "$W/rcell" 200000 > /dev/null || fail=$((fail + 1))
c1=$(cat "$W/c1"); c2=$(cat "$W/c2")
if [ "$c2" -gt $((c1 + 1024)) ]; then
    echo "FAIL: iter_region_rcell: RSS grows with the iterations ($c1 KB at 20000 → $c2 KB at 200000 — the region cell must go to the iteration's region)"
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
"$S2" build examples/iter_region_fnval_dest.sober --emit=elf --passes -o "$W/fvd" > /dev/null 2>&1 || { echo "FAIL: build iter_region_fnval_dest"; exit 1; }
/usr/bin/time -f %M -o "$W/v1" "$W/fvd" 2000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/v2" "$W/fvd" 20000 > /dev/null || fail=$((fail + 1))
v1=$(cat "$W/v1"); v2=$(cat "$W/v2")
if [ "$v2" -gt $((v1 + 1024)) ]; then
    echo "FAIL: iter_region_fnval_dest: RSS grows with the iterations ($v1 KB at 2000 → $v2 KB at 20000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_fnval_dest.sober --emit=elf --passes --stop-after=llight --dump-ir -o "$W/fvd.ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir iter_region_fnval_dest"; fail=$((fail + 1)); }
nr=$(awk '/^func / { fn = 0; pre = ""; ent = 0 }
    /^func @lambda#/ { fn = 1 }
    fn && !ent && /= region\.depth$/ && pre == "" { pre = $1 }
    fn && /region\.enter$/ { ent = 1 }
    fn && /call @main\.note\(/ { note = 1 }
    fn && pre != "" && /call @rt\.cat8\(/ { x = $0; if (index(x, pre ",") || index(x, pre ")")) bad++ }
    END { print (note ? bad + 0 : "none") }' "$W/fvd.ir")
if [ "$nr" != "0" ]; then
    echo "FAIL: iter_region_fnval_dest: the result-less lifted lambda builds its tail's concat at its entry depth ($nr — want 0: its own region)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_errcont.sober -o "$W/errcont" > /dev/null 2>&1 || { echo "FAIL: build iter_region_errcont"; exit 1; }
/usr/bin/time -f %M -o "$W/e1" "$W/errcont" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/e2" "$W/errcont" 200000 > /dev/null || fail=$((fail + 1))
e1=$(cat "$W/e1"); e2=$(cat "$W/e2")
if [ "$e2" -gt $((e1 + 1024)) ]; then
    echo "FAIL: iter_region_errcont: RSS grows with the caught failures ($e1 KB at 20000 → $e2 KB at 200000 — the error cells must go to the iteration's region)"
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
# ⑥⑦ の peak RSS は生きている task の数の最大（未着手の子の積み残し — 負荷で決まり上限が無い）に比例して伸びる: peak ≈ 600 KB + 4.3 KB × maxTasks。
# 基準は積み残しを引いた残差（peak − 4.3 KB × maxTasks — 題材が `ledger` の引数で印字）で比べる。残差は負荷・試行数に依らず一定で、枠の取りこぼしだけが伸ばす。
# 積み残しそのものは未着手の子の上限（ワーカーあたり 255 — language.md 11 節）で頭打ち: maxTasks ≤ W × 256 + 64（走っている task の分の余白）
resid() { local m; m=$(sed -n 's/^maxTasks //p' "$1.out"); echo $(( $(cat "$1") - ${m:-0} * 43 / 10 )); }
"$S2" build examples/task_spawn_discard.sober -o "$W/psd" > /dev/null 2>&1 || { echo "FAIL: build task_spawn_discard"; exit 1; }
for wm in 1:1024 4:4096; do
    w=${wm%%:*}; slack=${wm#*:}
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/p1" "$W/psd" 20000 ledger > "$W/p1.out" || fail=$((fail + 1))
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/p2" "$W/psd" 200000 ledger > "$W/p2.out" || fail=$((fail + 1))
    p1=$(resid "$W/p1"); p2=$(resid "$W/p2")
    mt=$(sed -n 's/^maxTasks //p' "$W/p2.out")
    if [ "${mt:-0}" -gt $((w * 256 + 64)) ]; then
        echo "FAIL: task_spawn_discard (W$w): unstarted children not bounded (maxTasks $mt > $w × 256 + 64)"
        fail=$((fail + 1))
    fi
    if [ "$p2" -gt $((p1 + slack)) ]; then
        echo "FAIL: task_spawn_discard (W$w): RSS grows with the discarded children (residual $p1 KB at 20000 → $p2 KB at 200000 — $(cat "$W/p1") / $(cat "$W/p2") KB peak)"
        fail=$((fail + 1))
    fi
    eval "pd$w=\"$p1 → $p2\""
done
"$S2" build examples/task_spawn_discard_die.sober -o "$W/psdd" > /dev/null 2>&1 || { echo "FAIL: build task_spawn_discard_die"; exit 1; }
for wm in 1:1024 4:4096; do
    w=${wm%%:*}; slack=${wm#*:}
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/q1" "$W/psdd" 20000 ledger > "$W/q1.out" || fail=$((fail + 1))
    SOBER_WORKERS=$w /usr/bin/time -f %M -o "$W/q2" "$W/psdd" 200000 ledger > "$W/q2.out" || fail=$((fail + 1))
    q1=$(resid "$W/q1"); q2=$(resid "$W/q2")
    mt=$(sed -n 's/^maxTasks //p' "$W/q2.out")
    if [ "${mt:-0}" -gt $((w * 256 + 64)) ]; then
        echo "FAIL: task_spawn_discard_die (W$w): unstarted children not bounded (maxTasks $mt > $w × 256 + 64)"
        fail=$((fail + 1))
    fi
    if [ "$q2" -gt $((q1 + slack)) ]; then
        echo "FAIL: task_spawn_discard_die (W$w): RSS grows with the deaths of discarded children (residual $q1 KB at 20000 → $q2 KB at 200000 — $(cat "$W/q1") / $(cat "$W/q2") KB peak)"
        fail=$((fail + 1))
    fi
    eval "pe$w=\"$q1 → $q2\""
done
"$S2" build examples/iter_region_reccons.sober -o "$W/rcons" > /dev/null 2>&1 || { echo "FAIL: build iter_region_reccons"; exit 1; }
/usr/bin/time -f %M -o "$W/k1" "$W/rcons" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/k2" "$W/rcons" 200000 > /dev/null || fail=$((fail + 1))
k1=$(cat "$W/k1"); k2=$(cat "$W/k2")
# 増分は節点の数に比例する（チェーンは保持する値）— 節点あたり128 B以下（180,000 節点 = 22,500 KB）
if [ "$k2" -gt $((k1 + 22500)) ]; then
    echo "FAIL: iter_region_reccons: RSS grows faster than the nodes ($k1 KB at 20000 → $k2 KB at 200000)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_optcons.sober -o "$W/ocons" > /dev/null 2>&1 || { echo "FAIL: build iter_region_optcons"; exit 1; }
/usr/bin/time -f %M -o "$W/o1" "$W/ocons" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/o2" "$W/ocons" 200000 > /dev/null || fail=$((fail + 1))
o1=$(cat "$W/o1"); o2=$(cat "$W/o2")
# ⑮ 箱のフィールド（next L?）のチェーンも ⑬ と同じ基準 — 節点あたり128 B以下
if [ "$o2" -gt $((o1 + 22500)) ]; then
    echo "FAIL: iter_region_optcons: RSS grows faster than the nodes ($o1 KB at 20000 → $o2 KB at 200000)"
    fail=$((fail + 1))
fi
"$S2" build examples/dest_append_rec.sober -o "$W/darec" > /dev/null 2>&1 || { echo "FAIL: build dest_append_rec"; exit 1; }
/usr/bin/time -f %M -o "$W/a1" "$W/darec" 90 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/a2" "$W/darec" 900 > /dev/null || fail=$((fail + 1))
a1=$(cat "$W/a1"); a2=$(cat "$W/a2")
# 深さに比例するのは深度ごとのregionのページだけ（≈ 4 KB / レベル）— 部分木を深さの数だけコピーすると2乗（90 → 900で +130 MB）
if [ "$a2" -gt $((a1 + 16384)) ]; then
    echo "FAIL: dest_append_rec: RSS grows with the square of the depth ($a1 KB at 90 → $a2 KB at 900)"
    fail=$((fail + 1))
fi
"$S2" build examples/iter_region_domain_mut.sober -o "$W/dmut" > /dev/null 2>&1 || { echo "FAIL: build iter_region_domain_mut"; exit 1; }
/usr/bin/time -f %M -o "$W/q1" "$W/dmut" 20000 > /dev/null || fail=$((fail + 1))
/usr/bin/time -f %M -o "$W/q2" "$W/dmut" 200000 > /dev/null || fail=$((fail + 1))
q1=$(cat "$W/q1"); q2=$(cat "$W/q2")
# ⑯ domain の状態の mut の器（その場で書く）は呼び出しごとに region を伸ばさない
if [ "$q2" -gt $((q1 + 1024)) ]; then
    echo "FAIL: iter_region_domain_mut: RSS grows with the calls ($q1 KB at 20000 → $q2 KB at 200000)"
    fail=$((fail + 1))
fi
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
echo "iterregion: 5 loop shapes (enters kept/removed after llight) + inline dest direct (entry-depth allocs ${got}) + RSS $r1 → $r2 KB at 10x iterations + caught errors RSS $e1 → $e2 KB + nonret RSS $n1 → $n2 KB + writer RSS $w1 → $w2 KB + map dest RSS $m1 → $m2 KB + region cell RSS $c1 → $c2 KB + inline dest RSS $d1 → $d2 KB + dest reg RSS $g1 → $g2 KB + fnval dest RSS $v1 → $v2 KB + discarded spawn residual RSS W1 $pd1 / W4 $pd4 KB + discarded deaths residual RSS W1 $pe1 / W4 $pe4 KB + lease RSS W1 $pl1 / W4 $pl4 KB + recursive cons RSS $k1 → $k2 KB + opt cons RSS $o1 → $o2 KB + dest append RSS $a1 → $a2 KB + domain mut state RSS $q1 → $q2 KB, fail=$fail"
[ "$fail" = 0 ]
