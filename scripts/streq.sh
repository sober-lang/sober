#!/usr/bin/env bash
# streq（短い等値の高速パスの差分オラクル — report-451）: stringの == / != は、呼び出し点で長さを先に比べ（S1）・8バイト以下のリテラルとは
# 呼ばずに1ワードで閉じ（S2 — compiler/lower/cont.sober strEqual）・rt.str_eqの8バイト未満のパスは1ワードの比較（R1 — compiler/lower/rt.sober buildStrEq）。
# どれも「ページの末尾7バイトに掛かる番地ではバイトの環 / rt.str_eqへ」の分岐を持ち、配置先をSoberから選べないので、そのパスは
# 開発用 --rt-mutant=12（3 つとも旧来の形 = 常に rt.str_eq を呼び・rt はバイトの環）と既定の出力を突き合わせて見る。
# 列 = examples/*.out・testdata/*/app.outのうちIRがrt.str_eqを呼ぶもの（S2の閉じるパスも低速パスで呼ぶので、stringの等値の点を持つentry全部）（examples/streq_lengthsが網羅の例）+ 題材3本
# （logagg・routing・jsonapi — 入力が out/bench に置いてあれば）
#   scripts/streq.sh
set -uo pipefail
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0; n=0
one() {
    local src=$1 inp=$2; shift 2
    local k
    k=$(echo "$src" | tr '/' '_')
    "$S2" build "$src" --emit=elf --passes -o "$W/$k.new" > /dev/null 2>&1 || { echo "FAIL build $src"; fail=$((fail + 1)); return; }
    "$S2" build "$src" --emit=elf --passes --rt-mutant=12 -o "$W/$k.old" > /dev/null 2>&1 || { echo "FAIL build (old) $src"; fail=$((fail + 1)); return; }
    timeout -s KILL 60 "$W/$k.new" "$@" < "$inp" > "$W/$k.o1" 2> /dev/null; e1=$?
    timeout -s KILL 60 "$W/$k.old" "$@" < "$inp" > "$W/$k.o2" 2> /dev/null; e2=$?
    n=$((n + 1))
    if [ $e1 != $e2 ] || ! cmp -s "$W/$k.o1" "$W/$k.o2"; then echo "FAIL $src (exit $e1 / $e2)"; fail=$((fail + 1)); fi
}
ents=()
for f in examples/*.out; do ents+=("examples/$(basename "$f" .out).sober"); done
for f in testdata/*/app.out; do ents+=("${f%.out}"); done
# 対象（.out を持つ = 実行できる）の build が失敗したら名前を残す — 件数の減少に失敗が隠れない（失敗してよい対象の一覧と照合）
: > "$W/tried"; : > "$W/omitted"
for e in "${ents[@]}"; do
    echo "$e" >> "$W/tried"
    "$S2" build "$e" --emit=ir -o "$W/ir" > /dev/null 2>&1 || { echo "$e" >> "$W/omitted"; continue; }
    grep -q 'rt\.str_eq' "$W/ir" || continue
    inp=/dev/null
    [ -f "${e%.sober}.in" ] && inp=${e%.sober}.in
    one "$e" "$inp"
done
nreq=$n   # 必須の題材（examples・testdata）— 以下は out/bench の入力のデータが有るときだけ足す題材
omit_judge streq scripts/omit/streq.list "$W/tried" "$W/omitted" || fail=$((fail + 1))
[ -f out/bench/logagg-500000.txt ] && one bench/logagg/main.sober /dev/null out/bench/logagg-500000.txt
[ -f out/bench/routing-500000.txt ] && one bench/routing/main.sober /dev/null out/bench/routing-500000.txt
[ -f out/bench/jsonapi-100000.ndjson ] && one bench/jsonapi/main.sober /dev/null out/bench/jsonapi-100000.ndjson
echo "streq: $n entries with string equality ($nreq from examples / testdata + $((n - nreq)) of 3 from out/bench) — fast paths ≡ rt.str_eq byte loop (stdout + exit), fail=$fail"
[ $fail = 0 ]
