#!/usr/bin/env bash
# stage2 の CLI（compiler/app — Sober 製の `sober`）の差分オラクル（selfhost の R35）。
#   1. build: 凍結コーパスの全 entry について `stage2 build <entry> --emit=ll -o <out>`と `--emit=ir` が、その場の Zig 版
#      `$STAGE1 build --emit=ll|ir` とバイト一致・exit 0（stage1 直呼び — 黄金は Sober 生成なので Zig ≡ Sober の相手にしない。Q1 裁定 2026-09-28）。
#      Zig 版が拒否する entry は stage2 が exit 1 か、受理（wider — Sober 版 lower が写していない拒否側の検査・未到達関数を下ろさない差 — docs/ir.md 1 節。数えて出す）
#   2. check: 同じ entry について `stage2 check <entry>` の stdout と exit code が Zig 版 `sober check`（Lean の判定）と一致
#      （Zig 版が Lean の前で拒否した — stdout が空の — ときは exit code だけを比べる。診断の文言は比べない）
#   3. 器: 使い方の誤り・読めない entry は exit 1、`-o` 無しは標準出力（F-20 — `>>` の追記先で前の出力を消さない）、ディレクトリ entry、
#      --emit の無い既定 = `--emit=elf --passes`（-o 無しは a.out）
# stage2 は $STAGE2（scripts/stages.sh が渡す）。無ければ scripts/stage2.sh の共有の stage2（古ければ作り直す — 約 40 秒）。
#
#   scripts/selfhost_cli.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
ZIG=${ZIG:-zig}
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT

if [ -z "${STAGE2:-}" ]; then
    STAGE2=$(STAGE1=$STAGE1 scripts/stage2.sh) || { echo "selfhost_cli: FAIL scripts/stage2.sh"; exit 1; }
fi

one() { # $1 = entry
    local w=${PAR_W:-$W} e=$1 k ec zec
    k=$(echo "${e%.sober}" | tr '/' '_')
    # build（.ll と IR）
    for kind in ll ir; do
        local flag=--emit=ll; [ "$kind" = ir ] && flag=--emit=ir
        "$STAGE2" build "$e" $flag -o "$w/out.$kind" > /dev/null 2> "$w/err"
        ec=$?
        if "$STAGE1" build "$e" --emit=$kind -o "$w/z.$kind" > /dev/null 2>&1; then
            if [ "$ec" != 0 ]; then echo "FAIL build[$kind] $e: exit $ec: $(head -c 200 "$w/err")"; echo "@@ fail"; return; fi
            if ! slot_eq "$w/z.$kind" "$w/out.$kind" 2> "$w/sm"; then echo "FAIL build[$kind] $e: differs from stage1 --emit=$kind: $(cat "$w/sm")"; echo "@@ fail"; return; fi
        elif [ "$ec" = 0 ]; then
            # 受理が Zig 版より広い（Sober 版 lower は拒否側の検査を全部は写していない — selfhost-drafts「(c) 第一段の総括」）
            [ "$kind" = ll ] && { echo "wider: $e"; echo "@@ wider"; }
        elif [ "$ec" != 1 ]; then
            echo "FAIL build[$kind] $e: Zig rejects but stage2 exit $ec"; echo "@@ fail"; return
        fi
    done
    # check（scripts/frozen/cli-check-retired.list の entry は退役 — 主の sober の analyzer が拒否するのが正しい意味論の差。理由はリストのコメント）
    if grep -qxF "$e" "$ROOT/scripts/frozen/cli-check-retired.list"; then echo "@@ ok"; return; fi
    "$STAGE1" check "$e" > "$w/zc" 2> /dev/null
    zec=$?
    "$STAGE2" check "$e" > "$w/sc" 2> /dev/null
    ec=$?
    if [ "$zec" != "$ec" ]; then echo "FAIL check $e: exit $ec (Zig $zec)"; echo "@@ fail"; return; fi
    if [ -s "$w/zc" ] && ! cmp -s "$w/zc" "$w/sc"; then echo "FAIL check $e: verdict differs"; echo "@@ fail"; return; fi
    echo "@@ ok"
}

