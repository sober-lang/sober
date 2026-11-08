# std/http

日本語

`import "std/http"`

HTTP の語彙のうちサーバ（std/http/server）とクライアント（std/http/client）が共に使うもの: ヘッダの 1 本・書けないヘッダの panic ラベル・状態の番号

## StatusCode

```sober
type StatusCode int
```

応答の状態の番号（RFC 9110 15 節）。std/http/server が理由句を知る番号は下の型つきの const（http.OK …）— 状態行の表はこの const の全部を名指す（@exhaustive — [language.md 13 節](../language.md)の補「表の網羅」）。const に無い番号も `http.StatusCode(418)` や整数のリテラル（`status: 418`）で書ける（理由句は空）

## OK

```sober
const OK = 200
```

200 OK

## Created

```sober
const Created = 201
```

201 Created

## NoContent

```sober
const NoContent = 204
```

204 No Content（本文なし・Content-Length を書かない）

## MovedPermanently

```sober
const MovedPermanently = 301
```

301 Moved Permanently

## Found

```sober
const Found = 302
```

302 Found

## NotModified

```sober
const NotModified = 304
```

304 Not Modified（条件付き GET の一致 — 本文なし）

## BadRequest

```sober
const BadRequest = 400
```

400 Bad Request（要求の頭が読めない）

## Unauthorized

```sober
const Unauthorized = 401
```

401 Unauthorized

## Forbidden

```sober
const Forbidden = 403
```

403 Forbidden

## NotFound

```sober
const NotFound = 404
```

404 Not Found（Dispatch の一致なし・Static のファイルなし）

## MethodNotAllowed

```sober
const MethodNotAllowed = 405
```

405 Method Not Allowed（Dispatch — Allow を付ける）

## PreconditionFailed

```sober
const PreconditionFailed = 412
```

412 Precondition Failed（If-Match / If-Unmodified-Since の不一致）

## ContentTooLarge

```sober
const ContentTooLarge = 413
```

413 Content Too Large（本文が上限を超える）

## RequestHeaderFieldsTooLarge

```sober
const RequestHeaderFieldsTooLarge = 431
```

431 Request Header Fields Too Large（要求の頭が上限を超える）

## InternalServerError

```sober
const InternalServerError = 500
```

500 Internal Server Error（handler の失敗）

## NotImplemented

```sober
const NotImplemented = 501
```

501 Not Implemented（知らない Transfer-Encoding）

## ServiceUnavailable

```sober
const ServiceUnavailable = 503
```

503 Service Unavailable

## HTTPVersionNotSupported

```sober
const HTTPVersionNotSupported = 505
```

505 HTTP Version Not Supported

## Field

```sober
type Field struct {
    name string
    value string
}
```

任意ヘッダの 1 本

## BadHeader

```sober
type BadHeader panic {
    name string
}
```

Response の headers の 1 本が書けない（名前が空か tchar でない・値に CR / LF / NUL・std/http/server が書く名前 — 呼び手の契約違反。panic ラベル）
