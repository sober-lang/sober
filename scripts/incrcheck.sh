#!/usr/bin/env bash
# check の関数単位キャッシュの stale の網（便 2 R2 — report-1263）: 1 つの温めた置き場（SOBER_CHECK_CACHE=1 — 切り口 D）に編集の列を「積み重ねて」当て、
# 各段の温の check の出力（判定 JSON・stderr・終了コード）がキャッシュなしの check とバイトで一致すること。
#   自己 check の鎖: base（冷）→ 編集を 1 つずつ積む（位置だけ・本体・署名・const・型・拒否の往復・拒否の位置の付け直し・ラムダの落ち・共有の
#     インスタンスの落ちと作り手の離脱）→ none（同じ木 — 全部当たり）。基準（off）は毎段 W8・本来のパス、温は (W ∈ {1, 8}) × (パス ∈ {本来の木,
#     長い別パスの写し}) の 4 組を段ごとに巡回する。検証モード（SOBER_CACHE_VERIFY=1 — 当たりも作り直してバイト比較・食い違いは stale で落ちる）は INCR_VFY の段・
#     扉の監査（=2）は INCR_AUD の段（既定 base — 冷で全 Def）
#     鎖の後ろに γ の段（便 2 R4 — bld = 置き場へ build して γ を書く・analyzer だけが拒否する編集・freeze の違反・依存の宣言・本体・省略可の関数型）
#   例題 + checkneg + tools + 自己: checkverdict の黄金と、置き場を全題材で 1 つにして冷 → 温（検証モード）→ 温（当たりをそのまま — 拒否の再生）→
#     gamma（題材ごとに置き場へ build してから check — analyzer が γ を読む）
# 出力 = 1 段 1 行（`incrcheck <段> W<w> <path> warm=same|DIFF miss=<外れ>/<全>`）。最後に `incrcheck: ok` か `incrcheck: FAIL n`
# 使い方: scripts/incrcheck.sh [--self | --ex] — 既定は両方。--self = 自己の鎖だけ（ゲート incrcheck_self）・--ex = 例題の 4 相だけ（ゲート incrcheck_ex —
# 2 ゲートに割って gates が並走させ、例題・testdata だけの編集では鎖が HIT する — report-1280）。変異の網（scripts/incrmut.sh の check 版）の口: INCR_COMPILER = 試すコンパイラ・INCR_EDITS = 鎖の編集の列・
# INCR_VFY = 検証モードの段・INCR_SELF_ONLY=1 で例題を外す
set -uo pipefail
MODE=both
case "${1:-}" in --self) MODE=self ;; --ex) MODE=ex ;; esac
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
C=${INCR_COMPILER:-$ROOT/out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
unset SOBER_SELF_KEY SOBER_CACHE_VERIFY SOBER_CHECK_CACHE SOBER_CACHE_STAT SOBER_VERIFY
# 答えの再生（丸ごとの当たり）は切る — この網は関数単位キャッシュの当否と再生を見る（再生の網は例題の default 相）
export SOBER_CHECK_REPLAY=0
export SOBER_BUILD_CACHE=0
ulimit -s unlimited
A=$W/a/compiler
B=$W/alt/a/much/longer/path/than/before/compiler
mkdir -p "$W/a" "$(dirname "$B")"
cp -r src/compiler "$A"
cp -r src/std "$A/std"
cp -r "$A" "$B"
CC=$W/cc
bad=0
# 編集（$1 = 編集・$2 = 木の compiler/）。編集は積み重なる
L=lower/lower.sober
edit() {
    local T=$2
    case "$1" in
        base|none) ;;
        shift) sed -i '1i // shift\n// shift\n' "$T/$L" "$T/ast/ast.sober" ;;
        body) sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$T/$L" ;;
        ast-body) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[1 + l + i]|' "$T/ast/ast.sober" ;;
        sig) sed -i 's|^func ListLen(t Tree, l int) int {$|func ListLen(t Tree, n int) int {|; /^func ListLen/{n;s|    return t.data\[l\]|    return t.data[n]|}' "$T/ast/ast.sober" ;;
        const) sed -i 's|^const PD_CHUNK = 60000$|const PD_CHUNK = 60001|' "$T/checker/e2s.sober" ;;
        type) sed -i 's|^type DefRng struct {$|type DefRng struct {\n    pad int|' "$T/desugar/core_out.sober" ;;
        # 拒否の往復: 型の誤り → その上に行を足す（落ちの位置の付け直し）→ 直す → 同じ誤りをもう一度（拒否の値の当たり）
        rej) sed -i '0,/^    _ = 0$/s//    _ = 0 + "a"/' "$T/$L" ;;
        rej-shift) sed -i '0,/^    _ = 0 + "a"$/s//    \/\/ 上に行\n\n    _ = 0 + "a"/' "$T/$L" ;;
        # 落ちた項目の前に字句を足す（コメントだけの行は字句の番号を動かさない — 項目の頭からの相対の付け直しを試すには字句が要る）
        rej-pad) sed -i '0,/^func /s//func incrPad() int {\n    return 1\n}\n\nfunc /' "$T/$L" ;;
        fix) sed -i 's|^    _ = 0 + "a"$|    _ = 0|' "$T/$L" ;;
        rej2) sed -i '0,/^    _ = 0$/s//    _ = 0 + "a"/' "$T/$L" ;;
        fix2) sed -i 's|^    _ = 0 + "a"$|    _ = 0|' "$T/$L" ;;
        # ラムダ（持ち上げ）の中の落ち
        lam) printf '\nfunc incrApply(f func(int) int, x int) int {\n    return f(x)\n}\n\nfunc incrLam(n int) int {\n    return incrApply((x int) => x + "a", n)\n}\n' >> "$T/$L" ;;
        lam-fix) sed -i 's|(x int) => x + "a"|(x int) => x + n|' "$T/$L" ;;
        # 共有のインスタンスの落ち: 使い手 2 つ → 作り手（最初の使い手）が使うのをやめる（当たりの使い手の値が落ちを運ぶか）→ 直す
        inst) printf '\nfunc incrGen[T](x T) int {\n    s := "${x}"\n    return len(bytes(s)) + "a"\n}\n\nfunc incrUse1(n int) int {\n    return incrGen(n)\n}\n\nfunc incrUse2(n int) int {\n    return incrGen(n) + 1\n}\n' >> "$T/$L" ;;
        inst-drop) sed -i '/^func incrUse1/{n;s|    return incrGen(n)|    return n|}' "$T/$L" ;;
        inst-fix) sed -i 's|    return len(bytes(s)) + "a"|    return len(bytes(s))|' "$T/$L" ;;
        # 上げた（mut の Def の）ジェネリックのインスタンスの落ち（本体の辺 ④ が張られない形 — 鍵の閉包のジェネリックの本体の辺 ② だけが運ぶ）
        inst2) printf '\nfunc incrGenM[T](xs mut []T, x T) int {\n    xs = append(xs, x)\n    s := "${x}"\n    return len(bytes(s)) + "a"\n}\n\nfunc incrUseM(n int) int {\n    mut xs := mut []int{}\n    return incrGenM(mut xs, n)\n}\n' >> "$T/$L" ;;
        inst2-fix) sed -i 's|    return len(bytes(s)) + "a"|    return len(bytes(s))|' "$T/$L" ;;
        # 展開される関数（mut 仮引数 2 つ — スカラーだけ）の本体の誤り: 落ちるのは展開した呼び手の Def（鍵の閉包の展開の本体の辺だけが運ぶ）
        exp) printf '\nfunc incrSwap(a mut int, b mut int) {\n    t := a\n    a = b\n    b = t\n}\n\nfunc incrUseSwap(n int) int {\n    mut x := n\n    mut y := 1\n    incrSwap(mut x, mut y)\n    return x + y\n}\n' >> "$T/$L" ;;
        exp-rej) sed -i '/^func incrSwap(a mut int, b mut int) {$/{n;s|    t := a|    t := a + "a"|}' "$T/$L" ;;
        exp-fix) sed -i 's|^    t := a + "a"$|    t := a|' "$T/$L" ;;
        # 呼び先の署名だけの編集で呼び手が落ちる（呼び先の本体は通る — 呼び手の鍵の参照の辺）
        callee) printf '\nfunc incrK(x int) int {\n    return x\n}\n\nfunc incrCall(n int) int {\n    return incrK(n) + 1\n}\n' >> "$T/$L" ;;
        callee-sig) sed -i '/^func incrK(x int) int {$/{s|int {$|bool {|;n;s|    return x|    return x == 0|}' "$T/$L" ;;
        callee-fix) sed -i '/^func incrK(x int) bool {$/{s|bool {$|int {|;n;s|    return x == 0|    return x|}' "$T/$L" ;;
        # 組み立ての const（const 拡張 — report-1270）: string / slice の const の中身の編集で、それを読む Def の判定が動く（鍵の const の辺）
        cstr) printf '\nconst IncrName = "abc"\n\nconst IncrTab = []int{1, 2}\n\nfunc incrName() int {\n    return len(bytes(IncrName)) + IncrTab[1]\n}\n' >> "$T/$L" ;;
        cstr-rej) sed -i 's|^const IncrName = "abc"$|const IncrName = true|' "$T/$L" ;;
        cstr-fix) sed -i 's|^const IncrName = true$|const IncrName = "abcd"|' "$T/$L" ;;
        cslice-rej) sed -i 's|^const IncrTab = \[\]int{1, 2}$|const IncrTab = []string{"a", "b"}|' "$T/$L" ;;
        cslice-fix) sed -i 's|^const IncrTab = \[\]string{"a", "b"}$|const IncrTab = []int{1, 3}|' "$T/$L" ;;
        # 脱糖の拒否の値と再生（便 2 R3 — report-1266）: 拒否 → 前に字句を足す（拒否の Def は当たり — 値から位置を付け直して再生）→ 直す
        dlen) printf '\nfunc incrDLen(s string) int {\n    return len(s)\n}\n' >> "$T/$L" ;;
        dlen-pad) sed -i '0,/^func /s//func incrPad2() int {\n    return 2\n}\n\nfunc /' "$T/$L" ;;
        dlen-fix) sed -i 's|^    return len(s)$|    return len(bytes(s))|' "$T/$L" ;;
        # 2 つ目の位置（NonExhaustive の missing — 型宣言の項目の中）
        dnex) printf '\ntype IncrU union {\n    IA {}\n    IB { n int }\n}\n\nfunc incrDNex(v IncrU) int {\n    mut r := 0\n    switch v {\n    case IB{n}: r = n\n    }\n    return r\n}\n' >> "$T/$L" ;;
        dnex-pad) sed -i '0,/^func /s//func incrPad3() int {\n    return 3\n}\n\nfunc /' "$T/$L" ;;
        dnex-fix) sed -i 's|^    case IB{n}: r = n$|    case IB{n}: r = n\n    case IA{}: r = 1|' "$T/$L" ;;
        # 共有のインスタンスの本体の拒否: 使い手 2 つ → 作り手（最初の使い手）が使うのをやめる（当たりの使い手の拒否の値が再生されるか）→ 直す
        dinst) printf '\nfunc incrDGen[T](x T) int {\n    s := "${x}"\n    return len(s)\n}\n\nfunc incrDU1(n int) int {\n    return incrDGen(n)\n}\n\nfunc incrDU2(n int) int {\n    return incrDGen(n) + 1\n}\n' >> "$T/$L" ;;
        dinst-drop) sed -i '/^func incrDU1/{n;s|    return incrDGen(n)|    return n|}' "$T/$L" ;;
        dinst-fix) sed -i '/^func incrDGen/,/^}/s|^    return len(s)$|    return len(bytes(s))|' "$T/$L" ;;
        # 全部の型付けの γ（便 2 R4 — check の analyzer が build の書いた区画を読む）: bld = 置き場へ build（γ を書く — 編集なし）・aerr = analyzer だけが
        # 拒否する（build は通る — γ の当たりの package でも指摘が出るか）・frz = freeze の違反（build も拒否 — 外れの package の規則を飛ばさないか）・
        # dep-decl = 依存の宣言の相を動かす（依存する package の鍵 K1）・listat-sem = 長さの同じ本体の編集（γ と parse の木の鍵）
        bld) ;;
        aerr) printf '\n@effects(!io)\nfunc IncrEff(x int) int {\n    println(x)\n    return x\n}\n' >> "$T/ast/ast.sober" ;;
        aerr-fix) sed -i 's|^@effects(!io)$|@effects(io)|' "$T/ast/ast.sober" ;;
        frz) printf '\nfunc incrFrz() int {\n    mut xs := mut []int{1, 2}\n    ys := freeze(xs)\n    xs[0] = 9\n    return ys[0]\n}\n' >> "$T/elf/elf.sober" ;;
        frz-fix) sed -i 's|^    xs\[0\] = 9$|    _ = xs[0]|' "$T/elf/elf.sober" ;;
        dep-decl) sed -i '0,/^func /s//func TyDepExtra(x int) int {\n    return x + 2\n}\n\nfunc /' "$T/ast/ast.sober" ;;
        listat-sem) sed -i 's|^    return t.data\[l + 1 + i\]$|    return t.data[l + 2 + i]|' "$T/ast/ast.sober" ;;
        # 省略可の匿名関数型の関数の定義 + 省略の呼び出し点 → 渡す呼び出し点（loader のソースは変わらず、脱糖後の木に F$z… が生える — 鍵 K1 のソースの要約）
        optfn-def) printf '\nfunc OptRun(n int, put (func(b []byte) error?)?) int {\n    return n\n}\n' >> "$T/loader/loader.sober"
            sed -i '/^func main() int {$/a\    a50, e50 := os.Args()\n    if e50 == nil \&\& len(a50) > 50 {\n        println(loader.OptRun(1))\n    }' "$T/app/main.sober" ;;
        optfn-site) sed -i '/^func main() int {$/a\    a51, e51 := os.Args()\n    if e51 == nil \&\& len(a51) > 51 {\n        println(loader.OptRun(2, put: (b []byte) => { nil }))\n    }' "$T/app/main.sober" ;;
        # 値の位置のラムダの関数が main から届く ↔ 届かない（capLive の印 — 親の PlanDefs が作って子へ渡す・report-1272）: reach = 定義 + main が呼ぶ
        # （扉の監査 =2 — 外れの Def の脱糖が全部の木の名前の解決を読まない）→ reach-drop = main の呼び出しだけを外す（検証 =1 — 当たりの値が届き方に依らない）
        reach) printf '\ntype IncrLess func(a int, b int) bool\n\ntype IncrOrd struct {\n    less IncrLess\n}\n\nfunc incrAsc() IncrOrd {\n    return IncrOrd{less: (a int, b int) => a < b}\n}\n\nfunc IncrAscUse() int {\n    o := incrAsc()\n    return if o.less(1, 2) { 1 } else { 0 }\n}\n' >> "$T/$L"
            sed -i '/^func main() int {$/a\    a52, e52 := os.Args()\n    if e52 == nil \&\& len(a52) > 52 {\n        println(lower.IncrAscUse())\n    }' "$T/app/main.sober" ;;
        reach-drop) sed -i '/^    a52, e52 := os.Args()$/,+3d' "$T/app/main.sober" ;;
        *) echo "incrcheck: unknown edit $1" >&2; exit 2 ;;
    esac
}
EDITS=${INCR_EDITS:-base shift body ast-body sig const type rej rej-shift rej-pad fix rej2 fix2 lam lam-fix inst inst-drop inst-fix inst2 inst2-fix exp exp-rej exp-fix callee callee-sig callee-fix cstr cstr-rej cstr-fix cslice-rej cslice-fix dlen dlen-pad dlen-fix dnex dnex-pad dnex-fix dinst dinst-drop dinst-fix bld aerr bld aerr-fix frz frz-fix bld dep-decl listat-sem optfn-def bld optfn-site reach reach-drop none}
[ "$MODE" = ex ] && EDITS=
VFY=" ${INCR_VFY:-sig rej2 listat-sem optfn-site reach reach-drop none} "
# 扉の監査（SOBER_CACHE_VERIFY=2 — 外れの Def の脱糖が読んだ項目 ∈ 鍵の届く集合・外は `cache: door outside` で落ちる）の段: 冷の base は全 Def が外れ
AUD=" ${INCR_AUD:-base reach} "
# runck <木> <出力> <env…>: check の stdout / stderr（当否の行を除く）/ 終了コード
runck() {
    local T=$1 o=$2 ec=0
    shift 2
    ( cd "$T" && env "$@" "$C" check app ) > "$o" 2> "$o.err" || ec=$?
    grep -v '^cache: check-' "$o.err" >> "$o"
    echo "exit=$ec" >> "$o"
}
# 段ごとの off（キャッシュなしの基準の check — W8・本来のパス）の先取り（incrcheck 高速化便 R1 — report-1280）: off は置き場を使わず段の木
# （base に edit を積んだ木）だけで決まるので、段の木の写しを先に作って全段の off を並列に走らせても比較の相手は同じバイト列（検出力は不変）。
# 温の鎖は従来どおり直列で、段 k の比較の前に off_k の完了を待つ。同時数 = INCR_PJ（既定 = JOBS・最低 2）
PJ=${INCR_PJ:-${JOBS:-4}}
[ "$PJ" -lt 2 ] && PJ=2
pre_off() {
    local P=$W/pre/compiler k=0 e
    mkdir -p "$W/pre" "$W/offs"
    cp -r src/compiler "$P"
    cp -r src/std "$P/std"
    for e in $EDITS; do
        edit "$e" "$P"
        while [ "$(jobs -rp | wc -l)" -ge "$PJ" ]; do wait -n || true; done
        rm -rf "$W/snap$k"
        mkdir -p "$W/snap$k"
        cp -r "$P" "$W/snap$k/compiler"
        ( runck "$W/snap$k/compiler" "$W/offs/$k" SOBER_WORKERS=8 SOBER_CHECK_CACHE=0; rm -rf "$W/snap$k"; touch "$W/offs/$k.done" ) &
        k=$((k + 1))
    done
    wait
}
if [ -n "$EDITS" ]; then
    pre_off &
