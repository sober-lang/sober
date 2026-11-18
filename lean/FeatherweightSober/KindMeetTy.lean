import FeatherweightSober.KindMeet

/-!
# kind の meet（型付けの帰納）

KindMeet.lean の部品で、形の項の帰納を組む。
-/

namespace FS

/-! ## meet の定理（形の帰納） -/

/-- k の世界の像の文脈 -/
abbrev LCtx.img (Λ : LCtx) (k : List Kind) : LCtx := Λ.map (fun p => (p.1.tsubst (Kind.idArgs k), p.2))

namespace HasType

set_option maxHeartbeats 1000000 in
/-- 形の項 e（型変数の出現の旗は m 以下）の k1 と k2 の世界の像が型付くなら、m の世界の像も型付く。
型は、形の型 T の像として揃う -/
theorem meet_typing {k1 k2 m : List Kind} (H : MeetK k1 k2 m) {Δ : Defs} (hΔ : SigOk Δ) :
    ∀ {e : Expr} {f b d : Nat} {Γ : Ctx} {Λ : LCtx} {t1 t2 : Ty},
    HasType Δ ∅ [] f b d (Γ.map (Ty.tsubst (Kind.idArgs k1))) (Λ.img k1) (e.tsubstTy (Kind.idArgs k1)) t1 →
    HasType Δ ∅ [] f b d (Γ.map (Ty.tsubst (Kind.idArgs k2))) (Λ.img k2) (e.tsubstTy (Kind.idArgs k2)) t2 →
    e.src = true → e.tvWf m = true → (∀ τ ∈ Γ, τ.tvWf m = true) → (∀ p ∈ Λ, p.1.tvWf m = true) →
    ∃ T : Ty, T.tvWf m = true ∧ T.tsubst (Kind.idArgs k1) = t1 ∧ T.tsubst (Kind.idArgs k2) = t2 ∧
      HasType Δ ∅ [] f b d (Γ.map (Ty.tsubst (Kind.idArgs m))) (Λ.img m) (e.tsubstTy (Kind.idArgs m))
        (T.tsubst (Kind.idArgs m)) := by
  intro e
  induction e with
  | lit n => intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _; cases h1; cases h2; exact ⟨.int, rfl, rfl, rfl, .lit⟩
  | tt => intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _; cases h1; cases h2; exact ⟨.bool, rfl, rfl, rfl, .tt⟩
  | ff => intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _; cases h1; cases h2; exact ⟨.bool, rfl, rfl, rfl, .ff⟩
  | triv => intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _; cases h1; cases h2; exact ⟨.unit, rfl, rfl, rfl, .triv⟩
  | flit n => intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _; cases h1; cases h2; exact ⟨.f64, rfl, rfl, rfl, .flit⟩
  | blit n => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | var i =>
    intro f b d Γ Λ t1 t2 h1 h2 _ _ hΓ _
    cases h1 with
    | var g1 =>
      cases h2 with
      | var g2 =>
        rw [List.getElem?_map] at g1 g2
        obtain ⟨τ, hτ, rfl⟩ := Option.map_eq_some_iff.mp g1
        rw [hτ] at g2; cases g2
        exact ⟨τ, hΓ _ (List.mem_of_getElem? hτ), rfl, rfl, .var (by rw [List.getElem?_map, hτ]; rfl)⟩
  | letE e body ihe ihb =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | letE a1 c1 =>
      cases h2 with
      | letE a2 c2 =>
        obtain ⟨T1, w1, e1, e2, r1⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        subst e1 e2
        obtain ⟨T2, w2, e1, e2, r2⟩ := ihb (Γ := T1 :: Γ) c1 c2 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨w1, hΓ⟩) hΛ
        exact ⟨T2, w2, e1, e2, .letE r1 r2⟩
  | add a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | add a1 c1 =>
      cases h2 with
      | add a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_int ea; cases Ty.idArgs_inv_int ec
        exact ⟨.int, rfl, rfl, rfl, .add ra rc⟩
  | ite c th el ihc iht ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | ite c1 a1 b1 =>
      cases h2 with
      | ite c2 a2 b2 =>
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.1.1 hE.1.1 hΓ hΛ
        cases Ty.idArgs_inv_bool ec
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := iht a1 a2 hs.1.2 hE.1.2 hΓ hΛ
        obtain ⟨Tb, -, eb1, eb2, rb⟩ := ihe b1 b2 hs.2 hE.2 hΓ hΛ
        rw [← H.inj2 (ea1.trans eb1.symm) (ea2.trans eb2.symm)] at rb
        exact ⟨Ta, wa, ea1, ea2, .ite rc ra rb⟩
  | nil t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1; cases h2; exact ⟨.opt t₀, by simpa [Ty.tvWf] using hE, rfl, rfl, .nil⟩
  | some e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | some a1 =>
      cases h2 with
      | some a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        exact ⟨.opt T, w, by simp [Ty.tsubst, e1], by simp [Ty.tsubst, e2], .some r⟩
  | fst e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | fst a1 =>
      cases h2 with
      | fst a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨L, R, rfl, el, -⟩ := Ty.idArgs_inv_prod e1
        simp only [Ty.tsubst, Ty.prod.injEq] at e2
        simp only [Ty.tvWf, Bool.and_eq_true] at w
        exact ⟨L, w.1, el, e2.1, .fst r⟩
  | ann e t₀ ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | ann a1 s1 =>
      cases h2 with
      | ann a2 s2 =>
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        subst e1 e2
        exact ⟨t₀, hE.1, rfl, rfl, .ann r (H.sub s1 s2)⟩
  | lt a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | lt a1 c1 =>
      cases h2 with
      | lt a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_int ea; cases Ty.idArgs_inv_int ec
        exact ⟨.bool, rfl, rfl, rfl, .lt ra rc⟩
  | arith op a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | arith a1 c1 =>
      cases h2 with
      | arith a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_int ea; cases Ty.idArgs_inv_int ec
        exact ⟨.int, rfl, rfl, rfl, .arith ra rc⟩
  | farith op a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | farith a1 c1 =>
      cases h2 with
      | farith a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_f64 ea; cases Ty.idArgs_inv_f64 ec
        exact ⟨.f64, rfl, rfl, rfl, .farith ra rc⟩
  | cmp op a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | cmp a1 c1 =>
      cases h2 with
      | cmp a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_int ea; cases Ty.idArgs_inv_int ec
        exact ⟨.bool, rfl, rfl, rfl, .cmp ra rc⟩
  | fcmp op a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | fcmp a1 c1 =>
      cases h2 with
      | fcmp a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_f64 ea; cases Ty.idArgs_inv_f64 ec
        exact ⟨.bool, rfl, rfl, rfl, .fcmp ra rc⟩
  | whileE c body ihc ihb =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | whileE c1 a1 =>
      cases h2 with
      | whileE c2 a2 =>
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.1 hE.1 hΓ hΛ
        cases Ty.idArgs_inv_bool ec
        obtain ⟨Ta, -, -, -, ra⟩ := ihb a1 a2 hs.2 hE.2 hΓ hΛ
        exact ⟨.unit, rfl, rfl, rfl, .whileE rc ra⟩
  | tobyte e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | tobyte a1 =>
      cases h2 with
      | tobyte a2 =>
        obtain ⟨T, -, e1, -, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        cases Ty.idArgs_inv_int e1
        exact ⟨.byte, rfl, rfl, rfl, .tobyte r⟩
  | toint e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | toint a1 =>
      cases h2 with
      | toint a2 =>
        obtain ⟨T, -, e1, -, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        cases Ty.idArgs_inv_byte e1
        exact ⟨.int, rfl, rfl, rfl, .toint r⟩
  | ifnil e n sb ihe ihn ihs =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | ifnil a1 n1 s1 =>
      cases h2 with
      | ifnil a2 n2 s2 =>
        obtain ⟨Te, we, ee1, ee2, re⟩ := ihe a1 a2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨U, rfl, eu1⟩ := Ty.idArgs_inv_opt ee1
        simp only [Ty.tsubst, Ty.opt.injEq] at ee2
        subst eu1 ee2
        simp only [Ty.tvWf] at we
        obtain ⟨Tn, wn, en1, en2, rn⟩ := ihn n1 n2 hs.1.2 hE.1.2 hΓ hΛ
        obtain ⟨Ts, -, es1, es2, rs⟩ := ihs (Γ := U :: Γ) s1 s2 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨we, hΓ⟩) hΛ
        rw [← H.inj2 (en1.trans es1.symm) (en2.trans es2.symm)] at rs
        exact ⟨Tn, wn, en1, en2, .ifnil re rn rs⟩
  | inl r e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | inl a1 =>
      cases h2 with
      | inl a2 =>
        obtain ⟨T, w, e1, e2, re⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        exact ⟨.union T r, by simp [Ty.tvWf, w, hE.1], by simp [Ty.tsubst, e1], by simp [Ty.tsubst, e2], .inl re⟩
  | inr l e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | inr a1 =>
      cases h2 with
      | inr a2 =>
        obtain ⟨T, w, e1, e2, re⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        exact ⟨.union l T, by simp [Ty.tvWf, w, hE.1], by simp [Ty.tsubst, e1], by simp [Ty.tsubst, e2], .inr re⟩
  | case e bl br ihe ihl ihr =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | case a1 l1 r1 =>
      cases h2 with
      | case a2 l2 r2 =>
        obtain ⟨Te, we, ee1, ee2, re⟩ := ihe a1 a2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨L, R, rfl, el1, er1⟩ := Ty.idArgs_inv_union ee1
        simp only [Ty.tsubst, Ty.union.injEq] at ee2
        obtain ⟨el2, er2⟩ := ee2
        subst el1 er1 el2 er2
        simp only [Ty.tvWf, Bool.and_eq_true] at we
        obtain ⟨Tl, wl, fl1, fl2, rl⟩ := ihl (Γ := L :: Γ) l1 l2 hs.1.2 hE.1.2 (List.forall_mem_cons.mpr ⟨we.1, hΓ⟩) hΛ
        obtain ⟨Tr, -, fr1, fr2, rr⟩ := ihr (Γ := R :: Γ) r1 r2 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨we.2, hΓ⟩) hΛ
        rw [← H.inj2 (fl1.trans fr1.symm) (fl2.trans fr2.symm)] at rr
        exact ⟨Tl, wl, fl1, fl2, .case re rl rr⟩
  | pair a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | pair a1 c1 =>
      cases h2 with
      | pair a2 c2 =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, wc, ec1, ec2, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        exact ⟨.prod Ta Tc, by simp [Ty.tvWf, wa, wc], by simp [Ty.tsubst, ea1, ec1], by simp [Ty.tsubst, ea2, ec2], .pair ra rc⟩
  | snd e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | snd a1 =>
      cases h2 with
      | snd a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨L, R, rfl, -, er⟩ := Ty.idArgs_inv_prod e1
        simp only [Ty.tsubst, Ty.prod.injEq] at e2
        simp only [Ty.tvWf, Bool.and_eq_true] at w
        exact ⟨R, w.2, er, e2.2, .snd r⟩
  | unreach t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1; cases h2; exact ⟨t₀, hE, rfl, rfl, .unreach⟩
  | deref e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | deref a1 =>
      cases h2 with
      | deref a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_ref e1
        simp only [Ty.tsubst, Ty.ref.injEq] at e2
        simp only [Ty.tvWf] at w
        exact ⟨X, w, ex, e2.2.2, .deref r⟩
  | assign l e ihl ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | assign l1 a1 =>
      cases h2 with
      | assign l2 a2 =>
        obtain ⟨Tl, wl, el1, el2, rl⟩ := ihl l1 l2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, ex1⟩ := Ty.idArgs_inv_ref el1
        simp only [Ty.tsubst, Ty.ref.injEq] at el2
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.2 hE.2 hΓ hΛ
        rw [H.inj2 (ea1.trans ex1.symm) (ea2.trans el2.2.2.symm)] at ra
        exact ⟨.unit, rfl, rfl, rfl, .assign rl ra⟩
  | lenE e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | lenE a1 =>
      cases h2 with
      | lenE a2 =>
        obtain ⟨T, -, e1, -, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice e1
        exact ⟨.int, rfl, rfl, rfl, .lenE r⟩
  | lenm e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | lenm a1 =>
      cases h2 with
      | lenm a2 =>
        obtain ⟨T, -, e1, -, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_map e1
        exact ⟨.int, rfl, rfl, rfl, .lenm r⟩
  | fnref fn ts' =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    have hws : ∀ s ∈ ts', s.tvWf m = true := fun s hs => List.all_eq_true.mp hE s hs
    cases h1 with
    | fnref hfn hlen hargs =>
      rename_i dfn
      cases h2 with
      | fnref hfn2 _ hargs2 =>
        rw [hfn] at hfn2; cases hfn2
        obtain ⟨-, hwp, hwr, htp, htr⟩ := hΔ fn dfn hfn
        simp only [List.length_map] at hlen
        rw [← hlen] at hwp hwr
        refine ⟨.fn (dfn.param.tsubst (ts'.map (Ty.tsubst (Kind.idArgs m))))
            (dfn.ret.tsubst (ts'.map (Ty.tsubst (Kind.idArgs m)))), ?_, ?_, ?_, ?_⟩
        · simp [Ty.tvWf, H.inst_wf htp hlen hws, H.inst_wf htr hlen hws]
        · simp [Ty.tsubst, Def.inst, H.inst_img1 hwp hws, H.inst_img1 hwr hws]
        · simp [Ty.tsubst, Def.inst, H.inst_img2 hwp hws, H.inst_img2 hwr hws]
        · simp only [Ty.tsubst, H.inst_imgm hwp hws, H.inst_imgm hwr hws, Expr.tsubstTy]
          exact .fnref hfn (by simp [hlen]) (H.kindsArgsOk hws hargs hargs2)
  | callv a ef e ihf ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | callv f1 a1 s1 bd1 ad1 ro1 =>
      rename_i d' _ _ _
      cases h2 with
      | callv f2 a2 s2 _ _ ro2 =>
        obtain ⟨Tf, wf, ef1, ef2, rf⟩ := ihf f1 f2 hs.1 hE.1 hΓ hΛ
        obtain ⟨P, R, rfl, ep1, er1⟩ := Ty.idArgs_inv_fn ef1
        simp only [Ty.tsubst, Ty.fn.injEq] at ef2
        obtain ⟨ep2, er2⟩ := ef2
        subst ep1 er1 ep2 er2
        simp only [Ty.tvWf, Bool.and_eq_true] at wf
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.2 hE.2 hΓ hΛ
        subst ea1 ea2
        rw [Ty.tsubst_renR _ (H.K1 wf.1)] at s1
        rw [Ty.tsubst_renR _ (H.K2 wf.1)] at s2
        have hsub := H.sub s1 s2
        rw [← Ty.tsubst_renR _ (H.Km wf.1)] at hsub
        have hro := H.retOk ro1 ro2
        have wR := H.wm wf.2
        refine ⟨(R.tsubst (Kind.idArgs m)).relocA a d', by rw [Ty.tvWf_relocA]; exact wR, ?_, ?_, ?_⟩
        · rw [← Ty.tsubst_relocA _ hro (H.K1 wR), H.comp1]
        · rw [← Ty.tsubst_relocA _ hro (H.K2 wR), H.comp2]
        · rw [← Ty.tsubst_relocA _ hro (H.Km wR), H.compm]
          simp only [Ty.tsubst] at rf
          exact .callv rf ra hsub bd1 ad1 hro
  | call a fn ts' e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    have hws : ∀ s ∈ ts', s.tvWf m = true := fun s hs => List.all_eq_true.mp hE.1 s hs
    cases h1 with
    | call hfn hlen hargs a1 s1 bd1 ad1 =>
      rename_i d' dfn _
      cases h2 with
      | call hfn2 _ hargs2 a2 s2 _ _ =>
        rw [hfn] at hfn2; cases hfn2
        obtain ⟨hr, hwp, hwr, htp, htr⟩ := hΔ fn dfn hfn
        simp only [List.length_map] at hlen
        rw [← hlen] at hwp hwr
        have hargsm := H.kindsArgsOk hws hargs hargs2
        have wP := H.inst_wf htp hlen hws
        have wR := H.inst_wf htr hlen hws
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        subst ea1 ea2
        simp only [Def.inst] at s1 s2 ⊢
        rw [← H.inst_img1 hwp hws, Ty.tsubst_renR _ (H.K1 wP)] at s1
        rw [← H.inst_img2 hwp hws, Ty.tsubst_renR _ (H.K2 wP)] at s2
        have hsub := H.sub s1 s2
        rw [← Ty.tsubst_renR _ (H.Km wP), H.inst_imgm hwp hws] at hsub
        have hro : (dfn.ret.tsubst (ts'.map (Ty.tsubst (Kind.idArgs m)))).retOk = true :=
          Ty.retOk_tsubst _ hr (Ty.kindsOk_of_tvWf hargsm htr)
        refine ⟨(dfn.ret.tsubst (ts'.map (Ty.tsubst (Kind.idArgs m)))).relocA a d', by rw [Ty.tvWf_relocA]; exact wR,
          ?_, ?_, ?_⟩
        · rw [← Ty.tsubst_relocA _ hro (H.K1 wR), H.inst_img1 hwr hws]
        · rw [← Ty.tsubst_relocA _ hro (H.K2 wR), H.inst_img2 hwr hws]
        · rw [← Ty.tsubst_relocA _ hro (H.Km wR), H.inst_imgm hwr hws]
          exact .call hfn (by simp [hlen]) hargsm ra (by simpa [Def.inst] using hsub) bd1 ad1
  | blockR t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | blockR a1 r1 rb1 =>
      cases h2 with
      | blockR a2 r2 rb2 =>
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        subst e1 e2
        exact ⟨t₀, hE.1, rfl, rfl, .blockR r (H.jumpRel r1 r2) (H.regionsBelow rb1 rb2)⟩
  | copyTo k t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | copyTo a1 hk r1 rb1 c1 =>
      cases h2 with
      | copyTo a2 _ r2 rb2 c2 =>
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        subst e1 e2
        exact ⟨t₀, hE.1, rfl, rfl, .copyTo r hk (H.jumpRel r1 r2) (H.regionsBelow rb1 rb2) (H.chanFree c1 c2)⟩
  | jump n t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | jump hn1 a1 r1 =>
      cases h2 with
      | jump hn2 a2 r2 =>
        simp only [LCtx.img, List.getElem?_map] at hn1 hn2
        obtain ⟨p, hp, hp1⟩ := Option.map_eq_some_iff.mp hn1
        rw [hp] at hn2
        simp only [Option.map_some, Option.some.injEq, Prod.mk.injEq] at hn2 hp1
        obtain ⟨rfl, rfl⟩ := hp1
        obtain ⟨rfl, rfl⟩ := hn2
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        subst e1 e2
        exact ⟨t₀, hE.1, rfl, rfl, .jump (by simp [LCtx.img, List.getElem?_map, hp]) r (H.jumpRel r1 r2)⟩
  | scope t₀ ε₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | scope a1 r1 rb1 em1 ec1 bd1 =>
      cases h2 with
      | scope a2 r2 rb2 em2 ec2 _ =>
        have hΓ' : ∀ τ ∈ (Ty.own .scope d ε₀ :: Γ), τ.tvWf m = true :=
          List.forall_mem_cons.mpr ⟨by simpa [Ty.tvWf] using hE.1.2, hΓ⟩
        obtain ⟨T, -, e1, e2, r⟩ := ihe (Γ := Ty.own .scope d ε₀ :: Γ) (Λ := []) a1 a2 hs hE.2 hΓ' (by simp)
        subst e1 e2
        have hmm := H.mutFree em1 em2
        have hcm := H.chanFree ec1 ec2
        have wε := H.wm hE.1.2
        refine ⟨.union t₀ (.union .unit ((ε₀.tsubst (Kind.idArgs m)).relocR (d - 1))),
          by simp [Ty.tvWf, Ty.tvWf_relocR, hE.1.1, wε], ?_, ?_, ?_⟩
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K1 wε), H.comp1]
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K2 wε), H.comp2]
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.Km wε), H.compm]
          exact .scope r (H.jumpRel r1 r2) (H.regionsBelow rb1 rb2) hmm hcm bd1
  | loc _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | slicev _ _ _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | mapv _ _ _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | chanV _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | scopeV _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | taskV _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | block e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | block a1 rb1 =>
      cases h2 with
      | block a2 rb2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        subst e1 e2
        exact ⟨T, w, rfl, rfl, .block r (H.regionsBelow rb1 rb2)⟩
  | label t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | label a1 rb1 =>
      cases h2 with
      | label a2 rb2 =>
        obtain ⟨T, -, e1, e2, r⟩ := ihe (Λ := (t₀, d - 1) :: Λ) a1 a2 hs hE.2 hΓ
          (List.forall_mem_cons.mpr ⟨hE.1, hΛ⟩)
        rw [H.inj2 e1 e2] at r
        exact ⟨t₀, hE.1, rfl, rfl, .label r (H.regionsBelow rb1 rb2)⟩
  | alloc mu e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | alloc a1 rb1 bd1 mf1 =>
      cases h2 with
      | alloc a2 rb2 _ mf2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        subst e1 e2
        exact ⟨.ref mu _ T, by simpa [Ty.tvWf] using w, rfl, rfl,
          .alloc r (H.regionsBelow rb1 rb2) bd1 (fun h => H.mutFree (mf1 h) (mf2 h))⟩
  | freeze e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | freeze a1 mf1 =>
      cases h2 with
      | freeze a2 mf2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_ref e1
        simp only [Ty.tsubst, Ty.ref.injEq] at e2
        obtain ⟨-, rfl, rfl⟩ := e2
        exact ⟨.ref false _ X, by simpa [Ty.tvWf] using w, rfl, rfl, .freeze r (H.mutFree mf1 mf2)⟩
      | freezes a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_ref e1
        simp [Ty.tsubst] at e2
      | freezem a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_ref e1
        simp [Ty.tsubst] at e2
    | freezes a1 mf1 =>
      cases h2 with
      | freezes a2 mf2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_slice e1
        simp only [Ty.tsubst, Ty.slice.injEq] at e2
        obtain ⟨-, rfl, rfl⟩ := e2
        exact ⟨.slice false _ X, by simpa [Ty.tvWf] using w, rfl, rfl, .freezes r (H.mutFree mf1 mf2)⟩
      | freeze a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice e1
        simp [Ty.tsubst] at e2
      | freezem a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice e1
        simp [Ty.tsubst] at e2
    | freezem a1 mf1 =>
      cases h2 with
      | freezem a2 mf2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_map e1
        simp only [Ty.tsubst, Ty.map.injEq] at e2
        obtain ⟨-, rfl, rfl⟩ := e2
        exact ⟨.map false _ X, by simpa [Ty.tvWf] using w, rfl, rfl, .freezem r (H.mutFree mf1 mf2)⟩
      | freeze a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_map e1
        simp [Ty.tsubst] at e2
      | freezes a2 _ =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_map e1
        simp [Ty.tsubst] at e2
  | mkslice mu t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1 with
    | mkslice rb1 bd1 mf1 =>
      cases h2 with
      | mkslice rb2 _ mf2 =>
        exact ⟨.slice mu _ t₀, by simpa [Ty.tvWf] using hE, rfl, rfl,
          .mkslice (H.regionsBelow rb1 rb2) bd1 (fun h => H.mutFree (mf1 h) (mf2 h))⟩
  | strlit bs r =>
    intro f b d Γ Λ t1 t2 h1 h2 _ _ _ _
    cases h1 with
    | strlit hb hr => cases h2; exact ⟨.slice false r .byte, rfl, rfl, rfl, .strlit hb hr⟩
  | mksliceAt mu t₀ r =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1 with
    | mksliceAt rb1 bd1 rd1 mf1 cf1 =>
      cases h2 with
      | mksliceAt rb2 _ _ mf2 cf2 =>
        exact ⟨.slice mu r t₀, by simpa [Ty.tvWf] using hE, rfl, rfl,
          .mksliceAt (H.regionsBelow rb1 rb2) bd1 rd1 (fun h => H.mutFree (mf1 h) (mf2 h)) (H.chanFree cf1 cf2)⟩
  | fconv op e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | fconv a1 =>
      cases h2 with
      | fconv a2 =>
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        have hd : ∀ k : List Kind, op.dom.tsubst (Kind.idArgs k) = op.dom := by intro k; cases op <;> rfl
        have hc : ∀ k : List Kind, op.cod.tsubst (Kind.idArgs k) = op.cod := by intro k; cases op <;> rfl
        rw [← hd k1] at e1; rw [← hd k2] at e2
        rw [H.inj2 e1 e2, hd m] at r
        exact ⟨op.cod, by cases op <;> rfl, hc k1, hc k2, by rw [hc m]; exact .fconv r⟩
  | setidx e i v ihe ihi ihv =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | setidx a1 i1 v1 =>
      cases h2 with
      | setidx a2 i2 v2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨X, rfl, ex1⟩ := Ty.idArgs_inv_slice ea1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2
        obtain ⟨Ti, -, ei, -, ri⟩ := ihi i1 i2 hs.1.2 hE.1.2 hΓ hΛ
        cases Ty.idArgs_inv_int ei
        obtain ⟨Tv, -, ev1, ev2, rv⟩ := ihv v1 v2 hs.2 hE.2 hΓ hΛ
        rw [H.inj2 (ev1.trans ex1.symm) (ev2.trans ea2.2.2.symm)] at rv
        exact ⟨.unit, rfl, rfl, rfl, .setidx ra ri rv⟩
  | subslice e sa sb ihe iha ihb =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | subslice a1 i1 j1 =>
      cases h2 with
      | subslice a2 i2 j2 =>
        obtain ⟨Ta, w, ea1, ea2, ra⟩ := ihe a1 a2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨Ti, -, ei, -, ri⟩ := iha i1 i2 hs.1.2 hE.1.2 hΓ hΛ
        cases Ty.idArgs_inv_int ei
        obtain ⟨Tj, -, ej, -, rj⟩ := ihb j1 j2 hs.2 hE.2 hΓ hΛ
        cases Ty.idArgs_inv_int ej
        obtain ⟨X, rfl, ex1⟩ := Ty.idArgs_inv_slice ea1
        exact ⟨_, w, by simp [Ty.tsubst, ex1], ea2, .subslice ra ri rj⟩
  | eqs a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | eqs a1 c1 =>
      cases h2 with
      | eqs a2 c2 =>
        obtain ⟨Ta, -, ea, -, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec, -, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        obtain ⟨Xa, rfl, xa⟩ := Ty.idArgs_inv_slice ea
        obtain ⟨Xc, rfl, xc⟩ := Ty.idArgs_inv_slice ec
        cases Ty.idArgs_inv_byte xa; cases Ty.idArgs_inv_byte xc
        exact ⟨.bool, rfl, rfl, rfl, .eqs ra rc⟩
  | concat a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | concat a1 c1 bd1 =>
      cases h2 with
      | concat a2 c2 _ =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := iha a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨Tc, -, ec1, ec2, rc⟩ := ihc c1 c2 hs.2 hE.2 hΓ hΛ
        obtain ⟨Xa, rfl, xa1⟩ := Ty.idArgs_inv_slice ea1
        obtain ⟨Xc, rfl, xc1⟩ := Ty.idArgs_inv_slice ec1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2 ec2
        simp only [Ty.tsubst] at rc
        rw [H.inj2 (xc1.trans xa1.symm) (ec2.2.2.trans ea2.2.2.symm)] at rc
        simp only [Ty.tvWf] at wa
        exact ⟨.slice false _ Xa, by simpa [Ty.tvWf] using wa, by simp [Ty.tsubst, xa1], by simp [Ty.tsubst, ea2.2.2],
          .concat (by simpa [Ty.tsubst] using ra) rc bd1⟩
  | append e v ihe ihv =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | appendM a1 v1 br1 =>
      cases h2 with
      | appendM a2 v2 _ =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_slice ea1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2
        obtain ⟨-, rfl, rfl⟩ := ea2
        obtain ⟨Tv, -, ev1, ev2, rv⟩ := ihv v1 v2 hs.2 hE.2 hΓ hΛ
        rw [H.inj2 ev1 ev2] at rv
        exact ⟨_, wa, rfl, rfl, .appendM ra rv br1⟩
      | appendI a2 _ _ _ =>
        obtain ⟨Ta, -, ea1, ea2, -⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice ea1
        simp [Ty.tsubst] at ea2
    | appendI a1 v1 bd1 rb1 =>
      cases h2 with
      | appendI a2 v2 _ rb2 =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, ex1⟩ := Ty.idArgs_inv_slice ea1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2
        obtain ⟨Tv, -, ev1, ev2, rv⟩ := ihv v1 v2 hs.2 hE.2 hΓ hΛ
        rw [H.inj2 (ev1.trans ex1.symm) (ev2.trans ea2.2.2.symm)] at rv
        subst ex1
        rw [← ea2.2.2] at rb2
        simp only [Ty.tvWf] at wa
        exact ⟨.slice false _ X, by simpa [Ty.tvWf] using wa, rfl, by simp [Ty.tsubst, ea2.2.2],
          .appendI ra rv bd1 (H.regionsBelow rb1 rb2)⟩
      | appendM a2 _ _ =>
        obtain ⟨Ta, -, ea1, ea2, -⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice ea1
        simp [Ty.tsubst] at ea2
  | keysm e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | keysm a1 ko1 rb1 bd1 =>
      cases h2 with
      | keysm a2 ko2 rb2 _ =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨P, rfl, ep⟩ := Ty.idArgs_inv_map ea1
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod ep
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_opt eo
        simp only [Ty.tsubst, Ty.map.injEq, Ty.prod.injEq, Ty.opt.injEq] at ea2
        obtain ⟨-, -, rfl, rfl⟩ := ea2
        subst ek ex
        simp only [Ty.tvWf, Bool.and_eq_true] at wa
        exact ⟨.slice false _ K, by simpa [Ty.tvWf] using wa.1, rfl, rfl,
          .keysm ra (H.keyOk ko1 ko2) (H.regionsBelow rb1 rb2) bd1⟩
  | setm e k v ihe ihk ihv =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | setm a1 k1' v1 =>
      cases h2 with
      | setm a2 k2' v2 =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨P, rfl, ep⟩ := Ty.idArgs_inv_map ea1
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod ep
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_opt eo
        simp only [Ty.tsubst, Ty.map.injEq, Ty.prod.injEq, Ty.opt.injEq] at ea2
        obtain ⟨Tk, -, ek1, ek2, rk⟩ := ihk k1' k2' hs.1.2 hE.1.2 hΓ hΛ
        obtain ⟨Tv, -, ev1, ev2, rv⟩ := ihv v1 v2 hs.2 hE.2 hΓ hΛ
        obtain ⟨-, rfl, rfl, rfl⟩ := ea2
        subst ek ex
        rw [H.inj2 ek1 ek2] at rk
        rw [H.inj2 ev1 ev2] at rv
        exact ⟨_, wa, rfl, rfl, .setm ra rk rv⟩
  | index e i ot ihe ihi =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | index a1 i1 rd1 =>
      cases h2 with
      | index a2 i2 rd2 =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1.1 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_slice ea1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2
        obtain ⟨rfl, -, rfl⟩ := ea2
        obtain ⟨Ti, -, ei, -, ri⟩ := ihi i1 i2 hs.2 hE.1.2 hΓ hΛ
        cases Ty.idArgs_inv_int ei
        obtain ⟨T, hT, e1, e2, rd⟩ := H.readAs rd1 rd2
        refine ⟨T, ?_, e1, e2, .index ra ri rd⟩
        rcases hT with rfl | rfl
        · simpa [Ty.tvWf] using wa
        · simpa using hE.2
  | getm t₀ e k ihe ihk =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | getm a1 k1' kc1 sb1 =>
      cases h2 with
      | getm a2 k2' kc2 sb2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1.2 hΓ hΛ
        obtain ⟨P, rfl, ep⟩ := Ty.idArgs_inv_map ea1
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod ep
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_opt eo
        simp only [Ty.tsubst, Ty.map.injEq, Ty.prod.injEq, Ty.opt.injEq] at ea2
        obtain ⟨-, -, rfl, rfl⟩ := ea2
        subst ek ex
        obtain ⟨Tk, -, ek1, ek2, rk⟩ := ihk k1' k2' hs.2 hE.2 hΓ hΛ
        subst ek1 ek2
        exact ⟨.opt t₀, by simpa [Ty.tvWf] using hE.1.1, rfl, rfl, .getm ra rk (H.keyCompat kc1 kc2) (H.sub sb1 sb2)⟩
  | delm t₀ e k ihe ihk =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | delm a1 k1' kc1 =>
      cases h2 with
      | delm a2 k2' kc2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1.2 hΓ hΛ
        obtain ⟨P, rfl, ep⟩ := Ty.idArgs_inv_map ea1
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod ep
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_opt eo
        simp only [Ty.tsubst, Ty.map.injEq, Ty.prod.injEq, Ty.opt.injEq] at ea2
        obtain ⟨-, -, rfl, e2x⟩ := ea2
        subst ek
        simp only [Ty.tsubst] at ra
        rw [H.inj2 ex e2x] at ra
        obtain ⟨Tk, -, ek1, ek2, rk⟩ := ihk k1' k2' hs.2 hE.2 hΓ hΛ
        subst ek1 ek2
        exact ⟨.unit, rfl, rfl, rfl, .delm ra rk (H.keyCompat kc1 kc2)⟩
  | clone ot e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | clones a1 rd1 rb1 bd1 =>
      cases h2 with
      | clones a2 rd2 rb2 _ =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_slice ea1
        simp only [Ty.tsubst, Ty.slice.injEq] at ea2
        obtain ⟨rfl, -, rfl⟩ := ea2
        obtain ⟨T, hT, rfl, rfl, rd⟩ := H.readAs rd1 rd2
        have wT : T.tvWf m = true := by
          rcases hT with rfl | rfl
          · simpa [Ty.tvWf] using wa
          · simpa using hE.1
        exact ⟨.slice true _ T, by simpa [Ty.tvWf] using wT, rfl, rfl, .clones ra rd (H.regionsBelow rb1 rb2) bd1⟩
      | clonem a2 _ _ _ =>
        obtain ⟨Ta, -, ea1, ea2, -⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_slice ea1
        simp [Ty.tsubst] at ea2
    | clonem a1 rd1 rb1 bd1 =>
      cases h2 with
      | clonem a2 rd2 rb2 _ =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_map ea1
        simp only [Ty.tsubst, Ty.map.injEq] at ea2
        obtain ⟨rfl, -, rfl⟩ := ea2
        obtain ⟨T, hT, rfl, rfl, rd⟩ := H.readAs rd1 rd2
        have wT : T.tvWf m = true := by
          rcases hT with rfl | rfl
          · simpa [Ty.tvWf] using wa
          · simpa using hE.1
        exact ⟨.map true _ T, by simpa [Ty.tvWf] using wT, rfl, rfl, .clonem ra rd (H.regionsBelow rb1 rb2) bd1⟩
      | clones a2 _ _ _ =>
        obtain ⟨Ta, -, ea1, ea2, -⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_map ea1
        simp [Ty.tsubst] at ea2
  | mkmap mu t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    simp only [Expr.tsubstTy] at h1 h2 ⊢
    generalize hx1 : t₀.tsubst (Kind.idArgs k1) = x1 at h1
    generalize hx2 : t₀.tsubst (Kind.idArgs k2) = x2 at h2
    cases h1 with
    | mkmap ko1 rb1 bd1 mf1 =>
      cases h2 with
      | mkmap ko2 rb2 _ mf2 =>
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod hx1
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_opt eo
        subst ek
        simp only [Ty.tsubst, Ty.prod.injEq, Ty.opt.injEq] at hx2
        obtain ⟨rfl, rfl⟩ := hx2
        exact ⟨.map mu _ (.prod K (.opt X)), by simpa [Ty.tvWf] using hE, rfl, rfl,
          .mkmap (H.keyOk ko1 ko2) (H.regionsBelow (A := .prod K (.opt X)) rb1 rb2) bd1
            (fun h => H.mutFree (A := .prod K (.opt X)) (mf1 h) (mf2 h))⟩
  | mkmapAt mu t₀ r =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    simp only [Expr.tsubstTy] at h1 h2 ⊢
    generalize hx1 : t₀.tsubst (Kind.idArgs k1) = x1 at h1
    generalize hx2 : t₀.tsubst (Kind.idArgs k2) = x2 at h2
    cases h1 with
    | mkmapAt ko1 rb1 bd1 rd1 mf1 cf1 =>
      cases h2 with
      | mkmapAt ko2 rb2 _ _ mf2 cf2 =>
        obtain ⟨K, O, rfl, ek, eo⟩ := Ty.idArgs_inv_prod hx1
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_opt eo
        subst ek
        simp only [Ty.tsubst, Ty.prod.injEq, Ty.opt.injEq] at hx2
        obtain ⟨rfl, rfl⟩ := hx2
        exact ⟨.map mu r (.prod K (.opt X)), by simpa [Ty.tvWf] using hE, rfl, rfl,
          .mkmapAt (H.keyOk ko1 ko2) (H.regionsBelow (A := .prod K (.opt X)) rb1 rb2) bd1 rd1
            (fun h => H.mutFree (A := .prod K (.opt X)) (mf1 h) (mf2 h)) (H.chanFree (A := .prod K (.opt X)) cf1 cf2)⟩
  | newchan rc t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1 with
    | newchan hf rb1 mf1 =>
      cases h2 with
      | newchan _ rb2 mf2 =>
        exact ⟨.chan rc t₀, by simpa [Ty.tvWf] using hE, rfl, rfl, .newchan hf (H.regionsBelow rb1 rb2) (H.mutFree mf1 mf2)⟩
  | newch r cap t₀ =>
    intro f b d Γ Λ t1 t2 h1 h2 _ hE _ _
    simp only [Expr.tvWf] at hE
    cases h1 with
    | newch br1 rd1 cp1 mf1 cf1 rb1 =>
      cases h2 with
      | newch _ _ _ mf2 cf2 rb2 =>
        exact ⟨.prod (.own .tx r t₀) (.own .rx r t₀), by simp [Ty.tvWf, hE], rfl, rfl,
          .newch br1 rd1 cp1 (H.mutFree mf1 mf2) (H.chanFree cf1 cf2) (H.regionsBelow rb1 rb2)⟩
  | epV _ _ _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | domV _ _ _ => intro f b d Γ Λ t1 t2 h1 h2 hs _ _ _; simp [Expr.src] at hs
  | par a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | par a1 c1 g1 =>
      cases h2 with
      | par a2 c2 g2 =>
        obtain ⟨Ta, -, -, -, ra⟩ := iha (Λ := []) a1 a2 hs.1 hE.1 hΓ (by simp)
        obtain ⟨Tc, -, -, -, rc⟩ := ihc (Λ := []) c1 c2 hs.2 hE.2 hΓ (by simp)
        refine ⟨.unit, rfl, rfl, rfl, .par ra rc ?_⟩
        intro τ hτ
        obtain ⟨σ, hσ, rfl⟩ := List.mem_map.mp hτ
        exact H.mutFree (g1 _ (List.mem_map_of_mem hσ)) (g2 _ (List.mem_map_of_mem hσ))
  | parch t₀ a c iha ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | parch a1 c1 g1 rb1 mf1 =>
      cases h2 with
      | parch a2 c2 g2 rb2 mf2 =>
        have hΓ' : ∀ τ ∈ (Ty.chan d t₀ :: Γ), τ.tvWf m = true :=
          List.forall_mem_cons.mpr ⟨by simpa [Ty.tvWf] using hE.1.1, hΓ⟩
        obtain ⟨Ta, -, -, -, ra⟩ := iha (Γ := Ty.chan d t₀ :: Γ) (Λ := []) a1 a2 hs.1 hE.1.2 hΓ' (by simp)
        obtain ⟨Tc, -, -, -, rc⟩ := ihc (Γ := Ty.chan d t₀ :: Γ) (Λ := []) c1 c2 hs.2 hE.2 hΓ' (by simp)
        refine ⟨.unit, rfl, rfl, rfl, .parch ra rc ?_ (H.regionsBelow rb1 rb2) (H.mutFree mf1 mf2)⟩
        intro τ hτ
        obtain ⟨σ, hσ, rfl⟩ := List.mem_map.mp hτ
        exact H.mutFree (g1 _ (List.mem_map_of_mem hσ)) (g2 _ (List.mem_map_of_mem hσ))
  | join t₀ h ihh =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | join a1 =>
      cases h2 with
      | join a2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihh a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_own ea1
        simp only [Ty.tsubst, Ty.own.injEq] at ea2
        simp only [Ty.tsubst] at ra
        rw [H.inj2 ex ea2.2.2] at ra
        exact ⟨t₀, hE.1, rfl, rfl, .join ra⟩
  | tryJ t₀ h ihh =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | tryJ a1 =>
      cases h2 with
      | tryJ a2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihh a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_own ea1
        simp only [Ty.tsubst, Ty.own.injEq] at ea2
        simp only [Ty.tsubst] at ra
        rw [H.inj2 ex ea2.2.2] at ra
        exact ⟨.opt t₀, by simpa [Ty.tvWf] using hE.1, rfl, rfl, .tryJ ra⟩
  | send c e ihc ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | send c1 a1 =>
      cases h2 with
      | send c2 a2 =>
        obtain ⟨Tc, -, ec1, ec2, rc⟩ := ihc c1 c2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_chan ec1
        simp only [Ty.tsubst, Ty.chan.injEq] at ec2
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs.2 hE.2 hΓ hΛ
        rw [H.inj2 (ea1.trans ex.symm) (ea2.trans ec2.2.symm)] at ra
        exact ⟨.unit, rfl, rfl, rfl, .send rc ra⟩
      | sendE c2 _ _ =>
        obtain ⟨Tc, -, ec1, ec2, -⟩ := ihc c1 c2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_chan ec1
        simp [Ty.tsubst] at ec2
    | sendE c1 a1 p1 =>
      cases h2 with
      | sendE c2 a2 p2 =>
        obtain ⟨Tc, wc, ec1, ec2, rc⟩ := ihc c1 c2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_own ec1
        simp only [Ty.tsubst, Ty.own.injEq] at ec2
        obtain ⟨-, -, rfl⟩ := ec2
        obtain ⟨Ta, wa, rfl, rfl, ra⟩ := ihe a1 a2 hs.2 hE.2 hΓ hΛ
        simp only [Ty.tvWf] at wc
        exact ⟨.unit, rfl, rfl, rfl, .sendE rc ra (H.payOk wa wc p1 p2)⟩
      | send c2 _ =>
        obtain ⟨Tc, -, ec1, ec2, -⟩ := ihc c1 c2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_own ec1
        simp [Ty.tsubst] at ec2
  | recv c ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | recv c1 =>
      cases h2 with
      | recv c2 =>
        obtain ⟨Tc, wc, ec1, ec2, rc⟩ := ihc c1 c2 hs hE hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_chan ec1
        simp only [Ty.tsubst, Ty.chan.injEq] at ec2
        obtain ⟨-, rfl⟩ := ec2
        exact ⟨X, by simpa [Ty.tvWf] using wc, rfl, rfl, .recv rc⟩
      | recvE c2 _ _ =>
        obtain ⟨Tc, -, ec1, ec2, -⟩ := ihc c1 c2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_chan ec1
        simp [Ty.tsubst] at ec2
    | recvE c1 mf1 cf1 =>
      cases h2 with
      | recvE c2 mf2 cf2 =>
        obtain ⟨Tc, wc, ec1, ec2, rc⟩ := ihc c1 c2 hs hE hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_own ec1
        simp only [Ty.tsubst, Ty.own.injEq] at ec2
        obtain ⟨-, -, rfl⟩ := ec2
        simp only [Ty.tvWf] at wc
        have hmm := H.mutFree mf1 mf2
        have hcm := H.chanFree cf1 cf2
        have wX := H.wm wc
        refine ⟨.opt ((X.tsubst (Kind.idArgs m)).relocR (d - 1)), by simpa [Ty.tvWf, Ty.tvWf_relocR] using wX, ?_, ?_, ?_⟩
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K1 wX), H.comp1]
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K2 wX), H.comp2]
        · simp only [Ty.tsubst]; rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.Km wX), H.compm]
          exact .recvE rc hmm hcm
      | recv c2 =>
        obtain ⟨Tc, -, ec1, ec2, -⟩ := ihc c1 c2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_own ec1
        simp [Ty.tsubst] at ec2
  | close c ihc =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | closeE c1 =>
      cases h2 with
      | closeE c2 =>
        obtain ⟨Tc, -, ec1, ec2, rc⟩ := ihc c1 c2 hs hE hΓ hΛ
        obtain ⟨X, rfl, -⟩ := Ty.idArgs_inv_own ec1
        exact ⟨.unit, rfl, rfl, rfl, .closeE rc⟩
  | dnew r i t₀ ihi =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | dnewE br1 rd1 i1 p1 =>
      cases h2 with
      | dnewE _ _ i2 p2 =>
        obtain ⟨Ti, wi, rfl, rfl, ri⟩ := ihi i1 i2 hs hE.2 hΓ hΛ
        exact ⟨.dom r t₀, by simpa [Ty.tvWf] using hE.1, rfl, rfl, .dnewE br1 rd1 ri (H.payOk wi hE.1 p1 p2)⟩
  | denter t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | denterE a1 bd1 mf1 cf1 =>
      cases h2 with
      | denterE a2 _ mf2 cf2 =>
        obtain ⟨Ta, -, ea1, ea2, ra⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        obtain ⟨X, rfl, ex⟩ := Ty.idArgs_inv_dom ea1
        simp only [Ty.tsubst, Ty.dom.injEq] at ea2
        simp only [Ty.tsubst] at ra
        rw [H.inj2 ex ea2.2] at ra
        have hmm := H.mutFree mf1 mf2
        have hcm := H.chanFree cf1 cf2
        have wX := H.wm hE.1
        refine ⟨(t₀.tsubst (Kind.idArgs m)).relocR (d - 1), by rw [Ty.tvWf_relocR]; exact wX, ?_, ?_, ?_⟩
        · rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K1 wX), H.comp1]
        · rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.K2 wX), H.comp2]
        · rw [← Ty.tsubst_relocR_mc _ hmm hcm (H.Km wX), H.compm]
          exact .denterE ra bd1 hmm hcm
  | dexit e v ihe ihv =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | dexitE a1 v1 p1 =>
      cases h2 with
      | dexitE a2 v2 p2 =>
        obtain ⟨Ta, wa, ea1, ea2, ra⟩ := ihe a1 a2 hs.1 hE.1 hΓ hΛ
        obtain ⟨X, rfl, rfl⟩ := Ty.idArgs_inv_dom ea1
        simp only [Ty.tsubst, Ty.dom.injEq] at ea2
        obtain ⟨-, rfl⟩ := ea2
        obtain ⟨Tv, wv, rfl, rfl, rv⟩ := ihv v1 v2 hs.2 hE.2 hΓ hΛ
        simp only [Ty.tvWf] at wa
        exact ⟨.unit, rfl, rfl, rfl, .dexitE ra rv (H.payOk wv wa p1 p2)⟩
  | fold t₀ e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    simp only [Expr.tsubstTy] at h1 h2 ⊢
    generalize hx1 : t₀.tsubst (Kind.idArgs k1) = x1 at h1
    generalize hx2 : t₀.tsubst (Kind.idArgs k2) = x2 at h2
    cases h1 with
    | foldS ok1 a1 =>
      cases h2 with
      | foldS ok2 a2 =>
        obtain ⟨Y, rfl, rfl⟩ := Ty.idArgs_inv_mus hx1
        simp only [Ty.tsubst, Ty.mus.injEq] at hx2
        obtain ⟨rfl, rfl, rfl⟩ := hx2
        rename_i n i
        have wY : Y.tvWf m = true := by simpa [Ty.tvWf] using hE.1
        have wYm := H.wm wY
        have hokm : (Ty.mus n i (Y.tsubst (Kind.idArgs m))).musOk = true := by
          simp only [Ty.musOk, Bool.and_eq_true] at ok1 ok2 ⊢
          refine ⟨H.recOk (A := Ty.mus n i Y) (by simpa [Ty.tvWf] using wY) ok1.1 ok2.1, ?_⟩
          simpa [Ty.tsubst, Ty.rfree, Ty.rfree_idArgs] using ok1.2
        have c1 : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k1) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs k1))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.K1 wYm)]; simp only [Ty.tsubst]; rw [H.comp1]
        have c2 : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k2) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs k2))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.K2 wYm)]; simp only [Ty.tsubst]; rw [H.comp2]
        have cm : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs m) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.Km wYm)]; simp only [Ty.tsubst]; rw [H.compm]
        rw [← c1] at a1; rw [← c2] at a2
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        rw [H.inj2 e1 e2, cm] at r
        exact ⟨Ty.mus n i Y, hE.1, rfl, rfl, .foldS hokm r⟩
      | foldRs _ a2 =>
        obtain ⟨Y, rfl, -⟩ := Ty.idArgs_inv_mus hx1
        simp [Ty.tsubst] at hx2
    | foldRs ok1 a1 =>
      cases h2 with
      | foldRs ok2 a2 =>
        obtain ⟨Y, rfl, rfl⟩ := Ty.idArgs_inv_muRs hx1
        simp only [Ty.tsubst, Ty.muRs.injEq] at hx2
        obtain ⟨rfl, rfl, rfl, rfl⟩ := hx2
        rename_i ρr n i
        have wY : Y.tvWf m = true := by simpa [Ty.tvWf] using hE.1
        have wYm := H.wm wY
        have hokm : (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).muRsOk = true := by
          simp only [Ty.muRsOk, Bool.and_eq_true] at ok1 ok2 ⊢
          refine ⟨H.recOk (A := Ty.muRs ρr n i Y) (by simpa [Ty.tvWf] using wY) ok1.1 ok2.1, ?_⟩
          simpa [Ty.tsubst, Ty.rfree, Ty.rfree_idArgs] using ok1.2
        have c1 : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k1) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs k1))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.K1 wYm)]; simp only [Ty.tsubst]; rw [H.comp1]
        have c2 : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k2) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs k2))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.K2 wYm)]; simp only [Ty.tsubst]; rw [H.comp2]
        have cm : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs m) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.Km wYm)]; simp only [Ty.tsubst]; rw [H.compm]
        rw [← c1] at a1; rw [← c2] at a2
        obtain ⟨T, -, e1, e2, r⟩ := ihe a1 a2 hs hE.2 hΓ hΛ
        rw [H.inj2 e1 e2, cm] at r
        exact ⟨Ty.muRs ρr n i Y, hE.1, rfl, rfl, .foldRs hokm r⟩
      | foldS _ a2 =>
        obtain ⟨Y, rfl, -⟩ := Ty.idArgs_inv_muRs hx1
        simp [Ty.tsubst] at hx2
  | unfold e ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases h1 with
    | unfoldS ok1 a1 =>
      cases h2 with
      | unfoldS ok2 a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨Y, rfl, rfl⟩ := Ty.idArgs_inv_mus e1
        simp only [Ty.tsubst, Ty.mus.injEq] at e2
        obtain ⟨rfl, rfl, rfl⟩ := e2
        rename_i n i
        have wY : Y.tvWf m = true := by simpa [Ty.tvWf] using w
        have wYm := H.wm wY
        have hokm : (Ty.mus n i (Y.tsubst (Kind.idArgs m))).musOk = true := by
          simp only [Ty.musOk, Bool.and_eq_true] at ok1 ok2 ⊢
          refine ⟨H.recOk (A := Ty.mus n i Y) (by simpa [Ty.tvWf] using wY) ok1.1 ok2.1, ?_⟩
          simpa [Ty.tsubst, Ty.rfree, Ty.rfree_idArgs] using ok1.2
        have c1 : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k1) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs k1))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.K1 wYm)]; simp only [Ty.tsubst]; rw [H.comp1]
        have c2 : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k2) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs k2))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.K2 wYm)]; simp only [Ty.tsubst]; rw [H.comp2]
        have cm : ((Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs m) =
            (Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold := by
          rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hokm) (H.Km wYm)]; simp only [Ty.tsubst]; rw [H.compm]
        refine ⟨(Ty.mus n i (Y.tsubst (Kind.idArgs m))).unfold, Ty.tvWf_unfold (by simpa [Ty.tvWf] using wYm), c1, c2, ?_⟩
        rw [cm]; exact .unfoldS hokm r
      | unfoldRs _ a2 =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨Y, rfl, -⟩ := Ty.idArgs_inv_mus e1
        simp [Ty.tsubst] at e2
    | unfoldRs ok1 a1 =>
      cases h2 with
      | unfoldRs ok2 a2 =>
        obtain ⟨T, w, e1, e2, r⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨Y, rfl, rfl⟩ := Ty.idArgs_inv_muRs e1
        simp only [Ty.tsubst, Ty.muRs.injEq] at e2
        obtain ⟨rfl, rfl, rfl, rfl⟩ := e2
        rename_i ρr n i
        have wY : Y.tvWf m = true := by simpa [Ty.tvWf] using w
        have wYm := H.wm wY
        have hokm : (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).muRsOk = true := by
          simp only [Ty.muRsOk, Bool.and_eq_true] at ok1 ok2 ⊢
          refine ⟨H.recOk (A := Ty.muRs ρr n i Y) (by simpa [Ty.tvWf] using wY) ok1.1 ok2.1, ?_⟩
          simpa [Ty.tsubst, Ty.rfree, Ty.rfree_idArgs] using ok1.2
        have c1 : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k1) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs k1))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.K1 wYm)]; simp only [Ty.tsubst]; rw [H.comp1]
        have c2 : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs k2) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs k2))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.K2 wYm)]; simp only [Ty.tsubst]; rw [H.comp2]
        have cm : ((Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold).tsubst (Kind.idArgs m) =
            (Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold := by
          rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hokm).1 (H.Km wYm)]; simp only [Ty.tsubst]; rw [H.compm]
        refine ⟨(Ty.muRs ρr n i (Y.tsubst (Kind.idArgs m))).unfold, Ty.tvWf_unfold (by simpa [Ty.tvWf] using wYm), c1, c2, ?_⟩
        rw [cm]; exact .unfoldRs hokm r
      | unfoldS _ a2 =>
        obtain ⟨T, -, e1, e2, -⟩ := ihe a1 a2 hs hE hΓ hΛ
        obtain ⟨Y, rfl, -⟩ := Ty.idArgs_inv_muRs e1
        simp [Ty.tsubst] at e2
  | spawn sc a e ihsc iha ihe =>
    intro f b d Γ Λ t1 t2 h1 h2 hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases h1 with
    | spawn s1 a1 g1 b1 mf1 cf1 p1 =>
      rename_i ρs _ _ _ _
      cases h2 with
      | spawn s2 a2 g2 b2 mf2 cf2 p2 =>
        obtain ⟨Ts, ws, es1, es2, rs⟩ := ihsc s1 s2 hs.1.1 hE.1.1 hΓ hΛ
        obtain ⟨E, rfl, rfl⟩ := Ty.idArgs_inv_own es1
        simp only [Ty.tsubst, Ty.own.injEq] at es2
        obtain ⟨-, rfl, rfl⟩ := es2
        obtain ⟨Ta, wa, rfl, rfl, ra⟩ := iha a1 a2 hs.1.2 hE.1.2 hΓ hΛ
        rw [← Ty.rehome_tsubst Ta (H.K1 wa)] at b1
        rw [← Ty.rehome_tsubst Ta (H.K2 wa)] at b2
        obtain ⟨Tb, wb, eb1, eb2, rb⟩ := ihe (Γ := [Ta.rehome d]) (Λ := []) b1 b2 hs.2 hE.2
          (by simp [Ty.tvWf_rehome, wa]) (by simp)
        obtain ⟨Tt, O, rfl, rfl, eo⟩ := Ty.idArgs_inv_prod eb1
        obtain ⟨E0, rfl, rfl⟩ := Ty.idArgs_inv_opt eo
        simp only [Ty.tsubst, Ty.prod.injEq, Ty.opt.injEq] at eb2
        obtain ⟨rfl, rfl⟩ := eb2
        simp only [Ty.tvWf, Bool.and_eq_true] at ws wb
        have hmm := H.mutFree (A := .prod Tt (.opt E0)) mf1 mf2
        have hcm := H.chanFree (A := .prod Tt (.opt E0)) cf1 cf2
        have wP : (Ty.prod Tt (.opt E0)).tvWf m = true := by simp [Ty.tvWf, wb.1, wb.2]
        have wPm := H.wm wP
        have q : ∀ k : List Kind, (∀ {B : Ty}, B.tvWf m = true → B.kindsOk (Kind.idArgs k) = true) →
            (∀ t : Ty, (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs k) = t.tsubst (Kind.idArgs k)) →
            ((((Ty.prod Tt (.opt E0)).tsubst (Kind.idArgs m)).relocR ρs).tsubst (Kind.idArgs k)) =
              ((Ty.prod Tt (.opt E0)).tsubst (Kind.idArgs k)).relocR ρs := by
          intro k Kk ck
          rw [← Ty.tsubst_relocR_mc _ hmm hcm (Kk wPm), ck]
        rw [List.map_cons, List.map_nil, Ty.rehome_tsubst Ta (H.Km wa)] at rb
        refine ⟨.own .task ρs (((Ty.prod Tt (.opt E0)).tsubst (Kind.idArgs m)).relocR ρs),
          by simp [Ty.tvWf, Ty.tvWf_relocR, wPm], ?_, ?_, ?_⟩
        · exact congrArg (Ty.own .task ρs) (q k1 H.K1 H.comp1)
        · exact congrArg (Ty.own .task ρs) (q k2 H.K2 H.comp2)
        · rw [show (Ty.own .task ρs (((Ty.prod Tt (.opt E0)).tsubst (Kind.idArgs m)).relocR ρs)).tsubst (Kind.idArgs m) =
              Ty.own .task ρs (((Ty.prod Tt (.opt E0)).tsubst (Kind.idArgs m)).relocR ρs) from
              congrArg (Ty.own .task ρs) ((q m H.Km H.compm).trans rfl)]
          exact .spawn rs ra (H.givable g1 g2) rb hmm hcm (H.payOk wb.2 ws p1 p2)

end HasType

end FS
