#!/usr/bin/env bash
# ringinst（io_uringのパスのリクエスト1件の命令の検査）: reqinstはcallgrindの下で走るのでW1・epollのパスしか測れない（ringの受け・待ち・送りのコストが漏れる）。
# こちらはbench/httparena/main.soberを今の木のstage2でビルドし、W2（io_uringのパス — W1はringを作らない）で perf stat のinstructions:uを
# 起動から終了まで数え、keep-aliveの1接続にリクエストを1本ずつ送るバッチK1 / K2の2本の差 ÷ (K2 − K1) =「命令/リクエスト」を
# bench/ratchet.txtの `ring/<題材> ireq <上限>` と照合する。リクエスト1本ずつなので受け・待ち・送りのio_uringのパスがリクエストごとに1回ずつ乗る。
# 同じELFの揺れ ±0.01命令/リクエスト（起動と終了は差で消える・暇なワーカーはringの待ちでスリープする）→ 余白は実測の最大 + 2。
#   scripts/ringinst.sh         照合。越えたら赤 — 正当な増えなら実測 + 2で再設定し、報告とコミットに明記して事後承認。0.5%以上下がったら仕上げ直しのnote
#   毎回、ミュータント61（io_uringのパスの受けだけに ≈ 24命令）でビルドしたELFが、同じ実行の今のELFより命令/リクエストが多いことも確認する（自己検査）
# perf（PERF → PATH → /nix/store）・io_uring・CPU 3つのどれかが無ければFAIL（SOBER_GATES_ALLOW_SKIPにperf・io_uring・cpusを書いたときだけSKIP。gatelib.shのcant）。
set -uo pipefail
export SOBER_HASH_SEED=0
cd "$(dirname "$0")/.."
R=$PWD
# STAGE2の明示が無ければstage2を今のcompiler/ とstd/ に合わせる（stage2はstdを焼き込む — 古いstage2でビルドすると古いstdのサーバができる）
[ -n "${STAGE2:-}" ] || scripts/stage2.sh --quiet || exit 1
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
source scripts/gatelib.sh
need_perf ringinst "the ring path instruction counts"; pc=$?
[ $pc = 2 ] && exit 1
[ $pc = 1 ] && exit 0
mapfile -t cpus < <(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }')
if [ "${#cpus[@]}" -lt 3 ]; then
    cant ringinst cpus "the ring path instruction counts (fewer than 3 CPUs to pin 2 server workers and the client apart)" && exit 0
    exit 1
