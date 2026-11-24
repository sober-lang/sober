#!/usr/bin/env bash
# 取り込みの前の検査（契約 = チェックレベル1の全部）を回したかの判定: 指定したコミットで、レベル1を N 個に割った全部の part（gates.sh --level 1 --part i/N）か、
# 割らないレベル1の、clean な木の ALL PASS の行が、実行の記録（gitの共通ディレクトリの gates-runs.tsv — gates.sh が書く）にあるかを見る。
# 各行の選んだゲートの列のハッシュ（sel=）が、この木の gates.sh で計算した割り方と一致する行だけを数える（割り方・ゲートの表が変わった後の古い行は数えない）。
# 記録の再利用（memo — HIT）を含む行も数える（ユーザー裁定 2026-11-18: 契約は普段の gates.sh と同じ形。冷の全件は push の前にナビが main の先頭で回す）。part ごとに最後の行で決める（ALL PASS の後に同じ part が落ちていれば NG）。worktree の間で記録は共有なので、同じコミットを別の木で回した行も数える。
#   scripts/contractok.sh [コミット（既定 HEAD）] [N（既定 = 記録にある割り方。無ければ3）] [--from=<基点>:<枝の先端>,…]
# --from = 列車の契約（チェックレベル2 — gates.sh --level 2 --from=…・旧名 --carry=）: 組の欄 lv=2・lv=2:i/N の行を数え、scripts/carry.ts の条件がいまも成り立つことを確かめる
# （枝の先端の記録が後で変わった・条件が崩れた場合に、古い持ち越しを数えない）。持ち越しを断られた行（全部を走らせた行）も同じ組として数える
# 出力: OK なら part ごとの日時・wall と wall の合計。NG なら、落ちた part のゲートと落ちたログの場所（<木>/scripts/.gatecache/failed/）、
# 足りない part を回すコマンド。終了コード 0 = OK・1 = NG・2 = 引数の誤り
set -u
cd "$(dirname "$0")/.."
carry=
pos=()
for a in "$@"; do case "$a" in --from=*) carry=${a#--from=} ;; --carry=*) carry=${a#--carry=}; echo "contractok: --carry= は --from= の旧名（移行の別名）" >&2 ;; *) pos+=("$a") ;; esac; done
set -- "${pos[@]}"
setb=lv=1; setarg="--level 1"
[ -n "$carry" ] && { setb=lv=2; setarg="--level 2 --from=$carry"; }
rev=$(git rev-parse --verify "${1:-HEAD}^{commit}" 2> /dev/null) || { echo "contractok: NG — コミットが見つからない: ${1:-HEAD}"; exit 2; }
runs=${GATES_RUNS:-$(git rev-parse --path-format=absolute --git-common-dir)/gates-runs.tsv}
[ "$(git rev-parse HEAD)" = "$rev" ] || echo "contractok: 注意 — この木の HEAD（$(git rev-parse --short HEAD)）は ${rev:0:12} と違う。割り方はこの木の gates.sh で計算する"
hashof() { if [ -n "$carry" ]; then scripts/gates.sh --level 2 --from="$carry" "$@" --list; else scripts/gates.sh --level 1 "$@" --list; fi | sha256sum | cut -c1-16; }
carryok=0
if [ -n "$carry" ]; then
    [ "$(git rev-parse HEAD)" = "$rev" ] || { echo "contractok: NG — --from は HEAD のコミットでだけ確かめられる（持ち越しの条件は HEAD の first-parent の列で見る）"; exit 2; }
    if out=$(NODE_NO_WARNINGS=1 node --experimental-strip-types scripts/carry.ts "$carry" 2> /dev/null); then
        carryok=1
        echo "contractok: 持ち越しの条件 OK（$(grep -c '^CARRY' <<< "$out")本を枝の全件から持ち越せる — $carry）"
    else
        echo "contractok: 注意 — 持ち越しの条件が成り立たない（$(grep -m1 '^NOCARRY' <<< "$out" | cut -c9-)）。持ち越した行は数えない"
    fi
fi
# 行: 1日時 2コミット 3clean 4組 5cache 6結果 7数 8sel= 9wall= 10fails= 11root= 12spot=（無い古い行もある）
# 13列目 carry=<引数>:<本数> — 持ち越した行（本数 > 0）は、持ち越しの条件がいまも成り立ち、引数が同じときだけ数える
# 組の欄の旧名（full / train — 2026-11-23 まで）は lv=1 / lv=2 に読み替える
rows() { [ -f "$runs" ] && awk -F'\t' -v r="$rev" -v ok="$carryok" -v c="carry=$carry:" '$2 == r && $3 == "clean" && ($5 == "cold" || $5 == "cache") && ($13 !~ /:[1-9][0-9]*$/ || (ok == 1 && index($13, c) == 1))' "$runs" | awk -F'\t' -v OFS='\t' '{ sub(/^full/, "lv=1", $4); sub(/^train/, "lv=2", $4); print }'; }
field() { sed -n "s/^$1=//p" <<< "$2"; }
# 割らないレベル1の ALL PASS
fh=$(hashof)
whole=$(rows | awk -F'\t' -v h="sel=$fh" -v s="$setb" '$4 == s && $6 == "ALL PASS" && $8 == h' | tail -n 1)
if [ -n "$whole" ]; then
    echo "contractok: OK — ${rev:0:12} で $setarg（$(cut -f7 <<< "$whole" | sed 's/.*gates=//')本・$(cut -f5 <<< "$whole")）が ALL PASS（$(cut -f1 <<< "$whole")・wall 合計 $(field wall "$(cut -f9 <<< "$whole")")秒・割らない1本）"
    exit 0
fi
# N: 引数か、記録にある割り方（このコミットの行のうち最後のもの）か、3
n=${2:-$(rows | awk -F'\t' -v s="$setb" '$4 ~ ("^" s ":[0-9]+/[0-9]+$") { split($4, a, "/"); n = a[2] } END { print n }')}
n=${n:-3}
ok=1; sum=0; out=(); todo=()
for i in $(seq "$n"); do
    h=$(hashof --part "$i/$n")
    last=$(rows | awk -F'\t' -v s="$setb:$i/$n" -v h="sel=$h" '$4 == s && $8 == h' | tail -n 1)
    # 最後の行で決める（同じコミットで ALL PASS の後に落ちた行があれば、揺れを隠さない）
    pass=$([ "$(cut -f6 <<< "$last")" = "ALL PASS" ] && echo "$last")
    if [ -n "$pass" ]; then
        w=$(field wall "$(cut -f9 <<< "$pass")"); sum=$((sum + ${w:-0}))
        out+=("  part $i/$n: ALL PASS（$(cut -f1 <<< "$pass")・$(cut -f7 <<< "$pass" | sed 's/.*gates=//')本・$(cut -f7 <<< "$pass" | grep -o 'hit=[0-9]*')・$(cut -f5 <<< "$pass")・wall ${w}秒）")
        continue
    fi
    ok=0
    todo+=("scripts/gates.sh $setarg --part $i/$n -j 12")
    if [ -z "$last" ]; then
        out+=("  part $i/$n: 記録が無い（このコミット・clean な木・いまの割り方の行が無い）")
    else
        fl=$(field fails "$(cut -f10 <<< "$last")"); rt=$(field root "$(cut -f11 <<< "$last")")
        out+=("  part $i/$n: $(cut -f6 <<< "$last")（$(cut -f1 <<< "$last")）— 落ちたゲート: ${fl:-（記録なし）}")
        [ -n "$fl" ] && [ -n "$rt" ] && for g in ${fl//,/ }; do
            lg=$(ls -t "$rt/scripts/.gatecache/failed/$g".*.log 2> /dev/null | head -n 1)
            out+=("    $g のログ: ${lg:-（$rt/scripts/.gatecache/failed/ に無い）}")
        done
    fi
done
if [ "$ok" = 1 ]; then
    echo "contractok: OK — ${rev:0:12} で $setarg の $n 個の part が全部 ALL PASS（wall 合計 ${sum}秒）"
    printf '%s\n' "${out[@]}"
    # 総量の線（柱4 — scripts/gatewall.txt の注）: part の wall の合計が 3600 秒を超えたら WARN。工程(e)とR1が入って枝の組が縮んだら FAIL へ上げる
    [ "$sum" -gt 3600 ] && echo "contractok: WARN — part の wall の合計 ${sum}秒 > 3600秒（総量の線 — いまは WARN。scripts/gatewall.txt の注）"
    exit 0
fi
echo "contractok: NG — ${rev:0:12} で $setarg の part が揃っていない（N = $n）"
printf '%s\n' "${out[@]}"
echo "  次にすること: 落ちたゲートを直してコミットし直すか、足りない part を回す（clean な木）:"
printf '    %s\n' "${todo[@]}"
echo "  （サーバーでは .pair/tools/gqfull.sh <レーン> が part を待ち行列に順に並べる）"
exit 1
