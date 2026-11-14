# std/net

日本語

`import "std/net"`

名前の解決（スタブリゾルバ — libc の getaddrinfo を使わない）: Dial が IPv4 の綴りでないホストを受けたときに、/etc/hosts → /etc/resolv.conf の nameserver（最大3本を順に・1回の問い合わせは期限つき）へAを問う。search / ndotsの候補の順（resolv.conf(5)）・レスポンスの切り詰め（TC）はTCPで問い直す・レスポンスのCNAMEのチェーンを追う（answer節の中だけ・8レベルまで）・txidはgetrandom・レスポンスはtxidと問いの名前と型の一致を確認する。AAAAも読めるが、DialはIPv4だけ。非ASCIIのホスト名（IDN）は専用の診断で拒否する（punycodeはURLの層の仕事）。DNSSEC・DoH / DoT・キャッシュは持たない

## NoHost

```sober
type NoHost error
```

ホストの名前が引けない（NXDOMAIN・どの候補にも答えが無い・hosts にも無い）

## NonASCIIHost

```sober
type NonASCIIHost error
```

ホストの名前に非 ASCII の字がある（IDN は punycode〔xn--〕で渡す — 名前の解決の層は扱わない）

## Listener

```sober
type Listener struct {
    fd int
    seal netSeal
}
```

listenしているsocket（同一性の型 — コピーできない・外へ出せない・give: で渡せない。fdの番号は封）

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
@errors(Bad, NoHost, NonASCIIHost, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Dial(addr string, k func(Conn)) error?
```

addr（"a.b.c.d:port" か "ホスト名:port"）へ接続した Conn を 1 回だけ k に渡し、k が返ったら閉じる。ホスト名は /etc/hosts と/etc/resolv.conf の nameserver で引いた IPv4 の番地へ順に繋ぐ（最初に繋がった 1 つ — 名前の解決は dns.sober）

失敗のラベル: [`Bad`](#bad)・[`NoHost`](#nohost)・[`NonASCIIHost`](#nonasciihost)・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

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

lの接続を受けるたびに接続1本 = task 1本でhを走らせる（acceptのループはstdが持つ — ワーカーごとに1本・lと同じ番地にSO\_REUSEPORTで足したlistenerで受ける）。hは `func(c net.Conn) error?`（名前つき関数をそのまま — `net.Serve(l, echo, …)`。η 展開 — [language.md 25 節](../language.md)）。h の失敗は Serve が吸収する（接続を閉じて続ける — 数えるのは Serve のプールの Ledger の fail・死は died）。admission は名前つきプールのノード 1 つ（天井 = conns × budget バイト — 省略時は budget = 64 \* task.KB・conns = 10000）+ 接続ごとの SpawnIn（budget = 接続 1 本の上界）: 入れなければ reject の定数のバイト列を 1 回送って閉じる（既定は送らずに閉じる・利用者のコードは走らせない）。h の死は Serve の scope が吸収して Serve は続く。受けた Conn はServe が閉じる（接続の task の登録簿 — 死んでも出口で閉じる）。Serve が返るのは listener の失敗か、Serve を包む scope の期限（accept の待ちが切れる）— 走っている接続の決着を待ってから。listenerの失敗は1つでも全部のループを止める（残りのlistenerをshutdown — 受けていないlistenerに接続が振られて残らないように）: 以後lはlistenしていない。Serve が足した listener は Serve が閉じる・l は Listen が閉じる。region = 接続の task の region 1 つの上限（既定 128 \* task.MB・2 の冪に切り上げ・1 MiB 未満は 1 MiB・子の task の既定〔512 MiB〕より大きくはならない）: 超えるとその接続の task の死（RegionExceeded{cause: slot\_capacity} — Serve が吸収し Ledger の died が数える）。小さいスロットは既定のスロットを割って深度ごとに 1 本（接続数 × 深度ぶんの VA を減らす — [language.md 11 節](../language.md)「接続の task の小さいスロット」）。maxWait = 飽和下の待ちの上限D（ns・既定100 \* task.MS・1 ms未満は1 ms）: acceptのループ・接続のtaskとその子が継ぐ。走れるようになってからDを過ぎたtaskは、期限の順に、まだ期限の来ていない task より先に走る（同じワーカーに違う D の task が混ざると順は積んだ順）。飽和しない負荷では効かない。D を越えて走った数と越えた量はtask.Ledger() のlate / maxLateで読める（[language.md 28 節](../language.md)ringのパス「飽和下の待ちの上限」）。backlog = 接続の task とその子が列に積んでおける未着手の子の本数（1〜255・既定 255 — task.Run の backlog: と同じ。観測は task.Ledger() の backlog / backlogYield）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`
