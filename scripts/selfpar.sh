#!/usr/bin/env bash
# selfpar（段階6 P6-1 / P6-3）: コンパイラ自身の並列（checkのDefの区間 — compiler/checker/core.soberの
# checkCoreX・脱糖 + 検査の区間 — compiler/checker/e2s.soberのcheckRoundPar）がワーカー数・天井に依らず逐次と同じバイトを出すことの検査。
# gates は全体に SOBER_WORKERS=1 を export するので、ここだけ明示で W8 / 天井 0 を掛ける。
#   1. 自己check（compiler/app — stdをコピーした作業木）の判定JSON: 1本の経路（SOBER_DESUGAR_PAR=0 — 脱糖を区間に割らない）≡ W1 ≡ W8 ≡ W8 + 天井0
#      （SOBER_BUDGET_MB=0 — 全区間が縮退）。自己の iface（L0 を使わない ExclE2 — std の本体も区間で脱糖する・`@expand`）: 1 本の経路 ≡ W8
#   2. 合成例（区間が複数になる大きさ・def errorを区間をまたいで置く）の判定と --def-index: ゴールデン（testdata/selfpar — 逐次の検査器の出力）≡ W1 ≡ W8 ≡ 天井0。
#      W8 では区間が子 task で走ったこと（SOBER_PAR_STATS の ended > 1）も見る
#      区間の子が全部死んだ形（SOBER_CHECK_DIE=1）: 親が同じ本体を区間の順に呼び直し、自己checkの判定JSONと合成例の判定がW1と同じ
#   3. ミューテーション: 区間の結果を逆順に畳む検査器をビルドすると2の --def-index が割れること・脱糖 + 検査の区間の合流で根の区間だけを見る
#      検査器をビルドすると2の判定が割れること（検査の自己検査）
#   4. 層の並走（段階6 P6-2 — checkFront）: 拒否の層を重ねた例の出力が逐次の経路 ≡ W1 ≡ W8 ≡ 天井0 + 合流の優先順のミューテーション
#   5. バックエンドの関数の並列（段階6 P6-4 — xParEmit）: 自己buildのELFが逐次の経路 ≡ W1 ≡ W8 ≡ 天井0 + 群の合流の逆順のミューテーション
#   6. lower の頭の関数単位化（席 A — compiler/lower/split.sober）: 自己 build の ELF が群の子で下ろして LIFO を模擬した形（SOBER_LOWER_SPLIT=3・
#      子が受け持ちを逆順に下ろすSOBER_LOWER_REV=1）≡ 1本の経路 + 文字列のrodataの事象を抜くと割れるミューテーション。W8 + SOBER_LOWER_SPLIT=8は
#      群の子（task.Map — A-2）で下ろす形・SOBER_LOWER_SPLIT=1 は直の道を強制する形 — どちらも 1 本の経路と同じ ELF（W>1 の既定は分割の道 —
#      オプションを外したW8で証人groups=8 fallback=none。gatesのSOBER_LOWER_SPLIT=1の固定はj_buildが外す）。子の死（SOBER_LOWER_DIE=1）→ 直のパスも同じELF（証人 #lower split … fallback=died・標準エラーに死の1行 — loader.ParFellBack）+ 死を見ずに模擬へ進むと割れるミューテーション
#   7. finishの検査だけのフェーズの並列（席DのD-2 — compiler/loader/finpar.sober）: 自己buildのW8は子のパス（証人 #finish … fallback=none）・
#      子の死（SOBER_FINISH_DIE=1）→ 直のパスも同じELF。拒否を2ファイルに置いた例（testdata/selfpar/finish — 同じフェーズ / フェーズをまたぐ / catchの左辺）の
#      出力がW1（直のパス）≡ W2 ≡ W8 ≡ W12 ≡ W8 + 子の死。ミューテーション11〜13: 後のファイルの当たりを選ぶ・規則の位置を後のファイルで上書きする・子の死を見ない
#   9. ParCheckの歩きの並列（compiler/desugar/pcpar.sober）: 自己buildのW8は関数の区間の子のパス（証人 #parcheck … fallback=none）・子の死
#      （SOBER_PARCHECK_DIE=1）→ 逐次の歩きも同じELF。拒否を関数の表の離れた2か所に置いた例（testdata/selfpar/parcheck — 同じ歩き / 歩きをまたぐ）の
#      check と build の出力がW1（逐次）≡ W2 ≡ W8 ≡ W12 ≡ W8 + 子の死。ミューテーション16・17: 後の区間の当たりを選ぶ・子の死を見ない
#  10. finishの木の変換の並列（compiler/loader/ftpar.sober）: 自己buildのW8は子のパス（証人 #finish trees=… fallback=none）・子の死 → 逐次も同じELF。
#      拒否をフェーズとファイルをまたいで置いた例（testdata/selfpar/finish/trees_cross）の build の出力がW1 ≡ W8（証人 fallback=rejected — 逐次でやり直す）≡ W8 + 子の死。
#      ミューテーション18: 子の拒否を見ない
#  11. 最後の検証（vfyFinal）をB2の子の中で（compiler/lower/move.soberのlParBatch・verify.soberのvfyRun）: 既定の検証（SOBER_VERIFYなし）の自己buildのW8は
#      子の結果を使う（証人 #vfyfinal kid=… parent=… dirty=… — 親が検証するのは子の検証の後に書き換えた関数だけ）・ELFは1本の経路と同じ。B2の前にIRを壊すミュータント107（--rt-mutant=107）の診断が W1 ≡ W2 ≡ W8 ≡ W12（同じ1件）。
#      ミューテーション19: 親が子の検証の文面を見ない
#   8. irinl の並びに依らない展開（report-1185）: 自己 build の ELF が処理の入力の並びの撹拌（SOBER_IRINL_ORDER=1 逆順 / 7 乱順）≡ 1 本の経路 +
#      入力の並びのまま処理するミューテーション14（撹拌で割れること）
#  12. noret の並びに依らない終端化: 自己 build の ELF が並びの逆転（SOBER_NORET_ORDER=1）≡ 1 本の経路。題材 testdata/selfpar/noret_order.sober
#      （推移で戻らない関数）も逆転 ≡ 既定。ミューテーション20: 戻らない関数の集合を不動点で求めず、チェーンの順に1レベルずつ判定する（題材の逆転で割れること）
#  13. spec の並びに依らない特化: 自己 build の ELF が作業列の入力の逆転（SOBER_SPEC_ORDER=1）≡ 1 本の経路。ミューテーション21: 作業列を名前の順に
#      並べずチェーンの順のまま回す（自己 build の逆転で割れること — 同じ呼ばれる側を SP_PER より多くの定数の組で呼ぶ package がある）。
#      枠は組の中の呼び出し点の多い順（同数は定数の組の安定なハッシュの順）: 題材 testdata/selfpar/spec_freq.sober の逆転 ≡ 既定・
#      ミューテーション22: 頻度で枠を与える部分を外し作業列の先着に戻す（題材のELFが本物と割れること。要求の道の命令〔reqinst・ringinst〕でも落ちる）
#  14. regionFlow の並びに依らない判定: 自己 build の ELF が判定と書き換えの順の逆転（SOBER_RFLOW_ORDER=1）≡ 1 本の経路
#      （呼び先の遅延の値〔rfMaskOf・rfFreshOf・rfEoOf〕が、呼び先の書き換えの前後で変わらないこと）
#   並列（ゲートの高速化タスクR0 — report-1220）: 各回の実行とミューテーションの1本ずつをgatelibのpar_runの仕事にして $JOBS本ずつ並べる（単体の既定4）。
#   仕事は自分の作業ディレクトリ（$PAR_W）だけに書き、ミューテーションは専用の木のコピーをsedする（共有の $W/treeは読むだけ）。1本の経路のELF（bseq）との
#   照合は全部の仕事が終わってから。FAIL の行と最後の要約の行の形は逐次の版と同じ
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
# 自己 check（W1）の peak RSS は1つのCPUに縛って測る（pin1 — 縛らないとカーネルのRSSの計数の近似で数 MB 揺れる）
read -ra PIN1 <<< "$(pin1)"
S2=${STAGE2:-out/stage2/sober2}
S2=$(cd "$(dirname "$S2")" && pwd)/$(basename "$S2")
G=$ROOT/testdata/selfpar
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
JOBS=${JOBS:-4}
# 検査器の本体の命令数（下のself/check bodyの上限値）: W1の自己checkと、Defの脱糖で止めたcheck（SOBER_CHECK_STOP=defs）を perf stat で包み、差を取る。
# perfが使えなければFAIL。SOBER_GATES_ALLOW_SKIPにperfがあるときだけこの上限値を飛ばす
INSTP=()
need_perf selfpar "the checker body instruction ratchet"; pc=$?
[ $pc = 2 ] && exit 1
[ $pc = 0 ] && INSTP=("$PERF" stat -x, -e instructions:u -o)
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
mytree() { # 仕事専用の木のコピー（ミューテーションをsedする配置先）→ $PAR_W/tree
    mkdir -p "$PAR_W/tree"
    cp -r "$W/tree/." "$PAR_W/tree/"
}
mutbuild() { # mutbuild <番号> <説明> — コピーの木（sed済み）からミュータントの検査器を $W/mut<番号> にビルドする。失敗はFAILの行で1を返す
    if (cd "$PAR_W/tree" && "$S2" build app --emit=elf --passes -o "$W/mut$1" > "$PAR_W/mutlog" 2>&1); then
        chmod +x "$W/mut$1"
        return 0
    fi
    echo "FAIL: mutant $2build: $(head -c 200 "$PAR_W/mutlog")"
    return 1
}
anchor() { # anchor <ファイル（コピーの木の中）> <grepの式> <FAILの文> — ミュータントの錨が無ければFAILの行
    grep -q "$2" "$PAR_W/tree/$1" || echo "FAIL: $3"
}

