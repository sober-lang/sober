import Lean.Data.Json
import FeatherweightSober.Checker
import FeatherweightSober.Split

/-!
# JSON 境界（formal.md「守る 2 条件」の 1: 境界はデータだけ）

Zig（脱糖器）→ Lean: 脱糖後のコア AST を JSON で受ける。範囲は `Expr.src`
（loc / chanV はソースに現れないので語彙に無い = パースの時点で拒否される）。
Lean → Zig: 判定を JSON で返す（`{"ok":true,"ty":…}` / `{"ok":false,"errors":[…]}`）。

このファイルの toJson / fromJson の対応が**境界のスキーマ仕様の正**。
Zig 側はこの形を吐く。スキーマ（"k" が種別タグ）:

- Ty: `{"k":"int"|"bool"|"byte"|"f64"|"unit"}` / `{"k":"opt","t":T}` / `{"k":"union","l":T,"r":T}` /
  `{"k":"prod","l":T,"r":T}` /
  `{"k":"ref","m":Bool,"r":Nat,"t":T}` / `{"k":"slice","m":Bool,"r":Nat,"t":T}` /
  `{"k":"map","m":Bool,"r":Nat,"key":K,"t":V}`（セル型 prod K (opt V)。他のセル型は "cell"） / `{"k":"chan","rc":Nat,"t":T}` / `{"k":"own","o":"scope"|"task"|"tx"|"rx","r":Nat,"t":T}`（段 6 P1） /
  `{"k":"fn","p":T,"r":T}`（V3-1。p / r は Def の base 座標） / `{"k":"tvar","i":Nat}`（V3-2）
- Expr: `{"k":"lit","n":Int}` / `{"k":"flit","n":Int}`（float の値 — ビット列を i64 の 2 の補数で読んだ値）/
  `{"k":"fadd"|"fsub"|"fmul"|"fdiv"|"feq"|"fne"|"flt"|"fle"|"fgt"|"fge","a":E,"b":E}` /
  `{"k":"fneg"|"fsqrt"|"tofloat"|"ftoint"|"fbits"|"ffrombits","e":E}`（float の段） / `{"k":"true"|"false"|"triv"}` / `{"k":"var","i":Nat}` /
  `{"k":"let","e":E,"body":E}` /
  `{"k":"add"|"lt"|"sub"|"mul"|"div"|"mod"|"and"|"or"|"xor"|"eq"|"ne"|"le"|"gt"|"ge","a":E,"b":E}`
  （sub..mod は arith、eq..ge は cmp のファミリに落ちる） /
  `{"k":"if","c":E,"t":E,"e":E}` / `{"k":"nil","t":T}` / `{"k":"some","e":E}` /
  `{"k":"ifnil","e":E,"nil":E,"some":E}` / `{"k":"pair","a":E,"b":E}` /
  `{"k":"fst","e":E}` / `{"k":"snd","e":E}` / `{"k":"inl","r":T,"e":E}` /
  `{"k":"inr","l":T,"e":E}` / `{"k":"case","e":E,"l":E,"r":E}` / `{"k":"block","e":E}` /
  `{"k":"alloc","mut":Bool,"e":E}` / `{"k":"deref","e":E}` / `{"k":"assign","l":E,"e":E}` /
  `{"k":"while","c":E,"body":E}` / `{"k":"freeze","e":E}` / `{"k":"par","e1":E,"e2":E}` /
  `{"k":"strlit","bs":[Int...],"r":Nat}`（string リテラル — region r の imm int セル列。strlit の段） /
  `{"k":"call","f":Nat,"e":E}` / `{"k":"callm","f":Nat,"e":E}`（R2 の anchor つき呼び出し） /
  `{"k":"fnref","f":Nat}`（型引数があれば `"ts":[T...]`。
  無いときは省略 = 単相の呼び出し。V3-2） / `{"k":"callv","f":E,"e":E}` /
  `{"k":"ann","e":E,"t":T}`（V3-5 の型注釈） /
  `{"k":"label","t":T,"e":E}` / `{"k":"jump","n":Nat,"t":T,"e":E}`（V4 の脱出。jump の t は結果型の注釈） /
  `{"k":"unreach","t":T}`（A5 — 到達しない。t は結果型の注釈） /
  `{"k":"parch","t":T,"e1":E,"e2":E}` / `{"k":"newchan","rc":Nat,"t":T}` /
  `{"k":"send","c":E,"e":E}` / `{"k":"recv","c":E}` / `{"k":"close","c":E}` /
  `{"k":"scope","t":T,"eps":T,"e":E}`（eps = err の型 — P3b-4 1b'） / `{"k":"spawn","s":E,"a":E,"e":E}` / `{"k":"join","t":T,"h":E}` / `{"k":"try","t":T,"h":E}`（段 6 P1） /
  `{"k":"newch","r":Nat,"cap":Nat,"t":T}`（段 6 P1 — 端点の組を作る） /
  `{"k":"mkmap","m":Bool,"key":K,"t":V}` / `{"k":"getm","t":T,"e":E,"key":E}` /
  `{"k":"setm","e":E,"key":E,"v":E}` / `{"k":"delm","t":T,"e":E,"key":E}` /
  `{"k":"lenm","e":E}` / `{"k":"keysm","e":E}`

