#!/usr/bin/env bash
# sober watch の網（便 2 R3 — report-1266）: watch の道（一括の check + 関数単位キャッシュ〔切り口 D〕）の差分の出力（watchReport の形 — `+ 行`・`- 行`・
# `watch: …`）を黄金 testdata/watchcheck/expect.txt と照合する。編集の列 = 受理 → 脱糖の拒否 → 検査器の拒否 → 直す → 同じ拒否をもう一度（拒否の値の当たり）
# → 直す。各周の `watch:` の行が出るのを待ってから次の編集を当てる（時間で待たない）。周ごとの当否（SOBER_CACHE_STAT）は照合の外で、最後の 2 周が
# 当たりであることだけ見る。使い方: scripts/watchcheck.sh [--regen]
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
C=${WATCH_COMPILER:-$ROOT/out/stage2/sober2}
G=$ROOT/testdata/watchcheck/expect.txt
W=$(mktemp -d)
trap 'kill $P 2>/dev/null; rm -rf "$W"' EXIT
P=""
unset SOBER_CHECK_CACHE SOBER_CACHE_VERIFY SOBER_SELF_KEY SOBER_VERIFY SOBER_CHECK_REPLAY
export SOBER_BUILD_CACHE=0
cat > "$W/main.sober" <<'SRC'
package main

func a(x int) int {
    return x + 1
}

func b(x int) int {
    return a(x) * 2
}

func main() {
    println(b(1))
}
SRC
( cd "$W" && SOBER_CACHE=$W/cc SOBER_WATCH_MS=20 SOBER_CACHE_STAT=1 exec "$C" watch main.sober ) 2> "$W/w.err" &
P=$!
# waitn <n>: `watch:` の行が n 本になるまで待つ（60 秒で打ち切り — 単独では 1 回 0.1〜0.15 s・負荷の窓の余裕）
waitn() {
    local i=0
    while [ "$(grep -c '^watch:' "$W/w.err")" -lt "$1" ]; do
        i=$((i + 1))
        if [ $i -gt 1200 ] || ! kill -0 $P 2>/dev/null; then echo "watchcheck: FAIL no round $1"; cat "$W/w.err"; exit 1; fi
        sleep 0.05
    done
}
n=1
waitn $n
for e in 's|return x + 1|return len("s")|' 's|return len("s")|return x + "a"|' 's|return x + "a"|return x + 1|' 's|return x + 1|return len("s")|' 's|return len("s")|return x + 1|'; do
    # 更新時刻の粒度を跨ぐ（同じ秒の書き換えを取りこぼさない — ModTime は ns）
    sed -i "$e" "$W/main.sober"
    n=$((n + 1))
    waitn $n
done
kill $P 2>/dev/null
grep -v '^cache: check-' "$W/w.err" > "$W/got.txt"
if [ "${1:-}" = --regen ]; then cp "$W/got.txt" "$G"; echo "watchcheck: regen $G"; exit 0; fi
st=$(grep '^cache: check-def' "$W/w.err" | tail -2 | awk '{ split($3, a, "/"); printf "%s ", (a[1] == a[2] ? "hit" : "miss") }')
if ! cmp -s "$G" "$W/got.txt"; then
    echo "watchcheck: FAIL output differs"
    diff "$G" "$W/got.txt" | head -20
    exit 1
fi
if [ "$st" != "hit hit " ]; then
    echo "watchcheck: FAIL the last 2 rounds are not cache hits ($st)"
    grep '^cache: check-def' "$W/w.err"
    exit 1
