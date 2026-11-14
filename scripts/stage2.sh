#!/usr/bin/env bash
# stage2（Sober で書いたコンパイラ — compiler/app）の唯一の作り手（主役交代 R38 / R39）。
#
#   scripts/stage2.sh            stage2が古ければ作り直し、配置先のパスを標準出力へ（新しければ何もしない — ハッシュ比較 約 0.01 秒）
#   scripts/stage2.sh --force    キャッシュを無視して作り直す
#   scripts/stage2.sh --quiet    パスを印字しない（bin/sober が呼ぶ形）
#
# ブートストラップチェーン（reaudit round 3 — 決定 (a)。reaudit ① で2ステージに延伸）: stage1 → boot₀（scripts/boot.commitの1行目の
# コミットのcompiler/ + std/ をstage1でビルドしたもの）→ boot₁（2行目のコミットをboot₀ で）→ … → stage2（最後のbootが今のcompiler/ を
# ビルドしたもの）。compiler/ はstage1の範囲でなく最後のbootの範囲の言語で書ける（凍結後の言語機能を使える）。
# 注意: boot は compiler/ 自身の `import "std/…"` を自分の焼き込み（そのコミットの std）から引く — compiler/ が使える std の関数も最後の起点の範囲。
# stage2 が利用者のプログラムに与える std は今の std/（@embed の素材）
#
# 配置先: out/stage2/（gitignore済み）
#   boot/sober-boot   boot₀ の ELF（キー = stage1 バイナリ + 1 行目のコミット。起点を上げるか stage1 が変わったときだけ作り直す — 約 38 秒）
#   boot/sober-boot-<i>  boot_i の ELF（i ≥ 1 — キー = 前段のキー + i 行目のコミット）
#   sober2      stage2 の ELF
#   stage2.ll   boot が吐いた stage2 の .ll（stages.sh の固定点の左辺・おまけの比較に使う）
#   L0          stdの各packageの .sobiを焼き込む2ステージのビルドの手順（l0_bake — 仮のstage2が書いた値を本番に @embed。3'' 第2ステージの1.5）
#   .key        入力の内容ハッシュ = compiler/ + std/ + boot バイナリ（gatelib の rel_key — 木のルートからの相対パス）。ずれたら作り直す
#  .stat    鮮度の入力のstat表の要約（高速パス — 一致なら内容ハッシュとブートストラップチェーンの確認を飛ばす。温ビルド回収）
# 作り直しは 約 4〜5 秒（最後の boot の正規バックエンドで ELF に — 2026-10-02 まで boot → .ll + zig cc -O0 で 5.6〜8.3 秒）。stderr に 1 行出す。
# 並行に呼ばれても 1 回だけ作る（flock）。置き換えは mv で原子的に（作りかけを他の呼び手に見せない）。
#
# ビルドの起点（仮決め R35-1）: compiler/ の package は compiler/ 相対で import し合い（ルート = cwd — 20 節）、std は `@embed("std/**/*.sober")`
# （ルート相対）で焼き込む。そこで作業ディレクトリにcompiler/* とリポジトリのstd/ のコピーを並べた木を組み、そこをcwdにしてbuildする。
set -uo pipefail
# ビルドの環境を固定する: 許可する変数だけを渡して自分を実行し直す。boot と stage2 の ELF は呼び手の環境（SOBER_VERIFY・SOBER_WORKERS・
# SOBER_CACHE などの開発用の変数）に依らない — 依ると、SOBER_VERIFY=each の下で古い boot が RegionExceeded で落ちた（2026-11-14）。
# 渡すもの = 道具の場所（PATH・ZIG・STAGE1）・zigのキャッシュ（HOME・XDG_CACHE_HOME・ZIG_*_CACHE_DIR）・一時の配置先（TMPDIR）・
# ビルドの入力（SOBER_O1 — キーに入る）・コピーの木のオプション（GATES_PREBUILT）
if [ "${SOBER_STAGE2_ENV:-}" != fixed ]; then
    keep=()
    for v in HOME PATH TMPDIR ZIG ZIG_GLOBAL_CACHE_DIR ZIG_LOCAL_CACHE_DIR XDG_CACHE_HOME STAGE1 SOBER_O1 GATES_PREBUILT; do [ -n "${!v+x}" ] && keep+=("$v=${!v}"); done
    exec env -i "${keep[@]}" SOBER_STAGE2_ENV=fixed bash "${BASH_SOURCE[0]}" "$@"
