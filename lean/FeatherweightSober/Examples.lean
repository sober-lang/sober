import FeatherweightSober.Typing
import FeatherweightSober.Checker
import FeatherweightSober.Machine
import FeatherweightSober.Soundness
import FeatherweightSober.Json

/-!
# 例（定義が意図どおり動くかの目視用。証明ではない）

実行例は機械（stepN [] / run）で走らせて rfl で突き合わせる。
-/
namespace FS.Examples

open FS Expr

/-- `x := 1; x + 2` -/
def ex1 : Expr := letE (lit 1) (add (var 0) (lit 2))

example : HasType [] ∅ [] 0 0 0 [] [] ex1 .int :=
  HasType.letE HasType.lit (HasType.add (HasType.var rfl) HasType.lit)

example : stepN [] 16 (load ex1) ∅ = (.ret [] [] (lit 3), ∅) := rfl

/-- `v := some 5; if v != nil { v + 1 } else { 0 }` -/
def ex2 : Expr :=
  letE (Expr.some (lit 5)) (ifnil (var 0) (lit 0) (add (var 0) (lit 1)))

example : HasType [] ∅ [] 0 0 0 [] [] ex2 .int :=
  HasType.letE (HasType.some HasType.lit)
    (HasType.ifnil (HasType.var rfl) HasType.lit (HasType.add (HasType.var rfl) HasType.lit))

example : stepN [] 16 (load ex2) ∅ = (.ret [] [] (lit 6), ∅) := rfl

/-- `switch inl 7 { case L{x}: x  case R{b}: if b { 1 } else { 0 } }` -/
def ex3 : Expr :=
  case (inl .bool (lit 7)) (var 0) (Expr.ite (var 0) (lit 1) (lit 0))

example : HasType [] ∅ [] 0 0 0 [] [] ex3 .int :=
  HasType.case (HasType.inl HasType.lit) (HasType.var rfl)
    (HasType.ite (HasType.var rfl) HasType.lit HasType.lit)

example : stepN [] 16 (load ex3) ∅ = (.ret [] [] (lit 7), ∅) := rfl

/-- `{ r := alloc mut 1; !r + 41 }` — region を作り、割り当てて読み、値だけ持ち出す -/
def ex4 : Expr := block (letE (alloc true (lit 1)) (add (deref (var 0)) (lit 41)))

example : HasType [] ∅ [] 0 0 0 [] [] ex4 .int :=
  HasType.block
    (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun h => nomatch h))
      (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit))
    rfl

example : stepN [] 32 (load ex4) ∅ = (.ret [] [] (lit 42), ∅) := rfl

/-- ネストした region: 内側の値を外へはコピー（int）でしか出せない -/
def ex5 : Expr :=
  block (letE (alloc true (lit 1))
    (add (block (letE (alloc true (lit 2)) (add (deref (var 0)) (deref (var 1)))))
      (deref (var 0))))

example : HasType [] ∅ [] 0 0 0 [] [] ex5 .int :=
  HasType.block
    (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun h => nomatch h))
      (HasType.add
        (HasType.block
          (HasType.letE (HasType.alloc HasType.lit rfl (by omega) (fun h => nomatch h))
            (HasType.add (HasType.deref (HasType.var rfl)) (HasType.deref (HasType.var rfl))))
          rfl)
        (HasType.deref (HasType.var rfl))))
    rfl

example : stepN [] 64 (load ex5) ∅ = (.ret [] [] (lit 4), ∅) := rfl

/-- escape は型が付かない: `{ alloc 1 }` は自分の region への参照を返そうとする -/
example : ¬ ∃ t, HasType [] ∅ [] 0 0 0 [] [] (block (alloc true (lit 1))) t := by
  intro ⟨t, h⟩
  cases h with
  | block h hb =>
    cases h with
    | alloc _ _ _ _ => simp [Ty.regionsBelow] at hb

/-- `{ i := alloc mut 0; while !i < 3 { i := !i + 1 }; !i }` — mut カウンタの while ループ -/
def ex6 : Expr :=
  block (letE (alloc true (lit 0))
    (letE (whileE (lt (deref (var 0)) (lit 3))
            (assign (var 0) (add (deref (var 0)) (lit 1))))
      (deref (var 1))))

example : HasType [] ∅ [] 0 0 0 [] [] ex6 .int :=
  HasType.block
    (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun h => nomatch h))
      (HasType.letE
        (HasType.whileE (HasType.lt (HasType.deref (HasType.var rfl)) HasType.lit)
          (HasType.assign (HasType.var rfl)
            (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)))
        (HasType.deref (HasType.var rfl))))
    rfl

example : stepN [] 128 (load ex6) ∅ = (.ret [] [] (lit 3), ∅) := rfl

/-- `x := 5; parallel { spawn x + 1; spawn x < 9 }` — 不変値（int）だけを共有する並列 -/
def ex7 : Expr := letE (lit 5) (par (add (var 0) (lit 1)) (lt (var 0) (lit 9)))

example : HasType [] ∅ [] 0 0 0 [] [] ex7 .unit :=
  HasType.letE HasType.lit
    (HasType.par (HasType.add (HasType.var rfl) HasType.lit)
      (HasType.lt (HasType.var rfl) HasType.lit) (by decide))

/-- 逐次スケジュール（左を先に完走） -/
example :
    run [] ([[], [], [], []] ++ List.replicate 5 [true] ++ List.replicate 5 [false] ++ [[]])
      (load ex7) ∅ = (.ret [] [] .triv, ∅) := rfl

/-- 交互スケジュール — どう並べても同じ最終状態（par_step_commute の可換性） -/
example :
    run [] ([[], [], [], []] ++
      [[true], [false], [true], [false], [true], [false], [true], [false], [true], [false]] ++
      [[]]) (load ex7) ∅ = (.ret [] [] .triv, ∅) := rfl

/-- 段 3b: immutable 参照の共有。
`{ p := alloc imm 20; parallel { spawn !p + 1; spawn !p + 2 }; !p + 22 }` —
タスクは親 region の immutable セルを読める（Γ の mutFree 緩和） -/
def ex8 : Expr :=
  block (letE (alloc false (lit 20))
    (letE (par (add (deref (var 0)) (lit 1)) (add (deref (var 0)) (lit 2)))
      (add (deref (var 1)) (lit 22))))

example : HasType [] ∅ [] 0 0 0 [] [] ex8 .int :=
  HasType.block
    (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun _ => rfl))
      (HasType.letE
        (HasType.par
          (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)
          (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)
          (by decide))
        (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)))
    rfl

/-- 左を先に完走 → 右 → join → メイン続行（!p + 22 = 42） -/
example :
    run [] (List.replicate 8 [] ++ List.replicate 7 [true] ++ List.replicate 7 [false] ++
      List.replicate 10 []) (load ex8) ∅ = (.ret [] [] (lit 42), ∅) := rfl

/-- 交互スケジュールでも同じ最終状態（読みは競合しない） -/
example :
    run [] (List.replicate 8 [] ++
      [[true], [false], [true], [false], [true], [false], [true], [false],
       [true], [false], [true], [false], [true], [false]] ++
      List.replicate 10 []) (load ex8) ∅ = (.ret [] [] (lit 42), ∅) := rfl

/-- mut 参照が見えるスコープでは par に型が付かない（Γ の mutFree 検査） -/
example : ¬ ∃ t, HasType [] ∅ [] 0 0 1 [.ref true 0 .int] [] (par (lit 1) (lit 2)) t := by
  intro ⟨t, h⟩
  cases h with
  | par _ _ hΓ =>
    have := hΓ (.ref true 0 .int) (by simp)
    simp [Ty.mutFree] at this

/-- 共有 region の mut セルにはタスクから loc の型が付かない
（共有境界 b = 1 の世界で、レベル 0 の mut セルへの代入） -/
example : ¬ ∃ t, HasType [] ∅ [[(true, Ty.int)]] 1 1 1 [] [] (assign (loc 0 0) (lit 1)) t := by
  intro ⟨t, h⟩
  cases h with
  | assign hl _ =>
    cases hl with
    | loc _ _ _ _ h5 _ => exact absurd (h5 rfl).2 (by omega)

/-- immutable セルには深く mutFree な型しか置けない
（mut 参照を immutable セルに入れて共有する抜け道は alloc で塞がる） -/
example : ¬ ∃ t, HasType [] ∅ [] 0 0 2 [.ref true 0 .int] Λ
    (alloc false (var 0)) t := by
  intro ⟨t, h⟩
  cases h with
  | alloc hv _ _ hmf =>
    cases hv with
    | var hget =>
      simp at hget
      cases hget
      simpa [Ty.mutFree] using hmf rfl

/-- freeze の動機そのもの: mut で構築 → freeze → par で共有。
`{ p := { q := alloc mut 20; q := !q + 22; q } を freeze; parallel { spawn !p+1; spawn !p+2 }; !p }`
構築に使った mut 束縛は freeze の引数の let 鎖に閉じ、par のスコープ（Γ）には
immutable 参照だけが残る -/
def ex9 : Expr :=
  block (letE (Expr.freeze (letE (alloc true (lit 20))
      (letE (assign (var 0) (add (deref (var 0)) (lit 22))) (var 1))))
    (letE (par (add (deref (var 0)) (lit 1)) (add (deref (var 0)) (lit 2)))
      (deref (var 1))))

example : HasType [] ∅ [] 0 0 0 [] [] ex9 .int :=
  HasType.block
    (HasType.letE
      (HasType.freeze
        (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun h => nomatch h))
          (HasType.letE
            (HasType.assign (HasType.var rfl)
              (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit))
            (HasType.var rfl)))
        rfl)
      (HasType.letE
        (HasType.par
          (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)
          (HasType.add (HasType.deref (HasType.var rfl)) HasType.lit)
          (by decide))
        (HasType.deref (HasType.var rfl))))
    rfl

/-- 左を先に完走 → 右 → join → メイン続行（!p = 42） -/
example :
    run [] (List.replicate 26 [] ++ List.replicate 7 [true] ++ List.replicate 7 [false] ++
      List.replicate 10 []) (load ex9) ∅ = (.ret [] [] (lit 42), ∅) := rfl

/-- 交互スケジュールでも同じ（freeze 後の読みは競合しない） -/
example :
    run [] (List.replicate 26 [] ++
      [[true], [false], [true], [false], [true], [false], [true], [false],
       [true], [false], [true], [false], [true], [false]] ++
      List.replicate 10 []) (load ex9) ∅ = (.ret [] [] (lit 42), ∅) := rfl

/-- 動的検査が底: freeze 後の古い mut エイリアスへの assign は
**型は付くが実行で panic する**。
`{ p := alloc mut 1; p2 := freeze p; p := 5 }` — p の型（ref mut）は freeze を知らないが、
実行時タグ検査が書き込みを止める -/
def ex10 : Expr :=
  block (letE (alloc true (lit 1))
    (letE (Expr.freeze (var 0))
      (assign (var 1) (lit 5))))

example : HasType [] ∅ [] 0 0 0 [] [] ex10 .unit :=
  HasType.block
    (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun h => nomatch h))
      (HasType.letE (HasType.freeze (HasType.var rfl) rfl)
        (HasType.assign (HasType.var rfl) HasType.lit)))
    rfl

/-- 実行は panic で止まる（ヒープは freeze 済みセルを保持したまま） -/
example : stepN [] 64 (load ex10) ∅ = (.panic [[(false, lit 1)]], ∅) := rfl

/-- 若い loc を古いセルに書く escape は alloc の regionsBelow が塞ぐ:
外 region の `T?` セルに、内 region への参照を some で書き込もうとする形は
`alloc (nil (ref 1 int))` の時点で型が付かない -/
example : ¬ ∃ t, HasType [] ∅ [] 0 0 1 [] [] (alloc true (nil (.ref true 1 .int))) t := by
  intro ⟨t, h⟩
  cases h with
  | alloc hn hb _ _ =>
    cases hn
    simp [Ty.regionsBelow] at hb

/-- 段 3c: チャネルによるタスク間通信。
`c1 := newchan; c2 := newchan;
 parallel { spawn c1 <- 41; spawn c2 <- (<-c1 + 1) }; <-c2` —
チャネル（Sharable）は Γ の mutFree 検査を通ってタスクに渡り、
タスク間の値の受け渡しは K（全タスク共有のチャネルストア）を経由する -/
def ex11 : Expr :=
  letE (newchan 0 .int) (letE (newchan 0 .int)
    (letE (par (send (var 1) (lit 41))
               (send (var 0) (add (recv (var 1)) (lit 1))))
      (recv (var 1))))

example : HasType [] ∅ [] 0 0 0 [] [] ex11 .int :=
  HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
    (HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
      (HasType.letE
        (HasType.par
          (HasType.send (HasType.var rfl) HasType.lit)
          (HasType.send (HasType.var rfl)
            (HasType.add (HasType.recv (HasType.var rfl)) HasType.lit))
          (by decide))
        (HasType.recv (HasType.var rfl))))

/-- 左（送信側）を先に完走 → 右 → join → メインが c2 から受信（42） -/
example :
    run [] (List.replicate 8 [] ++ List.replicate 5 [true] ++ List.replicate 11 [false] ++
      List.replicate 8 []) (load ex11) ∅ = (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-- 右（受信側）を先に走らせて空チャネルで待たせ、左の send 後に再開しても同じ 42 —
チャネルの同期が値を決め、スケジュールは結果を変えない -/
example :
    run [] (List.replicate 8 [] ++ List.replicate 6 [false] ++ List.replicate 5 [true] ++
      List.replicate 5 [false] ++ List.replicate 8 []) (load ex11) ∅ =
      (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-- デッドロック: 誰も送らないチャネルの recv は Blocked で止まる
（panic でも値でもない第 3 の終わり方。progress の言明の口） -/
def ex12 : Expr := letE (newchan 0 .int) (par (recv (var 0)) (lit 1))

example : HasType [] ∅ [] 0 0 0 [] [] ex12 .unit :=
  HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
    (HasType.par (HasType.recv (HasType.var rfl)) HasType.lit (by decide))

/-- 左タスクは recv 待ち、右は完了 — join できず止まる -/
example :
    run [] (List.replicate 4 [] ++ [[true], [true], [false]]) (load ex12) ∅ =
      (.par [] [] (.ret [] [.recvK] (chanV 0)) (.ret [] [] (lit 1)), .ofLeg [[]]) := rfl

/-- 止まった状態は Blocked（待機）そのもの -/
example : Blocked (.ofLeg [[]]) (.par [] [] (.ret [] [.recvK] (chanV 0)) (.ret [] [] (lit 1))) :=
  .parBD (.recv rfl) rfl

/-- 段 3d: mut 参照はペイロードにできない（mutFree 検査） -/
example : ¬ ∃ t, HasType [] ∅ [] 1 1 1 [] [] (newchan 1 (.ref true 0 .int)) t := by
  intro ⟨t, h⟩
  cases h with
  | newchan _ _ hm => simp [Ty.mutFree] at hm

/-- 段 3d: 共有上界 rc は書き込み床 f を超えられない —
メイン（f = 0）の単独 newchan は loc-free ペイロードに限られる。
参照つきチャネルが要るなら parch（生成と spawn の融合）を使う -/
example : ¬ ∃ t, HasType [] ∅ [] 0 0 1 [] [] (newchan 1 (.ref false 0 .int)) t := by
  intro ⟨t, h⟩
  cases h with
  | newchan hf _ _ => omega

/-- 段 3d の本命: 共有 region への imm 参照をチャネルで渡す（ゼロコピー共有）。
`c := newchan int;
 { p := alloc imm 41;
   parch(ref) { spawn cp <- p; spawn c <- (!(<-cp) + 1) }; 0 };
 <-c`
task1 は参照 p を parch チャネル cp で送り、task2 は受けた参照を deref して
（spawn コピーされた共有 region から 41 を読み）+1 を結果チャネル c へ返す -/
def ex13 : Expr :=
  letE (newchan 0 .int)
    (letE (block (letE (alloc false (lit 41))
        (letE (parch (.ref false 0 .int)
            (send (var 0) (var 1))
            (send (var 2) (add (deref (recv (var 0))) (lit 1))))
          (lit 0))))
      (recv (var 1)))

example : HasType [] ∅ [] 0 0 0 [] [] ex13 .int :=
  HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
    (HasType.letE
      (HasType.block
        (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun _ => rfl))
          (HasType.letE
            (HasType.parch
              (HasType.send (HasType.var rfl) (HasType.var rfl))
              (HasType.send (HasType.var rfl)
                (HasType.add (HasType.deref (HasType.recv (HasType.var rfl))) HasType.lit))
              (by decide) (by decide) rfl)
            HasType.lit))
        rfl)
      (HasType.recv (HasType.var rfl)))

