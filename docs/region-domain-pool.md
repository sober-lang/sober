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
| block / alloc（ルート領域への escape）効果 | analyzer | メモ 12 節の効果追跡そのまま |

プリミティブは region だけ（Domain をプリミティブにする案は採らない）。Domain は「region を持ち、spawn 先を決め、Pool を生む」ただの struct。CPU / GPU / IO の対称性（design-dev.md の表）はライブラリ設計として維持する。

## 1. region（言語側）

> 並列の表層は 2026-10-05 に language.md 11 節「表層」へ移った（`parallel scope { spawn }` → `par.Scope` / `par.Spawn`・spawn に渡せるのは不変値とチャネルの端点）。この文書の `parallel scope` の綴りは旧表層のまま読む。

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

## 1b. defer（ブロックスコープ）

- `defer` を持つ。Go と違いブロックスコープ（Zig 意味論）。全ブロックがリソース境界なので defer もブロック終了で走るのが一貫する。Go の for ループ内 defer が溜まる罠が消える
- 式ブロックでは値の評価後・親に値を渡す前に走る
- Domain の停止も同じ形: `d := newDomain(policy); defer d |> close()`。close の中で drain → executor 停止 → region 解放の順序をライブラリが持つ
- 暗黙に残るのは `parallel scope` 終了時の join だけ。structured concurrency の定義そのものなので例外として明記する

## 1c. freeze（mut → 不変の一方向遷移。決定 2026-09-18）

動機: formal.md 段 3b の形式化で「共有できるのは深く不変（mutFree）な値のみで、構築後に不変化する術がない」ことが最大の性能アッパーと判明した。mut で構築したデータを並列スコープへ渡すには共有直前の O(n) コピーが強制される。freeze はこの一方通行を足す。

- 型規則は薄く: freeze は mut 参照を消費して不変参照を返す（`ref mut T → ref T`）。premise は「格納型が mut 参照を含まない（mutFree）」だけ。深い不変性は規則に入れず、bottom-up 凍結パターンで出す — 子を先に凍結すれば親セルの格納型は不変参照だけになり premise を自然に満たす。region 移管も借用追跡も要らない
- 健全性の底は実行時タグ: セルが実行時にも mut フラグを持ち、代入はタグを検査、凍結済みへの書きは panic。エイリアスされた古い mut 参照が freeze 後に書く、という型系の穴はここで塞ぐ。panic は効果語彙の既存の住人（language.md 12 節）なので語彙は増えない
- analyzer が手厚く: use-after-freeze の検出（acquire / release と同じ局所照合の系譜）。さらに「安全と証明できた代入はタグ検査を省く」— 検査除去は最適化であって健全性はタグが持つので、best effort 層に置ける。証明できない箇所は load + 分岐 1 個が残るだけの graceful degradation
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

## 未決

- ~~escape の自動化~~ → 決定（1 節）: 境界越えはコピー、割り当ては所有者に従う、末尾式と単一割り当て点は親に再標的、残りは lint
- fenced Domain で `canReuse` が真だが fence 未完了のとき、acquire はブロックするか新規 create するか。候補は「fence 完了まで再利用しない = 新規 create」と「pipeline_depth を超えたらブロック」
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
