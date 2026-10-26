# Standard library guide

English | [日本語](std.ja.md)

A map of the packages you use with `import "std/<name>"`. The exact signature and description of each function are in the [standard library reference](../std/README.ja.md), generated from the doc comments in the source; each package name in the tables below links to its page. The reference is currently Japanese-first; an English version is planned for 1.0.

## I/O and environment

| Package | Purpose | Main items |
|---|---|---|
| [`std/io`](../std/io.ja.md) | Files, standard I/O, directories | `ReadFile`, `WriteFile`, `ReadStdin`, `WriteStdout`, `WriteStderr`, `ReadDir`, open files `Open` / `Close` (`defer io.Close(f)` right after) / `ReadAll`, reading slots without copying them `for c <- io.Chunks(f)?` (`Lines`, `ChunksAt` from a given offset, the bytes via `Raw`), the buffered `Writer` (`WriteString` / `WriteByte` / `Flush`). Error labels are `NotFound`, `Denied`, `Timeout`, `Expired` (after the deadline of the enclosing `task.Run` has passed), `Closed`, `Other` |
| [`std/os`](../std/os.ja.md) | Processes and the environment | `Args`, `Getenv`, `Run` (child processes), `Mkdir`, `Rename`, `ModTime`, `WriteMode`, `Sleep` |

## Text

| Package | Purpose | Main items |
|---|---|---|
| [`std/utf8`](../std/utf8.ja.md) | Validated UTF-8 views | `Check` (validate the whole input once and get a `View`), `Str` (take a substring from a validated view without copying), `Bytes` |
| [`std/strings`](../std/strings.ja.md) | String operations | `Contains`, `HasPrefix`, `HasSuffix`, `Index`, `IndexByte`, `Count`, `LastIndex`, `Cut`, `CutLast`, `Split`, `Fields`, `TrimPrefix`, `TrimSuffix`, `TrimSpace`, `Replace`, `ToLower`, `ToUpper`, `EqualFold`, `Join`, `Clone`, UTF-8 validation `Valid`, `IndexInvalid` (error label `InvalidUtf8`) (the pieces `Cut` and friends return are not re-validated — a position that matches a separator is always a character boundary; whitespace and case are ASCII only — no Unicode case folding) |
| [`std/builder`](../std/builder.ja.md) | Building sequences | push onto a `Builder[T]` with `Push`, `PushAll`, `PushString`, and take the result with `Build` |
| [`std/convert`](../std/convert.ja.md) | Converting between numbers and strings | `FormatInt`, `ParseInt`, `ParseFloat`, `FormatFloat`, `FormatFixed`, `ParseBool`, `FormatBool` |
| [`std/hex`](../std/hex.ja.md) | Hexadecimal | `Format`, `Parse` |
| [`std/base64`](../std/base64.ja.md) | base64 (RFC 4648) | `Encode` / `Decode` (standard alphabet, padded), `EncodeUrl` / `DecodeUrl` (URL-safe alphabet, unpadded) — decoding is strict (one spelling per byte sequence) |
| [`std/url`](../std/url.ja.md) | Encoding URL components | percent-encoding `Escape` / `Unescape`, `ParseQuery` for every pair of a query string (a repeated key gives separate pairs, `+` reads as a space) |

`string` is immutable text, and `bytes(s)` views it as a byte sequence (`[]byte`). String interpolation is `"x = ${x}"`.

## Data structures

| Package | Purpose | Main items |
|---|---|---|
| [`std/iter`](../std/iter.ja.md) | The lazy sequence `Iter[T]` | `Range`, `Slice`, `Each`, `Count`, `Sum` (consume the result of `for … yield` through a pipe) |
| [`std/sort`](../std/sort.ja.md) | Sorting | `Order` (the indices 0..n−1 in the order of a comparison closure `less(a, b)` — stable. The caller keeps the values and how to compare them) · `OrderUnstable` (same shape; faster, but makes no promise about the order of equal items — still deterministic) |
| [`std/table`](../std/table.ja.md) | Large tables (a sequence of fixed-size chunks — growing never copies) | `Push`, `Get`, `Set`, `Len` on a `Table[T]`, and `Freeze` into an immutable `Frozen[T]` |
| [`std/pool`](../std/pool.ja.md) | A lending pool looked up by handle | `Acquire`, `Release`, `Get`, `Set` |
| [`std/json`](../std/json.ja.md) | Reading and writing JSON | `Parse` gives a document `Doc`, read with `At` (a one-level view `Value`) / `Get` / `Items` / `Need*` / `ParseString`, `ParseInt`, `ParseFloat`, `ParseBool` and write with `Put*`; mapping to and from types is `json.Decode[T]` / `json.Encode[T]` |

Slices (`[]T`) and maps (`map[K]V`) are built into the language (`append`, `len`, `freeze`, `clone` [a shallow copy, returned as mut], and a lookup `m[k]` is `T?`).

## Parallelism

| Package | Purpose | Main items |
|---|---|---|
| [`std/task`](../std/task.ja.md) | Structured concurrency | `Map`, `Run` (opens a scope — the body receives a `Scope` token) + `Spawn` + `Join` / `Gather` / `Try`, channels `NewChannel` / `Send` / `Recv` / `Close`, `Pool` (`NewPool` / `SpawnIn`) |

