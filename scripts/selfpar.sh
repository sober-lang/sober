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
#      群の子（task.Map — A-2）で下ろす形・SOBER_LOWER_SPLIT=1 は直の道を強制する形 — どちらも 1 本の経路と同じ ELF（W>1 の既定は直の道 —
#      証人の行が出ないこと）。子の死（SOBER_LOWER_DIE=1）→ 直の道も同じ ELF（証人 #lower split … fallback=died）+ 死を見ずに模擬へ進むと割れる変異
#   7. finish の検査だけの段の並列（席 D の D-2 — compiler/loader/finpar.sober）: 自己 build の W8 は子の道（証人 #finish … fallback=none）・
#      子の死（SOBER_FINISH_DIE=1）→ 直の道も同じ ELF。拒否を 2 ファイルに置いた例（testdata/selfpar/finish — 同じ段 / 段をまたぐ / catch の左辺）の
#      出力が W1（直の道）≡ W2 ≡ W8 ≡ W12 ≡ W8 + 子の死。変異 11〜13: 後のファイルの当たりを選ぶ・規則の位置を後のファイルで上書きする・子の死を見ない
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
S2=${STAGE2:-out/stage2/sober2}
S2=$(cd "$(dirname "$S2")" && pwd)/$(basename "$S2")
G=$ROOT/testdata/selfpar
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
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
# 1. 自己 check
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
(cd "$W/tree" && SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8 "$S2" check app/main.sober > "$W/selfseq" 2>&1)
(cd "$W/tree" && SOBER_WORKERS=1 /usr/bin/time -f %M -o "$W/self1.rss" "$S2" check app/main.sober > "$W/self1" 2>&1)
(cd "$W/tree" && SOBER_WORKERS=8 "$S2" check app/main.sober > "$W/self8" 2>&1)
(cd "$W/tree" && SOBER_WORKERS=8 SOBER_BUDGET_MB=0 "$S2" check app/main.sober > "$W/self0" 2>&1)
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
(cd "$W/tree" && SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8 "$S2" iface app/main.sober > "$W/ifseq" 2>&1)
(cd "$W/tree" && SOBER_WORKERS=8 "$S2" iface app/main.sober > "$W/if8" 2>&1)
grep -q '^== link.txt' "$W/ifseq" || { echo "FAIL: self iface (1-path) failed: $(head -c 200 "$W/ifseq")"; fail=$((fail + 1)); }
cmp -s "$W/ifseq" "$W/if8" || { echo "FAIL: self iface W8 differs from the 1-path"; diff "$W/ifseq" "$W/if8" | head -4; fail=$((fail + 1)); }
# 2. 合成例
mkdir -p "$W/syn"
gen 120 150 "7 61 113" > "$W/syn/syn.sober"
gen 120 150 "61" > "$W/syn/one.sober"
gen 120 150 "" > "$W/syn/ok.sober"
n=0
chk() { # chk <検査器> <例> <W> [天井] → 判定と --def-index を <out> に
    local s=$1 e=$2 w=$3 b=${4:-}
    (cd "$W/syn" && { env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} SOBER_PAR_STATS=1 "$s" check "$e.sober" 2> "$W/stats"; env SOBER_WORKERS="$w" ${b:+SOBER_BUDGET_MB=$b} "$s" check "$e.sober" --def-index 2>&1; })
}
for e in syn one ok; do
    for cfg in "1" "8" "8 0"; do
        n=$((n + 1))
        chk "$S2" $e $cfg > "$W/out"
        if ! cmp -s "$G/$e.expected" "$W/out"; then
            echo "FAIL: $e (W=$cfg) differs from the golden"
            diff "$G/$e.expected" "$W/out" | head -6
            fail=$((fail + 1))
        fi
        if [ "$cfg" = 8 ]; then
            ended=$(grep '^#par tasks' "$W/stats" | sed 's/.*ended=\([0-9]*\).*/\1/')
            [ "${ended:-0}" -gt 1 ] || { echo "FAIL: $e (W=8) ran no child task (ended=${ended:-?}) — the ranges were not split"; fail=$((fail + 1)); }
        fi
    done
