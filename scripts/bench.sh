#!/usr/bin/env bash
# bench（ロードマップ 4 — docs/bench.md）: 題材 6 本（1BRC・binary-trees・fannkuch-redux・fasta・reverse-complement・k-nucleotide — 後ろ 3 本は 5.7 の拡張）を Sober と Go の双子で、コンパイラ自身（stage2 の自己 build / check）と一緒に測る。
#   scripts/bench.sh [--quick | --heavy] [-n 回数] [-o 結果の TSV] [--cpu K | --no-pin] [--load-max L] [--wait-quiet]
# 騒音の対策（掃除便 D）: 題材の双子は同じ固定コアで走らせる（taskset -c — 既定は最後のコア・--cpu で選ぶ・--no-pin で外す。マイグレーションと
# キャッシュの引っ越しの揺れを削る）。各対の前に loadavg（1 分）を見て、上限（--load-max — 既定 = コア数の半分）を超えていたら警告する
# （--wait-quiet なら下がるまで最大 10 分待つ）。WSL2 では isolcpus / governor は届かない — 根本解は計装の決定的プロファイル（sober prof 第二便）。
# 運用の規律: bench と gates を同時に回さない
# 規律（自己適用の CPU は時間帯で ±50% 動く）: 比べるのは同じ走りの中の数字だけ。題材は 1 周ごとに Sober → Go の交互で回し、回数の中央値を出す。
# 各行に loadavg（1 分）を添える — 負荷の高い時間帯の数字はそれと分かるように。基準値（docs/bench.md）はこのスクリプトの出力をそのまま写す。
# 規模: 既定 = 1BRC 10M 行・binary-trees 18・fannkuch 11・fasta 2.5M / --quick = 1M・16・10・250k / --heavy = 100M・21・12・25M（1BRC 100M の入力は 1.4 GB・
# fasta 25M は benchmarks game の公式の規模）。reverse-complement と k-nucleotide の入力は同じ規模の fasta の出力（Go の双子で作る）。
# float の種目（5.8 第二便）: n-body / spectral-norm / mandelbrot = 既定 5M / 2000 / 4000・--quick 500k / 500 / 1000・--heavy 50M / 5500 / 16000（公式の規模）。
# 入力は out/bench/ に決定的に作る（bench/1brc/gen — 一度作れば使い回す）。出力の一致（Sober ≡ Go）も毎回確かめる
set -uo pipefail
# map のハッシュの種を固定（既定は乱数 — 探査の長さが揺れて命令・cycles が揺れる。出力は種に依らない）
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
ROOT=$PWD
N=3
mode=default
res=""
CPU=$(( $(nproc) - 1 ))
LMAX=$(( $(nproc) / 2 ))
WAITQ=0
while [ $# -gt 0 ]; do
    case "$1" in
        --quick) mode=quick ;;
        --heavy) mode=heavy ;;
        -n) N=$2; shift ;;
        -o) res=$2; shift ;;
        --cpu) CPU=$2; shift ;;
        --no-pin) CPU=none ;;
        --load-max) LMAX=$2; shift ;;
        --wait-quiet) WAITQ=1 ;;
        *) echo "bench: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
case $mode in
    quick) ROWS=1000000; BT=16; FK=10; FA=250000; NB=500000; SN=500; MB=1000; JA=10000; RT=50000; LA=50000 ;;
    heavy) ROWS=100000000; BT=21; FK=12; FA=25000000; NB=50000000; SN=5500; MB=16000; JA=1000000; RT=5000000; LA=5000000 ;;
    *) ROWS=10000000; BT=18; FK=11; FA=2500000; NB=5000000; SN=2000; MB=4000; JA=100000; RT=500000; LA=500000 ;;
esac
B=$ROOT/out/bench
mkdir -p "$B"
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
[ -n "$res" ] || res=$B/results-$mode-$(date +%Y%m%d-%H%M%S).tsv
# 出力先は絶対パスに（スクリプトの中の cd を跨ぐと相対が解決できない）・置き場のディレクトリは作る
mkdir -p "$(dirname "$res")" && res=$(realpath -m "$res")
PIN=()
[ "$CPU" = none ] || PIN=(taskset -c "$CPU")
: > "$res"

# meas <名前> <コマンド…>: 1 回走らせて `名前 wall user rss_kb load` を結果に足す（標準出力は $W/out に捨て置き）
meas() {
    local name=$1; shift
    local ld
    ld=$(cut -d' ' -f1 /proc/loadavg)
    /usr/bin/time -f "%e %U %M" -o "$W/t" "$@" > "$W/out" 2> "$W/err" || { echo "bench: FAIL $name: $*" >&2; cat "$W/err" >&2; exit 1; }
    echo "$name $(cat "$W/t") $ld" >> "$res"
}

