import FeatherweightSober.Machine
import FeatherweightSober.Substitution

/-!
# 機械状態の型付け（段 3d）

不変条件:
- 深さ d の部品（フレーム、region r の格納値は d = r+1）は
  ストア型の先頭 d region（`Ψ.take d`）だけで型付けする。
  こうすると pop（dropLast）で既存部品の型付けが変化せず、
  strengthening は返る値 1 個（value_strengthen）で済む
- 共有境界 b は世界（1 つの逐次実行）ごとに固定。StackTy の底（nil）は深さ b —
  タスクは親の region の上から始まる。HeapOk の格納値の型付けは
  「immutable セルか、自分の世界のセル（b ≤ r）」にだけ要求する。
  共有 region（r < b）の mut セルはこの世界からは触れない（loc に型が付かない）ので
  型付けを持たなくてよい — spawn 時に落とす（heapOk_spawn）
- 機械状態では書き込み床 f = b（世界の書き込みは region ≥ b でしか起きない）。
  f < b や f > b は式の型付けの内側（par の本体）にだけ現れる
- チャネル環境 Ξ とストア K は全タスクで共有（グローバル）。ChanOk が
  「キューの値は Value かつスナップショット Ψc の世界（f = b = d = rc）で型付く」を運ぶ。
  chanV の型付け（`Ψ.take rc = Ψc`）が送り手と受け手の世界を Ψc で接合する
-/
namespace FS

