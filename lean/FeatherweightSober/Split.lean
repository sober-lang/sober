import FeatherweightSober.Checker

/-!
# package 単位の検査の合成（V5-6 = I-3、language.md 29 節「コンパイル単位 = package」）

分割コンパイルでは、package P の Def の本体を検査するとき、他の package の Def は interface（`.sobi`）から
読んだ**署名だけ**しか無い。これが全体の検査（DefsOk）と同じ結論を出すことの中身は 2 つ:

1. **型付けは関数表の署名しか見ない**（`hasType_sigEq`）: HasType が Δ を読むのは call / fnref の
   `Δ[fn]?` だけで、そこでも param / ret / tparams しか使わない。したがって署名の一致する表の間で型付けは移る
2. **合成**（`defsOk_of_parts`）: 関数表の添字を部分に割り、各部分を「自分の Def は本物・他は署名が同じ任意の Def」の
   表の下で checkDefsAt が受理すれば、全体の DefsOk が成り立つ

署名だけの Def（JSON では body を持たない Def）は、ここでは本体を任意に置いた Def として現れる — 検査されないので
何を置いてもよい（`Def.sig` は triv を置く）。機械は実行しない（sober-check は検査だけ）。
-/
namespace FS

/-- 署名（本体を落とした Def）。型付けが関数表から読むのはこれだけ -/
def Def.sig (d : Def) : Def := { d with body := .triv }

