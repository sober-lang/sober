#!/usr/bin/env bash
# parbudget（段 6 P5-2・language.md 11 節「予算と admission」）: 入場できない子の逐次への縮退が観測を変えないこと・
# 計上が天井を守ること。scripts/schedfuzz.list の例（split の証人を除く）と Skynet（小）を、天井 SOBER_BUDGET_MB ∈ {0〔極小 — give: 以外は全部縮退〕,
# 2〔小〕, 既定} × ワーカー {1, 2, 8} で走らせ、観測（stdout・終了コード・`#` で始まらない stderr）をワーカー 1・既定の天井の黄金と照合する
# （死ぬ例のワーカー 2 以上は exit + 死因の stderr だけ — schedfuzz と同じ裁定）。SOBER_PAR_STATS=1 の `#par admit` の行で
#   ① 計上の高水位 peak_bytes ≤ 天井（超過〔over — give: の子は常に入場〕が 0 の実行だけ）② 終わりの計上 held_bytes = held_tasks = 0（返し漏れ — 名前つきプールの節の
#   `#par pool` の used / tasks も — 段 6 P5-4）
#   ③ 天井 0 の実行の縮退の数の和 > 0（網が縮退の道を踏んだ証人）④〜⑥ inline の約束（縮退分の記帳 — 下の testdata/parbudget/inline.sober の節）
#   ⑦〜⑪ wait の約束（宣言 = 本当の上限・待ちの決定性・上界 > 天井の名指しの panic — testdata/parbudget/wait{,_over}.sober の節）
#   ⑫ wait × deadline（期限は待ちを切らない・子は期限を継ぐ — testdata/parbudget/wait_deadline.sober の節）
# 変異の自己検査: 7 = 終わりで台帳へ返さない（② で鳴る）・8 = 縮退した子の罠を張らない（子の死が親の死に化ける — 死因の照合で鳴る）
#   scripts/parbudget.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
inl0=0
ARGS=""
obs() {   # obs <bin> <out> [env…] — 観測 + `#par` の行を <out>.par へ
    local b=$1 o=$2 ec=0
    shift 2
    env "$@" timeout 60 "$b" $ARGS > "$o" 2> "$o.err" || ec=$?
    echo "exit=$ec" >> "$o"
    grep -v '^#' "$o.err" >> "$o"
    grep '^#par' "$o.err" > "$o.par"
}
deathobs() { sed -n '/^exit=/,$p' "$1"; }
field() { grep '^#par admit' "$1" | tr ' ' '\n' | sed -n "s/^$2=//p"; }
cap() { grep '^#par root' "$1" | tr ' ' '\n' | sed -n 's/^cap=//p'; }
check() {   # check <name> <bin>（実引数は ARGS）
    local e=$1 bin=$2
    shift 2
    obs "$bin" "$W/base" SOBER_WORKERS=1 "$@"
    deathobs "$W/base" > "$W/base.d"
    local dies=0
    grep -qx 'exit=0' "$W/base" || dies=1
    for b in 0 2 ""; do
        for w in 1 2 8; do
            obs "$bin" "$W/run" SOBER_WORKERS=$w SOBER_PAR_STATS=1 ${b:+SOBER_BUDGET_MB=$b} "$@"
            local same=0
            if [ $dies = 1 ] && [ "$w" != 1 ]; then
                deathobs "$W/run" > "$W/run.d"; cmp -s "$W/base.d" "$W/run.d" && same=1
            else
                cmp -s "$W/base" "$W/run" && same=1
            fi
            if [ $same = 0 ]; then
                echo "FAIL: $e splits (SOBER_BUDGET_MB=${b:-既定} SOBER_WORKERS=$w)"; diff "$W/base" "$W/run" | head -6; fail=$((fail + 1))
            fi
            local pk ov hb ht c inl
            pk=$(field "$W/run.par" peak_bytes); ov=$(field "$W/run.par" over); hb=$(field "$W/run.par" held_bytes); ht=$(field "$W/run.par" held_tasks)
            c=$(cap "$W/run.par"); inl=$(field "$W/run.par" inline)
            if [ -z "$pk" ]; then
                # std/task を使っても spawn しない終わり方（死ぬ例は印字の前に終わる）— 台帳の行が無ければ照合だけ
                continue
            fi
            if [ "$ov" = 0 ] && [ "$pk" -gt "$c" ]; then
                echo "FAIL: $e peak_bytes $pk > cap $c (SOBER_BUDGET_MB=${b:-既定} W=$w)"; fail=$((fail + 1))
            fi
            if [ $dies = 0 ] && { [ "$hb" != 0 ] || [ "$ht" != 0 ]; }; then
                echo "FAIL: $e ledger not returned: held_bytes=$hb held_tasks=$ht (SOBER_BUDGET_MB=${b:-既定} W=$w)"; fail=$((fail + 1))
            fi
            # 名前つきプールの節（段 6 P5-4 — `#par pool <id> … used=… tasks=…`）も終わりに全部返っていること
            if [ $dies = 0 ] && grep '^#par pool ' "$W/run.par" | tr ' ' '\n' | grep -Eq '^(used|tasks)=[^0]'; then
                echo "FAIL: $e pool ledger not returned (SOBER_BUDGET_MB=${b:-既定} W=$w)"; grep '^#par pool ' "$W/run.par" | head -3; fail=$((fail + 1))
            fi
            [ "$b" = 0 ] && inl0=$((inl0 + inl))
        done
    done
}
# 実行ファイルは建てるたびに別の名前（カーネル 6.18 では M:N の実行の直後に同じパスへ書くと ETXTBSY — report-660）
while read -r e mark; do
    case "$e" in ''|'#'*) continue ;; esac
    [ "$mark" = split ] && continue
    n=$((n + 1))
    "$S2" build "$e" --emit=elf -o "$W/bin.$n" > /dev/null 2>&1 || { echo "FAIL: build $e"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin.$n"
    check "$e" "$W/bin.$n"
done < scripts/schedfuzz.list
# Skynet（小 — 葉 1 万）
n=$((n + 1))
"$S2" build bench/skynet/main.sober --emit=elf -o "$W/sky" > /dev/null 2>&1 || { echo "FAIL: build skynet"; fail=$((fail + 1)); }
chmod +x "$W/sky"
ARGS=10000
check "skynet 10000" "$W/sky"
ARGS=""
if [ "$inl0" -le 0 ]; then
    echo "FAIL: no child was inlined under SOBER_BUDGET_MB=0 — the net does not reach the fallback path"; fail=$((fail + 1))
fi
# inline の約束（language.md 11 節「縮退分の記帳と約束の段」— 段 3 の ②）: testdata/parbudget/inline.sober（天井 64 MB・子の宣言 16 MB・実使用 約 14 MB × 32）を
# W 2 / 8 で 2 回ずつ。実使用 = 最大 RSS − `base` の最大 RSS。④ 台帳の計上の高水位（縮退の記帳込み — peak_all）≥ 実使用 ⑤ 実使用 ≤ 天井 + 子の宣言（縮退 1 段分）
# ⑥ 縮退が起きた（inline > 0 — 網が記帳の道を踏んだ証人）。wait の約束（宣言 ≥ 実使用）の網は段 3 の ③
"$S2" build testdata/parbudget/inline.sober --emit=elf -o "$W/inl" > /dev/null 2>&1 || { echo "FAIL: build testdata/parbudget/inline.sober"; fail=$((fail + 1)); }
chmod +x "$W/inl"
SOBER_WORKERS=8 /usr/bin/time -f "%M" -o "$W/inl.base" "$W/inl" base > /dev/null 2>&1
ib=$(cat "$W/inl.base")
inlw=0
for w in 2 8; do
    for _ in 1 2; do
        SOBER_WORKERS=$w SOBER_PAR_STATS=1 /usr/bin/time -f "%M" -o "$W/inl.rss" "$W/inl" > "$W/inl.out" 2> "$W/inl.par" || { echo "FAIL: inline W$w run"; fail=$((fail + 1)); continue; }
        used=$(( ($(tail -n 1 "$W/inl.rss") - ib) * 1024 ))
        pa=$(field "$W/inl.par" peak_all); il=$(field "$W/inl.par" inline)
        [ -n "$pa" ] && [ "$pa" -ge "$used" ] || { echo "FAIL: inline W$w — ledger peak (with inlined children) $pa < used $used"; fail=$((fail + 1)); }
        [ "$used" -le $(( (64 + 16) * 1048576 )) ] || { echo "FAIL: inline W$w — used $used > budget + one inlined child (80 MiB)"; fail=$((fail + 1)); }
        inlw=$(( inlw + ${il:-0} ))
    done
done
[ "$inlw" -gt 0 ] || { echo "FAIL: inline — no child was inlined (the net does not reach the recorded fallback)"; fail=$((fail + 1)); }
# wait の約束（language.md 11 節「wait」— 段 3 の ③）: testdata/parbudget/wait.sober（inline.sober と同じ形を wait: true で）を W 1 / 2 / 8 × 2 回。
# ⑦ 実使用 ≤ 天井（宣言 = 本当の上限）⑧ 縮退 0 ⑨ 出力が W1 と一致（待ちは遅らせるだけ）⑩ 待ちが起きた（#par admit waits の和 > 0）
# ⑪ 負例 testdata/parbudget/wait_over.sober（宣言 16 MB > wait の天井 8 MB）は W 1 / 8 とも exit 101 + 名指しの文面
"$S2" build testdata/parbudget/wait.sober --emit=elf -o "$W/wt" > /dev/null 2>&1 || { echo "FAIL: build testdata/parbudget/wait.sober"; fail=$((fail + 1)); }
chmod +x "$W/wt"
SOBER_WORKERS=8 /usr/bin/time -f "%M" -o "$W/wt.base" "$W/wt" base > /dev/null 2>&1
wb=$(cat "$W/wt.base")
SOBER_WORKERS=1 "$W/wt" > "$W/wt.ref" 2> /dev/null
waits=0
for w in 1 2 8; do
    for _ in 1 2; do
        SOBER_WORKERS=$w SOBER_PAR_STATS=1 timeout 60 /usr/bin/time -f "%M" -o "$W/wt.rss" "$W/wt" > "$W/wt.out" 2> "$W/wt.par" || { echo "FAIL: wait W$w run"; fail=$((fail + 1)); continue; }
        cmp -s "$W/wt.ref" "$W/wt.out" || { echo "FAIL: wait W$w — output differs from W1"; fail=$((fail + 1)); }
        used=$(( ($(tail -n 1 "$W/wt.rss") - wb) * 1024 ))
        [ "$used" -le $(( 64 * 1048576 )) ] || { echo "FAIL: wait W$w — used $used > budget (64 MiB)"; fail=$((fail + 1)); }
        il=$(field "$W/wt.par" inline); [ "${il:-x}" = 0 ] || { echo "FAIL: wait W$w — a direct child was inlined ($il)"; fail=$((fail + 1)); }
        waits=$(( waits + $(field "$W/wt.par" waits) ))
    done
done
[ "$waits" -gt 0 ] || { echo "FAIL: wait — no spawn waited (the net does not reach the wait path)"; fail=$((fail + 1)); }
"$S2" build testdata/parbudget/wait_over.sober --emit=elf -o "$W/wo" > /dev/null 2>&1 || { echo "FAIL: build testdata/parbudget/wait_over.sober"; fail=$((fail + 1)); }
chmod +x "$W/wo"
for w in 1 8; do
    ec=0; SOBER_WORKERS=$w timeout 20 "$W/wo" > /dev/null 2> "$W/wo.err" || ec=$?
    [ "$ec" = 101 ] && grep -q '^panic: budget: is larger than the ceiling of the wait: scope (the child can never be admitted) at wait_over.sober:9:24$' "$W/wo.err" || { echo "FAIL: wait_over W$w — exit $ec: $(head -c 200 "$W/wo.err")"; fail=$((fail + 1)); }
done
# wait × deadline（段 3 の ④ — language.md 28 節「デッドライン」）: testdata/parbudget/wait_deadline.sober（wait.sober の scope に deadline: 0）を W 1 / 2 / 8。
# ⑫ 期限は待ちを切らない — 全部の子が完走して出力 = wait.sober の W1 の値 × 2 + 32（子の io の口は 32 本とも Timeout — 期限は子へ継がれる）・縮退 0・待ちの和 > 0
"$S2" build testdata/parbudget/wait_deadline.sober --emit=elf -o "$W/wd" > /dev/null 2>&1 || { echo "FAIL: build testdata/parbudget/wait_deadline.sober"; fail=$((fail + 1)); }
chmod +x "$W/wd"
wdx=$(( $(cat "$W/wt.ref") * 2 + 32 ))
dwaits=0
for w in 1 2 8; do
    SOBER_WORKERS=$w SOBER_PAR_STATS=1 timeout 60 "$W/wd" > "$W/wd.out" 2> "$W/wd.par" || { echo "FAIL: wait_deadline W$w run"; fail=$((fail + 1)); continue; }
    [ "$(cat "$W/wd.out")" = "$wdx" ] || { echo "FAIL: wait_deadline W$w — output $(head -c 40 "$W/wd.out") ≠ $wdx"; fail=$((fail + 1)); }
    il=$(field "$W/wd.par" inline); [ "${il:-x}" = 0 ] || { echo "FAIL: wait_deadline W$w — a direct child was inlined ($il)"; fail=$((fail + 1)); }
    dwaits=$(( dwaits + $(field "$W/wd.par" waits) ))
done
[ "$dwaits" -gt 0 ] || { echo "FAIL: wait_deadline — no spawn waited"; fail=$((fail + 1)); }
# 変異の自己検査（1 件で足りる — 最初の割れで打ち切り）
for m in "7 examples/task_steal.sober" "8 examples/task_die.sober"; do
    set -- $m
    "$S2" build "$2" --emit=elf -o "$W/bin.m$1" > /dev/null 2>&1 && "$S2" build "$2" --emit=elf --rt-mutant=$1 -o "$W/mut.$1" > /dev/null 2>&1 || { echo "FAIL: build mutant $1 $2"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin.m$1" "$W/mut.$1"
    obs "$W/bin.m$1" "$W/base" SOBER_WORKERS=1
    caught=0
    for w in 1 2; do
        obs "$W/mut.$1" "$W/run" SOBER_WORKERS=$w SOBER_PAR_STATS=1 SOBER_BUDGET_MB=0
        cmp -s "$W/base" "$W/run" || { caught=1; break; }
        obs "$W/mut.$1" "$W/run" SOBER_WORKERS=$w SOBER_PAR_STATS=1
        hb=$(field "$W/run.par" held_bytes)
        cmp -s "$W/base" "$W/run" || { caught=1; break; }
        [ -n "$hb" ] && [ "$hb" != 0 ] && { caught=1; break; }
    done
    if [ $caught = 0 ]; then
        echo "FAIL: mutant $1 ($2) was not caught — the budget net does not see the broken rt"; fail=$((fail + 1))
    fi
done
# task の塊（TCB）が使い回されていること（手元の鎖を丸ごと束にした形は塊を 1 つのワーカーが抱え、新しい塊の mmap が入力に比例した）:
# Skynet を W8 で 1 万 / 100 万 task 走らせ、新しい塊の数（#par tasks の tcb_mmaps）が 4 倍以内（使い回せていれば同じ桁 — 直した形で 1.8 倍）
"$S2" build bench/skynet/main.sober --emit=elf -o "$W/sky2" > /dev/null 2>&1 || { echo "FAIL: build bench/skynet"; fail=$((fail + 1)); }
chmod +x "$W/sky2"
tm=()
for k in 10000 1000000; do
    SOBER_WORKERS=8 SOBER_PAR_STATS=1 "$W/sky2" "$k" > "$W/sky.out" 2> "$W/sky.par" || { echo "FAIL: skynet $k"; fail=$((fail + 1)); }
    tm+=("$(grep '^#par tasks' "$W/sky.par" | tr ' ' '\n' | sed -n 's/^tcb_mmaps=//p')")
done
if [ -z "${tm[0]}" ] || [ -z "${tm[1]}" ] || [ "${tm[1]}" -gt $(( 4 * ${tm[0]} )) ]; then
    echo "FAIL: task blocks are not reused — tcb_mmaps ${tm[0]:-?} (10^4 tasks) → ${tm[1]:-?} (10^6 tasks)"; fail=$((fail + 1))
fi
echo "parbudget: $n programs × budget {0, 2 MiB, default} × workers {1, 2, 8} + 2 mutants + inline promise (inlined $inlw) + wait promise (waits $waits) + wait × deadline (waits $dwaits), inlined under budget 0 = $inl0, tcb_mmaps ${tm[0]:-?} → ${tm[1]:-?}, fail=$fail"
[ $fail = 0 ]
