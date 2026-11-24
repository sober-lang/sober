#!/usr/bin/env bash
# tls12interop: TLS 1.2 のサーバー（tls.DangerouslyAllowTls12 — testdata/tls12/srv.sober）と openssl s_client の相互運用。通信は 127.0.0.1 だけ。
# 受ける形: 7 スイート × 群（ECDHE は X25519 と P-256）で HTTP/1.1 の往復が "ok"・CBC は encrypt_then_mac の有無の両方・extended_master_secret なし。
# ECDSA の証明書（testdata/crypto/ecdsa-server — 2 本目のサーバー）: ECDHE-ECDSA の 4 スイート × 群・署名 ecdsa_secp256r1_sha256・1.3 も ECDSA の署名・RSA のスイートだけの相手は拒否。
# 選ぶ形: 1.3 を申し出る相手は 1.3・ALPN h2 は ECDHE + AEAD だけ（CBC だけの相手は h2 を外した ALPN）・サーバーの好みの順。
# 拒否の形: TLS 1.1・TLS_FALLBACK_SCSV・共通のスイートが無い・3DES・接続の後の再交渉
# 通った件は `conf-item: interop/tls12 <件> <結果>` を出す（準拠文書の証拠 — scripts/confrecord.sh tls12 <出力> で testdata/conformance/interop/tls12.txt へ）
#   scripts/tls12interop.sh
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT=$PWD
SOBER=${SOBER:-$ROOT/bin/sober}
command -v openssl > /dev/null || { echo "FAIL: openssl が無い"; exit 1; }
W=$(mktemp -d)
SPID=
EPID=
trap '[ -n "$SPID" ] && kill "$SPID" 2>/dev/null; [ -n "$EPID" ] && kill "$EPID" 2>/dev/null; rm -rf "$W"' EXIT
"$SOBER" build testdata/tls12/srv.sober -o "$W/srv" > "$W/build.log" 2>&1 || { cat "$W/build.log"; echo "FAIL: build testdata/tls12/srv"; exit 1; }
freeport() { python3 -I -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1])'; }
# 待ち受けの準備ができるまで待つ（引数 = ポート・サーバーの標準出力のファイル）
ready() {
    for _ in $(seq 100); do
        grep -q '^tls12-ready' "$2" 2>/dev/null && python3 -I -c "import socket; socket.create_connection(('127.0.0.1', $1), 1)" 2>/dev/null && return
        sleep 0.05
    done
}
PORT=$(freeport)
"$W/srv" "$PORT" h2,http/1.1 > "$W/srv.out" 2> "$W/srv.err" &
SPID=$!
EPORT=$(freeport)
"$W/srv" "$EPORT" h2,http/1.1 ecdsa-server > "$W/esrv.out" 2> "$W/esrv.err" &
EPID=$!
ready "$PORT" "$W/srv.out"
ready "$EPORT" "$W/esrv.out"
RPORT=$PORT
fail=0
n=0
REQ='GET / HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n'
# 1 回の接続（引数 = s_client の追加の引数）→ 標準出力と標準エラーをまとめて $W/o
sc() {
    printf "$REQ" | timeout 10 openssl s_client -connect "127.0.0.1:$PORT" -brief -ign_eof "$@" > "$W/o" 2>&1
}
# 往復が通り、版とスイートが期待どおり
ok() {
    local name=$1 ver=$2 suite=$3; shift 3
    n=$((n + 1))
    sc "$@"
    if grep -q "^ok$" "$W/o" && grep -q "Protocol version: $ver" "$W/o" && grep -q "Ciphersuite: $suite$" "$W/o"; then
        echo "ok   $name"; echo "conf-item: interop/tls12 ${name// /-} ${ver#TLSv} $suite"
    else
        echo "FAIL $name"; grep -v '^HTTP\|^Content\|^Cache\|^Date\|^Connection' "$W/o" | head -8; fail=1
    fi
}
# 往復が通らない（handshake の失敗）
ng() {
    local name=$1; shift
    n=$((n + 1))
    sc "$@"
    if grep -q "^ok$" "$W/o"; then
        echo "FAIL $name (accepted)"; head -5 "$W/o"; fail=1
    else
        echo "ok   $name"; echo "conf-item: interop/tls12 ${name// /-} refused"
    fi
}
# ALPN の判定（-brief は ALPN の行を出さないので -brief なし。版とスイートは "Protocol" と "Cipher is" の行）
alpn() {
    local name=$1 want=$2 suite=$3; shift 3
    n=$((n + 1))
    printf '' | timeout 10 openssl s_client -connect "127.0.0.1:$PORT" "$@" > "$W/o" 2>&1
    if grep -q "ALPN protocol: $want" "$W/o" && grep -q "Cipher is $suite$" "$W/o" && grep -q "Protocol *: TLSv1.2" "$W/o"; then
        echo "ok   $name"; echo "conf-item: interop/tls12 ${name// /-} 1.2 $suite $want"
    else
        echo "FAIL $name"; grep -i 'alpn\|cipher\|protocol' "$W/o" | head -8; fail=1
    fi
}
L0='@SECLEVEL=0'
for g in X25519 P-256; do
    ok "ecdhe-rsa-aes128-gcm $g" TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256" -groups $g -alpn http/1.1
    ok "ecdhe-rsa-chacha20 $g" TLSv1.2 ECDHE-RSA-CHACHA20-POLY1305 -tls1_2 -cipher "ECDHE-RSA-CHACHA20-POLY1305" -groups $g -alpn http/1.1
    ok "ecdhe-rsa-aes128-cbc-sha256 $g" TLSv1.2 ECDHE-RSA-AES128-SHA256 -tls1_2 -cipher "ECDHE-RSA-AES128-SHA256:$L0" -groups $g
    ok "ecdhe-rsa-aes128-cbc-sha $g" TLSv1.2 ECDHE-RSA-AES128-SHA -tls1_2 -cipher "ECDHE-RSA-AES128-SHA:$L0" -groups $g
