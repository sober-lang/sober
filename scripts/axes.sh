#!/usr/bin/env bash
# 宣言なき軸の線（report-1282 / 1283 — 今日の 4 件〔raw 展開の肥大・黄金 361 MB の混入未遂 …〕は線を宣言していない軸の無自覚な劣化だった）:
# 決定的な軸を bench/ratchet.txt の上限と照合する（生成はしない — 黄金を stat して awk で舐めるだけ・2 秒前後）。
#   golden/<種類> maxfile <MB>   testdata/<種類> の 1 ファイルの最大（黄金の外れ値 — cli の raw の irtext 30 MB / lltext 80 MB はこれで鳴る）
#   golden/<種類> total <MB> ref 合計（記録だけ — 例題を足せば正当に伸びる）
#   ir/maxfn lines <行>          raw IR（testdata/irtext の黄金）の 1 関数の最大行数（展開の掛け算 — @std/cli.Spec の 110 万行はこれで鳴る）
# 越えたら実測 × 1.005 で引き直し・報告とコミットメッセージに明記して事後追認（標準運用）。
#   scripts/axes.sh [--warn]   --warn = 越えても終了 0（regen.sh の末尾の照合 — 行は WARN で出す）
set -uo pipefail
cd "$(dirname "$0")/.."
R=bench/ratchet.txt
warn=0
[ "${1:-}" = "--warn" ] && warn=1
fail=0
n=0
bad() { if [ $warn = 1 ]; then echo "WARN: $1"; else echo "FAIL: $1"; fail=1; fi; }
while read -r item field lim ref; do
    case "$item" in golden/*) ;; *) continue ;; esac
    k=${item#golden/}
    [ -d "testdata/$k" ] || { bad "$item: testdata/$k が無い"; continue; }
    case "$field" in
        maxfile)
            read -r sz f < <(find "testdata/$k" -type f -printf '%s %p\n' | sort -n | tail -1)
            mb=$(awk -v s="$sz" 'BEGIN { printf "%.3f", s / 1e6 }')
            n=$((n + 1))
            if awk -v a="$mb" -v b="$lim" 'BEGIN { exit !(a > b) }'; then bad "$item maxfile ${mb} MB > ${lim} MB ($f — bench/ratchet.txt)"; else echo "ok: $item maxfile ${mb} MB ≤ ${lim} MB ($f)"; fi ;;
        total)
            mb=$(find "testdata/$k" -type f -printf '%s\n' | awk '{ t += $1 } END { printf "%.1f", t / 1e6 }')
            echo "ref: $item total ${mb} MB (記録 ${lim} MB)" ;;
    esac
done < <(grep -v '^#' "$R")
lim=$(awk '$1 == "ir/maxfn" && $2 == "lines" { print $3 }' "$R")
if [ -n "$lim" ]; then
    read -r m fn f < <(awk '/^func /{ n = $2; sub(/\(.*/, "", n); c = 0 } { c++ } /^}/{ if (c > m) { m = c; mn = n; mf = FILENAME } } END { print m + 0, mn, mf }' testdata/irtext/*.ir)
    n=$((n + 1))
    if [ "$m" -gt "$lim" ]; then bad "ir/maxfn $m lines > $lim ($fn in $f — bench/ratchet.txt)"; else echo "ok: ir/maxfn $m lines ≤ $lim ($fn in $f)"; fi
fi
echo "axes: $n lines in bench/ratchet.txt (golden maxfile / ir maxfn), fail=$fail"
[ "$fail" = 0 ]
