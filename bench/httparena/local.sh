#!/usr/bin/env bash
# local.sh — HttpArena の HTTP/1.1 の種目を素のプロセスで回す（Docker なし — net 4c・report-671）。Sober のエントリ（main.sober）と Go の対照
# （go/ — HttpArena の go-stdlib のハンドラの写し）を同じ条件で交互に n 周走らせ、種目ごとに req/s の中央値・サーバの CPU / 要求・比（Sober / Go）を出す。
# 負荷は HttpArena と同じ gcannon（io_uring）と同じ要求のファイル（requests/*.raw）・同じ形（baseline = GET / POST CL / POST chunked の 3 つを混ぜて
# 4096 接続・pipelined = /pipeline を 16 本ずつ・limited-conn = 10 要求ごとに張り直し）。HttpArena の採点は 64 スレッド・3 回の最良・5 秒 —
# ここは機の大きさに合わせて縮め、最良でなく中央値で読む（比を正にする — PINS の「HttpArena のベンチ環境」の勘所）。
#
#   bench/httparena/local.sh [-n 周] [-d 秒] [-c 接続] [--profiles "baseline pipelined limited-conn json json-comp json-comp-16k latency-1m latency-10k latency-500k-8cpu async"] [-o 結果の TSV] [--summary 要約の md]
# 種目（meta.json の tests 全 7 つ — 本家 scripts/lib/profiles.sh の形 — と json）:
#   baseline / pipelined / limited-conn = gcannon・-c（既定 4096）
#   json           = gcannon・GET /json/{count}?m=（本家 json-comp の (25,4)・(40,8)・(50,6) の巡回を Accept-Encoding なしで — 本家に素の json 種目は無い
#                    〔json-comp / json-tls / json-h2c の端点〕ので meta.json の tests には載せない・手元の Sober / Go の直列化の比を見るだけ。report-703）。
#                    dataset = 本家の data/dataset.json（$ARENA_DATA — 無ければ GitHub から取る）をサーバの DATASET_PATH に
#   json-comp      = 同じ巡回を Accept-Encoding: gzip, br で（本家 json-comp — 4096 接続。json-comp-16k = 16384 接続 — 本家は 4096,16384 の両方）。
#                    本家の採点は effectiveRps = rps × (最小の Bpr / 自分の Bpr)²（Bpr = 応答 1 件のバイト — 頭込み）なので、巡回の 3 つの応答の
#                    頭 + 本文の平均のバイトを Sober / Go で測って要約の末尾に添える（report-714）
#   json-tls       = wrk（本家の形 — -c 4096・GET /json/{count}?m= の 7 組の巡回〔requests/json-tls-rotate.lua〕を HTTPS の TLS の port へ。
#                    ALPN http/1.1・Accept-Encoding なし。証明書 = 本家の certs と同じ対〔testdata/crypto/httparena-server.*〕を TLS_CERT / TLS_KEY で渡す。
#                    wrk は $WRK か PATH〔workflow は apt の wrk〕・p99 は --latency の分布から。report-841 / 843）
#   async          = gcannon・GET /delay/10・接続 32000（$ASYNC_CONNS — 保持した接続の数だけ保留のタイマーを運ぶ。天井 = conns/delay = 3.2M）。
#                    TIME_WAIT を大量に残すので一覧の最後に置くこと（本家 PROFILE_ORDER と同じ理由）
#   8gbit          = zrk（本家の形 — POST /echo を TLS の port へ・本文 10,240 B〔本家 tools/zrk.sh の決定的な "echo-body:" の繰り返し〕・接続 512・
#                    レート固定 50K req/s〔$ZRK_RATE_8GBIT〕・5 秒〔$ZRK_DUR_8GBIT〕。採点は latency と同じ式〔CPU / 要求・p99・mean〕— report-848 / 855）
#   latency-1m/10k = zrk（レート固定 1M / 10K req/s・接続 1024・20 秒 $ZRK_DUR — /baseline11?a=1&b=2）。測るのはサーバの CPU / 要求。
#                    測る前に同じサーバへ同じ形を $ZRK_WARM 秒（既定 5・0 で無し）流して捨てる（1 周目の p99 がランプの尻〔接続の張り始め・
#                    ワーカーの起き上がり〕を拾って秒の桁に跳ねた — GHA run 38704859501 の r3 / r4。本家の測りの形〔レート・接続・秒〕は変えない）
#                    zrk は $ZRK か PATH、無ければ本家の pin（v2.3.0 の静的 tarball・sha256 照合）を取って $W に置く
#   latency-500k-8cpu = latency-1m の形でレート 500K req/s（$ZRK_RATE_500K）・サーバは 8 論理 CPU（本家 profiles.sh の cpuset 0-3,64-67 = 4 物理コア +
#                    SMT の兄弟 — ここではサーバ側の物理コアの先頭 4 つ + 兄弟〔$SERVER_CPUS_8 で上書き・SMT の無い箱では先頭 8 CPU〕・SOBER_WORKERS /
#                    GOMAXPROCS も 8）。本家の箱の 4 コアと手元の 4 コアは同じ桁なので、レートは箱で割り直さない（採点 = rate_ratio・CPU / 要求・p99）
# 前提: gcannon（PATH か $GCANNON）と HttpArena の requests/（$ARENA_REQ — 無ければ GitHub から取る）・go・bin/sober
# CPU の割り当て: SMT の兄弟を同じ側に置き、前半の物理コアをサーバ・後半を gcannon（$SERVER_CPUS / $LOAD_CPUS で上書き）
# 注: seki の seccomp の下では時間（req/s・CPU）が歪む — 値は参考。公式の数字は GH Actions（.github/workflows/httparena.yml）
set -uo pipefail
cd "$(dirname "$0")"
HERE=$PWD
ROOT=$(cd ../.. && pwd)
n=3
dur=5
conns=4096
profiles="baseline pipelined limited-conn"
out=
summary=
while [ $# -gt 0 ]; do
    case "$1" in
        -n) n=$2; shift ;;
        -d) dur=$2; shift ;;
        -c) conns=$2; shift ;;
        --profiles) profiles=$2; shift ;;
        -o) out=$2; shift ;;
        --summary) summary=$2; shift ;;
        *) echo "local.sh: unknown option $1" >&2; exit 2 ;;
    esac
    shift