done
ok "rsa-aes128-gcm" TLSv1.2 AES128-GCM-SHA256 -tls1_2 -cipher "AES128-GCM-SHA256:$L0"
ok "rsa-aes128-cbc-sha256" TLSv1.2 AES128-SHA256 -tls1_2 -cipher "AES128-SHA256:$L0"
ok "rsa-aes128-cbc-sha" TLSv1.2 AES128-SHA -tls1_2 -cipher "AES128-SHA:$L0"
# encrypt_then_mac なし（MAC-then-encrypt — Lucky13 の対策の道）・extended_master_secret なし
ok "cbc-sha256 no etm" TLSv1.2 ECDHE-RSA-AES128-SHA256 -tls1_2 -cipher "ECDHE-RSA-AES128-SHA256:$L0" -no_etm
ok "cbc-sha no etm rsa kx" TLSv1.2 AES128-SHA -tls1_2 -cipher "AES128-SHA:$L0" -no_etm
ok "gcm no ems" TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256" -no_ems
# ServerKeyExchange の署名: rsa_pkcs1_sha1（古い相手）と rsa_pss_rsae_sha256
for sa in RSA+SHA1:rsa_pkcs1_sha1 rsa_pss_rsae_sha256:rsa_pss_rsae_sha256; do
    n=$((n + 1))
    sc -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256:$L0" -sigalgs "${sa%%:*}"
    if grep -q "^ok$" "$W/o" && grep -q "Signature type: ${sa#*:}$" "$W/o"; then echo "ok   signature ${sa#*:}"; echo "conf-item: interop/tls12 signature-${sa#*:} 1.2"; else echo "FAIL signature ${sa#*:}"; head -8 "$W/o"; fail=1; fi