fi
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
source "$ROOT/scripts/gatelib.sh"

force=0
quiet=0
for a in "$@"; do
    case "$a" in
        --force) force=1 ;;
        --quiet) quiet=1 ;;
        *) echo "stage2.sh: unknown argument $a" >&2; exit 2 ;;
    esac
done
STAGE1=${STAGE1:-$ROOT/src/stage1/zig-out/bin/sober}
ZIG=${ZIG:-zig}
OUT=$ROOT/out/stage2
[ -x "$STAGE1" ] || { echo "stage2.sh: $STAGE1 not found (zig build)" >&2; exit 1; }
mkdir -p "$OUT"
# GATES_PREBUILT=1（成果物ごとコピーした木 — scripts/gatemut.shのM2）: 鮮度を検証せずに今のsober2を使う（コピーはパスが違って鮮度の確認が外れ、ブートストラップチェーンからの再ビルドになる）
if [ "${GATES_PREBUILT:-0}" = 1 ] && [ "$force" = 0 ] && [ -x "$OUT/sober2" ]; then
    [ "$quiet" = 1 ] || echo "$OUT/sober2"
    exit 0
fi

# ── 高速パス（鮮度確認を安く — 温ビルド回収の一手目）──
# 鮮度の入力の全部（stage1・ブートストラップチェーン = boot.commit・compiler/・std/・bootのELFと .key・sober2と .key）のstat表
# （パス・大きさ・更新時刻ns）が前回の確認時と一致なら、内容ハッシュ（約3 MBのsha256）とブートストラップチェーン44行 × 2本の
# git merge-base を丸ごと飛ばす（0.16〜0.31 s → 約 0.01 s）。編集も git も mtime を動かすので、内容が変われば
# 表が割れて下の内容ハッシュのパスに落ちる。表は下のパスの末尾（鮮度の確定後）にだけ書く
stat_key() {
    {
        find "$STAGE1" "$ROOT/bootstrap/chain.txt" "$ROOT/src/compiler" "$ROOT/src/std" -type f -printf '%p %s %T@\n' 2> /dev/null
        find "$OUT" -maxdepth 2 -type f \( -name 'sober-boot*' -o -name sober2 -o -name '.key*' \) -printf '%p %s %T@\n' 2> /dev/null
        echo "O1=${SOBER_O1:-}"
    } | LC_ALL=C sort | sha256sum | cut -d' ' -f1
}
STATF=$OUT/.stat
if [ "$force" = 0 ] && [ -x "$OUT/sober2" ] && [ -f "$STATF" ] && [ "$(stat_key)" = "$(cat "$STATF")" ]; then
    [ "$quiet" = 1 ] || echo "$OUT/sober2"
    exit 0
fi

# ブートストラップチェーン = bootstrap/chain.txt（畳んだブートストラップチェーン — ステージのソースのスナップショットbootstrap/<ステージ>/{compiler,std} とビルドの手順。gitの履歴に依らない — 公開準備タスク ①）。
# ステージのディレクトリは不変（名前 = ステージの番号 + 元のコミット）。private側の63行の正史はscripts/boot.commit（scripts/bootcheck.shが照合）
mapfile -t CHAIN < <(grep -v '^#' "$ROOT/bootstrap/chain.txt" | awk 'NF { print $1 }')
mapfile -t FORM < <(grep -v '^#' "$ROOT/bootstrap/chain.txt" | awk 'NF { print $2 }')
[ "${#CHAIN[@]}" -gt 0 ] || { echo "stage2.sh: bootstrap/chain.txt has no step" >&2; exit 1; }
mkdir -p "$OUT/boot"

