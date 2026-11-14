#!/usr/bin/env bash
# iouring（IOタスクのフェーズ0 — src/compiler/lower/uring.sober）: M:Nのrtのワーカーごとのio_uringのprobeとring。
# examples/collatz_par（std/task を使う）を SOBER_IO ∈ {0〔自動〕, 1〔今の経路に固定〕, 2〔setup が -ENOSYS を返した形の模造 — seccomp で塞がれた環境の再現〕}
# × ワーカー {1, 2, 8} で走らせ、
#   ① 観測（stdout・終了コード）がワーカー1・SOBER_IO無しのゴールデンと同じ（ringの有無で振る舞いが変わらない）
#   ② SOBER_IO_TRACE=1 の `#io worker <k> backend=…` の行がワーカーごとに 1 行（ワーカー 1 は M:N を起こさないので 0 行）:
#      SOBER_IO=1 → `sync probe=0`・SOBER_IO=2 → `sync probe=-38`・自動 → `uring enter=1 nop=0 ud=77`（NOP の往復）。
#      自動で setup が通らない環境（古いカーネル・seccomp）では全ワーカーが `sync probe=<負>` — その旨を表示して ② の自動の照合だけ飛ばす
#   scripts/iouring.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
"$S2" build examples/collatz_par.sober --emit=elf --passes -o "$W/cz" > "$W/build.log" 2>&1 || { echo "iouring: FAIL build ($(head -c 200 "$W/build.log"))"; exit 1; }
run() {   # run <out> [env…]
    local o=$1 ec=0
    shift
    env "$@" timeout 60 "$W/cz" > "$o" 2> "$o.err" || ec=$?
    echo "exit=$ec" >> "$o"
}
run "$W/base" SOBER_WORKERS=1
auto=uring
run "$W/probe" SOBER_WORKERS=2 SOBER_IO_TRACE=1
if grep -q 'backend=sync' "$W/probe.err"; then
    auto=sync
    echo "iouring: note — io_uring_setup がこの環境で通らない（$(head -n 1 "$W/probe.err")）— 自動の行の照合は飛ばす"
fi
n=0
for io in "" 1 2; do
    for w in 1 2 8; do
        run "$W/run" SOBER_WORKERS=$w SOBER_IO_TRACE=1 ${io:+SOBER_IO=$io}
        n=$((n + 1))
        if ! cmp -s "$W/base" "$W/run"; then
            echo "iouring: FAIL observation SOBER_IO=${io:-auto} W$w"; diff "$W/base" "$W/run" | head -5; fail=1
        fi
        lines=$(grep -c '^#io worker' "$W/run.err")
        want=$([ "$w" = 1 ] && echo 0 || echo "$w")
        if [ "$lines" != "$want" ]; then
            echo "iouring: FAIL trace lines SOBER_IO=${io:-auto} W$w: $lines (want $want)"; fail=1
        fi
        [ "$w" = 1 ] && continue
        case "$io" in
            1) pat='backend=sync probe=0$' ;;
            2) pat='backend=sync probe=-38$' ;;
            *) [ "$auto" = sync ] && continue; pat='backend=uring enter=1 nop=0 ud=77$' ;;
        esac
        good=$(grep -c "^#io worker [0-9]* $pat" "$W/run.err")
        if [ "$good" != "$w" ]; then
            echo "iouring: FAIL trace SOBER_IO=${io:-auto} W$w: $good/$w lines match '$pat'"; head -3 "$W/run.err"; fail=1
        fi
        # ワーカーの番号が 0〜w-1 を 1 回ずつ
        ids=$(sed -n 's/^#io worker \([0-9]*\) .*/\1/p' "$W/run.err" | sort -n | paste -sd, -)
        if [ "$ids" != "$(seq -s, 0 $((w - 1)))" ]; then
            echo "iouring: FAIL worker ids SOBER_IO=${io:-auto} W$w: $ids"; fail=1
        fi
    done
done
# フェーズ1（report-579）: examples/io_par（taskの中のReadFile / WriteFile — ringがあればrt.uioがSQEを積んで待つ）を
# SOBER_IO ∈ {自動, 1, 2} × W ∈ {1, 2, 8} で走らせ、観測がゴールデン（examples/io_par.out・終了コード0）と同じ。続けてshardを1つ消した木で
# 負のerrnoのパス（NotFoundのラベル — 終了コード1）を同じ9通りで。cwdは作業域（testdata/io_parのコピーとout/ — obsのgateが同じ例を
# リポのルートで走らせても書き込み先がぶつからない）
"$S2" build examples/io_par.sober --emit=elf --passes -o "$W/iop" > "$W/build2.log" 2>&1 || { echo "iouring: FAIL build io_par ($(head -c 200 "$W/build2.log"))"; exit 1; }
for v in ok miss; do
    mkdir -p "$W/$v/out" "$W/$v/testdata"
    cp -r testdata/io_par "$W/$v/testdata/"
