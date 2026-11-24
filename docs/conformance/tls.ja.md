# TLS

[English](tls.md) · [準拠文書](README.ja.md)

## 範囲

TLS 1.3（RFC 8446）のサーバ（`std/tls` — `tls.Serve`）とクライアント（`std/http/client` のhttpsの下）。TLS 1.2はサーバーとクライアントの両方で明示のopt-in（サーバーは `tls.DangerouslyAllowTls12(cfg)`・クライアントはpolicyの `dangerouslyAllowTls12`）。どちらも使う点で毎回警告が出る。実装はSoberの自前で、外部のTLSライブラリを使わない。

## 対応

### サーバ

<!-- confsync:begin claims tls-server yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.3（RFC 8446） | 対応 | `std/tls.TestTrace`<br>`testdata/tls/trace.golden`: suite 4865 |
| TLS 1.2（tls.DangerouslyAllowTls12の明示でだけ — 既定は1.3だけ・1.3を申し出る相手は1.3。完全なhandshakeだけ: 再開・再交渉・クライアント証明書なし） | 一部 | 相互接続tls12: ecdhe-rsa-aes128-gcm-X25519（2026-11-22）<br>相互接続tls12: tls1.3-stays-1.3（2026-11-22）<br>tls/reject: tls12 |
| TLS 1.2のスイート（サーバーの好みの順）: ECDHE-RSA × AES-128-GCM / ChaCha20-Poly1305 / AES-128-CBC-SHA256 / AES-128-CBC-SHA・群X25519 / secp256r1。AES-NIの無い機械ではChaCha20だけ（SSL Labsのクライアントの模擬で1.2まで話す94件のうち、AES-NIのある機械では94件・無い機械では25件が繋がる） | 対応 | 相互接続tls12: ecdhe-rsa-aes128-gcm-P-256（2026-11-22）<br>相互接続tls12: ecdhe-rsa-chacha20-X25519（2026-11-22）<br>相互接続tls12: ecdhe-rsa-aes128-cbc-sha256-X25519（2026-11-22）<br>相互接続tls12: ecdhe-rsa-aes128-cbc-sha-P-256（2026-11-22）<br>相互接続tls12: server-preference（2026-11-22） |
| TLS 1.2のRSA鍵交換（AES-128-GCM / CBC-SHA256 / CBC-SHA — premasterの形の誤りを区別しない暗黙の拒否・定数時間の復号〔dudect〕）。実装はあるが、照合の範囲（SSL Labsのクライアントの模擬94件）では使う相手が見つかっていない | 一部 | 相互接続tls12: rsa-aes128-gcm（2026-11-22）<br>相互接続tls12: rsa-aes128-cbc-sha（2026-11-22）<br>`std/crypto/rsa.TestDecryptPremaster` |
| TLS 1.2のCBCの記録: Lucky13の対策（埋め草とMACの検査を埋め草の長さに依らない処理で — dudect）・encrypt_then_mac（RFC 7366 — 相手が出せば使う）・明示のIV = AES_ivKey(番号)（ivKeyはkey_blockを相手と共有する長さより長く取った末尾 — 予測できず繰り返さない。RFC 5246 6.2.3.2） | 対応 | `std/internal/cbcrec.TestPadRange`<br>`std/internal/cbcrec.TestTamper`<br>相互接続tls12: cbc-sha256-no-etm（2026-11-22）<br>相互接続tls12: etm-on（2026-11-22） |
| TLS 1.2の降格と再交渉の守り: ServerHelloのrandomの降格の番兵（RFC 8446 4.1.3）・TLS_FALLBACK_SCSVはinappropriate_fallback（RFC 7507）・extended master secret（RFC 7627 — 相手が出せば使う）・renegotiation_infoは空で返し、接続の後の再交渉はno_renegotiation | 対応 | 相互接続tls12: fallback-scsv-rejected（2026-11-22）<br>相互接続tls12: gcm-no-ems（2026-11-22）<br>相互接続tls12: renegotiation-refused（2026-11-22） |
| TLS 1.2: ALPNでh2に決まる接続はECDHE + AEADだけ（RFC 9113 9.2.2 — CBCだけの相手にはh2を除いたALPN）・ServerKeyExchangeの署名rsa_pkcs1_sha256 / rsa_pss_rsae_sha256 / rsa_pkcs1_sha1 | 対応 | 相互接続tls12: alpn-h2-with-ecdhe-aead（2026-11-22）<br>相互接続tls12: alpn-h2-not-with-cbc（2026-11-22）<br>相互接続tls12: signature-rsa pkcs1 sha1（2026-11-22）<br>相互接続tls12: signature-rsa pss rsae sha256（2026-11-22） |
| 証明書ECDSA P-256（鍵の種類で自動で選ぶ — 証明書は1本）: 署名はecdsa_secp256r1_sha256（RFC 6979の決定的なnonce）・TLS 1.2のスイートはECDHE-ECDSA × AES-128-GCM / ChaCha20-Poly1305 / AES-128-CBC-SHA256 / AES-128-CBC-SHA（相手のsupported_groupsにsecp256r1が要る — RFC 8422 5.1） | 対応 | `std/internal/hsc.TestEcdsaServer`<br>相互接続tls12: ecdsa-signature-tls1 3（2026-11-22）<br>相互接続tls12: ecdsa-signature-tls1 2（2026-11-22）<br>相互接続tls12: ecdhe-ecdsa-aes128-gcm-X25519（2026-11-22）<br>相互接続tls12: ecdhe-ecdsa-chacha20-P-256（2026-11-22）<br>相互接続tls12: ecdhe-ecdsa-aes128-cbc-sha256-X25519（2026-11-22）<br>相互接続tls12: ecdhe-ecdsa-aes128-cbc-sha-P-256（2026-11-22）<br>相互接続tls12: ecdsa-cert-x25519-only-groups（2026-11-22） |
| TLS_AES_128_GCM_SHA256 | 対応 | `testdata/tls/trace.golden`: suite 4865 |
| TLS_CHACHA20_POLY1305_SHA256（AES-NIの無い機械のフォールバック先） | 対応 | `testdata/tls/trace.golden`: suite 4867 |
| 鍵交換X25519 | 対応 | `testdata/tls/trace.golden`: == chacha |
| HelloRetryRequest（X25519のkey_shareを求め直す） | 対応 | `testdata/tls/trace.golden`: == hrr<br>tls/reject: hrr-again |
| 証明書RSA（2048 bit以上）・署名rsa_pss_rsae_sha256 | 対応 | `std/tls.TestTrace` |
| ALPN（RFC 7301 — 一致しなければno_application_protocol） | 対応 | `testdata/tls/trace.golden`: alpn http/1.1<br>tls/reject: alpn |
| KeyUpdate（受けて応じる・AES-GCMの鍵の使用上限の手前で自分から送る） | 対応 | `std/tls.TestFsmNonce` |
| handshakeの状態機械 ≡ Leanのモデル（定理つき） | 対応 | `std/tls.TestFsm`<br>`testdata/tls/fsm.golden`: waitFin |
<!-- confsync:end claims tls-server yes,partial -->

