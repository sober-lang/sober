#!/usr/bin/env bash
# parbudget（段 6 P5-2・language.md 11 節「予算と admission」）: 入場できない子の逐次への縮退が観測を変えないこと・
# 計上が天井を守ること。scripts/schedfuzz.list の例（split の証人を除く）と Skynet（小）を、天井 SOBER_BUDGET_MB ∈ {0〔極小 — give: 以外は全部縮退〕,
# 2〔小〕, 既定} × ワーカー {1, 2, 8} で走らせ、観測（stdout・終了コード・`#` で始まらない stderr）をワーカー 1・既定の天井の黄金と照合する
# （死ぬ例のワーカー 2 以上は exit + 死因の stderr だけ — schedfuzz と同じ裁定）。SOBER_PAR_STATS=1 の `#par admit` の行で
#   ① 計上の高水位 peak_bytes ≤ 天井（超過〔over — give: の子は常に入場〕が 0 の実行だけ）② 終わりの計上 held_bytes = held_tasks = 0（返し漏れ — 名前つきプールの節の
#   `#par pool` の used / tasks も — 段 6 P5-4）
#   ③ 天井 0 の実行の縮退の数の和 > 0（網が縮退の道を踏んだ証人）
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
                # std/par を使っても spawn しない終わり方（死ぬ例は印字の前に終わる）— 台帳の行が無ければ照合だけ
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
while read -r e mark; do
    case "$e" in ''|'#'*) continue ;; esac
    [ "$mark" = split ] && continue
    n=$((n + 1))
    "$S2" build "$e" --emit=elf -o "$W/bin" > /dev/null 2>&1 || { echo "FAIL: build $e"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin"
    check "$e" "$W/bin"
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
# 変異の自己検査（1 件で足りる — 最初の割れで打ち切り）
for m in "7 examples/par_steal.sober" "8 examples/par_die.sober"; do
    set -- $m
    "$S2" build "$2" --emit=elf -o "$W/bin" > /dev/null 2>&1 && "$S2" build "$2" --emit=elf --rt-mutant=$1 -o "$W/mut" > /dev/null 2>&1 || { echo "FAIL: build mutant $1 $2"; fail=$((fail + 1)); continue; }
    chmod +x "$W/bin" "$W/mut"
    obs "$W/bin" "$W/base" SOBER_WORKERS=1
    caught=0
    for w in 1 2; do
        obs "$W/mut" "$W/run" SOBER_WORKERS=$w SOBER_PAR_STATS=1 SOBER_BUDGET_MB=0
        cmp -s "$W/base" "$W/run" || { caught=1; break; }
        obs "$W/mut" "$W/run" SOBER_WORKERS=$w SOBER_PAR_STATS=1
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
"$S2" build bench/skynet/main.sober --emit=elf -o "$W/sky" > /dev/null 2>&1 || { echo "FAIL: build bench/skynet"; fail=$((fail + 1)); }
chmod +x "$W/sky"
tm=()
for k in 10000 1000000; do
    SOBER_WORKERS=8 SOBER_PAR_STATS=1 "$W/sky" "$k" > "$W/sky.out" 2> "$W/sky.par" || { echo "FAIL: skynet $k"; fail=$((fail + 1)); }
    tm+=("$(grep '^#par tasks' "$W/sky.par" | tr ' ' '\n' | sed -n 's/^tcb_mmaps=//p')")
done
if [ -z "${tm[0]}" ] || [ -z "${tm[1]}" ] || [ "${tm[1]}" -gt $(( 4 * ${tm[0]} )) ]; then
    echo "FAIL: task blocks are not reused — tcb_mmaps ${tm[0]:-?} (10^4 tasks) → ${tm[1]:-?} (10^6 tasks)"; fail=$((fail + 1))
fi
echo "parbudget: $n programs × budget {0, 2 MiB, default} × workers {1, 2, 8} + 2 mutants, inlined under budget 0 = $inl0, tcb_mmaps ${tm[0]:-?} → ${tm[1]:-?}, fail=$fail"
[ $fail = 0 ]
