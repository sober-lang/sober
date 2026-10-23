# std/crypto/hmac

日本語

`import "std/crypto/hmac"`

HMAC-SHA256（RFC 2104 / FIPS 198-1）。鍵の長さだけが分岐に効く（公開の値）— 中身は SHA-256 の圧縮関数を通るだけで定数時間。tag の照合は crypto.Equal で

```sober
tag := hmac.Sum256(key, msg)
```

## Sum256

```sober
@secret(key)
func Sum256(key []byte, msg []byte) []byte
```

key で msg の HMAC-SHA256（32 バイト）。鍵が 64 バイトを超えれば SHA-256 で縮めてから使う