done
W=${HTTPARENA_WORK:-$(mktemp -d)}
mkdir -p "$W"
# HTTPARENA_WORK で外から与えた W は消さない（CI が gcannon / zrk の生出力を artifact に拾う — run 39027394708 で trap が先に消していた）
W_KEEP=${HTTPARENA_WORK:+1}
SP=
trap '[ -n "$SP" ] && kill $SP 2>/dev/null; [ -z "$W_KEEP" ] && rm -rf "$W"' EXIT
[ -n "$out" ] || out=$W/result.tsv

# CPU の割り当て（cpus.sh — SMT の兄弟を揃えて物理コアの前半 / 後半）
. ./cpus.sh
# latency-500k-8cpu のサーバ: サーバ側の CPU の列（cpus.sh — 物理コアの順に兄弟が並ぶ）の先頭 8 つ
SERVER_CPUS_8=${SERVER_CPUS_8:-$(echo "$SERVER_CPUS" | tr ',' '\n' | head -8 | paste -sd,)}
nsrv8=$(echo "$SERVER_CPUS_8" | tr ',' '\n' | wc -l)

GC=${GCANNON:-$(command -v gcannon || true)}
[ -x "$GC" ] || { echo "local.sh: gcannon not found (PATH or \$GCANNON — https://github.com/MDA2AV/gcannon)" >&2; exit 2; }
REQ=${ARENA_REQ:-$W/req}
if [ ! -f "$REQ/get.raw" ]; then
    mkdir -p "$REQ"
    for f in get.raw post_cl.raw post_chunked.raw pipeline.raw async-delay.raw; do
        curl -fsSL -o "$REQ/$f" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/$f" || { echo "local.sh: cannot fetch requests/$f" >&2; exit 2; }
    done
