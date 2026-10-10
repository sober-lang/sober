import Lean
import FeatherweightSober.TcStep

/-!
# 抽出の設定（Lean → Sober 抽出器・E1）

1 ファイルに 3 つ: 抽出する定義の一覧・構成子の対応表（Lean の inductive → Sober の表の記録）・前奏（抽出物が呼ぶ小さな関数）。
写し先の表現は compiler/checker/ty.sober と同じ（型 = 番地、`tg` / `tA` / `tB` / `tC` で読み、`mk` で作る。List Ty = st.h の `[n, t…]`（-1 = 空））。
-/

namespace Extract

open Lean

/-- 構成子 → Sober のタグ定数と、欄ごとの読み出し関数（欄の順 = 構成子の引数の順） -/
def ctorTable : List (Name × String × List String) :=
  [ (``FS.Ty.int, "TInt", []), (``FS.Ty.tvar, "TVar", ["tA"]), (``FS.Ty.bool, "TBool", []),
    (``FS.Ty.byte, "TByte", []), (``FS.Ty.f64, "TF64", []), (``FS.Ty.unit, "TUnit", []),
    (``FS.Ty.opt, "TOpt", ["tA"]), (``FS.Ty.union, "TUn", ["tA", "tB"]), (``FS.Ty.prod, "TPr", ["tA", "tB"]),
    (``FS.Ty.ref, "TRef", ["tA", "tB", "tC"]), (``FS.Ty.slice, "TSl", ["tA", "tB", "tC"]),
    (``FS.Ty.map, "TMp", ["tA", "tB", "tC"]), (``FS.Ty.chan, "TChan", ["tA", "tB"]),
    (``FS.Ty.fn, "TFn", ["tA", "tB"]), (``FS.Ty.own, "TOwn", ["tA", "tB", "tC"]) ]

/-- 欄を持たない列挙の inductive の構成子 → Sober の整数の式（記録の欄に整数で入る — Ty.own の種類 = ty.sober の TOwn の a。
FConvOp は式の語の番号 — fconv の式の kind がそのまま op） -/
def enumTable : List (Name × String) :=
  [ (``FS.OwnK.scope, "0"), (``FS.OwnK.task, "1"), (``FS.OwnK.tx, "2"), (``FS.OwnK.rx, "3"),
    (``FS.FConvOp.neg, "W_FNEG"), (``FS.FConvOp.sqrt, "W_FSQRT"), (``FS.FConvOp.ofInt, "W_TOFLOAT"),
    (``FS.FConvOp.toInt, "W_FTOINT"), (``FS.FConvOp.bits, "W_FBITS"), (``FS.FConvOp.fromBits, "W_FFROMBITS") ]

/-- 列挙の inductive（Sober では int） -/
def enumTypes : List Name := [``FS.OwnK, ``FS.FConvOp]

/-! ## typecheck の 1 フレームの遷移（段 6 P2b — tc_gen.sober）

式（Expr）は記録でなく **節**: st.h の 5 語 [kind, nc, a, b, c]（json.sober — kind = 語の番号）。構成子ごとに
（kind の判定・switch の case の札・欄の読み出し）を対応表に書く。`@` = 節の番地。札が無い構成子は実行時だけの形
（境界の語彙に無い — 写さない。switch の外れ = `nodeDefault`）。判定の「 &&& 」の後ろは同じ札の中で分かれる追加の条件。 -/

/-- 節（番地で持つ・パターンで分かれる）の inductive -/
def nodeTypes : List Name := [``FS.Expr]

