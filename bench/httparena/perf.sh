#!/usr/bin/env bash
# perf.sh — Sober サーバの CPU の内訳（cpu-clock の flat サンプリング・カーネルのシンボル込み）。
# baseline の負荷を掛けながらサーバの pid をサンプリングし、perf report（flat — Sober の ELF は
# unwind 情報を持たないので call graph は取らない）を出す。目的 = sys 側（loopback の TCP・io_uring）の
# 内訳の帰属（report-673 — CPU / 要求の 3/4 がカーネルで、user の命令を削っても動かない）。
# PMU の無い VM（GH Actions / WSL2）向けに -e cpu-clock。カーネルのシンボルには
# kernel.perf_event_paranoid=-1 と kernel.kptr_restrict=0 が要る（workflow が sysctl で設定）。
#
#   bench/httparena/perf.sh [-d 秒] [-c 接続] [--profile baseline|pipelined|limited-conn|latency-10k|latency-1m|async|json-tls] [-b 建て済みのサーバ] [-o レポートの出力先]
# json-tls = local.sh と同じ形（wrk・-c 4096・本家 requests/json-tls-rotate.lua の 7 組の巡回を TLS の port へ・証明書は本家の対・
# dataset = $ARENA_DATA〔無ければ GitHub から〕）。wrk は $WRK か PATH。-b = 別の版で建てたサーバを測る（版どうしの帰属 — 無ければ main.sober を建てる）
# async = local.sh と同じ形（GET /delay/10・接続は -c でなく $ASYNC_CONNS 既定 32000 — 保留のタイマーを運ぶ接続の数が種目の形。
# TIME_WAIT を大量に残すので、並べるなら最後に）。nofile は呼び手が上げておく（workflow は prlimit）
# limited-conn = local.sh と同じ形（-r 10 — 10 要求ごとに張り直す churn）。
# latency-10k / latency-1m = zrk のレート固定（local.sh と同じ — 接続 1024・/baseline11?a=1&b=2・レート $ZRK_RATE_10K 既定 10000 /
# $ZRK_RATE_1M 既定 1000000・測る前に $ZRK_WARM 秒〔既定 5〕流して捨てる）。レート固定の種目は rps でなく CPU / 要求が点なので、
# 見出しの「cpu/req」の行（負荷の全窓のサーバの utime + stime ÷ 応答 — perf の採り分を含む）と内訳を対で読む
# 前提: perf・gcannon（PATH か $GCANNON）・zrk（latency-* — $ZRK か PATH、無ければ local.sh と同じ pin を取る）・go は不要（Sober 側だけ）。
# CPU の割りは cpus.sh と同じ。
set -uo pipefail
cd "$(dirname "$0")"
ROOT=$(cd ../.. && pwd)
dur=10
conns=4096
prof=baseline
out=
bin=
while [ $# -gt 0 ]; do
    case "$1" in
        -d) dur=$2; shift ;;
        -c) conns=$2; shift ;;
        --profile) prof=$2; shift ;;
        -o) out=$2; shift ;;
        -b) bin=$2; shift ;;
        *) echo "perf.sh: unknown option $1" >&2; exit 2 ;;
    esac
    shift
done
W=$(mktemp -d)
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; rm -rf "$W"' EXIT
[ -n "$out" ] || out=$W/report.txt

. ./cpus.sh

GC=${GCANNON:-$(command -v gcannon || true)}
[ -x "$GC" ] || { echo "perf.sh: gcannon not found (PATH or \$GCANNON)" >&2; exit 2; }
command -v perf > /dev/null || { echo "perf.sh: perf not found" >&2; exit 2; }
REQ=${ARENA_REQ:-$W/req}
if [ ! -f "$REQ/get.raw" ]; then
    mkdir -p "$REQ"
    for f in get.raw post_cl.raw post_chunked.raw pipeline.raw async-delay.raw; do
        curl -fsSL -o "$REQ/$f" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/$f" || { echo "perf.sh: cannot fetch requests/$f" >&2; exit 2; }
    done
fi

if [ -n "$bin" ]; then
    cp "$bin" "$W/sober-srv" || exit 2
else
    "$ROOT/bin/sober" build main.sober -o "$W/sober-srv" > "$W/b1.log" 2>&1 || { echo "perf.sh: sober build failed: $(head -c 300 "$W/b1.log")" >&2; exit 1; }
fi
# json-tls: wrk・巡回の Lua・dataset・TLS の port（= port + 400 — local.sh と同じ）
srvargs=()
if [ "$prof" = json-tls ]; then
    WRKBIN=${WRK:-$(command -v wrk || true)}
    [ -x "$WRKBIN" ] || { echo "perf.sh: wrk not found (PATH or \$WRK)" >&2; exit 2; }
    [ -f "$REQ/json-tls-rotate.lua" ] || curl -fsSL -o "$REQ/json-tls-rotate.lua" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/json-tls-rotate.lua" \
        || { echo "perf.sh: cannot fetch requests/json-tls-rotate.lua" >&2; exit 2; }
    DATA=${ARENA_DATA:-$W/dataset.json}
    [ -f "$DATA" ] || curl -fsSL -o "$DATA" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/data/dataset.json" || { echo "perf.sh: cannot fetch data/dataset.json (set \$ARENA_DATA)" >&2; exit 2; }
