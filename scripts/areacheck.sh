#!/usr/bin/env bash
# areacheck: 接続のtaskのエリア（language.md 11 節 — 本体より下のスタックはワーカーのエリア・止まると所有エリアと交換）の保存則の検査。
# testdata/areacheck/srv.soberの接続のtaskに4つのパス（普通に返る・ディープスリープの後に返る・panicで死ぬ・Serveの期限でスリープしたまま捨てられる）を
# 踏ませ、相ごとにscripts/areacheck.tsが外から全チャンクのTC_AREAと全ワーカーのWK_AREAを読んで見る:
#   (1) 所有エリアの多重集合 = チャンクのスタックの領域の全部 ∪ ワーカーのエリアの全部（数 = チャンクの数 + W・重複なし・持ち主のないエリアなし）
#   (2) チャンクの退避rspは持つエリアの中（自分の領域を持つときだけページ0も）
#   シャロースリープ（受けでスリープする接続 — 交換せず退避も持たない: TCBのワード0は本体の戻り先）は退避rspの照合から外し、その数（shallow）を数える
# 交換が起きていること（所有エリアが自分でないチャンク > 0）とarea_far = 0も。遠いパスの1行 = ミュータント60（全関数の枠 +512 B — 本体がページ0に入らず
# 所有エリアの上の連続の形）で (1)(2) が保たれ交換0・area_far > 0。
# 本体の太い題材（srvのfar — 本体の枠がページ0の余白に入らず遠いパスを通る）の行: スリープしている接続の「常駐のスタックのページ」の型の集合（parked /
# deep-wait / after-deep-waitの相）が、エリアを使わないELF（ミュータント66 — 段1の前のスタックの形）と一致する（遠いパスは所有エリアが自分の領域ならその場で連続）。
# ディープスリープの後の受け（所有エリアとワーカーのエリアを交換してからシャロースリープする — LedgerのparkSwap > 0）ともう一度のディープスリープ（deep-againの相）も踏む。
# エリアの予約ページ（task.sober）: シャロースリープしているtaskの予約ページの深度は全部空（相ごとに退避の対を外から読む）・ディープスリープする /holdとシャロースリープしてウェイクアップする /okが同じ
# ワーカーで混ざっても /holdはスリープする前のpathを返す・途中のリクエストを持って待つ接続はディープスリープする（parkDeepWin > 0 — splitの相）。
# 毎回、ミュータント62（出口形を外す）・63 / 64（交換のtaskの側だけ / ワーカーの側だけ）・65（遠いパスでいつも所有エリアの頂上へ付け替える — ページ0の余白が空いて
# スリープしている接続のスタックのページが1枚増える）・67（シャロースリープの記しを付けない — シャロースリープするチャンク0）・68（完了でレジスタを読み戻さない）・70（交換してシャロースリープしたのに
# ワーカーのエリアの上のフラグを立てない）・71（本体がページ0にあるフラグを見ない — 遠いパスの本体もシャロースリープする）・72（ウェイクアップしたシャロースリープを期限のチェーンから外さない —
# Serveの期限でスリープしたままウェイクアップされるパス）・74（ウェイクアップされた本体に誤りを返す — 完了の値が本体に届く証）・78（エリアの予約ページの中身を見ずにシャロースリープする）・
# 79（中身の判定からフィールドr = 0〔途中のリクエストを持つ深度〕を抜く）・80（ウェイクアップした点で予約ページの深度を付け替えない）・81（予約ページから小さいスロットへ移した深度も予約ページの始まりで空を比べる — 大きい本文の後に毎回ディープスリープする）が落ち、73（ウェイクアップされたをいつも見直し〔2〕に —
# 本体がもう一度rt.netwaitを呼ぶパス）が保存則と答えを保つことを確認する
# 行の無いパス: 同じrt.netwaitの呼び出しの中でディープスリープした後の再park — 記しつきのparkはAREA_NEARなら必ず浅く、NEARは本体の入口で立ててtaskの間
# 消えないのでウェイクアップしない（記しつきでディープスリープするのは遠いパスだけで、それは浅くならない）。別のワーカーでの完了 — 走り始めたtaskはTC_WORKERに固定でウェイクアップも持ち主へ
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
SRC=testdata/areacheck/srv.sober
MS="0 60 62 63 64 65 66 67 68 70 71 72 73 74 78 79 80 81"
for m in $MS; do
    (
        a=(); [ $m != 0 ] && a=(--rt-mutant=$m)
        "$S2" build $SRC "${a[@]}" -o "$W/srv$m" > "$W/b$m.log" 2>&1 &&
            SOBER_SYMS_MN=1 "$S2" build $SRC "${a[@]}" --emit=syms -o "$W/syms$m" >> "$W/b$m.log" 2>&1 || echo fail > "$W/bfail$m"
    ) &
