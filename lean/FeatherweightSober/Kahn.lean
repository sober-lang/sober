import FeatherweightSober.Leaf

/-!
# Kahn の定理（段 6 P1 — スケジュール非依存・デッドロックの有無まで決定的）

task の木（`State.fam`）の機械は合流的: **整形された木（`TaskOk` — main は葉・子 j の id = 親の id ++ [j]）の 2 つの 1 歩は、
同じ結果か、1 歩ずつで合流する**（`kahn_diamond`）。ここから正規形（完了・panic の葉・待機）の一意性と歩数の一致（`kahn`・
`kahn_unique`）、loadT の全プログラムのスケジュール非依存（`kahn_schedule`）と停止の決定性（`kahn_schedule_bounded`）が出る。
型付けは使わない — 機械だけの性質（旧 par / 旧 chan は task の中では panic なので前提なし）。

証明の骨格:
1. K への効果を操作 `Op`（give / newch / send / recv / pure）に分ける。違う task の独立な操作は可換（`op_comm`）— 持ち主の札が
   違うので片方は失敗するか、送りと受けが q の両端に触る（1 鍵の小操作 `Mini` に分解して全数で示す）
2. famMain = K の操作 `mainOp` → K に依らない続き `mainCont`（`famMain_spec` — 葉の歩は Leaf.lean で K 非依存）
3. 部分木の 1 歩は部分木の中の task の 1 つの操作で、同じ結果を返す K なら同じ歩が再生できる（`step_dec`）
4. 子の 1 歩は main の続きを子 j の置き換えにしか変えない（`mainCont_set` — join / try / scope の出口が読む子の決着は安定）
5. one-step diamond を木の帰納で（main/main は π 非依存・main/子と子/子は操作の独立性・同じ子は帰納）

**DRF の系**: kahn_diamond がそのまま「違う task の 1 歩は、チャネルに触れても、可換」— 段 3 の par_step_commute
（K を変えない歩だけ）の SPSC 版。
-/

namespace FS

/-! ## K の操作（task の 1 歩のチャネルストアへの効果） -/

/-- task の 1 歩の K への効果。famMain の腕と 1 対 1（葉の歩・join / try / scope の出口・横取りの panic は pure） -/
inductive Op : Type where
  | pure
  | give (me kid : List Nat) (d : Nat) (v : Expr)
  | newch (me : List Nat) (n cap : Nat) (ty : Ty)
  | send (me : List Nat) (k : EpKey) (v : Expr) (H : Heap)
  | recv (me : List Nat) (k : EpKey)
  | close (me : List Nat) (k : EpKey)

/-- 操作の実行: 外側 none = 待機（満杯の送信・空の受信・梱包の失敗）、結果 none = 失敗（panic）、some v = 成功の値 -/
def Op.run : Op → ChanSt → Option (Option Pkt × ChanSt)
  | .pure, K => some (some (Pkt.ofV .triv), K)
  | .give me kid d v, K =>
      match giveV me kid d v K with
      | Option.some (v', K') => some (some (Pkt.ofV v'), K')
      | Option.none => some (none, K)
  | .newch me n cap ty, K =>
      match K.ep (me, n) with
      | Option.some _ => some (none, K)
      | Option.none => some (some (Pkt.ofV .triv), K.setEp (me, n) ⟨[], cap, me, me, ty, false⟩)
  | .send me k v H, K =>
      match K.ep k with
      | Option.some e =>
          if e.otx = me then
            if e.closed then some (none, K)
            else if e.q.length < e.cap then
              match packV (.opt e.ty) H (Expr.some v) with
              | Option.some w => some (some (Pkt.ofV .triv), K.setEp k { e with q := e.q ++ [w] })
              | Option.none => none
            else none
          else some (none, K)
      | Option.none => some (none, K)
  | .recv me k, K =>
      match K.ep k with
      | Option.some e =>
          if e.orx = me then
            match e.q with
            | w :: q' => some (some w, K.setEp k { e with q := q' })
            | [] => if e.closed then some (some ⟨.nil e.ty, [], .opt e.ty⟩, K) else none
          else some (none, K)
      | Option.none => some (none, K)
  | .close me k, K =>
      match K.ep k with
      | Option.some e =>
          if e.otx = me ∧ e.closed = false then some (some (Pkt.ofV .triv), K.setEp k { e with closed := true })
          else some (none, K)
      | Option.none => some (none, K)

/-- 行為者（pure は誰でもない） -/
def Op.who : Op → Option (List Nat)
  | .pure => none
  | .give me _ _ _ => some me
  | .newch me _ _ _ => some me
  | .send me _ _ _ => some me
  | .recv me _ => some me
  | .close me _ => some me

/-- 新しい持ち主（give の子） -/
def Op.kid : Op → Option (List Nat)
  | .give _ kid _ _ => some kid
  | _ => none

/-- 独立: 行為者が違い、どちらの新しい持ち主も相手の行為者でない -/
def Op.Indep (a b : Op) : Prop :=
  (∀ x y, a.who = some x → b.who = some y → x ≠ y) ∧
  (∀ x y, a.who = some x → b.kid = some y → x ≠ y) ∧
  (∀ x y, a.kid = some x → b.who = some y → x ≠ y)

theorem Op.Indep.symm {a b : Op} (h : a.Indep b) : b.Indep a :=
  ⟨fun x y hx hy => (h.1 y x hy hx).symm, fun x y hx hy => (h.2.2 y x hy hx).symm,
    fun x y hx hy => (h.2.1 y x hy hx).symm⟩

/-! ## setEp の代数 -/

theorem ChanSt.ext' {K L : ChanSt} (h1 : K.leg = L.leg) (h2 : ∀ k, K.ep k = L.ep k) : K = L := by
  cases K; cases L; simp only at h1; subst h1; congr; funext k; exact h2 k

@[simp] theorem ChanSt.setEp_ep (K : ChanSt) (k k' : EpKey) (e : EpEnt) :
    (K.setEp k e).ep k' = if k' = k then some e else K.ep k' := rfl

@[simp] theorem ChanSt.setEp_leg (K : ChanSt) (k : EpKey) (e : EpEnt) : (K.setEp k e).leg = K.leg := rfl

theorem ChanSt.setEp_comm {K : ChanSt} {k1 k2 : EpKey} (e1 e2 : EpEnt) (h : k1 ≠ k2) :
    (K.setEp k1 e1).setEp k2 e2 = (K.setEp k2 e2).setEp k1 e1 := by
  refine ChanSt.ext' rfl ?_
  intro k
  simp only [ChanSt.setEp_ep]
  by_cases hk2 : k = k2
  · subst hk2; simp [Ne.symm h]
  · by_cases hk1 : k = k1 <;> simp [hk1, hk2, h]

theorem ChanSt.setEp_setEp {K : ChanSt} {k : EpKey} (e1 e2 : EpEnt) :
    (K.setEp k e1).setEp k e2 = K.setEp k e2 := by
  refine ChanSt.ext' rfl ?_
  intro k'
  simp only [ChanSt.setEp_ep]
  by_cases hk : k' = k <;> simp [hk]

/-! ## 1 鍵の小操作（give は送り端 / 受け端ごとの持ち主の書き換えの列に分解する） -/

inductive Mini : Type where
  | gtx (me kid : List Nat) (k : EpKey)
  | grx (me kid : List Nat) (k : EpKey)
  | newch (me : List Nat) (n cap : Nat) (ty : Ty)
  | send (me : List Nat) (k : EpKey) (v : Expr) (H : Heap)
  | recv (me : List Nat) (k : EpKey)
  | close (me : List Nat) (k : EpKey)

def Mini.key : Mini → EpKey
  | .gtx _ _ k => k
  | .grx _ _ k => k
  | .newch me n _ _ => (me, n)
  | .send _ k _ _ => k
  | .recv _ k => k
  | .close _ k => k

def Mini.who : Mini → List Nat
  | .gtx me _ _ => me
  | .grx me _ _ => me
  | .newch me _ _ _ => me
  | .send me _ _ _ => me
  | .recv me _ => me
  | .close me _ => me

/-- 1 鍵の項目への効果: 外側 none = 待機・(結果, 新しい項目〔none = そのまま〕) -/
def Mini.f : Mini → Option EpEnt → Option (Option Pkt × Option EpEnt)
  | .gtx me kid _, some e => if e.otx = me then some (some (Pkt.ofV .triv), some { e with otx := kid }) else some (none, none)
  | .grx me kid _, some e => if e.orx = me then some (some (Pkt.ofV .triv), some { e with orx := kid }) else some (none, none)
  | .newch me _ cap ty, none => some (some (Pkt.ofV .triv), some ⟨[], cap, me, me, ty, false⟩)
  | .newch _ _ _ _, some _ => some (none, none)
  | .send me _ v H, some e =>
      if e.otx = me then
        (if e.closed then some (none, none)
        else if e.q.length < e.cap then
          (match packV (.opt e.ty) H (Expr.some v) with
           | Option.some w => some (some (Pkt.ofV .triv), some { e with q := e.q ++ [w] })
           | Option.none => none)
        else none)
      else some (none, none)
  | .recv me _, some e =>
      if e.orx = me then
        match e.q with
        | w :: q' => some (some w, some { e with q := q' })
        | [] => if e.closed then some (some ⟨.nil e.ty, [], .opt e.ty⟩, none) else none
      else some (none, none)
  | .close me _, some e =>
      if e.otx = me ∧ e.closed = false then some (some (Pkt.ofV .triv), some { e with closed := true }) else some (none, none)
  | .gtx _ _ _, none => some (none, none)
  | .grx _ _ _, none => some (none, none)
  | .send _ _ _ _, none => some (none, none)
  | .recv _ _, none => some (none, none)
  | .close _ _, none => some (none, none)

def ChanSt.upd (K : ChanSt) (k : EpKey) : Option EpEnt → ChanSt
  | some e => K.setEp k e
  | none => K

def Mini.run (m : Mini) (K : ChanSt) : Option (Option Pkt × ChanSt) :=
  (m.f (K.ep m.key)).map (fun p => (p.1, K.upd m.key p.2))

theorem upd_ep_ne {K : ChanSt} {k k' : EpKey} {o : Option EpEnt} (h : k' ≠ k) : (K.upd k o).ep k' = K.ep k' := by
  cases o <;> simp [ChanSt.upd, h]

theorem upd_ep_self {K : ChanSt} {k : EpKey} {e : EpEnt} : (K.upd k (some e)).ep k = some e := by
  simp [ChanSt.upd]

theorem upd_comm {K : ChanSt} {k1 k2 : EpKey} (o1 o2 : Option EpEnt) (h : k1 ≠ k2) :
    (K.upd k1 o1).upd k2 o2 = (K.upd k2 o2).upd k1 o1 := by
  cases o1 <;> cases o2 <;> simp [ChanSt.upd, ChanSt.setEp_comm _ _ h]

