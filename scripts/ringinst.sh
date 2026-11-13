#!/usr/bin/env bash
# ringinst（ring の道の要求 1 件の命令の網）: reqinst は callgrind の下で走るので W1・epoll の道しか測れない（ring の受け・待ち・送りの値札が漏れる）。
# こちらは bench/httparena/main.sober を今の木の stage2 で建て、W2（ring の道 — W1 は ring を作らない）で perf stat の instructions:u を
# 起動から終了まで数え、keep-alive の 1 接続に要求を 1 本ずつ送る束 K1 / K2 の 2 本の差 ÷ (K2 − K1) =「命令/要求」を
# bench/ratchet.txt の `ring/<題材> ireq <上限>` と照合する。要求 1 本ずつなので受け・待ち・送りの ring の道が要求ごとに 1 回ずつ乗る。
# 同じ ELF の揺れ ±0.01 命令/要求（起動と終了は差で消える・暇なワーカーは ring の待ちで眠る）→ 余白は実測の最大 + 2。
#   scripts/ringinst.sh         照合。越えたら赤 — 正当な増えなら実測 + 2 で引き直し、報告とコミットに明記して事後追認。0.5% 以上下がったら締め直しの note
#   毎回、変異 61（ring の道の受けだけに ≈ 24 命令）で建てた ELF が pipeline の線で赤になることも確かめる（網の自己検査）
# perf（PERF → PATH → /nix/store）・io_uring・CPU 3 つのどれかが無い箱では SKIP（緑）。
set -uo pipefail
export SOBER_HASH_SEED=0
cd "$(dirname "$0")/.."
R=$PWD
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*-perf-linux-*/bin/perf 2> /dev/null | sort -V | tail -n 1)}
if [ -z "$PERF" ] || ! "$PERF" stat -x, -e instructions:u -- true > /dev/null 2>&1; then
    echo "SKIP ringinst — perf stat の instructions:u が使えない（PERF で perf を指す）: ring の道の命令は照合していない"
    exit 0
fi
mapfile -t cpus < <(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }')
if [ "${#cpus[@]}" -lt 3 ]; then
    echo "SKIP ringinst — 使える CPU が 3 つ未満（サーバのワーカー 2 本と客を別の CPU に固定する）: ring の道の命令は照合していない"
    exit 0
fi
CS="${cpus[${#cpus[@]} - 1]},${cpus[${#cpus[@]} - 2]}"
CC=${cpus[${#cpus[@]} - 3]}
W=$(mktemp -d)
trap 'kill $(jobs -p) 2> /dev/null; rm -rf "$W"' EXIT
K1=1000
K2=21000

# total <srv> <題材> <束の数> → 起動から終了までの instructions:u
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

# ireq <srv> <題材> → 命令/要求（小数 1 桁）
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
    if [ $ec = 2 ]; then echo "SKIP ringinst — io_uring がこの箱で使えない: ring の道の命令は照合していない"; exit 0; fi
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
# 網の自己検査: 変異 61 の ELF が最初の題材の線で赤になる
"$S2" build bench/httparena/main.sober --rt-mutant=61 -o "$W/srv61" > "$W/build61.log" 2>&1 || { echo "ringinst: FAIL build（変異 61）: $(tail -c 400 "$W/build61.log")"; exit 1; }
subj=${subjs[0]}
lim=$(awk -v k="ring/$subj" '$1 == k && $2 == "ireq" { print $3; exit }' bench/ratchet.txt)
mv=$(ireq "$W/srv61" "$subj") || mv=""
if [ -n "$mv" ] && awk -v v="$mv" -v l="$lim" 'BEGIN { exit !(v > l) }'; then echo "mutant 61 ring/$subj: $mv > $lim — caught"
else echo "FAIL mutant 61 ring/$subj: ${mv:-?} — not caught（線 $lim）"; fail=$((fail + 1)); fi
echo "ringinst: $n lines (ring/* ireq in bench/ratchet.txt), fail=$fail"
[ $fail = 0 ]