# ── 準備: 入力・Go の双子・Sober の build（build の時間と RSS も測る — Go は冷〔空の GOCACHE — runtime / std から〕と温の 2 列）──
echo "bench: mode=$mode N=$N (1BRC ${ROWS} rows, binary-trees ${BT}, fannkuch ${FK}, fasta ${FA}, n-body ${NB}, spectral-norm ${SN}, mandelbrot ${MB}, jsonapi ${JA}, routing ${RT}, logagg ${LA}) → $res" >&2
IN=$B/measurements-$ROWS.txt
if [ ! -s "$IN" ]; then
    echo "bench: generating $IN …" >&2
    (cd bench && go run ./1brc/gen "$ROWS" "$IN.tmp") && mv "$IN.tmp" "$IN" || exit 1
fi
# Web コア（jsonapi — NDJSON の注文のリクエスト・bench/jsonapi/gen）
JAIN=$B/jsonapi-$JA.ndjson
if [ ! -s "$JAIN" ]; then
    echo "bench: generating $JAIN …" >&2
    (cd bench && go run ./jsonapi/gen "$JA" "$JAIN.tmp") && mv "$JAIN.tmp" "$JAIN" || exit 1
fi
RTIN=$B/routing-$RT.txt
if [ ! -s "$RTIN" ]; then
    echo "bench: generating $RTIN …" >&2
    (cd bench && go run ./routing/gen "$RT" "$RTIN.tmp") && mv "$RTIN.tmp" "$RTIN" || exit 1
fi
LAIN=$B/logagg-$LA.txt
if [ ! -s "$LAIN" ]; then
    echo "bench: generating $LAIN …" >&2
    (cd bench && go run ./logagg/gen "$LA" "$LAIN.tmp") && mv "$LAIN.tmp" "$LAIN" || exit 1
fi
FIN=$B/fasta-$FA.txt
if [ ! -s "$FIN" ]; then
    echo "bench: generating $FIN …" >&2
    (cd bench && go run ./fasta/go "$FA" > "$FIN.tmp") && mv "$FIN.tmp" "$FIN" || exit 1
fi
./bin/sober build bench/1brc/main.sober -o "$W/warm" > /dev/null || exit 1   # stage2 を温める（作り直しを測らない）
for i in $(seq 1 "$N"); do
    for p in 1brc binarytrees fannkuch fasta revcomp knucleotide nbody spectralnorm mandelbrot jsonapi routing logagg; do
        meas "build/sober/$p" ./bin/sober build "bench/$p/main.sober" -o "$B/$p-sober"
        rm -rf "$W/gocache"
        meas "build/go-cold/$p" env GOCACHE="$W/gocache" sh -c "cd bench && go build -o '$B/$p-go' ./$p/go"
        # 温 = 同じ GOCACHE でもう一度（Go の runtime / std は当たり・main の package とリンクは払う — Sober の L0 + 置き場に近い条件）
        meas "build/go-warm/$p" env GOCACHE="$W/gocache" sh -c "cd bench && go build -o '$W/$p-go2' ./$p/go"
    done
done

# ── 公式の期待出力（benchmarks game の n = 1000 — bench/<題材>/expect-1000.txt。fasta の出力が他 2 本の入力）──
"$B/fasta-sober" 1000 > "$W/fa1000" && cmp -s "$W/fa1000" bench/fasta/expect-1000.txt || { echo "bench: FAIL fasta: official output" >&2; exit 1; }
for p in revcomp knucleotide; do
    "$B/$p-sober" "$W/fa1000" | cmp -s - "bench/$p/expect-1000.txt" || { echo "bench: FAIL $p: official output" >&2; exit 1; }
done
# float の種目（5.8 第二便）: n-body 1000・spectral-norm 100・mandelbrot 200 の公式の期待出力
"$B/nbody-sober" 1000 | cmp -s - bench/nbody/expect-1000.txt || { echo "bench: FAIL nbody: official output" >&2; exit 1; }
"$B/spectralnorm-sober" 100 | cmp -s - bench/spectralnorm/expect-100.txt || { echo "bench: FAIL spectralnorm: official output" >&2; exit 1; }
"$B/mandelbrot-sober" 200 | cmp -s - bench/mandelbrot/expect-200.pbm || { echo "bench: FAIL mandelbrot: official output" >&2; exit 1; }

