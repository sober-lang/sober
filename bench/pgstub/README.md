# pgstub — PostgreSQL の wire protocol だけを話す代役

計測の道具。本物の PostgreSQL の無い箱（gates・CI）で、async-db の客側（std/pg の Bind の符号化・行の受け・JSON の組み立て）を本物と同じ道で通すための、決まった応答を返す小さなサーバ。

- 平文・trust（認証を求めずに AuthenticationOk）。SSLRequest には 'N'
- 拡張問い合わせ（Parse / Describe / Bind / Execute / Close / Sync / Flush / Terminate）だけを話す。単純問い合わせと表に無い文面は ErrorResponse
- SQL は解釈しない: 文面を鍵に固定の表（`items.sober` の `shapeOf` / `answerOf`）を引く。今ある文面は async-db の 1 本だけ
- 束（Sync / Flush / Terminate まで）への応答は 1 回の Send で丸ごと送る — 客の recv の切れ目を代役の都合で揺らさない
- `delay-us` を与えると、起動の後の束への応答の前に回して待つ。目的は、客（サーバ）が応答を読みに来た時点ではまだ届いていない形 — 本物の PG と同じく、
  応答を待つ道を毎回必ず通る形 — に揃えて、客の命令の数えを決定的にすること（待たせないと、読みに来た時点で届いているかが回ごとに変わり、
  callgrind の数えが要求あたり 30 命令ほど揺れる）。reqinst は 300。待たせても残る ±6 命令/要求は客の rt の待ちの道（眠る前の回り・起こしの道）の揺れで、
  reqinst の asyncdb の線はその分の余白（実測の最大 + 25）で引く

## 建て方と使い方

```
out/stage2/sober2 build bench/pgstub --emit=elf --passes -o <pgstub>   # 入口はディレクトリ（package main が複数のファイル）
<pgstub> [port] [delay-us]                                               # 127.0.0.1:<port>（既定 0 = 空き番号）・"ready <port>" を出す
DATABASE_URL=postgres://bench:bench@127.0.0.1:<port>/benchmark <サーバ>   # user / password / db は何でも通る
```

## 置き場

| ファイル | 中身 |
|---|---|
| `main.sober` | 口（listen・接続ごとに 1 task） |
| `wire.sober` | wire のサーバ側: 枠の切り出し・符号化・接続の状態。表の中身は知らない |
| `items.sober` | 固定の表の応答器（文面・引数と列の形・Bind の引数 → 行） |
| `table.sober` | 表の 50 行（生成物 — `gen-items.ts <data/pgdb-seed.sql>`） |
| `trace-items.hex` | 本物の PG 18 から録った async-db の文の往復（`cap.ts`） |
| `replay.ts` | 照合: 記録の要求を代役へ流し、応答を記録と比べる |
| `check/` | std/pg の客での照合（行の数と id の和・プール 250 本 × 500 task） |

## 限界

表は「既定の引数（price 10〜50・limit 50）で本物が返す 50 行」だけを持ち、Bind の引数で price の絞りと limit を当てる。
既定より広い・ずれた範囲では本物より少なく返す（返す行は本物の答えの先頭 — `replay.ts` の items-narrow がこれを確かめる）。

## 照合

```
<pgstub> 0 &                                                  # ready <P>
node --experimental-strip-types --no-warnings bench/pgstub/replay.ts <P> bench/pgstub/trace-items.hex \
  startup items-prepare items-50 items-20 items-narrow items-none terminate
node --experimental-strip-types --no-warnings bench/pgstub/replay.ts <P> testdata/pg/trace-17.hex startup
<check> postgres://bench@127.0.0.1:<P>/benchmark              # 本物に向けた印字と narrow / unknown の 2 行以外が一致
```

記録の取り直し: seed を入れた PG（平文・trust）に `node --experimental-strip-types --no-warnings bench/pgstub/cap.ts <host:port> <user> <db> > bench/pgstub/trace-items.hex`。
表の OID（items.sober の `itemsTable`）は記録の RowDescription の値に合わせる。