/-- 送信側（task1）を先に完走 → task2 が参照を受けて deref → join → メインが 42 を受信。
参照は一度もコピーされない（キューを通るのは loc そのもの） -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 5 [true] ++ List.replicate 14 [false] ++
      List.replicate 8 []) (load ex13) ∅ = (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-- 受信側（task2）を先に走らせて parch チャネルで待たせ、
task1 の send 後に再開しても同じ 42 — 参照の transport でも同期が値を決める -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 6 [false] ++ List.replicate 5 [true] ++
      List.replicate 8 [false] ++ List.replicate 8 []) (load ex13) ∅ =
      (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-- Sharable の断片: Pool = chan の派生形（その 1）。
`pool := newchan int; pool <- 20;
 parallel { spawn { v := <-pool; pool <- v + 1 }     -- acquire → 更新 → release
            spawn { v := <-pool; pool <- v + 21 } };
 <-pool`
free-list チャネルが Pool の骨格: acquire = recv、release = send、資源の状態は
**値として循環する**。排他は「キューの値は一度しか取り出せない」というチャネルの
意味論そのもので、mut 参照なしに共有可変状態が書ける。
新しい型規則はゼロ — Sharable の白リストは chan 1 行のまま -/
def ex14 : Expr :=
  letE (newchan 0 .int)
    (letE (send (var 0) (lit 20))
      (letE (par (letE (recv (var 1)) (send (var 2) (add (var 0) (lit 1))))
                 (letE (recv (var 1)) (send (var 2) (add (var 0) (lit 21)))))
        (recv (var 2))))

example : HasType [] ∅ [] 0 0 0 [] [] ex14 .int :=
  HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
    (HasType.letE (HasType.send (HasType.var rfl) HasType.lit)
      (HasType.letE
        (HasType.par
          (HasType.letE (HasType.recv (HasType.var rfl))
            (HasType.send (HasType.var rfl)
              (HasType.add (HasType.var rfl) HasType.lit)))
          (HasType.letE (HasType.recv (HasType.var rfl))
            (HasType.send (HasType.var rfl)
              (HasType.add (HasType.var rfl) HasType.lit)))
          (by decide))
        (HasType.recv (HasType.var rfl))))

/-- 左が先に acquire → 右は空キューを待ち、左の release 後に acquire（20 → 21 → 42） -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 14 [true] ++ List.replicate 14 [false] ++
      List.replicate 5 []) (load ex14) ∅ = (.ret [] [] (lit 42), .ofLeg [[]]) := rfl

/-- 逆順（右が先に acquire。20 → 41 → 42）でも同じ —
どちらの順でも直列化され、更新は失われない（排他の観測） -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 14 [false] ++ List.replicate 14 [true] ++
      List.replicate 5 []) (load ex14) ∅ = (.ret [] [] (lit 42), .ofLeg [[]]) := rfl

/-- Sharable の断片: Pool = chan の派生形（その 2）。資源が region データ（imm 参照）で、
**同じ資源が返却後に再利用される** — Pool の本質（作り直さず回す）:
`c := newchan int;
 { p := alloc imm 20;
   parch(ref) { spawn pool <- p;                     -- 資源を pool に登録
                spawn { r1 := <-pool; x := !r1; pool <- r1;   -- acquire → 読み → release
                        r2 := <-pool; y := !r2;               -- 再 acquire = 同じ loc
                        c <- x + y + 2 } };
   0 };
 <-c`
r1 と r2 は同一の loc（キューを往復するのは参照そのもの）。
mut スロットの循環は型が付かない（下の否定例 = newchan の mutFree 検査）ので、
実 Pool の可変スロットは体系外 — region-domain-pool.md 4b「動的検査のはしご」が受ける -/
def ex15 : Expr :=
  letE (newchan 0 .int)
    (letE (block (letE (alloc false (lit 20))
        (letE (parch (.ref false 0 .int)
            (send (var 0) (var 1))
            (letE (recv (var 0))
              (letE (deref (var 0))
                (letE (send (var 2) (var 1))
                  (letE (recv (var 3))
                    (letE (deref (var 0))
                      (send (var 7) (add (add (var 3) (var 0)) (lit 2)))))))))
          (lit 0))))
      (recv (var 1)))

example : HasType [] ∅ [] 0 0 0 [] [] ex15 .int :=
  HasType.letE (HasType.newchan (Nat.le_refl 0) rfl rfl)
    (HasType.letE
      (HasType.block
        (HasType.letE (HasType.alloc HasType.lit rfl (Nat.zero_le _) (fun _ => rfl))
          (HasType.letE
            (HasType.parch
              (HasType.send (HasType.var rfl) (HasType.var rfl))
              (HasType.letE (HasType.recv (HasType.var rfl))
                (HasType.letE (HasType.deref (HasType.var rfl))
                  (HasType.letE (HasType.send (HasType.var rfl) (HasType.var rfl))
                    (HasType.letE (HasType.recv (HasType.var rfl))
                      (HasType.letE (HasType.deref (HasType.var rfl))
                        (HasType.send (HasType.var rfl)
                          (HasType.add
                            (HasType.add (HasType.var rfl) (HasType.var rfl))
                            HasType.lit)))))))
              (by decide) (by decide) rfl)
            HasType.lit))
        rfl)
      (HasType.recv (HasType.var rfl)))

/-- 登録側（task1）を先に完走 → task2 が acquire / release / 再 acquire → 42 -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 5 [true] ++ List.replicate 40 [false] ++
      List.replicate 8 []) (load ex15) ∅ = (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-- 利用側（task2）を先に走らせて空 pool で待たせ、登録後に再開しても同じ 42 —
acquire の待機は recv の Blocked そのもの（専用機構なし） -/
example :
    run [] (List.replicate 12 [] ++ List.replicate 3 [false] ++ List.replicate 5 [true] ++
      List.replicate 37 [false] ++ List.replicate 8 []) (load ex15) ∅ =
      (.ret [] [] (lit 42), .ofLeg [[], []]) := rfl

/-! ## 型検査器（Checker.lean）との突き合わせ

手書きの HasType 導出と typecheck の出力が一致する（rfl で照合）。
hasType_iff_typecheck があるので論理的には冗長だが、
「検査器が実例で本当に走る」ことの目視用。 [] -/

example : typecheck [] ∅ [] 0 0 0 [] [] ex1 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex2 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex3 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex4 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex5 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex6 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex7 = some .unit := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex8 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex9 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex10 = some .unit := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex11 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex12 = some .unit := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex13 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex14 = some .int := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] ex15 = some .int := rfl

/-- 拒否も一致する: escape（ex4 の否定例と同型）は none -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (alloc true (lit 1))) = none := rfl

/-- 拒否: mut 参照が見えるスコープの par -/
example : typecheck [] ∅ [] 0 0 1 [.ref true 0 .int] [] (par (lit 1) (lit 2)) = none := rfl

/-- 拒否: mut 参照のチャネルペイロード -/
example : typecheck [] ∅ [] 1 1 1 [] [] (newchan 1 (.ref true 0 .int)) = none := rfl

/-! ## ex16: 演算子ファミリ（arith / cmp）とゼロ除算 panic -/

/-- `if (10 - 3 * 2) == 4 { 20 % 3 } else { 0 }` -/
def ex16 : Expr :=
  Expr.ite (cmp .eq (arith .sub (lit 10) (arith .mul (lit 3) (lit 2))) (lit 4))
    (arith .mod (lit 20) (lit 3))
    (lit 0)

example : HasType [] ∅ [] 0 0 0 [] [] ex16 .int :=
  HasType.ite
    (HasType.cmp (HasType.arith HasType.lit (HasType.arith HasType.lit HasType.lit)) HasType.lit)
    (HasType.arith HasType.lit HasType.lit)
    HasType.lit

example : stepN [] 32 (load ex16) ∅ = (.ret [] [] (lit 2), ∅) := rfl

/-- ゼロ除算は panic（well-typed のまま実行が panic で止まる。freeze の ex10 と同じ受け皿） -/
def ex17 : Expr := arith .div (lit 1) (arith .sub (lit 2) (lit 2))

example : typecheck [] ∅ [] 0 0 0 [] [] ex17 = some .int := rfl
example : stepN [] 16 (load ex17) ∅ = (.panic [], ∅) := rfl

example : typecheck [] ∅ [] 0 0 0 [] [] ex16 = some .int := rfl

/-! ## ビット演算の突き合わせ（Lean 実装 ↔ x86 実行結果）

examples/bits.sober の実行（examples/bits.out）と同じケース・同じ期待値。
片側だけ変えるとどちらかが割れる（エンコーダオラクルと同じ役割の対） -/

example : ArithOp.eval .land 12 10 = some 8 := by native_decide
example : ArithOp.eval .lor 12 10 = some 14 := by native_decide
example : ArithOp.eval .lxor 12 10 = some 6 := by native_decide
example : ArithOp.eval .land (-7) 3 = some 1 := by native_decide
example : ArithOp.eval .lor (-7) 3 = some (-5) := by native_decide
example : ArithOp.eval .lxor (-7) 3 = some (-6) := by native_decide
example : ArithOp.eval .land (-7) (-3) = some (-7) := by native_decide
example : ArithOp.eval .lor (-7) (-3) = some (-3) := by native_decide
example : ArithOp.eval .lxor (-7) (-3) = some 4 := by native_decide
-- 単項 ^x（not）は xor x (-1) に脱糖される
example : ArithOp.eval .lxor 0 (-1) = some (-1) := by native_decide
example : ArithOp.eval .lxor 5 (-1) = some (-6) := by native_decide
example : ArithOp.eval .lxor (-6) (-1) = some 5 := by native_decide

/-! ## シフトの突き合わせ（Go 準拠 — examples/shift.sober(.out) と同じケース・同じ期待値） -/

example : ArithOp.eval .shl 1 3 = some 8 := by native_decide
example : ArithOp.eval .shl (-7) 2 = some (-28) := by native_decide
example : ArithOp.eval .shl 5 0 = some 5 := by native_decide
example : ArithOp.eval .shl 1 64 = some 0 := by native_decide
example : ArithOp.eval .shl 3 100 = some 0 := by native_decide
example : ArithOp.eval .shr 40 3 = some 5 := by native_decide
example : ArithOp.eval .shr (-7) 1 = some (-4) := by native_decide
example : ArithOp.eval .shr (-1) 100 = some (-1) := by native_decide
example : ArithOp.eval .shr 7 64 = some 0 := by native_decide
example : ArithOp.eval .shr (-8) 63 = some (-1) := by native_decide
example : ArithOp.eval .shr 5 0 = some 5 := by native_decide
-- 複合代入 `x <<= 4` / `y >>= 2`
example : ArithOp.eval .shl 3 4 = some 48 := by native_decide
example : ArithOp.eval .shr (-100) 2 = some (-25) := by native_decide
-- 負の量は panic（ゼロ除算の ex17 と同じ受け皿）
example : ArithOp.eval .shl 1 (-1) = none := by native_decide
example : ArithOp.eval .shr 1 (-1) = none := by native_decide

def exShlNeg : Expr := arith .shl (lit 1) (arith .sub (lit 0) (lit 1))

example : typecheck [] ∅ [] 0 0 0 [] [] exShlNeg = some .int := rfl
example : (stepN [] 16 (load exShlNeg) ∅).1 = .panic [] := by native_decide

/-! ## slice（可変長データの region 意味論 — language.md 21 節） -/

