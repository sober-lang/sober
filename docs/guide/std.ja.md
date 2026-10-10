# 標準ライブラリの案内

[English](std.md) | 日本語

`import "std/<名前>"` で使う package の地図です。各 package の関数の正確な形は、ソース（`src/std/<名前>/`）の公開の宣言（大文字で始まる名前）が正です。

## 入出力と環境

| package | 用途 | 主なもの |
|---|---|---|
| `std/io` | ファイル・標準入出力・ディレクトリ | `ReadFile`・`WriteFile`・`ReadStdin`・`WriteStdout`・`WriteStderr`・`ReadDir`・バッファつきの `Writer`（`WriteString` / `WriteByte` / `Flush`）。エラーのラベルは `NotFound`・`Denied`・`Other` |
| `std/os` | プロセスと環境 | `Args`・`Getenv`・`Run`（子プロセス）・`Mkdir`・`Rename`・`ModTime`・`WriteMode`・`Sleep` |

## テキスト

| package | 用途 | 主なもの |
|---|---|---|
| `std/utf8` | UTF-8 の検査と部分列 | `Check`（全体を 1 回検査して見方 `View` を得る）・`Str`（検査済みの見方から部分列を写さずに取る）・`Parse`・`Valid`・`IndexInvalid` |
| `std/strings` | 文字列の操作 | `Contains`・`HasPrefix`・`HasSuffix`・`Index`・`IndexByte`・`Count`・`Cut`・`CutLast`・`TrimPrefix`・`Join`・`FormatInt`・`Clone`（`Cut` などで切った片は検査し直さない — 区切りに一致した位置は必ず文字の境界） |
| `std/builder` | 列の組み立て | `Builder[T]` に `Push`・`PushAll`・`PushStr` で積み、`Build` で取り出す |
| `std/conv` | 数と文字列の変換 | `ParseFloat`・`FormatFloat`・`FormatFixed` |
| `std/hex` | 16 進 | `Encode` |

`string` は不変のテキストで、`bytes(s)` でバイト列（`[]byte`）として見られます。文字列の補間は `"x = ${x}"` です。

## データ構造

| package | 用途 | 主なもの |
|---|---|---|
| `std/iter` | 遅延の列 `Iter[T]` | `Range`・`Slice`・`Each`・`Count`・`Sum`（`for … yield` の結果をパイプで消費する） |
| `std/table` | 大きな表（固定長の塊の列 — 伸ばしても写しが起きない） | `Table[T]` に `Push`・`Get`・`Set`・`Len`、`Freeze` で不変の `Frozen[T]` に |
| `std/pool` | ハンドルで引く貸し借りの溜め | `Acquire`・`Release`・`Get`・`Set` |
| `std/json` | JSON の読み書き | `Parse` で文書 `Doc` を得て `Get` / `Items` / `Dec*` で読む・`Put*` で書く・型への写しは `json.Decode[T]` / `json.Encode[T]` |

slice（`[]T`）と map（`map[K]V`）は言語の組み込みです（`append`・`len`・`freeze`・`m[k]` の引きは `T?`）。

## 並列

| package | 用途 | 主なもの |
|---|---|---|
| `std/par` | structured concurrency | `Map`・`Scope` + `Spawn` + `Join` / `Gather` / `Try`・チャネル `NewChan` / `Send` / `Recv` / `Close`・`Pool`（`NewPool` / `SpawnIn`） |

子の task に渡せるのは不変の値とチャネルだけです。出力はワーカー数に依らず同じです（[言語ツアー 7 節](tour.ja.md#7-並列--structured-concurrencyチャネル)）。

## 数と乱数

| package | 用途 | 主なもの |
|---|---|---|
| `std/math` | 浮動小数点の基本 | `Sqrt`・`Abs`・`Bits` / `FromBits` |
| `std/rand` | 決定的な疑似乱数 | `New`（種から）・`Intn`・`Int62`・`Bool`・`Split`（並列の task ごとに分ける） |
| `std/hash` | ハッシュ | `Sha256` |

## その他

| package | 用途 |
|---|---|
| `std/testing` | テストの補助（`assert` の失敗のラベル） |
| `std/layout` | バイナリのレイアウトの宣言（`@layout`）の補助 |
| `std/floatfmt` | 浮動小数点の文字列化の内部（`std/conv` が使う） |

浮動小数点まわり（`float` の書式・数学関数）は v0.5.0 で整備中です。
