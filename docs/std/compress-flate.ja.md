# std/compress/flate

日本語

`import "std/compress/flate"`

DEFLATE（RFC 1951）の符号化（圧縮だけ — 解凍の API は持たない）

## Encode

```sober
func Encode(data []byte, level int) []byte
```

data を DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列）に符号化する。level は 0〜9（zlib と同じ目盛り — 0 = 圧縮しないstored・1 = 速さ優先・9 = 大きさ優先。gzip / zlib の既定は 6）。範囲外は panic(BadLevel{level}):

```sober
z := flate.Encode(bytes(s), 6)
```

同じ入力・同じ level なら常に同じバイト列（決定的 — 大きさの黄金で照合できる）。作業域は呼ぶたびに入力の長さに合わせて取る — 何度も符号化する task は EncodeWith でワーカー局所の作業域を借りる（下の Work）。

形（zlib の deflate.c と同じ設計 — ハッシュだけ Go と同じ 4 バイト）: 4 バイトのハッシュ鎖（窓 32 KiB）で一致を探し、level ごとの設定表（鎖の長さ・lazy の閾値・十分な長さ）で探す深さを決める — 1〜3 は貪欲（一致を見つけたら取る）・4〜9 は lazy（次の位置にもっと長い一致があれば 1 文字送る）。記号を 16383 個まで溜めてブロックに切り、ブロックごとに動的 Huffman・固定 Huffman・stored の最小で書く（動的 Huffman の木は miniz と同じ作り方 — lengths）

対の `Decode` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Work

```sober
type Work struct {
    syms pool.Scratch
    head pool.Scratch
    prev pool.Scratch
    nsym int
    hmask int
    off int
    ml int
    ms int
    avail bool
}
```

符号器の作業域（ハッシュ鎖と記号の溜め — 8 KiB の本文で ≈ 150 KB・最大 ≈ 650 KB）。ワーカー局所の lease に置ける形（スカラーとpool.Scratch の欄だけ — region-domain-pool.md 4d 節）で、Prepare が最大の容量に整える:

```sober
gzw := task.NewLocal((w mut flate.Work) => flate.Prepare(mut w))            // ワーカーごとに 1 つ（≈ 650 KB × ワーカー数）
z := task.Lease(gzw, (w mut flate.Work) => flate.EncodeWith(mut w, b, 6))  // 窓のたびにまっさら — 結果は Encode と同じバイト列
```

整えていない Work{} は EncodeWith が入力の長さに合わせて取る（Encode の形）。容量が足りない Work（Prepare 以外で整えた）は新しい作業域に倒す（結果は同じ）

## Prepare

```sober
func Prepare(w mut Work)
```

w を最大の入力（窓 32 KiB の鎖・2^15 のハッシュの表・ブロック 1 つの記号）の容量に整える（task.NewLocal の整え方）

## EncodeWith

```sober
func EncodeWith(w mut Work, data []byte, level int) []byte
```

Encode と同じ符号化を作業域 w で行う（w の中身は入口で捨てる — 結果は w に依らず Encode(data, level) と同じバイト列）

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## BadLevel

```sober
type BadLevel panic {
    level int
}
```

Encode の level が 0〜9 の外（呼び手の契約違反 — panic ラベル。[language.md 27 節](../language.md)）
