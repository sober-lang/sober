#!/usr/bin/env bash
# optdiff（性能投資の検査一式）: 最適化なし（`build --no-opt` — IRパスを何も掛けない）と既定（設計整合パス + SROA + mem2reg + GVN …）の
# 実行の観測（標準出力・終了コード・標準エラー〔panic の 1 行 — 位置つき〕）が一致することを見る。消去・変換のパスが観測を変えたら鳴る。
#   scripts/optdiff.sh [--full] [-j N]   受理集合の照合（全数 — 食い違いを全部出す）
#   scripts/optdiff.sh --mut [-j N]      ミューテーションの確認（パスをわざと壊した木で「検査が反応する」ことだけを見る — 小さい母集団・timeout 5 s・最初の食い違いで打ち切って成功）
# 母集団:
#   obsのentry（examples/*.out・testdata/*/app.out）— 期待値を持つので **--no-optの側だけ** ビルドして期待値（.out / .exit / .stderr）と照合する
#     （既定の側は obs と panicmsg が同じ期待値と照合している — 推移で opt ≟ no-opt。同じビルドを二重に払わない）
#   progenの固定シード（size 3 / 4 × 既定20本・--fullは60本 — 旗なしと旗floatの2列）とbenchの6題材（小さい規模 — floatの3種目を含む）— 期待値が無いので両方をビルドして突き合わせる
#     （参照の側は --no-opt --backend=copy — コピーのバックエンド。既定の側の最適化のバックエンド〔性能投資M4〜〕も照合に入る）
#   展開のオプション（SOBER_RAW_EXPAND=1の --no-opt — mut引数だけの関数を呼び出し点ごとに展開する旧のrawの形）のobsのentryも期待値と照合する（種類expx — --mut では回さない）:
#     raw の既定は透過の実体関数（report-1278）なので、既定の照合は透過 ↔ 透過。expx が「展開 ≡ 透過」の実行の照合を受け持つ（期待値を介した推移）。
#     scripts/noopt-excluded.listのentry（展開のオプションで肥大してビルドできない — std/cliの例題）はexpxから外す — 照合の検査の限界（展開 ≡ 透過は照合されない）
# 規律: 1件で足りる検証（ミューテーション・負例）と全数が要る検証（受理集合の照合）を同じ形で回さない — --mut は前者の形
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
# stage2の鮮度は最初に1回だけ確認する（以降のbin/soberの呼び出しは飛ばす）
if [ -z "${SOBER_STAGE2_CHECKED:-}" ]; then
    scripts/stage2.sh --quiet > /dev/null || exit 1
    export SOBER_STAGE2_CHECKED=1
fi
W=$(mktemp -d)
# 後始末: 子孫のプロセスを全部止める（--mut の打ち切りで走りかけのビルド・実行を残さない）
killtree() { local c; for c in $(pgrep -P "$1"); do killtree "$c"; kill -9 "$c" 2> /dev/null; done; }
trap 'exec 2> /dev/null; killtree $$; rm -rf "$W"' EXIT
# ジェネレータは最適化なし + コピーのバックエンドでビルドする（パス・バックエンドをわざと壊した木〔--mut〕でジェネレータそのものが壊れないように）
"$SOBER" build fuzz/progen/main.sober --no-opt --backend=copy -o "$W/progen" > /dev/null || { echo "optdiff: FAIL build progen"; exit 1; }
mkdir -p "$W/src" "$W/r"
# 列: 「種類 名前 ソース 引数…」（種類 = exp〔期待値と照合〕/ pair〔両方をビルドして突き合わせ〕）
list=()
if [ "$MUT" = 1 ]; then
    # 代表: 集約（slice / map / struct）・ループ・panic・error を突く例（hdr_mut2 = hdr の自分のヘッダの書き込み — 他の例は素通りした・
    # callconv_cold = 冷たい呼び出しの退避 — report-463・opt_hloop = mut slice の仮引数へループでappend — hloop / rlim・opt_cpfwd = コピーと使い道の間の書き換え — cpfwd・opt_bce_const = 小さい定数添字の後の大きい定数添字が範囲外 — bce ⑤・opt_bver = 長さがちょうど最大の定数添字 — 版分けの入口の判定・opt_slp = nbodyの形のまとめ — SLPのレーン・結合・opt_count = 等値の数え上げ — 畳む間隔・重なるK・opt_spec = 定数引数の特化 — 鍵の位置・定数の仮引数の位置・opt_spec_panic = 特化した複製の中のpanicの点・task_scope_try = scopeの本体の `?` — 戻りの文脈の出口と合流・copyloop_for / copyloop_for_oob = コピーのforの一括化 — 形の判定・区間の範囲の検査・copyloop_writer / copyloop_writer_oob = Writerへのコピー — 枠の空き・フィールドの経路の (B)・copyloop_fill / copyloop_fill_edge = 定数の詰め — (C) / (Z) の形・空と逆向きの区間・Rangeの評価の順・iter_region_inner / iter_region_outer_assign = 反復のregionのenterの残し方 — llightの本体の範囲と外の深度へのコピー〔観測はiterregion.shの形とRSS〕・fnval_err = 関数型の結果のerror? と η 展開 — クロージャの `?` の合流・寄せたT? の包み・sret_defer_mut / sret_defer_mut_fnval = 受け皿を書いた後にdeferがmutの実引数を書く — slotcolorの受け皿とmut仮引数の干渉〔直 / 間接〕）
    for n in opt_cse opt_bce opt_rlight_depth opt_divpow2 opt_vec_scan opt_vec_scan_panic map_key_slice map_index slice panic_slice errparse panic_label catch arith_edge bytes_packed for_stmt hdr_mut2 opt_promote opt_promote_panic opt_unroll opt_unroll_panic utf8_std utf8_simd map_update map_keyreloc callconv_cold opt_hloop opt_cpfwd opt_bce_const opt_bver opt_slp opt_count opt_spec opt_spec_panic task_scope_try copyloop_for copyloop_for_oob copyloop_writer copyloop_writer_oob copyloop_fill copyloop_fill_edge iter_region_inner iter_region_outer_assign fnval_err sret_defer_mut sret_defer_mut_fnval; do
        [ -f "examples/$n.out" ] && list+=("exp ex_$n examples/$n.sober")
    done
