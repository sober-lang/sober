# std/crypto/chacha20

日本語

`import "std/crypto/chacha20"`

ChaCha20（RFC 8439 2.3〜2.4 — 鍵 32 バイト・nonce 12 バイト・32 bit のブロック番号）。語は 32 bit を int に置き、和のたびに mask32・回転は shift 2 回 + or（積も表も無い — 定数時間）。スカラーの形（≈ 25 命令 / バイト）— AES-NI の無い機械の倒れ先の suite の本体。同じ鍵・nonce の組を 2 回使ってはならない（鍵ストリームが同じになり、2 つの平文の xor が漏れる）。認証も無いので、暗号化と改竄の検出には chacha20poly1305 を使う

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
func XorKeyStreamAt(key []byte, nonce []byte, counter int, src []byte, at int, n int) []byte
```

src[at, at + n) を鍵ストリームと xor したもの（写さずに読む — record 層向けの API）。同じ鍵・nonce の鍵ストリームを 2 つの平文に使ってはならない