# tree_of <dir> <compilerの元> <stdの元>: ビルドの木（compiler/* とstd/ のコピーを並べた木 — 仮決めR35-1）
tree_of() {
    mkdir -p "$1"
    cp -r "$2/." "$1/"
    cp -r "$3" "$1/std"
}
ll_cc() { "$ZIG" cc -target x86_64-linux-none -nostdlib -static -Wno-override-module "${3:--O0}" "$1" -o "$2"; }
# SOBER_O1=1: stage2を zig cc -O1 でビルドする（-O1の列。bootは -O0 のまま。キーにフラグを足して -O0 とビルドを分ける —
# 切り替えると作り直し: -O0 約 4 秒 / -O1 約 40 秒）。既定（開発ループ）は -O0
S2OPT=-O0
[ -n "${SOBER_O1:-}" ] && S2OPT=-O1
# 正規バックエンド（--emit=elf — mem2reg + 検証器つき、fcdb4bf 以降）を知るコンパイラは ELF を直に書く（B-5 の後 — LLVM / zig cc は開発時の差分オラクル専用に戻す。
# 決定 2026-10-02「bench の前」）。knows_elf <コミット>: そのコミットの compiler/app が --emit=elf を持つか
# ステージiのbootが --emit=elf を知るか = 次のステージの形がelf（最後のステージは知っている — 最後のステージの決まり）
knows_elf_step() { local n=$(( $1 + 1 )); [ "$n" -ge "${#CHAIN[@]}" ] || [[ ${FORM[$n]} == elf* ]]; }
# elf_build <コンパイラ> <出力> [フラグ…]: cwdのビルドの木のcompiler/appをELFに（entry = ELF_ENTRY — ブートストラップチェーンの過去のステージはapp/main.sober・今の木はapp）（実行のbitはここで — WriteModeを使わない古いコンパイラもある）
elf_build() { local cc=$1 out=$2; shift 2; "$cc" build "${ELF_ENTRY:-app/main.sober}" --emit=elf "$@" -o "$out" && chmod +x "$out"; }
# app_entry <木>: その木のcompiler/appのentry（appが複数のファイルのpackageならapp・1ファイルのステージはapp/main.sober）
app_entry() { if [ "$(find "$1/app" -maxdepth 1 -name '*.sober' | wc -l)" -gt 1 ]; then echo app; else echo app/main.sober; fi; }
secs() { awk -v a="$1" -v b="$(date +%s.%N)" 'BEGIN { printf "%.1f", b - a }'; }

