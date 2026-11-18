#!/usr/bin/env bash
# hermeticity 検査（V5-1 C1 — ブートストラップ固定点の前提）。
#
#   scripts/hermetic.sh [対象…]    stage1（凍結した Zig 版 — ELF を比べる。gates の hermetic_zig は凍結コーパスだけを渡す）
#   scripts/hermetic.sh --stage2   主の sober の stage2（out/stage2/sober2 — Sober の正規バックエンドの ELF（--emit=elf --passes = bin/sober の既定の形 — B-4）と
#                                  .ll を比べる。gates の hermetic）
#
# 出力が入力（ソースとコンパイラ）だけで決まることを検証する。stage2 ≡ stage3の固定点
# （docs/design-dev.md selfhost 項）は、コンパイラの出力に path・時刻・環境が混ざると偶然にしか成り立たない。
# 対象: examples/*.out を持つ全例 + 複数 package の testdata（pkgdemo / errpkg / iface / minic）。
# 観測: ELF（sober build）と脱糖後のコア JSON（sober check --core-json）をバイト比較。
#
# 基準 A = リポのルートで相対 path。比べる相手:
#   B  同じ条件でもう 1 回（非決定性）
#   C  別の深さの path へソース木とコンパイラ自身をコピーし、絶対 path で渡す。
#      環境も変える: env -i・TZ・LANG・umask・HOME・SOURCE_DATE_EPOCH
# 対象外: stage1 バイナリ自身（Zig のデバッグ情報が絶対 path を持つ — 固定点の対象ではない）、診断メッセージ
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
EMIT=()
EMIT2=()
if [ "${1:-}" = "--stage2" ]; then
    SOBER=$(scripts/stage2.sh) || exit 1   # 主のsoberの本体（bin/soberはラッパーでコピーできない — コピーするのはstage2のELF）
    EMIT=(--emit=ll)
    EMIT2=(--emit=elf --passes)
else
    SOBER=$(realpath "${STAGE1:-src/stage1/zig-out/bin/sober}")   # 検査する stage（既定は stage1）
fi

W=$(mktemp -d)
C=$W/elsewhere/deeper/tree
mkdir -p "$C/bin"
cp -r examples testdata "$C/"
cp "$SOBER" "$C/bin/sober-copy"

targets=$(for f in examples/*.out; do echo "examples/$(basename "$f" .out).sober"; done)
targets="$targets testdata/pkgdemo/app testdata/errpkg/app testdata/minic/app testdata/jsonpkg/app"
# testdata/ifaceはstage1専用の .sobiの題材（iface / --pkg はZigにしか無い）で、byteの段階S4の前の言語のまま凍結してある（[]intのバイト列）—
# 主の sober（--stage2）の対象からは外す（2026-10-01）
[ "${1:-}" = "--stage2" ] || targets="$targets testdata/iface/app"
# stage1 の列は対象を引数で絞れる（gates の hermetic_zig は凍結コーパスだけを渡す — obs の名前: examples/X.sober → X、testdata/D/app → そのまま。G1）
if [ "${1:-}" != "--stage2" ] && [ $# -gt 0 ]; then
    targets=$(for a in "$@"; do case "$a" in */*) echo "$a" ;; *) echo "examples/$a.sober" ;; esac; done)
fi

run_a() { (cd "$ROOT" && "$SOBER" "$@"); }
run_c() {
    (cd "$C" && umask 077 && env -i PATH=/usr/bin:/bin HOME=/nonexistent TZ=Pacific/Chatham LANG=ja_JP.UTF-8 \
        LC_ALL=C SOURCE_DATE_EPOCH=0 "$C/bin/sober-copy" "$@")
}

# 対象ごとに独立（出力のファイルは対象ごとに別名・C の木は読むだけ）— gatelib の par_run で $JOBS 本ずつ並列に。
# 各仕事は失敗の行と結果の 1 行（@@ ok / @@ fail / @@ skip）を吐き、par_wait が対象の順に並べる（出力の順は直列と同じ）
one() {
    local t=$1 k f=0
    k=$(echo "$t" | tr '/' '_')
    run_a build "$t" "${EMIT[@]}" -o "$W/$k.a" > /dev/null 2>&1 || { echo "BUILD FAIL $t"; echo "@@ skip"; return; }
    if [ -n "${EMIT2[*]}" ]; then
        run_a build "$t" "${EMIT2[@]}" -o "$W/$k.ea" > /dev/null 2>&1 || { echo "BUILD FAIL (ELF) $t"; echo "@@ skip"; return; }
        run_a build "$t" "${EMIT2[@]}" -o "$W/$k.eb" > /dev/null 2>&1
        run_c build "$C/$t" "${EMIT2[@]}" -o "$W/$k.ec" > /dev/null 2>&1
        cmp -s "$W/$k.ea" "$W/$k.eb" || { echo "NONDETERMINISTIC ELF (stage2) $t"; f=1; }
        cmp -s "$W/$k.ea" "$W/$k.ec" || { echo "ENV/PATH-DEPENDENT ELF (stage2) $t"; f=1; }
    fi
    run_a build "$t" "${EMIT[@]}" -o "$W/$k.b" > /dev/null 2>&1
    run_c build "$C/$t" "${EMIT[@]}" -o "$W/$k.c" > /dev/null 2>&1
    cmp -s "$W/$k.a" "$W/$k.b" || { echo "NONDETERMINISTIC ELF $t"; f=1; }
    cmp -s "$W/$k.a" "$W/$k.c" || { echo "ENV/PATH-DEPENDENT ELF $t"; f=1; }
    # コア JSON: 失敗する例（check の断片外）も「同じ失敗」なら一致とみなす — 出力と終了状態の両方を比べる
    local ea ec
    run_a check "$t" --core-json > "$W/$k.ja" 2> /dev/null; ea=$?
    run_c check "$C/$t" --core-json > "$W/$k.jc" 2> /dev/null; ec=$?
    { [ "$ea" = "$ec" ] && cmp -s "$W/$k.ja" "$W/$k.jc"; } || { echo "ENV/PATH-DEPENDENT CORE JSON $t"; f=1; }
    rm -f "$W/$k.a" "$W/$k.b" "$W/$k.c" "$W/$k.ea" "$W/$k.eb" "$W/$k.ec" "$W/$k.ja" "$W/$k.jc"
    if [ "$f" = 0 ]; then echo "@@ ok"; else echo "@@ fail"; fi
}

