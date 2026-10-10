#!/usr/bin/env bash
# selfhost の型検査器の差分オラクル: Sober 版（compiler/checker + compiler/tools/checkdump）の判定 JSON を、Lean 製 sober-check
# （lean/FeatherweightSober/Checker.lean の typecheck — 黄金オラクル）の stdout とバイト比較する。
#
#   scripts/selfhost_check.sh              全面: (i) 生成ベクタ (ii) 実コーパス (iii) 変異体 (iv) 負例のソース (v) 部分検査の封筒。fail = 0 がゲート
#   scripts/selfhost_check.sh --more N     加えて sober-gen の別シード（1..N、各 1000 本）も突き合わせる（gates --all = GATES_ALL=1 では常設で N = 2）
#   scripts/selfhost_check.sh --fast       (iii) の変異体を第 3 黄金の 4 本に 1 本だけに間引く（約 1/4 — 常備ゲートの短縮用）
#   scripts/selfhost_check.sh FILE.json... 指定のコア AST JSON だけ
#
# (i)   testdata/corevec.jsonl（seed 42・1000 本 — 型指向 + 近傍変異 + chaos）の各 "e" + testdata/corevec_byte/*.json・corevec_float/*.json・corevec_copyto/*.json・corevec_par/*.json（手書き — Gen が作らない op / 作りにくい reject）
# (ii)  第 3 黄金 testdata/corejson/*.json（71 本）+ compiler/tools/*（Sober 製コンパイラ自身のコア AST。cwd = compiler/）。
#       7 本全部（desugardump・checkdump・sobercheck はコア AST が 9.6〜10.6MB — 旧 64MB スロットでは 1 バイト 1 語の入力が溢れたので
#    外していた。region 予約の拡大 = で解除）。
#       この 3 本は直結の e2e（scripts/selfhost_e2e.sh — JSON を経ない）が検査する
# (iii) (ii) の第 3 黄金の各本に scripts/checkmut.ts の置換を 1 か所ずつ当てた変異体（多くは Lean が拒否する）
# (iv)  testdata/checkneg/*.sober（脱糖は通って Lean が拒否する型エラーの例）の --core-json
# (v)   部分検査の封筒（"parts":true）— 下の (v) の注
#
# 比べるのは stdout のバイト列。parse error だけは文言を比べない（Lean の Json.parse / fromJson の文言は写していない —
# 仮決め R11-2）。前提: zig build 済み・lean で lake build 済み（$SOBER / $STAGE1 / $SOBER_CHECK / $SOBER_GEN で差し替え可）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

