import FeatherweightSober.Json

/-!
# コア AST の生成器（段 2 の差分テスト基盤。formal.md「実装との照合」2）

JSON テストベクタ + Lean 判定（golden）を吐くための項生成器。乱数は Lean core の
`StdGen`（`mkStdGen seed` から決定的 — 同じシードなら同じベクタ列。toolchain 固定で再現可能）。

2 本立て:
- **型指向生成器** `genTyped`: typecheck の規則に沿って well-typed な項を組む
  （accept 側のカバレッジ。腕は「その状態で使えるものだけの重み表」から引く — Gen 総追いつき段 A）
- **chaos 生成器** `genChaos`: 語彙全体からランダムに組む（大半が reject 側。
  型注釈も index もでたらめでよい — 判定の正は typecheck）

不変条件（型指向側）: 生成する**ターゲット型は常に loc-free**（int / bool / byte / f64 / unit / opt /
union / prod の入れ子）。ref / chan / slice / map（string を含む）は Γ にだけ現れる（alloc / newchan /
parch / mkslice / mkmap / strlit … の束縛経由）。これで block の escape 検査（regionsBelow）に常に通り、
生成が行き詰まらない（region を持つターゲットは段 B）。
-/
namespace FS.Gen

open FS

/-- 乱数つき計算。StdGen を編んで通す -/
abbrev Rand (α : Type) := StateM StdGen α

instance : Inhabited Ty := ⟨.int⟩
instance : Inhabited ArithOp := ⟨.sub⟩
instance : Inhabited CmpOp := ⟨.eq⟩
instance : Inhabited FArithOp := ⟨.add⟩
instance : Inhabited FCmpOp := ⟨.eq⟩
instance : Inhabited FConvOp := ⟨.neg⟩
instance : Inhabited Expr := ⟨.triv⟩

/-- 0..n の一様乱数 -/
def rnd (n : Nat) : Rand Nat := fun g => randNat g 0 n

/-- lo..hi の一様乱数（hi < lo なら lo） -/
def rndIn (lo hi : Nat) : Rand Nat := do return lo + (← rnd (hi - lo))

/-- リストから一様に 1 つ（空なら default） -/
def pickD [Inhabited α] (xs : List α) : Rand α := do
  if xs.length = 0 then return default
  else
    let i ← rnd (xs.length - 1)
    return xs[i]!

def pickWGo [Inhabited α] : List (Nat × α) → Nat → α
  | [], _ => default
  | (w, a) :: rest, k => if k < w then a else pickWGo rest (k - w)

/-- 重みつきで 1 つ（重み 0 の腕は引かれない。全部 0 なら default） -/
def pickW [Inhabited α] (xs : List (Nat × α)) : Rand α := do
  let tot := xs.foldl (fun a p => a + p.1) 0
  if tot = 0 then return default
  else return pickWGo xs (← rnd (tot - 1))

-- ────────────────────────────────────────────────────────────────
-- 型の生成（loc-free のみ。ターゲット型・注釈型・要素型に使う）
-- ────────────────────────────────────────────────────────────────

def genScalarTy : Rand Ty :=
  pickW [(3, Ty.int), (2, .bool), (1, .unit), (1, .byte), (1, .f64)]

def genTy : Nat → Rand Ty
  | 0 => genScalarTy
  | fuel + 1 => do
    match ← rnd 7 with
    | 0 | 1 | 2 | 3 => genScalarTy
    | 4 => return .opt (← genTy fuel)
    | 5 => return .union (← genTy fuel) (← genTy fuel)
    | _ => return .prod (← genTy fuel) (← genTy fuel)

/-- float の値（i64 の 2 の補数で読んだビット列）: 0.0 / 1.0 / 2.0 / -1.0 / NaN -/
def genFlit : Rand Expr := do
  return .flit (← pickD [(0 : Int), 4607182418800017408, 4611686018427387904,
    -4616189618054758400, 9221120237041090560])

/-- string リテラルのバイト列（長さ 0〜3・小文字） -/
def genBytes : Rand (List Int) := do
  let n ← rnd 3
  let mut bs : List Int := []
  for _ in [0:n] do
    bs := Int.ofNat (97 + (← rnd 25)) :: bs
  return bs

-- ────────────────────────────────────────────────────────────────
-- 型指向生成器
-- ────────────────────────────────────────────────────────────────

/-- Γ の中で型 t を持つ変数の index -/
def varsOf (Γ : Ctx) (t : Ty) : List Nat :=
  (List.range Γ.length).filter (fun i => Γ[i]? = some t)

/-- 底の値（fuel 切れ用）。型の構造にだけ再帰する -/
def genBase (t : Ty) : Rand Expr := do
  match t with
  | .int => return .lit (Int.ofNat (← rnd 9))
  | .bool => return (if (← rnd 1) = 0 then .tt else .ff)
  | .byte => return .tobyte (.lit (Int.ofNat (← rnd 255)))
  | .f64 => genFlit
  | .unit => return .triv
  | .opt s =>
    if (← rnd 1) = 0 then return .nil s
    else return .some (← genBase s)
  | .union l r =>
    if (← rnd 1) = 0 then return .inl r (← genBase l)
    else return .inr l (← genBase r)
  | .prod l r => return .pair (← genBase l) (← genBase r)
  -- ターゲット型は loc-free の不変条件があるので来ない（来ても値にはできる形で返す）
  | .ref _ _ _ => return .triv
  | .slice _ _ _ => return .triv
  | .map _ _ _ => return .triv
  | .chan _ _ => return .triv
  | .own _ _ _ => return .triv
  | .fn _ _ => return .triv
  | .tvar _ => return .triv

def tString (r : Nat) : Ty := .slice false r .byte

/-- P3b-4 1b': 子の結果の組の型（err は int） -/
def ktI (t : Ty) : Ty := .prod t (.opt .int)

