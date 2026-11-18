/-!
# R3の確認（branch r3）: 本体の型（lean/FeatherweightSober の Ty・20 構成子）で、型変数を T@ρ にした代入の補題

本体の Lean の計画（report-r3-2）の要の主張を、本体の型の定義を写して確かめる。
型変数 `tvar i ρ k` は「型引数 i の全部の region 座標を ρ へ置き直した型」（T@ρ）で、k は本体が使う性質（kind の旗）。
代入は `tvar i ρ k ↦ ts[i].atR ρ`。正確な T（型引数を絶対座標のまま運ぶ形）は無い。

確かめること: 前の計画で壊れていた補題（tsubst_relocR・tsubst_relocA・tsubst_renR・localOnly_tsubst）と、
シフト・締め・region の上界・部分型・代入の合成が、kind の条件の下で代入と可換・準同型であること。
本体の「代入してから呼び手の座標へ写す」順（Def.inst の後に shiftR / renR / relocR / relocA）は変えなくてよい。

写した定義: Ty・regionsBelow・mutFree・chanFree・covOk・argFree・retOk・localOnly・shiftR・renR・relocR・relocA・clampR・sub。
tvar の腕だけを新しい形にした。μ の整形（recOk）・rfree は代入で変わらない部分なので写していない。
-/

namespace R3M

inductive OwnK : Type where
  | scope | task | tx | rx
  deriving DecidableEq, Repr

/-- 型パラメータの kind（本体が使った性質の旗）: rf = region を持たない・mf = mut を持たない・cf = chan / dom / own を持たない・
cov = region を上げると部分型（深く共変）。旗が立っていない性質は仮定しない -/
structure Kind where
  rf : Bool
  mf : Bool
  cf : Bool
  cov : Bool
  deriving DecidableEq, Repr

/-- 戻りで写せる（imm で端点なし）: relocR / relocA / clampR が region を締めてよい型変数 -/
def Kind.imm (k : Kind) : Bool := k.rf || (k.mf && k.cf)

inductive Ty : Type where
  | int
  | tvar (i ρ : Nat) (k : Kind)
  | bool
  | byte
  | f64
  | unit
  | opt (t : Ty)
  | union (l r : Ty)
  | prod (l r : Ty)
  | ref (m : Bool) (r : Nat) (t : Ty)
  | slice (m : Bool) (r : Nat) (t : Ty)
  | map (m : Bool) (r : Nat) (t : Ty)
  | chan (rc : Nat) (t : Ty)
  | fn (p r : Ty)
  | own (k : OwnK) (r : Nat) (t : Ty)
  | rvar (i : Nat)
  | mus (n i : Nat) (bs : Ty)
  | muRs (r n i : Nat) (bs : Ty)
  | dom (r : Nat) (s : Ty)
  deriving DecidableEq, Repr

def Ty.regionsBelow (d : Nat) : Ty → Bool
  | .int => true
  | .tvar _ ρ k => k.rf || decide (ρ < d)
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.regionsBelow d
  | .union l r => l.regionsBelow d && r.regionsBelow d
  | .prod l r => l.regionsBelow d && r.regionsBelow d
  | .ref _ r t => decide (r < d) && t.regionsBelow d
  | .slice _ r t => decide (r < d) && t.regionsBelow d
  | .map _ r t => decide (r < d) && t.regionsBelow d
  | .chan rc t => decide (rc ≤ d) && t.regionsBelow rc
  | .dom r t => decide (r < d) && t.regionsBelow d
  | .own _ r t => decide (r < d) && t.regionsBelow d
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .muRs r _ _ _ => decide (r < d)

def Ty.mutFree : Ty → Bool
  | .int => true
  | .tvar _ _ k => k.rf || k.mf
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.mutFree
  | .union l r => l.mutFree && r.mutFree
  | .prod l r => l.mutFree && r.mutFree
  | .ref m _ t => !m && t.mutFree
  | .slice m _ t => !m && t.mutFree
  | .map m _ t => !m && t.mutFree
  | .chan _ _ => true
  | .dom _ _ => true
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .own _ _ _ => false
  | .muRs _ _ _ b => b.mutFree

def Ty.chanFree : Ty → Bool
  | .int => true
  | .tvar _ _ k => k.rf || k.cf
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.chanFree
  | .union l r => l.chanFree && r.chanFree
  | .prod l r => l.chanFree && r.chanFree
  | .ref _ _ t => t.chanFree
  | .slice _ _ t => t.chanFree
  | .map _ _ t => t.chanFree
  | .chan _ _ => false
  | .dom _ _ => false
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .own _ _ _ => false
  | .muRs _ _ _ b => b.chanFree

def Ty.covOk : Ty → Bool
  | .int => true
  | .tvar _ _ k => k.rf || k.cov
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.covOk
  | .union l r => l.covOk && r.covOk
  | .prod l r => l.covOk && r.covOk
  | .ref false _ t => t.regionsBelow 0 && t.chanFree
  | .slice false _ t => t.covOk
  | .map false _ t => t.covOk
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .muRs _ _ _ b => b.covOk
  | _ => false

def Ty.argFree : Ty → Bool
  | .int => true
  | .tvar _ _ _ => true
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.argFree
  | .union l r => l.argFree && r.argFree
  | .prod l r => l.argFree && r.argFree
  | .ref _ _ t => t.argFree
  | .slice _ _ t => t.argFree
  | .map _ _ t => t.argFree
  | .chan _ _ => false
  | .dom _ t => t.chanFree
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .own _ _ _ => false
  | .muRs _ _ _ b => b.argFree

def Ty.retOk : Ty → Bool
  | .int => true
  | .tvar _ ρ k => k.rf || (k.mf && k.cf && decide (ρ < 2))
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.retOk
  | .union l r => l.retOk && r.retOk
  | .prod l r => l.retOk && r.retOk
  | .ref false r t => decide (r < 2) && t.retOk
  | .slice false r t => decide (r < 2) && t.retOk
  | .map false r t => decide (r < 2) && t.retOk
  | .ref true _ _ => false
  | .slice true _ _ => false
  | .map true _ _ => false
  | .chan _ _ => false
  | .dom _ _ => false
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .muRs r _ _ b => b.mutFree && decide (r < 2) && b.retOk
  | .own _ _ _ => false

def Ty.localOnly : Ty → Bool
  | .int => true
  | .tvar _ ρ k => k.rf || (decide (ρ = 0) && k.cf)
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.localOnly
  | .union l r => l.localOnly && r.localOnly
  | .prod l r => l.localOnly && r.localOnly
  | .ref _ r t => decide (r = 0) && t.localOnly
  | .slice _ r t => decide (r = 0) && t.localOnly
  | .map _ r t => decide (r = 0) && t.localOnly
  | .chan rc t => decide (rc = 0) && t.regionsBelow 0 && t.chanFree
  | .dom rc t => decide (rc = 0) && t.regionsBelow 0 && t.chanFree
  | .own _ r t => decide (r = 0) && t.regionsBelow 0 && t.chanFree
  | .fn _ _ => true
  | .mus _ _ _ => true
  | .rvar _ => true
  | .muRs r _ _ _ => decide (r = 0)

