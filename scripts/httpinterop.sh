#!/usr/bin/env bash
# httpinterop（std/http/client の相互接続の網）: Go の net/http のサーバ（scripts/oracles/httpserver — 平文・TLS 1.3・TLS 1.2 だけの 3 本）を起こし、
# std/http/client の TestHttpInterop を SOBER_HTTP_INTEROP で走らせる。Go の道具が要るので gates に入れない（tlsinterop と同じ扱い — クライアントを変えたら手で回す）
# 通ったら conf: の行を testdata/conformance/interop/http.txt へ記録する（scripts/confrecord.sh — 準拠文書の最終確認の欄）
#   scripts/httpinterop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
W=$(mktemp -d)
trap 'kill $pid 2> /dev/null; rm -rf "$W"' EXIT
go run scripts/oracles/httpserver/main.go "$W" > "$W/server.log" 2>&1 &
pid=$!
for i in $(seq 1 300); do
    [ -f "$W/ready" ] && break
    sleep 0.1
done
[ -f "$W/ready" ] || { echo "httpinterop: FAIL — the Go server did not start"; cat "$W/server.log"; exit 1; }
SOBER_HTTP_INTEROP=$W bin/sober test std/http/client --run TestHttpInterop -v --fresh > "$W/test.out" 2>&1
rc=$?
cat "$W/test.out"
[ "$rc" = 0 ] && scripts/confrecord.sh http "$W/test.out"
exit "$rc"
