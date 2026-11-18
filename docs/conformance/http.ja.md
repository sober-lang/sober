# HTTP・cookie・URL

[English](http.md) · [準拠文書](README.ja.md)

## 範囲

HTTP/1.1（RFC 9110〜9112）のサーバ（`std/http/server`）とクライアント（`std/http/client`）・cookie（RFC 6265 / 6265bis）・URLの部品（`std/url`）。サーバの検査はgate httpcheck（`testdata/httpcheck/check.ts`。HttpArenaのvalidateを模した送受のテストを平文とTLSの上で掛ける）が主で、表の「`testdata/httpcheck/check.ts`」の証拠はそのテストの項目の名前。外部の検査では、HTTP/1.1の準拠の検査の道具http11probe（HttpArenaのdocker/h1spec.Dockerfile・PROBE_COMMIT d50d818a）で159 / 159（採点の対象の全項目）。

## 対応

### サーバ

<!-- confsync:begin claims http-server yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| HTTP/1.1と1.0のリクエスト・keep-alive・パイプライン（RFC 9112） | 対応 | `testdata/httpcheck/check.ts`: pipelined 16<br>`testdata/httpcheck/check.ts`: HTTP/1.0 keep-alive<br>`std/http/server.TestFrameAgrees` |
| 本文のContent-Lengthとchunked（chunkの拡張とtrailerは文法を確かめて読み捨てる。trailerの行はヘッダの行と同じ文法で、外れたら400） | 対応 | `testdata/httpcheck/check.ts`: chunk ext + trailer<br>`testdata/httpcheck/check.ts`: POST chunked<br>`testdata/httpcheck/check.ts`: trailer bad name<br>`testdata/httpcheck/check.ts`: trailer NUL |
| リクエストの密輸の形の拒否（CL + TE・食い違うCL・obs-fold・裸のCR・空白の前のコロン）= 400 | 対応 | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: CL twice differ<br>`testdata/httpcheck/check.ts`: obs-fold<br>`testdata/httpcheck/check.ts`: bare CR |
| 上限 = 431（頭）・413（本文）・501（空白の無いまま頭の上限に達したメソッド）・chunked以外の符号化を含むTransfer-Encoding = 501（chunkedのパラメータは読み捨てる）・HTTP/1.x以外 = 505・chunkの大きさがintに収まらなければ400 | 対応 | `testdata/httpcheck/check.ts`: head > 8 KiB<br>`testdata/httpcheck/check.ts`: method > 8 KiB<br>`testdata/httpcheck/check.ts`: CL > 16 KiB<br>`testdata/httpcheck/check.ts`: TE gzip<br>`testdata/httpcheck/check.ts`: HTTP/2.0<br>`testdata/httpcheck/check.ts`: chunk size overflow<br>`testdata/httpcheck/check.ts`: TE chunked with params<br>`std/http/server.TestFrameLimits` |
| リクエスト行（RFC 9110 9.1・RFC 9112 3.2）: ターゲットのNULと制御文字と0x80以上のバイト = 400・どのルートにも一致しないCONNECT = 501・asterisk-form（`*`）はOPTIONSなら204（本文とAllowなし）、ほかのメソッドは400・absolute-formは受け、Hostはターゲットの側を使う | 対応 | `testdata/httpcheck/check.ts`: CONNECT<br>`testdata/httpcheck/check.ts`: GET *<br>`testdata/httpcheck/check.ts`: OPTIONS *<br>`std/http/server.TestUnroutedMethod`<br>`testdata/httpcheck/check.ts`: target NUL<br>`testdata/httpcheck/check.ts`: target raw UTF-8<br>`testdata/httpcheck/check.ts`: absolute-form<br>`std/http/server.TestAbsoluteForm`<br>`std/http/server.TestProbeCases` |
| レスポンスのDate（RFC 9110 6.6.1のIMF-fixdate。ワーカーごとに秒が変わったときだけ作り直す値で、最大で約0.3秒古い） | 対応 | `testdata/httpcheck/check.ts`: Date advances on a keep-alive connection<br>`testdata/httpcheck/check.ts`: dateHdr |
| レスポンスのgzip（Accept-Encodingの交渉・Vary）と事前圧縮のファイルのbr / gzの選択 | 対応 | `testdata/httpcheck/check.ts`: gzip stream node:http<br>`testdata/httpcheck/check.ts`: static gz roundtrip |
| レスポンスのstream（長さ既知 = Content-Length・長さ不定 = chunked・HTTP/1.0は閉じで区切る） | 対応 | `testdata/httpcheck/check.ts`: stream file<br>`testdata/httpcheck/check.ts`: chunked node:http |
| 条件付きGET（RFC 9110 13 — ETag・Last-Modified・304 / 412）とCache-Controlの既定private | 対応 | `std/http/server.TestTagIn`<br>`std/http/server.TestParseDate`<br>`testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: default cache-control private |
| multipart/form-data（RFC 7578） | 対応 | `std/http/server.TestMultipartRfc`<br>`std/http/server.TestMultipartBrowsers`<br>`testdata/httpcheck/check.ts`: upload formdata |
| Server-Sent Events（text/event-stream・Last-Event-ID） | 対応 | `std/http/server.TestFormatEvent`<br>`testdata/httpcheck/check.ts`: sse Last-Event-ID |
| Expect: 100-continue（頭が揃い本文が未着なら100を送る。HTTP/1.0のExpectは無視する） | 対応 | `testdata/httpcheck/check.ts`: expect 100-continue<br>`testdata/httpcheck/check.ts`: expect 100-continue HTTP/1.0 ignored |
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

## RFC 9110・9112のMUST（サーバー）

RFC 9110とRFC 9112がサーバー（オリジンサーバー・リクエストの受け手・レスポンスの送り手）に課すMUSTとMUST NOTのうち、検査の証拠があるものを節の番号つきで並べる。証拠の無い要件は表に載せない（作業用の全件の表で確かめを続ける）。

<!-- confsync:begin claims http-must yes,partial -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| RFC 9112 2.2: 受けた裸のCRは無効として扱う（400） | 対応 | `testdata/httpcheck/check.ts`: bare CR<br>`testdata/httpcheck/check.ts`: chunk ext bare CR |
| RFC 9112 3: 扱わない長さのrequest-targetには414 | 対応 | `testdata/httpcheck/check.ts`: target > 8 KiB |
| RFC 9112 3.2: Hostの無いHTTP/1.1のリクエスト・2行以上のHost・無効な値のHostには400 | 対応 | `testdata/httpcheck/check.ts`: Host missing<br>`testdata/httpcheck/check.ts`: Host twice<br>`testdata/httpcheck/check.ts`: Host empty<br>`testdata/httpcheck/check.ts`: absolute-form without Host |
| RFC 9112 3.2.2: absolute-formのリクエストを受ける | 対応 | `testdata/httpcheck/check.ts`: absolute-form<br>`std/http/server.TestAbsoluteForm` |
| RFC 9112 3.2.2: absolute-formを受けたオリジンサーバーは、受けたHostを無視してターゲットのhostを使う | 対応 | `testdata/httpcheck/check.ts`: absolute-form Host mismatch uses the target<br>`std/http/server.TestAbsoluteForm` |
| RFC 9112 5.1: ヘッダ名とコロンの間の空白は400 | 対応 | `testdata/httpcheck/check.ts`: space before colon |
| RFC 9112 5.2: 受けたobs-foldは400 | 対応 | `testdata/httpcheck/check.ts`: obs-fold |
| RFC 9112 6.1: chunkedを読める | 対応 | `testdata/httpcheck/check.ts`: POST chunked |
| RFC 9112 6.1: Transfer-EncodingとContent-Lengthが両方あるリクエストには、応えた後で接続を閉じる（400で閉じる） | 対応 | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: TE chunked with params + CL |
| RFC 9112 6.1: Transfer-EncodingのあるHTTP/1.0のメッセージは枠の誤りとして扱い、閉じる | 対応 | `testdata/httpcheck/check.ts`: TE in HTTP/1.0 |
| RFC 9112 6.3: 最後の転送符号化がchunkedでないリクエストには400を返して閉じる | 対応 | `testdata/httpcheck/check.ts`: TE chunked not final |
| RFC 9112 6.3: 無効なContent-Lengthのリクエストは回復できない誤りとして400 | 対応 | `testdata/httpcheck/check.ts`: CL not digits<br>`testdata/httpcheck/check.ts`: CL twice differ |
| RFC 9112 7.1: chunkedを解く（大きな16進でも整数があふれない） | 対応 | `testdata/httpcheck/check.ts`: chunk size overflow<br>`std/http/server.TestFrameAgrees` |
| RFC 9112 7.1.1: 知らないchunk拡張は無視する | 対応 | `testdata/httpcheck/check.ts`: chunk ext + trailer |
| RFC 9112 9.3.2: パイプラインのレスポンスは受けた順に送る | 対応 | `testdata/httpcheck/check.ts`: pipelined 16 |
| RFC 9112 9.6: closeを受けたら、そのレスポンスの後で閉じ、以後のリクエストを処理しない | 対応 | `testdata/httpcheck/check.ts`: GET baseline<br>`testdata/httpcheck/check.ts`: HTTP/1.0 closes |
| RFC 9110 4.2.1: hostが空のhttp URIは無効 | 対応 | `testdata/httpcheck/check.ts`: Host empty |
| RFC 9110 5.4: 大きすぎるヘッダには4xx（431） | 対応 | `testdata/httpcheck/check.ts`: head > 8 KiB |
| RFC 9110 5.5: 値のCR・LF・NULは拒否する（400） | 対応 | `testdata/httpcheck/check.ts`: NUL in value |
| RFC 9110 5.6.1.2: リストの空の要素を読み飛ばす | 対応 | `testdata/httpcheck/check.ts`: TE leading comma |
| RFC 9110 5.6.3: BWSを読んで除いてから解釈する | 対応 | `testdata/httpcheck/check.ts`: chunk ext quoted-string |
| RFC 9110 5.6.7: HTTP-dateの3つの形を受け付ける | 対応 | `std/http/server.TestParseDate` |
| RFC 9110 5.6.7・6.6.1: 時計のあるオリジンサーバーは2xx・3xx・4xxにDateを付け、IMF-fixdateで生成する | 対応 | `testdata/httpcheck/check.ts`: Date advances on a keep-alive connection<br>`testdata/httpcheck/check.ts`: dateHdr |
| RFC 9110 8.6: HEADのContent-LengthはGETの本文の長さと等しい | 対応 | `testdata/httpcheck/check.ts`: static HEAD |
| RFC 9110 8.6: 1xxと204にContent-Lengthを送らない | 対応 | `testdata/httpcheck/check.ts`: OPTIONS * keep-alive, no Allow / Content-Length |
| RFC 9110 8.8.3: 強い検証子の性質を満たさないETagにはW/を付ける | 対応 | `testdata/httpcheck/check.ts`: static etag 200 |
| RFC 9110 9.1・9.3.2: GETとHEADに対応し、HEADのレスポンスに内容を送らない | 対応 | `testdata/httpcheck/check.ts`: HEAD no body |
| RFC 9110 9.3.6: 空か無効なportのCONNECTを拒否する（CONNECTは501） | 対応 | `testdata/httpcheck/check.ts`: CONNECT |
| RFC 9110 10.2.1・15.5.6: 405にはAllowを付ける | 対応 | `testdata/httpcheck/check.ts`: static POST 405 |
| RFC 9110 13.1.1: If-Matchは強い比較で評価し、偽なら412 | 対応 | `testdata/httpcheck/check.ts`: static if-match weak is 412 |
| RFC 9110 13.1.2: If-None-Matchは弱い比較で評価し、GET / HEADなら304 | 対応 | `testdata/httpcheck/check.ts`: static 304 if-none-match |
| RFC 9110 13.1.3: If-None-MatchがあればIf-Modified-Sinceを無視する | 対応 | `testdata/httpcheck/check.ts`: static if-none-match wins over ims |
| RFC 9110 13.1.4: If-Unmodified-Sinceが偽なら412 | 対応 | `testdata/httpcheck/check.ts`: static if-unmodified-since |
| RFC 9112 2.2・5.2・RFC 9110 2.2: アプリがResponseに入れた値のうち、Coded.encoding・任意ヘッダの値・statusが文法の外ならpanic(BadHeader)にし、裸のCR・obs-fold・ABNFの外の頭を送らない | 対応 | `std/http/server.TestBadEncoding`<br>`std/http/server.TestBadHeaders`<br>`std/http/server.TestBadStatus` |
| RFC 9110 5.3: リストでない欄の行を2行生成しない（1行だけの欄の表〔下の節〕にある欄の2本目と、ライブラリが書く欄を任意ヘッダに書くことはpanic(BadHeader)。リストの欄とアプリが定めた欄は2行書ける） | 対応 | `std/http/server.TestBadHeaders`<br>`testdata/httpcheck/check.ts`: dup Link two lines<br>`testdata/httpcheck/check.ts`: dup custom field two lines<br>`testdata/httpcheck/check.ts`: dup Location panic |
| RFC 9110 5.6.4: multipartのboundaryのquoted-stringで、quoted-pairを後ろのオクテットに置き換える | 対応 | `std/http/server.TestMultipartShapes` |
| RFC 9110 5.6.7: RFC 850の2桁の年は、50年より先に見えるなら下2桁が同じ直近の過去の年と読む（今の年から決める） | 対応 | `std/http/server.TestYear850`<br>`std/http/server.TestParseDate` |
| RFC 9110 8.8.2.1: StaticはDateより後のLast-Modifiedを送らない（未来の更新時刻は今の秒に置き換える） | 対応 | `testdata/httpcheck/check.ts`: static future last-modified |
| RFC 9110 10.1.1: Expect: 100-continueのHTTP/1.1のリクエストには、本文を待つ前に100か最終のstatus（本文が上限を越えるなら413）を送る | 対応 | `testdata/httpcheck/check.ts`: expect 100-continue<br>`testdata/httpcheck/check.ts`: expect 100-continue chunked<br>`testdata/httpcheck/check.ts`: expect 100-continue after a pipelined request<br>`testdata/httpcheck/check.ts`: expect 100-continue CL > max 413 |
| RFC 9110 15.2: 1xxを最終のレスポンスにしない（panic(BadHeader)）ので、HTTP/1.0のクライアントに1xxを送らない。HTTP/1.0のExpectは無視する | 対応 | `std/http/server.TestBadStatus`<br>`testdata/httpcheck/check.ts`: expect 100-continue HTTP/1.0 ignored |
| RFC 9110 15.3.6: 205に内容を生成しない（204・205・304に本文があればpanic(BadHeader)。205はContent-Length: 0） | 対応 | `std/http/server.TestBadBodyless` |
| RFC 9110 15.4.5: Staticの304に、同じリクエストの200と同じVary: Accept-Encodingを付ける | 対応 | `testdata/httpcheck/check.ts`: static 304 vary vary.css<br>`testdata/httpcheck/check.ts`: static 304 vary tiny.css |
| RFC 9110 2.3: 自分が生成する長さ以上の要素を読める。ライブラリが生成する要素（ETag・HTTP-date）は受けて読める。アプリが長さを決める要素（Set-Cookieの値など）は、返ってきたときに頭の上限（既定8 KiB）に収まる保証が無い | 一部 | `testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: static etag 200 |
| RFC 9110 10.1.1: 100を送ったら最終のstatusを送る | 対応 | `testdata/httpcheck/check.ts`: expect 100-continue |
<!-- confsync:end claims http-must yes,partial -->

