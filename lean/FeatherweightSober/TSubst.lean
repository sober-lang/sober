import FeatherweightSober.Shift

/-!
# 型代入定理（V3-2: Def の型パラメータ）

Def の本体は tvar を抽象型のまま base の世界で一度だけ型付けされる（DefsOk）。
呼び出しは型引数 ts で代入した仮想 Def（`dfn.inst ts`）を instantiate する — その健全性が本定理:
「空ストア・空チャネル環境で型付くソース項は、項の型注釈・文脈・結果型を同じ ts で
代入しても型付く」。

- 型引数は loc-free・chan-free（tyArgOk）なので、代入は region 添字にもシフトにも触れず、
  escape 検査（regionsBelow）・mutFree・sub・relocR と可換（Syntax.lean の補題群）
- ジェネリックがジェネリックを呼ぶ形（入れ子の call / fnref の型引数）は代入の合成
  （tsubst_comp）で閉じる。合成には呼ばれる側のシグネチャの tvarsBelow（DefsOk）が要る
- ストアとチャネル環境が空なので loc / chanV は型が付かず、実行時項のケースが消える
  （空 slice / map ヘッダだけは型が付くので再構築する — shift_typing と同じ）
-/
namespace FS

/-- キー型の制限・比較可能性は型代入で不変（int / imm string は tvar を含まない） -/
theorem Ty.keyOk_tsubst (ts : List Ty) {k : Ty} (h : k.keyOk = true) : (k.tsubst ts).keyOk = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.tsubst, Ty.keyOk]

theorem Ty.annFree_tsubst {ts : List Ty} : ∀ {t : Ty}, t.annFree = true → (t.tsubst ts).annFree = true
  | .int, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .prod l r, h => by
    simp only [Ty.annFree, Bool.and_eq_true] at h
    simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h.1, Ty.annFree_tsubst h.2]
  | .ref _ _ _, _ => rfl
  | .slice m r t, h => by
    cases m
    · simp only [Ty.annFree, Bool.false_or] at h
      simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h]
    · rfl
  | .map m r t, h => by
    cases m
    · simp only [Ty.annFree, Bool.false_or] at h
      simp [Ty.tsubst, Ty.annFree, Ty.annFree_tsubst h]
    · rfl
  | .chan _ _, _ => rfl
  | .own _ _ _, _ => rfl
  | .fn _ _, _ => rfl
  | .tvar _, h => by simp [Ty.annFree] at h
  | .opt _, h => by simp [Ty.annFree] at h
  | .union _ _, h => by simp [Ty.annFree] at h

theorem Ty.readAs_tsubst {ts : List Ty} {m : Bool} {ot : Option Ty} {t' t : Ty}
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
    · simp [Ty.annFree_tsubst hc]
  | some ta =>
    simp only [Ty.readAs] at h ⊢
    split at h <;> cases h
    rename_i hc
    simp [Ty.sub_tsubst hc]

theorem Ty.keyCompat_tsubst (ts : List Ty) {a b : Ty} (h : a.keyCompat b = true) :
    (a.tsubst ts).keyCompat (b.tsubst ts) = true := by
  unfold Ty.keyCompat at h
  split at h <;> simp_all [Ty.tsubst, Ty.keyCompat]

/-- 関数表のシグネチャの整形条件（DefsOk から取れる部分） -/
def DefsWf (Δ : Defs) : Prop :=
  ∀ (fn : Nat) (dfn : Def), Δ[fn]? = some dfn →
    dfn.param.tvarsBelow dfn.tparams = true ∧ dfn.ret.tvarsBelow dfn.tparams = true

theorem DefsOk.wf {Δ : Defs} (h : DefsOk Δ) : DefsWf Δ := by
  intro fn dfn hfn
  obtain ⟨-, -, -, h1, h2, -, -⟩ := h fn dfn hfn
  exact ⟨h1, h2⟩

/-- 型引数は retOk（loc-free なので最上段のコンテナを持たない） -/
theorem Ty.retOk_of_argOk : ∀ {t : Ty}, t.tyArgOk = true → t.retOk = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at h
    exact Ty.retOk_of_argOk (t := t) (by simp [Ty.tyArgOk, h])
  | .union l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.retOk, Ty.retOk_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.retOk_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .prod l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.retOk, Ty.retOk_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.retOk_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .ref _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .slice _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .map _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .chan _ _, h => by simp [Ty.tyArgOk, Ty.chanFree] at h
  | .fn _ _, _ => rfl

theorem Ty.tsubst_retOk {ts : List Ty} (h : Ty.tyArgsOk ts = true) :
    ∀ {t : Ty}, t.retOk = true → (t.tsubst ts).retOk = true
  | .int, _ => rfl
  | .tvar i, _ => by
    simp only [Ty.tsubst]
    exact Ty.retOk_of_argOk (Ty.tsubst_tvar_argOk h i)
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, hr => by
    simp only [Ty.retOk] at hr
    simp only [Ty.tsubst, Ty.retOk]
    exact Ty.tsubst_retOk h hr
  | .union l r, hr => by
    simp only [Ty.retOk, Bool.and_eq_true] at hr
    simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true]
    exact ⟨Ty.tsubst_retOk h hr.1, Ty.tsubst_retOk h hr.2⟩
  | .prod l r, hr => by
    simp only [Ty.retOk, Bool.and_eq_true] at hr
    simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true]
    exact ⟨Ty.tsubst_retOk h hr.1, Ty.tsubst_retOk h hr.2⟩
  | .ref m r t, hr => by
    cases m with
    | true => simp [Ty.retOk] at hr
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at hr
      simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true]
      exact ⟨hr.1, Ty.tsubst_retOk h hr.2⟩
  | .slice m r t, hr => by
    cases m with
    | true => simp [Ty.retOk] at hr
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at hr
      simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true]
      exact ⟨hr.1, Ty.tsubst_retOk h hr.2⟩
  | .map m r t, hr => by
    cases m with
    | true => simp [Ty.retOk] at hr
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at hr
      simp only [Ty.tsubst, Ty.retOk, Bool.and_eq_true]
      exact ⟨hr.1, Ty.tsubst_retOk h hr.2⟩
  | .chan _ _, hr => by simp [Ty.retOk] at hr
  | .fn _ _, _ => rfl