# ── bootのブートストラップチェーン（boot₀ = 1行目のコミットのcompiler/ をstage1で、boot_i = i行目をboot_{i-1} で）──
bfresh() { [ -x "$1" ] && [ -f "$2" ] && [ "$(cat "$2")" = "$3" ]; }
prev=$STAGE1
bk=$(rel_key "$STAGE1")
for i in "${!CHAIN[@]}"; do
    c=${CHAIN[$i]}
    if [ "$i" = 0 ]; then BOOT=$OUT/boot/sober-boot; KF=$OUT/boot/.key; else BOOT=$OUT/boot/sober-boot-$i; KF=$OUT/boot/.key-$i; fi
    # 前の行のコンパイラが設計整合パス（a068ab9以降 — 57ef35b以降はregion透過の実体関数も）を知っていれば、bootもそれを掛けてビルドする
    # （最後のbootがstage2をビルドする速さに効く — 透過なしのbootは .llが約9倍・build約2.5倍）。キーにフラグを足してビルドを分ける
    bp=""
    [[ ${FORM[$i]} == *+passes ]] && bp=--passes
    be=""
    [[ ${FORM[$i]} == elf* ]] && be=+e
    bk="$bk $c${bp:++p}$be"
    if [ "$force" = 1 ] || ! bfresh "$BOOT" "$KF" "$bk"; then
        exec 8> "$OUT/boot/.lock"
        flock 8
        if [ "$force" = 1 ] || ! bfresh "$BOOT" "$KF" "$bk"; then
            echo "sober: building boot$i ($(basename "$prev") → compiler/ at $c) …" >&2
            t0=$(date +%s.%N)
            WB=$(mktemp -d)
            [ -d "$ROOT/bootstrap/$c/compiler" ] || { echo "stage2.sh: bootstrap/$c not found" >&2; rm -rf "$WB"; exit 1; }
            tree_of "$WB/root" "$ROOT/bootstrap/$c/compiler" "$ROOT/bootstrap/$c/std"
            if [ "$i" = 0 ]; then
                (cd "$WB/root" && "$prev" build app/main.sober --emit=ll -o "$WB/boot.ll") >&2 || { echo "stage2.sh: FAIL stage1 build of src/compiler/app at $c" >&2; rm -rf "$WB"; exit 1; }
                ll_cc "$WB/boot.ll" "$WB/sober-boot" >&2 || { echo "stage2.sh: FAIL zig cc boot.ll" >&2; rm -rf "$WB"; exit 1; }
            elif [ -n "$be" ]; then
                (cd "$WB/root" && ELF_ENTRY=$(app_entry "$WB/root") elf_build "$prev" "$WB/sober-boot" $bp) >&2 || { echo "stage2.sh: FAIL boot$((i - 1)) build of src/compiler/app at $c" >&2; rm -rf "$WB"; exit 1; }
            else
                (cd "$WB/root" && "$prev" build app/main.sober --emit=ll $bp -o "$WB/boot.ll") >&2 || { echo "stage2.sh: FAIL boot$((i - 1)) build of src/compiler/app at $c" >&2; rm -rf "$WB"; exit 1; }
                ll_cc "$WB/boot.ll" "$WB/sober-boot" >&2 || { echo "stage2.sh: FAIL zig cc boot.ll" >&2; rm -rf "$WB"; exit 1; }
            fi
            mv "$WB/sober-boot" "$BOOT.new" && mv "$BOOT.new" "$BOOT"
            echo "$bk" > "$KF"
            rm -rf "$WB"
            echo "sober: boot$i built ($(secs "$t0")s)" >&2
        fi
        flock -u 8
    fi
    prev=$BOOT
done

