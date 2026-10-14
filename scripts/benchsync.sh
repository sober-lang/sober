#!/usr/bin/env bash
# benchsync（gates）: README{,.ja}.md・bench/README.md のベンチの数字の行・表 ≡ bench/data/official.tsv からの生成（scripts/benchsync.ts）
#   scripts/benchsync.sh           文書の印の中を書き換える
#   scripts/benchsync.sh --check   生成と現物が違えば exit 1（gates はこちら）
#   scripts/benchsync.sh --import <seqperf.tsv> <webrust.tsv> <extsort.tsv> <日付> <木のコミット>   公式計測の raw から official.tsv を作り直す
set -uo pipefail
cd "$(dirname "$0")/.."
exec node --experimental-strip-types scripts/benchsync.ts "$@"