done
rm "$W/miss/testdata/io_par/access-3.log"
{ cat examples/io_par.out; echo "exit=0"; } > "$W/ok.want"
printf 'a log shard is missing\nexit=1\n' > "$W/miss.want"
for v in ok miss; do
    for io in "" 1 2; do
        for w in 1 2 8; do
            ec=0
            (cd "$W/$v" && env SOBER_WORKERS=$w ${io:+SOBER_IO=$io} timeout 60 "$W/iop" < /dev/null > "$W/iop.got" 2> "$W/iop.err") || ec=$?
            echo "exit=$ec" >> "$W/iop.got"
            n=$((n + 1))
            if ! cmp -s "$W/$v.want" "$W/iop.got"; then
                echo "iouring: FAIL io_par ($v) SOBER_IO=${io:-auto} W$w"; diff "$W/$v.want" "$W/iop.got" | head -5; fail=1
            fi
        done
    done
done
# read_fdのringのパス（report-580・report-590でReadStdinの形へ）: examples/io_par_stdin（標準入力をtaskの中でio.ReadStdinがIO_BUFずつ読む）を同じ9通りで
"$S2" build examples/io_par_stdin.sober --emit=elf --passes -o "$W/ips" > "$W/build3.log" 2>&1 || { echo "iouring: FAIL build io_par_stdin ($(head -c 200 "$W/build3.log"))"; exit 1; }
{ cat examples/io_par_stdin.out; echo "exit=0"; } > "$W/ips.want"
for io in "" 1 2; do
    for w in 1 2 8; do
        ec=0
        (cd "$W/ok" && env SOBER_WORKERS=$w ${io:+SOBER_IO=$io} timeout 60 "$W/ips" < "$OLDPWD/examples/io_par_stdin.in" > "$W/ips.got" 2> "$W/ips.err") || ec=$?
        echo "exit=$ec" >> "$W/ips.got"
        n=$((n + 1))
        if ! cmp -s "$W/ips.want" "$W/ips.got"; then
            echo "iouring: FAIL io_par_stdin SOBER_IO=${io:-auto} W$w"; diff "$W/ips.want" "$W/ips.got" | head -5; fail=1
        fi
    done
done
# フェーズ2 (c)（report-608）: io.Chunks / io.Linesのtaskの読み（ringがあればワーカーのアリーナのスロットへREAD_FIXED・先読み1本）と、読みの途中で死ぬ
# task の後始末（rt.chunk_drain — 先読み中の読みの完了を待ってスロットを返す）・io.ChunksAt の区間の読み（SQE の off — 位置を動かさない）を同じ 9 通りで。cwd はリポのルート（testdata を読むだけ）
# netフェーズ4a-2（report-649）・4a-3（report-650 — Serve・reject）: 非ブロックのsocketとepollの待ち（ringの有無 × 協調形 / M:Nで同じ出力）— 1本のtaskのecho・別のtask同士の往復・
# 期限が待ちを切る両端・相手がもういない（Closed）の 3 経路
# netフェーズ4c（report-670）: std/httpの例（http_arena — 切片をまたぐリクエスト・パイプライン・誤りのレスポンスの後の読み捨て）も同じ格子
# netフェーズ4b-0（report-664）: netの例と期限つきのSleep（timerfdの待ち）はSOBER_NET ∈ {自動〔netのring — カーネルが受ければ〕, 1〔epollのパスに固定〕} も掛ける
for ex in io_chunks_par io_chunks_par_die io_chunks_at_par net_echo net_multi net_deadline net_deadline_spawn net_deadline_order net_orphan net_orphan_dl net_closed net_serve net_reject net_region net_region_mix net_accept_break http_arena task_sleep_deadline task_sleep_many; do
    "$S2" build examples/$ex.sober --emit=elf --passes -o "$W/$ex" > "$W/build4.log" 2>&1 || { echo "iouring: FAIL build $ex ($(head -c 200 "$W/build4.log"))"; exit 1; }
    { cat examples/$ex.out; echo "exit=0"; } > "$W/$ex.want"
    case $ex in net_*|http_*|par_sleep_*) nets="0 1" ;; *) nets="0" ;; esac
    # net_region_mix（report-1077）: 子の既定のスロットを4 MiBに縮めて（SOBER_TASK_REGION_MB=4）region: 1 MiBのエリアの組を4深度にする形も — 組の境目をまたぐ
    case $ex in net_region_mix) trs="0 4" ;; *) trs="0" ;; esac
    for tr in $trs; do
    for nt in $nets; do
        for io in "" 1 2; do
            for w in 1 2 8; do
                ec=0
                env SOBER_WORKERS=$w ${io:+SOBER_IO=$io} SOBER_NET=$nt $([ "$tr" != 0 ] && echo SOBER_TASK_REGION_MB=$tr) timeout 60 "$W/$ex" < /dev/null > "$W/$ex.got" 2> "$W/$ex.err" || ec=$?
                echo "exit=$ec" >> "$W/$ex.got"
                n=$((n + 1))
                if ! cmp -s "$W/$ex.want" "$W/$ex.got"; then
                    echo "iouring: FAIL $ex SOBER_IO=${io:-auto} SOBER_NET=$nt W$w${tr/#0/}"; diff "$W/$ex.want" "$W/$ex.got" | head -5; fail=1
                fi
            done
        done
    done
    done