fromJson は燃料つき再帰（Json の入れ子への構造的再帰が書けないため）。
燃料は JSON のノード数で必ず足りる値を呼び手が渡す（parseExpr は入力長を使う）。
partial にしないのは roundtrip を rfl で照合できる（計算可能な定義に保つ）ため。
-/
namespace FS.JsonBoundary

open Lean (Json)

/-- 能力の種類の綴り（段 6 P1） -/
def ownKToStr : OwnK → String
  | .scope => "scope"
  | .task => "task"
  | .tx => "tx"
  | .rx => "rx"

def ownKFromStr : String → Except String OwnK
  | "scope" => .ok .scope
  | "task" => .ok .task
  | "tx" => .ok .tx
  | "rx" => .ok .rx
  | o => .error s!"ownK: unknown {o}"

/-- Ty → JSON（スキーマの正） -/
def tyToJson : Ty → Json
  | .int => Json.mkObj [("k", "int")]
  | .tvar i => Json.mkObj [("k", "tvar"), ("i", (i : Nat))]
  | .bool => Json.mkObj [("k", "bool")]
  | .byte => Json.mkObj [("k", "byte")]
  | .f64 => Json.mkObj [("k", "f64")]
  | .unit => Json.mkObj [("k", "unit")]
  | .opt t => Json.mkObj [("k", "opt"), ("t", tyToJson t)]
  | .union l r => Json.mkObj [("k", "union"), ("l", tyToJson l), ("r", tyToJson r)]
  | .prod l r => Json.mkObj [("k", "prod"), ("l", tyToJson l), ("r", tyToJson r)]
  | .ref m r t =>
      Json.mkObj [("k", "ref"), ("m", m), ("r", (r : Nat)), ("t", tyToJson t)]
  | .slice m r t =>
      Json.mkObj [("k", "slice"), ("m", m), ("r", (r : Nat)), ("t", tyToJson t)]
  -- map のセル型 prod k (opt v) は key / t（値型）に分けて出す（R3）。それ以外のセル型は cell
  | .map m r (.prod k (.opt v)) =>
      Json.mkObj [("k", "map"), ("m", m), ("r", (r : Nat)), ("key", tyToJson k), ("t", tyToJson v)]
  | .map m r c =>
      Json.mkObj [("k", "map"), ("m", m), ("r", (r : Nat)), ("cell", tyToJson c)]
  | .chan rc t => Json.mkObj [("k", "chan"), ("rc", (rc : Nat)), ("t", tyToJson t)]
  | .fn p r => Json.mkObj [("k", "fn"), ("p", tyToJson p), ("r", tyToJson r)]
  | .own k r t => Json.mkObj [("k", "own"), ("o", ownKToStr k), ("r", (r : Nat)), ("t", tyToJson t)]