### クライアント

<!-- confsync:begin claims tls-client yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.3（既定 — 1.3だけを申し出る） | 対応 | `std/internal/hsc.TestHandshakeAndData`<br>相互接続tls: p256（2026-11-08） |
| TLS 1.2（dangerouslyAllowTls12の明示でだけ・ECDHE X25519 × AES-128-GCM / ChaCha20-Poly1305 × ECDSA / RSAの4 suite） | 一部 | 相互接続tls: p256-12-gcm（2026-11-08）<br>相互接続tls: p256-12-chacha（2026-11-08）<br>相互接続tls: rsa-12-gcm（2026-11-08）<br>相互接続tls: rsa-12-chacha（2026-11-08） |
| TLS 1.2: extended master secret（RFC 7627）必須・renegotiation_info（RFC 5746）必須で再交渉は断る | 対応 | 相互接続tls: rsa-12-gcm（2026-11-08） |
| 降格の目印（RFC 8446 4.1.3 — 1.3を申し出て1.2を選んだサーバは中止） | 対応 | `std/internal/hsc.TestDowngradeSentinel` |
| サーバの署名ECDSA P-256 / P-384・RSA-PSS（rsae） | 対応 | 相互接続tls: p256（2026-11-08）<br>相互接続tls: p384（2026-11-08）<br>相互接続tls: rsa（2026-11-08） |
| 証明書チェーンは常に検証する（検証を切る設定は無い — x509の章） | 対応 | `std/internal/hsc.TestCertFailures`<br>相互接続http: unknown-ca-refused（2026-11-07） |
| HelloRetryRequestのcookie | 対応 | `std/internal/hsc.TestHelloRetry` |
| secp256r1を求めるHelloRetryRequest（P-256の鍵交換 — X25519を受けないサーバ） | 対応 | `std/internal/hsc.TestHelloRetryP256`<br>相互接続tls: p256-ecdhe（2026-11-08） |
| SNI・ALPNの申し出 | 対応 | `std/internal/hsc.TestHandshakeAndData` |
| CertificateRequest（TLS 1.2 — 空のCertificateで答える。クライアント証明書は持たない） | 一部 | 相互接続tls: rsa-12-req（2026-11-08） |
| 改竄したflightの拒否 | 対応 | `std/internal/hsc.TestTamperedFlight` |
<!-- confsync:end claims tls-client yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims tls-server intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.1以前・SSL・1.2のDHE / 3DES / RC4 / 静的 (EC)DH / export / NULL・anon / AES-256のスイート・圧縮・再開・再交渉・Heartbeat | 意図して非対応 | 相互接続tls12: tls1.1-rejected（2026-11-22）<br>相互接続tls12: 3des-rejected（2026-11-22）<br>相互接続tls12: no-common-suite-aes256-only（2026-11-22） |
| 0-RTT（early data — 再送の攻撃面を持たない） | 意図して非対応 | なし |
| 圧縮（CRIMEの形） | 意図して非対応 | tls/reject: comp |
| PSK・session resumption・クライアント証明書（mTLS）・SNIごとの証明書の切り替え（実需が出るまで持たない） | 意図して非対応 | なし |
<!-- confsync:end claims tls-server intentional -->

