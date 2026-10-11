import FeatherweightSober.TcStep

/-! # typecheck ≡ evalRule（段 6 P2b — 腕ごとの補題 + 帰納法）

腕ごとの補題 `tcEq_<構成子>` は機械的（部分項の帰納法の仮定で子の evalRule を typecheck へ書き換え → 両辺の match を割る）。
生成した雛形に、依存する文脈の腕（ifnil / case / callv / spawn …）だけ手で場合分けを書いた。 -/
namespace FS

/-- typecheck と tcStep の補助関数・読み口を全部開く -/
macro "tc_unf" : tactic => `(tactic| simp only [typecheck, ctxAllMutFree, ctxCons, ctxGet, defGet, defParam, defRet, defTps, kAlloc, kAnn, kAppend, kAssign, kBlock, kBlockR, kScope, kClose, kCall, kCallM, kCallM2, kCallv, kConcat, kCopyTo, kDelm, kDeref, kEq2, kEqs, kFF, kFconv, kFnref, kFreeze, kFst, kGetm, kII, kIndex, kInl, kInr, kIte, kJoin, kJump, kKeysm, kLabel, kLen, kLenm, kMkmap, kMkmapAt, kMkslice, kMksliceAt, kNewch, kNewchan, kPair, kPar, kParch, kRecv, kSend, kSetidx, kSetm, kSnd, kSome, kSpawn, kStrlit, kSubslice, kTobyte, kToint, kTry, kWhile, lctxCons, lctxK, lctxTy, sCallv1, sCase1, sCase2, sIfnil1, sIfnil2, sLet, sSpawn2, tsLen])

set_option hygiene false in
/-- 腕の締め: 部分項の結果を書き換えた後、両辺の match を割って照らし合わせる（d の場合分けが要る腕は d を割ってから） -/
macro "tc_fin" : tactic => `(tactic| first
  | (tc_unf <;> done)
  | (tc_unf <;> split <;> split <;> simp_all <;> done)
  | (rcases d with _ | d <;> tc_unf <;> split <;> split <;> simp_all <;> done)
  | (rcases d with _ | d <;> tc_unf <;> (try split) <;> simp_all <;> done))

variable {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f : Nat}

