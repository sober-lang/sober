/-!
# R3の確認（branch r3）: B1-a（型引数つきの再帰型）とB2（関数型の中の潰し）

本体のLean（lean/FeatherweightSober）とは別の小さな体系。型は int・型変数・slice・直積・関数型・再帰の変数・再帰型だけ。

- 再帰型 `mu r b ts`: 木のregionは r。本体 b は局所座標（region 0 = r）で、`rvar 0` が自分・`tvar j` がこのμ自身の型引数 ts[j]。
  本体は型変数について閉じている（外のDefの型変数は ts の中にだけ現れる）。組は幅1に簡単にした
- 関数型 `fn p q`: base座標の型スキーム。シフトは中へ入らない。代入は、型引数のregionを潰した形（low）で中へ入る（B2）
- 代入 `tsubst σ`: 型引数は絶対座標のまま入る（B1）。関数型の腕だけ low σ を使う

確かめること:
1. 代入とシフトの可換性（tsubst_shift）・展開とシフトの可換性（unfold_shift）
2. low の補題（low_shift・low_low・low_tsubst）と、代入の合成（tsubst_comp）・展開と代入の可換性（unfold_tsubst）
3. 反例2が型付かないこと（部分型が c' ≤ c を要求する）
-/

namespace R3

mutual
inductive Ty : Type where
  | int
  | tvar (i : Nat)
  | slice (m : Bool) (r : Nat) (t : Ty)
  | prod (a b : Ty)
  | fn (p q : Ty)
  | rvar (i : Nat)
  | mu (r : Nat) (b : Ty) (ts : Tys)
inductive Tys : Type where
  | nil
  | cons (t : Ty) (ts : Tys)
end

deriving instance DecidableEq for Ty, Tys

/-! ## 型の列の基本 -/

def Tys.get : Tys → Nat → Option Ty
  | .nil, _ => none
  | .cons t _, 0 => some t
  | .cons _ ts, i + 1 => ts.get i

def Tys.len : Tys → Nat
  | .nil => 0
  | .cons _ ts => ts.len + 1

/-- 型変数 0..n−1 の列（再帰の出現が持つ「自分の型引数そのもの」） -/
def Tys.ids (n : Nat) : Tys := go 0 n
where
  go (k : Nat) : Nat → Tys
    | 0 => .nil
    | m + 1 => .cons (.tvar k) (go (k + 1) m)

/-! ## シフト（region の一様な +ρ）。関数型の中へは入らない -/

