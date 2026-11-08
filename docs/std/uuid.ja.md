# std/uuid

日本語

`import "std/uuid"`

UUID（RFC 9562）。作り手は版 4（OS の乱数 122 bit）と版 7（UNIX 時刻のミリ秒 48 bit + 乱数 74 bit — 作った順に並ぶ・DB の主キー向き）。UUID は 16 バイトの値（比べるのは Equal・map の鍵には String の文字列を使う）。文字列は 8-4-4-4-12 の 16 進（書きは小文字・読みは大文字も受ける）

```sober
id := uuid.NewV4()
s := uuid.Format(id)          // "919108f7-52d1-4320-9bac-f847db4148a8" の形
back := uuid.Parse(s)?        // uuid.Equal(back, id)
```

## UUID

```sober
type UUID struct {
    hi int
    lo int
}
```

16 バイトを big endian の 64 bit 2 語で（hi = 0〜7 バイト目・lo = 8〜15 バイト目）

## Bad

```sober
type Bad error
```

Parse の入力が 36 文字の 8-4-4-4-12 の 16 進でない

## NewV4

```sober
@effects(io, panic)
func NewV4() UUID
```

版 4 の UUID（乱数 122 bit + 版 4 + 変種 10 — RFC 9562 5.4）。乱数が取れなければ panic(crypto.NoEntropy{errno})

## Equal

```sober
@effects()
func Equal(a UUID, b UUID) bool
```

a と b が同じ UUID か

## NewV7

```sober
@effects(io, panic)
func NewV7() UUID
```

版 7 の UUID（RFC 9562 5.7 — 上位 48 bit = time.Now の UNIX 時刻のミリ秒・版 7・変種 10・残り 74 bit は OS の乱数）。同じミリ秒の中の順は乱数で決まる（単調増加は約束しない）。乱数が取れなければ panic(crypto.NoEntropy{errno})

## Format

```sober
@effects()
func Format(u UUID) string
```

8-4-4-4-12 の 16 進（小文字）

## Parse

```sober
@errors(Bad)
@effects()
func Parse(s string) (UUID, error?)
```

8-4-4-4-12 の 16 進（大文字小文字どちらも）の UUID。版と変種は問わない

失敗のラベル: [`Bad`](#bad)