/-- `{ xs := []int{}; ys := append(xs, 7); ys[0] + len(ys) }` — 構築と先端伸長 -/
def ex19 : Expr :=
  block (letE (mkslice true .int)
    (letE (append (var 0) (lit 7))
      (add (index (var 0) (lit 0)) (lenE (var 0)))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex19 = some .int := rfl
example : stepN [] 64 (load ex19) ∅ = (.ret [] [] (lit 8), ∅) := rfl

/-- `xs[0] = 9` — mut slice への書き込み -/
def ex20 : Expr :=
  block (letE (mkslice true .int)
    (letE (append (var 0) (lit 1))
      (letE (setidx (var 0) (lit 0) (lit 9))
        (index (var 1) (lit 0)))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex20 = some .unit ∨
    typecheck [] ∅ [] 0 0 0 [] [] ex20 = some .int := .inr rfl
example : stepN [] 64 (load ex20) ∅ = (.ret [] [] (lit 9), ∅) := rfl

/-- freeze: mut で構築して不変化（string リテラルの形。language.md 21 節） -/
def ex21 : Expr :=
  block (letE (Expr.freeze (append (mkslice true .int) (lit 5)))
    (index (var 0) (lit 0)))

example : typecheck [] ∅ [] 0 0 0 [] [] ex21 = some .int := rfl
example : stepN [] 64 (load ex21) ∅ = (.ret [] [] (lit 5), ∅) := rfl

/-- 範囲外 index は panic（暫定裁定 — language.md 21 節） -/
def ex22 : Expr := block (letE (mkslice true .int) (index (var 0) (lit 0)))

example : typecheck [] ∅ [] 0 0 0 [] [] ex22 = some .int := rfl
example : stepN [] 16 (load ex22) ∅ = (.panic [[]], ∅) := rfl

/-- append の決定性: 同じ base から 2 回 append すると 2 回目は必ずコピー
（1 回目で bump 先端が進む — Go の cap 再利用の上書き事故が構造的に消える）。
ys := append(xs, 1)（先端）、zs := append(xs, 2)（コピー）で ys[0] は 1 のまま -/
def ex23 : Expr :=
  block (letE (mkslice true .int)
    (letE (append (var 0) (lit 1))
      (letE (append (var 1) (lit 2))
        (add (index (var 1) (lit 0)) (index (var 0) (lit 0))))))

example : stepN [] 96 (load ex23) ∅ = (.ret [] [] (lit 3), ∅) := rfl

/-- freeze 済み slice への setidx は実行時タグ検査で panic（assign と同じ動的な底）。
古い mut ヘッダ経由の書き込み — 型は付くが実行で止まる -/
def ex24 : Expr :=
  block (letE (append (mkslice true .int) (lit 1))
    (letE (Expr.freeze (var 0))
      (setidx (var 1) (lit 0) (lit 9))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex24 = some .unit := rfl
example : stepN [] 64 (load ex24) ∅ = (.panic [[(false, lit 1)]], ∅) := rfl

/-! ## ex25〜ex27: map（language.md 22 節。int キー、m[k] : V?、挿入列の連想モデル） -/

/-- 構築 → 挿入 2 件 → 既存キーの in-place 更新 → get（flow typing で剥く）+ len。
`m := mut map[int]int{}; m[1] = 10; m[2] = 20; m[1] = 99; (if m[1] != nil { it } else { 0 }) + len(m)` -/
def ex25 : Expr :=
  block (letE (mkmap true (.prod .int (.opt .int)))
    (letE (setm (var 0) (lit 1) (lit 10))
      (letE (setm (var 0) (lit 2) (lit 20))
        (letE (setm (var 0) (lit 1) (lit 99))
          (add (ifnil (getm .int (var 0) (lit 1)) (lit 0) (var 0))
               (lenm (var 0)))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex25 = some .int := rfl
example : stepN [] 128 (load ex25) ∅ = (.ret [] [] (lit 101), ∅) := rfl

/-- delete は墓石: get は不在（nil）、len は生きた数。不在キーと nil 値の区別が観測できる -/
def ex26 : Expr :=
  block (letE (mkmap true (.prod .int (.opt .int)))
    (letE (setm (var 0) (lit 1) (lit 10))
      (letE (setm (var 0) (lit 2) (lit 20))
        (letE (delm .int (var 0) (lit 1))
          (add (ifnil (getm .int (var 1) (lit 1)) (lit 0) (var 0))
               (lenm (var 1)))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex26 = some .int := rfl
example : stepN [] 128 (load ex26) ∅ = (.ret [] [] (lit 1), ∅) := rfl

/-- freeze 済み map への setm は実行時タグ検査で panic（slice の ex24 と同じ動的な底） -/
def ex27 : Expr :=
  block (letE (setm (mkmap true (.prod .int (.opt .int))) (lit 1) (lit 10))
    (letE (Expr.freeze (var 0))
      (letE (setm (var 1) (lit 1) (lit 9))
        (lit 0))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex27 = some .int := rfl
example : stepN [] 64 (load ex27) ∅ =
    (.panic [[(false, pair (lit 1) (Expr.some (lit 10)))]], ∅) := rfl

/-! ## ex27k: keysm（keysm の段 — キー列のスナップショット） -/

/-- examples/map_keys.sober と同じ筋: 挿入 3・1・2 → delete 1 → 1 を再挿入（墓石を生き返らせて元の位置）→ 4 を挿入 →
keys → 取った後に delete 3（スナップショットなので列は不変）。
重みつきの和 `ks[0]*1000 + ks[1]*100 + ks[2]*10 + ks[3] + len(ks)*10000` = 3124 + 40000 -/
def ex27k : Expr :=
  block (letE (mkmap true (.prod .int (.opt .int)))
    (letE (setm (var 0) (lit 3) (lit 30))
      (letE (setm (var 0) (lit 1) (lit 10))
        (letE (setm (var 0) (lit 2) (lit 20))
          (letE (delm .int (var 0) (lit 1))
            (letE (setm (var 1) (lit 1) (lit 11))
              (letE (setm (var 0) (lit 4) (lit 40))
                (letE (keysm (var 0))
                  (letE (delm .int (var 1) (lit 3))
                    (add (add (add (arith .mul (index (var 1) (lit 0)) (lit 1000))
                                   (arith .mul (index (var 1) (lit 1)) (lit 100)))
                              (add (arith .mul (index (var 1) (lit 2)) (lit 10))
                                   (index (var 1) (lit 3))))
                         (arith .mul (lenE (var 1)) (lit 10000))))))))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex27k = some .int := rfl
example : stepN [] 512 (load ex27k) ∅ = (.ret [] [] (lit 43124), ∅) := rfl

/-- keysm は最内 region に書く: 深さ 0（書き先なし）では型が付かない -/
example : typecheck [] ∅ [] 0 0 0 [] [] (keysm (mkmap true (.prod .int (.opt .int)))) = none := rfl

/-! ## ex25s: string キーの map（随時回収 R3。キー比較はヒープ上のバイト列 — keyEq）

examples/map_str.sober と同じ筋: 同じ綴りの別リテラル（別セル列）で既存キーに当たること、
不在キーの nil、len。`m := mut map[string]int{}; m["ab"] = 1; m["cd"] = 2; m["ab"] = 7;
m["ab"] ?? 0 + m["zz"] ?? 100 + len(m)` = 7 + 100 + 2 -/
def strLit (xs : List Int) : Expr :=
  Expr.freeze (xs.foldl (fun e c => append e (tobyte (lit c))) (mkslice true .byte))

def strCell : Ty := .prod (.slice false 0 .byte) (.opt .int)

def ex25s : Expr :=
  block (letE (mkmap true strCell)
    (letE (setm (var 0) (strLit [97, 98]) (lit 1))
      (letE (setm (var 0) (strLit [99, 100]) (lit 2))
        (letE (setm (var 0) (strLit [97, 98]) (lit 7))
          (add (add (ifnil (getm .int (var 0) (strLit [97, 98])) (lit 0) (var 0))
                    (ifnil (getm .int (var 0) (strLit [122, 122])) (lit 100) (var 0)))
               (lenm (var 0)))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex25s = some .int := by native_decide
example : (stepN [] 512 (load ex25s) ∅).1 = .ret [] [] (lit 109) := by native_decide

/-- キー型の制限は mkmap だけ: bool キーの map は作れない（R3 — int | string の二択） -/
example : typecheck [] ∅ [] 0 0 1 [] [] (mkmap true (.prod .bool (.opt .int))) = none := rfl
/-- 探索キーは同種なら region を問わない（keyCompat）が、種類違い（int で string キーを引く）は拒否 -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (getm .int (mkmap true strCell) (lit 1))) = none := by native_decide

/-! ## ex18: 直積（struct の右結合入れ子）。`p := Point{1, 2}; p.x + p.y` -/

def ex18 : Expr :=
  letE (pair (lit 1) (lit 2))
    (add (fst (var 0)) (snd (var 0)))

example : typecheck [] ∅ [] 0 0 0 [] [] ex18 = some .int := rfl
example : stepN [] 32 (load ex18) ∅ = (.ret [] [] (lit 3), ∅) := rfl

/-- 3 フィールド相当（右結合入れ子）の射影: `t := T{7, 8, 9}; t.z` -/
example :
    typecheck [] ∅ [] 0 0 0 [] []
      (letE (pair (lit 7) (pair (lit 8) (lit 9))) (snd (snd (var 0)))) = some .int := rfl
example :
    stepN [] 32 (load (letE (pair (lit 7) (pair (lit 8) (lit 9))) (snd (snd (var 0))))) ∅
      = (.ret [] [] (lit 9), ∅) := rfl

/-! ## ex19: 関数（一階・再帰）— fib。Phase 1 のマイルストーンがコアに乗る -/

/-- `func fib(n int) int { return if n < 2 { n } else { fib(n-1) + fib(n-2) } }` -/
def fibDef : Def :=
  { param := .int
    ret := .int
    body := Expr.ite (lt (var 0) (lit 2)) (var 0)
      (add (Expr.call 0 [] (arith .sub (var 0) (lit 1)))
           (Expr.call 0 [] (arith .sub (var 0) (lit 2)))) }

def fibΔ : Defs := [fibDef]

example : checkDefs fibΔ = true := rfl
-- round4: call は深さ 1 以上（呼び手フレームが要る）。実行はブロックで包む
example : typecheck fibΔ ∅ [] 0 0 1 [] [] (Expr.call 0 [] (lit 10)) = some .int := rfl

/-- fib 7 = 13（再帰呼び出しが入れ子世界で回る。stepN は入れ子込みの総ステップ数） -/
example : (stepN fibΔ 3000 (load (block (Expr.call 0 [] (lit 7)))) ∅).1 = .ret [] [] (lit 13) := by
  native_decide

/-- 引数の型違い（bool を渡す）は拒否 -/
example : typecheck fibΔ ∅ [] 0 0 1 [] [] (Expr.call 0 [] .tt) = none := rfl
/-- 未定義の関数 index は拒否 -/
example : typecheck fibΔ ∅ [] 0 0 1 [] [] (Expr.call 1 [] (lit 0)) = none := rfl

/-! ## JSON 境界（Json.lean）の不動点

parse（fromJson）∘ print（toJson）が恒等（Zig 側 printer の parse → print → parse
不動点オラクルと同じ形式。境界スキーマの回帰検査を兼ねる）。 -/

open FS.JsonBoundary

example : exprFromJson 100 (exprToJson ex1) = .ok ex1 := rfl
example : exprFromJson 100 (exprToJson ex6) = .ok ex6 := rfl
example : exprFromJson 100 (exprToJson ex9) = .ok ex9 := rfl
example : exprFromJson 100 (exprToJson ex13) = .ok ex13 := rfl
example : exprFromJson 100 (exprToJson ex14) = .ok ex14 := rfl
example : exprFromJson 100 (exprToJson ex15) = .ok ex15 := rfl
example : exprFromJson 100 (exprToJson ex16) = .ok ex16 := rfl
example : exprFromJson 100 (exprToJson ex17) = .ok ex17 := rfl
example : exprFromJson 100 (exprToJson ex19) = .ok ex19 := rfl
example : exprFromJson 100 (exprToJson ex20) = .ok ex20 := rfl
example : exprFromJson 100 (exprToJson ex21) = .ok ex21 := rfl
example : exprFromJson 100 (exprToJson ex18) = .ok ex18 := rfl
example : exprFromJson 200 (exprToJson ex25) = .ok ex25 := rfl
example : exprFromJson 200 (exprToJson ex26) = .ok ex26 := rfl
example : exprFromJson 200 (exprToJson ex27) = .ok ex27 := rfl
example : programFromJson 100 (programToJson fibΔ (.call 0 [] (lit 10)))
    = .ok (fibΔ, .call 0 [] (lit 10)) := rfl

/-! ## string / slice の演算 3 点（language.md 21 節。round5 の随時回収 —
examples/strings_ops.sober（.out）と同じ意味のケース） -/

/-- subslice: `s := freeze(append(append(mkslice, 5), 7)); t := s[1:2]; t[0] + len(t)`
→ 7 + 1 = 8 -/
def ex28 : Expr :=
  block (letE (Expr.freeze (append (append (mkslice true .int) (lit 5)) (lit 7)))
    (letE (Expr.subslice (var 0) (lit 1) (lit 2))
      (add (index (var 0) (lit 0)) (lenE (var 0)))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex28 = some .int := rfl
example : stepN [] 96 (load ex28) ∅ = (.ret [] [] (lit 8), ∅) := rfl

/-- subslice の範囲違反（b > len）は panic -/
def ex29 : Expr :=
  block (letE (Expr.freeze (append (mkslice true .int) (lit 5)))
    (Expr.subslice (var 0) (lit 0) (lit 2)))

example : stepN [] 64 (load ex29) ∅ = (.panic [[(false, lit 5)]], ∅) := rfl

/-- mut slice の subslice は型が付かない（imm 限定 — 21 節） -/
def ex30 : Expr :=
  block (letE (append (mkslice true .int) (lit 5))
    (Expr.subslice (var 0) (lit 0) (lit 1)))

example : typecheck [] ∅ [] 0 0 0 [] [] ex30 = none := rfl

/-- eqs（byte セル — 段 C で string = imm byte slice）: 同内容 [5] と [5] は tt、[5] と [7] は ff。ite で 1 / 0 に落とす -/
def ex31 : Expr :=
  block (letE (Expr.freeze (append (mkslice true .byte) (tobyte (lit 5))))
    (letE (Expr.freeze (append (mkslice true .byte) (tobyte (lit 5))))
      (letE (Expr.freeze (append (mkslice true .byte) (tobyte (lit 7))))
        (add (ite (Expr.eqs (var 2) (var 1)) (lit 10) (lit 0))
          (ite (Expr.eqs (var 2) (var 0)) (lit 1) (lit 0))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex31 = some .int := rfl
example : stepN [] 128 (load ex31) ∅ = (.ret [] [] (lit 10), ∅) := rfl

/-- concat: [5] + [7] → len 2、[0] = 5、[1] = 7 -/
def ex32 : Expr :=
  block (letE (Expr.freeze (append (mkslice true .int) (lit 5)))
    (letE (Expr.freeze (append (mkslice true .int) (lit 7)))
      (letE (Expr.concat (var 1) (var 0))
        (add (lenE (var 0))
          (add (index (var 0) (lit 0)) (index (var 0) (lit 1)))))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex32 = some .int := rfl
example : stepN [] 128 (load ex32) ∅ = (.ret [] [] (lit 14), ∅) := rfl

/-! ## bool（ソース層の bool 対応 — 比較ファミリの結果・条件は bool、int ↔ bool の暗黙変換なし。
examples/bool.sober（.out）と同じ意味のケース） -/

/-- `b := 4 == 4; b == (1 < 2)`。bool の等値はコアの cmp（int × int）に無いので、
脱糖器が `if a { b } else { !b }` の ite 形に落とす（その形をそのまま書いたもの）→ tt -/
def ex33 : Expr :=
  letE (cmp .eq (lit 4) (lit 4))
    (ite (var 0) (Expr.lt (lit 1) (lit 2)) (ite (Expr.lt (lit 1) (lit 2)) ff tt))

example : typecheck [] ∅ [] 0 0 0 [] [] ex33 = some .bool := rfl
example : stepN [] 64 (load ex33) ∅ = (.ret [] [] tt, ∅) := rfl

/-- `&&` / `!` の ite 脱糖: `!(3 > 5) && 2 >= 2` → tt -/
def ex34 : Expr :=
  ite (ite (cmp .gt (lit 3) (lit 5)) ff tt) (cmp .ge (lit 2) (lit 2)) ff

example : typecheck [] ∅ [] 0 0 0 [] [] ex34 = some .bool := rfl
example : stepN [] 64 (load ex34) ∅ = (.ret [] [] tt, ∅) := rfl

/-- 否定例: 比較の結果（bool）を int として足せない -/
example : typecheck [] ∅ [] 0 0 0 [] [] (add (cmp .eq (lit 1) (lit 1)) (lit 1)) = none := rfl
/-- 否定例: int を条件に使えない（if / while） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (ite (lit 1) (lit 2) (lit 3)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (whileE (lit 1) triv) = none := rfl
/-- 否定例: bool を比較ファミリに渡せない（bool の == は ite 形で書く） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (cmp .eq tt ff) = none := rfl
/-- 否定例: bool を返す腕と int を返す腕は混ぜられない -/
example : typecheck [] ∅ [] 0 0 0 [] [] (ite tt tt (lit 0)) = none := rfl

/-! ## 閉じた関数値（V3-1 — Ty.fn / fnref / callv）

辞書（関数型フィールドの struct）は関数値の pair 鎖。関数値は Def 参照で環境を持たない。
型は Def の base 座標のシグネチャ（型スキーム）で、callv が call と同じ +d シフトで instantiate する -/

/-- 関数表: 0 = incr : int → int、1 = isPos : int → bool、
2 = apply : (int → int) × int → int（関数値を受けて callv する高階 Def） -/
def fnΔ : Defs :=
  [ { param := .int, ret := .int, body := add (var 0) (lit 1) }
  , { param := .int, ret := .bool, body := cmp .gt (var 0) (lit 0) }
  , { param := .prod (.fn .int .int) .int, ret := .int,
      body := Expr.callv (Expr.fst (var 0)) (Expr.snd (var 0)) } ]

example : checkDefs fnΔ = true := rfl

/-- 関数値の直接呼び出し: `incr` を値として取り出して 41 に適用 → 42 -/
def ex35 : Expr := block (Expr.callv (Expr.fnref 0 []) (lit 41))

example : typecheck fnΔ ∅ [] 0 0 0 [] [] ex35 = some .int := rfl
example : (stepN fnΔ 64 (load ex35) ∅).1 = .ret [] [] (lit 42) := by native_decide

/-- 辞書 = 関数値の pair 鎖: `d := {incr, isPos}; if d.isPos(3) { d.incr(1) } else { 0 }` → 2 -/
def ex36 : Expr :=
  block (letE (pair (Expr.fnref 0 []) (Expr.fnref 1 []))
    (Expr.ite (Expr.callv (Expr.snd (var 0)) (lit 3))
      (Expr.callv (Expr.fst (var 0)) (lit 1)) (lit 0)))

example : typecheck fnΔ ∅ [] 0 0 0 [] [] ex36 = some .int := rfl
example : (stepN fnΔ 128 (load ex36) ∅).1 = .ret [] [] (lit 2) := by native_decide

/-- 高階 Def: `apply(incr, 5)` → 6（関数値が call の境界を渡る — loc-free なので relocate も恒等） -/
def ex37 : Expr := block (Expr.call 2 [] (pair (Expr.fnref 0 []) (lit 5)))

example : typecheck fnΔ ∅ [] 0 0 0 [] [] ex37 = some .int := rfl
example : (stepN fnΔ 128 (load ex37) ∅).1 = .ret [] [] (lit 6) := by native_decide

/-- 否定例: 関数でない値は呼べない -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (block (Expr.callv (lit 1) (lit 2))) = none := rfl
/-- 否定例: 引数の型違い（int → int に bool） -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (block (Expr.callv (Expr.fnref 0 []) .tt)) = none := rfl
/-- 否定例: callv は call と同じく深さ 1 以上（呼び手フレームが要る） -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (Expr.callv (Expr.fnref 0 []) (lit 1)) = none := rfl
/-- 否定例: 範囲外の関数 index -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (Expr.fnref 9 []) = none := rfl
/-- 否定例: シグネチャの違う関数値は高階 Def に渡せない（isPos : int → bool） -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (block (Expr.call 2 [] (pair (Expr.fnref 1 []) (lit 5)))) = none := rfl
/-- 否定例: 結果型（bool）を int として使えない -/
example : typecheck fnΔ ∅ [] 0 0 0 [] []
    (block (add (Expr.callv (Expr.fnref 1 []) (lit 1)) (lit 1))) = none := rfl

/-- 関数値は深さ・世界に依らず型が付く（loc-free。par の Γ にも mutFree で入れる） -/
example : typecheck fnΔ ∅ [] 0 0 0 [] [] (Expr.fnref 2 [])
    = some (.fn (.prod (.fn .int .int) .int) .int) := rfl

example : programFromJson 200 (programToJson fnΔ ex36) = .ok (fnΔ, ex36) := rfl

/-! ## Def の型パラメータ（V3-2 — tvar・明示の型適用・型代入）

Def の本体は tvar を抽象型のまま一度だけ型付けされ（DefsOk）、呼び出しは型引数で代入した
仮想 Def（`dfn.inst ts`）を instantiate する。型引数は loc-free・chan-free な型に限る -/

/-- 0 = id[T](x T) T、1 = twice[T](x T) T（ジェネリックがジェネリックを呼ぶ）、
2 = apply[T](d (T → T) × T) T（辞書 = 関数値を受けて callv）、3 = not : bool → bool、
4 = incr : int → int -/
def genΔ : Defs :=
  [ { tparams := 1, param := .tvar 0, ret := .tvar 0, body := var 0 }
  , { tparams := 1, param := .tvar 0, ret := .tvar 0,
      body := Expr.call 0 [.tvar 0] (Expr.call 0 [.tvar 0] (var 0)) }
  , { tparams := 1, param := .prod (.fn (.tvar 0) (.tvar 0)) (.tvar 0), ret := .tvar 0,
      body := Expr.callv (Expr.fst (var 0)) (Expr.snd (var 0)) }
  , { param := .bool, ret := .bool, body := Expr.ite (var 0) ff tt }
  , { param := .int, ret := .int, body := add (var 0) (lit 1) } ]

example : checkDefs genΔ = true := rfl

/-- 単一の定義を 2 つの型で呼ぶ: `id[int](41) + (if id[bool](true) { 1 } else { 0 })` → 42 -/
def ex38 : Expr :=
  block (add (Expr.call 0 [.int] (lit 41))
    (Expr.ite (Expr.call 0 [.bool] tt) (lit 1) (lit 0)))

example : typecheck genΔ ∅ [] 0 0 0 [] [] ex38 = some .int := rfl
example : (stepN genΔ 128 (load ex38) ∅).1 = .ret [] [] (lit 42) := by native_decide

/-- ジェネリックがジェネリックを呼ぶ + 構造体の型引数: `twice[int × bool]((7, true))` の
第 1 成分 → 7（入れ子の型適用が代入の合成で閉じる） -/
def ex39 : Expr :=
  block (Expr.fst (Expr.call 1 [.prod .int .bool] (pair (lit 7) tt)))

example : typecheck genΔ ∅ [] 0 0 0 [] [] ex39 = some .int := rfl
example : (stepN genΔ 128 (load ex39) ∅).1 = .ret [] [] (lit 7) := by native_decide

/-- 辞書渡し: `apply[int]((incr, 5))` → 6、`apply[bool]((not, false))` → true。
同じ本体（callv を含む）が 2 つの型で走る -/
def ex40 : Expr :=
  block (letE (Expr.call 2 [.bool] (pair (Expr.fnref 3 []) ff))
    (Expr.ite (var 0) (Expr.call 2 [.int] (pair (Expr.fnref 4 []) (lit 5))) (lit 0)))

example : typecheck genΔ ∅ [] 0 0 0 [] [] ex40 = some .int := rfl
example : (stepN genΔ 256 (load ex40) ∅).1 = .ret [] [] (lit 6) := by native_decide

/-- ジェネリック Def の関数値（型適用つき fnref）: `(id[bool])(true)` -/
example : typecheck genΔ ∅ [] 0 0 0 [] [] (Expr.fnref 0 [.bool]) = some (.fn .bool .bool) := rfl
example : typecheck genΔ ∅ [] 0 0 0 [] [] (block (Expr.callv (Expr.fnref 0 [.bool]) tt))
    = some .bool := rfl

/-- 否定例: 型引数の個数違い -/
example : typecheck genΔ ∅ [] 0 0 0 [] [] (block (Expr.call 0 [] (lit 1))) = none := rfl
/-- 否定例: 型引数と実引数の不一致（id[int] に bool） -/
example : typecheck genΔ ∅ [] 0 0 0 [] [] (block (Expr.call 0 [.int] tt)) = none := rfl
/-- 否定例: region を持つ型は型引数にできない（loc-free 限定） -/
example : typecheck genΔ ∅ [] 0 0 0 [] []
    (block (Expr.call 0 [.slice false 0 .int] (Expr.freeze (mkslice true .int)))) = none := rfl
/-- 否定例: 結果の型は型引数で決まる（id[bool] の結果を int として使えない） -/
example : typecheck genΔ ∅ [] 0 0 0 [] [] (block (add (Expr.call 0 [.bool] tt) (lit 1))) = none := rfl
/-- 否定例（パラメトリシティ）: tvar の値を int として扱う本体は DefsOk を通らない -/
example : checkDefs [{ tparams := 1, param := .tvar 0, ret := .int, body := add (var 0) (lit 1) }]
    = false := rfl
/-- 否定例: シグネチャの tvar が型パラメータの範囲外 -/
example : checkDefs [{ tparams := 1, param := .tvar 1, ret := .tvar 1, body := var 0 }]
    = false := rfl

example : programFromJson 300 (programToJson genΔ ex40) = .ok (genΔ, ex40) := rfl

/-! 型注釈 ann（V3-5）: 部分型へ緩めるだけの注釈。脱糖器が inline 展開で消える仮引数の型を書き込み、
検査を Lean に返す。値は変えない（注釈値だけ coerceTo で書き換わる） -/

/-- 自明な注釈: `(1 : int) + 2` → 3 -/
def ex41 : Expr := block (add (Expr.ann (lit 1) .int) (lit 2))

example : typecheck [] ∅ [] 0 0 0 [] [] ex41 = some .int := rfl
example : (stepN [] 64 (load ex41) ∅).1 = .ret [] [] (lit 3) := by native_decide

/-- imm 上界の緩め: region 0 の slice を内側ブロックで region 1 の上界に注釈して len → 0 -/
def ex42 : Expr :=
  block (letE (Expr.freeze (mkslice true .int))
    (block (lenE (Expr.ann (var 0) (.slice false 1 .int)))))

example : typecheck [] ∅ [] 0 0 0 [] [] ex42 = some .int := rfl
example : (stepN [] 64 (load ex42) ∅).1 = .ret [] [] (lit 0) := by native_decide

/-- 注釈値の書き換え: nil の注釈 (slice r0) を opt (slice r1) へ緩めて ifnil → 5 -/
def ex43 : Expr :=
  block (block (Expr.ifnil (Expr.ann (Expr.nil (.slice false 0 .int)) (.opt (.slice false 1 .int)))
    (lit 5) (lit 6)))

example : typecheck [] ∅ [] 0 0 0 [] [] ex43 = some .int := rfl
example : (stepN [] 64 (load ex43) ∅).1 = .ret [] [] (lit 5) := by native_decide

/-- 否定例: 型の違う注釈（bool を int と注釈） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (Expr.ann tt .int)) = none := rfl
/-- 否定例: sub の逆向き（region 1 の上界を region 0 へ締められない） -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (block (Expr.ann (Expr.freeze (mkslice true .int)) (.slice false 0 .int)))) = none := rfl
/-- 否定例: mut の region は正確（region 0 の mut slice を region 1 と注釈できない） -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (block (lenE (Expr.ann (mkslice true .int) (.slice true 0 .int))))) = none := rfl
/-- 否定例: 要素型は正確なまま（imm slice の要素型を変えられない） -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (lenE (Expr.ann (Expr.freeze (mkslice true .int)) (.slice false 0 .bool)))) = none := rfl

example : programFromJson 300 (programToJson [] ex43) = .ok ([], ex43) := rfl

/-! ## label / jump（V4-2 — 脱出の 1 組。return / break / continue / `?` の受け皿）
jump の t は結果型の注釈（構文主導。裁定 J1）。巻き戻しは途中の region を pop する -/

/-- 正常完了: 本体の値がそのままラベルの値 -/
def ex44 : Expr := label .int (add (lit 1) (lit 2))
example : typecheck [] ∅ [] 0 0 0 [] [] ex44 = some .int := rfl
example : (stepN [] 64 (load ex44) ∅).1 = .ret [] [] (lit 3) := by native_decide

/-- 途中脱出: add の右オペランドから抜ける（左の 1 と add は捨てられる） -/
def ex45 : Expr := label .int (add (lit 1) (jump 0 .int (lit 10)))
example : typecheck [] ∅ [] 0 0 0 [] [] ex45 = some .int := rfl
example : (stepN [] 64 (load ex45) ∅).1 = .ret [] [] (lit 10) := by native_decide

/-- 入れ子: 内側のラベルを飛び越えて外側へ（jump 1） -/
def ex46 : Expr := label .int (add (lit 100) (label .int (add (lit 1) (jump 1 .int (lit 7)))))
example : typecheck [] ∅ [] 0 0 0 [] [] ex46 = some .int := rfl
example : (stepN [] 64 (load ex46) ∅).1 = .ret [] [] (lit 7) := by native_decide

/-- region 越え: block の中で割り当てた値を読んで脱出。巻き戻しが region を pop するので
最終ヒープは空 -/
def ex47 : Expr := label .int (block (letE (alloc true (lit 5)) (jump 0 .int (deref (var 0)))))
example : typecheck [] ∅ [] 0 0 0 [] [] ex47 = some .int := rfl
example : (stepN [] 64 (load ex47) ∅).1 = .ret [] [] (lit 5) := by native_decide

/-- break の形: while の外側のラベルへ脱出（カウンタが 3 を超えた回で抜ける） -/
def ex48 : Expr :=
  block (letE (alloc true (lit 0))
    (letE (label .unit (whileE tt
        (letE (assign (var 0) (add (deref (var 0)) (lit 1)))
          (ite (lt (lit 2) (deref (var 1))) (jump 0 .unit triv) triv))))
      (deref (var 1))))
example : typecheck [] ∅ [] 0 0 0 [] [] ex48 = some .int := rfl
example : (stepN [] 256 (load ex48) ∅).1 = .ret [] [] (lit 3) := by native_decide

/-- 否定例: ラベル環境の範囲外への jump -/
example : typecheck [] ∅ [] 0 0 0 [] [] (label .int (jump 1 .int (lit 1))) = none := rfl
/-- 否定例: ペイロードの型がラベルの型と不一致 -/
example : typecheck [] ∅ [] 0 0 0 [] [] (label .int (jump 0 .int tt)) = none := rfl
/-- 否定例: ラベルの外（Λ = []）での jump -/
example : typecheck [] ∅ [] 0 0 0 [] [] (jump 0 .int (lit 1)) = none := rfl
/-- 否定例: ラベルの型は置いた深さの region までしか言及できない（block の escape 検査と同じ床）。
label 無しなら同じ文脈で var 0 は型が付く -/
example : typecheck [] ∅ [] 0 0 1 [.ref true 1 .int] [] (label (.ref true 1 .int) (var 0)) = none := rfl
example : typecheck [] ∅ [] 0 0 1 [.ref true 1 .int] [] (var 0) = some (.ref true 1 .int) := rfl

example : programFromJson 300 (programToJson [] ex48) = .ok ([], ex48) := rfl


/-! V4-3 の突き合わせの対: examples/early_return_pure.sober の脱糖結果（`sober check --core-json`）を
機械で走らせ、codegen の実行結果（151324）と照合する。途中 return・if 腕の return・ループ内の return
（式ブロックの region を開いたまま）・break / continue・inline 展開を越えるラムダの非局所 return・
defer の出口展開を踏む。脱糖器を変えてこの JSON が変わったら貼り直す -/
def v43json : String := "{\"defs\":[{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"lit\",\"n\":-1}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"lit\",\"n\":0}},\"e\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"lit\",\"n\":1}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":10}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"v\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":0},\"i\":{\"k\":\"lit\",\"n\":0}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"gt\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"var\",\"i\":3}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"v\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}},\"body\":{\"k\":\"var\",\"i\":1}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"v\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}},\"body\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"lit\",\"n\":-1}}}}},{\"param\":{\"k\":\"unit\"},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":3}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"label\",\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":5}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":2}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"triv\"}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":4}},\"t\":{\"k\":\"jump\",\"n\":1,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"triv\"}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":6},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":6}},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":5}},\"b\":{\"k\":\"lit\",\"n\":10}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}}}},\"body\":{\"k\":\"triv\"}}}}}}}},\"body\":{\"k\":\"triv\"}}}}},\"body\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"lit\",\"n\":10},\"t\":{\"k\":\"int\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"t\":{\"k\":\"int\"}},\"body\":{\"k\":\"ann\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"gt\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"var\",\"i\":3}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"var\",\"i\":0}},\"e\":{\"k\":\"triv\"}},\"t\":{\"k\":\"unit\"}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"lit\",\"n\":-1}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"bool\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"var\",\"i\":2},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"var\",\"i\":1}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"var\",\"i\":1}}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"lit\",\"n\":-5}},\"b\":{\"k\":\"lit\",\"n\":2}},\"b\":{\"k\":\"lit\",\"n\":100000}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"lit\",\"n\":20}},\"b\":{\"k\":\"lit\",\"n\":10000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"triv\"}},\"b\":{\"k\":\"lit\",\"n\":10}}},\"b\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"lit\",\"n\":10}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"false\"},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":4},\"b\":{\"k\":\"lit\",\"n\":5}}}},\"b\":{\"k\":\"lit\",\"n\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":0},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"var\",\"i\":1}}}}}"

example : (match parseProgram v43json with
    | .ok (Δ, e) => (stepN Δ 20000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 151324) := by native_decide

/-- V4-4b の突き合わせの対: examples/try_prop_pure.sober（codegen の値 103603391）の脱糖 JSON を機械で実行する。
後置 `?`（S1 = unit 注釈の jump を ifnil の some 腕に置く形）・ゼロ値の入口束縛（Z1、slice の結果成分）・
3 成分の結果と多値の分解・ループ内 / 式ブロック内の `?`・defer を越える `?`・inline 関数の `?`・
ラムダの非局所 `?`・`(error?)` 単値の `?` を踏む。脱糖器の出力が変わったら
`sober check examples/try_prop_pure.sober --core-json` を貼り直す -/
def v44json : String := "{\"defs\":[{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"var\",\"i\":0}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"gt\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":99}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":99}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"div\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":10}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"mod\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":10}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":3}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"append\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"v\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"v\":{\"k\":\"var\",\"i\":3}},\"body\":{\"k\":\"var\",\"i\":1}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"v\":{\"k\":\"var\",\"i\":2}},\"body\":{\"k\":\"var\",\"i\":1}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"var\",\"i\":0},\"t\":{\"k\":\"int\"}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}},\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"let\",\"e\":{\"k\":\"ann\",\"e\":{\"k\":\"var\",\"i\":0},\"t\":{\"k\":\"int\"}},\"body\":{\"k\":\"ann\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":3}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":1,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"b\":{\"k\":\"lit\",\"n\":1}},\"t\":{\"k\":\"int\"}}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}},\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}},{\"param\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"lit\",\"n\":0},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":1000},\"b\":{\"k\":\"var\",\"i\":0}},\"r\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"sub\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":2000},\"b\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":12}},\"v\":{\"k\":\"lit\",\"n\":34}},\"v\":{\"k\":\"lit\",\"n\":5}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":12}},\"v\":{\"k\":\"lit\",\"n\":-7}},\"v\":{\"k\":\"lit\",\"n\":5}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"lit\",\"n\":41}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"lit\",\"n\":150}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"lit\",\"n\":20}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"lit\",\"n\":40}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"lit\",\"n\":-2}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":21}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":21},\"i\":{\"k\":\"lit\",\"n\":0}}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":21},\"i\":{\"k\":\"lit\",\"n\":1}}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":21},\"i\":{\"k\":\"lit\",\"n\":2}}},\"b\":{\"k\":\"var\",\"i\":20}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":19}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":18}},\"b\":{\"k\":\"var\",\"i\":17}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":16}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":15},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":14}}},\"b\":{\"k\":\"var\",\"i\":12}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":11}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":10},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":9}}},\"b\":{\"k\":\"var\",\"i\":7}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":6}}},\"b\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":3}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"lit\",\"n\":3}}},\"b\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"lit\",\"n\":-3}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":10}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":1000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":100000}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":0},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"var\",\"i\":1}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}"

