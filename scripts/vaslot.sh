#!/usr/bin/env bash
# vaslot（net 4a-4 の直し — report-654/655）: region のスロットの VA の約束。
#   ① va_exhausted: スロットの補充（mmap）の失敗は RegionExceeded{cause: va_exhausted} を名乗る（旧 = slot_capacity の誤名乗り）。
#      SOBER_REGION_MB=SOBER_TASK_REGION_MB=65536（スロット 64 GiB — main のアリーナ 64 TiB・子の補充 16 本 = 1 TiB）+ ulimit -v 64.5 TiB で最初の子の補充を決定的に失敗させる
#   ② 宣言（budget:）の無い子の region 1 つの上限 = 子のスロットの既定（SOBER_TASK_REGION_MB — 網は 1 MiB）: 超えれば slot_capacity（main は 4 GiB のまま）
#   ③ 宣言が既定を超える子は宣言以上の 2 の冪のスロット（自前の mmap / munmap — 既定の子と交互に回してプールと取り違えない）
#   （<名前>.out があれば stdout も照合）
#   scripts/vaslot.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
D=testdata/vaslot
build() { "$S2" build "$D/$1.sober" -o "$W/$1" > "$W/$1.blog" 2>&1 || { echo "FAIL: build $1"; cat "$W/$1.blog" | head -5; fail=$((fail + 1)); return 1; }; }
# expect <名前> <終了コード> <stderr の 1 行目> [env…]（ulimit は VA_ULIMIT で）
expect() {
    local e=$1 want=$2 line=$3 ec=0
    shift 3
    ( [ -n "${VA_ULIMIT:-}" ] && ulimit -v "$VA_ULIMIT"; env "$@" timeout 60 "$W/$e" > "$W/$e.out" 2> "$W/$e.err" ) || ec=$?
    n=$((n + 1))
    if [ "$ec" != "$want" ] || [ "$(head -1 "$W/$e.err")" != "$line" ] || { [ -f "$D/$e.out" ] && ! cmp -s "$D/$e.out" "$W/$e.out"; }; then
        echo "FAIL: $e ($*${VA_ULIMIT:+ ulimit -v $VA_ULIMIT}): exit $ec (want $want)"; head -3 "$W/$e.err"; fail=$((fail + 1))
    fi
}
# ① va_exhausted（W = 1 / 既定の両方 — 補充の道は協調形と M:N で別）
build va_exhausted && for w in 1 2; do
    VA_ULIMIT=69256347648 expect va_exhausted 101 'panic: ChildDied{cause: RegionExceeded{cause: va_exhausted}} at va_exhausted.sober:19:18' SOBER_REGION_MB=65536 SOBER_TASK_REGION_MB=65536 SOBER_WORKERS=$w
done
# ② / ③（W ∈ {1, 2, 8}）
build child_over && build child_budget && for w in 1 2 8; do
    expect child_over 101 'panic: ChildDied{cause: RegionExceeded{cause: slot_capacity}} at child_over.sober:21:49' SOBER_TASK_REGION_MB=1 SOBER_WORKERS=$w
    expect child_budget 0 '' SOBER_TASK_REGION_MB=1 SOBER_WORKERS=$w
done
echo "vaslot: $n runs, fail=$fail"
[ $fail = 0 ]
