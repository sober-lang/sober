# 標準ライブラリの案内

[English](std.md) | 日本語

`import "std/<名前>"` で使うpackageの地図です。各packageの関数の正確な形と説明は [標準ライブラリのリファレンス](../std/README.ja.md)（ソースのdocコメントから生成）にあります。下の表のpackage名から各ページへ飛べます。

## 入出力と環境

| package | 用途 | 主なもの |
|---|---|---|
| [`std/io`](../std/io.ja.md) | ファイル・標準入出力・ディレクトリ | `ReadFile`・`WriteFile`・`ReadStdin`・`WriteStdout`・`WriteStderr`・`ReadDir`・開いたファイル `Open` / `Close`（`defer io.Close(f)` を直後に）/ `ReadAll`・切片をコピーせずに借りる読み `for c <- io.Chunks(f)?`（`Lines`・位置を指定する `ChunksAt`・中身は `Raw`）・バッファつきの `Writer`（`WriteString` / `WriteByte` / `Flush`）。エラーのラベルは `NotFound`・`Denied`・`Timeout`・`Expired`（囲む `task.Run` の期限が尽きた後）・`Closed`・`Other` |
| [`std/os`](../std/os.ja.md) | プロセスと環境 | `Args`・`Getenv`・`Run`（子プロセス）・`Mkdir`・`Rename`・`ModTime`・`WriteMode`・`Sleep` |
| [`std/cli`](../std/cli.ja.md) | コマンド行の解析と使い方の文書 | フラグ・位置引数・コマンドをconstの表で宣言（`BoolFlag`・`StrFlag`・`IntFlag`・`ChoiceFlag`・`ListFlag`・`Positional`・`Command`・`App`）・`Main` が解析・`--help`・`--version`・誤用の印字・コマンドへの振り分けを持つ・値は `Str` / `Int` / `Bool` / `Pos` で引く |
| [`std/env`](../std/env.ja.md) | 環境変数の宣言の表 | 読む変数をconstの表で宣言（`StrVar`・`IntVar`・`BoolVar`・`Table`）・`Load` が入場で1回だけ全部を読んで検査し、凍った表 `Values` を返す・一覧は `Spec`（[環境変数](env.ja.md)） |

## テキスト

| package | 用途 | 主なもの |
|---|---|---|
| [`std/utf8`](../std/utf8.ja.md) | 検査済みのUTF-8の見方 | `Check`（全体を1回検査して見方 `View` を得る）・`Str`（検査済みの見方から部分列をコピーせずに取る）・`Bytes` |
| [`std/strings`](../std/strings.ja.md) | 文字列の操作 | `Contains`・`HasPrefix`・`HasSuffix`・`Index`・`IndexByte`・`Count`・`LastIndex`・`Cut`・`CutLast`・`Split`・`Fields`・`TrimPrefix`・`TrimSuffix`・`TrimSpace`・`Replace`・`ToLower`・`ToUpper`・`EqualFold`・`Join`・`Clone`・UTF-8の検査 `Valid`・`IndexInvalid`（誤りのラベル `BadUtf8`）（`Cut` などで切った片は検査し直さない — 区切りに一致した位置は必ず文字の境界。空白と大文字小文字はASCIIだけを見る — Unicodeのcase foldingは対象外） |
| [`std/builder`](../std/builder.ja.md) | 列の組み立て | `Builder[T]` に `Push`・`PushAll`・`PushString` で積み、`Build` で取り出す |
| [`std/convert`](../std/convert.ja.md) | 数と文字列の変換 | `FormatInt`・`ParseInt`・`ParseFloat`・`FormatFloat`・`FormatFixed`・`ParseBool`・`FormatBool` |
| [`std/hex`](../std/hex.ja.md) | 16進 | `Format`・`Parse` |
| [`std/base64`](../std/base64.ja.md) | base64（RFC 4648） | `Encode` ⇄ `Decode`（標準の字母・詰めつき）・`EncodeUrl` ⇄ `DecodeUrl`（URLに安全な字母・詰めなし）— 復号は厳格（綴りは1つ） |
| [`std/url`](../std/url.ja.md) | URLの部品の符号化 | percent-encodingの `Escape` ⇄ `Unescape`・クエリ文字列の全部の組を読む `ParseQuery` ⇄ 組の列から書く `FormatQuery`（同じキーも別の組・`+` は空白） |

