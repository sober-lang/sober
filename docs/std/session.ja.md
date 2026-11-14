# std/session

日本語

`import "std/session"`

世代つきのセッショントークン（HMAC-SHA256 で署名した claims — サーバ側にセッションの表を持たない）。トークンは発行した時点の世代（gen）を刻む。認証の根（パスワードのハッシュ等）の隣に世代番号を置き、根を替えるとき（パスワードの変更・全端末のログアウト）に世代を 1 つ進めれば、それより前に発行したトークンは全部 Stale になる — 消し忘れの規律でなく構造で切れる。照合は二段: Open が形・タグ・期限を見て Unchecked を返し、呼び手は Subject で根の行を引いて、今の世代を Check に渡す。Claims は Check だけが作るので、今の世代を引かない限り Claims は手に入らない。世代を使わないアプリは gen を常に 0 で回す

```sober
k := session.KeyFrom(cfgSecret)                        // 32 バイト以上の秘密（設定由来）— 起動ごとに作るなら session.KeyNew()
t := session.Mint(k, user.id, user.gen, time.Now(), 86400)
// session.Seal(t) を __Host- の cookie の値に書く
```

```sober
u := session.Open(k, raw, time.Now())?                 // raw = cookie の値
user := users[session.Subject(u)]                      // 根の行を引く（無ければ再ログインへ）
c := session.Check(u, user.gen)?
who, _ := session.Who(c)                               // 認可に使える subject（ゼロ値の Claims では false）
```

Key・Token・Unchecked・Claimsは封の型（外でcompositeに書けない）。TokenとKeyに ==・印字のインターフェースは無い — 外へ出すインターフェースはSealだけ（grepで数えられる名前）。タグの比較は定数時間（crypto.Equal）で、claimsのフィールドはタグが合ってから読む

脅威モデル — 備えているもの（攻撃 → 備え）:
- トークンの偽造・改竄（subject・世代・期限の書き換え）→ HMAC-SHA256 のタグ。鍵を知らなければ作れず、1 bit の書き換えも Bad
- タグの比較の時間から正しいタグを探る → 定数時間の比較（crypto.Equal）。claimsのフィールドはタグが合うまで読まない
- 盗まれたトークンを長く使い続ける → 期限（ttlSec は必須 — 無期限のトークンは書けない）
- パスワードを変えた後も、変える前のトークンで入り続ける（盗んだ側の居座り）→ 世代。パスワードの変更で世代を進めれば、それまでのトークンは全部 Stale。今の世代を Check に渡さないと Claims は手に入らないので、世代の照合を忘れる書き方が無い
- 乗っ取った側がパスワードを変えて本人を締め出す → 世代が進んで乗っ取った側の他のトークンも本人の端末も切れる（黙って並び立てない — 乗っ取りが表に出る）
- 短い秘密から鍵を総当たり → KeyFrom は 32 バイト未満を panic(WeakSecret)・HKDF で session の用途の鍵に分ける
- ゼロ値の Claims（外の package でも書ける）を検証済みとして渡す → 中身は Check が入れたときだけある。Who と Of はゼロ値で false を返し、フィールドを直に読んでもnilの絞りを通らないと中身に届かない
- トークンや鍵がログ・印字に漏れる → TokenとKeyに印字のインターフェースが無い。Sealの結果は認証の源（その値を載せたレスポンスは共有キャッシュに置けない）
- cookie の盗み読み（スクリプト・平文の経路）→ std/http/server の SetCookie の既定（Secure・HttpOnly・SameSite=Lax）と \_\_Host- の名前で

守らないもの:
- 同じ世代の中で盗まれたトークン: 期限か世代の進みまで通る（持っている者を本人として扱う — 本人の操作と区別しない）。ttlSec を短くし、怪しければ世代を進める
- 端末ごとの失効（この端末だけログアウト）: logout で cookie を消しても、トークンそのものは期限まで有効。端末ごとに切るなら、失効させたトークンのClaims の id（Of）をアプリの表に持ち、Check の後で引く（表と掃除は std/session の外 — 期限を過ぎた id は表から捨ててよい）
- 鍵の漏れ: 鍵を知る者は任意のトークンを作れる。鍵を替える（KeyNew・別の secret）と発行済みのトークンは全部 Bad になる
- 同じトークンの再送: 期限の内なら何度でも通る

## Key

```sober
type Key struct {
    k []byte @secret
    seal keySeal
}
```

照合の鍵（HMAC-SHA256 の 32 バイト）

## Token

```sober
type Token struct {
    s string
    seal tokenSeal
}
```

発行したトークン（外へ出すインターフェースはSealだけ）

## Unchecked

```sober
type Unchecked struct {
    subject string
    gen int
    id string
    issued int
    expires int
    seal uncheckedSeal
}
```