SOBER=${SOBER:-$ROOT/bin/sober}        # 主の sober — (ii) の tools・(iv) の負例のコア JSON は Sober の脱糖器が作る（主役交代 R39）
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}   # (v) の iface / --pkg は Zig にしか無い
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
GEN=${SOBER_GEN:-$ROOT/lean/.lake/build/bin/sober-gen}
[ -x "$SOBER" ] || { echo "error: $SOBER not found (zig build)"; exit 1; }
[ -x "$CHECK" ] || { echo "error: $CHECK not found (cd lean && lake build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin checkdump "$tmp/checkdump" || { echo "FAIL: build src/compiler/tools/checkdump"; exit 1; }

# norm は判定 JSON の parse error の文言を落とす
norm() {
    sed -E 's/^\{"errors":\[\{"msg":"parse error.*$/{"errors":[{"msg":"parse error"}],"ok":false}/'
}

fail=0
acc=0
rej=0
one() { # $1 = コア AST JSON のファイル、$2 = 表示名
    local w=${PAR_W:-$tmp}
    lean_result "$1" "${LEANOUT:-}" | norm > "$w/l.out" || true
    local ec=0
    timeout 60 "$tmp/checkdump" < "$1" > "$w/s.raw" 2> "$w/s.err" || ec=$?
    if [ "$ec" != 0 ]; then
        echo "FAIL: $2: checkdump crashed (exit $ec): $(head -c 200 "$w/s.err")"
        echo "@@ fail"
        return
    fi
    norm < "$w/s.raw" > "$w/s.out"
    if ! cmp -s "$w/l.out" "$w/s.out"; then
        echo "FAIL: $2: Lean $(head -c 120 "$w/l.out") / Sober $(head -c 120 "$w/s.out")"
        echo "@@ fail"
    elif grep -q '"ok":true' "$w/l.out"; then
        echo "@@ acc"
    else
        echo "@@ rej"
    fi
}

section() { # $1 = 名前。直前の区切りからの集計を出す（並列の仕事を待って集める。fail は仕事の外で数えた分と足す）
    par_wait > "$tmp/all"
    grep -v '^@@ ' "$tmp/all" || true
    acc=$(par_count acc "$tmp/all"); rej=$(par_count rej "$tmp/all"); fail=$((fail + $(par_count fail "$tmp/all")))
    echo "selfhost_check: $1: accepted=$acc, rejected=$rej, fail=$fail"
    tot_fail=$((tot_fail + fail))
    fail=0; acc=0; rej=0
}
tot_fail=0
par_init "$tmp"

# prefetch は並列の組の前に、その組の入力を Lean のバッチに流しておく（one は結果を $LEANOUT から読む。単体実行 = ファイル指定のときは使わない）
LEANOUT=
prefetch() { # 引数 = 入力ファイル
    printf '%s\n' "$@" > "$tmp/pf.list"
    LEANOUT=$tmp/lean
    SOBER_CHECK=$CHECK lean_batch "$tmp/pf.list" "$LEANOUT"
}

# oneneg は負例: 判定が一致した上で Lean が拒否していること
oneneg() {
    local w=${PAR_W:-$tmp}
    one "$1" "$2"
    if grep -q '"ok":true' "$w/l.out"; then echo "FAIL: $2: Lean accepts it (not a negative example)"; echo "@@ fail"; fi
}

fast=0
if [ "${1:-}" = "--fast" ]; then fast=1; shift; fi
if [ $# -gt 0 ] && [ "$1" != "--more" ]; then
    for f in "$@"; do par_run one "$f" "$f"; done
    section "files"
    [ "$tot_fail" = 0 ]
    exit
fi

# (i) 生成ベクタ
vectors() { # $1 = jsonl、$2 = 接頭辞
    mkdir -p "$tmp/vec"
    python3 - "$1" "$tmp/vec/$2" <<'EOF'
import json, sys
for n, line in enumerate(open(sys.argv[1])):
    with open(f"{sys.argv[2]}.{n:04d}.json", "w") as f:
        f.write(json.dumps(json.loads(line)["e"], separators=(",", ":")))
EOF
    prefetch "$tmp/vec/$2".*.json
    for f in "$tmp/vec/$2".*.json; do par_run one "$f" "$2:$(basename "$f" .json | sed 's/.*\.//')"; done
}
vectors testdata/corevec.jsonl corevec
section "(i) corevec"
# (i'') 手書きのコア JSON（Gen が作らない op の点検 — byte の段: 型 byte・tobyte / toint。Examples.lean の exByte 系と同形。neg_* は Lean が拒否）
prefetch testdata/corevec_byte/*.json
for f in testdata/corevec_byte/*.json; do par_run one "$f" "$f"; done
section "(i'') corevec_byte"
# (i''') 手書きのコア JSON（float の段: 型 f64・flit / fadd… / feq… / fneg…。Examples.lean の exF 系と同形。neg_* は Lean が拒否）
prefetch testdata/corevec_float/*.json
for f in testdata/corevec_float/*.json; do par_run one "$f" "$f"; done
section "(i''') corevec_float"
# (i'''') 手書きのコア JSON（境界コピー式の段: copyto — 宛先構築レーン M3。Examples.lean の exLoopScope 系と同形。neg_* は Lean が拒否）
prefetch testdata/corevec_copyto/*.json
for f in testdata/corevec_copyto/*.json; do par_run one "$f" "$f"; done
section "(i'''') corevec_copyto"
# (i''''') 手書きのコア JSON（段 6 P2a: scope / spawn / join / try / newch・send / recv の端点。Gen の型指向の腕 task と同形 + 規則ごとに
# 1 か所だけ破る neg_*〔try の注釈・spawn の引数の givable・端点の向き・newch の cap / region〕— Gen の近傍変異が作りにくい reject の網）
prefetch testdata/corevec_par/*.json
for f in testdata/corevec_par/*.json; do par_run one "$f" "$f"; done
section "(i''''') corevec_par"
# (i') 追加シード（golden に焼かない乱択 — corevec v2）: --more N で seed 1..N × 1000 本。gates --all（GATES_ALL=1）では常設で seed 1..2（3 本で +90 s を計測 — +1 分の目安に合わせて 2）
more=0
if [ "${1:-}" = "--more" ]; then more=${2:-1}
elif [ "${GATES_ALL:-0}" = 1 ]; then more=2
fi
if [ "$more" -gt 0 ]; then
    [ -x "$GEN" ] || { echo "error: $GEN not found"; exit 1; }
    for s in $(seq 1 "$more"); do
        "$GEN" "$s" 1000 > "$tmp/gen$s.jsonl"
        vectors "$tmp/gen$s.jsonl" "seed$s"
    done
    section "(i') sober-gen seeds 1..$more × 1000"
fi

# (ii) 実コーパス
TOOLS="lexdump parsedump fmtdump loaderdump desugardump checkdump sobercheck"
mkdir -p "$tmp/tools"
for t in $TOOLS; do
    (cd src/compiler && "$SOBER" check "tools/$t/main.sober" --core-json > "$tmp/tools/$t.json" 2> /dev/null || rm -f "$tmp/tools/$t.json") &
done
wait
prefetch testdata/corejson/*.json "$tmp"/tools/*.json
for f in testdata/corejson/*.json; do par_run one "$f" "$f"; done
for t in $TOOLS; do
    [ -f "$tmp/tools/$t.json" ] || { echo "FAIL: --core-json src/compiler/tools/$t"; fail=$((fail + 1)); continue; }
    par_run one "$tmp/tools/$t.json" "src/compiler/tools/$t"
done
section "(ii) corpus"

# (iii) 変異体
mkdir -p "$tmp/mut"
if [ "$fast" = 1 ]; then
    mapfile -t mins < <(ls testdata/corejson/*.json | awk 'NR % 4 == 1')
else
    mins=(testdata/corejson/*.json)
fi
node scripts/checkmut.ts "$tmp/mut" "${mins[@]}" > /dev/null
prefetch "$tmp/mut"/*.json
for f in "$tmp/mut"/*.json; do par_run one "$f" "mutant:$(basename "$f" .json)"; done
section "(iii) mutants"

# (iv) 負例のソース
mkdir -p "$tmp/neg"
for s in testdata/checkneg/*.sober; do
    k=$(basename "$s" .sober)
    "$SOBER" check "$s" --core-json > "$tmp/neg/$k.json" 2> /dev/null || { echo "FAIL: $s: the desugarer rejects it (a negative example must reach the checker)"; fail=$((fail + 1)); rm -f "$tmp/neg/$k.json"; continue; }
done
prefetch "$tmp"/neg/*.json
for s in testdata/checkneg/*.sober; do
    k=$(basename "$s" .sober)
    [ -f "$tmp/neg/$k.json" ] && par_run oneneg "$tmp/neg/$k.json" "$s"
done
section "(iv) negative sources"

# (v) 部分検査の封筒（"parts":true — Split.lean の checkDefsAt）: pkgcheck と同じ対象・package で `sober check --pkg P --iface DIR` が
# sober-check へ渡す JSON を横取りする（SOBER_CHECK を tee の包みに差し替える）
mkdir -p "$tmp/parts"
# 横取りだけして Lean は起動しない（判定はあとでバッチに流す — Zig の中継した stdout は見ないので仮の判定を返す）
printf '#!/usr/bin/env bash\nf=$(mktemp -p %s XXXXXX.json)\ncat > "$f"\necho "{\\"pending\\":true}"\n' "$tmp/parts" > "$tmp/tee-check"
chmod +x "$tmp/tee-check"
# 凍結の入力（stage1 が読む — 書き換えた例は testdata/frozen_src の写し。std 命名規則のリネーム・S6 の文字リテラル化の後も同じ入力で続ける）
ptargets="testdata/pkgdemo/app testdata/errpkg/app testdata/iface/app testdata/frozen_src/testdata/minic/app testdata/frozen_src/testdata/minic_rd/app testdata/frozen_src/testdata/pool/nested.sober testdata/frozen_src/examples/errparse.sober testdata/frozen_src/examples/strings_std.sober"
partsgen() { # $1 = 対象。各 package の封筒を $tmp/parts へ横取りする
    local t=$1 D p
    D=$tmp/iface/$(echo "$t" | tr '/.' '__')
    "$STAGE1" iface "$t" -o "$D" > /dev/null 2>&1 || { echo "FAIL: sober iface $t"; echo "@@ fail"; return; }
    while read -r p; do
        SOBER_CHECK=$tmp/tee-check "$STAGE1" check "$t" --pkg "$p" --iface "$D" > /dev/null 2>&1 || true
    done < "$D/link.txt"
    echo "@@ gen"
}
for t in $ptargets; do par_run partsgen "$t"; done
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
fail=$((fail + $(par_count fail "$tmp/all")))
prefetch "$tmp/parts"/*.json
for f in "$tmp/parts"/*.json; do
    grep -q '"parts":true' "$f" || { echo "FAIL: $f: not a parts envelope"; fail=$((fail + 1)); continue; }
    par_run one "$f" "parts:$(basename "$f")"
done
section "(v) parts envelopes"

echo "selfhost_check: total fail=$tot_fail"
[ "$tot_fail" = 0 ]