fi
# json の要求（本家 json-comp の巡回 (25,4)・(40,8)・(50,6) — json は Accept-Encoding なし・json-comp は本家の頭 Accept-Encoding: gzip, br）と dataset
DATA=${ARENA_DATA:-$W/dataset.json}
case " $profiles " in *" json "*|*" json-comp"*)
    for cm in 25:4 40:8 50:6; do
        printf 'GET /json/%s?m=%s HTTP/1.1\r\nHost: localhost:8080\r\n\r\n' "${cm%%:*}" "${cm##*:}" > "$W/json-${cm%%:*}.raw"
        printf 'GET /json/%s?m=%s HTTP/1.1\r\nHost: localhost:8080\r\nAccept-Encoding: gzip, br\r\n\r\n' "${cm%%:*}" "${cm##*:}" > "$W/json-comp-${cm%%:*}.raw"
    done
    if [ ! -f "$DATA" ]; then
        curl -fsSL -o "$DATA" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/data/dataset.json" || { echo "local.sh: cannot fetch data/dataset.json (set \$ARENA_DATA)" >&2; exit 2; }
    fi
    ;;
esac
# json-tls: wrk・巡回の Lua（本家 requests/json-tls-rotate.lua）・dataset
WRKBIN=
case " $profiles " in *" json-tls "*)
    WRKBIN=${WRK:-$(command -v wrk || true)}
    [ -x "$WRKBIN" ] || { echo "local.sh: wrk not found (PATH or \$WRK)" >&2; exit 2; }
    [ -f "$REQ/json-tls-rotate.lua" ] || curl -fsSL -o "$REQ/json-tls-rotate.lua" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/json-tls-rotate.lua" \
        || { echo "local.sh: cannot fetch requests/json-tls-rotate.lua" >&2; exit 2; }
    if [ ! -f "$DATA" ]; then
        curl -fsSL -o "$DATA" "https://raw.githubusercontent.com/MDA2AV/HttpArena/main/data/dataset.json" || { echo "local.sh: cannot fetch data/dataset.json (set \$ARENA_DATA)" >&2; exit 2; }
    fi
    ;;
esac

# zrk（latency-* の負荷 — レート固定・JSON の要約）: $ZRK か PATH、無ければ本家 docker/zrk.Dockerfile と同じ pin を取る
ZRKBIN=
case " $profiles " in *" latency-"*|*" 8gbit "*)
    ZRKBIN=${ZRK:-$(command -v zrk || true)}
    if [ ! -x "$ZRKBIN" ]; then
        ZRK_VERSION=2.3.0
        ZRK_SHA256=ab6f1c1ce34ce73f52afd106419d15e5c494bd1cedd475afa56babb85b09a816
        curl -fsSL -o "$W/zrk.tar.gz" "https://github.com/zoxy-io/zrk/releases/download/v${ZRK_VERSION}/zrk-${ZRK_VERSION}-x86_64-linux.tar.gz" \
            && echo "$ZRK_SHA256  $W/zrk.tar.gz" | sha256sum -c - > /dev/null \
            && tar xzf "$W/zrk.tar.gz" -C "$W" zrk && chmod +x "$W/zrk" \
            || { echo "local.sh: cannot fetch zrk (set \$ZRK — https://github.com/zoxy-io/zrk)" >&2; exit 2; }
        ZRKBIN=$W/zrk
    fi
    ;;
esac

# 建てる（Sober = 主の sober・Go = 静的）
"$ROOT/bin/sober" build main.sober -o "$W/sober-srv" > "$W/b1.log" 2>&1 || { echo "local.sh: sober build failed: $(head -c 300 "$W/b1.log")" >&2; exit 1; }
(cd go && CGO_ENABLED=0 go build -trimpath -o "$W/go-srv" .) > "$W/b2.log" 2>&1 || { echo "local.sh: go build failed: $(head -c 300 "$W/b2.log")" >&2; exit 1; }

# サーバの port は 18000 番台（ephemeral の範囲の外 — workflow は ip_local_port_range を 1024-65535 に広げるので、
# 連番が TIME_WAIT の客側 port に当たると bind が黙って失敗する。workflow 側は ip_local_reserved_ports=18000-18999 で守る）
port=$((18000 + RANDOM % 500))
# 8gbit の本文（本家 tools/zrk.sh の _zrk_echo_body と同じ決定的なバイト列 — "echo-body:" の繰り返しを 10,240 B に）
ECHO_BODY=$W/echo-body.bin
case " $profiles " in *" 8gbit "*)
    node -e 'const n = 10240, u = Buffer.from("echo-body:"); process.stdout.write(Buffer.concat(Array(Math.ceil(n / u.length)).fill(u)).subarray(0, n))' > "$ECHO_BODY"
    ;;
