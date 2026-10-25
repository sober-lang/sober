# std/task

日本語

`import "std/task"`

structured concurrency の表層（[language.md 11 節](../language.md)「表層」）。task.Run が scope を開き、その中で task.Spawn した子の task を Join / Try で待つ。task の結果は写せる imm のデータ（string・slice・map も Join / Try が scope の region へ写す）。error を返す task（g が `(T, error?)` を返す）の Join は 2 値・Try は Outcome の Failed・Join も Try もしなかった失敗は scope の err へ集約

## Scope

```sober
type Scope struct {
    seal sealed
}
```

scope のハンドル（task.Run の本体の仮引数）

## Handle

```sober
type Handle[T] struct {
    seal sealed
}
```

子の task の handle（task.Spawn が返す）

## Cause

```sober
type Cause struct {
    seal sealed
}
```

子の死因（不透明 — 中身は実装が運ぶ実行時の値。コアでは抽象）

## ChildDied

```sober
type ChildDied error {
    cause Cause
}
```

scope の err: 本体は完走したが死んだ子がいた

## Outcome

```sober
type Outcome[T] union {
    Ok { v T }
    Failed { e error }
    Died { cause Cause }
}
```

task.Try の結果（死を値で見る — 監督の API）。Failed は error を返す task の失敗

## KB

```sober
const KB = 1024
```

予算の単位（バイト — `budget: 64 * MB`）

## MB

```sober
const MB = 1048576
```

予算の単位（バイト — `budget: 64 * MB`）

## GB

```sober
const GB = 1073741824
```

予算の単位（バイト — `budget: 64 * MB`）

## MS

```sober
const MS = 1000000
```

期限の単位（1 ミリ秒 — `deadline: 500 * MS`。値はナノ秒の相対時間 — 時刻源は CLOCK\_MONOTONIC）

## NotLowered

```sober
type NotLowered panic
```

呼び出し点の写しが外れた柵（到達しない）

## Run

```sober
@errors(ChildDied)
@effects(block)
func Run[T](f func(Scope) T, budget int?, wait bool?, deadline int?) (T, error?)
```

region を 1 段開き、本体 f をハンドルで走らせる。子が全部決着してから戻り、死んだ子がいれば err = ChildDied、無くて Join も Try もしなかった失敗があれば（生んだ順で最初のもの）err = その子の err。budget = この scope の天井（バイト・省略可 — 省略なら天井のノードを作らず、外の scope の天井だけが掛かる）。wait = true なら天井に入れない直接の子は縮退せずに入れるまで待つ（宣言 = 本当の上限 — [language.md 11 節](../language.md)「wait」。true / false の字面だけ・省略 = 外の scope の方針を継ぐ〔既定 = 縮退〕）。deadline = 開いた時点からの期限（相対・省略可）: 過ぎたら scope の中〔子孫の task も〕の I/O 呼び出しが io.Expired を返す — 走っている仕事は切らない（待ちの上限であって実行時間の上限ではない — [language.md 28 節](../language.md)「デッドライン」。入れ子は早い方）

