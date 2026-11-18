#!/usr/bin/env bash
# oversub: ワーカーの数がCPUより多い形で、rtの鍵とdomainを取り合う仕事が決まった時間の内に終わり、CPUが専用の形の数倍以内に収まるか。
# 題材 testdata/oversub（domainのUpdateの取り合い・Awaitで借りて返すプール・チャネル・spawnとJoin・net.Serveへの往復）を
# 専用の形（4ワーカーを4 CPU）と過剰な形（64ワーカーを4 CPU）で3回ずつ — 別々の4 CPUの組で同時に — 走らせ、印字（数だけ。スケジュールに依らない）の一致と、
# CPU時間（user + sys）の中央値の比・wallの中央値の差を見る。持ち手がOSに横取りされた鍵を待ち手が回り続ける形（rtの鍵の部品 lock.sober
# が譲らない形。変異105）では、過剰な形のCPUが専用の形の10倍を越える（手元で26〜29 CPU秒 対 1〜3秒）。
#   scripts/oversub.sh            変異105を建てて落ちることも確かめる（約30 CPU秒・4 CPUで約7秒。OVERSUB_MUT=0で省く）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
CPUS=${OVERSUB_CPUS:-0-3}
NDED=$(echo "$CPUS" | awk -F'[-,]' '{ print (NF == 2 ? $2 - $1 + 1 : NF) }')
WANT="update 6400000 borrow 64000 chan 160000 tree 4096 serve 8000 hits 8000"
K=${OVERSUB_K:-6}   # CPUの比の上限（過剰 / 専用）
fail=0
PRE="oversub: FAIL"
bad() { echo "$PRE: $*"; fail=$((fail + 1)); }
med() { sort -n | sed -n 2p; }
build() { # build <出力> [変異]
    local opt=
    [ -n "${2:-}" ] && opt=--rt-mutant=$2
    "$S2" build testdata/oversub/main.sober --emit=elf --passes $opt -o "$1" > "$W/b.log" 2>&1 || { echo "oversub: FAIL build ${2:-} ($(head -c 300 "$W/b.log"))"; exit 1; }
}
# 3つの形（専用 W4・過剰 W64・変異105 の W64）を、別々の4 CPUの組で同時に走らせる（同じ時間の負荷の下で比べる — 順に測ると、
# 測りの間に負荷が変われば暇なワーカーの回りのCPUが数倍動き、比が崩れる: 負荷のある専用 0.18 s 対 負荷の無い過剰 3.06 s など）。
# CPUが12に満たなければ、同じ組で順に走らせる（負荷が変わらない環境の形）
mapfile -t AV < <(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }')
if [ -z "${OVERSUB_CPUS:-}" ] && [ "${#AV[@]}" -ge 12 ]; then
    SA="${AV[0]},${AV[1]},${AV[2]},${AV[3]}"; SB="${AV[4]},${AV[5]},${AV[6]},${AV[7]}"; SC="${AV[8]},${AV[9]},${AV[10]},${AV[11]}"; PAR=1
else
    SA=$CPUS; SB=$CPUS; SC=$CPUS; PAR=0
fi
# one <実行ファイル> <ワーカー数> <CPUの組> <出力>: "<cpu秒> <wall秒> <印字>" を <出力> へ
one() {
    local out
    out=$(SOBER_WORKERS=$2 /usr/bin/time -f "%U %S %e" -o "$4.t" timeout 60 taskset -c "$3" "$1" 2> /dev/null)
    # time の出力の最後の行（0以外で終わると、前に "Command exited with non-zero status" の行が入る）
    awk -v o="$out" 'END { printf "%.2f %.2f %s\n", $1 + $2, $3, o }' "$4.t" > "$4"
}
build "$W/ov"
mut=${OVERSUB_MUT:-1}
[ "$mut" = 1 ] && build "$W/ov105" 105
: > "$W/d"; : > "$W/o"; : > "$W/m"
for k in 1 2 3; do
    if [ "$PAR" = 1 ]; then
        one "$W/ov" "$NDED" "$SA" "$W/d.$k" & one "$W/ov" 64 "$SB" "$W/o.$k" &
        [ "$mut" = 1 ] && one "$W/ov105" 64 "$SC" "$W/m.$k" &
        wait
    else
        one "$W/ov" "$NDED" "$SA" "$W/d.$k"; one "$W/ov" 64 "$SB" "$W/o.$k"
        [ "$mut" = 1 ] && one "$W/ov105" 64 "$SC" "$W/m.$k"
    fi
    cat "$W/d.$k" >> "$W/d"; cat "$W/o.$k" >> "$W/o"; [ "$mut" = 1 ] && cat "$W/m.$k" >> "$W/m"
done
for f in d o; do
    while read -r _ _ out; do [ "$out" = "$WANT" ] || bad "$f: output '$out' (want '$WANT')"; done < "$W/$f"
done
dc=$(awk '{ print $1 }' "$W/d" | med); dw=$(awk '{ print $2 }' "$W/d" | med)
oc=$(awk '{ print $1 }' "$W/o" | med); ow=$(awk '{ print $2 }' "$W/o" | med)
echo "oversub: CPUs $SA / $SB / $SC (at the same time: $PAR), dedicated W$NDED cpu ${dc}s wall ${dw}s | W64 cpu ${oc}s wall ${ow}s"
# 専用の形のCPUは、暇なワーカーが回る分で、同じ時間に測っても負荷しだいで 0.2〜3 秒動く（CPUの組にほかの仕事があれば譲る）。基準の床を1秒にする
# （普通の W64 は負荷の下でも 3.2 秒を越えなかった。変異105のような譲らない回り方は 9〜38 秒）
awk -v d="$dc" -v o="$oc" -v k="$K" 'BEGIN { exit !(o <= k * (d < 1 ? 1 : d)) }' || bad "W64 cpu ${oc}s > ${K} x max(dedicated ${dc}s, 1s)"
awk -v d="$dw" -v o="$ow" 'BEGIN { exit !(o <= 2 * d + 2) }' || bad "W64 wall ${ow}s > 2 x dedicated ${dw}s + 2s"
if [ "$mut" = 1 ]; then
    # 変異は、3回の各回で、出力が崩れる（Serveの往復が期限に間に合わない）か、CPUが同じ回の専用の形の上限を越えれば捕まえたことにする。
    # 3回のうち2回以上で捕まえれば検出
    nc=0; k=1
    while read -r mc _ mo; do
        read -r kc _ _ < "$W/d.$k"
        if [ "$mo" != "$WANT" ] || awk -v d="$kc" -v o="$mc" -v k="$K" 'BEGIN { exit !(o > k * (d < 0.5 ? 0.5 : d)) }'; then nc=$((nc + 1)); fi
        k=$((k + 1))
    done < "$W/m"
    echo "oversub: mutant 105 (spin without yield) W64 cpu $(awk '{ printf "%s ", $1 }' "$W/m")s — caught in $nc of 3"
    [ "$nc" -ge 2 ] || bad "mutant 105 not caught (caught in $nc of 3)"
fi
[ "$fail" = 0 ] && echo "oversub: ok" || exit 1
