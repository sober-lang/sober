#!/usr/bin/env bash
# リネーム道具の参照検索（R1 — 読むだけ。report-882 / 883）。道具の本体は src/compiler/tools/refs（loader / parser を in-process で使う）。
#
#   scripts/refs.sh <sym>             参照の一覧（TSV）を標準出力へ。<sym> = <pkg>.<Name>（トップレベル名）/ <pkg>.<型か variant>.<欄> /
#                                     <pkg>.<関数>(<仮引数>)。<pkg> は std のパス（std/task）かルート相対のディレクトリ（testdata/refs/neg/lib）。
#                                     欄は全 entry を表層型検査器に通して `x.欄` の基底の型を決める（typed — 数秒）・json に届く型の欄は WARN json-wire
#                                     1 部 = .sober の国勢調査（道具 — 綴りが一致する字句を全数 TARGET / OTHER / UNCLASSIFIED に振る。
#                                       コメント・文字列は TEXT・compiler/ の文字列リテラルは COMPILER-LIT・parser の合成の参照は SYNTH）
#                                     2 部 = .sober 以外の置き場（PLACE — 黄金 GOLDEN〔regen で作り直す〕/ 文書 DOCS〔候補 → 手〕/
#                                       履歴 HISTORY〔不変〕/ 凍結 FROZEN〔触らない〕/ lean LEAN〔候補〕/ その他 MISC〔候補〕）
#                                     終了コード: 0 = 書き換えの前提が揃う・2 = 未分類あり（書き換え不可）・3 = 合成の参照あり（コンパイラが名前を知る）
#   scripts/refs.sh --rename <sym> <new> [--dry-run]
#                                     TARGET の行の位置だけを書き換える（未分類・合成の参照があれば拒否）。書いた後に字句列の照合
#                                     （書き換えた位置以外の字句・コメント・空白が不変）と国勢調査（新名の対象数 = 書き換えた数・旧名 0）。
#                                     意味の照合は scripts/alphacheck.sh（V1〜V4）
#   scripts/refs.sh --chain <sym>     鎖の罠の判定（safe / compiler-known / chain — chain なら二相の手順を出す）。<sym> は上と同じか package のパス
#   scripts/refs.sh --pkgrename <old> <new> [--dry-run]
#                                     package の改名（import のパス・alias なしの参照名・package 節 + ディレクトリの移動）。compiler/ の import に当たれば拒否（chain）
#   scripts/refs.sh --entries         loadcheck の entry の一覧（<cwd>\t<entry> — cwd はルート相対）
#   scripts/refs.sh --loadcheck       各 entry を loader で読み、道具の import の参照名の表 ≡ loader の表を照合（道具の解決の網 —
#                                     import の表は国勢調査の 2 系統の共通の根なので、ここでしか捕まらない）
#   scripts/refs.sh --selftest        loadcheck + 負例（testdata/refs/neg — 同綴りの別物・testdata/refs/member — 欄 / 仮引数 / json 警告）の期待の TSV との一致 + 仮決め名 4 つの未分類 0
#
# コーパス = git の追跡下の .sober から bootstrap/ と src/stage1/ を除いたもの（凍結 — 2 部の FROZEN に数える）
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh

BIN=out/refs/refs
mkdir -p out/refs
# 道具は compiler の lexer / parser / ast / loader を読むので、どれかが新しければ建て直す（gates の $SELFHOST_BIN があればそれを写す）
if [ -n "${SELFHOST_BIN:-}" ] || [ ! -x "$BIN" ] || [ -n "$(find src/compiler/tools/refs src/compiler/lexer src/compiler/parser src/compiler/ast src/compiler/loader -newer "$BIN" -name '*.sober' -print -quit)" ]; then
    tool_bin refs "$PWD/$BIN" >&2 || { echo "refs.sh: FAIL build src/compiler/tools/refs" >&2; exit 1; }
fi

# コーパス = 作業木の .sober（追跡下 + 未追跡で ignore されないもの — package 改名の mv の後も新しいパスで見える）。凍結物は除く
corpus() { { git ls-files '*.sober'; git ls-files --others --exclude-standard '*.sober'; } | grep -v '^bootstrap/\|^src/stage1/' | sort -u | while read -r f; do [ -f "$f" ] && echo "$f"; done; }