done
# net の ring の選択: net_serve を W2 で走らせ、自動は `backend=uring+net`・SOBER_NET=1 は `backend=uring` がワーカーごとに 1 行（setup が通らない環境では自動の照合を飛ばす）
if [ "$auto" = uring ]; then
    for nt in 0 1; do
        want=$([ "$nt" = 0 ] && echo "backend=uring+net enter=1 nop=0 ud=77" || echo "backend=uring enter=1 nop=0 ud=77")
        env SOBER_WORKERS=2 SOBER_IO_TRACE=1 SOBER_NET=$nt timeout 60 "$W/net_serve" < /dev/null > /dev/null 2> "$W/ns.err"
        got=$(grep -c "^#io worker [01] $want\$" "$W/ns.err")
        n=$((n + 1))
        if [ "$got" != 2 ]; then
            echo "iouring: FAIL net ring selection SOBER_NET=$nt (want 2 lines '$want')"; grep '^#io' "$W/ns.err" | head -3; fail=1
        fi
    done
fi
# 期限のチェーンの検査（自己検査）: ミューテーション50（双方向のチェーンの外しが次の節の前を直し忘れる）はepollのパスのnet_serve（W1）が止まる・
# ミューテーション51（スタックが最早の期限の下界を下げ忘れる — 走査がチェーンを歩かず短い期限が長い期限まで待つ）はnetのringのnet_deadline_order（W2）が止まる
for mc in "50 net_serve 1" "51 net_deadline_order 2"; do
    set -- $mc
    "$S2" build examples/$2.sober --emit=elf --passes --rt-mutant=$1 -o "$W/m$1" > "$W/buildm.log" 2>&1 || { echo "iouring: FAIL build $2 m$1"; exit 1; }
    ec=0
    env SOBER_WORKERS=$3 timeout 10 "$W/m$1" < /dev/null > "$W/m$1.got" 2> /dev/null || ec=$?
    echo "exit=$ec" >> "$W/m$1.got"
    n=$((n + 1))
    if [ "$1" = 51 ] && [ "$auto" != uring ]; then continue; fi
    if cmp -s "$W/$2.want" "$W/m$1.got"; then echo "iouring: FAIL — mutant $1 was not caught by $2 W$3"; fail=1; fi
done
if [ $fail = 0 ]; then
    echo "iouring: $n runs — observation ≡ W1 for SOBER_IO ∈ {auto(${auto}), 1, 2} × W ∈ {1, 2, 8} (collatz_par + io_par + io_par_stdin + io_chunks_par + io_chunks_par_die + io_chunks_at_par + net_echo + net_multi + net_deadline + net_deadline_spawn + net_deadline_order + net_orphan + net_orphan_dl + net_closed + net_serve + net_reject + net_region + net_region_mix〔SOBER_TASK_REGION_MB ∈ {既定, 4} も〕 + net_accept_break + http_arena + task_sleep_deadline + task_sleep_many — net / http の例は SOBER_NET ∈ {auto, 1} も), one probe line per worker, net ring selection, deadline-chain mutants 50/51 caught, fail=0"
else
    echo "iouring: FAIL"
fi
exit $fail
