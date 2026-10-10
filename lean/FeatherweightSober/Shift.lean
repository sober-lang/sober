import FeatherweightSober.Substitution

/-!
# シフト定理（round4: call 同世界化の instantiate）

Def の本体は base の世界（Ξ = Ψ = []、f = b = 1、d = 2）で一度だけ型付けされる。
呼び出しはこれを一様シフト +ρ で呼び手の深さへ instantiate する — その健全性が本定理:
「空ストア・空チャネル環境で型付くソース項は、世界（f / b / d / Γ / 型 / 項注釈）を
同じ ρ でずらしても型付く」。

- ストアとチャネル環境が空なので loc / slicev / mapv / chanV は型が付かず（lookup 不能）、
  ソース項限定の述語なしで実行時項のケースが消える
- imm の region 添字は上界（(1)）なのでシフトは緩める向きでも正確な向きでも健全、
  mut は世界全体が一様にずれるので正確さが保たれる
- call のケースが sub_shiftR / shiftR_comp で閉じる形が、call 規則（ρ = d の instantiate）を
  一意に決めた
-/
namespace FS

/-- キー型の制限・比較可能性はシフトで不変（int / imm string は region 添字しか動かない） -/
theorem Ty.keyOk_shiftR (ρ : Nat) {k : Ty} (h : k.keyOk = true) : (k.shiftR ρ).keyOk = true := by
  unfold Ty.keyOk at h
  split at h <;> simp_all [Ty.shiftR, Ty.keyOk]

theorem Ty.keyCompat_shiftR (ρ : Nat) {a b : Ty} (h : a.keyCompat b = true) :
    (a.shiftR ρ).keyCompat (b.shiftR ρ) = true := by
  unfold Ty.keyCompat at h
  split at h <;> simp_all [Ty.shiftR, Ty.keyCompat]

theorem Ty.mutTop_shiftR (ρ : Nat) : ∀ ta : Ty, (ta.shiftR ρ).mutTop = ta.mutTop.map (· + ρ)
  | .ref m r _ => by cases m <;> simp [Ty.mutTop, Ty.shiftR]
  | .slice m r _ => by cases m <;> simp [Ty.mutTop, Ty.shiftR]
  | .map m r _ => by cases m <;> simp [Ty.mutTop, Ty.shiftR]
  | .int | .tvar _ | .bool | .byte | .f64 | .unit | .opt _ | .union _ _ | .prod _ _ | .chan _ _ | .fn _ _ | .own _ _ _ => by
    simp [Ty.mutTop, Ty.shiftR]

/-- anchor の読み取りはシフトと可換（実引数の型の mut 位置の region が +ρ ずれるだけ） -/
theorem Ty.anchorOf_shiftR (ρ : Nat) : ∀ (p ta : Ty), Ty.anchorOf p (ta.shiftR ρ) = (Ty.anchorOf p ta).map (· + ρ) := by
  intro p
  induction p with
  | prod l r ihl ihr =>
    intro ta
    cases ta <;> simp only [Ty.anchorOf, Ty.shiftR, Option.map_none]
    rename_i l' r'
    rw [ihl, ihr]
    cases Ty.anchorOf l l' <;> simp
  | _ =>
    intro ta
    simp only [Ty.anchorOf]
    split <;> simp [Ty.mutTop_shiftR]

/-- 型引数（loc-free・chan-free）は写像で不動 -/
theorem Ty.renR_of_argOk {ρ0 δ : Nat} {t : Ty} (h : t.tyArgOk = true) : t.renR ρ0 δ = t := by
  induction t with
  | int => rfl
  | tvar _ => rfl
  | bool => rfl
  | byte => rfl
  | f64 => rfl
  | unit => rfl
  | opt t ih =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at h
    simp [Ty.renR, ih (by simp [Ty.tyArgOk, h])]
  | union l r ihl ihr =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.renR, ihl (by simp [Ty.tyArgOk, h]), ihr (by simp [Ty.tyArgOk, h])]
  | prod l r ihl ihr =>
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.renR, ihl (by simp [Ty.tyArgOk, h]), ihr (by simp [Ty.tyArgOk, h])]
  | ref _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | slice _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | map _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | chan _ _ _ => simp [Ty.tyArgOk, Ty.chanFree] at h
  | fn _ _ _ _ => rfl
  | own _ _ _ _ => simp [Ty.tyArgOk, Ty.regionsBelow] at h

theorem Ty.map_renR_of_argsOk {ts : List Ty} {ρ0 δ : Nat} (h : Ty.tyArgsOk ts = true) :
    ts.map (Ty.renR ρ0 δ) = ts := by
  conv => rhs; rw [← List.map_id ts]
  apply List.map_congr_left
  intro τ hτ
  simp only [Ty.tyArgsOk, List.all_eq_true] at h
  exact Ty.renR_of_argOk (h τ hτ)

/-- 写像の後のシフト = anchor と深さを +ρ した写像 -/
theorem rmap_shift (a d ρ r : Nat) : rmap a d r + ρ = rmap (a + ρ) (d + ρ) r := by
  cases r <;> simp [rmap] <;> omega

theorem Ty.renR_shiftR (a d ρ : Nat) : ∀ t : Ty, (t.renR a d).shiftR ρ = t.renR (a + ρ) (d + ρ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t]
  | .union l r => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ l, Ty.renR_shiftR a d ρ r]
  | .prod l r => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ l, Ty.renR_shiftR a d ρ r]
  | .ref m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t, rmap_shift]
  | .slice m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t, rmap_shift]
  | .map m r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t, rmap_shift]
  | .chan rc t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t, rmap_shift]
  | .fn p r => rfl
  | .own k r t => by simp [Ty.renR, Ty.shiftR, Ty.renR_shiftR a d ρ t, rmap_shift]

theorem Ty.relocA_shiftR (a d ρ : Nat) : ∀ t : Ty, (t.relocA a d).shiftR ρ = t.relocA (a + ρ) (d + ρ)
  | .int => rfl
  | .tvar _ => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ t]
  | .union l r => by simp [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ l, Ty.relocA_shiftR a d ρ r]
  | .prod l r => by simp [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ l, Ty.relocA_shiftR a d ρ r]
  | .ref false r t => by
    simp only [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ t]; split <;> rfl
  | .slice false r t => by
    simp only [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ t]; split <;> rfl
  | .map false r t => by
    simp only [Ty.relocA, Ty.shiftR, Ty.relocA_shiftR a d ρ t]; split <;> rfl
  | .ref true r t => by simp [Ty.relocA, Ty.shiftR, Ty.renR_shiftR, rmap_shift]
  | .slice true r t => by simp [Ty.relocA, Ty.shiftR, Ty.renR_shiftR, rmap_shift]
  | .map true r t => by simp [Ty.relocA, Ty.shiftR, Ty.renR_shiftR, rmap_shift]
  | .chan rc t => by simp [Ty.relocA, Ty.shiftR, Ty.renR_shiftR, rmap_shift]
  | .fn p r => rfl
  | .own k r t => by simp [Ty.relocA, Ty.shiftR, Ty.renR_shiftR, rmap_shift]

namespace HasType

end HasType

end FS
