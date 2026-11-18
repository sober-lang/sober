/-!
# R3の確認（branch r3）: 項と実行を持つ小さな体系で、候補2（T@ρ）の健全性を確かめる

R3a は型の代数だけで、関数値の呼び出しの型規則を持たなかった。そのため、ジェネリックの本体の中で
関数値を呼ぶと結果の型が食い違う反例（report-r3-1.md）を見落とした。この体系は項・型付け・燃料つきの評価を持ち、
型付く項の評価がぶら下がり（err）にならないことを証明する。

- 型: int・型変数 `tvar i`（型引数そのもの・絶対座標のまま = B1）・`tat i ρ`（型引数を region ρ へ置き直した型 = T@ρ）・
  `box m r t`（region r の1セル。mut なら write できる。sliceへのappendの危険を表す）・直積・関数型（base座標のスキーム）
- 関数型の中へ代入するときは、型引数を region 0 へ置き直す（`σ.map (at 0)`）。関数型の中に素の型変数は書かない（callv の前提）
- 呼び出しのフレームは呼び手の最内の region に合わせる（返りの写しを先に済ませた形。base の region 1 = 呼び手の最内）。
  base の region 0 は anchor a へ写る（a = 呼び手の最内なら普通の call）
- 部分型: `tvar i ≤ tat i ρ`（i が cov の旗を持ち、ρ ≥ 1 = フレーム以上）・`tat i ρ ≤ tat i ρ'`（cov の旗を持ち ρ ≤ ρ'）
- 再帰型 `mu r b`（木は1つの region r）: 本体 b は局所座標で、`rvar k` が再帰の変数（de Bruijn。入れ子で相互再帰）。
  型引数を持たない（B1-a の型引数つきの μ は使わない）。本体の型変数は T@0（木の region に置いた T）として読み、
  代入は本体へ region 0 へ置き直した型引数を入れる。展開 `Ty.unf r b` は自分の出現を局所座標の自分にしてから全体を r へ置く。
  値は `fold` で作り `unfold` で1段開く。部分型は同じ本体で、深く共変な本体なら r ≤ r'。終端のために `opt`（none / some と case）を持つ
- kind は本体の計画と同じ旗の形（rf = region を持たない・mf = mut を持たない・cov = region を上げると部分型）。旗は独立に読む。
  本体の計画の cf は、端点を持たないこの体系では読む規則が無いので入れていない
- imm の ref `iref r t`（region r の1セル・中身の型は正確一致）を持つ。mut の box の像（`view`）で作り、`read` で読む。
  中身が region を持つ imm の ref は mut を持たないが共変でないので、mf と cov が別の旗になる（Ex8）
-/

namespace R3C

inductive Ty : Type where
  | int
  | tvar (i : Nat)
  | tat (i ρ : Nat)
  | box (m : Bool) (r : Nat) (t : Ty)
  /-- imm の ref: region r の1セル。中身の型は正確一致（部分型で緩めない）。mut の box の像（view）で作る -/
  | iref (r : Nat) (t : Ty)
  | prod (a b : Ty)
  | fn (p q : Ty)
  | opt (t : Ty)
  | rvar (i : Nat)
  | mu (r : Nat) (b : Ty)
  deriving DecidableEq, Repr

/-! ## 型の操作 -/

/-- 全部の region を k へ置き直す（関数型の中へは入らない）。型変数は T@k になる -/
def Ty.at (k : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tat i k
  | .tat i _ => .tat i k
  | .box m _ t => .box m k (t.at k)
  | .iref _ t => .iref k (t.at k)
  | .prod a b => .prod (a.at k) (b.at k)
  | .fn p q => .fn p q
  | .opt t => .opt (t.at k)
  | .rvar i => .rvar i
  | .mu _ b => .mu k b

/-- region の写像: 0（呼び手の空間）↦ a、それ以外は +δ -/
def rmap (a δ : Nat) : Nat → Nat
  | 0 => a
  | k + 1 => k + 1 + δ

/-- 型の写像（関数型の中へは入らない） -/
def Ty.ren (a δ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
  | .tat i ρ => .tat i (rmap a δ ρ)
  | .box m r t => .box m (rmap a δ r) (t.ren a δ)
  | .iref r t => .iref (rmap a δ r) (t.ren a δ)
  | .prod x y => .prod (x.ren a δ) (y.ren a δ)
  | .fn p q => .fn p q
  | .opt t => .opt (t.ren a δ)
  | .rvar i => .rvar i
  | .mu r b => .mu (rmap a δ r) b

def look (σ : List Ty) (i : Nat) : Ty := σ.getD i .int

/-- 型代入。型変数は型引数そのもの・T@ρ は型引数を ρ へ置き直したもの・関数型の中は型引数を 0 へ置き直してから -/
def Ty.tsubst : Ty → List Ty → Ty
  | .int, _ => .int
  | .tvar i, σ => look σ i
  | .tat i ρ, σ => (look σ i).at ρ
  | .box m r t, σ => .box m r (t.tsubst σ)
  | .iref r t, σ => .iref r (t.tsubst σ)
  | .prod a b, σ => .prod (a.tsubst σ) (b.tsubst σ)
  | .fn p q, σ => .fn (p.tsubst (σ.map (Ty.at 0))) (q.tsubst (σ.map (Ty.at 0)))
  | .opt t, σ => .opt (t.tsubst σ)
  | .rvar i, _ => .rvar i
  | .mu r b, σ => .mu r (b.tsubst (σ.map (Ty.at 0)))

/-- 型変数を含まない（関数型の中も） -/
def Ty.closed : Ty → Bool
  | .int => true
  | .tvar _ => false
  | .tat _ _ => false
  | .box _ _ t => t.closed
  | .iref _ t => t.closed
  | .prod a b => a.closed && b.closed
  | .fn p q => p.closed && q.closed
  | .opt t => t.closed
  | .rvar _ => true
  | .mu _ b => b.closed

/-- 素の型変数を含まない（関数型の中の型の条件） -/
def Ty.noTv : Ty → Bool
  | .int => true
  | .tvar _ => false
  | .tat _ _ => true
  | .box _ _ t => t.noTv
  | .iref _ t => t.noTv
  | .prod a b => a.noTv && b.noTv
  | .fn _ _ => true
  | .opt t => t.noTv
  | .rvar _ => true
  | .mu _ _ => true

/-- 素の型変数を T@0 にする（関数型の中の型の読み方。関数型の中へは入らない — 中の関数型は呼ぶときに読む） -/
def Ty.lowTv : Ty → Ty
  | .int => .int
  | .tvar i => .tat i 0
  | .tat i ρ => .tat i ρ
  | .box m r t => .box m r t.lowTv
  | .iref r t => .iref r t.lowTv
  | .prod a b => .prod a.lowTv b.lowTv
  | .fn p q => .fn p q
  | .opt t => .opt t.lowTv
  | .rvar i => .rvar i
  | .mu r b => .mu r b

/-- 型パラメータの kind（本体が使った性質の旗。本体の計画と同じ形）: rf = region を持たない・mf = mut を持たない・
cov = region を上げると部分型（深く共変）。旗が立っていない性質は仮定しない。範囲外は O（何も仮定しない）。
本体の計画の cf（chan / dom / own を持たない）は入れていない。この体系には端点が無く、cf を読む規則が無い -/
structure Kind where
  rf : Bool
  mf : Bool
  cov : Bool
  deriving DecidableEq, Repr

/-- 何も仮定しない（mut を持ちうる） -/
def Kind.O : Kind := ⟨false, false, false⟩
/-- mut を持たないが、region を上げると部分型にならない（imm の ref の中身が region を持つ） -/
def Kind.I : Kind := ⟨false, true, false⟩
/-- mut を持たず、深く共変 -/
def Kind.C : Kind := ⟨false, true, true⟩
/-- region を持たない -/
def Kind.R : Kind := ⟨true, true, true⟩

def kindOf (κ : List Kind) (i : Nat) : Kind := κ.getD i .O
def kindMut (κ : List Kind) (i : Nat) : Bool := !(kindOf κ i).mf
def kindRF (κ : List Kind) (i : Nat) : Bool := (kindOf κ i).rf
def kindCov (κ : List Kind) (i : Nat) : Bool := (kindOf κ i).cov

/-- mut を持たない（κ = 型変数ごとに mut を持ちうるか） -/
def Ty.mf (κ : List Kind) : Ty → Bool
  | .int => true
  | .tvar i => !kindMut κ i
  | .tat i _ => !kindMut κ i
  | .box m _ t => !m && t.mf κ
  | .iref _ t => t.mf κ
  | .prod a b => a.mf κ && b.mf κ
  | .fn _ _ => true
  | .opt t => t.mf κ
  | .rvar _ => true
  | .mu _ b => b.mf κ

/-- region がすべて k 未満（型変数は呼び手の空間に住むので数えない。型付けの深さはいつも 2 以上） -/
def Ty.rb (k : Nat) : Ty → Bool
  | .int => true
  | .tvar _ => true
  | .tat _ ρ => decide (ρ < k)
  | .box _ r t => decide (r < k) && t.rb k
  | .iref r t => decide (r < k) && t.rb k
  | .prod a b => a.rb k && b.rb k
  | .fn _ _ => true
  | .opt t => t.rb k
  | .rvar _ => true
  | .mu r _ => decide (r < k)

/-- 再帰の変数が k 未満（関数型の中は見ない） -/
def Ty.rc (k : Nat) : Ty → Bool
  | .int => true
  | .tvar _ => true
  | .tat _ _ => true
  | .box _ _ t => t.rc k
  | .iref _ t => t.rc k
  | .prod a b => a.rc k && b.rc k
  | .fn _ _ => true
  | .opt t => t.rc k
  | .rvar i => decide (i < k)
  | .mu _ b => b.rc (k + 1)

/-- region を持たない（関数型の外に box が無く、型変数は region を持たない kind だけ） -/
def Ty.rfK (κ : List Kind) : Ty → Bool
  | .int => true
  | .tvar i => kindRF κ i
  | .tat i _ => kindRF κ i
  | .box _ _ _ => false
  | .iref _ _ => false
  | .prod a b => a.rfK κ && b.rfK κ
  | .fn _ _ => true
  | .opt t => t.rfK κ
  | .rvar _ => true
  | .mu _ _ => false

/-- 深く共変（region を上げると部分型）: imm の box・値ラッパ・再帰型の本体。imm の ref は中身が region を持たないときだけ
（中身は正確一致。再帰の変数も region を持つ型の代わりなので、中身は再帰の変数について閉じている）。mut の box は持たない。型変数は cov の旗 -/
def Ty.cv (κ : List Kind) : Ty → Bool
  | .int => true
  | .tvar i => kindCov κ i
  | .tat i _ => kindCov κ i
  | .box m _ t => !m && t.cv κ
  | .iref _ t => t.rfK κ && t.rc 0
  | .prod a b => a.cv κ && b.cv κ
  | .fn _ _ => true
  | .opt t => t.cv κ
  | .rvar _ => true
  | .mu _ b => b.cv κ

/-- 部分型。L = 型変数の値が住む region の上界（base ではフレーム = 1） -/
def Ty.sub0 (κ : List Kind) (L : Nat) : Ty → Ty → Bool
  | .int, .int => true
  | .tvar i, .tvar j => i == j
  | .tvar i, .tat j ρ => i == j && kindCov κ i && decide (L ≤ ρ)
  | .tat i ρ, .tat j ρ' => i == j && (ρ == ρ' || (kindCov κ i && decide (ρ ≤ ρ')))
  | .box m r t, .box m' r' t' =>
      m == m' && (if m then r == r' && t == t' else decide (r ≤ r') && Ty.sub0 κ L t t')
  | .iref r t, .iref r' t' => decide (r ≤ r') && t == t'
  | .prod a b, .prod a' b' => Ty.sub0 κ L a a' && Ty.sub0 κ L b b'
  | .fn p q, .fn p' q' => p == p' && q == q'
  | .opt a, .opt a' => Ty.sub0 κ L a a'
  | .rvar i, .rvar j => i == j
  | .mu r b, .mu r' b' => b == b' && (r == r' || (b.cv κ && decide (r ≤ r')))
  | _, _ => false

/-- 閉じた型の部分型（型変数の腕は使われない） -/
abbrev csub (t t' : Ty) : Bool := Ty.sub0 [] 0 t t'

/-- region を持たない kind の型変数は、置き直しの添字を忘れる（T@ρ も T も T@0 に）。関数型の中も -/
def Ty.N (κ : List Kind) : Ty → Ty
  | .int => .int
  | .tvar i => if kindRF κ i then .tat i 0 else .tvar i
  | .tat i ρ => if kindRF κ i then .tat i 0 else .tat i ρ
  | .box m r t => .box m r (t.N κ)
  | .iref r t => .iref r (t.N κ)
  | .prod a b => .prod (a.N κ) (b.N κ)
  | .fn p q => .fn (p.N κ) (q.N κ)
  | .opt t => .opt (t.N κ)
  | .rvar i => .rvar i
  | .mu r b => .mu r (b.N κ)

/-- 型付けの部分型: 正規化してから比べる -/
def Ty.sub (κ : List Kind) (L : Nat) (t t' : Ty) : Bool := Ty.sub0 κ L (t.N κ) (t'.N κ)

/-- 再帰の変数 k に s を代入する（s は再帰の変数について閉じている）。関数型の中へは入らない（再帰は関数型を跨がない） -/
def Ty.rsubst : Ty → Nat → Ty → Ty
  | .int, _, _ => .int
  | .tvar i, _, _ => .tvar i
  | .tat i ρ, _, _ => .tat i ρ
  | .box m r t, k, s => .box m r (t.rsubst k s)
  | .iref r t, k, s => .iref r (t.rsubst k s)
  | .prod a b, k, s => .prod (a.rsubst k s) (b.rsubst k s)
  | .fn p q, _, _ => .fn p q
  | .opt t, k, s => .opt (t.rsubst k s)
  | .rvar i, k, s => if i = k then s else if k < i then .rvar (i - 1) else .rvar i
  | .mu r b, k, s => .mu r (b.rsubst (k + 1) s)

/-- 再帰型の1段の展開: 本体の自分の出現を「局所座標の自分」（mu 0 b）にし、全体を木の region r へ置く。
本体は局所座標（region はすべて木の region）なので、置き直し（at r）が本体の型変数 T@0 も T@r にする -/
def Ty.unf (r : Nat) (b : Ty) : Ty := (b.rsubst 0 (.mu 0 b)).at r

/-! ## 型の代数の補題 -/

theorem Ty.at_at (j k : Nat) : ∀ t : Ty, (t.at j).at k = t.at k
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.at, Ty.at_at j k t]
  | .iref r t => by simp [Ty.at, Ty.at_at j k t]
  | .prod a b => by simp [Ty.at, Ty.at_at j k a, Ty.at_at j k b]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.at_at j k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.ren_at (a δ k : Nat) : ∀ t : Ty, (t.at k).ren a δ = (t.ren a δ).at (rmap a δ k)
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.at, Ty.ren, Ty.ren_at a δ k t]
  | .iref r t => by simp [Ty.at, Ty.ren, Ty.ren_at a δ k t]
  | .prod x y => by simp [Ty.at, Ty.ren, Ty.ren_at a δ k x, Ty.ren_at a δ k y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.ren, Ty.ren_at a δ k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.at_ren (a δ k : Nat) : ∀ t : Ty, (t.ren a δ).at k = t.at k
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.at, Ty.ren, Ty.at_ren a δ k t]
  | .iref r t => by simp [Ty.at, Ty.ren, Ty.at_ren a δ k t]
  | .prod x y => by simp [Ty.at, Ty.ren, Ty.at_ren a δ k x, Ty.at_ren a δ k y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.ren, Ty.at_ren a δ k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem look_map (f : Ty → Ty) (hf : f .int = .int) (σ : List Ty) (i : Nat) :
    look (σ.map f) i = f (look σ i) := by
  unfold look
  induction σ generalizing i with
  | nil => simp [hf]
  | cons t σ ih =>
    cases i with
    | zero => rfl
    | succ n => simp only [List.map_cons, List.getD_cons_succ]; exact ih n

theorem map_at_ren (a δ : Nat) (σ : List Ty) :
    (σ.map (Ty.ren a δ)).map (Ty.at 0) = σ.map (Ty.at 0) := by
  simp [Function.comp_def, Ty.at_ren]

/-- 代入と写像の可換性（型引数も写す） -/
theorem Ty.ren_tsubst (a δ : Nat) : ∀ (t : Ty) (σ : List Ty),
    (t.tsubst σ).ren a δ = (t.ren a δ).tsubst (σ.map (Ty.ren a δ))
  | .int, _ => rfl
  | .tvar i, σ => by simp [Ty.tsubst, Ty.ren, look_map (Ty.ren a δ) rfl]
  | .tat i ρ, σ => by simp [Ty.tsubst, Ty.ren, look_map (Ty.ren a δ) rfl, Ty.ren_at]
  | .box m r t, σ => by simp [Ty.tsubst, Ty.ren, Ty.ren_tsubst a δ t σ]
  | .iref r t, σ => by simp [Ty.tsubst, Ty.ren, Ty.ren_tsubst a δ t σ]
  | .prod x y, σ => by simp [Ty.tsubst, Ty.ren, Ty.ren_tsubst a δ x σ, Ty.ren_tsubst a δ y σ]
  | .fn p q, σ => by simp only [Ty.tsubst, Ty.ren, map_at_ren]
  | .opt t, σ => by simp [Ty.tsubst, Ty.ren, Ty.ren_tsubst a δ t σ]
  | .rvar _, _ => rfl
  | .mu r b, σ => by simp only [Ty.tsubst, Ty.ren, map_at_ren]

theorem Ty.tsubst_at_map (k : Nat) : ∀ (t : Ty) (σ : List Ty),
    (t.tsubst (σ.map (Ty.at 0))).at k = (t.tsubst σ).at k
  | .int, _ => rfl
  | .tvar i, σ => by simp [Ty.tsubst, look_map (Ty.at 0) rfl, Ty.at_at]
  | .tat i ρ, σ => by simp [Ty.tsubst, look_map (Ty.at 0) rfl, Ty.at_at]
  | .box m r t, σ => by simp [Ty.tsubst, Ty.at, Ty.tsubst_at_map k t σ]
  | .iref r t, σ => by simp [Ty.tsubst, Ty.at, Ty.tsubst_at_map k t σ]
  | .prod x y, σ => by simp [Ty.tsubst, Ty.at, Ty.tsubst_at_map k x σ, Ty.tsubst_at_map k y σ]
  | .fn p q, σ => by
    simp [Ty.tsubst, Ty.at, Function.comp_def, Ty.at_at]
  | .opt t, σ => by simp [Ty.tsubst, Ty.at, Ty.tsubst_at_map k t σ]
  | .rvar _, _ => rfl
  | .mu r b, σ => by
    simp [Ty.tsubst, Ty.at, Function.comp_def, Ty.at_at]

theorem Ty.at_tsubst (k : Nat) : ∀ (t : Ty) (σ : List Ty), (t.at k).tsubst σ = (t.tsubst σ).at k
  | .int, _ => rfl
  | .tvar i, σ => rfl
  | .tat i ρ, σ => by simp [Ty.at, Ty.tsubst, Ty.at_at]
  | .box m r t, σ => by simp [Ty.tsubst, Ty.at, Ty.at_tsubst k t σ]
  | .iref r t, σ => by simp [Ty.tsubst, Ty.at, Ty.at_tsubst k t σ]
  | .prod x y, σ => by simp [Ty.tsubst, Ty.at, Ty.at_tsubst k x σ, Ty.at_tsubst k y σ]
  | .fn p q, σ => rfl
  | .opt t, σ => by simp [Ty.tsubst, Ty.at, Ty.at_tsubst k t σ]
  | .rvar _, _ => rfl
  | .mu r b, σ => rfl

/-- 代入の合成（範囲外の型変数は int なので、条件なし） -/
theorem Ty.tsubst_comp : ∀ (t : Ty) (τ σ : List Ty),
    (t.tsubst τ).tsubst σ = t.tsubst (τ.map (Ty.tsubst · σ))
  | .int, _, _ => rfl
  | .tvar i, τ, σ => by simp [Ty.tsubst, look_map (Ty.tsubst · σ) rfl]
  | .tat i ρ, τ, σ => by simp [Ty.tsubst, look_map (Ty.tsubst · σ) rfl, Ty.at_tsubst]
  | .box m r t, τ, σ => by simp [Ty.tsubst, Ty.tsubst_comp t τ σ]
  | .iref r t, τ, σ => by simp [Ty.tsubst, Ty.tsubst_comp t τ σ]
  | .prod x y, τ, σ => by simp [Ty.tsubst, Ty.tsubst_comp x τ σ, Ty.tsubst_comp y τ σ]
  | .fn p q, τ, σ => by
    simp only [Ty.tsubst, Ty.tsubst_comp p, Ty.tsubst_comp q, List.map_map]
    have : ((fun x => x.tsubst (σ.map (Ty.at 0))) ∘ Ty.at 0) = (Ty.at 0 ∘ fun x => x.tsubst σ) := by
      funext x; simp [Ty.at_tsubst, Ty.tsubst_at_map]
    rw [this]
  | .opt t, τ, σ => by simp [Ty.tsubst, Ty.tsubst_comp t τ σ]
  | .rvar _, _, _ => rfl
  | .mu r b, τ, σ => by
    simp only [Ty.tsubst, Ty.tsubst_comp b, List.map_map]
    have : ((fun x => x.tsubst (σ.map (Ty.at 0))) ∘ Ty.at 0) = (Ty.at 0 ∘ fun x => x.tsubst σ) := by
      funext x; simp [Ty.at_tsubst, Ty.tsubst_at_map]
    rw [this]

/-- 写像の合成 -/
theorem rmap_comp (a d a' δ : Nat) (r : Nat) : rmap a' δ (rmap a d r) = rmap (rmap a' δ a) (d + δ) r := by
  cases r with
  | zero => rfl
  | succ k =>
    have : k + 1 + d = (k + d) + 1 := by omega
    simp only [rmap, this]; omega

theorem Ty.ren_ren (a d a' δ : Nat) : ∀ t : Ty, (t.ren a d).ren a' δ = t.ren (rmap a' δ a) (d + δ)
  | .int => rfl
  | .tvar _ => rfl
  | .tat i ρ => by simp [Ty.ren, rmap_comp]
  | .box m r t => by simp [Ty.ren, rmap_comp, Ty.ren_ren a d a' δ t]
  | .iref r t => by simp [Ty.ren, rmap_comp, Ty.ren_ren a d a' δ t]
  | .prod x y => by simp [Ty.ren, Ty.ren_ren a d a' δ x, Ty.ren_ren a d a' δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.ren_ren a d a' δ t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.ren, rmap_comp]

/-- 素の型変数を持たない型は、型引数の置き直しに依らない -/
theorem Ty.tsubst_noTv (k : Nat) : ∀ (t : Ty) (σ : List Ty), t.noTv = true →
    t.tsubst (σ.map (Ty.at k)) = t.tsubst σ
  | .int, _, _ => rfl
  | .tvar _, _, h => by simp [Ty.noTv] at h
  | .tat i ρ, σ, _ => by simp [Ty.tsubst, look_map (Ty.at k) rfl, Ty.at_at]
  | .box m r t, σ, h => by simp [Ty.noTv] at h; simp [Ty.tsubst, Ty.tsubst_noTv k t σ h]
  | .iref r t, σ, h => by simp [Ty.noTv] at h; simp [Ty.tsubst, Ty.tsubst_noTv k t σ h]
  | .prod x y, σ, h => by
    simp [Ty.noTv] at h; simp [Ty.tsubst, Ty.tsubst_noTv k x σ h.1, Ty.tsubst_noTv k y σ h.2]
  | .fn p q, σ, _ => by
    simp only [Ty.tsubst, List.map_map]
    have : (Ty.at 0 ∘ Ty.at k) = Ty.at 0 := by funext x; simp [Ty.at_at]
    rw [this]
  | .opt t, σ, h => by simp [Ty.noTv] at h; simp [Ty.tsubst, Ty.tsubst_noTv k t σ h]
  | .rvar _, _, _ => rfl
  | .mu r b, σ, _ => by
    simp only [Ty.tsubst, List.map_map]
    have : (Ty.at 0 ∘ Ty.at k) = Ty.at 0 := by funext x; simp [Ty.at_at]
    rw [this]

/-! ## 型の性質の補題（閉じた型・region の上界・mut） -/

theorem Ty.closed_at (k : Nat) : ∀ t : Ty, t.closed = true → (t.at k).closed = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box m r t, h => by simp [Ty.closed] at h; simp [Ty.at, Ty.closed, Ty.closed_at k t h]
  | .iref r t, h => by simp [Ty.closed] at h; simp [Ty.at, Ty.closed, Ty.closed_at k t h]
  | .prod x y, h => by
    simp [Ty.closed] at h; simp [Ty.at, Ty.closed, Ty.closed_at k x h.1, Ty.closed_at k y h.2]
  | .fn p q, h => h
  | .opt t, h => by simp [Ty.closed] at h; simp [Ty.at, Ty.closed, Ty.closed_at k t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => h

theorem look_closed {σ : List Ty} (h : ∀ s ∈ σ, s.closed = true) (i : Nat) : (look σ i).closed = true := by
  unfold look
  rw [List.getD_eq_getElem?_getD]
  cases hi : σ[i]? with
  | none => rfl
  | some s => exact h s (List.mem_of_getElem? hi)

theorem Ty.closed_tsubst : ∀ (t : Ty) (σ : List Ty), (∀ s ∈ σ, s.closed = true) → (t.tsubst σ).closed = true
  | .int, _, _ => rfl
  | .tvar i, σ, h => look_closed h i
  | .tat i ρ, σ, h => Ty.closed_at ρ _ (look_closed h i)
  | .box m r t, σ, h => by simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst t σ h]
  | .iref r t, σ, h => by simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst t σ h]
  | .prod x y, σ, h => by simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst x σ h, Ty.closed_tsubst y σ h]
  | .fn p q, σ, h => by
    have h' : ∀ s ∈ σ.map (Ty.at 0), s.closed = true := by
      intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at 0 s0 (h s0 hs0)
    simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst p _ h', Ty.closed_tsubst q _ h']
  | .opt t, σ, h => by simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst t σ h]
  | .rvar _, _, _ => rfl
  | .mu r b, σ, h => by
    have h' : ∀ s ∈ σ.map (Ty.at 0), s.closed = true := by
      intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at 0 s0 (h s0 hs0)
    simp [Ty.tsubst, Ty.closed, Ty.closed_tsubst b _ h']

theorem Ty.rb_mono {k k' : Nat} (hk : k ≤ k') : ∀ t : Ty, t.rb k = true → t.rb k' = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .tat _ ρ, h => by simp [Ty.rb] at h ⊢; omega
  | .box m r t, h => by simp [Ty.rb] at h ⊢; exact ⟨by omega, Ty.rb_mono hk t h.2⟩
  | .iref r t, h => by simp [Ty.rb] at h ⊢; exact ⟨by omega, Ty.rb_mono hk t h.2⟩
  | .prod x y, h => by simp [Ty.rb] at h ⊢; exact ⟨Ty.rb_mono hk x h.1, Ty.rb_mono hk y h.2⟩
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rb] at h ⊢; exact Ty.rb_mono hk t h
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rb] at h ⊢; omega

theorem Ty.rb_at {k j : Nat} (hj : j < k) : ∀ t : Ty, (t.at j).rb k = true
  | .int => rfl
  | .tvar _ => by simp [Ty.at, Ty.rb]; omega
  | .tat _ _ => by simp [Ty.at, Ty.rb]; omega
  | .box m r t => by simp [Ty.at, Ty.rb]; exact ⟨hj, Ty.rb_at hj t⟩
  | .iref r t => by simp [Ty.at, Ty.rb]; exact ⟨hj, Ty.rb_at hj t⟩
  | .prod x y => by simp [Ty.at, Ty.rb]; exact ⟨Ty.rb_at hj x, Ty.rb_at hj y⟩
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.rb]; exact Ty.rb_at hj t
  | .rvar _ => rfl
  | .mu _ _ => by simp [Ty.at, Ty.rb]; omega

theorem look_rb {σ : List Ty} {k : Nat} (h : ∀ s ∈ σ, s.rb k = true) (i : Nat) : (look σ i).rb k = true := by
  unfold look
  rw [List.getD_eq_getElem?_getD]
  cases hi : σ[i]? with
  | none => rfl
  | some s => exact h s (List.mem_of_getElem? hi)

theorem Ty.rb_tsubst {k : Nat} : ∀ (t : Ty) (σ : List Ty), t.rb k = true → (∀ s ∈ σ, s.rb k = true) →
    (t.tsubst σ).rb k = true
  | .int, _, _, _ => rfl
  | .tvar i, σ, _, h => look_rb h i
  | .tat i ρ, σ, ht, _ => by simp [Ty.rb] at ht; exact Ty.rb_at ht _
  | .box m r t, σ, ht, h => by
    simp [Ty.rb] at ht; simp [Ty.tsubst, Ty.rb, ht.1, Ty.rb_tsubst t σ ht.2 h]
  | .iref r t, σ, ht, h => by
    simp [Ty.rb] at ht; simp [Ty.tsubst, Ty.rb, ht.1, Ty.rb_tsubst t σ ht.2 h]
  | .prod x y, σ, ht, h => by
    simp [Ty.rb] at ht; simp [Ty.tsubst, Ty.rb, Ty.rb_tsubst x σ ht.1 h, Ty.rb_tsubst y σ ht.2 h]
  | .fn _ _, _, _, _ => rfl
  | .opt t, σ, ht, h => by simp [Ty.rb] at ht; simp [Ty.tsubst, Ty.rb, Ty.rb_tsubst t σ ht h]
  | .rvar _, _, _, _ => rfl
  | .mu _ _, _, ht, _ => by simpa [Ty.tsubst, Ty.rb] using ht

theorem rmap_lt {a δ D r : Nat} (ha : a < D + δ) (hr : r < D) : rmap a δ r < D + δ := by
  cases r with
  | zero => exact ha
  | succ k => simp [rmap]; omega

theorem Ty.rb_ren {a δ D : Nat} (ha : a < D + δ) : ∀ t : Ty, t.rb D = true → (t.ren a δ).rb (D + δ) = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .tat _ ρ, h => by simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, rmap_lt ha h]
  | .box m r t, h => by
    simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, rmap_lt ha h.1, Ty.rb_ren ha t h.2]
  | .iref r t, h => by
    simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, rmap_lt ha h.1, Ty.rb_ren ha t h.2]
  | .prod x y, h => by simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, Ty.rb_ren ha x h.1, Ty.rb_ren ha y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, Ty.rb_ren ha t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rb] at h; simp [Ty.ren, Ty.rb, rmap_lt ha h]

theorem Ty.mf_at (κ : List Kind) (k : Nat) : ∀ t : Ty, (t.at k).mf κ = t.mf κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.at, Ty.mf, Ty.mf_at κ k t]
  | .iref r t => by simp [Ty.at, Ty.mf, Ty.mf_at κ k t]
  | .prod x y => by simp [Ty.at, Ty.mf, Ty.mf_at κ k x, Ty.mf_at κ k y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.mf, Ty.mf_at κ k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.mf_ren (κ : List Kind) (a δ : Nat) : ∀ t : Ty, (t.ren a δ).mf κ = t.mf κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.ren, Ty.mf, Ty.mf_ren κ a δ t]
  | .iref r t => by simp [Ty.ren, Ty.mf, Ty.mf_ren κ a δ t]
  | .prod x y => by simp [Ty.ren, Ty.mf, Ty.mf_ren κ a δ x, Ty.mf_ren κ a δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.mf, Ty.mf_ren κ a δ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.mf_tsubst {κ κ' : List Kind} : ∀ (t : Ty) (σ : List Ty), t.mf κ = true →
    (∀ i, kindMut κ i = false → (look σ i).mf κ' = true) → (t.tsubst σ).mf κ' = true
  | .int, _, _, _ => rfl
  | .tvar i, σ, ht, h => by simp [Ty.mf] at ht; exact h i ht
  | .tat i ρ, σ, ht, h => by simp [Ty.mf] at ht; simp [Ty.tsubst, Ty.mf_at, h i ht]
  | .box m r t, σ, ht, h => by
    simp [Ty.mf] at ht; simp [Ty.tsubst, Ty.mf, ht.1, Ty.mf_tsubst t σ ht.2 h]
  | .iref r t, σ, ht, h => by
    simp [Ty.mf] at ht; simp [Ty.tsubst, Ty.mf, Ty.mf_tsubst t σ ht h]
  | .prod x y, σ, ht, h => by
    simp [Ty.mf] at ht; simp [Ty.tsubst, Ty.mf, Ty.mf_tsubst x σ ht.1 h, Ty.mf_tsubst y σ ht.2 h]
  | .fn _ _, _, _, _ => rfl
  | .opt t, σ, ht, h => by simp [Ty.mf] at ht; simp [Ty.tsubst, Ty.mf, Ty.mf_tsubst t σ ht h]
  | .rvar _, _, _, _ => rfl
  | .mu r b, σ, ht, h => by
    simp [Ty.mf] at ht; simp only [Ty.tsubst, Ty.mf]
    exact Ty.mf_tsubst b _ ht (fun i hi => by rw [look_map (Ty.at 0) rfl, Ty.mf_at]; exact h i hi)

theorem Ty.noTv_ren (a δ : Nat) : ∀ t : Ty, (t.ren a δ).noTv = t.noTv
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.ren, Ty.noTv, Ty.noTv_ren a δ t]
  | .iref r t => by simp [Ty.ren, Ty.noTv, Ty.noTv_ren a δ t]
  | .prod x y => by simp [Ty.ren, Ty.noTv, Ty.noTv_ren a δ x, Ty.noTv_ren a δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.noTv, Ty.noTv_ren a δ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

/-- 置き直した後は、写像の前後で同じ（region を全部上書きするので） -/
theorem Ty.at_tsubst_ren (a δ k : Nat) : ∀ (t : Ty) (σ : List Ty),
    ((t.ren a δ).tsubst σ).at k = (t.tsubst σ).at k
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .tat i ρ, σ => by simp [Ty.ren, Ty.tsubst, Ty.at_at]
  | .box m r t, σ => by simp [Ty.ren, Ty.tsubst, Ty.at, Ty.at_tsubst_ren a δ k t σ]
  | .iref r t, σ => by simp [Ty.ren, Ty.tsubst, Ty.at, Ty.at_tsubst_ren a δ k t σ]
  | .prod x y, σ => by simp [Ty.ren, Ty.tsubst, Ty.at, Ty.at_tsubst_ren a δ k x σ, Ty.at_tsubst_ren a δ k y σ]
  | .fn _ _, _ => rfl
  | .opt t, σ => by simp [Ty.ren, Ty.tsubst, Ty.at, Ty.at_tsubst_ren a δ k t σ]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.rc_mono : ∀ (t : Ty) {k k' : Nat}, k ≤ k' → t.rc k = true → t.rc k' = true
  | .int, _, _, _, _ => rfl
  | .tvar _, _, _, _, _ => rfl
  | .tat _ _, _, _, _, _ => rfl
  | .box _ _ t, _, _, hk, h => by simp [Ty.rc] at h ⊢; exact Ty.rc_mono t hk h
  | .iref _ t, _, _, hk, h => by simp [Ty.rc] at h ⊢; exact Ty.rc_mono t hk h
  | .prod x y, _, _, hk, h => by simp [Ty.rc] at h ⊢; exact ⟨Ty.rc_mono x hk h.1, Ty.rc_mono y hk h.2⟩
  | .fn _ _, _, _, _, _ => rfl
  | .opt t, _, _, hk, h => by simp [Ty.rc] at h ⊢; exact Ty.rc_mono t hk h
  | .rvar _, _, _, hk, h => by simp [Ty.rc] at h ⊢; omega
  | .mu _ b, _, _, hk, h => by simp [Ty.rc] at h ⊢; exact Ty.rc_mono b (by omega) h

theorem Ty.rc_at (j : Nat) : ∀ (t : Ty) (k : Nat), (t.at j).rc k = t.rc k
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .tat _ _, _ => rfl
  | .box _ _ t, k => by simp [Ty.at, Ty.rc, Ty.rc_at j t k]
  | .iref _ t, k => by simp [Ty.at, Ty.rc, Ty.rc_at j t k]
  | .prod x y, k => by simp [Ty.at, Ty.rc, Ty.rc_at j x k, Ty.rc_at j y k]
  | .fn _ _, _ => rfl
  | .opt t, k => by simp [Ty.at, Ty.rc, Ty.rc_at j t k]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.rc_ren (a δ : Nat) : ∀ (t : Ty) (k : Nat), (t.ren a δ).rc k = t.rc k
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .tat _ _, _ => rfl
  | .box _ _ t, k => by simp [Ty.ren, Ty.rc, Ty.rc_ren a δ t k]
  | .iref _ t, k => by simp [Ty.ren, Ty.rc, Ty.rc_ren a δ t k]
  | .prod x y, k => by simp [Ty.ren, Ty.rc, Ty.rc_ren a δ x k, Ty.rc_ren a δ y k]
  | .fn _ _, _ => rfl
  | .opt t, k => by simp [Ty.ren, Ty.rc, Ty.rc_ren a δ t k]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem look_rc {σ : List Ty} (h : ∀ s ∈ σ, s.rc 0 = true) (i : Nat) : (look σ i).rc 0 = true := by
  unfold look; rw [List.getD_eq_getElem?_getD]
  cases hi : σ[i]? with
  | none => rfl
  | some s => exact h s (List.mem_of_getElem? hi)

theorem rc_map_at {σ : List Ty} (h : ∀ s ∈ σ, s.rc 0 = true) : ∀ s ∈ σ.map (Ty.at 0), s.rc 0 = true := by
  intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; rw [Ty.rc_at]; exact h s0 hs0

/-- 型引数が再帰の変数について閉じていれば、代入は再帰の変数の閉じ方を変えない -/
theorem Ty.rc_tsubst : ∀ (t : Ty) (σ : List Ty) (k : Nat), (∀ s ∈ σ, s.rc 0 = true) → (t.tsubst σ).rc k = t.rc k
  | .int, _, _, _ => rfl
  | .tvar i, σ, k, h => by simp only [Ty.tsubst, Ty.rc]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i)
  | .tat i ρ, σ, k, h => by
    simp only [Ty.tsubst, Ty.rc, Ty.rc_at]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i)
  | .box _ _ t, σ, k, h => by simp [Ty.tsubst, Ty.rc, Ty.rc_tsubst t σ k h]
  | .iref _ t, σ, k, h => by simp [Ty.tsubst, Ty.rc, Ty.rc_tsubst t σ k h]
  | .prod x y, σ, k, h => by simp [Ty.tsubst, Ty.rc, Ty.rc_tsubst x σ k h, Ty.rc_tsubst y σ k h]
  | .fn _ _, _, _, _ => rfl
  | .opt t, σ, k, h => by simp [Ty.tsubst, Ty.rc, Ty.rc_tsubst t σ k h]
  | .rvar _, _, _, _ => rfl
  | .mu _ b, σ, k, h => by simp [Ty.tsubst, Ty.rc, Ty.rc_tsubst b _ (k + 1) (rc_map_at h)]

theorem Ty.at_rfree (k : Nat) : ∀ s : Ty, s.closed = true → s.rfK [] = true → s.at k = s
  | .int, _, _ => rfl
  | .tvar _, h, _ => by simp [Ty.closed] at h
  | .tat _ _, h, _ => by simp [Ty.closed] at h
  | .box _ _ _, _, h => by simp [Ty.rfK] at h
  | .iref _ _, _, h => by simp [Ty.rfK] at h
  | .prod x y, hc, hr => by
    simp [Ty.closed] at hc; simp [Ty.rfK] at hr
    simp [Ty.at, Ty.at_rfree k x hc.1 hr.1, Ty.at_rfree k y hc.2 hr.2]
  | .fn _ _, _, _ => rfl
  | .opt t, hc, hr => by simp [Ty.closed] at hc; simp [Ty.rfK] at hr; simp [Ty.at, Ty.at_rfree k t hc hr]
  | .rvar _, _, _ => rfl
  | .mu _ _, _, h => by simp [Ty.rfK] at h

theorem Ty.rfK_at (κ : List Kind) (k : Nat) : ∀ s : Ty, (s.at k).rfK κ = s.rfK κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box _ _ _ => rfl
  | .iref _ _ => rfl
  | .prod x y => by simp [Ty.at, Ty.rfK, Ty.rfK_at κ k x, Ty.rfK_at κ k y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.rfK, Ty.rfK_at κ k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.rfK_ren (κ : List Kind) (a δ : Nat) : ∀ s : Ty, (s.ren a δ).rfK κ = s.rfK κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box _ _ _ => rfl
  | .iref _ _ => rfl
  | .prod x y => by simp [Ty.ren, Ty.rfK, Ty.rfK_ren κ a δ x, Ty.rfK_ren κ a δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.rfK, Ty.rfK_ren κ a δ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.rfK_tsubst {κ κ' : List Kind} : ∀ (t : Ty) (σ : List Ty), t.rfK κ = true →
    (∀ i, kindRF κ i = true → (look σ i).rfK κ' = true) → (t.tsubst σ).rfK κ' = true
  | .int, _, _, _ => rfl
  | .tvar i, σ, ht, h => h i ht
  | .tat i ρ, σ, ht, h => by simp only [Ty.tsubst, Ty.rfK_at]; exact h i ht
  | .box _ _ _, _, ht, _ => by simp [Ty.rfK] at ht
  | .iref _ _, _, ht, _ => by simp [Ty.rfK] at ht
  | .prod x y, σ, ht, h => by
    simp [Ty.rfK] at ht; simp [Ty.tsubst, Ty.rfK, Ty.rfK_tsubst x σ ht.1 h, Ty.rfK_tsubst y σ ht.2 h]
  | .fn _ _, _, _, _ => rfl
  | .opt t, σ, ht, h => by simp [Ty.rfK] at ht; simp [Ty.tsubst, Ty.rfK, Ty.rfK_tsubst t σ ht h]
  | .rvar _, _, _, _ => rfl
  | .mu _ _, _, ht, _ => by simp [Ty.rfK] at ht

theorem Ty.cv_at (κ : List Kind) (k : Nat) : ∀ t : Ty, (t.at k).cv κ = t.cv κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.at, Ty.cv, Ty.cv_at κ k t]
  | .iref r t => by simp [Ty.at, Ty.cv, Ty.rfK_at, Ty.rc_at]
  | .prod x y => by simp [Ty.at, Ty.cv, Ty.cv_at κ k x, Ty.cv_at κ k y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.at, Ty.cv, Ty.cv_at κ k t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.cv_ren (κ : List Kind) (a δ : Nat) : ∀ t : Ty, (t.ren a δ).cv κ = t.cv κ
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.ren, Ty.cv, Ty.cv_ren κ a δ t]
  | .iref r t => by simp [Ty.ren, Ty.cv, Ty.rfK_ren, Ty.rc_ren]
  | .prod x y => by simp [Ty.ren, Ty.cv, Ty.cv_ren κ a δ x, Ty.cv_ren κ a δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.cv, Ty.cv_ren κ a δ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.cv_tsubst {κ κ' : List Kind} : ∀ (t : Ty) (σ : List Ty), t.cv κ = true →
    (∀ i, kindCov κ i = true → (look σ i).cv κ' = true) → (∀ i, kindRF κ i = true → (look σ i).rfK κ' = true) →
    (∀ s ∈ σ, s.rc 0 = true) → (t.tsubst σ).cv κ' = true
  | .int, _, _, _, _, _ => rfl
  | .tvar i, σ, ht, h, _, _ => by simp [Ty.cv] at ht; exact h i ht
  | .tat i ρ, σ, ht, h, _, _ => by simp [Ty.cv] at ht; simp only [Ty.tsubst, Ty.cv_at]; exact h i ht
  | .box m r t, σ, ht, h, h', hc => by
    simp [Ty.cv] at ht; simp [Ty.tsubst, Ty.cv, ht.1, Ty.cv_tsubst t σ ht.2 h h' hc]
  | .iref r t, σ, ht, _, h', hc => by
    simp [Ty.cv] at ht; simp [Ty.tsubst, Ty.cv, Ty.rfK_tsubst t σ ht.1 h', Ty.rc_tsubst t σ 0 hc, ht.2]
  | .prod x y, σ, ht, h, h', hc => by
    simp [Ty.cv] at ht; simp [Ty.tsubst, Ty.cv, Ty.cv_tsubst x σ ht.1 h h' hc, Ty.cv_tsubst y σ ht.2 h h' hc]
  | .fn _ _, _, _, _, _, _ => rfl
  | .opt t, σ, ht, h, h', hc => by simp [Ty.cv] at ht; simp [Ty.tsubst, Ty.cv, Ty.cv_tsubst t σ ht h h' hc]
  | .rvar _, _, _, _, _, _ => rfl
  | .mu r b, σ, ht, h, h', hc => by
    simp [Ty.cv] at ht; simp only [Ty.tsubst, Ty.cv]
    exact Ty.cv_tsubst b _ ht (fun i hi => by rw [look_map (Ty.at 0) rfl, Ty.cv_at]; exact h i hi)
      (fun i hi => by rw [look_map (Ty.at 0) rfl, Ty.rfK_at]; exact h' i hi) (rc_map_at hc)

/-- region を持たない型（型変数の kind を仮定しない）は、置き直しで変わらない -/
theorem Ty.at_rfK0 (k : Nat) : ∀ t : Ty, t.rfK [] = true → t.at k = t
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .tat _ _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .box _ _ _, h => by simp [Ty.rfK] at h
  | .iref _ _, h => by simp [Ty.rfK] at h
  | .prod x y, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.at_rfK0 k x h.1, Ty.at_rfK0 k y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.at_rfK0 k t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rfK] at h

/-! ## 部分型の補題 -/

theorem Ty.sub_refl (κ : List Kind) (L : Nat) : ∀ t : Ty, Ty.sub0 κ L t t = true
  | .int => rfl
  | .tvar _ => by simp [Ty.sub0]
  | .tat _ _ => by simp [Ty.sub0]
  | .box m r t => by cases m <;> simp [Ty.sub0, Ty.sub_refl κ L t]
  | .iref r t => by simp [Ty.sub0]
  | .prod x y => by simp [Ty.sub0, Ty.sub_refl κ L x, Ty.sub_refl κ L y]
  | .fn _ _ => by simp [Ty.sub0]
  | .opt t => by simp [Ty.sub0, Ty.sub_refl κ L t]
  | .rvar _ => by simp [Ty.sub0]
  | .mu _ _ => by simp [Ty.sub0]

theorem Ty.sub_trans {κ : List Kind} {L : Nat} : ∀ {a b c : Ty}, Ty.sub0 κ L a b = true → Ty.sub0 κ L b c = true →
    Ty.sub0 κ L a c = true
  | .int, .int, .int, _, _ => rfl
  | .tvar i, .tvar j, c, h1, h2 => by simp [Ty.sub0] at h1; subst h1; exact h2
  | .tvar i, .tat j ρ, .tat k ρ', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; obtain ⟨⟨rfl, hk⟩, hl⟩ := h1; obtain ⟨rfl, h2⟩ := h2
    refine ⟨⟨rfl, hk⟩, ?_⟩; rcases h2 with rfl | ⟨-, h⟩ <;> omega
  | .tat i ρ, .tat j ρ', .tat k ρ'', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; obtain ⟨rfl, h1⟩ := h1; obtain ⟨rfl, h2⟩ := h2
    refine ⟨rfl, ?_⟩
    rcases h1 with rfl | ⟨hk, h1⟩ <;> rcases h2 with rfl | ⟨hk', h2⟩
    · exact .inl rfl
    · exact .inr ⟨hk', h2⟩
    · exact .inr ⟨hk, h1⟩
    · exact .inr ⟨hk, by omega⟩
  | .box m r t, .box m' r' t', .box m'' r'' t'', h1, h2 => by
    cases m <;> cases m' <;> cases m'' <;> simp [Ty.sub0] at h1 h2 ⊢
    · exact ⟨by omega, Ty.sub_trans h1.2 h2.2⟩
    · obtain ⟨rfl, rfl⟩ := h1; exact h2
  | .iref r t, .iref r' t', .iref r'' t'', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; obtain ⟨h1, rfl⟩ := h1; obtain ⟨h2, rfl⟩ := h2; exact ⟨by omega, rfl⟩
  | .prod x y, .prod x' y', .prod x'' y'', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; exact ⟨Ty.sub_trans h1.1 h2.1, Ty.sub_trans h1.2 h2.2⟩
  | .fn p q, .fn p' q', .fn p'' q'', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; obtain ⟨rfl, rfl⟩ := h1; exact h2
  | .opt x, .opt y, .opt z, h1, h2 => by simp [Ty.sub0] at h1 h2 ⊢; exact Ty.sub_trans h1 h2
  | .rvar i, .rvar j, .rvar k, h1, h2 => by simp [Ty.sub0] at h1 h2 ⊢; omega
  | .mu r b, .mu r' b', .mu r'' b'', h1, h2 => by
    simp [Ty.sub0] at h1 h2 ⊢; obtain ⟨rfl, h1⟩ := h1; obtain ⟨rfl, h2⟩ := h2; refine ⟨rfl, ?_⟩
    rcases h1 with rfl | ⟨hm, h1⟩ <;> rcases h2 with rfl | ⟨hm', h2⟩
    · exact .inl rfl
    · exact .inr ⟨hm', h2⟩
    · exact .inr ⟨hm, h1⟩
    · exact .inr ⟨hm, by omega⟩
  | .int, .tvar _, _, h1, _ | .int, .tat _ _, _, h1, _ | .int, .box _ _ _, _, h1, _ | .int, .prod _ _, _, h1, _
  | .int, .fn _ _, _, h1, _ | .int, .opt _, _, h1, _ | .int, .rvar _, _, h1, _ | .int, .mu _ _, _, h1, _
  | .tvar _, .int, _, h1, _ | .tvar _, .box _ _ _, _, h1, _ | .tvar _, .prod _ _, _, h1, _
  | .tvar _, .fn _ _, _, h1, _ | .tvar _, .opt _, _, h1, _ | .tvar _, .rvar _, _, h1, _ | .tvar _, .mu _ _, _, h1, _
  | .tat _ _, .int, _, h1, _ | .tat _ _, .tvar _, _, h1, _ | .tat _ _, .box _ _ _, _, h1, _
  | .tat _ _, .prod _ _, _, h1, _ | .tat _ _, .fn _ _, _, h1, _ | .tat _ _, .opt _, _, h1, _
  | .tat _ _, .rvar _, _, h1, _ | .tat _ _, .mu _ _, _, h1, _ | .box _ _ _, .int, _, h1, _
  | .box _ _ _, .tvar _, _, h1, _ | .box _ _ _, .tat _ _, _, h1, _ | .box _ _ _, .prod _ _, _, h1, _
  | .box _ _ _, .fn _ _, _, h1, _ | .box _ _ _, .opt _, _, h1, _ | .box _ _ _, .rvar _, _, h1, _
  | .box _ _ _, .mu _ _, _, h1, _ | .prod _ _, .int, _, h1, _ | .prod _ _, .tvar _, _, h1, _
  | .prod _ _, .tat _ _, _, h1, _ | .prod _ _, .box _ _ _, _, h1, _ | .prod _ _, .fn _ _, _, h1, _
  | .prod _ _, .opt _, _, h1, _ | .prod _ _, .rvar _, _, h1, _ | .prod _ _, .mu _ _, _, h1, _
  | .fn _ _, .int, _, h1, _ | .fn _ _, .tvar _, _, h1, _ | .fn _ _, .tat _ _, _, h1, _ | .fn _ _, .box _ _ _, _, h1, _
  | .fn _ _, .prod _ _, _, h1, _ | .fn _ _, .opt _, _, h1, _ | .fn _ _, .rvar _, _, h1, _ | .fn _ _, .mu _ _, _, h1, _
  | .opt _, .int, _, h1, _ | .opt _, .tvar _, _, h1, _ | .opt _, .tat _ _, _, h1, _ | .opt _, .box _ _ _, _, h1, _
  | .opt _, .prod _ _, _, h1, _ | .opt _, .fn _ _, _, h1, _ | .opt _, .rvar _, _, h1, _ | .opt _, .mu _ _, _, h1, _
  | .rvar _, .int, _, h1, _ | .rvar _, .tvar _, _, h1, _ | .rvar _, .tat _ _, _, h1, _ | .rvar _, .box _ _ _, _, h1, _
  | .rvar _, .prod _ _, _, h1, _ | .rvar _, .fn _ _, _, h1, _ | .rvar _, .opt _, _, h1, _ | .rvar _, .mu _ _, _, h1, _
  | .mu _ _, .int, _, h1, _ | .mu _ _, .tvar _, _, h1, _ | .mu _ _, .tat _ _, _, h1, _ | .mu _ _, .box _ _ _, _, h1, _
  | .mu _ _, .prod _ _, _, h1, _ | .mu _ _, .fn _ _, _, h1, _ | .mu _ _, .opt _, _, h1, _ | .mu _ _, .rvar _, _, h1, _
  | .iref _ _, .int, _, h1, _ | .int, .iref _ _, _, h1, _ | .iref _ _, .tvar _, _, h1, _
  | .tvar _, .iref _ _, _, h1, _ | .iref _ _, .tat _ _, _, h1, _ | .tat _ _, .iref _ _, _, h1, _
  | .iref _ _, .box _ _ _, _, h1, _ | .box _ _ _, .iref _ _, _, h1, _ | .iref _ _, .prod _ _, _, h1, _
  | .prod _ _, .iref _ _, _, h1, _ | .iref _ _, .fn _ _, _, h1, _ | .fn _ _, .iref _ _, _, h1, _
  | .iref _ _, .opt _, _, h1, _ | .opt _, .iref _ _, _, h1, _ | .iref _ _, .rvar _, _, h1, _
  | .rvar _, .iref _ _, _, h1, _ | .iref _ _, .mu _ _, _, h1, _ | .mu _ _, .iref _ _, _, h1, _ => by simp [Ty.sub0] at h1
  | .int, .int, .tvar _, _, h2 | .int, .int, .tat _ _, _, h2 | .int, .int, .box _ _ _, _, h2
  | .int, .int, .prod _ _, _, h2 | .int, .int, .fn _ _, _, h2 | .int, .int, .opt _, _, h2 | .int, .int, .rvar _, _, h2
  | .int, .int, .mu _ _, _, h2 | .tvar _, .tat _ _, .int, _, h2 | .tvar _, .tat _ _, .tvar _, _, h2
  | .tvar _, .tat _ _, .box _ _ _, _, h2 | .tvar _, .tat _ _, .prod _ _, _, h2 | .tvar _, .tat _ _, .fn _ _, _, h2
  | .tvar _, .tat _ _, .opt _, _, h2 | .tvar _, .tat _ _, .rvar _, _, h2 | .tvar _, .tat _ _, .mu _ _, _, h2
  | .tat _ _, .tat _ _, .int, _, h2 | .tat _ _, .tat _ _, .tvar _, _, h2 | .tat _ _, .tat _ _, .box _ _ _, _, h2
  | .tat _ _, .tat _ _, .prod _ _, _, h2 | .tat _ _, .tat _ _, .fn _ _, _, h2 | .tat _ _, .tat _ _, .opt _, _, h2
  | .tat _ _, .tat _ _, .rvar _, _, h2 | .tat _ _, .tat _ _, .mu _ _, _, h2 | .box _ _ _, .box _ _ _, .int, _, h2
  | .box _ _ _, .box _ _ _, .tvar _, _, h2 | .box _ _ _, .box _ _ _, .tat _ _, _, h2
  | .box _ _ _, .box _ _ _, .prod _ _, _, h2 | .box _ _ _, .box _ _ _, .fn _ _, _, h2
  | .box _ _ _, .box _ _ _, .opt _, _, h2 | .box _ _ _, .box _ _ _, .rvar _, _, h2
  | .box _ _ _, .box _ _ _, .mu _ _, _, h2 | .prod _ _, .prod _ _, .int, _, h2 | .prod _ _, .prod _ _, .tvar _, _, h2
  | .prod _ _, .prod _ _, .tat _ _, _, h2 | .prod _ _, .prod _ _, .box _ _ _, _, h2
  | .prod _ _, .prod _ _, .fn _ _, _, h2 | .prod _ _, .prod _ _, .opt _, _, h2 | .prod _ _, .prod _ _, .rvar _, _, h2
  | .prod _ _, .prod _ _, .mu _ _, _, h2 | .fn _ _, .fn _ _, .int, _, h2 | .fn _ _, .fn _ _, .tvar _, _, h2
  | .fn _ _, .fn _ _, .tat _ _, _, h2 | .fn _ _, .fn _ _, .box _ _ _, _, h2 | .fn _ _, .fn _ _, .prod _ _, _, h2
  | .fn _ _, .fn _ _, .opt _, _, h2 | .fn _ _, .fn _ _, .rvar _, _, h2 | .fn _ _, .fn _ _, .mu _ _, _, h2
  | .opt _, .opt _, .int, _, h2 | .opt _, .opt _, .tvar _, _, h2 | .opt _, .opt _, .tat _ _, _, h2
  | .opt _, .opt _, .box _ _ _, _, h2 | .opt _, .opt _, .prod _ _, _, h2 | .opt _, .opt _, .fn _ _, _, h2
  | .opt _, .opt _, .rvar _, _, h2 | .opt _, .opt _, .mu _ _, _, h2 | .rvar _, .rvar _, .int, _, h2
  | .rvar _, .rvar _, .tvar _, _, h2 | .rvar _, .rvar _, .tat _ _, _, h2 | .rvar _, .rvar _, .box _ _ _, _, h2
  | .rvar _, .rvar _, .prod _ _, _, h2 | .rvar _, .rvar _, .fn _ _, _, h2 | .rvar _, .rvar _, .opt _, _, h2
  | .rvar _, .rvar _, .mu _ _, _, h2 | .mu _ _, .mu _ _, .int, _, h2 | .mu _ _, .mu _ _, .tvar _, _, h2
  | .mu _ _, .mu _ _, .tat _ _, _, h2 | .mu _ _, .mu _ _, .box _ _ _, _, h2 | .mu _ _, .mu _ _, .prod _ _, _, h2
  | .mu _ _, .mu _ _, .fn _ _, _, h2 | .mu _ _, .mu _ _, .opt _, _, h2 | .mu _ _, .mu _ _, .rvar _, _, h2
  | .box _ _ _, .box _ _ _, .iref _ _, _, h2 | .fn _ _, .fn _ _, .iref _ _, _, h2 | .int, .int, .iref _ _, _, h2
  | .mu _ _, .mu _ _, .iref _ _, _, h2 | .opt _, .opt _, .iref _ _, _, h2 | .prod _ _, .prod _ _, .iref _ _, _, h2
  | .rvar _, .rvar _, .iref _ _, _, h2 | .tat _ _, .tat _ _, .iref _ _, _, h2 | .tvar _, .tat _ _, .iref _ _, _, h2
  | .iref _ _, .iref _ _, .int, _, h2 | .iref _ _, .iref _ _, .tvar _, _, h2 | .iref _ _, .iref _ _, .tat _ _, _, h2
  | .iref _ _, .iref _ _, .box _ _ _, _, h2 | .iref _ _, .iref _ _, .prod _ _, _, h2
  | .iref _ _, .iref _ _, .fn _ _, _, h2 | .iref _ _, .iref _ _, .opt _, _, h2 | .iref _ _, .iref _ _, .rvar _, _, h2
  | .iref _ _, .iref _ _, .mu _ _, _, h2 => by simp [Ty.sub0] at h2

theorem rmap_mono {a δ r r' : Nat} (ha : a ≤ 1 + δ) (h : r ≤ r') : rmap a δ r ≤ rmap a δ r' := by
  cases r <;> cases r' <;> simp [rmap] <;> omega

/-- 写像は部分型を保つ（L は 1 + δ へ写る） -/
theorem Ty.sub_ren {κ : List Kind} {a δ : Nat} (ha : a ≤ 1 + δ) : ∀ {t t' : Ty}, Ty.sub0 κ 1 t t' = true →
    Ty.sub0 κ (1 + δ) (t.ren a δ) (t'.ren a δ) = true
  | .int, .int, _ => rfl
  | .tvar i, .tvar j, h => h
  | .tvar i, .tat j ρ, h => by
    simp [Ty.sub0] at h; obtain ⟨⟨rfl, hk⟩, hl⟩ := h
    simp [Ty.ren, Ty.sub0, hk]
    cases ρ with
    | zero => omega
    | succ k => simp [rmap]
  | .tat i ρ, .tat j ρ', h => by
    simp [Ty.sub0] at h; obtain ⟨rfl, h⟩ := h
    simp [Ty.ren, Ty.sub0]
    rcases h with rfl | ⟨hk, hl⟩
    · exact .inl rfl
    · exact .inr ⟨hk, rmap_mono ha hl⟩
  | .box m r t, .box m' r' t', h => by
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · simp [Ty.ren, Ty.sub0, rmap_mono ha h.1, Ty.sub_ren ha h.2]
    · obtain ⟨rfl, rfl⟩ := h; simp [Ty.ren, Ty.sub0]
  | .iref r t, .iref r' t', h => by
    simp [Ty.sub0] at h; obtain ⟨h, rfl⟩ := h; simp [Ty.ren, Ty.sub0, rmap_mono ha h]
  | .prod x y, .prod x' y', h => by
    simp [Ty.sub0] at h; simp [Ty.ren, Ty.sub0, Ty.sub_ren ha h.1, Ty.sub_ren ha h.2]
  | .fn p q, .fn p' q', h => by simp [Ty.sub0] at h; obtain ⟨rfl, rfl⟩ := h; simp [Ty.ren, Ty.sub0]
  | .opt x, .opt y, h => by simp [Ty.sub0] at h; simp [Ty.ren, Ty.sub0, Ty.sub_ren ha h]
  | .rvar i, .rvar j, h => h
  | .mu r b, .mu r' b', h => by
    simp [Ty.sub0] at h; obtain ⟨rfl, h⟩ := h
    simp [Ty.ren, Ty.sub0]
    rcases h with rfl | ⟨hm, hl⟩
    · exact .inl rfl
    · exact .inr ⟨hm, rmap_mono ha hl⟩
  | .int, .tvar _, h | .int, .tat _ _, h | .int, .box _ _ _, h | .int, .prod _ _, h | .int, .fn _ _, h
  | .int, .opt _, h | .int, .rvar _, h | .int, .mu _ _, h | .tvar _, .int, h | .tvar _, .box _ _ _, h
  | .tvar _, .prod _ _, h | .tvar _, .fn _ _, h | .tvar _, .opt _, h | .tvar _, .rvar _, h | .tvar _, .mu _ _, h
  | .tat _ _, .int, h | .tat _ _, .tvar _, h | .tat _ _, .box _ _ _, h | .tat _ _, .prod _ _, h | .tat _ _, .fn _ _, h
  | .tat _ _, .opt _, h | .tat _ _, .rvar _, h | .tat _ _, .mu _ _, h | .box _ _ _, .int, h | .box _ _ _, .tvar _, h
  | .box _ _ _, .tat _ _, h | .box _ _ _, .prod _ _, h | .box _ _ _, .fn _ _, h | .box _ _ _, .opt _, h
  | .box _ _ _, .rvar _, h | .box _ _ _, .mu _ _, h | .prod _ _, .int, h | .prod _ _, .tvar _, h
  | .prod _ _, .tat _ _, h | .prod _ _, .box _ _ _, h | .prod _ _, .fn _ _, h | .prod _ _, .opt _, h
  | .prod _ _, .rvar _, h | .prod _ _, .mu _ _, h | .fn _ _, .int, h | .fn _ _, .tvar _, h | .fn _ _, .tat _ _, h
  | .fn _ _, .box _ _ _, h | .fn _ _, .prod _ _, h | .fn _ _, .opt _, h | .fn _ _, .rvar _, h | .fn _ _, .mu _ _, h
  | .opt _, .int, h | .opt _, .tvar _, h | .opt _, .tat _ _, h | .opt _, .box _ _ _, h | .opt _, .prod _ _, h
  | .opt _, .fn _ _, h | .opt _, .rvar _, h | .opt _, .mu _ _, h | .rvar _, .int, h | .rvar _, .tvar _, h
  | .rvar _, .tat _ _, h | .rvar _, .box _ _ _, h | .rvar _, .prod _ _, h | .rvar _, .fn _ _, h | .rvar _, .opt _, h
  | .rvar _, .mu _ _, h | .mu _ _, .int, h | .mu _ _, .tvar _, h | .mu _ _, .tat _ _, h | .mu _ _, .box _ _ _, h
  | .mu _ _, .prod _ _, h | .mu _ _, .fn _ _, h | .mu _ _, .opt _, h | .mu _ _, .rvar _, h | .iref _ _, .int, h
  | .int, .iref _ _, h | .iref _ _, .tvar _, h | .tvar _, .iref _ _, h | .iref _ _, .tat _ _, h
  | .tat _ _, .iref _ _, h | .iref _ _, .box _ _ _, h | .box _ _ _, .iref _ _, h | .iref _ _, .prod _ _, h
  | .prod _ _, .iref _ _, h | .iref _ _, .fn _ _, h | .fn _ _, .iref _ _, h | .iref _ _, .opt _, h
  | .opt _, .iref _ _, h | .iref _ _, .rvar _, h | .rvar _, .iref _ _, h | .iref _ _, .mu _ _, h
  | .mu _ _, .iref _ _, h => by simp [Ty.sub0] at h

/-- 深く共変な閉じた型は、上界 k 以下なら k へ置き直した型の部分型 -/
theorem csub_at {k : Nat} : ∀ s : Ty, s.closed = true → s.cv [] = true → s.rb (k + 1) = true → csub s (s.at k) = true
  | .int, _, _, _ => rfl
  | .tvar _, h, _, _ => by simp [Ty.closed] at h
  | .tat _ _, h, _, _ => by simp [Ty.closed] at h
  | .box m r t, hc, hm, hr => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm; simp [Ty.rb] at hr
    obtain ⟨rfl, hm⟩ := hm; simp [Ty.at, Ty.sub0]; exact ⟨by omega, csub_at t hc hm hr.2⟩
  | .iref r t, hc, hm, hr => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm; simp [Ty.rb] at hr
    simp [Ty.at, Ty.sub0, Ty.at_rfree k t hc hm.1]; omega
  | .prod x y, hc, hm, hr => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm; simp [Ty.rb] at hr
    simp [Ty.at, Ty.sub0, csub_at x hc.1 hm.1 hr.1, csub_at y hc.2 hm.2 hr.2]
  | .fn _ _, _, _, _ => by simp [Ty.at, Ty.sub0]
  | .opt t, hc, hm, hr => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm; simp [Ty.rb] at hr; simp [Ty.at, Ty.sub0, csub_at t hc hm hr]
  | .rvar _, _, _, _ => by simp [Ty.at, Ty.sub0]
  | .mu r b, _, hm, hr => by simp [Ty.cv] at hm; simp [Ty.rb] at hr; simp [Ty.at, Ty.sub0, hm]; omega

theorem csub_at_mono {k k' : Nat} (hk : k ≤ k') : ∀ s : Ty, s.closed = true → s.cv [] = true → csub (s.at k) (s.at k') = true
  | .int, _, _ => rfl
  | .tvar _, h, _ => by simp [Ty.closed] at h
  | .tat _ _, h, _ => by simp [Ty.closed] at h
  | .box m r t, hc, hm => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm
    obtain ⟨rfl, hm⟩ := hm; simp [Ty.at, Ty.sub0]; exact ⟨hk, csub_at_mono hk t hc hm⟩
  | .iref r t, hc, hm => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm
    simp [Ty.at, Ty.sub0, Ty.at_rfree k t hc hm.1, Ty.at_rfree k' t hc hm.1, hk]
  | .prod x y, hc, hm => by
    simp [Ty.closed] at hc; simp [Ty.cv] at hm
    simp [Ty.at, Ty.sub0, csub_at_mono hk x hc.1 hm.1, csub_at_mono hk y hc.2 hm.2]
  | .fn _ _, _, _ => by simp [Ty.at, Ty.sub0]
  | .opt t, hc, hm => by simp [Ty.closed] at hc; simp [Ty.cv] at hm; simp [Ty.at, Ty.sub0, csub_at_mono hk t hc hm]
  | .rvar _, _, _ => by simp [Ty.at, Ty.sub0]
  | .mu r b, _, hm => by simp [Ty.cv] at hm; simp [Ty.at, Ty.sub0, hm, hk]

/-- 代入は部分型を閉じた部分型へ移す（型引数は閉じていて、上界 L 以下・kind を満たす） -/
theorem Ty.sub_tsubst {κ : List Kind} {L : Nat} {σ : List Ty}
    (hc : ∀ s ∈ σ, s.closed = true) (hr : ∀ s ∈ σ, s.rb (L + 1) = true)
    (hk : ∀ i, kindCov κ i = true → (look σ i).cv [] = true) (hf : ∀ i, kindRF κ i = true → (look σ i).rfK [] = true)
    (hrc : ∀ s ∈ σ, s.rc 0 = true) :
    ∀ {t t' : Ty}, Ty.sub0 κ L t t' = true → csub (t.tsubst σ) (t'.tsubst σ) = true
  | .int, .int, _ => rfl
  | .tvar i, .tvar j, h => by simp [Ty.sub0] at h; subst h; exact Ty.sub_refl _ _ _
  | .tvar i, .tat j ρ, h => by
    simp [Ty.sub0] at h; obtain ⟨⟨rfl, hki⟩, hl⟩ := h
    simp only [Ty.tsubst]
    have h1 := csub_at (k := L) (look σ i) (look_closed hc i) (hk i hki) (look_rb hr i)
    exact Ty.sub_trans h1 (csub_at_mono hl (look σ i) (look_closed hc i) (hk i hki))
  | .tat i ρ, .tat j ρ', h => by
    simp [Ty.sub0] at h; obtain ⟨rfl, h⟩ := h
    simp only [Ty.tsubst]
    rcases h with rfl | ⟨hki, hl⟩
    · exact Ty.sub_refl _ _ _
    · exact csub_at_mono hl _ (look_closed hc i) (hk i hki)
  | .box m r t, .box m' r' t', h => by
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · simp [Ty.tsubst, Ty.sub0, h.1, Ty.sub_tsubst hc hr hk hf hrc h.2]
    · obtain ⟨rfl, rfl⟩ := h; simp [Ty.tsubst, Ty.sub0]
  | .iref r t, .iref r' t', h => by simp [Ty.sub0] at h; obtain ⟨h, rfl⟩ := h; simp [Ty.tsubst, Ty.sub0, h]
  | .prod x y, .prod x' y', h => by
    simp [Ty.sub0] at h; simp [Ty.tsubst, Ty.sub0, Ty.sub_tsubst hc hr hk hf hrc h.1, Ty.sub_tsubst hc hr hk hf hrc h.2]
  | .fn p q, .fn p' q', h => by simp [Ty.sub0] at h; obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _ _ _
  | .opt x, .opt y, h => by simp [Ty.sub0] at h; simp [Ty.tsubst, Ty.sub0, Ty.sub_tsubst hc hr hk hf hrc h]
  | .rvar i, .rvar j, h => h
  | .mu r b, .mu r' b', h => by
    simp [Ty.sub0] at h; obtain ⟨rfl, h⟩ := h
    simp only [Ty.tsubst, Ty.sub0, beq_self_eq_true, Bool.true_and, Bool.or_eq_true, beq_iff_eq,
      Bool.and_eq_true, decide_eq_true_eq]
    rcases h with rfl | ⟨hm, hl⟩
    · exact .inl rfl
    · refine .inr ⟨Ty.cv_tsubst b _ hm (fun i hi => ?_) (fun i hi => ?_) ?_, hl⟩
      · rw [look_map (Ty.at 0) rfl, Ty.cv_at]; exact hk i hi
      · rw [look_map (Ty.at 0) rfl, Ty.rfK_at]; exact hf i hi
      · exact rc_map_at hrc
  | .int, .tvar _, h | .int, .tat _ _, h | .int, .box _ _ _, h | .int, .prod _ _, h | .int, .fn _ _, h
  | .int, .opt _, h | .int, .rvar _, h | .int, .mu _ _, h | .tvar _, .int, h | .tvar _, .box _ _ _, h
  | .tvar _, .prod _ _, h | .tvar _, .fn _ _, h | .tvar _, .opt _, h | .tvar _, .rvar _, h | .tvar _, .mu _ _, h
  | .tat _ _, .int, h | .tat _ _, .tvar _, h | .tat _ _, .box _ _ _, h | .tat _ _, .prod _ _, h | .tat _ _, .fn _ _, h
  | .tat _ _, .opt _, h | .tat _ _, .rvar _, h | .tat _ _, .mu _ _, h | .box _ _ _, .int, h | .box _ _ _, .tvar _, h
  | .box _ _ _, .tat _ _, h | .box _ _ _, .prod _ _, h | .box _ _ _, .fn _ _, h | .box _ _ _, .opt _, h
  | .box _ _ _, .rvar _, h | .box _ _ _, .mu _ _, h | .prod _ _, .int, h | .prod _ _, .tvar _, h
  | .prod _ _, .tat _ _, h | .prod _ _, .box _ _ _, h | .prod _ _, .fn _ _, h | .prod _ _, .opt _, h
  | .prod _ _, .rvar _, h | .prod _ _, .mu _ _, h | .fn _ _, .int, h | .fn _ _, .tvar _, h | .fn _ _, .tat _ _, h
  | .fn _ _, .box _ _ _, h | .fn _ _, .prod _ _, h | .fn _ _, .opt _, h | .fn _ _, .rvar _, h | .fn _ _, .mu _ _, h
  | .opt _, .int, h | .opt _, .tvar _, h | .opt _, .tat _ _, h | .opt _, .box _ _ _, h | .opt _, .prod _ _, h
  | .opt _, .fn _ _, h | .opt _, .rvar _, h | .opt _, .mu _ _, h | .rvar _, .int, h | .rvar _, .tvar _, h
  | .rvar _, .tat _ _, h | .rvar _, .box _ _ _, h | .rvar _, .prod _ _, h | .rvar _, .fn _ _, h | .rvar _, .opt _, h
  | .rvar _, .mu _ _, h | .mu _ _, .int, h | .mu _ _, .tvar _, h | .mu _ _, .tat _ _, h | .mu _ _, .box _ _ _, h
  | .mu _ _, .prod _ _, h | .mu _ _, .fn _ _, h | .mu _ _, .opt _, h | .mu _ _, .rvar _, h | .iref _ _, .int, h
  | .int, .iref _ _, h | .iref _ _, .tvar _, h | .tvar _, .iref _ _, h | .iref _ _, .tat _ _, h
  | .tat _ _, .iref _ _, h | .iref _ _, .box _ _ _, h | .box _ _ _, .iref _ _, h | .iref _ _, .prod _ _, h
  | .prod _ _, .iref _ _, h | .iref _ _, .fn _ _, h | .fn _ _, .iref _ _, h | .iref _ _, .opt _, h
  | .opt _, .iref _ _, h | .iref _ _, .rvar _, h | .rvar _, .iref _ _, h | .iref _ _, .mu _ _, h
  | .mu _ _, .iref _ _, h => by simp [Ty.sub0] at h

/-- 置き直しは部分型を保つ（region を全部同じ k にするので、region の大小の条件は消える） -/
theorem Ty.sub0_at {κ : List Kind} {L L' k : Nat} : ∀ {a b : Ty}, Ty.sub0 κ L a b = true → Ty.sub0 κ L' (a.at k) (b.at k) = true
  | .int, .int, _ => rfl
  | .tvar i, .tvar j, h => by simp [Ty.sub0] at h; subst h; exact Ty.sub_refl _ _ _
  | .tvar i, .tat j ρ, h => by simp [Ty.sub0] at h; obtain ⟨⟨rfl, -⟩, -⟩ := h; exact Ty.sub_refl _ _ _
  | .tat i ρ, .tat j ρ', h => by simp [Ty.sub0] at h; obtain ⟨rfl, -⟩ := h; exact Ty.sub_refl _ _ _
  | .box m r t, .box m' r' t', h => by
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · simp [Ty.at, Ty.sub0, Ty.sub0_at h.2]
    · obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _ _ _
  | .iref r t, .iref r' t', h => by simp [Ty.sub0] at h; obtain ⟨-, rfl⟩ := h; exact Ty.sub_refl _ _ _
  | .prod x y, .prod x' y', h => by simp [Ty.sub0] at h; simp [Ty.at, Ty.sub0, Ty.sub0_at h.1, Ty.sub0_at h.2]
  | .fn p q, .fn p' q', h => by simp [Ty.sub0] at h; obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _ _ _
  | .opt x, .opt y, h => by simp [Ty.sub0] at h; simp [Ty.at, Ty.sub0, Ty.sub0_at h]
  | .rvar i, .rvar j, h => h
  | .mu r b, .mu r' b', h => by simp [Ty.sub0] at h; obtain ⟨rfl, -⟩ := h; exact Ty.sub_refl _ _ _
  | .int, .tvar _, h | .int, .tat _ _, h | .int, .box _ _ _, h | .int, .prod _ _, h | .int, .fn _ _, h
  | .int, .opt _, h | .int, .rvar _, h | .int, .mu _ _, h | .tvar _, .int, h | .tvar _, .box _ _ _, h
  | .tvar _, .prod _ _, h | .tvar _, .fn _ _, h | .tvar _, .opt _, h | .tvar _, .rvar _, h | .tvar _, .mu _ _, h
  | .tat _ _, .int, h | .tat _ _, .tvar _, h | .tat _ _, .box _ _ _, h | .tat _ _, .prod _ _, h | .tat _ _, .fn _ _, h
  | .tat _ _, .opt _, h | .tat _ _, .rvar _, h | .tat _ _, .mu _ _, h | .box _ _ _, .int, h | .box _ _ _, .tvar _, h
  | .box _ _ _, .tat _ _, h | .box _ _ _, .prod _ _, h | .box _ _ _, .fn _ _, h | .box _ _ _, .opt _, h
  | .box _ _ _, .rvar _, h | .box _ _ _, .mu _ _, h | .prod _ _, .int, h | .prod _ _, .tvar _, h
  | .prod _ _, .tat _ _, h | .prod _ _, .box _ _ _, h | .prod _ _, .fn _ _, h | .prod _ _, .opt _, h
  | .prod _ _, .rvar _, h | .prod _ _, .mu _ _, h | .fn _ _, .int, h | .fn _ _, .tvar _, h | .fn _ _, .tat _ _, h
  | .fn _ _, .box _ _ _, h | .fn _ _, .prod _ _, h | .fn _ _, .opt _, h | .fn _ _, .rvar _, h | .fn _ _, .mu _ _, h
  | .opt _, .int, h | .opt _, .tvar _, h | .opt _, .tat _ _, h | .opt _, .box _ _ _, h | .opt _, .prod _ _, h
  | .opt _, .fn _ _, h | .opt _, .rvar _, h | .opt _, .mu _ _, h | .rvar _, .int, h | .rvar _, .tvar _, h
  | .rvar _, .tat _ _, h | .rvar _, .box _ _ _, h | .rvar _, .prod _ _, h | .rvar _, .fn _ _, h | .rvar _, .opt _, h
  | .rvar _, .mu _ _, h | .mu _ _, .int, h | .mu _ _, .tvar _, h | .mu _ _, .tat _ _, h | .mu _ _, .box _ _ _, h
  | .mu _ _, .prod _ _, h | .mu _ _, .fn _ _, h | .mu _ _, .opt _, h | .mu _ _, .rvar _, h | .iref _ _, .int, h
  | .int, .iref _ _, h | .iref _ _, .tvar _, h | .tvar _, .iref _ _, h | .iref _ _, .tat _ _, h
  | .tat _ _, .iref _ _, h | .iref _ _, .box _ _ _, h | .box _ _ _, .iref _ _, h | .iref _ _, .prod _ _, h
  | .prod _ _, .iref _ _, h | .iref _ _, .fn _ _, h | .fn _ _, .iref _ _, h | .iref _ _, .opt _, h
  | .opt _, .iref _ _, h | .iref _ _, .rvar _, h | .rvar _, .iref _ _, h | .iref _ _, .mu _ _, h
  | .mu _ _, .iref _ _, h => by simp [Ty.sub0] at h

/-- 部分型の上の型が mut を持たなければ、下の型も持たない -/
theorem Ty.mf_of_sub0 {κ : List Kind} {L : Nat} : ∀ {a b : Ty}, Ty.sub0 κ L a b = true → b.mf κ = true → a.mf κ = true
  | .int, .int, _, _ => rfl
  | .tvar i, .tvar j, h, hb => by simp [Ty.sub0] at h; subst h; exact hb
  | .tvar i, .tat j ρ, h, hb => by simp [Ty.sub0] at h; obtain ⟨⟨rfl, -⟩, -⟩ := h; simpa [Ty.mf] using hb
  | .tat i ρ, .tat j ρ', h, hb => by simp [Ty.sub0] at h; obtain ⟨rfl, -⟩ := h; simpa [Ty.mf] using hb
  | .box m r t, .box m' r' t', h, hb => by
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · simp [Ty.mf] at hb ⊢; exact Ty.mf_of_sub0 h.2 hb
    · simp [Ty.mf] at hb
  | .iref r t, .iref r' t', h, hb => by simp [Ty.sub0] at h; obtain ⟨-, rfl⟩ := h; exact hb
  | .prod x y, .prod x' y', h, hb => by
    simp [Ty.sub0] at h; simp [Ty.mf] at hb ⊢; exact ⟨Ty.mf_of_sub0 h.1 hb.1, Ty.mf_of_sub0 h.2 hb.2⟩
  | .fn _ _, .fn _ _, _, _ => rfl
  | .opt x, .opt y, h, hb => by simp [Ty.sub0] at h; simp [Ty.mf] at hb ⊢; exact Ty.mf_of_sub0 h hb
  | .rvar _, .rvar _, _, _ => rfl
  | .mu r b, .mu r' b', h, hb => by simp [Ty.sub0] at h; obtain ⟨rfl, -⟩ := h; exact hb
  | .int, .tvar _, h, _ | .int, .tat _ _, h, _ | .int, .box _ _ _, h, _ | .int, .prod _ _, h, _ | .int, .fn _ _, h, _
  | .int, .opt _, h, _ | .int, .rvar _, h, _ | .int, .mu _ _, h, _ | .tvar _, .int, h, _ | .tvar _, .box _ _ _, h, _
  | .tvar _, .prod _ _, h, _ | .tvar _, .fn _ _, h, _ | .tvar _, .opt _, h, _ | .tvar _, .rvar _, h, _
  | .tvar _, .mu _ _, h, _ | .tat _ _, .int, h, _ | .tat _ _, .tvar _, h, _ | .tat _ _, .box _ _ _, h, _
  | .tat _ _, .prod _ _, h, _ | .tat _ _, .fn _ _, h, _ | .tat _ _, .opt _, h, _ | .tat _ _, .rvar _, h, _
  | .tat _ _, .mu _ _, h, _ | .box _ _ _, .int, h, _ | .box _ _ _, .tvar _, h, _ | .box _ _ _, .tat _ _, h, _
  | .box _ _ _, .prod _ _, h, _ | .box _ _ _, .fn _ _, h, _ | .box _ _ _, .opt _, h, _ | .box _ _ _, .rvar _, h, _
  | .box _ _ _, .mu _ _, h, _ | .prod _ _, .int, h, _ | .prod _ _, .tvar _, h, _ | .prod _ _, .tat _ _, h, _
  | .prod _ _, .box _ _ _, h, _ | .prod _ _, .fn _ _, h, _ | .prod _ _, .opt _, h, _ | .prod _ _, .rvar _, h, _
  | .prod _ _, .mu _ _, h, _ | .fn _ _, .int, h, _ | .fn _ _, .tvar _, h, _ | .fn _ _, .tat _ _, h, _
  | .fn _ _, .box _ _ _, h, _ | .fn _ _, .prod _ _, h, _ | .fn _ _, .opt _, h, _ | .fn _ _, .rvar _, h, _
  | .fn _ _, .mu _ _, h, _ | .opt _, .int, h, _ | .opt _, .tvar _, h, _ | .opt _, .tat _ _, h, _
  | .opt _, .box _ _ _, h, _ | .opt _, .prod _ _, h, _ | .opt _, .fn _ _, h, _ | .opt _, .rvar _, h, _
  | .opt _, .mu _ _, h, _ | .rvar _, .int, h, _ | .rvar _, .tvar _, h, _ | .rvar _, .tat _ _, h, _
  | .rvar _, .box _ _ _, h, _ | .rvar _, .prod _ _, h, _ | .rvar _, .fn _ _, h, _ | .rvar _, .opt _, h, _
  | .rvar _, .mu _ _, h, _ | .mu _ _, .int, h, _ | .mu _ _, .tvar _, h, _ | .mu _ _, .tat _ _, h, _
  | .mu _ _, .box _ _ _, h, _ | .mu _ _, .prod _ _, h, _ | .mu _ _, .fn _ _, h, _ | .mu _ _, .opt _, h, _
  | .mu _ _, .rvar _, h, _ | .iref _ _, .int, h, _ | .int, .iref _ _, h, _ | .iref _ _, .tvar _, h, _
  | .tvar _, .iref _ _, h, _ | .iref _ _, .tat _ _, h, _ | .tat _ _, .iref _ _, h, _ | .iref _ _, .box _ _ _, h, _
  | .box _ _ _, .iref _ _, h, _ | .iref _ _, .prod _ _, h, _ | .prod _ _, .iref _ _, h, _ | .iref _ _, .fn _ _, h, _
  | .fn _ _, .iref _ _, h, _ | .iref _ _, .opt _, h, _ | .opt _, .iref _ _, h, _ | .iref _ _, .rvar _, h, _
  | .rvar _, .iref _ _, h, _ | .iref _ _, .mu _ _, h, _ | .mu _ _, .iref _ _, h, _ => by simp [Ty.sub0] at h

/-! ## 再帰型の補題（再帰の変数の代入・展開と、代入・写像の可換性） -/

/-- 再帰の変数について閉じた型は、再帰の変数の代入で変わらない -/
theorem Ty.rsubst_rc : ∀ (t : Ty) (k : Nat) (s : Ty), t.rc k = true → t.rsubst k s = t
  | .int, _, _, _ => rfl
  | .tvar _, _, _, _ => rfl
  | .tat _ _, _, _, _ => rfl
  | .box m r t, k, s, h => by simp [Ty.rc] at h; simp [Ty.rsubst, Ty.rsubst_rc t k s h]
  | .iref r t, k, s, h => by simp [Ty.rc] at h; simp [Ty.rsubst, Ty.rsubst_rc t k s h]
  | .prod x y, k, s, h => by simp [Ty.rc] at h; simp [Ty.rsubst, Ty.rsubst_rc x k s h.1, Ty.rsubst_rc y k s h.2]
  | .fn _ _, _, _, _ => rfl
  | .opt t, k, s, h => by simp [Ty.rc] at h; simp [Ty.rsubst, Ty.rsubst_rc t k s h]
  | .rvar i, k, s, h => by
    simp [Ty.rc] at h; simp [Ty.rsubst, show i ≠ k by omega, show ¬ k < i by omega]
  | .mu r b, k, s, h => by simp [Ty.rc] at h; simp [Ty.rsubst, Ty.rsubst_rc b (k + 1) s h]

/-- 再帰の変数の代入と型代入の可換性（型引数は再帰の変数について閉じている。s の代入は関数型の中の読み方に依らない） -/
theorem Ty.tsubst_rsubst : ∀ (t : Ty) (k : Nat) (s : Ty) (σ : List Ty), (∀ x ∈ σ, x.rc 0 = true) →
    (∀ τ : List Ty, s.tsubst (τ.map (Ty.at 0)) = s.tsubst τ) →
    (t.rsubst k s).tsubst σ = (t.tsubst σ).rsubst k (s.tsubst σ)
  | .int, _, _, _, _, _ => rfl
  | .tvar i, k, s, σ, h, _ => by
    simp only [Ty.rsubst, Ty.tsubst]; rw [Ty.rsubst_rc _ k _ (Ty.rc_mono _ (Nat.zero_le k) (look_rc h i))]
  | .tat i ρ, k, s, σ, h, _ => by
    simp only [Ty.rsubst, Ty.tsubst]
    rw [Ty.rsubst_rc _ k _ (by rw [Ty.rc_at]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i))]
  | .box m r t, k, s, σ, h, hs => by simp [Ty.rsubst, Ty.tsubst, Ty.tsubst_rsubst t k s σ h hs]
  | .iref r t, k, s, σ, h, hs => by simp [Ty.rsubst, Ty.tsubst, Ty.tsubst_rsubst t k s σ h hs]
  | .prod x y, k, s, σ, h, hs => by
    simp [Ty.rsubst, Ty.tsubst, Ty.tsubst_rsubst x k s σ h hs, Ty.tsubst_rsubst y k s σ h hs]
  | .fn _ _, _, _, _, _, _ => rfl
  | .opt t, k, s, σ, h, hs => by simp [Ty.rsubst, Ty.tsubst, Ty.tsubst_rsubst t k s σ h hs]
  | .rvar i, k, s, σ, _, _ => by
    simp only [Ty.rsubst]
    by_cases h1 : i = k
    · subst h1; simp [Ty.tsubst, Ty.rsubst]
    · by_cases h2 : k < i <;> simp [h1, h2, Ty.tsubst, Ty.rsubst]
  | .mu r b, k, s, σ, h, hs => by
    simp only [Ty.rsubst, Ty.tsubst]
    rw [Ty.tsubst_rsubst b (k + 1) s _ (rc_map_at h) hs, hs σ]

/-- 置き直しの後では、本体の型代入の読み方（素の型引数か region 0 へ置き直した型引数か）は区別されない -/
theorem Ty.at_rsubst_low (j : Nat) : ∀ (t : Ty) (k : Nat) (s : Ty) (σ : List Ty), (∀ x ∈ σ, x.rc 0 = true) →
    ((t.tsubst σ).rsubst k s).at j = ((t.tsubst (σ.map (Ty.at 0))).rsubst k s).at j
  | .int, _, _, _, _ => rfl
  | .tvar i, k, s, σ, h => by
    simp only [Ty.tsubst, look_map (Ty.at 0) rfl]
    rw [Ty.rsubst_rc _ k _ (Ty.rc_mono _ (Nat.zero_le k) (look_rc h i)),
      Ty.rsubst_rc _ k _ (by rw [Ty.rc_at]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i))]
    exact (Ty.at_at 0 j _).symm
  | .tat i ρ, k, s, σ, h => by
    simp only [Ty.tsubst, look_map (Ty.at 0) rfl]
    rw [Ty.rsubst_rc _ k _ (by rw [Ty.rc_at]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i)),
      Ty.rsubst_rc _ k _ (by rw [Ty.rc_at, Ty.rc_at]; exact Ty.rc_mono _ (Nat.zero_le k) (look_rc h i))]
    rw [Ty.at_at, Ty.at_at, Ty.at_at]
  | .box m r t, k, s, σ, h => by simp [Ty.rsubst, Ty.tsubst, Ty.at, Ty.at_rsubst_low j t k s σ h]
  | .iref r t, k, s, σ, h => by simp [Ty.rsubst, Ty.tsubst, Ty.at, Ty.at_rsubst_low j t k s σ h]
  | .prod x y, k, s, σ, h => by
    simp [Ty.rsubst, Ty.tsubst, Ty.at, Ty.at_rsubst_low j x k s σ h, Ty.at_rsubst_low j y k s σ h]
  | .fn p q, _, _, σ, _ => by simp [Ty.rsubst, Ty.tsubst, Ty.at, Function.comp_def, Ty.at_at]
  | .opt t, k, s, σ, h => by simp [Ty.rsubst, Ty.tsubst, Ty.at, Ty.at_rsubst_low j t k s σ h]
  | .rvar _, _, _, _, _ => rfl
  | .mu r b, _, _, σ, _ => by simp [Ty.rsubst, Ty.tsubst, Ty.at, Function.comp_def, Ty.at_at]

/-- 展開と型代入の可換性: 本体へは region 0 へ置き直した型引数を代入する（本体は局所座標） -/
theorem Ty.unf_tsubst {σ : List Ty} (h : ∀ x ∈ σ, x.rc 0 = true) (r : Nat) (b : Ty) :
    (Ty.unf r b).tsubst σ = Ty.unf r (b.tsubst (σ.map (Ty.at 0))) := by
  have hs : ∀ τ : List Ty, (Ty.mu 0 b).tsubst (τ.map (Ty.at 0)) = (Ty.mu 0 b).tsubst τ := by
    intro τ; simp [Ty.tsubst, Function.comp_def, Ty.at_at]
  unfold Ty.unf
  rw [Ty.at_tsubst, Ty.tsubst_rsubst _ _ _ _ h hs, Ty.at_rsubst_low _ _ _ _ _ h]
  rfl

theorem Ty.unf_ren (a δ r : Nat) (b : Ty) : (Ty.unf r b).ren a δ = Ty.unf (rmap a δ r) b := by
  unfold Ty.unf; rw [Ty.ren_at, Ty.at_ren]

theorem Ty.unf_at (j r : Nat) (b : Ty) : (Ty.unf r b).at j = Ty.unf j b := by
  unfold Ty.unf; rw [Ty.at_at]

theorem Ty.closed_rsubst {s : Ty} (hs : s.closed = true) : ∀ (t : Ty) (k : Nat), t.closed = true → (t.rsubst k s).closed = true
  | .int, _, _ => rfl
  | .tvar _, _, h => h
  | .tat _ _, _, h => h
  | .box _ _ t, k, h => by simp [Ty.closed] at h; simp [Ty.rsubst, Ty.closed, Ty.closed_rsubst hs t k h]
  | .iref _ t, k, h => by simp [Ty.closed] at h; simp [Ty.rsubst, Ty.closed, Ty.closed_rsubst hs t k h]
  | .prod x y, k, h => by
    simp [Ty.closed] at h; simp [Ty.rsubst, Ty.closed, Ty.closed_rsubst hs x k h.1, Ty.closed_rsubst hs y k h.2]
  | .fn _ _, _, h => h
  | .opt t, k, h => by simp [Ty.closed] at h; simp [Ty.rsubst, Ty.closed, Ty.closed_rsubst hs t k h]
  | .rvar i, k, _ => by simp only [Ty.rsubst]; split; exact hs; split <;> rfl
  | .mu _ b, k, h => by simp [Ty.closed] at h; simp [Ty.rsubst, Ty.closed, Ty.closed_rsubst hs b (k + 1) h]

theorem Ty.closed_unf {r : Nat} {b : Ty} (h : b.closed = true) : (Ty.unf r b).closed = true :=
  Ty.closed_at r _ (Ty.closed_rsubst (s := .mu 0 b) h b 0 h)

theorem Ty.mf_rsubst {κ : List Kind} {s : Ty} (hs : s.mf κ = true) : ∀ (t : Ty) (k : Nat), t.mf κ = true → (t.rsubst k s).mf κ = true
  | .int, _, _ => rfl
  | .tvar _, _, h => h
  | .tat _ _, _, h => h
  | .box _ _ t, k, h => by simp [Ty.mf] at h; simp [Ty.rsubst, Ty.mf, h.1, Ty.mf_rsubst hs t k h.2]
  | .iref _ t, k, h => by simp [Ty.mf] at h; simp [Ty.rsubst, Ty.mf, Ty.mf_rsubst hs t k h]
  | .prod x y, k, h => by
    simp [Ty.mf] at h; simp [Ty.rsubst, Ty.mf, Ty.mf_rsubst hs x k h.1, Ty.mf_rsubst hs y k h.2]
  | .fn _ _, _, h => h
  | .opt t, k, h => by simp [Ty.mf] at h; simp [Ty.rsubst, Ty.mf, Ty.mf_rsubst hs t k h]
  | .rvar i, k, _ => by simp only [Ty.rsubst]; split; exact hs; split <;> rfl
  | .mu _ b, k, h => by simp [Ty.mf] at h; simp [Ty.rsubst, Ty.mf, Ty.mf_rsubst hs b (k + 1) h]

theorem Ty.mf_unf {κ : List Kind} {r : Nat} {b : Ty} (h : b.mf κ = true) : (Ty.unf r b).mf κ = true := by
  unfold Ty.unf; rw [Ty.mf_at]; exact Ty.mf_rsubst (s := .mu 0 b) h b 0 h

theorem Ty.cv_rsubst {κ : List Kind} {s : Ty} (hs : s.cv κ = true) : ∀ (t : Ty) (k : Nat), t.cv κ = true → (t.rsubst k s).cv κ = true
  | .int, _, _ => rfl
  | .tvar _, _, h => h
  | .tat _ _, _, h => h
  | .box _ _ t, k, h => by simp [Ty.cv] at h; simp [Ty.rsubst, Ty.cv, h.1, Ty.cv_rsubst hs t k h.2]
  | .iref r t, k, h => by
    simp [Ty.cv] at h; simp [Ty.rsubst, Ty.rsubst_rc t k s (Ty.rc_mono t (Nat.zero_le k) h.2), Ty.cv, h.1, h.2]
  | .prod x y, k, h => by
    simp [Ty.cv] at h; simp [Ty.rsubst, Ty.cv, Ty.cv_rsubst hs x k h.1, Ty.cv_rsubst hs y k h.2]
  | .fn _ _, _, h => h
  | .opt t, k, h => by simp [Ty.cv] at h; simp [Ty.rsubst, Ty.cv, Ty.cv_rsubst hs t k h]
  | .rvar i, k, _ => by simp only [Ty.rsubst]; split; exact hs; split <;> rfl
  | .mu _ b, k, h => by simp [Ty.cv] at h; simp [Ty.rsubst, Ty.cv, Ty.cv_rsubst hs b (k + 1) h]

/-- 深く共変な型（型変数の kind を仮定しない）は、置き直す先の region を上げると部分型になる -/
theorem Ty.csub_at_mono0 {k k' : Nat} (hk : k ≤ k') : ∀ t : Ty, t.cv [] = true → csub (t.at k) (t.at k') = true
  | .int, _ => rfl
  | .tvar i, h => by simp [Ty.cv, kindCov, kindOf, Kind.O] at h
  | .tat i _, h => by simp [Ty.cv, kindCov, kindOf, Kind.O] at h
  | .box m _ t, h => by
    simp [Ty.cv] at h; obtain ⟨rfl, h⟩ := h; simp [Ty.at, Ty.sub0, hk, Ty.csub_at_mono0 hk t h]
  | .iref _ t, h => by simp [Ty.cv] at h; simp [Ty.at, Ty.sub0, hk, Ty.at_rfK0 k t h.1, Ty.at_rfK0 k' t h.1]
  | .prod x y, h => by
    simp [Ty.cv] at h; simp [Ty.at, Ty.sub0, Ty.csub_at_mono0 hk x h.1, Ty.csub_at_mono0 hk y h.2]
  | .fn _ _, _ => Ty.sub_refl _ _ _
  | .opt t, h => by simp [Ty.cv] at h; simp [Ty.at, Ty.sub0, Ty.csub_at_mono0 hk t h]
  | .rvar _, _ => Ty.sub_refl _ _ _
  | .mu _ b, h => by simp [Ty.cv] at h; simp [Ty.at, Ty.sub0, h, hk]

/-- 展開の部分型（閉じた型）: 同じ本体の再帰型の部分型なら、展開も部分型 -/
theorem csub_unf {r r' : Nat} {b : Ty} (h : r = r' ∨ (b.cv [] = true ∧ r ≤ r')) : csub (Ty.unf r b) (Ty.unf r' b) = true := by
  rcases h with rfl | ⟨hm, hl⟩
  · exact Ty.sub_refl _ _ _
  · exact Ty.csub_at_mono0 hl _ (Ty.cv_rsubst (s := .mu 0 b) hm b 0 hm)

theorem Ty.rb_unf {r k : Nat} (h : r < k) (b : Ty) : (Ty.unf r b).rb k = true := Ty.rb_at h _

/-! ## 項・値・評価 -/

/-- 項。region の添字（call / callv の anchor）は、その項が型付く世界の座標（Defの本体では base） -/
inductive Expr : Type where
  | var (i : Nat)
  | lit (n : Int)
  | pair (a b : Expr)
  | fst (e : Expr)
  | snd (e : Expr)
  | letE (e b : Expr)
  | alloc (m : Bool) (t : Ty) (e : Expr)
  | read (e : Expr)
  | write (e v : Expr)
  | block (e : Expr)
  | call (g : Nat) (ts : List Ty) (a : Nat) (e : Expr)
  | fnref (g : Nat) (ts : List Ty)
  | callv (a : Nat) (ef e : Expr)
  | onone (t : Ty)
  | osome (e : Expr)
  /-- 注釈 t は結果の型（2つの枝の型の上界） -/
  | case (t : Ty) (e e1 e2 : Expr)
  /-- 注釈 t は再帰型 -/
  | fold (t : Ty) (e : Expr)
  | unfold (e : Expr)
  /-- 形式コピー: e の値を region k（その項が型付く世界の座標）へ深く写す（imm の値だけ） -/
  | copy (k : Nat) (e : Expr)
  /-- mut の box の像（imm の ref）: 同じセルを、書けない参照として見る。中身の型は正確一致のまま -/
  | view (e : Expr)

inductive Val : Type where
  | lit (n : Int)
  | loc (r x : Nat)
  | pair (a b : Val)
  | fnref (g : Nat) (ts : List Ty)
  | onone
  | osome (v : Val)

/-- Def: 型パラメータの kind（旗）・仮引数と戻り値の型（base 座標）・本体（仮引数は var 0） -/
structure Def where
  κ : List Kind
  p : Ty
  q : Ty
  body : Expr

abbrev Heap := List (List (Bool × Val))
abbrev StTy := List (List (Bool × Ty))

/-- 実行の座標: base の region 0 ↦ a・k + 1 ↦ k + 1 + δ と、型引数（閉じた型） -/
structure Inst where
  a : Nat
  δ : Nat
  σ : List Ty

def Inst.ty (I : Inst) (t : Ty) : Ty := (t.ren I.a I.δ).tsubst I.σ
def Inst.reg (I : Inst) (r : Nat) : Nat := rmap I.a I.δ r

inductive Res : Type where
  | ok (H : Heap) (v : Val)
  | timeout
  | err

def hget {α : Type} (H : List (List α)) (r x : Nat) : Option α := (H[r]?).bind (·[x]?)

def Res.bind : Res → (Heap → Val → Res) → Res
  | .ok H v, k => k H v
  | .timeout, _ => .timeout
  | .err, _ => .err

/-- 値を region k へ深く写す（imm のセルを k に作り直す。fold は値の上では恒等）。燃料つき -/
def copyV : Nat → Nat → Heap → Val → Res
  | 0, _, _, _ => .timeout
  | n + 1, k, H, v => match v with
    | .lit z => .ok H (.lit z)
    | .pair a b => (copyV n k H a).bind fun H1 a' => (copyV n k H1 b).bind fun H2 b' => .ok H2 (.pair a' b')
    | .loc r x => match hget H r x with
      | some c => (copyV n k H c.2).bind fun H1 w => match H1[k]? with
        | some row => .ok (H1.set k (row ++ [(false, w)])) (.loc k row.length)
        | none => .err
      | none => .err
    | .fnref g ts => .ok H (.fnref g ts)
    | .onone => .ok H .onone
    | .osome w => (copyV n k H w).bind fun H1 w' => .ok H1 (.osome w')

/-- 評価（燃料つき）。呼び出しはフレームを呼び手の最内に合わせる（base の region 1 ↦ 最内）。err = ぶら下がり・形の不一致 -/
def eval : Nat → List Def → Inst → Heap → List Val → Expr → Res
  | 0, _, _, _, _, _ => .timeout
  | n + 1, Δ, I, H, env, e =>
    match e with
    | .var i => match env[i]? with
      | some v => .ok H v
      | none => .err
    | .lit k => .ok H (.lit k)
    | .pair a b => (eval n Δ I H env a).bind fun H1 va =>
        (eval n Δ I H1 env b).bind fun H2 vb => .ok H2 (.pair va vb)
    | .fst e => (eval n Δ I H env e).bind fun H1 v => match v with
      | .pair va _ => .ok H1 va
      | _ => .err
    | .snd e => (eval n Δ I H env e).bind fun H1 v => match v with
      | .pair _ vb => .ok H1 vb
      | _ => .err
    | .letE e b => (eval n Δ I H env e).bind fun H1 v => eval n Δ I H1 (v :: env) b
    | .alloc m _ e => (eval n Δ I H env e).bind fun H1 v => match H1[H1.length - 1]? with
      | some row => .ok (H1.set (H1.length - 1) (row ++ [(m, v)])) (.loc (H1.length - 1) row.length)
      | none => .err
    | .read e => (eval n Δ I H env e).bind fun H1 v => match v with
      | .loc r x => match hget H1 r x with
        | some c => .ok H1 c.2
        | none => .err
      | _ => .err
    | .write e v => (eval n Δ I H env e).bind fun H1 l => (eval n Δ I H1 env v).bind fun H2 w =>
      match l with
      | .loc r x => match H2[r]? with
        | some row => if x < row.length then .ok (H2.set r (row.set x (true, w))) (.lit 0) else .err
        | none => .err
      | _ => .err
    | .block e => (eval n Δ I (H ++ [[]]) env e).bind fun H1 v => .ok (H1.take H.length) v
    | .call g ts a e => (eval n Δ I H env e).bind fun H1 v => match Δ[g]? with
      | some dfn => eval n Δ ⟨I.reg a, H1.length - 2, ts.map I.ty⟩ H1 [v] dfn.body
      | none => .err
    | .fnref g ts => .ok H (.fnref g (ts.map I.ty))
    | .callv a ef e => (eval n Δ I H env ef).bind fun H1 fv => (eval n Δ I H1 env e).bind fun H2 v =>
      match fv with
      | .fnref g ts' => match Δ[g]? with
        | some dfn => eval n Δ ⟨I.reg a, H2.length - 2, ts'.map (Ty.at (I.reg a))⟩ H2 [v] dfn.body
        | none => .err
      | _ => .err
    | .onone _ => .ok H .onone
    | .osome e => (eval n Δ I H env e).bind fun H1 v => .ok H1 (.osome v)
    | .case _ e e1 e2 => (eval n Δ I H env e).bind fun H1 v => match v with
      | .onone => eval n Δ I H1 env e1
      | .osome w => eval n Δ I H1 (w :: env) e2
      | _ => .err
    | .fold _ e => eval n Δ I H env e
    | .unfold e => eval n Δ I H env e
    | .copy k e => (eval n Δ I H env e).bind fun H1 v => copyV n (I.reg k) H1 v
    | .view e => eval n Δ I H env e

/-! ## 型付け -/

/-- 型引数の条件: 呼び手の世界の深さ D 未満の region・kind を満たす -/
def argsOk (κ : List Kind) (D : Nat) (κ' : List Kind) (ts : List Ty) : Prop :=
  (∀ s ∈ ts, (s.N κ).rb D = true) ∧ (∀ i, kindMut κ' i = false → (look ts i).mf κ = true) ∧
    (∀ i, kindRF κ' i = true → (look ts i).rfK κ = true) ∧ (∀ s ∈ ts, s.rc 0 = true) ∧
    ∀ i, kindCov κ' i = true → (look ts i).cv κ = true

/-- 型付け（κ = いまのDefの型パラメータの kind・D = 深さ・Γ = 文脈）。部分型の L はフレーム（1） -/
inductive HasType (Δ : List Def) (κ : List Kind) : Nat → List Ty → Expr → Ty → Prop where
  | var {D Γ i t} : Γ[i]? = some t → HasType Δ κ D Γ (.var i) t
  | lit {D Γ n} : HasType Δ κ D Γ (.lit n) .int
  | pair {D Γ a b ta tb} : HasType Δ κ D Γ a ta → HasType Δ κ D Γ b tb → HasType Δ κ D Γ (.pair a b) (.prod ta tb)
  | fst {D Γ e ta tb} : HasType Δ κ D Γ e (.prod ta tb) → HasType Δ κ D Γ (.fst e) ta
  | snd {D Γ e ta tb} : HasType Δ κ D Γ e (.prod ta tb) → HasType Δ κ D Γ (.snd e) tb
  | letE {D Γ e b t1 t2} : HasType Δ κ D Γ e t1 → HasType Δ κ D (t1 :: Γ) b t2 → HasType Δ κ D Γ (.letE e b) t2
  | sub {D Γ e t t'} : HasType Δ κ D Γ e t → Ty.sub κ 1 t t' = true → HasType Δ κ D Γ e t'
  | alloc {D Γ m e t} : HasType Δ κ D Γ e t → (t.N κ).rb D = true → HasType Δ κ D Γ (.alloc m t e) (.box m (D - 1) t)
  | read {D Γ e m r t} : HasType Δ κ D Γ e (.box m r t) → HasType Δ κ D Γ (.read e) t
  | readR {D Γ e r t} : HasType Δ κ D Γ e (.iref r t) → HasType Δ κ D Γ (.read e) t
  | write {D Γ e v r t} : HasType Δ κ D Γ e (.box true r t) → HasType Δ κ D Γ v t → HasType Δ κ D Γ (.write e v) .int
  | block {D Γ e t} : HasType Δ κ (D + 1) Γ e t → (t.N κ).rb D = true → HasType Δ κ D Γ (.block e) t
  | call {D Γ g ts a e dfn} : Δ[g]? = some dfn → argsOk κ D dfn.κ ts → a + 1 ≤ D →
      HasType Δ κ D Γ e ((dfn.p.ren a (D - 2)).tsubst ts) →
      HasType Δ κ D Γ (.call g ts a e) ((dfn.q.ren a (D - 2)).tsubst ts)
  | fnref {D Γ g ts dfn} : Δ[g]? = some dfn → argsOk κ D dfn.κ ts →
      HasType Δ κ D Γ (.fnref g ts) ((Ty.fn dfn.p dfn.q).tsubst ts)
  | callv {D Γ a ef e p q} : HasType Δ κ D Γ ef (.fn p q) → a + 1 ≤ D →
      HasType Δ κ D Γ e (p.lowTv.ren a (D - 2)) → HasType Δ κ D Γ (.callv a ef e) (q.lowTv.ren a (D - 2))
  | onone {D Γ t} : HasType Δ κ D Γ (.onone t) (.opt t)
  | osome {D Γ e t} : HasType Δ κ D Γ e t → HasType Δ κ D Γ (.osome e) (.opt t)
  | case {D Γ t e e1 e2 a} : HasType Δ κ D Γ e (.opt a) → HasType Δ κ D Γ e1 t → HasType Δ κ D (a :: Γ) e2 t →
      HasType Δ κ D Γ (.case t e e1 e2) t
  | fold {D Γ r b e} : HasType Δ κ D Γ e (Ty.unf r b) → HasType Δ κ D Γ (.fold (.mu r b) e) (.mu r b)
  | unfold {D Γ r b e} : HasType Δ κ D Γ e (.mu r b) → HasType Δ κ D Γ (.unfold e) (Ty.unf r b)
  /-- 形式コピー: mut を持たない値を region k（k < D）へ写す。結果の型は全部の region を k へ置き直した型 -/
  | copy {D Γ k e t} : HasType Δ κ D Γ e t → t.mf κ = true → k + 1 ≤ D → HasType Δ κ D Γ (.copy k e) (t.at k)
  /-- mut の box の像: region も中身の型もそのまま、書けない参照にする -/
  | view {D Γ e r t} : HasType Δ κ D Γ e (.box true r t) → HasType Δ κ D Γ (.view e) (.iref r t)

/-- Def の表の整形: どの本体も base（深さ 2・仮引数は var 0）で型付く -/
def DefsOk (Δ : List Def) : Prop :=
  ∀ (g : Nat) (dfn : Def), Δ[g]? = some dfn → HasType Δ dfn.κ 2 [dfn.p] dfn.body dfn.q

/-! ## 値とヒープの型 -/

/-- 値の型（閉じた型。ストアの型 Ψ に対して） -/
inductive VT (Δ : List Def) (Ψ : StTy) : Val → Ty → Prop where
  | lit {n} : VT Δ Ψ (.lit n) .int
  | locM {r x t} : hget Ψ r x = some (true, t) → VT Δ Ψ (.loc r x) (.box true r t)
  | locI {r x m tc r' t} : hget Ψ r x = some (m, tc) → r ≤ r' → csub tc t = true → VT Δ Ψ (.loc r x) (.box false r' t)
  /-- imm の ref: セルの型と中身の型は正確一致（セルが mut でもよい） -/
  | locR {r x m r' t} : hget Ψ r x = some (m, t) → r ≤ r' → VT Δ Ψ (.loc r x) (.iref r' t)
  | pair {a b ta tb} : VT Δ Ψ a ta → VT Δ Ψ b tb → VT Δ Ψ (.pair a b) (.prod ta tb)
  | fnref {g ts dfn} : Δ[g]? = some dfn → (∀ s ∈ ts, s.closed = true) →
      (∀ i, kindMut dfn.κ i = false → (look ts i).mf [] = true) →
      (∀ i, kindRF dfn.κ i = true → (look ts i).rfK [] = true) → (∀ s ∈ ts, s.rc 0 = true) →
      (∀ i, kindCov dfn.κ i = true → (look ts i).cv [] = true) →
      VT Δ Ψ (.fnref g ts) ((Ty.fn dfn.p dfn.q).tsubst ts)
  | onone {t} : VT Δ Ψ .onone (.opt t)
  | osome {v t} : VT Δ Ψ v t → VT Δ Ψ (.osome v) (.opt t)
  | fold {v r b} : VT Δ Ψ v (Ty.unf r b) → VT Δ Ψ v (.mu r b)

/-- ストアの伸長: region は増えてよく、各 region の行は前に足すだけ -/
def Ext (Ψ Ψ' : StTy) : Prop :=
  Ψ.length ≤ Ψ'.length ∧ ∀ (r : Nat) (row : List (Bool × Ty)), Ψ[r]? = some row → ∃ row', Ψ'[r]? = some row' ∧ row <+: row'

/-- ヒープの整形: 形が一致し、セルの値はセルの型に型付き、セルの型は閉じていて自分の region 以下 -/
def HeapOk (Δ : List Def) (Ψ : StTy) (H : Heap) : Prop :=
  H.length = Ψ.length ∧
  (∀ r : Nat, (H[r]?).map List.length = (Ψ[r]?).map List.length) ∧
  (∀ (r x : Nat) (m : Bool) (v : Val), hget H r x = some (m, v) → ∃ t, hget Ψ r x = some (m, t) ∧ VT Δ Ψ v t) ∧
  (∀ (r x : Nat) (m : Bool) (t : Ty), hget Ψ r x = some (m, t) → t.closed = true ∧ t.rb (r + 1) = true)

def EnvOk (Δ : List Def) (Ψ : StTy) (env : List Val) (Γ : List Ty) : Prop :=
  env.length = Γ.length ∧ ∀ (i : Nat) (v : Val) (t : Ty), env[i]? = some v → Γ[i]? = some t → VT Δ Ψ v t

/-- 実行の座標の整形（κ = 本体の型パラメータの kind） -/
def InstOk (κ : List Kind) (I : Inst) : Prop :=
  I.a ≤ 1 + I.δ ∧ (∀ s ∈ I.σ, s.closed = true) ∧ (∀ s ∈ I.σ, s.rb (2 + I.δ) = true) ∧
  (∀ i, kindMut κ i = false → (look I.σ i).mf [] = true) ∧
  (∀ i, kindRF κ i = true → (look I.σ i).rfK [] = true) ∧ (∀ s ∈ I.σ, s.rc 0 = true) ∧
  ∀ i, kindCov κ i = true → (look I.σ i).cv [] = true

/-- 評価の結果の性質: err にならず、ok なら伸長したストアで型付く（ヒープの region の数は変わらない） -/
def Good (Δ : List Def) (Ψ : StTy) (H : Heap) (t : Ty) : Res → Prop
  | .err => False
  | .timeout => True
  | .ok H' v => ∃ Ψ', Ext Ψ Ψ' ∧ HeapOk Δ Ψ' H' ∧ H'.length = H.length ∧ VT Δ Ψ' v t

/-! ## ストアとヒープの補題 -/

theorem prefix_get {α : Type} {l l' : List α} (h : l <+: l') {x : Nat} {c : α} (hx : l[x]? = some c) :
    l'[x]? = some c := by
  obtain ⟨u, rfl⟩ := h
  have hlt : x < l.length := by
    rcases Nat.lt_or_ge x l.length with h | h
    · exact h
    · rw [List.getElem?_eq_none h] at hx; cases hx
  rw [List.getElem?_append_left hlt]; exact hx

theorem Ext.refl (Ψ : StTy) : Ext Ψ Ψ := ⟨Nat.le_refl _, fun _ row h => ⟨row, h, List.prefix_refl _⟩⟩

theorem Ext.trans {Ψ1 Ψ2 Ψ3 : StTy} (h1 : Ext Ψ1 Ψ2) (h2 : Ext Ψ2 Ψ3) : Ext Ψ1 Ψ3 := by
  refine ⟨Nat.le_trans h1.1 h2.1, fun r row h => ?_⟩
  obtain ⟨row', h', hp⟩ := h1.2 r row h
  obtain ⟨row'', h'', hp'⟩ := h2.2 r row' h'
  exact ⟨row'', h'', hp.trans hp'⟩

theorem Ext.get {Ψ Ψ' : StTy} (he : Ext Ψ Ψ') {r x : Nat} {c : Bool × Ty} (h : hget Ψ r x = some c) :
    hget Ψ' r x = some c := by
  unfold hget at h ⊢
  cases hr : Ψ[r]? with
  | none => rw [hr] at h; cases h
  | some row =>
    rw [hr] at h
    obtain ⟨row', h', hp⟩ := he.2 r row hr
    rw [h']; exact prefix_get hp h

theorem VT.mono {Δ : List Def} {Ψ Ψ' : StTy} (he : Ext Ψ Ψ') {v : Val} {t : Ty} (h : VT Δ Ψ v t) : VT Δ Ψ' v t := by
  induction h with
  | lit => exact .lit
  | locM h => exact .locM (he.get h)
  | locI h hr hs => exact .locI (he.get h) hr hs
  | locR h hr => exact .locR (he.get h) hr
  | pair _ _ iha ihb => exact .pair iha ihb
  | fnref hg hc hk hk2 hk3 hk4 => exact .fnref hg hc hk hk2 hk3 hk4
  | onone => exact .onone
  | osome _ ih => exact .osome ih
  | fold _ ih => exact .fold ih

theorem VT.csub {Δ : List Def} {Ψ : StTy} {v : Val} {t : Ty} (h : VT Δ Ψ v t) : ∀ {t' : Ty}, csub t t' = true → VT Δ Ψ v t' := by
  induction h with
  | lit => intro t' hs; cases t' <;> simp [Ty.sub0] at hs; exact .lit
  | locM h =>
    intro t' hs; cases t' with
    | box m r t => cases m <;> simp [Ty.sub0] at hs; obtain ⟨rfl, rfl⟩ := hs; exact .locM h
    | _ => simp [Ty.sub0] at hs
  | locI h hr hs0 =>
    intro t' hs; cases t' with
    | box m r t => cases m <;> simp [Ty.sub0] at hs; exact .locI h (Nat.le_trans hr hs.1) (Ty.sub_trans hs0 hs.2)
    | _ => simp [Ty.sub0] at hs
  | locR h hr =>
    intro t' hs; cases t' with
    | iref r t => simp [Ty.sub0] at hs; obtain ⟨hs, rfl⟩ := hs; exact .locR h (Nat.le_trans hr hs)
    | _ => simp [Ty.sub0] at hs
  | pair _ _ iha ihb =>
    intro t' hs; cases t' with
    | prod a b => simp [Ty.sub0] at hs; exact .pair (iha hs.1) (ihb hs.2)
    | _ => simp [Ty.sub0] at hs
  | fnref hg hc hk hk2 hk3 hk4 =>
    intro t' hs; cases t' with
    | fn p q => simp [Ty.tsubst, Ty.sub0] at hs; obtain ⟨rfl, rfl⟩ := hs; exact .fnref hg hc hk hk2 hk3 hk4
    | _ => simp [Ty.tsubst, Ty.sub0] at hs
  | onone => intro t' hs; cases t' <;> simp [Ty.sub0] at hs; exact .onone
  | osome _ ih =>
    intro t' hs; cases t' with
    | opt a => simp [Ty.sub0] at hs; exact .osome (ih hs)
    | _ => simp [Ty.sub0] at hs
  | @fold v r b _ ih =>
    intro t' hs; cases t' with
    | mu r' b' => simp [Ty.sub0] at hs; obtain ⟨rfl, hs⟩ := hs; exact .fold (ih (csub_unf hs))
    | _ => simp [Ty.sub0] at hs

theorem EnvOk.mono {Δ : List Def} {Ψ Ψ' : StTy} (he : Ext Ψ Ψ') {env : List Val} {Γ : List Ty}
    (h : EnvOk Δ Ψ env Γ) : EnvOk Δ Ψ' env Γ :=
  ⟨h.1, fun i v t h1 h2 => (h.2 i v t h1 h2).mono he⟩

theorem EnvOk.cons {Δ : List Def} {Ψ : StTy} {env : List Val} {Γ : List Ty} {v : Val} {t : Ty}
    (h : EnvOk Δ Ψ env Γ) (hv : VT Δ Ψ v t) : EnvOk Δ Ψ (v :: env) (t :: Γ) := by
  refine ⟨by simp [h.1], fun i w s h1 h2 => ?_⟩
  cases i with
  | zero => simp at h1 h2; subst h1; subst h2; exact hv
  | succ i => simp at h1 h2; exact h.2 i w s h1 h2

theorem Res.bind_good {Δ : List Def} {Ψ : StTy} {H : Heap} {t1 t : Ty} {r : Res} {k : Heap → Val → Res}
    (hr : Good Δ Ψ H t1 r)
    (hk : ∀ Ψ1 H1 v, Ext Ψ Ψ1 → HeapOk Δ Ψ1 H1 → H1.length = H.length → VT Δ Ψ1 v t1 → Good Δ Ψ H t (k H1 v)) :
    Good Δ Ψ H t (r.bind k) := by
  cases r with
  | ok H1 v => obtain ⟨Ψ1, he, hh, hl, hv⟩ := hr; exact hk Ψ1 H1 v he hh hl hv
  | timeout => trivial
  | err => cases hr

theorem Good.ext {Δ : List Def} {Ψ Ψ1 : StTy} {H H1 : Heap} {t : Ty} {r : Res} (he : Ext Ψ Ψ1)
    (hl : H1.length = H.length) (h : Good Δ Ψ1 H1 t r) : Good Δ Ψ H t r := by
  cases r with
  | ok H2 v => obtain ⟨Ψ2, he2, hh, hl2, hv⟩ := h; exact ⟨Ψ2, he.trans he2, hh, by omega, hv⟩
  | timeout => trivial
  | err => cases h

theorem Good.csub {Δ : List Def} {Ψ : StTy} {H : Heap} {t t' : Ty} {r : Res} (hs : csub t t' = true)
    (h : Good Δ Ψ H t r) : Good Δ Ψ H t' r := by
  cases r with
  | ok H2 v => obtain ⟨Ψ2, he2, hh, hl2, hv⟩ := h; exact ⟨Ψ2, he2, hh, hl2, hv.csub hs⟩
  | timeout => trivial
  | err => cases h

theorem Good.vt {Δ : List Def} {Ψ : StTy} {H : Heap} {t t' : Ty} {r : Res}
    (hs : ∀ (Ψ' : StTy) (v : Val), VT Δ Ψ' v t → VT Δ Ψ' v t') (h : Good Δ Ψ H t r) : Good Δ Ψ H t' r := by
  cases r with
  | ok H2 v => obtain ⟨Ψ2, he2, hh, hl2, hv⟩ := h; exact ⟨Ψ2, he2, hh, hl2, hs _ _ hv⟩
  | timeout => trivial
  | err => cases h

theorem hget_append_lt {α : Type} {H : List (List α)} {row : List α} {r x : Nat} (hr : r < H.length) :
    hget (H ++ [row]) r x = hget H r x := by
  simp [hget, List.getElem?_append_left hr]

theorem hget_take {α : Type} {H : List (List α)} {L r x : Nat} (hr : r < L) :
    hget (H.take L) r x = hget H r x := by
  simp [hget, List.getElem?_take_of_lt hr]

theorem hget_lt {α : Type} {H : List (List α)} {r x : Nat} {c : α} (h : hget H r x = some c) : r < H.length := by
  unfold hget at h
  rcases Nat.lt_or_ge r H.length with hr | hr
  · exact hr
  · rw [List.getElem?_eq_none hr] at h; cases h

theorem VT.take {Δ : List Def} {Ψ : StTy} {L : Nat} {v : Val} {t : Ty} (h : VT Δ Ψ v t) (hr : t.rb L = true) :
    VT Δ (Ψ.take L) v t := by
  induction h with
  | lit => exact .lit
  | locM h => simp [Ty.rb] at hr; exact .locM (by rw [hget_take hr.1]; exact h)
  | locI h hr' hs => simp [Ty.rb] at hr; exact .locI (by rw [hget_take (by omega)]; exact h) hr' hs
  | locR h hr' => simp [Ty.rb] at hr; exact .locR (by rw [hget_take (by omega)]; exact h) hr'
  | pair _ _ iha ihb => simp [Ty.rb] at hr; exact .pair (iha hr.1) (ihb hr.2)
  | fnref hg hc hk hk2 hk3 hk4 => exact .fnref hg hc hk hk2 hk3 hk4
  | onone => exact .onone
  | osome _ ih => simp [Ty.rb] at hr; exact .osome (ih hr)
  | fold _ ih => simp [Ty.rb] at hr; exact .fold (ih (Ty.rb_unf hr _))

/-- ヒープのセルの読み出し（型の側にセルがあれば、ヒープにも同じ形のセルがある） -/
theorem HeapOk.get {Δ : List Def} {Ψ : StTy} {H : Heap} (hh : HeapOk Δ Ψ H) {r x : Nat} {m : Bool} {t : Ty}
    (h : hget Ψ r x = some (m, t)) : ∃ v, hget H r x = some (m, v) ∧ VT Δ Ψ v t := by
  obtain ⟨-, hshape, hcell, -⟩ := hh
  unfold hget at h
  cases hΨ : Ψ[r]? with
  | none => rw [hΨ] at h; cases h
  | some rowT =>
    rw [hΨ] at h
    have hs := hshape r
    rw [hΨ] at hs
    cases hH : H[r]? with
    | none => rw [hH] at hs; cases hs
    | some rowH =>
      rw [hH] at hs; simp at hs
      have hx : x < rowH.length := by
        rcases Nat.lt_or_ge x rowT.length with h' | h'
        · omega
        · simp at h; rw [List.getElem?_eq_none h'] at h; cases h
      obtain ⟨c, hc⟩ : ∃ c, rowH[x]? = some c := ⟨rowH[x], List.getElem?_eq_getElem hx⟩
      obtain ⟨m', v⟩ := c
      have hg : hget H r x = some (m', v) := by simp [hget, hH, hc]
      obtain ⟨t', ht', hv⟩ := hcell r x m' v hg
      simp [hget, hΨ] at ht'
      simp at h
      rw [h] at ht'; cases ht'
      exact ⟨v, hg, hv⟩

theorem HeapOk.push {Δ : List Def} {Ψ : StTy} {H : Heap} (hh : HeapOk Δ Ψ H) :
    Ext Ψ (Ψ ++ [[]]) ∧ HeapOk Δ (Ψ ++ [[]]) (H ++ [[]]) := by
  obtain ⟨hlen, hshape, hcell, hwf⟩ := hh
  have he : Ext Ψ (Ψ ++ [[]]) := by
    refine ⟨by simp, fun r row h => ⟨row, ?_, List.prefix_refl _⟩⟩
    have : r < Ψ.length := by
      rcases Nat.lt_or_ge r Ψ.length with h' | h'
      · exact h'
      · rw [List.getElem?_eq_none h'] at h; cases h
    rw [List.getElem?_append_left this]; exact h
  refine ⟨he, by simp [hlen], fun r => ?_, fun r x m v h => ?_, fun r x m t h => ?_⟩
  · rcases Nat.lt_or_ge r H.length with h' | h'
    · rw [List.getElem?_append_left h', List.getElem?_append_left (by omega)]; exact hshape r
    · rw [List.getElem?_append_right h', List.getElem?_append_right (by omega)]
      rw [hlen] at h' ⊢; rcases Nat.lt_or_ge (r - Ψ.length) 1 with h2 | h2 <;> simp [List.getElem?_cons]
      all_goals (cases hk : r - Ψ.length <;> simp_all)
  · have hr := hget_lt h
    simp at hr
    rcases Nat.lt_or_ge r H.length with h' | h'
    · rw [hget_append_lt h'] at h
      obtain ⟨t, ht, hv⟩ := hcell r x m v h
      exact ⟨t, by rw [hget_append_lt (by omega)]; exact ht, hv.mono he⟩
    · have : r = H.length := by omega
      subst this; simp [hget] at h
  · have hr := hget_lt h
    simp at hr
    rcases Nat.lt_or_ge r Ψ.length with h' | h'
    · rw [hget_append_lt h'] at h; exact hwf r x m t h
    · have : r = Ψ.length := by omega
      subst this; simp [hget] at h

/-- block の出口: 最内の region を捨てる -/
theorem HeapOk.pop {Δ : List Def} {Ψ Ψ1 : StTy} {H1 : Heap} {L : Nat} (hΨ : Ψ.length = L)
    (he : Ext (Ψ ++ [[]]) Ψ1) (hh : HeapOk Δ Ψ1 H1) (hl : H1.length = L + 1) :
    Ext Ψ (Ψ1.take L) ∧ HeapOk Δ (Ψ1.take L) (H1.take L) := by
  obtain ⟨hlen, hshape, hcell, hwf⟩ := hh
  refine ⟨⟨by simp; omega, fun r row h => ?_⟩, by simp; omega, fun r => ?_, fun r x m v h => ?_, fun r x m t h => ?_⟩
  · have hr : r < L := by
      rcases Nat.lt_or_ge r Ψ.length with h' | h'
      · omega
      · rw [List.getElem?_eq_none h'] at h; cases h
    have h0 : (Ψ ++ [[]])[r]? = some row := by rw [List.getElem?_append_left (by omega)]; exact h
    obtain ⟨row', h1, hp⟩ := he.2 r row h0
    exact ⟨row', by rw [List.getElem?_take_of_lt hr]; exact h1, hp⟩
  · rcases Nat.lt_or_ge r L with h' | h'
    · rw [List.getElem?_take_of_lt h', List.getElem?_take_of_lt h']; exact hshape r
    · rw [List.getElem?_eq_none (by simp; omega), List.getElem?_eq_none (by simp; omega)]; rfl
  · have hr := hget_lt h
    simp at hr
    rw [hget_take (by omega)] at h
    obtain ⟨t, ht, hv⟩ := hcell r x m v h
    have hrb := (hwf r x m t ht).2
    exact ⟨t, by rw [hget_take (by omega)]; exact ht, hv.take (Ty.rb_mono (by omega) t hrb)⟩
  · have hr := hget_lt h
    simp at hr
    rw [hget_take (by omega)] at h
    exact hwf r x m t h

theorem getElem?_set_row {α : Type} {H : List (List α)} {k r : Nat} {row : List α} (hk : k < H.length) :
    (H.set k row)[r]? = if k = r then some row else H[r]? := by
  rw [List.getElem?_set]; split <;> simp_all

/-- alloc: 最内の region k の行の末尾にセルを足す -/
theorem HeapOk.alloc {Δ : List Def} {Ψ : StTy} {H : Heap} (hh : HeapOk Δ Ψ H) {k : Nat} {row : List (Bool × Val)}
    (hk : H[k]? = some row) {m : Bool} {v : Val} {t : Ty} (hc : t.closed = true) (hr : t.rb (k + 1) = true)
    (hv : VT Δ Ψ v t) :
    ∃ Ψ2, Ext Ψ Ψ2 ∧ HeapOk Δ Ψ2 (H.set k (row ++ [(m, v)])) ∧ hget Ψ2 k row.length = some (m, t) := by
  obtain ⟨hlen, hshape, hcell, hwf⟩ := hh
  have hkl : k < H.length := by
    rcases Nat.lt_or_ge k H.length with h | h
    · exact h
    · rw [List.getElem?_eq_none h] at hk; cases hk
  obtain ⟨rowT, hT⟩ : ∃ rowT, Ψ[k]? = some rowT := ⟨Ψ[k]'(by omega), List.getElem?_eq_getElem (by omega)⟩
  have hsk := hshape k
  rw [hk, hT] at hsk; simp at hsk
  let Ψ2 := Ψ.set k (rowT ++ [(m, t)])
  have he : Ext Ψ Ψ2 := by
    refine ⟨by simp [Ψ2], fun r row' h => ?_⟩
    by_cases hrk : k = r
    · subst hrk; rw [hT] at h; cases h
      exact ⟨rowT ++ [(m, t)], by simp [Ψ2, getElem?_set_row (show k < Ψ.length by omega)], List.prefix_append _ _⟩
    · exact ⟨row', by simp [Ψ2, getElem?_set_row (show k < Ψ.length by omega), hrk, h], List.prefix_refl _⟩
  have hget2 : hget Ψ2 k row.length = some (m, t) := by
    simp [hget, Ψ2, getElem?_set_row (show k < Ψ.length by omega), hsk]
  refine ⟨Ψ2, he, ⟨by simp [Ψ2, hlen], fun r => ?_, fun r x m' v' h => ?_, fun r x m' t' h => ?_⟩, hget2⟩
  · by_cases hrk : k = r
    · subst hrk; simp [Ψ2, getElem?_set_row hkl, getElem?_set_row (show k < Ψ.length by omega), hsk]
    · simp [Ψ2, getElem?_set_row hkl, getElem?_set_row (show k < Ψ.length by omega), hrk, hshape r]
  · by_cases hrk : k = r
    · subst hrk
      simp [hget, getElem?_set_row hkl] at h
      rcases Nat.lt_or_ge x row.length with hx | hx
      · rw [List.getElem?_append_left hx] at h
        have hg : hget H k x = some (m', v') := by simp [hget, hk, h]
        obtain ⟨t1, ht1, hv1⟩ := hcell k x m' v' hg
        refine ⟨t1, ?_, hv1.mono he⟩
        simp [hget, hT] at ht1
        simp [hget, Ψ2, getElem?_set_row (show k < Ψ.length by omega), List.getElem?_append_left (show x < rowT.length by omega), ht1]
      · rw [List.getElem?_append_right hx] at h
        have hx' : x - row.length = 0 := by
          rcases Nat.lt_or_ge (x - row.length) 1 with h1 | h1
          · omega
          · rw [List.getElem?_eq_none (by simp; omega)] at h; cases h
        rw [hx'] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
        have : x = row.length := by omega
        subst this; exact ⟨t, hget2, hv.mono he⟩
    · have hg : hget H r x = some (m', v') := by simpa [hget, getElem?_set_row hkl, hrk] using h
      obtain ⟨t1, ht1, hv1⟩ := hcell r x m' v' hg
      exact ⟨t1, he.get ht1, hv1.mono he⟩
  · by_cases hrk : k = r
    · subst hrk
      simp [hget, Ψ2, getElem?_set_row (show k < Ψ.length by omega)] at h
      rcases Nat.lt_or_ge x rowT.length with hx | hx
      · rw [List.getElem?_append_left hx] at h
        exact hwf k x m' t' (by simp [hget, hT, h])
      · rw [List.getElem?_append_right hx] at h
        have hx' : x - rowT.length = 0 := by
          rcases Nat.lt_or_ge (x - rowT.length) 1 with h1 | h1
          · omega
          · rw [List.getElem?_eq_none (by simp; omega)] at h; cases h
        rw [hx'] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
        exact ⟨hc, hr⟩
    · exact hwf r x m' t' (by simpa [hget, Ψ2, getElem?_set_row (show k < Ψ.length by omega), hrk] using h)

/-- write: mut のセルを同じ型の値で書き換える -/
theorem HeapOk.write {Δ : List Def} {Ψ : StTy} {H : Heap} (hh : HeapOk Δ Ψ H) {r x : Nat} {t : Ty}
    (hT : hget Ψ r x = some (true, t)) {row : List (Bool × Val)} (hr : H[r]? = some row) {w : Val}
    (hw : VT Δ Ψ w t) : HeapOk Δ Ψ (H.set r (row.set x (true, w))) := by
  obtain ⟨hlen, hshape, hcell, hwf⟩ := hh
  have hrl : r < H.length := by
    rcases Nat.lt_or_ge r H.length with h | h
    · exact h
    · rw [List.getElem?_eq_none h] at hr; cases hr
  refine ⟨by simp [hlen], fun r' => ?_, fun r' x' m' v' h => ?_, hwf⟩
  · by_cases hrr : r = r'
    · subst hrr; have := hshape r; rw [hr] at this; simp [getElem?_set_row hrl, this.symm]
    · simp [getElem?_set_row hrl, hrr, hshape r']
  · by_cases hrr : r = r'
    · subst hrr
      simp [hget, getElem?_set_row hrl, List.getElem?_set] at h
      by_cases hxx : x = x'
      · subst hxx; simp at h; obtain ⟨-, rfl, rfl⟩ := h; exact ⟨t, hT, hw⟩
      · simp [hxx] at h
        exact hcell r x' m' v' (by simp [hget, hr, h])
    · exact hcell r' x' m' v' (by simpa [hget, getElem?_set_row hrl, hrr] using h)

/-- 形式コピー: mut を持たない型の値を region k へ写すと、写した値は全部の region を k へ置き直した型に型付く
（読むだけで、もとのセルは変えない。新しいセルは region k の行の末尾） -/
theorem copy_good {Δ : List Def} : ∀ (n : Nat) {Ψ : StTy} {H : Heap} {k : Nat} {v : Val} {t : Ty},
    HeapOk Δ Ψ H → k < H.length → VT Δ Ψ v t → t.mf [] = true → Good Δ Ψ H (t.at k) (copyV n k H v)
  | 0, _, _, _, _, _, _, _, _, _ => trivial
  | n + 1, Ψ, H, k, v, t, hh, hk, hv, hm => by
    induction hv with
    | lit => exact ⟨Ψ, Ext.refl _, hh, rfl, .lit⟩
    | locM _ => simp [Ty.mf] at hm
    | @locI r x m tc r' t' hg _ hs =>
      simp [Ty.mf] at hm
      have hmc : tc.mf [] = true := Ty.mf_of_sub0 hs hm
      obtain ⟨w, hw, hvw⟩ := hh.get hg
      have hcl : tc.closed = true := (hh.2.2.2 r x m tc hg).1
      simp only [copyV, hw]
      refine Res.bind_good (copy_good n hh hk hvw hmc) fun Ψ1 H1 w' he1 hh1 hl1 hw' => ?_
      have hk1 : k < H1.length := by omega
      have hrow : H1[k]? = some H1[k] := List.getElem?_eq_getElem hk1
      simp only [hrow]
      obtain ⟨Ψ2, he2, hh2, hg2⟩ := hh1.alloc hrow (Ty.closed_at k _ hcl) (Ty.rb_at (Nat.lt_succ_self k) _) (m := false) hw'
      refine ⟨Ψ2, he1.trans he2, hh2, by simp; omega, ?_⟩
      exact .locI hg2 (Nat.le_refl _) (Ty.sub0_at hs)
    | @locR r x m r' t' hg _ =>
      simp [Ty.mf] at hm
      obtain ⟨w, hw, hvw⟩ := hh.get hg
      have hcl : t'.closed = true := (hh.2.2.2 r x m t' hg).1
      simp only [copyV, hw]
      refine Res.bind_good (copy_good n hh hk hvw hm) fun Ψ1 H1 w' he1 hh1 hl1 hw' => ?_
      have hk1 : k < H1.length := by omega
      have hrow : H1[k]? = some H1[k] := List.getElem?_eq_getElem hk1
      simp only [hrow]
      obtain ⟨Ψ2, he2, hh2, hg2⟩ := hh1.alloc hrow (Ty.closed_at k _ hcl) (Ty.rb_at (Nat.lt_succ_self k) _) (m := false) hw'
      refine ⟨Ψ2, he1.trans he2, hh2, by simp; omega, ?_⟩
      exact .locR hg2 (Nat.le_refl _)
    | pair ha hb _ _ =>
      simp [Ty.mf] at hm
      simp only [copyV, Ty.at]
      refine Res.bind_good (copy_good n hh hk ha hm.1) fun Ψ1 H1 a' he1 hh1 hl1 ha' => ?_
      refine Good.ext he1 hl1 (Res.bind_good (copy_good n hh1 (by omega) (hb.mono he1) hm.2)
        fun Ψ2 H2 b' he2 hh2 hl2 hb' => ?_)
      exact ⟨Ψ2, he2, hh2, hl2, .pair (ha'.mono he2) hb'⟩
    | fnref hg hc hk1 hk2 hk3 hk4 => exact ⟨Ψ, Ext.refl _, hh, rfl, .fnref hg hc hk1 hk2 hk3 hk4⟩
    | onone => exact ⟨Ψ, Ext.refl _, hh, rfl, .onone⟩
    | osome hw _ =>
      simp [Ty.mf] at hm
      simp only [copyV, Ty.at]
      refine Res.bind_good (copy_good n hh hk hw hm) fun Ψ1 H1 w' he1 hh1 hl1 hw' => ?_
      exact ⟨Ψ1, he1, hh1, hl1, .osome hw'⟩
    | @fold v r b _ ih =>
      simp [Ty.mf] at hm
      have := ih (Ty.mf_unf hm)
      rw [Ty.unf_at] at this
      exact Good.vt (fun _ _ hv => .fold hv) this

/-! ## 実行の座標の補題 -/

@[simp] theorem Inst.ty_int (I : Inst) : I.ty .int = .int := rfl
@[simp] theorem Inst.ty_iref (I : Inst) (r : Nat) (t : Ty) :
    I.ty (.iref r t) = .iref (rmap I.a I.δ r) (I.ty t) := rfl
@[simp] theorem Inst.ty_prod (I : Inst) (a b : Ty) : I.ty (.prod a b) = .prod (I.ty a) (I.ty b) := rfl
@[simp] theorem Inst.ty_box (I : Inst) (m : Bool) (r : Nat) (t : Ty) :
    I.ty (.box m r t) = .box m (rmap I.a I.δ r) (I.ty t) := rfl
theorem Inst.ty_fn (I : Inst) (p q : Ty) :
    I.ty (.fn p q) = .fn (p.tsubst (I.σ.map (Ty.at 0))) (q.tsubst (I.σ.map (Ty.at 0))) := rfl
@[simp] theorem Inst.ty_opt (I : Inst) (t : Ty) : I.ty (.opt t) = .opt (I.ty t) := rfl
theorem Inst.ty_mu (I : Inst) (r : Nat) (b : Ty) :
    I.ty (.mu r b) = .mu (rmap I.a I.δ r) (b.tsubst (I.σ.map (Ty.at 0))) := rfl

theorem Inst.ty_at (I : Inst) (k : Nat) (t : Ty) : I.ty (t.at k) = (I.ty t).at (I.reg k) := by
  simp only [Inst.ty, Inst.reg]; rw [Ty.ren_at, Ty.at_tsubst]

theorem InstOk.closed {κ : List Kind} {I : Inst} (hI : InstOk κ I) (t : Ty) : (I.ty t).closed = true :=
  Ty.closed_tsubst _ _ hI.2.1

/-- 展開を実行の座標へ写すのは、写した再帰型の展開と同じ -/
theorem InstOk.unf {κ : List Kind} {I : Inst} (hI : InstOk κ I) (r : Nat) (b : Ty) :
    I.ty (Ty.unf r b) = Ty.unf (rmap I.a I.δ r) (b.tsubst (I.σ.map (Ty.at 0))) := by
  simp only [Inst.ty]; rw [Ty.unf_ren, Ty.unf_tsubst hI.2.2.2.2.2.1]

theorem InstOk.rb0 {κ : List Kind} {I : Inst} (hI : InstOk κ I) {D : Nat} (hD : 2 ≤ D) {t : Ty} (ht : t.rb D = true) :
    (I.ty t).rb (D + I.δ) = true :=
  Ty.rb_tsubst _ _ (Ty.rb_ren (by have := hI.1; omega) t ht)
    (fun s hs => Ty.rb_mono (by omega) s (hI.2.2.1 s hs))

theorem InstOk.mf {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t : Ty} (ht : t.mf κ = true) : (I.ty t).mf [] = true :=
  Ty.mf_tsubst _ _ (by rw [Ty.mf_ren]; exact ht) hI.2.2.2.1

theorem InstOk.sub0 {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t t' : Ty} (h : Ty.sub0 κ 1 t t' = true) :
    csub (I.ty t) (I.ty t') = true :=
  Ty.sub_tsubst (L := 1 + I.δ) hI.2.1 (fun s hs => by have := hI.2.2.1 s hs; rwa [show 1 + I.δ + 1 = 2 + I.δ by omega])
    hI.2.2.2.2.2.2 hI.2.2.2.2.1 hI.2.2.2.2.2.1 (Ty.sub_ren hI.1 h)

/-- 正規化は、region を持たない型引数での代入の前後で同じ -/
theorem Ty.N_tsubst {κ : List Kind} : ∀ (t : Ty) (σ : List Ty),
    (∀ i, kindRF κ i = true → (look σ i).closed = true ∧ (look σ i).rfK [] = true) →
    (t.N κ).tsubst σ = t.tsubst σ
  | .int, _, _ => rfl
  | .tvar i, σ, h => by
    unfold Ty.N; split
    · rename_i hr; obtain ⟨hc, hf⟩ := h i hr; simp [Ty.tsubst, Ty.at_rfree 0 _ hc hf]
    · rfl
  | .tat i ρ, σ, h => by
    unfold Ty.N; split
    · rename_i hr; obtain ⟨hc, hf⟩ := h i hr; simp [Ty.tsubst, Ty.at_rfree _ _ hc hf]
    · rfl
  | .box m r t, σ, h => by simp [Ty.N, Ty.tsubst, Ty.N_tsubst t σ h]
  | .iref r t, σ, h => by simp [Ty.N, Ty.tsubst, Ty.N_tsubst t σ h]
  | .prod x y, σ, h => by simp [Ty.N, Ty.tsubst, Ty.N_tsubst x σ h, Ty.N_tsubst y σ h]
  | .fn p q, σ, h => by
    have h' : ∀ i, kindRF κ i = true → (look (σ.map (Ty.at 0)) i).closed = true ∧ (look (σ.map (Ty.at 0)) i).rfK [] = true := by
      intro i hi; rw [look_map (Ty.at 0) rfl]; obtain ⟨hc, hf⟩ := h i hi
      exact ⟨Ty.closed_at 0 _ hc, by rw [Ty.rfK_at]; exact hf⟩
    simp [Ty.N, Ty.tsubst, Ty.N_tsubst p _ h', Ty.N_tsubst q _ h']
  | .opt t, σ, h => by simp [Ty.N, Ty.tsubst, Ty.N_tsubst t σ h]
  | .rvar _, _, _ => rfl
  | .mu r b, σ, h => by
    have h' : ∀ i, kindRF κ i = true → (look (σ.map (Ty.at 0)) i).closed = true ∧ (look (σ.map (Ty.at 0)) i).rfK [] = true := by
      intro i hi; rw [look_map (Ty.at 0) rfl]; obtain ⟨hc, hf⟩ := h i hi
      exact ⟨Ty.closed_at 0 _ hc, by rw [Ty.rfK_at]; exact hf⟩
    simp [Ty.N, Ty.tsubst, Ty.N_tsubst b _ h']

theorem InstOk.rfσ {κ : List Kind} {I : Inst} (hI : InstOk κ I) :
    ∀ i, kindRF κ i = true → (look I.σ i).closed = true ∧ (look I.σ i).rfK [] = true :=
  fun i hi => ⟨look_closed hI.2.1 i, hI.2.2.2.2.1 i hi⟩

theorem InstOk.N {κ : List Kind} {I : Inst} (hI : InstOk κ I) : ∀ t : Ty, I.ty (t.N κ) = I.ty t
  | .int => rfl
  | .tvar i => by
    unfold Ty.N; split
    · rename_i hr; obtain ⟨hc, hf⟩ := hI.rfσ i hr
      simp [Inst.ty, Ty.ren, Ty.tsubst, Ty.at_rfree _ _ hc hf]
    · rfl
  | .tat i ρ => by
    unfold Ty.N; split
    · rename_i hr; obtain ⟨hc, hf⟩ := hI.rfσ i hr
      simp [Inst.ty, Ty.ren, Ty.tsubst, Ty.at_rfree _ _ hc hf]
    · rfl
  | .box m r t => by simp [Ty.N, hI.N t]
  | .iref r t => by simp [Ty.N, hI.N t]
  | .prod x y => by simp [Ty.N, hI.N x, hI.N y]
  | .fn p q => by
    have h' : ∀ i, kindRF κ i = true → (look (I.σ.map (Ty.at 0)) i).closed = true ∧ (look (I.σ.map (Ty.at 0)) i).rfK [] = true := by
      intro i hi; rw [look_map (Ty.at 0) rfl]; obtain ⟨hc, hf⟩ := hI.rfσ i hi
      exact ⟨Ty.closed_at 0 _ hc, by rw [Ty.rfK_at]; exact hf⟩
    simp only [Inst.ty_fn, Ty.N, Ty.N_tsubst p _ h', Ty.N_tsubst q _ h']
  | .opt t => by simp [Ty.N, hI.N t]
  | .rvar _ => rfl
  | .mu r b => by
    have h' : ∀ i, kindRF κ i = true → (look (I.σ.map (Ty.at 0)) i).closed = true ∧ (look (I.σ.map (Ty.at 0)) i).rfK [] = true := by
      intro i hi; rw [look_map (Ty.at 0) rfl]; obtain ⟨hc, hf⟩ := hI.rfσ i hi
      exact ⟨Ty.closed_at 0 _ hc, by rw [Ty.rfK_at]; exact hf⟩
    simp only [Inst.ty_mu, Ty.N, Ty.N_tsubst b _ h']

theorem InstOk.rb {κ : List Kind} {I : Inst} (hI : InstOk κ I) {D : Nat} (hD : 2 ≤ D) {t : Ty} (ht : (t.N κ).rb D = true) :
    (I.ty t).rb (D + I.δ) = true := by
  rw [← hI.N t]; exact hI.rb0 hD ht

theorem InstOk.sub {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t t' : Ty} (h : Ty.sub κ 1 t t' = true) :
    csub (I.ty t) (I.ty t') = true := by
  rw [← hI.N t, ← hI.N t']; exact hI.sub0 h

theorem InstOk.rc {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t : Ty} (ht : t.rc 0 = true) : (I.ty t).rc 0 = true := by
  simp only [Inst.ty]; rw [Ty.rc_tsubst _ _ _ hI.2.2.2.2.2.1, Ty.rc_ren]; exact ht

theorem InstOk.rfK {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t : Ty} (ht : t.rfK κ = true) : (I.ty t).rfK [] = true :=
  Ty.rfK_tsubst _ _ (by rw [Ty.rfK_ren]; exact ht) hI.2.2.2.2.1

theorem InstOk.cv {κ : List Kind} {I : Inst} (hI : InstOk κ I) {t : Ty} (ht : t.cv κ = true) : (I.ty t).cv [] = true :=
  Ty.cv_tsubst _ _ (by rw [Ty.cv_ren]; exact ht) hI.2.2.2.2.2.2 hI.2.2.2.2.1 hI.2.2.2.2.2.1

theorem look_map_ty (I : Inst) (ts : List Ty) (i : Nat) : look (ts.map I.ty) i = I.ty (look ts i) :=
  look_map I.ty rfl ts i

/-- 直接の呼び出し: 呼び手の座標で型引数を代入した型を実行の座標へ写すのは、呼ばれた側の座標（anchor の写し・型引数の写し）で読むのと同じ -/
theorem Inst.call_eq (I : Inst) {D a : Nat} (hD : 2 ≤ D) (ts : List Ty) (p : Ty) :
    I.ty ((p.ren a (D - 2)).tsubst ts) = Inst.ty ⟨I.reg a, D + I.δ - 2, ts.map I.ty⟩ p := by
  simp only [Inst.ty, Inst.reg]
  rw [Ty.ren_tsubst, Ty.tsubst_comp, Ty.ren_ren, List.map_map]
  have : D - 2 + I.δ = D + I.δ - 2 := by omega
  rw [this]
  rfl

/-- 関数値: 型引数を region 0 へ置き直した Def のシグネチャを実行の座標へ写す -/
theorem Inst.fnref_eq (I : Inst) (ts : List Ty) (p q : Ty) :
    I.ty ((Ty.fn p q).tsubst ts) = (Ty.fn p q).tsubst (ts.map I.ty) := by
  simp only [Inst.ty, Ty.tsubst, Ty.ren, Ty.tsubst_comp, List.map_map]
  congr 2 <;> (congr 1; funext s; simp [Ty.at_tsubst, Ty.tsubst_at_map, Inst.ty, Ty.at_tsubst_ren])

/-- 関数値の呼び出し: 値の型（Defのシグネチャを型引数の置き直しで読んだもの）と、呼び手の関数型が一致すれば、
呼ばれた側の座標（型引数を anchor へ置き直したもの）で読む型は、呼び手の型を写した型と同じ -/
theorem Ty.lowTv_noTv : ∀ t : Ty, t.lowTv.noTv = true
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box _ _ t => by simp [Ty.lowTv, Ty.noTv, Ty.lowTv_noTv t]
  | .iref _ t => by simp [Ty.lowTv, Ty.noTv, Ty.lowTv_noTv t]
  | .prod x y => by simp [Ty.lowTv, Ty.noTv, Ty.lowTv_noTv x, Ty.lowTv_noTv y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.lowTv, Ty.noTv, Ty.lowTv_noTv t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

/-- 関数型の中の読み方（型変数を region 0 へ置き直して代入する）では、素の T と T@0 は同じ -/
theorem Ty.lowTv_tsubst0 : ∀ (t : Ty) (σ : List Ty), t.lowTv.tsubst (σ.map (Ty.at 0)) = t.tsubst (σ.map (Ty.at 0))
  | .int, _ => rfl
  | .tvar i, σ => by simp [Ty.lowTv, Ty.tsubst, look_map (Ty.at 0) rfl, Ty.at_at]
  | .tat _ _, _ => rfl
  | .box m r t, σ => by simp [Ty.lowTv, Ty.tsubst, Ty.lowTv_tsubst0 t σ]
  | .iref r t, σ => by simp [Ty.lowTv, Ty.tsubst, Ty.lowTv_tsubst0 t σ]
  | .prod x y, σ => by simp [Ty.lowTv, Ty.tsubst, Ty.lowTv_tsubst0 x σ, Ty.lowTv_tsubst0 y σ]
  | .fn _ _, _ => rfl
  | .opt t, σ => by simp [Ty.lowTv, Ty.tsubst, Ty.lowTv_tsubst0 t σ]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Inst.callv_eq (I : Inst) {D a : Nat} (hD : 2 ≤ D) {ts' : List Ty} {dp p : Ty}
    (heq : dp.tsubst (ts'.map (Ty.at 0)) = p.tsubst (I.σ.map (Ty.at 0))) :
    Inst.ty ⟨I.reg a, D + I.δ - 2, ts'.map (Ty.at (I.reg a))⟩ dp = I.ty (p.lowTv.ren a (D - 2)) := by
  have hm : ∀ (σ : List Ty) (a' δ' : Nat), (σ.map (Ty.at 0)).map (Ty.ren a' δ') = σ.map (Ty.at a') := by
    intro σ a' δ'; simp [Function.comp_def, Ty.ren_at, Ty.at_ren, rmap]
  simp only [Inst.ty, Inst.reg]
  rw [← hm ts' _ (D + I.δ - 2), ← Ty.ren_tsubst, heq, ← Ty.lowTv_tsubst0, Ty.ren_tsubst, hm,
    Ty.tsubst_noTv _ _ _ (by rw [Ty.noTv_ren]; exact Ty.lowTv_noTv p), Ty.ren_ren]
  have : D - 2 + I.δ = D + I.δ - 2 := by omega
  rw [this]

/-! ## 値の型の反転 -/

theorem VT.inv_prod {Δ : List Def} {Ψ : StTy} {v : Val} {a b : Ty} (h : VT Δ Ψ v (.prod a b)) :
    ∃ va vb, v = .pair va vb ∧ VT Δ Ψ va a ∧ VT Δ Ψ vb b := by
  generalize ht : Ty.prod a b = T at h
  cases h with
  | pair ha hb => cases ht; exact ⟨_, _, rfl, ha, hb⟩
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

theorem VT.inv_boxM {Δ : List Def} {Ψ : StTy} {v : Val} {r : Nat} {t : Ty} (h : VT Δ Ψ v (.box true r t)) :
    ∃ x, v = .loc r x ∧ hget Ψ r x = some (true, t) := by
  generalize ht : Ty.box true r t = T at h
  cases h with
  | locM h => cases ht; exact ⟨_, rfl, h⟩
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

theorem VT.inv_iref {Δ : List Def} {Ψ : StTy} {v : Val} {r' : Nat} {t : Ty} (h : VT Δ Ψ v (.iref r' t)) :
    ∃ r x m, v = .loc r x ∧ hget Ψ r x = some (m, t) := by
  generalize ht : Ty.iref r' t = T at h
  cases h with
  | locR h _ => cases ht; exact ⟨_, _, _, rfl, h⟩
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

theorem VT.inv_box {Δ : List Def} {Ψ : StTy} {v : Val} {m : Bool} {r' : Nat} {t : Ty} (h : VT Δ Ψ v (.box m r' t)) :
    ∃ r x m' tc, v = .loc r x ∧ hget Ψ r x = some (m', tc) ∧ R3C.csub tc t = true := by
  generalize ht : Ty.box m r' t = T at h
  cases h with
  | locM h => cases ht; exact ⟨_, _, _, _, rfl, h, Ty.sub_refl _ _ _⟩
  | locI h _ hs => cases ht; exact ⟨_, _, _, _, rfl, h, hs⟩
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

theorem VT.inv_fn {Δ : List Def} {Ψ : StTy} {v : Val} {P Q : Ty} (h : VT Δ Ψ v (.fn P Q)) :
    ∃ g ts dfn, v = .fnref g ts ∧ Δ[g]? = some dfn ∧ (∀ s ∈ ts, s.closed = true) ∧
      (∀ i, kindMut dfn.κ i = false → (look ts i).mf [] = true) ∧
      (∀ i, kindRF dfn.κ i = true → (look ts i).rfK [] = true) ∧ (∀ s ∈ ts, s.rc 0 = true) ∧
      (∀ i, kindCov dfn.κ i = true → (look ts i).cv [] = true) ∧
      dfn.p.tsubst (ts.map (Ty.at 0)) = P ∧ dfn.q.tsubst (ts.map (Ty.at 0)) = Q := by
  generalize ht : Ty.fn P Q = T at h
  cases h with
  | fnref hg hc hk hk2 hk3 hk4 =>
    simp [Ty.tsubst] at ht; obtain ⟨rfl, rfl⟩ := ht; exact ⟨_, _, _, rfl, hg, hc, hk, hk2, hk3, hk4, rfl, rfl⟩
  | _ => cases ht

theorem VT.inv_opt {Δ : List Def} {Ψ : StTy} {v : Val} {t : Ty} (h : VT Δ Ψ v (.opt t)) :
    v = .onone ∨ ∃ w, v = .osome w ∧ VT Δ Ψ w t := by
  generalize ht : Ty.opt t = T at h
  cases h with
  | onone => exact .inl rfl
  | osome hw => cases ht; exact .inr ⟨_, rfl, hw⟩
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

theorem VT.inv_mu {Δ : List Def} {Ψ : StTy} {v : Val} {r : Nat} {b : Ty} (h : VT Δ Ψ v (.mu r b)) :
    VT Δ Ψ v (Ty.unf r b) := by
  generalize ht : Ty.mu r b = T at h
  cases h with
  | fold hw => cases ht; exact hw
  | fnref => simp [Ty.tsubst] at ht
  | _ => cases ht

/-! ## 健全性: 型付く項の評価は err にならない（ぶら下がりの読み書きが起きない）。値は結果の型に型付く -/

theorem reg_le {I : Inst} {a D : Nat} (hD : 2 ≤ D) (hI : I.a ≤ 1 + I.δ) (ha : a + 1 ≤ D) : I.reg a ≤ 1 + (D + I.δ - 2) := by
  unfold Inst.reg; cases a with
  | zero => simp [rmap]; omega
  | succ k => simp [rmap]; omega

theorem sound {Δ : List Def} (hΔ : DefsOk Δ) : ∀ (n : Nat) {κ : List Kind} {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty},
    HasType Δ κ D Γ e t → ∀ (I : Inst) (Ψ : StTy) (H : Heap) (env : List Val), 2 ≤ D → InstOk κ I →
    H.length = D + I.δ → HeapOk Δ Ψ H → EnvOk Δ Ψ env (Γ.map I.ty) → Good Δ Ψ H (I.ty t) (eval n Δ I H env e)
  | 0, _, _, _, _, _, _ => by intros; simp [eval, Good]
  | n + 1, κ, D, Γ, e, t, h => by
    induction h with
    | @var D Γ i t hi =>
      intro I Ψ H env hD hI hH hh henv
      have hlt : i < Γ.length := by
        rcases Nat.lt_or_ge i Γ.length with h | h
        · exact h
        · rw [List.getElem?_eq_none h] at hi; cases hi
      have hlt' : i < env.length := by rw [henv.1, List.length_map]; exact hlt
      have he : env[i]? = some env[i] := List.getElem?_eq_getElem hlt'
      simp only [eval, he]
      exact ⟨Ψ, Ext.refl _, hh, rfl, henv.2 i _ _ he (by simp [hi])⟩
    | lit =>
      intro I Ψ H env hD hI hH hh henv
      exact ⟨Ψ, Ext.refl _, hh, rfl, .lit⟩
    | @pair D Γ a b ta tb ha hb _ _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval, Inst.ty_prod]
      refine Res.bind_good (sound hΔ n ha I Ψ H env hD hI hH hh henv) fun Ψ1 H1 va he1 hh1 hl1 hva => ?_
      refine Good.ext he1 hl1 (Res.bind_good (sound hΔ n hb I Ψ1 H1 env hD hI (by omega) hh1 (henv.mono he1))
        fun Ψ2 H2 vb he2 hh2 hl2 hvb => ?_)
      exact ⟨Ψ2, he2, hh2, hl2, .pair (hva.mono he2) hvb⟩
    | @fst D Γ e ta tb he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_prod] at hv
      obtain ⟨va, vb, rfl, hva, -⟩ := hv.inv_prod
      exact ⟨Ψ1, he1, hh1, hl1, hva⟩
    | @snd D Γ e ta tb he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_prod] at hv
      obtain ⟨va, vb, rfl, -, hvb⟩ := hv.inv_prod
      exact ⟨Ψ1, he1, hh1, hl1, hvb⟩
    | @letE D Γ e b t1 t2 he hb _ _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      exact Good.ext he1 hl1 (sound hΔ n hb I Ψ1 H1 (v :: env) hD hI (by omega) hh1 ((henv.mono he1).cons hv))
    | @sub D Γ e t t' _ hs ih =>
      intro I Ψ H env hD hI hH hh henv
      exact Good.csub (hI.sub hs) (ih I Ψ H env hD hI hH hh henv)
    | @alloc D Γ m e t he hrb _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval, Inst.ty_box]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      have hk : H1.length - 1 < H1.length := by omega
      have hrow : H1[H1.length - 1]? = some H1[H1.length - 1] := List.getElem?_eq_getElem hk
      simp only [hrow]
      have hrm : rmap I.a I.δ (D - 1) = H1.length - 1 := by
        obtain ⟨k, hk'⟩ : ∃ k, D - 1 = k + 1 := ⟨D - 2, by omega⟩
        rw [hk']; simp [rmap]; omega
      have hrb' : (I.ty t).rb (H1.length - 1 + 1) = true := by
        rw [show H1.length - 1 + 1 = D + I.δ by omega]; exact hI.rb hD hrb
      obtain ⟨Ψ2, he2, hh2, hg2⟩ := hh1.alloc hrow (hI.closed t) hrb' (m := m) hv
      refine ⟨Ψ2, he1.trans he2, hh2, by simp; omega, ?_⟩
      rw [hrm]
      cases m
      · exact .locI hg2 (Nat.le_refl _) (Ty.sub_refl _ _ _)
      · exact .locM hg2
    | @read D Γ e m r t he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_box] at hv
      obtain ⟨r0, x, m', tc, rfl, hg, hs⟩ := hv.inv_box
      obtain ⟨w, hw, hvw⟩ := hh1.get hg
      simp only [hw]
      exact ⟨Ψ1, he1, hh1, hl1, hvw.csub hs⟩
    | @readR D Γ e r t he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_iref] at hv
      obtain ⟨r0, x, m', rfl, hg⟩ := hv.inv_iref
      obtain ⟨w, hw, hvw⟩ := hh1.get hg
      simp only [hw]
      exact ⟨Ψ1, he1, hh1, hl1, hvw⟩
    | @view D Γ e r t he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Good.vt (fun _ _ hv => ?_) (sound hΔ n he I Ψ H env hD hI hH hh henv)
      rw [Inst.ty_box] at hv; rw [Inst.ty_iref]
      obtain ⟨x, rfl, hg⟩ := hv.inv_boxM
      exact .locR hg (Nat.le_refl _)
    | @write D Γ e v r t he hv _ _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 l he1 hh1 hl1 hl => ?_
      refine Good.ext he1 hl1 (Res.bind_good (sound hΔ n hv I Ψ1 H1 env hD hI (by omega) hh1 (henv.mono he1))
        fun Ψ2 H2 w he2 hh2 hl2 hw => ?_)
      rw [Inst.ty_box] at hl
      obtain ⟨x, rfl, hg⟩ := hl.inv_boxM
      have hg2 := he2.get hg
      obtain ⟨c, hc, -⟩ := hh2.get hg2
      unfold hget at hc
      cases hrow : H2[rmap I.a I.δ r]? with
      | none => rw [hrow] at hc; cases hc
      | some row =>
        rw [hrow] at hc
        have hx : x < row.length := by
          rcases Nat.lt_or_ge x row.length with h' | h'
          · exact h'
          · simp at hc; rw [List.getElem?_eq_none h'] at hc; cases hc
        simp only [hrow, if_pos hx]
        exact ⟨Ψ2, he2, hh2.write hg2 hrow hw, by simp; omega, .lit⟩
    | @block D Γ e t he hrb _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      obtain ⟨he0, hh0⟩ := hh.push
      have ih := sound hΔ n he I (Ψ ++ [[]]) (H ++ [[]]) env (by omega) hI (by simp; omega) hh0 (henv.mono he0)
      cases hr : eval n Δ I (H ++ [[]]) env e with
      | ok H1 v =>
        rw [hr] at ih
        obtain ⟨Ψ1, he1, hh1, hl1, hv⟩ := ih
        have hΨ : Ψ.length = H.length := hh.1.symm
        obtain ⟨he2, hh2⟩ := HeapOk.pop hΨ he1 hh1 (by simpa using hl1)
        refine ⟨Ψ1.take H.length, he2, hh2, by rw [List.length_take]; simp at hl1; omega, hv.take ?_⟩
        rw [hH]; exact hI.rb hD hrb
      | timeout => trivial
      | err => rw [hr] at ih; cases ih
    | @call D Γ g ts a e dfn hg hargs ha he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      simp only [hg]
      have hδ : H1.length - 2 = D + I.δ - 2 := by omega
      rw [hδ]
      have hI' : InstOk dfn.κ ⟨I.reg a, D + I.δ - 2, ts.map I.ty⟩ := by
        refine ⟨reg_le hD hI.1 ha, ?_, ?_, ?_, ?_, ?_, ?_⟩
        · intro s hs; obtain ⟨s0, -, rfl⟩ := List.mem_map.mp hs; exact hI.closed s0
        · intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs
          rw [show 2 + (D + I.δ - 2) = D + I.δ by omega]; exact hI.rb hD (hargs.1 s0 hs0)
        · intro i hk; simp only [look_map_ty]; exact hI.mf (hargs.2.1 i hk)
        · intro i hk; simp only [look_map_ty]; exact hI.rfK (hargs.2.2.1 i hk)
        · intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact hI.rc (hargs.2.2.2.1 s0 hs0)
        · intro i hk; simp only [look_map_ty]; exact hI.cv (hargs.2.2.2.2 i hk)
      have henv' : EnvOk Δ Ψ1 [v] ([dfn.p].map (Inst.ty ⟨I.reg a, D + I.δ - 2, ts.map I.ty⟩)) := by
        refine ⟨rfl, fun i w s h1 h2 => ?_⟩
        cases i with
        | zero => simp at h1 h2; subst h1; subst h2; rw [← Inst.call_eq I hD]; exact hv
        | succ => simp at h1
      have ih := sound hΔ n (hΔ g dfn hg) _ Ψ1 H1 [v] (Nat.le_refl 2) hI' (by simp; omega) hh1 henv'
      rw [← Inst.call_eq I hD] at ih
      exact Good.ext he1 hl1 ih
    | @fnref D Γ g ts dfn hg hargs =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine ⟨Ψ, Ext.refl _, hh, rfl, ?_⟩
      rw [Inst.fnref_eq]
      refine .fnref hg ?_ ?_ ?_ ?_ ?_
      · intro s hs; obtain ⟨s0, -, rfl⟩ := List.mem_map.mp hs; exact hI.closed s0
      · intro i hk; simp only [look_map_ty]; exact hI.mf (hargs.2.1 i hk)
      · intro i hk; simp only [look_map_ty]; exact hI.rfK (hargs.2.2.1 i hk)
      · intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact hI.rc (hargs.2.2.2.1 s0 hs0)
      · intro i hk; simp only [look_map_ty]; exact hI.cv (hargs.2.2.2.2 i hk)
    | @callv D Γ a ef e p q hf ha he _ _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n hf I Ψ H env hD hI hH hh henv) fun Ψ1 H1 fv he1 hh1 hl1 hfv => ?_
      refine Good.ext he1 hl1 (Res.bind_good (sound hΔ n he I Ψ1 H1 env hD hI (by omega) hh1 (henv.mono he1))
        fun Ψ2 H2 v he2 hh2 hl2 hv => ?_)
      rw [Inst.ty_fn] at hfv
      obtain ⟨g, ts', dfn, rfl, hg, hc, hk, hk2, hk3, hk4, hP, hQ⟩ := hfv.inv_fn
      simp only [hg]
      have hδ : H2.length - 2 = D + I.δ - 2 := by omega
      rw [hδ]
      have hI' : InstOk dfn.κ ⟨I.reg a, D + I.δ - 2, ts'.map (Ty.at (I.reg a))⟩ := by
        have hreg := reg_le hD hI.1 ha
        refine ⟨hreg, ?_, ?_, ?_, ?_, ?_, ?_⟩
        · intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at _ s0 (hc s0 hs0)
        · intro s hs; obtain ⟨s0, -, rfl⟩ := List.mem_map.mp hs; exact Ty.rb_at (show I.reg a < 2 + (D + I.δ - 2) by omega) s0
        · intro i hki; simp only [look_map (Ty.at (I.reg a)) rfl, Ty.mf_at]; exact hk i hki
        · intro i hki; simp only [look_map (Ty.at (I.reg a)) rfl, Ty.rfK_at]; exact hk2 i hki
        · intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; rw [Ty.rc_at]; exact hk3 s0 hs0
        · intro i hki; simp only [look_map (Ty.at (I.reg a)) rfl, Ty.cv_at]; exact hk4 i hki
      have henv' : EnvOk Δ Ψ2 [v] ([dfn.p].map (Inst.ty ⟨I.reg a, D + I.δ - 2, ts'.map (Ty.at (I.reg a))⟩)) := by
        refine ⟨rfl, fun i w s h1 h2 => ?_⟩
        cases i with
        | zero => simp at h1 h2; subst h1; subst h2; rw [Inst.callv_eq I hD hP]; exact hv
        | succ => simp at h1
      have ih := sound hΔ n (hΔ g dfn hg) _ Ψ2 H2 [v] (Nat.le_refl 2) hI' (by simp; omega) hh2 henv'
      rw [Inst.callv_eq I hD hQ] at ih
      exact Good.ext he2 hl2 ih
    | onone =>
      intro I Ψ H env hD hI hH hh henv
      exact ⟨Ψ, Ext.refl _, hh, rfl, .onone⟩
    | @osome D Γ e t he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval, Inst.ty_opt]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      exact ⟨Ψ1, he1, hh1, hl1, .osome hv⟩
    | @case D Γ t e e1 e2 a he h1 h2 _ _ _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_opt] at hv
      rcases hv.inv_opt with rfl | ⟨w, rfl, hw⟩
      · exact Good.ext he1 hl1 (sound hΔ n h1 I Ψ1 H1 env hD hI (by omega) hh1 (henv.mono he1))
      · exact Good.ext he1 hl1 (sound hΔ n h2 I Ψ1 H1 (w :: env) hD hI (by omega) hh1 ((henv.mono he1).cons hw))
    | @fold D Γ r b e he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Good.vt (fun _ _ hv => ?_) (sound hΔ n he I Ψ H env hD hI hH hh henv)
      rw [hI.unf] at hv; rw [Inst.ty_mu]; exact .fold hv
    | @unfold D Γ r b e he _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Good.vt (fun _ _ hv => ?_) (sound hΔ n he I Ψ H env hD hI hH hh henv)
      rw [Inst.ty_mu] at hv; rw [hI.unf]; exact hv.inv_mu
    | @copy D Γ k e t he hm hk _ =>
      intro I Ψ H env hD hI hH hh henv
      simp only [eval]
      refine Res.bind_good (sound hΔ n he I Ψ H env hD hI hH hh henv) fun Ψ1 H1 v he1 hh1 hl1 hv => ?_
      rw [Inst.ty_at]
      exact Good.ext he1 hl1 (copy_good n hh1 (by have := reg_le hD hI.1 hk; omega) hv (hI.mf hm))

theorem Ty.subN_refl (κ : List Kind) (L : Nat) (t : Ty) : Ty.sub κ L t t = true := Ty.sub_refl _ _ _

theorem Ty.subN_trans {κ : List Kind} {L : Nat} {a b c : Ty} (h1 : Ty.sub κ L a b = true) (h2 : Ty.sub κ L b c = true) :
    Ty.sub κ L a c = true := Ty.sub_trans (b := b.N κ) h1 h2

theorem Ty.N_id {κ : List Kind} (h : ∀ i, kindRF κ i = false) : ∀ t : Ty, t.N κ = t
  | .int => rfl
  | .tvar i => by simp [Ty.N, h i]
  | .tat i ρ => by simp [Ty.N, h i]
  | .box m r t => by simp [Ty.N, Ty.N_id h t]
  | .iref r t => by simp [Ty.N, Ty.N_id h t]
  | .prod x y => by simp [Ty.N, Ty.N_id h x, Ty.N_id h y]
  | .fn p q => by simp [Ty.N, Ty.N_id h p, Ty.N_id h q]
  | .opt t => by simp [Ty.N, Ty.N_id h t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.N_id h b]

/-- region を持たない kind が無ければ、部分型は正規化なしの部分型 -/
theorem Ty.sub_noRF {κ : List Kind} (h : ∀ i, kindRF κ i = false) (L : Nat) (t t' : Ty) :
    Ty.sub κ L t t' = Ty.sub0 κ L t t' := by
  simp [Ty.sub, Ty.N_id h]

theorem Ty.N_noTv (κ : List Kind) : ∀ t : Ty, t.noTv = true → (t.N κ).noTv = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.noTv] at h
  | .tat i ρ, _ => by unfold Ty.N; split <;> rfl
  | .box m r t, h => by simp [Ty.noTv] at h; simp [Ty.N, Ty.noTv, Ty.N_noTv κ t h]
  | .iref r t, h => by simp [Ty.noTv] at h; simp [Ty.N, Ty.noTv, Ty.N_noTv κ t h]
  | .prod x y, h => by simp [Ty.noTv] at h; simp [Ty.N, Ty.noTv, Ty.N_noTv κ x h.1, Ty.N_noTv κ y h.2]
  | .fn p q, _ => rfl
  | .opt t, h => by simp [Ty.noTv] at h; simp [Ty.N, Ty.noTv, Ty.N_noTv κ t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem kindRF_C (i : Nat) : kindRF [.C] i = false := by
  cases i <;> simp [kindRF, kindOf, Kind.C, Kind.O]

theorem kindRF_O (i : Nat) : kindRF [.O] i = false := by
  cases i <;> simp [kindRF, kindOf, Kind.O]

/-! ## 型付けの反転（例の「型付かない」を示すため） -/

section Inv
variable {Δ : List Def} {κ : List Kind}

theorem HasType.inv_var {D : Nat} {Γ : List Ty} {i : Nat} {t : Ty} (h : HasType Δ κ D Γ (.var i) t) :
    ∃ t0, Γ[i]? = some t0 ∧ Ty.sub κ 1 t0 t = true := by
  generalize hE : Expr.var i = E at h
  induction h with
  | var hi => cases hE; exact ⟨_, hi, Ty.subN_refl _ _ _⟩
  | sub _ hs ih => obtain ⟨t0, h0, h1⟩ := ih hE; exact ⟨t0, h0, Ty.subN_trans h1 hs⟩
  | _ => cases hE

theorem HasType.inv_fst {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty} (h : HasType Δ κ D Γ (.fst e) t) :
    ∃ ta tb, HasType Δ κ D Γ e (.prod ta tb) ∧ Ty.sub κ 1 ta t = true := by
  generalize hE : Expr.fst e = E at h
  induction h with
  | fst h _ => cases hE; exact ⟨_, _, h, Ty.subN_refl _ _ _⟩
  | sub _ hs ih => obtain ⟨ta, tb, h0, h1⟩ := ih hE; exact ⟨ta, tb, h0, Ty.subN_trans h1 hs⟩
  | _ => cases hE

theorem HasType.inv_snd {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty} (h : HasType Δ κ D Γ (.snd e) t) :
    ∃ ta tb, HasType Δ κ D Γ e (.prod ta tb) ∧ Ty.sub κ 1 tb t = true := by
  generalize hE : Expr.snd e = E at h
  induction h with
  | snd h _ => cases hE; exact ⟨_, _, h, Ty.subN_refl _ _ _⟩
  | sub _ hs ih => obtain ⟨ta, tb, h0, h1⟩ := ih hE; exact ⟨ta, tb, h0, Ty.subN_trans h1 hs⟩
  | _ => cases hE

theorem HasType.inv_callv {D : Nat} {Γ : List Ty} {a : Nat} {ef e : Expr} {t : Ty} (h : HasType Δ κ D Γ (.callv a ef e) t) :
    ∃ p q, HasType Δ κ D Γ ef (.fn p q) ∧ Ty.sub κ 1 (q.lowTv.ren a (D - 2)) t = true := by
  generalize hE : Expr.callv a ef e = E at h
  induction h with
  | callv hf _ _ _ _ => cases hE; exact ⟨_, _, hf, Ty.subN_refl _ _ _⟩
  | sub _ hs ih => obtain ⟨p, q, h0, h1⟩ := ih hE; exact ⟨p, q, h0, Ty.subN_trans h1 hs⟩
  | _ => cases hE

theorem HasType.inv_block {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty} (h : HasType Δ κ D Γ (.block e) t) :
    ∃ t0, HasType Δ κ (D + 1) Γ e t0 ∧ (t0.N κ).rb D = true ∧ Ty.sub κ 1 t0 t = true := by
  generalize hE : Expr.block e = E at h
  induction h with
  | block h hrb _ => cases hE; exact ⟨_, h, hrb, Ty.subN_refl _ _ _⟩
  | sub _ hs ih => obtain ⟨t0, h0, hr, h1⟩ := ih hE; exact ⟨t0, h0, hr, Ty.subN_trans h1 hs⟩
  | _ => cases hE

theorem HasType.inv_write {D : Nat} {Γ : List Ty} {e v : Expr} {t : Ty} (h : HasType Δ κ D Γ (.write e v) t) :
    ∃ r t0, HasType Δ κ D Γ e (.box true r t0) ∧ HasType Δ κ D Γ v t0 := by
  generalize hE : Expr.write e v = E at h
  induction h with
  | write h1 h2 _ _ => cases hE; exact ⟨_, _, h1, h2⟩
  | sub _ _ ih => exact ih hE
  | _ => cases hE

end Inv

theorem Ty.sub_fn_l {κ : List Kind} {L : Nat} {p q t : Ty} (h : Ty.sub0 κ L (.fn p q) t = true) : t = .fn p q := by
  cases t <;> simp [Ty.sub0] at h; obtain ⟨rfl, rfl⟩ := h; rfl

theorem Ty.sub_prod_l {κ : List Kind} {L : Nat} {a b t : Ty} (h : Ty.sub0 κ L (.prod a b) t = true) :
    ∃ a' b', t = .prod a' b' ∧ Ty.sub0 κ L a a' = true ∧ Ty.sub0 κ L b b' = true := by
  cases t <;> simp [Ty.sub0] at h; exact ⟨_, _, rfl, h.1, h.2⟩

theorem Ty.sub_boxM_l {κ : List Kind} {L : Nat} {r : Nat} {a t : Ty} (h : Ty.sub0 κ L (.box true r a) t = true) :
    t = .box true r a := by
  cases t with
  | box m r' a' => cases m <;> simp [Ty.sub0] at h; obtain ⟨rfl, rfl⟩ := h; rfl
  | _ => simp [Ty.sub0] at h

theorem Ty.sub_tat_l {κ : List Kind} {L : Nat} {i ρ : Nat} {t : Ty} (h : Ty.sub0 κ L (.tat i ρ) t = true) :
    ∃ ρ', t = .tat i ρ' ∧ ρ ≤ ρ' := by
  cases t <;> simp [Ty.sub0] at h
  obtain ⟨rfl, h⟩ := h
  rcases h with rfl | ⟨-, h⟩
  · exact ⟨_, rfl, Nat.le_refl _⟩
  · exact ⟨_, rfl, h⟩

/-- 関数値の呼び出しの結果は、素の型変数（正確な T）の型を持たない（関数型の中に素の型変数は無く、部分型も作らない） -/
theorem callv_not_tvar {Δ : List Def} {κ : List Kind} {D : Nat} {Γ : List Ty} {a : Nat} {ef e : Expr} {i : Nat}
    (hk : kindRF κ i = false) (h : HasType Δ κ D Γ (.callv a ef e) (.tvar i)) : False := by
  obtain ⟨p, q, -, hs⟩ := h.inv_callv
  have hq' : ((q.lowTv.ren a (D - 2)).N κ).noTv = true := Ty.N_noTv κ _ (by rw [Ty.noTv_ren]; exact Ty.lowTv_noTv q)
  unfold Ty.sub at hs
  simp only [Ty.N, hk] at hs
  generalize (q.lowTv.ren a (D - 2)).N κ = X at hq' hs
  cases X <;> simp [Ty.sub0, Ty.noTv] at hq' hs

/-! # 例（候補2の一般化: シグネチャの T の出現ごとに、正確な T か T@ρ を選ぶ） -/

namespace Ex

/-- apply[T](f func(T) T, x T) T@1 { f(x) }: 関数型の中は T@0（仮引数）と T@1（戻り値 = 単相と同じく呼び手の最内） -/
def fT : Ty := .fn (.tat 0 0) (.tat 0 1)
def applyP : Ty := .prod fT (.tvar 0)
def applyBody : Expr := .callv 1 (.fst (.var 0)) (.snd (.var 0))

theorem apply_typed (Δ : List Def) : HasType Δ [.C] 2 [applyP] applyBody (.tat 0 1) := by
  have h := HasType.callv (Δ := Δ) (κ := [.C]) (D := 2) (Γ := [applyP]) (a := 1)
    (ef := .fst (.var 0)) (e := .snd (.var 0)) (p := .tat 0 0) (q := .tat 0 1)
    (.fst (.var rfl)) (by omega) (.sub (.snd (.var rfl)) (by decide))
  exact h

/-- f(x) の結果は T@1（フレーム = 呼び手の最内）で、戻り値の型 T@1 と一致する。正確な T では型付かない（反例の apply は拒否される） -/
theorem apply_exact_rejected (Δ : List Def) (a : Nat) :
    ¬ HasType Δ [.C] 2 [applyP] (.callv a (.fst (.var 0)) (.snd (.var 0))) (.tvar 0) :=
  fun h => callv_not_tvar (kindRF_C 0) h

/-- push[T](mut xs box T, f func(T) T, x T) { xs := f(x) }: 型付かない（書く値は正確な T でなければならず、f(x) はそうならない） -/
def pushP : Ty := .prod (.box true 0 (.tvar 0)) (.prod fT (.tvar 0))
def pushBody (a : Nat) : Expr := .write (.fst (.var 0)) (.callv a (.fst (.snd (.var 0))) (.snd (.snd (.var 0))))

theorem push_rejected (Δ : List Def) (a : Nat) (t : Ty) : ¬ HasType Δ [.C] 2 [pushP] (pushBody a) t := by
  intro h
  obtain ⟨r, t0, h1, h2⟩ := h.inv_write
  obtain ⟨ta, tb, h3, hs1⟩ := h1.inv_fst
  obtain ⟨t00, h4, hs2⟩ := h3.inv_var
  rw [Ty.sub_noRF kindRF_C] at hs1 hs2
  simp [pushP] at h4; subst h4
  obtain ⟨a', b', he, hs3, -⟩ := Ty.sub_prod_l hs2
  cases he
  have := Ty.sub_boxM_l hs3; subst this
  have := Ty.sub_boxM_l hs1; cases this
  exact callv_not_tvar (kindRF_C 0) h2

/-- 単相の push も同じ所で拒否される: f(x) の結果はフレーム（region 1）に住み、mut のセルの型（region 0）と一致しない -/
theorem push_mono_rejected : Ty.sub0 [] 1 (.box false 1 .int) (.box false 0 .int) = false := by decide

/-- 単相の apply（T = imm box int を展開した形）: 戻り値はフレーム。呼び手の深さ D・anchor a での結果の型は、
候補2の apply を同じ型引数で呼んだ結果と同じ -/
theorem apply_same_as_mono (a D c : Nat) :
    ((Ty.tat 0 1).ren a (D - 2)).tsubst [.box false c .int] = (Ty.box false 1 .int).ren a (D - 2) := by
  simp [Ty.ren, Ty.tsubst, rmap, look, Ty.at]

/-- first[T](b imm box T) T: 戻り値を正確な T で返せる（B1 の精度。単相の first は anchor へ締めた region を返す） -/
def firstBody : Expr := .read (.var 0)
theorem first_typed (Δ : List Def) : HasType Δ [.C] 2 [.box false 0 (.tvar 0)] firstBody (.tvar 0) :=
  .read (.var rfl)

/-- mut を持つ T を関数値へ渡す（確認(6)）: callm[T](f func(T@0) int, x T@0) { f@0(x) }。仮引数を T@0 にすれば、
anchor 0 の callv で型付く。kind は何も仮定しない（κ = [.O]） -/
def callmP : Ty := .prod (.fn (.tat 0 0) .int) (.tat 0 0)
def callmBody : Expr := .callv 0 (.fst (.var 0)) (.snd (.var 0))
theorem callm_typed (Δ : List Def) : HasType Δ [.O] 2 [callmP] callmBody .int :=
  .callv (p := .tat 0 0) (q := .int) (.fst (.var rfl)) (by omega) (.snd (.var rfl))

/-- 同じ本体で、仮引数を正確な T にすると型付かない形の核: mut を持ちうる T は T@0 の部分型にならない -/
theorem callm_exact_core : Ty.sub0 [.O] 1 (.tvar 0) (.tat 0 0) = false := by decide

/-- callm を T = mut box int（region a'）で呼んだ仮引数の型は、単相の callm(f func(mut box int) int, mut x box int) を anchor a' で呼んだ形と同じ -/
theorem callm_same_as_mono (a' D : Nat) :
    ((callmP.ren a' (D - 2)).tsubst [.box true a' .int]) =
      (Ty.prod (.fn (.box true 0 .int) .int) (.box true 0 .int)).ren a' (D - 2) := by
  simp [callmP, Ty.ren, Ty.tsubst, rmap, look, Ty.at]

/-! ## 確認(5)の例: block の中で関数値の結果を返す形。T = int を展開すれば型付くが、候補2では型付かない -/

/-- g[T](f func(T) T, x T) { block { f(x) } }。関数型の戻り値は単相の規約どおり T@1 -/
def gP : Ty := .prod fT (.tat 0 0)
def gBody (a : Nat) : Expr := .block (.callv a (.fst (.var 0)) (.snd (.var 0)))

theorem g_rejected (Δ : List Def) (κ : List Kind) (hκ : ∀ i, kindRF κ i = false) (a : Nat) (t : Ty) :
    ¬ HasType Δ κ 2 [gP] (gBody a) t := by
  intro h
  obtain ⟨t0, h1, hrb, -⟩ := h.inv_block
  obtain ⟨p, q, h2, hs⟩ := h1.inv_callv
  obtain ⟨ta, tb, h3, hs1⟩ := h2.inv_fst
  obtain ⟨t00, h4, hs2⟩ := h3.inv_var
  rw [Ty.sub_noRF hκ] at hs hs1 hs2
  rw [Ty.N_id hκ] at hrb
  simp [gP] at h4; subst h4
  obtain ⟨a', b', he, hs3, -⟩ := Ty.sub_prod_l hs2
  cases he
  have := Ty.sub_fn_l hs3; subst this
  have := Ty.sub_fn_l hs1; cases this
  simp only [Ty.lowTv, Ty.ren] at hs
  obtain ⟨ρ', rfl, hρ⟩ := Ty.sub_tat_l hs
  simp [rmap] at hρ; simp [Ty.rb] at hrb; omega

/-- 同じ本体を T = int で展開した形は型付く（int は region を持たないので block を出られる） -/
def gIntP : Ty := .prod (.fn .int .int) .int
theorem g_int_typed (Δ : List Def) : HasType Δ [] 2 [gIntP] (gBody 2) .int :=
  .block (.callv (p := .int) (q := .int) (.fst (.var rfl)) (by omega) (.snd (.var rfl))) rfl

/-- T の kind が「region を持たない」なら、候補2の g は型付く（block の脱出の検査は T@2 を T@0 と同じに見る） -/
theorem g_rf_typed (Δ : List Def) : HasType Δ [.R] 2 [gP] (gBody 2) (.tat 0 2) :=
  .block (.callv (p := .tat 0 0) (q := .tat 0 1) (.fst (.var rfl)) (by omega)
    (.sub (.snd (.var rfl)) (by decide))) (by decide)

end Ex

/-! # 型付けの検査器（最小の型を返す）と、規則との一致 -/

def argsOkB (κ : List Kind) (D : Nat) (κ' : List Kind) (ts : List Ty) : Bool :=
  ts.all (fun s => (s.N κ).rb D) &&
    (List.range κ'.length).all (fun i => (kindMut κ' i || (look ts i).mf κ) && (!kindRF κ' i || (look ts i).rfK κ) &&
      (!kindCov κ' i || (look ts i).cv κ)) &&
    ts.all (fun s => s.rc 0)

theorem kindOf_out {κ : List Kind} {i : Nat} (h : κ.length ≤ i) : kindOf κ i = .O := by
  simp [kindOf, List.getD_eq_getElem?_getD, List.getElem?_eq_none h]

theorem argsOkB_iff {κ : List Kind} {D : Nat} {κ' : List Kind} {ts : List Ty} :
    argsOkB κ D κ' ts = true ↔ argsOk κ D κ' ts := by
  unfold argsOkB argsOk
  simp only [Bool.and_eq_true, List.all_eq_true, List.mem_range, Bool.or_eq_true, Bool.not_eq_true']
  constructor
  · rintro ⟨⟨h1, h2⟩, h4⟩
    refine ⟨h1, fun i hk => ?_, fun i hk => ?_, h4, fun i hk => ?_⟩
    · rcases Nat.lt_or_ge i κ'.length with hi | hi
      · rcases (h2 i hi).1.1 with h | h
        · rw [hk] at h; cases h
        · exact h
      · simp [kindMut, kindOf_out hi, Kind.O] at hk
    · rcases Nat.lt_or_ge i κ'.length with hi | hi
      · rcases (h2 i hi).1.2 with h | h
        · rw [hk] at h; cases h
        · exact h
      · simp [kindRF, kindOf_out hi, Kind.O] at hk
    · rcases Nat.lt_or_ge i κ'.length with hi | hi
      · rcases (h2 i hi).2 with h | h
        · rw [hk] at h; cases h
        · exact h
      · simp [kindCov, kindOf_out hi, Kind.O] at hk
  · rintro ⟨h1, h2, h3, h4, h5⟩
    refine ⟨⟨h1, fun i _ => ⟨⟨?_, ?_⟩, ?_⟩⟩, h4⟩
    · cases hk : kindMut κ' i
      · exact .inr (h2 i hk)
      · exact .inl rfl
    · cases hk : kindRF κ' i
      · exact .inl rfl
      · exact .inr (h3 i hk)
    · cases hk : kindCov κ' i
      · exact .inl rfl
      · exact .inr (h5 i hk)

def check (Δ : List Def) (κ : List Kind) : Nat → List Ty → Expr → Option Ty
  | _, Γ, .var i => Γ[i]?
  | _, _, .lit _ => some .int
  | D, Γ, .pair a b => match check Δ κ D Γ a, check Δ κ D Γ b with
    | some ta, some tb => some (.prod ta tb)
    | _, _ => none
  | D, Γ, .fst e => match check Δ κ D Γ e with
    | some (.prod ta _) => some ta
    | _ => none
  | D, Γ, .snd e => match check Δ κ D Γ e with
    | some (.prod _ tb) => some tb
    | _ => none
  | D, Γ, .letE e b => match check Δ κ D Γ e with
    | some t1 => check Δ κ D (t1 :: Γ) b
    | none => none
  | D, Γ, .alloc m t e => match check Δ κ D Γ e with
    | some te => if Ty.sub κ 1 te t && (t.N κ).rb D then some (.box m (D - 1) t) else none
    | none => none
  | D, Γ, .read e => match check Δ κ D Γ e with
    | some (.box _ _ t) => some t
    | some (.iref _ t) => some t
    | _ => none
  | D, Γ, .write e v => match check Δ κ D Γ e, check Δ κ D Γ v with
    | some (.box true _ t), some tv => if Ty.sub κ 1 tv t then some .int else none
    | _, _ => none
  | D, Γ, .block e => match check Δ κ (D + 1) Γ e with
    | some t => if (t.N κ).rb D then some t else none
    | none => none
  | D, Γ, .call g ts a e => match Δ[g]?, check Δ κ D Γ e with
    | some dfn, some te =>
      if argsOkB κ D dfn.κ ts && decide (a + 1 ≤ D) && Ty.sub κ 1 te ((dfn.p.ren a (D - 2)).tsubst ts) then
        some ((dfn.q.ren a (D - 2)).tsubst ts) else none
    | _, _ => none
  | D, _, .fnref g ts => match Δ[g]? with
    | some dfn => if argsOkB κ D dfn.κ ts then some ((Ty.fn dfn.p dfn.q).tsubst ts) else none
    | none => none
  | D, Γ, .callv a ef e => match check Δ κ D Γ ef, check Δ κ D Γ e with
    | some (.fn p q), some te =>
      if decide (a + 1 ≤ D) && Ty.sub κ 1 te (p.lowTv.ren a (D - 2)) then some (q.lowTv.ren a (D - 2)) else none
    | _, _ => none
  | _, _, .onone t => some (.opt t)
  | D, Γ, .osome e => match check Δ κ D Γ e with
    | some t => some (.opt t)
    | none => none
  | D, Γ, .case t e e1 e2 => match check Δ κ D Γ e with
    | some (.opt a) => match check Δ κ D Γ e1, check Δ κ D (a :: Γ) e2 with
      | some t1, some t2 => if Ty.sub κ 1 t1 t && Ty.sub κ 1 t2 t then some t else none
      | _, _ => none
    | _ => none
  | D, Γ, .fold t e => match t, check Δ κ D Γ e with
    | .mu r b, some te => if Ty.sub κ 1 te (Ty.unf r b) then some (.mu r b) else none
    | _, _ => none
  | D, Γ, .unfold e => match check Δ κ D Γ e with
    | some (.mu r b) => some (Ty.unf r b)
    | _ => none
  | D, Γ, .copy k e => match check Δ κ D Γ e with
    | some te => if te.mf κ && decide (k + 1 ≤ D) then some (te.at k) else none
    | none => none
  | D, Γ, .view e => match check Δ κ D Γ e with
    | some (.box true r t) => some (.iref r t)
    | _ => none

/-- 検査器の健全性: 検査器が返す型で、規則どおりに型付く -/
theorem check_sound {Δ : List Def} {κ : List Kind} : ∀ {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty},
    check Δ κ D Γ e = some t → HasType Δ κ D Γ e t := by
  intro D Γ e
  induction e generalizing D Γ with
  | var i => intro t h; exact .var h
  | lit n => intro t h; simp [check] at h; subst h; exact .lit
  | pair a b iha ihb =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1 h2; subst h; exact .pair (iha h1) (ihb h2)
  | fst e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; exact .fst (ih h1)
  | snd e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; exact .snd (ih h1)
  | letE e b ihe ihb =>
    intro t h; simp only [check] at h
    split at h
    · rename_i t1 h1; exact .letE (ihe h1) (ihb h)
    · cases h
  | alloc m t0 e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i te h1; split at h <;> simp at h
      rename_i hc; simp at hc; subst h; exact .alloc (.sub (ih h1) hc.1) hc.2
    · cases h
  | read e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    · rename_i m r t0 h1; subst h; exact .read (ih h1)
    · rename_i r t0 h1; subst h; exact .readR (ih h1)
  | write e v ihe ihv =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i r t0 tv h1 h2; obtain ⟨hs, rfl⟩ := h; exact .write (ihe h1) (.sub (ihv h2) hs)
  | block e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i t0 h1; split at h <;> simp at h
      rename_i hc; subst h; exact .block (ih h1) hc
    · cases h
  | call g ts a e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i dfn te hg h1; obtain ⟨⟨⟨ha, hd⟩, hs⟩, rfl⟩ := h
    exact .call hg (argsOkB_iff.mp ha) hd (.sub (ih h1) hs)
  | fnref g ts =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i dfn hg; obtain ⟨ha, rfl⟩ := h
    exact .fnref hg (argsOkB_iff.mp ha)
  | callv a ef e ihf ihe =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i p q te h1 h2; obtain ⟨⟨hd, hs⟩, rfl⟩ := h
    exact .callv (ihf h1) hd (.sub (ihe h2) hs)
  | onone t0 => intro t h; simp [check] at h; subst h; exact .onone
  | osome e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i t0 h1; subst h; exact .osome (ih h1)
  | case t0 e e1 e2 ih ih1 ih2 =>
    intro t h; simp only [check] at h
    split at h
    · rename_i a h0
      split at h
      · rename_i t1 t2 h1 h2
        split at h <;> simp at h
        rename_i hc; simp at hc; subst h
        exact .case (ih h0) (.sub (ih1 h1) hc.1) (.sub (ih2 h2) hc.2)
      · simp at h
    · simp at h
  | fold t0 e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i r b te h1
      split at h <;> simp at h
      rename_i hc; subst h; exact .fold (.sub (ih h1) hc)
    · simp at h
  | unfold e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i r b h1; subst h; exact .unfold (ih h1)
  | copy k e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i te h1; split at h <;> simp at h
      rename_i hc; simp at hc; subst h; exact .copy (ih h1) hc.1 hc.2
    · cases h
  | view e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i r t0 h1; subst h; exact .view (ih h1)

/-! ## 正規化の補題と、部分型の反転 -/

theorem Ty.N_N (κ : List Kind) : ∀ t : Ty, (t.N κ).N κ = t.N κ
  | .int => rfl
  | .tvar i => by by_cases h : kindRF κ i <;> simp [Ty.N, h]
  | .tat i ρ => by by_cases h : kindRF κ i <;> simp [Ty.N, h]
  | .box m r t => by simp [Ty.N, Ty.N_N κ t]
  | .iref r t => by simp [Ty.N, Ty.N_N κ t]
  | .prod x y => by simp [Ty.N, Ty.N_N κ x, Ty.N_N κ y]
  | .fn p q => by simp [Ty.N, Ty.N_N κ p, Ty.N_N κ q]
  | .opt t => by simp [Ty.N, Ty.N_N κ t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.N_N κ b]

theorem Ty.N_rsubst (κ : List Kind) : ∀ (t : Ty) (k : Nat) (s : Ty), (t.rsubst k s).N κ = (t.N κ).rsubst k (s.N κ)
  | .int, _, _ => rfl
  | .tvar i, _, _ => by simp only [Ty.rsubst, Ty.N]; split <;> rfl
  | .tat i ρ, _, _ => by simp only [Ty.rsubst, Ty.N]; split <;> rfl
  | .box m r t, k, s => by simp [Ty.rsubst, Ty.N, Ty.N_rsubst κ t k s]
  | .iref r t, k, s => by simp [Ty.rsubst, Ty.N, Ty.N_rsubst κ t k s]
  | .prod x y, k, s => by simp [Ty.rsubst, Ty.N, Ty.N_rsubst κ x k s, Ty.N_rsubst κ y k s]
  | .fn _ _, _, _ => rfl
  | .opt t, k, s => by simp [Ty.rsubst, Ty.N, Ty.N_rsubst κ t k s]
  | .rvar i, k, s => by
    simp only [Ty.rsubst]
    by_cases h1 : i = k
    · simp [h1, Ty.N, Ty.rsubst]
    · by_cases h2 : k < i <;> simp [h1, h2, Ty.N, Ty.rsubst]
  | .mu r b, k, s => by simp [Ty.rsubst, Ty.N, Ty.N_rsubst κ b (k + 1) s]

theorem Ty.N_at_N (κ : List Kind) : ∀ (t : Ty) (k : Nat), ((t.N κ).at k).N κ = (t.at k).N κ
  | .int, _ => rfl
  | .tvar i, k => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.at, h]
  | .tat i ρ, k => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.at, h]
  | .box m r t, k => by simp [Ty.N, Ty.at, Ty.N_at_N κ t k]
  | .iref r t, k => by simp [Ty.N, Ty.at, Ty.N_at_N κ t k]
  | .prod x y, k => by simp [Ty.N, Ty.at, Ty.N_at_N κ x k, Ty.N_at_N κ y k]
  | .fn p q, _ => by simp [Ty.N, Ty.at, Ty.N_N]
  | .opt t, k => by simp [Ty.N, Ty.at, Ty.N_at_N κ t k]
  | .rvar _, _ => rfl
  | .mu r b, _ => by simp [Ty.N, Ty.at, Ty.N_N]

theorem Ty.mf_N (κ : List Kind) : ∀ t : Ty, (t.N κ).mf κ = t.mf κ
  | .int => rfl
  | .tvar i => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.mf, h]
  | .tat i ρ => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.mf, h]
  | .box m r t => by simp [Ty.N, Ty.mf, Ty.mf_N κ t]
  | .iref r t => by simp [Ty.N, Ty.mf, Ty.mf_N κ t]
  | .prod x y => by simp [Ty.N, Ty.mf, Ty.mf_N κ x, Ty.mf_N κ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.N, Ty.mf, Ty.mf_N κ t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.mf, Ty.mf_N κ b]

theorem Ty.rfK_N (κ : List Kind) : ∀ t : Ty, (t.N κ).rfK κ = t.rfK κ
  | .int => rfl
  | .tvar i => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.rfK, h]
  | .tat i ρ => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.rfK, h]
  | .box m r t => rfl
  | .iref r t => rfl
  | .prod x y => by simp [Ty.N, Ty.rfK, Ty.rfK_N κ x, Ty.rfK_N κ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.N, Ty.rfK, Ty.rfK_N κ t]
  | .rvar _ => rfl
  | .mu r b => rfl

theorem Ty.rc_N (κ : List Kind) : ∀ (t : Ty) (k : Nat), (t.N κ).rc k = t.rc k
  | .int, _ => rfl
  | .tvar i, _ => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.rc, h]
  | .tat i ρ, _ => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.rc, h]
  | .box m r t, k => by simp [Ty.N, Ty.rc, Ty.rc_N κ t k]
  | .iref r t, k => by simp [Ty.N, Ty.rc, Ty.rc_N κ t k]
  | .prod x y, k => by simp [Ty.N, Ty.rc, Ty.rc_N κ x k, Ty.rc_N κ y k]
  | .fn _ _, _ => rfl
  | .opt t, k => by simp [Ty.N, Ty.rc, Ty.rc_N κ t k]
  | .rvar _, _ => rfl
  | .mu r b, k => by simp [Ty.N, Ty.rc, Ty.rc_N κ b (k + 1)]

theorem Ty.cv_N (κ : List Kind) : ∀ t : Ty, (t.N κ).cv κ = t.cv κ
  | .int => rfl
  | .tvar i => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.cv, h]
  | .tat i ρ => by by_cases h : kindRF κ i <;> simp [Ty.N, Ty.cv, h]
  | .box m r t => by simp [Ty.N, Ty.cv, Ty.cv_N κ t]
  | .iref r t => by simp [Ty.N, Ty.cv, Ty.rfK_N, Ty.rc_N]
  | .prod x y => by simp [Ty.N, Ty.cv, Ty.cv_N κ x, Ty.cv_N κ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.N, Ty.cv, Ty.cv_N κ t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.cv, Ty.cv_N κ b]

/-- region を持たない型は、正規化すれば置き直しに依らない -/
theorem Ty.N_at_rfK (κ : List Kind) (k : Nat) : ∀ t : Ty, t.rfK κ = true → (t.at k).N κ = t.N κ
  | .int, _ => rfl
  | .tvar i, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.N, h]
  | .tat i _, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.N, h]
  | .box _ _ _, h => by simp [Ty.rfK] at h
  | .iref _ _, h => by simp [Ty.rfK] at h
  | .prod x y, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.N, Ty.N_at_rfK κ k x h.1, Ty.N_at_rfK κ k y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rfK] at h; simp [Ty.at, Ty.N, Ty.N_at_rfK κ k t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rfK] at h

/-- 正規化した形でも、深く共変な型は置き直す先の region を上げると部分型 -/
theorem Ty.sub0_at_N {κ : List Kind} {L k k' : Nat} (hk : k ≤ k') : ∀ t : Ty, t.cv κ = true →
    Ty.sub0 κ L ((t.at k).N κ) ((t.at k').N κ) = true
  | .int, _ => rfl
  | .tvar i, h => by
    simp [Ty.cv] at h; by_cases hr : kindRF κ i <;> simp [Ty.at, Ty.N, hr, Ty.sub0, h, hk]
  | .tat i _, h => by
    simp [Ty.cv] at h; by_cases hr : kindRF κ i <;> simp [Ty.at, Ty.N, hr, Ty.sub0, h, hk]
  | .box m _ t, h => by
    simp [Ty.cv] at h; obtain ⟨rfl, h⟩ := h; simp [Ty.at, Ty.N, Ty.sub0, hk, Ty.sub0_at_N hk t h]
  | .iref _ t, h => by
    simp [Ty.cv] at h; simp [Ty.at, Ty.N, Ty.sub0, hk, Ty.N_at_rfK κ k t h.1, Ty.N_at_rfK κ k' t h.1]
  | .prod x y, h => by
    simp [Ty.cv] at h; simp [Ty.at, Ty.N, Ty.sub0, Ty.sub0_at_N hk x h.1, Ty.sub0_at_N hk y h.2]
  | .fn _ _, _ => Ty.sub_refl _ _ _
  | .opt t, h => by simp [Ty.cv] at h; simp [Ty.at, Ty.N, Ty.sub0, Ty.sub0_at_N hk t h]
  | .rvar _, _ => Ty.sub_refl _ _ _
  | .mu _ b, h => by simp [Ty.cv] at h; simp [Ty.at, Ty.N, Ty.sub0, Ty.cv_N, h, hk]

/-- 展開の部分型: 本体が正規化で等しく、region が等しいか、深く共変な本体で region が上がるなら、展開も部分型 -/
theorem Ty.sub_unf {κ : List Kind} {L r r' : Nat} {b b' : Ty} (hb : b'.N κ = b.N κ)
    (hr : r' = r ∨ ((b'.N κ).cv κ = true ∧ r' ≤ r)) : Ty.sub κ L (Ty.unf r' b') (Ty.unf r b) = true := by
  unfold Ty.sub Ty.unf
  rw [← Ty.N_at_N κ (b'.rsubst 0 (.mu 0 b')) r', ← Ty.N_at_N κ (b.rsubst 0 (.mu 0 b)) r, Ty.N_rsubst, Ty.N_rsubst,
    show (Ty.mu 0 b').N κ = .mu 0 (b'.N κ) from rfl, show (Ty.mu 0 b).N κ = .mu 0 (b.N κ) from rfl, hb]
  rcases hr with rfl | ⟨hm, hl⟩
  · exact Ty.sub_refl _ _ _
  · rw [hb] at hm; exact Ty.sub0_at_N hl _ (Ty.cv_rsubst (s := .mu 0 (b.N κ)) hm _ 0 hm)

/-- 正規化は部分型を保つ -/
theorem Ty.sub0_N {κ : List Kind} {L : Nat} : ∀ {x y : Ty}, Ty.sub0 κ L x y = true → Ty.sub0 κ L (x.N κ) (y.N κ) = true
  | .int, .int, _ => rfl
  | .tvar i, .tvar j, hs => by simp [Ty.sub0] at hs; subst hs; exact Ty.sub_refl _ _ _
  | .tvar i, .tat j ρ, hs => by
    simp [Ty.sub0] at hs; obtain ⟨⟨rfl, hk⟩, hl⟩ := hs
    by_cases h1 : kindRF κ i
    · simp [Ty.N, h1, Ty.sub0]
    · simp [Ty.N, h1, Ty.sub0, hk, hl]
  | .tat i ρ, .tat j ρ', hs => by
    simp [Ty.sub0] at hs; obtain ⟨rfl, hs⟩ := hs
    by_cases h1 : kindRF κ i
    · simp [Ty.N, h1, Ty.sub0]
    · simp only [Ty.N, h1]; rcases hs with rfl | ⟨hk, hl⟩
      · exact Ty.sub_refl _ _ _
      · simp [Ty.sub0, hk, hl]
  | .box m r t, .box m' r' t', hs => by
    cases m <;> cases m' <;> simp [Ty.sub0] at hs
    · simp [Ty.N, Ty.sub0, hs.1, Ty.sub0_N hs.2]
    · obtain ⟨rfl, rfl⟩ := hs; simp [Ty.N, Ty.sub0]
  | .iref r t, .iref r' t', hs => by simp [Ty.sub0] at hs; obtain ⟨hs, rfl⟩ := hs; simp [Ty.N, Ty.sub0, hs]
  | .prod x y, .prod x' y', hs => by
    simp [Ty.sub0] at hs; simp [Ty.N, Ty.sub0, Ty.sub0_N hs.1, Ty.sub0_N hs.2]
  | .fn p q, .fn p' q', hs => by simp [Ty.sub0] at hs; obtain ⟨rfl, rfl⟩ := hs; exact Ty.sub_refl _ _ _
  | .opt x, .opt y, hs => by simp [Ty.sub0] at hs; simp [Ty.N, Ty.sub0, Ty.sub0_N hs]
  | .rvar i, .rvar j, hs => by simp [Ty.sub0] at hs; subst hs; exact Ty.sub_refl _ _ _
  | .mu r b, .mu r' b', hs => by
    simp [Ty.sub0] at hs; obtain ⟨rfl, hs⟩ := hs
    simp only [Ty.N, Ty.sub0, beq_self_eq_true, Bool.true_and, Ty.cv_N, Bool.or_eq_true, beq_iff_eq,
      Bool.and_eq_true, decide_eq_true_eq]
    exact hs
  | .int, .tvar _, hs | .int, .tat _ _, hs | .int, .box _ _ _, hs | .int, .prod _ _, hs | .int, .fn _ _, hs
  | .int, .opt _, hs | .int, .rvar _, hs | .int, .mu _ _, hs | .tvar _, .int, hs | .tvar _, .box _ _ _, hs
  | .tvar _, .prod _ _, hs | .tvar _, .fn _ _, hs | .tvar _, .opt _, hs | .tvar _, .rvar _, hs | .tvar _, .mu _ _, hs
  | .tat _ _, .int, hs | .tat _ _, .tvar _, hs | .tat _ _, .box _ _ _, hs | .tat _ _, .prod _ _, hs
  | .tat _ _, .fn _ _, hs | .tat _ _, .opt _, hs | .tat _ _, .rvar _, hs | .tat _ _, .mu _ _, hs
  | .box _ _ _, .int, hs | .box _ _ _, .tvar _, hs | .box _ _ _, .tat _ _, hs | .box _ _ _, .prod _ _, hs
  | .box _ _ _, .fn _ _, hs | .box _ _ _, .opt _, hs | .box _ _ _, .rvar _, hs | .box _ _ _, .mu _ _, hs
  | .prod _ _, .int, hs | .prod _ _, .tvar _, hs | .prod _ _, .tat _ _, hs | .prod _ _, .box _ _ _, hs
  | .prod _ _, .fn _ _, hs | .prod _ _, .opt _, hs | .prod _ _, .rvar _, hs | .prod _ _, .mu _ _, hs
  | .fn _ _, .int, hs | .fn _ _, .tvar _, hs | .fn _ _, .tat _ _, hs | .fn _ _, .box _ _ _, hs
  | .fn _ _, .prod _ _, hs | .fn _ _, .opt _, hs | .fn _ _, .rvar _, hs | .fn _ _, .mu _ _, hs | .opt _, .int, hs
  | .opt _, .tvar _, hs | .opt _, .tat _ _, hs | .opt _, .box _ _ _, hs | .opt _, .prod _ _, hs | .opt _, .fn _ _, hs
  | .opt _, .rvar _, hs | .opt _, .mu _ _, hs | .rvar _, .int, hs | .rvar _, .tvar _, hs | .rvar _, .tat _ _, hs
  | .rvar _, .box _ _ _, hs | .rvar _, .prod _ _, hs | .rvar _, .fn _ _, hs | .rvar _, .opt _, hs
  | .rvar _, .mu _ _, hs | .mu _ _, .int, hs | .mu _ _, .tvar _, hs | .mu _ _, .tat _ _, hs | .mu _ _, .box _ _ _, hs
  | .mu _ _, .prod _ _, hs | .mu _ _, .fn _ _, hs | .mu _ _, .opt _, hs | .mu _ _, .rvar _, hs | .iref _ _, .int, hs
  | .int, .iref _ _, hs | .iref _ _, .tvar _, hs | .tvar _, .iref _ _, hs | .iref _ _, .tat _ _, hs
  | .tat _ _, .iref _ _, hs | .iref _ _, .box _ _ _, hs | .box _ _ _, .iref _ _, hs | .iref _ _, .prod _ _, hs
  | .prod _ _, .iref _ _, hs | .iref _ _, .fn _ _, hs | .fn _ _, .iref _ _, hs | .iref _ _, .opt _, hs
  | .opt _, .iref _ _, hs | .iref _ _, .rvar _, hs | .rvar _, .iref _ _, hs | .iref _ _, .mu _ _, hs
  | .mu _ _, .iref _ _, hs => by simp [Ty.sub0] at hs

theorem Ty.sub_at {κ : List Kind} {L k : Nat} {a b : Ty} (h : Ty.sub κ L a b = true) : Ty.sub κ L (a.at k) (b.at k) = true := by
  unfold Ty.sub at h ⊢; rw [← Ty.N_at_N κ a k, ← Ty.N_at_N κ b k]; exact Ty.sub0_N (Ty.sub0_at h)

theorem Ty.mf_of_sub {κ : List Kind} {L : Nat} {a b : Ty} (h : Ty.sub κ L a b = true) (hb : b.mf κ = true) : a.mf κ = true := by
  rw [← Ty.mf_N] at hb ⊢; exact Ty.mf_of_sub0 h hb

theorem Ty.N_low (κ : List Kind) : ∀ t : Ty, t.lowTv.N κ = (t.N κ).lowTv
  | .int => rfl
  | .tvar i => by simp only [Ty.lowTv, Ty.N]; split <;> rfl
  | .tat i ρ => by simp only [Ty.lowTv, Ty.N]; split <;> rfl
  | .box m r t => by simp [Ty.lowTv, Ty.N, Ty.N_low κ t]
  | .iref r t => by simp [Ty.lowTv, Ty.N, Ty.N_low κ t]
  | .prod x y => by simp [Ty.lowTv, Ty.N, Ty.N_low κ x, Ty.N_low κ y]
  | .fn p q => rfl
  | .opt t => by simp [Ty.lowTv, Ty.N, Ty.N_low κ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.N_ren_N (κ : List Kind) (a δ : Nat) : ∀ t : Ty, ((t.N κ).ren a δ).N κ = (t.ren a δ).N κ
  | .int => rfl
  | .tvar i => by simp only [Ty.N, Ty.ren]; split <;> simp_all [Ty.N, Ty.ren]
  | .tat i ρ => by simp only [Ty.N, Ty.ren]; split <;> simp_all [Ty.N, Ty.ren]
  | .box m r t => by simp [Ty.N, Ty.ren, Ty.N_ren_N κ a δ t]
  | .iref r t => by simp [Ty.N, Ty.ren, Ty.N_ren_N κ a δ t]
  | .prod x y => by simp [Ty.N, Ty.ren, Ty.N_ren_N κ a δ x, Ty.N_ren_N κ a δ y]
  | .fn p q => by simp [Ty.N, Ty.ren, Ty.N_N]
  | .opt t => by simp [Ty.N, Ty.ren, Ty.N_ren_N κ a δ t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.ren, Ty.N_N]

/-- 正規化が等しい関数型の成分は、関数値の呼び出しの型でも正規化が等しい -/
theorem Ty.N_callv {κ : List Kind} {p p' : Ty} (h : p'.N κ = p.N κ) (a δ : Nat) :
    (p'.lowTv.ren a δ).N κ = (p.lowTv.ren a δ).N κ := by
  rw [← Ty.N_ren_N, Ty.N_low, h, ← Ty.N_low, Ty.N_ren_N]

theorem Ty.N_head_prod {κ : List Kind} {t a b : Ty} (h : t.N κ = .prod a b) : ∃ a' b', t = .prod a' b' ∧ a'.N κ = a ∧ b'.N κ = b := by
  cases t with
  | prod x y => simp [Ty.N] at h; exact ⟨x, y, rfl, h.1, h.2⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.N_head_box {κ : List Kind} {t : Ty} {m : Bool} {r : Nat} {a : Ty} (h : t.N κ = .box m r a) :
    ∃ a', t = .box m r a' ∧ a'.N κ = a := by
  cases t with
  | box m' r' x => simp [Ty.N] at h; obtain ⟨rfl, rfl, rfl⟩ := h; exact ⟨x, rfl, rfl⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.N_head_iref {κ : List Kind} {t : Ty} {r : Nat} {a : Ty} (h : t.N κ = .iref r a) :
    ∃ a', t = .iref r a' ∧ a'.N κ = a := by
  cases t with
  | iref r' x => simp [Ty.N] at h; obtain ⟨rfl, rfl⟩ := h; exact ⟨x, rfl, rfl⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.N_head_fn {κ : List Kind} {t p q : Ty} (h : t.N κ = .fn p q) : ∃ p' q', t = .fn p' q' ∧ p'.N κ = p ∧ q'.N κ = q := by
  cases t with
  | fn x y => simp [Ty.N] at h; exact ⟨x, y, rfl, h.1, h.2⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.N_head_opt {κ : List Kind} {t a : Ty} (h : t.N κ = .opt a) : ∃ a', t = .opt a' ∧ a'.N κ = a := by
  cases t with
  | opt x => simp [Ty.N] at h; exact ⟨x, rfl, h⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.N_head_mu {κ : List Kind} {t : Ty} {r : Nat} {b : Ty} (h : t.N κ = .mu r b) : ∃ b', t = .mu r b' ∧ b'.N κ = b := by
  cases t with
  | mu r' x => simp [Ty.N] at h; obtain ⟨rfl, rfl⟩ := h; exact ⟨x, rfl, rfl⟩
  | tvar i => unfold Ty.N at h; split at h <;> cases h
  | tat i ρ => unfold Ty.N at h; split at h <;> cases h
  | _ => simp [Ty.N] at h

theorem Ty.subR_opt {κ : List Kind} {L : Nat} {t a : Ty} (h : Ty.sub κ L t (.opt a) = true) :
    ∃ a', t = .opt a' ∧ Ty.sub κ L a' a = true := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T <;> simp [Ty.sub0] at h
  obtain ⟨a', rfl, rfl⟩ := Ty.N_head_opt hT
  exact ⟨a', rfl, h⟩

theorem Ty.subR_mu {κ : List Kind} {L : Nat} {t : Ty} {r : Nat} {b : Ty} (h : Ty.sub κ L t (.mu r b) = true) :
    ∃ r' b', t = .mu r' b' ∧ b'.N κ = b.N κ ∧ (r' = r ∨ ((b'.N κ).cv κ = true ∧ r' ≤ r)) := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T <;> simp [Ty.sub0] at h
  rename_i r' b0
  obtain ⟨b', rfl, rfl⟩ := Ty.N_head_mu hT
  exact ⟨r', b', rfl, h.1, h.2⟩

theorem Ty.subR_prod {κ : List Kind} {L : Nat} {t a b : Ty} (h : Ty.sub κ L t (.prod a b) = true) :
    ∃ a' b', t = .prod a' b' ∧ Ty.sub κ L a' a = true ∧ Ty.sub κ L b' b = true := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T <;> simp [Ty.sub0] at h
  obtain ⟨a', b', rfl, rfl, rfl⟩ := Ty.N_head_prod hT
  exact ⟨a', b', rfl, h.1, h.2⟩

theorem Ty.subR_box {κ : List Kind} {L : Nat} {t : Ty} {m : Bool} {r : Nat} {a : Ty} (h : Ty.sub κ L t (.box m r a) = true) :
    ∃ r' a', t = .box m r' a' ∧ Ty.sub κ L a' a = true ∧ (m = true → r' = r ∧ a'.N κ = a.N κ) := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T with
  | box m' r' x =>
    obtain ⟨a', rfl, rfl⟩ := Ty.N_head_box hT
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · exact ⟨r', a', rfl, by unfold Ty.sub; exact h.2, fun h' => by cases h'⟩
    · obtain ⟨rfl, h2⟩ := h
      exact ⟨r', a', rfl, by unfold Ty.sub; rw [h2]; exact Ty.sub_refl _ _ _, fun _ => ⟨rfl, h2⟩⟩
  | _ => simp [Ty.sub0] at h

theorem Ty.subR_iref {κ : List Kind} {L : Nat} {t : Ty} {r : Nat} {a : Ty} (h : Ty.sub κ L t (.iref r a) = true) :
    ∃ r' a', t = .iref r' a' ∧ a'.N κ = a.N κ ∧ r' ≤ r := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T <;> simp [Ty.sub0] at h
  rename_i r' x
  obtain ⟨a', rfl, rfl⟩ := Ty.N_head_iref hT
  exact ⟨r', a', rfl, h.2, h.1⟩

theorem Ty.subR_fn {κ : List Kind} {L : Nat} {t p q : Ty} (h : Ty.sub κ L t (.fn p q) = true) :
    ∃ p' q', t = .fn p' q' ∧ p'.N κ = p.N κ ∧ q'.N κ = q.N κ := by
  unfold Ty.sub at h; simp only [Ty.N] at h
  generalize hT : t.N κ = T at h
  cases T <;> simp [Ty.sub0] at h
  obtain ⟨p', q', rfl, rfl, rfl⟩ := Ty.N_head_fn hT
  exact ⟨p', q', rfl, h.1, h.2⟩

theorem Ty.rb_sub0 {κ : List Kind} {L D : Nat} : ∀ {a b : Ty}, Ty.sub0 κ L a b = true → b.rb D = true → a.rb D = true
  | .int, _, _, _ => rfl
  | .tvar _, _, _, _ => rfl
  | .tat i ρ, .tat j ρ', h, hb => by
    simp [Ty.sub0] at h; simp [Ty.rb] at hb ⊢; rcases h.2 with rfl | ⟨-, h⟩ <;> omega
  | .box m r t, .box m' r' t', h, hb => by
    simp [Ty.rb] at hb ⊢
    cases m <;> cases m' <;> simp [Ty.sub0] at h
    · exact ⟨by omega, Ty.rb_sub0 h.2 hb.2⟩
    · obtain ⟨rfl, rfl⟩ := h; exact hb
  | .iref r t, .iref r' t', h, hb => by
    simp [Ty.rb] at hb ⊢; simp [Ty.sub0] at h; obtain ⟨h, rfl⟩ := h; exact ⟨by omega, hb.2⟩
  | .prod x y, .prod x' y', h, hb => by
    simp [Ty.sub0] at h; simp [Ty.rb] at hb ⊢; exact ⟨Ty.rb_sub0 h.1 hb.1, Ty.rb_sub0 h.2 hb.2⟩
  | .fn _ _, _, _, _ => rfl
  | .opt x, .opt y, h, hb => by simp [Ty.sub0] at h; simp [Ty.rb] at hb ⊢; exact Ty.rb_sub0 h hb
  | .rvar _, _, _, _ => rfl
  | .mu r b, .mu r' b', h, hb => by
    simp [Ty.sub0] at h; simp [Ty.rb] at hb ⊢; rcases h.2 with rfl | ⟨-, h⟩ <;> omega
  | .tat _ _, .int, h, _ | .tat _ _, .tvar _, h, _ | .tat _ _, .box _ _ _, h, _ | .tat _ _, .prod _ _, h, _
  | .tat _ _, .fn _ _, h, _ | .tat _ _, .opt _, h, _ | .tat _ _, .rvar _, h, _ | .tat _ _, .mu _ _, h, _
  | .box _ _ _, .int, h, _ | .box _ _ _, .tvar _, h, _ | .box _ _ _, .tat _ _, h, _ | .box _ _ _, .prod _ _, h, _
  | .box _ _ _, .fn _ _, h, _ | .box _ _ _, .opt _, h, _ | .box _ _ _, .rvar _, h, _ | .box _ _ _, .mu _ _, h, _
  | .prod _ _, .int, h, _ | .prod _ _, .tvar _, h, _ | .prod _ _, .tat _ _, h, _ | .prod _ _, .box _ _ _, h, _
  | .prod _ _, .fn _ _, h, _ | .prod _ _, .opt _, h, _ | .prod _ _, .rvar _, h, _ | .prod _ _, .mu _ _, h, _
  | .opt _, .int, h, _ | .opt _, .tvar _, h, _ | .opt _, .tat _ _, h, _ | .opt _, .box _ _ _, h, _
  | .opt _, .prod _ _, h, _ | .opt _, .fn _ _, h, _ | .opt _, .rvar _, h, _ | .opt _, .mu _ _, h, _
  | .mu _ _, .int, h, _ | .mu _ _, .tvar _, h, _ | .mu _ _, .tat _ _, h, _ | .mu _ _, .box _ _ _, h, _
  | .mu _ _, .prod _ _, h, _ | .mu _ _, .fn _ _, h, _ | .mu _ _, .opt _, h, _ | .mu _ _, .rvar _, h, _
  | .iref _ _, .int, h, _ | .iref _ _, .tvar _, h, _
  | .iref _ _, .tat _ _, h, _ | .tat _ _, .iref _ _, h, _ | .iref _ _, .box _ _ _, h, _ | .box _ _ _, .iref _ _, h, _
  | .iref _ _, .prod _ _, h, _ | .prod _ _, .iref _ _, h, _ | .iref _ _, .fn _ _, h, _
  | .iref _ _, .opt _, h, _ | .opt _, .iref _ _, h, _ | .iref _ _, .rvar _, h, _
  | .iref _ _, .mu _ _, h, _ | .mu _ _, .iref _ _, h, _ => by simp [Ty.sub0] at h

theorem Ty.sub_of_N {κ : List Kind} {L : Nat} {a b : Ty} (h : a.N κ = b.N κ) : Ty.sub κ L a b = true := by
  unfold Ty.sub; rw [h]; exact Ty.sub_refl _ _ _

/-- 文脈の部分型（各変数の型が部分型） -/
def CtxSub (κ : List Kind) (Γ' Γ : List Ty) : Prop :=
  Γ'.length = Γ.length ∧ ∀ (i : Nat) (a b : Ty), Γ'[i]? = some a → Γ[i]? = some b → Ty.sub κ 1 a b = true

theorem CtxSub.refl (κ : List Kind) (Γ : List Ty) : CtxSub κ Γ Γ :=
  ⟨rfl, fun i a b h1 h2 => by rw [h1] at h2; cases h2; exact Ty.subN_refl _ _ _⟩

theorem CtxSub.cons {κ : List Kind} {Γ' Γ : List Ty} {a b : Ty} (h : CtxSub κ Γ' Γ) (hs : Ty.sub κ 1 a b = true) :
    CtxSub κ (a :: Γ') (b :: Γ) := by
  refine ⟨by simp [h.1], fun i x y h1 h2 => ?_⟩
  cases i with
  | zero => simp at h1 h2; subst h1; subst h2; exact hs
  | succ i => simp at h1 h2; exact h.2 i x y h1 h2

/-- 検査器の完全性: 規則で型付くなら、検査器は（部分型の文脈でも）部分型を返す -/
theorem check_complete {Δ : List Def} {κ : List Kind} {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty}
    (h : HasType Δ κ D Γ e t) : ∀ {Γ' : List Ty}, CtxSub κ Γ' Γ → ∃ t', check Δ κ D Γ' e = some t' ∧ Ty.sub κ 1 t' t = true := by
  induction h with
  | @var D Γ i t hi =>
    intro Γ' hc
    have hlt : i < Γ'.length := by
      rw [hc.1]; rcases Nat.lt_or_ge i Γ.length with h | h
      · exact h
      · rw [List.getElem?_eq_none h] at hi; cases hi
    have he : Γ'[i]? = some Γ'[i] := List.getElem?_eq_getElem hlt
    exact ⟨Γ'[i], by simp [check, he], hc.2 i _ _ he hi⟩
  | lit => intro Γ' _; exact ⟨.int, rfl, rfl⟩
  | pair _ _ iha ihb =>
    intro Γ' hc
    obtain ⟨ta, ha, hsa⟩ := iha hc; obtain ⟨tb, hb, hsb⟩ := ihb hc
    refine ⟨.prod ta tb, by simp [check, ha, hb], ?_⟩
    unfold Ty.sub at hsa hsb ⊢; simp [Ty.N, Ty.sub0, hsa, hsb]
  | fst _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    obtain ⟨a', b', rfl, ha, -⟩ := Ty.subR_prod hs
    exact ⟨a', by simp [check, h1], ha⟩
  | snd _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    obtain ⟨a', b', rfl, -, hb⟩ := Ty.subR_prod hs
    exact ⟨b', by simp [check, h1], hb⟩
  | letE _ _ ihe ihb =>
    intro Γ' hc
    obtain ⟨t1, h1, hs1⟩ := ihe hc
    obtain ⟨t2, h2, hs2⟩ := ihb (hc.cons hs1)
    exact ⟨t2, by simp [check, h1, h2], hs2⟩
  | sub _ hs ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs1⟩ := ih hc
    exact ⟨t', h1, Ty.subN_trans hs1 hs⟩
  | @alloc D Γ m e t _ hrb ih =>
    intro Γ' hc
    obtain ⟨te, h1, hs⟩ := ih hc
    exact ⟨.box m (D - 1) t, by simp [check, h1, hs, hrb], Ty.subN_refl _ _ _⟩
  | read _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    obtain ⟨r', a', rfl, ha, -⟩ := Ty.subR_box hs
    exact ⟨a', by simp [check, h1], ha⟩
  | readR _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    obtain ⟨r', a', rfl, ha, -⟩ := Ty.subR_iref hs
    exact ⟨a', by simp [check, h1], Ty.sub_of_N ha⟩
  | write _ _ ihe ihv =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ihe hc
    obtain ⟨r', a', rfl, -, hm⟩ := Ty.subR_box hs
    obtain ⟨rfl, hN⟩ := hm rfl
    obtain ⟨tv, h2, hsv⟩ := ihv hc
    have : Ty.sub κ 1 tv a' = true := by unfold Ty.sub at hsv ⊢; rw [hN]; exact hsv
    exact ⟨.int, by simp [check, h1, h2, this], rfl⟩
  | @block D Γ e t _ hrb ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    have hrb' : (t'.N κ).rb D = true := Ty.rb_sub0 hs hrb
    exact ⟨t', by simp [check, h1, hrb'], hs⟩
  | @call D Γ g ts a e dfn hg hargs ha _ ih =>
    intro Γ' hc
    obtain ⟨te, h1, hs⟩ := ih hc
    exact ⟨_, by simp [check, hg, h1, argsOkB_iff.mpr hargs, ha, hs], Ty.subN_refl _ _ _⟩
  | @fnref D Γ g ts dfn hg hargs =>
    intro Γ' _
    exact ⟨_, by simp [check, hg, argsOkB_iff.mpr hargs], Ty.subN_refl _ _ _⟩
  | @callv D Γ a ef e p q _ ha _ ihf ihe =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ihf hc
    obtain ⟨p', q', rfl, hp, hq⟩ := Ty.subR_fn hs
    obtain ⟨te, h2, hse⟩ := ihe hc
    have hse' : Ty.sub κ 1 te (p'.lowTv.ren a (D - 2)) = true := by
      unfold Ty.sub at hse ⊢; rw [Ty.N_callv hp]; exact hse
    exact ⟨_, by simp [check, h1, h2, ha, hse'], Ty.sub_of_N (Ty.N_callv hq _ _)⟩
  | onone => intro Γ' _; exact ⟨_, rfl, Ty.subN_refl _ _ _⟩
  | osome _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    refine ⟨.opt t', by simp [check, h1], ?_⟩
    unfold Ty.sub at hs ⊢; simp [Ty.N, Ty.sub0, hs]
  | @case D Γ t e e1 e2 a _ _ _ ihe ih1 ih2 =>
    intro Γ' hc
    obtain ⟨te, h0, hs0⟩ := ihe hc
    obtain ⟨a', rfl, ha⟩ := Ty.subR_opt hs0
    obtain ⟨t1, h1, hs1⟩ := ih1 hc
    obtain ⟨t2, h2, hs2⟩ := ih2 (hc.cons ha)
    exact ⟨t, by simp [check, h0, h1, h2, hs1, hs2], Ty.subN_refl _ _ _⟩
  | @fold D Γ r b e _ ih =>
    intro Γ' hc
    obtain ⟨te, h1, hs⟩ := ih hc
    exact ⟨.mu r b, by simp [check, h1, hs], Ty.subN_refl _ _ _⟩
  | @unfold D Γ r b e _ ih =>
    intro Γ' hc
    obtain ⟨t', h1, hs⟩ := ih hc
    obtain ⟨r', b', rfl, hb, hr⟩ := Ty.subR_mu hs
    exact ⟨Ty.unf r' b', by simp [check, h1], Ty.sub_unf hb hr⟩
  | @copy D Γ k e t _ hm hk ih =>
    intro Γ' hc
    obtain ⟨te, h1, hs⟩ := ih hc
    exact ⟨te.at k, by simp [check, h1, Ty.mf_of_sub hs hm, hk], Ty.sub_at hs⟩
  | @view D Γ e r t _ ih =>
    intro Γ' hc
    obtain ⟨te, h1, hs⟩ := ih hc
    obtain ⟨r', a', rfl, -, hm⟩ := Ty.subR_box hs
    obtain ⟨rfl, ha⟩ := hm rfl
    exact ⟨.iref r' a', by simp [check, h1], Ty.sub_of_N (by simp [Ty.N, ha])⟩

/-! # 展開との一致 -/

/-- 展開と比べる型: 素の型変数を含まず（関数型の中も）、T@ρ の添字が n 未満 -/
def Ty.ok (n : Nat) : Ty → Bool
  | .int => true
  | .tvar _ => false
  | .tat i _ => decide (i < n)
  | .box _ _ t => t.ok n
  | .iref _ t => t.ok n
  | .prod a b => a.ok n && b.ok n
  | .fn p q => p.ok n && q.ok n
  | .opt t => t.ok n
  | .rvar _ => true
  | .mu _ b => b.ok n

theorem Ty.ok_at {n : Nat} (k : Nat) : ∀ t : Ty, t.ok n = true → (t.at k).ok n = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.ok] at h
  | .tat i ρ, h => by simpa [Ty.ok, Ty.at] using h
  | .box m r t, h => by simp [Ty.ok] at h; simp [Ty.ok, Ty.at, Ty.ok_at k t h]
  | .iref r t, h => by simp [Ty.ok] at h; simp [Ty.ok, Ty.at, Ty.ok_at k t h]
  | .prod x y, h => by simp [Ty.ok] at h; simp [Ty.ok, Ty.at, Ty.ok_at k x h.1, Ty.ok_at k y h.2]
  | .fn _ _, h => h
  | .opt t, h => by simp [Ty.ok] at h; simp [Ty.ok, Ty.at, Ty.ok_at k t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => h

theorem look_ok {n : Nat} {σ : List Ty} (h : ∀ s ∈ σ, s.ok n = true) (i : Nat) : (look σ i).ok n = true := by
  unfold look; rw [List.getD_eq_getElem?_getD]
  cases hi : σ[i]? with
  | none => rfl
  | some s => exact h s (List.mem_of_getElem? hi)

/-- 型引数が ok なら、どの型へ代入しても ok -/
theorem Ty.ok_tsubst {n : Nat} : ∀ (t : Ty) (σ : List Ty), (∀ s ∈ σ, s.ok n = true) → (t.tsubst σ).ok n = true
  | .int, _, _ => rfl
  | .tvar i, σ, h => look_ok h i
  | .tat i ρ, σ, h => Ty.ok_at ρ _ (look_ok h i)
  | .box m r t, σ, h => by simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst t σ h]
  | .iref r t, σ, h => by simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst t σ h]
  | .prod x y, σ, h => by simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst x σ h, Ty.ok_tsubst y σ h]
  | .fn p q, σ, h => by
    have h' : ∀ s ∈ σ.map (Ty.at 0), s.ok n = true := by
      intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.ok_at 0 s0 (h s0 hs0)
    simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst p _ h', Ty.ok_tsubst q _ h']
  | .opt t, σ, h => by simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst t σ h]
  | .rvar _, _, _ => rfl
  | .mu r b, σ, h => by
    have h' : ∀ s ∈ σ.map (Ty.at 0), s.ok n = true := by
      intro s hs; obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.ok_at 0 s0 (h s0 hs0)
    simp [Ty.ok, Ty.tsubst, Ty.ok_tsubst b _ h']

theorem Ty.ok_ren {n : Nat} (a δ : Nat) : ∀ t : Ty, (t.ren a δ).ok n = t.ok n
  | .int => rfl
  | .tvar _ => rfl
  | .tat _ _ => rfl
  | .box m r t => by simp [Ty.ren, Ty.ok, Ty.ok_ren (n := n) a δ t]
  | .iref r t => by simp [Ty.ren, Ty.ok, Ty.ok_ren (n := n) a δ t]
  | .prod x y => by simp [Ty.ren, Ty.ok, Ty.ok_ren (n := n) a δ x, Ty.ok_ren (n := n) a δ y]
  | .fn _ _ => rfl
  | .opt t => by simp [Ty.ren, Ty.ok, Ty.ok_ren (n := n) a δ t]
  | .rvar _ => rfl
  | .mu _ _ => rfl

theorem Ty.lowTv_of_ok {n : Nat} : ∀ t : Ty, t.ok n = true → t.lowTv = t
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.ok] at h
  | .tat _ _, _ => rfl
  | .box m r t, h => by simp [Ty.ok] at h; simp [Ty.lowTv, Ty.lowTv_of_ok t h]
  | .iref r t, h => by simp [Ty.ok] at h; simp [Ty.lowTv, Ty.lowTv_of_ok t h]
  | .prod x y, h => by simp [Ty.ok] at h; simp [Ty.lowTv, Ty.lowTv_of_ok x h.1, Ty.lowTv_of_ok y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.ok] at h; simp [Ty.lowTv, Ty.lowTv_of_ok t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.noTv_of_ok {n : Nat} : ∀ t : Ty, t.ok n = true → t.noTv = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.ok] at h
  | .tat _ _, _ => rfl
  | .box m r t, h => by simp [Ty.ok] at h; simp [Ty.noTv, Ty.noTv_of_ok t h]
  | .iref r t, h => by simp [Ty.ok] at h; simp [Ty.noTv, Ty.noTv_of_ok t h]
  | .prod x y, h => by simp [Ty.ok] at h; simp [Ty.noTv, Ty.noTv_of_ok x h.1, Ty.noTv_of_ok y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.ok] at h; simp [Ty.noTv, Ty.noTv_of_ok t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.ok_rsubst {n : Nat} {s : Ty} (hs : s.ok n = true) : ∀ (t : Ty) (k : Nat), t.ok n = true → (t.rsubst k s).ok n = true
  | .int, _, _ => rfl
  | .tvar _, _, h => h
  | .tat _ _, _, h => h
  | .box _ _ t, k, h => by simp [Ty.ok] at h; simp [Ty.rsubst, Ty.ok, Ty.ok_rsubst hs t k h]
  | .iref _ t, k, h => by simp [Ty.ok] at h; simp [Ty.rsubst, Ty.ok, Ty.ok_rsubst hs t k h]
  | .prod x y, k, h => by simp [Ty.ok] at h; simp [Ty.rsubst, Ty.ok, Ty.ok_rsubst hs x k h.1, Ty.ok_rsubst hs y k h.2]
  | .fn _ _, _, h => h
  | .opt t, k, h => by simp [Ty.ok] at h; simp [Ty.rsubst, Ty.ok, Ty.ok_rsubst hs t k h]
  | .rvar i, k, _ => by simp only [Ty.rsubst]; split; exact hs; split <;> rfl
  | .mu _ b, k, h => by simp [Ty.ok] at h; simp [Ty.rsubst, Ty.ok, Ty.ok_rsubst hs b (k + 1) h]

theorem Ty.ok_unf {n r : Nat} {b : Ty} (h : b.ok n = true) : (Ty.unf r b).ok n = true :=
  Ty.ok_at r _ (Ty.ok_rsubst (s := .mu 0 b) h b 0 h)

/-- 項の注釈への代入 -/
def Expr.tsubstE (σ : List Ty) : Expr → Expr
  | .var i => .var i
  | .lit n => .lit n
  | .pair a b => .pair (a.tsubstE σ) (b.tsubstE σ)
  | .fst e => .fst (e.tsubstE σ)
  | .snd e => .snd (e.tsubstE σ)
  | .letE e b => .letE (e.tsubstE σ) (b.tsubstE σ)
  | .alloc m t e => .alloc m (t.tsubst σ) (e.tsubstE σ)
  | .read e => .read (e.tsubstE σ)
  | .write e v => .write (e.tsubstE σ) (v.tsubstE σ)
  | .block e => .block (e.tsubstE σ)
  | .call g ts a e => .call g (ts.map (Ty.tsubst · σ)) a (e.tsubstE σ)
  | .fnref g ts => .fnref g (ts.map (Ty.tsubst · σ))
  | .callv a ef e => .callv a (ef.tsubstE σ) (e.tsubstE σ)
  | .onone t => .onone (t.tsubst σ)
  | .osome e => .osome (e.tsubstE σ)
  | .case t e e1 e2 => .case (t.tsubst σ) (e.tsubstE σ) (e1.tsubstE σ) (e2.tsubstE σ)
  | .fold t e => .fold (t.tsubst σ) (e.tsubstE σ)
  | .unfold e => .unfold (e.tsubstE σ)
  | .copy k e => .copy k (e.tsubstE σ)
  | .view e => .view (e.tsubstE σ)

/-- 項の注釈がすべて ok -/
def Expr.ok (n : Nat) : Expr → Bool
  | .var _ => true
  | .lit _ => true
  | .pair a b => a.ok n && b.ok n
  | .fst e => e.ok n
  | .snd e => e.ok n
  | .letE e b => e.ok n && b.ok n
  | .alloc _ t e => t.ok n && e.ok n
  | .read e => e.ok n
  | .write e v => e.ok n && v.ok n
  | .block e => e.ok n
  | .call _ ts _ e => ts.all (Ty.ok n) && e.ok n
  | .fnref _ ts => ts.all (Ty.ok n)
  | .callv _ ef e => ef.ok n && e.ok n
  | .onone t => t.ok n
  | .osome e => e.ok n
  | .case t e e1 e2 => t.ok n && e.ok n && e1.ok n && e2.ok n
  | .fold t e => t.ok n && e.ok n
  | .unfold e => e.ok n
  | .copy _ e => e.ok n
  | .view e => e.ok n

/-- 型の検査を抜いた型の計算（返す型は kind に依らない） -/
def tyOf (Δ : List Def) : Nat → List Ty → Expr → Option Ty
  | _, Γ, .var i => Γ[i]?
  | _, _, .lit _ => some .int
  | D, Γ, .pair a b => match tyOf Δ D Γ a, tyOf Δ D Γ b with
    | some ta, some tb => some (.prod ta tb)
    | _, _ => none
  | D, Γ, .fst e => match tyOf Δ D Γ e with
    | some (.prod ta _) => some ta
    | _ => none
  | D, Γ, .snd e => match tyOf Δ D Γ e with
    | some (.prod _ tb) => some tb
    | _ => none
  | D, Γ, .letE e b => match tyOf Δ D Γ e with
    | some t1 => tyOf Δ D (t1 :: Γ) b
    | none => none
  | D, _, .alloc m t _ => some (.box m (D - 1) t)
  | D, Γ, .read e => match tyOf Δ D Γ e with
    | some (.box _ _ t) => some t
    | some (.iref _ t) => some t
    | _ => none
  | _, _, .write _ _ => some .int
  | D, Γ, .block e => tyOf Δ (D + 1) Γ e
  | D, _, .call g ts a _ => match Δ[g]? with
    | some dfn => some ((dfn.q.ren a (D - 2)).tsubst ts)
    | none => none
  | _, _, .fnref g ts => match Δ[g]? with
    | some dfn => some ((Ty.fn dfn.p dfn.q).tsubst ts)
    | none => none
  | D, Γ, .callv a ef _ => match tyOf Δ D Γ ef with
    | some (.fn _ q) => some (q.lowTv.ren a (D - 2))
    | _ => none
  | _, _, .onone t => some (.opt t)
  | D, Γ, .osome e => match tyOf Δ D Γ e with
    | some t => some (.opt t)
    | none => none
  | _, _, .case t _ _ _ => some t
  | _, _, .fold t _ => some t
  | D, Γ, .unfold e => match tyOf Δ D Γ e with
    | some (.mu r b) => some (Ty.unf r b)
    | _ => none
  | D, Γ, .copy k e => match tyOf Δ D Γ e with
    | some t => some (t.at k)
    | none => none
  | D, Γ, .view e => match tyOf Δ D Γ e with
    | some (.box true r t) => some (.iref r t)
    | _ => none

theorem check_tyOf {Δ : List Def} {κ : List Kind} : ∀ {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty},
    check Δ κ D Γ e = some t → tyOf Δ D Γ e = some t := by
  intro D Γ e
  induction e generalizing D Γ with
  | var i => intro t h; exact h
  | lit n => intro t h; exact h
  | pair a b iha ihb =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1 h2; subst h; simp [tyOf, iha h1, ihb h2]
  | fst e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; simp [tyOf, ih h1]
  | snd e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; simp [tyOf, ih h1]
  | letE e b ihe ihb =>
    intro t h; simp only [check] at h
    split at h
    · rename_i t1 h1; simp [tyOf, ihe h1, ihb h]
    · cases h
  | alloc m t0 e ih =>
    intro t h; simp only [check] at h
    split at h
    · split at h <;> simp at h; subst h; rfl
    · cases h
  | read e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    · rename_i m r t0 h1; subst h; simp [tyOf, ih h1]
    · rename_i r t0 h1; subst h; simp [tyOf, ih h1]
  | write e v _ _ =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    obtain ⟨-, rfl⟩ := h; rfl
  | block e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i t0 h1; split at h <;> simp at h; subst h; exact ih h1
    · cases h
  | call g ts a e _ =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i dfn te hg h1; obtain ⟨-, rfl⟩ := h; simp [tyOf, hg]
  | fnref g ts =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i dfn hg; obtain ⟨-, rfl⟩ := h; simp [tyOf, hg]
  | callv a ef e ihf _ =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i p q te h1 h2; obtain ⟨-, rfl⟩ := h; simp [tyOf, ihf h1]
  | onone t0 => intro t h; simp [check] at h; subst h; rfl
  | osome e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i t0 h1; subst h; simp [tyOf, ih h1]
  | case t0 e e1 e2 _ _ _ =>
    intro t h; simp only [check] at h
    split at h
    · split at h
      · split at h <;> simp at h; subst h; rfl
      · simp at h
    · simp at h
  | fold t0 e _ =>
    intro t h; simp only [check] at h
    split at h
    · split at h <;> simp at h; subst h; rfl
    · simp at h
  | unfold e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i r b h1; subst h; simp [tyOf, ih h1]
  | copy k e ih =>
    intro t h; simp only [check] at h
    split at h
    · rename_i te h1; split at h <;> simp at h; subst h; simp [tyOf, ih h1]
    · cases h
  | view e ih =>
    intro t h; simp only [check] at h
    split at h <;> simp at h
    rename_i r t0 h1; subst h; simp [tyOf, ih h1]

theorem check_kind_indep {Δ : List Def} {κ1 κ2 : List Kind} {D : Nat} {Γ : List Ty} {e : Expr} {t1 t2 : Ty}
    (h1 : check Δ κ1 D Γ e = some t1) (h2 : check Δ κ2 D Γ e = some t2) : t1 = t2 := by
  have := check_tyOf h1; rw [check_tyOf h2] at this; cases this; rfl

/-- 検査器が返す型は、注釈と文脈が ok なら ok -/
theorem check_ok {Δ : List Def} {κ : List Kind} {n : Nat} : ∀ {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty},
    (∀ s ∈ Γ, s.ok n = true) → e.ok n = true → check Δ κ D Γ e = some t → t.ok n = true := by
  intro D Γ e
  induction e generalizing D Γ with
  | var i => intro t hΓ _ h; exact hΓ t (List.mem_of_getElem? h)
  | lit _ => intro t _ _ h; simp [check] at h; subst h; rfl
  | pair a b iha ihb =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1 h2; subst h
    simp [Ty.ok, iha hΓ he.1 h1, ihb hΓ he.2 h2]
  | fst e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; have := ih hΓ he h1; simp [Ty.ok] at this; exact this.1
  | snd e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i ta tb h1; subst h; have := ih hΓ he h1; simp [Ty.ok] at this; exact this.2
  | letE e b ihe ihb =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · rename_i t1 h1
      have h1' := ihe hΓ he.1 h1
      exact ihb (fun s hs => by simp at hs; rcases hs with rfl | hs; exact h1'; exact hΓ s hs) he.2 h
    · cases h
  | alloc m t0 e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · split at h <;> simp at h; subst h; simp [Ty.ok, he.1]
    · cases h
  | read e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    · rename_i m r t0 h1; subst h; have := ih hΓ he h1; simpa [Ty.ok] using this
    · rename_i r t0 h1; subst h; have := ih hΓ he h1; simpa [Ty.ok] using this
  | write e v _ _ =>
    intro t _ _ h; simp only [check] at h
    split at h <;> simp at h
    obtain ⟨-, rfl⟩ := h; rfl
  | block e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · rename_i t0 h1; split at h <;> simp at h; subst h; exact ih hΓ he h1
    · cases h
  | call g ts a e _ =>
    intro t _ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    obtain ⟨-, rfl⟩ := h
    exact Ty.ok_tsubst _ _ (fun s hs => by simpa using he.1 s hs)
  | fnref g ts =>
    intro t _ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    obtain ⟨-, rfl⟩ := h
    exact Ty.ok_tsubst _ _ (fun s hs => by simpa using he s hs)
  | callv a ef e ihf _ =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i p q te h1 _; obtain ⟨-, rfl⟩ := h
    have hf := ihf hΓ he.1 h1
    simp [Ty.ok] at hf
    rw [Ty.ok_ren, Ty.lowTv_of_ok q hf.2]; exact hf.2
  | onone t0 => intro t _ he h; simp [Expr.ok] at he; simp [check] at h; subst h; simp [Ty.ok, he]
  | osome e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i t0 h1; subst h; simp [Ty.ok, ih hΓ he h1]
  | case t0 e e1 e2 _ _ _ =>
    intro t _ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · split at h
      · split at h <;> simp at h; subst h; exact he.1.1.1
      · simp at h
    · simp at h
  | fold t0 e _ =>
    intro t _ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · split at h <;> simp at h; subst h; exact he.1
    · simp at h
  | unfold e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i r b h1; subst h; have := ih hΓ he h1; simp [Ty.ok] at this; exact Ty.ok_unf this
  | copy k e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h
    · rename_i te h1; split at h <;> simp at h; subst h; exact Ty.ok_at k _ (ih hΓ he h1)
    · cases h
  | view e ih =>
    intro t hΓ he h; simp [Expr.ok] at he; simp only [check] at h
    split at h <;> simp at h
    rename_i r t0 h1; subst h; have := ih hΓ he h1; simpa [Ty.ok] using this

/-! ## 閉じた型の置き直しの性質と、kind の読み取り -/

/-- 閉じた型の kind: 旗はそれぞれ、region を持たない・mut を持たない・深く共変か -/
def kindOfTy (s : Ty) : Kind := ⟨s.rfK [], s.mf [], s.cv []⟩

theorem Ty.mf_of_rfK : ∀ s : Ty, s.rfK [] = true → s.mf [] = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .tat _ _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .box _ _ _, h => by simp [Ty.rfK] at h
  | .iref _ _, h => by simp [Ty.rfK] at h
  | .prod x y, h => by simp [Ty.rfK] at h; simp [Ty.mf, Ty.mf_of_rfK x h.1, Ty.mf_of_rfK y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rfK] at h; simp [Ty.mf, Ty.mf_of_rfK t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rfK] at h

theorem Ty.cv_of_rfK : ∀ s : Ty, s.rfK [] = true → s.cv [] = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .tat _ _, h => by simp [Ty.rfK, kindRF, kindOf, Kind.O] at h
  | .box _ _ _, h => by simp [Ty.rfK] at h
  | .iref _ _, h => by simp [Ty.rfK] at h
  | .prod x y, h => by simp [Ty.rfK] at h; simp [Ty.cv, Ty.cv_of_rfK x h.1, Ty.cv_of_rfK y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.rfK] at h; simp [Ty.cv, Ty.cv_of_rfK t h]
  | .rvar _, _ => rfl
  | .mu _ _, h => by simp [Ty.rfK] at h

theorem Ty.mf_of_cv : ∀ s : Ty, s.cv [] = true → s.mf [] = true
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.cv, kindCov, kindOf, Kind.O] at h
  | .tat _ _, h => by simp [Ty.cv, kindCov, kindOf, Kind.O] at h
  | .box m _ t, h => by simp [Ty.cv] at h; simp [Ty.mf, h.1, Ty.mf_of_cv t h.2]
  | .iref _ t, h => by simp [Ty.cv] at h; simp [Ty.mf, Ty.mf_of_rfK t h.1]
  | .prod x y, h => by simp [Ty.cv] at h; simp [Ty.mf, Ty.mf_of_cv x h.1, Ty.mf_of_cv y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.cv] at h; simp [Ty.mf, Ty.mf_of_cv t h]
  | .rvar _, _ => rfl
  | .mu _ b, h => by simp [Ty.cv] at h; simp [Ty.mf, Ty.mf_of_cv b h]

/-- 閉じた型の mut の有無は kind の列に依らない -/
theorem Ty.mf_closed {κ κ' : List Kind} : ∀ t : Ty, t.closed = true → t.mf κ = t.mf κ'
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box _ _ t, h => by simp [Ty.closed] at h; simp [Ty.mf, Ty.mf_closed (κ := κ) (κ' := κ') t h]
  | .iref _ t, h => by simp [Ty.closed] at h; simp [Ty.mf, Ty.mf_closed (κ := κ) (κ' := κ') t h]
  | .prod x y, h => by simp [Ty.closed] at h; simp [Ty.mf, Ty.mf_closed (κ := κ) (κ' := κ') x h.1, Ty.mf_closed (κ := κ) (κ' := κ') y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.closed] at h; simp [Ty.mf, Ty.mf_closed (κ := κ) (κ' := κ') t h]
  | .rvar _, _ => rfl
  | .mu _ b, h => by simp [Ty.closed] at h; simp [Ty.mf, Ty.mf_closed (κ := κ) (κ' := κ') b h]

theorem Ty.rfK_closed {κ κ' : List Kind} : ∀ t : Ty, t.closed = true → t.rfK κ = t.rfK κ'
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box _ _ _, _ => rfl
  | .iref _ _, _ => rfl
  | .prod x y, h => by simp [Ty.closed] at h; simp [Ty.rfK, Ty.rfK_closed (κ := κ) (κ' := κ') x h.1, Ty.rfK_closed (κ := κ) (κ' := κ') y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.closed] at h; simp [Ty.rfK, Ty.rfK_closed (κ := κ) (κ' := κ') t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.cv_closed {κ κ' : List Kind} : ∀ t : Ty, t.closed = true → t.cv κ = t.cv κ'
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box _ _ t, h => by simp [Ty.closed] at h; simp [Ty.cv, Ty.cv_closed (κ := κ) (κ' := κ') t h]
  | .iref _ t, h => by simp [Ty.closed] at h; simp [Ty.cv, Ty.rfK_closed (κ := κ) (κ' := κ') t h]
  | .prod x y, h => by simp [Ty.closed] at h; simp [Ty.cv, Ty.cv_closed (κ := κ) (κ' := κ') x h.1, Ty.cv_closed (κ := κ) (κ' := κ') y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.closed] at h; simp [Ty.cv, Ty.cv_closed (κ := κ) (κ' := κ') t h]
  | .rvar _, _ => rfl
  | .mu _ b, h => by simp [Ty.closed] at h; simp [Ty.cv, Ty.cv_closed (κ := κ) (κ' := κ') b h]

theorem Ty.at_eq_iff {ρ ρ' : Nat} : ∀ s : Ty, s.closed = true → (s.at ρ = s.at ρ' ↔ s.rfK [] = true ∨ ρ = ρ')
  | .int, _ => by simp [Ty.at, Ty.rfK]
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box m r t, h => by
    simp [Ty.closed] at h; simp only [Ty.at, Ty.rfK, Ty.box.injEq, true_and]
    constructor
    · intro ⟨h1, _⟩; exact .inr h1
    · rintro (h1 | rfl); · cases h1
      exact ⟨rfl, rfl⟩
  | .iref r t, h => by
    simp [Ty.closed] at h; simp only [Ty.at, Ty.rfK, Ty.iref.injEq]
    constructor
    · intro ⟨h1, _⟩; exact .inr h1
    · rintro (h1 | rfl); · cases h1
      exact ⟨rfl, rfl⟩
  | .prod x y, h => by
    simp [Ty.closed] at h
    have hx := Ty.at_eq_iff (ρ := ρ) (ρ' := ρ') x h.1; have hy := Ty.at_eq_iff (ρ := ρ) (ρ' := ρ') y h.2
    simp only [Ty.at, Ty.rfK, Ty.prod.injEq, hx, hy, Bool.and_eq_true]
    constructor
    · rintro ⟨h1 | h1, h2 | h2⟩ <;> simp_all
    · rintro (⟨h1, h2⟩ | h1) <;> simp_all
  | .fn _ _, _ => by simp [Ty.at, Ty.rfK]
  | .opt t, h => by
    simp [Ty.closed] at h; simp only [Ty.at, Ty.rfK, Ty.opt.injEq]; exact Ty.at_eq_iff t h
  | .rvar _, _ => by simp [Ty.at, Ty.rfK]
  | .mu _ _, _ => by simp [Ty.at, Ty.rfK]

/-- 閉じた型の置き直しの部分型は、kind の旗で決まる: region を持たないか、深く共変で region が上がるか、同じ region -/
theorem Ty.at_sub_iff {κ' : List Kind} {L ρ ρ' : Nat} : ∀ s : Ty, s.closed = true → s.rc 0 = true →
    (Ty.sub0 κ' L (s.at ρ) (s.at ρ') = true ↔ s.rfK [] = true ∨ (s.cv [] = true ∧ ρ ≤ ρ') ∨ ρ = ρ')
  | .int, _, _ => by simp [Ty.at, Ty.rfK, Ty.sub0]
  | .tvar _, h, _ => by simp [Ty.closed] at h
  | .tat _ _, h, _ => by simp [Ty.closed] at h
  | .box m r t, h, hc => by
    simp [Ty.closed] at h; simp [Ty.rc] at hc
    have ih := Ty.at_sub_iff (κ' := κ') (L := L) (ρ := ρ) (ρ' := ρ') t h hc
    have hrm := Ty.cv_of_rfK t
    cases m
    · simp only [Ty.at, Ty.sub0, Ty.rfK, Ty.cv, Bool.not_false, Bool.true_and, beq_self_eq_true, if_false,
        Bool.false_eq_true, false_or, Bool.and_eq_true, decide_eq_true_eq, ih]
      cases hr : t.rfK [] <;> cases hm : t.cv [] <;> simp_all <;> omega
    · simp [Ty.at, Ty.sub0, Ty.rfK, Ty.cv]; intro h1; subst h1; rfl
  | .iref r t, h, hc => by
    simp [Ty.closed] at h; simp [Ty.rc] at hc
    have he := Ty.at_eq_iff (ρ := ρ) (ρ' := ρ') t h
    simp only [Ty.at, Ty.sub0, Ty.rfK, Ty.cv, hc, Bool.and_true, Bool.false_eq_true, false_or, Bool.and_eq_true,
      decide_eq_true_eq, beq_iff_eq, he]
    cases hr : t.rfK [] <;> simp <;> omega
  | .prod x y, h, hc => by
    simp [Ty.closed] at h; simp [Ty.rc] at hc
    have hx := Ty.at_sub_iff (κ' := κ') (L := L) (ρ := ρ) (ρ' := ρ') x h.1 hc.1
    have hy := Ty.at_sub_iff (κ' := κ') (L := L) (ρ := ρ) (ρ' := ρ') y h.2 hc.2
    have hrx := Ty.cv_of_rfK x; have hry := Ty.cv_of_rfK y
    simp only [Ty.at, Ty.sub0, Ty.rfK, Ty.cv, Bool.and_eq_true, hx, hy]
    cases h1 : x.rfK [] <;> cases h2 : y.rfK [] <;> cases h3 : x.cv [] <;> cases h4 : y.cv [] <;> simp_all <;> omega
  | .fn _ _, _, _ => by simp [Ty.at, Ty.rfK, Ty.sub0]
  | .opt t, h, hc => by
    simp [Ty.closed] at h; simp [Ty.rc] at hc; simp only [Ty.at, Ty.sub0, Ty.rfK, Ty.cv]; exact Ty.at_sub_iff t h hc
  | .rvar _, _, _ => by simp [Ty.at, Ty.rfK, Ty.sub0]
  | .mu _ b, h, _ => by
    simp [Ty.closed] at h
    simp only [Ty.at, Ty.sub0, Ty.rfK, Ty.cv, Ty.cv_closed (κ := κ') (κ' := []) b h]
    cases hm : b.cv [] <;> simp <;> omega

theorem Ty.at_rb_iff {ρ D : Nat} : ∀ s : Ty, s.closed = true → ((s.at ρ).rb D = true ↔ s.rfK [] = true ∨ ρ < D)
  | .int, _ => by simp [Ty.at, Ty.rfK, Ty.rb]
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box m r t, h => by
    simp [Ty.closed] at h
    have ih := Ty.at_rb_iff (ρ := ρ) (D := D) t h
    simp only [Ty.at, Ty.rb, Ty.rfK, Bool.and_eq_true, decide_eq_true_eq, ih, Bool.false_eq_true, false_or]
    constructor
    · intro ⟨h1, _⟩; exact h1
    · intro h1; exact ⟨h1, .inr h1⟩
  | .iref r t, h => by
    simp [Ty.closed] at h
    have ih := Ty.at_rb_iff (ρ := ρ) (D := D) t h
    simp only [Ty.at, Ty.rb, Ty.rfK, Bool.and_eq_true, decide_eq_true_eq, ih, Bool.false_eq_true, false_or]
    constructor
    · intro ⟨h1, _⟩; exact h1
    · intro h1; exact ⟨h1, .inr h1⟩
  | .prod x y, h => by
    simp [Ty.closed] at h
    have hx := Ty.at_rb_iff (ρ := ρ) (D := D) x h.1; have hy := Ty.at_rb_iff (ρ := ρ) (D := D) y h.2
    simp only [Ty.at, Ty.rb, Ty.rfK, Bool.and_eq_true, hx, hy]
    constructor
    · rintro ⟨h1 | h1, h2 | h2⟩ <;> simp_all
    · rintro (⟨h1, h2⟩ | h1) <;> simp_all
  | .fn _ _, _ => by simp [Ty.at, Ty.rfK, Ty.rb]
  | .opt t, h => by simp [Ty.closed] at h; simp only [Ty.at, Ty.rb, Ty.rfK]; exact Ty.at_rb_iff t h
  | .rvar _, _ => by simp [Ty.at, Ty.rfK, Ty.rb]
  | .mu _ _, _ => by simp [Ty.at, Ty.rfK, Ty.rb]

/-- σ が κ を実現する: κ は σ の各型の kind・σ は閉じている -/
def Real (κ : List Kind) (σ : List Ty) : Prop :=
  κ = σ.map kindOfTy ∧ (∀ s ∈ σ, s.closed = true) ∧ ∀ s ∈ σ, s.rc 0 = true

theorem kindOfTy_at (k : Nat) (s : Ty) : kindOfTy (s.at k) = kindOfTy s := by
  simp [kindOfTy, Ty.rfK_at, Ty.mf_at, Ty.cv_at]

theorem Real.at0 {κ : List Kind} {σ : List Ty} (h : Real κ σ) : Real κ (σ.map (Ty.at 0)) := by
  refine ⟨by rw [h.1, List.map_map]; congr 1; funext s; simp [kindOfTy_at], fun s hs => ?_, rc_map_at h.2.2⟩
  obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at 0 s0 (h.2.1 s0 hs0)

theorem Real.kind {κ : List Kind} {σ : List Ty} (h : Real κ σ) {i : Nat} (hi : i < σ.length) :
    kindOf κ i = kindOfTy (look σ i) := by
  rw [h.1]; simp [kindOf, look, List.getD_eq_getElem?_getD, List.getElem?_map, hi]

theorem Real.closed {κ : List Kind} {σ : List Ty} (h : Real κ σ) (i : Nat) : (look σ i).closed = true := look_closed h.2.1 i

theorem Real.rf_iff {κ : List Kind} {σ : List Ty} (h : Real κ σ) {i : Nat} (hi : i < σ.length) :
    kindRF κ i = (look σ i).rfK [] := by
  simp only [kindRF, h.kind hi, kindOfTy]

theorem Real.mut_iff {κ : List Kind} {σ : List Ty} (h : Real κ σ) {i : Nat} (hi : i < σ.length) :
    kindMut κ i = !(look σ i).mf [] := by
  simp only [kindMut, h.kind hi, kindOfTy]

theorem Real.cov_iff {κ : List Kind} {σ : List Ty} (h : Real κ σ) {i : Nat} (hi : i < σ.length) :
    kindCov κ i = (look σ i).cv [] := by
  simp only [kindCov, h.kind hi, kindOfTy]

def κrf (n : Nat) : List Kind := List.replicate n .R

theorem kindRF_κrf {n i : Nat} (hi : i < n) : kindRF (κrf n) i = true := by
  simp [kindRF, kindOf, κrf, List.getD_eq_getElem?_getD, List.getElem?_replicate, hi, Kind.R]

theorem Ty.N_nil (t : Ty) : t.N [] = t := Ty.N_id (fun i => by simp [kindRF, kindOf, Kind.O]) t

theorem look_lt_of_ok {σ : List Ty} {i : Nat} (h : (Ty.tat i 0).ok σ.length = true) : i < σ.length := by
  simpa [Ty.ok] using h

theorem Ty.N_κrf_tat {n i ρ : Nat} (hi : i < n) : (Ty.tat i ρ).N (κrf n) = .tat i 0 := by
  simp [Ty.N, kindRF_κrf hi]

section Refl
variable {κ : List Kind} {σ : List Ty}

theorem Ty.refl_mf : ∀ {σ : List Ty}, Real κ σ → ∀ t : Ty, t.ok σ.length = true → (t.tsubst σ).mf [] = t.mf κ
  | _, _, .int, _ => rfl
  | _, _, .tvar _, h => by simp [Ty.ok] at h
  | _, hR, .tat i ρ, h => by
    simp [Ty.ok] at h; simp [Ty.tsubst, Ty.mf_at, Ty.mf, hR.mut_iff h]
  | _, hR, .box m r t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.mf, Ty.refl_mf hR t h]
  | _, hR, .iref r t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.mf, Ty.refl_mf hR t h]
  | _, hR, .prod x y, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.mf, Ty.refl_mf hR x h.1, Ty.refl_mf hR y h.2]
  | _, _, .fn _ _, _ => rfl
  | _, hR, .opt t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.mf, Ty.refl_mf hR t h]
  | _, _, .rvar _, _ => rfl
  | σ, hR, .mu _ b, h => by
    simp [Ty.ok] at h; simp only [Ty.tsubst, Ty.mf]
    exact Ty.refl_mf hR.at0 b (by rw [List.length_map]; exact h)

theorem Ty.refl_rfK (hR : Real κ σ) : ∀ t : Ty, t.ok σ.length = true → (t.tsubst σ).rfK [] = t.rfK κ
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.ok] at h
  | .tat i ρ, h => by
    simp [Ty.ok] at h; simp [Ty.tsubst, Ty.rfK_at, Ty.rfK, hR.rf_iff h]
  | .box m r t, h => rfl
  | .iref r t, h => rfl
  | .prod x y, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.rfK, Ty.refl_rfK hR x h.1, Ty.refl_rfK hR y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.rfK, Ty.refl_rfK hR t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem Ty.refl_cv : ∀ {σ : List Ty}, Real κ σ → ∀ t : Ty, t.ok σ.length = true → (t.tsubst σ).cv [] = t.cv κ
  | _, _, .int, _ => rfl
  | _, _, .tvar _, h => by simp [Ty.ok] at h
  | _, hR, .tat i ρ, h => by
    simp [Ty.ok] at h; simp [Ty.tsubst, Ty.cv_at, Ty.cv, hR.cov_iff h]
  | _, hR, .box m r t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.cv, Ty.refl_cv hR t h]
  | _, hR, .iref r t, h => by
    simp [Ty.ok] at h; simp [Ty.tsubst, Ty.cv, Ty.refl_rfK hR t h, Ty.rc_tsubst _ _ _ hR.2.2]
  | _, hR, .prod x y, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.cv, Ty.refl_cv hR x h.1, Ty.refl_cv hR y h.2]
  | _, _, .fn _ _, _ => rfl
  | _, hR, .opt t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.cv, Ty.refl_cv hR t h]
  | _, _, .rvar _, _ => rfl
  | σ, hR, .mu _ b, h => by
    simp [Ty.ok] at h; simp only [Ty.tsubst, Ty.cv]
    exact Ty.refl_cv hR.at0 b (by rw [List.length_map]; exact h)

theorem Ty.refl_rb (hR : Real κ σ) {D : Nat} (hD : 1 ≤ D) : ∀ t : Ty, t.ok σ.length = true →
    (t.tsubst σ).rb D = (t.N κ).rb D
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.ok] at h
  | .tat i ρ, h => by
    simp [Ty.ok] at h
    have hiff := Ty.at_rb_iff (ρ := ρ) (D := D) (look σ i) (hR.closed i)
    simp only [Ty.tsubst, Ty.N, hR.rf_iff h]
    rw [Bool.eq_iff_iff, hiff]
    cases hr : (look σ i).rfK [] <;> simp [Ty.rb] <;> omega
  | .box m r t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.N, Ty.rb, Ty.refl_rb hR hD t h]
  | .iref r t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.N, Ty.rb, Ty.refl_rb hR hD t h]
  | .prod x y, h => by
    simp [Ty.ok] at h; simp [Ty.tsubst, Ty.N, Ty.rb, Ty.refl_rb hR hD x h.1, Ty.refl_rb hR hD y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.ok] at h; simp [Ty.tsubst, Ty.N, Ty.rb, Ty.refl_rb hR hD t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

end Refl

/-- 等しさの読み取り: 形が同じ（κrf で正規化が等しい）なら、代入した型が等しい ⇔ κ で正規化が等しい -/
theorem Ty.refl_eq : ∀ (a b : Ty) {κ : List Kind} {σ : List Ty}, Real κ σ → a.ok σ.length = true → b.ok σ.length = true →
    a.N (κrf σ.length) = b.N (κrf σ.length) → (a.tsubst σ = b.tsubst σ ↔ a.N κ = b.N κ)
  | .int, b, κ, σ, _, _, hb, hs => by
    cases b with
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp_all [Ty.N, Ty.ok, Ty.tsubst]
  | .tvar _, _, _, _, _, ha, _, _ => by simp [Ty.ok] at ha
  | .tat i ρ, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | tat j ρ' =>
      simp [Ty.ok] at hb; rw [Ty.N_κrf_tat ha, Ty.N_κrf_tat hb] at hs; simp at hs; subst hs
      rw [Ty.tsubst, Ty.tsubst, Ty.at_eq_iff _ (hR.closed i)]
      simp only [Ty.N, hR.rf_iff ha]
      cases (look σ i).rfK [] <;> simp
    | tvar _ => simp [Ty.ok] at hb
    | _ => rw [Ty.N_κrf_tat ha] at hs; simp [Ty.N] at hs
  | .box m r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | box m' r' y =>
      simp [Ty.ok] at hb; simp [Ty.N] at hs; obtain ⟨rfl, rfl, hs⟩ := hs
      simp [Ty.tsubst, Ty.N, Ty.refl_eq x y hR ha hb hs]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs
  | .iref r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | iref r' y =>
      simp [Ty.ok] at hb; simp [Ty.N] at hs; obtain ⟨rfl, hs⟩ := hs
      simp [Ty.tsubst, Ty.N, Ty.refl_eq x y hR ha hb hs]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs
  | .prod x y, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | prod x' y' =>
      simp [Ty.ok] at hb; simp [Ty.N] at hs
      simp [Ty.tsubst, Ty.N, Ty.refl_eq x x' hR ha.1 hb.1 hs.1, Ty.refl_eq y y' hR ha.2 hb.2 hs.2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs
  | .fn p q, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | fn p' q' =>
      simp [Ty.ok] at hb; simp [Ty.N] at hs
      have hR0 := hR.at0
      have hl : (σ.map (Ty.at 0)).length = σ.length := by simp
      have e1 := Ty.refl_eq p p' hR0 (by rw [hl]; exact ha.1) (by rw [hl]; exact hb.1) (by rw [hl]; exact hs.1)
      have e2 := Ty.refl_eq q q' hR0 (by rw [hl]; exact ha.2) (by rw [hl]; exact hb.2) (by rw [hl]; exact hs.2)
      simp [Ty.tsubst, Ty.N, e1, e2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs

  | .opt x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | opt y => simp [Ty.ok] at hb; simp [Ty.N] at hs; simp [Ty.tsubst, Ty.N, Ty.refl_eq x y hR ha hb hs]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs
  | .rvar i, b, κ, σ, hR, ha, hb, hs => by
    cases b with
    | rvar j => simp [Ty.tsubst, Ty.N]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs
  | .mu r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | mu r' y =>
      simp [Ty.ok] at hb; simp [Ty.N] at hs; obtain ⟨rfl, hs⟩ := hs
      have hl : (σ.map (Ty.at 0)).length = σ.length := by simp
      have e1 := Ty.refl_eq x y hR.at0 (by rw [hl]; exact ha) (by rw [hl]; exact hb) (by rw [hl]; exact hs)
      simp [Ty.tsubst, Ty.N, e1]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N] at hs
    | _ => simp [Ty.N] at hs

/-- 部分型の読み取り: 形が合う（κrf で部分型）なら、代入した型の部分型 ⇔ κ での部分型 -/
theorem Ty.refl_sub : ∀ (a b : Ty) {κ : List Kind} {σ : List Ty}, Real κ σ → a.ok σ.length = true → b.ok σ.length = true →
    Ty.sub (κrf σ.length) 1 a b = true → Ty.sub [] 1 (a.tsubst σ) (b.tsubst σ) = Ty.sub κ 1 a b
  | .int, b, κ, σ, _, _, hb, hs => by
    cases b with
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => simp_all [Ty.sub, Ty.N, Ty.ok, Ty.tsubst, Ty.sub0]
  | .tvar _, _, _, _, _, ha, _, _ => by simp [Ty.ok] at ha
  | .tat i ρ, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | tat j ρ' =>
      simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat ha, Ty.N_κrf_tat hb] at hs; simp [Ty.sub0] at hs
      subst hs
      have hiff := Ty.at_sub_iff (κ' := []) (L := 1) (ρ := ρ) (ρ' := ρ') (look σ i) (hR.closed i) (look_rc hR.2.2 i)
      unfold Ty.sub; rw [Ty.N_nil, Ty.N_nil]; simp only [Ty.tsubst]
      rw [Bool.eq_iff_iff, hiff]
      have hk1 := hR.rf_iff ha; have hk2 := hR.cov_iff ha
      cases hr : (look σ i).rfK []
      · rw [hr] at hk1
        simp only [Ty.N, hk1]
        simp only [Ty.sub0, hk2, Bool.false_eq_true, if_false]
        cases hm : (look σ i).cv [] <;> simp <;> omega
      · rw [hr] at hk1; simp [Ty.N, hk1, Ty.sub0]
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at hs; rw [Ty.N_κrf_tat ha] at hs; simp [Ty.N, Ty.sub0] at hs
  | .box m r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | box m' r' y =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs ⊢; rw [Ty.N_nil, Ty.N_nil]
      cases m <;> cases m' <;> simp [Ty.N, Ty.sub0] at hs <;> simp only [Ty.tsubst, Ty.N, Ty.sub0]
      · have := Ty.refl_sub x y hR ha hb (by unfold Ty.sub; exact hs.2)
        unfold Ty.sub at this; rw [Ty.N_nil, Ty.N_nil] at this; simp [this]
      · rw [Bool.eq_iff_iff]; simp [Ty.refl_eq x y hR ha hb hs.2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
  | .iref r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | iref r' y =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs ⊢; rw [Ty.N_nil, Ty.N_nil]
      simp [Ty.N, Ty.sub0] at hs; simp only [Ty.tsubst, Ty.N, Ty.sub0]
      rw [Bool.eq_iff_iff]; simp [Ty.refl_eq x y hR ha hb hs.2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
  | .prod x y, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | prod x' y' =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
      have e1 := Ty.refl_sub x x' hR ha.1 hb.1 (by unfold Ty.sub; exact hs.1)
      have e2 := Ty.refl_sub y y' hR ha.2 hb.2 (by unfold Ty.sub; exact hs.2)
      unfold Ty.sub at e1 e2 ⊢; rw [Ty.N_nil, Ty.N_nil] at e1 e2 ⊢
      simp [Ty.tsubst, Ty.N, Ty.sub0, e1, e2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
  | .fn p q, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | fn p' q' =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs ⊢; rw [Ty.N_nil, Ty.N_nil]; simp [Ty.N, Ty.sub0] at hs
      have hR0 := hR.at0
      have hl : (σ.map (Ty.at 0)).length = σ.length := by simp
      have e1 := Ty.refl_eq p p' hR0 (by rw [hl]; exact ha.1) (by rw [hl]; exact hb.1) (by rw [hl]; exact hs.1)
      have e2 := Ty.refl_eq q q' hR0 (by rw [hl]; exact ha.2) (by rw [hl]; exact hb.2) (by rw [hl]; exact hs.2)
      simp only [Ty.tsubst, Ty.N, Ty.sub0]; rw [Bool.eq_iff_iff]; simp [e1, e2]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs

  | .opt x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | opt y =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
      have e1 := Ty.refl_sub x y hR ha hb (by unfold Ty.sub; exact hs)
      unfold Ty.sub at e1 ⊢; rw [Ty.N_nil, Ty.N_nil] at e1 ⊢
      simp [Ty.tsubst, Ty.N, Ty.sub0, e1]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
  | .rvar i, b, κ, σ, hR, ha, hb, hs => by
    cases b with
    | rvar j => simp [Ty.sub, Ty.tsubst, Ty.N, Ty.sub0]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs
  | .mu r x, b, κ, σ, hR, ha, hb, hs => by
    simp [Ty.ok] at ha
    cases b with
    | mu r' y =>
      simp [Ty.ok] at hb
      unfold Ty.sub at hs ⊢; rw [Ty.N_nil, Ty.N_nil]; simp [Ty.N, Ty.sub0] at hs
      have hl : (σ.map (Ty.at 0)).length = σ.length := by simp
      have e1 := Ty.refl_eq x y hR.at0 (by rw [hl]; exact ha) (by rw [hl]; exact hb) (by rw [hl]; exact hs.1)
      have e2 := Ty.refl_cv hR.at0 x (by rw [hl]; exact ha)
      simp only [Ty.tsubst, Ty.N, Ty.sub0, Ty.cv_N, e2]
      rw [Bool.eq_iff_iff]; simp [e1]
    | tvar _ => simp [Ty.ok] at hb
    | tat j _ => simp [Ty.ok] at hb; unfold Ty.sub at hs; rw [Ty.N_κrf_tat hb] at hs; simp [Ty.N, Ty.sub0] at hs
    | _ => unfold Ty.sub at hs; simp [Ty.N, Ty.sub0] at hs

theorem List.all_eq_of {α : Type} {f g : α → Bool} : ∀ {l : List α}, (∀ x ∈ l, f x = g x) → l.all f = l.all g
  | [], _ => rfl
  | x :: l, h => by
    have : l.all f = l.all g := List.all_eq_of (fun y hy => h y (List.mem_cons_of_mem x hy))
    simp only [List.all_cons, h x List.mem_cons_self, this]

theorem argsOkB_refl {κ : List Kind} {σ : List Ty} (hR : Real κ σ) {D : Nat} (hD : 1 ≤ D) (κ' : List Kind) {ts : List Ty}
    (hts : ∀ s ∈ ts, s.ok σ.length = true) :
    argsOkB [] D κ' (ts.map (Ty.tsubst · σ)) = argsOkB κ D κ' ts := by
  have hts' : ∀ i, (look ts i).ok σ.length = true := look_ok hts
  unfold argsOkB
  simp only [List.all_map, look_map (Ty.tsubst · σ) rfl]
  rw [List.all_eq_of (g := fun s => (s.N κ).rb D) (fun s hs => by simp [Ty.N_nil, Ty.refl_rb hR hD s (hts s hs)]),
    List.all_eq_of (g := fun i => (kindMut κ' i || (look ts i).mf κ) && (!kindRF κ' i || (look ts i).rfK κ) &&
      (!kindCov κ' i || (look ts i).cv κ))
      (fun i _ => by simp [Ty.refl_mf hR _ (hts' i), Ty.refl_rfK hR _ (hts' i), Ty.refl_cv hR _ (hts' i)])]
  congr 1
  exact List.all_eq_of (fun s _ => by simp [Ty.rc_tsubst _ _ _ hR.2.2])

theorem Ty.lowTv_of_closed : ∀ t : Ty, t.closed = true → t.lowTv = t
  | .int, _ => rfl
  | .tvar _, h => by simp [Ty.closed] at h
  | .tat _ _, h => by simp [Ty.closed] at h
  | .box m r t, h => by simp [Ty.closed] at h; simp [Ty.lowTv, Ty.lowTv_of_closed t h]
  | .iref r t, h => by simp [Ty.closed] at h; simp [Ty.lowTv, Ty.lowTv_of_closed t h]
  | .prod x y, h => by simp [Ty.closed] at h; simp [Ty.lowTv, Ty.lowTv_of_closed x h.1, Ty.lowTv_of_closed y h.2]
  | .fn _ _, _ => rfl
  | .opt t, h => by simp [Ty.closed] at h; simp [Ty.lowTv, Ty.lowTv_of_closed t h]
  | .rvar _, _ => rfl
  | .mu _ _, _ => rfl

theorem callv_ty {σ : List Ty} {n : Nat} {p : Ty} (hp : p.ok n = true) (a δ : Nat) :
    (p.tsubst (σ.map (Ty.at 0))).ren a δ = (p.ren a δ).tsubst σ := by
  have hm : (σ.map (Ty.at 0)).map (Ty.ren a δ) = σ.map (Ty.at a) := by
    simp [Function.comp_def, Ty.ren_at, Ty.at_ren, rmap]
  rw [Ty.ren_tsubst, hm, Ty.tsubst_noTv _ _ _ (by rw [Ty.noTv_ren]; exact Ty.noTv_of_ok p hp)]

/-- 鍵の補題: 形の検査（どの型変数も region を持たない kind とみなす検査）が通る項について、
展開した項の単相の検査の結果は、ジェネリックの検査（σ の kind で）の結果を σ で展開したもの -/
theorem expand_check {Δ : List Def} {κ : List Kind} {σ : List Ty} (hR : Real κ σ) :
    ∀ {D : Nat} {Γ : List Ty} {e : Expr} {t0 : Ty}, 1 ≤ D → (∀ s ∈ Γ, s.ok σ.length = true) → e.ok σ.length = true →
    check Δ (κrf σ.length) D Γ e = some t0 →
    check Δ [] D (Γ.map (Ty.tsubst · σ)) (e.tsubstE σ) = (check Δ κ D Γ e).map (Ty.tsubst · σ) := by
  intro D Γ e
  induction e generalizing D Γ with
  | var i => intro t0 _ _ _ _; simp [check, Expr.tsubstE, List.getElem?_map]
  | lit _ => intro t0 _ _ _ _; rfl
  | pair a b iha ihb =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i ta tb h1 h2
    simp only [check, Expr.tsubstE, iha hD hΓ he.1 h1, ihb hD hΓ he.2 h2]
    cases check Δ κ D Γ a <;> cases check Δ κ D Γ b <;> simp [Ty.tsubst]
  | fst e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i ta tb h1
    simp only [check, Expr.tsubstE, ih hD hΓ he h1]
    cases hc : check Δ κ D Γ e with
    | none => rfl
    | some t => rw [check_kind_indep hc h1]; simp [Ty.tsubst]
  | snd e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i ta tb h1
    simp only [check, Expr.tsubstE, ih hD hΓ he h1]
    cases hc : check Δ κ D Γ e with
    | none => rfl
    | some t => rw [check_kind_indep hc h1]; simp [Ty.tsubst]
  | letE e b ihe ihb =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs
    · rename_i t1 h1
      have h1ok := check_ok hΓ he.1 h1
      simp only [check, Expr.tsubstE, ihe hD hΓ he.1 h1]
      cases hc : check Δ κ D Γ e with
      | none => rfl
      | some t => 
        rw [check_kind_indep hc h1]
        have := ihb (Γ := t1 :: Γ) hD (fun s hs => by simp at hs; rcases hs with rfl | hs; exact h1ok; exact hΓ s hs) he.2 hs
        simpa using this
    · cases hs
  | alloc m t e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs
    · rename_i te h1
      split at hs <;> simp at hs
      rename_i hc0; simp at hc0
      have h1ok := check_ok hΓ he.2 h1
      simp only [check, Expr.tsubstE, ih hD hΓ he.2 h1]
      cases hc : check Δ κ D Γ e with
      | none => rfl
      | some te' =>
        rw [check_kind_indep hc h1]
        simp only [Option.map_some, Ty.N_nil, Ty.refl_sub te t hR h1ok he.1 hc0.1, Ty.refl_rb hR hD t he.1]
        split <;> simp [Ty.tsubst]
    · cases hs
  | read e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    · rename_i m r t1 h1
      simp only [check, Expr.tsubstE, ih hD hΓ he h1]
      cases hc : check Δ κ D Γ e with
      | none => rfl
      | some t => rw [check_kind_indep hc h1]; simp [Ty.tsubst]
    · rename_i r t1 h1
      simp only [check, Expr.tsubstE, ih hD hΓ he h1]
      cases hc : check Δ κ D Γ e with
      | none => rfl
      | some t => rw [check_kind_indep hc h1]; simp [Ty.tsubst]
  | write e v ihe ihv =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i r t1 tv h1 h2
    have hok1 := check_ok hΓ he.1 h1; have hok2 := check_ok hΓ he.2 h2
    simp [Ty.ok] at hok1
    simp only [check, Expr.tsubstE, ihe hD hΓ he.1 h1, ihv hD hΓ he.2 h2]
    cases hc1 : check Δ κ D Γ e with
    | none => rfl
    | some te =>
      rw [check_kind_indep hc1 h1]
      cases hc2 : check Δ κ D Γ v with
      | none => simp [Ty.tsubst]
      | some tv' =>
        rw [check_kind_indep hc2 h2]
        simp only [Option.map_some, Ty.tsubst, Ty.refl_sub tv t1 hR hok2 hok1 hs.1]
        split <;> rfl
  | block e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs
    · rename_i t1 h1
      have h1ok := check_ok hΓ he h1
      simp only [check, Expr.tsubstE, ih (by omega) hΓ he h1]
      cases hc : check Δ κ (D + 1) Γ e with
      | none => rfl
      | some t =>
        rw [check_kind_indep hc h1]
        simp only [Option.map_some, Ty.N_nil, Ty.refl_rb hR hD t1 h1ok]
        split <;> rfl
    · cases hs
  | call g ts a e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i dfn te hg h1
    have h1ok := check_ok hΓ he.2 h1
    have hts : ∀ s ∈ ts, s.ok σ.length = true := fun s hs => by simpa using he.1 s hs
    have hpok : ((dfn.p.ren a (D - 2)).tsubst ts).ok σ.length = true := Ty.ok_tsubst _ _ hts
    simp only [check, Expr.tsubstE, ih hD hΓ he.2 h1, hg]
    cases hc : check Δ κ D Γ e with
    | none => rfl
    | some te' =>
      rw [check_kind_indep hc h1]
      simp only [Option.map_some, argsOkB_refl hR hD dfn.κ hts, ← Ty.tsubst_comp,
        Ty.refl_sub te _ hR h1ok hpok hs.1.2]
      split <;> rfl
  | fnref g ts =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i dfn hg
    have hts : ∀ s ∈ ts, s.ok σ.length = true := fun s hs => by simpa using he s hs
    simp only [check, Expr.tsubstE, hg, argsOkB_refl hR hD dfn.κ hts, ← Ty.tsubst_comp]
    split <;> rfl
  | callv a ef e ihf ihe =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i p q te h1 h2
    have hfok := check_ok hΓ he.1 h1; simp [Ty.ok] at hfok
    have h2ok := check_ok hΓ he.2 h2
    simp only [check, Expr.tsubstE, ihf hD hΓ he.1 h1, ihe hD hΓ he.2 h2]
    cases hc1 : check Δ κ D Γ ef with
    | none => rfl
    | some tf =>
      rw [check_kind_indep hc1 h1]
      cases hc2 : check Δ κ D Γ e with
      | none => simp [Ty.tsubst]
      | some te' =>
        rw [check_kind_indep hc2 h2]
        have hcp : (p.tsubst (σ.map (Ty.at 0))).closed = true :=
          Ty.closed_tsubst _ _ (fun s hs => by obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at 0 s0 (hR.2.1 s0 hs0))
        have hcq : (q.tsubst (σ.map (Ty.at 0))).closed = true :=
          Ty.closed_tsubst _ _ (fun s hs => by obtain ⟨s0, hs0, rfl⟩ := List.mem_map.mp hs; exact Ty.closed_at 0 s0 (hR.2.1 s0 hs0))
        have hpl : (p.lowTv.ren a (D - 2)).ok σ.length = true := by rw [Ty.ok_ren, Ty.lowTv_of_ok p hfok.1]; exact hfok.1
        simp only [Option.map_some, Ty.tsubst]
        rw [Ty.lowTv_of_closed _ hcp, Ty.lowTv_of_closed _ hcq, callv_ty hfok.1, callv_ty hfok.2]
        rw [Ty.lowTv_of_ok p hfok.1] at hs hpl
        rw [Ty.lowTv_of_ok p hfok.1, Ty.lowTv_of_ok q hfok.2]
        simp only [Ty.refl_sub te _ hR h2ok hpl hs.1.2]
        split <;> rfl
  | onone t => intro t0 _ _ _ _; simp [check, Expr.tsubstE, Ty.tsubst]
  | osome e ih =>
    intro t0 hD hΓ he hs; simp only [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i t1 h1
    simp only [check, Expr.tsubstE, ih hD hΓ he h1]
    cases check Δ κ D Γ e <;> simp [Ty.tsubst]
  | case t e e1 e2 ih ih1 ih2 =>
    intro t0 hD hΓ he hs; simp only [Expr.ok, Bool.and_eq_true] at he; simp only [check] at hs
    split at hs
    · rename_i a h0
      split at hs
      · rename_i t1 t2 h1 h2
        split at hs <;> simp at hs
        rename_i hc; simp at hc
        have hok0 := check_ok hΓ he.1.1.2 h0; simp [Ty.ok] at hok0
        have hΓ' : ∀ s ∈ a :: Γ, s.ok σ.length = true := fun s hs => by
          simp at hs; rcases hs with rfl | hs; exact hok0; exact hΓ s hs
        have hok1 := check_ok hΓ he.1.2 h1; have hok2 := check_ok hΓ' he.2 h2
        have e2' := ih2 (Γ := a :: Γ) hD hΓ' he.2 h2
        simp only [List.map_cons] at e2'
        simp only [check, Expr.tsubstE, ih hD hΓ he.1.1.2 h0]
        cases hc0 : check Δ κ D Γ e with
        | none => rfl
        | some te =>
          rw [check_kind_indep hc0 h0]
          simp only [Option.map_some, Ty.tsubst]
          rw [ih1 hD hΓ he.1.2 h1, e2']
          cases hc1 : check Δ κ D Γ e1 with
          | none => simp
          | some t1' =>
            rw [check_kind_indep hc1 h1]
            cases hc2 : check Δ κ D (a :: Γ) e2 with
            | none => simp
            | some t2' =>
              rw [check_kind_indep hc2 h2]
              simp only [Option.map_some, Ty.refl_sub t1 t hR hok1 he.1.1.1 hc.1, Ty.refl_sub t2 t hR hok2 he.1.1.1 hc.2]
              split <;> rfl
      · simp at hs
    · simp at hs
  | fold t e ih =>
    intro t0 hD hΓ he hs; simp only [Expr.ok, Bool.and_eq_true] at he; simp only [check] at hs
    split at hs
    · rename_i r b te h1
      split at hs <;> simp at hs
      rename_i hc
      have hok1 := check_ok hΓ he.2 h1
      have hbok : b.ok σ.length = true := by simpa [Ty.ok] using he.1
      simp only [check, Expr.tsubstE, ih hD hΓ he.2 h1, Ty.tsubst]
      cases hc0 : check Δ κ D Γ e with
      | none => rfl
      | some te' =>
        rw [check_kind_indep hc0 h1]
        simp only [Option.map_some]
        rw [← Ty.unf_tsubst hR.2.2, Ty.refl_sub te _ hR hok1 (Ty.ok_unf hbok) hc]
        split <;> rfl
    · simp at hs
  | unfold e ih =>
    intro t0 hD hΓ he hs; simp only [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i r b h1
    simp only [check, Expr.tsubstE, ih hD hΓ he h1]
    cases hc : check Δ κ D Γ e with
    | none => rfl
    | some t =>
      rw [check_kind_indep hc h1]
      simp only [Option.map_some, Ty.tsubst]
      rw [Ty.unf_tsubst hR.2.2]
  | copy k e ih =>
    intro t0 hD hΓ he hs; simp only [Expr.ok] at he; simp only [check] at hs
    split at hs
    · rename_i te h1
      have hok := check_ok hΓ he h1
      simp only [check, Expr.tsubstE, ih hD hΓ he h1]
      cases hc : check Δ κ D Γ e with
      | none => rfl
      | some t =>
        rw [check_kind_indep hc h1]
        simp only [Option.map_some, Ty.refl_mf hR te hok]
        split <;> simp [Ty.at_tsubst]
    · cases hs
  | view e ih =>
    intro t0 hD hΓ he hs; simp [Expr.ok] at he; simp only [check] at hs
    split at hs <;> simp at hs
    rename_i r t1 h1
    simp only [check, Expr.tsubstE, ih hD hΓ he h1]
    cases hc : check Δ κ D Γ e with
    | none => rfl
    | some t => rw [check_kind_indep hc h1]; simp [Ty.tsubst]

/-- 展開との一致（定理）: 閉じた型引数 σ と、その kind κ（σ の各型が region を持たないか・mut を持つか）について、
注釈が T@ρ だけで書かれ、形の検査が通る項は、σ で展開した項が単相の規則で型付く ⇔ κ の下でジェネリックの規則で型付く -/
theorem expand_iff {Δ : List Def} {κ : List Kind} {σ : List Ty} (hR : Real κ σ) {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty}
    (hD : 1 ≤ D) (hΓ : ∀ s ∈ Γ, s.ok σ.length = true) (he : e.ok σ.length = true) (ht : t.ok σ.length = true)
    (hshape : HasType Δ (κrf σ.length) D Γ e t) :
    HasType Δ [] D (Γ.map (Ty.tsubst · σ)) (e.tsubstE σ) (t.tsubst σ) ↔ HasType Δ κ D Γ e t := by
  obtain ⟨t0, hc0, hs0⟩ := check_complete hshape (CtxSub.refl _ _)
  have hk := expand_check hR hD hΓ he hc0
  have h0ok := check_ok hΓ he hc0
  have hrs := Ty.refl_sub t0 t hR h0ok ht hs0
  constructor
  · intro hm
    obtain ⟨τ, hcm, hsm⟩ := check_complete hm (CtxSub.refl _ _)
    rw [hk] at hcm
    cases hck : check Δ κ D Γ e with
    | none => rw [hck] at hcm; cases hcm
    | some t1 =>
      rw [hck] at hcm; simp at hcm; subst hcm
      have e1 := check_kind_indep hck hc0; subst e1
      exact .sub (check_sound hck) (by rw [← hrs]; exact hsm)
  · intro hg
    obtain ⟨t1, hc1, hs1⟩ := check_complete hg (CtxSub.refl _ _)
    have e1 := check_kind_indep hc0 hc1; subst e1
    have hcm : check Δ [] D (Γ.map (Ty.tsubst · σ)) (e.tsubstE σ) = some (t0.tsubst σ) := by rw [hk, hc1]; rfl
    exact .sub (check_sound hcm) (by rw [hrs]; exact hs1)

/-! ## kind についての単調性: 型変数により強い性質を仮定すれば、型付く項は型付いたまま -/

/-- k' は k 以上に強い仮定（旗ごとに、k で立っている旗は k' でも立っている） -/
def Kind.le (a b : Kind) : Bool := (!a.rf || b.rf) && (!a.mf || b.mf) && (!a.cov || b.cov)

def KLE (κ κ' : List Kind) : Prop := ∀ i, Kind.le (kindOf κ i) (kindOf κ' i) = true

section Mono
variable {κ κ' : List Kind}

theorem KLE.rf (h : KLE κ κ') {i : Nat} (hi : kindRF κ i = true) : kindRF κ' i = true := by
  have := h i; simp only [Kind.le, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at this
  simp only [kindRF] at hi ⊢; rcases this.1.1 with h1 | h1
  · rw [hi] at h1; cases h1
  · exact h1

theorem KLE.mut (h : KLE κ κ') {i : Nat} (hi : kindMut κ i = false) : kindMut κ' i = false := by
  have := h i; simp only [Kind.le, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at this
  simp only [kindMut, Bool.not_eq_false'] at hi ⊢; rcases this.1.2 with h1 | h1
  · rw [hi] at h1; cases h1
  · exact h1

theorem KLE.cov (h : KLE κ κ') {i : Nat} (hi : kindCov κ i = true) : kindCov κ' i = true := by
  have := h i; simp only [Kind.le, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at this
  simp only [kindCov] at hi ⊢; rcases this.2 with h1 | h1
  · rw [hi] at h1; cases h1
  · exact h1

theorem Ty.N_N' (h : KLE κ κ') : ∀ t : Ty, (t.N κ).N κ' = t.N κ'
  | .int => rfl
  | .tvar i => by
    by_cases h1 : kindRF κ i
    · simp [Ty.N, h1, h.rf h1]
    · simp [Ty.N, h1]
  | .tat i ρ => by
    by_cases h1 : kindRF κ i
    · simp [Ty.N, h1, h.rf h1]
    · simp [Ty.N, h1]
  | .box m r t => by simp [Ty.N, Ty.N_N' h t]
  | .iref r t => by simp [Ty.N, Ty.N_N' h t]
  | .prod x y => by simp [Ty.N, Ty.N_N' h x, Ty.N_N' h y]
  | .fn p q => by simp [Ty.N, Ty.N_N' h p, Ty.N_N' h q]
  | .opt t => by simp [Ty.N, Ty.N_N' h t]
  | .rvar _ => rfl
  | .mu r b => by simp [Ty.N, Ty.N_N' h b]

theorem Ty.mf_mono (h : KLE κ κ') : ∀ t : Ty, t.mf κ = true → t.mf κ' = true
  | .int, _ => rfl
  | .tvar i, ht => by simp [Ty.mf] at ht ⊢; exact h.mut ht
  | .tat i _, ht => by simp [Ty.mf] at ht ⊢; exact h.mut ht
  | .box m r t, ht => by simp [Ty.mf] at ht ⊢; exact ⟨ht.1, Ty.mf_mono h t ht.2⟩
  | .iref r t, ht => by simp [Ty.mf] at ht ⊢; exact Ty.mf_mono h t ht
  | .prod x y, ht => by simp [Ty.mf] at ht ⊢; exact ⟨Ty.mf_mono h x ht.1, Ty.mf_mono h y ht.2⟩
  | .fn _ _, _ => rfl
  | .opt t, ht => by simp [Ty.mf] at ht ⊢; exact Ty.mf_mono h t ht
  | .rvar _, _ => rfl
  | .mu _ b, ht => by simp [Ty.mf] at ht ⊢; exact Ty.mf_mono h b ht

theorem Ty.rfK_mono (h : KLE κ κ') : ∀ t : Ty, t.rfK κ = true → t.rfK κ' = true
  | .int, _ => rfl
  | .tvar i, ht => by simp [Ty.rfK] at ht ⊢; exact h.rf ht
  | .tat i _, ht => by simp [Ty.rfK] at ht ⊢; exact h.rf ht
  | .box _ _ _, ht => ht
  | .iref _ _, ht => ht
  | .prod x y, ht => by simp [Ty.rfK] at ht ⊢; exact ⟨Ty.rfK_mono h x ht.1, Ty.rfK_mono h y ht.2⟩
  | .fn _ _, _ => rfl
  | .opt t, ht => by simp [Ty.rfK] at ht ⊢; exact Ty.rfK_mono h t ht
  | .rvar _, _ => rfl
  | .mu _ _, ht => ht

theorem Ty.cv_mono (h : KLE κ κ') : ∀ t : Ty, t.cv κ = true → t.cv κ' = true
  | .int, _ => rfl
  | .tvar i, ht => by simp [Ty.cv] at ht ⊢; exact h.cov ht
  | .tat i _, ht => by simp [Ty.cv] at ht ⊢; exact h.cov ht
  | .box m r t, ht => by simp [Ty.cv] at ht ⊢; exact ⟨ht.1, Ty.cv_mono h t ht.2⟩
  | .iref r t, ht => by simp [Ty.cv] at ht ⊢; exact ⟨Ty.rfK_mono h t ht.1, ht.2⟩
  | .prod x y, ht => by simp [Ty.cv] at ht ⊢; exact ⟨Ty.cv_mono h x ht.1, Ty.cv_mono h y ht.2⟩
  | .fn _ _, _ => rfl
  | .opt t, ht => by simp [Ty.cv] at ht ⊢; exact Ty.cv_mono h t ht
  | .rvar _, _ => rfl
  | .mu _ b, ht => by simp [Ty.cv] at ht ⊢; exact Ty.cv_mono h b ht

theorem Ty.sub0_mono (h : KLE κ κ') {L : Nat} : ∀ {x y : Ty}, Ty.sub0 κ L x y = true → Ty.sub0 κ' L (x.N κ') (y.N κ') = true
  | .int, .int, _ => rfl
  | .tvar i, .tvar j, hs => by simp [Ty.sub0] at hs; subst hs; exact Ty.sub_refl _ _ _
  | .tvar i, .tat j ρ, hs => by
    simp [Ty.sub0] at hs; obtain ⟨⟨rfl, hk⟩, hl⟩ := hs
    by_cases h1 : kindRF κ' i
    · simp [Ty.N, h1, Ty.sub0]
    · simp [Ty.N, h1, Ty.sub0, h.cov hk, hl]
  | .tat i ρ, .tat j ρ', hs => by
    simp [Ty.sub0] at hs; obtain ⟨rfl, hs⟩ := hs
    by_cases h1 : kindRF κ' i
    · simp [Ty.N, h1, Ty.sub0]
    · simp only [Ty.N, h1]; rcases hs with rfl | ⟨hk, hl⟩
      · exact Ty.sub_refl _ _ _
      · simp [Ty.sub0, h.cov hk, hl]
  | .box m r t, .box m' r' t', hs => by
    cases m <;> cases m' <;> simp [Ty.sub0] at hs
    · simp [Ty.N, Ty.sub0, hs.1, Ty.sub0_mono h hs.2]
    · obtain ⟨rfl, rfl⟩ := hs; simp [Ty.N, Ty.sub0]
  | .iref r t, .iref r' t', hs => by simp [Ty.sub0] at hs; obtain ⟨hs, rfl⟩ := hs; simp [Ty.N, Ty.sub0, hs]
  | .prod x y, .prod x' y', hs => by
    simp [Ty.sub0] at hs; simp [Ty.N, Ty.sub0, Ty.sub0_mono h hs.1, Ty.sub0_mono h hs.2]
  | .fn p q, .fn p' q', hs => by simp [Ty.sub0] at hs; obtain ⟨rfl, rfl⟩ := hs; exact Ty.sub_refl _ _ _
  | .opt x, .opt y, hs => by simp [Ty.sub0] at hs; simp [Ty.N, Ty.sub0, Ty.sub0_mono h hs]
  | .rvar i, .rvar j, hs => by simp [Ty.sub0] at hs; subst hs; exact Ty.sub_refl _ _ _
  | .mu r b, .mu r' b', hs => by
    simp [Ty.sub0] at hs; obtain ⟨rfl, hs⟩ := hs
    simp only [Ty.N, Ty.sub0, beq_self_eq_true, Bool.true_and, Ty.cv_N, Bool.or_eq_true, beq_iff_eq,
      Bool.and_eq_true, decide_eq_true_eq]
    rcases hs with rfl | ⟨hm, hl⟩
    · exact .inl rfl
    · exact .inr ⟨Ty.cv_mono h _ hm, hl⟩
  | .int, .tvar _, hs | .int, .tat _ _, hs | .int, .box _ _ _, hs | .int, .prod _ _, hs | .int, .fn _ _, hs
  | .int, .opt _, hs | .int, .rvar _, hs | .int, .mu _ _, hs | .tvar _, .int, hs | .tvar _, .box _ _ _, hs
  | .tvar _, .prod _ _, hs | .tvar _, .fn _ _, hs | .tvar _, .opt _, hs | .tvar _, .rvar _, hs | .tvar _, .mu _ _, hs
  | .tat _ _, .int, hs | .tat _ _, .tvar _, hs | .tat _ _, .box _ _ _, hs | .tat _ _, .prod _ _, hs
  | .tat _ _, .fn _ _, hs | .tat _ _, .opt _, hs | .tat _ _, .rvar _, hs | .tat _ _, .mu _ _, hs
  | .box _ _ _, .int, hs | .box _ _ _, .tvar _, hs | .box _ _ _, .tat _ _, hs | .box _ _ _, .prod _ _, hs
  | .box _ _ _, .fn _ _, hs | .box _ _ _, .opt _, hs | .box _ _ _, .rvar _, hs | .box _ _ _, .mu _ _, hs
  | .prod _ _, .int, hs | .prod _ _, .tvar _, hs | .prod _ _, .tat _ _, hs | .prod _ _, .box _ _ _, hs
  | .prod _ _, .fn _ _, hs | .prod _ _, .opt _, hs | .prod _ _, .rvar _, hs | .prod _ _, .mu _ _, hs
  | .fn _ _, .int, hs | .fn _ _, .tvar _, hs | .fn _ _, .tat _ _, hs | .fn _ _, .box _ _ _, hs
  | .fn _ _, .prod _ _, hs | .fn _ _, .opt _, hs | .fn _ _, .rvar _, hs | .fn _ _, .mu _ _, hs | .opt _, .int, hs
  | .opt _, .tvar _, hs | .opt _, .tat _ _, hs | .opt _, .box _ _ _, hs | .opt _, .prod _ _, hs | .opt _, .fn _ _, hs
  | .opt _, .rvar _, hs | .opt _, .mu _ _, hs | .rvar _, .int, hs | .rvar _, .tvar _, hs | .rvar _, .tat _ _, hs
  | .rvar _, .box _ _ _, hs | .rvar _, .prod _ _, hs | .rvar _, .fn _ _, hs | .rvar _, .opt _, hs
  | .rvar _, .mu _ _, hs | .mu _ _, .int, hs | .mu _ _, .tvar _, hs | .mu _ _, .tat _ _, hs | .mu _ _, .box _ _ _, hs
  | .mu _ _, .prod _ _, hs | .mu _ _, .fn _ _, hs | .mu _ _, .opt _, hs | .mu _ _, .rvar _, hs | .iref _ _, .int, hs
  | .int, .iref _ _, hs | .iref _ _, .tvar _, hs | .tvar _, .iref _ _, hs | .iref _ _, .tat _ _, hs
  | .tat _ _, .iref _ _, hs | .iref _ _, .box _ _ _, hs | .box _ _ _, .iref _ _, hs | .iref _ _, .prod _ _, hs
  | .prod _ _, .iref _ _, hs | .iref _ _, .fn _ _, hs | .fn _ _, .iref _ _, hs | .iref _ _, .opt _, hs
  | .opt _, .iref _ _, hs | .iref _ _, .rvar _, hs | .rvar _, .iref _ _, hs | .iref _ _, .mu _ _, hs
  | .mu _ _, .iref _ _, hs => by simp [Ty.sub0] at hs

theorem Ty.sub_mono (h : KLE κ κ') {L : Nat} {a b : Ty} (hs : Ty.sub κ L a b = true) : Ty.sub κ' L a b = true := by
  have := Ty.sub0_mono h hs
  unfold Ty.sub; rw [Ty.N_N' h, Ty.N_N' h] at this; exact this

theorem Ty.rb_N {D : Nat} (hD : 1 ≤ D) (κ'' : List Kind) : ∀ x : Ty, x.rb D = true → (x.N κ'').rb D = true
  | .int, _ => rfl
  | .tvar i, _ => by unfold Ty.N; split <;> simp [Ty.rb]; omega
  | .tat i ρ, hx => by unfold Ty.N; split <;> simp_all [Ty.rb]; omega
  | .box m r t, hx => by simp [Ty.rb] at hx; simp [Ty.N, Ty.rb, hx.1, Ty.rb_N hD κ'' t hx.2]
  | .iref r t, hx => by simp [Ty.rb] at hx; simp [Ty.N, Ty.rb, hx.1, Ty.rb_N hD κ'' t hx.2]
  | .prod x y, hx => by simp [Ty.rb] at hx; simp [Ty.N, Ty.rb, Ty.rb_N hD κ'' x hx.1, Ty.rb_N hD κ'' y hx.2]
  | .fn _ _, _ => rfl
  | .opt t, hx => by simp [Ty.rb] at hx; simp [Ty.N, Ty.rb, Ty.rb_N hD κ'' t hx]
  | .rvar _, _ => rfl
  | .mu _ _, hx => by simpa [Ty.N, Ty.rb] using hx

theorem Ty.rbN_mono (h : KLE κ κ') {D : Nat} (hD : 1 ≤ D) {t : Ty} (ht : (t.N κ).rb D = true) : (t.N κ').rb D = true := by
  rw [← Ty.N_N' h]; exact Ty.rb_N hD κ' _ ht

theorem argsOkB_mono (h : KLE κ κ') {D : Nat} (hD : 1 ≤ D) {κ'' : List Kind} {ts : List Ty}
    (ha : argsOkB κ D κ'' ts = true) : argsOkB κ' D κ'' ts = true := by
  unfold argsOkB at ha ⊢
  simp only [Bool.and_eq_true, List.all_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at ha ⊢
  refine ⟨⟨fun s hs => Ty.rbN_mono h hD (ha.1.1 s hs), fun i hi => ⟨⟨?_, ?_⟩, ?_⟩⟩, ha.2⟩
  · rcases (ha.1.2 i hi).1.1 with h1 | h1
    · exact .inl h1
    · exact .inr (Ty.mf_mono h _ h1)
  · rcases (ha.1.2 i hi).1.2 with h1 | h1
    · exact .inl h1
    · exact .inr (Ty.rfK_mono h _ h1)
  · rcases (ha.1.2 i hi).2 with h1 | h1
    · exact .inl h1
    · exact .inr (Ty.cv_mono h _ h1)

/-- 型付けは kind について単調（推論した kind より強い kind を持つ型引数は、どれも受け取れる） -/
theorem HasType.kind_mono {Δ : List Def} (h : KLE κ κ') {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty}
    (hD : 1 ≤ D) (ht : HasType Δ κ D Γ e t) : HasType Δ κ' D Γ e t := by
  induction ht with
  | var hi => exact .var hi
  | lit => exact .lit
  | pair _ _ iha ihb => exact .pair (iha hD) (ihb hD)
  | fst _ ih => exact .fst (ih hD)
  | snd _ ih => exact .snd (ih hD)
  | letE _ _ ihe ihb => exact .letE (ihe hD) (ihb hD)
  | sub _ hs ih => exact .sub (ih hD) (Ty.sub_mono h hs)
  | alloc _ hrb ih => exact .alloc (ih hD) (Ty.rbN_mono h hD hrb)
  | read _ ih => exact .read (ih hD)
  | readR _ ih => exact .readR (ih hD)
  | write _ _ ihe ihv => exact .write (ihe hD) (ihv hD)
  | block _ hrb ih => exact .block (ih (by omega)) (Ty.rbN_mono h hD hrb)
  | call hg hargs ha _ ih =>
    exact .call hg (argsOkB_iff.mp (argsOkB_mono h hD (argsOkB_iff.mpr hargs))) ha (ih hD)
  | fnref hg hargs => exact .fnref hg (argsOkB_iff.mp (argsOkB_mono h hD (argsOkB_iff.mpr hargs)))
  | callv _ ha _ ihf ihe => exact .callv (ihf hD) ha (ihe hD)
  | onone => exact .onone
  | osome _ ih => exact .osome (ih hD)
  | case _ _ _ ih ih1 ih2 => exact .case (ih hD) (ih1 hD) (ih2 hD)
  | fold _ ih => exact .fold (ih hD)
  | unfold _ ih => exact .unfold (ih hD)
  | copy _ hm hk ih => exact .copy (ih hD) (Ty.mf_mono h _ hm) hk
  | view _ ih => exact .view (ih hD)

end Mono

/-! # 確認(3)の例: シグネチャの選び方に最良が無い場合

h[T](mut y box int, f func(T@0) T@0, x ?) ? { f(x) }。y は本体で使わないが、mut なので呼び出しの anchor を y の region に固定する。
- 選び方 A: x を T@0・anchor 0 の callv・戻り値 T@0（単相の規約と同じ形）
- 選び方 B: x を正確な T・anchor 1（フレーム）の callv・戻り値 T@1
A は呼び手の anchor（y の region）より深い x を受け取れない。B は戻り値を呼び手の最内に置くので、A より浅い region を返せない -/
namespace Ex3

def fT0 : Ty := .fn (.tat 0 0) (.tat 0 0)
def hA_P : Ty := .prod (.box true 0 .int) (.prod fT0 (.tat 0 0))
def hB_P : Ty := .prod (.box true 0 .int) (.prod fT0 (.tvar 0))
def hBody (a : Nat) : Expr := .callv a (.fst (.snd (.var 0))) (.snd (.snd (.var 0)))

theorem hA_typed (Δ : List Def) : HasType Δ [.C] 2 [hA_P] (hBody 0) (.tat 0 0) :=
  .callv (p := .tat 0 0) (q := .tat 0 0) (.fst (.snd (.var rfl))) (by omega) (.snd (.snd (.var rfl)))

theorem hB_typed (Δ : List Def) : HasType Δ [.C] 2 [hB_P] (hBody 1) (.tat 0 1) :=
  .callv (p := .tat 0 0) (q := .tat 0 0) (.fst (.snd (.var rfl))) (by omega) (.sub (.snd (.snd (.var rfl))) (by decide))

/-- 呼び手1（深さ 3・y は region 0・x は region 2）: A は anchor が 0 に固定され、x（region 2）は T@0 の部分型にならない。
B は型引数を x の型そのものにして受け取れる -/
theorem caller1_A_core (c : Nat) : csub (.box false 2 .int) ((Ty.box false c .int).at 0) = false := by simp [Ty.at, Ty.sub0]
theorem caller1_B_core : csub (.box false 2 .int) (Ty.box false 2 .int) = true := by decide

/-- 呼び手2（深さ 3・y は region 1・x は region 0。結果を region 2 未満に出したい）: A は anchor 1 で結果が region 1、
B は結果が呼び手の最内（region 2）に固定される -/
theorem caller2_A_core (c : Nat) : (((Ty.tat 0 0).ren 1 1).tsubst [.box false c .int]).rb 2 = true := by simp [Ty.ren, Ty.tsubst, rmap, look, Ty.at, Ty.rb]
theorem caller2_B_core (c a : Nat) : (((Ty.tat 0 1).ren a 1).tsubst [.box false c .int]).rb 2 = false := by
  simp [Ty.ren, Ty.tsubst, rmap, look, Ty.at, Ty.rb]

/-- 単相の関数にも同じ2つの選び方がある（T = imm box int を展開した形。x を region 0 にして anchor 0 か、x をフレームにして anchor 1 か）。
つまり、選び方が比べられないのはジェネリックに固有ではなく、単相の region の推論にもともとある -/
def bI0 : Ty := .box false 0 .int
def mA_P : Ty := .prod (.box true 0 .int) (.prod (.fn bI0 bI0) bI0)
def mB_P : Ty := .prod (.box true 0 .int) (.prod (.fn bI0 bI0) (.box false 1 .int))
theorem mA_typed (Δ : List Def) : HasType Δ [] 2 [mA_P] (hBody 0) bI0 :=
  .callv (p := bI0) (q := bI0) (.fst (.snd (.var rfl))) (by omega) (.snd (.snd (.var rfl)))
theorem mB_typed (Δ : List Def) : HasType Δ [] 2 [mB_P] (hBody 1) (.box false 1 .int) :=
  .callv (p := bI0) (q := bI0) (.fst (.snd (.var rfl))) (by omega) (.snd (.snd (.var rfl)))

end Ex3

/-! # 正確な T を使わない形: ジェネリックの規則 = 展開した単相の規則を kind の下で一度に検査するもの -/

/-- 閉じた型で実現できる旗の組: region を持たないなら深く共変、深く共変なら mut を持たない -/
def Kind.wf (k : Kind) : Bool := (!k.rf || k.cov) && (!k.cov || k.mf)

/-- kind ごとの代表の閉じた型（imm の ref の中身が region を持つ型が、mut を持たないが共変でない代表） -/
def Kind.witness (k : Kind) : Ty :=
  if k.rf then .int else if k.cov then .box false 0 .int else if k.mf then .iref 0 (.box false 0 .int) else .box true 0 .int

theorem kindOfTy_witness : ∀ k : Kind, k.wf = true → kindOfTy k.witness = k
  | ⟨rf, mf, cov⟩, h => by
    cases rf <;> cases mf <;> cases cov <;> simp_all [Kind.wf, Kind.witness] <;> rfl

theorem Real.witness (κ : List Kind) (hw : ∀ k ∈ κ, k.wf = true) : Real κ (κ.map Kind.witness) := by
  refine ⟨?_, fun s hs => ?_, fun s hs => ?_⟩
  · rw [List.map_map]; conv => lhs; rw [← List.map_id κ]
    exact List.map_congr_left (fun k hk => by simp [kindOfTy_witness k (hw k hk)])
  · obtain ⟨⟨rf, mf, cov⟩, -, rfl⟩ := List.mem_map.mp hs; cases rf <;> cases mf <;> cases cov <;> rfl
  · obtain ⟨⟨rf, mf, cov⟩, -, rfl⟩ := List.mem_map.mp hs; cases rf <;> cases mf <;> cases cov <;> rfl

theorem KLE.refl (κ : List Kind) : KLE κ κ := fun i => by simp [Kind.le]

/-- 正確な T を使わない（注釈が T@ρ だけの）項について: κ の下でジェネリックの規則で型付く ⇔
κ 以上の性質を持つどの閉じた型引数 σ で展開しても、単相の規則で型付く。κ の旗は閉じた型で実現できる組（Kind.wf） -/
theorem generic_iff_all_expand {Δ : List Def} {κ : List Kind} {n D : Nat} {Γ : List Ty} {e : Expr} {t : Ty}
    (hn : κ.length = n) (hD : 1 ≤ D) (hΓ : ∀ s ∈ Γ, s.ok n = true) (he : e.ok n = true) (ht : t.ok n = true)
    (hshape : HasType Δ (κrf n) D Γ e t) (hw : ∀ k ∈ κ, k.wf = true) :
    HasType Δ κ D Γ e t ↔
      ∀ σ : List Ty, σ.length = n → (∀ s ∈ σ, s.closed = true) → (∀ s ∈ σ, s.rc 0 = true) → KLE κ (σ.map kindOfTy) →
        HasType Δ [] D (Γ.map (Ty.tsubst · σ)) (e.tsubstE σ) (t.tsubst σ) := by
  constructor
  · intro hg σ hl hc hrc hk
    have hR : Real (σ.map kindOfTy) σ := ⟨rfl, hc, hrc⟩
    subst hl
    exact (expand_iff hR hD hΓ he ht hshape).mpr (hg.kind_mono hk hD)
  · intro hall
    have hR := Real.witness κ hw
    have hl : (κ.map Kind.witness).length = n := by simp [hn]
    have hm := hall _ hl hR.2.1 hR.2.2 (by rw [← hR.1]; exact KLE.refl κ)
    rw [← hl] at hΓ he ht hshape
    have := (expand_iff hR hD hΓ he ht hshape).mp hm
    exact this

namespace Ex4

/-- 正確な T を使わない apply: x は T@0、f(x) は anchor 1（フレーム）で呼び、戻り値は T@1 -/
def applyP : Ty := .prod (.fn (.tat 0 0) (.tat 0 1)) (.tat 0 0)
theorem apply_typed (Δ : List Def) : HasType Δ [.C] 2 [applyP] (.callv 1 (.fst (.var 0)) (.snd (.var 0))) (.tat 0 1) :=
  .callv (p := .tat 0 0) (q := .tat 0 1) (.fst (.var rfl)) (by omega) (.sub (.snd (.var rfl)) (by decide))

/-- first: 中身を T@0 で返す -/
theorem first_typed (Δ : List Def) : HasType Δ [.C] 2 [.box false 0 (.tat 0 0)] (.read (.var 0)) (.tat 0 0) :=
  .read (.var rfl)

/-- push（mut の box に f(x) を書く）: mut を持たない T では型付かない（f(x) は T@1、セルは T@0 で、T@1 ≤ T@0 にならない） -/
theorem push_core : Ty.sub [.C] 1 (.tat 0 1) (.tat 0 0) = false := by decide
/-- region を持たない T（int など）なら書ける。展開しても同じ（int の値はどこへでも書ける） -/
theorem push_rf_core : Ty.sub [.R] 1 (.tat 0 1) (.tat 0 0) = true := by decide

end Ex4

/-! # 型引数が2つ以上でも、推論した kind は1つに決まる: 2つの kind の列で型付くなら、添字ごとに弱い方をとった列でも型付く -/

def Kind.meet (a b : Kind) : Kind := ⟨a.rf && b.rf, a.mf && b.mf, a.cov && b.cov⟩

def meetL (κ1 κ2 : List Kind) : List Kind :=
  (List.range (max κ1.length κ2.length)).map (fun i => Kind.meet (kindOf κ1 i) (kindOf κ2 i))

theorem kindOf_meetL (κ1 κ2 : List Kind) (i : Nat) : kindOf (meetL κ1 κ2) i = Kind.meet (kindOf κ1 i) (kindOf κ2 i) := by
  unfold kindOf meetL
  rcases Nat.lt_or_ge i (max κ1.length κ2.length) with h | h
  · simp [List.getD_eq_getElem?_getD, h, kindOf]
  · have h1 : κ1.length ≤ i := by omega
    have h2 : κ2.length ≤ i := by omega
    simp [List.getD_eq_getElem?_getD, List.getElem?_eq_none h1, List.getElem?_eq_none h2, Kind.meet, Kind.O]
    rw [List.getElem?_eq_none (by simp; omega)]; rfl

section Meet
variable {κ1 κ2 : List Kind}

theorem kindRF_meet (i : Nat) : kindRF (meetL κ1 κ2) i = (kindRF κ1 i && kindRF κ2 i) := by
  simp only [kindRF, kindOf_meetL, Kind.meet]

theorem kindMut_meet (i : Nat) : kindMut (meetL κ1 κ2) i = (kindMut κ1 i || kindMut κ2 i) := by
  simp only [kindMut, kindOf_meetL, Kind.meet]; cases (kindOf κ1 i).mf <;> cases (kindOf κ2 i).mf <;> rfl

theorem kindCov_meet (i : Nat) : kindCov (meetL κ1 κ2) i = (kindCov κ1 i && kindCov κ2 i) := by
  simp only [kindCov, kindOf_meetL, Kind.meet]

/-- kind の列のどの kind も、閉じた型で実現できる旗の組 -/
def KWF (κ : List Kind) : Prop := ∀ i, (kindOf κ i).wf = true

theorem KWF.rf_cov {κ : List Kind} (h : KWF κ) {i : Nat} (hr : kindRF κ i = true) : kindCov κ i = true := by
  have := h i; simp only [Kind.wf, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at this
  simp only [kindRF, kindCov] at hr ⊢; rcases this.1 with h1 | h1
  · rw [hr] at h1; cases h1
  · exact h1

theorem Ty.N_tat (κ : List Kind) (i ρ : Nat) : (Ty.tat i ρ).N κ = if kindRF κ i then .tat i 0 else .tat i ρ := rfl

theorem Ty.sub_tat (κ : List Kind) (L i j ρ ρ' : Nat) :
    Ty.sub κ L (.tat i ρ) (.tat j ρ') = (i == j && (kindRF κ i || ρ == ρ' || (kindCov κ i && decide (ρ ≤ ρ')))) := by
  unfold Ty.sub
  by_cases hi : i = j
  · subst hi
    by_cases h : kindRF κ i
    · simp [Ty.N, h, Ty.sub0]
    · simp [Ty.N, h, Ty.sub0]
  · have hb : (i == j) = false := by simp [hi]
    by_cases h1 : kindRF κ i <;> by_cases h2 : kindRF κ j <;> simp [Ty.N, h1, h2, Ty.sub0, hb]

theorem Ty.mf_meet : ∀ t : Ty, t.mf κ1 = true → t.mf κ2 = true → t.mf (meetL κ1 κ2) = true
  | .int, _, _ => rfl
  | .tvar i, h1, h2 => by simp [Ty.mf, kindMut_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .tat i _, h1, h2 => by simp [Ty.mf, kindMut_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .box m r x, h1, h2 => by simp [Ty.mf] at h1 h2 ⊢; exact ⟨h1.1, Ty.mf_meet x h1.2 h2.2⟩
  | .iref r x, h1, h2 => by simp [Ty.mf] at h1 h2 ⊢; exact Ty.mf_meet x h1 h2
  | .prod x y, h1, h2 => by simp [Ty.mf] at h1 h2 ⊢; exact ⟨Ty.mf_meet x h1.1 h2.1, Ty.mf_meet y h1.2 h2.2⟩
  | .fn _ _, _, _ => rfl
  | .opt t, h1, h2 => by simp [Ty.mf] at h1 h2 ⊢; exact Ty.mf_meet t h1 h2
  | .rvar _, _, _ => rfl
  | .mu _ b, h1, h2 => by simp [Ty.mf] at h1 h2 ⊢; exact Ty.mf_meet b h1 h2

theorem Ty.rfK_meet : ∀ t : Ty, t.rfK κ1 = true → t.rfK κ2 = true → t.rfK (meetL κ1 κ2) = true
  | .int, _, _ => rfl
  | .tvar i, h1, h2 => by simp [Ty.rfK, kindRF_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .tat i _, h1, h2 => by simp [Ty.rfK, kindRF_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .box _ _ _, h1, _ => h1
  | .iref _ _, h1, _ => h1
  | .prod x y, h1, h2 => by simp [Ty.rfK] at h1 h2 ⊢; exact ⟨Ty.rfK_meet x h1.1 h2.1, Ty.rfK_meet y h1.2 h2.2⟩
  | .fn _ _, _, _ => rfl
  | .opt t, h1, h2 => by simp [Ty.rfK] at h1 h2 ⊢; exact Ty.rfK_meet t h1 h2
  | .rvar _, _, _ => rfl
  | .mu _ _, h1, _ => h1

theorem Ty.cv_meet : ∀ t : Ty, t.cv κ1 = true → t.cv κ2 = true → t.cv (meetL κ1 κ2) = true
  | .int, _, _ => rfl
  | .tvar i, h1, h2 => by simp [Ty.cv, kindCov_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .tat i _, h1, h2 => by simp [Ty.cv, kindCov_meet] at h1 h2 ⊢; exact ⟨h1, h2⟩
  | .box m r x, h1, h2 => by simp [Ty.cv] at h1 h2 ⊢; exact ⟨h1.1, Ty.cv_meet x h1.2 h2.2⟩
  | .iref r x, h1, h2 => by simp [Ty.cv] at h1 h2 ⊢; exact ⟨Ty.rfK_meet x h1.1 h2.1, h1.2⟩
  | .prod x y, h1, h2 => by simp [Ty.cv] at h1 h2 ⊢; exact ⟨Ty.cv_meet x h1.1 h2.1, Ty.cv_meet y h1.2 h2.2⟩
  | .fn _ _, _, _ => rfl
  | .opt t, h1, h2 => by simp [Ty.cv] at h1 h2 ⊢; exact Ty.cv_meet t h1 h2
  | .rvar _, _, _ => rfl
  | .mu _ b, h1, h2 => by simp [Ty.cv] at h1 h2 ⊢; exact Ty.cv_meet b h1 h2

theorem Ty.Neq_meet : ∀ (a b : Ty), a.ok n = true → b.ok n = true → a.N κ1 = b.N κ1 → a.N κ2 = b.N κ2 →
    a.N (meetL κ1 κ2) = b.N (meetL κ1 κ2)
  | .int, b, _, hb, h1, _ => by
    cases b with
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | _ => simp_all [Ty.N, Ty.ok]
  | .tvar _, _, ha, _, _, _ => by simp [Ty.ok] at ha
  | .tat i ρ, b, _, hb, h1, h2 => by
    cases b with
    | tat j ρ' =>
      simp only [Ty.N_tat, kindRF_meet] at h1 h2 ⊢
      by_cases r1 : kindRF κ1 i <;> by_cases r1' : kindRF κ1 j <;> by_cases r2 : kindRF κ2 i <;> by_cases r2' : kindRF κ2 j <;>
        simp_all
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
  | .box m r x, b, ha, hb, h1, h2 => by
    cases b with
    | box m' r' y =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢
      exact ⟨h1.1, h1.2.1, Ty.Neq_meet x y ha hb h1.2.2 h2.2.2⟩
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1
  | .iref r x, b, ha, hb, h1, h2 => by
    cases b with
    | iref r' y =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢
      exact ⟨h1.1, Ty.Neq_meet x y ha hb h1.2 h2.2⟩
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1
  | .prod x y, b, ha, hb, h1, h2 => by
    cases b with
    | prod x' y' =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢
      exact ⟨Ty.Neq_meet x x' ha.1 hb.1 h1.1 h2.1, Ty.Neq_meet y y' ha.2 hb.2 h1.2 h2.2⟩
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1
  | .fn p q, b, ha, hb, h1, h2 => by
    cases b with
    | fn p' q' =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢
      exact ⟨Ty.Neq_meet p p' ha.1 hb.1 h1.1 h2.1, Ty.Neq_meet q q' ha.2 hb.2 h1.2 h2.2⟩
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1

  | .opt x, b, ha, hb, h1, h2 => by
    cases b with
    | opt y =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢; exact Ty.Neq_meet x y ha hb h1 h2
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1
  | .rvar i, b, _, hb, h1, _ => by
    cases b with
    | rvar j => simp [Ty.N] at h1 ⊢; exact h1
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1
  | .mu r x, b, ha, hb, h1, h2 => by
    cases b with
    | mu r' y =>
      simp [Ty.ok] at ha hb; simp [Ty.N] at h1 h2 ⊢
      exact ⟨h1.1, Ty.Neq_meet x y ha hb h1.2 h2.2⟩
    | tat j ρ => simp [Ty.N_tat] at h1; split at h1 <;> cases h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => simp [Ty.N] at h1

theorem Ty.sub_meet {L : Nat} (hw1 : KWF κ1) (hw2 : KWF κ2) : ∀ (a b : Ty), a.ok n = true → b.ok n = true → Ty.sub κ1 L a b = true → Ty.sub κ2 L a b = true →
    Ty.sub (meetL κ1 κ2) L a b = true
  | .int, b, _, hb, h1, _ => by
    cases b with
    | tat j ρ => unfold Ty.sub at h1; rw [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | _ => simp_all [Ty.sub, Ty.N, Ty.ok, Ty.sub0]
  | .tvar _, _, ha, _, _, _ => by simp [Ty.ok] at ha
  | .tat i ρ, b, _, hb, h1, h2 => by
    cases b with
    | tat j ρ' =>
      rw [Ty.sub_tat] at h1 h2 ⊢; rw [kindRF_meet, kindCov_meet]
      have q1 := @KWF.rf_cov κ1 hw1 i; have q2 := @KWF.rf_cov κ2 hw2 i
      cases r1 : kindRF κ1 i <;> cases r2 : kindRF κ2 i <;> cases m1 : kindCov κ1 i <;>
        cases m2 : kindCov κ2 i <;> simp_all <;> omega
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
  | .box m r x, b, ha, hb, h1, h2 => by
    cases b with
    | box m' r' y =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢
      cases m <;> cases m' <;> simp [Ty.N, Ty.sub0] at h1 h2 ⊢
      · exact ⟨h1.1, Ty.sub_meet hw1 hw2 x y ha hb h1.2 h2.2⟩
      · exact ⟨h1.1, Ty.Neq_meet x y ha hb h1.2 h2.2⟩
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1
  | .iref r x, b, ha, hb, h1, h2 => by
    cases b with
    | iref r' y =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢; simp [Ty.N, Ty.sub0] at h1 h2 ⊢
      exact ⟨h1.1, Ty.Neq_meet x y ha hb h1.2 h2.2⟩
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1
  | .prod x y, b, ha, hb, h1, h2 => by
    cases b with
    | prod x' y' =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢; simp [Ty.N, Ty.sub0] at h1 h2 ⊢
      exact ⟨Ty.sub_meet hw1 hw2 x x' ha.1 hb.1 h1.1 h2.1, Ty.sub_meet hw1 hw2 y y' ha.2 hb.2 h1.2 h2.2⟩
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1
  | .fn p q, b, ha, hb, h1, h2 => by
    cases b with
    | fn p' q' =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢; simp [Ty.N, Ty.sub0] at h1 h2 ⊢
      exact ⟨Ty.Neq_meet p p' ha.1 hb.1 h1.1 h2.1, Ty.Neq_meet q q' ha.2 hb.2 h1.2 h2.2⟩
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1

  | .opt x, b, ha, hb, h1, h2 => by
    cases b with
    | opt y =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢; simp [Ty.N, Ty.sub0] at h1 h2 ⊢
      exact Ty.sub_meet hw1 hw2 x y ha hb h1 h2
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1
  | .rvar i, b, _, hb, h1, _ => by
    cases b with
    | rvar j => unfold Ty.sub at h1 ⊢; simp [Ty.N, Ty.sub0] at h1 ⊢; exact h1
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1
  | .mu r x, b, ha, hb, h1, h2 => by
    cases b with
    | mu r' y =>
      simp [Ty.ok] at ha hb
      unfold Ty.sub at h1 h2 ⊢; simp [Ty.N, Ty.sub0, Ty.cv_N] at h1 h2 ⊢
      refine ⟨Ty.Neq_meet x y ha hb h1.1 h2.1, ?_⟩
      rcases h1.2 with e | ⟨m1, l1⟩
      · exact .inl e
      · rcases h2.2 with e | ⟨m2, _⟩
        · exact .inl e
        · exact .inr ⟨Ty.cv_meet x m1 m2, l1⟩
    | tat j ρ => unfold Ty.sub at h1; simp [Ty.N_tat] at h1; split at h1 <;> simp [Ty.N, Ty.sub0] at h1
    | tvar _ => simp [Ty.ok] at hb
    | _ => unfold Ty.sub at h1; simp [Ty.N, Ty.sub0] at h1

theorem Ty.rbN_meet {D : Nat} : ∀ t : Ty, t.ok n = true → (t.N κ1).rb D = true → (t.N κ2).rb D = true →
    (t.N (meetL κ1 κ2)).rb D = true
  | .int, _, _, _ => rfl
  | .tvar _, ha, _, _ => by simp [Ty.ok] at ha
  | .tat i ρ, _, h1, h2 => by
    simp only [Ty.N_tat, kindRF_meet] at h1 h2 ⊢
    by_cases r1 : kindRF κ1 i <;> by_cases r2 : kindRF κ2 i <;> simp_all
  | .box m r x, ha, h1, h2 => by
    simp [Ty.ok] at ha; simp [Ty.N, Ty.rb] at h1 h2 ⊢; exact ⟨h1.1, Ty.rbN_meet x ha h1.2 h2.2⟩
  | .iref r x, ha, h1, h2 => by
    simp [Ty.ok] at ha; simp [Ty.N, Ty.rb] at h1 h2 ⊢; exact ⟨h1.1, Ty.rbN_meet x ha h1.2 h2.2⟩
  | .prod x y, ha, h1, h2 => by
    simp [Ty.ok] at ha; simp [Ty.N, Ty.rb] at h1 h2 ⊢
    exact ⟨Ty.rbN_meet x ha.1 h1.1 h2.1, Ty.rbN_meet y ha.2 h1.2 h2.2⟩
  | .fn _ _, _, _, _ => rfl
  | .opt t, ha, h1, h2 => by
    simp [Ty.ok] at ha; simp [Ty.N, Ty.rb] at h1 h2 ⊢; exact Ty.rbN_meet t ha h1 h2
  | .rvar _, _, _, _ => rfl
  | .mu _ _, _, h1, _ => by simpa [Ty.N, Ty.rb] using h1

theorem argsOkB_meet {D : Nat} {κ' : List Kind} {ts : List Ty} (hts : ∀ s ∈ ts, s.ok n = true)
    (h1 : argsOkB κ1 D κ' ts = true) (h2 : argsOkB κ2 D κ' ts = true) : argsOkB (meetL κ1 κ2) D κ' ts = true := by
  unfold argsOkB at h1 h2 ⊢
  simp only [Bool.and_eq_true, List.all_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h1 h2 ⊢
  refine ⟨⟨fun s hs => Ty.rbN_meet s (hts s hs) (h1.1.1 s hs) (h2.1.1 s hs), fun i hi => ⟨⟨?_, ?_⟩, ?_⟩⟩, h1.2⟩
  · rcases (h1.1.2 i hi).1.1 with a | a
    · exact .inl a
    · rcases (h2.1.2 i hi).1.1 with b | b
      · exact .inl b
      · exact .inr (Ty.mf_meet _ a b)
  · rcases (h1.1.2 i hi).1.2 with a | a
    · exact .inl a
    · rcases (h2.1.2 i hi).1.2 with b | b
      · exact .inl b
      · exact .inr (Ty.rfK_meet _ a b)
  · rcases (h1.1.2 i hi).2 with a | a
    · exact .inl a
    · rcases (h2.1.2 i hi).2 with b | b
      · exact .inl b
      · exact .inr (Ty.cv_meet _ a b)

end Meet

theorem ite_cond {b : Bool} {x : Option Ty} {y : Ty} (h : (if b = true then x else none) = some y) : b = true := by
  cases b <;> simp_all

section Meet2
variable {Δ : List Def} {κ1 κ2 : List Kind} {n : Nat}

theorem check_meet (hw1 : KWF κ1) (hw2 : KWF κ2) : ∀ {D : Nat} {Γ : List Ty} {e : Expr} {t1 t2 : Ty},
    (∀ s ∈ Γ, s.ok n = true) → e.ok n = true →
    check Δ κ1 D Γ e = some t1 → check Δ κ2 D Γ e = some t2 → check Δ (meetL κ1 κ2) D Γ e = some t1 := by
  intro D Γ e
  induction e generalizing D Γ with
  | var i => intro t1 t2 _ _ h1 _; exact h1
  | lit _ => intro t1 t2 _ _ h1 _; exact h1
  | pair a b iha ihb =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    split at h1 <;> simp at h1; split at h2 <;> simp at h2
    rename_i a1 b1 ha1 hb1 _ _ a2 b2 ha2 hb2
    subst h1; simp [check, iha hΓ he.1 ha1 ha2, ihb hΓ he.2 hb1 hb2]
  | fst e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    split at h1 <;> simp at h1; split at h2 <;> simp at h2
    rename_i a1 b1 he1 _ a2 b2 he2
    subst h1; simp [check, ih hΓ he he1 he2]
  | snd e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    split at h1 <;> simp at h1; split at h2 <;> simp at h2
    rename_i a1 b1 he1 _ a2 b2 he2
    subst h1; simp [check, ih hΓ he he1 he2]
  | letE e b ihe ihb =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
        have := check_kind_indep hc1 hc2; subst this
        simp only [check, hc1] at h1; simp only [check, hc2] at h2
        have hok := check_ok hΓ he.1 hc1
        simp only [check, ihe hΓ he.1 hc1 hc2]
        exact ihb (fun s hs => by simp at hs; rcases hs with rfl | hs; exact hok; exact hΓ s hs) he.2 h1 h2
  | alloc m t e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
        have := check_kind_indep hc1 hc2; subst this
        simp only [check, hc1] at h1; simp only [check, hc2] at h2
        have c1 : (Ty.sub κ1 1 u1 t && (t.N κ1).rb D) = true := ite_cond h1
        have c2 : (Ty.sub κ2 1 u1 t && (t.N κ2).rb D) = true := ite_cond h2
        rw [c1] at h1; simp at c1 c2
        have hok := check_ok hΓ he.2 hc1
        simp only [check, ih hΓ he.2 hc1 hc2, Ty.sub_meet hw1 hw2 _ _ hok he.1 c1.1 c2.1, Ty.rbN_meet _ he.1 c1.2 c2.2]
        simpa using h1
  | read e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    cases c1 : check Δ κ1 D Γ e with
    | none => simp [c1] at h1
    | some u1 =>
      cases c2 : check Δ κ2 D Γ e with
      | none => simp [c2] at h2
      | some u2 => simp only [check, ih hΓ he c1 c2]; simp only [c1] at h1; exact h1
  | write e v ihe ihv =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    split at h1 <;> simp at h1; split at h2 <;> simp at h2
    rename_i r1 a1 tv1 he1 hv1 _ _ r2 a2 tv2 he2 hv2
    have e1 := check_kind_indep he1 he2; simp at e1; obtain ⟨rfl, rfl⟩ := e1
    have e2 := check_kind_indep hv1 hv2; subst e2
    have hok1 := check_ok hΓ he.1 he1; simp [Ty.ok] at hok1
    have hok2 := check_ok hΓ he.2 hv1
    simp [check, ihe hΓ he.1 he1 he2, ihv hΓ he.2 hv1 hv2, Ty.sub_meet hw1 hw2 _ _ hok2 hok1 h1.1 h2.1, ← h1.2]
  | block e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hc1 : check Δ κ1 (D + 1) Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 (D + 1) Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
        have := check_kind_indep hc1 hc2; subst this
        simp only [check, hc1] at h1; simp only [check, hc2] at h2
        have c1 : (u1.N κ1).rb D = true := ite_cond h1
        have c2 : (u1.N κ2).rb D = true := ite_cond h2
        rw [c1] at h1
        have hok := check_ok hΓ he hc1
        simp only [check, ih hΓ he hc1 hc2, Ty.rbN_meet _ hok c1 c2]
        simpa using h1
  | call g ts a e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hg : Δ[g]? with
    | none => simp [check, hg] at h1
    | some d1 =>
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hg, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hg, hc2] at h2
      | some u2 =>
        have := check_kind_indep hc1 hc2; subst this
        simp only [check, hg, hc1] at h1; simp only [check, hg, hc2] at h2
        have c1 : (argsOkB κ1 D d1.κ ts && decide (a + 1 ≤ D) && Ty.sub κ1 1 u1 ((d1.p.ren a (D - 2)).tsubst ts)) = true := ite_cond h1
        have c2 : (argsOkB κ2 D d1.κ ts && decide (a + 1 ≤ D) && Ty.sub κ2 1 u1 ((d1.p.ren a (D - 2)).tsubst ts)) = true := ite_cond h2
        rw [c1] at h1; simp only [Bool.and_eq_true] at c1 c2
        have hts : ∀ s ∈ ts, s.ok n = true := fun s hs => by simpa using he.1 s hs
        have hok := check_ok hΓ he.2 hc1
        have hpok : ((d1.p.ren a (D - 2)).tsubst ts).ok n = true := Ty.ok_tsubst _ _ hts
        simp only [check, hg, ih hΓ he.2 hc1 hc2, argsOkB_meet hts c1.1.1 c2.1.1, c1.1.2,
          Ty.sub_meet hw1 hw2 _ _ hok hpok c1.2 c2.2, Bool.and_self, if_true]
        simpa using h1
  | fnref g ts =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hg : Δ[g]? with
    | none => simp [check, hg] at h1
    | some d1 =>
      simp only [check, hg] at h1 h2
      have hts : ∀ s ∈ ts, s.ok n = true := fun s hs => by simpa using he s hs
      have c1 := ite_cond h1; have c2 := ite_cond h2
      simp only [check, hg, argsOkB_meet hts c1 c2, if_true]
      rw [c1] at h1; simpa using h1
  | callv a ef e ihf ihe =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ ef with
    | none => simp [check, hc1] at h1
    | some f1 =>
    cases hc2 : check Δ κ2 D Γ ef with
    | none => simp [check, hc2] at h2
    | some f2 =>
    have := check_kind_indep hc1 hc2; subst this
    cases f1 with
    | fn p q =>
      cases he1 : check Δ κ1 D Γ e with
      | none => simp [check, hc1, he1] at h1
      | some u1 =>
      cases he2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2, he2] at h2
      | some u2 =>
      have := check_kind_indep he1 he2; subst this
      simp only [check, hc1, he1] at h1; simp only [check, hc2, he2] at h2
      have c1 := ite_cond h1; have c2 := ite_cond h2
      simp only [Bool.and_eq_true] at c1 c2
      have hfok := check_ok hΓ he.1 hc1; simp [Ty.ok] at hfok
      have hok := check_ok hΓ he.2 he1
      have hpl : (p.lowTv.ren a (D - 2)).ok n = true := by rw [Ty.ok_ren, Ty.lowTv_of_ok p hfok.1]; exact hfok.1
      simp only [check, ihf hΓ he.1 hc1 hc2, ihe hΓ he.2 he1 he2, c1.1, Ty.sub_meet hw1 hw2 _ _ hok hpl c1.2 c2.2,
        Bool.and_self, if_true]
      have c1' : (decide (a + 1 ≤ D) && Ty.sub κ1 1 u1 (p.lowTv.ren a (D - 2))) = true := by simp [c1.1, c1.2]
      rw [c1'] at h1; simpa using h1
    | _ => simp [check, hc1] at h1
  | onone t0 => intro t1 t2 _ _ h1 _; simpa [check] using h1
  | osome e ih =>
    intro t1 t2 hΓ he h1 h2; simp only [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
        simp only [check, hc1] at h1
        simp only [check, ih hΓ he hc1 hc2]; exact h1
  | case t0 e e1 e2 ih ih1 ih2 =>
    intro t1 t2 hΓ he h1 h2; simp only [Expr.ok, Bool.and_eq_true] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
    cases hc2 : check Δ κ2 D Γ e with
    | none => simp [check, hc2] at h2
    | some u2 =>
    have := check_kind_indep hc1 hc2; subst this
    cases u1 with
    | opt a =>
      have hok0 := check_ok hΓ he.1.1.2 hc1; simp [Ty.ok] at hok0
      have hΓ' : ∀ s ∈ a :: Γ, s.ok n = true := fun s hs => by
        simp at hs; rcases hs with rfl | hs; exact hok0; exact hΓ s hs
      cases g1 : check Δ κ1 D Γ e1 with
      | none => simp [check, hc1, g1] at h1
      | some v1 =>
      cases g2 : check Δ κ2 D Γ e1 with
      | none => simp [check, hc2, g2] at h2
      | some v2 =>
      have := check_kind_indep g1 g2; subst this
      cases k1 : check Δ κ1 D (a :: Γ) e2 with
      | none => simp [check, hc1, g1, k1] at h1
      | some w1 =>
      cases k2 : check Δ κ2 D (a :: Γ) e2 with
      | none => simp [check, hc2, g2, k2] at h2
      | some w2 =>
      have := check_kind_indep k1 k2; subst this
      simp only [check, hc1, g1, k1] at h1; simp only [check, hc2, g2, k2] at h2
      have c1 := ite_cond h1; have c2 := ite_cond h2
      simp only [Bool.and_eq_true] at c1 c2
      have hok1 := check_ok hΓ he.1.2 g1; have hok2 := check_ok hΓ' he.2 k1
      simp only [check, ih hΓ he.1.1.2 hc1 hc2, ih1 hΓ he.1.2 g1 g2, ih2 hΓ' he.2 k1 k2,
        Ty.sub_meet hw1 hw2 _ _ hok1 he.1.1.1 c1.1 c2.1, Ty.sub_meet hw1 hw2 _ _ hok2 he.1.1.1 c1.2 c2.2, Bool.and_self, if_true]
      have c1' : (Ty.sub κ1 1 v1 t0 && Ty.sub κ1 1 w1 t0) = true := by simp [c1.1, c1.2]
      rw [c1'] at h1; simpa using h1
    | _ => simp [check, hc1] at h1
  | fold t0 e ih =>
    intro t1 t2 hΓ he h1 h2; simp only [Expr.ok, Bool.and_eq_true] at he
    cases t0 with
    | mu r b =>
      cases hc1 : check Δ κ1 D Γ e with
      | none => simp [check, hc1] at h1
      | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
      have := check_kind_indep hc1 hc2; subst this
      simp only [check, hc1] at h1; simp only [check, hc2] at h2
      have c1 := ite_cond h1; have c2 := ite_cond h2
      have hok := check_ok hΓ he.2 hc1
      have hbok : b.ok n = true := by simpa [Ty.ok] using he.1
      simp only [check, ih hΓ he.2 hc1 hc2, Ty.sub_meet hw1 hw2 _ _ hok (Ty.ok_unf hbok) c1 c2, if_true]
      rw [c1] at h1; simpa using h1
    | _ => simp [check] at h1
  | unfold e ih =>
    intro t1 t2 hΓ he h1 h2; simp only [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
    cases hc2 : check Δ κ2 D Γ e with
    | none => simp [check, hc2] at h2
    | some u2 =>
    simp only [check, ih hΓ he hc1 hc2]; simp only [check, hc1] at h1; exact h1
  | copy k e ih =>
    intro t1 t2 hΓ he h1 h2; simp only [Expr.ok] at he
    cases hc1 : check Δ κ1 D Γ e with
    | none => simp [check, hc1] at h1
    | some u1 =>
      cases hc2 : check Δ κ2 D Γ e with
      | none => simp [check, hc2] at h2
      | some u2 =>
        have := check_kind_indep hc1 hc2; subst this
        simp only [check, hc1] at h1; simp only [check, hc2] at h2
        have c1 := ite_cond h1; have c2 := ite_cond h2
        simp only [Bool.and_eq_true] at c1 c2
        simp only [check, ih hΓ he hc1 hc2, Ty.mf_meet _ c1.1 c2.1, c1.2, Bool.and_self, if_true]
        have c1' : (u1.mf κ1 && decide (k + 1 ≤ D)) = true := by simp [c1.1, c1.2]
        rw [c1'] at h1; simpa using h1
  | view e ih =>
    intro t1 t2 hΓ he h1 h2; simp [Expr.ok] at he; simp only [check] at h1 h2
    cases c1 : check Δ κ1 D Γ e with
    | none => simp [c1] at h1
    | some u1 =>
      cases c2 : check Δ κ2 D Γ e with
      | none => simp [c2] at h2
      | some u2 => simp only [check, ih hΓ he c1 c2]; simp only [c1] at h1; exact h1

/-- 推論した kind は1つに決まる: 2つの kind の列で型付くなら、添字ごとに弱い方をとった列でも型付く（注釈が T@ρ だけの項） -/
theorem HasType.meet {D : Nat} {Γ : List Ty} {e : Expr} {t : Ty}
    (hΓ : ∀ s ∈ Γ, s.ok n = true) (he : e.ok n = true) (ht : t.ok n = true)
    (hw1 : KWF κ1) (hw2 : KWF κ2)
    (h1 : HasType Δ κ1 D Γ e t) (h2 : HasType Δ κ2 D Γ e t) : HasType Δ (meetL κ1 κ2) D Γ e t := by
  obtain ⟨u1, c1, s1⟩ := check_complete h1 (CtxSub.refl _ _)
  obtain ⟨u2, c2, s2⟩ := check_complete h2 (CtxSub.refl _ _)
  have := check_kind_indep c2 c1; subst this
  have hok := check_ok hΓ he c1
  exact .sub (check_sound (check_meet hw1 hw2 hΓ he c1 c2)) (Ty.sub_meet hw1 hw2 _ _ hok ht s1 s2)

end Meet2

/-! # 再帰型の例: 型引数を持たない再帰型（本体の T は局所座標の T@0）

`type Tree[T] struct { v T; next ?*Tree[T] }` を、型引数を持たない再帰型 `mu r B`（B の T は T@0 = 木の region に置いた T）で書く。
代入は本体へ「region 0 へ置き直した型引数」を入れるので、Tree[string@c] と Tree[string@c'] は同じ型になる（要素は木の region の上界で読む）。
-/

namespace Ex5

/-- Tree[T] の本体（局所座標）: v は T@0、next は同じ木の region の木への参照（無いこともある） -/
def treeB : Ty := .prod (.tat 0 0) (.opt (.box false 0 (.rvar 0)))
def str (c : Nat) : Ty := .box false c .int
/-- T = string で代入した本体（どの c でも同じ） -/
def treeS : Ty := .prod (.box false 0 .int) (.opt (.box false 0 (.rvar 0)))

/-- 要素の region が違う木は同じ型（型引数の region は本体の中で木の region に置き直される） -/
theorem tree_inst (r c : Nat) : (Ty.mu r treeB).tsubst [str c] = .mu r treeS := rfl

/-- head[T](t Tree[T]) T@0 = t.v。どの kind でも型付く（mut を持ちうる T でも） -/
def headBody : Expr := .fst (.unfold (.var 0))
theorem head_typed (Δ : List Def) : HasType Δ [.O] 2 [.mu 0 treeB] headBody (.tat 0 0) := check_sound rfl

/-- 呼び手（深さ D・anchor a）から見た head: 仮引数は region a の木、結果は region a の string。
型引数の region c は結果に現れない（最初の反例の「戻り値が string@c を名乗る」が起きない） -/
theorem head_call (a δ c : Nat) :
    ((Ty.mu 0 treeB).ren a δ).tsubst [str c] = .mu a treeS ∧ ((Ty.tat 0 0).ren a δ).tsubst [str c] = str a := ⟨rfl, rfl⟩

/-- region r の木を anchor a の仮引数へ渡せるのは r ≤ a のときだけ。木の要素はどれも r 以下に住むので、結果 string@a はぶら下がらない -/
theorem head_anchor_ge (r a : Nat) (h : csub (.mu r treeS) (.mu a treeS) = true) : r ≤ a := by
  simp [Ty.sub0] at h; omega

/-- 展開との一致（再帰型を含む）: head は、どの閉じた型引数で展開しても単相の規則で型付く -/
theorem head_expand (Δ : List Def) (σ : List Ty) (hl : σ.length = 1) (hc : ∀ s ∈ σ, s.closed = true)
    (hrc : ∀ s ∈ σ, s.rc 0 = true) :
    HasType Δ [] 2 ([Ty.mu 0 treeB].map (Ty.tsubst · σ)) (headBody.tsubstE σ) ((Ty.tat 0 0).tsubst σ) :=
  (generic_iff_all_expand (κ := [.O]) rfl (by omega) (by simp [treeB, Ty.ok]) rfl rfl (check_sound rfl) (by decide)).mp
    (head_typed Δ) σ hl hc hrc (fun i => by cases i <;> simp [kindOf, Kind.le, Kind.O])

/-! ## 実行: block の中で木を作り、head で要素を読む。要素を block の外へ出す形は型付かない -/

def defs : List Def := [⟨[.O], .mu 0 treeB, .tat 0 0, headBody⟩]

theorem defs_ok : DefsOk defs := by
  intro g dfn h
  match g with
  | 0 => simp [defs] at h; subst h; exact head_typed defs
  | _ + 1 => simp [defs] at h

/-- block（深さ 3・最内の region 2）の中: x = region 2 の string・t = region 2 の木 {v: x}・head[string@2](t) を anchor 2 で呼ぶ -/
def mkTree : Expr := .fold (.mu 2 treeS) (.pair (.var 0) (.onone (.box false 2 (.mu 2 treeS))))
def inner (body : Expr) : Expr :=
  .letE (.alloc false .int (.lit 7)) (.letE mkTree body)

/-- 要素を読んで int を block の外へ出す: 型付き、実行すると 7 -/
def progOk : Expr := .block (inner (.read (.call 0 [str 2] 2 (.var 0))))
theorem progOk_typed : HasType defs [] 2 [] progOk .int := check_sound rfl
theorem progOk_run : ∃ H, eval 20 defs ⟨0, 0, []⟩ [[], []] [] progOk = .ok H (.lit 7) := ⟨_, rfl⟩

/-- 最初の反例の筋: head の結果（region 2 の string）を block の外へ出す。型付かない -/
def progBad : Expr := .block (inner (.call 0 [str 2] 2 (.var 0)))
theorem progBad_rejected (t : Ty) : ¬ HasType defs [] 2 [] progBad t := by
  intro h
  obtain ⟨t', hc, -⟩ := check_complete h (CtxSub.refl _ _)
  have : check defs [] 2 [] progBad = none := rfl
  rw [this] at hc; cases hc

/-! ## 相互再帰: Tree[T] { v T; kids Forest[T] }・Forest[T] = ?*{ head Tree[T]; rest Forest[T] }（入れ子の再帰型） -/

/-- Tree の本体: kids は入れ子の再帰型（Forest）。Forest の本体の rvar 1 が Tree・rvar 0 が Forest -/
def forestB : Ty := .opt (.box false 0 (.prod (.rvar 1) (.rvar 0)))
def treeM : Ty := .prod (.tat 0 0) (.mu 0 forestB)

/-- firstChild[T](t Tree[T]) ?T@0: 最初の子の v -/
def firstChildBody : Expr :=
  .case (.opt (.tat 0 0)) (.unfold (.snd (.unfold (.var 0)))) (.onone (.tat 0 0))
    (.osome (.fst (.unfold (.fst (.read (.var 0))))))
theorem firstChild_typed (Δ : List Def) : HasType Δ [.O] 2 [.mu 0 treeM] firstChildBody (.opt (.tat 0 0)) :=
  check_sound rfl

theorem firstChild_expand (Δ : List Def) (σ : List Ty) (hl : σ.length = 1) (hc : ∀ s ∈ σ, s.closed = true)
    (hrc : ∀ s ∈ σ, s.rc 0 = true) :
    HasType Δ [] 2 ([Ty.mu 0 treeM].map (Ty.tsubst · σ)) (firstChildBody.tsubstE σ) ((Ty.opt (.tat 0 0)).tsubst σ) :=
  (generic_iff_all_expand (κ := [.O]) rfl (by omega) (by simp [treeM, forestB, Ty.ok]) rfl rfl (check_sound rfl) (by decide)).mp
    (firstChild_typed Δ) σ hl hc hrc (fun i => by cases i <;> simp [kindOf, Kind.le, Kind.O])

/-- T = string で代入した Tree と Forest の本体 -/
def treeMS : Ty := .prod (.box false 0 .int) (.mu 0 forestB)
def forestS : Ty := .opt (.box false 0 (.prod (.mu 0 treeMS) (.rvar 0)))

/-- 展開の形: Tree を開くと v は region r の string・kids は region r の Forest。Forest を開くと子は region r の Tree -/
theorem treeM_unf (r : Nat) : Ty.unf r treeMS = .prod (str r) (.mu r forestS) ∧
    Ty.unf r forestS = .opt (.box false r (.prod (.mu r treeMS) (.mu r forestS))) := ⟨rfl, rfl⟩

def defsM : List Def := [⟨[.O], .mu 0 treeM, .opt (.tat 0 0), firstChildBody⟩]

theorem defsM_ok : DefsOk defsM := by
  intro g dfn h
  match g with
  | 0 => simp [defsM] at h; subst h; exact firstChild_typed defsM
  | _ + 1 => simp [defsM] at h

def nodeTy : Ty := .prod (.mu 2 treeMS) (.mu 2 forestS)
def emptyF : Expr := .fold (.mu 2 forestS) (.onone (.box false 2 nodeTy))
/-- 子（v = 9）と根（v = 1・kids = [子]）を region 2 に作り、firstChild で子の v を読む -/
def child : Expr := .fold (.mu 2 treeMS) (.pair (.alloc false .int (.lit 9)) emptyF)
def root : Expr :=
  .fold (.mu 2 treeMS) (.pair (.alloc false .int (.lit 1))
    (.fold (.mu 2 forestS) (.osome (.alloc false nodeTy (.pair (.var 0) emptyF)))))
def progM : Expr :=
  .block (.letE child (.letE root (.case .int (.call 0 [str 2] 2 (.var 0)) (.lit 0) (.read (.var 0)))))
theorem progM_typed : HasType defsM [] 2 [] progM .int := check_sound rfl
theorem progM_run : ∃ H, eval 30 defsM ⟨0, 0, []⟩ [[], []] [] progM = .ok H (.lit 9) := ⟨_, rfl⟩

end Ex5


/-! # 形式コピーの下でのシグネチャの選び方（Ex3 の続き）

Ex3 の f（fn T@0 T@0）のままで比べる。選び方 B（x を正確な T・anchor 1・戻り値 T@1）が受け取る呼び出しは、
どれも A（x を T@0・本体の callv の anchor 0・戻り値 T@0）+ 形式コピーでも受け取れて、結果の型も同じ（A の結果 T@anchor は
B の結果 T@最内 の部分型）。ただし A の戻り値 T@0 は compiler/ の単相の規約に無い形（戻り値はフレーム）。規約どおりの比較は Ex7 -/

namespace Ex6
open Ex3

def defs6 : List Def := [⟨[.C], hB_P, .tat 0 1, hBody 1⟩, ⟨[.C], hA_P, .tat 0 0, hBody 0⟩]

theorem defs6_ok : DefsOk defs6 := by
  intro g dfn h
  match g with
  | 0 => simp [defs6] at h; subst h; exact hB_typed defs6
  | 1 => simp [defs6] at h; subst h; exact hA_typed defs6
  | _ + 2 => simp [defs6] at h

def bI (r : Nat) : Ty := .box false r .int
/-- 呼び手の文脈: y（mut・region ry）・f・x（imm・region rx） -/
def ctx (ry rx : Nat) : List Ty := [.box true ry .int, .fn (bI 0) (bI 0), bI rx]
def args (x : Expr) : Expr := .pair (.var 0) (.pair (.var 1) x)
/-- B を型引数 T = string@c・anchor a で呼ぶ -/
def termB (c a : Nat) : Expr := .call 0 [bI c] a (args (.var 2))
/-- A を anchor a で呼び、x を anchor へ形式コピーする（型引数の region は結果に効かないので 0 でよい） -/
def termA (a : Nat) : Expr := .call 1 [bI 0] a (args (.copy a (.var 2)))

/-- B で型付く呼び出しは、A + 形式コピーでも同じ型で型付く -/
theorem A_dominates_B (D a ry rx c : Nat) (hD : 2 ≤ D) (t : Ty)
    (h : HasType defs6 [] D (ctx ry rx) (termB c a) t) : HasType defs6 [] D (ctx ry rx) (termA a) t := by
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check, defs6, termB, args, ctx, argsOkB, bI, hB_P, fT0, Ty.ren, Ty.tsubst, look, Ty.sub, Ty.N, Ty.sub0, Ty.rb,
    Ty.mf, Ty.cv, Ty.rfK, Ty.rc, kindMut, kindRF, kindCov, kindOf, Kind.C, Kind.O, Ty.at, rmap] at hc
  obtain ⟨⟨⟨-, haD⟩, rfl, -⟩, rfl⟩ := hc
  have hA : check defs6 [] D (ctx ry rx) (termA ry) = some (bI ry) := by
    simp [check, defs6, termA, args, ctx, argsOkB, bI, hA_P, fT0, Ty.ren, Ty.tsubst, look, Ty.sub, Ty.N, Ty.sub0, Ty.rb,
      Ty.mf, Ty.cv, Ty.rfK, Ty.rc, kindMut, kindRF, kindCov, kindOf, Kind.C, Kind.O, Ty.at, rmap, haD]
    omega
  refine .sub (check_sound hA) (Ty.subN_trans ?_ hs)
  simp [Ty.sub, Ty.N, Ty.sub0, bI]; omega

/-- A + 形式コピーは、B が受け取れない呼び出しも受け取る（x が anchor より深くても、B の型引数の region c が足りなくても）。
B は x の region rx ≤ c < D を要る。A は x の region を問わない -/
theorem A_typed (D a ry rx : Nat) (hD : 2 ≤ D) (ha : a + 1 ≤ D) (hy : ry = a) :
    HasType defs6 [] D (ctx ry rx) (termA a) (bI a) := by
  subst hy
  apply check_sound
  simp [check, defs6, termA, args, ctx, argsOkB, bI, hA_P, fT0, Ty.ren, Ty.tsubst, look, Ty.sub, Ty.N, Ty.sub0, Ty.rb,
    Ty.mf, Ty.cv, Ty.rfK, Ty.rc, kindMut, kindRF, kindCov, kindOf, Kind.C, Kind.O, Ty.at, rmap, ha]
  omega

end Ex6

/-! # 単相の規約どおりのシグネチャ（compiler/ の desugar の規約）

compiler/ の desugar（desugar.sober の Def の組み立て・ty.sober の retTy）の規約: 仮引数の型は宣言の形（region 0）・戻り値の最上段の
imm のコンテナ（slice・map・D の再帰型。値ラッパの中も）は自フレーム（region 1 — 返りで呼び手の最内へ写る）・関数型の戻り値も同じ
（closure.sober）。ジェネリックに当てはめると、仮引数の T は T@0・戻り値の T は T@1・関数型は fn T@0 T@1。
Ex3 の選び方 A（戻り値 T@0）はこの規約に無い形で、規約どおりの関数型の f では型付かない。
規約どおりのシグネチャ（C）は、正確な T を使う形（X）が受け取る呼び出しを、形式コピーの下でどれも同じ型で受け取る。 -/

namespace Ex7
open Ex3 Ex6

/-- 規約どおりの関数型 func(T) T -/
def fC : Ty := .fn (.tat 0 0) (.tat 0 1)
/-- 規約どおりの h: x は T@0・戻り値は T@1 -/
def hC_P : Ty := .prod (.box true 0 .int) (.prod fC (.tat 0 0))
/-- 比べる形: x を正確な T にする -/
def hX_P : Ty := .prod (.box true 0 .int) (.prod fC (.tvar 0))

theorem hC_typed (Δ : List Def) : HasType Δ [.C] 2 [hC_P] (hBody 1) (.tat 0 1) := check_sound rfl
theorem hX_typed (Δ : List Def) : HasType Δ [.C] 2 [hX_P] (hBody 1) (.tat 0 1) := check_sound rfl

/-- 規約どおりの関数型の f では、戻り値を T@0 にする選び方（Ex3 の A）は、本体の呼び出しの anchor をどう選んでも型付かない -/
theorem ret0_rejected (Δ : List Def) (a : Nat) : ¬ HasType Δ [.C] 2 [hC_P] (hBody a) (.tat 0 0) := by
  intro h
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check, hBody, hC_P, fC, Ty.lowTv, Ty.ren, rmap] at hc
  obtain ⟨-, rfl⟩ := hc
  simp [Ty.sub, Ty.N, Ty.sub0, kindRF, kindCov, kindOf, Kind.C] at hs

def defs7 : List Def := [⟨[.C], hX_P, .tat 0 1, hBody 1⟩, ⟨[.C], hC_P, .tat 0 1, hBody 1⟩]

theorem defs7_ok : DefsOk defs7 := by
  intro g dfn h
  match g with
  | 0 => simp [defs7] at h; subst h; exact hX_typed defs7
  | 1 => simp [defs7] at h; subst h; exact hC_typed defs7
  | _ + 2 => simp [defs7] at h

/-- 呼び手の文脈: f の型は規約どおりの関数型を T = string で代入した形 -/
def ctx7 (ry rx : Nat) : List Ty := [.box true ry .int, .fn (bI 0) (bI 1), bI rx]
def termX (c a : Nat) : Expr := .call 0 [bI c] a (args (.var 2))
def termC (a : Nat) : Expr := .call 1 [bI 0] a (args (.copy a (.var 2)))

/-- 正確な T を使う形で型付く呼び出しは、規約どおりのシグネチャ + 形式コピーでも同じ型で型付く -/
theorem C_dominates_X (D a ry rx c : Nat) (hD : 2 ≤ D) (t : Ty)
    (h : HasType defs7 [] D (ctx7 ry rx) (termX c a) t) : HasType defs7 [] D (ctx7 ry rx) (termC a) t := by
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check, defs7, termX, args, ctx7, argsOkB, bI, hX_P, fC, Ty.ren, Ty.tsubst, look, Ty.sub, Ty.N, Ty.sub0, Ty.rb,
    Ty.mf, Ty.cv, Ty.rfK, Ty.rc, kindMut, kindRF, kindCov, kindOf, Kind.C, Kind.O, Ty.at, rmap] at hc
  obtain ⟨⟨⟨-, haD⟩, rfl, -⟩, rfl⟩ := hc
  have hC : check defs7 [] D (ctx7 ry rx) (termC ry) = some (bI (1 + (D - 2))) := by
    simp [check, defs7, termC, args, ctx7, argsOkB, bI, hC_P, fC, Ty.ren, Ty.tsubst, look, Ty.sub, Ty.N, Ty.sub0, Ty.rb,
      Ty.mf, Ty.cv, Ty.rfK, Ty.rc, kindMut, kindRF, kindCov, kindOf, Kind.C, Kind.O, Ty.at, rmap, haD]
    omega
  exact .sub (check_sound hC) hs

end Ex7

/-! # 旗の kind と imm の ref（Ex8）

imm の ref（`iref r t`）は中身が正確一致なので、mut を持たない（mf）ことと、region を上げると部分型（cov）であることが別の性質になる。
`iref 0 (box false 0 int)` は mf だが cov でない閉じた型（Kind.I の代表）。
-/

namespace Ex8

def str (c : Nat) : Ty := .box false c .int
/-- mf だが cov でない閉じた型 -/
def refStr (c : Nat) : Ty := .iref c (str c)

theorem refStr_kind : kindOfTy (refStr 0) = .I := by decide
theorem str_kind : kindOfTy (str 0) = .C := by decide

/-- 閉じた型で: 中身が region を持つ imm の ref は、region を上げても部分型にならない。中身が region を持たなければなる -/
theorem refStr_not_cov : csub (refStr 0) (refStr 1) = false := by decide
theorem refInt_cov : csub (.iref 0 .int) (.iref 1 .int) = true := by decide

/-- widen[T](x T@0) T@1 { x }: region を上げる部分型を使う本体。cov の旗が要る -/
theorem widen_C (Δ : List Def) : HasType Δ [.C] 2 [.tat 0 0] (.var 0) (.tat 0 1) := .sub (.var rfl) (by decide)

theorem widen_I_rejected (Δ : List Def) : ¬ HasType Δ [.I] 2 [.tat 0 0] (.var 0) (.tat 0 1) := by
  intro h
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check] at hc; subst hc
  revert hs; decide

/-- 展開でも同じ所で分かれる: T = refStr（Kind.I）で展開した単相の本体は型付かない。T = str（Kind.C）なら型付く -/
theorem widen_refStr_rejected (Δ : List Def) : ¬ HasType Δ [] 2 [refStr 0] (.var 0) (refStr 1) := by
  intro h
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check] at hc; subst hc
  revert hs; decide

theorem widen_str_typed (Δ : List Def) : HasType Δ [] 2 [str 0] (.var 0) (str 1) := .sub (.var rfl) (by decide)

/-- cp[T](x T@0) T@1 { copy 1 x }: 形式コピーは mf の旗だけを使う。Kind.I で型付き、Kind.O では型付かない -/
theorem cp_I (Δ : List Def) : HasType Δ [.I] 2 [.tat 0 0] (.copy 1 (.var 0)) (.tat 0 1) := check_sound rfl

theorem cp_O_rejected (Δ : List Def) (t : Ty) : ¬ HasType Δ [.O] 2 [.tat 0 0] (.copy 1 (.var 0)) t := by
  intro h
  obtain ⟨t0, hc, -⟩ := check_complete h (CtxSub.refl _ _)
  simp [check, Ty.mf, kindMut, kindOf, Kind.O] at hc

/-- 旗の整形（KWF）が無いと、推論した kind が1つに決まらない: rf だけ立てた kind（cov なし）と Kind.C のどちらでも widen は型付くが、
旗ごとに弱い方をとった kind（Kind.I と同じ旗）では型付かない -/
def kRfOnly : Kind := ⟨true, true, false⟩

theorem widen_rfOnly (Δ : List Def) : HasType Δ [kRfOnly] 2 [.tat 0 0] (.var 0) (.tat 0 1) := .sub (.var rfl) (by decide)

theorem meet_needs_wf (Δ : List Def) : ¬ HasType Δ (meetL [kRfOnly] [.C]) 2 [.tat 0 0] (.var 0) (.tat 0 1) := by
  intro h
  obtain ⟨t0, hc, hs⟩ := check_complete h (CtxSub.refl _ _)
  simp [check] at hc; subst hc
  revert hs; decide

/-- 実行: mut の box に imm の文字列を入れ、view で imm の ref にして2段読む -/
def progR : Expr :=
  .letE (.alloc true (str 1) (.alloc false .int (.lit 5))) (.read (.read (.view (.var 0))))

theorem progR_typed : HasType [] [] 2 [] progR .int := check_sound rfl
theorem progR_run : ∃ H, eval 20 [] ⟨0, 0, []⟩ [[], []] [] progR = .ok H (.lit 5) := ⟨_, rfl⟩

/-- getR[T](x iref 0 T@0) T@0 { read x }: imm の ref の中身を読むジェネリックは、何も仮定しない kind で型付く -/
theorem getR_O (Δ : List Def) : HasType Δ [.O] 2 [.iref 0 (.tat 0 0)] (.read (.var 0)) (.tat 0 0) := check_sound rfl

/-- 呼び出しの実行: getR を T = str で、view した ref に対して呼ぶ -/
def defsR : List Def := [⟨[.O], .iref 0 (.tat 0 0), .tat 0 0, .read (.var 0)⟩]

theorem defsR_ok : DefsOk defsR := by
  intro g dfn h
  cases g with
  | zero => simp [defsR] at h; subst h; exact getR_O _
  | succ => simp [defsR] at h

def progRc : Expr :=
  .letE (.alloc true (str 1) (.alloc false .int (.lit 7))) (.read (.call 0 [str 1] 1 (.view (.var 0))))

theorem progRc_typed : HasType defsR [] 2 [] progRc .int := check_sound rfl
theorem progRc_run : ∃ H, eval 20 defsR ⟨0, 0, []⟩ [[], []] [] progRc = .ok H (.lit 7) := ⟨_, rfl⟩

end Ex8

end R3C
