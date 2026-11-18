import FeatherweightSober.KindDef

/-!
# kind の推論の正しさ（相互再帰の成分）

相互再帰の成分 C の Def の形 `S g`（型変数の出現の旗は置き直しで決まる）に、kind の列を割り当てる。
割り当て K が整合（`Consistent`）とは、成分の行を K で置き直した関数表の下で、成分のどの行も自分の kind の列で型付くこと。

推論の手順（`inferK`）は、シグネチャの条件（戻りの型の retOk）の最小を出発点に、成分の行ごとに貪欲に旗を外す反復
（KindInfer.lean の `runK`）を回す。型付けの判定はそのまま使う（`accK`）。

- 手順が割り当てを返すなら、それは整合な割り当てのうち最小で、最小の整合な割り当ては1つに決まる
- 手順が型付かないと答えるなら、整合な割り当ては無い

反復の途中の割り当てはシグネチャの条件を満たすとは限らないので、判定では呼び先の行を出発点以上の正規形へ持ち上げる
（`upL`）。整合な割り当ては出発点以上の正規形なので、持ち上げても変わらない。
-/

namespace FS

/-! ## kind の join と持ち上げ -/

def Kind.join (a b : Kind) : Kind := ⟨a.rf || b.rf, a.mf || b.mf, a.cf || b.cf, a.cov || b.cov, a.kf || b.kf⟩

theorem Kind.join_has (a b : Kind) (x : Flag) : (a.join b).has x = (a.has x || b.has x) := by cases x <;> rfl

theorem Kind.le_trans {a b c : Kind} (h1 : a.le b = true) (h2 : b.le c = true) : a.le c = true := by
  rw [Kind.le_iff_has] at *; exact fun x hx => h2 x (h1 x hx)

theorem Kind.le_join_left (a b : Kind) : a.le (a.join b) = true := by
  rw [Kind.le_iff_has]; intro x hx; rw [Kind.join_has, hx]; rfl

