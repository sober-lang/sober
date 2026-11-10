# Cryptography

[日本語](crypto.ja.md) · [Conformance](README.md)

## Scope

The public primitives in `std/crypto` and the implementations inside std (under TLS and X.509). All are Sober's own implementations; no external cryptography library is used.

## Supported

<!-- confsync:begin claims crypto-prims yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| AEAD: AES-128-GCM (AES-NI + PCLMULQDQ), ChaCha20-Poly1305 | Supported | wycheproof/aes-gcm = 316<br>wycheproof/chacha20-poly1305 = 325 |
| Hashes, MAC, KDF: SHA-256, SHA-384 / 512 (internal to std), HMAC-SHA256, HKDF-SHA256 | Supported | wycheproof/hmac-sha256 = 174<br>wycheproof/hkdf-sha256 = 86<br>hashlib/sha512 = 14 |
| Key exchange X25519 | Supported | wycheproof/x25519 = 518 |
| Key exchange P-256 (ECDH, constant-time — TLS secp256r1) | Supported | wycheproof/ecdh_secp256r1 = 355 |
| Signature verification ECDSA P-256 / P-384, RSA-PSS, RSA PKCS#1 v1.5 | Supported | cavp/ecdsa-sigver = 30<br>wycheproof/rsa-pss-2048-sha256-mgf1-32 = 108 |
| Signing (RSA-PSS only — the TLS server's CertificateVerify) | Partial | `std/tls.TestTrace` |
| Constant time for functions that touch secrets (static gate ctcheck — per-function conditional branches checked against a golden) | Supported | `testdata/ctcheck/expect.txt`: aesgcm |
| Password hashing: Argon2id (recommended), bcrypt, PBKDF2-HMAC-SHA256, Verify of PHC strings | Supported | xcrypto/argon2id = 19<br>xcrypto/bcrypt = 18<br>go/pbkdf2-sha256 = 432 |
<!-- confsync:end claims crypto-prims yes,partial -->

## Not supported by design

<!-- confsync:begin claims crypto-prims intentional -->
| Item | Status | Evidence |
|---|---|---|
| Software AES (NoHardware on machines without AES-NI — TLS falls back to ChaCha20-Poly1305) | Not supported (by design) | — |
| scrypt, MD5 / SHA-1 hashes | Not supported (by design) | — |
<!-- confsync:end claims crypto-prims intentional -->

## Not yet

<!-- confsync:begin claims crypto-prims planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| AES-256-GCM | 0.8 | — |
| ECDSA signing (RFC 6979) | 0.8 | — |
<!-- confsync:end claims crypto-prims planned -->

## Evidence — passing vectors

<!-- confsync:begin crypto-vectors -->
| Primitive | Standard | Vector source | Passed |
|---|---|---|---:|
| AES-128-GCM | NIST SP 800-38D | Wycheproof aes_gcm_test.json | 316 (67 AES-128 / 96-bit nonce — the rest checked to be rejected) |
| ChaCha20-Poly1305 | RFC 8439 | Wycheproof chacha20_poly1305_test.json | 325 |
| HMAC-SHA256 | RFC 2104 | Wycheproof hmac_sha256_test.json | 174 |
| HKDF-SHA256 | RFC 5869 | Wycheproof hkdf_sha256_test.json | 86 |
| X25519 | RFC 7748 | Wycheproof x25519_test.json | 518 (rejects 31 all-zero shared secrets) |
| ECDH P-256 | SP 800-56A | Wycheproof ecdh_secp256r1_ecpoint_test.json | 355 |
| RSA-PSS 2048 (verify) | RFC 8017 | Wycheproof rsa_pss_2048_sha256_mgf1_32_test.json | 108 |
| RSA-PSS 2048 (verify) | RFC 8017 | Wycheproof rsa_pss_2048_sha256_mgf1_0_test.json | 103 |
| RSA-PSS 2048 (verify) | RFC 8017 | Go crypto/rsa (SHA-256/384/512) | 36 |
| ECDSA P-256 (verify) | FIPS 186-5 | Wycheproof ecdsa_secp256r1_sha256_test.json (DER) | 484 |
| ECDSA P-256 (verify) | FIPS 186-5 | Wycheproof ecdsa_secp256r1_sha256_p1363_test.json | 262 |
| ECDSA P-384 (verify) | FIPS 186-5 | Wycheproof ecdsa_secp384r1_sha384_test.json (DER) | 504 |
| ECDSA P-384 (verify) | FIPS 186-5 | Wycheproof ecdsa_secp384r1_sha384_p1363_test.json | 280 |
| ECDSA P-256 / P-384 (verify) | FIPS 186-5 | NIST CAVP SigVer | 30 |
| SHA-512 / SHA-384 | FIPS 180-4 | FIPS 180-4 ("abc") | 1 / 1 |
| SHA-512 / SHA-384 | FIPS 180-4 | Python hashlib | 14 / 14 |
| BLAKE2b | RFC 7693 | RFC 7693 Appendix A | 1 |
| BLAKE2b | RFC 7693 | golang.org/x/crypto | 55 |
| Argon2id | RFC 9106 | RFC 9106 5.3 | 1 |
| Argon2id | RFC 9106 | golang.org/x/crypto | 19 |
| bcrypt | — | golang.org/x/crypto | 18 |
| bcrypt | — | golang.org/x/crypto (known answer) | 1 |
| PBKDF2-HMAC-SHA256 | RFC 8018 | RFC 7914 11 | 2 |
| PBKDF2-HMAC-SHA256 | RFC 8018 | Go crypto/pbkdf2 | 432 |
| TLS 1.3 record (AES-128-GCM / ChaCha20-Poly1305) | RFC 8446 | Go crypto/tls record layer (twin) | 22 |
<!-- confsync:end crypto-vectors -->

## Password hashing defaults

The values `std/crypto/password` uses when the cost is omitted (the minimums recommended by the OWASP Password Storage Cheat Sheet). They are revised in std releases and listed in the CHANGELOG. The cost is stored in the hash string, so a change of defaults does not change Verify for values stored earlier.

<!-- confsync:begin password-defaults -->
| Scheme | Default cost when omitted (the head of a value std actually produced) |
|---|---|
| argon2id | `v=19 m=19456,t=2,p=1` |
| bcrypt | `2b cost=10` |
| pbkdf2-sha256 | `i=600000,l=32` |
<!-- confsync:end password-defaults -->
