# std/base64

日本語

`import "std/base64"`

base64（RFC 4648）の符号化と復号: 標準の字母（RFC 4648 4 節 — 詰め '=' つき）の Encode ⇄ Decode と、URL・ファイル名に安全な字母（RFC 4648 5 節 — '-' '\_'・詰めなし）のEncodeUrl ⇄ DecodeUrl。復号は厳格（1 つのバイト列に綴りは 1 つ — 字母の外の文字・空白と改行・余計な詰め・最後の文字の使わない bit が 0 でない綴りは Bad）。表引きと分岐で読むので秘密の値（鍵）の定数時間の道には使わない（std/crypto の規律の外）

## Bad

```sober
type Bad error
```

Decode / DecodeUrl の入力が綴りの規則に合わない（字母の外の文字・長さ・詰めの位置と数・最後の文字の使わない bit が 0 でない — RFC 4648 3.3・3.5）

## Encode

```sober
func Encode(b []byte) string
```

b の標準の字母の base64（4 文字ずつ・端は '=' で詰める — Go の base64.StdEncoding.EncodeToString と同じ綴り）

```sober
base64.Encode(bytes("hello"))   // "aGVsbG8="
```

## EncodeUrl

```sober
func EncodeUrl(b []byte) string
```

b の URL・ファイル名に安全な字母の base64（'+' '/' の代わりに '-' '\_'・詰めの '=' を書かない — Go の base64.RawURLEncoding と同じ綴り）

```sober
base64.EncodeUrl([]byte{0xfb, 0xff})   // "-_8"
```

## Decode

```sober
@errors(Bad)
func Decode(s string) ([]byte, error?)
```

標準の字母の base64 の s のバイト列（長さは 4 の倍数・'=' の詰めは端の 1〜2 文字だけ — Encode の綴りだけを受ける）

失敗のラベル: [`Bad`](#bad)

## DecodeUrl

```sober
@errors(Bad)
func DecodeUrl(s string) ([]byte, error?)
```

URL・ファイル名に安全な字母の base64 の s のバイト列（詰めの '=' は受けない — EncodeUrl の綴りだけを受ける）

失敗のラベル: [`Bad`](#bad)
