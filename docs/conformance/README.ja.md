# 準拠文書

[English](README.md)

Soberのstdが実装する通信プロトコルと暗号の、規格への準拠の言明。どの章も同じ様式で、**表と数は手で書かずテストの実物から生成し、gate（confsync）が照合する**。テストが通らない・言明に証拠が無い・テストの出した言明を文書が使っていない — のどれかでgateは赤になる。

## 様式

各章は同じ節を持つ:

1. **範囲** — 何の規格のどの役か
2. **対応** — 対応している項目と、その証拠（通ったテスト・通ったベクタの数・ゴールデン・相互接続の記録）
3. **意図して外したこと** — 持たないと決めた項目と理由
4. **未実装** — まだ無い項目と予定の時期
5. **証拠** — 外部オラクル（Wycheproof・NIST CAVP / PKITS・x509-limboほか）ごとの数と、既知の差の分類

「書いていない = 分からない」を無くすのが様式の目的。対応しない項目も、理由か時期つきで表に載せる。

状態の4種:

| 状態 | 意味 |
|---|---|
| 対応 | 実装があり、証拠の列のテスト・ベクタ・記録が通っている |
| 一部 | 実装はあるが範囲が限られる（限り方は項目の文） |
| 意図して非対応 | 持たないと決めた（理由は項目の文） |
| 未実装（時期） | まだ無い・その版の圏で入れる予定 |

## 章

<!-- confsync:begin summary -->
| 章 | 対応 | 一部 | 意図して非対応 | 未実装 |
|---|---:|---:|---:|---:|
| [tls](tls.ja.md) | 18 | 2 | 6 | 5 |
| [x509](x509.ja.md) | 7 | 1 | 4 | 3 |
| [crypto](crypto.ja.md) | 7 | 1 | 2 | 2 |
| [http](http.ja.md) | 20 | 1 | 5 | 7 |
| [dns](dns.ja.md) | 4 | 1 | 3 | 2 |
<!-- confsync:end summary -->

## 証拠の種類

- **テスト**（`std/….TestXxx`）— `sober test` で通るテスト。数の言明はテストが通った後に印字する `conf:` の行から取る
- **ゴールデン**（`testdata/…`・`examples/*.out`）— gateが照合するファイル
- **相互接続** — Goの実装（crypto/tls・net/http・偽のDNSサーバ）を相手に手で回すテスト（`scripts/{tls,http,dns}interop.sh`）。Goの道具が要るのでgateの外で、文書には最終確認の日付と木のコミットを載せる
- **外部オラクルの出所**: Wycheproof（C2SP — Apache-2.0）・NIST CAVP / PKITS（パブリックドメイン）・x509-limbo（C2SP — Apache-2.0）・Mozilla NSS certdata.txt（MPL-2.0）・Goの標準ライブラリとgolang.org/x/crypto（BSD-3-Clause）の値。コピーの出所とコミットは各 `testdata/*/README.md`

## 作り直しと照合

```
scripts/confsync.sh           # 印の中を書き換える
scripts/confsync.sh --check   # gate（生成と現物の一致・証拠の存在・使われない言明）
```

主張の表は `testdata/conformance/claims.tsv`、理由の英訳は `testdata/conformance/en.tsv`、相互接続の記録は `testdata/conformance/interop/`。新しいプロトコル（HTTP/2 = h2spec・QUIC = quic-interop-runner）も、同じ様式に章と外部オラクルの行を足す形で入る。
