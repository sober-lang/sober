#!/usr/bin/env bash
# 番号の摂動の網（インクリ + 並列の波 段 2 — report-1188 案 T / report-1189）: 関数の機械語が発見順の番号（panic の点・spawn の点・
# ワーカーの表）に依らないこと。番号は札つきの定数（lower の iconstTag — OpConst の欄 b）と OpFsAddr / 罠の表の disp32 で運び、x86 が後埋め
# （種類 3 / 4 / 5）にする。判定 = `SOBER_NUMNOPATCH=1`（番号の後埋めを書かない — 欄は 0）で下駄 `SOBER_NUMOFF` = 0 / 1 / 1000 の ELF が
# バイト一致。割れたら = 後埋めを通らない出し口があるか、番号の値で形が変わるパスがある（GVN の併合 — report-1188 0. の 3 で実発）。
# 割れた entry は syms で関数を名指しする（下駄 0 と K の最初の食い違いの関数）。
# 母集団: 自己 build（compiler/ + std/ の木）+ bench の題材 + examples（既定は 4 本に 1 本 — 並びの添字 mod 4 = 0・`--every` で全数 — 約 10 分）
# 変異 3 つ（網が名指しすること）: m1 = spawn の札を落とす（par.sober の CT_SITE → 0）・m2 = 並列の移し（呼び出しの引数の組み立て — 札つきの定数の主な出し口）の後埋めを落とす（xParallelMove の xTagAt）・
# m3 = GVN の鍵から札（欄 b）を落とす — 変異のコンパイラは木を stage2 で build して作り、探りの列（下の PROBE）で回す。変異が探りを建てられない
# （段 6 R1 の規則順の付け直しが札の無い点の定数を InvariantBroken で止める — m1 はこちらで捕まる）のも検出に数える
# 使い方: scripts/numpert.sh [--every] [--no-mutants]
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
every=0
mutants=1
for a in "$@"; do
    case "$a" in
        --every) every=1 ;;
        --no-mutants) mutants=0 ;;
        *) echo "numpert: unknown argument $a" >&2; exit 2 ;;
    esac
