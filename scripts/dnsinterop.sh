#!/usr/bin/env bash
# dnsinterop（std/net の名前の解決の送受の網）: 偽の DNS サーバ（scripts/oracles/dnsserver — UDP と TCP・
# 決めた名前に決めた応答）を起こし、std/net の TestResolveFake を SOBER_DNS_FAKE で走らせる。Go の道具が要るので gates に入れない（名前の解決とクライアントの便の締めに手で回す）
# 通ったら conf: の行を testdata/conformance/interop/dns.txt へ記録する（scripts/confrecord.sh — 準拠文書の最終確認の欄）
#   scripts/dnsinterop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
W=$(mktemp -d)
trap 'kill $pid 2> /dev/null; rm -rf "$W"' EXIT
go run scripts/oracles/dnsserver/main.go "$W" > "$W/server.log" 2>&1 &
pid=$!
for i in $(seq 1 300); do
    [ -f "$W/ready" ] && break
    sleep 0.1
done
[ -f "$W/ready" ] || { echo "dnsinterop: FAIL — the Go server did not start"; cat "$W/server.log"; exit 1; }
SOBER_DNS_FAKE=$(cat "$W/port") bin/sober test std/net --run TestResolveFake -v --fresh > "$W/test.out" 2>&1
rc=$?
cat "$W/test.out"
[ "$rc" = 0 ] && scripts/confrecord.sh dns "$W/test.out"
exit "$rc"
