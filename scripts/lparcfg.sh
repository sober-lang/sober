#!/usr/bin/env bash
# lParCfg の棚卸しの網（段 4 後半 ラウンド 9 — scripts/lparcfg.ts の頭の注記）: lower の束の関数ごとの入口の呼び出しの閉包が読む St の欄と、
# 外の関数の記録を読む箇所が許しの表の内であること。fail = 0 がゲート
set -uo pipefail
cd "$(dirname "$0")/.."
node scripts/lparcfg.ts
