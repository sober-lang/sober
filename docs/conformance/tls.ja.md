# TLS

[English](tls.md) · [準拠文書](README.ja.md)

## 範囲

TLS 1.3（RFC 8446）のサーバ（`std/tls` — `tls.Serve`）とクライアント（`std/http/client` のhttpsの下）。TLS 1.2はクライアントの明示のopt-inだけ。実装はSoberの自前で、外部のTLSライブラリを使わない。

## 対応

### サーバ

<!-- confsync:begin claims tls-server yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.3（RFC 8446） | 対応 | `std/tls.TestTrace`<br>`testdata/tls/trace.golden`: suite 4865 |
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
| TLS 1.2以前・SSL（サーバは1.3だけ — 降格・再交渉・CBCの面を構造的に持たない。1.2の客はLB / プロキシで受ける） | 意図して非対応 | tls/reject: tls12 |
| 0-RTT（early data — 再送の攻撃面を持たない） | 意図して非対応 | — |
| 圧縮（CRIMEの形） | 意図して非対応 | tls/reject: comp |
| PSK・session resumption・クライアント証明書（mTLS）・SNIごとの証明書の切り替え（実需が出るまで持たない） | 意図して非対応 | — |
<!-- confsync:end claims tls-server intentional -->

<!-- confsync:begin claims tls-client intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| TLS 1.2のCBC・RSA鍵交換・静的DHのsuite・TLS 1.1以前 | 意図して非対応 | — |
| session resumption・0-RTT（NewSessionTicketは読み捨てる） | 意図して非対応 | — |
<!-- confsync:end claims tls-client intentional -->

## 未実装

<!-- confsync:begin claims tls-server planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| TLS_AES_256_GCM_SHA384 | 0.8圏 | tls/reject: nosuite |
| 鍵交換secp256r1（P-256） | 0.8圏 | tls/reject: nogroup |
| 証明書ECDSA P-256（署名はRFC 6979） | 0.8圏 | tls/reject: nosig |
| OCSP stapling | 0.8圏 | — |
| HTTP/2のALPN（h2） | 0.8圏 | — |
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
