#!/usr/bin/env bash
# カバレッジの計器（`sober build --cover` — loader/coverx.sober・lower/cover.sober・std/internal/cover）の網:
#   - 題材 examples/cover_basic.sober を --cover で建てて走らせ、出力が計器なしの黄金（.out）と同じ
#   - 点の表（<出力>.pts）と踏んだ印（SOBER_COVER のバイト列）を 1 行 1 点 `<位置> <種類>\t<0|1>` に並べたものが黄金 testdata/cover/cover_basic.txt と一致
#   - 書き出しの見出しの鍵 = 点の表の鍵・ワーカー 1 と 8 で同じ印（task を使わない題材）
#   - `sober test --cover`（題材 testdata/cover/shapes — テストごとに別の腕・呼ばれない関数・101 / 102 で死ぬテスト）: 標準出力（結果の行 + 報告）が
#     testdata/cover/shapes.expect・--cover-out のテキストが shapes.txt・--cover-pkg で下の package まで広げた LCOV が shapes.lcov と一致。ワーカー 1 と 8 で同じ
#   scripts/cover.sh            照合
#   scripts/cover.sh --regen    黄金を作り直す（差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
G=testdata/cover/cover_basic.txt
regen=0
[ "${1:-}" = "--regen" ] && regen=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
"$SOBER" build examples/cover_basic.sober --cover -o "$W/cb" > "$W/build.log" 2>&1 || { echo "FAIL: build"; cat "$W/build.log"; exit 1; }
n=$(($(wc -l < "$W/cb.pts") - 1))
# 点の表と印を並べる（印 = 見出しの行の後ろの n バイト）
render() { tail -n +2 "$W/cb.pts" | paste - <(tail -c "$n" "$1" | od -An -tu1 -v -w1 | tr -d ' '); }
for w in 1 8; do
    SOBER_WORKERS=$w SOBER_COVER="$W/w$w.cov" "$W/cb" > "$W/out$w" 2>&1 < /dev/null || bad "W$w: exit $?"
    cmp -s "$W/out$w" examples/cover_basic.out || bad "W$w: output differs from examples/cover_basic.out"
    [ "$(head -1 "$W/w$w.cov")" = "sober cover v1 $(head -1 "$W/cb.pts" | awk '{print $5}')" ] || bad "W$w: header key differs from the point table"
    render "$W/w$w.cov" > "$W/r$w"
done
cmp -s "$W/r1" "$W/r8" || bad "W1 and W8 marks differ"
# sober test --cover（結果の再生を通さない — 走らせた子の印を見る）
T=testdata/cover/shapes
for w in 1 8; do
    SOBER_CHECK_REPLAY=0 SOBER_WORKERS=$w "$SOBER" test "$T" --cover-out="$W/t$w.txt" > "$W/tout$w" 2> /dev/null
    [ $? = 1 ] || bad "test W$w: exit (want 1 — two tests fail)"
done
SOBER_CHECK_REPLAY=0 "$SOBER" test "$T" --cover-pkg="$T/..." --cover-out="$W/t.lcov" > /dev/null 2>&1
cmp -s "$W/t1.txt" "$W/t8.txt" && cmp -s "$W/tout1" "$W/tout8" || bad "test: W1 and W8 differ"
if [ "$regen" = 1 ]; then
    mkdir -p "$(dirname "$G")"
    cp "$W/r1" "$G"
    cp "$W/tout1" testdata/cover/shapes.expect
    cp "$W/t1.txt" testdata/cover/shapes.txt
    cp "$W/t.lcov" testdata/cover/shapes.lcov
    echo "regen: $G ($n points) + testdata/cover/shapes.{expect,txt,lcov}"
    exit 0
fi
for g in expect:tout1 txt:t1.txt lcov:t.lcov; do
    diff "testdata/cover/shapes.${g%%:*}" "$W/${g#*:}" > "$W/d" || { bad "test: differs from testdata/cover/shapes.${g%%:*}"; head -20 "$W/d"; }
done
diff "$G" "$W/r1" > "$W/d" || { bad "points / marks differ from $G"; head -20 "$W/d"; }
[ "$fail" = 0 ] && echo "PASS: cover ($n points)" || exit 1
