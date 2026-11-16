#!/usr/bin/env bash
# segvcheck: rt.segv（SIGSEGVの口）の判定の検査。題材 = testdata/segvcheck/main.sober（枠の大きい再帰）。
#   ① 子のtaskの深い再帰はStackExceededのtaskの死（死因を印字する開発用のビルド --rt-mutant=14で、102と `panic: StackExceeded{}`）。
#      通常のビルドでは、死は罠で受けられ、プロセスは0で終わる
#   ② mainのtaskの深い再帰は `panic: StackExceeded{}` で102（プロセスのスタックの下端の判定）
#   ③ 計測用のミュータント97（罠の中で番地8を読む子）は、巻き戻らずにSIGSEGVで終わり（終了状態139）、標準エラーの1行目が
#      `fatal: invalid memory access at 0x0000000000000008 (pc 0x…)`、2行目が処理系の不具合の文面（ワーカー1と8の両方）
#   scripts/segvcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# ③はコアダンプを作るので、この検査の中では作らない。core_patternがパイプのときカーネルはRLIMIT_COREの0を見ないが、
# 1バイトの上限はパイプでもファイルでもダンプを書かない（ulimit -cの単位はブロックなので1バイトを指定できない）
prlimit --pid $$ --core=1:1 2>/dev/null || ulimit -c 0
fail=0
src=testdata/segvcheck/main.sober
"$S2" build "$src" -o "$W/sv" > "$W/b.log" 2>&1 || { echo "segvcheck: FAIL build: $(tail -c 300 "$W/b.log")"; exit 1; }
"$S2" build "$src" --rt-mutant=14 -o "$W/sv14" > "$W/b14.log" 2>&1 || { echo "segvcheck: FAIL build mutant 14: $(tail -c 300 "$W/b14.log")"; exit 1; }
"$S2" build "$src" --rt-mutant=97 -o "$W/sv97" > "$W/b97.log" 2>&1 || { echo "segvcheck: FAIL build mutant 97: $(tail -c 300 "$W/b97.log")"; exit 1; }

for w in 1 8; do
    # ① 通常のビルド: 子の死は罠で受けられる
    SOBER_WORKERS=$w "$W/sv" task > "$W/o" 2> "$W/e"; ec=$?
    [ $ec = 0 ] || { echo "segvcheck: FAIL W$w task: exit $ec: $(head -c 200 "$W/e")"; fail=1; }
    # ① 死因: StackExceeded
    SOBER_WORKERS=$w "$W/sv14" task > "$W/o" 2> "$W/e"; ec=$?
    if [ $ec != 102 ] || [ "$(head -n 1 "$W/e")" != "panic: StackExceeded{}" ]; then
        echo "segvcheck: FAIL W$w task (mutant 14): exit $ec: $(head -c 200 "$W/e")"; fail=1
    fi
    # ② mainのtask
    SOBER_WORKERS=$w "$W/sv" main > "$W/o" 2> "$W/e"; ec=$?
    if [ $ec != 102 ] || [ "$(head -n 1 "$W/e")" != "panic: StackExceeded{}" ]; then
        echo "segvcheck: FAIL W$w main: exit $ec: $(head -c 200 "$W/e")"; fail=1
    fi
    # ③ 不正なアクセス: 巻き戻らず、SIGSEGVで終わる
    # シェルの「Segmentation fault」の通知は捨てる（子のシェルの標準エラー）
    { SOBER_WORKERS=$w "$W/sv97" > "$W/o" 2> "$W/e"; ec=$?; } 2> /dev/null
    l1=$(sed -n 1p "$W/e")
    l2=$(sed -n 2p "$W/e")
    if [ $ec != 139 ] || ! [[ $l1 =~ ^fatal:\ invalid\ memory\ access\ at\ 0x0000000000000008\ \(pc\ 0x[0-9a-f]{16}\)$ ]] || ! [[ $l2 == "fatal: this is a bug in the Sober compiler or runtime, not in the program (sober "*")"* ]]; then
        echo "segvcheck: FAIL W$w mutant 97: exit $ec (want 139 = SIGSEGV): $(head -c 300 "$W/e")"; fail=1
    fi
    [ -s "$W/o" ] && { echo "segvcheck: FAIL W$w mutant 97: the program kept running ($(head -c 100 "$W/o"))"; fail=1; }
done
echo "segvcheck: stack overflow of a child task and of main = StackExceeded, invalid access (mutant 97) = SIGSEGV with the fatal line, W1 and W8, fail=$fail"
exit $fail
