/-!
# Tls — TLS 1.3 のサーバの handshake の状態機械の抽象（TLS 便 R6 — report-838 / 839）

std/internal/hs の Feed（record の枠 1 つを受ける）と、送りの口（SealApp / AlertRecord — std/tls の Send / die も同じ形）を、
暗号の中身を捨てた有限の事象の上の遷移に写したモデル。コア（Syntax / Typing …）には依存しない。

- 状態: Phase と、互換の CCS を受けたか（ccs）・HelloRetryRequest を送ったか（hrr）・受け / 送りの鍵の世代（rd / wr — 0 = 鍵なし・
  1 = handshake の鍵・2 + k = application の鍵の k 回目の更新）・送りの seq・相手の update_requested の保留（upd）
- 事象（Feed が見る record の分類 — report-838 2.1 の 13 種。KeyUpdate は request の有無を持つ）
- 送りの nonce = 鍵の世代ごとの iv ⊕ seq なので、(wr, seq) の組が重ならなければ nonce は重ならない（定理 3）

定理（report-790 の候補 4 つ）:
1. `app_only_connected` / `enter_connected` — 平文を渡すのは Connected だけ・Connected に入るのは WaitFin の FinOk だけ
2. `plain_after_keys` — 受けの鍵がある状態では暗号化前の事象は全部誤り（例外 = WaitFin の CCS 1 枚）
3. `nonce_unique` — 任意の入力の列で、送った record の (wr, seq) の列は重複なし
4. `err_closes` / `not_allowed_err` / `closed_absorbs` — 誤りは必ず Closed に落ち、許された表の外は誤り、Closed は吸収

遷移表は `sober-gen --tlsfsm` が印字し（`table`）、testdata/tls/fsm.golden と std/tls の TestFsm（hs_fsm_test.sober — Sober の hs.Feed を偽の転送路で駆動）の
両方と突き合わせる（scripts/tlsfsm.sh）。
-/

namespace FS.Tls

inductive Phase
  | start | waitCH2 | waitFin | connected | closed
  deriving DecidableEq, Repr

structure St where
  ph : Phase
  ccs : Bool
  hrr : Bool
  rd : Nat
  wr : Nat
  seq : Nat
  upd : Bool
  deriving DecidableEq, Repr

/-- Feed が見る record の分類。ch〜plainOther は暗号化前（plainOther = handshake / CCS 以外の平文 — alert）・forged 以降は暗号化した record -/
inductive Ev
  | ch | chRetry | chBad | ccs | plainOther
  | forged | finOk | finBad | app | keyUpd (req : Bool) | alertClose | alertOther | sealedOther
  deriving DecidableEq, Repr

structure Out where
  app : Bool := false
  done : Bool := false
  closed : Bool := false
  upd : Bool := false
  err : Option Nat := none
  sent : List (Nat × Nat) := []

-- alert の番号（RFC 9846 6）
def aUnexpected : Nat := 10
def aBadMac : Nat := 20
def aIllegal : Nat := 47
def aDecode : Nat := 50
def aDecrypt : Nat := 51
def aInternal : Nat := 80

def init : St := { ph := .start, ccs := false, hrr := false, rd := 0, wr := 0, seq := 0, upd := false }

/-- 誤り: alert a を返して Closed に落ちる（Feed が自分で落ちる — report-838 4 節 ②） -/
def fail (s : St) (a : Nat) : St × Out := ({ s with ph := .closed }, { err := some a })

/-- 互換の CCS は 1 枚だけ -/
def ccsOnce (s : St) : St × Out :=
  if s.ccs then fail s aUnexpected else ({ s with ccs := true }, {})

/-- サーバの flight: handshake の鍵（wr 世代 1・seq 0）で 1 record に封じ、送りを application の鍵（世代 2）へ・受けを handshake の鍵へ -/
def flight (s : St) : St × Out :=
  ({ s with ph := .waitFin, rd := 1, wr := 2, seq := 0 }, { sent := [(1, 0)] })

