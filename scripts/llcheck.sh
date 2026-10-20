#!/usr/bin/env bash
# llcheck（.ll の道の網 — report-879）: Sober 生成の黄金 testdata/lltext/*.ll（lltext が stage2 の --emit=ll と照合済み）を全部 LLVM に通す（-c）。
# lltext は「同じバイト列か」だけを見るので、壊れた .ll（未定義の値 — examples_http_arena.ll の `%v114`〔原子の op を .ll に出していなかった〕が
# 長く気づかれなかった）を黄金に焼き込んでも鳴らない。clang があれば clang・無ければ zig cc・どちらも無ければ SKIP を明示する（空振りを黙らせない）
#   scripts/llcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
if command -v clang > /dev/null 2>&1; then
    CC=(clang -c -w -Wno-override-module); cc=clang
elif command -v "${ZIG:-zig}" > /dev/null 2>&1; then
    CC=("${ZIG:-zig}" cc -target x86_64-linux-none -c -w -Wno-override-module); cc="zig cc"
else
    echo "SKIP llcheck: neither clang nor zig is on PATH — the .ll goldens were not checked by LLVM"
    exit 0
fi
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
export W
one() { "${CC[@]}" -o "$W/$(basename "$1").o" "$1" 2> "$W/$(basename "$1").err" || { echo "FAIL: $1: $(grep -m1 'error:' "$W/$(basename "$1").err")"; }; }
fails=0
n=0
for f in testdata/lltext/*.ll; do
    while [ "$(jobs -rp | wc -l)" -ge "${JOBS:-8}" ]; do wait -n || true; done
    one "$f" >> "$W/out.$n" &
    n=$((n + 1))
done
wait
cat "$W"/out.* 2> /dev/null > "$W/all" || true
cat "$W/all"
fails=$(grep -c '^FAIL' "$W/all" || true)
echo "llcheck: $n .ll goldens through $cc -c, fail=$fails"
[ "$fails" = 0 ]
