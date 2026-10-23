#!/usr/bin/env bash
# framestat（F-1 段 0 — report-1002 / 1003）: 開発の口 `--frame-stat`（1 本の経路で建て、関数ごとに
# `frame <関数> <フレーム B> <スロット B> <零初期化 B> <退避 B> <spill ほか B> <spill の部分区間の数>` を stdout へ — x86.sober xFrameStat）で、
# scripts/framestat.list の上限（ラチェット — 実測 ×1.01 で引き、越えたら赤・2% 以上下がったら締め直しの note）を照合する。フレームの大きさは出力を変えないので
# optdiff では鳴らない — スロット / spill の枠の割り当て（彩色）が黙って効かなくなる退行の網
#   scripts/framestat.sh            # 照合
#   scripts/framestat.sh --show     # 照合 + 各題材の上位 8 本を印字
# list の行 = `<題材> <関数 | @sum | @zero> <上限 B>`。題材 @self は自己 build の木（compiler + std の写し）
set -uo pipefail
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
R=$PWD
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
show=0; [ "${1:-}" = --show ] && show=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0; n=0
stat() {   # stat <題材> → $W/<鍵>.txt
    local src=$1 key; key=$(echo "$src" | tr '/@.' '___')
    [ -f "$W/$key.txt" ] && { echo "$W/$key.txt"; return; }
    if [ "$src" = @self ]; then
        mkdir -p "$W/tree"; cp -r src/compiler/. "$W/tree/"; cp -r src/std "$W/tree/std"
        (cd "$W/tree" && SOBER_WORKERS=1 "$S2" build app/main.sober --frame-stat -o "$W/x" > "$W/$key.txt" 2> "$W/err") || { echo "FAIL build $src" >&2; cat "$W/err" >&2; return 1; }
    else
        "$S2" build "$src" --frame-stat -o "$W/x" > "$W/$key.txt" 2> "$W/err" || { echo "FAIL build $src" >&2; cat "$W/err" >&2; return 1; }
    fi
    [ $show = 1 ] && { echo "== $src"; sort -k3 -n -r "$W/$key.txt" | head -8; } >&2
    echo "$W/$key.txt"
}
while read -r src fn lim; do
    case "$src" in ''|'#'*) continue ;; esac
    f=$(stat "$src") || { fail=$((fail + 1)); continue; }
    case "$fn" in
        @sum) got=$(awk '$1 == "frame" { s += $3 } END { print s + 0 }' "$f") ;;
        @zero) got=$(awk '$1 == "frame" { s += $5 } END { print s + 0 }' "$f") ;;
        *) got=$(awk -v n="$fn" '$1 == "frame" && $2 == n { print $3; exit }' "$f"); got=${got:-0} ;;
    esac
    n=$((n + 1))
    if [ "$got" -gt "$lim" ]; then echo "FAIL $src $fn: $got B > $lim B"; fail=$((fail + 1))
    elif [ $((got * 102 / 100)) -lt "$lim" ]; then echo "note $src $fn: $got B — 2% or more below $lim B (tighten scripts/framestat.list)"; fi
done < scripts/framestat.list
echo "framestat: $n limits — frame sizes within scripts/framestat.list, fail=$fail"
[ $fail = 0 ]