example : (match parseProgram v44json with
    | .ok (Δ, e) => (stepN Δ 200000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 103603391) := by native_decide

/-- V4-4c の突き合わせの対: examples/try_wrap_pure.sober（codegen の値 10970020042）。包み替え `f()? L{…}`
（err を捨てて L に置き換える — K3。フィールドはエラーの経路でだけ評価）をループ内で踏む。貼り直しは v44 と同じ -/
def v45json : String := "{\"defs\":[{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":48}},\"t\":{\"k\":\"true\"},\"e\":{\"k\":\"gt\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":57}}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"var\",\"i\":0}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"sub\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":48}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":2},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":5},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":1}}}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":10}},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}}}}},{\"param\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"lit\",\"n\":0},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":100},\"b\":{\"k\":\"var\",\"i\":0}},\"r\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"lit\",\"n\":1000},\"b\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":1},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":52}},\"v\":{\"k\":\"lit\",\"n\":50}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":7},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":120}},\"v\":{\"k\":\"lit\",\"n\":51}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":65},\"b\":{\"k\":\"lit\",\"n\":9}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":7},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"var\",\"i\":6}},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"lit\",\"n\":1000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":10000}}},\"b\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":100000000}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":0},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"var\",\"i\":1}}}}}}}}}}}}}}"

