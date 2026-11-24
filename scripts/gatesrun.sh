#!/usr/bin/env bash
# 実行の記録（gitの共通ディレクトリの gates-runs.tsv — gates.sh が書く）の行を、別の機械の記録へ持ち運ぶ。
# 用途: リリースの組（gates.sh --release）をサーバーで回し、その ALL PASS の行を手元へ持ち込んで、手元の scripts/releaseok.sh に受けさせる
# （手元で回すと冷の全件で40〜60分。サーバーなら約17分）。
#   scripts/gatesrun.sh export [コミット（既定 HEAD）]   このコミットの clean・release・ALL PASS の最後の行を標準出力へ
#   scripts/gatesrun.sh import [ファイル（既定 標準入力）] 行を照合してから、この機械の記録へ足す
#   scripts/gatesrun.sh sel <コミット>                    そのコミットの scripts/ の gates.sh --release --list のハッシュ（記録の sel= の列と同じ計算）
# 例（手元で）: ssh <サーバー> 'cd ~/projects/sober && scripts/gatesrun.sh export <コミット>' | scripts/gatesrun.sh import && scripts/releaseok.sh <コミット>
# import の照合: 列の形（11〜12 列 — spot= の列は後から足されたので無い行もある）・clean・release・ALL PASS・行のコミットがこのリポジトリにある・sel= がそのコミットの gates.sh で計算したハッシュと一致する。
# 足す行は root= の列を「root=server:<元の木>」に替える（出所の印 — 手元で回した行と区別できる）。同じ行が既にあれば足さない。
# 記録の場所は gates.sh・releaseok.sh と同じ（GATES_RUNS で替えられる）。終了コード: 0 = OK・1 = 照合の失敗・行が無い・2 = 引数の誤り
set -u
cd "$(dirname "$0")/.."
runs=${GATES_RUNS:-$(git rev-parse --path-format=absolute --git-common-dir)/gates-runs.tsv}

# コミット rev の scripts/ を一時ディレクトリに展開して、そこで gates.sh --release --list を回す（作業木の状態と HEAD に依らない）
relsel() {
    local w h
    w=$(mktemp -d) || return 1
    git archive "$1" scripts | tar -x -C "$w" || { rm -rf "$w"; return 1; }
    h=$(cd "$w" && bash scripts/gates.sh --release --list 2> /dev/null | sha256sum | cut -c1-16)   # --release = そのコミットの gates.sh が知る名前（新しい木では --level 4 の旧名）
    rm -rf "$w"
    echo "$h"
}

case "${1:-}" in
sel)
    rev=$(git rev-parse --verify "${2:-}^{commit}" 2> /dev/null) || { echo "gatesrun: コミットが見つからない: ${2:-}" >&2; exit 2; }
    relsel "$rev"
    ;;
export)
    rev=$(git rev-parse --verify "${2:-HEAD}^{commit}" 2> /dev/null) || { echo "gatesrun: コミットが見つからない: ${2:-HEAD}" >&2; exit 2; }
    row=$([ -f "$runs" ] && awk -F'\t' -v r="$rev" '$2 == r && $3 == "clean" && ($4 == "lv=4" || $4 == "release") && $6 == "ALL PASS"' "$runs" | tail -n 1)
    [ -n "$row" ] || { echo "gatesrun: ${rev:0:12} のリリースの組の ALL PASS の行が無い（$runs）" >&2; exit 1; }
    printf '%s\n' "$row"
    ;;
import)
    src=${2:--}
    [ "$src" = - ] || [ -f "$src" ] || { echo "gatesrun: ファイルが無い: $src" >&2; exit 2; }
    n=0; bad=0; seen=0
    while IFS= read -r row; do
        [ -n "$row" ] || continue
        seen=$((seen + 1))
        # 列の切り分けは awk で（read の IFS にタブを置くと、空の列が詰まる）
        nf=$(awk -F'\t' '{ print NF }' <<< "$row")
        mapfile -t f < <(awk -F'\t' '{ for (i = 1; i <= NF; i++) print $i }' <<< "$row")
        rev=${f[1]:-}
        why=
        if [ "$nf" -ne 11 ] && [ "$nf" -ne 12 ]; then why="列の数が ${nf}（sel= と root= を持つ 11〜12 列の行だけを受ける）"
        elif [ "${f[2]}" != clean ] || [ "${f[3]}" != release ] || [ "${f[5]}" != "ALL PASS" ]; then why="clean・release・ALL PASS の行でない（${f[2]}・${f[3]}・${f[5]}）"
        elif ! git cat-file -e "$rev^{commit}" 2> /dev/null; then why="コミット ${rev:0:12} がこのリポジトリに無い（先に fetch する）"
        else
            want=$(relsel "$rev")
            [ "${f[7]}" = "sel=$want" ] || why="ゲートの列のハッシュが違う（行 ${f[7]}・${rev:0:12} の gates.sh では sel=$want）"
        fi
        if [ -n "$why" ]; then echo "gatesrun: 断った — $why" >&2; bad=1; continue; fi
        root=${f[10]#root=}
        [ "${root#server:}" = "$root" ] && f[10]="root=server:$root"
        out=$(IFS=$'\t'; echo "${f[*]}")
        if [ -f "$runs" ] && grep -qxF -- "$out" "$runs"; then echo "gatesrun: 既にある — ${rev:0:12}（${f[0]}）"; continue; fi
        printf '%s\n' "$out" >> "$runs"
        echo "gatesrun: 足した — ${rev:0:12} のリリースの組（${f[0]}・${f[9]}）→ $runs"
        n=$((n + 1))
    done < <(if [ "$src" = - ]; then cat; else cat "$src"; fi)
    [ "$seen" -gt 0 ] || { echo "gatesrun: 入力に行が無い" >&2; exit 1; }
    [ "$bad" = 0 ] || exit 1
    ;;
*)
    echo "使い方: scripts/gatesrun.sh export [コミット] | import [ファイル] | sel <コミット>" >&2
    exit 2
    ;;
esac
