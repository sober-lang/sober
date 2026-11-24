#!/usr/bin/env bash
# pkgfin（D1 — package ごとの仕上げ・loader/pkgfin.sober）: package P を「P が推移的に import する package は宣言の木（関数の本体を外した木）・
# P はソース」で finish に掛けた結果（木と Program の行）が、全体で回した結果とバイトで同じこと（下流の使い方で決まる dest の本体の旗を除く —
# 全体の段 destPatch が足す）。SOBER_PKGFIN_VERIFY=1 の build が全 package について比べ、`#pkgfin summary ok=<n> bad=<n>` を出す。
# 検証モード 2（SOBER_PKGFIN_VERIFY=2）も同じ題材で回す: 全 package を下流から順に宣言の木で仕上げた結果から全体の Program の表（ファイルの並び・
# 木〔dest の下流の旗は名前で足す〕・関数・const・error・捕捉の表・cap_pend・z_decl）を組み立て、全体の結果とバイトで比べる（`#pkgasm ok`）。
# 題材 = 合成名（layout・json・log）・別名・lease・optfn・dest の下流の旗（task_budget・lambda_region）・package をまたぐ題材（testdata の app）
set -uo pipefail
cd "$(dirname "$0")/.."
scripts/stage2.sh --quiet || exit 1
S2=$PWD/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export SOBER_PKGFIN_VERIFY=1 SOBER_WORKERS=1 SOBER_CACHE= SOBER_BUILD_CACHE=0 SOBER_CHECK_REPLAY=0 SOBER_DATE_SEC=784111777
ulimit -s unlimited
entries=(examples/http_hello.sober examples/web_server_hello.sober examples/task_budget.sober examples/lambda_region.sober examples/json_decode.sober
    examples/layout_widths.sober examples/lease_alias.sober examples/optfn.sober examples/logs_stdout.sober examples/alias_pkg.sober
    testdata/alias/app testdata/jsonpkg/app testdata/fnpkg/app testdata/pkgdemo/app)
fail=0
n=0
for e in "${entries[@]}"; do
    n=$((n + 1))
    "$S2" build "$e" --emit=elf --passes -o "$W/x.elf" > /dev/null 2> "$W/err"
    sum=$(grep '^#pkgfin summary' "$W/err")
    SOBER_PKGFIN_VERIFY=2 "$S2" build "$e" --emit=elf --passes -o "$W/x.elf" > /dev/null 2> "$W/err2"
    asm=$(grep '^#pkgasm' "$W/err2" | head -1 | cut -c1-300)
    if [ "$asm" != "#pkgasm ok" ]; then
        echo "FAIL $e: ${asm:-no #pkgasm}"
        fail=$((fail + 1))
    fi
    if [ -z "$sum" ] || ! echo "$sum" | grep -q ' bad=0$'; then
        echo "FAIL $e: ${sum:-no summary}"
        grep '^#pkgfin .* mismatch' "$W/err" | head -5
        fail=$((fail + 1))
    else
        echo "ok $e: $sum"
    fi
done
echo "pkgfin: $n entries, fail=$fail"
[ "$fail" = 0 ]