失敗のラベル: [`ChildDied`](#childdied)

## Spawn

```sober
@effects()
func Spawn[T](s Scope, g func() T, budget int?) Handle[T]
```

子の task を生む（g の捕獲は imm のデータだけ・結果は scope の region へ写る）。budget = この子を逐次で走らせたときの使用量の上界（バイト・省略可。書けば入場の見積もりの代わりに使う — 省略なら spawn の点ごとに観測した使用量の高水位〔観測の無い間は 1 MiB〕が見積もり。呼び出しを含まない整数式）。budget の無い子の region 1 つの上限は 512 MiB（超えると RegionExceeded の死 — 大きい作業域の子は budget を書く・書けばそれ以上の 2 の冪）

## Join

```sober
@effects(block)
func Join[T](h Handle[T]) T
```

子の結果（死んでいたら呼び手も死ぬ — この子の死は私の死）

## Try

```sober
@effects(block)
func Try[T](h Handle[T]) Outcome[T]
```

子の結果を Outcome で（死は値）

## Sender

```sober
type Sender[T] struct {
    seal sealed
}
```

Sender / Receiver はチャネルの端点（送り端・受け端 — 単一の task が持つ。子へは Spawn の give: でだけ渡す — [language.md 11 節](../language.md)）

## Receiver

```sober
type Receiver[T] struct {
    seal sealed
}
```

チャネルの受け端（Sender の対 — NewChannel が組で返す。受けるのは Recv）

## NewChannel

```sober
@effects()
func NewChannel[T](cap int) (Sender[T], Receiver[T])
```

容量 cap（1 以上の整数の字面）の有界のチャネルの端点の組

## Send

```sober
@effects(block)
func Send[T](tx Sender[T], v T)
```

v を送る（満杯なら待つ）

## Recv

```sober
@effects(block)
func Recv[T](rx Receiver[T]) T?
```

次の値（空なら待つ。閉じて空なら nil — 何度受けても nil）

## RecvAll

```sober
@effects(block)
func RecvAll[T](rx Receiver[T], k func(T))
```

`for l <- task.Recv(rx) { … }` の写し先（loader が呼び先を付け替える — 閉じて空になるまで受けて k へ渡す）

対の `SendAll` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## Close

```sober
@effects()
func Close[T](tx Sender[T])
```

送り端を閉じる（以後の Send は panic・二度目の Close も panic。受け手は残りを受け終えると nil を受ける）

## SpawnGive

```sober
@effects()
func SpawnGive[T, E](s Scope, give E, g func(E) T, budget int?) Handle[T]
```

`Spawn(s, give: ep, (ep) => …)` の写し先（loader が呼び先を付け替える — 端点 ep をちょうど 1 つの子へ移す。親に残った別名は失効）

## Gather

```sober
@effects(block)
func Gather[T](hs []Handle[T]) []T
```

handle の列を生んだ順（正準順）で待って結果を集める fan-in（死んだ子があれば呼び手も死ぬ: Join と同じ）。handle の slice は関数の境界を越えないので、呼び出し点で展開される（loader の expands — 本体は普通の Sober）

## Map

```sober
@errors(ChildDied)
@effects(block)
func Map[T, U](xs []T, f func(T) U, budget int?) ([]U, error?)
```

xs の各要素に f を並列に（要素ごとに 1 task）適用し、結果を添字の順に返す（[language.md 11 節](../language.md): `([]U, error?)`。結果の型 U はラムダの結果から推論する。子が死ねば err = ChildDied で結果は空 — 死は Try で値にして集めず、scope の出口がerr に乗せる。死を見たら残りを Try しない — scope の値は ChildDied に決まり、後ろの純な子は切られる: Try すると走らせ直しになる）。f の捕獲は Spawn と同じ規則（実引数のラムダの本体が子の本体へ展開される）。呼び出し点で展開される（関数型の引数）

失敗のラベル: [`ChildDied`](#childdied)

## Pool

```sober
type Pool struct {
    seal sealed
}
```

名前つきプール（テナント・エンドポイント — [language.md 11 節](../language.md)「天井の木」）のハンドル: task.SpawnIn の第 2 実引数。1 語は rt の台帳のノード（imm のデータ — 子へ捕獲できる）。shed の単位 = プールのノード（枯れたノードの配下の SpawnIn だけが失敗する）

## Shed

```sober
type Shed error
```

task.SpawnIn の失敗: プール（か祖先のプール）の天井に入れなかった — 受けられない、という値（io の入力 — 兄弟の予算の返却時刻に依る）

## PoolLimit

```sober
type PoolLimit panic
```

プールのノードの表が尽きた（NewPool を POOL\_MAX 回より多く呼んだ）

## MarkFailed

```sober
@effects()
func MarkFailed(p Pool)
```

プール p の失敗を 1 つ記帳する（Ledger の fail — 境界の API が「受けた仕事が error で終わった」を数える: net.Serve の handler の失敗）

## NewPool

```sober
@effects(panic)
func NewPool(budget int, parent Pool?) Pool
```

天井 budget バイトのプール（parent があればその下のノード — 入場は自分のノードから根のノードまで全部の天井を見る）

## PoolView

```sober
type PoolView struct {
    id int
    parent int
    cap int
    used int
    tasks int
    admit int
    shed int
    fail int
    died int
}
```

台帳のプールのノードの 1 行（id = 作った順の番号・parent = 親の id〔-1 = 無し〕・used / tasks = 計上中のバイト / task の数）

欄:

- `fail` — MarkFailed で記帳した失敗の数（net.Serve — handler が error を返した接続）
- `died` — このプールで入場した task の死の数（net.Serve — handler が死んだ接続）

## LedgerView

```sober
type LedgerView struct {
    workers int
    cap int
    used int
    tasks int
    inline int
    over int
    declOver int
    shed int
    waits int
    maxWait int
    aged int
    pools []PoolView
}
```

台帳の read-only のビュー（[language.md 11 節](../language.md)「メトリクス」）: 根 = プロセスの天井と計上中の量・縮退 / 天井を超えた入場 /宣言超過 / shed の数・ワーカー数、と名前つきプールのノード（作った順）

欄:

- `waits` — wait の scope で入場を待った回数（[language.md 11 節](../language.md)「wait」）
- `maxWait` — 走れるようになってから走るまでの待ちの最大（ns・全ワーカー — 読むと 0 に戻る。[language.md 28 節](../language.md) ring の道「飽和下の待ちの上限」）
- `aged` — 待ちの上限が効いて積みの底から取った回数の累計（飽和の印）

## Ledger

```sober
@effects(nondet)
func Ledger() LedgerView
```

台帳の今の値（io の効果 — 読んだ値は時刻に依る: 時計と同じ扱い）

## SpawnIn

```sober
@errors(Shed)
@effects()
func SpawnIn[T](s Scope, pool Pool, g func() T, budget int?) (Handle[T]?, error?)
```

プール pool の天井に入れれば子の task を生む（handle, nil）・入れなければ (nil, Shed{})（縮退しない — shed を望む境界の API ・[language.md 11 節](../language.md)「shed」）。入場はプールのノードから親のノードまで全部と根（根の天井を超えるときは give: と同じく超過で入場）。子と子の中の Spawn はプールの天井の下に計上される。g・budget は Spawn と同じ

失敗のラベル: [`Shed`](#shed)

## Local

```sober
type Local struct {
    blk []int
}
```

ワーカーローカルストレージのハンドル（region-domain-pool.md 4d 節 — task.NewLocal が作る）: ワーカーごとに T を 1 つ持ち、task.Lease の窓に貸す。中身は NewLocal を呼んだ region に住む imm の列（region の規則がそのまま効く — 外へ出すと列ごと写る〔別のストレージ — 観測は同じ・遅いだけ〕）。子 task へは imm のデータとして捕獲で渡る。ゼロ値は何も指さない偽物（同一性の族 — NewLocal だけが作る）。型引数を持たない: ストレージの T は mut の列（pool.Scratch）を持つ struct で、型引数に置けない（[language.md 25 節](../language.md) — 型引数は写せる型）。T の同一性は loader が型の名前から焼いた指紋で Lease ごとに照合する（違えば panic(LocalType{}) — 呼び手の契約違反）

## LocalType

```sober
type LocalType panic
```

NewLocal と違う T の窓で Lease した（ストレージの T の指紋が合わない）

## NewLocal

```sober
@effects(panic)
func NewLocal(prep func()) Local
```

T のストレージをワーカーの数だけ作る: `gzw := task.NewLocal((w mut flate.Work) => { pool.NewScratch(mut w.head, 1 << 15) … })`。窓のラムダは T の Scratch の欄を定数の容量で整える文だけ（loader の検査）。T はスカラーと pool.Scratch の欄だけの struct。呼び出し点は loader が写す（lease.sober — 本体は写しが外れたときの柵）

## Lease

```sober
@effects(panic)
func Lease[U](lp Local, body func() U) U
```

lp の今のワーカーのストレージを窓 body に貸す: `z := task.Lease(gzw, (w mut flate.Work) => flate.EncodeWith(mut w, b, 6))`。意味は「窓のたびに新しい値」— `{ mut w := T{}; 整え(mut w); body(mut w) }` と観測上同じ（スカラーは 0・Scratch は全部 0・容量は NewLocal の整えのまま）。ストレージが使用中（窓の中で譲った task が持っている）なら新しい割り当てに倒れる（遅いだけ）。呼び出し点は loader が写す

## LocalNew

```sober
@effects()
func LocalNew(fp int, caps []int) Local
```

task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: T の指紋 fp と Scratch の欄の容量の列 caps からストレージを作る（ワーカーの数だけの区画を今の region に先取り — 全部 0）

## LeaseTake

```sober
@effects(panic)
func LeaseTake(lp Local, fp int) int
```

task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: T の指紋 fp を照合し、今のワーカーの区画の位置を返す（使用中なら −1 = 倒れ）

## LeaseGive

```sober
@effects()
func LeaseGive(lp Local, at int)
```

task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: LeaseTake で取った区画 at を返す（−1 なら何もしない）

## LeaseBlock

```sober
@effects()
func LeaseBlock(lp Local) []int
```

task.NewLocal / task.Lease の写し先（loader が組む — 利用者の直の呼び出しは loader が拒否）: ストレージの列（pool.LeaseAttach へ渡す）
