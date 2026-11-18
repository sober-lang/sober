#!/usr/bin/env bash
# pid1stop（report-960 — language.md 27 節「PID 1の停止」）: testdata/pid1stopの2本（逐次・M:N）をビルドし、SIGTERM / SIGINTで
# 非 PID 1 はシグナルの死のまま・PID 1（unshare -rpf の pid ns の init）は 143 / 130 で即座に止まることを照合する（本体 = scripts/pid1stop.ts）。
# unshareの利用者の名前空間が使えない環境はFAIL（SOBER_GATES_ALLOW_SKIPにunshareを書いたときだけSKIP。gatelib.shのcant）
#   scripts/pid1stop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
if ! timeout 5 unshare -rpf --kill-child true > /dev/null 2>&1; then
    cant pid1stop unshare "the PID 1 stop (unshare -rpf is not available)" && exit 0
    exit 1
fi
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
for p in seq task; do
    "$S2" build "testdata/pid1stop/$p.sober" -o "$W/$p" > "$W/$p.blog" 2>&1 || { echo "pid1stop: FAIL build $p ($(head -c 200 "$W/$p.blog"))"; exit 1; }
done
node --experimental-strip-types --no-warnings scripts/pid1stop.ts "$W/seq" "$W/task"
