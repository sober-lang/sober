# 値指向: Soberの中心にある考え方

Soberは値指向のプログラミング言語です。プログラムが名前で扱うのは値と、書き換える可変の束縛だけです。番地や参照を値として持ち運ぶ手段は、言語にありません。

この文書は、値指向とは何かを1本で説明します。次の順に書きます。

1. 定義
2. 既存のパラダイムとの違い
3. `mut` と `@effects` の意味
4. 値指向を成り立たせている仕組み
5. 値指向から説明できる設計判断
6. 先行する考え方との位置
7. 「それだとできないのでは」という疑問への答え

正確な規則は[言語仕様](spec/README.ja.md)に、設計の柱は[DESIGN](../DESIGN.ja.md)に、個々の判断の「なぜ」は[設計ノート](design-notes/README.md)にあります。

## 定義

値指向を、この文書では次の意味で使います。

- プログラムが名前で扱うのは値です。場所（番地・参照・オブジェクトの同一性）を値として取り出し、保存し、渡す手段はありません。仕様の型の一覧に、ポインタや参照の型はありません（[2章](spec/02-types.ja.md)）
- 不変の値は、コピーしたか共有したかをプログラムから観測できません。これは最適化の都合ではなく、言語の約束です（[language.md 21節](language.md)・[31節](language.md)）
- 変更は書けます。書き換える場所は、`mut` を付けた束縛の名前と、そこからたどるフィールドで書きます

2つ目の性質があるので、値をどう渡すか・どのregionに置くかを処理系が選べます。選び方を変えても、プログラムの意味は変わりません。

可変のコンテナ（`mut []T`・`mut map[K]V`）は同一性を持ちます（[9章M-3](spec/09-memory.ja.md)）。この同一性は束縛・structのフィールド・配列の要素・mapを経て自由にコピーでき、コピーした先のどこからでも同じ中身に書けます（別名）。不変の値について成り立つ「コピーしたか共有したかを観測できない」という約束は、可変のコンテナには今は及びません。別名は書けます。これは値指向の定義から外れる箇所で、無くす方向で設計を進めています（1.0までの課題）。呼び出しの境界を越えて書き換えの許可を持ち出す形のうち、検査が拒否するものがあります。mut仮引数の中身を返す形と、値になるラムダがmutの束縛を捕捉する形です。次の節で書きます。すべての形を拒否しているわけではありません。たとえば、別名になった2つの束縛を同じ呼び出しのmut実引数に渡す形は受理されます。

## 既存のパラダイムとの違い

関数型・手続き型・オブジェクト指向・データ指向という名前は、Soberの中心を言い当てません。この文書では、違いを1つの軸で見ます。利用者が名前で扱うのが、場所か値か、という軸です。

| | 名前で扱うもの | 変更 |
|---|---|---|
| 手続き型（C） | 場所。番地とメモリの並びが言語に見える | 場所への書き込み |
| オブジェクト指向（Java） | 場所。オブジェクトの同一性とmonitorが言語に見える | オブジェクトの状態の書き換え |
| 関数型 | 値 | 変更を手放すか、言語の端に寄せる |
| Sober | 値 | `mut` の束縛と、`mut` で渡した呼び出しの中で書ける |

言語の歴史は、プログラムに観測を許す範囲を広げてきた歴史として読めます。一度見せた観測は、使う人が現れた時点で取り下げられない約束になります（[先行研究のノート「読み方」](design-notes/related-work.md)）。Soberは場所を観測の面に出さず、値と変更だけを見せます。

データ指向とは対立しません。表と添字でデータを組む書き方は、Soberでも素直に書けます（後の「グラフや循環のあるデータ構造は書けないのでは」）。

## mutと@effectsは許可を書く

### mutは参照の値ではない

仮引数の型の先頭の `mut` は、呼び手の可変の場所を、その呼び出しの間だけ書き換えてよいという許可です。呼び出し点にも `mut` を書きます（[3章V-4](spec/03-values.ja.md)）。