def nodeTable : List (Name × String × Option String × List String) :=
  let k := "nK(mut st, @)"
  let a := "nA(mut st, @)"
  let b := "nB(mut st, @)"
  let c := "nC(mut st, @)"
  let is (w : String) := s!"{k} == {w}"
  let one (n : Name) (w : String) (fs : List String) := (n, is w, some w, fs)
  let rng (n : Name) (lo hi : String) (ws : List String) (fs : List String) :=
    (n, s!"{k} >= {lo} && {k} <= {hi}", some (" | ".intercalate ws), fs)
  let rt (n : Name) (m : Nat) := (n, "false", none, List.replicate m "0")
  [ one ``FS.Expr.lit "W_LIT" [a], one ``FS.Expr.flit "W_FLIT" [a], one ``FS.Expr.tt "W_TRUE" [],
    one ``FS.Expr.ff "W_FALSE" [], one ``FS.Expr.triv "W_TRIV" [], one ``FS.Expr.var "W_VAR" [a],
    one ``FS.Expr.letE "W_LET" [a, b], one ``FS.Expr.add "W_ADD" [a, b], one ``FS.Expr.lt "W_LT" [a, b],
    rng ``FS.Expr.arith "W_SUB" "W_SHR" ["W_SUB", "W_MUL", "W_DIV", "W_MOD", "W_AND", "W_OR", "W_XOR", "W_SHL", "W_SHR"] [k, a, b],
    rng ``FS.Expr.cmp "W_EQ" "W_GE" ["W_EQ", "W_NE", "W_LE", "W_GT", "W_GE"] [k, a, b],
    one ``FS.Expr.ite "W_IF" [a, b, c], one ``FS.Expr.nil "W_NIL" [a], one ``FS.Expr.some "W_SOME" [a],
    one ``FS.Expr.ifnil "W_IFNIL" [a, b, c], one ``FS.Expr.inl "W_INL" [a, b], one ``FS.Expr.inr "W_INR" [a, b],
    one ``FS.Expr.case "W_CASE" [a, b, c], one ``FS.Expr.pair "W_PAIR" [a, b], one ``FS.Expr.fst "W_FST" [a],
    one ``FS.Expr.snd "W_SND" [a], one ``FS.Expr.call "W_CALL" [a, b, c], one ``FS.Expr.callM "W_CALLM" [a, b, c],
    one ``FS.Expr.fnref "W_FNREF" [a, b], one ``FS.Expr.callv "W_CALLV" [a, b], one ``FS.Expr.ann "W_ANN" [a, b],
    one ``FS.Expr.block "W_BLOCK" [a], one ``FS.Expr.blockR "K_BLOCKR" [b, a], one ``FS.Expr.copyTo "W_COPYTO" [c, b, a],
    one ``FS.Expr.label "W_LABEL" [a, b], one ``FS.Expr.jump "W_JUMP" [a, b, c], one ``FS.Expr.unreach "W_UNREACH" [a],
    one ``FS.Expr.alloc "W_ALLOC" [a, b], one ``FS.Expr.deref "W_DEREF" [a], one ``FS.Expr.assign "W_ASSIGN" [a, b],
    one ``FS.Expr.whileE "W_WHILE" [a, b], one ``FS.Expr.freeze "W_FREEZE" [a],
    (``FS.Expr.mkslice, s!"{k} == W_MKSLICE &&& {c} == 0", some "W_MKSLICE", [a, b]),
    one ``FS.Expr.strlit "W_STRLIT" ["0", a],
    (``FS.Expr.mksliceAt, s!"{k} == W_MKSLICE &&& {c} > 0", some "W_MKSLICE", [a, b, s!"({c} - 1)"]),
    (``FS.Expr.mkmapAt, s!"{k} == W_MKMAP &&& {c} > 0", some "W_MKMAP", [a, b, s!"({c} - 1)"]),
    one ``FS.Expr.index "W_INDEX" [a, b, c], one ``FS.Expr.lenE "W_LEN" [a], one ``FS.Expr.tobyte "W_TOBYTE" [a],
    one ``FS.Expr.toint "W_TOINT" [a], rt ``FS.Expr.blit 1,
    rng ``FS.Expr.farith "W_FADD" "W_FDIV" ["W_FADD", "W_FSUB", "W_FMUL", "W_FDIV"] [k, a, b],
    rng ``FS.Expr.fcmp "W_FEQ" "W_FGE" ["W_FEQ", "W_FNE", "W_FLT", "W_FLE", "W_FGT", "W_FGE"] [k, a, b],
    rng ``FS.Expr.fconv "W_FNEG" "W_FFROMBITS" ["W_FNEG", "W_FSQRT", "W_TOFLOAT", "W_FTOINT", "W_FBITS", "W_FFROMBITS"] [k, a],
    one ``FS.Expr.append "W_APPEND" [a, b], one ``FS.Expr.setidx "W_SETIDX" [a, b, c],
    one ``FS.Expr.subslice "W_SUBSLICE" [a, b, c], one ``FS.Expr.eqs "W_EQS" [a, b], one ``FS.Expr.concat "W_CONCAT" [a, b],
    (``FS.Expr.mkmap, s!"{k} == W_MKMAP &&& {c} == 0", some "W_MKMAP", [a, b]),
    one ``FS.Expr.getm "W_GETM" [a, b, c], one ``FS.Expr.setm "W_SETM" [a, b, c], one ``FS.Expr.delm "W_DELM" [a, b, c],
    one ``FS.Expr.lenm "W_LENM" [a], one ``FS.Expr.keysm "W_KEYSM" [a], one ``FS.Expr.par "W_PAR" [a, b],
    one ``FS.Expr.parch "W_PARCH" [a, b, c], one ``FS.Expr.newchan "W_NEWCHAN" [a, b], one ``FS.Expr.send "W_SEND" [a, b],
    one ``FS.Expr.recv "W_RECV" [a], rt ``FS.Expr.loc 2, rt ``FS.Expr.slicev 4, rt ``FS.Expr.mapv 4, rt ``FS.Expr.chanV 1,
    one ``FS.Expr.scope "W_SCOPE" [a, c, b], one ``FS.Expr.spawn "W_SPAWN" [a, b, c], one ``FS.Expr.join "W_JOIN" [a, b],
    one ``FS.Expr.tryJ "W_TRY" [a, b], rt ``FS.Expr.scopeV 2, rt ``FS.Expr.taskV 2,
    one ``FS.Expr.newch "W_NEWCH" [a, b, c], rt ``FS.Expr.epV 4, one ``FS.Expr.close "W_CLOSE" [a] ]

