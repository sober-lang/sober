import FeatherweightSober.KindAnti

/-!
# kind の meet

Def の本体が kind の列 k1 でも k2 でも型付くなら、添字ごとの弱い方 m = meetL k1 k2 でも型付く（行を固定。`DefOk.meet`）。

型代入の系にはならない（m への置き直しは旗を下げる向き）。代わりに、m の世界の項を「形」とし、k1 と k2 の世界の像の
導出を同時に反転して、形の導出を組み立てる。m ≤ k なので、形を k へ置き直すと k の世界の像になる（`Ty.idArgs_comp`）。
2つの像が等しければ形も等しい（`Ty.idArgs_inj2` — rf で潰れる置き直し先は、m で rf でない添字では片方の像が保つ）。
述語は、2つの像で成り立てば形の像でも成り立つ（「反映」）。型変数の腕は旗の有限の場合分けで、正規形の含意を使う。
-/

namespace FS

/-- 2 つの kind の列と、添字ごとの弱い方 -/
structure MeetK (k1 k2 m : List Kind) : Prop where
  l1 : k1.length = m.length
  l2 : k2.length = m.length
  get : ∀ (j : Nat) (h : j < m.length), m[j] = (k1[j]'(by omega)).meet (k2[j]'(by omega))
  n1 : KNorm k1
  n2 : KNorm k2

theorem MeetK.of_meetL {k1 k2 : List Kind} (hl : k1.length = k2.length) (h1 : KNorm k1) (h2 : KNorm k2) :
    MeetK k1 k2 (meetL k1 k2) where
  l1 := by simp [meetL, hl]
  l2 := by simp [meetL, hl]
  get := by intro j h; simp [meetL]
  n1 := h1
  n2 := h2

/-- 添字 j について、3 つの列がそろって範囲外か、そろって範囲内（m の kind は弱い方） -/
theorem MeetK.cases {k1 k2 m : List Kind} (H : MeetK k1 k2 m) (j : Nat) :
    (k1[j]? = none ∧ k2[j]? = none ∧ m[j]? = none) ∨
      ∃ a b, k1[j]? = some a ∧ k2[j]? = some b ∧ m[j]? = some (a.meet b) ∧ a.isNorm = true ∧ b.isNorm = true := by
  by_cases hj : j < m.length
  · right
    refine ⟨k1[j]'(by have := H.l1; omega), k2[j]'(by have := H.l2; omega), by simp, by simp, ?_,
      H.n1 _ (List.getElem_mem _), H.n2 _ (List.getElem_mem _)⟩
    rw [List.getElem?_eq_getElem hj, H.get j hj]
  · left
    have := H.l1; have := H.l2
    exact ⟨by simp; omega, by simp; omega, by simp; omega⟩

/-- 置き直しの型変数の腕の閉じた形 -/
theorem Ty.tsubst_idArgs_tvar (k : List Kind) (i ρ : Nat) (kd : Kind) :
    (Ty.tvar i ρ kd).tsubst (Kind.idArgs k) =
      match k[i]? with
      | some a => .tvar i (a.place ρ) a
      | none => .tvar i ρ kd := by
  cases h : k[i]? <;> simp [Ty.tsubst, Kind.idArgs_get, h, Ty.atR, Kind.place]

/-- 置き直しの型変数の腕は型変数（形の反転に使う） -/
theorem Ty.tsubst_idArgs_tvar' (k : List Kind) (i ρ : Nat) (kd : Kind) :
    (Ty.tvar i ρ kd).tsubst (Kind.idArgs k) =
      .tvar i ((k[i]?.map (·.place ρ)).getD ρ) (k[i]?.getD kd) := by
  rw [Ty.tsubst_idArgs_tvar]; cases k[i]? <;> rfl

theorem Kind.meet_le_left (a b : Kind) : (a.meet b).le a = true := by
  obtain ⟨r1, m1, c1, v1, f1⟩ := a; obtain ⟨r2, m2, c2, v2, f2⟩ := b
  revert r1 m1 c1 v1 f1 r2 m2 c2 v2 f2; decide

theorem Kind.meet_le_right (a b : Kind) : (a.meet b).le b = true := by
  obtain ⟨r1, m1, c1, v1, f1⟩ := a; obtain ⟨r2, m2, c2, v2, f2⟩ := b
  revert r1 m1 c1 v1 f1 r2 m2 c2 v2 f2; decide

theorem Kind.meet_rf (a b : Kind) : (a.meet b).rf = (a.rf && b.rf) := rfl

/-- 弱い方への置き直しの後に強い方へ置き直すと、強い方への置き直しと同じ -/
theorem Ty.idArgs_comp {m k : List Kind} (hl : m.length = k.length)
    (hrf : ∀ (j : Nat) (a c : Kind), m[j]? = some a → k[j]? = some c → a.rf = true → c.rf = true) :
    ∀ t : Ty, (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs k) = t.tsubst (Kind.idArgs k) := by
  intro t; induction t with
  | tvar i ρ kd =>
    rw [Ty.tsubst_idArgs_tvar m]
    cases hm : m[i]? with
    | none =>
      have : k[i]? = none := by rw [List.getElem?_eq_none_iff, ← hl]; exact List.getElem?_eq_none_iff.mp hm
      simp [Ty.tsubst_idArgs_tvar, this]
    | some a =>
      obtain ⟨c, hc⟩ : ∃ c, k[i]? = some c := by
        have := (List.getElem?_eq_some_iff.mp hm).1; rw [hl] at this; exact ⟨_, List.getElem?_eq_getElem this⟩
      simp only [Ty.tsubst_idArgs_tvar, hc, Kind.place]
      have := hrf i a c hm hc
      cases ha : a.rf <;> cases hc' : c.rf <;> simp_all
  | _ => simp_all [Ty.tsubst]

theorem MeetK.rf1 {k1 k2 m : List Kind} (H : MeetK k1 k2 m) :
    ∀ (j : Nat) (a c : Kind), m[j]? = some a → k1[j]? = some c → a.rf = true → c.rf = true := by
  intro j a c hm hc hr
  rcases H.cases j with ⟨_, _, h⟩ | ⟨a', b', h1, h2, h3, -, -⟩
  · simp_all
  · rw [hm] at h3; rw [hc] at h1; cases h3; cases h1; simp_all [Kind.meet_rf]

theorem MeetK.rf2 {k1 k2 m : List Kind} (H : MeetK k1 k2 m) :
    ∀ (j : Nat) (a c : Kind), m[j]? = some a → k2[j]? = some c → a.rf = true → c.rf = true := by
  intro j a c hm hc hr
  rcases H.cases j with ⟨_, _, h⟩ | ⟨a', b', h1, h2, h3, -, -⟩
  · simp_all
  · rw [hm] at h3; rw [hc] at h2; cases h3; cases h2; simp_all [Kind.meet_rf]

theorem MeetK.comp1 {k1 k2 m : List Kind} (H : MeetK k1 k2 m) (t : Ty) :
    (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs k1) = t.tsubst (Kind.idArgs k1) :=
  Ty.idArgs_comp H.l1.symm H.rf1 t

theorem MeetK.comp2 {k1 k2 m : List Kind} (H : MeetK k1 k2 m) (t : Ty) :
    (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs k2) = t.tsubst (Kind.idArgs k2) :=
  Ty.idArgs_comp H.l2.symm H.rf2 t

theorem MeetK.compm {k1 k2 m : List Kind} (_ : MeetK k1 k2 m) (t : Ty) :
    (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs m) = t.tsubst (Kind.idArgs m) :=
  Ty.idArgs_comp rfl (fun j a c h1 h2 hr => by rw [h1] at h2; cases h2; exact hr) t

/-- 2 つの像が等しければ、弱い方の像も等しい -/
theorem MeetK.inj2 {k1 k2 m : List Kind} (H : MeetK k1 k2 m) :
    ∀ {A B : Ty}, A.tsubst (Kind.idArgs k1) = B.tsubst (Kind.idArgs k1) →
      A.tsubst (Kind.idArgs k2) = B.tsubst (Kind.idArgs k2) → A.tsubst (Kind.idArgs m) = B.tsubst (Kind.idArgs m) := by
  intro A
  induction A with
  | tvar i ρ kd =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> (try simp only [Ty.tsubst, reduceCtorEq] at h1 h2 ⊢)
    case tvar i' ρ' kd' =>
      simp only [Ty.tvar.injEq] at h1 h2 ⊢
      obtain ⟨rfl, h1ρ, h1k⟩ := h1
      obtain ⟨-, h2ρ, h2k⟩ := h2
      refine ⟨rfl, ?_, ?_⟩
      · rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, b, e1, e2, e3, -, -⟩
        · simp_all
        · simp only [e1, e2, e3, Option.map_some, Option.getD_some, Kind.place, Kind.meet_rf] at h1ρ h2ρ ⊢
          by_cases ha : a.rf <;> by_cases hb : b.rf <;> simp_all
      · rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, b, e1, e2, e3, -, -⟩
        · simp_all
        · simp [e3]
  | int =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
  | bool =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
  | byte =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
  | f64 =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
  | unit =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
  | opt t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ih h1 h2
  | union l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | prod l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | ref m r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
  | slice m r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
  | map m r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
  | chan rc t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, ih h1.2 h2.2⟩
  | dom r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, ih h1.2 h2.2⟩
  | fn p r ihp ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨ihp h1.1 h2.1, ihr h1.2 h2.2⟩
  | mus n i b ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
  | rvar i =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact h1
  | own k r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
  | muRs r n i b ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst] at h1 h2 ⊢
    exact ⟨h1.1, h1.2.1, h1.2.2.1, ih h1.2.2.2 h2.2.2.2⟩

