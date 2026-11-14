# std/json

日本語

`import "std/json"`

JSON（RFC 8259）の読みと決定的な印字（[language.md 16 節](../language.md)）。文書は平らな表 Doc（ノードの番号で子を指す — compiler/ の ast.Tree と同じ形）に置き、触るのは1段階だけ開くビューのunion View（json.At）— 各段階のswitchに網羅が要る（雑に読む手段が構成的に無い — [language.md 16 節](../language.md)）。値の木（再帰の union Value）は書きの側: 組んで Encode[json.Value] で書く・Doc の節から Tree で開く。

```sober
d := json.Parse(b)?                       // 全量・入れ子の深さは MaxDepth まで
switch json.At(d, json.Root(d)) {
case json.ViewObject{names, vals}: …          // 子はノードの番号 — json.At(d, vals[i]) で1段階ずつ開く
…
}
s := json.Format(d, json.Root(d))        // 決定的（空白なし・フィールドはソースの順・数は字句のまま）
```

数（Num）は字句のまま持つ（解釈はデコードの点まで遅らせる — 64 ビットを超える整数・精度・金額を float に黙って丸めない）。重複したキーは拒否（防御の既定 — パーサ間で解釈が割れる攻撃面。Go は後勝ち）。不正な UTF-8 は文書のどこでも拒否（Go は U+FFFD に置き換え）

## Decode

```sober
func Decode[T](d Doc, n int) (T, error?)
```

ノードnを struct T に読む。フィールドの名前 = JSONのキー。Tのフィールドに書ける型はint・float・bool・string・struct・`[]U`・`U?`（U は前のどれか か json.Value — 裸のjson.Valueのフィールドは拒否: unionはゼロ値を持たない）。T = json.ValueはTreeと同じ（値の木）。欠けたフィールドはMissing（`U?` のフィールドだけ欠けとnullをnilで受ける）・種類の合わないノードはWrongType・intのフィールドの範囲外はIntOutOfRange。余ったフィールドは無視する

例:

```sober
// examples/json_decode.sober
package main

// shape[T] の最小形（language.md 16 節2）: json.Decode[T](d, n) がstruct T（フィールド = int・float・bool・string・入れ子のstruct・[]T・T?）へ変換する。
// 欠けたフィールドはjson.Missing・T? のフィールドだけ欠けとnullがnil・余ったフィールドは無視・型の合わない節はjson.WrongType・intに収まらない数はjson.IntOutOfRange

import "std/convert"
import "std/io"
import "std/iter"
import "std/json"

type Point struct {
    x int
    y int
}

type Shape struct {
    name string
    closed bool
    scale float
    points []Point
    tags []string
    note string?
    origin Point?
}

func show(s Shape) {
    println("${s.name} closed=${if s.closed { "yes" } else { "no" }} scale=${convert.FormatFloat(s.scale)} points=${len(s.points)} tags=${len(s.tags)}")
    for i <- iter.Range(0, len(s.points)) {
        println("  (${s.points[i].x}, ${s.points[i].y})")
    }
    nt := s.note
    if nt != nil {
        println("  note: ${nt}")
    }
    showOrigin(s.origin)
}

// T? のフィールドは仮引数で受けて絞る（フィールドから束縛したstructのT? の絞り込みはcheckが拒否する）
func showOrigin(o Point?) {
    if o != nil {
        println("  origin: (${o.x}, ${o.y})")
    }
}


func main() {
    b, rerr := io.ReadStdin()
    if rerr != nil {
        return
    }
    d, err := json.Parse(b)
    if err != nil {
        println("parse error")
        return
    }
    xs := switch json.At(d, json.Root(d)) {
    case json.ViewArray{items}: items
    default: []int{}
    }
    for i <- iter.Range(0, len(xs)) {
        s, derr := json.Decode[Shape](d, xs[i])
        switch derr {
        case nil: show(s)
        case json.Missing{pos, field}: println("#${i}: missing ${field} (object at ${pos})")
        case json.WrongType{pos, want}: println("#${i}: want ${want} at ${pos}")
        case json.IntOutOfRange{pos}: println("#${i}: int out of range at ${pos}")
        }
    }
}
```