theorem Ty.tsubst_paramOk {ts : List Ty} (h : Ty.tyArgsOk ts = true) {t : Ty} :
    (t.tsubst ts).paramOk = t.paramOk := by
  simp only [Ty.paramOk, Ty.tsubst_regionsBelow h, Ty.tsubst_mutFree h, Ty.tsubst_chanFree h]

theorem Expr.noNewchan_tsubstTy {ts : List Ty} :
    ∀ {e : Expr}, (e.tsubstTy ts).noNewchan = e.noNewchan := by
  intro e
  induction e <;> simp_all [Expr.tsubstTy, Expr.noNewchan]

/-- 型引数（loc-free）は mut 位置を持たない — anchor の読み取りは代入で変わらない -/
theorem Ty.isMut0_of_locFree : ∀ {t : Ty}, t.regionsBelow 0 = true → t.isMut0 = false
  | .ref _ _ _, h | .slice _ _ _, h | .map _ _ _, h => by simp [Ty.regionsBelow] at h
  | .int, _ | .tvar _, _ | .bool, _ | .byte, _ | .f64, _ | .unit, _ | .opt _, _ | .union _ _, _ | .prod _ _, _
  | .chan _ _, _ | .fn _ _, _ => rfl

theorem Ty.mutTop_of_locFree : ∀ {t : Ty}, t.regionsBelow 0 = true → t.mutTop = none
  | .ref _ _ _, h | .slice _ _ _, h | .map _ _ _, h => by simp [Ty.regionsBelow] at h
  | .int, _ | .tvar _, _ | .bool, _ | .byte, _ | .f64, _ | .unit, _ | .opt _, _ | .union _ _, _ | .prod _ _, _
  | .chan _ _, _ | .fn _ _, _ => rfl

theorem Ty.anchorOf_of_locFreeL : ∀ {p : Ty} (ta : Ty), p.regionsBelow 0 = true → Ty.anchorOf p ta = none := by
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro ta h
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    cases ta <;> simp only [Ty.anchorOf]
    rw [ihl _ h.1, ihr _ h.2]; rfl
  | _ =>
    intro ta h
    simp only [Ty.anchorOf]
    rw [Ty.isMut0_of_locFree h]; rfl

theorem Ty.anchorOf_of_locFreeR : ∀ (p : Ty) {ta : Ty}, ta.regionsBelow 0 = true → Ty.anchorOf p ta = none := by
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro ta h
    cases ta <;> simp only [Ty.anchorOf]
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    rw [ihl h.1, ihr h.2]; rfl
  | _ =>
    intro ta h
    simp only [Ty.anchorOf]
    split <;> simp [Ty.mutTop_of_locFree h]

theorem Ty.mutTop_tsubst {ts : List Ty} (h : Ty.tyArgsOk ts = true) : ∀ t : Ty, (t.tsubst ts).mutTop = t.mutTop
  | .tvar i => by
    simp only [Ty.tsubst, Ty.mutTop]
    exact Ty.mutTop_of_locFree (by
      have := Ty.tsubst_tvar_argOk h i
      simp only [Ty.tyArgOk, Bool.and_eq_true] at this
      exact this.1)
  | .ref m r _ | .slice m r _ | .map m r _ => by simp [Ty.tsubst, Ty.mutTop]
  | .int | .bool | .byte | .f64 | .unit | .opt _ | .union _ _ | .prod _ _ | .chan _ _ | .fn _ _ | .own _ _ _ => by
    simp [Ty.tsubst, Ty.mutTop]