### 1行だけの欄（RFC 9110 5.3）

任意ヘッダ（Response.headers）では、次の欄の2本目をpanic(BadHeader)にする。仕様がリストでない値（1行だけ）と定めた欄で、アプリが書けるものを並べた。表に無い欄（リストの欄と、アプリが独自に定めた欄）は、同じ名前で何本でも書ける。表は「1行だけの欄」を列挙する向きにしている。許す欄を列挙すると、表に無い新しい欄や独自の欄が理由なく書けなくなるため。

| 欄 | 根拠 |
|---|---|
| Location | RFC 9110 10.2.2 |
| Content-Location | RFC 9110 8.7 |
| Content-Range | RFC 9110 14.4 |
| Retry-After | RFC 9110 10.2.3 |
| Server | RFC 9110 10.2.4 |
| Age | RFC 9111 5.1 |
| Expires | RFC 9111 5.3 |
| Content-Disposition | RFC 6266 4.1 |
| Strict-Transport-Security | RFC 6797 6.1 |
| X-Frame-Options | RFC 7034 2.1 |

ライブラリが書く欄（Date〔RFC 9110 6.6.1〕・Content-Type〔8.3〕・Content-Length〔8.6〕・Content-Encoding・Transfer-Encoding・Connection・Vary・Cache-Control・CDN-Cache-Control・Surrogate-Control・ETag〔8.8.3〕・Last-Modified〔8.8.2〕・Set-Cookie）は、1本目から任意ヘッダに書けない（重複を防ぐため）。

