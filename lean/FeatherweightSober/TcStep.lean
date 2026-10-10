import FeatherweightSober.Checker

/-!
# typecheck の 1 フレームの遷移関数（段 6 P2b — E3 typecheck の抽出・(γ') =）

`typecheck` は右辺で「部分項の検査の結果」に match する（56/82 腕 — 抽出器の方程式経由では写せない）。
ここではそれを**再帰しない 1 フレームの遷移** `tcStep` に書き直す: フレーム = (式 e・段 ph・文脈 b d Γ Λ・それまでの子の結果 r1 r2 r3)。
`tcStep` は「次に降りる子とその文脈（`Act.sub`）」か「このフレームの結果（`Act.ret`）」を返す。子の結果は**引数**で受けるので、
「計算結果への match」が「引数への match」に変わる — 抽出器（lean/Extract — 方程式経由）がそのまま写せる形。

書き方の規律（抽出器の受け口）:
- `tcStep` 自身のパターンは (式の構成子, 段) だけ（段は 0 / 1 / 2 / n+k — 重なりなし）。結果の型の入れ子のパターンは全部、
  1 腕 1 つの小さな関数（`k…` = 結果を組む・`s…` = 結果に依存して次の子と文脈を決める）の**引数のパターン**に置く
- 右辺に計算への match を書かない（`Δ[fn]?`・`Λ[n]?`・`Ty.anchorOf …` は補助関数の引数に持ち上げる）
- 文脈・関数表の読み口は小さな定義（`ctxGet` / `ctxCons` / `lctxTy` / `lctxK` / `lctxCons` / `defGet` / `defParam` / `defRet` / `defTps` /
  `tsLen` / `ctxAllMutFree`）— Sober 側は表現に合わせた手書きの shim（compiler/checker/check.sober）

`evalRule`（燃料つきの大ステップ — フレームを段 0〜3 で回す）と**定理 `typecheck_eq_evalRule`**: `typecheck … e = evalRule … (sizeOf e + 1) … e`。
Sober 側は `evalRule` の燃料なし版を明示スタックで回す汎用の駆動部（手書き・一度だけ）+ 抽出した `tcStep`。

`typecheck` は「評価した部分項がすべて some のときだけ some」で、部分項の評価の順・文脈の組み方はここでも同じ。違いは
`typecheck` が先に返す none（`d = 0`・`Δ[fn]?` が none 等）の場面でも、ここでは部分項を評価してから none を返す形がある
（結果は同じ none — 定理が保証する）。
-/
namespace FS

/-- 1 フレームの遷移の結果: 子 e へ文脈 (b, d, Γ, Λ) で降りる / このフレームの結果 r -/
inductive Act where
  | sub (e : Expr) (b d : Nat) (Γ : Ctx) (Λ : LCtx)
  | ret (r : Option Ty)

/-! ## 読み口（Sober 側は手書きの shim） -/

def ctxGet (Γ : Ctx) (i : Nat) : Option Ty := Γ[i]?
def ctxCons (t : Ty) (Γ : Ctx) : Ctx := t :: Γ
def ctxAllMutFree (Γ : Ctx) : Bool := Γ.all Ty.mutFree
def lctxTy (Λ : LCtx) (n : Nat) : Option Ty := (Λ[n]?).map Prod.fst
def lctxK (Λ : LCtx) (n : Nat) : Nat := ((Λ[n]?).map Prod.snd).getD 0
def lctxCons (t : Ty) (k : Nat) (Λ : LCtx) : LCtx := (t, k) :: Λ
def defGet (Δ : Defs) (fn : Nat) : Option Def := Δ[fn]?
def defParam (dfn : Def) (ts : List Ty) : Ty := (dfn.inst ts).param
def defRet (dfn : Def) (ts : List Ty) : Ty := (dfn.inst ts).ret
def defTps (dfn : Def) : Nat := dfn.tparams
def tsLen (ts : List Ty) : Nat := ts.length

/-! ## 結果を組む関数（k…）と、結果で次の子を決める関数（s…） -/

