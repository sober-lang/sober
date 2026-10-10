#!/usr/bin/env bash
# std/json の網（JSONTestSuite — testdata/jsontestsuite/test_parsing・nst/JSONTestSuite 1ef36fa・MIT）:
#   ① 全 318 ケースの受理 / 拒否が testdata/jsontestsuite/expect.txt と一致（i_ = 実装裁量の Sober の判定もここに固定 — docs/language.md 16 節の表）
#   ② 不変条件: n_ は全部拒否・y_ は全部受理（例外 = 重複キーの 2 件 — 防御の既定で拒否。16 節）
#   ③ 受理したものは印字の不動点（Parse → Format → Parse → Format が同じ — 検査は check/main.sober の中）
#   ④ shape[T] の T が別 package の struct（testdata/jsonpkg — 合成ファイルの参照名の import）: 実行の出力が app.out と一致
#   --regen: expect.txt を書き直す（緑の木からだけ）・--go: Go encoding/json の判定と並べて表示（scripts/oracles/jsonsuite.go）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
D=testdata/jsontestsuite
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
"$SOBER" build -o "$W/check" "$D/check/main.sober" > /dev/null || { echo "jsonsuite: FAIL build"; exit 1; }
for f in "$D"/test_parsing/*.json; do
    r=$(timeout 10 "$W/check" < "$f" 2>&1)
    echo "$(basename "$f") ${r%% *}"
done > "$W/got"
if [ "${1:-}" = --regen ]; then cp "$W/got" "$D/expect.txt"; echo "jsonsuite: regenerated $D/expect.txt ($(wc -l < "$W/got") cases)"; exit 0; fi
if [ "${1:-}" = --go ]; then (cd scripts/oracles && go run jsonsuite.go "$OLDPWD/$D"/test_parsing/*.json) > "$W/go"; join "$W/got" "$W/go" | awk '{print $1, "sober=" $2, "go=" $3}'; exit 0; fi
fail=0
diff "$D/expect.txt" "$W/got" > "$W/diff" || { echo "FAIL: decisions differ from expect.txt"; head -20 "$W/diff"; fail=1; }
grep -E '^n_' "$W/got" | grep -v ' reject$' | sed 's/^/FAIL: n_ accepted: /' && fail=1
grep -E '^y_' "$W/got" | grep -v ' ok$' | grep -v '^y_object_duplicated_key' | sed 's/^/FAIL: y_ rejected: /' && fail=1
grep -E ' roundtrip' "$W/got" | sed 's/^/FAIL: roundtrip: /' && fail=1
"$SOBER" build -o "$W/app" testdata/jsonpkg/app > /dev/null && "$W/app" > "$W/app.out" && diff testdata/jsonpkg/app.out "$W/app.out" > /dev/null || { echo "FAIL: testdata/jsonpkg/app"; fail=1; }
echo "jsonsuite: $(wc -l < "$W/got") cases ($(grep -c ' ok$' "$W/got") ok / $(grep -c ' reject$' "$W/got") reject), fail=$fail"
[ "$fail" = 0 ]
