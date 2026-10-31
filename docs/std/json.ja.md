# std/json

日本語

`import "std/json"`

JSON（RFC 8259）の読みと決定的な印字（[language.md 16 節](../language.md)）。文書は平らな表 Doc（ノードの番号で子を指す — compiler/ の ast.Tree と同じ形）に置き、触るのは 1 段だけ開くビューの union Value（json.At）— 各段の switch に網羅が要る（雑に読む手段が構成的に無い — [language.md 16 節](../language.md)）。再帰の union にしないのはコアに再帰型が無いため（形式化の箱「ジェネリック union 段 (3) 再帰」— 入ったら再訪）。

```sober
d := json.Parse(b)?                       // 全量・入れ子の深さは MaxDepth まで
switch json.At(d, json.Root(d)) {
case json.Object{names, vals}: …              // 子はノードの番号 — json.At(d, vals[i]) で 1 段ずつ開く
…
}
s := json.Format(d, json.Root(d))        // 決定的（空白なし・欄はソースの順・数は字句のまま）
```

数（Num）は字句のまま持つ（解釈はデコードの点まで遅らせる — 64 ビットを超える整数・精度・金額を float に黙って丸めない）。重複したキーは拒否（防御の既定 — パーサ間で解釈が割れる攻撃面。Go は後勝ち）。不正な UTF-8 は文書のどこでも拒否（Go は U+FFFD に置き換え）

## Decode

```sober
func Decode[T](d Doc, n int) (T, error?)
```

ノード n を struct T に読む。欄の名前 = JSON のキー。T の欄に書ける型は int・float・bool・string・struct・`[]U`・`U?`（U は前のどれか）。欠けた欄は Missing（`U?` の欄だけ欠けと null を nil で受ける）・種類の合わないノードは WrongType・int の欄の範囲外は IntRange。余った欄は無視する

例:

```sober
// examples/json_decode.sober
package main

// shape[T] の最小形（language.md 16 節 2）: json.Decode[T](d, n) が struct T（欄 = int・float・bool・string・入れ子の struct・[]T・T?）へ写す。
// 欠けた欄は json.Missing・T? の欄だけ欠けと null が nil・余った欄は無視・型の合わない節は json.WrongType・int に収まらない数は json.IntRange

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

// T? の欄は仮引数で受けて絞る（欄から束縛した struct の T? の絞り込みは check が拒否する）
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
    case json.Array{items}: items
    default: []int{}
    }
    for i <- iter.Range(0, len(xs)) {
        s, derr := json.Decode[Shape](d, xs[i])
        switch derr {
        case nil: show(s)
        case json.Missing{pos, field}: println("#${i}: missing ${field} (object at ${pos})")
        case json.WrongType{pos, want}: println("#${i}: want ${want} at ${pos}")
        case json.IntRange{pos}: println("#${i}: int out of range at ${pos}")
        }
    }
}
```

## DecodeWith

```sober
func DecodeWith[T](d Doc, n int, rename map[string]string) (T, error?)
```

Decode の欄名の対応つき版（rename = 欄名 → JSON のキー・入れ子の struct の欄にも同じ辞書が掛かる・対応の無い欄は欄名のまま）

## Missing

```sober
type Missing error {
    pos int
    field string
}
```

T? でない欄 field が無い（pos = オブジェクトの位置）

## WrongType

```sober
type WrongType error {
    pos int
    want string
}
```

ノードの種類が欄の型に合わない（want = 期待した JSON の種類: object・array・string・number・int・bool）

## IntRange

```sober
type IntRange error {
    pos int
}
```

int の欄の数が int に収まらない（小数・指数を含む数は WrongType{want: "int"}）

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

オブジェクト n の欄 key の値のノード（無ければ Missing）