def step (s : St) (e : Ev) : St × Out :=
  match s.ph, e with
  | .closed, _ => fail s aUnexpected
  | .start, .ch => flight s
  | .start, .chRetry => ({ s with ph := .waitCH2, hrr := true }, {})
  | .waitCH2, .ch => flight s
  | .waitCH2, .chRetry => fail s aIllegal
  | .start, .chBad => fail s aDecode
  | .waitCH2, .chBad => fail s aDecode
  | .start, .ccs => ccsOnce s
  | .waitCH2, .ccs => ccsOnce s
  | .waitFin, .ccs => ccsOnce s
  | .waitFin, .forged => fail s aBadMac
  | .connected, .forged => fail s aBadMac
  | .waitFin, .finOk => ({ s with ph := .connected, rd := 2 }, { done := true })
  | .waitFin, .finBad => fail s aDecrypt
  | .connected, .app => (s, { app := true })
  | .connected, .keyUpd r => ({ s with rd := s.rd + 1, upd := s.upd || r }, { upd := r })
  | .waitFin, .alertClose => ({ s with ph := .closed }, { closed := true })
  | .waitFin, .alertOther => ({ s with ph := .closed }, { closed := true })
  | .connected, .alertClose => ({ s with ph := .closed }, { closed := true })
  | .connected, .alertOther => ({ s with ph := .closed }, { closed := true })
  | _, _ => fail s aUnexpected

/-- 送りの application data（SealApp / tls.Send）: 相手の update_requested か鍵の使用上限（lim）なら、先に今の鍵で KeyUpdate を送って鍵を進める -/
def sendApp (s : St) (lim : Bool) : St × Out :=
  if s.ph = .connected then
    if s.upd || lim then
      ({ s with wr := s.wr + 1, seq := 1, upd := false }, { sent := [(s.wr, s.seq), (s.wr + 1, 0)] })
    else ({ s with seq := s.seq + 1 }, { sent := [(s.wr, s.seq)] })
  else (s, { err := some aInternal })

/-- 送りの alert（AlertRecord）: 送りの鍵があれば封じる。送った後は閉じる -/
def sendAlert (s : St) : St × Out :=
  if 1 ≤ s.wr then ({ s with ph := .closed, seq := s.seq + 1 }, { sent := [(s.wr, s.seq)] })
  else ({ s with ph := .closed }, {})

inductive In
  | feed (e : Ev)
  | sendApp (lim : Bool)
  | sendAlert

def stepIn (s : St) : In → St × Out
  | .feed e => step s e
  | .sendApp l => sendApp s l
  | .sendAlert => sendAlert s

/-- 入力の列で送った record の (wr, seq) を繋いだ列 -/
def sentOf (s : St) : List In → List (Nat × Nat)
  | [] => []
  | x :: xs => (stepIn s x).2.sent ++ sentOf (stepIn s x).1 xs

inductive Reach : St → Prop
  | init : Reach init
  | step {s : St} (x : In) : Reach s → Reach (stepIn s x).1

/-! ## 不変条件: 鍵の前の状態（Start / WaitCH2）は鍵の世代 0 -/

def Inv (s : St) : Prop := (s.ph = .start ∨ s.ph = .waitCH2) → s.rd = 0 ∧ s.wr = 0

/-- (w, s) の辞書順 -/
def Lt (a b : Nat × Nat) : Prop := a.1 < b.1 ∨ (a.1 = b.1 ∧ a.2 < b.2)
def Le (a b : Nat × Nat) : Prop := a.1 < b.1 ∨ (a.1 = b.1 ∧ a.2 ≤ b.2)

theorem inv_step (s : St) (x : In) (h : Inv s) : Inv (stepIn s x).1 := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  unfold Inv at *
  cases x with
  | feed e =>
    cases ph <;> cases e <;> cases ccs <;>
      simp_all [stepIn, step, fail, ccsOnce, flight]
  | sendApp l =>
    cases ph <;> cases upd <;> cases l <;> simp_all [stepIn, sendApp]
  | sendAlert =>
    simp only [stepIn, sendAlert]; split <;> simp_all

theorem reach_inv {s : St} (h : Reach s) : Inv s := by
  induction h with
  | init => simp [Inv, init]
  | step x _ ih => exact inv_step _ x ih

/-! ## 定理 1: 平文を渡すのは Connected だけ・Connected に入るのは FinOk だけ -/

