import FeatherweightSober.KindInfer

/-!
# 呼び先の kind についての反単調性

相互再帰の成分 C の行を、kind の割り当て K で置き直した関数表 `Δ.withK C S K` を考える。
呼び先の旗が少ないほど、呼び出しの型引数の条件（kindsArgsOk）は弱く、実体化したシグネチャは変わらない
（rf の旗の違いは、型引数が rf を満たす限り置き直し先に効かない）。よって K ≤ K' なら、Δ.withK C S K' の下の導出は
Δ.withK C S K の下の導出に写る。型付けの規則のうち関数表を読むのは call と fnref だけなので、
写せることは「呼び出しの規則が読む部分が保たれる関数表の対応」（`DefsSim`）の一般の補題から出る。
-/

namespace FS

/-- 呼び出しの規則が関数表から読む部分（型引数の条件・実体化したシグネチャ）が、Δ から Δ' へ保たれる -/
def DefsSim (Δ Δ' : Defs) : Prop :=
  ∀ (fn : Nat) (dfn : Def) (ts : List Ty), Δ[fn]? = some dfn → ts.length = dfn.kinds.length → kindsArgsOk dfn.kinds ts = true →
    ∃ dfn' : Def, Δ'[fn]? = some dfn' ∧ ts.length = dfn'.kinds.length ∧ kindsArgsOk dfn'.kinds ts = true ∧
      (dfn'.inst ts).param = (dfn.inst ts).param ∧ (dfn'.inst ts).ret = (dfn.inst ts).ret

theorem HasType.defs_sim {Δ Δ' : Defs} (hs : DefsSim Δ Δ') {Ξ Ψ f b d Γ Λ e t}
    (h : HasType Δ Ξ Ψ f b d Γ Λ e t) : HasType Δ' Ξ Ψ f b d Γ Λ e t := by
  induction h
  case call hfn hl hk _ hsub hba had ih =>
    obtain ⟨dfn', h1, h2, h3, hp, hr⟩ := hs _ _ _ hfn hl hk
    rw [← hr]
    exact .call h1 h2 h3 ih (hp ▸ hsub) hba had
  case fnref hfn hl hk =>
    obtain ⟨dfn', h1, h2, h3, hp, hr⟩ := hs _ _ _ hfn hl hk
    rw [← hp, ← hr]
    exact .fnref h1 h2 h3
  case sendE => apply HasType.sendE <;> assumption
  case recvE => apply HasType.recvE <;> assumption
  all_goals (constructor <;> assumption)

/-- 成分 C の行 g を、形の Def `S g` を kind の列 `K g` で置き直した行に替えた関数表（C の外の行と長さは変えない） -/
def Defs.withK (Δ : Defs) (C : List Nat) (S : Nat → Def) (K : Nat → List Kind) : Defs :=
  Δ.mapIdx (fun g dfn => if g ∈ C then (S g).raise (K g) else dfn)

theorem Defs.withK_get (Δ : Defs) (C : List Nat) (S : Nat → Def) (K : Nat → List Kind) (g : Nat) :
    (Δ.withK C S K)[g]? = Δ[g]?.map (fun dfn => if g ∈ C then (S g).raise (K g) else dfn) := by
  simp [Defs.withK, List.getElem?_mapIdx]

theorem KLe.le_get {a b : List Kind} (h : KLe a b) {j : Nat} {k k' : Kind} (ha : a[j]? = some k) (hb : b[j]? = some k') :
    k.le k' = true := by
  rw [Kind.le_iff_has]
  intro x hx
  have := h.2 j x (by simp [hasAt, ha, hx])
  simpa [hasAt, hb] using this

theorem kindsArgsOk_of_KLe {a b : List Kind} {ts : List Ty} (h : KLe a b) (hk : kindsArgsOk b ts = true) :
    kindsArgsOk a ts = true := by
  unfold kindsArgsOk
  rw [List.all_eq_true]
  intro p hp
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem hp
  simp only [List.length_zip] at hj
  have ha : j < a.length := by omega
  have hb : j < b.length := by rw [← h.1]; exact ha
  have hts : j < ts.length := by omega
  simp only [List.getElem_zip]
  exact Kind.le_kindOk (h.le_get (List.getElem?_eq_getElem ha) (List.getElem?_eq_getElem hb))
    (kindsArgsOk_get hk (List.getElem?_eq_getElem hb) (List.getElem?_eq_getElem hts))

/-- 型引数が強い方の kind の列を満たす限り、置き直した型の実体化は kind の列に依らない -/
theorem Ty.raise_inst_eq {k k' : List Kind} {ts : List Ty} (h : KLe k k') (hk : kindsArgsOk k' ts = true)
    (hl : ts.length = k'.length) :
    ∀ t : Ty, (t.tsubst (Kind.idArgs k)).tsubst ts = (t.tsubst (Kind.idArgs k')).tsubst ts := by
  intro t; induction t with
  | tvar i ρ kd =>
    cases hi : k'[i]? with
    | none =>
      have hi' : k[i]? = none := by
        rw [List.getElem?_eq_none_iff, h.1]; exact List.getElem?_eq_none_iff.mp hi
      simp [Ty.tsubst, Kind.idArgs_get, hi, hi']
    | some ki' =>
      have hil : i < k'.length := (List.getElem?_eq_some_iff.mp hi).1
      obtain ⟨ki, hki⟩ : ∃ ki, k[i]? = some ki := ⟨k[i]'(by rw [h.1]; exact hil), List.getElem?_eq_getElem _⟩
      have hle := h.le_get hki hi
      simp only [Ty.tsubst, Kind.idArgs_get, hi, hki, Option.map_some, Ty.atR]
      cases hs : ts[i]? with
      | none => exact absurd (List.getElem?_eq_none_iff.mp hs) (by omega)
      | some s =>
        have hok := kindsArgsOk_get hk hi hs
        cases hr' : ki'.rf
        · have hr : ki.rf = false := by
            cases hr : ki.rf
            · rfl
            · have := (Kind.le_iff_has.mp hle) .rf (by simp [Kind.has, hr]); simp_all [Kind.has]
          simp [hr]
        · cases hr : ki.rf
          · simp only [if_true, Bool.false_eq_true, if_false]; exact (kindOk_rf_atR hok hr' _ _)
          · simp
  | _ => simp_all [Ty.tsubst]

/-- K ≤ K'（C の上で添字ごと）なら、置き直した関数表 Δ.withK C S K' から Δ.withK C S K へ、呼び出しの規則が読む部分が保たれる -/
theorem Defs.withK_sim {Δ : Defs} {C : List Nat} {S : Nat → Def} {K K' : Nat → List Kind} (hle : KLeC C K K') :
    DefsSim (Δ.withK C S K') (Δ.withK C S K) := by
  intro fn dfn ts hfn hl hk
  rw [Defs.withK_get] at hfn
  obtain ⟨d0, hd0, rfl⟩ := Option.map_eq_some_iff.mp hfn
  by_cases hC : fn ∈ C
  · have h := hle fn hC
    refine ⟨(S fn).raise (K fn), by simp [Defs.withK_get, hd0, hC], ?_, ?_, ?_, ?_⟩
    · simp only [hC, if_true, Def.raise] at hl ⊢; rw [hl, h.1]
    · simp only [hC, if_true, Def.raise] at hk ⊢; exact kindsArgsOk_of_KLe h hk
    · simp only [hC, if_true, Def.raise, Def.inst] at hk hl ⊢; exact Ty.raise_inst_eq h hk hl _
    · simp only [hC, if_true, Def.raise, Def.inst] at hk hl ⊢; exact Ty.raise_inst_eq h hk hl _
  · refine ⟨d0, by simp [Defs.withK_get, hd0, hC], ?_, ?_, ?_, ?_⟩ <;> simp_all

/-- 呼び先の kind についての反単調性: 成分の行の kind を下げても（K ≤ K'）、導出は保たれる -/
theorem HasType.callee_anti {Δ : Defs} {C : List Nat} {S : Nat → Def} {K K' : Nat → List Kind} (hle : KLeC C K K')
    {Ξ Ψ f b d Γ Λ e t} (h : HasType (Δ.withK C S K') Ξ Ψ f b d Γ Λ e t) : HasType (Δ.withK C S K) Ξ Ψ f b d Γ Λ e t :=
  h.defs_sim (Defs.withK_sim hle)

end FS
