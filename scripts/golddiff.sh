#!/usr/bin/env bash
# golddiff: テキストのゴールデン（irtext・lltext・corejson・astjson）の表に差が出たとき、変わった関数の全文の差分を出す。
#   scripts/golddiff.sh <基点のrev> [ir|ll|core|ast] [<題材>…]
# <題材> = 表のファイルの名前から拡張子を除いたもの（examples_fib・testdata_minic_app。ast はソースの相対パスから .sober を落としたもの — examples/fib）。省くと、基点と全文のハッシュ（表の1行目）が違う題材の全部。
# 種類を省くと ir・ll・core・ast の全部。
# 新の側 = 今の木の全文（scripts/<種類>.sh --gen が out/gold/<ir|ll>/ に作る）。
# 旧の側 = 基点の全文。基点のgitに全文がある（移行の前のコミット）ならそれを使う。無ければ基点のコンパイラで作る:
#   out/gold/base-wt に基点を `git worktree add --detach` し、その木の bin/sober で題材を生成する（生成のコマンドは種類のスクリプトの gold_emit と同じ）。生成した全文は out/gold/base/<コミット>/ に残し、次からは使い回す
# 出力 = 題材ごとに、表の行が変わった関数の名前と、その関数の全文の unified diff（scripts/goldtab.ts diff）。追加・削除の関数は名前と行数だけ
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
source scripts/gatelib.sh
gate_env
rev=${1:?usage: golddiff.sh <基点のrev> [ir|ll|core|ast] [<題材>…]}
shift
commit=$(git rev-parse --verify "$rev^{commit}") || { echo "golddiff: $rev はコミットでない"; exit 2; }
kinds=(ir ll core ast)
case "${1:-}" in ir|ll|core|ast) kinds=("$1"); shift ;; esac
want=("$@")
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
gate_of() { case "$1" in ir) echo irtext ;; ll) echo lltext ;; core) echo corejson ;; ast) echo astjson ;; esac; }
ext_of() { case "$1" in core|ast) echo json ;; *) echo "$1" ;; esac; }
emit() { # $1 = 種類、$2 = entry、$3 = 出力（cwd = 基点の木）
    case "$1" in core) ./bin/sober check "$2" --core-json > "$3" ;; ast) ./bin/sober parse --ast-json "$2" > "$3" ;; *) ./bin/sober build "$2" --emit="$1" -o "$3" ;; esac
}
BASEWT=$ROOT/out/gold/base-wt

base_full() { # $1 = 種類、$2 = 題材 → 旧の全文のパスを出す（作れなければ空）
    local kind=$1 k=$2 g d e x t
    g=$(gate_of "$kind")
    x=$(ext_of "$kind")
    if git cat-file -e "$commit:testdata/$g/$k.$x" 2> /dev/null; then
        t=$W/base.$(echo "$k" | tr '/' '_').$x
        git show "$commit:testdata/$g/$k.$x" > "$t"
        echo "$t"
        return 0
    fi
    d=$ROOT/out/gold/base/$commit/$kind
    if [ ! -f "$d/$k.$x" ]; then
        if [ ! -d "$BASEWT" ]; then
            git worktree add --detach "$BASEWT" "$commit" > /dev/null 2>&1 || { echo "golddiff: 基点の作業木を作れない" >&2; return 1; }
        fi
        git -C "$BASEWT" checkout -q --detach "$commit" || return 1
        if [ "$kind" = ast ]; then
            e=$k.sober
            [ -f "$BASEWT/$e" ] || e=""
        else
            e=$(cd "$BASEWT" && scripts/$g.sh --list | while read -r p; do y=$(echo "$p" | tr '/' '_'); [ "${y%.sober}" = "$k" ] && echo "$p"; done | head -n 1)
        fi
        [ -n "$e" ] || { echo "golddiff: 基点に題材 $k が無い" >&2; return 1; }
        mkdir -p "$(dirname "$d/$k")"
        (cd "$BASEWT" && emit "$kind" "$e" "$d/$k.$x.tmp" 2> "$W/base.err") \
            || { echo "golddiff: 基点で $e が生成できない: $(head -n 1 "$W/base.err")" >&2; rm -f "$d/$k.$x.tmp"; return 1; }
        mv "$d/$k.$x.tmp" "$d/$k.$x"
    fi
    echo "$d/$k.$x"
}

base_fullhash() { # $1 = 種類、$2 = 題材 → 基点の全文のハッシュ（表の1行目・移行の前なら全文から）。無ければ空
    local kind=$1 k=$2 g x
    g=$(gate_of "$kind")
    x=$(ext_of "$kind")
    if git cat-file -e "$commit:testdata/$g/$k.${kind}h" 2> /dev/null; then
        git show "$commit:testdata/$g/$k.${kind}h" | head -n 1 | cut -f2
    elif git cat-file -e "$commit:testdata/$g/$k.$x" 2> /dev/null; then
        git show "$commit:testdata/$g/$k.$x" | sha256sum | cut -c1-16
    fi
}

total=0
for kind in "${kinds[@]}"; do
    g=$(gate_of "$kind")
    x=$(ext_of "$kind")
    scripts/$g.sh --gen > "$W/gen.log" 2>&1 || { echo "golddiff: scripts/$g.sh --gen が落ちた"; cat "$W/gen.log"; exit 1; }
    gold_rlock "$kind"
    if [ ${#want[@]} -gt 0 ]; then
        ks=("${want[@]}")
    else
        ks=()
        while IFS= read -r f; do
            k=${f#out/gold/$kind/}; k=${k%.$x}
            [ "$(sha256sum < "$f" | cut -c1-16)" = "$(base_fullhash "$kind" "$k")" ] || ks+=("$k")
        done < <(find "out/gold/$kind" -name "*.$x" | LC_ALL=C sort)
        # 基点にだけある題材
        git ls-tree -r --name-only "$commit" "testdata/$g/" | sed -n -e "s|^testdata/$g/\(.*\)\.${kind}h\$|\1|p" -e "s|^testdata/$g/\(.*\)\.$x\$|\1|p" | sort -u | while read -r k; do
            [ -f "out/gold/$kind/$k.$x" ] || echo "== $kind $k: 基点にだけある"
        done
    fi
    for k in "${ks[@]}"; do
        new=out/gold/$kind/$k.$x
        if [ ! -f "$new" ]; then echo "== $kind $k: 今の木に全文が無い（除外か、題材が無い）"; continue; fi
        old=$(base_full "$kind" "$k") || old=""
        if [ -z "$old" ]; then echo "== $kind $k: 基点の全文が無い"; continue; fi
        echo "#### $kind $k"
        node scripts/goldtab.ts diff "$kind" "$old" "$new"
        total=$((total + 1))
    done
    exec 8>&-
done
echo "golddiff: $total 題材（基点 ${commit:0:12}）"
