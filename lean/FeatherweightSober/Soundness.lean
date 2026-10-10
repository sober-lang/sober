import FeatherweightSober.MachineTy
import FeatherweightSober.Fam
import FeatherweightSober.TSubst
import FeatherweightSober.Ren

/-!
# 型健全性（段 3c）: canonical forms → preservation → progress → soundness

- 定理 1（領域安全）は progress に吸収: 解放済み region への deref は Ψ に無いので
  型が付かず、well-typed な機械状態は「最終状態・panic・recv 待ち・次の 1 歩」のどれか
- 定理 2（データ競合自由）の核は 2 つ:
  - `par_step_commute` — **チャネルに触れない**（K を変えない）タスクの 1 歩は可換。
    チャネル操作は同期点なので可換性を主張しない — 順序依存はチャネルにだけ許す、が
    DRF の言明そのもの（ヒープアクセスは可換 = 競合なし、非決定性はチャネルに封じる）
  - `step_shared_stable` — well-typed な世界の 1 歩は共有プレフィクス
    `H.take b` を変えない。spawn 時のヒープコピーが物理共有と一致することの中身
- 段 3c: recv は空キューで待つ（blocked）。デッドロック自由は主張しない（型の性質ではない）。
  `Blocked` が待機状態を特徴づけ、`blocked_no_step` が「待機 = 進めない」を言う
-/
namespace FS

/-! ## canonical forms -/

theorem canonical_int {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v .int) : ∃ n, v = .lit n := by
  cases hv <;> cases ht
  exact ⟨_, rfl⟩

/-- byte の値は範囲内の blit（byte の段 — []byte のセルを 1 バイトに詰める健全性の前提） -/
theorem canonical_byte {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v .byte) : ∃ n, v = .blit n ∧ 0 ≤ n ∧ n < 256 := by
  cases hv <;> cases ht
  exact ⟨_, rfl, ‹_›, ‹_›⟩

theorem canonical_f64 {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v .f64) : ∃ n, v = .flit n := by
  cases hv <;> cases ht
  exact ⟨_, rfl⟩

theorem canonical_bool {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v .bool) : v = .tt ∨ v = .ff := by
  cases hv <;> cases ht
  · exact .inl rfl
  · exact .inr rfl

theorem canonical_unit {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v .unit) : v = .triv := by
  cases hv <;> cases ht
  rfl

theorem canonical_opt {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr} {t : Ty}
    (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.opt t)) :
    v = .nil t ∨ ∃ w, v = .some w ∧ Value w := by
  cases hv <;> cases ht
  · exact .inl rfl
  · exact .inr ⟨_, rfl, by assumption⟩

theorem canonical_union {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {l r : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.union l r)) :
    (∃ w, v = .inl r w ∧ Value w) ∨ (∃ w, v = .inr l w ∧ Value w) := by
  cases hv <;> cases ht
  · exact .inl ⟨_, rfl, by assumption⟩
  · exact .inr ⟨_, rfl, by assumption⟩

theorem canonical_prod {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {l r : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.prod l r)) :
    ∃ a c, v = .pair a c ∧ Value a ∧ Value c ∧
      HasType Δ Ξ Ψ f b d Γ Λ a l ∧ HasType Δ Ξ Ψ f b d Γ Λ c r := by
  cases hv <;> cases ht
  exact ⟨_, _, rfl, by assumption, by assumption, by assumption, by assumption⟩

/-- ref の canonical form（round4: imm の型 region rt は上界 — 実 region r は r ≤ rt の存在。
mut は rt = r で正確） -/
theorem canonical_ref {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr} {m : Bool}
    {rt : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.ref m rt t)) :
    ∃ r a σ m', v = .loc r a ∧ Ψ[r]? = some σ ∧ σ[a]? = some (m', t) ∧ r < d ∧ r ≤ rt ∧
      (m = true → rt = r ∧ b ≤ r) ∧ (m = false → m' = false) := by
  cases hv <;> cases ht
  exact ⟨_, _, _, _, rfl, by assumption, by assumption, by assumption, by assumption,
    by assumption, by assumption⟩

/-- slice の canonical form: 値は slicev（実 region r ≤ 型 region rt、タグ mt = m）で、
slicev 規則の premises を持つ -/
theorem canonical_slice {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {m : Bool} {rt : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.slice m rt t)) :
    ∃ mt r base len, v = .slicev mt r base len ∧ mt = m ∧
      (∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
        (m = false → mk = false) ∧ Ty.sub tc t = true ∧ (m = true → tc = t)) ∧
      r < d ∧ r ≤ rt ∧ (m = true → rt = r ∧ b ≤ r) ∧
      (m = false → t.mutFree = true) ∧ (m = true → t.regionsBelow (r + 1) = true) := by
  cases hv <;> cases ht
  exact ⟨_, _, _, _, rfl, by assumption, by assumption, by assumption, by assumption,
    by assumption, by assumption, by assumption⟩

/-- map の canonical form: slice と同型（t はセル型） -/
theorem canonical_map {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {m : Bool} {rt : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.map m rt t)) :
    ∃ mt r base len, v = .mapv mt r base len ∧ mt = m ∧
      (∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
        (m = false → mk = false) ∧ Ty.sub tc t = true ∧ (m = true → tc = t)) ∧
      r < d ∧ r ≤ rt ∧ (m = true → rt = r ∧ b ≤ r) ∧
      (m = false → t.mutFree = true) ∧ (m = true → t.regionsBelow (r + 1) = true) := by
  cases hv <;> cases ht
  exact ⟨_, _, _, _, rfl, by assumption, by assumption, by assumption, by assumption,
    by assumption, by assumption, by assumption⟩

/-- 正確なセル型から slicev / mapv のセル条件（深い共変 — R4b-cov）を作る -/
theorem cells_exact {Ψ : StoreTy} {r base len : Nat} {m : Bool} {t : Ty}
    (h : ∀ k, k < len → ∃ ρ mk, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, t) ∧ (m = false → mk = false)) :
    ∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
      (m = false → mk = false) ∧ Ty.sub tc t = true ∧ (m = true → tc = t) := by
  intro k hk
  obtain ⟨ρ, mk, h1, h2, h3⟩ := h k hk
  exact ⟨ρ, mk, t, h1, h2, h3, Ty.sub_refl t, fun _ => rfl⟩

/-- mut のセル条件は正確一致（深い共変は imm だけ） -/
theorem cells_mut {Ψ : StoreTy} {r base len : Nat} {t : Ty}
    (h : ∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
      (true = false → mk = false) ∧ Ty.sub tc t = true ∧ (true = true → tc = t)) :
    ∀ k, k < len → ∃ ρ mk, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, t) := by
  intro k hk
  obtain ⟨ρ, mk, tc, h1, h2, -, -, h5⟩ := h k hk
  obtain rfl := h5 rfl
  exact ⟨ρ, mk, h1, h2⟩

/-- mut のセル条件を正確一致の旧形（タグ条件つき）へ戻す -/
theorem cells_mut3 {Ψ : StoreTy} {r base len : Nat} {t : Ty}
    (h : ∀ k, k < len → ∃ ρ mk tc, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, tc) ∧
      (true = false → mk = false) ∧ Ty.sub tc t = true ∧ (true = true → tc = t)) :
    ∀ k, k < len → ∃ ρ mk, Ψ[r]? = some ρ ∧ ρ[base + k]? = some (mk, t) ∧ (true = false → mk = false) := by
  intro k hk
  obtain ⟨ρ, mk, tc, h1, h2, h3, -, h5⟩ := h k hk
  obtain rfl := h5 rfl
  exact ⟨ρ, mk, h1, h2, h3⟩

/-- chan の canonical form: 値は chanV で、Ξ のエントリ (Ψc, t)（rc = Ψc.length）を持ち、
この世界はスナップショットと一致（`Ψ.take rc = Ψc`）し、rc は床以下 -/
theorem canonical_chan {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {rc : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.chan rc t)) :
    ∃ c Ψc, v = .chanV c ∧ Ξ.ch[c]? = some (Ψc, t) ∧ Ψc.length = rc ∧
      Ψ.take rc = Ψc ∧ rc ≤ f := by
  cases hv <;> cases ht
  exact ⟨_, _, rfl, by assumption, rfl, by assumption, by assumption⟩

/-- scope の札の canonical form（段 6 P1）: 値は scopeV で、家の region はこの世界のもの -/
theorem canonical_scope {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {rs : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.own .scope rs t)) :
    v = .scopeV rs t ∧ b ≤ rs ∧ rs < d := by
  cases hv <;> cases ht
  exact ⟨rfl, by assumption, by assumption⟩

/-- handle の canonical form（段 6 P1）: 値は taskV で、世界の子の表が結果型を与える -/
theorem canonical_task {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {rs : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.own .task rs t)) :
    ∃ n, v = .taskV rs n ∧ b ≤ rs ∧ rs < d ∧ Ξ.tk[n]? = some (rs, t) := by
  cases hv <;> cases ht
  exact ⟨_, rfl, by assumption, by assumption, by assumption⟩

/-- 送り端の canonical form（段 6 P1） -/
theorem canonical_tx {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {r : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.own .tx r t)) :
    ∃ p k, v = .epV p k true r ∧ b ≤ r ∧ r < d ∧ Ξ.ep.lookup (p, k) = some (t.relocR 0) := by
  cases hv <;> cases ht
  exact ⟨_, _, rfl, by assumption, by assumption, by assumption⟩

/-- 受け端の canonical form（段 6 P1） -/
theorem canonical_rx {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {r : Nat} {t : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.own .rx r t)) :
    ∃ p k, v = .epV p k false r ∧ b ≤ r ∧ r < d ∧ Ξ.ep.lookup (p, k) = some (t.relocR 0) := by
  cases hv <;> cases ht
  exact ⟨_, _, rfl, by assumption, by assumption, by assumption⟩

/-- fn の canonical form（V3-1）: 値は fnref で、関数表のシグネチャが型と一致する -/
theorem canonical_fn {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {v : Expr}
    {p r : Ty} (hv : Value v) (ht : HasType Δ Ξ Ψ f b d Γ Λ v (.fn p r)) :
    ∃ fn ts dfn, v = .fnref fn ts ∧ Δ[fn]? = some dfn ∧ ts.length = dfn.tparams ∧
      Ty.tyArgsOk ts = true ∧ (dfn.inst ts).param = p ∧ (dfn.inst ts).ret = r := by
  cases hv <;> cases ht
  exact ⟨_, _, _, rfl, by assumption, by assumption, by assumption, rfl, rfl⟩

/-! ## relocate の保存（round4 の境界コピー） -/

/-- prefix 内の drop-take は append で安定（concat の同一 region ソースで使う） -/
theorem drop_take_append_left {α : Type} (l1 l2 : List α) {b n : Nat}
    (h : b + n ≤ l1.length) :
    ((l1 ++ l2).drop b).take n = (l1.drop b).take n := by
  apply List.ext_getElem?
  intro i
  by_cases hi : i < n
  · rw [List.getElem?_take_of_lt hi, List.getElem?_take_of_lt hi,
      List.getElem?_drop, List.getElem?_drop,
      List.getElem?_append_left (by omega)]
  · rw [List.getElem?_take_eq_none (by omega), List.getElem?_take_eq_none (by omega)]

/-- coerceTo は値性を保つ（注釈だけの構造ウォーク） -/
theorem Value.coerceTo {v : Expr} (hv : Value v) : ∀ t : Ty, Value (Expr.coerceTo t v) := by
  induction hv with
  | some _ ih => intro t; cases t <;> simp only [Expr.coerceTo] <;> first | exact .some (ih _) | exact .some ‹_›
  | inl r _ ih => intro t; cases t <;> simp only [Expr.coerceTo] <;> first | exact .inl _ (ih _) | exact .inl _ ‹_›
  | inr l _ ih => intro t; cases t <;> simp only [Expr.coerceTo] <;> first | exact .inr _ (ih _) | exact .inr _ ‹_›
  | pair _ _ iha ihb =>
    intro t; cases t <;> simp only [Expr.coerceTo] <;> first | exact .pair (iha _) (ihb _) | exact .pair ‹_› ‹_›
  | nil t0 => intro t; cases t <;> simp only [Expr.coerceTo] <;> exact .nil _
  | lit n => intro t; cases t <;> exact .lit n
  | blit h1 h2 => intro t; cases t <;> exact .blit h1 h2
  | flit n => intro t; cases t <;> exact .flit n
  | tt => intro t; cases t <;> exact .tt
  | ff => intro t; cases t <;> exact .ff
  | triv => intro t; cases t <;> exact .triv
  | loc r a => intro t; cases t <;> exact .loc r a
  | slicev mt r base len => intro t; cases t <;> exact .slicev mt r base len
  | mapv mt r base len => intro t; cases t <;> exact .mapv mt r base len
  | chanV c => intro t; cases t <;> exact .chanV c
  | fnref fn ts => intro t; cases t <;> exact .fnref fn ts
  | scopeV rs ε => intro t; cases t <;> exact .scopeV rs ε
  | taskV rs n => intro t; cases t <;> exact .taskV rs n
  | epV p k b r => intro t; cases t <;> exact .epV p k b r

/-- 注釈を持たない型への coerceTo は恒等（R4b-cov: 注釈なしの読み出しは書き換え不要） -/
theorem Expr.coerceTo_annFree : ∀ {b : Ty} (v : Expr), b.annFree = true → Expr.coerceTo b v = v
  | .prod l r, v, h => by
    cases v with
    | pair a c =>
      simp only [Ty.annFree, Bool.and_eq_true] at h
      simp only [Expr.coerceTo]
      rw [Expr.coerceTo_annFree a h.1, Expr.coerceTo_annFree c h.2]
    | _ => rfl
  | .opt _, _, h => by simp [Ty.annFree] at h
  | .union _ _, _, h => by simp [Ty.annFree] at h
  | .int, v, _ => by cases v <;> rfl
  | .tvar _, v, _ => by cases v <;> rfl
  | .bool, v, _ => by cases v <;> rfl
  | .byte, v, _ => by cases v <;> rfl
  | .f64, v, _ => by cases v <;> rfl
  | .unit, v, _ => by cases v <;> rfl
  | .ref _ _ _, v, _ => by cases v <;> rfl
  | .slice _ _ _, v, _ => by cases v <;> rfl
  | .map _ _ _, v, _ => by cases v <;> rfl
  | .chan _ _, v, _ => by cases v <;> rfl
  | .own _ _ _, v, _ => by cases v <;> rfl
  | .fn _ _, v, _ => by cases v <;> rfl

/-- 読み出しの保存（R4b-cov A-2）: セル型 tc ≤ 要素型 t'（mut なら正確）の値を、読み出しの注釈 ot で結果型 t へ -/
theorem read_ok {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b D : Nat} {Γ : Ctx} {Λ : LCtx} {v : Expr}
    {tc t' t : Ty} {m : Bool} {ot : Option Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b D Γ Λ v tc)
    (hsc : Ty.sub tc t' = true) (hex : m = true → tc = t') (hrd : Ty.readAs m ot t' = some t) :
    Value (Expr.coerceOpt ot v) ∧ HasType Δ Ξ Ψ f b D Γ Λ (Expr.coerceOpt ot v) t := by
  cases ot with
  | none =>
    simp only [Ty.readAs] at hrd
    split at hrd <;> cases hrd
    rename_i hc
    simp only [Expr.coerceOpt]
    cases m with
    | true => obtain rfl := hex rfl; exact ⟨hv, he⟩
    | false =>
      simp only [Bool.false_or] at hc
      obtain ⟨hv', he'⟩ := HasType.value_coerce hv he hsc
      rw [Expr.coerceTo_annFree v hc] at hv' he'
      exact ⟨hv', he'⟩
  | some ta =>
    simp only [Ty.readAs] at hrd
    split at hrd <;> cases hrd
    rename_i hc
    simp only [Expr.coerceOpt]
    exact HasType.value_coerce hv he (Ty.sub_trans hsc hc)

/-! ## 深い relocate（R4a）の部品 -/

/-- セル列を region k の末尾へ連続に積む（heapOk_append1 の列版）。全セルは imm・型 t・take (k+1) で型付く -/
theorem heapOk_append_list {Δ : Defs} {Ξ : ChanTy} {b k : Nat} {t : Ty}
    (hbk : b ≤ k) (hbt : t.regionsBelow (k + 1) = true) (hmf : t.mutFree = true) :
    ∀ (cs : List (Bool × Expr)) {Ψ : StoreTy} {H : Heap} {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)},
      HeapOk Δ Ξ b Ψ H → H[k]? = some ρ → Ψ[k]? = some σ →
      (∀ c ∈ cs, c.1 = false ∧ Value c.2 ∧ HasType Δ Ξ (Ψ.take (k + 1)) b b (k + 1) [] [] c.2 t) →
      HeapOk Δ Ξ b (Ψ.set k (σ ++ cs.map (fun _ => (false, t)))) (H.set k (ρ ++ cs)) := by
  intro cs
  induction cs with
  | nil =>
    intro Ψ H ρ σ hH hρ hσ _
    simp only [List.map_nil, List.append_nil]
    have hΨ : Ψ.set k σ = Ψ := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hσ).1]
        exact hσ.symm
      · rw [List.getElem?_set_ne (by omega)]
    have hHe : H.set k ρ = H := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hρ).1]
        exact hρ.symm
      · rw [List.getElem?_set_ne (by omega)]
    rw [hΨ, hHe]
    exact hH
  | cons c cs ih =>
    intro Ψ H ρ σ hH hρ hσ hcs
    obtain ⟨hc1, hcv, hct⟩ := hcs c (List.mem_cons_self ..)
    obtain ⟨m, w⟩ := c
    simp only at hc1 hcv hct
    subst hc1
    have hH1 := heapOk_append1 (m := false) hH hρ hσ hbk hcv hct hbt (fun _ => hmf)
    have hkΨ : k < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
    have hkH : k < H.length := by rw [hH.len]; omega
    have hle : StoreLE Ψ (Ψ.set k (σ ++ [(false, t)])) := storeLE_set_concat hσ (false, t)
    have h2 := ih (Ψ := Ψ.set k (σ ++ [(false, t)])) (H := H.set k (ρ ++ [(false, w)]))
      (ρ := ρ ++ [(false, w)]) (σ := σ ++ [(false, t)]) hH1
      (List.getElem?_set_self hkH) (List.getElem?_set_self hkΨ) (fun c' hc' => by
        obtain ⟨h1, h2, h3⟩ := hcs c' (List.mem_cons_of_mem _ hc')
        refine ⟨h1, h2, h3.store_mono (hle.take_take (k + 1)) ?_⟩
        intro n hn _
        rw [List.take_take, List.take_take, Nat.min_eq_left (by omega : n ≤ k + 1),
          take_set_of_le (by omega : n ≤ k)])
    simp only [List.set_set, List.append_assoc, List.singleton_append, List.map_cons] at h2 ⊢
    exact h2

/-- 深い relocate の結果の束（ストア・ヒープの伸びは region d だけ） -/
def RelocOut (Δ : Defs) (Ξ : ChanTy) (b d : Nat) (Ψ : StoreTy) (H : Heap) (Ψ' : StoreTy) (H' : Heap) : Prop :=
  HeapOk Δ Ξ b Ψ' H' ∧ Ψ'.length = d + 2 ∧ StoreLE Ψ Ψ' ∧ Ψ'.take d = Ψ.take d ∧ H'.take d = H.take d

theorem RelocOut.trans {Δ : Defs} {Ξ : ChanTy} {b d : Nat} {Ψ Ψ1 Ψ2 : StoreTy} {H H1 H2 : Heap}
    (h1 : RelocOut Δ Ξ b d Ψ H Ψ1 H1) (h2 : RelocOut Δ Ξ b d Ψ1 H1 Ψ2 H2) : RelocOut Δ Ξ b d Ψ H Ψ2 H2 :=
  ⟨h2.1, h2.2.1, h1.2.2.1.trans h2.2.2.1, h2.2.2.2.1.trans h1.2.2.2.1, h2.2.2.2.2.trans h1.2.2.2.2⟩

/-- relocA の保存拡大: anchor = d なら relocR d -/
theorem Ty.relocA_top (d : Nat) : ∀ t : Ty, t.relocA d d = t.relocR d
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d t]
  | .union l r => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d l, Ty.relocA_top d r]
  | .prod l r => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d l, Ty.relocA_top d r]
  | .ref false r t => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d t]
  | .slice false r t => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d t]
  | .map false r t => by simp [Ty.relocA, Ty.relocR, Ty.relocA_top d t]
  | .ref true r t => by simp [Ty.relocA, Ty.relocR, Ty.renR_top, rmap_top]
  | .slice true r t => by simp [Ty.relocA, Ty.relocR, Ty.renR_top, rmap_top]
  | .map true r t => by simp [Ty.relocA, Ty.relocR, Ty.renR_top, rmap_top]
  | .chan rc t => by simp [Ty.relocA, Ty.relocR, Ty.renR_top, rmap_top]
  | .own k r t => by simp [Ty.relocA, Ty.relocR, Ty.renR_top, rmap_top]
  | .fn p r => rfl

/-- sub の右辺からの逆向き（mut 参照 / コンテナは正確一致、prod は成分へ） -/
theorem Ty.sub_prod_invR {ta l r : Ty} (hs : Ty.sub ta (.prod l r) = true) :
    ∃ l' r', ta = .prod l' r' ∧ Ty.sub l' l = true ∧ Ty.sub r' r = true := by
  cases ta <;> simp [Ty.sub] at hs
  exact ⟨_, _, rfl, hs.1, hs.2⟩

/-! ## keysm の段の部品 -/

theorem Ty.keyOk_mutFree {k : Ty} (h : k.keyOk = true) : k.mutFree = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.mutFree]

theorem Ty.keyOk_annFree {k : Ty} (h : k.keyOk = true) : k.annFree = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.annFree]

/-- liveKeys の要素は、覆う範囲の生きたセル（pair ke (some w)）のキー -/
theorem mem_liveKeys {ρ : List (Bool × Expr)} {base : Nat} {ke : Expr} :
    ∀ {n : Nat}, ke ∈ liveKeys ρ base n →
      ∃ j, j < n ∧ ∃ mj w, ρ[base + j]? = some (mj, Expr.pair ke (Expr.some w))
  | 0, h => by simp [liveKeys] at h
  | n + 1, h => by
    simp only [liveKeys, List.mem_append] at h
    rcases h with h | h
    · obtain ⟨j, hj, rest⟩ := mem_liveKeys h
      exact ⟨j, by omega, rest⟩
    · split at h
      · rename_i mj ke' w hc
        simp only [List.mem_singleton] at h
        subst h
        exact ⟨n, by omega, mj, w, hc⟩
      · simp at h

/-- keysm が積むセル: map の region r のセルから取り出したキー。imm・型 kt で take (k+1) に型付く
（キー型は keyOk = 注釈不要なので、セル型 tc ≤ prod kt _ の成分から coerce なしで kt へ緩められる） -/
theorem liveKeys_typed {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {r base len k : Nat} {m : Bool} {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {kt t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hρ : H[r]? = some ρ) (hσ : Ψ[r]? = some σ)
    (hk : ∀ j, j < len → ∃ σ' mk tc, Ψ[r]? = some σ' ∧ σ'[base + j]? = some (mk, tc) ∧
        (m = false → mk = false) ∧ Ty.sub tc (.prod kt (.opt t)) = true ∧
        (m = true → tc = .prod kt (.opt t)))
    (hmb : m = true → b ≤ r) (hrk : r ≤ k) (hko : kt.keyOk = true) :
    ∀ c ∈ (liveKeys ρ base len).map (fun ke => (false, ke)),
      c.1 = false ∧ Value c.2 ∧ HasType Δ Ξ (Ψ.take (k + 1)) b b (k + 1) [] [] c.2 kt := by
  intro c hc
  simp only [List.mem_map] at hc
  obtain ⟨ke, hke, rfl⟩ := hc
  obtain ⟨j, hj, mj, w, hcell⟩ := mem_liveKeys hke
  obtain ⟨σ', mk, tc, hσ', hσc, hmm, hsub, -⟩ := hk j hj
  have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
  subst hss
  have hbr : mk = false ∨ b ≤ r := by
    cases m with
    | false => exact .inl (hmm rfl)
    | true => exact .inr (hmb rfl)
  obtain ⟨hv, ht⟩ := hH.typed r ρ σ' (base + j) mj _ mk tc hρ hσ' hcell hσc hbr
  obtain ⟨l', r', rfl, hsl, -⟩ := Ty.sub_prod_invR hsub
  obtain ⟨a, c, hac, hva, -, hta, -⟩ := canonical_prod hv ht
  obtain ⟨rfl, -⟩ := Expr.pair.inj hac
  obtain ⟨-, htk⟩ := HasType.value_coerce hva hta hsl
  rw [Expr.coerceTo_annFree _ (Ty.keyOk_annFree hko)] at htk
  refine ⟨rfl, hva, ?_⟩
  exact HasType.value_depth_weaken hva
    (htk.store_mono (storeLE_take_le Ψ (by omega)) (storePre_take_le Ψ (by omega))) (by omega)

theorem Ty.sub_mut_invR {ta p : Ty} (hp : p.isMut0 = true) {a d : Nat}
    (hs : Ty.sub ta (p.renR a d) = true) : ta = p.renR a d := by
  cases p <;> simp [Ty.isMut0] at hp
  all_goals (obtain ⟨rfl, rfl⟩ := hp; cases ta <;> simp_all [Ty.sub, Ty.renR])

/-- 実行時の anchor（値の mut 位置の region）は型の anchor と一致する（mut は正確 region） -/
theorem anchorV_eq {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b D : Nat} {Γ : Ctx} {a d : Nat} :
    ∀ (p : Ty) {v : Expr} {ta : Ty}, Value v → HasType Δ Ξ Ψ f b D Γ Λ v ta →
      Ty.sub ta (p.renR a d) = true → Expr.anchorV p v = Ty.anchorOf p ta := by
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro v ta hv he hs
    simp only [Ty.renR] at hs
    obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.sub_prod_invR hs
    obtain ⟨x, y, rfl, hvx, hvy, htx, hty⟩ := canonical_prod hv he
    simp only [Expr.anchorV, Ty.anchorOf, ihl hvx htx hsl, ihr hvy hty hsr]
  | _ =>
    intro v ta hv he hs
    simp only [Expr.anchorV, Ty.anchorOf]
    split
    · rename_i hm
      have hta := Ty.sub_mut_invR hm hs
      subst hta
      first
        | (simp [Ty.isMut0] at hm; done)
        | (simp only [Ty.isMut0, Bool.and_eq_true, beq_iff_eq] at hm
           obtain ⟨rfl, rfl⟩ := hm
           first
             | (obtain ⟨r, x, σ, m', rfl, -, -, -, -, hmut, -⟩ := canonical_ref hv he
                have h := (hmut rfl).1; simp only [rmap] at h
                simp [Expr.mutTopV, Ty.mutTop, Ty.renR, rmap]; omega)
             | (obtain ⟨mt, r, base, len, rfl, -, -, -, -, hmut, -, -⟩ := canonical_slice hv he
                have h := (hmut rfl).1; simp only [rmap] at h
                simp [Expr.mutTopV, Ty.mutTop, Ty.renR, rmap]; omega)
             | (obtain ⟨mt, r, base, len, rfl, -, -, -, -, hmut, -, -⟩ := canonical_map hv he
                have h := (hmut rfl).1; simp only [rmap] at h
                simp [Expr.mutTopV, Ty.mutTop, Ty.renR, rmap]; omega))
    · rfl

/-! ## 脱出の境界コピー（R4b α — jump の巻き戻しで捨てる region からの survivor コピー） -/

theorem heapOk_take {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} (n : Nat)
    (hH : HeapOk Δ Ξ b Ψ H) : HeapOk Δ Ξ b (Ψ.take n) (H.take n) := by
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ σ h1 h2
    exact hH.storeLen r ρ σ (getElem?_take_some h1).2 (getElem?_take_some h2).2
  · intro r ρ σ a mv v m t h1 h2 h3 h4
    exact hH.tags r ρ σ a mv v m t (getElem?_take_some h1).2 (getElem?_take_some h2).2 h3 h4
  · intro r ρ σ a mv v m t h1 h2 h3 h4 hcond
    obtain ⟨hr, h1'⟩ := getElem?_take_some h1
    obtain ⟨-, h2'⟩ := getElem?_take_some h2
    obtain ⟨hv, ht⟩ := hH.typed r ρ σ a mv v m t h1' h2' h3 h4 hcond
    refine ⟨hv, ?_⟩
    rwa [List.take_take, Nat.min_eq_left (by omega : r + 1 ≤ n)]
  · intro r σ a m t h2 h3
    exact hH.tyBelow r σ a m t (getElem?_take_some h2).2 h3
  · intro r σ a t h2 h3
    exact hH.immMutFree r σ a t (getElem?_take_some h2).2 h3

theorem Ty.clampR_of_regionsBelow {k : Nat} : ∀ {t : Ty}, t.regionsBelow (k + 1) = true → t.clampR k = t
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.regionsBelow] at h
    simp [Ty.clampR, Ty.clampR_of_regionsBelow h]
  | .union l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.clampR, Ty.clampR_of_regionsBelow h.1, Ty.clampR_of_regionsBelow h.2]
  | .prod l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.clampR, Ty.clampR_of_regionsBelow h.1, Ty.clampR_of_regionsBelow h.2]
  | .ref m r t, h => by
    cases m
    · simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
      simp [Ty.clampR, Ty.clampR_of_regionsBelow h.2, Nat.min_eq_left (by omega : r ≤ k)]
    · rfl
  | .slice m r t, h => by
    cases m
    · simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
      simp [Ty.clampR, Ty.clampR_of_regionsBelow h.2, Nat.min_eq_left (by omega : r ≤ k)]
    · rfl
  | .map m r t, h => by
    cases m
    · simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
      simp [Ty.clampR, Ty.clampR_of_regionsBelow h.2, Nat.min_eq_left (by omega : r ≤ k)]
    · rfl
  | .chan _ _, _ => rfl
  | .own _ _ _, _ => rfl
  | .fn _ _, _ => rfl

theorem Ty.clampR_mutFree {k : Nat} : ∀ {t : Ty}, t.mutFree = true → (t.clampR k).mutFree = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.mutFree] at h
    simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h]
  | .union l r, h => by
    simp only [Ty.mutFree, Bool.and_eq_true] at h
    simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h.1, Ty.clampR_mutFree h.2]
  | .prod l r, h => by
    simp only [Ty.mutFree, Bool.and_eq_true] at h
    simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h.1, Ty.clampR_mutFree h.2]
  | .ref m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h]
    · simp [Ty.mutFree] at h
  | .slice m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h]
    · simp [Ty.mutFree] at h
  | .map m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.clampR, Ty.mutFree, Ty.clampR_mutFree h]
    · simp [Ty.mutFree] at h
  | .chan _ _, _ => rfl
  | .fn _ _, _ => rfl

/-- 締めた型の sub の逆向き: 葉（コンテナ / 直積 / opt / union 以外、または mut）は締めで変わらない -/
theorem Ty.clampR_sub_leaf {k : Nat} {T W : Ty}
    (hW : ∀ o, W ≠ .opt o) (hU : ∀ l r, W ≠ .union l r) (hP : ∀ l r, W ≠ .prod l r)
    (hR : ∀ r t, W ≠ .ref false r t) (hS : ∀ r t, W ≠ .slice false r t) (hM : ∀ r t, W ≠ .map false r t)
    (hs : Ty.sub (T.clampR k) W = true) : T = W := by
  cases T with
  | opt t => cases W <;> simp_all [Ty.clampR, Ty.sub]
  | union l r => cases W <;> simp_all [Ty.clampR, Ty.sub]
  | prod l r => cases W <;> simp_all [Ty.clampR, Ty.sub]
  | ref m r t => cases m <;> cases W <;> simp_all [Ty.clampR, Ty.sub]
  | slice m r t => cases m <;> cases W <;> simp_all [Ty.clampR, Ty.sub]
  | map m r t => cases m <;> cases W <;> simp_all [Ty.clampR, Ty.sub]
  | _ => cases W <;> simp_all [Ty.clampR, Ty.sub]

theorem Ty.clampR_sub_opt {k : Nat} {T W : Ty} (hs : Ty.sub (T.clampR k) (.opt W) = true) :
    ∃ T', T = .opt T' ∧ Ty.sub (T'.clampR k) W = true := by
  cases T with
  | opt t => exact ⟨t, rfl, by simpa [Ty.clampR, Ty.sub] using hs⟩
  | ref m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

theorem Ty.clampR_sub_union {k : Nat} {T l r : Ty} (hs : Ty.sub (T.clampR k) (.union l r) = true) :
    ∃ l' r', T = .union l' r' ∧ Ty.sub (l'.clampR k) l = true ∧ Ty.sub (r'.clampR k) r = true := by
  cases T with
  | union a c => exact ⟨a, c, rfl, by simp_all [Ty.clampR, Ty.sub]⟩
  | ref m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

theorem Ty.clampR_sub_prod {k : Nat} {T l r : Ty} (hs : Ty.sub (T.clampR k) (.prod l r) = true) :
    ∃ l' r', T = .prod l' r' ∧ Ty.sub (l'.clampR k) l = true ∧ Ty.sub (r'.clampR k) r = true := by
  cases T with
  | prod a c => exact ⟨a, c, rfl, by simp_all [Ty.clampR, Ty.sub]⟩
  | ref m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

theorem Ty.clampR_sub_ref {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.clampR k) (.ref false rW W) = true) :
    ∃ r e, T = .ref false r e ∧ min r k ≤ rW ∧ e.clampR k = W := by
  cases T with
  | ref m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.clampR, Ty.sub] using hs⟩
    · simp [Ty.clampR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

theorem Ty.clampR_sub_slice {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.clampR k) (.slice false rW W) = true) :
    ∃ r e, T = .slice false r e ∧ min r k ≤ rW ∧ Ty.sub (e.clampR k) W = true := by
  cases T with
  | slice m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.clampR, Ty.sub] using hs⟩
    · simp [Ty.clampR, Ty.sub] at hs
  | ref m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

theorem Ty.clampR_sub_map {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.clampR k) (.map false rW W) = true) :
    ∃ r e, T = .map false r e ∧ min r k ≤ rW ∧ Ty.sub (e.clampR k) W = true := by
  cases T with
  | map m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.clampR, Ty.sub] using hs⟩
    · simp [Ty.clampR, Ty.sub] at hs
  | ref m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.clampR, Ty.sub] at hs
  | _ => simp [Ty.clampR, Ty.sub] at hs

/-- 締めは sub を保つ（深い共変のセル型 ≤ 要素型を、締めた後も比べられる） -/
theorem Ty.clampR_mono {k : Nat} : ∀ {a b : Ty}, Ty.sub a b = true → Ty.sub (a.clampR k) (b.clampR k) = true
  | .int, _, h => by obtain rfl := Ty.sub_int_inv h; exact Ty.sub_refl _
  | .tvar _, _, h => by obtain rfl := Ty.sub_tvar_inv h; exact Ty.sub_refl _
  | .bool, _, h => by obtain rfl := Ty.sub_bool_inv h; exact Ty.sub_refl _
  | .byte, _, h => by obtain rfl := Ty.sub_byte_inv h; exact Ty.sub_refl _
  | .f64, _, h => by obtain rfl := Ty.sub_f64_inv h; exact Ty.sub_refl _
  | .unit, _, h => by obtain rfl := Ty.sub_unit_inv h; exact Ty.sub_refl _
  | .chan _ _, _, h => by obtain rfl := Ty.sub_chan_inv h; exact Ty.sub_refl _
  | .own _ _ _, _, h => by obtain rfl := Ty.sub_own_inv h; exact Ty.sub_refl _
  | .fn _ _, _, h => by obtain rfl := Ty.sub_fn_inv h; exact Ty.sub_refl _
  | .ref true _ _, _, h => by obtain rfl := Ty.sub_refT_inv h; exact Ty.sub_refl _
  | .slice true _ _, _, h => by obtain rfl := Ty.sub_sliceT_inv h; exact Ty.sub_refl _
  | .map true _ _, _, h => by obtain rfl := Ty.sub_mapT_inv h; exact Ty.sub_refl _
  | .opt a, _, h => by
    obtain ⟨b, rfl, hb⟩ := Ty.sub_opt_inv h
    simp only [Ty.clampR, Ty.sub]; exact Ty.clampR_mono hb
  | .union a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_union_inv h
    simp only [Ty.clampR, Ty.sub, Bool.and_eq_true]; exact ⟨Ty.clampR_mono h1, Ty.clampR_mono h2⟩
  | .prod a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_prod_inv h
    simp only [Ty.clampR, Ty.sub, Bool.and_eq_true]; exact ⟨Ty.clampR_mono h1, Ty.clampR_mono h2⟩
  | .ref false r a, _, h => by
    obtain ⟨r', rfl, hr⟩ := Ty.sub_refF_inv h
    simp [Ty.clampR, Ty.sub]; omega
  | .slice false r a, _, h => by
    obtain ⟨r', b, rfl, hr, hab⟩ := Ty.sub_sliceF_inv h
    simp only [Ty.clampR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨by omega, Ty.clampR_mono hab⟩
  | .map false r a, _, h => by
    obtain ⟨r', b, rfl, hr, hab⟩ := Ty.sub_mapF_inv h
    simp only [Ty.clampR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨by omega, Ty.clampR_mono hab⟩

/-- sub は chan の有無を変えない（chan は正確一致） -/
theorem Ty.sub_chanFree : ∀ {a b : Ty}, Ty.sub a b = true → a.chanFree = b.chanFree
  | .int, _, h => by obtain rfl := Ty.sub_int_inv h; rfl
  | .tvar _, _, h => by obtain rfl := Ty.sub_tvar_inv h; rfl
  | .bool, _, h => by obtain rfl := Ty.sub_bool_inv h; rfl
  | .byte, _, h => by obtain rfl := Ty.sub_byte_inv h; rfl
  | .f64, _, h => by obtain rfl := Ty.sub_f64_inv h; rfl
  | .unit, _, h => by obtain rfl := Ty.sub_unit_inv h; rfl
  | .chan _ _, _, h => by obtain rfl := Ty.sub_chan_inv h; rfl
  | .own _ _ _, _, h => by obtain rfl := Ty.sub_own_inv h; rfl
  | .fn _ _, _, h => by obtain rfl := Ty.sub_fn_inv h; rfl
  | .ref true _ _, _, h => by obtain rfl := Ty.sub_refT_inv h; rfl
  | .slice true _ _, _, h => by obtain rfl := Ty.sub_sliceT_inv h; rfl
  | .map true _ _, _, h => by obtain rfl := Ty.sub_mapT_inv h; rfl
  | .opt a, _, h => by
    obtain ⟨b, rfl, hb⟩ := Ty.sub_opt_inv h
    simp only [Ty.chanFree]; exact Ty.sub_chanFree hb
  | .union a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_union_inv h
    simp only [Ty.chanFree]; rw [Ty.sub_chanFree h1, Ty.sub_chanFree h2]
  | .prod a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_prod_inv h
    simp only [Ty.chanFree]; rw [Ty.sub_chanFree h1, Ty.sub_chanFree h2]
  | .ref false r a, _, h => by obtain ⟨r', rfl, _⟩ := Ty.sub_refF_inv h; rfl
  | .slice false r a, _, h => by
    obtain ⟨r', b, rfl, _, hab⟩ := Ty.sub_sliceF_inv h
    simp only [Ty.chanFree]; exact Ty.sub_chanFree hab
  | .map false r a, _, h => by
    obtain ⟨r', b, rfl, _, hab⟩ := Ty.sub_mapF_inv h
    simp only [Ty.chanFree]; exact Ty.sub_chanFree hab

/-- 脱出の境界コピーの結果の束（ストアは lookup 保存で伸び、伸びるのは region k だけ — 床 b ≤ k 以下も k 未満も不変） -/
def RelocJ (Δ : Defs) (Ξ : ChanTy) (b k : Nat) (Ψ : StoreTy) (H : Heap) (Ψ' : StoreTy) (H' : Heap) : Prop :=
  HeapOk Δ Ξ b Ψ' H' ∧ Ψ'.length = Ψ.length ∧ StoreLE Ψ Ψ' ∧ Ψ'.take b = Ψ.take b ∧ H'.take b = H.take b ∧
    Ψ'.take k = Ψ.take k ∧ H'.take k = H.take k

theorem RelocJ.refl {Δ : Defs} {Ξ : ChanTy} {b k : Nat} {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) :
    RelocJ Δ Ξ b k Ψ H Ψ H := ⟨hH, rfl, .refl Ψ, rfl, rfl, rfl, rfl⟩

theorem RelocJ.trans {Δ : Defs} {Ξ : ChanTy} {b k : Nat} {Ψ Ψ1 Ψ2 : StoreTy} {H H1 H2 : Heap}
    (h1 : RelocJ Δ Ξ b k Ψ H Ψ1 H1) (h2 : RelocJ Δ Ξ b k Ψ1 H1 Ψ2 H2) : RelocJ Δ Ξ b k Ψ H Ψ2 H2 :=
  ⟨h2.1, h2.2.1.trans h1.2.1, h1.2.2.1.trans h2.2.2.1, h2.2.2.2.1.trans h1.2.2.2.1,
    h2.2.2.2.2.1.trans h1.2.2.2.2.1, h2.2.2.2.2.2.1.trans h1.2.2.2.2.2.1, h2.2.2.2.2.2.2.trans h1.2.2.2.2.2.2⟩

theorem relocJ_carry {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ Ψ' : StoreTy} {D0 : Nat} {v : Expr} {t : Ty}
    {Λ : LCtx} (hle : StoreLE Ψ Ψ') (htb : Ψ'.take b = Ψ.take b)
    (he : HasType Δ Ξ (Ψ.take D0) b b D0 [] Λ v t) : HasType Δ Ξ (Ψ'.take D0) b b D0 [] Λ v t := by
  refine he.store_mono (hle.take_take D0) (storePre_of_take_eq ?_)
  rw [List.take_take, List.take_take]
  exact take_eq_of_take_floor htb (by omega)

theorem take_take_k1 {Ψ : StoreTy} {D0 k : Nat} (h : k + 1 ≤ D0 ∨ D0 = Ψ.length) :
    (Ψ.take D0).take (k + 1) = Ψ.take (k + 1) := by
  rw [List.take_take]
  rcases h with h | h
  · rw [Nat.min_eq_left h]
  · subst h
    by_cases hk : k + 1 ≤ Ψ.length
    · rw [Nat.min_eq_left hk]
    · rw [Nat.min_eq_right (by omega), List.take_length, List.take_of_length_le (by omega)]

/-- 写しの帰納法の仮定（歩く型 W を固定、値の型 T は量化 — 深い共変でセルごとに型が違う） -/
def RelocIH (Δ : Defs) (Ξ : ChanTy) (b k : Nat) (W : Ty) : Prop :=
  ∀ {T : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap} {D0 : Nat},
    HeapOk Δ Ξ b Ψ H → D0 ≤ Ψ.length → (k + 1 ≤ D0 ∨ D0 = Ψ.length) → Value v →
    HasType Δ Ξ (Ψ.take D0) b b D0 [] [] v T → W.regionsBelow (k + 1) = true →
    Ty.sub (T.clampR k) W = true → (T.noClamp k = true ∨ (b ≤ k ∧ T.chanFree = true)) →
    ∃ H' Ψ' v', relocTo k W H v = some (H', v') ∧ Value v' ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
      HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] v' W

/-- セル列を順に写す（各セルは自分の型 T を持ち、締めると W 以下） -/
theorem relocListJ_ok {Δ : Defs} {Ξ : ChanTy} {b k : Nat} {W : Ty} {D0 : Nat} (ih : RelocIH Δ Ξ b k W)
    (hWb : W.regionsBelow (k + 1) = true) :
    ∀ (cs : List (Bool × Expr)) {Ψ : StoreTy} {H : Heap}, HeapOk Δ Ξ b Ψ H → D0 ≤ Ψ.length → k + 1 ≤ D0 →
      (∀ c ∈ cs, c.1 = false ∧ Value c.2 ∧ ∃ T, HasType Δ Ξ (Ψ.take D0) b b D0 [] [] c.2 T ∧
        Ty.sub (T.clampR k) W = true ∧ (T.noClamp k = true ∨ (b ≤ k ∧ T.chanFree = true))) →
      ∃ H' Ψ' cs', relocList (relocTo k W) H cs = some (H', cs') ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
        cs'.length = cs.length ∧
        ∀ c ∈ cs', c.1 = false ∧ Value c.2 ∧ HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] c.2 W := by
  intro cs
  induction cs with
  | nil =>
    intro Ψ H hH _ _ _
    exact ⟨H, Ψ, [], rfl, RelocJ.refl hH, rfl, fun c hc => by simp at hc⟩
  | cons c cs ihc =>
    intro Ψ H hH hD hk hcs
    obtain ⟨m, w⟩ := c
    obtain ⟨hm, hwv, T, hwt, hsT, hcT⟩ := hcs (m, w) (List.mem_cons_self ..)
    simp only at hm hwv hwt
    obtain ⟨H1, Ψ1, w', hrel, hwv', hout1, hwt'⟩ := ih hH hD (.inl hk) hwv hwt hWb hsT hcT
    obtain ⟨H2, Ψ2, cs', hrel2, hout2, hlen', hcs'⟩ := ihc hout1.1 (by rw [hout1.2.1]; exact hD) hk
      (fun c' hc' => by
        obtain ⟨h1, h2, T', h3, h4, h5⟩ := hcs c' (List.mem_cons_of_mem _ hc')
        exact ⟨h1, h2, T', relocJ_carry hout1.2.2.1 hout1.2.2.2.1 h3, h4, h5⟩)
    refine ⟨H2, Ψ2, (m, w') :: cs', ?_, hout1.trans hout2, by simp [hlen'], ?_⟩
    · simp [relocList, hrel, hrel2]
    · intro c hc
      rcases List.mem_cons.mp hc with rfl | hc
      · exact ⟨hm, hwv', relocJ_carry hout2.2.2.1 hout2.2.2.2.1 hwt'⟩
      · exact hcs' c hc

/-- region r（> k）の [base, base + len) の imm セル列を、中身を写してから region k の末尾へ連続に積む
（セル j の型 tc_j は締めると W 以下 — 写した後のセルは型 W） -/
theorem reloc_cellsJ {Δ : Defs} {Ξ : ChanTy} {b k : Nat} {W : Ty} (hbk : b ≤ k)
    (hW : W.regionsBelow (k + 1) = true) (hmf : W.mutFree = true) (ih : RelocIH Δ Ξ b k W)
    {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) {r : Nat} (hkr : k < r) (hrl : r < Ψ.length)
    {ρs : List (Bool × Expr)} {σs : List (Bool × Ty)} (hρs : H[r]? = some ρs) (hσs : Ψ[r]? = some σs)
    {base len : Nat}
    (hk : ∀ j, j < len → ∃ tc, σs[base + j]? = some (false, tc) ∧ Ty.sub (tc.clampR k) W = true ∧
      tc.chanFree = true) :
    ∃ H1 cs ρd Ψ', relocList (relocTo k W) H ((ρs.drop base).take len) = some (H1, cs) ∧
      H1[k]? = some ρd ∧ RelocJ Δ Ξ b k Ψ H Ψ' (H1.set k (ρd ++ cs)) ∧ cs.length = len ∧
      ∀ j, j < len → ∃ σ', (Ψ'.take (k + 1))[k]? = some σ' ∧ σ'[ρd.length + j]? = some (false, W) := by
  have hslen : ρs.length = σs.length := hH.storeLen r ρs σs hρs hσs
  have hbl : len = 0 ∨ base + len ≤ σs.length := by
    rcases Nat.eq_zero_or_pos len with h | hpos
    · exact .inl h
    · obtain ⟨tc, hc, -⟩ := hk (len - 1) (by omega)
      have := (List.getElem?_eq_some_iff.mp hc).1
      exact .inr (by omega)
  have hcl : ((ρs.drop base).take len).length = len := by
    rcases hbl with h | h
    · subst h; simp
    · rw [List.length_take, List.length_drop]; omega
  have hcs : ∀ c ∈ (ρs.drop base).take len, c.1 = false ∧ Value c.2 ∧ ∃ T,
      HasType Δ Ξ (Ψ.take (r + 1)) b b (r + 1) [] [] c.2 T ∧ Ty.sub (T.clampR k) W = true ∧
      (T.noClamp k = true ∨ (b ≤ k ∧ T.chanFree = true)) := by
    intro c hc
    obtain ⟨j, hj, hcj⟩ := List.getElem_of_mem hc
    have hjl : j < len := by rw [hcl] at hj; exact hj
    obtain ⟨tc, hσk, hsc, hcf⟩ := hk j hjl
    have hρj : ρs[base + j]? = some c := by
      rw [← hcj, List.getElem_take, List.getElem_drop]
      exact List.getElem?_eq_getElem _
    obtain ⟨mc, w⟩ := c
    have htag := hH.tags r ρs σs (base + j) mc w false _ hρs hσs hρj hσk
    subst htag
    obtain ⟨hwv, hwt⟩ := hH.typed r ρs σs (base + j) false w false _ hρs hσs hρj hσk (.inl rfl)
    exact ⟨rfl, hwv, tc, hwt, hsc, .inr ⟨hbk, hcf⟩⟩
  obtain ⟨H1, Ψ1, cs, hrel, ⟨hH1, hlen1, hle1, htb1, htH1, htk1, htkH1⟩, hcsl, hcs'⟩ :=
    relocListJ_ok (D0 := r + 1) ih hW _ hH (by omega) (by omega) hcs
  have hH1l : H1.length = Ψ.length := by rw [hH1.len, hlen1]
  obtain ⟨ρd, hρd⟩ : ∃ ρd, H1[k]? = some ρd := ⟨_, List.getElem?_eq_getElem (by omega)⟩
  obtain ⟨σd, hσd⟩ : ∃ σd, Ψ1[k]? = some σd := ⟨_, List.getElem?_eq_getElem (by omega)⟩
  have hdl : ρd.length = σd.length := hH1.storeLen k ρd σd hρd hσd
  have hH' := heapOk_append_list hbk hW hmf cs hH1 hρd hσd hcs'
  refine ⟨H1, cs, ρd, Ψ1.set k (σd ++ cs.map (fun _ => (false, W))), hrel, hρd,
    ⟨hH', by simp [hlen1], hle1.trans (storeLE_set_concat_many hσd _),
      (take_set_of_le hbk _).trans htb1, (take_set_of_le hbk _).trans htH1,
      (take_set_of_le (Nat.le_refl k) _).trans htk1, (take_set_of_le (Nat.le_refl k) _).trans htkH1⟩,
    by rw [hcsl, hcl], ?_⟩
  intro j hj
  have hkΨ : k < Ψ1.length := by omega
  refine ⟨σd ++ cs.map (fun _ => (false, W)), ?_, ?_⟩
  · rw [List.getElem?_take_of_lt (by omega), List.getElem?_set_self hkΨ]
  · rw [hdl, List.getElem?_append_right (Nat.le_add_right _ _)]
    have hj0 : σd.length + j - σd.length = j := by omega
    have hjc : j < cs.length := by rw [hcsl, hcl]; exact hj
    rw [hj0, List.getElem?_map, List.getElem?_eq_getElem hjc]
    rfl

/-- 脱出の境界コピーの保存（R4b α / R4b-cov）: 世界 Ψ の値 v : T（深さ D0 で型付く）を、ラベルの型 W（T を k へ締めて
共変で緩めた型）に沿って relocTo k で写すと、(a) 成功し、(b) ストアは region k だけが lookup 保存で伸び、(c) 結果は
ラベルの世界（take (k + 1)、深さ k + 1）で W に型付く。k より深いコンテナは中身ごと region k へ積み直す（b ≤ k・
chan を持たないときだけ — jumpRel の第 2 腕）。締めで何も変わらない値（noClamp）はヒープを触らない。
imm のセル型は要素型の部分型（深い共変）なので、セルごとに型を量化して帰納する（RelocIH） -/
theorem relocTo_ok {Δ : Defs} {Ξ : ChanTy} {b k : Nat} : ∀ {W : Ty}, RelocIH Δ Ξ b k W := by
  -- 値を変えない葉: T = W、Ψ も H もそのまま
  have leaf : ∀ {W : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap} {D0 : Nat},
      HeapOk Δ Ξ b Ψ H → (k + 1 ≤ D0 ∨ D0 = Ψ.length) → Value v →
      HasType Δ Ξ (Ψ.take D0) b b D0 [] [] v W → W.regionsBelow (k + 1) = true →
      relocTo k W H v = some (H, v) →
      ∃ H' Ψ' v', relocTo k W H v = some (H', v') ∧ Value v' ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
        HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] v' W := by
    intro W v Ψ H D0 hH hDk hv he hW hrel
    refine ⟨H, Ψ, v, hrel, hv, RelocJ.refl hH, ?_⟩
    have := HasType.value_strengthen hv he hW
    rwa [take_take_k1 hDk] at this
  intro W
  induction W with
  | int =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | tvar i =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | bool =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | byte =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | f64 =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | unit =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | chan rc t ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | own _ r t ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | fn p r ihp ihr =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
    exact leaf hH hDk hv he hW (by cases v <;> rfl)
  | opt W' ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain ⟨T', rfl, hs'⟩ := Ty.clampR_sub_opt hs
    simp only [Ty.regionsBelow] at hW
    simp only [Ty.noClamp, Ty.chanFree] at hc
    rcases canonical_opt hv he with rfl | ⟨w, rfl, hw⟩
    · exact ⟨H, Ψ, .nil _, rfl, .nil _, RelocJ.refl hH, .nil⟩
    · cases he with
      | some hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ := ih hH hD hDk hw hwt hW hs' hc
        exact ⟨H', Ψ', .some w', by simp [relocTo, hrel], .some hv', hout, .some ht'⟩
  | union l r ihl ihr =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.clampR_sub_union hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hW
    simp only [Ty.noClamp, Ty.chanFree, Bool.and_eq_true] at hc
    rcases canonical_union hv he with ⟨w, rfl, hw⟩ | ⟨w, rfl, hw⟩
    · cases he with
      | inl hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ :=
          ihl hH hD hDk hw hwt hW.1 hsl (hc.imp (fun h => h.1) (fun h => ⟨h.1, h.2.1⟩))
        exact ⟨H', Ψ', .inl _ w', by simp [relocTo, hrel], .inl _ hv', hout, .inl ht'⟩
    · cases he with
      | inr hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ :=
          ihr hH hD hDk hw hwt hW.2 hsr (hc.imp (fun h => h.2) (fun h => ⟨h.1, h.2.2⟩))
        exact ⟨H', Ψ', .inr _ w', by simp [relocTo, hrel], .inr _ hv', hout, .inr ht'⟩
  | prod l r ihl ihr =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.clampR_sub_prod hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hW
    simp only [Ty.noClamp, Ty.chanFree, Bool.and_eq_true] at hc
    obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
    obtain ⟨H1, Ψ1, a', hrel1, hva', hout1, hta'⟩ :=
      ihl hH hD hDk hva hta hW.1 hsl (hc.imp (fun h => h.1) (fun h => ⟨h.1, h.2.1⟩))
    have hl1 := hout1.2.1
    obtain ⟨H2, Ψ2, c', hrel2, hvc', hout2, htc'⟩ :=
      ihr hout1.1 (by omega) (by omega) hvc (relocJ_carry hout1.2.2.1 hout1.2.2.2.1 htc) hW.2 hsr
        (hc.imp (fun h => h.2) (fun h => ⟨h.1, h.2.2⟩))
    refine ⟨H2, Ψ2, .pair a' c', ?_, .pair hva' hvc', hout1.trans hout2,
      .pair (relocJ_carry hout2.2.2.1 hout2.2.2.2.1 hta') htc'⟩
    simp [relocTo, hrel1, hrel2]
  | ref m rW W' ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    cases m with
    | true =>
      obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
      exact leaf hH hDk hv he hW (by cases v <;> rfl)
    | false =>
      obtain ⟨r, e, rfl, hmin, rfl⟩ := Ty.clampR_sub_ref hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      obtain ⟨r', x, σs, m', rfl, hσs0, hcell, hrd, hrle, -, hmm⟩ := canonical_ref hv he
      have hm' : m' = false := hmm rfl
      subst hm'
      have hσs : Ψ[r']? = some σs := (getElem?_take_some hσs0).2
      have hHlen : H.length = Ψ.length := hH.len
      have hbt : e.regionsBelow (r' + 1) = true := hH.tyBelow r' σs x false _ hσs hcell
      by_cases hkr : k < r'
      · have hc' : b ≤ k ∧ e.chanFree = true := by
          rcases hc with h | h
          · simp only [Ty.noClamp, Bool.and_eq_true, decide_eq_true_eq] at h; omega
          · simpa [Ty.chanFree] using h
        have hmfe : e.mutFree = true := hH.immMutFree r' σs x e hσs hcell
        obtain ⟨ρs, hρs⟩ : ∃ ρs, H[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
        obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
          reloc_cellsJ (base := x) (len := 1) hc'.1 hW.2 (Ty.clampR_mutFree hmfe) ih
            hH hkr (by omega) hρs hσs
            (fun j hj => ⟨e, by simpa [show j = 0 by omega] using hcell, Ty.sub_refl _, hc'.2⟩)
        refine ⟨H1.set k (ρd ++ cs), Ψ', .loc k ρd.length, ?_, .loc _ _, hout, ?_⟩
        · simp only [relocTo, if_pos hkr, hρs, hrel, hρd]
        · obtain ⟨σ', hσ', hσ'c⟩ := hcells 0 (by omega)
          exact .loc hσ' (by simpa using hσ'c) (by omega) (by omega) (fun h => nomatch h) (fun _ => rfl)
      · have hce : e.clampR k = e := Ty.clampR_of_regionsBelow (Ty.regionsBelow_mono (by omega) hbt)
        refine ⟨H, Ψ, .loc r' x, ?_, .loc r' x, RelocJ.refl hH, ?_⟩
        · simp only [relocTo, if_neg hkr]
        · rw [hce]
          exact .loc (ρ := σs) (by rw [List.getElem?_take_of_lt (by omega)]; exact hσs) hcell (by omega)
            (by omega) (fun h => nomatch h) (fun _ => rfl)
  | slice m rW W' ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    cases m with
    | true =>
      obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
      exact leaf hH hDk hv he hW (by cases v <;> rfl)
    | false =>
      obtain ⟨r, e, rfl, hmin, hse⟩ := Ty.clampR_sub_slice hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      obtain ⟨mt, r', base, len, rfl, hmt, hk, hrd, hrle, -, hmf, -⟩ := canonical_slice hv he
      subst hmt
      have hHlen : H.length = Ψ.length := hH.len
      have hmfW : W'.mutFree = true := by
        rw [← Ty.sub_mutFree hse]; exact Ty.clampR_mutFree (hmf rfl)
      have hσ0 : ∀ j, j < len → ∃ σ' tc, Ψ[r']? = some σ' ∧ σ'[base + j]? = some (false, tc) ∧
          Ty.sub tc e = true := by
        intro j hj
        obtain ⟨σ', mk, tc, hσ', hc, hmk, hsc, -⟩ := hk j hj
        obtain rfl := hmk rfl
        exact ⟨σ', tc, (getElem?_take_some hσ').2, hc, hsc⟩
      by_cases hkr : k < r'
      · have hc' : b ≤ k ∧ e.chanFree = true := by
          rcases hc with h | h
          · simp only [Ty.noClamp, Bool.and_eq_true, decide_eq_true_eq] at h; omega
          · simpa [Ty.chanFree] using h
        obtain ⟨ρs, hρs⟩ : ∃ ρs, H[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
        obtain ⟨σs, hσs⟩ : ∃ σs, Ψ[r']? = some σs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
        obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
          reloc_cellsJ (base := base) (len := len) hc'.1 hW.2 hmfW ih
            hH hkr (by omega) hρs hσs (fun j hj => by
              obtain ⟨σ', tc, hσ', hc, hsc⟩ := hσ0 j hj
              rw [hσs] at hσ'; cases hσ'
              exact ⟨tc, hc, Ty.sub_trans (Ty.clampR_mono hsc) hse, (Ty.sub_chanFree hsc) ▸ hc'.2⟩)
        refine ⟨H1.set k (ρd ++ cs), Ψ', .slicev false k ρd.length len, ?_, .slicev _ _ _ _, hout, ?_⟩
        · simp only [relocTo, if_pos hkr, hρs, hrel, hρd]
        · refine .slicev (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h)
            (fun _ => hmfW) (fun h => nomatch h)
          obtain ⟨σ', hσ', hσ'c⟩ := hcells j hj
          exact ⟨σ', false, W', hσ', hσ'c, fun _ => rfl, Ty.sub_refl _, fun h => nomatch h⟩
      · refine ⟨H, Ψ, .slicev false r' base len, ?_, .slicev _ _ _ _, RelocJ.refl hH, ?_⟩
        · simp only [relocTo, if_neg hkr]
        · refine .slicev (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h) (fun _ => hmfW)
            (fun h => nomatch h)
          obtain ⟨σ', tc, hσ', hc, hsc⟩ := hσ0 j hj
          have hbt : tc.regionsBelow (r' + 1) = true := hH.tyBelow r' σ' (base + j) false tc hσ' hc
          have hct : tc.clampR k = tc := Ty.clampR_of_regionsBelow (Ty.regionsBelow_mono (by omega) hbt)
          refine ⟨σ', false, tc, by rw [List.getElem?_take_of_lt (by omega)]; exact hσ', hc, fun _ => rfl, ?_,
            fun h => nomatch h⟩
          have := Ty.sub_trans (Ty.clampR_mono (k := k) hsc) hse
          rwa [hct] at this
  | map m rW W' ih =>
    intro T v Ψ H D0 hH hD hDk hv he hW hs hc
    cases m with
    | true =>
      obtain rfl := Ty.clampR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hs
      exact leaf hH hDk hv he hW (by cases v <;> rfl)
    | false =>
      obtain ⟨r, e, rfl, hmin, hse⟩ := Ty.clampR_sub_map hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      obtain ⟨mt, r', base, len, rfl, hmt, hk, hrd, hrle, -, hmf, -⟩ := canonical_map hv he
      subst hmt
      have hHlen : H.length = Ψ.length := hH.len
      have hmfW : W'.mutFree = true := by
        rw [← Ty.sub_mutFree hse]; exact Ty.clampR_mutFree (hmf rfl)
      have hσ0 : ∀ j, j < len → ∃ σ' tc, Ψ[r']? = some σ' ∧ σ'[base + j]? = some (false, tc) ∧
          Ty.sub tc e = true := by
        intro j hj
        obtain ⟨σ', mk, tc, hσ', hc, hmk, hsc, -⟩ := hk j hj
        obtain rfl := hmk rfl
        exact ⟨σ', tc, (getElem?_take_some hσ').2, hc, hsc⟩
      by_cases hkr : k < r'
      · have hc' : b ≤ k ∧ e.chanFree = true := by
          rcases hc with h | h
          · simp only [Ty.noClamp, Bool.and_eq_true, decide_eq_true_eq] at h; omega
          · simpa [Ty.chanFree] using h
        obtain ⟨ρs, hρs⟩ : ∃ ρs, H[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
        obtain ⟨σs, hσs⟩ : ∃ σs, Ψ[r']? = some σs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
        obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
          reloc_cellsJ (base := base) (len := len) hc'.1 hW.2 hmfW ih
            hH hkr (by omega) hρs hσs (fun j hj => by
              obtain ⟨σ', tc, hσ', hc, hsc⟩ := hσ0 j hj
              rw [hσs] at hσ'; cases hσ'
              exact ⟨tc, hc, Ty.sub_trans (Ty.clampR_mono hsc) hse, (Ty.sub_chanFree hsc) ▸ hc'.2⟩)
        refine ⟨H1.set k (ρd ++ cs), Ψ', .mapv false k ρd.length len, ?_, .mapv _ _ _ _, hout, ?_⟩
        · simp only [relocTo, if_pos hkr, hρs, hrel, hρd]
        · refine .mapv (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h)
            (fun _ => hmfW) (fun h => nomatch h)
          obtain ⟨σ', hσ', hσ'c⟩ := hcells j hj
          exact ⟨σ', false, W', hσ', hσ'c, fun _ => rfl, Ty.sub_refl _, fun h => nomatch h⟩
      · refine ⟨H, Ψ, .mapv false r' base len, ?_, .mapv _ _ _ _, RelocJ.refl hH, ?_⟩
        · simp only [relocTo, if_neg hkr]
        · refine .mapv (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h) (fun _ => hmfW)
            (fun h => nomatch h)
          obtain ⟨σ', tc, hσ', hc, hsc⟩ := hσ0 j hj
          have hbt : tc.regionsBelow (r' + 1) = true := hH.tyBelow r' σ' (base + j) false tc hσ' hc
          have hct : tc.clampR k = tc := Ty.clampR_of_regionsBelow (Ty.regionsBelow_mono (by omega) hbt)
          refine ⟨σ', false, tc, by rw [List.getElem?_take_of_lt (by omega)]; exact hσ', hc, fun _ => rfl, ?_,
            fun h => nomatch h⟩
          have := Ty.sub_trans (Ty.clampR_mono (k := k) hsc) hse
          rwa [hct] at this

/-! ## 境界をまたぐ写し（P3b-4 — task の結果: 子のヒープから親の region k へ中身ごと） -/

theorem Ty.relocR_mutFree_of {k : Nat} : ∀ {t : Ty}, t.mutFree = true → (t.relocR k).mutFree = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.mutFree] at h
    simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h]
  | .union l r, h => by
    simp only [Ty.mutFree, Bool.and_eq_true] at h
    simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h.1, Ty.relocR_mutFree_of h.2]
  | .prod l r, h => by
    simp only [Ty.mutFree, Bool.and_eq_true] at h
    simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h.1, Ty.relocR_mutFree_of h.2]
  | .ref m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h]
    · simp [Ty.mutFree] at h
  | .slice m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h]
    · simp [Ty.mutFree] at h
  | .map m r t, h => by
    cases m
    · simp only [Ty.mutFree, Bool.not_false, Bool.true_and] at h
      simp [Ty.relocR, Ty.mutFree, Ty.relocR_mutFree_of h]
    · simp [Ty.mutFree] at h
  | .chan _ _, _ => rfl
  | .fn _ _, _ => rfl
  | .own _ _ _, h => by simp [Ty.mutFree] at h

theorem Ty.relocR_chanFree_of {k : Nat} : ∀ {t : Ty}, t.mutFree = true → t.chanFree = true →
    (t.relocR k).chanFree = true
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm hc]
  | .union l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm.1 hc.1, Ty.relocR_chanFree_of hm.2 hc.2]
  | .prod l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm.1 hc.1, Ty.relocR_chanFree_of hm.2 hc.2]
  | .ref m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm hc]
    · simp [Ty.mutFree] at hm
  | .slice m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm hc]
    · simp [Ty.mutFree] at hm
  | .map m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.chanFree, Ty.relocR_chanFree_of hm hc]
    · simp [Ty.mutFree] at hm
  | .chan _ _, _, hc => by simp [Ty.chanFree] at hc
  | .fn _ _, _, _ => rfl
  | .own _ _ _, hm, _ => by simp [Ty.mutFree] at hm

/-- imm で chan を持たない型の relocR k は region k 以下しか指さない -/
theorem Ty.relocR_regionsBelow_of {k : Nat} : ∀ {t : Ty}, t.mutFree = true → t.chanFree = true →
    (t.relocR k).regionsBelow (k + 1) = true
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm hc]
  | .union l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm.1 hc.1, Ty.relocR_regionsBelow_of hm.2 hc.2]
  | .prod l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm.1 hc.1, Ty.relocR_regionsBelow_of hm.2 hc.2]
  | .ref m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm hc]
    · simp [Ty.mutFree] at hm
  | .slice m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm hc]
    · simp [Ty.mutFree] at hm
  | .map m r t, hm, hc => by
    cases m
    · simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      simp [Ty.relocR, Ty.regionsBelow, Ty.relocR_regionsBelow_of hm hc]
    · simp [Ty.mutFree] at hm
  | .chan _ _, _, hc => by simp [Ty.chanFree] at hc
  | .fn _ _, _, _ => rfl
  | .own _ _ _, hm, _ => by simp [Ty.mutFree] at hm

/-- relocR は imm の sub を保つ（全部の region を k へ — セル型 ≤ 要素型を写した後も比べられる） -/
theorem Ty.relocR_mono_mf {k : Nat} : ∀ {a b : Ty}, Ty.sub a b = true → Ty.sub (a.relocR k) (b.relocR k) = true
  | .int, _, h => by obtain rfl := Ty.sub_int_inv h; exact Ty.sub_refl _
  | .tvar _, _, h => by obtain rfl := Ty.sub_tvar_inv h; exact Ty.sub_refl _
  | .bool, _, h => by obtain rfl := Ty.sub_bool_inv h; exact Ty.sub_refl _
  | .byte, _, h => by obtain rfl := Ty.sub_byte_inv h; exact Ty.sub_refl _
  | .f64, _, h => by obtain rfl := Ty.sub_f64_inv h; exact Ty.sub_refl _
  | .unit, _, h => by obtain rfl := Ty.sub_unit_inv h; exact Ty.sub_refl _
  | .chan _ _, _, h => by obtain rfl := Ty.sub_chan_inv h; exact Ty.sub_refl _
  | .own _ _ _, _, h => by obtain rfl := Ty.sub_own_inv h; exact Ty.sub_refl _
  | .fn _ _, _, h => by obtain rfl := Ty.sub_fn_inv h; exact Ty.sub_refl _
  | .ref true _ _, _, h => by obtain rfl := Ty.sub_refT_inv h; exact Ty.sub_refl _
  | .slice true _ _, _, h => by obtain rfl := Ty.sub_sliceT_inv h; exact Ty.sub_refl _
  | .map true _ _, _, h => by obtain rfl := Ty.sub_mapT_inv h; exact Ty.sub_refl _
  | .opt a, _, h => by
    obtain ⟨b, rfl, hb⟩ := Ty.sub_opt_inv h
    simp only [Ty.relocR, Ty.sub]; exact Ty.relocR_mono_mf hb
  | .union a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_union_inv h
    simp only [Ty.relocR, Ty.sub, Bool.and_eq_true]; exact ⟨Ty.relocR_mono_mf h1, Ty.relocR_mono_mf h2⟩
  | .prod a1 a2, _, h => by
    obtain ⟨b1, b2, rfl, h1, h2⟩ := Ty.sub_prod_inv h
    simp only [Ty.relocR, Ty.sub, Bool.and_eq_true]; exact ⟨Ty.relocR_mono_mf h1, Ty.relocR_mono_mf h2⟩
  | .ref false r a, _, h => by
    obtain ⟨r', rfl, hr⟩ := Ty.sub_refF_inv h
    simp [Ty.relocR, Ty.sub]
  | .slice false r a, _, h => by
    obtain ⟨r', b, rfl, hr, hab⟩ := Ty.sub_sliceF_inv h
    simp only [Ty.relocR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨Nat.le_refl _, Ty.relocR_mono_mf hab⟩
  | .map false r a, _, h => by
    obtain ⟨r', b, rfl, hr, hab⟩ := Ty.sub_mapF_inv h
    simp only [Ty.relocR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨Nat.le_refl _, Ty.relocR_mono_mf hab⟩

theorem Ty.relocR_sub_leaf {k : Nat} {T W : Ty}
    (hW : ∀ o, W ≠ .opt o) (hU : ∀ l r, W ≠ .union l r) (hP : ∀ l r, W ≠ .prod l r)
    (hR : ∀ r t, W ≠ .ref false r t) (hS : ∀ r t, W ≠ .slice false r t) (hM : ∀ r t, W ≠ .map false r t)
    (hm : T.mutFree = true) (hc : T.chanFree = true)
    (hs : Ty.sub (T.relocR k) W = true) : T = W := by
  cases T with
  | opt t => cases W <;> simp_all [Ty.relocR, Ty.sub]
  | union l r => cases W <;> simp_all [Ty.relocR, Ty.sub]
  | prod l r => cases W <;> simp_all [Ty.relocR, Ty.sub]
  | ref m r t => cases m <;> cases W <;> simp_all [Ty.relocR, Ty.sub, Ty.mutFree]
  | slice m r t => cases m <;> cases W <;> simp_all [Ty.relocR, Ty.sub, Ty.mutFree]
  | map m r t => cases m <;> cases W <;> simp_all [Ty.relocR, Ty.sub, Ty.mutFree]
  | chan _ _ => simp [Ty.chanFree] at hc
  | own _ _ _ => simp [Ty.mutFree] at hm
  | _ => cases W <;> simp_all [Ty.relocR, Ty.sub]

theorem Ty.relocR_sub_opt {k : Nat} {T W : Ty} (hs : Ty.sub (T.relocR k) (.opt W) = true) :
    ∃ T', T = .opt T' ∧ Ty.sub (T'.relocR k) W = true := by
  cases T with
  | opt t => exact ⟨t, rfl, by simpa [Ty.relocR, Ty.sub] using hs⟩
  | ref m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

theorem Ty.relocR_sub_union {k : Nat} {T l r : Ty} (hs : Ty.sub (T.relocR k) (.union l r) = true) :
    ∃ l' r', T = .union l' r' ∧ Ty.sub (l'.relocR k) l = true ∧ Ty.sub (r'.relocR k) r = true := by
  cases T with
  | union a c => exact ⟨a, c, rfl, by simp_all [Ty.relocR, Ty.sub]⟩
  | ref m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

theorem Ty.relocR_sub_prod {k : Nat} {T l r : Ty} (hs : Ty.sub (T.relocR k) (.prod l r) = true) :
    ∃ l' r', T = .prod l' r' ∧ Ty.sub (l'.relocR k) l = true ∧ Ty.sub (r'.relocR k) r = true := by
  cases T with
  | prod a c => exact ⟨a, c, rfl, by simp_all [Ty.relocR, Ty.sub]⟩
  | ref m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

theorem Ty.relocR_sub_ref {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.relocR k) (.ref false rW W) = true) :
    ∃ r e, T = .ref false r e ∧ k ≤ rW ∧ e.relocR k = W := by
  cases T with
  | ref m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.relocR, Ty.sub] using hs⟩
    · simp [Ty.relocR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

theorem Ty.relocR_sub_slice {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.relocR k) (.slice false rW W) = true) :
    ∃ r e, T = .slice false r e ∧ k ≤ rW ∧ Ty.sub (e.relocR k) W = true := by
  cases T with
  | slice m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.relocR, Ty.sub] using hs⟩
    · simp [Ty.relocR, Ty.sub] at hs
  | ref m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | map m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

theorem Ty.relocR_sub_map {k rW : Nat} {T W : Ty} (hs : Ty.sub (T.relocR k) (.map false rW W) = true) :
    ∃ r e, T = .map false r e ∧ k ≤ rW ∧ Ty.sub (e.relocR k) W = true := by
  cases T with
  | map m r t =>
    cases m
    · exact ⟨r, t, rfl, by simpa [Ty.relocR, Ty.sub] using hs⟩
    · simp [Ty.relocR, Ty.sub] at hs
  | ref m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | slice m r t => cases m <;> simp [Ty.relocR, Ty.sub] at hs
  | _ => simp [Ty.relocR, Ty.sub] at hs

/-- 写しの帰納法の仮定（P3b-4 — 写す元は子のヒープ Hs〔世界 Ξs / 床 bs / Ψs〕で固定、写す先は親のヒープ H の region k）。
歩く型 W を固定、値の型 T は量化（深い共変でセルごとに型が違う） -/
def XferIH (Δ : Defs) (Ξs : ChanTy) (bs : Nat) (Ψs : StoreTy) (Hs : Heap) (Ξ : ChanTy) (b k : Nat) (W : Ty) : Prop :=
  ∀ {T : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap} {D0 : Nat},
    HeapOk Δ Ξ b Ψ H → k < Ψ.length → D0 ≤ Ψs.length → Value v →
    HasType Δ Ξs (Ψs.take D0) bs bs D0 [] [] v T → W.regionsBelow (k + 1) = true →
    Ty.sub (T.relocR k) W = true → T.mutFree = true → T.chanFree = true →
    ∃ H' Ψ' v', xfer k W Hs H v = some (H', v') ∧ Value v' ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
      HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] v' W

theorem xferListJ_ok {Δ : Defs} {Ξs : ChanTy} {bs : Nat} {Ψs : StoreTy} {Hs : Heap} {Ξ : ChanTy} {b k : Nat}
    {W : Ty} (ih : XferIH Δ Ξs bs Ψs Hs Ξ b k W) (hWb : W.regionsBelow (k + 1) = true) :
    ∀ (cs : List (Bool × Expr)) {Ψ : StoreTy} {H : Heap}, HeapOk Δ Ξ b Ψ H → k < Ψ.length →
      (∀ c ∈ cs, c.1 = false ∧ Value c.2 ∧ ∃ T D0, D0 ≤ Ψs.length ∧ HasType Δ Ξs (Ψs.take D0) bs bs D0 [] [] c.2 T ∧
        Ty.sub (T.relocR k) W = true ∧ T.mutFree = true ∧ T.chanFree = true) →
      ∃ H' Ψ' cs', relocList (xfer k W Hs) H cs = some (H', cs') ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
        cs'.length = cs.length ∧
        ∀ c ∈ cs', c.1 = false ∧ Value c.2 ∧ HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] c.2 W := by
  intro cs
  induction cs with
  | nil =>
    intro Ψ H hH _ _
    exact ⟨H, Ψ, [], rfl, RelocJ.refl hH, rfl, fun c hc => by simp at hc⟩
  | cons c cs ihc =>
    intro Ψ H hH hk hcs
    obtain ⟨m, w⟩ := c
    obtain ⟨hm, hwv, T, D0, hD0, hwt, hsT, hmT, hcT⟩ := hcs (m, w) (List.mem_cons_self ..)
    simp only at hm hwv hwt
    obtain ⟨H1, Ψ1, w', hrel, hwv', hout1, hwt'⟩ := ih hH hk hD0 hwv hwt hWb hsT hmT hcT
    obtain ⟨H2, Ψ2, cs', hrel2, hout2, hlen', hcs'⟩ := ihc hout1.1 (by rw [hout1.2.1]; exact hk)
      (fun c' hc' => hcs c' (List.mem_cons_of_mem _ hc'))
    refine ⟨H2, Ψ2, (m, w') :: cs', ?_, hout1.trans hout2, by simp [hlen'], ?_⟩
    · simp [relocList, hrel, hrel2]
    · intro c hc
      rcases List.mem_cons.mp hc with rfl | hc
      · exact ⟨hm, hwv', relocJ_carry hout2.2.2.1 hout2.2.2.2.1 hwt'⟩
      · exact hcs' c hc

/-- 子のヒープの region r の [base, base + len) の imm セル列を、中身を写してから親の region k の末尾へ連続に積む -/
theorem xfer_cellsJ {Δ : Defs} {Ξs : ChanTy} {bs : Nat} {Ψs : StoreTy} {Hs : Heap} {Ξ : ChanTy} {b k : Nat}
    {W : Ty} (hbk : b ≤ k) (hW : W.regionsBelow (k + 1) = true) (hmf : W.mutFree = true)
    (ih : XferIH Δ Ξs bs Ψs Hs Ξ b k W) (hHs : HeapOk Δ Ξs bs Ψs Hs)
    {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) (hkl : k < Ψ.length)
    {r : Nat} {ρs : List (Bool × Expr)} {σs : List (Bool × Ty)} (hρs : Hs[r]? = some ρs) (hσs : Ψs[r]? = some σs)
    {base len : Nat}
    (hk : ∀ j, j < len → ∃ tc, σs[base + j]? = some (false, tc) ∧ Ty.sub (tc.relocR k) W = true ∧
      tc.chanFree = true) :
    ∃ H1 cs ρd Ψ', relocList (xfer k W Hs) H ((ρs.drop base).take len) = some (H1, cs) ∧
      H1[k]? = some ρd ∧ RelocJ Δ Ξ b k Ψ H Ψ' (H1.set k (ρd ++ cs)) ∧ cs.length = len ∧
      ∀ j, j < len → ∃ σ', (Ψ'.take (k + 1))[k]? = some σ' ∧ σ'[ρd.length + j]? = some (false, W) := by
  have hslen : ρs.length = σs.length := hHs.storeLen r ρs σs hρs hσs
  have hbl : len = 0 ∨ base + len ≤ σs.length := by
    rcases Nat.eq_zero_or_pos len with h | hpos
    · exact .inl h
    · obtain ⟨tc, hc, -⟩ := hk (len - 1) (by omega)
      have := (List.getElem?_eq_some_iff.mp hc).1
      exact .inr (by omega)
  have hcl : ((ρs.drop base).take len).length = len := by
    rcases hbl with h | h
    · subst h; simp
    · rw [List.length_take, List.length_drop]; omega
  have hcs : ∀ c ∈ (ρs.drop base).take len, c.1 = false ∧ Value c.2 ∧ ∃ T D0, D0 ≤ Ψs.length ∧
      HasType Δ Ξs (Ψs.take D0) bs bs D0 [] [] c.2 T ∧ Ty.sub (T.relocR k) W = true ∧
      T.mutFree = true ∧ T.chanFree = true := by
    intro c hc
    obtain ⟨j, hj, hcj⟩ := List.getElem_of_mem hc
    have hjl : j < len := by rw [hcl] at hj; exact hj
    obtain ⟨tc, hσk, hsc, hcf⟩ := hk j hjl
    have hρj : ρs[base + j]? = some c := by
      rw [← hcj, List.getElem_take, List.getElem_drop]
      exact List.getElem?_eq_getElem _
    obtain ⟨mc, w⟩ := c
    have htag := hHs.tags r ρs σs (base + j) mc w false _ hρs hσs hρj hσk
    subst htag
    obtain ⟨hwv, hwt⟩ := hHs.typed r ρs σs (base + j) false w false _ hρs hσs hρj hσk (.inl rfl)
    have hrl : r < Ψs.length := (List.getElem?_eq_some_iff.mp hσs).1
    exact ⟨rfl, hwv, tc, r + 1, by omega, hwt, hsc, hHs.immMutFree r σs (base + j) tc hσs hσk, hcf⟩
  obtain ⟨H1, Ψ1, cs, hrel, ⟨hH1, hlen1, hle1, htb1, htH1, htk1, htkH1⟩, hcsl, hcs'⟩ :=
    xferListJ_ok ih hW _ hH hkl hcs
  have hH1l : H1.length = Ψ.length := by rw [hH1.len, hlen1]
  obtain ⟨ρd, hρd⟩ : ∃ ρd, H1[k]? = some ρd := ⟨_, List.getElem?_eq_getElem (by omega)⟩
  obtain ⟨σd, hσd⟩ : ∃ σd, Ψ1[k]? = some σd := ⟨_, List.getElem?_eq_getElem (by omega)⟩
  have hdl : ρd.length = σd.length := hH1.storeLen k ρd σd hρd hσd
  have hH' := heapOk_append_list hbk hW hmf cs hH1 hρd hσd hcs'
  refine ⟨H1, cs, ρd, Ψ1.set k (σd ++ cs.map (fun _ => (false, W))), hrel, hρd,
    ⟨hH', by simp [hlen1], hle1.trans (storeLE_set_concat_many hσd _),
      (take_set_of_le hbk _).trans htb1, (take_set_of_le hbk _).trans htH1,
      (take_set_of_le (Nat.le_refl k) _).trans htk1, (take_set_of_le (Nat.le_refl k) _).trans htkH1⟩,
    by rw [hcsl, hcl], ?_⟩
  intro j hj
  have hkΨ : k < Ψ1.length := by omega
  refine ⟨σd ++ cs.map (fun _ => (false, W)), ?_, ?_⟩
  · rw [List.getElem?_take_of_lt (by omega), List.getElem?_set_self hkΨ]
  · rw [hdl, List.getElem?_append_right (Nat.le_add_right _ _)]
    have hj0 : σd.length + j - σd.length = j := by omega
    have hjc : j < cs.length := by rw [hcsl, hcl]; exact hj
    rw [hj0, List.getElem?_map, List.getElem?_eq_getElem hjc]
    rfl

/-- 境界をまたぐ写しの保存（P3b-4）: 子のヒープ Hs で型 T（imm・chan なし）の値 v を、W（T の region を全部 k へ締めて共変で
緩めた型）に沿って親のヒープ H の region k へ xfer で写すと、(a) 成功し、(b) 親のストアは region k だけが lookup 保存で伸び、
(c) 結果は親の世界（take (k + 1)、深さ k + 1）で W に型付く。コンテナは region に依らず全部写す -/
theorem xfer_ok {Δ : Defs} {Ξs : ChanTy} {bs : Nat} {Ψs : StoreTy} {Hs : Heap} {Ξ : ChanTy} {b k : Nat}
    (hbk : b ≤ k) (hHs : HeapOk Δ Ξs bs Ψs Hs) : ∀ {W : Ty}, XferIH Δ Ξs bs Ψs Hs Ξ b k W := by
  have leaf : ∀ {W : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap} {D0 : Nat},
      HeapOk Δ Ξ b Ψ H → Value v → HasType Δ Ξs (Ψs.take D0) bs bs D0 [] [] v W →
      W.regionsBelow 0 = true → W.mutFree = true → W.chanFree = true →
      xfer k W Hs H v = some (H, v) →
      ∃ H' Ψ' v', xfer k W Hs H v = some (H', v') ∧ Value v' ∧ RelocJ Δ Ξ b k Ψ H Ψ' H' ∧
        HasType Δ Ξ (Ψ'.take (k + 1)) b b (k + 1) [] [] v' W := by
    intro W v Ψ H D0 hH hv he hb0 hm hc hrel
    exact ⟨H, Ψ, v, hrel, hv, RelocJ.refl hH,
      HasType.value_import hv (HasType.value_anyΞ hv hm hc (HasType.value_export hv he hb0)) hb0⟩
  have hHsl : Hs.length = Ψs.length := hHs.len
  intro W
  induction W with
  | int =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | tvar i =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | bool =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | byte =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | f64 =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | unit =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | fn p r ihp ihr =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    exact leaf hH hv he rfl rfl rfl (by cases v <;> rfl)
  | chan rc t ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    simp [Ty.chanFree] at hc
  | own _ r t ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
    simp [Ty.mutFree] at hm
  | opt W' ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain ⟨T', rfl, hs'⟩ := Ty.relocR_sub_opt hs
    simp only [Ty.regionsBelow] at hW
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    rcases canonical_opt hv he with rfl | ⟨w, rfl, hw⟩
    · exact ⟨H, Ψ, .nil _, rfl, .nil _, RelocJ.refl hH, .nil⟩
    · cases he with
      | some hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ := ih hH hk hD hw hwt hW hs' hm hc
        exact ⟨H', Ψ', .some w', by simp [xfer, hrel], .some hv', hout, .some ht'⟩
  | union l r ihl ihr =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.relocR_sub_union hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hW
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    rcases canonical_union hv he with ⟨w, rfl, hw⟩ | ⟨w, rfl, hw⟩
    · cases he with
      | inl hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ := ihl hH hk hD hw hwt hW.1 hsl hm.1 hc.1
        exact ⟨H', Ψ', .inl _ w', by simp [xfer, hrel], .inl _ hv', hout, .inl ht'⟩
    · cases he with
      | inr hwt =>
        obtain ⟨H', Ψ', w', hrel, hv', hout, ht'⟩ := ihr hH hk hD hw hwt hW.2 hsr hm.2 hc.2
        exact ⟨H', Ψ', .inr _ w', by simp [xfer, hrel], .inr _ hv', hout, .inr ht'⟩
  | prod l r ihl ihr =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.relocR_sub_prod hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hW
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
    obtain ⟨H1, Ψ1, a', hrel1, hva', hout1, hta'⟩ := ihl hH hk hD hva hta hW.1 hsl hm.1 hc.1
    have hl1 := hout1.2.1
    obtain ⟨H2, Ψ2, c', hrel2, hvc', hout2, htc'⟩ :=
      ihr hout1.1 (by omega) hD hvc htc hW.2 hsr hm.2 hc.2
    refine ⟨H2, Ψ2, .pair a' c', ?_, .pair hva' hvc', hout1.trans hout2,
      .pair (relocJ_carry hout2.2.2.1 hout2.2.2.2.1 hta') htc'⟩
    simp [xfer, hrel1, hrel2]
  | ref m rW W' ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    cases m with
    | true =>
      obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
      simp [Ty.mutFree] at hm
    | false =>
      obtain ⟨r, e, rfl, hkr, rfl⟩ := Ty.relocR_sub_ref hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      obtain ⟨r', x, σs, m', rfl, hσs0, hcell, hrd, hrle, -, hmm⟩ := canonical_ref hv he
      have hm' : m' = false := hmm rfl
      subst hm'
      have hσs : Ψs[r']? = some σs := (getElem?_take_some hσs0).2
      have hr'l : r' < Ψs.length := (List.getElem?_eq_some_iff.mp hσs).1
      obtain ⟨ρs, hρs⟩ : ∃ ρs, Hs[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
      obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
        xfer_cellsJ (base := x) (len := 1) hbk hW.2 (Ty.relocR_mutFree_of hm) ih hHs hH hk hρs hσs
          (fun j hj => ⟨e, by simpa [show j = 0 by omega] using hcell, Ty.sub_refl _, hc⟩)
      refine ⟨H1.set k (ρd ++ cs), Ψ', .loc k ρd.length, ?_, .loc _ _, hout, ?_⟩
      · simp only [xfer, hρs, hrel, hρd]
      · obtain ⟨σ', hσ', hσ'c⟩ := hcells 0 (by omega)
        exact .loc hσ' (by simpa using hσ'c) (by omega) (by omega) (fun h => nomatch h) (fun _ => rfl)
  | slice m rW W' ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    cases m with
    | true =>
      obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
      simp [Ty.mutFree] at hm
    | false =>
      obtain ⟨r, e, rfl, hkr, hse⟩ := Ty.relocR_sub_slice hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      obtain ⟨mt, r', base, len, rfl, hmt, hkk, hrd, hrle, -, hmf, -⟩ := canonical_slice hv he
      subst hmt
      have hmfW : W'.mutFree = true := by
        rw [← Ty.sub_mutFree hse]; exact Ty.relocR_mutFree_of hm
      have hσ0 : ∀ j, j < len → ∃ σ' tc, Ψs[r']? = some σ' ∧ σ'[base + j]? = some (false, tc) ∧
          Ty.sub tc e = true := by
        intro j hj
        obtain ⟨σ', mk, tc, hσ', hc', hmk, hsc, -⟩ := hkk j hj
        obtain rfl := hmk rfl
        exact ⟨σ', tc, (getElem?_take_some hσ').2, hc', hsc⟩
      have hce : e.chanFree = true := hc
      obtain ⟨ρs, hρs⟩ : ∃ ρs, Hs[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
      obtain ⟨σs, hσs⟩ : ∃ σs, Ψs[r']? = some σs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
      obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
        xfer_cellsJ (base := base) (len := len) hbk hW.2 hmfW ih hHs hH hk hρs hσs (fun j hj => by
          obtain ⟨σ', tc, hσ', hc', hsc⟩ := hσ0 j hj
          rw [hσs] at hσ'; cases hσ'
          exact ⟨tc, hc', Ty.sub_trans (Ty.relocR_mono_mf hsc) hse, (Ty.sub_chanFree hsc) ▸ hce⟩)
      refine ⟨H1.set k (ρd ++ cs), Ψ', .slicev false k ρd.length len, ?_, .slicev _ _ _ _, hout, ?_⟩
      · simp only [xfer, hρs, hrel, hρd]
      · refine .slicev (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h)
          (fun _ => hmfW) (fun h => nomatch h)
        obtain ⟨σ', hσ', hσ'c⟩ := hcells j hj
        exact ⟨σ', false, W', hσ', hσ'c, fun _ => rfl, Ty.sub_refl _, fun h => nomatch h⟩
  | map m rW W' ih =>
    intro T v Ψ H D0 hH hk hD hv he hW hs hm hc
    cases m with
    | true =>
      obtain rfl := Ty.relocR_sub_leaf (by simp) (by simp) (by simp) (by simp) (by simp) (by simp) hm hc hs
      simp [Ty.mutFree] at hm
    | false =>
      obtain ⟨r, e, rfl, hkr, hse⟩ := Ty.relocR_sub_map hs
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hW
      simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
      obtain ⟨mt, r', base, len, rfl, hmt, hkk, hrd, hrle, -, hmf, -⟩ := canonical_map hv he
      subst hmt
      have hmfW : W'.mutFree = true := by
        rw [← Ty.sub_mutFree hse]; exact Ty.relocR_mutFree_of hm
      have hσ0 : ∀ j, j < len → ∃ σ' tc, Ψs[r']? = some σ' ∧ σ'[base + j]? = some (false, tc) ∧
          Ty.sub tc e = true := by
        intro j hj
        obtain ⟨σ', mk, tc, hσ', hc', hmk, hsc, -⟩ := hkk j hj
        obtain rfl := hmk rfl
        exact ⟨σ', tc, (getElem?_take_some hσ').2, hc', hsc⟩
      have hce : e.chanFree = true := hc
      obtain ⟨ρs, hρs⟩ : ∃ ρs, Hs[r']? = some ρs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
      obtain ⟨σs, hσs⟩ : ∃ σs, Ψs[r']? = some σs := ⟨_, List.getElem?_eq_getElem (by omega)⟩
      obtain ⟨H1, cs, ρd, Ψ', hrel, hρd, hout, hcsl, hcells⟩ :=
        xfer_cellsJ (base := base) (len := len) hbk hW.2 hmfW ih hHs hH hk hρs hσs (fun j hj => by
          obtain ⟨σ', tc, hσ', hc', hsc⟩ := hσ0 j hj
          rw [hσs] at hσ'; cases hσ'
          exact ⟨tc, hc', Ty.sub_trans (Ty.relocR_mono_mf hsc) hse, (Ty.sub_chanFree hsc) ▸ hce⟩)
      refine ⟨H1.set k (ρd ++ cs), Ψ', .mapv false k ρd.length len, ?_, .mapv _ _ _ _, hout, ?_⟩
      · simp only [xfer, hρs, hrel, hρd]
      · refine .mapv (fun j hj => ?_) (by omega) (by omega) rfl (fun h => nomatch h)
          (fun _ => hmfW) (fun h => nomatch h)
        obtain ⟨σ', hσ', hσ'c⟩ := hcells j hj
        exact ⟨σ', false, W', hσ', hσ'c, fun _ => rfl, Ty.sub_refl _, fun h => nomatch h⟩

theorem Ty.retOk_chanFree : ∀ {t : Ty}, t.retOk = true → t.chanFree = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by simp only [Ty.retOk] at h; simp [Ty.chanFree, Ty.retOk_chanFree h]
  | .union l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp [Ty.chanFree, Ty.retOk_chanFree h.1, Ty.retOk_chanFree h.2]
  | .prod l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp [Ty.chanFree, Ty.retOk_chanFree h.1, Ty.retOk_chanFree h.2]
  | .ref m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true] at h; simp [Ty.chanFree, Ty.retOk_chanFree h.2]
    · simp [Ty.retOk] at h
  | .slice m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true] at h; simp [Ty.chanFree, Ty.retOk_chanFree h.2]
    · simp [Ty.retOk] at h
  | .map m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true] at h; simp [Ty.chanFree, Ty.retOk_chanFree h.2]
    · simp [Ty.retOk] at h
  | .chan _ _, h => by simp [Ty.retOk] at h
  | .fn _ _, _ => rfl

/-- 戻りの締め（relocA）は写像してから呼び手最内へ締めたもの（retOk — region は 0 か 1 だけ） -/
theorem Ty.relocA_eq_clampR {ρ0 d : Nat} (h0 : ρ0 ≤ d) :
    ∀ {t : Ty}, t.retOk = true → t.relocA ρ0 d = (t.renR ρ0 d).clampR d
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.retOk] at h
    simp [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h]
  | .union l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h.1, Ty.relocA_eq_clampR h0 h.2]
  | .prod l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h.1, Ty.relocA_eq_clampR h0 h.2]
  | .ref m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true, decide_eq_true_eq] at h
      simp only [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h.2, Ty.ref.injEq, and_true, true_and]
      rcases r with _ | _ | r
      · simp [rmap]; omega
      · simp [rmap]
      · omega
    · simp [Ty.retOk] at h
  | .slice m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true, decide_eq_true_eq] at h
      simp only [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h.2, Ty.slice.injEq, and_true, true_and]
      rcases r with _ | _ | r
      · simp [rmap]; omega
      · simp [rmap]
      · omega
    · simp [Ty.retOk] at h
  | .map m r t, h => by
    cases m
    · simp only [Ty.retOk, Bool.and_eq_true, decide_eq_true_eq] at h
      simp only [Ty.relocA, Ty.renR, Ty.clampR, Ty.relocA_eq_clampR h0 h.2, Ty.map.injEq, and_true, true_and]
      rcases r with _ | _ | r
      · simp [rmap]; omega
      · simp [rmap]
      · omega
    · simp [Ty.retOk] at h
  | .chan _ _, h => by simp [Ty.retOk] at h
  | .fn _ _, _ => rfl

/-- 関数の返り境界（fretK）の保存: relocTo_ok の系（k = 呼び手最内 d、歩く型 = 締めた結果型 relocA）。
R4a の relocT_ok を R4b-cov で置き換えた（写す元の判定 k < r は、深さ d + 2 の世界では自フレームだけ） -/
theorem relocRet_ok {Δ : Defs} {Ξ : ChanTy} {b d ρ0 : Nat} (h0 : ρ0 ≤ d) (hb : b ≤ d)
    {t0 : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) (hlen : Ψ.length = d + 2)
    (hv : Value v) (he : HasType Δ Ξ Ψ b b (d + 2) [] [] v (Ty.renR ρ0 d t0)) (hro : Ty.retOk t0 = true) :
    ∃ H' Ψ' v', relocTo (H.length - 2) (Ty.relocA ρ0 d t0) H v = some (H', v') ∧ Value v' ∧
      RelocOut Δ Ξ b d Ψ H Ψ' H' ∧ HasType Δ Ξ (Ψ'.take (d + 1)) b b (d + 1) [] [] v' (Ty.relocA ρ0 d t0) := by
  have hHl : H.length - 2 = d := by rw [hH.len, hlen]; omega
  rw [hHl]
  have he0 : HasType Δ Ξ (Ψ.take (d + 2)) b b (d + 2) [] [] v (Ty.renR ρ0 d t0) := by
    have h2 : Ψ.take (d + 2) = Ψ := by rw [← hlen]; exact List.take_length
    rw [h2]; exact he
  have hcl := Ty.relocA_eq_clampR h0 hro
  obtain ⟨H', Ψ', v', hrel, hv', ⟨hH', hl', hle, -, -, htk, htkH⟩, ht'⟩ :=
    relocTo_ok (k := d) hH (by omega) (.inr hlen.symm) hv he0 (Ty.relocA_regionsBelow h0 hro)
      (by rw [hcl]; exact Ty.sub_refl _) (.inr ⟨hb, by rw [Ty.chanFree_renR]; exact Ty.retOk_chanFree hro⟩)
  exact ⟨H', Ψ', v', hrel, hv', ⟨hH', by omega, hle, htk, htkH⟩, ht'⟩

/-- 返り境界の保存（anchor = 呼び手最内 d = 従来の call の形） -/
theorem relocRet_ok_top {Δ : Defs} {Ξ : ChanTy} {b d : Nat} {t0 : Ty} {v : Expr} {Ψ : StoreTy} {H : Heap}
    (hb : b ≤ d) (hH : HeapOk Δ Ξ b Ψ H) (hlen : Ψ.length = d + 2) (hv : Value v)
    (he : HasType Δ Ξ Ψ b b (d + 2) [] [] v (Ty.shiftR d t0)) (hro : Ty.retOk t0 = true) :
    ∃ H' Ψ' v', relocTo (H.length - 2) (Ty.relocR d t0) H v = some (H', v') ∧ Value v' ∧
      RelocOut Δ Ξ b d Ψ H Ψ' H' ∧ HasType Δ Ξ (Ψ'.take (d + 1)) b b (d + 1) [] [] v' (Ty.relocR d t0) := by
  rw [← Ty.renR_top] at he
  rw [← Ty.relocA_top]
  exact relocRet_ok (Nat.le_refl d) hb hH hlen hv he hro

/-- jump の 1 歩（R4b α）: 巻き戻し（unwind_ok）+ 脱出の境界コピー（relocTo_ok）+ ラベルの深さへの切り詰め。
preservation / progress / 共有プレフィクス安定性の 3 か所が同じ束を使う -/
theorem jumpK_step {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {v : Expr}
    {D n k : Nat} {tJ tL t' tf : Ty} {K : ChanSt} (π : List Bool)
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = D) (hv : Value v) (he : HasType Δ Ξ Ψ b b D [] Λ v tJ)
    (hn : Λ[n]? = some (tL, k)) (hrel : Ty.jumpRel b k tJ tL = true) (hS' : StackTy Δ Ξ Ψ b S Λ D t' tf) :
    ∃ (S'' : Stack) (Λ' : LCtx) (d' : Nat) (H'' : Heap) (Ψ' : StoreTy) (v' : Expr),
      step Δ π (.ret H (.jumpK n :: S) v) K = some (.ret (H''.take d') S'' v', K) ∧
      Value v' ∧ HeapOk Δ Ξ b (Ψ'.take d') (H''.take d') ∧ (Ψ'.take d').length = d' ∧
      HasType Δ Ξ (Ψ'.take d') b b d' [] Λ' v' tL ∧ StackTy Δ Ξ (Ψ'.take d') b S'' Λ' d' tL tf ∧
      (H''.take d').take b = H.take b := by
  have hH' : HeapOk Δ Ξ b (Ψ.take D) H := by rw [← hD, List.take_length]; exact hH
  obtain ⟨S'', Λ', d', h1, h2, h3, h4, h5, hk⟩ := unwind_ok hS' hn (by omega) hH'
  have hbd : b ≤ d' := h3.le_depth
  have hHt : (H.take d').length = d' := by rw [List.length_take, hH.len]; omega
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at hrel
  obtain ⟨hsub, hc⟩ := hrel
  have he0 : HasType Δ Ξ (Ψ.take D) b b D [] [] v tJ := by
    rw [← hD, List.take_length]; rw [← hD] at he; exact HasType.value_ctx hv he
  obtain ⟨H'', Ψ', v', hrl, hv', ⟨hH'', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    relocTo_ok (k := k) hH (by omega) (.inr hD.symm) hv he0 (Ty.regionsBelow_mono (by omega) h4) hsub hc
  have hΨt : (Ψ'.take (k + 1)).take d' = Ψ'.take d' := by rw [List.take_take, Nat.min_eq_left (by omega)]
  refine ⟨S'', Λ', d', H'', Ψ', v', ?_, hv', heapOk_take d' hH'', by rw [List.length_take]; omega, ?_, ?_, ?_⟩
  · simp only [step, h1, hHt, ← hk, hrl]
  · have := HasType.value_strengthen hv' ht' h4
    rw [hΨt] at this
    exact HasType.value_ctx hv' this
  · exact h3.mono (fun d'' hd'' => by rw [List.take_take, Nat.min_eq_left hd'']; exact hle.take_take d'')
      (by rw [List.take_take, Nat.min_eq_left hbd]; exact htb)
  · rw [List.take_take, Nat.min_eq_left hbd]; exact htH

/-- block の出口の写し（regionKR と scope の出口の共通部 — 段 6 P1 で regionKR_step から切り出し。穴の Λ と下の S の Λ' は別でよい） -/
theorem reloc_exit {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {v : Expr}
    {d : Nat} {tB t tS tf : Ty} {Λ' : LCtx}
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = d + 1) (hv : Value v)
    (he : HasType Δ Ξ Ψ b b (d + 1) [] Λ v tB) (hr : Ty.jumpRel b (d - 1) tB t = true)
    (hrb : t.regionsBelow d = true) (hS' : StackTy Δ Ξ Ψ b S Λ' d tS tf) :
    ∃ (H'' : Heap) (Ψ' : StoreTy) (v' : Expr),
      relocTo (H.length - 2) t H v = some (H'', v') ∧
      Value v' ∧ HeapOk Δ Ξ b Ψ'.dropLast H''.dropLast ∧ Ψ'.dropLast.length = d ∧
      HasType Δ Ξ Ψ'.dropLast b b d [] Λ' v' t ∧ StackTy Δ Ξ Ψ'.dropLast b S Λ' d tS tf ∧
      H''.dropLast.take b = H.take b := by
  have hbd : b ≤ d := hS'.le_depth
  have hHl : H.length - 2 = d - 1 := by rw [hH.len, hD]; omega
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at hr
  obtain ⟨hsub, hc⟩ := hr
  have he0 : HasType Δ Ξ (Ψ.take (d + 1)) b b (d + 1) [] [] v tB := by
    have h2 : Ψ.take (d + 1) = Ψ := by rw [← hD]; exact List.take_length
    rw [h2]; exact HasType.value_ctx hv he
  obtain ⟨H'', Ψ', v', hrl, hv', ⟨hH'', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    relocTo_ok (k := d - 1) hH (by omega) (.inr hD.symm) hv he0 (Ty.regionsBelow_mono (by omega) hrb) hsub hc
  have hdl : Ψ'.dropLast = Ψ'.take d := by
    rw [List.dropLast_eq_take, hlen', hD]; rfl
  have hH''l : H''.length = d + 1 := by rw [hH''.len, hlen', hD]
  refine ⟨H'', Ψ', v', ?_, hv', heapOk_pop hH'', by rw [hdl, List.length_take]; omega, ?_, ?_, ?_⟩
  · rw [hHl]; exact hrl
  · have := HasType.value_strengthen hv' ht' hrb
    rw [List.take_take, Nat.min_eq_left (by omega)] at this
    rw [hdl]; exact HasType.value_ctx hv' this
  · refine hS'.mono (fun d'' hd'' => ?_) ?_
    · rw [hdl, List.take_take, Nat.min_eq_left hd'']
      exact hle.take_take d''
    · rw [hdl, List.take_take, Nat.min_eq_left hbd]; exact htb
  · rw [take_dropLast_eq H'' (by omega : b ≤ H''.length - 1)]; exact htH

/-- scope の出口で死を値にする（P3a A1 (X)）: 写さずに pop して `inr t triv` — 最内の region を捨てるだけ -/
theorem dead_exit {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack}
    {d : Nat} {tS tf : Ty} {Λ' : LCtx}
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = d + 1) (hS' : StackTy Δ Ξ Ψ b S Λ' d tS tf) :
    HeapOk Δ Ξ b Ψ.dropLast H.dropLast ∧ Ψ.dropLast.length = d ∧
      StackTy Δ Ξ Ψ.dropLast b S Λ' d tS tf ∧ H.dropLast.take b = H.take b := by
  have hbd : b ≤ d := hS'.le_depth
  refine ⟨heapOk_pop hH, by simp [hD], ?_, ?_⟩
  · refine hS'.mono (fun d'' hd'' => ?_) ?_
    · rw [take_dropLast_eq Ψ (by omega)]; exact StoreLE.refl _
    · rw [take_dropLast_eq Ψ (by omega)]
  · rw [take_dropLast_eq H (by rw [hH.len, hD]; omega)]

/-- 出口で写すブロックの 1 歩（R5）: ブロックの region（最内 d）の imm コンテナを親の最内 d - 1 へ写してから pop。
jump の脱出（jumpK_step）と同じ relocTo_ok の束で、巻き戻しの代わりに 1 段だけ降りる -/
theorem regionKR_step {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {v : Expr}
    {d : Nat} {tB t tf : Ty} {K : ChanSt} (π : List Bool)
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = d + 1) (hv : Value v)
    (he : HasType Δ Ξ Ψ b b (d + 1) [] Λ v tB) (hr : Ty.jumpRel b (d - 1) tB t = true)
    (hrb : t.regionsBelow d = true) (hS' : StackTy Δ Ξ Ψ b S Λ d t tf) :
    ∃ (H'' : Heap) (Ψ' : StoreTy) (v' : Expr),
      step Δ π (.ret H (.regionKR t :: S) v) K = some (.ret H''.dropLast S v', K) ∧
      Value v' ∧ HeapOk Δ Ξ b Ψ'.dropLast H''.dropLast ∧ Ψ'.dropLast.length = d ∧
      HasType Δ Ξ Ψ'.dropLast b b d [] Λ v' t ∧ StackTy Δ Ξ Ψ'.dropLast b S Λ d t tf ∧
      H''.dropLast.take b = H.take b := by
  have hbd : b ≤ d := hS'.le_depth
  have hHl : H.length - 2 = d - 1 := by rw [hH.len, hD]; omega
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at hr
  obtain ⟨hsub, hc⟩ := hr
  have he0 : HasType Δ Ξ (Ψ.take (d + 1)) b b (d + 1) [] [] v tB := by
    have h2 : Ψ.take (d + 1) = Ψ := by rw [← hD]; exact List.take_length
    rw [h2]; exact HasType.value_ctx hv he
  obtain ⟨H'', Ψ', v', hrl, hv', ⟨hH'', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    relocTo_ok (k := d - 1) hH (by omega) (.inr hD.symm) hv he0 (Ty.regionsBelow_mono (by omega) hrb) hsub hc
  have hdl : Ψ'.dropLast = Ψ'.take d := by
    rw [List.dropLast_eq_take, hlen', hD]; rfl
  have hH''l : H''.length = d + 1 := by rw [hH''.len, hlen', hD]
  refine ⟨H'', Ψ', v', ?_, hv', heapOk_pop hH'', by rw [hdl, List.length_take]; omega, ?_, ?_, ?_⟩
  · simp only [step, hHl, hrl]
  · have := HasType.value_strengthen hv' ht' hrb
    rw [List.take_take, Nat.min_eq_left (by omega)] at this
    rw [hdl]; exact HasType.value_ctx hv' this
  · refine hS'.mono (fun d'' hd'' => ?_) ?_
    · rw [hdl, List.take_take, Nat.min_eq_left hd'']
      exact hle.take_take d''
    · rw [hdl, List.take_take, Nat.min_eq_left hbd]; exact htb
  · rw [take_dropLast_eq H'' (by omega : b ≤ H''.length - 1)]; exact htH

/-- 境界コピー式の 1 歩（M3 — copyTo）: 値を外側の region k へ relocTo で写す（jump の脱出・R5 と同じ relocTo_ok の束）。
深さは変えない（region を pop しない — 写した値は region k 以下しか指さないので今の深さでもそのまま型付く） -/
theorem copyK_step {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {v : Expr}
    {D k : Nat} {tE t tf : Ty} {K : ChanSt} (π : List Bool)
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = D) (hv : Value v)
    (he : HasType Δ Ξ Ψ b b D [] Λ v tE) (hk : k < D) (hr : Ty.jumpRel b k tE t = true)
    (hrb : t.regionsBelow (k + 1) = true) (hS' : StackTy Δ Ξ Ψ b S Λ D t tf) :
    ∃ (H' : Heap) (Ψ' : StoreTy) (v' : Expr),
      step Δ π (.ret H (.copyK k t :: S) v) K = some (.ret H' S v', K) ∧
      Value v' ∧ HeapOk Δ Ξ b Ψ' H' ∧ Ψ'.length = D ∧
      HasType Δ Ξ Ψ' b b D [] Λ v' t ∧ StackTy Δ Ξ Ψ' b S Λ D t tf ∧
      H'.take b = H.take b := by
  have hbd : b ≤ D := hS'.le_depth
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at hr
  obtain ⟨hsub, hc⟩ := hr
  have he0 : HasType Δ Ξ (Ψ.take D) b b D [] [] v tE := by
    rw [← hD, List.take_length]; rw [← hD] at he; exact HasType.value_ctx hv he
  obtain ⟨H', Ψ', v', hrl, hv', ⟨hH', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    relocTo_ok (k := k) hH (by omega) (.inr hD.symm) hv he0 hrb hsub hc
  refine ⟨H', Ψ', v', ?_, hv', hH', by omega, ?_, ?_, htH⟩
  · simp only [step, hrl]
  · have h1 := ht'.store_mono (storeLE_take_self Ψ' (k + 1)) (fun n _ hn => by
      rw [List.length_take] at hn
      rw [List.take_take, Nat.min_eq_left (by omega)])
    exact HasType.value_ctx hv' (HasType.value_depth_weaken hv' h1 (by omega))
  · exact hS'.mono (fun d'' _ => hle.take_take d'') htb

/-- join / try の写し（P3b-4）: 完了した子の結果 v（子のヒープ Hs で子の結果型 tc — imm・chan なし）を親の scope の region rs へ
xfer で写すと成功し、親の状態はストアの region rs が伸びるだけで型付いたまま、値は handle の結果型 t = tc.relocR rs に型付く -/
theorem xfer_join {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {D rs : Nat}
    {tS tf : Ty} {Λ : LCtx} {Ξs : ChanTy} {bs : Nat} {Ψs : StoreTy} {Hs : Heap} {v : Expr} {tc t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = D) (hbrs : b ≤ rs) (hrsD : rs < D)
    (hHs : HeapOk Δ Ξs bs Ψs Hs) (hv : Value v) (hvt : HasType Δ Ξs Ψs bs bs Ψs.length [] [] v tc)
    (hmf : tc.mutFree = true) (hcf : tc.chanFree = true) (ht : tc.relocR rs = t)
    (hS' : StackTy Δ Ξ Ψ b S Λ D tS tf) :
    ∃ (H' : Heap) (Ψ' : StoreTy) (v' : Expr), xfer rs t Hs H v = some (H', v') ∧
      Value v' ∧ HeapOk Δ Ξ b Ψ' H' ∧ Ψ'.length = D ∧
      HasType Δ Ξ Ψ' b b D [] Λ v' t ∧ StackTy Δ Ξ Ψ' b S Λ D tS tf := by
  subst ht
  have hbd : b ≤ D := hS'.le_depth
  obtain ⟨H', Ψ', v', hx, hv', ⟨hH', hlen', hle, htb, -, -, -⟩, ht'⟩ :=
    xfer_ok (Ξ := Ξ) (b := b) (k := rs) hbrs hHs hH (by omega) (Nat.le_refl _) hv
      (by rw [List.take_length]; exact hvt) (Ty.relocR_regionsBelow_of hmf hcf) (Ty.sub_refl _) hmf hcf
  refine ⟨H', Ψ', v', hx, hv', hH', by omega, ?_, ?_⟩
  · have h1 := ht'.store_mono (storeLE_take_self Ψ' (rs + 1)) (fun n _ hn => by
      rw [List.length_take] at hn
      rw [List.take_take, Nat.min_eq_left (by omega)])
    exact HasType.value_ctx hv' (HasType.value_depth_weaken hv' h1 (by omega))
  · exact hS'.mono (fun d'' _ => hle.take_take d'') htb

/-- scope の出口で未回収の失敗を値にする（P3b-4 1b'）: 子のヒープ Hs の err e（型 tc — imm・chan なし）を、型 W（tc を親の最内 d - 1 へ締めた形）で
親の最内へ写してから scope の region を pop する。共有境界は親の最内より下（b < d） -/
theorem fail_exit {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {d : Nat} {tS tf : Ty} {Λ' : LCtx}
    {Ξs : ChanTy} {bs : Nat} {Ψs : StoreTy} {Hs : Heap} {e : Expr} {tc W : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = d + 1) (hbd : b < d)
    (hHs : HeapOk Δ Ξs bs Ψs Hs) (hv : Value e) (hvt : HasType Δ Ξs Ψs bs bs Ψs.length [] [] e tc)
    (hmf : tc.mutFree = true) (hcf : tc.chanFree = true) (hW : tc.relocR (d - 1) = W)
    (hS' : StackTy Δ Ξ Ψ b S Λ' d tS tf) :
    ∃ (H'' : Heap) (Ψ' : StoreTy) (e' : Expr),
      xfer (H.length - 2) W Hs H e = some (H'', e') ∧
      Value e' ∧ HeapOk Δ Ξ b Ψ'.dropLast H''.dropLast ∧ Ψ'.dropLast.length = d ∧
      HasType Δ Ξ Ψ'.dropLast b b d [] Λ' e' W ∧ StackTy Δ Ξ Ψ'.dropLast b S Λ' d tS tf ∧
      H''.dropLast.take b = H.take b := by
  subst hW
  have hHl : H.length - 2 = d - 1 := by rw [hH.len, hD]; omega
  rw [hHl]
  obtain ⟨H'', Ψ', e', hx, hv', ⟨hH'', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    xfer_ok (Ξ := Ξ) (b := b) (k := d - 1) (by omega) hHs hH (by omega) (Nat.le_refl _) hv
      (by rw [List.take_length]; exact hvt) (Ty.relocR_regionsBelow_of hmf hcf) (Ty.sub_refl _) hmf hcf
  have hdl : Ψ'.dropLast = Ψ'.take d := by
    rw [List.dropLast_eq_take, hlen', hD]; rfl
  have hH''l : H''.length = d + 1 := by rw [hH''.len, hlen', hD]
  have hbd' : b ≤ d := by omega
  refine ⟨H'', Ψ', e', hx, hv', heapOk_pop hH'', by rw [hdl, List.length_take]; omega, ?_, ?_, ?_⟩
  · rw [hdl, show d - 1 + 1 = d by omega] at *
    exact HasType.value_ctx hv' ht'
  · refine hS'.mono (fun d'' hd'' => ?_) ?_
    · rw [hdl, List.take_take, Nat.min_eq_left hd'']
      exact hle.take_take d''
    · rw [hdl, List.take_take, Nat.min_eq_left hbd']; exact htb
  · rw [take_dropLast_eq H'' (by omega : b ≤ H''.length - 1)]; exact htH

/-- relocR を重ねると後の深さだけが残る（imm の型 — P3b-4b の受けの型） -/
theorem Ty.relocR_relocR_mf {a k : Nat} : ∀ {t : Ty}, t.mutFree = true → t.chanFree = true →
    (t.relocR a).relocR k = t.relocR k
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm hc]
  | .union l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm.1 hc.1, Ty.relocR_relocR_mf hm.2 hc.2]
  | .prod l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm.1 hc.1, Ty.relocR_relocR_mf hm.2 hc.2]
  | .ref false _ t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm hc]
  | .slice false _ t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm hc]
  | .map false _ t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.relocR_relocR_mf hm hc]
  | .ref true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .slice true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .map true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .chan _ _, _, hc => by simp [Ty.chanFree] at hc
  | .fn _ _, _, _ => rfl
  | .own _ _ _, hm, _ => by simp [Ty.mutFree] at hm

/-- 送りの梱包の保存（P3b-4b）: 送り手のヒープ H の値 v（型 te — payOk te t）を項目の型 t0 = t.relocR 0 で梱包すると成功し、梱包は型付く -/
theorem pack_ok {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {v : Expr} {te t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hv : Value v) (he : HasType Δ Ξ Ψ b b Ψ.length [] [] v te) (hp : Ty.payOk te t = true) :
    ∃ w, packV (t.relocR 0) H v = some w ∧ PktOk Δ (t.relocR 0) w := by
  simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at hp
  obtain ⟨⟨⟨⟨hm1, hc1⟩, hm2⟩, hc2⟩, heq⟩ := hp
  have hdst : HeapOk Δ ∅ 0 [[]] [[]] := heapOk_push (Ψ := []) (H := []) heapOk_empty
  obtain ⟨H', Ψ', v', hx, hv', ⟨hH', hl', -, -, -, -, -⟩, ht'⟩ :=
    xfer_ok (Ξ := ∅) (b := 0) (k := 0) (Nat.le_refl 0) hH hdst (by simp) (Nat.le_refl _) hv
      (by rw [List.take_length]; exact he) (Ty.relocR_regionsBelow_of hm2 hc2) (by rw [heq]; exact Ty.sub_refl _) hm1 hc1
  have hHl : H'.length = 1 := by rw [hH'.len, hl']; rfl
  obtain ⟨σ, rfl⟩ : ∃ σ, Ψ' = [σ] := by
    match Ψ', hl' with
    | [σ], _ => exact ⟨σ, rfl⟩
  obtain ⟨c, rfl⟩ : ∃ c, H' = [c] := by
    match H', hHl with
    | [c], _ => exact ⟨c, rfl⟩
  refine ⟨⟨v', c, t.relocR 0⟩, by simp [packV, hx, Heap.r0], rfl, σ, hH', hv', ?_⟩
  simpa using ht'

/-- 送りの梱包（P3b-4 ③）: 梱包は `T?` の値 `some v`（閉じて空の受けの nil と同じ形） -/
theorem pack_ok_opt {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {v : Expr} {te t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hv : Value v) (he : HasType Δ Ξ Ψ b b Ψ.length [] [] v te) (hp : Ty.payOk te t = true) :
    ∃ w, packV (.opt (t.relocR 0)) H (.some v) = some w ∧ PktOk Δ (.opt (t.relocR 0)) w := by
  have hp' : Ty.payOk (.opt te) (.opt t) = true := by
    simpa [Ty.payOk, Ty.mutFree, Ty.chanFree, Ty.relocR] using hp
  simpa [Ty.relocR] using pack_ok (te := .opt te) (t := .opt t) hH (.some hv) (.some he) hp'

/-- 受けの展開の保存（P3b-4b）: 型付いた梱包 w（型 t0 — imm・chan なし）を受け手のヒープ H の最内の region（D - 1）へ写すと成功し、
受け手のストアは region D - 1 だけが伸び、値は t0.relocR (D - 1) に型付く -/
theorem unpack_ok {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {D : Nat}
    {tS tf : Ty} {Λ : LCtx} {w : Pkt} {t0 : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hD : Ψ.length = D) (hbD : b + 1 ≤ D) (hw : PktOk Δ t0 w)
    (hmf : t0.mutFree = true) (hcf : t0.chanFree = true) (hS : StackTy Δ Ξ Ψ b S Λ D tS tf) :
    ∃ (H' : Heap) (Ψ' : StoreTy) (v' : Expr),
      xfer (H.length - 1) (w.ty.relocR (H.length - 1)) [w.cs] H w.v = some (H', v') ∧
      Value v' ∧ HeapOk Δ Ξ b Ψ' H' ∧ Ψ'.length = D ∧ HasType Δ Ξ Ψ' b b D [] Λ v' (t0.relocR (D - 1)) ∧
      StackTy Δ Ξ Ψ' b S Λ D tS tf ∧ H'.take b = H.take b := by
  obtain ⟨hty, σ, hHs, hvw, hwt⟩ := hw
  have hHl : H.length = D := by rw [hH.len, hD]
  rw [hHl, hty]
  obtain ⟨H', Ψ', v', hx, hv', ⟨hH', hlen', hle, htb, htH, -, -⟩, ht'⟩ :=
    xfer_ok (Ξ := Ξ) (b := b) (k := D - 1) (Ξs := ∅) (bs := 0) (Ψs := [σ]) (Hs := [w.cs]) (by omega) hHs hH (by omega)
      (D0 := 1) (by simp) hvw (by simpa using hwt) (Ty.relocR_regionsBelow_of hmf hcf) (Ty.sub_refl _) hmf hcf
  refine ⟨H', Ψ', v', hx, hv', hH', by omega, ?_, ?_, htH⟩
  · have h1 := ht'.store_mono (storeLE_take_self Ψ' (D - 1 + 1)) (fun n _ hn => by
      rw [List.length_take] at hn
      rw [List.take_take, Nat.min_eq_left (by omega)])
    exact HasType.value_ctx hv' (HasType.value_depth_weaken hv' h1 (by omega))
  · exact hS.mono (fun d'' _ => hle.take_take d'') htb

/-- 写しは region k より下（take k）に触れない（型付けに依らない構造の性質 — 共有プレフィクスの不変の受けの腕） -/
theorem relocList_take {k : Nat} {f : Heap → Expr → Option (Heap × Expr)}
    (hf : ∀ {H H' : Heap} {v v' : Expr}, f H v = some (H', v') → H'.take k = H.take k) :
    ∀ {cs : List (Bool × Expr)} {H H1 : Heap} {cs' : List (Bool × Expr)},
      relocList f H cs = some (H1, cs') → H1.take k = H.take k
  | [], H, H1, cs', h => by simp [relocList] at h; obtain ⟨rfl, -⟩ := h; rfl
  | (m, w) :: cs, H, H1, cs', h => by
    simp only [relocList] at h
    split at h
    · rename_i H2 w' hw
      split at h
      · rename_i H3 cs'' hcs
        simp only [Option.some.injEq, Prod.mk.injEq] at h
        obtain ⟨rfl, -⟩ := h
        exact (relocList_take hf hcs).trans (hf hw)
      · cases h
    · cases h

theorem xfer_take {k : Nat} : ∀ {W : Ty} {Hs H H' : Heap} {v v' : Expr},
    xfer k W Hs H v = some (H', v') → H'.take k = H.take k := by
  intro W
  induction W with
  | opt t ih =>
    intro Hs H H' v v' h
    cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | (obtain ⟨⟨H2, w⟩, hw, he⟩ := Option.map_eq_some_iff.mp h
         simp only [Prod.mk.injEq] at he; obtain ⟨rfl, -⟩ := he; exact ih hw)
  | union l r ihl ihr =>
    intro Hs H H' v v' h
    cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | (obtain ⟨⟨H2, w⟩, hw, he⟩ := Option.map_eq_some_iff.mp h
         simp only [Prod.mk.injEq] at he; obtain ⟨rfl, -⟩ := he; first | exact ihl hw | exact ihr hw)
  | prod l r ihl ihr =>
    intro Hs H H' v v' h
    cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | skip
    split at h
    · rename_i H1 a' ha
      split at h
      · rename_i H2 b' hb
        simp only [Option.some.injEq, Prod.mk.injEq] at h
        obtain ⟨rfl, -⟩ := h
        exact (ihr hb).trans (ihl ha)
      · cases h
    · cases h
  | ref m r t ih =>
    intro Hs H H' v v' h
    cases m <;> cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | skip
    repeat' split at h
    all_goals first
      | (cases h; done)
      | skip
    simp only [Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, -⟩ := h
    rw [take_set_of_le (Nat.le_refl k)]
    exact relocList_take (fun hw => ih hw) (by assumption)
  | slice m r t ih =>
    intro Hs H H' v v' h
    cases m <;> cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | skip
    repeat' split at h
    all_goals first
      | (cases h; done)
      | skip
    simp only [Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, -⟩ := h
    rw [take_set_of_le (Nat.le_refl k)]
    exact relocList_take (fun hw => ih hw) (by assumption)
  | map m r t ih =>
    intro Hs H H' v v' h
    cases m <;> cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h
    all_goals first
      | (obtain ⟨rfl, -⟩ := h; rfl)
      | skip
    repeat' split at h
    all_goals first
      | (cases h; done)
      | skip
    simp only [Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, -⟩ := h
    rw [take_set_of_le (Nat.le_refl k)]
    exact relocList_take (fun hw => ih hw) (by assumption)
  | _ =>
    intro Hs H H' v v' h
    cases v <;> simp only [xfer, Option.some.injEq, Prod.mk.injEq] at h <;> (obtain ⟨rfl, -⟩ := h; rfl)

theorem take_of_xfer {b k : Nat} {W : Ty} {Hs H H' : Heap} {v v' : Expr} (hbk : b ≤ k)
    (hx : xfer k W Hs H v = some (H', v')) : H'.take b = H.take b := by
  have key : ∀ (L : Heap), (L.take k).take b = L.take b := fun L => by
    rw [List.take_take]; congr 1; omega
  rw [← key H', xfer_take hx, key]

/-! ## 深さ・take の付け替えヘルパ -/

theorem HasType.of_take_full {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {e : Expr}
    {t : Ty} (hD : Ψ.length = d) (h : HasType Δ Ξ (Ψ.take d) f b d Γ Λ e t) :
    HasType Δ Ξ Ψ f b d Γ Λ e t := by
  subst hD
  rwa [List.take_length] at h

theorem HasType.to_take_full {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {e : Expr}
    {t : Ty} (hD : Ψ.length = d) (h : HasType Δ Ξ Ψ f b d Γ Λ e t) :
    HasType Δ Ξ (Ψ.take d) f b d Γ Λ e t := by
  subst hD
  rwa [List.take_length]


/-- StateTy の賢いコンストラクタ（深さの等式を外出しする） -/
theorem StateTy.eval' {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {e : Expr}
    {t tf : Ty} {D : Nat} (hD : Ψ.length = D) (he : HasType Δ Ξ Ψ b b D [] Λ e t)
    (hS : StackTy Δ Ξ Ψ b S Λ D t tf) (hH : HeapOk Δ Ξ b Ψ H) : StateTy Δ Ξ b (.eval H S e) tf := by
  subst hD
  exact .eval he hS hH

theorem StateTy.ret' {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {v : Expr}
    {t tf : Ty} {D : Nat} (hD : Ψ.length = D) (hv : Value v) (he : HasType Δ Ξ Ψ b b D [] Λ v t)
    (hS : StackTy Δ Ξ Ψ b S Λ D t tf) (hH : HeapOk Δ Ξ b Ψ H) : StateTy Δ Ξ b (.ret H S v) tf := by
  subst hD
  exact .ret hv he hS hH

theorem StateTy.par' {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack}
    {s1 s2 : State} {t1 t2 tf : Ty} {D : Nat} (hD : Ψ.length = D) (h1 : StateTy Δ Ξ D s1 t1)
    (h2 : StateTy Δ Ξ D s2 t2) (hf1 : s1.isFam = false) (hf2 : s2.isFam = false)
    (hS : StackTy Δ Ξ Ψ b S Λ D .unit tf) (hH : HeapOk Δ Ξ b Ψ H) :
    StateTy Δ Ξ b (.par H S s1 s2) tf := by
  subst hD
  exact .par h1 h2 hf1 hf2 hS hH

/-! ## 段 6 P1: task の型付けの補題 -/

/-- 葉の 1 歩の型環境の伸び: 共有の部分だけ伸びて、自分の子の表 tk は変わらない（tk を伸ばすのは fam の main の spawn だけ） -/
structure ChanLEt (Ξ Ξ' : ChanTy) : Prop where
  le : ChanLE Ξ Ξ'
  tk : Ξ'.tk = Ξ.tk

theorem ChanLEt.refl (Ξ : ChanTy) : ChanLEt Ξ Ξ := ⟨.refl Ξ, rfl⟩

theorem chanLEt_addCh (Ξ : ChanTy) (p : StoreTy × Ty) : ChanLEt Ξ (Ξ.addCh p) := ⟨chanLE_addCh Ξ p, rfl⟩

/-- ChanOk は共有の部分（ch）だけを見る: 待機中の値は mutFree なので世界ごとの部分に依らない -/
theorem chanOk_world {Δ : Defs} {Ξ Ξ' : ChanTy} {K : ChanSt} (hC : ChanOk Δ Ξ K) (hch : Ξ'.ch = Ξ.ch)
    (hep : Ξ'.ep = Ξ.ep) : ChanOk Δ Ξ' K := by
  refine ⟨by rw [hch]; exact hC.len, fun c Ψc t h => hC.wf c Ψc t (by rw [← hch]; exact h), ?_,
    fun k t h => hC.epdom k t (by rw [← hep]; exact h), fun k e h => by rw [hep]; exact hC.eprev k e h,
    fun k t e h1 h2 => hC.eptyped k t e (by rw [← hep]; exact h1) h2⟩
  intro c q Ψc t h1 h2 v hv
  rw [hch] at h2
  obtain ⟨hvv, ht⟩ := hC.typed c q Ψc t h1 h2 v hv
  exact ⟨hvv, HasType.value_world hvv (hC.wf c Ψc t h2).2 hch ht⟩

/-- loc-free な値はどの世界へも移せる（共有の ch が同じ世界どうし — 子の task の結果を親の世界で読む口） -/
theorem HasType.value_anywhere {Δ : Defs} {Ξ Ξ' : ChanTy} {Ψ Ψ' : StoreTy} {f b d f' b' d' : Nat} {Γ Γ' : Ctx}
    {Λ Λ' : LCtx} {v : Expr} {t : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t)
    (hb : t.regionsBelow 0 = true) (hch : Ξ'.ch = Ξ.ch) :
    HasType Δ Ξ' Ψ' f' b' d' Γ' Λ' v t := by
  have h1 := HasType.value_export hv he hb
  have h2 := HasType.value_world hv (Ty.mutFree_of_locFree hb) hch h1
  exact HasType.value_ctx hv (HasType.value_import (Ψ := Ψ') (f := f') (b := b') (d := d') (Γ := Γ') hv h2 hb)

/-- 1 歩踏める状態は panic でない（par_step_commute の要: panic は terminal） -/
theorem notPanic_of_step {π : List Bool} {s s' : State} {K K' : ChanSt}
    (h : step Δ π s K = some (s', K')) : s.isPanic = false := by
  cases s with
  | panic H => simp [step] at h
  | _ => rfl

/-! ## blocked（recv 待ち・task の待ち） -/

/-- 待機状態: 空チャネルの recv で止まっているか、両タスクが（完了か待機で）
少なくとも一方が待機のまま join できない par。panic は待機ではない（1 歩で伝播する）。
task（段 6 P1）は、main が待ち（Blocked・未完了の子の join / try・子が未決着の scope の出口・main は終わったが子が未完了・main が死）で、
子は全員 完了 か panic の葉 か待機（kidsStuck）のもの -/
inductive Blocked (K : ChanSt) : State → Prop where
  | recv {H S c} : K.leg[c]? = some [] → Blocked K (.ret H (.recvK :: S) (.chanV c))
  | parBB {H S s1 s2} : Blocked K s1 → Blocked K s2 → Blocked K (.par H S s1 s2)
  | parBD {H S s1 s2} : Blocked K s1 → (taskDone s2).isSome → Blocked K (.par H S s1 s2)
  | parDB {H S s1 s2} : (taskDone s1).isSome → Blocked K s2 → Blocked K (.par H S s1 s2)
  | famM {id o n m ks} : Blocked K m → (∀ H S c, m ≠ .ret H (.recvK :: S) (.chanV c)) →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n m ks)
  | famJ {id o n H S tj rs i rs' kid ks} : o ≤ i → ks.get? (i - o) = some (rs', kid) →
      (taskDone kid).isSome = false → kid.mainDead = false →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.ret H (.joinK tj :: S) (.taskV rs i)) ks)
  | famT {id o n H S t rs i rs' kid ks} : o ≤ i → ks.get? (i - o) = some (rs', kid) →
      (taskDone kid).isSome = false → kid.mainDead = false →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.ret H (.tryK t :: S) (.taskV rs i)) ks)
  | famS {id o n H S t ε v ks} : ks.settledAt (H.length - 1) = false →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.ret H (.scopeK t ε :: S) v) ks)
  | famD {id o n m ks} : (taskDone m).isSome → kidsDone ks = false →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n m ks)
  | famX {id o n H ks} :
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.panic H) ks)
  /-- 満杯の端点への送信（段 6 P1 — 有界 chan） -/
  | famSnd {id o n H S p k r v ks ent} : K.ep (p, k) = some ent → ent.otx = id → ent.closed = false → ent.cap ≤ ent.q.length →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.ret H (.sendR (.epV p k true r) :: S) v) ks)
  /-- 空の端点からの受信 -/
  | famRcv {id o n H S p k r ks ent} : K.ep (p, k) = some ent → ent.orx = id → ent.q = [] → ent.closed = false →
      (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) →
      Blocked K (.fam id o n (.ret H (.recvK :: S) (.epV p k false r)) ks)

theorem Blocked.taskDone_none {K : ChanSt} {s : State} (h : Blocked K s) :
    taskDone s = none := by
  induction h with
  | famM _ _ _ ihm => simp [taskDone, ihm]
  | famD _ hk _ => simp [taskDone, hk]
  | _ => simp [taskDone]

theorem Blocked.notPanic {K : ChanSt} {s : State} (h : Blocked K s) :
    s.isPanic = false := by
  cases h <;> rfl

/-- 完了形は panic ではない -/
theorem notPanic_of_done {s : State} (h : (taskDone s).isSome) : s.isPanic = false := by
  cases s <;> simp [taskDone, State.isPanic] at h ⊢

/-- 子が全員 完了 / panic の葉 / 待機 なら、子の列は歩けない -/
theorem stepKids_stuck {K : ChanSt} {ks : Kids}
    (hk : ∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false →
      ∀ (π : List Bool), step Δ π kid K = none) :
    ∀ (π : List Bool), stepKids Δ π ks K = none := by
  intro π
  cases hsk : stepKids Δ π ks K with
  | none => rfl
  | some p =>
    obtain ⟨ks', K'⟩ := p
    obtain ⟨i, rs, kid, kid', π', hget, hst, -⟩ := stepKids_some hsk
    have hd := taskDone_none_of_step hst
    have hp := notPanic_of_step hst
    rw [hk i rs kid hget (by simp [hd]) hp π'] at hst
    cases hst

/-- 待機 = 進めない（Blocked が本当に「これ以上動かない」ことの中身） -/
theorem blocked_no_step {K : ChanSt} {s : State} (h : Blocked K s) :
    ∀ (π : List Bool), step Δ π s K = none := by
  induction h with
  | recv hK => intro π; simp [step, hK]
  | parBB h1 h2 ih1 ih2 =>
    intro π
    rw [step_par_def]
    rw [if_neg (by simp [h1.taskDone_none])]
    cases π with
    | nil => rfl
    | cons c π' =>
      cases c with
      | true => simp [h1.notPanic, ih1 π']
      | false => simp [h2.notPanic, ih2 π']
  | parBD h1 h2 ih1 =>
    intro π
    rw [step_par_def]
    rw [if_neg (by simp [h1.taskDone_none])]
    cases π with
    | nil => rfl
    | cons c π' =>
      cases c with
      | true => simp [h1.notPanic, ih1 π']
      | false => simp [notPanic_of_done h2, step_done_none h2]
  | parDB h1 h2 ih2 =>
    intro π
    rw [step_par_def]
    rw [if_neg (by simp [h2.taskDone_none])]
    cases π with
    | nil => rfl
    | cons c π' =>
      cases c with
      | true => simp [notPanic_of_done h1, step_done_none h1]
      | false => simp [h2.notPanic, ih2 π']
  | famM hm hnr _ ihm ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp only [List.tail]; rw [ihm π']; cases hm <;> first | rfl | exact absurd rfl (hnr _ _ _)
    | nil => simp only [List.tail]; rw [ihm []]; cases hm <;> first | rfl | exact absurd rfl (hnr _ _ _)
  | @famJ id o n H S tj rs i rs' kid ks hoi hget hd hdead _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    have hd' : taskDone kid = none := by cases h : taskDone kid <;> simp_all
    have hr' := taskRes_none_of_taskDone hd'
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, hget, hoi, hr', hdead]
    | nil => simp [famMain, hget, hoi, hr', hdead]
  | @famT id o n H S t rs i rs' kid ks hoi hget hd hdead _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    have hd' : taskDone kid = none := by cases h : taskDone kid <;> simp_all
    have hr' := taskRes_none_of_taskDone hd'
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, hget, hoi, hr', hdead]
    | nil => simp [famMain, hget, hoi, hr', hdead]
  | famS hst _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, hst]
    | nil => simp [famMain, hst]
  | famD hm _ _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp only [List.tail]; rw [step_done_none hm]; exact famMain_done hm
    | nil => simp only [List.tail]; rw [step_done_none hm]; exact famMain_done hm
  | famX _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, step]
    | nil => simp [famMain, step]
  | famSnd hk hown hcl hfull _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    have hnl : ¬ (_ < _) := Nat.not_lt.mpr hfull
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, hk, hown, hcl, hnl]
    | nil => simp [famMain, hk, hown, hcl, hnl]
  | famRcv hk hown hemp hcl _ ihk =>
    intro π
    rw [step_fam_def]
    have hks := stepKids_stuck ihk
    cases π with
    | cons c π' =>
      cases c with
      | false => simp [hks π']
      | true => simp [famMain, hk, hown, hemp, hcl]
    | nil => simp [famMain, hk, hown, hemp, hcl]

/-- 完了した task の結果とそのヒープ（P3b-4 — join / try が写す元）: ヒープは task の世界で型付き、値は結果型に型付く -/
theorem taskRes_typed {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tr : Ty} {Hk : Heap} {v : Expr}
    (h : StateTy Δ Ξ b s tr) (hd : taskRes s = some (Hk, v)) :
    ∃ Ψ, HeapOk Δ Ξ b Ψ Hk ∧ Value v ∧ HasType Δ Ξ Ψ b b Ψ.length [] [] v tr := by
  induction h generalizing Hk v with
  | eval => simp [taskRes] at hd
  | par => simp [taskRes] at hd
  | panic => simp [taskRes] at hd
  | ret hv he hS hH =>
    rename_i Ξ b Ψ H S w t tf
    generalize hD : Ψ.length = D at he hS
    cases hS with
    | nil =>
      simp only [taskRes, Option.some.injEq, Prod.mk.injEq] at hd
      obtain ⟨rfl, rfl⟩ := hd
      exact ⟨Ψ, hH, hv, by rw [hD]; exact he⟩
    | taskK =>
      simp only [taskRes, Option.some.injEq, Prod.mk.injEq] at hd
      obtain ⟨rfl, rfl⟩ := hd
      exact ⟨Ψ, hH, hv, by rw [hD]; exact he⟩
    | _ => simp [taskRes] at hd
  | fam Ξs bs tcs _ _ _ _ _ _ _ _ _ _ ihm _ =>
    simp only [taskRes] at hd
    split at hd
    · exact ihm hd
    · simp at hd

/-- failAt の中身（構造）: 正準順で最初の、region rs0 の未回収の子で、結果が `pair v (some e)` のもの -/
theorem Kids.failAt_spec : ∀ {ks : Kids} {rs0 : Nat} {εk : Ty} {Hk : Heap} {e : Expr},
    ks.failAt rs0 = some (εk, Hk, e) →
    ∃ i kid v, ks.get? i = some (rs0, kid) ∧ ks.tag? i = some (εk, false) ∧ taskRes kid = some (Hk, .pair v (.some e))
  | .nil, _, _, _, _, h => by simp [Kids.failAt] at h
  | .cons r tg s rest, rs0, εk, Hk, e, h => by
    simp only [Kids.failAt] at h
    split at h
    · rename_i Hk' v e' hr hc hres
      simp only [Option.some.injEq, Prod.mk.injEq] at h
      obtain ⟨rfl, rfl, rfl⟩ := h
      have hr' : r = rs0 := by simpa using hr
      subst hr'
      refine ⟨0, s, v, rfl, ?_, hres⟩
      simp only [Kids.tag?]; rw [← hc]
    · obtain ⟨i, kid, v, h1, h2, h3⟩ := Kids.failAt_spec h
      exact ⟨i + 1, kid, v, h1, h2, h3⟩

/-- 未回収の失敗の err の型（P3b-4 1b'）: 子の世界で、子の err の型 ε0（imm・chan なし・relocR 0 が札の型）に型付く -/
theorem failAt_typed {Δ : Defs} {ks : Kids} {Ξs : Nat → ChanTy} {bs : Nat → Nat} {tcs : Nat → Ty}
    {Ξ : ChanTy} {o rs0 : Nat} {εk : Ty} {Hk : Heap} {e : Expr}
    (hex : ∀ i rs kid, ks.get? i = some (rs, kid) → ∃ t, Ξ.tk[o + i]? = some (rs, t))
    (hkt : ∀ i rs kid t, ks.get? i = some (rs, kid) → Ξ.tk[o + i]? = some (rs, t) →
      (tcs i).mutFree = true ∧ (tcs i).chanFree = true ∧ (tcs i).relocR rs = t)
    (hk : ∀ i rs kid, ks.get? i = some (rs, kid) → StateTy Δ (Ξs i) (bs i) kid (tcs i))
    (htg : ∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = .prod t (.opt ε0) ∧ ε0.relocR 0 = tg.1)
    (h : ks.failAt rs0 = some (εk, Hk, e)) :
    ∃ (i : Nat) (Ψk : StoreTy) (ε0 : Ty), HeapOk Δ (Ξs i) (bs i) Ψk Hk ∧ Value e ∧
      HasType Δ (Ξs i) Ψk (bs i) (bs i) Ψk.length [] [] e ε0 ∧ ε0.relocR 0 = εk ∧
      ε0.mutFree = true ∧ ε0.chanFree = true := by
  obtain ⟨i, kid, v, hg, htag, hres⟩ := Kids.failAt_spec h
  obtain ⟨t, ε0, htc, hε0⟩ := htg i _ htag
  obtain ⟨tt, htt⟩ := hex i rs0 kid hg
  obtain ⟨hmf, hcf, -⟩ := hkt i rs0 kid tt hg htt
  obtain ⟨Ψk, hHk, hvv, hvt⟩ := taskRes_typed (hk i rs0 kid hg) hres
  rw [htc] at hvt hmf hcf
  simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hmf hcf
  generalize hL : Ψk.length = L at hvt
  cases hvv with
  | pair _ hv2 =>
    cases hv2 with
    | some hve =>
      cases hvt with
      | pair _ h2 =>
        cases h2 with
        | some h3 => exact ⟨i, Ψk, ε0, hHk, hve, by rw [hL]; exact h3, hε0, hmf.2, hcf.2⟩

/-- 完了した task の値（段 6 P1 — 子の結果を親が join で受ける口）: 値で、その task の世界で結果型が付く -/
theorem taskDone_value {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tr : Ty} {v : Expr}
    (h : StateTy Δ Ξ b s tr) (hd : taskDone s = some v) :
    Value v ∧ ∃ (Ψ : StoreTy) (d : Nat), HasType Δ Ξ Ψ b b d [] [] v tr := by
  have h1 := taskDone_eq_taskRes s; rw [hd] at h1
  cases hr : taskRes s with
  | none => rw [hr] at h1; simp at h1
  | some p =>
    obtain ⟨Hk, w⟩ := p
    rw [hr] at h1; simp at h1; subst h1
    obtain ⟨Ψ, -, hv, he⟩ := taskRes_typed h hr
    exact ⟨hv, Ψ, Ψ.length, he⟩

/-- strlit の書き換え先（strCells）の型付け: region r の mut byte slice にバイト（tobyte (lit c)）を appendM で積んでも型は変わらない -/
theorem HasType.strCells {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {Λ : LCtx} {r : Nat}
    (hbr : b ≤ r) :
    ∀ (bs : List Int) {e : Expr}, HasType Δ Ξ Ψ f b d Γ Λ e (.slice true r .byte) →
      HasType Δ Ξ Ψ f b d Γ Λ (Expr.strCells bs e) (.slice true r .byte)
  | [], _, he => he
  | _ :: cs, _, he => HasType.strCells hbr cs (.appendM he (.tobyte .lit) hbr)

/-! ## preservation -/

/-- preservation の eval 腕（V4-2 で分離: 1 定理のままだと既定スレッドスタックを超える） -/
theorem preservation_eval {Δ : Defs} {Ξ : ChanTy} {Λ : LCtx} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {S : Stack} {e : Expr} {t tf : Ty} (hΔ : DefsOk Δ)
    (he : HasType Δ Ξ Ψ b b Ψ.length [] Λ e t) (hS : StackTy Δ Ξ Ψ b S Λ Ψ.length t tf)
    (hH : HeapOk Δ Ξ b Ψ H) :
    ∀ {π : List Bool} {K : ChanSt} {s' : State} {K' : ChanSt},
      ChanOk Δ Ξ K → step Δ π (.eval H S e) K = some (s', K') →
      ∃ Ξ', ChanLEt Ξ Ξ' ∧ StateTy Δ Ξ' b s' tf ∧ ChanOk Δ Ξ' K' := by
    intro π K s' K' hC hs
    generalize hD : Ψ.length = D at he hS
    cases e with
    | lit n =>
      simp only [step] at hs; cases hs
      cases he
      exact ⟨Ξ, .refl Ξ, .ret' hD (.lit n) .lit hS hH, hC⟩
    | blit n =>
      simp only [step] at hs; cases hs
      cases he with
      | blit h1 h2 => exact ⟨Ξ, .refl Ξ, .ret' hD (.blit h1 h2) (.blit h1 h2) hS hH, hC⟩
    | flit n =>
      simp only [step] at hs; cases hs
      cases he with
      | flit => exact ⟨Ξ, .refl Ξ, .ret' hD (.flit n) .flit hS hH, hC⟩
    | tt =>
      simp only [step] at hs; cases hs
      cases he
      exact ⟨Ξ, .refl Ξ, .ret' hD .tt .tt hS hH, hC⟩
    | ff =>
      simp only [step] at hs; cases hs
      cases he
      exact ⟨Ξ, .refl Ξ, .ret' hD .ff .ff hS hH, hC⟩
    | triv =>
      simp only [step] at hs; cases hs
      cases he
      exact ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS hH, hC⟩
    | nil t₀ =>
      simp only [step] at hs; cases hs
      cases he
      exact ⟨Ξ, .refl Ξ, .ret' hD (.nil t₀) .nil hS hH, hC⟩
    | loc r a =>
      simp only [step] at hs; cases hs
      cases he with
      | loc h1 h2 h3 h4 h5 h6 =>
        exact ⟨Ξ, .refl Ξ, .ret' hD (.loc r a) (.loc h1 h2 h3 h4 h5 h6) hS hH, hC⟩
    | chanV c =>
      simp only [step] at hs; cases hs
      cases he with
      | chanV h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ, .ret' hD (.chanV c) (.chanV h1 h2 h3) hS hH, hC⟩
    | var i =>
      cases he with
      | var h => simp at h
    | letE e body =>
      simp only [step] at hs; cases hs
      cases he with
      | letE h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.letK (h2.to_take_full hD) hS) hH, hC⟩
    | add a c =>
      simp only [step] at hs; cases hs
      cases he with
      | add h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.addL (h2.to_take_full hD) hS) hH, hC⟩
    | lt a c =>
      simp only [step] at hs; cases hs
      cases he with
      | lt h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.ltL (h2.to_take_full hD) hS) hH, hC⟩
    | arith op a c =>
      simp only [step] at hs; cases hs
      cases he with
      | arith h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.arithL (h2.to_take_full hD) hS) hH, hC⟩
    | farith op a c =>
      simp only [step] at hs; cases hs
      cases he with
      | farith h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.farithL (h2.to_take_full hD) hS) hH, hC⟩
    | cmp op a c =>
      simp only [step] at hs; cases hs
      cases he with
      | cmp h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.cmpL (h2.to_take_full hD) hS) hH, hC⟩
    | fcmp op a c =>
      simp only [step] at hs; cases hs
      cases he with
      | fcmp h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.fcmpL (h2.to_take_full hD) hS) hH, hC⟩
    | pair a c =>
      simp only [step] at hs; cases hs
      cases he with
      | pair h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.pairL (h2.to_take_full hD) hS) hH, hC⟩
    | fst e =>
      simp only [step] at hs; cases hs
      cases he with
      | fst h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.fstK hS) hH, hC⟩
    | ann e t =>
      simp only [step] at hs; cases hs
      cases he with
      | ann h1 hsub => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.annK hsub hS) hH, hC⟩
    | snd e =>
      simp only [step] at hs; cases hs
      cases he with
      | snd h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.sndK hS) hH, hC⟩
    | fnref fn ts =>
      simp only [step] at hs; cases hs
      cases he with
      | fnref hfn hl ha => exact ⟨Ξ, .refl Ξ, .ret' hD (.fnref fn ts) (.fnref hfn hl ha) hS hH, hC⟩
    | callv ef e =>
      simp only [step] at hs; cases hs
      cases he with
      | callv hf harg hsub hbd =>
        exact ⟨Ξ, .refl Ξ, .eval' hD hf (.callvL (harg.to_take_full hD) hsub hbd hS) hH, hC⟩
    | call fn ts e =>
      simp only [step] at hs; cases hs
      cases he with
      | call hfn hlen hargs harg hsub hbd =>
        exact ⟨Ξ, .refl Ξ, .eval' hD harg (.callK hfn hlen hargs hsub hbd hS) hH, hC⟩
    | callM fn ts e =>
      simp only [step] at hs; cases hs
      cases he with
      | callM hfn hlen hargs harg hanc hsub hbd had =>
        exact ⟨Ξ, .refl Ξ, .eval' hD harg (.callMK hfn hlen hargs hanc hsub hbd had hS) hH, hC⟩
    | ite c th el =>
      simp only [step] at hs; cases hs
      cases he with
      | ite h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ,
          .eval' hD h1 (.iteK (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | some e =>
      simp only [step] at hs; cases hs
      cases he with
      | some h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.someK hS) hH, hC⟩
    | ifnil e n s =>
      simp only [step] at hs; cases hs
      cases he with
      | ifnil h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ,
          .eval' hD h1 (.ifnilK (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | inl r e =>
      simp only [step] at hs; cases hs
      cases he with
      | inl h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.inlK hS) hH, hC⟩
    | inr l e =>
      simp only [step] at hs; cases hs
      cases he with
      | inr h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.inrK hS) hH, hC⟩
    | case e bl br =>
      simp only [step] at hs; cases hs
      cases he with
      | case h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ,
          .eval' hD h1 (.caseK (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | block e =>
      simp only [step] at hs; cases hs
      cases he with
      | block h1 hb =>
        have hbΨ : b ≤ Ψ.length := by rw [hD]; exact hS.le_depth
        refine ⟨Ξ, .refl Ξ, .eval' (Λ := Λ) (Ψ := Ψ ++ [[]]) (D := D + 1) (t := t)
          (by simp [hD]) ?_ ?_ (heapOk_push hH), hC⟩
        · exact h1.store_mono (storeLE_append Ψ [[]]) (storePre_of_take_eq (take_append_left_of_le hbΨ [[]]))
        · exact .regionK hb (hS.mono (fun d' _ => (storeLE_append Ψ [[]]).take_take d')
            (take_append_left_of_le hbΨ [[]]))
    | blockR t₀ e =>
      simp only [step] at hs; cases hs
      cases he with
      | blockR h1 hr hb =>
        rename_i tB
        have hbΨ : b ≤ Ψ.length := by rw [hD]; exact hS.le_depth
        refine ⟨Ξ, .refl Ξ, .eval' (Λ := Λ) (Ψ := Ψ ++ [[]]) (D := D + 1) (t := tB)
          (by simp [hD]) ?_ ?_ (heapOk_push hH), hC⟩
        · exact h1.store_mono (storeLE_append Ψ [[]]) (storePre_of_take_eq (take_append_left_of_le hbΨ [[]]))
        · exact .regionKR hr hb (hS.mono (fun d' _ => (storeLE_append Ψ [[]]).take_take d')
            (take_append_left_of_le hbΨ [[]]))
    | copyTo k t₀ e =>
      simp only [step] at hs; cases hs
      cases he with
      | copyTo h1 hk hr hb hcf =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.copyK (by omega) hr hb hcf hS) hH, hC⟩
    | alloc m e =>
      simp only [step] at hs; cases hs
      cases he with
      | alloc h1 hb hbd hmf =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.allocK hb hbd hmf hS) hH, hC⟩
    | deref e =>
      simp only [step] at hs; cases hs
      cases he with
      | deref h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.derefK hS) hH, hC⟩
    | assign l e =>
      simp only [step] at hs; cases hs
      cases he with
      | assign h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.assignL (h2.to_take_full hD) hS) hH, hC⟩
    | label t₀ e =>
      simp only [step] at hs; cases hs
      cases he with
      | label h1 hb => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.labelK hb hS) hH, hC⟩
    | unreach t₀ =>
      -- 到達しない（A5）: 1 歩で panic（終端 — 型の義務なし）
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | jump n t₀ e =>
      simp only [step] at hs; cases hs
      cases he with
      | jump hn h1 hrel => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.jumpK hn hrel hS) hH, hC⟩
    | whileE c body =>
      simp only [step] at hs; cases hs
      cases he with
      | whileE h1 h2 =>
        exact ⟨Ξ, .refl Ξ,
          .eval' hD h1 (.whileK (h1.to_take_full hD) (h2.to_take_full hD) hS) hH, hC⟩
    | freeze e =>
      simp only [step] at hs; cases hs
      cases he with
      | freeze h1 hmf => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.freezeK hmf hS) hH, hC⟩
      | freezes h1 hmf => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.freezeKs hmf hS) hH, hC⟩
      | freezem h1 hmf => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.freezeKm hmf hS) hH, hC⟩
    | mkslice m t₀ =>
      cases he with
      | mkslice hbt hbd hmf =>
        rename_i d'
        simp only [step] at hs
        split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          cases hs
          have hHlen : H.length = d' + 1 := by rw [hH.len, hD]
          have hk : H.length - 1 = d' := by omega
          rw [hk] at hρ ⊢
          refine ⟨Ξ, .refl Ξ, .ret' hD (.slicev m d' ρ.length 0)
            (.slicev (fun k hk0 => absurd hk0 (Nat.not_lt_zero k)) (by omega)
              (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbd⟩) hmf (fun _ => hbt)) hS hH, hC⟩
    | mksliceAt m t₀ r =>
      cases he with
      | mksliceAt hrb hbr hrd hmf hcf =>
        simp only [step] at hs
        split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          cases hs
          refine ⟨Ξ, .refl Ξ, .ret' hD (.slicev m r ρ.length 0)
            (.slicev (fun k hk0 => absurd hk0 (Nat.not_lt_zero k)) hrd
              (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩) hmf (fun _ => hrb)) hS hH, hC⟩
    | mkmapAt m t₀ r =>
      cases he with
      | mkmapAt hko hrb hbr hrd hmf hcf =>
        simp only [step] at hs
        split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          cases hs
          refine ⟨Ξ, .refl Ξ, .ret' hD (.mapv m r ρ.length 0)
            (.mapv (fun k hk0 => absurd hk0 (Nat.not_lt_zero k)) hrd
              (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩) hmf (fun _ => hrb)) hS hH, hC⟩
    | strlit bs r =>
      cases he with
      | strlit hbr hrd =>
        simp only [step] at hs
        split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          cases hs
          refine ⟨Ξ, .refl Ξ, .eval' hD (.freezes (HasType.strCells hbr bs
            (.slicev (fun k hk0 => absurd hk0 (Nat.not_lt_zero k)) hrd (Nat.le_refl _) rfl
              (fun _ => ⟨rfl, hbr⟩) (fun h => by cases h) (fun _ => by simp [Ty.regionsBelow])))
            (by simp [Ty.mutFree])) hS hH, hC⟩
    | index e i ot =>
      simp only [step] at hs; cases hs
      cases he with
      | index h1 h2 hrd =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.idxL (h2.to_take_full hD) hrd hS) hH, hC⟩
    | lenE e =>
      simp only [step] at hs; cases hs
      cases he with
      | lenE h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.lenK hS) hH, hC⟩
    | tobyte e =>
      simp only [step] at hs; cases hs
      cases he with
      | tobyte h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.tobyteK hS) hH, hC⟩
    | fconv op e =>
      simp only [step] at hs; cases hs
      cases he with
      | fconv h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.fconvK hS) hH, hC⟩
    | toint e =>
      simp only [step] at hs; cases hs
      cases he with
      | toint h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.tointK hS) hH, hC⟩
    | append e v =>
      simp only [step] at hs; cases hs
      cases he with
      | appendM h1 h2 hbr =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1
          (.appL (h2.to_take_full hD) (fun _ => ⟨rfl, hbr⟩) (fun h => by cases h) hS) hH, hC⟩
      | appendI h1 h2 hbd hbt =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1
          (.appL (h2.to_take_full hD) (fun h => by cases h) (fun _ => ⟨rfl, hbd, hbt⟩) hS) hH, hC⟩
    | setidx e i v =>
      simp only [step] at hs; cases hs
      cases he with
      | setidx h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1
          (.sixL (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | subslice e sa sb =>
      simp only [step] at hs; cases hs
      cases he with
      | subslice h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1
          (.subL (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | eqs e1 e2 =>
      simp only [step] at hs; cases hs
      cases he with
      | eqs h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.eqsL (h2.to_take_full hD) hS) hH, hC⟩
    | concat e1 e2 =>
      simp only [step] at hs; cases hs
      cases he with
      | concat h1 h2 hbd =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.catL (h2.to_take_full hD) rfl hbd hS) hH, hC⟩
    | slicev mt r base len =>
      simp only [step] at hs; cases hs
      cases he with
      | slicev hk h2 h3 h4 h5 h6 h7 =>
        exact ⟨Ξ, .refl Ξ, .ret' hD (.slicev mt r base len)
          (.slicev hk h2 h3 h4 h5 h6 h7) hS hH, hC⟩
    | mkmap m t₀ =>
      cases he with
      | mkmap hko hbt hbd hmf =>
        rename_i d' _ _
        simp only [step] at hs
        split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          cases hs
          have hHlen : H.length = d' + 1 := by rw [hH.len, hD]
          have hk : H.length - 1 = d' := by omega
          rw [hk] at hρ ⊢
          refine ⟨Ξ, .refl Ξ, .ret' hD (.mapv m d' ρ.length 0)
            (.mapv (fun k hk0 => absurd hk0 (Nat.not_lt_zero k)) (by omega)
              (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbd⟩) hmf (fun _ => hbt)) hS hH, hC⟩
    | getm t₀ e k =>
      simp only [step] at hs; cases hs
      cases he with
      | getm h1 h2 _ hsub =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.gtmL (h2.to_take_full hD) hsub hS) hH, hC⟩
    | setm e k v =>
      simp only [step] at hs; cases hs
      cases he with
      | setm h1 h2 h3 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1
          (.stmL (h2.to_take_full hD) (h3.to_take_full hD) hS) hH, hC⟩
    | delm t₀ e k =>
      simp only [step] at hs; cases hs
      cases he with
      | delm h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.dlmL (h2.to_take_full hD) hS) hH, hC⟩
    | lenm e =>
      simp only [step] at hs; cases hs
      cases he with
      | lenm h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.lenmK hS) hH, hC⟩
    | keysm e =>
      simp only [step] at hs; cases hs
      cases he with
      | keysm h1 hko hrb hbd => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.keysmK rfl hbd hko hrb hS) hH, hC⟩
    | mapv mt r base len =>
      simp only [step] at hs; cases hs
      cases he with
      | mapv hk h2 h3 h4 h5 h6 h7 =>
        exact ⟨Ξ, .refl Ξ, .ret' hD (.mapv mt r base len)
          (.mapv hk h2 h3 h4 h5 h6 h7) hS hH, hC⟩
    | newchan rc t₀ =>
      simp only [step] at hs; cases hs
      cases he with
      | newchan hf hl hm =>
        -- hf : rc ≤ b（機械状態では f = b）。b ≤ D なのでスナップショットの長さは rc
        have hbD : b ≤ D := hS.le_depth
        have hlen : (Ψ.take rc).length = rc := by
          simp only [List.length_take]
          omega
        have hle : ChanLE Ξ (Ξ.addCh (Ψ.take rc, t₀)) := chanLE_addCh Ξ (Ψ.take rc, t₀)
        have hlook : (Ξ.addCh (Ψ.take rc, t₀)).ch[K.leg.length]? = some (Ψ.take rc, t₀) := by
          rw [hC.len]; simp only [ChanTy.addCh]; rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]
          rfl
        have hcv : HasType Δ (Ξ.addCh (Ψ.take rc, t₀)) Ψ b b D [] Λ (.chanV K.leg.length)
            (.chan (Ψ.take rc).length t₀) :=
          .chanV hlook (by rw [hlen]) (by rw [hlen]; exact hf)
        rw [hlen] at hcv
        exact ⟨Ξ.addCh (Ψ.take rc, t₀), chanLEt_addCh Ξ _, .ret' hD (.chanV K.leg.length) hcv
          (hS.chan_mono hle) (heapOk_chan_mono hle hH),
          chanOk_new hC (by rw [hlen]; exact hl) hm⟩
    | send c e =>
      simp only [step] at hs; cases hs
      cases he with
      | send h1 h2 =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.sendL (h2.to_take_full hD) hS) hH, hC⟩
      | sendE h1 h2 hp =>
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.sendLE (h2.to_take_full hD) hp hS) hH, hC⟩
    | recv c =>
      simp only [step] at hs; cases hs
      cases he with
      | recv h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.recvK hS) hH, hC⟩
      | recvE h1 hm hc => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.recvKE hm hc hS) hH, hC⟩
    | close c =>
      simp only [step] at hs; cases hs
      cases he with
      | closeE h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.closeKE hS) hH, hC⟩
    -- 段 6 P1: 端点（task の外の生成は到達しない形 — panic・端点の値はそのまま値）
    | newch r cap t₀ =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | epV p k bx r =>
      simp only [step] at hs; cases hs
      cases he with
      | epTx h1 h2 h3 => exact ⟨Ξ, .refl Ξ, .ret' hD (.epV p k true r) (.epTx h1 h2 h3) hS hH, hC⟩
      | epRx h1 h2 h3 => exact ⟨Ξ, .refl Ξ, .ret' hD (.epV p k false r) (.epRx h1 h2 h3) hS hH, hC⟩
    -- 段 6 P1: scope / spawn / join / try の分解（葉の歩 — 子の表には触れない）
    | scope t₀ ε₀ e =>
      simp only [step] at hs; cases hs
      cases he with
      | scope h1 hr hb hem hec hbd =>
        rename_i tB
        have hbΨ : b ≤ Ψ.length := by rw [hD]; exact hS.le_depth
        have hHl : H.length = D := by rw [hH.len, hD]
        -- 札 scopeV D ε は開いた region D の世界（深さ D + 1）で型が付く（b ≤ D < D + 1）
        have hsv : HasType Δ Ξ (Ψ ++ [[]]) b b (D + 1) [] [] (.scopeV D ε₀) (.own .scope D ε₀) :=
          .scopeV (by omega) (by omega)
        have h1' := h1.store_mono (storeLE_append Ψ [[]]) (storePre_of_take_eq (take_append_left_of_le hbΨ [[]]))
        rw [hHl]
        refine ⟨Ξ, .refl Ξ, .eval' (Λ := []) (Ψ := Ψ ++ [[]]) (D := D + 1) (t := tB)
          (by simp [hD]) (HasType.subst0 h1' (.scopeV D ε₀) hsv) ?_ (heapOk_push hH), hC⟩
        exact .scopeK hr hb hem hec hbd (hS.mono (fun d' _ => (storeLE_append Ψ [[]]).take_take d')
          (take_append_left_of_le hbΨ [[]]))
    | spawn sc a e =>
      simp only [step] at hs; cases hs
      cases he with
      | spawn h1 ha hg h2 hrb hcf hε =>
        have hΨD : Ψ.take D = Ψ := by rw [← hD]; exact List.take_length
        exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.spawnK (ha.to_take_full hD) hg (by rw [hΨD]; exact h2) hrb hcf hε hS) hH, hC⟩
    | join h =>
      simp only [step] at hs; cases hs
      cases he with
      | join h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.joinK hS) hH, hC⟩
    | tryJ t₀ h =>
      simp only [step] at hs; cases hs
      cases he with
      | tryJ h1 => exact ⟨Ξ, .refl Ξ, .eval' hD h1 (.tryK hS) hH, hC⟩
    | scopeV rs ε₀ =>
      simp only [step] at hs; cases hs
      cases he with
      | scopeV h1 h2 => exact ⟨Ξ, .refl Ξ, .ret' hD (.scopeV rs ε₀) (.scopeV h1 h2) hS hH, hC⟩
    | taskV rs n =>
      simp only [step] at hs; cases hs
      cases he with
      | taskV h1 h2 h3 => exact ⟨Ξ, .refl Ξ, .ret' hD (.taskV rs n) (.taskV h1 h2 h3) hS hH, hC⟩
    | par e1 e2 =>
      simp only [step] at hs; cases hs
      cases he with
      | par h1 h2 hΓ =>
        have hbD : b ≤ D := hS.le_depth
        have hbΨ : b ≤ Ψ.length := by omega
        exact ⟨Ξ, .refl Ξ, .par' hD
          (.eval' hD (h1.f_mono hbD) .nil (hD ▸ heapOk_spawn hbΨ hH))
          (.eval' hD (h2.f_mono hbD) .nil (hD ▸ heapOk_spawn hbΨ hH)) rfl rfl hS hH, hC⟩
    | parch t₀ e1 e2 =>
      simp only [step] at hs; cases hs
      cases he with
      | parch h1 h2 hΓ hrb hmf =>
        have hbD : b ≤ D := hS.le_depth
        have hbΨ : b ≤ Ψ.length := by omega
        have hle : ChanLE Ξ (Ξ.addCh (Ψ, t₀)) := chanLE_addCh Ξ (Ψ, t₀)
        have hlook : (Ξ.addCh (Ψ, t₀)).ch[K.leg.length]? = some (Ψ, t₀) := by
          rw [hC.len]; simp only [ChanTy.addCh]; rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]
          rfl
        -- 新チャネルの chanV は spawn 深度 D（= Ψ.length）の世界（f = b = d = D）で型が付く
        have hcv : HasType Δ (Ξ.addCh (Ψ, t₀)) Ψ D D D [] [] (.chanV K.leg.length)
            (.chan Ψ.length t₀) :=
          .chanV hlook (by rw [List.take_length]) (Nat.le_of_eq hD)
        rw [hD] at hcv
        -- 本体を子の世界（f = b = D）へ持ち上げ、chanV を代入して spawn
        have hb1 := HasType.subst0 ((h1.chan_mono hle).f_mono hbD) (.chanV K.leg.length) hcv
        have hb2 := HasType.subst0 ((h2.chan_mono hle).f_mono hbD) (.chanV K.leg.length) hcv
        exact ⟨Ξ.addCh (Ψ, t₀), chanLEt_addCh Ξ _, .par' hD
          (.eval' hD hb1 .nil (hD ▸ heapOk_spawn hbΨ (heapOk_chan_mono hle hH)))
          (.eval' hD hb2 .nil (hD ▸ heapOk_spawn hbΨ (heapOk_chan_mono hle hH))) rfl rfl
          (hS.chan_mono hle) (heapOk_chan_mono hle hH),
          chanOk_new hC (by rw [hD]; exact hrb) hmf⟩

/-- preservation の ret 腕（eval 腕と同じ理由で分離） -/
theorem preservation_ret {Δ : Defs} {Ξ : ChanTy} {Λ : LCtx} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {S : Stack} {v : Expr} {t tf : Ty} (hΔ : DefsOk Δ) (hv : Value v)
    (he : HasType Δ Ξ Ψ b b Ψ.length [] Λ v t) (hS : StackTy Δ Ξ Ψ b S Λ Ψ.length t tf)
    (hH : HeapOk Δ Ξ b Ψ H) :
    ∀ {π : List Bool} {K : ChanSt} {s' : State} {K' : ChanSt},
      ChanOk Δ Ξ K → step Δ π (.ret H S v) K = some (s', K') →
      ∃ Ξ', ChanLEt Ξ Ξ' ∧ StateTy Δ Ξ' b s' tf ∧ ChanOk Δ Ξ' K' := by
    intro π K s' K' hC hs
    generalize hD : Ψ.length = D at he hS
    cases hS with
    | nil => simp [step] at hs
    | letK hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (HasType.subst0 (hb.of_take_full hD) hv he) hS' hH, hC⟩
    | addL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.addR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | addR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.lit _) .lit hS' hH, hC⟩
    | ltL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.ltR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | ltR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs
      split
      · exact ⟨Ξ, .refl Ξ, .ret' hD .tt .tt hS' hH, hC⟩
      · exact ⟨Ξ, .refl Ξ, .ret' hD .ff .ff hS' hH, hC⟩
    | arithL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.arithR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | arithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs <;> cases hs
      -- ゼロ除算: panic は任意の型で well-typed
      · exact ⟨Ξ, .refl Ξ, .ret' hD (.lit _) .lit hS' hH, hC⟩
      · exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | cmpL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.cmpR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | cmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs
      split
      · exact ⟨Ξ, .refl Ξ, .ret' hD .tt .tt hS' hH, hC⟩
      · exact ⟨Ξ, .refl Ξ, .ret' hD .ff .ff hS' hH, hC⟩
    | pairL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.pairR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | pairR hva hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.pair hva hv) (.pair (hb.of_take_full hD) he) hS' hH, hC⟩
    | fstK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD hva hta hS' hH, hC⟩
    | annK hsub hS' =>
      simp only [step] at hs; cases hs
      obtain ⟨hv', he'⟩ := HasType.value_coerce hv he hsub
      exact ⟨Ξ, .refl Ξ, .ret' hD hv' he' hS' hH, hC⟩
    | sndK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD hvc htc hS' hH, hC⟩
    | freezeKs hmf hS' =>
      rename_i S' r t
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, hbt⟩ := canonical_slice hv he
      subst hmt
      replace hk := cells_mut3 hk
      replace hbt := hbt rfl
      obtain ⟨hr1, hbr⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r]? = some σ := ⟨_, List.getElem?_eq_getElem hrΨ⟩
      simp only [step, hρ] at hs
      cases hs
      have hcells : ∀ j, j < len → ∃ mj, σ[base + j]? = some (mj, t) := by
        intro j hj
        obtain ⟨σ', mj, hσ', hcell, -⟩ := hk j hj
        have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
        exact ⟨mj, hss ▸ hcell⟩
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.set r (freezeRange base len σ)) (D := D)
        (t := .slice false r t) (by simp [hD]) (.slicev false r base len)
        (.slicev (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun h => nomatch h) (fun _ => hmf) (fun h => nomatch h)) ?_
        (heapOk_freezeRange hbr hmf len hH hρ hσ hcells), hC⟩
      · intro j hj
        obtain ⟨mj, hcell⟩ := hcells j hj
        exact ⟨freezeRange base len σ, false, List.getElem?_set_self hrΨ,
          freezeRange_getElem?_in len j hj hcell, fun _ => rfl⟩
      · exact hS'.mono (fun d' _ => (storeLE_freezeRange base len hσ).take_take d')
          (take_set_of_le hbr _)
    | idxL h1 hrd hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.idxR hv (he.to_take_full hD) hrd hS') hH, hC⟩
    | idxR hvs hsv hrd hS' =>
      rename_i S' ot sv m r t' t
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd0, -, hmb, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt
      obtain ⟨n, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs
      case isTrue hin =>
        obtain ⟨σ, mk, tc, hσ, hcell, hkimm, hsc, hex⟩ := hk n.toNat hin.2
        have hrH : r0 < H.length := by rw [hH.len]; omega
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
        have hlen : ρ.length = σ.length := hH.storeLen r0 ρ σ hρ hσ
        have haρ : base + n.toNat < ρ.length := by
          rw [hlen]; exact (List.getElem?_eq_some_iff.mp hcell).1
        obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[base + n.toNat]? = some c :=
          ⟨_, List.getElem?_eq_getElem haρ⟩
        simp only [hρ, hw] at hs
        cases hs
        have hcond : mk = false ∨ b ≤ r0 := by
          cases mt with
          | false => exact .inl (hkimm rfl)
          | true => exact .inr (hmb rfl).2
        obtain ⟨hwv, hwt⟩ := hH.typed r0 ρ σ (base + n.toNat) mw w mk tc hρ hσ hw hcell hcond
        have hwt' : HasType Δ Ξ Ψ b b D [] Λ w tc :=
          HasType.value_ctx hwv (HasType.value_depth_weaken hwv
            (hwt.store_mono (storeLE_take_self Ψ (r0 + 1)) (storePre_take_self Ψ (r0 + 1) b))
            (by omega))
        obtain ⟨hwv2, hwt2⟩ := read_ok hwv hwt' hsc hex hrd
        exact ⟨Ξ, .refl Ξ, .ret' hD hwv2 hwt2 hS' hH, hC⟩
      case isFalse _ =>
        cases hs
        exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | lenK hS' =>
      obtain ⟨mt, r0, base, len, rfl, -, -, -, -, -, -, -⟩ := canonical_slice hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.lit len) .lit hS' hH, hC⟩
    | tobyteK hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hv he
      by_cases hr : 0 ≤ n ∧ n < 256
      · simp only [step, if_pos hr] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.blit hr.1 hr.2) (.blit hr.1 hr.2) hS' hH, hC⟩
      · simp only [step, if_neg hr] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | tointK hS' =>
      obtain ⟨n, rfl, -, -⟩ := canonical_byte hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.lit n) .lit hS' hH, hC⟩
    | farithL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.farithR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | farithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.flit _) .flit hS' hH, hC⟩
    | fcmpL hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.fcmpR hv (he.to_take_full hD) hS') hH,
        hC⟩
    | fcmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      simp only [step] at hs; cases hs
      split
      · exact ⟨Ξ, .refl Ξ, .ret' hD .tt .tt hS' hH, hC⟩
      · exact ⟨Ξ, .refl Ξ, .ret' hD .ff .ff hS' hH, hC⟩
    | @fconvK _ S' _ op _ hS' =>
      cases op
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.flit _) .flit hS' hH, hC⟩
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.flit _) .flit hS' hH, hC⟩
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.flit _) .flit hS' hH, hC⟩
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs
        split at hs <;> cases hs
        · exact ⟨Ξ, .refl Ξ, .ret' hD (.lit _) .lit hS' hH, hC⟩
        · exact ⟨Ξ, .refl Ξ, .panic, hC⟩
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.lit _) .lit hS' hH, hC⟩
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.flit _) .flit hS' hH, hC⟩
    | appL h1 hbm hbi hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.appR hv (he.to_take_full hD) hbm hbi hS') hH, hC⟩
    | @appR _ S' _ sv m r rr t _ hvs hsv hbm hbi hS' =>
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, hrle, hmb, hmf, hbt⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt
      have hrΨ : r0 < Ψ.length := by omega
      have hrH : r0 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r0]? = some σ := ⟨_, List.getElem?_eq_getElem hrΨ⟩
      have hlen : ρ.length = σ.length := hH.storeLen r0 ρ σ hρ hσ
      have hcellsG : ∀ j, j < len → ∃ mj tj, σ[base + j]? = some (mj, tj) ∧ (mt = false → mj = false) ∧
          Ty.sub tj t = true ∧ (mt = true → tj = t) := by
        intro j hj
        obtain ⟨σ', mj, tj, hσ', hcell, hmm, hsj, hej⟩ := hk j hj
        have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
        exact ⟨mj, tj, hss ▸ hcell, hmm, hsj, hej⟩
      cases mt with
      | true =>
        -- mut: 型 region は正確、書き込み先も実 region r0（旧来の tip / copy 分岐）
        have hbt : t.regionsBelow (r0 + 1) = true := hbt rfl
        have hcells : ∀ j, j < len → ∃ mj, σ[base + j]? = some (mj, t) ∧ (true = false → mj = false) := by
          intro j hj
          obtain ⟨mj, tj, hcell, hmm, -, hej⟩ := hcellsG j hj
          obtain rfl := hej rfl
          exact ⟨mj, hcell, hmm⟩
        obtain ⟨hr1, hbr⟩ := hmb rfl
        subst hr1
        obtain ⟨hrr1, -⟩ := hbm rfl
        subst hrr1
        have hvt : HasType Δ Ξ (Ψ.take (rr + 1)) b b (rr + 1) [] Λ v t :=
          HasType.value_strengthen hv he hbt
        simp only [step, hρ] at hs
        by_cases htip : base + len = ρ.length
        · simp only [if_pos htip] at hs
          cases hs
          have hH' := heapOk_append1 (m := true) hH hρ hσ hbr hv hvt hbt (fun h => nomatch h)
          refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.set rr (σ ++ [(true, t)])) (D := D)
            (t := .slice true rr t) (by simp [hD]) (.slicev true rr base (len + 1))
            (.slicev (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩)
              (fun h => nomatch h) (fun _ => hbt)) ?_ hH', hC⟩
          · intro j hj
            by_cases hjl : j < len
            · obtain ⟨mj, hcell, hmm⟩ := hcells j hjl
              exact ⟨σ ++ [(true, t)], mj, List.getElem?_set_self hrΨ,
                by rw [List.getElem?_append_left ((List.getElem?_eq_some_iff.mp hcell).1)]
                   exact hcell,
                hmm⟩
            · have hje : j = len := by omega
              subst hje
              have hbase : base + j = σ.length := by omega
              refine ⟨σ ++ [(true, t)], true, List.getElem?_set_self hrΨ, ?_,
                fun h => nomatch h⟩
              rw [hbase, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]
              rfl
          · exact hS'.mono (fun d' _ => (storeLE_set_concat hσ (true, t)).take_take d')
              (take_set_of_le hbr _)
        · simp only [if_neg htip] at hs
          cases hs
          have hcells' : ∀ j, j < len → ∃ mj tj, σ[base + j]? = some (mj, tj) := by
            intro j hj
            obtain ⟨mj, hcell, -⟩ := hcells j hj
            exact ⟨mj, t, hcell⟩
          have hcopy := heapOk_append_copy hbr len hH hρ hσ hcells'
          have hσ1 : (Ψ.set rr (σ ++ (σ.drop base).take len))[rr]? =
              some (σ ++ (σ.drop base).take len) := List.getElem?_set_self hrΨ
          have hρ1 : (H.set rr (ρ ++ (ρ.drop base).take len))[rr]? =
              some (ρ ++ (ρ.drop base).take len) := List.getElem?_set_self hrH
          have hle1 : StoreLE Ψ (Ψ.set rr (σ ++ (σ.drop base).take len)) :=
            storeLE_set_concat_many hσ _
          have hH2 := heapOk_append1 (m := true) hcopy hρ1 hσ1 hbr hv
            (hvt.store_mono (hle1.take_take (rr + 1))
              (storePre_of_take_eq (take_pre_set (rr + 1) _ hbr)))
            hbt (fun h => nomatch h)
          rw [List.set_set, List.set_set] at hH2
          -- コピーされた区間の長さ = len（len > 0 なら末尾セルの存在から、len = 0 なら自明）
          have hblen : len = 0 ∨ base + len ≤ σ.length := by
            rcases Nat.eq_zero_or_pos len with h0 | hpos
            · exact .inl h0
            · obtain ⟨mj, _, hcell⟩ := hcells' (len - 1) (by omega)
              have := (List.getElem?_eq_some_iff.mp hcell).1
              exact .inr (by omega)
          have hxlen : ((σ.drop base).take len).length = len := by
            rcases hblen with h0 | hle0
            · subst h0; simp
            · rw [List.length_take, List.length_drop]; omega
          refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ)
            (Ψ := Ψ.set rr (σ ++ (σ.drop base).take len ++ [(true, t)])) (D := D)
            (t := .slice true rr t) (by simp [hD]) (.slicev true rr ρ.length (len + 1))
            (.slicev (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩)
              (fun h => nomatch h) (fun _ => hbt)) ?_ hH2, hC⟩
          · intro j hj
            refine ⟨σ ++ (σ.drop base).take len ++ [(true, t)], ?_⟩
            by_cases hjl : j < len
            · obtain ⟨mj, hcell, hmm⟩ := hcells j hjl
              have hjx : base + j < σ.length := (List.getElem?_eq_some_iff.mp hcell).1
              refine ⟨mj, List.getElem?_set_self hrΨ, ?_, hmm⟩
              rw [hlen]
              rw [List.getElem?_append_left (by
                rw [List.length_append, hxlen]; omega)]
              rw [List.getElem?_append_right (Nat.le_add_right _ _)]
              have hj0 : σ.length + j - σ.length = j := by omega
              rw [hj0, List.getElem?_take_of_lt hjl, List.getElem?_drop]
              exact hcell
            · have hje : j = len := by omega
              subst hje
              refine ⟨true, List.getElem?_set_self hrΨ, ?_, fun h => nomatch h⟩
              rw [hlen]
              rw [List.getElem?_append_right (by rw [List.length_append, hxlen]; omega)]
              rw [List.length_append, hxlen]
              have hj0 : σ.length + j - (σ.length + j) = 0 := by omega
              rw [hj0]
              rfl
          · have hle2 : StoreLE Ψ (Ψ.set rr (σ ++ (σ.drop base).take len ++ [(true, t)])) := by
              rw [List.append_assoc]
              exact storeLE_set_concat_many hσ _
            exact hS'.mono (fun d' _ => hle2.take_take d') (take_set_of_le hbr _)
      | false =>
        -- imm（round4）: 現在の最内 region rr（= D - 1）へ常に全コピー + 1 セル
        obtain ⟨hDrr, hbrr, hbtD⟩ := hbi rfl
        have hmf' : t.mutFree := hmf rfl
        have hHlen : H.length = D := by rw [hH.len, hD]
        have hin : H.length - 1 = rr := by omega
        have hrrΨ : rr < Ψ.length := by omega
        have hrrH : rr < H.length := by omega
        obtain ⟨ρi, hρi⟩ : ∃ ρi, H[rr]? = some ρi := ⟨_, List.getElem?_eq_getElem hrrH⟩
        obtain ⟨σi, hσi⟩ : ∃ σi, Ψ[rr]? = some σi := ⟨_, List.getElem?_eq_getElem hrrΨ⟩
        have hleni : ρi.length = σi.length := hH.storeLen rr ρi σi hρi hσi
        simp only [step, hρ] at hs
        rw [if_neg (show ¬(false = true) by simp)] at hs
        rw [hin] at hs
        simp only [hρi] at hs
        cases hs
        have hbt' : t.regionsBelow (rr + 1) := hDrr ▸ hbtD
        have hvt : HasType Δ Ξ (Ψ.take (rr + 1)) b b (rr + 1) [] Λ v t :=
          HasType.value_strengthen hv he hbt'
        have hcellsF : ∀ j, j < len → ∃ mj tj, σ[base + j]? = some (mj, tj) ∧ mj = false ∧
            Ty.sub tj t = true := by
          intro j hj
          obtain ⟨mj, tj, hcell, hmm, hsj, -⟩ := hcellsG j hj
          exact ⟨mj, tj, hcell, hmm rfl, hsj⟩
        have hcellsF' : ∀ j, j < len → ∃ mj tj, σ[base + j]? = some (mj, tj) := by
          intro j hj
          obtain ⟨mj, tj, hcell, -⟩ := hcellsF j hj
          exact ⟨mj, tj, hcell⟩
        -- コピー区間の長さ = len
        have hblen : len = 0 ∨ base + len ≤ σ.length := by
          rcases Nat.eq_zero_or_pos len with h0 | hpos
          · exact .inl h0
          · obtain ⟨mj, _, hcell⟩ := hcellsF' (len - 1) (by omega)
            have := (List.getElem?_eq_some_iff.mp hcell).1
            exact .inr (by omega)
        have hxlen : ((σ.drop base).take len).length = len := by
          rcases hblen with h0 | hle0
          · subst h0; simp
          · rw [List.length_take, List.length_drop]; omega
        -- コピー + 1 セルの HeapOk（同一 region か跨 region かで補題を使い分け）
        have hσ1 : (Ψ.set rr (σi ++ (σ.drop base).take len))[rr]? =
            some (σi ++ (σ.drop base).take len) := List.getElem?_set_self hrrΨ
        have hρ1 : (H.set rr (ρi ++ (ρ.drop base).take len))[rr]? =
            some (ρi ++ (ρ.drop base).take len) := List.getElem?_set_self hrrH
        have hle1 : StoreLE Ψ (Ψ.set rr (σi ++ (σ.drop base).take len)) :=
          storeLE_set_concat_many hσi _
        have hcopy : HeapOk Δ Ξ b (Ψ.set rr (σi ++ (σ.drop base).take len))
            (H.set rr (ρi ++ (ρ.drop base).take len)) := by
          by_cases hrk : r0 = rr
          · subst hrk
            have hσe : σi = σ := Option.some.inj (hσi.symm.trans hσ)
            have hρe : ρi = ρ := Option.some.inj (hρi.symm.trans hρ)
            subst hσe hρe
            exact heapOk_append_copy hbrr len hH hρi hσi hcellsF'
          · exact heapOk_append_copy_cross hbrr (by omega) len hH hρ hσ hρi hσi
              (fun j hj => let ⟨mj, tj, h1, h2, _⟩ := hcellsF j hj; ⟨mj, tj, h1, h2⟩)
        have hH2 := heapOk_append1 (m := false) hcopy hρ1 hσ1 hbrr hv
          (hvt.store_mono (hle1.take_take (rr + 1))
            (storePre_of_take_eq (take_pre_set (rr + 1) _ hbrr)))
          hbt' (fun _ => hmf')
        rw [List.set_set, List.set_set] at hH2
        refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ)
          (Ψ := Ψ.set rr (σi ++ (σ.drop base).take len ++ [(false, t)])) (D := D)
          (t := .slice false rr t) (by simp [hD]) (.slicev false rr ρi.length (len + 1))
          (.slicev ?_ (by omega) (Nat.le_refl _) rfl (fun h => nomatch h)
            (fun _ => hmf') (fun h => nomatch h)) ?_ hH2, hC⟩
        · intro j hj
          refine ⟨σi ++ (σ.drop base).take len ++ [(false, t)], ?_⟩
          by_cases hjl : j < len
          · obtain ⟨mj, tj, hcell, hmm, hsj⟩ := hcellsF j hjl
            have hjx : base + j < σ.length := (List.getElem?_eq_some_iff.mp hcell).1
            refine ⟨mj, tj, List.getElem?_set_self hrrΨ, ?_, fun _ => hmm, hsj, fun h => nomatch h⟩
            rw [hleni]
            rw [List.getElem?_append_left (by
              rw [List.length_append, hxlen]; omega)]
            rw [List.getElem?_append_right (Nat.le_add_right _ _)]
            have hj0 : σi.length + j - σi.length = j := by omega
            rw [hj0, List.getElem?_take_of_lt hjl, List.getElem?_drop]
            exact hcell
          · have hje : j = len := by omega
            subst hje
            refine ⟨false, t, List.getElem?_set_self hrrΨ, ?_, fun _ => rfl, Ty.sub_refl t, fun h => nomatch h⟩
            rw [hleni]
            rw [List.getElem?_append_right (by rw [List.length_append, hxlen]; omega)]
            rw [List.length_append, hxlen]
            have hj0 : σi.length + j - (σi.length + j) = 0 := by omega
            rw [hj0]
            rfl
        · have hle2 : StoreLE Ψ (Ψ.set rr (σi ++ (σ.drop base).take len ++ [(false, t)])) := by
            rw [List.append_assoc]
            exact storeLE_set_concat_many hσi _
          exact hS'.mono (fun d' _ => hle2.take_take d') (take_set_of_le hbrr _)
    | sixL h1 h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD)
        (.sixM hv (he.to_take_full hD) h2 hS') hH, hC⟩
    | sixM hvs hsv h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h2.of_take_full hD)
        (.sixR hvs hsv hv (he.to_take_full hD) hS') hH, hC⟩
    | subL h1 h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD)
        (.subM hv (he.to_take_full hD) h2 hS') hH, hC⟩
    | subM hvs hsv h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h2.of_take_full hD)
        (.subR hvs hsv hv (he.to_take_full hD) hS') hH, hC⟩
    | eqsL h1 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD)
        (.eqsR hv (he.to_take_full hD) hS') hH, hC⟩
    | catL h1 hd hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD)
        (.catR hv (he.to_take_full hD) hd hb hS') hH, hC⟩
    | sixR hvs hsv hvi hi hS' =>
      rename_i S' sv iv r
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, hbt⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt
      replace hk := cells_mut3 hk
      replace hbt := hbt rfl
      obtain ⟨hr1, -⟩ := hmb rfl
      subst hr1
      obtain ⟨n, rfl⟩ := canonical_int hvi (hi.of_take_full hD)
      simp only [step] at hs
      split at hs
      case isTrue hin =>
        obtain ⟨σ, mk, hσ, hcell, -⟩ := hk n.toNat hin.2
        have hrH : r < H.length := by rw [hH.len]; omega
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
        have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hρ hσ
        have haρ : base + n.toNat < ρ.length := by
          rw [hlen]; exact (List.getElem?_eq_some_iff.mp hcell).1
        obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[base + n.toNat]? = some c :=
          ⟨_, List.getElem?_eq_getElem haρ⟩
        have htag : mw = mk := hH.tags r ρ σ (base + n.toNat) mw w mk t hρ hσ hw hcell
        cases mw with
        | true =>
          simp only [hρ, hw] at hs
          cases hs
          have hσa' : σ[base + n.toNat]? = some (true, t) := by rwa [← htag] at hcell
          have hbtc : t.regionsBelow (r + 1) :=
            hH.tyBelow r σ (base + n.toNat) true t hσ hσa'
          refine ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS' ?_, hC⟩
          exact heapOk_write hH hρ hσ hσa' hv (HasType.value_strengthen hv he hbtc)
        | false =>
          simp only [hρ, hw] at hs
          cases hs
          exact ⟨Ξ, .refl Ξ, .panic, hC⟩
      case isFalse _ =>
        cases hs
        exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | @subR _ S' _ sv av r _ _ hvs hsv hav hat hS' =>
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, hrle, -, hmf, hbt⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt
      obtain ⟨na, rfl⟩ := canonical_int hav (hat.of_take_full hD)
      obtain ⟨nb, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs
      case isTrue hin =>
        cases hs
        refine ⟨Ξ, .refl Ξ, .ret' hD (.slicev false r0 (base + na.toNat) (nb.toNat - na.toNat))
          (.slicev ?_ hrd hrle rfl (fun h => nomatch h) hmf (fun h => nomatch h)) hS' hH, hC⟩
        intro j hj
        have hjl : na.toNat + j < len := by omega
        obtain ⟨σ, mk, tc, hσ, hcell, hmm, hsc, hex⟩ := hk (na.toNat + j) hjl
        refine ⟨σ, mk, tc, hσ, ?_, hmm, hsc, hex⟩
        rw [show base + na.toNat + j = base + (na.toNat + j) by omega]
        exact hcell
      case isFalse _ =>
        cases hs
        exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | eqsR hvs hsv hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, -, -, hrd1, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨mt2, r2, b2, l2, rfl, -, -, hrd2, -, -, -, -⟩ := canonical_slice hv he
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      simp only [step, hρ1, hρ2] at hs
      split at hs <;> cases hs
      · exact ⟨Ξ, .refl Ξ, .ret' hD .tt .tt hS' hH, hC⟩
      · exact ⟨Ξ, .refl Ξ, .ret' hD .ff .ff hS' hH, hC⟩
    | @catR _ S' _ sv r1t r2t rr t _ hvs hsv hd hb hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, hmt1, hk1, hrd1, -, -, hmf1, hbt1⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt1
      obtain ⟨mt2, r2, b2, l2, rfl, hmt2, hk2, hrd2, -, -, -, hbt2⟩ :=
        canonical_slice hv he
      subst hmt2
      -- 世界の形: 最内 rr = D - 1
      have hin : H.length - 1 = rr := by rw [hH.len, hD]; omega
      have hrrΨ : rr < Ψ.length := by omega
      have hrrH : rr < H.length := by rw [hH.len]; omega
      have hr1Ψ : r1 < Ψ.length := by omega
      have hr2Ψ : r2 < Ψ.length := by omega
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[rr]? = some ρ := ⟨_, List.getElem?_eq_getElem hrrH⟩
      obtain ⟨σ1, hσ1⟩ : ∃ σ, Ψ[r1]? = some σ := ⟨_, List.getElem?_eq_getElem hr1Ψ⟩
      obtain ⟨σ2, hσ2⟩ : ∃ σ, Ψ[r2]? = some σ := ⟨_, List.getElem?_eq_getElem hr2Ψ⟩
      obtain ⟨σi, hσi⟩ : ∃ σ, Ψ[rr]? = some σ := ⟨_, List.getElem?_eq_getElem hrrΨ⟩
      have hlen1 : ρ1.length = σ1.length := hH.storeLen r1 ρ1 σ1 hρ1 hσ1
      have hlen2 : ρ2.length = σ2.length := hH.storeLen r2 ρ2 σ2 hρ2 hσ2
      have hleni : ρi.length = σi.length := hH.storeLen rr ρi σi hρi hσi
      have hcells1x : ∀ j, j < l1 → ∃ mj tj, σ1[b1 + j]? = some (mj, tj) ∧ mj = false ∧ Ty.sub tj t = true := by
        intro j hj
        obtain ⟨σ', mj, tj, hσ', hcell, hmm, hsj, -⟩ := hk1 j hj
        have hss : σ' = σ1 := Option.some.inj (hσ'.symm.trans hσ1)
        exact ⟨mj, tj, hss ▸ hcell, hmm rfl, hsj⟩
      have hcells1 : ∀ j, j < l1 → ∃ mj tj, σ1[b1 + j]? = some (mj, tj) ∧ mj = false := by
        intro j hj
        obtain ⟨mj, tj, hcell, hmm, -⟩ := hcells1x j hj
        exact ⟨mj, tj, hcell, hmm⟩
      have hcells2x : ∀ j, j < l2 → ∃ mj tj, σ2[b2 + j]? = some (mj, tj) ∧ mj = false ∧ Ty.sub tj t = true := by
        intro j hj
        obtain ⟨σ', mj, tj, hσ', hcell, hmm, hsj, -⟩ := hk2 j hj
        have hss : σ' = σ2 := Option.some.inj (hσ'.symm.trans hσ2)
        exact ⟨mj, tj, hss ▸ hcell, hmm rfl, hsj⟩
      have hcells2 : ∀ j, j < l2 → ∃ mj tj, σ2[b2 + j]? = some (mj, tj) ∧ mj = false := by
        intro j hj
        obtain ⟨mj, tj, hcell, hmm, -⟩ := hcells2x j hj
        exact ⟨mj, tj, hcell, hmm⟩
      have hcells1' : ∀ j, j < l1 → ∃ mj tj, σ1[b1 + j]? = some (mj, tj) := by
        intro j hj
        obtain ⟨mj, tj, hcell, -⟩ := hcells1 j hj
        exact ⟨mj, tj, hcell⟩
      have hblen1 : l1 = 0 ∨ b1 + l1 ≤ σ1.length := by
        rcases Nat.eq_zero_or_pos l1 with h0 | hpos
        · exact .inl h0
        · obtain ⟨mj, _, hcell⟩ := hcells1' (l1 - 1) (by omega)
          have := (List.getElem?_eq_some_iff.mp hcell).1
          exact .inr (by omega)
      have hblen2 : l2 = 0 ∨ b2 + l2 ≤ σ2.length := by
        rcases Nat.eq_zero_or_pos l2 with h0 | hpos
        · exact .inl h0
        · obtain ⟨mj, _, hcell, -⟩ := hcells2 (l2 - 1) (by omega)
          have := (List.getElem?_eq_some_iff.mp hcell).1
          exact .inr (by omega)
      have hx1σ : ((σ1.drop b1).take l1).length = l1 := by
        rcases hblen1 with h0 | hle0
        · subst h0; simp
        · rw [List.length_take, List.length_drop]; omega
      have hx1ρ : ((ρ1.drop b1).take l1).length = l1 := by
        rcases hblen1 with h0 | hle0
        · subst h0; simp
        · rw [List.length_take, List.length_drop]; omega
      have hx2σ : ((σ2.drop b2).take l2).length = l2 := by
        rcases hblen2 with h0 | hle0
        · subst h0; simp
        · rw [List.length_take, List.length_drop]; omega
      -- step の具体化
      simp only [step, hρ1, hρ2, hin, hρi] at hs
      cases hs
      -- コピー 1: ソース r1 → 最内 rr
      have hcopy1 : HeapOk Δ Ξ b (Ψ.set rr (σi ++ (σ1.drop b1).take l1))
          (H.set rr (ρi ++ (ρ1.drop b1).take l1)) := by
        by_cases hrk : r1 = rr
        · subst hrk
          have hσe : σi = σ1 := Option.some.inj (hσi.symm.trans hσ1)
          have hρe : ρi = ρ1 := Option.some.inj (hρi.symm.trans hρ1)
          subst hσe hρe
          exact heapOk_append_copy hb l1 hH hρi hσi hcells1'
        · exact heapOk_append_copy_cross hb (by omega) l1 hH hρ1 hσ1 hρi hσi hcells1
      -- コピー 2: ソース r2 → 最内 rr（伸びた世界で言い直す）
      have hσ1' : (Ψ.set rr (σi ++ (σ1.drop b1).take l1))[rr]? =
          some (σi ++ (σ1.drop b1).take l1) := List.getElem?_set_self hrrΨ
      have hρ1' : (H.set rr (ρi ++ (ρ1.drop b1).take l1))[rr]? =
          some (ρi ++ (ρ1.drop b1).take l1) := List.getElem?_set_self hrrH
      have hcopy2 : HeapOk Δ Ξ b
          (Ψ.set rr (σi ++ (σ1.drop b1).take l1 ++ (σ2.drop b2).take l2))
          (H.set rr (ρi ++ (ρ1.drop b1).take l1 ++ (ρ2.drop b2).take l2)) := by
        by_cases hrk : r2 = rr
        · -- 同一 region ソース: 伸びた列の prefix からの drop-take は元と同じ
          subst hrk
          have hσe : σi = σ2 := Option.some.inj (hσi.symm.trans hσ2)
          have hρe : ρi = ρ2 := Option.some.inj (hρi.symm.trans hρ2)
          subst hσe hρe
          rcases hblen2 with h0 | hble
          · subst h0
            simpa using hcopy1
          · have hσeq : ((σi ++ (σ1.drop b1).take l1).drop b2).take l2 =
                (σi.drop b2).take l2 := drop_take_append_left _ _ hble
            have hρeq : ((ρi ++ (ρ1.drop b1).take l1).drop b2).take l2 =
                (ρi.drop b2).take l2 := drop_take_append_left _ _ (by omega)
            have hcells2' : ∀ j, j < l2 →
                ∃ mj tj, (σi ++ (σ1.drop b1).take l1)[b2 + j]? = some (mj, tj) := by
              intro j hj
              obtain ⟨mj, tj, hcell, -⟩ := hcells2 j hj
              refine ⟨mj, tj, ?_⟩
              rw [List.getElem?_append_left (by
                have := (List.getElem?_eq_some_iff.mp hcell).1
                omega)]
              exact hcell
            have := heapOk_append_copy hb l2 hcopy1 hρ1' hσ1' hcells2'
            rw [List.set_set, List.set_set, hσeq, hρeq] at this
            exact this
        · -- 跨 region ソース: set は r2 を触らない
          have hσ2' : (Ψ.set rr (σi ++ (σ1.drop b1).take l1))[r2]? = some σ2 := by
            rw [List.getElem?_set_ne (by omega)]
            exact hσ2
          have hρ2' : (H.set rr (ρi ++ (ρ1.drop b1).take l1))[r2]? = some ρ2 := by
            rw [List.getElem?_set_ne (by omega)]
            exact hρ2
          have := heapOk_append_copy_cross hb (by omega) l2 hcopy1 hρ2' hσ2' hρ1' hσ1'
            hcells2
          rw [List.set_set, List.set_set] at this
          exact this
      -- 結果ヘッダの型付け
      have hmf' : t.mutFree := hmf1 rfl
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ)
        (Ψ := Ψ.set rr (σi ++ (σ1.drop b1).take l1 ++ (σ2.drop b2).take l2)) (D := D)
        (t := .slice false rr t) (by simp [hD]) (.slicev false rr ρi.length (l1 + l2))
        (.slicev ?_ (by omega) (Nat.le_refl _) rfl (fun h => nomatch h)
          (fun _ => hmf') (fun h => nomatch h)) ?_ hcopy2, hC⟩
      · intro j hj
        refine ⟨σi ++ (σ1.drop b1).take l1 ++ (σ2.drop b2).take l2, ?_⟩
        by_cases hjl : j < l1
        · obtain ⟨mj, tj, hcell, hmm, hsj⟩ := hcells1x j hjl
          have hjx : b1 + j < σ1.length := (List.getElem?_eq_some_iff.mp hcell).1
          refine ⟨mj, tj, List.getElem?_set_self hrrΨ, ?_, fun _ => hmm, hsj, fun h => nomatch h⟩
          rw [hleni]
          rw [List.getElem?_append_left (by rw [List.length_append, hx1σ]; omega)]
          rw [List.getElem?_append_right (Nat.le_add_right _ _)]
          have hj0 : σi.length + j - σi.length = j := by omega
          rw [hj0, List.getElem?_take_of_lt hjl, List.getElem?_drop]
          exact hcell
        · have hj2 : j - l1 < l2 := by omega
          obtain ⟨mj, tj, hcell, hmm, hsj⟩ := hcells2x (j - l1) hj2
          refine ⟨mj, tj, List.getElem?_set_self hrrΨ, ?_, fun _ => hmm, hsj, fun h => nomatch h⟩
          rw [hleni]
          rw [List.getElem?_append_right (by rw [List.length_append, hx1σ]; omega)]
          rw [List.length_append, hx1σ]
          have hj0 : σi.length + j - (σi.length + l1) = j - l1 := by omega
          rw [hj0, List.getElem?_take_of_lt hj2, List.getElem?_drop]
          exact hcell
      · have hle2 : StoreLE Ψ
            (Ψ.set rr (σi ++ (σ1.drop b1).take l1 ++ (σ2.drop b2).take l2)) := by
          rw [List.append_assoc]
          exact storeLE_set_concat_many hσi _
        exact hS'.mono (fun d' _ => hle2.take_take d') (take_set_of_le hb _)
    | freezeKm hmf hS' =>
      -- freezeKs の鏡（セル型 prod int (opt t)。その mutFree / regionsBelow は t のと同値）
      rename_i S' r t
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, hbt⟩ := canonical_map hv he
      subst hmt
      replace hk := cells_mut3 hk
      replace hbt := hbt rfl
      obtain ⟨hr1, hbr⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r]? = some σ := ⟨_, List.getElem?_eq_getElem hrΨ⟩
      simp only [step, hρ] at hs
      cases hs
      have hcells : ∀ j, j < len → ∃ mj, σ[base + j]? = some (mj, t) := by
        intro j hj
        obtain ⟨σ', mj, hσ', hcell, -⟩ := hk j hj
        have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
        exact ⟨mj, hss ▸ hcell⟩
      have hmfc : t.mutFree := hmf
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.set r (freezeRange base len σ)) (D := D)
        (t := .map false r t) (by simp [hD]) (.mapv false r base len)
        (.mapv (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun h => nomatch h) (fun _ => hmf) (fun h => nomatch h)) ?_
        (heapOk_freezeRange hbr hmfc len hH hρ hσ hcells), hC⟩
      · intro j hj
        obtain ⟨mj, hcell⟩ := hcells j hj
        exact ⟨freezeRange base len σ, false, List.getElem?_set_self hrΨ,
          freezeRange_getElem?_in len j hj hcell, fun _ => rfl⟩
      · exact hS'.mono (fun d' _ => (storeLE_freezeRange base len hσ).take_take d')
          (take_set_of_le hbr _)
    | gtmL h1 hsub hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.gtmR hv (he.to_take_full hD) hsub hS') hH, hC⟩
    | gtmR hvs hsv hsub hS' =>
      rename_i S' sv m r kt t' t
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      subst hmt
      have hrH : r0 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base v len with
      | none =>
        rw [hfk] at hs
        cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD (.nil t) .nil hS' hH, hC⟩
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        simp only [hfk, hcellρ] at hs
        cases hs
        obtain ⟨σ, mk, tc, hσ, hcellσ, hkimm, hsc, -⟩ := hk j hjlen
        have hcond : mk = false ∨ b ≤ r0 := by
          cases mt with
          | false => exact .inl (hkimm rfl)
          | true => exact .inr (hmb rfl).2
        obtain ⟨kc, oc, rfl, -, hso⟩ := Ty.sub_prod_invR hsc
        obtain ⟨hwv, hwt⟩ :=
          hH.typed r0 ρ σ (base + j) mj _ mk _ hρ hσ hcellρ hcellσ hcond
        cases hwv with
        | pair hke hw =>
          cases hwt with
          | pair hket hwt' =>
            have hw2 : HasType Δ Ξ Ψ b b D [] Λ w oc :=
              HasType.value_ctx hw (HasType.value_depth_weaken hw
                (hwt'.store_mono (storeLE_take_self Ψ (r0 + 1)) (storePre_take_self Ψ (r0 + 1) b))
                (by omega))
            obtain ⟨hwv3, hwt3⟩ := HasType.value_coerce hw hw2
              (Ty.sub_trans hso (show Ty.sub (Ty.opt t') (Ty.opt t) = true by simpa [Ty.sub] using hsub))
            exact ⟨Ξ, .refl Ξ, .ret' hD hwv3 hwt3 hS' hH, hC⟩
    | stmL h1 h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD)
        (.stmM hv (he.to_take_full hD) h2 hS') hH, hC⟩
    | stmM hvs hsv h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h2.of_take_full hD)
        (.stmR hvs hsv hv (he.to_take_full hD) hS') hH, hC⟩
    | stmR hvs hsv hkv hkt hS' =>
      rename_i S' sv kv r kt
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, hbt⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      subst hmt
      replace hk := cells_mut3 hk
      replace hbt := hbt rfl
      obtain ⟨hr1, hbr⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r]? = some σ := ⟨_, List.getElem?_eq_getElem hrΨ⟩
      have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hρ hσ
      have hbtc : (Ty.prod kt (.opt t)).regionsBelow (r + 1) := hbt
      have hmfc : (true : Bool) = false → (Ty.prod kt (.opt t)).mutFree :=
        fun h => nomatch h
      have hbkv : kt.regionsBelow (r + 1) = true ∧ t.regionsBelow (r + 1) = true := by
        simpa [Ty.regionsBelow] using hbt
      have hvt : HasType Δ Ξ (Ψ.take (r + 1)) b b (r + 1) [] Λ v t :=
        HasType.value_strengthen hv he hbkv.2
      have hkvt : HasType Δ Ξ (Ψ.take (r + 1)) b b (r + 1) [] Λ kv kt :=
        HasType.value_strengthen hkv (hkt.of_take_full hD) hbkv.1
      have hcells : ∀ j, j < len → ∃ mj, σ[base + j]? = some (mj, .prod kt (.opt t)) := by
        intro j hj
        obtain ⟨σ', mj, hσ', hcell, -⟩ := hk j hj
        have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
        exact ⟨mj, hss ▸ hcell⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base kv len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        obtain ⟨mk, hcellσ⟩ := hcells j hjlen
        have htag : mj = mk := hH.tags r ρ σ (base + j) mj _ mk _ hρ hσ hcellρ hcellσ
        cases mj with
        | true =>
          simp only [hfk, hcellρ] at hs
          cases hs
          have hσa' : σ[base + j]? = some (true, .prod kt (.opt t)) := by
            rwa [← htag] at hcellσ
          obtain ⟨hwv, hwt⟩ :=
            hH.typed r ρ σ (base + j) true _ true _ hρ hσ hcellρ hσa' (.inr hbr)
          cases hwv with
          | pair hke hw =>
            cases hwt with
            | pair hket hwt' =>
              refine ⟨Ξ, .refl Ξ, .ret' hD (.mapv true r base len)
                (.mapv (cells_exact hk) hrd (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩)
                  (fun h => nomatch h) (fun _ => hbt)) hS'
                (heapOk_write hH hρ hσ hσa' (.pair hke (.some hv))
                  (.pair hket (.some (HasType.value_ctx hv hvt)))), hC⟩
        | false =>
          simp only [hfk, hcellρ] at hs
          cases hs
          exact ⟨Ξ, .refl Ξ, .panic, hC⟩
      | none =>
        simp only [hfk] at hs
        split at hs
        case isTrue htip =>
          cases hs
          have hH' := heapOk_append1 hH hρ hσ hbr (.pair hkv (.some hv))
            (.pair hkvt (.some hvt)) hbtc hmfc
          refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ)
            (Ψ := Ψ.set r (σ ++ [(true, .prod kt (.opt t))])) (D := D)
            (t := .map true r (.prod kt (.opt t))) (by simp [hD]) (.mapv true r base (len + 1))
            (.mapv (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩)
              (fun h => nomatch h) (fun _ => hbt)) ?_ hH', hC⟩
          · intro j hj
            by_cases hjl : j < len
            · obtain ⟨mj, hcell⟩ := hcells j hjl
              exact ⟨σ ++ [(true, .prod kt (.opt t))], mj, List.getElem?_set_self hrΨ,
                by rw [List.getElem?_append_left ((List.getElem?_eq_some_iff.mp hcell).1)]
                   exact hcell,
                fun h => nomatch h⟩
            · have hje : j = len := by omega
              subst hje
              have hbase : base + j = σ.length := by omega
              refine ⟨σ ++ [(true, .prod kt (.opt t))], true, List.getElem?_set_self hrΨ, ?_,
                fun h => nomatch h⟩
              rw [hbase, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]
              rfl
          · exact hS'.mono
              (fun d' _ => (storeLE_set_concat hσ (true, .prod kt (.opt t))).take_take d')
              (take_set_of_le hbr _)
        case isFalse hntip =>
          cases hs
          have hcopy := heapOk_append_copy hbr len hH hρ hσ (fun j hj => let ⟨mj, h⟩ := hcells j hj; ⟨mj, _, h⟩)
          have hσ1 : (Ψ.set r (σ ++ (σ.drop base).take len))[r]? =
              some (σ ++ (σ.drop base).take len) := List.getElem?_set_self hrΨ
          have hρ1 : (H.set r (ρ ++ (ρ.drop base).take len))[r]? =
              some (ρ ++ (ρ.drop base).take len) := List.getElem?_set_self hrH
          have hle1 : StoreLE Ψ (Ψ.set r (σ ++ (σ.drop base).take len)) :=
            storeLE_set_concat_many hσ _
          have hH2 := heapOk_append1 hcopy hρ1 hσ1 hbr (.pair hkv (.some hv))
            (HasType.pair (hkvt.store_mono (hle1.take_take (r + 1))
              (storePre_of_take_eq (take_pre_set (r + 1) _ hbr)))
              (.some (hvt.store_mono (hle1.take_take (r + 1))
              (storePre_of_take_eq (take_pre_set (r + 1) _ hbr)))))
            hbtc hmfc
          rw [List.set_set, List.set_set] at hH2
          have hblen : len = 0 ∨ base + len ≤ σ.length := by
            rcases Nat.eq_zero_or_pos len with h0 | hpos
            · exact .inl h0
            · obtain ⟨mj, hcell⟩ := hcells (len - 1) (by omega)
              have := (List.getElem?_eq_some_iff.mp hcell).1
              exact .inr (by omega)
          have hxlen : ((σ.drop base).take len).length = len := by
            rcases hblen with h0 | hle0
            · subst h0; simp
            · rw [List.length_take, List.length_drop]; omega
          refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ)
            (Ψ := Ψ.set r (σ ++ (σ.drop base).take len ++ [(true, .prod kt (.opt t))]))
            (D := D) (t := .map true r (.prod kt (.opt t))) (by simp [hD]) (.mapv true r ρ.length (len + 1))
            (.mapv (cells_exact ?_) hrd (Nat.le_refl _) rfl (fun _ => ⟨rfl, hbr⟩)
              (fun h => nomatch h) (fun _ => hbt)) ?_ hH2, hC⟩
          · intro j hj
            refine ⟨σ ++ (σ.drop base).take len ++ [(true, .prod kt (.opt t))], ?_⟩
            by_cases hjl : j < len
            · obtain ⟨mj, hcell⟩ := hcells j hjl
              have hjx : base + j < σ.length := (List.getElem?_eq_some_iff.mp hcell).1
              refine ⟨mj, List.getElem?_set_self hrΨ, ?_, fun h => nomatch h⟩
              rw [hlen]
              rw [List.getElem?_append_left (by
                rw [List.length_append, hxlen]; omega)]
              rw [List.getElem?_append_right (Nat.le_add_right _ _)]
              have hj0 : σ.length + j - σ.length = j := by omega
              rw [hj0, List.getElem?_take_of_lt hjl, List.getElem?_drop]
              exact hcell
            · have hje : j = len := by omega
              subst hje
              refine ⟨true, List.getElem?_set_self hrΨ, ?_, fun h => nomatch h⟩
              rw [hlen]
              rw [List.getElem?_append_right (by rw [List.length_append, hxlen]; omega)]
              rw [List.length_append, hxlen]
              have hj0 : σ.length + j - (σ.length + j) = 0 := by omega
              rw [hj0]
              rfl
          · have hle2 : StoreLE Ψ
                (Ψ.set r (σ ++ (σ.drop base).take len ++ [(true, .prod kt (.opt t))])) := by
              rw [List.append_assoc]
              exact storeLE_set_concat_many hσ _
            exact hS'.mono (fun d' _ => hle2.take_take d') (take_set_of_le hbr _)
    | dlmL h1 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.dlmR hv (he.to_take_full hD) hS') hH, hC⟩
    | dlmR hvs hsv hS' =>
      rename_i S' sv r kt t
      obtain ⟨mt, r0, base, len, rfl, hmt, hk, hrd, -, hmb, -, hbt⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      subst hmt
      replace hk := cells_mut3 hk
      replace hbt := hbt rfl
      obtain ⟨hr1, hbr⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r]? = some σ := ⟨_, List.getElem?_eq_getElem hrΨ⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base v len with
      | none =>
        rw [hfk] at hs
        cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS' hH, hC⟩
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        obtain ⟨σ', mk, hσ', hcellσ', hkimm⟩ := hk j hjlen
        have hss : σ' = σ := Option.some.inj (hσ'.symm.trans hσ)
        have hcellσ : σ[base + j]? = some (mk, .prod kt (.opt t)) := hss ▸ hcellσ'
        have htag : mj = mk := hH.tags r ρ σ (base + j) mj _ mk _ hρ hσ hcellρ hcellσ
        cases mj with
        | true =>
          simp only [hfk, hcellρ] at hs
          cases hs
          have hσa' : σ[base + j]? = some (true, .prod kt (.opt t)) := by
            rwa [← htag] at hcellσ
          obtain ⟨hwv, hwt⟩ :=
            hH.typed r ρ σ (base + j) true _ true _ hρ hσ hcellρ hσa' (.inr hbr)
          cases hwv with
          | pair hke hw =>
            cases hwt with
            | pair hket hwt' =>
              refine ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS'
                (heapOk_write hH hρ hσ hσa' (.pair hke (.nil t))
                  (.pair hket .nil)), hC⟩
        | false =>
          simp only [hfk, hcellρ] at hs
          cases hs
          exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | lenmK hS' =>
      rename_i S' m r t
      obtain ⟨mt, r0, base, len, rfl, -, -, hrd, -, -, -, -⟩ := canonical_map hv he
      have hrH : r0 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.lit _) .lit hS' hH, hC⟩
    | @keysmK _ S' _ m r rr kt t _ hd hb hko hrb hS' =>
      obtain ⟨mt, r0, base, len, rfl, -, hk, hrd, -, hmb, -, -⟩ := canonical_map hv he
      have hin : H.length - 1 = rr := by rw [hH.len, hD]; omega
      have hrrΨ : rr < Ψ.length := by omega
      have hrrH : rr < H.length := by rw [hH.len]; omega
      have hr0Ψ : r0 < Ψ.length := by omega
      have hr0H : r0 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hr0H⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[rr]? = some ρ := ⟨_, List.getElem?_eq_getElem hrrH⟩
      obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[r0]? = some σ := ⟨_, List.getElem?_eq_getElem hr0Ψ⟩
      obtain ⟨σi, hσi⟩ : ∃ σ, Ψ[rr]? = some σ := ⟨_, List.getElem?_eq_getElem hrrΨ⟩
      have hleni : ρi.length = σi.length := hH.storeLen rr ρi σi hρi hσi
      simp only [step, hρ, hin, hρi] at hs
      cases hs
      have hcs := liveKeys_typed (k := rr) hH hρ hσ hk (fun h => (hmb h).2) (by omega) hko
      have hH' := heapOk_append_list hb (by rw [← hd]; exact hrb) (Ty.keyOk_mutFree hko) _ hH hρi hσi hcs
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (D := D) (t := .slice false rr kt) (by simp [hD])
        (.slicev false rr ρi.length (liveKeys ρ base len).length)
        (.slicev ?_ (by omega) (Nat.le_refl _) rfl (fun h => nomatch h)
          (fun _ => Ty.keyOk_mutFree hko) (fun h => nomatch h)) ?_ hH', hC⟩
      · intro j hj
        refine ⟨_, false, kt, List.getElem?_set_self hrrΨ, ?_, fun _ => rfl, Ty.sub_refl kt,
          fun h => nomatch h⟩
        rw [hleni, List.getElem?_append_right (Nat.le_add_right _ _), Nat.add_sub_cancel_left]
        simp [List.getElem?_map, List.getElem?_eq_getElem hj]
      · have hle2 : StoreLE Ψ (Ψ.set rr (σi ++ ((liveKeys ρ base len).map
            (fun ke => (false, ke))).map (fun _ => (false, kt)))) := storeLE_set_concat_many hσi _
        exact hS'.mono (fun d' _ => hle2.take_take d') (take_set_of_le hb _)
    | callvL hb hsub hbd hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (hb.of_take_full hD) (.callvR hv (he.to_take_full hD) hsub hbd hS') hH, hC⟩
    | callvR hva hb hsub hbd hS' =>
      obtain ⟨fn, ts, dfn, rfl, hfn, hl, ha, rfl, rfl⟩ := canonical_fn hva (hb.of_take_full hD)
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD hv he (.callK hfn hl ha hsub hbd hS') hH, hC⟩
    | @callK _ S' d fn ts dfn ta _ hfn hlen hargs hsub hbd hS' =>
      -- round4: region を push し、coerce した引数をシフト済み本体へ代入して同世界で評価
      simp only [step] at hs
      rw [hfn] at hs
      cases hs
      have hHl : H.length = d + 1 := by rw [hH.len, hD]
      have hρ : H.length - 1 = d := by omega
      rw [hρ]
      obtain ⟨hp, hro, hnc, hsrc, hbody⟩ := defsOk_inst hΔ hfn hargs
      obtain ⟨hva', hta'⟩ := HasType.value_coerce hv he hsub
      have hbΨ : b ≤ Ψ.length := by rw [hD]; omega
      have harg1 : HasType Δ Ξ (Ψ ++ [[]]) b b (d + 1) [] Λ
          (Expr.coerceTo ((dfn.inst ts).param.shiftR d) v) ((dfn.inst ts).param.shiftR d) :=
        hta'.store_mono (storeLE_append Ψ [[]])
          (storePre_of_take_eq (take_append_left_of_le hbΨ [[]]))
      have harg2 := HasType.value_depth_weaken hva' harg1 (Nat.le_succ (d + 1))
      -- 本体を base からシフトして現在世界へ（写像定理の anchor = d の系）、b / f を実行時のタスク境界へ下げる
      have hsh := HasType.ren_typing (ρ0 := d) (δ := d) (Nat.le_refl d) hbody (Nat.le_refl 2) hsrc
      simp only [List.map_cons, List.map_nil, Ty.renR_top, Expr.renTy_top] at hsh
      have hsh1 := hsh.chan_mono (chanLE_nil Ξ)
      have hsh2 : HasType Δ Ξ (Ψ ++ [[]]) (rmap d d 1) (rmap d d 0) (2 + d)
          [(dfn.inst ts).param.shiftR d] [] ((dfn.inst ts).body.shiftTy d) ((dfn.inst ts).ret.shiftR d) :=
        hsh1.store_mono (storeLE_nil _) (fun n _ hl => by
          have hn0 : n = 0 := Nat.le_zero.mp (by simpa using hl)
          subst hn0
          rfl)
      have hsh3 := HasType.b_lower (b' := b) (by simp only [rmap]; omega) hsh2
      have hsh4 := HasType.f_lower (f' := b) (Expr.noNewchan_shiftTy hnc) hsh3
      have h2d : 2 + d = d + 2 := by omega
      rw [h2d] at hsh4
      have hsub0 := HasType.subst0 hsh4 hva' (HasType.value_ctx hva' harg2)
      have hSf : StackTy Δ Ξ (Ψ ++ [[]]) b (.fretK ((dfn.inst ts).ret.relocR d) :: S') _ (d + 2) ((dfn.inst ts).ret.shiftR d) tf :=
        .fretK hro hbd (hS'.mono (fun d' _ => (storeLE_append Ψ [[]]).take_take d')
          (take_append_left_of_le hbΨ [[]]))
      exact ⟨Ξ, .refl Ξ, .eval' (Ψ := Ψ ++ [[]]) (D := d + 2) (by simp [hD])
        hsub0 hSf (heapOk_push hH), hC⟩
    | @callMK _ S' d fn ts dfn ta a _ hfn hlen hargs hanc hsub hbd had hS' =>
      -- R2: region を push し、anchor a（引数値の mut 位置の region = 型の anchor）で本体を写して同世界で評価
      have hav : Expr.anchorV (dfn.inst ts).param v = Option.some a := by
        rw [anchorV_eq _ hv he hsub, hanc]
      simp only [step] at hs
      rw [hfn] at hs
      simp only [hav, Option.getD_some] at hs
      cases hs
      have hHl : H.length = d + 1 := by rw [hH.len, hD]
      have hρ : H.length - 1 = d := by omega
      rw [hρ]
      obtain ⟨hp, hro, hnc, hsrc, hbody⟩ := defsOk_inst hΔ hfn hargs
      obtain ⟨hva', hta'⟩ := HasType.value_coerce hv he hsub
      have hbΨ : b ≤ Ψ.length := by rw [hD]; omega
      have harg1 : HasType Δ Ξ (Ψ ++ [[]]) b b (d + 1) [] Λ
          (Expr.coerceTo ((dfn.inst ts).param.renR a d) v) ((dfn.inst ts).param.renR a d) :=
        hta'.store_mono (storeLE_append Ψ [[]])
          (storePre_of_take_eq (take_append_left_of_le hbΨ [[]]))
      have harg2 := HasType.value_depth_weaken hva' harg1 (Nat.le_succ (d + 1))
      -- 本体を base から写して（region 0 ↦ a、それ以外 +d）現在世界へ、b / f を実行時のタスク境界へ下げる
      have hsh := HasType.ren_typing (ρ0 := a) (δ := d) had hbody (Nat.le_refl 2) hsrc
      have hsh1 := hsh.chan_mono (chanLE_nil Ξ)
      have hsh2 : HasType Δ Ξ (Ψ ++ [[]]) (rmap a d 1) (rmap a d 0) (2 + d)
          [(dfn.inst ts).param.renR a d] [] ((dfn.inst ts).body.renTy a d) ((dfn.inst ts).ret.renR a d) :=
        hsh1.store_mono (storeLE_nil _) (fun n _ hl => by
          have hn0 : n = 0 := Nat.le_zero.mp (by simpa using hl)
          subst hn0
          rfl)
      have hsh3 := HasType.b_lower (b' := b) (by simp only [rmap]; omega) hsh2
      have hsh4 := HasType.f_lower (f' := b) (Expr.noNewchan_renTy hnc) hsh3
      have h2d : 2 + d = d + 2 := by omega
      rw [h2d] at hsh4
      have hsub0 := HasType.subst0 hsh4 hva' (HasType.value_ctx hva' harg2)
      have hSf : StackTy Δ Ξ (Ψ ++ [[]]) b (.fretK ((dfn.inst ts).ret.relocA a d) :: S') _ (d + 2)
          ((dfn.inst ts).ret.renR a d) tf :=
        .fretKA hro hbd had (hS'.mono (fun d' _ => (storeLE_append Ψ [[]]).take_take d')
          (take_append_left_of_le hbΨ [[]]))
      exact ⟨Ξ, .refl Ξ, .eval' (Ψ := Ψ ++ [[]]) (D := d + 2) (by simp [hD])
        hsub0 hSf (heapOk_push hH), hC⟩
    | @fretKA Λf S' d ρ0 t0 _ hro hbd had hS' =>
      -- R2: anchor 版 — relocate（境界コピー）して region を pop
      obtain ⟨H', Ψ', v', hrel, hv', ⟨hH', hlen', hle, htk, htkH⟩, ht'⟩ :=
        relocRet_ok had (by omega) hH hD hv (HasType.value_ctx hv he) hro
      simp only [step, hrel] at hs
      cases hs
      have hdl : Ψ'.dropLast = Ψ'.take (d + 1) := by
        rw [List.dropLast_eq_take, hlen']
        congr 1
      have htkb : Ψ'.take b = Ψ.take b := by
        have h1 : Ψ'.take b = (Ψ'.take d).take b := by
          rw [List.take_take, Nat.min_eq_left (by omega)]
        have h2 : Ψ.take b = (Ψ.take d).take b := by
          rw [List.take_take, Nat.min_eq_left (by omega)]
        rw [h1, h2, htk]
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λf) (Ψ := Ψ'.dropLast) (D := d + 1)
        (by rw [hdl, List.length_take]; omega) hv'
        (by rw [hdl]; exact HasType.value_ctx hv' ht') ?_
        (heapOk_pop hH'), hC⟩
      refine hS'.mono (fun d' hd' => ?_) ?_
      · rw [hdl, List.take_take, Nat.min_eq_left hd']
        exact hle.take_take d'
      · rw [hdl, List.take_take, Nat.min_eq_left (by omega)]
        exact htkb
    | @fretK Λf S' d t0 _ hro hbd hS' =>
      -- round4: relocate（境界コピー）して region を pop
      obtain ⟨H', Ψ', v', hrel, hv', ⟨hH', hlen', hle, htk, htkH⟩, ht'⟩ :=
        relocRet_ok_top hbd hH hD hv (HasType.value_ctx hv he) hro
      simp only [step, hrel] at hs
      cases hs
      have hdl : Ψ'.dropLast = Ψ'.take (d + 1) := by
        rw [List.dropLast_eq_take, hlen']
        congr 1
      have htkb : Ψ'.take b = Ψ.take b := by
        have h1 : Ψ'.take b = (Ψ'.take d).take b := by
          rw [List.take_take, Nat.min_eq_left (by omega)]
        have h2 : Ψ.take b = (Ψ.take d).take b := by
          rw [List.take_take, Nat.min_eq_left (by omega)]
        rw [h1, h2, htk]
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λf) (Ψ := Ψ'.dropLast) (D := d + 1)
        (by rw [hdl, List.length_take]; omega) hv'
        (by rw [hdl]; exact HasType.value_ctx hv' ht') ?_
        (heapOk_pop hH'), hC⟩
      refine hS'.mono (fun d' hd' => ?_) ?_
      · rw [hdl, List.take_take, Nat.min_eq_left hd']
        exact hle.take_take d'
      · rw [hdl, List.take_take, Nat.min_eq_left (by omega)]
        exact htkb
    | iteK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD) hS' hH, hC⟩
      · simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .eval' hD (h2.of_take_full hD) hS' hH, hC⟩
    | someK hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.some hv) (.some he) hS' hH, hC⟩
    | ifnilK h1 h2 hS' =>
      rcases canonical_opt hv he with rfl | ⟨w, rfl, hw⟩
      · simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD) hS' hH, hC⟩
      · simp only [step] at hs; cases hs
        cases he with
        | some hw' =>
          exact ⟨Ξ, .refl Ξ, .eval' hD (HasType.subst0 (h2.of_take_full hD) hw hw') hS' hH, hC⟩
    | inlK hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.inl _ hv) (.inl he) hS' hH, hC⟩
    | inrK hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD (.inr _ hv) (.inr he) hS' hH, hC⟩
    | caseK h1 h2 hS' =>
      rcases canonical_union hv he with ⟨w, rfl, hw⟩ | ⟨w, rfl, hw⟩
      · simp only [step] at hs; cases hs
        cases he with
        | inl hw' =>
          exact ⟨Ξ, .refl Ξ, .eval' hD (HasType.subst0 (h1.of_take_full hD) hw hw') hS' hH, hC⟩
      · simp only [step] at hs; cases hs
        cases he with
        | inr hw' =>
          exact ⟨Ξ, .refl Ξ, .eval' hD (HasType.subst0 (h2.of_take_full hD) hw hw') hS' hH, hC⟩
    | allocK hb hbd hmf hS' =>
      rename_i S' d m
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ =>
        cases hs
        have hHlen : H.length = d + 1 := by rw [hH.len, hD]
        have hk : H.length - 1 = d := by omega
        rw [hk] at hρ ⊢
        obtain ⟨σ, hσ⟩ : ∃ σ, Ψ[d]? = some σ :=
          ⟨_, List.getElem?_eq_getElem (by omega)⟩
        have hslen : ρ.length = σ.length := hH.storeLen d ρ σ hρ hσ
        refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.set d (σ ++ [(m, t)])) (D := d + 1)
          (t := .ref m d t) (by simp [hD]) (.loc d ρ.length)
          (.loc (ρ := σ ++ [(m, t)]) ?_ ?_ (by omega) (Nat.le_refl _)
            (fun _ => ⟨rfl, hbd⟩) (fun h => h)) ?_
          (heapOk_alloc hH hρ hσ (by omega) hbd hv (by rw [hD]; exact he) hb hmf), hC⟩
        · rw [List.getElem?_set_self (by omega)]
        · rw [hslen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]
          rfl
        · exact hS'.mono (fun d' _ => (storeLE_set_concat hσ (m, t)).take_take d')
            (take_set_of_le hbd _)
    | derefK hS' =>
      rename_i S' m r t'
      obtain ⟨r0, a, σ, m', rfl, hσ, hσa, hrd, -, hmb, hmm⟩ := canonical_ref hv he
      have hrΨ : r0 < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r0 < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r0]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r0 ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      simp only [step, hρ, hw] at hs
      cases hs
      have hcond : m' = false ∨ b ≤ r0 := by
        cases m with
        | false => exact .inl (hmm rfl)
        | true => exact .inr (hmb rfl).2
      obtain ⟨hwv, hwt⟩ := hH.typed r0 ρ σ a mw w m' t' hρ hσ hw hσa hcond
      refine ⟨Ξ, .refl Ξ, .ret' hD hwv ?_ hS' hH, hC⟩
      exact HasType.value_ctx hwv (HasType.value_depth_weaken hwv
        (hwt.store_mono (storeLE_take_self Ψ (r0 + 1)) (storePre_take_self Ψ (r0 + 1) b))
        (by omega))
    | assignL h1 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.assignR hv (he.to_take_full hD) hS') hH, hC⟩
    | assignR hvl hl hS' =>
      rename_i S' l r
      obtain ⟨r0, a, σ, m', rfl, hσ, hσa, hrd, -, hmb, hmm⟩ :=
        canonical_ref hvl (hl.of_take_full hD)
      obtain ⟨hr1, -⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      have htag : mw = m' := hH.tags r ρ σ a mw w m' t hρ hσ hw hσa
      cases mw with
      | true =>
        -- タグ true: 書き込み
        simp only [step, hρ, hw] at hs
        cases hs
        have hσa' : σ[a]? = some (true, t) := by rwa [← htag] at hσa
        have hbt : t.regionsBelow (r + 1) := hH.tyBelow r σ a true t hσ hσa'
        refine ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS' ?_, hC⟩
        exact heapOk_write hH hρ hσ hσa' hv (HasType.value_strengthen hv he hbt)
      | false =>
        -- タグ false（freeze 済み）: panic
        simp only [step, hρ, hw] at hs
        cases hs
        exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | freezeK hmf hS' =>
      rename_i S' r t
      obtain ⟨r0, a, σ, m', rfl, hσ, hσa, hrd, -, hmb, -⟩ := canonical_ref hv he
      obtain ⟨hr1, hbr⟩ := hmb rfl
      subst hr1
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      simp only [step, hρ, hw] at hs
      cases hs
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.set r (σ.set a (false, t))) (D := D)
        (t := .ref false r t) (by simp [hD]) (.loc r a)
        (.loc (ρ := σ.set a (false, t)) ?_ ?_ hrd (Nat.le_refl _)
          (fun h => nomatch h) (fun _ => rfl)) ?_
        (heapOk_freeze hH hρ hσ hw hσa hbr hmf), hC⟩
      · rw [List.getElem?_set_self hrΨ]
      · rw [List.getElem?_set_self haσ]
      · exact hS'.mono (fun d' _ => (storeLE_set_freeze hσ hσa).take_take d')
          (take_set_of_le hbr _)
    | whileK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .eval' hD (h2.of_take_full hD) (.whileB h1 h2 hS') hH, hC⟩
      · simp only [step] at hs; cases hs
        exact ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS' hH, hC⟩
    | whileB h1 h2 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (.whileE (h1.of_take_full hD) (h2.of_take_full hD)) hS' hH, hC⟩
    | labelK hb hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hD hv (HasType.value_ctx hv he) hS' hH, hC⟩
    | jumpK hn hrel hS' =>
      obtain ⟨S'', Λ', d', H'', Ψ', v', hst, hv', hH'', hl', ht', hS'', -⟩ :=
        jumpK_step π hH hD hv he hn hrel hS'
      rw [hst] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hl' hv' ht' hS'' hH'', hC⟩
    | taskK _ => simp [step] at hs
    | regionK hb hS' =>
      rename_i S' d
      simp only [step] at hs; cases hs
      have hdl : Ψ.dropLast = Ψ.take d := by
        rw [List.dropLast_eq_take, hD]
        congr 1
      refine ⟨Ξ, .refl Ξ, .ret' (Λ := Λ) (Ψ := Ψ.dropLast) (D := d) (t := t) (by simp [hD]) hv ?_ ?_
        (heapOk_pop hH), hC⟩
      · rw [hdl]
        exact HasType.value_strengthen hv he hb
      · refine hS'.mono (fun d' hd' => ?_)
          (take_dropLast_eq Ψ (by have := hS'.le_depth; omega))
        rw [take_dropLast_eq Ψ (by omega)]
        exact StoreLE.refl _
    | regionKR hr hb hS' =>
      rename_i S' d tB
      obtain ⟨H'', Ψ', v', hst, hv', hH'', hl', ht', hS'', -⟩ := regionKR_step π hH hD hv he hr hb hS'
      rw [hst] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hl' hv' ht' hS'' hH'', hC⟩
    | copyK hk hr hb _ hS' =>
      obtain ⟨H', Ψ', v', hst, hv', hH', hl', ht', hS'', -⟩ := copyK_step π hH hD hv he hk hr hb hS'
      rw [hst] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .ret' hl' hv' ht' hS'' hH', hC⟩
    -- 段 6 P1: 端点への送信・受信（task の外では到達しない形 — panic）
    | sendLE h1 hp hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (h1.of_take_full hD) (.sendRE hv (he.to_take_full hD) hp hS') hH, hC⟩
    | sendRE hvc hc _ =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hvc hc
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | recvKE _ =>
      obtain ⟨p, k, rfl, -⟩ := canonical_rx hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | closeKE _ =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    -- 段 6 P1: task の外（子の表を持たない世界）の scope の出口・spawn / join / try
    | scopeK hr hb hem hec hbd hS' =>
      obtain ⟨H'', Ψ', v', hrl, hv', hH'', hl', ht', hS'', -⟩ := reloc_exit hH hD hv he hr hb hS'
      simp only [step, hrl] at hs; cases hs
      rw [show H.length - 2 = Ψ'.dropLast.length - 1 by rw [hl', hH.len, hD]; omega, hl']
      exact ⟨Ξ, .refl Ξ, .ret' hl' (.inl _ hv') (.inl ht') hS'' hH'', hC⟩
    | spawnK ha hm h1 hrb hcf hε hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .eval' hD (ha.of_take_full hD) (.spawnA hv (he.to_take_full hD) hm h1 hrb hcf hε hS') hH, hC⟩
    | spawnA hsv hsvt _ _ _ _ _ _ =>
      obtain ⟨rfl, -⟩ := canonical_scope hsv hsvt
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | joinK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | tryK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ, .panic, hC⟩
    | sendL h1 hS' =>
      simp only [step] at hs; cases hs
      exact ⟨Ξ, .refl Ξ,
        .eval' hD (h1.of_take_full hD) (.sendR hv (he.to_take_full hD) hS') hH, hC⟩
    | sendR hvc hc hS' =>
      rename_i S' c₀ rc
      obtain ⟨c, Ψc, rfl, hΞc, hlen, htake, hf⟩ := canonical_chan hvc (hc.of_take_full hD)
      have hcK : c < K.leg.length := by rw [hC.len]; exact (List.getElem?_eq_some_iff.mp hΞc).1
      obtain ⟨q, hq⟩ : ∃ q, K.leg[c]? = some q := ⟨_, List.getElem?_eq_getElem hcK⟩
      simp only [step, hq] at hs
      cases hs
      obtain ⟨hrb, hmf⟩ := hC.wf c Ψc t hΞc
      -- ペイロードをスナップショットの世界（f = b = d = rc）へ落とす:
      -- strengthen（深さと Ψ を rc へ）→ 等式でスナップショットに乗り換え → b → rc → f → rc
      have h1 : HasType Δ Ξ Ψc b b rc [] Λ v t := by
        have h0 := HasType.value_strengthen (d := rc) hv he (by rw [← hlen]; exact hrb)
        rwa [htake] at h0
      have h3 : HasType Δ Ξ Ψc rc rc rc [] Λ v t :=
        HasType.value_f_set (HasType.value_sb hv hmf h1 : HasType Δ Ξ Ψc b rc rc [] Λ v t)
          (hv := hv) (by rw [← hlen]; exact hrb)
      refine ⟨Ξ, .refl Ξ, .ret' hD .triv .triv hS' hH, ?_⟩
      exact chanOk_send hC hq hΞc hv (by rw [hlen]; exact h3)
    | recvK hS' =>
      rename_i S' rc t
      obtain ⟨c, Ψc, rfl, hΞc, hlen, htake, hf⟩ := canonical_chan hv he
      have hcK : c < K.leg.length := by rw [hC.len]; exact (List.getElem?_eq_some_iff.mp hΞc).1
      obtain ⟨q, hq⟩ : ∃ q, K.leg[c]? = some q := ⟨_, List.getElem?_eq_getElem hcK⟩
      cases q with
      | nil => simp [step, hq] at hs
      | cons w q' =>
        simp only [step, hq] at hs
        cases hs
        obtain ⟨hwv, hwt⟩ := hC.typed c (w :: q') Ψc t hq hΞc w (by simp)
        obtain ⟨hrb, hmf⟩ := hC.wf c Ψc t hΞc
        -- rc はこの世界の深さに収まる（スナップショット等式の長さから）
        have hlt : rc ≤ Ψ.length := by
          have h := congrArg List.length htake
          simp only [List.length_take, hlen] at h
          omega
        -- スナップショットの世界から受け手の世界へ:
        -- store_mono（Ψc = Ψ.take rc はプレフィクス）→ 深さ weaken → b 付け替え → f 引き上げ
        have hle : StoreLE Ψc Ψ := by
          rw [← htake]
          exact storeLE_take_self Ψ rc
        have hpre : StorePre Ψc.length Ψc Ψ := by
          intro n hn _
          rw [← htake, List.take_take, Nat.min_eq_left (by omega)]
        have h1 : HasType Δ Ξ Ψ Ψc.length Ψc.length Ψc.length [] [] w t :=
          hwt.store_mono hle hpre
        have h2 := HasType.value_depth_weaken hwv h1 (show Ψc.length ≤ D by omega)
        have h3 := HasType.value_sb (b' := b) hwv hmf h2
        have h4 := HasType.f_mono (show Ψc.length ≤ b by rw [hlen]; exact hf) h3
        refine ⟨Ξ, .refl Ξ, .ret' hD hwv (HasType.value_ctx hwv h4) hS' hH, chanOk_recv hC hq⟩

/-- task の型付けの付け替え（段 6 P1）: main を Ξ' の世界の m' に替え、子の世界は共有の部分だけ Ξ' に揃える（子の表 tk は不変） -/
theorem famTy_rebase {Δ : Defs} {Ξ Ξ' : ChanTy} {b : Nat} {id : List Nat} {o n : Nat} {m' : State} {ks : Kids}
    {tf : Ty} {Ξs : Nat → ChanTy} {bs : Nat → Nat} {tcs : Nat → Ty}
    (hle : ChanLE Ξ Ξ') (htk : Ξ'.tk = Ξ.tk) (hmf' : m'.isFam = false) (hm' : StateTy Δ Ξ' b m' tf)
    (hlen : Ξ.tk.length = o + ks.length) (hch : ∀ i, (Ξs i).ch = Ξ.ch) (hep : ∀ i, (Ξs i).ep = Ξ.ep)
    (hloc : ∀ (i rs : Nat) (t : Ty), Ξ.tk[i]? = some (rs, t) → t.mutFree = true ∧ t.chanFree = true)
    (hex : ∀ i rs kid, ks.get? i = some (rs, kid) → ∃ t, Ξ.tk[o + i]? = some (rs, t))
    (hkt : ∀ i rs kid t, ks.get? i = some (rs, kid) → Ξ.tk[o + i]? = some (rs, t) →
      (tcs i).mutFree = true ∧ (tcs i).chanFree = true ∧ (tcs i).relocR rs = t)
    (hk : ∀ i rs kid, ks.get? i = some (rs, kid) → StateTy Δ (Ξs i) (bs i) kid (tcs i))
    (htg : ∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = .prod t (.opt ε0) ∧ ε0.relocR 0 = tg.1) :
    StateTy Δ Ξ' b (.fam id o n m' ks) tf := by
  refine .fam (fun j => { Ξs j with ch := Ξ'.ch, ep := Ξ'.ep }) bs tcs hmf' hm' (by rw [htk]; exact hlen)
    (fun _ => rfl) (fun _ => rfl) (by rw [htk]; exact hloc) (by rw [htk]; exact hex) (by rw [htk]; exact hkt) ?_ htg
  intro i rs kid hg
  have hle' : ChanLE (Ξs i) { Ξs i with ch := Ξ'.ch, ep := Ξ'.ep } :=
    ⟨fun c p h => by rw [hch i] at h; exact hle.ch c p h, fun k t' h => by rw [hep i] at h; exact hle.ep k t' h,
      fun _ _ h => h⟩
  exact (hk i rs kid hg).chan_mono hle' rfl

/-- famTy_rebase の回収済みの印つき版（join / try が結果を受けた — 子の状態と札の err の型は変わらない） -/
theorem famTy_rebase_mark {Δ : Defs} {Ξ Ξ' : ChanTy} {b : Nat} {id : List Nat} {o n : Nat} {m' : State} {ks : Kids}
    {tf : Ty} {Ξs : Nat → ChanTy} {bs : Nat → Nat} {tcs : Nat → Ty}
    (hle : ChanLE Ξ Ξ') (htk : Ξ'.tk = Ξ.tk) (hmf' : m'.isFam = false) (hm' : StateTy Δ Ξ' b m' tf)
    (hlen : Ξ.tk.length = o + ks.length) (hch : ∀ i, (Ξs i).ch = Ξ.ch) (hep : ∀ i, (Ξs i).ep = Ξ.ep)
    (hloc : ∀ (i rs : Nat) (t : Ty), Ξ.tk[i]? = some (rs, t) → t.mutFree = true ∧ t.chanFree = true)
    (hex : ∀ i rs kid, ks.get? i = some (rs, kid) → ∃ t, Ξ.tk[o + i]? = some (rs, t))
    (hkt : ∀ i rs kid t, ks.get? i = some (rs, kid) → Ξ.tk[o + i]? = some (rs, t) →
      (tcs i).mutFree = true ∧ (tcs i).chanFree = true ∧ (tcs i).relocR rs = t)
    (hk : ∀ i rs kid, ks.get? i = some (rs, kid) → StateTy Δ (Ξs i) (bs i) kid (tcs i))
    (htg : ∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = .prod t (.opt ε0) ∧ ε0.relocR 0 = tg.1) (j : Nat) :
    StateTy Δ Ξ' b (.fam id o n m' (ks.mark j)) tf :=
  famTy_rebase hle htk hmf' hm' (by rw [Kids.length_mark]; exact hlen) hch hep hloc
    (fun i rs kid h => hex i rs kid (by rwa [Kids.get?_mark] at h))
    (fun i rs kid t h => hkt i rs kid t (by rwa [Kids.get?_mark] at h))
    (fun i rs kid h => hk i rs kid (by rwa [Kids.get?_mark] at h))
    (fun i tg h => by obtain ⟨tg', h1, h2⟩ := Kids.tag?_mark ks j i tg h; rw [← h2]; exact htg i tg' h1)

theorem Ty.rehome_of_mutFree {d : Nat} : ∀ {t : Ty}, t.mutFree = true → t.rehome d = t
  | .own _ _ _, h => by simp [Ty.mutFree] at h
  | .prod l r, h => by
    simp only [Ty.mutFree, Bool.and_eq_true] at h
    simp [Ty.rehome, Ty.rehome_of_mutFree h.1, Ty.rehome_of_mutFree h.2]
  | .int, _ => rfl | .tvar _, _ => rfl | .bool, _ => rfl | .byte, _ => rfl | .f64, _ => rfl | .unit, _ => rfl
  | .opt _, _ => rfl | .union _ _, _ => rfl | .ref _ _ _, _ => rfl | .slice _ _ _, _ => rfl
  | .map _ _ _, _ => rfl | .chan _ _, _ => rfl | .fn _ _, _ => rfl

/-- 端点の引き渡しの型付け（段 6 P1）: 渡す値 va : ta（givable）の giveV は、端点の家を D へ移した値と、
持ち主の札だけを書き換えたストアを返す。データの部分の世界の移し替えは htr が担う -/
theorem giveV_ok {Δ : Defs} {Ξ : ChanTy} {Ψ Ψ2 : StoreTy} {f b d f2 d2 rs D : Nat} {Γ : Ctx} {Λ : LCtx}
    {me kid : List Nat}
    (htr : ∀ v t, Value v → t.mutFree = true → t.chanFree = true → t.regionsBelow (rs + 1) = true →
      HasType Δ Ξ Ψ f b d Γ Λ v t → HasType Δ Ξ Ψ2 f2 D d2 [] [] v t)
    (hD : D < d2) :
    ∀ {va va' : Expr} {ta : Ty} {K K' : ChanSt}, ChanOk Δ Ξ K → Value va → HasType Δ Ξ Ψ f b d Γ Λ va ta →
      ta.givable rs = true → giveV me kid D va K = some (va', K') →
      Value va' ∧ HasType Δ Ξ Ψ2 f2 D d2 [] [] va' (ta.rehome D) ∧ ChanOk Δ Ξ K' := by
  intro va va' ta K K' hC hv he hg hgv
  induction hv generalizing ta K va' K' with
  | epV p k bb r =>
    cases bb with
    | true =>
      cases he with
      | epTx h1 h2 h3 =>
        simp only [giveV] at hgv
        split at hgv
        · rename_i ent hent
          split at hgv
          · simp only [Option.some.injEq, Prod.mk.injEq] at hgv
            obtain ⟨rfl, rfl⟩ := hgv
            refine ⟨.epV _ _ _ _, .epTx (Nat.le_refl _) hD h3, chanOk_epSet hC hent rfl ?_⟩
            intro t ht w hw
            exact (hC.eptyped _ t ent ht hent).2.2.2.2 w hw
          · cases hgv
        · cases hgv
    | false =>
      cases he with
      | epRx h1 h2 h3 =>
        simp only [giveV] at hgv
        split at hgv
        · rename_i ent hent
          split at hgv
          · simp only [Option.some.injEq, Prod.mk.injEq] at hgv
            obtain ⟨rfl, rfl⟩ := hgv
            refine ⟨.epV _ _ _ _, .epRx (Nat.le_refl _) hD h3, chanOk_epSet hC hent rfl ?_⟩
            intro t ht w hw
            exact (hC.eptyped _ t ent ht hent).2.2.2.2 w hw
          · cases hgv
        · cases hgv
  | pair hva hvb iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.givable, Bool.and_eq_true] at hg
      simp only [giveV] at hgv
      split at hgv
      · rename_i a' K₁ hga
        split at hgv
        · rename_i b' K₂ hgb
          simp only [Option.some.injEq, Prod.mk.injEq] at hgv
          obtain ⟨rfl, rfl⟩ := hgv
          obtain ⟨hva', ha', hC₁⟩ := iha hC h1 hg.1 hga
          obtain ⟨hvb', hb', hC₂⟩ := ihb hC₁ h2 hg.2 hgb
          exact ⟨.pair hva' hvb', .pair ha' hb', hC₂⟩
        · cases hgv
      · cases hgv
  | _ =>
    simp only [giveV, Option.some.injEq, Prod.mk.injEq] at hgv
    obtain ⟨rfl, rfl⟩ := hgv
    refine ⟨by constructor <;> assumption, ?_, hC⟩
    have hdat : ta.mutFree = true ∧ ta.chanFree = true ∧ ta.regionsBelow (rs + 1) = true := by
      cases he <;> first
        | (simp [Ty.givable, Ty.mutFree] at hg; done)
        | (rw [Ty.givable_eq_data (by intros; nofun) (by intros; nofun)] at hg
           simpa only [Bool.and_eq_true, and_assoc] using hg)
    rw [Ty.rehome_of_mutFree hdat.1]
    exact htr _ _ (by constructor <;> assumption) hdat.1 hdat.2.1 hdat.2.2 he

/-- 端点のチャネルの生成の型環境の伸び（段 6 P1）: 新しい鍵を ep の先頭に足しても引ける項目は引けたまま -/
theorem chanLE_addEp {Ξ : ChanTy} {k : EpKey} {t : Ty} (hfresh : Ξ.ep.lookup k = none) :
    ChanLE Ξ { Ξ with ep := (k, t) :: Ξ.ep } := by
  refine ⟨fun _ _ h => h, ?_, fun _ _ h => h⟩
  intro k' t' h
  by_cases hkk : k' = k
  · subst hkk; rw [hfresh] at h; cases h
  · show ((k, t) :: Ξ.ep).lookup k' = some t'
    rw [lookup_cons_ne hkk]; exact h

/-- 端点のキューへ: loc-free で chan なしの値は空の世界で型が付く -/
theorem HasType.value_toEmpty {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {Λ : LCtx}
    {v : Expr} {t : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t)
    (hb : t.regionsBelow 0 = true) (hc : t.chanFree = true) : HasType Δ ∅ [] 0 0 0 [] [] v t :=
  HasType.value_anyΞ hv (Ty.mutFree_of_locFree hb) hc
    (HasType.value_ctx (Γ' := []) (Λ' := []) hv (HasType.value_export hv he hb))

/-- 端点のキューから: 空の世界で型付く loc-free で chan なしの値はどの世界へも降ろせる -/
theorem HasType.value_fromEmpty {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {Λ : LCtx}
    {v : Expr} {t : Ty} (hv : Value v) (he : HasType Δ ∅ [] 0 0 0 [] [] v t)
    (hb : t.regionsBelow 0 = true) (hc : t.chanFree = true) : HasType Δ Ξ Ψ f b d Γ Λ v t :=
  HasType.value_ctx hv (HasType.value_import (Ψ := Ψ) (f := f) (b := b) (d := d) (Γ := Γ) hv
    (HasType.value_anyΞ (Ξ' := Ξ) hv (Ty.mutFree_of_locFree hb) hc he) hb)

theorem preservation {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty}
    (hΔ : DefsOk Δ) (h : StateTy Δ Ξ b s tf) :
    ∀ {π : List Bool} {K : ChanSt} {s' : State} {K' : ChanSt},
      ChanOk Δ Ξ K → step Δ π s K = some (s', K') →
      ∃ Ξ', ChanLE Ξ Ξ' ∧ (s.isFam = false → Ξ'.tk = Ξ.tk) ∧ StateTy Δ Ξ' b s' tf ∧ ChanOk Δ Ξ' K' := by
  induction h with
  | eval he hS hH =>
    intro π K s' K' hC hs
    obtain ⟨Ξ', hle, hty, hC'⟩ := preservation_eval hΔ he hS hH hC hs
    exact ⟨Ξ', hle.le, fun _ => hle.tk, hty, hC'⟩
  | ret hv he hS hH =>
    intro π K s' K' hC hs
    obtain ⟨Ξ', hle, hty, hC'⟩ := preservation_ret hΔ hv he hS hH hC hs
    exact ⟨Ξ', hle.le, fun _ => hle.tk, hty, hC'⟩
  | par hs1 hs2 hf1 hf2 hS hH ih1 ih2 =>
    rename_i Ξ b Ψ H S s1 s2 t1 t2 tf
    intro π K s' K' hC hs
    rw [step_par_def] at hs
    by_cases hj : ((taskDone s1).isSome && (taskDone s2).isSome) = true
    · -- join: 両タスク完了
      rw [if_pos hj] at hs
      cases hs
      exact ⟨Ξ, .refl Ξ, fun _ => rfl, .ret .triv .triv hS hH, hC⟩
    · -- どちらかのタスクの 1 歩（または panic の伝播）
      rw [if_neg hj] at hs
      cases π with
      | nil => simp at hs
      | cons c π' =>
        cases c with
        | true =>
          by_cases hp : s1.isPanic = true
          · simp [hp] at hs
            obtain ⟨rfl, rfl⟩ := hs
            exact ⟨Ξ, .refl Ξ, fun _ => rfl, .panic, hC⟩
          · cases hstep : step Δ π' s1 K with
            | none => simp [hp, hstep] at hs
            | some p =>
              obtain ⟨s1', K₁⟩ := p
              simp [hp, hstep] at hs
              obtain ⟨rfl, rfl⟩ := hs
              obtain ⟨Ξ', hle, htk, hty1, hC'⟩ := ih1 hC hstep
              have htk1 := htk hf1
              exact ⟨Ξ', hle, fun _ => htk1, .par hty1 (hs2.chan_mono hle htk1) (step_isFam hf1 hstep) hf2
                (hS.chan_mono hle) (heapOk_chan_mono hle hH), hC'⟩
        | false =>
          by_cases hp : s2.isPanic = true
          · simp [hp] at hs
            obtain ⟨rfl, rfl⟩ := hs
            exact ⟨Ξ, .refl Ξ, fun _ => rfl, .panic, hC⟩
          · cases hstep : step Δ π' s2 K with
            | none => simp [hp, hstep] at hs
            | some p =>
              obtain ⟨s2', K₂⟩ := p
              simp [hp, hstep] at hs
              obtain ⟨rfl, rfl⟩ := hs
              obtain ⟨Ξ', hle, htk, hty2, hC'⟩ := ih2 hC hstep
              have htk2 := htk hf2
              exact ⟨Ξ', hle, fun _ => htk2, .par (hs1.chan_mono hle htk2) hty2 hf1 (step_isFam hf2 hstep)
                (hS.chan_mono hle) (heapOk_chan_mono hle hH), hC'⟩
  | panic =>
    intro π K s' K' hC hs
    simp [step] at hs
  | fam Ξs bs tcs hmf hm hlen hch hep hloc hex hkt hk htg ihm ihk =>
    rename_i Ξ b id o n m ks tf
    intro π K s' K' hC hs
    rw [step_fam_def] at hs
    -- main の 1 歩（spawn / join / try / scope の出口は子の表を見る・それ以外は main へ委ねる）
    have hmain : ∀ πt, famMain id o n m ks K (step Δ πt m K) = some (s', K') →
        ∃ Ξ', ChanLE Ξ Ξ' ∧ ((State.fam id o n m ks).isFam = false → Ξ'.tk = Ξ.tk) ∧
          StateTy Δ Ξ' b s' tf ∧ ChanOk Δ Ξ' K' := by
      intro πt hfm
      unfold famMain at hfm
      split at hfm
      · -- spawn: 端点を子へ引き渡し（持ち主の札を書き換え — 持ち主でなければ panic）、子を末尾に足し、handle を返す
        rename_i H rs εs e S v
        split at hfm
        case h_2 =>
          simp only [Option.some.injEq, Prod.mk.injEq] at hfm
          obtain ⟨rfl, rfl⟩ := hfm
          exact ⟨Ξ, .refl Ξ, fun _ => rfl, famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg, hC⟩
        rename_i va' Kg hgv
        simp only [Option.some.injEq, Prod.mk.injEq] at hfm
        obtain ⟨rfl, rfl⟩ := hfm
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ ta _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | @spawnA _ _ _ _ _ _ _ t1 ε ε0 _ hsv hsvt hmta h1 hrb hcf hε hS' =>
            obtain ⟨hvr, hbrs, hrsD⟩ := canonical_scope hsv hsvt
            cases hvr
            have hε0 : ε0.relocR 0 = εs.relocR 0 := by
              simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at hε; exact hε.2
            generalize ht : Ty.prod t1 (.opt ε0) = t at h1 hrb hcf hS'
            let L := ks.length
            have hbD : b ≤ Ψ.length := by rw [hD]; exact hS'.le_depth
            have hΨD : Ψ.take D = Ψ := by rw [← hD]; exact List.take_length
            rw [hΨD, ← hD] at h1
            rw [hH.len] at hgv
            have hpre : StorePre Ψ.length Ψ (Ψ ++ [[]]) :=
              storePre_of_take_eq (take_append_left_of_le (Nat.le_refl _) [[]])
            -- 渡す値: データは写す（mutFree なので共有境界 b → Ψ.length・深さ +1・ラベルなしの子の世界へ）・端点は家を子の region へ
            rw [← hD] at he
            obtain ⟨hva'v, hva, hCg⟩ := giveV_ok (Ψ2 := Ψ ++ [[]]) (f2 := Ψ.length) (d2 := Ψ.length + 1)
              (fun w tw hw hmw _ _ hwe => by
                have h0 := HasType.value_ctx (Γ' := []) (Λ' := []) hw
                  (HasType.value_depth_weaken hw (HasType.value_sb (b' := Ψ.length) hw hmw hwe) (Nat.le_succ _))
                exact (h0.f_mono hbD).store_mono (storeLE_append Ψ [[]]) hpre)
              (Nat.lt_succ_self _) hC hv he hmta hgv
            let Ξ' : ChanTy := { Ξ with tk := Ξ.tk ++ [(rs, t.relocR rs)] }
            have hle : ChanLE Ξ Ξ' := ⟨fun _ _ h => h, fun _ _ h => h, fun i p h => by
              have : i < Ξ.tk.length := (List.getElem?_eq_some_iff.mp h).1
              show (Ξ.tk ++ [(rs, t.relocR rs)])[i]? = some p
              rw [List.getElem?_append_left this]; exact h⟩
            have hlook : Ξ'.tk[o + L]? = some (rs, t.relocR rs) := by
              show (Ξ.tk ++ [(rs, t.relocR rs)])[o + L]? = some (rs, t.relocR rs)
              rw [← hlen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self]; rfl
            -- 子の task: 親ヒープのコピー + 自前の region（深さ Ψ.length）、世界は spawn した時点の親の世界 Ξ。
            -- 底は taskK（P3b-4 — 自前の region を持ったまま止まる。結果は join / try が写す）
            have hkid : StateTy Δ Ξ Ψ.length
                (.fam (id ++ [L]) (o + L) 0 (.eval (H ++ [[]]) [.taskK] (Expr.subst 0 va' e)) .nil) t := by
              refine .fam (fun _ => Ξ) (fun _ => 0) (fun _ => t) rfl ?_
                (by simp only [Kids.length, Nat.add_zero]; exact hlen) (fun _ => rfl) (fun _ => rfl)
                hloc (fun _ _ _ h => by simp [Kids.get?] at h) (fun _ _ _ _ h => by simp [Kids.get?] at h)
                (fun _ _ _ h => by simp [Kids.get?] at h) (fun _ _ h => by simp [Kids.tag?] at h)
              have he' := (h1.f_mono hbD).store_mono (storeLE_append Ψ [[]]) hpre
              refine .eval' (Ψ := Ψ ++ [[]]) (D := Ψ.length + 1) (by simp) (HasType.subst0 he' hva'v hva) ?_
                (heapOk_push (heapOk_spawn hbD hH))
              exact .taskK (by omega)
            refine ⟨Ξ', hle, fun h => by simp [State.isFam] at h, ?_, chanOk_world hCg rfl rfl⟩
            refine .fam (fun j => if j = L then Ξ else Ξs j) (fun j => if j = L then Ψ.length else bs j)
              (fun j => if j = L then t else tcs j) rfl
              (.ret' (Ψ := Ψ) hD (.taskV rs (o + L)) (.taskV hbrs hrsD hlook) (hS'.chan_mono hle) (heapOk_chan_mono hle hH))
              (by simp [Ξ', Kids.length_snoc, hlen]; omega) ?_ ?_ ?_ ?_ ?_ ?_ ?_
            · intro j; by_cases hj : j = L <;> simp [hj, hch j, Ξ']
            · intro j; by_cases hj : j = L <;> simp [hj, hep j, Ξ']
            · intro i rs' t' h
              by_cases hi : i < Ξ.tk.length
              · have : Ξ'.tk[i]? = Ξ.tk[i]? := List.getElem?_append_left hi
                rw [this] at h; exact hloc i rs' t' h
              · have hi' : Ξ.tk.length ≤ i := Nat.le_of_not_lt hi
                have : Ξ'.tk[i]? = [(rs, t.relocR rs)][i - Ξ.tk.length]? := List.getElem?_append_right hi'
                rw [this] at h
                have hz : i - Ξ.tk.length = 0 := by
                  have := (List.getElem?_eq_some_iff.mp h).1; simp at this; omega
                rw [hz] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
                exact ⟨Ty.relocR_mutFree_of hrb, Ty.relocR_chanFree_of hrb hcf⟩
            · intro i rs' kid h
              by_cases hi : i < L
              · rw [Kids.get?_snoc_lt _ _ _ hi] at h
                obtain ⟨t', ht'⟩ := hex i rs' kid h
                exact ⟨t', by rw [hle.tk _ _ ht']⟩
              · by_cases hiL : i = L
                · subst hiL; rw [Kids.get?_snoc_self] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
                  exact ⟨_, hlook⟩
                · rw [Kids.get?_snoc_gt _ _ _ (by omega)] at h; cases h
            · intro i rs' kid t' h ht'
              by_cases hi : i < L
              · rw [Kids.get?_snoc_lt _ _ _ hi] at h
                have hiL : i ≠ L := by omega
                simp only [hiL, if_false]
                obtain ⟨t'', ht''⟩ := hex i rs' kid h
                have := hle.tk _ _ ht''
                rw [this] at ht'; simp at ht'; obtain rfl := ht'
                exact hkt i rs' kid t'' h ht''
              · by_cases hiL : i = L
                · subst hiL; rw [Kids.get?_snoc_self] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
                  rw [hlook] at ht'; simp at ht'; subst ht'
                  refine ⟨?_, ?_, ?_⟩ <;> simp [hrb, hcf]
                · rw [Kids.get?_snoc_gt _ _ _ (by omega)] at h; cases h
            · intro i rs' kid h
              by_cases hi : i < L
              · rw [Kids.get?_snoc_lt _ _ _ hi] at h
                have hiL : i ≠ L := by omega
                simp only [hiL, if_false]
                exact hk i rs' kid h
              · by_cases hiL : i = L
                · subst hiL; rw [Kids.get?_snoc_self] at h; simp at h; obtain ⟨rfl, rfl⟩ := h
                  simp only [if_true]; exact hkid
                · rw [Kids.get?_snoc_gt _ _ _ (by omega)] at h; cases h
            · intro i tg h
              rcases Kids.tag?_snoc _ _ _ _ _ _ h with ⟨hi, h⟩ | ⟨rfl, rfl⟩
              · have hiL : i ≠ L := by omega
                simp only [hiL, if_false]
                exact htg i tg h
              · dsimp only; rw [if_pos rfl]; exact ⟨t1, ε0, ht.symm, hε0⟩
      · -- newch: 新しい鍵 (id, n) の空の項目を足し、送り端と受け端の組を返す（鍵が既にあれば panic — 到達しない）
        rename_i H S r cap t0
        have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o (n + 1) (.panic H') ks) tf :=
          fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
        split at hfm
        · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
          obtain ⟨rfl, rfl⟩ := hfm
          exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
        · rename_i hnone
          simp only [Option.some.injEq, Prod.mk.injEq] at hfm
          obtain ⟨rfl, rfl⟩ := hfm
          cases hm with
          | @eval Λ _ _ Ψ _ _ _ _ _ he hS hH =>
            generalize hD : Ψ.length = D at he hS
            cases he with
            | newch hbr hrd hcap hmf hcf hrbd =>
              have hfresh : Ξ.ep.lookup (id, n) = none := by
                cases h : Ξ.ep.lookup (id, n) with
                | none => rfl
                | some t' => obtain ⟨e', he'⟩ := hC.epdom _ t' h; rw [hnone] at he'; cases he'
              have hle := chanLE_addEp (t := t0.relocR 0) hfresh
              refine ⟨_, hle, fun h => by simp [State.isFam] at h, ?_,
                chanOk_epNew _ hC hnone (Ty.relocR_relocR_mf hmf hcf) (Ty.relocR_mutFree_of hmf) (Ty.relocR_chanFree_of hmf hcf) rfl rfl⟩
              exact famTy_rebase hle rfl rfl
                (.ret' hD (.pair (.epV _ _ _ _) (.epV _ _ _ _)) (.pair (.epTx hbr hrd lookup_cons_self) (.epRx hbr hrd lookup_cons_self))
                  (hS.chan_mono hle) (heapOk_chan_mono hle hH)) hlen hch hep hloc hex hkt hk htg
      · -- 送信: 持ち主で空きがあればキューの末尾へ（値は loc-free なので空の世界へ）・満杯は待つ（none）・持ち主違いは panic
        rename_i H p k r' S v
        have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
          fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | sendR _ hc _ => cases hc
          | sendRE _ hc hp hS' =>
            cases hc with
            | epTx h1 h2 h3 =>
              split at hfm
              · rename_i ent hent
                obtain ⟨hcan, hmf0, hcf0, hty, hq⟩ := hC.eptyped _ _ ent h3 hent
                obtain ⟨w', hpk', hw'⟩ := pack_ok_opt hH hv (by rw [hD]; exact HasType.value_ctx hv he) hp
                rw [← hty] at hpk'
                split at hfm
                · split at hfm
                  · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                    obtain ⟨rfl, rfl⟩ := hfm
                    exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
                  split at hfm
                  · rw [hpk'] at hfm
                    simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                    obtain ⟨rfl, rfl⟩ := hfm
                    refine ⟨Ξ, .refl Ξ, fun _ => rfl,
                      famTy_rebase (.refl Ξ) rfl rfl (.ret' hD .triv .triv hS' hH) hlen hch hep hloc hex hkt hk htg,
                      chanOk_epSet hC hent rfl ?_⟩
                    intro t' ht' x hx
                    rw [h3] at ht'; cases ht'
                    simp only [List.mem_append, List.mem_singleton] at hx
                    rcases hx with hx | rfl
                    · exact hq x hx
                    · exact hw'
                  · cases hfm
                · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                  obtain ⟨rfl, rfl⟩ := hfm
                  exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
      · -- 受信: 持ち主でキューが空でなければ先頭を取り出す（空の世界の値を今の世界へ）・空は待つ・持ち主違いは panic
        rename_i H S p k r'
        have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
          fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | recvK _ => cases he
          | recvKE hmr hcr hS' =>
            cases he with
            | epRx h1 h2 h3 =>
              split at hfm
              · rename_i ent hent
                obtain ⟨hcan, hmf0, hcf0, hty, hq⟩ := hC.eptyped _ _ ent h3 hent
                split at hfm
                · split at hfm
                  · rename_i w q' hcons
                    have hw := hq w (by rw [hcons]; exact List.mem_cons_self ..)
                    obtain ⟨H'', Ψ', v'', hx', hv', hH', hl', ht', hS'', -⟩ :=
                      unpack_ok hH hD (by omega) hw (by simpa [Ty.mutFree] using hmf0) (by simpa [Ty.chanFree] using hcf0) hS'
                    rw [hx'] at hfm
                    simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                    obtain ⟨rfl, rfl⟩ := hfm
                    simp only [Ty.relocR] at ht'
                    rw [Ty.relocR_relocR_mf hmr hcr] at ht'
                    refine ⟨Ξ, .refl Ξ, fun _ => rfl,
                      famTy_rebase (.refl Ξ) rfl rfl (.ret' hl' hv' ht' hS'' hH') hlen hch hep hloc hex hkt hk htg,
                      chanOk_epSet hC hent rfl ?_⟩
                    intro t' ht' x hx
                    rw [h3] at ht'; cases ht'
                    exact hq x (by rw [hcons]; exact List.mem_cons_of_mem _ hx)
                  · rename_i hnil
                    split at hfm
                    · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                      obtain ⟨rfl, rfl⟩ := hfm
                      have hHl : H.length = D := by rw [hH.len, hD]
                      rw [hty, Ty.relocR_relocR_mf hmr hcr, hHl]
                      exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                        famTy_rebase (.refl Ξ) rfl rfl (.ret' hD (.nil _) .nil hS' hH) hlen hch hep hloc hex hkt hk htg, hC⟩
                    · cases hfm
                · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                  obtain ⟨rfl, rfl⟩ := hfm
                  exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
      · -- close: 持ち主で開いていれば閉じる（キューはそのまま）・それ以外は panic（P3b-4 ③）
        rename_i H S p k r'
        have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
          fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | closeKE hS' =>
            split at hfm
            · rename_i ent hent
              split at hfm
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                refine ⟨Ξ, .refl Ξ, fun _ => rfl,
                  famTy_rebase (.refl Ξ) rfl rfl (.ret' hD .triv .triv hS' hH) hlen hch hep hloc hex hkt hk htg,
                  chanOk_epSet hC hent rfl ?_⟩
                intro t' ht' x hx
                exact (hC.eptyped _ _ ent ht' hent).2.2.2.2 x hx
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
            · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
              obtain ⟨rfl, rfl⟩ := hfm
              exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
      · -- join: 子が完了なら結果を子のヒープから scope の region へ写した値（P3b-4）、死なら親も死ぬ、子が居なければ panic
        rename_i H0 t0 S0 rs0 i
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | @joinK _ _ _ rs t _ hS' =>
            obtain ⟨n', hvi, hbrs, hrsD, hti⟩ := canonical_task hv he
            simp only [Expr.taskV.injEq] at hvi
            obtain ⟨-, hi⟩ := hvi
            rw [← hi] at hti
            have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
              fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
            split at hfm
            · rename_i rs'' kid hget hoi
              have hoi' : o ≤ i := of_decide_eq_true hoi
              have hidx : o + (i - o) = i := by omega
              obtain ⟨t', ht'⟩ := hex (i - o) rs'' kid hget
              rw [hidx, hti] at ht'
              simp only [Option.some.injEq, Prod.mk.injEq] at ht'
              obtain ⟨rfl, rfl⟩ := ht'
              split at hfm
              · rename_i Hk v hres
                obtain ⟨hmfk, hcfk, hrk⟩ := hkt (i - o) rs kid t0 hget (by rw [hidx]; exact hti)
                obtain ⟨Ψk, hHk, hvv, hvt⟩ := taskRes_typed (hk (i - o) rs kid hget) hres
                obtain ⟨H', Ψ', v', hx, hv', hH', hl', ht'', hS''⟩ :=
                  xfer_join hH hD hbrs hrsD hHk hvv hvt hmfk hcfk hrk hS'
                rw [hx] at hfm
                simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                  famTy_rebase_mark (.refl Ξ) rfl rfl (.ret' hl' hv' ht'' hS'' hH') hlen hch hep hloc hex hkt hk htg (i - o), hC⟩
              · split at hfm
                · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                  obtain ⟨rfl, rfl⟩ := hfm
                  exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
                · cases hfm
            · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
              obtain ⟨rfl, rfl⟩ := hfm
              exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
      · -- try: 子が完了なら some（写した値）、死なら nil、子が居なければ panic
        rename_i H0 t0 S0 rs0 i
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | @tryK _ _ _ rs _ _ hS' =>
            obtain ⟨n', hvi, hbrs, hrsD, hti⟩ := canonical_task hv he
            simp only [Expr.taskV.injEq] at hvi
            obtain ⟨-, hi⟩ := hvi
            rw [← hi] at hti
            have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
              fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
            split at hfm
            · rename_i rs'' kid hget hoi
              have hoi' : o ≤ i := of_decide_eq_true hoi
              have hidx : o + (i - o) = i := by omega
              obtain ⟨t', ht'⟩ := hex (i - o) rs'' kid hget
              rw [hidx, hti] at ht'
              simp only [Option.some.injEq, Prod.mk.injEq] at ht'
              obtain ⟨rfl, rfl⟩ := ht'
              split at hfm
              · rename_i Hk v hres
                obtain ⟨hmfk, hcfk, hrk⟩ := hkt (i - o) rs kid t0 hget (by rw [hidx]; exact hti)
                obtain ⟨Ψk, hHk, hvv, hvt⟩ := taskRes_typed (hk (i - o) rs kid hget) hres
                obtain ⟨H', Ψ', v', hx, hv', hH', hl', ht'', hS''⟩ :=
                  xfer_join (tS := .opt t0) (S := S0) hH hD hbrs hrsD hHk hvv hvt hmfk hcfk hrk hS'
                rw [hx] at hfm
                simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                  famTy_rebase_mark (.refl Ξ) rfl rfl (.ret' hl' (.some hv') (.some ht'') hS'' hH') hlen hch hep hloc hex hkt hk htg (i - o), hC⟩
              · split at hfm
                · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                  obtain ⟨rfl, rfl⟩ := hfm
                  exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                    famTy_rebase (.refl Ξ) rfl rfl (.ret' hD (.nil _) .nil hS' hH) hlen hch hep hloc hex hkt hk htg, hC⟩
                · cases hfm
            · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
              obtain ⟨rfl, rfl⟩ := hfm
              exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
      · -- scope の出口: 子が全部 完了 / 死 なら、死があれば親が死に、未回収の失敗があれば err を写し、無ければ blockR と同じ写し
        rename_i H0 t0 ε S0 v0
        cases hm with
        | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
          generalize hD : Ψ.length = D at he hS
          cases hS with
          | @scopeK _ _ d1 _ _ _ _ hr hb hem hec hbd hS' =>
            have hpanic : ∀ H', StateTy Δ Ξ b (.fam id o n (.panic H') ks) tf :=
              fun H' => famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg
            split at hfm
            · split at hfm
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                obtain ⟨rfl, rfl⟩ := hfm
                obtain ⟨hH2, hl2, hS2, -⟩ := dead_exit hH hD hS'
                rw [show H0.length - 2 = Ψ.dropLast.length - 1 by rw [hl2, hH.len, hD]; omega, hl2]
                exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                  famTy_rebase (.refl Ξ) rfl rfl (.ret' hl2 (.inr _ (.inl _ .triv)) (.inr (.inl .triv)) hS2 hH2) hlen hch hep hloc hex hkt hk htg, hC⟩
              · split at hfm
                · -- 未回収の失敗: err を子のヒープから親の最内へ写して pop（札の型が注釈と食い違えば panic — 型付きなら起きないが、panic も型付き）
                  rename_i εk Hk e0 hfa
                  split at hfm
                  · rename_i hεk
                    obtain ⟨i0, Ψk, ε0, hHk, hve, hvt, hε0, hm0, hc0⟩ := failAt_typed hex hkt hk htg hfa
                    have hW : ε0.relocR (d1 - 1) = ε.relocR (H0.length - 2) := by
                      rw [← Ty.relocR_relocR_mf (a := 0) hm0 hc0, hε0, hεk, Ty.relocR_relocR_mf hem hec]
                      rw [hH.len, hD]; rfl
                    obtain ⟨H'', Ψ', e', hx, hv', hH'', hl', ht', hS'', -⟩ :=
                      fail_exit hH hD hbd hHk hve hvt hm0 hc0 hW hS'
                    rw [hx] at hfm
                    simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                    obtain ⟨rfl, rfl⟩ := hfm
                    rw [show H0.length - 2 = Ψ'.dropLast.length - 1 by rw [hl', hH.len, hD]; omega, hl'] at ht'
                    exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                      famTy_rebase (.refl Ξ) rfl rfl (.ret' hl' (.inr _ (.inr _ hv')) (.inr (.inr ht')) hS'' hH'') hlen hch hep hloc hex hkt hk htg, hC⟩
                  · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                    obtain ⟨rfl, rfl⟩ := hfm
                    exact ⟨Ξ, .refl Ξ, fun _ => rfl, hpanic _, hC⟩
                · obtain ⟨H'', Ψ', v'', hrl, hv', hH'', hl', ht', hS'', -⟩ := reloc_exit hH hD hv he hr hb hS'
                  rw [hrl] at hfm
                  simp only [Option.some.injEq, Prod.mk.injEq] at hfm
                  obtain ⟨rfl, rfl⟩ := hfm
                  rw [show H0.length - 2 = Ψ'.dropLast.length - 1 by rw [hl', hH.len, hD]; omega, hl']
                  exact ⟨Ξ, .refl Ξ, fun _ => rfl,
                    famTy_rebase (.refl Ξ) rfl rfl (.ret' hl' (.inl _ hv') (.inl ht') hS'' hH'') hlen hch hep hloc hex hkt hk htg, hC⟩
            · cases hfm
      -- 旧 par / parch / newchan / 旧 chan の送受（task の中では panic）
      iterate 5
        · simp only [Option.some.injEq, Prod.mk.injEq] at hfm
          obtain ⟨rfl, rfl⟩ := hfm
          exact ⟨Ξ, .refl Ξ, fun _ => rfl, famTy_rebase (.refl Ξ) rfl rfl .panic hlen hch hep hloc hex hkt hk htg, hC⟩
      · -- それ以外: main 自身の 1 歩（葉の歩 — 子の表は変わらず、main は葉のまま）
        obtain ⟨⟨m', K₁⟩, hstep, heq⟩ := Option.map_eq_some_iff.mp hfm
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        obtain ⟨Ξm, hlem, htkm, htym, hCm⟩ := ihm hC hstep
        have htk := htkm hmf
        exact ⟨Ξm, hlem, fun _ => htk,
          famTy_rebase hlem htk (step_isFam hmf hstep) htym hlen hch hep hloc hex hkt hk htg, hCm⟩
    cases π with
    | cons c π' =>
      cases c with
      | false =>
        -- 子のどれかの 1 歩: その子の世界の伸びを task の世界の共有の部分へ写す
        cases hsk : stepKids Δ π' ks K with
        | none => simp [hsk] at hs
        | some p =>
          obtain ⟨ks', K₁⟩ := p
          simp [hsk] at hs
          obtain ⟨rfl, rfl⟩ := hs
          obtain ⟨i, rs, kid, kid', π'', hget, hst, rfl⟩ := stepKids_some hsk
          obtain ⟨t, ht⟩ := hex i rs kid hget
          obtain ⟨Ξi', hlei, -, htyi, hCi'⟩ := ihk i rs kid hget (chanOk_world hC (hch i) (hep i)) hst
          let Ξ' : ChanTy := { Ξ with ch := Ξi'.ch, ep := Ξi'.ep }
          have hle : ChanLE Ξ Ξ' :=
            ⟨fun c p h => hlei.ch c p (by rw [hch i]; exact h), fun k t h => hlei.ep k t (by rw [hep i]; exact h),
              fun _ _ h => h⟩
          refine ⟨Ξ', hle, fun h => by simp [State.isFam] at h, ?_, chanOk_world hCi' rfl rfl⟩
          refine .fam (fun j => if j = i then Ξi' else { Ξs j with ch := Ξi'.ch, ep := Ξi'.ep }) bs tcs hmf
            (hm.chan_mono hle rfl) (by rw [Kids.length_set]; exact hlen) ?_ ?_ hloc ?_ ?_ ?_ ?_
          · intro j; by_cases hj : j = i <;> simp [hj, Ξ']
          · intro j; by_cases hj : j = i <;> simp [hj, Ξ']
          · intro j rs' kid'' hg
            by_cases hj : j = i
            · subst hj; rw [Kids.get?_set_self _ hget] at hg; simp at hg; obtain ⟨rfl, -⟩ := hg; exact ⟨t, ht⟩
            · rw [Kids.get?_set_ne _ hj] at hg; exact hex j rs' kid'' hg
          · intro j rs' kid'' t' hg ht'
            by_cases hj : j = i
            · subst hj; rw [Kids.get?_set_self _ hget] at hg; simp at hg; obtain ⟨rfl, rfl⟩ := hg
              exact hkt j rs kid t' hget ht'
            · rw [Kids.get?_set_ne _ hj] at hg
              exact hkt j rs' kid'' t' hg ht'
          · intro j rs' kid'' hg
            by_cases hj : j = i
            · subst hj; rw [Kids.get?_set_self _ hget] at hg; simp at hg; obtain ⟨rfl, rfl⟩ := hg
              simp only [if_true]; exact htyi
            · rw [Kids.get?_set_ne _ hj] at hg
              simp only [hj, if_false]
              have hle' : ChanLE (Ξs j) { Ξs j with ch := Ξi'.ch, ep := Ξi'.ep } :=
                ⟨fun c p h => hlei.ch c p (by rw [hch i, ← hch j]; exact h),
                  fun k t'' h => hlei.ep k t'' (by rw [hep i, ← hep j]; exact h), fun _ _ h => h⟩
              exact (hk j rs' kid'' hg).chan_mono hle' rfl
          · intro j tg h; rw [Kids.tag?_set] at h; exact htg j tg h
      | true => exact hmain π' hs
    | nil => exact hmain [] hs

/-! ## progress -/

/-- タスクの最終形はヒープが空とは限らない（共有プレフィクスのコピーを持つ）ので、
「空スタックまで値が戻った」を最終とする（トップレベルの H = [] は soundness で回収）。
段 3c で四択に: 値・panic・recv 待ち（Blocked）・次の 1 歩。
デッドロック（Blocked のまま動かない par）は型では塞がない -/
theorem progress {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {K : ChanSt}
    (h : StateTy Δ Ξ b s tf) (hC : ChanOk Δ Ξ K) (hf : s.isFam = false) :
    (∃ H v, (s = .ret H [] v ∨ s = .ret H [.taskK] v) ∧ Value v) ∨ (∃ H, s = .panic H) ∨ Blocked K s ∨
      ∃ π s' K', step Δ π s K = some (s', K') := by
  revert hf hC
  induction h with
  | eval he hS hH =>
    intro hC hf0
    rename_i Λ b Ψ H S e t tf
    generalize hD : Ψ.length = D at he
    cases e
    case var i =>
      cases he with
      | var h => simp at h
    case mkslice m t₀ =>
      cases he with
      | mkslice hbt hbd hmf =>
        rename_i d'
        have hHlen : H.length = d' + 1 := by rw [hH.len, hD]
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
          ⟨_, List.getElem?_eq_getElem (by omega)⟩
        exact .inr (.inr (.inr ⟨[], .ret H S (.slicev m (H.length - 1) ρ.length 0), K,
          by simp only [step, hρ]⟩))
    case mkmap m t₀ =>
      cases he with
      | mkmap hko hbt hbd hmf =>
        rename_i d' _ _
        have hHlen : H.length = d' + 1 := by rw [hH.len, hD]
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
          ⟨_, List.getElem?_eq_getElem (by omega)⟩
        exact .inr (.inr (.inr ⟨[], .ret H S (.mapv m (H.length - 1) ρ.length 0), K,
          by simp only [step, hρ]⟩))
    case strlit bs r =>
      cases he with
      | strlit hbr hrd =>
        have hr : r < H.length := by rw [hH.len, hD]; exact hrd
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hr⟩
        exact .inr (.inr (.inr ⟨[], .eval H S (.freeze (Expr.strCells bs (.slicev true r ρ.length 0))), K,
          by simp only [step, hρ]⟩))
    case mksliceAt m t₀ r =>
      cases he with
      | mksliceAt hrb hbr hrd hmf hcf =>
        have hr : r < H.length := by rw [hH.len, hD]; exact hrd
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hr⟩
        exact .inr (.inr (.inr ⟨[], .ret H S (.slicev m r ρ.length 0), K, by simp only [step, hρ]⟩))
    case mkmapAt m t₀ r =>
      cases he with
      | mkmapAt hko hrb hbr hrd hmf hcf =>
        have hr : r < H.length := by rw [hH.len, hD]; exact hrd
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hr⟩
        exact .inr (.inr (.inr ⟨[], .ret H S (.mapv m r ρ.length 0), K, by simp only [step, hρ]⟩))
    all_goals exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
  | ret hv he hS hH =>
    intro hC hf0
    rename_i Λ b Ψ H S v t tf
    generalize hD : Ψ.length = D at he hS
    cases hS with
    | nil => exact .inl ⟨H, v, .inl rfl, hv⟩
    | taskK _ => exact .inl ⟨H, v, .inr rfl, hv⟩
    | scopeK hr hb _ _ _ hS' =>
      obtain ⟨H'', Ψ', v', hrl, -⟩ := reloc_exit hH hD hv he hr hb hS'
      exact .inr (.inr (.inr ⟨[], _, _, by simp only [step, hrl]; rfl⟩))
    | spawnK _ _ _ _ _ _ => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | spawnA hsv hsvt _ _ _ _ _ =>
      obtain ⟨rfl, -⟩ := canonical_scope hsv (hsvt.of_take_full hD)
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | joinK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | tryK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | letK hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | addL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | addR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | ltL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | ltR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | arithL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | arithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      cases hop : ArithOp.eval ‹ArithOp› n m with
      | none => exact .inr (.inr (.inr ⟨[], .panic H, K, by simp only [step, hop]⟩))
      | some k => exact .inr (.inr (.inr ⟨[], .ret H ‹Stack› (.lit k), K, by simp only [step, hop]⟩))
    | cmpL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | cmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | pairL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | pairR hva hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | fstK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | annK hsub hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | sndK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | freezeKs hmf hS' =>
      rename_i S' r t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ := canonical_slice hv he
      right; right; right
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      exact ⟨[], .ret (H.set r (freezeRange base len ρ)) S' (.slicev false r base len), K,
        by simp only [step, hρ]⟩
    | idxL h1 hrd hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | idxR hvs hsv hrd hS' =>
      rename_i S' ot sv m r t' t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨n, rfl⟩ := canonical_int hv he
      right; right; right
      by_cases hin : 0 ≤ n ∧ n.toNat < len
      · obtain ⟨σ, mk, _, hσ, hcell, -⟩ := hk n.toNat hin.2
        have hrH : r < H.length := by rw [hH.len]; omega
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
        have haρ : base + n.toNat < ρ.length := by
          rw [hH.storeLen r ρ σ hρ hσ]; exact (List.getElem?_eq_some_iff.mp hcell).1
        obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[base + n.toNat]? = some c :=
          ⟨_, List.getElem?_eq_getElem haρ⟩
        exact ⟨[], .ret H S' (Expr.coerceOpt ot w), K, by simp only [step, if_pos hin, hρ, hw]⟩
      · exact ⟨[], .panic H, K, by simp only [step, if_neg hin]⟩
    | lenK hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, -, -, -⟩ := canonical_slice hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | @tobyteK _ S' _ _ hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hv he
      by_cases hr : 0 ≤ n ∧ n < 256
      · exact .inr (.inr (.inr ⟨[], .ret H S' (.blit n), K, by simp only [step, if_pos hr]⟩))
      · exact .inr (.inr (.inr ⟨[], .panic H, K, by simp only [step, if_neg hr]⟩))
    | tointK hS' =>
      obtain ⟨n, rfl, -, -⟩ := canonical_byte hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | farithL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | farithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | fcmpL hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | fcmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | @fconvK _ S' _ op _ hS' =>
      cases op
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        cases hop : F64.toInt n with
        | none => exact .inr (.inr (.inr ⟨[], .panic H, K, by simp only [step, hop]⟩))
        | some k => exact .inr (.inr (.inr ⟨[], .ret H S' (.lit k), K, by simp only [step, hop]⟩))
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | appL h1 hbm hbi hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | subL h1 h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | subM hvs hsv h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | eqsL h1 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | catL h1 hd hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | @subR _ S' _ sv av rx _ _ hvs hsv hav hat hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨na, rfl⟩ := canonical_int hav (hat.of_take_full hD)
      obtain ⟨nb, rfl⟩ := canonical_int hv he
      right; right; right
      by_cases hin : 0 ≤ na ∧ na ≤ nb ∧ nb.toNat ≤ len
      · exact ⟨[], .ret H S' (.slicev mt r (base + na.toNat) (nb.toNat - na.toNat)), K,
          by simp only [step, if_pos hin]⟩
      · exact ⟨[], .panic H, K, by simp only [step, if_neg hin]⟩
    | @eqsR _ S' _ sv r1x r2x _ hvs hsv hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, -, -, hrd1, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨mt2, r2, b2, l2, rfl, -, -, hrd2, -, -, -, -⟩ := canonical_slice hv he
      right; right; right
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      by_cases heq : l1 = l2 ∧ eqCells ρ1 ρ2 b1 b2 l1
      · exact ⟨[], .ret H S' .tt, K, by simp only [step, hρ1, hρ2, if_pos heq]⟩
      · exact ⟨[], .ret H S' .ff, K, by simp only [step, hρ1, hρ2, if_neg heq]⟩
    | @catR _ S' _ sv _ _ rrx tx _ hvs hsv hd hb hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, -, -, hrd1, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨mt2, r2, b2, l2, rfl, -, -, hrd2, -, -, -, -⟩ := canonical_slice hv he
      right; right; right
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
        ⟨_, List.getElem?_eq_getElem (by rw [hH.len]; omega)⟩
      exact ⟨[], .ret (H.set (H.length - 1)
          (ρi ++ (ρ1.drop b1).take l1 ++ (ρ2.drop b2).take l2)) S'
          (.slicev false (H.length - 1) ρi.length (l1 + l2)), K,
        by simp only [step, hρ1, hρ2, hρi]⟩
    | @appR _ S' _ sv m r rr t _ hvs hsv hbm hbi hS' =>
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      right; right; right
      have hrΨ : r < Ψ.length := by omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      cases mt with
      | true =>
        by_cases htip : base + len = ρ.length
        · exact ⟨[], .ret (H.set r (ρ ++ [(true, v)])) S' (.slicev true r base (len + 1)), K,
            by simp only [step, hρ, if_true, if_pos htip]⟩
        · exact ⟨[], .ret (H.set r (ρ ++ (ρ.drop base).take len ++ [(true, v)])) S'
            (.slicev true r ρ.length (len + 1)), K,
            by simp only [step, hρ, if_true, if_neg htip]⟩
      | false =>
        obtain ⟨ρi, hρi⟩ : ∃ ρi, H[H.length - 1]? = some ρi :=
          ⟨_, List.getElem?_eq_getElem (by omega)⟩
        exact ⟨[], .ret (H.set (H.length - 1)
          (ρi ++ (ρ.drop base).take len ++ [(false, v)])) S'
          (.slicev false (H.length - 1) ρi.length (len + 1)), K,
          by simp only [step, hρ, hρi, Bool.false_eq_true, if_false]⟩
    | sixL h1 h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | sixM hvs hsv h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | sixR hvs hsv hvi hi hS' =>
      rename_i S' sv iv r
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨n, rfl⟩ := canonical_int hvi (hi.of_take_full hD)
      right; right; right
      by_cases hin : 0 ≤ n ∧ n.toNat < len
      · obtain ⟨σ, mk, _, hσ, hcell, -⟩ := hk n.toNat hin.2
        have hrH : r < H.length := by rw [hH.len]; omega
        obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
        have haρ : base + n.toNat < ρ.length := by
          rw [hH.storeLen r ρ σ hρ hσ]; exact (List.getElem?_eq_some_iff.mp hcell).1
        obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[base + n.toNat]? = some c :=
          ⟨_, List.getElem?_eq_getElem haρ⟩
        cases mw with
        | true => exact ⟨[], .ret (H.set r (ρ.set (base + n.toNat) (true, v))) S' .triv, K,
            by simp only [step, if_pos hin, hρ, hw]⟩
        | false => exact ⟨[], .panic H, K, by simp only [step, if_pos hin, hρ, hw]⟩
      · exact ⟨[], .panic H, K, by simp only [step, if_neg hin]⟩
    | freezeKm hmf hS' =>
      rename_i S' r t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ := canonical_map hv he
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      exact ⟨[], .ret (H.set r (freezeRange base len ρ)) S' (.mapv false r base len), K,
        by simp only [step, hρ]⟩
    | gtmL h1 hsub hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | gtmR hvs hsv hsub hS' =>
      rename_i S' sv m r kt t' t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      cases hfk : findKey H ρ base v len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        exact ⟨[], .ret H S' (Expr.coerceTo (.opt t) w), K, by simp only [step, hρ, hfk, hcellρ]⟩
      | none => exact ⟨[], .ret H S' (.nil t), K, by simp only [step, hρ, hfk]⟩
    | stmL h1 h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | stmM hvs hsv h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | stmR hvs hsv hkv hkt hS' =>
      rename_i S' sv kv r kt
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      cases hfk : findKey H ρ base kv len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        cases mj with
        | true =>
          exact ⟨[], .ret (H.set r (ρ.set (base + j) (true, .pair ke (.some v)))) S'
            (.mapv mt r base len), K, by simp only [step, hρ, hfk, hcellρ]⟩
        | false => exact ⟨[], .panic H, K, by simp only [step, hρ, hfk, hcellρ]⟩
      | none =>
        by_cases htip : base + len = ρ.length
        · exact ⟨[], .ret (H.set r (ρ ++ [(mt, .pair kv (.some v))])) S'
            (.mapv mt r base (len + 1)), K, by simp only [step, hρ, hfk, if_pos htip]⟩
        · exact ⟨[], .ret (H.set r (ρ ++ (ρ.drop base).take len ++
            [(mt, .pair kv (.some v))])) S' (.mapv mt r ρ.length (len + 1)), K,
            by simp only [step, hρ, hfk, if_neg htip]⟩
    | dlmL h1 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | dlmR hvs hsv hS' =>
      rename_i S' sv r kt t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, -, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      cases hfk : findKey H ρ base v len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        cases mj with
        | true =>
          exact ⟨[], .ret (H.set r (ρ.set (base + j) (true, .pair ke (.nil t)))) S'
            .triv, K, by simp only [step, hρ, hfk, hcellρ]⟩
        | false => exact ⟨[], .panic H, K, by simp only [step, hρ, hfk, hcellρ]⟩
      | none => exact ⟨[], .ret H S' .triv, K, by simp only [step, hρ, hfk]⟩
    | lenmK hS' =>
      rename_i S' m r t
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, -, -, -⟩ := canonical_map hv he
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      exact ⟨[], .ret H S' (.lit (countLive ρ base len)), K, by simp only [step, hρ]⟩
    | @keysmK _ S' _ _ _ _ _ _ _ hd hb hko hrb hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, -, -, -⟩ := canonical_map hv he
      right; right; right
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
        ⟨_, List.getElem?_eq_getElem (by rw [hH.len]; omega)⟩
      exact ⟨[], .ret (H.set (H.length - 1)
          (ρi ++ (liveKeys ρ base len).map (fun k => (false, k)))) S'
          (.slicev false (H.length - 1) ρi.length (liveKeys ρ base len).length), K,
        by simp only [step, hρ, hρi]⟩
    | callvL hb hsub hbd hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | callvR hva hb hsub hbd hS' =>
      obtain ⟨fn, ts, dfn, rfl, -, -, -, -, -⟩ := canonical_fn hva (hb.of_take_full hD)
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | @callK _ S' d fn ts dfn ta _ hfn hlen hargs hsub hbd hS' =>
      exact .inr (.inr (.inr ⟨[], .eval (H ++ [[]]) (.fretK ((dfn.inst ts).ret.relocR (H.length - 1)) :: S')
        (Expr.subst 0 (Expr.coerceTo ((dfn.inst ts).param.shiftR (H.length - 1)) v)
          ((dfn.inst ts).body.shiftTy (H.length - 1))), K, by simp only [step, hfn]⟩))
    | @callMK _ S' d fn ts dfn ta a _ hfn hlen hargs hanc hsub hbd had hS' =>
      exact .inr (.inr (.inr ⟨[], .eval (H ++ [[]])
        (.fretK ((dfn.inst ts).ret.relocA ((Expr.anchorV (dfn.inst ts).param v).getD (H.length - 1)) (H.length - 1)) :: S')
        (Expr.subst 0 (Expr.coerceTo ((dfn.inst ts).param.renR ((Expr.anchorV (dfn.inst ts).param v).getD (H.length - 1)) (H.length - 1)) v)
          ((dfn.inst ts).body.renTy ((Expr.anchorV (dfn.inst ts).param v).getD (H.length - 1)) (H.length - 1))), K,
        by simp only [step, hfn]⟩))
    | @fretK _ S' d t0 _ hro hbd hS' =>
      right; right; right
      obtain ⟨H', Ψ', v', hrel, -, -, -⟩ := relocRet_ok_top hbd hH hD hv (HasType.value_ctx hv he) hro
      exact ⟨[], .ret H'.dropLast S' v', K, by simp only [step, hrel]⟩
    | @fretKA _ S' d ρ0 t0 _ hro hbd had hS' =>
      right; right; right
      obtain ⟨H', Ψ', v', hrel, -, -, -⟩ := relocRet_ok had (by omega) hH hD hv (HasType.value_ctx hv he) hro
      exact ⟨[], .ret H'.dropLast S' v', K, by simp only [step, hrel]⟩
    | iteK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | someK hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | ifnilK h1 h2 hS' =>
      rcases canonical_opt hv he with rfl | ⟨w, rfl, hw⟩
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | inlK hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | inrK hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | caseK h1 h2 hS' =>
      rcases canonical_union hv he with ⟨w, rfl, hw⟩ | ⟨w, rfl, hw⟩
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | allocK hb hbd hmf hS' =>
      rename_i S' d m
      right; right; right
      have hHlen : H.length = d + 1 := by rw [hH.len, hD]
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
        ⟨_, List.getElem?_eq_getElem (by omega)⟩
      exact ⟨[], .ret (H.set (H.length - 1) (ρ ++ [(m, v)])) S'
        (.loc (H.length - 1) ρ.length), K, by simp only [step, hρ]⟩
    | derefK hS' =>
      rename_i S' m r t'
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, -, -⟩ := canonical_ref hv he
      right; right; right
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      exact ⟨[], .ret H S' w, K, by simp only [step, hρ, hw]⟩
    | assignL h1 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | assignR hvl hl hS' =>
      rename_i S' l r
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, -, -⟩ :=
        canonical_ref hvl (hl.of_take_full hD)
      right; right; right
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      -- タグで書き込みか panic に分かれるが、どちらでも 1 歩は踏める
      cases mw with
      | true => exact ⟨[], .ret (H.set r (ρ.set a (true, v))) S' .triv, K,
          by simp only [step, hρ, hw]⟩
      | false => exact ⟨[], .panic H, K, by simp only [step, hρ, hw]⟩
    | freezeK hmf hS' =>
      rename_i S' r t
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, -, -⟩ := canonical_ref hv he
      right; right; right
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      exact ⟨[], .ret (H.set r (ρ.set a (false, w))) S' (.loc r a), K,
        by simp only [step, hρ, hw]⟩
    | whileK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
      · exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | whileB h1 h2 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | regionK hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | regionKR hr hb hS' =>
      obtain ⟨H'', Ψ', v', hst, -⟩ := regionKR_step [] hH hD hv he hr hb hS'
      exact .inr (.inr (.inr ⟨[], _, _, hst⟩))
    | copyK hk hr hb _ hS' =>
      obtain ⟨H', Ψ', v', hst, -⟩ := copyK_step [] hH hD hv he hk hr hb hS'
      exact .inr (.inr (.inr ⟨[], _, _, hst⟩))
    | labelK hb hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | jumpK hn hrel hS' =>
      obtain ⟨S'', Λ', d', H'', Ψ', v', hst, -⟩ := jumpK_step [] hH hD hv he hn hrel hS'
      exact .inr (.inr (.inr ⟨[], _, _, hst⟩))
    | sendL h1 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | sendR hvc hc hS' =>
      rename_i S' c₀ rc
      obtain ⟨c, Ψc, rfl, hΞc, -, -, -⟩ := canonical_chan hvc (hc.of_take_full hD)
      right; right; right
      have hcK : c < K.leg.length := by rw [hC.len]; exact (List.getElem?_eq_some_iff.mp hΞc).1
      obtain ⟨q, hq⟩ : ∃ q, K.leg[c]? = some q := ⟨_, List.getElem?_eq_getElem hcK⟩
      exact ⟨[], .ret H S' .triv, K.setLeg c (q ++ [v]), by simp only [step, hq]⟩
    | recvK hS' =>
      rename_i S' rc t
      obtain ⟨c, Ψc, rfl, hΞc, -, -, -⟩ := canonical_chan hv he
      have hcK : c < K.leg.length := by rw [hC.len]; exact (List.getElem?_eq_some_iff.mp hΞc).1
      obtain ⟨q, hq⟩ : ∃ q, K.leg[c]? = some q := ⟨_, List.getElem?_eq_getElem hcK⟩
      cases q with
      | nil =>
        -- 空キュー: 待機（blocked）。デッドロックになり得るが panic でも故障でもない
        exact .inr (.inr (.inl (.recv hq)))
      | cons w q' =>
        exact .inr (.inr (.inr ⟨[], .ret H S' w, K.setLeg c q', by simp only [step, hq]⟩))
    | sendLE h1 hS' => exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | sendRE hvc hc hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hvc (hc.of_take_full hD)
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | recvKE hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_rx hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
    | closeKE hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hv he
      exact .inr (.inr (.inr ⟨[], _, _, rfl⟩))
  | par hs1 hs2 hf1 hf2 hS hH ih1 ih2 =>
    intro hC hf0
    rename_i Λ b Ψ H S s1 s2 t1 t2 tf
    rcases ih1 hC hf1 with ⟨H1, v1, hs1e, hv1⟩ | ⟨H1, rfl⟩ | hb1 | ⟨π1, s1', K1, h1⟩
    · -- 左タスク完了
      have hd1 : (taskDone s1).isSome = true := by rcases hs1e with rfl | rfl <;> rfl
      rcases ih2 hC hf2 with ⟨H2, v2, hs2e, hv2⟩ | ⟨H2, rfl⟩ | hb2 | ⟨π2, s2', K2, h2⟩
      · -- 両タスク完了 → join
        have hd2 : (taskDone s2).isSome = true := by rcases hs2e with rfl | rfl <;> rfl
        refine .inr (.inr (.inr ⟨[], .ret H S .triv, K, ?_⟩))
        simp [step_par_def, hd1, hd2]
      · -- 右タスクが panic → 伝播
        refine .inr (.inr (.inr ⟨[false], .panic H, K, ?_⟩))
        rw [step_par_def]
        simp [taskDone, State.isPanic, hd1]
      · -- 右タスクが待機 → 親も待機
        exact .inr (.inr (.inl (.parDB hd1 hb2)))
      · -- 右タスクが 1 歩
        refine .inr (.inr (.inr ⟨false :: π2, .par H S s1 s2', K2, ?_⟩))
        rw [step_par_def, if_neg (by simp [taskDone_none_of_step h2])]
        simp [notPanic_of_step h2, h2]
    · -- 左タスクが panic → 伝播
      refine .inr (.inr (.inr ⟨[true], .panic H, K, ?_⟩))
      rw [step_par_def]
      simp [taskDone, State.isPanic]
    · -- 左タスクが待機
      rcases ih2 hC hf2 with ⟨H2, v2, hs2e, hv2⟩ | ⟨H2, rfl⟩ | hb2 | ⟨π2, s2', K2, h2⟩
      · have hd2 : (taskDone s2).isSome = true := by rcases hs2e with rfl | rfl <;> rfl
        exact .inr (.inr (.inl (.parBD hb1 hd2)))
      · -- 右タスクが panic → 伝播
        refine .inr (.inr (.inr ⟨[false], .panic H, K, ?_⟩))
        rw [step_par_def]
        simp [taskDone, State.isPanic]
      · exact .inr (.inr (.inl (.parBB hb1 hb2)))
      · -- 右タスクが 1 歩
        refine .inr (.inr (.inr ⟨false :: π2, .par H S s1 s2', K2, ?_⟩))
        rw [step_par_def, if_neg (by simp [taskDone_none_of_step h2])]
        simp [notPanic_of_step h2, h2]
    · -- 左タスクが 1 歩
      refine .inr (.inr (.inr ⟨true :: π1, .par H S s1' s2, K1, ?_⟩))
      rw [step_par_def, if_neg (by simp [taskDone_none_of_step h1])]
      simp [notPanic_of_step h1, h1]
  | panic => intro _ _; exact .inr (.inl ⟨_, rfl⟩)
  | fam => intro _ hf0; simp [State.isFam] at hf0

/-! ## 型健全性 -/

/-- 閉じた well-typed な式の初期状態は well-typed（メイン世界: 床・共有境界 0、チャネル無し） -/
theorem load_typed {Δ : Defs} {e : Expr} {t : Ty} (he : HasType Δ ∅ [] 0 0 0 [] [] e t) :
    StateTy Δ ∅ 0 (load e) t :=
  .eval (Ψ := []) he .nil heapOk_empty

/-- preservation の多段版（任意のスケジュールで保存。Ξ は単調に伸びる） -/
theorem run_preserve {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {K : ChanSt}
    (hΔ : DefsOk Δ) (h : StateTy Δ Ξ b s tf) (hC : ChanOk Δ Ξ K) (πs : List (List Bool)) :
    ∃ Ξ', ChanLE Ξ Ξ' ∧ StateTy Δ Ξ' b (run Δ πs s K).1 tf ∧ ChanOk Δ Ξ' (run Δ πs s K).2 := by
  induction πs generalizing Ξ s K with
  | nil => exact ⟨Ξ, .refl Ξ, h, hC⟩
  | cons π πs ih =>
    simp only [run]
    split
    case h_1 s' K' heq =>
      obtain ⟨Ξ', hle, -, h', hC'⟩ := preservation hΔ h hC heq
      obtain ⟨Ξ'', hle', h'', hC''⟩ := ih h' hC'
      exact ⟨Ξ'', hle.trans hle', h'', hC''⟩
    case h_2 => exact ⟨Ξ, .refl Ξ, h, hC⟩

/-- 葉（task でない状態）から走らせても葉のまま（step_isFam の多段版） -/
theorem run_isFam {Δ : Defs} {s : State} {K : ChanSt} (hf : s.isFam = false) :
    ∀ (πs : List (List Bool)), (run Δ πs s K).1.isFam = false := by
  intro πs
  induction πs generalizing s K with
  | nil => exact hf
  | cons π πs ih =>
    simp only [run]
    split
    case h_1 s' K' heq => exact ih (step_isFam hf heq)
    case h_2 => exact hf

/-- メイン世界（b = 0）の最終形はヒープも空（StackTy の底が深さ 0 = Ψ が空） -/
theorem final_heap_empty {Δ : Defs} {Ξ : ChanTy} {H : Heap} {v : Expr} {tf : Ty}
    (h : StateTy Δ Ξ 0 (.ret H [] v) tf) : H = [] := by
  cases h with
  | ret hv he hS hH =>
    rename_i Ψ t
    generalize hD : Ψ.length = D at hS
    cases hS
    exact List.eq_nil_of_length_eq_zero (by rw [hH.len]; exact hD)

/-- 根（共有境界 0）は task の底で止まらない（taskK は子の task — 共有境界 ≥ 1 — の底だけ） -/
theorem not_taskK_root {Δ : Defs} {Ξ : ChanTy} {H : Heap} {v : Expr} {tf : Ty} :
    ¬ StateTy Δ Ξ 0 (.ret H [.taskK] v) tf := by
  intro h
  cases h with
  | ret hv he hS hH =>
    rename_i Ψ t
    generalize hD : Ψ.length = D at hS
    cases hS with
    | taskK h1 => omega

/-- 型健全性: well-typed な状態は、どのスケジュールで走らせても
「実行完了（空スタック・空ヒープで値）」「panic（実行時タグ検査の失敗）」
「recv 待ち（Blocked。デッドロック含む）」以外で止まらない。
定理 1（領域安全）はここに吸収されている — 解放済み region への deref で
止まる状態は型が付かないので到達しない -/
theorem soundness {Δ : Defs} {e : Expr} {t : Ty} (hΔ : DefsOk Δ)
    (he : HasType Δ ∅ [] 0 0 0 [] [] e t) (πs : List (List Bool)) :
    (∃ v, (run Δ πs (load e) ∅).1 = .ret [] [] v ∧ Value v) ∨
    (∃ H, (run Δ πs (load e) ∅).1 = .panic H) ∨
    Blocked (run Δ πs (load e) ∅).2 (run Δ πs (load e) ∅).1 ∨
    ∃ π s' K', step Δ π (run Δ πs (load e) ∅).1 (run Δ πs (load e) ∅).2 = some (s', K') := by
  obtain ⟨Ξ', hle, hty, hC⟩ := run_preserve hΔ (load_typed he) chanOk_empty πs
  rcases progress hty hC (run_isFam rfl πs) with ⟨H, v, hEq | hEq, hv⟩ | h | h | h
  · left
    have hH0 : H = [] := final_heap_empty (hEq ▸ hty)
    exact ⟨v, by rw [hEq, hH0], hv⟩
  · exact absurd (hEq ▸ hty) not_taskK_root
  · exact .inr (.inl h)
  · exact .inr (.inr (.inl h))
  · exact .inr (.inr (.inr h))

/-! ## 段 6 P1: task 込みの progress と型健全性 -/

/-- 子の列の progress（段 6 P1）: どれかの子が歩ける（そのときは子の列も歩ける）か、全員 完了 / panic の葉 / 待機。
子ごとの四択から構成的に作る（∃ の場合分けに古典論理を使わない） -/
theorem kids_progress {Δ : Defs} {K : ChanSt} : ∀ (ks : Kids),
    (∀ i rs kid, ks.get? i = some (rs, kid) →
      (∃ v, taskDone kid = some v) ∨ kid.isPanic = true ∨ Blocked K kid ∨ ∃ π s' K', step Δ π kid K = some (s', K')) →
    (∀ i rs kid, ks.get? i = some (rs, kid) → (taskDone kid).isSome = false → kid.isPanic = false → Blocked K kid) ∨
      ∃ π p, stepKids Δ π ks K = some p
  | .nil, _ => .inl (fun _ _ _ h => by simp [Kids.get?] at h)
  | .cons rs κ s r, hp => by
    rcases hp 0 rs s rfl with ⟨v, hv⟩ | hpn | hb | ⟨π, s', K', hst⟩
    all_goals first
      | (exact .inr ⟨true :: π, _, by simp [stepKids, hst]; rfl⟩)
      | skip
    all_goals
      rcases kids_progress r (fun i rs' kid h => hp (i + 1) rs' kid h) with hr | ⟨π', p, hsr⟩
      · refine .inl ?_
        intro i rs' kid h hnd hnp
        cases i with
        | zero =>
          simp only [Kids.get?, Option.some.injEq, Prod.mk.injEq] at h
          obtain ⟨rfl, rfl⟩ := h
          first | (simp [hv] at hnd) | (simp [hpn] at hnp) | exact hb
        | succ i => exact hr i rs' kid h hnd hnp
      · exact .inr ⟨false :: π', _, by simp [stepKids, hsr]; rfl⟩

/-- join / try の写しは型付きの task の中では必ず成功する（P3b-4 — progress の join / try の腕: 子の結果は子のヒープで子の結果型に型付く） -/
theorem join_xfer_some {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {S : Stack} {Λ : LCtx}
    {rs0 i rs' o : Nat} {t tS tf : Ty} {ks : Kids} {kid : State} {Hk : Heap} {v : Expr}
    {Ξs : Nat → ChanTy} {bs : Nat → Nat} {tcs : Nat → Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (he : HasType Δ Ξ Ψ b b Ψ.length [] Λ (.taskV rs0 i) (.own .task rs' t))
    (hS : StackTy Δ Ξ Ψ b S Λ Ψ.length tS tf)
    (hex : ∀ i rs kid, ks.get? i = some (rs, kid) → ∃ t, Ξ.tk[o + i]? = some (rs, t))
    (hkt : ∀ i rs kid t, ks.get? i = some (rs, kid) → Ξ.tk[o + i]? = some (rs, t) →
      (tcs i).mutFree = true ∧ (tcs i).chanFree = true ∧ (tcs i).relocR rs = t)
    (hk : ∀ i rs kid, ks.get? i = some (rs, kid) → StateTy Δ (Ξs i) (bs i) kid (tcs i))
    {rs'' : Nat} (hget : ks.get? (i - o) = some (rs'', kid)) (hoi : o ≤ i) (hres : taskRes kid = some (Hk, v)) :
    ∃ H' v', xfer rs'' t Hk H v = some (H', v') ∧ H'.take b = H.take b := by
  obtain ⟨n', hvi, hbrs, hrsD, hti⟩ := canonical_task (.taskV _ _) he
  simp only [Expr.taskV.injEq] at hvi
  obtain ⟨-, hi⟩ := hvi
  rw [← hi] at hti
  have hidx : o + (i - o) = i := by omega
  obtain ⟨t', ht'⟩ := hex (i - o) rs'' kid hget
  rw [hidx, hti] at ht'
  simp only [Option.some.injEq, Prod.mk.injEq] at ht'
  obtain ⟨rfl, rfl⟩ := ht'
  obtain ⟨hmfk, hcfk, hrk⟩ := hkt (i - o) rs' kid t hget (by rw [hidx]; exact hti)
  obtain ⟨Ψk, hHk, hvv, hvt⟩ := taskRes_typed (hk (i - o) rs' kid hget) hres
  subst hrk
  obtain ⟨H', Ψ', v', hx, -, ⟨-, -, -, -, htH, -, -⟩, -⟩ :=
    xfer_ok (Ξ := Ξ) (b := b) (k := rs') hbrs hHk hH (by omega) (Nat.le_refl _) hvv
      (by rw [List.take_length]; exact hvt) (Ty.relocR_regionsBelow_of hmfk hcfk) (Ty.sub_refl _) hmfk hcfk
  exact ⟨H', v', hx, htH⟩

/-- 葉の progress を task 込みの四択の形へ -/
theorem progressT_leaf {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {K : ChanSt}
    (h : StateTy Δ Ξ b s tf) (hC : ChanOk Δ Ξ K) (hf : s.isFam = false) :
    (∃ v, taskDone s = some v) ∨ s.isPanic = true ∨ Blocked K s ∨ ∃ π s' K', step Δ π s K = some (s', K') := by
  rcases progress h hC hf with ⟨H, v, rfl | rfl, -⟩ | ⟨H, rfl⟩ | hb | hst
  · exact .inl ⟨v, rfl⟩
  · exact .inl ⟨v, rfl⟩
  · exact .inr (.inl rfl)
  · exact .inr (.inr (.inl hb))
  · exact .inr (.inr (.inr hst))

/-- progress（task 込み）: 完了（自分の子も全部完了）・panic の葉・待機（recv 待ち・未完了の子の join / try・
子が未決着の scope の出口・子の残る完了 / 死 — 子も全員動けない）・次の 1 歩 の四択。
task が死んでも子孫は走り切る（打ち切らない）ので、死んだ task は「子が動けない」まで待機の形に入らない -/
theorem progressT {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {K : ChanSt}
    (h : StateTy Δ Ξ b s tf) (hC : ChanOk Δ Ξ K) :
    (∃ v, taskDone s = some v) ∨ s.isPanic = true ∨ Blocked K s ∨ ∃ π s' K', step Δ π s K = some (s', K') := by
  revert hC
  induction h with
  | eval he hS hH => intro hC; exact progressT_leaf (.eval he hS hH) hC rfl
  | ret hv he hS hH => intro hC; exact progressT_leaf (.ret hv he hS hH) hC rfl
  | par hs1 hs2 hf1 hf2 hS hH _ _ => intro hC; exact progressT_leaf (.par hs1 hs2 hf1 hf2 hS hH) hC rfl
  | panic => intro _; exact .inr (.inl rfl)
  | fam Ξs bs tcs hmf hm hlen hch hep hloc hex hkt hk htg ihm ihk =>
    rename_i Ξ b id o n m ks tf
    intro hC
    -- 子のどれかが歩けるなら task もその子で歩く。歩けなければ子は全員 完了 / panic の葉 / 待機
    rcases kids_progress (Δ := Δ) ks (fun i rs kid hget => by
        obtain ⟨t, ht⟩ := hex i rs kid hget
        exact ihk i rs kid hget (chanOk_world hC (hch i) (hep i))) with hstuck | ⟨π', ⟨ks', K'⟩, hsk⟩
    rotate_left
    · refine .inr (.inr (.inr ⟨false :: π', .fam id o n m ks', K', ?_⟩))
      rw [step_fam_def]
      simp [hsk]
    rcases progress hm hC hmf with ⟨H, v, hmv, -⟩ | ⟨H, rfl⟩ | hbm | ⟨π, m', K', hst⟩
    · -- main は完了: 子も全部完了なら task の完了、そうでなければ待機
      have hmd : (taskDone m).isSome = true := by rcases hmv with rfl | rfl <;> rfl
      by_cases hkd : kidsDone ks = true
      · obtain ⟨v', hv'⟩ := Option.isSome_iff_exists.mp hmd
        exact .inl ⟨v', by simp [taskDone, hkd, hv']⟩
      · exact .inr (.inr (.inl (.famD hmd (by simpa using hkd) hstuck)))
    · exact .inr (.inr (.inl (.famX hstuck)))
    · -- main の待ちが旧 chan の recv なら task の中では panic の 1 歩（横取り）・それ以外（旧 par の待ち）は待機
      have hbm2 := hbm
      cases hbm2 with
      | recv hq => exact .inr (.inr (.inr ⟨[true], _, _, by rw [step_fam_def]; rfl⟩))
      | parBB _ _ => exact .inr (.inr (.inl (.famM hbm (by intro _ _ _ h; cases h) hstuck)))
      | parBD _ _ => exact .inr (.inr (.inl (.famM hbm (by intro _ _ _ h; cases h) hstuck)))
      | parDB _ _ => exact .inr (.inr (.inl (.famM hbm (by intro _ _ _ h; cases h) hstuck)))
      | _ => simp [State.isFam] at hmf
    · -- main 自身は歩ける: famMain が子の表を見て歩くか、待つ（join / try / scope の出口）
      cases hfm : famMain id o n m ks K (step Δ π m K) with
      | some p =>
        obtain ⟨s', K''⟩ := p
        refine .inr (.inr (.inr ⟨true :: π, s', K'', ?_⟩))
        rw [step_fam_def]; exact hfm
      | none =>
        rw [hst] at hfm
        unfold famMain at hfm
        split at hfm
        · split at hfm <;> cases hfm
        · split at hfm <;> cases hfm
        · -- 送信: 満杯なら待つ（Blocked famSnd）・梱包は型付きなら失敗しない（P3b-4b）
          split at hfm
          · rename_i ent hent
            split at hfm
            · rename_i hown
              split at hfm
              · cases hfm
              rename_i hcl
              split at hfm
              · split at hfm
                · cases hfm
                · rename_i hpk
                  exfalso
                  cases hm with
                  | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                    generalize hD : Ψ.length = D at he hS
                    cases hS with
                    | sendR _ hc _ => cases hc
                    | sendRE _ hc hp hS' =>
                      cases hc with
                      | epTx h1 h2 h3 =>
                        obtain ⟨-, -, -, hty, -⟩ := hC.eptyped _ _ ent h3 hent
                        obtain ⟨w', hpk', -⟩ := pack_ok_opt hH hv (by rw [hD]; exact HasType.value_ctx hv he) hp
                        rw [← hty, hpk] at hpk'; cases hpk'
              · rename_i hfull
                exact .inr (.inr (.inl (.famSnd hent hown (by simpa using hcl) (Nat.le_of_not_lt hfull) hstuck)))
            · cases hfm
          · cases hfm
        · -- 受信: 空なら待つ（Blocked famRcv）・展開は型付きなら失敗しない（P3b-4b）
          split at hfm
          · rename_i ent hent
            split at hfm
            · rename_i hown
              split at hfm
              · rename_i w q' hcons
                split at hfm
                · cases hfm
                · rename_i hx
                  exfalso
                  cases hm with
                  | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                    generalize hD : Ψ.length = D at he hS
                    cases hS with
                    | recvK _ => cases he
                    | recvKE hmr hcr hS' =>
                      cases he with
                      | epRx h1 h2 h3 =>
                        obtain ⟨-, hmf0, hcf0, -, hq⟩ := hC.eptyped _ _ ent h3 hent
                        have hw := hq w (by rw [hcons]; exact List.mem_cons_self ..)
                        obtain ⟨H'', Ψ', v'', hx', -⟩ := unpack_ok hH hD (by omega) hw
                          (by simpa [Ty.mutFree] using hmf0) (by simpa [Ty.chanFree] using hcf0) hS'
                        rw [hx'] at hx; cases hx
              · rename_i hnil
                split at hfm
                · cases hfm
                rename_i hcl
                exact .inr (.inr (.inl (.famRcv hent hown hnil (by simpa using hcl) hstuck)))
            · cases hfm
          · cases hfm
        · -- close: 失敗の腕なし（none を返さない）
          split at hfm
          · split at hfm <;> cases hfm
          · cases hfm
        · rename_i H0 tj S0 rs0 i
          split at hfm
          · rename_i rs' kid hget hoi
            split at hfm
            · rename_i Hk v hres
              split at hfm
              · cases hfm
              · rename_i hx
                exfalso
                cases hm with
                | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                  generalize hD : Ψ.length = D at he hS
                  cases hS with
                  | joinK hS' =>
                    subst hD
                    obtain ⟨H', v', hx', -⟩ := join_xfer_some hH he hS' hex hkt hk hget (of_decide_eq_true hoi) hres
                    rw [hx'] at hx; cases hx
            · rename_i hres
              have hdone : taskDone kid = none := by rw [taskDone_eq_taskRes, hres]; rfl
              split at hfm
              · cases hfm
              · rename_i hdead
                exact .inr (.inr (.inl (.famJ (of_decide_eq_true hoi) hget (by simp [hdone]) (by simpa using hdead) hstuck)))
          · cases hfm
        · rename_i H0 tj S0 rs0 i
          split at hfm
          · rename_i rs' kid hget hoi
            split at hfm
            · rename_i Hk v hres
              split at hfm
              · cases hfm
              · rename_i hx
                exfalso
                cases hm with
                | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                  generalize hD : Ψ.length = D at he hS
                  cases hS with
                  | tryK hS' =>
                    subst hD
                    obtain ⟨H', v', hx', -⟩ := join_xfer_some hH he hS' hex hkt hk hget (of_decide_eq_true hoi) hres
                    rw [hx'] at hx; cases hx
            · rename_i hres
              have hdone : taskDone kid = none := by rw [taskDone_eq_taskRes, hres]; rfl
              split at hfm
              · cases hfm
              · rename_i hdead
                exact .inr (.inr (.inl (.famT (of_decide_eq_true hoi) hget (by simp [hdone]) (by simpa using hdead) hstuck)))
          · cases hfm
        · rename_i H0 t0 ε S0 v0
          split at hfm
          · split at hfm
            · cases hfm
            · split at hfm
              · rename_i εk Hk e0 hfa
                split at hfm
                · rename_i hεk
                  split at hfm
                  · cases hfm
                  · rename_i hx
                    exfalso
                    cases hm with
                    | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                      generalize hD : Ψ.length = D at he hS
                      cases hS with
                      | @scopeK _ _ d1 _ _ _ _ hr hb hem hec hbd hS' =>
                        obtain ⟨i0, Ψk, ε0, hHk, hve, hvt, hε0, hm0, hc0⟩ := failAt_typed hex hkt hk htg hfa
                        have hW : ε0.relocR (d1 - 1) = ε.relocR (H0.length - 2) := by
                          rw [← Ty.relocR_relocR_mf (a := 0) hm0 hc0, hε0, hεk, Ty.relocR_relocR_mf hem hec]
                          rw [hH.len, hD]; rfl
                        obtain ⟨H'', Ψ', e', hx', -⟩ := fail_exit hH hD hbd hHk hve hvt hm0 hc0 hW hS'
                        rw [hx'] at hx; cases hx
                · cases hfm
              · split at hfm
                · cases hfm
                · rename_i hrl
                  simp [step, hrl] at hst
          · rename_i hset
            exact .inr (.inr (.inl (.famS (by simpa using hset) hstuck)))
        iterate 5
          · cases hfm
        · cases hfm

/-- 根の task（loadT）の型付け -/
theorem loadT_typed {Δ : Defs} {e : Expr} {t : Ty} (he : HasType Δ ∅ [] 0 0 0 [] [] e t) :
    StateTy Δ ∅ 0 (loadT e) t :=
  .fam (fun _ => ∅) (fun _ => 0) (fun _ => .unit) rfl (load_typed he) rfl (fun _ => rfl) (fun _ => rfl)
    (fun _ _ _ h => by simp at h) (fun _ _ _ h => by simp [Kids.get?] at h) (fun _ _ _ _ h => by simp [Kids.get?] at h)
    (fun _ _ _ h => by simp [Kids.get?] at h) (fun _ _ h => by simp [Kids.tag?] at h)

/-- 型健全性（段 6 P1 — 並列の構成子込み）: 根の task から、どのスケジュールで走らせても
「完了（main も子も全部完了・値）」「panic の葉」「待機（Blocked — デッドロック・死んだ task の子孫の待ちを含む）」以外で止まらない -/
theorem soundnessT {Δ : Defs} {e : Expr} {t : Ty} (hΔ : DefsOk Δ)
    (he : HasType Δ ∅ [] 0 0 0 [] [] e t) (πs : List (List Bool)) :
    (∃ v, taskDone (run Δ πs (loadT e) ∅).1 = some v ∧ Value v) ∨
    (run Δ πs (loadT e) ∅).1.isPanic = true ∨
    Blocked (run Δ πs (loadT e) ∅).2 (run Δ πs (loadT e) ∅).1 ∨
    ∃ π s' K', step Δ π (run Δ πs (loadT e) ∅).1 (run Δ πs (loadT e) ∅).2 = some (s', K') := by
  obtain ⟨Ξ', hle, hty, hC⟩ := run_preserve hΔ (loadT_typed he) chanOk_empty πs
  rcases progressT hty hC with ⟨v, hv⟩ | h | h | h
  · exact .inl ⟨v, hv, (taskDone_value hty hv).1⟩
  · exact .inr (.inl h)
  · exact .inr (.inr (.inl h))
  · exact .inr (.inr (.inr h))

/-! ## 定理 2（データ競合自由）の核

段 3c はタスク間の共有が「immutable 参照の読み + チャネル」なので、競合の不在は 2 つ:

1. `par_step_commute` — **チャネルストア K を変えない**タスクの 1 歩は可換
   （どちらを先に進めても同じ状態）。K を変える歩 = チャネル操作は同期点で、
   その順序依存は意図された非決定性（DRF は決定性を意味しない）。
   K を変えずに成功する歩は K を読みもしない（recv の成功・send・newchan はすべて
   K を変える）ので、この形が「チャネルに触れない歩」の特徴づけそのもの
2. `step_shared_stable` — well-typed な世界の 1 歩は共有プレフィクス `H.take b` を
   変えない。書き込み（assign）は mut loc の型付けが `b ≤ r` を強制し、
   割り当て（alloc）は `b ≤ d` 規則が最内 region ≥ b を強制し、
   解放（pop）は StackTy の底が b なので region ≥ b しか落とさない。
   これが「spawn 時のヒープコピーは物理共有と観測的に一致する」の中身 -/

theorem par_step_commute {Δ : Defs} {H : Heap} {S : Stack} {s1 s2 s1' s2' : State} {π1 π2 : List Bool}
    {K : ChanSt}
    (h1 : step Δ π1 s1 K = some (s1', K)) (h2 : step Δ π2 s2 K = some (s2', K)) :
    (step Δ (true :: π1) (.par H S s1 s2) K).bind
        (fun p => step Δ (false :: π2) p.1 p.2) =
      some (.par H S s1' s2', K) ∧
    (step Δ (false :: π2) (.par H S s1 s2) K).bind
        (fun p => step Δ (true :: π1) p.1 p.2) =
      some (.par H S s1' s2', K) := by
  have hd1 := taskDone_none_of_step h1
  have hd2 := taskDone_none_of_step h2
  have hp1 := notPanic_of_step h1
  have hp2 := notPanic_of_step h2
  constructor
  · simp [step_par_def, hd1, hd2, hp1, hp2, h1, h2]
  · simp [step_par_def, hd1, hd2, hp1, hp2, h1, h2]

theorem step_shared_stable_leaf {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {π : List Bool}
    {K K' : ChanSt} {s' : State}
    (h : StateTy Δ Ξ b s tf) (hf : s.isFam = false) (hs : step Δ π s K = some (s', K')) :
    s'.heap.take b = s.heap.take b := by
  cases h with
  | eval he hS hH =>
    rename_i Ψ H S e t
    cases e with
    | var i => simp [step] at hs
    | block e =>
      simp only [step] at hs; cases hs
      have hb : b ≤ H.length := by
        rw [hH.len]
        exact hS.le_depth
      simp only [State.heap]
      exact take_append_left_of_le hb [[]]
    -- 段 6 P1: scope は block と同じく region を 1 段積む・spawn / join / try / 札 / handle はヒープに触れない
    | scope t₀ e =>
      simp only [step] at hs; cases hs
      have hb : b ≤ H.length := by
        rw [hH.len]
        exact hS.le_depth
      simp only [State.heap]
      exact take_append_left_of_le hb [[]]
    | spawn sc a e => simp only [step] at hs; cases hs; rfl
    | join h => simp only [step] at hs; cases hs; rfl
    | tryJ t₀ h => simp only [step] at hs; cases hs; rfl
    | scopeV rs => simp only [step] at hs; cases hs; rfl
    | taskV rs n => simp only [step] at hs; cases hs; rfl
    | newch r cap t₀ => simp only [step] at hs; cases hs; rfl
    | epV p k bx r => simp only [step] at hs; cases hs; rfl
    | blockR t₀ e =>
      simp only [step] at hs; cases hs
      have hb : b ≤ H.length := by
        rw [hH.len]
        exact hS.le_depth
      simp only [State.heap]
      exact take_append_left_of_le hb [[]]
    | copyTo k t₀ e => simp only [step] at hs; cases hs; rfl
    | par e1 e2 =>
      simp only [step] at hs; cases hs
      rfl
    | lit n => simp only [step] at hs; cases hs; rfl
    | blit n => simp only [step] at hs; cases hs; rfl
    | flit n => simp only [step] at hs; cases hs; rfl
    | tt => simp only [step] at hs; cases hs; rfl
    | ff => simp only [step] at hs; cases hs; rfl
    | triv => simp only [step] at hs; cases hs; rfl
    | nil t₀ => simp only [step] at hs; cases hs; rfl
    | loc r a => simp only [step] at hs; cases hs; rfl
    | chanV c => simp only [step] at hs; cases hs; rfl
    | letE e body => simp only [step] at hs; cases hs; rfl
    | add a c => simp only [step] at hs; cases hs; rfl
    | lt a c => simp only [step] at hs; cases hs; rfl
    | arith op a c => simp only [step] at hs; cases hs; rfl
    | farith op a c => simp only [step] at hs; cases hs; rfl
    | cmp op a c => simp only [step] at hs; cases hs; rfl
    | fcmp op a c => simp only [step] at hs; cases hs; rfl
    | pair a c => simp only [step] at hs; cases hs; rfl
    | fst e => simp only [step] at hs; cases hs; rfl
    | ann e t => simp only [step] at hs; cases hs; rfl
    | snd e => simp only [step] at hs; cases hs; rfl
    | ite c th el => simp only [step] at hs; cases hs; rfl
    | some e => simp only [step] at hs; cases hs; rfl
    | ifnil e n s => simp only [step] at hs; cases hs; rfl
    | inl r e => simp only [step] at hs; cases hs; rfl
    | inr l e => simp only [step] at hs; cases hs; rfl
    | case e bl br => simp only [step] at hs; cases hs; rfl
    | alloc m e => simp only [step] at hs; cases hs; rfl
    | deref e => simp only [step] at hs; cases hs; rfl
    | assign l e => simp only [step] at hs; cases hs; rfl
    | whileE c body => simp only [step] at hs; cases hs; rfl
    | label t₀ e => simp only [step] at hs; cases hs; rfl
    | unreach t₀ => simp only [step] at hs; cases hs; rfl
    | jump n t₀ e => simp only [step] at hs; cases hs; rfl
    | freeze e => simp only [step] at hs; cases hs; rfl
    | newchan rc t₀ => simp only [step] at hs; cases hs; rfl
    | parch t₀ e1 e2 => simp only [step] at hs; cases hs; rfl
    | send c e => simp only [step] at hs; cases hs; rfl
    | recv c => simp only [step] at hs; cases hs; rfl
    | close c => simp only [step] at hs; cases hs; rfl
    | fnref fn ts => simp only [step] at hs; cases hs; rfl
    | callv ef e => simp only [step] at hs; cases hs; rfl
    | call fn ts e => simp only [step] at hs; cases hs; rfl
    | callM fn ts e => simp only [step] at hs; cases hs; rfl
    | mkslice m t₀ =>
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ => cases hs; rfl
    | strlit bs r =>
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ => cases hs; rfl
    | mksliceAt m t₀ r =>
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ => cases hs; rfl
    | mkmapAt m t₀ r =>
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ => cases hs; rfl
    | index e i ot => simp only [step] at hs; cases hs; rfl
    | lenE e => simp only [step] at hs; cases hs; rfl
    | tobyte e => simp only [step] at hs; cases hs; rfl
    | fconv op e => simp only [step] at hs; cases hs; rfl
    | toint e => simp only [step] at hs; cases hs; rfl
    | append e v => simp only [step] at hs; cases hs; rfl
    | setidx e i v => simp only [step] at hs; cases hs; rfl
    | subslice e sa sb => simp only [step] at hs; cases hs; rfl
    | eqs e1 e2 => simp only [step] at hs; cases hs; rfl
    | concat e1 e2 => simp only [step] at hs; cases hs; rfl
    | slicev mt r base len => simp only [step] at hs; cases hs; rfl
    | mkmap m t₀ =>
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ => cases hs; rfl
    | getm t₀ e k => simp only [step] at hs; cases hs; rfl
    | setm e k v => simp only [step] at hs; cases hs; rfl
    | delm t₀ e k => simp only [step] at hs; cases hs; rfl
    | lenm e => simp only [step] at hs; cases hs; rfl
    | keysm e => simp only [step] at hs; cases hs; rfl
    | mapv mt r base len => simp only [step] at hs; cases hs; rfl
  | ret hv he hS hH =>
    rename_i Ψ H S v t
    generalize hD : Ψ.length = D at he hS
    cases hS with
    | nil => simp [step] at hs
    | letK hb hS' => simp only [step] at hs; cases hs; rfl
    | addL hb hS' => simp only [step] at hs; cases hs; rfl
    | addR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs; rfl
    | ltL hb hS' => simp only [step] at hs; cases hs; rfl
    | ltR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs; rfl
    | arithL hb hS' => simp only [step] at hs; cases hs; rfl
    | arithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs <;> cases hs <;> rfl
    | cmpL hb hS' => simp only [step] at hs; cases hs; rfl
    | cmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_int hv he
      simp only [step] at hs; cases hs; rfl
    | pairL hb hS' => simp only [step] at hs; cases hs; rfl
    | pairR hva hb hS' => simp only [step] at hs; cases hs; rfl
    | fstK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      simp only [step] at hs; cases hs; rfl
    | annK hsub hS' => simp only [step] at hs; cases hs; rfl
    | sndK hS' =>
      obtain ⟨a, c, rfl, hva, hvc, hta, htc⟩ := canonical_prod hv he
      simp only [step] at hs; cases hs; rfl
    | iteK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · simp only [step] at hs; cases hs; rfl
      · simp only [step] at hs; cases hs; rfl
    | someK hS' => simp only [step] at hs; cases hs; rfl
    | ifnilK h1 h2 hS' =>
      rcases canonical_opt hv he with rfl | ⟨w, rfl, hw⟩
      · simp only [step] at hs; cases hs; rfl
      · simp only [step] at hs; cases hs; rfl
    | inlK hS' => simp only [step] at hs; cases hs; rfl
    | inrK hS' => simp only [step] at hs; cases hs; rfl
    | caseK h1 h2 hS' =>
      rcases canonical_union hv he with ⟨w, rfl, hw⟩ | ⟨w, rfl, hw⟩
      · simp only [step] at hs; cases hs; rfl
      · simp only [step] at hs; cases hs; rfl
    | allocK hb hbd hmf hS' =>
      rename_i S' d m
      simp only [step] at hs
      split at hs
      case h_2 => simp at hs
      case h_1 ρ hρ =>
        cases hs
        have hHlen : H.length = d + 1 := by rw [hH.len, hD]
        simp only [State.heap]
        exact take_set_of_le (by omega) _
    | derefK hS' =>
      rename_i S' m r t'
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, -, -⟩ := canonical_ref hv he
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      simp only [step, hρ, hw] at hs
      cases hs
      rfl
    | assignL h1 hS' => simp only [step] at hs; cases hs; rfl
    | assignR hvl hl hS' =>
      rename_i S' l r
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, hmb, -⟩ :=
        canonical_ref hvl (hl.of_take_full hD)
      have hbr : b ≤ r := (hmb rfl).2
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      cases mw with
      | true =>
        simp only [step, hρ, hw] at hs
        cases hs
        simp only [State.heap]
        exact take_set_of_le hbr _
      | false =>
        -- panic: ヒープは保持される
        simp only [step, hρ, hw] at hs
        cases hs
        rfl
    | freezeK hmf hS' =>
      rename_i S' r t
      obtain ⟨r, a, σ, m', rfl, hσ, hσa, hrd, -, hmb, -⟩ := canonical_ref hv he
      have hbr : b ≤ r := (hmb rfl).2
      have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
      have hrH : r < H.length := by rw [hH.len]; exact hrΨ
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
      have haρ : a < ρ.length := by rw [hH.storeLen r ρ σ hρ hσ]; exact haσ
      obtain ⟨⟨mw, w⟩, hw⟩ : ∃ c, ρ[a]? = some c := ⟨_, List.getElem?_eq_getElem haρ⟩
      simp only [step, hρ, hw] at hs
      cases hs
      simp only [State.heap]
      exact take_set_of_le hbr _
    | whileK h1 h2 hS' =>
      rcases canonical_bool hv he with rfl | rfl
      · simp only [step] at hs; cases hs; rfl
      · simp only [step] at hs; cases hs; rfl
    | whileB h1 h2 hS' => simp only [step] at hs; cases hs; rfl
    | labelK hb hS' => simp only [step] at hs; cases hs; rfl
    | jumpK hn hrel hS' =>
      obtain ⟨S'', Λ', d', H'', Ψ', v', hst, -, -, -, -, -, htH⟩ := jumpK_step π hH hD hv he hn hrel hS'
      rw [hst] at hs; cases hs
      simp only [State.heap]
      exact htH
    | taskK _ => simp [step] at hs
    | regionK hb hS' =>
      rename_i S' d
      simp only [step] at hs; cases hs
      have hbd : b ≤ d := hS'.le_depth
      have hHlen : H.length = d + 1 := by rw [hH.len, hD]
      simp only [State.heap]
      exact take_dropLast_eq H (by omega)
    | regionKR hr hb hS' =>
      obtain ⟨H'', Ψ', v', hst, -, -, -, -, -, htH⟩ := regionKR_step π hH hD hv he hr hb hS'
      rw [hst] at hs; cases hs
      simp only [State.heap]
      exact htH
    | copyK hk hr hb _ hS' =>
      obtain ⟨H', Ψ', v', hst, -, -, -, -, -, htH⟩ := copyK_step π hH hD hv he hk hr hb hS'
      rw [hst] at hs; cases hs
      simp only [State.heap]
      exact htH
    | scopeK hr hb _ _ _ hS' =>
      obtain ⟨H'', Ψ', v', hrl, -, -, -, -, -, htH⟩ := reloc_exit hH hD hv he hr hb hS'
      simp only [step, hrl] at hs; cases hs
      simp only [State.heap]
      exact htH
    | spawnK _ _ _ _ _ _ => simp only [step] at hs; cases hs; rfl
    | spawnA hsv hsvt _ _ _ _ _ =>
      obtain ⟨rfl, -⟩ := canonical_scope hsv (hsvt.of_take_full hD)
      simp only [step] at hs; cases hs; rfl
    | joinK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      simp only [step] at hs; cases hs; rfl
    | tryK _ =>
      obtain ⟨n, rfl, -⟩ := canonical_task hv he
      simp only [step] at hs; cases hs; rfl
    | sendL h1 hS' => simp only [step] at hs; cases hs; rfl
    | sendR hvc hc hS' =>
      obtain ⟨c, Ψc, rfl, hΞc, -, -, -⟩ := canonical_chan hvc (hc.of_take_full hD)
      cases hq : K.leg[c]? with
      | none => simp [step, hq] at hs
      | some q =>
        simp only [step, hq] at hs
        cases hs
        rfl
    | recvK hS' =>
      obtain ⟨c, Ψc, rfl, hΞc, -, -, -⟩ := canonical_chan hv he
      cases hq : K.leg[c]? with
      | none => simp [step, hq] at hs
      | some q =>
        cases q with
        | nil => simp [step, hq] at hs
        | cons w q' =>
          simp only [step, hq] at hs
          cases hs
          rfl
    | sendLE h1 hS' => simp only [step] at hs; cases hs; rfl
    | sendRE hvc hc hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hvc (hc.of_take_full hD)
      simp only [step] at hs; cases hs; rfl
    | recvKE hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_rx hv he
      simp only [step] at hs; cases hs; rfl
    | closeKE hS' =>
      obtain ⟨p, k, rfl, -⟩ := canonical_tx hv he
      simp only [step] at hs; cases hs; rfl
    | callvL hb hsub hbd hS' => simp only [step] at hs; cases hs; rfl
    | callvR hva hb hsub hbd hS' =>
      obtain ⟨fn, ts, dfn, rfl, -, -, -, -, -⟩ := canonical_fn hva (hb.of_take_full hD)
      simp only [step] at hs; cases hs; rfl
    | @callK _ S' d fn ts dfn ta _ hfn hlen hargs hsub hbd hS' =>
      simp only [step] at hs
      rw [hfn] at hs
      cases hs
      have hbH : b ≤ H.length := by rw [hH.len, hD]; omega
      simp only [State.heap]
      exact take_append_left_of_le hbH [[]]
    | @fretK _ S' d t0 _ hro hbd hS' =>
      obtain ⟨H', Ψ', v', hrel, -, ⟨hH', hlen', -, -, htkH⟩, -⟩ :=
        relocRet_ok_top hbd hH hD hv (HasType.value_ctx hv he) hro
      simp only [step, hrel] at hs
      cases hs
      simp only [State.heap]
      -- H'.dropLast.take b = H.take b（relocate は take d を変えず、b ≤ d）
      have hHl : H'.length = d + 2 := by rw [hH'.len, hlen']
      rw [take_dropLast_eq H' (by omega : b ≤ H'.length - 1)]
      have h1 : H'.take b = (H'.take d).take b := by
        rw [List.take_take, Nat.min_eq_left (by omega)]
      have h2 : H.take b = (H.take d).take b := by
        rw [List.take_take, Nat.min_eq_left (by omega)]
      rw [h1, h2, htkH]
    | @callMK _ S' d fn ts dfn ta a _ hfn hlen hargs hanc hsub hbd had hS' =>
      simp only [step] at hs
      rw [hfn] at hs
      cases hs
      have hbH : b ≤ H.length := by rw [hH.len, hD]; omega
      simp only [State.heap]
      exact take_append_left_of_le hbH [[]]
    | @fretKA _ S' d ρ0 t0 _ hro hbd had hS' =>
      obtain ⟨H', Ψ', v', hrel, -, ⟨hH', hlen', -, -, htkH⟩, -⟩ :=
        relocRet_ok had (by omega) hH hD hv (HasType.value_ctx hv he) hro
      simp only [step, hrel] at hs
      cases hs
      simp only [State.heap]
      -- H'.dropLast.take b = H.take b（relocate は take d を変えず、b ≤ d）
      have hHl : H'.length = d + 2 := by rw [hH'.len, hlen']
      rw [take_dropLast_eq H' (by omega : b ≤ H'.length - 1)]
      have h1 : H'.take b = (H'.take d).take b := by
        rw [List.take_take, Nat.min_eq_left (by omega)]
      have h2 : H.take b = (H.take d).take b := by
        rw [List.take_take, Nat.min_eq_left (by omega)]
      rw [h1, h2, htkH]
    | freezeKs hmf hS' =>
      rename_i S' r t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, hmb, -, -⟩ := canonical_slice hv he
      have hbr : b ≤ r := (hmb rfl).2
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hs
      simp only [State.heap]
      exact take_set_of_le hbr _
    | idxL h1 hS' => simp only [step] at hs; cases hs; rfl
    | idxR hvs hsv hS' =>
      rename_i S' sv m r t
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨n, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs
      · split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          split at hs <;> first
            | (obtain ⟨rfl, rfl⟩ := hs; rfl)
            | (cases hs; rfl)
            | simp at hs
      · first
          | (obtain ⟨rfl, rfl⟩ := hs; rfl)
          | (cases hs; rfl)
    | lenK hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, -, -, -⟩ := canonical_slice hv he
      simp only [step] at hs; cases hs; rfl
    | tobyteK hS' =>
      obtain ⟨n, rfl⟩ := canonical_int hv he
      by_cases hr : 0 ≤ n ∧ n < 256
      · simp only [step, if_pos hr] at hs; cases hs; rfl
      · simp only [step, if_neg hr] at hs; cases hs; rfl
    | tointK hS' =>
      obtain ⟨n, rfl, -, -⟩ := canonical_byte hv he
      simp only [step] at hs; cases hs; rfl
    | farithL hb hS' => simp only [step] at hs; cases hs; rfl
    | farithR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      simp only [step] at hs; cases hs; rfl
    | fcmpL hb hS' => simp only [step] at hs; cases hs; rfl
    | fcmpR hva hb hS' =>
      obtain ⟨n, rfl⟩ := canonical_f64 hva (hb.of_take_full hD)
      obtain ⟨m, rfl⟩ := canonical_f64 hv he
      simp only [step] at hs; cases hs; rfl
    | @fconvK _ S' _ op _ hS' =>
      cases op
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs; rfl
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs; rfl
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        simp only [step] at hs; cases hs; rfl
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs
        split at hs <;> cases hs <;> rfl
      · obtain ⟨n, rfl⟩ := canonical_f64 hv he
        simp only [step] at hs; cases hs; rfl
      · obtain ⟨n, rfl⟩ := canonical_int hv he
        simp only [step] at hs; cases hs; rfl
    | appL h1 hbm hbi hS' => simp only [step] at hs; cases hs; rfl
    | appR hvs hsv hbm hbi hS' =>
      obtain ⟨mt, r, base, len, rfl, hmt, -, hrd, -, hmb, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      subst hmt
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      cases mt with
      | true =>
        have hbr : b ≤ r := (hmb rfl).2
        simp only [step, hρ] at hs
        by_cases htip : base + len = ρ.length
        · simp only [if_pos htip] at hs
          cases hs
          simp only [State.heap]
          exact take_set_of_le hbr _
        · simp only [if_neg htip] at hs
          cases hs
          simp only [State.heap]
          exact take_set_of_le hbr _
      | false =>
        obtain ⟨hDrr, hbrr⟩ := hbi rfl
        have hbH : b ≤ H.length - 1 := by rw [hH.len, hD]; omega
        obtain ⟨ρi, hρi⟩ : ∃ ρi, H[H.length - 1]? = some ρi :=
          ⟨_, List.getElem?_eq_getElem (by omega)⟩
        simp only [step, hρ, Bool.false_eq_true, if_false, hρi] at hs
        cases hs
        simp only [State.heap]
        exact take_set_of_le hbH _
    | sixL h1 h2 hS' => simp only [step] at hs; cases hs; rfl
    | sixM hvs hsv h2 hS' => simp only [step] at hs; cases hs; rfl
    | subL h1 h2 hS' => simp only [step] at hs; cases hs; rfl
    | subM hvs hsv h2 hS' => simp only [step] at hs; cases hs; rfl
    | eqsL h1 hS' => simp only [step] at hs; cases hs; rfl
    | catL h1 hd hb hS' => simp only [step] at hs; cases hs; rfl
    | subR hvs hsv hav hat hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨na, rfl⟩ := canonical_int hav (hat.of_take_full hD)
      obtain ⟨nb, rfl⟩ := canonical_int hv he
      simp only [step] at hs
      split at hs <;> (cases hs; rfl)
    | eqsR hvs hsv hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, -, -, hrd1, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨mt2, r2, b2, l2, rfl, -, -, hrd2, -, -, -, -⟩ := canonical_slice hv he
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      simp only [step, hρ1, hρ2] at hs
      split at hs <;> (cases hs; rfl)
    | catR hvs hsv hd hb hS' =>
      obtain ⟨mt1, r1, b1, l1, rfl, -, -, hrd1, -, -, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨mt2, r2, b2, l2, rfl, -, -, hrd2, -, -, -, -⟩ := canonical_slice hv he
      have hbH : b ≤ H.length - 1 := by rw [hH.len, hD]; omega
      have hr1H : r1 < H.length := by rw [hH.len]; omega
      have hr2H : r2 < H.length := by rw [hH.len]; omega
      obtain ⟨ρ1, hρ1⟩ : ∃ ρ, H[r1]? = some ρ := ⟨_, List.getElem?_eq_getElem hr1H⟩
      obtain ⟨ρ2, hρ2⟩ : ∃ ρ, H[r2]? = some ρ := ⟨_, List.getElem?_eq_getElem hr2H⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
        ⟨_, List.getElem?_eq_getElem (by omega)⟩
      simp only [step, hρ1, hρ2, hρi] at hs
      cases hs
      simp only [State.heap]
      exact take_set_of_le hbH _
    | sixR hvs hsv hvi hi hS' =>
      rename_i S' sv iv r
      obtain ⟨mt, r, base, len, rfl, -, -, -, -, hmb, -, -⟩ :=
        canonical_slice hvs (hsv.of_take_full hD)
      obtain ⟨n, rfl⟩ := canonical_int hvi (hi.of_take_full hD)
      have hbr : b ≤ r := (hmb rfl).2
      simp only [step] at hs
      split at hs
      · split at hs
        case h_2 => simp at hs
        case h_1 ρ hρ =>
          split at hs <;> first
            | (obtain ⟨rfl, rfl⟩ := hs
               first
                 | rfl
                 | (simp only [State.heap]; exact take_set_of_le hbr _))
            | simp at hs
      · first
          | (obtain ⟨rfl, rfl⟩ := hs; rfl)
          | (cases hs; rfl)
    | freezeKm hmf hS' =>
      rename_i S' r t
      obtain ⟨mt, r, base, len, rfl, -, hk, hrd, -, hmb, -, -⟩ := canonical_map hv he
      have hbr : b ≤ r := (hmb rfl).2
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hs
      simp only [State.heap]
      exact take_set_of_le hbr _
    | gtmL h1 hS' => simp only [step] at hs; cases hs; rfl
    | gtmR hvs hsv hS' =>
      rename_i S' sv m r kt t
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, -, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base v len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        simp only [hfk, hcellρ] at hs
        cases hs
        rfl
      | none =>
        simp only [hfk] at hs
        cases hs
        rfl
    | stmL h1 h2 hS' => simp only [step] at hs; cases hs; rfl
    | stmM hvs hsv h2 hS' => simp only [step] at hs; cases hs; rfl
    | stmR hvs hsv hkv hkt hS' =>
      rename_i S' sv kv r kt
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, hmb, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      have hbr : b ≤ r := (hmb rfl).2
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base kv len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        cases mj with
        | true =>
          simp only [hfk, hcellρ] at hs
          cases hs
          simp only [State.heap]
          exact take_set_of_le hbr _
        | false =>
          simp only [hfk, hcellρ] at hs
          cases hs
          rfl
      | none =>
        simp only [hfk] at hs
        split at hs <;>
          (cases hs; simp only [State.heap]; exact take_set_of_le hbr _)
    | dlmL h1 hS' => simp only [step] at hs; cases hs; rfl
    | dlmR hvs hsv hS' =>
      rename_i S' sv r kt t
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, hmb, -, -⟩ :=
        canonical_map hvs (hsv.of_take_full hD)
      have hbr : b ≤ r := (hmb rfl).2
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hfk : findKey H ρ base v len with
      | some j =>
        obtain ⟨hjlen, mj, ke, w, hcellρ⟩ := findKey_some hfk
        cases mj with
        | true =>
          simp only [hfk, hcellρ] at hs
          cases hs
          simp only [State.heap]
          exact take_set_of_le hbr _
        | false =>
          simp only [hfk, hcellρ] at hs
          cases hs
          rfl
      | none =>
        simp only [hfk] at hs
        cases hs
        rfl
    | lenmK hS' =>
      rename_i S' m r t
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, -, -, -⟩ := canonical_map hv he
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      simp only [step, hρ] at hs
      cases hs
      rfl
    | keysmK hd hb hko hrb hS' =>
      obtain ⟨mt, r, base, len, rfl, -, -, hrd, -, -, -, -⟩ := canonical_map hv he
      have hbH : b ≤ H.length - 1 := by rw [hH.len, hD]; omega
      have hrH : r < H.length := by rw [hH.len]; omega
      obtain ⟨ρ, hρ⟩ : ∃ ρ, H[r]? = some ρ := ⟨_, List.getElem?_eq_getElem hrH⟩
      obtain ⟨ρi, hρi⟩ : ∃ ρ, H[H.length - 1]? = some ρ :=
        ⟨_, List.getElem?_eq_getElem (by omega)⟩
      simp only [step, hρ, hρi] at hs
      cases hs
      simp only [State.heap]
      exact take_set_of_le hbH _
  | par hs1 hs2 hf1 hf2 hS hH =>
    rename_i Ψ H S s1 s2 t1 t2
    rw [step_par_def] at hs
    by_cases hj : ((taskDone s1).isSome && (taskDone s2).isSome) = true
    · rw [if_pos hj] at hs
      cases hs
      rfl
    · rw [if_neg hj] at hs
      cases π with
      | nil => simp at hs
      | cons c π' =>
        cases c with
        | true =>
          by_cases hp : s1.isPanic = true
          · simp [hp] at hs
            obtain ⟨rfl, rfl⟩ := hs
            rfl
          · cases hstep : step Δ π' s1 K with
            | none => simp [hp, hstep] at hs
            | some p =>
              obtain ⟨s1', K₁⟩ := p
              simp [hp, hstep] at hs
              obtain ⟨rfl, rfl⟩ := hs
              rfl
        | false =>
          by_cases hp : s2.isPanic = true
          · simp [hp] at hs
            obtain ⟨rfl, rfl⟩ := hs
            rfl
          · cases hstep : step Δ π' s2 K with
            | none => simp [hp, hstep] at hs
            | some p =>
              obtain ⟨s2', K₂⟩ := p
              simp [hp, hstep] at hs
              obtain ⟨rfl, rfl⟩ := hs
              rfl
  | panic => simp [step] at hs
  | fam => simp [State.isFam] at hf

/-- 共有プレフィクスの不変（task 込み — 段 6 P1）: task の世界のヒープ = main のヒープ。子の歩は main に触れず、
main の spawn / join / try はヒープを変えず、scope の出口は blockR と同じ写し、それ以外は main 自身の歩 -/
theorem step_shared_stable {Δ : Defs} {Ξ : ChanTy} {b : Nat} {s : State} {tf : Ty} {π : List Bool}
    {K K' : ChanSt} {s' : State}
    (h : StateTy Δ Ξ b s tf) (hs : step Δ π s K = some (s', K')) :
    s'.heap.take b = s.heap.take b := by
  cases hf : s.isFam with
  | false => exact step_shared_stable_leaf h hf hs
  | true =>
    cases h with
    | fam Ξs bs tcs hmf hm hlen hch hep hloc hex hkt hk htg =>
      rename_i id o n m ks
      rw [step_fam_def] at hs
      have hmain : ∀ πt, famMain id o n m ks K (step Δ πt m K) = some (s', K') →
          s'.heap.take b = (State.fam id o n m ks).heap.take b := by
        intro πt hfm
        unfold famMain at hfm
        split at hfm
        -- spawn・newch・送信: main のヒープはそのまま（ret / panic の H）
        iterate 3
          · repeat' split at hfm
            all_goals first
              | (simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl)
              | (cases hfm; done)
        -- 受信: 梱包を最内の region へ写す（P3b-4b — 写しは最内の region より下に触れない・最内 ≥ b）
        · repeat' split at hfm
          all_goals first
            | (simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl)
            | (cases hfm; done)
            | skip
          simp only [Option.some.injEq, Prod.mk.injEq] at hfm
          obtain ⟨rfl, rfl⟩ := hfm
          have hx := ‹xfer _ _ _ _ _ = some _›
          cases hm with
          | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
            generalize hD : Ψ.length = D at he hS
            cases hS with
            | recvK _ => cases he
            | recvKE _ _ hS' =>
              cases he with
              | epRx h1 h2 h3 =>
                simp only [State.heap]
                exact take_of_xfer (by rw [hH.len]; omega) hx
        -- close: main のヒープはそのまま
        · repeat' split at hfm
          all_goals first
            | (simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl)
            | (cases hfm; done)
        · split at hfm
          · rename_i rs'' kid hget hoi
            split at hfm
            · rename_i Hk v hres
              split at hfm
              · rename_i H' v' hx
                simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm
                cases hm with
                | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                  generalize hD : Ψ.length = D at he hS
                  cases hS with
                  | joinK hS' =>
                    subst hD
                    obtain ⟨H'', v'', hx', htH⟩ := join_xfer_some hH he hS' hex hkt hk hget (of_decide_eq_true hoi) hres
                    rw [hx] at hx'; simp only [Option.some.injEq, Prod.mk.injEq] at hx'; obtain ⟨rfl, rfl⟩ := hx'
                    simp only [State.heap]; exact htH
              · cases hfm
            · split at hfm
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
              · cases hfm
          · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
        · split at hfm
          · rename_i rs'' kid hget hoi
            split at hfm
            · rename_i Hk v hres
              split at hfm
              · rename_i H' v' hx
                simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm
                cases hm with
                | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                  generalize hD : Ψ.length = D at he hS
                  cases hS with
                  | tryK hS' =>
                    subst hD
                    obtain ⟨H'', v'', hx', htH⟩ := join_xfer_some hH he hS' hex hkt hk hget (of_decide_eq_true hoi) hres
                    rw [hx] at hx'; simp only [Option.some.injEq, Prod.mk.injEq] at hx'; obtain ⟨rfl, rfl⟩ := hx'
                    simp only [State.heap]; exact htH
              · cases hfm
            · split at hfm
              · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
              · cases hfm
          · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
        · rename_i H0 t0 ε S0 v0
          split at hfm
          · split at hfm
            · cases hm with
              | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                generalize hD : Ψ.length = D at he hS
                cases hS with
                | scopeK hr hb _ _ _ hS' =>
                  obtain ⟨-, -, -, htH⟩ := dead_exit hH hD hS'
                  simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm
                  simp only [State.heap]; exact htH
            · split at hfm
              · rename_i εk Hk e0 hfa
                split at hfm
                · rename_i hεk
                  cases hm with
                  | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                    generalize hD : Ψ.length = D at he hS
                    cases hS with
                    | @scopeK _ _ d1 _ _ _ _ hr hb hem hec hbd hS' =>
                      obtain ⟨i0, Ψk, ε0, hHk, hve, hvt, hε0, hm0, hc0⟩ := failAt_typed hex hkt hk htg hfa
                      have hW : ε0.relocR (d1 - 1) = ε.relocR (H0.length - 2) := by
                        rw [← Ty.relocR_relocR_mf (a := 0) hm0 hc0, hε0, hεk, Ty.relocR_relocR_mf hem hec]
                        rw [hH.len, hD]; rfl
                      obtain ⟨H'', Ψ', e', hx', -, -, -, -, -, htH⟩ := fail_exit hH hD hbd hHk hve hvt hm0 hc0 hW hS'
                      rw [hx'] at hfm
                      simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm
                      simp only [State.heap]; exact htH
                · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
              · cases hm with
                | @ret Λ _ _ Ψ _ _ _ _ _ hv he hS hH =>
                  generalize hD : Ψ.length = D at he hS
                  cases hS with
                  | scopeK hr hb _ _ _ hS' =>
                    obtain ⟨H'', Ψ', v'', hrl, -, -, -, -, -, htH⟩ := reloc_exit hH hD hv he hr hb hS'
                    rw [hrl] at hfm
                    simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm
                    simp only [State.heap]; exact htH
          · cases hfm
        iterate 5
          · simp only [Option.some.injEq, Prod.mk.injEq] at hfm; obtain ⟨rfl, rfl⟩ := hfm; rfl
        · obtain ⟨⟨m', K₁⟩, hstep, heq⟩ := Option.map_eq_some_iff.mp hfm
          simp only [Prod.mk.injEq] at heq
          obtain ⟨rfl, rfl⟩ := heq
          simp only [State.heap]
          exact step_shared_stable_leaf hm hmf hstep
      cases π with
      | cons c π' =>
        cases c with
        | false =>
          cases hsk : stepKids Δ π' ks K with
          | none => simp [hsk] at hs
          | some p =>
            obtain ⟨ks', K₁⟩ := p
            simp [hsk] at hs
            obtain ⟨rfl, rfl⟩ := hs
            rfl
        | true => exact hmain π' hs
      | nil => exact hmain [] hs
    | _ => simp [State.isFam] at hf

end FS
