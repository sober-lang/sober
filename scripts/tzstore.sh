#!/usr/bin/env bash
# tzstore（std/timeの地域の規則の焼き込み — ユーザー決定2026-11-05 ⑤-11: 信頼ストアと同じ更新フロー）: IANAのtzの正式リリース（data.iana.orgのtzdata<版>.tar.gz）を
# zic -b slim で TZif に組み、src/std/time/zones.sober（生成物・出所の銘つき）に焼き込む。組んだ TZif の束は testdata/tz/tzif.tar.gz（決定的な tar）・銘は
# testdata/tz/SOURCE（`版 取得日 tzdata<版>.tar.gz の SHA-256 zic の版`）・別名の表は testdata/tz/links.txt に置き、照合はネットにも zic にも依らない。照合の表 testdata/tz/samples.txt は同じソースの
# zic -b fat -r 1900〜2100（全部の遷移の展開）から作る（std/time のテストが slim の遷移 + 末尾の規則の評価と突き合わせる）。
#   scripts/tzstore.sh                 照合（gate tzsync）: 置いた TZif の束と銘から作り直した zones.sober ≡ リポジトリのもの
#   scripts/tzstore.sh --regen [版]    tz の版（2026f の形・省略 = 最新のリリース）の tzdata を取って組み直す（ネットと zic が要る）
#   scripts/tzstore.sh --latest        tz の最新のリリースの版を印字（data.iana.org/time-zones/tzdb/version — .github/workflows/tzstore.yml が銘の版と比べる）
#   scripts/tzstore.sh --pinned        銘の版を印字
set -uo pipefail
cd "$(dirname "$0")/.."
D=testdata/tz
OUT=src/std/time/zones.sober
SRCS="africa antarctica asia australasia europe northamerica southamerica etcetera backward"
latest() {
    curl -sfL https://data.iana.org/time-zones/tzdb/version | tr -d '[:space:]'
}
gen() { # $1 = slim の TZif の束 → stdout
    read -r tag date sha zic < "$D/SOURCE"
    node --experimental-strip-types scripts/tzgen.ts zones "$1" "$D/links.txt" "$tag" "$date" "$sha" "$zic"
}
case "${1:-}" in
    --latest) latest; exit 0 ;;
    --pinned) cut -d' ' -f1 "$D/SOURCE"; exit 0 ;;
    --regen)
        tag=${2:-$(latest)}
        [ -n "$tag" ] || { echo "tzstore: FAIL — no tz tag"; exit 1; }
        command -v zic > /dev/null || { echo "tzstore: FAIL — zic not found (the regen needs zic)"; exit 1; }
        W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
        mkdir -p "$W/src" "$W/slim" "$W/fat"
        curl -sfL -o "$W/tzdata.tar.gz" "https://data.iana.org/time-zones/releases/tzdata$tag.tar.gz" || { echo "tzstore: FAIL fetch tzdata$tag.tar.gz"; exit 1; }
        sha=$(sha256sum "$W/tzdata.tar.gz" | cut -d' ' -f1)
        tar -xzf "$W/tzdata.tar.gz" -C "$W/src" $SRCS || { echo "tzstore: FAIL extract"; exit 1; }
        zv=$(zic --version 2>&1 | head -n 1 | tr ' ' '_')
        (cd "$W/src" && zic -b slim -d "$W/slim" $SRCS && zic -b fat -r @-2208988800/@4102444800 -d "$W/fat" $SRCS) || { echo "tzstore: FAIL zic"; exit 1; }
        mkdir -p "$D"
        echo "$tag $(date -u +%Y-%m-%d) $sha $zv" > "$D/SOURCE"
        # 別名の表（tz のソースの Link の行 — `Link 正 別名` → `別名 正`）
        (cd "$W/src" && awk '$1 == "Link" || $1 == "L" { print $3, $2 }' $SRCS | sort) > "$D/links.txt"
        tar --sort=name --mtime=@0 --owner=0 --group=0 --numeric-owner -C "$W/slim" -cf - . | gzip -9n > "$D/tzif.tar.gz"
        gen "$W/slim" > "$OUT" || { echo "tzstore: FAIL generate"; exit 1; }
        node --experimental-strip-types scripts/tzgen.ts samples "$W/fat" "$D/links.txt" > "$D/samples.txt" || { echo "tzstore: FAIL samples"; exit 1; }
        echo "tzstore: regen $OUT from tz $tag ($(grep -c '^        "' "$OUT") lines, $(wc -l < "$D/samples.txt") samples)"
        exit 0 ;;
esac
W=$(mktemp -d); trap 'rm -rf "$W"' EXIT
mkdir -p "$W/slim"
tar -xzf "$D/tzif.tar.gz" -C "$W/slim"
gen "$W/slim" > "$W/zones.sober" || { echo "tzstore: FAIL generate"; exit 1; }
read -r tag _ < "$D/SOURCE"
cmp -s "$W/zones.sober" "$OUT" || { echo "tzstore: FAIL — $OUT is not the output of scripts/tzgen.ts for tz $tag (scripts/tzstore.sh --regen $tag)"; diff "$W/zones.sober" "$OUT" | head -5; exit 1; }
echo "tzstore: $OUT ≡ tz $tag ($(grep -c '^        "' "$OUT") lines)"
