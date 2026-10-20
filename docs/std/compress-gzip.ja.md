# std/compress/gzip

日本語

`import "std/compress/gzip"`

gzip（RFC 1952）の符号化（圧縮だけ — 中身は std/compress/flate）

## Encode

```sober
func Encode(data []byte, level int) []byte
```

data を gzip（RFC 1952 — 1 個のメンバ）に符号化する: 10 バイトの頭（ID 1f 8b・CM 8 = deflate・FLG 0・MTIME 0・XFL・OS 255 = 不明）+ flate.Encode(data, level) + CRC-32 + 長さ（mod 2^32）の 8 バイト（どちらも little endian）。level は flate と同じ 0〜9（範囲外は panic(flate.BadLevel)）:

```sober
z := gzip.Encode(bytes(body), 6)   // HTTP の Content-Encoding: gzip の本文
```

名前・時刻・コメントの欄は持たない（MTIME 0 = 無し — 同じ入力なら常に同じバイト列）。XFL は level 9 で 2・level 1 で 4（RFC の「最大圧縮 / 最速」の印）・他 0。OS は Go の compress/gzip の既定と同じ 255

対の `Decode` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## EncodeWith

```sober
func EncodeWith(w mut flate.Work, data []byte, level int) []byte
```

Encode と同じ符号化を flate の作業域 w で行う（flate.EncodeWith と同じ API — ワーカー局所の lease で借りた w を渡す。結果は Encode と同じバイト列）

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。
