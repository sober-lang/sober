#!/usr/bin/env bash
# alphacheck: 改名が意味を変えないことの自動検収（リネーム道具 R2 — report-882 4 節 / report-884）。
#
#   scripts/alphacheck.sh <sym> <new> [--keep] [--no-v4]    （<sym> は scripts/refs.sh と同じ — <pkg>.<Name> / <pkg>.<型>.<欄> / <pkg>.<関数>(<仮引数>)。
#                                                            package のパスなら <new> も新しいパス — scripts/refs.sh --pkgrename・写像はパスと参照名の 2 組）
#
# 手順: ① 書き換えの計画（scripts/refs.sh --rename --dry-run — 未分類・合成の参照・衝突があればここで止まる）
#       ② .sober と黄金の置き場の作業木 ≡ git の index を確かめる（往復の比較の基準 = index — stage 済みの未コミットの変更を含められる）
#       ③ 触るファイルを読む entry（scripts/refs.sh --entries × `refs files`）を選び、書き換えの前に測る
#       ④ 書き換える（refs.sh --rename — 字句列の照合と国勢調査つき）→ 同じ entry を測る
#       V1: check --core-json の標準出力がバイト一致（コアは名前も並びも持たない — report-883 1 節 ②）。違えば文字列の定数を復号して写像一致
#           （名前が文字列に入る形 — json のキー・panic の文面。report-885）。拒否される entry は終了コード + 診断を V2 の形で
#       V2: build --emit=ir の旧に旧名 → 新名の写像（語境界・一部可）を当てて新と一致（scripts/alphamap.ts — 位置の列は伏せる・文字列の定数は復号して長さは伏せる）
#       V3: ELF がバイト一致。違えば両方を走らせ（10 s・標準入力なし）標準出力 + 標準エラー + 終了コードの写像一致
#       V4: 黄金の regen（scripts/regen.sh の 5 種 + loaderjson）の後、変わった黄金 f ごとに 写像(index の f) == f（足された・消えた黄金は赤）
#       ⑤ 既定は戻す: 新名 → 旧名の改名（同じ道具）+ 黄金の regen → 触ったファイルと黄金が index とバイト一致（A→B→A の往復）。--keep なら戻さない
# compiler-known の改名: ALPHA_POST="<コマンド>" が書き換えの直後（後の測りの前）に手の追従を当てる（loader の合成コードの文字列等）。
# 往復（--keep なし）では逆の ALPHA_POST_BACK も要る
# 変異の検査: REFS_MUTANT（1 多い / 2 少ない / 3 綴り違い）を書き換えに渡す（REFS_NOPOSTCHECK=1 も渡すと道具の検査を飛ばして V1〜V4 へ通す）。
# 変異のときの戻しは git の index から（往復の道具の改名は使わない — 壊れた木は国勢調査が通らない）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
export SOBER_HASH_SEED=0 SOBER_WORKERS=1
SOBER=$ROOT/bin/sober
sym=${1:?usage: alphacheck.sh <pkg>.<Name> <new> [--keep] [--no-v4]}
new=${2:?usage}
shift 2
keep=0
v4=1
for a in "$@"; do
    case "$a" in
        --keep) keep=1 ;;
        --no-v4) v4=0 ;;
        *) echo "alphacheck: unknown argument $a"; exit 2 ;;
    esac
done
# 対象の類型と綴り（scripts/refs.sh と同じ規則 — トップレベル名 / 欄 / 仮引数）
eval "$(sed -n '/^mode_of()/p;/^name_of()/p;/^with_name()/p' scripts/refs.sh)"
# package の改名（<sym> がパス — 最後の要素に '.' が無い）: 写像はパスと参照名の 2 組（参照名が変わるとき）
pkgmode=0
case "${sym##*/}" in *.*) ;; *) pkgmode=1 ;; esac
pdir() { case "$1" in std/*) echo "src/$1" ;; *) echo "$1" ;; esac; }
if [ $pkgmode = 1 ]; then
    old=${sym##*/}
    MAPARGS=(--pair "$sym=$new")
    [ "${sym##*/}" != "${new##*/}" ] && MAPARGS+=(--pair "${sym##*/}=${new##*/}")
else
    old=$(name_of "$sym")
    MAPARGS=(--pair "$old=$new")
fi
GOLD=(testdata/astjson testdata/checkverdict testdata/corejson testdata/irtext testdata/lltext testdata/loaderjson)
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
map() { node --experimental-strip-types scripts/alphamap.ts "$@"; }

