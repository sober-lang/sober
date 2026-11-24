#!/usr/bin/env bash
# tzsync（gates — 地域の規則の焼き込みの鮮度の検査・ユーザー決定2026-11-05 ⑤-11の更新フロー）: scripts/tzstore.shの照合のインターフェース
# （置いた TZif の束と銘から作り直した src/std/time/zones.sober ≡ リポジトリのもの）。作り直しは scripts/tzstore.sh --regen
# ゴールデンの並びを呼び手のロケールに依らせない
export LC_ALL=C.UTF-8
exec "$(dirname "$0")/tzstore.sh"