esac
# TLS の port を待つか（json-tls・8gbit）
NEED_TLS=
case " $profiles " in *" json-tls "*|*" 8gbit "*) NEED_TLS=1 ;; esac

# start <name>: サーバを立てて ready を待つ（SOBER_WORKERS / GOMAXPROCS = サーバの CPU の数）。bind の失敗に備えて port を変えて 3 回まで。
# TLS の port = port + 400（同じ 18000〜18999 の予約の中）・証明書は本家の対 — json-tls の走りは TLS の port に curl が通るまで待つ（本家 framework.sh の準備の検査と同じ形）
CERT=$ROOT/testdata/crypto/httparena-server.crt
KEY=$ROOT/testdata/crypto/httparena-server.key
start() {
    local b=$W/$1-srv try
    # latency-500k-8cpu だけサーバを 8 論理 CPU に絞る（上の注 — $cur_prof は下の周の輪が置く）
    local scpus=$SERVER_CPUS ns=$nsrv
    [ "${cur_prof:-}" = latency-500k-8cpu ] && { scpus=$SERVER_CPUS_8; ns=$nsrv8; }
    for try in 1 2 3; do
        port=$((port + 1))
        tport=$((port + 400))
        env SOBER_WORKERS=$ns GOMAXPROCS=$ns DATASET_PATH="$DATA" TLS_CERT="$CERT" TLS_KEY="$KEY" taskset -c "$scpus" "$b" "$port" "$tport" > "$W/srv.out" 2> "$W/srv.err" &
        SP=$!
        for i in $(seq 100); do
            if grep -q '^ready' "$W/srv.out" 2> /dev/null; then
                [ -z "$NEED_TLS" ] && return 0
                curl -sk -o /dev/null --max-time 2 "https://localhost:$tport/json/1?m=1" && return 0
            fi
            sleep 0.05
        done
        kill "$SP" 2> /dev/null; wait "$SP" 2> /dev/null; SP=
        echo "local.sh: $1 did not start on port $port (try $try): out=$(head -c 120 "$W/srv.out") err=$(head -c 200 "$W/srv.err")" >&2
    done
    return 1
}
stop() { kill "$SP" 2> /dev/null; wait "$SP" 2> /dev/null; SP=; }
# cpu_ticks: サーバの utime + stime（clock tick）。走りの間に死んだサーバ（/proc が消える）は 0 — 行は残り、req/s = 0 で見える
cpu_ticks() { awk '{ print $14 + $15 }' "/proc/$SP/stat" 2> /dev/null || echo 0; }
# rss_row <名前> <種目> <周>: 走りの直後（stop の前）のサーバの VmHWM（ピーク）と VmRSS（終端）を kB で "$out.rss" へ。
# サーバは周ごとに建て直すので VmHWM = その周のピーク。死んだサーバは行を出さない（欠けで見える）
rss_row() {
    local ahp
    ahp=$(awk '/^AnonHugePages:/ { print $2 }' "/proc/$SP/smaps_rollup" 2> /dev/null)
    awk -v n="$1" -v p="$2" -v k="$3" -v a="${ahp:-0}" '/^VmHWM:/ { h = $2 } /^VmRSS:/ { r = $2 } END { if (h != "") printf "%s\t%s\t%d\t%d\t%d\t%d\n", n, p, k, h, r, a }' \
        "/proc/$SP/status" 2> /dev/null >> "$out.rss"
}

