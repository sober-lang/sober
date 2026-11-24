#!/usr/bin/env bash
# logcheck（language.md 42 節「sinkの約束」）: testdata/logcheckの題材をビルドし、print.Logのsinkの約束を照合する（本体 = scripts/logcheck.ts）。
# - 全行がJSONとして読める・速い読み手なら落ちない・written + dropped = 呼んだ数（ワーカー1 / 2 / 8）
# - 読み手が止まったパイプで書き手が塞がらない・少しずつ読む読み手と8ワーカーで行が割れない
# - 4 KiBを越える記録は1行・32 KiBを越える記録は落ちて `$dropped` の行
# - 正常終了・panic（死因の前）・SIGTERM / SIGINT（PID 1でないときはシグナルの死・PID 1は143 / 130）で書き出す
#   scripts/logcheck.sh            照合
#   scripts/logcheck.sh --mutants  検出の確認: rtの変異114（積んだ端を書きかけの途中で進める）・115（落とした記録を数えない）・
#                                  116（正常終了で書き出さない）・117（塊をPIPE_BUFで切らない）が赤になること
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
    for m in 114 115 116 117; do
        build "$W/m$m" "--rt-mutant=$m" || { fail=1; continue; }
        r=$(LOGCHECK_PID1=$pid1 node --experimental-strip-types --no-warnings scripts/logcheck.ts "$W/m$m" 2>&1 | tail -n 1)
        case "$r" in
            *"fail=0") echo "logcheck: FAIL mutant $m was not caught ($r)"; fail=1 ;;
            *) echo "logcheck: mutant $m caught ($r)" ;;
        esac
    done
    [ "$fail" = 0 ] && echo "logcheck: 4 mutants caught" && exit 0
    exit 1
fi
build "$W/ok" "" || exit 1
LOGCHECK_PID1=$pid1 node --experimental-strip-types --no-warnings scripts/logcheck.ts "$W/ok"
