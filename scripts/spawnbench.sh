#!/usr/bin/env bash
# spawnbench: spawn の固定費のマイクロベンチ（inst / rss = ワーカー 1 の協調形 — SOBER_WORKERS=1。wall = M:N のワーカー数ごとの往復 — 段 6 P4-6）（bench/spawn/main.sober）を perf の命令数（決定的）と RSS で測り、
# bench/spawn/ratchet.txt の上限と照合する。gates には入れない（perf が要る — PERF で perf の実行ファイルを指す・無ければ /nix/store を探す）
#   scripts/spawnbench.sh
set -uo pipefail
cd "$(dirname "$0")/.."
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "spawnbench: perf が無い（PERF で指す）" >&2; exit 2; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
bin/sober build -o "$W/spawn" bench/spawn/main.sober || exit 1
fail=0
while read -r mode n col lim w; do
    case "$mode" in ''|'#'*) continue ;; esac
    if [ "$col" = wall ]; then
        # M:N の行（段 6 P4-6）: ワーカー w の wall（秒 — 3 回の最小。揺れるので上限は目標〔往復 1 µs〕で置く）
        best=""
        for r in 1 2 3; do
            /usr/bin/time -f "%e" -o "$W/t" env SOBER_WORKERS="$w" "$W/spawn" "$mode" "$n" > /dev/null
            t=$(cat "$W/t")
            if [ -z "$best" ] || awk -v a="$t" -v b="$best" 'BEGIN { exit !(a < b) }'; then best=$t; fi
        done
        if awk -v a="$best" -v b="$lim" 'BEGIN { exit !(a > b) }'; then
            echo "spawnbench: RATCHET FAIL $mode $n wall(W$w) = $best > $lim"; fail=1
        else
            echo "spawnbench: ok $mode $n wall(W$w) = $best ≤ $lim"
        fi
        continue
    fi
    if [ "$col" = inst ]; then
        i=$(SOBER_WORKERS=1 "$PERF" stat -x, -e instructions:u "$W/spawn" "$mode" "$n" 2>&1 > /dev/null | cut -d, -f1)
        v=$(( i / n ))
    else
        SOBER_WORKERS=1 /usr/bin/time -f "%M" -o "$W/t" "$W/spawn" "$mode" "$n" > /dev/null
        v=$(( $(cat "$W/t") / 1024 ))
    fi
    if [ "$v" -gt "$lim" ]; then
        echo "spawnbench: RATCHET FAIL $mode $n $col = $v > $lim"; fail=1
    else
        echo "spawnbench: ok $mode $n $col = $v ≤ $lim"
    fi
done < bench/spawn/ratchet.txt
exit $fail
