#!/usr/bin/env bash
# docsync（gates）: README とガイドのコードの塊 ≡ examples/ の実物（scripts/docsync.ts）
set -uo pipefail
cd "$(dirname "$0")/.."
exec node --experimental-strip-types scripts/docsync.ts
