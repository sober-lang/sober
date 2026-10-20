#!/usr/bin/env bash
# benchfetch: 公式ベンチの GitHub Actions の run（.github/workflows/bench-official.yml）の artifact を取り込む（report-920 の案 C — コミットと push は手元の規律のまま）
#   scripts/benchfetch.sh <run-id> [--dry] [--accept-cpu]
# 1. `gh run download` で out/bench/gha-<run-id>/ へ（seqperf.tsv・extsort.tsv・bench-env.txt）
# 2. 型番の照合: bench-env.txt の cpu と official.tsv の `# env:` の cpu が違えば拒否（同じラベルでも箱の型番が run で変わる — report-921/922。
#    比は型番をまたぐと比べられない）。official.tsv に env が無い（手元のレジームからの最初の切り替え）か、基線を替えるときは --accept-cpu
# 3. raw + env を bench/data/raw/<日付>-<run-id>/ へ写し（artifact は保持期限で消える — raw はリポジトリに置く）→ benchsync --import → 文書とグラフの生成
# --dry: リポジトリに書かない — out/bench/gha-<run-id>/official.tsv へ import し、文書とグラフを out/bench/gha-<run-id>/render/ へ書く（基線の検証用 — scripts/benchrepro.ts で run 同士の比を照合）
# 取り込みの後は gates の docs 範囲（benchsync）を回してから、意味の単位でコミットする（push はユーザー同席の調停）
set -uo pipefail
cd "$(dirname "$0")/.."
RUN=""
DRY=0
ACCEPT=0
while [ $# -gt 0 ]; do
    case "$1" in
        --dry) DRY=1 ;;
        --accept-cpu) ACCEPT=1 ;;
        -*) echo "benchfetch: unknown argument $1" >&2; exit 2 ;;
        *) RUN=$1 ;;
    esac
    shift
done
[ -n "$RUN" ] || { echo "usage: scripts/benchfetch.sh <run-id> [--dry] [--accept-cpu]" >&2; exit 2; }
G=out/bench/gha-$RUN
if [ ! -s "$G/bench-env.txt" ]; then
    mkdir -p out/bench
    rm -rf "$G.dl"
    gh run download "$RUN" -D "$G.dl" || { echo "benchfetch: gh run download $RUN failed" >&2; exit 1; }
    mkdir -p "$G"
    # artifact は 1 つ（bench-official-<run>-<attempt>）— 中身を平らに写す
    find "$G.dl" -type f -exec cp {} "$G/" \;
    rm -rf "$G.dl"
fi
for f in seqperf.tsv extsort.tsv bench-env.txt; do [ -s "$G/$f" ] || { echo "benchfetch: $G/$f が無い" >&2; exit 1; }; done
kv() { sed -n "s/^$1=//p" "$G/bench-env.txt" | head -n 1; }
CPU=$(kv cpu)
COMMIT=$(kv commit)
DATE=$(kv started | cut -c1-10)
[ -n "$CPU" ] && [ -n "$COMMIT" ] && [ -n "$DATE" ] || { echo "benchfetch: bench-env.txt に cpu / commit / started が無い" >&2; exit 1; }
BASE=$(sed -n 's/^# env: \(.*; \)\{0,1\}cpu=\([^;]*\).*/\2/p' bench/data/official.tsv | head -n 1)
echo "benchfetch: run $RUN — cpu = $CPU・commit = $COMMIT・date = $DATE（基線の cpu = ${BASE:-なし（手元のレジーム）}）" >&2
if [ "$CPU" != "$BASE" ] && [ "$ACCEPT" = 0 ] && [ "$DRY" = 0 ]; then
    echo "benchfetch: 型番が基線と違う — 取り込まない（re-run で同じ型番の箱を待つか、基線を替えるなら --accept-cpu）" >&2
    exit 1
fi
if [ "$DRY" = 1 ]; then
    BENCHSYNC_TSV=$G/official.tsv node --experimental-strip-types scripts/benchsync.ts --import "$G/seqperf.tsv" "$G/extsort.tsv" "$DATE" "$COMMIT" --env "$G/bench-env.txt" || exit 1
    rm -rf "$G/render"
    BENCHSYNC_TSV=$G/official.tsv BENCHSYNC_OUT=$G/render node --experimental-strip-types scripts/benchsync.ts > /dev/null || exit 1
    echo "benchfetch: dry — $G/official.tsv・$G/render/（リポジトリは変えていない）" >&2
    exit 0
fi
D=bench/data/raw/$DATE-$RUN
mkdir -p "$D"
cp "$G/seqperf.tsv" "$G/extsort.tsv" "$G/bench-env.txt" "$D/"
node --experimental-strip-types scripts/benchsync.ts --import "$D/seqperf.tsv" "$D/extsort.tsv" "$DATE" "$COMMIT" --env "$D/bench-env.txt" || exit 1
scripts/benchsync.sh || exit 1
echo "benchfetch: 取り込んだ — $D・bench/data/official.tsv・README{,.ja}.md・bench/README.md・docs/assets/bench-*.svg（次: gates の docs 範囲 → コミット）" >&2
