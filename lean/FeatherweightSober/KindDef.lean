import FeatherweightSober.KindMeetTy

/-!
# Def の 1 行分の meet

形の Def `S`（型変数の出現の旗は置き直しで決まる）が、関数表 Δ の下で kind の列 k1 でも k2 でも型付くなら、
添字ごとの弱い方 `meetL k1 k2` でも型付く。本体の型付けは `HasType.meet_typing` に、形の項として
`S.body.tsubstTy (idArgs m)` を渡して出す。
-/

namespace FS

/-- 置き直した型の出現の整形は、添字が範囲内であることと同じ（旗は置き直しの先の kind に揃う） -/
theorem Ty.tvWf_idArgs (k : List Kind) : ∀ t : Ty, (t.tsubst (Kind.idArgs k)).tvWf k = t.tvarsBelow k.length := by
  intro t; induction t with
  | tvar i ρ kd =>
    rw [Ty.tsubst_idArgs_tvar']
    cases h : k[i]? with
    | none => simp [Ty.tvWf, Ty.tvarsBelow, List.getElem?_eq_none_iff.mp h]
    | some a =>
      simp [Ty.tvWf, Ty.tvarsBelow, (List.getElem?_eq_some_iff.mp h).1, (List.getElem?_eq_some_iff.mp h).2, Kind.le_refl]
  | _ => simp_all [Ty.tsubst, Ty.tvWf, Ty.tvarsBelow]

theorem Expr.tvWf_idArgs {k k' : List Kind} (hl : k.length = k'.length) :
    ∀ e : Expr, (e.tsubstTy (Kind.idArgs k)).tvWf k = (e.tsubstTy (Kind.idArgs k')).tvWf k' := by
  have ho : ∀ ot : Option Ty, (ot.map (Ty.tsubst (Kind.idArgs k))).all (Ty.tvWf k) =
      (ot.map (Ty.tsubst (Kind.idArgs k'))).all (Ty.tvWf k') := by
    intro ot; cases ot <;> simp [Ty.tvWf_idArgs, hl]
  intro e; induction e <;>
    simp_all [Expr.tvWf, Expr.tsubstTy, Ty.tvWf_idArgs, List.all_map, Function.comp_def]

/-- 弱い方への置き直しの後に強い方へ置き直すと、強い方への置き直しと同じ（項の型注釈） -/
theorem Expr.idArgs_comp {m k : List Kind} (hl : m.length = k.length)
    (hrf : ∀ (j : Nat) (a c : Kind), m[j]? = Option.some a → k[j]? = Option.some c → a.rf = true → c.rf = true) :
    ∀ e : Expr, (e.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs k) = e.tsubstTy (Kind.idArgs k) := by
  have hc := Ty.idArgs_comp hl hrf
  intro e; induction e <;> simp_all [Expr.tsubstTy, List.map_map, Function.comp_def]

/-- Def の 1 行分の meet（行を固定）: 形の Def が kind の列 k1 でも k2 でも型付くなら、添字ごとの弱い方でも型付く -/
theorem DefOk.meet {Δ : Defs} (hΔ : SigOk Δ) {S : Def} {k1 k2 : List Kind} (hl : k1.length = k2.length)
    (n1 : KNorm k1) (n2 : KNorm k2) (h1 : DefOk Δ (S.raise k1)) (h2 : DefOk Δ (S.raise k2)) :
    DefOk Δ (S.raise (meetL k1 k2)) := by
  have H := MeetK.of_meetL hl n1 n2
  generalize meetL k1 k2 = m at H ⊢
  obtain ⟨p1, r1, nc1, -, -, s1, tv1, b1⟩ := h1
  obtain ⟨p2, r2, -, -, -, -, -, b2⟩ := h2
  simp only [Def.raise, Ty.paramOk, Bool.and_eq_true] at p1 p2 r1 r2 nc1 s1 b1 b2 ⊢
  simp only [Def.tvOk, Def.raise, Bool.and_eq_true, Ty.tvWf_idArgs] at tv1
  have hl1 : k1.length = m.length := H.l1
  have twm : ∀ t : Ty, t.tvarsBelow k1.length = true → (t.tsubst (Kind.idArgs m)).tvWf m = true := by
    intro t ht; rw [Ty.tvWf_idArgs, ← hl1]; exact ht
  have wp := twm _ tv1.1.1
  have wr := twm _ tv1.1.2
  have wb : (S.body.tsubstTy (Kind.idArgs m)).tvWf m = true := by
    rw [← Expr.tvWf_idArgs hl1]; exact tv1.2
  -- 本体: 形の項 S.body.tsubstTy (idArgs m) の 2 つの像
  have e1 : ((S.body.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs k1)) = S.body.tsubstTy (Kind.idArgs k1) :=
    Expr.idArgs_comp H.l1.symm H.rf1 _
  have e2 : ((S.body.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs k2)) = S.body.tsubstTy (Kind.idArgs k2) :=
    Expr.idArgs_comp H.l2.symm H.rf2 _
  have em : ((S.body.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs m)) = S.body.tsubstTy (Kind.idArgs m) :=
    Expr.idArgs_comp rfl (fun j a c h1 h2 hr => by rw [h1] at h2; cases h2; exact hr) _
  have g1 : HasType Δ ∅ [] 1 0 2 ([S.param.tsubst (Kind.idArgs m)].map (Ty.tsubst (Kind.idArgs k1))) (LCtx.img [] k1)
      ((S.body.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs k1)) (S.ret.tsubst (Kind.idArgs k1)) := by
    simpa [e1, H.comp1] using b1
  have g2 : HasType Δ ∅ [] 1 0 2 ([S.param.tsubst (Kind.idArgs m)].map (Ty.tsubst (Kind.idArgs k2))) (LCtx.img [] k2)
      ((S.body.tsubstTy (Kind.idArgs m)).tsubstTy (Kind.idArgs k2)) (S.ret.tsubst (Kind.idArgs k2)) := by
    simpa [e2, H.comp2] using b2
  obtain ⟨T, -, hT1, hT2, hm⟩ := HasType.meet_typing H hΔ g1 g2
    (by simpa [Expr.src_tsubstTy] using s1) wb (by simpa using wp) (by simp)
  have hT : T.tsubst (Kind.idArgs m) = S.ret.tsubst (Kind.idArgs m) :=
    H.inj2 (by rw [hT1]) (by rw [hT2])
  rw [hT, em] at hm
  simp only [List.map_cons, List.map_nil, H.compm] at hm
  refine ⟨?_, H.retOk r1 r2, ?_, Ty.tvarsBelow_of_tvWf wp, Ty.tvarsBelow_of_tvWf wr, ?_, ?_, hm⟩
  · simp only [Ty.paramOk, Bool.and_eq_true]; exact ⟨H.regionsBelow p1.1 p2.1, H.argFree p1.2 p2.2⟩
  · rw [Expr.noNewchan_tsubstTy] at nc1 ⊢; exact nc1
  · rw [Expr.src_tsubstTy] at s1 ⊢; exact s1
  · simp only [Def.tvOk, Bool.and_eq_true]; exact ⟨⟨wp, wr⟩, wb⟩

end FS
