# Sober: Region / Domain / Pool 仕様（種メモ 2026-09-17）

docs/language.md の 11 節「スコープ = 領域」を、Domain / Pool の層と接合して詰めたもの。

原則: ブロック = リソース境界 / 所有は上位スコープ・利用は下位スコープ / 直接の alloc は存在しない / 参照は木であってグラフでない / 参照カウントは Pool 内部に隠す。

## 層の割り当て

| 概念 | 住む層 | 理由 |
|---|---|---|
| region（スコープごとのアリーナ、escape 規則） | コンパイラ（健全必須） | メモリ安全は analyzer に振れない |
| 世代付きハンドル `Handle[T]` と `get(h) T?` | ランタイム + 型（`T?`） | 越境参照を panic でなく分岐にする |
| 並列スコープに渡せるのは不変値かチャネルのみ | コンパイラ | data race freedom |
| freeze（mut → 不変の一方向遷移） | 型規則はコンパイラ（薄）、タグ検査はランタイム、use-after-freeze 検出と検査除去は analyzer | 借用検査なしで「mut で構築 → 不変として共有」を可能にする |
| Domain（region + executor + Policy） | ライブラリ struct | 言語仕様に GPU / IO の語を入れない |
| Pool（Domain 上の型付きリソースプール） | ライブラリ | Poolable 辞書で backend を差す |
| lease（pool を外の書き手に貸す — 4c 節） | ライブラリ（io の pool）+ ランタイム（世代の回転・fence） | 貸出中の pool への書き・reset は口が無いので書けない。言語に lease の語を入れない |
| ワーカー局所の lease（作業域を task をまたいで使い回す — 4d 節） | ライブラリ（`task.Local` / `task.Lease`・`pool.Scratch`）+ ランタイム（ワーカーの置き場・使用中の印・世代の進め）+ loader（窓の写し・置き場の T の形の検査） | 意味は「窓のたびに新しいゼロ値」— 割り当ての最適化で、言語の意味（Lean のコア）に現れない |
| block / alloc（ルート領域への escape）効果 | analyzer | メモ 12 節の効果追跡そのまま |

プリミティブは region だけ（Domain をプリミティブにする案は採らない）。Domain は「region を持ち、spawn 先を決め、Pool を生む」ただの struct。CPU / GPU / IO の対称性（design-dev.md の表）はライブラリ設計として維持する。

## 1. region（言語側）

> 並列の表層は 2026-10-05 に language.md 11 節「表層」へ移った（`parallel scope { spawn }` → `task.Run` / `task.Spawn`・spawn に渡せるのは不変値とチャネルの端点）。この文書の `parallel scope` の綴りは旧表層のまま読む。

- 全ブロックが region を持つ。ブロック終了で一括解放。if / for / switch の腕もブロックなので同じ
- 割り当てのデフォルトは囲みスコープの region。構文なし。`x := T{...}` は現在の region に置かれる
- escape 規則: 親 region の値が子 region の値を参照してはならない（親 → 子参照禁止）。子 → 親は常に可
- region 境界を越える書き込みは宛先 region へのコピー（決定 2026-09-17）。ブロックの値を親に返す、子ブロックから親の mut 変数に代入する、Domain 間の `receive`（3 節）は全部この 1 規則。コンパイラは宛先 region を字句的に知るので解析は要らず、親 → 子参照は構成的に作れない。移動は最適化
  - 割り当ては所有者に従う: `append(buf, x)` は現在の region ではなく `buf` の region に割り当てる（参照型が region を持つ、formal.md の `Ref ρ T`）。親で宣言した `buf` を子で伸ばしても escape にならない
  - コピーを消す最適化: ブロック末尾式の割り当ては親 region に直接置く（`{ setup; build(tmp) }` がゼロコスト）。`y := make(); fill(y); y` のように単一の割り当て点が結果にしか流れないなら、その割り当てを親 region に向ける。ブロック内の局所データフローで判定、call graph 不要
  - 消せなかったコピーは analyzer が lint で示し、fix が宣言を親ブロックへ持ち上げる。関数の効果としての `escape` はルート region（グローバル）への書き込みだけ（language.md 12 節）。ブロック境界のコピーは効果ではなく lint
  - 同一性を持つ型（チャネル・Domain・Pool）はコピーできないので子から親へ返せない（コンパイルエラー）。親で作って子へ渡す方向のみ。structured concurrency の形と一致
  - 棄てた案: Zig 式に割り当て先を明示（構文が増え Go の見た目を壊す）、Tofte–Talpin の region 多相（formal.md で借りないと決めた）、サイズ閾値で自動/明示を切り替える折衷（閾値の規則が要る）
- コルーチンのスタックも region から取る（メモ 11 節 1 項）。コルーチンの寿命 = スコープの寿命
- 並列スコープ `parallel scope { ... }` に渡せるのは不変値かチャネルだけ。mut な値は単一スコープが所有し単一書き手
- **置き場 — park で死んだ深度を返す**（実装 2026-10-23・report-1060〜1062。意味は不変で、変わるのは置き場だけ）:
  - task が待ちに入って別の task へ切り替わるとき（rt.task_wait・協調形の spawn の切替）、その task の今の深度より深い region のスロットを手放す。今の深度より深い region は抜けた時点で死んでいる（上の規則）ので、置き場を手放すだけで中身は写さない。
  - 手放したスロットは、ワーカーの予備（スロットの表に置いたままの範囲 — 続かない分はプールの深度ごとの列）に入る。同じワーカーで次にその深度へ入る task が、さっき手放されたスロットをそのまま使う。
  - 接続の task の RSS が「待ちを跨いで生きる深度」の分だけになり（4096 接続で 115 → 73 MB・json-comp で 225 → 91 MB）、要求ごとに触る頁が温かい器に寄る（cycles −14〜18%）。
  - main（予約のアリーナ）と既定より大きいスロットの task は手放さない。予備をプールへ出すときは madvise しない。
  - 前提: 待ちに入りうる呼び出しの間、今の深度のレジスタは最内の生きた region の深度でなければならない。浅い深度へ確保させたい rt の口（宛先構築の read_file / read_dir）は深度を実引数で受け、レジスタを書き換えない（2026-10-23 の直し・report-1086 — 旧形は読む間だけレジスタを宛先へ下げていて、読みの待ちが (宛先, 今の深度] の生きた region を手放し、戻った task が深度を飛ばして入り直して他の task のスロットを自前にした。W ≥ 2 で io を読む task のある利用者のプログラムに影響）。網 = scripts/nextgen.sh（今の rt を積んだコンパイラで W ≥ 2 の自己 build。検査つきの rt は深度を飛ばした入り直しを exit 81 で止める）。
  - 既定より小さいスロットの task（std/net の Serve の接続 — `region:`・language.md 11 節）は、既定のスロット 1 本を割った小さいスロットを深度ごとに 1 本使い、park では既定の task と同じに予備へ返す。予備の欄には大きさの印があり、予備を採るのは同じ大きさの task だけ（違う大きさの task が深く入るときは予備を大きさに合った置き場へ出してから）。小さいスロットはワーカーの小さいスロットの深度ごとの列（溢れは共有の列 — 既定のスロットの深度ごとのプールと同じ形）に戻り、既定のプールへは返さない。列はスロットの外にあり、返したスロットの頁には書かない（中に鎖の語を書くと、列を通ったスロットの先頭の頁が全部常駐する — report-1079）。
  - 棄てた案:
    - 止まらない部分木の間だけ own を下げる（L1-0b の試作）: 呼び出しごとに表の退避と復元が要り、止まる部分木に効かない。
    - park のたびに 1 本ずつプールへ返す: 深度ごとの出し入れで命令 +600/要求。