fi

# port は 18000 番台（local.sh と同じ — ephemeral の範囲と重ねない。async の後は TIME_WAIT の客側 port に bind して黙って失敗する）
port=$((18500 + RANDOM % 400))
for try in 1 2 3; do
    port=$((port + 1))
    tport=$((port + 400))
    if [ "$prof" = json-tls ]; then
        env SOBER_WORKERS=$nsrv DATASET_PATH="$DATA" TLS_CERT="$ROOT/testdata/crypto/httparena-server.crt" TLS_KEY="$ROOT/testdata/crypto/httparena-server.key" \
            taskset -c "$SERVER_CPUS" "$W/sober-srv" "$port" "$tport" > "$W/srv.out" 2> "$W/srv.err" &
    else
        env SOBER_WORKERS=$nsrv taskset -c "$SERVER_CPUS" "$W/sober-srv" "$port" > "$W/srv.out" 2> "$W/srv.err" &
    fi
    SP=$!
    for i in $(seq 100); do
        if grep -q '^ready' "$W/srv.out" 2> /dev/null; then
            [ "$prof" != json-tls ] && break
            curl -sk -o /dev/null --max-time 2 "https://localhost:$tport/json/1?m=1" && break
        fi
        sleep 0.05
    done
    grep -q '^ready' "$W/srv.out" && { [ "$prof" != json-tls ] || curl -sk -o /dev/null --max-time 2 "https://localhost:$tport/json/1?m=1"; } && break
    kill "$SP" 2> /dev/null; wait "$SP" 2> /dev/null; SP=
    echo "perf.sh: server did not start on port $port (try $try): $(head -c 200 "$W/srv.err")" >&2
done
[ -n "$SP" ] || exit 1

# zrk（latency-* — local.sh と同じ取り方: $ZRK か PATH、無ければ本家 docker/zrk.Dockerfile と同じ pin）
zrk_bin() {
    local z=${ZRK:-$(command -v zrk || true)}
    if [ ! -x "$z" ]; then
        local v=2.3.0 sum=ab6f1c1ce34ce73f52afd106419d15e5c494bd1cedd475afa56babb85b09a816
        curl -fsSL -o "$W/zrk.tar.gz" "https://github.com/zoxy-io/zrk/releases/download/v$v/zrk-$v-x86_64-linux.tar.gz" \
            && echo "$sum  $W/zrk.tar.gz" | sha256sum -c - > /dev/null \
            && tar xzf "$W/zrk.tar.gz" -C "$W" zrk && chmod +x "$W/zrk" || { echo "perf.sh: cannot fetch zrk (set \$ZRK)" >&2; return 1; }
        z=$W/zrk
    fi
    echo "$z"
}
ticks() { awk '{ print $14, $15 }' "/proc/$SP/stat" 2> /dev/null || echo 0 0; }

rate=
case "$prof" in
    baseline) args=(--raw "$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw" -p 1); url=http://localhost:$port ;;
    pipelined) args=(-p 16); url=http://localhost:$port/pipeline ;;
    limited-conn) args=(--raw "$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw" -p 1 -r 10); url=http://localhost:$port ;;
    async) args=(--raw "$REQ/async-delay.raw" -p 1); url=http://localhost:$port; conns=${ASYNC_CONNS:-32000} ;;
    latency-10k) rate=${ZRK_RATE_10K:-10000} ;;
    latency-1m) rate=${ZRK_RATE_1M:-1000000} ;;
    json-tls) ;;
    *) echo "perf.sh: unknown profile $prof" >&2; exit 2 ;;
esac
if [ -n "$rate" ]; then
    ZB=$(zrk_bin) || exit 2
    conns=1024
    zargs=(-t "$nload" -c "$conns" -R "$rate" --format json --plain "http://localhost:$port/baseline11?a=1&b=2")
    warm=${ZRK_WARM:-5}
    [ "$warm" -gt 0 ] && timeout $((warm + 40)) taskset -c "$LOAD_CPUS" "$ZB" -d "${warm}s" "${zargs[@]}" > /dev/null 2>&1
    c0=$(ticks)
    timeout $((dur + 40)) taskset -c "$LOAD_CPUS" "$ZB" -d "$((dur + 2))s" "${zargs[@]}" > "$W/gc.txt" 2>&1 &
