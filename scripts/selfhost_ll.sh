#!/usr/bin/env bash
# selfhost の .ll 出力の差分オラクル: Sober 版（compiler/lower の rtlower + llvm、compiler/tools/lldump）の LLVM テキストを、
# その場の Zig 版 `$STAGE1 build --emit=ll` とスロットの宣言・番号を除いてバイト比較し（S-1 — gatelib の slot_eq）（stage1 直呼び — 第 5 黄金 testdata/lltext/ は Sober 生成なので相手にしない。
# Q1 裁定 2026-09-28）、Sober 版の .ll を
# `zig cc -O0` で ELF にして実行して期待出力 .out / .exit と照合する（実行の裏取り — obs.sh の llvm 列と同じ下ろし方）。
#
#   scripts/selfhost_ll.sh            全対象: 凍結 entries のうち Zig が受理するもの全部（fail = 0 がゲート — 到達リストは持たない）+ compiler/tools/*（cwd = compiler/、
#                                     その場の `sober build --emit=ll` と比べる）+ .ll の暫定固定点（docs/design-dev.md 最終オラクル項の暫定形）:
#                                     lldump が吐いた自分の .ll（stage2.ll）を zig cc で ELF にし、それが自分の .ll を同じバイト列で吐く（stage3.ll ≡ stage2.ll）
#   scripts/selfhost_ll.sh ENTRY...   指定の entry だけ（cwd = ルート、Zig 版と比べる）
#
# Sober 版の入力は Manifest（loaderdump と同じ）。前提: zig build 済み（$STAGE1 で差し替え可）、zig（$ZIG）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
ZIG=${ZIG:-zig}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin lldump "$tmp/lldump" || { echo "FAIL: build src/compiler/tools/lldump"; exit 1; }