example : (match parseProgram v45json with
    | .ok (Δ, e) => (stepN Δ 20000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 10970020042) := by native_decide

/-- V4-4e の突き合わせの対: examples/errparse_pure.sober（codegen の値 98650273863090）。検証例 errparse の
ミニ lexer（ループ内の `?`・slice の結果成分のゼロ値 = Z1）+ 再帰下降 parser（3 成分の結果・相互再帰の中の `?`）+
トップの包み替え + オフセット → line:col の解決を、9 本の入力の結果を畳み込んだ 1 語で照合する。貼り直しは v44 と同じ -/
def v46json : String := "{\"defs\":[{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"bool\"},\"body\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":48}},\"t\":{\"k\":\"le\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":57}},\"e\":{\"k\":\"false\"}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":43}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":1},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":45}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":2},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":42}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":3},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"lit\",\"n\":40}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":4},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":5},\"b\":{\"k\":\"lit\",\"n\":41}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":5},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}},\"e\":{\"k\":\"var\",\"i\":5}}}}}}}}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":1},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":2},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":32}},\"t\":{\"k\":\"true\"},\"e\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":10}}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}},\"e\":{\"k\":\"if\",\"c\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":5}}},\"t\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":5},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"e\":{\"k\":\"false\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"sub\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":10}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":5},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"b\":{\"k\":\"lit\",\"n\":48}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":5},\"e\":{\"k\":\"append\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":5}},\"v\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":5},\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}},\"body\":{\"k\":\"triv\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":3},\"e\":{\"k\":\"append\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}},\"v\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":0}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":3},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"append\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"v\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":6},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":0}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":1},\"i\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":1}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":2}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":4}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"ne\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":7},\"i\":{\"k\":\"var\",\"i\":0}}},\"b\":{\"k\":\"lit\",\"n\":5}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"int\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":7},\"i\":{\"k\":\"var\",\"i\":0}}}},\"b\":{\"k\":\"lit\",\"n\":5}}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":1}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":6}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":3}}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"int\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":4}}},\"b\":{\"k\":\"lit\",\"n\":0}}}}}}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":6},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"b\":{\"k\":\"lit\",\"n\":3}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"triv\"}}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":6},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"b\":{\"k\":\"lit\",\"n\":1}},\"t\":{\"k\":\"true\"},\"e\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":6},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}},\"b\":{\"k\":\"lit\",\"n\":2}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":9},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}}}},\"b\":{\"k\":\"lit\",\"n\":1}},\"t\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"var\",\"i\":1}},\"e\":{\"k\":\"sub\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"triv\"}}}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"ne\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"var\",\"i\":0}}},\"b\":{\"k\":\"lit\",\"n\":6}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"int\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"var\",\"i\":0}}}},\"b\":{\"k\":\"lit\",\"n\":6}}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"lit\",\"n\":1}}}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"lit\",\"n\":2}}}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":1},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"var\",\"i\":4}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}},\"b\":{\"k\":\"lit\",\"n\":10}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"lit\",\"n\":1}},\"body\":{\"k\":\"triv\"}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}}}}}}}}}}},{\"param\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"var\",\"i\":0},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"var\",\"i\":0},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"var\",\"i\":1}}},\"r\":{\"k\":\"lit\",\"n\":0}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":6,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"var\",\"i\":1},\"some\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":8,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"call\",\"f\":9,\"e\":{\"k\":\"var\",\"i\":0}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":3},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":100000},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"var\",\"i\":1}},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":200000},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"var\",\"i\":2}},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":300000},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":10000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"var\",\"i\":5}}}},\"r\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":900000},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":7,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"var\",\"i\":1},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"lit\",\"n\":1}},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"lit\",\"n\":1}},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"r\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":900000},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":50}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":42}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":40}},\"v\":{\"k\":\"lit\",\"n\":51}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":45}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":52}},\"v\":{\"k\":\"lit\",\"n\":41}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":50}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":42}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":51}},\"v\":{\"k\":\"lit\",\"n\":10}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":52}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":42}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":45}},\"v\":{\"k\":\"lit\",\"n\":53}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":36}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":3},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":50}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":42}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":40}},\"v\":{\"k\":\"lit\",\"n\":51}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":52}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":55}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":10}},\"v\":{\"k\":\"lit\",\"n\":10}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":5},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":5}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":50}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":6},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":6}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":10,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":51}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":42}},\"v\":{\"k\":\"lit\",\"n\":10}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":32}},\"v\":{\"k\":\"lit\",\"n\":49}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":7},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":7}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":11,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":49}},\"v\":{\"k\":\"lit\",\"n\":43}},\"v\":{\"k\":\"lit\",\"n\":49}}},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":50}},\"v\":{\"k\":\"lit\",\"n\":42}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":8},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":8}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":11,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":53}}},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":40}},\"v\":{\"k\":\"lit\",\"n\":54}},\"v\":{\"k\":\"lit\",\"n\":41}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":9}},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":10}}}}}}}}}}}}}}}"

example : (match parseProgram v46json with
    | .ok (Δ, e) => (stepN Δ 2000000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 98650273863090) := by native_decide

/-- io-2 の突き合わせの対: examples/utf8_pure.sober（codegen の値 88186396779）。`string(b)`（cst_to_ast が
std/utf8.FromBytes の呼び出しに置き換える）の UTF-8 検査（Go の unicode/utf8 がオラクル — examples/utf8_std）・
検査後の恒等の戻し（std 専用 bytesToString）・`string(b)?` の伝播と包み替えを 1 語に畳み込んで照合する。貼り直しは v44 と同じ -/
def v47json : String := "{\"defs\":[{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":7,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":1}},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":2000},\"b\":{\"k\":\"var\",\"i\":0}},\"r\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":1000},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":7,\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"int\"},\"e\":{\"k\":\"var\",\"i\":4}}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"concat\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":33}}}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":1}},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":2000},\"b\":{\"k\":\"var\",\"i\":0}},\"r\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":1000},\"b\":{\"k\":\"var\",\"i\":0}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"ret\":{\"k\":\"bool\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":2}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":3}}}},\"body\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":3}}},\"t\":{\"k\":\"ge\",\"a\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"var\",\"i\":1}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"le\",\"a\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":3},\"i\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"var\",\"i\":0}},\"e\":{\"k\":\"false\"}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"int\"},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":1},\"i\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"lt\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":128}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"lit\",\"n\":1}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":194}},\"t\":{\"k\":\"le\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"lit\",\"n\":223}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"if\",\"c\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":1}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":128},\"b\":{\"k\":\"lit\",\"n\":191}}}}},\"t\":{\"k\":\"lit\",\"n\":2},\"e\":{\"k\":\"lit\",\"n\":0}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":224}},\"t\":{\"k\":\"le\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":239}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"lit\",\"n\":224}},\"t\":{\"k\":\"lit\",\"n\":160},\"e\":{\"k\":\"lit\",\"n\":128}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":237}},\"t\":{\"k\":\"lit\",\"n\":159},\"e\":{\"k\":\"lit\",\"n\":191}},\"body\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":5},\"b\":{\"k\":\"lit\",\"n\":1}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}}}},\"t\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":5},\"b\":{\"k\":\"lit\",\"n\":2}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":128},\"b\":{\"k\":\"lit\",\"n\":191}}}}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"lit\",\"n\":3},\"e\":{\"k\":\"lit\",\"n\":0}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":240}},\"t\":{\"k\":\"le\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":244}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":240}},\"t\":{\"k\":\"lit\",\"n\":144},\"e\":{\"k\":\"lit\",\"n\":128}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"lit\",\"n\":244}},\"t\":{\"k\":\"lit\",\"n\":143},\"e\":{\"k\":\"lit\",\"n\":191}},\"body\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":7},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"lit\",\"n\":1}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}}}}},\"t\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":7},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"lit\",\"n\":2}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":128},\"b\":{\"k\":\"lit\",\"n\":191}}}}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":7},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":6},\"b\":{\"k\":\"lit\",\"n\":3}},\"b\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":128},\"b\":{\"k\":\"lit\",\"n\":191}}}}},\"e\":{\"k\":\"false\"}},\"t\":{\"k\":\"lit\",\"n\":4},\"e\":{\"k\":\"lit\",\"n\":0}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"lit\",\"n\":0}}}}}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":-1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"if\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":2}}},\"e\":{\"k\":\"false\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":2},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"eq\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}}},\"body\":{\"k\":\"triv\"}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"var\",\"i\":0}}},\"body\":{\"k\":\"triv\"}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"bool\"},\"body\":{\"k\":\"lt\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":0}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"ge\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"int\"},\"e\":{\"k\":\"var\",\"i\":0}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":2},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"ann\",\"e\":{\"k\":\"var\",\"i\":0},\"t\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}}},\"b\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"int\"}}}}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":0},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":104}},\"v\":{\"k\":\"lit\",\"n\":105}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":227}},\"v\":{\"k\":\"lit\",\"n\":129}},\"v\":{\"k\":\"lit\",\"n\":130}},\"v\":{\"k\":\"lit\",\"n\":104}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":2},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":104}},\"v\":{\"k\":\"lit\",\"n\":237}},\"v\":{\"k\":\"lit\",\"n\":160}},\"v\":{\"k\":\"lit\",\"n\":128}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":3},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":240}},\"v\":{\"k\":\"lit\",\"n\":159}},\"v\":{\"k\":\"lit\",\"n\":152}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":4},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":4}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":97}},\"v\":{\"k\":\"lit\",\"n\":98}},\"v\":{\"k\":\"lit\",\"n\":128}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":5},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":5}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":6},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":6}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":3},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":111}},\"v\":{\"k\":\"lit\",\"n\":107}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":7},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":7}},\"b\":{\"k\":\"lit\",\"n\":31}},\"b\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":7},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":111}},\"v\":{\"k\":\"lit\",\"n\":192}},\"v\":{\"k\":\"lit\",\"n\":128}}}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":8}},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":9}}}}}}}}}}}}}}"

