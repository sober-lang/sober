#!/usr/bin/env bash
# sortcheck（std/sort の乱択の検査 — report-619）: testdata/sortcheck を最適化のバックエンド（--passes）と最適化なし（--no-opt）で建てて 2 回ずつ走らせ、
# 失敗の数が 0（Order = 並び・安定・置換・OrderUnstable = 並び・置換・同じ呼び出しの 2 回の一致・壊れた less でも置換）で、4 つの出力が全部一致すること
# （最後の行 = OrderUnstable の結果の検査和 — 決定性: 走りごと・最適化の有無で変わらない）
#   scripts/sortcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_WORKERS=1
fail=0
"$S2" build testdata/sortcheck/main.sober --emit=elf --passes -o "$W/opt" > /dev/null || { echo "sortcheck: FAIL build (--passes)"; exit 1; }
"$S2" build testdata/sortcheck/main.sober --emit=elf --no-opt -o "$W/noopt" > /dev/null || { echo "sortcheck: FAIL build (--no-opt)"; exit 1; }
chmod +x "$W/opt" "$W/noopt"
for v in opt noopt; do
    for r in 1 2; do
        timeout -s KILL 120 "$W/$v" > "$W/$v.$r" 2>&1 || { echo "FAIL run $v $r"; fail=$((fail + 1)); }
    done
done
f=$(sed -n 2p "$W/opt.1")
[ "$f" = 0 ] || { echo "FAIL: $f failing cases"; grep FAIL "$W/opt.1" | head -5; fail=$((fail + 1)); }
for x in opt.2 noopt.1 noopt.2; do
    cmp -s "$W/opt.1" "$W/$x" || { echo "FAIL: output of $x differs from opt.1 (determinism)"; fail=$((fail + 1)); }
done
echo "sortcheck: $(sed -n 1p "$W/opt.1") cases × {--passes, --no-opt} × 2 runs — order / stability / permutation / determinism (checksum $(sed -n 3p "$W/opt.1")), fail=$fail"
[ $fail = 0 ]
