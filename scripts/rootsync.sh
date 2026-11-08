#!/usr/bin/env bash
# rootsync（gates — 信頼ストアの焼き込みの鮮度の網・ユーザー裁定 2026-11-05 の更新フロー ②）: scripts/rootstore.sh の照合の口
# （置いた NSS の certdata.txt と銘から作り直した src/std/internal/x509/roots.sober ≡ リポジトリのもの）。作り直しは scripts/rootstore.sh --regen
exec "$(dirname "$0")/rootstore.sh"
