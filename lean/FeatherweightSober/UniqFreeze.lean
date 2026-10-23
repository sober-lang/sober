import FeatherweightSober.Syntax

/-!
# uniqFreeze — 凍結の一意性の述語（F-al の修理 — language.md 17 節 U1〜U3・formal.md の改定 2026-10-10）

実行できる述語（証明の対象ではない — Checker の外）。コア AST の上の抽象解釈で、次のどれかが起こりうるなら偽:

- 凍結した buffer への書き（setidx / setm / delm — freeze の後の書き。古い別名・欄・ループの次の周回を含む）
- 凍結した buffer に届く mut のセルを callM へ渡す（呼び先が書きうる）
- Def の中で、仮引数（呼び手の持ち物）の buffer を freeze する（U1 の仮引数）
- Def の mut の仮引数の buffer が戻り値で呼び出しを越えて逃げる（U3 の戻り値の側 — 別の仮引数への逃げはコアで仮引数の境目が
  残らないので表層の analyzer だけが見る。その分この述語は analyzer より弱い — 照合の向き analyzer ⊆ uniqFreeze は保たれる）

抽象値: buffer の id の集合（slice / map のヘッダの届き先）・直積の組・セルの id の集合（alloc / mut の仮引数）。
buffer の中身（要素の中の buffer）は別の表 contents に持つ — 要素の読み（index / getm）は中身を返す（スカラーの要素は空）。
セルは強い更新（届き先が 1 つのとき）。ループは体を 2 回評価する（1 周目の freeze が 2 周目の書きに届く形を見る — 不動点は取らない）。
分岐は合流（セルの中身・中身の表・凍結の集合の合併）。jump はラベルの出口へ状態を運ぶ。

照合（scripts/uniqfreeze.sh）: Sober の analyzer が受理したプログラムは、この述語も真であること（analyzer ⊆ uniqFreeze）。
analyzer は表層で U1 を「別名があれば拒否」と強く取るので、逆向きの食い違い（analyzer 拒否・ここは真）は想定内。
定理「型が付き uniqFreeze が真なら、機械は凍結済みのセルへ書かない」は積み（PINS — L-B）。
-/

namespace FS.Uniq

open FS

/-- 抽象値 -/
inductive AV where
  | bufs (s : List Nat)
  | pair (a b : AV)
  | refs (cs : List Nat)
  deriving Repr, Inhabited

def union (a b : List Nat) : List Nat := a ++ b.filter (fun x => !a.contains x)

def AV.allBufs : AV → List Nat
  | .bufs s => s
  | .pair a b => union a.allBufs b.allBufs
  | .refs _ => []

def AV.allRefs : AV → List Nat
  | .bufs _ => []
  | .pair a b => union a.allRefs b.allRefs
  | .refs cs => cs

/-- 合流（形が違えば平らにする） -/
def AV.join : AV → AV → AV
  | .bufs a, .bufs b => .bufs (union a b)
  | .pair a1 b1, .pair a2 b2 => .pair (a1.join a2) (b1.join b2)
  | .refs a, .refs b => .refs (union a b)
  | x, y =>
    let bs := union x.allBufs y.allBufs
    let rs := union x.allRefs y.allRefs
    if rs.isEmpty then .bufs bs else .pair (.bufs bs) (.refs rs)

def AV.fst : AV → AV
  | .pair a _ => a
  | x => x

def AV.snd : AV → AV
  | .pair _ b => b
  | x => x

/-- Def の仮引数の buffer / セルの印（局所の id と衝突しない大きい番号） -/
def paramBase : Nat := 1000000000

/-- 型が buffer（slice / map / ref）を中に持つか — 仮引数の要素の中身の印を付けるかの判断 -/
def hasBuf : Ty → Bool
  | .slice _ _ _ | .map _ _ _ | .ref _ _ _ => true
  | .prod l r | .union l r => hasBuf l || hasBuf r
  | .opt t => hasBuf t
  | _ => false

/-- mut のコンテナ（mut の slice / map・それを持つ struct）か — 呼び先が中身を書きうる型 -/
def mutCont : Ty → Bool
  | .slice m _ _ | .map m _ _ => m
  | .prod l r => mutCont l || mutCont r
  | _ => false