/-- Expr（ソース項）→ JSON。loc / chanV は境界の語彙に無い（ソースに現れない）ので
ダミーの kind を吐く — Zig からは絶対に来ず、パースは拒否する -/
def exprToJson : Expr → Json
  | .lit n => Json.mkObj [("k", "lit"), ("n", n)]
  | .tt => Json.mkObj [("k", "true")]
  | .ff => Json.mkObj [("k", "false")]
  | .triv => Json.mkObj [("k", "triv")]
  | .var i => Json.mkObj [("k", "var"), ("i", (i : Nat))]
  | .letE e body => Json.mkObj [("k", "let"), ("e", exprToJson e), ("body", exprToJson body)]
  | .add a b => Json.mkObj [("k", "add"), ("a", exprToJson a), ("b", exprToJson b)]
  | .lt a b => Json.mkObj [("k", "lt"), ("a", exprToJson a), ("b", exprToJson b)]
  | .arith op a b =>
      let k := match op with
        | .sub => "sub" | .mul => "mul" | .div => "div" | .mod => "mod"
        | .land => "and" | .lor => "or" | .lxor => "xor"
        | .shl => "shl" | .shr => "shr"
      Json.mkObj [("k", k), ("a", exprToJson a), ("b", exprToJson b)]
  | .cmp op a b =>
      let k := match op with
        | .eq => "eq" | .ne => "ne" | .le => "le" | .gt => "gt" | .ge => "ge"
      Json.mkObj [("k", k), ("a", exprToJson a), ("b", exprToJson b)]
  | .ite c t e =>
      Json.mkObj [("k", "if"), ("c", exprToJson c), ("t", exprToJson t), ("e", exprToJson e)]
  | .nil t => Json.mkObj [("k", "nil"), ("t", tyToJson t)]
  | .some e => Json.mkObj [("k", "some"), ("e", exprToJson e)]
  | .ifnil e n s =>
      Json.mkObj [("k", "ifnil"), ("e", exprToJson e), ("nil", exprToJson n),
        ("some", exprToJson s)]
  | .inl r e => Json.mkObj [("k", "inl"), ("r", tyToJson r), ("e", exprToJson e)]
  | .inr l e => Json.mkObj [("k", "inr"), ("l", tyToJson l), ("e", exprToJson e)]
  | .case e l r =>
      Json.mkObj [("k", "case"), ("e", exprToJson e), ("l", exprToJson l), ("r", exprToJson r)]
  | .pair a b => Json.mkObj [("k", "pair"), ("a", exprToJson a), ("b", exprToJson b)]
  | .fst e => Json.mkObj [("k", "fst"), ("e", exprToJson e)]
  | .snd e => Json.mkObj [("k", "snd"), ("e", exprToJson e)]
  | .call fn ts e =>
      if ts.isEmpty then Json.mkObj [("k", "call"), ("f", (fn : Nat)), ("e", exprToJson e)]
      else Json.mkObj [("k", "call"), ("f", (fn : Nat)),
        ("ts", Json.arr (ts.map tyToJson).toArray), ("e", exprToJson e)]
  | .callM fn ts e =>
      if ts.isEmpty then Json.mkObj [("k", "callm"), ("f", (fn : Nat)), ("e", exprToJson e)]
      else Json.mkObj [("k", "callm"), ("f", (fn : Nat)),
        ("ts", Json.arr (ts.map tyToJson).toArray), ("e", exprToJson e)]
  | .fnref fn ts =>
      if ts.isEmpty then Json.mkObj [("k", "fnref"), ("f", (fn : Nat))]
      else Json.mkObj [("k", "fnref"), ("f", (fn : Nat)), ("ts", Json.arr (ts.map tyToJson).toArray)]
  | .callv f e => Json.mkObj [("k", "callv"), ("f", exprToJson f), ("e", exprToJson e)]
  | .ann e t => Json.mkObj [("k", "ann"), ("e", exprToJson e), ("t", tyToJson t)]
  | .block e => Json.mkObj [("k", "block"), ("e", exprToJson e)]
  | .blockR t e => Json.mkObj [("k", "block"), ("e", exprToJson e), ("t", tyToJson t)]
  | .copyTo k t e => Json.mkObj [("k", "copyto"), ("r", (k : Nat)), ("t", tyToJson t), ("e", exprToJson e)]
  | .label t e => Json.mkObj [("k", "label"), ("t", tyToJson t), ("e", exprToJson e)]
  | .jump n t e =>
      Json.mkObj [("k", "jump"), ("n", (n : Nat)), ("t", tyToJson t), ("e", exprToJson e)]
  | .unreach t => Json.mkObj [("k", "unreach"), ("t", tyToJson t)]
  | .alloc m e => Json.mkObj [("k", "alloc"), ("mut", m), ("e", exprToJson e)]
  | .deref e => Json.mkObj [("k", "deref"), ("e", exprToJson e)]
  | .assign l e => Json.mkObj [("k", "assign"), ("l", exprToJson l), ("e", exprToJson e)]
  | .whileE c b => Json.mkObj [("k", "while"), ("c", exprToJson c), ("body", exprToJson b)]
  | .freeze e => Json.mkObj [("k", "freeze"), ("e", exprToJson e)]
  | .mkslice m t => Json.mkObj [("k", "mkslice"), ("m", m), ("t", tyToJson t)]
  | .mksliceAt m t r => Json.mkObj [("k", "mkslice"), ("m", m), ("t", tyToJson t), ("r", (r : Nat))]
  | .strlit bs r =>
      Json.mkObj [("k", "strlit"), ("bs", Json.arr (bs.map (fun n : Int => (n : Json))).toArray), ("r", (r : Nat))]
  | .index e i Option.none => Json.mkObj [("k", "index"), ("e", exprToJson e), ("i", exprToJson i)]
  | .index e i (Option.some t) =>
      Json.mkObj [("k", "index"), ("e", exprToJson e), ("i", exprToJson i), ("t", tyToJson t)]
  | .lenE e => Json.mkObj [("k", "len"), ("e", exprToJson e)]
  | .tobyte e => Json.mkObj [("k", "tobyte"), ("e", exprToJson e)]
  | .flit n => Json.mkObj [("k", "flit"), ("n", n)]
  | .farith op a b =>
      let k := match op with
        | .add => "fadd" | .sub => "fsub" | .mul => "fmul" | .div => "fdiv"
      Json.mkObj [("k", k), ("a", exprToJson a), ("b", exprToJson b)]
  | .fcmp op a b =>
      let k := match op with
        | .eq => "feq" | .ne => "fne" | .lt => "flt" | .le => "fle" | .gt => "fgt" | .ge => "fge"
      Json.mkObj [("k", k), ("a", exprToJson a), ("b", exprToJson b)]
  | .fconv op e =>
      let k := match op with
        | .neg => "fneg" | .sqrt => "fsqrt" | .ofInt => "tofloat" | .toInt => "ftoint"
        | .bits => "fbits" | .fromBits => "ffrombits"
      Json.mkObj [("k", k), ("e", exprToJson e)]
  | .toint e => Json.mkObj [("k", "toint"), ("e", exprToJson e)]
  | .append e v => Json.mkObj [("k", "append"), ("e", exprToJson e), ("v", exprToJson v)]
  | .setidx e i v =>
      Json.mkObj [("k", "setidx"), ("e", exprToJson e), ("i", exprToJson i),
        ("v", exprToJson v)]
  | .subslice e sa sb =>
      Json.mkObj [("k", "subslice"), ("e", exprToJson e), ("a", exprToJson sa),
        ("b", exprToJson sb)]
  | .eqs e1 e2 => Json.mkObj [("k", "eqs"), ("a", exprToJson e1), ("b", exprToJson e2)]
  | .concat e1 e2 => Json.mkObj [("k", "concat"), ("a", exprToJson e1), ("b", exprToJson e2)]
  | .slicev _ _ _ _ => Json.mkObj [("k", "slicev")]
  | .mkmap m (.prod k (.opt v)) =>
      Json.mkObj [("k", "mkmap"), ("m", m), ("key", tyToJson k), ("t", tyToJson v)]
  | .mkmap m c => Json.mkObj [("k", "mkmap"), ("m", m), ("cell", tyToJson c)]
  | .mkmapAt m (.prod k (.opt v)) r =>
      Json.mkObj [("k", "mkmap"), ("m", m), ("key", tyToJson k), ("t", tyToJson v), ("r", (r : Nat))]
  | .mkmapAt m c r => Json.mkObj [("k", "mkmap"), ("m", m), ("cell", tyToJson c), ("r", (r : Nat))]
  | .getm t e k =>
      Json.mkObj [("k", "getm"), ("t", tyToJson t), ("e", exprToJson e), ("key", exprToJson k)]
  | .setm e k v =>
      Json.mkObj [("k", "setm"), ("e", exprToJson e), ("key", exprToJson k),
        ("v", exprToJson v)]
  | .delm t e k =>
      Json.mkObj [("k", "delm"), ("t", tyToJson t), ("e", exprToJson e), ("key", exprToJson k)]
  | .lenm e => Json.mkObj [("k", "lenm"), ("e", exprToJson e)]
  | .keysm e => Json.mkObj [("k", "keysm"), ("e", exprToJson e)]
  | .mapv _ _ _ _ => Json.mkObj [("k", "mapv")]
  | .par e1 e2 => Json.mkObj [("k", "par"), ("e1", exprToJson e1), ("e2", exprToJson e2)]
  | .parch t e1 e2 =>
      Json.mkObj [("k", "parch"), ("t", tyToJson t), ("e1", exprToJson e1),
        ("e2", exprToJson e2)]
  | .newchan rc t => Json.mkObj [("k", "newchan"), ("rc", (rc : Nat)), ("t", tyToJson t)]
  | .send c e => Json.mkObj [("k", "send"), ("c", exprToJson c), ("e", exprToJson e)]
  | .recv c => Json.mkObj [("k", "recv"), ("c", exprToJson c)]
  | .close c => Json.mkObj [("k", "close"), ("c", exprToJson c)]
  | .loc _ _ => Json.mkObj [("k", "loc-not-in-source")]
  | .blit _ => Json.mkObj [("k", "blit-not-in-source")]
  | .chanV _ => Json.mkObj [("k", "chanv-not-in-source")]
  | .scope t ε e => Json.mkObj [("k", "scope"), ("t", tyToJson t), ("eps", tyToJson ε), ("e", exprToJson e)]
  | .spawn sc a e => Json.mkObj [("k", "spawn"), ("s", exprToJson sc), ("a", exprToJson a), ("e", exprToJson e)]
  | .join t h => Json.mkObj [("k", "join"), ("t", tyToJson t), ("h", exprToJson h)]
  | .tryJ t h => Json.mkObj [("k", "try"), ("t", tyToJson t), ("h", exprToJson h)]
  | .scopeV _ _ => Json.mkObj [("k", "scopev-not-in-source")]
  | .taskV _ _ => Json.mkObj [("k", "taskv-not-in-source")]
  | .newch r cap t => Json.mkObj [("k", "newch"), ("r", (r : Nat)), ("cap", (cap : Nat)), ("t", tyToJson t)]
  | .epV _ _ _ _ => Json.mkObj [("k", "epv-not-in-source")]

