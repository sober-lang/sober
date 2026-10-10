#!/usr/bin/env bash
# 観測等価ランナー（V5-1 C2 — バックエンド戦略の差分オラクルの器）。
#
#   scripts/obs.sh [--backend NAME] [name...]
#
# examples/<name>.sober を指定のバックエンドで build・実行し、観測値 (stdout, exit code) を
# 期待値 examples/<name>.out と examples/<name>.exit（無ければ 0）に照合する。name 省略時は .out を持つ全例。
# name が / を含むとディレクトリ entry（複数 package の例 — testdata/minic/app 等）で、期待値は <dir>.out / <dir>.exit。
# 省略時は testdata/*/app.out を持つ entry も回す。
# 観測は「バイナリ一致」でなく stdout + 終了コード（ABI を揃えない裁定の帰結 — docs/design-dev.md バックエンド戦略）。
# panic の exit 101 / 102 も観測値 — UB 遮断の規約（明示チェックを吐く）はここでしか見えない。
#
# バックエンドは build_<NAME> 関数で足す（引数: ソース・出力パス）:
#   default 既定経路（sober build — IR → IR パス → linear scan → 自前エンコーダ → ELF。Sober の正規バックエンド — B-4。AST 直吐きの codegen は B-9b で退役）
#   llvm    IR 経路（sober build --emit=ll → zig cc -O0）
#   llvm2   同じ .ll を -O2 で（-O0 と食い違えば吐いた IR から UB が漏れている兆候）
#   ir-x86raw  既定経路の IR パス無し（mem2reg 前の形 — スロットが多くブロック引数が少ない、割り当ての違う面を突く）
#   sober   既定の IR パスなし（--no-opt — B-1d の綴りの名残。scripts/elfeq.sh が回す）
#   stage1  凍結した Zig の正規バックエンド（--via=stage1 — B-4 までの既定。逃げ道と照合の役）
# IR 経路は到達した例だけを回す: scripts/obs-llvm.list（1 行 1 例、# はコメント）を
# `scripts/obs.sh --backend llvm $(grep -v '^#' scripts/obs-llvm.list)` の形で渡す。
#
# 実行の cwd はリポのルート（io 例が testdata/ を相対 path で読み、out/ に書く）。
set -uo pipefail
cd "$(dirname "$0")/.."

SOBER=${SOBER:-./bin/sober}   # 主の sober（主役交代 R39）。凍結した Zig 版の列は SOBER=src/stage1/zig-out/bin/sober（gates の obs_zig）
backend=default
OBS_TIMEOUT=${OBS_TIMEOUT:-60}   # 1 例の実行の上限（秒）— 最も遅い例でも数秒
if [ "${1:-}" = "--backend" ]; then backend=$2; shift 2; fi

build_default() { "$SOBER" build "$1" -o "$2"; }
ZIG=${ZIG:-zig}
ll_cc() { "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module "$@"; }
build_llvm()  { "$SOBER" build "$1" --emit=ll -o "$2.ll" && ll_cc -O0 "$2.ll" -o "$2"; }
build_llvm2() { "$SOBER" build "$1" --emit=ll -o "$2.ll" && ll_cc -O2 "$2.ll" -o "$2"; }
build_ir-x86raw() { "$SOBER" build "$1" --no-opt -o "$2"; }
build_sober() { "$SOBER" build "$1" --no-opt -o "$2"; }
build_stage1() { "$SOBER" build "$1" --via=stage1 -o "$2"; }

declare -F "build_$backend" >/dev/null || { echo "obs: unknown backend '$backend'"; exit 2; }

if [ $# -eq 0 ]; then
    set -- $(for f in examples/*.out; do basename "$f" .out; done) $(for f in testdata/*/app.out; do echo "${f%.out}"; done)
fi

W=$(mktemp -d)
fail=0
ran=0
for n in "$@"; do
    case "$n" in
        */*) src=$n; exp=$n ;;
        *) src=examples/$n.sober; exp=examples/$n ;;
    esac
    k=$(echo "$n" | tr '/' '_')
    want_exit=0
    [ -f "$exp.exit" ] && want_exit=$(tr -d ' \n' < "$exp.exit")
    if ! "build_$backend" "$src" "$W/$k" > /dev/null 2> "$W/$k.err"; then
        echo "BUILD FAIL [$backend] $n: $(head -3 "$W/$k.err")"
        fail=1
        continue
    fi
    # 標準入力 = 例の .in があればそれ・無ければ /dev/null（ReadStdin / ReadFd の例）
    inp=/dev/null
    [ -f "$exp.in" ] && inp=$exp.in
    # 上限つきで走らせる（ハングを FAIL に — 無いと gates が止まったまま返らない で 20 分。SIGTERM を受けない形もあるので KILL）
    timeout -s KILL "$OBS_TIMEOUT" "$W/$k" > "$W/$k.got" 2> /dev/null < "$inp"
    got_exit=$?
    ran=$((ran + 1))
    if [ "$got_exit" = 137 ] && [ "$want_exit" != 137 ]; then
        echo "TIMEOUT [$backend] $n: ${OBS_TIMEOUT}s"
        fail=1
        continue
    fi
    if ! diff -q "$W/$k.got" "$exp.out" > /dev/null; then
        echo "STDOUT DIFF [$backend] $n"
        fail=1
    fi
    if [ "$got_exit" != "$want_exit" ]; then
        echo "EXIT DIFF [$backend] $n: got $got_exit want $want_exit"
        fail=1
    fi
done
rm -r "$W"
echo "obs [$backend]: $ran run, fail=$fail"
exit $fail
