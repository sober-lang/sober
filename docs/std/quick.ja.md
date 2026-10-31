# std/quick

日本語

`import "std/quick"`

プロパティベーステスト: 選択の源 Src から値を引き（Int・Bool・Pick・Elem・Bytes・String・Runes・Slice）、Check がプロパティを試行ごとに呼ぶ。値の条件は引き方（変換・Pick / Elem・部品から組む）で満たすのが先で、構成で書きにくい条件だけ Assume で試行を捨てる。プロパティが偽になったら、その試行が使った選択の列をシュリンク（縮小）して最小の反例を探し、引いた値を標準エラーへ印字して panic(Falsified{}) する。

```sober
mut q := quick.New()
quick.Check(mut q, () => {
    xs := quick.Slice(mut q, 8, () => quick.Int(mut q, 0, 9))
    sum(xs) < 30
})
```

シュリンクは値の型を知らない — 引き出しは全部 [0, n) の選択の列の上に建ち、0 が最も単純な値になるように写す。引いた後の変換（`quick.Int(mut q, 0, 9) * 2`）も同じ列から決まるので一緒にシュリンクされる。シードは固定（SOBER\_QUICK\_SEED で変える）なので、同じ木なら同じ試行・同じ反例になる。シュリンクは再実行の回数で切り、時間では切らない。

fuzz（期限まで試行を回し続ける）は、テストの実行ファイルが自分を子として走らせ直す形（引数の `quick:` の指示で役を分ける — fuzz.sober）。駆動役（`quick:fuzz=<ms>`）が試行の束を回す子を起こし続け、子がプロパティの中の panic かハング（試行ごとの期限 `quick:hang=<ms>` — SIGALRM）で死んだら、束を二分探索して最初に死ぬ試行を決め、その試行の選択の列を記録し、列を 1 つずつ再生する子で同じ死に方か確かめながらシュリンクする。プロパティの偽は束の子の中でシュリンクする。試行はシードと番号で決まるので、走らせ直せば同じ所で同じ死に方をする

## Src

```sober
type Src struct {
    r rand.Rand
    seed int
    pre []int
    replay bool
    at int
    log []int
    show bool
    rejected bool
    depth int
    nth int
    logTo string
    tail bool
}
```

選択の源（引き出しの状態 — 利用者は New / Seed で作り、mut で Check と引き出しに渡す）

欄:

- `tail` — 再生の列が尽きたら乱数で続ける（fuzz の誘導のミューテーションの列 — 頭だけ読む）

## Falsified

```sober
type Falsified panic
```

プロパティが偽になった（反例は panic の前に標準エラーへ印字済み）

## BadRange

```sober
type BadRange panic {
    lo int
    hi int
}
```

引き出しの範囲が空（Int の lo > hi・Pick の n \< 1・Elem の空の列・Slice の負の max）

## TooManyDiscards

```sober
type TooManyDiscards panic {
    trials int
    discarded int
}
```

Assume が捨てた試行が多すぎる（成立 trials 件に対して 10 倍を超えた — 引く値の範囲が条件に比べて広すぎる）

## Crashed

```sober
type Crashed panic {
    exit int
}
```

fuzz がプロパティの中の panic（exit = 101）かハング（142 — 試行の期限の SIGALRM）を見つけた（シュリンクした列は panic の前に標準エラーへ印字済み）

## BadArg

```sober
type BadArg panic {
    arg string
}
```

`quick:` の指示の引数の形が違う

## BadEnv

```sober
type BadEnv panic {
    name string
    value string
}
```

SOBER\_QUICK\_SEED / SOBER\_QUICK\_TRIALS の値が整数でない（trials は 1 以上）

## New

```sober
@effects(io, panic)
func New() Src
```

選択の源（シード = SOBER\_QUICK\_SEED — 無ければ 0）

## Named

```sober
@effects(io, panic)
func Named(name string) Src
```

名前 name のハッシュと SOBER\_QUICK\_SEED を混ぜたシードの源（テストごとに別の列にする口）

## Seed

```sober
@effects()
func Seed(seed int) Src
```

シード seed そのままの源（環境変数を読まない）

## Check

```sober
@effects(block, io, panic, nondet)
func Check(q mut Src, prop func() bool, trials int?)
```

prop を trials 回（既定 100・SOBER\_QUICK\_TRIALS で上書き）試す。試行 k の選択はシードと k から決まる。偽になった試行があれば選択の列をシュリンクし、最小の列で引いた値を印字して panic(Falsified{})。Assume で捨てた試行は数えずに次の試行へ進み（シュリンクでも捨てた列は採らない）、捨てた数が trials の 10 倍を超えたら panic(TooManyDiscards{…})。prop の中の panic はシュリンクせずにそのまま死ぬ（試行は決定的なので、走らせ直せば同じ所で死ぬ — シュリンクするのは fuzz の駆動役）。引数に `quick:` の指示があれば fuzz の役で動く（パッケージの先頭の注釈）

## Assume

```sober
@effects(io, nondet)
func Assume(q mut Src, cond bool) bool
```

試行を捨てる条件: cond が偽ならこの試行は不成立（失敗とは数えない）。cond をそのまま返す — 後ろを `&&` で守る: `quick.Assume(mut q, y != 0) && x / y * y + x % y == x`。条件は構成（変換・Pick / Elem・部品から組む）で狭めるのが先で、Assume は構成で書きにくい条件の最後の手（捨てすぎは TooManyDiscards で落ちる）

## Reporting

```sober
@effects()
func Reporting(q Src) bool
```

シュリンクした列を再生して報告している回か（`_test.sober` の Check の写し先 — プロパティの偽をこの回だけ部分式で印字する。利用者は呼ばない）

## Int

```sober
@effects(io, panic, nondet)
func Int(q mut Src, lo int, hi int) int
```

[lo, hi] の整数（両端を含む — 値の数は 2^62 まで）。シュリンクは 0 の側へ — 範囲が 0 を含めば 0、全部正なら lo、全部負なら hi へ

## Bool

```sober
@effects(io, panic, nondet)
func Bool(q mut Src) bool
```

真偽（シュリンクは偽の側へ）

## Pick

```sober
@effects(io, panic, nondet)
func Pick(q mut Src, n int) int
```

[0, n) の添字（シュリンクは 0 へ）— 腕を選ぶ口: `switch quick.Pick(mut q, 3) { case 0: … }`

## Elem

```sober
@effects(io, panic, nondet)
func Elem[T](q mut Src, xs []T) T
```

xs の要素の 1 つ（シュリンクは先頭へ）

## Bytes

```sober
@effects(io, panic, nondet)
func Bytes(q mut Src, max int) []byte
```

長さ max 以下のバイト列（シュリンクは短く・0 のバイトへ）

## String

```sober
@effects(io, panic, nondet)
func String(q mut Src, max int) string
```

長さ max 文字以下の印字可能な ASCII の文字列（シュリンクは短く・'a' へ）

## Runes

```sober
@effects(io, panic, nondet)
func Runes(q mut Src, max int) string
```

長さ max 文字以下の文字列（Unicode のスカラー値全部から — 妥当な UTF-8 だけ。シュリンクは短く・'a' へ）

## Slice

```sober
@effects(io, panic, nondet)
func Slice[T](q mut Src, max int, g func() T) []T
```

長さ max 以下の列（要素は g が引く — g の中で同じ源から引く）。要素ごとに「続けるか」の選択を挟む（シュリンクで塊が消えると要素が消える）
