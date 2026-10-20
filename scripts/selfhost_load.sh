#!/usr/bin/env bash
# selfhost の loader 差分オラクル: Sober 版（compiler/loader + compiler/tools/loaderdump）の出力を、Zig 版 `sober parse --loader-json` と
# バイト比較する（Zig 版の出力は loader 黄金 testdata/loaderjson/ で固定されている — scripts/loaderjson.sh）。
#
#   scripts/selfhost_load.sh            全対象: 黄金の entry（scripts/loaderjson.list）+ examples 全部 + マルチ package の testdata
#                                       + compiler/tools/*（cwd = compiler/）+ 負例（testdata/loader_neg — 両方が拒否すること）
#   scripts/selfhost_load.sh ENTRY...   指定の entry だけ（cwd = ルート）
#
# Zig 版が拒否する entry は、Sober 版も拒否すること（診断の文言は比べない — 座標と文言の照合は診断の段）。
# Sober 版の入力は Manifest（argv と readdir が無いための代役 — 仮決め R8-2 / R8-3）: entry・std の置き場・ファイル一覧を stdin で渡す。
# 前提: zig build 済み（$STAGE1 で差し替え可）。
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD

STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
[ -x "$STAGE1" ] || { echo "error: $STAGE1 not found (zig build)"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

tool_bin loaderdump "$tmp/loaderdump" || { echo "FAIL: build src/compiler/tools/loaderdump"; exit 1; }
CHECK=${SOBER_CHECK:-$ROOT/lean/.lake/build/bin/sober-check}
if [ -n "${SELFHOST_TOOLCHECKED:-}" ]; then
    echo "selfhost_load: tool check skipped (done by scripts/gates.sh toolcheck)"
elif [ -x "$CHECK" ]; then
    (cd src/compiler && SOBER_CHECK="$CHECK" "$ROOT/bin/sober" check tools/loaderdump/main.sober --lean > /dev/null) || { echo "FAIL: sober check src/compiler/tools/loaderdump"; exit 1; }
    echo "selfhost_load: sober check src/compiler/tools/loaderdump ok"
else
    echo "selfhost_load: sober-check not found — check skipped"
fi

# manifest ENTRY: cwd 相対のファイル一覧（std/ は予約 — ユーザーの std/ は読まない）+ std の置き場。
# std の置き場は凍結した写し src/stage1/std_frozen/（= Zig 版 stage1 が焼き込んだもの — build.zig）: **凍結コーパスの照合は両側とも凍結時点の入力**の原則
# （byte の段 S4 で std/ が stage1 の外の言語になった — 2026-10-01、決定 A。Sober 側に今の std/ を読ませると、std を import する entry の
# loader JSON が言語でなく入力の差で食い違う）。loader は言語の意味に依らないので、この照合は凍結後も生きる
STDROOT=$tmp/stdroot
mkdir -p "$STDROOT"
ln -s "$ROOT/src/stage1/std_frozen" "$STDROOT/std"
manifest() {
    echo "$1"
    echo "$STDROOT"
    { find . -name '*.sober' -type f -not -path './std/*' -not -path './.git/*' | sed 's|^\./||'; (cd "$STDROOT" && find -L std -name '*.sober' -type f); } | LC_ALL=C sort
}

fail=0
ok=0
rej=0
one() { # $1 = cwd, $2 = entry
    local w=${PAR_W:-$tmp}
    local dir=$1 e=$2 zo so
    zo=0
    (cd "$dir" && "$STAGE1" parse --loader-json "$e") > "$w/z.json" 2> "$w/zerr" || zo=1
    # 綴りの正規化（selfhost_parse.sh と同じ — `string(b)` の合成名 utf8.FromBytes → utf8.Parse、裁定 N1）
    sed -i 's/utf8\.FromBytes"/utf8.Parse"/g' "$w/z.json"
    (cd "$dir" && manifest "$e" > "$w/m.txt" && timeout 20 "$tmp/loaderdump" < "$w/m.txt") > "$w/s.json" 2> "$w/serr" || { echo "FAIL: $dir/$e: loaderdump crashed: $(head -n 2 "$w/serr")"; echo "@@ fail"; return; }
    so=0
    grep -q '^loaderdump: ' "$w/s.json" && so=1
    if neg_beyond_stage1 "$e"; then   # stage1 の外の拒否の規則の負例（gatelib）— Sober が拒否することだけを見る
        if [ "$so" = 1 ]; then echo "@@ rej"; else echo "FAIL: $dir/$e: Sober accepts a beyond-stage1 negative"; echo "@@ fail"; fi
        return
    fi
    if [ "$zo" = 1 ]; then
        if [ "$so" = 1 ]; then echo "@@ rej"; else echo "FAIL: $dir/$e: Zig rejects ($(head -n 1 "$w/zerr")) but Sober accepts"; echo "@@ fail"; fi
        return
    fi
    if [ "$so" = 1 ]; then
        echo "FAIL: $dir/$e: Sober rejects: $(head -n 1 "$w/s.json")"
        echo "@@ fail"
    elif ! cmp -s "$w/z.json" "$w/s.json"; then
        echo "FAIL: $dir/$e: differs"
        diff "$w/z.json" "$w/s.json" | head -n 12
        echo "@@ fail"
    else
        echo "@@ ok"
    fi
}

par_init "$tmp"
if [ $# -gt 0 ]; then
    for e in "$@"; do par_run one "$ROOT" "$e"; done
else
    while IFS= read -r e; do par_run one "$ROOT" "$e"; done < <(frozen_list load | grep -vxF -f <(grep -v '^#' scripts/frozen/load-retired.list | grep -v '^$'))   # 凍結コーパス（主役交代 R39）— 退役分を除く（scripts/frozen/load-retired.list）
    # compiler/tools の 4 本（起点の木の lexdump / parsedump / fmtdump / loaderdump）は 2026-10-20 に退役（補間の合成の import の行き先が
    # 凍結した std に無い — scripts/frozen/load-retired.list の同じ日の注）
    if [ -d testdata/loader_neg ]; then
        for e in testdata/loader_neg/*/app; do par_run one "$ROOT" "$e"; done
    fi
fi
par_wait > "$tmp/all"
grep -v '^@@ ' "$tmp/all" || true
ok=$(par_count ok "$tmp/all"); rej=$(par_count rej "$tmp/all"); fail=$(par_count fail "$tmp/all")
echo "selfhost_load: ok=$ok, both-rejected=$rej, fail=$fail"
[ "$fail" = 0 ]
