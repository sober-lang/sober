# std/crypto/aescbc

日本語

`import "std/crypto/aescbc"`

AES-128-CBC（NIST SP 800-38A 6.2 — 鍵 16 バイト・IV 16 バイト・長さは 16 の倍数。埋め草は付けない — 呼び手の record 層が付けて外す）。TLS 1.2 の CBC のスイート（std/tls の dangerouslyAllowTls12 の道）のためだけにある。本体は x86 の AES-NI の専用命令の実装で、ソフトの AES は書かない（表引きは定数時間にならない）: 専用命令の無い機械・x86 の最適化のバックエンド以外の出力では Available() = false で、Prepare は NoHardware を返す。CBC は認証しない。MAC と組み合わせ、埋め草の検査と MAC の照合を定数時間で行うのは呼び手の責任（Lucky13）

```sober
k := crypto.aescbc.Prepare(key)?
ct := crypto.aescbc.Encrypt(k, iv, pt)?
pt := crypto.aescbc.Decrypt(k, iv, ct)?
```

## KeySize

```sober
const KeySize = 16
```

長さの定数（バイト）

鍵の長さ

## BlockSize

```sober
const BlockSize = 16
```

長さの定数（バイト）

ブロックと IV の長さ

## NoHardware

```sober
type NoHardware error
```

この機械で AES の専用命令の実装を使えない（AES-NI が無い・SOBER\_NOAES=1・x86 の最適化のバックエンド以外の出力）

## BadSize

```sober
type BadSize error
```

鍵・IV の長さが違う・本文の長さが 16 の倍数でない・切片の外を指す

## Available

```sober
@effects(!io, !block, !nondet)
func Available() bool
```

この機械で CBC が使えるか

## Key

```sober
type Key struct {
    tbl []byte @secret
}
```

展開した鍵（暗号化の鍵 11 ラウンドと復号の鍵 11 ラウンド。Prepare の後は書かない — 状態が番地で指す）

## Prepare

```sober
@errors(NoHardware, BadSize)
@secret(key)
@effects(!io, !block, !nondet)
func Prepare(key []byte) (Key, error?)
```

key を展開した Key（専用命令の有無と鍵の長さはここで見る）

失敗のラベル: [`NoHardware`](#nohardware)・[`BadSize`](#badsize)

## Encrypt

```sober
@errors(BadSize)
@effects(!io, !block, !nondet)
func Encrypt(k Key, iv []byte, pt []byte) ([]byte, error?)
```

pt（16 の倍数）を iv から連鎖して暗号化したもの（pt と同じ長さ）

失敗のラベル: [`BadSize`](#badsize)

## Decrypt

```sober
@errors(BadSize)
@effects(!io, !block, !nondet)
func Decrypt(k Key, iv []byte, ct []byte) ([]byte, error?)
```

Encrypt の逆（ct と同じ長さの平文 — 埋め草はそのまま返す）

失敗のラベル: [`BadSize`](#badsize)

## DecryptAt

```sober
@errors(BadSize)
@effects(!io, !block, !nondet)
func DecryptAt(k Key, iv []byte, b []byte, off int, n int) ([]byte, error?)
```

b[off, off + n) を iv から連鎖して復号したもの（record の受けの列から写さずに読む形）

失敗のラベル: [`BadSize`](#badsize)
