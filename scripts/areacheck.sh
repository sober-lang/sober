#!/usr/bin/env bash
# areacheck: 接続の task の区画（language.md 11 節 — 本体より下の積みはワーカーの区画・止まると持ち札と交換）の保存則の網。
# testdata/areacheck/srv.sober の接続の task に 4 つの道（普通に返る・深い待ちの後に返る・panic で死ぬ・Serve の期限で寝たまま捨てられる）を
# 踏ませ、相ごとに scripts/areacheck.ts が外から全塊の TC_AREA と全ワーカーの WK_AREA を読んで見る:
#   (1) 持ち札の多重集合 = 塊の積みの領域の全部 ∪ ワーカーの区画の全部（数 = 塊の数 + W・重複なし・持ち主のない区画なし）
#   (2) 塊の退避 rsp は持つ区画の中（自分の領域を持つときだけ頁 0 も）
#   浅い待ち（受けで寝る接続 — 交換せず退避も持たない: TCB の語 0 は本体の戻り先）は退避 rsp の照合から外し、その数（shallow）を数える
# 交換が起きていること（持ち札が自分でない塊 > 0）と area_far = 0 も。遠い道の 1 行 = 変異 60（全関数の枠 +512 B — 本体が頁 0 に入らず
# 持ち札の上の連続の形）で (1)(2) が保たれ交換 0・area_far > 0。
# 本体の太い題材（srv の far — 本体の枠が頁 0 の余白に入らず遠い道を通る）の行: 寝ている接続の「常駐の積みの頁」の型の集合（parked /
# deep-wait / after-deep-wait の相）が、区画を使わない ELF（変異 66 — 段 1 の前の積みの形）と一致する（遠い道は持ち札が自分の領域ならその場で連続）。
# 深い待ちの後の受け（持ち札とワーカーの区画を交換してから浅く寝る — Ledger の parkSwap > 0）ともう一度の深い待ち（deep-again の相）も踏む。
# 区画の窓（task.sober）: 浅く寝ている task の窓の深度は全部空（相ごとに退避の対を外から読む）・深く寝る /hold と浅く寝て起きる /ok が同じ
# ワーカーで混ざっても /hold は寝る前の path を返す・途中の要求を持って待つ接続は深く寝る（parkDeepWin > 0 — split の相）。
# 毎回、変異 62（出口形を外す）・63 / 64（交換の task の側だけ / ワーカーの側だけ）・65（遠い道でいつも持ち札の頂上へ付け替える — 頁 0 の余白が空いて
# 寝ている接続の積みの頁が 1 枚増える）・67（浅い待ちの記しを付けない — 浅く寝る塊 0）・68（着地でレジスタを読み戻さない）・70（交換して浅く寝たのに
# ワーカーの区画の上の印を立てない）・71（本体が頁 0 にある印を見ない — 遠い道の本体も浅く寝る）・72（起きた浅い待ちを期限の鎖から外さない —
# Serve の期限で寝たまま起こされる道）・74（起こされた本体に誤りを返す — 着地の値が本体に届く証）・78（区画の窓の中身を見ずに浅く寝る）・
# 79（中身の判定から欄 r = 0〔途中の要求を持つ深度〕を抜く）・80（起きた点で窓の深度を付け替えない）・81（窓から小さいスロットへ移した深度も窓の始まりで空を比べる — 大きい本文の後に毎回深く寝る）が落ち、73（起こされたをいつも見直し〔2〕に —
# 本体がもう一度 rt.netwait を呼ぶ道）が保存則と答えを保つことを確かめる
# 行の無い道: 同じ rt.netwait の呼び出しの中で深く寝た後の再 park — 記しつきの park は AREA_NEAR なら必ず浅く、NEAR は本体の入口で立てて task の間
# 消えないので起きない（記しつきで深く寝るのは遠い道だけで、それは浅くならない）。別のワーカーでの着地 — 走り始めた task は TC_WORKER に固定で起こしも持ち主へ
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
# 変異 73 = 浅い待ちから起こされた本体にいつも見直し（2）を返す（本体がもう一度 rt.netwait を呼ぶ道 — 保存則も答えも保つ）・74 = 同じ点で誤りを返す（落ちる — 73 がその値の道を踏む証）
r73=$(run 73)
if [[ "$r73" =~ ^areacheck-ok\ swapped-max\ [0-9]+\ shallow-max\ [1-9] ]]; then :; else echo "areacheck: FAIL — the recheck path (mutant 73) broke: $r73"; fail=1; fi
# 変異 67 = 浅い待ちの記しを付けない（受けも深い待ち — 浅く寝る塊 0）
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
# 遠い道の題材: 署名が段 1 の前（変異 66）と一致・変異 65 で違う
# 相ごとの「常駐の頁」の型の集合（積みの頁 — 頁 0 から下だけ。頭の頁〔塊の窓・区画の窓〕は区画の窓の段で変わるので見ない。積みの深さと数は見ない: 受けの待ちは本体の rt.netwait の点で寝るので区画を使わない形〔read_fd の中で寝る〕より浅く、
# 各ワーカーが最後に走らせた task〔その積みの上で次を待つ〕の語 0 は浅い待ちの記しの戻り先のことがある）
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
# 変異 71 = AREA_NEAR を見ない（遠い道の本体も浅く寝て、持ち札の上にあった本体の枠を失う）
r71=$(AC_FAR=1 run 71)
if [[ "$r71" == areacheck-bad* ]]; then echo "areacheck: m71 caught (far body: ${r71#areacheck-bad }" | cut -c1-160 | sed 's/$/…)/'; else echo "areacheck: FAIL — mutant 71 was not caught ($r71)"; fail=1; fi
if [ -n "$fs65" ] && [ "$fs65" != "$fs66" ]; then echo "areacheck: m65 caught (far body: $(sed -n 's/^parked //p' <<< "$fs65") vs $(sed -n 's/^parked //p' <<< "$fs66"))"; else echo "areacheck: FAIL — mutant 65 was not caught"; fail=1; fi
# 区画の窓の答え（examples/net_area_window — 浅く寝る /ok・深く寝て path を返す /hold・途中の要求を持って待つ接続が同じワーカーで混ざる）を
# ワーカー {1, 2, 4, 8} × 乱択のスケジュール（SOBER_SCHED_SEED — schedfuzz と同じ口）で黄金と照合する。schedfuzz.list に置かないのは parbudget が
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
