# testdata/wycheproof

[Wycheproof](https://github.com/C2SP/wycheproof)（C2SP — Apache License 2.0）のテストベクタの写し。std/crypto の網（examples/crypto_wycheproof_*.sober が `@embed` で読む — report-790 / 792）。

- 出所: `testvectors_v1/` の同名のファイル・コミット 7a325932231bd7a724c791c8b0d65ea4d6d2f435（2026-10-12）。中身は変えていない
- ライセンス: Apache License 2.0（Copyright Google LLC / C2SP の Wycheproof の作者）— 公開同期のときは NOTICE に出所を 1 行
- ECDSA の 4 ファイル（`ecdsa_secp256r1_sha256{,_p1363}_test.json`・`ecdsa_secp384r1_sha384{,_p1363}_test.json` — 2026-11-05 に同じコミットから足した）は std/internal/ec の white-box テスト（ec_test.sober）が読む
- ECDH の 1 ファイル（`ecdh_secp256r1_ecpoint_test.json` — 2026-11-08 に同じコミットから足した）は std/internal/p256 の white-box テスト（p256_test.sober）が読む