棄てた案: どの名前も2本目をpanicにする形。RFC 9110 5.3が禁じるのはリストでない欄の2行だけで、LinkやVaryを2行書くことは仕様が認めている。実装を単純にするために、仕様より狭い制限を利用者に課すことになるため。

### 満たしていない要件

直すかどうかは要件ごとに決める。

<!-- confsync:begin claims http-must no -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| RFC 9112 2.2・5.2・RFC 9110 2.2: ResponseのcontentTypeがmedia-typeの文法の外でも、そのまま送る（検査しない）。名前つきの文字列の型が言語に入った時点で、contentTypeをその型にして、リテラルの文法をコンパイル時に検査する予定。実行時に毎回検査する形は、要求1件あたりの命令が大きく増えるので採らない | 非対応 | なし |
| RFC 9112 9.8: TLSで閉じる前にclosure alertの交換を始める。std/tlsはkが返れば（errorでも）close_notifyを送るが、kが死んだとき（panic）は送らずに閉じる | 非対応 | なし |
<!-- confsync:end claims http-must no -->

### 対象外

その機能を持たないので掛からない要件。

<!-- confsync:begin claims http-must na -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| RFC 9112 6.1・RFC 9110 8.6・9.3.6: CONNECTへの2xxの頭の規則（CONNECTを実装しない） | 対象外 | なし |
| RFC 9110 4.2.4: httpとhttpsのURIにuserinfoを生成しない（URIを生成しない） | 対象外 | なし |
| RFC 9110 7.4: httpsのリソースへの安全でない接続のリクエストを拒否する（サーバーはschemeでリソースを分けない） | 対象外 | なし |
| RFC 9110 7.8・15.5.22: 101と426のUpgradeの規則（Upgradeを実装しない） | 対象外 | なし |
| RFC 9110 9.3.4: PUTの成否と検証子の規則（PUTの処理はアプリの側） | 対象外 | なし |
| RFC 9110 11.6.1・15.5.2: 401のWWW-Authenticate（認証はアプリの側） | 対象外 | なし |
| RFC 9110 12.5.3: 415のAccept-Encoding（415を送らない） | 対象外 | なし |
| RFC 9110 15.3.7: 206の頭と内容の規則（Rangeを実装しない） | 対象外 | なし |
<!-- confsync:end claims http-must na -->

