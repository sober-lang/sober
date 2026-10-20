#!/usr/bin/env bash
# docsync（gates）: README・ガイド・仕様（docs/spec/）のコードの塊 ≡ examples/ の実物 + 仕様の規則の段落の参照（例 / 拒否 / 決定）の照合（scripts/docsync.ts）
set -uo pipefail
cd "$(dirname "$0")/.."
exec node --experimental-strip-types scripts/docsync.ts