mutual
def Ty.shift (ρ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
  | .slice m r t => .slice m (r + ρ) (t.shift ρ)
  | .prod a b => .prod (a.shift ρ) (b.shift ρ)
  | .fn p q => .fn p q
  | .rvar i => .rvar i
  | .mu r b ts => .mu (r + ρ) b (ts.shift ρ)
def Tys.shift (ρ : Nat) : Tys → Tys
  | .nil => .nil
  | .cons t ts => .cons (t.shift ρ) (ts.shift ρ)
end

/-! ## 潰し（B2）: region を全部 0 へ。関数型の中へは入らない -/

mutual
def Ty.low : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
  | .slice m _ t => .slice m 0 t.low
  | .prod a b => .prod a.low b.low
  | .fn p q => .fn p q
  | .rvar i => .rvar i
  | .mu _ b ts => .mu 0 b ts.low
def Tys.low : Tys → Tys
  | .nil => .nil
  | .cons t ts => .cons t.low ts.low
end

/-! ## 型代入（B1 + B2）。関数型の腕だけ潰した型引数を使う。再帰型の本体へは入らない -/

def Tys.look (σ : Tys) (i : Nat) : Ty := (σ.get i).getD (.tvar i)

mutual
def Ty.tsubst : Ty → Tys → Ty
  | .int, _ => .int
  | .tvar i, σ => σ.look i
  | .slice m r t, σ => .slice m r (t.tsubst σ)
  | .prod a b, σ => .prod (a.tsubst σ) (b.tsubst σ)
  | .fn p q, σ => .fn (p.tsubst σ.low) (q.tsubst σ.low)
  | .rvar i, _ => .rvar i
  | .mu r b ts, σ => .mu r b (ts.tsubst σ)
def Tys.tsubst : Tys → Tys → Tys
  | .nil, _ => .nil
  | .cons t ts, σ => .cons (t.tsubst σ) (ts.tsubst σ)
end

/-! ## 再帰の変数 0 の代入（本体の展開用）。s は閉じている。再帰型の本体は閉じているので入らない -/

mutual
def Ty.rsubst : Ty → Ty → Ty
  | .int, _ => .int
  | .tvar i, _ => .tvar i
  | .slice m r t, s => .slice m r (t.rsubst s)
  | .prod a b, s => .prod (a.rsubst s) (b.rsubst s)
  | .fn p q, s => .fn (p.rsubst s) (q.rsubst s)
  | .rvar i, s => if i = 0 then s else .rvar (i - 1)
  | .mu r b ts, s => .mu r b (ts.rsubst s)
def Tys.rsubst : Tys → Ty → Tys
  | .nil, _ => .nil
  | .cons t ts, s => .cons (t.rsubst s) (ts.rsubst s)
end

/-- 1段の展開: 自分の出現を「region 0・型引数そのもの」の再帰型にし、r へシフトしてから型引数を代入する（シフトしてから代入 = B1の順） -/
def Ty.unfold : Ty → Ty
  | .mu r b ts => ((b.rsubst (.mu 0 b (Tys.ids ts.len))).shift r).tsubst ts
  | t => t

/-! ## 型変数の範囲 -/

mutual
def Ty.tvb (n : Nat) : Ty → Bool
  | .int => true
  | .tvar i => decide (i < n)
  | .slice _ _ t => t.tvb n
  | .prod a b => a.tvb n && b.tvb n
  | .fn p q => p.tvb n && q.tvb n
  | .rvar _ => true
  | .mu _ _ ts => ts.tvb n
def Tys.tvb (n : Nat) : Tys → Bool
  | .nil => true
  | .cons t ts => t.tvb n && ts.tvb n
end

/-! # 1. シフトの補題と、代入とシフトの可換性 -/

mutual
theorem Ty.shift_comp (ρ₁ ρ₂ : Nat) : ∀ t : Ty, (t.shift ρ₁).shift ρ₂ = t.shift (ρ₁ + ρ₂)
  | .int => rfl
  | .tvar _ => rfl
  | .slice m r t => by simp [Ty.shift, Ty.shift_comp ρ₁ ρ₂ t, Nat.add_assoc]
  | .prod a b => by simp [Ty.shift, Ty.shift_comp ρ₁ ρ₂ a, Ty.shift_comp ρ₁ ρ₂ b]
  | .fn _ _ => rfl
  | .rvar _ => rfl
  | .mu r b ts => by simp [Ty.shift, Tys.shift_comp ρ₁ ρ₂ ts, Nat.add_assoc]
theorem Tys.shift_comp (ρ₁ ρ₂ : Nat) : ∀ ts : Tys, (ts.shift ρ₁).shift ρ₂ = ts.shift (ρ₁ + ρ₂)
  | .nil => rfl
  | .cons t ts => by simp [Tys.shift, Ty.shift_comp ρ₁ ρ₂ t, Tys.shift_comp ρ₁ ρ₂ ts]
end

mutual
theorem Ty.low_shift (ρ : Nat) : ∀ t : Ty, (t.shift ρ).low = t.low
  | .int => rfl
  | .tvar _ => rfl
  | .slice m r t => by simp [Ty.shift, Ty.low, Ty.low_shift ρ t]
  | .prod a b => by simp [Ty.shift, Ty.low, Ty.low_shift ρ a, Ty.low_shift ρ b]
  | .fn _ _ => rfl
  | .rvar _ => rfl
  | .mu r b ts => by simp [Ty.shift, Ty.low, Tys.low_shift ρ ts]
theorem Tys.low_shift (ρ : Nat) : ∀ ts : Tys, (ts.shift ρ).low = ts.low
  | .nil => rfl
  | .cons t ts => by simp [Tys.shift, Tys.low, Ty.low_shift ρ t, Tys.low_shift ρ ts]
end

theorem Tys.get_shift (ρ : Nat) : ∀ (σ : Tys) (i : Nat), (σ.shift ρ).get i = (σ.get i).map (Ty.shift ρ)
  | .nil, _ => rfl
  | .cons _ _, 0 => rfl
  | .cons _ σ, i + 1 => Tys.get_shift ρ σ i

theorem Tys.look_shift (ρ : Nat) (σ : Tys) (i : Nat) : (σ.shift ρ).look i = (σ.look i).shift ρ := by
  simp only [Tys.look, Tys.get_shift]
  cases σ.get i <;> rfl

theorem Tys.len_shift (ρ : Nat) : ∀ ts : Tys, (ts.shift ρ).len = ts.len
  | .nil => rfl
  | .cons _ ts => by simp [Tys.shift, Tys.len, Tys.len_shift ρ ts]

/- 代入とシフトの可換性（B1の中心の補題）: 型引数もシフトすれば、シフトと代入の順は入れ替えられる。
関数型の腕は、潰しがシフトを忘れること（low_shift）で閉じる -/
mutual
theorem Ty.tsubst_shift (ρ : Nat) (σ : Tys) : ∀ t : Ty, (t.tsubst σ).shift ρ = (t.shift ρ).tsubst (σ.shift ρ)
  | .int => rfl
  | .tvar i => by simp [Ty.tsubst, Ty.shift, Tys.look_shift]
  | .slice m r t => by simp [Ty.tsubst, Ty.shift, Ty.tsubst_shift ρ σ t]
  | .prod a b => by simp [Ty.tsubst, Ty.shift, Ty.tsubst_shift ρ σ a, Ty.tsubst_shift ρ σ b]
  | .fn p q => by simp [Ty.tsubst, Ty.shift, Tys.low_shift]
  | .rvar _ => rfl
  | .mu r b ts => by simp [Ty.tsubst, Ty.shift, Tys.tsubst_shift ρ σ ts]
theorem Tys.tsubst_shift (ρ : Nat) (σ : Tys) : ∀ ts : Tys, (ts.tsubst σ).shift ρ = (ts.shift ρ).tsubst (σ.shift ρ)
  | .nil => rfl
  | .cons t ts => by simp [Tys.tsubst, Tys.shift, Ty.tsubst_shift ρ σ t, Tys.tsubst_shift ρ σ ts]
end

/-- 展開とシフトの可換性: 再帰型をシフトしてから展開しても、展開してからシフトしても同じ -/
theorem Ty.unfold_shift (ρ r : Nat) (b : Ty) (ts : Tys) :
    (Ty.mu r b ts).unfold.shift ρ = ((Ty.mu r b ts).shift ρ).unfold := by
  simp only [Ty.unfold, Ty.shift, Ty.tsubst_shift, Ty.shift_comp, Tys.len_shift]

/-! # 2. 部分型と、反例2が型付かないこと -/

/- 本体が型変数の位置まで深く共変（mut の slice を持たない）。型変数・関数型・再帰の変数は座標を持たない -/
mutual
def Ty.cov : Ty → Bool
  | .int => true
  | .tvar _ => true
  | .slice m _ t => !m && t.cov
  | .prod a b => a.cov && b.cov
  | .fn _ _ => true
  | .rvar _ => true
  | .mu _ b ts => b.cov && ts.cov
def Tys.cov : Tys → Bool
  | .nil => true
  | .cons t ts => t.cov && ts.cov
end

/- 部分型: imm の slice は region の上界を緩められ中身は深く共変。再帰型は、同じ本体で、
(region と型引数が等しい) か (本体が深く共変・region を緩める・型引数を成分ごとに緩める)。ほかは等しさ -/
mutual
def Ty.sub : Ty → Ty → Bool
  | .slice false r t, .slice false r' t' => decide (r ≤ r') && t.sub t'
  | .prod a b, .prod a' b' => a.sub a' && b.sub b'
  | .mu r b ts, .mu r' b' ts' =>
      decide (b = b') && ((decide (r = r') && decide (ts = ts')) || (decide (r ≤ r') && b.cov && ts.sub ts'))
  | a, a' => decide (a = a')
def Tys.sub : Tys → Tys → Bool
  | .nil, .nil => true
  | .cons t ts, .cons t' ts' => t.sub t' && ts.sub ts'
  | _, _ => false
end

/-- `type Tree[T] struct { v T; kids []Tree[T] }`（本体は局所座標・型変数 0 は自分の型引数） -/
def treeB : Ty := .prod (.tvar 0) (.slice false 0 (.rvar 0))
def str (c : Nat) : Ty := .slice false c .int
def tree (r c : Nat) : Ty := .mu r treeB (.cons (str c) .nil)

/-- 反例2の要: 要素の region が違う木は別の型で、`Tree[string@c']` を `Tree[string@c]` として渡せるのは c' ≤ c のときだけ -/
theorem tree_sub_iff (r c c' : Nat) : (tree r c').sub (tree r c) = true ↔ c' ≤ c := by
  simp [tree, Ty.sub, Tys.sub, str, treeB, Ty.cov]
  omega

/-- head[T] を T = string@c で呼べるなら、木の実際の要素（展開の v の型 string@c'）は戻り値の型 string@c の部分型（ぶら下がらない） -/
theorem head_sound (r c c' : Nat) (h : (tree r c').sub (tree r c) = true) :
    (str c').sub (str c) = true := by
  have := (tree_sub_iff r c c').1 h
  simp [str, Ty.sub, this]

/-- 展開の v の成分は型引数そのもの（シフトしてから代入するので、型引数の region は動かない）・kids は同じ木の slice -/
theorem unfold_tree (r c : Nat) :
    (tree r c).unfold = .prod (str c) (.slice false r (tree r c)) := by
  simp [Ty.unfold, tree, treeB, Ty.rsubst, Ty.shift, Tys.shift, Ty.tsubst, Tys.tsubst,
    Tys.len, Tys.ids, Tys.ids.go, Tys.look, Tys.get, str]

/-! # 3. 潰し（low）の補題・代入の合成・展開と代入の可換性 -/

mutual
theorem Ty.low_low : ∀ t : Ty, t.low.low = t.low
  | .int => rfl
  | .tvar _ => rfl
  | .slice m r t => by simp [Ty.low, Ty.low_low t]
  | .prod a b => by simp [Ty.low, Ty.low_low a, Ty.low_low b]
  | .fn _ _ => rfl
  | .rvar _ => rfl
  | .mu r b ts => by simp [Ty.low, Tys.low_low ts]
theorem Tys.low_low : ∀ ts : Tys, ts.low.low = ts.low
  | .nil => rfl
  | .cons t ts => by simp [Tys.low, Ty.low_low t, Tys.low_low ts]
end

theorem Tys.get_low : ∀ (σ : Tys) (i : Nat), σ.low.get i = (σ.get i).map Ty.low
  | .nil, _ => rfl
  | .cons _ _, 0 => rfl
  | .cons _ σ, i + 1 => Tys.get_low σ i

theorem Tys.look_low (σ : Tys) (i : Nat) : σ.low.look i = (σ.look i).low := by
  simp only [Tys.look, Tys.get_low]
  cases σ.get i <;> rfl

/- 潰しは代入の準同型: 代入してから潰しても、両方を潰してから代入しても同じ（入れ子の fnref の型引数の潰しが合成で閉じる） -/
mutual
theorem Ty.low_tsubst : ∀ (t : Ty) (σ : Tys), (t.tsubst σ).low = t.low.tsubst σ.low
  | .int, _ => rfl
  | .tvar i, σ => by simp [Ty.tsubst, Ty.low, Tys.look_low]
  | .slice m r t, σ => by simp [Ty.tsubst, Ty.low, Ty.low_tsubst t σ]
  | .prod a b, σ => by simp [Ty.tsubst, Ty.low, Ty.low_tsubst a σ, Ty.low_tsubst b σ]
  | .fn p q, σ => by simp [Ty.tsubst, Ty.low, Tys.low_low]
  | .rvar _, _ => rfl
  | .mu r b ts, σ => by simp [Ty.tsubst, Ty.low, Tys.low_tsubst ts σ]
theorem Tys.low_tsubst : ∀ (ts σ : Tys), (ts.tsubst σ).low = ts.low.tsubst σ.low
  | .nil, _ => rfl
  | .cons t ts, σ => by simp [Tys.tsubst, Tys.low, Ty.low_tsubst t σ, Tys.low_tsubst ts σ]
end

theorem Tys.len_low : ∀ ts : Tys, ts.low.len = ts.len
  | .nil => rfl
  | .cons _ ts => by simp [Tys.low, Tys.len, Tys.len_low ts]

theorem Tys.len_tsubst (σ : Tys) : ∀ ts : Tys, (ts.tsubst σ).len = ts.len
  | .nil => rfl
  | .cons _ ts => by simp [Tys.tsubst, Tys.len, Tys.len_tsubst σ ts]

theorem Tys.get_tsubst (σ : Tys) : ∀ (ts : Tys) (i : Nat), (ts.tsubst σ).get i = (ts.get i).map (Ty.tsubst · σ)
  | .nil, _ => rfl
  | .cons _ _, 0 => rfl
  | .cons _ ts, i + 1 => Tys.get_tsubst σ ts i

theorem Tys.get_some : ∀ (ts : Tys) (i : Nat), i < ts.len → ∃ t, ts.get i = some t
  | .nil, _, h => by simp [Tys.len] at h
  | .cons t _, 0, _ => ⟨t, rfl⟩
  | .cons _ ts, i + 1, h => Tys.get_some ts i (by simp [Tys.len] at h; omega)

theorem Tys.look_tsubst (σ ts : Tys) (i : Nat) (h : i < ts.len) :
    (ts.look i).tsubst σ = (ts.tsubst σ).look i := by
  obtain ⟨t, ht⟩ := Tys.get_some ts i h
  simp [Tys.look, Tys.get_tsubst, ht]

mutual
theorem Ty.tvb_low (n : Nat) : ∀ t : Ty, t.tvb n = true → t.low.tvb n = true
  | .int, _ => rfl
  | .tvar _, h => h
  | .slice _ _ t, h => by simp [Ty.tvb, Ty.low] at h ⊢; exact Ty.tvb_low n t h
  | .prod a b, h => by
    simp [Ty.tvb, Ty.low] at h ⊢; exact ⟨Ty.tvb_low n a h.1, Ty.tvb_low n b h.2⟩
  | .fn _ _, h => h
  | .rvar _, _ => rfl
  | .mu _ _ ts, h => by simp [Ty.tvb, Ty.low] at h ⊢; exact Tys.tvb_low n ts h
theorem Tys.tvb_low (n : Nat) : ∀ ts : Tys, ts.tvb n = true → ts.low.tvb n = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.tvb, Tys.low] at h ⊢; exact ⟨Ty.tvb_low n t h.1, Tys.tvb_low n ts h.2⟩
end

/- 代入の合成: 型変数が ts の範囲にあれば、ts で代入してから σ で代入するのと、ts に σ を代入した列で代入するのは同じ（ジェネリックがジェネリックを呼ぶ形） -/
mutual
theorem Ty.tsubst_comp : ∀ (t : Ty) (ts σ : Tys), t.tvb ts.len = true →
    (t.tsubst ts).tsubst σ = t.tsubst (ts.tsubst σ)
  | .int, _, _, _ => rfl
  | .tvar i, ts, σ, h => by
    simp [Ty.tvb] at h; simp [Ty.tsubst, Tys.look_tsubst σ ts i h]
  | .slice m r t, ts, σ, h => by
    simp [Ty.tvb] at h; simp [Ty.tsubst, Ty.tsubst_comp t ts σ h]
  | .prod a b, ts, σ, h => by
    simp [Ty.tvb] at h; simp [Ty.tsubst, Ty.tsubst_comp a ts σ h.1, Ty.tsubst_comp b ts σ h.2]
  | .fn p q, ts, σ, h => by
    simp [Ty.tvb] at h
    have hp : p.tvb ts.low.len = true := by rw [Tys.len_low]; exact h.1
    have hq : q.tvb ts.low.len = true := by rw [Tys.len_low]; exact h.2
    simp [Ty.tsubst, Ty.tsubst_comp p ts.low σ.low hp, Ty.tsubst_comp q ts.low σ.low hq, Tys.low_tsubst]
  | .rvar _, _, _, _ => rfl
  | .mu r b us, ts, σ, h => by
    simp [Ty.tvb] at h; simp [Ty.tsubst, Tys.tsubst_comp us ts σ h]
theorem Tys.tsubst_comp : ∀ (us ts σ : Tys), us.tvb ts.len = true →
    (us.tsubst ts).tsubst σ = us.tsubst (ts.tsubst σ)
  | .nil, _, _, _ => rfl
  | .cons t us, ts, σ, h => by
    simp [Tys.tvb] at h; simp [Tys.tsubst, Ty.tsubst_comp t ts σ h.1, Tys.tsubst_comp us ts σ h.2]
end

mutual
theorem Ty.tvb_shift (n ρ : Nat) : ∀ t : Ty, t.tvb n = true → (t.shift ρ).tvb n = true
  | .int, _ => rfl
  | .tvar _, h => h
  | .slice _ _ t, h => by simp [Ty.tvb, Ty.shift] at h ⊢; exact Ty.tvb_shift n ρ t h
  | .prod a b, h => by
    simp [Ty.tvb, Ty.shift] at h ⊢; exact ⟨Ty.tvb_shift n ρ a h.1, Ty.tvb_shift n ρ b h.2⟩
  | .fn _ _, h => h
  | .rvar _, _ => rfl
  | .mu _ _ ts, h => by simp [Ty.tvb, Ty.shift] at h ⊢; exact Tys.tvb_shift n ρ ts h
theorem Tys.tvb_shift (n ρ : Nat) : ∀ ts : Tys, ts.tvb n = true → (ts.shift ρ).tvb n = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.tvb, Tys.shift] at h ⊢; exact ⟨Ty.tvb_shift n ρ t h.1, Tys.tvb_shift n ρ ts h.2⟩
end

