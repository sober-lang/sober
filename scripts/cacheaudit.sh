#!/usr/bin/env bash
# 扉の監査の検査（段階3 R3 — report-1194 4 節3・report-1200）: 後段の関数キャッシュの関数ごとの作り直し（α = B1・β1 = B2・β2 = x86）が、鍵に入れた
# 相手の外の事実を読まないこと（`SOBER_CACHE_VERIFY=2` — lower/bcache.soberのbcAud*）。扉 = lFnRet（呼び先の戻りの型）・xRegCc（番地を取られるフラグ）・
# x86の読みのインターフェースxg（ヒープの読み全部）。xgの記録は木に書かない（低速パスは凍結の前のパスで熱い — 分岐1つでoffの自己build +0.49 G）ので、この検査が
# 木のコピーのxgの低速パスに `if st.bcAud { bcAudHeap(mut st, i) }` を差し込んだ監査用のコンパイラをstage2でビルドする（差し込めなければ落ちる）。
# 判定 = 自己 build（W1）と例題 + bench の題材で、はみ出し 0（`cache: undeclared read …` が出ない）・`heap=on`（差し込みが効いた）・ELF が同じ
# コンパイラのキャッシュなしとバイト一致。
# 母集団: 自己 build + examples（既定は 4 本に 1 本 — 並びの添字 mod 4 = 0・`--every` で全数）+ bench の題材（全部）
# プログラムをまたぐ相: 題材の数本（CROSS_ES）を、stage2で1つの格納場所へ順に検証モード（=1）でビルドする。後の題材は、前の題材が書いた
# std・rtの関数の値に当たり、検証モードが当たりを作り直してバイトで比べる。判定 = staleが無い・ELFがキャッシュ無効と一致・
# 通常のモードで、別のプログラム（web_server_route）で温めた格納場所からweb_server_helloをビルドするとβ2（機械語）が当たる。
# 例題の全部を1つの格納場所へ通す形は scripts/cachecross.sh（ゲートの外。鍵を変える変更のときに手で回す）
# 使い方: scripts/cacheaudit.sh [--every]
set -uo pipefail
# 答えの再生は切る（この検査は関数単位キャッシュの当否を見る）
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
# 監査用のコンパイラ: xgの低速パス（凍らせた表の高速パスの後のHeapGet）に記録を差し込む
node -e '
const fs = require("fs");
const p = process.argv[1];
const s = fs.readFileSync(p, "utf8");
const old = "        return st.hf.chunks[k][i & (table.CHUNK - 1)]\n    }\n    return desugar.HeapGet(mut st.d, i)\n}";
if (s.split(old).length !== 2) { console.error("cacheaudit: the xg slow path in lower/x86.sober changed — update the patch"); process.exit(1); }
fs.writeFileSync(p, s.replace(old, "        return st.hf.chunks[k][i & (table.CHUNK - 1)]\n    }\n    if st.bcAud {\n        bcAudHeap(mut st, i)\n    }\n    return desugar.HeapGet(mut st.d, i)\n}"));' "$W/tree/lower/x86.sober" || exit 1
ulimit -s unlimited
# gatesのSOBER_VERIFY=each（フェーズごとのIRの検証器）はキャッシュのパスに入らない — 検査はキャッシュのパスそのものを見るので外す
unset SOBER_SELF_KEY SOBER_VERIFY
C=$W/audit-sober
( cd "$W/tree" && SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$C" > /dev/null 2> "$W/build.err" ) || { echo "cacheaudit: FAIL building the audit compiler"; cat "$W/build.err"; exit 1; }
export SOBER_HASH_SEED=0 SOBER_WORKERS=1 SOBER_CACHE_STAT=1
bad=0
# 1題材: $1 = 名前・$2 = cwd・$3 = entry（cwdからの相対）。配置先は題材ごとに空から（監査は検証モードを含む — 当たりでも作り直す）
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
# プログラムをまたぐ相（stage2そのもの。監査用のコンパイラは使わない）
CROSS_ES=(web_server_route web_server_hello http_arena utf8_bound json_encode)
rm -rf "$W/c"
for e in "${CROSS_ES[@]}"; do
    SOBER_BUILD_CACHE=0 timeout 120 "$S2" build "examples/$e.sober" -o "$W/off.elf" > /dev/null 2> "$W/x.err" || { echo "cacheaudit: FAIL cross $e — no build without the cache: $(grep -m1 . "$W/x.err")"; bad=1; continue; }
    SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=1 timeout 300 "$S2" build "examples/$e.sober" -o "$W/on.elf" > /dev/null 2> "$W/x.err"
    ec=$?
    if grep -q 'cache: stale entry' "$W/x.err"; then echo "cacheaudit: FAIL cross $e — $(grep -m1 'cache: stale entry' "$W/x.err")"; bad=1; continue; fi
    [ "$ec" = 0 ] || { echo "cacheaudit: FAIL cross $e — exit $ec: $(grep -m1 . "$W/x.err")"; bad=1; continue; }
    cmp -s "$W/off.elf" "$W/on.elf" || { echo "cacheaudit: FAIL cross $e — ELF differs from the build without the cache"; bad=1; }
done
rm -rf "$W/c"
for e in web_server_route web_server_hello; do
    SOBER_CACHE=$W/c SOBER_BUILD_CACHE=1 "$S2" build "examples/$e.sober" -o "$W/on.elf" > /dev/null 2> "$W/x.err" || { echo "cacheaudit: FAIL cross warm $e: $(grep -m1 . "$W/x.err")"; bad=1; }
done
cross=$(awk '/^cache: alpha/ { for (i = 2; i <= NF; i++) if ($i == "beta2") print $(i + 1) }' "$W/x.err")
cross=${cross:-0/0}
[ "${cross%/*}" -gt 0 ] || { echo "cacheaudit: FAIL cross — no beta2 hit from a store warmed by another program"; bad=1; }
echo "cacheaudit: self + $n entries, cross ${#CROSS_ES[@]} entries (beta2 $cross), fail=$bad"
exit $bad
