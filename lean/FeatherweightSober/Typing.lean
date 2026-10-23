import FeatherweightSober.Syntax

/-!
# 型付け（段 3d: region + mut/immutable 参照 + parallel + 参照つきペイロードのチャネル）

- 文脈 Γ は型のリスト（de Bruijn。先頭が var 0）
- Ξ はチャネル型環境: チャネル id → (Ψc, ペイロード型)。K と同様に**全タスクで共有**。
  Ψc は生成時の共有プレフィクス `Ψ.take rc` のスナップショット（rc = Ψc.length）。
  chanV の型付けが `Ψ.take rc = Ψc` を要求することで、「このチャネルに触れる世界は
  ペイロードの参照先を同じ内容で持つ」が局所的に読める
- Ψ はストア型: region レベル → アドレス → (mut フラグ, 型)
- f は書き込み床（write floor）: この世界線の以後の書き込み（alloc / freeze）は
  region ≥ f でしか起きない。par が b を引き上げても f は不変 —
  chanV の `rc ≤ f` がスナップショットの安定性（書き込みが Ψ.take rc に届かない）の根拠。
  機械状態では常に f = b（par の本体の型付けの中でだけ b < f ... b > f になり得る）
- b は共有境界（share boundary）: レベル < b の region は親から共有されたもの
- d は現在の深さ（生きている region の数）
- Λ はラベル環境（de Bruijn。先頭が最内のラベルの型 — V4 の label / jump 用。V4-1 は下準備で、
  全規則が素通しし、par / parch の子タスクと Def の本体（DefsOk）だけ [] から始まる — タスク・関数境界を越える脱出は無い）
-/
namespace FS

abbrev Ctx := List Ty

/-- ラベル環境（V4、R4b で深さつき）: 各ラベルの (型, ラベルの最内 region k)。jump はペイロードのうち k より深い
region のコンテナを k へ写す（脱出の境界コピー） -/
abbrev LCtx := List (Ty × Nat)

/-- ストア型: region レベル → アドレス → (mut フラグ, 型) -/
abbrev StoreTy := List (List (Bool × Ty))

/-- チャネル型環境（段 6 P1 で構造体に — 世界ごとの部分を持つ）:
- `ch`（全タスク共有）: 旧チャネル id → (生成時の共有プレフィクスのスナップショット, ペイロード型)。
  rc = スナップショットの長さ。ペイロード型の制約（regionsBelow rc・mutFree）は ChanOk が運ぶ
- `ep`（全タスク共有）: 端点のチャネルの鍵 → ペイロード型（P1 は loc-free）
- `tk`（**世界ごと**）: この task の子の番号 → (scope の region, 結果型)。handle の型付けが引く -/
structure ChanTy where
  ch : List (StoreTy × Ty) := []
  ep : List (EpKey × Ty) := []
  tk : List (Nat × Ty) := []

instance : EmptyCollection ChanTy := ⟨{}⟩

@[simp] theorem ChanTy.empty_ch : (∅ : ChanTy).ch = [] := rfl
@[simp] theorem ChanTy.empty_ep : (∅ : ChanTy).ep = [] := rfl
@[simp] theorem ChanTy.empty_tk : (∅ : ChanTy).tk = [] := rfl

/-- 旧チャネルを 1 本足す -/
def ChanTy.addCh (Ξ : ChanTy) (p : StoreTy × Ty) : ChanTy := { Ξ with ch := Ξ.ch ++ [p] }

