# HTTP・cookie・URL

[English](http.md) · [準拠文書](README.ja.md)

## 範囲

HTTP/1.1（RFC 9110〜9112）のサーバ（`std/http/server`）とクライアント（`std/http/client`）・cookie（RFC 6265 / 6265bis）・URL の部品（`std/url`）。サーバの網は gate httpcheck（`testdata/httpcheck/check.ts` — HttpArena の validate を模した送受の網を平文と TLS の上で掛ける）が主で、表の「`testdata/httpcheck/check.ts`」の証拠はその網の検査の名前。

## 対応

### サーバ

<!-- confsync:begin claims http-server yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| HTTP/1.1 と 1.0 の要求・keep-alive・パイプライン（RFC 9112） | 対応 | `testdata/httpcheck/check.ts`: pipelined 16<br>`testdata/httpcheck/check.ts`: HTTP/1.0 keep-alive<br>`std/http/server.TestFrameAgrees` |
| 本文の Content-Length と chunked（chunk の拡張と trailer は読み捨て） | 対応 | `testdata/httpcheck/check.ts`: chunk ext + trailer<br>`testdata/httpcheck/check.ts`: POST chunked |
| 要求の密輸の形の拒否（CL + TE・食い違う CL・obs-fold・裸の CR・空白の前のコロン）= 400 | 対応 | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: CL twice differ<br>`testdata/httpcheck/check.ts`: obs-fold<br>`testdata/httpcheck/check.ts`: bare CR |
| 上限 = 431（頭）・413（本文）・chunked 以外の Transfer-Encoding = 501・HTTP/1.x 以外 = 505 | 対応 | `testdata/httpcheck/check.ts`: head > 8 KiB<br>`testdata/httpcheck/check.ts`: CL > 16 KiB<br>`testdata/httpcheck/check.ts`: TE gzip<br>`testdata/httpcheck/check.ts`: HTTP/2.0<br>`std/http/server.TestFrameLimits` |
| 応答の gzip（Accept-Encoding の交渉・Vary）と事前圧縮のファイルの br / gz の選択 | 対応 | `testdata/httpcheck/check.ts`: gzip stream node:http<br>`testdata/httpcheck/check.ts`: static gz roundtrip |
| 応答の stream（長さ既知 = Content-Length・長さ不定 = chunked・HTTP/1.0 は閉じで区切る） | 対応 | `testdata/httpcheck/check.ts`: stream file<br>`testdata/httpcheck/check.ts`: chunked node:http |
| 条件付き GET（RFC 9110 13 — ETag・Last-Modified・304 / 412）と Cache-Control の既定 private | 対応 | `std/http/server.TestTagIn`<br>`std/http/server.TestParseDate`<br>`testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: default cache-control private |
| multipart/form-data（RFC 7578） | 対応 | `std/http/server.TestMultipartRfc`<br>`std/http/server.TestMultipartBrowsers`<br>`testdata/httpcheck/check.ts`: upload formdata |
| Server-Sent Events（text/event-stream・Last-Event-ID） | 対応 | `std/http/server.TestFormatEvent`<br>`testdata/httpcheck/check.ts`: sse Last-Event-ID |
<!-- confsync:end claims http-server yes,partial -->

### クライアント

<!-- confsync:begin claims http-client yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| http と https（TLS の章）・Content-Length / chunked / 閉じ区切りの本文・HEAD | 対応 | `std/http/client.TestPlainLoopback`<br>`std/http/client.TestBodyMachine`<br>相互接続 http: chunked（2026-11-07）<br>相互接続 http: head（2026-11-07） |
| redirect（10 回まで・301 / 302 / 303 は GET へ・307 / 308 は保つ・origin が変われば認証の頭を落とす・https → http は追わない） | 対応 | 相互接続 http: redirect-303（2026-11-07）<br>相互接続 http: redirect-auth-same-origin-only（2026-11-07）<br>相互接続 http: insecure-redirect-refused（2026-11-07） |
| keep-alive の束（Open / Send）・stream（Stream） | 対応 | `std/http/client.TestSessionPlain`<br>`std/http/client.TestStreamPlain`<br>相互接続 http: session（2026-11-07）<br>相互接続 http: stream（2026-11-07） |
| proxy（CONNECT のトンネル・Proxy-Authorization） | 対応 | `std/http/client.TestProxyLoopback`<br>相互接続 http: proxy-connect（2026-11-07）<br>相互接続 http: proxy-auth（2026-11-07） |
| 1xx の中間の応答を読み捨てる | 対応 | `std/http/client.TestScanSplits` |
| 期限と本文の上限（ゼロ値で有効） | 対応 | `std/http/client.TestTimeoutAndRefused` |
<!-- confsync:end claims http-client yes,partial -->

### cookie

<!-- confsync:begin claims http-cookie yes -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| Set-Cookie を書く（ゼロ値が安全な側: Secure・HttpOnly・SameSite=Lax・Path=/・host-only） | 対応 | `std/http/server.TestSetCookieDefaults`<br>`std/http/server.TestSetCookieRejects` |
| __Host- / __Secure- の前置きの約束（RFC 6265bis 4.1.3） | 対応 | `std/http/server.TestSetCookieRejects` |
| クライアントの cookie はデータ（応答の Set-Cookie から CookieValue で取り出し、要求の cookies: に載せる — origin が変わる redirect では落とす） | 対応 | `std/http/client.TestCookieValue`<br>`std/http/client.TestCookieLoopback` |
<!-- confsync:end claims http-cookie yes -->

### URL

立場: std は RFC 3986 の厳格な側に立ち、ブラウザの寛容な読み（WHATWG URL Standard）は持たない。汎用の URL の型は無く、URL を読むのは HTTP クライアントの中（http / https の絶対 URL）だけ。

<!-- confsync:begin claims http-url yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| percent-encoding（RFC 3986 2.1）の Escape / Unescape | 対応 | `testdata/stdtest/stdurl.TestEscape`<br>`testdata/stdtest/stdurl.TestUnescape`<br>`testdata/stdtest/stdurl.TestUnescapeRejects` |
| application/x-www-form-urlencoded のクエリの読み書き | 対応 | `testdata/stdtest/stdurl.TestParseQuery`<br>`testdata/stdtest/stdurl.TestFormatQuery` |
| URL の読み（HTTP クライアントの http / https の絶対 URL だけ — 汎用の URL の型は無い） | 一部 | `std/http/client.TestTarget`<br>`std/http/client.TestLocation` |
<!-- confsync:end claims http-url yes,partial -->

## 意図して外したこと

<!-- confsync:begin claims http-server intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| Expect: 100-continue の 100 応答（送らずに本文を待つ — クライアントは待ちの期限の後に本文を送る） | 意図して非対応 | — |
| Upgrade（WebSocket を含む）・CONNECT（サーバからの押し出しは SSE が今の答え — WebSocket は実需が立てば 0.8 以降のピンへ上げる） | 意図して非対応 | — |
<!-- confsync:end claims http-server intentional -->

<!-- confsync:begin claims http-client intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| URL の userinfo（user:pass@） | 意図して非対応 | `std/http/client.TestTarget` |
<!-- confsync:end claims http-client intentional -->

<!-- confsync:begin claims http-url intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| WHATWG URL Standard の構文解析（ブラウザの寛容な読みは持たない — RFC 3986 の厳格な側） | 意図して非対応 | — |
<!-- confsync:end claims http-url intentional -->

<!-- confsync:begin claims http-cookie intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| cookie jar（RFC 6265 5 の自動の保存と送り — 載せるものは呼び手が書く。任意の origin を渡る汎用エージェントの機械は std に置かない） | 意図して非対応 | — |
<!-- confsync:end claims http-cookie intentional -->

## 未実装

<!-- confsync:begin claims http-server planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| Range（206） | 0.8 圏 | — |
| HTTP/2（h2 / h2c — 外部オラクル h2spec） | 0.8 圏 | — |
| HTTP/3（QUIC — 外部オラクル quic-interop-runner） | 0.8 圏 | — |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IPv6 の番地への接続 | 0.8 圏 | `std/http/client.TestTarget` |
| 応答の Content-Encoding の復号（今は Accept-Encoding を送らない） | 0.8 圏 | — |
| HTTP/2 | 0.8 圏 | — |
<!-- confsync:end claims http-client planned -->

<!-- confsync:begin claims http-url planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IDN（punycode） | 0.8 圏 | — |
<!-- confsync:end claims http-url planned -->

cookie で未実装のものは無い。

## 証拠 — 相互接続（クライアント — 相手 = Go net/http）

<!-- confsync:begin interop-http -->
最終確認: 2026-11-07（木 73597f45c958 (dirty) — scripts/httpinterop.sh・相手 = Go net/http）

`plain` · `tls13` · `tls12-opt-in` · `tls12-default-refused` · `content-length` · `chunked` · `head` · `redirect-303` · `redirect-auth-same-origin-only` · `insecure-redirect-refused` · `stream` · `session` · `proxy-connect` · `proxy-auth` · `unknown-ca-refused`
<!-- confsync:end interop-http -->
