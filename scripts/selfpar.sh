#!/usr/bin/env bash
# selfpar（段 6 P6-1 / P6-3）: コンパイラ自身の並列（check の Def の区間 — compiler/checker/core.sober の
# checkCoreX・脱糖 + 検査の区間 — compiler/checker/e2s.sober の checkRoundPar）がワーカー数・天井に依らず逐次と同じバイトを出すことの網。
# gates は全体に SOBER_WORKERS=1 を export するので、ここだけ明示で W8 / 天井 0 を掛ける。
#   1. 自己 check（compiler/app — std を写した作業木）の判定 JSON: 1 本の経路（SOBER_DESUGAR_PAR=0 — 脱糖を区間に割らない）≡ W1 ≡ W8 ≡ W8 + 天井 0
#      （SOBER_BUDGET_MB=0 — 全区間が縮退）。自己の iface（L0 を使わない ExclE2 — std の本体も区間で脱糖する・`@expand`）: 1 本の経路 ≡ W8
#   2. 合成例（区間が複数になる大きさ・def error を区間をまたいで置く）の判定と --def-index: 黄金（testdata/selfpar — 逐次の検査器の出力）≡ W1 ≡ W8 ≡ 天井 0。
#      W8 では区間が子 task で走ったこと（SOBER_PAR_STATS の ended > 1）も見る
#   3. 変異: 区間の結果を逆順に畳む検査器を建てると 2 の --def-index が割れること・脱糖 + 検査の区間の合流で根の区間だけを見る
#      検査器を建てると 2 の判定が割れること（網の自己検査）
#   4. 層の並走（段 6 P6-2 — checkFront）: 拒否の層を重ねた例の出力が逐次の経路 ≡ W1 ≡ W8 ≡ 天井 0 + 合流の優先順の変異
#   5. バックエンドの関数の並列（段 6 P6-4 — xParEmit）: 自己 build の ELF が逐次の経路 ≡ W1 ≡ W8 ≡ 天井 0 + 群の合流の逆順の変異
#   6. lower の頭の関数単位化（席 A — compiler/lower/split.sober）: 自己 build の ELF が群の子で下ろして LIFO を模擬した形（SOBER_LOWER_SPLIT=3・
#      子が受け持ちを逆順に下ろす SOBER_LOWER_REV=1）≡ 1 本の経路 + 文字列の rodata の事象を抜くと割れる変異。W8 + SOBER_LOWER_SPLIT=8 は
#      群の子（task.Map — A-2）で下ろす形・SOBER_LOWER_SPLIT=1 は直の道を強制する形 — どちらも 1 本の経路と同じ ELF（W>1 の既定は分割の道 —
#      口を外した W8 で証人 groups=8 fallback=none。gates の SOBER_LOWER_SPLIT=1 の固定は j_build が外す）。子の死（SOBER_LOWER_DIE=1）→ 直の道も同じ ELF（証人 #lower split … fallback=died）+ 死を見ずに模擬へ進むと割れる変異
#   7. finish の検査だけの段の並列（席 D の D-2 — compiler/loader/finpar.sober）: 自己 build の W8 は子の道（証人 #finish … fallback=none）・
#      子の死（SOBER_FINISH_DIE=1）→ 直の道も同じ ELF。拒否を 2 ファイルに置いた例（testdata/selfpar/finish — 同じ段 / 段をまたぐ / catch の左辺）の
#      出力が W1（直の道）≡ W2 ≡ W8 ≡ W12 ≡ W8 + 子の死。変異 11〜13: 後のファイルの当たりを選ぶ・規則の位置を後のファイルで上書きする・子の死を見ない
#   8. irinl の並びに依らない展開（report-1185）: 自己 build の ELF が処理の入力の並びの撹拌（SOBER_IRINL_ORDER=1 逆順 / 7 乱順）≡ 1 本の経路 +
#      入力の並びのまま処理する変異 14（撹拌で割れること）
#   並列（ゲートの高速化便 R0 — report-1220）: 各回の実行と変異の 1 本ずつを gatelib の par_run の仕事にして $JOBS 本ずつ並べる（単体の既定 4）。
#   仕事は自分の作業ディレクトリ（$PAR_W）だけに書き、変異は専用の木の写しを sed する（共有の $W/tree は読むだけ）。1 本の経路の ELF（bseq）との
#   照合は全部の仕事が終わってから。FAIL の行と最後の要約の行の形は逐次の版と同じ
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
S2=${STAGE2:-out/stage2/sober2}
S2=$(cd "$(dirname "$S2")" && pwd)/$(basename "$S2")
G=$ROOT/testdata/selfpar
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
JOBS=${JOBS:-4}
par_init "$W"
fail=0
gen() { # gen <関数の数> <行の数> <def error の関数の番号（空白区切り）>
    local n=$1 l=$2 bad=" $3 " i j
    echo "package main"
    echo
    for i in $(seq 0 $((n - 1))); do
        echo "func f$i(a int) int {"
        echo "    mut x := a"
        for j in $(seq 1 "$l"); do echo "    x = x + $j"; done
        if [[ $bad == *" $i "* ]]; then echo "    return \"no\""; else echo "    return x"; fi
        echo "}"
        echo
    done
    echo "func main() {"
    echo "    println(f0(1))"
    echo "}"
}
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
mkdir -p "$W/syn"
gen 120 150 "7 61 113" > "$W/syn/syn.sober"
gen 120 150 "61" > "$W/syn/one.sober"
gen 120 150 "" > "$W/syn/ok.sober"
mytree() { # 仕事専用の木の写し（変異を sed する置き場）→ $PAR_W/tree
    mkdir -p "$PAR_W/tree"
    cp -r "$W/tree/." "$PAR_W/tree/"
}
mutbuild() { # mutbuild <番号> <説明> — 写しの木（sed 済み）から変異の検査器を $W/mut<番号> に建てる。失敗は FAIL の行で 1 を返す
    if (cd "$PAR_W/tree" && "$S2" build app --emit=elf --passes -o "$W/mut$1" > "$PAR_W/mutlog" 2>&1); then
        chmod +x "$W/mut$1"
        return 0
    fi
    echo "FAIL: mutant $2build: $(head -c 200 "$PAR_W/mutlog")"
    return 1
}
anchor() { # anchor <ファイル（写しの木の中）> <grep の式> <FAIL の文> — 変異の錨が無ければ FAIL の行
    grep -q "$2" "$PAR_W/tree/$1" || echo "FAIL: $3"
}

