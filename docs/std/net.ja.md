# std/net

日本語

`import "std/net"`

名前の解決（スタブリゾルバ — libc の getaddrinfo を使わない）: Dial が IPv4 の綴りでないホストを受けたときに、/etc/hosts → /etc/resolv.conf の nameserver（IPv4かIPv6・最大3本を順に・1回の問い合わせは期限つき）へAとAAAAを1つのUDPのsocketから同時に問う。search / ndotsの候補の順（resolv.conf(5)）・レスポンスの切り詰め（TC）はTCPで問い直す・レスポンスのCNAMEのチェーンを追う（answer節の中だけ・8レベルまで）・txidはgetrandom・レスポンスはtxidと問いの名前と型の一致を確認する。/etc/hostsはIPv4とIPv6の行をファイルの順で返す。DNSの答えはIPv6とIPv4の交互（IPv6が先）に並べる（Dialが順に試す）。非ASCIIのホスト名（IDN）は専用の診断で拒否する（punycodeはURLの層の仕事）。DNSSEC・DoH / DoT・キャッシュは持たない

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
    sec []internal.sec.State
    seal netSeal
}
```

接続（同一性の型 — Listener と同じ規則。Accept / Dial / tls.Serve の k の仮引数としてだけ生まれる）。secはTLSの接続の状態（tls.Serveが渡す接続だけが要素を1つ持つ — 平文の接続は空）。Recv / Send / Put / Flushはsecを見てTLSの読み書きへ分ける。列（参照の2ワード）にするのは、状態の値（20ワード余り）を平文の接続のtaskの枠に置かないため

## Bad

```sober
type Bad error
```

addr の形の誤り。受ける形は "host:port"・"a.b.c.d:port"・"[IPv6]:port"・"[IPv6%zone]:port"（zone はインターフェースの名前か番号）と、Listen だけが受ける ":port" で、port は 0〜65535。角括弧の無い IPv6 の番地（"::1:80"）は誤り（どこまでがホストか決まらない）

## Listen

```sober
@errors(Bad, io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Listen(addr string, k func(Listener)) error?
```

addr で listen した Listener を 1 回だけ k に渡し（addr の "0.0.0.0:port" は IPv4 だけ・"[::]:port" は IPv6 だけ・ホストを省いた ":port" は両方。SO\_REUSEADDR・SO\_REUSEPORT・TCP\_NODELAY・backlog 65535 — somaxconn へ詰める・Go と同じ）、k が返ったら閉じる。SO\_REUSEPORT は Serve のワーカーごとの listener（同じ番地に足す）のため: 同じ uid の別のプロセスも同じ port に bind でき、接続をカーネルの振り分けで分け合う（同じ番地の 2 つ目の起動は EADDRINUSE で落ちずに黙って一部を受ける・別の uid は bind できない — 安全性ガイド〔docs/guide/security.ja.md〕の「Sober が守らないもの」）

失敗のラベル: [`Bad`](#bad)・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Secure

```sober
@errors(k)
@effects()
func Secure(c Conn, s internal.sec.State, k func(Conn) error?) error?
```

cと同じ接続に、TLSの状態sを持たせてkへ渡し、kの結果を返す（std/tlsのServeがhandshakeの後に呼ぶ。sの型はstdの内部にあるので、利用者のpackageからは呼べない）

失敗のラベル: `k`

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

addr（"a.b.c.d:port"・"[IPv6]:port"・"ホスト名:port"）へ接続した Conn を 1 回だけ k に渡し、k が返ったら閉じる。ホスト名は /etc/hosts と/etc/resolv.conf の nameserver で引いた番地へ順に繋ぐ（最初に繋がった 1 つ。名前の解決は dns.sober）

失敗のラベル: [`Bad`](#bad)・[`NoHost`](#nohost)・[`NonASCIIHost`](#nonasciihost)・`io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Recv

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Recv(c Conn, k func([]byte)) error?
```

c の受信を切片ずつ k へ渡す（失敗しうる生成元 — `for chunk <- net.Recv(c)? { … }`）。相手が閉じたら（FIN）列が終わる。切片はこの反復の region の []byte（1 回の read の分・最大 64 KiB）。TLSの接続（tls.Serveが渡すc）では、切片は受けたrecordを開いた平文（1回のreadに揃ったrecordの分 — recordの途中は接続の状態に持ち越す）で、相手のclose\_notifyで列が終わる。kがPutで積んだ分は、切片1つをkへ渡し終えるたびに送る。相手のfatal alertはio.Closed、壊れたrecord（こちらがalertを送って閉じる）はio.Other{errno: 71}（EPROTO）。breakで抜けた後も、次のRecvが続きを読む

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Send

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Send(c Conn, b []byte) error?
```

b を全部 c へ送る（同期 — 短い書きは続きから・MSG\_NOSIGNAL で相手が閉じた後の書きは io.Closed）。TLSの接続ではapplicationのrecordにして送る（Put + Flush。空のbは送らない）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Put

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Put(c Conn, b []byte) error?
```

bをcの送信バッファに積む（送りの2段階の1段目）。Flushか、Recvのkが戻ったときか、送信バッファに入らない次のPutが送る。TLSの接続ではapplicationのrecordにして積む（入らなければ積んだ分を送ってからその場で送る — 順序は保つ）。平文の接続ではSendと同じ

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## Flush

```sober
@errors(io.Closed)
@effects(block, io, nondet)
func Flush(c Conn) error?
```

cの送信バッファに積んだ分を送る（無ければ何もしない。平文の接続は積まないので何もしない）

失敗のラベル: `io.Closed`

## Serve

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, panic, nondet)
func Serve(l Listener, h func(Conn) error?, budget int?, conns int?, reject string?, region int?, backlog int?) error?
```

lの接続を受けるたびに接続1本 = task 1本でhを走らせる（acceptのループはstdが持つ — ワーカーごとに1本・lと同じ番地にSO\_REUSEPORTで足したlistenerで受ける）。hは `func(c net.Conn) error?`（名前つき関数をそのまま — `net.Serve(l, echo, …)`。η 展開 — [language.md 25 節](../language.md)）。h の失敗は Serve が吸収する（接続を閉じて続ける — 数えるのは Serve のプールの Ledger の fail・死は died）。admission は名前つきプールのノード 1 つ（天井 = バイト + ワーカー数 × ワーカーごとの作業の分 — 作業の分 = ワーカーで走っているtaskが予約を越えて借りる分）+ 接続ごとの SpawnIn（budget = 接続 1 本の上界・省略時は 64 \* task.KB）。天井のバイトは、conns があれば conns × 2 × (budget + task.Fixed())（task.Fixed() = taskの固定費。本数の天井も conns。2倍のうち1つ分は接続ごとの進行の保証 — 天井は、全部の接続が自分の子〔HTTP/2のストリームなど〕を1本ずつ、接続の予約と同じ大きさで同時に走らせる量を持つ。接続で埋まった天井でも子が入場できる。余白は接続ごとに取り分けず、天井の中で分け合う）、無ければ根の天井の残りからlistener の待ち行列とランタイムの列の分を引いた量（本数の天井なし — 入場はバイトの天井で決まる）。入れなければ reject の定数のバイト列を 1 回送って閉じる（利用者のコードは走らせない）。reject を省けば、受けた接続を listener ごとのランタイムの列で待たせ、空きができたら列のいちばん新しい接続から入れる。列が上限に達したら1本を閉じる（shed に数える。まだ1バイトも受けていない接続の古い順、無ければ頭の近くで未読のバイト数がいちばん多い接続）。入場を待つ接続があるときは、受けの無い・遅い入場済みの接続から切って枠を取り戻す（Ledger の evicted）。io\_uring の経路でない構成（epoll の経路）も同じ形。listener の backlog は根の天井の残りから導いた値に置き直す。task.Ledger() の pools には、このプロセスの Serve の全部（tls.Serve も）の親の節が1行ある（parent が -1・conns = 0）。h の死は Serve の scope が吸収してServe が閉じる（接続の task の登録簿 — 死んでも出口で閉じる）。Serve が返るのは listener の失敗か、Serve を包む scope の期限（accept の待ちが切れる）— 走っている接続の決着を待ってから。accept の一時的な失敗（fd の上限 EMFILE・ENFILE・カーネルのメモリ ENOBUFS・ENOMEM — 5 ms から2倍ずつ・上限 1 秒待ってから・相手が去った ECONNABORTED — 待たずに）では返らずに受け直す（Ledger の Serve の行の acceptRetry に数える。資源が尽きた形は、続いた失敗の始まりに stderr へ1行 — 10 秒に1行まで）。listenerの失敗は1つでも全部のループを止める（残りのlistenerをshutdown — 受けていないlistenerに接続が振られて残らないように）: 以後lはlistenしていない。Serve が足した listener は Serve が閉じる・l は Listen が閉じる。region = 接続の task の region 1 つの上限（既定 128 \* task.MB・2 の冪に切り上げ・1 MiB 未満は 1 MiB・子の task の既定〔512 MiB〕より大きくはならない）: 超えるとその接続の task の死（RegionExceeded{cause: slot\_capacity} — Serve が吸収し Ledger の died が数える）。小さいスロットは既定のスロットを割って深度ごとに 1 本（接続数 × 深度ぶんの VA を減らす — [language.md 11 節](../language.md)「接続の task の小さいスロット」）。backlog = 接続の task とその子が列に積んでおける未着手の子の本数（1〜255・既定 255 — task.Run の backlog: と同じ。観測は task.Ledger() の backlog / backlogYield）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`

## WaitView

```sober
type WaitView struct {
    waiting int
    limit int
}
```

受け付けを待っている接続の数（読んだ時点の値）と、その上限

フィールド:

- `waiting` — このプロセスの net.Serve・tls.Serve の全 listener の、受け付けの待ち行列の長さと、受けて入場していないランタイムの列の本数と、入場を待って受け付けのループが手に持っている接続の数の和
- `limit` — 全 listener の待ち行列の大きさの和（waiting がこれに張り付いていれば、新しい接続はカーネルが落として相手の SYN の再送で待つ）

## Waiting

```sober
@effects(nondet)
func Waiting() WaitView
```

このプロセスの Serve が受け付けを待たせている接続の数（task.Ledger と同じく読んだ時点の値 — 入場が埋まると増える。スケールアウトの判断に読む）。listener ごとに TCP\_INFO（listener では tcpi\_unacked = 待ち行列の長さ・tcpi\_sacked = 大きさ）を 1 回読む。断った接続は task.Ledger() の shed

## Pair

```sober
@errors(io.Closed, io.Timeout, io.Expired, io.Denied, io.Other)
@effects(block, io, nondet)
func Pair(server func(c Conn) error?, client func(c Conn)) error?
```

繋がった接続の組（一方へ送ったバイトが他方の受けに届く — カーネルのsocketpair・AF\_UNIXのstream・非ブロック）の一方をserverへ子のtaskで、他方をclientへ呼び手のtaskで渡す。clientが返ったらclientの側を閉じ（serverの受けは相手の閉じで終わる）、serverの終わりを待って戻る。serverの誤りの値は吸収する（結果はclientが受けたバイトで見る）。serverの死（panic）は呼び手に伝わる（子のJoinと同じ — 例と試験で見落とさない）。Pairが返す誤りはsocketpairの失敗だけ。例と試験で、ポートを使わずにサーバーとクライアントを1つのプログラムの中で繋ぐのに使う（ServeConnの受けの待ち・期限・送信バッファリングは本物の接続と同じ道で走る）。serverは並行に走るので、可変を捕獲できない（net.Serveのhandlerと同じ規則）

失敗のラベル: `io.Closed`・`io.Timeout`・`io.Expired`・`io.Denied`・`io.Other`