# 1. 自己 check（判定 JSON と iface — 照合は全部の仕事の後）
# 子の死を逐次で作り直した警告の1行（loader.ParFellBack — 既定の出力）。比べる出力からは除き、$PAR_W/warns（j_selfは $W/<名前>.warns）へ積む。
# 子を殺す設定（SOBER_*_DIE）は、そこに段の警告が出たことを warned で数える（消すための設定は作らない — 出るべき警告なので）
WARN_RE='^sober: [^:]+: a parallel child died '
dewarn() { # stdin → stdout（警告の行を除く）・警告は $1 へ追記
    local t
    t=$(mktemp "$W/dw.XXXXXX")
    cat > "$t"
    grep -E "$WARN_RE" "$t" >> "$1"
    grep -Ev "$WARN_RE" "$t"
    rm -f "$t"
    return 0
}
warned() { # warned <ファイル> <段の正規表現> <説明> — 段の警告が1行以上あること
    grep -Eq "^sober: $2: a parallel child died " "$1" 2> /dev/null || echo "FAIL: $3 did not warn on stderr that the $2 children died"
}
j_self() { # j_self <名前> <env…>
    local v=$1
    shift
    if [ "$v" = self1 ]; then
        if [ "${#INSTP[@]}" -gt 0 ]; then
            (cd "$W/tree" && env "$@" "${INSTP[@]}" "$W/self1.inst" /usr/bin/time -f %M -o "$W/self1.rss" "${PIN1[@]}" "$S2" check app > "$W/$v" 2>&1)
        else
            (cd "$W/tree" && env "$@" /usr/bin/time -f %M -o "$W/self1.rss" "${PIN1[@]}" "$S2" check app > "$W/$v" 2>&1)
        fi
    elif [ "$v" = defs1 ]; then
        [ "${#INSTP[@]}" -gt 0 ] && (cd "$W/tree" && env "$@" "${INSTP[@]}" "$W/defs1.inst" "$S2" check app > "$W/$v" 2>&1)
    else
        : > "$W/$v.warns"
        (cd "$W/tree" && env "$@" "$S2" check app 2>&1 | dewarn "$W/$v.warns" > "$W/$v")
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
    (cd "$W/syn" && { env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} SOBER_PAR_STATS=1 "$s" check "$e.sober" 2> "$PAR_W/stats"; env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} "$s" check "$e.sober" --def-index 2>&1; }) | dewarn "$PAR_W/warns"
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
                grep -q '^#check e2s ranges=[0-9]* retried=0$' "$PAR_W/stats" || echo "FAIL: $e (W=8) did not check the ranges in children without retry: $(grep '^#check' "$PAR_W/stats")"
            fi
        done
        # 区間の子が全部死んだ形（SOBER_CHECK_DIE=1）: 親が同じ本体を区間の順に呼び直し、判定と --def-indexは逐次と同じ。
        # 脱糖 + 検査の区間（e2s）と、脱糖を割らないときのDefの区間（core・SOBER_DESUGAR_PAR=0）の両方
        for k in e2s core; do
            : > "$PAR_W/warns"
            if [ $k = e2s ]; then SOBER_CHECK_DIE=1 chk "$S2" $e 8 > "$PAR_W/out"; else SOBER_CHECK_DIE=1 SOBER_DESUGAR_PAR=0 chk "$S2" $e 8 > "$PAR_W/out"; fi
            grep -E "$WARN_RE" "$PAR_W/stats" >> "$PAR_W/warns"
            warned "$PAR_W/warns" "check $k" "$e (W=8, SOBER_CHECK_DIE=1)"
            if ! cmp -s "$G/$e.expected" "$PAR_W/out"; then
                echo "FAIL: $e (W=8, all $k range children died) differs from the golden"
                diff "$G/$e.expected" "$PAR_W/out" | head -6
            fi
            grep -q "^#check $k ranges=\\([0-9]*\\) retried=\\1\$" "$PAR_W/stats" || echo "FAIL: $e (W=8, SOBER_CHECK_DIE=1, $k) did not retry every range: $(grep '^#check' "$PAR_W/stats")"
        done
    done
    return 0
}
# 3''. ミューテーション15: 区間の子の死を見ずにMapの結果（死んだら空）をそのまま使うと、子が全部死んだ形の判定が割れること（e2sとcoreの両方）
j_mut15() {
    mytree
    anchor checker/e2s.sober '^    if serr == nil {$' "mutant 15: the retry was not found in checker/e2s.sober"
    anchor checker/core.sober '^    if serr == nil {$' "mutant 15: the retry was not found in checker/core.sober"
    sed -i 's/^    if serr == nil {$/    if serr == nil || len(rs) > 0 {/' "$PAR_W/tree/checker/e2s.sober" "$PAR_W/tree/checker/core.sober"
    mutbuild 15 "15 " || return 0
    SOBER_CHECK_DIE=1 chk "$W/mut15" syn 8 > "$PAR_W/out"
    cmp -s "$G/syn.expected" "$PAR_W/out" && echo "FAIL: mutant 15 (the e2s ranges ignore a dead child) was not caught"
    SOBER_CHECK_DIE=1 SOBER_DESUGAR_PAR=0 chk "$W/mut15" syn 8 > "$PAR_W/out"
    cmp -s "$G/syn.expected" "$PAR_W/out" && echo "FAIL: mutant 15 (the core ranges ignore a dead child) was not caught"
    return 0
}
# 3. ミューテーション: 区間の結果を逆順に畳む
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
# 3'. ミューテーション: 脱糖 + 検査の区間の合流で根の区間（添字0）だけを見る（one / synの def error を落とす）
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
# 4. 層の並走（段階6 P6-2 — compiler/app/cmd_check.soberのcheckFront: ParCheck ‖ analyzer ‖ checkを子で走らせ逐次の優先順で畳む）:
#    拒否の層を重ねた例の出力（標準出力 + 標準エラー + 終了コード）が逐次の経路（SOBER_DESUGAR_PAR=0）≡ W1 ≡ W8 ≡ 天井 0。
#    ミューテーション: 合流でParCheckの拒否を見ない（analyzerの指摘が先に出る）とfront_allが割れること
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
# 5. バックエンドの関数の並列（段階6 P6-4 — compiler/lower/x86.soberのxParEmit: 切替 / 罠を持たない関数を群の子で吐いて吐く順に連結）:
#    自己 build（--passes の ELF）が 1 本の経路（SOBER_BUILD_PAR=0）≡ W1 ≡ W8 ≡ W8 + 天井 0 のバイト一致・W8 で群の子が走った証人（ended > 1）。
#    ミューテーション: 群の結果を逆順に連結するとELFが割れること。子が全部死んだ形（SOBER_XPAR_DIE=1）も、親の吐き直しで同じELF。
#    移し器の往復（段階4 後半 ラウンド 9 — compiler/lower/move.sober: SOBER_BUILD_PAR=roundtripでバッチの前ごとに全関数の本体を詰め、旧い本体を毒で
#    潰して積み直す）も同じELF。ミューテーション: 積み直しでブロックの命令の尾（B_ITAIL）を付け替えないと割れること。
#    W8はlowerのバッチ（B1 / B2）も群の子で回す（ラウンド10 — lParBatch）: 1本の経路はそれも外す。ミューテーション: 子のB1の列からlicmを抜くと割れること
BCFGS=("SOBER_WORKERS=1" "SOBER_WORKERS=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0" "SOBER_WORKERS=8 SOBER_BUILD_PAR=roundtrip" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_IRINL_ORDER=1" "SOBER_WORKERS=8 SOBER_IRINL_ORDER=7" "SOBER_WORKERS=8 SOBER_NORET_ORDER=1" "SOBER_WORKERS=8 SOBER_SPEC_ORDER=1" "SOBER_WORKERS=8 SOBER_RFLOW_ORDER=1" "SOBER_WORKERS=8 SOBER_XPAR_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_PARCHECK_DIE=1 SOBER_PAR_STATS=1")
j_bseq() {
    (cd "$W/tree" && SOBER_BUILD_PAR=0 SOBER_LOWER_SPLIT=1 SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$W/bseq" > "$PAR_W/blog" 2>&1) || echo "FAIL: self build (1-path): $(head -c 200 "$PAR_W/blog")"
    return 0
}
# 子を殺す設定（SOBER_*_DIE）の自己buildの標準エラー: 子の死を逐次で作り直したことの警告の1行（loader.ParFellBack — 段stage）が出て、
# それ以外（# の証人を除く）は出ないこと。警告は黙って遅くならないための既定の出力なので、消さずにここで数える
die_warn() {
    local cfg=$1 stage=$2
    grep -Eq "^sober: ${stage}: a parallel child died \([0-9]+ children\); redone " "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not warn about the child death of ${stage} on stderr"
    if grep -v '^#' "$PAR_W/blog" | grep -Eqv '^sober: [^:]+: a parallel child died '; then echo "FAIL: self build ($cfg) printed on stderr: $(grep -v '^#' "$PAR_W/blog" | head -c 200)"; fi
}
j_build() { # j_build <番号> — BCFGS の 1 本。ELF は $W/bpar<番号>（bseq との照合は後）・証人の行はここで見る
    local i=$1 cfg=${BCFGS[$1]} ended
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_LOWER_SPLIT $cfg "$S2" build app --emit=elf --passes -o "$W/bpar$i" > "$PAR_W/blog" 2>&1) || echo "FAIL: self build ($cfg): $(head -c 200 "$PAR_W/blog")"
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        ended=$(grep '^#par tasks' "$PAR_W/blog" | sed 's/.*ended=\([0-9]*\).*/\1/')
        [ "${ended:-0}" -gt 1 ] || echo "FAIL: self build (W=8) ran no group task (ended=${ended:-?})"
    fi
    # 席Aの証人（A-2）: W8の既定は分割のパス（群の数 = ワーカー数・最後まで子のパス）・オプションSPLIT=8は分割のパスを最後まで通る（fallback=none）・SOBER_LOWER_DIEは
    # 子の死 → 直の道（fallback=died）で、標準エラーに死の1行だけを出す（loader.ParFellBack — 黙って遅くならないように。die_warn）
    # 名前付き関数型のコピー（desugar/namedval.sober — 席DのD-1）: 自己buildにはコピーする呼び出しが無い（loaderのコピーの後に宙に浮いたKNamedArgの節は
    # 数えない）ので表層型検査器を走らせない（typed=0 — 全体の TypeAll の 2 回目を走らせない）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#namedval typed=0' "$PAR_W/blog" || echo "FAIL: self build (W=8) ran the surface typer for named value args: $(grep '^#namedval' "$PAR_W/blog")"
    fi
    # finishの検査だけのフェーズ（loader/finpar.sober — 席DのD-2）: W8は子のパスを最後まで通る・SOBER_FINISH_DIEは子の死 → 直のパス（標準エラーには死の1行だけ — die_warn）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\|trees\)=[0-9]* fallback=none$' "$PAR_W/blog")" = 3 ] || echo "FAIL: self build (W=8) did not take the finish child path: $(grep '^#finish' "$PAR_W/blog")"
    fi
    if [[ $cfg == *FINISH_DIE* ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\|trees\)=[0-9]* fallback=died$' "$PAR_W/blog")" = 3 ] || echo "FAIL: self build ($cfg) did not fall back on the finish child death: $(grep '^#finish' "$PAR_W/blog")"
        die_warn "$cfg" 'finish (trees|checks|rules)'
    fi
    # ParCheckの歩き（desugar/pcpar.sober）: W8は関数の区間の子のパスを最後まで通る・SOBER_PARCHECK_DIEは子の死 → 逐次の歩き（標準エラーには死の1行だけ — die_warn）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -q '^#parcheck groups=[0-9]* fallback=none$' "$PAR_W/blog" || echo "FAIL: self build (W=8) did not take the parcheck child path: $(grep '^#parcheck' "$PAR_W/blog")"
    fi
    if [[ $cfg == *PARCHECK_DIE* ]]; then
        grep -q '^#parcheck groups=[0-9]* fallback=died$' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not fall back on the parcheck child death: $(grep '^#parcheck' "$PAR_W/blog")"
        die_warn "$cfg" 'parcheck'
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#lower split groups=8 fallback=none' "$PAR_W/blog" || echo "FAIL: self build (W=8, no knob) did not take the default lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#lower split groups=8 fallback=none' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    # 逆順の子も最後まで子のパスで（拒否で直のパスへ黙って戻るとELFは一致してしまう — 段階4 R4で子が親の店を受け取る形の検査）
    if [[ $cfg == *LOWER_REV* ]]; then
        grep -qx '#lower split groups=3 fallback=none' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    fi
    # バックエンドの関数の並列（x86.soberのxParEmit）: W8の既定は群の子で最後まで吐く（retried=0）・SOBER_XPAR_DIEは全部の群の子が死に、
    # 親が同じ本体で吐き直す（retried = 群の数。標準エラーには死の1行だけ — die_warn）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -q '^#x86 par groups=[0-9]* retried=0$' "$PAR_W/blog" || echo "FAIL: self build (W=8) did not take the code generation children without retry: $(grep '^#x86' "$PAR_W/blog")"
    fi
    if [[ $cfg == *XPAR_DIE* ]]; then
        grep -q '^#x86 par groups=\([0-9]*\) retried=\1$' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not retry every code generation group: $(grep '^#x86' "$PAR_W/blog")"
        die_warn "$cfg" 'code generation'
    fi
    if [[ $cfg == *LOWER_DIE* ]]; then
        grep -qx '#lower split groups=8 fallback=died' "$PAR_W/blog" || echo "FAIL: self build ($cfg) did not fall back on the child death: $(grep '^#lower' "$PAR_W/blog")"
        die_warn "$cfg" 'lower split \([0-9]* nodes\)'
    fi
    return 0
}
# 席Aの子が γ の当たりの店を受け取る形（段階5 R3 — 配置先の切り口 γ: 親のTypeAllがエリアを読み戻した店を子へ渡す）: 同じ配置先で冷 → 温を
# 逆順の子（SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1）でビルドし、温のELF（$W/bcache）がbseqと一致・温で γ が全部当たり・子のパスを最後まで通る
# 束（packageの単位の格納場所）は切る（SOBER_PKG_CACHE=0）: 束を使う温のビルドは捨てる関数を模擬するので直のパスを通る — この検査は分割のパスの子の形を見る
j_cache() {
    local c=$PAR_W/cache cfg="SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1 SOBER_PAR_STATS=1 SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 SOBER_PKG_CACHE=0"
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY $cfg SOBER_CACHE="$c" "$S2" build app --emit=elf --passes -o "$PAR_W/bcold" > "$PAR_W/blog" 2>&1) || { echo "FAIL: self build (cache cold, split): $(head -c 200 "$PAR_W/blog")"; return 0; }
    # shellcheck disable=SC2086
    (cd "$W/tree" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY $cfg SOBER_CACHE="$c" "$S2" build app --emit=elf --passes -o "$W/bcache" > "$PAR_W/blog" 2>&1) || { echo "FAIL: self build (cache warm, split): $(head -c 200 "$PAR_W/blog")"; return 0; }
    grep -qx '#lower split groups=3 fallback=none' "$PAR_W/blog" || echo "FAIL: self build (cache warm, split) did not take the lower split path: $(grep '^#lower' "$PAR_W/blog")"
    grep -q '^cache: alpha .* gamma \([0-9]*\)/\1 ' "$PAR_W/blog" || echo "FAIL: self build (cache warm, split) — gamma did not hit every package: $(grep '^cache: alpha' "$PAR_W/blog" | head -c 160)"
    return 0
}
# ワードに詰めると同じで長さだけ違うstringの字面（testdata/selfpar/strwords）: 1本道のELF ≡ 逆順の子の冷 ≡ 温（rodataの大域の鍵の衝突の検査）
# 束は切る（j_cache と同じ理由）
j_strwords() {
    local c=$PAR_W/swcache cfg="SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1 SOBER_PAR_STATS=1 SOBER_BUILD_CACHE=1 SOBER_PKG_CACHE=0" r
    (cd "$G" && SOBER_BUILD_PAR=0 SOBER_LOWER_SPLIT=1 SOBER_WORKERS=8 "$S2" build strwords.sober --emit=elf --passes -o "$PAR_W/sw.seq" > "$PAR_W/swlog" 2>&1) || { echo "FAIL: strwords (1-path): $(head -c 200 "$PAR_W/swlog")"; return 0; }
    for r in cold warm; do
        # shellcheck disable=SC2086
        (cd "$G" && env -u SOBER_VERIFY -u SOBER_CACHE_VERIFY $cfg SOBER_CACHE="$c" "$S2" build strwords.sober --emit=elf --passes -o "$PAR_W/sw.$r" > "$PAR_W/swlog" 2>&1) || { echo "FAIL: strwords ($r): $(head -c 200 "$PAR_W/swlog")"; return 0; }
        grep -qx "#lower split groups=3 fallback=none" "$PAR_W/swlog" || echo "FAIL: strwords ($r) did not take the lower split path: $(grep "^#lower" "$PAR_W/swlog")"
        cmp -s "$PAR_W/sw.seq" "$PAR_W/sw.$r" || echo "FAIL: strwords — the $r cache build differs from the 1-path (rodata globals with the same words)"
    done
    return 0
}
# ミューテーション4〜9は「ミュータントの検査器で元の木をビルドしたELF（$W/bmut<番号>）がbseqと割れること」— 照合は全部の仕事の後（ビルドできなければELFが無く、割れた扱い）
# mutelf <番号> <元のファイル（木の中）> <env…> — コピーの木を元に戻してからミュータントの検査器でビルドする
mutelf() {
    local k=$1 f=$2
    shift 2
    cp "$W/tree/$f" "$PAR_W/tree/$f"
    (cd "$PAR_W/tree" && env "$@" "$W/mut$k" build app --emit=elf --passes -o "$W/bmut$k" > "$PAR_W/blog" 2>&1)
}
# ミューテーション4: 群の結果を逆順に連結する
j_mut4() {
    mytree
    anchor lower/x86.sober '        xParMerge(mut st, mut c, mut fx, mut fstart, mut fbeg, mut fend, outs\[k\], of, j)' "mutant 4: the merge (xParMerge … outs[k]) was not found in lower/x86.sober"
    sed -i 's/        xParMerge(mut st, mut c, mut fx, mut fstart, mut fbeg, mut fend, outs\[k\], of, j)/        xParMerge(mut st, mut c, mut fx, mut fstart, mut fbeg, mut fend, outs[len(outs) - 1 - k], of, j)/' "$PAR_W/tree/lower/x86.sober"
    mutbuild 4 "4 " || return 0
    mutelf 4 lower/x86.sober SOBER_WORKERS=8
    return 0
}
# ミューテーション5: 移し器の往復でB_ITAILを付け替えない
j_mut5() {
    mytree
    anchor lower/move.sober '^        mvRel(mut q, at + B_ITAIL, base)$' "mutant 5: the B_ITAIL relocation was not found in lower/move.sober"
    sed -i '/^        mvRel(mut q, at + B_ITAIL, base)$/d' "$PAR_W/tree/lower/move.sober"
    mutbuild 5 "5 " || return 0
    mutelf 5 lower/move.sober SOBER_BUILD_PAR=roundtrip
    return 0
}
# ミューテーション6（段階4 後半 ラウンド 10 — lowerのバッチの群の子move.soberのlParGroup）: 子のB1の列からlicmを抜くとW8の自己buildのELFが割れること
j_mut6() {
    mytree
    anchor lower/move.sober '^    licmFunc(mut st, f)$' "mutant 6: the licm call was not found in lower/move.sober"
    sed -i '/^    licmFunc(mut st, f)$/d' "$PAR_W/tree/lower/move.sober"
    mutbuild 6 "6 " || return 0
    mutelf 6 lower/move.sober SOBER_WORKERS=8
    return 0
}
# ミューテーション7（凍結のオプション — 仮決定2026-10-07夜間）: xModuleの入口のヒープの凍結（table.FreezeとhfOn）を抜くと、x86の群の子が空の凍結の表を
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
# ミューテーション8（席A — split.sober）: 子が文字列のrodataの事象を記録しないと、親の模擬が綴りの初出の順を知らずrodataの番号・並びが割れること
j_mut8() {
    mytree
    anchor lower/cont.sober '^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$' "mutant 8: the string event was not found in lower/cont.sober"
    sed -i '/^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$/d' "$PAR_W/tree/lower/cont.sober"
    mutbuild 8 "8 " || return 0
    mutelf 8 lower/cont.sober SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3
    return 0
}
# ミューテーション9（席AのA-2 — split.sober）: 群の子の死（task.Mapのerr）を見ずに模擬へ進むと、SOBER_LOWER_DIEの自己buildがビルドできない / 割れること
j_mut9() {
    mytree
    anchor lower/split.sober '^    if serr != nil {$' "mutant 9: the child death check was not found in lower/split.sober"
    sed -i 's/^    if serr != nil {$/    if serr != nil \&\& k < 0 {/' "$PAR_W/tree/lower/split.sober"
    mutbuild 9 "9 " || return 0
    mutelf 9 lower/split.sober SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1
    return 0
}
# ミューテーション10（席DのD-1 — desugar/namedval.sober）: 名前付きの実引数を持つ呼び出しを含む関数にフラグを付けないと、コピーが型の無い呼び先を読み、
# ターゲット（testdata/selfpar/named_reach — `T?` の名前付き関数型が無いプログラムの名前付きの呼び出し・表層型を付けるのは3関数のうち1つ = 証人）がビルドできない / 割れること
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
# 7. finishの検査だけのフェーズの並列（席DのD-2 — loader/finpar.sober）: 拒否を2ファイルに置いた例の出力（stderr + 終了コード）がW1（直のパス）≡ 子のパス
fin() { # fin <検査器> <例> [env…] → 出力と rc
    local s=$1 e=$2
    shift 2
    (cd "$ROOT" && env "$@" "$s" check "testdata/selfpar/finish/$e" 2>&1; echo "rc=$?") | dewarn "$PAR_W/warns"
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
            : > "$PAR_W/warns"
            fin "$S2" $e $cfg > "$PAR_W/finp"
            [[ $cfg == *FINISH_DIE* ]] && warned "$PAR_W/warns" "finish (checks|rules)" "finish $e ($cfg)"
            cmp -s "$PAR_W/fin1" "$PAR_W/finp" || { echo "FAIL: finish $e ($cfg) differs from W1"; diff "$PAR_W/fin1" "$PAR_W/finp" | head -4; }
        done
    done
    return 0
}
# ミューテーション11〜13（席DのD-2 — loader/finpar.sober）: ミュータントの検査器のW8の出力がW1（直のパス）と割れること
j_finmut() { # j_finmut <番号> <説明> <sedの式> <ターゲットの例…> — ミュータントの検査器をビルドし、ターゲットの例のどれかがW8でW1と割れれば捕まえた
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
# 9. ParCheckの歩きの並列（desugar/pcpar.sober）: 拒否を関数の表の離れた2か所に置いた例の check と build の出力（stderr + 終了コード）がW1（逐次）≡ 子のパス
pcx() { # pcx <コンパイラ> <check|build> <例> [env…] → 出力と rc
    local s=$1 c=$2 e=$3
    shift 3
    if [ "$c" = build ]; then
        (cd "$ROOT" && env "$@" "$s" build "testdata/selfpar/parcheck/$e" -o "$PAR_W/pcelf" 2>&1; echo "rc=$?") | dewarn "$PAR_W/warns"
    else
        (cd "$ROOT" && env "$@" "$s" check "testdata/selfpar/parcheck/$e" 2>&1; echo "rc=$?") | dewarn "$PAR_W/warns"
    fi
}
PCS="walk_cross file_late walk_late de_cross"
npc=32
j_pc() {
    local e c cfg
    for e in $PCS; do
        for c in check build; do
            pcx "$S2" $c $e SOBER_WORKERS=1 > "$PAR_W/pc1"
            grep -q '^rc=1$' "$PAR_W/pc1" || echo "FAIL: parcheck $e $c (W1) was not rejected"
            for cfg in "SOBER_WORKERS=2" "SOBER_WORKERS=8" "SOBER_WORKERS=12" "SOBER_WORKERS=8 SOBER_PARCHECK_DIE=1"; do
                : > "$PAR_W/warns"
                # shellcheck disable=SC2086
                pcx "$S2" $c $e $cfg > "$PAR_W/pcp"
                [[ $cfg == *PARCHECK_DIE* ]] && warned "$PAR_W/warns" "parcheck" "parcheck $e $c ($cfg)"
                cmp -s "$PAR_W/pc1" "$PAR_W/pcp" || { echo "FAIL: parcheck $e $c ($cfg) differs from W1"; diff "$PAR_W/pc1" "$PAR_W/pcp" | head -4; }
            done
        done
    done
    return 0
}
# ミューテーション16・17（desugar/pcpar.sober）: ミュータントの検査器のW8の check の出力がW1（逐次）と割れること
j_pcmut() { # j_pcmut <番号> <説明> <sedの式> <ターゲットの例…>
    local k=$1 what=$2 expr=$3 e caught=0
    shift 3
    mytree
    sed -i "$expr" "$PAR_W/tree/desugar/pcpar.sober"
    if cmp -s "$W/tree/desugar/pcpar.sober" "$PAR_W/tree/desugar/pcpar.sober"; then echo "FAIL: mutant $k: the anchor was not found in desugar/pcpar.sober"; return 0; fi
    mutbuild "$k" "$k " || return 0
    for e in "$@"; do
        pcx "$S2" check $e SOBER_WORKERS=1 > "$PAR_W/pc1"
        pcx "$W/mut$k" check $e SOBER_WORKERS=8 SOBER_PARCHECK_DIE=$([ "$k" = 17 ] && echo 1 || echo 0) > "$PAR_W/pcp"
        cmp -s "$PAR_W/pc1" "$PAR_W/pcp" || caught=1
    done
    [ $caught = 1 ] || echo "FAIL: mutant $k ($what) was not caught"
    return 0
}
# 10. finishの木の変換の並列（loader/ftpar.sober）: 拒否を置いた例の build の出力がW1（逐次）≡ 子のパス（拒否 → 逐次でやり直す）
ftb() { # ftb <コンパイラ> [env…] → 出力と rc（証人の行は除く）
    local s=$1
    shift
    (cd "$ROOT" && env "$@" SOBER_PAR_STATS=1 "$s" build testdata/selfpar/finish/trees_cross -o "$PAR_W/ftelf" 2>&1 | grep -v '^#par '; echo "rc=${PIPESTATUS[0]}") | dewarn "$PAR_W/warns"
}
j_ft() {
    local cfg
    ftb "$S2" SOBER_WORKERS=1 > "$PAR_W/ft1"
    grep -q '^rc=1$' "$PAR_W/ft1" || echo "FAIL: trees_cross (W1) was not rejected"
    for cfg in "SOBER_WORKERS=8" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1"; do
        : > "$PAR_W/warns"
        # shellcheck disable=SC2086
        ftb "$S2" $cfg > "$PAR_W/ftp"
        [[ $cfg == *FINISH_DIE* ]] && warned "$PAR_W/warns" "finish trees" "trees_cross ($cfg)"
        if [ "$cfg" = SOBER_WORKERS=8 ]; then
            grep -q '^#finish trees=[0-9]* fallback=rejected$' "$PAR_W/ftp" || echo "FAIL: trees_cross (W8) did not fall back on the rejection: $(grep '^#finish' "$PAR_W/ftp")"
        fi
        cmp -s <(grep -v '^#' "$PAR_W/ft1") <(grep -v '^#' "$PAR_W/ftp") || { echo "FAIL: trees_cross ($cfg) differs from W1"; diff "$PAR_W/ft1" "$PAR_W/ftp" | head -4; }
    done
    return 0
}
# ミューテーション18（loader/ftpar.sober）: 子の拒否を見ずに変換の後の木を使うと、W8の出力がW1と割れること
j_mut18() {
    mytree
    anchor loader/ftpar.sober '^        if !pre\[f\]\.ok {$' "mutant 18: the rejection check was not found in loader/ftpar.sober"
    sed -i 's/^        if !pre\[f\]\.ok {$/        if !pre[f].ok \&\& f < 0 {/' "$PAR_W/tree/loader/ftpar.sober"
    mutbuild 18 "18 " || return 0
    ftb "$S2" SOBER_WORKERS=1 > "$PAR_W/ft1"
    ftb "$W/mut18" SOBER_WORKERS=8 > "$PAR_W/ftp"
    if cmp -s <(grep -v '^#' "$PAR_W/ft1") <(grep -v '^#' "$PAR_W/ftp"); then echo "FAIL: mutant 18 (the merge ignores a rejected file) was not caught"; fi
    return 0
}
# 11. 最後の検証をB2の子の中で: 既定の検証の自己buildのW8（ELFは$W/bvfy — bseqとの照合は後）と、ミュータント107の診断の照合
vfyb() { # vfyb <コンパイラ> <出力> <env…> — 既定の検証（SOBER_VERIFYなし）でミュータント107つきの自己buildを走らせ、標準エラーを<出力>に
    local c=$1 o=$2
    shift 2
    (cd "$W/tree" && env -u SOBER_VERIFY "$@" "$c" build app --emit=elf --passes --rt-mutant=107 -o "$PAR_W/bm107" > "$o" 2>&1) && echo "FAIL: self build with mutant 107 ($*) was not rejected"
    return 0
}
j_vfy() {
    local w
    (cd "$W/tree" && env -u SOBER_VERIFY SOBER_WORKERS=8 SOBER_PAR_STATS=1 "$S2" build app --emit=elf --passes -o "$W/bvfy" > "$PAR_W/vlog" 2>&1) || echo "FAIL: self build (W8, final verification): $(head -c 200 "$PAR_W/vlog")"
    # 親が検証するのは、子の検証の後に親が書き換えた関数（cutInsert が検査点を置いた関数 — dirty）だけ
    w=$(grep '^#vfyfinal' "$PAR_W/vlog")
    [[ "$w" =~ ^#vfyfinal\ kid=[1-9][0-9]*\ parent=([0-9]+)\ dirty=([0-9]+)$ ]] && [ "${BASH_REMATCH[1]}" = "${BASH_REMATCH[2]}" ] || echo "FAIL: self build (W8) did not use the final verification of the group children: $(grep '^#vfyfinal' "$PAR_W/vlog")"
    for w in 1 2 8 12; do vfyb "$S2" "$PAR_W/vm$w" SOBER_WORKERS=$w; done
    grep -q '^panic: lower.InvalidIR{after: "the passes' "$PAR_W/vm1" || echo "FAIL: mutant 107 (W1) did not fail the final verification: $(head -c 200 "$PAR_W/vm1")"
    for w in 2 8 12; do
        cmp -s "$PAR_W/vm1" "$PAR_W/vm$w" || { echo "FAIL: mutant 107 — the final verification (W$w) differs from W1"; diff "$PAR_W/vm1" "$PAR_W/vm$w" | head -4; }
    done
    return 0
}
# ミューテーション19（lower/verify.sober）: 親が子の検証の文面を見ないと、ミュータント107のW8の診断がW1と割れること
j_mut19() {
    mytree
    anchor lower/verify.sober ' } else { st.vfyMsg\[pre\] }$' "mutant 19: the use of the child verdict was not found in lower/verify.sober"
    sed -i 's/ } else { st.vfyMsg\[pre\] }$/ } else { "" }/' "$PAR_W/tree/lower/verify.sober"
    mutbuild 19 "19 " || return 0
    vfyb "$S2" "$PAR_W/vm1" SOBER_WORKERS=1
    (cd "$W/tree" && env -u SOBER_VERIFY SOBER_WORKERS=8 "$W/mut19" build app --emit=elf --passes --rt-mutant=107 -o "$PAR_W/bm107" > "$PAR_W/vm8" 2>&1)
    if cmp -s "$PAR_W/vm1" "$PAR_W/vm8"; then echo "FAIL: mutant 19 (the parent ignores the child verdicts) was not caught"; fi
    return 0
}
# ミューテーション14（irinlの並びに依らない展開 — report-1185）: 呼び出しグラフの順をやめて処理の入力の並びのまま処理すると、撹拌（SOBER_IRINL_ORDER=1）で
# 自己buildのELFが割れること（上の self build の ORDER=1 / 7 ≡ 1 本の経路 が並び不変の検査・このミューテーションがその検査の自己検査）
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

# ミューテーション20（noretの並びに依らない終端化）: 題材の逆転が本物のコンパイラで既定と同じ・ミュータントで割れること
j_mut20() {
    local t=$ROOT/testdata/selfpar/noret_order.sober
    for o in 0 1; do
        SOBER_BUILD_CACHE=0 SOBER_NORET_ORDER=$o "$S2" build "$t" -o "$PAR_W/nr$o" > "$PAR_W/nlog" 2>&1 || { echo "FAIL: noret_order build (order $o): $(head -c 200 "$PAR_W/nlog")"; return 0; }
    done
    cmp -s "$PAR_W/nr0" "$PAR_W/nr1" || echo "FAIL: noret_order — SOBER_NORET_ORDER=1 changed the ELF"
    mytree
    anchor lower/noret.sober '^                if irInsOp(mut st, i) == OpCall && spFind(nr, int(irInsFn(mut st, i))) >= 0 {$' "mutant 20: the non-returning set (nr) was not found in lower/noret.sober"
    sed -i '/^func noretFunc(/,/^}/s/^                if irInsOp(mut st, i) == OpCall \&\& spFind(nr, int(irInsFn(mut st, i))) >= 0 {$/                if irInsOp(mut st, i) == OpCall \&\& ilNonretSeed(mut st, irInsFn(mut st, i)) {/; s/^        if noretCallsNr(mut st, FnRef(fl\[k\]), nr) {$/        if irFnBHead(mut st, FnRef(fl[k])) != -1 {/' "$PAR_W/tree/lower/noret.sober"
    mutbuild 20 "20 " || return 0
    for o in 0 1; do
        SOBER_BUILD_CACHE=0 SOBER_NORET_ORDER=$o "$W/mut20" build "$t" -o "$PAR_W/nm$o" > "$PAR_W/nlog" 2>&1
    done
    if cmp -s "$PAR_W/nm0" "$PAR_W/nm1"; then
        echo "FAIL: mutant 20 (noret one level in the chain order) was not caught"
    fi
    return 0
}

# ミューテーション21（specの並びに依らない特化）: 作業列をチェーンの順のまま回すと、入力の逆転（SOBER_SPEC_ORDER=1）で自己buildのELFが割れること
j_mut21() {
    mytree
    anchor lower/spec.sober '^    for k <- sort.Order(len(ofr), (a, b) => spBytesLess(nmf\[a\], nmf\[b\])) {$' "mutant 21: the name order (sort.Order) was not found in lower/spec.sober"
    sed -i 's/^    for k <- sort.Order(len(ofr), (a, b) => spBytesLess(nmf\[a\], nmf\[b\])) {$/    for k <- iter.Range(0, len(ofr)) {/' "$PAR_W/tree/lower/spec.sober"
    mutbuild 21 "21 " || return 0
    cp "$W/tree/lower/spec.sober" "$PAR_W/tree/lower/spec.sober"
    (cd "$PAR_W/tree" && SOBER_WORKERS=8 "$W/mut21" build app --emit=elf --passes -o "$PAR_W/bm0" > "$PAR_W/blog" 2>&1)
    (cd "$PAR_W/tree" && SOBER_WORKERS=8 SOBER_SPEC_ORDER=1 "$W/mut21" build app --emit=elf --passes -o "$PAR_W/bm1" > "$PAR_W/blog" 2>&1)
    if cmp -s "$PAR_W/bm0" "$PAR_W/bm1"; then
        echo "FAIL: mutant 21 (spec in the chain order) was not caught"
    fi
    return 0
}

# ミューテーション22（specの枠を頻度で与える）: 題材の逆転が本物で既定と同じ・頻度を外したミュータントで題材のELFが本物と割れること
j_mut22() {
    local t=$ROOT/testdata/selfpar/spec_freq.sober
    for o in 0 1; do
        SOBER_BUILD_CACHE=0 SOBER_SPEC_ORDER=$o "$S2" build "$t" -o "$PAR_W/sf$o" > "$PAR_W/slog" 2>&1 || { echo "FAIL: spec_freq build (order $o): $(head -c 200 "$PAR_W/slog")"; return 0; }
    done
    cmp -s "$PAR_W/sf0" "$PAR_W/sf1" || echo "FAIL: spec_freq — SOBER_SPEC_ORDER=1 changed the ELF"
    mytree
    anchor lower/spec.sober '^                            adm := if pr >= 0 { pre.recs\[pr + 5 + 3 \* key\[1\]\] == 1 } else { per < SP_PER }$' "mutant 22: the frequency slots (adm) were not found in lower/spec.sober"
    sed -i 's/^                            adm := if pr >= 0 { pre.recs\[pr + 5 + 3 \* key\[1\]\] == 1 } else { per < SP_PER }$/                            adm := per < SP_PER/' "$PAR_W/tree/lower/spec.sober"
    mutbuild 22 "22 " || return 0
    SOBER_BUILD_CACHE=0 "$W/mut22" build "$t" -o "$PAR_W/sm" > "$PAR_W/slog" 2>&1
    if cmp -s "$PAR_W/sf0" "$PAR_W/sm"; then
        echo "FAIL: mutant 22 (spec slots without the frequency) was not caught"
    fi
    return 0
}

# 仕事の投入（長いものから — ミューテーションは検査器をビルドしてから自己buildを1〜2回）
for k in 4 5 6 7 8 9 14 20 21 22; do par_run "j_mut$k"; done
par_run j_bseq
for i in "${!BCFGS[@]}"; do par_run j_build "$i"; done
par_run j_cache
par_run j_strwords
for k in 1 2 3 10 15; do par_run "j_mut$k"; done
par_run j_finmut 11 "pick the last file with a names hit" 's/^        if rs\[f\]\.nm {$/        if rs[f].nm \&\& f == n - 1 {/' names_same
par_run j_finmut 12 "later files overwrite the rule positions" 's/^            if hit\[r \* 3\] == 0 \&\& rs\[f\]\.hit\[r \* 3\] > 0 {$/            if rs[f].hit[r * 3] > 0 {/' rules_same
par_run j_finmut 13 "the merge ignores a dead child" 's/^    if cerr != nil {$/    if cerr != nil \&\& n < 0 {/' names_same rules_same
par_run j_pcmut 16 "pick the last range with a walk hit" 's/^        if outs\[g\]\.w\.kind != 0 {$/        if outs[g].w.kind != 0 \&\& g == len(outs) - 1 {/' walk_cross de_cross
par_run j_pcmut 17 "the merge ignores a dead child" 's/^    if err != nil {$/    if err != nil \&\& len(rs) < 0 {/' walk_cross
par_run j_self selfseq SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8
par_run j_self self1 SOBER_WORKERS=1
par_run j_self defs1 SOBER_WORKERS=1 SOBER_CHECK_STOP=defs
par_run j_self self8 SOBER_WORKERS=8
par_run j_self self0 SOBER_WORKERS=8 SOBER_BUDGET_MB=0
par_run j_self selfdie SOBER_WORKERS=8 SOBER_CHECK_DIE=1
par_run j_iface ifseq SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8
par_run j_iface if8 SOBER_WORKERS=8
par_run j_syn
par_run j_front
par_run j_fin
par_run j_pc
par_run j_ft
par_run j_mut18
par_run j_vfy
par_run j_mut19
par_wait > "$W/jobs.out"
cat "$W/jobs.out"
fail=$(grep -c '^FAIL' "$W/jobs.out")

# 全部の仕事の後の照合
grep -q '"ok":true' "$W/self1" || { echo "FAIL: self check (W1) not accepted: $(head -c 200 "$W/self1")"; fail=$((fail + 1)); }
# RSSのラチェット（bench/ratchet.txtのself/check rss — 自己check〔一括・W1〕のpeak RSS。段階6 P6-6で新設）
# 線との比較の赤は lfail に数える（fail = 線のほかの検査。本体の緑の印 meas_body_ok は fail だけで決める — gatelib.sh の ratchet_cmp）
lfail=0
rss=$(( $(cat "$W/self1.rss") / 1024 ))
ratchet_cmp bench/ratchet.txt self/check rss "$rss"
case $? in
    0) ;;
    1) echo "FAIL: ratchet — 自己 check（W1）の peak RSS ${rss} MB > ${RATCHET_LIM} MB（bench/ratchet.txt）"; lfail=$((lfail + 1)) ;;
    *) echo "FAIL: ratchet — bench/ratchet.txt に self/check rss の行が無い"; lfail=$((lfail + 1)) ;;
esac
rlim=$RATCHET_LIM
# 検査器の本体の命令数のラチェット（bench/ratchet.txtのself/check body — G命令・W1の「最後まで − defs」。核の節の数に出ない検査器の遅さの検査:
# 同じ節の数のまま検査器の時間が3倍になった形〔別のregionのmut実引数2つを取る再帰の関数1つ〕はRSSの上限値にたまたま掛かっただけだった）
if [ "${#INSTP[@]}" != 0 ]; then
    body=$(awk -F, '/instructions/ { v[FILENAME] = $1 } END { printf "%.3f", (v[ARGV[1]] - v[ARGV[2]]) / 1e9 }' "$W/self1.inst" "$W/defs1.inst")
    ratchet_cmp bench/ratchet.txt self/check body "$body"
    case $? in
        0) echo "ratchet: 自己 check（W1）の検査器の本体の命令 ${body} G ≤ ${RATCHET_LIM} G" ;;
        1) echo "FAIL: ratchet — 自己 check（W1）の検査器の本体の命令 ${body} G > ${RATCHET_LIM} G（bench/ratchet.txt — scripts/checkstats.sh で段ごとに見る）"; lfail=$((lfail + 1)) ;;
        *) echo "FAIL: ratchet — bench/ratchet.txt に self/check body の行が無い"; lfail=$((lfail + 1)) ;;
    esac
