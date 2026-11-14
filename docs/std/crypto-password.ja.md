# std/crypto/password

日本語

`import "std/crypto/password"`

パスワードの保存用のハッシュ（Argon2id・bcrypt・PBKDF2-HMAC-SHA256）と照合。書く側は方式を明示して呼ぶ — 書くAPIに既定の方式は無い（保存した値は他のシステム・組織の方針との約束なので、stdが黙って選ばない）。新しく選ぶなら Argon2id（RFC 9106 — NeedsRehash の UseDefault が目標にする std の推す方式もこれ）。読む側（Verify・NeedsRehash）は保存した文字列の頭で方式を判別する。塩は書く側が OS の乱数で 16 バイト作る。保存の形は Argon2id と PBKDF2 が PHC 文字列（base64 は詰め物なし）・bcrypt が $2b$ の 60 文字

費用の仮引数は省略可の名前付きで、省いた費用は OWASP Password Storage Cheat Sheet（2026-11 時点の版）の推奨の下限（Argon2id: memoryKiB 19456・passes 2・lanes 1 / bcrypt: cost 10 / PBKDF2-HMAC-SHA256: iters 600000）。既定の値の改訂は std の版で行い、CHANGELOG に載る。費用は保存した文字列に入るので、既定が変わっても前に保存した値の Verify は変わらない（作り直しの要否は NeedsRehash で分かる — UseDefault を渡せば、版上げで既定が変わったときに作り直しを求める）

```sober
h := crypto.password.Argon2id(pw)?
ok := crypto.password.Verify(h, pw)?
if ok && crypto.password.NeedsRehash(h, crypto.password.UseDefault{})? {
    // 照合に通った pw で crypto.password.Argon2id(pw) を作り直して保存し直す（std の既定に追従する）
}
```

## Policy

```sober
type Policy union {
    UseDefault {}
    UseArgon2id { memoryKiB int; passes int; lanes int }
    UseBcrypt { cost int }
    UsePbkdf2 { iters int }
}
```

NeedsRehash に渡す目標の方式と費用。UseDefault は方式も費用も std の版に任せる形で、今の std の推す方式と既定の費用（Argon2id・memoryKiB 19456・passes 2・lanes 1）を目標にする — 費用を省いた Argon2id(pw) で作り直せば目標に揃う。std の版上げで既定が変わると、同じ保存の文字列でも UseDefault の判定は変わる（作り直しを求める側へ）

## BadParams

```sober
type BadParams error
```

費用が方式の範囲の外（Argon2id: 1 ≤ lanes \< 2^24・passes ≥ 1・8·lanes ≤ memoryKiB \< 2^32 / bcrypt: 4 ≤ cost ≤ 31 / PBKDF2: 1 ≤ iters \< 2^32）

## TooLong

```sober
type TooLong error
```

bcrypt に渡せない pw（72 バイトを超える・NUL を含む — bcrypt は 72 バイトで黙って打ち切り、C の実装は NUL で切る。長い pw は Argon2id で）

## Bad

```sober
type Bad error
```

保存した文字列が読めない（知らない方式・フィールドの形・base64・範囲の外の費用）

## Argon2id

```sober
@errors(BadParams)
@secret(pw)
@effects(io, panic)
func Argon2id(pw string, memoryKiB int?, passes int?, lanes int?) (string, error?)
```

pw の Argon2id の PHC 文字列（$argon2id$v=19$m=…,t=…,p=…$塩$値 — 値は 32 バイト）。費用は memoryKiB = メモリ m〔KiB〕・passes = パス t・lanes = レーン p（省けば 19456・2・1 — 19 MiB）。作業域 m は呼んだ task の region に取るので、std/net の Serve の接続の task（region: 既定 128 MiB）で m を 100 MiB 超にするなら region: も上げる

失敗のラベル: [`BadParams`](#badparams)

## Bcrypt

```sober
@errors(BadParams, TooLong)
@secret(pw)
@effects(io, panic)
func Bcrypt(pw string, cost int?) (string, error?)
```

pw の bcrypt の文字列（$2b$費用$塩と値 — 60 文字）。cost を省けば 10。72 バイトを超える pw・NUL を含む pw は TooLong（打ち切らない）特に理由がなければ Argon2id を使う。長い pw を bcrypt で受けたいときの正当な形は bcrypt(base64(sha256(pw)))（44 文字・NUL を含まない）で、罠が 2 つある:① 生のダイジェストを渡さない — 0 のバイトを含みうるので、NUL で切る実装では打ち切られる（ここでは TooLong で拒否）② 内側のハッシュsha256(pw) を別の所に保存しない — 漏れた内側のハッシュの表をbcryptの表と突き合わせる hash shucking のターゲットになる

失敗のラベル: [`BadParams`](#badparams)・[`TooLong`](#toolong)

## Pbkdf2

```sober
@errors(BadParams)
@secret(pw)
@effects(io, panic)
func Pbkdf2(pw string, iters int?) (string, error?)
```

pw の PBKDF2-HMAC-SHA256 の PHC 文字列（$pbkdf2-sha256$i=…,l=32$塩$値）。iters を省けば 600000

失敗のラベル: [`BadParams`](#badparams)

## Verify

```sober
@errors(Bad)
@secret(pw)
@effects(!io, !block, !nondet)
func Verify(stored string, pw string) (bool, error?)
```

pw が保存した文字列 stored（Argon2id・bcrypt〔$2a$ / $2b$ / $2y$〕・PBKDF2-SHA256）と合うか。値の比較は定数時間。bcrypt に渡せない pw（72 バイト超・NUL）は false

失敗のラベル: [`Bad`](#bad)

## NeedsRehash

```sober
@errors(Bad)
@effects(!io, !block, !nondet)
func NeedsRehash(stored string, policy Policy) (bool, error?)
```

保存した文字列 stored を目標 policy で作り直すべきか（方式が違う・費用が目標と違う・値の長さが既定〔32 バイト〕でない）。作り直すには pw が要るので、Verify に通った直後に呼ぶ

失敗のラベル: [`Bad`](#bad)
