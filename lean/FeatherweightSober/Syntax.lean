/-!
# 構文（段 3d: region + mut/immutable 参照 + parallel + 参照つきペイロードのチャネル）

Sober のコア AST（脱糖後）。変数は de Bruijn インデックス。
Sober の構文との対応は docs/formal.md「段 1 の断片」の表を正とする:
ブロック `{ x := e; body }` は `letE` の鎖、`if v != nil { .. v .. } else { .. }` は `ifnil`、
2 バリアントの `union` は `inl` / `inr` と `case`。
-/

namespace FS

/-- 端点のチャネルの鍵（段 6 P1 — par-draft 5.3 の決定的な id）: 生成元の task id（親の id ++ [子の番号]）と、その task の局所の通し番号 -/
abbrev EpKey := List Nat × Nat

/-- 単一 task が所有する能力の種類（段 6 P1 — par-draft 5 節）: scope の札・task の handle・チャネルの送り端 / 受け端 -/
inductive OwnK : Type where
  | scope
  | task
  | tx
  | rx
  deriving DecidableEq, Repr

/-- 型。`opt t` が `T?`、`union l r` が 2 バリアント union（variant 名は抽象化）。
`ref m r t` の r は region の絶対レベル（region スタック底から 0。de Bruijn index ではない）、
m は mut フラグ（true = 書き込み可）。 -/
inductive Ty : Type where
  | int
  /-- 型変数（V3-2）: Def の型パラメータへの添字。region を持たず、区域系の述語
  （regionsBelow / mutFree / chanFree / シフト）では int と同じ扱い。インスタンスは
  loc-free・chan-free な型に限る（Ty.tyArgOk）ので、代入が region 座標と可換になる -/
  | tvar (i : Nat)
  | bool
  /-- 格納単位のスカラー（byte の段 — language.md 33 節）。値は実行時の blit n（0 ≤ n < 256）。区域系の述語は int と同じ扱い -/
  | byte
  /-- IEEE 754 binary64（float の段 — language.md 37 節）。値は flit n（n = ビット列を i64 の 2 の補数で読んだ Int）。区域系の述語は int と同じ扱い・演算の値は IEEE に委ねる（opaque） -/
  | f64
  /-- 値なし（Sober の none）。代入と while の型 -/
  | unit
  | opt (t : Ty)
  | union (l r : Ty)
  /-- 二項直積。Sober の struct は右結合の入れ子で表す（n = 0 は unit、n = 1 は素の型。
  フィールド名 → 位置は脱糖器の仕事）。List をコアに入れない裁定は formal.md
  「Phase 2 第一弾のスコープ」 -/
  | prod (l r : Ty)
  | ref (m : Bool) (r : Nat) (t : Ty)
  /-- slice（可変長データの region 意味論 — language.md 21 節）。
  本体は region r のセル列、変数は値としてのヘッダ。ref の一般化で m / r の意味は同じ -/
  | slice (m : Bool) (r : Nat) (t : Ty)
  /-- map（language.md 22 節）。本体は region r のセル列、変数は slice と同型の値ヘッダ。
  **t はセル型**（mkmap が作るのは `prod k (opt v)` — k = キー型、none = 墓石）。
  キー型は slice の要素型と同じく具体的な region 添字を持つ普通の型（string キー = 随時回収 R3。
  region 多相ではない）。キー型の制限（int | imm string）は mkmap の型規則だけが持つ -/
  | map (m : Bool) (r : Nat) (t : Ty)
  /-- ペイロード型 t のチャネル。rc は共有上界: ペイロードの参照は region < rc 限定で、
  チャネル自体も rc より下へ escape できない（段 3d。language.md 18 節） -/
  | chan (rc : Nat) (t : Ty)
  /-- 閉じた関数値の型（V3-1）。p / r は Def の **base 座標**（region 0 = 呼び手空間、
  1 = 自フレーム）のまま持つ型スキーム — 現在の世界の region に言及しないので
  loc-free・シフト不動。呼び出し（callv）が call と同じ一様シフト +d で instantiate する -/
  | fn (p r : Ty)
  /-- 単一 task が所有する能力（段 6 P1）: k = 種類・r = 家の region（mut の loc と同じく正確 — 型付けは b ≤ r < d なので
  子の世界では型が付かず、捕獲も実行時の代入も構造で閉じる）・t = 結果 / ペイロードの型（P1 は loc-free）。
  mutFree でない（捕獲できない）・chanFree でない（写せない）・部分型は不変 -/
  | own (k : OwnK) (r : Nat) (t : Ty)
  deriving DecidableEq, Repr

/-- 型が言及する region がすべてレベル d 未満（block の escape 検査に使う） -/
def Ty.regionsBelow (d : Nat) : Ty → Bool
  | .int => true
  | .tvar i => true
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
  -- チャネルはペイロードが参照する region（< rc）より下へ escape できない。
  -- 「参照先はチャネルより長生き」の型付け化（段 3d）
  | .chan rc t => decide (rc ≤ d) && t.regionsBelow rc
  | .own _ r t => decide (r < d) && t.regionsBelow d
  -- 関数値は環境を持たない（Def 参照のみ）。シグネチャは base 座標の型スキーム
  | .fn _ _ => true

/-- mut 参照をどこにも含まない（深い不変性）。par に渡せる Γ の条件（段 3b）。
loc-free（`regionsBelow 0`）から緩和: immutable 参照は含んでよい -/
def Ty.mutFree : Ty → Bool
  | .int => true
  | .tvar i => true
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
  -- チャネルは Sharable（region-domain-pool.md の方向づけの最小形）:
  -- 内部同期を持つのでタスクに渡せる。mutFree 検査の白リスト
  | .chan _ _ => true
  | .fn _ _ => true
  | .own _ _ _ => false

/-- map のキー型の制限（R3: int | imm string の二択）。mkmap の型規則だけが使う -/
def Ty.keyOk : Ty → Bool
  | .int => true
  | .slice false _ .byte => true
  | _ => false

/-- 探索キー（getm / delm）がキー型と比較できる: 同じ種類なら region は問わない
（探索はキーを格納しないので escape が無い — eqs と同じ線） -/
def Ty.keyCompat : Ty → Ty → Bool
  | .int, .int => true
  | .slice false _ .byte, .slice false _ .byte => true
  | _, _ => false

/-- loc-free（regionsBelow 0）なら mutFree（参照を全く含まないので）。
チャネルのペイロード（loc-free）を任意の共有境界の世界へ持ち込むときに使う -/
theorem Ty.mutFree_of_locFree : ∀ {t : Ty}, t.regionsBelow 0 = true → t.mutFree = true
  | .int, _ => rfl
  | .tvar i, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => Ty.mutFree_of_locFree (t := t) (by simpa [Ty.regionsBelow] using h)
  | .union l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.mutFree, Ty.mutFree_of_locFree (t := l) h.1, Ty.mutFree_of_locFree (t := r) h.2]
  | .prod l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h
    simp [Ty.mutFree, Ty.mutFree_of_locFree (t := l) h.1, Ty.mutFree_of_locFree (t := r) h.2]
  | .ref m r t, h => by simp [Ty.regionsBelow] at h
  | .slice m r t, h => by simp [Ty.regionsBelow] at h
  | .map m r t, h => by simp [Ty.regionsBelow] at h
  | .chan rc t, _ => rfl
  | .fn p r, _ => rfl

/-- regionsBelow の単調性: 上界を緩める向きは常に健全（round4 の imm 上界化で多用）。
chan は内側が rc 固定なので外側の rc ≤ d だけが動く -/
theorem Ty.regionsBelow_mono {m n : Nat} (hmn : m ≤ n) :
    ∀ {t : Ty}, t.regionsBelow m = true → t.regionsBelow n = true
  | .int, _ => rfl
  | .tvar i, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => Ty.regionsBelow_mono hmn (t := t) (by simpa [Ty.regionsBelow] using h)
  | .union l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h ⊢
    exact ⟨Ty.regionsBelow_mono hmn h.1, Ty.regionsBelow_mono hmn h.2⟩
  | .prod l r, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true] at h ⊢
    exact ⟨Ty.regionsBelow_mono hmn h.1, Ty.regionsBelow_mono hmn h.2⟩
  | .ref m' r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
    exact ⟨by omega, Ty.regionsBelow_mono hmn h.2⟩
  | .slice m' r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
    exact ⟨by omega, Ty.regionsBelow_mono hmn h.2⟩
  | .map m' r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
    exact ⟨by omega, Ty.regionsBelow_mono hmn h.2⟩
  | .chan rc t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
    exact ⟨by omega, h.2⟩
  | .own k r t, h => by
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at h ⊢
    exact ⟨by omega, Ty.regionsBelow_mono hmn h.2⟩
  | .fn p r, _ => rfl

/-- 全 region 添字への一様シフト +ρ（round4: Def を base で一度型付けし、
呼び出し深さへ instantiate する）。imm の添字は上界なのでシフトは常に健全、
mut は世界全体が一様にずれるので正確さが保たれる。chan は rc も内側もシフト -/
def Ty.shiftR (ρ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
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
  | .fn p r => .fn p r
  | .own k r t => .own k (r + ρ) (t.shiftR ρ)

theorem Ty.shiftR_zero : ∀ t : Ty, t.shiftR 0 = t
  | .int => rfl
  | .tvar i => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .union l r => by simp [Ty.shiftR, Ty.shiftR_zero l, Ty.shiftR_zero r]
  | .prod l r => by simp [Ty.shiftR, Ty.shiftR_zero l, Ty.shiftR_zero r]
  | .ref m r t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .slice m r t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .map m r t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .chan rc t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .own k r t => by simp [Ty.shiftR, Ty.shiftR_zero t]
  | .fn p r => rfl

theorem Ty.shiftR_comp (ρ₁ ρ₂ : Nat) : ∀ t : Ty, (t.shiftR ρ₁).shiftR ρ₂ = t.shiftR (ρ₁ + ρ₂)
  | .int => rfl
  | .tvar i => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]
  | .union l r => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ l, Ty.shiftR_comp ρ₁ ρ₂ r]
  | .prod l r => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ l, Ty.shiftR_comp ρ₁ ρ₂ r]
  | .ref m r t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]; omega
  | .slice m r t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]; omega
  | .map m r t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]; omega
  | .chan rc t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]; omega
  | .own k r t => by simp [Ty.shiftR, Ty.shiftR_comp ρ₁ ρ₂ t]; omega
  | .fn p r => rfl

/-- シフトと escape 検査の可換性: 世界と型を同じ ρ でずらすと regionsBelow は不変 -/
theorem Ty.shiftR_regionsBelow {ρ : Nat} :
    ∀ (t : Ty) (d : Nat), (t.shiftR ρ).regionsBelow (d + ρ) = t.regionsBelow d
  | .int, _ => rfl
  | .tvar i, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, d => by simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t d]
  | .union l r, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow l d, Ty.shiftR_regionsBelow r d]
  | .prod l r, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow l d, Ty.shiftR_regionsBelow r d]
  | .ref m r t, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t d]
  | .slice m r t, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t d]
  | .map m r t, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t d]
  | .chan rc t, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t rc]
  | .own k r t, d => by
    simp [Ty.shiftR, Ty.regionsBelow, Ty.shiftR_regionsBelow t d]
  | .fn p r, d => rfl

theorem Ty.shiftR_mutFree {ρ : Nat} : ∀ t : Ty, (t.shiftR ρ).mutFree = t.mutFree
  | .int => rfl
  | .tvar i => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree t]
  | .union l r => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree l, Ty.shiftR_mutFree r]
  | .prod l r => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree l, Ty.shiftR_mutFree r]
  | .ref m r t => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree t]
  | .slice m r t => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree t]
  | .map m r t => by simp [Ty.shiftR, Ty.mutFree, Ty.shiftR_mutFree t]
  | .chan rc t => by simp [Ty.shiftR, Ty.mutFree]
  | .own k r t => rfl
  | .fn p r => rfl

/-- call 結果の座標付け替え（round5: call 結果の再転送、R0 で値ラッパの中へ延長）: shiftR ρ と
同じ一様シフトだが、**最上段の imm コンテナ / 参照の上界だけ ρ に締める** — fretK の浅い
relocate が最上段を呼び手最内（region ρ）へ写す物理と一致する、最も締まった上界。
R4a（深い relocate）: imm コンテナの中身も同じく締める — relocate がフレームのセルの中身まで再帰して
呼び手最内へ写すので、中身の自フレーム由来の上界も ρ になる（フレーム外のコンテナの中身は元々 ρ 以下）。値ラッパ（opt / union / prod）へは
分配 — relocate は some / inl / inr / pair の中へも分配して写すので、opt / union の中の
コンテナも最上段として締める（R0。nil / inl / inr の型注釈は fretK が coerceTo で書き換える）。
mut / chan は shiftR と同じ（retOk が禁じるので call 結果には現れない） -/
def Ty.relocR (ρ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
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
  | .fn p r => .fn p r
  | .own k r t => .own k (r + ρ) (t.shiftR ρ)

/-- relocR とシフトの合成: instantiate をさらに ρ₂ ずらすと relocR (ρ₁ + ρ₂)（シフト定理の
call ケースが要求する形） -/
theorem Ty.relocR_shiftR_comp (ρ₁ ρ₂ : Nat) : ∀ t : Ty, (t.relocR ρ₁).shiftR ρ₂ = t.relocR (ρ₁ + ρ₂)
  | .int => rfl
  | .tvar i => rfl
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ t]
  | .union l r => by
    simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ l, Ty.relocR_shiftR_comp ρ₁ ρ₂ r]
  | .prod l r => by
    simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ l, Ty.relocR_shiftR_comp ρ₁ ρ₂ r]
  | .ref false r t => by simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ t]
  | .slice false r t => by simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ t]
  | .map false r t => by simp [Ty.relocR, Ty.shiftR, Ty.relocR_shiftR_comp ρ₁ ρ₂ t]
  | .ref true r t => by simp [Ty.relocR, Ty.shiftR, Ty.shiftR_comp]; omega
  | .slice true r t => by simp [Ty.relocR, Ty.shiftR, Ty.shiftR_comp]; omega
  | .map true r t => by simp [Ty.relocR, Ty.shiftR, Ty.shiftR_comp]; omega
  | .chan rc t => by simp [Ty.relocR, Ty.shiftR, Ty.shiftR_comp]; omega
  | .own k r t => by simp [Ty.relocR, Ty.shiftR, Ty.shiftR_comp]; omega
  | .fn p r => rfl

