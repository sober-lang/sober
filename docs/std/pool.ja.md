# std/pool

日本語

`import "std/pool"`

スロットを使い回す資源のプール Pool[T]（region-domain-pool.md 2・4 節の最小形）。取り出しは Acquire、返却は同じブロックの直後の文で defer する — analyzer が局所照合で強制する:

```sober
mut p := pool.Pool[Buf]{}
h := pool.Acquire(mut p, Buf{})
defer pool.Release(mut p, h)
```

最小形の割り切り:
- ピン済み参照 `*T` は持たない（言語に無い）。中身は Get でコピーを読み、Set で書く
- 単一スレッド（task をまたいで共有しない）。T は loc-free（型引数の制約 — [language.md 25 節](../language.md)）
- Len は未返却の個数

## Handle

```sober
type Handle struct {
    idx int
    gen int
}
```

Pool のスロットを指すハンドル（index + 世代）。スロットの世代は偶数 = 空き・奇数 = 使用中で、Acquire と Release で 1 ずつ進む。返却・再利用された後の Handle は世代が合わず、Get は nil・Set は false・Release は何もしない

## Pool

```sober
type Pool[T] struct {
    slots mut []T
    gens mut []int
    free mut []int
    nfree int
    out int
}
```

スロットを使い回す資源のプール（ゼロ値 `pool.Pool[T]{}` が空の Pool）

## Acquire

```sober
func Acquire[T](p mut Pool[T], v T) Handle
```

v を空きスロット（無ければ末尾に足す）に置き、そのスロットの Handle を返す

## Release

```sober
func Release[T](p mut Pool[T], h Handle)
```

h のスロットを空きに戻す。h が古ければ（返却済み・再利用済み）何もしない

## Get

```sober
func Get[T](p mut Pool[T], h Handle) T?
```

h のスロットの中身。h が古ければ nil（本当に消えたかもしれない場所にだけ現れる不在）

## Set

```sober
func Set[T](p mut Pool[T], h Handle, v T) bool
```

h のスロットを v で置き換える。h が古ければ何もせず false

## Len

```sober
func Len[T](p mut Pool[T]) int
```

未返却（Acquire したが Release していない）の個数

## Scratch

```sober
type Scratch struct {
    words mut []int
    tag int
    blk []int
    home int
}
```

世代印つきの固定容量の作業域（region-domain-pool.md 4d 節 — ワーカー局所の lease のストレージに置ける容器）。項目は 0 以上 2^32 未満の int。Renew で「全部 0 に戻した」のと同じ観測になる — 中身を消さずに世代を 1 つ進めるだけ（O(1)）:

```sober
mut s := pool.Scratch{}
pool.NewScratch(mut s, 1024)
pool.Store(mut s, 3, 7)
pool.Renew(mut s)
pool.Load(mut s, 3)   // 0
```

形（zlib の head の世代と同じ手）: 1 語 = (世代 32 ビット ‖ 値 32 ビット)。tag = 今の世代 \<\< 32 で、読みは語 ^ tag の上位 32 ビットが 0 なら下位 32 ビット・違えば 0（前の世代の書き）。世代は 2^32 回で一周し、一周の Renew だけが本当に全部を消す（償却 0）。容量は NewScratch で 1 回だけ決める（lease のストレージの大きさを宣言から導く — 窓の中で伸ばさない）。添字の範囲外は列の添字と同じ panic

## NewScratch

```sober
func NewScratch(s mut Scratch, n int)
```

容量 0 の s を容量 n・全部 0 にする（容量は 1 回だけ — 容量のある s に呼ぶと panic(ScratchSized{}): lease の窓の中でストレージを作り直すと、新しい列が task の region に取られて長命のストレージから宙吊りになる — region-domain-pool.md 4d 節）。0 の chunk min(n, 256) 個を 1 つ作り、chunk ごとに一括の写しの形で足す（flate の fill と同じ）

## Cap

```sober
func Cap(s mut Scratch) int
```

s の項目の数（NewScratch の n）

## Load

```sober
func Load(s mut Scratch, i int) int
```

s の i 番目の値（今の世代で Store していなければ 0）

## Store

```sober
func Store(s mut Scratch, i int, v int)
```

s の i 番目を v にする。v が 0〜2^32−1 の外なら panic(BadScratch{v})（呼び手の契約違反 — [language.md 27 節](../language.md)）

## Renew

```sober
func Renew(s mut Scratch)
```

s の全部の項目を 0 に戻す（世代を 1 つ進める — 2^32 回目の一周だけ本当に消す）

## LoadRaw

```sober
func LoadRaw(s mut Scratch, i int) int
```

s の i 番目の語をそのまま読む（生のアクセサ — 世代に触れない。毎アクセスの世代の検査〔xor・上位の判定〕を払わない代わりに、鮮度は呼び手が持つ: 読む添字は RenewDense で 0 に戻した範囲か、同じ世代で先に StoreRaw した添字だけ、が契約。世代つきの Load / Store と同じ Scratch で混ぜない — 世代の印が語に残り、素の読みが印ごと返す

## StoreRaw

```sober
func StoreRaw(s mut Scratch, i int, v int)
```

s の i 番目を v にする（生のアクセサ — 世代に触れず、値の範囲の制限も無い。LoadRaw の対）

## RenewDense

```sober
func RenewDense(s mut Scratch, n int)
```

s の先頭 n 項目を本当に 0 に書く（生のアクセサ版の Renew — O(n)。世代は進めない: 生のアクセサは世代を読まないので、この後 LoadRaw する範囲（\< n）を 0 にすれば「全部 0 に戻した」と同じ観測。lease の窓の約束（前の窓の書きは見えない）も同じ理由で保たれる — 窓の頭の LeaseAttach の世代は生のアクセサには効かないが、読む範囲を 0 にするのはこの関数）

## BadScratch

```sober
type BadScratch panic {
    v int
}
```

Store の値が 0〜2^32−1 の外（呼び手の契約違反 — panic ラベル）

## ScratchSized

```sober
type ScratchSized panic
```

NewScratch を容量のある Scratch に呼んだ（容量は 1 回だけ — 呼び手の契約違反）

## LeaseAttach

```sober
func LeaseAttach(s mut Scratch, blk []int, at int, i int)
```

task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: 窓の w の i 番目の Scratch の欄 s を、ストレージ blk の区画 at に付ける（at = −1 = 倒れ: 新しい割り当て）。blk の形は std/task の Local（[指紋, n, 容量 × n, W, 区画 …]・区画 = [印, 鎖, (tag, 語 × 容量) …]）。付けるたびに区画の tag を 1 世代進めて書き戻す（= Renew — 前の窓の書きは見えない）。一周したら区画の語を本当に消す
