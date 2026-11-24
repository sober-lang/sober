# TLS

[日本語](tls.ja.md) · [Conformance](README.md)

## Scope

The TLS 1.3 (RFC 8446) server (`std/tls` — `tls.Serve`) and client (under https in `std/http/client`). TLS 1.2 is an explicit opt-in on both sides: `tls.DangerouslyAllowTls12(cfg)` on the server and `dangerouslyAllowTls12` in the client policy. Both raise a warning at every use. The implementation is Sober's own; no external TLS library is used.

## Supported

### Server

<!-- confsync:begin claims tls-server yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.3 (RFC 8446) | Supported | `std/tls.TestTrace`<br>`testdata/tls/trace.golden`: suite 4865 |
| TLS 1.2 (only with an explicit tls.DangerouslyAllowTls12 — the default is 1.3 only, and a peer that offers 1.3 gets 1.3; full handshakes only: no resumption, renegotiation or client certificates) | Partial | interop tls12: ecdhe-rsa-aes128-gcm-X25519 (2026-11-22)<br>interop tls12: tls1.3-stays-1.3 (2026-11-22)<br>tls/reject: tls12 |
| TLS 1.2 suites (server preference): ECDHE-RSA × AES-128-GCM / ChaCha20-Poly1305 / AES-128-CBC-SHA256 / AES-128-CBC-SHA; groups X25519 / secp256r1. ChaCha20 only on machines without AES-NI (of the 94 clients in the SSL Labs client simulation that speak up to 1.2, all 94 connect with AES-NI and 25 without) | Supported | interop tls12: ecdhe-rsa-aes128-gcm-P-256 (2026-11-22)<br>interop tls12: ecdhe-rsa-chacha20-X25519 (2026-11-22)<br>interop tls12: ecdhe-rsa-aes128-cbc-sha256-X25519 (2026-11-22)<br>interop tls12: ecdhe-rsa-aes128-cbc-sha-P-256 (2026-11-22)<br>interop tls12: server-preference (2026-11-22) |
| TLS 1.2 RSA key exchange (AES-128-GCM / CBC-SHA256 / CBC-SHA — implicit rejection that does not tell premaster format errors apart; constant-time decryption checked with dudect). Implemented, but no client in the checked range (the 94 clients of the SSL Labs client simulation) needs it | Partial | interop tls12: rsa-aes128-gcm (2026-11-22)<br>interop tls12: rsa-aes128-cbc-sha (2026-11-22)<br>`std/crypto/rsa.TestDecryptPremaster` |
| TLS 1.2 CBC records: the Lucky13 countermeasure (padding and MAC checks that do not depend on the padding length — dudect); encrypt_then_mac (RFC 7366 — used when the peer offers it); explicit IV = AES_ivKey(sequence number) (ivKey is taken from the key_block past the length shared with the peer — unpredictable and never repeated; RFC 5246 6.2.3.2) | Supported | `std/internal/cbcrec.TestPadRange`<br>`std/internal/cbcrec.TestTamper`<br>interop tls12: cbc-sha256-no-etm (2026-11-22)<br>interop tls12: etm-on (2026-11-22) |
| TLS 1.2 downgrade and renegotiation guards: the downgrade sentinel in the ServerHello random (RFC 8446 4.1.3); TLS_FALLBACK_SCSV gets inappropriate_fallback (RFC 7507); extended master secret (RFC 7627 — used when the peer offers it); renegotiation_info answered empty, and renegotiation after the handshake gets no_renegotiation | Supported | interop tls12: fallback-scsv-rejected (2026-11-22)<br>interop tls12: gcm-no-ems (2026-11-22)<br>interop tls12: renegotiation-refused (2026-11-22) |
| TLS 1.2: a connection that ALPN settles on h2 uses ECDHE + AEAD only (RFC 9113 9.2.2 — a CBC-only peer gets ALPN without h2); ServerKeyExchange signatures rsa_pkcs1_sha256 / rsa_pss_rsae_sha256 / rsa_pkcs1_sha1 | Supported | interop tls12: alpn-h2-with-ecdhe-aead (2026-11-22)<br>interop tls12: alpn-h2-not-with-cbc (2026-11-22)<br>interop tls12: signature-rsa pkcs1 sha1 (2026-11-22)<br>interop tls12: signature-rsa pss rsae sha256 (2026-11-22) |
| ECDSA P-256 certificates (chosen automatically from the key type; one certificate): signatures are ecdsa_secp256r1_sha256 (deterministic nonces per RFC 6979); TLS 1.2 suites are ECDHE-ECDSA × AES-128-GCM / ChaCha20-Poly1305 / AES-128-CBC-SHA256 / AES-128-CBC-SHA (the peer's supported_groups must include secp256r1 — RFC 8422 5.1) | Supported | `std/internal/hsc.TestEcdsaServer`<br>interop tls12: ecdsa-signature-tls1 3 (2026-11-22)<br>interop tls12: ecdsa-signature-tls1 2 (2026-11-22)<br>interop tls12: ecdhe-ecdsa-aes128-gcm-X25519 (2026-11-22)<br>interop tls12: ecdhe-ecdsa-chacha20-P-256 (2026-11-22)<br>interop tls12: ecdhe-ecdsa-aes128-cbc-sha256-X25519 (2026-11-22)<br>interop tls12: ecdhe-ecdsa-aes128-cbc-sha-P-256 (2026-11-22)<br>interop tls12: ecdsa-cert-x25519-only-groups (2026-11-22) |
| TLS_AES_128_GCM_SHA256 | Supported | `testdata/tls/trace.golden`: suite 4865 |
| TLS_CHACHA20_POLY1305_SHA256 (the fallback on machines without AES-NI) | Supported | `testdata/tls/trace.golden`: suite 4867 |
| Key exchange X25519 | Supported | `testdata/tls/trace.golden`: == chacha |
| HelloRetryRequest (asks again for an X25519 key_share) | Supported | `testdata/tls/trace.golden`: == hrr<br>tls/reject: hrr-again |
| RSA certificates (2048 bits or more), signature rsa_pss_rsae_sha256 | Supported | `std/tls.TestTrace` |
| ALPN (RFC 7301 — no_application_protocol on mismatch) | Supported | `testdata/tls/trace.golden`: alpn http/1.1<br>tls/reject: alpn |
| KeyUpdate (answered, and sent before the AES-GCM key usage limit) | Supported | `std/tls.TestFsmNonce` |
| Handshake state machine ≡ the Lean model (with theorems) | Supported | `std/tls.TestFsm`<br>`testdata/tls/fsm.golden`: waitFin |
<!-- confsync:end claims tls-server yes,partial -->

### Client

<!-- confsync:begin claims tls-client yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.3 (default — offers 1.3 only) | Supported | `std/internal/hsc.TestHandshakeAndData`<br>interop tls: p256 (2026-11-08) |
| TLS 1.2 (only with an explicit dangerouslyAllowTls12; 4 suites: ECDHE X25519 × AES-128-GCM / ChaCha20-Poly1305 × ECDSA / RSA) | Partial | interop tls: p256-12-gcm (2026-11-08)<br>interop tls: p256-12-chacha (2026-11-08)<br>interop tls: rsa-12-gcm (2026-11-08)<br>interop tls: rsa-12-chacha (2026-11-08) |
| TLS 1.2: extended master secret (RFC 7627) required; renegotiation_info (RFC 5746) required and renegotiation refused | Supported | interop tls: rsa-12-gcm (2026-11-08) |
| Downgrade sentinel (RFC 8446 4.1.3 — abort when a server picks 1.2 after we offered 1.3) | Supported | `std/internal/hsc.TestDowngradeSentinel` |
| Server signatures ECDSA P-256 / P-384, RSA-PSS (rsae) | Supported | interop tls: p256 (2026-11-08)<br>interop tls: p384 (2026-11-08)<br>interop tls: rsa (2026-11-08) |
| The certificate chain is always verified (there is no setting to turn it off — see the x509 chapter) | Supported | `std/internal/hsc.TestCertFailures`<br>interop http: unknown-ca-refused (2026-11-07) |
| HelloRetryRequest with a cookie | Supported | `std/internal/hsc.TestHelloRetry` |
| HelloRetryRequest asking for secp256r1 (P-256 key exchange — servers without X25519) | Supported | `std/internal/hsc.TestHelloRetryP256`<br>interop tls: p256-ecdhe (2026-11-08) |
| SNI and ALPN in the ClientHello | Supported | `std/internal/hsc.TestHandshakeAndData` |
| CertificateRequest (TLS 1.2 — answered with an empty Certificate; no client certificates) | Partial | interop tls: rsa-12-req (2026-11-08) |
| Rejects a tampered flight | Supported | `std/internal/hsc.TestTamperedFlight` |
<!-- confsync:end claims tls-client yes,partial -->

## Not supported by design

<!-- confsync:begin claims tls-server intentional -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.1 and older, SSL; TLS 1.2 DHE / 3DES / RC4 / static (EC)DH / export / NULL / anon / AES-256 suites; compression, resumption, renegotiation, Heartbeat | Not supported (by design) | interop tls12: tls1.1-rejected (2026-11-22)<br>interop tls12: 3des-rejected (2026-11-22)<br>interop tls12: no-common-suite-aes256-only (2026-11-22) |
| 0-RTT (early data — no replay surface) | Not supported (by design) | none |
| Compression (the CRIME shape) | Not supported (by design) | tls/reject: comp |
| PSK, session resumption, client certificates (mTLS), per-SNI certificates (not until there is a demand) | Not supported (by design) | none |
<!-- confsync:end claims tls-server intentional -->

<!-- confsync:begin claims tls-client intentional -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.2 CBC, RSA key exchange and static DH suites; TLS 1.1 and older | Not supported (by design) | none |
| Session resumption, 0-RTT (NewSessionTicket is discarded) | Not supported (by design) | none |
<!-- confsync:end claims tls-client intentional -->

## Not yet

<!-- confsync:begin claims tls-server planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| TLS_AES_256_GCM_SHA384 | 0.8 | tls/reject: nosuite |
| Key exchange secp256r1 (P-256) | 0.8 | tls/reject: nogroup |
| OCSP stapling | 0.8 | none |
| ALPN for HTTP/2 (h2) | 0.8 | none |
<!-- confsync:end claims tls-server planned -->

## Evidence

### Server rejection suite

Broken or out-of-scope ClientHellos and records are sent one at a time, and the alert sent back (RFC 8446 6) is checked.

<!-- confsync:begin tls-reject -->
| Case | Alert sent |
|---|---|
| tls12 | 70 protocol_version |
| nogroup | 40 handshake_failure |
| nosuite | 40 handshake_failure |
| nosig | 40 handshake_failure |
| comp | 47 illegal_parameter |
| dup | 47 illegal_parameter |
| alpn | 120 no_application_protocol |
| short | 50 decode_error |
| share31 | 47 illegal_parameter |
| zero | 47 illegal_parameter |
| hrr-again | 47 illegal_parameter |
| app-early | 10 unexpected_message |
| ccs2 | 10 unexpected_message |
| tamper | 20 bad_record_mac |
| badfin | 51 decrypt_error |
| overflow | 22 record_overflow |
| inner-overflow | 22 record_overflow |
| plain-overflow | 22 record_overflow |
| legacy-version | 70 protocol_version |
| groups-empty | 50 decode_error |
| sigs-empty | 50 decode_error |
| share-empty-key | 50 decode_error |
| alpn-empty-name | 50 decode_error |
| share-missing | 109 missing_extension |
| alert-empty | 10 unexpected_message |
| sni-empty-list | 50 decode_error |
| sni-empty-name | 50 decode_error |
| sni-trailing | 50 decode_error |
| sni-list-long | 50 decode_error |
| sni-dup-type | 47 illegal_parameter |
| early-skip-over | 10 unexpected_message |
| early-ch2-nocookie | 47 illegal_parameter |
| early-ch2-badcookie | 47 illegal_parameter |
| early-ch2-early | 47 illegal_parameter |
| early-nonempty | 50 decode_error |
| app-after-hrr | 10 unexpected_message |
| fin-short | 50 decode_error |
<!-- confsync:end tls-reject -->

### Record layer and key derivation

Sealing and opening records (AES-128-GCM / ChaCha20-Poly1305, padding, KeyUpdate, segment boundaries) and HKDF-Expand-Label are checked against a Go twin — the numbers are on the "TLS 1.3 record" row of the [cryptography chapter](crypto.md).

### Interop (client — peer = Go crypto/tls)

<!-- confsync:begin interop-tls -->
Last run: 2026-11-08 (tree 858cb8e83ab2 (dirty) — scripts/tlsinterop.sh)

| Go server | Negotiated version |
|---|---|
| p256 | TLS 1.3 |
| p384 | TLS 1.3 |
| rsa | TLS 1.3 |
| p256-ecdhe | TLS 1.3 |
| p256-12-gcm | TLS 1.2 |
| p256-12-chacha | TLS 1.2 |
| rsa-12-gcm | TLS 1.2 |
| rsa-12-chacha | TLS 1.2 |
| rsa-12-req | TLS 1.2 |
<!-- confsync:end interop-tls -->

### Interop (server, TLS 1.2 — peer = openssl s_client)

<!-- confsync:begin interop-tls12 -->
Last run: 2026-11-22 (tree dd14f81dec5b (dirty) — scripts/tls12interop.sh; peer = openssl s_client; the gate tls12interop runs it every time)

| Case | Result |
|---|---|
| ecdhe-rsa-aes128-gcm-X25519 | 1.2 ECDHE-RSA-AES128-GCM-SHA256 |
| ecdhe-rsa-chacha20-X25519 | 1.2 ECDHE-RSA-CHACHA20-POLY1305 |
| ecdhe-rsa-aes128-cbc-sha256-X25519 | 1.2 ECDHE-RSA-AES128-SHA256 |
| ecdhe-rsa-aes128-cbc-sha-X25519 | 1.2 ECDHE-RSA-AES128-SHA |
| ecdhe-rsa-aes128-gcm-P-256 | 1.2 ECDHE-RSA-AES128-GCM-SHA256 |
| ecdhe-rsa-chacha20-P-256 | 1.2 ECDHE-RSA-CHACHA20-POLY1305 |
| ecdhe-rsa-aes128-cbc-sha256-P-256 | 1.2 ECDHE-RSA-AES128-SHA256 |
| ecdhe-rsa-aes128-cbc-sha-P-256 | 1.2 ECDHE-RSA-AES128-SHA |
| rsa-aes128-gcm | 1.2 AES128-GCM-SHA256 |
| rsa-aes128-cbc-sha256 | 1.2 AES128-SHA256 |
| rsa-aes128-cbc-sha | 1.2 AES128-SHA |
| cbc-sha256-no-etm | 1.2 ECDHE-RSA-AES128-SHA256 |
| cbc-sha-no-etm-rsa-kx | 1.2 AES128-SHA |
| gcm-no-ems | 1.2 ECDHE-RSA-AES128-GCM-SHA256 |
| signature-rsa_pkcs1_sha1 | 1.2 |
| signature-rsa_pss_rsae_sha256 | 1.2 |
| etm-on | 1.2 |
| etm-off | 1.2 |
| server-preference | 1.2 ECDHE-RSA-AES128-GCM-SHA256 |
| tls1.3-stays-1.3 | 1.3 TLS_AES_128_GCM_SHA256 |
| alpn-h2-not-with-cbc | 1.2 ECDHE-RSA-AES128-SHA http/1.1 |
| alpn-h2-with-ecdhe-aead | 1.2 ECDHE-RSA-AES128-GCM-SHA256 h2 |
| tls1.1-rejected | refused |
| fallback-scsv-rejected | refused |
| no-common-suite-aes256-only | refused |
| 3des-rejected | refused |
| renegotiation-refused | no_renegotiation |
| ecdhe-ecdsa-aes128-gcm-X25519 | 1.2 ECDHE-ECDSA-AES128-GCM-SHA256 |
| ecdhe-ecdsa-chacha20-X25519 | 1.2 ECDHE-ECDSA-CHACHA20-POLY1305 |
| ecdhe-ecdsa-aes128-cbc-sha256-X25519 | 1.2 ECDHE-ECDSA-AES128-SHA256 |
| ecdhe-ecdsa-aes128-cbc-sha-X25519 | 1.2 ECDHE-ECDSA-AES128-SHA |
| ecdhe-ecdsa-aes128-gcm-P-256 | 1.2 ECDHE-ECDSA-AES128-GCM-SHA256 |
| ecdhe-ecdsa-chacha20-P-256 | 1.2 ECDHE-ECDSA-CHACHA20-POLY1305 |
| ecdhe-ecdsa-aes128-cbc-sha256-P-256 | 1.2 ECDHE-ECDSA-AES128-SHA256 |
| ecdhe-ecdsa-aes128-cbc-sha-P-256 | 1.2 ECDHE-ECDSA-AES128-SHA |
| ecdsa-cbc-sha256-no-etm | 1.2 ECDHE-ECDSA-AES128-SHA256 |
| ecdsa-signature-tls1_2 | ecdsa_secp256r1_sha256 |
| ecdsa-signature-tls1_3 | ecdsa_secp256r1_sha256 |
| ecdsa-server-preference | 1.2 ECDHE-ECDSA-AES128-GCM-SHA256 |
| ecdsa-alpn-h2-with-ecdhe-aead | 1.2 ECDHE-ECDSA-AES128-GCM-SHA256 h2 |
| ecdsa-cert-rsa-suites-only | refused |
| ecdsa-cert-x25519-only-groups | refused |
| ecdsa-cert-no-ecdsa-sigalg | refused |
<!-- confsync:end interop-tls12 -->