/-- region の写像: 0（圧縮された呼び手空間）↦ ρ0、それ以外は +δ -/
def rmap (ρ0 δ : Nat) : Nat → Nat
  | 0 => ρ0
  | k + 1 => k + 1 + δ

/-- 型の写像（全 region 添字に rmap。tvar / 関数型のスキームには触れない — shiftR と同じ） -/
def Ty.renR (ρ0 δ : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
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
  | .fn p r => .fn p r
  | .own k r t => .own k (rmap ρ0 δ r) (t.renR ρ0 δ)

/-- anchor つき call 結果の座標（relocR の一般化 — R2）: 最上段の imm コンテナ / 参照のうち、
region 0（呼び手空間由来）は anchor ρ0 へ、自フレーム（region 1）由来は呼び手最内 d へ締める
（fretK の relocate がフレームのセルだけを呼び手最内へ写す物理と一致）。中身は renR。
値ラッパへは分配（R0 の relocR と同じ）。ρ0 = d のとき relocR d と一致する -/
def Ty.relocA (ρ0 d : Nat) : Ty → Ty
  | .int => .int
  | .tvar i => .tvar i
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
  | .fn p r => .fn p r
  | .own k r t => .own k (rmap ρ0 d r) (t.renR ρ0 d)

/-- 脱出の締め（R4b — jump の境界コピー）: k より深い imm の region を k に締める（中身も）。
jump は巻き戻しで捨てる region（> k）の imm コンテナを、ラベルの最内 region k へ中身ごと写す（深い relocate の一般化）。
mut / chan は触らない（写せない — jumpRel が k 以下を要求する） -/
def Ty.clampR (k : Nat) : Ty → Ty
  | .opt t => .opt (t.clampR k)
  | .union l r => .union (l.clampR k) (r.clampR k)
  | .prod l r => .prod (l.clampR k) (r.clampR k)
  | .ref false r t => .ref false (min r k) (t.clampR k)
  | .slice false r t => .slice false (min r k) (t.clampR k)
  | .map false r t => .map false (min r k) (t.clampR k)
  | t => t

/-- 締めで何も変わらない（imm の region がどこも k 以下 — 実行時にも写すものが無い） -/
def Ty.noClamp (k : Nat) : Ty → Bool
  | .opt t => t.noClamp k
  | .union l r => l.noClamp k && r.noClamp k
  | .prod l r => l.noClamp k && r.noClamp k
  | .ref false r t => decide (r ≤ k) && t.noClamp k
  | .slice false r t => decide (r ≤ k) && t.noClamp k
  | .map false r t => decide (r ≤ k) && t.noClamp k
  | _ => true

/-- 値が型注釈を持たない型（R4b-cov）: opt / union（nil / inl / inr が注釈を運ぶ）と tvar を含まない。
この型の値は部分型から注釈の書き換えなしに包摂できる（imm セルの読み出しの注釈を省ける条件） -/
def Ty.annFree : Ty → Bool
  | .int => true
  | .tvar _ => false
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt _ => false
  | .union _ _ => false
  | .prod l r => l.annFree && r.annFree
  | .ref _ _ _ => true
  | .slice m _ t => m || t.annFree
  | .map m _ t => m || t.annFree
  | .chan _ _ => true
  | .fn _ _ => true
  | .own _ _ _ => true

/-- 仮引数型の mut 位置（region 0 の ref / slice / map true） -/
def Ty.isMut0 : Ty → Bool
  | .ref m r _ => m && r == 0
  | .slice m r _ => m && r == 0
  | .map m r _ => m && r == 0
  | _ => false

/-- mut コンテナ / 参照の最上段の region -/
def Ty.mutTop : Ty → Option Nat
  | .ref m r _ => if m then some r else none
  | .slice m r _ => if m then some r else none
  | .map m r _ => if m then some r else none
  | _ => none

/-- anchor の読み取り（R2）: 仮引数型の mut 位置（region 0 の ref / slice / map true — prod 鎖の各成分）に
対応する実引数の型の region。最初に見つかったもの。無ければ none -/
def Ty.anchorOf : Ty → Ty → Option Nat
  | .prod l r, ta =>
      match ta with
      | .prod l' r' => (Ty.anchorOf l l').or (Ty.anchorOf r r')
      | _ => none
  | p, ta => if p.isMut0 then ta.mutTop else none

/-- 部分型（round4、V1 = 浅い imm 共変）: imm コンテナ / 参照の region 上界は
緩められる（要素型は正確なまま — セル型付けが要素型を正確に固定するため、
深い共変には「セル sub」が要る = 後続の梯子）。値ラッパ（opt / union / prod）へは
分配する。mut / chan は不変。call の引数を param.shiftR d に合わせる唯一の挿入点 -/
def Ty.sub : Ty → Ty → Bool
  | .opt t, .opt t' => Ty.sub t t'
  | .union l r, .union l' r' => Ty.sub l l' && Ty.sub r r'
  | .prod l r, .prod l' r' => Ty.sub l l' && Ty.sub r r'
  | .ref false r t, .ref false r' t' => decide (r ≤ r') && decide (t = t')
  | .slice false r t, .slice false r' t' => decide (r ≤ r') && Ty.sub t t'
  | .map false r t, .map false r' t' => decide (r ≤ r') && Ty.sub t t'
  | a, b => decide (a = b)

theorem Ty.sub_refl : ∀ t : Ty, Ty.sub t t = true
  | .int => rfl
  | .tvar i => by simp [Ty.sub]
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.sub, Ty.sub_refl t]
  | .union l r => by simp [Ty.sub, Ty.sub_refl l, Ty.sub_refl r]
  | .prod l r => by simp [Ty.sub, Ty.sub_refl l, Ty.sub_refl r]
  | .ref m r t => by cases m <;> simp [Ty.sub]
  | .slice m r t => by cases m <;> simp [Ty.sub, Ty.sub_refl t]
  | .map m r t => by cases m <;> simp [Ty.sub, Ty.sub_refl t]
  | .chan rc t => by simp [Ty.sub]
  | .own k r t => by simp [Ty.sub]
  | .fn p r => by simp [Ty.sub]

/-- sub は escape 検査を狭める向きに保つ: 上界の緩み ta ≤ tb は
tb の床がそのまま ta の床（boundary copy と block 出口の transport） -/
theorem Ty.sub_regionsBelow {d : Nat} :
    ∀ {ta tb : Ty}, Ty.sub ta tb = true → tb.regionsBelow d = true → ta.regionsBelow d = true
  | .opt t, .opt t', hs, hb => by
    simp only [Ty.sub] at hs
    simp only [Ty.regionsBelow] at hb ⊢
    exact Ty.sub_regionsBelow hs hb
  | .union l r, .union l' r', hs, hb => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hb ⊢
    exact ⟨Ty.sub_regionsBelow hs.1 hb.1, Ty.sub_regionsBelow hs.2 hb.2⟩
  | .prod l r, .prod l' r', hs, hb => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.regionsBelow, Bool.and_eq_true] at hb ⊢
    exact ⟨Ty.sub_regionsBelow hs.1 hb.1, Ty.sub_regionsBelow hs.2 hb.2⟩
  | .ref false r t, .ref false r' t', hs, hb => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    obtain ⟨hr, rfl⟩ := hs
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb ⊢
    exact ⟨by omega, hb.2⟩
  | .slice false r t, .slice false r' t', hs, hb => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb ⊢
    exact ⟨by omega, Ty.sub_regionsBelow hs.2 hb.2⟩
  | .map false r t, .map false r' t', hs, hb => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb ⊢
    exact ⟨by omega, Ty.sub_regionsBelow hs.2 hb.2⟩
  | .int, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .tvar i, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .bool, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .byte, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .f64, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .unit, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .chan rc t, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .own k r t, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .fn p r, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .ref true r t, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .slice true r t, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .map true r t, tb, hs, hb => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    exact hs ▸ hb
  | .opt t, .int, hs, hb => by simp [Ty.sub] at hs
  | .union l r, .int, hs, hb => by simp [Ty.sub] at hs
  | .prod l r, .int, hs, hb => by simp [Ty.sub] at hs

/-- sub は mutFree を変えない（緩むのは imm 側だけ） -/
theorem Ty.sub_mutFree :
    ∀ {ta tb : Ty}, Ty.sub ta tb = true → ta.mutFree = tb.mutFree
  | .opt t, .opt t', hs => by
    simp only [Ty.sub] at hs
    simp only [Ty.mutFree]
    exact Ty.sub_mutFree hs
  | .union l r, .union l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.mutFree]
    rw [Ty.sub_mutFree hs.1, Ty.sub_mutFree hs.2]
  | .prod l r, .prod l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.mutFree]
    rw [Ty.sub_mutFree hs.1, Ty.sub_mutFree hs.2]
  | .ref false r t, .ref false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    rw [hs.2]
    simp [Ty.mutFree]
  | .slice false r t, .slice false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp [Ty.mutFree, Ty.sub_mutFree hs.2]
  | .map false r t, .map false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp [Ty.mutFree, Ty.sub_mutFree hs.2]
  | .int, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .tvar i, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .bool, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .byte, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .f64, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .unit, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .chan rc t, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .own k r t, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .fn p r, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .ref true r t, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .slice true r t, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .map true r t, tb, hs => by
    simp only [Ty.sub, decide_eq_true_eq] at hs
    rw [hs]
  | .opt t, .int, hs => by simp [Ty.sub] at hs
  | .union l r, .int, hs => by simp [Ty.sub] at hs
  | .prod l r, .int, hs => by simp [Ty.sub] at hs

/-- チャネルを含まない（round4: 関数境界は chan の rc が正確なため断片外） -/
def Ty.chanFree : Ty → Bool
  | .int => true
  | .tvar i => true
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
  | .fn _ _ => true
  | .own _ _ _ => false

/-- jump のペイロードの型 tJ からラベルの型 tL への関係（R4b）: k へ締めてから浅い共変で緩める。
締めで型が変わる（= 実行時に写す）なら、写す先 k は共有 region でなく（b ≤ k）、ペイロードは chan を持たない -/
def Ty.jumpRel (b k : Nat) (tJ tL : Ty) : Bool :=
  Ty.sub (tJ.clampR k) tL && (tJ.noClamp k || (decide (b ≤ k) && tJ.chanFree))

/-- 共有境界は無条件に下げられる（b_lower の jump ケース） -/
theorem Ty.jumpRel_lower {b b' k : Nat} {tJ tL : Ty} (hb : b' ≤ b) (h : Ty.jumpRel b k tJ tL = true) :
    Ty.jumpRel b' k tJ tL = true := by
  simp only [Ty.jumpRel, Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at h ⊢
  exact ⟨h.1, h.2.elim .inl (fun h2 => .inr ⟨by omega, h2.2⟩)⟩

/-- 読み出しの結果型（R4b-cov A-2）: 注釈 t があれば要素型 t' ≤ t で t、無ければ t' そのもの
（mut コンテナ = セル型が正確、か annFree に限る） -/
def Ty.readAs (m : Bool) : Option Ty → Ty → Option Ty
  | Option.none, t' => if m || t'.annFree then some t' else none
  | Option.some t, t' => if Ty.sub t' t then some t else none

/-! sub の反転補題（value_coerce の場合分け用）。fallback 系（int / bool / unit / chan /
mut コンテナ）は等式、imm コンテナは region の緩みだけ、ラッパは成分へ分配 -/

theorem Ty.sub_int_inv {tb : Ty} (hs : Ty.sub .int tb = true) : tb = .int := by
  cases tb <;> simp [Ty.sub] at hs <;> rfl

theorem Ty.sub_tvar_inv {i : Nat} {tb : Ty} (hs : Ty.sub (.tvar i) tb = true) : tb = .tvar i := by
  cases tb <;> simp [Ty.sub] at hs <;> simp [hs]

theorem Ty.sub_bool_inv {tb : Ty} (hs : Ty.sub .bool tb = true) : tb = .bool := by
  cases tb <;> simp [Ty.sub] at hs <;> rfl

theorem Ty.sub_byte_inv {tb : Ty} (hs : Ty.sub .byte tb = true) : tb = .byte := by
  cases tb <;> simp [Ty.sub] at hs <;> rfl

theorem Ty.sub_f64_inv {tb : Ty} (hs : Ty.sub .f64 tb = true) : tb = .f64 := by
  cases tb <;> simp [Ty.sub] at hs <;> rfl

theorem Ty.sub_unit_inv {tb : Ty} (hs : Ty.sub .unit tb = true) : tb = .unit := by
  cases tb <;> simp [Ty.sub] at hs <;> rfl

theorem Ty.sub_chan_inv {rc : Nat} {t tb : Ty} (hs : Ty.sub (.chan rc t) tb = true) :
    tb = .chan rc t := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl⟩ := hs; rfl

theorem Ty.sub_own_inv {k : OwnK} {r : Nat} {t tb : Ty} (hs : Ty.sub (.own k r t) tb = true) :
    tb = .own k r t := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl, rfl⟩ := hs; rfl

theorem Ty.sub_fn_inv {p r tb : Ty} (hs : Ty.sub (.fn p r) tb = true) :
    tb = .fn p r := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl⟩ := hs; rfl

theorem Ty.sub_opt_inv {t tb : Ty} (hs : Ty.sub (.opt t) tb = true) :
    ∃ t', tb = .opt t' ∧ Ty.sub t t' = true := by
  cases tb <;> simp only [Ty.sub, decide_eq_true_eq, reduceCtorEq] at hs
  · exact ⟨_, rfl, hs⟩

theorem Ty.sub_union_inv {l r tb : Ty} (hs : Ty.sub (.union l r) tb = true) :
    ∃ l' r', tb = .union l' r' ∧ Ty.sub l l' = true ∧ Ty.sub r r' = true := by
  cases tb <;> simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq, reduceCtorEq] at hs
  · exact ⟨_, _, rfl, hs.1, hs.2⟩

