#!/usr/bin/env bash
# 受理集合の照合（E2-SのS3 — docs/formal.md「checkのcallMのフェーズ」の検査）: `sober check` の出力（判定JSON・拒否の診断・analyzerの指摘 — stdoutと
# stderrと終了コード）をentryごとにゴールデン（testdata/checkverdict/）に固定する。checkの脱糖の形（E2-SでcallMへ上げる関数の選び方・逃げ）を
# 変えても受理 / 拒否と診断の文面が1件でも変われば赤。EXCLUDEDの理由の文面を保つゴールデン（excluded_keep）では拾えない診断のラベルの変化も見る。
#
#   scripts/checkverdict.sh            ゴールデンと比較（fail = 0がゲート）
#   scripts/checkverdict.sh --regen    ゴールデンを作り直す（受理集合を意図して変えたときだけ — 差分を見てからコミット）
#   scripts/checkverdict.sh --split    G-e（3'' M3 — キャッシュは呼び手のSOBER_CACHE次第・既定は無効）: 小分けのcheck（`check --split` — packageごとのregion・依存の .sobiを読む）の出力を同じゴールデンと比較
#                                      （一括の判定 ≡ 小分けの判定 — 合成定理 defsOk_of_linked の実地確認）
#
# 対象: irtext の対象（examples の .out 持ち + testdata の package）・examples の全部・testdata/checkneg・compiler/tools/*・compiler/app（自己適用 — cwd = compiler/）
set -uo pipefail
cd "$(dirname "$0")/.."
source scripts/gatelib.sh
ROOT=$PWD
STAGE2=${STAGE2:-$ROOT/out/stage2/sober2}
G=testdata/checkverdict
regen=0
split=()
[ "${1:-}" = "--regen" ] && regen=1
[ "${1:-}" = "--split" ] && split=(--split)
# 小分けのキャッシュ（3'' 第2段階C2）: 呼び手がSOBER_CACHEを立てなければ無効（空文字 — 既定の ~/.cache/soberを汚さない・G-eは冷の判定）。
# 立てれば G-f（scripts/cachesplit.sh — 冷 / 温 / 検証）。コンパイラの鍵は stage2 の .key（/proc/self/exe のハッシュを entry ごとに払わない）
export SOBER_CACHE="${SOBER_CACHE-}"
export SOBER_SELF_KEY="${SOBER_SELF_KEY:-$(cat "$(dirname "$STAGE2")/.key" 2>/dev/null)}"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
[ $regen = 1 ] && mkdir -p "$G" && find "$G" -name "*.txt" -delete

# CV_BUILD=1（incrcheckのgammaの相 — タスク2 R4）: checkの前に同じentryを配置先へbuildする（γ とparseの木を書く — 結果は見ない）。
# src/compilerの題材（自己・tools）はbuildしない（重い — 自己はincrcheckの依存チェーンのbldが覆う）
pre() {
    [ "${CV_BUILD:-0}" = 1 ] && "$STAGE2" build "$1" -o "$2/cvb.out" > /dev/null 2>&1
    return 0
}

one() {
    local w=${PAR_W:-$tmp} e=$1 key out ec=0
    key=$(echo "$e" | tr '/' '_')
    case "$e" in
        # 自己適用はstdをcompiler/stdにコピーした木で（@embedのstdの焼き込み — typerdiffと同じ形）
        src/compiler/app) mkdir -p "$w/self" && cp -r src/compiler "$w/self/compiler" && cp -r src/std "$w/self/compiler/std" &&
            ( cd "$w/self/compiler" && ulimit -s unlimited && "$STAGE2" check "${e#src/compiler/}" "${split[@]}" ) > "$w/o" 2>&1 || ec=$? ;;
        src/compiler/*) ( cd "$ROOT/src/compiler" && ulimit -s unlimited && "$STAGE2" check "${e#src/compiler/}" "${split[@]}" ) > "$w/o" 2>&1 || ec=$? ;;
        *) pre "$e" "$w"; "$STAGE2" check "$e" "${split[@]}" > "$w/o" 2>&1 || ec=$? ;;
    esac
    echo "exit=$ec" >> "$w/o"
    if [ $regen = 1 ]; then
        cp "$w/o" "$ROOT/$G/$key.txt"
        echo "@@ ok"
        return
    fi
    # --split の既知の差（$G/SPLIT-KNOWN.txt — F の項目に紐づく）: 外して known と数える。一致するようになったら行の消し忘れとして赤
    if [ ${#split[@]} -gt 0 ] && grep -q "^$e " "$ROOT/$G/SPLIT-KNOWN.txt" 2>/dev/null; then
        if cmp -s "$w/o" "$ROOT/$G/$key.txt"; then
            echo "FAIL: $e: listed in $G/SPLIT-KNOWN.txt but now matches — remove the line (its F is fixed)"
            echo "@@ fail"
        else
            echo "@@ known"
        fi
        return
    fi
    if ! cmp -s "$w/o" "$ROOT/$G/$key.txt"; then
        echo "FAIL: $e: check output differs from $G/$key.txt"
        diff "$ROOT/$G/$key.txt" "$w/o" | head -6
        echo "@@ fail"
        return
    fi
    echo "@@ ok"
}

list() {
    ( scripts/irtext.sh --list; ls examples/*.sober; ls -d testdata/checkneg/* 2>/dev/null; ls -d src/compiler/tools/*/main.sober; echo src/compiler/app ) | sort -u | sample
}

# CV_SAMPLE = 抜き取り（呼び手の別の相が全数を覆うときだけ）: eighth = 8 本に 1 本 + compiler の題材・
# std = std の package を 3 つ以上 import する題材・まだ覆っていない std の package を直に import する題材 + compiler の題材
# （stdの焼き込みを外したパスの照合 — 全数の題材が引くstdのpackageを全部覆う）
sample() {
    local e n i new
    local -A seen=()
    case "${CV_SAMPLE:-}" in
        "") cat ;;
        eighth) awk '/^src\/compiler\// || NR % 8 == 0' ;;
        std)
            while IFS= read -r e; do
                case "$e" in src/compiler/*) echo "$e"; continue ;; esac
                if [ -d "$e" ]; then mapfile -t is < <(find "$e" -name '*.sober' -exec cat {} + | grep -o '^import "std/[^"]*"' | sort -u)
                else mapfile -t is < <(grep -o '^import "std/[^"]*"' "$e" | sort -u); fi
                n=${#is[@]}
                new=0
                for i in "${is[@]}"; do [ -n "${seen[$i]:-}" ] || new=1; done
                if [ "$n" -ge 3 ] || [ $new = 1 ]; then
                    echo "$e"
                    for i in "${is[@]}"; do seen[$i]=1; done
                fi
            done ;;
        *) echo "checkverdict: unknown CV_SAMPLE=$CV_SAMPLE" >&2; exit 2 ;;
    esac
}

par_init "$tmp"
while IFS= read -r e; do [ -e "$e" ] && par_run one "$e"; done < <(list)
par_wait > "$tmp/list"
grep -v '^@@ ' "$tmp/list" || true
ok=$(par_count ok "$tmp/list")
fail=$(par_count fail "$tmp/list")
known=$(par_count known "$tmp/list")
echo "checkverdict${split:+ --split (G-e)}${CV_SAMPLE:+ (sample $CV_SAMPLE)}: $ok entries match testdata/checkverdict${split:+ + $known known (SPLIT-KNOWN.txt)}, fail=$fail"
[ "$fail" = 0 ]
