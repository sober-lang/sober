import Extract.Core

/-!
# 抽出器の負例（止まる経路 — `sober-extract --neg`）

どれも抽出器が**止まる**こと（黙って近似しない）を確かめるための人工的な定義。
-/

namespace Extract.Neg

open FS Lean Meta

/-- partial: 方程式が無い -/
partial def negPartial (t : Ty) : Bool :=
  match t with
  | .opt s => negPartial s
  | _ => true

/-- String（写せない型） -/
def negString (t : Ty) : String :=
  match t with
  | .int => "int"
  | _ => "other"

/-- ユーザーの型クラス（対象外の関数の呼び出し） -/
class NegC (α : Type) where
  f : α → Bool

instance : NegC Ty := ⟨fun _ => true⟩

def negClass (t : Ty) : Bool := NegC.f t

/-- 右辺の match（計算結果への match — matcher の補助関数が右辺に残る） -/
def negMatchRhs (t : Ty) : Bool :=
  match t.mutTop with
  | some _ => true
  | none => false

/-- 仮定が先行の方程式の否定に対応しない人工的な方程式: 先行は `bool` の腕なのに、2 本目の仮定は `int` でない、と言う。
定義の本物の方程式の代わりに、この定理の列を方程式として渡す -/
def negHypF : Ty → Bool
  | _ => true

theorem negHyp_eq_1 : negHypF Ty.bool = true := rfl
theorem negHyp_eq_2 (x : Ty) (_h : x = Ty.int → False) : negHypF x = true := rfl

/-- 無条件の近道（定理が方程式を全部覆ってしまう — 近道でなく定義の言い換え） -/
def negShortF : Ty → Bool
  | .int => true
  | _ => true

theorem negShort (t : Ty) : negShortF t = true := by cases t <;> rfl

/-- 負例の一覧: (名前, 抽出を試す) -/
def cases (env : Env) : List (String × MetaM String) :=
  [ ("partial def", extract env ``negPartial)
  , ("String", extract env ``negString)
  , ("型クラス", extract env ``negClass)
  , ("右辺の match", extract env ``negMatchRhs)
  , ("仮定が先行の否定に対応しない", extractWith env ``negHypF #[``negHyp_eq_1, ``negHyp_eq_2])
  , ("無条件の近道", do
      let some eqs ← getEqnsFor? ``negShortF | throwError "negShortF に方程式が無い"
      extractWith env ``negShortF eqs [``negShort]) ]

end Extract.Neg
