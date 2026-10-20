# std/utf8

日本語

`import "std/utf8"`

検査済みの UTF-8 のビュー（View — 全体を 1 回検査すれば、文字境界で切った部分列は検査し直さずに string にできる）。UTF-8 の妥当性の検査そのもの（Valid / IndexInvalid / InvalidUtf8）は std/strings、`string(b)` の裏方は std/internal/utf8

## View

```sober
type View struct {
    b []byte
    seal sealed
}
```

中身が有効な UTF-8 と検査済みのバイト列（型つき証人）。作れるのは Check だけ: 非公開の型の封の欄 seal があるので外からは composite に書けない（部分リテラルは拒否・sealed の値は外で書けない）。型は公開（引数の型に utf8.View と書ける — json.Doc と同じ形）。全体を 1 回検査すれば、文字境界で切った部分列は全部有効（有効な列を境界で切ると両側とも有効）なので、Str は境界の 2 バイトを読むだけで string を返す— 行ごとに検査し直さない

## Check

```sober
@errors(strings.InvalidUtf8)
func Check(b []byte) (View, error?)
```

b 全体を検査して View にする（不正なら最初の不正なシーケンスの位置の InvalidUtf8 — string(b) と同じ位置）

失敗のラベル: `strings.InvalidUtf8`

## Bytes

```sober
func Bytes(v View) []byte
```

View のバイト列（読むだけ）

## Str

```sober
@errors(strings.InvalidUtf8)
func Str(v View, s int, i int) (string, error?)
```

v の [s, i) を検査し直さずに string にする。s と i が文字境界でなければ strings.InvalidUtf8{pos: 境界でない側}（範囲外の添字は slice と同じく panic）

失敗のラベル: `strings.InvalidUtf8`

## CHECK_GRAIN

```sober
const CHECK_GRAIN = 1048576
```

大きい入力の Check を区間に割って並列に検査するときの大きさ（バイト）。区間の大きさは入力の大きさだけで決まる（ワーカー数に依らない — 区間の数 = 長さ / CHECK\_GRAIN）。CHECK\_PAR\_MIN 未満は逐次のまま（区間 1 つの検査 ≈ 数百万命令に対し task の器は ≈ 1,000 命令 — 区間が 2 つ以上になる長さから割る）

## CHECK_PAR_MIN

```sober
const CHECK_PAR_MIN = 2097152
```

大きい入力の Check を区間に割って並列に検査するときの大きさ（バイト）。区間の大きさは入力の大きさだけで決まる（ワーカー数に依らない — 区間の数 = 長さ / CHECK\_GRAIN）。CHECK\_PAR\_MIN 未満は逐次のまま（区間 1 つの検査 ≈ 数百万命令に対し task の器は ≈ 1,000 命令 — 区間が 2 つ以上になる長さから割る）
