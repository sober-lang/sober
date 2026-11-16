#!/usr/bin/env bash
# 配置の計測のオプション（開発用 `--layout-save` / `--layout-pin` / `--layout-gap`。実装はcompiler/lower/place.sober）の検査。
#   1. 自分の表で固定したビルドが、表を保存したビルドとバイト一致する（`--layout=S` つきでも）。固定したビルドの表は元の表と一致する。
#      保存したビルド（コードとrodataの後ろに余白を取る）の例は、例の .outと同じ出力を出す
#   2. 実行頻度の低い関数を1つ変えたビルド（bench/httparenaのTLSの起動の1行を2回にする）を基準の表で固定したとき、変えた関数のほかは、表と同じ番地・
#      同じバイト列になる（番号の再配置〔種類3〜5〕はSOBER_NUMNOPATCH=1で外す）。動いた関数の数と理由の内訳を印字する
#   3. `--layout-gap` のELFは、元と違うバイト列で、同じ出力を出す（例の .outと照合）。`--layout-pin` と組むと、表と同じ番地に置いた関数は動かない
# 使い方: scripts/laypin.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
B() { "$S2" build "$@" > "$W/err" 2>&1 || { echo "FAIL: build $*: $(head -c 300 "$W/err")"; fail=$((fail + 1)); return 1; }; }
ENTRIES=(bench/httparena/main.sober examples/fib.sober examples/task_map.sober examples/sort_order.sober)
for e in "${ENTRIES[@]}"; do
    for L in "" "--layout=3"; do
        B "$e" $L --layout-save="$W/t" -o "$W/s" || continue
        B "$e" $L --layout-pin="$W/t" --layout-save="$W/t2" -o "$W/p" || continue
        cmp -s "$W/s" "$W/p" || { echo "FAIL: $e $L: pinned to its own table ≢ the saving build"; fail=$((fail + 1)); }
        cmp -s "$W/t" "$W/t2" || { echo "FAIL: $e $L: the table of the pinned build ≢ the table"; fail=$((fail + 1)); }
        if [ -f "${e%.sober}.out" ]; then
            "$W/s" > "$W/out" 2>&1
            cmp -s "$W/out" "${e%.sober}.out" || { echo "FAIL: $e $L: the saving build changed the output"; fail=$((fail + 1)); }
        fi
        n=$((n + 1))
    done
done
# 2. 実行頻度の低い関数の変更（serveTlsの起動の1行を2回にする）
mkdir -p "$W/h"
cp bench/httparena/main.sober "$W/h/main.sober"
grep -q '_ = io.WriteStdout(bytes("tls-ready ${tport}\\n"))' "$W/h/main.sober" || { echo "FAIL: the edit form was not found in bench/httparena/main.sober"; fail=$((fail + 1)); }
sed -i 's/^\(    _ = io.WriteStdout(bytes("tls-ready ${tport}\\n"))\)$/\1\n\1/' "$W/h/main.sober"
if SOBER_NUMNOPATCH=1 B bench/httparena/main.sober --layout-save="$W/ta" -o "$W/a" &&
   SOBER_NUMNOPATCH=1 B "$W/h/main.sober" --layout-pin="$W/ta" --layout-save="$W/tb" -o "$W/b"; then
    node --experimental-strip-types scripts/laypin.ts "$W/ta" "$W/tb" "$W/a" "$W/b" '@main.serveTls' || fail=$((fail + 1))
fi
# 3. パディングの系列
for e in examples/abstraction_handler.sober examples/domain_requeue.sober examples/task_map.sober; do
    B "$e" -o "$W/base" && B "$e" --layout-gap=5 -o "$W/g" || continue
    cmp -s "$W/base" "$W/g" && { echo "FAIL: $e: --layout-gap=5 did not move anything"; fail=$((fail + 1)); }
    "$W/g" > "$W/out" 2>&1
    cmp -s "$W/out" "${e%.sober}.out" || { echo "FAIL: $e: --layout-gap=5 changed the output"; fail=$((fail + 1)); }
done
# 固定と組んだ系列: 実行頻度の低い関数を変えたビルドで、表と同じ番地に置いた関数は動かず、表の後ろの関数だけがずれる
if SOBER_NUMNOPATCH=1 B "$W/h/main.sober" --layout-pin="$W/ta" --layout-gap=3 --layout-save="$W/tg" -o "$W/bg"; then
    node --experimental-strip-types scripts/laypin.ts "$W/ta" "$W/tg" "$W/a" "$W/bg" '@main.serveTls' || fail=$((fail + 1))
    [ "$(grep ' @main.serveTls$' "$W/tb" | cut -d' ' -f2)" != "$(grep ' @main.serveTls$' "$W/tg" | cut -d' ' -f2)" ] || { echo "FAIL: --layout-gap=3 with --layout-pin did not move the function placed after the table"; fail=$((fail + 1)); }
fi
echo "laypin: $n builds pinned to their own table: ELF identical, fail=$fail"
[ "$fail" = 0 ]