par_init "$W"
for t in $targets; do par_run one "$t"; done
par_wait > "$W/list"
grep -v '^@@ ' "$W/list" || true
# BUILD FAIL は従来どおり fail=1 で、件数（n）には数えない
n=$(( $(par_count ok "$W/list") + $(par_count fail "$W/list") ))
fail=0
[ "$(par_count fail "$W/list")" = 0 ] && [ "$(par_count skip "$W/list")" = 0 ] || fail=1
# @embed の []byte（map[string][]byte の受け皿）: 書き手はファイルを読み直して load の時点の長さと指紋で照合する。load の後にファイルが
# 変わった形（SOBER_EMBED_SKEW=1 — 指紋を1ビットずらす）では、ELF・.ll・IR・コアJSONのどれも出さずに EmbedChanged で止まること
if [ "${1:-}" = "--stage2" ]; then
    for em in "--emit=elf --passes" "--emit=ll" "--emit=ir"; do
        rm -f "$W/skew.out"
        ec=0
        SOBER_EMBED_SKEW=1 SOBER_BUILD_CACHE=0 "$SOBER" build examples/embed_bytes.sober $em -o "$W/skew.out" > "$W/skew.err" 2>&1 || ec=$?
        if [ "$ec" = 0 ] || [ -e "$W/skew.out" ] || ! grep -q "EmbedChanged" "$W/skew.err"; then
            echo "EMBED REREAD NOT CHECKED ($em): exit=$ec $(head -c 200 "$W/skew.err")"; fail=1
        fi
    done
    ec=0
    SOBER_EMBED_SKEW=1 SOBER_CHECK_CACHE=0 "$SOBER" check examples/embed_bytes.sober --core-json > "$W/skew.json" 2> "$W/skew.err" || ec=$?
    if [ "$ec" = 0 ] || ! grep -q "EmbedChanged" "$W/skew.err"; then
        echo "EMBED REREAD NOT CHECKED (--core-json): exit=$ec $(head -c 200 "$W/skew.err")"; fail=1
    fi
    # 鍵の材料は load の読みから: load の後にファイルが変わった答え（試しの口で load の中身をずらす）は、答えの再生（check・build）に
    # 覚えない。覚えなければ、次の素のビルドは外れ（0/1）で、その次から当たる（1/1）。runの格納場所は load の木の要約が鍵なので別の項目になる
    for ex in embed_bytes embed_demo; do
        for cmd in check build; do
            rm -rf "$W/skewcache"
            mkdir -p "$W/skewcache"
            o=()
            [ "$cmd" = build ] && o=(-o "$W/skew.exe")
            # gates.sh はキャッシュと答えの再生を切り、検証器を毎段に掛けて export する（buildの答えの再生は SOBER_VERIFY=each で通らない）— ここだけ明示で外す
            cc=(env -u SOBER_VERIFY -u SOBER_BUILD_PAR SOBER_BUILD_CACHE=1 SOBER_CHECK_CACHE=1 SOBER_CHECK_REPLAY=1 SOBER_CACHE="$W/skewcache" SOBER_CACHE_STAT=1)
            got=$( { "${cc[@]}" SOBER_EMBED_SKEW=1 "$SOBER" $cmd examples/$ex.sober "${o[@]}" > /dev/null 2>&1 || true
                     "${cc[@]}" "$SOBER" $cmd examples/$ex.sober "${o[@]}" 2>&1 > /dev/null
                     "${cc[@]}" "$SOBER" $cmd examples/$ex.sober "${o[@]}" 2>&1 > /dev/null; } | grep -oE "$cmd-replay [01]/1" | tr '\n' ' ')
            if [ "$got" != "$cmd-replay 0/1 $cmd-replay 1/1 " ]; then
                echo "EMBED KEY FROM A REREAD ($cmd $ex): $got"; fail=1
            fi
        done
    done
fi
rm -r "$W"
echo "hermetic: $n targets, fail=$fail"
exit $fail
