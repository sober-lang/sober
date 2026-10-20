# std/crypto/pem

日本語

`import "std/crypto/pem"`

PEM（RFC 7468 — "-----BEGIN \<label>-----" 〜 "-----END \<label>-----" の間の base64）の読み。証明書の鎖（CERTIFICATE が複数）と鍵（PRIVATE KEY）を同じ関数で読む。塊は書かれた順のまま返す（TLS の証明書の鎖は葉が先頭）。中身（der）の解釈はしない — PKCS#8 の RSA の鍵は rsa.ParsePKCS8 へ（TLS の設定は tls.Parse / tls.Load が両方をまとめて読む）base64 の綴りの検査は厳格（標準の字母・'=' の詰めは末尾だけ・行の間の空白と改行は飛ばす）

## Block

```sober
type Block struct {
    label string
    der []byte
}
```

1 つの PEM の塊（label = BEGIN の後ろの名前・der = 中身）

## Bad

```sober
type Bad error
```

PEM の形が違う（BEGIN と END が対にならない・base64 の綴りが違う）

## Parse

```sober
@errors(Bad)
func Parse(text string) ([]Block, error?)
```

text の中の PEM の塊の全部（塊の外の行は無視 — RFC 7468 の説明文の扱い）

失敗のラベル: [`Bad`](#bad)