/-- add / arith（int × int → int）・lt / cmp（→ bool） -/
def kII : Option Ty → Option Ty → Ty → Option Ty
  | some .int, some .int, res => some res
  | _, _, _ => none

def kFF : Option Ty → Option Ty → Ty → Option Ty
  | some .f64, some .f64, res => some res
  | _, _, _ => none

def kIte : Option Ty → Option Ty → Option Ty → Option Ty
  | some .bool, some τ₁, some τ₂ => if τ₁ = τ₂ then some τ₁ else none
  | _, _, _ => none

/-- 2 つの腕の型が等しい（ifnil / case の最後） -/
def kEq2 : Option Ty → Option Ty → Option Ty
  | some τ₁, some τ₂ => if τ₁ = τ₂ then some τ₁ else none
  | _, _ => none

def kSome : Option Ty → Option Ty
  | some t => some (.opt t)
  | none => none

def kInl : Option Ty → Ty → Option Ty
  | some l, r => some (.union l r)
  | none, _ => none

def kInr : Option Ty → Ty → Option Ty
  | some r, l => some (.union l r)
  | none, _ => none

def kPair : Option Ty → Option Ty → Option Ty
  | some l, some r => some (.prod l r)
  | _, _ => none

def kFst : Option Ty → Option Ty
  | some (.prod l _) => some l
  | _ => none

def kSnd : Option Ty → Option Ty
  | some (.prod _ r) => some r
  | _ => none

def sLet : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some t, body, b, d, Γ, Λ => .sub body b d (ctxCons t Γ) Λ
  | none, _, _, _, _, _ => .ret none

def sIfnil1 : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some (.opt _), n, b, d, Γ, Λ => .sub n b d Γ Λ
  | _, _, _, _, _, _ => .ret none

def sIfnil2 : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some (.opt t), s, b, d, Γ, Λ => .sub s b d (ctxCons t Γ) Λ
  | _, _, _, _, _, _ => .ret none

def sCase1 : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some (.union l _), bl, b, d, Γ, Λ => .sub bl b d (ctxCons l Γ) Λ
  | _, _, _, _, _, _ => .ret none

def sCase2 : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some (.union _ r), br, b, d, Γ, Λ => .sub br b d (ctxCons r Γ) Λ
  | _, _, _, _, _, _ => .ret none

