#!/usr/bin/env bash
# dnsinterop（std/netの名前の解決の送受の検査）: 偽のDNSサーバ（scripts/oracles/dnsserver — UDPとTCP・
# 決めた名前に決めたレスポンス）を起こし、std/netのTestResolveFakeをSOBER_DNS_FAKEで走らせる。Goの道具が要るのでgatesに入れない（名前の解決とクライアントのタスクの仕上げに手で回す）
# 通ったらconf: の行をtestdata/conformance/interop/dns.txtへ記録する（scripts/confrecord.sh — 準拠文書の最終確認のフィールド）
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
