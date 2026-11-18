import FeatherweightSober.Shift

/-!
# 型代入定理（V3-2: Def の型パラメータ）

Def の本体は tvar を抽象型のまま base の世界で一度だけ型付けされる（DefsOk）。
呼び出しは型引数 ts で代入した仮想 Def（`dfn.inst ts`）を instantiate する — その健全性が本定理:
「空ストア・空チャネル環境で型付くソース項は、項の型注釈・文脈・結果型を同じ ts で
代入しても型付く」。

- 型変数 T@ρ の代入は型引数の region を読まないので、kind を満たす型引数での代入は
  escape 検査（regionsBelow）・mutFree・sub・relocR と可換（Syntax.lean の補題群）。
  kind の条件は、型変数の出現の旗が Def の kinds 以下であること（DefsOk の tvOk）と型引数の kindsArgsOk から出る
- 脱出の締めの安全性（clampSafe）は、ラベル環境の型の region の上界（label の規則）と部分型から出る
- ジェネリックがジェネリックを呼ぶ形（入れ子の call / fnref の型引数）は代入の合成
  （tsubst_comp）で閉じる。合成には呼ばれる側のシグネチャの tvarsBelow（DefsOk）が要る
- 本体はソース項（src）なので、実行時の項の場合は消える
-/
namespace FS

/-- キーにできる型は注釈なしで読める（int と imm string。kf の型変数も） -/
theorem Ty.annFree_of_keyOk {s : Ty} (h : s.keyOk = true) : s.annFree = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.annFree]

theorem Ty.annFree_tsubst {ts : List Ty} : ∀ {t : Ty}, t.annFree = true → t.kindsOk ts = true → (t.tsubst ts).annFree = true
  | .int, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .prod l r, h, hk => by
    simp only [Ty.annFree, Ty.kindsOk, Bool.and_eq_true] at h hk
    simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h.1 hk.1, Ty.annFree_tsubst h.2 hk.2]
  | .ref _ _ _, _, _ => rfl
  | .slice m r t, h, hk => by
    cases m
    · simp only [Ty.annFree, Bool.false_or] at h
      simp only [Ty.kindsOk] at hk
      simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h hk]
    · rfl
  | .map m r t, h, hk => by
    cases m
    · simp only [Ty.annFree, Bool.false_or] at h
      simp only [Ty.kindsOk] at hk
      simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h hk]
    · rfl
  | .chan _ _, _, _ => rfl
  | .dom _ _, _, _ => rfl
  | .own _ _ _, _, _ => rfl
  | .fn _ _, _, _ => rfl
  | .mus _ _ _, _, _ => rfl
  | .rvar _, _, _ => rfl
  | .tvar i ρ k, h, hk => by
    simp only [Ty.annFree] at h
    cases hi : ts[i]? with
    | none => simp [Ty.tsubst, hi, Ty.annFree, h]
    | some u =>
      simp only [Ty.kindsOk, hi] at hk
      simp only [Ty.tsubst, hi]
      exact Ty.annFree_of_keyOk (Ty.keyOk_atR ((kindOk_parts hk).2.2.2.2.2.2.2 h) ρ)
  | .opt _, h, _ => by simp [Ty.annFree] at h
  | .union _ _, h, _ => by simp [Ty.annFree] at h

/-- 比較可能性は型代入で保たれる（kf の型変数どうしは、キーにできる型引数の置き直しどうしになる） -/
theorem Ty.keyCompat_atR {s : Ty} (h : s.keyOk = true) (ρ ρ' : Nat) : (s.atR ρ).keyCompat (s.atR ρ') = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.atR, Ty.keyCompat]

theorem Ty.keyCompat_tsubst (ts : List Ty) {a b : Ty} (h : a.keyCompat b = true) (ha : a.kindsOk ts = true) :
    (a.tsubst ts).keyCompat (b.tsubst ts) = true := by
  unfold Ty.keyCompat at h
  split at h
  · simp [Ty.tsubst, Ty.keyCompat]
  · rename_i i ρ k j ρ' k'
    simp only [Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨⟨⟨⟨rfl, hkf⟩, hmf⟩, hkf'⟩, hmf'⟩ := h
    cases hi : ts[i]? with
    | none => simp [Ty.tsubst, hi, Ty.keyCompat, hkf, hmf, hkf', hmf']
    | some u =>
      simp only [Ty.kindsOk, hi] at ha
      simp only [Ty.tsubst, hi]
      exact Ty.keyCompat_atR ((kindOk_parts ha).2.2.2.2.2.2.2 hkf) ρ ρ'
  · simp [Ty.tsubst, Ty.keyCompat]
  · simp at h

/-- 関数表のシグネチャの整形条件（DefsOk から取れる部分） -/
def DefsWf (Δ : Defs) : Prop :=
  ∀ (fn : Nat) (dfn : Def), Δ[fn]? = some dfn →
    dfn.param.tvarsBelow dfn.kinds.length = true ∧ dfn.ret.tvarsBelow dfn.kinds.length = true

theorem DefsOk.wf {Δ : Defs} (h : DefsOk Δ) : DefsWf Δ := by
  intro fn dfn hfn
  obtain ⟨-, -, -, h1, h2, -, -⟩ := h fn dfn hfn
  exact ⟨h1, h2⟩

theorem Expr.noNewchan_tsubstTy {ts : List Ty} :
    ∀ {e : Expr}, (e.tsubstTy ts).noNewchan = e.noNewchan := by
  intro e
  induction e <;> simp_all [Expr.tsubstTy, Expr.noNewchan]

/-- 型引数（loc-free）は mut 位置を持たない — anchor の読み取りは代入で変わらない -/
theorem Ty.isMut0_of_locFree : ∀ {t : Ty}, t.regionsBelow 0 = true → t.isMut0 = false
  | .ref _ _ _, h | .slice _ _ _, h | .map _ _ _, h => by simp [Ty.regionsBelow] at h
  | .int, _ | .tvar _ _ _, _ | .bool, _ | .byte, _ | .f64, _ | .unit, _ | .opt _, _ | .union _ _, _ | .prod _ _, _
  | .chan _ _, _ | .dom _ _, _ | .fn _ _, _ | .rvar _, _ | .mus _ _ _, _ | .muRs _ _ _ _, _ => rfl

theorem Ty.mutTop_of_locFree : ∀ {t : Ty}, t.regionsBelow 0 = true → t.mutTop = none
  | .ref _ _ _, h | .slice _ _ _, h | .map _ _ _, h => by simp [Ty.regionsBelow] at h
  | .int, _ | .tvar _ _ _, _ | .bool, _ | .byte, _ | .f64, _ | .unit, _ | .opt _, _ | .union _ _, _ | .prod _ _, _
  | .chan _ _, _ | .dom _ _, _ | .fn _ _, _ | .rvar _, _ | .mus _ _ _, _ | .muRs _ _ _ _, _ => rfl

theorem Expr.src_tsubstTy {ts : List Ty} :
    ∀ {e : Expr}, (e.tsubstTy ts).src = e.src := by
  intro e
  induction e <;> simp_all [Expr.tsubstTy, Expr.src]

theorem Ty.rehome_of_chanFree {d : Nat} {t : Ty} (h : t.chanFree = true) : t.rehome d = t := by
  induction t with
  | prod l r ihl ihr =>
    simp only [Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.rehome, ihl h.1, ihr h.2]
  | own k r t _ => simp [Ty.chanFree] at h
  | _ => rfl

/-! ## kind の整形（DefsOk の型変数の条件）から型引数の条件へ -/

theorem Kind.le_kindOk {k k' : Kind} {s : Ty} (hle : k.le k' = true) (h : kindOk k' s = true) : kindOk k s = true := by
  rcases k with ⟨a, b, c, d, e⟩
  simp only [Kind.le, kindOk, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at hle h ⊢
  cases a <;> cases b <;> cases c <;> cases d <;> cases e <;> simp_all

theorem kindsArgsOk_get {ks : List Kind} {ts : List Ty} (h : kindsArgsOk ks ts = true) {i : Nat} {k : Kind} {s : Ty}
    (hk : ks[i]? = some k) (hs : ts[i]? = some s) : kindOk k s = true := by
  unfold kindsArgsOk at h
  have hz : (ks.zip ts)[i]? = some (k, s) := by
    rw [List.getElem?_zip_eq_some]; exact ⟨hk, hs⟩
  exact List.all_eq_true.mp h _ (List.mem_of_getElem? hz)

theorem Ty.kindsOk_of_tvWf {ks : List Kind} {ts : List Ty} (hts : kindsArgsOk ks ts = true) :
    ∀ {t : Ty}, t.tvWf ks = true → t.kindsOk ts = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h
    simp only [Ty.tvWf] at h
    cases hk : ks[i]? with
    | none => simp [hk] at h
    | some k' =>
      simp only [hk] at h
      cases hs : ts[i]? with
      | none => simp [Ty.kindsOk, hs]
      | some s => simp only [Ty.kindsOk, hs]; exact Kind.le_kindOk h (kindsArgsOk_get hts hk hs)
  | _ => simp_all [Ty.tvWf, Ty.kindsOk]

theorem Ty.tvarsBelow_of_tvWf {ks : List Kind} : ∀ {t : Ty}, t.tvWf ks = true → t.tvarsBelow ks.length = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h; simp only [Ty.tvWf] at h
    cases hk : ks[i]? with
    | none => simp [hk] at h
    | some k' => simp [Ty.tvarsBelow, (List.getElem?_eq_some_iff.mp hk).1]
  | _ => simp_all [Ty.tvWf, Ty.tvarsBelow]

/-! 型付けが作る型は、型変数の出現の整形を保つ（座標の操作は旗と添字を変えない） -/

theorem Ty.tvWf_shiftR {ks : List Kind} (ρ : Nat) : ∀ t : Ty, (t.shiftR ρ).tvWf ks = t.tvWf ks := by
  intro t; induction t <;> simp_all [Ty.tvWf, Ty.shiftR]

theorem Ty.tvWf_renR {ks : List Kind} (a d : Nat) : ∀ t : Ty, (t.renR a d).tvWf ks = t.tvWf ks := by
  intro t; induction t <;> simp_all [Ty.tvWf, Ty.renR]

theorem Ty.tvWf_atR {ks : List Kind} (k : Nat) : ∀ t : Ty, (t.atR k).tvWf ks = t.tvWf ks := by
  intro t; induction t <;> simp_all [Ty.tvWf, Ty.atR]

theorem Ty.tvWf_relocR {ks : List Kind} (ρ : Nat) : ∀ t : Ty, (t.relocR ρ).tvWf ks = t.tvWf ks := by
  intro t; induction t with
  | tvar i r kd => simp only [Ty.relocR]; split <;> (try split) <;> simp [Ty.tvWf]
  | ref m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocR, Ty.tvWf_shiftR]
  | slice m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocR, Ty.tvWf_shiftR]
  | map m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocR, Ty.tvWf_shiftR]
  | muRs r n i b _ => simp only [Ty.relocR]; split <;> simp [Ty.tvWf]
  | _ => simp_all [Ty.tvWf, Ty.relocR, Ty.tvWf_shiftR]