/-- ベクタ共通の関数表（V3-1: 閉じた関数値を踏むため）。本体は base の世界
（Γ = [param]、d = 2、f = 1、b = 0）で型付く。2 番は関数値を受けて callv する高階 Def -/
def genDefs : Defs :=
  [ { param := .int, ret := .int, body := .add (.var 0) (.lit 1) }
  , { param := .int, ret := .bool, body := .cmp .gt (.var 0) (.lit 0) }
  , { param := .prod (.fn .int .int) .int, ret := .int,
      body := .callv (.fst (.var 0)) (.snd (.var 0)) }
  -- 3 = id[T]（V3-2: 型パラメータ。ターゲット型はすべて loc-free なので型引数になれる）
  , { tparams := 1, param := .tvar 0, ret := .tvar 0, body := .var 0 }
  -- 4〜6（R0）: 自フレームで作った slice を opt / union に包んで返す Def と、それを imm 引数に取る Def。
  -- call 結果の値ラッパの中のコンテナが呼び手最内へ締まり、別の Def の imm 引数へ渡せる
  , { param := .int, ret := .opt (.slice false 1 .int),
      body := .ite (.cmp .gt (.var 0) (.lit 0)) (.some (.append (.mkslice false .int) (.var 0)))
        (.nil (.slice false 1 .int)) }
  , { param := .slice false 0 .int, ret := .int, body := .add (.lenE (.var 0)) (.lit 1) }
  , { param := .int, ret := .union (.slice false 1 .int) .int,
      body := .ite (.cmp .gt (.var 0) (.lit 0)) (.inl .int (.append (.mkslice false .int) (.var 0)))
        (.inr (.slice false 1 .int) (.var 0)) }
  -- 7（R2）: mut 引数で再帰する Def（callM = anchor つき呼び出し）
  , { param := .prod (.ref true 0 .int) .int, ret := .unit
      body := .ite (.cmp .gt (.snd (.var 0)) (.lit 0))
        (.letE (.assign (.fst (.var 0)) (.add (.deref (.fst (.var 0))) (.snd (.var 0))))
          (.callM 7 [] (.pair (.fst (.var 1)) (.arith .sub (.snd (.var 1)) (.lit 1)))))
        .triv }
  -- 8〜14（Gen 総追いつき段 A）: string / float / 宛先構築 / 境界コピー / 総称の slice / mut の slice・map の anchor
  -- 8: string 仮引数（eqs と region 1 の strlit・lenE）
  , { param := tString 0, ret := .int,
      body := .ite (.eqs (.var 0) (.strlit [104, 105] 1)) (.lit 1) (.lenE (.var 0)) }
  -- 9: f64
  , { param := .f64, ret := .f64, body := .farith .mul (.var 0) (.fconv .sqrt (.var 0)) }
  -- 10: 呼び手空間（region 0）に mut の宛先構築 → freeze して string で返す
  , { param := .int, ret := tString 0,
      body := .freeze (.append (.mksliceAt true .byte 0) (.tobyte (.var 0))) }
  -- 11: 自フレームで連結した string を境界コピーで呼び手空間へ
  , { param := tString 0, ret := tString 0,
      body := .copyTo 0 (tString 0) (.concat (.var 0) (.strlit [33] 1)) }
  -- 12: 総称の slice（tparams = 1）
  , { tparams := 1, param := .slice false 0 (.tvar 0), ret := .int, body := .lenE (.var 0) }
  -- 13: mut slice の anchor（callM）— append と setidx
  , { param := .prod (.slice true 0 .int) .int, ret := .unit,
      body := .letE (.append (.fst (.var 0)) (.snd (.var 0)))
        (.setidx (.fst (.var 1)) (.lit 0) (.snd (.var 1))) }
  -- 14: mut map の anchor（callM）— setm
  , { param := .prod (.map true 0 (.prod .int (.opt .int))) .int, ret := .unit,
      body := .letE (.setm (.fst (.var 0)) (.snd (.var 0)) (.snd (.var 0))) .triv }
  -- 15〜16（段 6 P3a — Def の本体の par の解禁）: 関数の中で scope を開き、仮引数を子へ渡す（join / 死んだ子を try）
  , { param := .int, ret := .union .int (.union .unit .int)
      body := .scope .int .int (.fst (.join (ktI .int) (.spawn (.var 0) (.var 1) (.pair (.add (.var 0) (.lit 1)) (.nil .int))))) }
  , { param := .int, ret := .union (.opt .int) (.union .unit .int)
      body := .scope (.opt .int) .int (.letE (.spawn (.var 0) (.var 1) (.unreach (ktI .int)))
        (.ifnil (.tryJ (ktI .int) (.var 0)) (.nil .int) (.some (.fst (.var 0))))) }
  -- 17（P3b-2 — Def の本体の newch）: 子が送り端で仮引数 + 1 を送り、親が受け端で受ける
  , { param := .int, ret := .union .int (.union .unit .int)
      body := .scope .int .int (.letE (.newch 2 1 .int) (.letE (.spawn (.var 1) (.pair (.fst (.var 0)) (.var 2))
        (.pair (.send (.fst (.var 0)) (.add (.snd (.var 0)) (.lit 1))) (.nil .int)))
        (.letE (.ifnil (.recv (.snd (.var 1))) (.lit 0) (.var 0)) (.letE (.join (ktI .unit) (.var 1)) (.var 1))))) } ]

/-- Γ にある ref true の (index, region, ペイロード型) -/
def mutRefsOf (Γ : Ctx) : List (Nat × Nat × Ty) :=
  (List.range Γ.length).filterMap fun i =>
    match Γ[i]? with
    | some (Ty.ref true r s) => some (i, r, s)
    | _ => none

/-- Γ にあるチャネルの (index, ペイロード型) -/
def chansOf (Γ : Ctx) : List (Nat × Ty) :=
  (List.range Γ.length).filterMap fun i =>
    match Γ[i]? with
    | some (Ty.chan _ s) => some (i, s)
    | _ => none

/-- Γ にある slice の (index, mut, region, 要素型) -/
def slicesOf (Γ : Ctx) : List (Nat × Bool × Nat × Ty) :=
  (List.range Γ.length).filterMap fun i =>
    match Γ[i]? with
    | some (Ty.slice m r s) => some (i, m, r, s)
    | _ => none

/-- Γ にある map の (index, mut, region, キー型, 値型) -/
def mapsOf (Γ : Ctx) : List (Nat × Bool × Nat × Ty × Ty) :=
  (List.range Γ.length).filterMap fun i =>
    match Γ[i]? with
    | some (Ty.map m r (.prod k (.opt v))) => some (i, m, r, k, v)
    | _ => none

/-- Γ にある string（imm byte slice）の (index, region) -/
def strsOf (Γ : Ctx) : List (Nat × Nat) :=
  (slicesOf Γ).filterMap fun (i, m, r, s) => if !m && s == .byte then some (i, r) else none

/-- region r ちょうどの string（setm のキー — 型が正確に一致する必要がある）。strlit は b ≤ r < d を呼び手が保証 -/
def genStrAt (Γ : Ctx) (r : Nat) : Rand Expr := do
  let vs := varsOf Γ (tString r)
  if vs.length > 0 && (← rnd 1) = 0 then return .var (← pickD vs)
  else return .strlit (← genBytes) r

/-- 任意の region の string。作れない（Γ に無く、最内に書けない）なら none -/
def genStrAny (Γ : Ctx) (b d : Nat) : Nat → Rand (Option Expr)
  | 0 => do
    let ss := strsOf Γ
    if !ss.isEmpty && (← rnd 1) = 0 then return some (.var (← pickD ss).1)
    else if decide (b + 1 ≤ d) then return some (.strlit (← genBytes) (← rndIn b (d - 1)))
    else if !ss.isEmpty then return some (.var (← pickD ss).1)
    else return none
  | fuel + 1 => do
    let ss := strsOf Γ
    let canW := decide (b + 1 ≤ d)
    if ss.isEmpty && !canW then return none
    let c ← rnd 3
    if !ss.isEmpty && (c = 0 || !canW) then return some (.var (← pickD ss).1)
    else if !ss.isEmpty && c = 1 then
      return some (.subslice (.var (← pickD ss).1) (.lit 0) (.lit (Int.ofNat (← rnd 2))))
    else if c = 2 then
      match ← genStrAny Γ b d fuel, ← genStrAny Γ b d fuel with
      | some x, some y => return some (.concat x y)
      | _, _ => return some (.strlit (← genBytes) (← rndIn b (d - 1)))
    else return some (.strlit (← genBytes) (← rndIn b (d - 1)))

/-- 小さい値（Γ の同型の変数か底の値 — 消費 op の部分項。再帰しない） -/
def genSmall (t : Ty) (Γ : Ctx) : Rand Expr := do
  let vs := varsOf Γ t
  if vs.length > 0 && (← rnd 1) = 0 then return .var (← pickD vs)
  else genBase t

/-- コンテナの腕の op -/
inductive COp where
  | len | index | setidx | append | subslice | concat | eqs | freeze | callG | callM13 | callStr
  | lenm | getm | setm | delm | keysm | freezem | callM14
  deriving Inhabited, BEq

