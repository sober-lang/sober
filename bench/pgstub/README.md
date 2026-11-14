# pgstub — PostgreSQLのwire protocolだけを話す代役

計測の道具。本物のPostgreSQLの無い実行環境（gates・CI）で、async-dbの客側（std/pgのBindの符号化・行の受け・JSONの組み立て）を本物と同じパスで通すための、決まったレスポンスを返す小さなサーバ。

- 平文・trust（認証を求めずにAuthenticationOk）。SSLRequestには 'N'
- 拡張問い合わせ（Parse / Describe / Bind / Execute / Close / Sync / Flush / Terminate）だけを話す。単純問い合わせと表に無い文面はErrorResponse
- SQLは解釈しない: 文面を鍵に固定の表（`items.sober` の `shapeOf` / `answerOf`）を引く。今ある文面はasync-dbの1本だけ
- バッチ（Sync / Flush / Terminateまで）へのレスポンスは1回のSendで丸ごと送る — 客のrecvの切れ目を代役の都合で揺らさない
- `delay-us` を与えると、起動の後のバッチへのレスポンスの前に回して待つ。目的は、客（サーバ）がレスポンスを読みに来た時点ではまだ届いていない形 — 本物のPGと同じく、
  レスポンスを待つパスを毎回必ず通る形 — に揃えて、客の命令の数えを決定的にすること（待たせないと、読みに来た時点で届いているかが回ごとに変わり、
  callgrindの数えがリクエストあたり30命令ほど揺れる）。reqinstは300。待たせても残る ±6命令/リクエストは客のrtの待ちのパス（スリープ前のスピン・ウェイクアップのパス）の揺れで、
  reqinstのasyncdbの上限値はその分の余白（実測の最大 + 25）で引く

## ビルドと使い方

```
out/stage2/sober2 build bench/pgstub --emit=elf --passes -o <pgstub>   # 入口はディレクトリ（package main が複数のファイル）
<pgstub> [port] [delay-us]                                               # 127.0.0.1:<port>（既定 0 = 空き番号）・"ready <port>" を出す
DATABASE_URL=postgres://bench:bench@127.0.0.1:<port>/benchmark <サーバ>   # user / password / db は何でも通る
```

## ファイルの配置

| ファイル | 中身 |
|---|---|
| `main.sober` | エントリポイント（listen・接続ごとに1 task） |
| `wire.sober` | wireのサーバ側: 枠の切り出し・符号化・接続の状態。表の中身は知らない |
| `items.sober` | 固定の表からレスポンスを返す部品（文面・引数と列の形・Bindの引数 → 行） |
| `table.sober` | 表の50行（生成物 — `gen-items.ts <data/pgdb-seed.sql>`） |
| `trace-items.hex` | 本物のPG 18から録ったasync-dbの文の往復（`cap.ts`） |
| `replay.ts` | 照合: 記録のリクエストを代役へ流し、レスポンスを記録と比べる |
| `check/` | std/pgの客での照合（行の数とidの和・プール250本 × 500 task） |

## 限界

表は「既定の引数（price 10〜50・limit 50）で本物が返す50行」だけを持ち、Bindの引数でpriceの絞りとlimitを適用する。
既定より広い・ずれた範囲では本物より少なく返す（返す行は本物の答えの先頭 — `replay.ts` のitems-narrowがこれを確認する）。

## 照合

```
<pgstub> 0 &                                                  # ready <P>
node --experimental-strip-types --no-warnings bench/pgstub/replay.ts <P> bench/pgstub/trace-items.hex \
  startup items-prepare items-50 items-20 items-narrow items-none terminate
node --experimental-strip-types --no-warnings bench/pgstub/replay.ts <P> testdata/pg/trace-17.hex startup
<check> postgres://bench@127.0.0.1:<P>/benchmark              # 本物に向けた印字と narrow / unknown の 2 行以外が一致
```

記録の取り直し: seedを入れたPG（平文・trust）に `node --experimental-strip-types --no-warnings bench/pgstub/cap.ts <host:port> <user> <db> > bench/pgstub/trace-items.hex`。
表のOID（items.soberの `itemsTable`）は記録のRowDescriptionの値に合わせる。
