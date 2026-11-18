/-!
# R3の確認（branch r3）: 型パラメータのkindの推論

本体のLeanとは別の小さな体系。型パラメータのkind = 型変数が持ちうる性質（mutを持たない・端点を持たない）を、本体の型付けが
使った分だけ要求する。確かめること:

1. 単調性（ty_mono）: 型変数についてより多くの性質を仮定すれば、型付く式はそのまま型付く
2. 代入との一致（ty_tsubst）: 具体の型 σ で展開した本体の型付けは、kind = σ の性質で型付けた本体と同じ結果になる
3. 推論（ty_iff_need）: 本体が型付くための kind の条件は「要求の集合 A・B の型変数がその性質を持つ」の形で、最小の kind が計算できる
4. 一致（expand_iff_kind）: 「σ で展開して型付く」⇔「σ が推論した kind を満たす」

型の規則は、Soberのコアで型変数の性質を見る規則の代表だけを持つ: imm の slice を作る（要素は mutFree）・チャネルで送る（mutFree かつ
端点なし）・Def の引数に渡す（端点なし = argFree）・組と射影。型の等しさを見る規則は、表層の検査（型変数を抽象型のまま一度だけ検査する）が
受け持つので、ここでは構造の一致として持つ（式は型注釈を持たず、代入で変わらない）
-/

namespace R3K

inductive Ty : Type where
  | int
  | tvar (i : Nat)
  | slice (m : Bool) (t : Ty)
  | chan (t : Ty)
  | prod (a b : Ty)
  deriving DecidableEq

/-- 型変数の性質（kind）: mf i = 型変数 i は mut を持たない・ef i = 端点を持たない -/
structure Kd where
  mf : Nat → Bool
  ef : Nat → Bool

