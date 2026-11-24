#!/usr/bin/env bash
# h2spec（gates）: 外部の検査h2spec v2.6.0（HTTP/2の準拠 — 146項目）を、examples/http_h2cのサーバー（ServeConnのproto: H2とBoth — h2c）へ向ける。
# JUnitの出力の落ちた項目（package・classname）のうち、testdata/h2spec/expect.tsvの落ちてよい項目に無いものが1件でもあればFAIL。
# サーバーのプロセスが途中で死んでもFAIL。続けて curl --http2-prior-knowledge で、遅い要求（/slow）が同じ接続の速い要求（/fast）を
# 止めないこと（/fastが/slowより先に終わる）を見る。通信は127.0.0.1だけ（h2specの取得はscripts/h2spec-fetch.shの役）。
# 使う前に、取得したh2specのsha256を固定の値と照合する（写した取得物でも固定を保つ）
# 最後にh2floodの段（下 — testdata/h2flood）: HTTP/2の8つの攻撃を小さい規模で掛け、種目ごとの守りの形と攻撃の最中の生存を見る（h2c・TLS・TLS 1.2）。TLS 1.2ではh2specの146項目も当てる（h2specのTLSのクライアントはTLS 1.2まで申し出る）
#   scripts/h2spec.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
H=$ROOT/out/h2spec/h2spec
BIN_SHA=ac679b916bcd46c52314b17c8903d8dffebf0f2357586d272731f6d8bfd5e9f7
T=testdata/h2spec/expect.tsv
P=testdata/h2spec/pass.txt
REGEN=0
[ "${1:-}" = --regen ] && REGEN=1
if [ ! -x "$H" ]; then
    echo "FAIL: h2specが取得されていない（$H）。取得: scripts/h2spec-fetch.sh（GitHubへ出る・sha256で確かめる）"
    exit 1
fi
[ "$(sha256sum "$H" | cut -d' ' -f1)" = "$BIN_SHA" ] || { echo "FAIL: h2specのsha256が固定の値でない（$H）"; exit 1; }
W=$(mktemp -d)
SPID=
trap '[ -n "$SPID" ] && kill "$SPID" 2>/dev/null; rm -rf "$W"' EXIT
"$SOBER" build examples/http_h2c.sober -o "$W/srv" > "$W/build.log" 2>&1 || { cat "$W/build.log"; echo "FAIL: build examples/http_h2c"; exit 1; }
PORT=$(python3 -I -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1])')
fail=0
# モード: h2 = proto: H2（落ちてよい項目なし）・both = proto: Both（expect.tsvのboth の行だけ落ちてよい）
# 通った項目の一覧: proto: H2・workers 1の回で通った項目のID（h2specの番号 — package/パッケージの中の順番）と題を、testdata/h2spec/pass.txt と照合する
# （準拠文書の証拠 gold:testdata/h2spec/pass.txt:<ID>_ok が引く — 「ok」までで1つの項目に決まる）。`scripts/h2spec.sh --regen` は照合の代わりに書き直す
for mw in "h2 1" "h2 2" "both 2"; do
    mode=${mw% *}; w=${mw#* }
    SOBER_WORKERS=$w "$W/srv" live "$PORT" $([ $mode = h2 ] && echo h2) > "$W/server.$w.log" 2>&1 &
    SPID=$!
    for _ in $(seq 100); do
        python3 -I -c "import socket; socket.create_connection(('127.0.0.1', $PORT), 1)" 2>/dev/null && break
        sleep 0.05
    done
    timeout 300 "$H" -h 127.0.0.1 -p "$PORT" -o 3 -j "$W/j.$w.xml" > "$W/h2spec.$w.txt" 2>&1
    bad=$(python3 -I - "$W/j.$w.xml" "$T" "$mode" <<'PY'
import sys, xml.etree.ElementTree as ET
j, t, mode = sys.argv[1], sys.argv[2], sys.argv[3]
allow = set()
for line in open(t, encoding='utf-8'):
    if line.strip() and not line.startswith('#'):
        p = line.rstrip('\n').split('\t')
        if p[0] == mode:
            allow.add((p[1], p[2]))
try:
    root = ET.parse(j).getroot()
except Exception as e:
    print('(no JUnit output: %s)' % e)
    sys.exit()
n = 0
for tc in root.iter('testcase'):
    n += 1
    if tc.find('failure') is not None or tc.find('error') is not None:
        k = (tc.get('package'), tc.get('classname'))
        if k not in allow:
            print('%s %s' % k)
if n < 140:
    print('(only %d test cases)' % n)
PY
)
    if [ "$mode $w" = "h2 1" ]; then
        python3 -I - "$W/j.$w.xml" > "$W/pass.txt" <<'PY'
import sys, xml.etree.ElementTree as ET
seen = {}
print('# h2specが通った項目（proto: H2・SOBER_WORKERS=1 — scripts/h2spec.shが作って照合する。書き直しは scripts/h2spec.sh --regen）。1行 = ID〔package/パッケージの中の順番〕 ok \t 題。準拠文書の証拠は gold:testdata/h2spec/pass.txt:<ID>_ok で引く')
for tc in ET.parse(sys.argv[1]).getroot().iter('testcase'):
    pk = tc.get('package')
    seen[pk] = seen.get(pk, 0) + 1
    if tc.find('failure') is None and tc.find('error') is None:
        print('%s/%d ok\t%s' % (pk, seen[pk], tc.get('classname')))
PY
        if [ $REGEN = 1 ]; then
            cp "$W/pass.txt" "$P"; echo "h2spec: regen $P ($(grep -vc '^#' "$P") items)"
        elif ! diff -u "$P" "$W/pass.txt" > "$W/pass.diff"; then
            echo "FAIL h2spec: the passed items differ from $P (scripts/h2spec.sh --regen after checking):"; head -12 "$W/pass.diff"; fail=1
        fi
    fi
    total=$(tail -1 "$W/h2spec.$w.txt")
    if [ -n "$bad" ]; then
        echo "FAIL h2spec (proto $mode, SOBER_WORKERS=$w): $(echo "$bad" | wc -l) unexpected: $(echo "$bad" | head -3 | tr '\n' ';')"
        fail=1
    else
        echo "ok   h2spec (proto $mode, SOBER_WORKERS=$w): $total"
    fi
    if ! kill -0 "$SPID" 2>/dev/null; then
        echo "FAIL: the server died (SOBER_WORKERS=$w)"; tail -5 "$W/server.$w.log"; fail=1
    fi
    if [ $mode = both ] && command -v curl > /dev/null; then
        # 同じ接続の2本: /fast が /slow より先に終わる（curl -Z は同じ接続に多重化する）
        out=$(curl -s --http2-prior-knowledge -Z --parallel-max 2 "http://127.0.0.1:$PORT/slow" "http://127.0.0.1:$PORT/fast" -w '%{http_version} %{url_effective}\n')
        first=$(echo "$out" | grep -m1 '^2 ' | cut -d' ' -f2)
        case "$first" in
        */fast) echo "ok   curl: /fast ended before /slow on one connection" ;;
        *) echo "FAIL curl: /slow blocked /fast (first: $first)"; echo "$out" | head -4; fail=1 ;;
        esac
    fi
    kill "$SPID" 2>/dev/null; wait "$SPID" 2>/dev/null; SPID=
