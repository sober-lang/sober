#!/usr/bin/env bash
# tzsync（gates — 地域の規則の焼き込みの鮮度の網・ユーザー裁定 2026-11-05 ⑤-11 の更新フロー）: scripts/tzstore.sh の照合の口
# （置いた TZif の束と銘から作り直した src/std/time/zones.sober ≡ リポジトリのもの）。作り直しは scripts/tzstore.sh --regen
exec "$(dirname "$0")/tzstore.sh"
