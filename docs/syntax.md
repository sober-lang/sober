# 構文（v0 確定、2026-09-18）

`docs/language.md` の決定節とサンプル 2 本から起こした、PEG を書くための正。Go 仕様（The Go Programming Language Specification）の EBNF からの差分として書く。ここに無い規則は Go と同じ。

位置づけ: v0 確定（裁定 8 点は 7 節に決定として残す）。PEG を書くと曖昧さが 1〜2 個は見つかる前提で、修正はこの文書に棄てた案つきで書き戻す（design-dev.md「棄てた案と理由を一行残す」）。実装は「1 トークン、1 AST ノードずつ」で進めるが、目標の文法は先に固定する。

読み方: 消す / 変える / 足す の 3 リスト → EBNF → 裁定の記録 → fib 部分集合。

---

## 1. 字句（Go との差分）

Go と同じ: 識別子、整数 / 浮動小数 / 文字リテラル（n 進は `0x` / `0o` / `0b` + その基数の桁 — 接頭辞は小文字のみ・桁区切り `_` は無い・値は i64 に収まる範囲〔ビット模様 `0xffff…` の 64 bit 全域は拒否〕。2026-10-02 実装 — 値は int に畳み、綴りは fmt / AST JSON が保つ。浮動小数は 10 進だけ（2026-10-04 — language.md 37 節）: `数字+ "." 数字+ [指数]` か `数字+ 指数`（指数 = `e` / `E` + 任意の `+` / `-` + 数字+）— 小数点の両側に数字が要る（`1.` `.5` は無し）・16 進の浮動小数は無し・先頭 0 の規則は整数部に同じく掛ける（`0.5` は可・`01.5` は拒否）・型は float 固定。8 進は `0o755` のみ。旧形 `0755` は無い — 先頭が 0 の 10 進（`010`）は字句で拒否し `0o` へ誘導する（Go の旧来の 8 進と読み違えるため。それまでは 10 進として読んでいた）。決定 18。文字リテラルは ASCII 限定（2026-10-01 — language.md 33 節）: `'a'` は型なし整数定数、escape は `\n` `\t` `\r` `\0` `\\` `\'` のみ、非 ASCII は Rune の裁定まで拒否）、コメント `//` `/* */`、セミコロン自動挿入（行末が識別子・リテラル・`)` `]` `}` `?` なら `;` を挿す。`?` を追加）。予約語に `len` `shape` `println` `await` `freeze` `keys` `append` `delete` を含める（組み込みの再束縛不可。決定 16。`await` は 2026-09-18、`freeze` は 2026-09-19（language.md 22 節）、`keys` は 2026-09-28（同 22 節 — keysm の段）、`append` `delete` は 2026-09-30 の裁定で追加）。