theorem Ty.sub_prod_inv {l r tb : Ty} (hs : Ty.sub (.prod l r) tb = true) :
    ∃ l' r', tb = .prod l' r' ∧ Ty.sub l l' = true ∧ Ty.sub r r' = true := by
  cases tb <;> simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq, reduceCtorEq] at hs
  · exact ⟨_, _, rfl, hs.1, hs.2⟩

theorem Ty.sub_refT_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.ref true rt t) tb = true) :
    tb = .ref true rt t := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl, rfl⟩ := hs; rfl

theorem Ty.sub_sliceT_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.slice true rt t) tb = true) :
    tb = .slice true rt t := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl, rfl⟩ := hs; rfl

theorem Ty.sub_mapT_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.map true rt t) tb = true) :
    tb = .map true rt t := by
  cases tb <;> simp [Ty.sub] at hs
  · obtain ⟨rfl, rfl, rfl⟩ := hs; rfl

theorem Ty.sub_refF_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.ref false rt t) tb = true) :
    ∃ rt', tb = .ref false rt' t ∧ rt ≤ rt' := by
  cases tb <;> try simp [Ty.sub] at hs
  case ref m' rt' t' =>
    cases m' <;> simp [Ty.sub] at hs
    obtain ⟨hle, rfl⟩ := hs
    exact ⟨rt', rfl, hle⟩

theorem Ty.sub_sliceF_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.slice false rt t) tb = true) :
    ∃ rt' t', tb = .slice false rt' t' ∧ rt ≤ rt' ∧ Ty.sub t t' = true := by
  cases tb <;> try simp [Ty.sub] at hs
  case slice m' rt' t' =>
    cases m' <;> simp [Ty.sub] at hs
    exact ⟨rt', t', rfl, hs.1, hs.2⟩

theorem Ty.sub_mapF_inv {rt : Nat} {t tb : Ty} (hs : Ty.sub (.map false rt t) tb = true) :
    ∃ rt' t', tb = .map false rt' t' ∧ rt ≤ rt' ∧ Ty.sub t t' = true := by
  cases tb <;> try simp [Ty.sub] at hs
  case map m' rt' t' =>
    cases m' <;> simp [Ty.sub] at hs
    exact ⟨rt', t', rfl, hs.1, hs.2⟩

/-- sub の推移律（深い共変の読み出し: セル型 ≤ 要素型 ≤ 注釈型） -/
theorem Ty.sub_trans : ∀ {a b c : Ty}, Ty.sub a b = true → Ty.sub b c = true → Ty.sub a c = true
  | .int, _, _, h1, h2 => by obtain rfl := Ty.sub_int_inv h1; exact h2
  | .tvar _, _, _, h1, h2 => by obtain rfl := Ty.sub_tvar_inv h1; exact h2
  | .bool, _, _, h1, h2 => by obtain rfl := Ty.sub_bool_inv h1; exact h2
  | .byte, _, _, h1, h2 => by obtain rfl := Ty.sub_byte_inv h1; exact h2
  | .f64, _, _, h1, h2 => by obtain rfl := Ty.sub_f64_inv h1; exact h2
  | .unit, _, _, h1, h2 => by obtain rfl := Ty.sub_unit_inv h1; exact h2
  | .chan _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_chan_inv h1; exact h2
  | .own _ _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_own_inv h1; exact h2
  | .fn _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_fn_inv h1; exact h2
  | .opt a, _, _, h1, h2 => by
    obtain ⟨b, rfl, hb⟩ := Ty.sub_opt_inv h1
    obtain ⟨c, rfl, hc⟩ := Ty.sub_opt_inv h2
    simp only [Ty.sub]; exact Ty.sub_trans hb hc
  | .union a1 a2, _, _, h1, h2 => by
    obtain ⟨b1, b2, rfl, hb1, hb2⟩ := Ty.sub_union_inv h1
    obtain ⟨c1, c2, rfl, hc1, hc2⟩ := Ty.sub_union_inv h2
    simp only [Ty.sub, Bool.and_eq_true]; exact ⟨Ty.sub_trans hb1 hc1, Ty.sub_trans hb2 hc2⟩
  | .prod a1 a2, _, _, h1, h2 => by
    obtain ⟨b1, b2, rfl, hb1, hb2⟩ := Ty.sub_prod_inv h1
    obtain ⟨c1, c2, rfl, hc1, hc2⟩ := Ty.sub_prod_inv h2
    simp only [Ty.sub, Bool.and_eq_true]; exact ⟨Ty.sub_trans hb1 hc1, Ty.sub_trans hb2 hc2⟩
  | .ref true _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_refT_inv h1; exact h2
  | .slice true _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_sliceT_inv h1; exact h2
  | .map true _ _, _, _, h1, h2 => by obtain rfl := Ty.sub_mapT_inv h1; exact h2
  | .ref false _ _, _, _, h1, h2 => by
    obtain ⟨rb, rfl, hb⟩ := Ty.sub_refF_inv h1
    obtain ⟨rc, rfl, hc⟩ := Ty.sub_refF_inv h2
    simp [Ty.sub]; omega
  | .slice false _ a, _, _, h1, h2 => by
    obtain ⟨rb, b, rfl, hb, hab⟩ := Ty.sub_sliceF_inv h1
    obtain ⟨rc, c, rfl, hc, hbc⟩ := Ty.sub_sliceF_inv h2
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq]; exact ⟨by omega, Ty.sub_trans hab hbc⟩
  | .map false _ a, _, _, h1, h2 => by
    obtain ⟨rb, b, rfl, hb, hab⟩ := Ty.sub_mapF_inv h1
    obtain ⟨rc, c, rfl, hc, hbc⟩ := Ty.sub_mapF_inv h2
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq]; exact ⟨by omega, Ty.sub_trans hab hbc⟩

/-- sub とシフトの可換性: 両辺を同じ ρ でずらしても sub は保たれる
（シフト定理の call ケース） -/
theorem Ty.sub_shiftR {ρ : Nat} :
    ∀ {ta tb : Ty}, Ty.sub ta tb = true → Ty.sub (ta.shiftR ρ) (tb.shiftR ρ) = true
  | .opt t, .opt t', hs => by
    simp only [Ty.sub] at hs
    simp only [Ty.shiftR, Ty.sub]
    exact Ty.sub_shiftR hs
  | .union l r, .union l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.shiftR, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_shiftR hs.1, Ty.sub_shiftR hs.2⟩
  | .prod l r, .prod l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.shiftR, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_shiftR hs.1, Ty.sub_shiftR hs.2⟩
  | .ref false r t, .ref false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    obtain ⟨hle, rfl⟩ := hs
    simp only [Ty.shiftR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨by omega, trivial⟩
  | .slice false r t, .slice false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.shiftR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨by omega, Ty.sub_shiftR hs.2⟩
  | .map false r t, .map false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp only [Ty.shiftR, Ty.sub, Bool.and_eq_true, decide_eq_true_eq]
    exact ⟨by omega, Ty.sub_shiftR hs.2⟩
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

/-! ## 型代入（V3-2: Def の型パラメータ）

型引数は **loc-free かつ chan-free** な型に限る（tyArgOk）。region 座標を一切持たないので、
代入がシフト・relocR・escape 検査・mutFree と可換になり、region の議論に触れない。
region を含む型引数（`[]T` を T に入れる等）は後段の梯子 -/

/-- 型引数として許される型 -/
def Ty.tyArgOk (t : Ty) : Bool := t.regionsBelow 0 && t.chanFree

/-- 型引数リストの条件 -/
def Ty.tyArgsOk (ts : List Ty) : Bool := ts.all Ty.tyArgOk

/-- 型代入: tvar i を ts[i] に（範囲外は tvar のまま — DefsOk の tvarsBelow が排除する）。
fn のシグネチャの中へも入る（fnref の型適用が外側の tvar を運ぶため） -/
def Ty.tsubst (ts : List Ty) : Ty → Ty
  | .int => .int
  | .tvar i => (ts[i]?).getD (.tvar i)
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
  | .fn p r => .fn (p.tsubst ts) (r.tsubst ts)
  | .own k r t => .own k r (t.tsubst ts)

/-- tvar がすべて n 未満（Def のシグネチャの整形条件） -/
def Ty.tvarsBelow (n : Nat) : Ty → Bool
  | .int => true
  | .tvar i => decide (i < n)
  | .bool => true
  | .byte => true
  | .f64 => true
  | .unit => true
  | .opt t => t.tvarsBelow n
  | .union l r => l.tvarsBelow n && r.tvarsBelow n
  | .prod l r => l.tvarsBelow n && r.tvarsBelow n
  | .ref _ _ t => t.tvarsBelow n
  | .slice _ _ t => t.tvarsBelow n
  | .map _ _ t => t.tvarsBelow n
  | .chan _ t => t.tvarsBelow n
  | .fn p r => p.tvarsBelow n && r.tvarsBelow n
  | .own _ _ t => t.tvarsBelow n

theorem Ty.tyArgsOk_get {ts : List Ty} {i : Nat} {τ : Ty} (h : Ty.tyArgsOk ts = true)
    (hi : ts[i]? = some τ) : τ.tyArgOk = true := by
  simp only [Ty.tyArgsOk, List.all_eq_true] at h
  exact h τ (List.mem_of_getElem? hi)

/-- 型引数のシフト不動: region を持たないので -/
theorem Ty.shiftR_of_argOk {ρ : Nat} : ∀ {t : Ty}, t.tyArgOk = true → t.shiftR ρ = t
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at h
    simp [Ty.shiftR, Ty.shiftR_of_argOk (t := t) (by simp [Ty.tyArgOk, h])]
  | .union l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.shiftR, Ty.shiftR_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.shiftR_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .prod l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.shiftR, Ty.shiftR_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.shiftR_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .ref _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .slice _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .map _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .chan _ _, h => by simp [Ty.tyArgOk, Ty.chanFree] at h
  | .fn _ _, _ => rfl

theorem Ty.relocR_of_argOk {ρ : Nat} : ∀ {t : Ty}, t.tyArgOk = true → t.relocR ρ = t
  | .int, _ => rfl
  | .tvar _, _ => rfl
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree] at h
    simp [Ty.relocR, Ty.relocR_of_argOk (t := t) (by simp [Ty.tyArgOk, h])]
  | .union l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.relocR, Ty.relocR_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.relocR_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .prod l r, h => by
    simp only [Ty.tyArgOk, Ty.regionsBelow, Ty.chanFree, Bool.and_eq_true] at h
    simp [Ty.relocR, Ty.relocR_of_argOk (t := l) (by simp [Ty.tyArgOk, h]),
      Ty.relocR_of_argOk (t := r) (by simp [Ty.tyArgOk, h])]
  | .ref _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .slice _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .map _ _ _, h => by simp [Ty.tyArgOk, Ty.regionsBelow] at h
  | .chan _ _, h => by simp [Ty.tyArgOk, Ty.chanFree] at h
  | .fn _ _, _ => rfl

/-- 型引数リストのシフト不動（シフト定理の call / fnref ケース） -/
theorem Ty.map_shiftR_of_argsOk {ts : List Ty} {ρ : Nat} (h : Ty.tyArgsOk ts = true) :
    ts.map (Ty.shiftR ρ) = ts := by
  conv => rhs; rw [← List.map_id ts]
  apply List.map_congr_left
  intro τ hτ
  simp only [Ty.tyArgsOk, List.all_eq_true] at h
  exact Ty.shiftR_of_argOk (h τ hτ)

/-- tvar の代入先（型引数）は tyArgOk -/
theorem Ty.tsubst_tvar_argOk {ts : List Ty} (h : Ty.tyArgsOk ts = true) (i : Nat) :
    ((ts[i]?).getD (.tvar i)).tyArgOk = true := by
  cases hi : ts[i]? with
  | none => rfl
  | some τ => exact Ty.tyArgsOk_get h hi

theorem Ty.tsubst_shiftR {ts : List Ty} {ρ : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).shiftR ρ = (t.shiftR ρ).tsubst ts
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.shiftR]
    exact Ty.shiftR_of_argOk (Ty.tsubst_tvar_argOk h i)
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .union l r => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h l, Ty.tsubst_shiftR h r]
  | .prod l r => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h l, Ty.tsubst_shiftR h r]
  | .ref m r t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .slice m r t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .map m r t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .chan rc t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .own k r t => by simp [Ty.tsubst, Ty.shiftR, Ty.tsubst_shiftR h t]
  | .fn p r => rfl