```sober
// examples/tour_06_mut.sober
package main

// Tour 6: mut arguments and freeze (docs/guide/tour.md)

// A function that rewrites the caller's mut local says mut on the parameter and at the call site
func push3(xs mut []int, v int) {
    xs = append(xs, v)
    xs = append(xs, v)
    xs = append(xs, v)
}

type Counter struct {
    n int
}

func bump(c mut Counter) {
    c.n += 1
}

func main() int {
    mut xs := mut []int{}
    push3(mut xs, 7)
    println(len(xs))
    mut c := Counter{n: 0}
    bump(mut c)
    bump(mut c)
    println(c.n)
    // freeze when done building — from then on it can be shared as immutable
    ys := freeze(xs)
    println(ys[0] + ys[1] + ys[2])
    return 0
}
```

出力:

```
3
2
21
```

仕様はmut引数の意味を「呼び手の可変の場所への参照を受ける」と書いています（V-4）。ただし、この参照は値になりません。次の規則があるので、書き換えの許可を呼び出しの外へ持ち出す手段がありません。

- mut仮引数の中身を、returnの値・他への代入・フィールド・appendの要素に置けない（[3章V-6](spec/03-values.ja.md)）
- 値になるラムダは、mutの束縛を捕捉できない（[5章F-10・F-16](spec/05-functions.ja.md)）。捕捉できるのは、呼び出し点へ展開されるラムダだけ
- mutの値を返せるのは、mut仮引数か関数型の仮引数を持つ関数だけ（[language.md 26節](language.md)）
- 同じ呼び出しのmut実引数どうしは重ならない。mutとimmの実引数が重なれば、immの側は呼び出しの前の値を見る（[3章V-5](spec/03-values.ja.md)）

### Rustの `&mut` との違い

Rustの `&mut T` は型を持つ値です。変数に入れ、structに格納し、関数から返せます（structに格納するには寿命の注釈 `'a` が要ります）。参照はいつまで有効かという寿命を型で表す必要があり、構造体に持たせる場合は注釈が要ります（[Rust公式の本4章](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html)）。

Soberの `mut` には、持ち運べる実体がありません。許可は呼び出し点で与えられ、呼び出しが終われば消えます。だから寿命の注釈が要りません。

### 実例: 大きな引数の渡し方を変えても、意味は変わらなかった

大きな不変のstructの渡し方を、値のコピーから番地の受け渡しに変えたことがあります。対象は8ワードを超えるimmのstruct・union・`T?` のうち、mapを含まない型です（[ir.md 6節](ir.md)）。言語の規則は1行も変わっていません。immの実引数は呼び出し点の値を見る、という規則（V-5）が、コピーでも番地でも同じに成り立つからです（[language.md 22節](language.md)）。

渡し方が変わっても意味が変わらないことは、定義の2つ目の性質の帰結です。

### @effectsも同じ形

関数が外の世界に何をしうるか（`block`・`io`・`panic`・`nondet`）は、解析器が呼び出しのグラフから導きます（[12章A-15](spec/12-annotations.ja.md)）。`@effects(…)` はその上限の宣言で、導いた結果が宣言に収まるかを `sober check` が検証します（A-16）。

```sober
// examples/effects_annot.sober（抜粋）
// Step の値は io をしない約束（このラムダたちはこの契約と照合される）
type Step func(x int) int @effects(!io)

// 否定形: 純さの主張（将来 io や panic が入ったら止まる）
@effects(!io, !block, !panic, !nondet)
func double(x int) int {
    return x * 2
}
```

`mut` は値への書き換えの範囲を、`@effects` は外の世界への作用の範囲を、関数の署名に書きます。どちらも「何をしてよいか」を書くもので、場所を指すものではありません。

## 値指向を成り立たせている仕組み

### region: 寿命はブロックが決める

全部のブロックがregion（割り当ての領域）です。関数の本体・式ブロック・if / switchの分岐・ループの本体（反復ごとに新しいregion）が、それぞれregionを持ちます。値は今いるregionに置かれ、ブロックを出るとregionごとまとめて返ります（[9章M-1](spec/09-memory.ja.md)）。

寿命が構文から決まるので、所有権や借用を利用者が書くことはありません。GCもありません。

### 境界でのコピー