/-- スタックの型付け。`StackTy Δ Ξ Ψ b S Λ d t tf`: S は深さ d で型 t の値を受け取り（Λ はその穴から見えるラベルの型 —
V4-1 の下準備。fretK の穴と底は []）、
最終的に tf を生む。深さは regionK だけが変える（底が b = この世界の共有境界）。
フレームの式は床 f = b で型付ける -/
inductive StackTy (Δ : Defs) (Ξ : ChanTy) (Ψ : StoreTy) (b : Nat) : Stack → LCtx → Nat → Ty → Ty → Prop where
  | nil {t} : StackTy Δ Ξ Ψ b [] [] b t t
  | letK {S d body t₁ t₂ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [t₁] Λ body t₂ → StackTy Δ Ξ Ψ b S Λ d t₂ tf →
      StackTy Δ Ξ Ψ b (.letK body :: S) Λ d t₁ tf
  | addL {S d c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .int → StackTy Δ Ξ Ψ b S Λ d .int tf →
      StackTy Δ Ξ Ψ b (.addL c :: S) Λ d .int tf
  | addR {S d a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .int → StackTy Δ Ξ Ψ b S Λ d .int tf →
      StackTy Δ Ξ Ψ b (.addR a :: S) Λ d .int tf
  | ltL {S d c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .int → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.ltL c :: S) Λ d .int tf
  | ltR {S d a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .int → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.ltR a :: S) Λ d .int tf
  | arithL {S d op c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .int → StackTy Δ Ξ Ψ b S Λ d .int tf →
      StackTy Δ Ξ Ψ b (.arithL op c :: S) Λ d .int tf
  | arithR {S d op a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .int → StackTy Δ Ξ Ψ b S Λ d .int tf →
      StackTy Δ Ξ Ψ b (.arithR op a :: S) Λ d .int tf
  | cmpL {S d op c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .int → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.cmpL op c :: S) Λ d .int tf
  | cmpR {S d op a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .int → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.cmpR op a :: S) Λ d .int tf
  | iteK {S d t e τ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ t τ → HasType Δ Ξ (Ψ.take d) b b d [] Λ e τ →
      StackTy Δ Ξ Ψ b S Λ d τ tf →
      StackTy Δ Ξ Ψ b (.iteK t e :: S) Λ d .bool tf
  | someK {S d t tf} : StackTy Δ Ξ Ψ b S Λ d (.opt t) tf → StackTy Δ Ξ Ψ b (.someK :: S) Λ d t tf
  | ifnilK {S d n s t τ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ n τ → HasType Δ Ξ (Ψ.take d) b b d [t] Λ s τ →
      StackTy Δ Ξ Ψ b S Λ d τ tf →
      StackTy Δ Ξ Ψ b (.ifnilK n s :: S) Λ d (.opt t) tf
  | inlK {S d r t tf} :
      StackTy Δ Ξ Ψ b S Λ d (.union t r) tf → StackTy Δ Ξ Ψ b (.inlK r :: S) Λ d t tf
  | inrK {S d l t tf} :
      StackTy Δ Ξ Ψ b S Λ d (.union l t) tf → StackTy Δ Ξ Ψ b (.inrK l :: S) Λ d t tf
  | caseK {S d bl br l r τ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [l] Λ bl τ → HasType Δ Ξ (Ψ.take d) b b d [r] Λ br τ →
      StackTy Δ Ξ Ψ b S Λ d τ tf →
      StackTy Δ Ξ Ψ b (.caseK bl br :: S) Λ d (.union l r) tf
  | pairL {S d c l r tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c r → StackTy Δ Ξ Ψ b S Λ d (.prod l r) tf →
      StackTy Δ Ξ Ψ b (.pairL c :: S) Λ d l tf
  | pairR {S d a l r tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a l → StackTy Δ Ξ Ψ b S Λ d (.prod l r) tf →
      StackTy Δ Ξ Ψ b (.pairR a :: S) Λ d r tf
  /-- 型注釈の中身の評価中（V3-5）: 値 ta が戻ると coerceTo で t に緩めて S へ -/
  | annK {S d t ta tf} :
      Ty.sub ta t = true → StackTy Δ Ξ Ψ b S Λ d t tf → StackTy Δ Ξ Ψ b (.annK t :: S) Λ d ta tf
  | fstK {S d l r tf} :
      StackTy Δ Ξ Ψ b S Λ d l tf → StackTy Δ Ξ Ψ b (.fstK :: S) Λ d (.prod l r) tf
  | sndK {S d l r tf} :
      StackTy Δ Ξ Ψ b S Λ d r tf → StackTy Δ Ξ Ψ b (.sndK :: S) Λ d (.prod l r) tf
  | allocK {S d m t tf} :
      t.regionsBelow (d + 1) → b ≤ d → (m = false → t.mutFree) →
      StackTy Δ Ξ Ψ b S Λ (d + 1) (.ref m d t) tf → StackTy Δ Ξ Ψ b (.allocK m :: S) Λ (d + 1) t tf
  | derefK {S d m r t tf} :
      StackTy Δ Ξ Ψ b S Λ d t tf → StackTy Δ Ξ Ψ b (.derefK :: S) Λ d (.ref m r t) tf
  /-- freeze: mut 参照を受け取り immutable 参照を返す。t.mutFree は immutable セルの
  不変条件（immMutFree）をタグ倒しの後も立てるための premise -/
  | freezeK {S d r t tf} :
      t.mutFree → StackTy Δ Ξ Ψ b S Λ d (.ref false r t) tf →
      StackTy Δ Ξ Ψ b (.freezeK :: S) Λ d (.ref true r t) tf
  | assignL {S d e r t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ e t → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.assignL e :: S) Λ d (.ref true r t) tf
  | assignR {S d l r t tf} :
      Value l → HasType Δ Ξ (Ψ.take d) b b d [] Λ l (.ref true r t) → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.assignR l :: S) Λ d t tf
  | whileK {S d c body τ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .bool → HasType Δ Ξ (Ψ.take d) b b d [] Λ body τ →
      StackTy Δ Ξ Ψ b S Λ d .unit tf → StackTy Δ Ξ Ψ b (.whileK c body :: S) Λ d .bool tf
  | whileB {S d c body τ tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .bool → HasType Δ Ξ (Ψ.take d) b b d [] Λ body τ →
      StackTy Δ Ξ Ψ b S Λ d .unit tf → StackTy Δ Ξ Ψ b (.whileB c body :: S) Λ d τ tf
  /-- region 境界。escape 検査済みの型だけが通過できる -/
  | regionK {S d t tf} :
      t.regionsBelow d → StackTy Δ Ξ Ψ b S Λ d t tf → StackTy Δ Ξ Ψ b (.regionK :: S) Λ (d + 1) t tf
  /-- 出口で写すブロックの region（R5）: 穴は本体の型 tB（ブロックの region を指してよい）、下の S は締めた型 t を受ける -/
  | regionKR {S d tB t tf} :
      Ty.jumpRel b (d - 1) tB t = true → t.regionsBelow d → StackTy Δ Ξ Ψ b S Λ d t tf →
      StackTy Δ Ξ Ψ b (.regionKR t :: S) Λ (d + 1) tB tf
  /-- 境界コピー式（M3）: 穴は値の型 tE、下の S は写した型 t（region k 以下）を受ける -/
  | copyK {S d k tE t tf} :
      k < d → Ty.jumpRel b k tE t = true → t.regionsBelow (k + 1) = true → t.chanFree = true → StackTy Δ Ξ Ψ b S Λ d t tf →
      StackTy Δ Ξ Ψ b (.copyK k t :: S) Λ d tE tf
  | sendL {S d e rc t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ e t → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sendL e :: S) Λ d (.chan rc t) tf
  | sendR {S d c rc t tf} :
      Value c → HasType Δ Ξ (Ψ.take d) b b d [] Λ c (.chan rc t) → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sendR c :: S) Λ d t tf
  | recvK {S d rc t tf} :
      StackTy Δ Ξ Ψ b S Λ d t tf → StackTy Δ Ξ Ψ b (.recvK :: S) Λ d (.chan rc t) tf
  /-- call の引数評価（round4: 同世界化）。値（sub で param.shiftR d に収まる ta）が
  戻ると region を push してシフト済み本体を評価し、戻り値 ret.relocR d が S へ来る
  （round5: fretK の relocate が上界を呼び手最内 d に締める） -/
  | callK {S d fn ts dfn ta tf} :
      Δ[fn]? = some dfn → ts.length = dfn.tparams → Ty.tyArgsOk ts = true →
      Ty.sub ta ((dfn.inst ts).param.shiftR d) = true → b ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) ((dfn.inst ts).ret.relocR d) tf →
      StackTy Δ Ξ Ψ b (.callK fn ts :: S) Λ (d + 1) ta tf
  /-- anchor つき呼び出し（R2）の引数評価中: 前提は callM 規則と同じ（anchor は引数の型から読む） -/
  | callMK {S d fn ts dfn ta a tf} :
      Δ[fn]? = some dfn → ts.length = dfn.tparams → Ty.tyArgsOk ts = true →
      Ty.anchorOf (dfn.inst ts).param ta = some a →
      Ty.sub ta ((dfn.inst ts).param.renR a d) = true → b ≤ a → a ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) ((dfn.inst ts).ret.relocA a d) tf →
      StackTy Δ Ξ Ψ b (.callMK fn ts :: S) Λ (d + 1) ta tf
  /-- 関数値呼び出しの関数側評価中（V3-1）: 関数値 fn p r が戻ったら引数 e を評価する。
  前提は callK と同じ形（シグネチャを関数値の型から取る） -/
  | callvL {S d e p r ta tf} :
      HasType Δ Ξ (Ψ.take (d + 1)) b b (d + 1) [] Λ e ta →
      Ty.sub ta (p.shiftR d) = true → b ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) (r.relocR d) tf →
      StackTy Δ Ξ Ψ b (.callvL e :: S) Λ (d + 1) (.fn p r) tf
  /-- 関数値呼び出しの引数評価中: 評価済みの関数値 fv を保持。引数値が戻ると callK へ渡し直す -/
  | callvR {S d fv p r ta tf} :
      Value fv → HasType Δ Ξ (Ψ.take (d + 1)) b b (d + 1) [] Λ fv (.fn p r) →
      Ty.sub ta (p.shiftR d) = true → b ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) (r.relocR d) tf →
      StackTy Δ Ξ Ψ b (.callvR fv :: S) Λ (d + 1) ta tf
  /-- 関数の返り境界（round4）: 深さ d + 2（呼び手 d + 1 + フレーム region d... 実行時は
  最内 = d + 1）で ret.shiftR d の値を受け、relocate（境界コピー）+ region pop で
  呼び手の深さ d + 1 へ返す。t0 は base の戻り値型（retOk が relocate の床）。
  出口は relocR d（round5: relocate 後の最上段は呼び手最内 d に住む。R0: 値ラッパの中も締め、
  フレームが持つ同じ型へ coerceTo で注釈を揃える） -/
  | fretK {S : Stack} {d : Nat} {t0 : Ty} {tf : Ty} :
      Ty.retOk t0 = true → b ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) (Ty.relocR d t0) tf →
      StackTy Δ Ξ Ψ b (.fretK (Ty.relocR d t0) :: S) [] (d + 2) (Ty.shiftR d t0) tf
  /-- anchor つきの関数の返り境界（R2）: fretK の一般化。本体は region 0 を ρ0 へ写した世界
  （renR ρ0 d t0）の値を返し、relocate + pop の後の出口は relocA ρ0 d t0 -/
  | fretKA {S : Stack} {d ρ0 : Nat} {t0 : Ty} {tf : Ty} :
      Ty.retOk t0 = true → b ≤ ρ0 → ρ0 ≤ d →
      StackTy Δ Ξ Ψ b S Λ (d + 1) (Ty.relocA ρ0 d t0) tf →
      StackTy Δ Ξ Ψ b (.fretK (Ty.relocA ρ0 d t0) :: S) [] (d + 2) (Ty.renR ρ0 d t0) tf
  /-- freezeK の slice 版（同じフレームに 2 つ目の型付け — 入ってくる型で判別） -/
  | freezeKs {S d r t tf} :
      t.mutFree → StackTy Δ Ξ Ψ b S Λ d (.slice false r t) tf →
      StackTy Δ Ξ Ψ b (.freezeK :: S) Λ d (.slice true r t) tf
  | idxL {S d ot i m r t' t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ i .int → Ty.readAs m ot t' = some t → StackTy Δ Ξ Ψ b S Λ d t tf →
      StackTy Δ Ξ Ψ b (.idxL ot i :: S) Λ d (.slice m r t') tf
  | idxR {S d ot sv m r t' t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice m r t') → Ty.readAs m ot t' = some t →
      StackTy Δ Ξ Ψ b S Λ d t tf →
      StackTy Δ Ξ Ψ b (.idxR ot sv :: S) Λ d .int tf
  | lenK {S d m r t tf} :
      StackTy Δ Ξ Ψ b S Λ d .int tf → StackTy Δ Ξ Ψ b (.lenK :: S) Λ d (.slice m r t) tf
  | tobyteK {S d tf} :
      StackTy Δ Ξ Ψ b S Λ d .byte tf → StackTy Δ Ξ Ψ b (.tobyteK :: S) Λ d .int tf
  | farithL {S d op c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .f64 → StackTy Δ Ξ Ψ b S Λ d .f64 tf →
      StackTy Δ Ξ Ψ b (.farithL op c :: S) Λ d .f64 tf
  | farithR {S d op a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .f64 → StackTy Δ Ξ Ψ b S Λ d .f64 tf →
      StackTy Δ Ξ Ψ b (.farithR op a :: S) Λ d .f64 tf
  | fcmpL {S d op c tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ c .f64 → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.fcmpL op c :: S) Λ d .f64 tf
  | fcmpR {S d op a tf} :
      Value a → HasType Δ Ξ (Ψ.take d) b b d [] Λ a .f64 → StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.fcmpR op a :: S) Λ d .f64 tf
  | fconvK {S d op tf} :
      StackTy Δ Ξ Ψ b S Λ d op.cod tf → StackTy Δ Ξ Ψ b (.fconvK op :: S) Λ d op.dom tf
  | tointK {S d tf} :
      StackTy Δ Ξ Ψ b S Λ d .int tf → StackTy Δ Ξ Ψ b (.tointK :: S) Λ d .byte tf
  /-- append の継続。結果 region rr は mut なら subject と同じ r（正確）、
  imm なら現在の最内 region d - 1（round4: 書き込み先の固定） -/
  | appL {S d v m r rr t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ v t →
      (m = true → rr = r ∧ b ≤ r) → (m = false → d = rr + 1 ∧ b ≤ rr ∧ t.regionsBelow d) →
      StackTy Δ Ξ Ψ b S Λ d (.slice m rr t) tf →
      StackTy Δ Ξ Ψ b (.appL v :: S) Λ d (.slice m r t) tf
  | appR {S d sv m r rr t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice m r t) →
      (m = true → rr = r ∧ b ≤ r) → (m = false → d = rr + 1 ∧ b ≤ rr ∧ t.regionsBelow d) →
      StackTy Δ Ξ Ψ b S Λ d (.slice m rr t) tf →
      StackTy Δ Ξ Ψ b (.appR sv :: S) Λ d t tf
  | sixL {S d i v r t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ i .int → HasType Δ Ξ (Ψ.take d) b b d [] Λ v t →
      StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sixL i v :: S) Λ d (.slice true r t) tf
  | sixM {S d sv v r t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice true r t) →
      HasType Δ Ξ (Ψ.take d) b b d [] Λ v t → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sixM sv v :: S) Λ d .int tf
  | sixR {S d sv iv r t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice true r t) →
      Value iv → HasType Δ Ξ (Ψ.take d) b b d [] Λ iv .int →
      StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sixR sv iv :: S) Λ d t tf
  | subL {S d sa sb r t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ sa .int → HasType Δ Ξ (Ψ.take d) b b d [] Λ sb .int →
      StackTy Δ Ξ Ψ b S Λ d (.slice false r t) tf →
      StackTy Δ Ξ Ψ b (.subL sa sb :: S) Λ d (.slice false r t) tf
  | subM {S d sv sb r t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice false r t) →
      HasType Δ Ξ (Ψ.take d) b b d [] Λ sb .int →
      StackTy Δ Ξ Ψ b S Λ d (.slice false r t) tf →
      StackTy Δ Ξ Ψ b (.subM sv sb :: S) Λ d .int tf
  | subR {S d sv av r t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice false r t) →
      Value av → HasType Δ Ξ (Ψ.take d) b b d [] Λ av .int →
      StackTy Δ Ξ Ψ b S Λ d (.slice false r t) tf →
      StackTy Δ Ξ Ψ b (.subR sv av :: S) Λ d .int tf
  | eqsL {S d e2 r1 r2 tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ e2 (.slice false r2 .byte) →
      StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.eqsL e2 :: S) Λ d (.slice false r1 .byte) tf
  | eqsR {S d sv r1 r2 tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice false r1 .byte) →
      StackTy Δ Ξ Ψ b S Λ d .bool tf →
      StackTy Δ Ξ Ψ b (.eqsR sv :: S) Λ d (.slice false r2 .byte) tf
  /-- concat の継続（appendI と同じ床: 結果は最内 region d - 1） -/
  | catL {S d e2 r1 r2 rr t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ e2 (.slice false r2 t) →
      d = rr + 1 → b ≤ rr →
      StackTy Δ Ξ Ψ b S Λ d (.slice false rr t) tf →
      StackTy Δ Ξ Ψ b (.catL e2 :: S) Λ d (.slice false r1 t) tf
  | catR {S d sv r1 r2 rr t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.slice false r1 t) →
      d = rr + 1 → b ≤ rr →
      StackTy Δ Ξ Ψ b S Λ d (.slice false rr t) tf →
      StackTy Δ Ξ Ψ b (.catR sv :: S) Λ d (.slice false r2 t) tf
  /-- freezeK の map 版（freezeKs と同型） -/
  | freezeKm {S d r t tf} :
      t.mutFree → StackTy Δ Ξ Ψ b S Λ d (.map false r t) tf →
      StackTy Δ Ξ Ψ b (.freezeK :: S) Λ d (.map true r t) tf
  | gtmL {S d k m r kt kq t' t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ k kq → Ty.sub t' t = true → StackTy Δ Ξ Ψ b S Λ d (.opt t) tf →
      StackTy Δ Ξ Ψ b (.gtmL t k :: S) Λ d (.map m r (.prod kt (.opt t'))) tf
  | gtmR {S d sv m r kt kq t' t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.map m r (.prod kt (.opt t'))) → Ty.sub t' t = true →
      StackTy Δ Ξ Ψ b S Λ d (.opt t) tf →
      StackTy Δ Ξ Ψ b (.gtmR t sv :: S) Λ d kq tf
  | stmL {S d k v r kt t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ k kt → HasType Δ Ξ (Ψ.take d) b b d [] Λ v t →
      StackTy Δ Ξ Ψ b S Λ d (.map true r (.prod kt (.opt t))) tf →
      StackTy Δ Ξ Ψ b (.stmL k v :: S) Λ d (.map true r (.prod kt (.opt t))) tf
  | stmM {S d sv v r kt t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.map true r (.prod kt (.opt t))) →
      HasType Δ Ξ (Ψ.take d) b b d [] Λ v t →
      StackTy Δ Ξ Ψ b S Λ d (.map true r (.prod kt (.opt t))) tf →
      StackTy Δ Ξ Ψ b (.stmM sv v :: S) Λ d kt tf
  | stmR {S d sv kv r kt t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.map true r (.prod kt (.opt t))) →
      Value kv → HasType Δ Ξ (Ψ.take d) b b d [] Λ kv kt →
      StackTy Δ Ξ Ψ b S Λ d (.map true r (.prod kt (.opt t))) tf →
      StackTy Δ Ξ Ψ b (.stmR sv kv :: S) Λ d t tf
  | dlmL {S d k r kt kq t tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ k kq → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.dlmL t k :: S) Λ d (.map true r (.prod kt (.opt t))) tf
  | dlmR {S d sv r kt kq t tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.map true r (.prod kt (.opt t))) →
      StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.dlmR t sv :: S) Λ d kq tf
  | lenmK {S d m r t tf} :
      StackTy Δ Ξ Ψ b S Λ d .int tf → StackTy Δ Ξ Ψ b (.lenmK :: S) Λ d (.map m r t) tf
  /-- keysm の継続（concat と同じ床: 結果は最内 region d - 1） -/
  | keysmK {S d m r rr kt t tf} :
      d = rr + 1 → b ≤ rr → kt.keyOk → kt.regionsBelow d →
      StackTy Δ Ξ Ψ b S Λ d (.slice false rr kt) tf →
      StackTy Δ Ξ Ψ b (.keysmK :: S) Λ d (.map m r (.prod kt (.opt t))) tf
  /-- clone の継続（slice — keysm と同じ床: 結果は最内 region d - 1 の mut） -/
  | cloneKs {S d ot m r rr t' t tf} :
      d = rr + 1 → b ≤ rr → Ty.readAs m ot t' = some t → t.regionsBelow d →
      StackTy Δ Ξ Ψ b S Λ d (.slice true rr t) tf →
      StackTy Δ Ξ Ψ b (.cloneK ot :: S) Λ d (.slice m r t') tf
  /-- clone の継続（map — セル型に対して cloneKs と同型） -/
  | cloneKm {S d ot m r rr c' c tf} :
      d = rr + 1 → b ≤ rr → Ty.readAs m ot c' = some c → c.regionsBelow d →
      StackTy Δ Ξ Ψ b S Λ d (.map true rr c) tf →
      StackTy Δ Ξ Ψ b (.cloneK ot :: S) Λ d (.map m r c') tf
  /-- ラベル（V4）: 穴にはラベルを 1 つ伸ばした Λ を見せる（R4b: ラベルの最内 region d - 1 つき）。
  `t.regionsBelow d` は脱出の境界コピーで写した値を d へ降ろす床（label 規則の写し） -/
  | labelK {S d t tf} :
      t.regionsBelow d → StackTy Δ Ξ Ψ b S Λ d t tf →
      StackTy Δ Ξ Ψ b (.labelK t :: S) ((t, d - 1) :: Λ) d t tf
  /-- jump のペイロード評価中（V4）。下の S が受ける型 t' は任意（jump は戻らない）。
  穴はペイロードの型 tJ（R4b: ラベルより深い region を指してよい — jumpRel） -/
  | jumpK {S d n tL k tJ t' tf} :
      Λ[n]? = some (tL, k) → Ty.jumpRel b k tJ tL = true → StackTy Δ Ξ Ψ b S Λ d t' tf →
      StackTy Δ Ξ Ψ b (.jumpK n :: S) Λ d tJ tf
  /-- scope の本体（段 6 P1）: 穴は本体の型 tB・ラベル環境は空（本体はラベルを越えない）、下の S は `union t unit` を受ける
  （写した値の inl か 死の inr — P3a A1 (X)。写しは regionKR と同形） -/
  | scopeK {S d tB t ε tf} :
      Ty.jumpRel b (d - 1) tB t = true → t.regionsBelow d → ε.mutFree = true → ε.chanFree = true → b < d →
      StackTy Δ Ξ Ψ b S Λ d (.union t (.union .unit (ε.relocR (d - 1)))) tf →
      StackTy Δ Ξ Ψ b (.scopeK t ε :: S) [] (d + 1) tB tf
  /-- spawn の札の評価中: 子の本体 e は子の世界（共有境界 = d・自前の region d・型環境は親のまま。床は親の b — 子を作るとき f_mono で d へ上げる）で型付く -/
  | spawnK {S d a e rs ta t ε ε0 tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ a ta → ta.givable rs = true →
      HasType Δ Ξ (Ψ.take d) b d (d + 1) [ta.rehome d] [] e (.prod t (.opt ε0)) →
      (Ty.prod t (.opt ε0)).mutFree = true → (Ty.prod t (.opt ε0)).chanFree = true → Ty.payOk ε0 ε = true →
      StackTy Δ Ξ Ψ b S Λ d (.own .task rs ((Ty.prod t (.opt ε0)).relocR rs)) tf →
      StackTy Δ Ξ Ψ b (.spawnK a e :: S) Λ d (.own .scope rs ε) tf
  /-- spawn の渡す値の評価中: 札 sv は評価済み。値が戻ると（task の中で）子が生まれる -/
  | spawnA {S d sv e rs ta t ε ε0 tf} :
      Value sv → HasType Δ Ξ (Ψ.take d) b b d [] Λ sv (.own .scope rs ε) → ta.givable rs = true →
      HasType Δ Ξ (Ψ.take d) b d (d + 1) [ta.rehome d] [] e (.prod t (.opt ε0)) →
      (Ty.prod t (.opt ε0)).mutFree = true → (Ty.prod t (.opt ε0)).chanFree = true → Ty.payOk ε0 ε = true →
      StackTy Δ Ξ Ψ b S Λ d (.own .task rs ((Ty.prod t (.opt ε0)).relocR rs)) tf →
      StackTy Δ Ξ Ψ b (.spawnA sv e :: S) Λ d ta tf
  /-- 端点への送信（段 6 P1）: send の端点版の 2 フレーム -/
  | sendLE {S d e r t te tf} :
      HasType Δ Ξ (Ψ.take d) b b d [] Λ e te → Ty.payOk te t = true → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sendL e :: S) Λ d (.own .tx r t) tf
  | sendRE {S d c r t te tf} :
      Value c → HasType Δ Ξ (Ψ.take d) b b d [] Λ c (.own .tx r t) → Ty.payOk te t = true → StackTy Δ Ξ Ψ b S Λ d .unit tf →
      StackTy Δ Ξ Ψ b (.sendR c :: S) Λ d te tf
  /-- 受信: 受けた値は今の最内の region（d - 1）へ写る（P3b-4b） -/
  | recvKE {S d r t tf} :
      t.mutFree = true → t.chanFree = true → StackTy Δ Ξ Ψ b S Λ d (.opt (t.relocR (d - 1))) tf →
      StackTy Δ Ξ Ψ b (.recvK :: S) Λ d (.own .rx r t) tf
  /-- close（P3b-4 ③） -/
  | closeKE {S d r t tf} :
      StackTy Δ Ξ Ψ b S Λ d .unit tf → StackTy Δ Ξ Ψ b (.closeK :: S) Λ d (.own .tx r t) tf
  | joinK {S d rs t tf} :
      StackTy Δ Ξ Ψ b S Λ d t tf → StackTy Δ Ξ Ψ b (.joinK t :: S) Λ d (.own .task rs t) tf
  | tryK {S d rs t tf} :
      StackTy Δ Ξ Ψ b S Λ d (.opt t) tf → StackTy Δ Ξ Ψ b (.tryK t :: S) Λ d (.own .task rs t) tf
  /-- task の底（P3b-4）: 子の自前の region（深さ b — 共有境界の 1 段上）を持ったまま止まる -/
  | taskK {t} : 1 ≤ b → StackTy Δ Ξ Ψ b [.taskK] [] (b + 1) t t

/-- スタックの深さは共有境界より下がらない（底が b）。
alloc / pop が共有 region を触らないことの source -/
theorem StackTy.le_depth {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {b : Nat} {S : Stack} {d : Nat}
    {t tf : Ty} (h : StackTy Δ Ξ Ψ b S Λ d t tf) : b ≤ d := by
  induction h <;> omega

/-- 床 b ≤ d のとき、take b のプレフィクス一致は take d の下でも保たれる
（store_mono のプレフィクス条件を深さ d のフレームへ配るための形） -/
theorem take_pre_take {Ψ Ψ' : StoreTy} {b d : Nat}
    (hpre : Ψ'.take b = Ψ.take b) (hbd : b ≤ d) :
    (Ψ'.take d).take b = (Ψ.take d).take b := by
  rw [List.take_take, Nat.min_eq_left hbd, List.take_take, Nat.min_eq_left hbd]
  exact hpre

/-- ヒープの型付け: 長さ・各 region のストア長が Ψ と一致し、
region r の格納値は「immutable セルか自世界のセル（b ≤ r）」なら値であり
`Ψ.take (r+1)` の深さ r+1・共有境界 b で型が付く。
共有 region の mut セル（r < b、m = true）は型付けを要求しない —
この世界の loc に型が付かないので deref され得ない -/
structure HeapOk (Δ : Defs) (Ξ : ChanTy) (b : Nat) (Ψ : StoreTy) (H : Heap) : Prop where
  len : H.length = Ψ.length
  storeLen : ∀ (r : Nat) (ρ : List (Bool × Expr)) (σ : List (Bool × Ty)),
    H[r]? = some ρ → Ψ[r]? = some σ → ρ.length = σ.length
  /-- 実行時タグと Ψ のタグの一致。assign のタグ検査（機械）と mut/imm の型付け（静的）が
  同じものを見ていることの source -/
  tags : ∀ (r : Nat) (ρ : List (Bool × Expr)) (σ : List (Bool × Ty)) (a : Nat)
      (mv : Bool) (v : Expr) (m : Bool) (t : Ty),
    H[r]? = some ρ → Ψ[r]? = some σ → ρ[a]? = some (mv, v) → σ[a]? = some (m, t) →
    mv = m
  typed : ∀ (r : Nat) (ρ : List (Bool × Expr)) (σ : List (Bool × Ty)) (a : Nat)
      (mv : Bool) (v : Expr) (m : Bool) (t : Ty),
    H[r]? = some ρ → Ψ[r]? = some σ → ρ[a]? = some (mv, v) → σ[a]? = some (m, t) →
    (m = false ∨ b ≤ r) →
    Value v ∧ HasType Δ Ξ (Ψ.take (r + 1)) b b (r + 1) [] [] v t
  /-- スロット型は region ≤ r のみ言及（alloc 規則の制約の不変条件化。代入の preservation の要） -/
  tyBelow : ∀ (r : Nat) (σ : List (Bool × Ty)) (a : Nat) (m : Bool) (t : Ty),
    Ψ[r]? = some σ → σ[a]? = some (m, t) → t.regionsBelow (r + 1)
  /-- immutable セルの型は深く mutFree（alloc 規則の制約の不変条件化。
  spawn での型付けの引き継ぎ（heapOk_spawn）の要） -/
  immMutFree : ∀ (r : Nat) (σ : List (Bool × Ty)) (a : Nat) (t : Ty),
    Ψ[r]? = some σ → σ[a]? = some (false, t) → t.mutFree

/-- 梱包したペイロードの型付け（P3b-4b）: 歩いた型は t で、セル列は 1 region の小さなヒープ（共有境界 0・型環境は空）として型付き、
値はその世界（深さ 1）で t に型付く — どの task の世界へも xfer で写せる -/
def PktOk (Δ : Defs) (t : Ty) (w : Pkt) : Prop :=
  w.ty = t ∧ ∃ σ, HeapOk Δ ∅ 0 [σ] [w.cs] ∧ Value w.v ∧ HasType Δ ∅ [σ] 0 0 1 [] [] w.v t

/-- チャネルストアの型付け: 長さが Ξ と一致し、エントリ (Ψc, t) のペイロード型は
regionsBelow rc（rc = Ψc.length）かつ mutFree、待機中の値はすべて
Value かつスナップショットの世界（`HasType Δ Ξ Ψc rc rc rc [] Λ`）で型が付く。
chanV の `Ψ.take rc = Ψc` がこの世界を送り手・受け手の世界と接合する
（rc = 0・Ψc = [] が段 3c の loc-free チャネル = 世界非依存の特殊形） -/
structure ChanOk (Δ : Defs) (Ξ : ChanTy) (K : ChanSt) : Prop where
  len : K.leg.length = Ξ.ch.length
  wf : ∀ (c : Nat) (Ψc : StoreTy) (t : Ty), Ξ.ch[c]? = some (Ψc, t) →
    t.regionsBelow Ψc.length ∧ t.mutFree
  typed : ∀ (c : Nat) (q : List Expr) (Ψc : StoreTy) (t : Ty),
    K.leg[c]? = some q → Ξ.ch[c]? = some (Ψc, t) →
    ∀ v ∈ q, Value v ∧ HasType Δ Ξ Ψc Ψc.length Ψc.length Ψc.length [] [] v t
  /-- 端点のチャネル（段 6 P1）: 型の表 Ξ.ep と機械の表 K.ep の鍵が一致する -/
  epdom : ∀ (k : EpKey) (t : Ty), Ξ.ep.lookup k = some t → ∃ ent, K.ep k = some ent
  eprev : ∀ (k : EpKey) (ent : EpEnt), K.ep k = some ent → ∃ t, Ξ.ep.lookup k = some t
  /-- ペイロード型は region を全部 0 へ締めた形（relocR 0 で不動）で imm・chan なし・項目の型と一致し、待機中の梱包は型付く
  （P3b-4b — 旧 P1 は loc-free の値を空の世界で） -/
  eptyped : ∀ (k : EpKey) (t : Ty) (ent : EpEnt), Ξ.ep.lookup k = some t → K.ep k = some ent →
    t.relocR 0 = t ∧ t.mutFree = true ∧ t.chanFree = true ∧ ent.ty = t ∧ ∀ w ∈ ent.q, PktOk Δ (.opt t) w

/-- 機械状態の型付け。b は世界の共有境界（メインは 0、タスクは spawn 時の親の深さ）。
焦点は深さ Ψ.length（= 生きている region 数）で全 Ψ を見る。
Ξ は全タスク共有（K の型付け ChanOk は世界の外なので StateTy に含めない —
preservation が別引数で運ぶ） -/
inductive StateTy (Δ : Defs) : ChanTy → Nat → State → Ty → Prop where
  | eval {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H S e t tf} :
      HasType Δ Ξ Ψ b b Ψ.length [] Λ e t → StackTy Δ Ξ Ψ b S Λ Ψ.length t tf → HeapOk Δ Ξ b Ψ H →
      StateTy Δ Ξ b (.eval H S e) tf
  | ret {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H S v t tf} :
      Value v → HasType Δ Ξ Ψ b b Ψ.length [] Λ v t → StackTy Δ Ξ Ψ b S Λ Ψ.length t tf →
      HeapOk Δ Ξ b Ψ H →
      StateTy Δ Ξ b (.ret H S v) tf
  /-- par: 各タスクは共有境界 = 親の現在の深さ（Ψ.length）の well-typed 状態。
  メインは unit を待つ -/
  | par {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H S} {s1 s2 : State} {t1 t2 tf} :
      StateTy Δ Ξ Ψ.length s1 t1 → StateTy Δ Ξ Ψ.length s2 t2 →
      s1.isFam = false → s2.isFam = false →
      StackTy Δ Ξ Ψ b S Λ Ψ.length .unit tf → HeapOk Δ Ξ b Ψ H →
      StateTy Δ Ξ b (.par H S s1 s2) tf
  /-- panic は任意の型で well-typed（progress の四択の 1 つ。これ以上進まない） -/
  | panic {Ξ : ChanTy} {b : Nat} {H : Heap} {tf : Ty} : StateTy Δ Ξ b (.panic H) tf
  /-- task（段 6 P1）: main はこの task の世界 Ξ（tk = 子の (scope の region, 結果型) の表。先頭 o 個は生まれたときに親から引き継いだ分 —
  b より下の region の handle なので型が付かない — で、自分の子 i は tk[o + i]）で型付く葉。
  子 i は自分の世界 Ξs i（共有の部分 ch / ep は親と同じ・tk は子自身の子）と共有境界 bs i で、子の結果型 tcs i（imm・chan なし）で型付き、
  表の型は tc の imm の region を scope の region rs へ締めたもの（relocR rs — P3b-4: join / try が子のヒープから写す） -/
  | fam {Ξ : ChanTy} {b : Nat} {id : List Nat} {o n : Nat} {m : State} {ks : Kids} {tf : Ty}
      (Ξs : Nat → ChanTy) (bs : Nat → Nat) (tcs : Nat → Ty) :
      m.isFam = false → StateTy Δ Ξ b m tf → Ξ.tk.length = o + ks.length →
      (∀ i, (Ξs i).ch = Ξ.ch) → (∀ i, (Ξs i).ep = Ξ.ep) →
      (∀ (i rs : Nat) (t : Ty), Ξ.tk[i]? = some (rs, t) → t.mutFree = true ∧ t.chanFree = true) →
      (∀ i rs kid, ks.get? i = some (rs, kid) → ∃ t, Ξ.tk[o + i]? = some (rs, t)) →
      (∀ i rs kid t, ks.get? i = some (rs, kid) → Ξ.tk[o + i]? = some (rs, t) →
        (tcs i).mutFree = true ∧ (tcs i).chanFree = true ∧ (tcs i).relocR rs = t) →
      (∀ i rs kid, ks.get? i = some (rs, kid) → StateTy Δ (Ξs i) (bs i) kid (tcs i)) →
      -- P3b-4 1b': 子の結果は組 (t, err?)・札の err の型は子の err の型の relocR 0
      (∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = .prod t (.opt ε0) ∧ ε0.relocR 0 = tg.1) →
      StateTy Δ Ξ b (.fam id o n m ks) tf

/-- スタック型付けの transport: 深さ d 以下の take 単位で lookup が保存され、
床 b 以下のプレフィクスが変わらないなら Ψ を替えられる -/
theorem StackTy.mono {Δ : Defs} {Ξ : ChanTy} {Ψ Ψ' : StoreTy} {b : Nat} {S d t tf}
    (h : StackTy Δ Ξ Ψ b S Λ d t tf)
    (hle : ∀ d', d' ≤ d → StoreLE (Ψ.take d') (Ψ'.take d'))
    (hpre : Ψ'.take b = Ψ.take b) : StackTy Δ Ξ Ψ' b S Λ d t tf := by
  induction h with
  | nil => exact .nil
  | taskK h => exact .taskK h
  | letK h1 hS ih =>
    exact .letK (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | addL h1 hS ih =>
    exact .addL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | addR hv h1 hS ih =>
    exact .addR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | ltL h1 hS ih =>
    exact .ltL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | ltR hv h1 hS ih =>
    exact .ltR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | arithL h1 hS ih =>
    exact .arithL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | arithR hv h1 hS ih =>
    exact .arithR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | cmpL h1 hS ih =>
    exact .cmpL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | cmpR hv h1 hS ih =>
    exact .cmpR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | pairL h1 hS ih =>
    exact .pairL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | pairR hv h1 hS ih =>
    exact .pairR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | fstK _ ih => exact .fstK (ih hle)
  | annK hs _ ih => exact .annK hs (ih hle)
  | labelK hb _ ih => exact .labelK hb (ih hle)
  | jumpK hn hr _ ih => exact .jumpK hn hr (ih hle)
  | sndK _ ih => exact .sndK (ih hle)
  | iteK h1 h2 hS ih =>
    exact .iteK (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | someK _ ih => exact .someK (ih hle)
  | ifnilK h1 h2 hS ih =>
    exact .ifnilK (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | inlK _ ih => exact .inlK (ih hle)
  | inrK _ ih => exact .inrK (ih hle)
  | caseK h1 h2 hS ih =>
    exact .caseK (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | allocK hb hbd hmf _ ih => exact .allocK hb hbd hmf (ih hle)
  | derefK _ ih => exact .derefK (ih hle)
  | freezeK hmf _ ih => exact .freezeK hmf (ih hle)
  | assignL h1 hS ih =>
    exact .assignL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | assignR hv h1 hS ih =>
    exact .assignR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | whileK h1 h2 hS ih =>
    exact .whileK (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | whileB h1 h2 hS ih =>
    exact .whileB (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | regionK hb _ ih =>
    exact .regionK hb (ih fun d' hd' => hle d' (Nat.le_succ_of_le hd'))
  | regionKR hr hb _ ih =>
    exact .regionKR hr hb (ih fun d' hd' => hle d' (Nat.le_succ_of_le hd'))
  | copyK hk hr hb hc _ ih => exact .copyK hk hr hb hc (ih hle)
  | sendL h1 hS ih =>
    exact .sendL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | sendR hv h1 hS ih =>
    exact .sendR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | recvK _ ih => exact .recvK (ih hle)
  | callK hfn hlen hargs hsub hbd hS ih => exact .callK hfn hlen hargs hsub hbd (ih hle)
  | callMK hfn hlen hargs hanc hsub hbd had hS ih => exact .callMK hfn hlen hargs hanc hsub hbd had (ih hle)
  | callvL h1 hsub hbd hS ih =>
    exact .callvL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hsub hbd (ih hle)
  | callvR hv h1 hsub hbd hS ih =>
    exact .callvR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hsub hbd (ih hle)
  | fretK hro hbd _ ih =>
    exact .fretK hro hbd (ih fun d' hd' => hle d' (Nat.le_succ_of_le hd'))
  | fretKA hro hbd had _ ih =>
    exact .fretKA hro hbd had (ih fun d' hd' => hle d' (Nat.le_succ_of_le hd'))
  | freezeKs hmf _ ih => exact .freezeKs hmf (ih hle)
  | idxL h1 hrd hS ih =>
    exact .idxL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hrd
      (ih hle)
  | idxR hv h1 hrd hS ih =>
    exact .idxR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hrd
      (ih hle)
  | lenK _ ih => exact .lenK (ih hle)
  | tobyteK _ ih => exact .tobyteK (ih hle)
  | farithL h1 hS ih =>
    exact .farithL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | farithR hv h1 hS ih =>
    exact .farithR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | fcmpL h1 hS ih =>
    exact .fcmpL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | fcmpR hv h1 hS ih =>
    exact .fcmpR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | fconvK _ ih => exact .fconvK (ih hle)
  | tointK _ ih => exact .tointK (ih hle)
  | appL h1 hbm hbi hS ih =>
    exact .appL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hbm hbi (ih hle)
  | appR hv h1 hbm hbi hS ih =>
    exact .appR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hbm hbi (ih hle)
  | sixL h1 h2 hS ih =>
    exact .sixL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | sixM hv h1 h2 hS ih =>
    exact .sixM hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | sixR hv h1 hiv h2 hS ih =>
    exact .sixR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hiv (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | subL h1 h2 hS ih =>
    exact .subL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | subM hv h1 h2 hS ih =>
    exact .subM hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | subR hv h1 hav h2 hS ih =>
    exact .subR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hav (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | eqsL h1 hS ih =>
    exact .eqsL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | eqsR hv h1 hS ih =>
    exact .eqsR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | catL h1 hd hb hS ih =>
    exact .catL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hd hb (ih hle)
  | catR hv h1 hd hb hS ih =>
    exact .catR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hd hb (ih hle)
  | freezeKm hmf _ ih => exact .freezeKm hmf (ih hle)
  | gtmL h1 hsub hS ih =>
    exact .gtmL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hsub
      (ih hle)
  | gtmR hv h1 hsub hS ih =>
    exact .gtmR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hsub
      (ih hle)
  | stmL h1 h2 hS ih =>
    exact .stmL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | stmM hv h1 h2 hS ih =>
    exact .stmM hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | stmR hv h1 hkv h2 hS ih =>
    exact .stmR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hkv (h2.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) (ih hle)
  | dlmL h1 hS ih =>
    exact .dlmL (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | dlmR hv h1 hS ih =>
    exact .dlmR hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      (ih hle)
  | lenmK _ ih => exact .lenmK (ih hle)
  | keysmK hd hb hko hrb _ ih => exact .keysmK hd hb hko hrb (ih hle)
  | cloneKs hd hb hrd hrb _ ih => exact .cloneKs hd hb hrd hrb (ih hle)
  | cloneKm hd hb hrd hrb _ ih => exact .cloneKm hd hb hrd hrb (ih hle)
  | scopeK hr hb hem hec hbd _ ih =>
    exact .scopeK hr hb hem hec hbd (ih fun d' hd' => hle d' (Nat.le_succ_of_le hd'))
  | spawnK ha hm h1 hrb hcf hε hS ih =>
    exact .spawnK (ha.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hm
      (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hrb hcf hε (ih hle)
  | spawnA hv hsv hm h1 hrb hcf hε hS ih =>
    exact .spawnA hv (hsv.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hm
      (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth)))
      hrb hcf hε (ih hle)
  | joinK _ ih => exact .joinK (ih hle)
  | tryK _ ih => exact .tryK (ih hle)
  | sendLE h1 hp hS ih =>
    exact .sendLE (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hp (ih hle)
  | sendRE hv h1 hp hS ih =>
    exact .sendRE hv (h1.store_mono (hle _ (Nat.le_refl _)) (storePre_of_take_eq (take_pre_take hpre hS.le_depth))) hp (ih hle)
  | recvKE hm hc _ ih => exact .recvKE hm hc (ih hle)
  | closeKE _ ih => exact .closeKE (ih hle)

/-- スタック型付けの transport（Ξ 版）: newchan で Ξ が伸びても保たれる -/
theorem StackTy.chan_mono {Δ : Defs} {Ξ Ξ' : ChanTy} {Ψ : StoreTy} {b : Nat} {S d t tf}
    (h : StackTy Δ Ξ Ψ b S Λ d t tf) (hle : ChanLE Ξ Ξ') : StackTy Δ Ξ' Ψ b S Λ d t tf := by
  induction h with
  | nil => exact .nil
  | taskK h => exact .taskK h
  | letK h1 _ ih => exact .letK (h1.chan_mono hle) ih
  | addL h1 _ ih => exact .addL (h1.chan_mono hle) ih
  | addR hv h1 _ ih => exact .addR hv (h1.chan_mono hle) ih
  | ltL h1 _ ih => exact .ltL (h1.chan_mono hle) ih
  | ltR hv h1 _ ih => exact .ltR hv (h1.chan_mono hle) ih
  | arithL h1 _ ih => exact .arithL (h1.chan_mono hle) ih
  | arithR hv h1 _ ih => exact .arithR hv (h1.chan_mono hle) ih
  | cmpL h1 _ ih => exact .cmpL (h1.chan_mono hle) ih
  | cmpR hv h1 _ ih => exact .cmpR hv (h1.chan_mono hle) ih
  | pairL h1 _ ih => exact .pairL (h1.chan_mono hle) ih
  | pairR hv h1 _ ih => exact .pairR hv (h1.chan_mono hle) ih
  | fstK _ ih => exact .fstK ih
  | annK hs _ ih => exact .annK hs ih
  | labelK hb _ ih => exact .labelK hb ih
  | jumpK hn hr _ ih => exact .jumpK hn hr ih
  | sndK _ ih => exact .sndK ih
  | iteK h1 h2 _ ih => exact .iteK (h1.chan_mono hle) (h2.chan_mono hle) ih
  | someK _ ih => exact .someK ih
  | ifnilK h1 h2 _ ih => exact .ifnilK (h1.chan_mono hle) (h2.chan_mono hle) ih
  | inlK _ ih => exact .inlK ih
  | inrK _ ih => exact .inrK ih
  | caseK h1 h2 _ ih => exact .caseK (h1.chan_mono hle) (h2.chan_mono hle) ih
  | allocK hb hbd hmf _ ih => exact .allocK hb hbd hmf ih
  | derefK _ ih => exact .derefK ih
  | freezeK hmf _ ih => exact .freezeK hmf ih
  | assignL h1 _ ih => exact .assignL (h1.chan_mono hle) ih
  | assignR hv h1 _ ih => exact .assignR hv (h1.chan_mono hle) ih
  | whileK h1 h2 _ ih => exact .whileK (h1.chan_mono hle) (h2.chan_mono hle) ih
  | whileB h1 h2 _ ih => exact .whileB (h1.chan_mono hle) (h2.chan_mono hle) ih
  | regionK hb _ ih => exact .regionK hb ih
  | regionKR hr hb _ ih => exact .regionKR hr hb ih
  | copyK hk hr hb hc _ ih => exact .copyK hk hr hb hc ih
  | sendL h1 _ ih => exact .sendL (h1.chan_mono hle) ih
  | sendR hv h1 _ ih => exact .sendR hv (h1.chan_mono hle) ih
  | recvK _ ih => exact .recvK ih
  | callK hfn hlen hargs hsub hbd _ ih => exact .callK hfn hlen hargs hsub hbd ih
  | callMK hfn hlen hargs hanc hsub hbd had _ ih => exact .callMK hfn hlen hargs hanc hsub hbd had ih
  | callvL h1 hsub hbd _ ih => exact .callvL (h1.chan_mono hle) hsub hbd ih
  | callvR hv h1 hsub hbd _ ih => exact .callvR hv (h1.chan_mono hle) hsub hbd ih
  | fretK hro hbd _ ih => exact .fretK hro hbd ih
  | fretKA hro hbd had _ ih => exact .fretKA hro hbd had ih
  | freezeKs hmf _ ih => exact .freezeKs hmf ih
  | idxL h1 hrd _ ih => exact .idxL (h1.chan_mono hle) hrd ih
  | idxR hv h1 hrd _ ih => exact .idxR hv (h1.chan_mono hle) hrd ih
  | lenK _ ih => exact .lenK ih
  | tobyteK _ ih => exact .tobyteK ih
  | farithL h1 _ ih => exact .farithL (h1.chan_mono hle) ih
  | farithR hv h1 _ ih => exact .farithR hv (h1.chan_mono hle) ih
  | fcmpL h1 _ ih => exact .fcmpL (h1.chan_mono hle) ih
  | fcmpR hv h1 _ ih => exact .fcmpR hv (h1.chan_mono hle) ih
  | fconvK _ ih => exact .fconvK ih
  | tointK _ ih => exact .tointK ih
  | appL h1 hbm hbi _ ih => exact .appL (h1.chan_mono hle) hbm hbi ih
  | appR hv h1 hbm hbi _ ih => exact .appR hv (h1.chan_mono hle) hbm hbi ih
  | sixL h1 h2 _ ih => exact .sixL (h1.chan_mono hle) (h2.chan_mono hle) ih
  | sixM hv h1 h2 _ ih => exact .sixM hv (h1.chan_mono hle) (h2.chan_mono hle) ih
  | sixR hv h1 hiv h2 _ ih => exact .sixR hv (h1.chan_mono hle) hiv (h2.chan_mono hle) ih
  | subL h1 h2 _ ih => exact .subL (h1.chan_mono hle) (h2.chan_mono hle) ih
  | subM hv h1 h2 _ ih => exact .subM hv (h1.chan_mono hle) (h2.chan_mono hle) ih
  | subR hv h1 hav h2 _ ih => exact .subR hv (h1.chan_mono hle) hav (h2.chan_mono hle) ih
  | eqsL h1 _ ih => exact .eqsL (h1.chan_mono hle) ih
  | eqsR hv h1 _ ih => exact .eqsR hv (h1.chan_mono hle) ih
  | catL h1 hd hb _ ih => exact .catL (h1.chan_mono hle) hd hb ih
  | catR hv h1 hd hb _ ih => exact .catR hv (h1.chan_mono hle) hd hb ih
  | freezeKm hmf _ ih => exact .freezeKm hmf ih
  | gtmL h1 hsub _ ih => exact .gtmL (h1.chan_mono hle) hsub ih
  | gtmR hv h1 hsub _ ih => exact .gtmR hv (h1.chan_mono hle) hsub ih
  | stmL h1 h2 _ ih => exact .stmL (h1.chan_mono hle) (h2.chan_mono hle) ih
  | stmM hv h1 h2 _ ih => exact .stmM hv (h1.chan_mono hle) (h2.chan_mono hle) ih
  | stmR hv h1 hkv h2 _ ih => exact .stmR hv (h1.chan_mono hle) hkv (h2.chan_mono hle) ih
  | dlmL h1 _ ih => exact .dlmL (h1.chan_mono hle) ih
  | dlmR hv h1 _ ih => exact .dlmR hv (h1.chan_mono hle) ih
  | lenmK _ ih => exact .lenmK ih
  | keysmK hd hb hko hrb _ ih => exact .keysmK hd hb hko hrb ih
  | cloneKs hd hb hrd hrb _ ih => exact .cloneKs hd hb hrd hrb ih
  | cloneKm hd hb hrd hrb _ ih => exact .cloneKm hd hb hrd hrb ih
  | scopeK hr hb hem hec hbd _ ih => exact .scopeK hr hb hem hec hbd ih
  | spawnK ha hm h1 hrb hcf hε _ ih => exact .spawnK (ha.chan_mono hle) hm (h1.chan_mono hle) hrb hcf hε ih
  | spawnA hv hsv hm h1 hrb hcf hε _ ih => exact .spawnA hv (hsv.chan_mono hle) hm (h1.chan_mono hle) hrb hcf hε ih
  | joinK _ ih => exact .joinK ih
  | tryK _ ih => exact .tryK ih
  | sendLE h1 hp _ ih => exact .sendLE (h1.chan_mono hle) hp ih
  | sendRE hv h1 hp _ ih => exact .sendRE hv (h1.chan_mono hle) hp ih
  | recvKE hm hc _ ih => exact .recvKE hm hc ih
  | closeKE _ ih => exact .closeKE ih

/-! ## take / StoreLE の小補題 -/

theorem getElem?_take_some {α} {l : List α} {d r : Nat} {x : α}
    (h : (l.take d)[r]? = some x) : r < d ∧ l[r]? = some x := by
  obtain ⟨hlt, -⟩ := List.getElem?_eq_some_iff.mp h
  have hd : r < d := by
    rw [List.length_take] at hlt
    omega
  refine ⟨hd, ?_⟩
  rwa [List.getElem?_take_of_lt hd] at h

theorem storeLE_take_self (Ψ : StoreTy) (d : Nat) : StoreLE (Ψ.take d) Ψ := by
  intro r a m t ⟨ρ, h1, h2⟩
  exact ⟨ρ, m, (getElem?_take_some h1).2, h2, fun h => h⟩

/-- プレフィクス同士: take m の lookup は take n（m ≤ n）でそのまま立つ
（round4: imm セル値の型付けを浅い take から深い take へ運ぶ） -/
theorem storeLE_take_le (Ψ : StoreTy) {m n : Nat} (hmn : m ≤ n) :
    StoreLE (Ψ.take m) (Ψ.take n) := by
  intro r a mm t ⟨ρ, h1, h2⟩
  obtain ⟨hr, h1'⟩ := getElem?_take_some h1
  exact ⟨ρ, mm, by rw [List.getElem?_take_of_lt (by omega : r < n)]; exact h1', h2, fun h => h⟩

theorem storePre_take_le (Ψ : StoreTy) {m n f : Nat} (hmn : m ≤ n) :
    StorePre f (Ψ.take m) (Ψ.take n) := by
  intro j _ hjlen
  simp only [List.length_take] at hjlen
  rw [List.take_take, List.take_take, Nat.min_eq_left (by omega), Nat.min_eq_left (by omega)]

theorem storeLE_append (Ψ Ξ : StoreTy) : StoreLE Ψ (Ψ ++ Ξ) := by
  intro r a m t ⟨ρ, h1, h2⟩
  have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h1).1
  exact ⟨ρ, m, by rw [List.getElem?_append_left hr]; exact h1, h2, fun h => h⟩

/-- alloc: region k のストア末尾への追加は lookup を保存する -/
theorem storeLE_set_concat {Ψ : StoreTy} {k : Nat} {σ : List (Bool × Ty)}
    (hk : Ψ[k]? = some σ) (x : Bool × Ty) : StoreLE Ψ (Ψ.set k (σ ++ [x])) := by
  intro r a m t ⟨ρ, h1, h2⟩
  by_cases hrk : r = k
  · subst hrk
    have hρσ : ρ = σ := Option.some.inj (h1.symm.trans hk)
    subst hρσ
    have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h1).1
    have ha : a < ρ.length := (List.getElem?_eq_some_iff.mp h2).1
    refine ⟨ρ ++ [x], m, ?_, ?_, fun h => h⟩
    · rw [List.getElem?_set_self hr]
    · rw [List.getElem?_append_left ha]
      exact h2
  · exact ⟨ρ, m, by rw [List.getElem?_set_ne (by omega)]; exact h1, h2, fun h => h⟩

/-- freeze: region k・番地 a のタグを false に倒す。型は保存、タグは一方向（mut → imm）
なので StoreLE（一方向順序）に収まる — StoreLE を等号でなく順序にした理由そのもの -/
theorem storeLE_set_freeze {Ψ : StoreTy} {k a : Nat} {σ : List (Bool × Ty)}
    {m : Bool} {t : Ty} (hk : Ψ[k]? = some σ) (ha : σ[a]? = some (m, t)) :
    StoreLE Ψ (Ψ.set k (σ.set a (false, t))) := by
  intro r a' m₀ t₀ ⟨ρ, h1, h2⟩
  by_cases hrk : r = k
  · subst hrk
    have hρσ : ρ = σ := Option.some.inj (h1.symm.trans hk)
    subst hρσ
    have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h1).1
    by_cases haa : a' = a
    · subst haa
      have hc : (m₀, t₀) = (m, t) := Option.some.inj (h2.symm.trans ha)
      obtain ⟨rfl, rfl⟩ := Prod.mk.injEq .. ▸ hc
      have ha' : a' < ρ.length := (List.getElem?_eq_some_iff.mp h2).1
      refine ⟨ρ.set a' (false, t₀), false, ?_, ?_, fun _ => rfl⟩
      · rw [List.getElem?_set_self hr]
      · rw [List.getElem?_set_self ha']
    · refine ⟨ρ.set a (false, t), m₀, ?_, ?_, fun h => h⟩
      · rw [List.getElem?_set_self hr]
      · rw [List.getElem?_set_ne (by omega)]
        exact h2
  · exact ⟨ρ, m₀, by rw [List.getElem?_set_ne (by omega)]; exact h1, h2, fun h => h⟩

theorem StoreLE.trans {Ψ₁ Ψ₂ Ψ₃ : StoreTy} (h1 : StoreLE Ψ₁ Ψ₂) (h2 : StoreLE Ψ₂ Ψ₃) :
    StoreLE Ψ₁ Ψ₃ := by
  intro r a m t hx
  obtain ⟨ρ', m', hΨ', hρ', hmm⟩ := h1 r a m t hx
  obtain ⟨ρ'', m'', hΨ'', hρ'', hmm'⟩ := h2 r a m' t ⟨ρ', hΨ', hρ'⟩
  exact ⟨ρ'', m'', hΨ'', hρ'', fun h => hmm' (hmm h)⟩

/-- append（slice）: region k のストア末尾への複数セル追加も lookup を保存する -/
theorem storeLE_set_concat_many {Ψ : StoreTy} {k : Nat} {σ : List (Bool × Ty)}
    (hk : Ψ[k]? = some σ) (ext : List (Bool × Ty)) : StoreLE Ψ (Ψ.set k (σ ++ ext)) := by
  intro r a m t ⟨ρ, h1, h2⟩
  by_cases hrk : r = k
  · subst hrk
    have hρσ : ρ = σ := Option.some.inj (h1.symm.trans hk)
    subst hρσ
    have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h1).1
    have ha : a < ρ.length := (List.getElem?_eq_some_iff.mp h2).1
    refine ⟨ρ ++ ext, m, ?_, ?_, fun h => h⟩
    · rw [List.getElem?_set_self hr]
    · rw [List.getElem?_append_left ha]
      exact h2
  · exact ⟨ρ, m, by rw [List.getElem?_set_ne (by omega)]; exact h1, h2, fun h => h⟩

/-- freezeRange（slice の freeze）は StoreLE（単セル freeze の畳み込み） -/
theorem storeLE_freezeRange {Ψ : StoreTy} {k : Nat} {σ : List (Bool × Ty)} (base : Nat) :
    ∀ (len : Nat), Ψ[k]? = some σ →
      StoreLE Ψ (Ψ.set k (freezeRange base len σ)) := by
  intro len
  induction len generalizing Ψ σ with
  | zero =>
    intro hk
    simp only [freezeRange]
    intro r a m t hx
    by_cases hrk : r = k
    · subst hrk
      obtain ⟨ρ, h1, h2⟩ := hx
      have hρσ : ρ = σ := Option.some.inj (h1.symm.trans hk)
      subst hρσ
      have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h1).1
      exact ⟨ρ, m, by rw [List.getElem?_set_self hr], h2, fun h => h⟩
    · obtain ⟨ρ, h1, h2⟩ := hx
      exact ⟨ρ, m, by rw [List.getElem?_set_ne (by omega)]; exact h1, h2, fun h => h⟩
  | succ n ih =>
    intro hk
    simp only [freezeRange]
    match hcell : σ[base + n]? with
    | Option.some (mc, tc) =>
      have hle1 : StoreLE Ψ (Ψ.set k (σ.set (base + n) (false, tc))) :=
        storeLE_set_freeze hk hcell
      have hk' : (Ψ.set k (σ.set (base + n) (false, tc)))[k]? =
          some (σ.set (base + n) (false, tc)) :=
        List.getElem?_set_self (by exact (List.getElem?_eq_some_iff.mp hk).1)
      have hle2 := ih (Ψ := Ψ.set k (σ.set (base + n) (false, tc)))
        (σ := σ.set (base + n) (false, tc)) hk'
      rw [List.set_set] at hle2
      exact hle1.trans hle2
    | Option.none =>
      exact ih hk

/-- freezeRange は範囲外のセルを変えない -/
theorem freezeRange_getElem?_out {α : Type} {σ : List (Bool × α)} {base : Nat} :
    ∀ (len : Nat) (a : Nat), (a < base ∨ base + len ≤ a) →
      (freezeRange base len σ)[a]? = σ[a]? := by
  intro len
  induction len generalizing σ with
  | zero => intro a _; rfl
  | succ n ih =>
    intro a ha
    simp only [freezeRange]
    match hcell : σ[base + n]? with
    | Option.some (mc, w) =>
      rw [ih a (by omega)]
      rw [List.getElem?_set_ne (by omega)]
    | Option.none =>
      exact ih a (by omega)

/-- freezeRange は範囲内のセルのタグを false に倒す（値は保つ） -/
theorem freezeRange_getElem?_in {α : Type} {σ : List (Bool × α)} {base : Nat} :
    ∀ (len : Nat) (j : Nat), j < len → ∀ {m : Bool} {x : α}, σ[base + j]? = some (m, x) →
      (freezeRange base len σ)[base + j]? = some (false, x) := by
  intro len
  induction len generalizing σ with
  | zero => intro j hj; exact absurd hj (Nat.not_lt_zero j)
  | succ n ih =>
    intro j hj m x hx
    simp only [freezeRange]
    by_cases hjn : j = n
    · subst hjn
      simp only [hx]
      rw [freezeRange_getElem?_out j (base + j) (Or.inr (Nat.le_refl _))]
      exact List.getElem?_set_self (List.getElem?_eq_some_iff.mp hx).1
    · match hcell : σ[base + n]? with
      | Option.some (mc, w) =>
        exact ih j (by omega) (by rw [List.getElem?_set_ne (by omega)]; exact hx)
      | Option.none =>
        exact ih j (by omega) hx

/-- StoreLE は同じ深さの take へ持ち上がる（region 番地が変わらないため） -/
theorem StoreLE.take_take {Ψ Ψ' : StoreTy} (h : StoreLE Ψ Ψ') (d : Nat) :
    StoreLE (Ψ.take d) (Ψ'.take d) := by
  intro r a m t ⟨ρ, h1, h2⟩
  obtain ⟨hrd, h1'⟩ := getElem?_take_some h1
  obtain ⟨ρ', m', h1'', h2', hmm⟩ := h r a m t ⟨ρ, h1', h2⟩
  exact ⟨ρ', m', by rw [List.getElem?_take_of_lt hrd]; exact h1'', h2', hmm⟩

/-- pop（dropLast）は深さ d' ≤ |l| - 1 の take を変えない（Ψ と H の両方に使う） -/
theorem take_dropLast_eq {α} (l : List α) {d' : Nat} (h : d' ≤ l.length - 1) :
    l.dropLast.take d' = l.take d' := by
  rw [List.dropLast_eq_take, List.take_take]
  congr 1
  omega

/-- 先頭 b が l に収まるなら append は take b を変えない（block の push） -/
theorem take_append_left_of_le {α} {b : Nat} {l : List α} (h : b ≤ l.length) (l' : List α) :
    (l ++ l').take b = l.take b := by
  apply List.ext_getElem?
  intro n
  by_cases hn : n < b
  · rw [List.getElem?_take_of_lt hn, List.getElem?_take_of_lt hn,
      List.getElem?_append_left (by omega)]
  · rw [List.getElem?_eq_none (by simp [List.length_take]; omega),
      List.getElem?_eq_none (by simp [List.length_take]; omega)]

/-- b ≤ i なら set i は take b を変えない（alloc / assign の書き込み） -/
theorem take_set_of_le {α} {b i : Nat} {l : List α} (h : b ≤ i) (x : α) :
    (l.set i x).take b = l.take b := by
  apply List.ext_getElem?
  intro n
  by_cases hn : n < b
  · rw [List.getElem?_take_of_lt hn, List.getElem?_take_of_lt hn,
      List.getElem?_set_ne (by omega)]
  · rw [List.getElem?_eq_none (by simp [List.length_take]; omega),
      List.getElem?_eq_none (by simp [List.length_take]; omega)]

/-- b ≤ k の set は take b のプレフィクスを（take n の下でも）変えない
（heapOk 系の store_mono へのプレフィクス条件の供給口） -/
theorem take_pre_set {α} {b k : Nat} {l : List α} (n : Nat) (x : α) (hbk : b ≤ k) :
    ((l.set k x).take n).take b = (l.take n).take b := by
  rw [List.take_take, List.take_take]
  exact take_set_of_le (Nat.le_trans (Nat.min_le_left b n) hbk) x

/-- b ≤ l.length なら append は take b のプレフィクスを（take n の下でも）変えない -/
theorem take_pre_append {α} {b : Nat} {l : List α} (n : Nat) (l' : List α)
    (hb : b ≤ l.length) :
    ((l ++ l').take n).take b = (l.take n).take b := by
  rw [List.take_take, List.take_take]
  exact take_append_left_of_le (Nat.le_trans (Nat.min_le_left b n) hb) l'

/-! ## HeapOk の遷移補題 -/

theorem heapOk_empty {Δ : Defs} {Ξ : ChanTy} {b : Nat} : HeapOk Δ Ξ b [] [] := by
  refine ⟨rfl, ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ σ h1 _
    simp at h1
  · intro r ρ σ a mv v m t h1 _ _ _
    simp at h1
  · intro r ρ σ a mv v m t h1 _ _ _ _
    simp at h1
  · intro r σ a m t h1 _
    simp at h1
  · intro r σ a t h1 _
    simp at h1

/-- Ξ の transport: newchan で Ξ が伸びてもヒープの型付けは保たれる -/
theorem heapOk_chan_mono {Δ : Defs} {Ξ Ξ' : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    (hle : ChanLE Ξ Ξ') (hH : HeapOk Δ Ξ b Ψ H) : HeapOk Δ Ξ' b Ψ H := by
  refine ⟨hH.len, hH.storeLen, hH.tags, ?_, hH.tyBelow, hH.immMutFree⟩
  intro r ρ σ a mv v m t h1 h2 h3 h4 hcond
  obtain ⟨hv, ht⟩ := hH.typed r ρ σ a mv v m t h1 h2 h3 h4 hcond
  exact ⟨hv, ht.chan_mono hle⟩

/-- block の push: 空 region を両側に足す -/
theorem heapOk_push {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) :
    HeapOk Δ Ξ b (Ψ ++ [[]]) (H ++ [[]]) := by
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ σ h1 h2
    by_cases hr : r < H.length
    · rw [List.getElem?_append_left hr] at h1
      rw [List.getElem?_append_left (by rw [← hH.len]; exact hr)] at h2
      exact hH.storeLen r ρ σ h1 h2
    · have hr' : H.length ≤ r := Nat.le_of_not_lt hr
      rw [List.getElem?_append_right hr'] at h1
      rw [List.getElem?_append_right (by rw [← hH.len]; exact hr')] at h2
      have hb1 : r - H.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h1).1
        simpa using this
      have hz : r - H.length = 0 := by omega
      rw [hz] at h1
      rw [hH.len] at hz
      rw [hz] at h2
      simp at h1 h2
      subst h1
      subst h2
      rfl
  · intro r ρ σ a mv v m t h1 h2 h3 h4
    by_cases hr : r < H.length
    · rw [List.getElem?_append_left hr] at h1
      rw [List.getElem?_append_left (by rw [← hH.len]; exact hr)] at h2
      exact hH.tags r ρ σ a mv v m t h1 h2 h3 h4
    · have hr' : H.length ≤ r := Nat.le_of_not_lt hr
      rw [List.getElem?_append_right hr'] at h1
      have hb1 : r - H.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h1).1
        simpa using this
      have hz : r - H.length = 0 := by omega
      rw [hz] at h1
      simp at h1
      subst h1
      simp at h3
  · intro r ρ σ a mv v m t h1 h2 h3 h4 hcond
    by_cases hr : r < H.length
    · rw [List.getElem?_append_left hr] at h1
      have hrΨ : r < Ψ.length := by rw [← hH.len]; exact hr
      rw [List.getElem?_append_left hrΨ] at h2
      obtain ⟨hv, ht⟩ := hH.typed r ρ σ a mv v m t h1 h2 h3 h4 hcond
      refine ⟨hv, ?_⟩
      rw [take_append_left_of_le (show r + 1 ≤ Ψ.length by omega) [[]]]
      exact ht
    · have hr' : H.length ≤ r := Nat.le_of_not_lt hr
      rw [List.getElem?_append_right hr'] at h1
      have hb1 : r - H.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h1).1
        simpa using this
      have hz : r - H.length = 0 := by omega
      rw [hz] at h1
      simp at h1
      subst h1
      simp at h3
  · intro r σ a m t h2 h3
    by_cases hr : r < Ψ.length
    · rw [List.getElem?_append_left hr] at h2
      exact hH.tyBelow r σ a m t h2 h3
    · have hr' : Ψ.length ≤ r := Nat.le_of_not_lt hr
      rw [List.getElem?_append_right hr'] at h2
      have hb1 : r - Ψ.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h2).1
        simpa using this
      have hz : r - Ψ.length = 0 := by omega
      rw [hz] at h2
      simp at h2
      subst h2
      simp at h3
  · intro r σ a t h2 h3
    by_cases hr : r < Ψ.length
    · rw [List.getElem?_append_left hr] at h2
      exact hH.immMutFree r σ a t h2 h3
    · have hr' : Ψ.length ≤ r := Nat.le_of_not_lt hr
      rw [List.getElem?_append_right hr'] at h2
      have hb1 : r - Ψ.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h2).1
        simpa using this
      have hz : r - Ψ.length = 0 := by omega
      rw [hz] at h2
      simp at h2
      subst h2
      simp at h3

/-- pop: 最内 region を両側から落とす -/
theorem heapOk_pop {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} (hH : HeapOk Δ Ξ b Ψ H) :
    HeapOk Δ Ξ b Ψ.dropLast H.dropLast := by
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ σ h1 h2
    rw [List.dropLast_eq_take] at h1 h2
    exact hH.storeLen r ρ σ (getElem?_take_some h1).2 (getElem?_take_some h2).2
  · intro r ρ σ a mv v m t h1 h2 h3 h4
    rw [List.dropLast_eq_take] at h1 h2
    exact hH.tags r ρ σ a mv v m t (getElem?_take_some h1).2 (getElem?_take_some h2).2 h3 h4
  · intro r ρ σ a mv v m t h1 h2 h3 h4 hcond
    rw [List.dropLast_eq_take] at h1 h2
    obtain ⟨hr, h1'⟩ := getElem?_take_some h1
    obtain ⟨-, h2'⟩ := getElem?_take_some h2
    obtain ⟨hv, ht⟩ := hH.typed r ρ σ a mv v m t h1' h2' h3 h4 hcond
    refine ⟨hv, ?_⟩
    rwa [take_dropLast_eq Ψ (by have := hH.len; omega)]
  · intro r σ a m t h2 h3
    rw [List.dropLast_eq_take] at h2
    exact hH.tyBelow r σ a m t (getElem?_take_some h2).2 h3
  · intro r σ a t h2 h3
    rw [List.dropLast_eq_take] at h2
    exact hH.immMutFree r σ a t (getElem?_take_some h2).2 h3

/-- alloc: 最内 region（k = |Ψ| - 1）の末尾に v : t を mut フラグ m で積む
（タグは H・Ψ 両方に同じ m を刻む） -/
theorem heapOk_alloc {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {k : Nat}
    {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {v : Expr} {m : Bool} {t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hHk : H[k]? = some ρ) (hΨk : Ψ[k]? = some σ)
    (hk : k + 1 = Ψ.length) (hbk : b ≤ k)
    (hv : Value v) (ht : HasType Δ Ξ Ψ b b Ψ.length [] Λ v t)
    (hbt : t.regionsBelow (k + 1)) (hmf : m = false → t.mutFree) :
    HeapOk Δ Ξ b (Ψ.set k (σ ++ [(m, t)])) (H.set k (ρ ++ [(m, v)])) := by
  replace ht := HasType.value_ctx (Γ' := []) (Λ' := []) hv ht
  have hle : StoreLE Ψ (Ψ.set k (σ ++ [(m, t)])) := storeLE_set_concat hΨk (m, t)
  have hkΨ : k < Ψ.length := by omega
  have hkH : k < H.length := by rw [hH.len]; omega
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ' σ' h1 h2
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      simp [hH.storeLen r ρ σ hHk hΨk]
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.storeLen r ρ' σ' h1 h2
  · intro r ρ' σ' a mw w m' τ h1 h2 h3 h4
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hHk hΨk
      by_cases ha : a < ρ.length
      · rw [List.getElem?_append_left ha] at h3
        rw [List.getElem?_append_left (by omega)] at h4
        exact hH.tags r ρ σ a mw w m' τ hHk hΨk h3 h4
      · have ha1 : a < ρ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = ρ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        rw [hlen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h4
        simp at h3 h4
        obtain ⟨rfl, -⟩ := h3
        obtain ⟨rfl, -⟩ := h4
        rfl
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tags r ρ' σ' a mw w m' τ h1 h2 h3 h4
  · intro r ρ' σ' a mw w m' τ h1 h2 h3 h4 hcond
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hHk hΨk
      by_cases ha : a < ρ.length
      · rw [List.getElem?_append_left ha] at h3
        rw [List.getElem?_append_left (by omega)] at h4
        obtain ⟨hw, htw⟩ := hH.typed r ρ σ a mw w m' τ hHk hΨk h3 h4 hcond
        exact ⟨hw, htw.store_mono (hle.take_take (r + 1)) (storePre_of_take_eq (take_pre_set (r + 1) _ hbk))⟩
      · have ha1 : a < ρ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = ρ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        rw [hlen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h4
        simp at h3 h4
        obtain ⟨-, rfl⟩ := h3
        obtain ⟨rfl, rfl⟩ := h4
        refine ⟨hv, ?_⟩
        have hmono : HasType Δ Ξ (Ψ.set r (σ ++ [(m, t)])) b b Ψ.length [] [] v t :=
          ht.store_mono hle (storePre_of_take_eq (take_set_of_le hbk _))
        rw [← hk] at hmono
        rwa [List.take_of_length_le (by simp only [List.length_set]; omega)]
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      obtain ⟨hw, htw⟩ := hH.typed r ρ' σ' a mw w m' τ h1 h2 h3 h4 hcond
      exact ⟨hw, htw.store_mono (hle.take_take (r + 1)) (storePre_of_take_eq (take_pre_set (r + 1) _ hbk))⟩
  · intro r σ' a m' τ h2 h3
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkΨ] at h2
      cases h2
      by_cases ha : a < σ.length
      · rw [List.getElem?_append_left ha] at h3
        exact hH.tyBelow r σ a m' τ hΨk h3
      · have ha1 : a < σ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = σ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        simp at h3
        obtain ⟨rfl, rfl⟩ := h3
        exact hbt
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tyBelow r σ' a m' τ h2 h3
  · intro r σ' a τ h2 h3
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkΨ] at h2
      cases h2
      by_cases ha : a < σ.length
      · rw [List.getElem?_append_left ha] at h3
        exact hH.immMutFree r σ a τ hΨk h3
      · have ha1 : a < σ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = σ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        simp at h3
        obtain ⟨rfl, rfl⟩ := h3
        exact hmf rfl
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.immMutFree r σ' a τ h2 h3

/-- 代入: region r のアドレス a（mut セル）を v : t で上書きする。Ψ もタグも変わらない -/
theorem heapOk_write {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {r a : Nat}
    {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {v : Expr} {t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hρ : H[r]? = some ρ) (hσ : Ψ[r]? = some σ)
    (hσa : σ[a]? = some (true, t))
    (hv : Value v) (ht : HasType Δ Ξ (Ψ.take (r + 1)) b b (r + 1) [] Λ v t) :
    HeapOk Δ Ξ b Ψ (H.set r (ρ.set a (true, v))) := by
  replace ht := HasType.value_ctx (Γ' := []) (Λ' := []) hv ht
  have hrH : r < H.length := (List.getElem?_eq_some_iff.mp hρ).1
  refine ⟨by simp [hH.len], ?_, ?_, ?_, hH.tyBelow, hH.immMutFree⟩
  · intro r' ρ' σ' h1 h2
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      cases h1
      have hρσ : σ' = σ := Option.some.inj (h2.symm.trans hσ)
      subst hρσ
      simpa using hH.storeLen r' ρ σ' hρ h2
    · rw [List.getElem?_set_ne (by omega)] at h1
      exact hH.storeLen r' ρ' σ' h1 h2
  · intro r' ρ' σ' a' mw w m' τ h1 h2 h3 h4
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      cases h1
      have hρσ : σ' = σ := Option.some.inj (h2.symm.trans hσ)
      subst hρσ
      by_cases haa : a' = a
      · subst haa
        have haρ : a' < ρ.length := by
          rw [hH.storeLen r' ρ σ' hρ h2]
          exact (List.getElem?_eq_some_iff.mp hσa).1
        rw [List.getElem?_set_self haρ] at h3
        cases h3
        have hτ : (m', τ) = (true, t) := Option.some.inj (h4.symm.trans hσa)
        cases hτ
        rfl
      · rw [List.getElem?_set_ne (by omega)] at h3
        exact hH.tags r' ρ σ' a' mw w m' τ hρ h2 h3 h4
    · rw [List.getElem?_set_ne (by omega)] at h1
      exact hH.tags r' ρ' σ' a' mw w m' τ h1 h2 h3 h4
  · intro r' ρ' σ' a' mw w m' τ h1 h2 h3 h4 hcond
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      cases h1
      have hρσ : σ' = σ := Option.some.inj (h2.symm.trans hσ)
      subst hρσ
      by_cases haa : a' = a
      · subst haa
        have haρ : a' < ρ.length := by
          rw [hH.storeLen r' ρ σ' hρ h2]
          exact (List.getElem?_eq_some_iff.mp hσa).1
        rw [List.getElem?_set_self haρ] at h3
        cases h3
        have hτ : (m', τ) = (true, t) := Option.some.inj (h4.symm.trans hσa)
        cases hτ
        exact ⟨hv, ht⟩
      · rw [List.getElem?_set_ne (by omega)] at h3
        exact hH.typed r' ρ σ' a' mw w m' τ hρ h2 h3 h4 hcond
    · rw [List.getElem?_set_ne (by omega)] at h1
      exact hH.typed r' ρ' σ' a' mw w m' τ h1 h2 h3 h4 hcond

/-- freeze: region r のアドレス a のタグを H・Ψ 両方で false に倒す（型と値は不変）。
b ≤ r は mut loc の型付けから来る — 共有 region のセルを freeze で書き替える経路は無い。
t.mutFree は freeze 規則の premise（immMutFree を立てる） -/
theorem heapOk_freeze {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {r a : Nat}
    {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {mw : Bool} {w : Expr}
    {m : Bool} {t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hρ : H[r]? = some ρ) (hσ : Ψ[r]? = some σ)
    (hρa : ρ[a]? = some (mw, w)) (hσa : σ[a]? = some (m, t))
    (hbr : b ≤ r) (hmf : t.mutFree) :
    HeapOk Δ Ξ b (Ψ.set r (σ.set a (false, t))) (H.set r (ρ.set a (false, w))) := by
  have hle : StoreLE Ψ (Ψ.set r (σ.set a (false, t))) := storeLE_set_freeze hσ hσa
  have hrH : r < H.length := (List.getElem?_eq_some_iff.mp hρ).1
  have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
  have haρ : a < ρ.length := (List.getElem?_eq_some_iff.mp hρa).1
  have haσ : a < σ.length := (List.getElem?_eq_some_iff.mp hσa).1
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r' ρ' σ' h1 h2
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      rw [List.getElem?_set_self hrΨ] at h2
      cases h1
      cases h2
      simpa using hH.storeLen r' ρ σ hρ hσ
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.storeLen r' ρ' σ' h1 h2
  · intro r' ρ' σ' a' mw' w' m' τ h1 h2 h3 h4
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      rw [List.getElem?_set_self hrΨ] at h2
      cases h1
      cases h2
      by_cases haa : a' = a
      · subst haa
        rw [List.getElem?_set_self haρ] at h3
        rw [List.getElem?_set_self haσ] at h4
        cases h3
        cases h4
        rfl
      · rw [List.getElem?_set_ne (by omega)] at h3
        rw [List.getElem?_set_ne (by omega)] at h4
        exact hH.tags r' ρ σ a' mw' w' m' τ hρ hσ h3 h4
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tags r' ρ' σ' a' mw' w' m' τ h1 h2 h3 h4
  · intro r' ρ' σ' a' mw' w' m' τ h1 h2 h3 h4 hcond
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrH] at h1
      rw [List.getElem?_set_self hrΨ] at h2
      cases h1
      cases h2
      by_cases haa : a' = a
      · subst haa
        rw [List.getElem?_set_self haρ] at h3
        rw [List.getElem?_set_self haσ] at h4
        cases h3
        cases h4
        -- 対象セルの値: freeze 前は mut セル（b ≤ r）として型付けされていた
        obtain ⟨hw, ht⟩ := hH.typed r' ρ σ a' mw w m t hρ hσ hρa hσa (.inr hbr)
        exact ⟨hw, ht.store_mono (hle.take_take (r' + 1)) (storePre_of_take_eq (take_pre_set (r' + 1) _ hbr))⟩
      · rw [List.getElem?_set_ne (by omega)] at h3
        rw [List.getElem?_set_ne (by omega)] at h4
        obtain ⟨hw, ht⟩ := hH.typed r' ρ σ a' mw' w' m' τ hρ hσ h3 h4 hcond
        exact ⟨hw, ht.store_mono (hle.take_take (r' + 1)) (storePre_of_take_eq (take_pre_set (r' + 1) _ hbr))⟩
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      obtain ⟨hw, ht⟩ := hH.typed r' ρ' σ' a' mw' w' m' τ h1 h2 h3 h4 hcond
      exact ⟨hw, ht.store_mono (hle.take_take (r' + 1)) (storePre_of_take_eq (take_pre_set (r' + 1) _ hbr))⟩
  · intro r' σ' a' m' τ h2 h3
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrΨ] at h2
      cases h2
      by_cases haa : a' = a
      · subst haa
        rw [List.getElem?_set_self haσ] at h3
        cases h3
        exact hH.tyBelow r' σ a' m t hσ hσa
      · rw [List.getElem?_set_ne (by omega)] at h3
        exact hH.tyBelow r' σ a' m' τ hσ h3
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tyBelow r' σ' a' m' τ h2 h3
  · intro r' σ' a' τ h2 h3
    by_cases hrr : r' = r
    · subst hrr
      rw [List.getElem?_set_self hrΨ] at h2
      cases h2
      by_cases haa : a' = a
      · subst haa
        rw [List.getElem?_set_self haσ] at h3
        cases h3
        exact hmf
      · rw [List.getElem?_set_ne (by omega)] at h3
        exact hH.immMutFree r' σ a' τ hσ h3
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.immMutFree r' σ' a' τ h2 h3

/-- append（slice）の 1 セル版: region k の末尾に (m, v) を足す。
heapOk_alloc の一般化 — k は最内でなくてよい（値の型付けは take (k+1) で受ける） -/
theorem heapOk_append1 {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {k : Nat}
    {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {v : Expr} {m : Bool} {t : Ty}
    (hH : HeapOk Δ Ξ b Ψ H) (hHk : H[k]? = some ρ) (hΨk : Ψ[k]? = some σ)
    (hbk : b ≤ k)
    (hv : Value v) (ht : HasType Δ Ξ (Ψ.take (k + 1)) b b (k + 1) [] Λ v t)
    (hbt : t.regionsBelow (k + 1)) (hmf : m = false → t.mutFree) :
    HeapOk Δ Ξ b (Ψ.set k (σ ++ [(m, t)])) (H.set k (ρ ++ [(m, v)])) := by
  replace ht := HasType.value_ctx (Γ' := []) (Λ' := []) hv ht
  have hle : StoreLE Ψ (Ψ.set k (σ ++ [(m, t)])) := storeLE_set_concat hΨk (m, t)
  have hkΨ : k < Ψ.length := (List.getElem?_eq_some_iff.mp hΨk).1
  have hkH : k < H.length := by rw [hH.len]; omega
  refine ⟨by simp [hH.len], ?_, ?_, ?_, ?_, ?_⟩
  · intro r ρ' σ' h1 h2
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      simp [hH.storeLen r ρ σ hHk hΨk]
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.storeLen r ρ' σ' h1 h2
  · intro r ρ' σ' a mw w m' τ h1 h2 h3 h4
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hHk hΨk
      by_cases ha : a < ρ.length
      · rw [List.getElem?_append_left ha] at h3
        rw [List.getElem?_append_left (by omega)] at h4
        exact hH.tags r ρ σ a mw w m' τ hHk hΨk h3 h4
      · have ha1 : a < ρ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = ρ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        rw [hlen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h4
        simp at h3 h4
        obtain ⟨rfl, -⟩ := h3
        obtain ⟨rfl, -⟩ := h4
        rfl
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tags r ρ' σ' a mw w m' τ h1 h2 h3 h4
  · intro r ρ' σ' a mw w m' τ h1 h2 h3 h4 hcond
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkH] at h1
      rw [List.getElem?_set_self hkΨ] at h2
      cases h1
      cases h2
      have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hHk hΨk
      by_cases ha : a < ρ.length
      · rw [List.getElem?_append_left ha] at h3
        rw [List.getElem?_append_left (by omega)] at h4
        obtain ⟨hw, htw⟩ := hH.typed r ρ σ a mw w m' τ hHk hΨk h3 h4 hcond
        exact ⟨hw, htw.store_mono (hle.take_take (r + 1)) (storePre_of_take_eq (take_pre_set (r + 1) _ hbk))⟩
      · have ha1 : a < ρ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = ρ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        rw [hlen, List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h4
        simp at h3 h4
        obtain ⟨-, rfl⟩ := h3
        obtain ⟨rfl, rfl⟩ := h4
        exact ⟨hv, ht.store_mono (hle.take_take (r + 1))
          (storePre_of_take_eq (take_pre_set (r + 1) _ hbk))⟩
    · rw [List.getElem?_set_ne (by omega)] at h1
      rw [List.getElem?_set_ne (by omega)] at h2
      obtain ⟨hw, htw⟩ := hH.typed r ρ' σ' a mw w m' τ h1 h2 h3 h4 hcond
      exact ⟨hw, htw.store_mono (hle.take_take (r + 1)) (storePre_of_take_eq (take_pre_set (r + 1) _ hbk))⟩
  · intro r σ' a m' τ h2 h3
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkΨ] at h2
      cases h2
      by_cases ha : a < σ.length
      · rw [List.getElem?_append_left ha] at h3
        exact hH.tyBelow r σ a m' τ hΨk h3
      · have ha1 : a < σ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = σ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        simp at h3
        obtain ⟨rfl, rfl⟩ := h3
        exact hbt
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.tyBelow r σ' a m' τ h2 h3
  · intro r σ' a τ h2 h3
    by_cases hrk : r = k
    · subst hrk
      rw [List.getElem?_set_self hkΨ] at h2
      cases h2
      by_cases ha : a < σ.length
      · rw [List.getElem?_append_left ha] at h3
        exact hH.immMutFree r σ a τ hΨk h3
      · have ha1 : a < σ.length + 1 := by
          have := (List.getElem?_eq_some_iff.mp h3).1
          simpa using this
        have haz : a = σ.length := by omega
        subst haz
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self] at h3
        simp at h3
        obtain ⟨rfl, rfl⟩ := h3
        exact hmf rfl
    · rw [List.getElem?_set_ne (by omega)] at h2
      exact hH.immMutFree r σ' a τ h2 h3

/-- append（slice）のコピー用プレフィクス: region k の末尾に自分の [base, base+len) の
セル列を写す（1 セル版の畳み込み。新セルの追加は呼び手が heapOk_append1 で行う） -/
theorem heapOk_append_copy {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap} {k base : Nat}
    {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)}
    (hbk : b ≤ k) :
    ∀ (len : Nat), HeapOk Δ Ξ b Ψ H → H[k]? = some ρ → Ψ[k]? = some σ →
      (∀ j, j < len → ∃ mj tj, σ[base + j]? = some (mj, tj)) →
      HeapOk Δ Ξ b (Ψ.set k (σ ++ (σ.drop base).take len))
                   (H.set k (ρ ++ (ρ.drop base).take len)) := by
  intro len
  induction len with
  | zero =>
    intro hH hρ hσ _
    simp only [List.take_zero, List.append_nil]
    have hΨ : Ψ.set k σ = Ψ := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hσ).1]
        exact hσ.symm
      · rw [List.getElem?_set_ne (by omega)]
    have hHe : H.set k ρ = H := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hρ).1]
        exact hρ.symm
      · rw [List.getElem?_set_ne (by omega)]
    rw [hΨ, hHe]
    exact hH
  | succ n ih =>
    intro hH hρ hσ hcells
    -- まず n 個写し、次に σ[base+n] を 1 セル足す
    have hn := ih hH hρ hσ (fun j hj => hcells j (by omega))
    obtain ⟨mn, t, hσn⟩ := hcells n (by omega)
    have hσlen : base + n < σ.length := (List.getElem?_eq_some_iff.mp hσn).1
    have hlen : ρ.length = σ.length := hH.storeLen k ρ σ hρ hσ
    have hρlen : base + n < ρ.length := by omega
    obtain ⟨⟨mw, w⟩, hρn⟩ : ∃ c, ρ[base + n]? = some c := ⟨_, List.getElem?_eq_getElem hρlen⟩
    have htag : mw = mn := hH.tags k ρ σ (base + n) mw w mn t hρ hσ hρn hσn
    subst htag
    -- 元セルの値の型付けと不変条件
    obtain ⟨hwv, hwt⟩ := hH.typed k ρ σ (base + n) mw w mw t hρ hσ hρn hσn (.inr hbk)
    have hbt : t.regionsBelow (k + 1) := hH.tyBelow k σ (base + n) mw t hσ hσn
    have hmf : mw = false → t.mutFree := fun hz => hH.immMutFree k σ (base + n) t hσ (hz ▸ hσn)
    -- n 個写した後の lookup
    have hkΨ : k < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
    have hkH : k < H.length := (List.getElem?_eq_some_iff.mp hρ).1
    have hσ' : (Ψ.set k (σ ++ (σ.drop base).take n))[k]? = some (σ ++ (σ.drop base).take n) :=
      List.getElem?_set_self hkΨ
    have hρ' : (H.set k (ρ ++ (ρ.drop base).take n))[k]? = some (ρ ++ (ρ.drop base).take n) :=
      List.getElem?_set_self hkH
    have hle : StoreLE Ψ (Ψ.set k (σ ++ (σ.drop base).take n)) :=
      storeLE_set_concat_many hσ _
    have h1 := heapOk_append1 hn hρ' hσ' hbk hwv
      (hwt.store_mono (hle.take_take (k + 1)) (storePre_of_take_eq (take_pre_set (k + 1) _ hbk)))
      hbt hmf
    rw [List.set_set, List.set_set] at h1
    -- take (n+1) = take n ++ [l[base+n]]
    have hσtake : (σ.drop base).take (n + 1) = (σ.drop base).take n ++ [(mw, t)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hσn]
    have hρtake : (ρ.drop base).take (n + 1) = (ρ.drop base).take n ++ [(mw, w)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hρn]
    rw [hσtake, hρtake, ← List.append_assoc, ← List.append_assoc]
    exact h1

/-- append_copy の跨 region 版（round4 の imm append 用）: source region rs（rs < k、
set の影響を受けない）の [base, base+len) の imm セル列を region k の末尾に写す。
セルは全て imm（タグ false）で、値の型付けは take (rs+1) → take (k+1) のプレフィクス
包含（storeLE_take_le）で運ぶ -/
theorem heapOk_append_copy_cross {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {rs k base : Nat} {ρs ρ : List (Bool × Expr)} {σs σ : List (Bool × Ty)}
    (hbk : b ≤ k) (hrsk : rs < k) :
    ∀ (len : Nat), HeapOk Δ Ξ b Ψ H →
      H[rs]? = some ρs → Ψ[rs]? = some σs → H[k]? = some ρ → Ψ[k]? = some σ →
      (∀ j, j < len → ∃ mj tj, σs[base + j]? = some (mj, tj) ∧ mj = false) →
      HeapOk Δ Ξ b (Ψ.set k (σ ++ (σs.drop base).take len))
                   (H.set k (ρ ++ (ρs.drop base).take len)) := by
  intro len
  induction len with
  | zero =>
    intro hH hρs hσs hρ hσ _
    simp only [List.take_zero, List.append_nil]
    have hΨ : Ψ.set k σ = Ψ := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hσ).1]
        exact hσ.symm
      · rw [List.getElem?_set_ne (by omega)]
    have hHe : H.set k ρ = H := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hρ).1]
        exact hρ.symm
      · rw [List.getElem?_set_ne (by omega)]
    rw [hΨ, hHe]
    exact hH
  | succ n ih =>
    intro hH hρs hσs hρ hσ hcells
    have hn := ih hH hρs hσs hρ hσ (fun j hj => hcells j (by omega))
    obtain ⟨mn, t, hσn, hmn⟩ := hcells n (by omega)
    subst hmn
    have hσslen : base + n < σs.length := (List.getElem?_eq_some_iff.mp hσn).1
    have hlens : ρs.length = σs.length := hH.storeLen rs ρs σs hρs hσs
    have hρslen : base + n < ρs.length := by omega
    obtain ⟨⟨mw, w⟩, hρn⟩ : ∃ c, ρs[base + n]? = some c := ⟨_, List.getElem?_eq_getElem hρslen⟩
    have htag : mw = false := hH.tags rs ρs σs (base + n) mw w false t hρs hσs hρn hσn
    subst htag
    -- 元セル（imm）の値の型付けと不変条件。型付けは take (rs+1) → take (k+1) へ運ぶ
    obtain ⟨hwv, hwt⟩ := hH.typed rs ρs σs (base + n) false w false t hρs hσs hρn hσn (.inl rfl)
    have hbts : t.regionsBelow (rs + 1) := hH.tyBelow rs σs (base + n) false t hσs hσn
    have hbt : t.regionsBelow (k + 1) := Ty.regionsBelow_mono (by omega) hbts
    have hmf : (false : Bool) = false → t.mutFree :=
      fun _ => hH.immMutFree rs σs (base + n) t hσs hσn
    have hwt2 : HasType Δ Ξ (Ψ.take (k + 1)) b b (k + 1) [] [] w t :=
      HasType.value_depth_weaken hwv
        (hwt.store_mono (storeLE_take_le Ψ (by omega)) (storePre_take_le Ψ (by omega)))
        (by omega)
    -- n 個写した後の lookup（source は rs ≠ k なので不変）
    have hkΨ : k < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
    have hkH : k < H.length := (List.getElem?_eq_some_iff.mp hρ).1
    have hσ' : (Ψ.set k (σ ++ (σs.drop base).take n))[k]? =
        some (σ ++ (σs.drop base).take n) := List.getElem?_set_self hkΨ
    have hρ' : (H.set k (ρ ++ (ρs.drop base).take n))[k]? =
        some (ρ ++ (ρs.drop base).take n) := List.getElem?_set_self hkH
    have hle : StoreLE Ψ (Ψ.set k (σ ++ (σs.drop base).take n)) :=
      storeLE_set_concat_many hσ _
    have h1 := heapOk_append1 hn hρ' hσ' hbk hwv
      (hwt2.store_mono (hle.take_take (k + 1)) (storePre_of_take_eq (take_pre_set (k + 1) _ hbk)))
      hbt hmf
    rw [List.set_set, List.set_set] at h1
    have hσtake : (σs.drop base).take (n + 1) = (σs.drop base).take n ++ [(false, t)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hσn]
    have hρtake : (ρs.drop base).take (n + 1) = (ρs.drop base).take n ++ [(false, w)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hρn]
    rw [hσtake, hρtake, ← List.append_assoc, ← List.append_assoc]
    exact h1

/-- relocate 用の跨 region コピー（round4 の境界コピー）: source region rs（rs ≠ k）の
[base, base+len) の imm セル列を region k の末尾に写す。append_copy_cross と違い
source が target より上（フレーム → 呼び手）でもよく、内容型の床 t.regionsBelow (k+1)
を明示の premise で受ける（retOk の床が type-level で供給する） -/
theorem heapOk_reloc_copy {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {rs k base : Nat} {ρs ρ : List (Bool × Expr)} {σs σ : List (Bool × Ty)} {t : Ty}
    (hbk : b ≤ k) (hne : rs ≠ k) (hrb : t.regionsBelow (k + 1) = true) :
    ∀ (len : Nat), HeapOk Δ Ξ b Ψ H →
      H[rs]? = some ρs → Ψ[rs]? = some σs → H[k]? = some ρ → Ψ[k]? = some σ →
      (∀ j, j < len → ∃ mj, σs[base + j]? = some (mj, t) ∧ mj = false) →
      HeapOk Δ Ξ b (Ψ.set k (σ ++ (σs.drop base).take len))
                   (H.set k (ρ ++ (ρs.drop base).take len)) := by
  intro len
  induction len with
  | zero =>
    intro hH hρs hσs hρ hσ _
    simp only [List.take_zero, List.append_nil]
    have hΨ : Ψ.set k σ = Ψ := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hσ).1]
        exact hσ.symm
      · rw [List.getElem?_set_ne (by omega)]
    have hHe : H.set k ρ = H := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = k
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hρ).1]
        exact hρ.symm
      · rw [List.getElem?_set_ne (by omega)]
    rw [hΨ, hHe]
    exact hH
  | succ n ih =>
    intro hH hρs hσs hρ hσ hcells
    have hn := ih hH hρs hσs hρ hσ (fun j hj => hcells j (by omega))
    obtain ⟨mn, hσn, hmn⟩ := hcells n (by omega)
    subst hmn
    have hσslen : base + n < σs.length := (List.getElem?_eq_some_iff.mp hσn).1
    have hlens : ρs.length = σs.length := hH.storeLen rs ρs σs hρs hσs
    have hρslen : base + n < ρs.length := by omega
    obtain ⟨⟨mw, w⟩, hρn⟩ : ∃ c, ρs[base + n]? = some c := ⟨_, List.getElem?_eq_getElem hρslen⟩
    have htag : mw = false := hH.tags rs ρs σs (base + n) mw w false t hρs hσs hρn hσn
    subst htag
    obtain ⟨hwv, hwt⟩ := hH.typed rs ρs σs (base + n) false w false t hρs hσs hρn hσn (.inl rfl)
    have hmf : (false : Bool) = false → t.mutFree :=
      fun _ => hH.immMutFree rs σs (base + n) t hσs hσn
    -- 値の型付けを全体 → take (k+1) / 深さ k+1 へ（上下どちら向きでも strengthen で通る）
    have hwt1 : HasType Δ Ξ Ψ b b (rs + 1) [] [] w t :=
      hwt.store_mono (storeLE_take_self Ψ (rs + 1)) (storePre_take_self Ψ (rs + 1) b)
    have hwt2 : HasType Δ Ξ (Ψ.take (k + 1)) b b (k + 1) [] [] w t :=
      HasType.value_strengthen hwv hwt1 hrb
    -- n 個写した後の lookup（source は rs ≠ k なので不変）
    have hkΨ : k < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
    have hkH : k < H.length := (List.getElem?_eq_some_iff.mp hρ).1
    have hσ' : (Ψ.set k (σ ++ (σs.drop base).take n))[k]? =
        some (σ ++ (σs.drop base).take n) := List.getElem?_set_self hkΨ
    have hρ' : (H.set k (ρ ++ (ρs.drop base).take n))[k]? =
        some (ρ ++ (ρs.drop base).take n) := List.getElem?_set_self hkH
    have hle : StoreLE Ψ (Ψ.set k (σ ++ (σs.drop base).take n)) :=
      storeLE_set_concat_many hσ _
    have h1 := heapOk_append1 hn hρ' hσ' hbk hwv
      (hwt2.store_mono (hle.take_take (k + 1)) (storePre_of_take_eq (take_pre_set (k + 1) _ hbk)))
      hrb hmf
    rw [List.set_set, List.set_set] at h1
    have hσtake : (σs.drop base).take (n + 1) = (σs.drop base).take n ++ [(false, t)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hσn]
    have hρtake : (ρs.drop base).take (n + 1) = (ρs.drop base).take n ++ [(false, w)] := by
      rw [List.take_add_one]
      congr 1
      rw [List.getElem?_drop]
      simp [hρn]
    rw [hσtake, hρtake, ← List.append_assoc, ← List.append_assoc]
    exact h1

/-- freezeRange: region r の [base, base+len) のタグを H・Ψ 両方で false に倒す
（単セル freeze の畳み込み）。覆うセルは全て型 t（slicev の premise）、t は深く mutFree -/
theorem heapOk_freezeRange {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    {r base : Nat} {ρ : List (Bool × Expr)} {σ : List (Bool × Ty)} {t : Ty}
    (hbr : b ≤ r) (hmf : t.mutFree) :
    ∀ (len : Nat), HeapOk Δ Ξ b Ψ H → H[r]? = some ρ → Ψ[r]? = some σ →
      (∀ j, j < len → ∃ mj, σ[base + j]? = some (mj, t)) →
      HeapOk Δ Ξ b (Ψ.set r (freezeRange base len σ)) (H.set r (freezeRange base len ρ)) := by
  intro len
  induction len generalizing Ψ H ρ σ with
  | zero =>
    intro hH hρ hσ _
    simp only [freezeRange]
    have hΨ : Ψ.set r σ = Ψ := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = r
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hσ).1]
        exact hσ.symm
      · rw [List.getElem?_set_ne (by omega)]
    have hHe : H.set r ρ = H := by
      apply List.ext_getElem?
      intro n
      by_cases hn : n = r
      · subst hn
        rw [List.getElem?_set_self (List.getElem?_eq_some_iff.mp hρ).1]
        exact hρ.symm
      · rw [List.getElem?_set_ne (by omega)]
    rw [hΨ, hHe]
    exact hH
  | succ n ih =>
    intro hH hρ hσ hcells
    obtain ⟨mn, hσn⟩ := hcells n (by omega)
    have hlen : ρ.length = σ.length := hH.storeLen r ρ σ hρ hσ
    have han : base + n < ρ.length := by
      rw [hlen]
      exact (List.getElem?_eq_some_iff.mp hσn).1
    obtain ⟨⟨mw, w⟩, hρn⟩ : ∃ c, ρ[base + n]? = some c := ⟨_, List.getElem?_eq_getElem han⟩
    have h1 : HeapOk Δ Ξ b (Ψ.set r (σ.set (base + n) (false, t)))
        (H.set r (ρ.set (base + n) (false, w))) :=
      heapOk_freeze hH hρ hσ hρn hσn hbr hmf
    have hrΨ : r < Ψ.length := (List.getElem?_eq_some_iff.mp hσ).1
    have hrH : r < H.length := (List.getElem?_eq_some_iff.mp hρ).1
    have hσ' : (Ψ.set r (σ.set (base + n) (false, t)))[r]? = some (σ.set (base + n) (false, t)) :=
      List.getElem?_set_self hrΨ
    have hρ' : (H.set r (ρ.set (base + n) (false, w)))[r]? = some (ρ.set (base + n) (false, w)) :=
      List.getElem?_set_self hrH
    have hrest := ih h1 hρ' hσ' (fun j hj => by
      obtain ⟨mj, hσj⟩ := hcells j (by omega)
      by_cases hjn : j = n
      · subst hjn
        exact ⟨false, by rw [List.getElem?_set_self (by rw [← hlen]; omega)]⟩
      · exact ⟨mj, by rw [List.getElem?_set_ne (by omega)]; exact hσj⟩)
    rw [List.set_set, List.set_set] at hrest
    simpa only [freezeRange, hσn, hρn] using hrest

/-- spawn: 共有境界（と床）を親の深さ（= Ψ.length）へ引き上げる。
immutable セルの格納値は mutFree（immMutFree 不変条件）なので f_mono + value_sb で
型付けを引き継ぎ、mut セルの型付けは落とす（r < Ψ.length = 新しい b なので要求されない） -/
theorem heapOk_spawn {Δ : Defs} {Ξ : ChanTy} {b : Nat} {Ψ : StoreTy} {H : Heap}
    (hbl : b ≤ Ψ.length) (hH : HeapOk Δ Ξ b Ψ H) :
    HeapOk Δ Ξ Ψ.length Ψ H := by
  refine ⟨hH.len, hH.storeLen, hH.tags, ?_, hH.tyBelow, hH.immMutFree⟩
  intro r ρ σ a mv v m t h1 h2 h3 h4 hcond
  have hr : r < Ψ.length := (List.getElem?_eq_some_iff.mp h2).1
  have hm : m = false := by
    rcases hcond with h | h
    · exact h
    · omega
  subst hm
  obtain ⟨hv, ht⟩ := hH.typed r ρ σ a mv v false t h1 h2 h3 h4 (.inl rfl)
  exact ⟨hv, HasType.value_sb hv (hH.immMutFree r σ a t h2 h4) (ht.f_mono hbl)⟩

/-! ## ChanOk の遷移補題 -/

theorem chanOk_empty {Δ : Defs} : ChanOk Δ ∅ ∅ := by
  refine ⟨rfl, ?_, ?_, ?_, ?_, ?_⟩
  · intro c Ψc t h
    simp at h
  · intro c q Ψc t h _
    simp [EmptyCollection.emptyCollection] at h
  · intro k t h; simp at h
  · intro k ent h; simp [EmptyCollection.emptyCollection] at h
  · intro k t ent h; simp at h

/-- newchan / parch: エントリ (Ψc, t) を両側の末尾に足す（Ψc = 生成時の共有プレフィクス）。
既存キューの値の型付けは chan_mono で引き継ぐ -/
theorem chanOk_new {Δ : Defs} {Ξ : ChanTy} {K : ChanSt} {Ψc : StoreTy} {t : Ty} (hC : ChanOk Δ Ξ K)
    (hrb : t.regionsBelow Ψc.length) (hmf : t.mutFree) :
    ChanOk Δ (Ξ.addCh (Ψc, t)) K.addLeg := by
  refine ⟨by simp [hC.len, ChanTy.addCh, ChanSt.addLeg], ?_, ?_, hC.epdom, hC.eprev, hC.eptyped⟩
  · intro c Ψ' τ h
    by_cases hc : c < Ξ.ch.length
    · simp only [ChanTy.addCh] at h; rw [List.getElem?_append_left hc] at h
      exact hC.wf c Ψ' τ h
    · have hc' : Ξ.ch.length ≤ c := Nat.le_of_not_lt hc
      simp only [ChanTy.addCh] at h; rw [List.getElem?_append_right hc'] at h
      have hb1 : c - Ξ.ch.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h).1
        simpa using this
      have hz : c - Ξ.ch.length = 0 := by omega
      rw [hz] at h
      simp at h
      obtain ⟨rfl, rfl⟩ := h
      exact ⟨hrb, hmf⟩
  · intro c q Ψ' τ h1 h2 v hv
    simp only [ChanSt.addLeg] at h1
    by_cases hc : c < K.leg.length
    · rw [List.getElem?_append_left hc] at h1
      simp only [ChanTy.addCh] at h2; rw [List.getElem?_append_left (by rw [← hC.len]; exact hc)] at h2
      obtain ⟨hvv, ht⟩ := hC.typed c q Ψ' τ h1 h2 v hv
      exact ⟨hvv, ht.chan_mono (chanLE_addCh Ξ (Ψc, t))⟩
    · have hc' : K.leg.length ≤ c := Nat.le_of_not_lt hc
      rw [List.getElem?_append_right hc'] at h1
      have hb1 : c - K.leg.length < 1 := by
        have := (List.getElem?_eq_some_iff.mp h1).1
        simpa using this
      have hz : c - K.leg.length = 0 := by omega
      rw [hz] at h1
      simp at h1
      subst h1
      simp at hv

/-- send: チャネル c のキュー末尾に値 v : t（スナップショット世界の型付け）を積む -/
theorem chanOk_send {Δ : Defs} {Ξ : ChanTy} {K : ChanSt} {c : Nat} {q : List Expr} {v : Expr}
    {Ψc : StoreTy} {t : Ty}
    (hC : ChanOk Δ Ξ K) (hKc : K.leg[c]? = some q) (hΞc : Ξ.ch[c]? = some (Ψc, t))
    (hv : Value v) (ht : HasType Δ Ξ Ψc Ψc.length Ψc.length Ψc.length [] Λ v t) :
    ChanOk Δ Ξ (K.setLeg c (q ++ [v])) := by
  replace ht := HasType.value_ctx (Γ' := []) (Λ' := []) hv ht
  have hcK : c < K.leg.length := (List.getElem?_eq_some_iff.mp hKc).1
  refine ⟨by simp [hC.len, ChanSt.setLeg], hC.wf, ?_, hC.epdom, hC.eprev, hC.eptyped⟩
  intro c' q' Ψ' τ h1 h2 w hw
  simp only [ChanSt.setLeg] at h1
  by_cases hcc : c' = c
  · subst hcc
    rw [List.getElem?_set_self hcK] at h1
    cases h1
    have hτ : (Ψ', τ) = (Ψc, t) := Option.some.inj (h2.symm.trans hΞc)
    obtain ⟨rfl, rfl⟩ := Prod.mk.injEq .. ▸ hτ
    rcases List.mem_append.mp hw with h | h
    · exact hC.typed c' q Ψ' τ hKc h2 w h
    · rw [List.mem_singleton] at h
      subst h
      exact ⟨hv, ht⟩
  · rw [List.getElem?_set_ne (by omega)] at h1
    exact hC.typed c' q' Ψ' τ h1 h2 w hw

/-- recv: チャネル c のキュー先頭を取り出す -/
theorem chanOk_recv {Δ : Defs} {Ξ : ChanTy} {K : ChanSt} {c : Nat} {v : Expr} {q : List Expr}
    (hC : ChanOk Δ Ξ K) (hKc : K.leg[c]? = some (v :: q)) :
    ChanOk Δ Ξ (K.setLeg c q) := by
  have hcK : c < K.leg.length := (List.getElem?_eq_some_iff.mp hKc).1
  refine ⟨by simp [hC.len, ChanSt.setLeg], hC.wf, ?_, hC.epdom, hC.eprev, hC.eptyped⟩
  intro c' q' Ψ' τ h1 h2 w hw
  simp only [ChanSt.setLeg] at h1
  by_cases hcc : c' = c
  · subst hcc
    rw [List.getElem?_set_self hcK] at h1
    cases h1
    exact hC.typed c' (v :: q) Ψ' τ hKc h2 w (List.mem_cons_of_mem v hw)
  · rw [List.getElem?_set_ne (by omega)] at h1
    exact hC.typed c' q' Ψ' τ h1 h2 w hw

theorem lookup_cons_ne {k k' : EpKey} {t : Ty} {l : List (EpKey × Ty)} (h : k' ≠ k) :
    ((k, t) :: l).lookup k' = l.lookup k' := by
  simp only [List.lookup]
  split
  · rename_i heq; exact absurd (beq_iff_eq.mp heq) h
  · rfl

theorem lookup_cons_self {k : EpKey} {t : Ty} {l : List (EpKey × Ty)} : ((k, t) :: l).lookup k = some t := by
  have h : (k == k) = true := beq_iff_eq.mpr rfl
  simp only [List.lookup, h]

/-- 端点のチャネルの生成（段 6 P1）: 新しい鍵（機械の表に無い — 型の表にも無い）にペイロード型 t の空の項目を足す -/
theorem chanOk_epNew {Δ : Defs} {Ξ : ChanTy} {K : ChanSt} {k : EpKey} {t : Ty} (ent : EpEnt)
    (hC : ChanOk Δ Ξ K) (hk : K.ep k = none) (hcan : t.relocR 0 = t) (hmf : t.mutFree = true) (hcf : t.chanFree = true)
    (hty : ent.ty = t) (hq : ent.q = []) :
    ChanOk Δ { Ξ with ep := (k, t) :: Ξ.ep } (K.setEp k ent) := by
  have hfresh : Ξ.ep.lookup k = none := by
    cases h : Ξ.ep.lookup k with
    | none => rfl
    | some t' => obtain ⟨e, he⟩ := hC.epdom k t' h; rw [hk] at he; cases he
  have hle : ChanLE Ξ { Ξ with ep := (k, t) :: Ξ.ep } := by
    refine ⟨fun _ _ h => h, ?_, fun _ _ h => h⟩
    intro k' t' h
    by_cases hkk : k' = k
    · subst hkk; rw [hfresh] at h; cases h
    · show ((k, t) :: Ξ.ep).lookup k' = some t'
      rw [lookup_cons_ne hkk]; exact h
  refine ⟨hC.len, hC.wf, fun c q Ψc t' h1 h2 v hv => ?_, ?_, ?_, ?_⟩
  · obtain ⟨hvv, ht⟩ := hC.typed c q Ψc t' h1 h2 v hv
    exact ⟨hvv, ht.chan_mono hle⟩
  · intro k' t' h
    by_cases hkk : k' = k
    · subst hkk; exact ⟨ent, by simp [ChanSt.setEp]⟩
    · simp only [] at h; rw [lookup_cons_ne hkk] at h
      obtain ⟨e', he'⟩ := hC.epdom k' t' h
      exact ⟨e', by simp [ChanSt.setEp, hkk, he']⟩
  · intro k' e' h
    by_cases hkk : k' = k
    · subst hkk; exact ⟨t, lookup_cons_self⟩
    · simp [ChanSt.setEp, hkk] at h
      obtain ⟨t', ht'⟩ := hC.eprev k' e' h
      exact ⟨t', by show ((k, t) :: Ξ.ep).lookup k' = some t'; rw [lookup_cons_ne hkk]; exact ht'⟩
  · intro k' t' e' h1 h2
    by_cases hkk : k' = k
    · subst hkk
      have h1' : ((k', t) :: Ξ.ep).lookup k' = some t' := h1
      rw [lookup_cons_self] at h1'; cases h1'
      simp [ChanSt.setEp] at h2
      subst h2
      exact ⟨hcan, hmf, hcf, hty, by simp [hq]⟩
    · have h1' : ((k, t) :: Ξ.ep).lookup k' = some t' := h1
      rw [lookup_cons_ne hkk] at h1'
      replace h1 := h1'
      simp [ChanSt.setEp, hkk] at h2
      exact hC.eptyped k' t' e' h1 h2

/-- 端点のチャネルの項目の書き換え（送信・受信・持ち主の書き換え）: 待機中の値が型付いたままなら保たれる -/
theorem chanOk_epSet {Δ : Defs} {Ξ : ChanTy} {K : ChanSt} {k : EpKey} {ent ent' : EpEnt}
    (hC : ChanOk Δ Ξ K) (hk : K.ep k = some ent) (hty : ent'.ty = ent.ty)
    (hq : ∀ t, Ξ.ep.lookup k = some t → ∀ w ∈ ent'.q, PktOk Δ (.opt t) w) :
    ChanOk Δ Ξ (K.setEp k ent') := by
  refine ⟨hC.len, hC.wf, hC.typed, ?_, ?_, ?_⟩
  · intro k' t' h
    by_cases hkk : k' = k
    · subst hkk; exact ⟨ent', by simp [ChanSt.setEp]⟩
    · obtain ⟨e', he'⟩ := hC.epdom k' t' h
      exact ⟨e', by simp [ChanSt.setEp, hkk, he']⟩
  · intro k' e' h
    by_cases hkk : k' = k
    · subst hkk; exact hC.eprev k' ent hk
    · simp [ChanSt.setEp, hkk] at h
      exact hC.eprev k' e' h
  · intro k' t' e' h1 h2
    by_cases hkk : k' = k
    · subst hkk
      simp [ChanSt.setEp] at h2
      subst h2
      obtain ⟨hcan, hmf, hcf, hty0, -⟩ := hC.eptyped k' t' ent h1 hk
      exact ⟨hcan, hmf, hcf, by rw [hty, hty0], hq t' h1⟩
    · simp [ChanSt.setEp, hkk] at h2
      exact hC.eptyped k' t' e' h1 h2

/-- 状態型付けの transport（Ξ 版）: newchan で Ξ が伸びても保たれる。
Ξ は全タスク共有なので、あるタスクの newchan が兄弟タスクの型付けを壊さないことの中身 -/
theorem StateTy.chan_mono {Δ : Defs} {Ξ Ξ' : ChanTy} {b : Nat} {s : State} {tf : Ty}
    (hle : ChanLE Ξ Ξ') (htk : Ξ'.tk = Ξ.tk) (h : StateTy Δ Ξ b s tf) : StateTy Δ Ξ' b s tf := by
  induction h generalizing Ξ' with
  | eval he hS hH =>
    exact .eval (he.chan_mono hle) (hS.chan_mono hle) (heapOk_chan_mono hle hH)
  | ret hv he hS hH =>
    exact .ret hv (he.chan_mono hle) (hS.chan_mono hle) (heapOk_chan_mono hle hH)
  | par _ _ hf1 hf2 hS hH ih1 ih2 =>
    exact .par (ih1 hle htk) (ih2 hle htk) hf1 hf2 (hS.chan_mono hle) (heapOk_chan_mono hle hH)
  | panic => exact .panic
  | fam Ξs bs tcs hmf _ hlen hch hep hloc hex hkt _ htg ihm ihk =>
    -- 子の世界は共有の部分（ch / ep）だけ親に揃えて伸ばす（子自身の tk はそのまま）
    refine .fam (fun i => { Ξs i with ch := Ξ'.ch, ep := Ξ'.ep }) bs tcs hmf (ihm hle htk) (by rw [htk]; exact hlen)
      (fun _ => rfl) (fun _ => rfl) (by rw [htk]; exact hloc) (by rw [htk]; exact hex) (by rw [htk]; exact hkt) ?_ htg
    intro i rs kid hk
    refine ihk i rs kid hk ⟨?_, ?_, fun _ _ h => h⟩ rfl
    · intro c p h; rw [hch i] at h; exact hle.ch c p h
    · intro k t' h; rw [hep i] at h; exact hle.ep k t' h

/-- jump の巻き戻しの型付け（V4 / R4b）。スタックの帰納で n 番目の labelK を探す:
- 途中の regionK は heapOk_pop で region を 1 つ降ろす（ヒープは常に H.take d' の形）
- 到達した labelK は深さ d' で tL を受ける下のスタック、値を降ろす床 tL.regionsBelow d'、ラベルの最内 k = d' - 1 を与える
- nil（底）と fretK（関数境界）は穴の Λ = [] なので Λ[n]? = some が矛盾 — 巻き戻しは世界・関数を越えない
Ψ はスタック全体の型付けに固定し、ヒープは Ψ.take d で型付ける（pop のたびに Ψ を替えずに済む） -/
theorem unwind_ok {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {b : Nat} {S : Stack} {d : Nat}
    {t tf : Ty} (hS : StackTy Δ Ξ Ψ b S Λ d t tf) :
    ∀ {n : Nat} {tL : Ty} {k : Nat} {H : Heap}, Λ[n]? = some (tL, k) → d ≤ Ψ.length →
      HeapOk Δ Ξ b (Ψ.take d) H →
      ∃ (S' : Stack) (Λ' : LCtx) (d' : Nat), unwind n S H = some (H.take d', S', tL) ∧ d' ≤ d ∧
        StackTy Δ Ξ Ψ b S' Λ' d' tL tf ∧ tL.regionsBelow d' = true ∧
        HeapOk Δ Ξ b (Ψ.take d') (H.take d') ∧ k = d' - 1 := by
  induction hS
  case nil => intro n tL k H hn; simp at hn
  case taskK => intro n tL k H hn; simp at hn
  case fretK => intro n tL k H hn; simp at hn
  case fretKA => intro n tL k H hn; simp at hn
  case scopeK => intro n tL k H hn; simp at hn
  case labelK S d t tf hb hS' ih =>
    intro n tL k H hn hd hH
    cases n with
    | zero =>
      simp only [List.getElem?_cons_zero, Option.some.injEq, Prod.mk.injEq] at hn
      obtain ⟨rfl, rfl⟩ := hn
      have hHlen : H.length = d := by rw [hH.len, List.length_take]; omega
      have htk : H.take d = H := by rw [← hHlen]; exact List.take_length
      refine ⟨S, _, d, ?_, Nat.le_refl _, hS', hb, ?_, rfl⟩
      · rw [htk]; rfl
      · rw [htk]; exact hH
    | succ n =>
      simp only [List.getElem?_cons_succ] at hn
      exact ih hn hd hH
  case regionK S d t tf hb hS' ih =>
    intro n tL k H hn hd hH
    have hHlen : H.length = d + 1 := by rw [hH.len, List.length_take]; omega
    have hΨ : (Ψ.take (d + 1)).dropLast = Ψ.take d := by
      rw [List.dropLast_eq_take, List.length_take, List.take_take]
      congr 1; omega
    have hHd : H.dropLast = H.take d := by
      rw [List.dropLast_eq_take, hHlen]; rfl
    have hpop := heapOk_pop hH
    rw [hΨ, hHd] at hpop
    obtain ⟨S', Λ', d', h1, h2, h3, h4, h5, h6⟩ := ih hn (by omega) hpop
    have htt : (H.take d).take d' = H.take d' := by
      rw [List.take_take, Nat.min_eq_left h2]
    rw [htt] at h1 h5
    refine ⟨S', Λ', d', ?_, by omega, h3, h4, h5, h6⟩
    show unwind n S H.dropLast = _
    rw [hHd]; exact h1
  case regionKR S d tB t tf hr hb hS' ih =>
    intro n tL k H hn hd hH
    have hHlen : H.length = d + 1 := by rw [hH.len, List.length_take]; omega
    have hΨ : (Ψ.take (d + 1)).dropLast = Ψ.take d := by
      rw [List.dropLast_eq_take, List.length_take, List.take_take]
      congr 1; omega
    have hHd : H.dropLast = H.take d := by
      rw [List.dropLast_eq_take, hHlen]; rfl
    have hpop := heapOk_pop hH
    rw [hΨ, hHd] at hpop
    obtain ⟨S', Λ', d', h1, h2, h3, h4, h5, h6⟩ := ih hn (by omega) hpop
    have htt : (H.take d).take d' = H.take d' := by
      rw [List.take_take, Nat.min_eq_left h2]
    rw [htt] at h1 h5
    refine ⟨S', Λ', d', ?_, by omega, h3, h4, h5, h6⟩
    show unwind n S H.dropLast = _
    rw [hHd]; exact h1
  all_goals
    rename_i ih
    intro n tL k H hn hd hH
    exact ih hn hd hH

end FS