example : (match parseProgram v47json with
    | .ok (Δ, e) => (stepN Δ 200000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 88186396779) := by native_decide


/-! ### 部分検査の封筒（V5-6 = I-3）: body の無い Def は署名だけで、検査しない -/
-- f0 は署名だけ（int → bool と宣言）、f1 は本体つきで f0 を呼ぶ。f1 だけが検査される
def partsOk : String :=
  "{\"parts\":true,\"defs\":[{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"bool\"}}," ++
  "{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"bool\"},\"body\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}}}]}"
example : (match (checkInput partsOk).getObjVal? "ok" with
    | .ok (.bool true) => true
    | _ => false) = true := by native_decide
-- 署名が int → int なら f1 の本体（bool を返すはず）が型エラーになる
def partsBad : String :=
  "{\"parts\":true,\"defs\":[{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"int\"}}," ++
  "{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"bool\"},\"body\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"var\",\"i\":0}}}]}"
example : (match (checkInput partsBad).getObjVal? "ok" with
    | .ok (.bool false) => true
    | _ => false) = true := by native_decide


/-! R0（region 多相の裁定 — 系統 R）: call 結果の opt / union の中のコンテナも呼び手最内へ締まる。
L1（error ラベルの loc-free 制限）の解除の Lean 側。旧 relocR は opt / union の中身を shiftR のまま残し、
中の slice の上界が pop 済みの region（1 + d）を指していたので、別の Def の imm 引数へ渡せなかった -/

/-- 自フレームで作った slice を opt / union に包んで返す Def と、それを imm 引数に取る Def -/
def r0Δ : Defs :=
  [ { param := .int, ret := .opt (.slice false 1 .int)
      body := some (append (mkslice false .int) (lit 7)) }
  , { param := .slice false 0 .int, ret := .int
      body := add (lenE (var 0)) (index (var 0) (lit 0)) }
  , { param := .int, ret := .union (.slice false 1 .int) .int
      body := inl .int (append (mkslice false .int) (lit 40)) } ]

example : checkDefs r0Δ = true := by native_decide

/-- `if v := f(); v != nil { g(v) } else { 0 }` — 結果の中身が呼び手最内（region 0）に締まる -/
def exR0a : Expr := block (ifnil (call 0 [] (lit 0)) (lit 0) (call 1 [] (var 0)))
example : typecheck r0Δ ∅ [] 0 0 0 [] [] exR0a = some .int := by native_decide
example : typecheck r0Δ ∅ [] 0 0 1 [] [] (call 0 [] (lit 0)) = some (.opt (.slice false 0 .int)) := by native_decide
example : (stepN r0Δ 200 (load exR0a) ∅).1 = .ret [] [] (lit 8) := by native_decide

/-- union の腕の中のコンテナ（error ラベルの string フィールドと同じ形） -/
def exR0b : Expr := block (case (call 2 [] (lit 0)) (call 1 [] (var 0)) (var 0))
example : typecheck r0Δ ∅ [] 0 0 0 [] [] exR0b = some .int := by native_decide
example : (stepN r0Δ 200 (load exR0b) ∅).1 = .ret [] [] (lit 41) := by native_decide

/-- nil 腕: fretK の coerceTo が注釈を締めた型に揃える（旧 relocR なら nil の注釈と型がずれる形） -/
def r0Δn : Defs :=
  [ { param := .int, ret := .opt (.slice false 1 .int), body := nil (.slice false 1 .int) }
  , { param := .slice false 0 .int, ret := .int
      body := add (lenE (var 0)) (index (var 0) (lit 0)) } ]
def exR0c : Expr := block (ifnil (call 0 [] (lit 0)) (lit 5) (call 1 [] (var 0)))
example : typecheck r0Δn ∅ [] 0 0 0 [] [] exR0c = some .int := by native_decide
example : (stepN r0Δn 200 (load exR0c) ∅).1 = .ret [] [] (lit 5) := by native_decide


/-- R0 の突き合わせの対: examples/errlabel_pure.sober（codegen の値 30030252789114820）。error ラベルの string / slice
フィールド（呼び手由来・callee 構築・ループで伸ばした slice）が `?` の伝播と戻り値の境界コピー（opt / union の中の
relocate + fretK の coerceTo）を越えて呼び手に届くことを、中身を 1 語に畳み込んで照合する。貼り直しは v44 と同じ -/
def v48json : String := "{\"defs\":[{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"bool\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"var\",\"i\":0},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"var\",\"i\":2}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}},{\"param\":{\"k\":\"prod\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"true\"}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":0,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"false\"}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"ifnil\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":0}},\"nil\":{\"k\":\"triv\"},\"some\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"some\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":1}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":1},\"b\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}},{\"param\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"some\",\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}},\"e\":{\"k\":\"concat\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":46}},\"v\":{\"k\":\"lit\",\"n\":98}},\"v\":{\"k\":\"lit\",\"n\":97}},\"v\":{\"k\":\"lit\",\"n\":107}}}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"alloc\",\"mut\":true,\"e\":{\"k\":\"lit\",\"n\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"while\",\"c\":{\"k\":\"lt\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"var\",\"i\":2}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"append\",\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"v\":{\"k\":\"mul\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":0}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"assign\",\"l\":{\"k\":\"var\",\"i\":1},\"e\":{\"k\":\"add\",\"a\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":1}},\"b\":{\"k\":\"lit\",\"n\":1}}},\"body\":{\"k\":\"triv\"}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"gt\",\"a\":{\"k\":\"var\",\"i\":3},\"b\":{\"k\":\"lit\",\"n\":3}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"e\":{\"k\":\"inl\",\"r\":{\"k\":\"int\"},\"e\":{\"k\":\"deref\",\"e\":{\"k\":\"var\",\"i\":2}}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}}}}},{\"param\":{\"k\":\"int\"},\"ret\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"body\":{\"k\":\"label\",\"t\":{\"k\":\"prod\",\"l\":{\"k\":\"int\"},\"r\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}},\"e\":{\"k\":\"let\",\"e\":{\"k\":\"if\",\"c\":{\"k\":\"gt\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"lit\",\"n\":0}},\"t\":{\"k\":\"jump\",\"n\":0,\"t\":{\"k\":\"unit\"},\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"var\",\"i\":0},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"nil\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}},\"e\":{\"k\":\"triv\"}},\"body\":{\"k\":\"pair\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"ann\",\"e\":{\"k\":\"some\",\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"e\":{\"k\":\"inr\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"e\":{\"k\":\"var\",\"i\":1}}}},\"t\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":1,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}}}}}}},{\"param\":{\"k\":\"opt\",\"t\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"union\",\"l\":{\"k\":\"slice\",\"m\":false,\"r\":0,\"t\":{\"k\":\"int\"}},\"r\":{\"k\":\"int\"}}}},\"ret\":{\"k\":\"int\"},\"body\":{\"k\":\"ifnil\",\"e\":{\"k\":\"var\",\"i\":0},\"nil\":{\"k\":\"lit\",\"n\":0},\"some\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":1000},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":10}}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":0},\"i\":{\"k\":\"lit\",\"n\":0}}},\"r\":{\"k\":\"case\",\"e\":{\"k\":\"var\",\"i\":0},\"l\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"lit\",\"n\":2000},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"index\",\"e\":{\"k\":\"var\",\"i\":0},\"i\":{\"k\":\"sub\",\"a\":{\"k\":\"len\",\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":1}}}},\"r\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":3000},\"b\":{\"k\":\"var\",\"i\":0}}}}}}],\"e\":{\"k\":\"block\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":1,\"e\":{\"k\":\"pair\",\"a\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":97}},\"v\":{\"k\":\"lit\",\"n\":46}},\"v\":{\"k\":\"lit\",\"n\":116}},\"v\":{\"k\":\"lit\",\"n\":120}},\"v\":{\"k\":\"lit\",\"n\":116}}},\"b\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":98}},\"v\":{\"k\":\"lit\",\"n\":46}},\"v\":{\"k\":\"lit\",\"n\":116}},\"v\":{\"k\":\"lit\",\"n\":120}},\"v\":{\"k\":\"lit\",\"n\":116}}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":2,\"e\":{\"k\":\"freeze\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"append\",\"e\":{\"k\":\"mkslice\",\"m\":true,\"t\":{\"k\":\"int\"}},\"v\":{\"k\":\"lit\",\"n\":99}},\"v\":{\"k\":\"lit\",\"n\":46}},\"v\":{\"k\":\"lit\",\"n\":116}},\"v\":{\"k\":\"lit\",\"n\":120}},\"v\":{\"k\":\"lit\",\"n\":116}}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"lit\",\"n\":5}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":3,\"e\":{\"k\":\"lit\",\"n\":2}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"call\",\"f\":4,\"e\":{\"k\":\"sub\",\"a\":{\"k\":\"lit\",\"n\":0},\"b\":{\"k\":\"lit\",\"n\":3}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"fst\",\"e\":{\"k\":\"var\",\"i\":0}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"snd\",\"e\":{\"k\":\"var\",\"i\":1}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"add\",\"a\":{\"k\":\"var\",\"i\":13},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"var\",\"i\":4},\"b\":{\"k\":\"lit\",\"n\":10}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":12}},\"b\":{\"k\":\"lit\",\"n\":100}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":9}},\"b\":{\"k\":\"lit\",\"n\":1000000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":6}},\"b\":{\"k\":\"lit\",\"n\":100000000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":3}},\"b\":{\"k\":\"lit\",\"n\":1000000000000}}},\"b\":{\"k\":\"mul\",\"a\":{\"k\":\"call\",\"f\":5,\"e\":{\"k\":\"var\",\"i\":0}},\"b\":{\"k\":\"lit\",\"n\":10000000000000}}},\"body\":{\"k\":\"let\",\"e\":{\"k\":\"let\",\"e\":{\"k\":\"var\",\"i\":0},\"body\":{\"k\":\"triv\"}},\"body\":{\"k\":\"var\",\"i\":1}}}}}}}}}}}}}}}}}}}}"

example : (match parseProgram v48json with
    | .ok (Δ, e) => (stepN Δ 200000 (load e) ∅).1
    | .error _ => .panic []) = .ret [] [] (lit 30030252789114820) := by native_decide


/-! R2（region 多相の裁定 — 系統 Q、anchor 1 slot）: mut 引数の関数を展開せず Def として再帰させる。
callM は Def の region 0 を、引数の mut 位置の region（anchor）で instantiate する -/

/-- `func acc(mut s int, n int) { if n > 0 { s = s + n; acc(mut s, n - 1) } }` -/
def r2Δ : Defs :=
  [ { param := .prod (.ref true 0 .int) .int, ret := .unit
      body := ite (cmp .gt (snd (var 0)) (lit 0))
        (letE (assign (fst (var 0)) (add (deref (fst (var 0))) (snd (var 0))))
          (callM 0 [] (pair (fst (var 1)) (arith .sub (snd (var 1)) (lit 1)))))
        triv } ]

example : checkDefs r2Δ = true := by native_decide

/-- mut ローカルを外側の block（region 1）に置き、さらに深い block（深さ 3）から呼ぶ: anchor = 1 < 呼び手最内 2 -/
def exR2a : Expr :=
  block (block (letE (alloc true (lit 0))
    (letE (block (callM 0 [] (pair (var 0) (lit 4)))) (deref (var 1)))))
example : typecheck r2Δ ∅ [] 0 0 0 [] [] exR2a = some .int := by native_decide
example : (stepN r2Δ 400 (load exR2a) ∅).1 = .ret [] [] (lit 10) := by native_decide

/-- 同じ形を anchor なしの call で書くと拒否（region 0 が呼び手最内 2 に写り、mut の region 1 と一致しない） -/
example : typecheck r2Δ ∅ [] 0 0 0 [] []
    (block (block (letE (alloc true (lit 0))
      (letE (block (call 0 [] (pair (var 0) (lit 4)))) (deref (var 1)))))) = none := by native_decide

/-- 共有 region の mut には書けない（b ≤ anchor）: par の腕は Γ が mutFree なので mut を渡せない形は型が付かない -/
example : typecheck r2Δ ∅ [] 0 0 0 [] []
    (block (letE (alloc true (lit 0)) (par (block (callM 0 [] (pair (var 0) (lit 1)))) (lit 0)))) = none := by
  native_decide


/-! R4a（深い relocate）: callee で作った入れ子の slice（中身も自フレーム）を返し、呼び手で読む。
旧 retOk は中身を呼び手空間に限っていた（浅い relocate では中身がフレームごと消える） -/

/-- 0: `[][]int{{n}}` を作って返す / 1: 0 の結果をそのまま返す（call 結果の転送 — 深く締めた型が一致する） -/
def r4Δ : Defs :=
  [ { param := .int, ret := .slice false 1 (.slice false 1 .int)
      body := append (mkslice false (.slice false 1 .int)) (append (mkslice false .int) (var 0)) }
  , { param := .int, ret := .slice false 1 (.slice false 1 .int)
      body := call 0 [] (add (var 0) (lit 1)) } ]

example : checkDefs r4Δ = true := by native_decide

def exR4a : Expr := block (letE (call 1 [] (lit 6)) (index (index (var 0) (lit 0)) (lit 0)))
example : typecheck r4Δ ∅ [] 0 0 0 [] [] exR4a = some .int := by native_decide
example : (stepN r4Δ 400 (load exR4a) ∅).1 = .ret [] [] (lit 7) := by native_decide

/-- 旧 retOk（中身は呼び手空間）では同じ Def が拒否されていた形: 中身の region を 0 にすると本体の型と合わない -/
example : checkDefs
    [ { param := .int, ret := .slice false 1 (.slice false 0 .int)
        body := append (mkslice false (.slice false 1 .int)) (append (mkslice false .int) (var 0)) } ] = false := by
  native_decide

/-! R4b α（脱出の境界コピー）: 式ブロックの中（region 1）で作った入れ子の slice を、外側のラベル（最内 region 0）へ
jump で持ち出す。巻き戻しで捨てる region 1 のセルは中身ごと region 0 へ写される（relocTo）。
ラベルの型は締めた型（jumpRel = k へ締めてから浅い共変） -/
def exR4b : Expr :=
  block (letE
    (label (.slice false 0 (.slice false 0 .int))
      (block (jump 0 (.slice false 0 (.slice false 0 .int))
        (append (mkslice false (.slice false 1 .int)) (append (mkslice false .int) (lit 7))))))
    (index (index (var 0) (lit 0)) (lit 0)))
example : typecheck [] ∅ [] 0 0 0 [] [] exR4b = some .int := by native_decide
example : (stepN [] 200 (load exR4b) ∅).1 = .ret [] [] (lit 7) := by native_decide

/-- 否定例: mut 参照は写せない（締めは imm だけ）— 深い region の mut セルを外のラベルへ持ち出す jump は拒否 -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (label (.ref true 0 .int) (block (jump 0 (.ref true 0 .int) (alloc true (lit 1)))))) = none := by
  native_decide

/-! R4b-cov（imm セルの深い共変）: 仮引数由来の入れ子の imm コンテナを別の呼び出しへ転送できる。
旧 Ty.sub はセル型を正確一致にしていたので、region 0 の `[][]int` を region d の仮引数へ渡せなかった -/

/-- 0: `count(xs [][]int) int = len(xs)` / 1: `fwd(xs [][]int) int = count(xs)`（転送） -/
def covΔ : Defs :=
  [ { param := .slice false 0 (.slice false 0 .int), ret := .int, body := lenE (var 0) }
  , { param := .slice false 0 (.slice false 0 .int), ret := .int, body := call 0 [] (var 0) } ]

example : checkDefs covΔ = true := by native_decide

/-- 読み出しの注釈（A-2）: opt を要素に持つ imm slice は注釈つきで読む（セル型が要素型の部分型でも、
読んだ値の nil / some の注釈を coerceTo が要素型へ書き換える）。注釈なしは拒否 -/
def exCov : Expr :=
  block (letE (append (mkslice false (.opt .int)) (some (lit 3)))
    (ifnil (index (var 0) (lit 0) (Option.some (.opt .int))) (lit 0) (var 0)))
example : typecheck [] ∅ [] 0 0 0 [] [] exCov = some .int := by native_decide
example : (stepN [] 100 (load exCov) ∅).1 = .ret [] [] (lit 3) := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (letE (append (mkslice false (.opt .int)) (some (lit 3)))
      (ifnil (index (var 0) (lit 0)) (lit 0) (var 0)))) = none := by native_decide

/-! R5（普通の出口の対称化）: 式ブロックの中（region 1）で作った slice を末尾値で外へ返す。出口で写すブロック（blockR）は
region 1 のセルを親の最内 region 0 へ写してから pop する — jump の脱出と同じ境界コピー。注釈なしの block は従来どおり拒否 -/
def exR5 : Expr :=
  block (letE (blockR (.slice false 0 .int) (append (mkslice false .int) (lit 9)))
    (index (var 0) (lit 0)))
example : typecheck [] ∅ [] 0 0 0 [] [] exR5 = some .int := by native_decide
example : (stepN [] 100 (load exR5) ∅).1 = .ret [] [] (lit 9) := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (letE (block (append (mkslice false .int) (lit 9))) (index (var 0) (lit 0)))) = none := by
  native_decide

/-! strlit（string リテラル — region r の imm int セル列）: 機械は region r の先端に mut ヘッダを作り、バイトを append して
freeze する形へ書き換える。型は `slice false r int`（注釈の region — 最内ではない） -/
def exStr : Expr := block (lenE (strlit [97, 98, 99] 0))
example : typecheck [] ∅ [] 0 0 0 [] [] exStr = some .int := by native_decide
example : (stepN [] 100 (load exStr) ∅).1 = .ret [] [] (lit 3) := by native_decide
/-- 共有 region（b = 1）の中では region 0 に作れない（b ≤ r） -/
example : typecheck [] ∅ [] 1 1 2 [] [] (strlit [97] 0) = none := by native_decide

/-- F-6 のリテラル形: 再帰する mut 引数の関数（callM）に文字列リテラルを渡す。
0: `walk(n mut int, w string) = if n > 0 { n -= 1; walk(mut n, "abc") } else { n = len(w) }`。
リテラルが region 0（呼び手空間）なので、callM の imm 引数の条件（anchor 以下）を満たす -/
def strΔ : Defs :=
  [ { param := .prod (.ref true 0 .int) (.slice false 0 .byte), ret := .unit
      body := ite (cmp .gt (deref (fst (var 0))) (lit 0))
        (letE (assign (fst (var 0)) (arith .sub (deref (fst (var 0))) (lit 1)))
          (callM 0 [] (pair (fst (var 1)) (strlit [97, 98, 99] 0))))
        (assign (fst (var 0)) (lenE (snd (var 0)))) } ]
example : checkDefs strΔ = true := by native_decide
def exStrF6 : Expr :=
  block (letE (alloc true (lit 2)) (letE (callM 0 [] (pair (var 0) (strlit [122] 0))) (deref (var 1))))
example : typecheck strΔ ∅ [] 0 0 0 [] [] exStrF6 = some .int := by native_decide
example : (stepN strΔ 400 (load exStrF6) ∅).1 = .ret [] [] (lit 3) := by native_decide
/-- 旧テンプレート（freeze(append 連鎖) — 最内 region の slice）では同じ Def が拒否される（anchor 1 slot） -/
example : checkDefs
    [ { param := .prod (.ref true 0 .int) (.slice false 0 .byte), ret := .unit
        body := ite (cmp .gt (deref (fst (var 0))) (lit 0))
          (letE (assign (fst (var 0)) (arith .sub (deref (fst (var 0))) (lit 1)))
            (callM 0 [] (pair (fst (var 1)) (Expr.freeze (append (mkslice true .int) (lit 97))))))
          (assign (fst (var 0)) (lenE (snd (var 0)))) } ] = false := by native_decide

/-! ## 到達しない項（A5 — error 網羅 analyzer）
error の switch で analyzer が導出集合を覆ったと認めた腕の外の variant は `unreach t` で埋める。
型は注釈どおりに付き、実行で来れば panic（ゼロ除算の ex17 と同じ受け皿）。 -/