- **置き場 — 借りの閉包が mut で捕捉する大きい束縛のセルは region に**（実装 2026-10-23・report-1063 / 1065 / 1068。意味は不変で、変わるのは置き場だけ）:
  - `mut z := T{…}` の集合値（64 語以上）を借りの閉包が mut で捕捉すると、番地が逃げるのでセルはフレームの専用スロットになり、その枝を通らない呼び出しでも熱いフレームが深くなる（task のスタックの頁が 1 枚増える — 8-5 の compress + stream で +4 KB/接続）。このセルを今の深度の region に置く。
  - 今の深度を使うのは、それが束縛の繰り返しを区切る region のときだけ: 反復の region・式ブロック・task の scope の中か、region 透過でない関数の本体（入口の自前の region）。region 透過の関数の本体の直下は呼び手の深度に積もりうるので、スロットのまま。
  - セルは束縛のスコープの間だけ使われ（mut 仮引数と借りの閉包は番地を保持しない）、置いた region はスコープ以上に生きる。リテラルの全語を書くので、region の頁の前の持ち主の値は読めない。
  - 棄てた案:
    - 大きさだけで選ぶ（大きい mut の集合値の束縛すべて）: 自己 build には効かず、tls の handshake の状態（32〜127 語 — 捕捉されない）まで出して json-tls の cycles +3%（report-1065）。
    - 冷たい枝の中でだけフレームを延ばす（shrink-wrapping）: x86 のフレームの前提（rbp の固定変位）を崩す大きさで、効きは同じクラスの部分集合。
    - 束縛のブロックを 1 段の region で包む（今の深度が使えない形の倒れ先）: 今は実需が無い — 倒れた束縛はスロットのままで退行しない。

## 1b. defer（ブロックスコープ）

- `defer` を持つ。Go と違いブロックスコープ（Zig 意味論）。全ブロックがリソース境界なので defer もブロック終了で走るのが一貫する。Go の for ループ内 defer が溜まる罠が消える
- 式ブロックでは値の評価後・親に値を渡す前に走る
- Domain の停止も同じ形: `d := newDomain(policy); defer d |> close()`。close の中で drain → executor 停止 → region 解放の順序をライブラリが持つ
- 暗黙に残るのは `parallel scope` 終了時の join だけ。structured concurrency の定義そのものなので例外として明記する

## 1c. freeze（mut → 不変の一方向遷移。決定 2026-09-18）

動機: formal.md 段 3b の形式化で「共有できるのは深く不変（mutFree）な値のみで、構築後に不変化する術がない」ことが最大の性能アッパーと判明した。mut で構築したデータを並列スコープへ渡すには共有直前の O(n) コピーが強制される。freeze はこの一方通行を足す。

- 型規則は薄く: freeze は mut 参照を消費して不変参照を返す（`ref mut T → ref T`）。premise は「格納型が mut 参照を含まない（mutFree）」だけ。深い不変性は規則に入れず、bottom-up 凍結パターンで出す — 子を先に凍結すれば親セルの格納型は不変参照だけになり premise を自然に満たす。region 移管も借用追跡も要らない
- 健全性の底は静的な一意性（改定 2026-10-10 — language.md 17 節・F-al）: 一意でない freeze（別名の残る束縛・mut の仮引数）と、freeze の後の同じ道への書きを検査器が拒否し、mut の仮引数は呼び出しを越えて逃げない（26 節 U3）。実行時タグは模型（formal.md の機械）にだけ残る観測点で、実装は持たない
- 暗黙の freeze（2026-10-11 — language.md 17 節）: 期待型が imm の位置に置いた mut の道は `freeze(道)` と同じ。一意性の規則は暗黙の点にも同じく掛かる
- 旧記述（〜2026-10-10）: 「健全性の底は実行時タグ（凍結済みへの書きは panic）・analyzer は use-after-freeze の検出とタグ検査の除去」。実行時タグは実装されず、freeze は型の付け替えだけだった — 古い別名から凍結済みを書き換えられた（F-al）。タグを実装する案（D1）と写しの freeze（D2）は棄てた（理由は language.md 17 節）
- freeze は不可逆（unfreeze なし）。タグの一方向性が形式化側の可換性・共有プレフィクス安定性を守る源泉
- 棄てた案: region 移管（Verona 式。機構が大きく formal の絶対レベル前提に触る）、借用追跡（Sober が構成的に排除した困難の持ち込み）、deep freeze を型規則に入れる（規則が太る。bottom-up パターンで足りる）
- 実地（2026-10-07 夜間・裁定 2026-10-08 確定）: 入れ子の可変コンテナ（`mut []mut []T` — std の Table の chunk の列）は、中身のある要素を 1 本ずつ取り出して欄を差し替えてから freeze して imm の外側の列に積めば、データを写さずに凍る（外側の列ごとの `freeze` は格納型に mut が残るので premise で弾かれる — 正しい）。std/table.Freeze がこの形（取り出し形 — 元の表は空に戻る）

## 2. Handle（region 越境の唯一の手段）

- `Handle[T]` は「Pool 内のスロット index + 世代」の値型。ポインタではないので region 規則に触れない（どの region にコピーしてもよい）
- 解決は `pool |> get(h)` で `*T?`。スロットが返却・再利用済みなら世代不一致で `nil`。役割はスコープを越えて保存した Handle の解決に限る（LRU リスト、索引、親所有のレジストリ）。利用スコープ内でのアクセスは acquire が返すピン済み参照（4 節）で行い、`get` の `nil` は「本当に消えたかもしれない」場所にだけ現れる。`get` の返す `*T` も現在ブロックの region。get と使用の間に他のコルーチンが release しないことは、必要なら `@noblock` 区間（language.md 11 節）で主張する
- 世代チェックはランタイム層。コンパイラは `T?` の flow typing で分岐を強制するだけ
- 組み込みか std か: std の struct で書けるなら std。言語が知る必要があるのは「値型であること」だけで、それは struct なら自明。→ std（言語組み込みにしない）。Zig 製のゲームの Handle 値型 + 世代チェックがそのまま前例

## 3. Domain（ライブラリ）

```
type Domain struct {
    region  Region          // 言語側のハンドル。Domain を作ったスコープの region
    policy  Policy          // 定数辞書
    exec    Executor        // spawn の行き先（スレッドプール / コマンドキュー / イベントループ）
}
type Policy struct {
    threads     int
    scheduling  Scheduling
    memory      Memory      // host / host_visible / device_local
    transfer    Transfer    // direct / staged
    completion  Completion  // immediate / fenced
}
```

