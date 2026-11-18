#!/usr/bin/env bash
# selfhostの第5ゴールデン（LLVMテキストゴールデン — testdata/lltext/）の照合。主のsoberの `sober build <entry> --emit=ll`
# （stage2 の compiler/lower → rtlower → llvm 印字。IR パスは掛けない既定の形 — docs/ir.md 8 節）を固定する。
# 表だけをgitに置く: testdata/lltext/<entryの / を _ にした名前（.soberは落とす）>.llh = 関数ごとのハッシュの表（scripts/goldtab.ts）。
# 1行目の `@@full` は全文のハッシュ（正規化しない — 全文が1バイトでも変われば変わる）。関数ごとの行は、どこが変わったかを読むためのもの。
# 全文は out/gold/ll/<同じ名前>.ll（gitの外）。全文を読むゲートは --gen で作り直してから読む。差の中身 = scripts/golddiff.sh <基点> ll [<題材>…]
#
#   scripts/lltext.sh            表とのdiff（対象の各entryを --emit=ll に通して比べる）。加えて2回吐いてバイト一致を確認する（決定性）
#   scripts/lltext.sh --regen    表を作り直す（lowerの意図した変更後に使い、差を見てからコミットする）
#   scripts/lltext.sh --gen      out/gold/ll の全文が古ければ作り直すだけ（読み手のゲートが呼ぶ）
#   scripts/lltext.sh --list     対象の entry を 1 行ずつ出す（selfhost_ll.sh が使う）
#
# 対象: corejson と同じ流儀 — examples/*.sober + マルチ package の testdata（*/app）+ testdata/pool/*.sober。
# 生成元のlowerが拒否するentryは表を持たず、EXCLUDED.txtにentryとエラーの1行目を並べる（拒否の理由が変わったり、
# 通るようになったりしたら差分として出る — corejson の EXCLUDED と同じ）。全文はランタイム @rt.* と入口 @sober_entry を含む。
# 前提: zig build 済み（bin/sober が stage2 を作り直す。$SOBER で差し替え可）。cwd = リポジトリルート（import パスはルート相対）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

# 生成元 = 主のsober（Q1決定 (a) 2026-09-28 — lowerは到達関数だけを下ろす。docs/ir.md 1 節）。Zig ≡ Sober は selfhost_lower / ll / cli が stage1 直呼びで見る
SOBER=${SOBER:-./bin/sober}
gold_emit() { "$SOBER" build "$1" --emit=ll -o "$2"; }
gold_text_main ll lltext "$0" "$@"