# 1. 自己 check（判定 JSON と iface — 照合は全部の仕事の後）
j_self() { # j_self <名前> <env…>
    local v=$1
    shift
    if [ "$v" = self1 ]; then
        (cd "$W/tree" && env "$@" /usr/bin/time -f %M -o "$W/self1.rss" "$S2" check app > "$W/$v" 2>&1)
    else
        (cd "$W/tree" && env "$@" "$S2" check app > "$W/$v" 2>&1)
    fi
    return 0
}
j_iface() { # j_iface <名前> <env…>
    local v=$1
    shift
    (cd "$W/tree" && env "$@" "$S2" iface app > "$W/$v" 2>&1)
    return 0
}
# 2. 合成例
chk() { # chk <検査器> <例> <W> [天井] → 判定と --def-index を stdout に（SOBER_PAR_STATS の stderr は $PAR_W/stats）
    local s=$1 e=$2 w=$3 b=${4:-}
    (cd "$W/syn" && { env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} SOBER_PAR_STATS=1 "$s" check "$e.sober" 2> "$PAR_W/stats"; env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} "$s" check "$e.sober" --def-index 2>&1; })
}
n=9
j_syn() {
    local e cfg ended
    for e in syn one ok; do
        for cfg in "1" "8" "8 0"; do
            # shellcheck disable=SC2086
            chk "$S2" $e $cfg > "$PAR_W/out"
            if ! cmp -s "$G/$e.expected" "$PAR_W/out"; then
                echo "FAIL: $e (W=$cfg) differs from the golden"
                diff "$G/$e.expected" "$PAR_W/out" | head -6
            fi
            if [ "$cfg" = 8 ]; then
                ended=$(grep '^#par tasks' "$PAR_W/stats" | sed 's/.*ended=\([0-9]*\).*/\1/')
                [ "${ended:-0}" -gt 1 ] || echo "FAIL: $e (W=8) ran no child task (ended=${ended:-?}) — the ranges were not split"
            fi
        done
    done
    return 0
}
# 3. 変異: 区間の結果を逆順に畳む
j_mut1() {
    mytree
    anchor checker/core.sober 'o := outs\[k\]' "mutant: the merge loop (o := outs[k]) was not found in checker/core.sober"
    sed -i 's/o := outs\[k\]/o := outs[len(outs) - 1 - k]/' "$PAR_W/tree/checker/core.sober"
    mutbuild 1 "" || return 0
    chk "$W/mut1" syn 8 > "$PAR_W/out"
    if cmp -s "$G/syn.expected" "$PAR_W/out"; then
        echo "FAIL: mutant (merge in reverse) was not caught"
    fi
    return 0
}
# 3'. 変異: 脱糖 + 検査の区間の合流で根の区間（添字 0）だけを見る（one / syn の def error を落とす）
j_mut2() {
    mytree
    anchor checker/e2s.sober 'o := outs\[(k + 1) % len(outs)\]' "mutant 2: the merge loop was not found in checker/e2s.sober"
    sed -i 's/o := outs\[(k + 1) % len(outs)\]/o := outs[0]/' "$PAR_W/tree/checker/e2s.sober"
    mutbuild 2 "2 " || return 0
    (cd "$W/syn" && SOBER_WORKERS=8 "$W/mut2" check one.sober > "$PAR_W/out" 2>&1)
    if head -n 1 "$G/one.expected" | cmp -s - "$PAR_W/out"; then
        echo "FAIL: mutant 2 (merge only the root range) was not caught"
    fi
    return 0
}
# 4. 層の並走（段 6 P6-2 — compiler/app/cmd_check.sober の checkFront: ParCheck ‖ analyzer ‖ check を子で走らせ逐次の優先順で畳む）:
#    拒否の層を重ねた例の出力（標準出力 + 標準エラー + 終了コード）が逐次の経路（SOBER_DESUGAR_PAR=0）≡ W1 ≡ W8 ≡ 天井 0。
#    変異: 合流で ParCheck の拒否を見ない（analyzer の指摘が先に出る）と front_all が割れること
front() { # front <検査器> <例> [env…] → 出力と rc
    local s=$1 e=$2
    shift 2
    (cd "$G" && env "$@" "$s" check "$e.sober" 2>&1; echo "rc=$?")
}
nf=9
j_front() {
    local e cfg
    for e in front_all front_an front_ck; do
        front "$S2" $e SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8 > "$PAR_W/fseq"
        grep -q '^rc=1$' "$PAR_W/fseq" || echo "FAIL: front $e (1-path) was not rejected"
        for cfg in "SOBER_WORKERS=1" "SOBER_WORKERS=8" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0"; do
            # shellcheck disable=SC2086
            front "$S2" $e $cfg > "$PAR_W/fpar"
            cmp -s "$PAR_W/fseq" "$PAR_W/fpar" || { echo "FAIL: front $e ($cfg) differs from the 1-path"; diff "$PAR_W/fseq" "$PAR_W/fpar" | head -4; }
        done
    done
    return 0
}
j_mut3() {
    mytree
    anchor app/cmd_check.sober '    if pm != "" {' "mutant 3: the merge (if pm != \"\") was not found in app/cmd_check.sober"
    sed -i 's/    if pm != "" {/    if false {/' "$PAR_W/tree/app/cmd_check.sober"
    mutbuild 3 "3 " || return 0
    front "$S2" front_all SOBER_DESUGAR_PAR=0 > "$PAR_W/fseq"
    front "$W/mut3" front_all SOBER_WORKERS=8 > "$PAR_W/fpar"
    if cmp -s "$PAR_W/fseq" "$PAR_W/fpar"; then
        echo "FAIL: mutant 3 (merge without the ParCheck layer) was not caught"
    fi
    return 0
}
# 5. バックエンドの関数の並列（段 6 P6-4 — compiler/lower/x86.sober の xParEmit: 切替 / 罠を持たない関数を群の子で吐いて吐く順に連結）:
#    自己 build（--passes の ELF）が 1 本の経路（SOBER_BUILD_PAR=0）≡ W1 ≡ W8 ≡ W8 + 天井 0 のバイト一致・W8 で群の子が走った証人（ended > 1）。
#    変異: 群の結果を逆順に連結すると ELF が割れること。
#    移し器の往復（段 4 後半 ラウンド 9 — compiler/lower/move.sober: SOBER_BUILD_PAR=roundtrip で束の前ごとに全関数の本体を詰め、旧い本体を毒で
#    潰して積み直す）も同じ ELF。変異: 積み直しでブロックの命令の尾（B_ITAIL）を付け替えないと割れること。
#    W8 は lower の束（B1 / B2）も群の子で回す（ラウンド 10 — lParBatch）: 1 本の経路はそれも外す。変異: 子の B1 の列から licm を抜くと割れること
BCFGS=("SOBER_WORKERS=1" "SOBER_WORKERS=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0" "SOBER_WORKERS=8 SOBER_BUILD_PAR=roundtrip" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_IRINL_ORDER=1" "SOBER_WORKERS=8 SOBER_IRINL_ORDER=7")
j_bseq() {
    (cd "$W/tree" && SOBER_BUILD_PAR=0 SOBER_LOWER_SPLIT=1 SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$W/bseq" > "$PAR_W/blog" 2>&1) || echo "FAIL: self build (1-path): $(head -c 200 "$PAR_W/blog")"
    return 0
}
j_build() { # j_build <番号> — BCFGS の 1 本。ELF は $W/bpar<番号>（bseq との照合は後）・証人の行はここで見る
    local i=$1 cfg=${BCFGS[$1]} ended
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_LOWER_SPLIT $cfg "$S2" build app --emit=elf --passes -o "$W/bpar$i" > "$PAR_W/blog" 2>&1) || echo "FAIL: self build ($cfg): $(head -c 200 "$PAR_W/blog")"
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        ended=$(grep '^#par tasks' "$PAR_W/blog" | sed 's/.*ended=\([0-9]*\).*/\1/')
        [ "${ended:-0}" -gt 1 ] || echo "FAIL: self build (W=8) ran no group task (ended=${ended:-?})"
    fi
    # 席 A の証人（A-2）: W8 の既定は分割の道（群の数 = ワーカー数・最後まで子の道）・口 SPLIT=8 は分割の道を最後まで通る（fallback=none）・SOBER_LOWER_DIE は
    # 子の死 → 直の道（fallback=died）で、捕まった死は印字されない
    # 名前付き関数型の写し（desugar/namedval.sober — 席 D の D-1）: 自己 build には写す呼び出しが無い（loader の写しの後に宙に浮いた KNamedArg の節は
    # 数えない）ので表層型検査器を走らせない（typed=0 — 全体の TypeAll の 2 回目を走らせない）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#namedval typed=0' "$PAR_W/blog" || echo "FAIL: self build (W=8) ran the surface typer for named value args: $(grep '^#namedval' "$PAR_W/blog")"
    fi
    # finish の検査だけの段（loader/finpar.sober — 席 D の D-2）: W8 は子の道を最後まで通る・SOBER_FINISH_DIE は子の死 → 直の道（捕まった死は印字されない）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\)=[0-9]* fallback=none$' "$PAR_W/blog")" = 2 ] || echo "FAIL: self build (W=8) did not take the finish child path: $(grep '^#finish' "$PAR_W/blog")"
    fi
    if [[ $cfg == *FINISH_DIE* ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\)=[0-9]* fallback=died$' "$PAR_W/blog")" = 2 ] || echo "FAIL: self build ($cfg) did not fall back on the finish child death: $(grep '^#finish' "$PAR_W/blog")"
        if grep -qv '^#' "$PAR_W/blog"; then echo "FAIL: self build ($cfg) printed on stderr: $(grep -v '^#' "$PAR_W/blog" | head -c 200)"; fi
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#lower split groups=8 fallback=none' "$PAR_W/blog" || echo "FAIL: self build (W=8, no knob) did not take the default lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#lower split groups=8 fallback=none' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    # 逆順の子も最後まで子の道で（拒否で直の道へ黙って戻ると ELF は一致してしまう — 段 4 R4 で子が親の店を受け取る形の網）
    if [[ $cfg == *LOWER_REV* ]]; then
        grep -qx '#lower split groups=3 fallback=none' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    if [[ $cfg == *LOWER_DIE* ]]; then
        grep -qx '#lower split groups=8 fallback=died' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not fall back on the child death: $(grep '^#lower' "$PAR_W/blog")"
        if grep -qv '^#' "$PAR_W/blog"; then echo "FAIL: self build ($cfg) printed on stderr: $(grep -v '^#' "$PAR_W/blog" | head -c 200)"; fi
    fi
    return 0
}
# 席 A の子が γ の当たりの店を受け取る形（段 5 R3 — 置き場の切り口 γ: 親の TypeAll が区画を読み戻した店を子へ渡す）: 同じ置き場で冷 → 温を
# 逆順の子（SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1）で建て、温の ELF（$W/bcache）が bseq と一致・温で γ が全部当たり・子の道を最後まで通る
j_cache() {
    local c=$PAR_W/cache cfg="SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1 SOBER_PAR_STATS=1 SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1"
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY $cfg SOBER_CACHE="$c" "$S2" build app --emit=elf --passes -o "$PAR_W/bcold" > "$PAR_W/blog" 2>&1) || { echo "FAIL: self build (cache cold, split): $(head -c 200 "$PAR_W/blog")"; return 0; }
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY $cfg SOBER_CACHE="$c" "$S2" build app --emit=elf --passes -o "$W/bcache" > "$PAR_W/blog" 2>&1) || { echo "FAIL: self build (cache warm, split): $(head -c 200 "$PAR_W/blog")"; return 0; }
    grep -qx '#lower split groups=3 fallback=none' "$PAR_W/blog" || echo "FAIL: self build (cache warm, split) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    grep -q '^cache: alpha .* gamma \([0-9]*\)/\1 ' "$PAR_W/blog" || echo "FAIL: self build (cache warm, split) — gamma did not hit every package: $(grep '^cache: alpha' "$PAR_W/blog" | head -c 160)"
    return 0
}
# 変異 4〜9 は「変異の検査器で元の木を建てた ELF（$W/bmut<番号>）が bseq と割れること」— 照合は全部の仕事の後（建たなければ ELF が無く、割れた扱い）
# mutelf <番号> <元のファイル（木の中）> <env…> — 写しの木を元に戻してから変異の検査器で建てる
mutelf() {
    local k=$1 f=$2
    shift 2
    cp "$W/tree/$f" "$PAR_W/tree/$f"
    (cd "$PAR_W/tree" && env "$@" "$W/mut$k" build app --emit=elf --passes -o "$W/bmut$k" > "$PAR_W/blog" 2>&1)
}
# 変異 4: 群の結果を逆順に連結する
j_mut4() {
    mytree
    anchor lower/x86.sober '        xParMerge(mut st, mut c, mut fx, mut fstart, outs\[k\], of, j)' "mutant 4: the merge (xParMerge … outs[k]) was not found in lower/x86.sober"
    sed -i 's/        xParMerge(mut st, mut c, mut fx, mut fstart, outs\[k\], of, j)/        xParMerge(mut st, mut c, mut fx, mut fstart, outs[len(outs) - 1 - k], of, j)/' "$PAR_W/tree/lower/x86.sober"
    mutbuild 4 "4 " || return 0
    mutelf 4 lower/x86.sober SOBER_WORKERS=8
    return 0
}
# 変異 5: 移し器の往復で B_ITAIL を付け替えない
j_mut5() {
    mytree
    anchor lower/move.sober '^        mvRel(mut q, at + B_ITAIL, base)$' "mutant 5: the B_ITAIL relocation was not found in lower/move.sober"
    sed -i '/^        mvRel(mut q, at + B_ITAIL, base)$/d' "$PAR_W/tree/lower/move.sober"
    mutbuild 5 "5 " || return 0
    mutelf 5 lower/move.sober SOBER_BUILD_PAR=roundtrip
    return 0
}
# 変異 6（段 4 後半 ラウンド 10 — lower の束の群の子 move.sober の lParGroup）: 子の B1 の列から licm を抜くと W8 の自己 build の ELF が割れること
j_mut6() {
    mytree
    anchor lower/move.sober '^    licmFunc(mut st, f)$' "mutant 6: the licm call was not found in lower/move.sober"
    sed -i '/^    licmFunc(mut st, f)$/d' "$PAR_W/tree/lower/move.sober"
    mutbuild 6 "6 " || return 0
    mutelf 6 lower/move.sober SOBER_WORKERS=8
    return 0
}
# 変異 7（凍結の口 — 仮裁定 2026-10-07 夜間）: xModule の入口のヒープの凍結（table.Freeze と hfOn）を抜くと、x86 の群の子が空の凍結の表を
# 読んで W8 の自己 build が建たない / 割れること
j_mut7() {
    mytree
    anchor lower/x86.sober '^ *st.hf = desugar.HeapFreeze(mut st.d)$' "mutant 7: the heap freeze was not found in lower/x86.sober"
    # 字下げは問わない（xModule の凍結は扉の監査〔SOBER_CACHE_VERIFY=2〕の else の中 — report-1200）
    sed -i '/^ *st.hf = desugar.HeapFreeze(mut st.d)$/d; /^ *st.hfOn = true$/d' "$PAR_W/tree/lower/x86.sober"
    mutbuild 7 "7 " || return 0
    mutelf 7 lower/x86.sober SOBER_WORKERS=8
    return 0
}
# 変異 8（席 A — split.sober）: 子が文字列の rodata の事象を記録しないと、親の模擬が綴りの初出の順を知らず rodata の番号・並びが割れること
j_mut8() {
    mytree
    anchor lower/cont.sober '^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$' "mutant 8: the string event was not found in lower/cont.sober"
    sed -i '/^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$/d' "$PAR_W/tree/lower/cont.sober"
    mutbuild 8 "8 " || return 0
    mutelf 8 lower/cont.sober SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3
    return 0
}
# 変異 9（席 A の A-2 — split.sober）: 群の子の死（task.Map の err）を見ずに模擬へ進むと、SOBER_LOWER_DIE の自己 build が建たない / 割れること
j_mut9() {
    mytree
    anchor lower/split.sober '^    if serr != nil {$' "mutant 9: the child death check was not found in lower/split.sober"
    sed -i 's/^    if serr != nil {$/    if serr != nil \&\& k < 0 {/' "$PAR_W/tree/lower/split.sober"
    mutbuild 9 "9 " || return 0
    mutelf 9 lower/split.sober SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1
    return 0
}
# 変異 10（席 D の D-1 — desugar/namedval.sober）: 名前付きの実引数を持つ呼び出しを含む関数に印を付けないと、写しが型の無い呼び先を読み、
# 的（testdata/selfpar/named_reach — `T?` の名前付き関数型が無いプログラムの名前付きの呼び出し・表層型を付けるのは 3 関数のうち 1 つ = 証人）が建たない / 割れること
j_mut10() {
    mytree
    anchor desugar/namedval.sober '^                        lput(mut st, mark, fi, 1)$' "mutant 10: the nvReach mark was not found in desugar/namedval.sober"
    sed -i '/^                        lput(mut st, mark, fi, 1)$/d' "$PAR_W/tree/desugar/namedval.sober"
    mutbuild 10 "10 " || return 0
    SOBER_PAR_STATS=1 "$S2" build "$G/named_reach.sober" --emit=elf --passes -o "$PAR_W/nvok" > "$PAR_W/blog" 2>&1 || echo "FAIL: named_reach build: $(head -c 200 "$PAR_W/blog")"
    grep -qx '#namedval typed=1 bodies=3' "$PAR_W/blog" || echo "FAIL: named_reach typed: $(grep '^#namedval' "$PAR_W/blog")"
    if "$W/mut10" build "$G/named_reach.sober" --emit=elf --passes -o "$PAR_W/nvmut" > "$PAR_W/blog" 2>&1 && cmp -s "$PAR_W/nvok" "$PAR_W/nvmut"; then
        echo "FAIL: mutant 10 (named value args without the typed functions) was not caught"
    fi
    return 0
}
# 7. finish の検査だけの段の並列（席 D の D-2 — loader/finpar.sober）: 拒否を 2 ファイルに置いた例の出力（stderr + 終了コード）が W1（直の道）≡ 子の道
fin() { # fin <検査器> <例> [env…] → 出力と rc
    local s=$1 e=$2
    shift 2
    (cd "$ROOT" && env "$@" "$s" check "testdata/selfpar/finish/$e" 2>&1; echo "rc=$?")
}
FINS="names_same names_cross rules_same rules_cross rules_catch"
nfin=20
j_fin() {
    local e cfg
    for e in $FINS; do
        fin "$S2" $e SOBER_WORKERS=1 > "$PAR_W/fin1"
        grep -q '^rc=1$' "$PAR_W/fin1" || echo "FAIL: finish $e (W1) was not rejected"
        for cfg in "SOBER_WORKERS=2" "SOBER_WORKERS=8" "SOBER_WORKERS=12" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1"; do
            # shellcheck disable=SC2086
            fin "$S2" $e $cfg > "$PAR_W/finp"
            cmp -s "$PAR_W/fin1" "$PAR_W/finp" || { echo "FAIL: finish $e ($cfg) differs from W1"; diff "$PAR_W/fin1" "$PAR_W/finp" | head -4; }
        done
    done
    return 0
}
# 変異 11〜13（席 D の D-2 — loader/finpar.sober）: 変異した検査器の W8 の出力が W1（直の道）と割れること
j_finmut() { # j_finmut <番号> <説明> <sed の式> <的の例…> — 変異した検査器を建て、的の例のどれかが W8 で W1 と割れれば捕まえた
    local k=$1 what=$2 expr=$3 e caught=0
    shift 3
    mytree
    sed -i "$expr" "$PAR_W/tree/loader/finpar.sober"
    if cmp -s "$W/tree/loader/finpar.sober" "$PAR_W/tree/loader/finpar.sober"; then echo "FAIL: mutant $k: the anchor was not found in loader/finpar.sober"; return 0; fi
    mutbuild "$k" "$k " || return 0
    for e in "$@"; do
        fin "$S2" $e SOBER_WORKERS=1 > "$PAR_W/fin1"
        fin "$W/mut$k" $e SOBER_WORKERS=8 SOBER_FINISH_DIE=$([ "$k" = 13 ] && echo 1 || echo 0) > "$PAR_W/finp"
        cmp -s "$PAR_W/fin1" "$PAR_W/finp" || caught=1
    done
    [ $caught = 1 ] || echo "FAIL: mutant $k ($what) was not caught"
    return 0
}
# 変異 14（irinl の並びに依らない展開 — report-1185）: 呼び出しグラフの順をやめて処理の入力の並びのまま処理すると、撹拌（SOBER_IRINL_ORDER=1）で
# 自己 build の ELF が割れること（上の self build の ORDER=1 / 7 ≡ 1 本の経路 が並び不変の網・この変異がその網の自己検査）
j_mut14() {
    mytree
    anchor lower/irinl.sober '^    ord := ilCallersFirst(mut st, fr, inp)$' "mutant 14: the order (ilCallersFirst) was not found in lower/irinl.sober"
    sed -i 's/^    ord := ilCallersFirst(mut st, fr, inp)$/    ord := inp/' "$PAR_W/tree/lower/irinl.sober"
    mutbuild 14 "14 " || return 0
    cp "$W/tree/lower/irinl.sober" "$PAR_W/tree/lower/irinl.sober"
    (cd "$PAR_W/tree" && SOBER_WORKERS=8 "$W/mut14" build app --emit=elf --passes -o "$PAR_W/bm0" > "$PAR_W/blog" 2>&1)
    (cd "$PAR_W/tree" && SOBER_WORKERS=8 SOBER_IRINL_ORDER=1 "$W/mut14" build app --emit=elf --passes -o "$PAR_W/bm1" > "$PAR_W/blog" 2>&1)
    if cmp -s "$PAR_W/bm0" "$PAR_W/bm1"; then
        echo "FAIL: mutant 14 (irinl in the input order) was not caught"
    fi
    return 0
}