fi
k=0
for e in $EDITS; do
    edit "$e" "$A"
    edit "$e" "$B"
    # bld: 置き場へ build（γ・parse の木を書く — 拒否の木なら書かない。結果は見ない）
    [ "$e" = bld ] && ( cd "$A" && SOBER_CACHE=$CC SOBER_BUILD_CACHE=1 SOBER_WORKERS=8 "$C" build app -o "$W/bld.elf" > /dev/null 2>&1 )
    while [ ! -e "$W/offs/$k.done" ]; do sleep 0.1; done
    cp "$W/offs/$k" "$W/off"
    w=$(( k % 2 == 0 ? 1 : 8 ))
    T=$A; pn=a
    [ $(( (k / 2) % 2 )) = 1 ] && T=$B && pn=alt
    v=0
    case "$VFY" in *" $e "*) v=1 ;; esac
    case "$AUD" in *" $e "*) v=2 ;; esac
    runck "$T" "$W/warm" SOBER_WORKERS=$w SOBER_CACHE=$CC SOBER_CHECK_CACHE=1 SOBER_CACHE_STAT=1 SOBER_CACHE_VERIFY=$v
    st=same
    cmp -s "$W/off" "$W/warm" || st=DIFF
    m=$(awk '/^cache: check-def / { split($3, a, "/"); printf "%d/%d", a[2] - a[1], a[2]; exit }' "$W/warm.err")
    g=$(awk '/^cache: check-gamma / { print " gamma=" $3; exit }' "$W/warm.err")
    echo "incrcheck $e W$w $pn vfy=$v warm=$st miss=${m:-?}$g $(head -c 50 "$W/off" | tr '\n' ' ')"
    if [ $st != same ] || [ -z "$m" ]; then
        bad=$((bad + 1))
        diff "$W/off" "$W/warm" | head -6
        grep -m3 'stale\|door outside\|readback' "$W/warm.err"
    fi
    k=$((k + 1))
