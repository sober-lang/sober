#!/usr/bin/env bash
# kstatrate.sh <srv> <形>… — rtのカウンタ（--rt-mutant=4のdlsrv — kstat.shと同じ `#w` の16ワード）をレート固定の負荷で取る。
# レート固定の種目（latency-10k / latency-1m）はrpsでなくCPU / リクエストが点で、バッチ処理の浅さ（1リクエストごとのスリープ → ウェイクアップ → enter）が
# そのまま固定費になる（report-recon-3 — 10Kでenter/req 1.67）。その1周の内訳をGHAのマシンで取る口（report-map-1タスク1）。
# 形: latency-10k（zrk -R $ZRK_RATE_10K 既定 10000）/ latency-1m（-R $ZRK_RATE_1M 既定 1000000）— どちらも接続 1024・/baseline11?a=1&b=2・
#     $SECS 秒（既定 6 — dlsrv の期限 8 秒より前に終わる。温めなし: 期限の内に収めるため）
# 出力（形ごとに1行 + PER=1でワーカーごと）: zrkのrate_ratio・レスポンス | CPU µs/req（user / sys — 負荷のウィンドウのサーバのutime / stime）|
#   run/req・rsleep/req・ring / futexのスリープ（秒 / ワーカー）| cqe/enter・enter/req・sqe/req・recv/req・sqe/flush
# 環境: ZRK（無ければ PATH の zrk）・SERVER_CPUS / LOAD_CPUS（既定 = cpus.sh — local.sh と同じ割り）
set -uo pipefail
cd "$(dirname "$0")/.."
. ./cpus.sh
Z=${ZRK:-$(command -v zrk || true)}
[ -x "$Z" ] || { echo "kstatrate.sh: zrk not found (PATH or \$ZRK)" >&2; exit 2; }
SRV=$1; shift
[ $# -ge 1 ] || { echo "usage: kstatrate.sh <srv> <latency-10k|latency-1m>…" >&2; exit 2; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
d=${SECS:-6}
hz=$(getconf CLK_TCK)
for form in "$@"; do
    case $form in
        latency-10k) rate=${ZRK_RATE_10K:-10000} ;;
        latency-1m)  rate=${ZRK_RATE_1M:-1000000} ;;
        *) echo "kstatrate.sh: unknown form $form" >&2; exit 2 ;;
    esac
    port=$((18100 + RANDOM % 800))
    O=$W/srv.$form
    env SOBER_WORKERS=$nsrv taskset -c "$SERVER_CPUS" "$SRV" $port > "$O" 2>&1 &
    SP=$!
    for k in $(seq 100); do grep -q ready "$O" 2>/dev/null && break; sleep 0.05; done
    t0=$(awk '{ print $14, $15 }' /proc/$SP/stat 2>/dev/null)
    taskset -c "$LOAD_CPUS" "$Z" -t $nload -c 1024 -d ${d}s -R $rate --format json --plain "http://localhost:$port/baseline11?a=1&b=2" > "$O.z" 2>/dev/null
    t1=$(awk '{ print $14, $15 }' /proc/$SP/stat 2>/dev/null)
    wait $SP 2>/dev/null
    read -r resp rr <<< "$(node -e '
        const raw = require("fs").readFileSync(process.argv[1], "utf8"); const s = raw.indexOf("{"), e = raw.lastIndexOf("}");
        if (s < 0 || e <= s) { console.log("0 0"); process.exit(0); }
        const d = JSON.parse(raw.slice(s, e + 1)), c = d.status_codes || {};
        console.log(["2xx","3xx","4xx","5xx"].reduce((a, k) => a + (c[k] || 0), 0), (d.rate_ratio || 0).toFixed(4));
    ' "$O.z")"
    awk -v form=$form -v rate=$rate -v resp=${resp:-0} -v rr=${rr:-0} -v a="$t0" -v b="$t1" -v hz=$hz -v per="${PER:-}" '
      /^#w / { k = $2; for (j = 0; j < 16; j++) { v[j] += $(j + 3); w[k, j] = $(j + 3) } n++ }
      END {
        if (n == 0 || resp == 0) { print "=== " form ": no data (" n " workers, resp " resp " — not a --rt-mutant=4 build, or the server did not finish)"; exit }
        split(a, x, " "); split(b, y, " "); u = (y[1] - x[1]) / hz * 1e6 / resp; s = (y[2] - x[2]) / hz * 1e6 / resp
        en = v[11] > 0 ? v[11] : 1; fl = v[2] > 0 ? v[2] : 1
        printf "=== %s rate=%d rate_ratio=%s resp=%d W=%d | cpu/req=%.2fus (user %.2f / sys %.2f) | run/req=%.2f rsleep/req=%.3f rsleep_s/wk=%.2f fsleep_s/wk=%.2f | cqe/enter=%.2f enter/req=%.3f sqe/req=%.2f recv/req=%.2f sqe/flush=%.1f\n",
          form, rate, rr, resp, n, u + s, u, s, v[0] / resp, v[3] / resp, v[4] / n / 1e9, v[6] / n / 1e9, v[7] / en, v[11] / resp, v[10] / resp, v[9] / resp, v[10] / fl
        if (per != "") for (k = 0; k < n; k++) printf "  w%-2d run=%d start=%d spawn=%d steal=%d rsleep_s=%.2f fsleep_s=%.2f enter=%d\n", k, w[k, 0], w[k, 12], w[k, 14], w[k, 1], w[k, 4] / 1e9, w[k, 6] / 1e9, w[k, 11] }' "$O"
done
