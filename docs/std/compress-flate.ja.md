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
z := compress.flate.Encode(bytes(s), 6)
```

同じ入力・同じlevelなら常に同じバイト列（決定的 — 大きさのゴールデンで照合できる）。作業域は呼ぶたびに入力の長さに合わせて取る — 何度も符号化する task は EncodeWith でワーカー局所の作業域を借りる（下の Work）。

形（zlibのdeflate.cと同じ設計 — ハッシュはGoと同じ4バイト・lv6の設定表と4〜6の挿入の省略だけ違う — 下）: 4バイトのハッシュチェーン（ウィンドウ32 KiB）で一致を探し、levelごとの設定表（チェーンの長さ・lazyの閾値・十分な長さ）で探す深さを決める — 1〜3 は貪欲（一致を見つけたら取る）・4〜9 は lazy（次の位置にもっと長い一致があれば 1 文字送る）。記号を 16383 個までバッファリングしてブロックに切り、ブロックごとに動的Huffman・固定Huffman・storedの最小で書く（動的Huffmanの木はminizと同じ作り方 — lengths）。対はDecode

4〜6は長い一致（長さ > 8・lv6は > 6・距離 ≥ 長さ）の中の位置をチェーンに足さない（末尾の2位置だけ）。lv6（既定）の設定表はzlibの値でなく速さと率の交換で調律した値（浅いチェーン・短いlazy）— zlib比 +数 %以内の率で大幅に速い（jsonの本文で +2〜3%・短い一致が主の入力で +10%前後）。率を優先するなら 7 以上（zlib と同じ探し方）

## Work

```sober
type Work = internal.deflate.Work
```

符号器の作業域（ハッシュチェーンと記号のバッファ — 8 KiBの本文で ≈ 70 KB・最大 ≈ 200 KB）。ワーカー局所のleaseに置ける形（スカラーとpool.Scratchのフィールドだけ — region-domain-pool.md 4d節）で、NewWorkが最大の容量に整える:

```sober
gzw := task.NewLocal((w mut compress.flate.Work) => compress.flate.NewWork(mut w))            // ワーカーごとに 1 つ（≈ 200 KB × ワーカー数）
z := task.Lease(gzw, (w mut compress.flate.Work) => compress.flate.EncodeWith(mut w, b, 6))  // ウィンドウのたびにまっさら — 結果はEncodeと同じバイト列
```

整えていない Work{} は EncodeWith が入力の長さに合わせて取る（Encode の形）。容量が足りない Work（NewWork 以外で整えた）は新しい作業域に倒す（結果は同じ）

## NewWork

```sober
@effects(!io, !block, !nondet)
func NewWork(w mut Work)
```

wを最大の入力（ウィンドウ32 KiBのチェーン・2^15のハッシュの表・ブロック1つの記号）の容量に整える（task.NewLocalの整え方）

## EncodeWith

```sober
@effects(!io, !block, !nondet)
func EncodeWith(w mut Work, data []byte, level int) []byte
```

Encode と同じ符号化を作業域 w で行う（w の中身は入口で捨てる — 結果は w に依らず Encode(data, level) と同じバイト列）

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## History

```sober
type History = internal.deflate.History
```

直近の符号化で作った動的 Huffman の木の記録（最大 4 本・1 本 ≈ 300 バイト — 最初の記録で確保・ゼロ値 = 空）。EncodeHistory / EncodeWithHistory にmut で渡すと、ブロックの頻度に記録の木で足りる（費用が下限の見積もりの 1.03 倍以内の）ものがあれば木を作らずに使い、なければ作って記録する:

```sober
mut h := compress.flate.History{}          // 接続ごとなど、似た本文を続けて符号化する列ごとに 1 つ
z := compress.flate.EncodeHistory(mut h, b, 6)
```

出力は (data, level, h の値) で決まる — 同じ列を同じ順に符号化した h なら同じバイト列（h を共有する列の順に依る）。大きさは記録を使ったブロックで h なしの最適の木の 1.03 倍まで（ε = 0.03 — 似た本文の列では実測 +0.3〜0.8%）

## EncodeHistory

```sober
@effects(!io, !block, !nondet)
func EncodeHistory(h mut History, data []byte, level int) []byte
```

Encode と同じ符号化を記録 h つきで行う（History の注釈）

## EncodeWithHistory

```sober
@effects(!io, !block, !nondet)
func EncodeWithHistory(w mut Work, h mut History, data []byte, level int) []byte
```

EncodeHistory を作業域 w で行う（EncodeWith と同じ作業域 — 結果は w に依らない）

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

DEFLATE（RFC 1951 — 頭も検査和もない生の圧縮列。Encode の対）の data を復号したバイト列。data は最後のブロック（BFINAL）でちょうど終わる（最後のバイトの使わないビットは見ない・その後にバイトが余れば Bad）。maxSize を渡すと、出力がそれを越える時点で TooLarge（省略 = 上限なし — 信頼できない入力〔リクエストの本文・外から来たファイル〕には必ず渡す: DEFLATEは1バイトで最大258バイトに伸びるので、入力の大きさの上限は出力の上限にならない）:

```sober
b := compress.flate.Decode(z, maxSize: 1 << 20)?
```

作業域は符号の表（数 KB）だけで、ブロックごとに作り直す

失敗のラベル: [`Bad`](#bad)・[`TooLarge`](#toolarge)

対の `DecodeWith` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。
