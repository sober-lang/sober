#!/usr/bin/env bash
# pincheck: ワーカーのCPUの固定の検査（language.md 11 節「ワーカーのCPUの固定」）。testdata/pinを走らせ、印字したLedgerのpin / pinGroupsと
# /proc/<pid>/task/*/status の Cpus_allowed_list を照合する。
# - 本物のsysfs（マシンの構成に依る）: 不変だけ見る — SOBER_PIN=0は全ワーカーが許可の全体・2は1ワーカー1 CPUで全部違う・1は各ワーカーの集合が許可の部分集合で、
#   同じ集合どうしは数が群の CPU の数と一致し、pin が 1 か 3（縮退）
# - ミュータント49（作業ディレクトリのllc-fake/ の作った木を読む）: 3群（0-3,12-15 / 4-7,16-19 / 8-11,20-23）のマシンの模造で、tasksetの交差・群の数・
#   壊れたファイル（level が 2・cpulist の解釈の失敗）の縮退まで決まった値で見る
# - ミュータント48（index9 — 群が読めないマシン）: pin 3・全ワーカーがCPU 1つへ縮退
#   scripts/pincheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bad() { echo "pincheck: FAIL — $*"; fail=$((fail + 1)); }
for m in 0 48 49; do
    opt=
    [ "$m" != 0 ] && opt=--rt-mutant=$m
    "$S2" build testdata/pin/main.sober $opt -o "$W/pin$m" > "$W/b.log" 2>&1 || { echo "pincheck: FAIL build m$m ($(head -c 200 "$W/b.log"))"; exit 1; }
