# std/crypto/aesgcm

日本語

`import "std/crypto/aesgcm"`

AES-128-GCM（NIST SP 800-38D — 鍵 16 バイト・nonce 12 バイト・tag 16 バイト）。本体は x86 の AES-NI + PCLMULQDQ + SSSE3 の専用命令の実装で、ソフトの AES は書かない（表引きは定数時間にならない）: 専用命令の無い機械・x86 の最適化のバックエンド以外の出力では Available() = false で、Seal / Open は NoHardware を返す（TLS は suite の選択で ChaCha20-Poly1305 に倒れる）。SOBER\_NOAES=1 で専用命令の無い機械を装える。同じ鍵で nonce を 2 回使ってはならない（CTR の鍵ストリームが重なって平文の xor が漏れ、GHASH の鍵 H も解けて tag を偽造できる）

```sober
if aesgcm.Available() { ct := aesgcm.Seal(key, nonce, ad, pt)? }
```

record 層向けの API: 鍵の展開は Prepare で 1 回（接続ごと方向ごと）・record ごとは ctx の写し + nonce だけ。SealTo は head ‖ 暗号文 ‖ tag を 1 回の確保に直に書き、OpenAt は b[off, off + n) を写さずに検証してから復号する

```sober
k := aesgcm.Prepare(key)?
rec := aesgcm.SealTo(k, nonce, ad, pt, hdr, tail)?     // hdr ‖ 暗号文（pt ‖ tail）‖ tag
pt := aesgcm.OpenAt(k, nonce, ad, buf, off, n)?        // buf[off, off + n) = 暗号文 ‖ tag
```

## KeySize

```sober
const KeySize = 16
```

長さの定数（バイト）

鍵の長さ

## NonceSize

```sober
const NonceSize = 12
```

長さの定数（バイト）

nonce の長さ

## Overhead

```sober
const Overhead = 16
```

長さの定数（バイト）

Seal の暗号文が平文より長くなる分（tag）

## NoHardware

```sober
type NoHardware error
```

この機械で AES-GCM の専用命令の実装を使えない（AES-NI / PCLMULQDQ / SSSE3 が無い・SOBER\_NOAES=1・x86 の最適化のバックエンド以外の出力）

## BadSize

```sober
type BadSize error
```

鍵・nonce の長さが違う・暗号文が tag より短い・切片の外を指す

## Auth

```sober
type Auth error
```

tag が合わない

## Available

```sober
@effects(!io, !block, !nondet)
func Available() bool
```

この機械で Seal / Open が使えるか

## Key

```sober
type Key struct {
    ctx []byte @secret
}
```

展開した鍵（Prepare の結果 — 鍵の展開 11 段と GHASH の H^1〜H^4 を持つ ctx のテンプレート。Sober からも専用命令の実装からも書かない — record ごとに写して使う）

## Prepare

```sober
@errors(NoHardware, BadSize)
@secret(key)
@effects(!io, !block, !nondet)
func Prepare(key []byte) (Key, error?)
```

key を展開した Key（専用命令の有無と鍵の長さはここで見る）

失敗のラベル: [`NoHardware`](#nohardware)・[`BadSize`](#badsize)

## Seal

```sober
@errors(NoHardware, BadSize)
@secret(key)
@bless
@effects(!io, !block, !nondet)
func Seal(key []byte, nonce []byte, ad []byte, pt []byte) ([]byte, error?)
```

pt を暗号化して tag を付けたもの（暗号文 ‖ tag）。nonce は同じ鍵で 1 回だけ使う

失敗のラベル: [`NoHardware`](#nohardware)・[`BadSize`](#badsize)

## Open

```sober
@errors(NoHardware, BadSize, Auth)
@secret(key)
@effects(!io, !block, !nondet)
func Open(key []byte, nonce []byte, ad []byte, sealed []byte) ([]byte, error?)
```

Seal の逆（tag を crypto.Equal で照合してから復号する）

失敗のラベル: [`NoHardware`](#nohardware)・[`BadSize`](#badsize)・[`Auth`](#auth)

## SealTo

```sober
@errors(BadSize)
@bless
@effects(!io, !block, !nondet)
func SealTo(k Key, nonce []byte, ad []byte, pt []byte, head []byte, tail []byte) ([]byte, error?)
```

head ‖ 暗号文 ‖ tag（平文 = pt ‖ tail — tail は TLS 1.3 の内側の型と詰め物のような後ろの数バイトを、呼び手が pt に繋いで写さずに渡す口。無ければ []byte{}）。nonce は同じ鍵で 1 回だけ使う（Seal と同じ）・nonce の長さが違えば BadSize（1 回の確保 — head と pt と tail を宛先へ一括で写し、CTR は宛先のその場で〔16 の倍数に切り上げ — はみ出しは tag の席〕・GHASH は宛先の暗号文を読む・tag は計数器 J0 の ctx の CTR で宛先へ書く〔Y ⊕ E(J0) — 宛先は凍っているので Sober の添字では書かない〕）

失敗のラベル: [`BadSize`](#badsize)

対の `OpenTo` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。

## OpenAt

```sober
@errors(BadSize, Auth)
@effects(!io, !block, !nondet)
func OpenAt(k Key, nonce []byte, ad []byte, b []byte, off int, n int) ([]byte, error?)
```

b[off, off + n)（暗号文 ‖ tag）を写さずに tag を照合してから復号した平文。nonce の長さが違う・n が tag より短い・[off, off + n) が b の外なら BadSize

失敗のラベル: [`BadSize`](#badsize)・[`Auth`](#auth)

対の `SealAt` は実需まで足さない（[language.md 34 節](../language.md) の規則 2）。
