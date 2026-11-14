#!/usr/bin/env bash
# 後段の関数キャッシュの2プロセスの検査（段階3 R3-c — report-1194 6 節4・report-1202）: 1つの格納場所を2つのbuildが同時に使っても、どの
# buildのELFもキャッシュなしと一致し、格納場所の全部のパックの索引と値の検査和が通ること（SOBER_CACHE_FSCK=1 — lower/bcache.soberのbcFsck）。
#   r1 = 同じ世代へ同時に 2 本（冷 — 同じ鍵を同時に書く）
#   r2 = 書きと読み（温めた格納場所のコピーに、編集した木のbuild〔外れを書く〕と元の木のbuild〔読む〕を0〜4秒ずらして同時に — 5回）
#   r4 = 書きの途中のkill -9（冷のbuildを3 / 6 / 9秒で殺す）+ 書きかけの一時ファイルと途中で切れたパックを置いた格納場所で温のbuild — 読みが
#        壊れない（切れたパックは飛ばす — fsck が bad-packs=1 と数える）
#        + 掃除が古い一時ファイルを拾う（年齢10分未満は残し、古くした後のbuildの後はtmp=0 — 段階3 R4-b）
#   r5 = 別のパス（長い別パスのコピー + 絶対パスのentry）から同じ格納場所へ同時に2本
#   r3 = 併合中の読み（段階3 R4-b）: パックを33本にした世代で、併合するbuildと読むbuild 2本を0〜2秒ずらして同時に × 3 — どれもELF ≡ off・
#        併合の後の fsck が緑でパックが 1 本に減る・併合の後の温が全部当たり
#   r6 = 掃除（段階3 R4-b — 世代の鍵はSOBER_SELF_KEYで偽の世代を作る）: 世代の数の上限値（SOBER_CACHE_GENS=2で3世代 → 最古が消え今の世代は残る）・
#        大きさの上限値（SOBER_CACHE_MAX=1 MiBを越える古い世代が消える）・世代の中のゴミの上限値（SOBER_CACHE_FLOOR=1 MiBを越えた今の世代を捨て、次は冷）・
#        隠した世代の残りを消す・`sober cache gc` の明示・build × gc の同時（gc が読みかけの世代を消しても build の ELF ≡ off — × 4）
# 小さい題材（r3 / r6）はexamples/http_hello.sober（std/httpを引く — 格納場所の値が数MB）
# wallは判断に使わない（ELFの一致と検査の数だけ見る）。使い方: scripts/incrrace.sh — 約4分
set -uo pipefail
# 答えの再生は切る（この検査は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
C=${INCR_COMPILER:-$ROOT/out/stage2/sober2}
W=$(mktemp -d)
trap 'kill $(jobs -p) 2> /dev/null; rm -rf "$W"' EXIT
# gatesのSOBER_VERIFY=each（ステージごとのIRの検証器）はキャッシュのパスに入らない — 検査はキャッシュのパスそのものを見るので外す
unset SOBER_SELF_KEY SOBER_CACHE_VERIFY SOBER_BUILD_CACHE SOBER_VERIFY
# 基準（off）のbuildは切のパス（キャッシュは既定on — 格納場所のbuildはSOBER_BUILD_CACHE=1を明示する）
export SOBER_BUILD_CACHE=0
export SOBER_HASH_SEED=0
ulimit -s unlimited
A=$W/a/compiler
B=$W/alt/a/much/longer/path/than/before/compiler
E=$W/e/compiler
mkdir -p "$W/a" "$W/e" "$(dirname "$B")"
cp -r src/compiler "$A"
cp -r src/std "$A/std"
cp -r "$A" "$B"
cp -r "$A" "$E"
sed -i '0,/^    return nil$/s//    _ = 0\n    return nil/' "$E/lower/lower.sober"
cmp -s "$A/lower/lower.sober" "$E/lower/lower.sober" && { echo "incrrace: FAIL the edit did not apply"; exit 1; }
bad=0
( cd "$A" && SOBER_WORKERS=8 "$C" build app --emit=elf --passes -o "$W/offA.elf" > /dev/null 2>&1 ) || { echo "incrrace: FAIL off build"; exit 1; }
( cd "$E" && SOBER_WORKERS=8 "$C" build app --emit=elf --passes -o "$W/offE.elf" > /dev/null 2>&1 ) || { echo "incrrace: FAIL off build (edited)"; exit 1; }
# b <格納場所> <木> <entry> <W> <出力> — 温 / 冷のbuild（終了コードを返す）
b() {
    ( cd "$2" && SOBER_CACHE=$1 SOBER_BUILD_CACHE=1 SOBER_WORKERS=$4 "$C" build "$3" --emit=elf --passes -o "$5" > /dev/null 2> "$5.err" )
}
# same <名前> <基準> <出力> <終了コード>
same() {
    if [ "$4" != 0 ] || ! cmp -s "$2" "$3"; then echo "incrrace: FAIL $1 (exit $4): $(grep -m1 . "$3.err" 2> /dev/null)"; bad=1; fi
}
# fsck <名前> <格納場所> <期待するbad-packs>
fsck() {
    ( cd "$A" && SOBER_CACHE=$2 SOBER_BUILD_CACHE=1 SOBER_CACHE_FSCK=1 SOBER_WORKERS=8 "$C" build app --emit=elf --passes -o "$W/fsck.elf" > /dev/null 2> "$W/fsck.err" )
    local l
    l=$(grep -m1 'cache: fsck' "$W/fsck.err")
    echo "incrrace $1: ${l#cache: }"
    case "$l" in
        *"bad-packs=$3 "*"bad-entries=0 "*) ;;
        *) echo "incrrace: FAIL $1 fsck (expected bad-packs=$3, bad-entries=0)"; bad=1 ;;
    esac
    case "$l" in *" packs=0 "*) echo "incrrace: FAIL $1 fsck saw no packs"; bad=1 ;; esac
    cmp -s "$W/offA.elf" "$W/fsck.elf" || { echo "incrrace: FAIL $1 fsck build ELF"; bad=1; }
}
gen() { ls -d "$1"/sober-build-1/*/ 2> /dev/null | head -1; }
# r1: 同じ世代へ同時に 2 本（冷）
b "$W/c1" "$A" app 8 "$W/r1a.elf" & p1=$!
b "$W/c1" "$A" app 1 "$W/r1b.elf" & p2=$!
wait $p1; e1=$?; wait $p2; e2=$?
same r1-a "$W/offA.elf" "$W/r1a.elf" $e1
same r1-b "$W/offA.elf" "$W/r1b.elf" $e2
fsck r1 "$W/c1" 0
# r2: 書きと読み（温めた格納場所のコピーごとに0〜4秒ずらす）
b "$W/c2base" "$A" app 8 "$W/r2w.elf" || { echo "incrrace: FAIL r2 warm-up"; exit 1; }
for d in 0 1 2 3 4; do
    rm -rf "$W/c2"; cp -r "$W/c2base" "$W/c2"
    b "$W/c2" "$E" app 8 "$W/r2e.elf" & p1=$!
    sleep "$d"
    b "$W/c2" "$A" app 1 "$W/r2a.elf" & p2=$!
    wait $p1; e1=$?; wait $p2; e2=$?
    same "r2-write+$d" "$W/offE.elf" "$W/r2e.elf" $e1
    same "r2-read+$d" "$W/offA.elf" "$W/r2a.elf" $e2
done
fsck r2 "$W/c2" 0
# r4: 書きの途中の kill -9 + 書きかけの一時ファイル・途中で切れたパック
for t in 3 6 9; do
    ( cd "$A" && exec env SOBER_CACHE=$W/c4 SOBER_BUILD_CACHE=1 SOBER_WORKERS=8 "$C" build app --emit=elf --passes -o "$W/r4k.elf" > /dev/null 2>&1 ) & pk=$!
    sleep "$t"
    kill -9 $pk 2> /dev/null
    wait $pk 2> /dev/null
done
b "$W/c4" "$A" app 8 "$W/r4w.elf"; same r4-after-kill "$W/offA.elf" "$W/r4w.elf" $?
g=$(gen "$W/c4")
[ -n "$g" ] || { echo "incrrace: FAIL r4 no generation directory"; exit 1; }
pk1=$(ls "$g"*.pack | head -1)
printf 'half-written' > "$g/1-deadbeef.pack.tmp"
head -c 4000 "$pk1" > "$g/2-truncated.pack"
b "$W/c4" "$A" app 1 "$W/r4t.elf"; same r4-with-junk "$W/offA.elf" "$W/r4t.elf" $?
fsck r4 "$W/c4" 1
# r4 の続き（④ — 掃除が書きかけの一時ファイルを拾う）: 置いたばかりの一時ファイルは残す（走っている書き手のものかもしれない）・10 分より古くすると消える
grep -q 'tmp=1$' "$W/fsck.err" || { echo "incrrace: FAIL r4 a fresh tmp was removed (or not counted)"; bad=1; }
touch -d '1 hour ago' "$g/1-deadbeef.pack.tmp"
b "$W/c4" "$A" app 8 "$W/r4s.elf"; same r4-sweep "$W/offA.elf" "$W/r4s.elf" $?
[ -e "$g/1-deadbeef.pack.tmp" ] && { echo "incrrace: FAIL r4 the stale tmp was not swept"; bad=1; }
fsck r4-swept "$W/c4" 1
grep -q 'tmp=0$' "$W/fsck.err" || { echo "incrrace: FAIL r4-swept tmp != 0"; bad=1; }
# r5: 別のパスから同じ格納場所へ同時に2本（冷）
b "$W/c5" "$A" app 8 "$W/r5a.elf" & p1=$!
b "$W/c5" "$B" "$B/app" 8 "$W/r5b.elf" & p2=$!
wait $p1; e1=$?; wait $p2; e2=$?
same r5-rel "$W/offA.elf" "$W/r5a.elf" $e1
same r5-alt-abs "$W/offA.elf" "$W/r5b.elf" $e2
fsck r5 "$W/c5" 0
# ── 小さい題材の検査（r3 / r6）──
H=$ROOT/examples/http_hello.sober
"$C" build "$H" --emit=elf --passes -o "$W/offH.elf" > /dev/null 2>&1 || { echo "incrrace: FAIL off build (small)"; exit 1; }
# h <格納場所> <世代の鍵> <出力> [環境…] — 小さい題材のbuild（終了コードを返す）
h() {
    local c=$1 k=$2 o=$3
    shift 3
    env SOBER_CACHE="$c" SOBER_BUILD_CACHE=1 SOBER_SELF_KEY="$k" SOBER_CACHE_STAT=1 "$@" "$C" build "$H" --emit=elf --passes -o "$o" > /dev/null 2> "$o.err"
}
K0=0000000000000000k
# hfsck <名前> <格納場所> <鍵> — 小さい題材でfsck（bad 0）の行を返す
hfsck() {
    h "$2" "$3" "$W/hf.elf" SOBER_CACHE_FSCK=1
    local l
    l=$(grep -m1 'cache: fsck' "$W/hf.elf.err")
    echo "incrrace $1: ${l#cache: }"
    case "$l" in *"bad-packs=0 "*"bad-entries=0 "*) ;; *) echo "incrrace: FAIL $1 fsck"; bad=1 ;; esac
}
# r3: 併合中の読み
h "$W/c3base" $K0 "$W/r3w.elf" || { echo "incrrace: FAIL r3 warm-up"; exit 1; }
g3=$W/c3base/sober-build-1/0000000000000000
p3=$(ls "$g3"/*.pack | head -1)
sz=$(stat -c %s "$p3")
for n in $(seq 1 32); do cp "$p3" "$g3/$n-c0py-$sz.pack"; done
for d in 0 1 2; do
    rm -rf "$W/c3"; cp -r "$W/c3base" "$W/c3"
    h "$W/c3" $K0 "$W/r3m.elf" SOBER_WORKERS=8 & p1=$!
    sleep "0.$((d * 4))"
    h "$W/c3" $K0 "$W/r3a.elf" SOBER_WORKERS=1 & p2=$!
    h "$W/c3" $K0 "$W/r3b.elf" SOBER_WORKERS=8 & p3=$!
    wait $p1; e1=$?; wait $p2; e2=$?; wait $p3; e3=$?
    same "r3-merge+$d" "$W/offH.elf" "$W/r3m.elf" $e1
    same "r3-read-a+$d" "$W/offH.elf" "$W/r3a.elf" $e2
    same "r3-read-b+$d" "$W/offH.elf" "$W/r3b.elf" $e3
    np=$(ls "$W/c3/sober-build-1/0000000000000000"/*.pack | wc -l)
    [ "$np" -le 3 ] || { echo "incrrace: FAIL r3+$d no merge ($np packs)"; bad=1; }
done
hfsck r3 "$W/c3" $K0
h "$W/c3" $K0 "$W/r3h.elf"; same r3-after "$W/offH.elf" "$W/r3h.elf" $?
grep -q 'put=0 ' "$W/r3h.elf.err" || { echo "incrrace: FAIL r3 not all hits after the merge: $(grep -m1 '^cache: alpha' "$W/r3h.elf.err")"; bad=1; }
# r6: 掃除
C6=$W/c6
R6=$C6/sober-build-1
h "$C6" 1111111111111111k "$W/r6.elf" SOBER_CACHE_GENS=2; same r6-g1 "$W/offH.elf" "$W/r6.elf" $?
sleep 1
h "$C6" 2222222222222222k "$W/r6.elf" SOBER_CACHE_GENS=2; same r6-g2 "$W/offH.elf" "$W/r6.elf" $?
mkdir -p "$R6/.1111111111111111.dead-1-ab"; printf z > "$R6/.1111111111111111.dead-1-ab/f"
sleep 1
h "$C6" 3333333333333333k "$W/r6.elf" SOBER_CACHE_GENS=2; same r6-g3 "$W/offH.elf" "$W/r6.elf" $?
[ -d "$R6/1111111111111111" ] && { echo "incrrace: FAIL r6 the oldest generation survived the gens line"; bad=1; }
[ -d "$R6/2222222222222222" ] && [ -d "$R6/3333333333333333" ] || { echo "incrrace: FAIL r6 a young generation was dropped"; bad=1; }
[ -e "$R6/.1111111111111111.dead-1-ab" ] && { echo "incrrace: FAIL r6 a hidden generation was left"; bad=1; }
# 大きさの上限値: 古い世代（2222）を1 MiB超に膨らませてSOBER_CACHE_MAX=1で今の世代（3333）をbuild → 2222が消える
p6=$(ls "$R6/2222222222222222"/*.pack | head -1); sz=$(stat -c %s "$p6")
n=0; while [ "$(du -sb "$R6/2222222222222222" | awk '{ print $1 }')" -le 1100000 ]; do n=$((n + 1)); cp "$p6" "$R6/2222222222222222/$n-c0py-$sz.pack"; done
h "$C6" 3333333333333333k "$W/r6.elf" SOBER_CACHE_MAX=1; same r6-max "$W/offH.elf" "$W/r6.elf" $?
[ -d "$R6/2222222222222222" ] && { echo "incrrace: FAIL r6 the size line did not drop the old generation"; bad=1; }
[ -d "$R6/3333333333333333" ] || { echo "incrrace: FAIL r6 the size line dropped the current generation"; bad=1; }
# 世代の中のゴミの上限値: 今の世代（3333）をmax(満杯 × 4, 1 MiB) 超に膨らませてSOBER_CACHE_FLOOR=1 → 世代ごと捨てる・次のbuildは冷（put > 0）でELF ≡ off
p6=$(ls "$R6/3333333333333333"/*.pack | head -1); sz=$(stat -c %s "$p6")
full=$(od -An -t d8 -N 8 "$R6/3333333333333333/.full" | tr -d ' ')
lim=$(( 4 * full > 1048576 ? 4 * full : 1048576 ))
n=0; while [ "$(du -sb "$R6/3333333333333333" | awk '{ print $1 }')" -le $((lim + 65536)) ]; do n=$((n + 1)); cp "$p6" "$R6/3333333333333333/$n-c0py-$sz.pack"; done
h "$C6" 3333333333333333k "$W/r6.elf" SOBER_CACHE_FLOOR=1; same r6-floor "$W/offH.elf" "$W/r6.elf" $?
[ -d "$R6/3333333333333333" ] && { echo "incrrace: FAIL r6 the garbage line did not drop the generation"; bad=1; }
h "$C6" 3333333333333333k "$W/r6.elf"; same r6-after-floor "$W/offH.elf" "$W/r6.elf" $?
grep -q 'put=0 ' "$W/r6.elf.err" && { echo "incrrace: FAIL r6 the build after the drop was not cold"; bad=1; }
# `sober cache gc` の明示（SOBER_CACHE_GENS=1・今の鍵 4444 の世代は無い — 新しい 2222 だけが残り 3333 が消える）
h "$C6" 2222222222222222k "$W/r6.elf"
SOBER_CACHE=$C6 SOBER_SELF_KEY=4444444444444444k SOBER_CACHE_GENS=1 "$C" cache gc > "$W/r6gc.out" 2>&1 || { echo "incrrace: FAIL r6 cache gc exit"; bad=1; }
grep -q 'dropped [1-9]' "$W/r6gc.out" || { echo "incrrace: FAIL r6 cache gc dropped nothing: $(head -3 "$W/r6gc.out")"; bad=1; }
[ "$(ls -A "$R6" | grep -v '^\.now$' | tr '\n' ' ')" = "2222222222222222 " ] || { echo "incrrace: FAIL r6 cache gc should keep only the newest generation: $(ls -A "$R6" | tr '\n' ' ')"; bad=1; }
# build × gc の同時: 古い鍵（5555）の build が走っている間に、今の鍵（6666）の gc が 5555 を消す — build は壊れない
for d in 0 1 2 3; do
    rm -rf "$C6"; h "$C6" 5555555555555555k "$W/r6w.elf" || { echo "incrrace: FAIL r6 warm-up"; bad=1; }
    h "$C6" 5555555555555555k "$W/r6r.elf" & p1=$!
    sleep "0.$((d * 3))"
    SOBER_CACHE=$C6 SOBER_SELF_KEY=6666666666666666k SOBER_CACHE_GENS=1 "$C" cache gc > /dev/null 2>&1
    wait $p1; same "r6-build-x-gc+$d" "$W/offH.elf" "$W/r6r.elf" $?
done
hfsck r6 "$C6" 5555555555555555k
echo "incrrace: r1 r2(×5) r4(+sweep) r5 r3(×3) r6, fail=$bad"
exit $bad