/-- JSON → Ty（燃料つき） -/
def tyFromJson : Nat → Json → Except String Ty
  | 0, _ => .error "tyFromJson: out of fuel"
  | fuel + 1, j => do
    let k ← j.getObjVal? "k" >>= Json.getStr?
    match k with
    | "int" => pure .int
    | "tvar" => do
        let i ← j.getObjVal? "i" >>= Json.getNat?
        pure (.tvar i)
    | "bool" => pure .bool
    | "byte" => pure .byte
    | "f64" => pure .f64
    | "unit" => pure .unit
    | "opt" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.opt t)
    | "union" => do
        let l ← j.getObjVal? "l" >>= tyFromJson fuel
        let r ← j.getObjVal? "r" >>= tyFromJson fuel
        pure (.union l r)
    | "prod" => do
        let l ← j.getObjVal? "l" >>= tyFromJson fuel
        let r ← j.getObjVal? "r" >>= tyFromJson fuel
        pure (.prod l r)
    | "ref" => do
        let m ← j.getObjVal? "m" >>= Json.getBool?
        let r ← j.getObjVal? "r" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.ref m r t)
    | "slice" => do
        let m ← j.getObjVal? "m" >>= Json.getBool?
        let r ← j.getObjVal? "r" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.slice m r t)
    | "map" => do
        let m ← j.getObjVal? "m" >>= Json.getBool?
        let r ← j.getObjVal? "r" >>= Json.getNat?
        match j.getObjVal? "cell" with
        | .ok c => pure (.map m r (← tyFromJson fuel c))
        | .error _ => do
          let k ← j.getObjVal? "key" >>= tyFromJson fuel
          let t ← j.getObjVal? "t" >>= tyFromJson fuel
          pure (.map m r (.prod k (.opt t)))
    | "chan" => do
        let rc ← j.getObjVal? "rc" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.chan rc t)
    | "fn" => do
        let p ← j.getObjVal? "p" >>= tyFromJson fuel
        let r ← j.getObjVal? "r" >>= tyFromJson fuel
        pure (.fn p r)
    | "own" => do
        let o ← j.getObjVal? "o" >>= Json.getStr? >>= ownKFromStr
        let r ← j.getObjVal? "r" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.own o r t)
    | other => .error s!"tyFromJson: unknown kind {other}"