fi
CS="${cpus[${#cpus[@]} - 1]},${cpus[${#cpus[@]} - 2]}"
CC=${cpus[${#cpus[@]} - 3]}
W=$(mktemp -d)
trap 'kill $(jobs -p) 2> /dev/null; rm -rf "$W"' EXIT
K1=1000
K2=21000

# total <srv> <題材> <バッチの数> → 起動から終了までのinstructions:u
total() {
    local srv=$1 subj=$2 K=$3 o=$W/run pp port i
    SOBER_WORKERS=2 SOBER_MDWE=0 SOBER_IO_TRACE=1 TLS_CERT=/nonexistent TLS_KEY=/nonexistent \
        taskset -c "$CS" "$PERF" stat -x, -e instructions:u -o "$o.perf" -- "$srv" 0 0 > "$o.out" 2> "$o.err" &
    pp=$!
    port=""
    for i in $(seq 1200); do
        port=$(awk '$1 == "ready" { print $2; exit }' "$o.out" 2> /dev/null)
        [ -n "$port" ] && break
        kill -0 $pp 2> /dev/null || break
        sleep 0.05
    done
    [ -n "$port" ] || { echo "ringinst: サーバが ready を出さない（$subj）: $(tail -c 300 "$o.out" "$o.err")" >&2; kill $pp 2> /dev/null; return 1; }
    if ! grep -q 'backend=uring+net' "$o.err"; then
        echo "ringinst: ring の道に乗らない（$(grep -m1 -o 'backend=[a-z+]*' "$o.err")）" >&2; kill $(pgrep -P $pp) 2> /dev/null; return 2
    fi
    NODE_NO_WARNINGS=1 taskset -c "$CC" node --experimental-strip-types scripts/reqinst.ts cli "$port" "$K" "$subj" 1 2> "$o.cli" \
        || { echo "ringinst: 客が失敗（$subj 束 $K）: $(cat "$o.cli")" >&2; kill $(pgrep -P $pp) 2> /dev/null; return 1; }
    kill -TERM $(pgrep -P $pp)
    wait $pp 2> /dev/null
    awk -F, '/instructions/ { print $1; exit }' "$o.perf"
}

# ireq <srv> <題材> → 命令/リクエスト（小数1桁）
ireq() {
    local a b
    a=$(total "$1" "$2" $K1) || return $?
    b=$(total "$1" "$2" $K2) || return $?
    awk -v a="$a" -v b="$b" -v d=$((K2 - K1)) 'BEGIN { printf "%.1f\n", (b - a) / d }'
}

"$S2" build bench/httparena/main.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "ringinst: FAIL build: $(tail -c 400 "$W/build.log")"; exit 1; }
mapfile -t subjs < <(awk '$1 ~ /^ring\// && $2 == "ireq" { sub(/^ring\//, "", $1); print $1 }' bench/ratchet.txt)
[ "${#subjs[@]}" -gt 0 ] || { echo "ringinst: FAIL — bench/ratchet.txt に ring/<題材> ireq の行が無い"; exit 1; }
fail=0
n=0
for subj in "${subjs[@]}"; do
    v=$(ireq "$W/srv" "$subj"); ec=$?
    if [ $ec = 2 ]; then cant ringinst io_uring "the ring path instruction counts" && exit 0; exit 1; fi
    [ $ec = 0 ] || { echo "FAIL ring/$subj: 計測できない"; fail=$((fail + 1)); continue; }
    lim=$(awk -v k="ring/$subj" '$1 == k && $2 == "ireq" { print $3; exit }' bench/ratchet.txt)
    n=$((n + 1))
    if awk -v v="$v" -v l="$lim" 'BEGIN { exit !(v > l) }'; then
        echo "FAIL ring/$subj ireq = $v > $lim（bench/ratchet.txt — ring の道の要求 1 件の固定費の増え。正当なら実測 + 2 で引き直して事後追認）"; fail=$((fail + 1))
    elif awk -v v="$v" -v l="$lim" 'BEGIN { exit !(v * 1.005 < l) }'; then
        echo "note ring/$subj ireq = $v — 上限 $lim より下がった（bench/ratchet.txt を締め直す）"
    else
        echo "ok: ring/$subj ireq = $v ≤ $lim"
    fi
done
# 自己検査: ミュータント61（ringの道の受けだけに約24命令。差で測ると約15〜19命令/リクエスト）のELFを、同じ実行の中で今のELFと交互に対で測り、
# 差（変異 − 今）が MUT_MIN 以上の対を「捕まえた」、未満の対を「捕まえない」と数える。絶対の上限値との比較はしない（負荷の下では両方の値が数十命令ずれる）。
# 逐次の判定: 最初の3対が全部「捕まえた」なら検出で終わる。そうでなければ対を足し（最大 MUT_MAX = 9対）、どちらかが過半（5対）に届いた時点で決める
# （= 9対の中央値と同じ判定。負荷で1対の片方が ±45 ずれる外れが2対あっても崩れない。際どい回だけ時間が延びる — 1対 約20秒）
MUT_MIN=8
MUT_MAX=9
"$S2" build bench/httparena/main.sober --rt-mutant=61 -o "$W/srv61" > "$W/build61.log" 2>&1 || { echo "ringinst: FAIL build（変異 61）: $(tail -c 400 "$W/build61.log")"; exit 1; }
M61=$W/srv61
# 試験用: RINGINST_M61=base で、変異の代わりに今の ELF を対の両方に置く（差は雑音だけ — 「捕まえない」になることの確かめ）
[ "${RINGINST_M61:-}" = base ] && M61=$W/srv
subj=${subjs[0]}
yes=0; no=0; k=0; pairs=""; bad61=0
need=$(( MUT_MAX / 2 + 1 ))
while [ "$k" -lt "$MUT_MAX" ]; do
    b=$(ireq "$W/srv" "$subj") || b=""
    m=$(ireq "$M61" "$subj") || m=""
    [ -n "$b" ] && [ -n "$m" ] || { bad61=1; break; }
    k=$((k + 1))
    d=$(awk -v b="$b" -v m="$m" 'BEGIN { printf "%.1f\n", m - b }')
    pairs="$pairs $m−$b=$d"
    if awk -v d="$d" -v t="$MUT_MIN" 'BEGIN { exit !(d >= t) }'; then yes=$((yes + 1)); else no=$((no + 1)); fi
    [ "$k" = 3 ] && [ "$yes" = 3 ] && break
    [ "$yes" -ge "$need" ] || [ "$no" -ge "$need" ] && break
done
# 揺れの試験の道具（scripts/gatenoise.sh）が集める1行: 対の数・捕まえた対の数・差の列
echo "gatenoise: ringinst m61 pairs=$k caught=$yes deltas=$(sed 's/[^ ]*=//g; s/^ //; s/ /,/g' <<< "$pairs")"
if [ "$bad61" = 1 ]; then
    echo "FAIL mutant 61 ring/$subj: 計測できない"; fail=$((fail + 1))
elif [ "$yes" -gt "$no" ]; then
    echo "mutant 61 ring/$subj: caught in $yes of $k pairs (Δ ≥ $MUT_MIN; pairs:$pairs) — caught"
else
    echo "FAIL mutant 61 ring/$subj: caught in only $yes of $k pairs (Δ ≥ $MUT_MIN; pairs:$pairs) — not caught"; fail=$((fail + 1))
fi
echo "ringinst: $n lines (ring/* ireq in bench/ratchet.txt), fail=$fail"
[ $fail = 0 ]
