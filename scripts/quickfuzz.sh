#!/usr/bin/env bash
# std/quick の fuzz の駆動役（テストの実行ファイルの自己再実行）の網: testdata/quickfuzz/fz.sober の Check ごとに駆動役を走らせ、
#   - 稀な panic・ハング・性質の偽を見つけて縮めた報告（標準エラー）とコーパスの列が黄金 check<N>.stderr / check<N>.list と一致
#   - 二分探索が最初の死を当てた（報告の試行 K で、束の試行 [0, K−1) が通り [K−1, K) が死ぬ — ハングは期限の 142）
#   - スケジュールの軸（quick:sched — testdata/quickfuzz/fzsched.sober）: 軸なしは通り・軸ありは偽を見つけて `sched <種>` つきの列を書き、その列の再生で同じ偽
#   - カバレッジの誘導（quick:pool — testdata/quickfuzz/fzguide.sober を --cover で建てる）: 入れ子の 4 バイトの魔法値を、誘導つきは 40 万試行の中で見つけ
#     （報告が黄金 guide.stderr と一致 — 種の置き場を空から 2 回走らせて同じ）、誘導なしは同じ 40 万試行で見つけない
#   - コーパスの列の再生役が同じ panic で死ぬ・駆動役が試行の前にコーパスの列を再生して同じ失敗を名指す・失敗しない Check は期限まで回って exit 0
#   scripts/quickfuzz.sh            照合
#   scripts/quickfuzz.sh --regen    黄金を作り直す（差分を見てからコミット）
set -uo pipefail
cd "$(dirname "$0")/.."
SOBER=${SOBER:-./bin/sober}
D=testdata/quickfuzz
regen=0
[ "${1:-}" = "--regen" ] && regen=1
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
fail=0
bad() { echo "FAIL: $*"; fail=$((fail + 1)); }
"$SOBER" build "$D/fz.sober" -o "$W/fz" > "$W/build.log" 2>&1 || { echo "FAIL: build"; cat "$W/build.log"; exit 1; }
HANG=1000
for c in 0 1 2; do
    mkdir -p "$W/t$c" "$W/c$c"
    "$W/fz" quick:fuzz=60000 quick:check=$c quick:hang=$HANG quick:tmp="$W/t$c" quick:corpus="$W/c$c" quick:save > /dev/null 2> "$W/e$c" < /dev/null
    ec=$?
    [ "$ec" = 101 ] || bad "check $c: driver exit $ec (want 101)"
    f=$(ls "$W/c$c/main" 2> /dev/null | head -1)
    [ -n "$f" ] || { bad "check $c: no corpus file"; continue; }
    # コーパスのファイル名（<check>-<列のハッシュ>）と中身を 1 本の黄金に
    { echo "$f"; cat "$W/c$c/main/$f"; } > "$W/l$c"
    # 報告の中の作業場所のパスと std/quick の中の位置（std/quick を編集するたびに動く）は消す
    sed "s#$W/c$c#CORPUS#; s#at std/quick/[a-z_]*\.sober:[0-9]*:[0-9]*#at std/quick#" "$W/e$c" > "$W/s$c"
    if [ $regen = 1 ]; then
        cp "$W/s$c" "$D/check$c.stderr"; cp "$W/l$c" "$D/check$c.list"
    else
        cmp -s "$W/s$c" "$D/check$c.stderr" || { bad "check $c: stderr differs from $D/check$c.stderr"; diff "$D/check$c.stderr" "$W/s$c" | head -6; }
        cmp -s "$W/l$c" "$D/check$c.list" || { bad "check $c: corpus differs from $D/check$c.list"; diff "$D/check$c.list" "$W/l$c" | head -6; }
    fi
    # 二分探索: 報告の試行 K（1 始まり）の前の束は通り、K の試行だけで死ぬ
    k=$(sed -n 's/.* at trial \([0-9]*\) .*/\1/p' "$W/e$c" | head -1)
    if [ -n "$k" ]; then
        "$W/fz" quick:work=$c:0:0:$((k - 1)) quick:hang=$HANG > /dev/null 2>&1 < /dev/null
        e0=$?
        # ハングの試行は SIGALRM で死ぬ（シェルの「Alarm clock」の行は捨てる）
        { "$W/fz" quick:work=$c:0:$((k - 1)):$k quick:hang=$HANG > /dev/null 2>&1 < /dev/null; e1=$?; } 2> /dev/null
        [ "$e0" = 0 ] || bad "check $c: trials [0, $((k - 1))) exit $e0 (want 0 — the first death is earlier)"
        [ "$e1" != 0 ] || bad "check $c: trial $k passed alone"
    elif [ "$c" != 2 ]; then
        bad "check $c: no 'at trial K' in the report"
    fi
done
# コーパスの列の再生（Check 0 — 同じ panic の行で死ぬ）
f0=$(ls "$W/c0/main" 2> /dev/null | head -1)
if [ -n "$f0" ]; then
    "$W/fz" quick:replay=0:"$W/c0/main/$f0" > /dev/null 2> "$W/r0" < /dev/null
    ec=$?
    [ "$ec" = 101 ] || bad "replay of the corpus: exit $ec (want 101)"
    grep -q '^panic: index out of range at ' "$W/r0" || bad "replay of the corpus: not the same panic"
