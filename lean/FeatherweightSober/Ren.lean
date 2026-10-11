import FeatherweightSober.Shift
import FeatherweightSober.Checker

/-!
# region の写像定理（R2 = region 多相の裁定の anchor の下準備）

Def の本体は base の世界で一度だけ型付けされ、region 0 は「圧縮された呼び手空間」— 暗黙の region 変数 —
である。現行の call はこれを常に呼び手最内 d で instantiate する（一様シフト shiftR d）。anchor 案は
region 0 の行き先 ρ0 を呼び手が選べるようにする（b ≤ ρ0 ≤ d）: 写像 `rmap ρ0 δ` は

  0 ↦ ρ0、k + 1 ↦ k + 1 + δ

で、ρ0 = δ のとき一様シフトと一致する（保存拡大 — `rmap_top` / `Ty.renR_top`）。
本定理（`ren_typing`）は shift_typing の一般化: 空ストア・空チャネル環境で型付くソース項は、
世界（f / b / d / Γ / Λ / 型 / 項注釈）を rmap で写しても型付く。

- 深さは 2 以上（Def の本体の世界。block は深くなる向きにしか動かない）— 深さの写像は +δ で、
  割り当ては region ≥ 1 に落ちるので anchor に触れない
- 写像は狭義単調（ρ0 ≤ δ < 1 + δ）なので、escape 検査・共有境界・書き込み床の比較がそのまま運べる
- ソース項に限る（`Expr.src`）: 実行時項（loc / slicev / mapv / chanV）は Def の本体に現れない。
  空ストアでも空 slice ヘッダには型が付くので、シフト定理のように再構築せず前提で外す
- 入れ子の call は、深さ d' ≥ 1 のシフト / relocR が写像と合成して d' + δ のそれになる
  （`Ty.shiftR_renR` / `Ty.relocR_renR`）— 本体の中の call は従来の一様シフトの規則のまま閉じる
-/
namespace FS

theorem rmap_top (δ r : Nat) : rmap δ δ r = r + δ := by cases r <;> simp [rmap]

theorem rmap_pos {ρ0 δ k : Nat} (hk : 1 ≤ k) : rmap ρ0 δ k = k + δ := by
  obtain ⟨j, rfl⟩ : ∃ j, k = j + 1 := ⟨k - 1, by omega⟩
  simp [rmap]

theorem rmap_lt {ρ0 δ r n : Nat} (h0 : ρ0 ≤ δ) (h : r < n) : rmap ρ0 δ r < rmap ρ0 δ n := by
  cases r <;> cases n <;> simp [rmap] at * <;> omega

theorem rmap_le {ρ0 δ r n : Nat} (h0 : ρ0 ≤ δ) (h : r ≤ n) : rmap ρ0 δ r ≤ rmap ρ0 δ n := by
  cases r <;> cases n <;> simp [rmap] at * <;> omega

/-- 保存拡大: anchor = δ（呼び手最内）なら一様シフト -/
theorem Ty.renR_top (δ : Nat) : ∀ t : Ty, t.renR δ δ = t.shiftR δ
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t]
  | .union l r => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ l, Ty.renR_top δ r]
  | .prod l r => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ l, Ty.renR_top δ r]
  | .ref m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t, rmap_top]
  | .slice m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t, rmap_top]
  | .map m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t, rmap_top]
  | .chan rc t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t, rmap_top]
  | .own k r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_top δ t, rmap_top]
  | .fn p r => rfl

/-- 深さ ρ ≥ 1 のシフトは写像と合成して ρ + δ のシフトになる（本体の中の call の instantiate） -/
theorem Ty.shiftR_renR {ρ0 δ ρ : Nat} (hρ : 1 ≤ ρ) : ∀ t : Ty, (t.shiftR ρ).renR ρ0 δ = t.shiftR (ρ + δ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.shiftR, Ty.shiftR_renR hρ t]
  | .union l r => by simp [Ty.renR, Ty.shiftR, Ty.shiftR_renR hρ l, Ty.shiftR_renR hρ r]
  | .prod l r => by simp [Ty.renR, Ty.shiftR, Ty.shiftR_renR hρ l, Ty.shiftR_renR hρ r]
  | .ref m r t => by
    simp only [Ty.shiftR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .slice m r t => by
    simp only [Ty.shiftR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .map m r t => by
    simp only [Ty.shiftR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .chan rc t => by
    simp only [Ty.shiftR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ rc + ρ by omega)]; congr 1; omega
  | .own k r t => by
    simp only [Ty.shiftR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .fn p r => rfl

/-- imm で chan を持たない型の relocR（全部の imm の region を k へ — task の結果の型）は renR と可換（P3b-4） -/
theorem Ty.renR_relocR_mf {ρ0 δ k : Nat} : ∀ {t : Ty}, t.mutFree = true → t.chanFree = true →
    (t.relocR k).renR ρ0 δ = (t.renR ρ0 δ).relocR (rmap ρ0 δ k)
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm hc]
  | .union l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm.1 hc.1, Ty.renR_relocR_mf hm.2 hc.2]
  | .prod l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm.1 hc.1, Ty.renR_relocR_mf hm.2 hc.2]
  | .ref false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm hc]
  | .slice false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm hc]
  | .map false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.renR_relocR_mf hm hc]
  | .ref true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .slice true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .map true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .chan _ _, _, hc => by simp [Ty.chanFree] at hc
  | .own _ _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .fn _ _, _, _ => rfl

/-- imm で chan を持たない型は、renR の後に relocR k で締めると renR の前に締めたのと同じ（imm の region は全部 k へ — P3b-4b） -/
theorem Ty.relocR_renR_left {ρ0 δ k : Nat} : ∀ {t : Ty}, t.mutFree = true → t.chanFree = true →
    (t.renR ρ0 δ).relocR k = t.relocR k
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm hc]
  | .union l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm.1 hc.1, Ty.relocR_renR_left hm.2 hc.2]
  | .prod l r, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm.1 hc.1, Ty.relocR_renR_left hm.2 hc.2]
  | .ref false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm hc]
  | .slice false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm hc]
  | .map false r t, hm, hc => by
    simp only [Ty.mutFree, Ty.chanFree, Bool.not_false, Bool.true_and] at hm hc
    simp [Ty.relocR, Ty.renR, Ty.relocR_renR_left hm hc]
  | .ref true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .slice true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .map true _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .chan _ _, _, hc => by simp [Ty.chanFree] at hc
  | .own _ _ _, hm, _ => by simp [Ty.mutFree] at hm
  | .fn _ _, _, _ => rfl