regionの境界を出る値（return・早期return・break・式ブロックの出口）は、残る側のregionへ中身ごとコピーされます（[9章M-2](spec/09-memory.ja.md)）。外の可変の場所への代入も、行き先のregionへコピーします（M-3）。外のregionが中のregionを指すことが起きないので、解放済みの領域を指す形が作れません（[安全のノート](design-notes/safe.md)）。

```sober
// examples/block_escape.sober
package main

// 式ブロックの中で作った string / slice を末尾値で外へ返す例。
// ブロックの出口は暗黙のラベルへの脱出で、jumpと同じ境界コピー（ブロックのregionの中身を親の最内regionへコピーしてからpop）。
// コピーが消えるのは再標的の最適化（最初から親のregionに作る）の仕事で、意味論は常にコピーする

import "std/convert"

func noise() int {
    t := "zzzzzzzzzzzzzzzz" + "yyyyyyyyyyyyyyyy"
    return len(bytes(t))
}

func label(n int) string {
    s := {
        t := "n=" + convert.FormatInt(n)
        t + "!"
    }
    k := noise()
    return s
}

func squares(n int) []int {
    xs := {
        mut out := mut []int{}
        mut i := 0
        while i < n {
            out = append(out, i * i)
            i += 1
        }
        freeze(out)
    }
    k := noise()
    return xs
}

func main() {
    println(label(42))
    ys := squares(4)
    println("${len(ys)} ${ys[3]}")
}
```

出力:

```
n=42!
4 9
```

コピーするのは意味の上での話です。行き先が分かる値を最初から行き先のregionに作ってコピーを省くのは、処理系の最適化です（[language.md 21節](language.md)）。不変の値はコピーしたか共有したかを観測できないので、この最適化は意味を変えません。

### freeze: 可変で作って不変で共有する

`freeze(x)` は可変のコンテナを不変にします。中身はコピーしません。freezeできるのは、その点で他に別名の無いものだけで、freezeの後は同じパスに書けません（[3章V-8・V-9](spec/03-values.ja.md)）。可変の同一性は、freezeの点で一意だと検査器が確認してから、不変の値に変わります。

### task: 可変の値はtaskの境界を越えない

子のtaskへ渡せるのは、不変の値とチャネルの端点だけです。mutの束縛は捕獲できません（[10章C-2](spec/10-concurrency.ja.md)）。taskの結果と、チャネルで送る値も不変のデータで、regionを持つ値はコピーされます（C-3・C-13）。共有された可変の状態が無いので、データ競合は書けません。

この安全性と並列の出力の決定性は、言語のコアを形式化したモデルでLean 4の証明があります。証明はモデルの性質で、コンパイラの実装の性質そのものではありません（[安全のノート](design-notes/safe.md)）。

### 同一性が要る所は、型で明示する

同一性そのものが意味を持つものは、同一性の型として区別します。taskの `Scope`・`Handle`・チャネルの端点、開いたファイル・接続などです（[2章T-23](spec/02-types.ja.md)・[11章I-5](spec/11-io.ja.md)）。同一性の型はコピーの束縛・return・格納ができません。

長く生きて更新され続ける構造は、std/poolの `Pool[T]` に置きます。`Handle` は「スロットの番号 + 世代」の値で、どのregionにコピーしてもかまいません。返却や再利用の後の古い `Handle` で引くとnilになります（[9章M-7](spec/09-memory.ja.md)）。宙吊りの参照の代わりに、型で分岐を求めます。

複数のtaskが1つの可変の状態に合流する所は、domainで書きます。domainは状態を1つ持ち、`task.Update(d, (st mut S) => …)` の本体を1つずつ適用します（[10章C-21〜C-24](spec/10-concurrency.ja.md)）。状態への参照は外へ出ません。本体の値は呼び手のregionへコピーして返ります。本体は待たず、ioもしません。

## 値指向から説明できる設計判断

いくつかの設計判断は、個別の理由のほかに「場所を値にしない」「変更の許可を呼び出しの箇所に書く」という同じ見方で説明できます。ここでは、設計の記録で理由を確認できたものだけを挙げます。

### なぜメソッドが無いのか