theorem Ty.anchorOf_tsubst {ts : List Ty} (h : Ty.tyArgsOk ts = true) :
    ∀ (p ta : Ty), Ty.anchorOf (p.tsubst ts) (ta.tsubst ts) = Ty.anchorOf p ta := by
  have hloc : ∀ i, ((ts[i]?).getD (Ty.tvar i)).regionsBelow 0 = true := fun i => by
    have := Ty.tsubst_tvar_argOk h i
    simp only [Ty.tyArgOk, Bool.and_eq_true] at this
    exact this.1
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro ta
    cases ta with
    | prod l' r' => simp only [Ty.tsubst, Ty.anchorOf, ihl, ihr]
    | tvar i =>
      simp only [Ty.tsubst]
      rw [Ty.anchorOf_of_locFreeR _ (hloc i)]
      rfl
    | _ => simp [Ty.tsubst, Ty.anchorOf]
  | tvar i =>
    intro ta
    simp only [Ty.tsubst]
    rw [Ty.anchorOf_of_locFreeL _ (hloc i)]
    rfl
  | _ =>
    intro ta
    simp [Ty.tsubst, Ty.anchorOf, Ty.isMut0, Ty.mutTop_tsubst h]

theorem Ty.tsubst_renR {ts : List Ty} {a d : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).renR a d = (t.renR a d).tsubst ts
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.renR]
    exact Ty.renR_of_argOk (Ty.tsubst_tvar_argOk h i)
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .union l r => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h l, Ty.tsubst_renR h r]
  | .prod l r => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h l, Ty.tsubst_renR h r]
  | .ref m r t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .slice m r t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .map m r t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .chan rc t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .own k r t => by simp [Ty.tsubst, Ty.renR, Ty.tsubst_renR h t]
  | .fn p r => rfl

theorem Ty.relocA_of_argOk {a d : Nat} {t : Ty} (h : t.tyArgOk = true) : t.relocA a d = t := by
  induction t with
  | int => rfl
  | tvar _ => rfl
  | bool => rfl
  | byte => rfl
  | f64 => rfl
  | unit => rfl
  | opt t ih =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at h
    simp [Ty.relocA, ih (by simp [Ty.tyArgOk, h])]
  | union l r ihl ihr =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.relocA, ihl (by simp [Ty.tyArgOk, h]), ihr (by simp [Ty.tyArgOk, h])]
  | prod l r ihl ihr =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.relocA, ihl (by simp [Ty.tyArgOk, h]), ihr (by simp [Ty.tyArgOk, h])]
  | ref _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | slice _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | map _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | chan _ _ _ => simp [Ty.tyArgOk, Ty.chanFree] at h
  | own _ _ _ _ => simp [Ty.tyArgOk, Ty.chanFree] at h
  | fn _ _ _ _ => rfl

theorem Ty.tsubst_relocA {ts : List Ty} {a d : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).relocA a d = (t.relocA a d).tsubst ts
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.relocA]
    exact Ty.relocA_of_argOk (Ty.tsubst_tvar_argOk h i)
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.relocA, Ty.tsubst_relocA h t]
  | .union l r => by simp [Ty.tsubst, Ty.relocA, Ty.tsubst_relocA h l, Ty.tsubst_relocA h r]
  | .prod l r => by simp [Ty.tsubst, Ty.relocA, Ty.tsubst_relocA h l, Ty.tsubst_relocA h r]
  | .ref m r t => by cases m <;> simp [Ty.tsubst, Ty.relocA, Ty.tsubst_renR h t, Ty.tsubst_relocA h t]
  | .slice m r t => by cases m <;> simp [Ty.tsubst, Ty.relocA, Ty.tsubst_renR h t, Ty.tsubst_relocA h t]
  | .map m r t => by cases m <;> simp [Ty.tsubst, Ty.relocA, Ty.tsubst_renR h t, Ty.tsubst_relocA h t]
  | .chan rc t => by simp [Ty.tsubst, Ty.relocA, Ty.tsubst_renR h t]
  | .own k r t => by simp [Ty.tsubst, Ty.relocA, Ty.tsubst_renR h t]
  | .fn p r => rfl

theorem Expr.src_tsubstTy {ts : List Ty} :
    ∀ {e : Expr}, (e.tsubstTy ts).src = e.src := by
  intro e
  induction e <;> simp_all [Expr.tsubstTy, Expr.src]