mutual
theorem Ty.tvb_rsubst (n : Nat) (s : Ty) (hs : s.tvb n = true) : ∀ t : Ty, t.tvb n = true → (t.rsubst s).tvb n = true
  | .int, _ => rfl
  | .tvar _, h => h
  | .slice _ _ t, h => by simp [Ty.tvb, Ty.rsubst] at h ⊢; exact Ty.tvb_rsubst n s hs t h
  | .prod a b, h => by
    simp [Ty.tvb, Ty.rsubst] at h ⊢; exact ⟨Ty.tvb_rsubst n s hs a h.1, Ty.tvb_rsubst n s hs b h.2⟩
  | .fn p q, h => by
    simp [Ty.tvb, Ty.rsubst] at h ⊢; exact ⟨Ty.tvb_rsubst n s hs p h.1, Ty.tvb_rsubst n s hs q h.2⟩
  | .rvar i, _ => by by_cases hi : i = 0 <;> simp [Ty.rsubst, hi, hs, Ty.tvb]
  | .mu _ _ ts, h => by simp [Ty.tvb, Ty.rsubst] at h ⊢; exact Tys.tvb_rsubst n s hs ts h
theorem Tys.tvb_rsubst (n : Nat) (s : Ty) (hs : s.tvb n = true) : ∀ ts : Tys, ts.tvb n = true → (ts.rsubst s).tvb n = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.tvb, Tys.rsubst] at h ⊢; exact ⟨Ty.tvb_rsubst n s hs t h.1, Tys.tvb_rsubst n s hs ts h.2⟩
end