par_init "$W"
n=0
while IFS= read -r e; do par_run one "$e"; n=$((n + 1)); done < <(frozen_lower entries)   # 凍結コーパス（主役交代 R39）— 退役分を除く（scripts/frozen/lower-retired.list）
par_wait > "$W/all"
grep -v '^@@ ' "$W/all" || true
ok=$(par_count ok "$W/all"); fail=$(par_count fail "$W/all"); wider=$(par_count wider "$W/all")

# 器
edge=0
expect_exit() { # $1 = 期待の exit、残り = 引数
    local want=$1; shift
    "$STAGE2" "$@" > /dev/null 2>&1
    local got=$?
    if [ "$got" != "$want" ]; then echo "FAIL edge: stage2 $* → exit $got (want $want)"; fail=$((fail + 1)); fi
    edge=$((edge + 1))
}
expect_exit 1
expect_exit 1 frobnicate
expect_exit 1 build
expect_exit 1 build examples/fib.sober -o
expect_exit 1 build examples/fib.sober examples/fib.sober
expect_exit 1 build no/such/file.sober
expect_exit 1 check
expect_exit 1 check no/such/file.sober
expect_exit 1 check testdata/checkneg/add_bool.sober
expect_exit 0 check examples/fib.sober
expect_exit 0 build testdata/minic/app --emit=ll -o "$W/minic.ll"
cmp -s "$W/minic.ll" testdata/lltext/testdata_minic_app.ll || { echo "FAIL edge: directory entry differs"; fail=$((fail + 1)); }
# 標準出力への書き出しは追記先を切り詰めない（WriteStdout — F-20）
echo "before" > "$W/app.txt"
"$STAGE2" build examples/fib.sober --emit=ll >> "$W/app.txt"
{ echo "before"; cat testdata/lltext/examples_fib.ll; } | cmp -s - "$W/app.txt" || { echo "FAIL edge: stdout append"; fail=$((fail + 1)); }
edge=$((edge + 2))
# --emit の無い既定 = bin/sober の既定と同じ ELF（--emit=elf --passes）・-o が無ければ a.out（2026-10-10 — Release の単体バイナリの入口）
mkdir -p "$W/defout"
S2ABS=$(realpath "$STAGE2")
if (cd "$W/defout" && "$S2ABS" build "$ROOT/examples/hello.sober" > "$W/defout.log" 2>&1) && [ -x "$W/defout/a.out" ] \
    && [ "$("$W/defout/a.out")" = "$(cat examples/hello.out)" ]; then :; else echo "FAIL edge: default build (a.out ELF)"; fail=$((fail + 1)); fi
"$STAGE2" build examples/hello.sober -o "$W/def.bin" > /dev/null 2>&1 && "$STAGE2" build examples/hello.sober --emit=elf --passes -o "$W/elf.bin" > /dev/null 2>&1 \
    && cmp -s "$W/def.bin" "$W/elf.bin" || { echo "FAIL edge: default build ≢ --emit=elf --passes"; fail=$((fail + 1)); }
"$STAGE2" build examples/hello.sober --no-opt -o "$W/defno.bin" > /dev/null 2>&1 && "$STAGE2" build examples/hello.sober --emit=elf --no-opt -o "$W/elfno.bin" > /dev/null 2>&1 \
    && cmp -s "$W/defno.bin" "$W/elfno.bin" || { echo "FAIL edge: default build --no-opt ≢ --emit=elf --no-opt"; fail=$((fail + 1)); }
edge=$((edge + 3))

echo "selfhost_cli: entries=$n ok=$ok (build wider than Zig: $wider), edge=$edge, fail=$fail"
[ "$fail" = 0 ]
