import Lean
import Extract.Config

/-!
# Lean → Sober 抽出器の本体（方程式経由）

各定義の方程式（`getEqnsFor?`）を 1 本 = 1 腕として Sober の関数へ写す。

- **重なりのあるパターン**: 方程式の仮定が「先行の方程式の左辺のパターンの否定」（∀ ys, a_i = pat → … → False）の形であることを
  機械で確かめてから、方程式を順の if 連鎖（最初に当たった腕）に並べる。対応しない仮定は止まる
- **対象外は止まる**（黙って近似しない）: 方程式が無い（partial / unsafe）・写せない項（String・型クラス・右辺の match …）・
  写せない型・対象外の関数の呼び出し
- 素直な場合分け（どの腕も 1 つの仮引数の構成子 1 つだけで分かれる）は switch で出す
- `deriving DecidableEq` の構造の等しさは inductive の定義から生成する
-/

namespace Extract

open Lean Meta

/-- パターンの形（仮定と先行の方程式の照合用） -/
inductive Pat where
  | var
  | ctor (c : Name) (args : List Pat)
  | lit (s : String)
  deriving BEq, Inhabited, Repr

def isRecordTy (t : Expr) : Bool := recordTypes.any t.isConstOf

/-- 型が記録の番地を含むか（Ty・Option Ty・List Ty） -/
partial def mentionsRecord (t : Expr) : Bool :=
  isRecordTy t || t.getAppArgs.any mentionsRecord

/-- Sober の値の型（bool / int）。写せない型は止まる -/
def isNodeTy (t : Expr) : Bool := nodeTypes.any t.isConstOf

/-- int で持つ型（Nat・記録・節・番地・列挙） -/
def isIntTy (t : Expr) : Bool :=
  t.isConstOf ``Nat || isRecordTy t || isNodeTy t || handleTypes.any t.isConstOf || enumTypes.any t.isConstOf

def isDroppedTy (t : Expr) : Bool := droppedTypes.any t.isConstOf

