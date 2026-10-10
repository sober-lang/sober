#!/usr/bin/env bash
# argv の実行照合（R31 — std/os.Args）。obs.sh 等の実行ハーネスは引数を渡さない（examples/io_args.out は引数なしの形）ので、
# 引数つきの観測（stdout + 終了コード）はここで見る。既定経路と IR → LLVM 経路（zig cc -O0）と `sober run`（build + 実行の一手 — 引数と終了コードの
# 透過）の 3 本。末尾で `sober run` の標準入力の継ぎも見る（examples/io_stdin）。
# Sober 版 lower の .ll は selfhost_ll.sh が Zig 版とのバイト一致で見ている（ランタイムの read_args を含む）ので、ここでは回さない。
#
#   scripts/io_args.sh
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}   # 主の sober（主役交代 R39）
ZIG=${ZIG:-zig}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# sober run の置き場はこの走りの一時ディレクトリ（利用者の置き場を汚さない）
export SOBER_CACHE=$W/cache
fail=0
ran=0

"$SOBER" build examples/io_args.sober -o "$W/default" || { echo "io_args: BUILD FAIL default"; exit 1; }
"$SOBER" build examples/io_args.sober --emit=ll -o "$W/a.ll" && "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module -O0 "$W/a.ll" -o "$W/llvm" \
    || { echo "io_args: BUILD FAIL llvm"; exit 1; }

# check <期待の終了コード> <期待の stdout> -- 引数...
check() {
    local want_exit=$1 want=$2 b got ec
    shift 3
    for b in default llvm run; do
        if [ "$b" = run ]; then
            got=$("$SOBER" run examples/io_args.sober -- "$@")
        else
            got=$("$W/$b" "$@")
        fi
        ec=$?
        ran=$((ran + 1))
        if [ "$got" != "$want" ] || [ "$ec" != "$want_exit" ]; then
            echo "FAIL [$b] args=($*): exit $ec (want $want_exit)"
            diff <(printf '%s\n' "$want") <(printf '%s\n' "$got") | head -10
            fail=1
        fi
    done
}

check 0 "0 args" --
check 0 "$(printf '4 args\n[1] a (1 bytes)\n[2] héllo (6 bytes)\n[3]  (0 bytes)\n[4] x y (3 bytes)')" -- a "héllo" "" "x y"
# 不正な UTF-8（0xff）: 全体が utf8.InvalidUtf8、pos は引数の中の位置
check 2 "invalid utf-8 at 1" -- ok "z$(printf '\xff')"
# 多数の引数（region の先端で連続して積む — 1,000 個）
many=$(seq 1 1000)
check 0 "$(printf '1000 args'; for i in $many; do printf '\n[%d] %d (%d bytes)' "$i" "$i" "${#i}"; done)" -- $many

# sober run: 置き場には 1 本だけ（4 回とも同じ鍵 — 2 回目からは build を飛ばす）・標準入力を子が継ぐ
n=$(ls "$W/cache/sober-run" 2> /dev/null | wc -l)
[ "$n" = 1 ] || { echo "FAIL [run]: $n executables in the cache (want 1 — same key)"; fail=1; }
if ! "$SOBER" run examples/io_stdin.sober < examples/io_stdin.in | cmp -s - examples/io_stdin.out; then
    echo "FAIL [run]: examples/io_stdin with examples/io_stdin.in"; fail=1
fi
ran=$((ran + 1))

echo "io_args: $ran runs, fail=$fail"
exit $fail
