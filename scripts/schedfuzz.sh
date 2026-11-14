#!/usr/bin/env bash
# schedfuzz（段階6 P4-1 / P4-4・揉みどころ6）: scripts/schedfuzz.listの例をビルドし、既定のスケジュールの観測（stdout・終了コード・
# `#sched` 以外のstderr）をゴールデンにして、乱択のスケジュール（SOBER_SCHED_SEED = 1..K — rt.sched_pickが列の尽きた後の選択を乱択に・遅延注入のオプションつき）
# の観測と照合する。ワーカー1 = 切替点の選択の乱択・ワーカー2 / 4 / 8 = 本物の並列（M:N）+ 出来事の点の遅延注入（同じシードのオプション — mn.sober）。
# ゴールデン = ワーカー1・既定のスケジュールの観測。死ぬ例（ゴールデンのexit ≠ 0）のワーカー2以上はexit + 死因のstderrだけ照合する
# （決定2026-10-06: 死ぬ実行のstdoutの部分出力はM:Nでは非約束 — language.md 11 節O1）。
# 2列目splitの例は「割れて当然」（自己検査の証人 — 検査が反応することを確認する。割れなければ失敗 = 器が壊れた）
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
obs() {   # obs <bin> <out> [env…]（-k 5 = SIGTERMで落ちない止まり〔終了処理中にpipeの書きで回るミュータント6 — report-785〕は5秒後にSIGKILL）
    local b=$1 o=$2 ec=0
    shift 2
    env "$@" timeout -k 5 "${OBS_T:-60}" "$b" > "$o" 2> "$o.err" || ec=$?
    echo "exit=$ec" >> "$o"
    grep -v '^#sched ' "$o.err" >> "$o"
}
# deathobs <out>: 観測から stdout を外した形（exit + stderr — 死ぬ例の M:N の照合）
deathobs() {
    sed -n '/^exit=/,$p' "$1"
}
# 実行ファイルはビルドするたびに別の名前（カーネル6.18ではM:Nの実行の直後に同じパスへ書くとETXTBSY — report-660）
while read -r e mark; do
    case "$e" in ''|'#'*) continue ;; esac
    n=$((n + 1))
    # SCHEDFUZZ_FLAGS = 検査のbuildの追加の引数（--rt-mutant=28 = 走れるスタックの環の容量8 — 溢れのパスごと回す・report-1168）
    "$S2" build "$e" --emit=elf ${SCHEDFUZZ_FLAGS:-} -o "$W/bin.$n" > /dev/null 2>&1 || { echo "FAIL: build $e"; fail=$((fail + 1)); continue; }
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
# ミューテーションの自己検査（段階6 P4-4）: M:Nのrtにミューテーションを入れたビルド（--rt-mutant=N）で、検査が割れを捕まえること（1件で足りる —
# 最初の割れで打ち切り）。1 = 未回収の失敗を到着順で選ぶ（正準順の破れ）・2 = 待ち手を素のstoreで置いて見直さない（ウェイクアップ損ね → デッドロックの死）・
# 6 = 盗み手が被害者の鍵を取らない（盗み手どうしが同じ子を取る — 子が2回走る。Skynet回収 (a)）・15 = leaseの使用中のフラグを見ない
# （予約ページの中で譲ったtaskの格納場所を同じワーカーの別の予約ページが共有する — region-domain-pool.md 4d節の倒れの証人。ワーカー1で2つの予約ページが必ず重なる）・
# domainの待ちの列（domain.sober）: 52 = ウェイクアップした待ち手をPから外さない・53 = スリープし直しが番号の位置でなくPの尾へ・54 = 外さずにウェイクアップ済みのフラグだけ
# （52 / 54は鍵の中のループで止まる — 打ち切り10秒）・77 = 待ったAwaitの状態の読み直しの代入に格納点のコピーを戻す（状態が呼び手のregionへ移り、
# 回収された格納場所を本体の結果とproducerの書きが共有する）
for m in "1 examples/task_fail_order.sober" "2 examples/task_join_race.sober" "6 examples/task_steal.sober" "15 examples/lease_yield.sober" "52 examples/domain_requeue.sober" "53 examples/domain_requeue.sober" "54 examples/domain_requeue.sober" "77 examples/domain_await_result.sober"; do
    set -- $m
    "$S2" build "$2" --emit=elf -o "$W/bin.m$1" > /dev/null 2>&1 && "$S2" build "$2" --emit=elf --rt-mutant=$1 -o "$W/mut.$1" > /dev/null 2>&1 || { echo "FAIL: build mutant $1 $2"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin.m$1" "$W/mut.$1"
    obs "$W/bin.m$1" "$W/base" SOBER_WORKERS=1
    caught=0
    for w in 1 2 4; do
        for s in $(seq 1 "$K"); do
            OBS_T=10 obs "$W/mut.$1" "$W/run" SOBER_SCHED_SEED=$s SOBER_WORKERS=$w
            if ! cmp -s "$W/base" "$W/run"; then caught=1; break 2; fi
        done
    done
    if [ $caught = 0 ]; then
        echo "FAIL: mutant $1 ($2) was not caught — the M:N net does not see the broken rt"
        fail=$((fail + 1))
    fi
done
# domainの状態の格納場所の検査（--rt-mutant=75 — 出る点で書き戻す状態のヘッダのフラグが記録のregionのもの〔0かMAX_DEPTH〕でなければexit 104）:
# 一覧のdomainの例は検査つきでも既定の観測と同じ（偽陽性なし）・76（検査 + ミュータント77）は検査がexit 104で捕まえる
dchk=0
while read -r e mark; do
    case "$e" in examples/domain_*) ;; *) continue ;; esac
    "$S2" build "$e" --emit=elf -o "$W/dc.b" > /dev/null 2>&1 && "$S2" build "$e" --emit=elf --rt-mutant=75 -o "$W/dc.c" > /dev/null 2>&1 || { echo "FAIL: build domain check $e"; fail=$((fail + 1)); continue; }
    chmod +x "$W/dc.b" "$W/dc.c"
    obs "$W/dc.b" "$W/base" SOBER_WORKERS=1
    for w in 1 4; do
        obs "$W/dc.c" "$W/run" SOBER_WORKERS=$w
        if grep -qx 'exit=104' "$W/run"; then
            echo "FAIL: $e — the domain check (rt mutant 75) fired at SOBER_WORKERS=$w: the state was written back from outside the region of its record"
            fail=$((fail + 1))
        elif [ $w = 1 ] && ! cmp -s "$W/base" "$W/run"; then
            echo "FAIL: $e — the domain check build (rt mutant 75) changed the observation"; diff "$W/base" "$W/run" | head -6
            fail=$((fail + 1))
        fi
    done
    dchk=$((dchk + 1))