- comptime で評価する形にしない — Policy は 定数 struct。分岐は最適化器の定数伝播で消える（メモ 3 節「辞書が定数なら単相化と同じ」と同じ賭け）
- Domain のスコープ終了 = executor 停止 + `drain` + region 解放。順序はライブラリが持つ
- Domain 間転送 `receive(dst, src, v)` は (src.policy.memory, dst.policy.memory) の辞書ルックアップ。ユーザーコードは同じ、方式は表で決まる。コピーか移動か: region 規則上「別 region への値」は常にコピー。移動は最適化
  - Domain 越境のコピー除去（決定 2026-09-17）: 言語にムーブは無い。割り当て点を宛先に向ける。arena モデルでは 1 オブジェクトの所有権を別 region へ移せない（メモリは元の arena に残る）ので、区分はコピーか「最初から宛先に置く」の 2 つだけ。Rust 的なムーブは後者の特殊ケース。`receive(gpu, cpu, buf)` のコピーを消すなら `buf` を最初から宛先 Domain の staging（host_visible）に置く（Vulkan の「マップ済み staging に直接書く」定石）
  - 判定は ブロック内の局所データフロー（1 節の再標的と同じ）: `buf` の割り当て点がこのブロックにあり、`receive` にしか流れない（他へ代入されず、receive 後に使われない）なら宛先に向けられる。割り当て点が局所なら参照の出所が全部見えるのでエイリアスも閾内。引数やフィールド経由の値は出所不明で対象外（unknown に degrade。`@unique` のような「他に参照が無い」注釈は借用検査の入口になるので入れない）
  - ブロック境界と違い、最適化器が黙って再標的するのではなく analyzer が lint で示し fix がソースを書き換える: `buf := make([]Vertex, n)` → `h, buf := gpu.staging |> acquire(n)?; defer gpu.staging |> release(h)`。Domain 越境のコピーは性能を決めるので、消えたかどうかがソースに見えるべき。ブロック境界の小さなコピーは見せず最適化器、Domain 境界は fix で明示、の線引き（「見えるものは人が書く、見えないものは最適化器」）
  - staging は宛先 Domain の Pool から取る（下記の未決を閉じる）。Domain の region に直接置くと寿命が Domain と同じになり staging が溜まる。Pool 管理なら fenced Domain の「fence 完了後に再利用」の既存規則に乗る。`receive` は同一メモリなら所有の引き渡し（Pool の返却先が変わるだけ）でコピーしない

## 4. Pool（Domain 上）

```
type Poolable[T, A] struct {
    create    func(A) (T, error?)  @effects(...)   // 必須
    destroy   func(T)                              // 必須
    canReuse  func(T, A) bool?                     // nil = 再利用しない
    reset     func(T)?                             // nil = 何もしない
}
```

- 型クラス `class Poolable` → 関数値の struct（辞書）。デフォルト値は `T?` フィールドの `nil`。「can_reuse がデフォルトなら Pool はフリーリストを持たない」は comptime 分岐でなく 辞書定数の定数伝播 + dead code 除去 で表す
- `pool := domain |> pool(backend)` は Domain の region に Pool を置く。Pool のスロット配列も同じ region
- `h, p := pool |> acquire(args)?` は `(Handle[T], *T)` を返す（決定 2026-09-17、language.md サンプル 2 の気づき 1）。`*T` はスロットの中身へのピン済み参照で、実体は Pool の region（祖先）にあるが、型は現在ブロックの region として付く。到達可能な内部参照（`body []byte` 等）も同じ region に見える（Sober の型は region 多相を持たず値の全参照が「値の住む region」を指すので、その 1 変数を現在ブロックに置き換えるだけ）。祖先 → 現在ブロックへの狭め替えなので常に健全で、新しい型規則は無い。効果: ピン済み参照は escape 規則でブロックから出られず、release 後に使う経路が構成的に消える。acquire 直後の `get` と到達不能な `nil` 分岐が要らなくなる
  - acquire を包む helper は書けない（`*T` の region が helper のブロックなので返せず、Handle だけ返すと release の局所照合に落ちる）。資源を渡す helper は inline ラムダを取る形 `withPage(c, no, page => ...)` で書く（language.md 8 節）。展開されるので acquire / defer / 本体が同じブロックに収まる
  - 早すぎる release の後の参照は analyzer が塞ぐ: release は acquire と同じブロックの `defer` 位置にしか書けない（下記の局所照合そのまま）。これはメモリ安全ではなく stale read の防止（スロットの記憶は Pool の region で生きており型も同じ）なので analyzer 層でよい。層の線引きに合う
  - 返却は `defer pool |> release(h)` を明示（destroy ではなく Pool へ戻る）。region の終了フックにライブラリが隠れて乗る形は採らない（暗黙の実行を作らない）
  - release 忘れは安全側: 実体は Pool（親スコープ）が所有するので「Pool のスコープ終了まで再利用されない」だけ。ダングリングも二重解放も起きない。対応する release のない acquire は analyzer が拒否し、fix が defer 行を書く（Go の Body.Close 忘れ検出と同型）。言語メモの「analyzer の通過が受理の定義」に乗るので警告ではなく拒否。検査は「acquire の戻り値 h が、同じブロック内で defer release(h) に渡されているか」の局所照合で、call graph は要らない
- 返却先は Pool のあるスコープ S、利用は子スコープ C。C の region が消えても T の実体は S の Pool にある。C から漏れた `Handle` は次の acquire で世代が進んで `nil` になる。「所有と利用の分離」が region + Handle で構成的に成立
- fence 紐づき遅延再利用: `completion: fenced` の Domain の Pool は返却時に現在の fence を記録し、`canReuse` の前に fence 完了を確認する。これは Pool 実装の中の Policy 分岐で、利用側コードは CPU / GPU で同一
- 外部依存リソース（swapchain、接続プール）も Pool の backend。「待ち → 提供 → 返却」を双方向 yield のジェネレータで表す形は採らない — for-yield は push 型で、双方向 yield を持たない。`create` / `canReuse` が `block` 効果を持つ backend として書けば専用機構は不要。「どう待つか」は Domain の executor が知っている

## 4b. Pool のホットパス: 動的検査のはしご（決定 2026-09-18）

freeze（1c 節）と同じパターン「動的検査が健全性の底、静的検査は検査を剥がす最適化」を Pool に適用する。安全性と性能を別の層に置くので、analyzer の精度が上がるほど速くなり、証明できなくても遅いだけで壊れない。

| 段 | 形 | 検査コスト | 保証の出所 |
|---|---|---|---|
| 0 | `get(h)` → `*T?` | 世代比較 + `nil` 分岐が毎回 | ランタイム（常に健全） |
| 1 | acquire のピン済み参照（4 節。既決） | スコープ内ゼロ | 型（region の狭め替え） |
| 2 | analyzer の有効性導出で `get` の分岐を除去 | ゼロ | analyzer の証明。底は段 0 |

- 段 2 の判定は局所照合: 「h が同一ブロックの acquire 由来（または有効性導出済みの h のコピー）で、区間内にその Pool への release / close が届かない」。他コルーチンの release を排除したい区間は `@noblock`（language.md 11 節）で主張。導出できなければ段 0 に degrade するだけで正しさは変わらない
- B 木探索のような「Handle を保存して辿る」ホットパスは段 2 が本命（SoberSQL の性能を決める項目）。ピン済み参照（段 1）はループ・スコープをまたぐ保存ができないため
- 段 2 が効いた / 効かなかった場所は lint で可視化する（Domain 越境コピーと同じ「性能を決めるものは見える」の線）

