import FeatherweightSober.Json
import FeatherweightSober.UniqFreeze
import FeatherweightSober.KindInferTc

/-!
# sober-check: Lean 製型検査器バイナリ（formal.md「守る 2 条件」の 2: プロセス分離）

stdin に脱糖後のコア AST（JSON、スキーマは FeatherweightSober/Json.lean が正）、
stdout に判定 JSON（`{"ok":true,"ty":…}` / `{"ok":false,"errors":[…]}`）。
終了コード: 0 = 受理、1 = 拒否（型エラー・パースエラーとも）。

`--batch`: stdin の 1 行を 1 入力（NDJSON — コア AST JSON は改行を含まない 1 行で渡す）として順に検査し、
1 行ごとに判定 JSON を 1 行吐いて flush する（入力の行と出力の行は 1:1。空行も 1 入力 = parse error）。
判定の中身は 1 入力のときと同じ `checkInput`。拒否でも止まらず次の行へ進み、終了コードは常に 0
（ゲートのスクリプトが Lean の起動を 1 回にまとめるための入出力 — 意味の側は触らない）。
-/

/-- 行末の改行（\n、あれば手前の \r も）を落とす -/
def chompLine (s : String) : String :=
  let s := if s.endsWith "\n" then s.dropRight 1 else s
  if s.endsWith "\r" then s.dropRight 1 else s

partial def batchLoop (stdin : IO.FS.Stream) (stdout : IO.FS.Stream) : IO Unit := do
  let line ← stdin.getLine
  if line.isEmpty then return
  stdout.putStrLn (FS.JsonBoundary.checkInput (chompLine line)).compress
  stdout.flush
  batchLoop stdin stdout

/-- `--uniq-batch`（F-al の修理 — 凍結の一意性の述語 uniqFreeze の照合）: 入力の形は `--batch` と同じ NDJSON。
1 行ごとに `{"uniq":true}` か `{"uniq":false,"why":…,"def":添字}`（main の式は -1）。パース失敗は `{"uniq":null,"why":…}` -/
def uniqInput (input : String) : Lean.Json :=
  let parseErr (msg : String) := Lean.Json.mkObj [("uniq", Lean.Json.null), ("why", s!"parse error: {msg}")]
  let verdict (r : Option (String × Int)) := match r with
    | none => Lean.Json.mkObj [("uniq", true)]
    | some (m, i) => Lean.Json.mkObj [("uniq", false), ("why", m), ("def", i)]
  match Lean.Json.parse input with
  | .error msg => parseErr msg
  | .ok j =>
    -- Def の `"trust":true`（std の信頼の口 — 脱糖器の trustDefs）
    let trust : List Bool := match j.getObjValAs? (Array Lean.Json) "defs" with
      | .ok ds => ds.toList.map (fun d => (d.getObjValAs? Bool "trust").toOption.getD false)
      | .error _ => []
    let tr := fun i => trust.getD i false
    match j.getObjValAs? Bool "parts" with
    | .ok true =>
      match FS.JsonBoundary.partsFromJson (input.length + 1) j with
      | .ok (Δ, mask, eo) => verdict (FS.Uniq.check Δ (fun i => mask.getD i false) eo tr)
      | .error msg => parseErr msg
    | _ =>
      match FS.JsonBoundary.programFromJson (input.length + 1) j with
      | .ok (Δ, e) => verdict (FS.Uniq.check Δ (fun _ => true) (some e) tr)
      | .error msg => parseErr msg

partial def uniqLoop (stdin : IO.FS.Stream) (stdout : IO.FS.Stream) : IO Unit := do
  let line ← stdin.getLine
  if line.isEmpty then return
  stdout.putStrLn (uniqInput (chompLine line)).compress
  stdout.flush
  uniqLoop stdin stdout

/-! `--expand-batch`（検査の道具 — 総称関数の呼び出しと、型引数を代入した単相の Def の判定の照合）: 入力の形は `--batch` と同じ NDJSON。
単相の文脈（kinds の無い Def の本体・根の式・作った単相の Def の本体）の `call`・`fnref` で型引数を持つものを、
`Def.inst`（呼び出しの型付けと意味論が通る単相の Def）を末尾に足してそれを型引数なしで指す形に置き換える。同じ (関数, 型引数) は 1 つの Def を共有する。
総称の Def の本体の中は置き換えない（型引数が型変数を含み、単相の Def にならない）。
1 行ごとに `{"orig":判定,"exp":判定,"inst":作った Def の数}`。置き換えの数が上限を超えたら `"exp":null`（多相の再帰） -/