done < scripts/schedfuzz.list
"$S2" build examples/domain_await_result.sober --emit=elf --rt-mutant=76 -o "$W/dc.m" > /dev/null 2>&1 || { echo "FAIL: build domain check mutant 76"; fail=$((fail + 1)); }
chmod +x "$W/dc.m"
obs "$W/dc.m" "$W/run" SOBER_WORKERS=1
grep -qx 'exit=104' "$W/run" || { echo "FAIL: mutant 76 (the state re-read copied into the caller's region) was not caught by the domain check (want exit 104)"; fail=$((fail + 1)); }
# 預かり所の回収（std/internal/lotの単体の検査）: rtのミュータント55 = lease_drainが死の通し番号を上げない（Reapが走査を飛ばす — TestReapDeadが赤。
# SOBER_TEST_RT_MUTANT = 試験のビルドにrtのミューテーション）・LOT_REAP_LATE = 番号を走査の後で読むReapのコピー（走査が通り過ぎた枠の死を取りこぼす —
# TestReapRace が赤。交互はワーカー 4 / 8 の本物の並列でだけ起きる）
SOBER_TEST_RT_MUTANT=55 "$S2" test --fresh --run TestReapDead std/internal/lot > /dev/null 2>&1 && { echo "FAIL: lot mutant 55 (lease_drain does not bump the death number) was not caught by TestReapDead"; fail=$((fail + 1)); }
caught=0
for w in 4 8 4 8 4 8 4 8; do
    SOBER_WORKERS=$w LOT_REAP_LATE=1 timeout 120 "$S2" test --fresh --run TestReapRace std/internal/lot > /dev/null 2>&1 || { caught=1; break; }
done
[ $caught = 1 ] || { echo "FAIL: LOT_REAP_LATE (Reap reads the death number after the scan) was not caught by TestReapRace"; fail=$((fail + 1)); }
# 走れるスタックの溢れのパス（report-1168）: 環の容量8のbuild（--rt-mutant=28）はワーカー1の実行の順が通常のbuildと同じ（溢れの列はLIFOの順を保つ）・
# 溢れの列の順を崩した build（29）は順が変わること（testdata/readyspill — 20 本を一度に走れるようにして走った順に直書き）
for v in 0 28 29; do
    "$S2" build testdata/readyspill/main.sober --emit=elf $([ $v = 0 ] || echo --rt-mutant=$v) -o "$W/rs.$v" > /dev/null 2>&1 || { echo "FAIL: build readyspill ($v)"; fail=$((fail + 1)); continue; }
    chmod +x "$W/rs.$v"
    obs "$W/rs.$v" "$W/rs.$v.out" SOBER_WORKERS=1
done
cmp -s "$W/rs.0.out" "$W/rs.28.out" || { echo "FAIL: readyspill — the spill path (ring capacity 8) changes the run order"; diff "$W/rs.0.out" "$W/rs.28.out" | head -6; fail=$((fail + 1)); }
cmp -s "$W/rs.0.out" "$W/rs.29.out" && { echo "FAIL: readyspill — mutant 29 (spill order broken) was not caught"; fail=$((fail + 1)); }
# 盗みの門（rt.mn の MN_DQB）の取りこぼし: spawn → Join の往復（bench/spawn の loop）を W2 で 20 回・1 回 5 秒で打ち切る。ビットが 0 のまま子が
# 列に残ると、暇なワーカーは全走査のデッドロックの判定でスリープをやめては盗みで素通りするループを回り、持ち主はスリープして終わらない（死ではなく止まり）
"$S2" build bench/spawn/main.sober --emit=elf -o "$W/sp" > /dev/null 2>&1 || { echo "FAIL: build bench/spawn"; fail=$((fail + 1)); }
for r in $(seq 20); do
    SOBER_WORKERS=2 timeout 5 "$W/sp" loop 1000000 > /dev/null 2>&1
    [ $? = 124 ] && { echo "FAIL: bench/spawn loop W2 did not finish — a child stayed in a run queue the steal gate (MN_DQB) does not show"; fail=$((fail + 1)); break; }
done
echo "schedfuzz: $n programs × $K seeds × workers {$WS} + 8 mutants + domain check ($dchk examples · mutant 76) + lot nets (mutant 55 · reap-late) + readyspill + steal-gate stall, fail=$fail"
[ $fail = 0 ]
