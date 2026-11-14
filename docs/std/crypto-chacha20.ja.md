# std/crypto/chacha20

日本語

`import "std/crypto/chacha20"`

ChaCha20（RFC 8439 2.3〜2.4 — 鍵32バイト・nonce 12バイト・32 bitのブロック番号）。ワードは32 bitをintに置き、和のたびにmask32・回転はshift 2回 + or（積も表も無い — 定数時間）。スカラーの形（≈ 25 命令 / バイト）— AES-NI の無い機械の倒れ先の suite の本体。同じ鍵・nonce の組を 2 回使ってはならない（鍵ストリームが同じになり、2 つの平文の xor が漏れる）。認証も無いので、暗号化と改竄の検出には chacha20poly1305 を使う

## Block

```sober
@secret(key)
@effects(!io, !block, !nondet)
func Block(key []byte, nonce []byte, counter int) []byte
```

鍵 key・nonce・ブロック番号 counter の鍵ストリームの 1 ブロック（64 バイト）。key は 32 バイト・nonce は 12 バイト（短ければ添字の境界の panic・長い分は読まない — 下の 2 つも同じ）

## XorKeyStream

```sober
@secret(key)
@effects(!io, !block, !nondet)
func XorKeyStream(key []byte, nonce []byte, counter int, src []byte) []byte
```

src を鍵ストリーム（ブロック番号 counter から）と xor したもの（暗号化 = 復号）。同じ鍵・nonce の鍵ストリームを 2 つの平文に使ってはならない

## XorKeyStreamAt

```sober
@secret(key)
@effects(!io, !block, !nondet)
func XorKeyStreamAt(key []byte, nonce []byte, counter int, src []byte, off int, n int) []byte
```

src[off, off + n) を鍵ストリームとxorしたもの（コピーせずに読む — record層向けのAPI）。同じ鍵・nonceの鍵ストリームを2つの平文に使ってはならない