def Kd.le (k k' : Kd) : Prop := (∀ i, k.mf i = true → k'.mf i = true) ∧ (∀ i, k.ef i = true → k'.ef i = true)

def Ty.mutFree (k : Kd) : Ty → Bool
  | .int => true
  | .tvar i => k.mf i
  | .slice m t => !m && t.mutFree k
  | .chan _ => true
  | .prod a b => a.mutFree k && b.mutFree k

def Ty.epFree (k : Kd) : Ty → Bool
  | .int => true
  | .tvar i => k.ef i
  | .slice _ t => t.epFree k
  | .chan _ => false
  | .prod a b => a.epFree k && b.epFree k

def look (σ : List Ty) (i : Nat) : Ty := (σ[i]?).getD (.tvar i)

def Ty.tsubst (σ : List Ty) : Ty → Ty
  | .int => .int
  | .tvar i => look σ i
  | .slice m t => .slice m (t.tsubst σ)
  | .chan t => .chan (t.tsubst σ)
  | .prod a b => .prod (a.tsubst σ) (b.tsubst σ)

inductive Expr : Type where
  | var (i : Nat)
  | mks (e : Expr)
  | pair (a b : Expr)
  | fst (e : Expr)
  | send (e : Expr)
  | arg (e : Expr)

def ty (k : Kd) (Γ : List Ty) : Expr → Option Ty
  | .var i => Γ[i]?
  | .mks e => (ty k Γ e).bind fun t => if t.mutFree k then some (.slice false t) else none
  | .pair a b => (ty k Γ a).bind fun ta => (ty k Γ b).map fun tb => .prod ta tb
  | .fst e => (ty k Γ e).bind fun t => match t with | .prod a _ => some a | _ => none
  | .send e => (ty k Γ e).bind fun t => if t.mutFree k && t.epFree k then some .int else none
  | .arg e => (ty k Γ e).bind fun t => if t.epFree k then some t else none

/-! ## 1. 単調性 -/

theorem Ty.mutFree_mono {k k' : Kd} (h : k.le k') : ∀ t : Ty, t.mutFree k = true → t.mutFree k' = true
  | .int, _ => rfl
  | .tvar i, hm => h.1 i hm
  | .slice m t, hm => by simp [Ty.mutFree] at hm ⊢; exact ⟨hm.1, Ty.mutFree_mono h t hm.2⟩
  | .chan _, _ => rfl
  | .prod a b, hm => by
    simp [Ty.mutFree] at hm ⊢; exact ⟨Ty.mutFree_mono h a hm.1, Ty.mutFree_mono h b hm.2⟩

theorem Ty.epFree_mono {k k' : Kd} (h : k.le k') : ∀ t : Ty, t.epFree k = true → t.epFree k' = true
  | .int, _ => rfl
  | .tvar i, hm => h.2 i hm
  | .slice _ t, hm => by simp [Ty.epFree] at hm ⊢; exact Ty.epFree_mono h t hm
  | .chan _, hm => hm
  | .prod a b, hm => by
    simp [Ty.epFree] at hm ⊢; exact ⟨Ty.epFree_mono h a hm.1, Ty.epFree_mono h b hm.2⟩

/-- 型変数について多くを仮定するほど、型付く式は増えるだけ（結果の型は変わらない） -/
theorem ty_mono {k k' : Kd} (h : k.le k') (Γ : List Ty) : ∀ (e : Expr) (t : Ty), ty k Γ e = some t → ty k' Γ e = some t
  | .var _, _, he => he
  | .mks e, t, he => by
    simp only [ty, Option.bind_eq_some_iff] at he ⊢
    obtain ⟨u, hu, hc⟩ := he
    refine ⟨u, ty_mono h Γ e u hu, ?_⟩
    by_cases hm : u.mutFree k = true
    · simp [hm] at hc; simp [Ty.mutFree_mono h u hm, hc]
    · simp [hm] at hc
  | .pair a b, t, he => by
    simp only [ty, Option.bind_eq_some_iff, Option.map_eq_some_iff] at he ⊢
    obtain ⟨ta, ha, tb, hb, rfl⟩ := he
    exact ⟨ta, ty_mono h Γ a ta ha, tb, ty_mono h Γ b tb hb, rfl⟩
  | .fst e, t, he => by
    simp only [ty, Option.bind_eq_some_iff] at he ⊢
    obtain ⟨u, hu, hc⟩ := he
    exact ⟨u, ty_mono h Γ e u hu, hc⟩
  | .send e, t, he => by
    simp only [ty, Option.bind_eq_some_iff] at he ⊢
    obtain ⟨u, hu, hc⟩ := he
    refine ⟨u, ty_mono h Γ e u hu, ?_⟩
    by_cases hm : (u.mutFree k && u.epFree k) = true
    · simp at hm; simp [hm] at hc
      simp [Ty.mutFree_mono h u hm.1, Ty.epFree_mono h u hm.2, hc]
    · simp only [hm] at hc; simp at hc
  | .arg e, t, he => by
    simp only [ty, Option.bind_eq_some_iff] at he ⊢
    obtain ⟨u, hu, hc⟩ := he
    refine ⟨u, ty_mono h Γ e u hu, ?_⟩
    by_cases hm : u.epFree k = true
    · simp [hm] at hc; subst hc; simp [Ty.epFree_mono h _ hm]
    · simp [hm] at hc

/-! ## 2. 代入との一致 -/

/-- 型引数 σ の性質を、型変数の kind として読んだもの -/
def kindOf (k : Kd) (σ : List Ty) : Kd := ⟨fun i => (look σ i).mutFree k, fun i => (look σ i).epFree k⟩

theorem Ty.mutFree_tsubst (k : Kd) (σ : List Ty) : ∀ t : Ty, (t.tsubst σ).mutFree k = t.mutFree (kindOf k σ)
  | .int => rfl
  | .tvar i => rfl
  | .slice m t => by simp [Ty.tsubst, Ty.mutFree, Ty.mutFree_tsubst k σ t]
  | .chan _ => rfl
  | .prod a b => by simp [Ty.tsubst, Ty.mutFree, Ty.mutFree_tsubst k σ a, Ty.mutFree_tsubst k σ b]

theorem Ty.epFree_tsubst (k : Kd) (σ : List Ty) : ∀ t : Ty, (t.tsubst σ).epFree k = t.epFree (kindOf k σ)
  | .int => rfl
  | .tvar i => rfl
  | .slice _ t => by simp [Ty.tsubst, Ty.epFree, Ty.epFree_tsubst k σ t]
  | .chan _ => rfl
  | .prod a b => by simp [Ty.tsubst, Ty.epFree, Ty.epFree_tsubst k σ a, Ty.epFree_tsubst k σ b]

/-- 展開して型付けること: 構造（型の形・射影）は表層の検査と同じく本体の型で見る（表層の検査は型変数を抽象型のまま一度だけ検査する）。
型変数の性質を見る前提（mutFree・epFree）だけを、代入した具体の型で判定する。コアが展開した後の型で検査する部分に当たる -/
def tyE (k : Kd) (σ : List Ty) (Γ : List Ty) : Expr → Option Ty
  | .var i => Γ[i]?
  | .mks e => (tyE k σ Γ e).bind fun t => if (t.tsubst σ).mutFree k then some (.slice false t) else none
  | .pair a b => (tyE k σ Γ a).bind fun ta => (tyE k σ Γ b).map fun tb => .prod ta tb
  | .fst e => (tyE k σ Γ e).bind fun t => match t with | .prod a _ => some a | _ => none
  | .send e => (tyE k σ Γ e).bind fun t => if (t.tsubst σ).mutFree k && (t.tsubst σ).epFree k then some .int else none
  | .arg e => (tyE k σ Γ e).bind fun t => if (t.tsubst σ).epFree k then some t else none

/-- 展開して型付けることは、kind = σ の性質で本体を一度だけ型付けることと同じ -/
theorem tyE_eq (k : Kd) (σ Γ : List Ty) : ∀ e : Expr, tyE k σ Γ e = ty (kindOf k σ) Γ e
  | .var _ => rfl
  | .mks e => by simp only [tyE, ty, tyE_eq k σ Γ e, Ty.mutFree_tsubst]
  | .pair a b => by simp only [tyE, ty, tyE_eq k σ Γ a, tyE_eq k σ Γ b]
  | .fst e => by simp only [tyE, ty, tyE_eq k σ Γ e]
  | .send e => by simp only [tyE, ty, tyE_eq k σ Γ e, Ty.mutFree_tsubst, Ty.epFree_tsubst]
  | .arg e => by simp only [tyE, ty, tyE_eq k σ Γ e, Ty.epFree_tsubst]

/-! ## 3. 推論: 本体が要求する性質の集合（最小の kind） -/

/-- mutFree が成り立つための型変数の集合（定数の部分が偽なら none） -/
def Ty.mfAtoms : Ty → Option (List Nat)
  | .int => some []
  | .tvar i => some [i]
  | .slice m t => if m then none else t.mfAtoms
  | .chan _ => some []
  | .prod a b => (a.mfAtoms).bind fun A => (b.mfAtoms).map (A ++ ·)

def Ty.efAtoms : Ty → Option (List Nat)
  | .int => some []
  | .tvar i => some [i]
  | .slice _ t => t.efAtoms
  | .chan _ => none
  | .prod a b => (a.efAtoms).bind fun A => (b.efAtoms).map (A ++ ·)

theorem Ty.mutFree_iff (k : Kd) : ∀ t : Ty,
    t.mutFree k = true ↔ ∃ A, t.mfAtoms = some A ∧ ∀ i ∈ A, k.mf i = true
  | .int => by simp [Ty.mutFree, Ty.mfAtoms]
  | .tvar i => by simp [Ty.mutFree, Ty.mfAtoms]
  | .slice m t => by
    cases m <;> simp [Ty.mutFree, Ty.mfAtoms, Ty.mutFree_iff k t]
  | .chan _ => by simp [Ty.mutFree, Ty.mfAtoms]
  | .prod a b => by
    simp only [Ty.mutFree, Ty.mfAtoms, Bool.and_eq_true, Ty.mutFree_iff k a, Ty.mutFree_iff k b]
    constructor
    · rintro ⟨⟨A, hA, hA'⟩, ⟨B, hB, hB'⟩⟩
      refine ⟨A ++ B, by simp [hA, hB], ?_⟩
      intro i hi; rcases List.mem_append.1 hi with h | h
      · exact hA' i h
      · exact hB' i h
    · rintro ⟨C, hC, hC'⟩
      cases hA : a.mfAtoms <;> cases hB : b.mfAtoms <;> simp [hA, hB] at hC
      subst hC
      exact ⟨⟨_, rfl, fun i h => hC' i (List.mem_append_left _ h)⟩, ⟨_, rfl, fun i h => hC' i (List.mem_append_right _ h)⟩⟩

theorem Ty.epFree_iff (k : Kd) : ∀ t : Ty,
    t.epFree k = true ↔ ∃ A, t.efAtoms = some A ∧ ∀ i ∈ A, k.ef i = true
  | .int => by simp [Ty.epFree, Ty.efAtoms]
  | .tvar i => by simp [Ty.epFree, Ty.efAtoms]
  | .slice _ t => by simp [Ty.epFree, Ty.efAtoms, Ty.epFree_iff k t]
  | .chan _ => by simp [Ty.epFree, Ty.efAtoms]
  | .prod a b => by
    simp only [Ty.epFree, Ty.efAtoms, Bool.and_eq_true, Ty.epFree_iff k a, Ty.epFree_iff k b]
    constructor
    · rintro ⟨⟨A, hA, hA'⟩, ⟨B, hB, hB'⟩⟩
      refine ⟨A ++ B, by simp [hA, hB], ?_⟩
      intro i hi; rcases List.mem_append.1 hi with h | h
      · exact hA' i h
      · exact hB' i h
    · rintro ⟨C, hC, hC'⟩
      cases hA : a.efAtoms <;> cases hB : b.efAtoms <;> simp [hA, hB] at hC
      subst hC
      exact ⟨⟨_, rfl, fun i h => hC' i (List.mem_append_left _ h)⟩, ⟨_, rfl, fun i h => hC' i (List.mem_append_right _ h)⟩⟩

/-- 要求の集合: 結果の型と、mut を持たないことを要求する型変数 A・端点を持たないことを要求する型変数 B（kind に依らず計算できる） -/
def need (Γ : List Ty) : Expr → Option (Ty × List Nat × List Nat)
  | .var i => Γ[i]?.map fun t => (t, [], [])
  | .mks e => (need Γ e).bind fun (t, A, B) => t.mfAtoms.map fun A' => (.slice false t, A ++ A', B)
  | .pair a b => (need Γ a).bind fun (ta, A, B) => (need Γ b).map fun (tb, A', B') => (.prod ta tb, A ++ A', B ++ B')
  | .fst e => (need Γ e).bind fun (t, A, B) => match t with | .prod x _ => some (x, A, B) | _ => none
  | .send e => (need Γ e).bind fun (t, A, B) =>
      t.mfAtoms.bind fun A' => t.efAtoms.map fun B' => (.int, A ++ A', B ++ B')
  | .arg e => (need Γ e).bind fun (t, A, B) => t.efAtoms.map fun B' => (t, A, B ++ B')

