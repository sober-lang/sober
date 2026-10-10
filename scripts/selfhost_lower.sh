#!/usr/bin/env bash
# selfhost の lower の差分オラクル: Sober 版（compiler/lower + compiler/tools/lowerdump）の IR テキストを、その場の Zig 版
# `$STAGE1 build --emit=ir` とスロットの宣言・番号を除いてバイト比較し（S-1 — gatelib の slot_eq）（stage1 直呼び — 第 4 黄金 testdata/irtext/ は Sober 生成なので相手にしない。Q1 裁定 2026-09-28）、さらに Sober 版の IR テキストを Zig 版バックエンドに食わせて
# （`sober build x.ir -o exe` — ir_parse → mem2reg → rtlower → ir_x86）実行し、期待出力 examples/<name>.out と照合する（実行の裏取り）。
#
#   scripts/selfhost_lower.sh            到達リスト scripts/frozen/lower.list（凍結 — 主役交代 R39） の全部（リスト内 fail = 0 がゲート）。
#                                        加えて凍結 entries（scripts/frozen/entries.list）のうち Zig が受理する残りを回して、リスト外の一致数を参考に出す（ゲートにしない）
#   scripts/selfhost_lower.sh ENTRY...   指定の entry だけ（リスト外の集計なし）
#
# Sober 版の入力は Manifest（loaderdump と同じ）。前提: zig build 済み（$STAGE1 で差し替え可）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin lowerdump "$tmp/lowerdump" || { echo "FAIL: build src/compiler/tools/lowerdump"; exit 1; }

manifest() {
    echo "$1"
    echo "$ROOT/src"
    { find . -name '*.sober' -type f -not -path './std/*' -not -path './.git/*' | sed 's|^\./||'; (cd "$ROOT/src" && find std -name '*.sober' -type f); } | LC_ALL=C sort
}

