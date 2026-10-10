import FeatherweightSober.Syntax

/-!
# 意味論（段 3c）: フレームスタック機械 + グローバルなチャネルストア

congruence 式 small-step を置き換える。redex 規則（alloc / region の pop）が
「現在の深さ」を知る必要があり、機械ならスタック型付けが深さを局所的に運べる（formal.md 段 2a の裁定）。

- ヒープは region のリスト（レベル = 添字。底が 0、末尾が最内）。
  セルは（実行時 mut タグ, 値）。タグは freeze が倒し、assign が検査する
- `block` は region を push して `regionK` フレームを積み、値が返ると pop（dropLast）
- チャネルストア K は **全タスクで共有する唯一の可変媒体**（タスクのヒープは spawn 時
  コピーで独立）。step が K を編んで通す。ペイロードは loc-free なので値はどの世界でも読める
- send は enqueue（無限バッファ。常に進む）、recv は空キューで待つ（step が none = blocked）
- step は部分関数。型健全性（Soundness.lean）が「well-typed なら none は
  最終状態・panic・recv 待ちのみ」を言う
-/
namespace FS

/-- ヒープ: region レベル → アドレス → (実行時 mut タグ, 格納値)。
タグは段 freeze で実体化: assign が検査し、freeze が倒す -/
abbrev Heap := List (List (Bool × Expr))

/-- 梱包したペイロード（P3b-4b）: 送り手のヒープから 1 region の小さなヒープ（region 0）へ型に沿って写した値 v・そのセル列 cs・
歩いた型 ty（チャネルのペイロード型の relocR 0）。受け手は cs を自分の最内の region へ写して v を付け替える。
操作の結果（Kahn の Op.run）にも使う — チャネルの外の結果は ofV（セルなし） -/
structure Pkt where
  v : Expr
  cs : List (Bool × Expr) := []
  ty : Ty := .unit
  deriving Repr, DecidableEq

def Pkt.ofV (v : Expr) : Pkt := ⟨v, [], .unit⟩

/-- 1 region の小さなヒープの region 0 のセル列 -/
def Heap.r0 : Heap → List (Bool × Expr)
  | c :: _ => c
  | [] => []

/-- 端点のチャネルの項目（段 6 P1）: 待機中の値（先頭が最古 — 梱包したペイロード）・容量（有界 — 満杯の send は待つ）・送り端 / 受け端の持ち主の
task id（持ち主の印 — 引き渡しで子へ書き換わり、親に残った別名は失効する。freeze の古い mut 別名と同じ型の実行時の印）・
ペイロードの型（newch の注釈の relocR 0 — 送りの梱包が歩く型。P3b-4b） -/
structure EpEnt where
  q : List Pkt
  cap : Nat
  otx : List Nat
  orx : List Nat
  ty : Ty
  /-- 閉じた（P3b-4 ③ — close が立てる。以後の送りは panic・空の受けは nil） -/
  closed : Bool := false

/-- チャネルストア: 旧チャネル id → 待機中の値のキュー（先頭が最古）・端点のチャネル（鍵 → 項目の関数 — 挿入の順に依らない） -/
structure ChanSt where
  leg : List (List Expr) := []
  ep : EpKey → Option EpEnt := fun _ => none

instance : EmptyCollection ChanSt := ⟨{}⟩

/-- 旧チャネルだけのストア（例の比較用） -/
def ChanSt.ofLeg (l : List (List Expr)) : ChanSt := ⟨l, fun _ => none⟩

/-- 旧チャネルを 1 本足す -/
def ChanSt.addLeg (K : ChanSt) : ChanSt := { K with leg := K.leg ++ [[]] }

/-- 旧チャネル c のキューを書き換える -/
def ChanSt.setLeg (K : ChanSt) (c : Nat) (q : List Expr) : ChanSt := { K with leg := K.leg.set c q }