done
# h2floodの段: testdata/h2flood/srv（proto: H2・頭2秒・送りの間隔1秒）に、HttpArenaのResilienceのHTTP/2の8つの攻撃を小さい規模で掛け、
# 種目ごとの守りの形（閉じられる・shedに数えられる・攻撃の後も同じ接続で応じる・sendWaitの内に閉じられる）と、攻撃の最中の別の接続の生存を見る
# （testdata/h2flood/check.ts）。メモリの量は見ない
"$SOBER" build testdata/h2flood/srv.sober -o "$W/fsrv" > "$W/fbuild.log" 2>&1 || { cat "$W/fbuild.log"; echo "FAIL: build testdata/h2flood/srv"; exit 1; }
for w in 1 2; do
    SOBER_WORKERS=$w "$W/fsrv" > "$W/fsrv.$w.out" 2> "$W/fsrv.$w.err" &
    SPID=$!
    fport=
    for _ in $(seq 100); do
        fport=$(sed -n 's/^ready \([0-9]*\)$/\1/p' "$W/fsrv.$w.out")
        [ -n "$fport" ] && break
        sleep 0.05
    done
    if [ -z "$fport" ]; then
        echo "FAIL h2flood (SOBER_WORKERS=$w): the server did not start ($(head -c 200 "$W/fsrv.$w.err"))"; fail=1
    elif out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/h2flood/check.ts "$fport" 2>&1); then
        echo "ok   h2flood (SOBER_WORKERS=$w): $(echo "$out" | tail -1)"
    else
        echo "FAIL h2flood (SOBER_WORKERS=$w)"; echo "$out" | grep -v '^ok' | tail -12; fail=1
    fi
    if ! kill -0 "$SPID" 2>/dev/null; then
        echo "FAIL: the h2flood server died (SOBER_WORKERS=$w)"; tail -5 "$W/fsrv.$w.err"; fail=1
    fi
    kill "$SPID" 2>/dev/null; wait "$SPID" 2>/dev/null; SPID=
done
# nghttp（相互運用の段 — PATH → /nix/store の順に探す。無ければFAIL・SOBER_GATES_ALLOW_SKIPにnghttpを書いたときだけSKIP）
source scripts/gatelib.sh
NG=${NGHTTP:-$(command -v nghttp || ls -d /nix/store/*-nghttp2-[0-9]*/bin/nghttp 2> /dev/null | sort -V | tail -n 1)}
if [ -z "$NG" ] || ! "$NG" --version > /dev/null 2>&1; then
    NG=
    cant h2spec nghttp "the HTTP/2 interop over TLS" || fail=1
