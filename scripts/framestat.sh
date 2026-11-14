#!/usr/bin/env bash
# framestat（F-1段階0 — report-1002 / 1003）: 開発のオプション `--frame-stat`（1本の経路でビルドし、関数ごとに
# `frame <関数> <フレーム B> <スロット B> <零初期化 B> <退避 B> <spill ほか B> <spill の部分区間の数>` を stdout へ — x86.sober xFrameStat）で、
# scripts/framestat.list の上限（ラチェット — 実測 ×1.01 で引き、越えたら赤・2% 以上下がったら締め直しの note）を照合する。フレームの大きさは出力を変えないので
# optdiffでは鳴らない — スロット / spillの枠の割り当て（彩色）が黙って効かなくなる退行の検査
#   scripts/framestat.sh            # 照合
#   scripts/framestat.sh --show     # 照合 + 各題材の上位 8 本を印字
# listの行 = `<題材> <関数 | @sum | @zero> <上限 B>`。題材 @selfは自己buildの木（compiler + stdのコピー）
# `<題材> @room <本体> <入口>` = 接続のtaskの本体の枠がチャンクのページ0の余白に収まるしきい値: 本体の枠 + 入口の枠 + 72（入口の実引数・戻り番地・rbp）
#   + 16（本体の戻り番地とrbp）≤ TCB_TOP_ROOM（src/compiler/lower/task.sober）。越えると本体は今の連続のスタックの形に落ちる。
#   自己検査として毎回、同じ題材をミューテーション60（全関数の枠 +512 B）でビルドして @roomが赤になることも確認する（build 1本ぶん）
# `<題材> @shallow <本体> <下限>` = 接続のtaskの本体がシャロースリープ（rt.netwaitの呼び出しの点 — 受け）を下限の数以上持つ（`shallow <関数>` の行の数）。
#   自己検査としてミューテーション67（記しを付けない）で0になることも確認する
set -uo pipefail
export SOBER_HASH_SEED=${SOBER_HASH_SEED:-0}
cd "$(dirname "$0")/.."
R=$PWD
S2=${STAGE2:-out/stage2/sober2}
case "$S2" in /*) ;; *) S2=$R/$S2 ;; esac
show=0; [ "${1:-}" = --show ] && show=1
room=$(sed -n 's/^const TCB_TOP_ROOM = \([0-9]*\).*/\1/p' src/compiler/lower/task.sober)
[ -n "$room" ] || { echo "framestat: FAIL — TCB_TOP_ROOM not found in src/compiler/lower/task.sober"; exit 1; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0; n=0
stat() {   # stat <題材> [build の追加の旗…] → $W/<鍵>.txt
    local src=$1 key; shift; key=$(echo "$src $*" | tr '/@. =-' '______')
    [ -f "$W/$key.txt" ] && { echo "$W/$key.txt"; return; }
    if [ "$src" = @self ]; then
        mkdir -p "$W/tree"; cp -r src/compiler/. "$W/tree/"; cp -r src/std "$W/tree/std"
        (cd "$W/tree" && SOBER_WORKERS=1 "$S2" build app --frame-stat -o "$W/x" > "$W/$key.txt" 2> "$W/err") || { echo "FAIL build $src" >&2; cat "$W/err" >&2; return 1; }
    else
        "$S2" build "$src" --frame-stat "$@" -o "$W/x" > "$W/$key.txt" 2> "$W/err" || { echo "FAIL build $src" >&2; cat "$W/err" >&2; return 1; }
    fi
    [ $show = 1 ] && { echo "== $src"; sort -k3 -n -r "$W/$key.txt" | head -8; } >&2
    echo "$W/$key.txt"
}
fr() { awk -v n="$2" '$1 == "frame" && $2 == n { print $3; exit }' "$1"; }
roomsum() {   # roomsum <frame-statの出力> <本体> <入口> → ページ0に積むB（関数が無ければ空）
    local b e; b=$(fr "$1" "$2"); e=$(fr "$1" "$3")
    [ -n "$b" ] && [ -n "$e" ] && echo $((b + e + 72 + 16))
}
while read -r src fn lim; do
    case "$src" in ''|'#'*) continue ;; esac
    f=$(stat "$src") || { fail=$((fail + 1)); continue; }
    if [ "$fn" = @room ]; then
        read -r body entry <<< "$lim"
        n=$((n + 1))
        got=$(roomsum "$f" "$body" "$entry")
        if [ -z "$got" ]; then echo "FAIL $src @room: frame of $body or $entry not found"; fail=$((fail + 1))
        elif [ "$got" -gt "$room" ]; then echo "FAIL $src @room $body: $got B (body + entry + 88) > TCB_TOP_ROOM $room B — the body no longer fits page 0"; fail=$((fail + 1))
        else [ $show = 1 ] && echo "room $src $body: $got B of $room B (spare $((room - got)) B)"; fi
        mf=$(stat "$src" --rt-mutant=60) || { fail=$((fail + 1)); continue; }
        mg=$(roomsum "$mf" "$body" "$entry")
        if [ -n "$mg" ] && [ "$mg" -gt "$room" ]; then echo "mutant 60 $src @room: $mg B > $room B — caught"
        else echo "FAIL mutant 60 $src @room: ${mg:-?} B — not caught"; fail=$((fail + 1)); fi
        continue
    fi
    if [ "$fn" = @shallow ]; then
        read -r body lo <<< "$lim"
        n=$((n + 1))
        got=$(awk -v n="$body" '$1 == "shallow" && $2 == n' "$f" | wc -l)
        if [ "$got" -lt "$lo" ]; then echo "FAIL $src @shallow $body: $got shallow waits < $lo — the receive no longer waits shallow"; fail=$((fail + 1))
        else [ $show = 1 ] && echo "shallow $src $body: $got"; fi
        mf=$(stat "$src" --rt-mutant=67) || { fail=$((fail + 1)); continue; }
        mg=$(awk -v n="$body" '$1 == "shallow" && $2 == n' "$mf" | wc -l)
        if [ "$mg" -lt "$lo" ]; then echo "mutant 67 $src @shallow: $mg — caught"
        else echo "FAIL mutant 67 $src @shallow: $mg — not caught"; fail=$((fail + 1)); fi
        continue
    fi
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
