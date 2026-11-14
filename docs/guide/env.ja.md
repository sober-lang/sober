# 環境変数

[English](env.md) | 日本語

環境変数は3つの層に分かれます。このページは2つ目と3つ目、つまりSoberのプログラムが実行時に読む環境変数の一覧です。

1. コンパイラ（`sober`）が読むもの — `SOBER_BUILD_CACHE` などです。`sober --help`（開発用のものは `sober --help=dev`）と [CLIの文書](../cli/sober.ja.md) に載っています
2. 生成した実行ファイルのランタイムが読むもの — Soberで書いたどのプログラムも読みます（コンパイラ自身もSoberのプログラムなので読みます）。下の表です
3. 標準ライブラリが読むもの — 下の表です

自分のプログラムが読む環境変数は、[std/env](../std/env.ja.md) の表で宣言すると、読みの検査（必須・範囲・真偽の綴り）と一覧（`env.Spec`）がその表から出ます。実例は [examples/env_table.sober](../../examples/env_table.sober) です。

## ランタイムが読むもの

| 変数 | 意味 |
| --- | --- |
| `SOBER_WORKERS` | ワーカーの数（既定はコア数）。変えても標準出力は同じバイトになる |
| `SOBER_PIN` | ワーカーのCPUの固定（2 = 強制でCPU 1つへ・1 = 強制でL3キャッシュを共有するCPUのグループへ・0 = 切る。既定はServeの形のプログラムで許可数が足りるときだけCPU 1つへ） |
| `SOBER_REGION_MB` | mainのregionの大きさの上限（MiB・既定4096） |
| `SOBER_TASK_REGION_MB` | taskのregionの大きさの上限（MiB — mainより大きくはならない） |
| `SOBER_MADV_MB` | 捨てたregionのページをOSへ返すときに、先頭から触れたまま残す量（MiB・0 = 全部返す） |
| `SOBER_COVER` | カバレッジの計装つき（`sober build --cover`）の実行ファイルが、終わりに、実行された箇所のフラグを書くファイル（無ければ書かない） |
| `SOBER_BUDGET_MB` | メモリの上限を固定する（試験用 — 既定はcgroupのmemory.maxと搭載量から決める） |
| `SOBER_HASH_SEED` | mapのハッシュのシード（10進 — 再現用） |
| `SOBER_IO` | ioのパスを選ぶ（1 / 2でio_uringを使わない同期のread — 照合用） |
| `SOBER_NET` | 1でネットワークをepollのパスに固定する（照合用） |
| `SOBER_NET_FUSE` | 0で、keep-aliveのHTTP（平文）のレスポンスの送信を、完了を待たずに次のリクエストの受信へ進む形にしない（問題の切り分け用・既定は有効） |
| `SOBER_TASK_WIN` | 0で、接続のtaskの浅いregionを、taskの領域の末尾のページから始める形にしない（問題の切り分け用・既定は有効） |
| `SOBER_MDWE` | 0で、起動時に実行可能メモリを放棄する保護（`PR_SET_MDWE`・Linux 6.6以上）を切る。動的計装（valgrindなど）と同居させるときに使う（既定は有効） |
| `SOBER_MDWE_REPORT` | 0以外で、mainの正常終了のときに、上の保護の状態を標準エラーへ（試験用） |
| `SOBER_IO_TRACE` | 1でワーカーごとのio_uringの確認を標準エラーへ |
| `SOBER_FLIGHT` | フライトレコーダーの書き出し先のパス（指定したときだけrtの出来事を記録する） |
| `SOBER_FLIGHT_EV` | フライトレコーダーのリングバッファの大きさ（log2・8〜24・既定16） |
| `SOBER_SCHED` | ワーカー1のときのtaskの実行順の選び方（試験用） |
| `SOBER_SCHED_SEED` | スケジューラへの遅延注入のシード（試験用） |
| `SOBER_SCHED_TRACE` | 1でスケジューラの出来事を標準エラーへ |
| `SOBER_CHAOS_SEED` | ネットワークの送り・受け・acceptへの失敗注入のシード（試験用・0 = 注入しない） |
| `SOBER_PAR_STATS` | 1でtaskごとの使用量を数えて標準エラーへ |
| `SOBER_DEPTH_REPORT` | 真ならmainの正常終了でregionの深さの計測を標準エラーへ |
| `SOBER_NOAES` / `SOBER_NOCLMUL` / `SOBER_NOMULX` | 1でCPUのAES-NI / PCLMULQDQ / MULXを使わないパスにフォールバックする（照合用） |

## 標準ライブラリが読むもの

| 変数 | 読むpackage | 意味 |
| --- | --- | --- |
| `SOBER_NOAES` | std/crypto/aesgcm | ランタイムと同じ（AES-NIを使わないパス） |
| `SOBER_DUDECT` | std/internal/dudect | 定数時間の統計の計測の回数（無ければ測らない — テスト用） |
| `SOBER_TLS_INTEROP` | std/internal/hsc | TLSのクライアントの相互接続のテストのディレクトリ（scripts/tlsinterop.shがGoのサーバを起動して渡す — 無ければ繋がない・テスト用） |
| `SOBER_PG_ORACLE` | std/internal/pgwire | 実のPostgreSQLとの往復のテストの設定のファイル（scripts/pgoracle.shがPostgreSQL 17 / 18を立てて渡す — 無ければ繋がない・テスト用） |
| `SOBER_DNS_FAKE` | std/net | 名前の解決の送受のテストの偽のDNSサーバのport（scripts/dnsinterop.shが渡す — 無ければ問わない・テスト用） |
| `SOBER_HTTP_INTEROP` | std/http/client | HTTPクライアントの相互接続のテストのディレクトリ（scripts/httpinterop.shがGoのnet/httpのサーバを起動して渡す — 無ければ繋がない・テスト用） |
| `SOBER_QUICK_SEED` | std/quick | プロパティベーステストのシード（10進・New / Namedが混ぜる — 無ければ0。探索を広げるときに変える） |
| `SOBER_QUICK_TRIALS` | std/quick | Checkの試行の数（1以上 — 無ければCheckのtrials:・既定100） |
| `SOBER_TLS_TRACE_LIVE` | std/tlsのテスト | TLSのゴールデンを取り直すときの場合の名前（テスト用） |