entries() {
    # cwd = ルート: 追跡下で `func main` を持つ .sober 全部（単一ファイルの entry — 複数ファイルの main package の 1 本なら読めず LOADFAIL で害なし）・
    # loader 黄金の entry（複数ファイルの package）・テストの package（`test:<dir>` — _test.sober はテストのビルドでしか読まれない）
    corpus | grep -v '^src/compiler/' | while read -r f; do if grep -q '^func main' "$f"; then printf '.\t%s\n' "$f"; fi; done
    grep -v '^#' scripts/loaderjson.list | grep . | sed 's/^/.\t/'
    git ls-files '*_test.sober' | grep -v '^bootstrap/\|^src/stage1/\|^src/compiler/' | xargs -r -n1 dirname | sort -u | sed 's/^/.\ttest:/'
    # cwd = src/compiler: tools とテストの package（app/main は `@embed` が cwd の std/ を要る — typed_for が作業木で別に読む）
    for f in src/compiler/tools/*/main.sober; do printf 'src/compiler\t%s\n' "${f#src/compiler/}"; done
    git ls-files 'src/compiler/*_test.sober' | xargs -r -n1 dirname | sort -u | sed 's#^src/compiler/#src/compiler\ttest:#'
}

# 対象の類型（top / member / param）・字句で探す綴り・綴りを差し替えた対象
mode_of() { case "$1" in *')') echo param ;; *) local b=${1##*/}; b=${b#*.}; case "$b" in *.*) echo member ;; *) echo top ;; esac ;; esac; }
name_of() { case "$(mode_of "$1")" in param) local x=${1##*(}; echo "${x%)}" ;; *) echo "${1##*.}" ;; esac; }
with_name() { case "$(mode_of "$1")" in param) echo "${1%(*}($2)" ;; *) echo "${1%.*}.$2" ;; esac; }

# typed_for <綴り> <出力>: 全 entry を表層型検査器に通し、欄の selector の型の印と json に届く型を集める（欄の対象だけ要る）
typed_for() {
    : > "$2"
    local list cwd es std pre
    list=$(entries)
    for cwd in . src/compiler; do
        es=$(printf '%s\n' "$list" | awk -F'\t' -v c="$cwd" '$1 == c { print $2 }')
        std=$( [ "$cwd" = . ] && echo src/std || echo ../std )
        pre=$( [ "$cwd" = . ] && echo . || echo "$cwd/" )
        # shellcheck disable=SC2086
        (cd "$cwd" && "$OLDPWD/$BIN" typed "$std" "$pre" "$1" $es) >> "$2"
    done
    # compiler/app は `@embed("std/**")` が cwd の std/ を要る — stage2.sh と同じく compiler/* と std/ を並べた作業木で読む（パスは src/compiler/ 相対のまま）
    local ct
    ct=$(make_ctree)
    (cd "$ct" && "$OLDPWD/$BIN" typed "$OLDPWD/src/std" src/compiler/ "$1" app) >> "$2"
    rm -rf "$ct"
}

# make_ctree: compiler/* と std/ の写しを並べた作業木（stage2.sh の形 — symlink は @embed の走査が辿らないので写し）。パスを出す — 消すのは呼び手
make_ctree() {
    local ct
    ct=$(mktemp -d)
    cp -r src/compiler/. "$ct/"
    cp -r src/std "$ct/std"
    echo "$ct"
}

