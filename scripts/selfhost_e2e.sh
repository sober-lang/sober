#!/usr/bin/env bash
# selfhost の e2e 差分オラクル: Sober 版 `sober check` の直結（compiler/tools/sobercheck — lexer → parser → loader → desugar → checker を
# プロセス内でつなぐ。中間 JSON なし）の判定を、Zig 版 `sober check`（Zig の脱糖器 + Lean 製 sober-check）の判定と比べる。
#
#   scripts/selfhost_e2e.sh            全対象（下）。fail = 0 がゲート
#   scripts/selfhost_e2e.sh ENTRY...   指定の entry だけ（cwd = ルート）
#
# 対象: 第 3 黄金の全 entry（scripts/frozen/entries.list — 凍結、脱糖の拒否 10 本を含む）+ testdata/checkneg（Lean の拒否）+
#       testdata/loader_neg（load の拒否）+ compiler/tools/*（cwd = compiler/。sobercheck 自身を含む）
# 一致の条件:
#   - Zig が判定 JSON を出す（Lean まで届く）なら、sobercheck の出力とバイト一致（受理も拒否も — 型の印字まで）
#   - Zig が load / 脱糖で拒否する（判定 JSON が無い）なら、sobercheck も `sobercheck: load error` / `desugar error` で拒否
# 加えて、Lean まで届く entry では sobercheck の出力が checkdump（JSON 経由の Sober 版）の出力とバイト一致することも見る
# （直結の写し替え — checker/core.sober — が JSON の往復と同じ記録を作っていることの確認）。
# （旧 64MB スロットでは、コア AST が 8MB を超える entry — compiler/tools の大きい 3 本 — を checkdump が読めず、この照合だけ飛ばしていた。
#  region 予約の拡大 = で全 entry を照合する — checkdump の出力が空でも FAIL）
# 自己適用の到達点（上限で落ちる tool）は report に記録し、ここでは落ちたら FAIL にする（SELFHOST_E2E_SKIP で名前を外せる）。
# 前提: zig build 済み・lean で lake build 済み（$STAGE1 / $SOBER_CHECK で差し替え可）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
export SOBER_CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin sobercheck "$tmp/sobercheck" || { echo "FAIL: build src/compiler/tools/sobercheck"; exit 1; }
tool_bin checkdump "$tmp/checkdump" || { echo "FAIL: build src/compiler/tools/checkdump"; exit 1; }

manifest() {
    echo "$1"
    echo "$ROOT/src"
    { find . -name '*.sober' -type f -not -path './std/*' -not -path './.git/*' | sed 's|^\./||'; (cd "$ROOT/src" && find std -name '*.sober' -type f); } | LC_ALL=C sort
}

fail=0
acc=0
rej=0
fe=0
one() { # $1 = cwd, $2 = entry
    local w=${PAR_W:-$tmp}
    local dir=$1 e=$2
    (cd "$dir" && "$STAGE1" check "$e") > "$w/z.out" 2> "$w/z.err" || true
    (cd "$dir" && manifest "$e" > "$w/m.txt")
    local ec=0
    (cd "$dir" && timeout 120 "$tmp/sobercheck" < "$w/m.txt" > "$w/s.out" 2> "$w/s.err") || ec=$?
    if [ "$ec" != 0 ]; then
        echo "FAIL: $e: sobercheck crashed (exit $ec): $(head -c 200 "$w/s.err")"
        echo "@@ fail"
        return
    fi
    if neg_beyond_stage1 "$e"; then   # stage1 の外の拒否の規則の負例（gatelib）— Sober の load の拒否だけを見る
        if grep -q '^sobercheck: load error$' "$w/s.out"; then echo "@@ fe"; else echo "FAIL: $e: beyond-stage1 negative: sobercheck says $(head -c 120 "$w/s.out")"; echo "@@ fail"; fi
        return
    fi
    if ! grep -q '^{' "$w/z.out"; then
        # Zig は Lean に届く前に拒否した
        if grep -q '^sobercheck: \(load\|desugar\) error$' "$w/s.out"; then
            echo "@@ fe"
        else
            echo "FAIL: $e: Zig rejects ($(head -n 1 "$w/z.err")) but sobercheck says $(head -c 120 "$w/s.out")"
            echo "@@ fail"
        fi
        return
    fi
    if ! cmp -s "$w/z.out" "$w/s.out"; then
        echo "FAIL: $e: Zig $(head -c 120 "$w/z.out") / sobercheck $(head -c 120 "$w/s.out")"
        echo "@@ fail"
        return
    fi
    (cd "$dir" && "$STAGE1" check "$e" --core-json) > "$w/c.json"
    timeout 120 "$tmp/checkdump" < "$w/c.json" > "$w/d.out" 2> /dev/null || true
    if ! cmp -s "$w/d.out" "$w/s.out"; then
        echo "FAIL: $e: checkdump $(head -c 120 "$w/d.out") / sobercheck $(head -c 120 "$w/s.out")"
        echo "@@ fail"
        return
    fi
    if grep -q '"ok":true' "$w/s.out"; then echo "@@ acc"; else echo "@@ rej"; fi
}

