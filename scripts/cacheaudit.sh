#!/usr/bin/env bash
# 扉の監査の網（段 3 R3 — report-1194 4 節 3・report-1200）: 後段の関数キャッシュの関数ごとの作り直し（α = B1・β1 = B2・β2 = x86）が、鍵に入れた
# 相手の外の事実を読まないこと（`SOBER_CACHE_VERIFY=2` — lower/bcache.sober の bcAud*）。扉 = lFnRet（呼び先の戻りの型）・xRegCc（番地を取られる印）・
# x86 の読み口 xg（ヒープの読み全部）。xg の記録は木に書かない（遅い道は凍結の前のパスで熱い — 分岐 1 つで off の自己 build +0.49 G）ので、この網が
# 木の写しの xg の遅い道に `if st.bcAud { bcAudHeap(mut st, i) }` を差し込んだ監査用のコンパイラを stage2 で建てる（差し込めなければ落ちる）。
# 判定 = 自己 build（W1）と例題 + bench の題材で、はみ出し 0（`cache: undeclared read …` が出ない）・`heap=on`（差し込みが効いた）・ELF が同じ
# コンパイラのキャッシュなしとバイト一致。
# 母集団: 自己 build + examples（既定は 4 本に 1 本 — 並びの添字 mod 4 = 0・`--every` で全数）+ bench の題材（全部）
# 使い方: scripts/cacheaudit.sh [--every]
set -uo pipefail
# 答えの再生は切る（この網は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
every=0
for a in "$@"; do
    case "$a" in
        --every) every=1 ;;
        *) echo "cacheaudit: unknown argument $a" >&2; exit 2 ;;
    esac
done
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
mkdir -p "$W/tree"
cp -r src/compiler/. "$W/tree/"
cp -r src/std "$W/tree/std"
# 監査用のコンパイラ: xg の遅い道（凍らせた表の速い道の後の HeapGet）に記録を差し込む
node -e '
const fs = require("fs");
const p = process.argv[1];
const s = fs.readFileSync(p, "utf8");
const old = "        return st.hf.chunks[k][i & (table.CHUNK - 1)]\n    }\n    return desugar.HeapGet(mut st.d, i)\n}";
if (s.split(old).length !== 2) { console.error("cacheaudit: the xg slow path in lower/x86.sober changed — update the patch"); process.exit(1); }
fs.writeFileSync(p, s.replace(old, "        return st.hf.chunks[k][i & (table.CHUNK - 1)]\n    }\n    if st.bcAud {\n        bcAudHeap(mut st, i)\n    }\n    return desugar.HeapGet(mut st.d, i)\n}"));' "$W/tree/lower/x86.sober" || exit 1
ulimit -s unlimited
# gates の SOBER_VERIFY=each（段ごとの IR の検証器）はキャッシュの道に入らない — 網はキャッシュの道そのものを見るので外す
unset SOBER_SELF_KEY SOBER_VERIFY
C=$W/audit-sober
( cd "$W/tree" && SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$C" > /dev/null 2> "$W/build.err" ) || { echo "cacheaudit: FAIL building the audit compiler"; cat "$W/build.err"; exit 1; }
export SOBER_HASH_SEED=0 SOBER_WORKERS=1 SOBER_CACHE_STAT=1
bad=0
# 1 題材: $1 = 名前・$2 = cwd・$3 = entry（cwd からの相対）。置き場は題材ごとに空から（監査は検証モードを含む — 当たりでも作り直す）
one() {
    local name=$1 dir=$2 src=$3
    rm -rf "$W/c"
    ( cd "$dir" && timeout 300 "$C" build "$src" --emit=elf --passes -o "$W/off.elf" > /dev/null 2>&1 ) || return 2
    ( cd "$dir" && SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=2 timeout 600 "$C" build "$src" --emit=elf --passes -o "$W/aud.elf" > /dev/null 2> "$W/aud.err" )
    local ec=$? und
    und=$(grep -c 'undeclared read' "$W/aud.err")
    if [ "$und" != 0 ]; then
        echo "cacheaudit: FAIL $name — $und undeclared reads:"; grep 'undeclared read' "$W/aud.err" | head -20; return 1
    fi
    if [ "$ec" != 0 ]; then echo "cacheaudit: FAIL $name — exit $ec: $(grep -m1 . "$W/aud.err")"; return 1; fi
    if ! grep -q 'cache: audit ok .*heap=on' "$W/aud.err"; then echo "cacheaudit: FAIL $name — no 'audit ok … heap=on' line: $(grep -m1 'cache: audit' "$W/aud.err")"; return 1; fi
    if ! cmp -s "$W/off.elf" "$W/aud.elf"; then echo "cacheaudit: FAIL $name — ELF differs from the build without the cache"; return 1; fi
    [ "$name" = self ] && echo "cacheaudit: self $(grep 'cache: audit ok' "$W/aud.err")"
    return 0
}
one self "$W/tree" app || bad=1
n=0
k=0
for f in examples/*.sober bench/*/main.sober; do
    case "$f" in
        examples/*) if [ "$every" = 0 ] && [ $((k % 4)) != 0 ]; then k=$((k + 1)); continue; fi; k=$((k + 1)) ;;
    esac
    one "$f" "$ROOT" "$f"
    r=$?
    [ "$r" = 2 ] && continue   # キャッシュなしで建たない題材（負例・入力の要る題材）は数えない
    [ "$r" = 0 ] || bad=1
    n=$((n + 1))
done
echo "cacheaudit: self + $n entries, fail=$bad"
exit $bad
