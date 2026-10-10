import FeatherweightSober.Machine

/-!
# task（fam）の機械の補題（段 6 P1）

子の並び（Kids）の操作と、fam の 1 歩の分解。型付けを含まない（Soundness / Kahn が使う）。
-/

namespace FS

/-- i 番目の子の状態を置き換える（scope の region はそのまま） -/
def Kids.set : Kids → Nat → State → Kids
  | .nil, _, _ => .nil
  | .cons rs κ _ r, 0, s' => .cons rs κ s' r
  | .cons rs κ s r, i + 1, s' => .cons rs κ s (r.set i s')

theorem Kids.length_set : ∀ (ks : Kids) (i : Nat) (s' : State), (ks.set i s').length = ks.length
  | .nil, _, _ => rfl
  | .cons _ κ _ _, 0, _ => rfl
  | .cons _ κ _ r, i + 1, s' => by simp [Kids.set, Kids.length, Kids.length_set r i s']

theorem Kids.get?_set_self : ∀ {ks : Kids} {i : Nat} {rs : Nat} {s : State} (s' : State),
    ks.get? i = some (rs, s) → (ks.set i s').get? i = some (rs, s')
  | .nil, _, _, _, _, h => by simp [Kids.get?] at h
  | .cons _ κ _ _, 0, _, _, _, h => by simp [Kids.get?] at h; obtain ⟨rfl, rfl⟩ := h; rfl
  | .cons _ κ _ r, i + 1, _, _, s', h => by simp only [Kids.get?] at h; exact Kids.get?_set_self (ks := r) s' h

theorem Kids.get?_set_ne : ∀ {ks : Kids} {i j : Nat} (s' : State), j ≠ i → (ks.set i s').get? j = ks.get? j
  | .nil, _, _, _, _ => rfl
  | .cons _ κ _ _, 0, 0, _, h => absurd rfl h
  | .cons _ κ _ _, 0, _ + 1, _, _ => rfl
  | .cons _ κ _ _, _ + 1, 0, _, _ => rfl
  | .cons _ κ _ r, i + 1, j + 1, s', h => by
    simp only [Kids.set, Kids.get?]; exact Kids.get?_set_ne (ks := r) s' (by omega)

theorem Kids.get?_lt : ∀ {ks : Kids} {i : Nat} {p : Nat × State}, ks.get? i = some p → i < ks.length
  | .nil, _, _, h => by simp [Kids.get?] at h
  | .cons _ κ _ _, 0, _, _ => by simp [Kids.length]
  | .cons _ κ _ r, i + 1, _, h => by
    simp only [Kids.get?] at h; have := Kids.get?_lt (ks := r) h; simp [Kids.length]; omega

theorem Kids.length_snoc : ∀ (ks : Kids) (rs : Nat) (ε : Ty) (s : State), (ks.snoc rs ε s).length = ks.length + 1
  | .nil, _, _, _ => rfl
  | .cons _ κ _ r, rs, ε, s => by simp [Kids.snoc, Kids.length, Kids.length_snoc r rs ε s]

theorem Kids.get?_snoc_lt : ∀ {ks : Kids} {i : Nat} (rs : Nat) (ε : Ty) (s : State), i < ks.length →
    (ks.snoc rs ε s).get? i = ks.get? i
  | .nil, _, _, _, _, h => by simp [Kids.length] at h
  | .cons _ κ _ _, 0, _, _, _, _ => rfl
  | .cons _ κ _ r, i + 1, rs, ε, s, h => by
    simp only [Kids.snoc, Kids.get?]; exact Kids.get?_snoc_lt (ks := r) rs ε s (by simp [Kids.length] at h; omega)

theorem Kids.get?_snoc_self : ∀ (ks : Kids) (rs : Nat) (ε : Ty) (s : State), (ks.snoc rs ε s).get? ks.length = some (rs, s)
  | .nil, _, _, _ => rfl
  | .cons _ κ _ r, rs, ε, s => by simp only [Kids.snoc, Kids.length, Kids.get?]; exact Kids.get?_snoc_self r rs ε s

theorem Kids.get?_snoc_gt : ∀ {ks : Kids} {i : Nat} (rs : Nat) (ε : Ty) (s : State), ks.length < i →
    (ks.snoc rs ε s).get? i = none
  | .nil, 0, _, _, _, h => by simp [Kids.length] at h
  | .nil, _ + 1, _, _, _, _ => rfl
  | .cons _ κ _ _, 0, _, _, _, h => by simp [Kids.length] at h
  | .cons _ κ _ r, i + 1, rs, ε, s, h => by
    simp only [Kids.snoc, Kids.get?]; exact Kids.get?_snoc_gt (ks := r) rs ε s (by simp [Kids.length] at h; omega)

/-! ### 回収済みの印（P3b-4 1b'）: mark は状態を変えない -/

theorem Kids.length_mark : ∀ (ks : Kids) (i : Nat), (ks.mark i).length = ks.length
  | .nil, _ => rfl
  | .cons _ _ _ _, 0 => rfl
  | .cons _ _ _ r, i + 1 => by simp [Kids.mark, Kids.length, Kids.length_mark r i]

theorem Kids.get?_mark : ∀ (ks : Kids) (i j : Nat), (ks.mark i).get? j = ks.get? j
  | .nil, _, _ => rfl
  | .cons _ _ _ _, 0, 0 => rfl
  | .cons _ _ _ _, 0, _ + 1 => rfl
  | .cons _ _ _ _, _ + 1, 0 => rfl
  | .cons _ _ _ r, i + 1, j + 1 => by simp only [Kids.mark, Kids.get?]; exact Kids.get?_mark r i j

theorem Kids.tag?_set : ∀ (ks : Kids) (i j : Nat) (s' : State), (ks.set i s').tag? j = ks.tag? j
  | .nil, _, _, _ => rfl
  | .cons _ _ _ _, 0, 0, _ => rfl
  | .cons _ _ _ _, 0, _ + 1, _ => rfl
  | .cons _ _ _ _, _ + 1, 0, _ => rfl
  | .cons _ _ _ r, i + 1, j + 1, s' => by simp only [Kids.set, Kids.tag?]; exact Kids.tag?_set r i j s'

/-- mark は札の err の型を変えない -/
theorem Kids.tag?_mark : ∀ (ks : Kids) (i j : Nat) (tg : Ty × Bool), (ks.mark i).tag? j = some tg →
    ∃ tg', ks.tag? j = some tg' ∧ tg'.1 = tg.1
  | .nil, _, _, _, h => by simp [Kids.mark, Kids.tag?] at h
  | .cons _ κ _ _, 0, 0, tg, h => by simp only [Kids.mark, Kids.tag?, Option.some.injEq] at h; subst h; exact ⟨κ, rfl, rfl⟩
  | .cons _ κ _ _, 0, _ + 1, tg, h => ⟨tg, h, rfl⟩
  | .cons _ κ _ _, _ + 1, 0, tg, h => ⟨tg, h, rfl⟩
  | .cons _ _ _ r, i + 1, j + 1, tg, h => by simp only [Kids.mark, Kids.tag?] at h ⊢; exact Kids.tag?_mark r i j tg h

theorem Kids.tag?_snoc : ∀ (ks : Kids) (rs : Nat) (ε : Ty) (s : State) (j : Nat) (tg : Ty × Bool),
    (ks.snoc rs ε s).tag? j = some tg → (j < ks.length ∧ ks.tag? j = some tg) ∨ (j = ks.length ∧ tg = (ε, false))
  | .nil, _, _, _, 0, tg, h => by simp only [Kids.snoc, Kids.tag?, Option.some.injEq] at h; subst h; exact .inr ⟨rfl, rfl⟩
  | .nil, _, _, _, _ + 1, _, h => by simp [Kids.snoc, Kids.tag?] at h
  | .cons _ κ _ _, _, _, _, 0, tg, h => .inl ⟨by simp [Kids.length], h⟩
  | .cons _ _ _ r, rs, ε, s, j + 1, tg, h => by
    simp only [Kids.snoc, Kids.tag?] at h
    rcases Kids.tag?_snoc r rs ε s j tg h with ⟨h1, h2⟩ | ⟨h1, h2⟩
    · exact .inl ⟨by simp [Kids.length]; omega, h2⟩
    · exact .inr ⟨by simp [Kids.length]; omega, h2⟩

theorem Kids.mark_set : ∀ (ks : Kids) (i j : Nat) (s' : State), (ks.mark i).set j s' = (ks.set j s').mark i
  | .nil, _, _, _ => rfl
  | .cons _ _ _ _, 0, 0, _ => rfl
  | .cons _ _ _ _, 0, _ + 1, _ => rfl
  | .cons _ _ _ _, _ + 1, 0, _ => rfl
  | .cons _ _ _ r, i + 1, j + 1, s' => by simp only [Kids.mark, Kids.set]; rw [Kids.mark_set r i j s']

theorem Kids.get?_ge : ∀ {ks : Kids} {i : Nat}, ks.length ≤ i → ks.get? i = none
  | .nil, _, _ => rfl
  | .cons _ κ _ _, 0, h => by simp [Kids.length] at h
  | .cons _ κ _ r, i + 1, h => by simp only [Kids.get?]; exact Kids.get?_ge (ks := r) (by simp [Kids.length] at h; omega)

/-- 子の 1 歩の分解: どれか 1 人（i 番目）が π' で 1 歩踏み、その子だけ置き換わる -/
theorem stepKids_some : ∀ {Δ : Defs} {π : List Bool} {ks ks' : Kids} {K K' : ChanSt},
    stepKids Δ π ks K = some (ks', K') →
    ∃ i rs kid kid' π', ks.get? i = some (rs, kid) ∧ step Δ π' kid K = some (kid', K') ∧ ks' = ks.set i kid'
  | _, _, .nil, _, _, _, h => by simp [stepKids] at h
  | Δ, π, .cons rs κ s r, ks', K, K', h => by
    cases π with
    | nil => simp [stepKids] at h
    | cons c π' =>
      cases c with
      | true =>
        simp only [stepKids] at h
        cases hs : step Δ π' s K with
        | none => simp [hs] at h
        | some p =>
          obtain ⟨s', K₁⟩ := p
          simp [hs] at h
          obtain ⟨rfl, rfl⟩ := h
          exact ⟨0, rs, s, s', π', rfl, hs, rfl⟩
      | false =>
        simp only [stepKids] at h
        cases hs : stepKids Δ π' r K with
        | none => simp [hs] at h
        | some p =>
          obtain ⟨r', K₁⟩ := p
          simp [hs] at h
          obtain ⟨rfl, rfl⟩ := h
          obtain ⟨i, rs', kid, kid', π'', h1, h2, h3⟩ := stepKids_some hs
          exact ⟨i + 1, rs', kid, kid', π'', h1, h2, by rw [h3]; rfl⟩

/-- 逆向き: i 番目の子が π' で 1 歩踏めるなら、子の列は false^i true π' で踏める -/
def kidPath : Nat → List Bool → List Bool
  | 0, π' => true :: π'
  | i + 1, π' => false :: kidPath i π'

theorem stepKids_of_kid : ∀ {Δ : Defs} {ks : Kids} {i rs : Nat} {kid kid' : State} {π' : List Bool} {K K' : ChanSt},
    ks.get? i = some (rs, kid) → step Δ π' kid K = some (kid', K') →
    stepKids Δ (kidPath i π') ks K = some (ks.set i kid', K')
  | _, .nil, _, _, _, _, _, _, _, h, _ => by simp [Kids.get?] at h
  | Δ, .cons rs κ s r, 0, _, _, kid', π', K, K', h, hs => by
    simp [Kids.get?] at h; obtain ⟨rfl, rfl⟩ := h
    simp [kidPath, stepKids, hs, Kids.set]
  | Δ, .cons rs κ s r, i + 1, _, _, kid', π', K, K', h, hs => by
    simp only [Kids.get?] at h
    simp [kidPath, stepKids, stepKids_of_kid (ks := r) h hs, Kids.set]

/-- fam の 1 歩の展開（step の fam の腕） -/
theorem step_fam_def (Δ : Defs) (π : List Bool) (id : List Nat) (o n : Nat) (m : State) (ks : Kids) (K : ChanSt) :
    step Δ π (.fam id o n m ks) K =
      match π with
      | false :: π' => (stepKids Δ π' ks K).map (fun p => (.fam id o n m p.1, p.2))
      | _ => famMain id o n m ks K (step Δ π.tail m K) := by
  cases π with
  | nil => rfl
  | cons c π' => cases c <;> rfl

/-- 葉（fam でない状態）の 1 歩は葉のまま: task の外の spawn / join / try は panic で閉じるので、fam を作るのは fam の main の spawn だけ -/
theorem step_isFam {Δ : Defs} {π : List Bool} {s s' : State} {K K' : ChanSt}
    (hf : s.isFam = false) (h : step Δ π s K = some (s', K')) : s'.isFam = false := by
  cases s with
  | fam => simp [State.isFam] at hf
  | panic => simp [step] at h
  | par H S s1 s2 =>
    rw [step_par_def] at h
    split at h
    · cases h; rfl
    · cases π with
      | nil => simp at h
      | cons c π' =>
        cases c <;> simp only at h <;> split at h <;>
          first | (cases h; rfl) | (obtain ⟨p, -, hp⟩ := Option.map_eq_some_iff.mp h; cases hp; rfl)
  | eval H S e =>
    unfold step at h
    repeat' split at h
    all_goals first | contradiction | (simp at h; done) | (simp only [Option.some.injEq, Prod.mk.injEq] at h; obtain ⟨rfl, -⟩ := h; rfl)
  | ret H S v =>
    unfold step at h
    repeat' split at h
    all_goals first | contradiction | (simp at h; done) | (simp only [Option.some.injEq, Prod.mk.injEq] at h; obtain ⟨rfl, -⟩ := h; rfl)

/-- famMain が歩けるなら main は未完了（fam の歩の腕は main がスタックを持つ形 — 委ねた歩なら main 自身が歩けた） -/
theorem taskDone_none_of_famMain {id : List Nat} {o n : Nat} {m : State} {ks : Kids} {K : ChanSt}
    {r : Option (State × ChanSt)} {p : State × ChanSt} (h : famMain id o n m ks K r = some p)
    (hr : ∀ q, r = some q → taskDone m = none) : taskDone m = none := by
  unfold famMain at h
  split at h
  all_goals first | rfl | (obtain ⟨q, hq, -⟩ := Option.map_eq_some_iff.mp h; exact hr q hq)

/-- 完了した main に main 自身の歩が無いなら、famMain も歩かない -/
theorem famMain_done {id : List Nat} {o n : Nat} {m : State} {ks : Kids} {K : ChanSt}
    (h : (taskDone m).isSome) : famMain id o n m ks K none = none := by
  unfold famMain
  split
  all_goals first | rfl | simp [taskDone] at h

/-- 死んだ main（panic）に main 自身の歩は無く、famMain も歩かない -/
theorem famMain_panic {id : List Nat} {o n : Nat} {H : Heap} {ks : Kids} {K : ChanSt} :
    famMain id o n (.panic H) ks K none = none := by
  unfold famMain
  split
  all_goals first | rfl | simp_all

mutual
/-- 1 歩踏める状態は完了形でない（task は main か子のどれかが未完了） -/
theorem taskDone_none_of_step : ∀ {π : List Bool} {s s' : State} {K K' : ChanSt},
    step Δ π s K = some (s', K') → taskDone s = none
  | _, .eval _ _ _, _, _, _, _ => rfl
  | _, .par _ _ _ _, _, _, _, _ => rfl
  | _, .panic _, _, _, _, _ => rfl
  | _, .ret _ [] _, _, _, _, h => by simp [step] at h
  | _, .ret _ [.taskK] _, _, _, _, h => by simp [step] at h
  | _, .ret _ (f :: f' :: _) _, _, _, _, _ => by cases f <;> rfl
  | _, .ret _ [f] _, _, _, _, h => by cases f <;> first | rfl | simp [step] at h
  | π, .fam id o n m ks, s', K, K', h => by
    rw [step_fam_def] at h
    simp only [taskDone]
    split
    · rename_i hkd
      cases π with
      | cons c π' =>
        cases c with
        | false =>
          cases hsk : stepKids Δ π' ks K with
          | none => simp [hsk] at h
          | some p =>
            obtain ⟨ks', K₁⟩ := p
            have := kidsDone_false_of_stepKids hsk
            rw [this] at hkd; cases hkd
        | true => exact taskDone_none_of_famMain h (fun p hp => taskDone_none_of_step (s := m) hp)
      | nil => exact taskDone_none_of_famMain h (fun p hp => taskDone_none_of_step (s := m) hp)
    · rfl

theorem kidsDone_false_of_stepKids : ∀ {π : List Bool} {ks ks' : Kids} {K K' : ChanSt},
    stepKids Δ π ks K = some (ks', K') → kidsDone ks = false
  | _, .nil, _, _, _, h => by simp [stepKids] at h
  | π, .cons rs κ s r, ks', K, K', h => by
    cases π with
    | nil => simp [stepKids] at h
    | cons c π' =>
      cases c with
      | true =>
        simp only [stepKids] at h
        cases hs : step Δ π' s K with
        | none => simp [hs] at h
        | some p =>
          obtain ⟨s', K₁⟩ := p
          simp [kidsDone, taskDone_none_of_step hs, deadDone_false_of_step hs]
      | false =>
        simp only [stepKids] at h
        cases hs : stepKids Δ π' r K with
        | none => simp [hs] at h
        | some p =>
          obtain ⟨r', K₁⟩ := p
          simp [kidsDone, kidsDone_false_of_stepKids hs]

/-- 1 歩踏める状態は死んで静止していない（死んだ task の子孫は走り切る — 静止は子孫の決着まで） -/
theorem deadDone_false_of_step : ∀ {π : List Bool} {s s' : State} {K K' : ChanSt},
    step Δ π s K = some (s', K') → deadDone s = false
  | _, .eval _ _ _, _, _, _, _ => rfl
  | _, .par _ _ _ _, _, _, _, _ => rfl
  | _, .panic _, _, _, _, h => by simp [step] at h
  | _, .ret _ _ _, _, _, _, _ => rfl
  | π, .fam id o n m ks, s', K, K', h => by
    cases m with
    | panic H =>
      simp only [deadDone]
      rw [step_fam_def] at h
      cases π with
      | cons c π' =>
        cases c with
        | false =>
          cases hsk : stepKids Δ π' ks K with
          | none => simp [hsk] at h
          | some p => exact kidsDone_false_of_stepKids hsk
        | true => simp [step, famMain_panic] at h
      | nil => simp [step, famMain_panic] at h
    | _ => rfl
end

mutual
/-- 完了形はもう進めない（task は main も子も全部完了） -/
theorem step_done_none : ∀ {s : State}, (taskDone s).isSome → ∀ (π : List Bool) (K : ChanSt), step Δ π s K = none
  | .ret _ [] _, _, _, _ => by simp [step]
  | .ret _ [.taskK] _, _, _, _ => by simp [step]
  | .ret _ (f :: _ :: _) _, h, _, _ => by cases f <;> simp [taskDone] at h
  | .ret _ [f] _, h, _, _ => by cases f <;> first | (simp [taskDone] at h; done) | simp [step]
  | .eval _ _ _, h, _, _ => by simp [taskDone] at h
  | .par _ _ _ _, h, _, _ => by simp [taskDone] at h
  | .panic _, h, _, _ => by simp [taskDone] at h
  | .fam id o n m ks, h, π, K => by
    simp only [taskDone] at h
    split at h
    · rename_i hkd
      rw [step_fam_def]
      cases π with
      | cons c π' =>
        cases c with
        | false => simp [stepKids_done_none hkd π' K]
        | true => simp only [List.tail]; rw [step_done_none (s := m) h]; exact famMain_done h
      | nil => simp only [List.tail]; rw [step_done_none (s := m) h]; exact famMain_done h
    · simp at h

theorem stepKids_done_none : ∀ {ks : Kids}, kidsDone ks = true → ∀ (π : List Bool) (K : ChanSt), stepKids Δ π ks K = none
  | .nil, _, _, _ => by simp [stepKids]
  | .cons rs κ s r, h, π, K => by
    simp only [kidsDone, Bool.and_eq_true] at h
    cases π with
    | nil => simp [stepKids]
    | cons c π' =>
      cases c with
      | true =>
        rcases Bool.or_eq_true _ _ ▸ h.1 with h1 | h1
        · simp [stepKids, step_done_none (s := s) h1 π' K]
        · simp [stepKids, step_deadDone_none (s := s) h1 π' K]
      | false => simp [stepKids, stepKids_done_none (ks := r) h.2 π' K]

/-- 死んで静止した状態はもう進めない -/
theorem step_deadDone_none : ∀ {s : State}, deadDone s = true → ∀ (π : List Bool) (K : ChanSt), step Δ π s K = none
  | .panic _, _, _, _ => by simp [step]
  | .eval _ _ _, h, _, _ => by simp [deadDone] at h
  | .par _ _ _ _, h, _, _ => by simp [deadDone] at h
  | .ret _ _ _, h, _, _ => by simp [deadDone] at h
  | .fam id o n m ks, h, π, K => by
    cases m with
    | panic H =>
      simp only [deadDone] at h
      rw [step_fam_def]
      cases π with
      | cons c π' =>
        cases c with
        | false => simp [stepKids_done_none h π' K]
        | true => simp [step, famMain_panic]
      | nil => simp [step, famMain_panic]
    | _ => simp [deadDone] at h
end

end FS