Only immutable values and channels can be passed to a child task. The output is the same regardless of the number of workers ([language tour, section 7](tour.md#7-parallelism--structured-concurrency-channels)).

## Numbers and randomness

| Package | Purpose | Main items |
|---|---|---|
| [`std/math`](../std/math.ja.md) | Floating-point basics | `Sqrt`, `Abs`, `Bits` / `FromBits` |
| [`std/rand`](../std/rand.ja.md) | Deterministic pseudo-random numbers | `New` (from a seed), `Intn`, `Int62`, `Bool`, `Split` (split per parallel task) |
| [`std/hash`](../std/hash.ja.md) | Hashing | `Sha256` |
| [`std/hash/crc32`](../std/hash-crc32.ja.md) | Checksums | `Sum` (CRC-32 — the same value as gzip, zlib and PNG) |

## Compression

| Package | Purpose | Main items |
|---|---|---|
| [`std/compress/flate`](../std/compress-flate.ja.md) | DEFLATE (RFC 1951) encoder and decoder | `Encode(data, level)` (level 0–9 on the zlib scale — 6 is the usual default; the same input always gives the same bytes), `Decode(data, maxSize:)` (an output limit — always pass one for untrusted input; exceeding it gives `TooLarge`, a broken stream gives `Bad`) |
| [`std/compress/gzip`](../std/compress-gzip.ja.md) | gzip (RFC 1952) encoder and decoder | `Encode(data, level)` (10-byte header + DEFLATE + CRC-32 + length — the body for HTTP `Content-Encoding: gzip`), `Decode(data, maxSize:)` (checks the CRC-32 and length, joins multiple members; wrapper errors are `gzip.Bad`) |

## Networking

| Package | Purpose | Main items |
|---|---|---|
| [`std/net`](../std/net.ja.md) | TCP | `for l <- net.Listen(addr)?`, `for c <- net.Accept(l)?`, `for c <- net.Dial(addr)?` (closed when the body exits), `for chunk <- net.Recv(c)?`, `Send`, and `Serve` (one task per connection) |
| [`std/http`](../std/http.ja.md) | HTTP/1.1 server | `ServeConn` (on a net connection) / `ServeWith` (on receive and send functions — e.g. a TLS connection; the optional `put:` takes responses without sending them, flushed by the receive side, as `tls.Put`), `Request` / `Response`, `Text` / `Json` / `Status`, `Header` / `Query` / `Form` / `Multipart` (file uploads) / `JsonDoc`, a router `Route` + `Mount` / `Merge` / `Dispatch` / `Param`, `Middleware` (`Before` / `After`), gzip and streamed responses |
| [`std/tls`](../std/tls.ja.md) | TLS 1.3 server | `Serve` (hands over only connections whose handshake is done), a `Config` from `Load` / `Parse`, `Recv` / `Send` (same shape as net) / `Put` + `Flush` (put without sending — `Recv` sends what was put before the next receive). Errors are `HandshakeFailed`, `BadRecord`, `Closed` ([`std/tls/record`](../std/tls-record.ja.md) is the record layer inside — not for direct import) |

## Cryptography

| Package | Purpose | Main items |
|---|---|---|
| [`std/crypto`](../std/crypto.ja.md) | Constant-time helpers and OS randomness | `Equal`, `NonZero`, `Select`, `Wipe`, `Rand` |
| [`std/crypto/aesgcm`](../std/crypto-aesgcm.ja.md) / [`std/crypto/chacha20poly1305`](../std/crypto-chacha20poly1305.ja.md) | AEAD | `Seal` / `Open`, `Prepare` (expand the key once) + `SealTo` / `OpenAt` (aesgcm needs AES-NI — `Available`) |
| [`std/crypto/chacha20`](../std/crypto-chacha20.ja.md), [`std/crypto/poly1305`](../std/crypto-poly1305.ja.md) | Stream cipher and MAC | `XorKeyStream`, `Sum` / `SumAead` |
| [`std/crypto/sha256`](../std/crypto-sha256.ja.md), [`std/crypto/hmac`](../std/crypto-hmac.ja.md), [`std/crypto/hkdf`](../std/crypto-hkdf.ja.md) | Hash, MAC, key derivation | `New` / `Write` / `Sum`, `Sum256`, `Extract` / `Expand` |
| [`std/crypto/x25519`](../std/crypto-x25519.ja.md), [`std/crypto/rsa`](../std/crypto-rsa.ja.md) | Key agreement and signatures | `Base` / `Shared`, `ParsePKCS8` / `SignPSS` / `VerifyPSS` |
| [`std/crypto/pem`](../std/crypto-pem.ja.md) | Reading PEM | `Parse` |

## Other

| Package | Purpose |
|---|---|
| [`std/testing`](../std/testing.ja.md) | Test helpers (labels for `assert` failures) |
| [`std/layout`](../std/layout.ja.md) | Helpers for declaring binary layouts (`@layout`) |
| [`std/binary`](../std/binary.ja.md) | Reading bytes a word at a time (`Load64` — 8 bytes, little-endian) |