# one ENTRY: @@ ok / @@ fail（gate = 1 なら実行の裏取りもする）/ @@ skip（gate = 0 で Zig が拒否 — リスト外の参考から外す）
one() {
    local w=${PAR_W:-$tmp} e=$1 gate=$2
    if ! "$STAGE1" build "$e" --emit=ir -o "$w/z.ir" 2> "$w/zerr"; then
        if [ "$gate" = 0 ]; then echo "@@ skip"; return; fi
        echo "FAIL: $e: Zig rejects: $(head -n 1 "$w/zerr")"
        echo "@@ fail"
        return
    fi
    manifest "$e" > "$w/m.txt"
    timeout 60 "$tmp/lowerdump" < "$w/m.txt" > "$w/s.ir" 2> "$w/serr" || { echo "FAIL: $e: lowerdump crashed: $(head -c 300 "$w/serr")"; echo "@@ fail"; return; }
    if grep -q '^lowerdump: ' "$w/s.ir"; then
        [ "$gate" = 1 ] && echo "FAIL: $e: Sober rejects: $(head -n 1 "$w/s.ir")"
        echo "@@ fail"
        return
    fi
    if ! slot_eq "$w/z.ir" "$w/s.ir" 2> "$w/sm"; then
        if [ "$gate" = 1 ]; then
            echo "FAIL: $e: IR text differs: $(cat "$w/sm")"
        fi
        echo "@@ fail"
        return
    fi
    if [ "$gate" = 1 ]; then
        local name out
        name=$(basename "$e" .sober)
        out=${e%.sober}.out
        [ -d "$e" ] && out=$e.out
        if [ -f "$out" ]; then
            "$STAGE1" build "$w/s.ir" -o "$w/exe" 2> "$w/berr" || { echo "FAIL: $e: backend rejects the Sober IR: $(head -n 1 "$w/berr")"; echo "@@ fail"; return; }
            local ec=0
            timeout 10 "$w/exe" > "$w/run.out" 2> /dev/null < "$(stdin_of "${out%.out}")" || ec=$?
            local wantec=0
            [ -f "${out%.out}.exit" ] && wantec=$(cat "${out%.out}.exit")
            if ! cmp -s "$w/run.out" "$out" || [ "$ec" != "$wantec" ]; then
                echo "FAIL: $e: run output differs from $out (exit $ec, want $wantec)"
                diff "$out" "$w/run.out" | head -n 8 || true
                echo "@@ fail"
                return
            fi
            echo "@@ run"
        fi
    fi
    [ "$gate" = 0 ] && echo "outside-match: $e"
    echo "@@ ok"
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    for e in "$@"; do par_run one "$e" 1; done
    par_wait > "$tmp/all"
    grep -v '^@@ ' "$tmp/all" || true
    echo "selfhost_lower: ok=$(par_count ok "$tmp/all"), run=$(par_count run "$tmp/all"), fail=$(par_count fail "$tmp/all")"
    [ "$(par_count fail "$tmp/all")" = 0 ]
    exit
fi

# 自己適用（compiler/tools/* — cwd = 起点の木の compiler/ = boot_src。凍結の入力）: lowerdump の出力が Zig 版 `sober build --emit=ir` とバイト一致（黄金は持たない — その場で比べる）
BSRC=$(boot_src)
tool_one() { # $1 = tool 名
    local w=${PAR_W:-$tmp} t=$1
    (cd "$BSRC/compiler" && "$STAGE1" build "tools/$t/main.sober" --emit=ir -o "$w/z.ir") 2> "$w/zerr" || { echo "FAIL: tools/$t: Zig rejects: $(head -n 1 "$w/zerr")"; echo "@@ fail"; return; }
    (cd "$BSRC/compiler" && manifest "tools/$t/main.sober") > "$w/m.txt"
    (cd "$BSRC/compiler" && timeout 120 "$tmp/lowerdump" < "$w/m.txt") > "$w/s.ir" 2> "$w/serr" || { echo "FAIL: tools/$t: lowerdump crashed: $(head -c 300 "$w/serr")"; echo "@@ fail"; return; }
    if ! slot_eq "$w/z.ir" "$w/s.ir" 2> "$w/sm"; then
        echo "FAIL: tools/$t: IR text differs from sober build --emit=ir: $(cat "$w/sm")"
        echo "@@ fail"
        return
    fi
    # IR 境界の固定点: Sober 版が下ろした lowerdump の IR を Zig 版バックエンドで ELF にし（lowerdump2）、それが自分の IR を同じバイト列で吐く
    if [ "$t" = lowerdump ]; then
        "$STAGE1" build "$w/s.ir" -o "$w/lowerdump2" 2> "$w/berr" || { echo "FAIL: tools/lowerdump: backend rejects the Sober IR: $(head -n 1 "$w/berr")"; echo "@@ fail"; return; }
        (cd "$BSRC/compiler" && timeout 120 "$w/lowerdump2" < "$w/m.txt") > "$w/s2.ir" 2> /dev/null || { echo "FAIL: lowerdump2 crashed"; echo "@@ fail"; return; }
        # 入力は起点の木なので lowerdump2 は起点の lower — 今の lower とはスロットの使い回しの分だけずれる（S-1）。スロットを除いて比べる
        slot_eq "$w/s2.ir" "$w/s.ir" || { echo "FAIL: IR fixed point: lowerdump2 (built from the Sober IR) prints a different IR of itself"; echo "@@ fail"; return; }
        echo "@@ fix"
    fi
    echo "@@ ok"
}
# lowerdump の自己一致 + 固定点（最長の仕事 — 27 秒の ELF 化を含む）は最初に背景で走らせ、他の照合と重ねる
mkdir -p "$tmp/fixw"
fixpid=""
if tool_retired lowerdump; then : > "$tmp/fix.out"; else ( PAR_W=$tmp/fixw tool_one lowerdump ) > "$tmp/fix.out" 2>&1 & fixpid=$!; fi

mapfile -t listed < <(frozen_lower lower)   # 凍結コーパス（主役交代 R39）
declare -A inlist=()
for e in "${listed[@]}"; do inlist[$e]=1; done
for e in "${listed[@]}"; do par_run one "$e" 1; done
par_wait > "$tmp/list"
grep -v '^@@ ' "$tmp/list" || true
fail=$(par_count fail "$tmp/list")
# リスト外（参考）: 凍結 entries のうちリストに無いもの（Zig が拒否する entry は one が skip にする）
: > "$tmp/rest"
while IFS= read -r e; do
    # 在籍の判定は連想配列で（printf | grep -q は pipefail の下で SIGPIPE により揺れる）
    [ -n "${inlist[$e]:-}" ] && continue
    par_run one "$e" 0
done < <(frozen_lower entries)
par_wait > "$tmp/rest"
grep '^outside-match: ' "$tmp/rest" || true

for d in "$BSRC"/compiler/tools/*/; do t=$(basename "$d"); tool_retired "$t" && continue; [ "$t" = lowerdump ] || par_run tool_one "$t"; done
par_wait > "$tmp/tools"
[ -z "$fixpid" ] || wait "$fixpid" 2> /dev/null || true  # par_wait の wait が先に回収していることがある
cat "$tmp/fix.out" >> "$tmp/tools"
grep -v '^@@ ' "$tmp/tools" || true
tfail=$(par_count fail "$tmp/tools")
echo "selfhost_lower: list ${#listed[@]} entries — ok=$(par_count ok "$tmp/list"), run=$(par_count run "$tmp/list"), fail=$fail; outside the list: $(par_count ok "$tmp/rest") of $(( $(par_count ok "$tmp/rest") + $(par_count fail "$tmp/rest") )) match; tools: ok=$(par_count ok "$tmp/tools"), fixed-point=$(par_count fix "$tmp/tools"), fail=$tfail"
[ "$fail" = 0 ] && [ "$tfail" = 0 ]