`string` は不変のテキストで、`bytes(s)` でバイト列（`[]byte`）として見られます。文字列の補間は `"x = ${x}"` です。

## データ構造

| package | 用途 | 主なもの |
|---|---|---|
| [`std/iter`](../std/iter.ja.md) | 遅延の列 `Iter[T]` | `Range`・`Slice`・`Each`・`Count`・`Sum`（`for … yield` の結果をパイプで消費する） |
| [`std/sort`](../std/sort.ja.md) | 並べ替え | `Order`（0..n−1を比較のクロージャ `less(a, b)` の順に並べた添字の列 — 安定。比べ方と元の列は呼び手が持つ）・`OrderUnstable`（同じ形で等しい要素の順を約束しない代わりに速い — 決定的） |
| [`std/table`](../std/table.ja.md) | 大きな表（固定長のチャンクの列 — 伸ばしてもコピーが起きない） | `Table[T]` に `Push`・`Get`・`Set`・`Len`、`Freeze` で不変の `Frozen[T]` に |
| [`std/pool`](../std/pool.ja.md) | ハンドルで引く貸し借りのプール | `Acquire`・`Release`・`Get`・`Set` |
| [`std/json`](../std/json.ja.md) | JSONの読み書き | `Parse` で文書 `Doc` を得て `At`（1階層開くビュー `Value`）/ `Get` / `Items` / `Need*` / `ParseString`・`ParseInt`・`ParseFloat`・`ParseBool` で読む・`Put*` で書く・型への変換は `json.Decode[T]` / `json.Encode[T]` |

slice（`[]T`）とmap（`map[K]V`）は言語の組み込みです（`append`・`len`・`freeze`・`clone`〔浅いコピーをmutで返す〕・`m[k]` の引きは `T?`）。

## 並列

| package | 用途 | 主なもの |
|---|---|---|
| [`std/task`](../std/task.ja.md) | structured concurrency | `Map`・`Run`（scopeを開く — 本体は札 `Scope` を受ける）+ `Spawn` + `Join` / `Gather` / `Try`・チャネル `NewChannel` / `Send` / `Recv` / `Close`・`Pool`（`NewPool` / `SpawnIn`）・多くのtaskから1つの状態への直列の更新 `Domain`（`NewDomain` / `Update` / `Read` / `Await` — [並行](concurrency.ja.md) 5節） |

