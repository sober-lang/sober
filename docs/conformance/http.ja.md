# HTTP・cookie・URL

[English](http.md) · [準拠文書](README.ja.md)

## 範囲

HTTP/1.1（RFC 9110〜9112）のサーバ（`std/http/server`）とクライアント（`std/http/client`）・cookie（RFC 6265 / 6265bis）・URLの部品（`std/url`）。サーバの検査はgate httpcheck（`testdata/httpcheck/check.ts` — HttpArenaのvalidateを模した送受のテストを平文とTLSの上で掛ける）が主で、表の「`testdata/httpcheck/check.ts`」の証拠はそのテストの項目の名前。

## 対応

### サーバ

<!-- confsync:begin claims http-server yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| HTTP/1.1と1.0のリクエスト・keep-alive・パイプライン（RFC 9112） | 対応 | `testdata/httpcheck/check.ts`: pipelined 16<br>`testdata/httpcheck/check.ts`: HTTP/1.0 keep-alive<br>`std/http/server.TestFrameAgrees` |
| 本文のContent-Lengthとchunked（chunkの拡張とtrailerは読み捨て） | 対応 | `testdata/httpcheck/check.ts`: chunk ext + trailer<br>`testdata/httpcheck/check.ts`: POST chunked |
| リクエストの密輸の形の拒否（CL + TE・食い違うCL・obs-fold・裸のCR・空白の前のコロン）= 400 | 対応 | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: CL twice differ<br>`testdata/httpcheck/check.ts`: obs-fold<br>`testdata/httpcheck/check.ts`: bare CR |
| 上限 = 431（頭）・413（本文）・chunked以外のTransfer-Encoding = 501・HTTP/1.x以外 = 505 | 対応 | `testdata/httpcheck/check.ts`: head > 8 KiB<br>`testdata/httpcheck/check.ts`: CL > 16 KiB<br>`testdata/httpcheck/check.ts`: TE gzip<br>`testdata/httpcheck/check.ts`: HTTP/2.0<br>`std/http/server.TestFrameLimits` |
| レスポンスのgzip（Accept-Encodingの交渉・Vary）と事前圧縮のファイルのbr / gzの選択 | 対応 | `testdata/httpcheck/check.ts`: gzip stream node:http<br>`testdata/httpcheck/check.ts`: static gz roundtrip |
| レスポンスのstream（長さ既知 = Content-Length・長さ不定 = chunked・HTTP/1.0は閉じで区切る） | 対応 | `testdata/httpcheck/check.ts`: stream file<br>`testdata/httpcheck/check.ts`: chunked node:http |
| 条件付きGET（RFC 9110 13 — ETag・Last-Modified・304 / 412）とCache-Controlの既定private | 対応 | `std/http/server.TestTagIn`<br>`std/http/server.TestParseDate`<br>`testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: default cache-control private |
| multipart/form-data（RFC 7578） | 対応 | `std/http/server.TestMultipartRfc`<br>`std/http/server.TestMultipartBrowsers`<br>`testdata/httpcheck/check.ts`: upload formdata |
| Server-Sent Events（text/event-stream・Last-Event-ID） | 対応 | `std/http/server.TestFormatEvent`<br>`testdata/httpcheck/check.ts`: sse Last-Event-ID |
<!-- confsync:end claims http-server yes,partial -->

### クライアント

<!-- confsync:begin claims http-client yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| httpとhttps（TLSの章）・Content-Length / chunked / 閉じ区切りの本文・HEAD | 対応 | `std/http/client.TestPlainLoopback`<br>`std/http/client.TestBodyMachine`<br>相互接続http: chunked（2026-11-07）<br>相互接続http: head（2026-11-07） |
| redirect（10回まで・301 / 302 / 303はGETへ・307 / 308は保つ・originが変われば認証の頭を落とす・https → httpは追わない） | 対応 | 相互接続http: redirect-303（2026-11-07）<br>相互接続http: redirect-auth-same-origin-only（2026-11-07）<br>相互接続http: insecure-redirect-refused（2026-11-07） |
| keep-aliveのセッション（Open / Send）・stream（Stream） | 対応 | `std/http/client.TestSessionPlain`<br>`std/http/client.TestStreamPlain`<br>相互接続http: session（2026-11-07）<br>相互接続http: stream（2026-11-07） |
| proxy（CONNECTのトンネル・Proxy-Authorization） | 対応 | `std/http/client.TestProxyLoopback`<br>相互接続http: proxy-connect（2026-11-07）<br>相互接続http: proxy-auth（2026-11-07） |
| 1xxの中間のレスポンスを読み捨てる | 対応 | `std/http/client.TestScanSplits` |
| 期限と本文の上限（ゼロ値で有効） | 対応 | `std/http/client.TestTimeoutAndRefused` |
<!-- confsync:end claims http-client yes,partial -->

### cookie

<!-- confsync:begin claims http-cookie yes -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| Set-Cookieを書く（ゼロ値が安全な側: Secure・HttpOnly・SameSite=Lax・Path=/・host-only） | 対応 | `std/http/server.TestSetCookieDefaults`<br>`std/http/server.TestSetCookieRejects` |
| __Host- / __Secure- の前置きの約束（RFC 6265bis 4.1.3） | 対応 | `std/http/server.TestSetCookieRejects` |
| クライアントのcookieはデータ（レスポンスのSet-CookieからCookieValueで取り出し、リクエストのcookies: に載せる — originが変わるredirectでは落とす） | 対応 | `std/http/client.TestCookieValue`<br>`std/http/client.TestCookieLoopback` |
<!-- confsync:end claims http-cookie yes -->

### URL

立場: stdはRFC 3986の厳格な側に立ち、ブラウザの寛容な解釈（WHATWG URL Standard）は持たない。汎用のURLの型は無く、URLを読むのはHTTPクライアントの中（http / httpsの絶対URL）だけ。

<!-- confsync:begin claims http-url yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| percent-encoding（RFC 3986 2.1）のEscape / Unescape | 対応 | `testdata/stdtest/stdurl.TestEscape`<br>`testdata/stdtest/stdurl.TestUnescape`<br>`testdata/stdtest/stdurl.TestUnescapeRejects` |
| application/x-www-form-urlencodedのクエリの読み書き | 対応 | `testdata/stdtest/stdurl.TestParseQuery`<br>`testdata/stdtest/stdurl.TestFormatQuery` |
| URLの構文解析（HTTPクライアントのhttp / httpsの絶対URLだけ — 汎用のURLの型は無い） | 一部 | `std/http/client.TestTarget`<br>`std/http/client.TestLocation` |
<!-- confsync:end claims http-url yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims http-server intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| Expect: 100-continueの100レスポンス（送らずに本文を待つ — クライアントは待ちの期限の後に本文を送る） | 意図して非対応 | — |
| Upgrade（WebSocketを含む）・CONNECT（サーバからの押し出しはSSEが今の答え — WebSocketは実需が立てば0.8以降のピンへ上げる） | 意図して非対応 | — |
<!-- confsync:end claims http-server intentional -->

<!-- confsync:begin claims http-client intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| URLのuserinfo（user:pass@） | 意図して非対応 | `std/http/client.TestTarget` |
<!-- confsync:end claims http-client intentional -->

<!-- confsync:begin claims http-url intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| WHATWG URL Standardの構文解析（ブラウザの寛容な解釈は持たない — RFC 3986の厳格な側） | 意図して非対応 | — |
<!-- confsync:end claims http-url intentional -->

<!-- confsync:begin claims http-cookie intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| cookie jar（RFC 6265 5の自動の保存と送り — 載せるものは呼び手が書く。任意のoriginを渡る汎用エージェントの機械はstdに置かない） | 意図して非対応 | — |
<!-- confsync:end claims http-cookie intentional -->

## 未実装

<!-- confsync:begin claims http-server planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| Range（206） | 0.8圏 | — |
| HTTP/2（h2 / h2c — 外部オラクルh2spec） | 0.8圏 | — |
| HTTP/3（QUIC — 外部オラクルquic-interop-runner） | 0.8圏 | — |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IPv6の番地への接続 | 0.8圏 | `std/http/client.TestTarget` |
| レスポンスのContent-Encodingの復号（今はAccept-Encodingを送らない） | 0.8圏 | — |
| HTTP/2 | 0.8圏 | — |
<!-- confsync:end claims http-client planned -->

<!-- confsync:begin claims http-url planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IDN（punycode） | 0.8圏 | — |
<!-- confsync:end claims http-url planned -->

cookieで未実装のものは無い。

## 証拠 — 相互接続（クライアント — 相手 = Go net/http）

<!-- confsync:begin interop-http -->
最終確認: 2026-11-07（木73597f45c958 (dirty) — scripts/httpinterop.sh・相手 = Go net/http）

`plain` · `tls13` · `tls12-opt-in` · `tls12-default-refused` · `content-length` · `chunked` · `head` · `redirect-303` · `redirect-auth-same-origin-only` · `insecure-redirect-refused` · `stream` · `session` · `proxy-connect` · `proxy-auth` · `unknown-ca-refused`
<!-- confsync:end interop-http -->