## 4c. 貸出（lease）— 外の書き手に pool を貸す（決定 2026-10-13 — IO 設計。実装は IO 便 段 2 (c) から — 下の「段取り」）

完了ベースの io（io_uring）は、提出から完了までカーネルがバッファに非同期に書く。プログラムの検査が見えない書き手が、時間の穴をまたいでメモリを持つ — region の「スコープを抜けたら解放」とも、Pool の「返却 = プログラムの release」とも衝突する（language.md 未決「IO ブロッキングとスケジューラの結合方式」の「region × in-flight バッファ」）。これを Pool の第三の状態と pool 単位の世代で受ける。外の書き手の梯子（カーネル → プロセス〔shm〕→ DMA → GPU）の最初の段で、4 節の fenced Domain の遅延再利用は同じ形の特殊例として読み替える。

- スロットの状態は 3 つ: **空き / プログラムが持つ / 外の書き手に貸出中**（4 節の Pool は空き / 使用中の 2 つ）
- lease の単位は **pool**（スロットごとではない）: 「この pool の世代 g は、外の書き手に貸出中」。io の pool は宣言で世代の段数 k を持つ — `io.NewPool(slots: 64, size: 64 * KB, gens: 2)`（名前つき引数で性質を境界に書く。`gens:` の既定は 2 = ダブルバッファ）
- 登録 = pool 丸ごと 1 回（io_uring の registered buffers の一括登録と形が一致する。ring はワーカーごとなので、同じメモリを各ワーカーの ring に登録する — language.md 28 節）
- 世代の回転は **スコープの境界で起きる**: ストリームの for の反復の境目・`task.Run` の出口で、rt は「次に使う世代の完了が全部届いた」ことを待ってから（fence）その世代を使う。回転は rt の中の動作で、利用者のコードに reset の語は無い — **「貸出中の pool を reset する」は構文的に書けない**（DESIGN 柱 1「メモリの詳細は構造と宣言から導出」の、外の書き手の時代の論拠: 手で書く「貸出中」「世代」は検査できない主張だが、構造から導出した世代は定理になる）
- 非同期の解放の契機（外の合図）は pool の境界の内側に封じる。個体ごとの遅延回収の列は持たない — 寿命は「pool の本数と回し方」の宣言から導出される
- pool の空きが尽きたら、空きが出るまで task が待つ（有界 = 背圧 — chan の有界と同じ線）。デッドラインがあれば待ちは `io.Timeout` で終わる（language.md 28 節）。上の未決「fenced Domain で fence 未完了のとき」は、lease の pool については「k 段を超えたら待つ」に倒れる

検査の形（何を拒否するか）:

| 規則 | 形 | 層 |
|---|---|---|
| L1 貸出中の pool に書かない | 第一便は読みの道だけ（カーネルが書き・プログラムは完了で渡された View で読む）。プログラムが pool のスロットへ mut で触る口が無いので書けない | 型（口が無い） |
| L2 貸出中の pool を reset しない | reset は回転の中だけ — 語が無い | 構造 |
| L3 View を世代の外へ持ち出さない | View は for の反復のブロックの region の型（4 節の acquire のピン済み参照と同じ狭め替え — 新しい型規則なし）。外へは写してだけ出せる | 型（既存の region 規則） |
| L4 書きの lease（段 4d — 大きい本体のゼロコピー。小さい応答の `io.Send(c, b)` は同期の写しで lease ではない — language.md 28 節の net） | 枠を埋めて `io.Send(conn, buf)` に渡したら buf は消費される — 17 節の freeze の一意性の検査（渡す道が一意・渡した後に同じ道を使わない）を流用 | 検査器（既存の機構） |

- 新しく足す検査は L4 の「消費」だけで、それも freeze と同じ機構に載せる（1c 節の棄てた案「借用追跡」の線を保つ）
- 動的検査の底は持たない（4b 節のはしごの段 0 に当たる「View に世代の番号を持たせ、回転後の読みで panic」は入れない — L3 が型で閉じるので底が要らない。入れるなら gates の変異の網として）
- 最適化の前提を 1 文で書く: **io の口の呼び出しが書きうるのは、貸出中の pool のスロットと、その口の戻りの値だけ**。rt の関数の「書かないものの表」（hloop / rlim / cpfwd が読む「既知の rt は書かない」）に 1 行で足し、io の呼び出しをまたいで、貸していないメモリの load を保持・巻き上げられる。正しさは L1〜L4 が保証し、最適化は前提を読むだけ（検査を足さない）
- 段取り（2026-10-13 — IO 便 段 2 (c)・裁定 U1 = 案 P）: 最初の実装は **ストリームの私有の pool**（1 本の for が gens 個のスロットを持つ — 既定 64 KiB × 2・口は後便）。
  世代の回転 = 反復の境目（前の切片を返して次の読みを出す）・fence = for の出口の chunk_close と task の死の出口の chunk_drain（貸出中の読みの完了を待ってからスロットを返す）。
  スロットは std/task のプログラムでワーカーに ring があればワーカーのアリーナ（16 × 64 KiB — ワーカーの最初の Chunks で mmap し、ring に固定バッファとして 1 回だけ
  登録 — READ_FIXED）から取り、無ければ記録と同じ region から取る（READ / 同期の read）。共有の pool（`io.NewPool` を task とワーカーの間で 1 本・空き切れの背圧）は
  Web 波の実需と `pool:` 引数で。棄てた案: 案 S を今入れる（行き先のない往復 — language.md 28 節）・ストリームごとに自分のスロットを登録する（BUFFERS_UPDATE —
  5.15 は外した登録の memlock の戻りが遅延 work なので、短いストリームが続くと ENOMEM で READ に倒れる — 実測 report-608）
- net の受信の pool（決定 2026-10-14 — net の裁定 N10・language.md 28 節の net。実装 2026-10-14 — 4b-1・report-665）: ワーカーごとの PBUF_RING 1 本（登録は pool 丸ごと 1 回 — 上の形そのまま。カーネルがスロットを選ぶ）。
  大きさ = ワーカーごと 16 KiB × n・n = clamp(2048 ÷ W, 32, 256) を 2 の冪へ切り下げ（裁定 2026-10-24 — report-1102。全ワーカーの和を W に依らず ≈ 2048 本に）。
  小さい受けでも環が一巡すると全スロットの先頭の頁が触られるので、固定費の RSS ≈ n × 4 KiB / ワーカー（W ≤ 7 で 1 MiB・W 64 で 128 KiB）。
  棄てた案: 固定の 256（裁定 D1）— 固定費が W に比例し、W 65 で ≈ 65 MiB（report-1092 / 1099）。
  **受けは届いたスロットから反復の region の先端へ写し、写し終えたスロットはその場で環へ返す**（写し 1 回 — カーネルの写しと合わせ同期の read と同じ回数・裁定 2026-10-14 report-665）。
  スロットの状態は「カーネルに貸出中（環の中）/ 接続の受信の列にある（届いて写していない）」の 2 つで、プログラムの値はスロットを指さない。
  世代の回転は受信には当てない — 多数の独立した接続が 1 つの pool を共有するので、世代ごとの fence は最も遅い接続に全員を待たせる。
  空き切れ = カーネルが multishot RECV を ENOBUFS で止める（F_MORE の無い完了）。張り直しは次の Recv で、その時点で環の空きが 0 なら今の read（EAGAIN → POLL_ADD の待ち）へ倒す —
  張り直しを空きの戻りに賭けないので進行を保証する（有界の背圧 — 上の「空きが尽きたら待つ」の net 版）。世代 `gens:` の既定 2 は
  ファイルの道と送信の枠に残る。epoll の道（段 4a）はワーカーの作業スロットを使わず反復の region へ直に read する（同じ写し 1 回）。
  棄てた案（4b-1 の時点）: スロットの View を反復の region の型で貸し出し、反復の境界でスロットごとに環へ返す（決定 2026-10-14 の当初の形 — std/net の Recv の形と rt の返しの口が要り
  inst が乗る一方、syscall の的に効かない。大きい本体のゼロコピー〔4d〕の便で再訪。返却の契機が構造の境界なので下の棄てた案〔個体の遅延回収の列〕には当たらないことは当初の論のとおり）
