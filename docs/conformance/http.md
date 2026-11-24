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
| HTTP/2 (h2c with prior knowledge; RFC 9113, HPACK RFC 7541; chosen with ServeConn's `proto:`; each stream calls route in its own task — external oracle h2spec, 146 cases) | Supported | `testdata/h2spec/pass.txt`: generic/4/1 ok<br>`testdata/h2spec/pass.txt`: generic/4/3 ok<br>`std/http/server.TestH2One`<br>`std/http/server.TestH2SlowFast` |
| HTTP/2 over TLS (ALPN h2: ServeConn takes the TLS connection that tls.Serve hands over. Frame conformance does not depend on the transport and is checked by h2spec over plaintext; the receive and send paths over TLS are checked by h2flood over TLS 1.3 and 1.2 and by interop with nghttp. The TLS client of h2spec offers TLS 1.2 at most, so its 146 cases run over TLS 1.2 against a DangerouslyAllowTls12 server; all are stages of the h2spec gate) | Supported | `std/http/server.TestConnTlsBoth`<br>`std/http/server.TestConnTlsH2`<br>`std/http/server.TestH2TlsHuge` |
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
| Connecting to IPv6 addresses (bracketed URL authority; Host and the CONNECT authority keep the brackets; redirect origins are compared in RFC 5952 form) | Supported | `std/http/client.TestTarget`<br>`std/http/client.TestPlainLoopback6` |
| HTTP/2 (h2 is offered by ALPN to https targets, one stream at a time per connection; h2c is not used for http targets) | Supported | `std/http/server.TestH2TlsClient` |
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

## RFC 9113 and 7541 MUSTs (server, HTTP/2)

The MUSTs and MUST NOTs that RFC 9113 (HTTP/2) and RFC 7541 (HPACK) place on a server and that have evidence, with section numbers. As in the RFC 9110 and 9112 table, nearby requirements from one section share a row, and requirements without evidence are left out. h2spec cases are cited by their line in `testdata/h2spec/pass.txt` (the list of passed cases that the h2spec gate writes and compares). h2spec numbers sections after RFC 7540; the rows use RFC 9113 section numbers.

<!-- confsync:begin claims h2-must yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| RFC 9113 3.2: HTTP/2 over TLS starts by ALPN h2 (a TLS connection is not told from HTTP/1.1 by the preface; with proto: Both, HTTP/2 when ALPN picked h2 and HTTP/1.1 otherwise) | Supported | `std/http/server.TestConnTlsBoth`<br>`std/http/server.TestConnTlsBothH11` |
| RFC 9113 3.3, 3.4: the server connection preface is a SETTINGS frame sent first, and the SETTINGS in the peer's preface is acknowledged | Supported | `testdata/h2spec/pass.txt`: generic/1/1 ok<br>`testdata/h2spec/pass.txt`: http2/3.5/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.3/2 ok |
| RFC 9113 3.4: an invalid connection preface is a connection error of type PROTOCOL_ERROR (proto: H2; proto: Both reads a connection that does not start with the preface as HTTP/1.1) | Supported | `testdata/h2spec/pass.txt`: http2/3.5/2 ok |
| RFC 9113 4.1: frames of unknown types are discarded; unused flags and the reserved bit are ignored on receipt | Supported | `testdata/h2spec/pass.txt`: http2/4.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/4.1/2 ok<br>`testdata/h2spec/pass.txt`: http2/4.1/3 ok |
| RFC 9113 4.2: frames of 2^14 octets are received; a frame over SETTINGS_MAX_FRAME_SIZE is a FRAME_SIZE_ERROR (a connection error for frames carrying a field block) | Supported | `testdata/h2spec/pass.txt`: http2/4.2/1 ok<br>`testdata/h2spec/pass.txt`: http2/4.2/2 ok<br>`testdata/h2spec/pass.txt`: http2/4.2/3 ok |
| RFC 9113 4.3: a field block that does not decompress is a connection error of type COMPRESSION_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/4.3/1 ok<br>`std/internal/hpack.TestBad` |
| RFC 9113 4.3, 6.2, 6.10: a frame of another type or for another stream in the middle of a field block is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/4.3/2 ok<br>`testdata/h2spec/pass.txt`: http2/4.3/3 ok<br>`testdata/h2spec/pass.txt`: http2/6.2/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.2/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.10/2 ok |
| RFC 9113 5.1, 6.4: a frame other than HEADERS or PRIORITY (RST_STREAM included) on an idle stream is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/5.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/2 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/3 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/4 ok<br>`testdata/h2spec/pass.txt`: http2/6.4/2 ok |
| RFC 9113 5.1, 6.1: DATA, HEADERS or CONTINUATION on a half-closed (remote) or closed stream is a STREAM_CLOSED error (including after the server sent RST_STREAM) | Supported | `testdata/h2spec/pass.txt`: http2/5.1/5 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/6 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/7 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/8 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/9 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/10 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/11 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/12 ok<br>`testdata/h2spec/pass.txt`: http2/5.1/13 ok<br>`testdata/h2spec/pass.txt`: http2/6.1/2 ok |
| RFC 9113 5.1: WINDOW_UPDATE, PRIORITY and RST_STREAM on a half-closed (remote) stream, and PRIORITY on a closed stream, are not errors | Supported | `testdata/h2spec/pass.txt`: generic/2/2 ok<br>`testdata/h2spec/pass.txt`: generic/2/3 ok<br>`testdata/h2spec/pass.txt`: generic/2/4 ok<br>`testdata/h2spec/pass.txt`: generic/2/5 ok |
| RFC 9113 5.1.1: an even-numbered stream identifier, or one smaller than a previously opened stream, is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/5.1.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/5.1.1/2 ok |
| RFC 9113 5.1.2: a HEADERS frame that exceeds the advertised concurrent stream limit is a stream error of type PROTOCOL_ERROR or REFUSED_STREAM | Supported | `testdata/h2spec/pass.txt`: http2/5.1.2/1 ok |
| RFC 9113 5.2.1, 6.9.1: the server never sends more than the flow-control windows (stream and connection) advertised by the peer | Supported | `testdata/h2spec/pass.txt`: http2/6.9.1/1 ok<br>`std/http/server.TestH2WindowStall` |
| RFC 9113 5.2.2: frames keep being read while handlers run (a slow handler does not stall other streams on the connection) | Supported | `std/http/server.TestH2SlowFast` |
| RFC 9113 5.4.1: on a connection error the server sends GOAWAY and then closes the TCP connection | Supported | `testdata/h2spec/pass.txt`: http2/5.4.1/1 ok<br>`std/http/server.TestH2RstBudget` |
| RFC 9113 5.4.2: on a stream error the server sends RST_STREAM for that stream and the connection goes on (a stream whose child dies in route, by panic or by exceeding its budget, gets INTERNAL_ERROR) | Supported | `std/http/server.TestH2ChildDeath`<br>`std/http/server.TestH2TlsChildDeath` |
| RFC 9113 5.5: unknown extension frames and unknown settings are ignored; an extension frame in the middle of a field block is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/5.5/1 ok<br>`testdata/h2spec/pass.txt`: http2/5.5/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.2/5 ok |
| RFC 9113 6.1: a DATA frame on stream 0, or with padding as long as the payload or longer, is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.1/3 ok<br>`testdata/h2spec/pass.txt`: generic/3.1/3 ok |
| RFC 9113 6.2: a HEADERS frame on stream 0, or with padding as long as the payload or longer, is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.2/3 ok<br>`testdata/h2spec/pass.txt`: http2/6.2/4 ok<br>`testdata/h2spec/pass.txt`: generic/3.2/2 ok |
| RFC 9113 6.3: PRIORITY on stream 0 is a connection error of type PROTOCOL_ERROR; PRIORITY with a length other than 5 is a stream error of type FRAME_SIZE_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.3/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.3/2 ok |
| RFC 9113 6.4: RST_STREAM on stream 0 is a PROTOCOL_ERROR and RST_STREAM with a length other than 4 is a FRAME_SIZE_ERROR (both connection errors) | Supported | `testdata/h2spec/pass.txt`: http2/6.4/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.4/3 ok |
| RFC 9113 6.5: SETTINGS with ACK and a payload, or with a length that is not a multiple of 6, is a FRAME_SIZE_ERROR; SETTINGS on a non-zero stream is a PROTOCOL_ERROR (both connection errors) | Supported | `testdata/h2spec/pass.txt`: http2/6.5/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.5/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.5/3 ok |
| RFC 9113 6.5.2: SETTINGS_ENABLE_PUSH other than 0 or 1 and SETTINGS_MAX_FRAME_SIZE out of range are PROTOCOL_ERRORs; SETTINGS_INITIAL_WINDOW_SIZE above 2^31-1 is a FLOW_CONTROL_ERROR (all connection errors) | Supported | `testdata/h2spec/pass.txt`: http2/6.5.2/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.2/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.2/3 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.2/4 ok<br>`std/internal/h2frame.TestSettings` |
| RFC 9113 6.5.3: SETTINGS values are applied in the order they appear, and the ACK is sent right after | Supported | `testdata/h2spec/pass.txt`: http2/6.5.3/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.5.3/2 ok |
| RFC 9113 6.7: a PING without ACK gets a PING with ACK and the same payload, and a PING with ACK gets no reply; PING on a non-zero stream is a PROTOCOL_ERROR and PING with a length other than 8 is a FRAME_SIZE_ERROR (both connection errors) | Supported | `testdata/h2spec/pass.txt`: http2/6.7/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.7/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.7/3 ok<br>`testdata/h2spec/pass.txt`: http2/6.7/4 ok |
| RFC 9113 6.8: GOAWAY on a non-zero stream is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.8/1 ok |
| RFC 9113 6.9: WINDOW_UPDATE with an increment of 0 is a stream error of type PROTOCOL_ERROR on a stream and a connection error on the connection; WINDOW_UPDATE with a length other than 4 is a connection error of type FRAME_SIZE_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.9/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.9/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.9/3 ok |
| RFC 9113 6.9.1: a WINDOW_UPDATE that takes a window above 2^31-1 ends the stream (stream window) or the connection (connection window) with FLOW_CONTROL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.9.1/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.9.1/3 ok |
| RFC 9113 6.9.2: when SETTINGS_INITIAL_WINDOW_SIZE changes, open stream windows move by the difference and nothing is sent until a negative window is positive again; a change that takes a window above the maximum is a connection error of type FLOW_CONTROL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/6.9.2/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.9.2/2 ok<br>`testdata/h2spec/pass.txt`: http2/6.9.2/3 ok |
| RFC 9113 6.10: CONTINUATION is accepted only right after HEADERS or CONTINUATION without END_HEADERS, and is otherwise a connection error of type PROTOCOL_ERROR, as is CONTINUATION on stream 0 | Supported | `testdata/h2spec/pass.txt`: http2/6.10/1 ok<br>`testdata/h2spec/pass.txt`: http2/6.10/3 ok<br>`testdata/h2spec/pass.txt`: http2/6.10/4 ok<br>`testdata/h2spec/pass.txt`: http2/6.10/5 ok<br>`testdata/h2spec/pass.txt`: http2/6.10/6 ok<br>`testdata/h2spec/pass.txt`: generic/3.10/2 ok |
| RFC 9113 7: unknown error codes in GOAWAY and RST_STREAM trigger no special behavior | Supported | `testdata/h2spec/pass.txt`: http2/7/1 ok<br>`testdata/h2spec/pass.txt`: http2/7/2 ok |
| RFC 9113 8.1: a HEADERS frame without END_STREAM after the one that opened the request, and pseudo-header fields in trailers, are malformed (trailers themselves are accepted) | Supported | `testdata/h2spec/pass.txt`: http2/8.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.1/3 ok<br>`testdata/h2spec/pass.txt`: generic/4/4 ok |
| RFC 9113 8.1.1: a malformed request is a stream error of type PROTOCOL_ERROR (including content-length differing from the sum of the DATA lengths) | Supported | `testdata/h2spec/pass.txt`: http2/8.1.2.6/1 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.6/2 ok<br>`std/http/server.TestH2Malformed` |
| RFC 9113 8.2, 8.2.1: uppercase in a field name, a line break in a value, and leading or trailing whitespace in a value are malformed | Supported | `testdata/h2spec/pass.txt`: http2/8.1.2/1 ok<br>`std/http/server.TestH2RequestBad` |
| RFC 9113 8.2.2: connection-specific header fields (connection, keep-alive, proxy-connection, transfer-encoding, upgrade) and TE with a value other than trailers are malformed; responses carry no connection-specific header fields | Supported | `testdata/h2spec/pass.txt`: http2/8.1.2.2/1 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.2/2 ok<br>`std/http/server.TestH2RequestBad`<br>`std/http/server.TestH2Head` |
| RFC 9113 8.2.3: multiple cookie fields are joined with "; " into one before the application sees them | Supported | `std/http/server.TestH2RequestCookieBody` |
| RFC 9113 8.3: unknown pseudo-header fields, response pseudo-header fields, pseudo-header fields after a regular field, and a repeated pseudo-header field are malformed | Supported | `testdata/h2spec/pass.txt`: http2/8.1.2.1/1 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.1/2 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.1/4 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/5 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/6 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/7 ok<br>`std/http/server.TestH2RequestBad` |
| RFC 9113 8.3.1: a missing :method, :scheme or :path, or an empty :path, is malformed; when :authority is present it is used instead of Host | Supported | `testdata/h2spec/pass.txt`: http2/8.1.2.3/1 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/2 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/3 ok<br>`testdata/h2spec/pass.txt`: http2/8.1.2.3/4 ok<br>`std/http/server.TestH2RequestCookieBody` |
| RFC 9113 8.3.2: every response carries :status as its first field | Supported | `std/http/server.TestH2Head` |
| RFC 9113 8.4: a PUSH_PROMISE received by the server is a connection error of type PROTOCOL_ERROR | Supported | `testdata/h2spec/pass.txt`: http2/8.2/1 ok |
<!-- confsync:end claims h2-must yes,partial -->

### HPACK (RFC 7541)

<!-- confsync:begin claims hpack-must yes,partial -->
| Item | Status | Evidence |
|---|---|---|
| RFC 7541 2.1: decoded fields keep their order in the block (Appendix C examples) | Supported | `std/internal/hpack.TestC3`<br>`std/internal/hpack.TestC4`<br>`std/internal/hpack.TestC5`<br>`std/internal/hpack.TestC6` |
| RFC 7541 2.3.3, 6.1: an index beyond both tables, and index 0, are decoding errors | Supported | `testdata/h2spec/pass.txt`: hpack/2.3.3/1 ok<br>`testdata/h2spec/pass.txt`: hpack/2.3.3/2 ok<br>`testdata/h2spec/pass.txt`: hpack/6.1/1 ok<br>`std/internal/hpack.TestBad` |
| RFC 7541 4.2: a dynamic table size update that is not at the start of a block is a decoding error | Supported | `testdata/h2spec/pass.txt`: hpack/4.2/1 ok<br>`std/internal/hpack.TestSizeUpdate` |
| RFC 7541 5.1: an integer over the implementation limits is a decoding error | Supported | `std/internal/hpack.TestInt`<br>`std/internal/hpack.TestBad` |
| RFC 7541 5.2: a Huffman string with padding longer than 7 bits, padding that is not the most significant bits of EOS, or the EOS symbol is a decoding error | Supported | `testdata/h2spec/pass.txt`: hpack/5.2/1 ok<br>`testdata/h2spec/pass.txt`: hpack/5.2/2 ok<br>`testdata/h2spec/pass.txt`: hpack/5.2/3 ok |
| RFC 7541 6.3: a dynamic table size update above SETTINGS_HEADER_TABLE_SIZE is a decoding error | Supported | `testdata/h2spec/pass.txt`: hpack/6.3/1 ok<br>`std/internal/hpack.TestSizeUpdate` |
<!-- confsync:end claims hpack-must yes,partial -->

### Not applicable (HTTP/2)

Requirements that do not apply because the feature is absent.

<!-- confsync:begin claims h2-must na -->
| Item | Status | Evidence |
|---|---|---|
| RFC 9113 4.3.1: rules for the table size update after a reduction (the sending HPACK uses no dynamic table, and the receiving table size is never reduced) | Not applicable | none |
| RFC 9113 5.1.1, 5.1.2, 6.6, 8.4: rules for sending server push (the server opens no streams and sends no PUSH_PROMISE) | Not applicable | none |
| RFC 9113 8.5: CONNECT rules (CONNECT is not implemented — a CONNECT request is malformed) | Not applicable | none |
<!-- confsync:end claims h2-must na -->

<!-- confsync:begin claims hpack-must na -->
| Item | Status | Evidence |
|---|---|---|
| RFC 7541 4.2: table size rules for the encoder (the sending HPACK uses no dynamic table) | Not applicable | none |
| RFC 7541 6.2.3, 7.1.3: rules for keeping never-indexed literals when forwarding (the server does not forward received fields) | Not applicable | none |
<!-- confsync:end claims hpack-must na -->

## Not supported by design

<!-- confsync:begin claims http-server intentional -->
| Item | Status | Evidence |
|---|---|---|
| HTTP/2 server push (no PUSH_PROMISE is sent) and Upgrade: h2c (h2c is prior knowledge only) | Not supported (by design) | none |
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
| Zone identifiers in IPv6 URL hosts (RFC 6874; an optional extension most browsers also reject) | Not supported (by design) | `std/http/client.TestTarget` |
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
| HTTP/3 (QUIC — external oracle quic-interop-runner) | 0.8 | none |
<!-- confsync:end claims http-server planned -->

<!-- confsync:begin claims http-client planned -->
| Item | Planned | Evidence of today's behavior |
|---|---|---|
| Decoding a response Content-Encoding (Accept-Encoding is not sent today) | 0.8 | none |
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
