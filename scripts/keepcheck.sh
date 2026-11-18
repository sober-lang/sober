#!/usr/bin/env bash
# keepcheck（全レジスタを保つ中継の検査 — rt.wm_alloc_s / rt.wm_raise_s・x86.soberのxKeepAllBody）: 呼び手は中継の呼び出しを「rax・rcx・rdx・フラグだけを
# 壊す命令」として扱い、caller-savedのレジスタに値を載せたまま跨ぐ。中継が積み忘れたレジスタは、跨いだ値を黙って壊す。
# 確保の点が多く低速パスを実際に踏むプログラムとして、コンパイラ自身（src/compiler/app — 確保の点が約1万か所）を今のstage2でビルドし、そのコンパイラで
# testdata/keepcheck をビルドして走らせる。変異なしは出力が testdata/keepcheck/main.out と一致すること。続けて開発用 --rt-mutant=103（中継がrsiを積まない）
# で焼いたコンパイラが、同じことに失敗すること（落ちるか出力が違う）
#   scripts/keepcheck.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$(pwd)
. scripts/stagelib.sh
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
stage_tree "$W/root"
export SOBER_BUILD_CACHE=0 SOBER_CHECK_CACHE=0
fail=0
for v in ok m103; do
    f=""
    [ $v = m103 ] && f="--rt-mutant=103"
    (cd "$W/root" && "$ROOT/$S2" build app --emit=elf --passes $f -o "$W/sober.$v") > "$W/b.$v.log" 2>&1 || { echo "keepcheck: FAIL build of the compiler ($v)"; cat "$W/b.$v.log" | head -5; exit 1; }
    timeout -s KILL 300 "$W/sober.$v" build testdata/keepcheck/main.sober -o "$W/t.$v" > "$W/t.$v.log" 2>&1
    rc=$?
    if [ $rc = 0 ]; then
        timeout -s KILL 120 "$W/t.$v" > "$W/t.$v.out" 2>&1
        rc=$?
    fi
    echo $rc > "$W/$v.rc"
done
if [ "$(cat "$W/ok.rc")" != 0 ] || ! cmp -s "$W/t.ok.out" testdata/keepcheck/main.out; then
    echo "FAIL: the self-built compiler did not build and run testdata/keepcheck (rc $(cat "$W/ok.rc"))"
    head -5 "$W/t.ok.log" "$W/t.ok.out" 2>/dev/null
    fail=$((fail + 1))
fi
if [ "$(cat "$W/m103.rc")" = 0 ] && cmp -s "$W/t.m103.out" testdata/keepcheck/main.out; then
    echo "FAIL: mutant 103 (the relay does not save rsi) was not caught"
    fail=$((fail + 1))
fi
echo "keepcheck: self-built compiler → testdata/keepcheck $(cat "$W/t.ok.out" 2>/dev/null); mutant 103 caught (rc $(cat "$W/m103.rc")), fail=$fail"
[ $fail = 0 ]