- 棄てた案: スロットごとの lease（個体の遅延回収の列が要り、非同期の解放の契機がプログラムの全域へ漏れる — GPU の段で要ると分かったら再評価）・lease を借用追跡で検査（1c 節と同じ理由）・利用者が書く reset / fence（手で書く「貸出中」は検査できない主張 — Vulkan の規約文書 + validation layer の世界）・バッファの持ち込み（Go の `Read(p []byte)` — バッファの管理の詳細がコードに漏れ、貸出中のバッファへのプログラムの書きを型で止められない）

## 4d. ワーカー局所の lease — 作業域を task をまたいで使い回す（決定 2026-10-16 — report-717 の裁定 6 点 + report-719 の裁定 (A)〜(D)。実装 = `pool.Scratch` 2026-10-16〔report-718〕・窓の綴りと写し report-719a・ワーカーの区画と使用中の印〔rt — lower/lease.sober〕report-719b）

実需: keep-alive の接続の task が圧縮の符号器の作業域（≈ 84 KB）を自分の region に持つと、作業域は接続の数だけ居座る（16384 接続で 1.3 GB 分 — report-716）。
同時に符号化しているのはワーカーの数だけで、符号化の本体は io を跨がない。region（流れ — 空間局所性の器）では畳めない「task をまたいで同じ場所を使い回す」時間を、
世代（時計）として明示に持つのが Pool（滞在 — 時間局所性の器）で、lease はその窓の間だけ時間を構文（字面のブロック）へ畳み直す。

```
// 置き場を作る（T の package の整えの関数 — 欄は宣言の package でだけ書ける）
gzw := task.NewLocal((w mut flate.Work) => flate.Prepare(mut w))
…
// 窓 = mut 仮引数 1 つの inline ラムダ — 借りる / 返すが 1 つの式の入口と出口・値は本体の値
z := task.Lease(gzw, (w mut flate.Work) => flate.EncodeWith(mut w, body, level))
```

- **意味の約束 = 「lease ≡ 新しい値」**: `task.Lease(lp, body)` は `{ mut w := T{}; 整え(mut w); body(mut w) }` と観測上同じ（スカラーの欄はゼロ値・
  Scratch は整えた容量で全部 0）。lease は「新しい割り当て」の最適化で、言語の意味に現れない（Lean のコアは無変更）。帰結: 決定性（Kahn・schedfuzz）を壊さない
  （どの接続が前にそのワーカーで使ったかが出力に漏れない）・窓の途中の死（panic・ChildDied）で後始末が要らない（次の lease が「まっさら」に見せるので、壊れた中身を戻さない）
- 実装の形（report-719a）: **loader が呼び出し点を脱糖の固定テンプレートで写す**（loader/lease.sober — namedargs・η 展開と同じ層。check と build が同じ木を読む）:
  `{ $lp := lp; $at := $task.LeaseTake($lp, <T の指紋>); defer $task.LeaseGive($lp, $at); mut w := T{}; $pool.LeaseAttach(mut w.f, $task.LeaseBlock($lp), $at, i) …; 本体 }`。
  テンプレートの形そのものが約束で、置き場の使い回しは写し先（LeaseTake が区画を返す・LeaseAttach が区画の列を付けて世代を進める）の中だけの最適化。
  置き場の列の形 = [指紋, n, 容量 × n, W, 区画 × W]・区画 = [印, 鎖, 欄ごとに (tag, 語 × 容量)]。rt の口は 2 つ（lower/lease.sober — std の写し先だけが宣言する
  `@intrinsic`）: `lease_op`（ワーカーの数・今のワーカーの番号・印を取る / 返す・区画の語の生の読み書き — imm の列の語を書くので不透明な rt の呼び出し）と
  `lease_view`（区画の語を指す mut []int — 深度は列のまま。バイト版の `lease_bytes` = blk の off 語目から n バイトを指す mut []byte — std/tls の送りの束・2026-10-25）。使用中の印は今の task の鎖（TCB の語 TC_LEASE — 窓は字面のブロックなので LIFO）に積み、
  task の死の出口（fd_drain の隣）と縮退した子の死（入る前の頭まで）で外す。task の無いプログラムは鎖を持たない（死 = プロセスの終わり）。
  網: schedfuzz の変異 15（印を見ない — 窓の中でチャネルを待つ task の置き場を同じワーカーの別の窓が共有する形を examples/lease_yield が捕まえる）・
  iterregion ⑧（窓の反復の RSS）。整えの窓は NewLocal で 1 度走り（T を 1 つ作って容量を読む — 1 回きりの値札）
- 「まっさらに見える」は毎回の全消しでなく **世代印**で: 置き場の T が持てる容器は `pool.Scratch`（世代印つきの固定容量の int の列 — 1 語 = 世代 32 ビット ‖ 値 32 ビット・
  読みは世代が今と違えば 0・lease の入口で世代を 1 つ進めるだけ〔O(1)〕・世代が一周〔2^32 回〕したときだけ本当に消す — zlib の head の手）
  - 窓の中の `pool.Renew` は進めた世代を置き場へ書き戻す（Scratch が置き場の住所を持つ — 書き戻さないと次の窓の LeaseAttach が同じ世代を配り、
    Renew の後の書きが次の窓に見えた〔report-720 で修理・回帰例 examples/lease_renew〕）
- 最初の利用者 = std/compress/flate の `Work`（記号・鎖・ハッシュの表の Scratch 3 本 + スカラー — `flate.Prepare` が最大の容量 ≈ 650 KB に整える）と
  `flate.EncodeWith` / `gzip.EncodeWith`（Encode は `Work{}` を作って呼ぶ形 — 出力のバイト列は同じ）。http の口は ServeConn の名前付き引数 `work:`
  （compress: と組み — 無しなら panic(WorkNoCompress)・省略は要求ごとに作業域を取る今までの形）。json-comp の RSS / 接続は 150 → ≈ 70 KB（report-720）。
  値札: 作業域は 1 語 1 項目（世代印の容器）に戻したので、work: を渡さない既定の道は要求ごとの作業域が詰めた形（report-716）より大きい
  （json-comp の RSS / 接続 150 → 200 KB — ユーザー裁定 2026-10-16 で受理。接続数に比例させたくない利用者は work: を渡す）