/-- 節の switch の外れ（札の無い構成子 = 実行時だけの形・未知の kind）の戻り値 -/
def nodeDefault : String := "actRet(mut st, 0 - 1)"

/-- 番地で持つ（パターンで分かれない）型 — 関数表の Def・遷移の結果 Act -/
def handleTypes : List Name := [``FS.Def, ``FS.Act]

/-- 写すときに捨てる仮引数の型（Sober では st が持つ — 関数表 Δ は st.defs） -/
def droppedTypes : List Name := [``FS.Defs]

/-- 手書きの読み口（compiler/checker/check.sober — 表現に依存する）。Sober の名前 = 最後の成分。構成子も（Act.sub → actSub） -/
def shimTable : List (Name × String) :=
  [ (``FS.ctxGet, "ctxGet"), (``FS.ctxCons, "ctxCons"), (``FS.ctxAllMutFree, "ctxAllMutFree"), (``FS.lctxTy, "lctxTy"),
    (``FS.lctxK, "lctxK"), (``FS.lctxCons, "lctxCons"), (``FS.defGet, "defGet"), (``FS.defParam, "defParam"),
    (``FS.defRet, "defRet"), (``FS.defTps, "defTps"), (``FS.tsLen, "tsLen"), (``FS.Act.sub, "actSub"), (``FS.Act.ret, "actRet") ]

/-- tc_gen.sober に出す定義（この順） -/
def tcTargets : List Name :=
  [ ``FS.FConvOp.dom, ``FS.FConvOp.cod,
    ``FS.kII, ``FS.kFF, ``FS.kIte, ``FS.kEq2, ``FS.kSome, ``FS.kInl, ``FS.kInr, ``FS.kPair, ``FS.kFst, ``FS.kSnd,
    ``FS.sLet, ``FS.sIfnil1, ``FS.sIfnil2, ``FS.sCase1, ``FS.sCase2, ``FS.kCall, ``FS.kCallM2, ``FS.kCallM, ``FS.kFnref,
    ``FS.kAnn, ``FS.sCallv1, ``FS.kCallv, ``FS.kLabel, ``FS.kJump, ``FS.kBlock, ``FS.kBlockR, ``FS.kScope, ``FS.kCopyTo, ``FS.kAlloc,
    ``FS.kDeref, ``FS.kAssign, ``FS.kWhile, ``FS.kFreeze, ``FS.kMkslice, ``FS.kStrlit, ``FS.kMksliceAt, ``FS.kMkmapAt,
    ``FS.kIndex, ``FS.kLen, ``FS.kTobyte, ``FS.kToint, ``FS.kFconv, ``FS.kAppend, ``FS.kSetidx, ``FS.kSubslice,
    ``FS.kEqs, ``FS.kConcat, ``FS.kMkmap, ``FS.kGetm, ``FS.kSetm, ``FS.kDelm, ``FS.kLenm, ``FS.kKeysm, ``FS.kPar,
    ``FS.kParch, ``FS.kNewchan, ``FS.kSend, ``FS.kRecv, ``FS.kClose, ``FS.sSpawn2, ``FS.kSpawn, ``FS.kNewch, ``FS.kJoin, ``FS.kTry,
    ``FS.tcStep ]

