#!/usr/bin/env bash
# signprobe: 署名の列（language.md 28節）の益の計測。握手を張り直し続ける相手（testdata/slowcheck/signflood.ts の loop）の最中に、確立済みの TLS の接続の
# リクエストの応答の最大（probe max）が 400 ms 以下。壁時計の量なので、レベル3（@place nightly）でだけ判定する。保証（実行待ちの列のtaskの待ちに足される署名は
# N周ごとに1本まで）は slowcheck が検査のビルド（ミュータント123・124）で決定的に照合する。題材と相手は slowcheck と同じ（scripts/slowcheck.sh --probe）
#   scripts/signprobe.sh
cd "$(dirname "$0")/.."
exec scripts/slowcheck.sh --probe