# ── 題材: 1 周ごとに Sober → Go の交互 ──
# quiet: loadavg が上限を超えていれば警告（--wait-quiet なら 10 秒おきに見て最大 10 分待つ）
quiet() {
    local ld t=0
    ld=$(cut -d' ' -f1 /proc/loadavg)
    if awk -v l="$ld" -v m="$LMAX" 'BEGIN { exit !(l > m) }'; then
        if [ "$WAITQ" = 1 ]; then
            while [ $t -lt 60 ] && awk -v l="$(cut -d' ' -f1 /proc/loadavg)" -v m="$LMAX" 'BEGIN { exit !(l > m) }'; do sleep 10; t=$((t + 1)); done
        fi
        ld=$(cut -d' ' -f1 /proc/loadavg)
        awk -v l="$ld" -v m="$LMAX" 'BEGIN { exit !(l > m) }' && echo "bench: warning: loadavg $ld > $LMAX before $1 (numbers of this pair are noisy)" >&2
    fi
    return 0
}
run() { # run <題材> <引数>
    local p=$1 a=$2
    quiet "$p"
    # 逐次の表はワーカー 1（std の内側の並列 — utf8.Check の区間割り等 — を逐次の列に混ぜない。並列は bench/par/ の W 軸）
    meas "run/sober/$p" env SOBER_WORKERS=1 "${PIN[@]}" "$B/$p-sober" "$a"
    cp "$W/out" "$W/s.out"
    meas "run/go/$p" "${PIN[@]}" "$B/$p-go" "$a"
    cmp -s "$W/s.out" "$W/out" || { echo "bench: FAIL $p: Sober and Go outputs differ" >&2; exit 1; }
}
for i in $(seq 1 "$N"); do
    run 1brc "$IN"
    run binarytrees "$BT"
    run fannkuch "$FK"
    run fasta "$FA"
    run revcomp "$FIN"
    run knucleotide "$FIN"
    run nbody "$NB"
    run spectralnorm "$SN"
    run mandelbrot "$MB"
    run jsonapi "$JAIN"
    run routing "$RTIN"
    run logagg "$LAIN"
done

# ── コンパイラ自身: stage2 で compiler/app を build（--passes の ELF）/ check（一括）/ check --split（冷 = 空の置き場・温）──
S2=$ROOT/out/stage2/sober2
# -par の物差し: 物理 8 コア（SMT の片割れだけ — selfw.sh と同じ選び方）
CPUS8=$(lscpu -p=CPU,CORE | grep -v '^#' | sort -t, -k2,2n -k1,1n | awk -F, '!seen[$2]++ { print $1 }' | tail -n 8 | paste -sd, -)
T=$W/tree
mkdir -p "$T"
cp -r src/compiler/. "$T/"
cp -r src/std "$T/std"
for i in $(seq 1 "$N"); do
    # self/build・self/check はワーカー 1（ラチェットの物差し — stages / selfpar と同じ）・-par は W8 + 物理 8 コアに固定
    # （selfw.sh と同じ物差し — 機械のコア数に依らない値にする。既定ワーカー数〔この機は 24〕だと束の子のヒープで RSS が機械依存に）
    (cd "$T" && meas "self/build" env SOBER_WORKERS=1 "$S2" build app/main.sober --emit=elf --passes -o "$W/self.elf") || exit 1
    (cd "$T" && meas "self/build-par" env SOBER_WORKERS=8 taskset -c "$CPUS8" "$S2" build app/main.sober --emit=elf --passes -o "$W/self.elf") || exit 1
    (cd "$T" && meas "self/check" env SOBER_WORKERS=1 "$S2" check app/main.sober) || exit 1
    (cd "$T" && meas "self/check-par" env SOBER_WORKERS=8 taskset -c "$CPUS8" "$S2" check app/main.sober) || exit 1
    rm -rf "$W/cache"
    (cd "$T" && meas "self/check-split-cold" env SOBER_CACHE="$W/cache" "$S2" check app/main.sober --split) || exit 1
    (cd "$T" && meas "self/check-split-warm" env SOBER_CACHE="$W/cache" "$S2" check app/main.sober --split) || exit 1
done
# 自己 build の命令数（instructions:u — 決定的なので 1 回。副ラチェット: wall は時間帯で揺れるので照合は命令数で）
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
INST=""
if command -v "$PERF" > /dev/null 2>&1; then
    (cd "$T" && SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u -o "$W/inst" "$S2" build app/main.sober --emit=elf --passes -o "$W/self.elf" > /dev/null) || exit 1
    INST=$(awk -F, '/instructions/ { printf "%.3f", $1 / 1e9 }' "$W/inst")
    echo "bench: self/build instructions:u = ${INST} G" >&2
    echo "self/build-inst $INST" >> "$res.inst"
fi

# 自己 check の核の節の数（check --expansion-report の 1 行目 — 決定的。mut 引数の関数の呼び出し点展開の掛け算を等式で見る副ラチェット — report-510 / 511）
NODES=$(cd "$T" && SOBER_WORKERS=1 "$S2" check app/main.sober --expansion-report | awk '$1 == "core" && $2 == "nodes" { print $3 }')
echo "bench: self/check core nodes = ${NODES}" >&2