[平凡のノート](design-notes/plain.md)は、メソッドの仕事（名前空間・カプセル化・ドット記法の読みやすさ）がpackageと `|>` で足りること、残るレシーバの規則は言語を大きくするだけだったことを答えにしています。値指向から見ると、その「残るレシーバの規則」が生まれない理由が説明できます。

- Goのメソッドには値レシーバとポインタレシーバの区別があり、`T` と `*T` のメソッドの集合やaddressabilityの規則が付いてきます（[language.md 3節](language.md)）。この区別は、レシーバが場所を指せることから生まれます。Soberにはポインタの型が無いので、区別そのものが生じません
- `buf.append(y)` のような呼び出しの形は、bufが書き換わるかどうかを呼び出し点の表記に出しません。Soberは書き換えの許可を呼び出し点に `f(mut buf, y)` と書かせます。マークを付けない形は、審査基準「やっていることが、そのまま書いてある」に反するとして棄てています（[language.md 26節](language.md)）

### なぜクロージャはmutの束縛を捕捉できないのか

値になるラムダ（クロージャ）は、mutの束縛を捕捉できません（[5章F-10・F-16](spec/05-functions.ja.md)）。設計の記録には、理由が2つあります（[language.md 25節「関数型のmut仮引数」](language.md)・26節）。

- 捕捉を許すと、クロージャが書き換えの許可を持ったまま、束縛のregionより長く生きうる
- 捕捉を通した別名が、呼び出し点の表記に見えない

捕捉したmutは、持ち運べる書き換えの許可、つまり参照の値と同じ働きをします。状態は呼び手が持ち、関数型のmut仮引数で渡します（[3章V-7](spec/03-values.ja.md)）。

呼び出し点へ展開されるラムダは別です。展開される関数の匿名の関数型の仮引数へ渡すラムダと、局所の名前に束縛したラムダ（[5章F-23](spec/05-functions.ja.md)）は、mutの束縛を捕捉できます。これらは値になりません。別の名前への束縛・フィールドへの格納・returnは拒否されます。本体の書き込みは、その場に書いた書き込みと同じです。書き換えの許可を持ち運ぶ手段にならないので、禁じる理由がありません。

### なぜmutのsliceは部分列を取れないのか

部分列 `xs[a:b]` は不変のsliceだけで取れます（[9章M-5](spec/09-memory.ja.md)）。mutのsliceから取れると、同じセルを指すmutのヘッダが2つになり、片方の書きが他方に見えるGoのsliceの事故が戻るからです（[language.md 21節](language.md)）。可変の同一性が見える範囲を広げない、という同じ方針です。

## 先行する考え方との位置

値を中心に置く考え方には先例があります。主な2つとの違いを書きます。機構ごとの先行研究（region推論・Cyclone・monitor・actor・Kahnのネットワークなど）は[先行研究のノート](design-notes/related-work.md)にまとめてあり、この節では繰り返しません。

- Rich Hickeyの講演 "The Value of Values" は、新しい情報が古い情報の場所を置き換えるプログラミングを「Place-Oriented Programming」と呼んで批判しました（"anytime new information replaces old information, you're doing Place-Oriented Programming"）。この講演は、値は不変であることを条件にしています（"values are immutable and values are semantically transparent"）。Soberは不変を条件にしません。変更は書けて、その範囲を `mut` で閉じます
- mutable value semantics（Hylo・Swiftの `inout`）は、値の独立性を保ったまま変更を書けるようにする規律です。参照は第一級の値にならず（"references become second-class citizens"）、束縛どうしが可変の状態を共有しません（"variables can never share mutable state"）。部分だけのin-place変更は認めます（"part-wise in-place mutation"。出典: Racordon et al., "Implementation Strategies for Mutable Value Semantics", Journal of Object Technology, 2022）。Swiftの `inout` 引数も、呼び出しの間だけ呼び手の変数を書き換える仕組みで、関数の外へ持ち出せず、寿命の注釈を書く必要がありません（[Swift公式の本「関数」の章](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)）。Soberのmut引数はこの系統に近い形です。Soberはこの原則を、メモリの寿命（region）・並列（taskの境界）・外の世界への作用（`@effects`）に広げています