/-- relocR（深さ ρ ≥ 1 の call 結果）も同じく合成する -/
theorem Ty.relocR_renR {ρ0 δ ρ : Nat} (hρ : 1 ≤ ρ) : ∀ t : Ty, (t.relocR ρ).renR ρ0 δ = t.relocR (ρ + δ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ t]
  | .union l r => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ l, Ty.relocR_renR hρ r]
  | .prod l r => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ l, Ty.relocR_renR hρ r]
  | .ref false r t => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ t, rmap_pos hρ]
  | .slice false r t => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ t, rmap_pos hρ]
  | .map false r t => by simp [Ty.relocR, Ty.renR, Ty.relocR_renR hρ t, rmap_pos hρ]
  | .ref true r t => by
    simp only [Ty.relocR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .slice true r t => by
    simp only [Ty.relocR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .map true r t => by
    simp only [Ty.relocR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .chan rc t => by
    simp only [Ty.relocR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ rc + ρ by omega)]; congr 1; omega
  | .own k r t => by
    simp only [Ty.relocR, Ty.renR, Ty.shiftR_renR hρ t, rmap_pos (show 1 ≤ r + ρ by omega)]; congr 1; omega
  | .fn p r => rfl

/-- 境界コピー式の結果型の上界の写像（M3）: chan を持たない t が region k 以下なら、写した型は rmap k 以下
（renR_regionsBelow は n = k + 1 を rmap (k + 1) へ写すだけで、k = 0 が anchor ρ0 へ写る場合に足りない — 単調性から直接） -/
theorem Ty.renR_regionsBelow_succ {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {t : Ty} {k : Nat}, t.chanFree = true → t.regionsBelow (k + 1) = true →
      (t.renR ρ0 δ).regionsBelow (rmap ρ0 δ k + 1) = true
  | .int, _, _, _ => rfl
  | .tvar _, _, _, _ => rfl
  | .bool, _, _, _ => rfl
  | .byte, _, _, _ => rfl
  | .f64, _, _, _ => rfl
  | .unit, _, _, _ => rfl
  | .opt t, _, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree] at h hc
    simp only [Ty.renR, Ty.regionsBelow]
    exact Ty.renR_regionsBelow_succ h0 hc h
  | .union l r, _, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h hc
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow_succ h0 hc.1 h.1, Ty.renR_regionsBelow_succ h0 hc.2 h.2⟩
  | .prod l r, _, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h hc
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow_succ h0 hc.1 h.1, Ty.renR_regionsBelow_succ h0 hc.2 h.2⟩
  | .ref m r t, k, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true, decide_eq_true_eq] at h hc
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨Nat.lt_succ_of_le (rmap_le h0 (Nat.le_of_lt_succ h.1)), Ty.renR_regionsBelow_succ h0 hc h.2⟩
  | .slice m r t, k, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true, decide_eq_true_eq] at h hc
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨Nat.lt_succ_of_le (rmap_le h0 (Nat.le_of_lt_succ h.1)), Ty.renR_regionsBelow_succ h0 hc h.2⟩
  | .map m r t, k, hc, h => by
    simp only [Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true, decide_eq_true_eq] at h hc
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨Nat.lt_succ_of_le (rmap_le h0 (Nat.le_of_lt_succ h.1)), Ty.renR_regionsBelow_succ h0 hc h.2⟩
  | .chan _ _, _, hc, _ => by simp [Ty.chanFree] at hc
  | .fn _ _, _, _, _ => rfl

/-- escape 検査の保存（狭義単調性だけから） -/
theorem Ty.renR_regionsBelow {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {t : Ty} {n : Nat}, t.regionsBelow n = true → (t.renR ρ0 δ).regionsBelow (rmap ρ0 δ n) = true
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, _, h => by
    simp only [Ty.regionsBelow] at h
    simp only [Ty.renR, Ty.regionsBelow]
    exact Ty.renR_regionsBelow h0 h
  | .union l r, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .prod l r, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .ref m r t, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_lt h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .slice m r t, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_lt h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .map m r t, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_lt h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .chan rc t, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_le h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .own k r t, _, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_lt h0 h.1, Ty.renR_regionsBelow h0 h.2⟩
  | .fn _ _, _, _ => rfl

theorem Ty.renR_mutFree {ρ0 δ : Nat} : ∀ t : Ty, (t.renR ρ0 δ).mutFree = t.mutFree
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree t]
  | .union l r => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree l, Ty.renR_mutFree r]
  | .prod l r => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree l, Ty.renR_mutFree r]
  | .ref m r t => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree t]
  | .slice m r t => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree t]
  | .map m r t => by simp [Ty.renR, Ty.mutFree, Ty.renR_mutFree t]
  | .chan rc t => rfl
  | .own k r t => rfl
  | .fn p r => rfl

theorem Ty.keyOk_renR (ρ0 δ : Nat) {k : Ty} (h : k.keyOk = true) : (k.renR ρ0 δ).keyOk = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.renR, Ty.keyOk]

theorem Ty.keyCompat_renR (ρ0 δ : Nat) {a b : Ty} (h : a.keyCompat b = true) :
    (a.renR ρ0 δ).keyCompat (b.renR ρ0 δ) = true := by
  unfold Ty.keyCompat at h
  split at h <;> simp_all [Ty.renR, Ty.keyCompat]

/-- 部分型（imm 上界の緩め）の保存（単調性から） -/
theorem Ty.annFree_renR {ρ0 δ : Nat} : ∀ t : Ty, (t.renR ρ0 δ).annFree = t.annFree
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt _ => rfl
  | .union _ _ => rfl
  | .prod l r => by simp [Ty.renR, Ty.annFree, Ty.annFree_renR l, Ty.annFree_renR r]
  | .ref _ _ _ => rfl
  | .slice m r t => by simp [Ty.renR, Ty.annFree, Ty.annFree_renR t]
  | .map m r t => by simp [Ty.renR, Ty.annFree, Ty.annFree_renR t]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl

