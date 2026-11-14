#!/usr/bin/env bash
# confsync（gates）: 準拠文書docs/conformance/*.mdのマークの中 ≡ テストの実物からの生成（scripts/confsync.ts — 源と規律は道具の頭の注記）
#   scripts/confsync.sh           文書のマークの中を書き換える
#   scripts/confsync.sh --check   生成と現物が違う・言明に証拠が無い・使われない言明があれば exit 1（gates はこちら）
set -euo pipefail
cd "$(dirname "$0")/.."
exec node --experimental-strip-types --no-warnings scripts/confsync.ts "$@"