/-- callM の実引数のうち、呼び先が中身を書きうるセル（仮引数の型が `ref mut <mut のコンテナ>` の位置） -/
def mutCells : Ty → AV → List Nat
  | .prod l r, .pair a b => union (mutCells l a) (mutCells r b)
  | .ref m _ inner, v => if m && mutCont inner then v.allRefs else []
  | _, _ => []

structure St where
  cells : List (Nat × AV) := []
  /-- buffer の中身（要素の中の buffer — append / setidx / setm が足す） -/
  contents : List (Nat × List Nat) := []
  frozen : List Nat := []
  next : Nat := 1
  dead : Bool := false
  err : Option String := none
  /-- ラベルごとに jump が運んだ状態（de Bruijn — 0 = 最内） -/
  jumps : List (List St) := []
  /-- Def の mut の仮引数: (セル id, 中身の buffer id) -/
  params : List (Nat × Nat) := []
  /-- Def の mut の仮引数から届く buffer の印（freeze したら U1 違反） -/
  mutIds : List Nat := []
  /-- 関数表（callM の呼び先の仮引数の型 — mut のコンテナのセルだけを見る） -/
  defs : List Def := []
  /-- std の信頼の口の Def（コア JSON の `"trust":true` — std/table.Freeze・std/strings.Clone。U1 の仮引数・U3 を見ない — language.md 17 節） -/
  trusted : Bool := false
  deriving Inhabited

def St.cell (s : St) (c : Nat) : AV :=
  match s.cells.find? (fun p => p.1 == c) with
  | some p => p.2
  | none => .bufs []

def St.setCell (s : St) (c : Nat) (v : AV) : St :=
  { s with cells := (c, v) :: s.cells.filter (fun p => p.1 != c) }

def St.cont (s : St) (b : Nat) : List Nat :=
  match s.contents.find? (fun p => p.1 == b) with
  | some p => p.2
  | none => []

def St.addCont (s : St) (bs xs : List Nat) : St :=
  if xs.isEmpty then s else
  bs.foldl (fun s b => { s with contents := (b, union (s.cont b) xs) :: s.contents.filter (fun p => p.1 != b) }) s

def St.fail (s : St) (msg : String) : St :=
  match s.err with
  | some _ => s
  | none => { s with err := some msg }

def St.fresh (s : St) : Nat × St := (s.next, { s with next := s.next + 1 })

/-- ヘッダの届き先（セルの中身を辿る — 深さ 4 まで） -/
def hdr (s : St) : Nat → AV → List Nat
  | 0, v => v.allBufs
  | n + 1, v => v.allRefs.foldl (fun acc c => union acc (hdr s n (s.cell c))) v.allBufs

/-- 中身の閉包（深さ 4 まで） -/
def deep (s : St) : Nat → List Nat → List Nat
  | 0, bs => bs
  | n + 1, bs => union bs (deep s n (bs.foldl (fun acc b => union acc (s.cont b)) []))

def H (s : St) (v : AV) : List Nat := hdr s 4 v
def D (s : St) (v : AV) : List Nat := deep s 4 (H s v)

def St.joinSt (a b : St) : St :=
  if a.dead then { b with err := a.err <|> b.err, next := max a.next b.next }
  else if b.dead then { a with err := a.err <|> b.err, next := max a.next b.next }
  else
    let cs := (a.cells.map (·.1)) ++ (b.cells.map (·.1)).filter (fun c => !(a.cells.any (·.1 == c)))
    let ks := (a.contents.map (·.1)) ++ (b.contents.map (·.1)).filter (fun c => !(a.contents.any (·.1 == c)))
    { a with
      cells := cs.map (fun c => (c, (a.cell c).join (b.cell c)))
      contents := ks.map (fun k => (k, union (a.cont k) (b.cont k)))
      frozen := union a.frozen b.frozen
      next := max a.next b.next
      err := a.err <|> b.err }

/-- Def の仮引数の型から抽象値を作る（ref → 仮引数のセル・slice / map → 仮引数の buffer。中身は別の印） -/
partial def paramAV (t : Ty) (k : Nat) (s : St) : AV × Nat × St :=
  match t with
  | .prod l r =>
    let (a, k, s) := paramAV l k s
    let (b, k, s) := paramAV r k s
    (.pair a b, k, s)
  | .ref m _ inner =>
    let c := paramBase + 3 * k
    let b := paramBase + 3 * k + 1
    let s := s.setCell c (.bufs [b])
    let ci := paramBase + 3 * k + 2
    let s := match inner with
      | .slice _ _ t | .map _ _ t => if hasBuf t then s.addCont [b] [ci] else s
      | .prod _ _ => s.addCont [b] [ci]
      | _ => s
    let s := if m && hasBuf inner then
      { s with params := (c, b) :: s.params, mutIds := b :: ci :: s.mutIds } else s
    (.refs [c], k + 1, s)
  | .slice _ _ t | .map _ _ t =>
    let b := paramBase + 3 * k + 1
    (.bufs [b], k + 1, if hasBuf t then s.addCont [b] [paramBase + 3 * k + 2] else s)
  | _ => (.bufs [], k, s)

