#!/usr/bin/env bash
# seq ≡ par の照合（段 6 P3a-2c — language.md 11 節「並列化はリファクタリング」の最初の網）: scripts/seqpar.list の対ごとに、
# 逐次の双子（既定の経路）と並列の例（3 経路 — --passes + SOBER_VERIFY=each・既定・--no-opt）を建てて実行し、stdout と終了コードが全部一致すること。
# 即時形（P3a）では並列の例は 1 つのスケジュール（子は Spawn の時点で走る）なので、ここで立つのは「par の書き換えの等価」と「最適化の観測一致」まで
# P4-1 / P4-4: 並列の例はワーカー数の列（SEQPAR_WORKERS — 既定 "1 2 4 8"）ごとに SOBER_WORKERS を付けて走らせる（2 以上 = M:N の本物の並列）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
n=0
WS=${SEQPAR_WORKERS:-1 2 4 8}
run() {   # run <entry> <mode> <out> [workers]
    local e=$1 m=$2 o=$3 w=${4:-1} ec=0
    case $m in
        passes) SOBER_VERIFY=each "$S2" build "$e" --emit=elf --passes -o "$W/bin" ;;
        plain) "$S2" build "$e" --emit=elf -o "$W/bin" ;;
        noopt) "$S2" build "$e" --emit=elf --no-opt -o "$W/bin" ;;
    esac || { echo "FAIL: build $e ($m)"; return 1; }
    chmod +x "$W/bin"
    SOBER_WORKERS=$w "$W/bin" > "$o" 2> /dev/null || ec=$?
    # 実行できなかった（126 / 127 — 建てた物が ELF でない等）は失敗（両側の失敗が一致して素通りしないように）
    if [ "$ec" = 126 ] || [ "$ec" = 127 ]; then echo "FAIL: could not run $e ($m)"; return 1; fi
    echo "exit=$ec" >> "$o"
}
while read -r par seq; do
    case "$par" in ''|'#'*) continue ;; esac
    n=$((n + 1))
    run "$seq" plain "$W/seq.out" || { fail=$((fail + 1)); continue; }
    for w in $WS; do
        for m in passes plain noopt; do
            run "$par" $m "$W/par.out" "$w" || { fail=$((fail + 1)); continue; }
            if ! cmp -s "$W/seq.out" "$W/par.out"; then
                echo "FAIL: $par ($m, SOBER_WORKERS=$w) differs from $seq"
                diff "$W/seq.out" "$W/par.out" | head -6
                fail=$((fail + 1))
            fi
        done
    done
done < scripts/seqpar.list
echo "seqpar: $n pairs, fail=$fail"
[ $fail = 0 ]
