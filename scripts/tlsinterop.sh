#!/usr/bin/env bash
# tlsinterop（std/internal/hsc のクライアントの相互接続の網）: Go の crypto/tls のサーバ（scripts/oracles/tlsserver — ECDSA P-256 / P-384 / RSA-2048 の葉・
# TLS 1.3・X25519）を起こし、std/internal/hscのTestInteropをSOBER_TLS_INTEROPで走らせる。Goの道具が要るのでgatesに入れない（暗号のタスクの仕上げに手で回す）
# 通ったらconf: の行をtestdata/conformance/interop/tls.txtへ記録する（scripts/confrecord.sh — 準拠文書の最終確認のフィールド）
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
