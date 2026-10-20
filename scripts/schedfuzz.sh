#!/usr/bin/env bash
# schedfuzz（段 6 P4-1 / P4-4・揉みどころ 6）: scripts/schedfuzz.list の例を建て、既定のスケジュールの観測（stdout・終了コード・
# `#sched` 以外の stderr）を黄金にして、乱択のスケジュール（SOBER_SCHED_SEED = 1..K — rt.sched_pick が列の尽きた後の選択を乱択に・遅延注入の口つき）
# の観測と照合する。ワーカー 1 = 切替点の選択の乱択・ワーカー 2 / 4 / 8 = 本物の並列（M:N）+ 出来事の点の遅延注入（同じ種の口 — mn.sober）。
# 黄金 = ワーカー 1・既定のスケジュールの観測。死ぬ例（黄金の exit ≠ 0）のワーカー 2 以上は exit + 死因の stderr だけ照合する
# （裁定 2026-10-06: 死ぬ実行の stdout の部分出力は M:N では非約束 — language.md 11 節 O1）。
# 2 列目 split の例は「割れて当然」（自己検査の証人 — 網が鳴ることを確かめる。割れなければ失敗 = 器が壊れた）
#   scripts/schedfuzz.sh [K]（既定 8・SCHEDFUZZ_WORKERS で SOBER_WORKERS の列 — 既定 "1 2 4 8"）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
K=${1:-8}
WS=${SCHEDFUZZ_WORKERS:-1 2 4 8}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
obs() {   # obs <bin> <out> [env…]（-k 5 = SIGTERM で落ちない止まり〔終了処理中に pipe の書きで回る変異 6 — report-785〕は 5 秒後に SIGKILL）
    local b=$1 o=$2 ec=0
    shift 2
    env "$@" timeout -k 5 60 "$b" > "$o" 2> "$o.err" || ec=$?
    echo "exit=$ec" >> "$o"
    grep -v '^#sched ' "$o.err" >> "$o"
}
# deathobs <out>: 観測から stdout を外した形（exit + stderr — 死ぬ例の M:N の照合）
deathobs() {
    sed -n '/^exit=/,$p' "$1"
}
# 実行ファイルは建てるたびに別の名前（カーネル 6.18 では M:N の実行の直後に同じパスへ書くと ETXTBSY — report-660）
while read -r e mark; do
    case "$e" in ''|'#'*) continue ;; esac
    n=$((n + 1))
    "$S2" build "$e" --emit=elf -o "$W/bin.$n" > /dev/null 2>&1 || { echo "FAIL: build $e"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin.$n"
    obs "$W/bin.$n" "$W/base" SOBER_WORKERS=1
    deathobs "$W/base" > "$W/base.d"
    dies=0
    grep -qx 'exit=0' "$W/base" || dies=1
    split=0
    for w in $WS; do
        for s in $(seq 1 "$K"); do
            obs "$W/bin.$n" "$W/run" SOBER_SCHED_SEED=$s SOBER_WORKERS=$w
            if [ $dies = 1 ] && [ "$w" != 1 ]; then
                deathobs "$W/run" > "$W/run.d"
                same=0; cmp -s "$W/base.d" "$W/run.d" && same=1
            else
                same=0; cmp -s "$W/base" "$W/run" && same=1
            fi
            if [ $same = 0 ]; then
                split=1
                [ "$mark" = split ] || { echo "FAIL: $e splits (SOBER_WORKERS=$w SOBER_SCHED_SEED=$s — SOBER_SCHED_TRACE=1 で選択の列を取りワーカー 1 で再生)"; diff "$W/base" "$W/run" | head -6; }
            fi
        done
    done
    if [ "$mark" = split ] && [ $split = 0 ]; then
        echo "FAIL: $e should split (self-check witness) but every seed matched — the fuzz net does not move the schedule"
        fail=$((fail + 1))
    elif [ "$mark" != split ] && [ $split = 1 ]; then
        fail=$((fail + 1))
    fi
done < scripts/schedfuzz.list
# 変異の自己検査（段 6 P4-4）: M:N の rt に変異を入れたビルド（--rt-mutant=N）で、網が割れを捕まえること（1 件で足りる —
# 最初の割れで打ち切り）。1 = 未回収の失敗を到着順で選ぶ（正準順の破れ）・2 = 待ち手を素の store で置いて見直さない（起こし損ね → デッドロックの死）・
# 6 = 盗み手が被害者の鍵を取らない（盗み手どうしが同じ子を取る — 子が 2 回走る。Skynet 回収 (a)）・15 = lease の使用中の印を見ない
# （窓の中で譲った task の置き場を同じワーカーの別の窓が共有する — region-domain-pool.md 4d 節の倒れの証人。ワーカー 1 で 2 つの窓が必ず重なる）
for m in "1 examples/task_fail_order.sober" "2 examples/task_join_race.sober" "6 examples/task_steal.sober" "15 examples/lease_yield.sober"; do
    set -- $m
    "$S2" build "$2" --emit=elf -o "$W/bin.m$1" > /dev/null 2>&1 && "$S2" build "$2" --emit=elf --rt-mutant=$1 -o "$W/mut.$1" > /dev/null 2>&1 || { echo "FAIL: build mutant $1 $2"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin.m$1" "$W/mut.$1"
    obs "$W/bin.m$1" "$W/base" SOBER_WORKERS=1
    caught=0
    for w in 1 2 4; do
        for s in $(seq 1 "$K"); do
            obs "$W/mut.$1" "$W/run" SOBER_SCHED_SEED=$s SOBER_WORKERS=$w
            if ! cmp -s "$W/base" "$W/run"; then caught=1; break 2; fi
        done
    done
    if [ $caught = 0 ]; then
        echo "FAIL: mutant $1 ($2) was not caught — the M:N net does not see the broken rt"
        fail=$((fail + 1))
    fi
done
echo "schedfuzz: $n programs × $K seeds × workers {$WS} + 4 mutants, fail=$fail"
[ $fail = 0 ]