/-- 型引数リスト（省略 = []） -/
def tysFromJson (fuel : Nat) (j : Json) : Except String (List Ty) :=
  match j.getObjVal? "ts" with
  | .ok jt => do
      let arr ← jt.getArr?
      arr.toList.mapM (tyFromJson fuel)
  | .error _ => pure []

/-- JSON → Expr（燃料つき）。ソース項の語彙のみ — loc / chanV は unknown kind で拒否。
arith / cmp の各 op はアームを展開して書く（ヘルパーに切ると mutual になり
well-founded コンパイルで rfl 簡約（roundtrip の照合）が壊れるため） -/
def exprFromJson : Nat → Json → Except String Expr
  | 0, _ => .error "exprFromJson: out of fuel"
  | fuel + 1, j => do
    let k ← j.getObjVal? "k" >>= Json.getStr?
    match k with
    | "lit" => do
        let n ← j.getObjVal? "n" >>= Json.getInt?
        pure (.lit n)
    | "true" => pure .tt
    | "false" => pure .ff
    | "triv" => pure .triv
    | "var" => do
        let i ← j.getObjVal? "i" >>= Json.getNat?
        pure (.var i)
    | "let" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let body ← j.getObjVal? "body" >>= exprFromJson fuel
        pure (.letE e body)
    | "add" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.add a b)
    | "lt" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.lt a b)
    | "sub" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .sub a b)
    | "mul" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .mul a b)
    | "div" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .div a b)
    | "mod" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .mod a b)
    | "and" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .land a b)
    | "or" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .lor a b)
    | "xor" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .lxor a b)
    | "shl" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .shl a b)
    | "shr" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.arith .shr a b)
    | "eq" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.cmp .eq a b)
    | "ne" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.cmp .ne a b)
    | "le" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.cmp .le a b)
    | "gt" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.cmp .gt a b)
    | "ge" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.cmp .ge a b)
    | "if" => do
        let c ← j.getObjVal? "c" >>= exprFromJson fuel
        let t ← j.getObjVal? "t" >>= exprFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.ite c t e)
    | "nil" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.nil t)
    | "some" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.some e)
    | "ifnil" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let n ← j.getObjVal? "nil" >>= exprFromJson fuel
        let s ← j.getObjVal? "some" >>= exprFromJson fuel
        pure (.ifnil e n s)
    | "inl" => do
        let r ← j.getObjVal? "r" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.inl r e)
    | "inr" => do
        let l ← j.getObjVal? "l" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.inr l e)
    | "case" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let l ← j.getObjVal? "l" >>= exprFromJson fuel
        let r ← j.getObjVal? "r" >>= exprFromJson fuel
        pure (.case e l r)
    | "pair" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.pair a b)
    | "fst" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.fst e)
    | "snd" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.snd e)
    | "call" => do
        let fn ← j.getObjVal? "f" >>= Json.getNat?
        let ts ← tysFromJson fuel j
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.call fn ts e)
    | "callm" => do
        let fn ← j.getObjVal? "f" >>= Json.getNat?
        let ts ← tysFromJson fuel j
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.callM fn ts e)
    | "fnref" => do
        let fn ← j.getObjVal? "f" >>= Json.getNat?
        let ts ← tysFromJson fuel j
        pure (.fnref fn ts)
    | "callv" => do
        let f ← j.getObjVal? "f" >>= exprFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.callv f e)
    | "ann" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.ann e t)
    | "block" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        match j.getObjVal? "t" with
        | Except.ok tj => do
            let t ← tyFromJson fuel tj
            pure (.blockR t e)
        | Except.error _ => pure (.block e)
    | "copyto" => do
        let k ← j.getObjValAs? Nat "r"
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.copyTo k t e)
    | "label" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.label t e)
    | "jump" => do
        let n ← j.getObjVal? "n" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.jump n t e)
    | "unreach" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.unreach t)
    | "alloc" => do
        let m ← j.getObjVal? "mut" >>= Json.getBool?
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.alloc m e)
    | "deref" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.deref e)
    | "assign" => do
        let l ← j.getObjVal? "l" >>= exprFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.assign l e)
    | "while" => do
        let c ← j.getObjVal? "c" >>= exprFromJson fuel
        let b ← j.getObjVal? "body" >>= exprFromJson fuel
        pure (.whileE c b)
    | "freeze" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.freeze e)
    | "mkslice" => do
        let m ← j.getObjVal? "m" >>= Json.getBool?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        -- "r" があれば region 指定版（M3b — 省略 = 最内の mkslice。既存の黄金と互換）
        match j.getObjVal? "r" with
        | .ok rj => pure (.mksliceAt m t (← rj.getNat?))
        | .error _ => pure (.mkslice m t)
    | "strlit" => do
        let arr ← j.getObjVal? "bs" >>= Json.getArr?
        let bs ← arr.toList.mapM Json.getInt?
        let r ← j.getObjVal? "r" >>= Json.getNat?
        pure (.strlit bs r)
    | "index" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let i ← j.getObjVal? "i" >>= exprFromJson fuel
        match j.getObjVal? "t" with
        | Except.ok tj => do
            let t ← tyFromJson fuel tj
            pure (.index e i (Option.some t))
        | Except.error _ => pure (.index e i)
    | "len" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.lenE e)
    | "flit" => do
        let n ← j.getObjVal? "n" >>= Json.getInt?
        pure (.flit n)
    | "fadd" | "fsub" | "fmul" | "fdiv" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        let op : FArithOp := match k with
          | "fadd" => .add | "fsub" => .sub | "fmul" => .mul | _ => .div
        pure (.farith op a b)
    | "feq" | "fne" | "flt" | "fle" | "fgt" | "fge" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        let op : FCmpOp := match k with
          | "feq" => .eq | "fne" => .ne | "flt" => .lt | "fle" => .le | "fgt" => .gt | _ => .ge
        pure (.fcmp op a b)
    | "fneg" | "fsqrt" | "tofloat" | "ftoint" | "fbits" | "ffrombits" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let op : FConvOp := match k with
          | "fneg" => .neg | "fsqrt" => .sqrt | "tofloat" => .ofInt | "ftoint" => .toInt
          | "fbits" => .bits | _ => .fromBits
        pure (.fconv op e)
    | "tobyte" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.tobyte e)
    | "toint" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.toint e)
    | "append" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let v ← j.getObjVal? "v" >>= exprFromJson fuel
        pure (.append e v)
    | "setidx" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let i ← j.getObjVal? "i" >>= exprFromJson fuel
        let v ← j.getObjVal? "v" >>= exprFromJson fuel
        pure (.setidx e i v)
    | "subslice" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let sa ← j.getObjVal? "a" >>= exprFromJson fuel
        let sb ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.subslice e sa sb)
    | "eqs" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.eqs a b)
    | "concat" => do
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let b ← j.getObjVal? "b" >>= exprFromJson fuel
        pure (.concat a b)
    | "mkmap" => do
        let m ← j.getObjVal? "m" >>= Json.getBool?
        let c ← match j.getObjVal? "cell" with
          | .ok c => tyFromJson fuel c
          | .error _ => do
            let k ← j.getObjVal? "key" >>= tyFromJson fuel
            let t ← j.getObjVal? "t" >>= tyFromJson fuel
            pure (Ty.prod k (.opt t))
        match j.getObjVal? "r" with
        | .ok rj => pure (.mkmapAt m c (← rj.getNat?))
        | .error _ => pure (.mkmap m c)
    | "getm" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let kk ← j.getObjVal? "key" >>= exprFromJson fuel
        pure (.getm t e kk)
    | "setm" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let kk ← j.getObjVal? "key" >>= exprFromJson fuel
        let v ← j.getObjVal? "v" >>= exprFromJson fuel
        pure (.setm e kk v)
    | "delm" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        let kk ← j.getObjVal? "key" >>= exprFromJson fuel
        pure (.delm t e kk)
    | "lenm" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.lenm e)
    | "keysm" => do
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.keysm e)
    | "par" => do
        let e1 ← j.getObjVal? "e1" >>= exprFromJson fuel
        let e2 ← j.getObjVal? "e2" >>= exprFromJson fuel
        pure (.par e1 e2)
    | "parch" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let e1 ← j.getObjVal? "e1" >>= exprFromJson fuel
        let e2 ← j.getObjVal? "e2" >>= exprFromJson fuel
        pure (.parch t e1 e2)
    | "newchan" => do
        let rc ← j.getObjVal? "rc" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.newchan rc t)
    | "send" => do
        let c ← j.getObjVal? "c" >>= exprFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.send c e)
    | "recv" => do
        let c ← j.getObjVal? "c" >>= exprFromJson fuel
        pure (.recv c)
    | "close" => do
        let c ← j.getObjVal? "c" >>= exprFromJson fuel
        pure (.close c)
    | "scope" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let ε ← j.getObjVal? "eps" >>= tyFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.scope t ε e)
    | "spawn" => do
        let sc ← j.getObjVal? "s" >>= exprFromJson fuel
        let a ← j.getObjVal? "a" >>= exprFromJson fuel
        let e ← j.getObjVal? "e" >>= exprFromJson fuel
        pure (.spawn sc a e)
    | "join" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let h ← j.getObjVal? "h" >>= exprFromJson fuel
        pure (.join t h)
    | "try" => do
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        let h ← j.getObjVal? "h" >>= exprFromJson fuel
        pure (.tryJ t h)
    | "newch" => do
        let r ← j.getObjVal? "r" >>= Json.getNat?
        let cap ← j.getObjVal? "cap" >>= Json.getNat?
        let t ← j.getObjVal? "t" >>= tyFromJson fuel
        pure (.newch r cap t)
    | other => .error s!"exprFromJson: unknown kind {other}"

