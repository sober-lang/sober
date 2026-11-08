# testdata/x509

std/internal/x509 の網（x509_test.sober が `@embed` で読む）。

- `go/*.pem`: Go の crypto/x509 の verify_test.go に埋め込まれた証明書 36 本（Go 1.26.1 — BSD-3-Clause・Copyright The Go Authors）。const の名前をファイル名に
- `pkits/certs.txt`・`pkits/vectors.json`: NIST PKITS（Path Validation Testing Program — 米国政府の著作物でパブリックドメイン）の証明書 405 本と経路の期待値。
  Go の GOROOT の crypto/x509/testdata/nist-pkits から。証明書は 1 行 = `ファイル名 DER の base64`（文字列の @embed に載せるため — 中身は変えていない）。CRL は写していない（失効は見ない — 裁定 2026-11-05）
- `fields.txt`: Go の crypto/x509 で読んだ欄の 1 行 1 証明書（scripts/oracles/crypto_x509.go で再生成）
- `limbo/limbo.json`: x509-limbo（github.com/C2SP/x509-limbo 519f4bcf — Apache-2.0）の抜き出し 172 題材（scripts/limbo.ts — 採る名前空間と外す機能は道具の頭の注）。chain_test.sober の TestLimbo が読む
- `nss/certdata.txt.gz`・`nss/SOURCE`: 信頼ストアの取り込み元（Mozilla NSS の certdata.txt — MPL-2.0）と出所の銘（タグ・取得日・SHA-256）。scripts/rootstore.sh が置き、gate rootsync が照合する
