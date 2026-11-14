#!/usr/bin/env bash
# implicitfreeze（タスク② フェーズ2 — 暗黙 ≡ 明示のオラクル）: 明示の `freeze(x)` のうち、外すと同じ点で暗黙のfreezeになるもの（`sober check --freeze-sites`
# — typer が位置の期待型で判定）を外した木を作り（scripts/implicitfreeze.ts — 列を保つ）、元の木と
#   ① check の判定（標準出力・標準エラー・終了コード）② コア JSON（`check --core-json`）③ build の ELF（拒否なら診断）
# がバイト一致すること。点の表（desugar/implicit.sober）を analyzer・脱糖器・lower が同じく引いていることの証拠（どれかが点を見落とせば
# 外した木が型で落ちるか、コア / ELF が割れる）。木は同じ相対パスに置く（panic の位置の文字列が ELF に入る）。
# 入力 = compiler/ の木（app — 明示の freeze が 300 か所余り。compiler/ を暗黙へ移すまで）・testdata/implicitfreeze/（明示形を意図して残した題材）・
# examples / bench（移行の後に残る明示の freeze）。std は焼き込みなので対象外
#   scripts/implicitfreeze.sh
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$(pwd)
SOBER=${SOBER:-./bin/sober}
case "$SOBER" in /*) ;; *) SOBER=$ROOT/$SOBER ;; esac
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0; n=0; nsites=0

# one <元の根> <書き換え先の根> <entry> <作業の配置先> [点の列のファイル]: 外せるfreezeがあれば外して3つを比べる。結果は行で吐く
# （失敗の行・@@ in <外した数>〔数える入力〕・@@ fail）— 入力ごとに独立なので並列に回せる（集計は呼び手）
one() {
    local a=$1 b=$2 s=$3 w=$4 k f=0
    if [ -n "${5:-}" ]; then
        [ -f "$5" ] || return 0
        cp "$5" "$w/sites"
    else
        (cd "$a" && "$SOBER" check "$s" --freeze-sites) > "$w/sites" 2> /dev/null || { echo "FAIL $s: check --freeze-sites failed"; echo "@@ fail"; return 0; }
    fi
    grep -qE ':[0-9]+:[0-9]+$' "$w/sites" || return 0
    k=$(cd "$a" && node "$ROOT/scripts/implicitfreeze.ts" "$w/sites" "$b") || { echo "FAIL $s: rewrite"; echo "@@ fail"; return 0; }
    echo "@@ in $k"
    for side in a b; do
        local r=$a; [ "$side" = b ] && r=$b
        (cd "$r" && "$SOBER" check "$s" > "$w/$side.chk" 2>&1; echo "rc=$?" >> "$w/$side.chk")
        (cd "$r" && "$SOBER" check "$s" --core-json > "$w/$side.core" 2>&1)
        (cd "$r" && "$SOBER" build "$s" -o "$w/$side.elf" > "$w/$side.bld" 2>&1; echo "rc=$?" >> "$w/$side.bld")
        [ -f "$w/$side.elf" ] || : > "$w/$side.elf"
    done
    for x in chk core bld elf; do
        cmp -s "$w/a.$x" "$w/b.$x" || { echo "FAIL $s ($k sites): $x differs"; diff <(head -c 400 "$w/a.$x") <(head -c 400 "$w/b.$x") | head -4; f=1; }
    done
    rm -f "$w/a.elf" "$w/b.elf"
    [ "$f" = 0 ] || echo "@@ fail"
}

# compiler/ の木（stage2 と同じ組み方 — compiler/* + std/）。元の木 ca と書き換える木 cb を別に持つので、例題の仕事と並べて走らせる
mkdir -p "$W/ca" "$W/cb"
cp -r src/compiler/. "$W/ca/"; cp -r src/std "$W/ca/std"
cp -r "$W/ca/." "$W/cb/"
# 例題: 走査（--freeze-sites）は元の木で読むだけなので全入力を先に並列に走査し、外せる freeze を持つ入力（1 割に満たない）だけを比べる。
# 比べる仕事は入力ごとに書き換える木を持つ: examples・bench・testdataのハードリンクのコピー（testdataは1 GB余り — 中身はコピーしない）に、
# 書き換える点のファイルだけリンクを切った実体を置く（元の木のファイルは書き換えない）
mkdir -p "$W/sites.d"
scan() {
    local s=$1 o
    o=$W/sites.d/$(echo "$s" | tr '/' '_')
    (cd "$ROOT" && "$SOBER" check "$s" --freeze-sites) > "$o.tmp" 2> /dev/null && mv "$o.tmp" "$o" || rm -f "$o.tmp"
}
exone() {
    local s=$1 sf=$2 f
    grep -qE ':[0-9]+:[0-9]+$' "$sf" || return 0
    mkdir -p "$PAR_W/root"
    cp -al "$ROOT/examples" "$ROOT/bench" "$ROOT/testdata" "$PAR_W/root/"
    grep -E ':[0-9]+:[0-9]+$' "$sf" | while IFS= read -r l; do f=${l%:*:*}; rm -f "$PAR_W/root/$f"; cp "$ROOT/$f" "$PAR_W/root/$f"; done
    one "$ROOT" "$PAR_W/root" "$s" "$PAR_W" "$sf"
    rm -rf "$PAR_W/root"
}
inputs=(testdata/implicitfreeze/*.sober examples/*.sober bench/*/main.sober)
par_init "$W/scan"
for s in "${inputs[@]}"; do par_run scan "$s"; done
par_wait
# 走査（check --freeze-sites）が失敗した入力は名前を残し、失敗してよい一覧（checkが拒否する例など）と照合する — 件数の減少に失敗が隠れない
printf '%s\n' "${inputs[@]}" > "$W/tried"
for s in "${inputs[@]}"; do [ -f "$W/sites.d/$(echo "$s" | tr '/' '_')" ] || echo "$s"; done > "$W/omitted"
par_init "$W"
mkdir -p "$W/app"
par_run one "$W/ca" "$W/cb" app "$W/app"
for s in "${inputs[@]}"; do
    sf=$W/sites.d/$(echo "$s" | tr '/' '_')
    [ -f "$sf" ] && par_run exone "$s" "$sf"
done
par_wait > "$W/list"
grep -v '^@@ ' "$W/list" || true
n=$(par_count 'in [0-9]*' "$W/list")
nsites=$(sed -n 's/^@@ in //p' "$W/list" | awk '{ t += $1 } END { print t + 0 }')
fail=0
[ "$(par_count fail "$W/list")" = 0 ] || fail=1
omit_judge implicitfreeze scripts/omit/implicitfreeze.list "$W/tried" "$W/omitted" || fail=1
# 入力が0なら検査が空（--freeze-sitesが通らない形 — bin/soberの旗の許しなど）
[ "$n" -gt 0 ] || { echo "FAIL: no input has a removable freeze"; fail=1; }
echo "implicitfreeze: $n inputs, $nsites explicit freezes removed — check / core JSON / ELF identical, fail=$fail"
exit $fail
