# 標準ライブラリの案内

[English](std.md) | 日本語

`import "std/<名前>"` で使う package の地図です。各 package の関数の正確な形と説明は [標準ライブラリのリファレンス](../std/README.ja.md)（ソースの doc コメントから生成）にあります。下の表の package 名から各ページへ飛べます。

## 入出力と環境

| package | 用途 | 主なもの |
|---|---|---|
| [`std/io`](../std/io.ja.md) | ファイル・標準入出力・ディレクトリ | `ReadFile`・`WriteFile`・`ReadStdin`・`WriteStdout`・`WriteStderr`・`ReadDir`・開いたファイル `Open` / `Close`（`defer io.Close(f)` を直後に）/ `ReadAll`・切片を写さずに借りる読み `for c <- io.Chunks(f)?`（`Lines`・位置を指定する `ChunksAt`・中身は `Raw`）・バッファつきの `Writer`（`WriteString` / `WriteByte` / `Flush`）。エラーのラベルは `NotFound`・`Denied`・`Timeout`・`Expired`（囲む `task.Run` の期限が尽きた後）・`Closed`・`Other` |
| [`std/os`](../std/os.ja.md) | プロセスと環境 | `Args`・`Getenv`・`Run`（子プロセス）・`Mkdir`・`Rename`・`ModTime`・`WriteMode`・`Sleep` |

## テキスト

| package | 用途 | 主なもの |
|---|---|---|
| [`std/utf8`](../std/utf8.ja.md) | 検査済みの UTF-8 の見方 | `Check`（全体を 1 回検査して見方 `View` を得る）・`Str`（検査済みの見方から部分列を写さずに取る）・`Bytes` |
| [`std/strings`](../std/strings.ja.md) | 文字列の操作 | `Contains`・`HasPrefix`・`HasSuffix`・`Index`・`IndexByte`・`Count`・`LastIndex`・`Cut`・`CutLast`・`Split`・`Fields`・`TrimPrefix`・`TrimSuffix`・`TrimSpace`・`Replace`・`ToLower`・`ToUpper`・`EqualFold`・`Join`・`Clone`・UTF-8 の検査 `Valid`・`IndexInvalid`（誤りのラベル `InvalidUtf8`）（`Cut` などで切った片は検査し直さない — 区切りに一致した位置は必ず文字の境界。空白と大文字小文字は ASCII だけを見る — Unicode の case folding は対象外） |
| [`std/builder`](../std/builder.ja.md) | 列の組み立て | `Builder[T]` に `Push`・`PushAll`・`PushString` で積み、`Build` で取り出す |
| [`std/convert`](../std/convert.ja.md) | 数と文字列の変換 | `FormatInt`・`ParseInt`・`ParseFloat`・`FormatFloat`・`FormatFixed`・`ParseBool`・`FormatBool` |
| [`std/hex`](../std/hex.ja.md) | 16 進 | `Format`・`Parse` |
| [`std/base64`](../std/base64.ja.md) | base64（RFC 4648） | `Encode` ⇄ `Decode`（標準の字母・詰めつき）・`EncodeUrl` ⇄ `DecodeUrl`（URL に安全な字母・詰めなし）— 復号は厳格（綴りは 1 つ） |
| [`std/url`](../std/url.ja.md) | URL の部品の符号化 | percent-encoding の `Escape` ⇄ `Unescape`・クエリ文字列の全部の組を読む `ParseQuery`（同じキーも別の組・`+` は空白） |

`string` は不変のテキストで、`bytes(s)` でバイト列（`[]byte`）として見られます。文字列の補間は `"x = ${x}"` です。

## データ構造

| package | 用途 | 主なもの |
|---|---|---|
| [`std/iter`](../std/iter.ja.md) | 遅延の列 `Iter[T]` | `Range`・`Slice`・`Each`・`Count`・`Sum`（`for … yield` の結果をパイプで消費する） |
| [`std/sort`](../std/sort.ja.md) | 並べ替え | `Order`（0..n−1 を比較のクロージャ `less(a, b)` の順に並べた添字の列 — 安定。比べ方と元の列は呼び手が持つ）・`OrderUnstable`（同じ形で等しい要素の順を約束しない代わりに速い — 決定的） |
| [`std/table`](../std/table.ja.md) | 大きな表（固定長の塊の列 — 伸ばしても写しが起きない） | `Table[T]` に `Push`・`Get`・`Set`・`Len`、`Freeze` で不変の `Frozen[T]` に |
| [`std/pool`](../std/pool.ja.md) | ハンドルで引く貸し借りの溜め | `Acquire`・`Release`・`Get`・`Set` |
| [`std/json`](../std/json.ja.md) | JSON の読み書き | `Parse` で文書 `Doc` を得て `At`（1 段開くビュー `Value`）/ `Get` / `Items` / `Need*` / `ParseString`・`ParseInt`・`ParseFloat`・`ParseBool` で読む・`Put*` で書く・型への写しは `json.Decode[T]` / `json.Encode[T]` |

slice（`[]T`）と map（`map[K]V`）は言語の組み込みです（`append`・`len`・`freeze`・`clone`〔浅い写しを mut で返す〕・`m[k]` の引きは `T?`）。

## 並列

| package | 用途 | 主なもの |
|---|---|---|
| [`std/task`](../std/task.ja.md) | structured concurrency | `Map`・`Run`（scope を開く — 本体は札 `Scope` を受ける）+ `Spawn` + `Join` / `Gather` / `Try`・チャネル `NewChannel` / `Send` / `Recv` / `Close`・`Pool`（`NewPool` / `SpawnIn`） |

