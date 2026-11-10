#!/usr/bin/env bash
# stackcheck: 接続の task の積みの最深の網。task の塊の並びは [ガード | 積み | 頁: 積みの頂上 TCB_TOP_ROOM + TCB | …] で、keep-alive の
# 1 要求の最深の積みが「TCB_TOP_ROOM + 下の 1 頁」を越えると接続ごとに積みの頁が 1 枚増える（常駐 +4 KB/接続 — 命令の網にも
# RSS の傾きの 1 点にも鳴りにくい崖）。bench/httparena/main.sober の写し（main だけを期限つきで run に差し替え — 道は本物）に
# keep-alive の baseline の 3 形を流し、終わりの #par tasks の stack_hw（task の積みの最深 — rt.pstat_end の走査）が予算 − 64 B 以下かを見る。
# --mutants: 変異 47（新しい塊の積みの頂上を 1 KiB 下げる = 道が 1 KiB 深くなったのと同じ）で落ちることを確かめる
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
fail=0
if [ -z "$hw" ] || ! grep -q '^ok 4800$' "$W/client"; then
    echo "stackcheck: FAIL — no stack_hw or the client did not get 4800 responses ($(head -c 100 "$W/client"))"; fail=1
elif [ "$hw" -gt "$lim" ]; then
    echo "stackcheck: FAIL — the keep-alive connection task's deepest stack is $hw B > $lim B (TCB_TOP_ROOM $room + one page − 64): every connection would touch one more stack page"; fail=1
fi
if [ $MUT = 1 ]; then
    "$S2" build "$W/arena.sober" --rt-mutant=47 -o "$W/srv47" > "$W/b.log" 2>&1 || { echo "stackcheck: FAIL build m47"; exit 1; }
    h47=$(measure "$W/srv47")
    if [ -n "$h47" ] && [ "$h47" -gt "$lim" ]; then echo "stackcheck: m47 caught (stack_hw $h47 > $lim)"; else echo "stackcheck: FAIL — mutant 47 was not caught (stack_hw ${h47:-none})"; fail=1; fi
fi
[ $fail = 0 ] && echo "stackcheck: PASS (stack_hw $hw ≤ $lim B)"
exit $fail
