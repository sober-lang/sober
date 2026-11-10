# TLS

[日本語](tls.ja.md) · [Conformance](README.md)

## Scope

The TLS 1.3 (RFC 8446) server (`std/tls` — `tls.Serve`) and client (under https in `std/http/client`). TLS 1.2 is only an explicit opt-in on the client. The implementation is Sober's own; no external TLS library is used.

## Supported

### Server

<!-- confsync:begin claims tls-server yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.3 (RFC 8446) | Supported | `std/tls.TestTrace`<br>`testdata/tls/trace.golden`: suite 4865 |
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
| TLS 1.2 and older, SSL (the server is 1.3-only — no downgrade, renegotiation or CBC surface by construction; 1.2 clients go through an LB or proxy) | Not supported (by design) | tls/reject: tls12 |
| 0-RTT (early data — no replay surface) | Not supported (by design) | — |
| Compression (the CRIME shape) | Not supported (by design) | tls/reject: comp |
| PSK, session resumption, client certificates (mTLS), per-SNI certificates (not until there is a demand) | Not supported (by design) | — |
<!-- confsync:end claims tls-server intentional -->

<!-- confsync:begin claims tls-client intentional -->
| Item | Status | Evidence |
|---|---|---|
| TLS 1.2 CBC, RSA key exchange and static DH suites; TLS 1.1 and older | Not supported (by design) | — |
| Session resumption, 0-RTT (NewSessionTicket is discarded) | Not supported (by design) | — |
<!-- confsync:end claims tls-client intentional -->

## Not yet

<!-- confsync:begin claims tls-server planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| TLS_AES_256_GCM_SHA384 | 0.8 | tls/reject: nosuite |
| Key exchange secp256r1 (P-256) | 0.8 | tls/reject: nogroup |
| ECDSA P-256 certificates (signatures per RFC 6979) | 0.8 | tls/reject: nosig |
| OCSP stapling | 0.8 | — |
| ALPN for HTTP/2 (h2) | 0.8 | — |
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
