#!/usr/bin/env bash
# gatememo（ゲートの高速化便 R1 — report-1221）: ゲートの結果の記録の網 M1 — 宣言・共通の各成分の中の 1 ファイルを 1 バイト変えた上書きで成分のハッシュが変わること
# + 宣言の古びの lint（スクリプトの本文が言及するパスが scripts/gatedeps.txt に覆われていること）。本体 = scripts/gatememo.ts selftest
set -uo pipefail
cd "$(dirname "$0")/.."
NODE_NO_WARNINGS=1 exec node --experimental-strip-types scripts/gatememo.ts selftest