theorem Kind.join_mono {kb c c' : Kind} (h : c.le c' = true) : (kb.join c).le (kb.join c') = true := by
  rw [Kind.le_iff_has] at h ⊢; intro x hx
  rw [Kind.join_has, Bool.or_eq_true] at hx ⊢; exact hx.imp id (h x)

theorem Kind.norm_mono {a b : Kind} : a.le b = true → a.norm.le b.norm = true := by
  obtain ⟨r1, m1, c1, v1, f1⟩ := a; obtain ⟨r2, m2, c2, v2, f2⟩ := b
  revert r1 m1 c1 v1 f1 r2 m2 c2 v2 f2; decide

theorem Kind.join_norm_eq {kb a : Kind} : kb.le a = true → a.isNorm = true → (kb.join a).norm = a := by
  obtain ⟨r1, m1, c1, v1, f1⟩ := kb; obtain ⟨r2, m2, c2, v2, f2⟩ := a
  revert r1 m1 c1 v1 f1 r2 m2 c2 v2 f2; decide

/-- 行 a を、出発点 b 以上の正規形へ持ち上げる（長さは b に揃える） -/
def upL (a b : List Kind) : List Kind := b.mapIdx (fun j kb => (kb.join (a[j]?.getD kb)).norm)

theorem upL_get (a b : List Kind) (j : Nat) :
    (upL a b)[j]? = b[j]?.map (fun kb => (kb.join (a[j]?.getD kb)).norm) := by
  simp [upL, List.getElem?_mapIdx]

theorem upL_length (a b : List Kind) : (upL a b).length = b.length := by simp [upL]

theorem upL_norm (a b : List Kind) : KNorm (upL a b) := by
  intro k hk
  obtain ⟨j, hj, rfl⟩ := List.getElem_of_mem hk
  have := upL_get a b j
  rw [List.getElem?_eq_getElem hj] at this
  obtain ⟨kb, -, he⟩ := Option.map_eq_some_iff.mp this.symm
  rw [← he]; exact Kind.isNorm_norm _

theorem hasAt_iff_le {a b : List Kind} (hl : a.length = b.length)
    (h : ∀ (j : Nat) (k k' : Kind), a[j]? = some k → b[j]? = some k' → k.le k' = true) : KLe a b := by
  refine ⟨hl, fun j x hx => ?_⟩
  simp only [hasAt] at hx ⊢
  cases ha : a[j]? with
  | none => simp [ha] at hx
  | some k =>
    have hj : j < b.length := hl ▸ (List.getElem?_eq_some_iff.mp ha).1
    rw [List.getElem?_eq_getElem hj]
    rw [ha] at hx
    have := (Kind.le_iff_has.mp (h j k _ ha (List.getElem?_eq_getElem hj))) x (by simpa using hx)
    simpa using this

theorem upL_ge (a b : List Kind) : KLe b (upL a b) := by
  refine hasAt_iff_le (upL_length a b).symm (fun j k k' hb hu => ?_)
  rw [upL_get, hb] at hu; cases hu
  exact Kind.le_trans (Kind.le_join_left _ _) (Kind.le_norm _)

theorem upL_mono {a a' : List Kind} (h : KLe a a') (b : List Kind) : KLe (upL a b) (upL a' b) := by
  refine hasAt_iff_le (by simp [upL_length]) (fun j k k' h1 h2 => ?_)
  rw [upL_get] at h1 h2
  cases hb : b[j]? with
  | none => rw [hb] at h1; cases h1
  | some kb =>
    rw [hb] at h1 h2; cases h1; cases h2
    apply Kind.norm_mono
    cases ha : a[j]? with
    | none =>
      have : a'[j]? = none := by
        rw [List.getElem?_eq_none_iff, ← h.1]; exact List.getElem?_eq_none_iff.mp ha
      simp only [this, Option.getD_none]; exact Kind.le_refl _
    | some c =>
      obtain ⟨c', hc'⟩ : ∃ c', a'[j]? = some c' := by
        have := (List.getElem?_eq_some_iff.mp ha).1; rw [h.1] at this; exact ⟨_, List.getElem?_eq_getElem this⟩
      simp only [hc', Option.getD_some]; exact Kind.join_mono (h.le_get ha hc')

/-- 出発点以上の正規形は、持ち上げても変わらない -/
theorem upL_eq {a b : List Kind} (hn : KNorm a) (h : KLe b a) : upL a b = a := by
  apply List.ext_getElem?
  intro j
  rw [upL_get]
  cases hb : b[j]? with
  | none =>
    have : a[j]? = none := by rw [List.getElem?_eq_none_iff, ← h.1]; exact List.getElem?_eq_none_iff.mp hb
    simp [this]
  | some kb =>
    obtain ⟨c, hc⟩ : ∃ c, a[j]? = some c := by
      have := (List.getElem?_eq_some_iff.mp hb).1; rw [h.1] at this; exact ⟨_, List.getElem?_eq_getElem this⟩
    simp only [Option.map_some, hc, Option.getD_some]
    rw [Kind.join_norm_eq (h.le_get hb hc) (hn c (List.mem_of_getElem? hc))]

/-! ## 置き直しの合成と単調性 -/

theorem KLe.rf {a b : List Kind} (h : KLe a b) :
    ∀ (j : Nat) (ka kb : Kind), a[j]? = some ka → b[j]? = some kb → ka.rf = true → kb.rf = true := by
  intro j ka kb ha hb hr
  have := (Kind.le_iff_has.mp (h.le_get ha hb)) .rf (by simpa [Kind.has] using hr)
  simpa [Kind.has] using this

theorem Def.raise_raise (S : Def) {a b : List Kind} (h : KLe a b) : (S.raise a).raise b = S.raise b := by
  simp only [Def.raise, Ty.idArgs_comp h.1 h.rf, Expr.idArgs_comp h.1 h.rf]

theorem KLe.le_get' {a b : List Kind} (h : KLe a b) :
    ∀ (j : Nat) (k k' : Kind), a[j]? = some k → b[j]? = some k' → k.le k' = true :=
  fun _ _ _ ha hb => h.le_get ha hb

/-- 戻りの型の retOk は、旗を足した正規形の列へ保たれる -/
theorem Ty.retOk_raise {t : Ty} {a b : List Kind} (hn : KNorm b) (h : KLe a b) (ht : t.tvarsBelow a.length = true)
    (hr : (t.tsubst (Kind.idArgs a)).retOk = true) : (t.tsubst (Kind.idArgs b)).retOk = true := by
  rw [← Ty.idArgs_comp h.1 h.rf t]
  exact Ty.retOk_tsubst _ hr (Ty.kindsOk_of_tvWf (kindsArgsOk_idArgs h.1.symm h.le_get' hn)
    (by rw [Ty.tvWf_idArgs]; exact ht))

theorem DefOk.anti {Δ : Defs} {C : List Nat} {S : Nat → Def} {K K' : Nat → List Kind} (hle : KLeC C K K') {dfn : Def}
    (h : DefOk (Δ.withK C S K') dfn) : DefOk (Δ.withK C S K) dfn := by
  obtain ⟨h1, h2, h3, h4, h5, h6, h7, h8⟩ := h
  exact ⟨h1, h2, h3, h4, h5, h6, h7, HasType.callee_anti hle h8⟩

theorem Defs.withK_congr (Δ : Defs) (C : List Nat) (S : Nat → Def) {K K' : Nat → List Kind}
    (h : ∀ g ∈ C, K g = K' g) : Δ.withK C S K = Δ.withK C S K' := by
  unfold Defs.withK
  congr 1; funext g dfn
  by_cases hg : g ∈ C
  · simp [hg, h g hg]
  · simp [hg]

/-! ## 成分の推論 -/

section Comp

variable (Δ : Defs) (C : List Nat) (S : Nat → Def) (len : Nat → Nat)

/-- シグネチャの条件を満たす kind の列: 長さが合い、正規形で、置き直した戻りの型が retOk -/
def sigA (f : Nat) (a : List Kind) : Bool :=
  (a.length == len f) && a.all Kind.isNorm && ((S f).ret.tsubst (Kind.idArgs a)).retOk

/-- シグネチャの条件の最小（反復の出発点） -/
def sigMin (f : Nat) : List Kind := greedy (sigA S len f) (topL (len f)) (steps (len f))

/-- 呼び先の行を、出発点以上の正規形へ持ち上げた割り当て -/
def upK (K : Nat → List Kind) (g : Nat) : List Kind := upL (K g) (sigMin S len g)

/-- 型付けの判定: 呼び先の行を K（持ち上げる）にした関数表で、f の行が kind の列 a で型付く -/
noncomputable def accK (K : Nat → List Kind) (f : Nat) (a : List Kind) : Bool :=
  @decide (a.length = len f ∧ KNorm a ∧ DefOk (Δ.withK C S (upK S len K)) ((S f).raise a)) (Classical.propDecidable _)

/-- 整合な割り当て: 成分の行を K にした関数表の下で、成分のどの行も自分の kind の列で型付く -/
def Consistent (K : Nat → List Kind) : Prop :=
  ∀ f ∈ C, (K f).length = len f ∧ KNorm (K f) ∧ DefOk (Δ.withK C S K) ((S f).raise (K f))

/-- 推論の手順: シグネチャの条件が旗を全部立てても満たせない行があれば型付かない。そうでなければ反復 -/
noncomputable def inferK : Option (Nat → List Kind) :=
  if C.all (fun f => sigA S len f (topL (len f))) then runK C len (accK Δ C S len) (fuel C len) (sigMin S len) else none

/-- 成分の外の行はシグネチャの条件を満たし、成分の形のシグネチャの型変数は型パラメータの範囲内 -/
structure CompHyp : Prop where
  out : ∀ g dfn, Δ[g]? = some dfn → g ∉ C →
    dfn.ret.retOk = true ∧ dfn.param.tvarsBelow dfn.kinds.length = true ∧ dfn.ret.tvarsBelow dfn.kinds.length = true ∧
      dfn.param.tvWf dfn.kinds = true ∧ dfn.ret.tvWf dfn.kinds = true
  shape : ∀ g ∈ C, (S g).param.tvarsBelow (len g) = true ∧ (S g).ret.tvarsBelow (len g) = true

variable {Δ C S len}

theorem accK_iff {K : Nat → List Kind} {f : Nat} {a : List Kind} :
    accK Δ C S len K f a = true ↔ a.length = len f ∧ KNorm a ∧ DefOk (Δ.withK C S (upK S len K)) ((S f).raise a) := by
  simp [accK]

theorem sigA_iff {f : Nat} {a : List Kind} :
    sigA S len f a = true ↔ a.length = len f ∧ KNorm a ∧ ((S f).ret.tsubst (Kind.idArgs a)).retOk = true := by
  simp [sigA, KNorm, List.all_eq_true, and_assoc]

section
variable (hC : CompHyp Δ C S len)
include hC

theorem sigA_up {f : Nat} (hf : f ∈ C) {a b : List Kind} (ha : sigA S len f a = true) (hb : KNorm b) (hab : KLe a b) :
    sigA S len f b = true := by
  obtain ⟨l, -, r⟩ := sigA_iff.mp ha
  exact sigA_iff.mpr ⟨hab.1 ▸ l, hb, Ty.retOk_raise hb hab (l ▸ (hC.shape f hf).2) r⟩

theorem sigMin_spec {f : Nat} (hf : f ∈ C) (htop : sigA S len f (topL (len f)) = true) :
    sigA S len f (sigMin S len f) = true ∧ ∀ b, sigA S len f b = true → KLe (sigMin S len f) b := by
  have hmeet : ∀ a b, sigA S len f a = true → sigA S len f b = true → sigA S len f (meetL a b) = true := by
    intro a b ha hb
    obtain ⟨la, na, ra⟩ := sigA_iff.mp ha
    obtain ⟨lb, nb, rb⟩ := sigA_iff.mp hb
    have H := MeetK.of_meetL (la.trans lb.symm) na nb
    exact sigA_iff.mpr ⟨by rw [← H.l1, la], H.mnorm, H.retOk ra rb⟩
  obtain ⟨g1, -, g3⟩ := greedy_min (len f) (fun a b ha hb hab => sigA_up hC hf ha hb hab) hmeet
    (fun a ha => (sigA_iff.mp ha).1) htop
  exact ⟨g1, fun b hb => g3 b hb (sigA_iff.mp hb).2.1⟩

/-- 持ち上げた割り当ての下の関数表は、シグネチャの条件を満たす -/
theorem sigOk_upK (htop : ∀ f ∈ C, sigA S len f (topL (len f)) = true) (K : Nat → List Kind) :
    SigOk (Δ.withK C S (upK S len K)) := by
  intro g dfn hg
  rw [Defs.withK_get] at hg
  obtain ⟨d0, hd0, rfl⟩ := Option.map_eq_some_iff.mp hg
  by_cases hgC : g ∈ C
  · simp only [hgC, if_true, Def.raise]
    obtain ⟨s1, s2⟩ := sigMin_spec hC hgC (htop g hgC)
    obtain ⟨l0, -, r0⟩ := sigA_iff.mp s1
    have hu : (upK S len K g).length = len g := by rw [upK, upL_length, l0]
    obtain ⟨sp, sr⟩ := hC.shape g hgC
    have wp : ((S g).param.tsubst (Kind.idArgs (upK S len K g))).tvWf (upK S len K g) = true := by
      rw [Ty.tvWf_idArgs, hu]; exact sp
    have wr : ((S g).ret.tsubst (Kind.idArgs (upK S len K g))).tvWf (upK S len K g) = true := by
      rw [Ty.tvWf_idArgs, hu]; exact sr
    exact ⟨Ty.retOk_raise (upL_norm _ _) (upL_ge _ _) (l0 ▸ sr) r0, Ty.tvarsBelow_of_tvWf wp,
      Ty.tvarsBelow_of_tvWf wr, wp, wr⟩
  · simp only [hgC, if_false]; exact hC.out g d0 hd0 hgC

omit hC in
/-- 行 f が kind の列 a で型付くなら、a はシグネチャの条件を満たす -/
theorem sigA_of_defOk {Δ' : Defs} {f : Nat} {a : List Kind} (hl : a.length = len f) (hn : KNorm a)
    (h : DefOk Δ' ((S f).raise a)) : sigA S len f a = true :=
  sigA_iff.mpr ⟨hl, hn, h.2.1⟩

theorem fixHyp (htop : ∀ f ∈ C, sigA S len f (topL (len f)) = true) :
    FixHyp C len (accK Δ C S len) (sigMin S len) where
  hup := by
    intro K f a b hf ha hb hab
    obtain ⟨l, -, d⟩ := accK_iff.mp ha
    refine accK_iff.mpr ⟨hab.1 ▸ l, hb, ?_⟩
    have := DefOk.mono (sigOk_upK hC htop K) d (by simp [Def.raise, hab.1]) (fun j k k' h1 h2 => hab.le_get h1 h2) hb
    rwa [Def.raise_raise _ hab] at this
  hmeet := by
    intro K f a b hf ha hb
    obtain ⟨la, na, da⟩ := accK_iff.mp ha
    obtain ⟨lb, nb, db⟩ := accK_iff.mp hb
    have hl : a.length = b.length := la.trans lb.symm
    exact accK_iff.mpr ⟨by simp [meetL, la, lb], meetL_norm na nb, DefOk.meet (sigOk_upK hC htop K) hl na nb da db⟩
  hlen := fun K f a hf ha => (accK_iff.mp ha).1
  hanti := by
    intro K K' f a hf hle ha
    obtain ⟨l, n, d⟩ := accK_iff.mp ha
    exact accK_iff.mpr ⟨l, n, DefOk.anti (fun g _ => upL_mono (hle g ‹_›) _) d⟩
  hbase := by
    intro K f a hf ha
    obtain ⟨l, n, d⟩ := accK_iff.mp ha
    exact (sigMin_spec hC hf (htop f hf)).2 a (sigA_of_defOk l n d)
  hbaseLen := fun f hf => (sigA_iff.mp (sigMin_spec hC hf (htop f hf)).1).1

/-- 整合な割り当ては、持ち上げても変わらない -/
theorem upK_eq_of {K : Nat → List Kind} (htop : ∀ f ∈ C, sigA S len f (topL (len f)) = true)
    (h : ∀ f ∈ C, (K f).length = len f ∧ KNorm (K f) ∧ sigA S len f (K f) = true) : ∀ g ∈ C, upK S len K g = K g :=
  fun g hg => upL_eq (h g hg).2.1 ((sigMin_spec hC hg (htop g hg)).2 _ (h g hg).2.2)

theorem cons_iff (htop : ∀ f ∈ C, sigA S len f (topL (len f)) = true) (K : Nat → List Kind) :
    Cons C (accK Δ C S len) K ↔ Consistent Δ C S len K := by
  constructor
  · intro h
    have hs : ∀ f ∈ C, (K f).length = len f ∧ KNorm (K f) ∧ sigA S len f (K f) = true := by
      intro f hf
      obtain ⟨l, n, d⟩ := accK_iff.mp (h f hf).1
      exact ⟨l, n, sigA_of_defOk l n d⟩
    rw [Consistent, ← Defs.withK_congr Δ C S (upK_eq_of hC htop hs)]
    intro f hf
    exact accK_iff.mp (h f hf).1
  · intro h
    have hs : ∀ f ∈ C, (K f).length = len f ∧ KNorm (K f) ∧ sigA S len f (K f) = true :=
      fun f hf => ⟨(h f hf).1, (h f hf).2.1, sigA_of_defOk (h f hf).1 (h f hf).2.1 (h f hf).2.2⟩
    intro f hf
    refine ⟨accK_iff.mpr ⟨(h f hf).1, (h f hf).2.1, ?_⟩, (h f hf).2.1⟩
    rw [Defs.withK_congr Δ C S (upK_eq_of hC htop hs)]
    exact (h f hf).2.2

/-- 整合な割り当てがあれば、どの行もシグネチャの条件を旗を全部立てて満たす -/
theorem htop_of_consistent {K : Nat → List Kind} (h : Consistent Δ C S len K) :
    ∀ f ∈ C, sigA S len f (topL (len f)) = true := by
  intro f hf
  obtain ⟨l, n, d⟩ := h f hf
  exact sigA_up hC hf (sigA_of_defOk l n d) (topL_norm _) (topL_ge l)

/-- 推論の正しさ: 手順が割り当てを返すなら、それは整合な割り当てのうち最小。型付かないと答えるなら、整合な割り当ては無い -/
theorem inferK_correct :
    (∀ Ks, inferK Δ C S len = some Ks → Consistent Δ C S len Ks ∧ ∀ K, Consistent Δ C S len K → KLeC C Ks K) ∧
      (inferK Δ C S len = none → ∀ K, ¬ Consistent Δ C S len K) := by
  constructor
  · intro Ks h
    unfold inferK at h
    split at h
    · rename_i ht
      have htop : ∀ f ∈ C, sigA S len f (topL (len f)) = true := by simpa using ht
      obtain ⟨h1, h2⟩ := infer_sound (fixHyp hC htop) h
      exact ⟨(cons_iff hC htop Ks).mp h1, fun K hK => h2 K ((cons_iff hC htop K).mpr hK)⟩
    · cases h
  · intro h K hK
    have htop := htop_of_consistent hC hK
    unfold inferK at h
    rw [if_pos (by simpa using htop)] at h
    exact infer_complete (fixHyp hC htop) h K ((cons_iff hC htop K).mpr hK)

/-- 整合な割り当てがあることと、推論の手順が割り当てを返すことは同じ -/
theorem inferK_isSome_iff : (∃ K, Consistent Δ C S len K) ↔ (inferK Δ C S len).isSome = true := by
  constructor
  · rintro ⟨K, hK⟩
    cases h : inferK Δ C S len with
    | none => exact absurd hK ((inferK_correct hC).2 h K)
    | some _ => rfl
  · intro h
    obtain ⟨Ks, hs⟩ := Option.isSome_iff_exists.mp h
    exact ⟨Ks, ((inferK_correct hC).1 Ks hs).1⟩

omit hC in
/-- 最小の整合な割り当ては 1 つに決まる（成分の上で） -/
theorem consistent_min_unique {K K' : Nat → List Kind}
    (h : Consistent Δ C S len K ∧ ∀ K'', Consistent Δ C S len K'' → KLeC C K K'')
    (h' : Consistent Δ C S len K' ∧ ∀ K'', Consistent Δ C S len K'' → KLeC C K' K'') :
    ∀ f ∈ C, K f = K' f :=
  fun f hf => KLe.antisymm (h.2 K' h'.1 f hf) (h'.2 K h.1 f hf)

end

end Comp

end FS