done
# encrypt_then_mac の合意（-trace の ClientHello と ServerHello に 1 回ずつ — -no_etm では 0 回）
for e in "2:" "0:-no_etm"; do
    n=$((n + 1))
    printf '' | timeout 10 openssl s_client -connect "127.0.0.1:$PORT" -tls1_2 -cipher "ECDHE-RSA-AES128-SHA256:$L0" -trace ${e#*:} > "$W/o" 2>&1
    c=$(grep -c 'encrypt_then_mac' "$W/o")
    if [ "$c" = "${e%%:*}" ]; then echo "ok   etm negotiated ${e#*:} ($c)"; echo "conf-item: interop/tls12 etm-$([ "${e%%:*}" = 2 ] && echo on || echo off) 1.2"; else echo "FAIL etm negotiated ${e#*:} ($c)"; fail=1; fi
done
# サーバーの好みの順（相手の申し出の順でなく GCM が先）・1.3 を申し出る相手は 1.3
ok "server preference" TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 -tls1_2 -cipher "AES128-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES128-GCM-SHA256:$L0"
ok "tls1.3 stays 1.3" TLSv1.3 TLS_AES_128_GCM_SHA256 -alpn http/1.1
# ALPN h2: CBC だけの相手には h2 を選ばない（http/1.1 も申し出ていれば http/1.1）・ECDHE + AEAD なら h2
alpn "alpn h2 not with cbc" http/1.1 ECDHE-RSA-AES128-SHA -tls1_2 -cipher "ECDHE-RSA-AES128-SHA:$L0" -alpn h2,http/1.1
alpn "alpn h2 with ecdhe aead" h2 ECDHE-RSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256" -alpn h2
# 拒否の形
ng "tls1.1 rejected" -tls1_1 -cipher "AES128-SHA:$L0"
ng "fallback scsv rejected" -tls1_2 -fallback_scsv -cipher "ECDHE-RSA-AES128-GCM-SHA256"
ng "no common suite aes256 only" -tls1_2 -cipher "AES256-SHA:ECDHE-RSA-AES256-GCM-SHA384:$L0"
ng "3des rejected" -tls1_2 -cipher "DES-CBC3-SHA:$L0"
# 接続の後の再交渉（s_client の入力の "R"）は no_renegotiation（alert 100）で閉じる
n=$((n + 1))
(sleep 1; printf 'R\n'; sleep 2) | timeout 10 openssl s_client -connect "127.0.0.1:$PORT" -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256" > "$W/o" 2>&1
if grep -q 'RENEGOTIATING' "$W/o" && grep -q 'alert number 100' "$W/o"; then echo "ok   renegotiation refused"; echo "conf-item: interop/tls12 renegotiation-refused no_renegotiation"; else echo "FAIL renegotiation refused"; grep -i 'renegot\|alert' "$W/o" | head -5; fail=1; fi
kill -0 "$SPID" 2>/dev/null || { echo "FAIL: the server died ($(head -c 300 "$W/srv.err"))"; fail=1; }
# ECDSA の証明書のサーバー（以下の行は PORT を 2 本目に替えて同じ関数で回す）
PORT=$EPORT
# 群: X25519 で鍵を交換する相手も、証明書の曲線 P-256 を supported_groups に持つ（RFC 8422 5.1）
for g in X25519:P-256 P-256; do
    ok "ecdhe-ecdsa-aes128-gcm ${g%%:*}" TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-ECDSA-AES128-GCM-SHA256" -groups $g -alpn http/1.1
    ok "ecdhe-ecdsa-chacha20 ${g%%:*}" TLSv1.2 ECDHE-ECDSA-CHACHA20-POLY1305 -tls1_2 -cipher "ECDHE-ECDSA-CHACHA20-POLY1305" -groups $g -alpn http/1.1
    ok "ecdhe-ecdsa-aes128-cbc-sha256 ${g%%:*}" TLSv1.2 ECDHE-ECDSA-AES128-SHA256 -tls1_2 -cipher "ECDHE-ECDSA-AES128-SHA256:$L0" -groups $g
    ok "ecdhe-ecdsa-aes128-cbc-sha ${g%%:*}" TLSv1.2 ECDHE-ECDSA-AES128-SHA -tls1_2 -cipher "ECDHE-ECDSA-AES128-SHA:$L0" -groups $g
done
ok "ecdsa cbc-sha256 no etm" TLSv1.2 ECDHE-ECDSA-AES128-SHA256 -tls1_2 -cipher "ECDHE-ECDSA-AES128-SHA256:$L0" -no_etm
# 署名の種類（1.2 の ServerKeyExchange と 1.3 の CertificateVerify）・サーバーの好みの順・ALPN h2
for v in tls1_2:ECDHE-ECDSA-AES128-GCM-SHA256 tls1_3:TLS_AES_128_GCM_SHA256; do
    n=$((n + 1))
    sc "-${v%%:*}" $([ "${v%%:*}" = tls1_2 ] && echo -cipher "${v#*:}")
    if grep -q "^ok$" "$W/o" && grep -q "Signature type: ecdsa_secp256r1_sha256$" "$W/o" && grep -q "Ciphersuite: ${v#*:}$" "$W/o"; then
        echo "ok   ecdsa signature ${v%%:*}"; echo "conf-item: interop/tls12 ecdsa-signature-${v%%:*} ecdsa_secp256r1_sha256"
    else
        echo "FAIL ecdsa signature ${v%%:*}"; head -8 "$W/o"; fail=1
    fi
done
ok "ecdsa server preference" TLSv1.2 ECDHE-ECDSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES128-GCM-SHA256:$L0"
alpn "ecdsa alpn h2 with ecdhe aead" h2 ECDHE-ECDSA-AES128-GCM-SHA256 -tls1_2 -cipher "ECDHE-ECDSA-AES128-GCM-SHA256" -alpn h2
# 拒否: RSA のスイートだけの相手・証明書の曲線を持たない相手・ECDSA の署名を申し出ない相手
ng "ecdsa cert rsa suites only" -tls1_2 -cipher "ECDHE-RSA-AES128-GCM-SHA256:AES128-SHA:$L0"
ng "ecdsa cert x25519 only groups" -tls1_2 -cipher "ECDHE-ECDSA-AES128-GCM-SHA256" -groups X25519
ng "ecdsa cert no ecdsa sigalg" -tls1_2 -cipher "ECDHE-ECDSA-AES128-GCM-SHA256" -sigalgs "RSA+SHA256:ECDSA+SHA384"
kill -0 "$EPID" 2>/dev/null || { echo "FAIL: the ecdsa server died ($(head -c 300 "$W/esrv.err"))"; fail=1; }
PORT=$RPORT
[ $fail = 0 ] && echo "conf: interop/tls12 $n"
echo "tls12interop: $n cases against openssl s_client ($(openssl version | cut -d' ' -f1-2)), fail=$fail"
[ $fail = 0 ]