partial def ev (env : List AV) (e : Expr) (s : St) : AV × St :=
  if s.dead || s.err.isSome then (.bufs [], s) else
  match e with
  | .lit _ | .tt | .ff | .triv | .nil _ | .fnref _ _ | .unreach _ | .blit _ | .flit _ | .newchan _ _ | .newch _ _ _
  | .strlit _ _ => (.bufs [], s)
  | .var i => (env.getD i (.bufs []), s)
  | .letE a body =>
    let (v, s) := ev env a s
    ev (v :: env) body s
  | .add a b | .lt a b | .arith _ a b | .cmp _ a b | .farith _ a b | .fcmp _ a b | .eqs a b =>
    let (_, s) := ev env a s
    let (_, s) := ev env b s
    (.bufs [], s)
  | .ite c t f =>
    let (_, s) := ev env c s
    let (vt, st) := ev env t s
    let (vf, sf) := ev env f { s with next := st.next }
    (vt.join vf, st.joinSt sf)
  | .some a | .inl _ a | .inr _ a | .ann a _ | .block a | .blockR _ a | .copyTo _ _ a | .tobyte a | .toint a | .fconv _ a =>
    ev env a s
  | .ifnil a n sm =>
    let (v, s) := ev env a s
    let (vn, sn) := ev env n s
    let (vs, ss) := ev (v :: env) sm { s with next := sn.next }
    (vn.join vs, sn.joinSt ss)
  | .case a l r =>
    let (v, s) := ev env a s
    let (vl, sl) := ev (v :: env) l s
    let (vr, sr) := ev (v :: env) r { s with next := sl.next }
    (vl.join vr, sl.joinSt sr)
  | .pair a b =>
    let (va, s) := ev env a s
    let (vb, s) := ev env b s
    (.pair va vb, s)
  | .fst a => let (v, s) := ev env a s; (v.fst, s)
  | .snd a => let (v, s) := ev env a s; (v.snd, s)
  | .call _ _ a =>
    -- 実引数は loc-free（呼び先は mut を書けない）— 結果は実引数の届き先か新しい buffer
    let (v, s) := ev env a s
    let (b, s) := s.fresh
    (.bufs (union (D s v) [b]), s)
  | .callv f a =>
    let (_, s) := ev env f s
    let (v, s) := ev env a s
    let (b, s) := s.fresh
    (.bufs (union (D s v) [b]), s)
  | .callMv _ f a =>
    -- anchor つきの関数値の呼び出し（L1）: 閉包の env の mut のセル（借りの mut の捕捉）を呼び先が書きうる — 呼び先の Def は
    -- 静的に分からないので、実引数の届くセル全部を書きうるとみなす（callM の保守側）
    let (_, s) := ev env f s
    let (v, s) := ev env a s
    let s := if (D s (.refs v.allRefs)).any (fun b => s.frozen.contains b) then
      s.fail "callMv: a captured mut reaches a frozen buffer" else s
    let s := v.allRefs.foldl (fun s c => let (b, s) := s.fresh; s.setCell c ((s.cell c).join (.bufs [b]))) s
    let (b, s) := s.fresh
    (.bufs (union (deep s 4 v.allBufs) [b]), s)
  | .callM fn _ a =>
    let (v, s) := ev env a s
    -- 呼び先は mut の実引数のセル（仮引数の型が mut のコンテナの位置）を書きうる: 凍結した buffer に届くなら拒否（U2 の mut 渡し）。
    -- imm の欄（string のゼロ値 = 凍結した空の slice 等）から届く凍結は書かれない
    let wc := match s.defs[fn]? with
      | some d => mutCells d.param v
      | none => v.allRefs
    let s := if (D s (.refs wc)).any (fun b => s.frozen.contains b) then
      s.fail "callM: a mut argument reaches a frozen buffer" else s
    -- 呼び先はセルを差し替えうる（新しい buffer — U3 で他の仮引数の中身は入らない）
    let s := v.allRefs.foldl (fun s c => let (b, s) := s.fresh; s.setCell c ((s.cell c).join (.bufs [b]))) s
    let (b, s) := s.fresh
    -- 結果: U3 で mut の仮引数の中身は返らない — imm の実引数の届き先か新しい buffer
    (.bufs (union (deep s 4 v.allBufs) [b]), s)
  | .label _ a =>
    let s0 := { s with jumps := [] :: s.jumps }
    let (v, s1) := ev env a s0
    let js := s1.jumps.headD []
    let outer := s1.jumps.tail
    let s1 := { s1 with jumps := outer }
    let out := js.foldl (fun acc j => acc.joinSt { j with jumps := outer, dead := false }) s1
    -- 本体が jump で終わっても、出口は合流した状態（どれかの道が生きていれば生きている）
    let out := if js.isEmpty then out else { out with dead := s1.dead && false }
    (v, { out with jumps := outer })
  | .jump n _ a =>
    let (_, s) := ev env a s
    let js := s.jumps.set n (s :: s.jumps.getD n [])
    (.bufs [], { s with jumps := js, dead := true })
  | .alloc _ a =>
    let (v, s) := ev env a s
    let (c, s) := s.fresh
    (.refs [c], s.setCell c v)
  | .deref a =>
    let (v, s) := ev env a s
    (v.allRefs.foldl (fun acc c => acc.join (s.cell c)) (.bufs []), s)
  | .assign l a =>
    let (vl, s) := ev env l s
    let (v, s) := ev env a s
    let cs := vl.allRefs
    -- U3 の「別の仮引数への逃げ」はコアでは見ない（mut の struct の仮引数は欄ごとのセルに割れ、仮引数の境目が残らない —
    -- 同じ仮引数の欄どうしの別名〔std/builder の seed〕と区別できない）。表層の analyzer が見る。ここは戻り値の逃げだけ
    let s := match cs with
      | [c] => s.setCell c v
      | _ => cs.foldl (fun s c => s.setCell c ((s.cell c).join v)) s
    (.bufs [], s)
  | .whileE c b =>
    -- 体を 2 回（1 周目の freeze が 2 周目の書きに届く形）
    let (_, s1) := ev env c s
    let (_, s2) := ev env b s1
    let s2 := s1.joinSt { s2 with dead := false }
    let (_, s3) := ev env c s2
    let (_, s4) := ev env b s3
    (.bufs [], s3.joinSt { s4 with dead := false })
  | .freeze a =>
    let (v, s) := ev env a s
    let bs := D s v
    let s := if !s.trusted && bs.any (fun b => s.mutIds.contains b) then s.fail "U1: freeze of a parameter's contents" else s
    (v, { s with frozen := union s.frozen bs })
  | .mkslice _ _ | .mksliceAt _ _ _ | .mkmap _ _ | .mkmapAt _ _ _ =>
    let (b, s) := s.fresh
    (.bufs [b], s)
  | .index a i _ =>
    let (v, s) := ev env a s
    let (_, s) := ev env i s
    (.bufs ((H s v).foldl (fun acc b => union acc (s.cont b)) []), s)
  | .getm _ a k =>
    let (v, s) := ev env a s
    let (_, s) := ev env k s
    (.bufs ((H s v).foldl (fun acc b => union acc (s.cont b)) []), s)
  | .lenE a | .lenm a | .recv a | .close a =>
    let (_, s) := ev env a s
    (.bufs [], s)
  | .keysm a =>
    let (v, s) := ev env a s
    let (b, s) := s.fresh
    let ks := (H s v).foldl (fun acc x => union acc (s.cont x)) []
    (.bufs [b], s.addCont [b] ks)
  -- clone: 新しい buffer（元の buffer の別名にならない — freeze の呼び出しの結果と同じく根を張らない）。中身（要素の buffer）は共有する（浅い写し）
  | .clone _ a =>
    let (v, s) := ev env a s
    let (b, s) := s.fresh
    let ks := (H s v).foldl (fun acc x => union acc (s.cont x)) []
    (.bufs [b], s.addCont [b] ks)
  | .concat x y =>
    let (_, s) := ev env x s
    let (_, s) := ev env y s
    let (b, s) := s.fresh
    (.bufs [b], s)
  | .subslice a x y =>
    let (v, s) := ev env a s
    let (_, s) := ev env x s
    let (_, s) := ev env y s
    (v, s)
  | .append a x =>
    let (va, s) := ev env a s
    let (vx, s) := ev env x s
    -- その場で伸びれば同じ buffer（凍結した範囲の外への書き — 可）。伸びなければ新しい buffer（中身は写る）
    let (b, s) := s.fresh
    let hs := union (H s va) [b]
    let ks := hs.foldl (fun acc y => union acc (s.cont y)) []
    let s := s.addCont [b] ks
    let s := s.addCont hs (H s vx)
    (.bufs hs, s)
  | .setidx a i x =>
    let (va, s) := ev env a s
    let (_, s) := ev env i s
    let (vx, s) := ev env x s
    let s := if (H s va).any (fun b => s.frozen.contains b) then s.fail "U2: write (setidx) to a frozen buffer" else s
    (.bufs [], s.addCont (H s va) (H s vx))
  | .setm a k x =>
    let (va, s) := ev env a s
    let (_, s) := ev env k s
    let (vx, s) := ev env x s
    let s := if (H s va).any (fun b => s.frozen.contains b) then s.fail "U2: write (setm) to a frozen map" else s
    let (b, s) := s.fresh
    let hs := union (H s va) [b]
    let ks := hs.foldl (fun acc y => union acc (s.cont y)) []
    let s := s.addCont [b] ks
    (.bufs hs, s.addCont hs (H s vx))
  | .delm _ a k =>
    let (va, s) := ev env a s
    let (_, s) := ev env k s
    let s := if (H s va).any (fun b => s.frozen.contains b) then s.fail "U2: write (delm) to a frozen map" else s
    (.bufs [], s)
  | .send c a =>
    let (_, s) := ev env c s
    let (_, s) := ev env a s
    (.bufs [], s)
  | .par a b =>
    let (_, s) := ev env a s
    let (_, s) := ev env b s
    (.bufs [], s)
  | .parch _ a b =>
    let (_, s) := ev (.bufs [] :: env) a s
    let (_, s) := ev (.bufs [] :: env) b s
    (.bufs [], s)
  | .scope _ _ a =>
    ev (.bufs [] :: env) a s
  | .spawn sc a body =>
    let (_, s) := ev env sc s
    let (va, s) := ev env a s
    -- 子の本体は閉じている（var 0 = 渡す値だけ）。子の書きも同じ凍結の集合で見る
    let (_, sk) := ev [va] body { s with jumps := [] }
    (.bufs [], { s with err := s.err <|> sk.err, next := sk.next })
  | .join _ h | .tryJ _ h =>
    let (_, s) := ev env h s
    let (b, s) := s.fresh
    (.bufs [b], s)
  | .loc _ _ | .slicev _ _ _ _ | .mapv _ _ _ _ | .chanV _ | .scopeV _ _ | .taskV _ _ | .epV _ _ _ _ =>
    (.bufs [], s)