/-- 型は付くが実行で panic する（注釈の型 int のまま — 値を作らない） -/
def exUnreach1 : Expr := add (lit 1) (unreach .int)

example : HasType [] ∅ [] 0 0 0 [] [] exUnreach1 .int := HasType.add HasType.lit HasType.unreach
example : typecheck [] ∅ [] 0 0 0 [] [] exUnreach1 = some .int := rfl
example : stepN [] 16 (load exUnreach1) ∅ = (.panic [], ∅) := rfl

/-- 覆っていない variant の腕: `switch inl 7 { case L{x}: x  case R: 到達しない }`（L だけが導出集合 — 腕は正しく L を通る）と、
同じ形で R が来たとき（導出が誤っていた / build が analyzer を走らせない E4-B）の panic -/
def exUnreach2 : Expr := case (inl .bool (lit 7)) (var 0) (unreach .int)
def exUnreach3 : Expr := case (inr .int tt) (var 0) (unreach .int)

example : HasType [] ∅ [] 0 0 0 [] [] exUnreach2 .int :=
  HasType.case (HasType.inl HasType.lit) (HasType.var rfl) HasType.unreach
example : typecheck [] ∅ [] 0 0 0 [] [] exUnreach2 = some .int := rfl
example : stepN [] 16 (load exUnreach2) ∅ = (.ret [] [] (lit 7), ∅) := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] exUnreach3 = some .int := rfl
example : stepN [] 16 (load exUnreach3) ∅ = (.panic [], ∅) := rfl

/-- JSON の往復（境界の語彙） -/
example : exprFromJson 100 (exprToJson exUnreach2) = .ok exUnreach2 := rfl

/-! ## byte の段（段 A — language.md 33 節・formal.md「byte の段」）
byte の値は実行時の `blit n`（0 ≤ n < 256）。ソースの byte は `tobyte`（範囲外は panic）で作り、`toint` で int へ戻す。
byte の比較はコアの cmp（int × int）に `toint` を掛けた形（脱糖器が書く — bool の == を ite 形にしたのと同じ理由で、コアに byte の cmp を足さない）。 -/

/-- `byte(97) >= 48`（比較は toint の上の cmp）→ tt -/
def exByte1 : Expr := cmp .ge (toint (tobyte (lit 97))) (lit 48)

example : typecheck [] ∅ [] 0 0 0 [] [] exByte1 = some .bool := rfl
example : stepN [] 32 (load exByte1) ∅ = (.ret [] [] tt, ∅) := rfl

/-- `int(byte(255))` → 255（境界の値） -/
def exByte2 : Expr := toint (tobyte (lit 255))

example : typecheck [] ∅ [] 0 0 0 [] [] exByte2 = some .int := rfl
example : stepN [] 32 (load exByte2) ∅ = (.ret [] [] (lit 255), ∅) := rfl

/-- `byte(256)` / `byte(-1)`: 型は付くが実行で panic（範囲外 — 27 節の線引き） -/
def exByte3 : Expr := tobyte (lit 256)
def exByte4 : Expr := tobyte (lit (-1))

example : typecheck [] ∅ [] 0 0 0 [] [] exByte3 = some .byte := rfl
example : stepN [] 32 (load exByte3) ∅ = (.panic [], ∅) := rfl
example : stepN [] 32 (load exByte4) ∅ = (.panic [], ∅) := rfl

/-- `[]byte` の要素: mut の列に byte を積んで読み、int へ戻す → 200 -/
def exByte5 : Expr :=
  block (letE (append (mkslice true .byte) (tobyte (lit 200))) (toint (index (var 0) (lit 0))))

example : typecheck [] ∅ [] 0 0 0 [] [] exByte5 = some .int := rfl
example : stepN [] 64 (load exByte5) ∅ = (.ret [] [] (lit 200), ∅) := rfl

/-- 実行時の値の型付け: 範囲内だけ -/
example : HasType [] ∅ [] 0 0 0 [] [] (blit 255) .byte := .blit (by decide) (by decide)
example : ¬ HasType [] ∅ [] 0 0 0 [] [] (blit 256) .byte := by
  intro h; cases h; omega

/-- 否定例: byte の算術は無い（`int(b)` 経由）/ コアの cmp は int × int（byte は toint を掛けて比べる）/
変換は int → byte と byte → int だけ / byte を条件に使えない / blit はソース項でない（検査器は受けない） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (add (tobyte (lit 1)) (lit 1)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (cmp .eq (tobyte (lit 1)) (tobyte (lit 1))) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (tobyte (tobyte (lit 1))) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (toint (lit 1)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (ite (tobyte (lit 1)) (lit 2) (lit 3)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (blit 1) = none := rfl

/-- JSON の往復（境界の語彙 — 型 `{"k":"byte"}`・op `tobyte` / `toint`） -/
example : exprFromJson 100 (exprToJson exByte5) = .ok exByte5 := rfl
example : exprFromJson 100 (exprToJson exByte1) = .ok exByte1 := rfl

/-! ## float の段（language.md 37 節）
float の値は `flit n`（n = IEEE 754 binary64 のビット列）。演算の値は IEEE に委ねる（F64.* は opaque — 型の健全性は値に依らない）。
コアの名前は f64（表層の型名は `float` — 幅は実装の詳細）。 -/

/-- `1.5 * 2.0 < 4.0`（ビット列 0x3FF8… / 0x4000… / 0x4010…） -/
def exF1 : Expr := fcmp .lt (farith .mul (flit 4609434218613702656) (flit 4611686018427387904)) (flit 4616189618054758400)

example : typecheck [] ∅ [] 0 0 0 [] [] exF1 = some .bool := rfl

/-- `int(float(7) / 2.0)` — 変換は明示（int → float → int） -/
def exF2 : Expr := fconv .toInt (farith .div (fconv .ofInt (lit 7)) (flit 4611686018427387904))

example : typecheck [] ∅ [] 0 0 0 [] [] exF2 = some .int := rfl

/-- `-math.Sqrt(2.0)`・ビットの読み替えの往復 -/
def exF3 : Expr := fconv .neg (fconv .sqrt (fconv .fromBits (fconv .bits (flit 4611686018427387904))))

example : typecheck [] ∅ [] 0 0 0 [] [] exF3 = some .f64 := rfl

/-- 値はそのまま返る（リテラルは値） -/
example : stepN [] 4 (load (flit 42)) ∅ = (.ret [] [] (flit 42), ∅) := rfl

/-- 否定例: int と float は交わらない（暗黙の変換なし）/ float の比較の結果は bool / 単項の写しは定義域どおり -/
example : typecheck [] ∅ [] 0 0 0 [] [] (farith .add (flit 0) (lit 1)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (add (flit 0) (lit 1)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (cmp .eq (flit 0) (flit 0)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (fconv .sqrt (lit 4)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (fconv .ofInt (flit 4)) = none := rfl
example : typecheck [] ∅ [] 0 0 0 [] [] (ite (flit 0) (lit 2) (lit 3)) = none := rfl

/-- JSON の往復（型 `{"k":"f64"}`・op fadd… / feq… / fneg…） -/
example : exprFromJson 100 (exprToJson exF1) = .ok exF1 := rfl
example : exprFromJson 100 (exprToJson exF2) = .ok exF2 := rfl
example : exprFromJson 100 (exprToJson exF3) = .ok exF3 := rfl
example : exprFromJson 100 (exprToJson (nil .f64)) = .ok (nil .f64) := rfl


/-! 境界コピー式（M3 — copyTo）: ループの本体を反復ごとの block（region）で包み、外の mut セルへ格納する値だけを
外の region へ写す（「スコープは自分の region を持ち、境界を越える値は境界コピー」— scope-draft 2 節）。
反復で作った slice は反復の region で死に、写した値だけが外の region 0 に積もる -/
def exLoopScope : Expr :=
  block (letE (alloc true (mkslice false .int)) (letE (alloc true (lit 0))
    (letE (whileE (lt (deref (var 0)) (lit 3))
        (block (letE (assign (var 1) (copyTo 0 (.slice false 0 .int) (append (deref (var 1)) (deref (var 0)))))
          (assign (var 1) (add (deref (var 1)) (lit 1))))))
      (lenE (deref (var 2))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exLoopScope = some .int := by native_decide
example : (stepN [] 400 (load exLoopScope) ∅).1 = .ret [] [] (lit 3) := by native_decide
/-- 写さずに格納すると拒否（反復の region の slice を外のセルへ — 宙吊り） -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (letE (alloc true (mkslice false .int))
      (block (assign (var 0) (append (deref (var 0)) (lit 1)))))) = none := by native_decide
/-- 写し先は外の region（k < 深さ）だけ・注釈は k 以下しか指さない -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (copyTo 1 (.slice false 1 .int) (mkslice false .int))) = none := by
  native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (block (block (copyTo 0 (.slice false 1 .int) (mkslice false .int)))) = none := by
  native_decide


/-! mut の宛先構築（M3b — mksliceAt / mkmapAt）: 反復の region（内側の block）から外の mut セルへ新しい mut slice を置く。
mut は relocTo で写せないので、最初から行き先の region（0）に作る。最内に作る mkslice では拒否 -/
def exMutDest : Expr :=
  block (letE (alloc true (mkslice true .int))
    (letE (block (assign (var 0) (append (mksliceAt true .int 0) (lit 4))))
      (lenE (deref (var 1)))))
example : typecheck [] ∅ [] 0 0 0 [] [] exMutDest = some .int := by native_decide
example : (stepN [] 100 (load exMutDest) ∅).1 = .ret [] [] (lit 1) := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (letE (alloc true (mkslice true .int))
      (block (assign (var 0) (append (mkslice true .int) (lit 4)))))) = none := by native_decide
/-- 行き先は今の世界の region だけ（r < d） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (mksliceAt true .int 1)) = none := by native_decide
def exMapDest : Expr :=
  block (letE (alloc true (mkmap true (.prod .int (.opt .int))))
    (letE (block (assign (var 0) (setm (mkmapAt true (.prod .int (.opt .int)) 0) (lit 1) (lit 2))))
      (lenm (deref (var 1)))))
example : typecheck [] ∅ [] 0 0 0 [] [] exMapDest = some .int := by native_decide
example : (stepN [] 100 (load exMapDest) ∅).1 = .ret [] [] (lit 1) := by native_decide

/-! ## 段 6 P1: scope / spawn / join / try（task の木） -/

mutual
/-- 葉への経路の全列挙（例の実行用の公平なスケジューラ — 定理には使わない） -/
def leafPaths : State → List (List Bool)
  | .par _ _ s1 s2 => (leafPaths s1).map (true :: ·) ++ (leafPaths s2).map (false :: ·)
  | .fam _ _ _ m ks => (leafPaths m).map (true :: ·) ++ (kidsPaths ks).map (false :: ·)
  | _ => [[]]
def kidsPaths : Kids → List (List Bool)
  | .nil => []
  | .cons _ _ s r => (leafPaths s).map (true :: ·) ++ (kidsPaths r).map (false :: ·)
end

/-- 歩ける最初の経路で 1 歩（rev = 逆順 — 子を先に走らせるスケジュール） -/
def stepAny (Δ : Defs) (rev : Bool) (s : State) (K : ChanSt) : Option (State × ChanSt) :=
  (if rev then (leafPaths s).reverse else leafPaths s).findSome? (fun π => step Δ π s K)

def runAny (Δ : Defs) (rev : Bool) : Nat → State → ChanSt → State × ChanSt
  | 0, s, K => (s, K)
  | n + 1, s, K => match stepAny Δ rev s K with
    | Option.some (s', K') => runAny Δ rev n s' K'
    | Option.none => (s, K)

/-- P3b-4 1b' の例の書き味: scope の err の型は int・子の結果は組 (t, err?)（error を返さない子は `pair v nil`）・Join はその fst・
Try は (some v / 死の nil) に戻す。根の scope は block の中に置く（scope は共有境界より上 — b < d） -/
def kt (t : Ty) : Ty := .prod t (.opt .int)
def scope (t : Ty) (e : Expr) : Expr := Expr.scope t .int e
def spawn (sc a e : Expr) : Expr := Expr.spawn sc a (pair e (nil .int))
def join (t : Ty) (h : Expr) : Expr := fst (Expr.join (kt t) h)
def tryJ (t : Ty) (h : Expr) : Expr := ifnil (Expr.tryJ (kt t) h) (nil t) (some (fst (var 0)))
/-- scope の値の型（err = int） -/
def sty (t : Ty) : Ty := .union t (.union .unit .int)

/-- `par.Scope((s) => par.Join(par.Spawn(s, () => 40 + 2)))` -/
def exScope1 : Expr := block (scope .int (letE (spawn (var 0) triv (add (lit 40) (lit 2))) (join .int (var 0))))
example : typecheck [] ∅ [] 0 0 0 [] [] exScope1 = some (sty .int) := by native_decide
example : taskDone (runAny [] false 200 (loadT exScope1) ∅).1 = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide
example : taskDone (runAny [] true 200 (loadT exScope1) ∅).1 = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide

/-- 2 人の子（渡す値 1 / 2）の結果を足す。main 先・子先のどちらのスケジュールでも同じ最終状態 -/
def exScope2 : Expr :=
  block (scope .int (letE (spawn (var 0) (lit 1) (add (var 0) (lit 10)))
    (letE (spawn (var 1) (lit 2) (add (var 0) (lit 20))) (add (join .int (var 1)) (join .int (var 0))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exScope2 = some (sty .int) := by native_decide
example : taskDone (runAny [] false 300 (loadT exScope2) ∅).1 = Option.some (inl (.union .unit .int) (lit 33)) := by native_decide
example : (runAny [] false 300 (loadT exScope2) ∅).1 = (runAny [] true 300 (loadT exScope2) ∅).1 := by native_decide

/-- Try は死を吸収しない（C1）: 子の死を nil で見ても、scope の出口は死を値にする（inr — P3a A1 (X)）。
監督の綴り: 本体は Try で完走し、scope の値が inr なら子が死んだ -/
def exTryDead : Expr := block (scope (.opt .int) (letE (spawn (var 0) triv (unreach .int)) (tryJ .int (var 0))))
example : typecheck [] ∅ [] 0 0 0 [] [] exTryDead = some (sty (.opt .int)) := by native_decide
example : taskDone (runAny [] false 300 (loadT exTryDead) ∅).1 = Option.some (inr (.opt .int) (inl .int triv)) := by native_decide
example : taskDone (runAny [] true 300 (loadT exTryDead) ∅).1 = Option.some (inr (.opt .int) (inl .int triv)) := by native_decide

/-- 死んだ子を Join すると親は先へ進まない（Join = この子の死は私の死 — scope の値にはならない） -/
def exJoinDead : Expr := block (scope .int (letE (spawn (var 0) triv (unreach .int)) (join .int (var 0))))
example : (runAny [] true 300 (loadT exJoinDead) ∅).1.mainDead = true := by native_decide

/-- 入れ子: 子が自分の scope で孫を生む（孫の id = [0, 0]） -/
def exNested : Expr := block (scope (sty .int) (join (sty .int) (spawn (var 0) triv (scope .int (join .int (spawn (var 0) triv (lit 7)))))))
example : taskDone (runAny [] false 400 (loadT exNested) ∅).1 = Option.some (inl (.union .unit .int) (inl (.union .unit .int) (lit 7))) := by native_decide

/-- region を持つ結果（P3b-4 — 境界コピー）: 子は自前の region（深さ 1）に "hi" を作って返し、join が scope の region 0 へ写す。
block の中で spawn して handle を外へ出し、親が block の region を閉じてから try しても、写した値は scope の region にある -/
def exStrTask : Expr :=
  block (scope .int (letE (spawn (var 0) triv (strlit [104, 105] 2))
    (letE (block (spawn (var 1) triv (concat (strlit [97] 3) (strlit [98, 99] 3))))
      (add (lenE (join (.slice false 1 .byte) (var 1)))
        (ifnil (tryJ (.slice false 1 .byte) (var 0)) (lit 0) (lenE (var 0)))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exStrTask = some (sty .int) := by native_decide
example : taskDone (runAny [] false 400 (loadT exStrTask) ∅).1 = Option.some (inl (.union .unit .int) (lit 5)) := by native_decide
example : (runAny [] false 400 (loadT exStrTask) ∅).1 = (runAny [] true 400 (loadT exStrTask) ∅).1 := by native_decide

/-! ### P3b-4 1b': error を返す task（子の結果 = pair v err?・未回収の失敗は scope の err へ集約） -/

/-- scope の値の形 -/
def outcome (s : State) : String :=
  match taskDone s with
  | Option.some (inl _ _) => "ok"
  | Option.some (inr _ (inl _ _)) => "died"
  | Option.some (inr _ (inr _ _)) => "failed"
  | _ => if s.mainDead then "dead" else "stuck"

/-- 未回収の失敗は scope の err（inr (inr e)） -/
def exFail1 : Expr := block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (lit 9)))) (lit 0)))
example : typecheck [] ∅ [] 0 0 0 [] [] exFail1 = some (sty .int) := by native_decide
example : taskDone (runAny [] false 300 (loadT exFail1) ∅).1 = Option.some (inr .int (inr .unit (lit 9))) := by native_decide
example : taskDone (runAny [] true 300 (loadT exFail1) ∅).1 = Option.some (inr .int (inr .unit (lit 9))) := by native_decide
/-- Join で回収した失敗は集約しない（本体が err を値として扱った） -/
def exFail2 : Expr :=
  block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (lit 9))))
    (ifnil (snd (Expr.join (kt .int) (var 0))) (lit 0) (var 0))))
example : taskDone (runAny [] false 300 (loadT exFail2) ∅).1 = Option.some (inl (.union .unit .int) (lit 9)) := by native_decide
/-- Try で回収しても集約しない -/
def exFail2t : Expr :=
  block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (lit 9))))
    (ifnil (Expr.tryJ (kt .int) (var 0)) (lit 0) (lit 5))))