/-! ## 像の型の反転（型変数の像は型変数なので、像の頭の構成子は形の頭の構成子） -/

theorem Ty.idArgs_inv_int {k : List Kind} {T : Ty} (h : T.tsubst (Kind.idArgs k) = .int) : T = .int := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h ⊢

theorem Ty.idArgs_inv_bool {k : List Kind} {T : Ty} (h : T.tsubst (Kind.idArgs k) = .bool) : T = .bool := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h ⊢

theorem Ty.idArgs_inv_byte {k : List Kind} {T : Ty} (h : T.tsubst (Kind.idArgs k) = .byte) : T = .byte := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h ⊢

theorem Ty.idArgs_inv_f64 {k : List Kind} {T : Ty} (h : T.tsubst (Kind.idArgs k) = .f64) : T = .f64 := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h ⊢

theorem Ty.idArgs_inv_unit {k : List Kind} {T : Ty} (h : T.tsubst (Kind.idArgs k) = .unit) : T = .unit := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h ⊢

theorem Ty.idArgs_inv_opt {k : List Kind} {T : Ty}  {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .opt t) : ∃ Xt, T = .opt Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_union {k : List Kind} {T : Ty}  {l r : Ty}
    (h : T.tsubst (Kind.idArgs k) = .union l r) : ∃ Xl Xr, T = .union Xl Xr ∧ Xl.tsubst (Kind.idArgs k) = l ∧ Xr.tsubst (Kind.idArgs k) = r := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1⟩ := h
  subst_vars
  exact ⟨_, _, rfl, rfl, rfl⟩

theorem Ty.idArgs_inv_prod {k : List Kind} {T : Ty}  {l r : Ty}
    (h : T.tsubst (Kind.idArgs k) = .prod l r) : ∃ Xl Xr, T = .prod Xl Xr ∧ Xl.tsubst (Kind.idArgs k) = l ∧ Xr.tsubst (Kind.idArgs k) = r := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1⟩ := h
  subst_vars
  exact ⟨_, _, rfl, rfl, rfl⟩

theorem Ty.idArgs_inv_ref {k : List Kind} {T : Ty} {m : Bool} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .ref m r t) : ∃ Xt, T = .ref m r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_slice {k : List Kind} {T : Ty} {m : Bool} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .slice m r t) : ∃ Xt, T = .slice m r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_map {k : List Kind} {T : Ty} {m : Bool} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .map m r t) : ∃ Xt, T = .map m r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_chan {k : List Kind} {T : Ty} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .chan r t) : ∃ Xt, T = .chan r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_dom {k : List Kind} {T : Ty} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .dom r t) : ∃ Xt, T = .dom r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_fn {k : List Kind} {T : Ty}  {p r : Ty}
    (h : T.tsubst (Kind.idArgs k) = .fn p r) : ∃ Xp Xr, T = .fn Xp Xr ∧ Xp.tsubst (Kind.idArgs k) = p ∧ Xr.tsubst (Kind.idArgs k) = r := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1⟩ := h
  subst_vars
  exact ⟨_, _, rfl, rfl, rfl⟩

theorem Ty.idArgs_inv_own {k : List Kind} {T : Ty} {o : OwnK} {r : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .own o r t) : ∃ Xt, T = .own o r Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_mus {k : List Kind} {T : Ty} {n i : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .mus n i t) : ∃ Xt, T = .mus n i Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

theorem Ty.idArgs_inv_muRs {k : List Kind} {T : Ty} {r n i : Nat} {t : Ty}
    (h : T.tsubst (Kind.idArgs k) = .muRs r n i t) : ∃ Xt, T = .muRs r n i Xt ∧ Xt.tsubst (Kind.idArgs k) = t := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  obtain ⟨h0, h1, h2, h3⟩ := h
  subst_vars
  exact ⟨_, rfl, rfl⟩

/-! ## 述語の反映 -/

/-- 型変数の腕の場合分け: 範囲外なら 3 つの像は同じ、範囲内なら旗の組 -/
theorem MeetK.tvar_cases {k1 k2 m : List Kind} (H : MeetK k1 k2 m) (i ρ : Nat) (kd : Kind) :
    ((Ty.tvar i ρ kd).tsubst (Kind.idArgs k1) = .tvar i ρ kd ∧ (Ty.tvar i ρ kd).tsubst (Kind.idArgs k2) = .tvar i ρ kd ∧
      (Ty.tvar i ρ kd).tsubst (Kind.idArgs m) = .tvar i ρ kd) ∨
    ∃ a b, a.isNorm = true ∧ b.isNorm = true ∧ (Ty.tvar i ρ kd).tsubst (Kind.idArgs k1) = .tvar i (a.place ρ) a ∧
      (Ty.tvar i ρ kd).tsubst (Kind.idArgs k2) = .tvar i (b.place ρ) b ∧
      (Ty.tvar i ρ kd).tsubst (Kind.idArgs m) = .tvar i ((a.meet b).place ρ) (a.meet b) := by
  rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, b, e1, e2, e3, n1, n2⟩
  · left; simp [Ty.tsubst_idArgs_tvar, e1, e2, e3]
  · right; exact ⟨a, b, n1, n2, by simp [Ty.tsubst_idArgs_tvar, e1], by simp [Ty.tsubst_idArgs_tvar, e2],
      by simp [Ty.tsubst_idArgs_tvar, e3]⟩

/-- 旗の有限の場合分け（正規形の 2 つの kind）: 旗を変数として取り出して、全部の組を決定手続きで調べる -/
macro "kind_bash" a:ident b:ident h1:ident h2:ident n1:ident n2:ident : tactic =>
  `(tactic| (
    obtain ⟨r1, m1, c1, v1, f1⟩ := $a:ident
    obtain ⟨r2, m2, c2, v2, f2⟩ := $b:ident
    simp only [Kind.meet, Kind.place, Kind.isNorm] at $h1:ident $h2:ident $n1:ident $n2:ident ⊢
    revert $h1:ident $h2:ident $n1:ident $n2:ident
    revert r1 m1 c1 v1 f1 r2 m2 c2 v2 f2
    decide))

/-- 旗の場合分け（置き直し先の Nat を含む目標）: rf・mf・cf・cov の組を全部調べる -/
macro "kind_split" a:ident b:ident : tactic =>
  `(tactic| (
    obtain ⟨r1, m1, c1, v1, f1⟩ := $a:ident
    obtain ⟨r2, m2, c2, v2, f2⟩ := $b:ident
    cases r1 <;> cases r2 <;> cases v1 <;> cases v2 <;> cases m1 <;> cases m2 <;> cases c1 <;> cases c2 <;>
      simp_all [Kind.meet, Kind.place, Kind.isNorm] <;> omega))

section
variable {k1 k2 m : List Kind}

theorem MeetK.mutFree (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).mutFree = true →
    (A.tsubst (Kind.idArgs k2)).mutFree = true → (A.tsubst (Kind.idArgs m)).mutFree = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.mutFree] at h1 h2 ⊢
      clear e1 e2 e3; kind_bash a b h1 h2 n1 n2
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.mutFree]

theorem Ty.rfree_idArgs (k : List Kind) : ∀ (A : Ty) (n : Nat), (A.tsubst (Kind.idArgs k)).rfree n = A.rfree n := by
  intro A; induction A with
  | tvar i ρ kd => intro n; simp [Ty.tsubst_idArgs_tvar', Ty.rfree]
  | _ => intro n; simp_all [Ty.tsubst, Ty.rfree]

theorem MeetK.chanFree (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).chanFree = true →
    (A.tsubst (Kind.idArgs k2)).chanFree = true → (A.tsubst (Kind.idArgs m)).chanFree = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.chanFree] at h1 h2 ⊢
      clear e1 e2 e3; kind_bash a b h1 h2 n1 n2
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.chanFree]

theorem MeetK.regionsBelow (H : MeetK k1 k2 m) : ∀ {A : Ty} {d : Nat}, (A.tsubst (Kind.idArgs k1)).regionsBelow d = true →
    (A.tsubst (Kind.idArgs k2)).regionsBelow d = true → (A.tsubst (Kind.idArgs m)).regionsBelow d = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro d h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.regionsBelow] at h1 h2 ⊢
      clear e1 e2 e3; simp only [Bool.or_eq_true, decide_eq_true_eq] at h1 h2 ⊢; kind_split a b
  | _ => intro d h1 h2; simp_all [Ty.tsubst, Ty.regionsBelow]