/-- 入力テキストからのパース。燃料は入力長で必ず足りる（1 ノード ≥ 数文字） -/
def parseExpr (input : String) : Except String Expr := do
  let j ← Json.parse input
  exprFromJson (input.length + 1) j

/-- 関数定義 → JSON: `{"param":T,"ret":T,"body":E}` -/
def defToJson (d : Def) : Json :=
  if d.tparams = 0 then
    Json.mkObj [("param", tyToJson d.param), ("ret", tyToJson d.ret), ("body", exprToJson d.body)]
  else
    Json.mkObj [("tparams", (d.tparams : Nat)), ("param", tyToJson d.param), ("ret", tyToJson d.ret),
      ("body", exprToJson d.body)]

def defFromJson (fuel : Nat) (j : Json) : Except String Def := do
  let param ← j.getObjVal? "param" >>= tyFromJson fuel
  let ret ← j.getObjVal? "ret" >>= tyFromJson fuel
  let body ← j.getObjVal? "body" >>= exprFromJson fuel
  let tparams := (j.getObjValAs? Nat "tparams").toOption.getD 0
  pure { param := param, ret := ret, body := body, tparams := tparams }

/-- プログラム → JSON: `{"defs":[D...],"e":E}`。素の式（defs なし）も受ける（後方互換） -/
def programToJson (Δ : Defs) (e : Expr) : Json :=
  Json.mkObj [("defs", Json.arr (Δ.map defToJson).toArray), ("e", exprToJson e)]