/-- 2 つの関数表の署名が添字ごとに一致する -/
def SigEq (Δ Δ' : Defs) : Prop := Δ.map Def.sig = Δ'.map Def.sig

theorem SigEq.symm {Δ Δ' : Defs} (h : SigEq Δ Δ') : SigEq Δ' Δ := Eq.symm h

theorem SigEq.lookup {Δ Δ' : Defs} (h : SigEq Δ Δ') {fn : Nat} {dfn : Def} (hf : Δ[fn]? = some dfn) :
    ∃ dfn', Δ'[fn]? = some dfn' ∧ dfn'.param = dfn.param ∧ dfn'.ret = dfn.ret ∧
      dfn'.tparams = dfn.tparams := by
  have hc := congrArg (fun l : List Def => l[fn]?) h
  simp only [List.getElem?_map, hf, Option.map_some] at hc
  cases hd : Δ'[fn]? with
  | none => simp [hd] at hc
  | some dfn' =>
    simp only [hd, Option.map_some, Option.some.injEq] at hc
    refine ⟨dfn', rfl, ?_, ?_, ?_⟩
    · exact (congrArg Def.param hc).symm
    · exact (congrArg Def.ret hc).symm
    · exact (congrArg Def.tparams hc).symm

theorem Def.inst_param_congr {d d' : Def} (h : d'.param = d.param) (ts : List Ty) :
    (d'.inst ts).param = (d.inst ts).param := by simp [Def.inst, h]

theorem Def.inst_ret_congr {d d' : Def} (h : d'.ret = d.ret) (ts : List Ty) :
    (d'.inst ts).ret = (d.inst ts).ret := by simp [Def.inst, h]

/-- 型付けは関数表の署名しか見ない -/
theorem hasType_sigEq {Δ Δ' : Defs} (hs : SigEq Δ Δ') {Ξ Ψ f b d Γ Λ e t}
    (h : HasType Δ Ξ Ψ f b d Γ Λ e t) : HasType Δ' Ξ Ψ f b d Γ Λ e t := by
  induction h
  case call hf hlen hok _ hsub hbd ih =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hs.lookup hf
    rw [← Def.inst_ret_congr hr]
    rw [← Def.inst_param_congr hp] at hsub
    exact HasType.call hf' (htp ▸ hlen) hok ih hsub hbd
  case callM hf hlen hok _ hanc hsub hbd had ih =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hs.lookup hf
    rw [← Def.inst_ret_congr hr]
    rw [← Def.inst_param_congr hp] at hsub hanc
    exact HasType.callM hf' (htp ▸ hlen) hok ih hanc hsub hbd had
  case fnref hf hlen hok =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hs.lookup hf
    rw [← Def.inst_ret_congr hr, ← Def.inst_param_congr hp]
    exact HasType.fnref hf' (htp ▸ hlen) hok
  case sendE hp ih1 ih2 => exact .sendE ih1 ih2 hp
  case recvE hm hc ih => exact .recvE ih hm hc
  case closeE ih => exact .closeE ih
  all_goals (constructor <;> assumption)

namespace Expr

/-- 関数表の添字の付け替え（リンク時の再配置）: call / fnref の添字だけを ρ で写す。
視点の表（`.sobi` が落とした非公開関数・他 package の持ち上げが無い）の添字を、全体の表の添字へ写す -/
def renameFn (ρ : Nat → Nat) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => var i
  | letE e b => letE (renameFn ρ e) (renameFn ρ b)
  | add a b => add (renameFn ρ a) (renameFn ρ b)
  | lt a b => lt (renameFn ρ a) (renameFn ρ b)
  | arith op a b => arith op (renameFn ρ a) (renameFn ρ b)
  | farith op a b => farith op (renameFn ρ a) (renameFn ρ b)
  | cmp op a b => cmp op (renameFn ρ a) (renameFn ρ b)
  | fcmp op a b => fcmp op (renameFn ρ a) (renameFn ρ b)
  | ite c t e => ite (renameFn ρ c) (renameFn ρ t) (renameFn ρ e)
  | nil t => nil t
  | some e => some (renameFn ρ e)
  | ifnil e n s => ifnil (renameFn ρ e) (renameFn ρ n) (renameFn ρ s)
  | inl r e => inl r (renameFn ρ e)
  | inr l e => inr l (renameFn ρ e)
  | case e l r => case (renameFn ρ e) (renameFn ρ l) (renameFn ρ r)
  | pair a b => pair (renameFn ρ a) (renameFn ρ b)
  | fst e => fst (renameFn ρ e)
  | snd e => snd (renameFn ρ e)
  | call fn ts' e => call (ρ fn) ts' (renameFn ρ e)
  | callM fn ts' e => callM (ρ fn) ts' (renameFn ρ e)
  | fnref fn ts' => fnref (ρ fn) ts'
  | callv f e => callv (renameFn ρ f) (renameFn ρ e)
  | callMv a f e => callMv a (renameFn ρ f) (renameFn ρ e)
  | ann e t => ann (renameFn ρ e) t
  | block e => block (renameFn ρ e)
  | blockR t e => blockR t (renameFn ρ e)
  | copyTo k t e => copyTo k t (renameFn ρ e)
  | label t e => label t (renameFn ρ e)
  | jump n t e => jump n t (renameFn ρ e)
  | unreach t => unreach t
  | alloc m e => alloc m (renameFn ρ e)
  | deref e => deref (renameFn ρ e)
  | assign l e => assign (renameFn ρ l) (renameFn ρ e)
  | whileE c b => whileE (renameFn ρ c) (renameFn ρ b)
  | freeze e => freeze (renameFn ρ e)
  | mkslice m t => mkslice m t
  | strlit bs r => strlit bs r
  | mksliceAt m t r => mksliceAt m t r
  | mkmapAt m t r => mkmapAt m t r
  | index e i ot => index (renameFn ρ e) (renameFn ρ i) ot
  | lenE e => lenE (renameFn ρ e)
  | tobyte e => tobyte (renameFn ρ e)
  | fconv op e => fconv op (renameFn ρ e)
  | toint e => toint (renameFn ρ e)
  | append e w => append (renameFn ρ e) (renameFn ρ w)
  | setidx e i w => setidx (renameFn ρ e) (renameFn ρ i) (renameFn ρ w)
  | subslice e sa sb => subslice (renameFn ρ e) (renameFn ρ sa) (renameFn ρ sb)
  | eqs e1 e2 => eqs (renameFn ρ e1) (renameFn ρ e2)
  | concat e1 e2 => concat (renameFn ρ e1) (renameFn ρ e2)
  | mkmap m t => mkmap m t
  | getm t e k => getm t (renameFn ρ e) (renameFn ρ k)
  | setm e k w => setm (renameFn ρ e) (renameFn ρ k) (renameFn ρ w)
  | delm t e k => delm t (renameFn ρ e) (renameFn ρ k)
  | lenm e => lenm (renameFn ρ e)
  | keysm e => keysm (renameFn ρ e)
  | clone ot e => clone ot (renameFn ρ e)
  | par e1 e2 => par (renameFn ρ e1) (renameFn ρ e2)
  | parch t e1 e2 => parch t (renameFn ρ e1) (renameFn ρ e2)
  | newchan rc t => newchan rc t
  | send c e => send (renameFn ρ c) (renameFn ρ e)
  | recv c => recv (renameFn ρ c)
  | close c => close (renameFn ρ c)
  | loc r a => loc r a
  | slicev mt r base len => slicev mt r base len
  | mapv mt r base len => mapv mt r base len
  | chanV c => chanV c
  | scope t ε e => scope t ε (renameFn ρ e)
  | spawn sc a e => spawn (renameFn ρ sc) (renameFn ρ a) (renameFn ρ e)
  | join t h => join t (renameFn ρ h)
  | tryJ t h => tryJ t (renameFn ρ h)
  | scopeV rs ε => scopeV rs ε
  | taskV rs n => taskV rs n
  | newch r cap t => newch r cap t
  | epV p k b r => epV p k b r

end Expr

theorem Expr.noNewchan_renameFn (ρ : Nat → Nat) (e : Expr) :
    (e.renameFn ρ).noNewchan = e.noNewchan := by
  induction e <;> simp_all [Expr.renameFn, Expr.noNewchan]

theorem Expr.src_renameFn (ρ : Nat → Nat) (e : Expr) :
    (e.renameFn ρ).src = e.src := by
  induction e <;> simp_all [Expr.renameFn, Expr.src]

/-- 視点の表 Δv の添字 i を全体の表 Δ の添字 ρ i へ写したとき署名が保たれる -/
def SigMap (Δv Δ : Defs) (ρ : Nat → Nat) : Prop :=
  ∀ (i : Nat) (dv : Def), Δv[i]? = some dv →
    ∃ d, Δ[ρ i]? = some d ∧ d.param = dv.param ∧ d.ret = dv.ret ∧ d.tparams = dv.tparams

/-- 型付けは添字の付け替えで移る（署名が保たれる限り）— hasType_sigEq の一般化 -/
theorem hasType_rename {Δv Δ : Defs} {ρ : Nat → Nat} (hm : SigMap Δv Δ ρ) {Ξ Ψ f b d Γ Λ e t}
    (h : HasType Δv Ξ Ψ f b d Γ Λ e t) : HasType Δ Ξ Ψ f b d Γ Λ (e.renameFn ρ) t := by
  induction h
  case call hf hlen hok _ hsub hbd ih =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hm _ _ hf
    rw [← Def.inst_ret_congr hr]
    rw [← Def.inst_param_congr hp] at hsub
    exact HasType.call hf' (htp ▸ hlen) hok ih hsub hbd
  case callM hf hlen hok _ hanc hsub hbd had ih =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hm _ _ hf
    rw [← Def.inst_ret_congr hr]
    rw [← Def.inst_param_congr hp] at hsub hanc
    exact HasType.callM hf' (htp ▸ hlen) hok ih hanc hsub hbd had
  case fnref hf hlen hok =>
    obtain ⟨dfn', hf', hp, hr, htp⟩ := hm _ _ hf
    simp only [Expr.renameFn]
    rw [← Def.inst_ret_congr hr, ← Def.inst_param_congr hp]
    exact HasType.fnref hf' (htp ▸ hlen) hok
  case sendE hp ih1 ih2 => simp only [Expr.renameFn]; exact .sendE ih1 ih2 hp
  case recvE hm hc ih => simp only [Expr.renameFn]; exact .recvE ih hm hc
  case closeE ih => simp only [Expr.renameFn]; exact .closeE ih
  all_goals (simp only [Expr.renameFn]; constructor <;> assumption)

/-- 部分検査: 述語 S が立つ添字の Def だけを checkDefs と同じ条件で検査する（他は署名だけの枠） -/
def checkDefsAt (Δ : Defs) (S : Nat → Bool) : Bool :=
  (List.range Δ.length).all fun i =>
    !S i || match Δ[i]? with
      | some dfn => Ty.paramOk dfn.param && Ty.retOk dfn.ret &&
          dfn.body.noNewchan &&
          dfn.param.tvarsBelow dfn.tparams && dfn.ret.tvarsBelow dfn.tparams && dfn.body.src &&
          (typecheck Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body == some dfn.ret)
      | none => true

/-- 部分検査が受理した添字の Def は、署名の一致する任意の表（全体の表）の下で DefsOk の条件を満たす -/
theorem defOk_of_checkAt {Δv Δ : Defs} {S : Nat → Bool} (hc : checkDefsAt Δv S = true)
    (hs : SigEq Δv Δ) {fn : Nat} (hS : S fn = true) {dfn : Def} (hv : Δv[fn]? = some dfn) :
    dfn.param.paramOk = true ∧ dfn.ret.retOk = true ∧ dfn.body.noNewchan = true ∧
      dfn.param.tvarsBelow dfn.tparams = true ∧ dfn.ret.tvarsBelow dfn.tparams = true ∧
      dfn.body.src = true ∧ HasType Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body dfn.ret := by
  have hlt : fn < Δv.length := (List.getElem?_eq_some_iff.mp hv).1
  have := List.all_eq_true.mp hc fn (List.mem_range.mpr hlt)
  simp only [hS, Bool.not_true, Bool.false_or, hv, Bool.and_eq_true, beq_iff_eq] at this
  obtain ⟨⟨⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩, h6⟩, h7⟩ := this
  exact ⟨h1, h2, h3, h4, h5, h6, hasType_sigEq hs (typecheck_sound h7)⟩

/-- **合成**: 関数表 Δ の添字を部分に割る。各部分 k について、視点の表 Δv（自分の添字では Δ と同じ Def・
他は署名が同じ任意の Def）を部分検査が受理すれば、全体の DefsOk が成り立つ。
部分は「添字 → 担当の部分」の関数 part で与える（package ごとの分割 — 各添字はちょうど 1 つの部分に属する） -/
theorem defsOk_of_parts {Δ : Defs} {K : Nat} (part : Nat → Fin K) (views : Fin K → Defs)
    (hsig : ∀ k, SigEq (views k) Δ)
    (hown : ∀ fn, (views (part fn))[fn]? = Δ[fn]?)
    (hchk : ∀ k, checkDefsAt (views k) (fun i => decide (part i = k)) = true) :
    DefsOk Δ := by
  intro fn dfn hfn
  have hv : (views (part fn))[fn]? = some dfn := (hown fn).trans hfn
  exact defOk_of_checkAt (hchk (part fn)) (hsig (part fn)) (by simp) hv

/-- **リンクの合成**（分割コンパイルの実態に合わせた形）: package k の視点の表 views k は、自分の Def（本体つき・
S k が立つ添字）と、interface から読んだ他の署名だけを持つ — 全体の表とは添字が揃わない（`.sobi` が落とした非公開関数、
他 package の持ち上げたラムダが無い）。リンカが添字を ρ k で全体へ写し、全体の Def はどれも、ある視点の検査済みの Def の
本体を ρ k で付け替えたものになっている（hcover）。このとき各視点の部分検査の受理から、全体の DefsOk が出る -/
theorem defsOk_of_linked {Δ : Defs} {K : Nat} (views : Fin K → Defs) (ρ : Fin K → Nat → Nat)
    (S : Fin K → Nat → Bool)
    (hmap : ∀ k, SigMap (views k) Δ (ρ k))
    (hchk : ∀ k, checkDefsAt (views k) (S k) = true)
    (hcover : ∀ (fn : Nat) (dfn : Def), Δ[fn]? = some dfn → ∃ (k : Fin K) (i : Nat) (dv : Def), S k i = true ∧ (views k)[i]? = some dv ∧
      dfn = { dv with body := dv.body.renameFn (ρ k) }) :
    DefsOk Δ := by
  intro fn dfn hfn
  obtain ⟨k, i, dv, hS, hv, rfl⟩ := hcover fn dfn hfn
  obtain ⟨h1, h2, h3, h4, h5, h6, h7⟩ :=
    defOk_of_checkAt (Δ := views k) (hchk k) (show SigEq (views k) (views k) from rfl) hS hv
  refine ⟨h1, h2, ?_, h4, h5, ?_, hasType_rename (hmap k) h7⟩
  · simpa [Expr.noNewchan_renameFn] using h3
  · simpa [Expr.src_renameFn] using h6

/-- 1 部分なら checkDefs と同じ（健全性の確認用の系） -/
theorem defsOk_of_checkAt_all {Δ : Defs} (h : checkDefsAt Δ (fun _ => true) = true) : DefsOk Δ :=
  defsOk_of_parts (K := 1) (fun _ => 0) (fun _ => Δ) (fun _ => rfl) (fun _ => rfl)
    (fun k => by simpa [Fin.fin_one_eq_zero k] using h)

end FS
