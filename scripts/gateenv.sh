#!/usr/bin/env bash
# gateenv: 照合できないゲートは、明示して外さない限りFAILにすることの検査（gatelib.shのcant・need_perf・need_valgrind・need_nofile）。
# 条件の種類（道具が無い・権限が無い・CPUの機能が無い・CPUの数が足りない）で分けない。外すのはSOBER_GATES_ALLOW_SKIP（条件の名前を空白区切り）
#   1. cant: 一覧に条件があれば `SKIP[条件] ゲート: …` を出して0・無ければFAILの行を出して1
#   2. need_perf・need_valgrind: 使えなければ2（FAILの行）・外せば1（SKIPの行）・このサーバーでperfが使えれば0。need_nofile: hardの範囲で上げる・足りなければ2
#   3. lint（gates.shのORDERにある名前のscripts/<名前>.shと、ORDERに無いbootcheck）:
#      - SKIPの行をcantを通さずに出さない（例外はキャッシュの「SKIP: inputs unchanged」と、条件の名前つきの `SKIP[…]`）。「note: … skipped」の形も持たない
#      - cantに渡す条件の名前と `SKIP[…]` の名前は、下のCONDSのどれか
#      - perf statに -e instructions:uを渡すスクリプトはneed_perfを、valgrindを --tool= で走らせるスクリプトはneed_valgrindを呼ぶ
#   4. 通し: ringinst・reqinst（冒頭で計器を探す）を、使えない計器で走らせるとFAIL・一覧で外せばSKIPで緑
#
#   scripts/gateenv.sh
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
# 外せる条件の名前（SOBER_GATES_ALLOW_SKIPに書ける語）
CONDS=" perf valgrind nofile cpus io_uring unshare llvm python3 aes bmi2 boot-history SELFHOST_E2E_SKIP "
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
unset SOBER_GATES_ALLOW_SKIP

# 1. cant
out=$(cant probe perf "x"); rc=$?
[ $rc = 1 ] && [[ "$out" == "probe: FAIL: perf "* ]] || bad "cant without SOBER_GATES_ALLOW_SKIP: rc=$rc out=$out (want 1 and a FAIL line)"
out=$(SOBER_GATES_ALLOW_SKIP="cpus perf" cant probe perf "x"); rc=$?
[ $rc = 0 ] && [ "$out" = "SKIP[perf] probe: x" ] || bad "cant with perf in SOBER_GATES_ALLOW_SKIP: rc=$rc out=$out (want 0 and a SKIP[perf] line)"
out=$(SOBER_GATES_ALLOW_SKIP="perfx" cant probe perf "x"); rc=$?
[ $rc = 1 ] || bad "cant matched a partial name in SOBER_GATES_ALLOW_SKIP (perfx): rc=$rc"

# 2. need_perf・need_valgrind・need_nofile
out=$(PERF=/bin/false need_perf probe); rc=$?
[ $rc = 2 ] && [[ "$out" == "probe: FAIL: perf "* ]] || bad "need_perf with an unusable PERF: rc=$rc out=$out (want 2 and a FAIL line)"
out=$(SOBER_GATES_ALLOW_SKIP=perf PERF=/bin/false need_perf probe); rc=$?
[ $rc = 1 ] && [[ "$out" == "SKIP[perf] probe: "* ]] || bad "need_perf with perf allowed to skip: rc=$rc out=$out (want 1 and a SKIP[perf] line)"
hasperf=0
( unset PERF; need_perf probe > /dev/null ) && hasperf=1
if [ $hasperf = 1 ]; then
    out=$(unset PERF; need_perf probe; echo "rc=$?"); [ "$out" = "rc=0" ] || bad "need_perf with perf on this box: $out (want rc=0)"
fi
out=$(VALGRIND=/bin/false need_valgrind probe); rc=$?
[ $rc = 2 ] && [[ "$out" == "probe: FAIL: valgrind "* ]] || bad "need_valgrind with an unusable VALGRIND: rc=$rc out=$out (want 2 and a FAIL line)"
out=$(SOBER_GATES_ALLOW_SKIP=valgrind VALGRIND=/bin/false need_valgrind probe); rc=$?
[ $rc = 1 ] && [[ "$out" == "SKIP[valgrind] probe: "* ]] || bad "need_valgrind with valgrind allowed to skip: rc=$rc out=$out (want 1 and a SKIP[valgrind] line)"
# サブシェルの中でhardを下げて見る。親のlimitは変えない
out=$(ulimit -Sn 256 && ulimit -Hn 512 && need_nofile probe 400 && ulimit -Sn); [ "$out" = 400 ] || bad "need_nofile did not raise soft 256 to 400 under hard 512: $out"
out=$(ulimit -n 256 && need_nofile probe 400); rc=$?
[ $rc = 2 ] && [[ "$out" == "probe: FAIL: nofile "* ]] || bad "need_nofile with hard 256 < 400: rc=$rc out=$out (want 2 and a FAIL line)"

