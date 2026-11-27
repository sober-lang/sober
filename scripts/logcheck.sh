#!/usr/bin/env bash
# logcheck（language.md 42 節「sinkの約束」）: testdata/logcheckの題材をビルドし、print.Logのsinkの約束を照合する（本体 = scripts/logcheck.ts）。
# - 全行がJSONとして読める・速い読み手なら落ちない・written + dropped = 呼んだ数（ワーカー1 / 2 / 8）
# - 読み手が止まったパイプで書き手が塞がらない・少しずつ読む読み手と8ワーカーで行が割れない
# - 4 KiBを越える記録は1行・32 KiBを越える記録は落ちて `$dropped` の行
# - 正常終了・panic（死因の前）・SIGTERM / SIGINT（PID 1でないときはシグナルの死・PID 1は143 / 130）で書き出す
#   scripts/logcheck.sh            照合
#   scripts/logcheck.sh --mutants  検出の確認: rtの変異115（落とした記録を数えない）・116（正常終了で書き出さない）が赤になること。
#                                  照合のビルド: 154（照合だけ — 照合が全部の場面で破れない）・155（114 = 積んだ端を書きかけの途中で進める + log_endの入口の照合）・
#                                  156（117 = 塊をPIPE_BUFで切らない + 塊の照合）が、manyの1回目の実行（W1・ファイルへ）で照合に捕まり終了コード103
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
source scripts/gatelib.sh
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
pid1=1
timeout 5 unshare -rpf --kill-child true > /dev/null 2>&1 || pid1=0
build() { # $1 = 出力のディレクトリ, $2 = 追加の旗
    mkdir -p "$1"
    for p in many big exit acct; do
        "$S2" build "testdata/logcheck/$p.sober" $2 -o "$1/$p" > "$1/$p.blog" 2>&1 || { echo "logcheck: FAIL build $p $2 ($(head -c 200 "$1/$p.blog"))"; return 1; }
    done
}
if [ "${1:-}" = "--mutants" ]; then
    fail=0
    for m in 154 155 156; do
        build "$W/m$m" "--rt-mutant=$m" || { fail=1; continue; }
    done
    r=$(LOGCHECK_PID1=$pid1 node --experimental-strip-types --no-warnings scripts/logcheck.ts "$W/m154" 2>&1 | tail -n 1)
    case "$r" in *"fail=0") ;; *) echo "logcheck: FAIL the check build (mutant 154) broke ($r)"; fail=1 ;; esac
    for m in 155 156; do
        SOBER_WORKERS=1 "$W/m$m/many" > /dev/null 2> "$W/m$m.err"; ec=$?
        if [ $ec = 103 ] && grep -q '^log-check: ' "$W/m$m.err"; then echo "logcheck: mutant $m caught by the check ($(grep -m1 '^log-check: ' "$W/m$m.err"))"
        else echo "logcheck: FAIL mutant $m was not caught by the check (exit $ec)"; fail=1; fi
    done
    for m in 115 116; do
        build "$W/m$m" "--rt-mutant=$m" || { fail=1; continue; }
        r=$(LOGCHECK_PID1=$pid1 node --experimental-strip-types --no-warnings scripts/logcheck.ts "$W/m$m" 2>&1 | tail -n 1)
        case "$r" in
            *"fail=0") echo "logcheck: FAIL mutant $m was not caught ($r)"; fail=1 ;;
            *) echo "logcheck: mutant $m caught ($r)" ;;
        esac
    done
    [ "$fail" = 0 ] && echo "logcheck: 4 mutants caught · check build clean" && exit 0
    exit 1
fi
build "$W/ok" "" || exit 1
LOGCHECK_PID1=$pid1 node --experimental-strip-types --no-warnings scripts/logcheck.ts "$W/ok"