/-- Def 1 本: 仮引数の抽象値で本体を評価し、U1（仮引数の freeze）・U3（戻り値への mut の仮引数の中身）を見る -/
def checkDef (Δ : Defs) (d : Def) (trusted : Bool := false) : Option String :=
  let (pv, _, s0) := paramAV d.param 0 { defs := Δ, trusted := trusted }
  let (v, s) := ev [pv] d.body s0
  match s.err with
  | some m => some m
  | none =>
    let own := s.params.map (·.2)
    if !trusted && (D s v).any (fun b => own.contains b) then some "U3: a mut parameter's contents escape through the result"
    else none

/-- プログラム: 本体を持つ Def 全部（mask）と main の式。none = 真（受理）・some (理由, Def の添字〔main = -1〕) = 偽 -/
def check (Δ : Defs) (mask : Nat → Bool) (e : Option Expr) (trust : Nat → Bool := fun _ => false) : Option (String × Int) :=
  let rec go : List Def → Nat → Option (String × Int)
    | [], _ => none
    | d :: ds, i =>
      if mask i then
        match checkDef Δ d (trust i) with
        | some m => some (m, (i : Int))
        | none => go ds (i + 1)
      else go ds (i + 1)
  match go Δ 0 with
  | some r => some r
  | none =>
    match e with
    | none => none
    | some e =>
      let (_, s) := ev [] e { defs := Δ }
      s.err.map (fun m => (m, -1))

end FS.Uniq
