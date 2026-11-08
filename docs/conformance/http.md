# HTTP, cookies, URLs

[日本語](http.ja.md) · [Conformance](README.md)

## Scope

The HTTP/1.1 (RFC 9110–9112) server (`std/http/server`) and client (`std/http/client`), cookies (RFC 6265 / 6265bis), and URL parts (`std/url`). The main suite for the server is the httpcheck gate (`testdata/httpcheck/check.ts` — exchanges modeled on HttpArena's validation, over plain TCP and TLS); evidence citing `testdata/httpcheck/check.ts` names a check in that suite.

## Supported

### Server

<!-- confsync:begin claims http-server yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| HTTP/1.1 and 1.0 requests, keep-alive, pipelining (RFC 9112) | Supported | `testdata/httpcheck/check.ts`: pipelined 16<br>`testdata/httpcheck/check.ts`: HTTP/1.0 keep-alive<br>`std/http/server.TestFrameAgrees` |
| Bodies with Content-Length and chunked (chunk extensions and trailers are discarded) | Supported | `testdata/httpcheck/check.ts`: chunk ext + trailer<br>`testdata/httpcheck/check.ts`: POST chunked |
| Rejects request-smuggling shapes (CL + TE, conflicting CL, obs-fold, bare CR, space before colon) with 400 | Supported | `testdata/httpcheck/check.ts`: CL + TE<br>`testdata/httpcheck/check.ts`: CL twice differ<br>`testdata/httpcheck/check.ts`: obs-fold<br>`testdata/httpcheck/check.ts`: bare CR |
| Limits: 431 (head), 413 (body); Transfer-Encoding other than chunked = 501; non-HTTP/1.x = 505 | Supported | `testdata/httpcheck/check.ts`: head > 8 KiB<br>`testdata/httpcheck/check.ts`: CL > 16 KiB<br>`testdata/httpcheck/check.ts`: TE gzip<br>`testdata/httpcheck/check.ts`: HTTP/2.0<br>`std/http/server.TestFrameLimits` |
| Response gzip (Accept-Encoding negotiation, Vary) and choosing precompressed br / gz files | Supported | `testdata/httpcheck/check.ts`: gzip stream node:http<br>`testdata/httpcheck/check.ts`: static gz roundtrip |
| Streamed responses (known length = Content-Length, unknown = chunked, HTTP/1.0 delimited by close) | Supported | `testdata/httpcheck/check.ts`: stream file<br>`testdata/httpcheck/check.ts`: chunked node:http |
| Conditional GET (RFC 9110 13 — ETag, Last-Modified, 304 / 412) and a private Cache-Control default | Supported | `std/http/server.TestTagIn`<br>`std/http/server.TestParseDate`<br>`testdata/httpcheck/check.ts`: static 304 if-none-match<br>`testdata/httpcheck/check.ts`: default cache-control private |
| multipart/form-data (RFC 7578) | Supported | `std/http/server.TestMultipartRfc`<br>`std/http/server.TestMultipartBrowsers`<br>`testdata/httpcheck/check.ts`: upload formdata |
| Server-Sent Events (text/event-stream, Last-Event-ID) | Supported | `std/http/server.TestFormatEvent`<br>`testdata/httpcheck/check.ts`: sse Last-Event-ID |
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

## Not supported by design

<!-- confsync:begin claims http-server intentional -->
| Item | Status | Evidence |
|---|---|---|
| The 100 response to Expect: 100-continue (not sent; the body is awaited — clients send it after their wait) | Not supported (by design) | — |
| Upgrade (including WebSocket), CONNECT (SSE is today's answer for server push — WebSocket moves to a 0.8+ pin once there is a real demand) | Not supported (by design) | — |
<!-- confsync:end claims http-server intentional -->

<!-- confsync:begin claims http-client intentional -->
| Item | Status | Evidence |
|---|---|---|
| userinfo in URLs (user:pass@) | Not supported (by design) | `std/http/client.TestTarget` |
<!-- confsync:end claims http-client intentional -->

<!-- confsync:begin claims http-url intentional -->
| Item | Status | Evidence |
|---|---|---|
| WHATWG URL Standard parsing (no browser-style lenient parsing — the strict RFC 3986 side) | Not supported (by design) | — |
<!-- confsync:end claims http-url intentional -->

<!-- confsync:begin claims http-cookie intentional -->
| Item | Status | Evidence |
|---|---|---|
| Cookie jar (RFC 6265 5 automatic storage and sending — the caller writes what is sent; the machinery of a general agent crossing arbitrary origins is not in std) | Not supported (by design) | — |
<!-- confsync:end claims http-cookie intentional -->

## Not yet

<!-- confsync:begin claims http-server planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| Range requests (206) | 0.8 | — |
| HTTP/2 (h2 / h2c — external oracle h2spec) | 0.8 | — |
| HTTP/3 (QUIC — external oracle quic-interop-runner) | 0.8 | — |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| Connecting to IPv6 addresses | 0.8 | `std/http/client.TestTarget` |
| Decoding a response Content-Encoding (Accept-Encoding is not sent today) | 0.8 | — |
| HTTP/2 | 0.8 | — |
<!-- confsync:end claims http-client planned -->

<!-- confsync:begin claims http-url planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| IDN (punycode) | 0.8 | — |
<!-- confsync:end claims http-url planned -->

Nothing about cookies is waiting to be implemented.

## Evidence — interop (client — peer = Go net/http)

<!-- confsync:begin interop-http -->
Last run: 2026-11-07 (tree 73597f45c958 (dirty) — scripts/httpinterop.sh; peer = Go net/http)

`plain` · `tls13` · `tls12-opt-in` · `tls12-default-refused` · `content-length` · `chunked` · `head` · `redirect-303` · `redirect-auth-same-origin-only` · `insecure-redirect-refused` · `stream` · `session` · `proxy-connect` · `proxy-auth` · `unknown-ca-refused`
<!-- confsync:end interop-http -->