theorem Ty.tvWf_relocA {ks : List Kind} (a d : Nat) : ∀ t : Ty, (t.relocA a d).tvWf ks = t.tvWf ks := by
  intro t; induction t with
  | tvar i r kd => simp only [Ty.relocA]; split <;> (try split) <;> simp [Ty.tvWf]
  | ref m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocA, Ty.tvWf_renR]
  | slice m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocA, Ty.tvWf_renR]
  | map m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.relocA, Ty.tvWf_renR]
  | muRs r n i b _ => simp only [Ty.relocA]; split <;> simp [Ty.tvWf]
  | _ => simp_all [Ty.tvWf, Ty.relocA, Ty.tvWf_renR]

theorem Ty.tvWf_clampR {ks : List Kind} (k : Nat) : ∀ t : Ty, (t.clampR k).tvWf ks = t.tvWf ks := by
  intro t; induction t with
  | tvar i r kd => simp only [Ty.clampR]; split <;> (try split) <;> simp [Ty.tvWf]
  | ref m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.clampR]
  | slice m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.clampR]
  | map m r t ih => cases m <;> simp_all [Ty.tvWf, Ty.clampR]
  | muRs r n i b _ => simp only [Ty.clampR]; split <;> simp [Ty.tvWf]
  | _ => simp_all [Ty.tvWf, Ty.clampR]

theorem Ty.tvWf_rehome {ks : List Kind} (d : Nat) : ∀ t : Ty, (t.rehome d).tvWf ks = t.tvWf ks := by
  intro t; induction t with
  | own o r t _ => cases o <;> simp [Ty.tvWf, Ty.rehome]
  | _ => simp_all [Ty.tvWf, Ty.rehome]

theorem Ty.tvWf_rsubst {ks : List Kind} {s : Ty} (hs : s.tvWf ks = true) :
    ∀ {k : Nat} {t : Ty}, t.tvWf ks = true → (t.rsubst k s).tvWf ks = true := by
  intro k t; induction t generalizing k with
  | rvar i => intro _; simp only [Ty.rsubst]; split <;> simp_all [Ty.tvWf]
  | _ => simp_all [Ty.rsubst, Ty.tvWf]

theorem Ty.tvWf_comp {ks : List Kind} {bs : Ty} (h : bs.tvWf ks = true) (c : Nat) : (bs.comp c).tvWf ks = true := by
  induction bs generalizing c with
  | prod l r _ ihr =>
    simp only [Ty.tvWf, Bool.and_eq_true] at h
    cases c with
    | zero => exact h.1
    | succ c => exact ihr h.2 c
  | _ => cases c <;> rfl

theorem Ty.tvWf_unfold {ks : List Kind} {t : Ty} (h : t.tvWf ks = true) : t.unfold.tvWf ks = true := by
  cases t with
  | mus n i bs =>
    simp only [Ty.tvWf] at h
    exact Ty.substG_pres (fun t => t.tvWf ks = true)
      (fun _ _ h' => Ty.tvWf_rsubst (by simpa [Ty.grp, Ty.tvWf] using h) h') n 0 (Ty.tvWf_comp h i)
  | muRs r n i bs =>
    simp only [Ty.tvWf] at h
    simp only [Ty.unfold, Ty.tvWf_shiftR]
    exact Ty.substG_pres (fun t => t.tvWf ks = true)
      (fun _ _ h' => Ty.tvWf_rsubst (by simpa [Ty.grp, Ty.tvWf] using h) h') n 0 (Ty.tvWf_comp h i)
  | _ => simpa [Ty.unfold] using h

/-- 呼び出しの実体化: シグネチャ（Def の kinds の下で整形）を、整形した型引数で代入した型も整形 -/
theorem Ty.tvWf_tsubst {ks ks' : List Kind} {ts' : List Ty} (hw : ∀ s ∈ ts', s.tvWf ks = true)
    (hl : ts'.length = ks'.length) : ∀ {t : Ty}, t.tvWf ks' = true → (t.tsubst ts').tvWf ks = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h; simp only [Ty.tvWf] at h
    cases hk : ks'[i]? with
    | none => simp [hk] at h
    | some k' =>
      have hi : i < ts'.length := hl ▸ (List.getElem?_eq_some_iff.mp hk).1
      simp only [Ty.tsubst, List.getElem?_eq_getElem hi, Ty.tvWf_atR]
      exact hw _ (List.getElem_mem hi)
  | _ => simp_all [Ty.tvWf, Ty.tsubst]

theorem kindsArgsOk_map_tsubst {ks : List Kind} {ts ts' : List Ty} (h : kindsArgsOk ks ts' = true)
    (hk : ∀ s ∈ ts', s.kindsOk ts = true) : kindsArgsOk ks (ts'.map (Ty.tsubst ts)) = true := by
  unfold kindsArgsOk at h ⊢
  rw [List.all_eq_true] at h ⊢
  intro p hp
  rw [List.zip_map_right, List.mem_map] at hp
  obtain ⟨⟨k, s⟩, hm, rfl⟩ := hp
  exact kindOk_tsubst (h _ hm) (hk s (List.of_mem_zip hm).2)

/-! ## 代入の補題（kind の前提） -/