def Ty.shiftR (ρ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i r k => .tvar i (if k.rf then r else r + ρ) k
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.shiftR ρ)
  | .union l r => .union (l.shiftR ρ) (r.shiftR ρ)
  | .prod l r => .prod (l.shiftR ρ) (r.shiftR ρ)
  | .ref m r t => .ref m (r + ρ) (t.shiftR ρ)
  | .slice m r t => .slice m (r + ρ) (t.shiftR ρ)
  | .map m r t => .map m (r + ρ) (t.shiftR ρ)
  | .chan rc t => .chan (rc + ρ) (t.shiftR ρ)
  | .dom rc t => .dom (rc + ρ) (t.shiftR ρ)
  | .fn p r => .fn p r
  | .mus n i b => .mus n i b
  | .rvar i => .rvar i
  | .own k r t => .own k (r + ρ) (t.shiftR ρ)
  | .muRs r n i b => .muRs (r + ρ) n i b

def rmap (ρ0 δ : Nat) : Nat → Nat
  | 0 => ρ0
  | k + 1 => k + 1 + δ

def Ty.renR (ρ0 δ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i r k => .tvar i (if k.rf then r else rmap ρ0 δ r) k
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.renR ρ0 δ)
  | .union l r => .union (l.renR ρ0 δ) (r.renR ρ0 δ)
  | .prod l r => .prod (l.renR ρ0 δ) (r.renR ρ0 δ)
  | .ref m r t => .ref m (rmap ρ0 δ r) (t.renR ρ0 δ)
  | .slice m r t => .slice m (rmap ρ0 δ r) (t.renR ρ0 δ)
  | .map m r t => .map m (rmap ρ0 δ r) (t.renR ρ0 δ)
  | .chan rc t => .chan (rmap ρ0 δ rc) (t.renR ρ0 δ)
  | .dom rc t => .dom (rmap ρ0 δ rc) (t.renR ρ0 δ)
  | .fn p r => .fn p r
  | .mus n i b => .mus n i b
  | .rvar i => .rvar i
  | .own k r t => .own k (rmap ρ0 δ r) (t.renR ρ0 δ)
  | .muRs r n i b => .muRs (rmap ρ0 δ r) n i b

/-- 戻りの写し（最上段の imm を呼び手最内 ρ へ。mut / 端点はシフト）。imm の型変数は締める、そうでない型変数はシフト -/
def Ty.relocR (ρ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i r k => if k.rf then .tvar i r k else if k.imm then .tvar i ρ k else .tvar i (r + ρ) k
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.relocR ρ)
  | .union l r => .union (l.relocR ρ) (r.relocR ρ)
  | .prod l r => .prod (l.relocR ρ) (r.relocR ρ)
  | .ref false _ t => .ref false ρ (t.relocR ρ)
  | .slice false _ t => .slice false ρ (t.relocR ρ)
  | .map false _ t => .map false ρ (t.relocR ρ)
  | .ref true r t => .ref true (r + ρ) (t.shiftR ρ)
  | .slice true r t => .slice true (r + ρ) (t.shiftR ρ)
  | .map true r t => .map true (r + ρ) (t.shiftR ρ)
  | .chan rc t => .chan (rc + ρ) (t.shiftR ρ)
  | .dom rc t => .dom (rc + ρ) (t.shiftR ρ)
  | .fn p r => .fn p r
  | .mus n i b => .mus n i b
  | .rvar i => .rvar i
  | .own k r t => .own k (r + ρ) (t.shiftR ρ)
  | .muRs r n i b => if b.mutFree then .muRs ρ n i b else .muRs (r + ρ) n i b

def Ty.relocA (ρ0 d : Nat) : Ty → Ty
  | .int => .int
  | .tvar i r k => if k.rf then .tvar i r k else if k.imm then .tvar i (if r = 0 then ρ0 else d) k else .tvar i (rmap ρ0 d r) k
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.relocA ρ0 d)
  | .union l r => .union (l.relocA ρ0 d) (r.relocA ρ0 d)
  | .prod l r => .prod (l.relocA ρ0 d) (r.relocA ρ0 d)
  | .ref false r t => .ref false (if r = 0 then ρ0 else d) (t.relocA ρ0 d)
  | .slice false r t => .slice false (if r = 0 then ρ0 else d) (t.relocA ρ0 d)
  | .map false r t => .map false (if r = 0 then ρ0 else d) (t.relocA ρ0 d)
  | .ref true r t => .ref true (rmap ρ0 d r) (t.renR ρ0 d)
  | .slice true r t => .slice true (rmap ρ0 d r) (t.renR ρ0 d)
  | .map true r t => .map true (rmap ρ0 d r) (t.renR ρ0 d)
  | .chan rc t => .chan (rmap ρ0 d rc) (t.renR ρ0 d)
  | .dom rc t => .dom (rmap ρ0 d rc) (t.renR ρ0 d)
  | .fn p r => .fn p r
  | .mus n i b => .mus n i b
  | .rvar i => .rvar i
  | .own k r t => .own k (rmap ρ0 d r) (t.renR ρ0 d)
  | .muRs r n i b => if b.mutFree then .muRs (if r = 0 then ρ0 else d) n i b else .muRs (rmap ρ0 d r) n i b

def Ty.clampR (k : Nat) : Ty → Ty
  | .tvar i r kd => if kd.rf then .tvar i r kd else if kd.imm then .tvar i (min r k) kd else .tvar i r kd
  | .opt t => .opt (t.clampR k)
  | .union l r => .union (l.clampR k) (r.clampR k)
  | .prod l r => .prod (l.clampR k) (r.clampR k)
  | .ref false r t => .ref false (min r k) (t.clampR k)
  | .slice false r t => .slice false (min r k) (t.clampR k)
  | .map false r t => .map false (min r k) (t.clampR k)
  | .muRs r n i b => if b.mutFree then .muRs (min r k) n i b else .muRs r n i b
  | t => t

