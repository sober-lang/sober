#!/usr/bin/env bash
# `sober test` の結果の再生の網: 一時の package（テスト 2 本・testdata・環境変数のリテラルの読み）で、問い合わせの相ごとに
# 当否（SOBER_CACHE_STAT の `cache: test-replay …`）と印字（置き場なし〔SOBER_CHECK_REPLAY=0〕の印字とのバイト一致）を見る。
# 外れるべき相 = ソースの編集・.sober の追加・testdata の追加と編集・読む環境変数の値・SOBER_* の値・--run の違い・--fresh。
# 覚えない相 = 失敗のある package・リテラルでない環境変数の読み。使い方: scripts/testreplay.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S=$ROOT/out/stage2/sober2
W=$(mktemp -d)
trap 'rm -rf "$W"' EXIT
# 再生と温めを既定の道で見る（gates の検証の道〔SOBER_VERIFY=each〕・切の道は build の再生を通さない）
unset SOBER_CHECK_REPLAY SOBER_CACHE_VERIFY TR_NAME SOBER_VERIFY SOBER_BUILD_PAR SOBER_LOWER_SPLIT SOBER_CHECK_CACHE
export SOBER_CACHE=$W/cache SOBER_BUILD_CACHE=1
# ワーカー数は既定（コア数 — gates の SOBER_WORKERS=1 を外す）: M:N の親が書いたテストの実行ファイルを直後に走らせる道を網に入れる
unset SOBER_WORKERS
mkdir -p "$W/p/pkg/testdata" "$W/p/bad" "$W/p/dyn"
cd "$W/p"
cat > pkg/pkg.sober <<'SRC'
package pkg

func Add(a int, b int) int {
    return a + b
}
SRC
cat > pkg/pkg_test.sober <<'SRC'
package pkg

import "std/io"
import "std/os"

func TestAdd() {
    println("add says hi")
    assert(Add(2, 3) == 5)
}

// pkg/slow がある間は待つ（watch の温めの列を長くして、編集で止まることを見る相のため）
func TestWait() {
    while true {
        _ = io.ReadFile("pkg/slow") catch return
        os.Sleep(50)
    }
}

func TestData() {
    b := io.ReadFile("pkg/testdata/in.txt") catch []byte{}
    n := os.Getenv("TR_NAME") catch nil
    _ = io.WriteStderr(bytes("data ${len(b)} ${n == nil}\n"))
    assert(len(b) > 0)
}
SRC
echo hello > pkg/testdata/in.txt
cat > bad/bad_test.sober <<'SRC'
package bad

func TestNo() {
    assert(1 == 2)
}
SRC
cat > dyn/dyn_test.sober <<'SRC'
package dyn

import "std/os"