done
# 3. 変異: 区間の結果を逆順に畳む
grep -q 'o := outs\[k\]' "$W/tree/checker/core.sober" || { echo "FAIL: mutant: the merge loop (o := outs[k]) was not found in checker/core.sober"; fail=$((fail + 1)); }
sed -i 's/o := outs\[k\]/o := outs[len(outs) - 1 - k]/' "$W/tree/checker/core.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut"
    chk "$W/mut" syn 8 > "$W/out"
    if cmp -s "$G/syn.expected" "$W/out"; then
        echo "FAIL: mutant (merge in reverse) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
# 3'. 変異: 脱糖 + 検査の区間の合流で根の区間（添字 0）だけを見る（one / syn の def error を落とす）
cp "$ROOT/src/compiler/checker/core.sober" "$W/tree/checker/core.sober"
grep -q 'o := outs\[(k + 1) % len(outs)\]' "$W/tree/checker/e2s.sober" || { echo "FAIL: mutant 2: the merge loop was not found in checker/e2s.sober"; fail=$((fail + 1)); }
sed -i 's/o := outs\[(k + 1) % len(outs)\]/o := outs[0]/' "$W/tree/checker/e2s.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut2" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut2"
    (cd "$W/syn" && SOBER_WORKERS=8 "$W/mut2" check one.sober > "$W/out" 2>&1)
    if head -n 1 "$G/one.expected" | cmp -s - "$W/out"; then
        echo "FAIL: mutant 2 (merge only the root range) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 2 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
# 4. 層の並走（段 6 P6-2 — compiler/app/main.sober の checkFront: ParCheck ‖ analyzer ‖ check を子で走らせ逐次の優先順で畳む）:
#    拒否の層を重ねた例の出力（標準出力 + 標準エラー + 終了コード）が逐次の経路（SOBER_DESUGAR_PAR=0）≡ W1 ≡ W8 ≡ 天井 0。
#    変異: 合流で ParCheck の拒否を見ない（analyzer の指摘が先に出る）と front_all が割れること
front() { # front <検査器> <例> [env…] → 出力と rc
    local s=$1 e=$2
    shift 2
    (cd "$G" && env "$@" "$s" check "$e.sober" 2>&1; echo "rc=$?")
}
nf=0
for e in front_all front_an front_ck; do
    front "$S2" $e SOBER_DESUGAR_PAR=0 SOBER_WORKERS=8 > "$W/fseq"
    grep -q '^rc=1$' "$W/fseq" || { echo "FAIL: front $e (1-path) was not rejected"; fail=$((fail + 1)); }
    for cfg in "SOBER_WORKERS=1" "SOBER_WORKERS=8" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0"; do
        nf=$((nf + 1))
        # shellcheck disable=SC2086
        front "$S2" $e $cfg > "$W/fpar"
        cmp -s "$W/fseq" "$W/fpar" || { echo "FAIL: front $e ($cfg) differs from the 1-path"; diff "$W/fseq" "$W/fpar" | head -4; fail=$((fail + 1)); }
    done
done
cp "$ROOT/src/compiler/checker/e2s.sober" "$W/tree/checker/e2s.sober"
grep -q '    if pm != "" {' "$W/tree/app/main.sober" || { echo "FAIL: mutant 3: the merge (if pm != \"\") was not found in app/main.sober"; fail=$((fail + 1)); }
sed -i 's/    if pm != "" {/    if false {/' "$W/tree/app/main.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut3" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut3"
    front "$S2" front_all SOBER_DESUGAR_PAR=0 > "$W/fseq"
    front "$W/mut3" front_all SOBER_WORKERS=8 > "$W/fpar"
    if cmp -s "$W/fseq" "$W/fpar"; then
        echo "FAIL: mutant 3 (merge without the ParCheck layer) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 3 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