theorem MeetK.covOk (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).covOk = true →
    (A.tsubst (Kind.idArgs k2)).covOk = true → (A.tsubst (Kind.idArgs m)).covOk = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.covOk] at h1 h2 ⊢
      clear e1 e2 e3; kind_bash a b h1 h2 n1 n2
  | ref mu r t ih =>
    intro h1 h2; cases mu <;> simp only [Ty.tsubst, Ty.covOk, Ty.rfree_idArgs, Bool.and_eq_true] at h1 h2 ⊢
    · exact ⟨⟨H.regionsBelow h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, h1.2⟩
    · exact h1
  | slice mu r t ih => intro h1 h2; cases mu <;> simp_all [Ty.tsubst, Ty.covOk]
  | map mu r t ih => intro h1 h2; cases mu <;> simp_all [Ty.tsubst, Ty.covOk]
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.covOk]

theorem Ty.isFn_idArgs (k : List Kind) (A : Ty) : (A.tsubst (Kind.idArgs k)).isFn = A.isFn := by
  cases A <;> (try simp only [Ty.tsubst_idArgs_tvar']) <;> simp [Ty.tsubst, Ty.isFn]

theorem Ty.isChain_idArgs (k : List Kind) : ∀ (A : Ty) (n : Nat), (A.tsubst (Kind.idArgs k)).isChain n = A.isChain n := by
  intro A; induction A <;> intro n <;> cases n <;> (try simp only [Ty.tsubst_idArgs_tvar']) <;> simp_all [Ty.tsubst, Ty.isChain]

theorem Ty.chainFn_idArgs (k : List Kind) : ∀ (A : Ty) (n : Nat), (A.tsubst (Kind.idArgs k)).chainFn n = A.chainFn n := by
  intro A; induction A <;> intro n <;> cases n <;> (try simp only [Ty.tsubst_idArgs_tvar']) <;>
    simp_all [Ty.tsubst, Ty.chainFn, Ty.isFn_idArgs]

theorem MeetK.argFree (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).argFree = true →
    (A.tsubst (Kind.idArgs k2)).argFree = true → (A.tsubst (Kind.idArgs m)).argFree = true := by
  intro A; induction A with
  | tvar i ρ kd => intro _ _; simp [Ty.tsubst_idArgs_tvar', Ty.argFree]
  | dom r t ih => intro h1 h2; simp only [Ty.tsubst, Ty.argFree] at h1 h2 ⊢; exact H.chanFree h1 h2
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.argFree]

theorem MeetK.localOnly (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).localOnly = true →
    (A.tsubst (Kind.idArgs k2)).localOnly = true → (A.tsubst (Kind.idArgs m)).localOnly = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.localOnly] at h1 h2 ⊢
      clear e1 e2 e3; simp only [Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢; kind_split a b
  | chan rc t ih =>
    intro h1 h2; simp only [Ty.tsubst, Ty.localOnly, Bool.and_eq_true, Ty.rfree_idArgs] at h1 h2 ⊢
    exact ⟨⟨⟨h1.1.1.1, H.regionsBelow h1.1.1.2 h2.1.1.2⟩, H.chanFree h1.1.2 h2.1.2⟩, h1.2⟩
  | dom rc t ih =>
    intro h1 h2; simp only [Ty.tsubst, Ty.localOnly, Bool.and_eq_true, Ty.rfree_idArgs] at h1 h2 ⊢
    exact ⟨⟨⟨h1.1.1.1, H.regionsBelow h1.1.1.2 h2.1.1.2⟩, H.chanFree h1.1.2 h2.1.2⟩, h1.2⟩
  | own o rc t ih =>
    intro h1 h2; simp only [Ty.tsubst, Ty.localOnly, Bool.and_eq_true, Ty.rfree_idArgs] at h1 h2 ⊢
    exact ⟨⟨⟨h1.1.1.1, H.regionsBelow h1.1.1.2 h2.1.1.2⟩, H.chanFree h1.1.2 h2.1.2⟩, h1.2⟩
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.localOnly]

theorem MeetK.mnorm (H : MeetK k1 k2 m) : KNorm m := by
  intro k hk
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem hk
  rw [H.get j hj]; exact Kind.meet_norm (H.n1 _ (List.getElem_mem _)) (H.n2 _ (List.getElem_mem _))

/-- 形の型（出現の旗が m 以下）は、どの世界への置き直しの kind の条件も満たす -/
theorem MeetK.Km (H : MeetK k1 k2 m) {B : Ty} (hB : B.tvWf m = true) : B.kindsOk (Kind.idArgs m) = true :=
  Ty.kindsOk_of_tvWf (kindsArgsOk_idArgs rfl (fun j k k' h1 h2 => by rw [h1] at h2; cases h2; exact Kind.le_refl _)
    H.mnorm) hB

theorem MeetK.K1 (H : MeetK k1 k2 m) {B : Ty} (hB : B.tvWf m = true) : B.kindsOk (Kind.idArgs k1) = true :=
  Ty.kindsOk_of_tvWf (kindsArgsOk_idArgs H.l1 (fun j k k' h1 h2 => by
    rcases H.cases j with ⟨-, -, e⟩ | ⟨a, b, e1, -, e3, -, -⟩
    · simp_all
    · rw [h1] at e3; rw [h2] at e1; cases e3; cases e1; exact Kind.meet_le_left _ _) H.n1) hB

theorem MeetK.K2 (H : MeetK k1 k2 m) {B : Ty} (hB : B.tvWf m = true) : B.kindsOk (Kind.idArgs k2) = true :=
  Ty.kindsOk_of_tvWf (kindsArgsOk_idArgs H.l2 (fun j k k' h1 h2 => by
    rcases H.cases j with ⟨-, -, e⟩ | ⟨a, b, -, e2, e3, -, -⟩
    · simp_all
    · rw [h1] at e3; rw [h2] at e2; cases e3; cases e2; exact Kind.meet_le_right _ _) H.n2) hB

theorem MeetK.recOk (H : MeetK k1 k2 m) : ∀ {A : Ty}, A.tvWf m = true → (A.tsubst (Kind.idArgs k1)).recOk = true →
    (A.tsubst (Kind.idArgs k2)).recOk = true → (A.tsubst (Kind.idArgs m)).recOk = true := by
  have Km := @MeetK.Km _ _ _ H
  have K1 := @MeetK.K1 _ _ _ H
  intro A; induction A with
  | tvar i ρ kd => intro _ _ _; simp [Ty.tsubst_idArgs_tvar', Ty.recOk]
  | mus n i b ih =>
    intro w h1 h2; simp only [Ty.tvWf] at w
    simp only [Ty.tsubst, Ty.recOk, Bool.and_eq_true, Ty.chainFn_idArgs] at h1 h2 ⊢
    exact ⟨h1.1, ih w h1.2 h2.2⟩
  | muRs r n i b ih =>
    intro w h1 h2; simp only [Ty.tvWf] at w
    simp only [Ty.tsubst, Ty.recOk, Bool.and_eq_true, Ty.isChain_idArgs] at h1 h2 ⊢
    obtain ⟨⟨⟨⟨hc, hi⟩, hl1⟩, hg1⟩, hr1⟩ := h1
    obtain ⟨⟨⟨-, hl2⟩, -⟩, hr2⟩ := h2
    rw [Ty.groupOk_tsubst hc (K1 w)] at hg1
    exact ⟨⟨⟨⟨hc, hi⟩, H.localOnly hl1 hl2⟩, by rw [Ty.groupOk_tsubst hc (Km w)]; exact hg1⟩, ih w hr1 hr2⟩
  | _ =>
    intro w h1 h2; simp only [Ty.tvWf, Bool.and_eq_true] at w; simp_all [Ty.tsubst, Ty.recOk]

theorem MeetK.keyOk (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).keyOk = true →
    (A.tsubst (Kind.idArgs k2)).keyOk = true → (A.tsubst (Kind.idArgs m)).keyOk = true := by
  intro A h1 h2
  cases A with
  | tvar i ρ kd =>
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.keyOk] at h1 h2 ⊢
      clear e1 e2 e3; kind_bash a b h1 h2 n1 n2
  | slice mu r t =>
    cases mu <;> simp only [Ty.tsubst] at h1 h2 ⊢
    · cases t <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp_all [Ty.tsubst, Ty.keyOk]
    · simp [Ty.keyOk] at h1
  | _ => simp_all [Ty.tsubst, Ty.keyOk]

theorem MeetK.retOk (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).retOk = true →
    (A.tsubst (Kind.idArgs k2)).retOk = true → (A.tsubst (Kind.idArgs m)).retOk = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, b, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.retOk] at h1 h2 ⊢
      clear e1 e2 e3; simp only [Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢; kind_split a b
  | ref mu r t ih => intro h1 h2; cases mu <;> simp_all [Ty.tsubst, Ty.retOk]
  | slice mu r t ih => intro h1 h2; cases mu <;> simp_all [Ty.tsubst, Ty.retOk]
  | map mu r t ih => intro h1 h2; cases mu <;> simp_all [Ty.tsubst, Ty.retOk]
  | muRs r n i b ih =>
    intro h1 h2; simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, h1.1.2⟩, ih h1.2 h2.2⟩
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.retOk]

theorem MeetK.kindOk (H : MeetK k1 k2 m) {k : Kind} {A : Ty} (w : A.tvWf m = true)
    (h1 : kindOk k (A.tsubst (Kind.idArgs k1)) = true) (h2 : kindOk k (A.tsubst (Kind.idArgs k2)) = true) :
    kindOk k (A.tsubst (Kind.idArgs m)) = true := by
  obtain ⟨a1, f1, r1, rf1, mf1, cf1, cv1, kf1⟩ := kindOk_parts h1
  obtain ⟨a2, -, r2, rf2, mf2, cf2, cv2, kf2⟩ := kindOk_parts h2
  rw [Ty.rfree_idArgs] at f1
  simp only [FS.kindOk, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true', Ty.rfree_idArgs]
  refine ⟨⟨⟨⟨⟨⟨⟨H.argFree a1 a2, f1⟩, H.recOk w r1 r2⟩, ?_⟩, ?_⟩, ?_⟩, ?_⟩, ?_⟩
  · cases h : k.rf
    · exact .inl rfl
    · exact .inr ⟨H.regionsBelow (rf1 h).1 (rf2 h).1, H.chanFree (rf1 h).2 (rf2 h).2⟩
  · cases h : k.mf
    · exact .inl rfl
    · exact .inr (H.mutFree (mf1 h) (mf2 h))
  · cases h : k.cf
    · exact .inl rfl
    · exact .inr (H.chanFree (cf1 h) (cf2 h))
  · cases h : k.cov
    · exact .inl rfl
    · exact .inr ⟨⟨H.covOk (cv1 h).1 (cv2 h).1, H.mutFree (cv1 h).2.1 (cv2 h).2.1⟩, H.chanFree (cv1 h).2.2 (cv2 h).2.2⟩
  · cases h : k.kf
    · exact .inl rfl
    · exact .inr (H.keyOk (kf1 h) (kf2 h))

theorem MeetK.kindsArgsOk (H : MeetK k1 k2 m) {ks : List Kind} {ts : List Ty} (w : ∀ s ∈ ts, s.tvWf m = true)
    (h1 : kindsArgsOk ks (ts.map (Ty.tsubst (Kind.idArgs k1))) = true)
    (h2 : kindsArgsOk ks (ts.map (Ty.tsubst (Kind.idArgs k2))) = true) :
    kindsArgsOk ks (ts.map (Ty.tsubst (Kind.idArgs m))) = true := by
  unfold FS.kindsArgsOk at h1 h2 ⊢
  rw [List.all_eq_true] at h1 h2 ⊢
  intro p hp
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem hp
  simp only [List.length_zip, List.length_map] at hj
  have q1 := h1 _ (List.getElem_mem (l := ks.zip (ts.map (Ty.tsubst (Kind.idArgs k1)))) (by simp; omega))
  have q2 := h2 _ (List.getElem_mem (l := ks.zip (ts.map (Ty.tsubst (Kind.idArgs k2)))) (by simp; omega))
  simp only [List.getElem_zip, List.getElem_map] at q1 q2 ⊢
  exact H.kindOk (w _ (List.getElem_mem _)) q1 q2

theorem Ty.relocR0_ref (m : Bool) (r : Nat) (t : Ty) :
    (Ty.ref m r t).relocR 0 = if m then .ref true r t else .ref false 0 (t.relocR 0) := by
  cases m <;> simp [Ty.relocR, Ty.shiftR_zero]

theorem Ty.relocR0_slice (m : Bool) (r : Nat) (t : Ty) :
    (Ty.slice m r t).relocR 0 = if m then .slice true r t else .slice false 0 (t.relocR 0) := by
  cases m <;> simp [Ty.relocR, Ty.shiftR_zero]

theorem Ty.relocR0_map (m : Bool) (r : Nat) (t : Ty) :
    (Ty.map m r t).relocR 0 = if m then .map true r t else .map false 0 (t.relocR 0) := by
  cases m <;> simp [Ty.relocR, Ty.shiftR_zero]

theorem Ty.relocR0_muRs (r n i : Nat) (b : Ty) :
    (Ty.muRs r n i b).relocR 0 = .muRs (if b.mutFree then 0 else r) n i b := by
  cases h : b.mutFree <;> simp [Ty.relocR, h]

theorem Ty.relocR0_tvar (i ρ : Nat) (k : Kind) :
    (Ty.tvar i ρ k).relocR 0 = .tvar i (if k.imm && !k.rf then 0 else ρ) k := by
  cases h1 : k.rf <;> cases h2 : k.imm <;> simp [Ty.relocR, h1, h2]

/-- relocR 0 の像が 2 つの kind の列で等しければ、交わり m でも等しい（domain の状態の型を形で比べる Ty.sub の腕） -/
theorem MeetK.relocInj2 (H : MeetK k1 k2 m) : ∀ {A B : Ty},
    (A.tsubst (Kind.idArgs k1)).relocR 0 = (B.tsubst (Kind.idArgs k1)).relocR 0 →
    (A.tsubst (Kind.idArgs k2)).relocR 0 = (B.tsubst (Kind.idArgs k2)).relocR 0 →
    (A.tsubst (Kind.idArgs m)).relocR 0 = (B.tsubst (Kind.idArgs m)).relocR 0 := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro B h1 h2
    simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢
    cases B with
    | tvar i' ρ' kd' =>
      simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar, Ty.tvar.injEq] at h1 h2 ⊢
      obtain ⟨rfl, hρ1, hk1⟩ := h1
      obtain ⟨-, hρ2, hk2⟩ := h2
      rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, b, e1, e2, e3, n1, n2⟩
      · simp_all
      · simp only [e1, e2, e3, Option.map_some, Option.getD_some, Kind.place] at hρ1 hρ2 hk1 hk2 ⊢
        simp only [true_and, and_true]
        obtain ⟨r1, m1, c1, v1, f1⟩ := a; obtain ⟨r2, m2, c2, v2, f2⟩ := b
        simp only [Kind.isNorm] at n1 n2
        cases r1 <;> cases m1 <;> cases c1 <;> cases r2 <;> cases m2 <;> cases c2 <;>
          simp_all [Kind.imm, Kind.meet]
    | ref mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR] at h1
    | slice mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR] at h1
    | map mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR] at h1
    | muRs => simp [Ty.tsubst, Ty.relocR0_muRs] at h1
    | _ => simp [Ty.tsubst, Ty.relocR] at h1
  | int => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1))
  | bool => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1))
  | byte => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1))
  | f64 => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1))
  | unit => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1))
  | opt t ih => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | union l r ihl ihr => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | prod l r ihl ihr => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | ref mu r t ih => intro B h1 h2; cases mu <;> cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | slice mu r t ih => intro B h1 h2; cases mu <;> cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | map mu r t ih => intro B h1 h2; cases mu <;> cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | chan rc t ih => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | dom rc t ih => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | fn p r ihp ihr => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | mus n i b ih => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | rvar i => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)) <;> exact h1
  | own k r t ih => intro B h1 h2; cases B <;> (try (rename_i mb _ _; cases mb)) <;> (try simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.relocR, Ty.shiftR_zero] at h1 h2 ⊢ <;> (try (split at h1 <;> simp at h1)); all_goals first | exact ih h1 h2 | exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩ | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩ | exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | muRs r n i b ih =>
    intro B h1 h2
    cases B with
    | muRs r' n' i' b' =>
      simp only [Ty.tsubst, Ty.relocR0_muRs, Ty.muRs.injEq] at h1 h2 ⊢
      obtain ⟨hr1, rfl, rfl, hb1⟩ := h1
      obtain ⟨hr2, -, -, hb2⟩ := h2
      have hbm := H.inj2 hb1 hb2
      refine ⟨?_, rfl, rfl, hbm⟩
      rw [hbm]
      by_cases hr : r = r'
      · subst hr; rfl
      · have M1 : (b.tsubst (Kind.idArgs k1)).mutFree = true := by
          rw [hb1] at hr1; cases h : (b'.tsubst (Kind.idArgs k1)).mutFree <;> simp_all
        have M2 : (b.tsubst (Kind.idArgs k2)).mutFree = true := by
          rw [hb2] at hr2; cases h : (b'.tsubst (Kind.idArgs k2)).mutFree <;> simp_all
        have Mm := H.mutFree M1 M2
        rw [hbm] at Mm; simp [Mm]
    | ref mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR0_muRs, Ty.relocR] at h1
    | slice mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR0_muRs, Ty.relocR] at h1
    | map mu _ _ => cases mu <;> simp [Ty.tsubst, Ty.relocR0_muRs, Ty.relocR] at h1
    | tvar => simp only [Ty.tsubst_idArgs_tvar', Ty.relocR0_tvar] at h1; simp [Ty.tsubst, Ty.relocR0_muRs] at h1
    | _ => simp [Ty.tsubst, Ty.relocR0_muRs, Ty.relocR] at h1

theorem MeetK.sub (H : MeetK k1 k2 m) : ∀ {A B : Ty}, Ty.sub (A.tsubst (Kind.idArgs k1)) (B.tsubst (Kind.idArgs k1)) = true →
    Ty.sub (A.tsubst (Kind.idArgs k2)) (B.tsubst (Kind.idArgs k2)) = true →
    Ty.sub (A.tsubst (Kind.idArgs m)) (B.tsubst (Kind.idArgs m)) = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> (try simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢)
    case tvar i' ρ' kd' =>
      obtain ⟨⟨rfl, hk⟩, h1⟩ := h1
      obtain ⟨-, h2⟩ := h2
      rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, b, e1, e2, e3, n1, n2⟩
      · simp_all
      · simp only [e1, e2, e3, Option.getD_some, Option.map_some, true_and] at h1 h2 ⊢
        kind_split a b
  | int =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
  | bool =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
  | byte =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
  | f64 =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
  | unit =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
  | opt t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ih h1 h2
  | union l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | prod l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | ref mu r t ih =>
    intro B h1 h2
    cases mu <;> cases B <;> (try rename_i mu' _ _; cases mu') <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> (first | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2.2 h2.2.2⟩ | skip)
  | slice mu r t ih =>
    intro B h1 h2
    cases mu <;> cases B <;> (try rename_i mu' _ _; cases mu') <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> (first | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2.2 h2.2.2⟩ | skip)
  | map mu r t ih =>
    intro B h1 h2
    cases mu <;> cases B <;> (try rename_i mu' _ _; cases mu') <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> (first | exact ⟨h1.1, ih h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2 h2.2⟩ | exact ⟨h1.1, H.inj2 h1.2.2 h2.2.2⟩ | skip)
  | chan rc t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨h1.1, H.inj2 h1.2 h2.2⟩
  | dom r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
    exact ⟨⟨h1.1.1, ih h1.1.2 h2.1.2⟩, H.relocInj2 h1.2 h2.2⟩
  | fn p r ihp ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨H.inj2 h1.1 h2.1, H.inj2 h1.2 h2.2⟩
  | mus n i b ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩
  | rvar i =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact h1
  | own k r t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢ <;> exact ⟨h1.1, h1.2.1, H.inj2 h1.2.2 h2.2.2⟩
  | muRs r n i b ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
    refine ⟨⟨h1.1.1, H.inj2 h1.1.2 h2.1.2⟩, ?_⟩
    rcases h1.2 with h | ⟨hr, hc1⟩
    · exact .inl h
    · rcases h2.2 with h | ⟨-, hc2⟩
      · exact .inl h
      · exact .inr ⟨hr, H.covOk hc1 hc2⟩


/-! ## 呼び先のシグネチャの実体化の像 -/

theorem MeetK.wm (H : MeetK k1 k2 m) {B : Ty} (hB : B.tvWf m = true) : (B.tsubst (Kind.idArgs m)).tvWf m = true := by
  refine Ty.tvWf_tsubst (fun s hs => ?_) (Kind.idArgs_length m) hB
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem hs
  have hj' : j < m.length := by simpa [Kind.idArgs_length] using hj
  simp [Kind.idArgs, Ty.tvWf, List.getElem?_eq_getElem hj', Kind.le_refl]

/-- 型引数を m へ置き直してから実体化した型は、k の世界への置き直しで、型引数を k へ置き直した実体化になる -/
theorem MeetK.inst_img {k : List Kind} (Kk : ∀ {B : Ty}, B.tvWf m = true → B.kindsOk (Kind.idArgs k) = true)
    (Ck : ∀ t : Ty, (t.tsubst (Kind.idArgs m)).tsubst (Kind.idArgs k) = t.tsubst (Kind.idArgs k))
    (H : MeetK k1 k2 m) {Y : Ty} {ts : List Ty} (hY : Y.tvarsBelow ts.length = true) (w : ∀ s ∈ ts, s.tvWf m = true) :
    (Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m)))).tsubst (Kind.idArgs k) = Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs k))) := by
  have hk : ∀ s ∈ ts.map (Ty.tsubst (Kind.idArgs m)), s.kindsOk (Kind.idArgs k) = true := by
    intro s hs; obtain ⟨u, hu, rfl⟩ := List.mem_map.mp hs; exact Kk (H.wm (w u hu))
  rw [Ty.tsubst_comp hk (by simpa using hY), List.map_map]
  congr 1
  exact List.map_congr_left (fun u _ => Ck u)