fi
# h2floodのTLSの段: 同じ題材をTLS（testdataの証明書・ALPN h2 / http/1.1・`srv tls <port>`）で立て、check.tsがTLS（ALPN h2）で同じ攻撃を掛ける
# （TLSの接続の受けと送りの道 — mux.RecvFromのTLSの分岐・net.Sendの暗号化 — の上の守りの形）
for w in 1 2; do
    tport=$(python3 -I -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1])')
    SOBER_WORKERS=$w "$W/fsrv" tls "$tport" > "$W/tsrv.$w.out" 2> "$W/tsrv.$w.err" &
    SPID=$!
    up=0
    for _ in $(seq 100); do
        grep -q '^tls-ready' "$W/tsrv.$w.out" 2>/dev/null && python3 -I -c "import socket; socket.create_connection(('127.0.0.1', $tport), 1)" 2>/dev/null && { up=1; break; }
        sleep 0.05
    done
    if [ $up = 0 ]; then
        echo "FAIL h2flood tls (SOBER_WORKERS=$w): the server did not start ($(head -c 200 "$W/tsrv.$w.err"))"; fail=1
    elif out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/h2flood/check.ts "$tport" tls 2>&1); then
        echo "ok   h2flood tls (SOBER_WORKERS=$w): $(echo "$out" | tail -1)"
    else
        echo "FAIL h2flood tls (SOBER_WORKERS=$w)"; echo "$out" | grep -v '^ok' | tail -12; fail=1
    fi
    # TLS 1.2の段（DangerouslyAllowTls12）: 同じ攻撃をTLS 1.2（ECDHE + AEAD — ALPN h2のスイートの制限）で掛け、h2spec（TLS 1.2まで申し出る）の146項目を -P /big で当てる
    # （h2specの6.9.2/2は応答の本文が短いと飛ばす〔"/" の "ok\n" 3バイト〕ので、本文の長い /big を使う。落ちてよい項目は無い）
    if [ $up = 1 ]; then
        if out=$(timeout 120 node --experimental-strip-types --no-warnings testdata/h2flood/check.ts "$tport" tls12 2>&1); then
            echo "ok   h2flood tls12 (SOBER_WORKERS=$w): $(echo "$out" | tail -1)"
        else
            echo "FAIL h2flood tls12 (SOBER_WORKERS=$w)"; echo "$out" | grep -v '^ok' | tail -12; fail=1
        fi
        timeout 300 "$H" -h 127.0.0.1 -p "$tport" -t -k -P /big -o 3 > "$W/h2spec12.$w.txt" 2>&1
        last=$(tail -1 "$W/h2spec12.$w.txt")
        if echo "$last" | grep -q '^146 tests, 146 passed, 0 skipped, 0 failed'; then
            echo "ok   h2spec tls12 (SOBER_WORKERS=$w): $last"
        else
            echo "FAIL h2spec tls12 (SOBER_WORKERS=$w): $last"; grep -B3 '×' "$W/h2spec12.$w.txt" | head -12; fail=1
        fi
    fi
    # 相互運用: nghttp（nghttp2のクライアント — ALPNでh2）が1本の接続に20本のストリーム（/ と /big を10回ずつ）を並べ、全部が200で、/bigの本文が40000バイト
    # （h2specのTLSのクライアントはTLS 1.2までしか申し出ないので、TLS 1.3の上のHTTP/2の道はh2floodとこの相互運用で見る — TLS 1.2の上は上のh2spec tls12）
    if [ $up = 1 ] && [ -n "$NG" ]; then
        st=$(timeout 30 "$NG" -y -n -s -m 10 "https://127.0.0.1:$tport/" "https://127.0.0.1:$tport/big" 2>&1)
        n200=$(echo "$st" | awk '$5 == 200' | wc -l)
        nbig=$(echo "$st" | awk '$5 == 200 && $7 == "/big" && $6 == "39K"' | wc -l)
        if [ "$n200" = 20 ] && [ "$nbig" = 10 ]; then
            echo "ok   nghttp tls (SOBER_WORKERS=$w): 20 streams on one connection, all 200"
        else
            echo "FAIL nghttp tls (SOBER_WORKERS=$w): 200 = $n200 of 20, /big 39K = $nbig of 10"; echo "$st" | tail -5; fail=1
        fi
    fi
    if ! kill -0 "$SPID" 2>/dev/null; then
        echo "FAIL: the h2flood tls server died (SOBER_WORKERS=$w)"; tail -5 "$W/tsrv.$w.err"; fail=1
    fi
    kill "$SPID" 2>/dev/null; wait "$SPID" 2>/dev/null; SPID=
done
echo "h2spec: examples/http_h2c × {proto H2 × workers 1・2, proto Both × workers 2} + h2flood × workers {1, 2} × {h2c, tls, tls12} + h2spec tls12 × workers {1, 2} + nghttp tls × workers {1, 2}, fail=$fail"
[ $fail = 0 ]