fi
for v in selfseq self8 self0 selfdie; do
    cmp -s "$W/self1" "$W/$v" || { echo "FAIL: self check $v differs from W1"; diff "$W/self1" "$W/$v" | head -4; fail=$((fail + 1)); }
done
r=$(warned "$W/selfdie.warns" "check (e2s|core)" "self check selfdie (SOBER_CHECK_DIE=1)")
[ -z "$r" ] || { echo "$r"; fail=$((fail + 1)); }
grep -q '^== link.txt' "$W/ifseq" || { echo "FAIL: self iface (1-path) failed: $(head -c 200 "$W/ifseq")"; fail=$((fail + 1)); }
cmp -s "$W/ifseq" "$W/if8" || { echo "FAIL: self iface W8 differs from the 1-path"; diff "$W/ifseq" "$W/if8" | head -4; fail=$((fail + 1)); }
cmp -s "$W/bseq" "$W/bvfy" || { echo "FAIL: self build (W8, final verification in the group children) differs from the 1-path"; fail=$((fail + 1)); }
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
echo "selfpar: self check {1-path (W1 rss ${rss} MB ≤ ${rlim} MB), W 1, 8, 8 + budget 0, 8 + range child death} + self iface + $n synthetic runs + $nf layered runs + self build {1-path, W 1, 8, 8 + budget 0, 8 + roundtrip, 8 + lower split 3 rev, 8 + lower direct, 8 + lower split 8, 8 + lower split 8 child death, 8 + finish child death, 8 + parcheck child death, 8 + irinl order rev, 8 + irinl order seed 7, 8 + noret order rev, 8 + spec order rev, 8 + rflow order rev, strwords 1-path ≡ split cold ≡ warm} + $nfin finish runs + $npc parcheck runs + 3 trees runs + final verification {W8 children, mutant 107 W 1 ≡ 2 ≡ 8 ≡ 12} + 22 mutants, fail=$fail, ratchet fail=$lfail$([ "${#INSTP[@]}" = 0 ] && echo " (SKIP[perf] check body ratchet)")"
[ $fail = 0 ] && meas_body_ok
[ $fail = 0 ] && [ $lfail = 0 ]