def soberTy (t : Expr) : MetaM String := do
  let t ← instantiateMVars t
  if t.isConstOf ``Bool then return "bool"
  if isIntTy t then return "int"
  -- 文脈（Ctx = List Ty・LCtx = List (Ty × Nat)）は st.h の cons の番地（-1 = 空）
  if t.isConstOf ``FS.Ctx || t.isConstOf ``FS.LCtx then return "int"
  match t.getAppFnArgs with
  | (``Option, #[a]) => if isIntTy a then return "int" else throwError "extract: 写せない型 {t}"
  | (``List, #[a]) => if isRecordTy a then return "int" else throwError "extract: 写せない型 {t}"
  | _ => throwError "extract: 写せない型 {t}"

/-- 抽出する関数の署名 -/
structure FnSig where
  name : Name
  sober : String
  params : List String  -- Sober の型（捨てる仮引数を除く）
  ret : String
  needsSt : Bool
  /-- 仮引数ごとに写すか（関数表 Δ のような st が持つ型は捨てる） -/
  keep : List Bool := []

def fnSig (f : Name) (sober : Option String := none) : MetaM FnSig := do
  let ci ← getConstInfo f
  forallTelescope ci.type fun xs r => do
    let tys ← xs.toList.mapM inferType
    let keep := tys.map (!isDroppedTy ·)
    let ps ← (tys.filter (!isDroppedTy ·)).mapM soberTy
    let rt ← soberTy r
    let st := sober.isSome || tys.any mentionsRecord || mentionsRecord r || tys.any (fun t => isNodeTy t || isDroppedTy t)
    return { name := f, sober := sober.getD f.getString!, params := ps, ret := rt, needsSt := st, keep := keep }

/-- 手書きの読み口の署名（shimTable — 構成子は欄の型から） -/
def shimSig (f : Name) (s : String) : MetaM FnSig := do
  let ci ← getConstInfo f
  forallTelescope ci.type fun xs _ => do
    let tys ← xs.toList.mapM inferType
    -- 構成子は型の仮引数（無い — Act は単相）だけ。欄はそのまま
    let keep := tys.map (!isDroppedTy ·)
    return { name := f, sober := s, params := [], ret := "int", needsSt := true, keep := keep }

structure Env where
  sigs : List FnSig
  /-- 使った List.all の特殊化（関数の Sober 名） -/
  alls : IO.Ref (List String)

def Env.call (env : Env) (c : Name) (args : List String) : MetaM String := do
  match env.sigs.find? (·.name == c) with
  | some s =>
    let as := (if s.needsSt then ["mut st"] else []) ++ args
    return s!"{s.sober}({", ".intercalate as})"
  | none => throwError "extract: 対象外の関数の呼び出し {c}"

partial def patOf (e : Expr) : MetaM Pat := do
  let e ← instantiateMVars e
  if e.isFVar then return .var
  if e.isConstOf ``Bool.true then return .lit "true"
  if e.isConstOf ``Bool.false then return .lit "false"
  if let some n := e.rawNatLit? then return .lit (toString n)
  if let some n := e.nat? then return .lit (toString n)
  if let some (_, n) := enumTable.find? (e.isConstOf ·.1) then return .lit (toString n)
  match e.getAppFnArgs with
  | (``Nat.succ, #[x]) => return .ctor ``Nat.succ [← patOf x]
  | (``HAdd.hAdd, #[t, _, _, _, x, k]) =>
    unless t.isConstOf ``Nat do throwError "extract: パターンにできない項 {e}"
    let some n := k.nat? <|> k.rawNatLit? | throwError "extract: パターンにできない項 {e}"
    return (List.range n).foldl (fun p _ => .ctor ``Nat.succ [p]) (← patOf x)
  | (``Option.none, #[_]) => return .ctor ``Option.none []
  | (``Option.some, #[_, x]) => return .ctor ``Option.some [← patOf x]
  | (c, args) =>
    if (ctorTable.find? (·.1 == c)).isSome then return .ctor c (← args.toList.mapM patOf)
    if (nodeTable.find? (·.1 == c)).isSome then return .ctor c (← args.toList.mapM patOf)
    throwError "extract: パターンにできない項 {e}"

/-- 先行の方程式 j のパターン列 pj が、仮定（a_i = pat の連言の否定）と対応するか:
仮定の各等式 (i, pat) が pj[i] と同じ形で、pj の非変数の位置のうち仮定に無いものは現在の方程式 pk と同じ形 -/
def hypMatches (hyp : List (Nat × Pat)) (pj pk : List Pat) : Bool :=
  !hyp.isEmpty &&
  hyp.all (fun (i, p) => pj[i]? == some p) &&
  (List.range pj.length).all fun i =>
    pj[i]! == .var || (hyp.any (·.1 == i)) || pk[i]? == pj[i]?

/-- Sober の識別子（v_ + 名前・非 ASCII は _u<符号>） -/
def greek : List (Char × String) :=
  [('ρ', "rho"), ('δ', "delta"), ('Γ', "gam"), ('Λ', "lam"), ('Δ', "dlt"), ('τ', "tau"), ('₀', "0"), ('₁', "1"), ('₂', "2")]

def sname (n : Name) : String :=
  "v_" ++ String.join (n.toString.toList.map fun c =>
    if let some (_, s) := greek.find? (·.1 == c) then s
    else if c.isAlphanum && c.toNat < 128 || c == '_' then c.toString
    else if c == '\'' then "_p" else if c == '.' then "_" else s!"_u{c.toNat}")

/-- 条件 1 つ（tag = 仮引数の最上段の構成子の検査なら (仮引数, タグ) — switch の判定用） -/
structure Cond where
  s : String
  /-- switch の判定: (switch の主語, case の札) -/
  tag : Option (String × String) := none
  /-- 節の構成子の判定（switch の外れは nodeDefault） -/
  node : Bool := false
  deriving Inhabited

/-- パターン p（Lean の項）を値 v（Sober の式）に当てる。field = 記録の欄の値（Bool は 0 / 1 の int） -/
partial def patCode (v : String) (p : Expr) (field top : Bool) : MetaM (List Cond × List (FVarId × String)) := do
  let p ← instantiateMVars p
  if let .fvar fv := p then
    if field && (← inferType p).isConstOf ``Bool then return ([], [(fv, s!"{v} != 0")])
    return ([], [(fv, v)])
  if p.isConstOf ``Bool.true then return ([{ s := if field then s!"{v} != 0" else v }], [])
  if p.isConstOf ``Bool.false then return ([{ s := if field then s!"{v} == 0" else s!"!{v}" }], [])
  if let some n := p.rawNatLit? then return ([{ s := s!"{v} == {n}" }], [])
  if let some n := p.nat? then return ([{ s := s!"{v} == {n}" }], [])
  if let some (_, n) := enumTable.find? (p.isConstOf ·.1) then return ([{ s := s!"{v} == {n}" }], [])
  match p.getAppFnArgs with
  | (``Nat.succ, #[x]) =>
    let (c, b) ← patCode s!"({v} - 1)" x false false
    return ({ s := s!"{v} >= 1" } :: c, b)
  | (``HAdd.hAdd, #[t, _, _, _, x, k]) =>
    unless t.isConstOf ``Nat do throwError "extract: パターン {p}"
    let some n := k.nat? <|> k.rawNatLit? | throwError "extract: パターン {p}"
    let (c, b) ← patCode s!"({v} - {n})" x false false
    return ({ s := s!"{v} >= {n}" } :: c, b)
  | (``Option.none, #[_]) => return ([{ s := s!"{v} < 0" }], [])
  | (``List.nil, #[_]) => return ([{ s := s!"{v} < 0" }], [])
  | (``Option.some, #[_, x]) =>
    let (c, b) ← patCode v x false false
    return ({ s := s!"{v} >= 0" } :: c, b)
  | (c, args) =>
    if let some (_, cond, label, accs) := nodeTable.find? (·.1 == c) then
      let sub (s : String) := s.replace "@" v
      -- 判定の「&&&」の後ろは同じ札の中で分かれる条件（mkslice / mksliceAt は同じ kind — c の欄で分かれる）
      let parts := (sub cond).splitOn " &&& "
      let mut conds : List Cond := { s := parts.head!, tag := if top then label.map (s!"nK(mut st, {v})", ·) else none, node := true } ::
        (parts.drop 1).map fun s => { s := s }
      let mut binds := []
      for (a, acc) in args.toList.zip accs do
        let (c', b) ← patCode (sub acc) a true false
        conds := conds ++ c'
        binds := binds ++ b
      return (conds, binds)
    let some (_, tag, accs) := ctorTable.find? (·.1 == c) | throwError "extract: パターン {p}"
    let mut conds : List Cond := [{ s := s!"tg(mut st, {v}) == {tag}", tag := if top then some (s!"tg(mut st, {v})", tag) else none }]
    let mut binds := []
    for (a, acc) in args.toList.zip accs do
      let (c', b) ← patCode s!"{acc}(mut st, {v})" a true false
      conds := conds ++ c'
      binds := binds ++ b
    return (conds, binds)

structure Ctx where
  env : Env
  names : List (FVarId × String) := []
  /-- 左辺の仮引数の最上段のパターン（構成子の適用）と仮引数の名前。右辺の部分式がこれと同じ項なら
  新しい記録を作らずに仮引数をそのまま返す（記録は作ったら変えない・等しさは構造で見る — 観測等価。
  手書きの写しが葉の型で引数を共有していたのと同じ形 — E2） -/
  shares : List (Expr × String) := []

def Ctx.nameOf (cx : Ctx) (fv : FVarId) : MetaM String := do
  match cx.names.find? (·.1 == fv) with
  | some (_, s) => return s
  | none => throwError "extract: 束縛されていない変数"

mutual
partial def propStr (cx : Ctx) (p : Expr) : MetaM String := do
  let p ← whnfR p
  match p.getAppFnArgs with
  | (``LT.lt, #[t, _, a, b]) => do
    unless t.isConstOf ``Nat do throwError "extract: Nat 以外の < {p}"
    return s!"{← exprStr cx a} < {← exprStr cx b}"
  | (``LE.le, #[t, _, a, b]) => do
    unless t.isConstOf ``Nat do throwError "extract: Nat 以外の ≤ {p}"
    return s!"{← exprStr cx a} <= {← exprStr cx b}"
  | (``Eq, #[ty, a, b]) =>
    if isRecordTy ty then
      match eqTargets.find? (fun (n, _) => ty.isConstOf n) with
      | some (_, f) => return s!"{f}(mut st, {← exprStr cx a}, {← exprStr cx b})"
      | none => throwError "extract: 等しさを生成しない型 {ty}"
    else if ty.isConstOf ``Bool && b.isConstOf ``Bool.true then exprStr cx a
    else if ty.isConstOf ``Bool && b.isConstOf ``Bool.false then return s!"!{← exprStr cx a}"
    else if ty.isConstOf ``Nat || ty.isConstOf ``Bool then return s!"{← exprStr cx a} == {← exprStr cx b}"
    else throwError "extract: 写せない等式 {p}"
  | (``Not, #[q]) => return s!"!({← propStr cx q})"
  | _ => throwError "extract: 命題を写せない {p}"

partial def exprStr (cx : Ctx) (e : Expr) : MetaM String := do
  let e ← instantiateMVars e
  if let .fvar fv := e then return ← cx.nameOf fv
  if e.isConstOf ``Bool.true then return "true"
  if e.isConstOf ``Bool.false then return "false"
  if let some n := e.rawNatLit? then return toString n
  if let some n := e.nat? then return toString n
  if let some (_, n) := enumTable.find? (e.isConstOf ·.1) then return toString n
  match e.getAppFnArgs with
  | (``and, #[a, b]) => return s!"({← exprStr cx a} && {← exprStr cx b})"
  | (``or, #[a, b]) => return s!"({← exprStr cx a} || {← exprStr cx b})"
  | (``not, #[a]) => return s!"!{← exprStr cx a}"
  | (``Decidable.decide, #[p, _]) => return s!"({← propStr cx p})"
  | (``ite, #[_, c, _, a, b]) =>
    return s!"if {← propStr cx c} \{ {← exprStr cx a} } else \{ {← exprStr cx b} }"
  | (``Option.none, #[_]) => return "-1"
  | (``List.nil, #[_]) => return "-1"
  | (``Option.some, #[_, a]) => exprStr cx a
  | (``Option.or, #[_, a, b]) => return s!"optOr({← exprStr cx a}, {← exprStr cx b})"
  | (``Option.getD, #[_, a, d]) => return s!"optGetD({← exprStr cx a}, {← exprStr cx d})"
  | (``GetElem?.getElem?, #[coll, _, _, _, _, xs, i]) =>
    unless (coll.getAppFnArgs.1 == ``List) do throwError "extract: List 以外の添字 {e}"
    return s!"listGet(mut st, {← exprStr cx xs}, {← exprStr cx i})"
  | (``HAdd.hAdd, #[t, _, _, _, a, b]) =>
    unless t.isConstOf ``Nat do throwError "extract: Nat 以外の + {e}"
    return s!"({← exprStr cx a} + {← exprStr cx b})"
  | (``HSub.hSub, #[t, _, _, _, a, b]) =>
    unless t.isConstOf ``Nat do throwError "extract: Nat 以外の - {e}"
    return s!"natSub({← exprStr cx a}, {← exprStr cx b})"
  | (``Nat.succ, #[a]) => return s!"({← exprStr cx a} + 1)"
  | (``Min.min, #[t, _, a, b]) =>
    unless t.isConstOf ``Nat do throwError "extract: Nat 以外の min {e}"
    return s!"natMin({← exprStr cx a}, {← exprStr cx b})"
  | (``BEq.beq, #[t, _, a, b]) =>
    unless t.isConstOf ``Nat || t.isConstOf ``Bool do throwError "extract: 写せない == {e}"
    return s!"({← exprStr cx a} == {← exprStr cx b})"
  | (``List.all, #[_, xs, f]) =>
    let f ← etaReduceFn f
    let .const g _ := f | throwError "extract: List.all の関数が捕捉のない参照でない {f}"
    let some s := cx.env.sigs.find? (·.name == g) | throwError "extract: 対象外の関数の呼び出し {g}"
    let nm := s!"all_{s.sober}"
    cx.env.alls.modify fun l => if l.contains s.sober then l else l ++ [s.sober]
    return s!"{nm}(mut st, {← exprStr cx xs})"
  | (c, args) =>
    if let some (_, tag, _) := ctorTable.find? (·.1 == c) then
      if let some (_, v) := cx.shares.find? (·.1 == e) then return v
      if let some (_, v) := constCtors.find? (·.1 == c) then return v
      let like := cx.shares.find? (·.1.getAppFn.constName == c) |>.map (·.2)
      let mut fs : List String := []
      for a in args do
        let s ← exprStr cx a
        fs := fs ++ [if (← inferType a).isConstOf ``Bool then s!"b2i({s})" else s]
      let fs3 := (fs ++ ["0", "0", "0"]).take 3
      if let some v := like then return s!"mkLike(mut st, {v}, {tag}, {", ".intercalate fs3})"
      return s!"mk(mut st, {tag}, {", ".intercalate fs3})"
    -- 捨てる仮引数（関数表 Δ — st が持つ）の実引数は写さない
    let args := match cx.env.sigs.find? (·.name == c) with
      | some s => if s.keep.isEmpty then args.toList else ((args.toList.zip s.keep).filter (fun (p : Lean.Expr × Bool) => p.2)).map (fun (p : Lean.Expr × Bool) => p.1)
      | none => args.toList
    cx.env.call c (← args.mapM (exprStr cx))
where
  etaReduceFn (f : Expr) : MetaM Expr := do
    match f with
    | .lam _ _ (.app g (.bvar 0)) _ => if g.hasLooseBVars then return f else return g
    | _ => return f
end

/-- 腕 1 本 -/
structure Arm where
  header : String
  conds : List Cond
  hyps : Bool
  lets : List String
  ret : String
  deriving Inhabited

/-- 方程式の列から関数 1 本（eqns を外から渡せる — 負例の人工的な方程式のため） -/
def extractWith (env : Env) (f : Name) (eqs : Array Name)
    (shorts : List Name := (shortcuts.filter (·.1 == f)).map (·.2)) : MetaM String := do
  let sig ← fnSig f
  let params := sig.params.zipIdx.map fun (t, i) => (s!"a{i}", t)
  let mut pats : List (List Pat) := []
  let mut arms : List Arm := []
  for eq in eqs do
    let ty := (← getConstInfo eq).type
    let (arm, pk) ← forallTelescope ty fun xs concl => do
      let some (_, lhs, rhs) := concl.eq? | throwError "extract: {eq} が方程式でない"
      unless lhs.getAppFn.isConstOf f do throwError "extract: {eq} の左辺が {f} でない"
      let args0 := lhs.getAppArgs.toList
      unless args0.length == sig.keep.length do throwError "extract: {eq} の引数の数が署名と合わない"
      let args := ((args0.zip sig.keep).filter (·.2)).map (·.1)
      let pk ← args.mapM patOf
      let mut hasHyp := false
      for x in xs do
        let xt ← inferType x
        if ← isProp xt then
          hasHyp := true
          let hyp ← forallTelescope xt fun ys concl' => do
            unless concl'.isConstOf ``False do throwError "extract: {eq} の仮定が否定の形でない"
            let mut out : List (Nat × Pat) := []
            for y in ys do
              -- パターンの変数（∀ r, …）は飛ばす — 前提の等式だけ読む
              unless ← isProp (← inferType y) do continue
              match (← inferType y).eq? with
              | some (_, .fvar a, pat) =>
                let some i := args.findIdx? (· == .fvar a) | throwError "extract: {eq} の仮定の左辺が仮引数でない"
                out := out ++ [(i, ← patOf pat)]
              | _ => throwError "extract: {eq} の仮定に等式でない前提 {← inferType y}"
            return out
          unless pats.any (fun pj => hypMatches hyp pj pk) do
            throwError "extract: {eq} の仮定が先行の方程式の否定に対応しない: {repr hyp}"
      let rhs ← instantiateMVars rhs
      let mut conds : List Cond := []
      let mut binds : List (FVarId × String) := []
      for (a, (pn, _)) in args.zip params do
        let (c, b) ← patCode pn a false true
        conds := conds ++ c
        binds := binds ++ b
      let mut names : List (FVarId × String) := []
      let mut lets : List String := []
      for (fv, v) in binds do
        let base := sname (← fv.getUserName).eraseMacroScopes
        let s := if names.any (·.2 == base) then s!"{base}_{names.length}" else base
        names := names ++ [(fv, s)]
        if rhs.containsFVar fv then lets := lets ++ [s!"{s} := {v}"]
      let shares := (← (args.zip params).filterMapM fun (a, (pn, _)) => do
        let a ← instantiateMVars a
        return if ctorTable.any (·.1 == a.getAppFn.constName) then some (a, pn) else none)
      let cx : Ctx := { env := env, names := names, shares := shares }
      -- 右辺の最上段の `Option.or a b` は文で短絡させる（a が some なら b を計算しない — 前奏の optOr は両方を先に計算する）。
      -- 字句の後始末を a と b に一緒に掛けるため、区切り文字 \x01 で 1 本の字句にしてから分ける
      let orTop := match rhs.getAppFnArgs with
        | (``Option.or, #[_, a, b]) => some (a, b)
        | _ => none
      let r ← match orTop with
        | some (a, b) => do pure s!"{← exprStr cx a}\x01{← exprStr cx b}"
        | none => exprStr cx rhs
      -- 束縛の後始末（名前の字句の出現で数える — 名前は v_ で始まり、後ろが識別子の文字でない所だけが出現）:
      -- 使わなくなった束縛（共有で消えた）は出さない・1 回だけ使う欄の読み出しは使う場所へ畳む
      -- （読み出しは純粋 — `&&` の短絡で読まずに済む欄を先に読まない）
      let isId (c : Char) : Bool := c.isAlphanum || c == '_'
      let mut r := r
      let mut kept : List String := []
      for l in lets do
        let (nm, v) := match l.splitOn " := " with
          | [a, b] => (a, b)
          | _ => (l, l)
        let parts := r.splitOn nm
        let hit (rest : String) : Bool := !(String.Pos.Raw.get? rest 0 |>.any isId)
        let n := (parts.drop 1).filter hit |>.length
        if n == 0 then continue
        if n == 1 then
          let v' := if v.all isId then v else s!"({v})"
          let mut acc := parts.head!
          for rest in parts.drop 1 do
            acc := acc ++ (if hit rest then v' else nm) ++ rest
          r := acc
        else kept := kept ++ [l]
      lets := kept
      let rsplit := r.splitOn "\x01"
      if rsplit.length == 2 then
        lets := lets ++ [s!"o_or := {rsplit[0]!}", "if o_or >= 0 {", "    return o_or", "}"]
        r := rsplit[1]!
      return ({ header := s!"// {eq}", conds := conds, hyps := hasHyp, lets := lets, ret := r }, pk)
    pats := pats ++ [pk]
    -- 札の無い節の構成子（実行時だけの形）の腕は写さない（switch の外れが受ける）
    unless (arm : Arm).conds.any (·.s == "false") do
      arms := arms ++ [arm]
  -- switch にできるか: 仮定が無く（= 重なりが無い）、どの腕も同じ仮引数の最上段のタグの検査から始まる。
  -- 腕をタグでまとめ、タグの中は残りの条件の if 連鎖。重なりが無い方程式は網羅的なので、タグの中の最後の腕は無条件
  -- （外した条件はコメントに残す）・最後のタグのまとまりは switch の後に置く
  let tagOf (a : Arm) : Option (String × String) := a.conds.head?.bind (·.tag)
  let isNode := arms.any fun a => a.conds.head?.any (·.node)
  let tagArg : Option String := (arms.head?.bind tagOf).map (·.1)
  let useSwitch := arms.length ≥ 2 && tagArg.isSome && arms.all (!·.hyps) &&
    arms.all fun a => (tagOf a).map (·.1) == tagArg
  let body (a : Arm) (ind : String) : List String := (a.lets ++ [s!"return {a.ret}"]).map (ind ++ ·)
  let dropped (cs : List Cond) : String :=
    if cs.isEmpty then "" else s!"（最後の腕 — 先行の腕が外れれば当たる: {" && ".intercalate (cs.map (·.s))}）"
  -- 腕の列を if 連鎖に（skip = 先頭から捨てる条件の数 — switch のタグ検査の分）
  let chain (as : List Arm) (skip : Nat) (ind : String) : MetaM (List String) := do
    let mut out : List String := []
    for a in as.dropLast do
      let cs := a.conds.drop skip
      if cs.isEmpty then throwError "extract: {f} の最後でない腕が無条件"
      out := out ++ [s!"{ind}{a.header}", s!"{ind}if {" && ".intercalate (cs.map (·.s))} \{"] ++ body a (ind ++ "    ") ++ [s!"{ind}}"]
    let l := as.getLast!
    return out ++ [s!"{ind}{l.header}{dropped (l.conds.drop skip)}"] ++ body l ind
  let mut lines : List String := []
  if useSwitch then
    let mut groups : List (String × List Arm) := []
    for a in arms do
      let t := (tagOf a).get!.2
      groups := match groups.find? (·.1 == t) with
        | some _ => groups.map fun (t', as) => if t' == t then (t', as ++ [a]) else (t', as)
        | none => groups ++ [(t, [a])]
    lines := lines ++ [s!"    switch {tagArg.get!} \{"]
    -- 節の switch は全部の札を case に置き、外れ（実行時だけの形・未知の kind）は nodeDefault
    let inner := if isNode then groups else groups.dropLast
    for (t, as) in inner do
      lines := lines ++ [s!"    case {t}:"] ++ (← chain as 1 "        ")
    if isNode then
      lines := lines ++ ["    }", s!"    return {nodeDefault}"]
    else
      let (_, lastAs) := groups.getLast!
      lines := lines ++ ["    }"] ++ (← chain lastAs 1 "    ")
  else
    lines := lines ++ (← chain arms 0 "    ")
  -- 近道の腕（Config.shortcuts — 定理を先頭の腕に）
  let mut pre : List String := []
  for thm in shorts do
    let g := f
    let ty := (← getConstInfo thm).type
    let arm ← forallTelescope ty fun _ concl => do
      let some (_, lhs, rhs) := concl.eq? | throwError "extract: 近道 {thm} が等式でない"
      unless lhs.getAppFn.isConstOf g do throwError "extract: 近道 {thm} の左辺が {g} でない"
      let args := lhs.getAppArgs.toList
      unless args.length == params.length do throwError "extract: 近道 {thm} の引数の数が署名と合わない"
      let mut conds : List Cond := []
      let mut binds : List (FVarId × String) := []
      for (a, (pn, _)) in args.zip params do
        let (c, b) ← patCode pn a false false
        conds := conds ++ c
        binds := binds ++ b
      if conds.isEmpty then throwError "extract: 近道 {thm} が無条件（方程式を全部覆ってしまう）"
      let r ← exprStr { env := env, names := binds } (← instantiateMVars rhs)
      return [s!"    // 近道 {thm}（定理 — 先に当てても値は同じ）", s!"    if {" && ".intercalate (conds.map (·.s))} \{", s!"        return {r}", "    }"]
    pre := pre ++ arm
  lines := pre ++ lines
  -- 記録の仮引数（Option / List でない Ty — 番地は常に有効）の最上段のタグは先頭で 1 回だけ読む（if 連鎖の腕ごとに読み直さない）
  let recs ← forallTelescope (← getConstInfo f).type fun xs _ => xs.toList.mapM fun x => return isRecordTy (← inferType x)
  let mut hoist : List String := []
  for ((pn, _), r) in params.zip recs do
    let call := s!"tg(mut st, {pn})"
    let uses := lines.foldl (fun n l => n + ((l.splitOn call).length - 1)) 0
    if r && uses ≥ 2 then
      hoist := hoist ++ [s!"    g_{pn} := {call}"]
      lines := lines.map fun l => (s!"g_{pn}").intercalate (l.splitOn call)
  let ps := (if sig.needsSt then ["st mut S"] else []) ++ params.map fun (n, t) => s!"{n} {t}"
  return s!"// {f}（方程式 {eqs.size} 本）\nfunc {sig.sober}({", ".intercalate ps}) {sig.ret} \{\n{"\n".intercalate (hoist ++ lines)}\n}\n"

def extract (env : Env) (f : Name) : MetaM String := withRef .missing do
  try extract0 env f catch e => throwError "{f}: {e.toMessageData}"
where extract0 (env : Env) (f : Name) : MetaM String := do
  if let some eqs ← getEqnsFor? f then return ← extractWith env f eqs
  -- 場合分けの無い定義（非再帰・パターンなし）は展開の等式 1 本を腕 1 本に
  let ci ← getConstInfo f
  unless ci matches .defnInfo _ do throwError "extract: {f} に方程式が無い（partial / unsafe / 定義でない）"
  let some eq ← getUnfoldEqnFor? f (nonRec := true) | throwError "extract: {f} に方程式が無い（partial / unsafe / 定義でない）"
  extractWith env f #[eq]

/-- 構造の等しさ（deriving DecidableEq の写し）を inductive の定義から -/
def genEq (ind : Name) (fname : String) : MetaM String := do
  let .inductInfo iv ← getConstInfo ind | throwError "extract: {ind} が inductive でない"
  let mut cases : List String := []
  for c in iv.ctors do
    let some (_, tag, accs) := ctorTable.find? (·.1 == c) | throwError "extract: 構成子 {c} の対応表が無い"
    let fts ← forallTelescope (← getConstInfo c).type fun xs _ => xs.toList.mapM inferType
    unless fts.length == accs.length do throwError "extract: 構成子 {c} の欄の数が対応表と合わない"
    if fts.isEmpty then continue
    let cmps := (fts.zip accs).map fun (t, acc) =>
      if t.isConstOf ind then s!"{fname}(mut st, {acc}(mut st, a), {acc}(mut st, b))"
      else s!"{acc}(mut st, a) == {acc}(mut st, b)"
    cases := cases ++ [s!"    case {tag}:", s!"        return {" && ".intercalate cmps}"]
  return s!"// {ind} の構造の等しさ（deriving DecidableEq — 同じ番地なら等しい: 記録は作ったら変えない）\nfunc {fname}(st mut S, a int, b int) bool \{\n    if a == b \{\n        return true\n    }\n    gt_a := tg(mut st, a)\n    if gt_a != tg(mut st, b) \{\n        return false\n    }\n    switch gt_a \{\n{"\n".intercalate cases}\n    }\n    return true\n}\n"

/-- 生成物 1 ファイル -/
def genFile : MetaM String := do
  let sigs ← targets.mapM fnSig
  -- 構成子の対応表の網羅（inductive の構成子が全部表にあるか）
  for ind in recordTypes do
    let .inductInfo iv ← getConstInfo ind | throwError "extract: {ind} が inductive でない"
    for c in iv.ctors do
      unless (ctorTable.find? (·.1 == c)).isSome do throwError "extract: 構成子 {c} の対応表が無い（Config.lean の ctorTable に足す）"
  -- 名前の衝突
  for s in sigs do
    if (sigs.filter (·.sober == s.sober)).length > 1 then throwError "extract: Sober の名前が衝突 {s.sober}"
  let env : Env := { sigs := sigs, alls := ← IO.mkRef [] }
  let mut out := "package checker\n\n// 生成物 — 手で直さない（lean/Extract が Lean の定義の方程式から作る。作り直し = scripts/extract.sh --regen・照合 = scripts/extract.sh --check）。\n// 元: lean/FeatherweightSober/Syntax.lean・Typing.lean（設定 = lean/Extract/Config.lean）\n\nimport \"std/iter\"\nimport \"std/table\"\n\n"
  out := out ++ prelude ++ "\n"
  for (ind, fname) in eqTargets do
    out := out ++ (← genEq ind fname) ++ "\n"
  for f in targets do
    out := out ++ (← extract env f) ++ "\n"
  for g in ← env.alls.get do
    out := out ++ s!"// List.all の特殊化（{g}）\n" ++ ((listAllTemplate.replace "@NAME" s!"all_{g}").replace "@F" g) ++ "\n"
  return out

/-- tc_gen.sober（typecheck の 1 フレームの遷移 — 段 6 P2b）。Ty 層（ty_gen.sober）の関数と手書きの読み口（check.sober）を呼ぶ -/
def genTcFile : MetaM String := do
  let tySigs ← targets.mapM (fnSig ·)
  let tcSigs ← tcTargets.mapM (fnSig ·)
  let shims ← shimTable.mapM fun (n, s) => shimSig n s
  let sigs := tySigs ++ tcSigs ++ shims
  for s in sigs do
    if (sigs.filter (·.sober == s.sober)).length > 1 then throwError "extract: Sober の名前が衝突 {s.sober}"
  -- 節の対応表の網羅
  for ind in nodeTypes do
    let .inductInfo iv ← getConstInfo ind | throwError "extract: {ind} が inductive でない"
    for c in iv.ctors do
      unless (nodeTable.find? (·.1 == c)).isSome do throwError "extract: 節の構成子 {c} の対応表が無い（Config.lean の nodeTable に足す）"
  let env : Env := { sigs := sigs, alls := ← IO.mkRef [] }
  let mut out := "package checker\n\n// 生成物 — 手で直さない（lean/Extract が Lean の定義の方程式から作る。作り直し = scripts/extract.sh --regen・照合 = scripts/extract.sh --check）。\n// 元: lean/FeatherweightSober/TcStep.lean（typecheck の 1 フレームの遷移 tcStep — 定理 typecheck_eq_evalRule で typecheck と結ぶ）・設定 = lean/Extract/Config.lean。\n// 駆動部（tcRun）と読み口（ctxGet / actSub …）は手書き = check.sober\n\n"
  for f in tcTargets do
    out := out ++ (← extract env f) ++ "\n"
  unless (← env.alls.get).isEmpty do throwError "extract: tc_gen に List.all の特殊化は出さない（読み口に置く）"
  return out

end Extract
