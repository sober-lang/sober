#!/usr/bin/env bash
# starve.sh <srvbin> [conns] [env…] — 飢えの持続の検査（report-685）: ss -tni の接続ごとの segs_out を t = 1.5 / 2.5 / 4.5 s で取り、窓 A（1 s）・
# 窓 B（2 s）で応答 0 の接続の割合と「両方で 0」（独立なら A × B — 持続する飢えなら A と同じ）・飢えている接続の segs_out の絶対値の分布
# （1 = SYN-ACK だけ = 一度も応答していない）を出す。サーバ 0-11・W12 / 負荷 12-23（layer4.sh と同じ）
. "$(dirname "$0")/env.sh"   # S（計器）・GC・R・W（作業）
b=$1; c=${2:-4096}; shift $(( $# < 2 ? $# : 2 ))   # 引数が N 未満でも位置引数を残さない（shift N の失敗で "$@" にサーバのパスが残り env の後ろで起動を壊す — report-689）
p=$((30000 + RANDOM % 20000))
env SOBER_WORKERS=12 "$@" taskset -c 0-11 $b $p > /dev/null 2>&1 & SP=$!
sleep 0.3
taskset -c 12-23 $GC http://localhost:$p --raw $R/get.raw -c $c -t 12 -d 6s > $W/st.gc 2>&1 & GP=$!
sleep 1.5; taskset -c 23 ss -tniH state established "( sport = :$p )" > $W/st1
sleep 1; taskset -c 23 ss -tniH state established "( sport = :$p )" > $W/st2
sleep 2; taskset -c 23 ss -tniH state established "( sport = :$p )" > $W/st3
wait $GP; kill $SP; wait $SP 2>/dev/null
awk 'FNR == 1 { f++ } /^[0-9]/ { peer = $4; next } { if (match($0, /segs_out:[0-9]+/)) v[f, peer] = substr($0, RSTART + 9, RLENGTH - 9); seen[peer] = 1 }
  END { for (k in seen) { n++; za = (v[2, k] == v[1, k]); zb = (v[3, k] == v[2, k]); a += za; b += zb; ab += za && zb; if (za && zb) h[v[3, k] + 0]++ }
        printf "conns %d | zero in A(1s) %.0f%% | zero in B(2s) %.0f%% | both %.0f%% (indep. %.0f%%) | starved segs_out:", n, 100*a/n, 100*b/n, 100*ab/n, 100*(a/n)*(b/n)
        m = 0; for (x in h) if (m++ < 6) printf " %s:%d", x, h[x]; printf "\n" }' $W/st1 $W/st2 $W/st3
grep Throughput $W/st.gc
