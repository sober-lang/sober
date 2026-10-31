#!/usr/bin/env bash
# regen.sh: IR / コア / AST を変えるコミットの黄金 5 種（astjson・checkverdict・corejson・irtext・lltext）+ std リファレンス（stdref — docs/std/）+ outline の黄金を並列に作り直す（足回りの便）。
#   scripts/regen.sh            7 種を同時に（各スクリプトの中も entry ごとに並列 — JOBS は nproc / 4・最低 4）
# 規律は今までどおり: regen は gates 緑の木 / 意図した差だけを確かめてから（黄金 regen は gates 緑からだけ）。差は git diff で見る
set -uo pipefail
cd "$(dirname "$0")/.."
scripts/stage2.sh --quiet > /dev/null || exit 1
export SOBER_STAGE2_CHECKED=1
J=$(( $(nproc) / 4 ))
[ "$J" -ge 4 ] || J=4
export JOBS=${JOBS:-$J}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
t0=$(date +%s)
for g in astjson checkverdict corejson irtext lltext stdref outline; do
    ( s=$(date +%s); scripts/$g.sh --regen > "$W/$g.log" 2>&1; echo "$? $(( $(date +%s) - s ))" > "$W/$g.res" ) &
done
wait
fail=0
for g in astjson checkverdict corejson irtext lltext stdref outline; do
    read -r ec secs < "$W/$g.res"
    echo "regen: $g ec=$ec ${secs}s — $(tail -n 1 "$W/$g.log")"
    [ "$ec" = 0 ] || { fail=1; cat "$W/$g.log"; }
done
echo "regen: wall $(( $(date +%s) - t0 ))s (JOBS=$JOBS), fail=$fail"
# 差分の量（宣言なき軸の線 — report-1283: 動いた黄金の本数とバイトをコミットの前に目に入れる）と線の照合（scripts/axes.sh --warn — 越えたら WARN の行）
echo "regen: golden changes — $(git -c core.quotepath=off status --porcelain -- testdata docs/std | wc -l) files ($(git diff --shortstat -- testdata docs/std | sed 's/^ *//')); untracked $(git ls-files --others --exclude-standard -- testdata docs/std | xargs -r stat -c %s | awk '{ t += $1 } END { printf "%.1f MB", t / 1e6 }')"
scripts/axes.sh --warn | grep -E '^(WARN|axes:)'
[ "$fail" = 0 ]
