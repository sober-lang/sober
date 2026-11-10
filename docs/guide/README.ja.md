# 利用ガイド

[English](README.md) | 日本語

Sober を初めて使う人のための導線です。上から順に読めば、インストールから並列のプログラムまで書けるようになります。

1. [インストール](install.ja.md) — Zig とソースだけでコンパイラを建てる
2. [最初のプログラム](first-program.ja.md) — 入力を読んで数える・package を分ける・テストを書く
3. [言語ツアー](tour.ja.md) — 式・関数・コレクション・型・エラー・mut・並列を、動く短い例で
4. [抽象化 — interface の代わりに](abstraction.ja.md) — 関数型・関数の欄の struct・union で、他の言語の interface を書き直す
5. [並行 — task・チャネル・domain](concurrency.ja.md) — scope と子の task・不変の値を渡す・チャネル・失敗と死・多くの task から 1 つの状態へ（domain）・何が決定的に約束されるか
6. [テストの書き方](testing.ja.md) — 小さな package に単体テスト・プロパティベーステスト・カバレッジ・ミューテーションテスト・ファジングの順でテストを足していく
7. [標準ライブラリの案内](std.ja.md) — package ごとの地図
8. [Web クライアント](web-client.ja.md) — `std/http/client` で外の HTTP API を呼ぶ: 一発の要求・失敗のラベル・cookie を値で運ぶ・本文の切片・keep-alive の束
9. [Web サーバ](web-server.ja.md) — `std/http/server` で HTTP を受ける: ルーティング・状態の置き場・ストリームと SSE・cookie の安全な既定・ログインのセッション・TLS・本番で走らせる
10. [PostgreSQL](postgres.ja.md) — `std/pg` でデータベースを使う: TLS と SCRAM で繋ぐ・SQL の文面は const の席・行の読み・失敗のラベル・トランザクション・接続のプール
11. [安全性ガイド](security.ja.md) — 脅威ごとに、Sober が何をどう消し、何を書き手に残すか
12. [環境変数](env.ja.md) — Sober のプログラムが実行時に読む環境変数（ランタイムと標準ライブラリ）

ガイドのコード例はすべて `examples/` にある実物で、コンパイラの検査の網（`scripts/gates.sh`）が毎回建てて走らせ、出力を照合しています（PostgreSQL の例だけは網が DB を持たないので建てて検査までで、走らせて照合するのは `scripts/pgoracle.sh`）。

設計の「なぜ」は [設計ノート](../design-notes/) に、言語の正確な定義は [言語仕様](../spec/README.ja.md)（規則だけ）に、決定の経緯は [決定の記録](../language.md)（開発者向け）にあります。