# ── 中央値の表（wall / user は秒・RSS は MB）──
awk '
{ k = $1; n[k]++; w[k, n[k]] = $2; u[k, n[k]] = $3; m[k, n[k]] = $4; l[k, n[k]] = $5; if (!(k in seen)) { seen[k] = 1; order[++K] = k } }
function med(a, k, c,   i, j, t, v) { for (i = 1; i <= c; i++) v[i] = a[k, i]; for (i = 2; i <= c; i++) { t = v[i]; for (j = i - 1; j >= 1 && v[j] > t; j--) v[j + 1] = v[j]; v[j + 1] = t } return v[int((c + 1) / 2)] }
END {
    printf "| 項目 | wall s | user s | peak RSS MB | loadavg |\n|---|---|---|---|---|\n"
    for (i = 1; i <= K; i++) { k = order[i]; c = n[k]; printf "| %s | %.2f | %.2f | %.0f | %s |\n", k, med(w, k, c), med(u, k, c), med(m, k, c) / 1024, med(l, k, c) }
}' "$res"
# ── 題材の Sober / Go の比（wall と peak RSS の中央値 — RSS は速度と同格の一級メトリクス: RSS 回収便 2026-10-05）──
awk '
{ k = $1; n[k]++; w[k, n[k]] = $2; m[k, n[k]] = $4 }
function med(a, k, c,   i, j, t, v) { for (i = 1; i <= c; i++) v[i] = a[k, i]; for (i = 2; i <= c; i++) { t = v[i]; for (j = i - 1; j >= 1 && v[j] > t; j--) v[j + 1] = v[j]; v[j + 1] = t } return v[int((c + 1) / 2)] }
END {
    printf "\n| 題材 | wall Sober / Go | peak RSS MB Sober / Go | RSS 比 |\n|---|---|---|---|\n"
    np = split("1brc binarytrees fannkuch fasta revcomp knucleotide nbody spectralnorm mandelbrot jsonapi routing logagg", ps, " ")
    for (i = 1; i <= np; i++) {
        s = "run/sober/" ps[i]; g = "run/go/" ps[i]
        if (!(s in n) || !(g in n)) continue
        ws = med(w, s, n[s]); wg = med(w, g, n[g]); ms = med(m, s, n[s]) / 1024; mg = med(m, g, n[g]) / 1024
        printf "| %s | %.2f / %.2f = %.2fx | %.0f / %.0f | %.2fx |\n", ps[i], ws, wg, (wg > 0 ? ws / wg : 0), ms, mg, (mg > 0 ? ms / mg : 0)
    }
}' "$res"
echo "bench: raw results in $res" >&2

# ── ラチェット（bench/ratchet.txt — 「項目 欄 上限 [ref]」の行。欄 = inst〔G 命令 — 決定的な等式で鳴る主の照合〕/ nodes〔核の節の数 — 決定的〕/ rss〔MB〕/ wall〔秒〕。
# 中央値が上限を超えたら鳴る。4 つ目に ref を書いた行は参考値（記録だけ — 照合しない）。上げるのは裁定つきで ──
rfail=0
while read -r item col lim ref; do
    case "$item" in ''|'#'*) continue ;; esac
    # size（stage3 の ELF の大きさ）は scripts/stages.sh が照合する
    [ "$col" = size ] && continue
    if [ "$col" = nodes ]; then
        v=$NODES
    elif [ "$col" = inst ]; then
        v=$INST
        if [ -z "$v" ]; then
            echo "bench: RATCHET FAIL $item inst — perf が無い（環境変数 PERF で perf の実行ファイルを指す）" >&2; rfail=1; continue
        fi
    else
        v=$(awk -v k="$item" -v c="$col" '$1 == k { n++; x[n] = (c == "rss" ? $4 / 1024 : $2) }
            END { for (i = 2; i <= n; i++) { t = x[i]; for (j = i - 1; j >= 1 && x[j] > t; j--) x[j + 1] = x[j]; x[j + 1] = t } if (n) print x[int((n + 1) / 2)] }' "$res")
    fi
    [ -z "$v" ] && continue
    if [ "$ref" = ref ]; then
        echo "bench: ratchet ref $item $col = $v（参考値 $lim — 照合しない）" >&2
    elif awk -v v="$v" -v l="$lim" 'BEGIN { exit !(v > l) }'; then
        echo "bench: RATCHET FAIL $item $col = $v > $lim" >&2; rfail=1
    else
        echo "bench: ratchet ok $item $col = $v ≤ $lim" >&2
    fi
done < bench/ratchet.txt
exit $rfail
