import FeatherweightSober.Mono

/-!
# kind の推論の手順の正しさ（型付けに依らない部分）

受け取れる kind の列の集合 A が、正規形の上で上に閉じていて添字ごとの弱い方（meet）で閉じているとき:

- 貪欲に旗を外す手順（`greedy`）は、1 回の走査で A の最小元に届く。旗を外す 1 歩は、その旗と、その旗を含意する旗を
  まとめて外す（`Kind.drop` — 正規形の含意: rf・kf ⇒ mf・cf・cov、cov ⇒ mf・cf）
- 相互再帰の成分の kind を同時に決める反復（`runK`）は、呼び先の kind について反単調な A の下で、最小の整合な割り当てに
  止まる（`infer_sound`）。型付かないと答えるなら、整合な割り当ては無い（`infer_complete`）
-/

namespace FS

/-- kind の旗の名前 -/
inductive Flag where
  | rf | mf | cf | cov | kf
  deriving DecidableEq, Repr

def Kind.has (k : Kind) : Flag → Bool
  | .rf => k.rf
  | .mf => k.mf
  | .cf => k.cf
  | .cov => k.cov
  | .kf => k.kf

/-- 旗 x と、x を含意する旗をまとめて外す（k 以下で x を持たない最大の正規形） -/
def Kind.drop (k : Kind) : Flag → Kind
  | .rf => { k with rf := false }
  | .kf => { k with kf := false }
  | .cov => { k with cov := false, rf := false, kf := false }
  | .mf => { k with mf := false, cov := false, rf := false, kf := false }
  | .cf => { k with cf := false, cov := false, rf := false, kf := false }

def Kind.meet (a b : Kind) : Kind := ⟨a.rf && b.rf, a.mf && b.mf, a.cf && b.cf, a.cov && b.cov, a.kf && b.kf⟩

def Kind.top : Kind := ⟨true, true, true, true, true⟩

/-- 外す順: rf・kf → cov → mf・cf -/
def Flag.order : List Flag := [.rf, .kf, .cov, .mf, .cf]

theorem Flag.mem_order (x : Flag) : x ∈ Flag.order := by cases x <;> simp [Flag.order]

