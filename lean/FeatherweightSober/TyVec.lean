import FeatherweightSober.Gen

/-!
# tyvec — 型の関数の差分オラクル（Lean → Sober 抽出器 E1b）

`sober-gen --tyvec <seed> <count>` が 1 行 1 ベクタ `<関数名> <引数…> = <結果>` を吐く。結果は **Lean の評価そのもの**
（Syntax.lean / Typing.lean の定義をそのまま走らせる）。Sober 側（lean/Extract/sober/tyvecdump.sober）が同じ引数で
抽出物（または移行期の手書きの写し）を計算して同じ形で印字し、scripts/extract.sh がバイト比較する。

字句: 型は前順のトークン（i / v n / b / y / f / u / o T / U T T / P T T / R m r T / S m r T / M m r T / C rc T / F T T）・
Nat は 10 進・Bool は 0 / 1・Option Nat は 10 進（none = -1）・Option Ty は N / J T・List Ty は L n T…
-/

namespace FS.TyVec

open FS FS.Gen

def bTok (b : Bool) : String := if b then "1" else "0"

def ownKTok : OwnK → Nat
  | .scope => 0
  | .task => 1
  | .tx => 2
  | .rx => 3

def tyTok : Ty → String
  | .int => "i"
  | .tvar n => s!"v {n}"
  | .bool => "b"
  | .byte => "y"
  | .f64 => "f"
  | .unit => "u"
  | .opt t => s!"o {tyTok t}"
  | .union l r => s!"U {tyTok l} {tyTok r}"
  | .prod l r => s!"P {tyTok l} {tyTok r}"
  | .ref m r t => s!"R {bTok m} {r} {tyTok t}"
  | .slice m r t => s!"S {bTok m} {r} {tyTok t}"
  | .map m r t => s!"M {bTok m} {r} {tyTok t}"
  | .chan rc t => s!"C {rc} {tyTok t}"
  | .fn p r => s!"F {tyTok p} {tyTok r}"
  | .own k r t => s!"W {ownKTok k} {r} {tyTok t}"

def optNatTok : Option Nat → String
  | none => "-1"
  | some n => toString n

def optTyTok : Option Ty → String
  | none => "N"
  | some t => s!"J {tyTok t}"

def listTok (ts : List Ty) : String :=
  s!"L {ts.length}" ++ String.join (ts.map (" " ++ tyTok ·))

/-- 能力の型（段 6 P1 — Ty.own）。genChaosTy は corevec の項の生成と共有なので、ここでだけ混ぜる -/
def genOwnK : Rand OwnK := do
  match ← rnd 3 with
  | 0 => return .scope
  | 1 => return .task
  | 2 => return .tx
  | _ => return .rx

/-- 型の乱択: genChaosTy（全構成子）に、string（imm byte slice）と能力の型を混ぜる（keyOk / keyCompat を自明にしない） -/
def genT : Rand Ty := do
  match ← rnd 9 with
  | 0 => return .slice false (← rnd 3) .byte
  | 1 => return .own (← genOwnK) (← rnd 3) (← genChaosTy 2)
  | 2 => return .prod (← genChaosTy 2) (.own (← genOwnK) (← rnd 3) (← genChaosTy 1))
  | _ => genChaosTy 3

