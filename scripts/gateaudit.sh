#!/usr/bin/env bash
# gateaudit（ゲートの高速化便 R2 — report-1222）: 宣言の監査 — 開発時の道具で、鍵の経路には入れない（ナビ裁定 2026-10-27 — openat が io_uring に
# 載ると syscall の観測は黙って欠ける。網羅の主の網は scripts/gatemut.sh の変異）。ゲートを strace の下で 1 本ずつ走らせ（gates.sh --gate・--no-cache）、
# 木の中の読みのうち鍵（共通の成分 + 入口 + scripts/gatedeps.txt の宣言）が覆わないものと、読んだ testdata の 1 段目を出す（宣言を詰める材料）。
#   scripts/gateaudit.sh [-P 並べる数] gate…
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
P=1
[ "${1:-}" = -P ] && { P=$2; shift 2; }
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
one() {
    local g=$1
    # gates.sh の共有ビルドの読みも混ざるが、鍵の共通の成分（stage1・stage2・道具）か AUDIT_IGNORE に落ちる
    strace -f -qq -y --seccomp-bpf -e trace=%file -o "$W/$g.st" scripts/gates.sh --no-cache --gate "$g" -j 1 --jobs 4 > "$W/$g.log" 2>&1
    local st=PASS
    grep -q 'gates: ALL PASS' "$W/$g.log" || st=FAIL
    { echo "== $g ($st under strace)"; NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/gatememo.ts audit "$g" "$W/$g.st"; } > "$W/$g.out"
    rm -f "$W/$g.st"
}
for g in "$@"; do
    while [ "$(jobs -rp | wc -l)" -ge "$P" ]; do wait -n || true; done
    one "$g" &
done
wait
for g in "$@"; do cat "$W/$g.out"; done
