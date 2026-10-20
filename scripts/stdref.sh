#!/usr/bin/env bash
# stdref（gates）: std リファレンス（docs/std/ — docs 補完 B-1・report-903 の 3〜4 節）の照合。生成器の本体は src/compiler/tools/docgen
# （loader / parser / printer を in-process で使う — 署名は .sobi と同じ印字器・doc コメントは宣言の字句の位置からソースを遡って取る）。
#
#   scripts/stdref.sh             ① 生成物の一致: 生成し直した docs/std/*.ja.md ≡ リポジトリのもの（黄金の形）
#                                 ② doc の lint（赤 — en-* だけは英訳表〔B-3〕までの間は警告で数を出すだけ）
#                                 ③ 負例: testdata/stdref/neg（lint の各条を 1 本ずつ破った最小の std）の警告 ≡ expect.tsv
#   scripts/stdref.sh --regen     docs/std/ を生成し直す（README.ja.md と <package>.ja.md — 英訳表 docs/std/en/ は触らない）
#   scripts/stdref.sh --lint      lint の警告の全行（WARN\t<種類>\t<位置>\t<名前>\t<詳細>）
#   scripts/stdref.sh --regen-neg 負例の期待（testdata/stdref/neg/expect.tsv）を作り直す
#
# lint の種類: nodoc（公開の宣言・package に doc なし）・name（1 文目が「<名前> は」で始まる — doc は宣言の直下で読むので名前を繰り返さず説明の本体から書く。
#   宣言・欄・package〔パスの最後の要素〕が対象・const の群は群の先頭の名前・`[T]` / `(a, b)` / `・名前` の続きも同じ形）・
#   jargon（report-N / 便 / 段 N / 日付 / P3a 形）・section（`language.md N 節` の節が無い・裸の `N 節` — `language.md` を付けて書く。他の `.md` と `RFC NNNN N 節` は除く）・example（`例: examples/…` の実物が無い）・
#   bold（コードの区間の外の `**` — 人間向けの文書に強調の太字は使わない）・
# 合成の口 = `// 合成: <印字>` で始まる宣言に付かない塊（std に実体が無く loader が写す口 — layout.Decode[T]・json.Decode[T] 等）: 印字は手書き・塊の残りの行が doc・
#   ページではそのファイルの宣言より先に並ぶ（ファイルの末尾に置いて std の行の位置を動かさない）
# const の群 = 空行を挟まず続く `const` の行: 自分の doc が無い const は群の先頭の塊を doc にし、行末のコメントを自分の段落に足す
#   en-none / en-missing / en-stale / en-bad（英訳表 docs/std/en/<package>.json の無い・訳なし・原文の crc32 と不一致・読めない — B-3 まで en-none だけ）
# 対象 = stage2.sh の L0 と同じ列挙（src/std の .sober のあるディレクトリ全部・std/internal を除く）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

mode=check
case "${1:-}" in
    --regen) mode=regen ;;
    --lint) mode=lint ;;
    --regen-neg) mode=regenneg ;;
    "") ;;
    *) echo "usage: scripts/stdref.sh [--regen | --lint | --regen-neg]" >&2; exit 2 ;;
esac

BIN=out/stdref/docgen
mkdir -p out/stdref
if [ -n "${SELFHOST_BIN:-}" ] || [ ! -x "$BIN" ] || [ -n "$(find src/compiler/tools/docgen src/compiler/lexer src/compiler/parser src/compiler/ast src/compiler/loader src/compiler/printer -newer "$BIN" -name '*.sober' -print -quit)" ]; then
    tool_bin docgen "$PWD/$BIN" >&2 || { echo "stdref.sh: FAIL build src/compiler/tools/docgen" >&2; exit 1; }
fi

W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT

# entry <std の置き場> <出力>: std の全 package を import する合成の main（stage2.sh の l0_bake と同じ列挙）
entry() {
    { echo "package main"; echo; for d in $(cd "$1/.." && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done
      echo; echo "func main() {"; echo "}"; } > "$2"
}

# gen <出力の置き場>: docs/std の生成（警告の行は $W/warn.tsv）
gen() {
    mkdir -p "$1"
    entry src/std "$W/all.sober"
    "$BIN" gen src/std "$W/all.sober" . docs/std/en scripts/stdref/head.ja.md "$1" > "$W/warn.tsv"
}

# neg: 負例の警告の行（位置は testdata/stdref/neg 相対）
neg() {
    local N=testdata/stdref/neg
    mkdir -p "$W/neg"
    "$BIN" gen "$N/std" "$N/main.sober" . "$N/en" scripts/stdref/head.ja.md "$W/neg" | grep -v '^STAT' | sed "s#src/std/#std/#"
}

case "$mode" in
    regen)
        gen docs/std
        tail -n 1 "$W/warn.tsv"
        echo "stdref: regen docs/std ($(ls docs/std/*.ja.md | wc -l) files)"
        exit 0 ;;
    lint)
        gen "$W/out"
        cat "$W/warn.tsv"
        exit 0 ;;
    regenneg)
        neg > testdata/stdref/neg/expect.tsv
        echo "stdref: regen testdata/stdref/neg/expect.tsv ($(wc -l < testdata/stdref/neg/expect.tsv) lines)"
        exit 0 ;;
esac

fail=0
gen "$W/out"
# ① 生成物の一致（英訳表 en/ は生成物でない — 比べない）
if ! diff -r -x en "$W/out" docs/std > "$W/diff" 2>&1; then
    echo "stdref: FAIL docs/std is stale (scripts/stdref.sh --regen):"
    head -n 40 "$W/diff"
    fail=1
fi
# ② lint — en-* 以外は赤・en-* は種類ごとの数だけ
if grep -v '^WARN	en-' "$W/warn.tsv" | grep -q '^WARN'; then
    echo "stdref: FAIL doc lint (scripts/stdref.sh --lint):"
    grep -v '^WARN	en-' "$W/warn.tsv" | grep '^WARN' | head -n 40
    fail=1
fi
echo "stdref: lint en-* (warnings until the translation tables — B-3):"
grep '^WARN	en-' "$W/warn.tsv" | cut -f2 | sort | uniq -c | sed 's/^/  /' || true
tail -n 1 "$W/warn.tsv"
# ③ 負例
neg > "$W/neg.tsv"
if ! diff testdata/stdref/neg/expect.tsv "$W/neg.tsv" > "$W/negdiff"; then
    echo "stdref: FAIL negative cases (testdata/stdref/neg/expect.tsv):"
    cat "$W/negdiff"
    fail=1
fi
# 負例が各条を 1 回以上鳴らしていること（期待の黄金が空洞化しない）
for k in nodoc name jargon section example bold en-none en-missing en-stale; do
    grep -q "^WARN	$k	" testdata/stdref/neg/expect.tsv || { echo "stdref: FAIL negative case missing for $k"; fail=1; }
done
echo "stdref: docs/std $(ls docs/std/*.ja.md 2>/dev/null | wc -l) files, negative $(wc -l < testdata/stdref/neg/expect.tsv) warnings, fail=$fail"
[ "$fail" = 0 ]
