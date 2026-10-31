#!/usr/bin/env bash
# implicitfreeze（便② 段 2 — 暗黙 ≡ 明示のオラクル）: 明示の `freeze(x)` のうち、外すと同じ点で暗黙の freeze になるもの（`sober check --freeze-sites`
# — typer が位置の期待型で判定）を外した木を作り（scripts/implicitfreeze.ts — 列を保つ）、元の木と
#   ① check の判定（標準出力・標準エラー・終了コード）② コア JSON（`check --core-json`）③ build の ELF（拒否なら診断）
# がバイト一致すること。点の表（desugar/implicit.sober）を analyzer・脱糖器・lower が同じく引いていることの証拠（どれかが点を見落とせば
# 外した木が型で落ちるか、コア / ELF が割れる）。木は同じ相対パスに置く（panic の位置の文字列が ELF に入る）。
# 入力 = compiler/ の木（app — 明示の freeze が 300 か所余り。compiler/ を暗黙へ移すまで）・testdata/implicitfreeze/（明示形を意図して残した題材）・
# examples / bench（移行の後に残る明示の freeze）。std は焼き込みなので対象外
#   scripts/implicitfreeze.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$(pwd)
SOBER=${SOBER:-./bin/sober}
case "$SOBER" in /*) ;; *) SOBER=$ROOT/$SOBER ;; esac
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0; n=0; nsites=0

# one <元の根> <書き換え先の根> <entry>: 外せる freeze があれば外して 3 つを比べる
one() {
    local a=$1 b=$2 s=$3 k
    (cd "$a" && "$SOBER" check "$s" --freeze-sites) > "$W/sites" 2> /dev/null || return 0
    grep -qE ':[0-9]+:[0-9]+$' "$W/sites" || return 0
    k=$(cd "$a" && node "$ROOT/scripts/implicitfreeze.ts" "$W/sites" "$b") || { echo "FAIL $s: rewrite"; fail=1; return 0; }
    n=$((n + 1)); nsites=$((nsites + k))
    for side in a b; do
        local r=$a; [ "$side" = b ] && r=$b
        (cd "$r" && "$SOBER" check "$s" > "$W/$side.chk" 2>&1; echo "rc=$?" >> "$W/$side.chk")
        (cd "$r" && "$SOBER" check "$s" --core-json > "$W/$side.core" 2>&1)
        (cd "$r" && "$SOBER" build "$s" -o "$W/$side.elf" > "$W/$side.bld" 2>&1; echo "rc=$?" >> "$W/$side.bld")
        [ -f "$W/$side.elf" ] || : > "$W/$side.elf"
    done
    for x in chk core bld elf; do
        cmp -s "$W/a.$x" "$W/b.$x" || { echo "FAIL $s ($k sites): $x differs"; diff <(head -c 400 "$W/a.$x") <(head -c 400 "$W/b.$x") | head -4; fail=1; }
    done
    rm -f "$W/a.elf" "$W/b.elf"
    # 次の入力のために書き換えた木を元に戻す
    grep -E ':[0-9]+:[0-9]+$' "$W/sites" | while IFS= read -r l; do f=${l%:*:*}; cp "$a/$f" "$b/$f"; done
}

# compiler/ の木（stage2 と同じ組み方 — compiler/* + std/）
mkdir -p "$W/ca" "$W/cb"
cp -r src/compiler/. "$W/ca/"; cp -r src/std "$W/ca/std"
cp -r "$W/ca/." "$W/cb/"
one "$W/ca" "$W/cb" app
mkdir -p "$W/root"
cp -r examples bench testdata "$W/root/"
for s in testdata/implicitfreeze/*.sober examples/*.sober bench/*/main.sober; do
    one "$ROOT" "$W/root" "$s"
done
# 入力が 0 なら網が空（--freeze-sites が通らない形 — bin/sober の旗の許しなど）
[ "$n" -gt 0 ] || { echo "FAIL: no input has a removable freeze"; fail=1; }
echo "implicitfreeze: $n inputs, $nsites explicit freezes removed — check / core JSON / ELF identical, fail=$fail"
exit $fail
