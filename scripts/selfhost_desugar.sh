#!/usr/bin/env bash
# **退役（2026-09-28、reaudit round 5 — F-17 案 2α）**: mut struct の束縛を欄ごとのセルに割ったので、Sober 版の脱糖器のコア AST は Zig 版と
# バイト一致しない（型も変わるので正規化でも戻せない）。gates.sh のゲート一覧から外した（凍結コーパスの規則 — 互換を壊した成分はゲートごと退役）。
# 脱糖器は第 3 黄金（Sober 生成）・Lean 照合（leanbatch / selfhost_check / selfhost_e2e）・固定点が見る。以下は記録として残す
# selfhost の脱糖器の差分オラクル: Sober 版（compiler/desugar + compiler/tools/desugardump）の出力を、Zig 版 `sober check --core-json` と
# バイト比較する（Zig 版の出力は第 3 黄金 testdata/corejson/ で固定されている — scripts/corejson.sh）。
#
#   scripts/selfhost_desugar.sh            全対象: 黄金の全 entry（scripts/frozen/entries.list — 凍結、拒否の 10 本を含む）+ compiler/tools/* の 7 本
#                                          （cwd = compiler/。desugardump 自身を含む）。fail = 0 がゲート
#   scripts/selfhost_desugar.sh ENTRY...   指定の entry だけ（cwd = ルート）
#
# 大きい 3 本（desugardump・checkdump・sobercheck — コア AST 9.6〜10.6MB）は、出力バッファ（1 バイト 1 語）が旧 64MB スロットを超えるので
# 外していた（selfhost-drafts F-17）。region 予約の拡大で解除
#
# Zig 版が拒否する entry は、Sober 版も拒否すること（診断の文言は比べない — 座標と文言の照合は診断の段）。
# Sober 版の入力は Manifest（loaderdump と同じ — 仮決め R8-2 / R8-3）。前提: zig build 済み（$STAGE1 で差し替え可）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin desugardump "$tmp/desugardump" || { echo "FAIL: build src/compiler/tools/desugardump"; exit 1; }
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
if [ -n "${SELFHOST_TOOLCHECKED:-}" ]; then
    echo "selfhost_desugar: tool check skipped (done by scripts/gates.sh toolcheck)"
elif [ "${SELFHOST_DESUGAR_NOCHECK:-}" = "" ] && [ -x "$CHECK" ]; then
    (cd src/compiler && SOBER_CHECK="$CHECK" "$ROOT/bin/sober" check tools/desugardump/main.sober --lean > /dev/null) || { echo "FAIL: sober check src/compiler/tools/desugardump"; exit 1; }
    echo "selfhost_desugar: sober check src/compiler/tools/desugardump ok"
fi

manifest() {
    echo "$1"
    echo "$ROOT/src"
    { find . -name '*.sober' -type f -not -path './std/*' -not -path './.git/*' | sed 's|^\./||'; (cd "$ROOT/src" && find std -name '*.sober' -type f); } | LC_ALL=C sort
}

fail=0
ok=0
rej=0
one() { # $1 = cwd, $2 = entry
    local w=${PAR_W:-$tmp}
    local dir=$1 e=$2 zo so
    zo=0
    (cd "$dir" && "$STAGE1" check "$e" --core-json) > "$w/z.json" 2> "$w/zerr" || zo=1
    (cd "$dir" && manifest "$e" > "$w/m.txt" && timeout 60 "$tmp/desugardump" < "$w/m.txt") > "$w/s.json" 2> "$w/serr" || { echo "FAIL: $e: desugardump crashed: $(head -c 300 "$w/serr")"; echo "@@ fail"; return; }
    so=0
    grep -q '^desugardump: ' "$w/s.json" && so=1
    if [ "$zo" = 1 ]; then
        if [ "$so" = 1 ]; then echo "@@ rej"; else echo "FAIL: $e: Zig rejects ($(head -n 1 "$w/zerr")) but Sober accepts"; echo "@@ fail"; fi
        return
    fi
    if [ "$so" = 1 ]; then
        echo "FAIL: $e: Sober rejects: $(head -n 1 "$w/s.json")"
        echo "@@ fail"
    elif ! cmp -s "$w/z.json" "$w/s.json"; then
        echo "FAIL: $e: differs"
        if command -v jq > /dev/null; then
            diff <(jq . "$w/z.json") <(jq . "$w/s.json" 2> /dev/null || cat "$w/s.json") | head -n 16 || true
        fi
        echo "@@ fail"
    else
        echo "@@ ok"
    fi
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    for e in "$@"; do par_run one "$ROOT" "$e"; done
else
    while IFS= read -r e; do par_run one "$ROOT" "$e"; done < <(frozen_list entries)   # 凍結コーパス（主役交代 R39）
    bsrc=$(boot_src)   # compiler/tools の入力は起点の木（凍結の入力 — 今の compiler/ は凍結後の言語で書かれうる）
    for t in lexdump parsedump fmtdump loaderdump desugardump checkdump sobercheck; do par_run one "$bsrc/compiler" "tools/$t/main.sober"; done
fi
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
ok=$(par_count ok "$tmp/all"); rej=$(par_count rej "$tmp/all"); fail=$(par_count fail "$tmp/all")
echo "selfhost_desugar: ok=$ok, both-rejected=$rej, fail=$fail"
[ "$fail" = 0 ]