fi
# コーパスの回帰: 前に書いた列を試行の前に再生して同じ失敗を名指す（試行は回さない — 期限 1 ms でも見つかる）
for c in 0 2; do
    "$W/fz" quick:fuzz=1 quick:check=$c quick:hang=$HANG quick:tmp="$W/t$c" quick:corpus="$W/c$c" > /dev/null 2> "$W/k$c" < /dev/null
    ec=$?
    [ "$ec" = 101 ] || bad "corpus check $c: exit $ec (want 101)"
    grep -q "^quick: fuzz: [a-z]* in the corpus case $W/c$c/main/$c-" "$W/k$c" || { bad "corpus check $c: not found by the corpus"; head -3 "$W/k$c"; }
done
# 失敗しない Check: 期限まで回って exit 0
"$W/fz" quick:fuzz=300 quick:check=3 quick:tmp="$W/t3" > /dev/null 2> "$W/e3" < /dev/null
ec=$?
[ "$ec" = 0 ] || bad "check 3: exit $ec (want 0)"
grep -q '^quick: fuzz: [0-9]* trials, no failure (check 3, seed 0)$' "$W/e3" || { bad "check 3: no 'no failure' line"; head -3 "$W/e3"; }
# スケジュールの軸（testdata/quickfuzz/fzsched.sober — 2 つの task の書き足しの順）: 軸なし（ワーカー 1・既定のスケジュール）では通り、
# quick:sched で試行ごとの SOBER_SCHED_SEED を振ると偽を見つけ、コーパスの列に `sched <種>` を持たせる。その列は駆動役の再生で同じ偽を名指す
"$SOBER" build "$D/fzsched.sober" -o "$W/fzs" > "$W/build.log" 2>&1 || { echo "FAIL: build fzsched"; cat "$W/build.log"; exit 1; }
mkdir -p "$W/s"
( cd "$W/s" && SOBER_WORKERS=1 "$W/fzs" quick:fuzz=300 quick:tmp="$W/s/t" > /dev/null 2>&1 < /dev/null )
ec=$?
[ "$ec" = 0 ] || bad "fzsched without the schedule axis: exit $ec (want 0)"
( cd "$W/s" && SOBER_WORKERS=1 "$W/fzs" quick:fuzz=60000 quick:sched quick:tmp="$W/s/t" quick:corpus="$W/s/c" quick:save > /dev/null 2> "$W/se" < /dev/null )
ec=$?
[ "$ec" = 101 ] || bad "fzsched with the schedule axis: exit $ec (want 101)"
f=$(ls "$W/s/c/main" 2> /dev/null | head -1)
if [ -n "$f" ]; then
    { echo "$f"; cat "$W/s/c/main/$f"; } > "$W/sl"
    sed "s#$W/s/c#CORPUS#; s#at std/quick/[a-z_]*\.sober:[0-9]*:[0-9]*#at std/quick#" "$W/se" > "$W/ss"
    if [ $regen = 1 ]; then
        cp "$W/ss" "$D/sched.stderr"; cp "$W/sl" "$D/sched.list"
    else
        cmp -s "$W/ss" "$D/sched.stderr" || { bad "fzsched: stderr differs from $D/sched.stderr"; diff "$D/sched.stderr" "$W/ss" | head -6; }
        cmp -s "$W/sl" "$D/sched.list" || { bad "fzsched: corpus differs from $D/sched.list"; diff "$D/sched.list" "$W/sl" | head -6; }
    fi
    ( cd "$W/s" && SOBER_WORKERS=1 "$W/fzs" quick:fuzz=1 quick:tmp="$W/s/t" quick:corpus="$W/s/c" > /dev/null 2> "$W/sk" < /dev/null )
    ec=$?
    [ "$ec" = 101 ] || bad "fzsched corpus replay: exit $ec (want 101)"
    grep -q "^quick: fuzz: falsified in the corpus case $W/s/c/main/0-.* sched " "$W/sk" || { bad "fzsched corpus replay: not found with its schedule"; head -3 "$W/sk"; }
else
    bad "fzsched: no corpus file"
fi
# カバレッジの誘導（種の置き場は空から — 試行は種・番号・束の頭の種の列で決まるので 2 回とも同じ所で見つける）
"$SOBER" build "$D/fzguide.sober" --cover -o "$W/fg" > "$W/gbuild.log" 2>&1 || { bad "fzguide: build"; cat "$W/gbuild.log"; }
for i in 1 2; do
    mkdir -p "$W/gp$i"
    SOBER_QUICK_TRIALS=400000 "$W/fg" quick:fuzz=0 quick:pool="$W/gp$i" quick:tmp="$W/gt$i" > /dev/null 2> "$W/ge$i" < /dev/null
    ec=$?
    [ "$ec" = 101 ] || bad "fzguide (guided, run $i): exit $ec (want 101)"
    sed "s#at std/quick/[a-z_]*\.sober:[0-9]*:[0-9]*#at std/quick#" "$W/ge$i" > "$W/gs$i"
done
cmp -s "$W/gs1" "$W/gs2" || bad "fzguide: the two guided runs differ"
if [ $regen = 1 ]; then
    cp "$W/gs1" "$D/guide.stderr"
else
    cmp -s "$W/gs1" "$D/guide.stderr" || { bad "fzguide: stderr differs from $D/guide.stderr"; diff "$D/guide.stderr" "$W/gs1" | head -6; }
fi
SOBER_QUICK_TRIALS=400000 "$W/fg" quick:fuzz=0 quick:tmp="$W/gt3" > /dev/null 2>&1 < /dev/null
ec=$?
[ "$ec" = 0 ] || bad "fzguide (unguided): exit $ec (want 0 — the magic value is out of reach without guidance)"
[ $regen = 1 ] && echo "quickfuzz: regenerated $D/check{0,1,2}.{stderr,list}, $D/sched.{stderr,list} and $D/guide.stderr"
echo "quickfuzz: fail=$fail"
[ "$fail" = 0 ]