/-- 締め（R4b）と型代入の交換（型引数は loc-free なので締めに触れない） -/
theorem Ty.clampR_tsubst {ts : List Ty} {k : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).clampR k = (t.clampR k).tsubst ts
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.clampR]
    have ha := Ty.tsubst_tvar_argOk h i
    generalize (ts[i]?).getD (Ty.tvar i) = τ at ha ⊢
    induction τ with
    | opt t ih =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at ha
      simp [Ty.clampR, ih (by simp [Ty.tyArgOk, ha])]
    | union l r ihl ihr =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at ha
      simp [Ty.clampR, ihl (by simp [Ty.tyArgOk, ha]), ihr (by simp [Ty.tyArgOk, ha])]
    | prod l r ihl ihr =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at ha
      simp [Ty.clampR, ihl (by simp [Ty.tyArgOk, ha]), ihr (by simp [Ty.tyArgOk, ha])]
    | ref _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | slice _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | map _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h t]
  | .union l r => by simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h l, Ty.clampR_tsubst h r]
  | .prod l r => by simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h l, Ty.clampR_tsubst h r]
  | .ref m r t => by cases m <;> simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h t]
  | .slice m r t => by cases m <;> simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h t]
  | .map m r t => by cases m <;> simp [Ty.tsubst, Ty.clampR, Ty.clampR_tsubst h t]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl

theorem Ty.noClamp_tsubst {ts : List Ty} {k : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).noClamp k = t.noClamp k
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.noClamp]
    have ha := Ty.tsubst_tvar_argOk h i
    generalize (ts[i]?).getD (Ty.tvar i) = τ at ha ⊢
    induction τ with
    | opt t ih =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at ha
      simp [Ty.noClamp, ih (by simp [Ty.tyArgOk, ha])]
    | union l r ihl ihr =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at ha
      simp [Ty.noClamp, ihl (by simp [Ty.tyArgOk, ha]), ihr (by simp [Ty.tyArgOk, ha])]
    | prod l r ihl ihr =>
      simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at ha
      simp [Ty.noClamp, ihl (by simp [Ty.tyArgOk, ha]), ihr (by simp [Ty.tyArgOk, ha])]
    | ref _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | slice _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | map _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at ha
    | _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h t]
  | .union l r => by simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h l, Ty.noClamp_tsubst h r]
  | .prod l r => by simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h l, Ty.noClamp_tsubst h r]
  | .ref m r t => by cases m <;> simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h t]
  | .slice m r t => by cases m <;> simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h t]
  | .map m r t => by cases m <;> simp [Ty.tsubst, Ty.noClamp, Ty.noClamp_tsubst h t]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl

theorem Ty.jumpRel_tsubst {ts : List Ty} {b k : Nat} (hts : Ty.tyArgsOk ts = true) {tJ tL : Ty}
    (h : Ty.jumpRel b k tJ tL = true) : Ty.jumpRel b k (tJ.tsubst ts) (tL.tsubst ts) = true := by
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h ⊢
  refine ⟨?_, ?_⟩
  · rw [Ty.clampR_tsubst hts]; exact Ty.sub_tsubst h.1
  · rw [Ty.noClamp_tsubst hts, Ty.tsubst_chanFree hts]; exact h.2

/-! 段 6 P1: 引き渡し（give:）の型の補題 -/

theorem Ty.givable_of_argOk {rs : Nat} {t : Ty} (h : t.tyArgOk = true) : t.givable rs = true := by
  induction t with
  | prod l r ihl ihr =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.givable, ihl (by simp [Ty.tyArgOk, h]), ihr (by simp [Ty.tyArgOk, h])]
  | own k r t _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | _ =>
    simp only [Ty.tyArgOk, Bool.and_eq_true] at h
    simp [Ty.givable, Ty.mutFree_of_locFree h.1, h.2, Ty.regionsBelow_mono (Nat.zero_le _) h.1]

theorem Ty.rehome_of_chanFree {d : Nat} {t : Ty} (h : t.chanFree = true) : t.rehome d = t := by
  induction t with
  | prod l r ihl ihr =>
    simp only [Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.rehome, ihl h.1, ihr h.2]
  | own k r t _ => simp [Ty.chanFree] at h
  | _ => rfl

theorem Ty.givable_tsubst {ts : List Ty} {rs : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).givable rs = t.givable rs := by
  intro t
  induction t with
  | tvar i =>
    simp only [Ty.tsubst]
    rw [Ty.givable_of_argOk (Ty.tsubst_tvar_argOk h i)]
    simp [Ty.givable, Ty.mutFree, Ty.chanFree, Ty.regionsBelow]
  | prod l r ihl ihr => simp [Ty.tsubst, Ty.givable, ihl, ihr]
  | own k r t _ =>
    cases k <;> simp [Ty.tsubst, Ty.givable, Ty.tsubst_regionsBelow h, Ty.tsubst_chanFree h, Ty.tsubst_mutFree h, Ty.mutFree]
  | _ => simp [Ty.tsubst, Ty.givable, Ty.mutFree, Ty.chanFree, Ty.regionsBelow, Ty.tsubst_mutFree h,
      Ty.tsubst_chanFree h, Ty.tsubst_regionsBelow h]

theorem Ty.rehome_tsubst {ts : List Ty} {d : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.rehome d).tsubst ts = (t.tsubst ts).rehome d := by
  intro t
  induction t with
  | tvar i =>
    simp only [Ty.rehome, Ty.tsubst]
    have ha := Ty.tsubst_tvar_argOk h i
    simp only [Ty.tyArgOk, Bool.and_eq_true] at ha
    rw [Ty.rehome_of_chanFree ha.2]
  | prod l r ihl ihr => simp [Ty.tsubst, Ty.rehome, ihl, ihr]
  | own k r t _ => cases k <;> rfl
  | _ => rfl

