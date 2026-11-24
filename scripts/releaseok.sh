#!/usr/bin/env bash
# 公開の同期の前の止め: 指定したコミットで、リリースの組（チェックレベル4 — scripts/gates.sh --level 4・旧名 --release）が ALL PASS だった記録があるかを見る。無ければ断り、次にすることを出す。
# 記録 = gitの共通ディレクトリの gates-runs.tsv（gates.sh が実行の終わりに1行書く — 日時・コミット・clean / dirty・組・cache / cold・結果・数）。
# 数えるのは、作業木が綺麗（clean — コミットに無い変更を含まない）で、組が lv=4（チェックレベル4・旧名 release）の ALL PASS の行だけ（PASS with skipped は数えない）。
# さらに、行のゲートの列のハッシュ（sel=）が、そのコミットの gates.sh で計算したリリースの組のハッシュと一致する行だけ（ゲートの表が違う回の行を数えない）。
# サーバーで回した行は scripts/gatesrun.sh で持ち込める（export → import — 出所は root=server:<木>）。
#   scripts/releaseok.sh [コミット（既定 HEAD）]
# 終了コード: 0 = OK・1 = 記録が無い・2 = 引数の誤り
set -u
cd "$(dirname "$0")/.."
rev=$(git rev-parse --verify "${1:-HEAD}^{commit}" 2> /dev/null) || { echo "releaseok: NG — コミットが見つからない: ${1:-HEAD}"; exit 2; }
runs=${GATES_RUNS:-$(git rev-parse --path-format=absolute --git-common-dir)/gates-runs.tsv}
sel=$(scripts/gatesrun.sh sel "$rev") || { echo "releaseok: NG — ${rev:0:12} のゲートの列のハッシュを計算できない"; exit 1; }
hit=$([ -f "$runs" ] && awk -F'\t' -v r="$rev" -v h="sel=$sel" '$2 == r && $3 == "clean" && ($4 == "lv=4" || $4 == "release") && $6 == "ALL PASS" && $8 == h' "$runs" | tail -n 1)
if [ -n "$hit" ]; then
    echo "releaseok: OK — ${rev:0:12} でリリースの組が ALL PASS（$(cut -f1 <<< "$hit")・$(cut -f7 <<< "$hit")・$(cut -f11 <<< "$hit")）"
    exit 0
fi
echo "releaseok: NG — ${rev:0:12} でリリースの組（scripts/gates.sh --level 4）が ALL PASS だった記録が無い（$runs）"
last=$([ -f "$runs" ] && awk -F'\t' -v r="$rev" '$2 == r && ($4 == "lv=4" || $4 == "release")' "$runs" | tail -n 1)
[ -n "$last" ] && echo "  このコミットの最後のリリースの組: $(cut -f1,3,6,7,8 <<< "$last" | tr '\t' ' ')（数えるのは sel=$sel の行だけ）"
echo "  次にすること: このコミットを、変更の無い作業木で checkout して、リリースの組を回す:"
echo "    git -C <作業木> checkout --detach ${rev:0:12} && <作業木>/scripts/gates.sh --level 4 -j 12"
echo "  （所要は --full と同じ 約15〜25分。サーバーの待ち行列の1本の上限〔15分〕を越えるので、枠の取り方はナビに聞く）"
echo "  サーバーで回した記録があるなら、持ち込む: ssh <サーバー> 'cd <開発リポ> && scripts/gatesrun.sh export ${rev:0:12}' | scripts/gatesrun.sh import"
exit 1
