#!/usr/bin/env bash
# `sober check` の応答時間ベンチ（formal.md「順序」5 の再実装トリガー計測）。
# end-to-end（プロセス起動 + parse + 脱糖 + sober-check 起動 + Lean 検査）の 1 回あたりの時間を測る。
# 使い方: bench/check_bench.sh [回数]   （デフォルト 20 回。要: zig build 済み + lean/ で lake build 済み）
set -euo pipefail
cd "$(dirname "$0")/.."

N="${1:-20}"
SOBER=${SOBER:-./bin/sober}   # 主の sober（主役交代 R39 — Sober の検査器 + stage1 の analyzer）
SRC=bench/fw_bench.sober

# 検査器は明示する — 既定の PATH 探索は環境（WSL の /mnt/ 等）で 60ms 級の雑音になる（R8 2026-09-27）
export SOBER_CHECK="${SOBER_CHECK:-lean/.lake/build/bin/sober-check}"

[ -x "$SOBER" ] || { echo "error: $SOBER not found (run: zig build)"; exit 1; }
"$SOBER" check "$SRC" > /dev/null || { echo "error: check failed on $SRC"; exit 1; }

start=$(date +%s%N)
for _ in $(seq "$N"); do
    "$SOBER" check "$SRC" > /dev/null
done
end=$(date +%s%N)

total_ms=$(( (end - start) / 1000000 ))
echo "sober check $SRC: $N runs, total ${total_ms}ms, avg $(( total_ms / N ))ms/run"