/-- 端点のチャネル k の項目を書き換える -/
def ChanSt.setEp (K : ChanSt) (k : EpKey) (e : EpEnt) : ChanSt :=
  { K with ep := fun k' => if k' = k then some e else K.ep k' }

/-- 継続フレーム。評価文脈の 1 層 -/
inductive Frame : Type where
  | letK (b : Expr)
  | addL (b : Expr)
  | addR (a : Expr)
  | ltL (b : Expr)
  | ltR (a : Expr)
  | arithL (op : ArithOp) (b : Expr)
  | arithR (op : ArithOp) (a : Expr)
  | cmpL (op : CmpOp) (b : Expr)
  | cmpR (op : CmpOp) (a : Expr)
  | iteK (t e : Expr)
  | someK
  | ifnilK (n s : Expr)
  | inlK (r : Ty)
  | inrK (l : Ty)
  | caseK (l r : Expr)
  | pairL (b : Expr)
  | pairR (a : Expr)
  | fstK
  /-- 型注釈の中身の評価中。値が戻ったら注釈値を coerceTo で書き換えて返す（V3-5） -/
  | annK (t : Ty)
  | sndK
  /-- 割り当ての値評価中。m は書き込むタグ（物理的にタグを刻むため保持） -/
  | allocK (m : Bool)
  | derefK
  /-- 代入の左辺評価中（右辺 e を保持） -/
  | assignL (e : Expr)
  /-- 代入の右辺評価中（評価済みの参照 l を保持） -/
  | assignR (l : Expr)
  /-- while の条件評価中 -/
  | whileK (c b : Expr)
  /-- while の本体評価中。値が戻ったら捨てて whileE を再評価 -/
  | whileB (c b : Expr)
  /-- region 境界。値が戻ったら最内 region を解放する -/
  | regionK
  /-- 出口で写すブロックの region（R5）: 値が返ると relocTo で親の最内へ写してから pop -/
  | regionKR (t : Ty)
  /-- 境界コピー式（M3）: 値が返ると relocTo k で region k へ写す（region は pop しない） -/
  | copyK (k : Nat) (t : Ty)
  /-- freeze の対象評価中。値（loc）が戻ったらセルのタグを false に倒す -/
  | freezeK
  /-- 送信のチャネル評価中（ペイロード e を保持） -/
  | sendL (e : Expr)
  /-- 送信のペイロード評価中（評価済みのチャネル値 c を保持） -/
  | sendR (c : Expr)
  /-- 受信のチャネル評価中 -/
  | recvK
  /-- close のチャネル評価中（P3b-4 ③） -/
  | closeK
  /-- 呼び出しの引数評価中。値が戻ったら region を push し、シフト + coerce した
  本体に代入して同世界で評価する（round4） -/
  | callK (fn : Nat) (ts : List Ty)
  /-- anchor つき呼び出し（R2）の引数評価中。値が戻ったら anchor（mut 位置の値の region）を読み、
  region 0 をそこへ写した本体を同世界で評価する -/
  | callMK (fn : Nat) (ts : List Ty)
  /-- 関数値呼び出しの関数側評価中（引数 e を保持） -/
  | callvL (e : Expr)
  /-- 関数値呼び出しの引数評価中（評価済みの関数値 fv を保持） -/
  | callvR (fv : Expr)
  /-- 関数の返り境界。値が戻ったら relocate（境界コピー）して region を pop し、
  結果型 t（呼び手座標の relocR）へ coerceTo で注釈を書き換える（R0: opt / union の中の
  コンテナが締まるので、nil / inl / inr の注釈も締めた型に揃える。codegen では恒等） -/
  | fretK (t : Ty)
  /-- index の subject 評価中（添字 i を保持） -/
  | idxL (ot : Option Ty) (i : Expr)
  /-- index の添字評価中（評価済み slice 値を保持） -/
  | idxR (ot : Option Ty) (sv : Expr)
  /-- len の subject 評価中 -/
  | lenK
  /-- byte(e) / int(e) の被演算子評価中（byte の段） -/
  | tobyteK
  | tointK
  /-- float の段: 算術・比較の左右・単項の写しの被演算子評価中 -/
  | farithL (op : FArithOp) (b : Expr)
  | farithR (op : FArithOp) (a : Expr)
  | fcmpL (op : FCmpOp) (b : Expr)
  | fcmpR (op : FCmpOp) (a : Expr)
  | fconvK (op : FConvOp)
  /-- append の subject 評価中（値 v を保持） -/
  | appL (v : Expr)
  /-- append の値評価中（評価済み slice 値を保持） -/
  | appR (sv : Expr)
  /-- setidx の subject 評価中（添字 i と値 v を保持） -/
  | sixL (i v : Expr)
  /-- setidx の添字評価中 -/
  | sixM (sv v : Expr)
  /-- setidx の値評価中 -/
  | sixR (sv iv : Expr)
  /-- subslice の subject 評価中（a b を保持） -/
  | subL (sa sb : Expr)
  /-- subslice の a 評価中 -/
  | subM (sv sb : Expr)
  /-- subslice の b 評価中 -/
  | subR (sv av : Expr)
  /-- eqs の左評価中（右 e2 を保持） -/
  | eqsL (e2 : Expr)
  /-- eqs の右評価中（評価済み左値を保持） -/
  | eqsR (sv : Expr)
  /-- concat の左評価中（右 e2 を保持） -/
  | catL (e2 : Expr)
  /-- concat の右評価中（評価済み左値を保持） -/
  | catR (sv : Expr)
  /-- getm の subject 評価中（キー k と不在時 nil の型注釈を保持） -/
  | gtmL (t : Ty) (k : Expr)
  /-- getm のキー評価中（評価済み map 値を保持） -/
  | gtmR (t : Ty) (sv : Expr)
  /-- setm の subject 評価中（キー k と値 v を保持） -/
  | stmL (k v : Expr)
  /-- setm のキー評価中 -/
  | stmM (sv v : Expr)
  /-- setm の値評価中 -/
  | stmR (sv kv : Expr)
  /-- delm の subject 評価中（キー k と墓石 nil の型注釈を保持） -/
  | dlmL (t : Ty) (k : Expr)
  /-- delm のキー評価中 -/
  | dlmR (t : Ty) (sv : Expr)
  /-- lenm の subject 評価中 -/
  | lenmK
  /-- keysm の subject 評価中 -/
  | keysmK
  /-- ラベル（V4）。値が戻れば正常完了でそのまま下へ返す。jump の巻き戻しの停止点 -/
  | labelK (t : Ty)
  /-- jump のペイロード評価中。値が戻ったら n 番目の labelK まで巻き戻す -/
  | jumpK (n : Nat)
  /-- scope の本体評価中（段 6 P1）。値が戻ったら、その scope（region = 最内）の子が全部 完了 か 死 になるのを待ち、
  死があれば pop して `inr t triv`（死を値に — P3a A1 (X)）。無ければ blockR と同じく写して pop し `inl unit v`（task の外 = 子が居ない世界では待たない） -/
  | scopeK (t ε : Ty)
  /-- spawn の札の評価中（子へ渡す値 a と子の本体 e を保持） -/
  | spawnK (a e : Expr)
  /-- spawn の渡す値の評価中（評価済みの札 sv と子の本体 e を保持） -/
  | spawnA (sv e : Expr)
  /-- join の handle の評価中（t = 結果型 — 子の結果を scope の region へ写すときに歩く型） -/
  | joinK (t : Ty)
  /-- try の handle の評価中（t は死のときの nil の注釈・完了のときに写す結果の型） -/
  | tryK (t : Ty)
  /-- task の底（P3b-4）: 子の本体の値が戻ったらそこで止まる（region は pop しない — 子の結果は自前の region を指してよく、
  親の join / try がそこから scope の region へ写す〔xfer〕） -/
  | taskK
  deriving Repr, DecidableEq

abbrev Stack := List Frame

/-- jump の巻き戻し（V4）: n 番目の labelK まで S を捨て、その下のスタックとラベルの型を返す
（R4b: ラベルの型は脱出の境界コピー relocTo の歩く型）。
途中の regionK では region を pop する（block の出口と同じ解放）。fretK（関数境界）と
空スタック（タスク・世界の底）は越えない — 型付き状態では到達しない（StackTy の穴の Λ = []）。
1 歩で終える補助関数なので step は関数のまま -/
def unwind : Nat → Stack → Heap → Option (Heap × Stack × Ty)
  | _, [], _ => none
  | n, .labelK t :: S, H =>
      match n with
      | 0 => some (H, S, t)
      | n' + 1 => unwind n' S H
  | n, .regionK :: S, H => unwind n S H.dropLast
  | n, .regionKR _ :: S, H => unwind n S H.dropLast
  | _, .fretK _ :: _, _ => none
  -- scope の本体はラベルを越えない（Λ = []）ので、巻き戻しは scope の出口を越えない（fretK と同じ壁）
  | _, .scopeK _ _ :: _, _ => none
  | n, _ :: S, H => unwind n S H

/-- ビット差分 `a &&& ~b`（Lean core に無いので Nat.bitwise で定義）。
Int の 2 の補数ビット演算の負数側で使う -/
def natLdiff (a b : Nat) : Nat := Nat.bitwise (fun x y => x && !y) a b

/-- Int のビット AND（無限桁の 2 の補数。negSucc n のビット列 = n の補元）。
値が 64bit に収まる限り x86 and と一致 — Examples の突き合わせと
examples/bits.sober（実行）が同じケースで照合する -/
def intLand : Int → Int → Int
  | .ofNat a, .ofNat b => .ofNat (a &&& b)
  | .ofNat a, .negSucc b => .ofNat (natLdiff a b)
  | .negSucc a, .ofNat b => .ofNat (natLdiff b a)
  | .negSucc a, .negSucc b => .negSucc (a ||| b)

/-- Int のビット OR（2 の補数） -/
def intLor : Int → Int → Int
  | .ofNat a, .ofNat b => .ofNat (a ||| b)
  | .ofNat a, .negSucc b => .negSucc (natLdiff b a)
  | .negSucc a, .ofNat b => .negSucc (natLdiff a b)
  | .negSucc a, .negSucc b => .negSucc (a &&& b)

/-- Int のビット XOR（2 の補数） -/
def intLxor : Int → Int → Int
  | .ofNat a, .ofNat b => .ofNat (a ^^^ b)
  | .ofNat a, .negSucc b => .negSucc (a ^^^ b)
  | .negSucc a, .ofNat b => .negSucc (a ^^^ b)
  | .negSucc a, .negSucc b => .ofNat (a ^^^ b)

/-- slice の freeze: セル列 ρ の [base, base+len) のタグを false に倒す。
1 セルずつの set の畳み込み（freeze の単セル規則の反復 — 証明も len の帰納で単セルに落ちる）。
多相なのは Heap（値）と StoreTy（型）の両方に同じ変形を使うため -/
def freezeRange {α : Type} (base : Nat) : Nat → List (Bool × α) → List (Bool × α)
  | 0, ρ => ρ
  | n + 1, ρ =>
      freezeRange base n
        (match ρ[base + n]? with
         | Option.some (_, w) => ρ.set (base + n) (false, w)
         | Option.none => ρ)

/-- eqs のセル列比較（byte セル限定 — 型付けが保証する。blit 以外・範囲外は不一致扱いだが、
型付けされた実行では現れない）。全域 Bool なので stuck しない -/
def eqCells (ρ1 ρ2 : List (Bool × Expr)) (b1 b2 : Nat) : Nat → Bool
  | 0 => true
  | k + 1 =>
      match ρ1[b1 + k]?, ρ2[b2 + k]? with
      | Option.some (_, .blit n1), Option.some (_, .blit n2) => n1 == n2 && eqCells ρ1 ρ2 b1 b2 k
      | _, _ => false

/-- map のキー等値（R3: int | imm string）。lit 同士は値、slicev 同士は長さ + バイト列を
ヒープ H 上で比較（eqs と同じ 1 step 比較）。形の違うキーは不一致 — 型付き状態では現れないので
任意でよいが、全域 Bool に固定する -/
def keyEq (H : Heap) : Expr → Expr → Bool
  | .lit a, .lit b => a == b
  | .slicev _ r1 b1 l1, .slicev _ r2 b2 l2 =>
      match H[r1]?, H[r2]? with
      | Option.some ρ1, Option.some ρ2 => l1 == l2 && eqCells ρ1 ρ2 b1 b2 l1
      | _, _ => false
  | _, _ => false

/-- map セルのキー読み出し（pair ke w 形のみ some ke。それ以外は none） -/
def entryKey : Bool × Expr → Option Expr
  | (_, .pair ke _) => some ke
  | _ => none

theorem entryKey_some {c : Bool × Expr} {ke : Expr} (h : entryKey c = some ke) :
    ∃ mj w, c = (mj, .pair ke w) := by
  unfold entryKey at h
  split at h
  case h_1 mj k' w =>
    cases h
    exact ⟨mj, w, rfl⟩
  case h_2 => cases h

/-- map のキー探索: セル列 ρ の [base, base+len) から keyEq H k となる最初のセル（相対位置）を返す。
セルは pair ke w 形が前提（型が付いていれば成立）。形が違うセルは不一致扱い -/
def findKey (H : Heap) (ρ : List (Bool × Expr)) (base : Nat) (k : Expr) : Nat → Option Nat
  | 0 => none
  | n + 1 =>
      match findKey H ρ base k n with
      | Option.some j => Option.some j
      | Option.none =>
          match ρ[base + n]?.bind entryKey with
          | Option.some ke => if keyEq H k ke then Option.some n else Option.none
          | Option.none => Option.none

/-- findKey が命中したら: 位置は範囲内で、セルは pair 形 -/
theorem findKey_some {H : Heap} {ρ : List (Bool × Expr)} {base : Nat} {k : Expr} :
    ∀ {len j : Nat}, findKey H ρ base k len = some j →
      j < len ∧ ∃ mj ke w, ρ[base + j]? = some (mj, .pair ke w) := by
  intro len
  induction len with
  | zero => intro j h; simp [findKey] at h
  | succ n ih =>
    intro j h
    simp only [findKey] at h
    cases hfk : findKey H ρ base k n with
    | some j' =>
      rw [hfk] at h
      cases h
      obtain ⟨hj, hw⟩ := ih hfk
      exact ⟨Nat.lt_succ_of_lt hj, hw⟩
    | none =>
      cases hkk : (ρ[base + n]?.bind entryKey) with
      | none => simp only [hfk, hkk] at h; cases h
      | some ke =>
        by_cases hq : keyEq H k ke = true
        · simp only [hfk, hkk, hq, if_true] at h
          cases h
          cases hcell : ρ[base + n]? with
          | none => rw [hcell] at hkk; cases hkk
          | some c =>
            rw [hcell] at hkk
            obtain ⟨mj, w, rfl⟩ := entryKey_some hkk
            exact ⟨Nat.lt_succ_self n, mj, ke, w, rfl⟩
        · simp only [hfk, hkk, hq] at h
          cases h

/-- 生きたエントリ（w = some）の数。lenm の意味 -/
def countLive (ρ : List (Bool × Expr)) (base : Nat) : Nat → Nat
  | 0 => 0
  | n + 1 =>
      countLive ρ base n +
        (match ρ[base + n]? with
         | Option.some (_, .pair _ (.some _)) => 1
         | _ => 0)

/-- 生きたエントリ（w = some）のキー列（挿入順 — セル列の並び）。keysm の意味。
墓石（w = nil）はスキップ。setm は墓石のキーを findKey で見つけて in-place で生き返らせるので、
削除 → 再挿入のキーは元の位置に戻る（language.md 22 節） -/
def liveKeys (ρ : List (Bool × Expr)) (base : Nat) : Nat → List Expr
  | 0 => []
  | n + 1 =>
      liveKeys ρ base n ++
        (match ρ[base + n]? with
         | Option.some (_, .pair ke (.some _)) => [ke]
         | _ => [])

/-- arith の意味。none = ゼロ除算・負のシフト量（step が panic に落とす）。
シフトは Go 準拠（裁定 2026-09-27）: shl は count ≥ 64 で 0（64bit 切り詰めの帰結を明示）、
shr は floor なので count ≥ 64 の 0 / -1 は unbounded Int のままで出る。
div / mod は切り捨て（Int.tdiv / tmod。x86 idiv と一致: -7÷2 = -3 余 -1） -/
def ArithOp.eval : ArithOp → Int → Int → Option Int
  | .sub, a, b => some (a - b)
  | .mul, a, b => some (a * b)
  | .div, a, b => if b = 0 then none else some (a.tdiv b)
  | .mod, a, b => if b = 0 then none else some (a.tmod b)
  | .land, a, b => some (intLand a b)
  | .lor, a, b => some (intLor a b)
  | .lxor, a, b => some (intLxor a b)
  | .shl, a, b => if b < 0 then none else if 64 ≤ b then some 0 else some (a <<< b.toNat)
  | .shr, a, b => if b < 0 then none else some (a >>> b.toNat)

/-- float64 の演算の値（IEEE 754 binary64 — 言語は値の意味を IEEE に委ねる。型の健全性は値に依らないので opaque にする:
公理を足さず、どのビット列にも結果がある〔全域〕ことだけを使う） -/
opaque F64.arith : FArithOp → Int → Int → Int
opaque F64.cmp : FCmpOp → Int → Int → Bool
/-- neg / sqrt -/
opaque F64.un : FConvOp → Int → Int
opaque F64.ofInt : Int → Int
/-- 0 方向の切り捨て。none = NaN・±Inf・int の範囲外（step が panic に落とす） -/
opaque F64.toInt : Int → Option Int
opaque F64.bits : Int → Int
opaque F64.fromBits : Int → Int

def CmpOp.eval : CmpOp → Int → Int → Bool
  | .eq, a, b => a = b
  | .ne, a, b => a ≠ b
  | .le, a, b => a ≤ b
  | .gt, a, b => b < a
  | .ge, a, b => b ≤ a

mutual
/-- 機械状態。eval = 式を分解中、ret = 値をスタックへ返す。
par = 2 タスクの並走。各タスクは自前のヒープ・スタックを持つ独立した機械状態で、
親（メイン）は S を保持したまま停止する -/
inductive State : Type where
  | eval (H : Heap) (S : Stack) (e : Expr)
  | ret (H : Heap) (S : Stack) (v : Expr)
  | par (H : Heap) (S : Stack) (s1 s2 : State)
  /-- 実行時タグ検査の失敗（freeze 済みセルへの assign）。terminal。
  ヒープを保持する（共有プレフィクス安定性の言明のため） -/
  | panic (H : Heap)
  /-- task（段 6 P1 — par-draft 5 節）: id = この task の id（親の id ++ [子の番号] — 決定的）、
  o = 生まれたときの親の子の表の長さ（自分の子 i の handle の番号は o + i — 型の子の表 Ξ.tk の先頭 o 個は親から引き継ぐ）、
  n = 局所の通し番号（端点のチャネルの鍵）、
  main = 自分の機械状態（葉 — fam にはならない）、ks = 自分が生んだ子（生んだ順 = handle の番号）。
  子は親の死後も走り切る（打ち切らない — 打ち切ると K への効果が時刻で変わり合流性が死ぬ） -/
  | fam (id : List Nat) (o n : Nat) (main : State) (ks : Kids)
  deriving Repr, DecidableEq

/-- task の子の並び（段 6 P1）: 各子は (spawn した scope の region rs, 札 tg, 子の状態)。札 = scope の err の型（P3b-4 1b' — 失敗を出口で写すときに
歩く型・relocR 0 の形）と回収済みの印（join / try が結果を受けたら立つ — 親のプログラム順だけで決まる） -/
inductive Kids : Type where
  | nil
  | cons (rs : Nat) (tg : Ty × Bool) (s : State) (rest : Kids)
  deriving Repr, DecidableEq
end

def Kids.length : Kids → Nat
  | .nil => 0
  | .cons _ _ _ r => r.length + 1

def Kids.get? : Kids → Nat → Option (Nat × State)
  | .nil, _ => none
  | .cons rs _ s _, 0 => some (rs, s)
  | .cons _ _ _ r, i + 1 => r.get? i

/-- i 番目の子の札 -/
def Kids.tag? : Kids → Nat → Option (Ty × Bool)
  | .nil, _ => none
  | .cons _ tg _ _, 0 => some tg
  | .cons _ _ _ r, i + 1 => r.tag? i

/-- 末尾に子を足す（新しい子の番号 = 今の length・札 = (scope の err の型, 未回収)） -/
def Kids.snoc : Kids → Nat → Ty → State → Kids
  | .nil, rs, ε, s => .cons rs (ε, false) s .nil
  | .cons rs' tg s' r, rs, ε, s => .cons rs' tg s' (r.snoc rs ε s)

/-- i 番目の子を回収済みに（join / try が結果を受けた — 状態はそのまま） -/
def Kids.mark : Kids → Nat → Kids
  | .nil, _ => .nil
  | .cons rs tg s r, 0 => .cons rs (tg.1, true) s r
  | .cons rs tg s r, i + 1 => .cons rs tg s (r.mark i)

def State.isFam : State → Bool
  | .fam _ _ _ _ _ => true
  | _ => false

/-- 死: panic、または main が panic の task（子孫はまだ走っていてよい） -/
def State.mainDead : State → Bool
  | .panic _ => true
  | .fam _ _ _ (.panic _) _ => true
  | _ => false

/-- セル列の値を順に写す（relocT の中身の再帰 — 深い relocate、R4a）。タグはそのまま -/
def relocList (f : Heap → Expr → Option (Heap × Expr)) : Heap → List (Bool × Expr) → Option (Heap × List (Bool × Expr))
  | H, [] => some (H, [])
  | H, (m, v) :: cs =>
      match f H v with
      | Option.some (H1, v') =>
          match relocList f H1 cs with
          | Option.some (H2, cs') => Option.some (H2, (m, v') :: cs')
          | Option.none => Option.none
      | Option.none => Option.none

/-- 脱出の境界コピー（R4b α — relocT の複数 region 一般化）: 型 t に沿って値を歩き、k より深い region にある
imm のヘッダ / loc は、セルの値をまず再帰で写してから region k の末尾へ連続に積み直して付け替える。
k 以下のコンテナは中身も k 以下（HeapOk の tyBelow）なので触らない。nil / inl / inr の型注釈は t に書き換える。
jump の巻き戻しで捨てる region（> k = ラベルの最内）から生き残る値を写す — 関数の return と同じ survivor コピー。
関数の返り境界（fretK）は k = 呼び手の最内（H.length - 2）の特殊形（R4a の relocT を R4b-cov で統合 — 写す元は自フレームだけ） -/
def relocTo (k : Nat) : Ty → Heap → Expr → Option (Heap × Expr)
  | .opt t', H, .some e => (relocTo k t' H e).map (fun p => (p.1, .some p.2))
  | .opt t', H, .nil _ => Option.some (H, .nil t')
  | .union l r, H, .inl _ e => (relocTo k l H e).map (fun p => (p.1, .inl r p.2))
  | .union l r, H, .inr _ e => (relocTo k r H e).map (fun p => (p.1, .inr l p.2))
  | .prod l r, H, .pair a b =>
      match relocTo k l H a with
      | Option.some (H1, a') =>
          match relocTo k r H1 b with
          | Option.some (H2, b') => Option.some (H2, .pair a' b')
          | Option.none => Option.none
      | Option.none => Option.none
  | .slice false _ t', H, .slicev mt r base len =>
      if k < r then
        match H[r]? with
        | Option.some ρs =>
            match relocList (relocTo k t') H ((ρs.drop base).take len) with
            | Option.some (H1, cs) =>
                match H1[k]? with
                | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .slicev mt k ρd.length len)
                | Option.none => Option.none
            | Option.none => Option.none
        | Option.none => Option.none
      else Option.some (H, .slicev mt r base len)
  | .map false _ t', H, .mapv mt r base len =>
      if k < r then
        match H[r]? with
        | Option.some ρs =>
            match relocList (relocTo k t') H ((ρs.drop base).take len) with
            | Option.some (H1, cs) =>
                match H1[k]? with
                | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .mapv mt k ρd.length len)
                | Option.none => Option.none
            | Option.none => Option.none
        | Option.none => Option.none
      else Option.some (H, .mapv mt r base len)
  | .ref false _ t', H, .loc r a =>
      if k < r then
        match H[r]? with
        | Option.some ρs =>
            match relocList (relocTo k t') H ((ρs.drop a).take 1) with
            | Option.some (H1, cs) =>
                match H1[k]? with
                | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .loc k ρd.length)
                | Option.none => Option.none
            | Option.none => Option.none
        | Option.none => Option.none
      else Option.some (H, .loc r a)
  | _, H, v => Option.some (H, v)

/-- 境界をまたぐ写し（P3b-4 — task の結果）: 子のヒープ Hs の値 v を型 t に沿って歩き、imm のヘッダ / loc は
（region に依らず全部）セルの値をまず再帰で写してから親のヒープ Hd の region k の末尾へ連続に積み直して付け替える。
共有の region（親のコピー）を指す値も写す — imm なので観測は変わらない（実装は写さずに済ませてよい）。nil / inl / inr の注釈は t に書き換える -/
def xfer (k : Nat) : Ty → Heap → Heap → Expr → Option (Heap × Expr)
  | .opt t', Hs, Hd, .some e => (xfer k t' Hs Hd e).map (fun p => (p.1, .some p.2))
  | .opt t', _, Hd, .nil _ => Option.some (Hd, .nil t')
  | .union l r, Hs, Hd, .inl _ e => (xfer k l Hs Hd e).map (fun p => (p.1, .inl r p.2))
  | .union l r, Hs, Hd, .inr _ e => (xfer k r Hs Hd e).map (fun p => (p.1, .inr l p.2))
  | .prod l r, Hs, Hd, .pair a b =>
      match xfer k l Hs Hd a with
      | Option.some (H1, a') =>
          match xfer k r Hs H1 b with
          | Option.some (H2, b') => Option.some (H2, .pair a' b')
          | Option.none => Option.none
      | Option.none => Option.none
  | .slice false _ t', Hs, Hd, .slicev mt r base len =>
      match Hs[r]? with
      | Option.some ρs =>
          match relocList (xfer k t' Hs) Hd ((ρs.drop base).take len) with
          | Option.some (H1, cs) =>
              match H1[k]? with
              | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .slicev mt k ρd.length len)
              | Option.none => Option.none
          | Option.none => Option.none
      | Option.none => Option.none
  | .map false _ t', Hs, Hd, .mapv mt r base len =>
      match Hs[r]? with
      | Option.some ρs =>
          match relocList (xfer k t' Hs) Hd ((ρs.drop base).take len) with
          | Option.some (H1, cs) =>
              match H1[k]? with
              | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .mapv mt k ρd.length len)
              | Option.none => Option.none
          | Option.none => Option.none
      | Option.none => Option.none
  | .ref false _ t', Hs, Hd, .loc r a =>
      match Hs[r]? with
      | Option.some ρs =>
          match relocList (xfer k t' Hs) Hd ((ρs.drop a).take 1) with
          | Option.some (H1, cs) =>
              match H1[k]? with
              | Option.some ρd => Option.some (H1.set k (ρd ++ cs), .loc k ρd.length)
              | Option.none => Option.none
          | Option.none => Option.none
      | Option.none => Option.none
  | _, _, Hd, v => Option.some (Hd, v)

/-- 送りの梱包（P3b-4b）: 送り手のヒープ H の値 v を項目の型 ty で 1 region の小さなヒープへ写す（失敗 = none — 型付きなら起きない） -/
def packV (ty : Ty) (H : Heap) (v : Expr) : Option Pkt :=
  (xfer 0 ty H [[]] v).map (fun p => ⟨p.2, p.1.r0, ty⟩)

mutual
/-- タスクの完了形（空スタックまで値が戻った — task の子は全部 完了 か 死〔P3a A1 (X) — 死は scope の出口で値になった〕）。完了なら結果の値。panic は完了ではない -/
def taskDone : State → Option Expr
  | .ret _ [] v => some v
  | .ret _ [.taskK] v => some v
  | .fam _ _ _ m ks => if kidsDone ks then taskDone m else none
  | _ => none

/-- 子が全部 完了 か 死んで静止（P3a A1 (X): 死んだ子は scope の出口で値になった — main が完了していれば子は全部決着している。
死んだ子の子孫は走り切る〔キャンセルなし〕ので、静止まで待つ） -/
def kidsDone : Kids → Bool
  | .nil => true
  | .cons _ _ s r => ((taskDone s).isSome || deadDone s) && kidsDone r

/-- 死んで静止: main が panic で、子孫も全部 完了 か 死んで静止 -/
def deadDone : State → Bool
  | .panic _ => true
  | .fam _ _ _ (.panic _) ks => kidsDone ks
  | _ => false
end

/-- 完了した task の結果とそのヒープ（P3b-4 — join / try が子のヒープから写す）。taskDone の写し -/
def taskRes : State → Option (Heap × Expr)
  | .ret H [] v => some (H, v)
  | .ret H [.taskK] v => some (H, v)
  | .fam _ _ _ m ks => if kidsDone ks then taskRes m else none
  | _ => none

theorem taskDone_eq_taskRes : ∀ s : State, taskDone s = (taskRes s).map Prod.snd
  | .ret _ [] _ => rfl
  | .ret _ [.taskK] _ => rfl
  | .ret _ (_ :: _ :: _) _ => by simp [taskDone, taskRes]
  | .ret _ [f] _ => by cases f <;> simp [taskDone, taskRes]
  | .eval _ _ _ => rfl
  | .par _ _ _ _ => rfl
  | .panic _ => rfl
  | .fam _ _ _ m ks => by
    simp only [taskDone, taskRes]
    split
    · exact taskDone_eq_taskRes m
    · rfl

theorem taskRes_none_of_taskDone {s : State} (h : taskDone s = none) : taskRes s = none := by
  have h1 := taskDone_eq_taskRes s; rw [h] at h1
  cases hr : taskRes s with
  | none => rfl
  | some p => rw [hr] at h1; simp at h1

/-- region rs の scope の子が全部 完了 か 死 -/
def Kids.settledAt (rs : Nat) : Kids → Bool
  | .nil => true
  | .cons r _ s rest => (r != rs || (taskDone s).isSome || s.mainDead) && rest.settledAt rs

/-- region rs の scope の子に死がいる -/
def Kids.deadAt (rs : Nat) : Kids → Bool
  | .nil => false
  | .cons r _ s rest => (r == rs && s.mainDead) || rest.deadAt rs

/-- region rs の scope の子で、正準順（生んだ順）で最初の「完了して err を返し（結果 = pair v (some e)）、未回収」の子（P3b-4 1b'）:
(札の err の型, 子のヒープ, err の値) -/
def Kids.failAt (rs : Nat) : Kids → Option (Ty × Heap × Expr)
  | .nil => none
  | .cons r tg s rest =>
      match r == rs, tg.2, taskRes s with
      | true, false, Option.some (Hk, .pair _ (.some e)) => some (tg.1, Hk, e)
      | _, _, _ => rest.failAt rs

def State.isPanic : State → Bool
  | .panic _ => true
  | _ => false

open Expr in
/-- 端点の引き渡し（段 6 P1 — give:）: 渡す値の中の端点の持ち主を me から kid へ書き換え、値の家の region を子の region d にする
（データはそのまま — 写す）。持ち主でない端点（失効した別名・二度目の引き渡し）が混ざっていれば none（spawn が定義された panic） -/
def giveV (me kid : List Nat) (d : Nat) : Expr → ChanSt → Option (Expr × ChanSt)
  | epV p k true _, K =>
      match K.ep (p, k) with
      | Option.some ent =>
          if ent.otx = me then some (epV p k true d, K.setEp (p, k) { ent with otx := kid }) else none
      | Option.none => none
  | epV p k false _, K =>
      match K.ep (p, k) with
      | Option.some ent =>
          if ent.orx = me then some (epV p k false d, K.setEp (p, k) { ent with orx := kid }) else none
      | Option.none => none
  | pair a b, K =>
      match giveV me kid d a K with
      | Option.some (a', K₁) =>
          match giveV me kid d b K₁ with
          | Option.some (b', K₂) => some (pair a' b', K₂)
          | Option.none => none
      | Option.none => none
  | v, K => some (v, K)

open Expr in
/-- task の main の 1 歩（段 6 P1）: spawn / join / try / scope の出口は子の表 ks を見るのでここで扱い、それ以外は main 自身の歩 r
（step が `step Δ π.tail m K` を渡す — 再帰はしない）を task へ包んで返す -/
def famMain (id : List Nat) (o n : Nat) (m : State) (ks : Kids) (K : ChanSt) (r : Option (State × ChanSt)) :
    Option (State × ChanSt) :=
  match m with
  | .ret H (.spawnA (scopeV rs ε) e :: S) va =>
      match giveV id (id ++ [ks.length]) H.length va K with
      | Option.some (va', K') =>
          some (.fam id o n (.ret H S (taskV rs (o + ks.length)))
            (ks.snoc rs (ε.relocR 0) (.fam (id ++ [ks.length]) (o + ks.length) 0 (.eval (H ++ [[]]) [.taskK] (subst 0 va' e)) .nil)), K')
      | Option.none => some (.fam id o n (.panic H) ks, K)
  -- 端点のチャネル: 鍵 = (この task の id, 局所の通し番号)。持ち主は作った task
  | .eval H S (newch r cap t) =>
      match K.ep (id, n) with
      | Option.some _ => some (.fam id o (n + 1) (.panic H) ks, K)
      | Option.none =>
          some (.fam id o (n + 1) (.ret H S (pair (epV id n true r) (epV id n false r))) ks,
            K.setEp (id, n) ⟨[], cap, id, id, t.relocR 0, false⟩)
  -- 送信: 持ち主でなければ定義された panic（失効した別名）・閉じた後なら panic・満杯なら待つ。値は `some v` を 1 region の小さなヒープへ
  -- 梱包する（P3b-4b — xfer 0。梱包は `T?` の値 — 閉じて空の受けの nil と同じ形で受け手へ写す）
  | .ret H (.sendR (epV p k true _) :: S) v =>
      match K.ep (p, k) with
      | Option.some ent =>
          if ent.otx = id then
            if ent.closed then some (.fam id o n (.panic H) ks, K)
            else if ent.q.length < ent.cap then
              match packV (.opt ent.ty) H (Expr.some v) with
              | Option.some w => some (.fam id o n (.ret H S triv) ks, K.setEp (p, k) { ent with q := ent.q ++ [w] })
              | Option.none => none
            else none
          else some (.fam id o n (.panic H) ks, K)
      | Option.none => some (.fam id o n (.panic H) ks, K)
  -- 受信: 持ち主でなければ定義された panic・空なら待つ。梱包を今の最内の region へ写して受ける（P3b-4b）
  | .ret H (.recvK :: S) (epV p k false _) =>
      match K.ep (p, k) with
      | Option.some ent =>
          if ent.orx = id then
            match ent.q with
            | w :: q' =>
                match xfer (H.length - 1) (w.ty.relocR (H.length - 1)) [w.cs] H w.v with
                | Option.some (H', v') => some (.fam id o n (.ret H' S v') ks, K.setEp (p, k) { ent with q := q' })
                | Option.none => none
            | [] =>
                -- 閉じて空なら nil（P3b-4 ③ — 梱包と同じ形の空の値。何度受けても nil）
                if ent.closed then some (.fam id o n (.ret H S (nil (ent.ty.relocR (H.length - 1)))) ks, K) else none
          else some (.fam id o n (.panic H) ks, K)
      | Option.none => some (.fam id o n (.panic H) ks, K)
  -- close: 持ち主で開いていれば閉じる・それ以外は定義された panic（P3b-4 ③）
  | .ret H (.closeK :: S) (epV p k true _) =>
      match K.ep (p, k) with
      | Option.some ent =>
          if ent.otx = id ∧ ent.closed = false then
            some (.fam id o n (.ret H S triv) ks, K.setEp (p, k) { ent with closed := true })
          else some (.fam id o n (.panic H) ks, K)
      | Option.none => some (.fam id o n (.panic H) ks, K)
  -- join / try: 完了した子の結果を子のヒープから scope の region rs へ写す（P3b-4 — 境界コピー）
  | .ret H (.joinK t :: S) (taskV _ i) =>
      match ks.get? (i - o), decide (o ≤ i) with
      | Option.some (rs, kid), true =>
          match taskRes kid with
          | Option.some (Hk, v) =>
              match xfer rs t Hk H v with
              | Option.some (H', v') => some (.fam id o n (.ret H' S v') (ks.mark (i - o)), K)
              | Option.none => none
          | Option.none => if kid.mainDead then some (.fam id o n (.panic H) ks, K) else none
      | _, _ => some (.fam id o n (.panic H) ks, K)
  | .ret H (.tryK t :: S) (taskV _ i) =>
      match ks.get? (i - o), decide (o ≤ i) with
      | Option.some (rs, kid), true =>
          match taskRes kid with
          | Option.some (Hk, v) =>
              match xfer rs t Hk H v with
              | Option.some (H', v') => some (.fam id o n (.ret H' S (Expr.some v')) (ks.mark (i - o)), K)
              | Option.none => none
          | Option.none => if kid.mainDead then some (.fam id o n (.ret H S (nil t)) ks, K) else none
      | _, _ => some (.fam id o n (.panic H) ks, K)
  | .ret H (.scopeK t ε :: S) v =>
      if ks.settledAt (H.length - 1) then
        -- 死が先（P3a A1 (X) — inr (inl triv)）・次に正準順で最初の未回収の失敗（P3b-4 1b' — err を子のヒープから親の最内へ写して inr (inr e)。
        -- 札の err の型が scope の注釈と食い違えば定義された panic — 型付きなら起きない）
        if ks.deadAt (H.length - 1) then
          some (.fam id o n (.ret H.dropLast S (inr t (inl (ε.relocR (H.length - 2)) triv))) ks, K)
        else
          match ks.failAt (H.length - 1) with
          | Option.some (εk, Hk, e) =>
              if εk = ε.relocR 0 then
                match xfer (H.length - 2) (ε.relocR (H.length - 2)) Hk H e with
                | Option.some (H', e') => some (.fam id o n (.ret H'.dropLast S (inr t (inr .unit e'))) ks, K)
                | Option.none => none
              else some (.fam id o n (.panic H) ks, K)
          | Option.none =>
              -- 待ちが明けたら task の外の出口と同じ（blockR の写し + pop）
              match relocTo (H.length - 2) t H v with
              | Option.some (H', v') => some (.fam id o n (.ret H'.dropLast S (inl (.union .unit (ε.relocR (H.length - 2))) v')) ks, K)
              | Option.none => none
      else none
  -- 旧 par / parch / newchan / 旧 chan の送受は task の中では定義された panic（凍結 — load の側にだけ残る・退役は Kahn の後。
  -- 旧 newchan の id は全 task 共有の通し番号で順序に依り、旧 par は MPMC の並走を作るので、task の木の合流性〔Kahn〕を壊す）
  | .eval H _ (par _ _) => some (.fam id o n (.panic H) ks, K)
  | .eval H _ (parch _ _ _) => some (.fam id o n (.panic H) ks, K)
  | .eval H _ (newchan _ _) => some (.fam id o n (.panic H) ks, K)
  | .ret H (.sendR (chanV _) :: _) _ => some (.fam id o n (.panic H) ks, K)
  | .ret H (.recvK :: _) (chanV _) => some (.fam id o n (.panic H) ks, K)
  | _ => r.map (fun p => (.fam id o n p.1 ks, p.2))

open Expr in
mutual
/-- 1 ステップ。π はスケジュール: par を潜るたびに先頭の Bool で側を選ぶ
（true = 左、par 以外は π を読まない）。K はチャネルストア（全タスク共有）。
none = これ以上進めない（最終状態・panic・空チャネルの recv 待ち） -/
def step (Δ : Defs) (π : List Bool) : State → ChanSt → Option (State × ChanSt)
  -- 分解: 値形は ret へ、それ以外はフレームを積む
  | .eval H S (lit n), K => some (.ret H S (lit n), K)
  | .eval H S (blit n), K => some (.ret H S (blit n), K)
  | .eval H S tt, K => some (.ret H S tt, K)
  | .eval H S ff, K => some (.ret H S ff, K)
  | .eval H S triv, K => some (.ret H S triv, K)
  | .eval H S (nil t), K => some (.ret H S (nil t), K)
  | .eval H S (loc r a), K => some (.ret H S (loc r a), K)
  | .eval H S (chanV c), K => some (.ret H S (chanV c), K)
  | .eval _ _ (var _), _ => none
  | .eval H S (letE e b), K => some (.eval H (.letK b :: S) e, K)
  | .eval H S (add a b), K => some (.eval H (.addL b :: S) a, K)
  | .eval H S (lt a b), K => some (.eval H (.ltL b :: S) a, K)
  | .eval H S (arith op a b), K => some (.eval H (.arithL op b :: S) a, K)
  | .eval H S (cmp op a b), K => some (.eval H (.cmpL op b :: S) a, K)
  | .eval H S (Expr.ite c t e), K => some (.eval H (.iteK t e :: S) c, K)
  | .eval H S (Expr.some e), K => some (.eval H (.someK :: S) e, K)
  | .eval H S (ifnil e n s), K => some (.eval H (.ifnilK n s :: S) e, K)
  | .eval H S (inl r e), K => some (.eval H (.inlK r :: S) e, K)
  | .eval H S (inr l e), K => some (.eval H (.inrK l :: S) e, K)
  | .eval H S (case e l r), K => some (.eval H (.caseK l r :: S) e, K)
  | .eval H S (pair a b), K => some (.eval H (.pairL b :: S) a, K)
  | .eval H S (fst e), K => some (.eval H (.fstK :: S) e, K)
  | .eval H S (ann e t), K => some (.eval H (.annK t :: S) e, K)
  | .eval H S (snd e), K => some (.eval H (.sndK :: S) e, K)
  | .eval H S (call fn ts e), K => some (.eval H (.callK fn ts :: S) e, K)
  | .eval H S (callM fn ts e), K => some (.eval H (.callMK fn ts :: S) e, K)
  | .eval H S (fnref fn ts), K => some (.ret H S (fnref fn ts), K)
  | .eval H S (callv f e), K => some (.eval H (.callvL e :: S) f, K)
  | .eval H S (block e), K => some (.eval (H ++ [[]]) (.regionK :: S) e, K)
  | .eval H S (blockR t e), K => some (.eval (H ++ [[]]) (.regionKR t :: S) e, K)
  | .eval H S (copyTo k t e), K => some (.eval H (.copyK k t :: S) e, K)
  | .eval H S (label t e), K => some (.eval H (.labelK t :: S) e, K)
  | .eval H S (jump n _ e), K => some (.eval H (.jumpK n :: S) e, K)
  -- 到達しない（A5）: 評価に来たら panic（ゼロ除算と同じ終端 — 27 節の「到達 = バグ」）
  | .eval H S (unreach _), K => some (.panic H, K)
  | .eval H S (alloc m e), K => some (.eval H (.allocK m :: S) e, K)
  | .eval H S (deref e), K => some (.eval H (.derefK :: S) e, K)
  | .eval H S (assign l e), K => some (.eval H (.assignL e :: S) l, K)
  | .eval H S (whileE c b), K => some (.eval H (.whileK c b :: S) c, K)
  | .eval H S (Expr.freeze e), K => some (.eval H (.freezeK :: S) e, K)
  -- mkslice: 最内 region の現在長を base に、長さ 0 のヘッダを返す（セルは書かない）
  | .eval H S (mkslice m _), K =>
      match H[H.length - 1]? with
      | Option.some ρ => some (.ret H S (slicev m (H.length - 1) ρ.length 0), K)
      | Option.none => none
  -- strlit: region r の現在長を base に長さ 0 の mut ヘッダを作り、バイトを append して freeze する形へ書き換える
  -- （ヒープは変えない — セルは続く appendM の歩が region r の先端に積む）
  | .eval H S (strlit bs r), K =>
      match H[r]? with
      | Option.some ρ => some (.eval H S (Expr.freeze (strCells bs (slicev true r ρ.length 0))), K)
      | Option.none => none
  -- mksliceAt / mkmapAt（M3b）: mkslice / mkmap の region 指定版（region r の現在長を base に、長さ 0 のヘッダ）
  | .eval H S (mksliceAt m _ r), K =>
      match H[r]? with
      | Option.some ρ => some (.ret H S (slicev m r ρ.length 0), K)
      | Option.none => none
  | .eval H S (mkmapAt m _ r), K =>
      match H[r]? with
      | Option.some ρ => some (.ret H S (mapv m r ρ.length 0), K)
      | Option.none => none
  | .eval H S (index e i ot), K => some (.eval H (.idxL ot i :: S) e, K)
  | .eval H S (lenE e), K => some (.eval H (.lenK :: S) e, K)
  | .eval H S (flit n), K => some (.ret H S (flit n), K)
  | .eval H S (tobyte e), K => some (.eval H (.tobyteK :: S) e, K)
  | .eval H S (farith op a b), K => some (.eval H (.farithL op b :: S) a, K)
  | .eval H S (fcmp op a b), K => some (.eval H (.fcmpL op b :: S) a, K)
  | .eval H S (fconv op e), K => some (.eval H (.fconvK op :: S) e, K)
  | .eval H S (toint e), K => some (.eval H (.tointK :: S) e, K)
  | .eval H S (append e v), K => some (.eval H (.appL v :: S) e, K)
  | .eval H S (setidx e i v), K => some (.eval H (.sixL i v :: S) e, K)
  | .eval H S (subslice e sa sb), K => some (.eval H (.subL sa sb :: S) e, K)
  | .eval H S (eqs e1 e2), K => some (.eval H (.eqsL e2 :: S) e1, K)
  | .eval H S (concat e1 e2), K => some (.eval H (.catL e2 :: S) e1, K)
  | .eval H S (slicev mt r base len), K => some (.ret H S (slicev mt r base len), K)
  -- mkmap: mkslice と同型（最内 region の現在長を base に、長さ 0 のヘッダ）
  | .eval H S (mkmap m _), K =>
      match H[H.length - 1]? with
      | Option.some ρ => some (.ret H S (mapv m (H.length - 1) ρ.length 0), K)
      | Option.none => none
  | .eval H S (getm t e k), K => some (.eval H (.gtmL t k :: S) e, K)
  | .eval H S (setm e k v), K => some (.eval H (.stmL k v :: S) e, K)
  | .eval H S (delm t e k), K => some (.eval H (.dlmL t k :: S) e, K)
  | .eval H S (lenm e), K => some (.eval H (.lenmK :: S) e, K)
  | .eval H S (keysm e), K => some (.eval H (.keysmK :: S) e, K)
  | .eval H S (mapv mt r base len), K => some (.ret H S (mapv mt r base len), K)
  -- newchan: K の末尾に空キューを足し、その id を返す
  | .eval H S (newchan _ _), K => some (.ret H S (chanV K.leg.length), K.addLeg)
  -- parch: チャネルを作り、その chanV を両本体に代入して spawn（newchan + par の融合）
  | .eval H S (parch _ e1 e2), K =>
      some (.par H S (.eval H [] (subst 0 (chanV K.leg.length) e1))
        (.eval H [] (subst 0 (chanV K.leg.length) e2)), K.addLeg)
  | .eval H S (send c e), K => some (.eval H (.sendL e :: S) c, K)
  | .eval H S (recv c), K => some (.eval H (.recvK :: S) c, K)
  | .eval H S (close c), K => some (.eval H (.closeK :: S) c, K)
  -- 段 6 P1: scope / spawn / join / try の分解（札・handle は値）
  | .eval H S (scope t ε e), K => some (.eval (H ++ [[]]) (.scopeK t ε :: S) (subst 0 (scopeV H.length ε) e), K)
  | .eval H S (spawn sc a e), K => some (.eval H (.spawnK a e :: S) sc, K)
  | .eval H S (join t h), K => some (.eval H (.joinK t :: S) h, K)
  | .eval H S (tryJ t h), K => some (.eval H (.tryK t :: S) h, K)
  | .eval H S (scopeV rs ε), K => some (.ret H S (scopeV rs ε), K)
  | .eval H S (taskV rs n), K => some (.ret H S (taskV rs n), K)
  | .eval H S (epV p k b r), K => some (.ret H S (epV p k b r), K)
  -- task の外の端点の生成は到達しない形（子の表も id も持たない）: panic で閉じる
  | .eval H S (newch _ _ _), K => some (.panic H, K)
  -- spawn: 各タスクは親ヒープのコピーと空スタックで走る（段 3b: 共有 region の読み出し。
  -- 型付けがタスクからの共有 region への書き込みを禁じるので、コピーは物理共有と一致する
  -- — step_shared_stable がその中身）。K は共有（コピーしない）
  | .eval H S (par e1 e2), K => some (.par H S (.eval H [] e1) (.eval H [] e2), K)
  -- join: 両タスクが完了したらメインが unit で再開。未完了なら π の先頭で側を選ぶ。
  -- 選んだ側が panic ならメインへ伝播（無条件チェックにしないのは par_step_commute を
  -- 構造不変に保つため — 相手側を先に進める自由を残す。formal.md 段 freeze の裁定）
  | .par H S s1 s2, K =>
      if (taskDone s1).isSome && (taskDone s2).isSome then some (.ret H S triv, K)
      else
        match π with
        | true :: π' =>
            if s1.isPanic then some (.panic H, K)
            else (step Δ π' s1 K).map (fun (s1', K') => (.par H S s1' s2, K'))
        | false :: π' =>
            if s2.isPanic then some (.panic H, K)
            else (step Δ π' s2 K).map (fun (s2', K') => (.par H S s1 s2', K'))
        | [] => none
  -- 継続: 値をフレームへ返す
  | .ret H (.letK b :: S) v, K => some (.eval H S (subst 0 v b), K)
  | .ret H (.addL b :: S) v, K => some (.eval H (.addR v :: S) b, K)
  | .ret H (.addR (lit n) :: S) (lit m), K => some (.ret H S (lit (n + m)), K)
  | .ret H (.ltL b :: S) v, K => some (.eval H (.ltR v :: S) b, K)
  | .ret H (.ltR (lit n) :: S) (lit m), K =>
      some (.ret H S (if n < m then tt else ff), K)
  | .ret H (.arithL op b :: S) v, K => some (.eval H (.arithR op v :: S) b, K)
  -- ゼロ除算は panic（回復可能な違反を panic に落とさない裁定は language.md 未決 —
  -- 決まったらここが変わる。現状は codegen（idiv のトラップ）と同じ抽象）
  | .ret H (.arithR op (lit n) :: S) (lit m), K =>
      match op.eval n m with
      | Option.some k => some (.ret H S (lit k), K)
      | Option.none => some (.panic H, K)
  | .ret H (.cmpL op b :: S) v, K => some (.eval H (.cmpR op v :: S) b, K)
  | .ret H (.cmpR op (lit n) :: S) (lit m), K =>
      some (.ret H S (if op.eval n m then tt else ff), K)
  | .ret H (.iteK t _ :: S) tt, K => some (.eval H S t, K)
  | .ret H (.iteK _ e :: S) ff, K => some (.eval H S e, K)
  | .ret H (.someK :: S) v, K => some (.ret H S (Expr.some v), K)
  | .ret H (.ifnilK n _ :: S) (nil _), K => some (.eval H S n, K)
  | .ret H (.ifnilK _ s :: S) (Expr.some v), K => some (.eval H S (subst 0 v s), K)
  | .ret H (.inlK r :: S) v, K => some (.ret H S (inl r v), K)
  | .ret H (.inrK l :: S) v, K => some (.ret H S (inr l v), K)
  | .ret H (.caseK l _ :: S) (inl _ v), K => some (.eval H S (subst 0 v l), K)
  | .ret H (.caseK _ r :: S) (inr _ v), K => some (.eval H S (subst 0 v r), K)
  | .ret H (.pairL b :: S) v, K => some (.eval H (.pairR v :: S) b, K)
  | .ret H (.callvL e :: S) v, K => some (.eval H (.callvR v :: S) e, K)
  -- 関数値呼び出し: 関数値が fnref なら、引数値を callK に渡し直して call に委譲する
  | .ret H (.callvR (fnref fn ts) :: S) v, K => some (.ret H (.callK fn ts :: S) v, K)
  | .ret H (.pairR a :: S) v, K => some (.ret H S (pair a v), K)
  | .ret H (.fstK :: S) (pair a _), K => some (.ret H S a, K)
  | .ret H (.annK t :: S) v, K => some (.ret H S (Expr.coerceTo t v), K)
  | .ret H (.sndK :: S) (pair _ b), K => some (.ret H S b, K)
  | .ret H (.allocK m :: S) v, K =>
      match H[H.length - 1]? with
      | Option.some ρ =>
          some (.ret (H.set (H.length - 1) (ρ ++ [(m, v)])) S (loc (H.length - 1) ρ.length), K)
      | Option.none => none
  | .ret H (.derefK :: S) (loc r a), K =>
      match H[r]? with
      | Option.some ρ =>
          match ρ[a]? with
          | Option.some (_, w) => some (.ret H S w, K)
          | Option.none => none
      | Option.none => none
  | .ret H (.assignL e :: S) v, K => some (.eval H (.assignR v :: S) e, K)
  -- assign のタグ検査: mut なら書き込み、freeze 済み（タグ false）なら panic。
  -- 「freeze 後の古い mut エイリアスは型が付くが実行で panic」— 動的検査が底
  | .ret H (.assignR (loc r a) :: S) v, K =>
      match H[r]? with
      | Option.some ρ =>
          match ρ[a]? with
          | Option.some (true, _) => some (.ret (H.set r (ρ.set a (true, v))) S triv, K)
          | Option.some (false, _) => some (.panic H, K)
          | Option.none => none
      | Option.none => none
  -- freeze: セルのタグを false に倒し、同じ loc を（immutable 参照として）返す
  | .ret H (.freezeK :: S) (loc r a), K =>
      match H[r]? with
      | Option.some ρ =>
          match ρ[a]? with
          | Option.some (_, w) => some (.ret (H.set r (ρ.set a (false, w))) S (loc r a), K)
          | Option.none => none
      | Option.none => none
  -- freeze（slice）: 覆う範囲のタグをまとめて倒し、実行時タグ false のヘッダを返す
  | .ret H (.freezeK :: S) (slicev _ r base len), K =>
      match H[r]? with
      | Option.some ρ =>
          some (.ret (H.set r (freezeRange base len ρ)) S (slicev false r base len), K)
      | Option.none => none
  -- index: 範囲内なら読み、範囲外は panic（暫定 — language.md 21 節）
  | .ret H (.idxL ot i :: S) sv, K => some (.eval H (.idxR ot sv :: S) i, K)
  | .ret H (.idxR ot (slicev _ r base len) :: S) (lit n), K =>
      if 0 ≤ n ∧ n.toNat < len then
        match H[r]? with
        | Option.some ρ =>
            match ρ[base + n.toNat]? with
            | Option.some (_, w) => some (.ret H S (Expr.coerceOpt ot w), K)
            | Option.none => none
        | Option.none => none
      else some (.panic H, K)
  | .ret H (.lenK :: S) (slicev _ _ _ len), K => some (.ret H S (lit len), K)
  -- append（mut = mt true）: slice 末尾が region r の bump 先端なら 1 セル伸長、
  -- そうでなければ region r の先端へ全コピー + 1 セル（新しいヘッダ）。language.md 21 節
  -- append（imm = mt false）: 現在の最内 region へ常に全コピー + 1 セル（round4:
  -- imm の型 region は上界で実 region に b ≤ r を言えないため、書き込み先を自フレームに固定。
  -- imm はセル不変なのでコピーは観測不能）
  | .ret H (.appL v :: S) sv, K => some (.eval H (.appR sv :: S) v, K)
  | .ret H (.appR (slicev mt r base len) :: S) v, K =>
      match H[r]? with
      | Option.some ρ =>
          if mt then
            if base + len = ρ.length then
              some (.ret (H.set r (ρ ++ [(true, v)])) S (slicev true r base (len + 1)), K)
            else
              some (.ret (H.set r (ρ ++ (ρ.drop base).take len ++ [(true, v)])) S
                (slicev true r ρ.length (len + 1)), K)
          else
            match H[H.length - 1]? with
            | Option.some ρi =>
                some (.ret (H.set (H.length - 1)
                  (ρi ++ (ρ.drop base).take len ++ [(false, v)])) S
                  (slicev false (H.length - 1) ρi.length (len + 1)), K)
            | Option.none => none
      | Option.none => none
  -- setidx: 範囲内かつタグ true なら書き込み、freeze 済みは panic（assign と同じ動的な底）、
  -- 範囲外は panic
  | .ret H (.sixL i v :: S) sv, K => some (.eval H (.sixM sv v :: S) i, K)
  | .ret H (.sixM sv v :: S) iv, K => some (.eval H (.sixR sv iv :: S) v, K)
  | .ret H (.sixR (slicev _ r base len) (lit n) :: S) v, K =>
      if 0 ≤ n ∧ n.toNat < len then
        match H[r]? with
        | Option.some ρ =>
            match ρ[base + n.toNat]? with
            | Option.some (true, _) =>
                some (.ret (H.set r (ρ.set (base + n.toNat) (true, v))) S triv, K)
            | Option.some (false, _) => some (.panic H, K)
            | Option.none => none
        | Option.none => none
      else some (.panic H, K)
  -- subslice: 0 ≤ a ≤ b ≤ len なら同セル列の新ヘッダ（割り当てゼロ）、範囲外は panic
  | .ret H (.subL sa sb :: S) sv, K => some (.eval H (.subM sv sb :: S) sa, K)
  | .ret H (.subM sv sb :: S) av, K => some (.eval H (.subR sv av :: S) sb, K)
  | .ret H (.subR (slicev mt r base len) (lit na) :: S) (lit nb), K =>
      if 0 ≤ na ∧ na ≤ nb ∧ nb.toNat ≤ len then
        some (.ret H S (slicev mt r (base + na.toNat) (nb.toNat - na.toNat)), K)
      else some (.panic H, K)
  -- eqs: 長さ一致 + セル列比較（ヒープ不変。byte セル限定 — 型付けが保証）
  | .ret H (.eqsL e2 :: S) sv, K => some (.eval H (.eqsR sv :: S) e2, K)
  | .ret H (.eqsR (slicev _ r1 b1 l1) :: S) (slicev _ r2 b2 l2), K =>
      match H[r1]?, H[r2]? with
      | Option.some ρ1, Option.some ρ2 =>
          if l1 = l2 ∧ eqCells ρ1 ρ2 b1 b2 l1 then some (.ret H S tt, K)
          else some (.ret H S ff, K)
      | _, _ => none
  -- concat: 最内 region へ両セル列をコピー（appendI と同じ床）
  | .ret H (.catL e2 :: S) sv, K => some (.eval H (.catR sv :: S) e2, K)
  | .ret H (.catR (slicev _ r1 b1 l1) :: S) (slicev _ r2 b2 l2), K =>
      match H[r1]?, H[r2]? with
      | Option.some ρ1, Option.some ρ2 =>
          match H[H.length - 1]? with
          | Option.some ρi =>
              some (.ret (H.set (H.length - 1)
                (ρi ++ (ρ1.drop b1).take l1 ++ (ρ2.drop b2).take l2)) S
                (slicev false (H.length - 1) ρi.length (l1 + l2)), K)
          | Option.none => none
      | _, _ => none
  -- freeze（map）: slice 版と同型
  | .ret H (.freezeK :: S) (mapv _ r base len), K =>
      match H[r]? with
      | Option.some ρ =>
          some (.ret (H.set r (freezeRange base len ρ)) S (mapv false r base len), K)
      | Option.none => none
  -- getm: キー探索。命中ならセルの opt 値、不在なら nil t
  | .ret H (.gtmL t k :: S) sv, K => some (.eval H (.gtmR t sv :: S) k, K)
  | .ret H (.gtmR t (mapv _ r base len) :: S) kv, K =>
      match H[r]? with
      | Option.some ρ =>
          match findKey H ρ base kv len with
          | Option.some j =>
              match ρ[base + j]? with
              | Option.some (_, .pair _ w) => some (.ret H S (Expr.coerceTo (.opt t) w), K)
              | _ => none
          | Option.none => some (.ret H S (nil t), K)
      | Option.none => none
  -- setm: 既存キーは in-place 更新（タグ検査 — freeze 済みへの書き込みは panic）、
  -- 新規キーは append と同じ「先端 1 セル / 全コピー」（language.md 22 節）
  | .ret H (.stmL k v :: S) sv, K => some (.eval H (.stmM sv v :: S) k, K)
  | .ret H (.stmM sv v :: S) kv, K => some (.eval H (.stmR sv kv :: S) v, K)
  | .ret H (.stmR (mapv mt r base len) kv :: S) v, K =>
      match H[r]? with
      | Option.some ρ =>
          match findKey H ρ base kv len with
          | Option.some j =>
              match ρ[base + j]? with
              | Option.some (true, .pair ke _) =>
                  some (.ret (H.set r (ρ.set (base + j) (true, .pair ke (.some v)))) S
                    (mapv mt r base len), K)
              | Option.some (false, _) => some (.panic H, K)
              | _ => none
          | Option.none =>
              if base + len = ρ.length then
                some (.ret (H.set r (ρ ++ [(mt, .pair kv (.some v))])) S
                  (mapv mt r base (len + 1)), K)
              else
                some (.ret (H.set r (ρ ++ (ρ.drop base).take len ++
                  [(mt, .pair kv (.some v))])) S
                  (mapv mt r ρ.length (len + 1)), K)
      | Option.none => none
  -- delm: 墓石を in-place で書く（タグ検査）。不在は no-op
  | .ret H (.dlmL t k :: S) sv, K => some (.eval H (.dlmR t sv :: S) k, K)
  | .ret H (.dlmR t (mapv _ r base len) :: S) kv, K =>
      match H[r]? with
      | Option.some ρ =>
          match findKey H ρ base kv len with
          | Option.some j =>
              match ρ[base + j]? with
              | Option.some (true, .pair ke _) =>
                  some (.ret (H.set r (ρ.set (base + j) (true, .pair ke (nil t)))) S triv, K)
              | Option.some (false, _) => some (.panic H, K)
              | _ => none
          | Option.none => some (.ret H S triv, K)
      | Option.none => none
  -- lenm: 生きたエントリの数
  | .ret H (.lenmK :: S) (mapv _ r base len), K =>
      match H[r]? with
      | Option.some ρ => some (.ret H S (lit (countLive ρ base len)), K)
      | Option.none => none
  -- keysm: 生きたキーを挿入順に最内 region へコピー（concat と同じ床。スナップショット）
  | .ret H (.keysmK :: S) (mapv _ r base len), K =>
      match H[r]? with
      | Option.some ρ =>
          match H[H.length - 1]? with
          | Option.some ρi =>
              some (.ret (H.set (H.length - 1)
                (ρi ++ (liveKeys ρ base len).map (fun k => (false, k)))) S
                (slicev false (H.length - 1) ρi.length (liveKeys ρ base len).length), K)
          | Option.none => none
      | Option.none => none
  | .ret H (.whileK c b :: S) tt, K => some (.eval H (.whileB c b :: S) b, K)
  | .ret H (.whileK _ _ :: S) ff, K => some (.ret H S triv, K)
  | .ret H (.whileB c b :: S) _, K => some (.eval H S (whileE c b), K)
  | .ret H (.regionK :: S) v, K => some (.ret H.dropLast S v, K)
  -- 出口で写すブロック（R5）: ブロックの region（最内）の imm コンテナを親の最内へ写してから pop
  | .ret H (.regionKR t :: S) v, K =>
      match relocTo (H.length - 2) t H v with
      | Option.some (H', v') => some (.ret H'.dropLast S v', K)
      | Option.none => none
  | .ret H (.labelK _ :: S) v, K => some (.ret H S v, K)
  | .ret H (.spawnK a e :: S) sv, K => some (.eval H (.spawnA sv e :: S) a, K)
  -- scope の出口（task の外 = 子の居ない世界 — task の中では fam が先に待ちを検査してから委ねる）: blockR と同じ
  | .ret H (.scopeK t ε :: S) v, K =>
      match relocTo (H.length - 2) t H v with
      | Option.some (H', v') => some (.ret H'.dropLast S (inl (.union .unit (ε.relocR (H.length - 2))) v'), K)
      | Option.none => none
  -- task の外での spawn / join / try（旧 load の根や旧 par の子 — 子の表を持たない）: 到達しない形を panic で閉じる
  | .ret H (.spawnA (scopeV _ _) _ :: _) _, K => some (.panic H, K)
  | .ret H (.joinK _ :: _) (taskV _ _), K => some (.panic H, K)
  | .ret H (.tryK _ :: _) (taskV _ _), K => some (.panic H, K)
  | .ret H (.sendR (epV _ _ _ _) :: _) _, K => some (.panic H, K)
  | .ret H (.recvK :: _) (epV _ _ _ _), K => some (.panic H, K)
  | .ret H (.closeK :: _) (epV _ _ _ _), K => some (.panic H, K)
  | .ret H (.copyK k t :: S) v, K =>
      match relocTo k t H v with
      | Option.some (H', v') => some (.ret H' S v', K)
      | Option.none => none
  | .ret H (.jumpK n :: S) v, K =>
      match unwind n S H with
      | Option.some (H', S', tL) =>
          match relocTo (H'.length - 1) tL H v with
          | Option.some (H'', v') => some (.ret (H''.take H'.length) S' v', K)
          | Option.none => none
      | Option.none => none
  | .ret H (.sendL e :: S) v, K => some (.eval H (.sendR v :: S) e, K)
  -- send: enqueue（無限バッファ。常に進む）
  | .ret H (.sendR (chanV c) :: S) v, K =>
      match K.leg[c]? with
      | Option.some q => some (.ret H S triv, K.setLeg c (q ++ [v]))
      | Option.none => none
  -- recv: dequeue。空キューなら none（blocked） — 待機であって故障ではない。
  -- progress の言明の第 3 の口（Blocked）
  -- call: 引数（loc-free 値）を本体に代入し、空ヒープ・空スタックの入れ子世界を開く
  -- call（round4: 同世界化）: region を push し、シフト + coerce した本体に代入して
  -- 同じ世界で評価する。ρ = 呼び手深さ - 1（base のフレーム region 1 ↦ 押した region）
  -- V3-2: 型引数 ts で代入した仮想 Def（dfn.inst ts）をインスタンス化する
  | .ret H (.callK fn ts :: S) v, K =>
      match Δ[fn]? with
      | Option.some dfn =>
          some (.eval (H ++ [[]]) (.fretK ((dfn.inst ts).ret.relocR (H.length - 1)) :: S)
            (Expr.subst 0 (Expr.coerceTo ((dfn.inst ts).param.shiftR (H.length - 1)) v)
              ((dfn.inst ts).body.shiftTy (H.length - 1))), K)
      | Option.none => none
  -- anchor つき call（R2）: anchor a = 引数値の mut 位置の region（型付き状態では Ty.anchorOf と一致。
  -- 見つからなければ呼び手最内 = call と同じ）。本体は region 0 を a、それ以外を +d へ写す
  | .ret H (.callMK fn ts :: S) v, K =>
      match Δ[fn]? with
      | Option.some dfn =>
          let a := (Expr.anchorV (dfn.inst ts).param v).getD (H.length - 1)
          some (.eval (H ++ [[]]) (.fretK ((dfn.inst ts).ret.relocA a (H.length - 1)) :: S)
            (Expr.subst 0 (Expr.coerceTo ((dfn.inst ts).param.renR a (H.length - 1)) v)
              ((dfn.inst ts).body.renTy a (H.length - 1))), K)
      | Option.none => none
  -- 関数の返り境界: relocate（境界コピー）して region を pop
  | .ret H (.fretK t :: S) v, K =>
      match relocTo (H.length - 2) t H v with
      | Option.some (H', v') => some (.ret H'.dropLast S v', K)
      | Option.none => none
  | .ret H (.recvK :: S) (chanV c), K =>
      match K.leg[c]? with
      | Option.some (v :: q) => some (.ret H S v, K.setLeg c q)
      | Option.some [] => none
      | Option.none => none
  -- byte の段: 変換の継続（ret の腕の末尾に置く — 値で場合分けする腕を後ろの腕の前に置くと、後ろの腕の等式の生成が重くなる）
  | .ret H (.tobyteK :: S) (lit n), K =>
      if 0 ≤ n ∧ n < 256 then some (.ret H S (blit n), K) else some (.panic H, K)
  | .ret H (.tointK :: S) (blit n), K => some (.ret H S (lit n), K)
  -- float の段: 値は opaque な IEEE の関数・toInt の不可は panic
  | .ret H (.farithL op b :: S) v, K => some (.eval H (.farithR op v :: S) b, K)
  | .ret H (.farithR op (flit n) :: S) (flit m), K => some (.ret H S (flit (F64.arith op n m)), K)
  | .ret H (.fcmpL op b :: S) v, K => some (.eval H (.fcmpR op v :: S) b, K)
  | .ret H (.fcmpR op (flit n) :: S) (flit m), K =>
      some (.ret H S (if F64.cmp op n m then tt else ff), K)
  | .ret H (.fconvK .neg :: S) (flit n), K => some (.ret H S (flit (F64.un .neg n)), K)
  | .ret H (.fconvK .sqrt :: S) (flit n), K => some (.ret H S (flit (F64.un .sqrt n)), K)
  | .ret H (.fconvK .ofInt :: S) (lit i), K => some (.ret H S (flit (F64.ofInt i)), K)
  | .ret H (.fconvK .toInt :: S) (flit n), K =>
      match F64.toInt n with
      | Option.some i => some (.ret H S (lit i), K)
      | Option.none => some (.panic H, K)
  | .ret H (.fconvK .bits :: S) (flit n), K => some (.ret H S (lit (F64.bits n)), K)
  | .ret H (.fconvK .fromBits :: S) (lit i), K => some (.ret H S (flit (F64.fromBits i)), K)
  | .ret _ _ _, _ => none
  -- panic は terminal
  | .panic _, _ => none
  -- task（段 6 P1）: π の先頭 false = 子のどれか（stepKids が続きで選ぶ）、それ以外 = main（[] は main — stepN が素の形で走る）。
  -- main の spawn / join / try / scope の出口は子の表を見るのでここで扱い、それ以外の歩は main へ委ねる
  | .fam id o n m ks, K =>
      match π with
      | false :: π' => (stepKids Δ π' ks K).map (fun p => (.fam id o n m p.1, p.2))
      | _ => famMain id o n m ks K (step Δ π.tail m K)

/-- 子のどれかを 1 歩（π の先頭 true = 先頭の子、false = 残りへ — 子 i は false^i true） -/
def stepKids (Δ : Defs) (π : List Bool) : Kids → ChanSt → Option (Kids × ChanSt)
  | .nil, _ => none
  | .cons rs tg s r, K =>
      match π with
      | true :: π' => (step Δ π' s K).map (fun p => (.cons rs tg p.1 r, p.2))
      | false :: π' => (stepKids Δ π' r K).map (fun p => (.cons rs tg s p.1, p.2))
      | [] => none
end

/-- par の step の展開形（simp only [step] は再帰定義の par 等式を拾わないことがあるため） -/
theorem step_par_def (Δ : Defs) (π : List Bool) (H : Heap) (S : Stack) (s1 s2 : State) (K : ChanSt) :
    step Δ π (.par H S s1 s2) K =
      if (taskDone s1).isSome && (taskDone s2).isSome then some (.ret H S .triv, K)
      else
        match π with
        | true :: π' =>
            if s1.isPanic then some (.panic H, K)
            else (step Δ π' s1 K).map (fun (s1', K') => (.par H S s1' s2, K'))
        | false :: π' =>
            if s2.isPanic then some (.panic H, K)
            else (step Δ π' s2 K).map (fun (s2', K') => (.par H S s1 s2', K'))
        | [] => none := by
  cases π with
  | nil => rfl
  | cons b π' => cases b <;> rfl

/-- スケジュールつき実行（1 要素 = 1 ステップのパス） -/
def run (Δ : Defs) : List (List Bool) → State → ChanSt → State × ChanSt
  | [], s, K => (s, K)
  | π :: πs, s, K =>
    match step Δ π s K with
    | Option.some (s', K') => run Δ πs s' K'
    | Option.none => (s, K)

/-- 燃料つき実行（par の無い項用。パスは常に空） -/
def stepN (Δ : Defs) (n : Nat) (s : State) (K : ChanSt) : State × ChanSt := run Δ (List.replicate n []) s K

/-- 閉じた式の初期状態 -/
def load (e : Expr) : State := .eval [] [] e

/-- 閉じた式の初期状態（段 6 P1 — 根の task: id = []）。並列の構成子を使う式はこちらで走らせる -/
def loadT (e : Expr) : State := .fam [] 0 0 (.eval [] [] e) .nil

/-- 状態のトップレベルのヒープ（par の子は含まない）。
共有プレフィクス安定性（step_shared_stable）の対象 -/
def State.heap : State → Heap
  | .eval H _ _ => H
  | .ret H _ _ => H
  | .par H _ _ _ => H
  | .panic H => H
  | .fam _ _ _ m _ => m.heap

end FS
