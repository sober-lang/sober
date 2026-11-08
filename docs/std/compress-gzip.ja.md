# std/compress/gzip

日本語

`import "std/compress/gzip"`

gzip（RFC 1952）の符号化と復号（中身は std/compress/flate）

## Encode

```sober
@effects(!io, !block, !nondet)
func Encode(data []byte, level int) []byte
```

data を gzip（RFC 1952 — 1 個のメンバ）に符号化する: 10 バイトの頭（ID 1f 8b・CM 8 = deflate・FLG 0・MTIME 0・XFL・OS 255 = 不明）+ compress.flate.Encode(data, level) + CRC-32 + 長さ（mod 2^32）の 8 バイト（どちらも little endian）。level は flate と同じ 0〜9（範囲外は panic(compress.flate.BadLevel)）:

```sober
z := compress.gzip.Encode(bytes(body), 6)   // HTTP の Content-Encoding: gzip の本文
```

名前・時刻・コメントの欄は持たない（MTIME 0 = 無し — 同じ入力なら常に同じバイト列）。XFL は level 9 で 2・level 1 で 4（RFC の「最大圧縮 / 最速」の印）・他 0。OS は Go の compress/gzip の既定と同じ 255（対は Decode）

## EncodeWith

```sober
@effects(!io, !block, !nondet)
func EncodeWith(w mut compress.flate.Work, data []byte, level int) []byte
```

Encode と同じ符号化を flate の作業域 w で行う（compress.flate.EncodeWith と同じ API — ワーカー局所の lease で借りた w を渡す。結果は Encode と同じバイト列）

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## History

```sober
type History = compress.flate.History
```

compress.flate.History と同じ記録（似た本文を続けて符号化する列ごとに 1 つ — 注釈は flate.History）

## EncodeHistory

```sober
@effects(!io, !block, !nondet)
func EncodeHistory(h mut History, data []byte, level int) []byte
```

Encode と同じ符号化を記録 h つきで行う（中身は compress.flate.EncodeHistory — 出力は (data, level, h の値) で決まる・大きさは記録を使ったブロックで h なしの最適の木の 1.03 倍まで）

## EncodeWithHistory

```sober
@effects(!io, !block, !nondet)
func EncodeWithHistory(w mut compress.flate.Work, h mut History, data []byte, level int) []byte
```

EncodeHistory を作業域 w で行う（EncodeWith と同じ作業域 — 結果は w に依らない）

## Bad

```sober
type Bad error
```

Decode の入力の gzip の包みが違う（ID が 1f 8b でない・CM が 8 でない・FLG の予約ビット・頭の欄の途中で尽きた・FHCRC の不一致・末尾の CRC-32 / 長さ〔ISIZE〕が中身と合わない・メンバの後に余りのバイト）。中身の DEFLATE の誤りは compress.flate.Bad

## Decode

```sober
@errors(Bad, compress.flate.Bad, compress.flate.TooLarge)
@effects(!io, !block, !nondet)
func Decode(data []byte, maxSize int?) ([]byte, error?)
```

gzip（RFC 1952）の data を復号したバイト列（Encode の対）。メンバが続いていれば全部を繋ぐ（RFC 1952 2.2 — gzip(1)・Go と同じ）。頭の FNAME・FCOMMENT・FEXTRA は読み飛ばし、FHCRC は照合する。各メンバの CRC-32 と長さ（mod 2^32）を照合する。maxSize は全メンバの出力の合計の上限（compress.flate.Decode と同じ — 越えたら compress.flate.TooLarge・省略 = 上限なし。信頼できない入力には必ず渡す）:

```sober
body := compress.gzip.Decode(r.body, maxSize: 1 << 20)?   // Content-Encoding: gzip の要求の本文
```

失敗のラベル: [`Bad`](#bad)・`compress.flate.Bad`・`compress.flate.TooLarge`
