/-!
# 実験2（shape-m0）: 辞書に従って値を読む操作の型安全性

本体のLean（lean/FeatherweightSober）とは別の小さな体系。型は int・string・unit・直積（structは右結合の入れ子）だけ。

- `shapeOf t`（`shape[T]` に当たる）: 型 t の形の定数。型は `shape t`。形の値（Sh）は型からしか作れない
- `pack v s`: 値と、その型の形を組にする。型は `dyn`（中の型を隠す）
- 読みのop: kind・asInt・asStr・hd・tl。どれも全域（形が合わないときは既定値の式を評価する）。結果の型は辞書の値に依らない
- ジェネリック関数（tparams 個の型変数）は呼び出しで型引数を受け、評価は型引数を環境に持って `shapeOf` を具体化する（単相コピーと同じ観測）

定理 `sound`: 型の付いた式を燃料つきの評価器で評価すると、stuck にならず、結果の値は型に合う。
-/
namespace Shape0

inductive Ty where
  | int
  | str
  | unit
  | prod (l r : Ty)
  | dyn
  | shape (t : Ty)
  | tvar (i : Nat)
  deriving DecidableEq, Repr

/-- 形（辞書の値）: データの型の木 -/
inductive Sh where
  | int
  | str
  | unit
  | prod (a b : Sh)
  deriving DecidableEq, Repr

def Sh.code : Sh → Int
  | .int => 0
  | .str => 1
  | .unit => 2
  | .prod _ _ => 3

def Ty.sh : Ty → Option Sh
  | .int => some .int
  | .str => some .str
  | .unit => some .unit
  | .prod l r =>
    match l.sh, r.sh with
    | some a, some b => some (.prod a b)
    | _, _ => none
  | .dyn => none
  | .shape _ => none
  | .tvar _ => none

def Ty.tsubst (ts : List Ty) : Ty → Ty
  | .int => .int
  | .str => .str
  | .unit => .unit
  | .prod l r => .prod (l.tsubst ts) (r.tsubst ts)
  | .dyn => .dyn
  | .shape t => .shape (t.tsubst ts)
  | .tvar i => (ts[i]?).getD (.tvar i)

/-- データの型（形を持つ型）か、n 未満の型変数。`shapeOf` と型引数の条件 -/
def Ty.dataOk (n : Nat) : Ty → Bool
  | .int => true
  | .str => true
  | .unit => true
  | .prod l r => l.dataOk n && r.dataOk n
  | .dyn => false
  | .shape _ => false
  | .tvar i => decide (i < n)

def Ty.tvarsBelow (n : Nat) : Ty → Bool
  | .prod l r => l.tvarsBelow n && r.tvarsBelow n
  | .shape t => t.tvarsBelow n
  | .tvar i => decide (i < n)
  | _ => true

inductive Val where
  | int (n : Int)
  | str (s : String)
  | unit
  | pair (a b : Val)
  | dyn (v : Val) (s : Sh)
  | shp (s : Sh)
  deriving Repr

inductive VTy : Val → Ty → Prop where
  | int (n : Int) : VTy (.int n) .int
  | str (s : String) : VTy (.str s) .str
  | unit : VTy .unit .unit
  | pair {a b : Val} {l r : Ty} : VTy a l → VTy b r → VTy (.pair a b) (.prod l r)
  | dyn {v : Val} {t : Ty} {s : Sh} : VTy v t → t.sh = some s → VTy (.dyn v s) .dyn
  | shp {t : Ty} {s : Sh} : t.sh = some s → VTy (.shp s) (.shape t)

inductive Expr where
  | var
  | lit (n : Int)
  | slit (s : String)
  | triv
  | pair (a b : Expr)
  | fst (e : Expr)
  | snd (e : Expr)
  | add (a b : Expr)
  | cat (a b : Expr)
  | itos (e : Expr)
  | ifz (c a b : Expr)
  | shapeOf (t : Ty)
  | pack (v s : Expr)
  | kind (d : Expr)
  | asInt (d dflt : Expr)
  | asStr (d dflt : Expr)
  | hd (d dflt : Expr)
  | tl (d dflt : Expr)
  | call (f : Nat) (ts : List Ty) (e : Expr)
  deriving Repr

