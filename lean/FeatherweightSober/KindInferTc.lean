import FeatherweightSober.KindComp
import FeatherweightSober.Checker

/-!
# kind の推論の計算できる形

`inferK` は判定に DefOk（命題）を使うので計算できない。判定を検査器（typecheck）に替えた `inferTc` を置き、
`typecheck_sound`・`typecheck_complete` から両者が同じ結果を返すことを示す。
コンパイラの推論の結果と、この手順の結果を照合する（sober-check の `--infer-batch`）。
-/

namespace FS

/-- DefOk の検査器の版（checkDefs の 1 行と同じ条件） -/
def defOkB (Δ : Defs) (dfn : Def) : Bool :=
  dfn.param.paramOk && dfn.ret.retOk && dfn.body.noNewchan &&
    dfn.param.tvarsBelow dfn.kinds.length && dfn.ret.tvarsBelow dfn.kinds.length && dfn.body.src && dfn.tvOk &&
    (typecheck Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body == some dfn.ret)

theorem defOkB_iff {Δ : Defs} {dfn : Def} : defOkB Δ dfn = true ↔ DefOk Δ dfn := by
  simp only [defOkB, DefOk, Bool.and_eq_true, beq_iff_eq, and_assoc]
  constructor
  · rintro ⟨h1, h2, h3, h4, h5, h6, h7, h8⟩
    exact ⟨h1, h2, h3, h4, h5, h6, h7, typecheck_sound h8⟩
  · rintro ⟨h1, h2, h3, h4, h5, h6, h7, h8⟩
    exact ⟨h1, h2, h3, h4, h5, h6, h7, typecheck_complete h8 h6⟩

section Comp

variable (Δ : Defs) (C : List Nat) (S : Nat → Def) (len : Nat → Nat)

/-- accK の判定を検査器で計算する版 -/
def accTc (K : Nat → List Kind) (f : Nat) (a : List Kind) : Bool :=
  (a.length == len f) && a.all Kind.isNorm && defOkB (Δ.withK C S (upK S len K)) ((S f).raise a)

/-- 推論の手順の計算できる版（inferK の accK を accTc に替えたもの） -/
def inferTc : Option (Nat → List Kind) :=
  if C.all (fun f => sigA S len f (topL (len f))) then runK C len (accTc Δ C S len) (fuel C len) (sigMin S len) else none

theorem accTc_eq : accTc Δ C S len = accK Δ C S len := by
  funext K f a
  apply Bool.eq_iff_iff.mpr
  rw [accK_iff]
  simp only [accTc, Bool.and_eq_true, beq_iff_eq, List.all_eq_true, defOkB_iff]
  simp [KNorm, and_assoc]

/-- 計算できる版は inferK と同じ結果を返す（inferK_correct がそのまま inferTc に移る） -/
theorem inferTc_eq : inferTc Δ C S len = inferK Δ C S len := by
  simp only [inferTc, inferK, accTc_eq]

end Comp

end FS