def Ty.sub : Ty → Ty → Bool
  | .tvar i ρ k, .tvar j ρ' k' => decide (i = j) && decide (k = k') && (decide (ρ = ρ') || k.rf || (k.cov && decide (ρ ≤ ρ')))
  | .opt t, .opt t' => Ty.sub t t'
  | .union l r, .union l' r' => Ty.sub l l' && Ty.sub r r'
  | .prod l r, .prod l' r' => Ty.sub l l' && Ty.sub r r'
  | .ref false r t, .ref false r' t' => decide (r ≤ r') && decide (t = t')
  | .slice false r t, .slice false r' t' => decide (r ≤ r') && Ty.sub t t'
  | .map false r t, .map false r' t' => decide (r ≤ r') && Ty.sub t t'
  | .dom r t, .dom r' t' => decide (r ≤ r') && decide (t = t')
  | .muRs r n i b, .muRs r' n' i' b' =>
    decide (n = n') && decide (i = i') && decide (b = b') && (decide (r = r') || (decide (r ≤ r') && b.covOk))
  | a, b => decide (a = b)

/-- 全部の region 座標を k へ置き直す（renR が触る位置と同じ。関数型・S の μ・μ の本体には入らない） -/
def Ty.atR (k : Nat) : Ty → Ty
  | .int => .int
  | .tvar i r kd => .tvar i (if kd.rf then r else k) kd
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.atR k)
  | .union l r => .union (l.atR k) (r.atR k)
  | .prod l r => .prod (l.atR k) (r.atR k)
  | .ref m _ t => .ref m k (t.atR k)
  | .slice m _ t => .slice m k (t.atR k)
  | .map m _ t => .map m k (t.atR k)
  | .chan _ t => .chan k (t.atR k)
  | .dom _ t => .dom k (t.atR k)
  | .fn p r => .fn p r
  | .mus n i b => .mus n i b
  | .rvar i => .rvar i
  | .own o _ t => .own o k (t.atR k)
  | .muRs _ n i b => .muRs k n i b

def look (ts : List Ty) (i : Nat) : Ty := ts.getD i .int

/-- 型代入: T@ρ ↦ 型引数を ρ へ置き直した型。関数型・μ の本体の中も同じ（置き直しが座標を決めるので、読み方を変えなくてよい） -/
def Ty.tsubst (ts : List Ty) : Ty → Ty
  | .int => .int
  | .tvar i ρ _ => (look ts i).atR ρ
  | .bool => .bool
  | .byte => .byte
  | .f64 => .f64
  | .unit => .unit
  | .opt t => .opt (t.tsubst ts)
  | .union l r => .union (l.tsubst ts) (r.tsubst ts)
  | .prod l r => .prod (l.tsubst ts) (r.tsubst ts)
  | .ref m r t => .ref m r (t.tsubst ts)
  | .slice m r t => .slice m r (t.tsubst ts)
  | .map m r t => .map m r (t.tsubst ts)
  | .chan rc t => .chan rc (t.tsubst ts)
  | .dom rc t => .dom rc (t.tsubst ts)
  | .fn p r => .fn (p.tsubst ts) (r.tsubst ts)
  | .mus n i b => .mus n i (b.tsubst ts)
  | .rvar i => .rvar i
  | .own k r t => .own k r (t.tsubst ts)
  | .muRs r n i b => .muRs r n i (b.tsubst ts)

/-- 型引数 s が kind k を満たす（旗の性質を持つ。端点は渡さない = argFree） -/
def kindOk (k : Kind) (s : Ty) : Bool :=
  s.argFree && (!k.rf || (s.regionsBelow 0 && s.chanFree)) && (!k.mf || s.mutFree) && (!k.cf || s.chanFree) &&
    (!k.cov || (s.covOk && s.mutFree && s.chanFree))

/-- t の型変数の出現 tvar i ρ k はどれも、型引数 ts[i] が k を満たす -/
def Ty.kindsOk (ts : List Ty) : Ty → Bool
  | .tvar i _ k => kindOk k (look ts i)
  | .opt t => t.kindsOk ts
  | .union l r => l.kindsOk ts && r.kindsOk ts
  | .prod l r => l.kindsOk ts && r.kindsOk ts
  | .ref _ _ t => t.kindsOk ts
  | .slice _ _ t => t.kindsOk ts
  | .map _ _ t => t.kindsOk ts
  | .chan _ t => t.kindsOk ts
  | .dom _ t => t.kindsOk ts
  | .fn p r => p.kindsOk ts && r.kindsOk ts
  | .mus _ _ b => b.kindsOk ts
  | .own _ _ t => t.kindsOk ts
  | .muRs _ _ _ b => b.kindsOk ts
  | _ => true

/-! ## 置き直しの補題（型引数そのものの性質） -/

theorem Ty.atR_atR (j k : Nat) : ∀ t : Ty, (t.atR j).atR k = t.atR k := by
  intro t; induction t <;> simp_all [Ty.atR]

theorem Ty.shiftR_atR (k d : Nat) : ∀ t : Ty, (t.atR k).shiftR d = t.atR (k + d) := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.shiftR]

theorem Ty.renR_atR (k a d : Nat) : ∀ t : Ty, (t.atR k).renR a d = t.atR (rmap a d k) := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.renR]

/-- region も端点も持たない型は置き直しで変わらない -/
theorem Ty.atR_rf (k : Nat) : ∀ t : Ty, t.regionsBelow 0 = true → t.chanFree = true → t.atR k = t := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.regionsBelow, Ty.chanFree]

theorem Ty.mutFree_atR (k : Nat) : ∀ t : Ty, (t.atR k).mutFree = t.mutFree := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.mutFree]

theorem Ty.chanFree_atR (k : Nat) : ∀ t : Ty, (t.atR k).chanFree = t.chanFree := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.chanFree]

theorem Ty.argFree_atR (k : Nat) : ∀ t : Ty, (t.atR k).argFree = t.argFree := by
  intro t; induction t <;> simp_all [Ty.atR, Ty.argFree, Ty.chanFree_atR]

theorem Ty.covOk_atR (k : Nat) : ∀ t : Ty, t.covOk = true → (t.atR k).covOk = true := by
  intro t; induction t with
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.covOk, Ty.atR_rf]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.covOk]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.covOk]
  | _ => simp_all [Ty.atR, Ty.covOk]

/-- 置き直した型の region の上界: 置き直し先が d 未満なら d 未満（端点は除く） -/
theorem Ty.regionsBelow_atR {k d : Nat} (hk : k < d) : ∀ t : Ty, t.chanFree = true → (t.atR k).regionsBelow d = true := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.atR, Ty.regionsBelow, Ty.chanFree]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | _ => simp_all [Ty.atR, Ty.regionsBelow, Ty.chanFree]

/-- 戻りの写し: imm で端点の無い型を置き直した型は、写すと写し先へ置き直した型 -/
theorem Ty.relocR_atR (k ρ : Nat) : ∀ t : Ty, t.mutFree = true → t.chanFree = true → (t.atR k).relocR ρ = t.atR ρ := by
  intro t; induction t with
  | tvar i r kd => intro hm hc; simp [Ty.mutFree, Ty.chanFree] at hm hc; simp [Ty.atR, Ty.relocR]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocR, Ty.mutFree, Ty.chanFree]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocR, Ty.mutFree, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocR, Ty.mutFree, Ty.chanFree]
  | muRs r n i b _ => intro hm _; simp_all [Ty.atR, Ty.relocR, Ty.mutFree]
  | _ => simp_all [Ty.atR, Ty.relocR, Ty.mutFree, Ty.chanFree]