func TestDyn() {
    k := "TR_" + "DYN"
    _ = os.Getenv(k) catch nil
}
SRC
fail=0
n=0
# q <名前> <期待の当否: hit / miss / skip> [sober test の引数…]: 1 回走らせて当否と印字（置き場なしの印字と一致）を見る
q() {
    local name=$1 want=$2; shift 2
    n=$((n + 1))
    SOBER_CACHE_STAT=1 "$S" test "$@" > "$W/o" 2> "$W/e"
    local ec=$?
    SOBER_CHECK_REPLAY=0 "$S" test "$@" > "$W/o0" 2> "$W/e0"
    local ec0=$?
    local got=miss
    grep -q '^cache: test-replay 1/1' "$W/e" && got=hit
    [ "$want" = skip ] && { grep -q '^cache: test-replay skip' "$W/e" && got=skip; }
    [ "$got" = "$want" ] || { echo "FAIL $name: want $want, got $got"; grep '^cache: test' "$W/e"; fail=1; }
    [ "$ec" = "$ec0" ] || { echo "FAIL $name: exit $ec vs $ec0 without the replay"; fail=1; }
    cmp -s "$W/o" "$W/o0" || { echo "FAIL $name: stdout differs from the run without the replay"; diff "$W/o" "$W/o0" | head -5; fail=1; }
    { grep -v '^cache: ' "$W/e" || true; } > "$W/e1"
    cmp -s "$W/e1" "$W/e0" || { echo "FAIL $name: stderr differs from the run without the replay"; diff "$W/e1" "$W/e0" | head -5; fail=1; }
}
q first miss pkg
q again hit pkg
sed -i 's/a + b/b + a/' pkg/pkg.sober
q edited miss pkg
q edited-again hit pkg
echo 'package pkg' > pkg/more.sober
q add-file miss pkg
q add-file-again hit pkg
echo more >> pkg/testdata/in.txt
q testdata-edit miss pkg
echo x > pkg/testdata/new.txt
q testdata-add miss pkg
q testdata-again hit pkg
TR_NAME=a q env-set miss pkg
TR_NAME=a q env-set-again hit pkg
TR_NAME=b q env-changed miss pkg
q env-unset miss pkg
q env-unset-again hit pkg
SOBER_HASH_SEED=7 q sober-env miss pkg
q run-prefix miss pkg --run TestAdd
q run-prefix-again hit pkg --run TestAdd
q fresh miss pkg --fresh
q failed skip bad
q failed-again skip bad
q dyn skip dyn
q dyn-again skip dyn
# watch の温めの列（build → テスト）: 受理の回の後に裏で走り、素の `sober build` / `sober test` が 1 回目から当たる。温めの最中に編集すると
# 前の列は止まり、最後の状態が温まる（止めた列の値は鍵が違うので返らない — 当たりの印字・ELF は置き場なしと一致を見る）
mkdir -p app
cat > app/main.sober <<'SRC'
package main

import "pkg"

func main() {
    println(pkg.Add(1, 2))
}
SRC
echo '// watched' >> pkg/pkg.sober
# wwait <前の列の pid>: 前と違う温めの列が走り終えるのを待つ（後から来た回が列を止めて起こし直すことがあるので、いま pid のファイルに
# 書かれている列の `done <pid>` が進み〔<id>.warm〕に出るまで追う）
wwait() {
    local old=$1 P="" C=""
    for _ in $(seq 1 3000); do
        P=$(find "$W/cache" -path '*/watch/*.pid' 2> /dev/null | head -1)
        C=$(cat "$P" 2> /dev/null)
        if [ -n "$C" ] && [ "$C" != "$old" ] && grep -qx "done $C" "${P%.pid}.warm" 2> /dev/null; then
            WPID=$C
            return 0
        fi
        sleep 0.1
    done
    echo "FAIL watch: no warming finished after $old"; tail -3 "$W/watch.err"; fail=1; return 1
}
# bq <名前>: 素の `sober build app` が再生で当たり、ELF が置き場なしとバイト一致
bq() {
    n=$((n + 1))
    SOBER_CACHE_STAT=1 "$S" build app -o "$W/a1" 2> "$W/be" > /dev/null
    SOBER_CHECK_REPLAY=0 SOBER_BUILD_CACHE=0 "$S" build app -o "$W/a0" > /dev/null 2>&1
    grep -q '^cache: build-replay 1/1' "$W/be" || { echo "FAIL $1: build not replayed"; grep '^cache: build' "$W/be"; fail=1; }
    cmp -s "$W/a1" "$W/a0" || { echo "FAIL $1: ELF differs from the build without the cache"; fail=1; }
}
${TR_WATCH_ENV:-} "$S" watch app > /dev/null 2> "$W/watch.err" &
WP=$!
WPID=""
if wwait ""; then
    q watch-warmed hit pkg
    bq watch-warmed-build
fi
# 温めの最中の編集: 列が走り出したらすぐ編集 → 前の列は止まり、最後の状態の build とテストが温まる
echo 'func Sub(a int, b int) int { return a - b }' >> pkg/pkg.sober
for _ in $(seq 1 100); do P=$(find "$W/cache" -path '*/watch/*.pid' 2> /dev/null | head -1); [ -n "$P" ] && [ "$(cat "$P" 2> /dev/null)" != "$WPID" ] && break; sleep 0.05; done
OLD=$(cat "$P" 2> /dev/null)
echo 'func Mul(a int, b int) int { return a * b }' >> pkg/pkg.sober
if wwait "$OLD"; then
    [ -d "/proc/$OLD" ] && [ "$(cat /proc/$OLD/comm 2> /dev/null)" = sh ] && { echo "FAIL watch: the stale warming $OLD still runs"; fail=1; }
    q watch-latest hit pkg
    bq watch-latest-build
