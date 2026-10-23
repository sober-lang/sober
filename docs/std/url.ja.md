# std/url

日本語

`import "std/url"`

URL の部品の符号化: percent-encoding（RFC 3986 2.1）の Escape ⇄ Unescape と、クエリ文字列（application/x-www-form-urlencoded — `k=v&…`）の全部の組を読む ParseQuery。std/http の Query / Form は生のまま（デコードしない）の 1 キーの読み — デコードした値・同じキーの全部が要るときはこちら

## Bad

```sober
type Bad error
```

Unescape / ParseQuery の入力が読めない（'%' の後が 16 進の 2 桁でない・復号したバイト列が UTF-8 でない）

## Pair

```sober
type Pair struct {
    key string
    value string
}
```

クエリの 1 組（ParseQuery の結果 — 書かれた順・同じ key も別の組）

## Escape

```sober
func Escape(s string) string
```

s の percent-encoding（RFC 3986 2.3 の unreserved = 英数字と '-' '.' '\_' '~' はそのまま・他のバイトは "%XX" — 16 進は大文字 2.1。空白は "%20"）。パスの 1 区切りにもクエリの値にもそのまま置ける（'/' '?' '&' '=' '+' も符号化する）

```sober
url.Escape("a b&c=d/é")   // "a%20b%26c%3Dd%2F%C3%A9"
```

## Unescape

```sober
@errors(Bad)
func Unescape(s string) (string, error?)
```

s の "%XX"（16 進は大小どちらも）を 1 バイトに戻した文字列（'+' はそのまま — 空白に読むのは ParseQuery だけ）

失敗のラベル: [`Bad`](#bad)

## ParseQuery

```sober
@errors(Bad)
func ParseQuery(s string) ([]Pair, error?)
```

クエリ文字列 s（先頭の '?' は含めない）の全部の組（'&' で切る・空の項目は飛ばす・'=' の無い項目は値 ""・key と value は '+' を空白に読んでからUnescape と同じ復号 — WHATWG URL の application/x-www-form-urlencoded の読み）。';' は区切りにしない

```sober
url.ParseQuery("q=a+b&tag=x&tag=%E3%81%82")   // [{q, "a b"}, {tag, "x"}, {tag, "あ"}]
```

失敗のラベル: [`Bad`](#bad)
