# std/crypto/poly1305

日本語

`import "std/crypto/poly1305"`

Poly1305 の一回の MAC（RFC 8439 2.5 — 鍵 32 バイト = r ‖ s・tag 16 バイト）。累算は 26 bit × 5 limb（poly1305-donna-32 の形）: limb の積は 2^52 級・5 項の和は2^57 未満で int（符号つき 64 bit）に収まる。データに依る分岐・添字は無い — 最後の「h ≥ p なら p を引く」も mask の選択（定数時間）。tag の照合は crypto.Equal で

## Sum

```sober
@secret(key)
@bless
func Sum(key []byte, msg []byte) []byte
```

key（32 バイト — 1 回だけ使う鍵。同じ鍵で 2 つのメッセージに tag を付けると鍵が解けて tag を偽造できる）で msg の tag（16 バイト）。key が 32 バイトより短ければ添字の境界の panic（長い分は読まない — SumAead も同じ）

## SumAead

```sober
@secret(key)
func SumAead(key []byte, ad []byte, msg []byte, off int, n int) []byte
```

AEAD の MAC の入力（ad ‖ 0 埋め ‖ msg[off, off + n) ‖ 0 埋め ‖ len(ad) ‖ n — 長さは各 64 bit の小さい端・RFC 8439 2.8）の tag。入力を繋いだ写しを作らない（record 層向けの API — msg は受けの切片のまま）