fi
# 長い列を編集で止める: テストの層が pkg/slow で待っている間に編集 → 前の列（プロセスグループ）は数秒の内に消え、新しい列が最後の状態を温める
touch pkg/slow
echo 'func Neg(a int) int { return 0 - a }' >> pkg/pkg.sober
OLD=""
for _ in $(seq 1 600); do
    P=$(find "$W/cache" -path '*/watch/*.pid' 2> /dev/null | head -1)
    C=$(cat "$P" 2> /dev/null)
    [ -n "$C" ] && [ "$C" != "$WPID" ] && grep -q '^build' "${P%.pid}.warm" 2> /dev/null && { OLD=$C; break; }
    sleep 0.1
done
if [ -z "$OLD" ]; then
    echo "FAIL watch-stop: the long warming did not start"; fail=1
else
    echo 'func Twice(a int) int { return a * 2 }' >> pkg/pkg.sober
    gone=0
    for _ in $(seq 1 100); do [ -d "/proc/$OLD" ] || { gone=1; break; }; sleep 0.05; done
    [ "$gone" = 1 ] || { echo "FAIL watch-stop: the stale warming $OLD was not stopped"; fail=1; }
    rm -f pkg/slow
    if wwait "$OLD"; then
        q watch-after-stop hit pkg
        bq watch-after-stop-build
    fi
fi
rm -f pkg/slow
# 状態ファイル（watch/<id>.json — pid と cwd を除いて照合）: 受理で温め済み → 拒否（診断の行・温めは skipped）→ 直して温め済み。
# `sober cache info` が同じ状態を 1 行で出し、watch が終わると (stale)
sj() { sed 's/"pid":[0-9]*,"cwd":"[^"]*",//' "$(find "$W/cache" -path '*/watch/*.json' | head -1)" 2> /dev/null; }
swait() {
    n=$((n + 1))
    for _ in $(seq 1 1200); do [ "$(sj)" = "$2" ] && return 0; sleep 0.05; done
    echo "FAIL $1: status"; echo "  got:  $(sj)"; echo "  want: $2"; fail=1
}
R0=$(sj | sed 's/.*"round":\([0-9]*\).*/\1/')
swait status-ok "$(sj | sed 's/"warm":{.*/"warm":{"build":"done","test":"done"}}/')"
cp pkg/pkg.sober "$W/pkg.keep"
echo 'func Bad() int { return "x" }' >> pkg/pkg.sober
R1=$((R0 + 1))
swait status-rejected '{"version":1,"entry":"app","round":'$R1',"phase":"idle","verdict":"rejected","diags":["sober: type error at pkg/pkg.sober:'$(wc -l < pkg/pkg.sober)':25","check: {\"errors\":[{\"msg\":\"def error\"}],\"ok\":false}"],"warm":{"build":"skipped","test":"skipped"}}'
cp "$W/pkg.keep" pkg/pkg.sober
R2=$((R1 + 1))
swait status-fixed '{"version":1,"entry":"app","round":'$R2',"phase":"idle","verdict":"ok","diags":[],"warm":{"build":"done","test":"done"}}'
n=$((n + 1))
"$S" cache info | grep -q "^watch .* app: round $R2 ok · warm build=done test=done\$" || { echo "FAIL cache-info: the watch line"; "$S" cache info | grep '^watch'; fail=1; }
kill "$WP" 2> /dev/null
wait "$WP" 2> /dev/null
n=$((n + 1))
"$S" cache info | grep -q "^watch .* app: round $R2 ok · warm build=done test=done (stale)\$" || { echo "FAIL cache-info: stale"; "$S" cache info | grep '^watch'; fail=1; }
echo "testreplay: $n queries, fail=$fail"
[ "$fail" = 0 ]