theorem Ty.tsubst_relocR {ts : List Ty} {ρ : Nat} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).relocR ρ = (t.relocR ρ).tsubst ts
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.relocR]
    exact Ty.relocR_of_argOk (Ty.tsubst_tvar_argOk h i)
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.relocR, Ty.tsubst_relocR h t]
  | .union l r => by simp [Ty.tsubst, Ty.relocR, Ty.tsubst_relocR h l, Ty.tsubst_relocR h r]
  | .prod l r => by simp [Ty.tsubst, Ty.relocR, Ty.tsubst_relocR h l, Ty.tsubst_relocR h r]
  | .ref m r t => by cases m <;> simp [Ty.tsubst, Ty.relocR, Ty.tsubst_shiftR h t, Ty.tsubst_relocR h t]
  | .slice m r t => by cases m <;> simp [Ty.tsubst, Ty.relocR, Ty.tsubst_shiftR h t, Ty.tsubst_relocR h t]
  | .map m r t => by cases m <;> simp [Ty.tsubst, Ty.relocR, Ty.tsubst_shiftR h t, Ty.tsubst_relocR h t]
  | .chan rc t => by simp [Ty.tsubst, Ty.relocR, Ty.tsubst_shiftR h t]
  | .own k r t => by simp [Ty.tsubst, Ty.relocR, Ty.tsubst_shiftR h t]
  | .fn p r => rfl

theorem Ty.tsubst_regionsBelow {ts : List Ty} (h : Ty.tyArgsOk ts = true) :
    ∀ (t : Ty) (d : Nat), (t.tsubst ts).regionsBelow d = t.regionsBelow d
  | .int, _ => rfl
  | .tvar i, d => by
    simp only [Ty.tsubst, Ty.regionsBelow]
    have ha := Ty.tsubst_tvar_argOk h i
    simp only [Ty.tyArgOk, Bool.and_eq_true] at ha
    exact Ty.regionsBelow_mono (Nat.zero_le d) ha.1
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t d]
  | .union l r, d => by
    simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h l d, Ty.tsubst_regionsBelow h r d]
  | .prod l r, d => by
    simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h l d, Ty.tsubst_regionsBelow h r d]
  | .ref m r t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t d]
  | .slice m r t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t d]
  | .map m r t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t d]
  | .chan rc t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t rc]
  | .own k r t, d => by simp [Ty.tsubst, Ty.regionsBelow, Ty.tsubst_regionsBelow h t d]
  | .fn p r, _ => rfl

theorem Ty.tsubst_mutFree {ts : List Ty} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).mutFree = t.mutFree
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.mutFree]
    have ha := Ty.tsubst_tvar_argOk h i
    simp only [Ty.tyArgOk, Bool.and_eq_true] at ha
    exact Ty.mutFree_of_locFree ha.1
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h t]
  | .union l r => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h l, Ty.tsubst_mutFree h r]
  | .prod l r => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h l, Ty.tsubst_mutFree h r]
  | .ref m r t => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h t]
  | .slice m r t => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h t]
  | .map m r t => by simp [Ty.tsubst, Ty.mutFree, Ty.tsubst_mutFree h t]
  | .chan rc t => rfl
  | .own k r t => rfl
  | .fn p r => rfl

theorem Ty.tsubst_chanFree {ts : List Ty} (h : Ty.tyArgsOk ts = true) :
    ∀ t : Ty, (t.tsubst ts).chanFree = t.chanFree
  | .int => rfl
  | .tvar i => by
    simp only [Ty.tsubst, Ty.chanFree]
    have ha := Ty.tsubst_tvar_argOk h i
    simp only [Ty.tyArgOk, Bool.and_eq_true] at ha
    exact ha.2
  | .bool => rfl
  | .byte => rfl
  | .f64 => rfl
  | .unit => rfl
  | .opt t => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h t]
  | .union l r => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h l, Ty.tsubst_chanFree h r]
  | .prod l r => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h l, Ty.tsubst_chanFree h r]
  | .ref m r t => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h t]
  | .slice m r t => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h t]
  | .map m r t => by simp [Ty.tsubst, Ty.chanFree, Ty.tsubst_chanFree h t]
  | .chan rc t => rfl
  | .own k r t => rfl
  | .fn p r => rfl

/-- sub は代入で保たれる（sub が見るのは region 上界と構造の一致だけ） -/
theorem Ty.sub_tsubst {ts : List Ty} :
    ∀ {ta tb : Ty}, Ty.sub ta tb = true → Ty.sub (ta.tsubst ts) (tb.tsubst ts) = true
  | .opt t, .opt t', hs => by
    simp only [Ty.sub] at hs
    simp only [Ty.tsubst, Ty.sub]
    exact Ty.sub_tsubst hs
  | .union l r, .union l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.tsubst, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_tsubst hs.1, Ty.sub_tsubst hs.2⟩
  | .prod l r, .prod l' r', hs => by
    simp only [Ty.sub, Bool.and_eq_true] at hs
    simp only [Ty.tsubst, Ty.sub, Bool.and_eq_true]
    exact ⟨Ty.sub_tsubst hs.1, Ty.sub_tsubst hs.2⟩
  | .ref false r t, .ref false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    obtain ⟨hle, rfl⟩ := hs
    simp [Ty.tsubst, Ty.sub, hle]
  | .slice false r t, .slice false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp [Ty.tsubst, Ty.sub, hs.1, Ty.sub_tsubst hs.2]
  | .map false r t, .map false r' t', hs => by
    simp only [Ty.sub, Bool.and_eq_true, decide_eq_true_eq] at hs
    simp [Ty.tsubst, Ty.sub, hs.1, Ty.sub_tsubst hs.2]
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

