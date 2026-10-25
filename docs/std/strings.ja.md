# std/strings

日本語

`import "std/strings"`

Go の strings パッケージが仕様のオラクル。string は不透明なので、中身はバイト列ビュー（bytes(s)）越しに見る。位置はすべて bytes(s) 上のバイトオフセット（Go と同じ）

## HasPrefix

```sober
@effects()
func HasPrefix(s string, prefix string) bool
```

s が prefix で始まるかを返す

## HasSuffix

```sober
@effects()
func HasSuffix(s string, suffix string) bool
```

s が suffix で終わるかを返す

## Index

```sober
@effects()
func Index(s string, substr string) int
```

substr が s に最初に現れる位置を bytes(s) 上のバイトオフセットで返す。無ければ -1。substr が空なら 0

## Contains

```sober
@effects()
func Contains(s string, substr string) bool
```

substr が s に含まれるかを返す（空の substr は常に含まれる）

## Count

```sober
@effects()
func Count(s string, substr string) int
```

s に含まれる substr の重ならない出現数を返す。substr が空なら s のコードポイント数 + 1（Go と同じ。コードポイント数は継続バイト〔0b10xxxxxx〕でないバイトの数 — 妥当な UTF-8 を前提）

## Cut

```sober
@effects()
func Cut(s string, sep string) (string, string, bool)
```

s を最初の sep の前と後に割る（Go の strings.Cut — 無ければ s・""・false）。割った 2 つは検査し直さない: 妥当な s の中で妥当な sep にバイト列として一致した位置は文字の頭（sep の頭は継続バイトでない）、一致の末尾も文字の頭（完結した列の直後に継続バイトは来ない）— 自己同期。`bytes(s)` に落として切って `string(…) catch` で戻す回り道が要らない

## CutLast

```sober
@effects()
func CutLast(s string, sep string) (string, string, bool)
```

s を最後の sep の前と後に割る（無ければ s・""・false — Cut の最後の出現版。検査し直さない理由は Cut と同じ）

## TrimPrefix

```sober
@effects()
func TrimPrefix(s string, prefix string) string
```

s が prefix で始まればそれを外した残り、でなければ s（Go の strings.TrimPrefix — 残りは prefix の末尾から始まるので文字の頭）

## TrimSuffix

```sober
@effects()
func TrimSuffix(s string, suffix string) string
```

s が suffix で終わればそれを外した残り、でなければ s（Go の strings.TrimSuffix — 残りは suffix の頭で終わるので文字の境目）

## LastIndex

```sober
@effects()
func LastIndex(s string, substr string) int
```

substr が s に最後に現れる位置を bytes(s) 上のバイトオフセットで返す。無ければ -1。substr が空なら len(bytes(s))（Go の strings.LastIndex と同じ）

## Split

```sober
@effects()
func Split(s string, sep string) []string
```

s を sep の出現ごとに割った片の列（Go の strings.Split と同じ）。sep が無ければ [s]・s が空で sep が空でなければ [""]。sep が空なら 1 文字（コードポイント — UTF-8 の列）ずつに割る（s が空なら空の列）。片は検査し直さない（Cut と同じ自己同期の理由）

## Fields

```sober
@effects()
func Fields(s string) []string
```

s を ASCII の空白の連なりで割った空でない片の列（Go の strings.Fields — 空白だけ / 空なら空の列）。空白は ASCII の 6 つだけ（Unicode の空白は片の中身）

## TrimSpace

```sober
@effects()
func TrimSpace(s string) string
```

s の頭と尻の ASCII の空白を外した残り（Go の strings.TrimSpace — Unicode の空白は外さない）

## Replace

```sober
@effects()
func Replace(s string, old string, new string, n int) string
```

s の old の重ならない出現を前から n 個 new に置き換えた string（Go の strings.Replace — n \< 0 なら全部・n == 0 なら s）。old が空なら s の頭と各文字（コードポイント）の後ろに new を差す（Go と同じ — 差す位置は文字の境目なので結果は妥当な UTF-8）

## ToLower

```sober
@effects()
func ToLower(s string) string
```

s の ASCII の大文字（'A'..'Z'）を小文字にした string（Go の strings.ToLower の ASCII の部分 — 非 ASCII の文字はそのまま。変わる所が無ければ s）

## ToUpper

```sober
@effects()
func ToUpper(s string) string
```

s の ASCII の小文字（'a'..'z'）を大文字にした string（Go の strings.ToUpper の ASCII の部分 — 非 ASCII の文字はそのまま。変わる所が無ければ s）

## EqualFold

```sober
@effects()
func EqualFold(s string, t string) bool
```

s と t が ASCII の大文字小文字を同一視して等しいか（Go の strings.EqualFold の ASCII の部分 — 非 ASCII のバイトは完全一致で比べる。Go は Unicode の simple folding〔'É' ≡ 'é'・K〔U+212A〕≡ k・ſ ≡ s〕でも等しいとするが、ここでは等しくない）

## IndexByte

```sober
@effects()
func IndexByte(s string, c byte) int
```

c が s に最初に現れる位置を bytes(s) 上のバイトオフセットで返す。無ければ -1

## Arena

```sober
type Arena struct {
    seed mut []byte
}
```

string のコピー先の region を表す（region 多相の seed の慣用句）。seed は空の mut ヘッダで、mut slice の append はヘッダの region へ書くので「その region への確保権」として働く。Arena を宣言した region に string を置き直したいとき（深い位置で作った string を外側の Pool / map / 表に入れる等）に使う:

```sober
mut a := strings.Arena{}
...
t := strings.Clone(mut a, s)   // t は a の region にある s のコピー
```

同じ seed からの 2 回目以降の append は必ずコピーになる（[language.md 21 節](../language.md)）ので、Clone の結果どうしが重なることはない

## Clone

```sober
@effects()
func Clone(a mut Arena, s string) string
```

s のバイト列を a の region へコピーした string を返す（コピーのコストはソースに見える — 境界コピー = 明示イディオム）

## Join

```sober
@effects()
func Join(ps []string, sep string) string
```

ps を sep で繋いだ string（Go の strings.Join と同じ）。片の長さの和を 1 回だけ写す — 素直な `s = s + sep + p` の繰り返しは写しが積もる（先端一致の concat の in-place 成長はまだ無い）。積みは 1 本の列の先端なので写しが起きない

## InvalidUtf8

```sober
type InvalidUtf8 error {
    pos int
}
```

不正な UTF-8（pos = 最初の不正なシーケンスの先頭バイトのオフセット）

## IndexInvalid

```sober
@effects()
func IndexInvalid(b []byte) int
```

最初の不正なシーケンスの位置、妥当なら -1

## Valid

```sober
@effects()
func Valid(b []byte) bool
```

b 全体が有効な UTF-8 か（IndexInvalid(b) \< 0 と同じ）
