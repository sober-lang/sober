# std/net

日本語

`import "std/net"`

TCP のリスナーと接続（[language.md 28 節](../language.md)の net）: 寿命は for の本体で言う（閉じる関数は無い）。`for l <- net.Listen(addr)? { … }`・`for c <- net.Dial(addr)? { … }`・`for c <- net.Accept(l)? { … }`（失敗しうる生成元 — [language.md 7 節](../language.md)）は本体を抜けたら std が閉じる（Listen / Dial は 1 回だけ渡す・Accept は受けるたびに渡す — break で止める）。本体の `?` は囲む関数の失敗（文形 for の規則 — 利用者のラムダは error? を返せないので k の形にはしない）。受信は `for chunk <- net.Recv(c)? { … }`（FIN = 列の終わり）・送信は `net.Send(c, b)?`（同期の写し）。socket の操作は std 専用の生の syscall（sysCall / sysAddr — [language.md 28 節](../language.md)の囲い）で書く。期限（task.Run の deadline:）は待ちも切る（待ちの途中で期限が来たら io.Expired）

## Listener

```sober
type Listener struct {
    fd int
    seal netSeal
}
```

listen している socket（同一性の型 — 写せない・外へ出せない・give: で渡せない。fd の番号は封）

## Conn

```sober
type Conn struct {
    fd int
    seal netSeal
}
```

接続（同一性の型 — Listener と同じ規則。Accept / Dial の k の仮引数としてだけ生まれる）

## Bad

```sober
type Bad error
```

addr の形の誤り（"a.b.c.d:port" — IPv4 の 4 つ組と 0〜65535 の port）

## Listen

```sober
@errors(Bad, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Listen(addr string, k func(Listener)) error?
```

addr で listen した Listener を 1 回だけ k に渡し（SO\_REUSEADDR・SO\_REUSEPORT・TCP\_NODELAY・backlog 65535 — somaxconn へ詰める・Go と同じ）、k が返ったら閉じる。SO\_REUSEPORT は Serve のワーカーごとの listener（同じ番地に足す）のため: 同じ uid の別のプロセスも同じ port に bind でき、接続をカーネルの振り分けで分け合う（同じ番地の 2 つ目の起動は EADDRINUSE で落ちずに黙って一部を受ける・別の uid は bind できない — 安全性ガイド〔docs/guide/security.ja.md〕の「Sober が守らないもの」）

失敗のラベル: [`Bad`](#bad)・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Port

```sober
@effects(io)
func Port(l Listener) int
```

l が bind している port（"…:0" で listen したときの割り当ての読み — getsockname）

## Accept

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Accept(l Listener, k func(Conn)) error?
```

l の接続を受けるたびに k に渡し、k が返ったら閉じる（列は終わらない — 本体の break か失敗で止まる。接続ごとの task・admission は Serve〔4a-3〕）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Dial

```sober
@errors(Bad, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Dial(addr string, k func(Conn)) error?
```

addr へ接続した Conn を 1 回だけ k に渡し、k が返ったら閉じる

失敗のラベル: [`Bad`](#bad)・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Recv

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Recv(c Conn, k func([]byte)) error?
```

c の受信を切片ずつ k へ渡す（失敗しうる生成元 — `for chunk <- net.Recv(c)? { … }`）。相手が閉じたら（FIN）列が終わる。切片はこの反復の region の []byte（1 回の read の分・最大 64 KiB）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Send

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Send(c Conn, b []byte) error?
```

b を全部 c へ送る（同期 — 短い書きは続きから・MSG\_NOSIGNAL で相手が閉じた後の書きは io.Closed）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Serve

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, panic, nondet)
func Serve(l Listener, h func(Conn) error?, budget int?, conns int?, reject string?, region int?, maxWait int?, backlog int?) error?
```

l の接続を受けるたびに接続 1 本 = task 1 本で h を走らせる（accept の輪は std が持つ — ワーカーごとに 1 本・l と同じ番地に SO\_REUSEPORT で足した listener で受ける）。h は `func(c net.Conn) error?`（名前つき関数をそのまま — `net.Serve(l, echo, …)`。η 展開 — [language.md 25 節](../language.md)）。h の失敗は Serve が吸収する（接続を閉じて続ける — 数えるのは Serve のプールの Ledger の fail・死は died）。admission は名前つきプールのノード 1 つ（天井 = conns × budget バイト — 省略時は budget = 64 \* task.KB・conns = 10000）+ 接続ごとの SpawnIn（budget = 接続 1 本の上界）: 入れなければ reject の定数のバイト列を 1 回送って閉じる（既定は送らずに閉じる・利用者のコードは走らせない）。h の死は Serve の scope が吸収して Serve は続く。受けた Conn はServe が閉じる（接続の task の登録簿 — 死んでも出口で閉じる）。Serve が返るのは listener の失敗か、Serve を包む scope の期限（accept の待ちが切れる）— 走っている接続の決着を待ってから。listener の失敗は 1 つでも全部の輪を止める（残りの listener を shutdown — 受けていない listener に接続が振られて残らないように）: 以後 l は listen していない。Serve が足した listener は Serve が閉じる・l は Listen が閉じる。region = 接続の task の region 1 つの上限（既定 128 \* task.MB・2 の冪に切り上げ・1 MiB 未満は 1 MiB・子の task の既定〔512 MiB〕より大きくはならない）: 超えるとその接続の task の死（RegionExceeded{cause: slot\_capacity} — Serve が吸収し Ledger の died が数える）。小さいスロットは既定のスロットを割って深度ごとに 1 本（接続数 × 深度ぶんの VA を減らす — [language.md 11 節](../language.md)「接続の task の小さいスロット」）。maxWait = 飽和下の待ちの上限 D（ns・既定 100 \* task.MS・1 ms 未満は 1 ms）: 接続の task とその子は、走れるようになってから D 以内に走る（同じワーカーに違う D のtask が混ざると上限は混ざった中の最大）。飽和しない負荷では効かない。観測は task.Ledger() の maxWait / aged（[language.md 28 節](../language.md) ring の道「飽和下の待ちの上限」）。backlog = 接続の task とその子が列に積んでおける未着手の子の本数（1〜255・既定 255 — task.Run の backlog: と同じ。観測は task.Ledger() の backlog / backlogYield）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`