theorem MeetK.inst_img1 (H : MeetK k1 k2 m) {Y : Ty} {ts : List Ty} (hY : Y.tvarsBelow ts.length = true)
    (w : ∀ s ∈ ts, s.tvWf m = true) :
    (Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m)))).tsubst (Kind.idArgs k1) = Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs k1))) :=
  MeetK.inst_img H.K1 H.comp1 H hY w

theorem MeetK.inst_img2 (H : MeetK k1 k2 m) {Y : Ty} {ts : List Ty} (hY : Y.tvarsBelow ts.length = true)
    (w : ∀ s ∈ ts, s.tvWf m = true) :
    (Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m)))).tsubst (Kind.idArgs k2) = Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs k2))) :=
  MeetK.inst_img H.K2 H.comp2 H hY w

theorem MeetK.inst_imgm (H : MeetK k1 k2 m) {Y : Ty} {ts : List Ty} (hY : Y.tvarsBelow ts.length = true)
    (w : ∀ s ∈ ts, s.tvWf m = true) :
    (Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m)))).tsubst (Kind.idArgs m) = Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m))) :=
  MeetK.inst_img H.Km H.compm H hY w

/-- 実体化の形の型は整形 -/
theorem MeetK.inst_wf (H : MeetK k1 k2 m) {Y : Ty} {ks : List Kind} {ts : List Ty} (hY : Y.tvWf ks = true)
    (hl : ts.length = ks.length) (w : ∀ s ∈ ts, s.tvWf m = true) :
    (Y.tsubst (ts.map (Ty.tsubst (Kind.idArgs m)))).tvWf m = true :=
  Ty.tvWf_tsubst (fun s hs => by obtain ⟨u, hu, rfl⟩ := List.mem_map.mp hs; exact H.wm (w u hu)) (by simp [hl]) hY

