#!/usr/bin/env bash
# tlsfuzz-fetch: ゲートtlsfuzzが使う外部の検査（tlsfuzzer）と、その依存（tlslite-ng・ecdsa・six）を、固定のcommitと版でout/tlsfuzz/に取得する。
# ネットワークに出るのはこのスクリプトだけ（ゲートの実行は127.0.0.1だけ）。取得したものはハッシュで確かめる:
#   tlsfuzzer = gitのcommit（取得した木のHEADがREVと一致すること。gitがオブジェクトのハッシュを検証する）
#   依存 = PyPIのwheelのsha256（pipの--require-hashes）
#   scripts/tlsfuzz-fetch.sh          取得（済んでいれば何もしない）
#   scripts/tlsfuzz-fetch.sh --force  取り直す
set -euo pipefail
cd "$(dirname "$0")/.."
D=out/tlsfuzz
REV=607cfc2b76644a9d99c0bb4242685007810631a9
REQ="tlslite-ng==0.9.0b2 --hash=sha256:d69afaa207972506fcdad4362de09a422f0c8b780f370ec881cf7e789e858aa1
ecdsa==0.19.2 --hash=sha256:840f5dc5e375c68f36c1a7a5b9caad28f95daa65185c9253c0c08dd952bb7399
six==1.17.0 --hash=sha256:4721f391ed90541fddacab5acf947aa0d3dc7d27b2e1e8eda2be8970586c3274"
STAMP="$REV $(printf '%s' "$REQ" | sha256sum | cut -c1-16)"
if [ "${1:-}" != --force ] && [ -f "$D/.stamp" ] && [ "$(cat "$D/.stamp")" = "$STAMP" ]; then
    echo "tlsfuzz-fetch: up to date ($D)"
    exit 0
fi
rm -rf out/tlsfuzz
mkdir -p "$D"
git init -q "$D/src"
git -C "$D/src" fetch -q --depth 1 https://github.com/tlsfuzzer/tlsfuzzer.git "$REV"
git -C "$D/src" checkout -q FETCH_HEAD
[ "$(git -C "$D/src" rev-parse HEAD)" = "$REV" ] || { echo "tlsfuzz-fetch: FAIL: tlsfuzzerのHEADが$REVでない"; exit 1; }
# pipは取得のためだけの一時の環境から使う。ゲートはsite/をPYTHONPATHに置いて素のpython3で動かす（置き場所を動かしても動く）
python3 -m venv "$D/pipenv"
printf '%s\n' "$REQ" > "$D/requirements.txt"
"$D/pipenv/bin/pip" install -q --disable-pip-version-check --require-hashes --no-deps --only-binary :all: --target "$D/site" -r "$D/requirements.txt"
rm -rf out/tlsfuzz/pipenv
echo "$STAMP" > "$D/.stamp"
echo "tlsfuzz-fetch: tlsfuzzer $REV + $(printf '%s' "$REQ" | cut -d' ' -f1 | tr '\n' ' ')→ $D"