/-- 鍵の違う 2 つの小操作は可換 -/
theorem mini_comm_ne {m1 m2 : Mini} {K K1 K2 : ChanSt} {r1 r2 : Option Pkt} (hk : m1.key ≠ m2.key)
    (h1 : m1.run K = some (r1, K1)) (h2 : m2.run K = some (r2, K2)) :
    ∃ K', m1.run K2 = some (r1, K') ∧ m2.run K1 = some (r2, K') := by
  unfold Mini.run at h1 h2 ⊢
  obtain ⟨⟨a1, o1⟩, hf1, he1⟩ := Option.map_eq_some_iff.mp h1
  obtain ⟨⟨a2, o2⟩, hf2, he2⟩ := Option.map_eq_some_iff.mp h2
  simp only [Prod.mk.injEq] at he1 he2
  obtain ⟨rfl, rfl⟩ := he1
  obtain ⟨rfl, rfl⟩ := he2
  refine ⟨(K.upd m1.key o1).upd m2.key o2, ?_, ?_⟩
  · rw [upd_ep_ne hk, hf1]; simp [upd_comm o1 o2 hk]
  · rw [upd_ep_ne (Ne.symm hk), hf2]; simp

def Mini.kid : Mini → Option (List Nat)
  | .gtx _ kid _ => some kid
  | .grx _ kid _ => some kid
  | _ => none

/-- 鍵の同じ 2 つの小操作（行為者が違う）の項目の上の可換性: 持ち主の札が違うので片方は失敗するか、送りと受けが q の両端に触る -/
theorem mini_f_comm {m1 m2 : Mini} {o : Option EpEnt} {a1 a2 : Option Pkt} {o1 o2 : Option EpEnt}
    (hw : m1.who ≠ m2.who) (hk : m1.key = m2.key) (hg1 : m1.kid ≠ some m2.who) (hg2 : m2.kid ≠ some m1.who)
    (h1 : m1.f o = some (a1, o1)) (h2 : m2.f o = some (a2, o2)) :
    ∃ o1' o2', m1.f (o2.or o) = some (a1, o1') ∧ m2.f (o1.or o) = some (a2, o2') ∧
      (o1'.or o2).or o = (o2'.or o1).or o := by
  cases m1 <;> cases m2 <;> cases o <;> simp only [Mini.f, Mini.who, Mini.kid, Mini.key] at hw hk hg1 hg2 h1 h2 ⊢
  all_goals first
    | (simp at h1)
    | (simp at h2)
    | skip
  all_goals (repeat' split at h1) <;> (repeat' split at h2) <;>
    simp only [Option.some.injEq, Prod.mk.injEq, reduceCtorEq] at h1 h2
  all_goals (obtain ⟨rfl, rfl⟩ := h1; obtain ⟨rfl, rfl⟩ := h2)
  all_goals first
    | (simp_all; done)
    | ((simp only [Option.or]; repeat' split) <;> simp_all; done)
    | ((simp only [Option.or]; repeat' split) <;> simp_all <;> omega)

theorem upd_ep_or {K : ChanSt} {k : EpKey} {o : Option EpEnt} : (K.upd k o).ep k = o.or (K.ep k) := by
  cases o <;> simp [ChanSt.upd]

theorem upd_upd {K : ChanSt} {k : EpKey} (o o' : Option EpEnt) : (K.upd k o).upd k o' = K.upd k (o'.or o) := by
  cases o <;> cases o' <;> simp [ChanSt.upd, ChanSt.setEp_setEp]

theorem upd_congr {K : ChanSt} {k : EpKey} {x y : Option EpEnt} (h : x.or (K.ep k) = y.or (K.ep k)) :
    K.upd k x = K.upd k y := by
  refine ChanSt.ext' (by cases x <;> cases y <;> rfl) ?_
  intro k'
  by_cases hk : k' = k
  · subst hk; rw [upd_ep_or, upd_ep_or, h]
  · rw [upd_ep_ne hk, upd_ep_ne hk]

/-- 行為者の違う 2 つの小操作は可換（鍵が違えば無関係・同じなら mini_f_comm） -/
theorem mini_comm {m1 m2 : Mini} {K K1 K2 : ChanSt} {r1 r2 : Option Pkt}
    (hw : m1.who ≠ m2.who) (hg1 : m1.kid ≠ some m2.who) (hg2 : m2.kid ≠ some m1.who)
    (h1 : m1.run K = some (r1, K1)) (h2 : m2.run K = some (r2, K2)) :
    ∃ K', m1.run K2 = some (r1, K') ∧ m2.run K1 = some (r2, K') := by
  by_cases hk : m1.key = m2.key
  · unfold Mini.run at h1 h2 ⊢
    obtain ⟨⟨a1, o1⟩, hf1, he1⟩ := Option.map_eq_some_iff.mp h1
    obtain ⟨⟨a2, o2⟩, hf2, he2⟩ := Option.map_eq_some_iff.mp h2
    simp only [Prod.mk.injEq] at he1 he2
    obtain ⟨rfl, rfl⟩ := he1
    obtain ⟨rfl, rfl⟩ := he2
    rw [← hk] at hf2
    obtain ⟨o1', o2', hf1', hf2', heq⟩ := mini_f_comm hw hk hg1 hg2 hf1 hf2
    refine ⟨(K.upd m1.key o2).upd m1.key o1', ?_, ?_⟩
    · rw [← hk, upd_ep_or, hf1']; simp
    · rw [← hk, upd_ep_or, hf2']
      simp only [Option.map_some, upd_upd]
      congr 2
      exact (upd_congr heq).symm
  · exact mini_comm_ne hk h1 h2

/-- 引き渡しの 1 端点の形: giveV は送り端 / 受け端の持ち主の書き換え（gtx / grx）そのもの -/
theorem giveV_tx {me kid : List Nat} {d : Nat} {p : List Nat} {k r : Nat} {K : ChanSt} :
    giveV me kid d (.epV p k true r) K =
      match (Mini.gtx me kid (p, k)).run K with
      | Option.some (Option.some _, K') => some (.epV p k true d, K')
      | _ => none := by
  simp only [giveV, Mini.run, Mini.key]
  cases h : K.ep (p, k) with
  | none => simp [Mini.f]
  | some e => by_cases ho : e.otx = me <;> simp [Mini.f, ho, ChanSt.upd]

theorem giveV_rx {me kid : List Nat} {d : Nat} {p : List Nat} {k r : Nat} {K : ChanSt} :
    giveV me kid d (.epV p k false r) K =
      match (Mini.grx me kid (p, k)).run K with
      | Option.some (Option.some _, K') => some (.epV p k false d, K')
      | _ => none := by
  simp only [giveV, Mini.run, Mini.key]
  cases h : K.ep (p, k) with
  | none => simp [Mini.f]
  | some e => by_cases ho : e.orx = me <;> simp [Mini.f, ho, ChanSt.upd]

theorem Mini.run_gtx_some (me kid : List Nat) (k : EpKey) (K : ChanSt) :
    ∃ res K', (Mini.gtx me kid k).run K = some (res, K') := by
  simp only [Mini.run, Mini.key]
  cases h : K.ep k with
  | none => exact ⟨_, _, rfl⟩
  | some e => by_cases ho : e.otx = me <;> simp [Mini.f, ho]

theorem Mini.run_grx_some (me kid : List Nat) (k : EpKey) (K : ChanSt) :
    ∃ res K', (Mini.grx me kid k).run K = some (res, K') := by
  simp only [Mini.run, Mini.key]
  cases h : K.ep k with
  | none => exact ⟨_, _, rfl⟩
  | some e => by_cases ho : e.orx = me <;> simp [Mini.f, ho]

/-- 引き渡しと、他人の操作 run2 の可換性（run2 が me の gtx / grx と可換なら、giveV 全体とも可換 — 成功は同じ値・失敗は失敗のまま） -/
theorem giveV_comm {me kid : List Nat} {d : Nat} {run2 : ChanSt → Option (Option Pkt × ChanSt)}
    (hc : ∀ (m1 : Mini), (∃ k, m1 = .gtx me kid k ∨ m1 = .grx me kid k) →
      ∀ K K1 K2 res r, m1.run K = some (res, K1) → run2 K = some (r, K2) →
        ∃ K', m1.run K2 = some (res, K') ∧ run2 K1 = some (r, K')) (v : Expr) :
    ∀ {K K2 : ChanSt} {r : Option Pkt}, run2 K = some (r, K2) →
      (∀ v' K1, giveV me kid d v K = some (v', K1) → ∃ K', giveV me kid d v K2 = some (v', K') ∧ run2 K1 = some (r, K')) ∧
      (giveV me kid d v K = none → giveV me kid d v K2 = none) := by
  induction v
  case epV p k b rr =>
    intro K K2 r h2
    cases b with
    | true =>
      obtain ⟨res, K1', hg⟩ := Mini.run_gtx_some me kid (p, k) K
      obtain ⟨K', hc1, hc2⟩ := hc _ ⟨(p, k), .inl rfl⟩ _ _ _ _ _ hg h2
      rw [giveV_tx, giveV_tx, hg, hc1]
      cases res with
      | none => exact ⟨fun _ _ h => by simp at h, fun _ => rfl⟩
      | some _ =>
        refine ⟨fun v' K1 h => ?_, fun h => by simp at h⟩
        simp only [Option.some.injEq, Prod.mk.injEq] at h
        obtain ⟨rfl, rfl⟩ := h
        exact ⟨K', rfl, hc2⟩
    | false =>
      obtain ⟨res, K1', hg⟩ := Mini.run_grx_some me kid (p, k) K
      obtain ⟨K', hc1, hc2⟩ := hc _ ⟨(p, k), .inr rfl⟩ _ _ _ _ _ hg h2
      rw [giveV_rx, giveV_rx, hg, hc1]
      cases res with
      | none => exact ⟨fun _ _ h => by simp at h, fun _ => rfl⟩
      | some _ =>
        refine ⟨fun v' K1 h => ?_, fun h => by simp at h⟩
        simp only [Option.some.injEq, Prod.mk.injEq] at h
        obtain ⟨rfl, rfl⟩ := h
        exact ⟨K', rfl, hc2⟩
  case pair a b iha ihb =>
    intro K K2 r h2
    obtain ⟨ia1, ia2⟩ := iha h2
    refine ⟨fun v' K1 h => ?_, fun h => ?_⟩
    · simp only [giveV] at h
      split at h
      · rename_i a' Ka hga
        split at h
        · rename_i b' Kb hgb
          simp only [Option.some.injEq, Prod.mk.injEq] at h
          obtain ⟨rfl, rfl⟩ := h
          obtain ⟨Ka2, hga2, hma⟩ := ia1 a' Ka hga
          obtain ⟨K', hgb2, hmb⟩ := (ihb hma).1 b' Kb hgb
          exact ⟨K', by simp [giveV, hga2, hgb2], hmb⟩
        · cases h
      · cases h
    · simp only [giveV] at h
      split at h
      · rename_i a' Ka hga
        split at h
        · cases h
        · rename_i hgb
          obtain ⟨Ka2, hga2, hma⟩ := ia1 a' Ka hga
          have := (ihb hma).2 (by simpa using hgb)
          simp [giveV, hga2, this]
      · rename_i hga
        have := ia2 (by simpa using hga)
        simp [giveV, this]
  all_goals
    intro K K2 r h2
    refine ⟨fun v' K1 h => ?_, fun h => by simp [giveV] at h⟩
    simp only [giveV, Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, rfl⟩ := h
    exact ⟨K2, by simp [giveV], h2⟩

/-- give の Op の可換性の下ごしらえ: run2 が giveV と可換（giveV_comm の形）なら give の Op.run とも可換 -/
theorem op_give_comm {me kid : List Nat} {d : Nat} {v : Expr} {run2 : ChanSt → Option (Option Pkt × ChanSt)}
    (hc : ∀ {K K2 : ChanSt} {r : Option Pkt}, run2 K = some (r, K2) →
      (∀ v' K1, giveV me kid d v K = some (v', K1) → ∃ K', giveV me kid d v K2 = some (v', K') ∧ run2 K1 = some (r, K')) ∧
      (giveV me kid d v K = none → giveV me kid d v K2 = none))
    {K Ka Kb : ChanSt} {ra rb : Option Pkt}
    (ha : (Op.give me kid d v).run K = some (ra, Ka)) (hb : run2 K = some (rb, Kb)) :
    ∃ K', (Op.give me kid d v).run Kb = some (ra, K') ∧ run2 Ka = some (rb, K') := by
  simp only [Op.run] at ha ⊢
  obtain ⟨h1, h2⟩ := hc hb
  split at ha
  · rename_i v' K1 hg
    simp only [Option.some.injEq, Prod.mk.injEq] at ha
    obtain ⟨rfl, rfl⟩ := ha
    obtain ⟨K', hg2, hr⟩ := h1 v' K1 hg
    exact ⟨K', by simp [hg2], hr⟩
  · rename_i hg
    simp only [Option.some.injEq, Prod.mk.injEq] at ha
    obtain ⟨rfl, rfl⟩ := ha
    exact ⟨Kb, by simp [h2 hg], hb⟩

/-- Op（give 以外）は 1 つの小操作 -/
def Op.mini : Op → Option Mini
  | .newch me n cap ty => some (.newch me n cap ty)
  | .send me k v H => some (.send me k v H)
  | .recv me k => some (.recv me k)
  | .close me k => some (.close me k)
  | _ => none

theorem Op.run_mini {a : Op} {m : Mini} (h : a.mini = some m) (K : ChanSt) : a.run K = m.run K := by
  cases a <;> simp only [Op.mini, Option.some.injEq, reduceCtorEq] at h <;> subst h <;>
    simp only [Op.run, Mini.run, Mini.key] <;> cases hk : K.ep _ <;> simp [Mini.f, ChanSt.upd] <;>
    (repeat' split) <;> simp_all

theorem Op.mini_who {a : Op} {m : Mini} (h : a.mini = some m) : a.who = some m.who := by
  cases a <;> simp only [Op.mini, Option.some.injEq, reduceCtorEq] at h <;> subst h <;> rfl

theorem Op.mini_kid {a : Op} {m : Mini} (h : a.mini = some m) : m.kid = none := by
  cases a <;> simp only [Op.mini, Option.some.injEq, reduceCtorEq] at h <;> subst h <;> rfl

/-- 可換性の対称形 -/
theorem comm_symm {f g : ChanSt → Option (Option Pkt × ChanSt)}
    (h : ∀ {K Ka Kb ra rb}, f K = some (ra, Ka) → g K = some (rb, Kb) →
      ∃ K', f Kb = some (ra, K') ∧ g Ka = some (rb, K')) :
    ∀ {K Ka Kb ra rb}, g K = some (rb, Kb) → f K = some (ra, Ka) →
      ∃ K', g Ka = some (rb, K') ∧ f Kb = some (ra, K') := by
  intro K Ka Kb ra rb hg hf
  obtain ⟨K', h1, h2⟩ := h hf hg
  exact ⟨K', h2, h1⟩

/-- give と小操作 m の可換性 -/
theorem give_mini_comm {me kid : List Nat} {d : Nat} {v : Expr} {m : Mini}
    (hw : me ≠ m.who) (hg1 : kid ≠ m.who) (hg2 : m.kid ≠ some me) :
    ∀ {K Ka Kb ra rb}, (Op.give me kid d v).run K = some (ra, Ka) → m.run K = some (rb, Kb) →
      ∃ K', (Op.give me kid d v).run Kb = some (ra, K') ∧ m.run Ka = some (rb, K') := by
  intro K Ka Kb ra rb ha hb
  refine op_give_comm (run2 := m.run) (fun h => giveV_comm (run2 := m.run) ?_ v h) ha hb
  intro m1 ⟨k, hm1⟩ K K1 K2 res r h1 h2
  rcases hm1 with rfl | rfl
  · exact mini_comm (by simpa [Mini.who] using hw) (by simpa [Mini.kid] using hg1) (by simpa [Mini.who] using hg2) h1 h2
  · exact mini_comm (by simpa [Mini.who] using hw) (by simpa [Mini.kid] using hg1) (by simpa [Mini.who] using hg2) h1 h2

/-- give 同士の可換性 -/
theorem give_give_comm {me1 kid1 me2 kid2 : List Nat} {d1 d2 : Nat} {v1 v2 : Expr}
    (h12 : me1 ≠ me2) (hk1 : kid1 ≠ me2) (hk2 : kid2 ≠ me1) :
    ∀ {K Ka Kb ra rb}, (Op.give me1 kid1 d1 v1).run K = some (ra, Ka) → (Op.give me2 kid2 d2 v2).run K = some (rb, Kb) →
      ∃ K', (Op.give me1 kid1 d1 v1).run Kb = some (ra, K') ∧ (Op.give me2 kid2 d2 v2).run Ka = some (rb, K') := by
  intro K Ka Kb ra rb ha hb
  refine op_give_comm (run2 := (Op.give me2 kid2 d2 v2).run) (fun h => giveV_comm ?_ v1 h) ha hb
  intro m1 ⟨k, hm1⟩ K K1 K2 res r h1 h2
  have hmw : m1.who = me1 := by rcases hm1 with rfl | rfl <;> rfl
  have hmk : m1.kid = some kid1 := by rcases hm1 with rfl | rfl <;> rfl
  exact comm_symm (give_mini_comm (m := m1) (by rw [hmw]; exact Ne.symm h12) (by rw [hmw]; exact hk2)
    (by rw [hmk]; simpa using hk1)) h1 h2

theorem Op.cases3 (a : Op) :
    a = .pure ∨ (∃ me kid d v, a = .give me kid d v) ∨ ∃ m, a.mini = some m := by
  cases a with
  | pure => exact .inl rfl
  | give me kid d v => exact .inr (.inl ⟨me, kid, d, v, rfl⟩)
  | newch => exact .inr (.inr ⟨_, rfl⟩)
  | send => exact .inr (.inr ⟨_, rfl⟩)
  | recv => exact .inr (.inr ⟨_, rfl⟩)
  | close => exact .inr (.inr ⟨_, rfl⟩)

/-- 操作の可換性（独立な 2 つの操作は、結果を変えずに順序を入れ替えられ、同じ K に着く） -/
theorem op_comm {a b : Op} (hi : a.Indep b) :
    ∀ {K Ka Kb ra rb}, a.run K = some (ra, Ka) → b.run K = some (rb, Kb) →
      ∃ K', a.run Kb = some (ra, K') ∧ b.run Ka = some (rb, K') := by
  intro K Ka Kb ra rb ha hb
  obtain ⟨hw, hk1, hk2⟩ := hi
  rcases Op.cases3 a with rfl | ⟨me1, kid1, d1, v1, rfl⟩ | ⟨m1, hm1⟩
  · simp only [Op.run, Option.some.injEq, Prod.mk.injEq] at ha
    obtain ⟨rfl, rfl⟩ := ha
    exact ⟨Kb, rfl, hb⟩
  all_goals rcases Op.cases3 b with rfl | ⟨me2, kid2, d2, v2, rfl⟩ | ⟨m2, hm2⟩
  · simp only [Op.run, Option.some.injEq, Prod.mk.injEq] at hb
    obtain ⟨rfl, rfl⟩ := hb
    exact ⟨Ka, ha, rfl⟩
  · exact give_give_comm (hw _ _ rfl rfl) (hk2 _ _ rfl rfl) (Ne.symm (hk1 _ _ rfl rfl)) ha hb
  · rw [Op.run_mini hm2] at hb ⊢
    have hw2 := Op.mini_who hm2
    exact give_mini_comm (hw _ _ rfl hw2) (hk2 _ _ rfl hw2) (by rw [Op.mini_kid hm2]; simp) ha hb
  · simp only [Op.run, Option.some.injEq, Prod.mk.injEq] at hb
    obtain ⟨rfl, rfl⟩ := hb
    exact ⟨Ka, ha, rfl⟩
  · rw [Op.run_mini hm1] at ha ⊢
    have hw1 := Op.mini_who hm1
    exact comm_symm (give_mini_comm (Ne.symm (hw _ _ hw1 rfl)) (Ne.symm (hk1 _ _ hw1 rfl))
      (by rw [Op.mini_kid hm1]; simp)) ha hb
  · rw [Op.run_mini hm1] at ha ⊢
    rw [Op.run_mini hm2] at hb ⊢
    have hw1 := Op.mini_who hm1
    have hw2 := Op.mini_who hm2
    exact mini_comm (hw _ _ hw1 hw2) (by rw [Op.mini_kid hm1]; simp) (by rw [Op.mini_kid hm2]; simp) ha hb

open Expr

/-! ## famMain の分解: K への操作（mainOp）と、K に依らない続き（mainCont） -/

/-- main の 1 歩の K への操作（famMain の K を触る 4 つの腕・それ以外は pure） -/
def mainOp (id : List Nat) (n : Nat) (ks : Kids) : State → Op
  | .ret H (.spawnA (scopeV _ _) _ :: _) va => .give id (id ++ [ks.length]) H.length va
  | .eval _ _ (newch _ cap t) => .newch id n cap (t.relocR 0)
  | .ret H (.sendR (epV p k true _) :: _) v => .send id (p, k) v H
  | .ret _ (.recvK :: _) (epV p k false _) => .recv id (p, k)
  | .ret _ (.closeK :: _) (epV p k true _) => .close id (p, k)
  | _ => .pure

/-- main の 1 歩の続き（操作の結果 res から、次の task の状態。葉の歩は空の K で走らせた葉の歩の結果） -/
def mainCont (Δ : Defs) (π : List Bool) (id : List Nat) (o n : Nat) (m : State) (ks : Kids) (res : Option Pkt) :
    Option State :=
  match m with
  | .ret H (.spawnA (scopeV rs ε) e :: S) _ =>
      match res with
      | Option.some va' =>
          some (.fam id o n (.ret H S (taskV rs (o + ks.length)))
            (ks.snoc rs (ε.relocR 0) (.fam (id ++ [ks.length]) (o + ks.length) 0 (.eval (H ++ [[]]) [.taskK] (subst 0 va'.v e)) .nil)))
      | Option.none => some (.fam id o n (.panic H) ks)
  | .eval H S (newch r _ _) =>
      match res with
      | Option.some _ => some (.fam id o (n + 1) (.ret H S (pair (epV id n true r) (epV id n false r))) ks)
      | Option.none => some (.fam id o (n + 1) (.panic H) ks)
  | .ret H (.sendR (epV _ _ true _) :: S) _ =>
      match res with
      | Option.some _ => some (.fam id o n (.ret H S triv) ks)
      | Option.none => some (.fam id o n (.panic H) ks)
  | .ret H (.recvK :: S) (epV _ _ false _) =>
      match res with
      | Option.some w =>
          match xfer (H.length - 1) (w.ty.relocR (H.length - 1)) [w.cs] H w.v with
          | Option.some (H', v') => some (.fam id o n (.ret H' S v') ks)
          | Option.none => none
      | Option.none => some (.fam id o n (.panic H) ks)
  | .ret H (.closeK :: S) (epV _ _ true _) =>
      match res with
      | Option.some _ => some (.fam id o n (.ret H S triv) ks)
      | Option.none => some (.fam id o n (.panic H) ks)
  | .ret H (.joinK t :: S) (taskV _ i) =>
      match ks.get? (i - o), decide (o ≤ i) with
      | Option.some (rs, kid), true =>
          match taskRes kid with
          | Option.some (Hk, v) =>
              match xfer rs t Hk H v with
              | Option.some (H', v') => some (.fam id o n (.ret H' S v') (ks.mark (i - o)))
              | Option.none => none
          | Option.none => if kid.mainDead then some (.fam id o n (.panic H) ks) else none
      | _, _ => some (.fam id o n (.panic H) ks)
  | .ret H (.tryK t :: S) (taskV _ i) =>
      match ks.get? (i - o), decide (o ≤ i) with
      | Option.some (rs, kid), true =>
          match taskRes kid with
          | Option.some (Hk, v) =>
              match xfer rs t Hk H v with
              | Option.some (H', v') => some (.fam id o n (.ret H' S (Expr.some v')) (ks.mark (i - o)))
              | Option.none => none
          | Option.none => if kid.mainDead then some (.fam id o n (.ret H S (nil t)) ks) else none
      | _, _ => some (.fam id o n (.panic H) ks)
  | .ret H (.scopeK t ε :: S) v =>
      if ks.settledAt (H.length - 1) then
        if ks.deadAt (H.length - 1) then
          some (.fam id o n (.ret H.dropLast S (inr t (inl (ε.relocR (H.length - 2)) triv))) ks)
        else
          match ks.failAt (H.length - 1) with
          | Option.some (εk, Hk, e) =>
              if εk = ε.relocR 0 then
                match xfer (H.length - 2) (ε.relocR (H.length - 2)) Hk H e with
                | Option.some (H', e') => some (.fam id o n (.ret H'.dropLast S (inr t (inr .unit e'))) ks)
                | Option.none => none
              else some (.fam id o n (.panic H) ks)
          | Option.none =>
              match relocTo (H.length - 2) t H v with
              | Option.some (H', v') => some (.fam id o n (.ret H'.dropLast S (inl (.union .unit (ε.relocR (H.length - 2))) v')) ks)
              | Option.none => none
      else none
  | .eval H _ (par _ _) => some (.fam id o n (.panic H) ks)
  | .eval H _ (parch _ _ _) => some (.fam id o n (.panic H) ks)
  | .eval H _ (newchan _ _) => some (.fam id o n (.panic H) ks)
  | .ret H (.sendR (chanV _) :: _) _ => some (.fam id o n (.panic H) ks)
  | .ret H (.recvK :: _) (chanV _) => some (.fam id o n (.panic H) ks)
  | _ => (step Δ π m ∅).map (fun p => .fam id o n p.1.fixLeaf ks)

/-- famMain の分解の仕様: 葉の main の 1 歩は「K の操作 → 続き」 -/
theorem famMain_spec (Δ : Defs) (π : List Bool) (id : List Nat) (o n : Nat) (m : State) (ks : Kids) (K : ChanSt)
    (hl : m.fixLeaf = m) :
    famMain id o n m ks K (step Δ π m K) =
      ((mainOp id n ks m).run K).bind (fun p => (mainCont Δ π id o n m ks p.1).map (·, p.2)) := by
  by_cases hr : m.legRedex = true
  · unfold State.legRedex at hr
    split at hr <;> first | (simp at hr; done) | (simp only [famMain, mainOp, mainCont, Op.run, Option.bind_some, Option.map_some]; done) | rfl
  · simp only [Bool.not_eq_true] at hr
    unfold famMain
    split
    all_goals first
      | (simp [State.legRedex] at hr; done)
      | (simp only [mainOp, mainCont, Op.run]; (repeat' split) <;> simp_all [Pkt.ofV]; done)
      | skip
    case h_3 =>
      simp only [mainOp, mainCont, Op.run]
      cases K.ep _ with
      | none => rfl
      | some e =>
        by_cases h1 : e.otx = id <;> by_cases h0 : e.closed = true <;> by_cases h2 : e.q.length < e.cap <;> simp [h1, h0, h2]
        cases hp : packV (.opt e.ty) _ _ <;> simp
    case h_4 =>
      simp only [mainOp, mainCont, Op.run]
      cases K.ep _ with
      | none => rfl
      | some e =>
        by_cases h1 : e.orx = id <;> simp only [h1, if_true, if_false, Option.bind_some, Option.map_some]
        · cases e.q with
          | cons w q' => simp only [Option.bind_some, Option.map_some]; cases xfer _ _ _ _ _ <;> rfl
          | nil => by_cases h0 : e.closed = true <;> simp [h0, xfer, Ty.relocR]
    -- 葉の歩（famMain の最後の腕）
    rename_i h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13
    have hop : mainOp id n ks m = .pure := by
      unfold mainOp; split <;> first | rfl | (exfalso; first | (apply h1 <;> rfl) | (apply h2 <;> rfl) | (apply h3 <;> rfl) | (apply h4 <;> rfl) | (apply h5 <;> rfl) | (apply h6 <;> rfl) | (apply h7 <;> rfl) | (apply h8 <;> rfl) | (apply h9 <;> rfl) | (apply h10 <;> rfl) | (apply h11 <;> rfl) | (apply h12 <;> rfl) | (apply h13 <;> rfl))
    have hco : mainCont Δ π id o n m ks (Option.some (Pkt.ofV Expr.triv)) = (step Δ π m ∅).map (fun p => .fam id o n p.1.fixLeaf ks) := by
      unfold mainCont; split <;> first | rfl | (exfalso; first | (apply h1 <;> rfl) | (apply h2 <;> rfl) | (apply h3 <;> rfl) | (apply h4 <;> rfl) | (apply h5 <;> rfl) | (apply h6 <;> rfl) | (apply h7 <;> rfl) | (apply h8 <;> rfl) | (apply h9 <;> rfl) | (apply h10 <;> rfl) | (apply h11 <;> rfl) | (apply h12 <;> rfl) | (apply h13 <;> rfl))
    rw [hop]
    simp only [Op.run, Option.bind_some]
    rw [hco, stepLeaf_all Δ π π m K ∅ hl hr, Option.map_map, Option.map_map]
    cases h : step Δ π m K with
    | none => rfl
    | some p =>
      obtain ⟨p1, p2⟩ := p
      obtain ⟨hK, hfx, -⟩ := stepLeaf_some hl hr h
      subst hK
      simp [hfx]

/-! ## task の木の整形（id = 位置）と、部分木の 1 歩の分解 -/

mutual
/-- task の木の整形: 根の id・main は葉・子 j の id = 親の id ++ [j] -/
inductive TaskOk : List Nat → State → Prop where
  | mk {id : List Nat} {o n : Nat} {m : State} {ks : Kids} :
      m.fixLeaf = m → KidsOk id 0 ks → TaskOk id (.fam id o n m ks)
inductive KidsOk : List Nat → Nat → Kids → Prop where
  | nil {id : List Nat} {j : Nat} : KidsOk id j .nil
  | cons {id : List Nat} {j rs : Nat} {κ : Ty × Bool} {s : State} {r : Kids} :
      TaskOk (id ++ [j]) s → KidsOk id (j + 1) r → KidsOk id j (.cons rs κ s r)
end

/-- 操作が部分木 P の中の task のもの（行為者も新しい持ち主も P の子孫） -/
def OpIn (P : List Nat) (b : Op) : Prop :=
  (∀ y, b.who = Option.some y → P <+: y) ∧ (∀ y, b.kid = Option.some y → P <+: y)

theorem OpIn.mono {P Q : List Nat} {b : Op} (h : OpIn Q b) (hpq : P <+: Q) : OpIn P b :=
  ⟨fun y hy => hpq.trans (h.1 y hy), fun y hy => hpq.trans (h.2 y hy)⟩

theorem mainOp_in (id : List Nat) (n : Nat) (ks : Kids) (m : State) : OpIn id (mainOp id n ks m) := by
  unfold mainOp
  split <;> refine ⟨fun y hy => ?_, fun y hy => ?_⟩ <;> simp [Op.who, Op.kid] at hy <;> subst hy <;> simp

mutual
/-- 部分木の 1 歩の分解と再生: K への効果は部分木の中の task の 1 つの操作で、同じ結果を返す K なら同じ歩が再生できる -/
theorem step_dec {Δ : Defs} : ∀ {P : List Nat} {s : State} {π : List Bool} {K : ChanSt} {s' : State} {K' : ChanSt},
    TaskOk P s → step Δ π s K = some (s', K') →
    ∃ b r, OpIn P b ∧ b.run K = some (r, K') ∧ ∀ K2 K2', b.run K2 = some (r, K2') → step Δ π s K2 = some (s', K2')
  | _, _, π, K, s', K', .mk (id := id) (o := o) (n := n) (m := m) (ks := ks) hl hk, h => by
    rw [step_fam_def] at h
    cases π with
    | cons c π' =>
      cases c with
      | false =>
        obtain ⟨⟨ks', K₁⟩, hsk, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        obtain ⟨b, r, hin, hb, hrep⟩ := stepKids_dec hk hsk
        refine ⟨b, r, hin, hb, fun K2 K2' h2 => ?_⟩
        rw [step_fam_def]
        simp [hrep K2 K2' h2]
      | true =>
        change famMain id o n m ks K (step Δ π' m K) = _ at h
        rw [famMain_spec Δ π' id o n m ks K hl] at h
        obtain ⟨⟨r, K₁⟩, hrun, hc⟩ := Option.bind_eq_some_iff.mp h
        obtain ⟨s₁, hs₁, heq⟩ := Option.map_eq_some_iff.mp hc
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        refine ⟨_, r, mainOp_in id n ks m, hrun, fun K2 K2' h2 => ?_⟩
        rw [step_fam_def]
        show famMain id o n m ks K2 (step Δ π' m K2) = _
        rw [famMain_spec Δ π' id o n m ks K2 hl, h2]
        simp [hs₁]
    | nil =>
      change famMain id o n m ks K (step Δ [] m K) = _ at h
      rw [famMain_spec Δ [] id o n m ks K hl] at h
      obtain ⟨⟨r, K₁⟩, hrun, hc⟩ := Option.bind_eq_some_iff.mp h
      obtain ⟨s₁, hs₁, heq⟩ := Option.map_eq_some_iff.mp hc
      simp only [Prod.mk.injEq] at heq
      obtain ⟨rfl, rfl⟩ := heq
      refine ⟨_, r, mainOp_in id n ks m, hrun, fun K2 K2' h2 => ?_⟩
      rw [step_fam_def]
      show famMain id o n m ks K2 (step Δ [] m K2) = _
      rw [famMain_spec Δ [] id o n m ks K2 hl, h2]
      simp [hs₁]

theorem stepKids_dec {Δ : Defs} : ∀ {P : List Nat} {j : Nat} {ks : Kids} {π : List Bool} {K : ChanSt} {ks' : Kids} {K' : ChanSt},
    KidsOk P j ks → stepKids Δ π ks K = some (ks', K') →
    ∃ b r, OpIn P b ∧ b.run K = some (r, K') ∧ ∀ K2 K2', b.run K2 = some (r, K2') → stepKids Δ π ks K2 = some (ks', K2')
  | _, _, _, π, K, ks', K', .nil, h => by simp [stepKids] at h
  | P, j, _, π, K, ks', K', .cons (rs := rs) (s := s) (r := rest) ht hr, h => by
    cases π with
    | nil => simp [stepKids] at h
    | cons c π' =>
      cases c with
      | true =>
        simp only [stepKids] at h
        obtain ⟨⟨s₁, K₁⟩, hst, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        obtain ⟨b, r, hin, hb, hrep⟩ := step_dec ht hst
        refine ⟨b, r, hin.mono (List.prefix_append P [j]), hb, fun K2 K2' h2 => ?_⟩
        simp [stepKids, hrep K2 K2' h2]
      | false =>
        simp only [stepKids] at h
        obtain ⟨⟨ks₁, K₁⟩, hsk, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        obtain ⟨b, r, hin, hb, hrep⟩ := stepKids_dec hr hsk
        refine ⟨b, r, hin, hb, fun K2 K2' h2 => ?_⟩
        simp [stepKids, hrep K2 K2' h2]
end


/-! ## 子の 1 歩の下での main の続きの安定性 -/

/-- task の子 j を置き換える -/
def State.setKid : State → Nat → State → State
  | .fam id o n m ks, j, x => .fam id o n m (ks.set j x)
  | s, _, _ => s

theorem Kids.set_snoc : ∀ {ks : Kids} {j : Nat} (rs : Nat) (ε : Ty) (x y : State), j < ks.length →
    (ks.snoc rs ε x).set j y = (ks.set j y).snoc rs ε x
  | .nil, _, _, _, _, _, h => by simp [Kids.length] at h
  | .cons _ κ _ _, 0, _, _, _, _, _ => rfl
  | .cons r' κ s' r, j + 1, rs, ε, x, y, h => by
    simp only [Kids.snoc, Kids.set]
    rw [Kids.set_snoc rs ε x y (by simp [Kids.length] at h; omega)]

theorem mainDead_taskDone {s : State} (h : s.mainDead = true) : taskDone s = none := by
  cases s with
  | panic => rfl
  | fam id o n m ks =>
    cases m with
    | panic => simp [taskDone]
    | _ => simp [State.mainDead] at h
  | _ => simp [State.mainDead] at h

/-- 死は 1 歩で死のまま（main が panic の task は子だけが歩く） -/
theorem mainDead_step {Δ : Defs} {π : List Bool} {s s' : State} {K K' : ChanSt}
    (hd : s.mainDead = true) (h : step Δ π s K = some (s', K')) : s'.mainDead = true := by
  cases s with
  | panic H => simp [step] at h
  | fam id o n m ks =>
    cases m with
    | panic H =>
      rw [step_fam_def] at h
      cases π with
      | cons c π' =>
        cases c with
        | false =>
          obtain ⟨⟨ks', K₁⟩, -, heq⟩ := Option.map_eq_some_iff.mp h
          simp only [Prod.mk.injEq] at heq
          obtain ⟨rfl, rfl⟩ := heq
          rfl
        | true => simp [famMain, step] at h
      | nil => simp [famMain, step] at h
    | _ => simp [State.mainDead] at hd
  | _ => simp [State.mainDead] at hd

/-- 歩ける子の置き換えの下で、scope の出口の判定（settledAt / deadAt）は、決着していたなら変わらない -/
theorem Kids.settled_set : ∀ {ks : Kids} {j rs0 rs : Nat} {kid x : State},
    ks.get? j = some (rs, kid) → taskDone kid = none → (kid.mainDead = true → x.mainDead = true) →
    ks.settledAt rs0 = true → (ks.set j x).settledAt rs0 = true ∧ (ks.set j x).deadAt rs0 = ks.deadAt rs0
  | .nil, _, _, _, _, _, h, _, _, _ => by simp [Kids.get?] at h
  | .cons r κ s rest, 0, rs0, rs, kid, x, h, hd, hdead, hset => by
    simp only [Kids.get?, Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, rfl⟩ := h
    have hs : (taskDone s).isSome = false := by rw [hd]; rfl
    simp only [Kids.settledAt, Kids.deadAt, Kids.set] at hset ⊢
    rw [hs, Bool.or_false] at hset
    have hrest := ((Bool.and_eq_true _ _).mp hset).2
    have hhead := ((Bool.and_eq_true _ _).mp hset).1
    cases hb : (r == rs0) with
    | false =>
      have hb' : (r != rs0) = true := by rw [bne, hb]; rfl
      rw [hb'] at hhead ⊢
      exact ⟨by rw [Bool.true_or, Bool.true_or, Bool.true_and]; exact hrest, rfl⟩
    | true =>
      have hb' : (r != rs0) = false := by rw [bne, hb]; rfl
      rw [hb', Bool.false_or] at hhead
      rw [hb', hdead hhead, hhead, Bool.false_or, Bool.or_true, Bool.true_and]
      exact ⟨hrest, rfl⟩
  | .cons r κ s rest, j + 1, rs0, rs, kid, x, h, hd, hdead, hset => by
    simp only [Kids.get?] at h
    simp only [Kids.settledAt, Kids.set, Kids.deadAt] at hset ⊢
    have hrest := ((Bool.and_eq_true _ _).mp hset).2
    have hhead := ((Bool.and_eq_true _ _).mp hset).1
    obtain ⟨h1, h2⟩ := Kids.settled_set h hd hdead hrest
    rw [h1, h2, hhead]
    exact ⟨rfl, rfl⟩

/-- 歩ける子の置き換えの下で、決着した scope の未回収の失敗（failAt）は変わらない（置き換える子は未完了 — 失敗を持たない・死なら死のまま） -/
theorem Kids.failAt_set : ∀ {ks : Kids} {j rs0 rs : Nat} {kid x : State},
    ks.get? j = some (rs, kid) → taskRes kid = none → (kid.mainDead = true → taskRes x = none) →
    ks.settledAt rs0 = true → (ks.set j x).failAt rs0 = ks.failAt rs0
  | .nil, _, _, _, _, _, h, _, _, _ => by simp [Kids.get?] at h
  | .cons r κ s rest, 0, rs0, rs, kid, x, h, hd, hdead, hset => by
    simp only [Kids.get?, Option.some.injEq, Prod.mk.injEq] at h
    obtain ⟨rfl, rfl⟩ := h
    have hs : (taskDone s).isSome = false := by rw [taskDone_eq_taskRes, hd]; rfl
    simp only [Kids.settledAt, Kids.set, Kids.failAt] at hset ⊢
    rw [hs, Bool.or_false] at hset
    have hhead := ((Bool.and_eq_true _ _).mp hset).1
    cases hb : (r == rs0) with
    | false => rfl
    | true =>
      have hb' : (r != rs0) = false := by rw [bne, hb]; rfl
      rw [hb', Bool.false_or] at hhead
      rw [hd, hdead hhead]
  | .cons r κ s rest, j + 1, rs0, rs, kid, x, h, hd, hdead, hset => by
    simp only [Kids.get?] at h
    simp only [Kids.settledAt, Kids.set, Kids.failAt] at hset ⊢
    have hrest := ((Bool.and_eq_true _ _).mp hset).2
    rw [Kids.failAt_set h hd hdead hrest]

theorem mainOp_set (id : List Nat) (n : Nat) (ks : Kids) (j : Nat) (x : State) (m : State) :
    mainOp id n (ks.set j x) m = mainOp id n ks m := by
  unfold mainOp; split <;> simp [Kids.length_set]

/-- 子 j の 1 歩（未完了・死は死のまま）の下で、main の続きは子 j を置き換えるだけ -/
theorem mainCont_set {Δ : Defs} {π : List Bool} {id : List Nat} {o n : Nat} {m : State} {ks : Kids}
    {res : Option Pkt} {s1 : State} {j rs : Nat} {kid x : State}
    (hg : ks.get? j = some (rs, kid)) (hd : taskDone kid = none) (hdead : kid.mainDead = true → x.mainDead = true)
    (h : mainCont Δ π id o n m ks res = some s1) :
    mainCont Δ π id o n m (ks.set j x) res = some (s1.setKid j x) := by
  have hj := Kids.get?_lt hg
  have hxd : kid.mainDead = true → taskDone x = none := fun hm => mainDead_taskDone (hdead hm)
  have hdr : taskRes kid = none := by
    have h1 := taskDone_eq_taskRes kid; rw [hd] at h1
    cases hr : taskRes kid with
    | none => rfl
    | some p => rw [hr] at h1; simp at h1
  have hxr : kid.mainDead = true → taskRes x = none := fun hm => by
    have h1 := taskDone_eq_taskRes x; rw [hxd hm] at h1
    cases hr : taskRes x with
    | none => rfl
    | some p => rw [hr] at h1; simp at h1
  unfold mainCont at h ⊢
  split at h
  -- spawn
  · split at h
    · simp only [Option.some.injEq] at h; subst h
      simp only [State.setKid, Kids.length_set, Kids.set_snoc _ _ _ _ hj]
    · simp only [Option.some.injEq] at h; subst h; rfl
  -- newch / 送信 / 受信（受信は梱包を写す — 失敗の腕は none）
  all_goals try (split at h <;> (simp only [Option.some.injEq] at h; subst h; rfl))
  all_goals try (split at h <;> (try split at h) <;> first | (simp only [Option.some.injEq] at h; subst h; rfl) | (cases h; done))
  all_goals try (simp only [Option.some.injEq] at h; subst h; rfl)
  -- join / try: 子 j を見るなら、子 j は未完了なので死の腕 — 置き換えた子も死・未完了
  case h_6 | h_7 =>
    rename_i i
    by_cases hij : i - o = j
    · rw [hij] at h ⊢
      rw [hg] at h
      rw [Kids.get?_set_self x hg]
      cases hdec : decide (o ≤ i) <;> simp only [hdec] at h ⊢
      · simp only [Option.some.injEq] at h; subst h; rfl
      · simp only [hdr] at h
        split at h
        · rename_i hm
          simp only [Option.some.injEq] at h; subst h
          simp [hxr hm, hdead hm, State.setKid]
        · cases h
    · rw [Kids.get?_set_ne x hij]
      revert h
      split <;> (try split) <;> (try split) <;> (try split) <;> intro h <;>
        first | (cases h; done) | (simp only [Option.some.injEq] at h; subst h; simp_all [State.setKid, Kids.mark_set])
  case h_8 =>
    rename_i H S t ε v
    split at h
    · rename_i hset
      obtain ⟨h1, h2⟩ := Kids.settled_set hg hd hdead hset
      have h3 := Kids.failAt_set hg hdr hxr hset
      rw [if_pos h1, h2, h3]
      split at h
      · rename_i hda
        simp only [Option.some.injEq] at h; subst h; simp [hda, State.setKid]
      · rename_i hda
        revert h
        split <;> (try split) <;> (try split) <;> intro h <;>
          first | (cases h; done) | (simp only [Option.some.injEq] at h; subst h; simp_all [State.setKid])
    · cases h
  case h_14 =>
    obtain ⟨p, hp, rfl⟩ := Option.map_eq_some_iff.mp h
    rw [hp]; rfl

theorem State.fixLeaf_idem (s : State) : s.fixLeaf.fixLeaf = s.fixLeaf := by
  cases s <;> rfl

/-- main の続きの形: 同じ id・o の task で、main は葉、子は同じか末尾に新しい子（id ++ [長さ]） -/
theorem mainCont_out {Δ : Defs} {π : List Bool} {id : List Nat} {o n : Nat} {m : State} {ks : Kids}
    {res : Option Pkt} {s1 : State} (h : mainCont Δ π id o n m ks res = some s1) :
    ∃ n' m' ks1, s1 = .fam id o n' m' ks1 ∧ m'.fixLeaf = m' ∧
      (ks1 = ks ∨ (∃ i, ks1 = ks.mark i) ∨ ∃ rs ε y, ks1 = ks.snoc rs ε y ∧ TaskOk (id ++ [ks.length]) y) := by
  unfold mainCont at h
  split at h
  · split at h
    · simp only [Option.some.injEq] at h; subst h
      exact ⟨_, _, _, rfl, rfl, .inr (.inr ⟨_, _, _, rfl, .mk rfl .nil⟩)⟩
    · simp only [Option.some.injEq] at h; subst h
      exact ⟨_, _, _, rfl, rfl, .inl rfl⟩
  case h_14 =>
    obtain ⟨p, -, rfl⟩ := Option.map_eq_some_iff.mp h
    exact ⟨_, _, _, rfl, State.fixLeaf_idem _, .inl rfl⟩
  all_goals
    repeat' split at h
    all_goals first
      | (cases h; done)
      | (simp only [Option.some.injEq] at h; subst h; exact ⟨_, _, _, rfl, rfl, .inl rfl⟩)
      | (simp only [Option.some.injEq] at h; subst h; exact ⟨_, _, _, rfl, rfl, .inr (.inl ⟨_, rfl⟩)⟩)

theorem KidsOk.snoc : ∀ {P : List Nat} {j : Nat} {ks : Kids} {rs : Nat} {ε : Ty} {y : State},
    KidsOk P j ks → TaskOk (P ++ [j + ks.length]) y → KidsOk P j (ks.snoc rs ε y)
  | _, _, .nil, _, _, _, _, hy => .cons (by simpa [Kids.length] using hy) .nil
  | _, j, .cons _ κ _ r, _, _, _, .cons ht hr, hy =>
    .cons ht (KidsOk.snoc hr (by simpa [Kids.length, Nat.add_assoc, Nat.add_comm 1] using hy))

theorem KidsOk.mark : ∀ {P : List Nat} {j : Nat} {ks : Kids} (i : Nat), KidsOk P j ks → KidsOk P j (ks.mark i)
  | _, _, .nil, _, h => h
  | _, _, .cons _ _ _ _, 0, .cons ht hr => .cons ht hr
  | _, _, .cons _ _ _ _, i + 1, .cons ht hr => .cons ht (KidsOk.mark i hr)

theorem KidsOk.set : ∀ {P : List Nat} {j i : Nat} {ks : Kids} {rs : Nat} {kid y : State},
    KidsOk P j ks → ks.get? i = some (rs, kid) → TaskOk (P ++ [j + i]) y → KidsOk P j (ks.set i y)
  | _, _, _, .nil, _, _, _, _, h, _ => by simp [Kids.get?] at h
  | _, j, 0, .cons _ κ _ r, _, _, _, .cons _ hr, _, hy => .cons (by simpa using hy) hr
  | _, j, i + 1, .cons _ κ _ r, _, _, _, .cons ht hr, h, hy =>
    .cons ht (KidsOk.set hr h (by simpa [Nat.add_assoc, Nat.add_comm 1] using hy))

theorem KidsOk.get : ∀ {P : List Nat} {j i : Nat} {ks : Kids} {rs : Nat} {kid : State},
    KidsOk P j ks → ks.get? i = some (rs, kid) → TaskOk (P ++ [j + i]) kid
  | _, _, _, .nil, _, _, _, h => by simp [Kids.get?] at h
  | _, j, 0, .cons _ κ _ _, _, _, .cons ht _, h => by
    simp [Kids.get?] at h; obtain ⟨rfl, rfl⟩ := h; simpa using ht
  | _, j, i + 1, .cons _ κ _ _, _, _, .cons _ hr, h => by
    simp only [Kids.get?] at h; simpa [Nat.add_assoc, Nat.add_comm 1] using KidsOk.get hr h

mutual
/-- 整形は 1 歩で保たれる -/
theorem taskOk_step {Δ : Defs} : ∀ {P : List Nat} {s : State} {π : List Bool} {K : ChanSt} {s' : State} {K' : ChanSt},
    TaskOk P s → step Δ π s K = some (s', K') → TaskOk P s'
  | _, _, π, K, s', K', .mk (id := id) (o := o) (n := n) (m := m) (ks := ks) hl hk, h => by
    rw [step_fam_def] at h
    have hmain : ∀ π', famMain id o n m ks K (step Δ π' m K) = some (s', K') → TaskOk id s' := by
      intro π' hm
      rw [famMain_spec Δ π' id o n m ks K hl] at hm
      obtain ⟨⟨r, K₁⟩, -, hc⟩ := Option.bind_eq_some_iff.mp hm
      obtain ⟨s₁, hs₁, heq⟩ := Option.map_eq_some_iff.mp hc
      simp only [Prod.mk.injEq] at heq
      obtain ⟨rfl, rfl⟩ := heq
      obtain ⟨n', m', ks1, rfl, hl', hks⟩ := mainCont_out hs₁
      refine .mk hl' ?_
      rcases hks with rfl | ⟨i, rfl⟩ | ⟨rs, ε, y, rfl, hy⟩
      · exact hk
      · exact KidsOk.mark i hk
      · exact KidsOk.snoc hk (by simpa using hy)
    cases π with
    | cons c π' =>
      cases c with
      | false =>
        obtain ⟨⟨ks', K₁⟩, hsk, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        exact .mk hl (kidsOk_step hk hsk)
      | true => exact hmain π' h
    | nil => exact hmain [] h

theorem kidsOk_step {Δ : Defs} : ∀ {P : List Nat} {j : Nat} {ks : Kids} {π : List Bool} {K : ChanSt} {ks' : Kids} {K' : ChanSt},
    KidsOk P j ks → stepKids Δ π ks K = some (ks', K') → KidsOk P j ks'
  | _, _, _, π, K, ks', K', .nil, h => by simp [stepKids] at h
  | P, j, _, π, K, ks', K', .cons (rs := rs) (s := s) (r := rest) ht hr, h => by
    cases π with
    | nil => simp [stepKids] at h
    | cons c π' =>
      cases c with
      | true =>
        simp only [stepKids] at h
        obtain ⟨⟨s₁, K₁⟩, hst, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        exact .cons (taskOk_step ht hst) hr
      | false =>
        simp only [stepKids] at h
        obtain ⟨⟨ks₁, K₁⟩, hsk, heq⟩ := Option.map_eq_some_iff.mp h
        simp only [Prod.mk.injEq] at heq
        obtain ⟨rfl, rfl⟩ := heq
        exact .cons ht (kidsOk_step hr hsk)
end


/-! ## 独立性: 部分木が交わらない操作・main と子の操作 -/

theorem pre_eq_idx {P x : List Nat} {j1 j2 : Nat} (h1 : P ++ [j1] <+: x) (h2 : P ++ [j2] <+: x) : j1 = j2 := by
  have hl : (P ++ [j1]).length ≤ (P ++ [j2]).length := by simp
  have := (List.prefix_of_prefix_length_le h1 h2 hl).eq_of_length (by simp)
  simpa using this

theorem pre_ne_self {P y : List Nat} {j : Nat} (h : P ++ [j] <+: y) : P ≠ y := by
  intro he; subst he
  have := h.length_le; simp at this; omega

/-- 違う子の部分木の操作は独立 -/
theorem indep_disjoint {P : List Nat} {j1 j2 : Nat} {b1 b2 : Op}
    (h1 : OpIn (P ++ [j1]) b1) (h2 : OpIn (P ++ [j2]) b2) (hne : j1 ≠ j2) : b1.Indep b2 := by
  refine ⟨fun x y hx hy he => ?_, fun x y hx hy he => ?_, fun x y hx hy he => ?_⟩
  · subst he; exact hne (pre_eq_idx (h1.1 x hx) (h2.1 x hy))
  · subst he; exact hne (pre_eq_idx (h1.1 x hx) (h2.2 x hy))
  · subst he; exact hne (pre_eq_idx (h1.2 x hx) (h2.1 x hy))

theorem mainOp_who {id : List Nat} {n : Nat} {ks : Kids} {m : State} {x : List Nat}
    (h : (mainOp id n ks m).who = Option.some x) : x = id := by
  unfold mainOp at h; split at h <;> simp [Op.who] at h <;> exact h.symm

theorem mainOp_kid {id : List Nat} {n : Nat} {ks : Kids} {m : State} {x : List Nat}
    (h : (mainOp id n ks m).kid = Option.some x) : x = id ++ [ks.length] := by
  unfold mainOp at h; split at h <;> simp [Op.kid] at h <;> exact h.symm

/-- main の操作と、子 j（j < 子の数）の部分木の操作は独立 -/
theorem indep_main_kid {id : List Nat} {n : Nat} {ks : Kids} {m : State} {j : Nat} {b : Op}
    (hb : OpIn (id ++ [j]) b) (hj : j < ks.length) : (mainOp id n ks m).Indep b := by
  refine ⟨fun x y hx hy he => ?_, fun x y hx hy he => ?_, fun x y hx hy he => ?_⟩
  · rw [mainOp_who hx] at he; exact pre_ne_self (hb.1 y hy) he
  · rw [mainOp_who hx] at he; exact pre_ne_self (hb.2 y hy) he
  · rw [mainOp_kid hx] at he; subst he
    have := pre_eq_idx (hb.1 _ hy) (List.prefix_refl _)
    omega

/-! ## main の歩の π 非依存 -/

theorem leaf_pi {Δ : Defs} {πa πb : List Bool} {m : State} {K : ChanSt} (hl : m.fixLeaf = m) (hr : m.legRedex = false) :
    step Δ πb m K = step Δ πa m K := by
  rw [stepLeaf_all Δ πa πb m K K hl hr]
  cases h : step Δ πa m K with
  | none => rfl
  | some p =>
    obtain ⟨p1, p2⟩ := p
    obtain ⟨hK, hfx, -⟩ := stepLeaf_some hl hr h
    subst hK; simp [hfx]

theorem famMain_pi {Δ : Defs} {πa πb : List Bool} {id : List Nat} {o n : Nat} {m : State} {ks : Kids} {K : ChanSt}
    (hl : m.fixLeaf = m) :
    famMain id o n m ks K (step Δ πa m K) = famMain id o n m ks K (step Δ πb m K) := by
  rw [famMain_spec Δ πa id o n m ks K hl, famMain_spec Δ πb id o n m ks K hl]
  by_cases hr : m.legRedex = true
  · unfold State.legRedex at hr
    split at hr <;> first | (simp at hr; done) | rfl
  · simp only [Bool.not_eq_true] at hr
    rw [← famMain_spec Δ πa id o n m ks K hl, ← famMain_spec Δ πb id o n m ks K hl, leaf_pi (πa := πa) (πb := πb) hl hr]

/-- task の main の経路（先頭が false でない）の 1 歩は famMain -/
theorem fam_main_path {Δ : Defs} {π : List Bool} (hπ : ∀ π', π ≠ false :: π') (id : List Nat) (o n : Nat) (m : State)
    (ks : Kids) (K : ChanSt) : step Δ π (.fam id o n m ks) K = famMain id o n m ks K (step Δ π.tail m K) := by
  cases π with
  | nil => rfl
  | cons c π' =>
    cases c with
    | true => rfl
    | false => exact absurd rfl (hπ π')

/-! ## one-step diamond -/

/-- 1 歩の関係（どれかの経路で） -/
def TStep (Δ : Defs) (x y : State × ChanSt) : Prop := ∃ π, step Δ π x.1 x.2 = some y

/-- 合流: 同じか、1 歩ずつで同じ所へ -/
def Joinable (Δ : Defs) (y z : State × ChanSt) : Prop := y = z ∨ ∃ w, TStep Δ y w ∧ TStep Δ z w

theorem Joinable.symm {Δ : Defs} {y z : State × ChanSt} (h : Joinable Δ y z) : Joinable Δ z y := by
  rcases h with rfl | ⟨w, h1, h2⟩
  · exact .inl rfl
  · exact .inr ⟨w, h2, h1⟩

theorem fam_step_cases {Δ : Defs} {π : List Bool} {id : List Nat} {o n : Nat} {m : State} {ks : Kids} {K : ChanSt}
    {y : State × ChanSt} (h : step Δ π (.fam id o n m ks) K = some y) :
    (∃ πk ks2 K2, π = false :: πk ∧ stepKids Δ πk ks K = some (ks2, K2) ∧ y = (.fam id o n m ks2, K2)) ∨
      famMain id o n m ks K (step Δ π.tail m K) = some y := by
  rw [step_fam_def] at h
  cases π with
  | nil => exact .inr h
  | cons c π' =>
    cases c with
    | true => exact .inr h
    | false =>
      obtain ⟨⟨ks2, K2⟩, hsk, rfl⟩ := Option.map_eq_some_iff.mp h
      exact .inl ⟨π', ks2, K2, rfl, hsk, rfl⟩

/-- main の 1 歩と子の 1 歩は 1 歩ずつで合流する（K の操作は独立・子の歩は main の続きを子 j の置き換えにしか変えない） -/
theorem diamond_main_kid {Δ : Defs} {id : List Nat} {o n : Nat} {m : State} {ks ks2 : Kids} {K Kb : ChanSt}
    {πm πk : List Bool} {y : State × ChanSt} (hl : m.fixLeaf = m) (hk : KidsOk id 0 ks)
    (hm : famMain id o n m ks K (step Δ πm m K) = some y) (hkid : stepKids Δ πk ks K = some (ks2, Kb)) :
    ∃ w, TStep Δ y w ∧ TStep Δ (.fam id o n m ks2, Kb) w := by
  rw [famMain_spec Δ πm id o n m ks K hl] at hm
  obtain ⟨⟨ra, Ka⟩, hra, hc⟩ := Option.bind_eq_some_iff.mp hm
  obtain ⟨s1, hs1, rfl⟩ := Option.map_eq_some_iff.mp hc
  obtain ⟨i, rs, kid, kid', πi, hg, hst, rfl⟩ := stepKids_some hkid
  have htk : TaskOk (id ++ [i]) kid := by simpa using KidsOk.get hk hg
  obtain ⟨b, rb, hin, hrb, hrep⟩ := step_dec htk hst
  have hlt := Kids.get?_lt hg
  obtain ⟨K3, h1, h2⟩ := op_comm (indep_main_kid (n := n) (m := m) hin hlt) hra hrb
  refine ⟨(s1.setKid i kid', K3), ?_, ?_⟩
  · obtain ⟨n', m', ks1, rfl, -, hks⟩ := mainCont_out hs1
    have hg1 : ks1.get? i = some (rs, kid) := by
      rcases hks with rfl | ⟨i', rfl⟩ | ⟨rs', ε', y', rfl, -⟩
      · exact hg
      · rw [Kids.get?_mark]; exact hg
      · rw [Kids.get?_snoc_lt _ _ _ hlt]; exact hg
    refine ⟨false :: kidPath i πi, ?_⟩
    rw [step_fam_def]
    simp [stepKids_of_kid hg1 (hrep Ka K3 h2), State.setKid]
  · refine ⟨true :: πm, ?_⟩
    rw [step_fam_def]
    show famMain id o n m (ks.set i kid') Kb (step Δ πm m Kb) = _
    rw [famMain_spec Δ πm id o n m (ks.set i kid') Kb hl, mainOp_set, h1]
    simp [mainCont_set hg (taskDone_none_of_step hst) (fun hd => mainDead_step hd hst) hs1]

/-- 先頭の子の 1 歩と残りの子の 1 歩は 1 歩ずつで合流する -/
theorem kids_head_rest {Δ : Defs} {P : List Nat} {j rs : Nat} {κ : Ty × Bool} {s s' : State} {rest rest' : Kids} {K Ka Kb : ChanSt}
    {πa πb : List Bool} (ht : TaskOk (P ++ [j]) s) (hr : KidsOk P (j + 1) rest)
    (ha : step Δ πa s K = some (s', Ka)) (hb : stepKids Δ πb rest K = some (rest', Kb)) :
    ∃ ks3 K3, (∃ π, stepKids Δ π (.cons rs κ s' rest) Ka = some (ks3, K3)) ∧
      (∃ π, stepKids Δ π (.cons rs κ s rest') Kb = some (ks3, K3)) := by
  obtain ⟨b1, r1, hin1, hr1, hrep1⟩ := step_dec ht ha
  obtain ⟨i, rs', kid, kid', πi, hg, hst, rfl⟩ := stepKids_some hb
  have htk : TaskOk (P ++ [j + 1 + i]) kid := KidsOk.get hr hg
  obtain ⟨b2, r2, hin2, hr2, hrep2⟩ := step_dec htk hst
  obtain ⟨K3, h1, h2⟩ := op_comm (indep_disjoint hin1 hin2 (by omega)) hr1 hr2
  refine ⟨.cons rs κ s' (rest.set i kid'), K3, ⟨false :: kidPath i πi, ?_⟩, ⟨true :: πa, ?_⟩⟩
  · simp [stepKids, stepKids_of_kid hg (hrep2 Ka K3 h2)]
  · simp [stepKids, hrep1 Kb K3 h1]

mutual
/-- **one-step diamond**（段 6 P1 — Kahn の核）: 整形された task の木の 2 つの 1 歩は、同じ結果か、1 歩ずつで合流する -/
theorem kahn_diamond {Δ : Defs} : ∀ {P : List Nat} {s : State} {π1 π2 : List Bool} {K : ChanSt} {y z : State × ChanSt},
    TaskOk P s → step Δ π1 s K = some y → step Δ π2 s K = some z → Joinable Δ y z
  | _, _, π1, π2, K, y, z, .mk (id := id) (o := o) (n := n) (m := m) (ks := ks) hl hk, h1, h2 => by
    rcases fam_step_cases h1 with ⟨πk1, ks1, K1, -, hk1, rfl⟩ | hm1 <;>
      rcases fam_step_cases h2 with ⟨πk2, ks2, K2, -, hk2, rfl⟩ | hm2
    · rcases kids_diamond hk hk1 hk2 with ⟨rfl, rfl⟩ | ⟨ks3, K3, ⟨πa, ha⟩, ⟨πb, hb⟩⟩
      · exact .inl rfl
      · exact .inr ⟨(.fam id o n m ks3, K3), ⟨false :: πa, by rw [step_fam_def]; simp [ha]⟩,
          ⟨false :: πb, by rw [step_fam_def]; simp [hb]⟩⟩
    · obtain ⟨w, hz, hy⟩ := diamond_main_kid hl hk hm2 hk1
      exact .inr ⟨w, hy, hz⟩
    · obtain ⟨w, hy, hz⟩ := diamond_main_kid hl hk hm1 hk2
      exact .inr ⟨w, hy, hz⟩
    · rw [famMain_pi (πb := π2.tail) hl] at hm1
      rw [hm1] at hm2
      cases hm2
      exact .inl rfl

theorem kids_diamond {Δ : Defs} : ∀ {P : List Nat} {j : Nat} {ks : Kids} {π1 π2 : List Bool} {K : ChanSt}
    {ks1 ks2 : Kids} {K1 K2 : ChanSt},
    KidsOk P j ks → stepKids Δ π1 ks K = some (ks1, K1) → stepKids Δ π2 ks K = some (ks2, K2) →
    (ks1 = ks2 ∧ K1 = K2) ∨ ∃ ks3 K3, (∃ π, stepKids Δ π ks1 K1 = some (ks3, K3)) ∧ (∃ π, stepKids Δ π ks2 K2 = some (ks3, K3))
  | _, _, _, π1, π2, K, ks1, ks2, K1, K2, .nil, h1, _ => by simp [stepKids] at h1
  | P, j, _, π1, π2, K, ks1, ks2, K1, K2, .cons (rs := rs) (κ := κ) (s := s) (r := rest) ht hr, h1, h2 => by
    cases π1 with
    | nil => simp [stepKids] at h1
    | cons c1 a =>
      cases π2 with
      | nil => simp [stepKids] at h2
      | cons c2 b =>
        cases c1 <;> cases c2 <;> simp only [stepKids] at h1 h2
        · -- 残り / 残り
          obtain ⟨⟨r1, K1'⟩, hr1, he1⟩ := Option.map_eq_some_iff.mp h1
          obtain ⟨⟨r2, K2'⟩, hr2, he2⟩ := Option.map_eq_some_iff.mp h2
          simp only [Prod.mk.injEq] at he1 he2
          obtain ⟨rfl, rfl⟩ := he1
          obtain ⟨rfl, rfl⟩ := he2
          rcases kids_diamond hr hr1 hr2 with ⟨rfl, rfl⟩ | ⟨ks3, K3, ⟨πa, ha⟩, ⟨πb, hb⟩⟩
          · exact .inl ⟨rfl, rfl⟩
          · exact .inr ⟨.cons rs κ s ks3, K3, ⟨false :: πa, by simp [stepKids, ha]⟩, ⟨false :: πb, by simp [stepKids, hb]⟩⟩
        · -- 残り / 先頭
          obtain ⟨⟨r1, K1'⟩, hr1, he1⟩ := Option.map_eq_some_iff.mp h1
          obtain ⟨⟨s2, K2'⟩, hs2, he2⟩ := Option.map_eq_some_iff.mp h2
          simp only [Prod.mk.injEq] at he1 he2
          obtain ⟨rfl, rfl⟩ := he1
          obtain ⟨rfl, rfl⟩ := he2
          obtain ⟨ks3, K3, hy, hz⟩ := kids_head_rest ht hr hs2 hr1
          exact .inr ⟨ks3, K3, hz, hy⟩
        · -- 先頭 / 残り
          obtain ⟨⟨s1, K1'⟩, hs1, he1⟩ := Option.map_eq_some_iff.mp h1
          obtain ⟨⟨r2, K2'⟩, hr2, he2⟩ := Option.map_eq_some_iff.mp h2
          simp only [Prod.mk.injEq] at he1 he2
          obtain ⟨rfl, rfl⟩ := he1
          obtain ⟨rfl, rfl⟩ := he2
          exact .inr (kids_head_rest ht hr hs1 hr2)
        · -- 先頭 / 先頭
          obtain ⟨⟨s1, K1'⟩, hs1, he1⟩ := Option.map_eq_some_iff.mp h1
          obtain ⟨⟨s2, K2'⟩, hs2, he2⟩ := Option.map_eq_some_iff.mp h2
          simp only [Prod.mk.injEq] at he1 he2
          obtain ⟨rfl, rfl⟩ := he1
          obtain ⟨rfl, rfl⟩ := he2
          rcases kahn_diamond ht hs1 hs2 with he | ⟨⟨w1, w2⟩, ⟨πa, ha⟩, ⟨πb, hb⟩⟩
          · simp only [Prod.mk.injEq] at he
            obtain ⟨rfl, rfl⟩ := he
            exact .inl ⟨rfl, rfl⟩
          · exact .inr ⟨.cons rs κ w1 rest, w2, ⟨true :: πa, by simp [stepKids, ha]⟩, ⟨true :: πb, by simp [stepKids, hb]⟩⟩
end


/-! ## 合流（Kahn の定理）: 正規形の一意性・歩数の一致・停止の決定性 -/

/-- ちょうど n 歩 -/
inductive Steps (Δ : Defs) : Nat → State × ChanSt → State × ChanSt → Prop where
  | refl {x} : Steps Δ 0 x x
  | step {n x y z} : TStep Δ x y → Steps Δ n y z → Steps Δ (n + 1) x z

/-- 正規形（どの経路でも 1 歩も踏めない — 完了・panic の葉・待機） -/
def Normal (Δ : Defs) (x : State × ChanSt) : Prop := ∀ π, step Δ π x.1 x.2 = none

theorem Normal.not_tstep {Δ : Defs} {x y : State × ChanSt} (h : Normal Δ x) (hs : TStep Δ x y) : False := by
  obtain ⟨π, hπ⟩ := hs
  rw [h π] at hπ; cases hπ

theorem Steps.taskOk {Δ : Defs} {P : List Nat} : ∀ {n : Nat} {x y : State × ChanSt},
    TaskOk P x.1 → Steps Δ n x y → TaskOk P y.1
  | _, _, _, hT, .refl => hT
  | _, _, _, hT, .step ⟨_, hs⟩ hr => Steps.taskOk (taskOk_step hT hs) hr

theorem Steps.one {Δ : Defs} {x y : State × ChanSt} (h : TStep Δ x y) : Steps Δ 1 x y := .step h .refl

theorem Steps.zero_eq {Δ : Defs} {x y : State × ChanSt} (h : Steps Δ 0 x y) : x = y := by
  cases h; rfl

/-- **Kahn の定理**（段 6 P1 — 機械の合流性）: 整形された task の木から正規形 v に n 歩で着く実行があれば、
どの k 歩の実行 u も k ≤ n で、u からちょうど n − k 歩で同じ v に着く（スケジュールは歩数も着く先も変えない） -/
theorem kahn {Δ : Defs} {P : List Nat} {v : State × ChanSt} (hv : Normal Δ v) :
    ∀ (n : Nat) {x : State × ChanSt}, TaskOk P x.1 → Steps Δ n x v →
      ∀ {k : Nat} {u : State × ChanSt}, Steps Δ k x u → k ≤ n ∧ Steps Δ (n - k) u v := by
  intro n
  induction n with
  | zero =>
    intro x _ hxv k u hxu
    obtain rfl := hxv.zero_eq
    cases hxu with
    | refl => exact ⟨Nat.le_refl _, .refl⟩
    | step h1 _ => exact (hv.not_tstep h1).elim
  | succ n ih =>
    intro x hT hxv k u hxu
    cases hxu with
    | refl => exact ⟨Nat.zero_le _, hxv⟩
    | @step k' _ u1 _ hu1 hu =>
      cases hxv with
      | step hv1 hrest =>
        rename_i v1
        obtain ⟨π1, hπ1⟩ := hu1
        obtain ⟨π2, hπ2⟩ := hv1
        have hT1 : TaskOk P u1.1 := taskOk_step hT hπ1
        have hT2 : TaskOk P v1.1 := taskOk_step hT hπ2
        rcases kahn_diamond hT hπ1 hπ2 with rfl | ⟨w, hw1, hw2⟩
        · obtain ⟨hk, hr⟩ := ih hT2 hrest hu
          exact ⟨by omega, by simpa using hr⟩
        · -- v1 → w: w は n − 1 歩で v へ。u1 → w → v は n 歩
          obtain ⟨h1, hwv⟩ := ih hT2 hrest (Steps.one hw2)
          have hu1v : Steps Δ n u1 v := by
            have := Steps.step hw1 hwv
            rwa [show n - 1 + 1 = n by omega] at this
          obtain ⟨hk, hr⟩ := ih hT1 hu1v hu
          exact ⟨by omega, by simpa using hr⟩

/-- 正規形の一意性と歩数の一致: 2 つの実行がどちらも正規形に着くなら、同じ状態に同じ歩数で着く -/
theorem kahn_unique {Δ : Defs} {P : List Nat} {x u v : State × ChanSt} {n k : Nat} (hT : TaskOk P x.1)
    (hv : Normal Δ v) (hu : Normal Δ u) (hxv : Steps Δ n x v) (hxu : Steps Δ k x u) : u = v ∧ k = n := by
  obtain ⟨hk, hr⟩ := kahn hv n hT hxv hxu
  generalize hm : n - k = m at hr
  cases hr with
  | refl => exact ⟨rfl, by omega⟩
  | step h _ => exact (hu.not_tstep h).elim

/-- 停止の決定性: 正規形に n 歩で着く実行があれば、n 歩を超える実行は無い（どのスケジュールも止まる） -/
theorem kahn_bounded {Δ : Defs} {P : List Nat} {x v u : State × ChanSt} {n k : Nat} (hT : TaskOk P x.1)
    (hv : Normal Δ v) (hxv : Steps Δ n x v) (hxu : Steps Δ k x u) : k ≤ n :=
  (kahn hv n hT hxv hxu).1

/-- 根の task は整形されている -/
theorem taskOk_loadT (e : Expr) : TaskOk [] (loadT e) := .mk rfl .nil

/-- スケジュールつき実行は何歩かの実行 -/
theorem run_steps {Δ : Defs} : ∀ (πs : List (List Bool)) (x : State × ChanSt), ∃ k, Steps Δ k x (run Δ πs x.1 x.2)
  | [], x => ⟨0, .refl⟩
  | π :: πs, x => by
    simp only [run]
    split
    · rename_i s' K' h
      obtain ⟨k, hk⟩ := run_steps πs (s', K')
      exact ⟨k + 1, .step ⟨π, h⟩ hk⟩
    · exact ⟨0, .refl⟩

/-- **スケジュール非依存**（loadT の全プログラム — 旧 par / 旧 chan は task の中では panic なので無条件）:
2 つのスケジュールの実行がどちらも止まった（正規形 — 完了・panic・待機〔デッドロックを含む〕）なら、最終状態は一致する。
デッドロックの有無まで決定的: 片方が待機で止まれば、止まった他方も同じ待機の状態 -/
theorem kahn_schedule {Δ : Defs} (e : Expr) (πs1 πs2 : List (List Bool))
    (h1 : Normal Δ (run Δ πs1 (loadT e) ∅)) (h2 : Normal Δ (run Δ πs2 (loadT e) ∅)) :
    run Δ πs1 (loadT e) ∅ = run Δ πs2 (loadT e) ∅ := by
  obtain ⟨k1, hk1⟩ := run_steps (Δ := Δ) πs1 (loadT e, ∅)
  obtain ⟨k2, hk2⟩ := run_steps (Δ := Δ) πs2 (loadT e, ∅)
  exact (kahn_unique (taskOk_loadT e) h2 h1 hk2 hk1).1

/-- 停止の決定性（loadT）: どれかのスケジュールで止まるなら、歩数の上界 n があり、どのスケジュールの実行も n 歩を超えない
（止まらないスケジュールは存在しない） -/
theorem kahn_schedule_bounded {Δ : Defs} (e : Expr) (πs1 : List (List Bool))
    (h1 : Normal Δ (run Δ πs1 (loadT e) ∅)) :
    ∃ n, ∀ (k : Nat) (u : State × ChanSt), Steps Δ k (loadT e, ∅) u → k ≤ n := by
  obtain ⟨k1, hk1⟩ := run_steps (Δ := Δ) πs1 (loadT e, ∅)
  exact ⟨k1, fun k u hk => kahn_bounded (taskOk_loadT e) h1 hk1 hk⟩

end FS
