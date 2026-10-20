#!/usr/bin/env bash
# iouring（IO 便 段 0 — src/compiler/lower/uring.sober・.pair/io-design-draft.md 2.1 / 2.2 節）: M:N の rt のワーカーごとの io_uring の probe と ring。
# examples/collatz_par（std/task を使う）を SOBER_IO ∈ {0〔自動〕, 1〔今の経路に固定〕, 2〔setup が -ENOSYS を返した形の模造 — seccomp で塞がれた環境の再現〕}
# × ワーカー {1, 2, 8} で走らせ、
#   ① 観測（stdout・終了コード）がワーカー 1・SOBER_IO 無しの黄金と同じ（ring の有無で振る舞いが変わらない）
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
# 段 1（report-579）: examples/io_par（task の中の ReadFile / WriteFile — ring があれば rt.uio が SQE を積んで待つ）を
# SOBER_IO ∈ {自動, 1, 2} × W ∈ {1, 2, 8} で走らせ、観測が黄金（examples/io_par.out・終了コード 0）と同じ。続けて shard を 1 つ消した木で
# 負の errno の道（NotFound のラベル — 終了コード 1）を同じ 9 通りで。cwd は作業域（testdata/io_par の写しと out/ — obs の gate が同じ例を
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
# read_fd の ring の道（report-580・report-590 で ReadStdin の形へ）: examples/io_par_stdin（標準入力を task の中で io.ReadStdin が IO_BUF ずつ読む）を同じ 9 通りで
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
# 段 2 (c)（report-608）: io.Chunks / io.Lines の task の読み（ring があればワーカーのアリーナのスロットへ READ_FIXED・先読み 1 本）と、読みの途中で死ぬ
# task の後始末（rt.chunk_drain — 先読み中の読みの完了を待ってスロットを返す）・io.ChunksAt の区間の読み（SQE の off — 位置を動かさない）を同じ 9 通りで。cwd はリポのルート（testdata を読むだけ）
# net 段 4a-2（report-649）・4a-3（report-650 — Serve・reject）: 非ブロックの socket と epoll の待ち（ring の有無 × 協調形 / M:N で同じ出力）— 1 本の task の echo・別の task 同士の往復・
# 期限が待ちを切る両端・相手がもういない（Closed）の 3 経路
# net 段 4c（report-670）: std/http の例（http_arena — 切片をまたぐ要求・パイプライン・誤りの応答の後の読み捨て）も同じ格子
# net 段 4b-0（report-664）: net の例と期限つきの Sleep（timerfd の待ち）は SOBER_NET ∈ {自動〔net の ring — カーネルが受ければ〕, 1〔epoll の道に固定〕} も掛ける
for ex in io_chunks_par io_chunks_par_die io_chunks_at_par net_echo net_multi net_deadline net_deadline_spawn net_orphan net_orphan_dl net_closed net_serve net_reject net_accept_break http_arena task_sleep_deadline; do
    "$S2" build examples/$ex.sober --emit=elf --passes -o "$W/$ex" > "$W/build4.log" 2>&1 || { echo "iouring: FAIL build $ex ($(head -c 200 "$W/build4.log"))"; exit 1; }
    { cat examples/$ex.out; echo "exit=0"; } > "$W/$ex.want"
    case $ex in net_*|http_*|par_sleep_*) nets="0 1" ;; *) nets="0" ;; esac
    for nt in $nets; do
        for io in "" 1 2; do
            for w in 1 2 8; do
                ec=0
                env SOBER_WORKERS=$w ${io:+SOBER_IO=$io} SOBER_NET=$nt timeout 60 "$W/$ex" < /dev/null > "$W/$ex.got" 2> "$W/$ex.err" || ec=$?
                echo "exit=$ec" >> "$W/$ex.got"
                n=$((n + 1))
                if ! cmp -s "$W/$ex.want" "$W/$ex.got"; then
                    echo "iouring: FAIL $ex SOBER_IO=${io:-auto} SOBER_NET=$nt W$w"; diff "$W/$ex.want" "$W/$ex.got" | head -5; fail=1
                fi
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
if [ $fail = 0 ]; then
    echo "iouring: $n runs — observation ≡ W1 for SOBER_IO ∈ {auto(${auto}), 1, 2} × W ∈ {1, 2, 8} (collatz_par + io_par + io_par_stdin + io_chunks_par + io_chunks_par_die + io_chunks_at_par + net_echo + net_multi + net_deadline + net_deadline_spawn + net_orphan + net_orphan_dl + net_closed + net_serve + net_reject + net_accept_break + http_arena + task_sleep_deadline — net / http の例は SOBER_NET ∈ {auto, 1} も), one probe line per worker, net ring selection, fail=0"
else
    echo "iouring: FAIL"
fi
exit $fail