# ① 計画
# 計画は変異込みで取る（触るファイルの一覧 = 戻しの対象。変異 1 は別のファイルの OTHER を書きうる — report-884 の実発）
if [ $pkgmode = 1 ]; then
    scripts/refs.sh --pkgrename "$sym" "$new" --dry-run > "$W/plan" || { echo "alphacheck: package の改名の計画が通らない（上の理由）"; exit 1; }
    # 触るファイル = 書き換え + 移るディレクトリの中身（package の全ファイル）
    { cut -f1 "$W/plan"; git ls-files "$(pdir "$sym")"; } | sort -u > "$W/touched"
else
    scripts/refs.sh --rename "$sym" "$new" --dry-run > "$W/plan" || { echo "alphacheck: 書き換えの計画が通らない（上の理由）"; exit 1; }
    cut -f1 "$W/plan" | sort -u > "$W/touched"
fi
echo "alphacheck: $sym → $new — $(wc -l < "$W/touched") ファイル・$(wc -l < "$W/plan") か所"

# ② 基準 = index
# コーパスの .sober 全部（道具自身を除く）と黄金が index のまま — 触るファイルだけでは足りない（別のファイルの残骸が測りの基準を壊す — report-884 の実発）
# 基準 = index（stage 済みの木 — 未コミットの fixture を含めて往復を見られる）: 作業木 ≡ index・未追跡の .sober / 黄金なし
dirty=$( { git diff --name-only -- '*.sober' "${GOLD[@]}" ':!src/compiler/tools/refs' ':!bootstrap' ':!src/stage1'; git ls-files --others --exclude-standard -- '*.sober' "${GOLD[@]}" ':!bootstrap' ':!src/stage1'; } )
[ -z "$dirty" ] || { echo "alphacheck: .sober か黄金に stage されていない変更がある（基準 = index）:"; echo "$dirty" | head; exit 1; }

