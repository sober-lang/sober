#!/usr/bin/env bash
# tschain（時刻つきの送信バッファリングの依存チェーンの検査 — report-fq-7）: testdata/delaylat/main.sober（ServeConnのDelayed(10 ms) と閉ループの客を同じプロセスに・2秒）を
# SOBER_PAR_STATS=1・SOBER_WORKERS=4・客 256 本で走らせ、#par tasks の ts_chain（満了で積んだ SEND だけで未提出が UR_POKE に届いて入った頭の取り込みの数 —
# 満了の処理 → enter → 満了の処理 … の依存チェーンでtaskが走れない形）を数で見る。時間では判定しない（遅延の分布は負荷と機械で揺れる）。
# 判定: ts_chain = 0かつearly = 0（待たずに出たレスポンスが無い）。
#   scripts/tschain.sh   検査 + 検出の確認（ミューテーション89 = 満了で積んだSENDを頭の取り込みの数えに入れる形でts_chain > 0になること）
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# run <tag> <want: 0 = 依存チェーンなし・1 = 依存チェーンあり> [buildの引数…]
run() {
    local tag=$1 want=$2; shift 2
    "$S2" build testdata/delaylat/main.sober --emit=elf --passes "$@" -o "$W/$tag" > "$W/$tag.blog" 2>&1 || { echo "tschain: FAIL build $tag ($(head -c 200 "$W/$tag.blog"))"; return 1; }
    local out ec=0 e ch
    out=$(env SOBER_PAR_STATS=1 SOBER_WORKERS=4 CLIENTS=256 timeout 60 "$W/$tag" 2>&1) || ec=$?
    e=$(echo "$out" | sed -n 's/^n=[0-9]* early=\([0-9]*\) .*/\1/p'); ch=$(echo "$out" | sed -n 's/.* ts_chain=\([0-9]*\).*/\1/p')
    if [ "$ec" != 0 ] || [ -z "$e" ] || [ -z "$ch" ]; then echo "tschain: FAIL $tag — exit $ec ($(echo "$out" | head -c 300))"; return 1; fi
    if [ "$e" != 0 ]; then echo "tschain: RED $tag — $e responses came before the delay"; return 1; fi
    if [ "$want" = 0 ] && [ "$ch" != 0 ]; then echo "tschain: RED $tag — ts_chain=$ch (head polls entered only for SENDs pushed at expiry)"; return 1; fi
    if [ "$want" = 1 ] && [ "$ch" = 0 ]; then echo "tschain: RED $tag — mutant not detected (ts_chain=0)"; return 1; fi
    echo "tschain: ok $tag — ts_chain=$ch early=$e"; return 0
}
fail=0
run base 0 || fail=1
run m89 1 --rt-mutant=89 || fail=1
[ $fail = 0 ] && echo "tschain: PASS (mutant 89 caught)" || { echo "tschain: FAIL"; exit 1; }