theorem Kind.le_iff_has {a b : Kind} : a.le b = true ↔ ∀ x, a.has x = true → b.has x = true := by
  cases a with
  | mk rf mf cf cov kf =>
    cases b with
    | mk rf' mf' cf' cov' kf' =>
      constructor
      · intro h x
        simp only [Kind.le, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h
        obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := h
        cases x <;> simp only [Kind.has] <;> intro hx <;> simp_all
      · intro h
        have h1 := h .rf; have h2 := h .mf; have h3 := h .cf; have h4 := h .cov; have h5 := h .kf
        simp only [Kind.has] at h1 h2 h3 h4 h5
        cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;>
          cases rf' <;> cases mf' <;> cases cf' <;> cases cov' <;> cases kf' <;> simp_all [Kind.le]

theorem Kind.drop_has_self (k : Kind) (x : Flag) : (k.drop x).has x = false := by
  cases x <;> rfl

theorem Kind.drop_has (k : Kind) (x y : Flag) : (k.drop x).has y = true → k.has y = true := by
  cases x <;> cases y <;> simp [Kind.drop, Kind.has]

theorem Kind.drop_norm {k : Kind} (h : k.isNorm = true) (x : Flag) : (k.drop x).isNorm = true := by
  cases k with
  | mk rf mf cf cov kf =>
    cases x <;> cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;> simp_all [Kind.isNorm, Kind.drop]

/-- drop の最大性: k 以下で x を持たない正規形は k.drop x 以下 -/
theorem Kind.drop_max {μ k : Kind} (hn : μ.isNorm = true) (hle : ∀ y, μ.has y = true → k.has y = true)
    {x : Flag} (hx : μ.has x = false) : ∀ y, μ.has y = true → (k.drop x).has y = true := by
  cases μ with
  | mk rf mf cf cov kf =>
    have h1 := hle .rf; have h2 := hle .mf; have h3 := hle .cf; have h4 := hle .cov; have h5 := hle .kf
    intro y hy
    cases x <;> cases y <;> cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;>
      simp_all [Kind.isNorm, Kind.drop, Kind.has]

theorem Kind.meet_has (a b : Kind) (x : Flag) : (a.meet b).has x = (a.has x && b.has x) := by
  cases x <;> rfl

theorem Kind.meet_norm {a b : Kind} (ha : a.isNorm = true) (hb : b.isNorm = true) : (a.meet b).isNorm = true := by
  cases a with
  | mk rf mf cf cov kf =>
    cases b with
    | mk rf' mf' cf' cov' kf' =>
      cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;>
        cases rf' <;> cases mf' <;> cases cf' <;> cases cov' <;> cases kf' <;> simp_all [Kind.isNorm, Kind.meet]

theorem Kind.top_norm : Kind.top.isNorm = true := rfl

/-! ## kind の列 -/

/-- 列 ks の添字 j の kind が旗 x を持つ（範囲外は持たない） -/
def hasAt (ks : List Kind) (j : Nat) (x : Flag) : Bool := (ks[j]?.map (·.has x)).getD false

/-- 添字ごとの旗の包含（長さは同じ） -/
def KLe (a b : List Kind) : Prop := a.length = b.length ∧ ∀ j x, hasAt a j x = true → hasAt b j x = true

def KNorm (a : List Kind) : Prop := ∀ k ∈ a, k.isNorm = true

def meetL (a b : List Kind) : List Kind := List.zipWith Kind.meet a b

def topL (n : Nat) : List Kind := List.replicate n Kind.top

def dropAt (m : List Kind) (j : Nat) (x : Flag) : List Kind := m.modify j (·.drop x)

theorem KLe.refl (a : List Kind) : KLe a a := ⟨rfl, fun _ _ h => h⟩

theorem KLe.trans {a b c : List Kind} (h1 : KLe a b) (h2 : KLe b c) : KLe a c :=
  ⟨h1.1.trans h2.1, fun j x h => h2.2 j x (h1.2 j x h)⟩

/-- 長さが同じで添字ごとの旗が同じなら等しい -/
theorem KLe.antisymm {a b : List Kind} (h1 : KLe a b) (h2 : KLe b a) : a = b := by
  apply List.ext_getElem?
  intro j
  cases ha : a[j]? with
  | none =>
    have : b.length ≤ j := by rw [← h1.1]; exact List.getElem?_eq_none_iff.mp ha
    simp [List.getElem?_eq_none this]
  | some ka =>
    have hj : j < b.length := by rw [← h1.1]; exact (List.getElem?_eq_some_iff.mp ha).1
    rw [List.getElem?_eq_getElem hj]
    congr 1
    have hx : ∀ x, ka.has x = b[j].has x := by
      intro x
      have e1 := h1.2 j x; have e2 := h2.2 j x
      simp only [hasAt, ha, List.getElem?_eq_getElem hj, Option.map_some, Option.getD_some] at e1 e2
      cases h : ka.has x <;> cases h' : b[j].has x <;> simp_all
    cases ka; cases hb : b[j]
    have := hx .rf; have := hx .mf; have := hx .cf; have := hx .cov; have := hx .kf
    simp_all [Kind.has]

theorem hasAt_dropAt (m : List Kind) (j j' : Nat) (x y : Flag) :
    hasAt (dropAt m j x) j' y = if j = j' then ((m[j']?.map (fun k => (k.drop x).has y)).getD false) else hasAt m j' y := by
  simp only [hasAt, dropAt, List.getElem?_modify]
  cases m[j']? <;> by_cases h : j = j' <;> simp [h]

theorem dropAt_le (m : List Kind) (j : Nat) (x : Flag) : KLe (dropAt m j x) m := by
  refine ⟨by simp [dropAt], fun j' y h => ?_⟩
  rw [hasAt_dropAt] at h
  split at h
  · simp only [hasAt]; cases hm : m[j']? <;> simp_all; exact Kind.drop_has _ _ _ h
  · exact h

theorem dropAt_has_self (m : List Kind) (j : Nat) (x : Flag) : hasAt (dropAt m j x) j x = false := by
  rw [hasAt_dropAt]; simp; cases m[j]? <;> simp [Kind.drop_has_self]

theorem dropAt_norm {m : List Kind} (h : KNorm m) (j : Nat) (x : Flag) : KNorm (dropAt m j x) := by
  intro k hk
  obtain ⟨i, hi, rfl⟩ := List.getElem_of_mem hk
  have hi' : i < m.length := by simpa [dropAt] using hi
  have e : (dropAt m j x)[i]? = some (if j = i then m[i].drop x else m[i]) := by
    simp [dropAt, List.getElem?_modify, List.getElem?_eq_getElem hi']
  rw [List.getElem?_eq_getElem hi, Option.some.injEq] at e
  rw [e]
  have hm := h _ (List.getElem_mem hi')
  split <;> simp_all [Kind.drop_norm]

/-- dropAt の最大性: m 以下で、添字 j に旗 x を持たない正規形の列は dropAt m j x 以下 -/
theorem dropAt_max {c m : List Kind} (hn : KNorm c) (hle : KLe c m) {j : Nat} {x : Flag}
    (hx : hasAt c j x = false) : KLe c (dropAt m j x) := by
  refine ⟨by simp [dropAt, hle.1], fun j' y h => ?_⟩
  rw [hasAt_dropAt]
  split
  · subst j
    have hm := hle.2 j' y h
    simp only [hasAt] at h hm hx
    cases hc : c[j']? with
    | none => simp [hc] at h
    | some kc =>
      cases hm' : m[j']? with
      | none => simp [hm'] at hm
      | some km =>
        simp only [hc, hm', Option.map_some, Option.getD_some] at h hm hx ⊢
        have hkn : kc.isNorm = true := hn _ (List.mem_of_getElem? hc)
        have hl : ∀ z, kc.has z = true → km.has z = true := by
          intro z hz
          have := hle.2 j' z; simp only [hasAt, hc, hm', Option.map_some, Option.getD_some] at this; exact this hz
        exact Kind.drop_max hkn hl hx y h
  · exact hle.2 j' y h

theorem hasAt_meetL {a b : List Kind} (hl : a.length = b.length) (j : Nat) (x : Flag) :
    hasAt (meetL a b) j x = (hasAt a j x && hasAt b j x) := by
  simp only [hasAt, meetL, List.getElem?_zipWith]
  cases ha : a[j]? <;> cases hb : b[j]? <;> simp [Kind.meet_has]
  all_goals first
    | (have := (List.getElem?_eq_some_iff.mp hb).1; have := List.getElem?_eq_none_iff.mp ha; omega)
    | (have := (List.getElem?_eq_some_iff.mp ha).1; have := List.getElem?_eq_none_iff.mp hb; omega)

theorem meetL_le_left {a b : List Kind} (hl : a.length = b.length) : KLe (meetL a b) a :=
  ⟨by simp [meetL, hl], fun j x h => by rw [hasAt_meetL hl] at h; simp_all⟩

theorem meetL_le_right {a b : List Kind} (hl : a.length = b.length) : KLe (meetL a b) b :=
  ⟨by simp [meetL, hl], fun j x h => by rw [hasAt_meetL hl] at h; simp_all⟩

theorem meetL_norm {a b : List Kind} (ha : KNorm a) (hb : KNorm b) : KNorm (meetL a b) := by
  intro k hk
  simp only [meetL, List.mem_iff_getElem] at hk
  obtain ⟨i, hi, rfl⟩ := hk
  simp only [List.getElem_zipWith]
  have h1 : i < a.length := by simp at hi; omega
  have h2 : i < b.length := by simp at hi; omega
  exact Kind.meet_norm (ha _ (List.getElem_mem h1)) (hb _ (List.getElem_mem h2))

theorem topL_norm (n : Nat) : KNorm (topL n) := by
  intro k hk; simp [topL] at hk; rw [hk.2]; rfl

/-! ## 貪欲に外す手順 -/

/-- 外す 1 歩の列: 添字ごとに Flag.order の順 -/
def steps (n : Nat) : List (Nat × Flag) := (List.range n).flatMap (fun j => Flag.order.map (fun x => (j, x)))

/-- 列 st の順に、外して A に入れば外したままにする -/
def greedy (A : List Kind → Bool) : List Kind → List (Nat × Flag) → List Kind
  | m, [] => m
  | m, (j, x) :: st => greedy A (if A (dropAt m j x) then dropAt m j x else m) st

section Greedy

variable {A : List Kind → Bool}

theorem greedy_spec
    (hup : ∀ a b, A a = true → KNorm b → KLe a b → A b = true)
    (hmeet : ∀ a b, A a = true → A b = true → A (meetL a b) = true)
    (hlen : ∀ a b, A a = true → A b = true → a.length = b.length) :
    ∀ (st : List (Nat × Flag)) (m : List Kind), A m = true → KNorm m →
      A (greedy A m st) = true ∧ KNorm (greedy A m st) ∧ KLe (greedy A m st) m ∧
      ∀ p ∈ st, ∀ b, A b = true → KNorm b → hasAt (greedy A m st) p.1 p.2 = true → hasAt b p.1 p.2 = true := by
  intro st
  induction st with
  | nil => intro m hA hn; exact ⟨hA, hn, KLe.refl _, by simp⟩
  | cons p st ih =>
    obtain ⟨j, x⟩ := p
    intro m hA hn
    by_cases hd : A (dropAt m j x) = true
    · obtain ⟨g1, g2, g3, g4⟩ := ih (dropAt m j x) hd (dropAt_norm hn j x)
      simp only [greedy, hd, if_true]
      refine ⟨g1, g2, g3.trans (dropAt_le m j x), ?_⟩
      intro q hq b hb hbn hg
      rcases List.mem_cons.mp hq with rfl | hq
      · have := g3.2 j x hg; rw [dropAt_has_self] at this; cases this
      · exact g4 q hq b hb hbn hg
    · have hd' : A (dropAt m j x) = false := by simpa using hd
      obtain ⟨g1, g2, g3, g4⟩ := ih m hA hn
      simp only [greedy, hd', Bool.false_eq_true, if_false]
      refine ⟨g1, g2, g3, ?_⟩
      intro q hq b hb hbn hg
      rcases List.mem_cons.mp hq with rfl | hq
      · -- 外せなかった旗: b がこの旗を持たなければ、meet が dropAt 以下で A に入り、矛盾
        cases hbx : hasAt b j x
        · exfalso
          have hl := hlen m b hA hb
          have hc := hmeet m b hA hb
          have hcn := meetL_norm hn hbn
          have hcx : hasAt (meetL m b) j x = false := by rw [hasAt_meetL hl]; simp [hbx]
          have := hup _ _ hc (dropAt_norm hn j x) (dropAt_max hcn (meetL_le_left hl) hcx)
          rw [hd'] at this; cases this
        · rfl
      · exact g4 q hq b hb hbn hg

/-- 貪欲の結果は A の最小元: A に入り、正規形で、A のどの正規形の元以下 -/
theorem greedy_min (n : Nat)
    (hup : ∀ a b, A a = true → KNorm b → KLe a b → A b = true)
    (hmeet : ∀ a b, A a = true → A b = true → A (meetL a b) = true)
    (hlen : ∀ a, A a = true → a.length = n)
    (htop : A (topL n) = true) :
    A (greedy A (topL n) (steps n)) = true ∧ KNorm (greedy A (topL n) (steps n)) ∧
      ∀ b, A b = true → KNorm b → KLe (greedy A (topL n) (steps n)) b := by
  obtain ⟨g1, g2, -, g4⟩ := greedy_spec hup hmeet (fun a b ha hb => (hlen a ha).trans (hlen b hb).symm)
    (steps n) (topL n) htop (topL_norm n)
  refine ⟨g1, g2, fun b hb hbn => ⟨(hlen _ g1).trans (hlen b hb).symm, fun j x hg => ?_⟩⟩
  have hj : j < n := by
    have := hlen _ g1
    simp only [hasAt] at hg
    cases h : (greedy A (topL n) (steps n))[j]? with
    | none => simp [h] at hg
    | some _ => have := (List.getElem?_eq_some_iff.mp h).1; omega
  exact g4 (j, x) (by simp [steps, List.mem_flatMap, Flag.mem_order, hj]) b hb hbn hg

end Greedy


/-! ## 成分の最小の不動点

相互再帰の成分 C の Def の kind を同時に決める。A K f a = 「呼び先の行を割り当て K にした関数表で、f の本体が kind の列 a で
型付く」（型付けに依らない形で抽象する）。A K f は上に閉じて meet で閉じ、呼び先の kind について反単調（呼び先の旗が多いほど
受け取れる集合は狭い）。出発点 K0 はシグネチャの条件の最小（受け取れる列はどれも K0 以上）。 -/

section Fix

variable (C : List Nat) (len : Nat → Nat) (A : (Nat → List Kind) → Nat → List Kind → Bool) (K0 : Nat → List Kind)

def KLeC (K K' : Nat → List Kind) : Prop := ∀ f ∈ C, KLe (K f) (K' f)

/-- 整合な割り当て: 成分のどの Def も、自分の行の kind で型付く -/
def Cons (K : Nat → List Kind) : Prop := ∀ f ∈ C, A K f (K f) = true ∧ KNorm (K f)

structure FixHyp : Prop where
  hup : ∀ K f a b, f ∈ C → A K f a = true → KNorm b → KLe a b → A K f b = true
  hmeet : ∀ K f a b, f ∈ C → A K f a = true → A K f b = true → A K f (meetL a b) = true
  hlen : ∀ K f a, f ∈ C → A K f a = true → a.length = len f
  hanti : ∀ K K' f a, f ∈ C → KLeC C K K' → A K' f a = true → A K f a = true
  hbase : ∀ K f a, f ∈ C → A K f a = true → KLe (K0 f) a
  hbaseLen : ∀ f ∈ C, (K0 f).length = len f

/-- 1 回分: 成分の各 Def の最小の kind を、呼び先の行を K にして貪欲に求める -/
def stepK (K : Nat → List Kind) (f : Nat) : List Kind :=
  if f ∈ C then greedy (A K f) (topL (len f)) (steps (len f)) else K f

/-- 成分のどの Def も、呼び先の行 K の下で何かの kind で型付く -/
def okAll (K : Nat → List Kind) : Bool := C.all (fun f => A K f (topL (len f)))

/-- 推論の手順（燃料つき）: 型付かない Def があれば none、変わらなくなれば その割り当て -/
def runK : Nat → (Nat → List Kind) → Option (Nat → List Kind)
  | 0, _ => none
  | n + 1, K =>
    if okAll C len A K then
      if C.all (fun f => stepK C len A K f == K f) then some K else runK n (stepK C len A K)
    else none

def iterK : Nat → Nat → List Kind
  | 0 => K0
  | n + 1 => stepK C len A (iterK n)

/-- 成分の旗の位置（Def・型パラメータ・旗） -/
def cells : List (Nat × Nat × Flag) :=
  C.flatMap (fun f => (List.range (len f)).flatMap (fun j => Flag.order.map (fun x => (f, j, x))))

/-- 立っている旗の数 -/
def cnt (K : Nat → List Kind) : Nat := (cells C len).countP (fun p => hasAt (K p.1) p.2.1 p.2.2)

/-- 燃料: 成分の旗の総数 + 1（反復は旗を増やす向きにだけ動く） -/
def fuel : Nat := (cells C len).length + 1

variable {C len A K0}

theorem KLeC.refl (K : Nat → List Kind) : KLeC C K K := fun _ _ => KLe.refl _

theorem KLeC.trans {K1 K2 K3 : Nat → List Kind} (h1 : KLeC C K1 K2) (h2 : KLeC C K2 K3) : KLeC C K1 K3 :=
  fun f hf => (h1 f hf).trans (h2 f hf)

theorem okAll_iff {K : Nat → List Kind} : okAll C len A K = true ↔ ∀ f ∈ C, A K f (topL (len f)) = true := by
  simp [okAll]

theorem topL_ge {n : Nat} {a : List Kind} (h : a.length = n) : KLe a (topL n) := by
  refine ⟨by simp [topL, h], fun j x hj => ?_⟩
  simp only [hasAt] at hj ⊢
  cases ha : a[j]? with
  | none => simp [ha] at hj
  | some k =>
    have : j < n := h ▸ (List.getElem?_eq_some_iff.mp ha).1
    simp [topL, List.getElem?_replicate, this, Kind.top]; cases x <;> rfl

theorem iterK_succ (n : Nat) : iterK C len A K0 (n + 1) = stepK C len A (iterK C len A K0 n) := rfl

theorem countP_lt {α : Type} {p q : α → Bool} : ∀ {l : List α}, (∀ a ∈ l, p a = true → q a = true) →
    (∃ a ∈ l, q a = true ∧ p a = false) → l.countP p < l.countP q := by
  intro l
  induction l with
  | nil => intro _ h; simp at h
  | cons a l ih =>
    intro hpq hex
    have hpq' : ∀ b ∈ l, p b = true → q b = true := fun b hb => hpq b (List.mem_cons_of_mem _ hb)
    have hle : l.countP p ≤ l.countP q := List.countP_mono_left hpq'
    obtain ⟨b, hb, hqb, hpb⟩ := hex
    simp only [List.countP_cons]
    rcases List.mem_cons.mp hb with rfl | h
    · simp [hqb, hpb]; omega
    · have := ih hpq' ⟨b, h, hqb, hpb⟩
      cases hpa : p a <;> cases hqa : q a <;> simp <;> (try have := hpq a (by simp) hpa) <;> simp_all <;> omega

theorem hasAt_lt {ks : List Kind} {j : Nat} {x : Flag} (h : hasAt ks j x = true) : j < ks.length := by
  simp only [hasAt] at h
  cases hk : ks[j]? with
  | none => simp [hk] at h
  | some _ => exact (List.getElem?_eq_some_iff.mp hk).1

theorem cnt_lt {K K' : Nat → List Kind} (hlen : ∀ f ∈ C, (K' f).length = len f) (hle : KLeC C K K')
    (hne : ¬ KLeC C K' K) : cnt C len K < cnt C len K' := by
  apply countP_lt
  · intro q hq h
    simp only [cells, List.mem_flatMap, List.mem_range, List.mem_map] at hq
    obtain ⟨f, hf, j, -, x, -, rfl⟩ := hq
    exact (hle f hf).2 j x h
  · have hex : ∃ f ∈ C, ¬ KLe (K' f) (K f) := by
      refine Classical.byContradiction fun hc => hne fun f hf => Classical.byContradiction fun h' => hc ⟨f, hf, h'⟩
    obtain ⟨f, hf, hn⟩ := hex
    have hl : (K' f).length = (K f).length := (hle f hf).1.symm
    have hex2 : ∃ j x, hasAt (K' f) j x = true ∧ hasAt (K f) j x = false := by
      refine Classical.byContradiction fun hc => hn ⟨hl, fun j x h => ?_⟩
      cases h2 : hasAt (K f) j x
      · exact absurd ⟨j, x, h, h2⟩ hc
      · rfl
    obtain ⟨j, x, h1, h2⟩ := hex2
    refine ⟨(f, j, x), ?_, h1, by simpa using h2⟩
    have := hasAt_lt h1
    simp only [cells, List.mem_flatMap, List.mem_range, List.mem_map]
    exact ⟨f, hf, j, by rw [← hlen f hf]; exact this, x, Flag.mem_order x, rfl⟩

theorem cnt_le_length (K : Nat → List Kind) : cnt C len K ≤ (cells C len).length := List.countP_le_length


theorem runK_spec_some : ∀ (m k : Nat) (Ks : Nat → List Kind), runK C len A m (iterK C len A K0 k) = some Ks →
    ∃ n, Ks = iterK C len A K0 n ∧ okAll C len A (iterK C len A K0 n) = true ∧
      ∀ f ∈ C, stepK C len A (iterK C len A K0 n) f = iterK C len A K0 n f := by
  intro m
  induction m with
  | zero => intro k Ks h; simp [runK] at h
  | succ m ih =>
    intro k Ks h
    simp only [runK] at h
    by_cases hok : okAll C len A (iterK C len A K0 k) = true
    · rw [if_pos hok] at h
      by_cases he : (C.all (fun f => stepK C len A (iterK C len A K0 k) f == iterK C len A K0 k f)) = true
      · rw [if_pos he] at h
        cases h
        refine ⟨k, rfl, hok, fun f hf => ?_⟩
        have := List.all_eq_true.mp he f hf
        simpa using this
      · rw [if_neg he] at h
        exact ih (k + 1) Ks h
    · rw [if_neg hok] at h; cases h

theorem runK_spec_none : ∀ (m k : Nat), runK C len A m (iterK C len A K0 k) = none →
    (∃ n, okAll C len A (iterK C len A K0 n) = false) ∨
      ∀ i < m, ¬ ∀ f ∈ C, stepK C len A (iterK C len A K0 (k + i)) f = iterK C len A K0 (k + i) f := by
  intro m
  induction m with
  | zero => intro k _; exact .inr (fun i hi => absurd hi (Nat.not_lt_zero _))
  | succ m ih =>
    intro k h
    simp only [runK] at h
    by_cases hok : okAll C len A (iterK C len A K0 k) = true
    · rw [if_pos hok] at h
      by_cases he : (C.all (fun f => stepK C len A (iterK C len A K0 k) f == iterK C len A K0 k f)) = true
      · rw [if_pos he] at h; cases h
      · rw [if_neg he] at h
        rcases ih (k + 1) h with h1 | h1
        · exact .inl h1
        · refine .inr fun i hi => ?_
          cases i with
          | zero =>
            intro hall; apply he; rw [List.all_eq_true]; intro f hf; simpa using hall f hf
          | succ i =>
            have := h1 i (by omega)
            rwa [show k + 1 + i = k + (i + 1) by omega] at this
    · exact .inl ⟨k, by simpa using hok⟩

section
variable (H : FixHyp C len A K0)
include H

/-- 1 回分の値は、その割り当ての下の最小元 -/
theorem stepK_min {K : Nat → List Kind} {f : Nat} (hf : f ∈ C) (hok : A K f (topL (len f)) = true) :
    A K f (stepK C len A K f) = true ∧ KNorm (stepK C len A K f) ∧
      ∀ b, A K f b = true → KNorm b → KLe (stepK C len A K f) b := by
  simp only [stepK, hf, if_true]
  exact greedy_min (len f) (fun a b ha hb hab => H.hup K f a b hf ha hb hab) (fun a b ha hb => H.hmeet K f a b hf ha hb)
    (fun a ha => H.hlen K f a hf ha) hok

/-- 反復はどの整合な割り当て以下に留まり、型付かない Def は出ない -/
theorem iterK_below {K : Nat → List Kind} (hK : Cons C A K) :
    ∀ n, KLeC C (iterK C len A K0 n) K ∧ okAll C len A (iterK C len A K0 n) = true := by
  have ok_of : ∀ K', KLeC C K' K → okAll C len A K' = true := by
    intro K' hle
    rw [okAll_iff]; intro f hf
    have h1 := H.hanti K' K f (K f) hf hle (hK f hf).1
    exact H.hup K' f _ _ hf h1 (topL_norm _) (topL_ge (H.hlen K' f _ hf h1))
  intro n
  induction n with
  | zero =>
    have : KLeC C K0 K := fun f hf => H.hbase K f (K f) hf (hK f hf).1
    exact ⟨this, ok_of _ this⟩
  | succ n ih =>
    have hle : KLeC C (iterK C len A K0 (n + 1)) K := by
      intro f hf
      have hstep : iterK C len A K0 (n + 1) = stepK C len A (iterK C len A K0 n) := rfl
      rw [hstep]
      exact (stepK_min H hf ((okAll_iff.mp ih.2) f hf)).2.2 (K f) (H.hanti _ K f _ hf ih.1 (hK f hf).1) (hK f hf).2
    exact ⟨hle, ok_of _ hle⟩

/-- 反復は増える（型付かない Def が出ない間） -/
theorem iterK_mono : ∀ n, (∀ m ≤ n + 1, okAll C len A (iterK C len A K0 m) = true) →
    KLeC C (iterK C len A K0 n) (iterK C len A K0 (n + 1)) := by
  intro n
  induction n with
  | zero =>
    intro h f hf
    rw [iterK_succ]
    exact H.hbase _ f _ hf (stepK_min H hf ((okAll_iff.mp (h 0 (by omega))) f hf)).1
  | succ n ih =>
    intro h f hf
    have ih' := ih (fun m hm => h m (by omega))
    have s2 := stepK_min H hf ((okAll_iff.mp (h (n + 1) (by omega))) f hf)
    have s1 := stepK_min H hf ((okAll_iff.mp (h n (by omega))) f hf)
    rw [iterK_succ (n + 1)]
    rw [iterK_succ n] at ih' ⊢
    exact s1.2.2 _ (H.hanti _ _ f _ hf ih' s2.1) s2.2.1


theorem iterK_len {n : Nat} (hok : ∀ m < n, okAll C len A (iterK C len A K0 m) = true) :
    ∀ f ∈ C, (iterK C len A K0 n f).length = len f := by
  intro f hf
  cases n with
  | zero => exact H.hbaseLen f hf
  | succ n =>
    rw [iterK_succ]
    exact H.hlen _ f _ hf (stepK_min H hf ((okAll_iff.mp (hok n (by omega))) f hf)).1

/-- 変わらない回が来るまで、立っている旗の数は回ごとに増える -/
theorem iterK_cnt (hok : ∀ m, okAll C len A (iterK C len A K0 m) = true) :
    ∀ n, (∀ m < n, ¬ KLeC C (iterK C len A K0 (m + 1)) (iterK C len A K0 m)) → n ≤ cnt C len (iterK C len A K0 n) := by
  intro n
  induction n with
  | zero => intro _; exact Nat.zero_le _
  | succ n ih =>
    intro h
    have h1 := ih (fun m hm => h m (by omega))
    have h2 := cnt_lt (iterK_len H (fun m _ => hok m)) (iterK_mono H n (fun m _ => hok m)) (h n (by omega))
    omega

/-- 推論の手順の健全性と最小性: 結果は整合な割り当てで、どの整合な割り当て以下 -/
theorem infer_sound {Ks : Nat → List Kind} (h : runK C len A (fuel C len) K0 = some Ks) :
    Cons C A Ks ∧ ∀ K, Cons C A K → KLeC C Ks K := by
  obtain ⟨n, rfl, hok, hfix⟩ := runK_spec_some (K0 := K0) (fuel C len) 0 Ks h
  refine ⟨fun f hf => ?_, fun K hK => (iterK_below H hK n).1⟩
  have st := stepK_min H hf ((okAll_iff.mp hok) f hf)
  rw [hfix f hf] at st
  exact ⟨st.1, st.2.1⟩

/-- 推論の手順の完全性: 手順が型付かないと答えるなら、整合な割り当ては無い -/
theorem infer_complete (h : runK C len A (fuel C len) K0 = none) : ∀ K, ¬ Cons C A K := by
  intro K hK
  have hb := iterK_below H hK
  rcases runK_spec_none (K0 := K0) (fuel C len) 0 h with ⟨n, hn⟩ | hall
  · rw [(hb n).2] at hn; cases hn
  · have hne : ∀ m < fuel C len, ¬ KLeC C (iterK C len A K0 (m + 1)) (iterK C len A K0 m) := by
      intro m hm hle'
      apply hall m hm
      intro f hf
      rw [Nat.zero_add, ← iterK_succ]
      exact KLe.antisymm (hle' f hf) (iterK_mono H m (fun i _ => (hb i).2) f hf)
    have h1 := iterK_cnt H (fun m => (hb m).2) (fuel C len) hne
    have h2 := cnt_le_length (C := C) (len := len) (iterK C len A K0 (fuel C len))
    simp only [fuel] at h1 h2
    omega

end

end Fix

end FS