- **倒れの形（窓の中の譲りは禁止しない）**: 窓の中で io・sleep・chan・spawn の待ちに譲ると、同じワーカーの別の task が同じ置き場を借りに来うる。rt は置き場の
  「使用中」の印を見て、後から来た lease を **新しい割り当て（その task の region）に倒す** — 意味の約束で観測は同じで、遅く（重く）なるだけ。正しさに動的検査の底も
  静的検査も要らない（4b 節のはしごと同じ線: 証明できなくても遅いだけで壊れない）。analyzer は性能の lint を 2 つだけ出す: ① block 効果（language.md 12 節）が届く窓
  （倒れうる）② 窓の中で同じ Local をもう一度借りる（必ず倒れる — 入れ子の 2 つ目が新しい割り当て）。io を跨いで lease を持ちたい席（DB の buffer pool）は下の Sharable の便
  - lint の形（実装 2026-10-16 — analyzer/lease.sober）: **警告**（`<位置>: warning: … (Analyzer)` — 受理は変えない。受理した `sober check` だけが判定の前に stderr へ出す。
    言語に警告の口はこれが最初 — 拒否の analyzer の指摘と同じ列に warn の印を付けた）。① の block 効果は call graph の推移閉包（desugar.MayBlock — 葉 = std/task の
    Scope・Join・Try・Send・Recv と rt の待つ口 sleep・wait_fd・net_op・read_fd）で、1 つの窓に 1 回だけ名指す。近似: 関数値の呼び出しは見えない（鳴らない側）・
    Local の同一性は名前の字面（別名・関数をまたぐ入れ子は見ない）・窓の中で spawn した子のラムダは別の task として窓の外に数える。棄てた案: 拒否（意味は同じなので
    受理を変える理由が無い）・`--lint` の開発用フラグ（見えない lint は効かない）
- **置き場 = ワーカー局所・NewLocal で先取り**（裁定 (B)）: NewLocal はその場で W 個の T を呼び手の region に作る — 置き場は NewLocal を呼んだ region に住み、子 task は
  その scope より長生きしない（structured concurrency）ので、ワーカーの寿命の区画（rt が Sober の値を置く新しい住所）が要らない。接続の task はワーカーに固定され、窓は譲らなければ
  割り込まれない（協調スケジューリング）ので **原子操作なし**。容量 = 1 つ × W（使わなくても W × 作業域を取る — 値札）。使用中の印は task の死の出口で外す
- **置ける T = スカラー（int・byte・bool・float）と `pool.Scratch` の欄だけの struct**（loader の検査 — diag.Par 26）。slice / string / map を持つ T は拒否:
  窓の中の写しの規則（若い region の値を古い置き場へ書くと写し — language.md 21 節）で置き場が伸び続ける
- **容量の宣言 = NewLocal の整えの窓**（裁定 (B)）: 窓の本体は Scratch の欄ごとに `pool.NewScratch(mut w.f, 定数)` をちょうど 1 回（定数 = 字面・const の名前・括弧・+ - * <<）。
  欄は宣言の package でだけ書ける（language.md 20 節）ので、T が別の package なら窓は T の package の関数 1 つ `F(mut w)` を呼ぶ形で、その本体を同じ規則で検査する（diag.Par 27）。
  F の本体が 1 文の転送 `G(mut w)`（w は F の唯一の mut 仮引数そのもの）なら G へ辿る（深さ 4 まで — 決定 2026-10-22・report-1043 A4）。T が std/internal の型で
  公開の名前が型の別名（language.md 32 節）のとき、整えの関数の本体は T の package（internal）に置き、公開の package には転送を置く — `flate.Prepare(mut w)` が
  `deflate.Prepare(mut w)` を呼ぶ形。棄てた案: 別名を宣言した package も「T の package」と数える（別名は宣言の package を変えない — 転送の本体は T の欄を書けないので、検査は結局 T の package の本体に要る）
  テンプレートが組む欄の場所（容量の読み・区画の付け外し）は loader の印（EMutArg の b）で欄の書きの規則の外 — 形は loader が検査済み
- **NewScratch は 1 回だけ**（裁定 (C)）: 容量のある Scratch に呼ぶと panic(ScratchSized{})。窓の中で作り直すと、新しい列が task の region に取られて長命の置き場から
  宙吊りになる — 呼ぶ関数は別の package にあり局所の検査では届かないので、動的な不変条件にする（倒れの道でも同じ振る舞い — 観測は割れない）
- **Local の値 = region に住む imm の列**（裁定 (D)）: 端点のような同一性の型にしない — 約束のもとでは写しても観測は変わらない（どの写しから借りても中身は「まっさら」）。
  imm の列なので region の規則がそのまま効き（外へ出すと列ごと写る = 別の置き場・遅いだけ）、捕獲・spawn への受け渡しは imm のデータの既存の道で通る。ゼロ値 `task.Local{}` は
  何も指さない偽物として拒否（同一性の族のゼロ値の規則 — NewLocal だけが作る）。rt が使用中の印を imm の列に書く点は、rt の「書かないものの表」で写し先を「書く」側に置く
- **task.Local は型引数を持たない**（実装の制約 — report-719a）: T は mut の列（Scratch）を持つ struct で、型引数に置けない（language.md 25 節 — 型引数は写せる型）。
  T の同一性は loader が型の名前（package の path + 名前）から焼いた指紋を置き場に持たせ、LeaseTake が窓の T の指紋と照合する（違えば panic(LocalType{}) — 呼び手の契約違反・
  静的な照合の代わりの 1 比較）
- 窓の綴り（裁定 (A)）: ラムダの仮引数に `mut` を書ける（仮引数宣言と同じ綴り — syntax.md の LambdaParams）が、**task.Lease / task.NewLocal の窓の位置だけ**（他は loader の拒否 —
  diag.Par 25）。関数型に mut の席は足さない（std の Lease / NewLocal の宣言の署名は柵 — 呼び出し点は全部写される）。逃げない保証は mut 仮引数の U3 がそのまま閉じ、
  早すぎる返し・二重の返しは形の上で書けない（4 節の withPage の形）。30 節 R-a（Acquire / Release の局所照合）の対象は広げない・新しい拒否規則も足さない
