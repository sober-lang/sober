#!/usr/bin/env bash
# 後続ステージの関数キャッシュのstaleの検査（段階3 R3-b — report-1194 6 節2・report-1199 2 節・report-1201）: 1つの温めた配置先（SOBER_BUILD_CACHE=1）に
# 編集の列を「積み重ねて」当て、各ステージの温のbuildのELFがキャッシュなしのbuildのELFとバイトで一致すること。
#   自己buildのチェーン: base（冷）→ 編集を1つずつ積む（shift … fnval）→ none（同じ木のビルドし直し — ほぼ全部当たり）→ compiler-swap（出力の違う
#     コンパイラC' で同じ配置先 — 世代の鍵が分かれて全部外れ）。基準（off）は毎ステージW8・seed 0・本来のパスでビルドし、温は (W ∈ {1, 8}) ×
#     (SOBER_HASH_SEED ∈ {0, 7}) × (パス ∈ {本来の木 + 相対のentry, 長い別パスのコピー + 絶対パスのentry}) の8組をステージごとに巡回する（掛け算に
#     しない — 出力はW・seed・パスに依らないので、基準と組が違うこと自体も毎ステージ見ている）。検証モード（SOBER_CACHE_VERIFY=1 — staleを特定）は
#     途中の2ステージと最後の編集のステージ
#   progenのチェーン: ジェネレータ（fuzz/progen）のシード1〜Kのprogramを1つの配置先に順に当てる（題材をまたいだ当たり — 乱数の形の編集）
#   例題 + bench: 配置先を全題材で1つにしてoff（W8）/ 冷（W1）/ 温（W8）/ 検証（W1）（既定は例題4本に1本 — `--every` で全数）
# 出力 = 1ステージ1行（`incrbuild <段> W<w> s<seed> <path> warm=same|DIFF miss=α a/n β1 b/n β2 c/n γ d/n`）。外れの数は当否の記録（SOBER_CACHE_STAT=1）から
# 使い方: scripts/incrbuild.sh [--every] — 長い（全部で約 4 分）。背景で回して出力をファイルで読む
# ミューテーションの検査（scripts/incrmut.sh）のオプション: INCR_COMPILER = 試すコンパイラ・INCR_SRC = compiler-swapのC' の素の木（compiler/* + std — 既定src/）・
# INCR_EDITS = 自己のチェーンの編集の列（既定は下のEDITS）・INCR_VFY = 検証モードのステージ・INCR_SWAP=0でcompiler-swapを外す・INCR_SELF_ONLY=1でprogenと例題を外す
set -uo pipefail
# 答えの再生は切る（この検査は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
every=0
for a in "$@"; do
    case "$a" in
        --every) every=1 ;;
        *) echo "incrbuild: unknown argument $a" >&2; exit 2 ;;
    esac