# emit <名前> <種目> <周> <req/s> <応答> <2xx> <tickの差> <p99> <p99.9>: TSV の行（名前 種目 周 req/s 応答 2xx以外 CPUμs/要求 p99 p99.9）
# p99.9 は分布の尻（report-706 — 本家で p99 と p99.9 が 2 桁割れる実装がある。尻の綺麗さは p99 だけでは見えない）
emit() {
    awk -v n="$1" -v p="$2" -v k="$3" -v r="${4:-0}" -v resp="${5:-0}" -v ok="${6:-0}" -v d="$7" -v t="$(getconf CLK_TCK)" -v l="${8:--}" -v l9="${9:--}" \
        'BEGIN { printf "%s\t%s\t%d\t%d\t%d\t%d\t%.2f\t%s\t%s\n", n, p, k, r, resp, resp - ok, (resp > 0 ? d / t * 1e6 / resp : 0), l, l9 }'
}

# run_one <name> <profile> <周>: 1 回測って TSV の行を出す
run_one() {
    local name=$1 prof=$2 k=$3 url args pc=$conns c0 c1 txt
    # latency-* と 8gbit は zrk（レート固定 — 本家 tools/zrk.sh の形。測るのはサーバの CPU / 要求）
    if [ "$prof" = latency-1m ] || [ "$prof" = latency-10k ] || [ "$prof" = latency-500k-8cpu ] || [ "$prof" = 8gbit ]; then
        # レートは箱に合わせて上書きできる（本家の 1M は 32 コアのベンチ機の値 — 8 コアのサーバでは Go が飽和して rate_ratio が割れる。
        # GHA の 16vcpu は ZRK_RATE_1M=250000〔1M × 8/32〕で両者が運べる水準に）
        local rate=${ZRK_RATE_1M:-1000000} zdur=${ZRK_DUR:-20} zc=1024 zargs=("http://localhost:$port/baseline11?a=1&b=2")
        [ "$prof" = latency-10k ] && rate=${ZRK_RATE_10K:-10000}
        [ "$prof" = latency-500k-8cpu ] && rate=${ZRK_RATE_500K:-500000}
        if [ "$prof" = 8gbit ]; then
            rate=${ZRK_RATE_8GBIT:-50000}; zdur=${ZRK_DUR_8GBIT:-5}; zc=512
            zargs=(-m POST -b "@$ECHO_BODY" -H "Content-Type: application/octet-stream" -k "https://localhost:$tport/echo")
        fi
        # ウォームアップ（数えない — 上の注）
        local warm=${ZRK_WARM:-5}
        [ "$warm" -gt 0 ] && timeout $((warm + 40)) taskset -c "$LOAD_CPUS" "$ZRKBIN" -t "$nload" -c "$zc" -d "${warm}s" -R "$rate" --format json --plain "${zargs[@]}" > /dev/null 2>&1
        c0=$(cpu_ticks)
        txt=$(timeout $((zdur + 40)) taskset -c "$LOAD_CPUS" "$ZRKBIN" -t "$nload" -c "$zc" -d "${zdur}s" -R "$rate" --format json --plain "${zargs[@]}" 2> "$W/zrk-$name-$prof-$k.err")
        c1=$(cpu_ticks)
        echo "$txt" > "$W/gc-$name-$prof-$k.txt"
        # JSON の要約（本家 zrk_parse と同じ読み方 — 外側の {...} だけを取る）: achieved_rate・latency_us.p99 / p99_9・status_codes・rate_ratio
        local parsed
        parsed=$(node -e '
            const raw = require("fs").readFileSync(0, "utf8");
            const s = raw.indexOf("{"), e = raw.lastIndexOf("}");
            if (s < 0 || e <= s) { console.log("0 0 0 - 0 -"); process.exit(0); }
            const d = JSON.parse(raw.slice(s, e + 1));
            const c = d.status_codes || {};
            const resp = ["2xx","3xx","4xx","5xx"].reduce((a, k) => a + (c[k] || 0), 0);
            const lu = d.latency_us || {};
            console.log(Math.round(d.achieved_rate || 0), resp, c["2xx"] || 0, `${Math.round(lu.p99 || 0)}us`, (d.rate_ratio || 0).toFixed(4), `${Math.round(lu.p99_9 || 0)}us`);
        ' <<< "$txt")
        local rps resp ok p99 rr p999
        read -r rps resp ok p99 rr p999 <<< "$parsed"
        # レートを保てなかった走り（本家の妥当性の門 = rate_ratio）は数字が比べられない — 行はそのまま出して警告だけ
        awk -v r="$rr" 'BEGIN { exit !(r < 0.98) }' && echo "local.sh: WARN $name $prof round $k rate_ratio=$rr (< 0.98 — the offered load was not the profile's)" >&2
        emit "$name" "$prof" "$k" "$rps" "$resp" "$ok" $((c1 - c0)) "$p99" "$p999"
        return 0
    fi
    # json-tls は wrk（--latency で分布を出す — 本家の採点は rps だけ・p99 は手元の読み）
    if [ "$prof" = json-tls ]; then
        c0=$(cpu_ticks)
        txt=$(timeout $((dur + 30)) taskset -c "$LOAD_CPUS" "$WRKBIN" -t "$nload" -c "$conns" -d "${dur}s" --latency -s "$REQ/json-tls-rotate.lua" "https://localhost:$tport" 2>&1)
        c1=$(cpu_ticks)
        echo "$txt" > "$W/gc-$name-$prof-$k.txt"
        local rps resp bad p99
        rps=$(echo "$txt" | sed -n 's/^Requests\/sec: *\([0-9.]*\).*/\1/p' | awk '{ printf "%.0f", $1 }')
        resp=$(echo "$txt" | sed -n 's/^ *\([0-9]*\) requests in .*/\1/p')
        bad=$(echo "$txt" | sed -n 's/^ *Non-2xx or 3xx responses: *\([0-9]*\).*/\1/p')
        p99=$(echo "$txt" | awk '$1 == "99%" { print $2 }')
        emit "$name" "$prof" "$k" "$rps" "$resp" $(( ${resp:-0} - ${bad:-0} )) $((c1 - c0)) "$p99" "-"
        return 0
    fi
    case "$prof" in
        baseline) args=(--raw "$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw" -p 1); url=http://localhost:$port ;;
        pipelined) args=(-p 16); url=http://localhost:$port/pipeline ;;
        json) args=(--raw "$W/json-25.raw,$W/json-40.raw,$W/json-50.raw" -p 1); url=http://localhost:$port ;;
        json-comp) args=(--raw "$W/json-comp-25.raw,$W/json-comp-40.raw,$W/json-comp-50.raw" -p 1); url=http://localhost:$port ;;
        json-comp-16k) args=(--raw "$W/json-comp-25.raw,$W/json-comp-40.raw,$W/json-comp-50.raw" -p 1); url=http://localhost:$port; pc=16384 ;;
        limited-conn) args=(--raw "$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw" -p 1 -r 10); url=http://localhost:$port ;;
        # 本家の形 = GET /delay/10 を 32000 接続で保持（req_per_conn 無制限・天井 = conns/delay = 3.2M）
        async) args=(--raw "$REQ/async-delay.raw" -p 1); url=http://localhost:$port; pc=${ASYNC_CONNS:-32000} ;;
        *) echo "local.sh: unknown profile $prof" >&2; return 1 ;;
    esac
    c0=$(cpu_ticks)
    txt=$(timeout $((dur + 30)) taskset -c "$LOAD_CPUS" "$GC" "$url" "${args[@]}" -c "$pc" -t "$nload" -d "${dur}s" 2>&1)
    c1=$(cpu_ticks)
    echo "$txt" > "$W/gc-$name-$prof-$k.txt"
    local rps resp ok p99 p999
    rps=$(echo "$txt" | sed -n 's/^ *Throughput: *\([0-9.]*\)\([KM]*\) req\/s.*/\1 \2/p' | awk '{ m = $2 == "M" ? 1e6 : $2 == "K" ? 1e3 : 1; printf "%.0f", $1 * m }')
    resp=$(echo "$txt" | sed -n 's/.* requests in .*, \([0-9]*\) responses.*/\1/p')
    ok=$(echo "$txt" | sed -n 's/.*2xx=\([0-9]*\).*/\1/p')
    # 列 = Avg p50 p90 p99 p99.9（$5 が p99・$6 が p99.9 — 703 まで $4 = p90 を p99 として出していた）
    p99=$(echo "$txt" | awk '/^ *Latency +[0-9]/ { print $5 }')
    p999=$(echo "$txt" | awk '/^ *Latency +[0-9]/ { print $6 }')
    emit "$name" "$prof" "$k" "$rps" "$resp" "$ok" $((c1 - c0)) "$p99" "$p999"
}