done
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
entries=()
k=0
for f in $(ls examples/*.sober | grep -v '_neg'); do
    if [ "$every" = 1 ] || [ $((k % 4)) = 0 ]; then entries+=("$f"); fi
    k=$((k + 1))
done
for f in bench/*/main.sober; do entries+=("$f"); done
# 探り（変異の検出用 — report-1188 の摂動で番号の形が出た例 + spawn の多い例）
PROBE=(examples/opt_promote.sober examples/switch_nil.sober examples/task_map.sober examples/tour_07_parallel.sober examples/task_budget.sober bench/httparena/main.sober)
# 名指し: 下駄 0 と K の ELF の関数ごとの最初の食い違い
name_fn() { # $1 = cwd $2 = src $3 = コンパイラ $4 = K
    (cd "$1" && SOBER_NUMNOPATCH=1 "$3" build "$2" --emit=syms -o "$W/s0" > /dev/null 2>&1) || return
    node -e '
const fs = require("fs");
const [e0, e1, s0] = process.argv.slice(1);
const A = fs.readFileSync(e0), B = fs.readFileSync(e1);
const s = fs.readFileSync(s0, "utf8").trim().split("\n").map(l => { const [h, ...n] = l.split(" "); return { a: parseInt(h, 16) - 0x400000, n: n.join(" ") }; }).sort((x, y) => x.a - y.a);
let p = 0; while (p < A.length && p < B.length && A[p] === B[p]) p++;
let f = "?"; for (const x of s) if (x.a <= p) f = x.n;
console.log(f + " +" + p);' "$W/e0" "$W/e$4" "$W/s0"
}
# one <cwd> <src> <名前> <コンパイラ> — 0 = 一致・1 = 割れた・2 = 受理しない
one() {
    local K
    for K in 0 1 1000; do
        (cd "$1" && SOBER_NUMNOPATCH=1 SOBER_NUMOFF=$K SOBER_WORKERS=4 "$4" build "$2" --emit=elf --passes -o "$W/e$K") > "$W/err" 2>&1 || return 2
    done
    for K in 1 1000; do
        if ! cmp -s "$W/e0" "$W/e$K"; then
            echo "  $3: NUMOFF=$K ≢ 0 at $(name_fn "$1" "$2" "$4" "$K")"
            return 1
        fi
    done
    return 0
}
n=0
fail=0
for e in "${entries[@]}"; do
    one . "$e" "$e" "$S2"
    r=$?
    if [ $r = 1 ]; then echo "FAIL: $e — the machine code depends on the numbers"; fail=$((fail + 1)); fi
    [ $r = 2 ] || n=$((n + 1))
done
one "$W/tree" app src/compiler/app "$S2"
r=$?
[ $r = 1 ] && { echo "FAIL: self build — the machine code depends on the numbers"; fail=$((fail + 1)); }
[ $r = 2 ] && { echo "FAIL: self build did not build: $(head -c 200 "$W/err")"; fail=$((fail + 1)); }
n=$((n + 1))
nm=0
if [ "$mutants" = 1 ]; then
    # mutant <名前> <ファイル> <sed の式> <grep の形> — 変異のコンパイラで PROBE（+ 自己）を回して 1 本でも割れれば捕まえた
    mutant() {
        local name=$1 file=$2 expr=$3 pat=$4 caught=0 p
        rm -rf "$W/mt"; mkdir -p "$W/mt"; cp -r "$W/tree/." "$W/mt/"
        grep -q -- "$pat" "$W/mt/$file" || { echo "FAIL: mutant $name: the form was not found in $file"; fail=$((fail + 1)); return; }
        sed -i -- "$expr" "$W/mt/$file"
        cmp -s "$W/tree/$file" "$W/mt/$file" && { echo "FAIL: mutant $name: the edit did not apply to $file"; fail=$((fail + 1)); return; }
        (cd "$W/mt" && "$S2" build app --emit=elf --passes -o "$W/mc" > "$W/mlog" 2>&1) || { echo "FAIL: mutant $name build: $(head -c 200 "$W/mlog")"; fail=$((fail + 1)); return; }
        chmod +x "$W/mc"
        for p in "${PROBE[@]}"; do
            one . "$p" "$p" "$W/mc" > "$W/mout"
            r=$?
            if [ $r = 1 ]; then caught=1; echo "  mutant $name caught by $(cat "$W/mout" | sed 's/^  //')"; break; fi
            # 探りは基のコンパイラで建つ — 変異が建てられないのも検出（段 6 R1 の規則順の付け直し〔ruleord.sober の roPoints〕が札の無い点の定数を InvariantBroken で止める）
            if [ $r = 2 ]; then caught=1; echo "  mutant $name caught by $p: build failed — $(grep -m1 . "$W/err" | head -c 160)"; break; fi
        done
        if [ $caught = 0 ]; then
            one "$W/tree" app src/compiler/app "$W/mc" > "$W/mout"
            [ $? = 1 ] && { caught=1; echo "  mutant $name caught by $(cat "$W/mout" | sed 's/^  //')"; }
        fi
        [ $caught = 1 ] || { echo "FAIL: mutant $name was not caught"; fail=$((fail + 1)); }
        nm=$((nm + 1))
    }
    mutant m1-site-tag lower/par.sober 's/(siteIn + st.numOff) \* 4, CT_SITE)/(siteIn + st.numOff) * 4, 0)/; s/(if give { 1 } else { 0 }), CT_SITE)/(if give { 1 } else { 0 }), 0)/' 'CT_SITE)'
    mutant m2-move-fixup lower/x86.sober 's/^                xTagAt(mut e, mv, xMoveImm(mut c, e.mvD\[ready\], e.constV\[mv\]))$/                _ = xMoveImm(mut c, e.mvD[ready], e.constV[mv])/' 'xTagAt(mut e, mv, xMoveImm('
    mutant m3-gvn-tag lower/gvn.sober 's/^            mut b := irInsB(mut st, ins)$/            mut b := if op == OpConst { 0 } else { irInsB(mut st, ins) }/' '^            mut b := irInsB(mut st, ins)$'
fi
echo "numpert: $n entries × NUMOFF {0, 1, 1000} (number fixups unwritten) — ELF identical, $nm mutants, fail=$fail"
[ "$fail" = 0 ]
