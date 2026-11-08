#!/usr/bin/env bash
# mdwecheck（rt の入口の PR_SET_MDWE — docs/guide/security の「実行可能メモリの放棄」）: testdata/mdwe の題材を建て、SOBER_MDWE_REPORT の
# `mdwe <PR_GET_MDWE>` を照合する。Linux 6.6+（PR_MDWE_NO_INHERIT がある）では 3（REFUSE_EXEC_GAIN | NO_INHERIT）・それより古いカーネルでは
# 掛けない（3 でない）。os.Run の子は引き継がない（0 — python3 が無ければその照合だけ SKIP）。SOBER_MDWE=0 では掛けない（0）
#   scripts/mdwecheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
IFS=. read -r kmaj kmin _ <<< "$(uname -r)"
want=0
if [ "$kmaj" -gt 6 ] || { [ "$kmaj" -eq 6 ] && [ "${kmin%%[^0-9]*}" -ge 6 ]; }; then want=3; fi
fail=0
for p in seq task child; do
    "$S2" build "testdata/mdwe/$p.sober" -o "$W/$p" > "$W/$p.blog" 2>&1 || { echo "mdwecheck: FAIL build $p ($(head -c 200 "$W/$p.blog"))"; exit 1; }
    out=$(SOBER_MDWE_REPORT=1 "$W/$p" 2>&1)
    got=$(sed -n 's/^mdwe //p' <<< "$out")
    if [ "$want" = 3 ] && [ "$got" != 3 ]; then echo "FAIL $p: mdwe=$got (want 3)"; fail=1; fi
    if [ "$want" = 0 ] && [ "$got" = 3 ]; then echo "FAIL $p: mdwe=3 on a kernel without NO_INHERIT"; fail=1; fi
    if [ "$p" = child ]; then
        if command -v python3 > /dev/null 2>&1; then
            c=$(sed -n 's/^child //p' <<< "$out")
            [ "$c" = 0 ] || { echo "FAIL child: child mdwe=$c (want 0 — NO_INHERIT)"; fail=1; }
        else
            echo "note: python3 missing — child check skipped"
        fi
    fi
    # SOBER_MDWE=0 の走り（valgrind 等の動的計装の口）は掛けない（0）
    off=$(SOBER_MDWE=0 SOBER_MDWE_REPORT=1 "$W/$p" 2>&1 | sed -n 's/^mdwe //p')
    [ "$off" = 0 ] || { echo "FAIL $p: SOBER_MDWE=0 gave mdwe=$off (want 0)"; fail=1; }
    # 印の無い走り（SOBER_MDWE_REPORT なし）は何も足さない
    [ -z "$(SOBER_MDWE_REPORT= "$W/$p" 2>&1 | grep '^mdwe ')" ] || { echo "FAIL $p: report without the flag"; fail=1; }
done
echo "mdwecheck: 3 programs (seq / task / os.Run child) + SOBER_MDWE=0 — kernel $(uname -r) want mdwe=$want, fail=$fail"
exit $fail
