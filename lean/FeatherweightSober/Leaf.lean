import FeatherweightSober.Fam

/-!
# 葉の 1 歩の π 非依存・K 非依存（段 6 P1 — Kahn.lean の下ごしらえ）

旧チャネルの redex（send / recv の chanV）と旧 par / parch / newchan を除く葉（eval / ret / panic）の 1 歩は、経路 π を見ず、
チャネルストア K を読まず変えず、結果も葉（eval / ret / panic）。step の腕の全数の場合分けで示す（frame ごとの定理に分けて並列に elaborate）。
`step Δ π' s K2 = (step Δ π s K).map (fun p => (p.1.fixLeaf, K2))` の 1 本の等式に 3 つを畳む（fixLeaf は葉なら恒等）。
-/
namespace FS

/-- 葉なら恒等・葉でなければ panic（等式の右辺で「結果は葉」を rfl で言うための写し） -/
def State.fixLeaf : State → State
  | .eval H S e => .eval H S e
  | .ret H S v => .ret H S v
  | .panic H => .panic H
  | _ => .panic []

syntax "kR" : tactic
macro_rules
  | `(tactic| kR) => `(tactic| first | rfl | (simp only [step]; repeat' split) <;> rfl)

set_option maxHeartbeats 0 in
theorem stepLeaf_letK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (b : Expr) :
    step Δ π' (.ret H ((.letK b) :: S) v) K2 = (step Δ π (.ret H ((.letK b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_addL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (b : Expr) :
    step Δ π' (.ret H ((.addL b) :: S) v) K2 = (step Δ π (.ret H ((.addL b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_addR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (a : Expr) :
    step Δ π' (.ret H ((.addR a) :: S) v) K2 = (step Δ π (.ret H ((.addR a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> cases v <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_ltL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (b : Expr) :
    step Δ π' (.ret H ((.ltL b) :: S) v) K2 = (step Δ π (.ret H ((.ltL b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_ltR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (a : Expr) :
    step Δ π' (.ret H ((.ltR a) :: S) v) K2 = (step Δ π (.ret H ((.ltR a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> cases v <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_arithL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : ArithOp) (b : Expr) :
    step Δ π' (.ret H ((.arithL op b) :: S) v) K2 = (step Δ π (.ret H ((.arithL op b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_arithR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : ArithOp) (a : Expr) :
    step Δ π' (.ret H ((.arithR op a) :: S) v) K2 = (step Δ π (.ret H ((.arithR op a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> cases v <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_cmpL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : CmpOp) (b : Expr) :
    step Δ π' (.ret H ((.cmpL op b) :: S) v) K2 = (step Δ π (.ret H ((.cmpL op b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_cmpR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : CmpOp) (a : Expr) :
    step Δ π' (.ret H ((.cmpR op a) :: S) v) K2 = (step Δ π (.ret H ((.cmpR op a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> cases v <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_iteK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Expr) (e : Expr) :
    step Δ π' (.ret H ((.iteK t e) :: S) v) K2 = (step Δ π (.ret H ((.iteK t e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_someK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.someK) :: S) v) K2 = (step Δ π (.ret H ((.someK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_ifnilK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (n : Expr) (s : Expr) :
    step Δ π' (.ret H ((.ifnilK n s) :: S) v) K2 = (step Δ π (.ret H ((.ifnilK n s) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_inlK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (r : Ty) :
    step Δ π' (.ret H ((.inlK r) :: S) v) K2 = (step Δ π (.ret H ((.inlK r) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_inrK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (l : Ty) :
    step Δ π' (.ret H ((.inrK l) :: S) v) K2 = (step Δ π (.ret H ((.inrK l) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_caseK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (l : Expr) (r : Expr) :
    step Δ π' (.ret H ((.caseK l r) :: S) v) K2 = (step Δ π (.ret H ((.caseK l r) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_pairL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (b : Expr) :
    step Δ π' (.ret H ((.pairL b) :: S) v) K2 = (step Δ π (.ret H ((.pairL b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_pairR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (a : Expr) :
    step Δ π' (.ret H ((.pairR a) :: S) v) K2 = (step Δ π (.ret H ((.pairR a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_fstK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.fstK) :: S) v) K2 = (step Δ π (.ret H ((.fstK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_annK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.annK t) :: S) v) K2 = (step Δ π (.ret H ((.annK t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_sndK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.sndK) :: S) v) K2 = (step Δ π (.ret H ((.sndK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_allocK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (m : Bool) :
    step Δ π' (.ret H ((.allocK m) :: S) v) K2 = (step Δ π (.ret H ((.allocK m) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_derefK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.derefK) :: S) v) K2 = (step Δ π (.ret H ((.derefK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_assignL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (e : Expr) :
    step Δ π' (.ret H ((.assignL e) :: S) v) K2 = (step Δ π (.ret H ((.assignL e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_assignR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (l : Expr) :
    step Δ π' (.ret H ((.assignR l) :: S) v) K2 = (step Δ π (.ret H ((.assignR l) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases l <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_whileK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (c : Expr) (b : Expr) :
    step Δ π' (.ret H ((.whileK c b) :: S) v) K2 = (step Δ π (.ret H ((.whileK c b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_whileB (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (c : Expr) (b : Expr) :
    step Δ π' (.ret H ((.whileB c b) :: S) v) K2 = (step Δ π (.ret H ((.whileB c b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_regionK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.regionK) :: S) v) K2 = (step Δ π (.ret H ((.regionK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_regionKR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.regionKR t) :: S) v) K2 = (step Δ π (.ret H ((.regionKR t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_copyK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (k : Nat) (t : Ty) :
    step Δ π' (.ret H ((.copyK k t) :: S) v) K2 = (step Δ π (.ret H ((.copyK k t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_freezeK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.freezeK) :: S) v) K2 = (step Δ π (.ret H ((.freezeK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_sendL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (e : Expr) :
    step Δ π' (.ret H ((.sendL e) :: S) v) K2 = (step Δ π (.ret H ((.sendL e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_sendR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (c : Expr) (hs : ∀ n, c ≠ .chanV n) :
    step Δ π' (.ret H ((.sendR c) :: S) v) K2 = (step Δ π (.ret H ((.sendR c) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases c <;> first | kR | (exact absurd rfl (hs _))

set_option maxHeartbeats 0 in
theorem stepLeaf_recvK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  (hr : ∀ n, v ≠ .chanV n) :
    step Δ π' (.ret H ((.recvK) :: S) v) K2 = (step Δ π (.ret H ((.recvK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases v <;> first | kR | (exact absurd rfl (hr _))

set_option maxHeartbeats 0 in
theorem stepLeaf_callK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (fn : Nat) (ts : List Ty) :
    step Δ π' (.ret H ((.callK fn ts) :: S) v) K2 = (step Δ π (.ret H ((.callK fn ts) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_callMK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (fn : Nat) (ts : List Ty) :
    step Δ π' (.ret H ((.callMK fn ts) :: S) v) K2 = (step Δ π (.ret H ((.callMK fn ts) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_callvL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (e : Expr) :
    step Δ π' (.ret H ((.callvL e) :: S) v) K2 = (step Δ π (.ret H ((.callvL e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_callvR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (fv : Expr) :
    step Δ π' (.ret H ((.callvR fv) :: S) v) K2 = (step Δ π (.ret H ((.callvR fv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases fv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_fretK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.fretK t) :: S) v) K2 = (step Δ π (.ret H ((.fretK t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_idxL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (ot : Option Ty) (i : Expr) :
    step Δ π' (.ret H ((.idxL ot i) :: S) v) K2 = (step Δ π (.ret H ((.idxL ot i) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_idxR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (ot : Option Ty) (sv : Expr) :
    step Δ π' (.ret H ((.idxR ot sv) :: S) v) K2 = (step Δ π (.ret H ((.idxR ot sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_lenK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.lenK) :: S) v) K2 = (step Δ π (.ret H ((.lenK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_tobyteK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.tobyteK) :: S) v) K2 = (step Δ π (.ret H ((.tobyteK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_tointK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.tointK) :: S) v) K2 = (step Δ π (.ret H ((.tointK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_farithL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : FArithOp) (b : Expr) :
    step Δ π' (.ret H ((.farithL op b) :: S) v) K2 = (step Δ π (.ret H ((.farithL op b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_farithR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : FArithOp) (a : Expr) :
    step Δ π' (.ret H ((.farithR op a) :: S) v) K2 = (step Δ π (.ret H ((.farithR op a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_fcmpL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : FCmpOp) (b : Expr) :
    step Δ π' (.ret H ((.fcmpL op b) :: S) v) K2 = (step Δ π (.ret H ((.fcmpL op b) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_fcmpR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : FCmpOp) (a : Expr) :
    step Δ π' (.ret H ((.fcmpR op a) :: S) v) K2 = (step Δ π (.ret H ((.fcmpR op a) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases a <;> first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_fconvK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (op : FConvOp) :
    step Δ π' (.ret H ((.fconvK op) :: S) v) K2 = (step Δ π (.ret H ((.fconvK op) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases op <;> cases v <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_appL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (w : Expr) :
    step Δ π' (.ret H ((.appL w) :: S) v) K2 = (step Δ π (.ret H ((.appL w) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_appR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) :
    step Δ π' (.ret H ((.appR sv) :: S) v) K2 = (step Δ π (.ret H ((.appR sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_sixL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (i : Expr) (w : Expr) :
    step Δ π' (.ret H ((.sixL i w) :: S) v) K2 = (step Δ π (.ret H ((.sixL i w) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_sixM (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (w : Expr) :
    step Δ π' (.ret H ((.sixM sv w) :: S) v) K2 = (step Δ π (.ret H ((.sixM sv w) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_sixR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (iv : Expr) :
    step Δ π' (.ret H ((.sixR sv iv) :: S) v) K2 = (step Δ π (.ret H ((.sixR sv iv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> first | kR | (cases iv <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_subL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sa : Expr) (sb : Expr) :
    step Δ π' (.ret H ((.subL sa sb) :: S) v) K2 = (step Δ π (.ret H ((.subL sa sb) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_subM (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (sb : Expr) :
    step Δ π' (.ret H ((.subM sv sb) :: S) v) K2 = (step Δ π (.ret H ((.subM sv sb) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_subR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (av : Expr) :
    step Δ π' (.ret H ((.subR sv av) :: S) v) K2 = (step Δ π (.ret H ((.subR sv av) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> first | kR | (cases av <;> first | kR | (cases v <;> kR))

set_option maxHeartbeats 0 in
theorem stepLeaf_eqsL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (e2 : Expr) :
    step Δ π' (.ret H ((.eqsL e2) :: S) v) K2 = (step Δ π (.ret H ((.eqsL e2) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_eqsR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) :
    step Δ π' (.ret H ((.eqsR sv) :: S) v) K2 = (step Δ π (.ret H ((.eqsR sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_catL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (e2 : Expr) :
    step Δ π' (.ret H ((.catL e2) :: S) v) K2 = (step Δ π (.ret H ((.catL e2) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_catR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) :
    step Δ π' (.ret H ((.catR sv) :: S) v) K2 = (step Δ π (.ret H ((.catR sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_gtmL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) (k : Expr) :
    step Δ π' (.ret H ((.gtmL t k) :: S) v) K2 = (step Δ π (.ret H ((.gtmL t k) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_gtmR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) (sv : Expr) :
    step Δ π' (.ret H ((.gtmR t sv) :: S) v) K2 = (step Δ π (.ret H ((.gtmR t sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_stmL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (k : Expr) (w : Expr) :
    step Δ π' (.ret H ((.stmL k w) :: S) v) K2 = (step Δ π (.ret H ((.stmL k w) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_stmM (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (w : Expr) :
    step Δ π' (.ret H ((.stmM sv w) :: S) v) K2 = (step Δ π (.ret H ((.stmM sv w) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_stmR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (kv : Expr) :
    step Δ π' (.ret H ((.stmR sv kv) :: S) v) K2 = (step Δ π (.ret H ((.stmR sv kv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_dlmL (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) (k : Expr) :
    step Δ π' (.ret H ((.dlmL t k) :: S) v) K2 = (step Δ π (.ret H ((.dlmL t k) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_dlmR (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) (sv : Expr) :
    step Δ π' (.ret H ((.dlmR t sv) :: S) v) K2 = (step Δ π (.ret H ((.dlmR t sv) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_lenmK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.lenmK) :: S) v) K2 = (step Δ π (.ret H ((.lenmK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_keysmK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)  :
    step Δ π' (.ret H ((.keysmK) :: S) v) K2 = (step Δ π (.ret H ((.keysmK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_labelK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.labelK t) :: S) v) K2 = (step Δ π (.ret H ((.labelK t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_jumpK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (n : Nat) :
    step Δ π' (.ret H ((.jumpK n) :: S) v) K2 = (step Δ π (.ret H ((.jumpK n) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_scopeK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t ε : Ty) :
    step Δ π' (.ret H ((.scopeK t ε) :: S) v) K2 = (step Δ π (.ret H ((.scopeK t ε) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_spawnK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (a : Expr) (e : Expr) :
    step Δ π' (.ret H ((.spawnK a e) :: S) v) K2 = (step Δ π (.ret H ((.spawnK a e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_spawnA (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (sv : Expr) (e : Expr) :
    step Δ π' (.ret H ((.spawnA sv e) :: S) v) K2 = (step Δ π (.ret H ((.spawnA sv e) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases sv <;> kR

set_option maxHeartbeats 0 in
theorem stepLeaf_joinK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.joinK t) :: S) v) K2 = (step Δ π (.ret H ((.joinK t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_closeK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) :
    step Δ π' (.ret H ((.closeK) :: S) v) K2 = (step Δ π (.ret H ((.closeK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

theorem stepLeaf_taskK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) :
    step Δ π' (.ret H ((.taskK) :: S) v) K2 = (step Δ π (.ret H ((.taskK) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  simp [step]

set_option maxHeartbeats 0 in
theorem stepLeaf_tryK (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt) (t : Ty) :
    step Δ π' (.ret H ((.tryK t) :: S) v) K2 = (step Δ π (.ret H ((.tryK t) :: S) v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  first | kR | (cases v <;> kR)

set_option maxHeartbeats 0 in
theorem stepLeaf_eval (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (e : Expr) (K K2 : ChanSt)
    (hn : ∀ rc t, e ≠ .newchan rc t) (hp : ∀ t a b, e ≠ .parch t a b) (hq : ∀ a b, e ≠ .par a b) :
    step Δ π' (.eval H S e) K2 = (step Δ π (.eval H S e) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases e
  all_goals first
    | (exact absurd rfl (hn _ _))
    | (exact absurd rfl (hp _ _ _))
    | (exact absurd rfl (hq _ _))
    | kR

/-- 旧チャネルの redex でない ret の 1 歩 -/
theorem stepLeaf_ret (Δ : Defs) (π π' : List Bool) (H : Heap) (S : Stack) (v : Expr) (K K2 : ChanSt)
    (hs : ∀ S' c, S ≠ .sendR (.chanV c) :: S') (hr : ∀ S' c, S = .recvK :: S' → v ≠ .chanV c) :
    step Δ π' (.ret H S v) K2 = (step Δ π (.ret H S v) K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases S with
  | nil => rfl
  | cons f S =>
    cases f with
    | letK b => exact stepLeaf_letK Δ π π' H S v K K2 b
    | addL b => exact stepLeaf_addL Δ π π' H S v K K2 b
    | addR a => exact stepLeaf_addR Δ π π' H S v K K2 a
    | ltL b => exact stepLeaf_ltL Δ π π' H S v K K2 b
    | ltR a => exact stepLeaf_ltR Δ π π' H S v K K2 a
    | arithL op b => exact stepLeaf_arithL Δ π π' H S v K K2 op b
    | arithR op a => exact stepLeaf_arithR Δ π π' H S v K K2 op a
    | cmpL op b => exact stepLeaf_cmpL Δ π π' H S v K K2 op b
    | cmpR op a => exact stepLeaf_cmpR Δ π π' H S v K K2 op a
    | iteK t e => exact stepLeaf_iteK Δ π π' H S v K K2 t e
    | someK => exact stepLeaf_someK Δ π π' H S v K K2
    | ifnilK n s => exact stepLeaf_ifnilK Δ π π' H S v K K2 n s
    | inlK r => exact stepLeaf_inlK Δ π π' H S v K K2 r
    | inrK l => exact stepLeaf_inrK Δ π π' H S v K K2 l
    | caseK l r => exact stepLeaf_caseK Δ π π' H S v K K2 l r
    | pairL b => exact stepLeaf_pairL Δ π π' H S v K K2 b
    | pairR a => exact stepLeaf_pairR Δ π π' H S v K K2 a
    | fstK => exact stepLeaf_fstK Δ π π' H S v K K2
    | annK t => exact stepLeaf_annK Δ π π' H S v K K2 t
    | sndK => exact stepLeaf_sndK Δ π π' H S v K K2
    | allocK m => exact stepLeaf_allocK Δ π π' H S v K K2 m
    | derefK => exact stepLeaf_derefK Δ π π' H S v K K2
    | assignL e => exact stepLeaf_assignL Δ π π' H S v K K2 e
    | assignR l => exact stepLeaf_assignR Δ π π' H S v K K2 l
    | whileK c b => exact stepLeaf_whileK Δ π π' H S v K K2 c b
    | whileB c b => exact stepLeaf_whileB Δ π π' H S v K K2 c b
    | regionK => exact stepLeaf_regionK Δ π π' H S v K K2
    | regionKR t => exact stepLeaf_regionKR Δ π π' H S v K K2 t
    | copyK k t => exact stepLeaf_copyK Δ π π' H S v K K2 k t
    | freezeK => exact stepLeaf_freezeK Δ π π' H S v K K2
    | sendL e => exact stepLeaf_sendL Δ π π' H S v K K2 e
    | sendR c => exact stepLeaf_sendR Δ π π' H S v K K2 c (fun n h => hs S n (by rw [h]))
    | recvK => exact stepLeaf_recvK Δ π π' H S v K K2 (fun n h => hr S n rfl h)
    | callK fn ts => exact stepLeaf_callK Δ π π' H S v K K2 fn ts
    | callMK fn ts => exact stepLeaf_callMK Δ π π' H S v K K2 fn ts
    | callvL e => exact stepLeaf_callvL Δ π π' H S v K K2 e
    | callvR fv => exact stepLeaf_callvR Δ π π' H S v K K2 fv
    | fretK t => exact stepLeaf_fretK Δ π π' H S v K K2 t
    | idxL ot i => exact stepLeaf_idxL Δ π π' H S v K K2 ot i
    | idxR ot sv => exact stepLeaf_idxR Δ π π' H S v K K2 ot sv
    | lenK => exact stepLeaf_lenK Δ π π' H S v K K2
    | tobyteK => exact stepLeaf_tobyteK Δ π π' H S v K K2
    | tointK => exact stepLeaf_tointK Δ π π' H S v K K2
    | farithL op b => exact stepLeaf_farithL Δ π π' H S v K K2 op b
    | farithR op a => exact stepLeaf_farithR Δ π π' H S v K K2 op a
    | fcmpL op b => exact stepLeaf_fcmpL Δ π π' H S v K K2 op b
    | fcmpR op a => exact stepLeaf_fcmpR Δ π π' H S v K K2 op a
    | fconvK op => exact stepLeaf_fconvK Δ π π' H S v K K2 op
    | appL w => exact stepLeaf_appL Δ π π' H S v K K2 w
    | appR sv => exact stepLeaf_appR Δ π π' H S v K K2 sv
    | sixL i w => exact stepLeaf_sixL Δ π π' H S v K K2 i w
    | sixM sv w => exact stepLeaf_sixM Δ π π' H S v K K2 sv w
    | sixR sv iv => exact stepLeaf_sixR Δ π π' H S v K K2 sv iv
    | subL sa sb => exact stepLeaf_subL Δ π π' H S v K K2 sa sb
    | subM sv sb => exact stepLeaf_subM Δ π π' H S v K K2 sv sb
    | subR sv av => exact stepLeaf_subR Δ π π' H S v K K2 sv av
    | eqsL e2 => exact stepLeaf_eqsL Δ π π' H S v K K2 e2
    | eqsR sv => exact stepLeaf_eqsR Δ π π' H S v K K2 sv
    | catL e2 => exact stepLeaf_catL Δ π π' H S v K K2 e2
    | catR sv => exact stepLeaf_catR Δ π π' H S v K K2 sv
    | gtmL t k => exact stepLeaf_gtmL Δ π π' H S v K K2 t k
    | gtmR t sv => exact stepLeaf_gtmR Δ π π' H S v K K2 t sv
    | stmL k w => exact stepLeaf_stmL Δ π π' H S v K K2 k w
    | stmM sv w => exact stepLeaf_stmM Δ π π' H S v K K2 sv w
    | stmR sv kv => exact stepLeaf_stmR Δ π π' H S v K K2 sv kv
    | dlmL t k => exact stepLeaf_dlmL Δ π π' H S v K K2 t k
    | dlmR t sv => exact stepLeaf_dlmR Δ π π' H S v K K2 t sv
    | lenmK => exact stepLeaf_lenmK Δ π π' H S v K K2
    | keysmK => exact stepLeaf_keysmK Δ π π' H S v K K2
    | labelK t => exact stepLeaf_labelK Δ π π' H S v K K2 t
    | jumpK n => exact stepLeaf_jumpK Δ π π' H S v K K2 n
    | scopeK t ε => exact stepLeaf_scopeK Δ π π' H S v K K2 t ε
    | spawnK a e => exact stepLeaf_spawnK Δ π π' H S v K K2 a e
    | spawnA sv e => exact stepLeaf_spawnA Δ π π' H S v K K2 sv e
    | joinK t => exact stepLeaf_joinK Δ π π' H S v K K2 t
    | taskK => exact stepLeaf_taskK Δ π π' H S v K K2
    | closeK => exact stepLeaf_closeK Δ π π' H S v K K2
    | tryK t => exact stepLeaf_tryK Δ π π' H S v K K2 t

/-- 旧構成子の redex（task の中では famMain が横取りして panic にする形） -/
def State.legRedex : State → Bool
  | .eval _ _ (.par _ _) => true
  | .eval _ _ (.parch _ _ _) => true
  | .eval _ _ (.newchan _ _) => true
  | .ret _ (.sendR (.chanV _) :: _) _ => true
  | .ret _ (.recvK :: _) (.chanV _) => true
  | _ => false

/-- 葉（fixLeaf で不動）で旧構成子の redex でない状態の 1 歩 -/
theorem stepLeaf_all (Δ : Defs) (π π' : List Bool) (s : State) (K K2 : ChanSt)
    (hl : s.fixLeaf = s) (hr : s.legRedex = false) :
    step Δ π' s K2 = (step Δ π s K).map (fun p => (p.1.fixLeaf, K2)) := by
  cases s with
  | eval H S e =>
    exact stepLeaf_eval Δ π π' H S e K K2 (fun _ _ h => by subst h; simp [State.legRedex] at hr)
      (fun _ _ _ h => by subst h; simp [State.legRedex] at hr) (fun _ _ h => by subst h; simp [State.legRedex] at hr)
  | ret H S v =>
    exact stepLeaf_ret Δ π π' H S v K K2 (fun _ _ h => by subst h; simp [State.legRedex] at hr)
      (fun _ _ hS hv => by subst hS; subst hv; simp [State.legRedex] at hr)
  | panic H => rfl
  | par => simp [State.fixLeaf] at hl
  | fam => simp [State.fixLeaf] at hl

/-- 使い口: 葉の 1 歩は K を変えず、結果も葉で、どの π・どの K でも同じ歩 -/
theorem stepLeaf_some {Δ : Defs} {π : List Bool} {s s' : State} {K K' : ChanSt}
    (hl : s.fixLeaf = s) (hr : s.legRedex = false) (h : step Δ π s K = some (s', K')) :
    K' = K ∧ s'.fixLeaf = s' ∧ ∀ π' K2, step Δ π' s K2 = some (s', K2) := by
  have e0 := stepLeaf_all Δ π π s K K hl hr
  rw [h] at e0
  simp only [Option.map_some, Option.some.injEq, Prod.mk.injEq] at e0
  obtain ⟨h1, h2⟩ := e0
  refine ⟨h2, h1.symm, fun π' K2 => ?_⟩
  rw [stepLeaf_all Δ π π' s K K2 hl hr, h]
  simp [← h1]

end FS
