#!/usr/bin/env bash
# テスティングガイド（docs/guide/testing{,.ja}.md）の `$ sober …` の出力の網: testdata/guide/testing.cmds の各コマンドを、examples/guide の写しの中で
# 上から順に走らせ（標準出力 + 標準エラー・終了コードの行つき）、黄金 testdata/guide/testing/<名前>.out と照合する。ワーカー 1 と 8 で同じ。
# fuzz の「見つからない」の行の試行数は期限に依るので `<n>` に置き換える。ページの塊と黄金の一致は docsync が見る。あわせて題材の写しの整合
# （kv2 / kv3 / kvbug の kv.sober は kv と虫だけの差 — kv2 / kv3 は 4 節の虫 1 匹・kvbug は 3 匹・kv2 / kv3 のテストは kv のテストの頭）も見る
#   scripts/guidetest.sh            照合
#   scripts/guidetest.sh --regen    黄金を作り直す（差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
G=testdata/guide/testing
regen=0
[ "${1:-}" = "--regen" ] && regen=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
"$SOBER" build examples/hello.sober -o "$W/h" > /dev/null 2>&1 || { echo "FAIL: build"; exit 1; }
S2=$(pwd)/out/stage2/sober2
# 題材の写しの整合
pk() { sed "1s/^package .*/package kv/" "$1"; }
for d in kv2 kv3; do
    [ "$(diff <(pk examples/guide/$d/kv.sober) examples/guide/kv/kv.sober | grep -c '^[<>]')" = 2 ] || bad "examples/guide/$d/kv.sober should differ from kv/kv.sober by the escape bug of section 4 only"
    n=$(wc -l < examples/guide/$d/kv_test.sober)
    cmp -s <(pk examples/guide/$d/kv_test.sober) <(head -n "$n" examples/guide/kv/kv_test.sober) || bad "examples/guide/$d/kv_test.sober is not the head of kv/kv_test.sober"
done
cmp -s <(pk examples/guide/kvbug/kv_test.sober) examples/guide/kv/kv_test.sober || bad "examples/guide/kvbug/kv_test.sober differs from kv/kv_test.sober"
[ "$(diff <(pk examples/guide/kvbug/kv.sober) examples/guide/kv/kv.sober | grep -c '^[<>]')" = 6 ] || bad "examples/guide/kvbug/kv.sober should differ from kv/kv.sober by the three bugs only"
run() {
    local w=$1 d="$W/w$1"
    mkdir -p "$d/examples" "$d/out"
    cp -r examples/guide "$d/examples/"
    rm -rf "$d"/examples/guide/*/testdata/fuzz
    while read -r name cmd; do
        case "$name" in ''|'#'*) continue ;; esac
        ( cd "$d" && SOBER_CHECK_REPLAY=0 SOBER_BUILD_CACHE=0 SOBER_WORKERS=$w "$S2" ${cmd#sober } > "out/$name" 2>&1; echo "(exit $?)" >> "out/$name" )
        sed -i -E 's/quick: fuzz: [0-9]+ trials, no failure/quick: fuzz: <n> trials, no failure/' "$d/out/$name"
    done < testdata/guide/testing.cmds
}
run 1
run 8
for f in "$W"/w1/out/*; do
    cmp -s "$f" "$W/w8/out/$(basename "$f")" || bad "W1 and W8 differ: $(basename "$f")"
done
if [ "$regen" = 1 ]; then
    rm -rf "$G"
    mkdir -p "$G"
    for f in "$W"/w1/out/*; do cp "$f" "$G/$(basename "$f").out"; done
    echo "regen: $G ($(ls "$G" | wc -l) outputs)"
    exit 0
fi
for f in "$W"/w1/out/*; do
    n=$(basename "$f")
    diff "$G/$n.out" "$f" > "$W/d" 2>&1 || { bad "$n differs from $G/$n.out"; head -10 "$W/d"; }
done
[ "$fail" = 0 ] && echo "PASS: guidetest ($(ls "$W"/w1/out | wc -l) commands)" || exit 1
