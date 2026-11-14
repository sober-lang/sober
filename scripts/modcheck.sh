#!/usr/bin/env bash
# モジュールの宣言（sober.mod — language.md 20 節）の検査: testdata/mod/<題材>/ を起点（cwd）にしてmain.soberをcheckし、受理ならbuildして走らせ、
# 出力（標準出力 + 標準エラー・終了コードの行つき）をゴールデンtestdata/mod/<題材>.expectと照合する（ワーカー1と8）。題材 = 正例（project — dep・自分の木の
# package・std の根の alias・renamed — dep の名前の付け替え）と負例（neg_* — sober.mod の文法・名前の規則・ローカルでない出所・版・dep の sober.mod の欠け・
# 木での名前の衝突・alias の宛先・dep の dep・import の衝突）。あわせて dep の package のテスト（project から `sober test kv/store`）と、
# sober.mod を書き換えたら check の答えの再生が外れること（読んだファイルの照合に sober.mod が入る）を見る
#   scripts/modcheck.sh            照合
#   scripts/modcheck.sh --regen    ゴールデンを作り直す（差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
"$SOBER" build examples/hello.sober -o "$W/h" > /dev/null 2>&1 || { echo "FAIL: build"; exit 1; }
S2=$ROOT/out/stage2/sober2
G=testdata/mod
regen=0
[ "${1:-}" = "--regen" ] && regen=1
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
one() { # one <題材> <ワーカー数>
    local d=$1 w=$2 o="$W/$1.$2"
    ( cd "$G/$d" && SOBER_CHECK_REPLAY=0 SOBER_BUILD_CACHE=0 SOBER_WORKERS=$w "$S2" check main.sober ) > "$o" 2>&1
    local rc=$?
    echo "(check exit $rc)" >> "$o"
    if [ "$rc" = 0 ]; then
        ( cd "$G/$d" && SOBER_BUILD_CACHE=0 SOBER_WORKERS=$w "$S2" build main.sober -o "$W/$d.$w.exe" ) >> "$o" 2>&1 || echo "(build failed)" >> "$o"
        [ -x "$W/$d.$w.exe" ] && { "$W/$d.$w.exe" >> "$o" 2>&1; echo "(run exit $?)" >> "$o"; }
    fi
}
for d in $(cd "$G" && ls -d */ | tr -d / ); do
    [ -f "$G/$d/main.sober" ] || continue
    one "$d" 1
    one "$d" 8
    cmp -s "$W/$d.1" "$W/$d.8" || bad "$d: W1 and W8 differ"
    if [ "$regen" = 1 ]; then
        cp "$W/$d.1" "$G/$d.expect"
    else
        diff "$G/$d.expect" "$W/$d.1" > "$W/diff" 2>&1 || { bad "$d differs from $G/$d.expect"; head -10 "$W/diff"; }
    fi
done
[ "$regen" = 1 ] && { echo "regen: $G"; exit 0; }
# dep の package のテスト（起点 = project — kv/store は dep の木の package）
( cd "$G/project" && SOBER_WORKERS=1 "$S2" test kv/store ) > "$W/t" 2>&1 || bad "sober test kv/store in $G/project: $(tail -1 "$W/t")"
grep -q "^ok   kv/store.TestFind" "$W/t" || bad "sober test kv/store did not report TestFind: $(head -3 "$W/t")"
# checkの答えの再生: sober.modを書き換えたら外れる（コピーの木で — 配置先は一時のディレクトリ）
cp -r "$G" "$W/copy"
( cd "$W/copy/project" && SOBER_CACHE="$W/cache" "$S2" check main.sober ) > "$W/r1" 2>&1 || bad "replay: the first check rejects: $(tail -1 "$W/r1")"
printf 'alias json2 "std/json"\n' >> "$W/copy/project/sober.mod"
( cd "$W/copy/project" && SOBER_CACHE="$W/cache" "$S2" check main.sober ) > "$W/r2" 2>&1 && bad "replay: a check after editing sober.mod replayed the old answer"
grep -q "an alias renames a std root" "$W/r2" || bad "replay: the check after editing sober.mod did not name the alias: $(tail -1 "$W/r2")"
[ "$fail" = 0 ] && echo "PASS: modcheck ($(cd "$G" && ls -d */ | wc -l) dirs)" || exit 1
