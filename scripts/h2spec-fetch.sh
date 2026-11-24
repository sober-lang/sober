#!/usr/bin/env bash
# h2spec-fetch: ゲートh2specが使う外部の検査（h2spec v2.6.0 — HTTP/2の準拠の検査）を、固定のURLとsha256でout/h2spec/に取得する。
# ネットワークに出るのはこのスクリプトだけ（ゲートの実行は127.0.0.1だけ）。取得したtar.gzと展開したh2specの両方をsha256で確かめる。
# 使う側（scripts/h2spec.sh）も、走らせる前に展開したh2specのsha256を照合する（写した取得物でも固定を保つ）
#   scripts/h2spec-fetch.sh          取得（済んでいれば何もしない）
#   scripts/h2spec-fetch.sh --force  取り直す
set -euo pipefail
cd "$(dirname "$0")/.."
D=out/h2spec
URL=https://github.com/summerwind/h2spec/releases/download/v2.6.0/h2spec_linux_amd64.tar.gz
TGZ_SHA=157ee0de702e01ad40e752dbf074b366027e550c8e7504f9450da2809e279318
BIN_SHA=ac679b916bcd46c52314b17c8903d8dffebf0f2357586d272731f6d8bfd5e9f7
if [ "${1:-}" != --force ] && [ -x "$D/h2spec" ] && [ "$(sha256sum "$D/h2spec" | cut -d' ' -f1)" = "$BIN_SHA" ]; then
    echo "h2spec-fetch: up to date ($D)"
    exit 0
fi
rm -rf out/h2spec
mkdir -p "$D"
curl -fsSL -o "$D/h2spec.tar.gz" "$URL"
[ "$(sha256sum "$D/h2spec.tar.gz" | cut -d' ' -f1)" = "$TGZ_SHA" ] || { echo "h2spec-fetch: FAIL: tar.gzのsha256が固定の値でない"; rm -rf out/h2spec; exit 1; }
tar -xzf "$D/h2spec.tar.gz" -C "$D" h2spec
rm -f "$D/h2spec.tar.gz"
[ "$(sha256sum "$D/h2spec" | cut -d' ' -f1)" = "$BIN_SHA" ] || { echo "h2spec-fetch: FAIL: h2specのsha256が固定の値でない"; rm -rf out/h2spec; exit 1; }
chmod +x "$D/h2spec"
echo "h2spec-fetch: h2spec v2.6.0 → $D"