ll_cc() { "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module "$@"; }

manifest() {
    echo "$1"
    echo "$ROOT/src"
    { find . -name '*.sober' -type f -not -path './std/*' -not -path './.git/*' | sed 's|^\./||'; (cd "$ROOT/src" && find std -name '*.sober' -type f); } | LC_ALL=C sort
}

# one ENTRY: Zig 版とのバイト一致 + 実行の裏取り（.out があれば）。Zig が拒否する entry は skip
one() {
    local w=${PAR_W:-$tmp} e=$1
    "$STAGE1" build "$e" --emit=ll -o "$w/z.ll" 2> /dev/null || { echo "@@ skip"; return; }
    manifest "$e" > "$w/m.txt"
    timeout 60 "$tmp/lldump" < "$w/m.txt" > "$w/s.ll" 2> "$w/serr" || { echo "FAIL: $e: lldump crashed: $(head -c 300 "$w/serr")"; echo "@@ fail"; return; }
    if grep -q '^lldump: ' "$w/s.ll"; then echo "FAIL: $e: Sober rejects: $(head -n 1 "$w/s.ll")"; echo "@@ fail"; return; fi
    if ! slot_eq "$w/z.ll" "$w/s.ll" 2> "$w/sm"; then
        echo "FAIL: $e: .ll differs: $(cat "$w/sm")"
        echo "@@ fail"
        return
    fi
    local out=${e%.sober}.out
    [ -d "$e" ] && out=$e.out
    if [ -f "$out" ]; then
        ll_cc -O0 "$w/s.ll" -o "$w/exe" 2> "$w/cerr" || { echo "FAIL: $e: zig cc rejects the Sober .ll: $(head -n 1 "$w/cerr")"; echo "@@ fail"; return; }
        local ec=0 wantec=0
        timeout 10 "$w/exe" > "$w/run.out" 2> /dev/null < "$(stdin_of "${out%.out}")" || ec=$?
        [ -f "${out%.out}.exit" ] && wantec=$(cat "${out%.out}.exit")
        if ! cmp -s "$w/run.out" "$out" || [ "$ec" != "$wantec" ]; then
            echo "FAIL: $e: run output differs from $out (exit $ec, want $wantec)"
            diff "$out" "$w/run.out" | head -n 8 || true
            echo "@@ fail"
            return
        fi
        echo "@@ run"
    fi
    echo "@@ ok"
}

# tool_one TOOL: compiler/tools/<TOOL> の .ll がその場の Zig 版と一致。lldump は暫定固定点も。
# 入力は起点の木の compiler/（boot_src — 凍結の入力。Sober 版の道具は今の compiler/ から建てたもの）
BSRC=$(boot_src)
tool_one() {
    local w=${PAR_W:-$tmp} t=$1
    (cd "$BSRC/compiler" && "$STAGE1" build "tools/$t/main.sober" --emit=ll -o "$w/z.ll") 2> "$w/zerr" || { echo "FAIL: tools/$t: Zig rejects: $(head -n 1 "$w/zerr")"; echo "@@ fail"; return; }
    (cd "$BSRC/compiler" && manifest "tools/$t/main.sober") > "$w/m.txt"
    (cd "$BSRC/compiler" && timeout 120 "$tmp/lldump" < "$w/m.txt") > "$w/s.ll" 2> "$w/serr" || { echo "FAIL: tools/$t: lldump crashed: $(head -c 300 "$w/serr")"; echo "@@ fail"; return; }
    if ! slot_eq "$w/z.ll" "$w/s.ll" 2> "$w/sm"; then
        echo "FAIL: tools/$t: .ll differs from sober build --emit=ll: $(cat "$w/sm")"
        echo "@@ fail"
        return
    fi
    if [ "$t" = lldump ]; then
        ll_cc -O0 "$w/s.ll" -o "$w/lldump_s2" 2> "$w/cerr" || { echo "FAIL: tools/lldump: zig cc rejects stage2.ll: $(head -n 1 "$w/cerr")"; echo "@@ fail"; return; }
        (cd "$BSRC/compiler" && timeout 120 "$w/lldump_s2" < "$w/m.txt") > "$w/s3.ll" 2> /dev/null || { echo "FAIL: stage2 lldump crashed"; echo "@@ fail"; return; }
        # 入力は起点の木なので lldump_s2 は起点の lower — 今の lower とはスロットの使い回しの分だけずれる（S-1）。スロットを除いて比べる
        slot_eq "$w/s3.ll" "$w/s.ll" 2> "$w/sm" || { echo "FAIL: .ll fixed point: stage3.ll differs from stage2.ll: $(cat "$w/sm")"; echo "@@ fail"; return; }
        echo "@@ fix"
    fi
    echo "@@ ok"
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    for e in "$@"; do par_run one "$e"; done
    par_wait > "$tmp/all"
    grep -v '^@@ ' "$tmp/all" || true
    echo "selfhost_ll: ok=$(par_count ok "$tmp/all"), run=$(par_count run "$tmp/all"), fail=$(par_count fail "$tmp/all")"
    [ "$(par_count fail "$tmp/all")" = 0 ]
    exit
fi

# 固定点（最長の仕事）は最初に背景で
mkdir -p "$tmp/fixw"
if tool_retired lldump; then : > "$tmp/fix.out"; else ( PAR_W=$tmp/fixw tool_one lldump ) > "$tmp/fix.out" 2>&1 & fi
while IFS= read -r e; do par_run one "$e"; done < <(frozen_lower entries)   # 凍結コーパス（主役交代 R39）— 退役分を除く（scripts/frozen/lower-retired.list）
par_wait > "$tmp/all"
for d in "$BSRC"/compiler/tools/*/; do t=$(basename "$d"); tool_retired "$t" && continue; [ "$t" = lldump ] || par_run tool_one "$t"; done
par_wait > "$tmp/tools"
wait 2> /dev/null || true
cat "$tmp/fix.out" >> "$tmp/tools"
grep -v '^@@ ' "$tmp/all" "$tmp/tools" || true
fail=$(( $(par_count fail "$tmp/all") + $(par_count fail "$tmp/tools") ))
echo "selfhost_ll: frozen ok=$(par_count ok "$tmp/all"), run=$(par_count run "$tmp/all"), fail=$(par_count fail "$tmp/all"); tools: ok=$(par_count ok "$tmp/tools"), fixed-point=$(par_count fix "$tmp/tools"), fail=$(par_count fail "$tmp/tools")"
[ "$fail" = 0 ]
