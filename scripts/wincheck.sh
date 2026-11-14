#!/usr/bin/env bash
# wincheck: 浅いregionの予約ページ（language.md 11 節「接続のtaskの小さいスロット」）の検査。testdata/wincheck/win.sober（net.Serveのregion: 1 MiBの接続の
# taskが予約ページを越えて小さいスロットへ移るパス — 持続する深度のスタック・先端の1バイト伸長・mapの成長・ファイルの読み・深い再帰・region: の境）を
# W2 / W8 × {既定・SOBER_TASK_WIN=0（予約ページを張らない）・SOBER_MADV_MB=0（深度の入りの返しを毎回走らせる — 予約ページの守りを踏む）} で走らせ、
# stdoutがtestdata/wincheck/win.outと一致することを検証する（予約ページの有無で出力は変わらない — region: の上限も予約ページの有無でちょうど同じ）。
# W1は予約ページを張らない（小さいスロットのtaskはM:Nのときだけ）ので回さない。
# --mutants: ミューテーション42（予約ページを移さない — 溢れで死102）・43（深度の入りとleaseの返しの予約ページの守りを外す）でビルドした題材がどこかの構成でゴールデンと外れること・
#   46（予約ページにしないフラグをチャンクに残さない — 接続ごとにページを返す）でビルドしたchurnが回数の照合で落ちることを検証する
#   scripts/wincheck.sh [--mutants]
set -uo pipefail
cd "$(dirname "$0")/.."
S2=${STAGE2:-out/stage2/sober2}
MUT=0
[ "${1:-}" = --mutants ] && MUT=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
GOLD=testdata/wincheck/win.out
# judge <実行ファイル> <名前> → 0 = 全構成でゴールデンと一致（外れた構成を印字）
judge() {
    local x=$1 name=$2 w e bad=0
    for w in 2 8; do
        for e in "" SOBER_TASK_WIN=0 SOBER_MADV_MB=0; do
            env SOBER_WORKERS=$w $e timeout 60 "$x" > "$W/out" 2> "$W/err"
            local ec=$?
            if [ $ec != 0 ] || ! cmp -s "$GOLD" "$W/out"; then
                echo "wincheck: $name W$w ${e:-default}: exit $ec"
                diff "$GOLD" "$W/out" | head -8
                head -3 "$W/err"
                bad=1
            fi
        done
    done
    return $bad
}
"$S2" build testdata/wincheck/win.sober --emit=elf --passes -o "$W/win" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build ($(head -c 200 "$W/b.log"))"; exit 1; }
# churn: 1接続2リクエストで張り直す接続を300本（limited-connの形 — std/httpの畳みのparkでリクエストの深度が死ぬ）。予約ページを返すmadviseは
# チャンクの予約ページごとに高々1回（WSP_NOWINをチャンクに残す）— 接続ごとに返すとM:NでTLBの撃ち落とし。回数の不変条件win_rel ≤ 予約ページの数4 × tcb_mmapsで縛る
# （命令の検査にも速さにも鳴らない種類）。W2だけ（予約ページはM:Nのときだけ・W2でチャンクの使い回しが最も多い）
churn() {
    local x=$1 name=$2
    env SOBER_WORKERS=2 SOBER_PAR_STATS=1 timeout 60 "$x" > "$W/cout" 2> "$W/cerr"
    local ec=$? t r
    t=$(grep -o 'tcb_mmaps=[0-9]*' "$W/cerr" | cut -d= -f2)
    r=$(grep -o 'win_rel=[0-9]*' "$W/cerr" | cut -d= -f2)
    if [ $ec != 0 ] || [ "$(cat "$W/cout")" != "responses 600" ] || [ -z "$t" ] || [ -z "$r" ] || [ "$r" -gt $((4 * t)) ]; then
        echo "wincheck: $name churn: exit $ec out=$(head -c 60 "$W/cout") tcb_mmaps=$t win_rel=$r"
        return 1
    fi
}
"$S2" build testdata/wincheck/churn.sober --emit=elf --passes -o "$W/churn" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build churn ($(head -c 200 "$W/b.log"))"; exit 1; }
fail=0
judge "$W/win" base || { echo "wincheck: FAIL — output differs from $GOLD"; fail=1; }
churn "$W/churn" base || { echo "wincheck: FAIL — the window pages are returned per connection"; fail=1; }
if [ $MUT = 1 ]; then
    for m in 42 43; do
        "$S2" build testdata/wincheck/win.sober --emit=elf --passes --rt-mutant=$m -o "$W/win$m" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build m$m"; exit 1; }
        if judge "$W/win$m" "m$m" > "$W/m$m.log"; then echo "wincheck: FAIL — mutant $m was not caught"; fail=1; else echo "wincheck: m$m caught ($(head -1 "$W/m$m.log"))"; fi
    done
    "$S2" build testdata/wincheck/churn.sober --emit=elf --passes --rt-mutant=46 -o "$W/churn46" > "$W/b.log" 2>&1 || { echo "wincheck: FAIL build churn m46"; exit 1; }
    if churn "$W/churn46" m46 > "$W/m46.log"; then echo "wincheck: FAIL — mutant 46 was not caught"; fail=1; else echo "wincheck: m46 caught ($(head -1 "$W/m46.log"))"; fi
fi
[ $fail = 0 ] && echo "wincheck: PASS"
exit $fail