/-- 代入の合成: シグネチャの tvar が ts' の範囲内なら、ts' で代入してから ts で代入するのは
ts' の各要素を ts で代入したもので一度に代入するのと同じ（ジェネリックがジェネリックを呼ぶ形） -/
theorem Ty.tsubst_comp {ts ts' : List Ty} :
    ∀ {t : Ty}, t.tvarsBelow ts'.length = true →
      (t.tsubst ts').tsubst ts = t.tsubst (ts'.map (Ty.tsubst ts))
  | .int, _ => rfl
  | .tvar i, h => by
    simp only [Ty.tvarsBelow, decide_eq_true_eq] at h
    simp [Ty.tsubst, List.getElem?_eq_getElem h]
  | .bool, _ => rfl
  | .byte, _ => rfl
  | .f64, _ => rfl
  | .unit, _ => rfl
  | .opt t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .union l r, h => by
    simp only [Ty.tvarsBelow, Bool.and_eq_true] at h; simp [Ty.tsubst, Ty.tsubst_comp h.1, Ty.tsubst_comp h.2]
  | .prod l r, h => by
    simp only [Ty.tvarsBelow, Bool.and_eq_true] at h; simp [Ty.tsubst, Ty.tsubst_comp h.1, Ty.tsubst_comp h.2]
  | .ref m r t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .slice m r t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .map m r t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .chan rc t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .own k r t, h => by simp only [Ty.tvarsBelow] at h; simp [Ty.tsubst, Ty.tsubst_comp h]
  | .fn p r, h => by
    simp only [Ty.tvarsBelow, Bool.and_eq_true] at h; simp [Ty.tsubst, Ty.tsubst_comp h.1, Ty.tsubst_comp h.2]

/-- 型引数を型引数で代入しても型引数（ジェネリックの入れ子呼び出しの ts の保存） -/
theorem Ty.tyArgsOk_map_tsubst {ts ts' : List Ty} (h : Ty.tyArgsOk ts = true)
    (h' : Ty.tyArgsOk ts' = true) : Ty.tyArgsOk (ts'.map (Ty.tsubst ts)) = true := by
  simp only [Ty.tyArgsOk, List.all_eq_true, List.mem_map] at h' ⊢
  rintro _ ⟨τ, hτ, rfl⟩
  have := h' τ hτ
  simp only [Ty.tyArgOk, Bool.and_eq_true] at this ⊢
  rw [Ty.tsubst_regionsBelow h, Ty.tsubst_chanFree h]
  exact this

/-- 送る値の型 te がチャネルのペイロード型 t と region を除いて一致する（P3b-4b — 送りで梱包するので region はどこでもよい）:
どちらも imm で chan を持たず、region を全部 0 へ締めると同じ -/
def Ty.payOk (te t : Ty) : Bool := te.mutFree && te.chanFree && t.mutFree && t.chanFree && decide (te.relocR 0 = t.relocR 0)

/-- spawn で子へ渡せる型（段 6 P1 — give: の口）: 端点（送り端 / 受け端 — 移す。ペイロードは imm で chan なし — P3b-4b）か、写せるデータ
（mutFree・旧 chan なし・scope の region rs 以下 — 写す）、その組 -/
def Ty.givable (rs : Nat) : Ty → Bool
  | .own .tx _ t => t.mutFree && t.chanFree
  | .own .rx _ t => t.mutFree && t.chanFree
  | .prod l r => Ty.givable rs l && Ty.givable rs r
  | t => t.mutFree && t.chanFree && t.regionsBelow (rs + 1)

/-- 引き渡しの後の型: 端点の家の region を子の region d へ（データはそのまま） -/
def Ty.rehome (d : Nat) : Ty → Ty
  | .own .tx _ t => .own .tx d t
  | .own .rx _ t => .own .rx d t
  | .prod l r => .prod (l.rehome d) (r.rehome d)
  | t => t

/-- 組でも端点でもない型の givable はデータの条件そのもの -/
theorem Ty.givable_eq_data {rs : Nat} {t : Ty} (hp : ∀ l r, t ≠ .prod l r) (ho : ∀ k r u, t ≠ .own k r u) :
    t.givable rs = (t.mutFree && t.chanFree && t.regionsBelow (rs + 1)) := by
  cases t with
  | prod l r => exact absurd rfl (hp l r)
  | own k r u => exact absurd rfl (ho k r u)
  | _ => rfl

/-- int × int → int の演算子ファミリ（add は歴史的に独立コンストラクタのまま）。
1 演算子 1 コンストラクタにしないのは証明の場合分けを演算子数に比例させないため -/
inductive ArithOp : Type where
  | sub
  | mul
  /-- 切り捨て除算（Int.tdiv。x86 idiv と一致）。除数 0 は panic -/
  | div
  /-- 切り捨て剰余（Int.tmod。符号は被除数に従う）。除数 0 は panic -/
  | mod
  /-- ビット AND（2 の補数。値が 64bit に収まる限り x86 and と一致 — add と同じ約束） -/
  | land
  /-- ビット OR -/
  | lor
  /-- ビット XOR -/
  | lxor
  /-- 左シフト（Go 準拠: count ≥ 64 は 0、負の count は panic） -/
  | shl
  /-- 算術右シフト（floor。count ≥ 64 は 0 / -1 — unbounded Int の floor がそのまま一致）。負の count は panic -/
  | shr
  deriving DecidableEq, Repr

/-- int × int → bool の演算子ファミリ（lt は独立コンストラクタのまま） -/
inductive CmpOp : Type where
  | eq
  | ne
  | le
  | gt
  | ge
  deriving DecidableEq, Repr

/-- float64 × float64 → float64 の演算子（float の段 — language.md 37 節）。値は IEEE 754（F64.arith — opaque） -/
inductive FArithOp : Type where
  | add
  | sub
  | mul
  | div
  deriving DecidableEq, Repr

/-- float64 × float64 → bool の比較（IEEE — NaN は ne だけ真。値は F64.cmp — opaque） -/
inductive FCmpOp : Type where
  | eq
  | ne
  | lt
  | le
  | gt
  | ge
  deriving DecidableEq, Repr

/-- float64 の単項の写し（float の段）。定義域と値域は op が決める（FConvOp.dom / cod） -/
inductive FConvOp : Type where
  /-- 符号の反転（f64 → f64） -/
  | neg
  /-- 平方根（f64 → f64 — sqrtsd） -/
  | sqrt
  /-- `float64(i)`（int → f64） -/
  | ofInt
  /-- `int(f)`（f64 → int — 0 方向の切り捨て。NaN・範囲外は panic） -/
  | toInt
  /-- math.Bits（f64 → int — ビット列の読み替え） -/
  | bits
  /-- math.FromBits（int → f64） -/
  | fromBits
  deriving DecidableEq, Repr

/-- FConvOp の定義域（被演算子の型） -/
def FConvOp.dom : FConvOp → Ty
  | .neg | .sqrt | .toInt | .bits => .f64
  | .ofInt | .fromBits => .int

/-- FConvOp の値域（結果の型） -/
def FConvOp.cod : FConvOp → Ty
  | .neg | .sqrt | .ofInt | .fromBits => .f64
  | .toInt | .bits => .int

/-- 式。値を持たない文は無い（Sober の式指向）。
`nil t` / `inl r e` / `inr l e` の型注釈は型付けを構文主導にするためのもので、
Sober のソースでは双方向推論が埋める（脱糖器 = Zig 側の仕事） -/
inductive Expr : Type where
  | lit (n : Int)
  | tt
  | ff
  /-- unit 値（Sober の none） -/
  | triv
  | var (i : Nat)
  /-- `x := e; body`。body の中で x は var 0 -/
  | letE (e body : Expr)
  | add (a b : Expr)
  | lt (a b : Expr)
  /-- int × int → int（sub / mul / div / mod）。div / mod の除数 0 は panic -/
  | arith (op : ArithOp) (a b : Expr)
  /-- int × int → bool（eq / ne / le / gt / ge） -/
  | cmp (op : CmpOp) (a b : Expr)
  | ite (c t e : Expr)
  | nil (t : Ty)
  | some (e : Expr)
  /-- `if e != nil { someCase（var 0 = 中身）} else { nilCase }`。flow typing のコア形 -/
  | ifnil (e nilCase someCase : Expr)
  | inl (r : Ty) (e : Expr)
  | inr (l : Ty) (e : Expr)
  /-- `switch e { case L{x}: l  case R{x}: r }`。各腕で中身は var 0 -/
  | case (e l r : Expr)
  /-- 直積の構築。struct リテラルは右結合の pair 鎖（評価はフィールド順） -/
  | pair (a b : Expr)
  | fst (e : Expr)
  | snd (e : Expr)
  /-- 一階関数の呼び出し `call fn e`。fn は関数表 Δ の index、引数は 1 つ
  （多引数は脱糖器が struct に束ねる）。本体は自前ヒープの入れ子世界で走る（par と同型） -/
  | call (fn : Nat) (ts : List Ty) (e : Expr)
  /-- anchor つき呼び出し（R2 = region 多相の裁定 Q）: `call` と同じだが、Def の region 0
  （圧縮された呼び手空間 = 暗黙の region 変数）を呼び手最内でなく、引数の mut 位置の region
  （anchor）で instantiate する。mut 引数の関数を展開せず Def として呼ぶ形（再帰する mut 引数の関数）。
  anchor は引数の型から読む（構文主導のまま — `Ty.anchorOf`） -/
  | callM (fn : Nat) (ts : List Ty) (e : Expr)
  /-- 閉じた関数値（V3-1）: 関数表 Δ の index への参照。環境を持たない（捕捉なし）ので
  loc-free な値。辞書定数（関数型フィールドの struct）はこの値の pair 鎖 -/
  | fnref (fn : Nat) (ts : List Ty)
  /-- 関数値の呼び出し `callv f e`。f を値（fnref）にしてから e を値にし、
  `call` へ 1 歩で委譲する（世界の機構は call と共有） -/
  | callv (f e : Expr)
  /-- anchor つきの関数値の呼び出し `callMv a f e`（L1 — 借りの閉包の mut 捕捉・formal.md「callMv の段」）。callv と同じく f → e の順に値にし、
  fnref なら callM の本体の入口へ委譲する。anchor a は構文の region の注釈（copyTo k と同じく shiftTy / renTy で写る）— env の union の
  片方の variant の中の mut は Ty.anchorOf / anchorV に見えないので、型からでなく注釈で持つ -/
  | callMv (a : Nat) (f e : Expr)
  /-- 型注釈 `ann e t`（V3-5）: e の型 ta を部分型 t へ緩める（`Ty.sub ta t`）。値は変えない
  （機械は注釈値だけ coerceTo で書き換える — call の引数境界と同じ）。脱糖器が inline 展開で
  消える仮引数の型・ラムダの引数 / 結果型を書き込み、検査を Lean に返すための op。
  座標は注釈を置いた点の座標（写像は脱糖器の仕事、Lean は sub を検査するだけ） -/
  | ann (e : Expr) (t : Ty)
  /-- region 境界のブロック。実行で region を push し、値になったら pop（term 変数は束縛しない） -/
  | block (e : Expr)
  /-- 出口で値を写すブロック（R5 — 普通の出口の対称化）: 本体を block と同じく 1 段深い region で評価し、値になったら
  ブロックの region の imm コンテナを中身ごと親の最内 region へ写してから pop する（jump の脱出と同じ境界コピー）。
  t は結果型の注釈（ラベルの型と同じ役 — relocTo が歩く型） -/
  | blockR (t : Ty) (e : Expr)
  /-- 境界コピー式（宛先構築レーン M3 — scope-draft 6 節）: e の値を外側の region k へ写す（imm コンテナは中身ごと region k の末尾へ積み直す —
  blockR の出口の写しから region の pop を除いたもの・機械は relocTo k）。結果は region k 以下の型 t（relocTo が歩く型）。
  スコープ（ループ本体のブロック・mut 関数の本体）の中で作った値を外のスコープの mut セル / コンテナへ格納する前に掛ける —
  格納は既存の assign / append / setm のまま（値の型がセルの region 以下になる）。k は絶対の region 添字（shiftTy / renTy で型の region と同じに写る） -/
  | copyTo (k : Nat) (t : Ty) (e : Expr)
  /-- 脱出先のラベル（V4）: 本体 e をラベル環境 Λ' = t :: Λ で評価し、正常完了も `jump 0 v` も
  値 t で抜ける。return / break / continue / `?` を 1 機構で受ける -/
  | label (t : Ty) (e : Expr)
  /-- n 番目（de Bruijn、0 = 最内）のラベルへ e の値を持って脱出する。式としては戻らないので
  結果型は任意 — t はそれを構文主導に決める注釈（nil t / inl r と同じ。V4-2 裁定 J1）。
  途中の region は巻き戻しで pop する -/
  | jump (n : Nat) (t : Ty) (e : Expr)
  /-- 到達しない（error 網羅 analyzer A5 — language.md 13 節）: analyzer が導出集合で網羅を認めた error の switch の、
  覆っていない variant の腕。評価に来たら panic（27 節の「到達 = バグ」— ゼロ除算・タグ検査と同じ終端）。値を作らないので
  結果型は任意 — t はそれを構文主導に決める注釈（jump と同じ — V4-2 裁定 J1） -/
  | unreach (t : Ty)
  /-- 現在（最内）の region への割り当て。参照を返す（m = mut フラグ） -/
  | alloc (m : Bool) (e : Expr)
  /-- `!r` -/
  | deref (e : Expr)
  /-- `r := e`（mut 参照への書き込み）。unit を返す -/
  | assign (l e : Expr)
  /-- `while c { b }`。unit を返す（b の値は捨てる） -/
  | whileE (c b : Expr)
  /-- mut 参照を immutable 参照に変換し、セルのタグを倒す（freeze）。
  古い mut エイリアスは型が付いたまま残るが、実行時のタグ検査（assign）が panic で受ける。
  slice にも適用でき、覆う範囲のセルのタグをまとめて倒す（language.md 21 節） -/
  | freeze (e : Expr)
  /-- 空 slice を最内 region に作る（base = region の現在長）。型注釈は構文主導のため -/
  | mkslice (m : Bool) (t : Ty)
  /-- string リテラル（strlit の段）: バイト列 bs を region r の imm byte セル列として作る。r は注釈（型の座標 —
  shiftTy / renTy で写る）。Def 本体では r = 0（呼び手空間 — call で呼び手の最内、callM で anchor へ写る）。
  機械は `freeze (strCells bs (slicev true r len 0))` へ書き換え、セルは appendM の歩が積む（codegen は rodata — imm なので観測同値） -/
  | strlit (bs : List Int) (r : Nat)
  /-- 空 slice を region r に作る（宛先構築レーン M3b — mut の宛先構築の原始操作）: mkslice の region 指定版（strlit と同じく r は注釈 —
  外のスコープの mut 場所へ流れ込む新しい mut コンテナを、最初から行き先の region に作る。mut は relocTo で写せないので
  反復の region・mut 関数の本体からは、この形でしか外の場所へ置けない） -/
  | mksliceAt (m : Bool) (t : Ty) (r : Nat)
  /-- 空 map を region r に作る（mkmap の region 指定版 — mksliceAt と同型） -/
  | mkmapAt (m : Bool) (t : Ty) (r : Nat)
  /-- `xs[i]`。範囲外は panic（暫定 — language.md 21 節）。ot は読み出しの型注釈（R4b-cov A-2）: imm セルは要素型の
  部分型で置かれうる（深い共変）ので、注釈つきなら読んだ値を coerceTo で注釈型へ書き換える。注釈なしは
  注釈を持たない要素型（annFree）か mut slice（セル型が正確）に限る -/
  | index (e i : Expr) (ot : Option Ty := none)
  /-- `len(xs)` -/
  | lenE (e : Expr)
  /-- `byte(e)`（byte の段 — language.md 33 節）: int → byte。0 ≤ n < 256 なら blit n、範囲外は panic -/
  | tobyte (e : Expr)
  /-- `int(e)`: byte → int（値を変えない — blit n を lit n に） -/
  | toint (e : Expr)
  /-- byte の値（実行時にのみ現れる — ソース項でない。ソースの byte は tobyte で作る）。型付けは 0 ≤ n < 256 -/
  | blit (n : Int)
  /-- float64 の値（ビット列 n — float の段・language.md 37 節）。ソースのリテラルも実行時の値もこの項（型は f64 だけ） -/
  | flit (n : Int)
  /-- float64 × float64 → float64 -/
  | farith (op : FArithOp) (a b : Expr)
  /-- float64 × float64 → bool -/
  | fcmp (op : FCmpOp) (a b : Expr)
  /-- float64 の単項の写し（neg / sqrt / ofInt / toInt / bits / fromBits） -/
  | fconv (op : FConvOp) (e : Expr)
  /-- `append(xs, v)`。slice 末尾が region の bump 先端なら 1 セル伸長、
  そうでなければ region r の先端へ全コピー + 1 セル（新しいヘッダを返す） -/
  | append (e v : Expr)
  /-- `xs[i] = v`。mut slice のみ（タグ検査は assign と同じ動的な底）。unit を返す -/
  | setidx (e i v : Expr)
  /-- `xs[a:b]`（imm slice / string 限定 — language.md 21 節）。同じセル列を指す
  新ヘッダ（ptr+a、len = b−a、割り当てゼロ）。範囲違反（0 ≤ a ≤ b ≤ len 以外）は panic -/
  | subslice (e a c : Expr)
  /-- `s == t`（string = imm byte slice の比較 — language.md 21 節）。
  長さ一致 + 全セル等値で tt。構造的等価の一般化は辞書（Eq[T]）の領分なので int セル限定 -/
  | eqs (e1 e2 : Expr)
  /-- `s + t`（imm slice の連結 — language.md 21 節)。最内 region に
  len1 + len2 セルの新 slice を作る（appendI と同じ床） -/
  | concat (e1 e2 : Expr)
  /-- 空 map を最内 region に作る（mkslice と同型）。language.md 22 節 -/
  | mkmap (m : Bool) (t : Ty)
  /-- `m[k]`。opt t を返す（不在 = nil。t 注釈は不在時の nil 構築のため — 構文主導） -/
  | getm (t : Ty) (e k : Expr)
  /-- `m[k] = v`。既存キーは in-place 更新（タグ検査つき）、新規キーは append と同じ
  「先端 1 セル / 全コピー」。新しいヘッダを返す -/
  | setm (e k v : Expr)
  /-- `delete(m, k)`。墓石（nil）を in-place で書く。不在は no-op。unit を返す -/
  | delm (t : Ty) (e k : Expr)
  /-- `len(m)`。生きたエントリ（墓石以外）の数 -/
  | lenm (e : Expr)
  /-- `keys(m)`（keysm の段）: 生きたキーの挿入順の列を最内 region に imm slice として作る（スナップショット） -/
  | keysm (e : Expr)
  /-- `clone(x)`（clone の段 — freeze の双対）: slice / map のセル列を最内 region へ mut のセルとして写した浅い写し。
  ot は読み出しの注釈（index と同じ — imm のセルの部分型を写す先の型へ揃える） -/
  | clone (ot : Option Ty) (e : Expr)
  /-- `parallel scope { spawn e1; spawn e2 }` の最小形。両方走らせて join、unit を返す -/
  | par (e1 e2 : Expr)
  /-- チャネルつき並列スコープ: 共有上界 rc = spawn 深度のチャネルを作り、
  両タスクに var 0 として渡して spawn（段 3d）。親の続きにはチャネルは残らない。
  b < rc の世界の単独 newchan ではスナップショットが安定しないため、生成と spawn を融合する -/
  | parch (t : Ty) (e1 e2 : Expr)
  /-- 新しいチャネルを作る（ペイロードの参照は region < rc 限定。rc ≤ 書き込み床 f）。
  rc は脱糖器が計算するコア AST の注釈。チャネル値を返す -/
  | newchan (rc : Nat) (t : Ty)
  /-- `c <- e`（送信）。無限バッファなので常に進む。unit を返す -/
  | send (c e : Expr)
  /-- `<-c`（受信）。キューが空なら待つ（blocked） -/
  | recv (c : Expr)
  /-- 実行時のみ: region レベル r のアドレス a への参照。ソースには現れない -/
  | loc (r a : Nat)
  /-- 実行時のみ: slice ヘッダ（実行時タグ mt, region r, 開始 base, 長さ len）。
  mt は freeze 済みかの値側の写し（新セルのタグ決めに使う）。ソースには現れない -/
  | slicev (mt : Bool) (r base len : Nat)
  /-- 実行時のみ: map ヘッダ（slicev と同型。セルは pair (lit k) w、w : opt t）。
  ソースには現れない -/
  | mapv (mt : Bool) (r base len : Nat)
  /-- 実行時のみ: チャネル id c への参照。ソースには現れない -/
  | chanV (c : Nat)
  /-- 構造化スコープ（段 6 P1 — par.Scope）: region を 1 段開き、本体を var 0 = scope の札（scopeV d）で評価する。
  出口はその scope で spawn した子が全部 完了 か 死 になるまで待ち（寿命結合）、死があれば `inr t triv`（死を値にする — P3a 揉みどころ A = A1 (X)・
  未回収の死は scope の err で TaskDied）。無ければ値を blockR と同じく親の最内 region へ写して `inl unit v`（t = 結果型の注釈・式の型は `union t unit`）。本体はラベルを越えない（Λ = []） -/
  | scope (t ε : Ty) (e : Expr)
  /-- 子の task を生む（par.Spawn）: sc = scope の札、a = 子へ渡す値（give: の口 — データは写す。P1 は mutFree・chan なし・scope の region 以下）、
  e = 子の本体（**閉じている** — var 0 = a の値だけを見る。親の文脈を捕獲しないので、捕獲の検査は渡す値の型 1 つに集まる）。handle を返す。
  子は親ヒープのコピー + 自前の region で走る（旧 par と同型）。shift / subst は閉じた本体 e に入らない -/
  | spawn (sc a e : Expr)
  /-- handle の結果を待つ（par.Join）。子が死んでいれば親が死ぬ（Join の先は走らない）。t = 結果型の注釈
  （P3b-4 — 子の結果を scope の region へ写すときに歩く型。tryJ と同じ） -/
  | join (t : Ty) (h : Expr)
  /-- 死を値として見る（par.Try）: 完了なら some v、死なら nil t（t は注釈）。死を吸収はしない — scope は出口で TaskDied に失敗する -/
  | tryJ (t : Ty) (h : Expr)
  /-- 実行時のみ: region rs に開いた scope の札。ソースには現れない -/
  | scopeV (rs : Nat) (ε : Ty)
  /-- 実行時のみ: scope rs の n 番目の子の handle（n = 生んだ task の子の通し番号）。ソースには現れない -/
  | taskV (rs n : Nat)
  /-- 端点のチャネルを作る（段 6 P1 — par.NewChan）: 送り端と受け端の組を返す。r = 端点の家の region（今の世界のもの）・cap = 容量（1 以上）・
  t = ペイロード型（P1 は loc-free）。鍵は生成元の task id + その task の局所の通し番号（決定的）。持ち主は作った task -/
  | newch (r cap : Nat) (t : Ty)
  /-- 実行時のみ: 端点の値（鍵 (p, k)・tx = 送り端か・家の region r）。ソースには現れない -/
  | epV (p : List Nat) (k : Nat) (tx : Bool) (r : Nat)
  /-- 送り端を閉じる（par.Close — P3b-4 ③）: 以後の受けは、キューが空になったら nil（閉じた後の送り・二度目の close は定義された panic） -/
  | close (c : Expr)
  deriving Repr, DecidableEq

/-- 一階関数の定義。引数は 1 つ（多引数は脱糖器が struct に束ねる。formal.md）。
本体では引数が var 0。param / ret は loc-free（DefsOk が要求） -/
structure Def where
  param : Ty
  ret : Ty
  body : Expr
  /-- 型パラメータの個数（V3-2）。本体・シグネチャでは tvar 0 .. tparams-1 として現れる -/
  tparams : Nat := 0
  deriving Repr, DecidableEq

/-- 関数表。call の index が引く。プログラムごとに固定 -/
abbrev Defs := List Def

namespace Expr

/-- c 以上の自由変数を 1 つずらす（束縛の下に値を持ち込むとき用） -/
def shift (c : Nat) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => if i < c then var i else var (i + 1)
  | letE e b => letE (shift c e) (shift (c + 1) b)
  | add a b => add (shift c a) (shift c b)
  | lt a b => lt (shift c a) (shift c b)
  | arith op a b => arith op (shift c a) (shift c b)
  | farith op a b => farith op (shift c a) (shift c b)
  | fcmp op a b => fcmp op (shift c a) (shift c b)
  | cmp op a b => cmp op (shift c a) (shift c b)
  | ite c' t e => ite (shift c c') (shift c t) (shift c e)
  | nil t => nil t
  | some e => some (shift c e)
  | ifnil e n s => ifnil (shift c e) (shift c n) (shift (c + 1) s)
  | inl r e => inl r (shift c e)
  | inr l e => inr l (shift c e)
  | case e l r => case (shift c e) (shift (c + 1) l) (shift (c + 1) r)
  | pair a b => pair (shift c a) (shift c b)
  | fst e => fst (shift c e)
  | snd e => snd (shift c e)
  | call fn ts e => call fn ts (shift c e)
  | callM fn ts e => callM fn ts (shift c e)
  | fnref fn ts => fnref fn ts
  | callv f e => callv (shift c f) (shift c e)
  | callMv a f e => callMv a (shift c f) (shift c e)
  | ann e t => ann (shift c e) t
  | block e => block (shift c e)
  | blockR t e => blockR t (shift c e)
  | copyTo k t e => copyTo k t (shift c e)
  | label t e => label t (shift c e)
  | jump n t e => jump n t (shift c e)
  | unreach t => unreach t
  | alloc m e => alloc m (shift c e)
  | deref e => deref (shift c e)
  | assign l e => assign (shift c l) (shift c e)
  | whileE c' b => whileE (shift c c') (shift c b)
  | freeze e => freeze (shift c e)
  | mkslice m t => mkslice m t
  | strlit bs r => strlit bs r
  | mksliceAt m t r => mksliceAt m t r
  | mkmapAt m t r => mkmapAt m t r
  | index e i ot => index (shift c e) (shift c i) ot
  | lenE e => lenE (shift c e)
  | tobyte e => tobyte (shift c e)
  | fconv op e => fconv op (shift c e)
  | toint e => toint (shift c e)
  | append e v => append (shift c e) (shift c v)
  | setidx e i v => setidx (shift c e) (shift c i) (shift c v)
  | subslice e sa sb => subslice (shift c e) (shift c sa) (shift c sb)
  | eqs e1 e2 => eqs (shift c e1) (shift c e2)
  | concat e1 e2 => concat (shift c e1) (shift c e2)
  | mkmap m t => mkmap m t
  | getm t e k => getm t (shift c e) (shift c k)
  | setm e k v => setm (shift c e) (shift c k) (shift c v)
  | delm t e k => delm t (shift c e) (shift c k)
  | lenm e => lenm (shift c e)
  | keysm e => keysm (shift c e)
  | clone ot e => clone ot (shift c e)
  | par e1 e2 => par (shift c e1) (shift c e2)
  | parch t e1 e2 => parch t (shift (c + 1) e1) (shift (c + 1) e2)
  | newchan rc t => newchan rc t
  | send ch e => send (shift c ch) (shift c e)
  | recv ch => recv (shift c ch)
  | close ch => close (shift c ch)
  | loc r a => loc r a
  | slicev mt r base len => slicev mt r base len
  | mapv mt r base len => mapv mt r base len
  | chanV ch => chanV ch
  | scope t ε e => scope t ε (shift (c + 1) e)
  | spawn sc a e => spawn (shift c sc) (shift c a) e
  | join t h => join t (shift c h)
  | tryJ t h => tryJ t (shift c h)
  | scopeV rs ε => scopeV rs ε
  | taskV rs n => taskV rs n
  | newch r cap t => newch r cap t
  | epV p k b r => epV p k b r

