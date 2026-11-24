#!/usr/bin/env bash
# 宣言なき軸の上限値（report-1282 / 1283 — 今日の4件〔raw展開の肥大・ゴールデン361 MBの混入未遂 …〕は上限値を宣言していない軸の無自覚な劣化だった）:
# 決定的な軸をbench/ratchet.txtの上限と照合する（生成はしない — ゴールデンをstatしてawkで舐めるだけ・2秒前後）。
# irtext・lltext は表（scripts/goldtab.ts）の列から読む: 全文の大きさ = `@@full` の行のバイト数・関数の行数 = 関数の行の行数
#   golden/<種類> maxfile <MB>   1題材の全文の最大（ゴールデンの外れ値 — cliのrawのirtext 30 MB / lltext 80 MBはこれで鳴る）
#   golden/<種類> total <MB> ref 合計（記録だけ — 例題を足せば正当に伸びる）
#   ir/maxfn lines <行>          raw IR（testdata/irtextの表）の1関数の最大行数（展開の掛け算 — @std/cli.Specの110万行はこれで鳴る）
# 越えたら実測 × 1.005で再設定・報告とコミットメッセージに明記して事後承認（標準運用）。
#   scripts/axes.sh [--warn]   --warn = 越えても終了 0（regen.sh の末尾の照合 — 行は WARN で出す）
set -uo pipefail
cd "$(dirname "$0")/.."
. scripts/gatelib.sh
R=bench/ratchet.txt
warn=0
[ "${1:-}" = "--warn" ] && warn=1
fail=0
n=0
# sizes <種類>: 題材の全文ごとに「バイト数 名前」（表のあるゴールデンは @@full の行から・ほかはファイルの大きさ）
sizes() {
    if compgen -G "testdata/$1/*.*h" > /dev/null; then
        awk -F"\t" 'FNR == 1 && $1 == "@@full" { print $4, FILENAME }' "testdata/$1"/*.*h
    else
        find "testdata/$1" -type f -printf '%s %p\n'
    fi
}
bad() { if [ $warn = 1 ]; then echo "WARN: $1"; else echo "FAIL: $1"; fail=1; fi; }
lfail=0
lbad() { if [ $warn = 1 ]; then echo "WARN: $1"; else echo "FAIL: $1"; lfail=1; fi; }   # 線との比較の赤（ratchet_cmp — 線の値の変更は記録の実測で再判定される）
while read -r item field lim ref; do
    case "$item" in golden/*) ;; *) continue ;; esac
    k=${item#golden/}
    [ -d "testdata/$k" ] || { bad "$item: testdata/$k が無い"; continue; }
    case "$field" in
        maxfile)
            read -r sz f < <(sizes "$k" | sort -n | tail -1)
            mb=$(awk -v s="$sz" 'BEGIN { printf "%.3f", s / 1e6 }')
            n=$((n + 1))
            if ratchet_cmp "$R" "$item" maxfile "$mb"; then echo "ok: $item maxfile ${mb} MB ≤ ${RATCHET_LIM} MB ($f)"; else lbad "$item maxfile ${mb} MB > ${RATCHET_LIM} MB ($f — bench/ratchet.txt)"; fi ;;
        total)
            mb=$(sizes "$k" | awk '{ t += $1 } END { printf "%.1f", t / 1e6 }')
            echo "ref: $item total ${mb} MB (記録 ${lim} MB)" ;;
    esac
done < <(grep -v '^#' "$R")
if grep -q '^ir/maxfn lines ' "$R"; then
    read -r m fn f < <(awk -F"\t" 'FNR > 1 && $1 != "@globals" && $3 > m { m = $3; mn = $1; mf = FILENAME } END { print m + 0, mn, mf }' testdata/irtext/*.irh)
    n=$((n + 1))
    if ratchet_cmp "$R" ir/maxfn lines "$m"; then echo "ok: ir/maxfn $m lines ≤ $RATCHET_LIM ($fn in $f)"; else lbad "ir/maxfn $m lines > $RATCHET_LIM ($fn in $f — bench/ratchet.txt)"; fi
fi
echo "axes: $n lines in bench/ratchet.txt (golden maxfile / ir maxfn), fail=$fail, ratchet fail=$lfail"
[ "$fail" = 0 ] && meas_body_ok
[ "$fail" = 0 ] && [ "$lfail" = 0 ]
