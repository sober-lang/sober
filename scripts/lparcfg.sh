#!/usr/bin/env bash
# lParCfgの棚卸しの検査（段階4 後半 ラウンド 9 — scripts/lparcfg.tsの頭の注記）: lowerの束の関数ごとの入口の呼び出しの閉包が読むStのフィールドと、
# 外の関数の記録を読む箇所が許しの表の内であること。fail = 0 がゲート
set -uo pipefail
cd "$(dirname "$0")/.."
node scripts/lparcfg.ts