/-- 欄の無い構成子の作り置き（記録を毎回積まない — state.sober の S が起動時に作る。記録は作ったら変えない・等しさは構造で見るので観測等価） -/
def constCtors : List (Name × String) :=
  [ (``FS.Ty.int, "st.tInt"), (``FS.Ty.bool, "st.tBool"), (``FS.Ty.byte, "st.tByte"), (``FS.Ty.f64, "st.tF64"),
    (``FS.Ty.unit, "st.tUnit") ]

/-- 記録へ平らにする inductive（番地で持つ型） -/
def recordTypes : List Name := [``FS.Ty]

/-- 抽出する定義（この順に出す）。Sober の名前は最後の成分（Ty.regionsBelow → regionsBelow） -/
def targets : List Name :=
  [ ``FS.Ty.regionsBelow, ``FS.Ty.mutFree, ``FS.Ty.keyOk, ``FS.Ty.keyCompat, ``FS.Ty.shiftR, ``FS.Ty.relocR,
    ``FS.rmap, ``FS.Ty.renR, ``FS.Ty.relocA, ``FS.Ty.clampR, ``FS.Ty.noClamp, ``FS.Ty.annFree,
    ``FS.Ty.isMut0, ``FS.Ty.mutTop, ``FS.Ty.anchorOf, ``FS.Ty.sub, ``FS.Ty.chanFree, ``FS.Ty.jumpRel,
    ``FS.Ty.readAs, ``FS.Ty.tyArgOk, ``FS.Ty.tyArgsOk, ``FS.Ty.tsubst, ``FS.Ty.tvarsBelow,
    ``FS.Ty.paramOk, ``FS.Ty.retOk, ``FS.Ty.givable, ``FS.Ty.rehome, ``FS.Ty.payOk ]

/-- 近道: 抽出する関数の **定理**（`f パターン… = 右辺` の形 — 方程式でなく証明つきの等式）を、方程式の腕の前に置く腕として出す。
定理なので最初に当てても値は変わらない（観測等価）— 方程式どおりに再帰で作り直す仕事を飛ばす（手書きの写しが持っていた速い道の、定理で正当化した形 — E2） -/
theorem tsubst_nil (t : FS.Ty) : t.tsubst [] = t := by
  induction t <;> simp_all [FS.Ty.tsubst]

def shortcuts : List (Name × Name) := [(``FS.Ty.tsubst, ``Extract.tsubst_nil)]

/-- 構造の等しさ（`deriving DecidableEq`）を生成する inductive と Sober の名前 -/
def eqTargets : List (Name × String) := [(``FS.Ty, "tyEq")]

/-- 前奏（抽出物が呼ぶ。表現に依存するので設定に置く） -/
def prelude : String := "// ── 前奏（Extract/Config.lean の prelude — 抽出物が呼ぶ小さな関数）──

// Nat の引き算（Lean の Nat は 0 で止まる — Sober の int は負になる）
func natSub(a int, b int) int {
    return if a < b { 0 } else { a - b }
}

func natMin(a int, b int) int {
    return if a < b { a } else { b }
}

// Option（Nat / 番地）の or・getD（-1 = none）
func optOr(a int, b int) int {
    return if a >= 0 { a } else { b }
}

func optGetD(a int, d int) int {
    return if a >= 0 { a } else { d }
}

// Bool の欄は 0 / 1 の int
func b2i(b bool) int {
    return if b { 1 } else { 0 }
}

// List Ty（st.h の [n, t…]、-1 = 空）の添字（範囲外 = -1）
func listGet(st mut S, ts int, i int) int {
    return if ts < 0 || i < 0 || i >= table.Get(mut st.h, ts) { 0 - 1 } else { table.Get(mut st.h, ts + 1 + i) }
}

// 構成子の生成（左辺の仮引数 old と同じ構成子を作る場所）: 欄が全部 old と同じなら old をそのまま返す
// （記録は作ったら変えない・等しさは構造で見る — 観測等価。子が変わらなかった型を作り直さない）
func mkLike(st mut S, old int, k int, a int, b int, c int) int {
    x := tyAt(mut st, old)
    return if x.tag == k && x.a == a && x.b == b && x.c == c { old } else { mk(mut st, k, a, b, c) }
}
"

/-- `List.all ts f`（f = 捕捉のない関数参照）の特殊化の雛形。`@F` を関数の呼び出しに置き換える -/
def listAllTemplate : String := "func @NAME(st mut S, ts int) bool {
    if ts < 0 {
        return true
    }
    for i <- iter.Range(0, table.Get(mut st.h, ts)) {
        if !@F(mut st, table.Get(mut st.h, ts + 1 + i)) {
            return false
        }
    }
    return true
}
"

end Extract