# ── バッチ経路（全対象のとき）: Lean の起動を 1 回にまとめる。Zig 版 `sober check` の SOBER_CHECK をスタブに差し替えて、Zig が検査器へ渡す
# JSON をそのまま横取りし（analyzer / 脱糖で拒否すれば横取りは起きない）、あとで sober-check --batch に流す。判定の中身は 1 件ずつと同じ
# （sober check は検査器の stdout をそのまま中継する — src/stage1/main.zig の cmdCheck）。Zig の脱糖も 1 回で済む（--core-json を別に呼ばない）
STUB=$(lean_stub "$tmp")
mkdir -p "$tmp/e"
onea() { # 段 A（並列）: $1 = cwd, $2 = entry, $3 = 結果の置き場
    local dir=$1 e=$2 r=$3 ec=0
    mkdir -p "$r"
    echo "$e" > "$r/name"
    (cd "$dir" && LEANCAP=$r/c.json SOBER_CHECK=$STUB "$STAGE1" check "$e") > "$r/z.out" 2> "$r/z.err" || true
    (cd "$dir" && manifest "$e" > "$r/m.txt")
    (cd "$dir" && timeout 120 "$tmp/sobercheck" < "$r/m.txt" > "$r/s.out" 2> "$r/s.err") || ec=$?
    echo "$ec" > "$r/s.ec"
    if [ -s "$r/c.json" ]; then
        timeout 120 "$tmp/checkdump" < "$r/c.json" > "$r/d.out" 2> /dev/null || true
    fi
    echo "@@ a"
}
onec() { # 段 C: $1 = 結果の置き場（段 B の Lean の判定は $tmp/lean）
    local r=$1 e ec
    e=$(cat "$r/name")
    ec=$(cat "$r/s.ec")
    if [ "$ec" != 0 ]; then
        echo "FAIL: $e: sobercheck crashed (exit $ec): $(head -c 200 "$r/s.err")"; echo "@@ fail"; return
    fi
    if neg_beyond_stage1 "$e"; then   # stage1 の外の拒否の規則の負例（gatelib）— Sober の load の拒否だけを見る
        if grep -q '^sobercheck: load error$' "$r/s.out"; then echo "@@ fe"; else echo "FAIL: $e: beyond-stage1 negative: sobercheck says $(head -c 120 "$r/s.out")"; echo "@@ fail"; fi
        return
    fi
    if [ ! -f "$r/c.json" ]; then
        # Zig は Lean に届く前に拒否した
        if grep -q '^sobercheck: \(load\|desugar\) error$' "$r/s.out"; then
            echo "@@ fe"
        else
            echo "FAIL: $e: Zig rejects ($(head -n 1 "$r/z.err")) but sobercheck says $(head -c 120 "$r/s.out")"; echo "@@ fail"
        fi
        return
    fi
    lean_result "$r/c.json" "$tmp/lean" > "$r/l.out"
    if ! cmp -s "$r/l.out" "$r/s.out"; then
        echo "FAIL: $e: Zig $(head -c 120 "$r/l.out") / sobercheck $(head -c 120 "$r/s.out")"; echo "@@ fail"; return
    fi
    if ! cmp -s "$r/d.out" "$r/s.out"; then
        echo "FAIL: $e: checkdump $(head -c 120 "$r/d.out") / sobercheck $(head -c 120 "$r/s.out")"; echo "@@ fail"; return
    fi
    if grep -q '"ok":true' "$r/s.out"; then echo "@@ acc"; else echo "@@ rej"; fi
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    # 単体実行（entry 指定）: 従来経路（1 件ずつ Zig 版 sober check → Lean）
    for e in "$@"; do par_run one "$ROOT" "$e"; done
else
    ne=0
    a() { ne=$((ne + 1)); par_run onea "$1" "$2" "$tmp/e/$(printf '%04d' "$ne")"; }
    while IFS= read -r e; do check_retired "$e" && continue; a "$ROOT" "$e"; done < <(frozen_list entries)   # 凍結コーパス（主役交代 R39）— 退役分を除く（scripts/frozen/check-retired.list）
    for e in testdata/checkneg/*.sober; do a "$ROOT" "$e"; done
    for e in testdata/loader_neg/*/app; do a "$ROOT" "$e"; done
    bsrc=$(boot_src)   # compiler/tools の入力は起点の木（凍結の入力 — Zig 版が読める）
    for t in "$bsrc"/compiler/tools/*/; do
        t=$(basename "$t")
        check_retired "compiler/tools/$t" && continue   # S5 で退役（起点の木は旧い言語 — scripts/frozen/check-retired.list の末尾の節）
        case " ${SELFHOST_E2E_SKIP:-} " in *" $t "*) echo "skip: tools/$t"; continue;; esac
        a "$bsrc/compiler" "tools/$t/main.sober"
    done
    par_wait > /dev/null
    # 段 B: 横取りした JSON を Lean のバッチに流す
    find "$tmp/e" -name c.json -size +0 | LC_ALL=C sort > "$tmp/lean.list"
    lean_batch "$tmp/lean.list" "$tmp/lean"
    for r in "$tmp/e"/*; do par_run onec "$r"; done
fi
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
acc=$(par_count acc "$tmp/all"); rej=$(par_count rej "$tmp/all"); fe=$(par_count fe "$tmp/all"); fail=$(par_count fail "$tmp/all")
echo "selfhost_e2e: accepted=$acc, rejected-by-checker=$rej, rejected-before-checker=$fe, fail=$fail"
[ "$fail" = 0 ]
