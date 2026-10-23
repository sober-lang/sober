#!/usr/bin/env bash
# pid1stop（report-960 — language.md 27 節「PID 1 の停止」）: testdata/pid1stop の 2 本（逐次・M:N）を建て、SIGTERM / SIGINT で
# 非 PID 1 はシグナルの死のまま・PID 1（unshare -rpf の pid ns の init）は 143 / 130 で即座に止まることを照合する（本体 = scripts/pid1stop.ts）。
# unshare の利用者の名前空間が使えない環境は SKIP（緑）
#   scripts/pid1stop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
if ! timeout 5 unshare -rpf --kill-child true > /dev/null 2>&1; then
    echo "pid1stop: SKIP (unshare -rpf is not available)"
    exit 0
fi
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
for p in seq task; do
    "$S2" build "testdata/pid1stop/$p.sober" -o "$W/$p" > "$W/$p.blog" 2>&1 || { echo "pid1stop: FAIL build $p ($(head -c 200 "$W/$p.blog"))"; exit 1; }
done
node --experimental-strip-types --no-warnings scripts/pid1stop.ts "$W/seq" "$W/task"