structure Def where
  tparams : Nat
  param : Ty
  ret : Ty
  body : Expr

abbrev Defs := List Def

/-- 型付け: n = 型変数の数・Γ = 仮引数（var）の型 -/
inductive HasTy (Δ : Defs) (n : Nat) (Γ : Ty) : Expr → Ty → Prop where
  | var : HasTy Δ n Γ .var Γ
  | lit (k : Int) : HasTy Δ n Γ (.lit k) .int
  | slit (s : String) : HasTy Δ n Γ (.slit s) .str
  | triv : HasTy Δ n Γ .triv .unit
  | pair {a b : Expr} {l r : Ty} : HasTy Δ n Γ a l → HasTy Δ n Γ b r → HasTy Δ n Γ (.pair a b) (.prod l r)
  | fst {e : Expr} {l r : Ty} : HasTy Δ n Γ e (.prod l r) → HasTy Δ n Γ (.fst e) l
  | snd {e : Expr} {l r : Ty} : HasTy Δ n Γ e (.prod l r) → HasTy Δ n Γ (.snd e) r
  | add {a b : Expr} : HasTy Δ n Γ a .int → HasTy Δ n Γ b .int → HasTy Δ n Γ (.add a b) .int
  | cat {a b : Expr} : HasTy Δ n Γ a .str → HasTy Δ n Γ b .str → HasTy Δ n Γ (.cat a b) .str
  | itos {e : Expr} : HasTy Δ n Γ e .int → HasTy Δ n Γ (.itos e) .str
  | ifz {c a b : Expr} {t : Ty} : HasTy Δ n Γ c .int → HasTy Δ n Γ a t → HasTy Δ n Γ b t → HasTy Δ n Γ (.ifz c a b) t
  | shapeOf {t : Ty} : t.dataOk n = true → HasTy Δ n Γ (.shapeOf t) (.shape t)
  | pack {v s : Expr} {t : Ty} : HasTy Δ n Γ v t → HasTy Δ n Γ s (.shape t) → HasTy Δ n Γ (.pack v s) .dyn
  | kind {d : Expr} : HasTy Δ n Γ d .dyn → HasTy Δ n Γ (.kind d) .int
  | asInt {d f : Expr} : HasTy Δ n Γ d .dyn → HasTy Δ n Γ f .int → HasTy Δ n Γ (.asInt d f) .int
  | asStr {d f : Expr} : HasTy Δ n Γ d .dyn → HasTy Δ n Γ f .str → HasTy Δ n Γ (.asStr d f) .str
  | hd {d f : Expr} : HasTy Δ n Γ d .dyn → HasTy Δ n Γ f .dyn → HasTy Δ n Γ (.hd d f) .dyn
  | tl {d f : Expr} : HasTy Δ n Γ d .dyn → HasTy Δ n Γ f .dyn → HasTy Δ n Γ (.tl d f) .dyn
  | call {f : Nat} {us : List Ty} {e : Expr} {dfn : Def} :
      Δ[f]? = some dfn → us.length = dfn.tparams → us.all (Ty.dataOk n) = true →
      HasTy Δ n Γ e (dfn.param.tsubst us) → HasTy Δ n Γ (.call f us e) (dfn.ret.tsubst us)

def DefsOk (Δ : Defs) : Prop :=
  ∀ dfn ∈ Δ, HasTy Δ dfn.tparams dfn.param dfn.body dfn.ret ∧
    dfn.param.tvarsBelow dfn.tparams = true ∧ dfn.ret.tvarsBelow dfn.tparams = true

