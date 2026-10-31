#!/usr/bin/env bash
# outline（gates）: `sober outline` の出力 ≡ 黄金 testdata/outline/*.golden（text / json）+ json の形の照合（node）。
#   題材 = testdata/outline/sample.sober（宣言の種類・注釈・複数行の署名・doc）・examples の 2 本・std の package（ディレクトリ・--depth・--no-test・--public）
#   scripts/outline.sh [--regen]   --regen は黄金を書き直す
set -uo pipefail
cd "$(dirname "$0")/.."
scripts/stage2.sh --quiet || exit 1
S2=$PWD/out/stage2/sober2
G=testdata/outline
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
regen=0
[ "${1:-}" = "--regen" ] && regen=1
fail=0
n=0
# 名前|引数（空白区切り）
CASES=(
    "sample.txt|$G/sample.sober"
    "sample.json|$G/sample.sober --format=json"
    "sample_public.txt|$G/sample.sober --public"
    "alias.txt|examples/alias.sober"
    "http_hello.json|examples/http_hello.sober --format=json"
    "std_os.txt|src/std/os --no-test"
    "std_cli_public.json|src/std/cli --no-test --public --format=json"
    "std_hash_depth2.txt|src/std/hash --depth 2"
)
for c in "${CASES[@]}"; do
    name=${c%%|*}
    args=${c#*|}
    # shellcheck disable=SC2086
    "$S2" outline $args > "$W/$name" 2> "$W/$name.err" || { echo "FAIL outline $args:"; cat "$W/$name.err"; fail=1; continue; }
    n=$((n + 1))
    if [ $regen = 1 ]; then
        cp "$W/$name" "$G/$name.golden"
    elif ! diff -q "$W/$name" "$G/$name.golden" > /dev/null 2>&1; then
        echo "FAIL $G/$name.golden differs (scripts/outline.sh --regen):"; diff "$W/$name" "$G/$name.golden" | head -8; fail=1
    fi
    case $name in
        *.json) node -e '
            const a = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"));
            const ok = Array.isArray(a) && a.every(f => typeof f.file === "string" && typeof f.package === "string" && Array.isArray(f.imports)
                && Array.isArray(f.decls) && f.decls.every(d => ["type", "func", "const", "intrinsic"].includes(d.kind) && typeof d.name === "string"
                && typeof d.sig === "string" && Array.isArray(d.lines) && d.lines.length === 2 && d.lines[0] <= d.lines[1] && typeof d.doc === "string"));
            if (!ok) { console.log("FAIL json shape: " + process.argv[1]); process.exit(1); }' "$W/$name" || fail=1 ;;
    esac
done
# 負例: parse できないファイルは名指しして終了 1・使い方の誤りは終了 2
"$S2" outline examples/bind.sober > /dev/null 2> "$W/neg.err"; ec=$?
{ [ $ec = 1 ] && grep -q 'parse error in examples/bind.sober' "$W/neg.err"; } || { echo "FAIL parse error not named (exit $ec):"; cat "$W/neg.err"; fail=1; }
"$S2" outline "$G/sample.sober" --format=xml > /dev/null 2>&1; ec=$?
[ $ec = 2 ] || { echo "FAIL --format=xml: exit $ec (want 2)"; fail=1; }
[ $regen = 1 ] && { echo "outline: regenerated $n goldens in $G"; exit $fail; }
echo "outline: cases $n + negatives 2, fail=$fail"
exit $fail