/-- 同じ形のまま region / mut だけ揺らす（sub / anchorOf / keyCompat の 2 引数目を自明に false にしない） -/
def perturb : Ty → Rand Ty
  | .opt t => do return .opt (← perturb t)
  | .union l r => do return .union (← perturb l) (← perturb r)
  | .prod l r => do return .prod (← perturb l) (← perturb r)
  | .fn p r => do return .fn (← perturb p) (← perturb r)
  | .ref m _ t => do return .ref (if (← rnd 3) = 0 then !m else m) (← rnd 3) (← perturb t)
  | .slice m _ t => do return .slice (if (← rnd 3) = 0 then !m else m) (← rnd 3) (← perturb t)
  | .map m _ t => do return .map (if (← rnd 3) = 0 then !m else m) (← rnd 3) (← perturb t)
  | .chan _ t => do return .chan (← rnd 3) (← perturb t)
  | .own k _ t => do
    let k' ← genOwnK
    return .own (if (← rnd 3) = 0 then k' else k) (← rnd 3) (← perturb t)
  | t => return t

/-- region 0 の mut 位置を持つ仮引数型（isMut0 / anchorOf を自明に false / none にしない）: mut の ref / slice / map か、それを含む prod -/
def genMut0 : Nat → Rand Ty
  | 0 => do
    let t ← genChaosTy 1
    match ← rnd 2 with
    | 0 => return .ref true 0 t
    | 1 => return .slice true 0 t
    | _ => return .map true 0 t
  | n + 1 => do
    match ← rnd 2 with
    | 0 => return .prod (← genMut0 n) (← genChaosTy 1)
    | 1 => return .prod (← genChaosTy 1) (← genMut0 n)
    | _ => genMut0 0

def genP : Rand Ty := do
  if (← rnd 1) = 0 then genMut0 2 else genT

def genT2 (a : Ty) : Rand Ty := do
  if (← rnd 1) = 0 then perturb a else genT

def genN : Rand Nat := rnd 4

def genTs : Rand (List Ty) := do
  let n ← rnd 2
  let mut ts : List Ty := []
  for _ in [0:n] do
    ts := ts ++ [← genChaosTy 1]
  return ts

/-- 関数ごとの 1 本（関数の並びは Extract/Config.lean の targets + 構造の等しさ） -/
def vec (k : Nat) : Rand String := do
  match k with
  | 0 => let d ← genN; let t ← genT; return s!"regionsBelow {d} {tyTok t} = {bTok (t.regionsBelow d)}"
  | 1 => let t ← genT; return s!"mutFree {tyTok t} = {bTok t.mutFree}"
  | 2 => let t ← genT; return s!"keyOk {tyTok t} = {bTok t.keyOk}"
  | 3 => let a ← genT; let b ← genT2 a; return s!"keyCompat {tyTok a} {tyTok b} = {bTok (a.keyCompat b)}"
  | 4 => let r ← genN; let t ← genT; return s!"shiftR {r} {tyTok t} = {tyTok (t.shiftR r)}"
  | 5 => let r ← genN; let t ← genT; return s!"relocR {r} {tyTok t} = {tyTok (t.relocR r)}"
  | 6 => let a ← genN; let b ← genN; let n ← genN; return s!"rmap {a} {b} {n} = {rmap a b n}"
  | 7 => let a ← genN; let b ← genN; let t ← genT; return s!"renR {a} {b} {tyTok t} = {tyTok (t.renR a b)}"
  | 8 => let a ← genN; let b ← genN; let t ← genT; return s!"relocA {a} {b} {tyTok t} = {tyTok (t.relocA a b)}"
  | 9 => let k ← genN; let t ← genT; return s!"clampR {k} {tyTok t} = {tyTok (t.clampR k)}"
  | 10 => let k ← genN; let t ← genT; return s!"noClamp {k} {tyTok t} = {bTok (t.noClamp k)}"
  | 11 => let t ← genT; return s!"annFree {tyTok t} = {bTok t.annFree}"
  | 12 => let t ← genP; return s!"isMut0 {tyTok t} = {bTok t.isMut0}"
  | 13 => let t ← genP; return s!"mutTop {tyTok t} = {optNatTok t.mutTop}"
  | 14 => let a ← genP; let b ← genT2 a; return s!"anchorOf {tyTok a} {tyTok b} = {optNatTok (a.anchorOf b)}"
  | 15 => let a ← genT; let b ← genT2 a; return s!"sub {tyTok a} {tyTok b} = {bTok (a.sub b)}"
  | 16 => let t ← genT; return s!"chanFree {tyTok t} = {bTok t.chanFree}"
  | 17 => let b ← genN; let k ← genN; let a ← genT; let c ← genT2 a
          return s!"jumpRel {b} {k} {tyTok a} {tyTok c} = {bTok (Ty.jumpRel b k a c)}"
  | 18 => let m := (← rnd 1) = 0; let t ← genT
          let ot ← (do if (← rnd 1) = 0 then return none else return some (← genT2 t))
          return s!"readAs {bTok m} {optTyTok ot} {tyTok t} = {optTyTok (Ty.readAs m ot t)}"
  | 19 => let t ← genT; return s!"tyArgOk {tyTok t} = {bTok t.tyArgOk}"
  | 20 => let ts ← genTs; return s!"tyArgsOk {listTok ts} = {bTok (Ty.tyArgsOk ts)}"
  | 21 => let ts ← genTs; let t ← genT; return s!"tsubst {listTok ts} {tyTok t} = {tyTok (t.tsubst ts)}"
  | 22 => let n ← rnd 2; let t ← genT; return s!"tvarsBelow {n} {tyTok t} = {bTok (t.tvarsBelow n)}"
  | 23 => let t ← genT; return s!"paramOk {tyTok t} = {bTok t.paramOk}"
  | 24 => let t ← genT; return s!"retOk {tyTok t} = {bTok t.retOk}"
  | 25 => let r ← genN; let t ← genT; return s!"givable {r} {tyTok t} = {bTok (t.givable r)}"
  | 26 => let d ← genN; let t ← genT; return s!"rehome {d} {tyTok t} = {tyTok (t.rehome d)}"
  | _ => let a ← genT; let b ← genT2 a; return s!"tyEq {tyTok a} {tyTok b} = {bTok (decide (a = b))}"

def nFns : Nat := 28

/-- seed から count 本（関数を巡回） -/
def vectors (seed count : Nat) : List String := Id.run do
  let mut g := mkStdGen seed
  let mut out : List String := []
  for i in [0:count] do
    let (l, g') := (vec (i % nFns)).run g
    g := g'
    out := l :: out
  return out.reverse

end FS.TyVec