## DecodeWith

```sober
func DecodeWith[T](d Doc, n int, rename map[string]string) (T, error?)
```

Decodeのフィールド名の対応つき版（rename = フィールド名 → JSONのキー・入れ子のstructのフィールドにも同じ辞書が掛かる・対応の無いフィールドはフィールド名のまま）

## Missing

```sober
type Missing error {
    pos int
    field string
}
```

T? でないフィールドfieldが無い（pos = オブジェクトの位置）

## WrongType

```sober
type WrongType error {
    pos int
    want string
}
```

ノードの種類がフィールドの型に合わない（want = 期待したJSONの種類: object・array・string・number・int・bool）

## IntOutOfRange

```sober
type IntOutOfRange error {
    pos int
}
```

intのフィールドの数がintに収まらない（小数・指数を含む数はWrongType{want: "int"}）

## NeedObject

```sober
@errors(WrongType)
@effects()
func NeedObject(d Doc, n int) (int, error?)
```

ノード n がオブジェクトなら n（でなければ WrongType）

失敗のラベル: [`WrongType`](#wrongtype)

## Need

```sober
@errors(Missing)
@effects()
func Need(d Doc, n int, key string) (int, error?)
```

オブジェクトnのフィールドkeyの値のノード（無ければMissing）

失敗のラベル: [`Missing`](#missing)

## NeedAt

```sober
@errors(Missing)
@effects()
func NeedAt(d Doc, n int, key string, hint int) (int, error?)
```

Needに手掛かりの位置hintを足したもの（GetAtと同じ — 変換の関数はフィールドの宣言の位置を渡す）

失敗のラベル: [`Missing`](#missing)

## IsNull

```sober
@effects()
func IsNull(d Doc, n int) bool
```

ノード n が null か

## Items

```sober
@errors(WrongType)
@effects()
func Items(d Doc, n int) ([]int, error?)
```

配列 n の要素のノード（配列でなければ WrongType）

失敗のラベル: [`WrongType`](#wrongtype)

## ParseString

```sober
@errors(WrongType)
@effects()
func ParseString(d Doc, n int) (string, error?)
```

文字列 n の中身

失敗のラベル: [`WrongType`](#wrongtype)

## ParseBool

```sober
@errors(WrongType)
@effects()
func ParseBool(d Doc, n int) (bool, error?)
```

true / false

失敗のラベル: [`WrongType`](#wrongtype)

## ParseInt

```sober
@errors(WrongType, IntOutOfRange)
@effects()
func ParseInt(d Doc, n int) (int, error?)
```

整数の字句（小数点・指数なし）の数を int に（範囲外は IntOutOfRange）

失敗のラベル: [`WrongType`](#wrongtype)・[`IntOutOfRange`](#intoutofrange)

## ParseFloat

```sober
@errors(WrongType)
@effects()
func ParseFloat(d Doc, n int) (float, error?)
```

数を binary64 に（最近接・偶数への丸め — convert.ParseFloat。あふれは IntOutOfRange でなく WrongType{want: "float"}）

失敗のラベル: [`WrongType`](#wrongtype)

## Encode

```sober
func Encode[T](v T) string
```

vのJSON（空白なし・フィールドは宣言の順・`U?` のnilはnull）。Tの範囲はDecodeと同じ + 裸のjson.Valueのフィールド・T = json.Value（値の木 — 印字はFormatと同じ規則）。float の NaN / ±Inf は panic(NotFinite)

例:

```sober
// examples/json_encode.sober
package main

// shape[T] の逆向き（language.md 16 節2）: json.Encode[T](v) がstructをJSONに書く（空白なし・フィールドは宣言の順・U? のnilはnull）。
// EncodeWith / DecodeWithはフィールド名 → JSONのキーの対応の辞書つき（同じ辞書で両方向）。Encode → Parse → Decodeの往復で元に戻る

import "std/json"

type Point struct {
    x int
    y int
}

type Shape struct {
    name string
    closed bool
    scale float
    points []Point
    tags []string
    note string?
    origin Point?
}

func main() {
    s := Shape{name: "tri \"A\"", closed: true, scale: 1.5, points: []Point{Point{x: 0, y: 0}, Point{x: 3, y: -4}}, tags: []string{"a", "b\nc"}, note: nil, origin: Point{x: 7, y: 9}}
    j := json.Encode[Shape](s)
    println(j)
    r := map[string]string{"points": "pts", "x": "lon", "y": "lat"}
    j2 := json.EncodeWith[Shape](s, r)
    println(j2)
    // 往復: 書いたものを読んで戻す（rename も同じ辞書で）
    d, err := json.Parse(bytes(j2))
    if err != nil {
        println("parse error")
        return
    }
    t, derr := json.DecodeWith[Shape](d, json.Root(d), r)
    if derr != nil {
        println("decode error")
        return
    }
    println(json.Encode[Shape](t) == j)
}
```

## EncodeWith

```sober
func EncodeWith[T](v T, rename map[string]string) string
```

Encodeのフィールド名の対応つき版（renameはDecodeWithと同じ辞書 — 同じ辞書で両方向に使える）

## NotFinite

```sober
type NotFinite panic {
    field string
}
```

JSON に書けない float（NaN・±Inf）を Encode に渡した

## KeyOf

```sober
@effects()
func KeyOf(rename map[string]string, field string) string
```

フィールドfieldのJSONのキー（renameの対応が無ければフィールド名のまま。renameは省略可能な引数〔map[K]V?〕にしない — mapのT? は実引数に map を渡すと build が拒否・絞って使うと check が拒否する言語の穴がある。対応なしは空の map）

## Put

```sober
@effects()
func Put(o mut builder.Builder[byte], s string)
```

s のバイト列をそのまま積む（Put… / Done で JSON を手で組み立てる例: examples/json\_put.sober）

## PutKey

```sober
@effects()
func PutKey(o mut builder.Builder[byte], key string, first bool)
```

フィールドの頭（2つ目以降は ','・キーの文字列・':'）

## PutString

```sober
@effects()
func PutString(o mut builder.Builder[byte], s string)
```

s を JSON の文字列（引用符つき — `"` `\` と制御文字だけをエスケープ）として積む

## PutInt

```sober
@effects()
func PutInt(o mut builder.Builder[byte], n int)
```

nの10進をbuilderへ直に積む（FormatIntのstringを経ない）。割るのは定数だけ（10・10^8・10^16 — 乗算に下りる）: 8桁ずつのチャンクを下の桁から1ワードに詰めて（1バイト / 桁）上の桁から積む（棄てた形: 桁の数の10の冪pでn / p — 割る数が変数で桁ごとにidiv）

## PutBool

```sober
@effects()
func PutBool(o mut builder.Builder[byte], b bool)
```

b を true / false の綴りで積む

## PutFloat

```sober
@effects(panic)
func PutFloat(o mut builder.Builder[byte], f float, field string)
```

fの最短の往復表現（NaN・±Infはpanic — field = フィールド名）

## Done

```sober
@effects()
func Done(o mut builder.Builder[byte]) string
```

積んだバイト列の string

## PutValue

```sober
@effects()
func PutValue(o mut builder.Builder[byte], x Value)
```

値の木vをoに書く（json.Encode[json.Value] の変換と、フィールドの型がjson.Valueのstructの変換が呼ぶ部品）。印字の規則はFormatと同じ（空白なし・フィールドは並びの順・数は字句のまま）。再帰の深さ = 木の深さ（Treeで開いた木ならMaxDepthまで）

## MaxDepth

```sober
const MaxDepth = 1000
```

入れ子の深さの上限（配列とオブジェクトの開き — 防御の上限。読みは明示のスタックで再帰しないので、深さはスタックの長さにだけ効く）

## Syntax

```sober
const Syntax = 1
```

BadJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## BadUtf8

```sober
const BadUtf8 = 2
```

BadJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## TooDeep

```sober
const TooDeep = 3
```

BadJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## DuplicateKey

```sober
const DuplicateKey = 4
```

BadJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## BadJson

```sober
type BadJson error {
    pos int
    kind int
}
```

読めなかった位置（src 上のバイトオフセット）と種類（Syntax・BadUtf8・TooDeep・DuplicateKey）

## Doc

```sober
type Doc struct {
    src []byte
    esc []byte
    kind []int
    a []int
    b []int
    pos []int
    kids []int
    seal sealed
}
```

読んだ文書: ノードの表（番号 = 添字。子は親より先に並ぶ — 根は最後）。書き換えない値なので task の子へそのまま渡せる（例: examples/json\_put.sober）。作れるのは Parse だけ（証人 — 外から作った表を At に渡させない）:非公開の型の封のフィールドsealがあるので、外からはcompositeに書けない（部分リテラルは拒否・sealedの値は外で書けない）。型は公開のまま（引数の型にjson.Docと書ける — shape[T] の変換の関数も）。フィールドの読みは塞いでいない（裸のintでAtなしには解釈できない — 規律の面だけ）。再訪条件: 可視性の細分（構築のみ私有・フィールドの私有）が入ったら封を外してそれに置き換える

## Value

```sober
type Value union {
    Null {}
    Bool { v bool }
    Number { lit string }
    String { v string }
    Array { items []Value }
    Object { names []string; vals []Value }
}
```

JSON の値の木（再帰の union — 組んで Encode[json.Value] で書く・Doc の節から Tree で開く）。数は字句のまま

## View

```sober
type View union {
    ViewNull {}
    ViewBool { v bool }
    ViewNumber { lit string }
    ViewString { v string }
    ViewArray { items []int }
    ViewObject { names []string; vals []int }
}
```

ノード 1 つのビュー（子はノードの番号 — json.At で開く）

## Root

```sober
@effects()
func Root(d Doc) int
```

根のノード

## Pos

```sober
@effects()
func Pos(d Doc, n int) int
```

ノード n の src 上の位置（値の先頭のバイト）

## At

```sober
@effects()
func At(d Doc, n int) View
```

ノード n を 1 段開く

## Tree

```sober
@effects()
func Tree(d Doc, n int) Value
```

ノード n を根とする部分木を値の木に開く。節は子が親より先に並び、部分木は [最初の子孫, n] の連続した区間なので、区間を前から 1 回歩いて下から組む（再帰しない — 深さ MaxDepth の文書でもスタックと region の深度を使わない）

## Get

```sober
@effects()
func Get(d Doc, n int, key string) int?
```

オブジェクトのノードnのフィールドkeyの値のノード（nがオブジェクトでない・フィールドが無ければnil）

## GetAt

```sober
@effects()
func GetAt(d Doc, n int, key string, hint int) int?
```

Getに手掛かりの位置hintを足したもの: hint番目のフィールドのキーを先に見て、外れたら線形に探す（shape[T] の変換の関数はフィールドの宣言の位置を渡す — 宣言と同じ順の JSON なら 1 回の比較で当たる）キーの比較は手で展開してある（Docのフィールドを局所に取ってから回す — 旧keyIsはDocを値で渡す呼び出しをフィールドごとに払っていた）。見る順 = 手掛かり（t = -1）→ 0から線形

## Parse

```sober
@errors(BadJson)
@effects()
func Parse(b []byte) (Doc, error?)
```

b 全体を 1 つの JSON の値として読む（前後の空白は可・後ろに何か残れば Syntax）

失敗のラベル: [`BadJson`](#badjson)

## Format

```sober
@effects()
func Format(d Doc, n int) string
```

ノードnの決定的なJSON（空白なし・フィールドはソースの順・数は字句のまま・文字列は '"' '\\' と制御文字だけをエスケープ）