done
# run <dir> <ncpu の制限（空 = なし）> <env…> — 走らせて印字の行を "$W/line"・ワーカーの集合（行ごと）を "$W/sets" へ
run() {
    local dir=$1 cpus=$2
    shift 2
    local ts=()
    [ -n "$cpus" ] && ts=(taskset -c "$cpus")
    ( cd "$dir" && exec env -u SOBER_WORKERS -u SOBER_PIN "$@" "${ts[@]}" "$W/$X" 2000 ) > "$W/out" 2> "$W/err" &
    local pid=$!
    for _ in $(seq 200); do grep -q '^sum' "$W/out" 2> /dev/null && break; sleep 0.02; done
    : > "$W/sets"
    for t in /proc/$pid/task/*; do
        awk '/^Cpus_allowed_list:/ { print $2 }' "$t/status" 2> /dev/null >> "$W/sets"
    done
    kill "$pid" 2> /dev/null
    wait "$pid" 2> /dev/null
    head -n 1 "$W/out" > "$W/line"
}
# 集合の数え: "<本数> <集合>" の行（集合の昇順）
sets() { sort "$W/sets" | uniq -c | awk '{ print $1, $2 }' | sort -k2; }
field() { awk -v k="$1" '{ for (i = 1; i < NF; i++) if ($i == k) print $(i + 1) }' "$W/line"; }

# --- 本物の sysfs ---
X=pin0
allowed=$(awk '/^Cpus_allowed_list:/ { print $2 }' /proc/self/status)
run . "" SOBER_PIN=0
[ "$(field pin)" = 0 ] && [ "$(field groups)" = 0 ] || bad "PIN=0: $(cat "$W/line")"
[ "$(sort -u "$W/sets")" = "$allowed" ] || bad "PIN=0: sets $(sets | tr '\n' ' ') (want all $allowed)"
run . "" SOBER_PIN=2
nw=$(field workers)
[ "$(field pin)" = 2 ] && [ "$(field groups)" = "$nw" ] || bad "PIN=2: $(cat "$W/line")"
[ "$(sort -u "$W/sets" | grep -cv '[-,]')" = "$nw" ] || bad "PIN=2: sets $(sets | tr '\n' ' ') (want $nw distinct single CPUs)"
run . "" SOBER_PIN=1
p=$(field pin)
[ "$p" = 1 ] || [ "$p" = 3 ] || bad "PIN=1: $(cat "$W/line")"
# 各集合の CPU の数 = その集合のワーカーの数（W = 許可の数・昇順の割り当て）・群の数 = 集合の数（縮退していなければ）
while read -r n s; do
    c=$(echo "$s" | tr ',' '\n' | awk -F- '{ n += (NF == 2 ? $2 - $1 + 1 : 1) } END { print n }')
    [ "$c" = "$n" ] || bad "PIN=1: set $s has $c CPUs but $n workers"
done < <(sets)
[ "$p" = 3 ] || [ "$(sets | wc -l)" = "$(field groups)" ] || bad "PIN=1: groups $(field groups) vs $(sets | wc -l) sets"

# --- ミュータント49: 3群の模造 ---
F=$W/fk
mkdir -p "$F"
mk() { # mk <cpu> <level> <shared_cpu_list>
    local d=$F/llc-fake/cpu$1/cache/index3
    mkdir -p "$d"
    printf '%s\n' "$2" > "$d/level"
    printf '%s\n' "$3" > "$d/shared_cpu_list"
}
fake() { # 全 CPU を 3 群に
    rm -rf "$F/llc-fake"
    for c in $(seq 0 23); do g=$(((c % 12) / 4)); mk "$c" 3 "$((g * 4))-$((g * 4 + 3)),$((g * 4 + 12))-$((g * 4 + 15))"; done
}
X=pin49
expect() { # expect <名> <pin> <groups> <集合の数え（"本数 集合" を ; で区切る）>
    local got
    got=$(sets | tr '\n' ';' | sed 's/;$//')
    [ "$(field pin)" = "$2" ] && [ "$(field groups)" = "$3" ] && [ "$got" = "$4" ] || bad "$1: $(cat "$W/line") sets [$got] want pin $2 groups $3 [$4]"
}
if [ "$(nproc --all)" -ge 24 ] && taskset -c 0-23 true 2> /dev/null && [ "$allowed" = "0-$(($(nproc --all) - 1))" ]; then
    fake
    run "$F" 0-23 SOBER_PIN=1
    expect "m49 3 groups" 1 3 "8 0-3,12-15;8 4-7,16-19;8 8-11,20-23"
    run "$F" 2-13 SOBER_PIN=1
    expect "m49 taskset 2-13" 1 3 "4 2-3,12-13;4 4-7;4 8-11"
    run "$F" 0-3,12-15 SOBER_PIN=1
    expect "m49 one group" 1 1 "8 0-3,12-15"
    # 壊れたファイル: cpu5 の level が 2・cpu6 の cpulist が解釈できない・cpu7 の項が逆順 → その 3 本は CPU 1 つへ縮退（pin 3）。cpu4 は群 4-7 のまま
    mk 5 2 4-7,16-19
    mk 6 3 4-x
    mk 7 3 7-4
    run "$F" 4-7 SOBER_PIN=1
    expect "m49 broken" 3 4 "1 4-7;1 5;1 6;1 7"
    # 既定（Serve でないプログラム）は固定しない
    fake
    run "$F" 0-23
    expect "m49 default (not Serve)" 0 0 "24 0-23"
else
    echo "pincheck: skip the m49 fake-topology cases (needs 24+ CPUs all allowed — have $(nproc --all), allowed $allowed)"
fi

# --- ミュータント48: 群が読めないマシン ---
X=pin48
run . "" SOBER_PIN=1
nw=$(field workers)
[ "$(field pin)" = 3 ] && [ "$(field groups)" = "$nw" ] || bad "m48: $(cat "$W/line")"
[ "$(sort -u "$W/sets" | grep -cv '[-,]')" = "$nw" ] || bad "m48: sets $(sets | tr '\n' ' ') (want $nw single CPUs)"

[ "$fail" = 0 ] && { echo "pincheck: PASS"; exit 0; }
exit 1