/-! ## 締めの写しの条件と、締めた型の部分型の反映（jumpRel） -/

theorem MeetK.clampOk (H : MeetK k1 k2 m) {b k : Nat} : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).clampOk b k = true →
    (A.tsubst (Kind.idArgs k2)).clampOk b k = true → (A.tsubst (Kind.idArgs m)).clampOk b k = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, c, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]
      simp only [Ty.clampOk, Kind.imm, Bool.or_eq_true, Bool.not_eq_true', Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      clear e1 e2 e3; kind_split a c
  | ref mu r t ih =>
    intro h1 h2; cases mu
    · simp only [Ty.tsubst, Ty.clampOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      rcases h1 with h | h
      · exact .inl h
      · rcases h2 with h' | h'
        · exact .inl h'
        · exact .inr ⟨h.1, H.chanFree h.2 h'.2⟩
    · simp [Ty.tsubst, Ty.clampOk]
  | slice mu r t ih =>
    intro h1 h2; cases mu
    · simp only [Ty.tsubst, Ty.clampOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      rcases h1 with h | h
      · exact .inl h
      · rcases h2 with h' | h'
        · exact .inl h'
        · exact .inr ⟨h.1, H.chanFree h.2 h'.2⟩
    · simp [Ty.tsubst, Ty.clampOk]
  | map mu r t ih =>
    intro h1 h2; cases mu
    · simp only [Ty.tsubst, Ty.clampOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      rcases h1 with h | h
      · exact .inl h
      · rcases h2 with h' | h'
        · exact .inl h'
        · exact .inr ⟨h.1, H.chanFree h.2 h'.2⟩
    · simp [Ty.tsubst, Ty.clampOk]
  | muRs r n i bd ih =>
    intro h1 h2
    simp only [Ty.tsubst, Ty.clampOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
    rcases h1 with h | h
    · exact .inl h
    · rcases h2 with h' | h'
      · exact .inl h'
      · exact .inr ⟨h.1, H.chanFree h.2 h'.2⟩
  | opt t ih => intro h1 h2; simp only [Ty.tsubst, Ty.clampOk] at h1 h2 ⊢; exact ih h1 h2
  | union l r ihl ihr =>
    intro h1 h2; simp only [Ty.tsubst, Ty.clampOk, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | prod l r ihl ihr =>
    intro h1 h2; simp only [Ty.tsubst, Ty.clampOk, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | _ => intro _ _; simp [Ty.tsubst, Ty.clampOk]

theorem Ty.clampR_tvar (k i r : Nat) (kd : Kind) :
    (Ty.tvar i r kd).clampR k = .tvar i (if kd.rf then r else if kd.imm then min r k else r) kd := by
  simp only [Ty.clampR]; split <;> (try split) <;> simp_all

/-- 外す旗の向き: m の像で mut を持たなければ、旗の多い k2 の像でも持たない -/
theorem MeetK.mutFree2 (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs m)).mutFree = true →
    (A.tsubst (Kind.idArgs k2)).mutFree = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, c, n1, n2, e1, e2, e3⟩
    · rw [e2]; rw [e3] at h; exact h
    · rw [e3] at h; rw [e2]; simp only [Ty.mutFree] at h ⊢
      clear e1 e2 e3; have h' := h; kind_bash a c h h' n1 n2
  | _ => intro h; simp_all [Ty.tsubst, Ty.mutFree]

theorem MeetK.mutFree1 (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs m)).mutFree = true →
    (A.tsubst (Kind.idArgs k1)).mutFree = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, c, n1, n2, e1, e2, e3⟩
    · rw [e1]; rw [e3] at h; exact h
    · rw [e3] at h; rw [e1]; simp only [Ty.mutFree] at h ⊢
      clear e1 e2 e3; have h' := h; kind_bash a c h h' n1 n2
  | _ => intro h; simp_all [Ty.tsubst, Ty.mutFree]

/-- 締めた像が像に等しい: 2 つの世界で成り立てば m の世界でも -/
theorem MeetK.clampEq (H : MeetK k1 k2 m) {k : Nat} :
    ∀ {A B : Ty}, (A.tsubst (Kind.idArgs k1)).clampR k = B.tsubst (Kind.idArgs k1) →
      (A.tsubst (Kind.idArgs k2)).clampR k = B.tsubst (Kind.idArgs k2) →
      (A.tsubst (Kind.idArgs m)).clampR k = B.tsubst (Kind.idArgs m) := by
  intro A
  induction A with
  | tvar i ρ kd =>
    intro B h1 h2
    rw [Ty.tsubst_idArgs_tvar', Ty.clampR_tvar] at h1 h2 ⊢
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> (try simp only [Ty.tsubst, reduceCtorEq] at h1)
    case tvar i' ρ' kd' =>
      simp only [Ty.tvar.injEq] at h1 h2 ⊢
      obtain ⟨rfl, hρ1, hk1⟩ := h1
      obtain ⟨-, hρ2, hk2⟩ := h2
      rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, c, e1, e2, e3, n1, n2⟩
      · simp_all
      · simp only [e1, e2, e3, Option.map_some, Option.getD_some] at hρ1 hρ2 hk1 hk2 ⊢
        simp only [Kind.imm] at hρ1 hρ2 ⊢
        kind_split a c
  | int =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.int).tsubst (Kind.idArgs k')).clampR k = (Ty.int).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | bool =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.bool).tsubst (Kind.idArgs k')).clampR k = (Ty.bool).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | byte =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.byte).tsubst (Kind.idArgs k')).clampR k = (Ty.byte).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | f64 =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.f64).tsubst (Kind.idArgs k')).clampR k = (Ty.f64).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | unit =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.unit).tsubst (Kind.idArgs k')).clampR k = (Ty.unit).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | chan rc t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.chan rc t).tsubst (Kind.idArgs k')).clampR k = (Ty.chan rc t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | dom rc t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.dom rc t).tsubst (Kind.idArgs k')).clampR k = (Ty.dom rc t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | fn p q _ _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.fn p q).tsubst (Kind.idArgs k')).clampR k = (Ty.fn p q).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | mus n i t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.mus n i t).tsubst (Kind.idArgs k')).clampR k = (Ty.mus n i t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | rvar i =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.rvar i).tsubst (Kind.idArgs k')).clampR k = (Ty.rvar i).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | own o r t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.own o r t).tsubst (Kind.idArgs k')).clampR k = (Ty.own o r t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | ref mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.ref false r t).tsubst (Kind.idArgs kk)).clampR k =
          .ref false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp only [Ty.tsubst, reduceCtorEq] at h1
      case ref mu' r' t' =>
        simp only [Ty.tsubst, Ty.ref.injEq] at h1 h2 ⊢
        exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.ref true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.ref true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | slice mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.slice false r t).tsubst (Kind.idArgs kk)).clampR k =
          .slice false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp only [Ty.tsubst, reduceCtorEq] at h1
      case slice mu' r' t' =>
        simp only [Ty.tsubst, Ty.slice.injEq] at h1 h2 ⊢
        exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.slice true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.slice true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | map mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.map false r t).tsubst (Kind.idArgs kk)).clampR k =
          .map false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp only [Ty.tsubst, reduceCtorEq] at h1
      case map mu' r' t' =>
        simp only [Ty.tsubst, Ty.map.injEq] at h1 h2 ⊢
        exact ⟨h1.1, h1.2.1, ih h1.2.2 h2.2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.map true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.map true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.inj2 h1 h2
  | muRs r n i bd ih =>
    intro B h1 h2
    have g : ∀ kk : List Kind, ((Ty.muRs r n i bd).tsubst (Kind.idArgs kk)).clampR k =
        .muRs (if (bd.tsubst (Kind.idArgs kk)).mutFree then min r k else r) n i (bd.tsubst (Kind.idArgs kk)) := by
      intro kk; simp only [Ty.tsubst, Ty.clampR]; split <;> simp_all
    rw [g k1] at h1; rw [g k2] at h2; rw [g m]
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp only [Ty.tsubst, reduceCtorEq] at h1
    case muRs r' n' i' bd' =>
      simp only [Ty.tsubst, Ty.muRs.injEq] at h1 h2 ⊢
      obtain ⟨hr1, rfl, rfl, hb1⟩ := h1
      obtain ⟨hr2, -, -, hb2⟩ := h2
      refine ⟨?_, rfl, rfl, H.inj2 hb1 hb2⟩
      have m1 := H.mutFree1 (A := bd); have m2 := H.mutFree2 (A := bd); have mm := H.mutFree (A := bd)
      cases e1 : (bd.tsubst (Kind.idArgs k1)).mutFree <;> cases e2 : (bd.tsubst (Kind.idArgs k2)).mutFree <;>
        cases e3 : (bd.tsubst (Kind.idArgs m)).mutFree <;> simp_all
  | opt t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR] at h1 h2 ⊢
    exact ih h1 h2
  | union l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | prod l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩

