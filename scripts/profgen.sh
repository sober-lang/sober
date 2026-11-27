#!/usr/bin/env bash
# 熱さのプロファイルを取る（lower/profile.sober の入力 — `sober build --profile=<file>`）:
#   scripts/profgen.sh <出力のファイル> [--check]
# 題材 = bench/httparena/main.sober のサーバ。今の木のstage2で、プロファイルなしのELF・関数の先頭番地の表（--emit=syms）・ブロックの番地の表
# （--blkmap）を作り、callgrind（reqinstと同じ形 — W1・SOBER_IO=2・SOBER_HASH_SEED=0・客とサーバを別のCPUに固定）で題材ごとに
# 束の少と多の2本を流して、scripts/profgen.ts が冷たいブロックの集合を書く。
#   題材: pipeline・hdr（束 20 / 220）・jsoncomp（gzipの符号器 — 束 2 / 22）・bget・bpost・bchunk（HttpArenaのbaselineの3本 — keep-aliveで1本ずつ 320 / 3520。受けの待ちを通る）。ringのパス（SOBER_IO=2でないパス）はcallgrindで測れないので、
#   そこでだけ通る関数には行が付かない（静的な判定のまま）
#   冷たい = どの題材でも1要求あたりPROFGEN_TH（既定 1/64）回未満。プロファイルを取るELFはプロファイルなしでビルドする（プロファイルは
#   吐く順にしか効かないので、ブロックの番号と指紋はプロファイルの有無で変わらない — 取り直しが前のプロファイルに依らない）
#   --check: 2回取って同じファイルになることを確かめる（しきい値の近くのブロックが揺れで出入りしないか）
set -uo pipefail
export SOBER_HASH_SEED=0
cd "$(dirname "$0")/.."
R=$PWD
OUT=${1:?出力のファイル}
CHECK=0
[ "${2:-}" = --check ] && CHECK=1
[ -n "${STAGE2:-}" ] || scripts/stage2.sh --quiet || exit 1
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
VG=${VALGRIND:-$(command -v valgrind)}
[ -n "$VG" ] || { echo "profgen: FAIL — valgrind が無い"; exit 1; }
TH=${PROFGEN_TH:-0.015625}
mapfile -t cpus < <(taskset -pc $$ | sed 's/.*: //' | tr ',' '\n' | awk -F- '{ if (NF == 2) for (i = $1; i <= $2; i++) print i; else print $1 }')
[ "${#cpus[@]}" -ge 2 ] || { echo "profgen: FAIL — CPUが2つ未満（客とサーバを分けて固定できない）"; exit 1; }
CS=${cpus[${#cpus[@]} - 1]}
CC=${cpus[${#cpus[@]} - 2]}
W=$(mktemp -d)
trap 'kill $(jobs -p) 2> /dev/null; rm -rf "$W"' EXIT
DATA=$R/testdata/httpcheck/dataset.json

"$S2" build bench/httparena/main.sober --emit=elf --passes -o "$W/srv" > "$W/build.log" 2>&1 || { echo "profgen: FAIL build: $(tail -c 400 "$W/build.log")"; exit 1; }
"$S2" build bench/httparena/main.sober --emit=syms -o "$W/srv.syms" > "$W/syms.log" 2>&1 || { echo "profgen: FAIL syms: $(tail -c 400 "$W/syms.log")"; exit 1; }
SOBER_WORKERS=1 SOBER_CHECK_REPLAY=0 SOBER_BUILD_CACHE=0 "$S2" build bench/httparena/main.sober --emit=elf --passes --blkmap -o "$W/srv.map.elf" > "$W/blkmap" 2> "$W/blkmap.err" \
    || { echo "profgen: FAIL blkmap: $(tail -c 400 "$W/blkmap.err")"; exit 1; }
cmp -s "$W/srv" "$W/srv.map.elf" || { echo "profgen: FAIL — --blkmap のELFがプロファイルなしのELFと違う"; exit 1; }

ready() { # ready <出力のファイル> <pid>
    local i port=""
    for i in $(seq 1200); do
        port=$(awk '$1 == "ready" { print $2; exit }' "$1" 2> /dev/null)
        [ -n "$port" ] && break
        kill -0 "$2" 2> /dev/null || break
        sleep 0.1
    done
    echo "$port"
}

# run <題材> <束> <出力の頭> [<束の大きさ>]: サーバをcallgrindに掛けて題材を束の数だけ流す（束の大きさの既定は16）
run() {
    local subj=$1 k=$2 o=$3 bsz=${4:-16} vp port
    SOBER_WORKERS=1 SOBER_IO=2 SOBER_MDWE=0 TLS_CERT=/nonexistent TLS_KEY=/nonexistent DATASET_PATH=$DATA taskset -c "$CS" "$VG" --tool=callgrind --dump-instr=yes \
        --callgrind-out-file="$o.cg" "$W/srv" 0 0 > "$o.out" 2>&1 &
    vp=$!
    port=$(ready "$o.out" $vp)
    [ -n "$port" ] || { echo "profgen: FAIL — サーバが ready を出さない（$subj）"; return 1; }
    NODE_NO_WARNINGS=1 taskset -c "$CC" node --experimental-strip-types scripts/reqinst.ts cli "$port" "$k" "$subj" "$bsz" 2> "$o.cli" || { echo "profgen: FAIL — 客（$subj）: $(tail -c 300 "$o.cli")"; return 1; }
    kill -TERM $vp
    wait $vp 2> /dev/null
    return 0
}

# once <出力>: 題材を全部流してプロファイルを書く
once() {
    local args=() s k1 k2 bsz
    for s in pipeline:20:220:16 hdr:20:220:16 jsoncomp:2:22:16 bget:320:3520:1 bpost:320:3520:1 bchunk:320:3520:1; do
        IFS=: read -r subj k1 k2 bsz <<< "$s"
        run "$subj" "$k1" "$W/$subj.$k1" "$bsz" || return 1
        run "$subj" "$k2" "$W/$subj.$k2" "$bsz" || return 1
        args+=("$W/$subj.$k1.cg:$W/$subj.$k2.cg:$(( (k2 - k1) * bsz ))")
    done
    NODE_NO_WARNINGS=1 node --max-old-space-size=8000 --experimental-strip-types scripts/profgen.ts "$W/blkmap" "$W/srv.syms" "$TH" "${args[@]}" > "$1"
}

once "$OUT" || exit 1
if [ $CHECK = 1 ]; then
    once "$W/again.prof" || exit 1
    cmp -s "$OUT" "$W/again.prof" || { echo "profgen: FAIL — 2回目のプロファイルが1回目と違う"; diff "$OUT" "$W/again.prof" | head -10; exit 1; }
    echo "profgen: 2回の取りが一致"
fi
echo "profgen: $OUT（$(($(wc -l < "$OUT") - 1)) 行）"