printf 'name\tprofile\tround\treq_s\tresponses\tnon2xx\tcpu_us_per_req\tp99\tp99_9\n' > "$out"
printf 'name\tprofile\tround\tvmhwm_kb\tvmrss_kb\tanonhuge_kb\n' > "$out.rss"
for prof in $profiles; do
    cur_prof=$prof
    for k in $(seq "$n"); do
        # 交互（周ごとに先後を入れ替える — 熱と時間帯の偏りを両側に散らす）
        order="sober go"
        [ $((k % 2)) = 0 ] && order="go sober"
        for name in $order; do
            start "$name" || exit 1
            sleep 0.3
            run_one "$name" "$prof" "$k" | tee -a "$out"
            rss_row "$name" "$prof" "$k"
            stop
            sleep 1
        done
    done
done

# 要約: 種目ごとの中央値と比（Sober / Go — req/s は大きいほど良い・CPU / 要求は小さいほど良い）
node --experimental-strip-types --no-warnings summary.ts "$out" > "$W/summary.md"
# RSS の要約（周の中央値の VmHWM — MB）: 種目 × 名前の表を summary.md に足す
if [ -s "$out.rss" ]; then
    {
        echo
        echo "## server RSS (VmHWM per round, median, MB)"
        awk -F'\t' 'NR > 1 { key = $2 "\t" $1; v[key] = v[key] " " $4 }
            END {
                for (key in v) {
                    n = split(v[key], a, " "); asort_n = n
                    for (i = 1; i < n; i++) for (j = i + 1; j <= n; j++) if (a[j] < a[i]) { t = a[i]; a[i] = a[j]; a[j] = t }
                    m = a[int((n + 1) / 2)]
                    printf "%s\t%.1f MB\n", key, m / 1024
                }
            }' "$out.rss" | sort
    } >> "$W/summary.md"