/-- var k を v で置き換え、k より上の自由変数を 1 つ下げる（束縛 1 つの消費） -/
def subst (k : Nat) (v : Expr) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => if i = k then v else if k < i then var (i - 1) else var i
  | letE e b => letE (subst k v e) (subst (k + 1) (shift 0 v) b)
  | add a b => add (subst k v a) (subst k v b)
  | lt a b => lt (subst k v a) (subst k v b)
  | arith op a b => arith op (subst k v a) (subst k v b)
  | farith op a b => farith op (subst k v a) (subst k v b)
  | fcmp op a b => fcmp op (subst k v a) (subst k v b)
  | cmp op a b => cmp op (subst k v a) (subst k v b)
  | ite c t e => ite (subst k v c) (subst k v t) (subst k v e)
  | nil t => nil t
  | some e => some (subst k v e)
  | ifnil e n s => ifnil (subst k v e) (subst k v n) (subst (k + 1) (shift 0 v) s)
  | inl r e => inl r (subst k v e)
  | inr l e => inr l (subst k v e)
  | case e l r => case (subst k v e) (subst (k + 1) (shift 0 v) l) (subst (k + 1) (shift 0 v) r)
  | pair a b => pair (subst k v a) (subst k v b)
  | fst e => fst (subst k v e)
  | snd e => snd (subst k v e)
  | call fn ts e => call fn ts (subst k v e)
  | callM fn ts e => callM fn ts (subst k v e)
  | fnref fn ts => fnref fn ts
  | callv f e => callv (subst k v f) (subst k v e)
  | callMv a f e => callMv a (subst k v f) (subst k v e)
  | ann e t => ann (subst k v e) t
  | block e => block (subst k v e)
  | blockR t e => blockR t (subst k v e)
  | copyTo k' t e => copyTo k' t (subst k v e)
  | label t e => label t (subst k v e)
  | jump n t e => jump n t (subst k v e)
  | unreach t => unreach t
  | alloc m e => alloc m (subst k v e)
  | deref e => deref (subst k v e)
  | assign l e => assign (subst k v l) (subst k v e)
  | whileE c b => whileE (subst k v c) (subst k v b)
  | freeze e => freeze (subst k v e)
  | mkslice m t => mkslice m t
  | strlit bs r => strlit bs r
  | mksliceAt m t r => mksliceAt m t r
  | mkmapAt m t r => mkmapAt m t r
  | index e i ot => index (subst k v e) (subst k v i) ot
  | lenE e => lenE (subst k v e)
  | tobyte e => tobyte (subst k v e)
  | fconv op e => fconv op (subst k v e)
  | toint e => toint (subst k v e)
  | append e w => append (subst k v e) (subst k v w)
  | setidx e i w => setidx (subst k v e) (subst k v i) (subst k v w)
  | subslice e sa sb => subslice (subst k v e) (subst k v sa) (subst k v sb)
  | eqs e1 e2 => eqs (subst k v e1) (subst k v e2)
  | concat e1 e2 => concat (subst k v e1) (subst k v e2)
  | mkmap m t => mkmap m t
  | getm t e kk => getm t (subst k v e) (subst k v kk)
  | setm e kk w => setm (subst k v e) (subst k v kk) (subst k v w)
  | delm t e kk => delm t (subst k v e) (subst k v kk)
  | lenm e => lenm (subst k v e)
  | keysm e => keysm (subst k v e)
  | clone ot e => clone ot (subst k v e)
  | par e1 e2 => par (subst k v e1) (subst k v e2)
  | parch t e1 e2 =>
      parch t (subst (k + 1) (shift 0 v) e1) (subst (k + 1) (shift 0 v) e2)
  | newchan rc t => newchan rc t
  | send c e => send (subst k v c) (subst k v e)
  | recv c => recv (subst k v c)
  | close c => close (subst k v c)
  | loc r a => loc r a
  | slicev mt r base len => slicev mt r base len
  | mapv mt r base len => mapv mt r base len
  | chanV c => chanV c
  | scope t ε e => scope t ε (subst (k + 1) (shift 0 v) e)
  | spawn sc a e => spawn (subst k v sc) (subst k v a) e
  | join t h => join t (subst k v h)
  | tryJ t h => tryJ t (subst k v h)
  | scopeV rs ε => scopeV rs ε
  | taskV rs n => taskV rs n
  | newch r cap t => newch r cap t
  | epV p k b r => epV p k b r

/-- 項に埋まった型注釈・region 注釈への一様シフト +ρ（round4: call の instantiate）。
ソース項の注釈（nil / inl / inr / mkslice / getm / delm / mkmap / newchan / parch）に
Ty.shiftR を掛け、実行時項（loc / slicev / mapv）は region 添字をずらす
（値の世界渡しでも同じシフトで一貫する）。chanV はチャネル id なので不変 -/
def shiftTy (ρ : Nat) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => var i
  | letE e b => letE (shiftTy ρ e) (shiftTy ρ b)
  | add a b => add (shiftTy ρ a) (shiftTy ρ b)
  | lt a b => lt (shiftTy ρ a) (shiftTy ρ b)
  | arith op a b => arith op (shiftTy ρ a) (shiftTy ρ b)
  | farith op a b => farith op (shiftTy ρ a) (shiftTy ρ b)
  | fcmp op a b => fcmp op (shiftTy ρ a) (shiftTy ρ b)
  | cmp op a b => cmp op (shiftTy ρ a) (shiftTy ρ b)
  | ite c t e => ite (shiftTy ρ c) (shiftTy ρ t) (shiftTy ρ e)
  | nil t => nil (t.shiftR ρ)
  | some e => some (shiftTy ρ e)
  | ifnil e n s => ifnil (shiftTy ρ e) (shiftTy ρ n) (shiftTy ρ s)
  | inl r e => inl (r.shiftR ρ) (shiftTy ρ e)
  | inr l e => inr (l.shiftR ρ) (shiftTy ρ e)
  | case e l r => case (shiftTy ρ e) (shiftTy ρ l) (shiftTy ρ r)
  | pair a b => pair (shiftTy ρ a) (shiftTy ρ b)
  | fst e => fst (shiftTy ρ e)
  | snd e => snd (shiftTy ρ e)
  | call fn ts e => call fn (ts.map (Ty.shiftR ρ)) (shiftTy ρ e)
  | callM fn ts e => callM fn (ts.map (Ty.shiftR ρ)) (shiftTy ρ e)
  | fnref fn ts => fnref fn (ts.map (Ty.shiftR ρ))
  | callv f e => callv (shiftTy ρ f) (shiftTy ρ e)
  | callMv a f e => callMv (a + ρ) (shiftTy ρ f) (shiftTy ρ e)
  | ann e t => ann (shiftTy ρ e) (t.shiftR ρ)
  | block e => block (shiftTy ρ e)
  | blockR t e => blockR (t.shiftR ρ) (shiftTy ρ e)
  | copyTo k t e => copyTo (k + ρ) (t.shiftR ρ) (shiftTy ρ e)
  | label t e => label (t.shiftR ρ) (shiftTy ρ e)
  | jump n t e => jump n (t.shiftR ρ) (shiftTy ρ e)
  | unreach t => unreach (t.shiftR ρ)
  | alloc m e => alloc m (shiftTy ρ e)
  | deref e => deref (shiftTy ρ e)
  | assign l e => assign (shiftTy ρ l) (shiftTy ρ e)
  | whileE c b => whileE (shiftTy ρ c) (shiftTy ρ b)
  | freeze e => freeze (shiftTy ρ e)
  | mkslice m t => mkslice m (t.shiftR ρ)
  | strlit bs r => strlit bs (r + ρ)
  | mksliceAt m t r => mksliceAt m (t.shiftR ρ) (r + ρ)
  | mkmapAt m t r => mkmapAt m (t.shiftR ρ) (r + ρ)
  | index e i ot => index (shiftTy ρ e) (shiftTy ρ i) (ot.map (Ty.shiftR ρ))
  | lenE e => lenE (shiftTy ρ e)
  | tobyte e => tobyte (shiftTy ρ e)
  | fconv op e => fconv op (shiftTy ρ e)
  | toint e => toint (shiftTy ρ e)
  | append e w => append (shiftTy ρ e) (shiftTy ρ w)
  | setidx e i w => setidx (shiftTy ρ e) (shiftTy ρ i) (shiftTy ρ w)
  | subslice e sa sb => subslice (shiftTy ρ e) (shiftTy ρ sa) (shiftTy ρ sb)
  | eqs e1 e2 => eqs (shiftTy ρ e1) (shiftTy ρ e2)
  | concat e1 e2 => concat (shiftTy ρ e1) (shiftTy ρ e2)
  | mkmap m t => mkmap m (t.shiftR ρ)
  | getm t e k => getm (t.shiftR ρ) (shiftTy ρ e) (shiftTy ρ k)
  | setm e k w => setm (shiftTy ρ e) (shiftTy ρ k) (shiftTy ρ w)
  | delm t e k => delm (t.shiftR ρ) (shiftTy ρ e) (shiftTy ρ k)
  | lenm e => lenm (shiftTy ρ e)
  | keysm e => keysm (shiftTy ρ e)
  | clone ot e => clone (ot.map (Ty.shiftR ρ)) (shiftTy ρ e)
  | par e1 e2 => par (shiftTy ρ e1) (shiftTy ρ e2)
  | parch t e1 e2 => parch (t.shiftR ρ) (shiftTy ρ e1) (shiftTy ρ e2)
  | newchan rc t => newchan (rc + ρ) (t.shiftR ρ)
  | send c e => send (shiftTy ρ c) (shiftTy ρ e)
  | recv c => recv (shiftTy ρ c)
  | close c => close (shiftTy ρ c)
  | loc r a => loc (r + ρ) a
  | slicev mt r base len => slicev mt (r + ρ) base len
  | mapv mt r base len => mapv mt (r + ρ) base len
  | chanV c => chanV c
  | scope t ε e => scope (t.shiftR ρ) (ε.shiftR ρ) (shiftTy ρ e)
  | spawn sc a e => spawn (shiftTy ρ sc) (shiftTy ρ a) (shiftTy ρ e)
  | join t h => join (t.shiftR ρ) (shiftTy ρ h)
  | tryJ t h => tryJ (t.shiftR ρ) (shiftTy ρ h)
  | scopeV rs ε => scopeV (rs + ρ) (ε.shiftR ρ)
  | taskV rs n => taskV (rs + ρ) n
  | newch r cap t => newch (r + ρ) cap (t.shiftR ρ)
  | epV p k b r => epV p k b (r + ρ)