子のtaskに渡せるのは不変の値とチャネルだけです。出力はワーカー数に依らず同じです（[言語ツアー7節](tour.ja.md#7-並列--structured-concurrencyチャネル)）。

## 数と乱数

| package | 用途 | 主なもの |
|---|---|---|
| [`std/math`](../std/math.ja.md) | 浮動小数点の基本 | `Sqrt`・`Abs`・`Bits` / `FromBits` |
| [`std/time`](../std/time.ja.md) | 時刻（壁時計の `Time` と単調時計の `Instant` は別の型・壁時計を読むのは `Now` だけ） | `Now`・`Mono`・`Since`・`Unix`・`Add` / `Sub`・`ToCivil` / `FromCivil`・`FormatRFC3339` / `ParseRFC3339`・`FormatHTTP` / `ParseHTTP`・地域の規則 `LoadZone` / `ToCivilIn` / `OffsetAt`（IANAのtzdataの焼き込み） |
| [`std/uuid`](../std/uuid.ja.md) | UUID（RFC 9562 — 版4と版7） | `NewV4`・`NewV7`・`Parse`・`Format`・`Equal` |
| [`std/rand`](../std/rand.ja.md) | 決定的な疑似乱数 | `New`（シードから）・`Intn`・`Int62`・`Bool`・`Split`（並列のtaskごとに分ける） |
| [`std/hash`](../std/hash.ja.md) | ハッシュ | `Sha256` |
| [`std/hash/crc32`](../std/hash-crc32.ja.md) | 検査和 | `Sum`（CRC-32 — gzip・zlib・PNGと同じ値） |

## 圧縮

| package | 用途 | 主なもの |
|---|---|---|
| [`std/compress/flate`](../std/compress-flate.ja.md) | DEFLATE（RFC 1951）の符号と復号 | `Encode(data, level)`（level 0〜9 — zlibと同じ目盛り・既定の目安は6。同じ入力なら常に同じバイト列）・`Decode(data, maxSize:)`（出力の上限 — 信頼できない入力には必ず渡す。越えたら `TooLarge`・壊れた列は `Bad`） |
| [`std/compress/gzip`](../std/compress-gzip.ja.md) | gzip（RFC 1952）の符号と復号 | `Encode(data, level)`（頭10バイト + DEFLATE + CRC-32 + 長さ。HTTPの `Content-Encoding: gzip` の本文）・`Decode(data, maxSize:)`（CRC-32と長さを照合・複数メンバは繋ぐ・包みの誤りは `compress.gzip.Bad`） |

## ネットワーク

| package | 用途 | 主なもの |
|---|---|---|
| [`std/net`](../std/net.ja.md) | TCP | `for l <- net.Listen(addr)?`・`for c <- net.Accept(l)?`・`for c <- net.Dial(addr)?`（本体を抜けたら閉じる）・`for chunk <- net.Recv(c)?`・`Send`・接続1本 = task 1本で走らせる `Serve` |
| [`std/http`](../std/http.ja.md) | サーバとクライアントが共に使うHTTPの語彙 | `Field`（ヘッダの1本）・`StatusCode` と型つきのconst（`http.OK` …）・`BadHeader` |
| [`std/http/server`](../std/http-server.ja.md) | HTTP/1.1のサーバ | `ServeConn`（netの接続に）/ `ServeWith`（受けと送りの関数に — TLSの接続など。省略可の `put:` にレスポンスを送らずに積む関数を渡すと受けの側が送る — tls.Putの形）・`SetCookie`（Response.cookies — Secure / HttpOnly / SameSite=Laxが既定）・`Request` / `Response`・`Text` / `Json` / `Status`・`Header` / `Query` / `Form` / `Multipart`（ファイルのアップロード）/ `JsonDoc`・ルーター `Route` + `Mount` / `Merge` / `Dispatch` / `Param`・`Middleware`（`Before` / `After`）・レスポンスのgzipとstream |
| [`std/http/client`](../std/http-client.ja.md) | HTTP/1.1のクライアント（TLSは常に検証 — 既定は1.3だけ） | 状態を持たない。リクエストごとの `Request(url, method:, headers:, body:, cookies:, policy:)`・方針のデータ `Policy`（ゼロ値が安全な既定: 本文の上限8 MiB・期限30秒・redirect 10回・`extraRoots`〔私的PKI — `tls.ParseRoots`〕・`proxy`〔`ParseProxy`〕/ `proxyAuth`・`dangerouslyAllowTls12`）・cookieは値（`CookieValue` で取り出し `cookies:` に載せる）・本文を切片で受ける `for part <- http.client.Stream(url)?`・keep-aliveのセッション `Open` の中の `Send`（Sessionは同一性の型）。誤りは `Dns`・`Tls`・`Timeout`・`TooManyRedirects`・`InsecureRedirect`・`BodyTooLarge`・`Closed`・`BadUrl`・`BadResponse`・`ProxyRefused`・`BadProxy`（ParseProxy） |
| [`std/tls`](../std/tls.ja.md) | TLS 1.3のサーバ | `Serve`（handshakeが済んだ接続だけを渡す）・`Config` を `Load` / `Parse` で・`Recv` / `Send`（netと同じ形）/ `Put` + `Flush`（送らずに積む — 積んだ分は `Recv` が次の受けの前に送る）・クライアントの信頼の起点に足す `Roots` を `ParseRoots` で（誤り `BadRoots`）。誤りは `HandshakeFailed`・`BadRecord`・`Closed` |
| [`std/pg`](../std/pg.ja.md) | PostgreSQLのクライアント（wire protocol 3.0 — TLS 1.3 + SCRAM-SHA-256-PLUSが既定） | `Open`（接続 `Conn`）・`Exec` / `Query` / `Script`（SQLの文面はconst仮引数）・行の読み `Col*`・トランザクション `Tx`・接続のプール `OpenPool` / `With`（[PostgreSQL](postgres.ja.md)） |

## 暗号

| package | 用途 | 主なもの |
|---|---|---|
| [`std/crypto`](../std/crypto.ja.md) | 定数時間の部品とOSの乱数 | `Equal`・`NonZero`・`Select`・`Wipe`・`Rand`・`RandIntn`（暗号論的な乱数の整数 — 決定的な乱数はstd/rand） |
| [`std/crypto/aesgcm`](../std/crypto-aesgcm.ja.md) / [`std/crypto/chacha20poly1305`](../std/crypto-chacha20poly1305.ja.md) | AEAD | `Seal` / `Open`・鍵を1回展開する `Prepare` + `SealTo` / `OpenAt`（aesgcmはAES-NIの機械だけ — `Available`） |
| [`std/crypto/chacha20`](../std/crypto-chacha20.ja.md)・[`std/crypto/poly1305`](../std/crypto-poly1305.ja.md) | ストリーム暗号とMAC | `XorKeyStream`・`Sum` / `SumAead` |
| [`std/crypto/sha256`](../std/crypto-sha256.ja.md)・[`std/crypto/hmac`](../std/crypto-hmac.ja.md)・[`std/crypto/hkdf`](../std/crypto-hkdf.ja.md) | ハッシュ・MAC・鍵導出 | `New` / `Write` / `Sum`・`Sum256`・`Extract` / `Expand` |
| [`std/crypto/password`](../std/crypto-password.ja.md) | パスワードの保存用のハッシュと照合（方式は書く側が選ぶ — 新しく選ぶならArgon2id） | `Argon2id`・`Bcrypt`・`Pbkdf2`・`Verify`・`NeedsRehash` |
| [`std/crypto/x25519`](../std/crypto-x25519.ja.md)・[`std/crypto/rsa`](../std/crypto-rsa.ja.md) | 鍵共有と署名 | `Base` / `Shared`・`ParsePKCS8` / `SignPSS` / `VerifyPSS` |
| [`std/crypto/pem`](../std/crypto-pem.ja.md) | PEMの読み | `Parse` |

## テスト

| package | 用途 | 主なもの |
|---|---|---|
| [`std/quick`](../std/quick.ja.md) | プロパティベーステスト | 選択の源 `Src`（`New` / `Named` / `Seed`）から値を引き（`Int`・`Bool`・`Pick`・`Elem`・`Bytes`・`String`・`Runes`・`Slice`）、`Check` がプロパティを試行ごとに呼ぶ・`Assume`（試行を捨てる条件）・反例はシュリンクして印字 |
| [`std/testing`](../std/testing.ja.md) | `assert` の裏方 | 失敗のラベル `AssertFailed` と印字 `Report`（`assert(e)` / `assert(e, label)` は `_test.sober` の中で使う — importは要らない） |
| [`std/testing/cell`](../std/testing-cell.ja.md) | テストのdoubleが状態を貯める格納場所 | constの把手 `Cell[T]{init: …}` に `Get` / `Set` / `Update`（`_test.sober` と `_double.sober` だけがimportできる） |

書き方の通しの例は [テストの書き方](testing.ja.md) にあります。

## その他

| package | 用途 |
|---|---|
| [`std/layout`](../std/layout.ja.md) | バイナリのレイアウトの宣言（`@layout`）の補助 |
| [`std/binary`](../std/binary.ja.md) | バイト列のワード単位の読み（`Load64` — 8バイトをlittle-endianで）と末尾へのワードの書き（`AppendWord`） |
