#!/usr/bin/env bash
# partinl（部分インライン — compiler/lower/irinl.sober の IL_HOTINS の道）の形の網: 写すかどうかは観測に出ない最適化なので、出力の照合
# （obs / optdiff）では外れても鳴らない（mapfuse.sh と同じ理由）。最適化のバックエンドの経路の IR（--stop-after=inline --dump-ir）で関数ごとの
# 呼び出しの数を照合する:
#   ① ループの中の std/utf8.Str は写す（examples/str_partial_inline の main・bench/1brc の main・bench/knucleotide の frequencies — 0 本）
#   ② ループの外の呼び出し点は写さない（examples/str_partial_inline の cut — 1 本）
#   ③ error を返す return 文の印を持たない大きい関数は写さない（bench/fasta の randomChunk の rt.slice_grow8 — exit だけの遅い道。写すと fasta +6.6%）
#   scripts/partinl.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
# want = ファイル:関数:呼ばれる関数:比較:数（eq = ちょうど・ge = 以上）。関数が '/' を含めば完全修飾（std の関数）・'*' はファイル全体
#   ④ 戻らない利用者の種（730 — report-728 A）: flate.insert は lazy / greedy の中へ写す（0 本）
#   ⑤ rt.* は種にしない（730 の負例の網）: rt.deadlock を呼ぶ rt.task_wait（眠りの器）が写らず呼び出しのまま残る（ファイル全体で ≥ 1 本）
for want in examples/str_partial_inline.sober:main:std/utf8.Str:eq:0 examples/str_partial_inline.sober:cut:std/utf8.Str:eq:1 \
    bench/1brc/main.sober:main:std/utf8.Str:eq:0 bench/knucleotide/main.sober:frequencies:std/utf8.Str:eq:0 bench/fasta/main.sober:randomChunk:rt.slice_grow8:ge:1 \
    bench/httparena/main.sober:std/compress/flate.lazy:std/compress/flate.insert:eq:0 \
    bench/httparena/main.sober:std/compress/flate.greedy:std/compress/flate.insert:eq:0 \
    bench/httparena/main.sober:*:rt.task_wait:ge:1; do
    IFS=: read -r src fn callee op k <<< "$want"
    ir=$W/$(echo "$src" | tr '/' '_').ir
    [ -f "$ir" ] || "$S2" build "$src" --emit=elf --passes --stop-after=inline --dump-ir -o "$ir" > /dev/null 2>&1 || { echo "FAIL: dump-ir $src"; fail=$((fail + 1)); continue; }
    pat="@main.$fn"
    case "$fn" in */*) pat="@${fn//\//\\/}" ;; esac
    if [ "$fn" = '*' ]; then
        got=$(grep -c "call @$callee(" "$ir")
    else
        body=$(awk "/^func $pat\\(/,/^}/" "$ir")
        if [ -z "$body" ]; then
            echo "FAIL: $src $fn: function not found in the inline-stage IR"
            fail=$((fail + 1))
            n=$((n + 1))
            continue
        fi
        got=$(echo "$body" | grep -c "call @$callee(")
    fi
    n=$((n + 1))
    if { [ "$op" = eq ] && [ "$got" != "$k" ]; } || { [ "$op" = ge ] && [ "$got" -lt "$k" ]; }; then
        echo "FAIL: $src $fn: $got calls to $callee (want $op $k)"
        fail=$((fail + 1))
    fi
done
echo "partinl: $n call-site shapes (loop sites copied / non-loop and unmarked kept), fail=$fail"
[ "$fail" = 0 ]
