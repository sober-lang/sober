# testdata/crypto

std/crypto の網（examples/crypto_rsa・testdata/ctcheck — report-795）の試験用の鍵と証明書。**どれも試験専用 — 秘密ではない**。

- `rsa2048.key` — `openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048` で作った試験用の鍵（PKCS#8 の PEM）
- `httparena-server.key` / `httparena-server.crt` — HttpArena（MDA2AV/HttpArena — MIT）の `certs/` の写し。harness が `/certs` に置く RSA-2048 の自己署名の対（公開済みの試験用）。Sober の TLS が本番の採点で読むのと同じ形の鍵で網を張るため
- `p256_base.txt` — P-256 の基点のスカラー倍 d·G の 30 組（`d Q` の行 — Q は非圧縮）。std の P-256 と独立の node:crypto で作った（scripts/p256vec.ts — d は端の値と SHA-256 から導いた決定的な値）。std/internal/p256 の p256_test.sober が読む
- `ecdsa-server.key` / `ecdsa-server.crt` — P-256 の ECDSA の自己署名の対（`openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:P-256` と `openssl req -x509` — CN・SAN・期間は httparena-server.crt に揃えた）。ECDSA の証明書のサーバーの試験（std/internal/hsc の TestEcdsaServer・scripts/tls12interop.sh の 2 本目のサーバー）
- `ecdsa_p256_det.txt` — P-256 / SHA-256 の決定的な ECDSA の署名（RFC 6979）の 48 組（`d h r s` の行）。std の P-256 と独立の openssl（`pkeyutl -pkeyopt nonce-type:1`）で作った（scripts/ecdsavec.ts — d と h は端の値と SHA-256 から導いた決定的な値）。std/internal/p256 の sign_test.sober が読む