# ③ entry の選定: 触るファイルを読む entry
scripts/refs.sh --entries > "$W/entries"
: > "$W/sel"
for cwd in . src/compiler; do
    es=$(awk -F'\t' -v c="$cwd" '$1 == c { print $2 }' "$W/entries")
    std=$( [ "$cwd" = . ] && echo src/std || echo ../std )
    # shellcheck disable=SC2086
    (cd "$cwd" && "$ROOT/out/refs/refs" files "$std" $es) |
    awk -F'\t' -v c="$cwd" 'NR == FNR { t[$1] = 1; next }
        { p = $2; if (p ~ /^std\//) p = "src/" p; else if (c != ".") p = c "/" p; if (p in t) print c "\t" $1 }' "$W/touched" - | sort -u >> "$W/sel"
done
echo "alphacheck: 測る entry $(wc -l < "$W/sel")"

measure() { # $1 = 置き場
    mkdir -p "$1"
    while IFS=$'\t' read -r cwd e; do
        printf '%s\t%s\t%s\n' "$1" "$cwd" "$e"
    done < "$W/sel" | xargs -P "$(nproc)" -d '\n' -n 1 bash -c '
        IFS=$'"'"'\t'"'"' read -r d cwd e <<< "$0"
        id=$(printf "%s/%s" "$cwd" "$e" | sed "s,^\./,," | tr "/" "_")
        cd "'"$ROOT"'/$cwd" || exit 0
        { "'"$SOBER"'" check "$e" --core-json; echo "exit=$?"; } > "$d/$id.core" 2> "$d/$id.coreerr"
        { "'"$SOBER"'" build "$e" --emit=ir -o "$d/$id.ir"; echo "exit=$?"; } > "$d/$id.irlog" 2>&1
        { "'"$SOBER"'" build "$e" -o "$d/$id.elf"; echo "exit=$?"; } > "$d/$id.elflog" 2>&1
        true'
}

"$SOBER" --version > /dev/null 2>&1 || { echo "alphacheck: bin/sober が動かない"; exit 1; } # stage2 を先に（std が変わると作り直し — 測りの中で並列に建てない）
measure "$W/before"
# 基準の健全性: 書き換えの前に check が通る entry が 1 つも無ければ測りが壊れている（全部同じ失敗なら V1〜V3 は素通りする）
okb=$(grep -l 'exit=0$' "$W"/before/*.core 2> /dev/null | wc -l) # check の JSON は末尾に改行が無い — exit= は同じ行に付く
[ "$okb" -gt 0 ] || { echo "alphacheck: 書き換えの前の check が 1 つも通らない — 基準が壊れている"; exit 1; }
echo "alphacheck: 書き換えの前に check が通る entry $okb"
# ④ 書き換え（書き換えの赤も最終の判定に入れる — 変異でない走りで道具の検査が赤なら RED）
red=0
if [ $pkgmode = 1 ]; then scripts/refs.sh --pkgrename "$sym" "$new" > "$W/applied"; else scripts/refs.sh --rename "$sym" "$new" > "$W/applied"; fi
rc=$?
if [ $rc -ne 0 ]; then
    echo "alphacheck: 書き換えが赤（終了コード $rc — 道具の字句列の照合か国勢調査）"
    red=1
elif [ -n "${ALPHA_POST:-}" ]; then
    # compiler-known の改名の手の追従（loader の合成コードの文字列等 — 道具は文字列を書かない）を書き換えと同じ「後」の木に入れる
    echo "alphacheck: 手の追従（ALPHA_POST）: $ALPHA_POST"
    bash -c "$ALPHA_POST" || { echo "alphacheck: ALPHA_POST が落ちた"; red=1; }
fi
"$SOBER" --version > /dev/null 2>&1 || echo "alphacheck: 書き換えの後の bin/sober が動かない（stage2 の作り直しが落ちた — std の書き換えが壊した）"
measure "$W/after"

v1=0; v2=0; v3=0; v3run=0
while IFS=$'\t' read -r cwd e; do
    id=$(printf "%s/%s" "$cwd" "$e" | sed "s,^\./,," | tr "/" "_")
    b=$W/before/$id a=$W/after/$id
    # V1: 受理された check はコアのバイト一致・拒否は終了コードと診断の写像一致
    if ! cmp -s "$b.core" "$a.core" && ! map --core "${MAPARGS[@]}" "$b.core" "$a.core" > "$W/m" 2>&1; then
        echo "V1 RED: $cwd/$e — check --core-json がバイト一致せず、文字列の中の名前の写像でも説明できない"; head -5 "$W/m"; red=1; v1=$((v1 + 1))
    elif ! map --cols "${MAPARGS[@]}" "$b.coreerr" "$a.coreerr" > "$W/m" 2>&1; then
        echo "V1 RED: $cwd/$e — check の診断"; head -5 "$W/m"; red=1; v1=$((v1 + 1))
    fi
    # V2: IR の写像一致（ビルドの成否と診断も）
    if ! map --cols "${MAPARGS[@]}" "$b.irlog" "$a.irlog" > "$W/m" 2>&1; then
        echo "V2 RED: $cwd/$e — build --emit=ir の成否 / 診断"; head -5 "$W/m"; red=1; v2=$((v2 + 1))
    elif [ -f "$b.ir" ] && ! map --cols --ir "${MAPARGS[@]}" "$b.ir" "$a.ir" > "$W/m" 2>&1; then
        echo "V2 RED: $cwd/$e — IR"; head -5 "$W/m"; red=1; v2=$((v2 + 1))
    fi
    # V3: ELF のバイト一致、違えば実行の写像一致
    if ! map --cols "${MAPARGS[@]}" "$b.elflog" "$a.elflog" > "$W/m" 2>&1; then
        echo "V3 RED: $cwd/$e — build の成否 / 診断"; head -5 "$W/m"; red=1; v3=$((v3 + 1))
    elif [ -f "$b.elf" ] && ! cmp -s "$b.elf" "$a.elf"; then
        v3run=$((v3run + 1))
        for s in before after; do
            f=$W/$s/$id
            chmod +x "$f.elf"
            (cd "$ROOT/$cwd" && { timeout 10 "$f.elf" < /dev/null; echo "exit=$?"; } > "$f.run" 2>&1)
        done
        if ! map --cols "${MAPARGS[@]}" "$b.run" "$a.run" > "$W/m" 2>&1; then
            echo "V3 RED: $cwd/$e — ELF が違い実行の出力も写像で説明できない"; head -5 "$W/m"; red=1; v3=$((v3 + 1))
        fi
    fi
done < "$W/sel"
echo "alphacheck: V1 赤 $v1・V2 赤 $v2・V3 赤 $v3（ELF が違って走らせた entry $v3run）"

# V4: 黄金
v4bad=0
if [ $v4 -eq 1 ]; then
    scripts/regen.sh > "$W/regen.log" 2>&1 || { echo "V4 RED: regen.sh が落ちた"; tail -5 "$W/regen.log"; red=1; }
    scripts/loaderjson.sh --regen > "$W/ljregen.log" 2>&1 || { echo "V4 RED: loaderjson --regen が落ちた"; red=1; }
    { git diff --name-status -- "${GOLD[@]}"; git ls-files --others --exclude-standard -- "${GOLD[@]}" | sed 's/^/A\t/'; } > "$W/gold"
    while read -r st f; do
        src=$f
        if [ "$st" = A ] && [ $pkgmode = 1 ]; then
            # package の改名で動いた黄金（パスが package のパスを含む）: 写像を逆に当てた旧いパスが消えていれば組にして中身を比べる
            g=${f/$new/$sym}
            if [ "$g" != "$f" ] && grep -qx "D"$'\t'"$g" "$W/gold"; then src=$g; st=M; fi
        fi
        if [ "$st" = D ] && [ $pkgmode = 1 ] && grep -qx "A"$'\t'"${f/$sym/$new}" "$W/gold"; then continue; fi
        if [ "$st" != M ]; then
            echo "V4 RED: 黄金が足された / 消えた（$st $f）"; red=1; v4bad=$((v4bad + 1)); continue
        fi
        git show ":$src" > "$W/gold.old"
        # 黄金の種類ごとの照合の形（文字列の定数の復号 — 名前やパスが panic の位置・文面の文字列に入る）
        gf=(--cols)
        case "$f" in *.ir) gf+=(--ir) ;; *.ll) gf+=(--ll) ;; testdata/corejson/*) gf+=(--core) ;; esac
        if ! map "${gf[@]}" "${MAPARGS[@]}" "$W/gold.old" "$f" > "$W/m" 2>&1; then
            echo "V4 RED: $f"; head -5 "$W/m"; red=1; v4bad=$((v4bad + 1))
        fi
    done < "$W/gold"
    echo "alphacheck: V4 — 変わった黄金 $(wc -l < "$W/gold")・説明できない $v4bad"
fi

# ⑤ 戻す
if [ $keep -eq 0 ]; then
    if [ -n "${REFS_MUTANT:-}" ] || [ $rc -ne 0 ]; then
        # 変異 / 赤の書き換えの木は道具では戻せない — 触ったファイル（② で index と一致を確かめた）を index から
        # package の改名はディレクトリを戻してから（mv — 新しいパスに在って旧いパスに無いときだけ）
        if [ $pkgmode = 1 ] && [ -d "$(pdir "$new")" ] && [ ! -d "$(pdir "$sym")" ]; then mkdir -p "$(dirname "$(pdir "$sym")")"; mv "$(pdir "$new")" "$(pdir "$sym")"; rmdir -p "$(dirname "$(pdir "$new")")" 2> /dev/null || true; fi
        git checkout -- $(cat "$W/touched")
        [ $v4 -eq 1 ] && { git checkout -- "${GOLD[@]}"; git clean -fq -- "${GOLD[@]}"; }
        echo "alphacheck: 戻し = git の index から（変異 / 赤の書き換え）"
    else
        if [ -n "${ALPHA_POST:-}" ]; then
            [ -n "${ALPHA_POST_BACK:-}" ] && bash -c "$ALPHA_POST_BACK" || { echo "alphacheck: 往復には ALPHA_POST_BACK（手の追従の逆）が要る"; red=1; }
        fi
        if [ $pkgmode = 1 ]; then
            REFS_MUTANT= REFS_NOPOSTCHECK= scripts/refs.sh --pkgrename "$new" "$sym" > /dev/null || { echo "alphacheck: 戻しの package の改名（$new → $sym）が赤"; red=1; }
        else
            REFS_MUTANT= REFS_NOPOSTCHECK= scripts/refs.sh --rename "$(with_name "$sym" "$new")" "$old" > /dev/null || { echo "alphacheck: 戻しの改名（$new → $old）が赤"; red=1; }
        fi
        [ $v4 -eq 1 ] && { scripts/regen.sh > "$W/regen2.log" 2>&1; scripts/loaderjson.sh --regen > /dev/null 2>&1; }
        back=$( { git diff --name-only -- $(cat "$W/touched") "${GOLD[@]}"; git ls-files --others --exclude-standard -- "${GOLD[@]}"; } )
        if [ -n "$back" ]; then
            echo "alphacheck: 往復 RED — A→B→A が index とバイト一致しない:"; echo "$back" | head; red=1
        else
            echo "alphacheck: 往復 ok — A→B→A で触ったファイル $(wc -l < "$W/touched") 本と黄金が index とバイト一致"
        fi
    fi
fi
[ $red -eq 0 ] && echo "alphacheck: ALL GREEN" || echo "alphacheck: RED"
exit $red