theorem Ty.relocA_atR (k a d : Nat) : ∀ t : Ty, t.mutFree = true → t.chanFree = true →
    (t.atR k).relocA a d = t.atR (if k = 0 then a else d) := by
  intro t; induction t with
  | tvar i r kd => intro hm hc; simp [Ty.mutFree, Ty.chanFree] at hm hc; simp [Ty.atR, Ty.relocA]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocA, Ty.mutFree, Ty.chanFree]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocA, Ty.mutFree, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.relocA, Ty.mutFree, Ty.chanFree]
  | muRs r n i b _ => intro hm _; simp_all [Ty.atR, Ty.relocA, Ty.mutFree]
  | _ => simp_all [Ty.atR, Ty.relocA, Ty.mutFree, Ty.chanFree]

theorem Ty.clampR_atR_imm (k k' : Nat) : ∀ t : Ty, t.mutFree = true → t.chanFree = true →
    (t.atR k).clampR k' = t.atR (min k k') := by
  intro t; induction t with
  | tvar i r kd => intro hm hc; simp [Ty.mutFree, Ty.chanFree] at hm hc; simp [Ty.atR, Ty.clampR]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR, Ty.mutFree, Ty.chanFree]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR, Ty.mutFree, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR, Ty.mutFree, Ty.chanFree]
  | muRs r n i b _ => intro hm _; simp_all [Ty.atR, Ty.clampR, Ty.mutFree]
  | _ => simp_all [Ty.atR, Ty.clampR, Ty.mutFree, Ty.chanFree]

/-- 締めの先より浅い置き直しは締めで変わらない（mut を持ってもよい） -/
theorem Ty.clampR_atR_le {k k' : Nat} (hk : k ≤ k') : ∀ t : Ty, (t.atR k).clampR k' = t.atR k := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.atR, Ty.clampR]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR] <;> omega
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR] <;> omega
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.clampR] <;> omega
  | muRs r n i b => simp [Ty.atR, Ty.clampR]; intro _; omega
  | _ => simp_all [Ty.atR, Ty.clampR]

theorem Ty.localOnly_atR0 : ∀ t : Ty, t.chanFree = true → (t.atR 0).localOnly = true := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.atR, Ty.localOnly, Ty.chanFree]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | _ => simp_all [Ty.atR, Ty.localOnly, Ty.chanFree]

/-- D の μ の本体が局所座標（本体の整形 — 本体の recOk の一部） -/
def Ty.wfMu : Ty → Bool
  | .opt t => t.wfMu
  | .union l r => l.wfMu && r.wfMu
  | .prod l r => l.wfMu && r.wfMu
  | .ref _ _ t => t.wfMu
  | .slice _ _ t => t.wfMu
  | .map _ _ t => t.wfMu
  | .chan _ t => t.wfMu
  | .dom _ t => t.wfMu
  | .own _ _ t => t.wfMu
  | .muRs _ _ _ b => b.localOnly && b.wfMu
  | _ => true

/-- 局所座標で mut も端点も持たない本体は、戻りの条件を満たす -/
theorem Ty.retOk_local : ∀ t : Ty, t.localOnly = true → t.wfMu = true → t.mutFree = true → t.chanFree = true → t.retOk = true := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.localOnly, Ty.mutFree, Ty.chanFree, Ty.retOk]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.localOnly, Ty.wfMu, Ty.mutFree, Ty.chanFree, Ty.retOk]
  | slice m r t ih => cases m <;> simp_all [Ty.localOnly, Ty.wfMu, Ty.mutFree, Ty.chanFree, Ty.retOk]
  | map m r t ih => cases m <;> simp_all [Ty.localOnly, Ty.wfMu, Ty.mutFree, Ty.chanFree, Ty.retOk]
  | _ => simp_all [Ty.localOnly, Ty.wfMu, Ty.mutFree, Ty.chanFree, Ty.retOk]

theorem Ty.retOk_atR {k : Nat} (hk : k < 2) : ∀ t : Ty, t.wfMu = true → t.mutFree = true → t.chanFree = true →
    (t.atR k).retOk = true := by
  intro t; induction t with
  | tvar i r kd => intro _ hm hc; simp [Ty.mutFree, Ty.chanFree] at hm hc; simp [Ty.atR, Ty.retOk]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih => cases m <;> simp_all [Ty.atR, Ty.retOk, Ty.wfMu, Ty.mutFree, Ty.chanFree]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.retOk, Ty.wfMu, Ty.mutFree, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.retOk, Ty.wfMu, Ty.mutFree, Ty.chanFree]
  | muRs r n i b _ =>
    intro hw hm hc; simp [Ty.wfMu, Ty.mutFree, Ty.chanFree] at hw hm hc
    simp [Ty.atR, Ty.retOk, hm, hk, Ty.retOk_local b hw.1 hw.2 hm hc]
  | _ => simp_all [Ty.atR, Ty.retOk, Ty.wfMu, Ty.mutFree, Ty.chanFree]

theorem Ty.sub_refl : ∀ t : Ty, Ty.sub t t = true := by
  intro t; induction t with
  | ref m r t ih => cases m <;> simp_all [Ty.sub]
  | slice m r t ih => cases m <;> simp_all [Ty.sub]
  | map m r t ih => cases m <;> simp_all [Ty.sub]
  | _ => simp_all [Ty.sub]