| 追加トークン | 用途 |
|---|---|
| `\|>` | パイプ |
| `=>` | ラムダ |
| `<-` | for のジェネレータ束縛 `x <- xs`（Go のチャネル受信演算子としては使わない。チャネルは std の `Chan[T]` と `send` / `recv` 関数） |
| `?` | 後置: 伝播 / 包み替え。型位置: optional |
| `@` | 注釈の先頭 |
| `${` `}` | 文字列補間（`"..."` 内のみ。raw 文字列 `` ` `` では補間しない） |

| 追加キーワード | 用途 |
|---|---|
| `mut` | 再代入可能な束縛 |
| `union` | 閉じた variant の宣言 |
| `error` | 開いた variant（エラーラベル）の宣言。型名としても使う |
| `panic` | panic ラベルの宣言（`type L panic{…}`）と組み込みの `panic(L{…})`（2026-10-03 — キーワードに昇格。language.md 27 節） |
| `for` `yield` | ジェネレータ式 |
| `while` | 唯一の命令型ループ |
| `scope` `parallel` `spawn` `shield` | structured concurrency（`await` はキーワードでなく std 関数。決定 16 の再束縛不可に含める） |
| `defer` | Go と同じ綴り、意味はブロックスコープ |

削除キーワード: `var`（→ `mut`）、`interface`、`chan`、`go`、`select`、`goto`、`fallthrough`、`range`（`for` は generator のみ。`range(n)` は std 関数）、`map`（→ `map[K]V` の型構文は残す。キーワードとしては型構築子扱いで Go と同じ）。

---

## 2. 消す（Go にあって Sober に無い）

| Go の構文 | 行き先 | 根拠 |
|---|---|---|
| メソッド宣言 `func (r T) m()`、レシーバ、メソッド値 / 式 | 自由関数 + `\|>` | language.md 3 節 |
| `interface { ... }`、型アサーション `x.(T)`、型 switch `switch x.(type)` | 関数型フィールドの struct（辞書）、`union` + switch | 3 節、1 節 |
| struct タグ `` `json:"x"` `` | 注釈 `@`（型付き） | 10 節 |
| struct 埋め込み（匿名フィールド） | 持たない。メソッド昇格が無いので埋め込みの効用はフィールド昇格だけ。明示フィールドで書く | 3 節の帰結 |
| 匿名 struct 型 `struct{ a int }` の式位置での使用 | 持たない（名前付き宣言のみ。匿名 union を断つのと同じ理由） | 1 節 |
| `var x T`、`var x = e`、`var ( ... )` | `x := e`（const）、`mut x := e`。ゼロ値だけの宣言は持てる型に限り `mut x := T{}` と書く（実装 2026-09-27: 持てる型 = int / bool / T? / slice / map / string と、それらだけの struct。関数値・union・型パラメータは拒否） | 6 節、15 節 |
| `x++` `x--` | `x += 1`（`mut` のみ） | 6 節。形を 1 つに |
| `for` の 3 節形、`for range`、`for cond {}` | `for ... yield`（ジェネレータ）、文の位置のブロック形 `for x <- xs { }`（消費 — `for range` の鏡。整数範囲は `for i <- iter.Range(0, n) { }`）、`while cond {}`（状態機械） | 7 節、8 節 |
| `break` `continue`（ループ制御） | `while` 内で許す。inline ラムダ本体（`each` 等）・文形 for の本体からの `break` / `continue` は 8 節の非局所脱出として同じ綴りで許す（文形 for は実装済み 2026-09-28 — for 全体を label で包む。inline ラムダ本体は未実装）。yield 形の for 本体では禁止 | 7 節、8 節 |
| ラベル、`goto`、`fallthrough` | 持たない | — |
| switch の中の `break`（Go では switch を抜ける） | switch を囲むループを抜ける（移行の罠 — Go から写すと意味が変わる）。Sober の switch は式で fallthrough も無いので「switch を抜ける break」は意味を持たない。switch の残りを飛ばしたいなら腕を分ける（裁定 S1 2026-10-02） | language.md 13 節 |
| `go f()`、`chan T`、`<-ch`、`ch <- v`、`select` | `spawn`、std の `Chan[T]` / `send` / `recv` / `select` 関数 | 11 節 |
| `func(x int) int { ... }`（関数リテラル） | `(x int) => ...` ラムダのみ。関数リテラルの綴りを 2 つ持たない | 8 節 |
| `&x`、`*p`（アドレス取得・デリファレンス演算子） | 持たない。`*T` は型としてだけ残る（acquire / get が返すピン済み参照）。フィールドアクセスは自動デリファレンス | region-domain-pool.md 2, 4 節 |
| `panic(v)`（任意の値）`recover` | `panic(L{欄})` — L は `type L panic{…}` で宣言した panic ラベル（または組み込みの `Unreachable` / `InvariantBroken`）のリテラルだけ。`recover` は持たない。入力次第で起きる失敗はエラー値（2026-10-03 — language.md 27 節） | 13 節、27 節 |
| `iota` | 持たない。列挙は `union`（ペイロード無し variant）、番号が要るなら `const A, B = 1, 2` | 13 節の sum type 線引き |
| `new(T)`、`make` | std 関数 `make[T](n)`（決定 8） | region-domain-pool.md「直接の alloc は存在しない」 |
| `nil` を任意ポインタ / slice / map / interface に | `nil` は `T?` のみ。slice / map の空は空値 | 15 節 |
| 複数戻り値の「呼び出し結果をそのまま引数へ」`f(g())` | 持たない。多値は `:=` の分解、`return`、`\|>` の穴、switch の subject にのみ流せる | 2 節、4 節 |
| `switch` の `fallthrough`、`case` の複数値 `case 1, 2:` | 複数値 case は多値パターンの意味に変わる（`case v, nil:`）。同じ腕に複数の値を並べる Go の用法は `case 1 \| 2:` で書く | 1 節、13 節 |
| 名前付き戻り値 `(n int, err error)`、naked `return` | 持たない。`return` は必ず値を伴う | 決定 11 |
| if / switch の初期化文 `if v, ok := m[k]; ok {` | 持たない。1 行前に `:=`。`v, ok` イディオムは `T?` + flow typing で消える | 決定 12 |
| シャドーイング、`:=` の宣言 / 再代入混在 | シャドーイング禁止（コンパイルエラー。トップレベル名と同名のローカルも含む）。`:=` は左辺全部を新規宣言 | 決定 13 |
| `init()`、副作用 import `import _ "p"`、dot import `import . "p"` | 持たない。トップレベルの束縛は const 式のみ（実行時初期化なし） | 決定 14、design-dev.md 第 2 の審査基準 |
| 組み込み識別子の再束縛 `len := 3` | `len` `shape` `println` `await` `freeze` `keys` `bytes` `true` `false` `append` `delete` は予約語扱いで再束縛不可（ローカル束縛・型パラメータ・トップレベルの宣言の名前のすべて。検査は loader — 決定 13 と同じ置き場） | 決定 16・22・language.md 22・23・24 |
| `defer` の「引数は defer 時、本体は出口」の二段階評価 | 式全体を出口で評価（Zig） | 決定 17 |
| 旧 8 進リテラル `0755` | `0o755` のみ | 決定 18 |

---

## 3. 変える（綴りは Go、意味が違う）

| 構文 | Go | Sober |
|---|---|---|
| `if c { } else { }` | 文 | 式。両腕の型は双方向型検査で合わせる。`else` 無しは文位置のみ |
| `switch` | 文 | 式。subject は単値 / 多値 / union 値。case は値・多値パターン・union パターン。網羅は union / 多値 error でコンパイラ・analyzer が検査し、網羅なら `default` 不要 |
| ブロック `{ ... }` | 文の並び | 式位置では最後の式が値（if / switch の腕、ブロック式、ラムダ本体、scope）。文位置（`func` 本体・while 本体・defer・文位置の if / switch の腕の全文と、値位置のブロックの末尾以外）の式文は呼び出しだけ（`f(x)`・`x |> f()`・`f()?`、腕がまた文位置になる if / switch / ブロック）— 呼び出しの結果は捨ててよく、純粋な式（名前・演算・リテラル・添字等）の式文は拒否（Go 同型。裁定 2026-09-27。実装 src/stage1/exprstmt.zig — loader が build / check 共通に掛ける）。例外: main の本体の末尾は check の値位置（`*_pure` 例の Lean 突き合わせ） |
| `x := e` | 再代入可能 | 不変束縛。再代入は `mut x := e` で宣言した変数のみ |
| `defer e` | 関数スコープ | ブロックスコープ（Zig 意味論）。ブロック出口でインライン展開 |
| `T?`（新）/ `*T` | — / ポインタ | optional / ピン済み参照型。`*T` の値は式では作れない |
| `_` | 空識別子（破棄） | 束縛位置では破棄（Go と同じ）。`\|>` 右辺の直下引数位置では穴 |
| `[T]`（型パラメータ） | `[T any]` 制約つき | `[T]` のみ、制約構文なし。振る舞いは辞書引数 |
| 文字列 `"..."` | 補間なし | `${expr}` 補間あり |
| `return` | 関数から戻る | `func` 本体は `return` 必須（末尾式は戻り値にならない。決定 9）。ラムダ内の `return` は常に囲みの名前付き関数から戻る（inline ラムダのみ合法。ラムダ自身の値は末尾式。決定 10） |
| `type A = B` | 型の別名（右辺は任意の型・総称の別名も — 1.24） | 型宣言の別名だけ: 右辺は型宣言の名前（`N` / `ref.N`）・型パラメータなし・トップレベルだけ（決定 15 の改訂・language.md 32 節） |
| `func F(params) results`（本体なし） | 関数本体を別に（アセンブリで）与える宣言 | interface ファイル `.sobi` の中だけ（language.md 29 節 — 非展開の関数の署名）。`.sober` では拒否。文法は本体を省略可能なまま受け、拒否は AST 層（ファイル名が `.sobi` のときだけ許す） |

---

## 4. 足す（Go に無い）

| 構文 | 例 | 根拠 |
|---|---|---|
| パイプ | `xs \|> filter(p) \|> collect` / `f() \|> g(_, _)` | 4 節 |
| ラムダ | `(a, b) => a < b`、`u => u.id`、`(p Profile) => "..."`、`x => { ...; v }` | 3, 8 節 |
| 後置 `?` | `f()?`（伝播）、`f()? BadLine{line: n}`（包み替え） | 13 節 |
| `union` 宣言 | `type Lookup union { Hit { p Profile }; Miss { reason string } }` | 1 節 |
| `error` 宣言 | `type NotFound error { id int }` | 13 節 |
| for ジェネレータ | `for x <- xs if p(x); y <- ys(x) yield Pair{x, y}`、`for l <- lines(p) { ...; yield u }` | 7 節 |
| `while` | `while lo < hi { ... }` | 8 節 |
| scope | `scope { }`、`scope(timeout: 200 * time.ms) { }`、`parallel scope { }` | 11 節 |
| spawn / await | `spawn f(x)` → `Task[T]`、`await(t)?` | 11 節 |
| shield | `shield { ... }`（式ブロック。`defer shield { }` と合成） | 11 節 |
| 注釈 | `@pure`、`@errors(NotFound, Timeout)`、`@layout(c)`、`@recursion(depth: 8)`、`@noblock { }`、`@exhaustive`（関数 — 表の網羅。language.md 13 節の補）、`@secret(k)`（関数 — 仮引数の源）・`k []byte @secret`（struct の欄）・`@secret const`、`@bless`（関数 — std だけ。language.md 12 節「秘密の値の宣言」）、`@credential`（関数 / struct の欄 — std だけ）・`Fresh { … } @shared`（union の variant — std だけ）・`@bless(origin)`（関数 — std だけ。12 節「出所の依存」）、`@effects(io, !block…)`（関数の前置 / 名前付き関数型の後置 — 12 節「関数の効果の宣言」） | 10 節 |
| 名前付き引数 | `f(x, sep: ",")`、`scope(timeout: 200 * time.ms)`、`@json(name: "x")`。位置が先・名前が後、省略は `T?` 引数のみ、直接呼び出しと名前付き関数型のみ（決定 7） | 決定 7 |

---

## 5. EBNF（Go 仕様の記法。差分のある production のみ）

### 5.1 ソースファイル・宣言

```ebnf
SourceFile   = PackageClause ";" { ImportDecl ";" } { TopLevelDecl ";" } .
ImportDecl   = "import" ( ImportSpec | "(" { ImportSpec ";" } ")" ) .
ImportSpec   = [ identifier ] string_lit .                 (* 別名のみ。"_" と "." は無い（決定 14）。init() も無い *)
TopLevelDecl = { Annotation } ( ConstDecl | TypeDecl | FuncDecl | BindDecl ) .

Annotation   = "@" identifier [ "(" [ AnnotArgs ] ")" ] .   (* 名前は閉じた集合 — errors・noinline・layout・embed・exhaustive〔関数の印 — 表の網羅〕・secret〔関数は仮引数の名前の列（空にしない）・const は引数なし〕・bless〔関数 — 引数なしか `(origin)`〕・credential〔関数〕・effects〔関数 — 語・否定の語・名前付き関数型の名前の列〕ほか。知らない名前は文法の外 *)
AnnotArgs    = AnnotArg { "," AnnotArg } .
AnnotArg     = [ identifier ":" ] ConstExpr .            (* 名前付き / 位置。Argument と同じ並びで引数が const 式に限られるだけ *)

ConstDecl    = "const" IdentifierList "=" ExpressionList .   (* Go の ( ) グループ形は持たない *)
BindDecl     = [ "mut" ] IdentifierList ":=" ExpressionList .  (* トップレベルは右辺が const 式のみ、mut 不可（決定 14）。左辺は全部新規宣言、シャドーイング禁止（決定 13） *)

TypeDecl     = "type" identifier ( [ TypeParams ] TypeSpecBody | "=" TypeName ) .   (* "=" は型の別名（決定 15 の改訂 — language.md 32 節）: 右辺は型宣言の名前だけ・型パラメータなし・トップレベルだけ *)
TypeSpecBody = StructType | UnionType | ErrorType | PanicType | FuncType { Annotation } | Type .   (* FuncType の後置の注釈は `@errors(…)` と `@effects(…)`（名前付き関数型の契約 — language.md 13 節・12 節「関数の効果の宣言」— 順は問わず各 1 つ）。 最後は Go の defined type — 下地は int / bool に限る（language.md 32 節・宣言の位置で検査） *)
TypeParams   = "[" identifier { "," identifier } "]" .

StructType   = "struct" "{" { FieldDecl ";" } "}" .
FieldDecl    = IdentifierList Type { Annotation } .        (* タグなし。注釈は後置 — 今受けるのは struct の欄の `@secret` / `@credential` だけ（union の variant・error・panic の欄は注釈なし）。union の variant そのものは後置の `@shared` を受ける *)

UnionType    = "union" "{" { Variant ";" } "}" .
Variant      = identifier VariantBody .
VariantBody  = "{" { FieldDecl ";" } "}" .                 (* Hit { p Profile } / Null {} — 決定 2 *)

ErrorType    = "error" [ "{" { FieldDecl ";" } "}" ] .
PanicType    = "panic" [ "{" { FieldDecl ";" } "}" ] .     (* panic ラベル（language.md 27 節）。欄の型は int / byte / bool / string。型パラメータは持たない *)

FuncDecl     = "func" identifier [ TypeParams ] Signature [ Block ] .   (* Block は文位置: 値を返すなら return 必須（決定 9） *)
Signature    = Parameters [ Result ] .
Result       = "(" Type { "," Type } ")" | Type .        (* 名前付き戻り値は無い（決定 11） *)
Parameters   = "(" [ ParameterList [ "," ] ] ")" .
ParameterList = ParameterDecl { "," ParameterDecl } .
ParameterDecl = [ IdentifierList ] [ "..." ] Type .
(* 仮引数の Type の先頭の "mut" は mut 引数の印（language.md 26 節）。非コンテナ型にも付く — 仮引数位置だけ *)
```

### 5.2 型

```ebnf
Type         = TypeName [ TypeArgs ] [ "?" ] | TypeLit [ "?" ] | "(" Type ")" .
TypeArgs     = "[" TypeArg { "," TypeArg } "]" .
TypeArg      = Type | "(" Type "," Type { "," Type } ")" .   (* 多値の型は型引数の位置にだけ — `task.Handle[(T, error?)]`（P3b 残穴1）。std/task の Task の型引数の外は loader が拒否 — 一般の匿名タプル型は入れない（決定 4 の線のまま） *)
TypeLit      = ArrayType | SliceType | MapType | FuncType | PinnedType .
PinnedType   = "*" Type .                                 (* acquire / get の戻りにのみ現れる *)
FuncType     = "func" Signature .   (* 仮引数名は全部付けるか全部付けないか — Go と同じ。名前は型の同一性に入らず、名前付き関数型を通した名前付き引数〔決定 7〕だけが読む *)
(* InterfaceType, ChannelType, StructType(式位置), PointerType(演算子) は無い *)
```

### 5.3 文

```ebnf
Block        = "{" StatementList "}" .                    (* 末尾が式なら値を持つ *)
StatementList = { Statement ";" } .
Statement    = Declaration | SimpleStmt | ReturnStmt | BreakStmt | ContinueStmt
             | DeferStmt | WhileStmt | YieldStmt | AnnotatedBlock | Block .
Declaration  = ConstDecl | TypeDecl | BindDecl .

SimpleStmt   = ExpressionStmt | Assignment .
ExpressionStmt = Expression .                              (* 文位置: 値は捨てられない（未使用エラー）。unit 型のみ許す *)
Assignment   = ExpressionList assign_op ExpressionList .   (* 左辺は mut 束縛のみ *)
assign_op    = [ add_op | mul_op ] "=" .                   (* ++ -- は無い *)

ReturnStmt   = "return" [ ExpressionList ] .
BreakStmt    = "break" .   ContinueStmt = "continue" .     (* while 内、文形 for の本体（7 節）、または inline ラムダ本体（未実装） *)
DeferStmt    = "defer" Expression .                         (* 呼び出し / shield ブロック。式全体をブロック出口で評価（決定 17） *)
WhileStmt    = "while" Expression Block .
YieldStmt    = "yield" Expression .                         (* 生成器（式の位置の for）の本体の字句的内側のみ。文形 for の中なら囲む生成器へ。単値（決定 4） *)
AnnotatedBlock = Annotation Block .                         (* @noblock { ... } *)
```

### 5.4 式

優先順位（低 → 高）:

```
1  =>            ラムダ（右結合。本体は右へ最大延長）
2  |>            パイプ（左結合）
3  ||
4  &&
5  == != < <= > >=
6  + - | ^
7  * / % << >> &
8  単項  - ! ^
9  後置  call  index  selector  ?  (包み替え)  catch（末尾 — 呼び出しの直後だけ）
```

```ebnf
Expression   = Lambda | PipeExpr .
Lambda       = LambdaParams "=>" ( Expression | Block ) .   (* Block は式位置。中の return は囲みの名前付き関数から戻る（決定 10） *)
LambdaParams = identifier | "(" [ ParameterList ] ")" .   (* 型は省略可。双方向推論。型の前の `mut`（mut 仮引数）は task.Lease / task.NewLocal の窓だけ — loader の柵（2026-10-16） *)

PipeExpr     = OrExpr { "|>" PipeStage } .
PipeStage    = PostfixExpr [ "?" [ CompositeLit ] ] .      (* 穴 _ は PipeStage の呼び出し直下引数のみ。? は段の結果に掛かる *)

OrExpr       = AndExpr { "||" AndExpr } .   (* 以下 Go と同じ二項階層 *)

UnaryExpr    = PostfixExpr | unary_op UnaryExpr .
PostfixExpr  = PrimaryExpr { Selector | Index | Call | Try } [ Catch ] .   (* Catch は末尾の後置が Call のときだけ *)
Catch        = "catch" ( "return" [ ExpressionList ] | UnaryExpr ) .   (* f() catch -1   f() catch return -1   f() catch panic(Unreachable{})（catch 式 — language.md 13 節・決定 2026-10-02。
               二項演算子より強い。loader の固定テンプレートが多値の束縛と if に写す） *)
Try          = "?" [ CompositeLit ] .                       (* f()?   f()? BadLine{line: n} *)
Call         = [ TypeArgs ] "(" [ ArgumentList ] ")" .     (* readInt[int64](b, off, endian.little) *)
ArgumentList = Argument { "," Argument } [ "," ] .
Argument     = [ identifier ":" ] ( "mut" identifier { "." identifier } | Expression ) [ "..." ] .   (* 決定 7: 名前付きは位置の後にのみ。
               "mut" identifier は mut 引数への参照渡しの印（language.md 26 節）— 後続が "," / ")" のときだけ読み、
               `mut []T{...}` の composite literal と区別する。欄の経路 `mut x.f.g`（2026-09-28 解禁 — 26 節）は字句が隙間なく続くときだけ *)

PrimaryExpr  = Operand | Conversion | IfExpr | SwitchExpr | ForExpr | ScopeExpr
             | SpawnExpr | ShieldExpr | Block .
Operand      = Literal | OperandName | "(" Expression ")" | "_" .   (* _ は PipeStage 引数位置のみ有効 *)
Literal      = BasicLit | CompositeLit | InterpString .
InterpString = '"' { char | "${" Expression "}" } '"' .   (* 字句は "..." 全体で 1 トークン（補間の中の入れ子の文字列・raw 文字列・{ } を読み飛ばす。改行は補間の中でも不可）。式は cst_to_ast が部分文字列を 1 つの Expression として解析し直す。`\$` で `$` を書ける（R7 2026-09-27） *)
CompositeLit = LiteralType LiteralValue .                   (* Go と同じ。名前付き / 位置フィールド *)

IfExpr       = "if" Expression Block [ "else" ( IfExpr | Block ) ] .          (* 初期化文は無い（決定 12） *)
SwitchExpr   = "switch" [ ExpressionList ] "{" { CaseClause } "}" .             (* subject 無しは bool case の if-else 連鎖。初期化文は無い *)
CaseClause   = ( "case" PatternList | "default" ) ":" StatementList .
PatternList  = Pattern { "," Pattern } .                    (* 多値 subject は 1 値 1 パターン *)
Pattern      = "_" | identifier [ TypePattern ] | TypePattern | ConstExpr { "|" ConstExpr } .
TypePattern  = TypeName "{" [ FieldPatterns ] "}" .         (* NotFound{id}  BadLine{cause: strconv.Range{}} — 裁定 3 *)
FieldPatterns = FieldPattern { "," FieldPattern } .
FieldPattern = identifier [ ":" Pattern ] .

ForExpr      = "for" Generators ( "yield" OrExpr | Block ) .   (* yield の値は '|>' の手前まで — '|>' は for 式全体に掛かる（language.md 7 節）。
                                                                文の位置のブロック形は消費（文形 for — 7 節、2026-09-28）。文法は同じで位置で読み分ける *)
Generators   = Generator { ";" Generator } .
Generator    = IdentifierList "<-" Expression [ "if" Expression ] .   (* 決定 4: ガードは各ジェネレータ直後。
                                                                呼び出し形の生成元に付いた後置 `?`（`x <- g(a)?`）は、継続を足した後の呼び出しに付く —
                                                                失敗しうる生成元（language.md 7 節・2026-10-13）。文法は変えない: 判定は g の宣言の署名
                                                                （仮引数が実引数より 1 つ多く最後が関数型・結果が error? 1 つ）。包み替え `? L{…}` は
                                                                条件の位置の composite literal の規則（決定 5）どおり括弧で `x <- (g(a)? L{…})` *)

ScopeExpr    = [ "parallel" ] "scope" [ "(" AnnotArgs ")" ] Block .
SpawnExpr    = "spawn" Expression .
ShieldExpr   = "shield" Block .
```

### 5.5 Go から変えていないもの（確認用）

演算子と literal の字句、`package` / `import`、`const` の untyped constant 意味論、slice / map / 配列の型構文と index / slice 式、`...` 可変長引数、`return` の多値、composite literal の名前付き / 位置フィールド、`//` `/* */`、セミコロン自動挿入（`?` を末尾トークン集合に追加）。

---

## 6. サンプルとの食い違い（v0 で片付けるもの）

| 箇所 | 状態 | 処置 |
|---|---|---|
| サンプル 1 の気づき「新構文は `type X = A \| B`」 | 1 節で `union` ブロックに決定済み。気づきの文が古い | 直した |
| サンプル 1 の `Some(p)` / `None` | 15 節で `p` / `nil` に決定済み | 直した |
| サンプル 1 の `Fetch union { Ok { p Profile }; ... }` と 16 節の `Value union { Null; Bool bool; ... }` | variant の本体が「フィールド列」と「単一型」の 2 形 | 決定 2: フィールド列のみ。16 節の `Value` を直した |
| case の形: `case Ok{p}` / `case _, NotFound{id}` / `case _, e NotFound{}` / `case Missing{}` | 束縛付き型パターン `e NotFound{}` と、フィールド分解 `NotFound{id}` が混在 | 決定 3: 両方とも正。混在ではなく併用可 |
| `readInt[int64](..., .little)` | `.Ident` 略記は未決定 | 決定 6: 入れない。サンプル 2 を `endian.little` に直した |
| `scope(timeout: 200ms)` | 名前付き引数と単位付きリテラル `200ms` は未決定 | 決定 7: 名前付き引数は一般規則、`200 * time.ms`。サンプル 2 を直した |

---

## 7. 裁定（2026-09-18。8 点の初期裁定 + 読み手優先の再裁定 9〜10 + Go 自身の歪みの処置 11〜18）

1. ~~ラムダの引数と本体~~ → 決定 2026-09-18: `x => e`、`(x, y) => e`、`(x T, y U) => e`、`() => e`（thunk。`defer` と遅延値に要る）。本体は式かブロック（最後の式が値）。戻り値型の明示は持たない。双方向推論で決まらなければ名前付き関数にする（14 節「内部は自由、公開は名前付き」）。棄てた案: `(x int) int => e` — 関数リテラルの綴りが増え、公開境界は名前付き必須なので書く場面がない

2. ~~union の variant 本体~~ → 決定 2026-09-18: フィールド列のみ。`Num { v float }`、ペイロード無しは `Null {}`。構築は Go の composite literal（`Num{1.0}` / `Num{v: 1.0}`）、パターンは `Num{v}` の 1 形。棄てた案: 単一型の略記 `Num float` — 構築 `Num(1.0)` とパターン `Num(x)` の綴りが 1 系増える

3. ~~switch の case パターン~~ → 決定 2026-09-18: 多値 subject は 1 値 1 パターン（`case v, nil:`、`case _, err:`、`case _, NotFound{id}:`）。値全体の束縛と型パターンの同時指定は `case _, e NotFound{}:`（識別子の後に型パターン。Go の `name Type` と同じ並び。フィールド分解と両立 `e NotFound{id}`）。定数 case の複数値は `case 1 | 2:`（`case 1, 2:` は多値パターンの意味）。棄てた案: `e @ NotFound{}`（Rust。記号が増える）、値全体の束縛を持たない（包み替え `Internal{cause: e}` で元の値が要る）

4. ~~for ... yield の区切り~~ → 決定 2026-09-18: ジェネレータ間は `;`、`if` ガードは各ジェネレータ直後に任意個（`for x <- xs if p(x); y <- ys(x) if q(y) yield ...`。内側を走らせる前に落とせる。Scala と同じ）。`yield` は単値のみ。ペアは struct を作る（`Iter[(T, U)]` は匿名タプル型になり 2 節と衝突）。ジェネレータ側の多値束縛 `k, v <- entries(m)` は分解点なので許す。棄てた案: `,` 区切り（多値束縛 `x, y <- pairs` と見分けにくい）、末尾ガード 1 つ

5. ~~後置 `?` と包み替えの曖昧さ~~ → 決定 2026-09-18: `?` は行末なら `;` を挿すトークン集合に入る（改行で伝播、同じ行に `Label{...}` が続けば包み替え）。if / switch の条件中の包み替えは Go の「条件中の composite literal は括弧が要る」規則を継ぐ（`if (f()? Label{}) { }`）。この括弧規則は Go の歪み（C 由来）のうち意図的に残した唯一の例外（明記 2026-09-27）— 11〜18 の処置で他の歪みは切ったが、これは代替が無い（条件の `{` とブロックの `{` を字句で分ける手段が他に無い）ので残した。パイプ段の `?` は段の結果に掛かる（`a |> f()? |> g()` = `(a |> f())? |> g()`）。包み替えのラベルは必ず `{ }` 付き（`Label{}`。裸の識別子は次の文の先頭と区別できない）

6. ~~`.Ident` 列挙略記~~ → 決定 2026-09-18: 入れない。`Endian.little{}` と書き、長ければ std が `const little = Endian.little{}` を置いて `endian.little`。棄てた案: Zig 式の `.little`（期待型から補う） — 双方向推論の「期待型が無い場所でエラー」という規則が増え、Go の目で読めない。後から足せる糖衣で、外すのは難しい

7. ~~名前付き引数と単位付きリテラル~~ → 決定 2026-09-18: 名前付き引数を一般の関数呼び出しに入れる。`f(x, sep: ",")` は composite literal の `key: value` と同じ見え方で Go の目で読め、LLM が書くコードの引数順の取り違えが減る。規則は 5 つ:
   - 並び: 位置引数が先、名前付きが後。混在可、名前付きの後に位置は置けない
   - 省略: デフォルト値式は持たない。省略できるのは型が `T?` の引数だけで、省略時は `nil`（15 節「省略可能な設定は `T?`」を引数に当てる。デフォルト式の評価順・副作用の規則を足さない）
   - 呼べる相手: `func` 宣言の直接呼び出しと、名前付き関数型（14 節。Go 同様に引数名を書ける）を通した呼び出し。ラムダ・辞書フィールドの関数値は位置のみ（Swift と同じ線）
   - パイプの穴: `_` は位置引数としてのみ。`x |> f(_, sep: ",")` は可、`f(sep: _)` は不可
   - 契約: 公開関数の引数名は公開 API の一部で、改名は破壊的変更（唯一の実コスト。契約を宣言に集める言語なので筋は通る）。名前付き関数型の仮引数名も同じく公開 API の一部（改名は semver の機械導出の名前の欄に数える — 仮引数名は型の同一性に入らないので、型の互換の欄とは別。language.md 14 節）
   - 実装（2026-10-02 夜 — 第 1 便・夜間の仮進行 = 朝の裁定待ち）: loader の固定テンプレート（src/compiler/loader/namedargs.sober — 名前 → 位置・省略された `T?` は `nil`。以降の層は位置引数だけの木を読み、コア / Lean は無変更）。名前付き同士は宣言の順に限る（Swift と同じ — 並べ替えを許すと評価の順が字面の順とずれる。緩めるのは互換）。名前付きの無い呼び出しも、足りない仮引数が全部 `T?` なら `nil` を足す。写す相手は func 宣言の直接呼び出し（`f(…)`・`ref.F(…)`・`f[T](…)`）とパイプ段（穴 `_` のある段）。名前付き関数型の変数を通した呼び出しは第 2 便（仮引数名を知るのに局所の型が要る）。拒否は diag.NamedArg（6 種 — 例 named_args_*）
   - 第 2 便（裁定 2026-10-03 — 実装 2026-10-03）: 名前付き関数型を通した呼び出し。
     - 表記: 関数型の仮引数名は Go と同じくどこに書いてもよい（名前付き関数型の右辺・関数型の仮引数・欄・局所の型）。名前は全部付けるか全部付けないか（混在は parse の拒否 — 例 named_fn_type_mixed）。まとめ書き `func(a, b int)` も Go と同じ
     - 呼べる相手: 名前付き引数が書けるのは、呼び先の式の静的な型が仮引数名を持つ名前付き関数型のときだけ（この項の文言どおり — 名前つきの関数型リテラルの値・辞書の欄の関数値は位置だけ）。名前は呼び先の静的な型から取る（値の実体の仮引数名・ラムダの仮引数名とは照合しない）
     - 並び・省略・重複・パイプは第 1 便と同じ規則・同じ診断。名前付きの無い呼び出しも、足りない仮引数が全部 `T?` なら `nil` を足す
     - 実装: 型を知る層の固定テンプレート（src/compiler/desugar/namedval.sober — 表層型検査器が呼び先の名前付き関数型を引き、名前 → 位置・`nil` を写した木を app の loadEntry が check / build / analyzer へ渡す。コア / Lean は無変更）。loader は func 宣言を引けない名前付きの呼び出しを素通しにし、kind 1 の拒否はこちら（文言「func 宣言か、仮引数名を持つ名前付き関数型の値」）。写す呼び出しの候補が無いプログラムでは表層型検査器を走らせない。例 named_fn_args・負例 named_fn_args_literal / _nonames / _dup / _unknown / _field
     - 棄てた案: 名前つきの関数型リテラルの値にも名前付き引数を許す（内部の関数型の引数でも名前で呼べるが、項の文言を広げ、辞書の欄の関数値との境界が揺れる — 緩めるのは互換）・仮引数名を名前付き関数型の右辺にだけ書ける（Go からの写しで躓く — 14 節で公開境界は名前付き型に限るので実害は文書性だけ）
   - `scope(timeout: ...)` と注釈引数はこの一般規則の適用例（特別扱いが消える）。`200ms` は持たず `200 * time.ms`（const 式で畳まれる）。棄てた案: 注釈と scope だけに限る（初案。「Go に無い」だけでは理由が弱い）、デフォルト値式、単位付きリテラル（字句規則とユーザー定義単位の話が始まる）

8. ~~組み込み関数~~ → 決定 2026-09-18: 組み込みは `len` と `shape[T]` の 2 つ（コンパイラが知る const 式。16 節の命名規約）。`append` `copy` `delete` `min` `max` `make` は std 関数（`append` は `|>` で流せる普通の関数、`make[T](n)` は割り当てを std に集める）。`cap` は落とす。`println` は Phase 1 の仮置き組み込みで、std の io ができたら移す

---

9. ~~関数本体の末尾式~~ → 決定 2026-09-18: `func` 本体は `return` 必須。Go の読み手は `return` を探して出口を数えるので、その走査を残す。末尾式が値になるのは式形（if / switch の腕、ブロック式、ラムダ本体、scope）だけ。棄てた案: 関数本体も末尾式（初案。「規則が一つで済む」という統一性の理由で、読み手の走査を削っていた）

10. ~~ラムダ内の `return` の行き先~~ → 決定 2026-09-18: 常に囲みの名前付き関数から戻る。inline でないラムダに書いたら拒否。ラムダ自身の値は末尾式。読み手は `each` が inline かを知らなくても `return` の意味を決められる（Go が range-over-func でループ本体を構文に残した理由への、構文を増やさない側からの答え）。帰結: 早期脱出が要る複数文のラムダは名前付き関数に切り出す（language.md サンプル 2 の Handler を `lookup` に切り出した）。棄てた案: `return` はラムダ局所で非局所は別綴り（Kotlin の `return@label`。綴りが増え、局所 / 非局所の読み分けが残る）。~~`for x <- xs { }` 糖衣（8 節で既に棄却）~~ → 2026-09-28 に文形 for として採用（language.md 7 / 8 節 — 本体の `return` はこの決定どおり囲みの関数から戻る）

### Go 自身が Go way（書く方は面倒でも読む方が楽）に反している構文の処置（決定 2026-09-18）

Go の綴りを継ぐと一緒に持ち込むものを、Go 自身のポリシーで採点して切った。目的は Go から離れることではなく、Go が C 由来か互換性維持で残した歪みを継がないこと。

11. 名前付き戻り値と naked return は持たない。書く側の省力で、読み手は戻り値を宣言まで探しに戻る。Go 自身のスタイルガイドも避けろと言う。`return` は必ず値を伴う
12. if / switch の初期化文は持たない。1 行に宣言と分岐を詰める書き手の都合で、スコープが `if` に閉じる特殊規則が要る。`v, ok` イディオムは `T?` + flow typing で消える（`v := m[k]; if v != nil {`）
13. シャドーイング禁止、`:=` は左辺全部を新規宣言。内側スコープの `x, err := f()` が外の `err` を隠す Go 最古典のバグと、「一部は宣言、一部は再代入」の混在規則を消す。`?` で `err` の再束縛はほぼ消えるので摩擦は小さい。Zig と同じ
    トップレベル名にも及ぶ（裁定 2026-09-27）: ローカル束縛（`:=`・仮引数・ラムダ引数・for の生成元・
    型パターンの束縛）は同じ package のトップレベル名（const・func・型・union の variant）と同名にできない。
    import の参照名（alias か path 末尾）と同名のローカル束縛、トップレベルの型名と同名の
    型パラメータ（func / type の `[T]`）も同様にエラー（追加裁定 2026-09-27）。
    検査は loader（src/compiler/loader/localnames.sober — 凍結 Zig 版は src/stage1/localnames.zig）で一度だけ行い、build と check が同じ規則を共有する。
    主役交代（2026-09-28）で Sober 版の loader への移植が漏れ、受理が広がっていた（reaudit 第 2 弾 A0 で発見 → 2026-09-30 に移植。
    決定 16 の再束縛不可と variant 名の一意もここで検査する — どちらも以前はどの実装にも無かった。決定 16 の導入に伴い、Zig ≡ Sober の照合に
    使う boot 起点の木（keys が組み込みになる前）の局所名 keys は gates が α 改名して照合する — scripts/alpha16.ts・意味不変）。
    棄てた案: (B) const だけ禁止 — func 名のローカルは関数値参照（V3-3）と読み違える、
    (C) Go 同様トップレベルは対象外 — パターン位置の裸の識別子の意味がスコープ次第で変わる

    | 隠す側 | 隠される側 | 扱い |
    |---|---|---|
    | ローカル束縛（`:=`・仮引数・ラムダ引数・for の生成元・型パターンの束縛） | ローカル束縛 | エラー（従来） |
    | 同上 | トップレベル名（const・func・型・variant） | エラー（裁定 A 2026-09-27） |
    | 同上 | import の参照名 | エラー（追加裁定 2026-09-27） |
    | 型パラメータ | トップレベルの型名 | エラー（追加裁定 2026-09-27） |

14. `init()`、副作用 import、dot import は持たない。トップレベルの束縛は const 式のみ。ソースを読んでも実行されることが分からない隠れた実行の代表で、design-dev.md 第 2 の審査基準に正面から反する。実行時初期化が要るなら `main` から明示的に呼ぶ。const 式の範囲は language.md 未決「const 式の範囲」の決定が正（辞書 const への拡張は 25 節）。
15. ~~型エイリアス `type A = B` は v0 では持たない。`=` 1 文字で nominal かどうかが変わる。定義型のみ。移行用途で要ることが分かったら再考~~ → 改訂 2026-10-22（report-1041 の実需 — std の実装の型を std/internal へ下ろしたまま公開の名前を残す・report-1043）: 型宣言の別名に限って持つ（`type A = B` — B は型宣言の名前だけ・型パラメータなし・トップレベルだけ。language.md 32 節）。「`=` 1 文字」への答え: 定義型の右辺（int / bool）と別名の右辺（型宣言の名前）が交わらないので、取り違えはほぼ宣言の位置の拒否で大声で落ちる。棄てた案: `alias` キーワード（Go の読み手の予想から外れる）・型式の別名（Go 同等 — 実需なし）
16. `len` `shape` `println` `await` `freeze` `keys` `bytes` `true` `false` `append` `delete` は予約語扱いで再束縛不可（`bytes` / `true` / `false` は 2026-09-26、language.md 23・24 節。`keys` は 2026-09-28、language.md 22 節。`append` / `delete` は 2026-09-30 — 局所に束縛すると build は組み込み、check は束縛と読む順序の食い違いが観測できた。入れて順序を観測不能にした）。Go は組み込み識別子を隠せる（`len := 3`）。`await` は 2026-09-18 の裁定（9 節）で、`freeze` は 2026-09-19（language.md 22 節）でこちらへ
17. `defer` は式全体をブロック出口で評価（Zig）。Go の「引数は defer 時、本体は出口」の二段階は読み手に見えない。const 既定で差が出る場面は稀
18. 8 進リテラルは `0o755` のみ。旧形 `0755` は継がない

（2026-09-19 追加。language.md 22 節）

19. `[]T` / `map[K]V` は imm がデフォルト、可変は `mut []T` / `mut map[K]V`。Go はコンテナが常に可変。const 既定（決定 6）と極性を揃え、string ≒ imm byte slice の特称も消える。`freeze(x)` が `mut` 側から imm 側への一方通行
20. map は参照型でない。ヘッダは slice と同型の値で、再ハッシュ後も旧ヘッダ経由の読みは旧テーブルを見る（決定的なエイリアス観測）。Go の「全エイリアスが同一実体」を継がない
21. map のイテレーション順序は挿入順で決定的。Go のランダム化（順序依存の抑止）は analyzer の lint に振る。オラクル駆動・決定的スケジューラの思想と揃える

見て残したもの: subject 無し `switch { case a > 0: }`（if-else 連鎖の 2 つ目の書き方だが長い分岐で読み手が得をする。Go 自身も vet で咎めていない）、条件中の composite literal に括弧が要る規則（C 由来の歪みだが代替が無い。意図的に残した唯一の例外 — 決定 5）、`package` 節（ディレクトリ名と重複するがファイル単体で読める）。

## 8. fib 部分集合（Phase 1 の最初の目標）

裁定 1〜8 に依存しない範囲で fib を通す。ここまでで PEG を書き始められる。

```
package main

func fib(n int) int {
    return if n < 2 { n } else { fib(n - 1) + fib(n - 2) }
}

func main() {
    println(fib(10))
}
```

必要な production: `PackageClause`、`FuncDecl`（型パラメータ無し）、`Parameters`、`Result` 単値、`Block`、`ReturnStmt`、`IfExpr`（式位置、腕は末尾式）、二項演算 `< + -`、`Call`、整数リテラル、識別子。

次に足す順（各 1 コミット、parse → print → parse の不動点で検証）: `:=` 束縛 → `mut` と `while` と代入 → 多値 return と `:=` 分解 → struct 宣言と composite literal → `switch` 式 → `|>` → ラムダ → `union` と型パターン → `for ... yield` → `?` → 注釈 → scope / spawn。

---

## 9. PEG 化で出た点（2026-09-18、`src/stage1/grammar.zig`）

v0 を PEG に起こして分かったこと。EBNF の意図は変えず、構文と AST 層の分担を確定した。棄てた案は一行。

| 点 | 処置 | 層 |
|---|---|---|
| `error` はキーワードだが型位置に立つ（`type Timeout error`、戻り値 `(int, error)`） | `Type` に `"error"` を直接足す。行末の `error` にもセミコロンを挿す（Go では識別子なので挿入対象。1 節の末尾トークン集合に `error` を追加） | 字句・構文 |
| `panic` のキーワード化（2026-10-03 — panic ラベル） | `type L panic` の行末にもセミコロンを挿す（`error` と同じ — 末尾トークン集合に `panic` を追加）。式の位置の `panic` は組み込みの名前として読む（呼び出しの callee だけ — 値としては使えない） | 字句・構文 |
| 条件位置（if / while / switch subject / for の `<-` 右辺とガード）の composite literal | 決定 5 どおり読まない。PEG に文脈が無いので式の二項階層を 2 系統生成（`expression` / `c_expression`）。括弧の中は通常に戻る | 構文 |
| `case 1 \| 2:` の選択と二項 `\|` | 同じ木になる（定数パターンは `c_expression`。subject 無し switch の bool case も同じ規則）。AST 層でパターン最上位の `\|` 連鎖を選択と解釈。ビットマスク値が要るなら括弧 `case (A \| B):`。棄てた案: 単項式の並びに限る（`case a > 0:` が書けない） | AST |
| Call の `[TypeArgs]` と index | 同形（`f[int](x)` は index + call）。型検査で解決 — callee がジェネリック関数で、index が型名なら型適用（V3-3。当面 1 個まで） | 型検査 |
| 注釈を自分の行に書く | `@pure` の `pure` は識別子なので行末で `;` が入る。`(Annotation [";"])*` と直後の自動 `;` を許す。棄てた案: 宣言と同じ行に限る（複数注釈が横に伸びる） | 構文 |
| `_`（破棄・穴・`import _`） | 識別子トークン。束縛位置の破棄、`\|>` 段の穴、`import _` の拒否（決定 14）は AST 層 | AST |
| ラムダ引数 `(a, b) => e` | `Parameters` を流用するので「型 a と型 b」とも読める（Go の `func(a, b)` と同じ） | AST |
| `Statement` の `Block` | `ExpressionStmt` → `Block` で読めるので独立の選択肢にしない | 構文 |
| ブロック末尾の多値 `x, y, nil` | 無い（2 節: 多値は `:=` / `return` / `\|>` の穴 / switch subject のみ）。scope から 2 値を返すなら struct | 確認 |
| `await` | 裁定（2026-09-18）: std 関数。`send` / `recv` / `select` と同列で、決定 16 の再束縛不可に含める。language.md のサンプル節に `\|> map(await)` と関数値で渡す例が既にあり、キーワードだと書けない。`spawn` は引数式を新タスクで遅延評価するためキーワードが必須だが、`await` は `Task[T]` を受ける普通の関数で済む（非対称の理由）。PEG から `await_expr` を削除し通常の Call で読む。棄てた案: キーワードのまま spawn と対にする（関数値として渡せなくなる） | 設計 |
| 定数パターンの位置 | `Pattern` の `ConstExpr` は条件位置の式として読む（`c_expression`。`case P{1}:` は型パターン側で読まれる） | 構文 |
| パターン位置の裸の識別子 `case v, nil:` | `ConstExpr` として読まれる。AST 層で、既知の名前なら比較、未知なら subject の値の束縛。既知 = ローカル束縛・事前宣言の `true` / `false`（language.md 23 節）・現 package のトップレベル名（const・func・型・variant — ast.Pkg.hasTopName）。ローカルとトップレベル名は同名にできない（決定 13）ので一意に決まる。他 package の名前は `pkg.N` の選択子なので常に比較。修正 2026-09-27: 以前はトップレベル const が束縛として読まれ `case Local:` が全値に一致していた。棄てた案: 束縛は常に `IDENT type_pattern` の形に限る（`case _, err:` が書けない） | AST |
| ラムダを受ける関数の印 | 無い。関数型引数を持つ関数を呼び出し点に展開するかは生成方式（language.md 8 節）。AST 層は `FuncDecl.expands`（関数型引数を持つ）を導出するだけ。棄てた案: `@inline` 注釈（一度入れて戻した） | AST |
| struct の分割代入 `{min, max} := f()`（language.md 19 節、決定 2026-09-18） | switch の struct パターンを `:=` 左辺に再利用。型名は書かない（右辺の戻り値型から双方向推論。コア AST には明示で残る）。文頭の `{` はブロック式と衝突するが PEG の順序選択で分割代入を先に試す。`_` での部分分割可 | 構文・AST |

未着手（字句）: ~~浮動小数~~（2026-10-04 — 1 節・language.md 37 節）。~~文字~~（2026-10-01 — language.md 33 節）・~~`0x` / `0o` / `0b` リテラル~~（2026-10-02 — 1 節）。~~`${ }` 補間~~（R7 2026-09-27）。
