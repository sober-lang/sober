import FeatherweightSober.TSubst

/-!
# kind の単調性

Def の本体が kind の列 ks で型付くなら、旗を足した正規形の列 ks' でも型付く。
旗を足すことは、型パラメータ j を kind ks'[j] の型変数そのもので置く型代入（`Kind.idArgs`）と同じ形になる:
代入は tvar j ρ k を tvar j (ks'[j].place ρ) ks'[j] へ写す（rf の型変数の置き直し先は 0 に揃う）。
よって単調性は型代入定理（`HasType.tsubst_typing`）の系として出る。関数表 Δ は固定する（呼ばれる Def の kind は変えない）。
-/

namespace FS

/-- 型パラメータ j を kind ks[j] の型変数 T@0 で置く型引数の列 -/
def Kind.idArgs (ks : List Kind) : List Ty := ks.mapIdx (fun j k => Ty.tvar j 0 k)

/-- 旗を足した kind の列 ks' で、型変数の出現を置き直した Def -/
def Def.raise (dfn : Def) (ks' : List Kind) : Def :=
  { param := dfn.param.tsubst (Kind.idArgs ks'), ret := dfn.ret.tsubst (Kind.idArgs ks'),
    body := dfn.body.tsubstTy (Kind.idArgs ks'), kinds := ks' }

theorem Kind.le_refl (k : Kind) : k.le k = true := by
  cases k with
  | mk rf mf cf cov kf => cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;> decide

theorem Kind.le_norm (k : Kind) : k.le k.norm = true := by
  cases k with
  | mk rf mf cf cov kf => cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;> decide

theorem Kind.idArgs_get (ks : List Kind) (j : Nat) :
    (Kind.idArgs ks)[j]? = ks[j]?.map (fun k => Ty.tvar j 0 k) := by
  simp [Kind.idArgs, List.getElem?_mapIdx]

theorem Kind.idArgs_length (ks : List Kind) : (Kind.idArgs ks).length = ks.length := by
  simp [Kind.idArgs]

/-- 旗を足した正規形の kind の型変数は、元の kind を満たす型引数になる -/
theorem kindOk_tvar_of_le {k k' : Kind} (hle : k.le k' = true) (hn : k'.isNorm = true) (j ρ : Nat) :
    kindOk k (.tvar j ρ k') = true := by
  cases k with
  | mk rf mf cf cov kf =>
    cases k' with
    | mk rf' mf' cf' cov' kf' =>
      cases rf <;> cases mf <;> cases cf <;> cases cov <;> cases kf <;>
        cases rf' <;> cases mf' <;> cases cf' <;> cases cov' <;> cases kf' <;>
        simp_all [Kind.le, Kind.isNorm, kindOk, Ty.argFree, Ty.rfree, Ty.recOk, Ty.regionsBelow,
          Ty.chanFree, Ty.mutFree, Ty.covOk, Ty.keyOk]

theorem kindsArgsOk_idArgs {ks ks' : List Kind} (hlen : ks'.length = ks.length)
    (hle : ∀ (j : Nat) (k k' : Kind), ks[j]? = some k → ks'[j]? = some k' → k.le k' = true)
    (hn : ∀ k ∈ ks', k.isNorm = true) : kindsArgsOk ks (Kind.idArgs ks') = true := by
  unfold kindsArgsOk
  rw [List.all_eq_true]
  intro p hp
  obtain ⟨j, hjl, rfl⟩ := List.getElem_of_mem hp
  have hj1 : j < ks.length := by simp at hjl; omega
  have hj' : j < ks'.length := by omega
  simp only [List.getElem_zip]
  have he : (Kind.idArgs ks')[j]'(by rw [Kind.idArgs_length]; exact hj') = Ty.tvar j 0 ks'[j] := by simp [Kind.idArgs]
  rw [he]
  exact kindOk_tvar_of_le (hle j _ _ (by simp [hj1]) (by simp [hj'])) (hn _ (List.getElem_mem hj')) j 0

/-- 型代入した注釈・引数の型は、型引数が整形なら整形 -/
theorem Expr.tvWf_tsubstTy {ks ks' : List Kind} {ts' : List Ty} (hw : ∀ s ∈ ts', s.tvWf ks = true)
    (hl : ts'.length = ks'.length) : ∀ {e : Expr}, e.tvWf ks' = true → (e.tsubstTy ts').tvWf ks = true := by
  have T : ∀ {t : Ty}, t.tvWf ks' = true → (t.tsubst ts').tvWf ks = true := Ty.tvWf_tsubst hw hl
  have L : ∀ {us : List Ty}, us.all (Ty.tvWf ks') = true → (us.map (Ty.tsubst ts')).all (Ty.tvWf ks) = true := by
    intro us h; simp only [List.all_map, List.all_eq_true, Function.comp] at h ⊢; exact fun u hu => T (h u hu)
  have O : ∀ {ot : Option Ty}, ot.all (Ty.tvWf ks') = true → (ot.map (Ty.tsubst ts')).all (Ty.tvWf ks) = true := by
    intro ot h; cases ot <;> simp_all
  intro e; induction e <;> simp_all [Expr.tvWf, Expr.tsubstTy]

/-- Def の 1 行分の条件（DefsOk の各条件）を、関数表 Δ の下で満たす -/
def DefOk (Δ : Defs) (dfn : Def) : Prop :=
  dfn.param.paramOk = true ∧ dfn.ret.retOk = true ∧ dfn.body.noNewchan = true ∧
    dfn.param.tvarsBelow dfn.kinds.length = true ∧ dfn.ret.tvarsBelow dfn.kinds.length = true ∧
    dfn.body.src = true ∧ dfn.tvOk = true ∧ HasType Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body dfn.ret

theorem DefsOk.defOk {Δ : Defs} (hΔ : DefsOk Δ) {fn : Nat} {dfn : Def} (hfn : Δ[fn]? = some dfn) : DefOk Δ dfn :=
  hΔ fn dfn hfn

/-- 単調性（行を固定）: 関数表 Δ のシグネチャの条件の下で Def が型付くなら、kind の列に旗を足した正規形の列 ks' でも、
置き直した Def は型付く。Δ は DefsOk でなくてよい（推論の途中の関数表） -/
theorem DefOk.mono {Δ : Defs} (hΔ : SigOk Δ) {dfn : Def} (hd : DefOk Δ dfn)
    {ks' : List Kind} (hlen : ks'.length = dfn.kinds.length)
    (hle : ∀ (j : Nat) (k k' : Kind), dfn.kinds[j]? = some k → ks'[j]? = some k' → k.le k' = true)
    (hn : ∀ k ∈ ks', k.isNorm = true) : DefOk Δ (dfn.raise ks') := by
  have hts := kindsArgsOk_idArgs hlen hle hn
  obtain ⟨hp, hr, hnc, -, -, hsrc, htv, hbody⟩ := hd
  simp only [Def.tvOk, Bool.and_eq_true] at htv
  have K : ∀ {τ : Ty}, τ.tvWf dfn.kinds = true → τ.kindsOk (Kind.idArgs ks') = true := fun h => Ty.kindsOk_of_tvWf hts h
  have hw : ∀ s ∈ Kind.idArgs ks', s.tvWf ks' = true := by
    intro s hs
    obtain ⟨j, hjl, rfl⟩ := List.getElem_of_mem hs
    have hj' : j < ks'.length := by simpa [Kind.idArgs_length] using hjl
    simp [Kind.idArgs, Ty.tvWf, List.getElem?_eq_getElem hj', Kind.le_refl]
  have hl : (Kind.idArgs ks').length = dfn.kinds.length := by rw [Kind.idArgs_length, hlen]
  have T : ∀ {t : Ty}, t.tvWf dfn.kinds = true → (t.tsubst (Kind.idArgs ks')).tvWf ks' = true := Ty.tvWf_tsubst hw hl
  have wp := T htv.1.1
  have wr := T htv.1.2
  refine ⟨Ty.paramOk_tsubst hp (K htv.1.1), Ty.retOk_tsubst _ hr (K htv.1.2), ?_, Ty.tvarsBelow_of_tvWf wp,
    Ty.tvarsBelow_of_tvWf wr, ?_, ?_, ?_⟩
  · simp only [Def.raise, Expr.noNewchan_tsubstTy]; exact hnc
  · simp only [Def.raise, Expr.src_tsubstTy]; exact hsrc
  · simp only [Def.tvOk, Def.raise, Bool.and_eq_true]
    exact ⟨⟨wp, wr⟩, Expr.tvWf_tsubstTy hw hl htv.2⟩
  · have := (HasType.tsubst_typing hΔ hts hbody hsrc htv.2 (by simp [htv.1.1]) (by simp)).1
    simpa [Def.raise] using this

/-- 単調性（関数表の Def について）: DefsOk の関数表の Def の kind に旗を足した正規形の列でも、置き直した Def は型付く -/
theorem Def.kind_mono {Δ : Defs} (hΔ : DefsOk Δ) {fn : Nat} {dfn : Def} (hfn : Δ[fn]? = some dfn)
    {ks' : List Kind} (hlen : ks'.length = dfn.kinds.length)
    (hle : ∀ (j : Nat) (k k' : Kind), dfn.kinds[j]? = some k → ks'[j]? = some k' → k.le k' = true)
    (hn : ∀ k ∈ ks', k.isNorm = true) : DefOk Δ (dfn.raise ks') :=
  DefOk.mono hΔ.sig (hΔ.defOk hfn) hlen hle hn

/-- 旗を足した Def の型変数の出現は、置き場の関数で正規化されている（rf の出現の置き直し先は 0） -/
theorem Kind.idArgs_atR {ks : List Kind} {j : Nat} {k : Kind} (h : ks[j]? = some k) (ρ : Nat) :
    ((Kind.idArgs ks)[j]?).map (fun s => s.atR ρ) = some (.tvar j (k.place ρ) k) := by
  rw [Kind.idArgs_get, h]
  simp [Ty.atR, Kind.place]

/-! ### 形の検査（Def.raisedOk）: 宣言の kind で置き直しても変わらない Def -/

theorem Kind.le_antisymm {k k' : Kind} (h1 : k.le k' = true) (h2 : k'.le k = true) : k = k' := by
  cases k with
  | mk a b c d e => cases k' with
    | mk a' b' c' d' e' => cases a <;> cases b <;> cases c <;> cases d <;> cases e <;>
        cases a' <;> cases b' <;> cases c' <;> cases d' <;> cases e' <;> simp_all [Kind.le]

theorem Ty.tsubst_idArgs_self {ks : List Kind} : ∀ {t : Ty}, t.raisedOk ks = true → t.tsubst (Kind.idArgs ks) = t := by
  intro t; induction t with
  | tvar i ρ k =>
    intro h
    simp only [Ty.raisedOk] at h
    split at h
    · rename_i k' hk
      simp only [Bool.and_eq_true, beq_iff_eq] at h
      obtain ⟨⟨h1, h2⟩, h3⟩ := h
      have := Kind.le_antisymm h1 h2; subst this
      simp only [Ty.tsubst, Kind.idArgs_get, hk, Option.map_some]
      simp only [Ty.atR, Kind.place] at h3 ⊢
      split <;> simp_all
    · cases h
  | _ => simp_all [Ty.raisedOk, Ty.tsubst]

theorem Expr.tsubstTy_idArgs_self {ks : List Kind} : ∀ {e : Expr}, e.raisedOk ks = true → e.tsubstTy (Kind.idArgs ks) = e := by
  have T : ∀ {t : Ty}, t.raisedOk ks = true → t.tsubst (Kind.idArgs ks) = t := Ty.tsubst_idArgs_self
  have L : ∀ {us : List Ty}, us.all (Ty.raisedOk ks) = true → us.map (Ty.tsubst (Kind.idArgs ks)) = us := by
    intro us h; induction us <;> simp_all
  have O : ∀ {ot : Option Ty}, ot.all (Ty.raisedOk ks) = true → ot.map (Ty.tsubst (Kind.idArgs ks)) = ot := by
    intro ot h; cases ot <;> simp_all
  intro e; induction e <;> simp_all [Expr.raisedOk, Expr.tsubstTy]

/-- 形の検査を通る Def は、宣言の kind で置き直しても変わらない（推論の定理の前提 — 形の Def と確定した Def が同じ） -/
theorem Def.raise_self {dfn : Def} (h : dfn.raisedOk = true) : dfn.raise dfn.kinds = dfn := by
  simp only [Def.raisedOk, Bool.and_eq_true] at h
  obtain ⟨⟨hp, hr⟩, hb⟩ := h
  simp only [Def.raise, Ty.tsubst_idArgs_self hp, Ty.tsubst_idArgs_self hr, Expr.tsubstTy_idArgs_self hb]

end FS