done
if [ "${INCR_SELF_ONLY:-0}" != 1 ] && [ "$MODE" != self ]; then
    # cold = 冷で書く（扉の監査 =2 — 例題の全数で外れの Def の読み ∈ 鍵の届く集合・report-1271 / 1272）・warm = 検証 =1（当たりも作り直して比較）・replay = 当たりをそのまま使う（脱糖の拒否の値の再生 — R3）
    # gamma = 題材ごとに置き場へ build してから check（analyzer の全部の型付けが build の書いた γ を読む — 便 2 R4。build が通る負例〔analyzer
    # だけが拒否〕で当たりの package の指摘が出るか。検証 =1 の γ の照合は自己の鎖の listat-sem / optfn-site / none が見る）
    for ph in cold warm replay gamma; do
        v=0
        [ $ph = cold ] && v=2
        [ $ph = warm ] && v=1
        b=0
        [ $ph = gamma ] && b=1
        if CV_BUILD=$b SOBER_BUILD_CACHE=1 STAGE2=$C SOBER_CACHE=$W/cv SOBER_CHECK_CACHE=1 SOBER_CACHE_VERIFY=$v scripts/checkverdict.sh > "$W/cv.log" 2>&1; then
            echo "incrcheck examples $ph: $(tail -1 "$W/cv.log")"
        else
            bad=$((bad + 1))
            echo "incrcheck examples $ph: FAIL"
            grep -m5 '^FAIL' "$W/cv.log"
        fi
    done
    # default = 既定の道（SOBER_CHECK_CACHE も SOBER_CHECK_REPLAY も指定しない — 既定 on）: 抜き取りの題材を新しい置き場で冷 → 温。
    # 冷が置き場に書いたこと（既定で on）と、温（答えの再生が当たる）の判定が黄金と一致することを見る。関数単位キャッシュの全数の照合は上の相
    for ph in cold warm; do
        if env -u SOBER_CHECK_CACHE -u SOBER_CHECK_REPLAY CV_SAMPLE=eighth STAGE2=$C SOBER_CACHE=$W/cvd scripts/checkverdict.sh > "$W/cvd.log" 2>&1; then
            echo "incrcheck examples default-$ph: $(tail -1 "$W/cvd.log")"
        else
            bad=$((bad + 1))
            echo "incrcheck examples default-$ph: FAIL"
            grep -m5 '^FAIL' "$W/cvd.log"
        fi
        if [ $ph = cold ] && [ "$(find "$W/cvd" -type f 2> /dev/null | wc -l)" = 0 ]; then
            bad=$((bad + 1))
            echo "incrcheck examples default-cold: FAIL the check cache is not on by default (nothing written to SOBER_CACHE)"
        fi
    done
fi
if [ $bad = 0 ]; then
    echo "incrcheck: ok"
else
    echo "incrcheck: FAIL $bad"
    exit 1
fi
