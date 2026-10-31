#!/usr/bin/env bash
# clidoc（gates）: CLI の文書 ≡ 実装（docsync の CLI 版）。
#   ① 生成物の一致: `sober doc --cli` の頁 ≡ docs/cli/sober.md（英 — 正）・sober.ja.md（訳表 docs/cli/sober.ja.json）。表は stage2 自身に吐かせる
#      （--exe — stage2 は今の木の app を建てたもの）・効果は compiler/ の木（std を写した — effectsdump の自己と同じ形）で導出。
#      題材 testdata/clidoc/tool.sober（名前の run / ラムダの run / run 無し / dev の除外 / `|` の逃がし / サブコマンドの錨）≡ tool.md・tool.ja.md
#   ①' 訳表の陳腐化: 訳の無い文・使われない訳で生成が落ちること（負例 2 本）
#   ②③ scripts/clidoc.ts（環境変数の綴り ⊆ 表の宣言 ∪ docs/guide/env.ja.md の表・scripts と bin/sober が渡すフラグ ⊆ 表の宣言）
#
#   scripts/clidoc.sh [--regen]   --regen は ① の生成物を書き直す（②③ と負例は見ない）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = "--regen" ] && regen=1
fail=0
mkdir -p "$W/self" && cp -r src/compiler/. "$W/self/" && cp -r src/std "$W/self/std"
(cd "$W/self" && "$S2" doc --cli app --exe "$S2" -o "$W/sober.md") || { echo "FAIL doc --cli (sober)"; exit 1; }
(cd "$W/self" && "$S2" doc --cli app --exe "$S2" --ja "$ROOT/docs/cli/sober.ja.json" -o "$W/sober.ja.md") || { echo "FAIL doc --cli --ja (sober)"; exit 1; }
T=testdata/clidoc
(cd "$T" && "$S2" doc --cli tool.sober -o "$W/tool.md") || { echo "FAIL doc --cli (tool)"; exit 1; }
(cd "$T" && "$S2" doc --cli tool.sober --ja tool.ja.json -o "$W/tool.ja.md") || { echo "FAIL doc --cli --ja (tool)"; exit 1; }
if [ $regen = 1 ]; then
    mkdir -p docs/cli
    cp "$W/sober.md" "$W/sober.ja.md" docs/cli/
    cp "$W/tool.md" "$W/tool.ja.md" "$T/"
    echo "clidoc: regenerated docs/cli/sober{,.ja}.md and $T/tool{,.ja}.md"
    exit 0
fi
for f in docs/cli/sober.md docs/cli/sober.ja.md "$T/tool.md" "$T/tool.ja.md"; do
    diff -q "$W/$(basename "$f")" "$f" > /dev/null 2>&1 || { echo "FAIL $f differs from the generated page (scripts/clidoc.sh --regen):"; diff "$W/$(basename "$f")" "$f" | head -8; fail=1; }
done
# ①' 負例: 訳を 1 本抜く（訳なし）・余分な訳を足す（使われない）— どちらも生成が名指しで落ちる
node -e 'const t=JSON.parse(require("fs").readFileSync(process.argv[1],"utf8"));delete t["count the bytes"];require("fs").writeFileSync(process.argv[2],JSON.stringify(t))' "$T/tool.ja.json" "$W/miss.json"
node -e 'const t=JSON.parse(require("fs").readFileSync(process.argv[1],"utf8"));t["no such text"]="無い";require("fs").writeFileSync(process.argv[2],JSON.stringify(t))' "$T/tool.ja.json" "$W/extra.json"
(cd "$T" && "$S2" doc --cli tool.sober --ja "$W/miss.json" -o "$W/x.md" 2> "$W/miss.err")
grep -q 'no translation for "count the bytes"' "$W/miss.err" || { echo "FAIL a missing translation was not named:"; cat "$W/miss.err"; fail=1; }
(cd "$T" && "$S2" doc --cli tool.sober --ja "$W/extra.json" -o "$W/x.md" 2> "$W/extra.err")
grep -q 'unused translation of "no such text"' "$W/extra.err" || { echo "FAIL an unused translation was not named:"; cat "$W/extra.err"; fail=1; }
"$S2" --cli-spec > "$W/spec.json" || { echo "FAIL sober --cli-spec"; exit 1; }
node --experimental-strip-types --no-warnings scripts/clidoc.ts "$W/spec.json" || fail=1
echo "clidoc: pages 4 + negatives 2, fail=$fail"
exit $fail