theorem tcEq_lit (x0 : Int)  :
    ∀ n b d Γ Λ, sizeOf (Expr.lit x0) < n → evalRule Δ f n b d Γ Λ (Expr.lit x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.lit x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_tt   :
    ∀ n b d Γ Λ, sizeOf Expr.tt < n → evalRule Δ f n b d Γ Λ Expr.tt = typecheck Δ Ξ Ψ f b d Γ Λ Expr.tt := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_ff   :
    ∀ n b d Γ Λ, sizeOf Expr.ff < n → evalRule Δ f n b d Γ Λ Expr.ff = typecheck Δ Ξ Ψ f b d Γ Λ Expr.ff := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_triv   :
    ∀ n b d Γ Λ, sizeOf Expr.triv < n → evalRule Δ f n b d Γ Λ Expr.triv = typecheck Δ Ξ Ψ f b d Γ Λ Expr.triv := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_var (x0 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.var x0) < n → evalRule Δ f n b d Γ Λ (Expr.var x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.var x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_letE (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.letE x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.letE x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.letE x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.letE.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_add (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.add x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.add x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.add x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.add.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_lt (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.lt x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.lt x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.lt x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.lt.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_arith (x0 : ArithOp) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.arith x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.arith x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.arith x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.arith.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_cmp (x0 : CmpOp) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.cmp x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.cmp x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.cmp x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.cmp.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_ite (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.ite x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.ite x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.ite x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.ite.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1, ihx2]
    tc_fin

theorem tcEq_nil (x0 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.nil x0) < n → evalRule Δ f n b d Γ Λ (Expr.nil x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.nil x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_some (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.some x0) < n → evalRule Δ f n b d Γ Λ (Expr.some x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.some x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.some.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_ifnil (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.ifnil x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.ifnil x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.ifnil x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.ifnil.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, typecheck]
    cases hx : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [sIfnil1]
    | some t => cases t <;> simp [sIfnil1, sIfnil2, ctxCons, ihx1, ihx2, kEq2] <;> split <;> split <;> simp_all

theorem tcEq_inl (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.inl x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.inl x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.inl x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.inl.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_inr (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.inr x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.inr x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.inr x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.inr.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_case (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.case x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.case x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.case x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.case.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, typecheck]
    cases hx : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [sCase1]
    | some t => cases t <;> simp [sCase1, sCase2, ctxCons, ihx1, ihx2, kEq2] <;> split <;> split <;> simp_all

theorem tcEq_pair (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.pair x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.pair x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.pair x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.pair.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_fst (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.fst x0) < n → evalRule Δ f n b d Γ Λ (Expr.fst x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.fst x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.fst.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_snd (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.snd x0) < n → evalRule Δ f n b d Γ Λ (Expr.snd x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.snd x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.snd.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_call (x0 : Nat) (x1 : List Ty) (x2 : Expr) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.call x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.call x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.call x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.call.sizeOf_spec] at h
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx2]
    cases d with
    | zero => cases defGet Δ x0 <;> cases typecheck Δ Ξ Ψ f b 0 Γ Λ x2 <;> simp only [kCall, typecheck]
    | succ d' =>
      simp only [defGet] at *
      cases hT : typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ x2 <;> cases hD : Δ[x0]? <;>
        simp only [kCall, typecheck, defParam, defRet, defTps, tsLen, hT, hD] <;> rfl

theorem tcEq_callM (x0 : Nat) (x1 : List Ty) (x2 : Expr) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.callM x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.callM x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.callM x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.callM.sizeOf_spec] at h
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx2]
    cases d with
    | zero => cases defGet Δ x0 <;> cases typecheck Δ Ξ Ψ f b 0 Γ Λ x2 <;> simp only [kCallM, typecheck]
    | succ d' =>
      simp only [defGet] at *
      cases hT : typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ x2 <;> cases hD : Δ[x0]? <;>
        simp only [kCallM, typecheck, defParam, defRet, defTps, tsLen, hT, hD]
      rename_i t dfn
      cases hA : Ty.anchorOf (dfn.inst x1).param t <;> simp only [kCallM2, hA, defParam, defRet, defTps, tsLen] <;> rfl

theorem tcEq_fnref (x0 : Nat) (x1 : List Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.fnref x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.fnref x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.fnref x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_callv (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.callv x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.callv x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.callv x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.callv.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    cases hx : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => cases d <;> simp [sCallv1, typecheck, hx]
    | some t =>
      cases d with
      | zero => cases t <;> cases hy : typecheck Δ Ξ Ψ f b 0 Γ Λ x1 <;> simp [sCallv1, kCallv, typecheck, hx, hy, ihx1]
      | succ d' =>
        cases t <;> cases hy : typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ x1 <;> simp [sCallv1, kCallv, typecheck, hx, hy, ihx1]

theorem tcEq_ann (x0 : Expr) (x1 : Ty) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.ann x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.ann x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.ann x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.ann.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_block (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.block x0) < n → evalRule Δ f n b d Γ Λ (Expr.block x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.block x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.block.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_blockR (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.blockR x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.blockR x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.blockR x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.blockR.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_copyTo (x0 : Nat) (x1 : Ty) (x2 : Expr) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.copyTo x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.copyTo x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.copyTo x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.copyTo.sizeOf_spec] at h
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx2]
    tc_fin

theorem tcEq_label (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.label x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.label x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.label x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.label.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_jump (x0 : Nat) (x1 : Ty) (x2 : Expr) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.jump x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.jump x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.jump x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.jump.sizeOf_spec] at h
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx2]
    cases hL : Λ[x0]? with
    | none => simp [kJump, lctxTy, lctxK, typecheck, hL]
    | some p =>
      obtain ⟨tL, k⟩ := p
      cases hT : typecheck Δ Ξ Ψ f b d Γ Λ x2 <;> simp [kJump, lctxTy, lctxK, typecheck, hL, hT]

theorem tcEq_unreach (x0 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.unreach x0) < n → evalRule Δ f n b d Γ Λ (Expr.unreach x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.unreach x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_alloc (x0 : Bool) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.alloc x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.alloc x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.alloc x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.alloc.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    cases hT : typecheck Δ Ξ Ψ f b d Γ Λ x1 <;> cases d <;> simp [kAlloc, typecheck, hT]

theorem tcEq_deref (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.deref x0) < n → evalRule Δ f n b d Γ Λ (Expr.deref x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.deref x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.deref.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_assign (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.assign x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.assign x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.assign x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.assign.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_whileE (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.whileE x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.whileE x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.whileE x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.whileE.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_freeze (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.freeze x0) < n → evalRule Δ f n b d Γ Λ (Expr.freeze x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.freeze x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.freeze.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_mkslice (x0 : Bool) (x1 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.mkslice x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.mkslice x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.mkslice x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_strlit (x0 : List Int) (x1 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.strlit x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.strlit x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.strlit x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_mksliceAt (x0 : Bool) (x1 : Ty) (x2 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.mksliceAt x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.mksliceAt x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.mksliceAt x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_mkmapAt (x0 : Bool) (x1 : Ty) (x2 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.mkmapAt x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.mkmapAt x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.mkmapAt x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    cases x1 with
    | prod k v => cases v <;> simp [kMkmapAt, typecheck]
    | _ => simp [kMkmapAt, typecheck]

theorem tcEq_index (x0 : Expr) (x1 : Expr) (x2 : Option Ty) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.index x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.index x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.index x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.index.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_lenE (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.lenE x0) < n → evalRule Δ f n b d Γ Λ (Expr.lenE x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.lenE x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.lenE.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_tobyte (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.tobyte x0) < n → evalRule Δ f n b d Γ Λ (Expr.tobyte x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.tobyte x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.tobyte.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_toint (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.toint x0) < n → evalRule Δ f n b d Γ Λ (Expr.toint x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.toint x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.toint.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_blit (x0 : Int)  :
    ∀ n b d Γ Λ, sizeOf (Expr.blit x0) < n → evalRule Δ f n b d Γ Λ (Expr.blit x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.blit x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_flit (x0 : Int)  :
    ∀ n b d Γ Λ, sizeOf (Expr.flit x0) < n → evalRule Δ f n b d Γ Λ (Expr.flit x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.flit x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_farith (x0 : FArithOp) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.farith x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.farith x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.farith x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.farith.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_fcmp (x0 : FCmpOp) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.fcmp x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.fcmp x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.fcmp x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.fcmp.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_fconv (x0 : FConvOp) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.fconv x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.fconv x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.fconv x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.fconv.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_append (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.append x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.append x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.append x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.append.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    cases hA : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [kAppend, typecheck, hA]
    | some tA =>
      cases hB : typecheck Δ Ξ Ψ f b d Γ Λ x1 <;> cases tA <;> (try cases ‹Bool›) <;> cases d <;>
        simp [kAppend, typecheck, hA, hB]

theorem tcEq_setidx (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.setidx x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.setidx x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.setidx x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.setidx.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1, ihx2]
    tc_fin

theorem tcEq_subslice (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.subslice x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.subslice x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.subslice x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.subslice.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1, ihx2]
    tc_fin

theorem tcEq_eqs (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.eqs x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.eqs x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.eqs x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.eqs.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_concat (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.concat x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.concat x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.concat x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.concat.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    cases hA : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [kConcat, typecheck, hA]
    | some tA =>
      cases hB : typecheck Δ Ξ Ψ f b d Γ Λ x1 with
      | none => cases tA <;> simp [kConcat, typecheck, hA, hB]
      | some tB =>
        cases tA <;> (try cases ‹Bool›) <;> (try (simp [kConcat, typecheck, hA, hB]; done)) <;>
          cases tB <;> (try cases ‹Bool›) <;> cases d <;> simp [kConcat, typecheck, hA, hB]

theorem tcEq_mkmap (x0 : Bool) (x1 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.mkmap x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.mkmap x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.mkmap x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    cases d with
    | zero => simp [kMkmap, typecheck]
    | succ d =>
      cases x1 with
      | prod k v => cases v <;> simp [kMkmap, typecheck]
      | _ => simp [kMkmap, typecheck]

theorem tcEq_getm (x0 : Ty) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.getm x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.getm x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.getm x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.getm.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_setm (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.setm x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.setm x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.setm x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.setm.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1, ihx2]
    tc_fin

theorem tcEq_delm (x0 : Ty) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.delm x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.delm x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.delm x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.delm.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_lenm (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.lenm x0) < n → evalRule Δ f n b d Γ Λ (Expr.lenm x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.lenm x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.lenm.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_keysm (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.keysm x0) < n → evalRule Δ f n b d Γ Λ (Expr.keysm x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.keysm x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.keysm.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    cases hA : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [kKeysm, typecheck, hA]
    | some tA =>
      cases d <;> cases tA <;> (try (simp [kKeysm, typecheck, hA]; done))
      all_goals (rename_i c; cases c <;> (try (simp [kKeysm, typecheck, hA]; done)))
      all_goals (rename_i v; cases v <;> simp [kKeysm, typecheck, hA])

theorem tcEq_clone (x0 : Option Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.clone x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.clone x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.clone x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.clone.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    cases hA : typecheck Δ Ξ Ψ f b d Γ Λ x1 with
    | none => simp [kClone, typecheck, hA]
    | some tA =>
      cases d <;> cases tA <;> simp [kClone, typecheck, hA]
      all_goals (split <;> simp_all [kCloneR])

theorem tcEq_par (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.par x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.par x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.par x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.par.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_parch (x0 : Ty) (x1 : Expr) (x2 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.parch x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.parch x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.parch x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.parch.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1, ihx2]
    tc_fin

theorem tcEq_newchan (x0 : Nat) (x1 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.newchan x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.newchan x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.newchan x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_send (x0 : Expr) (x1 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.send x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.send x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.send x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.send.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    tc_fin

theorem tcEq_recv (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.recv x0) < n → evalRule Δ f n b d Γ Λ (Expr.recv x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.recv x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.recv.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_close (x0 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) :
    ∀ n b d Γ Λ, sizeOf (Expr.close x0) < n → evalRule Δ f n b d Γ Λ (Expr.close x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.close x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.close.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0]
    tc_fin

theorem tcEq_loc (x0 : Nat) (x1 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.loc x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.loc x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.loc x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_slicev (x0 : Bool) (x1 : Nat) (x2 : Nat) (x3 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.slicev x0 x1 x2 x3) < n → evalRule Δ f n b d Γ Λ (Expr.slicev x0 x1 x2 x3) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.slicev x0 x1 x2 x3) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_mapv (x0 : Bool) (x1 : Nat) (x2 : Nat) (x3 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.mapv x0 x1 x2 x3) < n → evalRule Δ f n b d Γ Λ (Expr.mapv x0 x1 x2 x3) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.mapv x0 x1 x2 x3) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_chanV (x0 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.chanV x0) < n → evalRule Δ f n b d Γ Λ (Expr.chanV x0) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.chanV x0) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_scope (x0 : Ty) (xε : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.scope x0 xε x1) < n → evalRule Δ f n b d Γ Λ (Expr.scope x0 xε x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.scope x0 xε x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.scope.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_spawn (x0 : Expr) (x1 : Expr) (x2 : Expr) (ih_x0 : ∀ n b d Γ Λ, sizeOf x0 < n → evalRule Δ f n b d Γ Λ x0 = typecheck Δ Ξ Ψ f b d Γ Λ x0) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) (ih_x2 : ∀ n b d Γ Λ, sizeOf x2 < n → evalRule Δ f n b d Γ Λ x2 = typecheck Δ Ξ Ψ f b d Γ Λ x2) :
    ∀ n b d Γ Λ, sizeOf (Expr.spawn x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.spawn x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.spawn x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.spawn.sizeOf_spec] at h
    have ihx0 := fun b d Γ Λ => ih_x0 n b d Γ Λ (by omega)
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    have ihx2 := fun b d Γ Λ => ih_x2 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx0, ihx1]
    cases hA : typecheck Δ Ξ Ψ f b d Γ Λ x0 with
    | none => simp [sSpawn2, typecheck, hA]
    | some tA =>
      cases tA <;> (try (simp [sSpawn2, typecheck, hA]; done))
      rename_i k r t
      cases k <;> (try (simp [sSpawn2, typecheck, hA]; done))
      cases hB : typecheck Δ Ξ Ψ f b d Γ Λ x1 with
      | none => simp [sSpawn2, typecheck, hA, hB]
      | some tB =>
        cases hC : typecheck Δ Ξ Ψ f d (d + 1) [Ty.rehome d tB] [] x2 with
        | none => simp [sSpawn2, kSpawn, ctxCons, ihx2, typecheck, hA, hB, hC]
        | some tC =>
          cases tC <;> (try (simp [sSpawn2, kSpawn, ctxCons, ihx2, typecheck, hA, hB, hC]; done))
          rename_i l r'
          cases r' <;> simp [sSpawn2, kSpawn, ctxCons, ihx2, typecheck, hA, hB, hC]


theorem tcEq_join (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.join x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.join x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.join x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.join.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_tryJ (x0 : Ty) (x1 : Expr) (ih_x1 : ∀ n b d Γ Λ, sizeOf x1 < n → evalRule Δ f n b d Γ Λ x1 = typecheck Δ Ξ Ψ f b d Γ Λ x1) :
    ∀ n b d Γ Λ, sizeOf (Expr.tryJ x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.tryJ x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.tryJ x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [Expr.tryJ.sizeOf_spec] at h
    have ihx1 := fun b d Γ Λ => ih_x1 n b d Γ Λ (by omega)
    simp only [evalRule, tcStep, ihx1]
    tc_fin

theorem tcEq_scopeV (x0 : Nat) (xε : Ty) :
    ∀ n b d Γ Λ, sizeOf (Expr.scopeV x0 xε) < n → evalRule Δ f n b d Γ Λ (Expr.scopeV x0 xε) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.scopeV x0 xε) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_taskV (x0 : Nat) (x1 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.taskV x0 x1) < n → evalRule Δ f n b d Γ Λ (Expr.taskV x0 x1) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.taskV x0 x1) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_newch (x0 : Nat) (x1 : Nat) (x2 : Ty)  :
    ∀ n b d Γ Λ, sizeOf (Expr.newch x0 x1 x2) < n → evalRule Δ f n b d Γ Λ (Expr.newch x0 x1 x2) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.newch x0 x1 x2) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem tcEq_epV (x0 : List Nat) (x1 : Nat) (x2 : Bool) (x3 : Nat)  :
    ∀ n b d Γ Λ, sizeOf (Expr.epV x0 x1 x2 x3) < n → evalRule Δ f n b d Γ Λ (Expr.epV x0 x1 x2 x3) = typecheck Δ Ξ Ψ f b d Γ Λ (Expr.epV x0 x1 x2 x3) := by
  intro n b d Γ Λ h; cases n with
  | zero => omega
  | succ n =>
    simp only [evalRule, tcStep]
    tc_fin

theorem evalRule_eq_typecheck :
    ∀ (e : Expr) (n b d : Nat) (Γ : Ctx) (Λ : LCtx), sizeOf e < n → evalRule Δ f n b d Γ Λ e = typecheck Δ Ξ Ψ f b d Γ Λ e := by
  intro e
  induction e with
  | lit x0 => exact tcEq_lit x0
  | tt  => exact tcEq_tt 
  | ff  => exact tcEq_ff 
  | triv  => exact tcEq_triv 
  | var x0 => exact tcEq_var x0
  | letE x0 x1 ih_x0 ih_x1 => exact tcEq_letE x0 x1 ih_x0 ih_x1
  | add x0 x1 ih_x0 ih_x1 => exact tcEq_add x0 x1 ih_x0 ih_x1
  | lt x0 x1 ih_x0 ih_x1 => exact tcEq_lt x0 x1 ih_x0 ih_x1
  | arith x0 x1 x2 ih_x1 ih_x2 => exact tcEq_arith x0 x1 x2 ih_x1 ih_x2
  | cmp x0 x1 x2 ih_x1 ih_x2 => exact tcEq_cmp x0 x1 x2 ih_x1 ih_x2
  | ite x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_ite x0 x1 x2 ih_x0 ih_x1 ih_x2
  | nil x0 => exact tcEq_nil x0
  | some x0 ih_x0 => exact tcEq_some x0 ih_x0
  | ifnil x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_ifnil x0 x1 x2 ih_x0 ih_x1 ih_x2
  | inl x0 x1 ih_x1 => exact tcEq_inl x0 x1 ih_x1
  | inr x0 x1 ih_x1 => exact tcEq_inr x0 x1 ih_x1
  | case x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_case x0 x1 x2 ih_x0 ih_x1 ih_x2
  | pair x0 x1 ih_x0 ih_x1 => exact tcEq_pair x0 x1 ih_x0 ih_x1
  | fst x0 ih_x0 => exact tcEq_fst x0 ih_x0
  | snd x0 ih_x0 => exact tcEq_snd x0 ih_x0
  | call x0 x1 x2 ih_x2 => exact tcEq_call x0 x1 x2 ih_x2
  | callM x0 x1 x2 ih_x2 => exact tcEq_callM x0 x1 x2 ih_x2
  | fnref x0 x1 => exact tcEq_fnref x0 x1
  | callv x0 x1 ih_x0 ih_x1 => exact tcEq_callv x0 x1 ih_x0 ih_x1
  | ann x0 x1 ih_x0 => exact tcEq_ann x0 x1 ih_x0
  | block x0 ih_x0 => exact tcEq_block x0 ih_x0
  | blockR x0 x1 ih_x1 => exact tcEq_blockR x0 x1 ih_x1
  | copyTo x0 x1 x2 ih_x2 => exact tcEq_copyTo x0 x1 x2 ih_x2
  | label x0 x1 ih_x1 => exact tcEq_label x0 x1 ih_x1
  | jump x0 x1 x2 ih_x2 => exact tcEq_jump x0 x1 x2 ih_x2
  | unreach x0 => exact tcEq_unreach x0
  | alloc x0 x1 ih_x1 => exact tcEq_alloc x0 x1 ih_x1
  | deref x0 ih_x0 => exact tcEq_deref x0 ih_x0
  | assign x0 x1 ih_x0 ih_x1 => exact tcEq_assign x0 x1 ih_x0 ih_x1
  | whileE x0 x1 ih_x0 ih_x1 => exact tcEq_whileE x0 x1 ih_x0 ih_x1
  | freeze x0 ih_x0 => exact tcEq_freeze x0 ih_x0
  | mkslice x0 x1 => exact tcEq_mkslice x0 x1
  | strlit x0 x1 => exact tcEq_strlit x0 x1
  | mksliceAt x0 x1 x2 => exact tcEq_mksliceAt x0 x1 x2
  | mkmapAt x0 x1 x2 => exact tcEq_mkmapAt x0 x1 x2
  | index x0 x1 x2 ih_x0 ih_x1 => exact tcEq_index x0 x1 x2 ih_x0 ih_x1
  | lenE x0 ih_x0 => exact tcEq_lenE x0 ih_x0
  | tobyte x0 ih_x0 => exact tcEq_tobyte x0 ih_x0
  | toint x0 ih_x0 => exact tcEq_toint x0 ih_x0
  | blit x0 => exact tcEq_blit x0
  | flit x0 => exact tcEq_flit x0
  | farith x0 x1 x2 ih_x1 ih_x2 => exact tcEq_farith x0 x1 x2 ih_x1 ih_x2
  | fcmp x0 x1 x2 ih_x1 ih_x2 => exact tcEq_fcmp x0 x1 x2 ih_x1 ih_x2
  | fconv x0 x1 ih_x1 => exact tcEq_fconv x0 x1 ih_x1
  | append x0 x1 ih_x0 ih_x1 => exact tcEq_append x0 x1 ih_x0 ih_x1
  | setidx x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_setidx x0 x1 x2 ih_x0 ih_x1 ih_x2
  | subslice x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_subslice x0 x1 x2 ih_x0 ih_x1 ih_x2
  | eqs x0 x1 ih_x0 ih_x1 => exact tcEq_eqs x0 x1 ih_x0 ih_x1
  | concat x0 x1 ih_x0 ih_x1 => exact tcEq_concat x0 x1 ih_x0 ih_x1
  | mkmap x0 x1 => exact tcEq_mkmap x0 x1
  | getm x0 x1 x2 ih_x1 ih_x2 => exact tcEq_getm x0 x1 x2 ih_x1 ih_x2
  | setm x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_setm x0 x1 x2 ih_x0 ih_x1 ih_x2
  | delm x0 x1 x2 ih_x1 ih_x2 => exact tcEq_delm x0 x1 x2 ih_x1 ih_x2
  | lenm x0 ih_x0 => exact tcEq_lenm x0 ih_x0
  | keysm x0 ih_x0 => exact tcEq_keysm x0 ih_x0
  | clone x0 x1 ih_x1 => exact tcEq_clone x0 x1 ih_x1
  | par x0 x1 ih_x0 ih_x1 => exact tcEq_par x0 x1 ih_x0 ih_x1
  | parch x0 x1 x2 ih_x1 ih_x2 => exact tcEq_parch x0 x1 x2 ih_x1 ih_x2
  | newchan x0 x1 => exact tcEq_newchan x0 x1
  | send x0 x1 ih_x0 ih_x1 => exact tcEq_send x0 x1 ih_x0 ih_x1
  | recv x0 ih_x0 => exact tcEq_recv x0 ih_x0
  | close x0 ih_x0 => exact tcEq_close x0 ih_x0
  | loc x0 x1 => exact tcEq_loc x0 x1
  | slicev x0 x1 x2 x3 => exact tcEq_slicev x0 x1 x2 x3
  | mapv x0 x1 x2 x3 => exact tcEq_mapv x0 x1 x2 x3
  | chanV x0 => exact tcEq_chanV x0
  | scope x0 xε x1 ih_x1 => exact tcEq_scope x0 xε x1 ih_x1
  | spawn x0 x1 x2 ih_x0 ih_x1 ih_x2 => exact tcEq_spawn x0 x1 x2 ih_x0 ih_x1 ih_x2
  | join x0 x1 ih_x1 => exact tcEq_join x0 x1 ih_x1
  | tryJ x0 x1 ih_x1 => exact tcEq_tryJ x0 x1 ih_x1
  | scopeV x0 xε => exact tcEq_scopeV x0 xε
  | taskV x0 x1 => exact tcEq_taskV x0 x1
  | newch x0 x1 x2 => exact tcEq_newch x0 x1 x2
  | epV x0 x1 x2 x3 => exact tcEq_epV x0 x1 x2 x3

/-- **定理（P2b の要）**: typecheck は tcStep を回す大ステップ（燃料 = 式の大きさ + 1）と等しい -/
theorem typecheck_eq_evalRule (e : Expr) (b d : Nat) (Γ : Ctx) (Λ : LCtx) :
    typecheck Δ Ξ Ψ f b d Γ Λ e = evalRule Δ f (sizeOf e + 1) b d Γ Λ e :=
  (evalRule_eq_typecheck e _ b d Γ Λ (Nat.lt_succ_self _)).symm

end FS