theorem Tys.ids_go_tvb (n : Nat) : ∀ k m : Nat, k + m ≤ n → (Tys.ids.go k m).tvb n = true
  | _, 0, _ => rfl
  | k, m + 1, h => by
    simp [Tys.ids.go, Tys.tvb, Ty.tvb]
    exact ⟨by omega, Tys.ids_go_tvb n (k + 1) m (by omega)⟩

/-- 展開と代入の可換性: 本体の型変数が自分の型引数の範囲にあれば、展開してから外の型変数を代入しても、型引数に代入してから展開しても同じ -/
theorem Ty.unfold_tsubst (r : Nat) (b : Ty) (ts σ : Tys) (hb : b.tvb ts.len = true) :
    (Ty.mu r b ts).unfold.tsubst σ = (Ty.mu r b (ts.tsubst σ)).unfold := by
  have hs : (Ty.mu 0 b (Tys.ids ts.len)).tvb ts.len = true := by
    simp [Ty.tvb, Tys.ids]; exact Tys.ids_go_tvb ts.len 0 ts.len (by omega)
  have hB := Ty.tvb_shift ts.len r _ (Ty.tvb_rsubst ts.len _ hs b hb)
  simp only [Ty.unfold, Tys.len_tsubst]
  exact Ty.tsubst_comp _ ts σ hB

