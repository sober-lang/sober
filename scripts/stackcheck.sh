#!/usr/bin/env bash
# stackcheck: 接続のtaskのスタックの最深の検査。taskのチャンクの並びは [ガード | スタック | ページ: スタックの頂上TCB_TOP_ROOM + TCB | …] で、keep-aliveの
# 1リクエストの最深のスタックが「TCB_TOP_ROOM + 下の1ページ」を越えると接続ごとにスタックのページが1枚増える（常駐 +4 KB/接続 — 命令の検査にも
# RSSの傾きの1点にも鳴りにくい崖）。bench/httparena/main.soberのコピー（mainだけを期限つきでrunに差し替え — パスは本物）に
# keep-aliveのbaselineの3形を流し、終わりの #par tasksのstack_hw（taskのスタックの最深 — rt.pstat_endの走査）が予算 − 64 B以下かを見る。
# --mutants: ミューテーション47（新しいチャンクのスタックの頂上を1 KiB下げる = パスが1 KiB深くなったのと同じ）で落ちることを検証する
#   scripts/stackcheck.sh [--mutants]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
MUT=0
[ "${1:-}" = --mutants ] && MUT=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
room=$(sed -n 's/^const TCB_TOP_ROOM = \([0-9]*\).*/\1/p' src/compiler/lower/task.sober)
[ -n "$room" ] || { echo "stackcheck: FAIL — TCB_TOP_ROOM not found in src/compiler/lower/task.sober"; exit 1; }
lim=$((room + 4096 - 64))
sed 's/^func main() int {/func arenaMain() int {/' bench/httparena/main.sober > "$W/arena.sober"
cat >> "$W/arena.sober" <<'SRC'

func main() int {
    _, _ = task.Run((s task.Scope) => run("0", "0"), deadline: 2500 * task.MS)
    return 0
}
SRC
# measure <実行ファイル> → stack_hw を印字（失敗は空）
measure() {
    local x=$1 p
    env SOBER_PAR_STATS=1 SOBER_WORKERS=2 DATASET_PATH=testdata/httpcheck/dataset.json "$x" > "$W/out" 2> "$W/err" &
    local pid=$!
    for _ in $(seq 100); do grep -q '^ready' "$W/out" 2> /dev/null && break; sleep 0.05; done
    p=$(awk '/^ready/ { print $2; exit }' "$W/out")
    [ -n "$p" ] && node scripts/stackcheck.ts "$p" 16 300 > "$W/client" 2>&1
    wait $pid
    grep -o 'stack_hw=[0-9]*' "$W/err" | cut -d= -f2
}
"$S2" build "$W/arena.sober" -o "$W/srv" > "$W/b.log" 2>&1 || { echo "stackcheck: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
hw=$(measure "$W/srv")
# 接続のtaskがエリアの形（本体の枠はページ0の余白・下はワーカーのエリア）で走ったか: 入らなかった数area_farが0（framestatの @roomの予測と実際の照合）
af=$(grep -o 'area_far=[0-9]*' "$W/err" | cut -d= -f2)
fail=0
if [ "$af" != 0 ]; then echo "stackcheck: FAIL — area_far=${af:-none}: connection tasks whose body frame did not fit page 0 (framestat @room predicts it fits)"; fail=1; fi
if [ -z "$hw" ] || ! grep -q '^ok 4800$' "$W/client"; then
    echo "stackcheck: FAIL — no stack_hw or the client did not get 4800 responses ($(head -c 100 "$W/client"))"; fail=1
elif [ "$hw" -gt "$lim" ]; then
    echo "stackcheck: FAIL — the keep-alive connection task's deepest stack is $hw B > $lim B (TCB_TOP_ROOM $room + one page − 64): every connection would touch one more stack page"; fail=1
fi
if [ $MUT = 1 ]; then
    "$S2" build "$W/arena.sober" --rt-mutant=47 -o "$W/srv47" > "$W/b.log" 2>&1 || { echo "stackcheck: FAIL build m47"; exit 1; }
    h47=$(measure "$W/srv47")
    if [ -n "$h47" ] && [ "$h47" -gt "$lim" ]; then echo "stackcheck: m47 caught (stack_hw $h47 > $lim)"; else echo "stackcheck: FAIL — mutant 47 was not caught (stack_hw ${h47:-none})"; fail=1; fi
    # ミューテーション60（全関数の枠 +512 B）: 本体がページ0の余白に入らずarea_far > 0
    "$S2" build "$W/arena.sober" --rt-mutant=60 -o "$W/srv60" > "$W/b.log" 2>&1 || { echo "stackcheck: FAIL build m60"; exit 1; }
    measure "$W/srv60" > /dev/null
    a60=$(grep -o 'area_far=[0-9]*' "$W/err" | cut -d= -f2)
    if [ -n "$a60" ] && [ "$a60" -gt 0 ] && grep -q '^ok 4800$' "$W/client"; then echo "stackcheck: m60 caught (area_far $a60)"; else echo "stackcheck: FAIL — mutant 60 was not caught (area_far ${a60:-none} · client $(head -c 120 "$W/client"))"; fail=1; fi
fi
[ $fail = 0 ] && echo "stackcheck: PASS (stack_hw $hw ≤ $lim B · area_far 0)"
exit $fail
