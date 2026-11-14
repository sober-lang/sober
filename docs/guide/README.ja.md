# 利用ガイド

[English](README.md) | 日本語

Soberを初めて使う人のための導線です。上から順に読めば、インストールから並列のプログラムまで書けるようになります。

1. [インストール](install.ja.md) — Zigとソースだけでコンパイラをビルドする
2. [最初のプログラム](first-program.ja.md) — 入力を読んで数える・packageを分ける・テストを書く
3. [言語ツアー](tour.ja.md) — 式・関数・コレクション・型・エラー・mut・並列を、動く短い例で
4. [抽象化 — interfaceの代わりに](abstraction.ja.md) — 関数型・関数のフィールドを持つstruct・unionで、他の言語のinterfaceを書き直す
5. [並行 — task・チャネル・domain](concurrency.ja.md) — scopeと子のtask・不変の値を渡す・チャネル・失敗と死・多くのtaskから1つの状態へ（domain）・何が決定的に約束されるか
6. [テストの書き方](testing.ja.md) — 小さなpackageに単体テスト・プロパティベーステスト・カバレッジ・ミューテーションテスト・ファジングの順でテストを足していく
7. [標準ライブラリの案内](std.ja.md) — packageごとの地図
8. [Webクライアント](web-client.ja.md) — `std/http/client` で外のHTTP APIを呼ぶ: 単発のリクエスト・失敗のラベル・cookieを値で運ぶ・本文の切片・keep-aliveのセッション
9. [Webサーバ](web-server.ja.md) — `std/http/server` でHTTPを受ける: ルーティング・状態の置き場所・ストリームとSSE・cookieの安全な既定・ログインのセッション・TLS・本番で走らせる
10. [PostgreSQL](postgres.ja.md) — `std/pg` でデータベースを使う: TLSとSCRAMで繋ぐ・SQLの文面はconst仮引数・行の読み・失敗のラベル・トランザクション・接続のプール
11. [安全性ガイド](security.ja.md) — 脅威ごとに、Soberが何をどう消し、何を書き手に残すか
12. [環境変数](env.ja.md) — Soberのプログラムが実行時に読む環境変数（ランタイムと標準ライブラリ）

ガイドのコード例はすべて `examples/` にある実物で、コンパイラの検査一式（`scripts/gates.sh`）が毎回ビルドして走らせ、出力を照合しています（PostgreSQLの例だけは検査一式がDBを持たないのでビルドして検査までで、走らせて照合するのは `scripts/pgoracle.sh`）。

設計の「なぜ」は [設計ノート](../design-notes/) に、言語の正確な定義は [言語仕様](../spec/README.ja.md)（規則だけ）に、決定の経緯は [決定の記録](../language.md)（開発者向け）にあります。
