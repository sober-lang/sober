#!/usr/bin/env bash
# selfhostの第3ゴールデン（コアASTゴールデン — testdata/corejson/）の照合。主のsoberの `sober check <entry> --core-json`
# （脱糖器の出力 = Lean の Json.lean スキーマ）を固定する。
# 表だけをgitに置く: testdata/corejson/<entryの / を _ にした名前（.soberは落とす）>.coreh = 関数ごとのハッシュの表（scripts/goldtab.ts・docs/golden.md）。
# 1行目の `@@full` は全文のハッシュ（正規化しない）。関数（defs の要素）は名前を持たないので、行の名前は本体のハッシュ（def~…）。
# 全文は out/gold/core/<同じ名前>.json（gitの外。中身は1行のJSON + 改行）。全文を読むゲート（leanbatch・selfhost_check）は --gen で作り直してから読む。
# 差の中身 = scripts/golddiff.sh <基点> core [<題材>…]
#
#   scripts/corejson.sh            表とのdiff（対象の各entryを --core-json に通して比べる）。加えて2回吐いてバイト一致を検証する（決定性）
#   scripts/corejson.sh --regen    表を作り直す（脱糖器の意図した変更後に使い、差を見てからコミットする）
#   scripts/corejson.sh --gen      out/gold/core の全文が古ければ作り直すだけ（読み手のゲートが呼ぶ）
#   scripts/corejson.sh --list     対象の entry を 1 行ずつ出す（selfhost_desugar.sh が使う）
#
# 対象: examples/*.sober + マルチ package の testdata（*/app）+ testdata/pool/*.sober。
# 脱糖器が拒否するentryは表を持たず、EXCLUDED.txtにentryとエラーの1行目を並べる
# （拒否の理由が変わったり、通るようになったりしたら差分として出る — astjson の EXCLUDED と同じ流儀）。
# 前提: zig build 済み（$SOBER で差し替え可）。cwd = リポジトリルート（import パスはルート相対）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

SOBER=${SOBER:-./bin/sober}   # 生成元 = 主のsober（主役交代R39 — それまではZig版。付け替え時にバイト不変を確認済み）
gold_emit() { "$SOBER" check "$1" --core-json > "$2"; }
# call・callvは必ずanchor "r" を書く（Leanの読み手は、凍結したstage1の形を読むために "r" の省略を受けるので、ここで抜けを見る）
gold_job_check() {
    if grep -oE '"k":"callv?",("[a-z]+":)?' "$2" | grep -qv '"r":$'; then
        echo "FAIL: $1: a call or callv without the anchor \"r\""
    fi
}
# 対の照合（型の別名 — language.md 32 節）: 別名で書いたentryと、別名を手で実体の名前へ展開したentryのコアはバイト一致（コアは型の名前を持たない）
gold_post() {
    local pair ta tb bad=0
    for pair in "examples_alias examples_alias_expanded" "testdata_alias_app testdata_alias_x_app"; do
        read -r ta tb <<< "$pair"
        cmp -s "$1/$ta.json" "$1/$tb.json" || { echo "FAIL: core JSON of $ta differs from its expanded twin $tb (an alias is not transparent)"; bad=1; }
    done
    [ "$bad" = 0 ]
}
gold_text_main core corejson "$0" "$@"
