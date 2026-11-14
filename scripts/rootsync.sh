#!/usr/bin/env bash
# rootsync（gates — 信頼ストアの焼き込みの鮮度の検査・ユーザー決定2026-11-05の更新フロー ②）: scripts/rootstore.shの照合のインターフェース
# （置いた NSS の certdata.txt と銘から作り直した src/std/internal/x509/roots.sober ≡ リポジトリのもの）。作り直しは scripts/rootstore.sh --regen
exec "$(dirname "$0")/rootstore.sh"
