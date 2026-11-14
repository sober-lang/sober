# std/table

日本語

`import "std/table"`

添字で読み書きできる可変長の列 Table[T]（大きな表を O(1) で読み書きする — 小さな列を積んで Build するなら std/builder）

## Table

```sober
type Table[T] struct {
    chunks mut []mut []T
    seed mut []T
    n int
}
```

添字で読み書きできる可変長の列（[language.md 21 節](../language.md)の緩和策 2 の添字版）。固定長のchunkのチェーンに積み、Get / SetはO(1)（chunk = 添字 / CHUNK、chunkの中 = 添字 & (CHUNK - 1)）。同じ region で他の割り当てと交錯して成長しても、成長のコピーによるゴミが出ない（chunk は一度確保したら動かない）。std/builder の Builder（倍々の chunk・Get は O(log n)・Set なし）は小さな列を積んで Build する用途、Table は大きな表を添字で読み書きする用途（コンパイラの脱糖器 / lower の記録）。

```sober
mut t := table.Table[int]{}
table.Push(mut t, 7)
table.Set(mut t, 0, table.Get(mut t, 0) + 1)
```

表現:
- chunksはchunkヘッダの列。初回のPushで空ヘッダseedのコピーをDIR0本積み、足りなくなったら本数を倍にする（伸ばすときは列のコピー〔ヘッダだけ — chunk の中身は動かない〕が出うる。倍々なので償却 O(1)）
- chunkはCHUNK要素ずつ、seedのコピーへ連続appendして確保する（seedはTableのregionにあるので、確保先はPushを呼んだ深さに依らない）。以降は添字で書く
- 容量の上限は無い（chunk ヘッダの列が倍々で伸びる）

## CHUNK_BITS

```sober
const CHUNK_BITS = 13
```

表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0

## CHUNK

```sober
const CHUNK = 8192
```

表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0

## DIR0

```sober
const DIR0 = 16
```

表現の定数: chunk 1 本の要素数 CHUNK（= 1 \<\< CHUNK\_BITS）と、初回の Push で積む chunk ヘッダの本数 DIR0

## Push

```sober
@effects()
func Push[T](t mut Table[T], x T)
```

x を末尾に積む

## PushAll

```sober
@effects()
func PushAll[T](t mut Table[T], xs []T)
```

xs を順に末尾に積む（Push を要素ごとに呼ぶのと同じ結果 — chunk ごとにまとめて書く）

## Len

```sober
@effects()
func Len[T](t mut Table[T]) int
```

積んだ要素の個数

## Get

```sober
@effects()
func Get[T](t mut Table[T], i int) T
```

i 番目（0 起点）の要素。i が範囲外（i \< 0 か Len 以上）なら添字の境界検査で panic する

## Set

```sober
@effects()
func Set[T](t mut Table[T], i int, x T)
```

i 番目（0 起点）の要素を x にする。i が範囲外なら Get と同じく panic する（形は Get と同じ）

## Frozen

```sober
type Frozen[T] struct {
    chunks [][]T
    n int
}
```

Freeze が返す凍った表（imm — 書く関数が無い。par の子へそのまま渡せる）

## Freeze

```sober
@effects()
func Freeze[T](t mut Table[T]) Frozen[T]
```

tの中身をコピーせずに凍らせて返し、tを空の表に戻す（取り出し形 — [language.md 17 節](../language.md)のbottom-up凍結のTable版:中身のあるchunkを1本ずつ取り出して表のフィールドを空のseedに差し替えてからfreezeする。凍らせたchunkに届くのは返すFrozenだけ。t は以後も普通の空の表として使える — 新しく積む分は新しい chunk に入り、凍らせた中身には届かない）

## FrozenLen

```sober
@effects()
func FrozenLen[T](f Frozen[T]) int
```

凍った表の要素の個数

## At

```sober
@effects()
func At[T](f Frozen[T], i int) T
```

凍った表の i 番目（0 起点）の要素。範囲外なら Get と同じく panic する（形も Get と同じ）

## Read

```sober
@effects()
func Read[T](t mut Table[T], i int, n int, dst mut []T)
```

tの [i, i + n) をdstの [0, n) へコピーする（Getをn回呼んでdstに書くのと同じ値 — chunkごとにまとめてコピーする）。範囲外（i \< 0・n \< 0・i + n が Len を越える・n が len(dst) を越える）なら Get と同じく境界検査で panic する。記録 1 つ（数語〜数十語）を局所の列へ一括で読み、局所で添字で読む形のためのインターフェース（Getをワードごとに呼ぶと、ワードごとに範囲の判定とchunkの二重の境界検査を払う）