子の task に渡せるのは不変の値とチャネルだけです。出力はワーカー数に依らず同じです（[言語ツアー 7 節](tour.ja.md#7-並列--structured-concurrencyチャネル)）。

## 数と乱数

| package | 用途 | 主なもの |
|---|---|---|
| [`std/math`](../std/math.ja.md) | 浮動小数点の基本 | `Sqrt`・`Abs`・`Bits` / `FromBits` |
| [`std/rand`](../std/rand.ja.md) | 決定的な疑似乱数 | `New`（種から）・`Intn`・`Int62`・`Bool`・`Split`（並列の task ごとに分ける） |
| [`std/hash`](../std/hash.ja.md) | ハッシュ | `Sha256` |
| [`std/hash/crc32`](../std/hash-crc32.ja.md) | 検査和 | `Sum`（CRC-32 — gzip・zlib・PNG と同じ値） |

## 圧縮

| package | 用途 | 主なもの |
|---|---|---|
| [`std/compress/flate`](../std/compress-flate.ja.md) | DEFLATE（RFC 1951）の符号と復号 | `Encode(data, level)`（level 0〜9 — zlib と同じ目盛り・既定の目安は 6。同じ入力なら常に同じバイト列）・`Decode(data, maxSize:)`（出力の上限 — 信頼できない入力には必ず渡す。越えたら `TooLarge`・壊れた列は `Bad`） |
| [`std/compress/gzip`](../std/compress-gzip.ja.md) | gzip（RFC 1952）の符号と復号 | `Encode(data, level)`（頭 10 バイト + DEFLATE + CRC-32 + 長さ。HTTP の `Content-Encoding: gzip` の本文）・`Decode(data, maxSize:)`（CRC-32 と長さを照合・複数メンバは繋ぐ・包みの誤りは `gzip.Bad`） |

## ネットワーク

| package | 用途 | 主なもの |
|---|---|---|
| [`std/net`](../std/net.ja.md) | TCP | `for l <- net.Listen(addr)?`・`for c <- net.Accept(l)?`・`for c <- net.Dial(addr)?`（本体を抜けたら閉じる）・`for chunk <- net.Recv(c)?`・`Send`・接続 1 本 = task 1 本で走らせる `Serve` |
| [`std/http`](../std/http.ja.md) | HTTP/1.1 のサーバ | `ServeConn`（net の接続に）/ `ServeWith`（受けと送りの口に — TLS の接続など。省略可の `put:` に応答を送らずに積む口を渡すと受けの側が送る — tls.Put の形）・`Request` / `Response`・`Text` / `Json` / `Status`・`Header` / `Query` / `Form` / `Multipart`（ファイルのアップロード）/ `JsonDoc`・ルーター `Route` + `Mount` / `Merge` / `Dispatch` / `Param`・`Middleware`（`Before` / `After`）・応答の gzip と stream |
| [`std/tls`](../std/tls.ja.md) | TLS 1.3 のサーバ | `Serve`（handshake が済んだ接続だけを渡す）・`Config` を `Load` / `Parse` で・`Recv` / `Send`（net と同じ形）/ `Put` + `Flush`（送らずに積む — 積んだ分は `Recv` が次の受けの前に送る）。誤りは `HandshakeFailed`・`BadRecord`・`Closed`（[`std/tls/record`](../std/tls-record.ja.md) は内側の record 層 — 利用者は import しない） |

## 暗号

| package | 用途 | 主なもの |
|---|---|---|
| [`std/crypto`](../std/crypto.ja.md) | 定数時間の部品と OS の乱数 | `Equal`・`NonZero`・`Select`・`Wipe`・`Rand` |
| [`std/crypto/aesgcm`](../std/crypto-aesgcm.ja.md) / [`std/crypto/chacha20poly1305`](../std/crypto-chacha20poly1305.ja.md) | AEAD | `Seal` / `Open`・鍵を 1 回展開する `Prepare` + `SealTo` / `OpenAt`（aesgcm は AES-NI の機械だけ — `Available`） |
| [`std/crypto/chacha20`](../std/crypto-chacha20.ja.md)・[`std/crypto/poly1305`](../std/crypto-poly1305.ja.md) | ストリーム暗号と MAC | `XorKeyStream`・`Sum` / `SumAead` |
| [`std/crypto/sha256`](../std/crypto-sha256.ja.md)・[`std/crypto/hmac`](../std/crypto-hmac.ja.md)・[`std/crypto/hkdf`](../std/crypto-hkdf.ja.md) | ハッシュ・MAC・鍵導出 | `New` / `Write` / `Sum`・`Sum256`・`Extract` / `Expand` |
| [`std/crypto/x25519`](../std/crypto-x25519.ja.md)・[`std/crypto/rsa`](../std/crypto-rsa.ja.md) | 鍵共有と署名 | `Base` / `Shared`・`ParsePKCS8` / `SignPSS` / `VerifyPSS` |
| [`std/crypto/pem`](../std/crypto-pem.ja.md) | PEM の読み | `Parse` |

## その他

| package | 用途 |
|---|---|
| [`std/testing`](../std/testing.ja.md) | テストの補助（`assert` の失敗のラベル） |
| [`std/layout`](../std/layout.ja.md) | バイナリのレイアウトの宣言（`@layout`）の補助 |
| [`std/binary`](../std/binary.ja.md) | バイト列の語単位の読み（`Load64` — 8 バイトを little-endian で） |