namespace HasType

theorem tsubst_typing {e : Expr} {Δ : Defs} {f b d : Nat} {Γ : Ctx} {t : Ty} {ts : List Ty}
    (hwf : DefsWf Δ) (hts : Ty.tyArgsOk ts = true)
    (he : HasType Δ ∅ [] f b d Γ Λ e t) :
    HasType Δ ∅ [] f b d (Γ.map (Ty.tsubst ts)) (Λ.map (fun p => (p.1.tsubst ts, p.2))) (e.tsubstTy ts) (t.tsubst ts) := by
  induction e generalizing f b d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i =>
    cases he with
    | var h =>
      refine .var ?_
      rw [List.getElem?_map, h]
      rfl
  | letE e body ihe ihb =>
    cases he with
    | letE h1 h2 => exact .letE (ihe h1) (ihb h2)
  | add a c iha ihc => cases he with | add h1 h2 => exact .add (iha h1) (ihc h2)
  | lt a c iha ihc => cases he with | lt h1 h2 => exact .lt (iha h1) (ihc h2)
  | arith op a c iha ihc =>
    cases he with | arith h1 h2 => exact .arith (iha h1) (ihc h2)
  | farith op a c iha ihc =>
    cases he with | farith h1 h2 => exact .farith (iha h1) (ihc h2)
  | cmp op a c iha ihc => cases he with | cmp h1 h2 => exact .cmp (iha h1) (ihc h2)
  | fcmp op a c iha ihc => cases he with | fcmp h1 h2 => exact .fcmp (iha h1) (ihc h2)
  | ite c th el ihc iht ihe =>
    cases he with | ite h1 h2 h3 => exact .ite (ihc h1) (iht h2) (ihe h3)
  | nil t => cases he; exact .nil
  | some e ihe => cases he with | some h => exact .some (ihe h)
  | ifnil e n s ihe ihn ihs =>
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe h1) (ihn h2) (ihs h3)
  | inl r e ihe => cases he with | inl h => exact .inl (ihe h)
  | inr l e ihe => cases he with | inr h => exact .inr (ihe h)
  | case e bl br ihe ihl ihr =>
    cases he with | case h1 h2 h3 => exact .case (ihe h1) (ihl h2) (ihr h3)
  | pair a c iha ihc => cases he with | pair h1 h2 => exact .pair (iha h1) (ihc h2)
  | fst e ihe => cases he with | fst h => exact .fst (ihe h)
  | ann e t ihe =>
    cases he with | ann h hs => exact .ann (ihe h) (Ty.sub_tsubst hs)
  | snd e ihe => cases he with | snd h => exact .snd (ihe h)
  | fnref fn ts' =>
    cases he with
    | fnref hfn hlen hargs =>
      rename_i dfn
      obtain ⟨hwp, hwr⟩ := hwf fn dfn hfn
      rw [← hlen] at hwp hwr
      simp only [Expr.tsubstTy, Def.inst, Ty.tsubst, Ty.tsubst_comp hwp, Ty.tsubst_comp hwr]
      exact .fnref hfn (by simp [hlen]) (Ty.tyArgsOk_map_tsubst hts hargs)
  | callv ef e ihf ihe =>
    cases he with
    | callv hf harg hsub hbd =>
      rename_i d' p r ta
      rw [← Ty.tsubst_relocR hts]
      have hsub' := Ty.sub_tsubst (ts := ts) hsub
      rw [← Ty.tsubst_shiftR hts] at hsub'
      have hf' := ihf hf
      simp only [Ty.tsubst] at hf'
      exact .callv hf' (ihe harg) hsub' hbd
  | call fn ts' e ihe =>
    cases he with
    | call hfn hlen hargs harg hsub hbd =>
      rename_i d' dfn ta
      obtain ⟨hwp, hwr⟩ := hwf fn dfn hfn
      rw [← hlen] at hwp hwr
      have hsub' := Ty.sub_tsubst (ts := ts) hsub
      rw [← Ty.tsubst_shiftR hts] at hsub'
      simp only [Def.inst, Ty.tsubst_comp hwp] at hsub'
      simp only [Expr.tsubstTy]
      rw [← Ty.tsubst_relocR hts]
      simp only [Def.inst, Ty.tsubst_comp hwr]
      exact .call hfn (by simp [hlen]) (Ty.tyArgsOk_map_tsubst hts hargs) (ihe harg)
        (by simpa [Def.inst] using hsub') hbd
  | callM fn ts' e ihe =>
    cases he with
    | callM hfn hlen hargs harg hanc hsub hbd had =>
      rename_i d' dfn ta a
      obtain ⟨hwp, hwr⟩ := hwf fn dfn hfn
      rw [← hlen] at hwp hwr
      have hsub' := Ty.sub_tsubst (ts := ts) hsub
      rw [← Ty.tsubst_renR hts] at hsub'
      simp only [Def.inst, Ty.tsubst_comp hwp] at hsub'
      have hanc' := hanc
      rw [← Ty.anchorOf_tsubst hts] at hanc'
      simp only [Def.inst, Ty.tsubst_comp hwp] at hanc'
      simp only [Expr.tsubstTy]
      rw [← Ty.tsubst_relocA hts]
      simp only [Def.inst, Ty.tsubst_comp hwr]
      exact .callM hfn (by simp [hlen]) (Ty.tyArgsOk_map_tsubst hts hargs) (ihe harg)
        (by simpa [Def.inst] using hanc') (by simpa [Def.inst] using hsub') hbd had
  | block e ihe =>
    cases he with
    | block h hrb =>
      refine .block (ihe h) ?_
      rw [Ty.tsubst_regionsBelow hts]
      exact hrb
  | blockR t₀ e ihe =>
    cases he with
    | blockR h hr hrb =>
      refine .blockR (ihe h) (Ty.jumpRel_tsubst hts hr) ?_
      rw [Ty.tsubst_regionsBelow hts]
      exact hrb
  | copyTo k t₀ e ihe =>
    cases he with
    | copyTo h hk hr hrb hcf =>
      refine .copyTo (ihe h) hk (Ty.jumpRel_tsubst hts hr) ?_ ?_
      · rw [Ty.tsubst_regionsBelow hts]; exact hrb
      · rw [Ty.tsubst_chanFree hts]; exact hcf
  | label t e ihe =>
    cases he with
    | label h hrb =>
      refine .label (ihe h) ?_
      rw [Ty.tsubst_regionsBelow hts]
      exact hrb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe =>
    cases he with
    | jump hn h hr => exact .jump (by simp [hn]) (ihe h) (Ty.jumpRel_tsubst hts hr)
  | alloc m e ihe =>
    cases he with
    | alloc h hrb hbd hmf =>
      refine .alloc (ihe h) ?_ hbd ?_
      · rw [Ty.tsubst_regionsBelow hts]
        exact hrb
      · intro hm
        rw [Ty.tsubst_mutFree hts]
        exact hmf hm
  | deref e ihe => cases he with | deref h => exact .deref (ihe h)
  | assign l e ihl ihe =>
    cases he with | assign h1 h2 => exact .assign (ihl h1) (ihe h2)
  | whileE c body ihc ihb =>
    cases he with | whileE h1 h2 => exact .whileE (ihc h1) (ihb h2)
  | freeze e ihe =>
    cases he with
    | freeze h hm =>
      refine .freeze (ihe h) ?_
      rw [Ty.tsubst_mutFree hts]
      exact hm
    | freezes h hm =>
      refine .freezes (ihe h) ?_
      rw [Ty.tsubst_mutFree hts]
      exact hm
    | freezem h hm =>
      refine .freezem (ihe h) ?_
      rw [Ty.tsubst_mutFree hts]
      exact hm
  | mkslice m t =>
    cases he with
    | mkslice hrb hbd hmf =>
      refine .mkslice ?_ hbd ?_
      · rw [Ty.tsubst_regionsBelow hts]
        exact hrb
      · intro hm
        rw [Ty.tsubst_mutFree hts]
        exact hmf hm
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r =>
    cases he with
    | mksliceAt hrb hbr hrd hmf hcf =>
      refine .mksliceAt ?_ hbr hrd ?_ ?_
      · rw [Ty.tsubst_regionsBelow hts]; exact hrb
      · intro hm; rw [Ty.tsubst_mutFree hts]; exact hmf hm
      · rw [Ty.tsubst_chanFree hts]; exact hcf
  | mkmapAt m t r =>
    cases he with
    | mkmapAt hko hrb hbr hrd hmf hcf =>
      refine .mkmapAt (Ty.keyOk_tsubst ts hko) ?_ hbr hrd ?_ ?_
      · show Ty.regionsBelow _ (Ty.tsubst ts (.prod _ (.opt _))) = true
        rw [Ty.tsubst_regionsBelow hts]; exact hrb
      · intro hm
        show (Ty.tsubst ts (.prod _ (.opt _))).mutFree = true
        rw [Ty.tsubst_mutFree hts]; exact hmf hm
      · show (Ty.tsubst ts (.prod _ (.opt _))).chanFree = true
        rw [Ty.tsubst_chanFree hts]; exact hcf
  | index e i ot ihe ihi =>
    cases he with | index h1 h2 hrd => exact .index (ihe h1) (ihi h2) (Ty.readAs_tsubst hrd)
  | lenE e ihe => cases he with | lenE h => exact .lenE (ihe h)
  | tobyte e ihe => cases he with | tobyte h => exact .tobyte (ihe h)
  | fconv op e ihe => cases he with | fconv h => cases op <;> exact .fconv (ihe h)
  | toint e ihe => cases he with | toint h => exact .toint (ihe h)
  | append e v ihe ihv =>
    cases he with
    | appendM h1 h2 hbr => exact .appendM (ihe h1) (ihv h2) hbr
    | appendI h1 h2 hbd hbt => exact .appendI (ihe h1) (ihv h2) hbd (by rw [Ty.tsubst_regionsBelow hts]; exact hbt)
  | setidx e i v ihe ihi ihv =>
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe h1) (ihi h2) (ihv h3)
  | subslice e sa sb ihe iha ihb =>
    cases he with | subslice h1 h2 h3 => exact .subslice (ihe h1) (iha h2) (ihb h3)
  | eqs e1 e2 ih1 ih2 =>
    cases he with | eqs h1 h2 => exact .eqs (ih1 h1) (ih2 h2)
  | concat e1 e2 ih1 ih2 =>
    cases he with
    | concat h1 h2 hbd => exact .concat (ih1 h1) (ih2 h2) hbd
  | mkmap m t =>
    cases he with
    | mkmap hko hrb hbd hmf =>
      refine .mkmap (Ty.keyOk_tsubst ts hko) ?_ hbd ?_
      · show Ty.regionsBelow _ (Ty.tsubst ts (.prod _ (.opt _))) = true
        rw [Ty.tsubst_regionsBelow hts]
        exact hrb
      · intro hm
        show (Ty.tsubst ts (.prod _ (.opt _))).mutFree = true
        rw [Ty.tsubst_mutFree hts]
        exact hmf hm
  | getm t e k ihe ihk =>
    cases he with
    | getm h1 h2 hkc hsub => exact .getm (ihe h1) (ihk h2) (Ty.keyCompat_tsubst ts hkc) (Ty.sub_tsubst hsub)
  | setm e k v ihe ihk ihv =>
    cases he with | setm h1 h2 h3 => exact .setm (ihe h1) (ihk h2) (ihv h3)
  | delm t e k ihe ihk =>
    cases he with | delm h1 h2 hkc => exact .delm (ihe h1) (ihk h2) (Ty.keyCompat_tsubst ts hkc)
  | lenm e ihe => cases he with | lenm h => exact .lenm (ihe h)
  | keysm e ihe =>
    cases he with
    | keysm h hko hrb hbd =>
      exact .keysm (ihe h) (Ty.keyOk_tsubst ts hko) (by rw [Ty.tsubst_regionsBelow hts]; exact hrb) hbd
  | par e1 e2 ih1 ih2 =>
    cases he with
    | par h1 h2 hΓ =>
      refine .par (ih1 h1) (ih2 h2) ?_
      intro τ hτ
      obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
      rw [Ty.tsubst_mutFree hts]
      exact hΓ τ0 hτ0
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf =>
      refine .parch (ih1 h1) (ih2 h2) ?_ ?_ ?_
      · intro τ hτ
        obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
        rw [Ty.tsubst_mutFree hts]
        exact hΓ τ0 hτ0
      · rw [Ty.tsubst_regionsBelow hts]
        exact hrb
      · rw [Ty.tsubst_mutFree hts]
        exact hmf
  | newchan rc t =>
    cases he with
    | newchan hf hrb hmf =>
      refine .newchan hf ?_ ?_
      · rw [Ty.tsubst_regionsBelow hts]
        exact hrb
      · rw [Ty.tsubst_mutFree hts]
        exact hmf
  | send c e ihc ihe => cases he with
    | send h1 h2 => exact .send (ihc h1) (ihe h2)
    | sendE h1 h2 hp =>
      refine .sendE (ihc h1) (ihe h2) ?_
      simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at hp ⊢
      obtain ⟨⟨⟨⟨p1, p2⟩, p3⟩, p4⟩, p5⟩ := hp
      refine ⟨⟨⟨⟨by rw [Ty.tsubst_mutFree hts]; exact p1, by rw [Ty.tsubst_chanFree hts]; exact p2⟩,
        by rw [Ty.tsubst_mutFree hts]; exact p3⟩, by rw [Ty.tsubst_chanFree hts]; exact p4⟩, ?_⟩
      rw [Ty.tsubst_relocR hts, Ty.tsubst_relocR hts, p5]
  | recv c ihc => cases he with
    | recv h => exact .recv (ihc h)
    | recvE h hm hc =>
      simp only [Ty.tsubst]
      rw [← Ty.tsubst_relocR hts]
      exact .recvE (ihc h) (by rw [Ty.tsubst_mutFree hts]; exact hm) (by rw [Ty.tsubst_chanFree hts]; exact hc)
  | close c ihc => cases he with
    | closeE h => exact .closeE (ihc h)
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 => simp at h1
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4 h5 h6 h7 =>
      refine .slicev (fun k hkl => ?_) h2 h3 h4 h5 ?_ ?_
      · obtain ⟨σ, mk, tc, hσ, -⟩ := hk k hkl
        simp at hσ
      · intro hm
        rw [Ty.tsubst_mutFree hts]
        exact h6 hm
      · intro hm
        rw [Ty.tsubst_regionsBelow hts]
        exact h7 hm
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4 h5 h6 h7 =>
      refine .mapv (fun k hkl => ?_) h2 h3 h4 h5 ?_ ?_
      · obtain ⟨σ, mk, tc, hσ, -⟩ := hk k hkl
        simp at hσ
      · intro hm
        rw [Ty.tsubst_mutFree hts]
        exact h6 hm
      · intro hm
        rw [Ty.tsubst_regionsBelow hts]
        exact h7 hm
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 => simp at h1
  | scope t εs e ihe =>
    cases he with
    | scope h hr hrb hem hec hbd =>
      have h' := ihe h
      simp only [List.map_cons, List.map_nil, Ty.tsubst] at h'
      simp only [Ty.tsubst, Expr.tsubstTy]
      rw [← Ty.tsubst_relocR hts]
      refine .scope h' (Ty.jumpRel_tsubst hts hr) ?_ (by rw [Ty.tsubst_mutFree hts]; exact hem) (by rw [Ty.tsubst_chanFree hts]; exact hec) hbd
      rw [Ty.tsubst_regionsBelow hts]
      exact hrb
  | spawn sc a e ihsc iha ihe =>
    cases he with
    | spawn h1 ha hg h2 hrb hcf hε =>
      have h1' := ihsc h1
      simp only [Ty.tsubst] at h1'
      have h2' := ihe h2
      simp only [List.map_cons, List.map_nil, Ty.rehome_tsubst hts] at h2'
      simp only [Ty.tsubst, Expr.tsubstTy]
      rw [← Ty.tsubst_relocR hts]
      refine .spawn h1' (iha ha) (by rw [Ty.givable_tsubst hts]; exact hg) h2' ?_ ?_ ?_
      · simpa [Ty.mutFree, Ty.tsubst_mutFree hts] using hrb
      · simpa [Ty.chanFree, Ty.tsubst_chanFree hts] using hcf
      · simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at hε ⊢
        obtain ⟨⟨⟨⟨p1, p2⟩, p3⟩, p4⟩, p5⟩ := hε
        refine ⟨⟨⟨⟨by rw [Ty.tsubst_mutFree hts]; exact p1, by rw [Ty.tsubst_chanFree hts]; exact p2⟩,
          by rw [Ty.tsubst_mutFree hts]; exact p3⟩, by rw [Ty.tsubst_chanFree hts]; exact p4⟩, ?_⟩
        rw [Ty.tsubst_relocR hts, Ty.tsubst_relocR hts, p5]
  | join tj h ihh =>
    cases he with
    | join h1 =>
      have h1' := ihh h1
      simp only [Ty.tsubst] at h1'
      exact .join h1'
  | tryJ t h ihh =>
    cases he with
    | tryJ h1 =>
      have h1' := ihh h1
      simp only [Ty.tsubst] at h1'
      exact .tryJ h1'
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => simp at h3
  | newch r cap t₀ =>
    cases he with
    | newch h1 h2 h3 h4 h5 h6 =>
      simp only [Expr.tsubstTy, Ty.tsubst]
      exact .newch h1 h2 h3 (by rw [Ty.tsubst_mutFree hts]; exact h4) (by rw [Ty.tsubst_chanFree hts]; exact h5)
        (by rw [Ty.tsubst_regionsBelow hts]; exact h6)
  | epV p k b r => cases he <;> simp_all