# 5. バックエンドの関数の並列（段 6 P6-4 — compiler/lower/x86.sober の xParEmit: 切替 / 罠を持たない関数を群の子で吐いて吐く順に連結）:
#    自己 build（--passes の ELF）が 1 本の経路（SOBER_BUILD_PAR=0）≡ W1 ≡ W8 ≡ W8 + 天井 0 のバイト一致・W8 で群の子が走った証人（ended > 1）。
#    変異: 群の結果を逆順に連結すると ELF が割れること。
#    移し器の往復（段 4 後半 ラウンド 9 — compiler/lower/move.sober: SOBER_BUILD_PAR=roundtrip で束の前ごとに全関数の本体を詰め、旧い本体を毒で
#    潰して積み直す）も同じ ELF。変異: 積み直しでブロックの命令の尾（B_ITAIL）を付け替えないと割れること。
#    W8 は lower の束（B1 / B2）も群の子で回す（ラウンド 10 — lParBatch）: 1 本の経路はそれも外す。変異: 子の B1 の列から licm を抜くと割れること
cp "$ROOT/src/compiler/app/main.sober" "$W/tree/app/main.sober"
(cd "$W/tree" && SOBER_BUILD_PAR=0 SOBER_WORKERS=8 "$S2" build app/main.sober --emit=elf --passes -o "$W/bseq" > "$W/blog" 2>&1) || { echo "FAIL: self build (1-path): $(head -c 200 "$W/blog")"; fail=$((fail + 1)); }
for cfg in "SOBER_WORKERS=1" "SOBER_WORKERS=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0" "SOBER_WORKERS=8 SOBER_BUILD_PAR=roundtrip" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 SOBER_LOWER_REV=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1 SOBER_PAR_STATS=1"; do
    # shellcheck disable=SC2086
    (cd "$W/tree" && env $cfg "$S2" build app/main.sober --emit=elf --passes -o "$W/bpar" > "$W/blog" 2>&1) || { echo "FAIL: self build ($cfg): $(head -c 200 "$W/blog")"; fail=$((fail + 1)); }
    cmp -s "$W/bseq" "$W/bpar" || { echo "FAIL: self build ($cfg) differs from the 1-path"; fail=$((fail + 1)); }
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        ended=$(grep '^#par tasks' "$W/blog" | sed 's/.*ended=\([0-9]*\).*/\1/')
        [ "${ended:-0}" -gt 1 ] || { echo "FAIL: self build (W=8) ran no group task (ended=${ended:-?})"; fail=$((fail + 1)); }
    fi
    # 席 A の証人（A-2）: W8 の既定は直の道（証人の行なし）・口 SPLIT=8 は分割の道を最後まで通る（fallback=none）・SOBER_LOWER_DIE は
    # 子の死 → 直の道（fallback=died）で、捕まった死は印字されない
    # 名前付き関数型の写し（desugar/namedval.sober — 席 D の D-1）: 自己 build には写す呼び出しが無い（loader の写しの後に宙に浮いた KNamedArg の節は
    # 数えない）ので表層型検査器を走らせない（typed=0 — 全体の TypeAll の 2 回目を走らせない）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#namedval typed=0' "$W/blog" || { echo "FAIL: self build (W=8) ran the surface typer for named value args: $(grep '^#namedval' "$W/blog")"; fail=$((fail + 1)); }
    fi
    # finish の検査だけの段（loader/finpar.sober — 席 D の D-2）: W8 は子の道を最後まで通る・SOBER_FINISH_DIE は子の死 → 直の道（捕まった死は印字されない）
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\)=[0-9]* fallback=none$' "$W/blog")" = 2 ] || { echo "FAIL: self build (W=8) did not take the finish child path: $(grep '^#finish' "$W/blog")"; fail=$((fail + 1)); }
    fi
    if [[ $cfg == *FINISH_DIE* ]]; then
        [ "$(grep -c '^#finish \(checks\|rules\)=[0-9]* fallback=died$' "$W/blog")" = 2 ] || { echo "FAIL: self build ($cfg) did not fall back on the finish child death: $(grep '^#finish' "$W/blog")"; fail=$((fail + 1)); }
        if grep -qv '^#' "$W/blog"; then echo "FAIL: self build ($cfg) printed on stderr: $(grep -v '^#' "$W/blog" | head -c 200)"; fail=$((fail + 1)); fi
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_PAR_STATS=1" ]] && grep -q '^#lower' "$W/blog"; then
        echo "FAIL: self build (W=8, no knob) took the lower split path: $(grep '^#lower' "$W/blog")"; fail=$((fail + 1))
    fi
    if [[ $cfg == "SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_PAR_STATS=1" ]]; then
        grep -qx '#lower split groups=8 fallback=none' "$W/blog" || { echo "FAIL: self build ($cfg) did not take the lower split path: $(grep '^#lower' "$W/blog")"; fail=$((fail + 1)); }
    fi
    if [[ $cfg == *LOWER_DIE* ]]; then
        grep -qx '#lower split groups=8 fallback=died' "$W/blog" || { echo "FAIL: self build ($cfg) did not fall back on the child death: $(grep '^#lower' "$W/blog")"; fail=$((fail + 1)); }
        if grep -qv '^#' "$W/blog"; then echo "FAIL: self build ($cfg) printed on stderr: $(grep -v '^#' "$W/blog" | head -c 200)"; fail=$((fail + 1)); fi
    fi
