#!/usr/bin/env bash
# selfhost C4: 表層 AST JSON 黄金（testdata/astjson/）の照合。
#
#   scripts/astjson.sh            黄金との diff（examples/*.sober・testdata/**/*.sober・std/**/*.sober を
#                                 `sober parse --ast-json` に通して比較）。加えて各ファイルを 2 回吐いて
#                                 バイト一致を確かめる（決定性）
#   scripts/astjson.sh --regen    黄金を再生成する（cst_to_ast / スキーマの意図した変更後に使い、
#                                 diff を見てからコミットする）
#
# 黄金の置き場: testdata/astjson/<ソースの相対パス>.json（拡張子 .sober → .json）。
# cst_to_ast が拒否するファイル（parse のみの例）は testdata/astjson/EXCLUDED.txt に
# 「パス<TAB>エラー行」で並べる。拒否の理由が変わる / 通るようになるのも差分として検出する。
# 前提: zig build 済み（$SOBER で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

SOBER=${SOBER:-./bin/sober}   # 黄金の生成元 = 主の sober（主役交代 R39 — それまでは Zig 版。付け替え時にバイト不変を確認済み）
GOLDEN=testdata/astjson
EXCLUDED=$GOLDEN/EXCLUDED.txt

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

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

regen=0
[ "${1:-}" = "--regen" ] && regen=1

fail=0
# ファイルごとの仕事を並列に（gatelib の par_run — 出力は番号順にまとめるので除外の並びは直列と同じ。足回りの便）
JOBS=${JOBS:-$(nproc)}
par_init "$tmp"
job() { # $1 = ソース
    local src=$1 out
    out="$tmp/out/${src%.sober}.json"
    mkdir -p "$(dirname "$out")"
    if "$SOBER" parse --ast-json "$src" > "$out" 2> "$PAR_W/err"; then
        "$SOBER" parse --ast-json "$src" > "$PAR_W/again"
        cmp -s "$out" "$PAR_W/again" || echo "FAIL: $src: output is not deterministic"
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
# 除外したファイルの出力先に mkdir -p した空ディレクトリを刈る（git は空ディレクトリを持たない — 黄金の木に残すと fresh clone / git archive の木で偽赤）
find "$tmp/out" -mindepth 1 -type d -empty -delete
n=$(grep -c '^@@ ok' "$tmp/res" || true)
# 除外の理由の列は黄金の文面を保つ（生成元の診断文 — gatelib の excluded_keep）
excluded_keep "$tmp/excluded" "$EXCLUDED" "$(printf '\t')"

if [ "$regen" = 1 ]; then
    [ "$fail" = 0 ] || exit 1
    rm -rf "$GOLDEN"
    mkdir -p "$GOLDEN"
    cp -r "$tmp/out/." "$GOLDEN/"
    cp "$tmp/excluded" "$EXCLUDED"
    echo "regenerated $GOLDEN ($n files, $(wc -l < "$EXCLUDED") excluded)"
    exit 0
fi

[ -d "$GOLDEN" ] || { echo "error: $GOLDEN not found (--regen)"; exit 1; }
cp "$tmp/excluded" "$tmp/out/EXCLUDED.txt"
diff -r "$tmp/out" "$GOLDEN" > "$tmp/diff" || {
    echo "FAIL: AST JSON differs from $GOLDEN"
    echo "  (cst_to_ast / emitter / スキーマのどれかが変わった。意図した変更なら --regen)"
    head -n 40 "$tmp/diff"
    fail=1
}
[ "$fail" = 0 ] || exit 1
[ $# -eq 0 ] && cache_store
echo "OK: $n files match $GOLDEN (deterministic; $(wc -l < "$EXCLUDED") excluded)"
