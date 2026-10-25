# std/tls/record

日本語

`import "std/tls/record"`

TLS 1.3 の record 層（RFC 9846 5 節 — 8446bis）。std/tls の内側で、利用者は import しない（公開の API は std/tls の Serve / Conn。std の網が例から叩けるように公開名で置いている）。

- 送り: Seal は平文を 2^14 バイトずつの record に割り、1 record ごとに [頭 5 | 暗号文（平文 ‖ 内容の型 ‖ 0 埋め）| tag 16] を書く（AEAD は std/crypto の record 層向けの API SealTo — 頭 = 追加データ・nonce = iv ⊕ seq）
- 受け: Frames は転送路の受信コールバック recv から record の枠を切り出す呼び出し形の生成元（`for r <- record.Frames(recv)? { … }`）。record が受けの切片に丸ごと入っていれば切片のまま（写さない）・切片をまたぐときだけ持ち越しの列に溜めて繋ぐ。Open は枠 1 つを Dir の鍵で検証・復号して内容の型と中身を返す（剥がしは末尾 256 バイトを固定回数で舐める — 定数時間の対象・ctcheck）
- 鍵: Dir は 1 方向の traffic の鍵（traffic secret → HKDF-Expand-Label で key / iv）と seq。Update は KeyUpdate（secret を "traffic upd" で進めseq を 0 に）。AES-GCM の鍵の使用上限（RFC 9846 5.5 — 2^24.5 record）の手前で NeedUpdate が真になる（送りの KeyUpdate は handshake の層が送る）
- 誤りは Alert（TLS の alert の番号 — 閉じるときに相手へ送る値・RFC 9846 6 節）1 つ

## AesGcm

```sober
const AesGcm = 4865
```

cipher suite の番号（RFC 9846 B.4 — v1 は 2 つ・どちらも SHA-256）

TLS\_AES\_128\_GCM\_SHA256

## ChaCha

```sober
const ChaCha = 4867
```

cipher suite の番号（RFC 9846 B.4 — v1 は 2 つ・どちらも SHA-256）

TLS\_CHACHA20\_POLY1305\_SHA256

## CtCcs

```sober
const CtCcs = 20
```

record の内容の型（RFC 9846 5.1）

change\_cipher\_spec（互換の CCS）

## CtAlert

```sober
const CtAlert = 21
```

record の内容の型（RFC 9846 5.1）

alert

## CtHandshake

```sober
const CtHandshake = 22
```

record の内容の型（RFC 9846 5.1）

handshake

## CtApp

```sober
const CtApp = 23
```

record の内容の型（RFC 9846 5.1）

application\_data

## MaxPlain

```sober
const MaxPlain = 16384
```

record の大きさ（RFC 9846 5.1 / 5.2）

TLSInnerPlaintext の中身の上限

## MaxCipher

```sober
const MaxCipher = 16640
```

record の大きさ（RFC 9846 5.1 / 5.2）

TLSCiphertext の本体の上限

## HeadSize

```sober
const HeadSize = 5
```

record の大きさ（RFC 9846 5.1 / 5.2）

record の頭のバイト数

## AlertUnexpected

```sober
const AlertUnexpected = 10
```

alert の番号（RFC 9846 6）

unexpected\_message

## AlertBadMac

```sober
const AlertBadMac = 20
```

alert の番号（RFC 9846 6）

bad\_record\_mac

## AlertOverflow

```sober
const AlertOverflow = 22
```

alert の番号（RFC 9846 6）

record\_overflow

## AlertDecode

```sober
const AlertDecode = 50
```

alert の番号（RFC 9846 6）

decode\_error

## AlertInternal

```sober
const AlertInternal = 80
```

alert の番号（RFC 9846 6）

internal\_error

## Alert

```sober
type Alert error {
    desc int
}
```

record 層の誤り（desc = 相手へ送る alert の番号）

## Transport

```sober
type Transport error
```

転送路の受信コールバックが失敗した（相手の切断・期限など — 元の誤りは関数値越しでラベルを導出できないので包み替える。std/tls が tls.Closed に読む）

## Dir

```sober
type Dir struct {
    suite int
    secret []byte
    aes aesgcm.Key
    cc chacha20poly1305.Key
    iv []byte
    seq int
}
```

1 方向の traffic の鍵と seq

## Frame

```sober
type Frame struct {
    b []byte
    off int
    n int
}
```

受けた record の枠 1 つ = b[off, off + n)（頭 5 バイト込み）。b は受けの切片か、切片をまたいだ record を繋いだ写し（反復の間だけ生きる）

## ExpandLabel

```sober
@effects()
func ExpandLabel(secret []byte, label string, context []byte, n int) []byte
```