done
grep -q '        xParMerge(mut st, mut c, mut fx, mut fstart, outs\[k\], of, j)' "$W/tree/lower/x86.sober" || { echo "FAIL: mutant 4: the merge (xParMerge … outs[k]) was not found in lower/x86.sober"; fail=$((fail + 1)); }
cp "$W/tree/lower/x86.sober" "$W/x86.orig"
sed -i 's/        xParMerge(mut st, mut c, mut fx, mut fstart, outs\[k\], of, j)/        xParMerge(mut st, mut c, mut fx, mut fstart, outs[len(outs) - 1 - k], of, j)/' "$W/tree/lower/x86.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut4" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut4"
    (cd "$W/tree" && cp "$W/x86.orig" lower/x86.sober && SOBER_WORKERS=8 "$W/mut4" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1)
    if cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 4 (merge the groups in reverse) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 4 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
grep -q '^        mvRel(mut q, at + B_ITAIL, base)$' "$W/tree/lower/move.sober" || { echo "FAIL: mutant 5: the B_ITAIL relocation was not found in lower/move.sober"; fail=$((fail + 1)); }
cp "$W/tree/lower/move.sober" "$W/move.orig"
sed -i '/^        mvRel(mut q, at + B_ITAIL, base)$/d' "$W/tree/lower/move.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut5" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut5"
    if (cd "$W/tree" && cp "$W/move.orig" lower/move.sober && SOBER_BUILD_PAR=roundtrip "$W/mut5" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1) && cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 5 (roundtrip without relocating B_ITAIL) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 5 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/move.orig" "$W/tree/lower/move.sober"
# 変異 6（段 4 後半 ラウンド 10 — lower の束の群の子 move.sober の lParGroup）: 子の B1 の列から licm を抜くと W8 の自己 build の ELF が割れること
grep -q '^    licmFunc(mut st, f)$' "$W/tree/lower/move.sober" || { echo "FAIL: mutant 6: the licm call was not found in lower/move.sober"; fail=$((fail + 1)); }
sed -i '/^    licmFunc(mut st, f)$/d' "$W/tree/lower/move.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut6" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut6"
    if (cd "$W/tree" && cp "$W/move.orig" lower/move.sober && SOBER_WORKERS=8 "$W/mut6" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1) && cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 6 (the group children skip licm) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 6 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/move.orig" "$W/tree/lower/move.sober"
# 変異 7（凍結の口 — 仮裁定 2026-10-07 夜間）: xModule の入口のヒープの凍結（table.Freeze と hfOn）を抜くと、x86 の群の子が空の凍結の表を
# 読んで W8 の自己 build が建たない / 割れること
grep -q '^    st.hf = desugar.HeapFreeze(mut st.d)$' "$W/tree/lower/x86.sober" || { echo "FAIL: mutant 7: the heap freeze was not found in lower/x86.sober"; fail=$((fail + 1)); }
cp "$W/tree/lower/x86.sober" "$W/x86.orig7"
sed -i '/^    st.hf = desugar.HeapFreeze(mut st.d)$/d; /^    st.hfOn = true$/d' "$W/tree/lower/x86.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut7" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut7"
    if (cd "$W/tree" && cp "$W/x86.orig7" lower/x86.sober && SOBER_WORKERS=8 "$W/mut7" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1) && cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 7 (no heap freeze before the x86 groups) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 7 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/x86.orig7" "$W/tree/lower/x86.sober"