# ── stage2（今の compiler/ を boot で）──
# 最後の boot が --emit=elf を知っていて -O1 の列でなければ、stage2 は boot の正規バックエンドで ELF に（.ll と zig cc を通らない）
S2VIA=ll
if knows_elf_step $((${#CHAIN[@]} - 1)) && [ -z "${SOBER_O1:-}" ]; then S2VIA=elf; fi
key() { echo "$(rel_key "$BOOT" src/compiler src/std) $S2OPT $S2VIA"; }
fresh() { [ -x "$OUT/sober2" ] && [ -f "$OUT/.key" ] && [ "$(cat "$OUT/.key")" = "$1" ]; }

# l0_bake <仮の stage2>: 仮の stage2（L0 は仮のファイルだけ）に std の全 package（入れ子の std/hash/crc32 等も — .sober のある全ディレクトリ）の .sobi を書かせ、木の l0/std/ に置く
# （3'' 第2ステージの1.5 — stdのプリビルド焼き込み。同じコードが計算した値を、再ビルドするstage2に @embedで焼き込む）
l0_bake() {
    local s2a=$1 e=$W/l0all.sober d
    { echo "package main"; echo; for d in $(cd "$W/root" && find std -name '*.sober' ! -name '*_test.sober' ! -path 'std/internal/*' ! -path 'std/testing/cell/*' -printf '%h\n' | sort -u); do echo "import \"$d\""; done; echo; echo "func main() {"; echo "}"; } > "$e"
    # std/internal/… は std の中からだけ import できる（language.md 20 節 — この合成の main は std の外）ので列挙から外す。internal の package は使う std の package を通して読まれる
    # std/testing/cell もテストの構成のファイルからだけ import できる（41 節）ので外す — テストのビルドがソースから読む
    # 失敗したら check の出力（拒否の文面 — std のどこが落ちたか）と、def error の位置を引く手順を見せる（stdout を捨てていて理由が出なかった）
    SOBER_CACHE= SOBER_L0=0 "$s2a" check "$e" --split --l0-out "$W/root/l0" > "$W/l0.out" 2>&1 || {
        echo "stage2.sh: FAIL L0 bake (std check):" >&2
        cat "$W/l0.out" >&2
        SOBER_CACHE= SOBER_L0=0 "$s2a" check "$e" --def-index 2>&1 | tail -3 >&2
        exit 1
    }
}

k=$(key)
if [ "$force" = 1 ] || ! fresh "$k"; then
    exec 9> "$OUT/.lock"
    flock 9
    k=$(key)   # 待っている間に他の呼び手が作ったかもしれない
    if [ "$force" = 1 ] || ! fresh "$k"; then
        echo "sober: rebuilding stage2 (compiler/ or std/ or boot changed) …" >&2
        t0=$(date +%s.%N)
        W=$(mktemp -d)
        trap 'rm -rf "$W"' EXIT
        tree_of "$W/root" "$ROOT/src/compiler" "$ROOT/src/std"
        # 設計整合パス（--passes — 最後のboot = ブートストラップチェーンの5行目以降が知っている）を掛けてビルドする
        if [ "$S2VIA" = elf ]; then
            (cd "$W/root" && ELF_ENTRY=app elf_build "$BOOT" "$W/sober2" --passes) >&2 || { echo "stage2.sh: FAIL boot build of src/compiler/app" >&2; exit 1; }
            # 2ステージ目: L0を焼き込んで再ビルドする
            l0_bake "$W/sober2"
            (cd "$W/root" && ELF_ENTRY=app elf_build "$BOOT" "$W/sober2" --passes) >&2 || { echo "stage2.sh: FAIL boot build of src/compiler/app (with L0)" >&2; exit 1; }
            rm -f "$OUT/stage2.ll"
            mv "$W/sober2" "$OUT/sober2.new" && mv "$OUT/sober2.new" "$OUT/sober2"
        else
            (cd "$W/root" && "$BOOT" build app --emit=ll --passes -o "$W/stage2.ll") >&2 || { echo "stage2.sh: FAIL boot build of src/compiler/app" >&2; exit 1; }
            ll_cc "$W/stage2.ll" "$W/sober2" "$S2OPT" >&2 || { echo "stage2.sh: FAIL zig cc stage2.ll" >&2; exit 1; }
            l0_bake "$W/sober2"
            (cd "$W/root" && "$BOOT" build app --emit=ll --passes -o "$W/stage2.ll") >&2 || { echo "stage2.sh: FAIL boot build of src/compiler/app (with L0)" >&2; exit 1; }
            ll_cc "$W/stage2.ll" "$W/sober2" "$S2OPT" >&2 || { echo "stage2.sh: FAIL zig cc stage2.ll (with L0)" >&2; exit 1; }
            mv "$W/stage2.ll" "$OUT/stage2.ll.new" && mv "$W/sober2" "$OUT/sober2.new"
            mv "$OUT/stage2.ll.new" "$OUT/stage2.ll" && mv "$OUT/sober2.new" "$OUT/sober2"
        fi
        echo "$k" > "$OUT/.key"
        echo "sober: stage2 rebuilt ($(secs "$t0")s)" >&2
    fi
    flock -u 9
fi
stat_key > "$STATF"
[ "$quiet" = 1 ] || echo "$OUT/sober2"
