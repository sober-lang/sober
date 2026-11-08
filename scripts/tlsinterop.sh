#!/usr/bin/env bash
# tlsinterop（std/internal/hsc のクライアントの相互接続の網）: Go の crypto/tls のサーバ（scripts/oracles/tlsserver — ECDSA P-256 / P-384 / RSA-2048 の葉・
# TLS 1.3・X25519）を起こし、std/internal/hsc の TestInterop を SOBER_TLS_INTEROP で走らせる。Go の道具が要るので gates に入れない（暗号の便の締めに手で回す）
# 通ったら conf: の行を testdata/conformance/interop/tls.txt へ記録する（scripts/confrecord.sh — 準拠文書の最終確認の欄）
#   scripts/tlsinterop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
W=$(mktemp -d)
trap 'kill $pid 2> /dev/null; rm -rf "$W"' EXIT
go run scripts/oracles/tlsserver/main.go "$W" > "$W/server.log" 2>&1 &
pid=$!
for i in $(seq 1 300); do
    [ -f "$W/ready" ] && break
    sleep 0.1
done
[ -f "$W/ready" ] || { echo "tlsinterop: FAIL — the Go server did not start"; cat "$W/server.log"; exit 1; }
SOBER_TLS_INTEROP=$W bin/sober test std/internal/hsc --run TestInterop -v --fresh > "$W/test.out" 2>&1
rc=$?
cat "$W/test.out"
[ "$rc" = 0 ] && scripts/confrecord.sh tls "$W/test.out"
exit "$rc"