# 変異 8（席 A — split.sober）: 子が文字列の rodata の事象を記録しないと、親の模擬が綴りの初出の順を知らず rodata の番号・並びが割れること
grep -q '^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$' "$W/tree/lower/cont.sober" || { echo "FAIL: mutant 8: the string event was not found in lower/cont.sober"; fail=$((fail + 1)); }
cp "$W/tree/lower/cont.sober" "$W/cont.orig"
sed -i '/^    lsEv(mut st, EV_STR, g, int(s), 0, 0)$/d' "$W/tree/lower/cont.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut8" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut8"
    if (cd "$W/tree" && cp "$W/cont.orig" lower/cont.sober && SOBER_WORKERS=8 SOBER_LOWER_SPLIT=3 "$W/mut8" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1) && cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 8 (the children do not record the string events) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 8 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/cont.orig" "$W/tree/lower/cont.sober"
# 変異 9（席 A の A-2 — split.sober）: 群の子の死（task.Map の err）を見ずに模擬へ進むと、SOBER_LOWER_DIE の自己 build が建たない / 割れること
grep -q '^    if serr != nil {$' "$W/tree/lower/split.sober" || { echo "FAIL: mutant 9: the child death check was not found in lower/split.sober"; fail=$((fail + 1)); }
cp "$W/tree/lower/split.sober" "$W/split.orig"
sed -i 's/^    if serr != nil {$/    if serr != nil \&\& k < 0 {/' "$W/tree/lower/split.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut9" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut9"
    if (cd "$W/tree" && cp "$W/split.orig" lower/split.sober && SOBER_WORKERS=8 SOBER_LOWER_SPLIT=8 SOBER_LOWER_DIE=1 "$W/mut9" build app/main.sober --emit=elf --passes -o "$W/bmut" > "$W/blog" 2>&1) && cmp -s "$W/bseq" "$W/bmut"; then
        echo "FAIL: mutant 9 (the replay ignores a dead child) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 9 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/split.orig" "$W/tree/lower/split.sober"
# 変異 10（席 D の D-1 — desugar/namedval.sober）: 名前付きの実引数を持つ呼び出しを含む関数に印を付けないと、写しが型の無い呼び先を読み、
# 的（testdata/selfpar/named_reach — `T?` の名前付き関数型が無いプログラムの名前付きの呼び出し・表層型を付けるのは 3 関数のうち 1 つ = 証人）が建たない / 割れること
grep -q '^                        lput(mut st, mark, fi, 1)$' "$W/tree/desugar/namedval.sober" || { echo "FAIL: mutant 10: the nvReach mark was not found in desugar/namedval.sober"; fail=$((fail + 1)); }
cp "$W/tree/desugar/namedval.sober" "$W/nv.orig"
sed -i '/^                        lput(mut st, mark, fi, 1)$/d' "$W/tree/desugar/namedval.sober"
if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut10" > "$W/mutlog" 2>&1); then
    chmod +x "$W/mut10"
    SOBER_PAR_STATS=1 "$S2" build "$G/named_reach.sober" --emit=elf --passes -o "$W/nvok" > "$W/blog" 2>&1 || { echo "FAIL: named_reach build: $(head -c 200 "$W/blog")"; fail=$((fail + 1)); }
    grep -qx '#namedval typed=1 bodies=3' "$W/blog" || { echo "FAIL: named_reach typed: $(grep '^#namedval' "$W/blog")"; fail=$((fail + 1)); }
    if "$W/mut10" build "$G/named_reach.sober" --emit=elf --passes -o "$W/nvmut" > "$W/blog" 2>&1 && cmp -s "$W/nvok" "$W/nvmut"; then
        echo "FAIL: mutant 10 (named value args without the typed functions) was not caught"
        fail=$((fail + 1))
    fi
else
    echo "FAIL: mutant 10 build: $(head -c 200 "$W/mutlog")"
    fail=$((fail + 1))