## 「それだとできないのでは」への答え

### 長時間動くサーバでは、メモリが増え続けるのでは

答え: 接続ごと・反復ごとにregionが閉じるので、増え続けません。

`net.Serve` は接続1本ごとにtaskを1本走らせます。接続のtaskのregionには上限があり、`region:` で指定します。既定は128 MiBです（[11章I-11](spec/11-io.ja.md)）。ループの本体は反復ごとのregionなので、反復を越えて残すもの以外は積もりません（[9章M-1](spec/09-memory.ja.md)）。handleを捨てた子のtaskの格納場所は子の終わりで返るので、接続を受け続けるscopeでも伸びません（[10章C-10](spec/10-concurrency.ja.md)）。

例: [`examples/net_serve.sober`](../examples/net_serve.sober)・[`examples/iter_region_inner.sober`](../examples/iter_region_inner.sober)

### リクエストをまたいで生きるデータ（キャッシュ・セッション・接続プール）は持てないのでは

答え: 持てます。置き場所は、受けを直列にするか・domainか・外の保存先かの3つです。今の制約もあります。

- 受けを直列にするなら、接続を1本ずつ受け、`mut` の表を各リクエストの処理にmutで渡します（[Webサーバのガイド3節](guide/web-server.ja.md)・[`examples/web_login.sober`](../examples/web_login.sober)）
- 並行に受けるなら、domainに置きます。接続のプールはこの形です（[`examples/pg_pool.sober`](../examples/pg_pool.sober)）
- ログインのセッションは、std/sessionの署名つきのトークンとユーザーの表の世代で表します（[Webサーバのガイド7節](guide/web-server.ja.md)）

制約: domainの本体が状態に書けるのは、regionを持たない値（int・bool・byte・floatとそれらのstructなど）と、状態のmut sliceの要素への書きだけです。appendやstringの書き込みで状態を伸ばすことはできません（[10章C-24](spec/10-concurrency.ja.md)）。状態はdomainと同じだけ生きるので、伸ばした分は上書きしても解放されないからです（[language.md 11節「domain」](language.md)）。可変長のデータを並行のリクエストで共有するキャッシュは、今は外の保存先に置きます。

### regionの外に値を返すたびにコピーが起きて遅いのでは

答え: 意味の上ではコピーで、費用はコピーする量に比例します（[9章M-2](spec/09-memory.ja.md)）。行き先が分かる値は、処理系が最初から行き先のregionに作ってコピーを省きます（[language.md 21節](language.md)）。

コピーが省けるかどうかで意味は変わりません。不変の値はコピーしたか共有したかを観測できないからです。大きな不変の値の引数を番地で渡すようにしたのも、同じ理由で意味を変えずにできました（前の「実例」）。

### ループの中で確保したメモリは、ループが終わるまで解放されないのでは

答え: ループの本体は反復ごとのregionです。反復の中で作った値は、反復を越えて残すものだけが外へコピーされ、反復の数に比例して積もりません（[9章M-1](spec/09-memory.ja.md)）。

例: [`examples/iter_region_inner.sober`](../examples/iter_region_inner.sober)・[`examples/iter_region_outer_assign.sober`](../examples/iter_region_outer_assign.sober)

### 伸びていくコレクション（append・map）はゴミだらけになるのでは

答え: 先端で伸ばし続ける形ではゴミが出ません。ただし書き方に決まりがあります。

`append` は、mutのsliceの末尾がregionの先端と一致するときだけ、その場で伸ばします（[9章M-4](spec/09-memory.ja.md)）。1つのregionで複数の列を交互に伸ばすと、先端が一致しなくなってコピーが起き、ゴミが溜まります。小さなparserで測ったときは、交互に伸ばす形でゴミが85%・使用量がO(n²) になり、1つのregionに伸ばす列を1本だけにした形ではゴミがゼロ・O(n) でした（[language.md 21節](language.md)）。

決まりは「伸ばす構造はregionごとに1本にし、確定した値だけを境界でコピーして親へ渡す」です。交互に伸ばす必要があるときは、std/builder（チャンクをつないで伸ばす列）とstd/table（添字で読み書きする大きな表）を使います。どちらもチャンクを動かさないので、他の割り当てと混ざってもゴミが出ません。

