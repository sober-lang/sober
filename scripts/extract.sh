#!/usr/bin/env bash
# Lean → Sober 抽出器（E1 / E2）の照合と作り直し。
#
#   scripts/extract.sh            = --check
#   scripts/extract.sh --check    ①抽出器を走らせた結果 ≡ コミット済みの生成物（compiler/checker/ty_gen.sober・tc_gen.sober）
#                                 ②負例が全部止まる（sober-extract --neg）
#                                 ③tyvec: Lean の評価（sober-gen --tyvec）≡ 生成物の計算（tyvecdump）を全行バイト比較
#   scripts/extract.sh --regen    生成物を作り直す（Lean の定義・抽出器・設定を意図して変えたとき — diff を見てからコミット）
#
# 生成物は compiler/checker の package に入って建つ（抽出器 E2 — 手書きの写しは退役。移行期の --hand〔旧 ≡ 新〕は E2 で役目を終えて撤去）。
# 前提: lean/ で lake が使える（sober-extract / sober-gen はここで建てる）・bin/sober
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
GEN_OUT=src/compiler/checker/ty_gen.sober
TC_OUT=src/compiler/checker/tc_gen.sober   # typecheck の 1 フレームの遷移（段 6 P2b — lean/FeatherweightSober/TcStep.lean）
SEED=${TYVEC_SEED:-42}
COUNT=${TYVEC_COUNT:-224000}   # 28 関数 × 8000

mode=${1:---check}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

(cd lean && lake build sober-extract sober-gen > "$tmp/lake.log" 2>&1) || { cat "$tmp/lake.log"; echo "FAIL: lake build sober-extract sober-gen"; exit 1; }
extract() { (cd lean && lake env .lake/build/bin/sober-extract "$@"); }

if [ "$mode" = --regen ]; then
    extract > "$GEN_OUT"
    echo "regenerated $GEN_OUT ($(wc -l < "$GEN_OUT") lines)"
    extract --tc > "$TC_OUT"
    echo "regenerated $TC_OUT ($(wc -l < "$TC_OUT") lines)"
    exit 0
fi

# 型の表現（ty.sober — 型の記録・tg / tA / mk …・型の印字の手前まで）+ 生成物を tyvecdump に連結して建て、tyvec を照合する
tyvec() {
    awk '/^\/\/ ── 型の印字/{exit} {print}' src/compiler/checker/ty.sober > "$tmp/rep.sober"
    mkdir -p "$tmp/tv"
    { cat lean/Extract/sober/tyvecdump.sober; for f in "$tmp/rep.sober" "$GEN_OUT" lean/Extract/sober/shim_gen.sober; do grep -v '^package \|^import ' "$f"; done; } > "$tmp/tv/main.sober"
    (cd "$tmp/tv" && "$ROOT/bin/sober" build main.sober -o "$tmp/tyvecdump") || { echo "FAIL: build tyvecdump"; exit 1; }
    lean/.lake/build/bin/sober-gen --tyvec "$SEED" "$COUNT" > "$tmp/tyvec.txt"
    "$tmp/tyvecdump" < "$tmp/tyvec.txt" > "$tmp/out.txt"
    if ! cmp -s "$tmp/tyvec.txt" "$tmp/out.txt"; then
        echo "FAIL: tyvec: Lean の評価と食い違う行がある（先頭 5 件 — 上 = Lean・下 = Sober）"
        diff "$tmp/tyvec.txt" "$tmp/out.txt" | head -12
        exit 1
    fi
    echo "OK: tyvec: $(wc -l < "$tmp/tyvec.txt") vectors agree with Lean (seed $SEED)"
}

extract > "$tmp/ty_gen.sober"
if ! cmp -s "$tmp/ty_gen.sober" "$GEN_OUT"; then
    echo "FAIL: 抽出器の結果がコミット済みの $GEN_OUT と違う（Lean の定義・抽出器・設定が変わった — 意図した変更なら --regen）"
    diff "$GEN_OUT" "$tmp/ty_gen.sober" | head -20
    exit 1
fi
echo "OK: $GEN_OUT matches the extractor"
extract --tc > "$tmp/tc_gen.sober"
if ! cmp -s "$tmp/tc_gen.sober" "$TC_OUT"; then
    echo "FAIL: 抽出器の結果がコミット済みの $TC_OUT と違う（Lean の定義・抽出器・設定が変わった — 意図した変更なら --regen）"
    diff "$TC_OUT" "$tmp/tc_gen.sober" | head -20
    exit 1
fi
echo "OK: $TC_OUT matches the extractor"
extract --neg > "$tmp/neg.log" || { cat "$tmp/neg.log"; echo "FAIL: 負例が止まらない"; exit 1; }
echo "OK: negative cases all stopped ($(grep -c '^ok:' "$tmp/neg.log"))"
tyvec