/-- call: 呼び手深さ d = d' + 1、ρ = d'。引数は浅い imm 共変で param.shiftR d' へ -/
def kCall : Option Def → List Ty → Option Ty → Nat → Nat → Option Ty
  | some dfn, ts, some t, b, d' + 1 =>
      if decide (tsLen ts = defTps dfn) && Ty.tyArgsOk ts &&
          Ty.sub t ((defParam dfn ts).shiftR d') && decide (b ≤ d') then
        some ((defRet dfn ts).relocR d')
      else none
  | _, _, _, _, _ => none

def kCallM2 : Option Nat → Def → List Ty → Ty → Nat → Nat → Option Ty
  | some a, dfn, ts, t, b, d' =>
      if decide (tsLen ts = defTps dfn) && Ty.tyArgsOk ts &&
          Ty.sub t ((defParam dfn ts).renR a d') && decide (b ≤ a) && decide (a ≤ d') then
        some ((defRet dfn ts).relocA a d')
      else none
  | none, _, _, _, _, _ => none

/-- callM: call と同じ形。anchor a は引数の型の mut 位置から読む -/
def kCallM : Option Def → List Ty → Option Ty → Nat → Nat → Option Ty
  | some dfn, ts, some t, b, d' + 1 => kCallM2 (Ty.anchorOf (defParam dfn ts) t) dfn ts t b d'
  | _, _, _, _, _ => none

def kFnref : Option Def → List Ty → Option Ty
  | some dfn, ts =>
      if decide (tsLen ts = defTps dfn) && Ty.tyArgsOk ts then
        some (.fn (defParam dfn ts) (defRet dfn ts))
      else none
  | none, _ => none

def kAnn : Option Ty → Ty → Option Ty
  | some ta, t => if Ty.sub ta t then some t else none
  | none, _ => none

def sCallv1 : Option Ty → Expr → Nat → Nat → Ctx → LCtx → Act
  | some (.fn _ _), e, b, d, Γ, Λ => .sub e b d Γ Λ
  | _, _, _, _, _, _ => .ret none

def kCallv : Option Ty → Option Ty → Nat → Nat → Option Ty
  | some (.fn p r), some t, b, d' + 1 =>
      if Ty.sub t (p.shiftR d') && decide (b ≤ d') then some (r.relocR d') else none
  | _, _, _, _ => none

def kLabel : Option Ty → Ty → Nat → Option Ty
  | some t', t, d => if t' = t && t.regionsBelow d then some t else none
  | none, _, _ => none

def kJump : Option Ty → Nat → Option Ty → Nat → Ty → Option Ty
  | some tL, k, some t', b, t => if Ty.jumpRel b k t' tL then some t else none
  | _, _, _, _, _ => none

def kBlock : Option Ty → Nat → Option Ty
  | some t, d => if t.regionsBelow d then some t else none
  | none, _ => none

/-- blockR と scope の出口（同じ形） -/
def kBlockR : Option Ty → Nat → Nat → Ty → Option Ty
  | some tB, b, d, t => if Ty.jumpRel b (d - 1) tB t && t.regionsBelow d then some t else none
  | none, _, _, _ => none

/-- scope の結果（P3a A1 (X) + P3b-4 1b'）: blockR と同じ条件で `union t (union unit ε')`（inr (inl) = 子の死・inr (inr) = 未回収の失敗） -/
def kScope : Option Ty → Nat → Nat → Ty → Ty → Option Ty
  | some tB, b, d, t, ε =>
      if Ty.jumpRel b (d - 1) tB t && t.regionsBelow d && ε.mutFree && ε.chanFree && decide (b < d) then
        some (.union t (.union .unit (ε.relocR (d - 1))))
      else none
  | none, _, _, _, _ => none

def kCopyTo : Option Ty → Nat → Nat → Nat → Ty → Option Ty
  | some tE, b, d, k, t =>
      if decide (k < d) && Ty.jumpRel b k tE t && t.regionsBelow (k + 1) && t.chanFree then some t else none
  | none, _, _, _, _ => none

def kAlloc : Option Ty → Nat → Nat → Bool → Option Ty
  | some t, b, d + 1, m =>
      if t.regionsBelow (d + 1) && decide (b ≤ d) && (m || t.mutFree) then some (.ref m d t) else none
  | _, _, _, _ => none

def kDeref : Option Ty → Option Ty
  | some (.ref _ _ t) => some t
  | _ => none

def kAssign : Option Ty → Option Ty → Option Ty
  | some (.ref true _ t), some t' => if t' = t then some .unit else none
  | _, _ => none

def kWhile : Option Ty → Option Ty → Option Ty
  | some .bool, some _ => some .unit
  | _, _ => none

def kFreeze : Option Ty → Option Ty
  | some (.ref true r t) => if t.mutFree then some (.ref false r t) else none
  | some (.slice true r t) => if t.mutFree then some (.slice false r t) else none
  | some (.map true r t) => if t.mutFree then some (.map false r t) else none
  | _ => none

def kMkslice : Nat → Nat → Bool → Ty → Option Ty
  | _, 0, _, _ => none
  | b, d + 1, m, t =>
      if t.regionsBelow (d + 1) && decide (b ≤ d) && (m || t.mutFree) then some (.slice m d t) else none

def kStrlit (b d r : Nat) : Option Ty :=
  if decide (b ≤ r) && decide (r < d) then some (.slice false r .byte) else none

def kMksliceAt (b d : Nat) (m : Bool) (t : Ty) (r : Nat) : Option Ty :=
  if t.regionsBelow (r + 1) && decide (b ≤ r) && decide (r < d) && (m || t.mutFree) && t.chanFree then
    some (.slice m r t)
  else none

def kMkmapAt : Nat → Nat → Bool → Ty → Nat → Option Ty
  | b, d, m, .prod k (.opt t), r =>
      if k.keyOk && (Ty.prod k (.opt t)).regionsBelow (r + 1) && decide (b ≤ r) && decide (r < d) &&
          (m || (Ty.prod k (.opt t)).mutFree) && (Ty.prod k (.opt t)).chanFree then
        some (.map m r (.prod k (.opt t)))
      else none
  | _, _, _, _, _ => none

def kIndex : Option Ty → Option Ty → Option Ty → Option Ty
  | some (.slice m _ t), some .int, ot => Ty.readAs m ot t
  | _, _, _ => none

def kLen : Option Ty → Option Ty
  | some (.slice _ _ _) => some .int
  | _ => none

def kTobyte : Option Ty → Option Ty
  | some .int => some .byte
  | _ => none

def kToint : Option Ty → Option Ty
  | some .byte => some .int
  | _ => none

def kFconv : Option Ty → FConvOp → Option Ty
  | some t, op => if t = op.dom then some op.cod else none
  | none, _ => none

def kAppend : Option Ty → Option Ty → Nat → Nat → Option Ty
  | some (.slice true r t), some t', b, _ => if t' = t && decide (b ≤ r) then some (.slice true r t) else none
  | some (.slice false _ t), some t', b, d' + 1 =>
      if t' = t && decide (b ≤ d') && t.regionsBelow (d' + 1) then some (.slice false d' t) else none
  | _, _, _, _ => none

def kSetidx : Option Ty → Option Ty → Option Ty → Option Ty
  | some (.slice true _ t), some .int, some t' => if t' = t then some .unit else none
  | _, _, _ => none

def kSubslice : Option Ty → Option Ty → Option Ty → Option Ty
  | some (.slice false r t), some .int, some .int => some (.slice false r t)
  | _, _, _ => none

def kEqs : Option Ty → Option Ty → Option Ty
  | some (.slice false _ .byte), some (.slice false _ .byte) => some .bool
  | _, _ => none

def kConcat : Option Ty → Option Ty → Nat → Nat → Option Ty
  | some (.slice false _ t1), some (.slice false _ t2), b, d' + 1 =>
      if t2 = t1 && decide (b ≤ d') then some (.slice false d' t1) else none
  | _, _, _, _ => none

def kMkmap : Nat → Nat → Bool → Ty → Option Ty
  | _, 0, _, _ => none
  | b, d + 1, m, .prod k (.opt t) =>
      if k.keyOk && (Ty.prod k (.opt t)).regionsBelow (d + 1) && decide (b ≤ d) &&
          (m || (Ty.prod k (.opt t)).mutFree) then
        some (.map m d (.prod k (.opt t)))
      else none
  | _, _ + 1, _, _ => none

def kGetm : Option Ty → Option Ty → Ty → Option Ty
  | some (.map _ _ (.prod kt (.opt t'))), some kq, t => if Ty.sub t' t && kq.keyCompat kt then some (.opt t) else none
  | _, _, _ => none

def kSetm : Option Ty → Option Ty → Option Ty → Option Ty
  | some (.map true r (.prod kt (.opt t))), some k', some t' =>
      if k' = kt && t' = t then some (.map true r (.prod kt (.opt t))) else none
  | _, _, _ => none

def kDelm : Option Ty → Option Ty → Ty → Option Ty
  | some (.map true _ (.prod kt (.opt t'))), some kq, t => if t' = t && kq.keyCompat kt then some .unit else none
  | _, _, _ => none

def kLenm : Option Ty → Option Ty
  | some (.map _ _ _) => some .int
  | _ => none

def kKeysm : Option Ty → Nat → Nat → Option Ty
  | some (.map _ _ (.prod kt (.opt _))), b, d' + 1 =>
      if kt.keyOk && kt.regionsBelow (d' + 1) && decide (b ≤ d') then some (.slice false d' kt) else none
  | _, _, _ => none

def kPar : Option Ty → Option Ty → Bool → Option Ty
  | some _, some _, ok => if ok then some .unit else none
  | _, _, _ => none

def kParch : Option Ty → Option Ty → Bool → Nat → Ty → Option Ty
  | some _, some _, ok, d, t => if ok && t.regionsBelow d && t.mutFree then some .unit else none
  | _, _, _, _, _ => none

def kNewchan (f rc : Nat) (t : Ty) : Option Ty :=
  if decide (rc ≤ f) && t.regionsBelow rc && t.mutFree then some (.chan rc t) else none

def kSend : Option Ty → Option Ty → Option Ty
  | some (.chan _ t), some t' => if t' = t then some .unit else none
  | some (.own .tx _ t), some t' => if Ty.payOk t' t then some .unit else none
  | _, _ => none

def kRecv (d : Nat) : Option Ty → Option Ty
  | some (.chan _ t) => some t
  | some (.own .rx _ t) => if t.mutFree && t.chanFree then some (.opt (t.relocR (d - 1))) else none
  | _ => none

def kClose : Option Ty → Option Ty
  | some (.own .tx _ _) => some .unit
  | _ => none

def sSpawn2 : Option Ty → Option Ty → Expr → Nat → Act
  | some (.own .scope _ _), some ta, e, d => .sub e d (d + 1) (ctxCons (ta.rehome d) []) []
  | _, _, _, _ => .ret none

def kSpawn : Option Ty → Option Ty → Option Ty → Option Ty
  | some (.own .scope rs ε), some ta, some (.prod t (.opt ε0)) =>
      if ta.givable rs && (Ty.prod t (.opt ε0)).mutFree && (Ty.prod t (.opt ε0)).chanFree && Ty.payOk ε0 ε then
        some (.own .task rs ((Ty.prod t (.opt ε0)).relocR rs))
      else none
  | _, _, _ => none

def kNewch (b d r cap : Nat) (t : Ty) : Option Ty :=
  if decide (b ≤ r) && decide (r < d) && decide (1 ≤ cap) && t.mutFree && t.chanFree && t.regionsBelow d then
    some (.prod (.own .tx r t) (.own .rx r t))
  else none

def kJoin : Option Ty → Ty → Option Ty
  | some (.own .task _ t'), t => if t' = t then some t else none
  | _, _ => none

def kTry : Option Ty → Ty → Option Ty
  | some (.own .task _ t'), t => if t' = t then some (.opt t) else none
  | _, _ => none

/-! ## 1 フレームの遷移 -/

/-- フレーム (e, ph) の 1 歩。r1 r2 r3 = 段 1〜3 までに評価し終えた子の結果（まだのものは none） -/
def tcStep (Δ : Defs) (f b d : Nat) (Γ : Ctx) (Λ : LCtx) (r1 r2 r3 : Option Ty) : Expr → Nat → Act
  | .lit _, _ => .ret (some .int)
  | .flit _, _ => .ret (some .f64)
  | .tt, _ => .ret (some .bool)
  | .ff, _ => .ret (some .bool)
  | .triv, _ => .ret (some .unit)
  | .var i, _ => .ret (ctxGet Γ i)
  | .letE e _, 0 => .sub e b d Γ Λ
  | .letE _ body, 1 => sLet r1 body b d Γ Λ
  | .letE _ _, _ + 2 => .ret r2
  | .add a _, 0 => .sub a b d Γ Λ
  | .add _ c, 1 => .sub c b d Γ Λ
  | .add _ _, _ + 2 => .ret (kII r1 r2 .int)
  | .lt a _, 0 => .sub a b d Γ Λ
  | .lt _ c, 1 => .sub c b d Γ Λ
  | .lt _ _, _ + 2 => .ret (kII r1 r2 .bool)
  | .arith _ a _, 0 => .sub a b d Γ Λ
  | .arith _ _ c, 1 => .sub c b d Γ Λ
  | .arith _ _ _, _ + 2 => .ret (kII r1 r2 .int)
  | .cmp _ a _, 0 => .sub a b d Γ Λ
  | .cmp _ _ c, 1 => .sub c b d Γ Λ
  | .cmp _ _ _, _ + 2 => .ret (kII r1 r2 .bool)
  | .ite c _ _, 0 => .sub c b d Γ Λ
  | .ite _ t _, 1 => .sub t b d Γ Λ
  | .ite _ _ e, 2 => .sub e b d Γ Λ
  | .ite _ _ _, _ + 3 => .ret (kIte r1 r2 r3)
  | .nil t, _ => .ret (some (.opt t))
  | .some e, 0 => .sub e b d Γ Λ
  | .some _, _ + 1 => .ret (kSome r1)
  | .ifnil e _ _, 0 => .sub e b d Γ Λ
  | .ifnil _ n _, 1 => sIfnil1 r1 n b d Γ Λ
  | .ifnil _ _ s, 2 => sIfnil2 r1 s b d Γ Λ
  | .ifnil _ _ _, _ + 3 => .ret (kEq2 r2 r3)
  | .inl _ e, 0 => .sub e b d Γ Λ
  | .inl r _, _ + 1 => .ret (kInl r1 r)
  | .inr _ e, 0 => .sub e b d Γ Λ
  | .inr l _, _ + 1 => .ret (kInr r1 l)
  | .case e _ _, 0 => .sub e b d Γ Λ
  | .case _ bl _, 1 => sCase1 r1 bl b d Γ Λ
  | .case _ _ br, 2 => sCase2 r1 br b d Γ Λ
  | .case _ _ _, _ + 3 => .ret (kEq2 r2 r3)
  | .pair a _, 0 => .sub a b d Γ Λ
  | .pair _ c, 1 => .sub c b d Γ Λ
  | .pair _ _, _ + 2 => .ret (kPair r1 r2)
  | .fst e, 0 => .sub e b d Γ Λ
  | .fst _, _ + 1 => .ret (kFst r1)
  | .snd e, 0 => .sub e b d Γ Λ
  | .snd _, _ + 1 => .ret (kSnd r1)
  | .call _ _ e, 0 => .sub e b d Γ Λ
  | .call fn ts _, _ + 1 => .ret (kCall (defGet Δ fn) ts r1 b d)
  | .callM _ _ e, 0 => .sub e b d Γ Λ
  | .callM fn ts _, _ + 1 => .ret (kCallM (defGet Δ fn) ts r1 b d)
  | .fnref fn ts, _ => .ret (kFnref (defGet Δ fn) ts)
  | .ann e _, 0 => .sub e b d Γ Λ
  | .ann _ t, _ + 1 => .ret (kAnn r1 t)
  | .callv ef _, 0 => .sub ef b d Γ Λ
  | .callv _ e, 1 => sCallv1 r1 e b d Γ Λ
  | .callv _ _, _ + 2 => .ret (kCallv r1 r2 b d)
  | .label t e, 0 => .sub e b d Γ (lctxCons t (d - 1) Λ)
  | .label t _, _ + 1 => .ret (kLabel r1 t d)
  | .unreach t, _ => .ret (some t)
  | .jump _ _ e, 0 => .sub e b d Γ Λ
  | .jump n t _, _ + 1 => .ret (kJump (lctxTy Λ n) (lctxK Λ n) r1 b t)
  | .block e, 0 => .sub e b (d + 1) Γ Λ
  | .block _, _ + 1 => .ret (kBlock r1 d)
  | .blockR _ e, 0 => .sub e b (d + 1) Γ Λ
  | .blockR t _, _ + 1 => .ret (kBlockR r1 b d t)
  | .copyTo _ _ e, 0 => .sub e b d Γ Λ
  | .copyTo k t _, _ + 1 => .ret (kCopyTo r1 b d k t)
  | .alloc _ e, 0 => .sub e b d Γ Λ
  | .alloc m _, _ + 1 => .ret (kAlloc r1 b d m)
  | .deref e, 0 => .sub e b d Γ Λ
  | .deref _, _ + 1 => .ret (kDeref r1)
  | .assign l _, 0 => .sub l b d Γ Λ
  | .assign _ e, 1 => .sub e b d Γ Λ
  | .assign _ _, _ + 2 => .ret (kAssign r1 r2)
  | .whileE c _, 0 => .sub c b d Γ Λ
  | .whileE _ body, 1 => .sub body b d Γ Λ
  | .whileE _ _, _ + 2 => .ret (kWhile r1 r2)
  | .freeze e, 0 => .sub e b d Γ Λ
  | .freeze _, _ + 1 => .ret (kFreeze r1)
  | .mkslice m t, _ => .ret (kMkslice b d m t)
  | .strlit _ r, _ => .ret (kStrlit b d r)
  | .mksliceAt m t r, _ => .ret (kMksliceAt b d m t r)
  | .mkmapAt m t r, _ => .ret (kMkmapAt b d m t r)
  | .index e _ _, 0 => .sub e b d Γ Λ
  | .index _ i _, 1 => .sub i b d Γ Λ
  | .index _ _ ot, _ + 2 => .ret (kIndex r1 r2 ot)
  | .lenE e, 0 => .sub e b d Γ Λ
  | .lenE _, _ + 1 => .ret (kLen r1)
  | .tobyte e, 0 => .sub e b d Γ Λ
  | .tobyte _, _ + 1 => .ret (kTobyte r1)
  | .toint e, 0 => .sub e b d Γ Λ
  | .toint _, _ + 1 => .ret (kToint r1)
  | .farith _ a _, 0 => .sub a b d Γ Λ
  | .farith _ _ c, 1 => .sub c b d Γ Λ
  | .farith _ _ _, _ + 2 => .ret (kFF r1 r2 .f64)
  | .fcmp _ a _, 0 => .sub a b d Γ Λ
  | .fcmp _ _ c, 1 => .sub c b d Γ Λ
  | .fcmp _ _ _, _ + 2 => .ret (kFF r1 r2 .bool)
  | .fconv _ e, 0 => .sub e b d Γ Λ
  | .fconv op _, _ + 1 => .ret (kFconv r1 op)
  | .append e _, 0 => .sub e b d Γ Λ
  | .append _ v, 1 => .sub v b d Γ Λ
  | .append _ _, _ + 2 => .ret (kAppend r1 r2 b d)
  | .setidx e _ _, 0 => .sub e b d Γ Λ
  | .setidx _ i _, 1 => .sub i b d Γ Λ
  | .setidx _ _ v, 2 => .sub v b d Γ Λ
  | .setidx _ _ _, _ + 3 => .ret (kSetidx r1 r2 r3)
  | .subslice e _ _, 0 => .sub e b d Γ Λ
  | .subslice _ sa _, 1 => .sub sa b d Γ Λ
  | .subslice _ _ sb, 2 => .sub sb b d Γ Λ
  | .subslice _ _ _, _ + 3 => .ret (kSubslice r1 r2 r3)
  | .eqs e1 _, 0 => .sub e1 b d Γ Λ
  | .eqs _ e2, 1 => .sub e2 b d Γ Λ
  | .eqs _ _, _ + 2 => .ret (kEqs r1 r2)
  | .concat e1 _, 0 => .sub e1 b d Γ Λ
  | .concat _ e2, 1 => .sub e2 b d Γ Λ
  | .concat _ _, _ + 2 => .ret (kConcat r1 r2 b d)
  | .slicev _ _ _ _, _ => .ret none
  | .mkmap m t, _ => .ret (kMkmap b d m t)
  | .getm _ e _, 0 => .sub e b d Γ Λ
  | .getm _ _ k, 1 => .sub k b d Γ Λ
  | .getm t _ _, _ + 2 => .ret (kGetm r1 r2 t)
  | .setm e _ _, 0 => .sub e b d Γ Λ
  | .setm _ k _, 1 => .sub k b d Γ Λ
  | .setm _ _ v, 2 => .sub v b d Γ Λ
  | .setm _ _ _, _ + 3 => .ret (kSetm r1 r2 r3)
  | .delm _ e _, 0 => .sub e b d Γ Λ
  | .delm _ _ k, 1 => .sub k b d Γ Λ
  | .delm t _ _, _ + 2 => .ret (kDelm r1 r2 t)
  | .lenm e, 0 => .sub e b d Γ Λ
  | .lenm _, _ + 1 => .ret (kLenm r1)
  | .keysm e, 0 => .sub e b d Γ Λ
  | .keysm _, _ + 1 => .ret (kKeysm r1 b d)
  | .mapv _ _ _ _, _ => .ret none
  | .par e1 _, 0 => .sub e1 d d Γ []
  | .par _ e2, 1 => .sub e2 d d Γ []
  | .par _ _, _ + 2 => .ret (kPar r1 r2 (ctxAllMutFree Γ))
  | .parch t e1 _, 0 => .sub e1 d d (ctxCons (.chan d t) Γ) []
  | .parch t _ e2, 1 => .sub e2 d d (ctxCons (.chan d t) Γ) []
  | .parch t _ _, _ + 2 => .ret (kParch r1 r2 (ctxAllMutFree Γ) d t)
  | .newchan rc t, _ => .ret (kNewchan f rc t)
  | .send c _, 0 => .sub c b d Γ Λ
  | .send _ e, 1 => .sub e b d Γ Λ
  | .send _ _, _ + 2 => .ret (kSend r1 r2)
  | .recv c, 0 => .sub c b d Γ Λ
  | .recv _, _ + 1 => .ret (kRecv d r1)
  | .close c, 0 => .sub c b d Γ Λ
  | .close _, _ + 1 => .ret (kClose r1)
  | .loc _ _, _ => .ret none
  | .blit _, _ => .ret none
  | .chanV _, _ => .ret none
  | .scope _ ε e, 0 => .sub e b (d + 1) (ctxCons (.own .scope d ε) Γ) []
  | .scope t ε _, _ + 1 => .ret (kScope r1 b d t ε)
  | .spawn sc _ _, 0 => .sub sc b d Γ Λ
  | .spawn _ a _, 1 => .sub a b d Γ Λ
  | .spawn _ _ e, 2 => sSpawn2 r1 r2 e d
  | .spawn _ _ _, _ + 3 => .ret (kSpawn r1 r2 r3)
  | .newch r cap t, _ => .ret (kNewch b d r cap t)
  | .epV _ _ _ _, _ => .ret none
  | .join _ h, 0 => .sub h b d Γ Λ
  | .join t _, _ + 1 => .ret (kJoin r1 t)
  | .tryJ _ h, 0 => .sub h b d Γ Λ
  | .tryJ t _, _ + 1 => .ret (kTry r1 t)
  | .scopeV _ _, _ => .ret none
  | .taskV _ _, _ => .ret none

/-- 燃料つきの大ステップ: フレームを段 0〜3 で回す（子は燃料を 1 減らして同じ関数で）。Sober 側の駆動部はこの燃料なし版 -/
def evalRule (Δ : Defs) (f : Nat) : Nat → Nat → Nat → Ctx → LCtx → Expr → Option Ty
  | 0, _, _, _, _, _ => none
  | n + 1, b, d, Γ, Λ, e =>
    match tcStep Δ f b d Γ Λ none none none e 0 with
    | .ret r => r
    | .sub e1 b1 d1 Γ1 Λ1 =>
      let r1 := evalRule Δ f n b1 d1 Γ1 Λ1 e1
      match tcStep Δ f b d Γ Λ r1 none none e 1 with
      | .ret r => r
      | .sub e2 b2 d2 Γ2 Λ2 =>
        let r2 := evalRule Δ f n b2 d2 Γ2 Λ2 e2
        match tcStep Δ f b d Γ Λ r1 r2 none e 2 with
        | .ret r => r
        | .sub e3 b3 d3 Γ3 Λ3 =>
          let r3 := evalRule Δ f n b3 d3 Γ3 Λ3 e3
          match tcStep Δ f b d Γ Λ r1 r2 r3 e 3 with
          | .ret r => r
          | .sub _ _ _ _ _ => none

end FS
