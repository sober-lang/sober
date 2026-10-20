# std/binary

日本語

`import "std/binary"`

バイト列の語単位の読み（1 バイトずつの読みを 1 回の検査 + 1 回の load に）。書きの対（Store64）は無い — 書くときは 1 バイトずつ積む

## Load64

```sober
func Load64(b []byte, i int) int
```

b[i]〜b[i + 7] の 8 バイトを little-endian で読んだ int（b[i] が最下位のバイト）。i \< 0 か i + 8 > len(b) なら panic(OutOfRange{i, len(b)})（検査は 1 か所 — `i > len(b) - 8` は len(b) ≥ 0 なので桁あふれしない）

## OutOfRange

```sober
type OutOfRange panic {
    i int
    n int
}
```

Load64 の読みが b の外にはみ出した（呼び手の契約違反 — panic ラベル。[language.md 27 節](../language.md)）