# 仕事の投入（長いものから — 変異は検査器を建ててから自己 build を 1〜2 回）
for k in 4 5 6 7 8 9 14; do par_run "j_mut$k"; done
par_run j_bseq
for i in "${!BCFGS[@]}"; do par_run j_build "$i"; done
par_run j_cache
for k in 1 2 3 10; do par_run "j_mut$k"; done
par_run j_finmut 11 "pick the last file with a names hit" 's/^        if rs\[f\]\.nm {$/        if rs[f].nm \&\& f == n - 1 {/' names_same
par_run j_finmut 12 "later files overwrite the rule positions" 's/^            if hit\[r \* 3\] == 0 \&\& rs\[f\]\.hit\[r \* 3\] > 0 {$/            if rs[f].hit[r * 3] > 0 {/' rules_same
par_run j_finmut 13 "the merge ignores a dead child" 's/^    if cerr != nil {$/    if cerr != nil \&\& n < 0 {/' names_same rules_same
par_run j_self selfseq SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8
par_run j_self self1 SOBER_WORKERS=1
par_run j_self self8 SOBER_WORKERS=8
par_run j_self self0 SOBER_WORKERS=8 SOBER_BUDGET_MB=0
par_run j_iface ifseq SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8
par_run j_iface if8 SOBER_WORKERS=8
par_run j_syn
par_run j_front
par_run j_fin
par_wait > "$W/jobs.out"
cat "$W/jobs.out"
fail=$(grep -c '^FAIL' "$W/jobs.out")