fi
cp "$W/nv.orig" "$W/tree/desugar/namedval.sober"
# 7. finish の検査だけの段の並列（席 D の D-2 — loader/finpar.sober）: 拒否を 2 ファイルに置いた例の出力（stderr + 終了コード）が W1（直の道）≡ 子の道
fin() { # fin <検査器> <例> [env…] → 出力と rc
    local s=$1 e=$2
    shift 2
    (cd "$ROOT" && env "$@" "$s" check "testdata/selfpar/finish/$e" 2>&1; echo "rc=$?")
}
FINS="names_same names_cross rules_same rules_cross rules_catch"
nfin=0
for e in $FINS; do
    fin "$S2" $e SOBER_WORKERS=1 > "$W/fin1"
    grep -q '^rc=1$' "$W/fin1" || { echo "FAIL: finish $e (W1) was not rejected"; fail=$((fail + 1)); }
    for cfg in "SOBER_WORKERS=2" "SOBER_WORKERS=8" "SOBER_WORKERS=12" "SOBER_WORKERS=8 SOBER_FINISH_DIE=1"; do
        nfin=$((nfin + 1))
        # shellcheck disable=SC2086
        fin "$S2" $e $cfg > "$W/finp"
        cmp -s "$W/fin1" "$W/finp" || { echo "FAIL: finish $e ($cfg) differs from W1"; diff "$W/fin1" "$W/finp" | head -4; fail=$((fail + 1)); }
    done
done
# 変異 11〜13（席 D の D-2 — loader/finpar.sober）: 変異した検査器の W8 の出力が W1（直の道）と割れること
finmut() { # finmut <番号> <説明> <sed の式> <的の例…> — 変異した検査器を建て、的の例のどれかが W8 で W1 と割れれば捕まえた
    local k=$1 what=$2 expr=$3 e caught=0
    shift 3
    cp "$W/tree/loader/finpar.sober" "$W/finpar.orig"
    sed -i "$expr" "$W/tree/loader/finpar.sober"
    if cmp -s "$W/finpar.orig" "$W/tree/loader/finpar.sober"; then echo "FAIL: mutant $k: the anchor was not found in loader/finpar.sober"; fail=$((fail + 1)); return; fi
    if (cd "$W/tree" && "$S2" build app/main.sober --emit=elf --passes -o "$W/mut$k" > "$W/mutlog" 2>&1); then
        chmod +x "$W/mut$k"
        for e in "$@"; do
            fin "$S2" $e SOBER_WORKERS=1 > "$W/fin1"
            fin "$W/mut$k" $e SOBER_WORKERS=8 SOBER_FINISH_DIE=$([ "$k" = 13 ] && echo 1 || echo 0) > "$W/finp"
            cmp -s "$W/fin1" "$W/finp" || caught=1
        done
        [ $caught = 1 ] || { echo "FAIL: mutant $k ($what) was not caught"; fail=$((fail + 1)); }
    else
        echo "FAIL: mutant $k build: $(head -c 200 "$W/mutlog")"
        fail=$((fail + 1))
    fi
    cp "$W/finpar.orig" "$W/tree/loader/finpar.sober"
}
finmut 11 "pick the last file with a names hit" 's/^        if rs\[f\]\.nm {$/        if rs[f].nm \&\& f == n - 1 {/' names_same
finmut 12 "later files overwrite the rule positions" 's/^            if hit\[r \* 3\] == 0 \&\& rs\[f\]\.hit\[r \* 3\] > 0 {$/            if rs[f].hit[r * 3] > 0 {/' rules_same
finmut 13 "the merge ignores a dead child" 's/^    if cerr != nil {$/    if cerr != nil \&\& n < 0 {/' names_same rules_same
echo "selfpar: self check {1-path (W1 rss ${rss} MB ≤ ${rlim} MB), W 1, 8, 8 + budget 0} + self iface + $n synthetic runs + $nf layered runs + self build {1-path, W 1, 8, 8 + budget 0, 8 + roundtrip, 8 + lower split 3 rev, 8 + lower direct, 8 + lower split 8, 8 + lower split 8 child death, 8 + finish child death} + $nfin finish runs + 13 mutants, fail=$fail"
[ $fail = 0 ]