elif [ "$prof" = json-tls ]; then
    c0=$(ticks)
    timeout $((dur + 30)) taskset -c "$LOAD_CPUS" "$WRKBIN" -t "$nload" -c "$conns" -d "$((dur + 2))s" --latency -s "$REQ/json-tls-rotate.lua" "https://localhost:$tport" > "$W/gc.txt" 2>&1 &
else
    c0=$(ticks)
    timeout $((dur + 30)) taskset -c "$LOAD_CPUS" "$GC" "$url" "${args[@]}" -c "$conns" -t "$nload" -d "$((dur + 2))s" > "$W/gc.txt" 2>&1 &
fi
GCP=$!
sleep 1
# -g: カーネル側の呼び出し鎖はカーネル自身の unwinder（ORC）で辿れる。user 側（Sober の ELF —
# fp も unwind 情報も無い）は壊れるが、目的はカーネルの帰属（spin_unlock_irqrestore の呼び手等）
perf record -q -e cpu-clock -F 997 -g -p "$SP" -o "$W/perf.data" -- sleep "$dur" || { echo "perf.sh: perf record failed" >&2; kill $GCP 2>/dev/null; exit 1; }
wait "$GCP" 2> /dev/null
c1=$(ticks)

# 応答の数（gcannon = "N responses"・zrk = JSON の status_codes の和）— 見出しの cpu/req（負荷の全窓・user / sys に割る）の分母
if [ -n "$rate" ]; then
    resp=$(node -e '
        const raw = require("fs").readFileSync(process.argv[1], "utf8"); const s = raw.indexOf("{"), e = raw.lastIndexOf("}");
        if (s < 0 || e <= s) { console.log(0); process.exit(0); }
        const d = JSON.parse(raw.slice(s, e + 1)), c = d.status_codes || {}, l = d.latency_us || {};
        console.log(["2xx","3xx","4xx","5xx"].reduce((a, k) => a + (c[k] || 0), 0), (d.rate_ratio || 0).toFixed(4), Math.round(l.mean || 0), Math.round(l.p99 || 0), Math.round(l.p99_9 ?? l.p999 ?? 0));
    ' "$W/gc.txt")
elif [ "$prof" = json-tls ]; then
    resp=$(sed -n 's/^ *\([0-9]*\) requests in .*/\1/p' "$W/gc.txt")
else
    resp=$(sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p' "$W/gc.txt")
fi
read -r nresp rr lmean lp99 lp999 <<< "${resp:-0}"

{
    echo "# perf.sh — profile=$prof conns=$conns dur=${dur}s server CPUs $SERVER_CPUS (workers $nsrv) load CPUs $LOAD_CPUS${rate:+ rate=$rate}"
    if [ -n "$rate" ]; then
        echo "zrk: responses=$nresp rate_ratio=$rr mean=${lmean}us p99=${lp99}us p99.9=${lp999}us"
    else
        grep -E 'Throughput|Latency|Requests/sec|requests in|^ *(50|75|90|99)%' "$W/gc.txt" | head -9
    fi
    awk -v a="$c0" -v b="$c1" -v n="${nresp:-0}" -v t="$(getconf CLK_TCK)" 'BEGIN { split(a, x, " "); split(b, y, " "); u = (y[1] - x[1]) / t * 1e6; s = (y[2] - x[2]) / t * 1e6
        if (n > 0) printf "cpu/req: %.2f us (user %.2f / sys %.2f — server utime+stime over the whole load window incl. perf sampling ÷ %d responses)\n", (u + s) / n, u / n, s / n, n; else print "cpu/req: - (no responses)" }'
    echo
    echo "## by object (user vs kernel)"
    perf report --stdio -i "$W/perf.data" --sort dso --percent-limit 0.5 -g none 2> /dev/null | grep -v '^#\s*$'
    echo
    echo "## by symbol (flat — ≥ 0.05%: 0.5% の切りでは CPU の半分しか表に入らなかった — report-682)"
    perf report --stdio -i "$W/perf.data" --sort dso,symbol --percent-limit 0.05 -g none --no-children 2> /dev/null | grep -v '^#\s*$' | head -400
    echo
    echo "## kernel callers (per top kernel symbol — callee order: the leaf first, then its kernel callers upward; caller order put the broken user frames on top — report-682)"
    # flat の上位のカーネルの symbol を 3 つ取り、それぞれの呼び手の鎖を低い閾値で出す
    # （--sort symbol の一括 caller graph は呼び手が分散すると閾値で全部切れる — run 38652999799）
    perf report --stdio -i "$W/perf.data" --sort dso,symbol -g none --no-children 2> /dev/null \
        | awk '$2 ~ /kernel/ && $3 == "[k]" { print $4 }' | head -3 | while read -r sym; do
        echo "### $sym"
        perf report --stdio -i "$W/perf.data" --symbols "$sym" --no-children -g graph,0.2,callee --percent-limit 0 2> /dev/null | grep -v '^#\s*$' | head -45
        echo
    done
} > "$out"
cat "$out"
exit 0
