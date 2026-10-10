#!/usr/bin/env bash
# compiler/ の単体テスト（`sober test` — _test.sober を持つ package を全部。cwd = compiler/ — import は compiler/ 相対）と std の black-box テスト（testdata/stdtest）。
# 加えて各 package のテストのビルドが検査に通ること（check --test — analyzer → 検査器）。fail = 0 がゲート
set -uo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
SOBER=${SOBER:-$ROOT/bin/sober}
cd "$ROOT/src/compiler"
pkgs=()
for d in */; do
    d=${d%/}
    compgen -G "$d/*_test.sober" > /dev/null && pkgs+=("$d")
done
fail=0
[ "${#pkgs[@]}" -gt 0 ] || { echo "unittest: no package has _test.sober"; exit 1; }
for p in "${pkgs[@]}"; do
    "$SOBER" check "$p" --test > /dev/null || { echo "FAIL: check --test $p"; fail=1; }
done
"$SOBER" test "${pkgs[@]}" || fail=1
# std の black-box の表駆動テスト（testdata/stdtest — cwd = ルート。std の中に置くと import が循環する: 補間 → std/strings・std/testing → std/io → std/utf8）
cd "$ROOT"
spkgs=()
for d in testdata/stdtest/*/; do spkgs+=("${d%/}"); done
for p in "${spkgs[@]}"; do
    "$SOBER" check "$p" --test > /dev/null || { echo "FAIL: check --test $p"; fail=1; }
done
"$SOBER" test "${spkgs[@]}" || fail=1
echo "unittest: ${#pkgs[@]} compiler packages (${pkgs[*]}) + ${#spkgs[@]} std packages, fail=$fail"
[ "$fail" = 0 ]