/-- 深く共変で mut も端点も持たない型は、置き直す先を上げると部分型 -/
theorem Ty.sub_atR_mono {k k' : Nat} (hk : k ≤ k') : ∀ t : Ty, t.covOk = true → t.mutFree = true → t.chanFree = true →
    Ty.sub (t.atR k) (t.atR k') = true := by
  intro t; induction t with
  | tvar i r kd => intro hv hm hc; simp [Ty.covOk, Ty.mutFree, Ty.chanFree] at hv hm hc; simp [Ty.atR, Ty.sub]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | ref m r t ih =>
    cases m <;> simp [Ty.covOk, Ty.mutFree, Ty.chanFree] at *
    intro hr hcf; simp [Ty.atR, Ty.sub, Ty.atR_rf _ _ hr hcf, hk]
  | slice m r t ih => cases m <;> simp_all [Ty.atR, Ty.sub, Ty.covOk, Ty.mutFree, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.atR, Ty.sub, Ty.covOk, Ty.mutFree, Ty.chanFree]
  | muRs r n i b => intro hv _ _; simp [Ty.covOk] at hv; simp [Ty.atR, Ty.sub, hv, hk]
  | _ => simp_all [Ty.atR, Ty.sub, Ty.covOk, Ty.mutFree, Ty.chanFree, Ty.sub_refl]

/-! ## 代入と座標の操作の可換性（前の計画で壊れていた補題） -/

theorem look_kind {ts : List Ty} {i : Nat} {k : Kind} (h : kindOk k (look ts i) = true) :
    (look ts i).argFree = true ∧ (k.rf = true → (look ts i).regionsBelow 0 = true ∧ (look ts i).chanFree = true) ∧
    (k.mf = true → (look ts i).mutFree = true) ∧ (k.cf = true → (look ts i).chanFree = true) ∧
    (k.cov = true → (look ts i).covOk = true ∧ (look ts i).mutFree = true ∧ (look ts i).chanFree = true) := by
  simp only [kindOk, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h
  obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := h
  refine ⟨h1, fun hk => ?_, fun hk => ?_, fun hk => ?_, fun hk => ?_⟩
  · rcases h2 with h | h; · simp [hk] at h
    exact h
  · rcases h3 with h | h; · simp [hk] at h
    exact h
  · rcases h4 with h | h; · simp [hk] at h
    exact h
  · rcases h5 with h | h; · simp [hk] at h
    exact ⟨h.1.1, h.1.2, h.2⟩

/-- region を持たない型は mut を持たない -/
theorem Ty.rf_mf : ∀ t : Ty, t.regionsBelow 0 = true → t.mutFree = true := by
  intro t; induction t <;> simp_all [Ty.regionsBelow, Ty.mutFree]

/-- 型変数の imm の旗を満たす型引数は、mut も端点も持たない -/
theorem kind_imm {ts : List Ty} {i : Nat} {k : Kind} (h : kindOk k (look ts i) = true) (hi : k.imm = true) :
    (look ts i).mutFree = true ∧ (look ts i).chanFree = true := by
  obtain ⟨-, hrf, hmf, hcf, -⟩ := look_kind h
  simp [Kind.imm] at hi
  rcases hi with h1 | ⟨h1, h2⟩
  · exact ⟨Ty.rf_mf _ (hrf h1).1, (hrf h1).2⟩
  · exact ⟨hmf h1, hcf h2⟩

/-- rf の旗の型変数の置き直し先は効かない -/
theorem look_rf_atR {ts : List Ty} {i : Nat} {k : Kind} (h : kindOk k (look ts i) = true) (hr : k.rf = true) (a b : Nat) :
    (look ts i).atR a = (look ts i).atR b := by
  obtain ⟨-, hrf, -⟩ := look_kind h
  rw [Ty.atR_rf _ _ (hrf hr).1 (hrf hr).2, Ty.atR_rf _ _ (hrf hr).1 (hrf hr).2]

theorem Ty.tsubst_shiftR (ts : List Ty) (d : Nat) : ∀ t : Ty, t.kindsOk ts = true → (t.tsubst ts).shiftR d = (t.shiftR d).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hk; simp [Ty.kindsOk] at hk
    simp only [Ty.tsubst, Ty.shiftR, Ty.shiftR_atR]
    cases hr : kd.rf
    · simp
    · simp only [if_true]; exact look_rf_atR hk hr _ _
  | _ => simp_all [Ty.tsubst, Ty.shiftR, Ty.kindsOk]

theorem Ty.tsubst_renR (ts : List Ty) (a d : Nat) : ∀ t : Ty, t.kindsOk ts = true → (t.tsubst ts).renR a d = (t.renR a d).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hk; simp [Ty.kindsOk] at hk
    simp only [Ty.tsubst, Ty.renR, Ty.renR_atR]
    cases hr : kd.rf
    · simp
    · simp only [if_true]; exact look_rf_atR hk hr _ _
  | _ => simp_all [Ty.tsubst, Ty.renR, Ty.kindsOk]

theorem Ty.mutFree_tsubst (ts : List Ty) : ∀ t : Ty, t.mutFree = true → t.kindsOk ts = true → (t.tsubst ts).mutFree = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro hm hk; simp [Ty.kindsOk] at hk; simp [Ty.mutFree] at hm
    obtain ⟨-, hrf, hmf, -, -⟩ := look_kind hk
    simp only [Ty.tsubst, Ty.mutFree_atR]
    rcases hm with h | h
    · exact Ty.rf_mf _ (hrf h).1
    · exact hmf h
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.mutFree, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.mutFree, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.mutFree, Ty.kindsOk]
  | _ => simp_all [Ty.tsubst, Ty.mutFree, Ty.kindsOk]

/-- 戻りの写しと代入の可換性（戻り値の条件 retOk の下 — 戻り値の型変数は imm の旗を持つ） -/
theorem Ty.tsubst_relocR (ts : List Ty) (ρ : Nat) : ∀ t : Ty, t.retOk = true → t.kindsOk ts = true →
    (t.tsubst ts).relocR ρ = (t.relocR ρ).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hr hk; simp [Ty.kindsOk] at hk
    have hi : kd.imm = true := by
      simp [Ty.retOk] at hr; simp only [Kind.imm]; rcases hr with h | ⟨⟨h1, h2⟩, -⟩ <;> simp [*]
    obtain ⟨hm, hc⟩ := kind_imm hk hi
    cases hrf : kd.rf
    · simp [Ty.tsubst, Ty.relocR, hrf, hi, Ty.relocR_atR _ _ _ hm hc]
    · simp only [Ty.tsubst, Ty.relocR, hrf, if_true]; rw [Ty.relocR_atR _ _ _ hm hc]; exact look_rf_atR hk hrf _ _
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.retOk, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.retOk, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocR, Ty.retOk, Ty.kindsOk]
  | muRs r n i b _ =>
    intro hr hk; simp [Ty.retOk] at hr; simp [Ty.kindsOk] at hk
    simp [Ty.tsubst, Ty.relocR, hr.1.1, Ty.mutFree_tsubst ts b hr.1.1 hk]
  | _ => simp_all [Ty.tsubst, Ty.relocR, Ty.retOk, Ty.kindsOk]