def Kd.sat (k : Kd) (A B : List Nat) : Prop := (∀ i ∈ A, k.mf i = true) ∧ (∀ i ∈ B, k.ef i = true)

theorem Kd.sat_append {k : Kd} {A A' B B' : List Nat} :
    k.sat (A ++ A') (B ++ B') ↔ k.sat A B ∧ k.sat A' B' := by
  simp only [Kd.sat, List.mem_append]
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨⟨fun i h => h1 i (.inl h), fun i h => h2 i (.inl h)⟩, ⟨fun i h => h1 i (.inr h), fun i h => h2 i (.inr h)⟩⟩
  · rintro ⟨⟨a1, a2⟩, ⟨b1, b2⟩⟩
    exact ⟨fun i h => h.elim (a1 i) (b1 i), fun i h => h.elim (a2 i) (b2 i)⟩

/-- 本体が kind k で型付く ⇔ 要求の集合があって k がそれを満たす。最小の kind は「A の型変数だけ mut なし・B の型変数だけ端点なし」 -/
theorem ty_iff_need (k : Kd) (Γ : List Ty) : ∀ (e : Expr) (t : Ty),
    ty k Γ e = some t ↔ ∃ A B, need Γ e = some (t, A, B) ∧ k.sat A B
  | .var i, t => by
    simp only [ty, need]
    constructor
    · intro h; exact ⟨[], [], by simp [h], by simp [Kd.sat]⟩
    · rintro ⟨A, B, h, _⟩; cases hg : Γ[i]? <;> simp [hg] at h ⊢; exact h.1
  | .mks e, t => by
    simp only [ty, need, Option.bind_eq_some_iff, Option.map_eq_some_iff]
    constructor
    · rintro ⟨u, hu, hc⟩
      split at hc
      · rename_i hm
        simp at hc; subst hc
        obtain ⟨A, B, hn, hs⟩ := (ty_iff_need k Γ e u).1 hu
        obtain ⟨A', hA', hA''⟩ := (Ty.mutFree_iff k u).1 hm
        exact ⟨A ++ A', B, ⟨(u, A, B), hn, A', hA', rfl⟩, by
          simpa using (Kd.sat_append (k := k) (B := B) (B' := [])).2
            ⟨hs, (⟨fun i h => hA'' i h, fun i h => by simp at h⟩ : k.sat A' [])⟩⟩
      · simp at hc
    · rintro ⟨A0, B0, ⟨⟨u, A, B⟩, hn, A', hA', he⟩, hs⟩
      simp at he; obtain ⟨rfl, rfl, rfl⟩ := he
      have hs' : k.sat (A ++ A') (B ++ []) := by simpa using hs
      obtain ⟨hs1, hs2⟩ := Kd.sat_append.1 hs'
      refine ⟨u, (ty_iff_need k Γ e u).2 ⟨A, B, hn, hs1⟩, ?_⟩
      have hm : u.mutFree k = true := (Ty.mutFree_iff k u).2 ⟨A', hA', hs2.1⟩
      simp [hm]
  | .pair a b, t => by
    simp only [ty, need, Option.bind_eq_some_iff, Option.map_eq_some_iff]
    constructor
    · rintro ⟨ta, ha, tb, hb, rfl⟩
      obtain ⟨A, B, hn, hs⟩ := (ty_iff_need k Γ a ta).1 ha
      obtain ⟨A', B', hn', hs'⟩ := (ty_iff_need k Γ b tb).1 hb
      exact ⟨A ++ A', B ++ B', ⟨(ta, A, B), hn, (tb, A', B'), hn', rfl⟩, Kd.sat_append.2 ⟨hs, hs'⟩⟩
    · rintro ⟨A0, B0, ⟨⟨ta, A, B⟩, hn, ⟨tb, A', B'⟩, hn', he⟩, hs⟩
      simp at he; obtain ⟨rfl, rfl, rfl⟩ := he
      obtain ⟨hs1, hs2⟩ := Kd.sat_append.1 hs
      exact ⟨ta, (ty_iff_need k Γ a ta).2 ⟨A, B, hn, hs1⟩, tb, (ty_iff_need k Γ b tb).2 ⟨A', B', hn', hs2⟩, rfl⟩
  | .fst e, t => by
    simp only [ty, need, Option.bind_eq_some_iff]
    constructor
    · rintro ⟨u, hu, hc⟩
      obtain ⟨A, B, hn, hs⟩ := (ty_iff_need k Γ e u).1 hu
      cases u <;> simp at hc
      subst hc
      exact ⟨A, B, ⟨(_, A, B), hn, rfl⟩, hs⟩
    · rintro ⟨A0, B0, ⟨⟨u, A, B⟩, hn, hc⟩, hs⟩
      cases u <;> simp at hc
      obtain ⟨rfl, rfl, rfl⟩ := hc
      exact ⟨_, (ty_iff_need k Γ e _).2 ⟨A, B, hn, hs⟩, rfl⟩
  | .send e, t => by
    simp only [ty, need, Option.bind_eq_some_iff, Option.map_eq_some_iff]
    constructor
    · rintro ⟨u, hu, hc⟩
      split at hc
      · rename_i hm
        simp at hc hm; subst hc
        obtain ⟨A, B, hn, hs⟩ := (ty_iff_need k Γ e u).1 hu
        obtain ⟨A', hA', hA''⟩ := (Ty.mutFree_iff k u).1 hm.1
        obtain ⟨B', hB', hB''⟩ := (Ty.epFree_iff k u).1 hm.2
        exact ⟨A ++ A', B ++ B', ⟨(u, A, B), hn, A', hA', B', hB', rfl⟩, Kd.sat_append.2 ⟨hs, hA'', hB''⟩⟩
      · simp at hc
    · rintro ⟨A0, B0, ⟨⟨u, A, B⟩, hn, A', hA', B', hB', he⟩, hs⟩
      simp at he; obtain ⟨rfl, rfl, rfl⟩ := he
      obtain ⟨hs1, hs2⟩ := Kd.sat_append.1 hs
      refine ⟨u, (ty_iff_need k Γ e u).2 ⟨A, B, hn, hs1⟩, ?_⟩
      have hm : u.mutFree k = true := (Ty.mutFree_iff k u).2 ⟨A', hA', hs2.1⟩
      have he : u.epFree k = true := (Ty.epFree_iff k u).2 ⟨B', hB', hs2.2⟩
      simp [hm, he]
  | .arg e, t => by
    simp only [ty, need, Option.bind_eq_some_iff, Option.map_eq_some_iff]
    constructor
    · rintro ⟨u, hu, hc⟩
      split at hc
      · rename_i hm
        simp at hc; subst hc
        obtain ⟨A, B, hn, hs⟩ := (ty_iff_need k Γ e u).1 hu
        obtain ⟨B', hB', hB''⟩ := (Ty.epFree_iff k u).1 hm
        exact ⟨A, B ++ B', ⟨(u, A, B), hn, B', hB', rfl⟩, by
          have := Kd.sat_append (k := k) (A := A) (A' := []) (B := B) (B' := B')
          simpa using this.2 ⟨hs, by simp, hB''⟩⟩
      · simp at hc
    · rintro ⟨A0, B0, ⟨⟨u, A, B⟩, hn, B', hB', he⟩, hs⟩
      simp at he; obtain ⟨rfl, rfl, rfl⟩ := he
      have hs' : k.sat (A ++ []) (B ++ B') := by simpa using hs
      obtain ⟨hs1, hs2⟩ := Kd.sat_append.1 hs'
      refine ⟨u, (ty_iff_need k Γ e u).2 ⟨A, B, hn, hs1⟩, ?_⟩
      have he : u.epFree k = true := (Ty.epFree_iff k u).2 ⟨B', hB', hs2.2⟩
      simp [he]

/-! ## 4. 一致: 展開して型付く ⇔ 推論した kind を満たす -/

/-- 型引数 σ が要求の集合 A・B を満たす（A の型変数の型引数は mut を持たない・B は端点を持たない） -/
def satArgs (k : Kd) (σ : List Ty) (A B : List Nat) : Prop :=
  (∀ i ∈ A, (look σ i).mutFree k = true) ∧ (∀ i ∈ B, (look σ i).epFree k = true)

/-- 本体を σ で展開して型付くことと、本体の要求の集合（推論した kind）を σ が満たすことは一致する。
k は具体の型の外に残る型変数の性質（σ が閉じていれば使われない） -/
theorem expand_iff_kind (k : Kd) (σ Γ : List Ty) (e : Expr) :
    (tyE k σ Γ e).isSome ↔ ∃ t A B, need Γ e = some (t, A, B) ∧ satArgs k σ A B := by
  rw [tyE_eq]
  constructor
  · intro h
    obtain ⟨t, ht⟩ := Option.isSome_iff_exists.1 h
    obtain ⟨A, B, hn, hs⟩ := (ty_iff_need (kindOf k σ) Γ e t).1 ht
    exact ⟨t, A, B, hn, hs⟩
  · rintro ⟨t, A, B, hn, hs⟩
    have := (ty_iff_need (kindOf k σ) Γ e t).2 ⟨A, B, hn, hs⟩
    simp [this]

/-! ## 例 -/

/-- `func dup[T](x T) []T { return []T{x} }`: imm の slice を作るので、T に mut なしを要求する -/
example : need [.tvar 0] (.mks (.var 0)) = some (.slice false (.tvar 0), [0], []) := rfl
/-- `func keep[T](x T) T { return x }`: 何も要求しない（mut を持つ型・端点を持つ型も受け取れる。端点は argFree の規則で別に掛かる） -/
example : need [.tvar 0] (.var 0) = some (.tvar 0, [], []) := rfl
/-- `send(ch, x)` は mut なし・端点なしの両方を要求する -/
example : need [.tvar 0] (.send (.var 0)) = some (.int, [0], [0]) := rfl

end R3K
