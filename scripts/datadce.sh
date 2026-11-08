#!/usr/bin/env bash
# datadce（焼き込みのデータの閉世界の DCE の網 — ユーザー要求 2026-11-05）: std に焼き込んだ外の世界の表（信頼ストア src/std/internal/x509/roots.sober・
# 地域の規則 src/std/time/zones.sober）が、参照しないプログラムの ELF に入らないこと・参照するプログラムには入ることを、
# 生成物から取った目印の文字列で数える。題材: testdata/datadce/now.sober（std/time を import して Now だけ — 表は無し）・zone.sober（LoadZone — ゾーンだけ）・
# examples/hello.sober・examples/tls_serve.sober（TLS のサーバ — どの表も無し）・examples/http_client_session.sober（HTTP クライアント — ルートだけ）
#   scripts/datadce.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# 目印: ゾーンの表の 2 本目の行の名前と、ルートの 1 本目の DER の base64 の先頭 40 文字（どちらも生成物の中身 — 表を作り直しても追従する）
zm=$(sed -n 's/^        "\([^ ]*\) .*/\1/p' src/std/time/zones.sober | sed -n 2p)
rm=$(sed -n 's/^        "[0-9]* \([A-Za-z0-9+\/]\{40\}\).*/\1/p' src/std/internal/x509/roots.sober | head -n 1)
[ -n "$zm" ] && [ -n "$rm" ] || { echo "datadce: FAIL — no marker (zones '$zm' roots '$rm')"; exit 1; }
fail=0; n=0
# 題材 期待するゾーンの目印の有無 期待するルートの目印の有無
check() {
    local src=$1 wz=$2 wr=$3 out gz gr
    out="$W/$(basename "$src" .sober)"
    "$S2" build "$src" --emit=elf --passes -o "$out" > /dev/null 2>&1 || { echo "FAIL build $src"; fail=$((fail + 1)); return; }
    gz=$(LC_ALL=C grep -a -c -F "$zm" "$out"); gr=$(LC_ALL=C grep -a -c -F "$rm" "$out")
    [ "$gz" -gt 0 ] && gz=1; [ "$gr" -gt 0 ] && gr=1
    n=$((n + 1))
    if [ "$gz" != "$wz" ] || [ "$gr" != "$wr" ]; then
        echo "FAIL $src: zones $gz (want $wz) roots $gr (want $wr) — $(stat -c %s "$out") B"; fail=$((fail + 1))
    else
        echo "ok $src: zones $gz roots $gr — $(stat -c %s "$out") B"
    fi
}
check testdata/datadce/now.sober 0 0
check testdata/datadce/zone.sober 1 0
check examples/hello.sober 0 0
check examples/tls_serve.sober 0 0
check examples/http_client_session.sober 0 1
echo "datadce: $n programs — baked tables (zones '$zm', roots ${rm:0:12}…) only in the ELF that references them, fail=$fail"
[ $fail = 0 ]
