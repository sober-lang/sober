# testdata/crypto

std/crypto の網（examples/crypto_rsa・testdata/ctcheck — report-795）の試験用の鍵と証明書。**どれも試験専用 — 秘密ではない**。

- `rsa2048.key` — `openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048` で作った試験用の鍵（PKCS#8 の PEM）
- `httparena-server.key` / `httparena-server.crt` — HttpArena（MDA2AV/HttpArena — MIT）の `certs/` の写し。harness が `/certs` に置く RSA-2048 の自己署名の対（公開済みの試験用）。Sober の TLS が本番の採点で読むのと同じ形の鍵で網を張るため
