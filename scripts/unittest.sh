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
SOBER_TEST_RT_MUTANT=129 "$SOBER" test --fresh --run TestDieAfterFin std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant 129 (posting a stream child's last signal does not clear its death mark) was not caught by TestDieAfterFin"; fail=1; }
# 要求の塊の持ち主（照合のbuild 161〜163 — 持ち主以外が返す・持ち主の終わりより前に返る・渡した塊が子へ移らないとexit 103）: 161（照合だけ）はHTTP/2とmuxのテストが全部通る。
# 162（参照を渡した直後に返す）・163（task_newが親の渡しを消さない）は照合が止め、164（taskの終わりで返さない）はTestBlobOwnの溜めの数えが捕まえる
SOBER_TEST_RT_MUTANT=161 "$SOBER" test --fresh std/internal/mux std/http/server > /dev/null 2>&1 || { echo "FAIL: blob owner check build 161 broke std/internal/mux or std/http/server"; fail=1; }
for m in 162 163; do
    o=$(SOBER_TEST_RT_MUTANT=$m "$SOBER" test --fresh --run TestBlobOwn std/internal/mux 2>&1)
    [[ "$o" == *"exit 103"* ]] || { echo "FAIL: mutant $m (blob owner) was not stopped by the check build"; fail=1; }
done
# 直の受け（昇格前の子の終わりの合図を直の列へ）: 子を先に走らせる配置はM:Nにだけあるので、ワーカー4で走らせる（ゲートの既定はワーカー1）。
# 165 = 終わりを兼ねない合図も直の列へ・166 = 列より先に直の列を取る
SOBER_WORKERS=4 "$SOBER" test --run TestDirect std/internal/mux > /dev/null 2>&1 || { echo "FAIL: TestDirect* (direct list) failed with SOBER_WORKERS=4"; fail=1; }
SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=165 "$SOBER" test --fresh --run TestDirectPromote std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant 165 (a non-final signal goes to the direct list) was not caught by TestDirectPromote"; fail=1; }
SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=166 "$SOBER" test --fresh --run TestDirectOrder std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant 166 (take reads the direct list before the locked list) was not caught by TestDirectOrder"; fail=1; }
# 遅延task化（lazy.sober — M:Nだけ）: 照合のbuild 167（昇格前の子が待てば終了コード103）でmuxとhttpのサーバーが通る。
# 168 = rt.sleepで昇格せずに待つ（167が止める）・171 = 昇格で生きている子の数を足さない（scopeの出口が待たない）
SOBER_WORKERS=4 "$SOBER" test --run TestLazy std/internal/mux > /dev/null 2>&1 || { echo "FAIL: TestLazy* failed with SOBER_WORKERS=4"; fail=1; }
SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=167 "$SOBER" test --fresh std/internal/mux std/http/server > /dev/null 2>&1 || { echo "FAIL: lazy check build 167 broke std/internal/mux or std/http/server"; fail=1; }
o=$(SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=168 "$SOBER" test --fresh --run TestLazyRegion std/internal/mux 2>&1)
[[ "$o" == *"exit 103"* ]] || { echo "FAIL: mutant 168 (a lazy child sleeps without promotion) was not stopped by the check build"; fail=1; }
SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=171 "$SOBER" test --fresh --run TestLazyScopeWait std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant 171 (promotion does not count the live child) was not caught by TestLazyScopeWait"; fail=1; }
# 子の死の道・隠す / 戻す / 移す・出力の区間: 170 = 死んだ子を返った点の速いパスへ（TestLazyDie）・172 = fdの連なりが残る子を速いパスへ（TestLazyFdLeft）・
# 174 = 昇格で隠した分の移しを1深度ずらす（TestLazyRegion）・175 = 昇格で子の区間を切り出さない（TestLazyOutの印字の順）・
# 176 = spawnの点で隠さない（TestLazyRegion）・177 = 返った点で戻さない（TestLazyRegionPar — 戻さないスロットをほかの親の子が取る）
lzo=$(SOBER_WORKERS=4 "$SOBER" test --run TestLazyOut std/internal/mux 2>/dev/null | grep '^lazyout' | tr '\n' ' ')
[ "$lzo" = "$(for i in 1 2 3 4; do printf 'lazyout k1 lazyout k2 lazyout p1 lazyout p2 '; done)" ] || { echo "FAIL: TestLazyOut printed out of order: $lzo"; fail=1; }
lzo=$(SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=175 "$SOBER" test --fresh --run TestLazyOut std/internal/mux 2>/dev/null | grep '^lazyout' | tr '\n' ' ')
[ "$lzo" = "$(for i in 1 2 3 4; do printf 'lazyout k1 lazyout k2 lazyout p1 lazyout p2 '; done)" ] && { echo "FAIL: mutant 175 (promotion does not split the output segment) was not caught by the TestLazyOut order"; fail=1; }
for mt in 170:TestLazyDie 172:TestLazyFdLeft 174:TestLazyRegion 176:TestLazyRegion 177:TestLazyRegionPar; do
    SOBER_WORKERS=4 SOBER_TEST_RT_MUTANT=${mt%%:*} "$SOBER" test --fresh --run ${mt#*:} std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant ${mt%%:*} (lazy child) was not caught by ${mt#*:}"; fail=1; }
done
SOBER_TEST_RT_MUTANT=164 "$SOBER" test --fresh --run TestBlobOwn std/internal/mux > /dev/null 2>&1 && { echo "FAIL: mutant 164 (a task end does not return its blob) was not caught by TestBlobOwn"; fail=1; }
echo "unittest: ${#pkgs[@]} compiler packages (${pkgs[*]}) + ${#spkgs[@]} std packages + ${#ipkgs[@]} std white-box (${ipkgs[*]}), fail=$fail"
[ "$fail" = 0 ]
