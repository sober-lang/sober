#!/usr/bin/env bash
# sober fix の網（effect の波 段 5a-3 — language.md 12 節「関数の効果の宣言」・13 節の 4 点組の「正の列挙は fix が書く」）: testdata/fix（宣言の無い公開関数・
# 古い正の列挙・古い @errors・否定形と内部関数〔触らない〕）を写して `sober fix` を掛け、
#   ① 書き換えた木 ≡ 黄金（testdata/fixgold/fix/）② もう 1 回の fix は何も書かない（不動点）③ 書き換えた木を check が受理する
#   ④ fix が書いた正の列挙 ≡ `check --effects-dump` の導出のビット
#   ⑤ std（段 5b の強制）: std の全 package を import する合成の main に `fix --effects --std` を掛けて何も書かない（木の std の宣言 = 正規形の不動点。
#      欠け・古さの負例は stage2 の L0 bake〔std の check〕が MEffMissing / MEffStale で落ちる形が受け持つ — CLI は焼き込みの std しか読まない）
#
#   scripts/fixcheck.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
mkdir -p "$W/testdata" && cp -r testdata/fix "$W/testdata/fix"
(cd "$W" && "$S2" fix testdata/fix/app) > "$W/fix1.txt" 2>&1 || { echo "FAIL fix: $(cat "$W/fix1.txt")"; fail=1; }
if [ "${1:-}" = "--regen" ]; then
    rm -rf testdata/fixgold && mkdir -p testdata/fixgold && cp -r "$W/testdata/fix" testdata/fixgold/fix && echo "fixcheck: regenerated testdata/fixgold" && exit 0
fi
diff -r "$W/testdata/fix" testdata/fixgold/fix > "$W/diff.txt" || { echo "FAIL ① fix output differs from testdata/fixgold:"; head -20 "$W/diff.txt"; fail=1; }
(cd "$W" && "$S2" fix testdata/fix/app) > "$W/fix2.txt" 2>&1
[ -s "$W/fix2.txt" ] && { echo "FAIL ② second fix wrote: $(cat "$W/fix2.txt")"; fail=1; }
(cd "$W" && "$S2" check testdata/fix/app) > "$W/check.txt" 2>&1 || { echo "FAIL ③ check after fix:"; cat "$W/check.txt"; fail=1; }
# ④ 書いた正の列挙（語だけ）と導出: 関数名ごとに `@effects(…)` の直後の func の名前を引く
(cd "$W" && "$S2" check testdata/fix/app --effects-dump) > "$W/dump.txt" 2>&1
n=0
for f in "$W"/testdata/fix/*/*.sober; do
    pkg=$(sed -n 's/^package //p' "$f" | head -1)
    while read -r decl name; do
        words=$(sed 's/^@effects(//;s/)$//' <<< "$decl")
        [ -z "$words" ] && words=none
        case "$words" in *'!'*) continue ;; esac
        got=$(grep -E " effects [^ ]*${pkg}\.${name} fi=" "$W/dump.txt" | sed 's/.* bits=//;s/ declared$//')
        n=$((n + 1))
        [ "$got" = "$words" ] || { echo "FAIL ④ ${pkg}.${name}: wrote ($words) — derived ($got)"; fail=1; }
    done < <(awk '/^@effects\(/ { d = $0; next } /^func / && d != "" { split($2, a, "("); print d, a[1]; d = ""; next } /^@/ { next } { d = "" }' "$f")
done
mkdir -p "$W/std/app" && { echo "package main"; echo; for d in $(cd src && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$W/std/app/main.sober"
(cd "$W/std" && "$S2" fix --effects --std "$W/std/out" app/main.sober) > "$W/fixstd.txt" 2>&1 || { echo "FAIL ⑤ fix --std: $(head -c 300 "$W/fixstd.txt")"; fail=1; }
[ -s "$W/fixstd.txt" ] && { echo "FAIL ⑤ fix --std wrote (the std declarations are not in derived form): $(head -c 300 "$W/fixstd.txt")"; fail=1; }
echo "fixcheck: $(wc -l < "$W/fix1.txt") files written, ${n} positive @effects matched the derivation, std fix --std wrote $(wc -l < "$W/fixstd.txt"), fail=$fail"
exit $fail