done
scripts/stage2.sh --quiet || exit 1
C=${INCR_COMPILER:-$ROOT/out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# gatesのSOBER_VERIFY=each（ステージごとのIRの検証器）はキャッシュのパスに入らない — 検査はキャッシュのパスそのものを見るので外す
unset SOBER_SELF_KEY SOBER_CACHE_VERIFY SOBER_BUILD_CACHE SOBER_VERIFY
# 基準（off）のbuildは切のパス（キャッシュは既定on — 配置先のbuildはSOBER_BUILD_CACHE=1を明示する）
export SOBER_BUILD_CACHE=0
ulimit -s unlimited
A=$W/a/compiler
B=$W/alt/a/much/longer/path/than/before/compiler
mkdir -p "$W/a" "$(dirname "$B")"
cp -r src/compiler "$A"
cp -r src/std "$A/std"
cp -r "$A" "$B"
bad=0
# 例題 + bench の題材の列（既定は例題 4 本に 1 本 — --every で全数）
exlist() {
    local f j=0
    for f in examples/*.sober bench/*/main.sober; do
        case "$f" in
            examples/*) if [ "$every" = 0 ] && [ $((j % 4)) != 0 ]; then j=$((j + 1)); continue; fi; j=$((j + 1)) ;;
        esac
        echo "$f"
    done
}
# 当否の印字 → `miss=α a/n β1 b/n β2 c/n γ d/n P e/n`（a = 外れの数・γ = TypeAllのpackageの区画 — 段階5 R2・P = parseのファイル — 段階5 R4）
missof() {
    awk '/^cache: alpha / { split($3, a, "/"); split($5, b, "/"); split($7, c, "/"); split($9, d, "/"); split($11, e, "/"); printf "miss=α %d/%d β1 %d/%d β2 %d/%d γ %d/%d P %d/%d\n", a[2] - a[1], a[2], b[2] - b[1], b[2], c[2] - c[1], c[2], d[2] - d[1], d[2], e[2] - e[1], e[2]; exit }' "$1"
}
# 編集（$1 = 編集・$2 = 木の compiler/）。編集は積み重なる — 前の編集の後の木に当てる
edit() {
    local T=$2
    case "$1" in
        shift) sed -i '1i // shift\n// shift\n' "$T/lower/lower.sober" "$T/ast/ast.sober" ;;
        dead) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$T/lower/lower.sober" ;;
        listat-sem) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[l + 2 + i]|' "$T/ast/ast.sober" ;;
        xfixadd-sem) sed -i '/^func xFixAdd/,/^}/s|table.Push(mut fx, at)|table.Push(mut fx, at + 1)|' "$T/lower/x86.sober" ;;
        panic-add) sed -i '/^func main() int {$/a\    a20, e20 := os.Args()\n    if e20 == nil \&\& len(a20) > 20 \&\& 100 / (len(a20) - 21) == 1 {\n        return 3\n    }' "$T/app/main.sober" ;;
        # 子から呼ぶ再帰の関数finStepはpure-flipの前後でIRが変わらず、検査点のフラグ（純な子から届くか）だけが変わる — 鍵のcutInsertの2 bitを
        # 落としたミューテーション（incrmut m3）が古い成果物を当てる題材（題材のループは最適化で消えうるので、消えない再帰の入口に置く）
        lambda-add) sed -i '/^    rs, cerr := task.Map(finFiles(n), (f) => checksOne(cx, pp, ixs, pnames, f, die))$/a\    if n < 0 {\n        xs0, e0 := task.Map(finFiles(0), (f) => finStep(f))\n        if e0 != nil || len(xs0) > 99 {\n            return noHit(), false\n        }\n    }' "$T/loader/finpar.sober"
            printf '\nfunc finStep(n int) int {\n    if n <= 0 {\n        return 0\n    }\n    return n + finStep(n - 1)\n}\n' >> "$T/loader/finpar.sober" ;;
        # spawnの子（lambda-addの子）の純性が変わる: stdoutに書く子になる（cutPatchの旗・cutInsertのフラグ — β の鍵の2 bit）
        pure-flip) sed -i 's|^        xs0, e0 := task.Map(finFiles(0), (f) => finStep(f))$|        xs0, e0 := task.Map(finFiles(0), (f) => { println("p"); finStep(f) })|' "$T/loader/finpar.sober" ;;
        # 関数を値として渡す（番地を取られる関数 — xAddrのフラグが変わり、呼び手の呼び出し規約が変わる — β の鍵の番地取りのbit）
        addr-add) sed -i '0,/^    bv := lower.BcOpen(bd)$/s//    bv := lower.BcOpen(bd)\n    if cli.Bool(cl, Typer) \&\& cli.Bool(cl, TyperDiff) {\n        fv := parentOf\n        println(fv("a\/b"))\n    }/' "$T/app/cmd_build.sober" ;;
        fnval) sed -i '/^func main() int {$/a\    a40, e40 := os.Args()\n    if e40 == nil \&\& len(a40) > 40 {\n        la := strings.HasPrefix\n        println(la("ab", "a"))\n    }' "$T/app/main.sober" ;;
        # 組み立ての const（const 拡張 — report-1270）: package ast の公開の string / slice の const を main が引く → 中身の編集（ELF が変わる）
        cconst-add) printf '\nconst IncrName = "abc"\n\nconst IncrTab = []int{1, 2}\n' >> "$T/ast/ast.sober"
            sed -i '/^func main() int {$/a\    a60, e60 := os.Args()\n    if e60 == nil \&\& len(a60) > 60 {\n        println(ast.IncrName, ast.IncrTab[1])\n    }' "$T/app/main.sober" ;;
        cconst-edit) sed -i 's|^const IncrName = "abc"$|const IncrName = "abcd"|; s|^const IncrTab = \[\]int{1, 2}$|const IncrTab = []int{1, 2, 3}|' "$T/ast/ast.sober" ;;
        # 段階5 R3（γ の鍵の成分を1つずつ揺らす — report-1228 4.5）: 依存の宣言（astの頭に関数 — 宣言の相の記録の序数がずれ、依存するpackageの
        # 区画の値が変わる）
        dep-decl) sed -i '0,/^func /s//func TyDepExtra(x int) int {\n    return x + 2\n}\n\nfunc /' "$T/ast/ast.sober" ;;
        # 省略可の匿名関数型の関数（optfn）: 定義 + 省略の呼び出し点 → 渡す呼び出し点を足す（loader のソースは変わらず、脱糖後の木に F$z… が生える）
        optfn-def) printf '\nfunc OptRun(n int, put (func(b []byte) error?)?) int {\n    return n\n}\n' >> "$T/loader/loader.sober"
            sed -i '/^func main() int {$/a\    a50, e50 := os.Args()\n    if e50 == nil \&\& len(a50) > 50 {\n        println(loader.OptRun(1))\n    }' "$T/app/main.sober" ;;
        optfn-site) sed -i '/^func main() int {$/a\    a51, e51 := os.Args()\n    if e51 == nil \&\& len(a51) > 51 {\n        println(loader.OptRun(2, put: (b []byte) => { nil }))\n    }' "$T/app/main.sober" ;;
        # error 型の追加（errv の番号 — 全体の S 類）
        err-add) printf '\n// TyBenchErr は incrbuild の error 型の追加\ntype TyBenchErr error {\n    at Pos\n}\n' >> "$T/diag/diag.sober" ;;
        # 名前付き関数型の展開（Init の合成の節）: ast に型と受け手・main から名前付き関数を渡す
        nfn-add) printf '\ntype TyGen func(n int) int\n\ntype TyGenBox struct {\n    g TyGen\n}\n\nfunc TyGenRun(b TyGenBox) int {\n    return b.g(3)\n}\n' >> "$T/ast/ast.sober"
            printf '\nfunc tyDbl(n int) int {\n    return n * 2\n}\n' >> "$T/app/main.sober"
            sed -i '/^func main() int {$/a\    a52, e52 := os.Args()\n    if e52 == nil \&\& len(a52) > 52 {\n        println(ast.TyGenRun(ast.TyGenBox{g: tyDbl}))\n    }' "$T/app/main.sober" ;;
        # importの追加 / 削除（importの推移的な依存が変わる）
        import-add) sed -i 's|^import "std/builder"$|import "std/builder"\nimport "std/hex"|' "$T/elf/elf.sober"
            printf '\nfunc TyHex(b []byte) string {\n    return hex.Format(b)\n}\n' >> "$T/elf/elf.sober" ;;
        import-del) sed -i '/^import "std\/hex"$/d; /^func TyHex(b \[\]byte) string {$/,/^}$/d' "$T/elf/elf.sober" ;;
        none) ;;
    esac
}
# 拒否の編集（段階5 R3の γc — 積まない: コピーの木に当てて、キャッシュなしのbuildと温のbuildが同じ診断で拒否すること）
reject() {
    local T=$2
    case "$1" in
        # std/task の呼び出し点の形（ParCheck の kind 20 — budget: が呼び出しを含む）
        rej-par) printf '\nfunc tyRejPar(xs []int) int {\n    ys, e := task.Map(xs, (f) => f + 1, budget: len(xs))\n    if e != nil {\n        return 0\n    }\n    return len(ys)\n}\n' >> "$T/loader/finpar.sober" ;;
        # freeze の U1〜U3（凍らせた後の書き）
        rej-freeze) printf '\nfunc tyRejFreeze() int {\n    mut xs := mut []int{1, 2}\n    ys := freeze(xs)\n    xs[0] = 9\n    return ys[0]\n}\n' >> "$T/elf/elf.sober" ;;
    esac
}
read -r -a EDITS <<< "${INCR_EDITS-shift dead listat-sem xfixadd-sem panic-add lambda-add pure-flip addr-add fnval cconst-add cconst-edit dep-decl optfn-def optfn-site err-add nfn-add import-add import-del none}"
read -r -a REJECTS <<< "${INCR_REJECTS-rej-par rej-freeze}"
VFY=" ${INCR_VFY-listat-sem lambda-add fnval optfn-site nfn-add import-del} "
# base（冷）: 配置先は空から
k=0
combo() { # ステージ $1の温の組 → "w seed path"
    local i=$(($1 % 8))
    echo "$(( (i & 1) ? 8 : 1 )) $(( (i & 2) ? 7 : 0 )) $(( (i & 4) ? 1 : 0 ))"
}
ref() { # 基準（キャッシュなし・W8・seed 0・本来のパス）→ $W/off.elf。$1 = コンパイラ
    ( cd "$A" && SOBER_WORKERS=8 SOBER_HASH_SEED=0 "$1" build app --emit=elf --passes -o "$W/off.elf" > /dev/null 2> "$W/off.err" ) || { echo "incrbuild: FAIL off build ($2): $(head -c 300 "$W/off.err")"; exit 1; }
}
warm() { # $1 = ステージの名前・$2 = コンパイラ・$3 = ステージの番号・$4 = 検証モードか（1）
    local w s p dir src
    read -r w s p <<< "$(combo "$3")"
    if [ "$p" = 1 ]; then dir=$B; src=$B/app; else dir=$A; src=app; fi
    ( cd "$dir" && SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 SOBER_WORKERS=$w SOBER_HASH_SEED=$s "$2" build "$src" --emit=elf --passes -o "$W/warm.elf" > /dev/null 2> "$W/warm.err" )
    local ec=$? r=same
    cmp -s "$W/off.elf" "$W/warm.elf" || r=DIFF
    # 温の build が落ちた（読み戻しの誤りで lower が割れる等）は EXIT<コード>
    [ "$ec" != 0 ] && r=EXIT$ec
    # 当否の表示が無い = キャッシュのパスに入っていない（中身のない緑を塞ぐ — gatesのSOBER_VERIFY=eachで実発）
    [ "$ec" = 0 ] && ! grep -q '^cache: alpha ' "$W/warm.err" && { r=NOCACHE; ec=1; }
    echo "incrbuild $1 W$w s$s $(if [ "$p" = 1 ]; then echo alt-abs; else echo rel; fi) warm=$r $(missof "$W/warm.err")"
    if [ "$ec" != 0 ] || [ "$r" != same ]; then bad=1; grep -m3 . "$W/warm.err" | sed 's/^/  /'; fi
    if [ "$4" = 1 ]; then
        ( cd "$dir" && SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=1 SOBER_WORKERS=$w SOBER_HASH_SEED=$s "$2" build "$src" --emit=elf --passes -o "$W/vfy.elf" > /dev/null 2> "$W/vfy.err" )
        ec=$?
        local st r2=same
        st=$(grep -c 'stale entry' "$W/vfy.err")
        cmp -s "$W/off.elf" "$W/vfy.elf" || r2=DIFF
        echo "incrbuild $1 verify vfy=$r2 stale=$st"
        if [ "$ec" != 0 ] || [ "$r2" = DIFF ] || [ "$st" != 0 ]; then bad=1; grep -m5 . "$W/vfy.err" | sed 's/^/  /'; fi
    fi
}
main() {
# 題材だけのオプション（ミューテーションの検査 — INCR_ONLY_FILES = 例題の列: 配置先は題材で1つ・自己のチェーンとprogenを外す）
if [ -n "${INCR_ONLY_FILES:-}" ]; then
    n=0
    for f in $INCR_ONLY_FILES; do exone "$f"; done
    echo "incrbuild: files $n entries, fail=$bad"
    exit $bad
fi
# 基準の先取り（gatesの時間 — report-gt-0 A2）: 基準（off）のbuildはキャッシュを使わず、ステージの木だけで決まる。ステージごとの木のコピー（$W/pre/<ステージ>）に
# 編集を同じ順に積み、基準をINCR_PREJ本ずつ背景で先にビルドする（温のbuildは配置先を共有するので従来どおり直列）。チェーンのステージはコピーの木 ≡ $Aを
# diffで確認してから先取りのELFを使う。INCR_PREJの既定 = 2（ミューテーションの検査incrmut — INCR_COMPILERあり — は5本並列で回すので0 = 先取りしない）
PREJ=${INCR_PREJ:-$([ -n "${INCR_COMPILER:-}" ] && echo 0 || echo 2)}
prebuild() { # $1 = 名前（off-<ステージ>・x0-<題材>）・$2 = 木（cwd）・$3 = entry・$4 = 時間の上限（秒・0 = なし）・残り = 環境
    local nm=$1 dir=$2 src=$3 to=$4; shift 4
    ( cd "$dir" && env "$@" timeout "$to" "$C" build "$src" --emit=elf --passes -o "$W/pre/$nm.elf" > /dev/null 2> "$W/pre/$nm.err" )
    echo $? > "$W/pre/$nm.ec"
}
prefetch() { # 背景のまとめ役: 仕事の列（$W/pre/jobs — 1行 = prebuildの引数）をPREJ本ずつ
    local line
    while IFS= read -r line; do
        while [ "$(jobs -rp | wc -l)" -ge "$PREJ" ]; do wait -n || true; done
        eval "prebuild $line" &
    done < "$W/pre/jobs"
    wait
}
prewait() { # $1 = 名前: 先取りの終わりを待つ（.ec が出るまで）
    while [ ! -f "$W/pre/$1.ec" ]; do sleep 0.2; done
}
mkdir -p "$W/pre"
: > "$W/pre/jobs"
if [ "$PREJ" -gt 0 ] && [ -z "${INCR_ONLY_FILES:-}" ]; then
    cp -r "$A" "$W/pre/t0"
    echo "off-0 $W/pre/t0 app 0 SOBER_WORKERS=8 SOBER_HASH_SEED=0" >> "$W/pre/jobs"
    i=0
    for e in "${EDITS[@]}"; do
        i=$((i + 1))
        cp -r "$W/pre/t$((i - 1))" "$W/pre/t$i"
        edit "$e" "$W/pre/t$i"
        echo "off-$i $W/pre/t$i app 0 SOBER_WORKERS=8 SOBER_HASH_SEED=0" >> "$W/pre/jobs"
    done
    # 例題 + bench の基準（exone の x0 — W8・時間の上限 120 秒）も同じ列の後ろに
    if [ "${INCR_SELF_ONLY:-0}" != 1 ]; then
        j=0
        for f in $(exlist); do
            echo "x0-$(echo "$f" | tr '/.' '__') $ROOT $f 120 SOBER_WORKERS=8" >> "$W/pre/jobs"
        done
    fi
    prefetch &
fi
# ステージ $2の基準: 先取りがあればコピーの木 ≡ $Aを確認してそのELFを、無ければ従来どおりここでビルドする
refk() { # $1 = 名前（FAILの表示）・$2 = ステージの番号
    if [ "$PREJ" -gt 0 ] && [ -z "${INCR_ONLY_FILES:-}" ]; then
        diff -rq "$W/pre/t$2" "$A" > /dev/null || { echo "incrbuild: FAIL prefetch tree $2 differs from the chain's tree ($1)"; exit 1; }
        prewait "off-$2"
        [ "$(cat "$W/pre/off-$2.ec")" = 0 ] || { echo "incrbuild: FAIL off build ($1): $(head -c 300 "$W/pre/off-$2.err")"; exit 1; }
        cp "$W/pre/off-$2.elf" "$W/off.elf"
        rm -rf "$W/pre/t$2"
    else
        ref "$C" "$1"
    fi
}
refk base 0
warm base "$C" "$k" 0
for e in "${EDITS[@]}"; do
    k=$((k + 1))
    cp -r "$A" "$W/prev"
    edit "$e" "$A"
    edit "$e" "$B"
    if [ "$e" != none ] && diff -rq "$W/prev" "$A" > /dev/null; then echo "incrbuild: FAIL edit $e did not apply"; exit 1; fi
    rm -rf "$W/prev"
    refk "$e" "$k"
    case "$VFY" in *" $e "*) warm "$e" "$C" "$k" 1 ;; *) warm "$e" "$C" "$k" 0 ;; esac
done
# 拒否のステージ: 温めた配置先のまま、コピーの木に拒否の編集を1つずつ当てる（拒否のbuildは配置先へ書かない — 配置先は変わらない）
for e in "${REJECTS[@]}"; do
    rm -rf "$W/rj"
    cp -r "$A" "$W/rj"
    reject "$e" "$W/rj"
    if diff -rq "$A" "$W/rj" > /dev/null; then echo "incrbuild: FAIL reject $e did not apply"; bad=1; continue; fi
    ( cd "$W/rj" && SOBER_WORKERS=8 SOBER_HASH_SEED=0 "$C" build app --emit=elf --passes -o "$W/rj-off.elf" > /dev/null 2> "$W/rj-off.err" )
    eo=$?
    ( cd "$W/rj" && SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_STAT=1 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$C" build app --emit=elf --passes -o "$W/rj-warm.elf" > /dev/null 2> "$W/rj-warm.err" )
    ew=$?
    do1=$(grep -v '^cache: ' "$W/rj-off.err" | head -1)
    dw1=$(grep -v '^cache: ' "$W/rj-warm.err" | head -1)
    r=same
    [ "$do1" = "$dw1" ] || r=DIFF
    echo "incrbuild $e off=exit$eo warm=exit$ew diag=$r: $do1"
    if [ "$eo" = 0 ] || [ "$ew" = 0 ] || [ "$r" != same ]; then bad=1; echo "  warm: $dw1"; fi
done
rm -rf "$W/rj"
if [ "${INCR_SWAP:-1}" = 1 ]; then
# compiler-swap: 出力の違うコンパイラC'（ループの頭の整列32 → 16 — 関数の中の機械語が変わる）で同じ配置先を当てる。世代の鍵（コンパイラの鍵）が
# 分かれて全部外れること — 鍵が落ちていればCの値が当たってELFが割れる（ミュータント6）
k=$((k + 1))
mkdir -p "$W/cs"
if [ -n "${INCR_SRC:-}" ]; then
    cp -r "$INCR_SRC" "$W/cs/compiler"
else
    cp -r src/compiler "$W/cs/compiler"
    cp -r src/std "$W/cs/compiler/std"
fi
grep -q '^const XA_LOOP = 32$' "$W/cs/compiler/lower/x86.sober" || { echo "incrbuild: FAIL compiler-swap: XA_LOOP not found in lower/x86.sober"; exit 1; }
sed -i 's|^const XA_LOOP = 32$|const XA_LOOP = 16|' "$W/cs/compiler/lower/x86.sober"
( cd "$W/cs/compiler" && SOBER_WORKERS=8 "$C" build app --emit=elf --passes -o "$W/cswap" > /dev/null 2> "$W/cs.err" ) || { echo "incrbuild: FAIL building the swapped compiler: $(head -c 300 "$W/cs.err")"; exit 1; }
chmod +x "$W/cswap"
ref "$W/cswap" compiler-swap
cmp -s "$W/off.elf" "$W/warm.elf" && { echo "incrbuild: FAIL compiler-swap: the swapped compiler's output equals the original's (the swap must change code)"; bad=1; }
warm compiler-swap "$W/cswap" "$k" 1
fi
if [ "${INCR_SELF_ONLY:-0}" = 1 ]; then
    echo "incrbuild: self chain ${#EDITS[@]} edits, fail=$bad"
    exit $bad
fi
# progenのチェーン: シード1〜K（大きさ4）のprogramを1つの配置先へ順に
"$C" build fuzz/progen/main.sober --emit=elf --passes -o "$W/progen" > /dev/null 2>&1 || { echo "incrbuild: FAIL build progen"; exit 1; }
chmod +x "$W/progen"
K=$(if [ "$every" = 1 ]; then echo 16; else echo 6; fi)
pg=0
for s in $(seq 1 "$K"); do
    timeout 10 "$W/progen" "$s" 4 > "$W/p$s.sober" 2> /dev/null || { echo "incrbuild: FAIL progen seed $s did not generate"; bad=1; continue; }
    ( cd "$W" && SOBER_WORKERS=1 "$C" build "p$s.sober" --emit=elf --passes -o "$W/p-off.elf" > /dev/null 2>&1 ) || { echo "incrbuild: FAIL progen seed $s did not build without the cache"; bad=1; continue; }
    read -r w x _ <<< "$(combo "$s")"
    vm=$(( s == K ? 1 : 0 ))
    ( cd "$W" && SOBER_CACHE=$W/cp SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=$vm SOBER_WORKERS=$w SOBER_HASH_SEED=$x "$C" build "p$s.sober" --emit=elf --passes -o "$W/p-warm.elf" > /dev/null 2> "$W/p.err" )
    ec=$?
    if [ "$ec" != 0 ] || ! cmp -s "$W/p-off.elf" "$W/p-warm.elf"; then echo "incrbuild: FAIL progen seed $s (W$w s$x vfy=$vm): $(grep -m1 . "$W/p.err")"; bad=1; fi
    pg=$((pg + 1))
done
echo "incrbuild progen: $pg programs into one cache"
[ "$pg" = "$K" ] || bad=1
# 例題 + bench（配置先は全題材で1つ）
n=0
: > "$W/omitted"
exlist > "$W/tried"
for f in $(cat "$W/tried"); do
    exone "$f"
done
# 基準（キャッシュなし・W8）の build が失敗した題材（build が拒否する例など）は、失敗してよい一覧と照合する — 件数の減少に失敗が隠れない
omit_judge incrbuild scripts/omit/incrbuild.list "$W/tried" "$W/omitted" || bad=1
echo "incrbuild: self chain ${#EDITS[@]} edits + ${#REJECTS[@]} rejects + compiler-swap, progen $pg, $n entries, fail=$bad"
exit $bad
}
exone() { # 題材 $1 を off（W8）/ 冷（W1）/ 温（W8）/ 検証（W1）で
    local f=$1 nm
    nm=x0-$(echo "$f" | tr '/.' '__')
    if [ -f "$W/pre/jobs" ] && grep -q "^$nm " "$W/pre/jobs"; then
        prewait "$nm"
        [ "$(cat "$W/pre/$nm.ec")" = 0 ] || { echo "$f" >> "$W/omitted"; return 0; }
        mv "$W/pre/$nm.elf" "$W/x0.elf"
    else
        SOBER_WORKERS=8 timeout 120 "$C" build "$f" --emit=elf --passes -o "$W/x0.elf" > /dev/null 2>&1 || { echo "$f" >> "$W/omitted"; return 0; }
    fi
    n=$((n + 1))
    for m in "1 0 cold" "8 0 warm" "1 1 verify"; do
        read -r w vm nm <<< "$m"
        SOBER_CACHE=$W/cx SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=$vm SOBER_WORKERS=$w SOBER_HASH_SEED=$((n % 2 * 7)) timeout 300 "$C" build "$f" --emit=elf --passes -o "$W/x1.elf" > /dev/null 2> "$W/x.err"
        ec=$?
        if [ "$ec" != 0 ] || ! cmp -s "$W/x0.elf" "$W/x1.elf"; then echo "incrbuild: FAIL $f $nm: $(grep -m1 . "$W/x.err")"; bad=1; fi
    done
}
main "$@"