example : taskDone (runAny [] true 300 (loadT exFail2t) ∅).1 = Option.some (inl (.union .unit .int) (lit 5)) := by native_decide
/-- 未回収の失敗が 2 つ: 正準順（生んだ順）で最初のものが err（スケジュールに依らない） -/
def exFail3 : Expr :=
  block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (lit 7))))
    (letE (Expr.spawn (var 1) triv (pair (lit 2) (some (lit 8)))) (lit 0))))
example : taskDone (runAny [] false 300 (loadT exFail3) ∅).1 = Option.some (inr .int (inr .unit (lit 7))) := by native_decide
example : (runAny [] false 300 (loadT exFail3) ∅).1 = (runAny [] true 300 (loadT exFail3) ∅).1 := by native_decide
/-- 死と失敗が両方: 死が先 -/
def exFail4 : Expr :=
  block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (lit 7))))
    (letE (Expr.spawn (var 1) triv (unreach (kt .int))) (lit 0))))
example : outcome (runAny [] false 300 (loadT exFail4) ∅).1 = "died" := by native_decide
example : outcome (runAny [] true 300 (loadT exFail4) ∅).1 = "died" := by native_decide
/-- err が region を持つ（string）: 子の region から親の最内へ写って scope の err になる（block の中で長さを読む） -/
def exFailStr : Expr :=
  block (case (Expr.scope .int (.slice false 0 .byte) (letE (Expr.spawn (var 0) triv (pair (lit 1) (some (strlit [101, 102] 2)))) (lit 0)))
    (lit 0) (case (var 0) (lit 1) (lenE (var 0))))
example : typecheck [] ∅ [] 0 0 0 [] [] exFailStr = some .int := by native_decide
example : taskDone (runAny [] false 300 (loadT exFailStr) ∅).1 = Option.some (lit 2) := by native_decide
example : (runAny [] false 300 (loadT exFailStr) ∅).1 = (runAny [] true 300 (loadT exFailStr) ∅).1 := by native_decide
/-- 型の拒否: 子の err の型は scope の err の型と region を除いて一致・根の scope（深さ 0 — 共有境界と同じ）は書けない -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (Expr.scope .int .int (letE (Expr.spawn (var 0) triv (pair (lit 1) (some tt))) (lit 0)))) = none := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (Expr.scope .int .int (lit 0)) = none := by native_decide
example : exprFromJson 100 (exprToJson (Expr.scope .int .int (lit 0))) = .ok (Expr.scope .int .int (lit 0)) := rfl

/-- Def の本体の par（P3a — noNewchan の解禁）: 関数の中で scope を開き、仮引数を子へ渡して +1 を計算させる。
2 本目は子が死ぬ（Try で nil を見ても scope の値は inr）。呼び出しは task の中（loadT）で -/
def parDefΔ : Defs :=
  [{ param := .int, ret := sty .int
     body := scope .int (join .int (spawn (var 0) (var 1) (add (var 0) (lit 1)))) },
   { param := .int, ret := sty (.opt .int)
     body := scope (.opt .int) (letE (spawn (var 0) (var 1) (unreach .int)) (tryJ .int (var 0))) }]
example : checkDefs parDefΔ = true := by native_decide
example : taskDone (runAny parDefΔ false 400 (loadT (block (Expr.call 0 [] (lit 41)))) ∅).1
    = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide
example : taskDone (runAny parDefΔ true 400 (loadT (block (Expr.call 0 [] (lit 41)))) ∅).1
    = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide
example : taskDone (runAny parDefΔ false 400 (loadT (block (Expr.call 1 [] (lit 0)))) ∅).1
    = Option.some (inr (.opt .int) (inl .int triv)) := by native_decide
/-- task の外（旧 load の根）から呼ぶと spawn は定義された panic -/
example : (stepN parDefΔ 400 (load (block (Expr.call 0 [] (lit 41)))) ∅).1.isPanic = true := by native_decide

/-- 受けて nil なら 0（受けの型は `T?` — P3b-4 ③） -/
def recvOr0 (c : Expr) : Expr := ifnil (recv c) (lit 0) (var 0)

/-- Def の本体の newch（P3b-2 — noNewchan の newch の解禁）: 関数の中で scope を開き、子が送り端で仮引数 + 1 を送り、親が受け端で受ける -/
def chDefΔ : Defs :=
  [{ param := .int, ret := sty .int
     body := scope .int (letE (newch 2 1 .int) (letE (spawn (var 1) (pair (fst (var 0)) (var 2))
       (send (fst (var 0)) (add (snd (var 0)) (lit 1))))
       (letE (recvOr0 (snd (var 1))) (letE (join .unit (var 1)) (var 1))))) }]
example : checkDefs chDefΔ = true := by native_decide
example : taskDone (runAny chDefΔ false 600 (loadT (block (Expr.call 0 [] (lit 41)))) ∅).1
    = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide
example : taskDone (runAny chDefΔ true 600 (loadT (block (Expr.call 0 [] (lit 41)))) ∅).1
    = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide

/-- 型の拒否: mut 参照は子へ渡せない・handle は scope から出られない・札は子へ渡せない -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (block (letE (alloc true (lit 1)) (scope .int (join .int (spawn (var 0) (var 1) (deref (var 0))))))) = none := by
  native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (letE (scope (.own .task 0 .int) (spawn (var 0) triv (lit 1))) (lit 0)) = none := by
  native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (join .int (spawn (var 0) (var 0) (lit 1))))) = none := by native_decide

/-! ## 段 6 P1: 端点のチャネル（newch・SPSC・有界・持ち主の札 — 裁定 A） -/

/-- 子が送り端を持って 42 を送り、親が受け端で受ける -/
def exEp1 : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (spawn (var 1) (fst (var 0)) (send (var 0) (lit 42)))
    (letE (recvOr0 (snd (var 1))) (letE (join .unit (var 1)) (var 1))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exEp1 = some (sty .int) := by native_decide
example : taskDone (runAny [] false 300 (loadT exEp1) ∅).1 = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide
example : taskDone (runAny [] true 300 (loadT exEp1) ∅).1 = Option.some (inl (.union .unit .int) (lit 42)) := by native_decide

/-- 容量 1 に 2 つ送る（2 つ目は親の受信まで待つ）— どちらのスケジュールでも同じ最終状態 -/
def exEp2 : Expr :=
  block (scope .int (letE (newch 0 1 .int)
    (letE (spawn (var 1) (fst (var 0)) (letE (send (var 0) (lit 1)) (send (var 1) (lit 2))))
      (letE (recvOr0 (snd (var 1))) (letE (recvOr0 (snd (var 2))) (letE (join .unit (var 2)) (add (var 2) (var 1))))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exEp2 = some (sty .int) := by native_decide
example : taskDone (runAny [] false 400 (loadT exEp2) ∅).1 = Option.some (inl (.union .unit .int) (lit 3)) := by native_decide
example : (runAny [] false 400 (loadT exEp2) ∅).1 = (runAny [] true 400 (loadT exEp2) ∅).1 := by native_decide

/-- 親の別名は失効（裁定 A）: 送り端を子へ渡した後に親が使うと定義された panic（型は受理 — 線形型は入れない） -/
def exEpAlias : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (spawn (var 1) (fst (var 0)) triv)
    (letE (send (fst (var 1)) (lit 1)) (lit 0)))))
example : typecheck [] ∅ [] 0 0 0 [] [] exEpAlias = some (sty .int) := by native_decide
example : (runAny [] false 300 (loadT exEpAlias) ∅).1.mainDead = true := by native_decide
example : (runAny [] true 300 (loadT exEpAlias) ∅).1.mainDead = true := by native_decide
/-- 二度目の引き渡しも失効した別名（giveV が none → spawn が panic） -/
def exEpGive2 : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (spawn (var 1) (fst (var 0)) triv)
    (letE (spawn (var 2) (fst (var 1)) triv) (lit 0)))))
example : (runAny [] false 300 (loadT exEpGive2) ∅).1.mainDead = true := by native_decide

/-- 満杯で待つ: 受け手の居ない容量 1 へ 2 つ送ると 2 つ目で止まる（panic でも完了でもない — Blocked famSnd） -/
def exEpFull : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (send (fst (var 0)) (lit 1)) (letE (send (fst (var 1)) (lit 2)) (lit 0)))))
example : typecheck [] ∅ [] 0 0 0 [] [] exEpFull = some (sty .int) := by native_decide
example : (let r := runAny [] false 300 (loadT exEpFull) ∅
    (stepAny [] false r.1 r.2).isNone && (taskDone r.1).isNone && !r.1.mainDead) = true := by native_decide
/-- 空で待つ: 誰も送らない受け端の受信（Blocked famRcv） -/
def exEpEmpty : Expr := block (scope .int (letE (newch 0 1 .int) (recv (snd (var 0)))))
example : (let r := runAny [] false 300 (loadT exEpEmpty) ∅
    (stepAny [] false r.1 r.2).isNone && (taskDone r.1).isNone && !r.1.mainDead) = true := by native_decide

/-- region を持つペイロード（P3b-4b）: 子が自前の region に作った string を送り、親は受けて自分の最内へ写す（梱包 → 展開） -/
def exStrChan : Expr :=
  block (scope .int (letE (newch 0 1 (.slice false 0 .byte))
    (letE (spawn (var 1) (fst (var 0)) (send (var 0) (strlit [104, 105, 106] 2)))
      (letE (recv (snd (var 1))) (letE (join .unit (var 1)) (ifnil (var 1) (lit 0) (lenE (var 0))))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exStrChan = some (sty .int) := by native_decide
example : taskDone (runAny [] false 400 (loadT exStrChan) ∅).1 = Option.some (inl (.union .unit .int) (lit 3)) := by native_decide
example : (runAny [] false 400 (loadT exStrChan) ∅).1 = (runAny [] true 400 (loadT exStrChan) ∅).1 := by native_decide

/-- 型の拒否: ペイロードは imm（P3b-4b — 旧 P1 は loc-free）・容量 0・家の region はこの世界・端点は chan の中へ入れない -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (letE (newch 0 1 (.slice true 0 .int)) (lit 0)))) = none := by
  native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (letE (newch 0 0 .int) (lit 0)))) = none := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (letE (newch 2 1 .int) (lit 0)))) = none := by native_decide
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (letE (newch 0 1 (.own .tx 0 .int)) (lit 0)))) = none := by
  native_decide
/-- 子の中で親の端点を捕獲する形は書けない（子の本体は閉じている — 文脈は渡す値 1 つ） -/
example : typecheck [] ∅ [] 0 0 0 [] []
    (scope .int (letE (newch 0 1 .int) (letE (spawn (var 1) triv (send (fst (var 1)) (lit 1))) (lit 0)))) = none := by
  native_decide
example : exprFromJson 100 (exprToJson (newch 0 1 .int)) = .ok (newch 0 1 .int) := rfl

/-! ## P3b-4 ③: close（送り端を閉じる — 以後の送りは panic・二度目の close も panic・閉じて空の受けは nil〔何度でも〕） -/

/-- 子が 1 を送って閉じる。親は 2 回受ける（1 回目は some 1・2 回目は nil）→ 1 + 10 -/
def exClose : Expr :=
  block (scope .int (letE (newch 0 1 .int)
    (letE (spawn (var 1) (fst (var 0)) (letE (send (var 0) (lit 1)) (close (var 1))))
      (letE (recvOr0 (snd (var 1))) (letE (ifnil (recv (snd (var 2))) (lit 10) (lit 0))
        (letE (join .unit (var 2)) (add (var 2) (var 1))))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exClose = some (sty .int) := by native_decide
example : taskDone (runAny [] false 400 (loadT exClose) ∅).1 = Option.some (inl (.union .unit .int) (lit 11)) := by native_decide
example : (runAny [] false 400 (loadT exClose) ∅).1 = (runAny [] true 400 (loadT exClose) ∅).1 := by native_decide
/-- 何も送らずに閉じる: 親は待った後 nil を受ける（子が先でも後でも） -/
def exCloseEmpty : Expr :=
  block (scope .int (letE (newch 0 1 .int)
    (letE (spawn (var 1) (fst (var 0)) (close (var 0)))
      (letE (ifnil (recv (snd (var 1))) (lit 7) (var 0)) (letE (join .unit (var 1)) (var 1))))))
example : typecheck [] ∅ [] 0 0 0 [] [] exCloseEmpty = some (sty .int) := by native_decide
example : taskDone (runAny [] false 400 (loadT exCloseEmpty) ∅).1 = Option.some (inl (.union .unit .int) (lit 7)) := by native_decide
example : taskDone (runAny [] true 400 (loadT exCloseEmpty) ∅).1 = Option.some (inl (.union .unit .int) (lit 7)) := by native_decide
/-- 閉じた後の送り・二度目の close は定義された panic -/
def exCloseSend : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (close (fst (var 0))) (letE (send (fst (var 1)) (lit 1)) (lit 0)))))
example : typecheck [] ∅ [] 0 0 0 [] [] exCloseSend = some (sty .int) := by native_decide
example : (runAny [] false 300 (loadT exCloseSend) ∅).1.mainDead = true := by native_decide
def exClose2 : Expr :=
  block (scope .int (letE (newch 0 1 .int) (letE (close (fst (var 0))) (letE (close (fst (var 1))) (lit 0)))))
example : (runAny [] false 300 (loadT exClose2) ∅).1.mainDead = true := by native_decide
/-- 受け端は閉じられない（型の拒否） -/
example : typecheck [] ∅ [] 0 0 0 [] [] (block (scope .int (letE (newch 0 1 .int) (letE (close (snd (var 0))) (lit 0))))) = none := by
  native_decide
example : exprFromJson 100 (exprToJson (close (var 0))) = .ok (close (var 0)) := rfl

/-- 旧 par / 旧 chan は task の中では定義された panic（相談 D — 凍結・task の外〔load〕にだけ残る） -/
example : (runAny [] false 50 (loadT (letE (newchan 0 .int) (lit 0))) ∅).1.mainDead = true := by native_decide
example : (runAny [] false 50 (loadT (letE (par (lit 1) (lit 2)) (lit 0))) ∅).1.mainDead = true := by native_decide
example : (runAny [] false 50 (loadT (scope .int (letE (newchan 0 .int) (lit 0)))) ∅).1.mainDead = true := by native_decide
example : (stepN [] 20 (load (letE (newchan 0 .int) (lit 0))) ∅).1 = .ret [] [] (lit 0) := by native_decide

end FS.Examples