theorem Ty.sub_renR {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {ta tb : Ty}, Ty.sub ta tb = true → Ty.sub (ta.renR ρ0 δ) (tb.renR ρ0 δ) = true
  | .opt t, .opt t', hs => by
    simp only [Ty.sub] at hs
    simp only [Ty.renR, Ty.sub]
    exact Ty.sub_renR h0 hs
  | .union l r, .union l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.renR, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_renR h0 hs.1, Ty.sub_renR h0 hs.2⟩
  | .prod l r, .prod l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.renR, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_renR h0 hs.1, Ty.sub_renR h0 hs.2⟩
  | .ref false r t, .ref false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    obtain ⟨hle, rfl⟩ := hs
    simp only [Ty.renR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_le h0 hle, trivial⟩
  | .slice false r t, .slice false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.renR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_le h0 hs.1, Ty.sub_renR h0 hs.2⟩
  | .map false r t, .map false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.renR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨rmap_le h0 hs.1, Ty.sub_renR h0 hs.2⟩
  | .int, tb, hs => by
    obtain rfl := Ty.sub_int_inv hs
    exact Ty.sub_refl _
  | .tvar i, tb, hs => by
    obtain rfl := Ty.sub_tvar_inv hs
    exact Ty.sub_refl _
  | .bool, tb, hs => by
    obtain rfl := Ty.sub_bool_inv hs
    exact Ty.sub_refl _
  | .byte, tb, hs => by
    obtain rfl := Ty.sub_byte_inv hs
    exact Ty.sub_refl _
  | .f64, tb, hs => by
    obtain rfl := Ty.sub_f64_inv hs
    exact Ty.sub_refl _
  | .unit, tb, hs => by
    obtain rfl := Ty.sub_unit_inv hs
    exact Ty.sub_refl _
  | .chan rc t, tb, hs => by
    obtain rfl := Ty.sub_chan_inv hs
    exact Ty.sub_refl _
  | .own k r t, tb, hs => by
    obtain rfl := Ty.sub_own_inv hs
    exact Ty.sub_refl _
  | .fn p r, tb, hs => by
    obtain rfl := Ty.sub_fn_inv hs
    exact Ty.sub_refl _
  | .ref true r t, tb, hs => by
    obtain rfl := Ty.sub_refT_inv hs
    exact Ty.sub_refl _
  | .slice true r t, tb, hs => by
    obtain rfl := Ty.sub_sliceT_inv hs
    exact Ty.sub_refl _
  | .map true r t, tb, hs => by
    obtain rfl := Ty.sub_mapT_inv hs
    exact Ty.sub_refl _
  | .opt t, .int, hs => by simp [Ty.sub] at hs
  | .union l r, .int, hs => by simp [Ty.sub] at hs
  | .prod l r, .int, hs => by simp [Ty.sub] at hs

theorem Ty.mutTop_renR (ρ0 δ : Nat) : ∀ ta : Ty, (ta.renR ρ0 δ).mutTop = ta.mutTop.map (rmap ρ0 δ)
  | .ref m r _ => by cases m <;> simp [Ty.mutTop, Ty.renR]
  | .slice m r _ => by cases m <;> simp [Ty.mutTop, Ty.renR]
  | .map m r _ => by cases m <;> simp [Ty.mutTop, Ty.renR]
  | .int | .tvar _ | .bool | .byte | .f64 | .unit | .opt _ | .union _ _ | .prod _ _ | .chan _ _ | .fn _ _ | .own _ _ _ => by
    simp [Ty.mutTop, Ty.renR]

theorem Ty.anchorOf_renR (ρ0 δ : Nat) :
    ∀ (p ta : Ty), Ty.anchorOf p (ta.renR ρ0 δ) = (Ty.anchorOf p ta).map (rmap ρ0 δ) := by
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro ta
    cases ta <;> simp only [Ty.anchorOf, Ty.renR, Option.map_none]
    rename_i l' r'
    rw [ihl, ihr]
    cases Ty.anchorOf l l' <;> simp
  | _ =>
    intro ta
    simp only [Ty.anchorOf]
    split <;> simp [Ty.mutTop_renR]

/-- 入れ子の anchor つき call の写像の合成（本体の深さ d' ≥ 1） -/
theorem rmap_comp {ρ0 δ a d' : Nat} (hd' : 1 ≤ d') (r : Nat) :
    rmap ρ0 δ (rmap a d' r) = rmap (rmap ρ0 δ a) (d' + δ) r := by
  cases r with
  | zero => simp [rmap]
  | succ k =>
    show rmap ρ0 δ (k + 1 + d') = k + 1 + (d' + δ)
    rw [rmap_pos (by omega)]; omega

theorem Ty.renR_renR {ρ0 δ a d' : Nat} (hd' : 1 ≤ d') :
    ∀ t : Ty, (t.renR a d').renR ρ0 δ = t.renR (rmap ρ0 δ a) (d' + δ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.renR_renR hd' t]
  | .union l r => by simp [Ty.renR, Ty.renR_renR hd' l, Ty.renR_renR hd' r]
  | .prod l r => by simp [Ty.renR, Ty.renR_renR hd' l, Ty.renR_renR hd' r]
  | .ref m r t => by simp [Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .slice m r t => by simp [Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .map m r t => by simp [Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .chan rc t => by simp [Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .own k r t => by simp [Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .fn p r => rfl

theorem Ty.relocA_renR {ρ0 δ a d' : Nat} (hd' : 1 ≤ d') :
    ∀ t : Ty, (t.relocA a d').renR ρ0 δ = t.relocA (rmap ρ0 δ a) (d' + δ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.relocA, Ty.renR, Ty.relocA_renR hd' t]
  | .union l r => by simp [Ty.relocA, Ty.renR, Ty.relocA_renR hd' l, Ty.relocA_renR hd' r]
  | .prod l r => by simp [Ty.relocA, Ty.renR, Ty.relocA_renR hd' l, Ty.relocA_renR hd' r]
  | .ref false r t => by
    simp only [Ty.relocA, Ty.renR, Ty.relocA_renR hd' t]; split <;> simp [rmap_pos hd']
  | .slice false r t => by
    simp only [Ty.relocA, Ty.renR, Ty.relocA_renR hd' t]; split <;> simp [rmap_pos hd']
  | .map false r t => by
    simp only [Ty.relocA, Ty.renR, Ty.relocA_renR hd' t]; split <;> simp [rmap_pos hd']
  | .ref true r t => by simp [Ty.relocA, Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .slice true r t => by simp [Ty.relocA, Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .map true r t => by simp [Ty.relocA, Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .chan rc t => by simp [Ty.relocA, Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .own k r t => by simp [Ty.relocA, Ty.renR, Ty.renR_renR hd' t, rmap_comp hd']
  | .fn p r => rfl

/-! ## R4a（深い relocate）の型の補題 -/

/-- 写像は狭義単調なので regionsBelow を反射する（写した型の床から元の型の床へ） -/
theorem rmap_lt_iff {ρ0 δ r n : Nat} (h0 : ρ0 ≤ δ) : rmap ρ0 δ r < rmap ρ0 δ n ↔ r < n := by
  cases r <;> cases n <;> simp [rmap] <;> omega

theorem rmap_le_iff {ρ0 δ r n : Nat} (h0 : ρ0 ≤ δ) : rmap ρ0 δ r ≤ rmap ρ0 δ n ↔ r ≤ n := by
  cases r <;> cases n <;> simp [rmap] <;> omega

theorem Ty.renR_regionsBelow_refl {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {t : Ty} {n : Nat}, (t.renR ρ0 δ).regionsBelow (rmap ρ0 δ n) = true → t.regionsBelow n = true
  | .int, _, _ => rfl
  | .tvar _, _, _ => rfl
  | .bool, _, _ => rfl
  | .byte, _, _ => rfl
  | .f64, _, _ => rfl
  | .unit, _, _ => rfl
  | .opt t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow] at h
    simp only [Ty.regionsBelow]
    exact Ty.renR_regionsBelow_refl h0 h
  | .union l r, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow_refl h0 h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .prod l r, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.renR_regionsBelow_refl h0 h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .ref m r t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨(rmap_lt_iff h0).mp h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .slice m r t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨(rmap_lt_iff h0).mp h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .map m r t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨(rmap_lt_iff h0).mp h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .chan rc t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨(rmap_le_iff h0).mp h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .own k r t, _, h => by
    simp only [Ty.renR, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨(rmap_lt_iff h0).mp h.1, Ty.renR_regionsBelow_refl h0 h.2⟩
  | .fn _ _, _, _ => rfl

/-- 中身が region 0（呼び手空間）だけなら、深い締めは写像そのもの（フレーム外のコンテナの中身の型） -/
theorem Ty.relocA_of_below1 {ρ0 δ : Nat} : ∀ {t : Ty}, t.regionsBelow 1 = true → t.relocA ρ0 δ = t.renR ρ0 δ
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.regionsBelow] at h
    simp [Ty.relocA, Ty.renR, Ty.relocA_of_below1 h]
  | .union l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.relocA, Ty.renR, Ty.relocA_of_below1 h.1, Ty.relocA_of_below1 h.2]
  | .prod l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.relocA, Ty.renR, Ty.relocA_of_below1 h.1, Ty.relocA_of_below1 h.2]
  | .ref m r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨hr, ht⟩ := h
    have : r = 0 := by omega
    subst this
    cases m <;> simp [Ty.relocA, Ty.renR, rmap, Ty.relocA_of_below1 ht]
  | .slice m r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨hr, ht⟩ := h
    have : r = 0 := by omega
    subst this
    cases m <;> simp [Ty.relocA, Ty.renR, rmap, Ty.relocA_of_below1 ht]
  | .map m r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h
    obtain ⟨hr, ht⟩ := h
    have : r = 0 := by omega
    subst this
    cases m <;> simp [Ty.relocA, Ty.renR, rmap, Ty.relocA_of_below1 ht]
  | .chan rc t, _ => rfl
  | .own k r t, _ => rfl
  | .fn _ _, _ => rfl

/-- retOk な型の深い締めは呼び手空間（region ≤ d）に収まる -/
theorem Ty.relocA_regionsBelow {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {t : Ty}, t.retOk = true → (t.relocA ρ0 δ).regionsBelow (δ + 1) = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.retOk] at h
    simp only [Ty.relocA, Ty.regionsBelow]
    exact Ty.relocA_regionsBelow h0 h
  | .union l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp only [Ty.relocA, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.relocA_regionsBelow h0 h.1, Ty.relocA_regionsBelow h0 h.2⟩
  | .prod l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp only [Ty.relocA, Ty.regionsBelow, Bool.and_eq_true]
    exact ⟨Ty.relocA_regionsBelow h0 h.1, Ty.relocA_regionsBelow h0 h.2⟩
  | .ref m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
      exact ⟨by split <;> omega, Ty.relocA_regionsBelow h0 h.2⟩
  | .slice m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
      exact ⟨by split <;> omega, Ty.relocA_regionsBelow h0 h.2⟩
  | .map m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq]
      exact ⟨by split <;> omega, Ty.relocA_regionsBelow h0 h.2⟩
  | .chan _ _, h => by simp [Ty.retOk] at h
  | .fn _ _, _ => rfl

theorem Ty.relocA_mutFree {ρ0 δ : Nat} : ∀ {t : Ty}, t.retOk = true → (t.relocA ρ0 δ).mutFree = true
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.retOk] at h
    simp only [Ty.relocA, Ty.mutFree]
    exact Ty.relocA_mutFree h
  | .union l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp only [Ty.relocA, Ty.mutFree, Bool.and_eq_true]
    exact ⟨Ty.relocA_mutFree h.1, Ty.relocA_mutFree h.2⟩
  | .prod l r, h => by
    simp only [Ty.retOk, Bool.and_eq_true] at h
    simp only [Ty.relocA, Ty.mutFree, Bool.and_eq_true]
    exact ⟨Ty.relocA_mutFree h.1, Ty.relocA_mutFree h.2⟩
  | .ref m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.mutFree, Bool.not_false, Bool.true_and]
      exact Ty.relocA_mutFree h.2
  | .slice m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.mutFree, Bool.not_false, Bool.true_and]
      exact Ty.relocA_mutFree h.2
  | .map m r t, h => by
    cases m with
    | true => simp [Ty.retOk] at h
    | false =>
      simp only [Ty.retOk, Bool.and_eq_true] at h
      simp only [Ty.relocA, Ty.mutFree, Bool.not_false, Bool.true_and]
      exact Ty.relocA_mutFree h.2
  | .chan _ _, h => by simp [Ty.retOk] at h
  | .fn _ _, _ => rfl

/-! ## R4b（脱出の境界コピー）: 締めと写像の交換 -/

theorem rmap_min {ρ0 δ r k : Nat} (h0 : ρ0 ≤ δ) : min (rmap ρ0 δ r) (rmap ρ0 δ k) = rmap ρ0 δ (min r k) := by
  rcases Nat.le_total r k with h | h
  · rw [Nat.min_eq_left h, Nat.min_eq_left (rmap_le h0 h)]
  · rw [Nat.min_eq_right h, Nat.min_eq_right (rmap_le h0 h)]

theorem Ty.clampR_renR {ρ0 δ k : Nat} (h0 : ρ0 ≤ δ) :
    ∀ t : Ty, (t.renR ρ0 δ).clampR (rmap ρ0 δ k) = (t.clampR k).renR ρ0 δ
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 t]
  | .union l r => by simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 l, Ty.clampR_renR h0 r]
  | .prod l r => by simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 l, Ty.clampR_renR h0 r]
  | .ref m r t => by cases m <;> simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 t, rmap_min h0]
  | .slice m r t => by cases m <;> simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 t, rmap_min h0]
  | .map m r t => by cases m <;> simp [Ty.renR, Ty.clampR, Ty.clampR_renR h0 t, rmap_min h0]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl

theorem Ty.noClamp_renR {ρ0 δ k : Nat} (h0 : ρ0 ≤ δ) :
    ∀ t : Ty, (t.renR ρ0 δ).noClamp (rmap ρ0 δ k) = t.noClamp k
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 t]
  | .union l r => by simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 l, Ty.noClamp_renR h0 r]
  | .prod l r => by simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 l, Ty.noClamp_renR h0 r]
  | .ref m r t => by cases m <;> simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 t, rmap_le_iff h0]
  | .slice m r t => by cases m <;> simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 t, rmap_le_iff h0]
  | .map m r t => by cases m <;> simp [Ty.renR, Ty.noClamp, Ty.noClamp_renR h0 t, rmap_le_iff h0]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl

theorem Ty.chanFree_renR {ρ0 δ : Nat} : ∀ t : Ty, (t.renR ρ0 δ).chanFree = t.chanFree
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR t]
  | .union l r => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR l, Ty.chanFree_renR r]
  | .prod l r => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR l, Ty.chanFree_renR r]
  | .ref m r t => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR t]
  | .slice m r t => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR t]
  | .map m r t => by simp [Ty.renR, Ty.chanFree, Ty.chanFree_renR t]
  | .chan _ _ => rfl
  | .own _ _ _ => rfl
  | .fn _ _ => rfl