HKDF-Expand-Label(secret, label, context, n)（RFC 9846 7.1 — info = 長さ 2 バイト ‖ "tls13 " ‖ label ‖ context の長さ付き）

## NewDir

```sober
@errors(Alert)
@effects()
func NewDir(suite int, secret []byte) (Dir, error?)
```

suite と traffic secret の Dir（key = ExpandLabel(secret, "key", "", 16 / 32)・iv = ExpandLabel(secret, "iv", "", 12)・seq 0）

失敗のラベル: [`Alert`](#alert)

## Update

```sober
@errors(Alert)
@effects()
func Update(d mut Dir) error?
```

KeyUpdate（secret' = ExpandLabel(secret, "traffic upd", "", 32) — RFC 9846 7.2・key / iv を作り直して seq を 0 に）

失敗のラベル: [`Alert`](#alert)

## NeedUpdate

```sober
@effects()
func NeedUpdate(d Dir) bool
```

送りの鍵を進めるべきか（AES-GCM の使用上限の手前 — ChaCha20-Poly1305 は seq の上限〔2^64〕まで来ない）

## Seal

```sober
@effects()
func Seal(d mut Dir, ctype int, pt []byte, pad int) []byte
```

内容の型 ctype の平文 pt を record の列にしたもの（2^14 バイトずつ・各 record の内側の末尾に 0 埋め pad バイト〔0 = 埋めない〕）。空の pt は中身 0 バイトの record 1 つ（application\_data には送らない約束は呼び手 — RFC 9846 5.1）

## SealInto

```sober
@effects()
func SealInto(d Dir, ctype int, pt []byte, dst mut []byte, at int) int
```

Seal の宛先を呼び手の列 dst[at:] にした形（record 1 つ — pt が MaxPlain を越える・dst に入らなければ −1。書いたバイト数を返す）。d は読むだけ（seq は呼び手が +1 して書き戻す — mut の仮引数を dst の 1 つに保つ）。作業の列（頭・nonce・tail・AEAD の作業）は呼び手の region に積もる

## Plain

```sober
@effects()
func Plain(r Frame) (int, []byte)
```

暗号化していない record（handshake の最初の flight・互換の CCS）の内容の型と中身（枠 r の頭の後ろ — 写さない部分列）

## Open

```sober
@errors(Alert)
@bless
@effects()
func Open(d mut Dir, r Frame) (int, []byte, error?)
```

枠 r（外側の内容の型 = application\_data）を d の鍵で検証・復号して、内側の内容の型と中身（0 埋めを剥がした平文）を返す。tag の不一致は bad\_record\_mac・本体が tag より短い / 長すぎるは record\_overflow / decode\_error・内側が全部 0（内容の型が無い）は unexpected\_message

失敗のラベル: [`Alert`](#alert)

## Frames

```sober
@errors(Alert, Transport)
@effects()
func Frames(recv func(k func([]byte)) error?, k func(Frame)) error?
```

転送路の受信コールバック recv から record の枠を順に k へ渡す（呼び出し形の生成元 — `for r <- record.Frames(recv)? { … }`）。枠の本体の長さが MaxCipher を超えれば record\_overflow（溜めない）。record が受けの切片に丸ごと入っていれば切片のまま渡し、切片をまたぐrecord は持ち越しの列（最初にまたいだときに頭 + MaxCipher バイトを 1 回確保）に溜めて、揃ったら繋いだ写しを渡す。recv が閉じたときに半端な record が残っていれば decode\_error。recv の失敗は Transport に包み替える

失敗のラベル: [`Alert`](#alert)・[`Transport`](#transport)

## At

```sober
@effects()
func At(b []byte, off int, n int) Frame
```

b[off, off + n) を枠に（std/tls の handshake の組み立て — 呼び手が頭の長さを検査した後）

## Pack

```sober
@effects(panic)
func Pack(d Dir) []int
```

d の語の列（[suite, seq, 秘密の長さ, 秘密 …, iv の長さ, iv …, 鍵の素材の長さ, 鍵の素材 …] — バイト列は 8 バイト / 語。鍵の素材 = AES-GCM の展開済みの ctx か ChaCha20-Poly1305 の鍵 — 開くたびに展開し直さない）

## Unpack

```sober
@effects()
func Unpack(w []int, at int) Dir
```

Pack の逆（w[at:] から）

## WithSeq

```sober
@effects()
func WithSeq(d Dir, seq int) Dir
```

d の seq を seq に差し替えた Dir（鍵の素材は d と共有 — std/tls が展開済みの送りの方向に置き場の seq の語を当てる）

## Seq

```sober
@effects()
func Seq(d Dir) int
```

d の seq（std/tls がストレージの seq の語だけを書き戻す）
