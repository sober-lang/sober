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
for cfg in "SOBER_WORKERS=1" "SOBER_WORKERS=8 SOBER_PAR_STATS=1" "SOBER_WORKERS=8 SOBER_BUDGET_MB=0" "SOBER_WORKERS=8 SOBER_BUILD_PAR=roundtrip"; do
    # shellcheck disable=SC2086
    (cd "$W/tree" && env $cfg "$S2" build app/main.sober --emit=elf --passes -o "$W/bpar" > "$W/blog" 2>&1) || { echo "FAIL: self build ($cfg): $(head -c 200 "$W/blog")"; fail=$((fail + 1)); }
    cmp -s "$W/bseq" "$W/bpar" || { echo "FAIL: self build ($cfg) differs from the 1-path"; fail=$((fail + 1)); }
    if [[ $cfg == *PAR_STATS* ]]; then
        ended=$(grep '^#par tasks' "$W/blog" | sed 's/.*ended=\([0-9]*\).*/\1/')
        [ "${ended:-0}" -gt 1 ] || { echo "FAIL: self build (W=8) ran no group task (ended=${ended:-?})"; fail=$((fail + 1)); }
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
echo "selfpar: self check {1-path (W1 rss ${rss} MB ≤ ${rlim} MB), W 1, 8, 8 + budget 0} + self iface + $n synthetic runs + $nf layered runs + self build {1-path, W 1, 8, 8 + budget 0, 8 + roundtrip} + 7 mutants, fail=$fail"
[ $fail = 0 ]
