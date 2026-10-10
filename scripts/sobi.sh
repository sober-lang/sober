#!/usr/bin/env bash
# .sobi（package の interface — language.md 29 節・compiler/iface）と package 単位の検査（check --pkg — compiler/checker の CheckPkgE2）の照合
# （3'' M1・M2）。
#
#   scripts/sobi.sh
#
# 今の例（examples/*.out の entry + testdata/*/app）:
#   G-a ラウンドトリップ: 全 package の .sobi（主の sober の `iface -o`）が
#       ・バイト決定的（2 回書いて一致）
#       ・先頭の版の行 `// sobi 1` + 印字器の正規形（`fmt`〔.sobi は ParseIface で読む〕が版の行の後ろと一致 — parse → 印字の不動点）
#       ・Emit ∘ LoadView ∘ Emit の不動点（main の視点 = 他の全 package を .sobi から読んだプログラムから書き直した .sobi が元と一致 — `iface --view main`）
#   G-d 合成（formal.md V5-6 — 合成定理 defsOk_of_linked の hchk / hmap）: 全体の check が受理する entry で、全 package P について
#       ・部分検査 `check E --pkg P --iface D` が受理（hchk）
#       ・視点の署名表（--sigs）の各行が全体の署名表にある（hmap — 名前と署名の綴り）
#     改竄 mutant（testdata/iface の lib.sobi の Decode の戻り型 int → bool）: 署名表の包含が必ず落ちる（部分検査の受理だけでは合成が成り立たない）
# 凍結コーパス（scripts/frozen/pkgcheck.list — stage1 が読める言語の範囲）:
#   G-b stage1 との .sobi の差分: std の外の .sobi について stage2 の fmt(stage1 の .sobi) ≡ stage2 の .sobi（版の行と `@expand` の行を除く —
#       stage1 に無い情報。`--no-expand` で書く）。一致は「種類の中の宣言の順が stage1〔原文の順〕と同じ」を含む。link.txt は std の外の行が一致。
#       既知の食い違いは scripts/frozen/sobi_known.txt
#   G-c stage1 との判定の一致（V5-5）: stage2 の全体の check が通る entry（check-retired は除く）の std の外の全 package P で、
#       stage2 の `check --pkg P --iface D2` ≡ stage1 の `check --pkg P --iface D1`（Lean の sober-check）の判定 JSON
#       （std は stage1 と stage2 で中身が違う — stage1 は凍結）
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
SOBER=${SOBER:-./bin/sober}
STAGE1=${STAGE1:-src/stage1/zig-out/bin/sober}
export SOBER_CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
S2=out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
JOBS=${JOBS:-$(nproc)}
par_init "$W"

split_bundle() { # $1 = 束 $2 = 書き出し先
    awk -v d="$2" '/^== / { f = d "/" substr($0, 4); g = f; sub(/\/[^\/]*$/, "", g); system("mkdir -p \047" g "\047"); printf "" > f; next } { print > f }' "$1"
}

# 今の例の 1 entry（G-a・G-d）
cur_one() {
    local e=$1 w=$PAR_W D f P rel ok
    D=$w/d
    "$SOBER" iface "$e" -o "$D" > /dev/null 2> "$w/err" || { echo "@@ skip"; return 0; }   # check で落ちる entry（負例）は対象外
    "$SOBER" iface "$e" -o "$w/d2" > /dev/null 2>&1
    diff -r "$D" "$w/d2" > /dev/null || echo "FAIL G-a $e: .sobi not deterministic"
    while read -r f; do
        echo "@@ sobi"
        if [ "$(head -n 1 "$f")" != "// sobi 1" ]; then echo "FAIL G-a $e ${f#$D/}: no version line"; continue; fi
        tail -n +2 "$f" > "$w/body"
        if ! "$S2" fmt "$f" > "$w/fmt" 2>&1 || ! cmp -s "$w/body" "$w/fmt"; then
            echo "FAIL G-a $e ${f#$D/}: not a fmt fixpoint"; diff "$w/body" "$w/fmt" | head -6
        fi
    done < <(find "$D" -name '*.sobi' | sort)
    # Emit ∘ LoadView ∘ Emit
    if "$SOBER" iface "$e" --view main "$D" > "$w/view" 2> "$w/verr"; then
        mkdir -p "$w/vv"
        split_bundle "$w/view" "$w/vv"
        while read -r rel; do
            echo "@@ fix"
            cmp -s "$w/vv/$rel" "$D/$rel" || { echo "FAIL G-a $e $rel: Emit ∘ LoadView ∘ Emit differs"; diff "$D/$rel" "$w/vv/$rel" | head -6; }
        done < <(cd "$w/vv" && find . -name '*.sobi' | sed 's|^\./||' | sort)
    else
        echo "FAIL G-a $e: iface --view main: $(head -n 1 "$w/verr")"
    fi
    # G-d（全体の check が受理する entry だけ）
    "$SOBER" check "$e" > "$w/whole" 2>&1 || { echo "@@ dskip"; return 0; }
    grep -q '"ok":true' "$w/whole" || { echo "@@ dskip"; return 0; }
    "$S2" check "$e" --sigs | sort > "$w/sigs.all"
    while read -r P; do
        echo "@@ pkg"
        "$SOBER" check "$e" --pkg "$P" --iface "$D" > "$w/part" 2>&1
        grep -q '"ok":true' "$w/part" || { echo "FAIL G-d $e $P: partial check rejected: $(head -n 1 "$w/part")"; continue; }
        "$S2" check "$e" --pkg "$P" --iface "$D" --sigs | sort > "$w/sigs.view"
        comm -23 "$w/sigs.view" "$w/sigs.all" > "$w/extra"
        if [ -s "$w/extra" ]; then echo "FAIL G-d $e $P: view signatures not in the whole table"; head -3 "$w/extra"; fi
    done < "$D/link.txt"
    return 0
}

