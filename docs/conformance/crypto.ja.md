# 暗号

[English](crypto.md) · [準拠文書](README.ja.md)

## 範囲

`std/crypto` の公開のプリミティブと、std の内側（TLS・X.509 の下）の実装。どれも Sober の自前の実装で、外部の暗号ライブラリを使わない。

## 対応

<!-- confsync:begin claims crypto-prims yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| AEAD: AES-128-GCM（AES-NI + PCLMULQDQ）・ChaCha20-Poly1305 | 対応 | wycheproof/aes-gcm = 316<br>wycheproof/chacha20-poly1305 = 325 |
| ハッシュ・MAC・KDF: SHA-256・SHA-384 / 512（std の内側）・HMAC-SHA256・HKDF-SHA256 | 対応 | wycheproof/hmac-sha256 = 174<br>wycheproof/hkdf-sha256 = 86<br>hashlib/sha512 = 14 |
| 鍵交換 X25519 | 対応 | wycheproof/x25519 = 518 |
| 鍵交換 P-256（ECDH・定数時間 — TLS の secp256r1） | 対応 | wycheproof/ecdh_secp256r1 = 355 |
| 署名の検証 ECDSA P-256 / P-384・RSA-PSS・RSA PKCS#1 v1.5 | 対応 | cavp/ecdsa-sigver = 30<br>wycheproof/rsa-pss-2048-sha256-mgf1-32 = 108 |
| 署名の生成（RSA-PSS だけ — TLS のサーバの CertificateVerify） | 一部 | `std/tls.TestTrace` |
| 秘密に触る関数の定数時間（静的な網 ctcheck — 関数ごとの条件分岐の列を黄金と照合） | 対応 | `testdata/ctcheck/expect.txt`: aesgcm |
| パスワードハッシュ: Argon2id（推し）・bcrypt・PBKDF2-HMAC-SHA256・PHC 文字列の Verify | 対応 | xcrypto/argon2id = 19<br>xcrypto/bcrypt = 18<br>go/pbkdf2-sha256 = 432 |
<!-- confsync:end claims crypto-prims yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims crypto-prims intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| ソフトウェアの AES（塊の無い機械では NoHardware — TLS は ChaCha20-Poly1305 へ倒れる） | 意図して非対応 | — |
| scrypt・MD5 / SHA-1 のハッシュ | 意図して非対応 | — |
<!-- confsync:end claims crypto-prims intentional -->

## 未実装

<!-- confsync:begin claims crypto-prims planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| AES-256-GCM | 0.8 圏 | — |
| ECDSA の署名（RFC 6979） | 0.8 圏 | — |
<!-- confsync:end claims crypto-prims planned -->

## 証拠 — 通ったベクタ

<!-- confsync:begin crypto-vectors -->
| プリミティブ | 規格 | ベクタの出所 | 通った数 |
|---|---|---|---:|
| AES-128-GCM | NIST SP 800-38D | Wycheproof aes_gcm_test.json | 316（うち AES-128 / 96-bit nonce 67 — 他は拒否を確認） |
| ChaCha20-Poly1305 | RFC 8439 | Wycheproof chacha20_poly1305_test.json | 325 |
| HMAC-SHA256 | RFC 2104 | Wycheproof hmac_sha256_test.json | 174 |
| HKDF-SHA256 | RFC 5869 | Wycheproof hkdf_sha256_test.json | 86 |
| X25519 | RFC 7748 | Wycheproof x25519_test.json | 518（全 0 の共有 31 を拒否） |
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

## パスワードハッシュの既定

`std/crypto/password` で費用を省いたときの値（OWASP Password Storage Cheat Sheet の推奨の下限）。std の版で改訂し、CHANGELOG に載る。費用は保存した文字列に入るので、既定が変わっても前に保存した値の Verify は変わらない。

<!-- confsync:begin password-defaults -->
| 方式 | 省いた費用の既定（std が実際に作った値の頭） |
|---|---|
| argon2id | `v=19 m=19456,t=2,p=1` |
| bcrypt | `2b cost=10` |
| pbkdf2-sha256 | `i=600000,l=32` |
<!-- confsync:end password-defaults -->