fi
# json-comp の応答 1 件のバイト（頭 + 本文・巡回の 3 つの平均 — 本家の採点の Bpr の物差し。gzip を解いた本文が Sober ≡ Go かも見る）
case " $profiles " in *" json-comp"*)
    for name in sober go; do
        start "$name" || exit 1
        tot=0
        for cm in 25:4 40:8 50:6; do
            curl -s -H 'Accept-Encoding: gzip, br' -D "$W/jc-$name-h" -o "$W/jc-$name-${cm%%:*}" "http://localhost:$port/json/${cm%%:*}?m=${cm##*:}"
            tot=$((tot + $(wc -c < "$W/jc-$name-h") + $(wc -c < "$W/jc-$name-${cm%%:*}")))
            grep -qi '^content-encoding: gzip' "$W/jc-$name-h" || echo "local.sh: WARN $name json-comp ${cm%%:*}: no Content-Encoding: gzip" >&2
        done
        stop
        eval "jc_$name=$((tot / 3))"
    done
    same=yes
    for c in 25 40 50; do
        cmp -s <(gzip -dc < "$W/jc-sober-$c") <(gzip -dc < "$W/jc-go-$c") || same=NO
    done
    echo "json-comp bytes/response (headers + body, mean of the 3): Sober $jc_sober · Go $jc_go · score factor (min Bpr / Bpr)² Sober $(awk -v s="$jc_sober" -v g="$jc_go" 'BEGIN { m = s < g ? s : g; printf "%.3f", (m / s) ^ 2 }') · Go $(awk -v s="$jc_sober" -v g="$jc_go" 'BEGIN { m = s < g ? s : g; printf "%.3f", (m / g) ^ 2 }') · decoded bodies Sober ≡ Go: $same" >> "$W/summary.md"
    ;;
esac
cat "$W/summary.md"
echo "(rounds $n × ${dur}s · $conns conns · server CPUs $SERVER_CPUS · load CPUs $LOAD_CPUS · gcannon threads $nload · median of rounds)"
[ -n "$summary" ] && { cat "$W/summary.md"; echo; echo "rounds $n × ${dur}s · $conns conns · server CPUs $SERVER_CPUS · load CPUs $LOAD_CPUS · median of rounds"; } > "$summary"
exit 0
