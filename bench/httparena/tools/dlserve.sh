#!/usr/bin/env bash
# dlserve.sh [runs] [conns] — 期限の scope の中の Serve が負荷の最中に期限を迎えても終わることの常備の検査（report-700）: dlsrv.sober（Serve を期限 8 秒の
# scope で包んだサーバ）に limited-conn の形（-r 10）を 9 秒（期限が負荷の最中に来る）掛けて、期限の後 12 秒以内に終わるかを runs 回。
# 旧 rt（SQ の空きを見ずに積む eventfd の読みが、期限の走査の取り消しで満杯の SQ を 1 本越えて未提出の SEND を上書き → その待ち手が誰にも起こされない）は
# 8192 接続で 5〜10 回に 1 回止まった（窓で率が動く — 0 / 20 の窓もあった）。判定（最後の行）: 止まった回数 0 で PASS。
# gate にしない理由: 1 回 10 秒 × 回数が要り、率が窓で動く（wave.sh と同じ扱い — rt の眠り / 起こし・SQ の積みを触ったら手で回す）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業） — env.sh の注
n=${1:-20}; c=${2:-8192}
S2=${STAGE2:-$(dirname "$0")/../../../out/stage2/sober2}
"$S2" build "$(dirname "$0")/dlsrv.sober" --emit=elf --passes -o $W/dlsrv > $W/dl.build 2>&1 || { echo "dlserve: FAIL build"; exit 1; }
hung=0
for i in $(seq $n); do
  port=$((30000 + RANDOM % 20000))
  env SOBER_WORKERS=12 taskset -c 0-11 $W/dlsrv $port > $W/dl.srv 2>&1 &
  SP=$!
  for k in $(seq 50); do grep -q ready $W/dl.srv 2>/dev/null && break; sleep 0.05; done
  taskset -c 12-23 $GC http://localhost:$port --raw $R/get.raw -p 1 -r 10 -c $c -t 12 -d 9s > /dev/null 2>&1
  for k in $(seq 60); do kill -0 $SP 2>/dev/null || break; sleep 0.2; done
  if kill -0 $SP 2>/dev/null; then echo "run $i: HUNG"; hung=$((hung + 1)); kill -9 $SP; fi
  wait $SP 2>/dev/null
done
if [ $hung = 0 ]; then echo "dlserve: PASS ($n runs × $c conns)"; else echo "dlserve: FAIL (hung $hung / $n)"; exit 1; fi
