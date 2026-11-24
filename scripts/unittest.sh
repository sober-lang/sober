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
# stdの中の _test.sober（white-box — stdの内側の実装〔std/internal/…〕を見る検査: std/tlsのhsの拒否・Goとの往復の再生・状態機械。cwd = ルート — @embedはルート相対）
ipkgs=()
for d in $(cd "$ROOT/src" && find std -name '*_test.sober' -printf '%h\n' | sort -u); do ipkgs+=("$d"); done
for p in "${ipkgs[@]}"; do
    "$SOBER" check "$p" --test > /dev/null || { echo "FAIL: check --test $p"; fail=1; }
done
[ "${#ipkgs[@]}" -eq 0 ] || "$SOBER" test "${ipkgs[@]}" || fail=1
# ミュータント112（lease_op 12がTLSの受けの持ち越しの席を格納場所の深度でなく今の深度に確保する）をstd/tlsのTestNetConnが捕まえる
SOBER_TEST_RT_MUTANT=112 "$SOBER" test --fresh --run TestNetConn std/tls > /dev/null 2>&1 && { echo "FAIL: mutant 112 (lease_op 12 allocates the TLS carry seat at the current depth) was not caught by TestNetConn"; fail=1; }
SOBER_TEST_RT_MUTANT=114 "$SOBER" test --fresh --run TestH2Conns std/http/server > /dev/null 2>&1 && { echo "FAIL: mutant 114 (a plain spawn counts a task on the pool node — conns: fills with HTTP/2 stream children) was not caught by TestH2Conns"; fail=1; }
SOBER_TEST_RT_MUTANT=113 "$SOBER" test --fresh --run TestH2ChildDeath std/http/server > /dev/null 2>&1 && { echo "FAIL: mutant 113 (a dead HTTP/2 stream child does not set its dead-slot bit) was not caught by TestH2ChildDeath"; fail=1; }
echo "unittest: ${#pkgs[@]} compiler packages (${pkgs[*]}) + ${#spkgs[@]} std packages + ${#ipkgs[@]} std white-box (${ipkgs[*]}), fail=$fail"
[ "$fail" = 0 ]