namespace ExpandTool
open Lean (Json)
open FS

structure St where
  defs : Array Json
  memo : List (String × Nat) := []
  queue : List Nat := []
  fuel : Nat

/-- (関数, 型引数) の単相の Def の添字（無ければ `Def.inst` で作って末尾に足す） -/
def instOf (orig : Array Def) (st : St) (fn : Nat) (node : Json) (fuel : Nat) : Except String (St × Nat) := do
  let key := s!"{fn}:{((node.getObjVal? "ts").toOption.getD .null).compress}"
  match st.memo.lookup key with
  | some i => pure (st, i)
  | none =>
    if st.memo.length ≥ 4000 then throw "expansion limit"
    let dfn : Def ← match orig[fn]? with
      | some d => pure d
      | none => throw s!"call of unknown function {fn}"
    let ts ← FS.JsonBoundary.tysFromJson fuel node
    let d := dfn.inst ts
    let i := st.defs.size
    let defs' := st.defs.push (FS.JsonBoundary.defToJson d)
    let memo' := (key, i) :: st.memo
    let st' : St := { defs := defs', memo := memo', queue := st.queue ++ [i], fuel := st.fuel }
    pure (st', i)

/-- JSON の木を辿り、型引数を持つ call・fnref を単相の Def の参照に置き換える -/
partial def walk (orig : Array Def) (st : St) (j : Json) : Except String (St × Json) := do
  match j with
  | .arr a =>
    let mut s := st
    let mut out : Array Json := #[]
    for x in a do
      let (s', x') ← walk orig s x
      s := s'
      out := out.push x'
    pure (s, .arr out)
  | .obj kvs =>
    let kd := (j.getObjValAs? String "k").toOption
    let jts := (j.getObjVal? "ts").toOption
    let nts := match jts with
      | some (.arr a) => a.size
      | _ => 0
    let mut s := st
    let mut fields : List (String × Json) := []
    for (key, v) in kvs.toArray.toList do
      let (s', v') ← walk orig s v
      s := s'
      fields := fields ++ [(key, v')]
    if (kd == some "call" || kd == some "fnref") && nts > 0 then
      let fn ← j.getObjValAs? Nat "f"
      let (s', i) ← instOf orig s fn j s.fuel
      s := s'
      fields := fields.map (fun (key, v) =>
        if key == "f" then (key, (i : Json)) else if key == "ts" then (key, Json.arr #[]) else (key, v))
    pure (s, Json.mkObj fields)
  | _ => pure (st, j)

/-- 作った単相の Def の本体を順に辿る（本体の中の総称の呼び出しも単相の Def になる） -/
partial def drain (orig : Array Def) (st : St) : Except String St := do
  match st.queue with
  | [] => pure st
  | i :: rest =>
    let st := { st with queue := rest }
    let dj := st.defs[i]!
    let body : Json ← dj.getObjVal? "body"
    let (st, body') ← walk orig st body
    let dj' := match dj with
      | .obj kvs => Json.obj (kvs.insert "body" body')
      | other => other
    drain orig { st with defs := st.defs.set! i dj' }

def expandInput (input : String) (dump : Bool := false) : Json :=
  let orig := FS.JsonBoundary.checkInput input
  let fuel := input.length + 1
  let res : Except String (Json × Nat) := do
    let j ← Json.parse input
    let (Δ, _) ← FS.JsonBoundary.programFromJson fuel j
    -- defs の無い入力（素の式）は総称の Def を持たない
    let jdefs ← match j.getObjVal? "defs" with
      | .ok jd => jd.getArr?
      | .error _ => pure #[]
    let orig := Δ.toArray
    -- 単相の Def の本体（総称の Def は置き換えない）
    let mut st : St := { defs := jdefs, fuel := fuel * 4 }
    for i in [0:jdefs.size] do
      let dj := jdefs[i]!
      if (dj.getObjVal? "kinds").toOption.isNone then
        let body : Json ← dj.getObjVal? "body"
        let (st', body') ← walk orig st body
        st := { st' with defs := st'.defs.set! i (match dj with
          | .obj kvs => Json.obj (kvs.insert "body" body')
          | other => other) }
    let e : Json ← if (j.getObjVal? "defs").toOption.isNone then pure j else j.getObjVal? "e"
    let (st1, e') ← walk orig st e
    let st2 ← drain orig st1
    let n := st2.defs.size - jdefs.size
    let out := Json.mkObj [("defs", Json.arr st2.defs), ("e", e')]
    pure (if dump then out else FS.JsonBoundary.checkInput out.compress, n)
  match res with
  | .ok (v, n) => Json.mkObj [("orig", orig), ("exp", v), ("inst", (n : Nat))]
  | .error msg => Json.mkObj [("orig", orig), ("exp", Json.null), ("why", msg)]

partial def loop (stdin : IO.FS.Stream) (stdout : IO.FS.Stream) : IO Unit := do
  let line ← stdin.getLine
  if line.isEmpty then return
  stdout.putStrLn (expandInput (chompLine line)).compress
  stdout.flush
  loop stdin stdout

end ExpandTool

/-! `--infer-batch`（検査の道具 — kind の推論の照合）: 入力は、型変数の旗を全部外した形のコアの JSON（`check --emit=kindshape`）の NDJSON。
型パラメータを持つ Def の呼び出し（call・fnref）の辺で強連結成分を作り、呼び先の成分から順に `inferTc` で kind を推論する。
確定した成分の行は、形の Def をその kind で置き直した Def（`Def.raise`）に替えてから次の成分へ進む。成分の切り出しは証明しない（結果を照合する）。
1 行ごとに `{"kinds":[[K…]…]}`（Def の順・型パラメータの無い Def は空）か、型付かない成分があれば `{"kinds":null,"def":成分の最小の添字}` -/

namespace InferTool
open Lean (Json)
open FS

/-- JSON の木の call・fnref の呼び先 -/
partial def callees (j : Json) (acc : Array Nat) : Array Nat := Id.run do
  match j with
  | .arr a => a.foldl (fun acc x => callees x acc) acc
  | .obj kvs =>
    let mut acc := acc
    for (_, v) in kvs.toArray do
      acc := callees v acc
    let kd := (j.getObjValAs? String "k").toOption
    if kd == some "call" || kd == some "fnref" then
      if let .ok f := j.getObjValAs? Nat "f" then acc := acc.push f
    return acc
  | _ => acc

/-- g から辺を辿って届く行（g 自身は辺があるときだけ） -/
def reach (succ : Array (Array Nat)) (g : Nat) : Array Bool := Id.run do
  let mut seen := Array.replicate succ.size false
  let mut stack := succ.getD g #[]
  let mut fuel := succ.size * succ.size + succ.size + 1
  while fuel > 0 do
    fuel := fuel - 1
    match stack.back? with
    | none => break
    | some h =>
      stack := stack.pop
      if !(seen.getD h true) then
        seen := seen.set! h true
        stack := stack ++ succ.getD h #[]
  return seen

def inferInput (input : String) : Json :=
  let fuel := input.length + 1
  let res : Except String (Except Nat (Array (List Kind))) := do
    let j ← Json.parse input
    let jdefs ← match j.getObjVal? "defs" with
      | .ok jd => jd.getArr?
      | .error _ => pure #[]
    let Δ : Defs ← match j.getObjValAs? Bool "parts" with
      | .ok true => do let (ds, _, _) ← FS.JsonBoundary.partsFromJson fuel j; pure ds
      | _ => if jdefs.isEmpty then pure [] else do let (ds, _) ← FS.JsonBoundary.programFromJson fuel j; pure ds
    let n := Δ.length
    let d0 : Def := ⟨.unit, .unit, .triv, []⟩
    let S : Nat → Def := fun g => Δ[g]?.getD d0
    let len : Nat → Nat := fun g => (S g).kinds.length
    -- 型パラメータを持つ Def の間の辺
    let succ : Array (Array Nat) := (Array.range n).map (fun g =>
      if len g == 0 then #[] else
        let body := ((jdefs.getD g Json.null).getObjVal? "body").toOption.getD Json.null
        ((callees body #[]).filter (fun f => f < n && len f > 0)).toList.eraseDups.toArray)
    let rs := (Array.range n).map (reach succ)
    let gen := (List.range n).filter (fun g => len g > 0)
    -- 強連結成分（呼び先の成分から順に）
    let comp : Nat → List Nat := fun g => g :: gen.filter (fun h => h != g && (rs.getD g #[]).getD h false && (rs.getD h #[]).getD g false)
    let mut out : Array (List Kind) := Array.replicate n []
    let mut Δc := Δ
    let mut doneA := Array.replicate n false
    let mut left := gen
    let mut guard := n + 1
    while !left.isEmpty && guard > 0 do
      guard := guard - 1
      let mut next : List Nat := []
      for g in left do
        if doneA.getD g true then continue
        let C := comp g
        let ready := C.all (fun h => (succ.getD h #[]).all (fun f => C.contains f || doneA.getD f false))
        if !ready then
          next := next ++ [g]
          continue
        match inferTc Δc C S len with
        | none => return .error (C.foldl min g)
        | some K =>
          for h in C do
            out := out.set! h (K h)
            doneA := doneA.set! h true
          Δc := Δc.withK C S (fun h => if C.contains h then K h else [])
      left := next
    if !left.isEmpty then throw "component order"
    pure (.ok out)
  match res with
  | .ok (.ok ks) => Json.mkObj [("kinds", Json.arr (ks.map (fun l => Json.arr (l.map FS.JsonBoundary.kindToJson).toArray)))]
  | .ok (.error g) => Json.mkObj [("kinds", Json.null), ("def", (g : Nat))]
  | .error msg => Json.mkObj [("kinds", Json.null), ("why", msg)]

partial def loop (stdin : IO.FS.Stream) (stdout : IO.FS.Stream) : IO Unit := do
  let line ← stdin.getLine
  if line.isEmpty then return
  stdout.putStrLn (inferInput (chompLine line)).compress
  stdout.flush
  loop stdin stdout

end InferTool

/-! `--shape-batch`（形の検査: 型付けの判定とは別の結果）: 入力の形は `--batch` と同じ NDJSON。
1 行ごとに `{"raised":true}` か、宣言の kind で置き直すと変わる Def があれば `{"raised":false,"def":最小の添字}`。
`Def.raisedOk` は型付けの規則ではなく推論の定理の前提で、脱糖器の出力がこの形でないのはコンパイラの不具合。パース失敗は `{"raised":null}` -/
def shapeInput (input : String) : Lean.Json :=
  let fuel := input.length + 1
  let res : Except String (List FS.Def) := do
    let j ← Lean.Json.parse input
    match j.getObjValAs? Bool "parts" with
    | .ok true => do let (ds, _, _) ← FS.JsonBoundary.partsFromJson fuel j; pure ds
    | _ => match j.getObjVal? "defs" with
      | .ok _ => do let (ds, _) ← FS.JsonBoundary.programFromJson fuel j; pure ds
      | .error _ => pure []
  match res with
  | .error _ => Lean.Json.mkObj [("raised", Lean.Json.null)]
  | .ok ds => match ds.findIdx? (fun d => !d.raisedOk) with
    | none => Lean.Json.mkObj [("raised", true)]
    | some i => Lean.Json.mkObj [("raised", false), ("def", (i : Nat))]

partial def shapeLoop (stdin : IO.FS.Stream) (stdout : IO.FS.Stream) : IO Unit := do
  let line ← stdin.getLine
  if line.isEmpty then return
  stdout.putStrLn (shapeInput (chompLine line)).compress
  stdout.flush
  shapeLoop stdin stdout

/-- `--fill-anchors`: stdin の1入力に checkInput と同じ補い（fillProgramAnchors）を当てた JSON を1行で書く（検査はしない）。
凍結したstage1の出力を、Soberの側の読み手へ渡す前に揃えるゲート用の口。JSON として読めない入力はそのまま返す -/
def fillInput (input : String) : String :=
  match Lean.Json.parse input with
  | .ok j => (FS.JsonBoundary.fillProgramAnchors (input.length + 1) j).compress
  | .error _ => input

def main (args : List String) : IO UInt32 := do
  if args == ["--fill-anchors"] then
    IO.println (fillInput ((← (← IO.getStdin).readToEnd)))
    return 0
  if args == ["--expand-dump"] then
    IO.println (ExpandTool.expandInput ((← (← IO.getStdin).readToEnd)) true).compress
    return 0
  if args == ["--shape-batch"] then
    shapeLoop (← IO.getStdin) (← IO.getStdout)
    return 0
  if args == ["--infer-batch"] then
    InferTool.loop (← IO.getStdin) (← IO.getStdout)
    return 0
  if args == ["--expand-batch"] then
    ExpandTool.loop (← IO.getStdin) (← IO.getStdout)
    return 0
  if args == ["--uniq-batch"] then
    uniqLoop (← IO.getStdin) (← IO.getStdout)
    return 0
  if args == ["--batch"] then
    batchLoop (← IO.getStdin) (← IO.getStdout)
    return 0
  let input ← (← IO.getStdin).readToEnd
  let result := FS.JsonBoundary.checkInput input
  IO.println result.compress
  match result.getObjVal? "ok" with
  | .ok (.bool true) => return 0
  | _ => return 1