else
    for f in examples/*.out; do n=$(basename "$f" .out); list+=("exp ex_$n examples/$n.sober"); done
    for f in testdata/*/app.out; do d=${f%/app.out}; list+=("exp td_$(basename "$d") $d/app"); done
    # 展開 ≡ 透過（expx）: 同じobsのentryを展開のオプションで（scripts/noopt-excluded.listのentryを除く — 理由はリストの中）
    excl=$(sed 's/#.*//; s/^ *//; s/ *$//' scripts/noopt-excluded.list | grep -v '^$') || true
    for f in examples/*.out; do n=$(basename "$f" .out); grep -qxF -e "examples/$n.sober" <<< "$excl" || list+=("expx xex_$n examples/$n.sober"); done
    for f in testdata/*/app.out; do d=${f%/app.out}; grep -qxF -e "$d/app" <<< "$excl" || list+=("expx xtd_$(basename "$d") $d/app"); done
fi
list+=("pair bench_fannkuch bench/fannkuch/main.sober 8" "pair bench_binarytrees bench/binarytrees/main.sober 10" "pair bench_1brc bench/1brc/main.sober testdata/bench1brc.txt")
# floatの3題材（小さい規模 — xmmの割り当て・SLPのまとめ・比較の融合を突く）
list+=("pair bench_nbody bench/nbody/main.sober 1000" "pair bench_spectralnorm bench/spectralnorm/main.sober 100" "pair bench_mandelbrot bench/mandelbrot/main.sober 200")
for z in 3 4; do
    for s in $(seq 1 "$SEEDS"); do
        timeout 10 "$W/progen" "$s" "$z" > "$W/src/p${s}_$z.sober" 2> /dev/null && list+=("pair pg_${s}_$z $W/src/p${s}_$z.sober")
        # floatの式を混ぜた同じシード（progenの旗float — 旗なしの列は変えない）
        timeout 10 "$W/progen" "$s" "$z" float > "$W/src/pf${s}_$z.sober" 2> /dev/null && list+=("pair pgf_${s}_$z $W/src/pf${s}_$z.sober")
    done
done
run() { # run <実行ファイル> <出力の前置き> <引数…> → 前置き.o / .e / .c（標準入力 = $RUNIN〔例の .in〕か /dev/null）
    # timeoutはKILL（壊した最適化の暴走はTERMを受けないことがある — 深度の検査を外したミュータントM9-cで外側ごと止まった）
    local x=$1 o=$2
    shift 2
    timeout -s KILL "$TO" "$x" "$@" > "$o.o" 2> "$o.e" < "${RUNIN:-/dev/null}"
    echo $? > "$o.c"
}
one() { # 結果は $W/r/<名前>（空 = 一致・.skip = 両方とも建たない）
    local kind=$1 n=$2 src=$3
    shift 3
    if [ "$kind" = exp ] || [ "$kind" = expx ]; then
        local exp=${src%.sober}
        # 通常は最適化なしの側（既定の側はobs / panicmsgが見る）。--mutは壊した最適化を見るので既定の側。expx = 展開のオプションの最適化なし
        local fl=--no-opt ex=0
        [ "$MUT" = 1 ] && fl=
        [ "$kind" = expx ] && ex=1
        if ! SOBER_RAW_EXPAND=$ex timeout "$BTO" "$SOBER" build "$src" $fl -o "$W/$n.raw" > /dev/null 2>&1; then echo "BUILD FAIL $n" > "$W/r/$n"; return; fi
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
    # 参照の側 = 最適化なし + コピーのバックエンド（--backend=copy — 凍結したコピー。IRパスとバックエンドの最適化〔M4〜〕を一度に照合する）
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
echo "optdiff: $ran programs no-opt ≟ opt (obs entries vs expectations — transparent and expanded ($(ls "$W"/r | grep -c '^x')), the rest pairwise; skipped $skipped that neither build), fail=$fail"
[ "$fail" = 0 ]
