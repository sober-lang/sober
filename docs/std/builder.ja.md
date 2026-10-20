# std/builder

日本語

`import "std/builder"`

コピーせずに成長する可変長の列 Builder[T]（積んでから Build で 1 本の slice にする — 添字で読み書きする大きな表なら std/table）

## Builder

```sober
type Builder[T] struct {
    chunks mut []mut []T
    seed mut []T
    cur int
    fill int
    cap int
    n int
}
```

コピーせずに成長する可変長の列（[language.md 21 節](../language.md)の緩和策 2）。固定長チャンクの鎖に積み、Build で連続 slice へ 1 回だけコピーする — 同じ region で他の割り当てと交錯して成長しても、成長のコピーによるゴミが出ない（総コスト O(n)）。

```sober
mut nb := builder.Builder[Node]{}
builder.Push(mut nb, n)
nodes := builder.Build(mut nb)
```

表現:
- chunks は chunk ヘッダの列。初回の Push で空ヘッダ seed の写しを seeds 本まとめて積む（連続した append なので先端一致 = コピーなし）
- chunk k の容量は 8 \<\< k。新しい chunk は seed へ容量ぶん連続 append して確保し（seed は Builder の region にあるので、確保先は Push を呼んだ深さに依らない）、以降は添字で書く
- seed を使い切ると（8 × (2^seeds − 1) 要素を超えると）範囲外で panic する

## Push

```sober
func Push[T](b mut Builder[T], x T)
```

x を末尾に積む

## PushAll

```sober
func PushAll[T](b mut Builder[T], xs []T)
```

xs の要素を順に末尾に積む（Push を要素ごとに呼ぶのと同じ結果 — chunk の空きへまとめて写す: 呼び出しと chunk の出し入れが要素ごとでなく chunk ごと。シリアライザ・パーサの積みの絶対値の的）

## PushString

```sober
func PushString(b mut Builder[byte], s string)
```

s のバイト列を末尾に積む（PushAll(b, bytes(s))）

## Len

```sober
func Len[T](b mut Builder[T]) int
```

積んだ要素の個数

## Get

```sober
func Get[T](b mut Builder[T], i int) T
```

i 番目（0 起点）に積んだ要素。i が範囲外（i \< 0 か Len 以上）なら添字の境界検査で panic する

## Build

```sober
func Build[T](b mut Builder[T]) []T
```

積んだ要素を連続した imm slice にして返す（現在の最内 region へ 1 回コピー）。Builder 自体は変えない（続けて Push できる）