fi
# 問い合わせ側（答えの再生）: watch の最後の回の後、素の `sober check main.sober` が同じ置き場で再生に当たり、置き場なしの check と同じ答えを返す。
# 続けて watch の居ない編集（中身の変化）の後は外れて、やはり置き場なしと同じ答え
query() { # query <名前> <当否の期待>
    ( cd "$W" && SOBER_CACHE=$W/cc SOBER_CACHE_STAT=1 "$C" check main.sober ) > "$W/q.out" 2> "$W/q.err"
    echo "exit=$?" >> "$W/q.out"
    ( cd "$W" && SOBER_CACHE= "$C" check main.sober ) > "$W/r.out" 2> "$W/r.err"
    echo "exit=$?" >> "$W/r.out"
    grep -v '^cache: ' "$W/q.err" >> "$W/q.out"
    cat "$W/r.err" >> "$W/r.out"
    grep -q "^cache: check-replay $2\$" "$W/q.err" || { echo "watchcheck: FAIL query $1: want check-replay $2"; grep '^cache: check-replay' "$W/q.err"; exit 1; }
    cmp -s "$W/q.out" "$W/r.out" || { echo "watchcheck: FAIL query $1: the answer differs from a check without the cache"; diff "$W/r.out" "$W/q.out" | head -6; exit 1; }
}
query after-watch 1/1
echo '// edited without watch' >> "$W/main.sober"
query after-edit 0/1
query again 1/1
# ディレクトリの entry（package main のディレクトリ）: ファイルを足すと閉包が変わる — 足した後の問い合わせは外れて、足したファイルの拒否を返す
mkdir -p "$W/pkg"
printf 'package main\n\nfunc main() {\n    println(1)\n}\n' > "$W/pkg/a.sober"
dquery() { # dquery <名前> <当否の期待>
    ( cd "$W" && SOBER_CACHE=$W/cc SOBER_CACHE_STAT=1 "$C" check pkg ) > "$W/q.out" 2> "$W/q.err"
    echo "exit=$?" >> "$W/q.out"
    ( cd "$W" && SOBER_CACHE= "$C" check pkg ) > "$W/r.out" 2> "$W/r.err"
    echo "exit=$?" >> "$W/r.out"
    grep -v '^cache: ' "$W/q.err" >> "$W/q.out"
    cat "$W/r.err" >> "$W/r.out"
    grep -q "^cache: check-replay $2\$" "$W/q.err" || { echo "watchcheck: FAIL dir query $1: want check-replay $2"; grep '^cache: check-replay' "$W/q.err"; exit 1; }
    cmp -s "$W/q.out" "$W/r.out" || { echo "watchcheck: FAIL dir query $1: the answer differs from a check without the cache"; diff "$W/r.out" "$W/q.out" | head -6; exit 1; }
}
dquery first 0/1
dquery warm 1/1
printf 'package main\n\nfunc b() int {\n    return len("s")\n}\n' > "$W/pkg/b.sober"
dquery added-file 0/1
# 鍵の環境変数: 宣言済みの開発の口（答えは変えない SOBER_TYORDER）を立てた問い合わせは別の鍵 — 外れる
( cd "$W" && SOBER_TYORDER=1 SOBER_CACHE=$W/cc SOBER_CACHE_STAT=1 "$C" check pkg ) > /dev/null 2> "$W/q.err"
grep -q '^cache: check-replay 0/1$' "$W/q.err" || { echo "watchcheck: FAIL env query: a declared environment variable is not in the replay key"; grep '^cache: check-replay' "$W/q.err"; exit 1; }
# build の再生と watch の温め（build のキャッシュを入れて）: 素の build は 2 回目で再生に当たり、ELF は置き場なしの build とバイト一致。
# watch は受理の回の後に子プロセスで build を温める — 温めが済んだ後の素の build は 1 回目から当たる
( cd "$W" && SOBER_BUILD_CACHE=0 SOBER_CHECK_CACHE=0 "$C" build pkg -o fresh.elf ) > /dev/null 2>&1
rm -f "$W/pkg/b.sober"
( cd "$W" && SOBER_BUILD_CACHE=0 SOBER_CHECK_CACHE=0 "$C" build pkg -o fresh.elf ) > /dev/null 2>&1 || { echo "watchcheck: FAIL fresh build"; exit 1; }
for want in 0/1 1/1; do
    ( cd "$W" && SOBER_BUILD_CACHE=1 SOBER_CACHE=$W/cb SOBER_CACHE_STAT=1 "$C" build pkg -o q.elf ) > /dev/null 2> "$W/b.err"
    grep -q "^cache: build-replay $want\$" "$W/b.err" || { echo "watchcheck: FAIL build query: want build-replay $want"; grep '^cache: build-replay' "$W/b.err"; exit 1; }
    cmp -s "$W/q.elf" "$W/fresh.elf" || { echo "watchcheck: FAIL build query ($want): the ELF differs from a build without the cache"; exit 1; }
done
mkdir -p "$W/pkg2"
cp "$W/pkg/a.sober" "$W/pkg2/a.sober"
( cd "$W" && SOBER_BUILD_CACHE=1 SOBER_CACHE=$W/cw SOBER_WATCH_MS=20 exec "$C" watch pkg2 ) 2> "$W/w2.err" &
P=$!
i=0
while ! grep -q '^watch:' "$W/w2.err"; do i=$((i + 1)); [ $i -gt 1200 ] && { echo "watchcheck: FAIL warm watch: no round"; exit 1; }; sleep 0.05; done
G=$(ls -d "$W"/cw/sober-build-1/*/ | head -1)
i=0
# 温めの列の終わり = 進み（watch/<id>.warm）に、pid のファイルに書かれた列の `done <pid>` が出る
until wp=$(cat "$G"/watch/*.pid 2> /dev/null) && [ -n "$wp" ] && grep -qx "done $wp" "$G"/watch/*.warm 2> /dev/null; do i=$((i + 1)); [ $i -gt 1200 ] && { echo "watchcheck: FAIL warm watch: the warm build did not finish"; exit 1; }; sleep 0.05; done
kill $P 2> /dev/null
( cd "$W" && SOBER_BUILD_CACHE=1 SOBER_CACHE=$W/cw SOBER_CACHE_STAT=1 "$C" build pkg2 -o q2.elf ) > /dev/null 2> "$W/b.err"
grep -q '^cache: build-replay 1/1$' "$W/b.err" || { echo "watchcheck: FAIL warm watch: the first build after watch did not replay"; grep '^cache: build-replay' "$W/b.err"; exit 1; }
cmp -s "$W/q2.elf" "$W/fresh.elf" || { echo "watchcheck: FAIL warm watch: the ELF differs from a build without the cache"; exit 1; }
echo "watchcheck: $n rounds match testdata/watchcheck/expect.txt, last 2 rounds hit · the query replays the watch's answer · build replays and watch warms it"
