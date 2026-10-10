#!/usr/bin/env bash
# package 単位の検査（V5-6 = I-3 — lean/FeatherweightSober/Split.lean）。
#
#   scripts/pkgcheck.sh
#
# 各対象プログラムの各 package P について:
#   1. `sober check E --pkg P --iface DIR`（P の Def は本体つき・他は .sobi から読んだ署名だけ）を sober-check が受理する
#   2. 視点の署名表（名前付き関数、`--pkg P --iface DIR --core-json`）の各行が全ソースの署名表にある（名前で包含）
#      — defsOk_of_parts の仮定 SigEq（各視点の表と全体の表の署名が一致）のうち、名前付き関数の部分を確かめる
# 全 package が 1 と 2 を満たせば、合成定理により全体の関数表が DefsOk（持ち上げたラムダの添字の再配置は仮定の外）
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
STAGE1=${STAGE1:-src/stage1/zig-out/bin/sober}
export SOBER_CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
W=$(mktemp -d)
# 1 の判定は Lean のバッチでまとめて取る: `sober check --pkg P --iface DIR` の SOBER_CHECK をスタブに差し替えて検査器へ渡す JSON を横取りし
# （sober check は検査器の stdout を中継するだけ — 判定の中身は同じ）、最後に sober-check --batch へ流す
STUB=$(lean_stub "$W")
REAL_CHECK=$SOBER_CHECK
mkdir -p "$W/cap"
: > "$W/cap.list"

# 対象 = 凍結コーパス scripts/frozen/pkgcheck.list（このゲートは stage1 専用 — 凍結後の言語機能を使う例は stage1 が読めないので、入力を凍結時点に固定する。
# 旧: examples/*.out の全例から名指しで除外 — 凍結後の例が増えるたびに除外が要った。reaudit round 3 で切り替え）
targets=""
missing=0
while read -r t; do
    case "$t" in ''|'#'*) continue;; esac
    check_retired "$t" && continue   # scripts/frozen/check-retired.list（string を使う entry — 凍結した脱糖器の string の型が新しい Lean と合わない）
    if [ -e "$t" ]; then targets="$targets $t"; else missing=$((missing + 1)); fi
done < scripts/frozen/pkgcheck.list
[ "$missing" = 0 ] || echo "pkgcheck: $missing entries of scripts/frozen/pkgcheck.list are gone (skipped)"

pkgone() { # 1 対象（並列の仕事 — 横取りした入力の一覧は自分の $w/cap.list に書き、最後に寄せる）
    local t=$1 w=$PAR_DIR/r_$(echo "$1" | tr '/.' '__') k D p cap
    mkdir -p "$w"
    : > "$w/cap.list"
    k=$(echo "$t" | tr '/.' '__')
    D=$W/$k
    "$STAGE1" iface "$t" -o "$D" > /dev/null 2> "$w/err" || { echo "IFACE FAIL $t: $(head -2 "$w/err")"; echo "@@ fail"; return; }
    "$STAGE1" check "$t" --pkg main --core-json > "$w/sigs.whole" 2> "$w/err" || { echo "SIGS FAIL $t: $(head -2 "$w/err")"; echo "@@ fail"; return; }
    while read -r p; do
        cap=$W/cap/$(echo "$t $p" | tr '/. ' '___').json
        LEANCAP=$cap SOBER_CHECK=$STUB "$STAGE1" check "$t" --pkg "$p" --iface "$D" > "$w/v" 2> "$w/err" || { echo "PKG CHECK FAIL $t $p: $(head -c 200 "$w/v") $(head -2 "$w/err")"; echo "@@ fail"; continue; }
        [ -s "$cap" ] || { echo "PKG CHECK FAIL $t $p: no checker input"; echo "@@ fail"; continue; }
        printf '%s\t%s %s\n' "$cap" "$t" "$p" >> "$w/cap.list"
        "$STAGE1" check "$t" --pkg "$p" --iface "$D" --core-json > "$w/sigs.view" 2> "$w/err"
        # 視点の表は全体の表の部分（落とした非公開関数・他 package の持ち上げが無い）— 名前で包含を見る
        grep -vxFf "$w/sigs.whole" "$w/sigs.view" > "$w/extra"; [ -s "$w/extra" ] && { echo "SIG MISMATCH $t $p"; head -3 "$w/extra"; echo "@@ fail"; }
        echo "@@ pkg"
    done < "$D/link.txt"
}
fail=0
par_init "$W"
for t in $targets; do par_run pkgone "$t"; done
par_wait > "$W/all"
grep -v '^@@ ' "$W/all" || true
pkgs=$(par_count pkg "$W/all")
[ "$(par_count fail "$W/all")" = 0 ] || fail=1
cat "$W"/par/r_*/cap.list > "$W/cap.list"
# 1 の判定（Lean のバッチ）
cut -f1 "$W/cap.list" > "$W/cap.files"
SOBER_CHECK=$REAL_CHECK JOBS=${JOBS:-4} lean_batch "$W/cap.files" "$W/lean"
while IFS=$'\t' read -r cap what; do
    v=$(SOBER_CHECK=$REAL_CHECK lean_result "$cap" "$W/lean")
    case "$v" in *'"ok":true'*) ;; *) echo "PKG CHECK FAIL $what: $(printf '%s' "$v" | head -c 200)"; fail=1 ;; esac
done < "$W/cap.list"
# 自己検査: 署名を偽った .sobi（Decode の結果型を int → bool）は、部分検査を通っても署名表の包含で必ず落ちる
M=$W/mut
"$STAGE1" iface testdata/iface/app -o "$M" > /dev/null
sed -i 's/^func Decode(b \[\]int) int$/func Decode(b []int) bool/' "$M/testdata/iface/lib.sobi"
grep -qx 'func Decode(b \[\]int) bool' "$M/testdata/iface/lib.sobi" || { echo "MUTANT NOT APPLIED"; fail=1; }
"$STAGE1" check testdata/iface/app --pkg main --core-json > "$W/sigs.whole"
"$STAGE1" check testdata/iface/app --pkg main --iface "$M" --core-json > "$W/sigs.view"
grep -qvxFf "$W/sigs.whole" "$W/sigs.view" || { echo "LYING SIGNATURE NOT DETECTED"; fail=1; }

echo "pkgcheck: $pkgs packages accepted with matching signature tables, fail=$fail"
exit $fail
