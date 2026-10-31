# 環境変数

[English](env.md) | 日本語

環境変数は 3 つの層に分かれます。この頁は 2 つ目と 3 つ目、つまり **Sober のプログラムが実行時に読む環境変数**の一覧です。

1. **コンパイラ（`sober`）が読むもの** — `SOBER_BUILD_CACHE` などです。`sober --help`（開発用のものは `sober --help=dev`）と [CLI の文書](../cli/sober.ja.md) に載っています
2. **生成した実行ファイルのランタイムが読むもの** — Sober で書いたどのプログラムも読みます（コンパイラ自身も Sober のプログラムなので読みます）。下の表です
3. **標準ライブラリが読むもの** — 下の表です

自分のプログラムが読む環境変数は、[std/env](../std/env.ja.md) の表で宣言すると、読みの検査（必須・範囲・真偽の綴り）と一覧（`env.Spec`）がその表から出ます。実例は [examples/env_table.sober](../../examples/env_table.sober) です。

## ランタイムが読むもの

| 変数 | 意味 |
| --- | --- |
| `SOBER_WORKERS` | ワーカーの数（既定はコア数）。変えても標準出力は同じバイトになる |
| `SOBER_PIN` | ワーカーを CPU に固定する（1 で強制・0 で切る。既定は Serve の形のプログラムで許可数が足りるときだけ） |
| `SOBER_REGION_MB` | main の region の大きさの上限（MiB・既定 4096） |
| `SOBER_TASK_REGION_MB` | task の region の大きさの上限（MiB — main より大きくはならない） |
| `SOBER_MADV_MB` | 捨てた region のページを OS へ返すときに、先頭から触れたまま残す量（MiB・0 = 全部返す） |
| `SOBER_COVER` | カバレッジの計器つき（`sober build --cover`）の実行ファイルが、終わりに踏んだ点の印を書くファイル（無ければ書かない） |
| `SOBER_BUDGET_MB` | メモリの天井を固定する（試験用 — 既定は cgroup の memory.max と搭載量から決める） |
| `SOBER_HASH_SEED` | map のハッシュの種（10 進 — 再現用） |
| `SOBER_IO` | io の道を選ぶ（1 / 2 で io_uring を使わない同期の read — 照合用） |
| `SOBER_NET` | 1 でネットワークを epoll の道に固定する（照合用） |
| `SOBER_IO_TRACE` | 1 でワーカーごとの io_uring の確認を標準エラーへ |
| `SOBER_FLIGHT` | 飛行記録の書き出し先のパス（指定したときだけ rt の出来事を記録する） |
| `SOBER_FLIGHT_EV` | 飛行記録の環の大きさ（log2・8〜24・既定 16） |
| `SOBER_SCHED` | ワーカー 1 のときの task の実行順の選び方（試験用） |
| `SOBER_SCHED_SEED` | スケジューラへの遅延注入の種（試験用） |
| `SOBER_SCHED_TRACE` | 1 でスケジューラの出来事を標準エラーへ |
| `SOBER_CHAOS_SEED` | ネットワークの送り・受け・accept への失敗注入の種（試験用・0 = 注入しない） |
| `SOBER_PAR_STATS` | 1 で task ごとの使用量を数えて標準エラーへ |
| `SOBER_DEPTH_REPORT` | 真なら main の正常終了で region の深さの計測を標準エラーへ |
| `SOBER_NOAES` / `SOBER_NOCLMUL` / `SOBER_NOMULX` | 1 で CPU の AES-NI / PCLMULQDQ / MULX を使わない道に倒す（照合用） |

## 標準ライブラリが読むもの

| 変数 | 読む package | 意味 |
| --- | --- | --- |
| `SOBER_NOAES` | std/crypto/aesgcm | ランタイムと同じ（AES-NI を使わない道） |
| `SOBER_DUDECT` | std/internal/dudect | 定数時間の統計の計測の回数（無ければ測らない — テスト用） |
| `SOBER_QUICK_SEED` | std/quick | 性質ベースのテストの種（10 進・New / Named が混ぜる — 無ければ 0。探索を広げるときに変える） |
| `SOBER_QUICK_TRIALS` | std/quick | Check の試行の数（1 以上 — 無ければ Check の trials:・既定 100） |
| `SOBER_TLS_TRACE_LIVE` | std/tls のテスト | TLS の黄金を取り直すときの場合の名前（テスト用） |