def programFromJson (fuel : Nat) (j : Json) : Except String (Defs × Expr) := do
  match j.getObjVal? "defs" with
  | .ok jdefs => do
      let arr ← jdefs.getArr?
      let defs ← arr.toList.mapM (defFromJson fuel)
      let e ← j.getObjVal? "e" >>= exprFromJson fuel
      pure (defs, e)
  | .error _ => do
      let e ← exprFromJson fuel j
      pure ([], e)

/-- 入力テキストからのパース。燃料は入力長で必ず足りる -/
def parseProgram (input : String) : Except String (Defs × Expr) := do
  let j ← Json.parse input
  programFromJson (input.length + 1) j

/-- 検査結果の JSON。errors はリスト形（診断が育つ余地）。
関数表は checkDefs（DefsOk の checker 版）を先に通す -/
def checkToJson (Δ : Defs) (e : Expr) : Json :=
  if checkDefs Δ then
    match typecheck Δ ∅ [] 0 0 0 [] [] e with
    | some t => Json.mkObj [("ok", true), ("ty", tyToJson t)]
    | none => Json.mkObj [("ok", false),
        ("errors", Json.arr #[Json.mkObj [("msg", "type error")]])]
  else Json.mkObj [("ok", false),
    ("errors", Json.arr #[Json.mkObj [("msg", "def error")]])]

/-- 部分検査の Def（V5-6 = I-3）: `body` の無い Def は**署名だけ**（interface から読んだ他 package の関数）。
本体には triv を置き、検査しない（Split.lean の checkDefsAt の枠）。返す Bool = 本体を持つ（検査する）か -/
def defPartFromJson (fuel : Nat) (j : Json) : Except String (Def × Bool) := do
  let param ← j.getObjVal? "param" >>= tyFromJson fuel
  let ret ← j.getObjVal? "ret" >>= tyFromJson fuel
  let tparams := (j.getObjValAs? Nat "tparams").toOption.getD 0
  match j.getObjVal? "body" with
  | .ok jb => do
      let body ← exprFromJson fuel jb
      pure ({ param := param, ret := ret, body := body, tparams := tparams }, true)
  | .error _ => pure ({ param := param, ret := ret, body := .triv, tparams := tparams }, false)

/-- 部分検査の封筒: `{"parts":true,"defs":[D...],"e":E}`。e は省略できる（main 以外の package — 根の式が無い） -/
def partsFromJson (fuel : Nat) (j : Json) : Except String (Defs × List Bool × Option Expr) := do
  let arr ← j.getObjVal? "defs" >>= Json.getArr?
  let ds ← arr.toList.mapM (defPartFromJson fuel)
  let e ← match j.getObjVal? "e" with
    | .ok je => some <$> exprFromJson fuel je
    | .error _ => pure none
  pure (ds.map Prod.fst, ds.map Prod.snd, e)

/-- 部分検査の結果。本体を持つ Def だけを checkDefsAt で検査する — 受理すれば、署名の一致する全体の表の下で
その Def は DefsOk の条件を満たす（defOk_of_checkAt）。package ごとの受理の合成は defsOk_of_parts -/
def checkPartsToJson (Δ : Defs) (mask : List Bool) (eo : Option Expr) : Json :=
  if checkDefsAt Δ (fun i => mask.getD i false) then
    match eo with
    | none => Json.mkObj [("ok", true)]
    | some e =>
      match typecheck Δ ∅ [] 0 0 0 [] [] e with
      | some t => Json.mkObj [("ok", true), ("ty", tyToJson t)]
      | none => Json.mkObj [("ok", false),
          ("errors", Json.arr #[Json.mkObj [("msg", "type error")]])]
  else Json.mkObj [("ok", false),
    ("errors", Json.arr #[Json.mkObj [("msg", "def error")]])]

/-- 入力テキスト → 判定 JSON（バイナリの本体。パース失敗も同じ形で返す）。
`"parts":true` の封筒は部分検査（V5-6）、それ以外は従来の全体検査 -/
def checkInput (input : String) : Json :=
  let parseErr (msg : String) := Json.mkObj [("ok", false),
      ("errors", Json.arr #[Json.mkObj [("msg", s!"parse error: {msg}")]])]
  match Json.parse input with
  | .error msg => parseErr msg
  | .ok j =>
    match j.getObjValAs? Bool "parts" with
    | .ok true =>
      match partsFromJson (input.length + 1) j with
      | .ok (Δ, mask, eo) => checkPartsToJson Δ mask eo
      | .error msg => parseErr msg
    | _ =>
      match programFromJson (input.length + 1) j with
      | .ok (Δ, e) => checkToJson Δ e
      | .error msg => parseErr msg

end FS.JsonBoundary