/-- 項の型注釈への型代入（V3-2: call の instantiate）。入れ子の call / fnref の型引数にも
掛ける。region 添字は触らない（型引数は region を持たない） -/
def tsubstTy (ts : List Ty) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => var i
  | letE e b => letE (tsubstTy ts e) (tsubstTy ts b)
  | add a b => add (tsubstTy ts a) (tsubstTy ts b)
  | lt a b => lt (tsubstTy ts a) (tsubstTy ts b)
  | arith op a b => arith op (tsubstTy ts a) (tsubstTy ts b)
  | farith op a b => farith op (tsubstTy ts a) (tsubstTy ts b)
  | fcmp op a b => fcmp op (tsubstTy ts a) (tsubstTy ts b)
  | cmp op a b => cmp op (tsubstTy ts a) (tsubstTy ts b)
  | ite c t e => ite (tsubstTy ts c) (tsubstTy ts t) (tsubstTy ts e)
  | nil t => nil (t.tsubst ts)
  | some e => some (tsubstTy ts e)
  | ifnil e n s => ifnil (tsubstTy ts e) (tsubstTy ts n) (tsubstTy ts s)
  | inl r e => inl (r.tsubst ts) (tsubstTy ts e)
  | inr l e => inr (l.tsubst ts) (tsubstTy ts e)
  | case e l r => case (tsubstTy ts e) (tsubstTy ts l) (tsubstTy ts r)
  | pair a b => pair (tsubstTy ts a) (tsubstTy ts b)
  | fst e => fst (tsubstTy ts e)
  | snd e => snd (tsubstTy ts e)
  | call fn ts' e => call fn (ts'.map (Ty.tsubst ts)) (tsubstTy ts e)
  | callM fn ts' e => callM fn (ts'.map (Ty.tsubst ts)) (tsubstTy ts e)
  | fnref fn ts' => fnref fn (ts'.map (Ty.tsubst ts))
  | callv f e => callv (tsubstTy ts f) (tsubstTy ts e)
  | callMv a f e => callMv a (tsubstTy ts f) (tsubstTy ts e)
  | ann e t => ann (tsubstTy ts e) (t.tsubst ts)
  | block e => block (tsubstTy ts e)
  | blockR t e => blockR (t.tsubst ts) (tsubstTy ts e)
  | copyTo k t e => copyTo k (t.tsubst ts) (tsubstTy ts e)
  | label t e => label (t.tsubst ts) (tsubstTy ts e)
  | jump n t e => jump n (t.tsubst ts) (tsubstTy ts e)
  | unreach t => unreach (t.tsubst ts)
  | alloc m e => alloc m (tsubstTy ts e)
  | deref e => deref (tsubstTy ts e)
  | assign l e => assign (tsubstTy ts l) (tsubstTy ts e)
  | whileE c b => whileE (tsubstTy ts c) (tsubstTy ts b)
  | freeze e => freeze (tsubstTy ts e)
  | mkslice m t => mkslice m (t.tsubst ts)
  | strlit bs r => strlit bs r
  | mksliceAt m t r => mksliceAt m (t.tsubst ts) r
  | mkmapAt m t r => mkmapAt m (t.tsubst ts) r
  | index e i ot => index (tsubstTy ts e) (tsubstTy ts i) (ot.map (Ty.tsubst ts))
  | lenE e => lenE (tsubstTy ts e)
  | tobyte e => tobyte (tsubstTy ts e)
  | fconv op e => fconv op (tsubstTy ts e)
  | toint e => toint (tsubstTy ts e)
  | append e w => append (tsubstTy ts e) (tsubstTy ts w)
  | setidx e i w => setidx (tsubstTy ts e) (tsubstTy ts i) (tsubstTy ts w)
  | subslice e sa sb => subslice (tsubstTy ts e) (tsubstTy ts sa) (tsubstTy ts sb)
  | eqs e1 e2 => eqs (tsubstTy ts e1) (tsubstTy ts e2)
  | concat e1 e2 => concat (tsubstTy ts e1) (tsubstTy ts e2)
  | mkmap m t => mkmap m (t.tsubst ts)
  | getm t e k => getm (t.tsubst ts) (tsubstTy ts e) (tsubstTy ts k)
  | setm e k w => setm (tsubstTy ts e) (tsubstTy ts k) (tsubstTy ts w)
  | delm t e k => delm (t.tsubst ts) (tsubstTy ts e) (tsubstTy ts k)
  | lenm e => lenm (tsubstTy ts e)
  | keysm e => keysm (tsubstTy ts e)
  | clone ot e => clone (ot.map (Ty.tsubst ts)) (tsubstTy ts e)
  | par e1 e2 => par (tsubstTy ts e1) (tsubstTy ts e2)
  | parch t e1 e2 => parch (t.tsubst ts) (tsubstTy ts e1) (tsubstTy ts e2)
  | newchan rc t => newchan rc (t.tsubst ts)
  | send c e => send (tsubstTy ts c) (tsubstTy ts e)
  | recv c => recv (tsubstTy ts c)
  | close c => close (tsubstTy ts c)
  | loc r a => loc r a
  | slicev mt r base len => slicev mt r base len
  | mapv mt r base len => mapv mt r base len
  | chanV c => chanV c
  | scope t ε e => scope (t.tsubst ts) (ε.tsubst ts) (tsubstTy ts e)
  | spawn sc a e => spawn (tsubstTy ts sc) (tsubstTy ts a) (tsubstTy ts e)
  | join t h => join (t.tsubst ts) (tsubstTy ts h)
  | tryJ t h => tryJ (t.tsubst ts) (tsubstTy ts h)
  | scopeV rs ε => scopeV rs (ε.tsubst ts)
  | taskV rs n => taskV rs n
  | newch r cap t => newch r cap (t.tsubst ts)
  | epV p k b r => epV p k b r

/-- bare newchan / 実行時チャネル参照を含まない（round4: Def 本体の条件）。
本体は呼び手より高い床 f で型付けされるが、f を使うのは newchan / chanV だけなので、
これらを含まなければ f を実行時のタスク床へ下げられる（f_lower）。
parch は f 制約を持たないので関数内の並列は断片内に残る -/
def noNewchan : Expr → Bool
  | lit _ => true
  | blit _ => true
  | flit _ => true
  | tt => true
  | ff => true
  | triv => true
  | var _ => true
  | letE e b => noNewchan e && noNewchan b
  | add a b => noNewchan a && noNewchan b
  | lt a b => noNewchan a && noNewchan b
  | arith _ a b => noNewchan a && noNewchan b
  | farith _ a b => noNewchan a && noNewchan b
  | fcmp _ a b => noNewchan a && noNewchan b
  | cmp _ a b => noNewchan a && noNewchan b
  | ite c t e => noNewchan c && noNewchan t && noNewchan e
  | nil _ => true
  | some e => noNewchan e
  | ifnil e n s => noNewchan e && noNewchan n && noNewchan s
  | inl _ e => noNewchan e
  | inr _ e => noNewchan e
  | case e l r => noNewchan e && noNewchan l && noNewchan r
  | pair a b => noNewchan a && noNewchan b
  | fst e => noNewchan e
  | snd e => noNewchan e
  | call _ _ e => noNewchan e
  | callM _ _ e => noNewchan e
  | fnref _ _ => true
  | callv f e => noNewchan f && noNewchan e
  | callMv _ f e => noNewchan f && noNewchan e
  | ann e _ => noNewchan e
  | block e => noNewchan e
  | blockR _ e => noNewchan e
  | copyTo _ _ e => noNewchan e
  | label _ e => noNewchan e
  | jump _ _ e => noNewchan e
  | unreach _ => true
  | alloc _ e => noNewchan e
  | deref e => noNewchan e
  | assign l e => noNewchan l && noNewchan e
  | whileE c b => noNewchan c && noNewchan b
  | freeze e => noNewchan e
  | mkslice _ _ => true
  | strlit _ _ => true
  | mksliceAt _ _ _ => true
  | mkmapAt _ _ _ => true
  | index e i _ => noNewchan e && noNewchan i
  | lenE e => noNewchan e
  | tobyte e => noNewchan e
  | fconv _ e => noNewchan e
  | toint e => noNewchan e
  | append e w => noNewchan e && noNewchan w
  | setidx e i w => noNewchan e && noNewchan i && noNewchan w
  | subslice e sa sb => noNewchan e && noNewchan sa && noNewchan sb
  | eqs e1 e2 => noNewchan e1 && noNewchan e2
  | concat e1 e2 => noNewchan e1 && noNewchan e2
  | mkmap _ _ => true
  | getm _ e k => noNewchan e && noNewchan k
  | setm e k w => noNewchan e && noNewchan k && noNewchan w
  | delm _ e k => noNewchan e && noNewchan k
  | lenm e => noNewchan e
  | keysm e => noNewchan e
  | clone _ e => noNewchan e
  | par e1 e2 => noNewchan e1 && noNewchan e2
  | parch _ e1 e2 => noNewchan e1 && noNewchan e2
  | newchan _ _ => false
  | send c e => noNewchan c && noNewchan e
  | recv c => noNewchan c
  | close c => noNewchan c
  | loc _ _ => true
  | slicev _ _ _ _ => true
  | mapv _ _ _ _ => true
  | chanV _ => false
  | scope _ _ e => noNewchan e
  | spawn sc a e => noNewchan sc && noNewchan a && noNewchan e
  | join _ h => noNewchan h
  | tryJ _ h => noNewchan h
  | scopeV _ _ => false
  | taskV _ _ => false
  | newch _ _ _ => true
  | epV _ _ _ _ => false

theorem noNewchan_shiftTy {ρ : Nat} {e : Expr} (h : e.noNewchan = true) :
    (e.shiftTy ρ).noNewchan = true := by
  induction e <;> simp_all [Expr.noNewchan, Expr.shiftTy]