# 3. lint
ORDER=$(sed -n 's/^ORDER=(\(.*\))/\1/p' scripts/gates.sh)
nf=0 nl=0 nv=0
for g in $ORDER bootcheck; do
    f=scripts/$g.sh
    { [ "$g" = gateenv ] || [ ! -f "$f" ]; } && continue
    nf=$((nf + 1))
    # cantを通さないSKIPの行（キャッシュのinputs unchangedと、条件の名前つきのSKIP[…]は除く）
    while read -r l; do bad "$f:${l%%:*} prints SKIP without cant: ${l#*:}"; done < <(grep -n 'echo[^#]*SKIP' "$f" | grep -v 'SKIP: inputs unchanged' | grep -v 'SKIP\[')
    while read -r c; do case "$CONDS" in *" $c "*) ;; *) bad "$f prints SKIP[$c] (not in CONDS)" ;; esac; done < <(grep -o 'echo[^#]*SKIP\[[^]]*\]' "$f" | sed 's/.*SKIP\[\([^]]*\)\]/\1/')
    grep -qiE 'echo[^#]*note:[^#]*skip' "$f" && bad "$f skips a check with a note line instead of cant"
    while read -r c; do case "$CONDS" in *" $c "*) ;; *) bad "$f calls cant with the condition $c (not in CONDS)" ;; esac; done < <(grep -oE '\bcant [a-z0-9_]+ [A-Za-z0-9_-]+' "$f" | awk '{ print $3 }')
    if grep -q -- '-e instructions:u' "$f"; then
        nl=$((nl + 1))
        grep -q 'need_perf ' "$f" || bad "$f uses perf stat instructions:u without need_perf"
    fi
    if grep -q -- '--tool=' "$f"; then
        nv=$((nv + 1))
        grep -q 'need_valgrind ' "$f" || bad "$f runs valgrind without need_valgrind"
    fi
done
[ $nl -ge 3 ] || bad "lint found only $nl gate scripts using instructions:u (stages・selfpar・ringinst at least)"
[ $nv -ge 1 ] || bad "lint found no gate script running valgrind (reqinst at least)"

# 4. 通し（ringinst・reqinst）
S2=${STAGE2:-out/stage2/sober2}
out=$(STAGE2=$S2 PERF=/bin/false scripts/ringinst.sh 2>&1); rc=$?
[ $rc != 0 ] && grep -q '^ringinst: FAIL: perf' <<< "$out" || bad "ringinst with an unusable PERF: rc=$rc ($(tail -n 1 <<< "$out"))"
out=$(STAGE2=$S2 PERF=/bin/false SOBER_GATES_ALLOW_SKIP=perf scripts/ringinst.sh 2>&1); rc=$?
[ $rc = 0 ] && grep -q '^SKIP\[perf\] ringinst: ' <<< "$out" || bad "ringinst with perf allowed to skip: rc=$rc ($(tail -n 1 <<< "$out"))"
out=$(STAGE2=$S2 VALGRIND=/bin/false scripts/reqinst.sh 2>&1); rc=$?
[ $rc != 0 ] && grep -q '^reqinst: FAIL: valgrind' <<< "$out" || bad "reqinst with an unusable VALGRIND: rc=$rc ($(tail -n 1 <<< "$out"))"
out=$(STAGE2=$S2 VALGRIND=/bin/false SOBER_GATES_ALLOW_SKIP=valgrind scripts/reqinst.sh 2>&1); rc=$?
[ $rc = 0 ] && grep -q '^SKIP\[valgrind\] reqinst: ' <<< "$out" || bad "reqinst with valgrind allowed to skip: rc=$rc ($(tail -n 1 <<< "$out"))"

echo "gateenv: cant + need_perf (unusable / allowed$([ $hasperf = 1 ] && echo " / usable")) + need_valgrind + need_nofile + $nf gate scripts linted ($nl perf · $nv valgrind) + ringinst and reqinst end to end, fail=$fail"
[ $fail = 0 ]