theorem app_only_connected (s : St) (x : In) (h : (stepIn s x).2.app = true) : s.ph = .connected := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  cases x with
  | feed e => cases ph <;> cases e <;> cases ccs <;> simp_all [stepIn, step, fail, ccsOnce, flight]
  | sendApp l => simp only [stepIn, sendApp] at h; split at h <;> (try split at h) <;> simp_all
  | sendAlert => simp only [stepIn, sendAlert] at h; split at h <;> simp_all

theorem enter_connected (s : St) (x : In) (h1 : (stepIn s x).1.ph = .connected) (h0 : s.ph ≠ .connected) :
    s.ph = .waitFin ∧ x = .feed .finOk := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  cases x with
  | feed e => cases ph <;> cases e <;> cases ccs <;> simp_all [stepIn, step, fail, ccsOnce, flight]
  | sendApp l => simp only [stepIn, sendApp] at h1; split at h1 <;> (try split at h1) <;> simp_all
  | sendAlert => simp only [stepIn, sendAlert] at h1; split at h1 <;> simp_all

/-! ## 定理 2: 受けの鍵がある状態では暗号化前の事象は誤り（WaitFin の CCS 1 枚だけ例外） -/

def isPlain : Ev → Bool
  | .ch | .chRetry | .chBad | .ccs | .plainOther => true
  | _ => false

theorem plain_after_keys {s : St} (hr : Reach s) (hk : 1 ≤ s.rd) (e : Ev) (hp : isPlain e = true)
    (hc : ¬ (s.ph = .waitFin ∧ e = .ccs ∧ s.ccs = false)) : (step s e).2.err.isSome := by
  have hi := reach_inv hr
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  unfold Inv at hi
  cases ph <;> cases e <;> cases ccs <;> simp_all [isPlain, step, fail, ccsOnce] <;> omega

/-! ## 定理 3: nonce（送りの (wr, seq)）は重ならない -/

theorem lt_of_lt_le {a b c : Nat × Nat} (h1 : Lt a b) (h2 : Le b c) : Lt a c := by
  unfold Lt Le at *; omega

theorem le_trans' {a b c : Nat × Nat} (h1 : Le a b) (h2 : Le b c) : Le a c := by
  unfold Le at *; omega

/-- 1 歩の送り: 列は増える・全部 (wr, seq) 以上で次の (wr', seq') 未満・(wr, seq) は減らない -/
theorem step_sent (s : St) (x : In) (h : Inv s) :
    (stepIn s x).2.sent.Pairwise Lt ∧
    (∀ p ∈ (stepIn s x).2.sent, Le (s.wr, s.seq) p ∧ Lt p ((stepIn s x).1.wr, (stepIn s x).1.seq)) ∧
    Le (s.wr, s.seq) ((stepIn s x).1.wr, (stepIn s x).1.seq) := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  unfold Inv at h
  cases x with
  | feed e =>
    cases ph <;> cases e <;> cases ccs <;> simp_all [stepIn, step, fail, ccsOnce, flight, Lt, Le]
  | sendApp l =>
    simp only [stepIn, sendApp]
    split
    · split <;> simp_all [Lt, Le] <;> omega
    · simp [Le]
  | sendAlert =>
    simp only [stepIn, sendAlert]
    split <;> simp_all [Lt, Le]

theorem sent_sorted (xs : List In) : ∀ s, Inv s →
    (sentOf s xs).Pairwise Lt ∧ ∀ p ∈ sentOf s xs, Le (s.wr, s.seq) p := by
  induction xs with
  | nil => intro s _; simp [sentOf]
  | cons x xs ih =>
    intro s h
    obtain ⟨h1, h2, h3⟩ := step_sent s x h
    obtain ⟨r1, r2⟩ := ih _ (inv_step s x h)
    refine ⟨?_, ?_⟩
    · simp only [sentOf]
      refine List.pairwise_append.mpr ⟨h1, r1, ?_⟩
      intro a ha b hb
      exact lt_of_lt_le (h2 a ha).2 (r2 b hb)
    · intro p hp
      simp only [sentOf, List.mem_append] at hp
      rcases hp with hp | hp
      · exact (h2 p hp).1
      · exact le_trans' h3 (r2 p hp)

theorem nonce_unique (xs : List In) : (sentOf init xs).Nodup := by
  have h := (sent_sorted xs init (by simp [Inv, init])).1
  exact h.imp (fun {a b} hab => by
    intro e; subst e; unfold Lt at hab; omega)