タグと期限は通ったが、世代はまだ見ていないトークン（Open の結果 — Subject で根の行を引いて Check へ渡す）

## Claims

```sober
type Claims struct {
    v Info?
    seal claimsSeal
}
```

Check を通ったトークン（作れるのは Check だけ — 受け取った関数は世代まで検証済みと読める）。中身はWho（subject）とOf（全フィールド）で読む — ゼロ値のClaims（外でも書ける）ではどちらもfalseで、検証済みの値として読める形が無い

## Info

```sober
type Info struct {
    subject string
    gen int
    id string
    issued time.Time
    expires time.Time
}
```

Claims の中身（Of の結果 — ただの値で、検証の証人は Claims の側）。issued・expires は秒の精度（Mint の now の端数は切り捨て）

フィールド:

- `id` — トークンの識別子（nonce の 16 進 32 文字 — 公開の値・端末単位の失効の表の鍵用。同じ subject・同じ秒でも毎回違う）

## Bad

```sober
type Bad error
```

トークンの形が崩れている・タグが合わない（改竄・鍵違い・知らない版）

## Expired

```sober
type Expired error
```

有効期限（発行時の ttlSec）を過ぎた

## Stale

```sober
type Stale error
```

トークンの世代が今の世代と違う（Check — 期限の切れたトークンは Open が先に Expired で落とす）— 根の世代が進んでいる（パスワードの変更・全端末のログアウトなど）ので、そのトークンでは入れない。再ログインが要る

## WeakSecret

```sober
type WeakSecret panic {
    n int
}
```

KeyFrom の secret が 32 バイトに満たない（短い秘密は発行済みのトークンから総当たりで鍵を割られる）

## BadTtl

```sober
type BadTtl panic {
    ttlSec int
}
```

Mint の ttlSec が 0 以下（発行した時点で切れているトークンは作らない）

## KeyNew

```sober
@effects(io, panic)
func KeyNew() Key
```

OS の乱数の新しい鍵（プロセスの寿命だけ使う鍵 — 再起動で発行済みのトークンは全部 Bad になる）

## KeyFrom

```sober
@secret(secret)
@effects(panic)
func KeyFrom(secret []byte) Key
```

設定由来の secret（32 バイト以上）から HKDF-SHA256 で導いた鍵（同じ secret から同じ鍵 — 再起動をまたいでトークンが通る）。session の用途の salt と info で分けるので、同じ secret を他の用途の鍵にしても衝突しない。32 バイト未満は panic(WeakSecret{n})

## Mint

```sober
@effects(io, panic)
func Mint(k Key, subject string, gen int, now time.Time, ttlSec int) Token
```

subject・世代 gen のトークン（now から ttlSec 秒有効 — 上限は無い・int の上限で飽和）。nonce は OS の乱数 16 バイトで、同じ秒・同じ subject でも毎回違うトークンになる。ttlSec が 0 以下なら panic(BadTtl{ttlSec})

## Seal

```sober
@credential
@effects()
func Seal(t Token) string
```

tの文字列（base64url・詰めなし — cookieの値に引用なしで置ける）。トークンを外へ出す唯一のインターフェースで、結果は認証の源（この値を載せたレスポンスは共有キャッシュに置けない）

## Open

```sober
@errors(Bad, Expired)
@effects(!io, !block, !nondet)
func Open(k Key, raw string, now time.Time) (Unchecked, error?)
```

raw（Seal の文字列）を鍵 k で照合し、今の時刻 now で期限を見たもの（世代はまだ見ない — Subject で根の行を引いて Check へ）。形が崩れている・タグが合わない・知らない版は Bad、now の秒が期限以上なら Expired（根の行を引かずに落とせる）。タグの比較は定数時間で、claimsのフィールドはタグが合ってから読む

失敗のラベル: [`Bad`](#bad)・[`Expired`](#expired)

## Subject

```sober
@effects()
func Subject(u Unchecked) string
```

u の subject — 根の行（今の世代）を引くための値。認可には使わない（世代を見ていない — 認可は Check の結果の Claims を Who で読む）

## Check

```sober
@errors(Stale)
@effects()
func Check(u Unchecked, currentGen int) (Claims, error?)
```

u の世代が今の世代 currentGen と同じなら Claims、違えば Stale（根の世代が進んだ — 再ログインが要る）

失敗のラベル: [`Stale`](#stale)

## Who

```sober
@effects()
func Who(c Claims) (string, bool)
```

c の subject（認可に使える値）と true。Check が作った Claims でなければ（ゼロ値）"" と false

## Of

```sober
@effects()
func Of(c Claims) (Info, bool)
```

cの全フィールド（世代・id・発行と期限の時刻 — idは端末単位の失効の表の鍵）とtrue。Checkが作ったClaimsでなければ（ゼロ値）ゼロ値のInfoとfalse
