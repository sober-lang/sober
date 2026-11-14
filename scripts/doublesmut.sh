#!/usr/bin/env bash
# ゲートdoublesのミューテーションの検査（節目の明示のオプション — gatesには入れない）: 「差し替えを再生の鍵に入れない」壊したコンパイラ
# （テストの結果の再生と答えの再生が照合するファイルから、契約の検査が読んだ相手のファイルを落とす — app/cmd_check.sober の userFiles）を
# 木のコピーからstage2でビルドし、scripts/doubles.shの ⑥（本物の宣言の変更で再生が外れる）が特定して鳴ること（鳴らなければFAIL）。
# 関数キャッシュの鍵（incrmut）には差し替えに固有の成分が無い — 鍵は中身から組まれ、double と本物は中身で別の項目になる
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/t"
cp -r src/compiler/. "$W/t/"
cp -r src/std "$W/t/std"
f=$W/t/app/cmd_check.sober
sed -i 's|^    for i <- iter.Range(0, len(p.contract_files)) {$|    for i <- iter.Range(0, 0) {|' "$f"
cmp -s "$f" src/compiler/app/cmd_check.sober && { echo "doublesmut: FAIL the mutation did not apply (update scripts/doublesmut.sh)"; exit 1; }
( cd "$W/t" && ulimit -s unlimited && SOBER_WORKERS=8 "$ROOT/out/stage2/sober2" build app --emit=elf --passes -o "$W/sober" ) > /dev/null 2> "$W/b.err" ||
    { echo "doublesmut: FAIL build: $(head -c 300 "$W/b.err")"; exit 1; }
chmod +x "$W/sober"
SOBER=$W/sober scripts/doubles.sh > "$W/out" 2>&1
fs=$(grep '^FAIL' "$W/out")
if [ "$fs" = "FAIL: the replay did not see the real package change" ]; then
    echo "doublesmut: caught — $fs"
else
    echo "doublesmut: FAIL the mutant was not caught by ⑥ alone"; grep '^FAIL' "$W/out" | head -5; exit 1
fi