theorem Ty.tsubst_relocA (ts : List Ty) (a d : Nat) : ∀ t : Ty, t.retOk = true → t.kindsOk ts = true →
    (t.tsubst ts).relocA a d = (t.relocA a d).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hr hk; simp [Ty.kindsOk] at hk
    have hi : kd.imm = true := by
      simp [Ty.retOk] at hr; simp only [Kind.imm]; rcases hr with h | ⟨⟨h1, h2⟩, -⟩ <;> simp [*]
    obtain ⟨hm, hc⟩ := kind_imm hk hi
    cases hrf : kd.rf
    · simp [Ty.tsubst, Ty.relocA, hrf, hi, Ty.relocA_atR _ _ _ _ hm hc]
    · simp only [Ty.tsubst, Ty.relocA, hrf, if_true]; rw [Ty.relocA_atR _ _ _ _ hm hc]; exact look_rf_atR hk hrf _ _
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocA, Ty.retOk, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocA, Ty.retOk, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.relocA, Ty.retOk, Ty.kindsOk]
  | muRs r n i b _ =>
    intro hr hk; simp [Ty.retOk] at hr; simp [Ty.kindsOk] at hk
    simp [Ty.tsubst, Ty.relocA, hr.1.1, Ty.mutFree_tsubst ts b hr.1.1 hk]
  | _ => simp_all [Ty.tsubst, Ty.relocA, Ty.retOk, Ty.kindsOk]

/-- 締めの対象の深さ: imm でない型変数は締めの先より浅い（jumpRel・regionsBelow が保証する形） -/
def Ty.clampSafe (k : Nat) : Ty → Bool
  | .tvar _ r kd => kd.imm || decide (r ≤ k)
  | .opt t => t.clampSafe k
  | .union l r => l.clampSafe k && r.clampSafe k
  | .prod l r => l.clampSafe k && r.clampSafe k
  | .ref false _ t => t.clampSafe k
  | .slice false _ t => t.clampSafe k
  | .map false _ t => t.clampSafe k
  | .muRs r _ _ b => b.mutFree || decide (r ≤ k)
  | _ => true

theorem Ty.clampR_rf (k : Nat) : ∀ t : Ty, t.regionsBelow 0 = true → t.clampR k = t := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.regionsBelow, Ty.clampR]; intro h; simp [h]
  | ref m r t ih => cases m <;> simp_all [Ty.clampR, Ty.regionsBelow]
  | slice m r t ih => cases m <;> simp_all [Ty.clampR, Ty.regionsBelow]
  | map m r t ih => cases m <;> simp_all [Ty.clampR, Ty.regionsBelow]
  | _ => simp_all [Ty.clampR, Ty.regionsBelow]

theorem Ty.tsubst_clampR (ts : List Ty) (k : Nat) : ∀ t : Ty, t.clampSafe k = true → t.kindsOk ts = true →
    (t.tsubst ts).clampR k = (t.clampR k).tsubst ts := by
  intro t; induction t with
  | tvar i r kd =>
    intro hs hk; simp [Ty.kindsOk] at hk; simp [Ty.clampSafe] at hs
    cases hrf : kd.rf
    · cases hi : kd.imm
      · have hle : r ≤ k := by simp_all
        simp only [Ty.tsubst, Ty.clampR, hrf, hi, Ty.clampR_atR_le hle]; simp [Ty.tsubst]
      · obtain ⟨hm, hc⟩ := kind_imm hk hi
        simp only [Ty.tsubst, Ty.clampR, hrf, hi, Ty.clampR_atR_imm _ _ _ hm hc]; simp [Ty.tsubst]
    · obtain ⟨-, hr, -⟩ := look_kind hk
      simp only [Ty.tsubst, Ty.clampR, hrf, if_true, Ty.atR_rf _ _ (hr hrf).1 (hr hrf).2]
      exact Ty.clampR_rf _ _ (hr hrf).1
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.clampR, Ty.clampSafe, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.clampR, Ty.clampSafe, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.clampR, Ty.clampSafe, Ty.kindsOk]
  | muRs r n i b =>
    intro hs hk; simp [Ty.kindsOk] at hk; simp [Ty.clampSafe] at hs
    cases hb : b.mutFree
    · have hle : r ≤ k := by simp_all
      simp [Ty.tsubst, Ty.clampR, hb, Nat.min_eq_left hle]
    · simp [Ty.tsubst, Ty.clampR, hb, Ty.mutFree_tsubst ts b hb hk]
  | _ => simp_all [Ty.tsubst, Ty.clampR, Ty.clampSafe, Ty.kindsOk]

/-! ## 述語の準同型（kind を満たす型引数での代入は性質を保つ） -/

theorem Ty.chanFree_tsubst (ts : List Ty) : ∀ t : Ty, t.chanFree = true → t.kindsOk ts = true → (t.tsubst ts).chanFree = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro hm hk; simp [Ty.kindsOk] at hk; simp [Ty.chanFree] at hm
    obtain ⟨-, hrf, -, hcf, -⟩ := look_kind hk
    simp only [Ty.tsubst, Ty.chanFree_atR]
    rcases hm with h | h
    · exact (hrf h).2
    · exact hcf h
  | _ => simp_all [Ty.tsubst, Ty.chanFree, Ty.kindsOk]

theorem Ty.argFree_tsubst (ts : List Ty) : ∀ t : Ty, t.argFree = true → t.kindsOk ts = true → (t.tsubst ts).argFree = true := by
  intro t; induction t with
  | tvar i r kd => intro _ hk; simp [Ty.kindsOk] at hk; simp only [Ty.tsubst, Ty.argFree_atR]; exact (look_kind hk).1
  | dom r t ih => intro h hk; simp [Ty.argFree, Ty.kindsOk] at h hk; simp [Ty.tsubst, Ty.argFree, Ty.chanFree_tsubst ts t h hk]
  | _ => simp_all [Ty.tsubst, Ty.argFree, Ty.kindsOk]