/-- Γ の i 番の slice（mut m・region r・要素 s）を 1 回使う項と、その結果型 -/
def useSlice (Γ : Ctx) (b d i : Nat) (m : Bool) (r : Nat) (s : Ty) : Rand (Expr × Ty) := do
  let canW := decide (b + 1 ≤ d)
  let isStr := !m && s == .byte
  -- 要素が loc-free でない（keysm の string キーの列）なら値を作る op（setidx / append）と型引数（callG）を外す
  let lf := s.regionsBelow 0
  let sls := slicesOf Γ
  let op ← pickW
    [ (3, COp.len), (3, .index)
    , (if m && lf then 3 else 0, .setidx)
    , (if lf && ((m && decide (b ≤ r)) || (!m && canW)) then 3 else 0, .append)
    , (if m then 0 else 2, .subslice)
    , (if !m && canW then 2 else 0, .concat)
    , (if isStr then 2 else 0, .eqs)
    , (if m then 2 else 0, .freeze)
    , (if !m && canW && lf then 2 else 0, .callG)
    , (if m && s == .int && decide (b ≤ r) && decide (r + 1 ≤ d) then 2 else 0, .callM13)
    , (if isStr && canW then 2 else 0, .callStr) ]
  let xs := Expr.var i
  match op with
  | .len => return (.lenE xs, .int)
  | .index =>
    -- 注釈なしは mut か annFree の要素に限る（readAs）。それ以外は要素型の注釈つき
    let ot : Option Ty := if (m || s.annFree) && (← rnd 1) = 0 then none else some s
    return (.index xs (← genSmall .int Γ) ot, s)
  | .setidx => return (.setidx xs (← genSmall .int Γ) (← genSmall s Γ), .unit)
  | .append =>
    return (.append xs (← genSmall s Γ), if m then .slice true r s else .slice false (d - 1) s)
  | .subslice => return (.subslice xs (.lit 0) (.lit (Int.ofNat (← rnd 1))), .slice false r s)
  | .concat =>
    let others := (sls.filter fun (_, m', _, s') => !m' && s' == s).map (·.1)
    return (.concat xs (.var (← pickD (i :: others))), .slice false (d - 1) s)
  | .eqs =>
    let other ← (do match ← genStrAny Γ b d 1 with
      | some y => return y
      | none => return xs)
    return (.eqs xs other, .bool)
  | .freeze => return (.freeze xs, .slice false r s)
  | .callG => return (.call 12 [s] xs, .int)
  | .callM13 => return (.callM 13 [] (.pair xs (← genSmall .int Γ)), .unit)
  | _ => -- callStr
    if (← rnd 1) = 0 then return (.call 8 [] xs, .int) else return (.lenE (.call 11 [] xs), .int)

/-- Γ の i 番の map（mut m・region r・キー k・値 v）を 1 回使う項と、その結果型 -/
def useMap (Γ : Ctx) (b d i : Nat) (m : Bool) (r : Nat) (k v : Ty) : Rand (Expr × Ty) := do
  let canW := decide (b + 1 ≤ d)
  -- 探索キー（getm / delm — region は問わない）
  let key ← (do
    if k == .int then return some (← genSmall .int Γ)
    else genStrAny Γ b d 1)
  -- 格納キー（setm — 型が正確）
  let keyAt ← (do
    match k with
    | .slice false rk .byte =>
      if decide (b ≤ rk) && decide (rk + 1 ≤ d) then return some (← genStrAt Γ rk)
      else
        let vs := varsOf Γ k
        if vs.isEmpty then return none else return some (.var (← pickD vs))
    | _ => return some (← genSmall .int Γ))
  let op ← pickW
    [ (2, COp.lenm)
    , (if key.isSome then 3 else 0, .getm)
    , (if m && keyAt.isSome then 4 else 0, .setm)
    , (if m && key.isSome then 3 else 0, .delm)
    , (if canW then 2 else 0, .keysm)
    , (if m then 2 else 0, .freezem)
    , (if m && k == .int && v == .int && decide (b ≤ r) && decide (r + 1 ≤ d) then 2 else 0, .callM14) ]
  let mx := Expr.var i
  match op with
  | .getm => return (.getm v mx (key.getD (.lit 0)), .opt v)
  | .setm => return (.setm mx (keyAt.getD (.lit 0)) (← genSmall v Γ), .map true r (.prod k (.opt v)))
  | .delm => return (.delm v mx (key.getD (.lit 0)), .unit)
  | .keysm => return (.keysm mx, .slice false (d - 1) k)
  | .freezem => return (.freeze mx, .map false r (.prod k (.opt v)))
  | .callM14 => return (.callM 14 [] (.pair mx (← genSmall .int Γ)), .unit)
  | _ => return (.lenm mx, .int)

/-- Γ の i 番の mut ref（region r・ペイロード s）を 1 回使う項と、その結果型 -/
def useRef (Γ : Ctx) (b d i r : Nat) (s : Ty) : Rand (Expr × Ty) := do
  match ← rnd 3 with
  | 0 => return (.assign (.var i) (← genSmall s Γ), .unit)
  | 1 => return (.freeze (.var i), .ref false r s)  -- s は loc-free なので mutFree
  | 2 =>
    -- R2: mut int ref を anchor にして再帰する Def 7 へ（b ≤ anchor ≤ 呼び手最内）
    if s == .int && decide (b ≤ r) && decide (r + 1 ≤ d) then
      return (.callM 7 [] (.pair (.var i) (← genSmall .int Γ)), .unit)
    else return (.deref (.var i), s)
  | _ => return (.deref (.var i), s)

/-- Γ の i 番（slice / map / mut ref）を 1 回使う。使えない型なら none -/
def useAt (Γ : Ctx) (b d i : Nat) : Rand (Option (Expr × Ty)) := do
  match Γ[i]? with
  | some (Ty.slice m r s) => return some (← useSlice Γ b d i m r s)
  | some (Ty.map m r (.prod k (.opt v))) => return some (← useMap Γ b d i m r k v)
  | some (Ty.ref true r s) => return some (← useRef Γ b d i r s)
  | _ => return none

/-- 型指向の腕 -/
inductive Arm where
  | base | letE | ite | case | ifnil | block | alloc | mutop | allocDeref | whileE | chan | pair
  | op | fn | callM | label | par | unreach | mkc | usec | task
  deriving Inhabited, BEq

