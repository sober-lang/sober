#!/usr/bin/env bash
# selfhostの第3ゴールデン（コアASTゴールデン — testdata/corejson/）の照合。Zig版の `sober check <entry> --core-json`
# （脱糖器 src/stage1/desugar.zig の出力 = Lean の Json.lean スキーマ）をバイト列のまま固定する。
#
#   scripts/corejson.sh            ゴールデンとのdiff（対象の各entryを --core-json に通して比較）。加えて2回吐いてバイト一致を検証する（決定性）
#   scripts/corejson.sh --regen    ゴールデンを再生成する（脱糖器の意図した変更後に使い、diffを見てからコミットする）
#   scripts/corejson.sh --list     対象の entry を 1 行ずつ出す（selfhost_desugar.sh が使う）
#
# 対象: examples/*.sober + マルチ package の testdata（*/app）+ testdata/pool/*.sober。
# Zig版の脱糖器が拒否するentryはゴールデンを持たず、EXCLUDED.txtにentryとエラーの1行目を並べる
# （拒否の理由が変わったり、通るようになったりしたら差分として出る — astjson の EXCLUDED と同じ流儀）。
# ゴールデンの配置先: testdata/corejson/<entryの / を _ にした名前（.soberは落とす）>.json。中身は1行のJSON + 改行（Zig版の出力そのもの）。
# 前提: zig build 済み（$SOBER で差し替え可）。cwd = リポジトリルート（import パスはルート相対）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

SOBER=${SOBER:-./bin/sober}   # ゴールデンの生成元 = 主のsober（主役交代R39 — それまではZig版。付け替え時にバイト不変を確認済み）
GOLDEN=testdata/corejson
[ -x "$SOBER" ] || { echo "error: $SOBER not found (zig build)"; exit 1; }
# 差分スキップ（$GATECACHE — scripts/gates.sh が立てる）: sober バイナリ・このスクリプト・入力の木の内容ハッシュが前回の成功時と同じなら照合しない
if [ $# -eq 0 ] && cache_hit corejson "$SOBER" "$(stage2_key)" "$0" examples testdata src/std; then
    echo "SKIP: inputs unchanged since the last pass (scripts/.gatecache/corejson.key)"
    exit 0
fi

entries() {
    ls examples/*.sober
    for d in testdata/*/app; do echo "$d"; done
    ls testdata/pool/*.sober
}

if [ "${1:-}" = "--list" ]; then
    entries
    exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

regen=0
[ "${1:-}" = "--regen" ] && regen=1

mkdir -p "$tmp/out"
: > "$tmp/out/EXCLUDED.txt"
fail=0
# entryごとの仕事を並列に（gatelibのpar_run — 出力は番号順にまとめるのでEXCLUDEDの並びは直列と同じ。足回りのタスク）
JOBS=${JOBS:-$(nproc)}
par_init "$tmp"
job() { # $1 = entry
    local e=$1 k
    k=$(echo "$e" | tr '/' '_')
    k=${k%.sober}
    if ! "$SOBER" check "$e" --core-json > "$tmp/out/$k.json" 2> "$PAR_W/err"; then
        rm -f "$tmp/out/$k.json"
        echo "@@ excl $e: $(head -n 1 "$PAR_W/err")"
        return 0
    fi
    "$SOBER" check "$e" --core-json > "$PAR_W/again"
    cmp -s "$tmp/out/$k.json" "$PAR_W/again" || echo "FAIL: $e: output is not deterministic"
    echo "@@ ok"
}
# testdata/golden_skip.txtのentryはゴールデンを作らない（--listは絞らない — 他のゲートが全entryを読む）
while IFS= read -r e; do par_run job "$e"; done < <(entries | grep -vxF -f <(grep -v "^#" testdata/golden_skip.txt))
par_wait > "$tmp/res"
grep '^@@ excl ' "$tmp/res" | sed 's/^@@ excl //' > "$tmp/out/EXCLUDED.txt" || true
if grep '^FAIL' "$tmp/res"; then fail=1; fi
n=$(grep -c '^@@ ok' "$tmp/res" || true)
# 除外の理由の列はゴールデンの文面を保つ（生成元の診断文 — gatelibのexcluded_keep）
excluded_keep "$tmp/out/EXCLUDED.txt" "$GOLDEN/EXCLUDED.txt" ": "

if [ "$regen" = 1 ]; then
    [ "$fail" = 0 ] || exit 1
    rm -rf "$GOLDEN"
    mkdir -p "$GOLDEN"
    cp -r "$tmp/out/." "$GOLDEN/"
    echo "regenerated $GOLDEN ($n entries, $(wc -l < "$GOLDEN/EXCLUDED.txt") excluded)"
    exit 0
fi

[ -d "$GOLDEN" ] || { echo "error: $GOLDEN not found (--regen)"; exit 1; }
if ! diff -rq "$tmp/out" "$GOLDEN" > "$tmp/diff"; then
    echo "FAIL: core JSON differs from $GOLDEN"
    echo "  (脱糖器 / スキーマのどれかが変わった。意図した変更なら --regen)"
    head -n 20 "$tmp/diff"
    # 1 本目の差分を整形して見せる（1 行 JSON なので jq で割る）
    f=$(grep -m1 '^Files ' "$tmp/diff" | awk '{print $2}' || true)
    if [ -n "$f" ] && command -v jq > /dev/null; then
        g="$GOLDEN/$(basename "$f")"
        diff <(jq . "$g" 2> /dev/null || cat "$g") <(jq . "$f" 2> /dev/null || cat "$f") | head -n 30 || true
    fi
    exit 1
fi
# 対の照合（型の別名 — language.md 32 節）: 別名で書いたentryと、別名を手で実体の名前へ展開したentryのコアはバイト一致（コアは型の名前を持たない）
for pair in "examples_alias examples_alias_expanded" "testdata_alias_app testdata_alias_x_app"; do
    read -r ta tb <<< "$pair"
    cmp -s "$GOLDEN/$ta.json" "$GOLDEN/$tb.json" || { echo "FAIL: core JSON of $ta differs from its expanded twin $tb (an alias is not transparent)"; fail=1; }
done
[ "$fail" = 0 ] || exit 1
[ $# -eq 0 ] && cache_store
echo "OK: $n entries match $GOLDEN (deterministic, $(wc -l < "$GOLDEN/EXCLUDED.txt") excluded)"
