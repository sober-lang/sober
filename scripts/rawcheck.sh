#!/usr/bin/env bash
# rawcheck（stages の passes の段 — 設計整合パスの守り。2026-10-20 決定 (C2)・report-893 / 898）:
# 同じ stage2 が「掛けた」（--emit=elf --passes）と「掛けない」（raw — --emit=ll のパスなし → zig cc -O0）の 2 通りに建てた check の経路の道具が、
# 同じ入力に同じ出力を出すことを確かめる。道具 = tools/sobercheck（lexer → parser → loader → desugar → checker の判定 JSON）と
# tools/desugardump（loader → desugar のコア AST の JSON — 旧来の照合〔stage3 / stage3raw の `check --core-json`〕と同じ形の出力）。
# 入力 = compiler/app 自身（sobercheck — コンパイラのソース全部を通す）+ examples/*.sober の全部（2 道具とも）。
# 2026-10-19 までの形（compiler/app 全体を raw で建てた stage3raw）は raw の .ll が 6.1 GB に育って clang の 4 GiB 上限を越えた（report-893）。
#   scripts/rawcheck.sh <stage2> <ビルドの木（compiler/* + std/ の写し）> <作業 dir>   標準出力の最後の行が `rawcheck: ok …` か `rawcheck: FAIL …`
# 注意: raw の道具は SOBER_WORKERS=1 で走らせる — raw × M:N（W ≥ 2）は import を持つ入力で RegionExceeded{slot_capacity} で即死する別件の穴がある
# （掛けた版は W に依らず正常 — report-898。出力は W に依らない約束なので照合の中身は変わらない）。raw は機械スタックも太いので ulimit -s unlimited
set -uo pipefail
S2=$1; B=$2; W=$3
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
mkdir -p "$W"
ZIG=${ZIG:-zig}
fail() { echo "rawcheck: FAIL $*"; exit 1; }
for t in sobercheck desugardump; do
    (cd "$B" && "$S2" build "tools/$t/main.sober" --emit=ll -o "$W/$t.raw.ll") || fail "raw build of tools/$t"
    "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module -O0 "$W/$t.raw.ll" -o "$W/$t.raw" || fail "zig cc of tools/$t (raw)"
    rm -f "$W/$t.raw.ll"
    (cd "$B" && "$S2" build "tools/$t/main.sober" --emit=elf --passes -o "$W/$t.opt") || fail "build of tools/$t (passes)"
    chmod +x "$W/$t.opt"
done
ulimit -s unlimited
# ① コンパイラ自身（compiler/app — Manifest は stages の manifest の段と同じ形）
(cd "$B" && { echo app; echo .; { find . -name '*.sober' -type f -not -path './std/*' | sed 's|^\./||'; find std -name '*.sober' -type f; } | LC_ALL=C sort; }) > "$W/app.m"
(cd "$B" && SOBER_WORKERS=1 "$W/sobercheck.opt" < "$W/app.m" > "$W/app.opt" 2> /dev/null)
(cd "$B" && SOBER_WORKERS=1 "$W/sobercheck.raw" < "$W/app.m" > "$W/app.raw" 2> /dev/null)
[ -s "$W/app.opt" ] && cmp -s "$W/app.opt" "$W/app.raw" || fail "compiler/app: sobercheck の掛けた / 掛けないの判定が違う（$(head -c 100 "$W/app.opt") / $(head -c 100 "$W/app.raw")）"
# ② examples/*.sober（std と examples を並べた根 — manifest の段と同じ組み方）
mkdir -p "$W/mroot" && ln -sfn "$ROOT/src/std" "$W/mroot/std" && ln -sfn "$ROOT/examples" "$W/mroot/examples"
(cd "$W/mroot" && find -L std -name '*.sober' -type f | LC_ALL=C sort) > "$W/stdlist"
one() { # one <entry>: 2 道具 × 掛けた / 掛けないの出力（と終了コード）を比べ、違えば DIFF 行
    local e=$1 k m t a b
    k=$(echo "$e" | tr '/.' '__'); m="$W/x.$k.m"
    (cd "$W/mroot" && { echo "$e"; echo .; { echo "$e"; cat "$W/stdlist"; } | LC_ALL=C sort; }) > "$m"
    for t in sobercheck desugardump; do
        # 出力と終了コードの組（拒否の出力も照合する）
        a=$(cd "$W/mroot" && { SOBER_WORKERS=1 timeout 120 "$W/$t.opt" < "$m" 2> /dev/null; echo "exit=$?"; } | md5sum)
        b=$(cd "$W/mroot" && { SOBER_WORKERS=1 timeout 120 "$W/$t.raw" < "$m" 2> /dev/null; echo "exit=$?"; } | md5sum)
        [ "$a" = "$b" ] || echo "DIFF $t $e"
    done
    rm -f "$m"
}
export -f one; export W
(cd "$W/mroot" && ls examples/*.sober) | xargs -P "${RAWCHECK_JOBS:-6}" -I{} bash -c 'ulimit -s unlimited; one "$@"' _ {} > "$W/ex.log"
n=$(cd "$W/mroot" && ls examples/*.sober | wc -l)
if grep -q '^DIFF' "$W/ex.log"; then
    fail "examples: $(grep -c '^DIFF' "$W/ex.log") 件 — $(head -3 "$W/ex.log" | tr '\n' ' ')"
fi
echo "rawcheck: ok — compiler/app の判定 + examples ${n} 本 × {sobercheck, desugardump} が掛けた ≡ 掛けない"
