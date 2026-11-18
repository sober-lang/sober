#!/usr/bin/env bash
# 後段の関数キャッシュのプログラムをまたぐ検査: 例題の全部を1つの格納場所へ（std・rtの関数の値をほかのプログラムが書いたものから当てる）
# ゲートの外（例題の全部を回す）。鍵の素を変える変更（lower/ckey.sober・bcache.sober）のときに手で回す。ゲートではcacheauditのプログラムをまたぐ相が題材5本で同じ照合をする
# 検証モード（SOBER_CACHE_VERIFY=1。当たりでも作り直して値をバイトで比べ、違えば `cache: stale entry` で落ちる）でビルドし、
#   ① stale が1つも無いこと（鍵に入れていないプログラム全体の事実に、関数の値が依っていない）
#   ② 各ELFがキャッシュ無効のビルドとバイト一致すること
#   ③ 当たりが実際に出ていること: 新しい格納場所でweb_server_helloを温め、http_arenaをビルドしたときのβ2（機械語）の当たり > 0
#     （検証モードは当たりも作り直すので当否を数えない。この相は通常のモード。印字 `cachecross: … cross beta2 <当たり>/<全>`）
# を見る。キャッシュ無効でビルドできない例題（負例）は飛ばす。並びは名前の順で、CROSS_PAR本ずつ同時に回す（書きはtmp + renameで原子的。
# 検証モードは当否の順に依らず全部の当たりを照合する）。
#   使い方: scripts/cachecross.sh [<例題>…]（既定は examples/*.sober の全部）・CROSS_COMPILER = 検査するコンパイラ（既定 stage2）・
#   CROSS_PAR（既定8）
set -uo pipefail
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
if [ -z "${CROSS_COMPILER:-}" ]; then
    scripts/stage2.sh --quiet || exit 1
fi
C=${CROSS_COMPILER:-$ROOT/out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
unset SOBER_SELF_KEY SOBER_VERIFY SOBER_CACHE_STAT
export SOBER_HASH_SEED=0 SOBER_WORKERS=1
if [ $# -gt 0 ]; then ES=("$@"); else ES=(examples/*.sober); fi
mkdir -p "$W/o" "$W/r"
export C W ROOT
one() {
    local e=$1 n
    n=$(basename "$e" .sober)
    ( cd "$ROOT" && SOBER_BUILD_CACHE=0 timeout 120 "$C" build "$e" -o "$W/o/$n.off" > /dev/null 2>&1 ) || { echo skip > "$W/r/$n"; return 0; }
    ( cd "$ROOT" && SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=1 SOBER_CACHE_STAT=1 timeout 300 "$C" build "$e" -o "$W/o/$n.on" > /dev/null 2> "$W/o/$n.err" )
    local ec=$?
    if grep -q 'cache: stale entry' "$W/o/$n.err"; then echo "stale $(grep -m1 'cache: stale entry' "$W/o/$n.err")" > "$W/r/$n"; return 0; fi
    if [ "$ec" != 0 ]; then echo "fail exit $ec: $(grep -m1 . "$W/o/$n.err")" > "$W/r/$n"; return 0; fi
    if ! cmp -s "$W/o/$n.off" "$W/o/$n.on"; then echo "diff ELF differs from the build without the cache" > "$W/r/$n"; return 0; fi
    echo "ok $(grep -m1 '^cache: alpha' "$W/o/$n.err")" > "$W/r/$n"
    rm -f "$W/o/$n.off" "$W/o/$n.on"
}
export -f one
printf '%s\n' "${ES[@]}" | xargs -P "${CROSS_PAR:-8}" -I{} bash -c 'one "$@"' _ {}
bad=0
for f in "$W"/r/*; do
    case "$(cut -d' ' -f1 "$f")" in
        ok|skip) ;;
        *) echo "cachecross: FAIL $(basename "$f"): $(cat "$f")"; bad=1 ;;
    esac
done
# ③ 別のプログラムで温めた格納場所での当たり
for e in web_server_hello http_arena; do
    SOBER_CACHE=$W/x SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 "$C" build "examples/$e.sober" -o "$W/x.elf" > /dev/null 2> "$W/x.err" || { echo "cachecross: FAIL cross build $e: $(grep -m1 . "$W/x.err")"; bad=1; }
done
sum=$(awk '/^cache: alpha/ { for (i = 2; i <= NF; i++) if ($i == "beta2") print $(i + 1) }' "$W/x.err")
sum=${sum:-0/0}
nok=$(grep -l '^ok' "$W"/r/* 2>/dev/null | wc -l)
nskip=$(grep -l '^skip' "$W"/r/* 2>/dev/null | wc -l)
h=${sum%/*}
[ "$h" -gt 0 ] || { echo "cachecross: FAIL no beta2 hit across programs"; bad=1; }
echo "cachecross: ok=$nok skip=$nskip cross beta2 $sum fail=$bad"
exit $bad
