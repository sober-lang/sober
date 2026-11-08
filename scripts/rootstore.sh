#!/usr/bin/env bash
# rootstore（std/internal/x509 の信頼ストアの焼き込み — ユーザー裁定 2026-11-05 の更新フロー）: Mozilla NSS の certdata.txt のサーバ認証の信頼の起点と
# distrust-after を src/std/internal/x509/roots.sober（生成物・出所の銘つき）に焼き込む。取り込んだ certdata.txt は testdata/x509/nss/certdata.txt.gz・銘は
# testdata/x509/nss/SOURCE（`タグ 取得日 SHA-256`）に置き、ビルドも照合もネットに出ない。
#   scripts/rootstore.sh                 照合（gate rootsync）: 置いた certdata.txt と銘から作り直した roots.sober ≡ リポジトリのもの
#   scripts/rootstore.sh --regen [TAG]   NSS の TAG（省略 = 最新の RTM タグ）の certdata.txt を取って置き、roots.sober を作り直す（ネットに出る）
#   scripts/rootstore.sh --latest        NSS の最新の RTM タグを印字（.github/workflows/rootstore.yml が銘のタグと比べる）
#   scripts/rootstore.sh --pinned        銘のタグを印字
set -uo pipefail
cd "$(dirname "$0")/.."
D=testdata/x509/nss
OUT=src/std/internal/x509/roots.sober
latest() {
    git ls-remote --tags https://github.com/nss-dev/nss | sed -n 's|.*refs/tags/\(NSS_3_[0-9]*\(_[0-9]*\)\{0,1\}_RTM\)$|\1|p' | sort -t_ -k2,2n -k3,3n -k4,4n | tail -n 1
}
gen() { # $1 = certdata.txt → stdout
    read -r tag date sha < "$D/SOURCE"
    node --experimental-strip-types scripts/nssroots.ts "$1" "$tag" "$date" "$sha"
}
case "${1:-}" in
    --latest) latest; exit 0 ;;
    --pinned) cut -d' ' -f1 "$D/SOURCE"; exit 0 ;;
    --regen)
        tag=${2:-$(latest)}
        [ -n "$tag" ] || { echo "rootstore: FAIL — no NSS tag"; exit 1; }
        W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
        curl -sfL -o "$W/certdata.txt" "https://raw.githubusercontent.com/nss-dev/nss/$tag/lib/ckfw/builtins/certdata.txt" || { echo "rootstore: FAIL fetch $tag"; exit 1; }
        sha=$(sha256sum "$W/certdata.txt" | cut -d' ' -f1)
        mkdir -p "$D"
        echo "$tag $(date -u +%Y-%m-%d) $sha" > "$D/SOURCE"
        gzip -9n -c "$W/certdata.txt" > "$D/certdata.txt.gz"
        gen "$W/certdata.txt" > "$OUT" || { echo "rootstore: FAIL generate"; exit 1; }
        echo "rootstore: regen $OUT from NSS $tag ($(grep -c '^        "' "$OUT") anchors)"
        exit 0 ;;
esac
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
gunzip -c "$D/certdata.txt.gz" > "$W/certdata.txt"
read -r tag date sha < "$D/SOURCE"
[ "$(sha256sum "$W/certdata.txt" | cut -d' ' -f1)" = "$sha" ] || { echo "rootstore: FAIL — $D/certdata.txt.gz does not match the SHA-256 in $D/SOURCE"; exit 1; }
gen "$W/certdata.txt" > "$W/roots.sober" || { echo "rootstore: FAIL generate"; exit 1; }
cmp -s "$W/roots.sober" "$OUT" || { echo "rootstore: FAIL — $OUT is not the output of scripts/nssroots.ts for NSS $tag (scripts/rootstore.sh --regen $tag)"; diff "$W/roots.sober" "$OUT" | head -5; exit 1; }
echo "rootstore: $OUT ≡ NSS $tag ($(grep -c '^        "' "$OUT") anchors)"
