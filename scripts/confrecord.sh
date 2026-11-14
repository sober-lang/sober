#!/usr/bin/env bash
# confrecord（準拠文書の手で回す検査の記録）: 相互接続の検査（scripts/{tls,http,dns}interop.sh — Goの道具が要るのでgatesの外）が通ったときに、
# テストの出力の conf: の行を testdata/conformance/interop/<名前>.txt へ木のコミットと日付つきで書く。準拠文書はこの記録を「最終確認」として載せ、
# gate confsync は記録の形だけを照合する（鮮度は文書にそのまま出す）
#   scripts/confrecord.sh <名前> <テストの出力>
set -euo pipefail
cd "$(dirname "$0")/.."
name=$1
src=$2
dirty=$([ -n "$(git --no-optional-locks status --porcelain --untracked-files=no)" ] && echo " (dirty)" || true)
{
    echo "# scripts/${name}interop.sh の記録（scripts/confrecord.sh が書く — 手で直さない）"
    echo "commit $(git rev-parse --short=12 HEAD)${dirty}"
    echo "date $(date -u +%F)"
    grep -E '^conf(-[a-z]+)?: ' "$src"
} > "testdata/conformance/interop/${name}.txt"
echo "confrecord: testdata/conformance/interop/${name}.txt"