done
wait
for m in $MS; do
    [ -e "$W/bfail$m" ] && { echo "areacheck: FAIL build m$m ($(head -c 200 "$W/b$m.log"))"; exit 1; }
done
run() { AC_SERVE_MS=4000 AC_HOLD_MS=1500 timeout 60 node scripts/areacheck.ts "$W/srv$1" "$W/syms$1" > "$W/r$1" 2>&1; tail -1 "$W/r$1"; }
fail=0
r=$(run 0)
sw=$(sed -n 's/^areacheck-ok swapped-max \([0-9]*\) shallow-max \([0-9]*\) area_far \([0-9]*\) parkswap \([0-9]*\) awin \([0-9]*\) deepwin \([0-9]*\)$/\1 \2 \3 \4 \5 \6/p' <<< "$r")
read -r swm shm afm psw awm pdw <<< "$sw"
if [ -z "$sw" ]; then
    echo "areacheck: FAIL — $r"; sed 's/^/  /' "$W/r0" | head -12; fail=1
elif [ "$swm" -eq 0 ] || [ "$shm" -eq 0 ] || [ "$psw" -eq 0 ] || [ "$afm" != 0 ] || [ "$awm" -eq 0 ] || [ "$pdw" -eq 0 ]; then
    echo "areacheck: FAIL — swapped-max $swm · shallow-max $shm · parkSwap $psw (all must be > 0) · area_far $afm ≠ 0: the connection tasks did not run in the area form, never slept shallow, never swapped before a shallow park, never used the area window (awin $awm) or never parked deep for a partial request in it (parkDeepWin $pdw)"; fail=1
fi
# ミュータント73 = シャロースリープからウェイクアップされた本体にいつも見直し（2）を返す（本体がもう一度rt.netwaitを呼ぶパス — 保存則も答えも保つ）・74 = 同じ点で誤りを返す（落ちる — 73がその値のパスを踏む証）
r73=$(run 73)
if [[ "$r73" =~ ^areacheck-ok\ swapped-max\ [0-9]+\ shallow-max\ [1-9] ]]; then :; else echo "areacheck: FAIL — the recheck path (mutant 73) broke: $r73"; fail=1; fi
# ミュータント67 = シャロースリープの記しを付けない（受けもディープスリープ — シャロースリープするチャンク0）
r67=$(run 67)
if [[ "$r67" =~ ^areacheck-ok\ swapped-max\ [0-9]+\ shallow-max\ 0\  ]] || [[ "$r67" == areacheck-bad* ]]; then echo "areacheck: m67 caught ($r67)" | cut -c1-160; else echo "areacheck: FAIL — mutant 67 was not caught ($r67)"; fail=1; fi
r60=$(run 60)
if [[ "$r60" =~ ^areacheck-ok\ swapped-max\ 0\ shallow-max\ 0\ area_far\ [1-9] ]]; then :; else
    echo "areacheck: FAIL — the far path (mutant 60) broke conservation or still swapped: $r60"; fail=1
fi
for m in 62 63 64 68 70 72 74 78 79 80 81; do
    rm=$(run $m)
    if [[ "$rm" == areacheck-bad* ]]; then echo "areacheck: m$m caught (${rm#areacheck-bad }" | cut -c1-160 | sed 's/$/…)/'; else echo "areacheck: FAIL — mutant $m was not caught ($rm)"; fail=1; fi
done
# 遠いパスの題材: 署名が段1の前（ミュータント66）と一致・ミュータント65で違う
# 相ごとの「常駐のページ」の型の集合（スタックのページ — ページ0から下だけ。頭のページ〔チャンクの予約ページ・エリアの予約ページ〕はエリアの予約ページの段で変わるので見ない。スタックの深さと数は見ない: 受けの待ちは本体のrt.netwaitの点でスリープするのでエリアを使わない形〔read_fdの中でスリープする〕より浅く、
# 各ワーカーが最後に走らせたtask〔そのスタックの上で次を待つ〕のワード0はシャロースリープの記しの戻り先のことがある）
sigs() { AC_FAR=1 AC_REF=${2:-0} AC_SERVE_MS=4000 AC_HOLD_MS=1500 timeout 60 node scripts/areacheck.ts "$W/srv$1" "$W/syms$1" > "$W/f$1" 2>&1
    grep -E '^sig (parked|deep-wait|after-deep-wait) ' "$W/f$1" | while read -r _ ph rest; do echo "$ph $(tr ' ' '\n' <<< "$rest" | sed 's/^[0-9]*×\[[0-9]*:/[/; s/,[1-9][0-9]*//g' | sort -u | tr '\n' ' ')"; done; }
