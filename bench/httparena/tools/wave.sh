#!/usr/bin/env bash
# wave.sh <srvbin> [rounds] [conns] [env…] — ring の道の劣化の再現と常備の検査（report-671 4 節 / 672）: 同じサーバのプロセスに 4096 接続 × 3 秒を rounds 回 → 64 接続を 1 回。
# 判定（最後の行 — PASS / FAIL）: 波の後の 64 接続の req/s が 1 回目の 4096 接続の 15% 以上（旧 rt は 5% 前後〔18〜27K / 390〜500K〕・直した rt は 35〜130%）。
# gate にしない理由（report-672 4 節）: 小さい題材（testdata の 512 接続 → CPU の仕事）では旧 rt の偏りが W8 で 1/10・W4 で 0/10 しか出ず、gcannon と
# 実時間に依る数の網は gate の偽赤の種になる — 便ごとに手で回す（rt の mn / uring / netring を触ったとき）
# 各回の req/s と、選択 strace（各回ごとにスレッド全部へ attach — 計測用パッチの印の syscall: getppid = ENOBUFS・geteuid = RECV の終わり〔F_MORE なし〕・
# getuid = 環が空で read へ倒す・getgid = RECV を張る）の数を出す。STRACE=1 で strace あり（既定なし）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業） — env.sh の注
b=$1; rounds=${2:-3}; conns=${3:-4096}; shift $(( $# < 3 ? $# : 3 ))   # 引数が N 未満でも位置引数を残さない（shift N の失敗で "$@" にサーバのパスが残り env の後ろで起動を壊す — report-689）
port=$((30000 + RANDOM % 20000))
if [ "${STRACE:-0}" = 1 ]; then
  env SOBER_WORKERS=12 "$@" taskset -c 0-11 strace -f -q --seccomp-bpf -ttt -e trace=getpriority,geteuid,getuid,getgid,getsid,getpgrp -o $W/wave.tr "$b" $port > /dev/null 2>&1 &
else
  env SOBER_WORKERS=12 "$@" taskset -c 0-11 "$b" $port > /dev/null 2>&1 &
fi
SP=$!
sleep 0.4
one() {
  local c=$1 tag=$2 tp=
  local t0 t1
  t0=$(date +%s.%N)
  r=$(taskset -c 12-23 $GC http://localhost:$port --raw $R/get.raw -c $c -t 12 -d 3s -p 1 2>&1 | sed -n 's/^ *Throughput: *//p')
  t1=$(date +%s.%N)
  echo "$r" > $W/wave.$tag
  echo "$tag ${c}c: $r $( [ "${STRACE:-0}" = 1 ] && awk -v a=$t0 -v b=$t1 '$2 >= a && $2 <= b { split($3, f, "("); n[f[1]]++ } END { for (k in n) printf " %s=%d", k, n[k] }' $W/wave.tr)"
  sleep 1
}
for k in $(seq $rounds); do one $conns run$k; done
one 64 after
pkill -TERM -P $SP 2>/dev/null; kill $SP 2>/dev/null; wait $SP 2>/dev/null
num() { awk '{ m = $2 ~ /^M/ ? 1e6 : $2 ~ /^K/ ? 1e3 : 1; v = $1; sub(/[KM]$/, "", v); if ($1 ~ /K$/) m = 1e3; if ($1 ~ /M$/) m = 1e6; printf "%.0f", v * m }' "$1"; }
a=$(num $W/wave.run1); z=$(num $W/wave.after)
if [ "$a" -gt 0 ] && [ $((z * 100 / a)) -ge 15 ]; then echo "wave: PASS (after 64c = $((z * 100 / a))% of run1)"; else echo "wave: FAIL (after 64c = $z req/s vs run1 $a)"; exit 1; fi
