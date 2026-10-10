#!/usr/bin/env bash
# 正規バックエンドの Sober 化の照合（B-1d）: Sober の正規バックエンド（stage2 の `build --emit=elf` —
# compiler/lower/x86.sober）の ELF が、stage1（凍結した Zig の正規バックエンド）が同じ IR テキストから建てた ELF（`build x.ir --no-opt`）と
# バイト一致すること + 実行の観測（stdout・終了コード）が期待値と一致すること（obs.sh --backend sober）。
# 中間成分（区間・置き場）は Zig と照合できない（src/ 凍結）— ずれは ELF の最初の不一致バイトから逆アセンブルの差分で場所を特定する。
# 列 = obs の列（examples/*.out・testdata/*/app.out）+ scripts/elfeq.list（観測の期待値を持たない入力 — 1 行 1 entry、# はコメント）。
# list の行は「entry [フラグ…]」（フラグは両側の build に渡す — 例: --test）。compiler/ で始まる entry は cwd = compiler/ で建てる（import は compiler/ 相対）
# 形は 3 つ（下の cmp3 — IR パスなし・mem2reg・設計整合パス + mem2reg）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
STAGE1=$STAGE1 scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
entries=()
for f in examples/*.out; do entries+=("examples/$(basename "$f" .out).sober"); done
for f in testdata/*/app.out; do entries+=("${f%.out}"); done
if [ -f scripts/elfeq.list ]; then
    while IFS= read -r l; do
        l=${l%%#*}
        l=$(echo "$l" | sed 's/^ *//; s/ *$//')
        [ -n "$l" ] && entries+=("$l")
    done < scripts/elfeq.list
fi
# 列ごとに 3 つの形を比べる（stage1 の側は同じ IR テキスト）:
#   raw     stage2 --emit=ir         → stage1 build x.ir --no-opt   ≡ stage2 --emit=elf --no-opt
#   m2r     stage2 --emit=ir         → stage1 build x.ir（mem2reg）  ≡ stage2 --emit=elf（mem2reg — B-3）
#   passes  stage2 --emit=ir --passes → stage1 build x.ir（mem2reg） ≡ stage2 --emit=elf --passes（bin/sober の既定の形）
# stage2 の ELF の側は写しのバックエンド（--backend=copy — 性能投資 M4 の両持ち。既定の最適化のバックエンドは stage1 が追えないので obs / optdiff が見る）
cmp3() { # $1 = 行 $2 = 鍵 $3 = 形の名前 $4 = cwd $5 = src $6 = フラグ $7 = IR のフラグ $8 = stage1 のフラグ $9 = ELF のフラグ
    local line=$1 k=$2.$3 cwd=$4 src=$5 flags=$6
    if ! (cd "$cwd" && "$S2" build "$src" $flags $7 --emit=ir -o "$W/$k.ir") 2> "$W/$k.err"; then
        echo "FAIL: $line [$3]: --emit=ir: $(head -c 200 "$W/$k.err")"; return
    fi
    # stage1 の IR の語彙を越える entry（float の段 — gatelib の beyond_stage1）は照合しない（観測は obs --backend sober が見る）
    if beyond_stage1 "$W/$k.ir"; then
        touch "$W/beyond.$2"; rm -f "$W/$k.ir"; return
    fi
    if ! "$STAGE1" build "$W/$k.ir" $8 -o "$W/$k.z" 2> "$W/$k.err"; then
        echo "FAIL: $line [$3]: stage1 build x.ir: $(head -c 200 "$W/$k.err")"; return
    fi
    if ! (cd "$cwd" && "$S2" build "$src" $flags $9 --emit=elf -o "$W/$k.s") 2> "$W/$k.err"; then
        echo "FAIL: $line [$3]: --emit=elf: $(head -c 200 "$W/$k.err")"; return
    fi
    if ! cmp -s "$W/$k.s" "$W/$k.z"; then
        echo "FAIL: $line [$3]: ELF differs from stage1 ($(cmp "$W/$k.s" "$W/$k.z" 2>&1 | head -1 | sed 's/.* differ: //'); sizes $(stat -c %s "$W/$k.s") / $(stat -c %s "$W/$k.z"))"
    fi
    rm -f "$W/$k.ir" "$W/$k.s" "$W/$k.z"
}
one() { # $1 = 列の 1 行。結果は $W/r/<鍵>（空なら ok、FAIL の行が並べば失敗）
    local line=$1 src flags k cwd
    read -r src flags <<< "$line"
    k=$(echo "$line" | tr '/ ' '__')
    cwd=$ROOT
    case "$src" in src/compiler/*) cwd=$ROOT/src/compiler; src=${src#src/compiler/} ;; esac
    {
        cmp3 "$line" "$k" raw "$cwd" "$src" "$flags" "" --no-opt "--no-opt --backend=copy"
        cmp3 "$line" "$k" m2r "$cwd" "$src" "$flags" "" "" --backend=copy
        cmp3 "$line" "$k" passes "$cwd" "$src" "$flags" --passes "" "--passes --backend=copy"
    } > "$W/r/$k"
}
mkdir -p "$W/r"
J=${JOBS:-$(nproc)}
for line in "${entries[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$J" ]; do wait -n || true; done
    one "$line" &
done
wait
fail=0
n=0
for f in "$W"/r/*; do
    n=$((n + 1))
    if [ -s "$f" ]; then cat "$f"; fail=1; fi
done
scripts/obs.sh --backend sober > "$W/obs.log" 2>&1 || { cat "$W/obs.log"; fail=1; }
echo "elfeq: $n entries × 3 forms (raw / mem2reg / passes) compared with stage1 (beyond the stage1 IR vocabulary: $(ls "$W" | grep -c '^beyond\.')), $(tail -1 "$W/obs.log"), fail=$fail"
[ "$fail" = 0 ]