/-! # 4. 展開は部分型について単調（fold / unfold と部分型の組み合わせの土台） -/

theorem Ty.sub_cases {t t' : Ty} (h : t.sub t' = true) :
    t = t' ∨
    (∃ r r' u u', t = .slice false r u ∧ t' = .slice false r' u' ∧ r ≤ r' ∧ u.sub u' = true) ∨
    (∃ a b a' b', t = .prod a b ∧ t' = .prod a' b' ∧ a.sub a' = true ∧ b.sub b' = true) ∨
    (∃ r r' b ts ts', t = .mu r b ts ∧ t' = .mu r' b ts' ∧ r ≤ r' ∧ b.cov = true ∧ ts.sub ts' = true) := by
  cases t <;> cases t' <;> simp [Ty.sub] at h ⊢
  case tvar.tvar => exact h
  case fn.fn => exact h
  case rvar.rvar => exact h
  case prod.prod => exact .inr ⟨_, _, ⟨rfl, rfl⟩, _, _, ⟨rfl, rfl⟩, h.1, h.2⟩
  case mu.mu =>
    rcases h with ⟨rfl, ⟨rfl, rfl⟩ | ⟨⟨hr, hc⟩, hs⟩⟩
    · exact .inl ⟨rfl, rfl, rfl⟩
    · exact .inr ⟨_, _, _, _, ⟨rfl, rfl, rfl⟩, _, ⟨rfl, rfl, rfl⟩, hr, hc, hs⟩
  case slice.slice m r u m' r' u' =>
    cases m <;> cases m' <;> simp [Ty.sub] at h ⊢
    · first
        | exact .inr ⟨_, _, _, ⟨rfl, rfl⟩, _, ⟨rfl, rfl⟩, h.1, h.2⟩
        | exact .inr ⟨_, _, _, rfl, _, rfl, h.1, h.2⟩
        | exact .inr ⟨_, _, _, ⟨rfl, rfl, rfl⟩, _, ⟨rfl, rfl, rfl⟩, h.1, h.2⟩
    all_goals exact h

mutual
theorem Ty.sub_refl : ∀ t : Ty, t.sub t = true
  | .int => by simp [Ty.sub]
  | .tvar _ => by simp [Ty.sub]
  | .slice m r t => by cases m <;> simp [Ty.sub, Ty.sub_refl t]
  | .prod a b => by simp [Ty.sub, Ty.sub_refl a, Ty.sub_refl b]
  | .fn _ _ => by simp [Ty.sub]
  | .rvar _ => by simp [Ty.sub]
  | .mu r b ts => by simp [Ty.sub]
theorem Tys.sub_refl : ∀ ts : Tys, ts.sub ts = true
  | .nil => rfl
  | .cons t ts => by simp [Tys.sub, Ty.sub_refl t, Tys.sub_refl ts]
end

theorem Tys.sub_cases {ts ts' : Tys} (h : ts.sub ts' = true) :
    (ts = .nil ∧ ts' = .nil) ∨ (∃ t u t' u', ts = .cons t u ∧ ts' = .cons t' u' ∧ t.sub t' = true ∧ u.sub u' = true) := by
  cases ts <;> cases ts' <;> simp [Tys.sub] at h ⊢
  exact ⟨_, _, ⟨rfl, rfl⟩, _, _, ⟨rfl, rfl⟩, h.1, h.2⟩

mutual
theorem Ty.sub_trans : ∀ {a b c : Ty}, a.sub b = true → b.sub c = true → a.sub c = true
  | a, b, c, h1, h2 => by
    rcases Ty.sub_cases h1 with rfl | ⟨r, r', u, u', rfl, rfl, hr, hu⟩ | ⟨x, y, x', y', rfl, rfl, hx, hy⟩ |
      ⟨r, r', bb, ts, ts', rfl, rfl, hr, hc, hs⟩
    · exact h2
    · rcases Ty.sub_cases h2 with rfl | ⟨_, r'', _, u'', he, rfl, hr', hu'⟩ | ⟨_, _, _, _, he, _⟩ | ⟨_, _, _, _, _, he, _⟩
      · simp [Ty.sub, hr, hu]
      · cases he; simp [Ty.sub, Nat.le_trans hr hr', Ty.sub_trans hu hu']
      · cases he
      · cases he
    · rcases Ty.sub_cases h2 with rfl | ⟨_, _, _, _, he, _⟩ | ⟨_, _, x'', y'', he, rfl, hx', hy'⟩ | ⟨_, _, _, _, _, he, _⟩
      · simp [Ty.sub, hx, hy]
      · cases he
      · cases he; simp [Ty.sub, Ty.sub_trans hx hx', Ty.sub_trans hy hy']
      · cases he
    · rcases Ty.sub_cases h2 with rfl | ⟨_, _, _, _, he, _⟩ | ⟨_, _, _, _, he, _⟩ | ⟨_, r'', _, _, ts'', he, rfl, hr', _, hs'⟩
      · simp [Ty.sub, hr, hc, hs]
      · cases he
      · cases he
      · cases he; simp [Ty.sub, Nat.le_trans hr hr', hc, Tys.sub_trans hs hs']
theorem Tys.sub_trans : ∀ {a b c : Tys}, a.sub b = true → b.sub c = true → a.sub c = true
  | a, b, c, h1, h2 => by
    rcases Tys.sub_cases h1 with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · exact h2
    · rcases Tys.sub_cases h2 with ⟨he, _⟩ | ⟨_, _, t'', u'', he, rfl, ht', hu'⟩
      · cases he
      · cases he; simp [Tys.sub, Ty.sub_trans ht ht', Tys.sub_trans hu hu']
end

mutual
theorem Ty.sub_shift (ρ : Nat) : ∀ {a b : Ty}, a.sub b = true → (a.shift ρ).sub (b.shift ρ) = true
  | a, b, h => by
    rcases Ty.sub_cases h with rfl | ⟨r, r', u, u', rfl, rfl, hr, hu⟩ | ⟨x, y, x', y', rfl, rfl, hx, hy⟩ |
      ⟨r, r', bb, ts, ts', rfl, rfl, hr, hc, hs⟩
    · exact Ty.sub_refl _
    · simp [Ty.shift, Ty.sub, Ty.sub_shift ρ hu]; omega
    · simp [Ty.shift, Ty.sub, Ty.sub_shift ρ hx, Ty.sub_shift ρ hy]
    · simp [Ty.shift, Ty.sub, hc, Tys.sub_shift ρ hs]; omega
theorem Tys.sub_shift (ρ : Nat) : ∀ {a b : Tys}, a.sub b = true → (a.shift ρ).sub (b.shift ρ) = true
  | a, b, h => by
    rcases Tys.sub_cases h with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · rfl
    · simp [Tys.shift, Tys.sub, Ty.sub_shift ρ ht, Tys.sub_shift ρ hu]
end

/- 深く共変な型は、region を上げるシフトで部分型になる -/
mutual
theorem Ty.sub_shift_le {r r' : Nat} (hr : r ≤ r') : ∀ t : Ty, t.cov = true → (t.shift r).sub (t.shift r') = true
  | .int, _ => by simp [Ty.shift, Ty.sub]
  | .tvar _, _ => by simp [Ty.shift, Ty.sub]
  | .slice m q t, h => by
    cases m <;> simp [Ty.cov] at h
    simp [Ty.shift, Ty.sub, Ty.sub_shift_le hr t h]; omega
  | .prod a b, h => by
    simp [Ty.cov] at h; simp [Ty.shift, Ty.sub, Ty.sub_shift_le hr a h.1, Ty.sub_shift_le hr b h.2]
  | .fn _ _, _ => by simp [Ty.shift, Ty.sub]
  | .rvar _, _ => by simp [Ty.shift, Ty.sub]
  | .mu q b ts, h => by
    simp [Ty.cov] at h; simp [Ty.shift, Ty.sub, h.1, Tys.sub_shift_le hr ts h.2]; omega
theorem Tys.sub_shift_le {r r' : Nat} (hr : r ≤ r') : ∀ ts : Tys, ts.cov = true → (ts.shift r).sub (ts.shift r') = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.cov] at h; simp [Tys.shift, Tys.sub, Ty.sub_shift_le hr t h.1, Tys.sub_shift_le hr ts h.2]
end

/- 部分型は region だけを動かすので、潰すと等しい（関数型の腕の型引数の潰しが部分型で変わらない） -/
mutual
theorem Ty.sub_low : ∀ {a b : Ty}, a.sub b = true → a.low = b.low
  | a, b, h => by
    rcases Ty.sub_cases h with rfl | ⟨r, r', u, u', rfl, rfl, hr, hu⟩ | ⟨x, y, x', y', rfl, rfl, hx, hy⟩ |
      ⟨r, r', bb, ts, ts', rfl, rfl, hr, hc, hs⟩
    · rfl
    · simp [Ty.low, Ty.sub_low hu]
    · simp [Ty.low, Ty.sub_low hx, Ty.sub_low hy]
    · simp [Ty.low, Tys.sub_low hs]
theorem Tys.sub_low : ∀ {a b : Tys}, a.sub b = true → a.low = b.low
  | a, b, h => by
    rcases Tys.sub_cases h with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · rfl
    · simp [Tys.low, Ty.sub_low ht, Tys.sub_low hu]
end

/- 代入は、代入される型の部分型を保つ -/
mutual
theorem Ty.tsubst_mono (σ : Tys) : ∀ {a b : Ty}, a.sub b = true → (a.tsubst σ).sub (b.tsubst σ) = true
  | a, b, h => by
    rcases Ty.sub_cases h with rfl | ⟨r, r', u, u', rfl, rfl, hr, hu⟩ | ⟨x, y, x', y', rfl, rfl, hx, hy⟩ |
      ⟨r, r', bb, ts, ts', rfl, rfl, hr, hc, hs⟩
    · exact Ty.sub_refl _
    · simp [Ty.tsubst, Ty.sub, hr, Ty.tsubst_mono σ hu]
    · simp [Ty.tsubst, Ty.sub, Ty.tsubst_mono σ hx, Ty.tsubst_mono σ hy]
    · simp [Ty.tsubst, Ty.sub, hr, hc, Tys.tsubst_mono σ hs]
theorem Tys.tsubst_mono (σ : Tys) : ∀ {a b : Tys}, a.sub b = true → (a.tsubst σ).sub (b.tsubst σ) = true
  | a, b, h => by
    rcases Tys.sub_cases h with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · rfl
    · simp [Tys.tsubst, Tys.sub, Ty.tsubst_mono σ ht, Tys.tsubst_mono σ hu]
end

theorem Tys.getD_sub (d : Ty) : ∀ {σ σ' : Tys}, σ.sub σ' = true → ∀ i, ((σ.get i).getD d).sub ((σ'.get i).getD d) = true
  | σ, σ', h, i => by
    rcases Tys.sub_cases h with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · exact Ty.sub_refl _
    · cases i with
      | zero => simpa [Tys.get] using ht
      | succ i => simpa [Tys.get] using Tys.getD_sub d hu i

theorem Tys.look_sub {σ σ' : Tys} (h : σ.sub σ' = true) (i : Nat) : (σ.look i).sub (σ'.look i) = true :=
  Tys.getD_sub _ h i

/- 深く共変な型では、型引数を部分型へ替えると代入の結果も部分型（関数型の腕は潰しが部分型で変わらないので等しい） -/
mutual
theorem Ty.tsubst_mono_arg {σ σ' : Tys} (hσ : σ.sub σ' = true) : ∀ t : Ty, t.cov = true → (t.tsubst σ).sub (t.tsubst σ') = true
  | .int, _ => by simp [Ty.tsubst, Ty.sub]
  | .tvar i, _ => by simpa [Ty.tsubst] using Tys.look_sub hσ i
  | .slice m q t, h => by
    cases m <;> simp [Ty.cov] at h
    simp [Ty.tsubst, Ty.sub, Ty.tsubst_mono_arg hσ t h]
  | .prod a b, h => by
    simp [Ty.cov] at h; simp [Ty.tsubst, Ty.sub, Ty.tsubst_mono_arg hσ a h.1, Ty.tsubst_mono_arg hσ b h.2]
  | .fn p q, _ => by simp [Ty.tsubst, Ty.sub, Tys.sub_low hσ]
  | .rvar _, _ => by simp [Ty.tsubst, Ty.sub]
  | .mu q b ts, h => by
    simp [Ty.cov] at h; simp [Ty.tsubst, Ty.sub, h.1, Tys.tsubst_mono_arg hσ ts h.2]
theorem Tys.tsubst_mono_arg {σ σ' : Tys} (hσ : σ.sub σ' = true) : ∀ ts : Tys, ts.cov = true → (ts.tsubst σ).sub (ts.tsubst σ') = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.cov] at h; simp [Tys.tsubst, Tys.sub, Ty.tsubst_mono_arg hσ t h.1, Tys.tsubst_mono_arg hσ ts h.2]
end

mutual
theorem Ty.cov_shift (ρ : Nat) : ∀ t : Ty, t.cov = true → (t.shift ρ).cov = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .slice m _ t, h => by
    cases m <;> simp [Ty.cov] at h; simp [Ty.shift, Ty.cov, Ty.cov_shift ρ t h]
  | .prod a b, h => by
    simp [Ty.cov] at h; simp [Ty.shift, Ty.cov, Ty.cov_shift ρ a h.1, Ty.cov_shift ρ b h.2]
  | .fn _ _, _ => rfl
  | .rvar _, _ => rfl
  | .mu _ b ts, h => by simp [Ty.cov] at h; simp [Ty.shift, Ty.cov, h.1, Tys.cov_shift ρ ts h.2]
theorem Tys.cov_shift (ρ : Nat) : ∀ ts : Tys, ts.cov = true → (ts.shift ρ).cov = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.cov] at h; simp [Tys.shift, Tys.cov, Ty.cov_shift ρ t h.1, Tys.cov_shift ρ ts h.2]
end

mutual
theorem Ty.cov_rsubst {s : Ty} (hs : s.cov = true) : ∀ t : Ty, t.cov = true → (t.rsubst s).cov = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .slice m _ t, h => by
    cases m <;> simp [Ty.cov] at h; simp [Ty.rsubst, Ty.cov, Ty.cov_rsubst hs t h]
  | .prod a b, h => by
    simp [Ty.cov] at h; simp [Ty.rsubst, Ty.cov, Ty.cov_rsubst hs a h.1, Ty.cov_rsubst hs b h.2]
  | .fn _ _, _ => rfl
  | .rvar i, _ => by by_cases hi : i = 0 <;> simp [Ty.rsubst, hi, hs, Ty.cov]
  | .mu _ b ts, h => by simp [Ty.cov] at h; simp [Ty.rsubst, Ty.cov, h.1, Tys.cov_rsubst hs ts h.2]
theorem Tys.cov_rsubst {s : Ty} (hs : s.cov = true) : ∀ ts : Tys, ts.cov = true → (ts.rsubst s).cov = true
  | .nil, _ => rfl
  | .cons t ts, h => by
    simp [Tys.cov] at h; simp [Tys.rsubst, Tys.cov, Ty.cov_rsubst hs t h.1, Tys.cov_rsubst hs ts h.2]
end

theorem Tys.ids_go_cov : ∀ k m : Nat, (Tys.ids.go k m).cov = true
  | _, 0 => rfl
  | k, m + 1 => by simp [Tys.ids.go, Tys.cov, Ty.cov, Tys.ids_go_cov (k + 1) m]

theorem Tys.len_of_sub : ∀ {a b : Tys}, a.sub b = true → a.len = b.len
  | a, b, h => by
    rcases Tys.sub_cases h with ⟨rfl, rfl⟩ | ⟨t, u, t', u', rfl, rfl, ht, hu⟩
    · rfl
    · simp [Tys.len, Tys.len_of_sub hu]

/-- 展開は部分型について単調: 再帰型の部分型（region を緩める・型引数を成分ごとに緩める）は、1段展開した型の部分型を与える。
fold / unfold の型規則が部分型と組み合わさるための土台 -/
theorem Ty.unfold_sub {r r' : Nat} {b b' : Ty} {ts ts' : Tys}
    (h : (Ty.mu r b ts).sub (Ty.mu r' b' ts') = true) :
    (Ty.mu r b ts).unfold.sub (Ty.mu r' b' ts').unfold = true := by
  rcases Ty.sub_cases h with he | ⟨_, _, _, _, he, _⟩ | ⟨_, _, _, _, he, _⟩ | ⟨_, _, bb, _, _, he, he', hr, hc, hs⟩
  · rw [he]; exact Ty.sub_refl _
  · cases he
  · cases he
  · cases he; cases he'
    have hl := Tys.len_of_sub hs
    have hS : (Ty.mu 0 b (Tys.ids ts.len)).cov = true := by
      simp [Ty.cov, hc, Tys.ids, Tys.ids_go_cov]
    have hB := Ty.cov_rsubst hS b hc
    simp only [Ty.unfold, ← hl]
    exact Ty.sub_trans (Ty.tsubst_mono ts (Ty.sub_shift_le hr _ hB))
      (Ty.tsubst_mono_arg hs _ (Ty.cov_shift r' _ hB))

/-! # 5. anchor をスキームで読む（mut を持つ型引数の callM）

callM は Def の region 0（呼び手空間）を anchor a へ、k + 1 を k + 1 + d へ写す（renR a d）。anchor は仮引数の mut の位置
（region 0 の mut の slice）に対応する実引数の region。今の本体は、代入した後の仮引数で anchor を読み、代入した後に写す。
B1 では型引数が絶対座標なので、どちらも代入の前のスキームで行う -/

mutual
def Ty.renR (a d : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
  | .slice m r t => .slice m (if r = 0 then a else r + d) (t.renR a d)
  | .prod x y => .prod (x.renR a d) (y.renR a d)
  | .fn p q => .fn p q
  | .rvar i => .rvar i
  | .mu r b ts => .mu (if r = 0 then a else r + d) b (ts.renR a d)
def Tys.renR (a d : Nat) : Tys → Tys
  | .nil => .nil
  | .cons t ts => .cons (t.renR a d) (ts.renR a d)
end

def Ty.isMut0 : Ty → Bool
  | .slice m r _ => m && r == 0
  | _ => false

def Ty.mutTop : Ty → Option Nat
  | .slice m r _ => if m then some r else none
  | _ => none

def Ty.anchorOf : Ty → Ty → Option Nat
  | .prod l r, .prod l' r' => (Ty.anchorOf l l').or (Ty.anchorOf r r')
  | .prod _ _, _ => none
  | p, ta => if p.isMut0 then ta.mutTop else none

/-- 今の形（代入してから anchor を読み、代入してから写す）の callM の前提 -/
def callMOld (p : Ty) (ts : Tys) (ta : Ty) (d : Nat) : Bool :=
  match Ty.anchorOf (p.tsubst ts) ta with
  | some a => decide (a ≤ d) && ta.sub (((p.tsubst ts)).renR a d)
  | none => ta.sub ((p.tsubst ts).renR d d)

/-- B1 の形（スキームで anchor を読み、写してから代入する）の callM の前提 -/
def callMNew (p : Ty) (ts : Tys) (ta : Ty) (d : Nat) : Bool :=
  match Ty.anchorOf p ta with
  | some a => decide (a ≤ d) && ta.sub ((p.renR a d).tsubst ts)
  | none => ta.sub ((p.renR d d).tsubst ts)

/-- `func keep2[T](x T, mut y []int)`: 仮引数は (T, region 0 の mut の slice) -/
def keepP : Ty := .prod (.tvar 0) (.slice true 0 .int)
def mutS (r : Nat) : Ty := .slice true r .int

/-- 呼び手の深さ 4（region 0..3）。x は region 0 の mut の slice（T = mut []int@0）、y は region 2 の mut の slice -/
example : callMOld keepP (.cons (mutS 0) .nil) (.prod (mutS 0) (mutS 2)) 3 = false := by decide
example : callMNew keepP (.cons (mutS 0) .nil) (.prod (mutS 0) (mutS 2)) 3 = true := by decide

/-- T = mut []int@1: 今の形は T の region 1 を写像で 1 + d（呼ばれた側のフレーム）へ動かしてしまう。B1 の形は動かさない -/
example : callMOld keepP (.cons (mutS 1) .nil) (.prod (mutS 1) (mutS 2)) 3 = false := by decide
example : callMNew keepP (.cons (mutS 1) .nil) (.prod (mutS 1) (mutS 2)) 3 = true := by decide

/-- スキームの型変数は mut の位置にならない（B1 の形で anchor は型引数に依らない） -/
theorem anchor_tvar (i : Nat) (ta : Ty) : Ty.anchorOf (.tvar i) ta = none := rfl

/-- mut の型引数の region は写像で動かない（写してから代入するので、型引数は写像を受けない） -/
theorem tsubst_after_renR (a d : Nat) (ts : Tys) (i : Nat) : ((Ty.tvar i).renR a d).tsubst ts = ts.look i := rfl

end R3