inductive Res where
  | ok (v : Val)
  | stuck
  | out
  deriving Repr

def Res.bind : Res → (Val → Res) → Res
  | .ok v, f => f v
  | .stuck, _ => .stuck
  | .out, _ => .out

/-- 燃料つきの評価器。ts = 型引数（具体の型）・env = 仮引数の値 -/
def eval : Nat → Defs → List Ty → Val → Expr → Res
  | 0, _, _, _, _ => .out
  | n + 1, Δ, ts, env, e =>
    match e with
    | .var => .ok env
    | .lit k => .ok (.int k)
    | .slit s => .ok (.str s)
    | .triv => .ok .unit
    | .pair a b =>
      (eval n Δ ts env a).bind fun va => (eval n Δ ts env b).bind fun vb => .ok (.pair va vb)
    | .fst e => (eval n Δ ts env e).bind fun v =>
      match v with
      | .pair a _ => .ok a
      | _ => .stuck
    | .snd e => (eval n Δ ts env e).bind fun v =>
      match v with
      | .pair _ b => .ok b
      | _ => .stuck
    | .add a b => (eval n Δ ts env a).bind fun va => (eval n Δ ts env b).bind fun vb =>
      match va, vb with
      | .int x, .int y => .ok (.int (x + y))
      | _, _ => .stuck
    | .cat a b => (eval n Δ ts env a).bind fun va => (eval n Δ ts env b).bind fun vb =>
      match va, vb with
      | .str x, .str y => .ok (.str (x ++ y))
      | _, _ => .stuck
    | .itos e => (eval n Δ ts env e).bind fun v =>
      match v with
      | .int x => .ok (.str (toString x))
      | _ => .stuck
    | .ifz c a b => (eval n Δ ts env c).bind fun vc =>
      match vc with
      | .int x => if x = 0 then eval n Δ ts env a else eval n Δ ts env b
      | _ => .stuck
    | .shapeOf t =>
      match (t.tsubst ts).sh with
      | some s => .ok (.shp s)
      | none => .stuck
    | .pack v s => (eval n Δ ts env v).bind fun vv => (eval n Δ ts env s).bind fun vs =>
      match vs with
      | .shp sh => .ok (.dyn vv sh)
      | _ => .stuck
    | .kind d => (eval n Δ ts env d).bind fun vd =>
      match vd with
      | .dyn _ s => .ok (.int s.code)
      | _ => .stuck
    | .asInt d f => (eval n Δ ts env d).bind fun vd =>
      match vd with
      | .dyn (.int m) _ => .ok (.int m)
      | .dyn _ _ => eval n Δ ts env f
      | _ => .stuck
    | .asStr d f => (eval n Δ ts env d).bind fun vd =>
      match vd with
      | .dyn (.str m) _ => .ok (.str m)
      | .dyn _ _ => eval n Δ ts env f
      | _ => .stuck
    | .hd d f => (eval n Δ ts env d).bind fun vd =>
      match vd with
      | .dyn (.pair a _) (.prod sa _) => .ok (.dyn a sa)
      | .dyn _ _ => eval n Δ ts env f
      | _ => .stuck
    | .tl d f => (eval n Δ ts env d).bind fun vd =>
      match vd with
      | .dyn (.pair _ b) (.prod _ sb) => .ok (.dyn b sb)
      | .dyn _ _ => eval n Δ ts env f
      | _ => .stuck
    | .call f us e => (eval n Δ ts env e).bind fun v =>
      match Δ[f]? with
      | some dfn => eval n Δ (us.map (Ty.tsubst ts)) v dfn.body
      | none => .stuck

/-- 結果の良さ: ok なら型に合う・stuck にならない・燃料切れは問わない -/
def Good : Res → Ty → Prop
  | .ok v, t => VTy v t
  | .stuck, _ => False
  | .out, _ => True

