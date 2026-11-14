#!/usr/bin/env bash
# selfhostの第4ゴールデン（IRテキストゴールデン — testdata/irtext/）の照合。主のsoberの `sober build <entry> --emit=ir`
# （stage2 の compiler/lower の出力 — docs/ir.md のテキスト形式。IR パスも rtlower も掛けない形）をバイト列のまま固定する。
# (c) codegen の Sober 化の境界（Sober 版 lower → IR テキスト → Zig 版バックエンド）の正。
#
#   scripts/irtext.sh            ゴールデンとのdiff（対象の各entryを --emit=ir に通して比較）。加えて2回吐いてバイト一致を確認する（決定性）
#   scripts/irtext.sh --regen    ゴールデンを再生成する（lowerの意図した変更後に使い、diffを見てからコミットする）
#   scripts/irtext.sh --list     対象の entry を 1 行ずつ出す（selfhost_lower.sh が使う）
#
# 対象: corejson と同じ流儀 — examples/*.sober + マルチ package の testdata（*/app）+ testdata/pool/*.sober。
# 生成元のlowerが拒否するentryはゴールデンを持たず、EXCLUDED.txtにentryとエラーの1行目を並べる（拒否の理由が変わったり、
# 通るようになったりしたら差分として出る — corejson の EXCLUDED と同じ）。
# ゴールデンの格納場所: testdata/irtext/<entryの / を _ にした名前（.soberは落とす）>.ir。中身は生成元の出力そのもの（ランタイム @rt.* と
# 入口 @sober_entry を含む全文 — 境界のテキストは 1 つのモジュール）。
# 前提: zig build 済み（bin/sober が stage2 を作り直す。$SOBER で差し替え可）。cwd = リポジトリルート（import パスはルート相対）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

# ゴールデンの生成元 = 主のsober（Q1決定 (a) 2026-09-28 — lowerは到達関数だけを下ろす。docs/ir.md 1 節）。Zig版からの付け替え時の差分は
# examples/union.sober の追加だけ（死んだ関数に Zig の lower が拒否を抱えていた — EXCLUDED 1 行減）。Zig ≡ Sober は selfhost_lower / ll / cli が stage1 直呼びで見る
SOBER=${SOBER:-./bin/sober}
GOLDEN=testdata/irtext
[ -x "$SOBER" ] || { echo "error: $SOBER not found"; exit 1; }
# 差分スキップ（$GATECACHE — scripts/gates.sh が立てる）: sober バイナリ・このスクリプト・入力の木の内容ハッシュが前回の成功時と同じなら照合しない
if [ $# -eq 0 ] && cache_hit irtext "$SOBER" "$(stage2_key)" "$0" examples testdata src/std; then
    echo "SKIP: inputs unchanged since the last pass (scripts/.gatecache/irtext.key)"
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
    if ! "$SOBER" build "$e" --emit=ir -o "$tmp/out/$k.ir" 2> "$PAR_W/err"; then
        rm -f "$tmp/out/$k.ir"
        echo "@@ excl $e: $(head -n 1 "$PAR_W/err")"
        return 0
    fi
    "$SOBER" build "$e" --emit=ir -o "$PAR_W/again"
    cmp -s "$tmp/out/$k.ir" "$PAR_W/again" || echo "FAIL: $e: output is not deterministic"
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
    echo "FAIL: IR text differs from $GOLDEN"
    echo "  (lower / ランタイム / 印字のどれかが変わった。意図した変更なら --regen)"
    head -n 20 "$tmp/diff"
    f=$(grep -m1 '^Files ' "$tmp/diff" | awk '{print $2}' || true)
    if [ -n "$f" ]; then
        diff "$GOLDEN/$(basename "$f")" "$f" | head -n 30 || true
    fi
    exit 1
fi
[ "$fail" = 0 ] || exit 1
[ $# -eq 0 ] && cache_store
echo "OK: $n entries match $GOLDEN (deterministic, $(wc -l < "$GOLDEN/EXCLUDED.txt") excluded)"