例: [`examples/builder_string.sober`](../examples/builder_string.sober)・[`examples/table_std.sober`](../examples/table_std.sober)

### グラフや循環のあるデータ構造は書けないのでは

答え: 木は再帰型でそのまま書けます。辺が戻る構造は、表と添字で組みます。

型宣言は、`[]T`・`map[K]V`・`T?` を通る形なら自分自身を含められます（[2章T-33](spec/02-types.ja.md)）。式の木・JSONの値・ディレクトリの木のような構造は、再帰型で書けます。

書けないのは、値が自分自身に戻る形です。参照が無いので、値は下から組む木になります。双方向リスト・親つきの木・LRUのように辺が戻る構造は、mutの列に要素を置き、添字で辺を表します。`xs[i].f = v` で要素のフィールドを書けます（[3章V-10](spec/03-values.ja.md)）。

```sober
// examples/elem_field_assign.sober（抜粋）
// 番兵 0 番の直後に h を差し込む
func pushFront(es mut []Ent, h int) {
    first := es[0].next
    es[h].prev = 0
    es[h].next = first
    es[first].prev = h
    es[0].next = h
}

func unlink(es mut []Ent, h int) {
    p := es[h].prev
    n := es[h].next
    es[p].next = n
    es[n].prev = p
}
```

寿命が構文に従わない、長く生きる可変のオブジェクトのグラフ（GUIのretained modeの木など）は、Soberが狙わない領域です（[DESIGN「非目標」](../DESIGN.ja.md)）。

例: [`examples/elem_field_assign.sober`](../examples/elem_field_assign.sober)・[`examples/type_recursive_tree.sober`](../examples/type_recursive_tree.sober)

### task間でデータを共有できないのでは

答え: 不変の値は共有できます。可変の状態をtaskの間で共有する手段はdomainだけです。

可変で作ったデータは `freeze` で不変にすれば、コピーせずに子のtaskへ渡せます（[3章V-8](spec/03-values.ja.md)・[10章C-2](spec/10-concurrency.ja.md)）。taskの間の受け渡しはチャネルで書き、送る値は不変のデータです（C-13）。多くのtaskが1つの状態に合流する所はdomainで書きます。domainの呼び出しが走った順は、ioの入力と同じく記録される入力として扱い、その順を固定すれば結果はスケジュールに依りません（C-22）。

例: [`examples/tour_07_parallel.sober`](../examples/tour_07_parallel.sober)・[`examples/domain_counter.sober`](../examples/domain_counter.sober)

### コンパイラのように、寿命の違うデータが入り混じるプログラムは書けないのでは

答え: Soberのコンパイラ自身がSoberで書かれています（`src/compiler/`）。

寿命の違いは、置く構造で分けます。関数の表や脱糖・コード生成の記録のような大きな表はstd/tableに置き、作り終えたら `table.Freeze` で中身をコピーせずに不変にします（[language.md 17節](language.md)）。小さな列はstd/builderで組みます。

書き方の決まりを外れた例もありました。コンパイラのloaderが関数の表を、8本の `mut []T` に1周に1回ずつappendする形で書いていて、先端の一致が1本にしか効かず、使用量がO(n²) になりました。std/builderに移して解消しています（[language.md 21節](language.md)）。この形を知らせる解析器のlintはまだありません。

## 関連

- [DESIGN 1. region](../DESIGN.ja.md)・[安全のノート](design-notes/safe.md)・[先行研究のノート](design-notes/related-work.md)
- 仕様: [3章 値と束縛](spec/03-values.ja.md)・[9章 メモリ](spec/09-memory.ja.md)・[10章 並行](spec/10-concurrency.ja.md)
- 決定の記録: [language.md](language.md) の17節（freeze）・21節（sliceとregion）・26節（mut引数）・11節「domain」
- Rich Hickey, "The Value of Values"（講演）・Racordon et al., "Implementation Strategies for Mutable Value Semantics"（Journal of Object Technology, 2022）・[Swift公式の本「関数」の章](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)・[Rust公式の本4章](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html)