<!-- confsync:begin claims tls-client intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.2のCBC・RSA鍵交換・静的DHのsuite・TLS 1.1以前 | 意図して非対応 | なし |
| session resumption・0-RTT（NewSessionTicketは読み捨てる） | 意図して非対応 | なし |
<!-- confsync:end claims tls-client intentional -->

## 未実装

<!-- confsync:begin claims tls-server planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| TLS_AES_256_GCM_SHA384 | 0.8圏 | tls/reject: nosuite |
| 鍵交換secp256r1（P-256） | 0.8圏 | tls/reject: nogroup |
| OCSP stapling | 0.8圏 | なし |
| HTTP/2のALPN（h2） | 0.8圏 | なし |
<!-- confsync:end claims tls-server planned -->

## 証拠

### サーバの拒否のテスト

壊れた・範囲外のClientHelloとrecordを1枚ずつ送り、返すalert（RFC 8446 6）を照合する。

<!-- confsync:begin tls-reject -->
| 題材 | 返すalert |
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

### record層と鍵の導出

recordの封と開け（AES-128-GCM / ChaCha20-Poly1305・0埋め・KeyUpdate・切片の境界）とHKDF-Expand-Labelは比較用のGoの実装と照合する — 数は[暗号の章](crypto.ja.md)の「TLS 1.3 record」の行。

### 相互接続（クライアント — 相手 = Go crypto/tls）

<!-- confsync:begin interop-tls -->
最終確認: 2026-11-08（木858cb8e83ab2 (dirty) — scripts/tlsinterop.sh）

| Goのサーバ | 繋がった版 |
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

### 相互接続（サーバー・TLS 1.2 — 相手 = openssl s_client）

<!-- confsync:begin interop-tls12 -->
最終確認: 2026-11-22（木dd14f81dec5b (dirty) — scripts/tls12interop.sh・相手 = openssl s_client・ゲートtls12interopでも毎回回る）

| 件 | 結果 |
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
