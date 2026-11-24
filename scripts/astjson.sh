#!/usr/bin/env bash
# selfhost C4: 表層 AST JSON ゴールデン（testdata/astjson/）の照合。
#
#   scripts/astjson.sh            表とのdiff（examples/*.sober・testdata/**/*.sober・std/**/*.soberを
#                                 `sober parse --ast-json` に通して比べる）。加えて各ファイルを 2 回吐いて
#                                 バイト一致を検証する（決定性）
#   scripts/astjson.sh --regen    表を作り直す（cst_to_ast / スキーマの意図した変更後に使い、差を見てからコミットする）
#   scripts/astjson.sh --gen      out/gold/ast の全文が古ければ作り直すだけ（全文を読む道具が呼ぶ）
#
# 表だけをgitに置く: testdata/astjson/<ソースの相対パス>.asth（拡張子 .sober → .asth）= 宣言ごとのハッシュの表（scripts/goldtab.ts・docs/golden.md）。
# 1行目の `@@full` は全文のハッシュ（正規化しない）。宣言の行は位置のフィールドを外してハッシュを取る。
# 全文は out/gold/ast/<ソースの相対パス>.json（gitの外）。差の中身 = scripts/golddiff.sh <基点> ast [<ソースの相対パス（.soberを落とす）>…]
# cst_to_ast が拒否するファイル（parse のみの例）は testdata/astjson/EXCLUDED.txt に
# 「パス<TAB>エラー行」で並べる。拒否の理由が変わる / 通るようになるのも差分として検出する。
# 前提: zig build 済み（$SOBER で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
gate_env   # 鍵と出力の環境をゲートと揃える（直に呼んでも、gates.sh・regen.sh の中と同じ鍵になる）

SOBER=${SOBER:-./bin/sober}   # 生成元 = 主のsober（主役交代R39 — それまではZig版。付け替え時にバイト不変を確認済み）
GOLDEN=testdata/astjson
EXCLUDED=$GOLDEN/EXCLUDED.txt
mode=${1:-}

[ -x "$SOBER" ] || { echo "error: $SOBER not found (zig build)"; exit 1; }
# 差分スキップ（$GATECACHE — scripts/gates.sh が立てる）: sober バイナリ・このスクリプト・入力の木の内容ハッシュが前回の成功時と同じなら照合しない
if [ $# -eq 0 ] && cache_hit astjson "$SOBER" "$(stage2_key)" "$0" examples testdata src/std; then
    echo "SKIP: inputs unchanged since the last pass (scripts/.gatecache/astjson.key)"
    exit 0
fi

sources() {
    ls examples/*.sober
    find testdata src/std -name '*.sober' -not -path "$GOLDEN/*" | LC_ALL=C sort
}

key=$(gold_key "$0")
mkdir -p out/gold
if [ "$mode" = --gen ]; then
    # 生成の間は排他（並んで呼ばれても1回だけ作る）。取った後にもう一度鍵を見る
    exec 7> out/gold/.ast.gen
    flock 7
    [ -f out/gold/ast/.key ] && [ "$(cat out/gold/ast/.key)" = "$key" ] && exit 0
fi
full=$(mktemp -d "$PWD/out/gold/.ast.XXXXXX")
tmp=$(mktemp -d)
trap 'rm -rf "$tmp" "$full"' EXIT

fail=0
# ファイルごとの仕事を並列に（gatelibのpar_run — 出力は番号順にまとめるので除外の並びは直列と同じ。足回りのタスク）
JOBS=${JOBS:-$(nproc)}
par_init "$tmp"
job() { # $1 = ソース
    local src=$1 out
    out="$full/${src%.sober}.json"
    mkdir -p "$(dirname "$out")"
    if "$SOBER" parse --ast-json "$src" > "$out" 2> "$PAR_W/err"; then
        if [ "$mode" != --gen ]; then
            "$SOBER" parse --ast-json "$src" > "$PAR_W/again"
            cmp -s "$out" "$PAR_W/again" || echo "FAIL: $src: output is not deterministic"
        fi
        echo "@@ ok"
    else
        rm -f "$out"
        printf '@@ excl %s\t%s\n' "$src" "$(head -n 1 "$PAR_W/err")"
    fi
}
while IFS= read -r src; do par_run job "$src"; done < <(sources)
par_wait > "$tmp/res"
grep '^@@ excl ' "$tmp/res" | sed 's/^@@ excl //' > "$tmp/excluded" || true
if grep '^FAIL' "$tmp/res"; then fail=1; fi
# 除外したファイルの出力先にmkdir -p した空ディレクトリを刈る（gitは空ディレクトリを持たない — 表の木に残すと fresh clone / git archive の木で偽赤）
find "$full" -mindepth 1 -type d -empty -delete
n=$(grep -c '^@@ ok' "$tmp/res" || true)
# 除外の理由の列はゴールデンの文面を保つ（生成元の診断文 — gatelibのexcluded_keep）
excluded_keep "$tmp/excluded" "$EXCLUDED" "$(printf '\t')"
mkdir -p "$tmp/tab"
(cd "$full" && find . -name '*.json' | sed 's|^\./||' | LC_ALL=C sort) | xargs -r -n 60 -P "$JOBS" node scripts/goldtab.ts tab ast "$full" "$tmp/tab" > /dev/null || fail=1
cp "$tmp/excluded" "$tmp/tab/EXCLUDED.txt"
[ "$fail" = 0 ] || exit 1
gold_publish ast "$full" "$key"
[ "$mode" = --gen ] && exit 0

if [ "$mode" = --regen ]; then
    rm -rf "$GOLDEN"
    mkdir -p "$GOLDEN"
    cp -r "$tmp/tab/." "$GOLDEN/"
    echo "regenerated $GOLDEN ($n files, $(wc -l < "$EXCLUDED") excluded; full text in out/gold/ast)"
    exit 0
fi

[ -d "$GOLDEN" ] || { echo "error: $GOLDEN not found (--regen)"; exit 1; }
diff -r "$GOLDEN" "$tmp/tab" > "$tmp/diff" || {
    echo "FAIL: AST JSON differs from $GOLDEN"
    echo "  (cst_to_ast / emitter / スキーマのどれかが変わった。意図した変更なら --regen。宣言の全文の差分 = golddiff.sh HEAD ast <パス>)"
    head -n 40 "$tmp/diff"
    fail=1
}
[ "$fail" = 0 ] || exit 1
[ $# -eq 0 ] && cache_store
echo "OK: $n files match $GOLDEN (deterministic; $(wc -l < "$EXCLUDED") excluded)"