# norm_sym <sym>: package の部分が `/` を持たない短い形（`task.MarkFailed`・`task`）は、src/std/<先頭> が在りルート直下に同名のディレクトリが無ければ `std/` を補う。
# どちらにも無ければ空（呼び手が止める）。`/` を持つ形はそのまま
norm_sym() {
    local s=$1 head
    case "${s%%.*}" in */*) echo "$s"; return ;; esac
    head=${s%%.*}; head=${head%%(*}
    if [ -d "src/std/$head" ] && [ ! -d "$head" ]; then echo "std/$s"; elif [ -d "$head" ]; then echo "$s"; else echo ""; fi
}

# chain <sym>: 鎖の罠の判定（report-886）。stage2 は boot が建て、compiler/ の `std/…` の import は boot に焼き込まれた旧い std から読む
#   chain          = compiler/（stage2 の閉包 = app/main が読むファイル）が対象を参照する（package なら import する）— 新名は boot の std に無い → 二相
#   compiler-known = parser の合成の参照（SYNTH）か、package の文脈つきで名前と一致する compiler/ の文字列リテラル（EXACT pkg）— 同じコミットでリテラルも直す
#   safe           = どちらも無い（弱い候補 — 部分一致・連結・文脈なし — は一覧に出す。判定は手）
chain() {
    local sym mode pkg name T ct
    sym=$(norm_sym "$1")
    [ -n "$sym" ] || { echo "chain: $1 の package が見つからない（src/std/… にもルート直下にも無い — std の名前は std/… の形で）" >&2; return 1; }
    [ "$sym" = "$1" ] || echo "chain: $1 → $sym（std/ を補った）"
    T=$(mktemp -d)
    case "${sym##*/}" in *.*) mode=$(mode_of "$sym") ;; *) mode=package ;; esac
    if [ "$mode" = package ]; then pkg=$sym; name=$sym; else local pre=${sym%/*} base=${sym##*/}; [ "$pre" = "$sym" ] && pre= || pre=$pre/; pkg=$pre${base%%.*}; name=$(name_of "$sym"); fi
    echo "chain: $sym（類型 $mode・package $pkg・綴り $name）"
    # stage2 の閉包（app/main が読むファイル — 作業木で）
    ct=$(make_ctree)
    (cd "$ct" && "$OLDPWD/$BIN" files "$OLDPWD/src/std" app) | cut -f2 > "$T/closure"
    rm -rf "$ct"
    grep '^std/' "$T/closure" | xargs -r -n1 dirname | sort -u > "$T/stdpkgs"
    grep -v '^std/\|^\$' "$T/closure" | sed 's#^#src/compiler/#' | sort -u > "$T/cfiles"
    inclosure=0; grep -qx "$pkg" "$T/stdpkgs" && inclosure=1
    echo "  std の閉包: $(wc -l < "$T/stdpkgs") package（$pkg は$( [ $inclosure = 1 ] && echo '閉包の中' || echo '閉包の外')）・compiler/ のファイル $(wc -l < "$T/cfiles")"
    # 書き換えの計画（触るファイル）— compiler/ の閉包のファイルに当たれば chain
    if [ "$mode" = package ]; then
        corpus | "$BIN" pkgrename "$pkg" "${pkg%/*}/zz9refschain" --dry-run 2> /dev/null | grep -v '^POSTCHECK' | cut -f1 | sort -u > "$T/touched"
    else
        # 触るファイル = 国勢調査の TARGET の行（書き換えの計画は合成の参照や未分類で拒否されて空になる — 判定の道では拒否しない）
        { "$0" "$sym" 2> /dev/null || true; } | awk -F'\t' '$1 == "TARGET" { print $3 }' | sort -u > "$T/touched"
    fi
    comm -12 "$T/touched" "$T/cfiles" > "$T/cuse"
    # 合成の参照（parser の固定テンプレート — トップレベル名だけ）
    synth=0
    # 道具は合成の参照があると終了コード 3 — pipefail + set -e で判定の道が落ちないように
    if [ "$mode" = top ]; then synth=$({ corpus | "$BIN" refs "$sym" 2>&1 > /dev/null || true; } | sed -n 's/.* synth=\([0-9]*\).*/\1/p'); fi
    # compiler/ の閉包のファイルの文字列リテラル
    "$BIN" lits "$name" "$pkg" < "$T/cfiles" > "$T/lits"
    # 強い候補 = EXACT で package の文脈あり・または QUAL（文字列の中の `x.名前` — loader の合成コード・診断の文面 — report-895）
    strong=$(grep -c $'^LIT\tEXACT\tpkg\|^LIT\tQUAL' "$T/lits" || true)
    weak=$(( $(wc -l < "$T/lits") - strong ))
    echo "  compiler/ の使用（書き換えが閉包のファイルに当たる）: $(wc -l < "$T/cuse") ファイル"; sed 's/^/    /' "$T/cuse"
    echo "  parser の合成の参照（SYNTH）: ${synth:-0}"
    echo "  compiler/ の文字列リテラル: 強い候補（EXACT・package の文脈あり / QUAL — 文字列の中の x.名前）$strong・弱い候補（部分一致 / 連結 / 文脈なし — 手で確認）$weak"
    sed 's/^/    /' "$T/lits" | cut -c1-200
    # 凍結物の警告: 触るファイル ∩ scripts/frozen の一覧・std_frozen の同名 package
    sed -n 's#^\(compiler/\)#src/\1#p; /^examples\|^testdata\|^bench/p' scripts/frozen/*.list 2> /dev/null | grep -v '^#' | sort -u > "$T/frozen"
    comm -12 "$T/touched" "$T/frozen" > "$T/fz"
    sf=0; case "$pkg" in std/*) [ -d "src/stage1/std_frozen/${pkg#std/}" ] && sf=1 ;; esac
    if [ -s "$T/fz" ]; then
        echo "  凍結物の警告: 触るファイルのうち scripts/frozen の一覧の入力 $(wc -l < "$T/fz") 本$( [ $sf = 1 ] && echo "・src/stage1/std_frozen に同名の package（凍結した Zig の照合〔load / check / lower〕はこの package を旧名で読む — 一覧の入力が新名を使うと Zig 側だけ落ちる）")"
        while read -r f; do
            echo "    $f — $(grep -lx "${f#src/}\|$f" scripts/frozen/*.list | xargs -r -n1 basename | tr '\n' ' ')（lex / parse / fmt の一覧は字句と構文だけの照合で名前に無関係）"
        done < "$T/fz"
    fi
    if [ -s "$T/cuse" ]; then
        verdict=chain
    elif [ "${synth:-0}" -gt 0 ] || [ "$strong" -gt 0 ]; then
        verdict=compiler-known
    else
        verdict=safe
    fi
    echo "CHAIN-VERDICT: $verdict"
    case $verdict in
        chain) cat <<EOT
  二相の手順（compiler/ は boot が boot の std で建てる — 新名は鎖に段を足すまで compiler/ から使えない）:
    第 1 相（両受け）:
      a. std の $pkg に新名を足し旧名も残す（関数は旧名を新名への薄い包みに。package は新しいパスに写しを足して旧パスも残す。
         型・欄・variant は別名が無いので両立できない — 第 1 相の形は個別の設計が要る〔compiler/ の使用を一時的に外す等〕）
      b. compiler/ の文字列リテラル（強い候補 $strong 件・合成 ${synth:-0} 件）に新名を足して新旧の両方を受ける
      c. gates --full → コミット → 鎖に段を足す（bootstrap/<番号>-<コミット>/{compiler,std}・bootstrap/chain.txt・scripts/boot.commit — CLAUDE.md の手順）→ scripts/bootcheck.sh
    第 2 相（切り替え）:
      d. scripts/refs.sh --rename / --pkgrename で compiler/ を含む全部を新名へ → scripts/alphacheck.sh
      e. std の旧名（旧パス）と compiler/ のリテラルの旧名の受けを消す
      f. gates --full → コミット
EOT
        ;;
        compiler-known) echo "  手順: 同じコミットで compiler/ の文字列リテラル（強い候補）・合成のテンプレートも新名へ（scripts/refs.sh の書き換えは文字列を書かない — 手で）→ alphacheck → gates" ;;
        safe) echo "  手順: scripts/refs.sh --rename / --pkgrename → scripts/alphacheck.sh（弱い候補は手で確認）" ;;
    esac
    rm -rf "$T"
    case $verdict in safe) return 0 ;; compiler-known) return 3 ;; chain) return 6 ;; esac
}

loadcheck() {
    local rc=0 list
    list=$(entries)
    for cwd in . src/compiler; do
        local es
        es=$(printf '%s\n' "$list" | awk -F'\t' -v c="$cwd" '$1 == c { print $2 }')
        local std
        std=$(cd "$cwd" && realpath --relative-to=. "$OLDPWD/src/std")
        # shellcheck disable=SC2086
        (cd "$cwd" && "$OLDPWD/$BIN" loadcheck "$std" $es) || rc=1
    done
    return $rc
}

place() { # $1 = 名前: .sober 以外の追跡下のファイル（と凍結の .sober）での語の出現（分類は awk 1 本 — 短い名前は数万行になる）
    local name=$1
    local re="(?<![A-Za-z0-9_])${name}(?![A-Za-z0-9_])"
    { git grep -n --column -I -P "$re" -- . ':!*.sober' || true; git grep -n --column -I -P "$re" -- bootstrap src/stage1 || true; } |
    awk '{
        i = index($0, ":"); file = substr($0, 1, i - 1); r = substr($0, i + 1)
        i = index(r, ":"); line = substr(r, 1, i - 1); r = substr(r, i + 1)
        i = index(r, ":"); col = substr(r, 1, i - 1); r = substr(r, i + 1)
        sub(/^[ \t]+/, "", r)
        if (file ~ /^(bootstrap|src\/stage1|scripts\/frozen)\//) {
            # 凍結物は触らないので行は出さず、置き場（bootstrap の段・src/stage1・scripts/frozen）ごとの件数 1 行に畳む
            split(file, a, "/"); n[a[1] "/" a[2]]++; next
        }
        if (file ~ /^testdata\//) cls = "GOLDEN"
        else if (file ~ /^CHANGELOG/ || file ~ /\.local\.md$/ || file ~ /^\.pair\//) cls = "HISTORY"
        else if (file ~ /^docs\// || file ~ /^README/ || file ~ /^DESIGN/ || file ~ /\/README/) cls = "DOCS"
        else if (file ~ /^lean\//) cls = "LEAN"
        else cls = "MISC"
        printf "PLACE\t%s\t%s\t-\t-\t%s:%s\t%s\n", cls, file, line, col, substr(r, 1, 160)
    }
    END { for (k in n) printf "PLACE\tFROZEN\t%s\t-\t-\t-\t%d 件（凍結 — 触らない）\n", k, n[k] | "sort" }'
}

case "${1:-}" in
    --entries) entries ;;
    --rename)
        # scripts/refs.sh --rename <pkg>.<Name> <new> [--dry-run] — 書き換え（道具の終了コードをそのまま: 0 済 / 2 未分類 / 3 合成 / 4 拒否 / 5 検査が赤）
        [ $# -ge 3 ] || { sed -n '2,24p' "$0"; exit 1; }
        sym=$2 new=$3
        T=$(mktemp -d)
        trap 'rm -rf "$T"' EXIT
        targs=()
        if [ "$(mode_of "$sym")" = member ]; then typed_for "$(name_of "$sym")" "$T/typed"; targs=(--typed "$T/typed"); fi
        # 欄・仮引数の書く前の新名の別物の数（新名の型の印で数える — 道具の中では旧名の印しか無い）
        pn=
        if [ -z "${4:-}" ] && [ "$(mode_of "$sym")" != top ] && [ "${REFS_NOPOSTCHECK:-}" != 1 ]; then
            na0=()
            if [ "$(mode_of "$sym")" = member ]; then typed_for "$new" "$T/tn0"; na0=(--typed "$T/tn0"); fi
            pn=$(corpus | "$BIN" refs "$(with_name "$sym" "$new")" "${na0[@]}" 2>&1 > /dev/null | sed -n 's/.* other=\([0-9]*\).*/\1/p')
        fi
        rc=0
        corpus | "$BIN" rename "$sym" "$new" ${4:-} "${targs[@]}" 2> >(tee "$T/err" >&2) || rc=$?
        wait
        # 欄・仮引数の書いた後の国勢調査（道具の中では新名の型の印が作れない — ここで）: 新名の対象数 = 書き換えた数・旧名 0・未分類 0・別物の数が不変
        if [ $rc -eq 0 ] && [ -z "${4:-}" ] && [ "$(mode_of "$sym")" != top ] && [ "${REFS_NOPOSTCHECK:-}" != 1 ]; then
            pre=$(grep -o 'PRE target=[0-9]* other=[0-9]* newother=[0-9]*' "$T/err")
            pt=$(echo "$pre" | sed 's/.*PRE target=\([0-9]*\).*/\1/'); po=$(echo "$pre" | sed 's/.* other=\([0-9]*\).*/\1/')
            nsym=$(with_name "$sym" "$new")
            na=(); oa=()
            if [ "$(mode_of "$sym")" = member ]; then typed_for "$new" "$T/tn"; typed_for "$(name_of "$sym")" "$T/to"; na=(--typed "$T/tn"); oa=(--typed "$T/to"); fi
            sn=$(corpus | "$BIN" refs "$nsym" "${na[@]}" 2>&1 > /dev/null | grep -o 'target=[0-9]* decl=[0-9]* other=[0-9]* unclassified=[0-9]*')
            so=$(corpus | "$BIN" refs "$sym" "${oa[@]}" 2>&1 > /dev/null | grep -o 'target=[0-9]* decl=[0-9]* other=[0-9]* unclassified=[0-9]*')
            get() { echo "$1" | sed "s/.*$2=\([0-9]*\).*/\1/"; }
            if [ "$(get "$sn" target)" != "$pt" ] || [ "$(get "$so" target)" != 0 ] || [ "$(get "$sn" unclassified)" != 0 ] || [ "$(get "$so" unclassified)" != 0 ] || [ "$(get "$so" other)" != "$po" ] || [ "$(get "$sn" other)" != "$pn" ]; then
                echo "rename: 書いた後の国勢調査が合わない（新名 $sn / 期待 target=$pt other=$pn・旧名 $so / 期待 target=0 other=$po）" >&2
                rc=5
            else
                echo "rename: 書いた後の国勢調査 ok（新名 target=$pt・旧名 target=0・別物の数 不変）" >&2
            fi
        fi
        exit $rc ;;
    --loadcheck) loadcheck ;;
    --chain) [ $# -ge 2 ] || { sed -n '2,30p' "$0"; exit 1; }; chain "$2"; exit $? ;;
    --pkgrename)
        # scripts/refs.sh --pkgrename <old> <new> [--dry-run]（std のパス同士かルート相対のディレクトリ同士）: 字句の書き換え（道具）+ ディレクトリの移動（mv —
        # index は触らない: alphacheck の基準 = index）+ 書いた後の検査（loadcheck の不一致 0・読めない entry の数が不変・旧パスの import が 0）
        [ $# -ge 3 ] || { sed -n '2,30p' "$0"; exit 1; }
        old=$2 new=$3
        dir() { case "$1" in std/*) echo "src/$1" ;; *) echo "$1" ;; esac; }
        [ -d "$(dir "$old")" ] || { echo "pkgrename: $(dir "$old") が無い" >&2; exit 4; }
        [ ! -e "$(dir "$new")" ] || { echo "pkgrename: $(dir "$new") が既に在る" >&2; exit 4; }
        if [ -z "${4:-}" ] && [ "${REFS_ALLOW_CHAIN:-}" != 1 ]; then
            # stage2 の閉包のファイル（compiler/app が読むもの — tools は外）の import に当たる改名は chain（第 2 相でだけ — REFS_ALLOW_CHAIN=1）
            vd=$(chain "$old" 2>&1 | sed -n 's/^CHAIN-VERDICT: //p')
            if [ "$vd" = chain ]; then
                echo "pkgrename: stage2 の閉包の import に当たる — chain（scripts/refs.sh --chain $old で二相の手順。第 2 相なら REFS_ALLOW_CHAIN=1）" >&2; exit 6
            fi
        fi
        lf0=$(loadcheck 2>&1 | grep -c LOADFAIL || true)
        rc=0
        corpus | "$BIN" pkgrename "$old" "$new" ${4:-} || rc=$?
        [ $rc -eq 0 ] && [ -z "${4:-}" ] || exit $rc
        mkdir -p "$(dirname "$(dir "$new")")"
        mv "$(dir "$old")" "$(dir "$new")"
        # 中間の空ディレクトリ（std/internal/x → 戻す等）は消す
        rmdir -p "$(dirname "$(dir "$old")")" 2> /dev/null || true
        [ "${REFS_NOPOSTCHECK:-}" = 1 ] && exit 0
        lc=$(loadcheck 2>&1 || true)
        lf1=$(echo "$lc" | grep -c LOADFAIL || true)
        mm=$(echo "$lc" | grep -c '^MISMATCH\|^PKG' || true)
        left=$(corpus | xargs grep -l "\"$old\"" 2> /dev/null | grep -v '^bootstrap/\|^src/stage1/' || true)
        if [ "$mm" != 0 ] || [ "$lf1" != "$lf0" ] || [ -n "$left" ]; then
            echo "pkgrename: 書いた後の検査が赤（loadcheck の不一致 $mm・読めない entry $lf0 → $lf1・旧パスの import の残り: $(echo $left)）" >&2; exit 5
        fi
        echo "pkgrename: 書いた後の検査 ok（loadcheck の不一致 0・読めない entry $lf1 で不変・旧パスの import 0）" >&2
        exit 0 ;;
    --selftest)
        rc=0
        loadcheck > /dev/null || { echo "FAIL: refs loadcheck（scripts/refs.sh --loadcheck で一覧）"; rc=1; }
        for sym in std/task.MarkFailed testdata/refs/neg/lib.MarkFailed; do
            exp=testdata/refs/$(echo "$sym" | tr '/.' '__').tsv
            got=$(corpus | "$BIN" refs "$sym" 2> /dev/null | grep -v '^TEXT\|^COMPILER-LIT' | grep 'testdata/refs/neg/' || true)
            if [ "$got" != "$(cat "$exp")" ]; then
                echo "FAIL: refs $sym — 負例の振り分けが $exp と違う"; diff <(printf '%s\n' "$got") "$exp" | head -20; rc=1
            fi
        done
        # 欄・仮引数（R3）: 同綴りの欄の持ち主の別・json の wire 警告の有無・名前つき実引数の callee の別（testdata/refs/member）
        T=$(mktemp -d)
        trap 'rm -rf "$T"' EXIT
        typed_for code "$T/typed"
        for sym in testdata/refs/member/m.Req.code testdata/refs/member/m.Wire.code 'testdata/refs/member/m.Handle(scale)'; do
            exp=testdata/refs/$(echo "$sym" | tr '/.()' '____').tsv
            got=$(corpus | "$BIN" refs "$sym" --typed "$T/typed" 2> /dev/null | grep -av '^TEXT\|^COMPILER-LIT' | grep -a 'testdata/refs/member/\|^WARN' || true)
            if [ "$got" != "$(cat "$exp")" ]; then
                echo "FAIL: refs $sym — 欄・仮引数の振り分けが $exp と違う"; diff <(printf '%s\n' "$got") "$exp" | head -20; rc=1
            fi
        done
        for sym in std/task.MarkFailed std/os.SleepExpired std/sort.OrderUnstable std/http.ServeWith; do
            corpus | "$BIN" refs "$sym" > /dev/null 2>&1 || { echo "FAIL: refs $sym — 未分類か合成の参照がある"; rc=1; }
        done
        [ $rc -eq 0 ] && echo "refs selftest ok"
        exit $rc ;;
    ''|-*) sed -n '2,24p' "$0"; exit 1 ;;
    *)
        sym=$1
        rc=0
        T=$(mktemp -d)
        trap 'rm -rf "$T"' EXIT
        targs=()
        if [ "$(mode_of "$sym")" = member ]; then typed_for "$(name_of "$sym")" "$T/typed"; targs=(--typed "$T/typed"); fi
        corpus | "$BIN" refs "$sym" "${targs[@]}" || rc=$?
        place "$(name_of "$sym")"
        exit $rc ;;
esac