/-- 項の型注釈と実行時項の region 添字を写す（shiftTy の一般化） -/
def renTy (ρ0 δ : Nat) : Expr → Expr
  | lit n => lit n
  | blit n => blit n
  | flit n => flit n
  | tt => tt
  | ff => ff
  | triv => triv
  | var i => var i
  | letE e b => letE (renTy ρ0 δ e) (renTy ρ0 δ b)
  | add a b => add (renTy ρ0 δ a) (renTy ρ0 δ b)
  | lt a b => lt (renTy ρ0 δ a) (renTy ρ0 δ b)
  | arith op a b => arith op (renTy ρ0 δ a) (renTy ρ0 δ b)
  | farith op a b => farith op (renTy ρ0 δ a) (renTy ρ0 δ b)
  | fcmp op a b => fcmp op (renTy ρ0 δ a) (renTy ρ0 δ b)
  | cmp op a b => cmp op (renTy ρ0 δ a) (renTy ρ0 δ b)
  | ite c t e => ite (renTy ρ0 δ c) (renTy ρ0 δ t) (renTy ρ0 δ e)
  | nil t => nil (t.renR ρ0 δ)
  | some e => some (renTy ρ0 δ e)
  | ifnil e n s => ifnil (renTy ρ0 δ e) (renTy ρ0 δ n) (renTy ρ0 δ s)
  | inl r e => inl (r.renR ρ0 δ) (renTy ρ0 δ e)
  | inr l e => inr (l.renR ρ0 δ) (renTy ρ0 δ e)
  | case e l r => case (renTy ρ0 δ e) (renTy ρ0 δ l) (renTy ρ0 δ r)
  | pair a b => pair (renTy ρ0 δ a) (renTy ρ0 δ b)
  | fst e => fst (renTy ρ0 δ e)
  | snd e => snd (renTy ρ0 δ e)
  | call fn ts e => call fn (ts.map (Ty.renR ρ0 δ)) (renTy ρ0 δ e)
  | callM fn ts e => callM fn (ts.map (Ty.renR ρ0 δ)) (renTy ρ0 δ e)
  | fnref fn ts => fnref fn (ts.map (Ty.renR ρ0 δ))
  | callv f e => callv (renTy ρ0 δ f) (renTy ρ0 δ e)
  | callMv a f e => callMv (rmap ρ0 δ a) (renTy ρ0 δ f) (renTy ρ0 δ e)
  | ann e t => ann (renTy ρ0 δ e) (t.renR ρ0 δ)
  | block e => block (renTy ρ0 δ e)
  | blockR t e => blockR (t.renR ρ0 δ) (renTy ρ0 δ e)
  | copyTo k t e => copyTo (rmap ρ0 δ k) (t.renR ρ0 δ) (renTy ρ0 δ e)
  | label t e => label (t.renR ρ0 δ) (renTy ρ0 δ e)
  | jump n t e => jump n (t.renR ρ0 δ) (renTy ρ0 δ e)
  | unreach t => unreach (t.renR ρ0 δ)
  | alloc m e => alloc m (renTy ρ0 δ e)
  | deref e => deref (renTy ρ0 δ e)
  | assign l e => assign (renTy ρ0 δ l) (renTy ρ0 δ e)
  | whileE c b => whileE (renTy ρ0 δ c) (renTy ρ0 δ b)
  | freeze e => freeze (renTy ρ0 δ e)
  | mkslice m t => mkslice m (t.renR ρ0 δ)
  | strlit bs r => strlit bs (rmap ρ0 δ r)
  | mksliceAt m t r => mksliceAt m (t.renR ρ0 δ) (rmap ρ0 δ r)
  | mkmapAt m t r => mkmapAt m (t.renR ρ0 δ) (rmap ρ0 δ r)
  | index e i ot => index (renTy ρ0 δ e) (renTy ρ0 δ i) (ot.map (Ty.renR ρ0 δ))
  | lenE e => lenE (renTy ρ0 δ e)
  | tobyte e => tobyte (renTy ρ0 δ e)
  | fconv op e => fconv op (renTy ρ0 δ e)
  | toint e => toint (renTy ρ0 δ e)
  | append e w => append (renTy ρ0 δ e) (renTy ρ0 δ w)
  | setidx e i w => setidx (renTy ρ0 δ e) (renTy ρ0 δ i) (renTy ρ0 δ w)
  | subslice e sa sb => subslice (renTy ρ0 δ e) (renTy ρ0 δ sa) (renTy ρ0 δ sb)
  | eqs e1 e2 => eqs (renTy ρ0 δ e1) (renTy ρ0 δ e2)
  | concat e1 e2 => concat (renTy ρ0 δ e1) (renTy ρ0 δ e2)
  | mkmap m t => mkmap m (t.renR ρ0 δ)
  | getm t e k => getm (t.renR ρ0 δ) (renTy ρ0 δ e) (renTy ρ0 δ k)
  | setm e k w => setm (renTy ρ0 δ e) (renTy ρ0 δ k) (renTy ρ0 δ w)
  | delm t e k => delm (t.renR ρ0 δ) (renTy ρ0 δ e) (renTy ρ0 δ k)
  | lenm e => lenm (renTy ρ0 δ e)
  | keysm e => keysm (renTy ρ0 δ e)
  | clone ot e => clone (ot.map (Ty.renR ρ0 δ)) (renTy ρ0 δ e)
  | par e1 e2 => par (renTy ρ0 δ e1) (renTy ρ0 δ e2)
  | parch t e1 e2 => parch (t.renR ρ0 δ) (renTy ρ0 δ e1) (renTy ρ0 δ e2)
  | newchan rc t => newchan (rmap ρ0 δ rc) (t.renR ρ0 δ)
  | send c e => send (renTy ρ0 δ c) (renTy ρ0 δ e)
  | recv c => recv (renTy ρ0 δ c)
  | close c => close (renTy ρ0 δ c)
  | loc r a => loc (rmap ρ0 δ r) a
  | slicev mt r base len => slicev mt (rmap ρ0 δ r) base len
  | mapv mt r base len => mapv mt (rmap ρ0 δ r) base len
  | chanV c => chanV c
  | scope t ε e => scope (t.renR ρ0 δ) (ε.renR ρ0 δ) (renTy ρ0 δ e)
  | spawn sc a e => spawn (renTy ρ0 δ sc) (renTy ρ0 δ a) (renTy ρ0 δ e)
  | join t h => join (t.renR ρ0 δ) (renTy ρ0 δ h)
  | tryJ t h => tryJ (t.renR ρ0 δ) (renTy ρ0 δ h)
  | scopeV rs ε => scopeV (rmap ρ0 δ rs) (ε.renR ρ0 δ)
  | taskV rs n => taskV (rmap ρ0 δ rs) n
  | newch r cap t => newch (rmap ρ0 δ r) cap (t.renR ρ0 δ)
  | epV p k b r => epV p k b (rmap ρ0 δ r)

/-- strlit の書き換え先のセル列: e に bs の各バイトを先頭から append する（`strCells [a, b] e = append (append e (tobyte a)) (tobyte b)` —
セルは byte（段 C: string = imm byte slice）。範囲外のバイトは tobyte の panic だが、JSON の strlit は UTF-8 のバイト列なので現れない） -/
def strCells : List Int → Expr → Expr
  | [], e => e
  | c :: cs, e => strCells cs (append e (tobyte (lit c)))

/-- 値の mut 位置の region（loc / slicev / mapv の region） -/
def mutTopV : Expr → Option Nat
  | loc r _ => Option.some r
  | slicev _ r _ _ => Option.some r
  | mapv _ r _ _ => Option.some r
  | _ => Option.none

/-- anchor の読み取り（実行時の値 — Machine の callMK が使う）: 仮引数型の mut 位置に対応する
値の region。型付き状態では Ty.anchorOf と一致する -/
def anchorV : Ty → Expr → Option Nat
  | .prod l r, v =>
      match v with
      | pair a b => (anchorV l a).or (anchorV r b)
      | _ => Option.none
  | p, v => if p.isMut0 then v.mutTopV else Option.none

/-- ソース項: 実行時にのみ現れる形（loc / chanV）を含まない。
脱糖器（Zig 側）が Lean に渡すコア AST はこの範囲 -/
def src : Expr → Bool
  | .lit _ | .tt | .ff | .triv | .var _ | .nil _ | .newchan _ _ => true
  | .letE e b => e.src && b.src
  | .mkslice _ _ => true
  | .strlit _ _ => true
  | .mksliceAt _ _ _ => true
  | .mkmapAt _ _ _ => true
  | .add a b | .lt a b | .arith _ a b | .cmp _ a b | .farith _ a b | .fcmp _ a b
  | .assign a b | .whileE a b | .send a b | .index a b _ | .append a b => a.src && b.src
  | .setidx e i v => e.src && i.src && v.src
  | .subslice e sa sb => e.src && sa.src && sb.src
  | .eqs e1 e2 => e1.src && e2.src
  | .concat e1 e2 => e1.src && e2.src
  | .lenE e => e.src
  | .tobyte e => e.src
  | .fconv _ e => e.src
  | .toint e => e.src
  | .blit _ => false
  | .flit _ => true
  | .slicev _ _ _ _ => false
  | .mkmap _ _ => true
  | .getm _ e k => e.src && k.src
  | .setm e k v => e.src && k.src && v.src
  | .delm _ e k => e.src && k.src
  | .lenm e => e.src
  | .keysm e => e.src
  | .clone _ e => e.src
  | .mapv _ _ _ _ => false
  | .ite c t e | .ifnil c t e => c.src && t.src && e.src
  | .some e | .inl _ e | .inr _ e | .block e | .blockR _ e | .copyTo _ _ e | .alloc _ e | .deref e
  | .freeze e | .recv e | .close e | .fst e | .snd e => e.src
  | .pair a b => a.src && b.src
  | .call _ _ e => e.src
  | .callM _ _ e => e.src
  | .fnref _ _ => true
  | .callv ef e => ef.src && e.src
  | .callMv _ ef e => ef.src && e.src
  | .ann e _ => e.src
  | .label _ e => e.src
  | .jump _ _ e => e.src
  | .unreach _ => true
  | .case e l r => e.src && l.src && r.src
  | .par e1 e2 => e1.src && e2.src
  | .parch _ e1 e2 => e1.src && e2.src
  | .loc _ _ => false
  | .chanV _ => false
  -- 段 6 P1: scope / spawn / join / try はソースの形（札・handle は実行時だけ）。Def 本体には置かない（noNewchan が締め出す）
  | .scope _ _ e => e.src
  | .spawn sc a e => sc.src && a.src && e.src
  | .join _ h => h.src
  | .tryJ _ h => h.src
  | .scopeV _ _ | .taskV _ _ => false
  | .newch _ _ _ => true
  | .epV _ _ _ _ => false

/-- 値の型注釈を目標型（Ty.sub の右側）に合わせて書き換える構造ウォーク（round4）。
nil / inl / inr は型注釈を持つ値なので、上界を緩めた型ではそのままだと型が付かない —
call が引数を param.shiftR d へ渡すとき、機械がこれを掛ける。
注釈は実行時表現を持たないので codegen ではゼロコスト（恒等写像） -/
def coerceTo : Ty → Expr → Expr
  | .opt t', nil _ => nil t'
  | .opt t', some e => some (coerceTo t' e)
  | .union l' r', inl _ e => inl r' (coerceTo l' e)
  | .union l' r', inr _ e => inr l' (coerceTo r' e)
  | .prod l' r', pair a b => pair (coerceTo l' a) (coerceTo r' b)
  | _, e => e

/-- 読み出しの注釈（R4b-cov A-2）: 注釈があれば coerceTo、無ければそのまま -/
def coerceOpt : Option Ty → Expr → Expr
  | Option.none, e => e
  | Option.some t, e => coerceTo t e

end Expr

/-- 呼び出し点のインスタンス化（V3-2）: 型引数で代入した仮想 Def。
呼び出しの意味論・型付けは常にこの単相の Def を通る -/
def Def.inst (dfn : Def) (ts : List Ty) : Def :=
  { param := dfn.param.tsubst ts, ret := dfn.ret.tsubst ts, body := dfn.body.tsubstTy ts }

/-- 値 -/
inductive Value : Expr → Prop where
  | lit (n : Int) : Value (.lit n)
  | blit {n : Int} : 0 ≤ n → n < 256 → Value (.blit n)
  | flit (n : Int) : Value (.flit n)
  | tt : Value .tt
  | ff : Value .ff
  | triv : Value .triv
  | nil (t : Ty) : Value (.nil t)
  | some {v : Expr} : Value v → Value (.some v)
  | inl {v : Expr} (r : Ty) : Value v → Value (.inl r v)
  | inr {v : Expr} (l : Ty) : Value v → Value (.inr l v)
  | pair {a b : Expr} : Value a → Value b → Value (.pair a b)
  | loc (r a : Nat) : Value (.loc r a)
  | slicev (mt : Bool) (r base len : Nat) : Value (.slicev mt r base len)
  | mapv (mt : Bool) (r base len : Nat) : Value (.mapv mt r base len)
  | chanV (c : Nat) : Value (.chanV c)
  | scopeV (rs : Nat) (ε : Ty) : Value (.scopeV rs ε)
  | taskV (rs n : Nat) : Value (.taskV rs n)
  | epV (p : List Nat) (k : Nat) (b : Bool) (r : Nat) : Value (.epV p k b r)
  | fnref (fn : Nat) (ts : List Ty) : Value (.fnref fn ts)

/-- shift は値性を保つ（値は block / alloc / deref を含まない wrapper のみ） -/
theorem Value.shift {v : Expr} (hv : Value v) (c : Nat) : Value (v.shift c) := by
  induction hv with
  | lit n => exact .lit n
  | blit h1 h2 => exact .blit h1 h2
  | flit n => exact .flit n
  | tt => exact .tt
  | ff => exact .ff
  | triv => exact .triv
  | nil t => exact .nil t
  | some _ ih => exact .some ih
  | inl r _ ih => exact .inl r ih
  | inr l _ ih => exact .inr l ih
  | pair _ _ iha ihb => exact .pair iha ihb
  | loc r a => exact .loc r a
  | slicev mt r base len => exact .slicev mt r base len
  | mapv mt r base len => exact .mapv mt r base len
  | chanV c => exact .chanV c
  | scopeV rs ε => exact .scopeV rs ε
  | taskV rs n => exact .taskV rs n
  | epV p k b r => exact .epV p k b r
  | fnref fn ts => exact .fnref fn ts

/-- 値は自由変数を含まないので shift は恒等 -/
theorem Value.shift_eq {v : Expr} (hv : Value v) (c : Nat) : v.shift c = v := by
  induction hv with
  | lit n => rfl
  | blit _ _ => rfl
  | flit _ => rfl
  | tt => rfl
  | ff => rfl
  | triv => rfl
  | nil t => rfl
  | some _ ih => simp [Expr.shift, ih]
  | inl r _ ih => simp [Expr.shift, ih]
  | inr l _ ih => simp [Expr.shift, ih]
  | pair _ _ iha ihb => simp [Expr.shift, iha, ihb]
  | loc r a => rfl
  | slicev _ _ _ _ => rfl
  | mapv _ _ _ _ => rfl
  | chanV c => rfl
  | fnref fn ts => rfl
  | scopeV _ _ => rfl
  | taskV _ _ => rfl
  | epV _ _ _ _ => rfl

end FS