# 全部の仕事の後の照合
grep -q '"ok":true' "$W/self1" || { echo "FAIL: self check (W1) not accepted: $(head -c 200 "$W/self1")"; fail=$((fail + 1)); }
# RSS のラチェット（bench/ratchet.txt の self/check rss — 自己 check〔一括・W1〕の peak RSS。段 6 P6-6 で新設）
rlim=$(awk '$1 == "self/check" && $2 == "rss" { print $3 }' "$ROOT/bench/ratchet.txt")
rss=$(( $(cat "$W/self1.rss") / 1024 ))
if [ -n "$rlim" ] && [ "$rss" -gt "$rlim" ]; then
    echo "FAIL: ratchet — 自己 check（W1）の peak RSS ${rss} MB > ${rlim} MB（bench/ratchet.txt）"; fail=$((fail + 1))
fi
for v in selfseq self8 self0; do
    cmp -s "$W/self1" "$W/$v" || { echo "FAIL: self check $v differs from W1"; diff "$W/self1" "$W/$v" | head -4; fail=$((fail + 1)); }
done
grep -q '^== link.txt' "$W/ifseq" || { echo "FAIL: self iface (1-path) failed: $(head -c 200 "$W/ifseq")"; fail=$((fail + 1)); }
cmp -s "$W/ifseq" "$W/if8" || { echo "FAIL: self iface W8 differs from the 1-path"; diff "$W/ifseq" "$W/if8" | head -4; fail=$((fail + 1)); }
cmp -s "$W/bseq" "$W/bcache" || { echo "FAIL: self build (cache warm, lower split with the reversed child) differs from the 1-path"; fail=$((fail + 1)); }
for i in "${!BCFGS[@]}"; do
    cmp -s "$W/bseq" "$W/bpar$i" || { echo "FAIL: self build (${BCFGS[$i]}) differs from the 1-path"; fail=$((fail + 1)); }
done
mutwhat=([4]="merge the groups in reverse" [5]="roundtrip without relocating B_ITAIL" [6]="the group children skip licm" [7]="no heap freeze before the x86 groups" [8]="the children do not record the string events" [9]="the replay ignores a dead child")
for k in 4 5 6 7 8 9; do
    if [ -e "$W/mut$k" ] && cmp -s "$W/bseq" "$W/bmut$k"; then
        echo "FAIL: mutant $k (${mutwhat[$k]}) was not caught"
        fail=$((fail + 1))
    fi
done
echo "selfpar: self check {1-path (W1 rss ${rss} MB ≤ ${rlim} MB), W 1, 8, 8 + budget 0} + self iface + $n synthetic runs + $nf layered runs + self build {1-path, W 1, 8, 8 + budget 0, 8 + roundtrip, 8 + lower split 3 rev, 8 + lower direct, 8 + lower split 8, 8 + lower split 8 child death, 8 + finish child death, 8 + irinl order rev, 8 + irinl order seed 7} + $nfin finish runs + 14 mutants, fail=$fail"
[ $fail = 0 ]