fs0=$(sigs 0); fr=$(tail -1 "$W/f0")
fs66=$(sigs 66 1)
fs65=$(sigs 65)
if [[ "$fr" != areacheck-ok\ swapped-max\ 0\ shallow-max\ 0\ area_far\ [1-9]* ]]; then
    echo "areacheck: FAIL — far body: $fr"; fail=1
elif [ -z "$fs0" ] || [ "$fs0" != "$fs66" ]; then
    echo "areacheck: FAIL — far body: the sleeping connections' resident stack pages differs from the pre-area form (mutant 66)"; diff <(echo "$fs66") <(echo "$fs0") | sed 's/^/  /'; fail=1
fi
# ミュータント71 = AREA_NEARを見ない（遠いパスの本体もシャロースリープして、所有エリアの上にあった本体の枠を失う）
r71=$(AC_FAR=1 run 71)
if [[ "$r71" == areacheck-bad* ]]; then echo "areacheck: m71 caught (far body: ${r71#areacheck-bad }" | cut -c1-160 | sed 's/$/…)/'; else echo "areacheck: FAIL — mutant 71 was not caught ($r71)"; fail=1; fi
if [ -n "$fs65" ] && [ "$fs65" != "$fs66" ]; then echo "areacheck: m65 caught (far body: $(sed -n 's/^parked //p' <<< "$fs65") vs $(sed -n 's/^parked //p' <<< "$fs66"))"; else echo "areacheck: FAIL — mutant 65 was not caught"; fail=1; fi
# エリアの予約ページの答え（examples/net_area_window — シャロースリープする /ok・ディープスリープしてpathを返す /hold・途中のリクエストを持って待つ接続が同じワーカーで混ざる）を
# ワーカー {1, 2, 4, 8} × 乱択のスケジュール（SOBER_SCHED_SEED — schedfuzzと同じインターフェース）でゴールデンと照合する。schedfuzz.listに置かないのはparbudgetが
# 同じ列を予算の天井の下で回すため: 天井の下では client の spawn が親の上へ縮退し、Serve の前に答えを待ち続ける（題材の性質 — 接続の向こうの相手は子孫でない）
NAW=examples/net_area_window
"$S2" build $NAW.sober -o "$W/naw" > "$W/naw.log" 2>&1 || { echo "areacheck: FAIL build $NAW ($(head -c 200 "$W/naw.log"))"; exit 1; }
for w in 1 2 4 8; do for s in 0 1 2 3 4; do
    ( env SOBER_WORKERS=$w $( [ $s != 0 ] && echo SOBER_SCHED_SEED=$s ) timeout 60 "$W/naw" > "$W/naw.$w.$s" 2>&1; echo "exit=$?" >> "$W/naw.$w.$s" ) &
done; done
wait
nawn=0
for w in 1 2 4 8; do for s in 0 1 2 3 4; do
    if ! cmp -s "$W/naw.$w.$s" <(cat $NAW.out; echo exit=0); then
        echo "areacheck: FAIL — $NAW (SOBER_WORKERS=$w SOBER_SCHED_SEED=$s)"; diff <(cat $NAW.out; echo exit=0) "$W/naw.$w.$s" | head -6 | sed 's/^/  /'; fail=1
    fi
    nawn=$((nawn + 1))
done; done
[ $fail = 0 ] && echo "areacheck: PASS (4 paths × 9 phases · swapped-max $swm · shallow-max $shm · parkSwap $psw · area window depths $awm · parkDeepWin $pdw · recheck (m73) · area_far 0 · far path (m60) keeps it with area_far $(sed -n 's/.* area_far \([0-9]*\).*/\1/p' <<< "$r60") · far body = pre-area stack pages: $(sed -n 's/^parked //p' <<< "$fs0") · $NAW × $nawn schedules)"
exit $fail