theorem Ty.payOk_renR {ρ0 δ : Nat} {te t : Ty} (h : Ty.payOk te t = true) :
    Ty.payOk (te.renR ρ0 δ) (t.renR ρ0 δ) = true := by
  simp only [Ty.payOk, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
  obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := h
  refine ⟨⟨⟨⟨by rw [Ty.renR_mutFree]; exact h1, by rw [Ty.chanFree_renR]; exact h2⟩,
    by rw [Ty.renR_mutFree]; exact h3⟩, by rw [Ty.chanFree_renR]; exact h4⟩, ?_⟩
  rw [Ty.relocR_renR_left h1 h2, Ty.relocR_renR_left h3 h4, h5]

theorem Ty.jumpRel_renR {ρ0 δ b k : Nat} (h0 : ρ0 ≤ δ) {tJ tL : Ty} (h : Ty.jumpRel b k tJ tL = true) :
    Ty.jumpRel (rmap ρ0 δ b) (rmap ρ0 δ k) (tJ.renR ρ0 δ) (tL.renR ρ0 δ) = true := by
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h ⊢
  refine ⟨?_, ?_⟩
  · rw [Ty.clampR_renR h0]; exact Ty.sub_renR h0 h.1
  · rw [Ty.noClamp_renR h0, Ty.chanFree_renR]
    exact h.2.elim .inl (fun h2 => .inr ⟨rmap_le h0 h2.1, h2.2⟩)

theorem Ty.readAs_renR {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) {m : Bool} {ot : Option Ty} {t' t : Ty}
    (h : Ty.readAs m ot t' = some t) :
    Ty.readAs m (ot.map (Ty.renR ρ0 δ)) (t'.renR ρ0 δ) = some (t.renR ρ0 δ) := by
  cases ot with
  | none =>
    simp only [Ty.readAs] at h ⊢
    split at h <;> cases h
    rename_i hc
    simp [Ty.annFree_renR, hc]
  | some ta =>
    simp only [Ty.readAs] at h ⊢
    split at h <;> cases h
    rename_i hc
    simp [Ty.sub_renR h0 hc]

namespace Expr

/-- 保存拡大（項）: anchor = δ の写像は一様シフトと同じ項を作る -/
theorem renTy_top (δ : Nat) : ∀ e : Expr, e.renTy δ δ = e.shiftTy δ := by
  intro e
  have hf : Ty.renR δ δ = Ty.shiftR δ := funext (Ty.renR_top δ)
  induction e <;> simp_all [renTy, shiftTy, Ty.renR_top, rmap_top]

end Expr

/-! 段 6 P1: 引き渡し（give:）の型と region の写像 -/

theorem Ty.givable_renR {ρ0 δ rs : Nat} (h0 : ρ0 ≤ δ) :
    ∀ {t : Ty}, t.givable rs = true → (t.renR ρ0 δ).givable (rmap ρ0 δ rs) = true := by
  intro t ht
  induction t with
  | prod l r ihl ihr =>
    simp only [Ty.givable, Bool.and_eq_true] at ht
    simp [Ty.renR, Ty.givable, ihl ht.1, ihr ht.2]
  | own k r u _ =>
    cases k with
    | scope => simp [Ty.givable, Ty.mutFree] at ht
    | task => simp [Ty.givable, Ty.mutFree] at ht
    | tx =>
      simp only [Ty.givable, Bool.and_eq_true] at ht
      simp only [Ty.renR, Ty.givable, Bool.and_eq_true]
      rw [Ty.renR_mutFree, Ty.chanFree_renR]; exact ht
    | rx =>
      simp only [Ty.givable, Bool.and_eq_true] at ht
      simp only [Ty.renR, Ty.givable, Bool.and_eq_true]
      rw [Ty.renR_mutFree, Ty.chanFree_renR]; exact ht
  | _ =>
    rw [Ty.givable_eq_data (by intros; simp) (by intros; simp)] at ht
    rw [Ty.givable_eq_data (by intros; simp [Ty.renR]) (by intros; simp [Ty.renR])]
    simp only [Bool.and_eq_true] at ht ⊢
    exact ⟨⟨by rw [Ty.renR_mutFree]; exact ht.1.1, by rw [Ty.chanFree_renR]; exact ht.1.2⟩,
      Ty.renR_regionsBelow_succ h0 ht.1.2 ht.2⟩

theorem Ty.rehome_renR {ρ0 δ d : Nat} :
    ∀ t : Ty, (t.rehome d).renR ρ0 δ = (t.renR ρ0 δ).rehome (rmap ρ0 δ d) := by
  intro t
  induction t with
  | prod l r ihl ihr => simp [Ty.renR, Ty.rehome, ihl, ihr]
  | own k r t _ => cases k <;> rfl
  | _ => rfl

namespace HasType

/-- 写像定理: 深さ 2 以上の世界で型付くソース項は、region 0 を ρ0（≤ δ）へ・それ以外を +δ へ写した世界でも
型付く。ρ0 = δ の特殊形がシフト定理（深さ 2 以上の部分） -/
theorem ren_typing {ρ0 δ : Nat} (h0 : ρ0 ≤ δ) {e : Expr} {Δ : Defs} {f b d : Nat} {Γ : Ctx} {t : Ty}
    (he : HasType Δ ∅ [] f b d Γ Λ e t) (hd : 2 ≤ d) (hs : e.src = true) :
    HasType Δ ∅ [] (rmap ρ0 δ f) (rmap ρ0 δ b) (d + δ) (Γ.map (Ty.renR ρ0 δ)) (Λ.map (fun p => (p.1.renR ρ0 δ, rmap ρ0 δ p.2)))
      (e.renTy ρ0 δ) (t.renR ρ0 δ) := by
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
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | letE h1 h2 => exact .letE (ihe h1 hd hs.1) (ihb h2 hd hs.2)
  | add a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | add h1 h2 => exact .add (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | lt a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | lt h1 h2 => exact .lt (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | arith op a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | arith h1 h2 => exact .arith (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | farith op a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | farith h1 h2 => exact .farith (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | cmp op a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | cmp h1 h2 => exact .cmp (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | fcmp op a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | fcmp h1 h2 => exact .fcmp (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | ite c th el ihc iht ihe =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | ite h1 h2 h3 => exact .ite (ihc h1 hd hs.1.1) (iht h2 hd hs.1.2) (ihe h3 hd hs.2)
  | nil t => cases he; exact .nil
  | some e ihe =>
    simp only [Expr.src] at hs
    cases he with | some h => exact .some (ihe h hd hs)
  | ifnil e n s ihe ihn ihs =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe h1 hd hs.1.1) (ihn h2 hd hs.1.2) (ihs h3 hd hs.2)
  | inl r e ihe =>
    simp only [Expr.src] at hs
    cases he with | inl h => exact .inl (ihe h hd hs)
  | inr l e ihe =>
    simp only [Expr.src] at hs
    cases he with | inr h => exact .inr (ihe h hd hs)
  | case e bl br ihe ihl ihr =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | case h1 h2 h3 => exact .case (ihe h1 hd hs.1.1) (ihl h2 hd hs.1.2) (ihr h3 hd hs.2)
  | pair a c iha ihc =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | pair h1 h2 => exact .pair (iha h1 hd hs.1) (ihc h2 hd hs.2)
  | fst e ihe =>
    simp only [Expr.src] at hs
    cases he with | fst h => exact .fst (ihe h hd hs)
  | ann e t ihe =>
    simp only [Expr.src] at hs
    cases he with | ann h hsb => exact .ann (ihe h hd hs) (Ty.sub_renR h0 hsb)
  | snd e ihe =>
    simp only [Expr.src] at hs
    cases he with | snd h => exact .snd (ihe h hd hs)
  | fnref fn ts =>
    cases he with
    | fnref h hl ha =>
      simp only [Expr.renTy, Ty.renR, Ty.map_renR_of_argsOk ha]
      exact .fnref h hl ha
  | callv ef e ihf ihe =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | callv hf harg hsub hbd =>
      rename_i d' p r ta
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      rw [hdd, Ty.relocR_renR hd1]
      have hsub' := Ty.sub_renR h0 hsub
      rw [Ty.shiftR_renR hd1] at hsub'
      have hf' := ihf hf hd hs.1
      simp only [Ty.renR] at hf'
      exact .callv (by rw [← hdd]; exact hf') (by rw [← hdd]; exact ihe harg hd hs.2) hsub'
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
  | call fn ts e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | call hfn hlen hargs harg hsub hbd =>
      rename_i d' dfn ta
      have hd1 : 1 ≤ d' := by omega
      simp only [Expr.renTy, Ty.map_renR_of_argsOk hargs]
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      rw [hdd, Ty.relocR_renR hd1]
      have hsub' := Ty.sub_renR h0 hsub
      rw [Ty.shiftR_renR hd1] at hsub'
      exact .call hfn hlen hargs (by rw [← hdd]; exact ihe harg hd hs) hsub'
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
  | callM fn ts e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | callM hfn hlen hargs harg hanc hsub hbd had =>
      rename_i d' dfn ta a
      have hd1 : 1 ≤ d' := by omega
      simp only [Expr.renTy, Ty.map_renR_of_argsOk hargs]
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      rw [hdd, Ty.relocA_renR hd1]
      have hsub' := Ty.sub_renR h0 hsub
      rw [Ty.renR_renR hd1] at hsub'
      have hanc' : Ty.anchorOf (dfn.inst ts).param (ta.renR ρ0 δ) = Option.some (rmap ρ0 δ a) := by
        rw [Ty.anchorOf_renR, hanc]; rfl
      exact .callM hfn hlen hargs (by rw [← hdd]; exact ihe harg hd hs) hanc' hsub' (rmap_le h0 hbd)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 had; rw [rmap_pos hd1] at this; exact this)
  | block e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | block h hrb =>
      refine .block (by
        have hdd : d + δ + 1 = (d + 1) + δ := by omega
        rw [hdd]
        exact ihe h (by omega) hs) ?_
      have := Ty.renR_regionsBelow h0 hrb
      rwa [rmap_pos (by omega)] at this
  | blockR t₀ e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | blockR h hr hrb =>
      have hdd : d + δ + 1 = (d + 1) + δ := by omega
      have hr' := Ty.jumpRel_renR (ρ0 := ρ0) (δ := δ) h0 hr
      rw [show rmap ρ0 δ (d - 1) = d + δ - 1 by rw [rmap_pos (by omega)]; omega] at hr'
      refine .blockR (by rw [hdd]; exact ihe h (by omega) hs) hr' ?_
      have := Ty.renR_regionsBelow h0 hrb
      rwa [rmap_pos (by omega)] at this
  | copyTo k t₀ e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | copyTo h hk hr hrb hcf =>
      refine .copyTo (ihe h hd hs) ?_ (Ty.jumpRel_renR h0 hr) (Ty.renR_regionsBelow_succ h0 hcf hrb) (by rw [Ty.chanFree_renR]; exact hcf)
      rcases k with _ | k
      · simp only [rmap]; omega
      · rw [rmap_pos (by omega)]; omega
  | label t e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | label h hrb =>
      have h' := ihe h hd hs
      simp only [List.map_cons] at h'
      rw [show rmap ρ0 δ (d - 1) = d + δ - 1 by rw [rmap_pos (by omega)]; omega] at h'
      refine .label h' ?_
      have := Ty.renR_regionsBelow h0 hrb
      rwa [rmap_pos (by omega)] at this
  | unreach t => cases he; exact .unreach
  | jump n t e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | jump hn h hr => exact .jump (by simp [hn]) (ihe h hd hs) (Ty.jumpRel_renR h0 hr)
  | alloc m e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | alloc h hrb hbd hmf =>
      rename_i d' t'
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      refine .alloc (by rw [← hdd]; exact ihe h hd hs) ?_
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this) ?_
      · have := Ty.renR_regionsBelow h0 hrb
        rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this
      · intro hm
        rw [Ty.renR_mutFree]
        exact hmf hm
  | deref e ihe =>
    simp only [Expr.src] at hs
    cases he with | deref h => exact .deref (ihe h hd hs)
  | assign l e ihl ihe =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | assign h1 h2 => exact .assign (ihl h1 hd hs.1) (ihe h2 hd hs.2)
  | whileE c body ihc ihb =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | whileE h1 h2 => exact .whileE (ihc h1 hd hs.1) (ihb h2 hd hs.2)
  | freeze e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | freeze h hm =>
      refine .freeze (ihe h hd hs) ?_
      rw [Ty.renR_mutFree]
      exact hm
    | freezes h hm =>
      refine .freezes (ihe h hd hs) ?_
      rw [Ty.renR_mutFree]
      exact hm
    | freezem h hm =>
      refine .freezem (ihe h hd hs) ?_
      rw [Ty.renR_mutFree]
      exact hm
  | mkslice m t =>
    cases he with
    | mkslice hrb hbd hmf =>
      rename_i d'
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      refine .mkslice ?_
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this) ?_
      · have := Ty.renR_regionsBelow h0 hrb
        rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this
      · intro hm
        rw [Ty.renR_mutFree]
        exact hmf hm
  | mksliceAt m t r =>
    cases he with
    | mksliceAt hrb hbr hrd hmf hcf =>
      refine .mksliceAt (Ty.renR_regionsBelow_succ h0 hcf hrb) (rmap_le h0 hbr) ?_ ?_
        (by rw [Ty.chanFree_renR]; exact hcf)
      · rcases r with _ | r
        · simp only [rmap]; omega
        · rw [rmap_pos (by omega)]; omega
      · intro hm; rw [Ty.renR_mutFree]; exact hmf hm
  | mkmapAt m t r =>
    cases he with
    | mkmapAt hko hrb hbr hrd hmf hcf =>
      have hrb' := Ty.renR_regionsBelow_succ h0 hcf hrb
      have hcf' := (Ty.chanFree_renR (ρ0 := ρ0) (δ := δ) _).trans hcf
      simp only [Ty.renR] at hrb' hcf' ⊢
      refine .mkmapAt (Ty.keyOk_renR ρ0 δ hko) hrb' (rmap_le h0 hbr) ?_ ?_ hcf'
      · rcases r with _ | r
        · simp only [rmap]; omega
        · rw [rmap_pos (by omega)]; omega
      · intro hm
        have h2 := (Ty.renR_mutFree (ρ0 := ρ0) (δ := δ) _).trans (hmf hm)
        simpa only [Ty.renR] using h2
  | strlit bs r =>
    cases he with
    | strlit hbr hrd =>
      simp only [Ty.renR]
      refine .strlit (rmap_le h0 hbr) ?_
      have := rmap_lt (ρ0 := ρ0) (δ := δ) h0 hrd
      rwa [rmap_pos (k := d) (by omega)] at this
  | index e i ot ihe ihi =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | index h1 h2 hrd => exact .index (ihe h1 hd hs.1) (ihi h2 hd hs.2) (Ty.readAs_renR h0 hrd)
  | lenE e ihe =>
    simp only [Expr.src] at hs
    cases he with | lenE h => exact .lenE (ihe h hd hs)
  | tobyte e ihe =>
    simp only [Expr.src] at hs
    cases he with | tobyte h => exact .tobyte (ihe h hd hs)
  | fconv op e ihe =>
    simp only [Expr.src] at hs
    cases he with | fconv h => cases op <;> exact .fconv (ihe h hd hs)
  | toint e ihe =>
    simp only [Expr.src] at hs
    cases he with | toint h => exact .toint (ihe h hd hs)
  | append e v ihe ihv =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | appendM h1 h2 hbr =>
      exact .appendM (ihe h1 hd hs.1) (ihv h2 hd hs.2) (rmap_le h0 hbr)
    | appendI h1 h2 hbd hbt =>
      rename_i d' r' t'
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      exact .appendI (by rw [← hdd]; exact ihe h1 hd hs.1) (by rw [← hdd]; exact ihv h2 hd hs.2)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
        (by have := Ty.renR_regionsBelow h0 hbt; rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this)
  | setidx e i v ihe ihi ihv =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe h1 hd hs.1.1) (ihi h2 hd hs.1.2) (ihv h3 hd hs.2)
  | subslice e sa sb ihe iha ihb =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | subslice h1 h2 h3 => exact .subslice (ihe h1 hd hs.1.1) (iha h2 hd hs.1.2) (ihb h3 hd hs.2)
  | eqs e1 e2 ih1 ih2 =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | eqs h1 h2 => exact .eqs (ih1 h1 hd hs.1) (ih2 h2 hd hs.2)
  | concat e1 e2 ih1 ih2 =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | concat h1 h2 hbd =>
      rename_i d' r1' r2' t'
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      exact .concat (by rw [← hdd]; exact ih1 h1 hd hs.1) (by rw [← hdd]; exact ih2 h2 hd hs.2)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
  | mkmap m t =>
    cases he with
    | mkmap hko hrb hbd hmf =>
      rename_i d' _ _
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      refine .mkmap (Ty.keyOk_renR ρ0 δ hko) ?_
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this) ?_
      · have := Ty.renR_regionsBelow (ρ0 := ρ0) (δ := δ) h0 hrb
        simp only [Ty.renR] at this
        rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this
      · intro hm
        have := hmf hm
        show (Ty.renR ρ0 δ (.prod _ (.opt _))).mutFree = true
        rw [Ty.renR_mutFree]
        exact this
  | getm t e k ihe ihk =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | getm h1 h2 hkc hsub =>
      exact .getm (ihe h1 hd hs.1) (ihk h2 hd hs.2) (Ty.keyCompat_renR ρ0 δ hkc) (Ty.sub_renR h0 hsub)
  | setm e k v ihe ihk ihv =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with | setm h1 h2 h3 => exact .setm (ihe h1 hd hs.1.1) (ihk h2 hd hs.1.2) (ihv h3 hd hs.2)
  | delm t e k ihe ihk =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | delm h1 h2 hkc => exact .delm (ihe h1 hd hs.1) (ihk h2 hd hs.2) (Ty.keyCompat_renR ρ0 δ hkc)
  | lenm e ihe =>
    simp only [Expr.src] at hs
    cases he with | lenm h => exact .lenm (ihe h hd hs)
  | keysm e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | keysm h hko hrb hbd =>
      rename_i d' _ _ _ _
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      exact .keysm (by rw [← hdd]; exact ihe h hd hs) (Ty.keyOk_renR ρ0 δ hko)
        (by have := Ty.renR_regionsBelow h0 hrb; rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
  | clone ot e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | clones h hrd hrb hbd =>
      rename_i d' _ _ _ _
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      exact .clones (by rw [← hdd]; exact ihe h hd hs) (Ty.readAs_renR h0 hrd)
        (by have := Ty.renR_regionsBelow h0 hrb; rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
    | clonem h hrd hrb hbd =>
      rename_i d' _ _ _ _
      have hd1 : 1 ≤ d' := by omega
      have hdd : d' + 1 + δ = (d' + δ) + 1 := by omega
      simp only [Ty.renR, rmap_pos hd1]
      rw [hdd]
      exact .clonem (by rw [← hdd]; exact ihe h hd hs) (Ty.readAs_renR h0 hrd)
        (by have := Ty.renR_regionsBelow h0 hrb; rwa [rmap_pos (k := d' + 1) (by omega), hdd] at this)
        (by have := rmap_le (ρ0 := ρ0) (δ := δ) h0 hbd; rw [rmap_pos hd1] at this; exact this)
  | par e1 e2 ih1 ih2 =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | par h1 h2 hΓ =>
      have e1' := ih1 h1 hd hs.1
      have e2' := ih2 h2 hd hs.2
      rw [rmap_pos (k := d) (by omega)] at e1' e2'
      refine .par e1' e2' ?_
      intro τ hτ
      obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
      rw [Ty.renR_mutFree]
      exact hΓ τ0 hτ0
  | parch t e1 e2 ih1 ih2 =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | parch h1 h2 hΓ hrb hmf =>
      have e1' := ih1 h1 hd hs.1
      have e2' := ih2 h2 hd hs.2
      simp only [List.map_cons, Ty.renR] at e1' e2'
      rw [rmap_pos (k := d) (by omega)] at e1' e2'
      refine .parch e1' e2' ?_ ?_ ?_
      · intro τ hτ
        obtain ⟨τ0, hτ0, rfl⟩ := List.mem_map.mp hτ
        rw [Ty.renR_mutFree]
        exact hΓ τ0 hτ0
      · have := Ty.renR_regionsBelow h0 hrb
        rwa [rmap_pos (by omega)] at this
      · rw [Ty.renR_mutFree]
        exact hmf
  | newchan rc t =>
    cases he with
    | newchan hf hrb hmf =>
      refine .newchan (rmap_le h0 hf) (Ty.renR_regionsBelow h0 hrb) ?_
      rw [Ty.renR_mutFree]
      exact hmf
  | send c e ihc ihe =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | send h1 h2 => exact .send (ihc h1 hd hs.1) (ihe h2 hd hs.2)
    | sendE h1 h2 hp => exact .sendE (ihc h1 hd hs.1) (ihe h2 hd hs.2) (Ty.payOk_renR hp)
  | recv c ihc =>
    simp only [Expr.src] at hs
    cases he with
    | recv h => exact .recv (ihc h hd hs)
    | recvE h hm hc =>
      rename_i r t
      have h' := HasType.recvE (ihc h hd hs) (by rw [Ty.renR_mutFree]; exact hm) (by rw [Ty.chanFree_renR]; exact hc)
      rw [Ty.relocR_renR_left hm hc] at h'
      simp only [Ty.renR]
      rw [Ty.renR_relocR_mf hm hc, rmap_pos (k := d - 1) (by omega), Ty.relocR_renR_left hm hc]
      rwa [show d - 1 + δ = d + δ - 1 by omega]
  | close c ihc =>
    simp only [Expr.src] at hs
    cases he with
    | closeE h => exact .closeE (ihc h hd hs)
  | loc r a => simp [Expr.src] at hs
  | slicev mt r base len => simp [Expr.src] at hs
  | mapv mt r base len => simp [Expr.src] at hs
  | chanV c => simp [Expr.src] at hs
  | scope t₀ εs e ihe =>
    simp only [Expr.src] at hs
    cases he with
    | scope h hr hrb hem hec hbd =>
      have hdd : d + δ + 1 = (d + 1) + δ := by omega
      have hr' := Ty.jumpRel_renR (ρ0 := ρ0) (δ := δ) h0 hr
      rw [show rmap ρ0 δ (d - 1) = d + δ - 1 by rw [rmap_pos (by omega)]; omega] at hr'
      have h' := ihe h (by omega) hs
      simp only [List.map_cons, List.map_nil, Ty.renR, rmap_pos (show 1 ≤ d by omega)] at h'
      have hεr : (εs.relocR (d - 1)).renR ρ0 δ = (εs.renR ρ0 δ).relocR (d + δ - 1) := by
        rw [Ty.renR_relocR_mf hem hec, rmap_pos (by omega)]; congr 1; omega
      simp only [Ty.renR, Expr.renTy, hεr]
      refine .scope (by rw [hdd]; exact h') hr' ?_ (by rw [Ty.renR_mutFree]; exact hem) (by rw [Ty.chanFree_renR]; exact hec)
        (by unfold rmap; split <;> omega)
      have := Ty.renR_regionsBelow h0 hrb
      rwa [rmap_pos (by omega)] at this
  | spawn sc a e ihsc iha ihe =>
    simp only [Expr.src, Bool.and_eq_true] at hs
    cases he with
    | spawn h1 ha hg h2 hrb hcf hε =>
      have h1' := ihsc h1 hd hs.1.1
      simp only [Ty.renR] at h1'
      have h2' := ihe h2 (by omega) hs.2
      simp only [List.map_cons, List.map_nil, Ty.rehome_renR] at h2'
      rw [rmap_pos (k := d) (by omega), show d + 1 + δ = (d + δ) + 1 by omega] at h2'
      simp only [Ty.renR, Expr.renTy]
      rw [Ty.renR_relocR_mf hrb hcf]
      exact .spawn h1' (iha ha hd hs.1.2) (Ty.givable_renR h0 hg) h2'
        (by simpa [Ty.mutFree, Ty.renR_mutFree] using hrb)
        (by simpa [Ty.chanFree, Ty.chanFree_renR] using hcf)
        (Ty.payOk_renR hε)
  | join tj h ihh =>
    simp only [Expr.src] at hs
    cases he with
    | join h1 =>
      have h1' := ihh h1 hd hs
      simp only [Ty.renR] at h1'
      exact .join h1'
  | tryJ t₀ h ihh =>
    simp only [Expr.src] at hs
    cases he with
    | tryJ h1 =>
      have h1' := ihh h1 hd hs
      simp only [Ty.renR] at h1'
      exact .tryJ h1'
  | scopeV rs ε => simp [Expr.src] at hs
  | taskV rs n => simp [Expr.src] at hs
  | newch r cap t₀ =>
    cases he with
    | newch h1 h2 h3 h4 h5 h6 =>
      simp only [Expr.renTy, Ty.renR]
      refine .newch (rmap_le h0 h1) ?_ h3 (by rw [Ty.renR_mutFree]; exact h4) (by rw [Ty.chanFree_renR]; exact h5) ?_
      · have := rmap_lt (ρ0 := ρ0) (δ := δ) h0 h2
        rwa [rmap_pos (k := d) (by omega)] at this
      · have := Ty.renR_regionsBelow (ρ0 := ρ0) (δ := δ) h0 h6
        rwa [rmap_pos (k := d) (by omega)] at this
  | epV p k b r => simp [Expr.src] at hs

end HasType

theorem Expr.noNewchan_renTy {ρ0 δ : Nat} {e : Expr} (h : e.noNewchan = true) :
    (e.renTy ρ0 δ).noNewchan = true := by
  induction e <;> simp_all [Expr.noNewchan, Expr.renTy]

end FS
