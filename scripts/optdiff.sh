#!/usr/bin/env bash
# optdiff（性能投資の網）: 最適化なし（`build --no-opt` — IR パスを何も掛けない）と既定（設計整合パス + SROA + mem2reg + GVN …）の
# 実行の観測（標準出力・終了コード・標準エラー〔panic の 1 行 — 位置つき〕）が一致することを見る。消去・変換のパスが観測を変えたら鳴る。
#   scripts/optdiff.sh [--full] [-j N]   受理集合の照合（全数 — 食い違いを全部出す）
#   scripts/optdiff.sh --mut [-j N]      変異の確認（パスをわざと壊した木で「網が鳴る」ことだけを見る — 小さい母集団・timeout 5 s・最初の食い違いで打ち切って成功）
# 母集団:
#   obs の entry（examples/*.out・testdata/*/app.out）— 期待値を持つので **--no-opt の側だけ** 建てて期待値（.out / .exit / .stderr）と照合する
#     （既定の側は obs と panicmsg が同じ期待値と照合している — 推移で opt ≟ no-opt。同じビルドを二重に払わない）
#   progen の固定シード（size 3 / 4 × 既定 20 本・--full は 60 本）と bench の 3 題材（小さい規模）— 期待値が無いので両方を建てて突き合わせる
#     （参照の側は --no-opt --backend=copy — 写しのバックエンド。既定の側の最適化のバックエンド〔性能投資 M4〜〕も照合に入る）
# 規律: 1 件で足りる検証（変異・負例）と全数が要る検証（受理集合の照合）を同じ形で回さない — --mut は前者の形
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
SEEDS=20
MUT=0
BTO=120
J=${JOBS:-$(nproc)}
TO=60
while [ $# -gt 0 ]; do
    case "$1" in
        --full) SEEDS=60 ;;
        --mut) MUT=1; SEEDS=4; TO=5; BTO=20 ;;
        -j) J=$2; shift ;;
        *) echo "optdiff: unknown argument $1" >&2; exit 2 ;;
    esac
    shift
done
# stage2 の鮮度は最初に 1 回だけ確かめる（以降の bin/sober の呼び出しは飛ばす）
if [ -z "${SOBER_STAGE2_CHECKED:-}" ]; then
    scripts/stage2.sh --quiet > /dev/null || exit 1
    export SOBER_STAGE2_CHECKED=1
fi
W=$(mktemp -d)
# 後始末: 子孫のプロセスを全部止める（--mut の打ち切りで走りかけのビルド・実行を残さない）
killtree() { local c; for c in $(pgrep -P "$1"); do killtree "$c"; kill -9 "$c" 2> /dev/null; done; }
trap 'exec 2> /dev/null; killtree $$; rm -rf "$W"' EXIT
# 生成器は最適化なし + 写しのバックエンドで建てる（パス・バックエンドをわざと壊した木〔--mut〕で生成器そのものが壊れないように）
"$SOBER" build fuzz/progen/main.sober --no-opt --backend=copy -o "$W/progen" > /dev/null || { echo "optdiff: FAIL build progen"; exit 1; }
mkdir -p "$W/src" "$W/r"
# 列: 「種類 名前 ソース 引数…」（種類 = exp〔期待値と照合〕/ pair〔両方を建てて突き合わせ〕）
list=()
if [ "$MUT" = 1 ]; then
    # 代表: 集約（slice / map / struct）・ループ・panic・error を突く例（hdr_mut2 = hdr の自分のヘッダの書き込み — 他の例は素通りした・
    # callconv_cold = 冷たい呼び出しの退避 — report-463）
    for n in opt_cse opt_bce opt_rlight_depth opt_divpow2 opt_vec_scan opt_vec_scan_panic map_key_slice map_index slice panic_slice errparse panic_label catch arith_edge bytes_packed for_stmt hdr_mut2 opt_promote opt_promote_panic opt_unroll opt_unroll_panic utf8_std utf8_simd map_update map_keyreloc callconv_cold; do
        [ -f "examples/$n.out" ] && list+=("exp ex_$n examples/$n.sober")
    done
else
    for f in examples/*.out; do n=$(basename "$f" .out); list+=("exp ex_$n examples/$n.sober"); done
    for f in testdata/*/app.out; do d=${f%/app.out}; list+=("exp td_$(basename "$d") $d/app"); done
fi
list+=("pair bench_fannkuch bench/fannkuch/main.sober 8" "pair bench_binarytrees bench/binarytrees/main.sober 10" "pair bench_1brc bench/1brc/main.sober testdata/bench1brc.txt")
for z in 3 4; do
    for s in $(seq 1 "$SEEDS"); do
        timeout 10 "$W/progen" "$s" "$z" > "$W/src/p${s}_$z.sober" 2> /dev/null && list+=("pair pg_${s}_$z $W/src/p${s}_$z.sober")
    done
