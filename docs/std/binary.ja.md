# std/binary

日本語

`import "std/binary"`

バイト列のワード単位の読み（1バイトずつの読みを1回の検査 + 1回のloadに）と末尾へのワードの書き（AppendWord）。途中の位置を書き換えるAPI（Store64）は無い

## Load64

```sober
@effects(panic)
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

Load64 / MatchLen の読みが b の外にはみ出した・AppendWord の k が 0〜8 の外（呼び手の契約違反 — panic ラベル。[language.md 27 節](../language.md)）

## MatchLen

```sober
@effects(panic)
func MatchLen(b []byte, i int, j int, n int) int
```

b[i:i+n] と b[j:j+n] の先頭からの一致の長さ（0〜n — 最初に食い違うバイトの位置・全部一致なら n）。区間は重なってよい。i \< 0・j \< 0・n \< 0・i + n > len(b)・j + n > len(b) のどれかなら panic(OutOfRange{…})（検査は 1 か所 — 読むのは 2 つの区間の中だけ）。最初の食い違いで止まるので時間は一致の長さに依る（秘密の比較には使わない — 定数時間の比較は std/crypto/ct）

## AppendWord

```sober
@effects(panic)
func AppendWord(b mut []byte, v int, k int)
```

v の下位 k バイトを b の末尾に積む（v の最下位のバイトが先 — little-endian）。k \< 0 か k > 8 なら panic(OutOfRange{k, 8})。結果は byte(v & 0xff), byte((v >> 8) & 0xff), … を k 回 append したのと同じで、b が伸ばせる位置にあれば検査 1 回・書き 1 本で済む（ビットバッファのフラッシュ・可変長の整数の書き）
