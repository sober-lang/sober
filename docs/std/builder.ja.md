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

コピーせずに成長する可変長の列（[language.md 21 節](../language.md)の緩和策 2）。固定長チャンクのチェーンに積み、Buildで連続sliceへ1回だけコピーする — 同じregionで他の割り当てと交錯して成長しても、成長のコピーによるゴミが出ない（総コスト O(n)）。

```sober
mut nb := builder.Builder[Node]{}
builder.Push(mut nb, n)
nodes := builder.Build(mut nb)
```

表現:
- chunksはchunkヘッダの列。初回のPushで空ヘッダseedのコピーをseeds本まとめて積み、使い切ったら同じ本数を足す（倍々）
- chunk k の容量は 8 \<\< k を maxChunk で頭打ち（8, 16, …, 512, 1024, 1024, …）。新しい chunk は seed へ容量ぶん連続 append して確保し（seed は Builder の region にあるので、確保先は Push を呼んだ深さに依らない）、以降は添字で書く
- 頭打ちは最後のchunkの空き（倍々のままだと最大で積んだ量と同じだけ）をmaxChunk未満に抑える — 確保は書いて埋めるので、空きもそのままページを触る（json.Encode の作業域: 8.4 KB の本文で 16 KB → 9 KB）

## Push

```sober
@effects()
func Push[T](b mut Builder[T], x T)
```

xを末尾に積む（高速パス = 今のchunkに空きがある — 呼び出し点に展開される大きさに保つ。初期化と新しいchunkはpushSlow）

## PushAll

```sober
@effects()
func PushAll[T](b mut Builder[T], xs []T)
```

xsの要素を順に末尾に積む（Pushを要素ごとに呼ぶのと同じ結果 — chunkの空きへまとめてコピーする: 呼び出しとchunkの出し入れが要素ごとでなくchunkごと。シリアライザ・パーサの積みの絶対値のターゲット）

## PushString

```sober
@effects()
func PushString(b mut Builder[byte], s string)
```

s のバイト列を末尾に積む（PushAll(b, bytes(s))）

## PushWord

```sober
@effects()
func PushWord(b mut Builder[byte], w int, k int)
```

w の下の k バイトを下のバイトから順に末尾に積む（Push(b, byte(w & 255)) と w = w >> 8 を k 回くり返すのと同じ結果）。k ≤ 0 なら何もしない。k > 8 なら 9 バイト目からは算術右シフトの埋め（w が負なら 255・でなければ 0）。今の chunk に k バイトの空きがあれば、chunk の出し入れと空きの検査は1回だけ（10進の桁や短い字面を1ワードに詰めてから積む形 — jsonの数の書き出し）

## Len

```sober
@effects()
func Len[T](b mut Builder[T]) int
```

積んだ要素の個数

## Get

```sober
@effects()
func Get[T](b mut Builder[T], i int) T
```

i 番目（0 起点）に積んだ要素。i が範囲外（i \< 0 か Len 以上）なら添字の境界検査で panic する

## Build

```sober
@effects()
func Build[T](b mut Builder[T]) []T
```

積んだ要素を連続した imm slice にして返す（現在の最内 region へ 1 回コピー）。Builder 自体は変えない（続けて Push できる）

## PushBetween

```sober
@effects()
func PushBetween[T](b mut Builder[T], open T, xs []T, close T)
```

xs を open と close で挟んで末尾に積む（Push(b, open)・PushAll(b, xs)・Push(b, close) と同じ結果 — 今の chunk に len(xs) + 2 の空きがあれば空きの検査と chunk の出し入れは 1 回だけ。JSON の文字列の引用符の対の形）