done
run() { # run <実行ファイル> <出力の前置き> <引数…> → 前置き.o / .e / .c（標準入力 = $RUNIN〔例の .in〕か /dev/null）
    # timeout は KILL（壊した最適化の暴走は TERM を受けないことがある — 深度の検査を外した変異 M9-c で外側ごと止まった）
    local x=$1 o=$2
    shift 2
    timeout -s KILL "$TO" "$x" "$@" > "$o.o" 2> "$o.e" < "${RUNIN:-/dev/null}"
    echo $? > "$o.c"
}
one() { # 結果は $W/r/<名前>（空 = 一致・.skip = 両方とも建たない）
    local kind=$1 n=$2 src=$3
    shift 3
    if [ "$kind" = exp ]; then
        local exp=${src%.sober}
        # 通常は最適化なしの側（既定の側は obs / panicmsg が見る）。--mut は壊した最適化を見るので既定の側
        local fl=--no-opt
        [ "$MUT" = 1 ] && fl=
        if ! timeout "$BTO" "$SOBER" build "$src" $fl -o "$W/$n.raw" > /dev/null 2>&1; then echo "BUILD FAIL $n" > "$W/r/$n"; return; fi
        local RUNIN=/dev/null
        [ -f "$exp.in" ] && RUNIN=$exp.in
        run "$W/$n.raw" "$W/$n.1" "$@"
        local want=0
        [ -f "$exp.exit" ] && want=$(tr -d ' \n' < "$exp.exit")
        {
            cmp -s "$W/$n.1.o" "$exp.out" || echo "STDOUT DIFF $n (vs .out)"
            [ "$(cat "$W/$n.1.c")" = "$want" ] || echo "EXIT DIFF $n: $(cat "$W/$n.1.c") / want $want"
            if [ -f "$exp.stderr" ]; then cmp -s "$W/$n.1.e" "$exp.stderr" || echo "STDERR DIFF $n (vs .stderr)"; fi
        } > "$W/r/$n"
        rm -f "$W/$n".*
        return
    fi
    local b1=0 b2=0
    # 参照の側 = 最適化なし + 写しのバックエンド（--backend=copy — 凍結した写し。IR パスとバックエンドの最適化〔M4〜〕を一度に照合する）
    timeout "$BTO" "$SOBER" build "$src" --no-opt --backend=copy -o "$W/$n.raw" > /dev/null 2>&1 || b1=1
    timeout "$BTO" "$SOBER" build "$src" -o "$W/$n.opt" > /dev/null 2>&1 || b2=1
    if [ "$b1$b2" = 11 ]; then : > "$W/r/$n.skip"; return; fi
    if [ "$b1" != "$b2" ]; then echo "BUILD DIFF $n" > "$W/r/$n"; return; fi
    run "$W/$n.raw" "$W/$n.1" "$@"
    run "$W/$n.opt" "$W/$n.2" "$@"
    {
        cmp -s "$W/$n.1.o" "$W/$n.2.o" || echo "STDOUT DIFF $n"
        cmp -s "$W/$n.1.e" "$W/$n.2.e" || echo "STDERR DIFF $n"
        [ "$(cat "$W/$n.1.c")" = "$(cat "$W/$n.2.c")" ] || echo "EXIT DIFF $n: no-opt $(cat "$W/$n.1.c") / opt $(cat "$W/$n.2.c")"
    } > "$W/r/$n"
    rm -f "$W/$n".*
}
caught() { # 食い違いの出た結果があれば最初の 1 行
    for f in "$W"/r/*; do
        case "$f" in *.skip) continue ;; esac
        [ -s "$f" ] && { head -1 "$f"; return 0; }
    done
    return 1
}
for l in "${list[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$J" ]; do wait -n || true; done
    if [ "$MUT" = 1 ] && c=$(caught); then
        echo "optdiff --mut: caught — $c"
        exit 0
    fi
    one $l &
done
if [ "$MUT" = 1 ]; then
    # 走りきるのを待たず、食い違いが出た時点で打ち切る
    while [ "$(jobs -rp | wc -l)" -gt 0 ]; do
        if c=$(caught); then echo "optdiff --mut: caught — $c"; exit 0; fi
        sleep 0.2
    done
    if c=$(caught); then echo "optdiff --mut: caught — $c"; exit 0; fi
    echo "optdiff --mut: NOT caught (${#list[@]} programs)"
    exit 1
fi
wait
fail=0
for f in "$W"/r/*; do
    case "$f" in *.skip) continue ;; esac
    if [ -s "$f" ]; then cat "$f"; fail=1; fi
done
ran=$(ls "$W"/r | grep -vc '\.skip$')
skipped=$(ls "$W"/r | grep -c '\.skip$')
echo "optdiff: $ran programs no-opt ≟ opt (obs entries vs expectations, the rest pairwise; skipped $skipped that neither build), fail=$fail"
[ "$fail" = 0 ]
