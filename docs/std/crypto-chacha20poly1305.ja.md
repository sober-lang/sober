# std/crypto/chacha20poly1305

日本語

`import "std/crypto/chacha20poly1305"`

AEAD\_CHACHA20\_POLY1305（RFC 8439 2.8 — 鍵 32 バイト・nonce 12 バイト・tag 16 バイト）。Open は tag を crypto.Equal（定数時間）で照合し、食い違えば平文を返さない。同じ鍵で nonce を 2 回使ってはならない（2 つの暗号文の xor から平文の xor が漏れ、Poly1305 の鍵も同じになって tag を偽造できる）

```sober
ct := chacha20poly1305.Seal(key, nonce, ad, pt)?       // 暗号文 ‖ tag
pt := chacha20poly1305.Open(key, nonce, ad, ct)?       // 改竄なら chacha20poly1305.Auth
```

record 層向けの API（aesgcm と同じ形）: Prepare（鍵の長さを見る）・SealTo（head ‖ 暗号文 ‖ tag）・OpenAt（b[off, off + n) を写さずに検証してから復号）。MAC は入力を繋がずに poly1305.SumAead で

## KeySize

```sober
const KeySize = 32
```

長さの定数（バイト）

鍵の長さ

## NonceSize

```sober
const NonceSize = 12
```

長さの定数（バイト）

nonce の長さ

## Overhead

```sober
const Overhead = 16
```

長さの定数（バイト）

Seal の暗号文が平文より長くなる分（tag）

## BadSize

```sober
type BadSize error
```

鍵・nonce の長さが違う・暗号文が tag より短い

## Auth

```sober
type Auth error
```

tag が合わない（暗号文・ad・nonce・鍵のどれかが違う）

## Key

```sober
type Key struct {
    key []byte @secret
}
```

鍵（Prepare の結果 — ChaCha20 は鍵の展開を持たないので鍵そのもの）

## Prepare

```sober
@errors(BadSize)
@secret(key)
@effects(!io, !block, !nondet)
func Prepare(key []byte) (Key, error?)
```

key の Key（鍵の長さはここで見る）

失敗のラベル: [`BadSize`](#badsize)

## Seal

```sober
@errors(BadSize)
@secret(key)
@bless
@effects(!io, !block, !nondet)
func Seal(key []byte, nonce []byte, ad []byte, pt []byte) ([]byte, error?)
```

pt を暗号化して tag を付けたもの（暗号文 ‖ tag）。nonce は同じ鍵で 1 回だけ使う

失敗のラベル: [`BadSize`](#badsize)

## Open

```sober
@errors(BadSize, Auth)
@secret(key)
@effects(!io, !block, !nondet)
func Open(key []byte, nonce []byte, ad []byte, sealed []byte) ([]byte, error?)
```

Seal の逆（tag を照合してから復号する）

失敗のラベル: [`BadSize`](#badsize)・[`Auth`](#auth)

## SealInto

```sober
@bless
@effects(!io, !block, !nondet)
func SealInto(k Key, nonce []byte, ad []byte, pt []byte, head []byte, tail []byte, dst mut []byte, at int) int
```

SealTo の宛先を呼び手の列 dst[at:] にした形（aesgcm.SealInto と同じ口 — 書いたバイト数・入らなければ / nonce の長さが違えば −1）。SealTo の結果を写す（ChaCha は鍵ストリームの列を作るので直書きの得が無い — 作業の列は呼び手の region に積もる）

## SealTo

```sober
@errors(BadSize)
@bless
@effects(!io, !block, !nondet)
func SealTo(k Key, nonce []byte, ad []byte, pt []byte, head []byte, tail []byte) ([]byte, error?)
```

head ‖ 暗号文 ‖ tag（平文 = pt ‖ tail — tail は呼び手が pt に繋いで写さずに渡す後ろの数バイト。無ければ []byte{}・aesgcm.SealTo と同じ口）。nonce は同じ鍵で 1 回だけ使う（Seal と同じ）・nonce の長さが違えば BadSize

失敗のラベル: [`BadSize`](#badsize)

対の `OpenTo` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## OpenAt

```sober
@errors(BadSize, Auth)
@effects(!io, !block, !nondet)
func OpenAt(k Key, nonce []byte, ad []byte, b []byte, off int, n int) ([]byte, error?)
```

b[off, off + n)（暗号文 ‖ tag）を写さずに tag を照合してから復号した平文。nonce の長さが違う・n が tag より短い・[off, off + n) が b の外なら BadSize

失敗のラベル: [`BadSize`](#badsize)・[`Auth`](#auth)

対の `SealAt` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。
