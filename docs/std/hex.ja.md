# std/hex

日本語

`import "std/hex"`

バイト列の小文字の 16 進表記（Format）と、その逆向きの読み（Parse）

## Format

```sober
@effects()
func Format(b []byte) string
```

b の小文字の 16 進表記（1 バイト 2 桁 — Go の hex.EncodeToString・sha256sum の出力と同じ綴り）。逆向きは Parse（[language.md 34 節](../language.md)の Format ⇄ Parse の族）。表引きなので秘密の値（鍵）には使わない（定数時間でない — std/crypto の規律の外）

```sober
hex.Format(hash.Sha256(bytes("abc")))   // "ba7816bf…"
```

## Bad

```sober
type Bad error
```

Parse の入力が 16 進の綴りでない（奇数の長さ・0-9 a-f A-F 以外の文字）

## Parse

```sober
@errors(Bad)
@effects()
func Parse(s string) ([]byte, error?)
```

16 進の綴り s のバイト列（大文字・小文字とも受ける — 暗号のテストベクタの読み）

失敗のラベル: [`Bad`](#bad)
