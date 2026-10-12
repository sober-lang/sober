#!/usr/bin/env bash
# checkstats（段 6 P6-0 — 自己 check の費用の帰属）: `sober check` を段ごとに止めて（SOBER_CHECK_STOP = load / analyzer / desugar / 最後まで）、
# （typer = 脱糖の表層型検査器まで・defs = Def の脱糖まで〔検査器への写しの前〕— 段 6 P6-3）
# perf の命令数（instructions:u — 決定的）と peak RSS を測り、前の段との差を段の費用として出す。
#   scripts/checkstats.sh [--pkg <path>]… [<entry>]   既定 entry = compiler/app/main.sober（std を写した作業木で — passstats と同じ形）
# --pkg を付けると一括でなく package ごとの部分検査（check --pkg — iface は先に 1 回書く）を、付けた package ごとに測る（analyzer の段は無い）。
# PERF で perf の実行ファイルを指す（無ければ PATH → /nix/store を探す）。SOBER_WORKERS は呼び手の環境のまま（P6 の W 軸はこれで振る）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
PERF=${PERF:-$(command -v perf || ls -d /nix/store/*perf-linux*/bin/perf 2>/dev/null | head -n 1)}
[ -n "$PERF" ] || { echo "checkstats: perf が無い（PERF で指す）" >&2; exit 2; }
pkgs=()
entry=""
while [ $# -gt 0 ]; do
    case "$1" in
        --pkg) pkgs+=("$2"); shift ;;
        *) entry=$1 ;;
    esac
    shift
done
S2=$(scripts/stage2.sh) || exit 1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
if [ -z "$entry" ]; then
    T=$W/tree
    mkdir -p "$T"
    cp -r src/compiler/. "$T/"
    cp -r src/std "$T/std"
    entry=app/main.sober
else
    T=$ROOT
fi
one() { # $1 = 止める段（空 = 最後まで）・残り = check の引数 → 「命令数 rssMB」
    local stop=$1
    shift
    (cd "$T" && SOBER_CHECK_STOP=$stop "$PERF" stat -x, -e instructions:u -o "$W/p" /usr/bin/time -f "%M" -o "$W/t" "$S2" check "$@" > /dev/null 2> "$W/err") \
        || { echo "checkstats: FAIL ${stop:-all} $*: $(head -c 200 "$W/err")" >&2; exit 1; }
    local ins
    ins=$(grep instructions "$W/p" | cut -d, -f1)
    echo "$ins $(( $(cat "$W/t" | tail -n 1) / 1024 ))"
}
table() { # $1 = 見出し・$2… = 段の名前（最後は空 = 最後まで）・-- の後 = check の引数
    local title=$1
    shift
    local stages=()
    while [ "$1" != "--" ]; do stages+=("$1"); shift; done
    shift
    echo "### $title"
    echo "| 段まで | 命令 G | RSS MB | 段の命令 G | 段の比 |"
    echo "|---|---|---|---|---|"
    local prev=0 rows=() s ins rss
    for s in "${stages[@]}"; do
        read -r ins rss < <(one "$s" "$@")
        rows+=("${s:-all} $ins $rss $(( ins - prev ))")
        prev=$ins
    done
    local r
    for r in "${rows[@]}"; do
        set -- $r
        awk -v n="$1" -v i="$2" -v m="$3" -v d="$4" -v t="$prev" 'BEGIN { printf "| %s | %.2f | %d | %+.2f | %.0f%% |\n", n, i / 1e9, m, d / 1e9, 100 * d / t }'
    done
}
echo "checkstats: $entry (W=${SOBER_WORKERS:-auto}) loadavg $(cut -d' ' -f1 /proc/loadavg)"
if [ ${#pkgs[@]} -eq 0 ]; then
    table "一括" load analyzer typer defs desugar "" -- "$entry"
    # 核の節の数（展開の掛け算 — 決定的。bench/ratchet.txt の self/check nodes と照合 — report-511）
    nodes=$(cd "$T" && "$S2" check "$entry" --expansion-report | awk '$1 == "core" && $2 == "nodes" { print $3 }')
    nlim=$(awk '$1 == "self/check" && $2 == "nodes" { print $3 }' bench/ratchet.txt)
    if [ "$entry" = app/main.sober ] && [ -n "$nlim" ] && [ "$nodes" -gt "$nlim" ]; then
        echo "核の節 $nodes > $nlim（bench/ratchet.txt の self/check nodes — RATCHET FAIL）"
        exit 1
    fi
    echo "核の節 $nodes（上限 ${nlim:-なし}）— 展開の多い関数は check $entry --expansion-report"
else
    (cd "$T" && "$ROOT/bin/sober" iface "$entry" -o "$W/ifc" > /dev/null) || { echo "checkstats: iface の書き出しに失敗" >&2; exit 1; }
    for pk in "${pkgs[@]}"; do
        table "--pkg $pk" load typer defs desugar "" -- "$entry" --pkg "$pk" --iface "$W/ifc"
    done
fi
