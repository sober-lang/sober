# std/compress/flate

日本語

`import "std/compress/flate"`

DEFLATE（RFC 1951）の符号化（Encode）と復号（Decode — inflate.sober）

## Encode

```sober
@effects(!io, !block, !nondet)
func Encode(data []byte, level int) []byte
```

data を DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列）に符号化する。level は 0〜9（zlib と同じ目盛り — 0 = 圧縮しないstored・1 = 速さ優先・9 = 大きさ優先。gzip / zlib の既定は 6）。範囲外は panic(BadLevel{level}):

```sober
z := flate.Encode(bytes(s), 6)
```

同じ入力・同じ level なら常に同じバイト列（決定的 — 大きさの黄金で照合できる）。作業域は呼ぶたびに入力の長さに合わせて取る — 何度も符号化する task は EncodeWith でワーカー局所の作業域を借りる（下の Work）。

形（zlib の deflate.c と同じ設計 — ハッシュは Go と同じ 4 バイト・lv6 の lazy の閾値だけ 12）: 4 バイトのハッシュ鎖（窓 32 KiB）で一致を探し、level ごとの設定表（鎖の長さ・lazy の閾値・十分な長さ）で探す深さを決める — 1〜3 は貪欲（一致を見つけたら取る）・4〜9 は lazy（次の位置にもっと長い一致があれば 1 文字送る）。記号を 16383 個まで溜めてブロックに切り、ブロックごとに動的 Huffman・固定 Huffman・stored の最小で書く（動的 Huffman の木は miniz と同じ作り方 — lengths）。対は Decode

## Work

```sober
type Work = deflate.Work
```

符号器の作業域（ハッシュ鎖と記号の溜め — 8 KiB の本文で ≈ 150 KB・最大 ≈ 650 KB）。ワーカー局所の lease に置ける形（スカラーとpool.Scratch の欄だけ — region-domain-pool.md 4d 節）で、Prepare が最大の容量に整える:

```sober
gzw := task.NewLocal((w mut flate.Work) => flate.Prepare(mut w))            // ワーカーごとに 1 つ（≈ 650 KB × ワーカー数）
z := task.Lease(gzw, (w mut flate.Work) => flate.EncodeWith(mut w, b, 6))  // 窓のたびにまっさら — 結果は Encode と同じバイト列
```

整えていない Work{} は EncodeWith が入力の長さに合わせて取る（Encode の形）。容量が足りない Work（Prepare 以外で整えた）は新しい作業域に倒す（結果は同じ）

## Prepare

```sober
@effects(!io, !block, !nondet)
func Prepare(w mut Work)
```

w を最大の入力（窓 32 KiB の鎖・2^15 のハッシュの表・ブロック 1 つの記号）の容量に整える（task.NewLocal の整え方）

## EncodeWith

```sober
@effects(!io, !block, !nondet)
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

## Bad

```sober
type Bad error
```

Decode の入力が DEFLATE の列でない（ブロックの型 3・stored の LEN と NLEN の不一致・Huffman の符号の長さの表が過剰 / 不完全・使えない記号〔長さ 286 / 287・距離 30 / 31〕・出力の頭より前を指す距離・最後のブロックの前で入力が尽きた〔切り詰め〕・最後のブロックの後に余りのバイト）

## TooLarge

```sober
type TooLarge error
```

Decode の出力が maxSize バイトを越える（展開爆弾の封 — 越える書きの手前で止める。それまでの出力は返さない）

## Decode

```sober
@errors(Bad, TooLarge)
@effects(!io, !block, !nondet)
func Decode(data []byte, maxSize int?) ([]byte, error?)
```

DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列。Encode の対）の data を復号したバイト列。data は最後のブロック（BFINAL）でちょうど終わる（最後のバイトの使わないビットは見ない・その後にバイトが余れば Bad）。maxSize を渡すと、出力がそれを越える時点で TooLarge（省略 = 上限なし — 信頼できない入力〔要求の本文・外から来たファイル〕には必ず渡す: DEFLATE は 1 バイトで最大 258 バイトに伸びるので、入力の大きさの上限は出力の上限にならない）:

```sober
b := flate.Decode(z, maxSize: 1 << 20)?
```

作業域は符号の表（数 KB）だけで、ブロックごとに作り直す

失敗のラベル: [`Bad`](#bad)・[`TooLarge`](#toolarge)

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。