inductive HasType (Δ : Defs) : ChanTy → StoreTy → Nat → Nat → Nat → Ctx → LCtx → Expr → Ty → Prop where
  | lit {Ξ Ψ f b d Γ Λ} {n : Int} : HasType Δ Ξ Ψ f b d Γ Λ (.lit n) .int
  | tt {Ξ Ψ f b d Γ Λ} : HasType Δ Ξ Ψ f b d Γ Λ .tt .bool
  | ff {Ξ Ψ f b d Γ Λ} : HasType Δ Ξ Ψ f b d Γ Λ .ff .bool
  | triv {Ξ Ψ f b d Γ Λ} : HasType Δ Ξ Ψ f b d Γ Λ .triv .unit
  | var {Ξ Ψ f b d Γ Λ} {i : Nat} {t : Ty} : Γ[i]? = some t → HasType Δ Ξ Ψ f b d Γ Λ (.var i) t
  | letE {Ξ Ψ f b d Γ Λ} {e body : Expr} {t₁ t₂ : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e t₁ → HasType Δ Ξ Ψ f b d (t₁ :: Γ) Λ body t₂ →
      HasType Δ Ξ Ψ f b d Γ Λ (.letE e body) t₂
  | add {Ξ Ψ f b d Γ Λ} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .int → HasType Δ Ξ Ψ f b d Γ Λ c .int →
      HasType Δ Ξ Ψ f b d Γ Λ (.add a c) .int
  | lt {Ξ Ψ f b d Γ Λ} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .int → HasType Δ Ξ Ψ f b d Γ Λ c .int →
      HasType Δ Ξ Ψ f b d Γ Λ (.lt a c) .bool
  | arith {Ξ Ψ f b d Γ Λ} {op : ArithOp} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .int → HasType Δ Ξ Ψ f b d Γ Λ c .int →
      HasType Δ Ξ Ψ f b d Γ Λ (.arith op a c) .int
  | cmp {Ξ Ψ f b d Γ Λ} {op : CmpOp} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .int → HasType Δ Ξ Ψ f b d Γ Λ c .int →
      HasType Δ Ξ Ψ f b d Γ Λ (.cmp op a c) .bool
  | ite {Ξ Ψ f b d Γ Λ} {c t e : Expr} {τ : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c .bool → HasType Δ Ξ Ψ f b d Γ Λ t τ → HasType Δ Ξ Ψ f b d Γ Λ e τ →
      HasType Δ Ξ Ψ f b d Γ Λ (.ite c t e) τ
  | nil {Ξ Ψ f b d Γ Λ} {t : Ty} : HasType Δ Ξ Ψ f b d Γ Λ (.nil t) (.opt t)
  | some {Ξ Ψ f b d Γ Λ} {e : Expr} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e t → HasType Δ Ξ Ψ f b d Γ Λ (.some e) (.opt t)
  /-- flow typing: someCase の中では中身が t で見える -/
  | ifnil {Ξ Ψ f b d Γ Λ} {e n s : Expr} {t τ : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.opt t) → HasType Δ Ξ Ψ f b d Γ Λ n τ →
      HasType Δ Ξ Ψ f b d (t :: Γ) Λ s τ →
      HasType Δ Ξ Ψ f b d Γ Λ (.ifnil e n s) τ
  | inl {Ξ Ψ f b d Γ Λ} {e : Expr} {l r : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e l → HasType Δ Ξ Ψ f b d Γ Λ (.inl r e) (.union l r)
  | inr {Ξ Ψ f b d Γ Λ} {e : Expr} {l r : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e r → HasType Δ Ξ Ψ f b d Γ Λ (.inr l e) (.union l r)
  /-- 網羅: 2 バリアントとも腕が要る（default 無し） -/
  | case {Ξ Ψ f b d Γ Λ} {e bl br : Expr} {l r τ : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.union l r) → HasType Δ Ξ Ψ f b d (l :: Γ) Λ bl τ →
      HasType Δ Ξ Ψ f b d (r :: Γ) Λ br τ →
      HasType Δ Ξ Ψ f b d Γ Λ (.case e bl br) τ
  | pair {Ξ Ψ f b d Γ Λ} {a c : Expr} {l r : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ a l → HasType Δ Ξ Ψ f b d Γ Λ c r →
      HasType Δ Ξ Ψ f b d Γ Λ (.pair a c) (.prod l r)
  | fst {Ξ Ψ f b d Γ Λ} {e : Expr} {l r : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.prod l r) → HasType Δ Ξ Ψ f b d Γ Λ (.fst e) l
  | snd {Ξ Ψ f b d Γ Λ} {e : Expr} {l r : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.prod l r) → HasType Δ Ξ Ψ f b d Γ Λ (.snd e) r
  /-- 一階関数の呼び出し（round4: 同世界化）。Def は base（region 0 = 圧縮された
  呼び手空間、1 = 自フレーム）で一度だけ型付けされ（DefsOk）、呼び出しが一様シフト
  +d で instantiate する（呼び手深さ = d + 1、フレーム region = d）。
  引数は浅い imm 共変（Ty.sub）で param.shiftR d に合わせる — 機械は coerceTo で
  注釈を書き換えて渡す。戻り値は ret.relocR d（round5: fretK の relocate が最上段を
  呼び手最内 = region d へ写すので、上界も d に締める — 結果の再転送が型を通る）。
  `b ≤ d`: 戻りの relocate が呼び手フレーム（region d）に書くので、共有 region の
  直上では呼べない — タスクは自分の block を開いてから call（alloc と同型の制約） -/
  | call {Ξ Ψ f b d Γ Λ} {fn : Nat} {ts : List Ty} {e : Expr} {dfn : Def} {ta : Ty} :
      Δ[fn]? = some dfn → ts.length = dfn.tparams → Ty.tyArgsOk ts = true →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e ta →
      Ty.sub ta ((dfn.inst ts).param.shiftR d) = true → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.call fn ts e) ((dfn.inst ts).ret.relocR d)
  /-- anchor つき呼び出し（R2 = region 多相の裁定 Q、anchor 1 slot）: call の一般化。Def の region 0
  （圧縮された呼び手空間 — 暗黙の region 変数）を、引数の mut 位置の region a（anchor — 型から読む）で
  instantiate する（写像 rmap a d: 0 ↦ a、k + 1 ↦ k + 1 + d）。mut は正確一致（Ty.sub は mut を動かさない）
  なので、mut 実引数の region が呼び手の束縛の region そのものになる — mut 引数の関数を展開せず、
  再帰に持ち込める。imm 引数は anchor 以下（region 0 の上界）。`b ≤ a`: 共有 region へは書けない。
  戻り値は relocA a d（region 0 由来の最上段は a、自フレーム由来は d）。a = d のとき call と同じ -/
  | callM {Ξ Ψ f b d Γ Λ} {fn : Nat} {ts : List Ty} {e : Expr} {dfn : Def} {ta : Ty} {a : Nat} :
      Δ[fn]? = some dfn → ts.length = dfn.tparams → Ty.tyArgsOk ts = true →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e ta →
      Ty.anchorOf (dfn.inst ts).param ta = some a →
      Ty.sub ta ((dfn.inst ts).param.renR a d) = true → b ≤ a → a ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.callM fn ts e) ((dfn.inst ts).ret.relocA a d)
  /-- 閉じた関数値（V3-1）: Def 参照の型は Def のシグネチャ（base 座標の型スキーム）。
  環境を持たないので深さ・世界に依らず型が付く -/
  | fnref {Ξ Ψ f b d Γ Λ} {fn : Nat} {ts : List Ty} {dfn : Def} :
      Δ[fn]? = some dfn → ts.length = dfn.tparams → Ty.tyArgsOk ts = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.fnref fn ts) (.fn (dfn.inst ts).param (dfn.inst ts).ret)
  /-- 関数値の呼び出し: call と同じ形（シグネチャを関数値の型から取る）。
  機械は `callv (fnref i) v ⟶ call i v` で call に委譲する -/
  | callv {Ξ Ψ f b d Γ Λ} {ef e : Expr} {p r ta : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ ef (.fn p r) → HasType Δ Ξ Ψ f b (d + 1) Γ Λ e ta →
      Ty.sub ta (p.shiftR d) = true → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.callv ef e) (r.relocR d)
  /-- anchor つきの関数値の呼び出し（L1 — 借りの閉包の mut 捕捉）: callv の anchor 版。anchor a は構文の注釈で、
  前提は callM の規則からシグネチャを関数値の型へ置き換えたもの。機械は `callMv a (fnref i) v ⟶ callM の入口（anchor = a）` -/
  | callMv {Ξ Ψ f b d Γ Λ} {a : Nat} {ef e : Expr} {p r ta : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ ef (.fn p r) → HasType Δ Ξ Ψ f b (d + 1) Γ Λ e ta →
      Ty.sub ta (p.renR a d) = true → b ≤ a → a ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.callMv a ef e) (r.relocA a d)
  /-- 型注釈（V3-5）: 部分型へ緩める。値は変えない（imm 上界の slack と注釈値の coerceTo） -/
  | ann {Ξ Ψ f b d Γ Λ} {e : Expr} {ta t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e ta → Ty.sub ta t = true → HasType Δ Ξ Ψ f b d Γ Λ (.ann e t) t
  /-- region 境界。本体は 1 段深く、結果型は自分の region（レベル d）に言及しない（escape 検査） -/
  | block {Ξ Ψ f b d Γ Λ} {e : Expr} {t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e t → t.regionsBelow d → HasType Δ Ξ Ψ f b d Γ Λ (.block e) t
  /-- 出口で写すブロック（R5）: 本体の型 tB はブロックの region を指してよく、結果型 t は親の最内 d - 1 へ締めて
  浅い共変で緩めた型（jump の規則と同じ jumpRel — ブロックの出口は暗黙のラベルへの脱出）。t は親の世界の型 -/
  | blockR {Ξ Ψ f b d Γ Λ} {e : Expr} {tB t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e tB → Ty.jumpRel b (d - 1) tB t = true → t.regionsBelow d →
      HasType Δ Ξ Ψ f b d Γ Λ (.blockR t e) t
  /-- 境界コピー式（宛先構築レーン M3）: e の値を外側の region k（k < d — 最内は d - 1）へ写す。結果型 t は値の型 tE を k へ締めて
  浅い共変で緩めた型（jumpRel — blockR・jump と同じ関係）で、region k 以下しか指さない（写した先のセルの region へそのまま格納できる）。
  chan は持たない（写すのは region のデータ — chan は写せない） -/
  | copyTo {Ξ Ψ f b d Γ Λ} {k : Nat} {e : Expr} {tE t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e tE → k < d → Ty.jumpRel b k tE t = true → t.regionsBelow (k + 1) = true →
      t.chanFree = true → HasType Δ Ξ Ψ f b d Γ Λ (.copyTo k t e) t
  /-- 脱出先のラベル（V4）。本体はラベル環境を 1 つ伸ばして型付け、正常完了も t。
  結果型はラベルを置いた深さ d の region までしか言及しない — 深い region から jump で
  抜けるとき、値を value_strengthen で降ろす床（block の escape 検査と同じ形） -/
  | label {Ξ Ψ f b d Γ Λ} {e : Expr} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ ((t, d - 1) :: Λ) e t → t.regionsBelow d → HasType Δ Ξ Ψ f b d Γ Λ (.label t e) t
  /-- 脱出（V4）。n 番目のラベルへ値を持って抜ける。式としては戻らないので結果型は
  注釈 t のまま（任意の型を構文主導にする — V4-2 裁定 J1）。
  R4b（脱出の境界コピー）: ペイロードの型 tJ は深い region を指してよい — 巻き戻しで捨てる region（ラベルの最内 k より深い）の
  imm コンテナは中身ごと k へ写され、型は k へ締まる（jumpRel）。関数の return と同じ境界コピー -/
  | jump {Ξ Ψ f b d Γ Λ} {n : Nat} {e : Expr} {tL tJ t : Ty} {k : Nat} :
      Λ[n]? = some (tL, k) → HasType Δ Ξ Ψ f b d Γ Λ e tJ → Ty.jumpRel b k tJ tL = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.jump n t e) t
  /-- 到達しない（A5 — error の switch の覆っていない腕）。値を作らず評価に来たら panic なので、結果型は注釈 t のまま
  （jump と同じく任意の型を構文主導にする。前提なし — 値を作らないので region の座標の約束が生じない） -/
  | unreach {Ξ Ψ f b d Γ Λ} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ (.unreach t) t
  /-- 最内 region（レベル d）への割り当て。深さ d+1 でのみ書ける。
  - 格納型は region ≤ d しか言及できない（代入で若い loc を古いセルに書く抜け道を塞ぐ）
  - `b ≤ d`: 共有 region には割り当てられない（タスクは自分の block を開いてから alloc）
  - immutable セルの格納型は深く mutFree（共有される可能性があるため。段 3b） -/
  | alloc {Ξ Ψ f b d Γ Λ} {m : Bool} {e : Expr} {t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e t → t.regionsBelow (d + 1) → b ≤ d →
      (m = false → t.mutFree) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.alloc m e) (.ref m d t)
  | deref {Ξ Ψ f b d Γ Λ} {e : Expr} {m : Bool} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.ref m r t) → HasType Δ Ξ Ψ f b d Γ Λ (.deref e) t
  /-- `l := e`。mut 参照にのみ書ける。unit を返す -/
  | assign {Ξ Ψ f b d Γ Λ} {l e : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ l (.ref true r t) → HasType Δ Ξ Ψ f b d Γ Λ e t →
      HasType Δ Ξ Ψ f b d Γ Λ (.assign l e) .unit
  /-- `while c { b }`。b の値は捨てるので型は任意 -/
  | whileE {Ξ Ψ f b d Γ Λ} {c body : Expr} {τ : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c .bool → HasType Δ Ξ Ψ f b d Γ Λ body τ →
      HasType Δ Ξ Ψ f b d Γ Λ (.whileE c body) .unit
  /-- freeze: mut 参照を immutable 参照へ。格納型は深く mutFree（immutable セルの不変条件）。
  セルのタグは実行で false に倒れる（型は静的に付け替え、整合は preservation が StoreLE で運ぶ） -/
  | freeze {Ξ Ψ f b d Γ Λ} {e : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.ref true r t) → t.mutFree →
      HasType Δ Ξ Ψ f b d Γ Λ (.freeze e) (.ref false r t)
  /-- 空 slice を最内 region に作る。制約は alloc と同型（格納型は region ≤ d、
  共有 region には作れない、imm は深く mutFree） -/
  | mkslice {Ξ Ψ f b d Γ Λ} {m : Bool} {t : Ty} :
      t.regionsBelow (d + 1) → b ≤ d → (m = false → t.mutFree) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.mkslice m t) (.slice m d t)
  /-- string リテラル（strlit の段）: region r の imm byte セル列（byte の段 C — string = imm byte slice）。`b ≤ r`: region r へ書く（appendM と同じ — 共有 region には作れない）。
  `r < d`: region r が今の世界にある。r は注釈なので、Def 本体の r = 0（呼び手空間）は call / callM の写像で呼び手側へ写る -/
  | strlit {Ξ Ψ f b d Γ Λ} {bs : List Int} {r : Nat} :
      b ≤ r → r < d →
      HasType Δ Ξ Ψ f b d Γ Λ (.strlit bs r) (.slice false r .byte)
  /-- 空 slice を region r に作る（M3b — mkslice の region 指定版）: 床は mkslice と同じ形を region r で書く（`b ≤ r`・`r < d`）。
  chan を持たない要素型だけ（renTy の写像が region の上界を保つため — copyTo と同じ） -/
  | mksliceAt {Ξ Ψ f b d Γ Λ} {m : Bool} {t : Ty} {r : Nat} :
      t.regionsBelow (r + 1) → b ≤ r → r < d → (m = false → t.mutFree) → t.chanFree = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.mksliceAt m t r) (.slice m r t)
  /-- 空 map を region r に作る（mkmap の region 指定版） -/
  | mkmapAt {Ξ Ψ f b d Γ Λ} {m : Bool} {k t : Ty} {r : Nat} :
      k.keyOk → (Ty.prod k (.opt t)).regionsBelow (r + 1) → b ≤ r → r < d →
      (m = false → (Ty.prod k (.opt t)).mutFree) → (Ty.prod k (.opt t)).chanFree = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.mkmapAt m (.prod k (.opt t)) r) (.map m r (.prod k (.opt t)))
  /-- `xs[i]`。範囲は実行時検査（範囲外 panic — language.md 21 節） -/
  | index {Ξ Ψ f b d Γ Λ} {e i : Expr} {ot : Option Ty} {m : Bool} {r : Nat} {t' t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice m r t') → HasType Δ Ξ Ψ f b d Γ Λ i .int →
      Ty.readAs m ot t' = some t →
      HasType Δ Ξ Ψ f b d Γ Λ (.index e i ot) t
  | lenE {Ξ Ψ f b d Γ Λ} {e : Expr} {m : Bool} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice m r t) →
      HasType Δ Ξ Ψ f b d Γ Λ (.lenE e) .int
  /-- `byte(e)`（byte の段）: int → byte（範囲外は実行時に panic） -/
  | tobyte {Ξ Ψ f b d Γ Λ} {e : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ e .int → HasType Δ Ξ Ψ f b d Γ Λ (.tobyte e) .byte
  /-- `int(e)`: byte → int -/
  | toint {Ξ Ψ f b d Γ Λ} {e : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ e .byte → HasType Δ Ξ Ψ f b d Γ Λ (.toint e) .int
  /-- byte の値（実行時の項）: 0 ≤ n < 256 だけ — []byte のセルを 1 バイトに詰める lower の変換の健全性の前提 -/
  | blit {Ξ Ψ f b d Γ Λ} {n : Int} : 0 ≤ n → n < 256 → HasType Δ Ξ Ψ f b d Γ Λ (.blit n) .byte
  /-- float64 の値（float の段 — language.md 37 節）: どのビット列も float64 -/
  | flit {Ξ Ψ f b d Γ Λ} {n : Int} : HasType Δ Ξ Ψ f b d Γ Λ (.flit n) .f64
  | farith {Ξ Ψ f b d Γ Λ} {op : FArithOp} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .f64 → HasType Δ Ξ Ψ f b d Γ Λ c .f64 →
      HasType Δ Ξ Ψ f b d Γ Λ (.farith op a c) .f64
  | fcmp {Ξ Ψ f b d Γ Λ} {op : FCmpOp} {a c : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ a .f64 → HasType Δ Ξ Ψ f b d Γ Λ c .f64 →
      HasType Δ Ξ Ψ f b d Γ Λ (.fcmp op a c) .bool
  /-- 単項の写し: 被演算子は op.dom・結果は op.cod（toInt の NaN・範囲外は実行時に panic） -/
  | fconv {Ξ Ψ f b d Γ Λ} {op : FConvOp} {e : Expr} :
      HasType Δ Ξ Ψ f b d Γ Λ e op.dom → HasType Δ Ξ Ψ f b d Γ Λ (.fconv op e) op.cod
  /-- mut slice の append: region r（正確）の先端に書く（in-place もコピーも）。
  `b ≤ r`: 共有 region には書けない -/
  | appendM {Ξ Ψ f b d Γ Λ} {e v : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice true r t) → HasType Δ Ξ Ψ f b d Γ Λ v t → b ≤ r →
      HasType Δ Ξ Ψ f b d Γ Λ (.append e v) (.slice true r t)
  /-- imm slice の append: 現在の最内 region（レベル d）へ常に全コピー + 1 セル。
  imm の型 region は上界（round4）なので実 region に `b ≤ r` を静的に言えない —
  書き込み先を自フレームに固定して健全化（b ≤ d）。in-place 伸長は mut 限定になる。
  要素型の床 `t.regionsBelow (d + 1)` は新しいセルの床（R4b-cov: imm の slicev は要素型の床を運ばなくなった）
  （imm はセル不変なのでコピーは観測不能。language.md 21 節「現在の region へコピー」） -/
  | appendI {Ξ Ψ f b d Γ Λ} {e v : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e (.slice false r t) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ v t → b ≤ d → t.regionsBelow (d + 1) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.append e v) (.slice false d t)
  /-- `xs[i] = v`。mut slice のみ。タグ検査は assign と同じ動的な底 -/
  | setidx {Ξ Ψ f b d Γ Λ} {e i v : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice true r t) → HasType Δ Ξ Ψ f b d Γ Λ i .int →
      HasType Δ Ξ Ψ f b d Γ Λ v t →
      HasType Δ Ξ Ψ f b d Γ Λ (.setidx e i v) .unit
  /-- `xs[a:b]`（imm 限定 — language.md 21 節）: 同じセル列を指す新ヘッダ。
  割り当てゼロなので型 region は不変。範囲違反は panic -/
  | subslice {Ξ Ψ f b d Γ Λ} {e sa sb : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice false r t) → HasType Δ Ξ Ψ f b d Γ Λ sa .int →
      HasType Δ Ξ Ψ f b d Γ Λ sb .int →
      HasType Δ Ξ Ψ f b d Γ Λ (.subslice e sa sb) (.slice false r t)
  /-- `s == t`（string = imm byte slice の比較）: 長さ一致 + 全セル等値。
  int セル限定 — 構造的等価の一般化は辞書（Eq[T]）の領分 -/
  | eqs {Ξ Ψ f b d Γ Λ} {e1 e2 : Expr} {r1 r2 : Nat} :
      HasType Δ Ξ Ψ f b d Γ Λ e1 (.slice false r1 .byte) →
      HasType Δ Ξ Ψ f b d Γ Λ e2 (.slice false r2 .byte) →
      HasType Δ Ξ Ψ f b d Γ Λ (.eqs e1 e2) .bool
  /-- `s + t`（imm slice の連結）: 最内 region へ両方コピー（appendI と同じ床 b ≤ d） -/
  | concat {Ξ Ψ f b d Γ Λ} {e1 e2 : Expr} {r1 r2 : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e1 (.slice false r1 t) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e2 (.slice false r2 t) → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.concat e1 e2) (.slice false d t)
  /-- freeze の slice 版: 覆う範囲のタグをまとめて倒す。制約は freeze と同型 -/
  | freezes {Ξ Ψ f b d Γ Λ} {e : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.slice true r t) → t.mutFree →
      HasType Δ Ξ Ψ f b d Γ Λ (.freeze e) (.slice false r t)
  /-- 空 map を最内 region に作る。制約は mkslice と同型で、セル型 `prod k (opt t)` に対して書く。
  キー型の制限 keyOk はここだけ（R3） -/
  | mkmap {Ξ Ψ f b d Γ Λ} {m : Bool} {k t : Ty} :
      k.keyOk → (Ty.prod k (.opt t)).regionsBelow (d + 1) → b ≤ d →
      (m = false → (Ty.prod k (.opt t)).mutFree) →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.mkmap m (.prod k (.opt t))) (.map m d (.prod k (.opt t)))
  /-- `m[k]`。不在 = nil（t 注釈は構文主導のため）。探索キーはキー型と同種なら region を問わない -/
  | getm {Ξ Ψ f b d Γ Λ} {e k : Expr} {m : Bool} {r : Nat} {kt kq t' t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.map m r (.prod kt (.opt t'))) → HasType Δ Ξ Ψ f b d Γ Λ k kq →
      kq.keyCompat kt → Ty.sub t' t = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.getm t e k) (.opt t)
  /-- `m[k] = v`。mut map のみ。既存キーは in-place（タグ検査）、新規キーは region r の
  先端へ書く（b ≤ r はヘッダの m = true が運ぶ）。新しいヘッダを返す。
  キーはセルに格納されるのでキー型そのもの（緩めは ann — 内側 scope のキーは escape で落ちる） -/
  | setm {Ξ Ψ f b d Γ Λ} {e k v : Expr} {r : Nat} {kt t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.map true r (.prod kt (.opt t))) → HasType Δ Ξ Ψ f b d Γ Λ k kt →
      HasType Δ Ξ Ψ f b d Γ Λ v t →
      HasType Δ Ξ Ψ f b d Γ Λ (.setm e k v) (.map true r (.prod kt (.opt t)))
  /-- `delete(m, k)`。mut map のみ。墓石を in-place で書く（タグ検査）。unit を返す -/
  | delm {Ξ Ψ f b d Γ Λ} {e k : Expr} {r : Nat} {kt kq t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.map true r (.prod kt (.opt t))) → HasType Δ Ξ Ψ f b d Γ Λ k kq →
      kq.keyCompat kt →
      HasType Δ Ξ Ψ f b d Γ Λ (.delm t e k) .unit
  /-- `len(m)`。生きたエントリの数 -/
  | lenm {Ξ Ψ f b d Γ Λ} {e : Expr} {m : Bool} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.map m r t) →
      HasType Δ Ξ Ψ f b d Γ Λ (.lenm e) .int
  /-- `keys(m)`（keysm の段）: 生きたキーの挿入順の列を最内 region（レベル d）へ imm slice として作る
  （スナップショット — 以後の setm / delm は列に影響しない）。床は concat / appendI と同じ `b ≤ d`、
  新しいセルの型の床 `kt.regionsBelow (d + 1)`。キー型は keyOk（int | imm string — mutFree かつ注釈不要） -/
  | keysm {Ξ Ψ f b d Γ Λ} {e : Expr} {m : Bool} {r : Nat} {kt t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e (.map m r (.prod kt (.opt t))) →
      kt.keyOk → kt.regionsBelow (d + 1) → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.keysm e) (.slice false d kt)
  /-- `clone(x)` の slice 版（clone の段 — freeze の双対）: セル列を最内 region（レベル d）へ mut のセルとして写す。
  読み出しは index と同じ readAs（imm のセルの部分型を t へ揃える）。床は concat / keysm と同じ `b ≤ d`、
  新しいセルの型の床 `t.regionsBelow (d + 1)`。要素の中身は共有する（浅い写し） -/
  | clones {Ξ Ψ f b d Γ Λ} {e : Expr} {ot : Option Ty} {m : Bool} {r : Nat} {t' t : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e (.slice m r t') → Ty.readAs m ot t' = some t →
      t.regionsBelow (d + 1) → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.clone ot e) (.slice true d t)
  /-- `clone(m)` の map 版: セル（キーと値の組・墓石も）を挿入順のまま最内 region へ mut のセルとして写す。制約は clones と同型（セル型に対して） -/
  | clonem {Ξ Ψ f b d Γ Λ} {e : Expr} {ot : Option Ty} {m : Bool} {r : Nat} {c' c : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ e (.map m r c') → Ty.readAs m ot c' = some c →
      c.regionsBelow (d + 1) → b ≤ d →
      HasType Δ Ξ Ψ f b (d + 1) Γ Λ (.clone ot e) (.map true d c)
  /-- freeze の map 版。制約は freezes と同型 -/
  | freezem {Ξ Ψ f b d Γ Λ} {e : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ e (.map true r t) → t.mutFree →
      HasType Δ Ξ Ψ f b d Γ Λ (.freeze e) (.map false r t)
  /-- 並列実行。本体は共有境界 b = d（現在の全 region が共有扱い）で型付けし、
  Γ は mutFree な型のみ — 不変値・immutable 参照・チャネル（Sharable）がタスクに渡る。
  書き込み床 f は据え置く（本体の書き込みも region ≥ f でしか起きないため） -/
  | par {Ξ Ψ f b d Γ Λ} {e1 e2 : Expr} {t1 t2 : Ty} :
      HasType Δ Ξ Ψ f d d Γ [] e1 t1 → HasType Δ Ξ Ψ f d d Γ [] e2 t2 →
      (∀ t ∈ Γ, t.mutFree) →
      HasType Δ Ξ Ψ f b d Γ Λ (.par e1 e2) .unit
  /-- チャネルつき並列スコープ: rc = d（spawn 深度）のチャネルを作り、
  var 0 として両本体に渡して spawn する。ペイロードは region < d への imm 参照を含んでよい。
  b < rc の世界の単独 newchan ではスナップショットが安定しないため、生成と spawn を融合 -/
  | parch {Ξ Ψ f b d Γ Λ} {t : Ty} {e1 e2 : Expr} {t1 t2 : Ty} :
      HasType Δ Ξ Ψ f d d ((.chan d t) :: Γ) [] e1 t1 →
      HasType Δ Ξ Ψ f d d ((.chan d t) :: Γ) [] e2 t2 →
      (∀ τ ∈ Γ, τ.mutFree) → t.regionsBelow d → t.mutFree →
      HasType Δ Ξ Ψ f b d Γ Λ (.parch t e1 e2) .unit
  /-- 新しいチャネル。ペイロードの参照は region < rc 限定（mutFree = imm 参照のみ）。
  `rc ≤ f` が要: 以後の書き込みが region ≥ f ≥ rc なので、生成時のスナップショット
  `Ψ.take rc` が世界線全体で不変に保たれる（rc = 0 が段 3c の loc-free チャネル） -/
  | newchan {Ξ Ψ f b d Γ Λ} {rc : Nat} {t : Ty} :
      rc ≤ f → t.regionsBelow rc → t.mutFree →
      HasType Δ Ξ Ψ f b d Γ Λ (.newchan rc t) (.chan rc t)
  /-- 送信。無限バッファなので同期は片側（recv）だけ。unit を返す -/
  | send {Ξ Ψ f b d Γ Λ} {c e : Expr} {rc : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c (.chan rc t) → HasType Δ Ξ Ψ f b d Γ Λ e t →
      HasType Δ Ξ Ψ f b d Γ Λ (.send c e) .unit
  | recv {Ξ Ψ f b d Γ Λ} {c : Expr} {rc : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c (.chan rc t) → HasType Δ Ξ Ψ f b d Γ Λ (.recv c) t
  /-- 実行時参照。r < d が「解放済み region への参照は型が付かない」の中身。
  freeze 導入で ref の m とセルのタグ m' を分離（段 freeze）:
  - mut loc（m = true）は型のみに結ぶ（タグ不問）— freeze 後の古い mut エイリアスも
    型が付いたまま残り、書き込みは実行時のタグ検査（panic）が受ける。
    `b ≤ r` が「共有 region への書き込み権はタスクから見えない」の中身。
    mut の型 region は正確（rt = r）— 書き込み先は揺らせない
  - imm loc（m = false）はタグ false のセルに結ぶ — immutable の読みは常に安全。
    型 region は上界（r ≤ rt。round4: Def を base 1 で一度型付けして
    一様シフトで instantiate するための slack） -/
  | loc {Ξ Ψ f b d Γ Λ} {r a rt : Nat} {ρ : List (Bool × Ty)} {m m' : Bool} {t : Ty} :
      Ψ[r]? = some ρ → ρ[a]? = some (m', t) → r < d → r ≤ rt →
      (m = true → rt = r ∧ b ≤ r) → (m = false → m' = false) →
      HasType Δ Ξ Ψ f b d Γ Λ (.loc r a) (.ref m rt t)
  /-- 実行時 slice ヘッダ。loc 規則の範囲版:
  - 覆うセルは全て型 t（per-cell の量化 — 空 slice では base は無意味な値でよい）。
    m = false なら全セルのタグ false
  - `mt = m`（round4 で強化。旧: m = false → mt = false の片向き）— 機械の append が
    mt で mut/imm を判別して書き込み先を選ぶため、型の m と一致していないと
    書き込み先と型がズレる
  - m = true → rt = r ∧ b ≤ r（mut は正確 + 共有 region を指せない）。
    imm の型 region は上界（r ≤ rt。round4）
  - m = false → t は深く mutFree（imm タグのセルを append が書くための床）
  - `m = true → t.regionsBelow (r + 1)` は空 slice のための明示（非空なら HeapOk.tyBelow が同値を運ぶ）。
    mut append が region r の先端に型 t のセルを書くための床（imm append は最内 region へ書くので要らない）
  - imm のセル型 tc は要素型 t の部分型（R4b-cov: 深い共変 — 上界の緩みがセルの中へ届く）。mut は正確 -/
  | slicev {Ξ Ψ f b d Γ Λ} {mt : Bool} {r base len rt : Nat} {m : Bool} {t : Ty} :
      (∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
        (m = false → mk = false) ∧ Ty.sub tc t = true ∧ (m = true → tc = t)) →
      r < d → r ≤ rt → mt = m →
      (m = true → rt = r ∧ b ≤ r) →
      (m = false → t.mutFree = true) →
      (m = true → t.regionsBelow (r + 1)) →
      HasType Δ Ξ Ψ f b d Γ Λ (.slicev mt r base len) (.slice m rt t)
  /-- 実行時 map ヘッダ。slicev と同型（t はセル型） -/
  | mapv {Ξ Ψ f b d Γ Λ} {mt : Bool} {r base len rt : Nat} {m : Bool} {t : Ty} :
      (∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
        (m = false → mk = false) ∧ Ty.sub tc t = true ∧ (m = true → tc = t)) →
      r < d → r ≤ rt → mt = m →
      (m = true → rt = r ∧ b ≤ r) →
      (m = false → t.mutFree = true) →
      (m = true → t.regionsBelow (r + 1)) →
      HasType Δ Ξ Ψ f b d Γ Λ (.mapv mt r base len) (.map m rt t)
  /-- 実行時チャネル参照。型は Ξ が与える。
  - `Ψ.take rc = Ψc`: この世界はペイロードの参照先（共有プレフィクス）を
    スナップショットと同じ内容で持つ — send/recv の型付けの出会いの場所
  - `rc ≤ f`: 以後の書き込みがスナップショットに届かない（等式の保存の根拠） -/
  | chanV {Ξ Ψ f b d Γ Λ} {c : Nat} {Ψc : StoreTy} {t : Ty} :
      Ξ.ch[c]? = some (Ψc, t) → Ψ.take Ψc.length = Ψc → Ψc.length ≤ f →
      HasType Δ Ξ Ψ f b d Γ Λ (.chanV c) (.chan Ψc.length t)
  /-- 構造化スコープ（段 6 P1 — par.Scope）: blockR と同じく 1 段深い region で本体を評価し、値を親の最内へ写して返す。
  型は `union t (union unit ε')`（P3a A1 (X) — inr (inl triv) = 子の死・死因の中身はコアでは抽象。P3b-4 1b' — inr (inr e) = 未回収の失敗:
  ε = err の型の注釈〔imm・chan なし〕・ε' = ε を親の最内 region d - 1 へ締めた形 — 失敗の err は子のヒープからそこへ写る。
  そこが共有境界より上にあるよう b < d — task の本体と関数の本体は常に満たす）。
  本体は var 0 = scope の札（own scope d ε — d = 開いた region）・ラベルを越えない（Λ = [] — 出口の待ちを飛ばす脱出は無い） -/
  | scope {Ξ Ψ f b d Γ Λ} {e : Expr} {tB t ε : Ty} :
      HasType Δ Ξ Ψ f b (d + 1) (.own .scope d ε :: Γ) [] e tB → Ty.jumpRel b (d - 1) tB t = true →
      t.regionsBelow d → ε.mutFree = true → ε.chanFree = true → b < d →
      HasType Δ Ξ Ψ f b d Γ Λ (.scope t ε e) (.union t (.union .unit (ε.relocR (d - 1))))
  /-- 子の task を生む（par.Spawn）: 子へ渡す値 a は親の世界で型 ta が付き、ta は mutFree（写せる imm データ）・旧 chan なし・
  scope の region rs 以下（寿命結合 — 子が触る親の region は scope が閉じるまで生きている）。
  子の本体 e は閉じていて（文脈 = [ta]）、旧 par と同じく共有境界 = d（今の全 region が共有）で子自前の region d の中で型付く。
  型環境は親のまま（子の表 tk も親の分を引き継ぐ — 子自身の子は fam の o から後ろに積む。引き継いだ分の handle は b で型が付かない）。
  結果は imm（mutFree）で chan を持たない。handle の結果型は子の結果型の imm の region を全部 scope の region rs へ締めたもの
  （relocR rs — P3b-4: join / try が子のヒープから scope の region へ中身ごと写す〔xfer〕。旧 P1 は loc-free に限っていた）。
  P3b-4 1b': 子の本体の結果は常に組 `(t, err?)`（全 task をコアでは fallible に一様化 — error を返さない task は表層の脱糖が `pair v nil` で包む）。
  err の型 ε0 は札の ε と region を除いて一致（未回収の失敗は scope の出口で ε として写す） -/
  | spawn {Ξ Ψ f b d Γ Λ} {sc a e : Expr} {rs : Nat} {ta t ε ε0 : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ sc (.own .scope rs ε) → HasType Δ Ξ Ψ f b d Γ Λ a ta → ta.givable rs = true →
      HasType Δ Ξ Ψ f d (d + 1) [ta.rehome d] [] e (.prod t (.opt ε0)) → (Ty.prod t (.opt ε0)).mutFree → (Ty.prod t (.opt ε0)).chanFree →
      Ty.payOk ε0 ε = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.spawn sc a e) (.own .task rs ((Ty.prod t (.opt ε0)).relocR rs))
  /-- handle の結果を待つ（par.Join）。注釈 t = handle の結果型（子の結果を scope の region へ写すときに歩く型） -/
  | join {Ξ Ψ f b d Γ Λ} {h : Expr} {rs : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ h (.own .task rs t) → HasType Δ Ξ Ψ f b d Γ Λ (.join t h) t
  /-- 死を値として見る（par.Try）: 完了 = some v・死 = nil t -/
  | tryJ {Ξ Ψ f b d Γ Λ} {h : Expr} {rs : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ h (.own .task rs t) → HasType Δ Ξ Ψ f b d Γ Λ (.tryJ t h) (.opt t)
  /-- 実行時の scope の札。家の region rs はこの世界のもの（b ≤ rs — mut の loc と同じ。子の世界では型が付かない） -/
  | scopeV {Ξ Ψ f b d Γ Λ} {rs : Nat} {ε : Ty} :
      b ≤ rs → rs < d → HasType Δ Ξ Ψ f b d Γ Λ (.scopeV rs ε) (.own .scope rs ε)
  /-- 端点のチャネルを作る（段 6 P1）: 家の region r はこの世界のもの（b ≤ r < d — mut の loc と同じ）・容量は 1 以上・
  ペイロードは imm で chan なし（P3b-4b — 旧 P1 は loc-free。region を持つ値は送りで梱包・受けで受け手の最内へ写す）。送り端と受け端の組を返す -/
  | newch {Ξ Ψ f b d Γ Λ} {r cap : Nat} {t : Ty} :
      b ≤ r → r < d → 1 ≤ cap → t.mutFree = true → t.chanFree = true → t.regionsBelow d = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.newch r cap t) (.prod (.own .tx r t) (.own .rx r t))
  /-- 実行時の送り端: 家の region はこの世界のもの（子の世界では型が付かない — 捕獲も実行時の代入も構造で閉じる）・ペイロード型は共有の表 Ξ.ep
  （region を全部 0 へ締めた形 — 端点の型のペイロードの region は意味を持たない。P3b-4b） -/
  | epTx {Ξ Ψ f b d Γ Λ} {p : List Nat} {k r : Nat} {t : Ty} :
      b ≤ r → r < d → Ξ.ep.lookup (p, k) = some (t.relocR 0) → HasType Δ Ξ Ψ f b d Γ Λ (.epV p k true r) (.own .tx r t)
  /-- 実行時の受け端（epTx と同型） -/
  | epRx {Ξ Ψ f b d Γ Λ} {p : List Nat} {k r : Nat} {t : Ty} :
      b ≤ r → r < d → Ξ.ep.lookup (p, k) = some (t.relocR 0) → HasType Δ Ξ Ψ f b d Γ Λ (.epV p k false r) (.own .rx r t)
  /-- 送り端への送信（有界 — 満杯なら待つ・持ち主でなければ定義された panic）: 送る値の型はペイロード型と region を除いて一致（payOk —
  値は送りで梱包されるので region はどこでもよい。P3b-4b） -/
  | sendE {Ξ Ψ f b d Γ Λ} {c e : Expr} {r : Nat} {t te : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c (.own .tx r t) → HasType Δ Ξ Ψ f b d Γ Λ e te → Ty.payOk te t = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.send c e) .unit
  /-- 受け端からの受信（空なら待つ・持ち主でなければ定義された panic）: 受けた値は今の最内の region（d - 1）へ写る（P3b-4b）。
  型は `T?` — 閉じて空なら nil（P3b-4 ③） -/
  | recvE {Ξ Ψ f b d Γ Λ} {c : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c (.own .rx r t) → t.mutFree = true → t.chanFree = true →
      HasType Δ Ξ Ψ f b d Γ Λ (.recv c) (.opt (t.relocR (d - 1)))
  /-- 送り端を閉じる（P3b-4 ③ — 持ち主でなければ・閉じた後なら定義された panic） -/
  | closeE {Ξ Ψ f b d Γ Λ} {c : Expr} {r : Nat} {t : Ty} :
      HasType Δ Ξ Ψ f b d Γ Λ c (.own .tx r t) → HasType Δ Ξ Ψ f b d Γ Λ (.close c) .unit
  /-- 実行時の handle。結果型はこの世界の子の表（Ξ.tk — 世界ごと）が与える -/
  | taskV {Ξ Ψ f b d Γ Λ} {rs n : Nat} {t : Ty} :
      b ≤ rs → rs < d → Ξ.tk[n]? = some (rs, t) → HasType Δ Ξ Ψ f b d Γ Λ (.taskV rs n) (.own .task rs t)

/-- 引数境界の条件（round4 V1、R2 で mut を解禁）: 呼び手空間（region 0）への参照までを許す。
imm は上界、mut は正確（callM の anchor が呼び手の束縛の region を与える。call なら呼び手最内 d）。
chan は rc が正確（スナップショット長）でシフト・sub に馴染まないため断片外 -/
def Ty.paramOk (t : Ty) : Bool := t.regionsBelow 1 && t.chanFree

/-- 戻り値の条件（round4 V1、R4a で深く）: imm のコンテナ / 参照は、どの深さでも自フレーム（region < 2）まで
（中身も自フレーム可 — fretK の境界コピーが中身まで再帰して写す = 深い relocate）。mut は正確 region が relocation で壊れ、chan は rc が正確なので
どちらも境界を渡れない -/
def Ty.retOk : Ty → Bool
  | .int => true
  | .tvar _ => true
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.retOk
  | .union l r => l.retOk && r.retOk
  | .prod l r => l.retOk && r.retOk
  | .ref false r t => decide (r < 2) && t.retOk
  | .slice false r t => decide (r < 2) && t.retOk
  | .map false r t => decide (r < 2) && t.retOk
  | .ref true _ _ => false
  | .slice true _ _ => false
  | .map true _ _ => false
  | .chan _ _ => false
  -- 関数値は loc-free・閉じているので境界を渡れる
  | .fn _ _ => true
  | .own _ _ _ => false

/-- 関数表の整合（round4: 同世界化）: 各本体は base の世界
（Ξ = Ψ = []、f = 1、b = 0、d = 2 — region 0 = 圧縮された呼び手空間、1 = 自フレーム。R2 で b を 0 に:
mut 引数の region 0 へ書ける。b は無条件に下げられるので従来の本体はそのまま通る）で
引数 1 つの文脈から戻り値に型が付く。呼び出しは一様シフト +d で instantiate する -/
def DefsOk (Δ : Defs) : Prop :=
  ∀ (fn : Nat) (dfn : Def), Δ[fn]? = some dfn →
    dfn.param.paramOk = true ∧ dfn.ret.retOk = true ∧
    dfn.body.noNewchan = true ∧
    dfn.param.tvarsBelow dfn.tparams = true ∧ dfn.ret.tvarsBelow dfn.tparams = true ∧
    dfn.body.src = true ∧
    HasType Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body dfn.ret

end FS