- std/pool の Pool[T]（Acquire / Get の写し / Release）はそのまま残す — 「Handle を保存して後で引く」（索引・LRU）の席で、lease とは別の道具
- 棄てた案: 中身の持ち越しを許す lease（速いが「どの task が前に使ったか」が観測に漏れ、決定性の約束の外）・窓の中の譲りを拒否する（`@noblock` の窓 — 拒否の規則が 1 つ増え、
  倒れの形で足りる）・Acquire / Release の handle で借りて Get / Set で写す（毎回の写し — 84 KB の作業域では本末転倒）・ピン済み参照 `*T` を言語に（4 節の当初の設計 —
  mut 実引数の道で足りる間は棚）・置き場を接続の task ごと（今の形 — 接続数に比例）・Sharable（全ワーカーで 1 本・原子的な取り出し — 符号器には過剰〔競合・偽共有〕。
  io を跨ぐ lease〔DB の buffer pool — ピン = 貸出・eviction = 世代の fence〕の席として Phase 3 の原子性の設計と同時に）・Local を struct の欄に置く
  （`http.Gzip{level, work}` — http の口は ServeConn の名前付き引数 `work:`）・rt が std の型ごとに暗黙の Local を持つ（`@worker_local` — グローバル変数に近く、性質を境界に書く柱と緊張）・
  関数型一般に mut の席（26 節 G3・関数値に mut の別名が乗る）・`w =>` で暗黙に mut（印の無い mut）・型の宣言に容量（欄の既定値の構文が無い）・初回の Store で伸ばす（窓の中で伸びる）・
  初回の lease で置き場を作る（ワーカーの寿命の区画が要る）・Local を端点と同じ同一性の型（give: で 1 子へ移す — 接続の task は数千）・`Local[T]` の型引数で T を照合する（上の 25 節）・
  desugar（check の経路）と lower（build の経路）で別々に写す（同じ規則の 2 実装 — check ⊂/⊃ build の割れの種。loader の 1 か所に）

## 4e. 貸し出しの梯子 — 外の書き手の段階（構想 2026-10-12・0.6.0 の裁定 2026-10-17 — IO 基盤の壁打ち 論点 3）

「プログラムの検査が見えない書き手にメモリを貸す」は io_uring 固有でなく、段階のある 1 つの型。育てる順:

| 段 | 外の書き手 | 足されるもの | 状態 |
|---|---|---|---|
| 1 | カーネル（io_uring） | 最小の実物 — リング 1 本・バイト列・世代は読みの回転だけ | 読みは 4c 節で着地・書きの lease は L4（段 4d） |
| 2 | プロセス（shm チャネル） | 相手が対等（双方が読み書き）・プロセスモデルの箱 | 構想（PINS） |
| 3 | デバイス（DMA） | ピンされたページ（動かないメモリ）・デバイスの完了 | 構想 |
| 4 | GPU（Vulkan） | 世代（N-buffering = in-flight 多段）・遅延回収（fence 後の deferred deletion）・双方向（storage buffer / readback） | 構想 — 最難関。sujini の Vulkan の実地の痛みが素材 |

- **0.6.0 の裁定（2026-10-17）: registered buffers は rt の内側に留める**。表面は View 貸し（4c 節 L3）のまま・READ_FIXED / WRITE_FIXED は rt の性能便
  （design-dev.md の IO 便 ⑤）・「貸出中 = カーネルが書き手」の第三状態は rt の規律で守る。**言語の lease 型を切るのは GPU / shm の波** —
  io_uring（段 1）だけから型を切ると、世代・双方向・遅延回収が足される段で作り直しになる。最小の実物を rt の内側で運用し、2 段目以降の実需が
  形を出してから型にする（io_uring = 前哨戦、の位置づけ）
- pool 単位 lease の勝ち筋（2026-10-12 の発見 — 型を切るときの出発点としてここに昇格）: ① 登録 = pool 丸ごと 1 回（registered buffers の一括登録と形が一致）
  ② 世代 = pool を in-flight の段数だけ回す（fence が通ったら pool ごと reset — 個体の遅延回収キューが消える。Vulkan の per-frame arena の実務知の構造への昇格）
  ③ 非同期の解放契機が pool の境界の内側に封じられ「寿命は構造から導出」と和解する ④ 検査が粗くて安い（「貸出中の pool に書くな・reset するな」の 2 つ —
  4c 節の L1 / L2 がそのまま）。個体単位の lease は GPU の段で要ると分かってから再評価（4c 節の棄てた案）
- 型が切れた後に開く最適化の棚（裏の動機の記録）: 外部の書き手の効果を型が区切ると、io の呼び出しをまたいで非貸出メモリの load を保持・巻き上げられる
  （4c 節「最適化の前提を 1 文で」の一般化）・submit / completion を跨ぐソフトウェアパイプライン化・カーネルが書く pool の false sharing 回避と NUMA 配置

## 5. 並列とデータ分割: SoA 強制（決定: 案 (a)）

> 2026-10-05 注: 下の例の「spawn の引数に mut な配列を渡す = 所有の移動」は、今の表層では spawn の閉包が mut を捕獲できない（language.md 11 節）。所有の移動は端点の引き渡し（`give:`）と同じ口で書けるかを段 6 で確かめる。

mut パス（`mut(elem.position)` の非重複検査で同一配列への分割並列書き込みを許す）は採らない。

- 並列スコープに渡せるのは不変値かチャネルのみ、という 1 項の規則を崩さない。フィールド単位のアクセス権行列（read / atomic / mut）と重複判定を言語から消す
- 結果、ECS 型ループ「同じ entities を position と frame で並列更新」はそのままでは書けない。代わりに SoA を強制する: `positions []Vec3` と `frames []int` を別配列に分け、並列スコープごとに 1 配列を所有させる

  ```
  parallel scope {
      spawn physics(positions, velocities, dt)   // positions を所有、velocities は不変
      spawn animate(frames, dt)                  // frames を所有
  }
  ```

  所有の移動はスコープ境界の明示（`spawn` の引数に mut な配列を渡す = そのスコープの間は親から触れない）。これは region 規則の「単一書き手」で表現でき、新しい型規則は要らない
- 採る理由: (1) メモの「健全性はコンパイラ、その他は analyzer、ただしメモリ安全と data race freedom はコンパイラ」の線に乗る (2) GPU 側は元から SoA（SSBO の列）なので CPU 側も揃えると `receive` の転送単位が自然に配列になる (3) 最小権限を lint で段階的に絞る UX を丸ごと不要にする
- 払うもの: AoS で書いた既存コードの移植コスト、struct 1 個に纏まっていた「エンティティ」が配列群 + index になる可読性。ECS はもともとそういう形なので損は小さい
- 撤退条件: SoA 化で書けない並列パターンがゲームの移植中に 3 つ以上出たら、mut パスを analyzer 層の性質（`@mut(.position)` の非重複検査、unknown は拒否）として復活させる。コンパイラ側には入れない

## 6. 採らなかった機構と、その読み替え

| 採らなかった機構 | Sober |
|---|---|
| `class Poolable` / `impl` / 構造的充足 | 関数値 struct の辞書。省略は `T?` の `nil` |
| comptime による Policy 分岐・can_reuse 分岐・転送方式選択 | 定数辞書 + 最適化器 |
| `join` 必須、暗黙の待ちなし | スコープ終了で全 spawn を暗黙 join（structured concurrency）。未 join のハンドルはエラーではなく「スコープ末尾で待つ」 |
| acquire の自動返却（ブロック終了で Pool へ） | `defer release` を明示。忘れは analyzer が拒否 + fix |
| 双方向 yield（`-> yield Out -> In`） | 持たない。ジェネレータは push 型 for-yield、待ちは Pool backend の `block` 効果 |
| mut パス、read / atomic / mut 行列 | 持たない。不変値 or チャネル + SoA 強制（5 節） |
| `T ! E` エラーユニオン、エラーセット自動合成 | `(T, error?)` + analyzer のラベル導出（メモ 13 節） |
| 値の精錬 `& nonzero` | 保留。analyzer 層に入れるなら別メモ |
| 名前付き引数必須 | 落とす。`\|>` の第 1 引数省略と噛み合わない |
| 1 ファイル 1 型 | 保留。package が可視性の単位なので必須ではない |
| `nopanic` | `@effects(!panic)`（メモ 12 節） |
| 調停コルーチン（frame sync を yield で書く） | コルーチン + チャネルでそのまま書ける。機構追加なし |
| スロットごとの lease・貸出中の借用追跡・利用者が書く fence / reset | pool 単位の lease + 宣言した世代の回転（4c 節） |

