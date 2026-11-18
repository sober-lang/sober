# HTTP, cookies, URLs

[日本語](http.ja.md) · [Conformance](README.md)

## Scope

The HTTP/1.1 (RFC 9110–9112) server (`std/http/server`) and client (`std/http/client`), cookies (RFC 6265 / 6265bis), and URL parts (`std/url`). The main suite for the server is the httpcheck gate (`testdata/httpcheck/check.ts` — exchanges modeled on HttpArena's validation, over plain TCP and TLS); evidence citing `testdata/httpcheck/check.ts` names a check in that suite. External check: the HTTP/1.1 conformance tool http11probe (HttpArena docker/h1spec.Dockerfile, PROBE_COMMIT d50d818a) scores 159 / 159 (every scored item).

## Supported

### Server

<!-- confsync:begin claims http-server yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| HTTP/1.1 and 1.0 requests, keep-alive, pipelining (RFC 9112) | Supported | `testdata/httpcheck/check.ts`: pipelined 16<br>`testdata/httpcheck/check.ts`: HTTP/1.0 keep-alive<br>`std/http/server.TestFrameAgrees` |
| Bodies with Content-Length and chunked (chunk extensions and trailers are checked against their grammar and discarded; a trailer line follows the header line grammar, 400 otherwise) | Supported | `testdata/httpcheck/check.ts`: chunk ext + trailer<br>`testdata/httpcheck/check.ts`: POST chunked<br>`testdata/httpcheck/check.ts`: trailer bad name<br>`testdata/httpcheck/check.ts`: trailer NUL |
| Rejects request-smuggling shapes (CL + TE, conflicting CL, obs-fold, bare CR, space before colon) with 400 | Supported | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: CL twice differ<br>`testdata/httpcheck/check.ts`: obs-fold<br>`testdata/httpcheck/check.ts`: bare CR |
| Limits: 431 (head), 413 (body), 501 (a method that reaches the head limit without a space); a Transfer-Encoding with a coding other than chunked = 501 (parameters on chunked are ignored); versions other than HTTP/1.x = 505; a chunk size that does not fit in an int = 400 | Supported | `testdata/httpcheck/check.ts`: head > 8 KiB<br>`testdata/httpcheck/check.ts`: method > 8 KiB<br>`testdata/httpcheck/check.ts`: CL > 16 KiB<br>`testdata/httpcheck/check.ts`: TE gzip<br>`testdata/httpcheck/check.ts`: HTTP/2.0<br>`testdata/httpcheck/check.ts`: chunk size overflow<br>`testdata/httpcheck/check.ts`: TE chunked with params<br>`std/http/server.TestFrameLimits` |
| Request line (RFC 9110 9.1, RFC 9112 3.2): NUL, control characters and bytes 0x80 and above in the target = 400; an unrouted CONNECT = 501; asterisk-form (`*`) is 204 for OPTIONS (no body, no Allow) and 400 for other methods; absolute-form is accepted and the target's host replaces Host | Supported | `testdata/httpcheck/check.ts`: CONNECT<br>`testdata/httpcheck/check.ts`: GET *<br>`testdata/httpcheck/check.ts`: OPTIONS *<br>`std/http/server.TestUnroutedMethod`<br>`testdata/httpcheck/check.ts`: target NUL<br>`testdata/httpcheck/check.ts`: target raw UTF-8<br>`testdata/httpcheck/check.ts`: absolute-form<br>`std/http/server.TestAbsoluteForm`<br>`std/http/server.TestProbeCases` |
| Date on responses (RFC 9110 6.6.1, IMF-fixdate; rebuilt per worker when the second changes, at most about 0.3 s old) | Supported | `testdata/httpcheck/check.ts`: Date advances on a keep-alive connection<br>`testdata/httpcheck/check.ts`: dateHdr |
| Response gzip (Accept-Encoding negotiation, Vary) and choosing precompressed br / gz files | Supported | `testdata/httpcheck/check.ts`: gzip stream node:http<br>`testdata/httpcheck/check.ts`: static gz roundtrip |
| Streamed responses (known length = Content-Length, unknown = chunked, HTTP/1.0 delimited by close) | Supported | `testdata/httpcheck/check.ts`: stream file<br>`testdata/httpcheck/check.ts`: chunked node:http |
| Conditional GET (RFC 9110 13 — ETag, Last-Modified, 304 / 412) and a private Cache-Control default | Supported | `std/http/server.TestTagIn`<br>`std/http/server.TestParseDate`<br>`testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: default cache-control private |
| multipart/form-data (RFC 7578) | Supported | `std/http/server.TestMultipartRfc`<br>`std/http/server.TestMultipartBrowsers`<br>`testdata/httpcheck/check.ts`: upload formdata |
| Server-Sent Events (text/event-stream, Last-Event-ID) | Supported | `std/http/server.TestFormatEvent`<br>`testdata/httpcheck/check.ts`: sse Last-Event-ID |
| Expect: 100-continue (a 100 is sent once the header is complete and the body has not arrived; Expect in HTTP/1.0 is ignored) | Supported | `testdata/httpcheck/check.ts`: expect 100-continue<br>`testdata/httpcheck/check.ts`: expect 100-continue HTTP/1.0 ignored |
<!-- confsync:end claims http-server yes,partial -->

### Client

<!-- confsync:begin claims http-client yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| http and https (see the TLS chapter), Content-Length / chunked / close-delimited bodies, HEAD | Supported | `std/http/client.TestPlainLoopback`<br>`std/http/client.TestBodyMachine`<br>interop http: chunked (2026-11-07)<br>interop http: head (2026-11-07) |
| Redirects (up to 10; 301 / 302 / 303 become GET, 307 / 308 keep the method; auth headers dropped across origins; never https → http) | Supported | interop http: redirect-303 (2026-11-07)<br>interop http: redirect-auth-same-origin-only (2026-11-07)<br>interop http: insecure-redirect-refused (2026-11-07) |
| Keep-alive sessions (Open / Send), streaming (Stream) | Supported | `std/http/client.TestSessionPlain`<br>`std/http/client.TestStreamPlain`<br>interop http: session (2026-11-07)<br>interop http: stream (2026-11-07) |
| Proxy (CONNECT tunnel, Proxy-Authorization) | Supported | `std/http/client.TestProxyLoopback`<br>interop http: proxy-connect (2026-11-07)<br>interop http: proxy-auth (2026-11-07) |
| Skips 1xx interim responses | Supported | `std/http/client.TestScanSplits` |
| Timeouts and body limits (on in the zero value) | Supported | `std/http/client.TestTimeoutAndRefused` |
<!-- confsync:end claims http-client yes,partial -->

### Cookies

<!-- confsync:begin claims http-cookie yes -->
| Item | Status | Evidence |
|---|---|---|
| Writing Set-Cookie (the zero value is the safe side: Secure, HttpOnly, SameSite=Lax, Path=/, host-only) | Supported | `std/http/server.TestSetCookieDefaults`<br>`std/http/server.TestSetCookieRejects` |
| __Host- / __Secure- prefixes (RFC 6265bis 4.1.3) | Supported | `std/http/server.TestSetCookieRejects` |
| Client cookies are data (read from Set-Cookie with CookieValue, sent with the request's cookies: argument — dropped on a cross-origin redirect) | Supported | `std/http/client.TestCookieValue`<br>`std/http/client.TestCookieLoopback` |
<!-- confsync:end claims http-cookie yes -->

### URLs

Position: std stands on the strict side of RFC 3986 and does not implement browser-style lenient parsing (the WHATWG URL Standard). There is no general URL type; URLs are parsed only inside the HTTP client (absolute http / https URLs).

<!-- confsync:begin claims http-url yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| percent-encoding (RFC 3986 2.1) Escape / Unescape | Supported | `testdata/stdtest/stdurl.TestEscape`<br>`testdata/stdtest/stdurl.TestUnescape`<br>`testdata/stdtest/stdurl.TestUnescapeRejects` |
| Reading and writing application/x-www-form-urlencoded queries | Supported | `testdata/stdtest/stdurl.TestParseQuery`<br>`testdata/stdtest/stdurl.TestFormatQuery` |
| URL parsing (absolute http / https URLs inside the HTTP client only — no general URL type) | Partial | `std/http/client.TestTarget`<br>`std/http/client.TestLocation` |
<!-- confsync:end claims http-url yes,partial -->

## RFC 9110 and 9112 MUSTs (server)

The MUST and MUST NOT requirements RFC 9110 and RFC 9112 place on servers (origin servers, request recipients, response senders) that have test evidence, listed with their section numbers. Requirements without evidence are left out (they stay in the working table until checked).

<!-- confsync:begin claims http-must yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| RFC 9112 2.2: a bare CR received is treated as invalid (400) | Supported | `testdata/httpcheck/check.ts`: bare CR<br>`testdata/httpcheck/check.ts`: chunk ext bare CR |
| RFC 9112 3: a request-target longer than the server handles gets 414 | Supported | `testdata/httpcheck/check.ts`: target > 8 KiB |
| RFC 9112 3.2: an HTTP/1.1 request without Host, with two or more Host lines, or with an invalid Host value gets 400 | Supported | `testdata/httpcheck/check.ts`: Host missing<br>`testdata/httpcheck/check.ts`: Host twice<br>`testdata/httpcheck/check.ts`: Host empty<br>`testdata/httpcheck/check.ts`: absolute-form without Host |
| RFC 9112 3.2.2: requests in absolute-form are accepted | Supported | `testdata/httpcheck/check.ts`: absolute-form<br>`std/http/server.TestAbsoluteForm` |
| RFC 9112 3.2.2: an origin server receiving absolute-form ignores the received Host and uses the target's host | Supported | `testdata/httpcheck/check.ts`: absolute-form Host mismatch uses the target<br>`std/http/server.TestAbsoluteForm` |
| RFC 9112 5.1: whitespace between a field name and the colon gets 400 | Supported | `testdata/httpcheck/check.ts`: space before colon |
| RFC 9112 5.2: obs-fold received gets 400 | Supported | `testdata/httpcheck/check.ts`: obs-fold |
| RFC 9112 6.1: the chunked transfer coding is parsed | Supported | `testdata/httpcheck/check.ts`: POST chunked |
| RFC 9112 6.1: after responding to a request with both Transfer-Encoding and Content-Length, the connection is closed (400, then close) | Supported | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: TE chunked with params + CL |
| RFC 9112 6.1: an HTTP/1.0 message with Transfer-Encoding is treated as faulty framing and the connection is closed | Supported | `testdata/httpcheck/check.ts`: TE in HTTP/1.0 |
| RFC 9112 6.3: a request whose final transfer coding is not chunked gets 400 and the connection is closed | Supported | `testdata/httpcheck/check.ts`: TE chunked not final |
| RFC 9112 6.3: a request with an invalid Content-Length is an unrecoverable error (400) | Supported | `testdata/httpcheck/check.ts`: CL not digits<br>`testdata/httpcheck/check.ts`: CL twice differ |
| RFC 9112 7.1: chunked is decoded (no integer overflow on large hex sizes) | Supported | `testdata/httpcheck/check.ts`: chunk size overflow<br>`std/http/server.TestFrameAgrees` |
| RFC 9112 7.1.1: unknown chunk extensions are ignored | Supported | `testdata/httpcheck/check.ts`: chunk ext + trailer |
| RFC 9112 9.3.2: pipelined responses are sent in the order the requests were received | Supported | `testdata/httpcheck/check.ts`: pipelined 16 |
| RFC 9112 9.6: after a request with close, the connection is closed after the response and later requests are not processed | Supported | `testdata/httpcheck/check.ts`: GET baseline<br>`testdata/httpcheck/check.ts`: HTTP/1.0 closes |
| RFC 9110 4.2.1: an http URI with an empty host is invalid | Supported | `testdata/httpcheck/check.ts`: Host empty |
| RFC 9110 5.4: oversized header fields get a 4xx (431) | Supported | `testdata/httpcheck/check.ts`: head > 8 KiB |
| RFC 9110 5.5: CR, LF and NUL in field values are rejected (400) | Supported | `testdata/httpcheck/check.ts`: NUL in value |
| RFC 9110 5.6.1.2: empty list elements are skipped | Supported | `testdata/httpcheck/check.ts`: TE leading comma |
| RFC 9110 5.6.3: BWS is parsed and removed before interpretation | Supported | `testdata/httpcheck/check.ts`: chunk ext quoted-string |
| RFC 9110 5.6.7: all three HTTP-date formats are accepted | Supported | `std/http/server.TestParseDate` |
| RFC 9110 5.6.7, 6.6.1: an origin server with a clock sends Date on 2xx, 3xx and 4xx, generated as IMF-fixdate | Supported | `testdata/httpcheck/check.ts`: Date advances on a keep-alive connection<br>`testdata/httpcheck/check.ts`: dateHdr |
| RFC 9110 8.6: Content-Length on HEAD equals the GET body length | Supported | `testdata/httpcheck/check.ts`: static HEAD |
| RFC 9110 8.6: no Content-Length on 1xx and 204 | Supported | `testdata/httpcheck/check.ts`: OPTIONS * keep-alive, no Allow / Content-Length |
| RFC 9110 8.8.3: an ETag that is not a strong validator carries W/ | Supported | `testdata/httpcheck/check.ts`: static etag 200 |
| RFC 9110 9.1, 9.3.2: GET and HEAD are supported and HEAD responses carry no content | Supported | `testdata/httpcheck/check.ts`: HEAD no body |
| RFC 9110 9.3.6: CONNECT with an empty or invalid port is rejected (CONNECT gets 501) | Supported | `testdata/httpcheck/check.ts`: CONNECT |
| RFC 9110 10.2.1, 15.5.6: 405 carries Allow | Supported | `testdata/httpcheck/check.ts`: static POST 405 |
| RFC 9110 13.1.1: If-Match uses the strong comparison and a false result gets 412 | Supported | `testdata/httpcheck/check.ts`: static if-match weak is 412 |
| RFC 9110 13.1.2: If-None-Match uses the weak comparison and GET / HEAD get 304 | Supported | `testdata/httpcheck/check.ts`: static 304 if-none-match |
| RFC 9110 13.1.3: If-Modified-Since is ignored when If-None-Match is present | Supported | `testdata/httpcheck/check.ts`: static if-none-match wins over ims |
| RFC 9110 13.1.4: a false If-Unmodified-Since gets 412 | Supported | `testdata/httpcheck/check.ts`: static if-unmodified-since |
| RFC 9112 2.2, 5.2, RFC 9110 2.2: of the values an application puts in a Response, Coded.encoding, custom header values and status that do not match the grammar are a panic(BadHeader), so no bare CR, obs-fold or header outside the ABNF is sent | Supported | `std/http/server.TestBadEncoding`<br>`std/http/server.TestBadHeaders`<br>`std/http/server.TestBadStatus` |
| RFC 9110 5.3: no two field lines are generated for a field that is not a list (a second line of a field in the single-line table below, or a field the library writes given as a custom header, is a panic(BadHeader); list fields and fields the application defines may have two lines) | Supported | `std/http/server.TestBadHeaders`<br>`testdata/httpcheck/check.ts`: dup Link two lines<br>`testdata/httpcheck/check.ts`: dup custom field two lines<br>`testdata/httpcheck/check.ts`: dup Location panic |
| RFC 9110 5.6.4: in a multipart boundary quoted-string, a quoted-pair is replaced by the octet that follows | Supported | `std/http/server.TestMultipartShapes` |
| RFC 9110 5.6.7: a two-digit RFC 850 year that appears more than 50 years in the future is read as the most recent past year with the same last two digits (decided from the current year) | Supported | `std/http/server.TestYear850`<br>`std/http/server.TestParseDate` |
| RFC 9110 8.8.2.1: Static never sends a Last-Modified later than Date (a future modification time is replaced by the current second) | Supported | `testdata/httpcheck/check.ts`: static future last-modified |
| RFC 9110 10.1.1: for an HTTP/1.1 request with Expect: 100-continue, a 100 or a final status (413 when the body exceeds the limit) is sent before waiting for the body | Supported | `testdata/httpcheck/check.ts`: expect 100-continue<br>`testdata/httpcheck/check.ts`: expect 100-continue chunked<br>`testdata/httpcheck/check.ts`: expect 100-continue after a pipelined request<br>`testdata/httpcheck/check.ts`: expect 100-continue CL > max 413 |
| RFC 9110 15.2: a 1xx is never the final response (panic(BadHeader)), so no 1xx goes to an HTTP/1.0 client; Expect in HTTP/1.0 is ignored | Supported | `std/http/server.TestBadStatus`<br>`testdata/httpcheck/check.ts`: expect 100-continue HTTP/1.0 ignored |
| RFC 9110 15.3.6: no content is generated for 205 (a body on 204, 205 or 304 is a panic(BadHeader); 205 carries Content-Length: 0) | Supported | `std/http/server.TestBadBodyless` |
| RFC 9110 15.4.5: a Static 304 carries the same Vary: Accept-Encoding as the 200 for the same request | Supported | `testdata/httpcheck/check.ts`: static 304 vary vary.css<br>`testdata/httpcheck/check.ts`: static 304 vary tiny.css |
| RFC 9110 2.3: elements at least as long as those generated can be parsed. Elements the library generates (ETag, HTTP-date) are parsed when received; elements whose length the application decides (such as Set-Cookie values) are not guaranteed to fit the header limit (8 KiB by default) when they come back | Partial | `testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: static etag 200 |
| RFC 9110 10.1.1: a final status follows a 100 | Supported | `testdata/httpcheck/check.ts`: expect 100-continue |
<!-- confsync:end claims http-must yes,partial -->

### Single-line fields (RFC 9110 5.3)

In custom headers (Response.headers), a second line of any of these fields is a panic(BadHeader). The table lists the fields an application can write whose value the specification defines as not a list (one line only). Fields not in the table (list fields and fields the application defines) may be written any number of times under the same name. The table enumerates the single-line fields rather than the fields that are allowed twice, so that new or application-defined fields are not refused without a reason.

| Field | Source |
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

Fields the library writes (Date [RFC 9110 6.6.1], Content-Type [8.3], Content-Length [8.6], Content-Encoding, Transfer-Encoding, Connection, Vary, Cache-Control, CDN-Cache-Control, Surrogate-Control, ETag [8.8.3], Last-Modified [8.8.2], Set-Cookie) cannot be given as custom headers at all, so they are never duplicated.

Rejected: a panic on the second line of any name. RFC 9110 5.3 forbids two lines only for fields that are not lists, and the specification allows two lines of Link or Vary. Refusing them would impose a restriction narrower than the specification on users just to keep the implementation simple.

### Requirements not met

Whether to fix each one is decided per requirement.

<!-- confsync:begin claims http-must no -->
| Item | Status | Evidence |
|---|---|---|
| RFC 9112 2.2, 5.2, RFC 9110 2.2: a Response contentType outside the media-type grammar is sent as is (not checked). Once named string types are in the language, contentType becomes such a type and its literals are checked against the grammar at compile time. A check on every response at run time is not used, because it adds many instructions per request | Not supported | none |
| RFC 9112 9.8: over TLS, an exchange of closure alerts is initiated before closing. std/tls sends close_notify when k returns (even with an error) but closes without it when k dies (panic) | Not supported | none |
<!-- confsync:end claims http-must no -->

### Not applicable

Requirements that do not apply because the feature is absent.

<!-- confsync:begin claims http-must na -->
| Item | Status | Evidence |
|---|---|---|
| RFC 9112 6.1, RFC 9110 8.6, 9.3.6: header rules for 2xx responses to CONNECT (CONNECT is not implemented) | Not applicable | none |
| RFC 9110 4.2.4: no userinfo in generated http and https URIs (the server generates no URIs) | Not applicable | none |
| RFC 9110 7.4: rejecting requests for https resources over insecure connections (the server does not split resources by scheme) | Not applicable | none |
| RFC 9110 7.8, 15.5.22: Upgrade rules for 101 and 426 (Upgrade is not implemented) | Not applicable | none |
| RFC 9110 9.3.4: PUT outcome and validator rules (PUT handling belongs to the application) | Not applicable | none |
| RFC 9110 11.6.1, 15.5.2: WWW-Authenticate on 401 (authentication belongs to the application) | Not applicable | none |
| RFC 9110 12.5.3: Accept-Encoding on 415 (415 is never sent) | Not applicable | none |
| RFC 9110 15.3.7: header and content rules for 206 (Range is not implemented) | Not applicable | none |
<!-- confsync:end claims http-must na -->

## Not supported by design

<!-- confsync:begin claims http-server intentional -->
| Item | Status | Evidence |
|---|---|---|
| Upgrade (including WebSocket), CONNECT (SSE is today's answer for server push — WebSocket moves to a 0.8+ pin once there is a real demand) | Not supported (by design) | none |
<!-- confsync:end claims http-server intentional -->

<!-- confsync:begin claims http-client intentional -->
| Item | Status | Evidence |
|---|---|---|
| userinfo in URLs (user:pass@) | Not supported (by design) | `std/http/client.TestTarget` |
<!-- confsync:end claims http-client intentional -->

<!-- confsync:begin claims http-url intentional -->
| Item | Status | Evidence |
|---|---|---|
| WHATWG URL Standard parsing (no browser-style lenient parsing — the strict RFC 3986 side) | Not supported (by design) | none |
<!-- confsync:end claims http-url intentional -->

<!-- confsync:begin claims http-cookie intentional -->
| Item | Status | Evidence |
|---|---|---|
| Cookie jar (RFC 6265 5 automatic storage and sending — the caller writes what is sent; the machinery of a general agent crossing arbitrary origins is not in std) | Not supported (by design) | none |
<!-- confsync:end claims http-cookie intentional -->

## Not yet

<!-- confsync:begin claims http-server planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| Range requests (206) | 0.8 | none |
| HTTP/2 (h2 / h2c — external oracle h2spec) | 0.8 | none |
| HTTP/3 (QUIC — external oracle quic-interop-runner) | 0.8 | none |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| Connecting to IPv6 addresses | 0.8 | `std/http/client.TestTarget` |
| Decoding a response Content-Encoding (Accept-Encoding is not sent today) | 0.8 | none |
| HTTP/2 | 0.8 | none |
<!-- confsync:end claims http-client planned -->

<!-- confsync:begin claims http-url planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| IDN (punycode) | 0.8 | none |
<!-- confsync:end claims http-url planned -->

Nothing about cookies is waiting to be implemented.

## Evidence — interop (client — peer = Go net/http)

<!-- confsync:begin interop-http -->
Last run: 2026-11-07 (tree 73597f45c958 (dirty) — scripts/httpinterop.sh; peer = Go net/http)

`plain` · `tls13` · `tls12-opt-in` · `tls12-default-refused` · `content-length` · `chunked` · `head` · `redirect-303` · `redirect-auth-same-origin-only` · `insecure-redirect-refused` · `stream` · `session` · `proxy-connect` · `proxy-auth` · `unknown-ca-refused`
<!-- confsync:end interop-http -->
