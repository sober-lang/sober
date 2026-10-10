#!/usr/bin/env bash
# acquire / release 照合（analyzer 1 本目）の動的オラクル — T1: Pool の未返却カウンタ（V5-3）。
#
#   scripts/pool_oracle.sh
#
# 述語（健全性 = 見逃し側だけ — language.md 未決「analyzer の実装方針」）:
#   analyzer が受理したプログラムは、終了直前の未返却が 0（最終行 "outstanding 0"）
# コーパス testdata/pool/*.sober は Pool を main に持ち、最終行で pool.Outstanding を出す約束。
# 変異: 各 `defer ...Release(...)` 行を 1 本ずつ消す → analyzer は必ず拒否（静的）。build は analyzer を
# 走らせないので変異体も実行でき、未返却 > 0 が観測されたら「オラクルも漏れを見た」として数える（動的）。
# 実行されない枝の変異は動的には見えない — 静的拒否だけが要求で、動的観測は参考値。
# ディレクトリ entry（複数 package の例 — testdata/minic/app、V5-7）も同じ約束で回す。import はリポのルート相対なので、
# 変異はリポの外に写した testdata の木で作り、その木を cwd にして check / build / 実行する（リポの作業木は触らない）。
# analyzer は主の sober（compiler/analyzer — A1 で Zig 版から移植）。凍結した Zig 版（src/stage1/analyzer.zig）とは指摘の行を全部照合する
# （本体・変異体・負例 testdata/pool_neg/forms.sober — 負例は期待の forms.err とも照合）。
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=$(realpath ./bin/sober)
STAGE1=$(realpath "${STAGE1:-./src/stage1/zig-out/bin/sober}")
export SOBER_CHECK=${SOBER_CHECK:-$PWD/lean/.lake/build/bin/sober-check}
W=$(mktemp -d)
T=$W/tree
mkdir -p "$T"
cp -r testdata "$T/"
fail=0
progs=0
mutants=0
rejected=0
leaked=0
intree() { (cd "$T" && "$@"); }
# zigsame <entry> <主の stderr>: Zig 版の analyzer の指摘の行（検査器は常に受理のスタブ）が主の sober と同じか
printf '#!/bin/sh\ncat > /dev/null\necho "{\\"ok\\":true}"\n' > "$W/stub"
chmod +x "$W/stub"
zigsame() {
    (cd "$T" && SOBER_CHECK="$W/stub" "$STAGE1" check "$1" 2>&1 > /dev/null) | { grep '(Analyzer)' || true; } > "$W/z.err"
    { grep '(Analyzer)' "$2" || true; } > "$W/s.err"
    diff -q "$W/s.err" "$W/z.err" > /dev/null || { echo "ZIG DIFF $1: $(diff "$W/s.err" "$W/z.err" | head -3)"; fail=1; }
}
for src in testdata/pool/*.sober testdata/minic/app; do
    n=$(echo "$src" | tr '/.' '__')
    progs=$((progs + 1))
    if ! intree "$SOBER" check "$src" > /dev/null 2> "$W/$n.err"; then
        echo "CHECK FAIL $src: $(head -3 "$W/$n.err")"
        fail=1
        continue
    fi
    zigsame "$src" "$W/$n.err"
    intree "$SOBER" build "$src" -o "$W/$n" > /dev/null 2>&1 || { echo "BUILD FAIL $src"; fail=1; continue; }
    last=$(intree "$W/$n" | tail -1)
    [ "$last" = "outstanding 0" ] || { echo "ORACLE FAIL $src: analyzer accepted but '$last'"; fail=1; }
    files=$src
    [ -d "$src" ] && files=$(ls "$src"/*.sober)
    for f in $files; do
        for ln in $(grep -n 'defer .*Release(' "$f" | cut -d: -f1); do
            sed "${ln}d" "$f" > "$T/$f"
            mutants=$((mutants + 1))
            intree "$SOBER" check "$src" > /dev/null 2> "$W/m.err"
            zigsame "$src" "$W/m.err"
            if grep -q '(Analyzer)' "$W/m.err"; then
                rejected=$((rejected + 1))
            else
                echo "MUTANT ACCEPTED $f: line $ln deleted"
                fail=1
            fi
            if intree "$SOBER" build "$src" -o "$W/m.bin" > /dev/null 2>&1; then
                mlast=$(intree "$W/m.bin" | tail -1)
                [ "$mlast" != "outstanding 0" ] && leaked=$((leaked + 1))
            fi
            cp "$f" "$T/$f"
        done
    done
done
# 負例: 拒否の形を全部並べた 1 本 — 期待の指摘（forms.err）と Zig 版の両方に一致
neg=testdata/pool_neg/forms.sober
intree "$SOBER" check "$neg" > /dev/null 2> "$W/neg.err"
diff -q "$W/neg.err" testdata/pool_neg/forms.err > /dev/null || { echo "NEG DIFF $neg: $(diff "$W/neg.err" testdata/pool_neg/forms.err | head -3)"; fail=1; }
zigsame "$neg" "$W/neg.err"
rm -r "$W"
echo "pool oracle: $progs programs, mutants $mutants (analyzer rejected $rejected, leak observed at run $leaked), fail=$fail"
exit $fail