/-- 締めた像の部分型（jumpRel の前半）: 2 つの世界で成り立てば m の世界でも -/
theorem MeetK.subClamp (H : MeetK k1 k2 m) {k : Nat} :
    ∀ {A B : Ty}, Ty.sub ((A.tsubst (Kind.idArgs k1)).clampR k) (B.tsubst (Kind.idArgs k1)) = true →
      Ty.sub ((A.tsubst (Kind.idArgs k2)).clampR k) (B.tsubst (Kind.idArgs k2)) = true →
      Ty.sub ((A.tsubst (Kind.idArgs m)).clampR k) (B.tsubst (Kind.idArgs m)) = true := by
  intro A
  induction A with
  | tvar i ρ kd =>
    intro B h1 h2
    rw [Ty.tsubst_idArgs_tvar', Ty.clampR_tvar] at h1 h2 ⊢
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.sub] at h1
    case tvar i' ρ' kd' =>
      simp only [Ty.sub, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      obtain ⟨⟨rfl, hk1⟩, h1⟩ := h1
      obtain ⟨⟨-, hk2⟩, h2⟩ := h2
      rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, c, e1, e2, e3, n1, n2⟩
      · simp_all
      · simp only [e1, e2, e3, Option.map_some, Option.getD_some] at hk1 hk2 h1 h2 ⊢
        simp only [Kind.imm] at h1 h2 ⊢
        kind_split a c
  | int =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.int).tsubst (Kind.idArgs k')).clampR k = (Ty.int).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | bool =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.bool).tsubst (Kind.idArgs k')).clampR k = (Ty.bool).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | byte =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.byte).tsubst (Kind.idArgs k')).clampR k = (Ty.byte).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | f64 =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.f64).tsubst (Kind.idArgs k')).clampR k = (Ty.f64).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | unit =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.unit).tsubst (Kind.idArgs k')).clampR k = (Ty.unit).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | chan rc t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.chan rc t).tsubst (Kind.idArgs k')).clampR k = (Ty.chan rc t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | dom rc t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.dom rc t).tsubst (Kind.idArgs k')).clampR k = (Ty.dom rc t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | fn p q _ _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.fn p q).tsubst (Kind.idArgs k')).clampR k = (Ty.fn p q).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | mus n i t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.mus n i t).tsubst (Kind.idArgs k')).clampR k = (Ty.mus n i t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | rvar i =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.rvar i).tsubst (Kind.idArgs k')).clampR k = (Ty.rvar i).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | own o r t _ =>
    intro B h1 h2
    have e : ∀ k' : List Kind, ((Ty.own o r t).tsubst (Kind.idArgs k')).clampR k = (Ty.own o r t).tsubst (Kind.idArgs k') :=
      fun _ => by simp [Ty.tsubst, Ty.clampR]
    rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | ref mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.ref false r t).tsubst (Kind.idArgs kk)).clampR k =
          .ref false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp [Ty.tsubst, Ty.sub] at h1
      case ref mu' r' t' =>
        cases mu' <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
        exact ⟨h1.1, H.clampEq h1.2 h2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.ref true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.ref true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | slice mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.slice false r t).tsubst (Kind.idArgs kk)).clampR k =
          .slice false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp [Ty.tsubst, Ty.sub] at h1
      case slice mu' r' t' =>
        cases mu' <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
        exact ⟨h1.1, ih h1.2 h2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.slice true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.slice true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | map mu r t ih =>
    intro B h1 h2
    cases mu
    · have g : ∀ kk : List Kind, ((Ty.map false r t).tsubst (Kind.idArgs kk)).clampR k =
          .map false (min r k) ((t.tsubst (Kind.idArgs kk)).clampR k) := fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [g k1] at h1; rw [g k2] at h2; rw [g m]
      cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp [Ty.tsubst, Ty.sub] at h1
      case map mu' r' t' =>
        cases mu' <;> simp [Ty.tsubst, Ty.sub] at h1 h2 ⊢
        exact ⟨h1.1, ih h1.2 h2.2⟩
    · have e : ∀ k' : List Kind, ((Ty.map true r t).tsubst (Kind.idArgs k')).clampR k = (Ty.map true r t).tsubst (Kind.idArgs k') :=
        fun _ => by simp [Ty.tsubst, Ty.clampR]
      rw [e k1] at h1; rw [e k2] at h2; rw [e m]; exact H.sub h1 h2
  | muRs r n i bd ih =>
    intro B h1 h2
    have g : ∀ kk : List Kind, ((Ty.muRs r n i bd).tsubst (Kind.idArgs kk)).clampR k =
        .muRs (if (bd.tsubst (Kind.idArgs kk)).mutFree then min r k else r) n i (bd.tsubst (Kind.idArgs kk)) := by
      intro kk; simp only [Ty.tsubst, Ty.clampR]; split <;> simp_all
    rw [g k1] at h1; rw [g k2] at h2; rw [g m]
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1) <;> simp [Ty.tsubst, Ty.sub] at h1
    case muRs r' n' i' bd' =>
      simp only [Ty.tsubst, Ty.sub, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h1 h2 ⊢
      obtain ⟨⟨⟨rfl, rfl⟩, hb1⟩, h1⟩ := h1
      obtain ⟨⟨⟨-, -⟩, hb2⟩, h2⟩ := h2
      refine ⟨⟨⟨rfl, rfl⟩, H.inj2 hb1 hb2⟩, ?_⟩
      have m1 := H.mutFree1 (A := bd); have m2 := H.mutFree2 (A := bd); have mm := H.mutFree (A := bd)
      have cm := H.covOk (A := bd)
      have c1 := Ty.mutFree_of_covOk (t := bd.tsubst (Kind.idArgs k1))
      have c2 := Ty.mutFree_of_covOk (t := bd.tsubst (Kind.idArgs k2))
      cases e1 : (bd.tsubst (Kind.idArgs k1)).mutFree <;> cases e2 : (bd.tsubst (Kind.idArgs k2)).mutFree <;>
        cases e3 : (bd.tsubst (Kind.idArgs m)).mutFree <;>
        cases f1 : (bd.tsubst (Kind.idArgs k1)).covOk <;> cases f2 : (bd.tsubst (Kind.idArgs k2)).covOk <;>
        cases f3 : (bd.tsubst (Kind.idArgs m)).covOk <;> simp_all <;> omega
  | opt t ih =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR, Ty.sub] at h1 h2 ⊢
    exact ih h1 h2
  | union l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR, Ty.sub] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | prod l r ihl ihr =>
    intro B h1 h2
    cases B <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h1 h2 ⊢) <;> simp [Ty.tsubst, Ty.clampR, Ty.sub] at h1 h2 ⊢
    exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩

