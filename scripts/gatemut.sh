#!/usr/bin/env bash
# gatemut（ゲートの高速化タスクR2 — report-1222）: M2宣言の網羅 — gatememoの主たる検査。ゲートごとに木をコピーし（.git・.pair・outの大物・記録は除く）、
# 鍵（共通の成分 + 入口 + scripts/gatedeps.txt の宣言）の外にある入力の候補（examples・testdata・bench・lean・docs・scripts・README）の全ファイルの末尾に
# マークを足して、コピーの上でゲートを走らせる（gates.sh --gate・--no-cache）。判定がPASSのままなら、ゲートは鍵の外の入力に依らない。
# FAILならコピーを元に戻して再走し、緑に戻れば「鍵の外の入力への依存」= 偽緑の種として特定（FAIL）。戻しても赤ならコピーの環境の問題（ENV）。
#   scripts/gatemut.sh [-P 並べる数] gate…    （ゲートの指定なし = gates.sh の --full の全部）
#   scripts/gatemut.sh --lines [gate…]  線の再判定の端から端の確認（下の節 — ゲートの指定なし = @lines の全部）
# 節目の明示のインターフェース（--fullには入れない — ナビ決定3）。所要 ≈ ゲート秒の和 / P + コピー1本 ≈ 10 s
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
P=3
[ "${1:-}" = -P ] && { P=$2; shift 2; }
# --lines（節目 — 柱1の再判定の端から端の確認）: 線を読むゲート（gatedeps.txt の @lines）ごとに、木の写しで
#   ① gates.sh --gate で走らせて記録を作る（一時の格納場所 GATEMEMO_SHARED — 本物の記録に混ぜない）
#   ② 記録の実測のある線を1行ずつ実測の直下へ下げ、gates.sh --gate が走らせずに FAIL（REJUDGE — 再判定の赤）になること
#      （鍵は gates.sh の中の道具の鍵と環境を含むので、gatememo.ts check を外から呼ばずに gates.sh を通す — 1行あたりビルドの確認の十数秒）
#   ③ 全部を下げた写しで gates.sh --gate が、走らせずに FAIL になること（要約の memo の行に re-judged red）
#   ④ 線を戻すと HIT に戻ること
if [ "${1:-}" = --lines ]; then
    shift
    gates=("$@")
    [ "${#gates[@]}" = 0 ] && read -ra gates <<< "$(sed -n 's/^@lines:\([^#]*\).*/\1/p' scripts/gatedeps.txt)"
    S=${GATEMUT_DIR:-$(mktemp -d)}
    c=$S/t-lines
    fail=0
    rsync -a --delete --exclude /.git --exclude /.pair --exclude /out/bench --exclude /out/inst --exclude /out/rust --exclude /out/skym \
        --exclude /scripts/.gatecache/logs --exclude /scripts/.gatecache/memo --exclude /scripts/.gatecache/failed "$ROOT/" "$c/"
    export GATEMEMO_SHARED=$S/shared NODE_NO_WARNINGS=1
    G=("node" "--experimental-strip-types" "$c/scripts/gatememo.ts")
    for g in "${gates[@]}"; do
        GATES_PREBUILT=1 "$c/scripts/gates.sh" --gate "$g" -j 1 --jobs 4 > "$S/$g.run1" 2>&1
        mapfile -t rows < <("${G[@]}" meas "$g" 2> /dev/null | awk '{ print $4, $5, $6, $7 }' | sort -u)
        if [ "${#rows[@]}" = 0 ]; then echo "FAIL $g: no record with measurements after a run ($(grep -a -m1 "  FAIL\|  PASS" "$S/$g.run1"))"; fail=$((fail + 1)); continue; fi
        ok=0
        for r in "${rows[@]}"; do
            read -r f it col v <<< "$r"
            cp "$c/$f" "$S/line.bak"
            low=$(awk -v v="$v" 'BEGIN { printf "%.6f", v / 2 - 1 }')
            awk -v k="$it" -v c="$col" -v n="$low" '!done && $1 !~ /^#/ && $1 == k && $2 == c { $3 = n; done = 1 } { print }' "$S/line.bak" > "$c/$f"
            GATES_PREBUILT=1 "$c/scripts/gates.sh" --gate "$g" -j 1 --jobs 4 > "$S/$g.row" 2>&1
            if grep -aq "re-judged red against the lines: $g" "$S/$g.row" && grep -aq "^  FAIL $g " "$S/$g.row"; then ok=$((ok + 1))
            else echo "FAIL $g: lowering $f $it $col below $v is not re-judged red: $(grep -a -m1 "^  [A-Z]* *$g " "$S/$g.row")"; fail=$((fail + 1)); fi
            cp "$S/line.bak" "$c/$f"
        done
        for r in "${rows[@]}"; do
            read -r f it col v <<< "$r"
            low=$(awk -v v="$v" 'BEGIN { printf "%.6f", v / 2 - 1 }')
            awk -v k="$it" -v c="$col" -v n="$low" '!done && $1 !~ /^#/ && $1 == k && $2 == c { $3 = n; done = 1 } { print }' "$c/$f" > "$S/line.tmp" && cp "$S/line.tmp" "$c/$f"
        done
        GATES_PREBUILT=1 "$c/scripts/gates.sh" --gate "$g" -j 1 --jobs 4 > "$S/$g.run2" 2>&1 && { echo "FAIL $g: all lines lowered but gates.sh passed"; fail=$((fail + 1)); }
        grep -aq "re-judged red against the lines: $g" "$S/$g.run2" || { echo "FAIL $g: all lines lowered but not re-judged without a run: $(grep -a -m1 'memo:' "$S/$g.run2")"; fail=$((fail + 1)); }
        rsync -a "$ROOT/bench/ratchet.txt" "$c/bench/ratchet.txt"; rsync -a "$ROOT/scripts/framestat.list" "$c/scripts/framestat.list"
        GATES_PREBUILT=1 "$c/scripts/gates.sh" --gate "$g" -j 1 --jobs 4 > "$S/$g.run3" 2>&1
        # HIT（抜き打ちに選ばれた回は、HIT から走らせ直した PASS — 要約の memo の行の「HIT re-run」）
        grep -aq "^  HIT  $g " "$S/$g.run3" || { grep -aq "HIT re-run: $g\b" "$S/$g.run3" && grep -aq "^  PASS $g " "$S/$g.run3"; } || { echo "FAIL $g: the restored lines are not HIT: $(grep -a -m1 "^  [A-Z]* *$g " "$S/$g.run3")"; fail=$((fail + 1)); }
        echo "lines $g: ${#rows[@]} lines — each lowered is REJUDGE ($ok), all lowered fails without a run, restored is HIT"
    done
    echo "gatemut --lines: ${#gates[@]} gates, fail=$fail (logs in $S)"
    [ "$fail" = 0 ]; exit
fi
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
        --exclude /scripts/.gatecache/logs --exclude /scripts/.gatecache/memo --exclude /scripts/.gatecache/failed "$ROOT/" "$1/"
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