失敗のラベル: [`Missing`](#missing)

## NeedAt

```sober
@errors(Missing)
@effects()
func NeedAt(d Doc, n int, key string, hint int) (int, error?)
```

Need に手掛かりの位置 hint を足したもの（GetAt と同じ — 写しの関数は欄の宣言の位置を渡す）

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
@errors(WrongType, IntRange)
@effects()
func ParseInt(d Doc, n int) (int, error?)
```

整数の字句（小数点・指数なし）の数を int に（範囲外は IntRange）

失敗のラベル: [`WrongType`](#wrongtype)・[`IntRange`](#intrange)

## ParseFloat

```sober
@errors(WrongType)
@effects()
func ParseFloat(d Doc, n int) (float, error?)
```

数を binary64 に（最近接・偶数への丸め — convert.ParseFloat。あふれは IntRange でなく WrongType{want: "float"}）

失敗のラベル: [`WrongType`](#wrongtype)

## Encode

```sober
func Encode[T](v T) string
```

v の JSON（空白なし・欄は宣言の順・`U?` の nil は null）。T の範囲は Decode と同じ。float の NaN / ±Inf は panic(NotFinite)

例:

```sober
// examples/json_encode.sober
package main

// shape[T] の逆向き（language.md 16 節 2）: json.Encode[T](v) が struct を JSON に書く（空白なし・欄は宣言の順・U? の nil は null）。
// EncodeWith / DecodeWith は欄名 → JSON のキーの対応の辞書つき（同じ辞書で両方向）。Encode → Parse → Decode の往復で元に戻る

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

Encode の欄名の対応つき版（rename は DecodeWith と同じ辞書 — 同じ辞書で両方向に使える）

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

欄 field の JSON のキー（rename の対応が無ければ欄名のまま。rename は省略可能な引数〔map[K]V?〕にしない — map の T? は実引数に map を渡すと build が拒否・絞って使うと check が拒否する言語の穴がある。対応なしは空の map）

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

欄の頭（2 つ目以降は ','・キーの文字列・':'）

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

n の 10 進を builder へ直に積む（FormatInt の string を経ない）。割るのは定数だけ（10・10^8・10^16 — 乗算に下りる）: 8 桁ずつの塊を下の桁から 1 語に詰めて（1 バイト / 桁）上の桁から積む（棄てた形: 桁の数の 10 の冪 p で n / p — 割る数が変数で桁ごとに idiv）

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

f の最短の往復表現（NaN・±Inf は panic — field = 欄名）

## Done

```sober
@effects()
func Done(o mut builder.Builder[byte]) string
```

積んだバイト列の string

## MaxDepth

```sober
const MaxDepth = 1000
```

入れ子の深さの上限（配列とオブジェクトの開き — 防御の上限。読みは明示のスタックで再帰しないので、深さはスタックの長さにだけ効く）

## Syntax

```sober
const Syntax = 1
```

InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## BadUtf8

```sober
const BadUtf8 = 2
```

InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## TooDeep

```sober
const TooDeep = 3
```

InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## DuplicateKey

```sober
const DuplicateKey = 4
```

InvalidJson の kind（形の誤り・不正な UTF-8・MaxDepth を超えた入れ子・オブジェクトのキーの重複）

## InvalidJson

```sober
type InvalidJson error {
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

読んだ文書: ノードの表（番号 = 添字。子は親より先に並ぶ — 根は最後）。書き換えない値なので task の子へそのまま渡せる（例: examples/json\_put.sober）。作れるのは Parse だけ（証人 — 外から作った表を At に渡させない）:非公開の型の封の欄 seal があるので、外からは composite に書けない（部分リテラルは拒否・sealed の値は外で書けない）。型は公開のまま（引数の型に json.Doc と書ける — shape[T] の写しの関数も）。欄の読みは塞いでいない（裸の int で At なしには解釈できない — 規律の面だけ）。再訪条件: 可視性の細分（構築のみ私有・欄の私有）が入ったら封を外してそれに置き換える

## Value

```sober
type Value union {
    Null {}
    Bool { v bool }
    Number { lit string }
    String { v string }
    Array { items []int }
    Object { names []string; vals []int }
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
func At(d Doc, n int) Value
```

ノード n を 1 段開く

## Get

```sober
@effects()
func Get(d Doc, n int, key string) int?
```

オブジェクトのノード n の欄 key の値のノード（n がオブジェクトでない・欄が無ければ nil）

## GetAt

```sober
@effects()
func GetAt(d Doc, n int, key string, hint int) int?
```

Get に手掛かりの位置 hint を足したもの: hint 番目の欄のキーを先に見て、外れたら線形に探す（shape[T] の写しの関数は欄の宣言の位置を渡す — 宣言と同じ順の JSON なら 1 回の比較で当たる）キーの比較は手で展開してある（Doc の欄を局所に取ってから回す — 旧 keyIs は Doc を値で渡す呼び出しを欄ごとに払っていた）。見る順 = 手掛かり（t = -1）→ 0 から線形

## Parse

```sober
@errors(InvalidJson)
@effects()
func Parse(b []byte) (Doc, error?)
```

b 全体を 1 つの JSON の値として読む（前後の空白は可・後ろに何か残れば Syntax）

失敗のラベル: [`InvalidJson`](#invalidjson)

## Format

```sober
@effects()
func Format(d Doc, n int) string
```

ノード n の決定的な JSON（空白なし・欄はソースの順・数は字句のまま・文字列は '"' '\\' と制御文字だけをエスケープ）