/-- jump の関係（締めて浅い共変・位置ごとの写しの条件）の反映 -/
theorem MeetK.jumpRel (H : MeetK k1 k2 m) {b k : Nat} {A B : Ty}
    (h1 : Ty.jumpRel b k (A.tsubst (Kind.idArgs k1)) (B.tsubst (Kind.idArgs k1)) = true)
    (h2 : Ty.jumpRel b k (A.tsubst (Kind.idArgs k2)) (B.tsubst (Kind.idArgs k2)) = true) :
    Ty.jumpRel b k (A.tsubst (Kind.idArgs m)) (B.tsubst (Kind.idArgs m)) = true := by
  simp only [Ty.jumpRel, Bool.and_eq_true] at h1 h2 ⊢
  exact ⟨H.subClamp h1.1 h2.1, H.clampOk h1.2 h2.2⟩

/-! ## 読み出し・キー・送りの条件の反映 -/

theorem MeetK.annFree (H : MeetK k1 k2 m) : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).annFree = true →
    (A.tsubst (Kind.idArgs k2)).annFree = true → (A.tsubst (Kind.idArgs m)).annFree = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, c, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]; simp only [Ty.annFree] at h1 h2 ⊢
      clear e1 e2 e3; kind_bash a c h1 h2 n1 n2
  | prod l r ihl ihr =>
    intro h1 h2; simp only [Ty.tsubst, Ty.annFree, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | slice mu r t ih =>
    intro h1 h2; cases mu
    · simp only [Ty.tsubst, Ty.annFree, Bool.false_or] at h1 h2 ⊢; exact ih h1 h2
    · simp [Ty.tsubst, Ty.annFree]
  | map mu r t ih =>
    intro h1 h2; cases mu
    · simp only [Ty.tsubst, Ty.annFree, Bool.false_or] at h1 h2 ⊢; exact ih h1 h2
    · simp [Ty.tsubst, Ty.annFree]
  | _ => intro h1 h2; simp_all [Ty.tsubst, Ty.annFree]

/-- 読み出しの結果型: 注釈があれば注釈、無ければ要素型。どちらも形の像 -/
theorem MeetK.readAs (H : MeetK k1 k2 m) {mu : Bool} {ot : Option Ty} {X t1 t2 : Ty}
    (h1 : Ty.readAs mu (ot.map (Ty.tsubst (Kind.idArgs k1))) (X.tsubst (Kind.idArgs k1)) = some t1)
    (h2 : Ty.readAs mu (ot.map (Ty.tsubst (Kind.idArgs k2))) (X.tsubst (Kind.idArgs k2)) = some t2) :
    ∃ T, (T = X ∨ ot = some T) ∧ T.tsubst (Kind.idArgs k1) = t1 ∧ T.tsubst (Kind.idArgs k2) = t2 ∧
      Ty.readAs mu (ot.map (Ty.tsubst (Kind.idArgs m))) (X.tsubst (Kind.idArgs m)) = some (T.tsubst (Kind.idArgs m)) := by
  cases ot with
  | none =>
    simp only [Option.map_none, Ty.readAs] at h1 h2 ⊢
    split at h1 <;> split at h2 <;> simp at h1 h2
    subst h1 h2
    rename_i c1 c2
    refine ⟨X, .inl rfl, rfl, rfl, ?_⟩
    have : (mu || (X.tsubst (Kind.idArgs m)).annFree) = true := by
      cases mu
      · simp only [Bool.false_or] at c1 c2 ⊢; exact H.annFree c1 c2
      · rfl
    simp [this]
  | some u =>
    simp only [Option.map_some, Ty.readAs] at h1 h2 ⊢
    split at h1 <;> split at h2 <;> simp at h1 h2
    subst h1 h2
    rename_i c1 c2
    exact ⟨u, .inr rfl, rfl, rfl, by simp [H.sub c1 c2]⟩

theorem Ty.keyCompat_cases {a c : Ty} (h : a.keyCompat c = true) :
    (a = .int ∧ c = .int) ∨
    (∃ i ρ k ρ' k', a = .tvar i ρ k ∧ c = .tvar i ρ' k' ∧ k.kf = true ∧ k.mf = true ∧ k'.kf = true ∧ k'.mf = true) ∨
    (∃ r r', a = .slice false r .byte ∧ c = .slice false r' .byte) := by
  unfold Ty.keyCompat at h
  split at h
  · exact .inl ⟨rfl, rfl⟩
  · simp only [Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨⟨⟨⟨rfl, h1⟩, h2⟩, h3⟩, h4⟩ := h
    exact .inr (.inl ⟨_, _, _, _, _, rfl, rfl, h1, h2, h3, h4⟩)
  · exact .inr (.inr ⟨_, _, rfl, rfl⟩)
  · simp at h

theorem Ty.idArgs_inv_tvar {k : List Kind} {T : Ty} {i ρ : Nat} {kd : Kind}
    (h : T.tsubst (Kind.idArgs k) = .tvar i ρ kd) : ∃ ρ0 kd0, T = .tvar i ρ0 kd0 := by
  cases T <;> (try simp only [Ty.tsubst_idArgs_tvar'] at h) <;> simp [Ty.tsubst] at h
  exact ⟨_, _, by rw [h.1]⟩

theorem MeetK.keyCompat (H : MeetK k1 k2 m) {A B : Ty}
    (h1 : (A.tsubst (Kind.idArgs k1)).keyCompat (B.tsubst (Kind.idArgs k1)) = true)
    (h2 : (A.tsubst (Kind.idArgs k2)).keyCompat (B.tsubst (Kind.idArgs k2)) = true) :
    (A.tsubst (Kind.idArgs m)).keyCompat (B.tsubst (Kind.idArgs m)) = true := by
  rcases Ty.keyCompat_cases h1 with ⟨ea, eb⟩ | ⟨i, ρ, kk, ρ', kk', ea, eb, -, -, -, -⟩ | ⟨r, r', ea, eb⟩
  · cases Ty.idArgs_inv_int ea; cases Ty.idArgs_inv_int eb; rfl
  · obtain ⟨ρa, ka, rfl⟩ := Ty.idArgs_inv_tvar ea
    obtain ⟨ρb, kb, rfl⟩ := Ty.idArgs_inv_tvar eb
    simp only [Ty.tsubst_idArgs_tvar', Ty.keyCompat, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
    obtain ⟨⟨⟨⟨-, a1⟩, a2⟩, a3⟩, a4⟩ := h1
    obtain ⟨⟨⟨⟨-, b1⟩, b2⟩, b3⟩, b4⟩ := h2
    rcases H.cases i with ⟨e1, e2, e3⟩ | ⟨a, c, e1, e2, e3, n1, n2⟩
    · simp_all
    · simp only [e1, e2, e3, Option.getD_some] at a1 a2 a3 a4 b1 b2 b3 b4 ⊢
      simp [Kind.meet, a1, a2, b1, b2]
  · obtain ⟨Xa, rfl, xa⟩ := Ty.idArgs_inv_slice ea
    obtain ⟨Xb, rfl, xb⟩ := Ty.idArgs_inv_slice eb
    cases Ty.idArgs_inv_byte xa; cases Ty.idArgs_inv_byte xb
    rfl

/-- 送りの条件（payOk）: 形の型は m の世界で整形 -/
theorem MeetK.payOk (H : MeetK k1 k2 m) {A B : Ty} (wA : A.tvWf m = true) (wB : B.tvWf m = true)
    (h1 : Ty.payOk (A.tsubst (Kind.idArgs k1)) (B.tsubst (Kind.idArgs k1)) = true)
    (h2 : Ty.payOk (A.tsubst (Kind.idArgs k2)) (B.tsubst (Kind.idArgs k2)) = true) :
    Ty.payOk (A.tsubst (Kind.idArgs m)) (B.tsubst (Kind.idArgs m)) = true := by
  simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at h1 h2 ⊢
  obtain ⟨⟨⟨⟨ma1, ca1⟩, mb1⟩, cb1⟩, q1⟩ := h1
  obtain ⟨⟨⟨⟨ma2, ca2⟩, mb2⟩, cb2⟩, q2⟩ := h2
  have ma := H.mutFree ma1 ma2; have ca := H.chanFree ca1 ca2
  have mb := H.mutFree mb1 mb2; have cb := H.chanFree cb1 cb2
  refine ⟨⟨⟨⟨ma, ca⟩, mb⟩, cb⟩, ?_⟩
  have wA' := H.wm wA; have wB' := H.wm wB
  have r1 : ((A.tsubst (Kind.idArgs m)).relocR 0).tsubst (Kind.idArgs k1) =
      ((B.tsubst (Kind.idArgs m)).relocR 0).tsubst (Kind.idArgs k1) := by
    rw [← Ty.tsubst_relocR_mc _ ma ca (H.K1 wA'), ← Ty.tsubst_relocR_mc _ mb cb (H.K1 wB'), H.comp1, H.comp1, q1]
  have r2 : ((A.tsubst (Kind.idArgs m)).relocR 0).tsubst (Kind.idArgs k2) =
      ((B.tsubst (Kind.idArgs m)).relocR 0).tsubst (Kind.idArgs k2) := by
    rw [← Ty.tsubst_relocR_mc _ ma ca (H.K2 wA'), ← Ty.tsubst_relocR_mc _ mb cb (H.K2 wB'), H.comp2, H.comp2, q2]
  have r3 := H.inj2 r1 r2
  rwa [← Ty.tsubst_relocR_mc _ ma ca (H.Km wA'), ← Ty.tsubst_relocR_mc _ mb cb (H.Km wB'), H.compm, H.compm] at r3

/-! ## 引き渡し（spawn）の条件の反映 -/

theorem MeetK.givable (H : MeetK k1 k2 m) {rs : Nat} : ∀ {A : Ty}, (A.tsubst (Kind.idArgs k1)).givable rs = true →
    (A.tsubst (Kind.idArgs k2)).givable rs = true → (A.tsubst (Kind.idArgs m)).givable rs = true := by
  intro A; induction A with
  | tvar i ρ kd =>
    intro h1 h2
    rcases H.tvar_cases i ρ kd with ⟨e1, e2, e3⟩ | ⟨a, c, n1, n2, e1, e2, e3⟩
    · rw [e3]; rw [e1] at h1; exact h1
    · rw [e1] at h1; rw [e2] at h2; rw [e3]
      simp only [Ty.givable, Ty.mutFree, Ty.chanFree, Ty.regionsBelow, Bool.and_eq_true, Bool.or_eq_true,
        decide_eq_true_eq] at h1 h2 ⊢
      clear e1 e2 e3; kind_split a c
  | prod l r ihl ihr =>
    intro h1 h2; simp only [Ty.tsubst, Ty.givable, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨ihl h1.1 h2.1, ihr h1.2 h2.2⟩
  | dom r t _ =>
    intro h1 h2; simp only [Ty.tsubst, Ty.givable, Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨h1.1.1, H.mutFree h1.1.2 h2.1.2⟩, H.chanFree h1.2 h2.2⟩
  | own o r t _ =>
    intro h1 h2
    cases o
    · simp [Ty.tsubst, Ty.givable, Ty.mutFree] at h1
    · simp [Ty.tsubst, Ty.givable, Ty.mutFree] at h1
    · simp only [Ty.tsubst, Ty.givable, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨H.mutFree h1.1 h2.1, H.chanFree h1.2 h2.2⟩
    · simp only [Ty.tsubst, Ty.givable, Bool.and_eq_true] at h1 h2 ⊢; exact ⟨H.mutFree h1.1 h2.1, H.chanFree h1.2 h2.2⟩
  | int =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.int).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.int).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.int).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | bool =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.bool).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.bool).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.bool).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | byte =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.byte).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.byte).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.byte).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | f64 =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.f64).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.f64).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.f64).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | unit =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.unit).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.unit).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.unit).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | opt t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.opt t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.opt t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.opt t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | union l r _ _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.union l r).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.union l r).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.union l r).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | ref mu r t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.ref mu r t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.ref mu r t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.ref mu r t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | slice mu r t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.slice mu r t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.slice mu r t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.slice mu r t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | map mu r t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.map mu r t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.map mu r t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.map mu r t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | chan rc t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.chan rc t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.chan rc t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.chan rc t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | fn p q _ _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.fn p q).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.fn p q).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.fn p q).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | mus n i t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.mus n i t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.mus n i t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.mus n i t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | rvar i =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.rvar i).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.rvar i).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.rvar i).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩
  | muRs r n i t _ =>
    intro h1 h2
    have hp : ∀ k : List Kind, ∀ l₀ r₀, ((Ty.muRs r n i t).tsubst (Kind.idArgs k)) ≠ .prod l₀ r₀ := by intro k l₀ r₀; simp [Ty.tsubst]
    have ho : ∀ k : List Kind, ∀ o₀ r₀ u₀, ((Ty.muRs r n i t).tsubst (Kind.idArgs k)) ≠ .own o₀ r₀ u₀ := by intro k o₀ r₀ u₀; simp [Ty.tsubst]
    have hd : ∀ k : List Kind, ∀ rc₀ u₀, ((Ty.muRs r n i t).tsubst (Kind.idArgs k)) ≠ .dom rc₀ u₀ := by intro k rc₀ u₀; simp [Ty.tsubst]
    rw [Ty.givable_eq_data (hp k1) (ho k1) (hd k1)] at h1
    rw [Ty.givable_eq_data (hp k2) (ho k2) (hd k2)] at h2
    rw [Ty.givable_eq_data (hp m) (ho m) (hd m)]
    simp only [Bool.and_eq_true] at h1 h2 ⊢
    exact ⟨⟨H.mutFree h1.1.1 h2.1.1, H.chanFree h1.1.2 h2.1.2⟩, H.regionsBelow h1.2 h2.2⟩

end

end FS
