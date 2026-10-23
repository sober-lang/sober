#!/usr/bin/env bash
# perf.sh — Sober サーバの CPU の内訳（cpu-clock の flat サンプリング・カーネルのシンボル込み）。
# baseline の負荷を掛けながらサーバの pid をサンプリングし、perf report（flat — Sober の ELF は
# unwind 情報を持たないので call graph は取らない）を出す。目的 = sys 側（loopback の TCP・io_uring）の
# 内訳の帰属（report-673 — CPU / 要求の 3/4 がカーネルで、user の命令を削っても動かない）。
# PMU の無い VM（GH Actions / WSL2）向けに -e cpu-clock。カーネルのシンボルには
# kernel.perf_event_paranoid=-1 と kernel.kptr_restrict=0 が要る（workflow が sysctl で設定）。
#
#   bench/httparena/perf.sh [-d 秒] [-c 接続] [--profile baseline|pipelined|async] [-o レポートの出力先]
# async = local.sh と同じ形（GET /delay/10・接続は -c でなく $ASYNC_CONNS 既定 32000 — 保留のタイマーを運ぶ接続の数が種目の形。
# TIME_WAIT を大量に残すので、並べるなら最後に）。nofile は呼び手が上げておく（workflow は prlimit）
# 前提: perf・gcannon（PATH か $GCANNON）・go は不要（Sober 側だけ）。CPU の割りは cpus.sh と同じ。
set -uo pipefail
cd "$(dirname "$0")"
ROOT=$(cd ../.. && pwd)
dur=10
conns=4096
prof=baseline
out=
while [ $# -gt 0 ]; do
    case "$1" in
        -d) dur=$2; shift ;;
        -c) conns=$2; shift ;;
        --profile) prof=$2; shift ;;
        -o) out=$2; shift ;;
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

"$ROOT/bin/sober" build main.sober -o "$W/sober-srv" > "$W/b1.log" 2>&1 || { echo "perf.sh: sober build failed: $(head -c 300 "$W/b1.log")" >&2; exit 1; }

# port は 18000 番台（local.sh と同じ — ephemeral の範囲と重ねない。async の後は TIME_WAIT の客側 port に bind して黙って失敗する）
port=$((18500 + RANDOM % 400))
for try in 1 2 3; do
    port=$((port + 1))
    env SOBER_WORKERS=$nsrv taskset -c "$SERVER_CPUS" "$W/sober-srv" "$port" > "$W/srv.out" 2> "$W/srv.err" &
    SP=$!
    for i in $(seq 100); do grep -q '^ready' "$W/srv.out" 2> /dev/null && break; sleep 0.05; done
    grep -q '^ready' "$W/srv.out" && break
    kill "$SP" 2> /dev/null; wait "$SP" 2> /dev/null; SP=
    echo "perf.sh: server did not start on port $port (try $try): $(head -c 200 "$W/srv.err")" >&2
done
[ -n "$SP" ] || exit 1

case "$prof" in
    baseline) args=(--raw "$REQ/get.raw,$REQ/post_cl.raw,$REQ/post_chunked.raw" -p 1); url=http://localhost:$port ;;
    pipelined) args=(-p 16); url=http://localhost:$port/pipeline ;;
    async) args=(--raw "$REQ/async-delay.raw" -p 1); url=http://localhost:$port; conns=${ASYNC_CONNS:-32000} ;;
    *) echo "perf.sh: unknown profile $prof" >&2; exit 2 ;;
esac
timeout $((dur + 30)) taskset -c "$LOAD_CPUS" "$GC" "$url" "${args[@]}" -c "$conns" -t "$nload" -d "$((dur + 2))s" > "$W/gc.txt" 2>&1 &
GCP=$!
sleep 1
# -g: カーネル側の呼び出し鎖はカーネル自身の unwinder（ORC）で辿れる。user 側（Sober の ELF —
# fp も unwind 情報も無い）は壊れるが、目的はカーネルの帰属（spin_unlock_irqrestore の呼び手等）
perf record -q -e cpu-clock -F 997 -g -p "$SP" -o "$W/perf.data" -- sleep "$dur" || { echo "perf.sh: perf record failed" >&2; kill $GCP 2>/dev/null; exit 1; }
wait "$GCP" 2> /dev/null

{
    echo "# perf.sh — profile=$prof conns=$conns dur=${dur}s server CPUs $SERVER_CPUS (workers $nsrv) load CPUs $LOAD_CPUS"
    grep -E 'Throughput|Latency' "$W/gc.txt" | head -3
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