end HasType

/-- 呼び出し点のインスタンス化は DefsOk の各条件を保つ: 仮想 Def `dfn.inst ts` は
単相の Def と同じく base の世界で型付き・境界条件つき（preservation の callK が使う形） -/
theorem defsOk_inst {Δ : Defs} (hΔ : DefsOk Δ) {fn : Nat} {dfn : Def} {ts : List Ty}
    (hfn : Δ[fn]? = some dfn) (hts : Ty.tyArgsOk ts = true) :
    (dfn.inst ts).param.paramOk = true ∧ (dfn.inst ts).ret.retOk = true ∧
    (dfn.inst ts).body.noNewchan = true ∧ (dfn.inst ts).body.src = true ∧
    HasType Δ ∅ [] 1 0 2 [(dfn.inst ts).param] [] (dfn.inst ts).body (dfn.inst ts).ret := by
  obtain ⟨hp, hr, hnc, -, -, hsrc, hbody⟩ := hΔ fn dfn hfn
  refine ⟨?_, Ty.tsubst_retOk hts hr, ?_, ?_, ?_⟩
  · simp only [Def.inst, Ty.tsubst_paramOk hts]; exact hp
  · simp only [Def.inst, Expr.noNewchan_tsubstTy]; exact hnc
  · simp only [Def.inst, Expr.src_tsubstTy]; exact hsrc
  · have := HasType.tsubst_typing hΔ.wf hts hbody
    simpa [Def.inst] using this

end FS
