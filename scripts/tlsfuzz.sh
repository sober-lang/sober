#!/usr/bin/env bash
# tlsfuzz（gates）: 外部の検査tlsfuzzerの仕様違反のメッセージを、std/tlsの最小のサーバー（examples/web_server_tls・examples/tls_serve）へ向ける。
# 期待の表testdata/tlsfuzz/expect.tsvの行ごとにスクリプトを実行し、落ちた検査の名前のうち、表の「落ちてよい名前」に当たらないものが1件でもあればFAIL。
# サーバーのプロセスが途中で死んでもFAIL。通信は127.0.0.1だけ（tlsfuzzerの取得はscripts/tlsfuzz-fetch.shの役）。
# tlsfuzzerのClientHelloの群は大半がsecp256r1の固定で、サーバーはX25519だけなので、群をx25519に替えた写しを作業のディレクトリに作って実行する
# （表の群の列がoの行は元のまま）。
#   scripts/tlsfuzz.sh
# 環境変数: TLSFUZZ_BIN = ビルド済みのサーバー（http・echo）のディレクトリ（検査の検査用。指定するとビルドしない）
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
D=$ROOT/out/tlsfuzz
T=testdata/tlsfuzz/expect.tsv
if [ ! -f "$D/.stamp" ]; then
    echo "FAIL: tlsfuzzerが取得されていない（$D）。取得: scripts/tlsfuzz-fetch.sh（GitHubとPyPIへ出る・固定のcommitと版をハッシュで確かめる）"
    exit 1
fi
W=$(mktemp -d)
SPID=
trap '[ -n "$SPID" ] && kill "$SPID" 2>/dev/null; rm -rf "$W"' EXIT

# 群の写し: scripts/とtlsfuzzer/だけをコピーして置き換える（スクリプトは自分の親のディレクトリをimportの起点にする）
for t in o x; do
    mkdir -p "$W/$t"
    cp -a "$D/src/scripts" "$D/src/tlsfuzzer" "$W/$t/"
done
# 自前の会話（testdata/tlsfuzz/test-sober-*.py。tlsfuzzerの本体に無い形）も、同じscripts/から実行する
cp testdata/tlsfuzz/test-sober-*.py "$W/o/scripts/"
cp testdata/tlsfuzz/test-sober-*.py "$W/x/scripts/"
for f in "$W"/x/tlsfuzzer/_apps/*.py; do
    sed -i 's/GroupName\.secp256r1\]/GroupName.x25519]/g; s/GroupName\.secp256r1)/GroupName.x25519)/g; s/groups = \[GroupName\.secp256r1,/groups = [GroupName.x25519,/g' "$f"
done

if [ -n "${TLSFUZZ_BIN:-}" ]; then
    cp "$TLSFUZZ_BIN/http" "$TLSFUZZ_BIN/echo" "$W/"
else
    "$SOBER" build examples/web_server_tls.sober -o "$W/http" > "$W/build.log" 2>&1 || { cat "$W/build.log"; echo "FAIL: build examples/web_server_tls"; exit 1; }
    "$SOBER" build examples/tls_serve.sober -o "$W/echo" >> "$W/build.log" 2>&1 || { cat "$W/build.log"; echo "FAIL: build examples/tls_serve"; exit 1; }
fi
PORT=$(python3 -I -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1])')
cur=
start() {
    [ "$cur" = "$1" ] && [ -n "$SPID" ] && return 0
    if [ -n "$SPID" ]; then kill "$SPID" 2>/dev/null; wait "$SPID" 2>/dev/null; fi
    # half = examples/tls_serveのlive-half（相手のclose_notifyの後に送る）
    case "$1" in half) SOBER_WORKERS=2 "$W/echo" live-half "$PORT" > "$W/server-$1.log" 2>&1 & ;;
        *) SOBER_WORKERS=2 "$W/$1" live "$PORT" > "$W/server-$1.log" 2>&1 & ;; esac
    SPID=$!
    cur=$1
    for _ in $(seq 100); do
        python3 -I -c "import socket; socket.create_connection(('127.0.0.1', $PORT), 1)" 2>/dev/null && return 0
        sleep 0.05
    done
    echo "FAIL: server $1 did not listen on 127.0.0.1:$PORT"
    return 1
}

fail=0
n=0
while IFS=$'\t' read -r script tree srv args allow _why; do
    case "$script" in ''|'#'*) continue ;; esac
    start "$srv" || { fail=1; break; }
    log=$W/$n-$script.log
    n=$((n + 1))
    if [ -z "$args" ]; then
        (cd "$W/$tree" && PYTHONPATH=$D/site timeout 300 python3 "scripts/$script.py" -h 127.0.0.1 -p "$PORT") > "$log" 2>&1
    elif [ "${args#-}" != "$args" ]; then
        # shellcheck disable=SC2086
        (cd "$W/$tree" && PYTHONPATH=$D/site timeout 300 python3 "scripts/$script.py" -h 127.0.0.1 -p "$PORT" $args) > "$log" 2>&1
    else
        (cd "$W/$tree" && PYTHONPATH=$D/site timeout 300 python3 "scripts/$script.py" -h 127.0.0.1 -p "$PORT" "$args") > "$log" 2>&1
    fi
    bad=$(python3 -I - "$log" "$allow" <<'PY'
import re, sys
log, allow = sys.argv[1], sys.argv[2]
t = open(log, errors='replace').read()
if '\nTOTAL:' not in t:
    print('(no summary: the script did not finish)')
    sys.exit()
names = re.findall(r"^\t'(.*)'$", t.split('\nFAILED:', 1)[1], re.M) if '\nFAILED:' in t else []
print('\n'.join(x for x in names if not (allow and re.search(allow, x))))
PY
)
    total=$(grep -m1 '^TOTAL:' "$log" | cut -d' ' -f2)
    if [ -n "$bad" ]; then
        echo "FAIL $script ($tree, $srv): $(echo "$bad" | wc -l) unexpected: $(echo "$bad" | head -3 | tr '\n' ';')"
        fail=1
    else
        echo "ok   $script ($tree, $srv): ${total:-?} probes"
    fi
    if ! kill -0 "$SPID" 2>/dev/null; then
        echo "FAIL $script: server $srv died"; tail -5 "$W/server-$srv.log"
        fail=1
        SPID=
    fi
done < "$T"
echo "tlsfuzz: $n rows of $T against std/tls @ tlsfuzzer $(cut -c1-12 "$D/.stamp"), fail=$fail"
[ $fail = 0 ]