theorem Ty.regionsBelow_mono : ∀ (t : Ty) {d d' : Nat}, d ≤ d' → t.regionsBelow d = true → t.regionsBelow d' = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; rcases h1 with h1 | h1
    · exact .inl h1
    · exact .inr (by omega)
  | opt t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ih h h1
  | union l r ihl ihr => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨ihl h h1.1, ihr h h1.2⟩
  | prod l r ihl ihr => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨ihl h h1.1, ihr h h1.2⟩
  | ref m r t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, ih h h1.2⟩
  | slice m r t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, ih h h1.2⟩
  | map m r t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, ih h h1.2⟩
  | dom r t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, ih h h1.2⟩
  | own o r t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, ih h h1.2⟩
  | chan rc t ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; exact ⟨by omega, h1.2⟩
  | muRs r n i b ih => intro d d' h h1; simp [Ty.regionsBelow] at h1 ⊢; omega
  | _ => intros; rfl

theorem Ty.localOnly_rf : ∀ t : Ty, t.regionsBelow 0 = true → t.chanFree = true → t.localOnly = true := by
  intro t; induction t <;> simp_all [Ty.localOnly, Ty.regionsBelow, Ty.chanFree]

/-- 端点を持たない（argFree）型の置き直しの上界 -/
theorem Ty.regionsBelow_atR_arg {k d : Nat} (hk : k < d) : ∀ t : Ty, t.argFree = true → (t.atR k).regionsBelow d = true := by
  intro t; induction t with
  | tvar i r kd => simp [Ty.atR, Ty.regionsBelow]; rcases kd with ⟨rf, mf, cf, cov⟩; cases rf <;> cases mf <;> cases cf <;> cases cov <;> simp_all [Kind.imm] <;> omega
  | dom r t ih => intro h; simp [Ty.argFree] at h; simp [Ty.atR, Ty.regionsBelow, hk, Ty.regionsBelow_atR hk t h]
  | _ => simp_all [Ty.atR, Ty.regionsBelow, Ty.argFree]

theorem Ty.regionsBelow_tsubst (ts : List Ty) : ∀ (t : Ty) {d : Nat}, t.regionsBelow d = true → t.kindsOk ts = true →
    (t.tsubst ts).regionsBelow d = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro d h hk; simp [Ty.kindsOk] at hk; simp [Ty.regionsBelow] at h
    obtain ⟨ha, hrf, -⟩ := look_kind hk
    simp only [Ty.tsubst]
    rcases h with h | h
    · rw [Ty.atR_rf _ _ (hrf h).1 (hrf h).2]; exact Ty.regionsBelow_mono _ (Nat.zero_le d) (hrf h).1
    · exact Ty.regionsBelow_atR_arg h _ ha
  | _ => simp_all [Ty.tsubst, Ty.regionsBelow, Ty.kindsOk]

theorem Ty.localOnly_tsubst (ts : List Ty) : ∀ t : Ty, t.localOnly = true → t.kindsOk ts = true → (t.tsubst ts).localOnly = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h hk; simp [Ty.kindsOk] at hk; simp [Ty.localOnly] at h
    obtain ⟨-, hrf, -, hcf, -⟩ := look_kind hk
    simp only [Ty.tsubst]
    rcases h with h | ⟨rfl, h⟩
    · rw [Ty.atR_rf _ _ (hrf h).1 (hrf h).2]; exact Ty.localOnly_rf _ (hrf h).1 (hrf h).2
    · exact Ty.localOnly_atR0 _ (hcf h)
  | chan rc t ih =>
    intro h hk; simp [Ty.localOnly, Ty.kindsOk] at h hk
    simp [Ty.tsubst, Ty.localOnly, h.1.1, Ty.regionsBelow_tsubst ts t h.1.2 hk, Ty.chanFree_tsubst ts t h.2 hk]
  | dom rc t ih =>
    intro h hk; simp [Ty.localOnly, Ty.kindsOk] at h hk
    simp [Ty.tsubst, Ty.localOnly, h.1.1, Ty.regionsBelow_tsubst ts t h.1.2 hk, Ty.chanFree_tsubst ts t h.2 hk]
  | own o rc t ih =>
    intro h hk; simp [Ty.localOnly, Ty.kindsOk] at h hk
    simp [Ty.tsubst, Ty.localOnly, h.1.1, Ty.regionsBelow_tsubst ts t h.1.2 hk, Ty.chanFree_tsubst ts t h.2 hk]
  | _ => simp_all [Ty.tsubst, Ty.localOnly, Ty.kindsOk]

theorem Ty.retOk_tsubst (ts : List Ty) (hw : ∀ i, (look ts i).wfMu = true) : ∀ t : Ty, t.retOk = true → t.kindsOk ts = true →
    (t.tsubst ts).retOk = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h hk; simp [Ty.kindsOk] at hk; simp [Ty.retOk] at h
    obtain ⟨-, hrf, hmf, hcf, -⟩ := look_kind hk
    simp only [Ty.tsubst]
    rcases h with h | ⟨⟨h1, h2⟩, h3⟩
    · have := Ty.retOk_atR (k := 0) (by omega) _ (hw i) (Ty.rf_mf _ (hrf h).1) (hrf h).2
      rw [Ty.atR_rf _ _ (hrf h).1 (hrf h).2] at this ⊢; exact this
    · exact Ty.retOk_atR h3 _ (hw i) (hmf h1) (hcf h2)
  | ref m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.retOk, Ty.kindsOk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.retOk, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.retOk, Ty.kindsOk]
  | muRs r n i b ih =>
    intro h hk; simp [Ty.retOk, Ty.kindsOk] at h hk
    simp [Ty.tsubst, Ty.retOk, h.1.2, Ty.mutFree_tsubst ts b h.1.1 hk, ih h.2 hk]
  | _ => simp_all [Ty.tsubst, Ty.retOk, Ty.kindsOk]

theorem Ty.covOk_rf : ∀ t : Ty, t.regionsBelow 0 = true → t.chanFree = true → t.covOk = true := by
  intro t; induction t with
  | ref m r t ih => cases m <;> simp_all [Ty.covOk, Ty.regionsBelow, Ty.chanFree]
  | slice m r t ih => cases m <;> simp_all [Ty.covOk, Ty.regionsBelow, Ty.chanFree]
  | map m r t ih => cases m <;> simp_all [Ty.covOk, Ty.regionsBelow, Ty.chanFree]
  | _ => simp_all [Ty.covOk, Ty.regionsBelow, Ty.chanFree]

theorem Ty.covOk_tsubst (ts : List Ty) : ∀ t : Ty, t.covOk = true → t.kindsOk ts = true → (t.tsubst ts).covOk = true := by
  intro t; induction t with
  | tvar i r kd =>
    intro h hk; simp [Ty.kindsOk] at hk; simp [Ty.covOk] at h
    obtain ⟨-, hrf, -, -, hcov⟩ := look_kind hk
    simp only [Ty.tsubst]
    rcases h with h | h
    · rw [Ty.atR_rf _ _ (hrf h).1 (hrf h).2]; exact Ty.covOk_rf _ (hrf h).1 (hrf h).2
    · exact Ty.covOk_atR _ _ (hcov h).1
  | ref m r t ih =>
    cases m <;> simp [Ty.covOk, Ty.kindsOk] at *
    intro h1 h2 hk; simp [Ty.tsubst, Ty.covOk, Ty.regionsBelow_tsubst ts t h1 hk, Ty.chanFree_tsubst ts t h2 hk]
  | slice m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.covOk, Ty.kindsOk]
  | map m r t ih => cases m <;> simp_all [Ty.tsubst, Ty.covOk, Ty.kindsOk]
  | _ => simp_all [Ty.tsubst, Ty.covOk, Ty.kindsOk]