theorem Ty.readAs_tsubst {ts : List Ty} {m : Bool} {ot : Option Ty} {t' t : Ty}
    (hk' : t'.kindsOk ts = true) (hko : ∀ u, ot = some u → u.kindsOk ts = true)
    (h : Ty.readAs m ot t' = some t) :
    Ty.readAs m (ot.map (Ty.tsubst ts)) (t'.tsubst ts) = some (t.tsubst ts) := by
  cases ot with
  | none =>
    simp only [Ty.readAs] at h ⊢
    split at h <;> cases h
    rename_i hc
    simp only [Bool.or_eq_true] at hc
    rcases hc with hc | hc
    · simp [hc]
    · simp [Ty.annFree_tsubst hc hk']
  | some ta =>
    simp only [Ty.readAs] at h ⊢
    split at h <;> cases h
    rename_i hc
    simp [Ty.sub_tsubst hc hk' (hko _ rfl)]

theorem Ty.paramOk_tsubst {ts : List Ty} {t : Ty} (h : t.paramOk = true) (hk : t.kindsOk ts = true) :
    (t.tsubst ts).paramOk = true := by
  simp only [Ty.paramOk, Bool.and_eq_true] at h ⊢
  exact ⟨Ty.tsubst_regionsBelow t h.1 hk, Ty.tsubst_argFree t h.2 hk⟩

/-- imm で端点の無い型の戻りの写しは代入と可換（チャネル・domain・scope の結果の写し） -/
theorem Ty.tsubst_relocR_mc {ts : List Ty} {ρ : Nat} : ∀ t : Ty, t.mutFree = true → t.chanFree = true → t.kindsOk ts = true →
    (t.tsubst ts).relocR ρ = (t.relocR ρ).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hm hc hk
    have hi' : kd.imm = true := by
      simp [Ty.mutFree, Ty.chanFree] at hm hc; simp only [Kind.imm]
      rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> simp_all
    cases hi : ts[i]? with
    | none => simp only [Ty.tsubst, hi, Ty.relocR]; split <;> (try split) <;> simp [Ty.tsubst, hi]
    | some s =>
      simp only [Ty.kindsOk, hi] at hk
      obtain ⟨hm', hc'⟩ := kindOk_imm hk hi'
      cases hrf : kd.rf
      · simp only [Ty.tsubst, Ty.relocR, hi, hrf, hi', if_true, Bool.false_eq_true, if_false]
        rw [Ty.relocR_atR _ _ _ hm' hc']
      · simp only [Ty.tsubst, Ty.relocR, hi, hrf, if_true]
        rw [Ty.relocR_atR _ _ _ hm' hc']; exact kindOk_rf_atR hk hrf _ _
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.mutFree, Ty.chanFree, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.mutFree, Ty.chanFree, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.mutFree, Ty.chanFree, Ty.kindsOk]
  | muRs r n i b _ =>
    intro hm _ hk; simp only [Ty.mutFree] at hm; simp only [Ty.kindsOk] at hk
    simp [Ty.tsubst, Ty.relocR, hm, Ty.tsubst_mutFree b hm hk]
  | chan rc t _ => intro _ hc; simp [Ty.chanFree] at hc
  | dom rc t _ => intro _ hc; simp [Ty.chanFree] at hc
  | own o r t _ => intro hm; simp [Ty.mutFree] at hm
  | _ => simp_all [Ty.tsubst, Ty.relocR, Ty.mutFree, Ty.chanFree, Ty.kindsOk]

theorem Ty.payOk_tsubst {ts : List Ty} {te t : Ty} (hke : te.kindsOk ts = true) (hk : t.kindsOk ts = true)
    (hp : Ty.payOk te t = true) : Ty.payOk (te.tsubst ts) (t.tsubst ts) = true := by
  simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at hp ⊢
  obtain ⟨⟨⟨⟨p1, p2⟩, p3⟩, p4⟩, p5⟩ := hp
  refine ⟨⟨⟨⟨Ty.tsubst_mutFree te p1 hke, Ty.tsubst_chanFree te p2 hke⟩, Ty.tsubst_mutFree t p3 hk⟩,
    Ty.tsubst_chanFree t p4 hk⟩, ?_⟩
  rw [Ty.tsubst_relocR_mc te p1 p2 hke, Ty.tsubst_relocR_mc t p3 p4 hk, p5]

/-! ### 脱出の締め: 締めの安全性は、ラベルの型の region の上界と部分型から出る -/

theorem Ty.clampSafe_of_rb {k : Nat} : ∀ t : Ty, (t.clampR k).regionsBelow (k + 1) = true → t.clampSafe k = true := by
  intro t; induction t with
  | tvar i r kd =>
    simp only [Ty.clampR, Ty.clampSafe]
    cases hrf : kd.rf
    · cases hi : kd.imm
      · simp [hrf, hi, Ty.regionsBelow]; omega
      · simp
    · have : kd.imm = true := by simp [Kind.imm, hrf]
      simp [this]
  | ref m r t ih => cases m <;> simp_all [Ty.clampR, Ty.clampSafe, Ty.regionsBelow]
  | slice m r t ih => cases m <;> simp_all [Ty.clampR, Ty.clampSafe, Ty.regionsBelow]
  | map m r t ih => cases m <;> simp_all [Ty.clampR, Ty.clampSafe, Ty.regionsBelow]
  | muRs r n i b _ =>
    simp only [Ty.clampR, Ty.clampSafe]
    cases hm : b.mutFree <;> simp [Ty.regionsBelow]; omega
  | _ => simp_all [Ty.clampR, Ty.clampSafe, Ty.regionsBelow]

theorem Ty.clampSafe_of_jump {k : Nat} {tJ tL : Ty} (hs : Ty.sub (tJ.clampR k) tL = true)
    (hL : tL.regionsBelow (k + 1) = true) : tJ.clampSafe k = true :=
  Ty.clampSafe_of_rb tJ (Ty.sub_regionsBelow hs hL)

theorem Ty.noClamp_rb0 {k : Nat} : ∀ t : Ty, t.regionsBelow 0 = true → t.noClamp k = true := by
  intro t; induction t with
  | tvar i r kd => intro h; simp [Ty.regionsBelow] at h; simp [Ty.noClamp, h]
  | ref m r t ih => cases m <;> simp_all [Ty.noClamp, Ty.regionsBelow]
  | slice m r t ih => cases m <;> simp_all [Ty.noClamp, Ty.regionsBelow]
  | map m r t ih => cases m <;> simp_all [Ty.noClamp, Ty.regionsBelow]
  | _ => simp_all [Ty.noClamp, Ty.regionsBelow]

theorem Ty.noClamp_atR {r k : Nat} (hr : r ≤ k) : ∀ t : Ty, (t.atR r).noClamp k = true := by
  intro t; induction t with
  | tvar i ρ kd => cases hrf : kd.rf <;> simp [Ty.atR, Ty.noClamp, hrf, hr]
  | ref m ρ t ih => cases m <;> simp_all [Ty.atR, Ty.noClamp]
  | slice m ρ t ih => cases m <;> simp_all [Ty.atR, Ty.noClamp]
  | map m ρ t ih => cases m <;> simp_all [Ty.atR, Ty.noClamp]
  | _ => simp_all [Ty.atR, Ty.noClamp]

theorem Ty.noClamp_tsubst {ts : List Ty} {k : Nat} : ∀ t : Ty, t.noClamp k = true → t.clampSafe k = true →
    t.kindsOk ts = true → (t.tsubst ts).noClamp k = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro hn hs hk
    cases hi : ts[i]? with
    | none => simpa [Ty.tsubst, hi] using hn
    | some s =>
      simp only [Ty.kindsOk, hi] at hk
      simp only [Ty.tsubst, hi]
      cases hrf : kd.rf
      · have hr : r ≤ k := by
          simp only [Ty.noClamp, Ty.clampSafe, hrf, Bool.false_or, Bool.or_eq_true, Bool.not_eq_true',
            decide_eq_true_eq] at hn hs
          rcases hs with hs | hs
          · rcases hn with hn | hn
            · simp [hn] at hs
            · exact hn
          · exact hs
        exact Ty.noClamp_atR hr s
      · obtain ⟨-, -, -, hrf', -⟩ := kindOk_parts hk
        rw [Ty.atR_rf _ _ (hrf' hrf).1 (hrf' hrf).2]
        exact Ty.noClamp_rb0 s (hrf' hrf).1
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.noClamp, Ty.clampSafe, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.noClamp, Ty.clampSafe, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.noClamp, Ty.clampSafe, Ty.kindsOk]
  | _ => simp_all [Ty.tsubst, Ty.noClamp, Ty.clampSafe, Ty.kindsOk]

theorem Ty.kindsOk_clampR {ts : List Ty} {k : Nat} : ∀ t : Ty, t.kindsOk ts = true → (t.clampR k).kindsOk ts = true := by
  intro t; induction t with
  | tvar i r kd => simp only [Ty.clampR]; split <;> (try split) <;> simp [Ty.kindsOk]
  | ref m r t ih => cases m <;> simp_all [Ty.kindsOk, Ty.clampR]
  | slice m r t ih => cases m <;> simp_all [Ty.kindsOk, Ty.clampR]
  | map m r t ih => cases m <;> simp_all [Ty.kindsOk, Ty.clampR]
  | muRs r n i b _ => simp only [Ty.clampR]; split <;> simp [Ty.kindsOk]
  | _ => simp_all [Ty.kindsOk, Ty.clampR]

theorem Ty.clampOk_tsubst {ts : List Ty} {b k : Nat} : ∀ t : Ty, t.clampOk b k = true → t.clampSafe k = true →
    t.kindsOk ts = true → (t.tsubst ts).clampOk b k = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro hn hs hk
    cases hi : ts[i]? with
    | none => simpa [Ty.tsubst, hi] using hn
    | some s =>
      simp only [Ty.kindsOk, hi] at hk
      simp only [Ty.tsubst, hi]
      cases hrf : kd.rf
      · by_cases hr : r ≤ k
        · exact Ty.clampOk_of_noClamp _ (Ty.noClamp_atR hr s)
        · have him : kd.imm = true := by
            simp only [Ty.clampSafe, Bool.or_eq_true, decide_eq_true_eq] at hs; exact hs.resolve_right hr
          have hbk : b ≤ k := by
            simp only [Ty.clampOk, hrf, him, Bool.false_or, Bool.not_true, Bool.or_eq_true,
              decide_eq_true_eq] at hn
            omega
          obtain ⟨-, -, -, -, -, hcf, -, -⟩ := kindOk_parts hk
          have hc : kd.cf = true := by
            rcases kd with ⟨rf, mf, cf, cov⟩; cases cf <;> simp_all [Kind.imm]
          exact Ty.clampOk_of_chanFree hbk _ (by rw [Ty.chanFree_atR]; exact hcf hc)
      · obtain ⟨-, -, -, hrf', -⟩ := kindOk_parts hk
        rw [Ty.atR_rf _ _ (hrf' hrf).1 (hrf' hrf).2]
        exact Ty.clampOk_of_noClamp _ (Ty.noClamp_rb0 s (hrf' hrf).1)
  | ref m r t ih =>
    cases m
    · simp only [Ty.tsubst, Ty.clampOk, Ty.kindsOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq]
      intro hn _ hk; exact hn.imp_right (fun h => ⟨h.1, Ty.tsubst_chanFree t h.2 hk⟩)
    · simp [Ty.tsubst, Ty.clampOk]
  | slice m r t ih =>
    cases m
    · simp only [Ty.tsubst, Ty.clampOk, Ty.kindsOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq]
      intro hn _ hk; exact hn.imp_right (fun h => ⟨h.1, Ty.tsubst_chanFree t h.2 hk⟩)
    · simp [Ty.tsubst, Ty.clampOk]
  | map m r t ih =>
    cases m
    · simp only [Ty.tsubst, Ty.clampOk, Ty.kindsOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq]
      intro hn _ hk; exact hn.imp_right (fun h => ⟨h.1, Ty.tsubst_chanFree t h.2 hk⟩)
    · simp [Ty.tsubst, Ty.clampOk]
  | muRs r n i bd _ =>
    simp only [Ty.tsubst, Ty.clampOk, Ty.kindsOk, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq]
    intro hn _ hk; exact hn.imp_right (fun h => ⟨h.1, Ty.tsubst_chanFree bd h.2 hk⟩)
  | _ => simp_all [Ty.tsubst, Ty.clampOk, Ty.clampSafe, Ty.kindsOk]

/-- 脱出の関係は代入で保たれる。前提: ラベルの型の region の上界（ラベル環境の不変条件） -/
theorem Ty.jumpRel_tsubst {ts : List Ty} {b k : Nat} {tJ tL : Ty} (hkJ : tJ.kindsOk ts = true) (hkL : tL.kindsOk ts = true)
    (hL : tL.regionsBelow (k + 1) = true)
    (h : Ty.jumpRel b k tJ tL = true) : Ty.jumpRel b k (tJ.tsubst ts) (tL.tsubst ts) = true := by
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h ⊢
  have hcs := Ty.clampSafe_of_jump h.1 hL
  refine ⟨?_, ?_⟩
  · rw [Ty.tsubst_clampR tJ hcs hkJ]; exact Ty.sub_tsubst h.1 (Ty.kindsOk_clampR tJ hkJ) hkL
  · exact Ty.clampOk_tsubst tJ h.2 hcs hkJ

/-! ### 引き渡し（spawn）の型 -/

theorem Ty.givable_of_data {rs : Nat} : ∀ t : Ty, t.mutFree = true → t.chanFree = true →
    t.regionsBelow (rs + 1) = true → t.givable rs = true := by
  intro t; induction t with
  | prod l r ihl ihr =>
    intro hm hc hr; simp only [Ty.mutFree, Ty.chanFree, Ty.regionsBelow, Bool.and_eq_true] at hm hc hr
    simp [Ty.givable, ihl hm.1 hc.1 hr.1, ihr hm.2 hc.2 hr.2]
  | own o r t _ => intro hm; simp [Ty.mutFree] at hm
  | dom r t _ => intro _ hc; simp [Ty.chanFree] at hc
  | _ => intro hm hc hr; simp_all [Ty.givable]

theorem Ty.givable_data {rs : Nat} {t : Ty} (h : t.givable rs = true) (hp : ∀ l r, t ≠ .prod l r)
    (ho : ∀ k r u, t ≠ .own k r u) (hd : ∀ rc u, t ≠ .dom rc u) :
    t.mutFree = true ∧ t.chanFree = true ∧ t.regionsBelow (rs + 1) = true := by
  rw [Ty.givable_eq_data hp ho hd] at h; simpa [Bool.and_eq_true, and_assoc] using h

theorem Ty.givable_tsubst {ts : List Ty} {rs : Nat} : ∀ t : Ty, t.givable rs = true → t.kindsOk ts = true →
    (t.tsubst ts).givable rs = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro hg hk
    cases hi : ts[i]? with
    | none => simpa [Ty.tsubst, hi] using hg
    | some s =>
      simp only [Ty.kindsOk, hi] at hk
      simp only [Ty.tsubst, hi]
      simp only [Ty.givable, Ty.mutFree, Ty.chanFree, Ty.regionsBelow, Bool.and_eq_true, Bool.or_eq_true,
        decide_eq_true_eq] at hg
      obtain ⟨⟨hm, hc⟩, hr⟩ := hg
      have hi' : kd.imm = true := by
        simp only [Kind.imm]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> simp_all
      obtain ⟨hm', hc'⟩ := kindOk_imm hk hi'
      refine Ty.givable_of_data _ (by rw [Ty.mutFree_atR]; exact hm') (by rw [Ty.chanFree_atR]; exact hc') ?_
      rcases hr with hr | hr
      · obtain ⟨-, -, -, hrf, -⟩ := kindOk_parts hk
        rw [Ty.atR_rf _ _ (hrf hr).1 (hrf hr).2]
        exact Ty.regionsBelow_mono (Nat.zero_le _) (hrf hr).1
      · exact Ty.regionsBelow_atR hr _ hc'
  | prod l r ihl ihr =>
    intro hg hk; simp only [Ty.givable, Ty.kindsOk, Bool.and_eq_true] at hg hk
    simp [Ty.tsubst, Ty.givable, ihl hg.1 hk.1, ihr hg.2 hk.2]
  | own o r t _ =>
    intro hg hk; simp only [Ty.kindsOk] at hk
    cases o <;> simp_all [Ty.givable, Ty.tsubst, Ty.tsubst_mutFree, Ty.tsubst_chanFree, Ty.mutFree]
  | dom rc t _ =>
    intro hg hk; simp only [Ty.kindsOk] at hk
    simp only [Ty.givable, Bool.and_eq_true] at hg
    simp [Ty.tsubst, Ty.givable, hg.1.1, Ty.tsubst_mutFree t hg.1.2 hk, Ty.tsubst_chanFree t hg.2 hk]
  | _ =>
    intro hg hk
    obtain ⟨hm, hc, hr⟩ := Ty.givable_data hg (by intros; simp) (by intros; simp) (by intros; simp)
    exact Ty.givable_of_data _ (Ty.tsubst_mutFree _ hm hk) (Ty.tsubst_chanFree _ hc hk) (Ty.tsubst_regionsBelow _ hr hk)

theorem Ty.rehome_of_argFree {d : Nat} : ∀ {t : Ty}, t.argFree = true → t.rehome d = t := by
  intro t; induction t with
  | prod l r ihl ihr => intro h; simp only [Ty.argFree, Bool.and_eq_true] at h; simp [Ty.rehome, ihl h.1, ihr h.2]
  | own k r t _ => intro h; simp [Ty.argFree] at h
  | _ => intro _; rfl

theorem Ty.rehome_tsubst {ts : List Ty} {d : Nat} : ∀ t : Ty, t.kindsOk ts = true →
    (t.rehome d).tsubst ts = (t.tsubst ts).rehome d := by
  intro t; induction t with
  | tvar i r kd =>
    intro hk
    cases hi : ts[i]? with
    | none => simp [Ty.tsubst, Ty.rehome, hi]
    | some s =>
      simp only [Ty.kindsOk, hi] at hk
      simp only [Ty.rehome, Ty.tsubst, hi]
      rw [Ty.rehome_of_argFree (by rw [Ty.argFree_atR]; exact (kindOk_parts hk).1)]
  | prod l r ihl ihr => intro hk; simp only [Ty.kindsOk, Bool.and_eq_true] at hk; simp [Ty.tsubst, Ty.rehome, ihl hk.1, ihr hk.2]
  | own k r t _ => intro _; cases k <;> rfl
  | _ => intro _; rfl

/-! ### anchor の読み取り: 代入で増える mut の位置の region は、部分型から anchor と同じ値 -/

theorem Ty.mutTop_atR_isMut0 {s : Ty} {ρ : Nat} (h : (s.atR 0).isMut0 = true) : (s.atR ρ).mutTop = some ρ := by
  cases s <;> simp_all [Ty.atR, Ty.isMut0, Ty.mutTop]

theorem Ty.isMut0_tsubst_of {ts : List Ty} : ∀ {p : Ty}, p.isMut0 = true → (p.tsubst ts).isMut0 = true := by
  intro p h; cases p <;> simp_all [Ty.isMut0, Ty.tsubst]

theorem Ty.mutTop_tsubst_of {ts : List Ty} : ∀ {t : Ty} {a : Nat}, t.mutTop = some a → (t.tsubst ts).mutTop = some a := by
  intro t a h; cases t <;> simp_all [Ty.mutTop, Ty.tsubst]


theorem Ty.tvWf_readAs {ks : List Kind} {m : Bool} {ot : Option Ty} {t' t : Ty} (h : Ty.readAs m ot t' = some t)
    (h' : t'.tvWf ks = true) (ho : ∀ u, ot = some u → u.tvWf ks = true) : t.tvWf ks = true := by
  cases ot with
  | none => simp only [Ty.readAs] at h; split at h <;> cases h; exact h'
  | some u => simp only [Ty.readAs] at h; split at h <;> cases h; exact ho _ rfl

/-- 関数表のシグネチャの条件（型代入定理が呼び先に使う部分）: 戻りは retOk・型変数は範囲内・出現の旗は kinds 以下。
本体の型付けは含まない（kind の推論の途中の関数表もこれを満たす） -/
def SigOk (Δ : Defs) : Prop :=
  ∀ (fn : Nat) (dfn : Def), Δ[fn]? = some dfn →
    dfn.ret.retOk = true ∧ dfn.param.tvarsBelow dfn.kinds.length = true ∧ dfn.ret.tvarsBelow dfn.kinds.length = true ∧
      dfn.param.tvWf dfn.kinds = true ∧ dfn.ret.tvWf dfn.kinds = true

theorem DefsOk.sig {Δ : Defs} (h : DefsOk Δ) : SigOk Δ := by
  intro fn dfn hfn
  obtain ⟨-, hr, -, h1, h2, -, htv, -⟩ := h fn dfn hfn
  simp only [Def.tvOk, Bool.and_eq_true] at htv
  exact ⟨hr, h1, h2, htv.1.1, htv.1.2⟩

/-! ## 型代入定理 -/

namespace HasType

/-- 型代入定理: 型変数の出現の旗が ks 以下の項（注釈・文脈・ラベル環境）は、ks を満たす型引数 ts で代入しても型付く。
結論の後半は、型付けが新しい型変数の出現を作らないこと（途中の型の kind の条件を得るため）。
ラベル環境の型は、ラベルの region の上界を満たす（label の規則が要求する — 脱出の締めの安全性はここから出る） -/
theorem tsubst_typing {ks : List Kind} {ts : List Ty} {Δ : Defs} (hΔ : SigOk Δ) (hts : kindsArgsOk ks ts = true) :
    ∀ {e : Expr} {f b d : Nat} {Γ : Ctx} {Λ : LCtx} {t : Ty},
    HasType Δ ∅ [] f b d Γ Λ e t → e.src = true → e.tvWf ks = true →
    (∀ τ ∈ Γ, τ.tvWf ks = true) → (∀ p ∈ Λ, p.1.tvWf ks = true ∧ p.1.regionsBelow (p.2 + 1) = true) →
    HasType Δ ∅ [] f b d (Γ.map (Ty.tsubst ts)) (Λ.map (fun p => (p.1.tsubst ts, p.2))) (e.tsubstTy ts) (t.tsubst ts) ∧
      t.tvWf ks = true := by
  have K : ∀ {τ : Ty}, τ.tvWf ks = true → τ.kindsOk ts = true := fun h => Ty.kindsOk_of_tvWf hts h
  have hnil : ∀ p ∈ ([] : LCtx), p.1.tvWf ks = true ∧ p.1.regionsBelow (p.2 + 1) = true := by simp
  intro e
  induction e with
  | lit n => intro f b d Γ Λ t he _ _ _ _; cases he; exact ⟨.lit, rfl⟩
  | blit n => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | flit n => intro f b d Γ Λ t he _ _ _ _; cases he; exact ⟨.flit, rfl⟩
  | tt => intro f b d Γ Λ t he _ _ _ _; cases he; exact ⟨.tt, rfl⟩
  | ff => intro f b d Γ Λ t he _ _ _ _; cases he; exact ⟨.ff, rfl⟩
  | triv => intro f b d Γ Λ t he _ _ _ _; cases he; exact ⟨.triv, rfl⟩
  | var i =>
    intro f b d Γ Λ t he _ _ hΓ _
    cases he with
    | var h => exact ⟨.var (by rw [List.getElem?_map, h]; rfl), hΓ _ (List.mem_of_getElem? h)⟩
  | letE e body ihe ihb =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | letE h1 h2 =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1 hE.1 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihb h2 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨w1, hΓ⟩) hΛ
      exact ⟨.letE r1 r2, w2⟩
  | add a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | add h1 h2 => exact ⟨.add (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | lt a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | lt h1 h2 => exact ⟨.lt (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | arith op a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | arith h1 h2 => exact ⟨.arith (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | farith op a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | farith h1 h2 => exact ⟨.farith (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | cmp op a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | cmp h1 h2 => exact ⟨.cmp (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | fcmp op a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | fcmp h1 h2 => exact ⟨.fcmp (iha h1 hs.1 hE.1 hΓ hΛ).1 (ihc h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | ite c th el ihc iht ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | ite h1 h2 h3 =>
      obtain ⟨r2, w2⟩ := iht h2 hs.1.2 hE.1.2 hΓ hΛ
      exact ⟨.ite (ihc h1 hs.1.1 hE.1.1 hΓ hΛ).1 r2 (ihe h3 hs.2 hE.2 hΓ hΛ).1, w2⟩
  | nil t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he; exact ⟨.nil, by simpa [Ty.tvWf] using hE⟩
  | fold t0 e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | foldS hok h =>
      have hb : _ := hE.1
      simp only [Ty.tvWf] at hb
      obtain ⟨r, -⟩ := ihe h hs hE.2 hΓ hΛ
      rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hok) (K hb)] at r
      exact ⟨.foldS (Ty.musOk_tsubst hok (K hE.1)) r, hE.1⟩
    | foldRs hok h =>
      have hb : _ := hE.1
      simp only [Ty.tvWf] at hb
      obtain ⟨r, -⟩ := ihe h hs hE.2 hΓ hΛ
      rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hok).1 (K hb)] at r
      exact ⟨.foldRs (Ty.muRsOk_tsubst hok (K hE.1)) r, hE.1⟩
  | unfold e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | unfoldS hok h =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      have hb : _ := w
      simp only [Ty.tvWf] at hb
      refine ⟨?_, Ty.tvWf_unfold w⟩
      rw [Ty.unfold_tsubst_mus (Ty.musOk_chain hok) (K hb)]
      exact .unfoldS (Ty.musOk_tsubst hok (K w)) r
    | unfoldRs hok h =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      have hb : _ := w
      simp only [Ty.tvWf] at hb
      refine ⟨?_, Ty.tvWf_unfold w⟩
      rw [Ty.unfold_tsubst_muRs (Ty.muRsOk_parts hok).1 (K hb)]
      exact .unfoldRs (Ty.muRsOk_tsubst hok (K w)) r
  | some e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | some h => obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ; exact ⟨.some r, w⟩
  | ifnil e n s ihe ihn ihs =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | ifnil h1 h2 h3 =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1.1 hE.1.1 hΓ hΛ
      simp only [Ty.tvWf] at w1
      obtain ⟨r2, w2⟩ := ihn h2 hs.1.2 hE.1.2 hΓ hΛ
      obtain ⟨r3, -⟩ := ihs h3 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨w1, hΓ⟩) hΛ
      exact ⟨.ifnil r1 r2 r3, w2⟩
  | inl r e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | inl h => obtain ⟨r1, w⟩ := ihe h hs hE.2 hΓ hΛ; exact ⟨.inl r1, by simp [Ty.tvWf, w, hE.1]⟩
  | inr l e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | inr h => obtain ⟨r1, w⟩ := ihe h hs hE.2 hΓ hΛ; exact ⟨.inr r1, by simp [Ty.tvWf, w, hE.1]⟩
  | case e bl br ihe ihl ihr =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | case h1 h2 h3 =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1.1 hE.1.1 hΓ hΛ
      simp only [Ty.tvWf, Bool.and_eq_true] at w1
      obtain ⟨r2, w2⟩ := ihl h2 hs.1.2 hE.1.2 (List.forall_mem_cons.mpr ⟨w1.1, hΓ⟩) hΛ
      obtain ⟨r3, -⟩ := ihr h3 hs.2 hE.2 (List.forall_mem_cons.mpr ⟨w1.2, hΓ⟩) hΛ
      exact ⟨.case r1 r2 r3, w2⟩
  | pair a c iha ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | pair h1 h2 =>
      obtain ⟨r1, w1⟩ := iha h1 hs.1 hE.1 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihc h2 hs.2 hE.2 hΓ hΛ
      exact ⟨.pair r1 r2, by simp [Ty.tvWf, w1, w2]⟩
  | fst e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | fst h => obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ; simp only [Ty.tvWf, Bool.and_eq_true] at w; exact ⟨.fst r, w.1⟩
  | snd e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | snd h => obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ; simp only [Ty.tvWf, Bool.and_eq_true] at w; exact ⟨.snd r, w.2⟩
  | ann e t₀ ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | ann h hsub =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      exact ⟨.ann r (Ty.sub_tsubst hsub (K w) (K hE.1)), hE.1⟩
  | fnref fn ts' =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    have hws : ∀ s ∈ ts', s.tvWf ks = true := fun s hs => List.all_eq_true.mp hE s hs
    have hk : ∀ s ∈ ts', s.kindsOk ts = true := fun s hs => K (hws s hs)
    cases he with
    | fnref hfn hlen hargs =>
      rename_i dfn
      obtain ⟨-, hwp, hwr, htp, htr⟩ := hΔ fn dfn hfn
      rw [← hlen] at hwp hwr
      refine ⟨?_, by simp [Ty.tvWf, Def.inst, Ty.tvWf_tsubst hws hlen htp, Ty.tvWf_tsubst hws hlen htr]⟩
      simp only [Expr.tsubstTy, Def.inst, Ty.tsubst, Ty.tsubst_comp hk hwp, Ty.tsubst_comp hk hwr]
      exact .fnref hfn (by simp [hlen]) (kindsArgsOk_map_tsubst hargs hk)
  | callv a ef e ihf ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | callv hf harg hsub hbd had hro =>
      rename_i d' p r ta
      obtain ⟨r1, w1⟩ := ihf hf hs.1 hE.1 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihe harg hs.2 hE.2 hΓ hΛ
      simp only [Ty.tvWf, Bool.and_eq_true] at w1
      simp only [Ty.tsubst] at r1
      refine ⟨?_, by rw [Ty.tvWf_relocA]; exact w1.2⟩
      rw [← Ty.tsubst_relocA r hro (K w1.2)]
      have hsub' := Ty.sub_tsubst hsub (K w2) (K (by rw [Ty.tvWf_renR]; exact w1.1))
      rw [← Ty.tsubst_renR p (K w1.1)] at hsub'
      exact .callv r1 r2 hsub' hbd had (Ty.retOk_tsubst r hro (K w1.2))
  | call a fn ts' e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    have hws : ∀ s ∈ ts', s.tvWf ks = true := fun s hs => List.all_eq_true.mp hE.1 s hs
    have hk : ∀ s ∈ ts', s.kindsOk ts = true := fun s hs => K (hws s hs)
    cases he with
    | call hfn hlen hargs harg hsub hbd had =>
      rename_i d' dfn ta
      obtain ⟨hr, hwp, hwr, htp, htr⟩ := hΔ fn dfn hfn
      rw [← hlen] at hwp hwr
      have wP := Ty.tvWf_tsubst hws hlen htp
      have wR := Ty.tvWf_tsubst hws hlen htr
      obtain ⟨r2, w2⟩ := ihe harg hs hE.2 hΓ hΛ
      simp only [Def.inst] at hsub ⊢
      refine ⟨?_, by rw [Ty.tvWf_relocA]; exact wR⟩
      have hsub' := Ty.sub_tsubst hsub (K w2) (K (by rw [Ty.tvWf_renR]; exact wP))
      rw [← Ty.tsubst_renR _ (K wP), Ty.tsubst_comp hk hwp] at hsub'
      rw [← Ty.tsubst_relocA _ (Ty.retOk_tsubst _ hr (Ty.kindsOk_of_tvWf hargs htr)) (K wR), Ty.tsubst_comp hk hwr]
      exact .call hfn (by simp [hlen]) (kindsArgsOk_map_tsubst hargs hk) r2
        (by simpa [Def.inst] using hsub') hbd had
  | block e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | block h hrb =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      exact ⟨.block r (Ty.tsubst_regionsBelow _ hrb (K w)), w⟩
  | blockR t₀ e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | blockR h hr hrb =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      exact ⟨.blockR r (Ty.jumpRel_tsubst (K w) (K hE.1) (Ty.regionsBelow_mono (by omega) hrb) hr)
        (Ty.tsubst_regionsBelow _ hrb (K hE.1)), hE.1⟩
  | copyTo k t₀ e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | copyTo h hk hr hrb hcf =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      exact ⟨.copyTo r hk (Ty.jumpRel_tsubst (K w) (K hE.1) hrb hr) (Ty.tsubst_regionsBelow _ hrb (K hE.1))
        (Ty.tsubst_chanFree _ hcf (K hE.1)), hE.1⟩
  | label t₀ e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | label h hrb =>
      obtain ⟨r, -⟩ := ihe h hs hE.2 hΓ
        (List.forall_mem_cons.mpr ⟨⟨hE.1, Ty.regionsBelow_mono (by omega) hrb⟩, hΛ⟩)
      exact ⟨.label r (Ty.tsubst_regionsBelow _ hrb (K hE.1)), hE.1⟩
  | unreach t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he; exact ⟨.unreach, hE⟩
  | jump n t₀ e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | jump hn h hr =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      obtain ⟨wL, hL⟩ := hΛ _ (List.mem_of_getElem? hn)
      exact ⟨.jump (by simp [List.getElem?_map, hn]) r (Ty.jumpRel_tsubst (K w) (K wL) hL hr), hE.1⟩
  | alloc m e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | alloc h hrb hbd hmf =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      exact ⟨.alloc r (Ty.tsubst_regionsBelow _ hrb (K w)) hbd (fun hm => Ty.tsubst_mutFree _ (hmf hm) (K w)),
        by simp [Ty.tvWf, w]⟩
  | deref e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | deref h => obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ; exact ⟨.deref r, by simpa [Ty.tvWf] using w⟩
  | assign l e ihl ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | assign h1 h2 => exact ⟨.assign (ihl h1 hs.1 hE.1 hΓ hΛ).1 (ihe h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | whileE c body ihc ihb =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | whileE h1 h2 => exact ⟨.whileE (ihc h1 hs.1 hE.1 hΓ hΛ).1 (ihb h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | freeze e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | freeze h hm =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      have w' : _ := w; simp only [Ty.tvWf] at w'
      exact ⟨.freeze r (Ty.tsubst_mutFree _ hm (K w')), by simpa [Ty.tvWf] using w⟩
    | freezes h hm =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      have w' : _ := w; simp only [Ty.tvWf] at w'
      exact ⟨.freezes r (Ty.tsubst_mutFree _ hm (K w')), by simpa [Ty.tvWf] using w⟩
    | freezem h hm =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      have w' : _ := w; simp only [Ty.tvWf] at w'
      exact ⟨.freezem r (Ty.tsubst_mutFree _ hm (K w')), by simpa [Ty.tvWf] using w⟩
  | mkslice m t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | mkslice hrb hbd hmf =>
      exact ⟨.mkslice (Ty.tsubst_regionsBelow _ hrb (K hE)) hbd (fun hm => Ty.tsubst_mutFree _ (hmf hm) (K hE)),
        by simpa [Ty.tvWf] using hE⟩
  | strlit bs r => intro f b d Γ Λ t he _ _ _ _; cases he with | strlit h1 h2 => exact ⟨.strlit h1 h2, rfl⟩
  | mksliceAt m t₀ r =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | mksliceAt hrb hbr hrd hmf hcf =>
      exact ⟨.mksliceAt (Ty.tsubst_regionsBelow _ hrb (K hE)) hbr hrd (fun hm => Ty.tsubst_mutFree _ (hmf hm) (K hE))
        (Ty.tsubst_chanFree _ hcf (K hE)), by simpa [Ty.tvWf] using hE⟩
  | mkmapAt m t₀ r =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | mkmapAt hko hrb hbr hrd hmf hcf =>
      refine ⟨.mkmapAt (Ty.keyOk_tsubst hko (by have := K hE; simp only [Ty.kindsOk, Bool.and_eq_true] at this; exact this.1)) ?_ hbr hrd ?_ ?_, by simpa [Ty.tvWf] using hE⟩
      · show Ty.regionsBelow _ (Ty.tsubst ts (.prod _ (.opt _))) = true
        exact Ty.tsubst_regionsBelow _ hrb (K hE)
      · intro hm
        show (Ty.tsubst ts (.prod _ (.opt _))).mutFree = true
        exact Ty.tsubst_mutFree _ (hmf hm) (K hE)
      · show (Ty.tsubst ts (.prod _ (.opt _))).chanFree = true
        exact Ty.tsubst_chanFree _ hcf (K hE)
  | index e i ot ihe ihi =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    have ho : ∀ u, ot = Option.some u → u.tvWf ks = true := by intro u hu; subst hu; simpa using hE.2
    cases he with
    | index h1 h2 hrd =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1 hE.1.1 hΓ hΛ
      simp only [Ty.tvWf] at w1
      exact ⟨.index r1 (ihi h2 hs.2 hE.1.2 hΓ hΛ).1 (Ty.readAs_tsubst (K w1) (fun u hu => K (ho u hu)) hrd),
        Ty.tvWf_readAs hrd w1 ho⟩
  | lenE e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | lenE h => exact ⟨.lenE (ihe h hs hE hΓ hΛ).1, rfl⟩
  | tobyte e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | tobyte h => exact ⟨.tobyte (ihe h hs hE hΓ hΛ).1, rfl⟩
  | fconv op e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | fconv h =>
      have r := (ihe h hs hE hΓ hΛ).1
      cases op <;> exact ⟨.fconv r, rfl⟩
  | toint e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | toint h => exact ⟨.toint (ihe h hs hE hΓ hΛ).1, rfl⟩
  | append e v ihe ihv =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | appendM h1 h2 hbr =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1 hE.1 hΓ hΛ
      exact ⟨.appendM r1 (ihv h2 hs.2 hE.2 hΓ hΛ).1 hbr, w1⟩
    | appendI h1 h2 hbd hbt =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1 hE.1 hΓ hΛ
      have w1' : _ := w1; simp only [Ty.tvWf] at w1'
      exact ⟨.appendI r1 (ihv h2 hs.2 hE.2 hΓ hΛ).1 hbd (Ty.tsubst_regionsBelow _ hbt (K w1')), by simpa [Ty.tvWf] using w1⟩
  | setidx e i v ihe ihi ihv =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | setidx h1 h2 h3 =>
      exact ⟨.setidx (ihe h1 hs.1.1 hE.1.1 hΓ hΛ).1 (ihi h2 hs.1.2 hE.1.2 hΓ hΛ).1 (ihv h3 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | subslice e sa sb ihe iha ihb =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | subslice h1 h2 h3 =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1.1 hE.1.1 hΓ hΛ
      exact ⟨.subslice r1 (iha h2 hs.1.2 hE.1.2 hΓ hΛ).1 (ihb h3 hs.2 hE.2 hΓ hΛ).1, w1⟩
  | eqs e1 e2 ih1 ih2 =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with | eqs h1 h2 => exact ⟨.eqs (ih1 h1 hs.1 hE.1 hΓ hΛ).1 (ih2 h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
  | concat e1 e2 ih1 ih2 =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | concat h1 h2 hbd =>
      obtain ⟨r1, w1⟩ := ih1 h1 hs.1 hE.1 hΓ hΛ
      exact ⟨.concat r1 (ih2 h2 hs.2 hE.2 hΓ hΛ).1 hbd, by simpa [Ty.tvWf] using w1⟩
  | mkmap m t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | mkmap hko hrb hbd hmf =>
      refine ⟨.mkmap (Ty.keyOk_tsubst hko (by have := K hE; simp only [Ty.kindsOk, Bool.and_eq_true] at this; exact this.1)) ?_ hbd ?_, by simpa [Ty.tvWf] using hE⟩
      · show Ty.regionsBelow _ (Ty.tsubst ts (.prod _ (.opt _))) = true
        exact Ty.tsubst_regionsBelow _ hrb (K hE)
      · intro hm
        show (Ty.tsubst ts (.prod _ (.opt _))).mutFree = true
        exact Ty.tsubst_mutFree _ (hmf hm) (K hE)
  | getm t₀ e k ihe ihk =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | getm h1 h2 hkc hsub =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1 hE.1.2 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihk h2 hs.2 hE.2 hΓ hΛ
      simp only [Ty.tvWf, Bool.and_eq_true] at w1
      exact ⟨.getm r1 r2 (Ty.keyCompat_tsubst ts hkc (K w2)) (Ty.sub_tsubst hsub (K w1.2) (K hE.1.1)),
        by simpa [Ty.tvWf] using hE.1.1⟩
  | setm e k v ihe ihk ihv =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | setm h1 h2 h3 =>
      obtain ⟨r1, w1⟩ := ihe h1 hs.1.1 hE.1.1 hΓ hΛ
      exact ⟨.setm r1 (ihk h2 hs.1.2 hE.1.2 hΓ hΛ).1 (ihv h3 hs.2 hE.2 hΓ hΛ).1, w1⟩
  | delm t₀ e k ihe ihk =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | delm h1 h2 hkc =>
      obtain ⟨r2, w2⟩ := ihk h2 hs.2 hE.2 hΓ hΛ
      exact ⟨.delm (ihe h1 hs.1 hE.1.2 hΓ hΛ).1 r2 (Ty.keyCompat_tsubst ts hkc (K w2)), rfl⟩
  | lenm e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | lenm h => exact ⟨.lenm (ihe h hs hE hΓ hΛ).1, rfl⟩
  | keysm e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | keysm h hko hrb hbd =>
      obtain ⟨r, w⟩ := ihe h hs hE hΓ hΛ
      simp only [Ty.tvWf, Bool.and_eq_true] at w
      exact ⟨.keysm r (Ty.keyOk_tsubst hko (K w.1)) (Ty.tsubst_regionsBelow _ hrb (K w.1)) hbd, by simpa [Ty.tvWf] using w.1⟩
  | clone ot e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    have ho : ∀ u, ot = Option.some u → u.tvWf ks = true := by intro u hu; subst hu; simpa using hE.1
    cases he with
    | clones h hrd hrb hbd =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      simp only [Ty.tvWf] at w
      have wt := Ty.tvWf_readAs hrd w ho
      exact ⟨.clones r (Ty.readAs_tsubst (K w) (fun u hu => K (ho u hu)) hrd) (Ty.tsubst_regionsBelow _ hrb (K wt)) hbd,
        by simpa [Ty.tvWf] using wt⟩
    | clonem h hrd hrb hbd =>
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ hΛ
      simp only [Ty.tvWf] at w
      have wt := Ty.tvWf_readAs hrd w ho
      exact ⟨.clonem r (Ty.readAs_tsubst (K w) (fun u hu => K (ho u hu)) hrd) (Ty.tsubst_regionsBelow _ hrb (K wt)) hbd,
        by simpa [Ty.tvWf] using wt⟩
  | par e1 e2 ih1 ih2 =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | par h1 h2 hΓm =>
      refine ⟨.par (ih1 h1 hs.1 hE.1 hΓ hnil).1 (ih2 h2 hs.2 hE.2 hΓ hnil).1 ?_, rfl⟩
      intro τ hτ
      obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
      exact Ty.tsubst_mutFree _ (hΓm τ0 hτ0) (K (hΓ τ0 hτ0))
  | parch t₀ e1 e2 ih1 ih2 =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    have hΓ' : ∀ τ ∈ (Ty.chan d t₀ :: Γ), τ.tvWf ks = true :=
      List.forall_mem_cons.mpr ⟨by simpa [Ty.tvWf] using hE.1.1, hΓ⟩
    cases he with
    | parch h1 h2 hΓm hrb hmf =>
      refine ⟨.parch (ih1 h1 hs.1 hE.1.2 hΓ' hnil).1 (ih2 h2 hs.2 hE.2 hΓ' hnil).1 ?_
        (Ty.tsubst_regionsBelow _ hrb (K hE.1.1)) (Ty.tsubst_mutFree _ hmf (K hE.1.1)), rfl⟩
      intro τ hτ
      obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
      exact Ty.tsubst_mutFree _ (hΓm τ0 hτ0) (K (hΓ τ0 hτ0))
  | newchan rc t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | newchan hf hrb hmf =>
      exact ⟨.newchan hf (Ty.tsubst_regionsBelow _ hrb (K hE)) (Ty.tsubst_mutFree _ hmf (K hE)), by simpa [Ty.tvWf] using hE⟩
  | send c e ihc ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | send h1 h2 => exact ⟨.send (ihc h1 hs.1 hE.1 hΓ hΛ).1 (ihe h2 hs.2 hE.2 hΓ hΛ).1, rfl⟩
    | sendE h1 h2 hp =>
      obtain ⟨r1, w1⟩ := ihc h1 hs.1 hE.1 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihe h2 hs.2 hE.2 hΓ hΛ
      simp only [Ty.tvWf] at w1
      exact ⟨.sendE r1 r2 (Ty.payOk_tsubst (K w2) (K w1) hp), rfl⟩
  | recv c ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with
    | recv h => obtain ⟨r, w⟩ := ihc h hs hE hΓ hΛ; exact ⟨.recv r, by simpa [Ty.tvWf] using w⟩
    | recvE h hm hc =>
      obtain ⟨r, w⟩ := ihc h hs hE hΓ hΛ
      simp only [Ty.tvWf] at w
      refine ⟨?_, by simp [Ty.tvWf, Ty.tvWf_relocR, w]⟩
      simp only [Ty.tsubst]
      rw [← Ty.tsubst_relocR_mc _ hm hc (K w)]
      exact .recvE r (Ty.tsubst_mutFree _ hm (K w)) (Ty.tsubst_chanFree _ hc (K w))
  | close c ihc =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf] at hs hE
    cases he with | closeE h => exact ⟨.closeE (ihc h hs hE hΓ hΛ).1, rfl⟩
  | dnew r i t₀ ihi =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | dnewE h1 h2 h3 hp =>
      obtain ⟨r3, w3⟩ := ihi h3 hs hE.2 hΓ hΛ
      exact ⟨.dnewE h1 h2 r3 (Ty.payOk_tsubst (K w3) (K hE.1) hp), by simpa [Ty.tvWf] using hE.1⟩
  | domV p k r => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | denter t₀ dd ihd =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | denterE h hbd hm hc =>
      obtain ⟨r, -⟩ := ihd h hs hE.2 hΓ hΛ
      refine ⟨?_, by rw [Ty.tvWf_relocR]; exact hE.1⟩
      simp only [Expr.tsubstTy]
      rw [← Ty.tsubst_relocR_mc _ hm hc (K hE.1)]
      exact .denterE r hbd (Ty.tsubst_mutFree _ hm (K hE.1)) (Ty.tsubst_chanFree _ hc (K hE.1))
  | dexit dd v ihd ihv =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | dexitE h1 h2 hp =>
      obtain ⟨r1, w1⟩ := ihd h1 hs.1 hE.1 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihv h2 hs.2 hE.2 hΓ hΛ
      simp only [Ty.tvWf] at w1
      exact ⟨.dexitE r1 r2 (Ty.payOk_tsubst (K w2) (K w1) hp), rfl⟩
  | loc r a => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | slicev mt r base len => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | mapv mt r base len => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | chanV c => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | scope t₀ ε e ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | scope h hr hrb hem hec hbd =>
      have hΓ' : ∀ τ ∈ (Ty.own .scope d ε :: Γ), τ.tvWf ks = true :=
        List.forall_mem_cons.mpr ⟨by simpa [Ty.tvWf] using hE.1.2, hΓ⟩
      obtain ⟨r, w⟩ := ihe h hs hE.2 hΓ' hnil
      refine ⟨?_, by simp [Ty.tvWf, Ty.tvWf_relocR, hE.1.1, hE.1.2]⟩
      simp only [Ty.tsubst, Expr.tsubstTy]
      rw [← Ty.tsubst_relocR_mc _ hem hec (K hE.1.2)]
      exact .scope r (Ty.jumpRel_tsubst (K w) (K hE.1.1) (Ty.regionsBelow_mono (by omega) hrb) hr)
        (Ty.tsubst_regionsBelow _ hrb (K hE.1.1)) (Ty.tsubst_mutFree _ hem (K hE.1.2)) (Ty.tsubst_chanFree _ hec (K hE.1.2)) hbd
  | spawn sc a e ihsc iha ihe =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | spawn h1 ha hg h2 hrb hcf hε =>
      rename_i rs ta t₁ ε ε0
      obtain ⟨r1, w1⟩ := ihsc h1 hs.1.1 hE.1.1 hΓ hΛ
      obtain ⟨ra, wa⟩ := iha ha hs.1.2 hE.1.2 hΓ hΛ
      obtain ⟨r2, w2⟩ := ihe h2 hs.2 hE.2 (by simp [Ty.tvWf_rehome, wa]) hnil
      simp only [Ty.tvWf] at w1
      have w2' : _ := w2
      simp only [Ty.tvWf, Bool.and_eq_true] at w2'
      simp only [Ty.tsubst] at r1
      simp only [List.map_cons, List.map_nil, Ty.rehome_tsubst ta (K wa)] at r2
      refine ⟨?_, by simp [Ty.tvWf, Ty.tvWf_relocR, w2'.1, w2'.2]⟩
      simp only [Ty.tsubst]
      rw [← Ty.tsubst_relocR_mc (Ty.prod t₁ (.opt ε0)) hrb hcf (K w2)]
      exact .spawn r1 ra (Ty.givable_tsubst ta hg (K wa)) r2 (Ty.tsubst_mutFree _ hrb (K w2))
        (Ty.tsubst_chanFree _ hcf (K w2)) (Ty.payOk_tsubst (K w2'.2) (K w1) hε)
  | join tj h ihh =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | join h1 =>
      obtain ⟨r, -⟩ := ihh h1 hs hE.2 hΓ hΛ
      simp only [Ty.tsubst] at r
      exact ⟨.join r, hE.1⟩
  | tryJ tj h ihh =>
    intro f b d Γ Λ t he hs hE hΓ hΛ
    simp only [Expr.src, Expr.tvWf, Bool.and_eq_true] at hs hE
    cases he with
    | tryJ h1 =>
      obtain ⟨r, -⟩ := ihh h1 hs hE.2 hΓ hΛ
      simp only [Ty.tsubst] at r
      exact ⟨.tryJ r, by simpa [Ty.tvWf] using hE.1⟩
  | scopeV rs ε => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | taskV rs n => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs
  | newch r cap t₀ =>
    intro f b d Γ Λ t he _ hE _ _
    simp only [Expr.tvWf] at hE
    cases he with
    | newch h1 h2 h3 h4 h5 h6 =>
      refine ⟨?_, by simp [Ty.tvWf, hE]⟩
      simp only [Expr.tsubstTy, Ty.tsubst]
      exact .newch h1 h2 h3 (Ty.tsubst_mutFree _ h4 (K hE)) (Ty.tsubst_chanFree _ h5 (K hE))
        (Ty.tsubst_regionsBelow _ h6 (K hE))
  | epV p k b r => intro f b d Γ Λ t he hs _ _ _; simp [Expr.src] at hs

end HasType

/-- 呼び出し点のインスタンス化は DefsOk の各条件を保つ: 仮想 Def `dfn.inst ts` は
単相の Def と同じく base の世界で型付き・境界条件つき（preservation の callK が使う形） -/
theorem defsOk_inst {Δ : Defs} (hΔ : DefsOk Δ) {fn : Nat} {dfn : Def} {ts : List Ty}
    (hfn : Δ[fn]? = some dfn) (hts : kindsArgsOk dfn.kinds ts = true) :
    (dfn.inst ts).param.paramOk = true ∧ (dfn.inst ts).ret.retOk = true ∧
    (dfn.inst ts).body.noNewchan = true ∧ (dfn.inst ts).body.src = true ∧
    HasType Δ ∅ [] 1 0 2 [(dfn.inst ts).param] [] (dfn.inst ts).body (dfn.inst ts).ret := by
  obtain ⟨hp, hr, hnc, -, -, hsrc, htv, hbody⟩ := hΔ fn dfn hfn
  simp only [Def.tvOk, Bool.and_eq_true] at htv
  have K : ∀ {τ : Ty}, τ.tvWf dfn.kinds = true → τ.kindsOk ts = true := fun h => Ty.kindsOk_of_tvWf hts h
  refine ⟨Ty.paramOk_tsubst hp (K htv.1.1), Ty.retOk_tsubst _ hr (K htv.1.2), ?_, ?_, ?_⟩
  · simp only [Def.inst, Expr.noNewchan_tsubstTy]; exact hnc
  · simp only [Def.inst, Expr.src_tsubstTy]; exact hsrc
  · have := (HasType.tsubst_typing hΔ.sig hts hbody hsrc htv.2 (by simp [htv.1.1]) (by simp)).1
    simpa [Def.inst] using this

end FS
