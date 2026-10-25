# std/hash

日本語

`import "std/hash"`

ワンショット API のハッシュ（Sha256）。CRC-32 は std/hash/crc32

## Sha256

```sober
@effects()
func Sha256(data []byte) []byte
```

data の SHA-256 の値（32 バイト — FIPS 180-4）。content-addressed の鍵・成果物の照合用:

```sober
sum := hash.Sha256(bytes("abc"))
println(hex.Format(sum))   // ba7816bf…（16 進の綴りは std/hex）
```

本体は std/crypto/sha256（インクリメンタル API New / Write / Sum もそこ）