/-- 部分型は代入で保たれる（kind を満たす型引数。cov の旗の型変数は、置き直す先を上げてよい） -/
theorem Ty.sub_tsubst (ts : List Ty) : ∀ (a b : Ty), Ty.sub a b = true → a.kindsOk ts = true → b.kindsOk ts = true →
    Ty.sub (a.tsubst ts) (b.tsubst ts) = true := by
  intro a; induction a with
  | tvar i r kd =>
    intro b h ha _; simp [Ty.kindsOk] at ha
    cases b with
    | tvar j r' kd' =>
      simp [Ty.sub] at h; obtain ⟨⟨rfl, rfl⟩, h⟩ := h
      obtain ⟨-, -, -, -, hcov⟩ := look_kind ha
      simp only [Ty.tsubst]
      rcases h with (rfl | h) | ⟨h1, h2⟩
      · exact Ty.sub_refl _
      · rw [look_rf_atR ha h r r']; exact Ty.sub_refl _
      · exact Ty.sub_atR_mono h2 _ (hcov h1).1 (hcov h1).2.1 (hcov h1).2.2
    | _ => simp [Ty.sub] at h
  | opt t ih => intro b h ha hb; cases b <;> simp_all [Ty.sub, Ty.tsubst, Ty.kindsOk]
  | union l r ihl ihr => intro b h ha hb; cases b <;> simp_all [Ty.sub, Ty.tsubst, Ty.kindsOk]
  | prod l r ihl ihr => intro b h ha hb; cases b <;> simp_all [Ty.sub, Ty.tsubst, Ty.kindsOk]
  | ref m r t ih =>
    intro b h ha hb
    cases b with
    | ref m' r' t' =>
      cases m <;> cases m' <;> simp [Ty.sub] at h
      · obtain ⟨h1, rfl⟩ := h; simp [Ty.tsubst, Ty.sub, h1]
      · obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _
    | _ => cases m <;> simp [Ty.sub] at h
  | slice m r t ih =>
    intro b h ha hb
    cases b with
    | slice m' r' t' =>
      cases m <;> cases m' <;> simp [Ty.sub] at h
      · simp [Ty.kindsOk] at ha hb; simp [Ty.tsubst, Ty.sub, h.1, ih t' h.2 ha hb]
      · obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _
    | _ => cases m <;> simp [Ty.sub] at h
  | map m r t ih =>
    intro b h ha hb
    cases b with
    | map m' r' t' =>
      cases m <;> cases m' <;> simp [Ty.sub] at h
      · simp [Ty.kindsOk] at ha hb; simp [Ty.tsubst, Ty.sub, h.1, ih t' h.2 ha hb]
      · obtain ⟨rfl, rfl⟩ := h; exact Ty.sub_refl _
    | _ => cases m <;> simp [Ty.sub] at h
  | dom r t ih => intro b h ha hb; cases b <;> simp_all [Ty.sub, Ty.tsubst, Ty.kindsOk]
  | muRs r n i bb ih =>
    intro b h ha hb; cases b with
    | muRs r' n' i' b' =>
      simp [Ty.sub] at h; obtain ⟨⟨⟨rfl, rfl⟩, rfl⟩, h⟩ := h
      simp [Ty.kindsOk] at ha
      simp only [Ty.sub, Ty.tsubst]
      rcases h with rfl | ⟨h1, h2⟩
      · simp
      · simp [h1, Ty.covOk_tsubst ts bb h2 ha]
    | _ => simp [Ty.sub] at h
  | _ => intro b h _ _; simp [Ty.sub] at h; subst h; exact Ty.sub_refl _

/-! ## 代入の合成（入れ子のジェネリック: 型引数が外の型変数を含む） -/

theorem look_map (f : Ty → Ty) (hf : f .int = .int) (ts : List Ty) (i : Nat) : look (ts.map f) i = f (look ts i) := by
  unfold look
  induction ts generalizing i with
  | nil => simp [hf]
  | cons t ts ih => cases i with
    | zero => rfl
    | succ n => simp only [List.map_cons, List.getD_cons_succ]; exact ih n

theorem Ty.atR_tsubst (us : List Ty) (ρ : Nat) : ∀ s : Ty, s.kindsOk us = true → (s.atR ρ).tsubst us = (s.tsubst us).atR ρ := by
  intro s; induction s with
  | tvar j r kd =>
    intro hk; simp [Ty.kindsOk] at hk
    simp only [Ty.atR, Ty.tsubst, Ty.atR_atR]
    cases hr : kd.rf
    · simp
    · simp only [if_true]; exact look_rf_atR hk hr _ _
  | _ => simp_all [Ty.atR, Ty.tsubst, Ty.kindsOk]

theorem Ty.tsubst_comp (ts us : List Ty) (hus : ∀ i, (look ts i).kindsOk us = true) :
    ∀ t : Ty, (t.tsubst ts).tsubst us = t.tsubst (ts.map (Ty.tsubst us)) := by
  intro t; induction t with
  | tvar i r kd => simp only [Ty.tsubst, look_map (Ty.tsubst us) rfl, Ty.atR_tsubst us r _ (hus i)]
  | _ => simp_all [Ty.tsubst]

theorem Ty.kindsOk_tsubst {ts us : List Ty} (hus : ∀ i, (look ts i).kindsOk us = true) :
    ∀ t : Ty, t.kindsOk ts = true → (∀ i k, kindOk k (look ts i) = true → kindOk k ((look ts i).tsubst us) = true) →
      t.kindsOk (ts.map (Ty.tsubst us)) = true := by
  intro t; induction t with
  | tvar i r kd => intro h hk; simp [Ty.kindsOk] at h ⊢; rw [look_map (Ty.tsubst us) rfl]; exact hk i kd h
  | _ => simp_all [Ty.kindsOk]

/-- 入れ子の kind: 外の型変数を含む型引数 s が kind k を満たし、外の型引数 us が s の型変数の kind を満たせば、代入した型も k を満たす -/
theorem kindOk_tsubst {us : List Ty} {k : Kind} {s : Ty} (h : kindOk k s = true) (hs : s.kindsOk us = true) :
    kindOk k (s.tsubst us) = true := by
  simp only [kindOk, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true'] at h ⊢
  obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := h
  refine ⟨⟨⟨⟨Ty.argFree_tsubst us s h1 hs, ?_⟩, ?_⟩, ?_⟩, ?_⟩
  · rcases h2 with h | h; · exact .inl h
    exact .inr ⟨Ty.regionsBelow_tsubst us s h.1 hs, Ty.chanFree_tsubst us s h.2 hs⟩
  · rcases h3 with h | h; · exact .inl h
    exact .inr (Ty.mutFree_tsubst us s h hs)
  · rcases h4 with h | h; · exact .inl h
    exact .inr (Ty.chanFree_tsubst us s h hs)
  · rcases h5 with h | h; · exact .inl h
    exact .inr ⟨⟨Ty.covOk_tsubst us s h.1.1 hs, Ty.mutFree_tsubst us s h.1.2 hs⟩, Ty.chanFree_tsubst us s h.2 hs⟩

end R3M
