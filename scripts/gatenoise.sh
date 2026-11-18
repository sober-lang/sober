#!/usr/bin/env bash
# 揺れの試験の道具（design-gates-robust-0）: 計測で判定するゲートを、決まった形の負荷の下で N 回回し、判定に使う量の分布を出す。
# 負荷 = CPU の数の 3/4 本の空回しを、12秒ごとに入れて切る（全部の CPU・プロセスグループごと止める）。GATENOISE_LOAD=0 で負荷なし（比べる用）。
# ゲートは判定に使う量を `gatenoise: <ゲート> <題目> key=value …` の1行で出す（ringinst・areacheck・oversub）。数の値は最小・中央値・最大を、
# `,` で区切った列の値（対の差など）は全部の要素を並べて同じく集計する。ゲートの結果（PASS / FAIL）の数も出す。
#   scripts/gatenoise.sh <ゲート> [N（既定5）]
# 時間がかかり、負荷を作るので、ふだんのゲートには入れない。サーバーでは待ち行列のふつうの枠で（負荷の分を見込んで、ナビに枠の取り方を聞く）。
# しきい値・余白を決める・変えるときと、揺れが報告されたときに回す
set -u
cd "$(dirname "$0")/.."
g=${1:?使い方: scripts/gatenoise.sh <ゲート> [N（既定5）]}
n=${2:-5}
OUT=$(mktemp -d)
H=$(( $(nproc) * 3 / 4 ))
PG=
stop_load() { [ -n "$PG" ] && kill -9 -- "-$PG" 2> /dev/null; PG=; }
trap 'stop_load; rm -rf "$OUT"' EXIT
if [ "${GATENOISE_LOAD:-1}" != 0 ]; then
    # 負荷: 空回しは timeout --foreground で同じプロセスグループに置く（グループごと止めれば残らない）
    setsid bash -c "while :; do for k in \$(seq $H); do timeout --foreground 12 bash -c 'while :; do :; done' & done; wait; sleep 12; done" > /dev/null 2>&1 &
    PG=$!
    disown "$PG"
fi
pass=0; failn=0
for i in $(seq "$n"); do
    if scripts/gates.sh -j 4 --no-cache --gate "$g" > "$OUT/run$i.log" 2>&1; then pass=$((pass + 1)); else failn=$((failn + 1)); fi
    grep -h "^gatenoise: " "scripts/.gatecache/logs/$g.log" >> "$OUT/lines" 2> /dev/null
    echo "gatenoise: run $i/$n $(grep -oE 'gates: (ALL PASS|[0-9]+ FAILED)' "$OUT/run$i.log") load=$(cut -d' ' -f1 /proc/loadavg)"
done
stop_load
echo "gatenoise: $g — $n 回（負荷 $([ -n "${GATENOISE_LOAD:-}" ] && [ "$GATENOISE_LOAD" = 0 ] && echo なし || echo "空回し $H 本の入れ切り")）: PASS $pass · FAIL $failn"
[ -s "$OUT/lines" ] || { echo "gatenoise: $g は gatenoise: の行を出さない（判定に使う量を出す行を、ゲートに足す）"; exit 1; }
# 題目（3列目）ごとに、key=value の値を集めて分布を出す
awk '
function show(t, k,    a, m, i, j, x, v) {
    m = split(vals[t, k], a, " ")
    for (i = 2; i <= m; i++) { x = a[i] + 0; for (j = i - 1; j >= 1 && a[j] + 0 > x; j--) a[j + 1] = a[j]; a[j + 1] = x }
    printf "  %s %s: n=%d min=%s median=%s max=%s\n", t, k, m, a[1], a[int((m + 1) / 2)], a[m]
}
{ t = $2 " " $3
  for (i = 4; i <= NF; i++) { split($i, kv, "="); if (kv[2] == "") continue
      n2 = split(kv[2], xs, ","); for (j = 1; j <= n2; j++) if (xs[j] ~ /^-?[0-9.]+$/) { vals[t, kv[1]] = vals[t, kv[1]] " " xs[j]; if (!((t, kv[1]) in seen)) { seen[t, kv[1]] = 1; keys[++nk] = t SUBSEP kv[1] } } } }
END { for (i = 1; i <= nk; i++) { split(keys[i], p, SUBSEP); sub(/^ /, "", vals[p[1], p[2]]); show(p[1], p[2]) } }' "$OUT/lines"