## 未決

- ~~escape の自動化~~ → 決定（1 節）: 境界越えはコピー、割り当ては所有者に従う、末尾式と単一割り当て点は親に再標的、残りは lint
- fenced Domain で `canReuse` が真だが fence 未完了のとき、acquire はブロックするか新規 create するか。候補は「fence 完了まで再利用しない = 新規 create」と「pipeline_depth を超えたらブロック」
  - 2026-10-13: lease の pool（4c 節）は後者 — 宣言した世代の段数 k を超えたら待つ（背圧）。一般の fenced Domain の Pool は GPU の段で同じ形に寄せるかを裁定する
- ~~`receive` の staged 転送で staging buffer をどの region から取るか~~ → 決定（3 節）: 宛先 Domain の staging Pool から acquire。fix がそこへ書き換える
- ~~Handle の `get` の毎回分岐コスト~~ → 決定（4b 節: 動的検査のはしご）。段 2 の判定精度が実際のホットパスでどこまで効くかは SoberSQL で計測
- SoA 強制のとき、複数配列をまたぐ「1 エンティティの削除」（index の整合）を誰が守るか。世代付き index をエンティティ ID にすれば Handle と同じ機構で解ける
- 並列スコープに渡せる第 3 のクラス Sharable（方向づけ 2026-09-18、確定は Phase 3 のアトミック設計と同時）: 「不変値かチャネルのみ」の規則に、内部同期を持つ std 型（チャネル・Pool・アトミック）のマーカーとして Sharable を足す。型システムはマーカーの白リストだけ薄く持ち（mutFree 検査の例外）、内部同期の正しさは TLA+（チャネル・join と同じ枠、design-dev.md Phase 5b）とランタイム検証へ振る。チャネルは formal.md 段 3c で形式化し、Pool は「チャネルで書いた参照実装と観測等価」を差分テストで見る。これで RDBMS 未決の「Pool のスレッド安全性」は (a) 単一書き手 + 共有 Pool の形が取れる方向になる。2026-09-18 追記: Pool の骨格（acquire / release / 排他 / 待機 / 再利用）が新しい型規則ゼロで chan の派生形として書けることを機械化で確認（formal.md「Sharable の断片」、ex14 / ex15）。白リストは chan 1 行のまま。mut スロットの循環は型が付かず、実 Pool の可変スロットは 4b のはしごが受ける

### RDBMS（SoberSQL、ゴール sober/sobersql）を書くと必ず要るもの（2026-09-17 洗い出し）

前提: 「並列スコープには不変値かチャネルのみ」は PG / InnoDB 式の「共有バッファプール + ラッチ」を構成的に禁じる。取れる形は (a) 単一書き手 + copy-on-write B 木（LMDB 系。不変ページの共有 = MVCC スナップショット）か (b) thread-per-core の shared-nothing（Seastar 系。Phase 5b のワーカー固定と一致）。SoberSQL の第一形は (a)。これは制約ではなく思想の一致として扱う。相性が良い点: ページのピン/アンピン = Pool の acquire / `defer release`、push 型 for-yield = push-based クエリ実行（子 → 親のタプル返しが無いので region 越境コピーが起きない）、for の反復 = region なので長い走査でも一時割り当てが溜まらない。以下は docs に答えが無く、Phase 3 の std 設計時点で決める必要があるもの:

- アトミック / ラッチの逃げ道: LSN カウンタ、CoW のルート差し替えは原子的でなければならない。std にアトミック型を置くか、型システム上どう扱うか（並列スコープに渡せる「第 3 の種類」になる）。無いと単一書き手ですら書けない
- バイトレイアウトと再解釈: ページのスロット配列、可変長タプル、非アライン読み。Go の `unsafe` 相当が無く、FFI（Phase 6。既定は wasm で線形メモリは別 Domain なので、そもそも Sober 側のメモリを見せる手段ではない）だけでは足りない。候補は Zig 式: (1) レイアウト定義済み struct（Zig の `extern struct` / `packed struct`）を `@layout(c)` / `@layout(packed)` アノテーションで与える（9〜10 節の方針どおり言語ではなく注釈層。注釈のない struct はレイアウト未規定のまま）、(2) エンディアンを読み時に明示する std 関数（Zig の `std.mem.readInt(u32, bytes, .little)`。ホストエンディアン暗黙の再解釈を持たない）、(3) `[]byte` → レイアウト定義済み struct のビューは std 関数で長さとアライン検査つき `T?` を返す（Zig の `bytesAsValue` + アライン付きポインタ型に相当。失敗は `nil`、UB ではない）。ポインタ演算は持ち込まない。要検討: ビューが元の `[]byte` を参照するので region 規則（子 → 親のみ可）にそのまま乗るか、mut ビューの単一書き手をどう保つか
- Handle の `get` がホットパス: B 木探索は 1 ステップごとに get で、世代チェックと `T?` 分岐が毎回乗る。上記「analyzer が有効性を導出して分岐を消す」を SoberSQL では性能を決める項目に格上げ
- ~~CPU 束縛ループのキャンセル~~ → 解決: 中断点を含まないループのバックエッジにコンパイラが検査点を挿す（language.md 11 節「キャンセル」）。公平性のためにも要るので追加コストではない
- Pool のスレッド安全性: 複数の並列スコープから同じ Pool に acquire してよいか。可なら Pool が唯一の共有可変オブジェクトになり、実装内にアトミックが要る（上記 1 項と同じ答えになる）。不可なら (b) の形しか取れない。→ 方向づけ: Sharable クラス（未決の最終項）で「可」に倒す
- ~~コルーチンスタックの仮想予約~~ → 解決: スタック上界のリンク時計算（language.md 11 節）で spawn ごとに必要量だけ region から取る。Policy の予約サイズは不要
- 制約にならないもの: トランザクション・カーソルの寿命はセッションのコルーチンに閉じるので LIFO で足りる。字句的でない寿命はバッファページ（LRU）だけで、Pool に振られている

## 実装との対応

- Phase 1（fib、if/switch 式、struct、union、`|>`、for-yield）: 本メモと無関係。今すぐ着手可
- Phase 2（型検査）: region の escape 規則、`T?` flow typing、並列スコープの不変値制約。5 節の決定がここに効く
- Phase 3 相当: Handle / Domain / Pool を std として書く。ここで 1〜4 節が検証される
- Phase 5: `parallel scope` の spawn 先は Domain の Executor。タスクは生成時のワーカーに固定（design-dev.md Phase 5b）。`Policy.threads` = 1 なら単一スレッド実行と同じ
- Phase 4 以降: ゲームの移植で 5 節の撤退条件を計測
