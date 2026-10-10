#!/usr/bin/env bash
# 設計整合パス（S-3.5 — `sober build --passes`、compiler/lower/opt.sober）の実行照合。irtext の対象のうち期待出力 .out を持つ entry を
# stage2 の `--emit=ir --passes` に通し、その IR テキストを stage1（凍結した Zig）の `build x.ir` に食わせて（ir_parse → verify → mem2reg →
# rtlower → ir_x86）実行し、.out / .exit と照合する。パスを掛けた IR が構文・検証を通り、観測が変わらないことを見る
# （掛けない IR は irtext / selfhost_lower が見る）。
#
#   scripts/passes.sh
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
STAGE1=${STAGE1:-./src/stage1/zig-out/bin/sober}
STAGE2=${STAGE2:-./out/stage2/sober2}
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

one() {
    local w=${PAR_W:-$tmp} e=$1 out ec=0 want=0
    out=${e%.sober}.out
    [ -d "$e" ] && out=$e.out
    [ -f "$out" ] || { echo "@@ skip"; return; }
    "$STAGE2" build "$e" --emit=ir --passes -o "$w/p.ir" 2> "$w/err" || { echo "FAIL: $e: lower rejects with --passes: $(head -c 200 "$w/err")"; echo "@@ fail"; return; }
    # stage1 の IR の語彙を越える entry（float の段 — gatelib の beyond_stage1）は照合しない（件数は skip に出る）
    if beyond_stage1 "$w/p.ir"; then echo "@@ skip"; return; fi
    "$STAGE1" build "$w/p.ir" -o "$w/exe" 2> "$w/err" || { echo "FAIL: $e: the passed IR is rejected: $(head -n 1 "$w/err")"; echo "@@ fail"; return; }
    timeout 10 "$w/exe" > "$w/run.out" 2> /dev/null < "$(stdin_of "${out%.out}")" || ec=$?
    [ -f "${out%.out}.exit" ] && want=$(cat "${out%.out}.exit")
    if ! cmp -s "$w/run.out" "$out" || [ "$ec" != "$want" ]; then
        echo "FAIL: $e: run output differs from $out (exit $ec, want $want)"
        echo "@@ fail"
        return
    fi
    echo "@@ ok"
}

par_init "$tmp"
while IFS= read -r e; do par_run one "$e"; done < <(scripts/irtext.sh --list)
par_wait > "$tmp/list"
grep -v '^@@ ' "$tmp/list" || true
ok=$(par_count ok "$tmp/list")
fail=$(par_count fail "$tmp/list")
echo "passes: $ok run, skip=$(par_count skip "$tmp/list") (no .out or beyond the stage1 IR vocabulary), fail=$fail"
[ "$fail" = 0 ]
