# std/crypto/pem

日本語

`import "std/crypto/pem"`

PEM（RFC 7468 — "-----BEGIN \<label>-----" 〜 "-----END \<label>-----" の間のbase64）の読み。証明書のチェーン（CERTIFICATEが複数）と鍵（PRIVATE KEY）を同じ関数で読む。チャンクは書かれた順のまま返す（TLSの証明書のチェーンは葉が先頭）。中身（der）の解釈はしない — PKCS#8のRSAの鍵はrsa.ParsePKCS8へ（TLSの設定はtls.Parse / tls.Loadが両方をまとめて読む）base64 の綴りの検査は厳格（標準の字母・'=' の詰めは末尾だけ・行の間の空白と改行は飛ばす）

## Block

```sober
type Block struct {
    label string
    der []byte
}
```

1つのPEMのチャンク（label = BEGINの後ろの名前・der = 中身）

## Bad

```sober
type Bad error
```

PEM の形が違う（BEGIN と END が対にならない・base64 の綴りが違う）

## Parse

```sober
@errors(Bad)
@effects(!io, !block, !nondet)
func Parse(text string) ([]Block, error?)
```

textの中のPEMのチャンクの全部（チャンクの外の行は無視 — RFC 7468の説明文の扱い）

失敗のラベル: [`Bad`](#bad)
