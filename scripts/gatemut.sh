#!/usr/bin/env bash
# gatemut（ゲートの高速化タスクR2 — report-1222）: M2宣言の網羅 — gatememoの主たる検査。ゲートごとに木をコピーし（.git・.pair・outの大物・記録は除く）、
# 鍵（共通の成分 + 入口 + scripts/gatedeps.txt の宣言）の外にある入力の候補（examples・testdata・bench・lean・docs・scripts・README）の全ファイルの末尾に
# マークを足して、コピーの上でゲートを走らせる（gates.sh --gate・--no-cache）。判定がPASSのままなら、ゲートは鍵の外の入力に依らない。
# FAILならコピーを元に戻して再走し、緑に戻れば「鍵の外の入力への依存」= 偽緑の種として特定（FAIL）。戻しても赤ならコピーの環境の問題（ENV）。
#   scripts/gatemut.sh [-P 並べる数] gate…    （ゲートの指定なし = gates.sh の --full の全部）
# 節目の明示のインターフェース（--fullには入れない — ナビ決定3）。所要 ≈ ゲート秒の和 / P + コピー1本 ≈ 10 s
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
copy() { # copy <格納場所> — コピーの木（ゲートの実行に要るビルドの出力out/stage2・道具・zig-out・Leanのsober-checkは含める）
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
        copy "$c"   # 元に戻して再走（rsyncはマークを足したファイルを元の中身に戻し、--deleteで足したファイルを消す）
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
