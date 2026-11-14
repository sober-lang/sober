#!/usr/bin/env bash
# pgoracle（std/pgの実PostgreSQLとの相互接続の検査）: 使い捨てのPostgreSQL（17と18 — TLSつき・SCRAMの役割）を立て、
# std/internal/pgwire と std/pg の TestOracle を SOBER_PG_ORACLE で走らせる。PostgreSQL のバイナリが要るので gates に入れない（R2 / R3 の節目に手で回す）。
# バイナリ = PG_BIN_17 / PG_BIN_18（initdb・pg_ctl・postgresのあるbin/ — 既定はembedded-postgresのコピー ~/.cache/sqlshape/pg-<版>/bin）。
# 片方しか無ければある方だけで走る（無い方は明示して飛ばす）。証明書はopensslで毎回作る（自己署名のCA + localhost / 127.0.0.1の葉 — RSA 2048）
#   scripts/pgoracle.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
W=$(mktemp -d)
pids=()
cleanup() {
    for d in "$W"/data-*; do
        [ -d "$d" ] && "$(cat "$d.bin")/pg_ctl" -D "$d" -m immediate stop > /dev/null 2>&1
    done
    rm -rf "$W"
}
trap cleanup EXIT
openssl req -x509 -newkey rsa:2048 -nodes -keyout "$W/ca.key" -out "$W/ca.pem" -days 2 -subj "/CN=pgoracle CA" \
    -addext "basicConstraints=critical,CA:TRUE" -addext "keyUsage=critical,keyCertSign" 2> /dev/null
openssl req -newkey rsa:2048 -nodes -keyout "$W/server.key" -out "$W/server.csr" -subj "/CN=localhost" 2> /dev/null
printf "subjectAltName=DNS:localhost,IP:127.0.0.1\nbasicConstraints=CA:FALSE\nextendedKeyUsage=serverAuth\n" > "$W/ext.cnf"
openssl x509 -req -in "$W/server.csr" -CA "$W/ca.pem" -CAkey "$W/ca.key" -CAcreateserial -out "$W/server.pem" -days 2 -extfile "$W/ext.cnf" 2> /dev/null
chmod 600 "$W/server.key"
echo pw > "$W/pwfile"
conf="$W/oracle.conf"
printf "ca %s\nuser scramuser\npassword pencil\n" "$W/ca.pem" > "$conf"
port=$((54400 + RANDOM % 500))
n=0
for v in 17 18; do
    var="PG_BIN_$v"
    bin=${!var:-$(ls -d "$HOME"/.cache/sqlshape/pg-"$v".*/bin 2> /dev/null | head -1)}
    if [ -z "$bin" ] || [ ! -x "$bin/initdb" ]; then
        echo "pgoracle: skip PostgreSQL $v (no binaries — set $var)"
        continue
    fi
    d="$W/data-$v"
    echo "$bin" > "$d.bin"
    "$bin/initdb" -D "$d" -U postgres --auth-local=trust --auth-host=scram-sha-256 --pwfile="$W/pwfile" -E UTF8 > "$W/initdb-$v.log" 2>&1 \
        || { echo "pgoracle: FAIL — initdb $v"; cat "$W/initdb-$v.log"; exit 1; }
    cat >> "$d/postgresql.conf" << EOF
port = $port
listen_addresses = '127.0.0.1'
unix_socket_directories = '$W'
ssl = on
ssl_cert_file = '$W/server.pem'
ssl_key_file = '$W/server.key'
EOF
    printf "local all all trust\nhost all all 127.0.0.1/32 scram-sha-256\n" > "$d/pg_hba.conf"
    # 2 接続で同じ表を見る題材（Serializable の 40001）のため public に表を作れるように（PG 15 以降は既定で作れない）
    printf "CREATE ROLE scramuser LOGIN PASSWORD 'pencil';\nGRANT CREATE ON SCHEMA public TO scramuser;\n" | "$bin/postgres" --single -D "$d" postgres > "$W/single-$v.log" 2>&1
    "$bin/pg_ctl" -D "$d" -l "$W/pg-$v.log" -w start > /dev/null || { echo "pgoracle: FAIL — start $v"; cat "$W/pg-$v.log"; exit 1; }
    echo "server pg$v 127.0.0.1:$port" >> "$conf"
    port=$((port + 1))
    n=$((n + 1))
done
[ "$n" -gt 0 ] || { echo "pgoracle: FAIL — no PostgreSQL binaries"; exit 1; }
SOBER_PG_ORACLE=$conf "$ROOT/bin/sober" test std/internal/pgwire std/pg --run TestOracle -v --fresh
rc=$?
# ガイドの例（examples/pg_*.sober — .outを持たない: 検査一式はDBを持たないのでビルドして検査するだけ）を各サーバに向けて走らせ、
# 出力を testdata/pg/<例>.out と照合する（TLS + SCRAM-SHA-256-PLUS・私的 CA）
for ex in pg_shop pg_transfer pg_pool; do
    "$ROOT/bin/sober" build "$ROOT/examples/$ex.sober" -o "$W/$ex" > "$W/$ex.build.log" 2>&1 \
        || { echo "pgoracle: FAIL — build examples/$ex"; cat "$W/$ex.build.log"; rc=1; continue; }
    while read -r kw name hostport; do
        [ "$kw" = server ] || continue
        got=$(PG_URL="postgres://scramuser@${hostport/127.0.0.1/localhost}/postgres" PG_PASSWORD=pencil PG_CA="$W/ca.pem" "$W/$ex" 2>&1)
        if [ "$got" = "$(cat "$ROOT/testdata/pg/$ex.out")" ]; then
            echo "ok   examples/$ex ($name)"
        else
            echo "pgoracle: FAIL — examples/$ex ($name)"; diff <(echo "$got") "$ROOT/testdata/pg/$ex.out"; rc=1
        fi
    done < "$conf"
done
exit $rc
