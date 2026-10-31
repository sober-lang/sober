#!/usr/bin/env bash
# gatemut（ゲートの高速化便 R2 — report-1222）: M2 宣言の網羅 — gatememo の主の網。ゲートごとに木を写し（.git・.pair・out の大物・記録は除く）、
# 鍵（共通の成分 + 入口 + scripts/gatedeps.txt の宣言）の外にある入力の候補（examples・testdata・bench・lean・docs・scripts・README）の全ファイルの末尾に
# 印を足して、写しの上でゲートを走らせる（gates.sh --gate・--no-cache）。判定が PASS のままなら、ゲートは鍵の外の入力に依らない。
# FAIL なら写しを元に戻して再走し、緑に戻れば「鍵の外の入力への依存」= 偽緑の種として名指し（FAIL）。戻しても赤なら写しの環境の問題（ENV）。
#   scripts/gatemut.sh [-P 並べる数] gate…    （ゲートの指定なし = gates.sh の --full の全部）
# 節目の明示の口（--full には入れない — ナビ裁定 3）。所要 ≈ ゲート秒の和 / P + 写し 1 本 ≈ 10 s
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
P=3
[ "${1:-}" = -P ] && { P=$2; shift 2; }
gates=("$@")
if [ "${#gates[@]}" = 0 ]; then
    mapfile -t gates < <(sed -n 's/^ORDER=(\(.*\))$/\1/p' scripts/gates.sh | tr ' ' '\n' | grep -vx 'zigtest\|obs_zig\|hermetic_zig\|ir_roundtrip\|gatememo\|tyorder')
fi
S=${GATEMUT_DIR:-$(mktemp -d)}
R=$S/res
mkdir -p "$R"
copy() { # copy <置き場> — 写しの木（ゲートの実行に要るビルドの出力 out/stage2・道具・zig-out・Lean の sober-check は含める）
    mkdir -p "$1"
    rsync -a --delete --exclude /.git --exclude /.pair --exclude /out/bench --exclude /out/inst --exclude /out/rust --exclude /out/skym \
        --exclude /scripts/.gatecache/logs --exclude /scripts/.gatecache/memo "$ROOT/" "$1/"
}
one() {
    local g=$1 c=$S/t-$1 st
    rm -rf "$c"
    copy "$c"
    NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts mutate "$g" "$c" > "$R/$g.mut"
    if GATES_PREBUILT=1 "$c/scripts/gates.sh" --no-cache --gate "$g" -j 1 --jobs 4 > "$R/$g.log" 2>&1; then
        st=ok
    else
        copy "$c"   # 元に戻して再走（rsync は印を足したファイルを元の中身に戻し、--delete で足したファイルを消す）
        if GATES_PREBUILT=1 "$c/scripts/gates.sh" --no-cache --gate "$g" -j 1 --jobs 4 > "$R/$g.ctl" 2>&1; then st=FAIL; else st=ENV; fi
    fi
    echo "$st $g $(cat "$R/$g.mut" | sed 's/^gatemut: [^:]*: //')" > "$R/$g.st"
    rm -rf "$c"
}
for g in "${gates[@]}"; do
    while [ "$(jobs -rp | wc -l)" -ge "$P" ]; do wait -n || true; done
    one "$g" &
done
wait
fail=0
for g in "${gates[@]}"; do
    cat "$R/$g.st"
    case "$(cut -d' ' -f1 "$R/$g.st")" in
        FAIL) fail=$((fail + 1)); grep -a 'FAIL' "$R/$g.log" | head -3 | sed 's/^/    /' ;;
        ENV) fail=$((fail + 1)); grep -a 'FAIL' "$R/$g.ctl" | head -3 | sed 's/^/    /' ;;
    esac
done
echo "gatemut: ${#gates[@]} gates, fail=$fail (logs in $R)"
[ "$fail" = 0 ]