/-! ## 定理 4: 想定外は必ず Closed・Closed は吸収 -/

/-- 各状態で許された事象の表 -/
def allowed (s : St) (e : Ev) : Bool :=
  match s.ph, e with
  | .start, .ch => true
  | .start, .chRetry => true
  | .waitCH2, .ch => true
  | .start, .ccs => !s.ccs
  | .waitCH2, .ccs => !s.ccs
  | .waitFin, .ccs => !s.ccs
  | .waitFin, .finOk => true
  | .waitFin, .alertClose => true
  | .waitFin, .alertOther => true
  | .connected, .app => true
  | .connected, .keyUpd _ => true
  | .connected, .alertClose => true
  | .connected, .alertOther => true
  | _, _ => false

theorem err_closes (s : St) (e : Ev) (h : (step s e).2.err.isSome) :
    (step s e).1 = { s with ph := .closed } := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  cases ph <;> cases e <;> cases ccs <;> simp_all [step, fail, ccsOnce, flight]

theorem not_allowed_err (s : St) (e : Ev) (h : allowed s e = false) :
    (step s e).2.err.isSome ∧ (step s e).1.ph = .closed := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  cases ph <;> cases e <;> cases ccs <;> simp_all [allowed, step, fail, ccsOnce]

theorem allowed_ok (s : St) (e : Ev) (h : allowed s e = true) : (step s e).2.err = none := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  cases ph <;> cases e <;> cases ccs <;> simp_all [allowed, step, ccsOnce, flight]

theorem closed_absorbs (s : St) (e : Ev) (h : s.ph = .closed) :
    (step s e).1 = s ∧ (step s e).2.err = some aUnexpected := by
  rcases s with ⟨ph, ccs, hrr, rd, wr, seq, upd⟩
  subst h; simp [step, fail]

/-! ## 遷移表（sober-gen --tlsfsm — testdata/tls/fsm.golden・std/tls の TestFsm と照合） -/

def phName : Phase → String
  | .start => "start" | .waitCH2 => "waitCH2" | .waitFin => "waitFin" | .connected => "connected" | .closed => "closed"

def bit (b : Bool) : String := if b then "1" else "0"

def stName (s : St) : String :=
  if s.ph = .closed then "closed" else s!"{phName s.ph}/c{bit s.ccs}/h{bit s.hrr}"

def evName : Ev → String
  | .ch => "ch" | .chRetry => "chRetry" | .chBad => "chBad" | .ccs => "ccs" | .plainOther => "plainOther"
  | .forged => "forged" | .finOk => "finOk" | .finBad => "finBad" | .app => "app"
  | .keyUpd false => "keyUpd0" | .keyUpd true => "keyUpd1"
  | .alertClose => "alertClose" | .alertOther => "alertOther" | .sealedOther => "sealedOther"

def events : List Ev :=
  [.ch, .chRetry, .chBad, .ccs, .plainOther, .forged, .finOk, .finBad, .app, .keyUpd false, .keyUpd true,
   .alertClose, .alertOther, .sealedOther]

/-- 抽象の状態の代表（世代と seq は畳む — 表に現れない） -/
def states : List St :=
  let mk (ph : Phase) (c h : Bool) (rd wr : Nat) : St := { ph := ph, ccs := c, hrr := h, rd := rd, wr := wr, seq := 0, upd := false }
  [mk .start false false 0 0, mk .start true false 0 0,
   mk .waitCH2 false true 0 0, mk .waitCH2 true true 0 0,
   mk .waitFin false false 1 2, mk .waitFin true false 1 2, mk .waitFin false true 1 2, mk .waitFin true true 1 2,
   mk .connected false false 2 2, mk .connected true false 2 2,
   mk .closed false false 0 0]

def row (s : St) (e : Ev) : String :=
  let (s', o) := step s e
  let err := match o.err with | some a => toString a | none => "-"
  s!"{stName s} {evName e} -> {stName s'} app={bit o.app} done={bit o.done} closed={bit o.closed} upd={bit o.upd} err={err}"

def table : List String :=
  states.flatMap fun s => events.map fun e => row s e

end FS.Tls