theorem Good.bind {r : Res} {t t' : Ty} {f : Val → Res} (h : Good r t)
    (hf : ∀ v, VTy v t → Good (f v) t') : Good (r.bind f) t' := by
  cases r with
  | ok v => exact hf v h
  | stuck => exact h.elim
  | out => trivial

/-! ## 補題 -/

theorem VTy.int_inv {v : Val} (h : VTy v .int) : ∃ m, v = .int m := by
  cases h; exact ⟨_, rfl⟩

theorem VTy.str_inv {v : Val} (h : VTy v .str) : ∃ m, v = .str m := by
  cases h; exact ⟨_, rfl⟩

theorem VTy.prod_inv {v : Val} {l r : Ty} (h : VTy v (.prod l r)) :
    ∃ a b, v = .pair a b ∧ VTy a l ∧ VTy b r := by
  cases h with
  | pair ha hb => exact ⟨_, _, rfl, ha, hb⟩

theorem VTy.pair_inv {a b : Val} {t : Ty} (h : VTy (.pair a b) t) :
    ∃ l r, t = .prod l r ∧ VTy a l ∧ VTy b r := by
  cases h with
  | pair ha hb => exact ⟨_, _, rfl, ha, hb⟩

theorem VTy.dyn_inv {v : Val} (h : VTy v .dyn) : ∃ w t s, v = .dyn w s ∧ VTy w t ∧ t.sh = some s := by
  cases h with
  | dyn hw hs => exact ⟨_, _, _, rfl, hw, hs⟩

theorem VTy.shape_inv {v : Val} {t : Ty} (h : VTy v (.shape t)) : ∃ s, v = .shp s ∧ t.sh = some s := by
  cases h with
  | shp hs => exact ⟨_, rfl, hs⟩

theorem Ty.sh_prod {l r : Ty} {sa sb : Sh} (h : (Ty.prod l r).sh = some (.prod sa sb)) :
    l.sh = some sa ∧ r.sh = some sb := by
  simp only [Ty.sh] at h
  cases hl : l.sh <;> cases hr : r.sh <;> simp_all

theorem Ty.sh_of_data : ∀ {t : Ty}, t.dataOk 0 = true → ∃ s, t.sh = some s
  | .int, _ => ⟨_, rfl⟩
  | .str, _ => ⟨_, rfl⟩
  | .unit, _ => ⟨_, rfl⟩
  | .prod l r, h => by
    simp only [Ty.dataOk, Bool.and_eq_true] at h
    obtain ⟨a, ha⟩ := Ty.sh_of_data h.1
    obtain ⟨b, hb⟩ := Ty.sh_of_data h.2
    exact ⟨.prod a b, by simp [Ty.sh, ha, hb]⟩
  | .dyn, h => by simp [Ty.dataOk] at h
  | .shape _, h => by simp [Ty.dataOk] at h
  | .tvar _, h => by simp [Ty.dataOk] at h

theorem Ty.dataOk_tsubst {k : Nat} {ts : List Ty} (hk : ts.length = k) (hts : ts.all (Ty.dataOk 0) = true) :
    ∀ {t : Ty}, t.dataOk k = true → (t.tsubst ts).dataOk 0 = true
  | .int, _ => rfl
  | .str, _ => rfl
  | .unit, _ => rfl
  | .prod l r, h => by
    simp only [Ty.dataOk, Bool.and_eq_true] at h
    simp only [Ty.tsubst, Ty.dataOk, Bool.and_eq_true]
    exact ⟨Ty.dataOk_tsubst hk hts h.1, Ty.dataOk_tsubst hk hts h.2⟩
  | .dyn, h => by simp [Ty.dataOk] at h
  | .shape _, h => by simp [Ty.dataOk] at h
  | .tvar i, h => by
    simp only [Ty.dataOk, decide_eq_true_eq] at h
    have hi : i < ts.length := hk ▸ h
    simp only [Ty.tsubst, List.getElem?_eq_getElem hi, Option.getD_some]
    exact List.all_eq_true.1 hts _ (List.getElem_mem hi)

theorem Ty.tsubst_comp {us ts : List Ty} :
    ∀ {t : Ty}, t.tvarsBelow us.length = true → (t.tsubst us).tsubst ts = t.tsubst (us.map (Ty.tsubst ts))
  | .int, _ => rfl
  | .str, _ => rfl
  | .unit, _ => rfl
  | .dyn, _ => rfl
  | .prod l r, h => by
    simp only [Ty.tvarsBelow, Bool.and_eq_true] at h
    simp [Ty.tsubst, Ty.tsubst_comp h.1, Ty.tsubst_comp h.2]
  | .shape t, h => by
    simp only [Ty.tvarsBelow] at h
    simp [Ty.tsubst, Ty.tsubst_comp h]
  | .tvar i, h => by
    simp only [Ty.tvarsBelow, decide_eq_true_eq] at h
    simp [Ty.tsubst, List.getElem?_eq_getElem h]

/-! ## 既定値の分岐の到達条件

dyn の値の不変条件（VTy.dyn）: `dyn w s` なら、ある型 t があって w : t かつ t の形 = s。
そこから、読みの op が既定値の分岐へ進むのは「形が合わないとき」だけになる。つまり、実装は値の側を見ずに、形 s だけを見て分岐してよい。
形 s が定数なら（単相コピーの中の shape[T]）、この分岐は定数で畳める -/

/-- 形が int なら値は int（asInt は既定値の分岐へ進まない） -/
theorem VTy.dyn_int {w : Val} (h : VTy (.dyn w .int) .dyn) : ∃ m, w = .int m := by
  cases h with
  | dyn hw hs =>
    rename_i t
    cases hw <;> simp_all [Ty.sh]
    all_goals (rename_i l r _ _; cases hl : l.sh <;> cases hr : r.sh <;> simp_all)

/-- 形が str なら値は str -/
theorem VTy.dyn_str {w : Val} (h : VTy (.dyn w .str) .dyn) : ∃ m, w = .str m := by
  cases h with
  | dyn hw hs =>
    rename_i t
    cases hw <;> simp_all [Ty.sh]
    all_goals (rename_i l r _ _; cases hl : l.sh <;> cases hr : r.sh <;> simp_all)

/-- 形が直積なら値は組（hd・tl は既定値の分岐へ進まない） -/
theorem VTy.dyn_prod {w : Val} {sa sb : Sh} (h : VTy (.dyn w (.prod sa sb)) .dyn) : ∃ a b, w = .pair a b := by
  cases h with
  | dyn hw hs =>
    cases hw <;> simp_all [Ty.sh]

/-! ## 健全性 -/

theorem sound {Δ : Defs} (hΔ : DefsOk Δ) : ∀ (fuel : Nat) {k : Nat} {Γ : Ty} {e : Expr} {t : Ty}
    {ts : List Ty} {env : Val},
    HasTy Δ k Γ e t → ts.length = k → ts.all (Ty.dataOk 0) = true → VTy env (Γ.tsubst ts) →
    Good (eval fuel Δ ts env e) (t.tsubst ts)
  | 0, _, _, _, _, _, _, _, _, _, _ => trivial
  | n + 1, k, Γ, e, t, ts, env, h, hk, hts, henv => by
    have ih : ∀ {e' : Expr} {t' : Ty}, HasTy Δ k Γ e' t' → Good (eval n Δ ts env e') (t'.tsubst ts) :=
      fun h' => sound hΔ n h' hk hts henv
    cases h with
    | var => exact henv
    | lit _ => exact VTy.int _
    | slit _ => exact VTy.str _
    | triv => exact VTy.unit
    | pair ha hb =>
      exact Good.bind (ih ha) fun va hva => Good.bind (ih hb) fun vb hvb => VTy.pair hva hvb
    | fst he =>
      refine Good.bind (ih he) fun v hv => ?_
      obtain ⟨a, b, rfl, ha, _⟩ := VTy.prod_inv hv
      exact ha
    | snd he =>
      refine Good.bind (ih he) fun v hv => ?_
      obtain ⟨a, b, rfl, _, hb⟩ := VTy.prod_inv hv
      exact hb
    | add ha hb =>
      refine Good.bind (ih ha) fun va hva => Good.bind (ih hb) fun vb hvb => ?_
      obtain ⟨x, rfl⟩ := VTy.int_inv hva
      obtain ⟨y, rfl⟩ := VTy.int_inv hvb
      exact VTy.int _
    | cat ha hb =>
      refine Good.bind (ih ha) fun va hva => Good.bind (ih hb) fun vb hvb => ?_
      obtain ⟨x, rfl⟩ := VTy.str_inv hva
      obtain ⟨y, rfl⟩ := VTy.str_inv hvb
      exact VTy.str _
    | itos he =>
      refine Good.bind (ih he) fun v hv => ?_
      obtain ⟨x, rfl⟩ := VTy.int_inv hv
      exact VTy.str _
    | ifz hc ha hb =>
      refine Good.bind (ih hc) fun vc hvc => ?_
      obtain ⟨x, rfl⟩ := VTy.int_inv hvc
      show Good (if x = 0 then _ else _) _
      split
      · exact ih ha
      · exact ih hb
    | shapeOf hd =>
      obtain ⟨s, hs⟩ := Ty.sh_of_data (Ty.dataOk_tsubst hk hts hd)
      show Good (match _ with | some s => Res.ok (Val.shp s) | none => Res.stuck) _
      rw [hs]
      exact VTy.shp hs
    | pack hv hs =>
      refine Good.bind (ih hv) fun vv hvv => Good.bind (ih hs) fun vs hvs => ?_
      obtain ⟨s, rfl, hsh⟩ := VTy.shape_inv hvs
      exact VTy.dyn hvv hsh
    | kind hd =>
      refine Good.bind (ih hd) fun vd hvd => ?_
      obtain ⟨w, t', s, rfl, _, _⟩ := VTy.dyn_inv hvd
      exact VTy.int _
    | asInt hd hf =>
      refine Good.bind (ih hd) fun vd hvd => ?_
      obtain ⟨w, t', s, rfl, _, _⟩ := VTy.dyn_inv hvd
      cases w <;> first | exact VTy.int _ | exact ih hf
    | asStr hd hf =>
      refine Good.bind (ih hd) fun vd hvd => ?_
      obtain ⟨w, t', s, rfl, _, _⟩ := VTy.dyn_inv hvd
      cases w <;> first | exact VTy.str _ | exact ih hf
    | hd hd hf =>
      refine Good.bind (ih hd) fun vd hvd => ?_
      obtain ⟨w, t', s, rfl, hw, hs⟩ := VTy.dyn_inv hvd
      cases w with
      | pair a b =>
        cases s with
        | prod sa sb =>
          obtain ⟨l, r, rfl, ha, _⟩ := VTy.pair_inv hw
          exact VTy.dyn ha (Ty.sh_prod hs).1
        | _ => exact ih hf
      | _ => exact ih hf
    | tl hd hf =>
      refine Good.bind (ih hd) fun vd hvd => ?_
      obtain ⟨w, t', s, rfl, hw, hs⟩ := VTy.dyn_inv hvd
      cases w with
      | pair a b =>
        cases s with
        | prod sa sb =>
          obtain ⟨l, r, rfl, _, hb⟩ := VTy.pair_inv hw
          exact VTy.dyn hb (Ty.sh_prod hs).2
        | _ => exact ih hf
      | _ => exact ih hf
    | @call f us e' dfn hf hlen hus he =>
      refine Good.bind (ih he) fun v hv => ?_
      obtain ⟨hb, hp, hr⟩ := hΔ dfn (List.mem_of_getElem? hf)
      have hts' : (us.map (Ty.tsubst ts)).all (Ty.dataOk 0) = true := by
        refine List.all_eq_true.2 fun x hx => ?_
        obtain ⟨u, hu, rfl⟩ := List.mem_map.1 hx
        exact Ty.dataOk_tsubst hk hts (List.all_eq_true.1 hus u hu)
      have hlen' : (us.map (Ty.tsubst ts)).length = dfn.tparams := by simp [hlen]
      have hv' : VTy v (dfn.param.tsubst (us.map (Ty.tsubst ts))) := by
        rw [← Ty.tsubst_comp (hlen ▸ hp)]; exact hv
      show Good (match Δ[f]? with | some dfn => _ | none => Res.stuck) _
      rw [hf, Ty.tsubst_comp (hlen ▸ hr)]
      exact sound hΔ n hb hlen' hts' hv'

/-! ## 例: 入れ子のstructを歩く put と、ジェネリックの encode -/

/-- put（Def 0・非ジェネリック）: dyn を受けて文字列にする。直積は hd と tl で歩く（入れ子のstructは hd の先で再帰） -/
def dUnit : Expr := .pack .triv (.shapeOf .unit)

def putBody : Expr :=
  .ifz (.add (.kind .var) (.lit (-3)))
    (.cat (.call 0 [] (.hd .var dUnit)) (.cat (.slit ",") (.call 0 [] (.tl .var dUnit))))
    (.ifz (.kind .var) (.itos (.asInt .var (.lit 0)))
      (.ifz (.add (.kind .var) (.lit (-1))) (.asStr .var (.slit "")) (.slit "")))

/-- encode[T]（Def 1・ジェネリック）: 本体に `shape[T]` と書くだけ。利用者は辞書を渡さない -/
def encodeBody : Expr := .call 0 [] (.pack .var (.shapeOf (.tvar 0)))

def defs : Defs :=
  [ { tparams := 0, param := .dyn, ret := .str, body := putBody },
    { tparams := 1, param := .tvar 0, ret := .str, body := encodeBody } ]

theorem call_put {n : Nat} {Γ : Ty} {e : Expr} (h : HasTy defs n Γ e .dyn) : HasTy defs n Γ (.call 0 [] e) .str :=
  HasTy.call (dfn := { tparams := 0, param := .dyn, ret := .str, body := putBody }) rfl rfl rfl h

theorem put_typed : HasTy defs 0 .dyn putBody .str := by
  unfold putBody dUnit
  repeat' (first | rfl | apply call_put | constructor)

theorem encode_typed : HasTy defs 1 (.tvar 0) encodeBody .str := by
  unfold encodeBody
  repeat' (first | rfl | apply call_put | constructor)

theorem defs_ok : DefsOk defs := by
  intro dfn hd
  simp only [defs, List.mem_cons, List.not_mem_nil, or_false] at hd
  rcases hd with rfl | rfl
  · exact ⟨put_typed, rfl, rfl⟩
  · exact ⟨encode_typed, rfl, rfl⟩

/-- 入れ子のstruct: {a int, b string, c {x int, y int}} -/
def recTy : Ty := .prod .int (.prod .str (.prod (.prod .int (.prod .int .unit)) .unit))
def recVal : Expr :=
  .pair (.lit 1) (.pair (.slit "x") (.pair (.pair (.lit 2) (.pair (.lit 3) .triv)) .triv))

def mainExpr : Expr := .call 1 [recTy] recVal

theorem main_typed : HasTy defs 0 .unit mainExpr .str := by
  unfold mainExpr recVal recTy
  refine HasTy.call (us := [_]) (dfn := { tparams := 1, param := .tvar 0, ret := .str, body := encodeBody }) rfl rfl rfl ?_
  repeat' (first | rfl | constructor)

#eval eval 1000 defs [] .unit mainExpr

end Shape0