/-- 型 t の well-typed な項を生成する。f = 0 / Ξ = Ψ = [] 前提（sober-check と同じ土俵）。
b は共有境界（par / parch の腕では d に上がる）、d は現在の深さ、Γ は文脈（ref / chan / slice / map を
含みうる）。ターゲット t は loc-free に保つ。最内 region へ書く形（alloc / mkslice / append imm / concat …）は
b ≤ d - 1 が要るので D ≥ b + 1 まで block を開いてから置く -/
def genTyped (t : Ty) (Γ : Ctx) (b d : Nat) : Nat → Rand Expr
  | 0 => do
    -- fuel 切れ: 変数が使えれば半々で使う
    let vs := varsOf Γ t
    if vs.length > 0 && (← rnd 1) = 0 then return .var (← pickD vs)
    else genBase t
  | fuel + 1 => do
    let canW := decide (b + 1 ≤ d)
    let muts := mutRefsOf Γ
    let sls := slicesOf Γ
    let mps := mapsOf Γ
    let scalar := match t with
      | .int | .bool | .byte | .f64 => true
      | _ => false
    let arm ← pickW
      [ (2, Arm.base), (5, .letE), (4, .ite), (3, .case), (3, .ifnil), (3, .block)
      , (if canW then 4 else 0, .alloc)
      , (if muts.isEmpty then 0 else 14, .mutop)
      , (if canW && muts.isEmpty then 1 else 0, .allocDeref)
      , (3, .whileE), (3, .chan), (4, .pair)
      , (if scalar then 7 else 0, .op)
      , (4, .fn)
      , (if canW && t == .int then 2 else 0, .callM)
      , (3, .label)
      , (if Γ.all Ty.mutFree then 2 else 0, .par)
      , (1, .unreach)
      , (if canW then 6 else 0, .mkc)
      , (if sls.isEmpty && mps.isEmpty then 0 else 18, .usec)
      , (if t.regionsBelow 0 && t.chanFree && decide (b < d) then 3 else 0, .task) ]
    match arm with
    | .base => genTyped t Γ b d 0
    | .letE => do
      let s ← genTy 1
      let e ← genTyped s Γ b d fuel
      return .letE e (← genTyped t (s :: Γ) b d fuel)
    | .ite => do
      let c ← genTyped .bool Γ b d fuel
      return .ite c (← genTyped t Γ b d fuel) (← genTyped t Γ b d fuel)
    | .case => do -- union の消去
      let l ← genTy 1
      let r ← genTy 1
      let e ← genTyped (.union l r) Γ b d fuel
      return .case e (← genTyped t (l :: Γ) b d fuel) (← genTyped t (r :: Γ) b d fuel)
    | .ifnil => do -- opt の消去
      let s ← genTy 1
      let e ← genTyped (.opt s) Γ b d fuel
      return .ifnil e (← genTyped t Γ b d fuel) (← genTyped t (s :: Γ) b d fuel)
    | .block => -- t は loc-free なので escape 検査に常に通る
      return .block (← genTyped t Γ b (d + 1) fuel)
    | .alloc => do -- let-alloc（ref が Γ に入る。mut なら半々で直後に 1 回使う）
      let s ← genTy 1
      let m := (← rnd 2) ≠ 0
      let e ← genTyped s Γ b d fuel
      let Γ' := .ref m (d - 1) s :: Γ
      if m && (← rnd 1) = 0 then
        match ← useAt Γ' b d 0 with
        | some (u, ty) => return .letE (.alloc m e) (.letE u (← genTyped t (ty :: Γ') b d fuel))
        | none => return .letE (.alloc m e) (← genTyped t Γ' b d fuel)
      else return .letE (.alloc m e) (← genTyped t Γ' b d fuel)
    | .allocDeref =>
      return .deref (.alloc true (← genTyped t Γ b d fuel))
    | .mutop => do -- assign / freeze / deref / callM（Γ の mut ref を使う — useRef）
      let (i, _, _) ← pickD muts
      match ← useAt Γ b d i with
      | some (e, ty) => return .letE e (← genTyped t (ty :: Γ) b d fuel)
      | none => genTyped t Γ b d fuel
    | .whileE => do -- unit を letE で流す
      let c ← genTyped .bool Γ b d fuel
      let s ← genTy 1
      let body ← genTyped s Γ b d fuel
      return .letE (.whileE c body) (← genTyped t (.unit :: Γ) b d fuel)
    | .chan => do -- newchan → send / recv（rc = 0: f = 0 なので床ぎりぎり。ペイロードは loc-free）
      let s ← genTy 1
      let payload ← genTyped s (.chan 0 s :: Γ) b d fuel
      let use ← rnd 1
      let inner : Expr :=
        if use = 0 then .send (.var 0) payload
        else .letE (.recv (.var 0)) .triv  -- 受信値を束縛して捨てる（inner は常に unit）
      return .letE (.newchan 0 s) (.letE inner (← genTyped t (.unit :: .chan 0 s :: Γ) b d fuel))
    | .pair => do -- pair の導入と射影
      match t with
      | .prod l r => return .pair (← genTyped l Γ b d fuel) (← genTyped r Γ b d fuel)
      | _ => do -- fst/snd で t を取り出す
        let other ← genTy 1
        match ← rnd 2 with
        | 0 => return .fst (← genTyped (.prod t other) Γ b d fuel)
        | 1 => return .snd (← genTyped (.prod other t) Γ b d fuel)
        | _ => return .ann (← genTyped t Γ b d fuel) t  -- 型注釈（V3-5）: 自分の型への注釈
    | .op => do -- スカラーの演算（int / bool / byte / f64）
      match t with
      | .int =>
        match ← rnd 5 with
        | 0 => return .add (← genTyped .int Γ b d fuel) (← genTyped .int Γ b d fuel)
        | 1 => return .toint (← genTyped .byte Γ b d fuel)
        | 2 => return .fconv (← pickD [FConvOp.toInt, .bits]) (← genTyped .f64 Γ b d fuel)
        | _ =>
          let op ← pickD [ArithOp.sub, .mul, .div, .mod, .land, .lor, .lxor, .shl, .shr]
          return .arith op (← genTyped .int Γ b d fuel) (← genTyped .int Γ b d fuel)
      | .bool =>
        match ← rnd 5 with
        | 0 => return .lt (← genTyped .int Γ b d fuel) (← genTyped .int Γ b d fuel)
        | 1 =>
          let op ← pickD [FCmpOp.eq, .ne, .lt, .le, .gt, .ge]
          return .fcmp op (← genTyped .f64 Γ b d fuel) (← genTyped .f64 Γ b d fuel)
        | 2 =>
          match ← genStrAny Γ b d 1, ← genStrAny Γ b d 1 with
          | some x, some y => return .eqs x y
          | _, _ => return .lt (← genTyped .int Γ b d fuel) (← genTyped .int Γ b d fuel)
        | _ =>
          let op ← pickD [CmpOp.eq, .ne, .le, .gt, .ge]
          return .cmp op (← genTyped .int Γ b d fuel) (← genTyped .int Γ b d fuel)
      | .byte =>
        match ← rnd 2 with
        | 0 =>
          match ← genStrAny Γ b d 1 with
          | some s => return .index s (← genTyped .int Γ b d fuel)
          | none => return .tobyte (← genTyped .int Γ b d fuel)
        | _ => return .tobyte (← genTyped .int Γ b d fuel)
      | _ => -- f64
        match ← rnd 3 with
        | 0 => return .fconv (← pickD [FConvOp.neg, .sqrt]) (← genTyped .f64 Γ b d fuel)
        | 1 => return .fconv (← pickD [FConvOp.ofInt, .fromBits]) (← genTyped .int Γ b d fuel)
        | _ =>
          let op ← pickD [FArithOp.add, .sub, .mul, .div]
          return .farith op (← genTyped .f64 Γ b d fuel) (← genTyped .f64 Γ b d fuel)
    | .fn => do -- 関数値（genDefs を参照）: callv / 関数値を束縛して callv / 高階 Def に渡す
      -- callv / call は深さ D = d' + 1 で b ≤ d' が要る（call と同じ）
      if !canW then return .block (← genTyped t Γ b (d + 1) fuel)
      else if (← rnd 1) = 0 then
        -- ジェネリック Def を任意のターゲット型で呼ぶ（直接 / 型適用つき関数値）
        let arg ← genTyped t Γ b d fuel
        if (← rnd 1) = 0 then return .call 3 [t] arg
        else return .callv (.fnref 3 [t]) arg
      else
        match t with
        | .int => do
          match ← rnd 7 with
          | 0 => return .callv (.fnref 0 []) (← genTyped .int Γ b d fuel)
          | 1 => return .letE (.fnref 0 []) (.callv (.var 0) (← genTyped .int (.fn .int .int :: Γ) b d fuel))
          | 2 => return .call 2 [] (.pair (.fnref 0 []) (← genTyped .int Γ b d fuel))
          -- R0: opt / union の中の slice を別の Def へ転送（中身は呼び手最内 d - 1 に締まる）
          | 3 => return .ifnil (.call 4 [] (← genTyped .int Γ b d fuel)) (← genTyped .int Γ b d fuel) (.call 5 [] (.var 0))
          | 4 => return .case (.call 6 [] (← genTyped .int Γ b d fuel)) (.call 5 [] (.var 0)) (.var 0)
          -- 段 6 P3a: 本体で scope を開く Def（15 = join・16 = 死んだ子を try — scope の値は union）
          | 5 =>
            match ← rnd 2 with
            | 0 => return .case (.call 15 [] (← genTyped .int Γ b d fuel)) (.var 0) (.lit 0)
            | 1 => return .case (.call 17 [] (← genTyped .int Γ b d fuel)) (.var 0) (.lit 3)
            | _ =>
              return .case (.call 16 [] (← genTyped .int Γ b d fuel)) (.ifnil (.var 0) (.lit 1) (.var 0)) (.lit 2)
          -- string の Def（8 / 10 / 11）
          | _ =>
            match ← genStrAny Γ b d 1 with
            | some s =>
              match ← rnd 2 with
              | 0 => return .call 8 [] s
              | 1 => return .lenE (.call 11 [] s)
              | _ => return .call 8 [] (.call 10 [] (← genTyped .int Γ b d fuel))
            | none => return .lenE (.call 10 [] (← genTyped .int Γ b d fuel))
        | .bool => return .callv (.fnref 1 []) (← genTyped .int Γ b d fuel)
        | .f64 => return .call 9 [] (← genTyped .f64 Γ b d fuel)
        | .byte => return .index (.call 10 [] (← genTyped .int Γ b d fuel)) (.lit 0)
        | _ => genTyped t Γ b d fuel
    | .callM => do
      -- R2: mut ローカルを作り、1 段深い block から anchor つきで再帰する Def に渡す（anchor < 呼び手最内）
      let arg ← genTyped .int Γ b d fuel
      return .letE (.alloc true arg) (.letE (.block (.callM 7 [] (.pair (.var 0) (.lit 3)))) (.deref (.var 1)))
    | .label => do -- label / jump（V4）: 途中脱出・block 越えの脱出・入れ子の外側への脱出
      let c ← genTyped .bool Γ b d fuel
      match ← rnd 2 with
      | 0 => -- label t (if c { jump 0 v } else e)
        let v ← genTyped t Γ b d fuel
        return .label t (.ite c (.jump 0 t v) (← genTyped t Γ b d fuel))
      | 1 => -- label t { if c { jump 0 v } else e }（region を開いたまま脱出 — 巻き戻しで pop）。条件は block の中の深さで作り直す
        -- （深さに依る項 — task の結果の region・子の自前の region — は外の深さで作ると block の中で型が付かない。P3b-4 で露見）
        let c1 ← genTyped .bool Γ b (d + 1) fuel
        let v ← genTyped t Γ b (d + 1) fuel
        let _ := c
        return .label t (.block (.ite c1 (.jump 0 t v) (← genTyped t Γ b (d + 1) fuel)))
      | _ => -- label t (x := label s (if c { jump 1 v } else w); e)（内側を飛び越えて外側へ）
        let s ← genTy 1
        let v ← genTyped t Γ b d fuel
        let w ← genTyped s Γ b d fuel
        return .label t (.letE (.label s (.ite c (.jump 1 s v) w)) (← genTyped t (s :: Γ) b d fuel))
    | .par => do -- par / parch（Γ が全部 mutFree のときだけ。t = unit を letE で流す）
      let s ← genTy 1
      let e ← (do
        if (← rnd 1) = 0 then
          return Expr.par (← genTyped .int Γ d d fuel) (← genTyped .int Γ d d fuel)
        else
          let e1 := Expr.send (.var 0) (← genBase s)
          let e2 := Expr.recv (.var 0)
          return Expr.parch s e1 e2)
      return .letE e (← genTyped t (.unit :: Γ) b d fuel)
    | .unreach => do -- 到達しない（A5）: 覆っていない腕の形・まれに裸
      if (← rnd 2) = 0 then return .unreach t
      else
        let c ← genTyped .bool Γ b d fuel
        return .ite c (← genTyped t Γ b d fuel) (.unreach t)
    | .mkc => do -- コンテナを作って Γ に束縛（slice / map / string — 最内か浅い region r ∈ [b, d-1]）。半々で直後に 1 回使う
      let m := (← rnd 1) = 0
      let mkUse := fun (e : Expr) (ty : Ty) => (do
        let Γ' := ty :: Γ
        if (← rnd 1) = 0 then
          match ← useAt Γ' b d 0 with
          | some (u, ty') => return Expr.letE e (.letE u (← genTyped t (ty' :: Γ') b d fuel))
          | none => return Expr.letE e (← genTyped t Γ' b d fuel)
        else return Expr.letE e (← genTyped t Γ' b d fuel) : Rand Expr)
      match ← rnd 4 with
      | 0 => -- mkslice（半々で 1 要素 append してから）
        let s ← genTy 1
        let e0 := Expr.mkslice m s
        let e ← (do if (← rnd 1) = 0 then return Expr.append e0 (← genTyped s Γ b d fuel) else return e0)
        mkUse e (.slice m (d - 1) s)
      | 1 => -- mksliceAt（宛先構築 M3b）
        let s ← genTy 1
        let r ← rndIn b (d - 1)
        mkUse (.mksliceAt m s r) (.slice m r s)
      | 2 => -- mkmap / mkmapAt（キーは int か region rk ≤ r の string）
        let r ← (do if (← rnd 1) = 0 then return d - 1 else rndIn b (d - 1))
        let k ← (do if (← rnd 1) = 0 then return Ty.int else return tString (← rndIn b r))
        let v ← genTy 1
        let kv := Ty.prod k (.opt v)
        let e := if r + 1 = d && (← rnd 1) = 0 then Expr.mkmap m kv else .mkmapAt m kv r
        mkUse e (.map m r kv)
      | _ => -- strlit
        let r ← rndIn b (d - 1)
        mkUse (.strlit (← genBytes) r) (tString r)
    | .usec => do -- Γ のコンテナを使う。結果が t なら直接、opt なら半々で ifnil、それ以外は束縛して続き
      let ixs := (sls.map (·.1)) ++ (mps.map (·.1))
      match ← useAt Γ b d (← pickD ixs) with
      | some (e, ty) =>
        if ty == t then return e
        else
          match ty with
          | .opt v =>
            if (← rnd 1) = 0 then return .ifnil e (← genTyped t Γ b d fuel) (← genTyped t (v :: Γ) b d fuel)
            else return .letE e (← genTyped t (ty :: Γ) b d fuel)
          | _ => return .letE e (← genTyped t (ty :: Γ) b d fuel)
      | none => genTyped t Γ b d fuel
    | .task => do -- 段 6 P1: scope の中で spawn → join / try・端点のチャネル（newch → tx を spawn に渡して send → join → recv）
      -- scope の本体は深さ d + 1・Γ の先頭に札 own scope d int・Λ = []。spawn の本体は子の世界（b = d + 1・深さ d + 2・Γ = [引数の型]）。
      -- t は loc-free（regionsBelow 0 && chanFree — 腕の重みの条件）なので scope の脱出検査と spawn の結果の条件に常に通る。
      -- P3b-4 1b': scope の err の型は int・子の結果は組 (t, err?)（error を返さない子は pair v nil・Join はその fst）・腕の重みの条件に b < d
      let dS := d + 1
      let Γ1 := Ty.own .scope d .int :: Γ
      -- scope の型は union t (union unit int)（inr (inl) = 子の死・inr (inr) = 未回収の失敗）: case で t へ戻す（inr の腕は unreach — 乱数を消費しない）
      let sc : Expr → Expr := fun e => .case (.scope t .int e) (.var 0) (.unreach t)
      let ok : Expr → Expr := fun v => .pair v (.nil .int)
      match ← rnd (if t = .int then 5 else 2) with
      | 0 => -- join
        let s ← genTy 1
        let a ← genTyped s Γ1 b dS fuel
        let body ← genTyped t [s] dS (dS + 1) fuel
        return sc (.letE (.spawn (.var 0) a (ok body)) (.fst (.join (ktI t) (.var 0))))
      | 5 => -- 未回収の失敗（P3b-4 1b'）: 子は err を返し、親は回収しない — scope の値は inr (inr e)。回収する形（Join の snd を見る）も乱択
        let s ← genTy 1
        let a ← genTyped s Γ1 b dS fuel
        let body ← genTyped t [s] dS (dS + 1) fuel
        let ek ← rnd 9
        let col ← rnd 1
        let k : Expr := if col = 0 then .lit 0 else .ifnil (.snd (.join (ktI t) (.var 0))) (.lit 1) (.var 0)
        let alt ← genTyped t (Ty.union .unit .int :: Γ) b d fuel
        return .case (.scope t .int (.letE (.spawn (.var 0) a (.pair body (.some (.lit (ek : Int))))) k)) (.var 0) alt
      | 4 => -- region を持つペイロード（P3b-4b）: 子は自前の region に string を作って送り、親は受けて自分の最内へ写す
        let bs ← genBytes
        return sc (.letE (.newch d 1 (.slice false 0 .byte))
          (.letE (.spawn (.var 1) (.fst (.var 0)) (ok (.send (.var 0) (.strlit bs dS))))
            (.letE (.recv (.snd (.var 1))) (.letE (.join (ktI .unit) (.var 1)) (.ifnil (.var 1) (.lit 0) (.lenE (.var 0)))))))
      | 3 => -- region を持つ結果（P3b-4）: 子は自前の region に string を作って返し、join が scope の region へ写す
        let s ← genTy 1
        let a ← genTyped s Γ1 b dS fuel
        let bs ← genBytes
        return sc (.letE (.spawn (.var 0) a (ok (.strlit bs dS))) (.lenE (.fst (.join (ktI (.slice false d .byte)) (.var 0)))))
      | 1 => -- try（死んだら nil — nil の腕は続きの値）
        let s ← genTy 1
        let a ← genTyped s Γ1 b dS fuel
        let body ← genTyped t [s] dS (dS + 1) fuel
        let dead ← genTyped t (Ty.own .task d (ktI t) :: Γ1) b dS fuel
        return sc (.letE (.spawn (.var 0) a (ok body)) (.ifnil (.tryJ (ktI t) (.var 0)) dead (.fst (.var 0))))
      | _ => -- 端点のチャネル（家の region = d = scope の外側の最内）。受けは T?（P3b-4 ③ — 子が送った後に close すると 2 つ目の受けは nil）
        let s ← genTy 1
        let cap ← rndIn 1 2
        let pt := Ty.prod (.own .tx d s) (.own .rx d s)
        let payload ← genTyped s [Ty.own .tx dS s] dS (dS + 1) fuel
        let cl ← rnd 1
        let Γ5 := Ty.opt s :: ktI .unit :: Ty.own .task d (ktI .unit) :: pt :: Γ1
        let k ← genTyped t Γ5 b dS fuel
        let body : Expr := if cl = 0 then .send (.var 0) payload else .letE (.send (.var 0) payload) (.close (.var 1))
        let k' : Expr := if cl = 0 then k else .letE (.recv (.snd (.var 3))) (Expr.shift 0 k)
        return sc (.letE (.newch d cap s)
          (.letE (.spawn (.var 1) (.fst (.var 0)) (ok body))
            (.letE (.join (ktI .unit) (.var 0)) (.letE (.recv (.snd (.var 2))) k'))))

-- ────────────────────────────────────────────────────────────────
-- chaos 生成器（reject 側。語彙全体・注釈も index もでたらめ）
-- ────────────────────────────────────────────────────────────────

/-- ref / chan / slice / map / tvar 込みのランダム型 -/
def genChaosTy : Nat → Rand Ty
  | 0 => genScalarTy
  | fuel + 1 => do
    match ← rnd 13 with
    | 0 => return .int
    | 1 => return .bool
    | 2 => return .unit
    | 3 => return .opt (← genChaosTy fuel)
    | 4 => return .union (← genChaosTy fuel) (← genChaosTy fuel)
    | 5 => return .ref ((← rnd 1) = 0) (← rnd 2) (← genChaosTy fuel)
    | 6 => return .chan (← rnd 2) (← genChaosTy fuel)
    | 7 => return .prod (← genChaosTy fuel) (← genChaosTy fuel)
    | 8 => return .fn (← genChaosTy fuel) (← genChaosTy fuel)
    | 9 => return .byte
    | 10 => return .f64
    | 11 => return .slice ((← rnd 1) = 0) (← rnd 2) (← genChaosTy fuel)
    | 12 => return .map ((← rnd 1) = 0) (← rnd 2) (.prod (← genChaosTy 0) (.opt (← genChaosTy fuel)))
    | _ => return .tvar (← rnd 1)

def genChaos : Nat → Rand Expr
  | 0 => do
    match ← rnd 7 with
    | 0 => return .lit (Int.ofNat (← rnd 9))
    | 1 => return .tt
    | 2 => return .triv
    | 3 => return .var (← rnd 3)
    | 4 => return .ff
    | 5 => genFlit
    | 6 => return .strlit (← genBytes) (← rnd 2)
    | _ => return .nil (← genChaosTy 1)
  | fuel + 1 => do
    match ← rnd 63 with
    | 0 => genChaos 0
    | 1 => return .letE (← genChaos fuel) (← genChaos fuel)
    | 2 => return .add (← genChaos fuel) (← genChaos fuel)
    | 3 => return .lt (← genChaos fuel) (← genChaos fuel)
    | 4 => return .ite (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 5 => return .some (← genChaos fuel)
    | 6 => return .ifnil (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 7 => return .inl (← genChaosTy fuel) (← genChaos fuel)
    | 8 => return .inr (← genChaosTy fuel) (← genChaos fuel)
    | 9 => return .case (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 10 => return .block (← genChaos fuel)
    | 11 => return .alloc ((← rnd 1) = 0) (← genChaos fuel)
    | 12 => return .deref (← genChaos fuel)
    | 13 => return .assign (← genChaos fuel) (← genChaos fuel)
    | 14 => return .whileE (← genChaos fuel) (← genChaos fuel)
    | 15 => return .freeze (← genChaos fuel)
    | 16 => return .par (← genChaos fuel) (← genChaos fuel)
    | 17 => return .parch (← genChaosTy fuel) (← genChaos fuel) (← genChaos fuel)
    | 18 => return .newchan (← rnd 2) (← genChaosTy fuel)
    | 19 => return .send (← genChaos fuel) (← genChaos fuel)
    | 20 => return .recv (← genChaos fuel)
    | 21 => do
      let op ← pickD [ArithOp.sub, .mul, .div, .mod, .land, .lor, .lxor, .shl, .shr]
      return .arith op (← genChaos fuel) (← genChaos fuel)
    | 22 => return .pair (← genChaos fuel) (← genChaos fuel)
    | 23 => return .fst (← genChaos fuel)
    | 24 => return .snd (← genChaos fuel)
    | 25 => do
      let ts ← (do if (← rnd 1) = 0 then return [] else return [← genChaosTy 1])
      return .call (← rnd 14) ts (← genChaos fuel)
    | 26 => do
      let ts ← (do if (← rnd 1) = 0 then return [] else return [← genChaosTy 1])
      return .fnref (← rnd 14) ts
    | 27 => return .callv (← genChaos fuel) (← genChaos fuel)
    | 28 => return .ann (← genChaos fuel) (← genChaosTy fuel)
    | 29 => return .label (← genChaosTy fuel) (← genChaos fuel)
    | 30 => return .jump (← rnd 2) (← genChaosTy fuel) (← genChaos fuel)
    | 31 => return .callM (← rnd 14) [] (← genChaos fuel)
    | 32 => return .blockR (← genChaosTy fuel) (← genChaos fuel)
    | 33 => return .copyTo (← rnd 2) (← genChaosTy fuel) (← genChaos fuel)
    | 34 => return .unreach (← genChaosTy fuel)
    | 35 => return .mkslice ((← rnd 1) = 0) (← genChaosTy fuel)
    | 36 => return .mksliceAt ((← rnd 1) = 0) (← genChaosTy fuel) (← rnd 2)
    | 37 => return .mkmapAt ((← rnd 1) = 0) (← genChaosTy fuel) (← rnd 2)
    | 38 => return .mkmap ((← rnd 1) = 0) (← genChaosTy fuel)
    | 39 => do
      let ot ← (do if (← rnd 1) = 0 then return none else return some (← genChaosTy 1))
      return .index (← genChaos fuel) (← genChaos fuel) ot
    | 40 => return .lenE (← genChaos fuel)
    | 41 => return .tobyte (← genChaos fuel)
    | 42 => return .toint (← genChaos fuel)
    | 43 => do
      let op ← pickD [FArithOp.add, .sub, .mul, .div]
      return .farith op (← genChaos fuel) (← genChaos fuel)
    | 44 => do
      let op ← pickD [FCmpOp.eq, .ne, .lt, .le, .gt, .ge]
      return .fcmp op (← genChaos fuel) (← genChaos fuel)
    | 45 => do
      let op ← pickD [FConvOp.neg, .sqrt, .ofInt, .toInt, .bits, .fromBits]
      return .fconv op (← genChaos fuel)
    | 46 => return .append (← genChaos fuel) (← genChaos fuel)
    | 47 => return .setidx (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 48 => return .subslice (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 49 => return .eqs (← genChaos fuel) (← genChaos fuel)
    | 50 => return .concat (← genChaos fuel) (← genChaos fuel)
    | 51 => return .getm (← genChaosTy fuel) (← genChaos fuel) (← genChaos fuel)
    | 52 => return .setm (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 53 => return .delm (← genChaosTy fuel) (← genChaos fuel) (← genChaos fuel)
    | 54 => return .lenm (← genChaos fuel)
    | 55 => return .keysm (← genChaos fuel)
    | 56 => return .strlit (← genBytes) (← rnd 2)
    | 57 => return .scope (← genChaosTy fuel) (← genChaosTy fuel) (← genChaos fuel)
    | 58 => return .spawn (← genChaos fuel) (← genChaos fuel) (← genChaos fuel)
    | 59 => return .join (← genChaosTy fuel) (← genChaos fuel)
    | 60 => return .tryJ (← genChaosTy fuel) (← genChaos fuel)
    | 61 => return .newch (← rnd 2) (← rnd 2) (← genChaosTy fuel)
    | 62 => return .close (← genChaos fuel)
    | _ => do
      let op ← pickD [CmpOp.eq, .ne, .le, .gt, .ge]
      return .cmp op (← genChaos fuel) (← genChaos fuel)

-- ────────────────────────────────────────────────────────────────
-- ベクタ列の生成
-- ────────────────────────────────────────────────────────────────

-- ────────────────────────────────────────────────────────────────
-- 近傍変異（corevec v2 — near-miss の reject 側）
-- ────────────────────────────────────────────────────────────────

/-- 子の項（ソースに現れる構成子だけ — 実行時専用の項は子を持たない扱い） -/
def kids : Expr → List Expr
  | .letE e b => [e, b]
  | .add a b | .lt a b | .arith _ a b | .cmp _ a b | .farith _ a b | .fcmp _ a b => [a, b]
  | .ite c t e => [c, t, e]
  | .some e | .inl _ e | .inr _ e | .fst e | .snd e => [e]
  | .ifnil e n s => [e, n, s]
  | .case e l r => [e, l, r]
  | .pair a b => [a, b]
  | .call _ _ e | .callM _ _ e => [e]
  | .callv f e => [f, e]
  | .ann e _ | .block e | .blockR _ e | .copyTo _ _ e | .label _ e | .jump _ _ e => [e]
  | .alloc _ e | .deref e | .freeze e => [e]
  | .assign l e => [l, e]
  | .whileE c b => [c, b]
  | .index e i _ => [e, i]
  | .lenE e | .tobyte e | .toint e | .fconv _ e | .lenm e | .keysm e | .recv e | .close e => [e]
  | .append e v => [e, v]
  | .setidx e i v | .subslice e i v | .setm e i v => [e, i, v]
  | .eqs a b | .concat a b => [a, b]
  | .getm _ e k | .delm _ e k => [e, k]
  | .par a b | .parch _ a b | .send a b => [a, b]
  | .scope _ _ e | .join _ e | .tryJ _ e => [e]
  | .spawn sc a e => [sc, a, e]
  | _ => []

/-- 子を差し替える（kids と同じ順・同じ数。数が合わなければ元のまま） -/
def setKids (x : Expr) (cs : List Expr) : Expr :=
  match x, cs with
  | .letE _ _, [e, b] => .letE e b
  | .add _ _, [a, b] => .add a b
  | .lt _ _, [a, b] => .lt a b
  | .arith op _ _, [a, b] => .arith op a b
  | .cmp op _ _, [a, b] => .cmp op a b
  | .farith op _ _, [a, b] => .farith op a b
  | .fcmp op _ _, [a, b] => .fcmp op a b
  | .ite _ _ _, [c, t, e] => .ite c t e
  | .some _, [e] => .some e
  | .inl r _, [e] => .inl r e
  | .inr l _, [e] => .inr l e
  | .fst _, [e] => .fst e
  | .snd _, [e] => .snd e
  | .ifnil _ _ _, [e, n, s] => .ifnil e n s
  | .case _ _ _, [e, l, r] => .case e l r
  | .pair _ _, [a, b] => .pair a b
  | .call fn ts _, [e] => .call fn ts e
  | .callM fn ts _, [e] => .callM fn ts e
  | .callv _ _, [f, e] => .callv f e
  | .ann _ t, [e] => .ann e t
  | .block _, [e] => .block e
  | .blockR t _, [e] => .blockR t e
  | .copyTo k t _, [e] => .copyTo k t e
  | .label t _, [e] => .label t e
  | .jump n t _, [e] => .jump n t e
  | .alloc m _, [e] => .alloc m e
  | .deref _, [e] => .deref e
  | .freeze _, [e] => .freeze e
  | .assign _ _, [l, e] => .assign l e
  | .whileE _ _, [c, b] => .whileE c b
  | .index _ _ ot, [e, i] => .index e i ot
  | .lenE _, [e] => .lenE e
  | .tobyte _, [e] => .tobyte e
  | .toint _, [e] => .toint e
  | .fconv op _, [e] => .fconv op e
  | .lenm _, [e] => .lenm e
  | .keysm _, [e] => .keysm e
  | .recv _, [e] => .recv e
  | .close _, [e] => .close e
  | .append _ _, [e, v] => .append e v
  | .setidx _ _ _, [e, i, v] => .setidx e i v
  | .subslice _ _ _, [e, i, v] => .subslice e i v
  | .setm _ _ _, [e, i, v] => .setm e i v
  | .eqs _ _, [a, b] => .eqs a b
  | .concat _ _, [a, b] => .concat a b
  | .getm t _ _, [e, k] => .getm t e k
  | .delm t _ _, [e, k] => .delm t e k
  | .par _ _, [a, b] => .par a b
  | .parch t _ _, [a, b] => .parch t a b
  | .send _ _, [a, b] => .send a b
  | .scope t ε _, [e] => .scope t ε e
  | .join t _, [e] => .join t e
  | .tryJ t _, [e] => .tryJ t e
  | .spawn _ _ _, [sc, a, e] => .spawn sc a e
  | x, _ => x

/-- 前順の節の列（fuel = 深さの上限） -/
def nodesF : Nat → Expr → List Expr
  | 0, e => [e]
  | n + 1, e => e :: (kids e).flatMap (nodesF n)

/-- 前順で k 番目の節を newE に差し替える（k < 0 = 差し替え済み）。nodesF と同じ fuel で数える -/
def replF (newE : Expr) : Nat → Int → Expr → Expr × Int
  | 0, k, e => if k = 0 then (newE, -1) else (e, k - 1)
  | n + 1, k, e =>
    if k < 0 then (e, k)
    else if k = 0 then (newE, -1)
    else
      let (cs, k') := (kids e).foldl (fun (acc : List Expr × Int) c =>
        let (c', k'') := replF newE n acc.2 c
        (acc.1 ++ [c'], k'')) ([], k - 1)
      (setKids e cs, k')

/-- 変異の種別: その節に当てられるもの（1 か所だけ・1 規則だけ破る狙い） -/
def mutKinds : Expr → List String
  | .alloc _ _ | .mkslice _ _ => ["flag"]
  | .mksliceAt _ _ _ => ["flag", "region"]
  | .mkmap _ _ => ["flag", "key"]
  | .mkmapAt _ _ _ => ["flag", "region", "key"]
  | .strlit _ _ | .newchan _ _ | .newch _ _ _ => ["region"]
  | .scope _ _ _ | .tryJ _ _ | .join _ _ => ["annty"]
  | .copyTo _ _ _ => ["region", "annty"]
  | .var _ => ["var"]
  | .ann _ _ | .nil _ | .inl _ _ | .inr _ _ | .label _ _ | .unreach _ | .getm _ _ _ | .delm _ _ _ => ["annty"]
  | .jump _ _ _ => ["jump", "annty"]
  | .call _ _ _ | .callM _ _ _ | .fnref _ _ => ["fn"]
  | .lit _ | .tt | .ff | .tobyte _ | .toint _ | .eqs _ _ | .add _ _ | .lenE _ | .lenm _
  | .arith _ _ _ | .farith _ _ _ => ["op"]
  | .index _ _ _ => ["idx"]
  | _ => []

/-- s と違う loc-free の型 -/
def otherTy (s : Ty) : Rand Ty := do
  let t ← genTy 1
  if t = s then return (if s = .int then .bool else .int) else return t

def bumpR (r : Nat) : Rand Nat := do
  if r = 0 || (← rnd 1) = 0 then return r + 1 else return r - 1

/-- 種別 kind の変異を 1 つ当てる -/
def applyMut (kind : String) (e : Expr) : Rand Expr := do
  match kind, e with
  | "flag", .alloc m x => return .alloc (!m) x
  | "flag", .mkslice m t => return .mkslice (!m) t
  | "flag", .mksliceAt m t r => return .mksliceAt (!m) t r
  | "flag", .mkmap m t => return .mkmap (!m) t
  | "flag", .mkmapAt m t r => return .mkmapAt (!m) t r
  | "region", .mksliceAt m t r => return .mksliceAt m t (← bumpR r)
  | "region", .mkmapAt m t r => return .mkmapAt m t (← bumpR r)
  | "region", .strlit bs r => return .strlit bs (← bumpR r)
  | "region", .newchan rc t => return .newchan (rc + 1) t
  | "region", .newch r cap t => if (← rnd 1) = 0 then return .newch (← bumpR r) cap t else return .newch r 0 t
  | "region", .copyTo k t x => return .copyTo (← bumpR k) t x
  | "key", .mkmap m (.prod _ v) => return .mkmap m (.prod (← pickD [Ty.bool, .f64, .opt .int]) v)
  | "key", .mkmapAt m (.prod _ v) r => return .mkmapAt m (.prod (← pickD [Ty.bool, .f64, .opt .int]) v) r
  | "var", .var i => return .var (← bumpR i)
  | "annty", .ann x t => return .ann x (← otherTy t)
  | "annty", .nil t => return .nil (← otherTy t)
  | "annty", .inl r x => return .inl (← otherTy r) x
  | "annty", .inr l x => return .inr (← otherTy l) x
  | "annty", .label t x => return .label (← otherTy t) x
  | "annty", .unreach t => return .unreach (← otherTy t)
  | "annty", .getm t x k => return .getm (← otherTy t) x k
  | "annty", .delm t x k => return .delm (← otherTy t) x k
  | "annty", .jump n t x => return .jump n (← otherTy t) x
  | "annty", .copyTo k t x => return .copyTo k (← otherTy t) x
  | "annty", .scope t ε x => return .scope (← otherTy t) ε x
  | "annty", .tryJ t x => return .tryJ (← otherTy t) x
  | "annty", .join t x => return .join (← otherTy t) x
  | "jump", .jump n t x => return .jump (← bumpR n) t x
  | "fn", .call fn ts x =>
    if (← rnd 1) = 0 then return .call (← rnd 14) ts x
    else return .call fn (if ts.isEmpty then [.int] else []) x
  | "fn", .callM fn ts x => return .callM (← rnd 14) ts x
  | "fn", .fnref fn ts =>
    if (← rnd 1) = 0 then return .fnref (← rnd 14) ts
    else return .fnref fn (if ts.isEmpty then [.int] else [])
  | "op", .lit _ => return (← pickD [Expr.flit 0, .tt, .tobyte (.lit 0)])
  | "op", .tt => return .lit 1
  | "op", .ff => return .lit 0
  | "op", .tobyte x => return .toint x
  | "op", .toint x => return .tobyte x
  | "op", .eqs a b => return .cmp .eq a b
  | "op", .add a b => return .farith .add a b
  | "op", .arith _ a b => return .farith .mul a b
  | "op", .farith _ a b => return .arith .mul a b
  | "op", .lenE x => return .lenm x
  | "op", .lenm x => return .lenE x
  | "idx", .index x i Option.none => return .index x i (some (← otherTy .int))
  | "idx", .index x i (Option.some _) => return .index x i none
  | _, x => return x

def mutFuel : Nat := 1000

/-- 型指向の項 e に近傍変異を 1 つ当てる。返す種別は `mut:<kind>` -/
def mutate (e : Expr) : Rand (Expr × String) := do
  let ns := nodesF mutFuel e
  -- 種別を先に一様に選び（lit の多さで op に偏らないように）、その種別を当てられる節から 1 つ
  let kinds := ["flag", "region", "key", "var", "annty", "jump", "fn", "op", "idx"].filter fun k =>
    ns.any fun n => (mutKinds n).contains k
  if kinds.isEmpty then return (e, "mut:none")
  let kind ← pickD kinds
  let cands := (List.range ns.length).filter fun j => (mutKinds ns[j]!).contains kind
  let j ← pickD cands
  let x' ← applyMut kind ns[j]!
  return ((replF x' mutFuel (Int.ofNat j) e).1, "mut:" ++ kind)

/-- 型指向の 1 本（半分は最外の block の中から — 深さ 1 で始めると
最内 region へ書く腕〔alloc / コンテナ / 関数呼び出し〕が最初から使える） -/
def genTypedVec (i : Nat) : Rand Expr := do
  let t ← genTy 2
  if i % 2 = 1 then return .block (← genTyped t [] 0 1 4)
  else genTyped t [] 0 0 4

/-- ベクタ 1 本と出自: 10 本に 7 本は型指向・2 本は近傍変異・1 本は chaos -/
def genVector (i : Nat) : Rand (Expr × String) := do
  match i % 10 with
  | 7 | 8 => do
    -- 変異を当てる節が無い型指向（triv だけ等）は引き直す（1 回）
    let (e, g) ← mutate (← genTypedVec i)
    if g = "mut:none" then mutate (← genTypedVec (i + 1)) else return (e, g)
  | 9 => return (← genChaos 4, "chaos")
  | _ => return (← genTypedVec i, "typed")

/-- seed から count 本のベクタを JSONL の行のリストで返す。
各行は `{"e": <プログラム JSON（defs = genDefs + e）>, "g": <出自>, "v": <sober-check と同じ判定 JSON>}`。
出自 g = `typed` / `mut:<種別>` / `chaos`（消費者は e / v だけ読む — g は corevec.sh の自己検査と分布表のため） -/
def vectors (seed count : Nat) : List String := Id.run do
  let mut g := mkStdGen seed
  let mut out : List String := []
  for i in [0:count] do
    let ((e, tag), g') := (genVector i).run g
    g := g'
    let line := (Lean.Json.mkObj
      [("e", JsonBoundary.programToJson genDefs e), ("g", tag),
       ("v", JsonBoundary.checkToJson genDefs e)]).compress
    out := line :: out
  return out.reverse

end FS.Gen