## 意図して外したこと

<!-- confsync:begin claims http-server intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| Upgrade（WebSocketを含む）・CONNECT（サーバからの押し出しはSSEが今の答え — WebSocketは実需が立てば0.8以降のピンへ上げる） | 意図して非対応 | なし |
<!-- confsync:end claims http-server intentional -->

<!-- confsync:begin claims http-client intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| URLのuserinfo（user:pass@） | 意図して非対応 | `std/http/client.TestTarget` |
<!-- confsync:end claims http-client intentional -->

<!-- confsync:begin claims http-url intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| WHATWG URL Standardの構文解析（ブラウザの寛容な解釈は持たない — RFC 3986の厳格な側） | 意図して非対応 | なし |
<!-- confsync:end claims http-url intentional -->

<!-- confsync:begin claims http-cookie intentional -->
| 項目 | 状態 | 証拠 |
|---|---|---|
| cookie jar（RFC 6265 5の自動の保存と送り — 載せるものは呼び手が書く。任意のoriginを渡る汎用エージェントの機械はstdに置かない） | 意図して非対応 | なし |
<!-- confsync:end claims http-cookie intentional -->

## 未実装

<!-- confsync:begin claims http-server planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| Range（206） | 0.8圏 | なし |
| HTTP/2（h2 / h2c — 外部オラクルh2spec） | 0.8圏 | なし |
| HTTP/3（QUIC — 外部オラクルquic-interop-runner） | 0.8圏 | なし |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IPv6の番地への接続 | 0.8圏 | `std/http/client.TestTarget` |
| レスポンスのContent-Encodingの復号（今はAccept-Encodingを送らない） | 0.8圏 | なし |
| HTTP/2 | 0.8圏 | なし |
<!-- confsync:end claims http-client planned -->

<!-- confsync:begin claims http-url planned -->
| 項目 | 時期 | 今の挙動の証拠 |
|---|---|---|
| IDN（punycode） | 0.8圏 | なし |
<!-- confsync:end claims http-url planned -->

cookieで未実装のものは無い。

## 証拠 — 相互接続（クライアント — 相手 = Go net/http）

<!-- confsync:begin interop-http -->
最終確認: 2026-11-07（木73597f45c958 (dirty) — scripts/httpinterop.sh・相手 = Go net/http）

`plain` · `tls13` · `tls12-opt-in` · `tls12-default-refused` · `content-length` · `chunked` · `head` · `redirect-303` · `redirect-auth-same-origin-only` · `insecure-redirect-refused` · `stream` · `session` · `proxy-connect` · `proxy-auth` · `unknown-ca-refused`
<!-- confsync:end interop-http -->