# 凍結コーパスの 1 entry（G-b・G-c）
frozen_one() {
    local e=$1 w=$PAR_W k D1 D2 rel P v1 v2
    D1=$w/d1
    D2=$w/d2
    "$STAGE1" iface "$e" -o "$D1" > /dev/null 2>&1 || { echo "@@ skip"; return 0; }
    if ! "$SOBER" iface "$e" -o "$D2" --no-expand > /dev/null 2> "$w/err"; then
        echo "FAIL G-b $e: stage2 iface: $(head -n 1 "$w/err")"; return 0
    fi
    cmp -s <(grep -v '^std/' "$D1/link.txt") <(grep -v '^std/' "$D2/link.txt") || echo "FAIL G-b $e: link.txt differs"
    while read -r rel; do
        echo "@@ cmp"
        if grep -qP "^\Q$e\E\t\Q$rel\E\t" scripts/frozen/sobi_known.txt; then echo "@@ known"; continue; fi
        [ -f "$D2/$rel" ] || { echo "FAIL G-b $e $rel: missing in stage2"; continue; }
        "$S2" fmt "$D1/$rel" > "$w/s1" 2>&1
        grep -v '^// sobi 1$' "$D2/$rel" | grep -v '^@expand$' > "$w/s2"
        cmp -s "$w/s1" "$w/s2" || { echo "FAIL G-b $e $rel"; diff "$w/s1" "$w/s2" | head -6; }
    done < <(cd "$D1" && find . -name '*.sobi' | sed 's|^\./||' | grep -v '^std/' | sort)
    # G-c（stage2 の全体の check が通る entry — 凍結した例には今の脱糖器が拒否するものがある）
    check_retired "$e" && { echo "@@ cskip"; return 0; }
    "$SOBER" iface "$e" -o "$w/d3" > /dev/null 2>&1 || { echo "@@ cskip"; return 0; }
    while read -r P; do
        case "$P" in std/*) continue ;; esac
        echo "@@ verdict"
        v1=$("$STAGE1" check "$e" --pkg "$P" --iface "$D1" 2>&1 | head -n 1)
        v2=$("$SOBER" check "$e" --pkg "$P" --iface "$w/d3" 2>&1 | head -n 1)
        [ "$v1" = "$v2" ] || echo "FAIL G-c $e $P: stage1 $v1 / stage2 $v2"
    done < "$D1/link.txt"
    return 0
}

entries=()
for s in examples/*.sober; do [ -f "${s%.sober}.out" ] && entries+=("$s"); done
for d in testdata/*/app; do entries+=("$d"); done
for e in "${entries[@]}"; do par_run cur_one "$e"; done
while read -r e; do
    case "$e" in ''|'#'*) continue;; esac
    [ -e "$e" ] && par_run frozen_one "$e"
done < scripts/frozen/pkgcheck.list
par_wait > "$W/out"

# 改竄 mutant（G-d の自己検査）
M=$W/mut
"$SOBER" iface testdata/iface/app -o "$M" > /dev/null
sed -i 's/^func Decode(b \[\]int) int$/func Decode(b []int) bool/' "$M/testdata/iface/lib.sobi"
mutok=0
grep -q '^func Decode(b \[\]int) bool$' "$M/testdata/iface/lib.sobi" || echo "FAIL G-d mutant: Decode not found in lib.sobi" >> "$W/out"
"$S2" check testdata/iface/app --sigs | sort > "$W/m.all"
"$S2" check testdata/iface/app --pkg main --iface "$M" --sigs | sort > "$W/m.view"
[ -n "$(comm -23 "$W/m.view" "$W/m.all")" ] && mutok=1
[ "$mutok" = 1 ] || echo "FAIL G-d mutant: the forged signature was not detected" >> "$W/out"

grep -v '^@@ ' "$W/out"
fail=0
grep -q '^FAIL' "$W/out" && fail=1
echo "sobi G-a: ${#entries[@]} entries ($(par_count skip "$W/out") skipped incl. frozen), $(par_count sobi "$W/out") .sobi round-tripped, $(par_count fix "$W/out") Emit∘LoadView∘Emit fixpoints"
echo "sobi G-d: $(par_count pkg "$W/out") packages partially checked with signature inclusion ($(par_count dskip "$W/out") entries not accepted as a whole), mutant detected=$mutok"
echo "sobi G-b: $(par_count cmp "$W/out") .sobi compared with stage1 ($(par_count known "$W/out") known differences)"
echo "sobi G-c: $(par_count verdict "$W/out") package verdicts matched against stage1 ($(par_count cskip "$W/out") entries skipped), fail=$fail"
exit $fail
