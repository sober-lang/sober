import FeatherweightSober.Typing

/-!
# 型付けの構造補題（段 3d）

- weakening（Γ への挿入と shift）と置換補題: 段 1 と同じ構造で Ξ / Ψ / f / b / d を素通しする
- 値の深さ weakening / strengthening: 値は wrapper と loc / chanV だけなので、
  深さと Ψ の付け替えは値に限れば軽い（一般の項は un-evaluated な block を含みうるので不可）
- 値の共有境界の付け替え（value_sb）: mutFree 型の値の loc はすべて immutable なので、
  loc 規則の条件が m = false 側で常に立ち、b を任意に取り替えられる。
  par の Γ 制約（mutFree）が置換補題を通る要
- ストア単調性（store_mono）: lookup の保存に加えて**書き込み床 f 以下のプレフィクス保存**
  （`Ψ'.take f = Ψ.take f`）を要求する。chanV のスナップショット等式（rc ≤ f）の保存の根拠。
  すべてのストア遷移（alloc / freeze / push / pop）は region ≥ f にしか触れないので立つ
- 床の単調性（f_mono）: f を上げても型付けは保たれる（f は chanV / newchan の
  `rc ≤ f` にしか現れず、どちらも単調）。spawn（b = f = d への引き上げ）と recv で使う
- 床の付け替え（value_f_set）: 値は型の regionsBelow n から全 chanV の rc ≤ n が出るので、
  f を n に取り替えられる。send がペイロードをキューの世界（f = rc）へ落とすときに使う
- チャネル環境の単調性（chan_mono）: newchan / parch で Ξ が伸びても型付けは保たれる

帰納はすべて式に対して行う（型付けが構文主導なので inversion が一意）。
-/
namespace FS

/-- Ψ' が Ψ の全 lookup を「型は保存、タグは mut → imm の一方向」で保存する
（freeze でセルのタグが false に倒れても型付けが運べるように、等号でなく順序）。
imm セル（m = false）は imm のまま — imm loc の型付けが壊れないことの source -/
def StoreLE (Ψ Ψ' : StoreTy) : Prop :=
  ∀ (r a : Nat) (m : Bool) (t : Ty), (∃ ρ, Ψ[r]? = some ρ ∧ ρ[a]? = some (m, t)) →
    ∃ ρ' m', Ψ'[r]? = some ρ' ∧ ρ'[a]? = some (m', t) ∧ (m = false → m' = false)

theorem StoreLE.refl (Ψ : StoreTy) : StoreLE Ψ Ψ :=
  fun _ _ m _ ⟨ρ, h1, h2⟩ => ⟨ρ, m, h1, h2, fun h => h⟩


/-- 空ストアからはどこへでも行ける -/
theorem storeLE_nil (Ψ : StoreTy) : StoreLE [] Ψ := by
  intro r a m t ⟨ρ, h1, _⟩
  simp at h1

/-- チャネル型環境の伸長（段 6 P1 で 3 成分に）: 引ける項目は引けたまま（ch・ep は全タスク共有の伸長、tk は自分の子の追加） -/
structure ChanLE (Ξ Ξ' : ChanTy) : Prop where
  ch : ∀ (c : Nat) (p : StoreTy × Ty), Ξ.ch[c]? = some p → Ξ'.ch[c]? = some p
  ep : ∀ (k : EpKey) (t : Ty), Ξ.ep.lookup k = some t → Ξ'.ep.lookup k = some t
  tk : ∀ (n : Nat) (p : Nat × Ty), Ξ.tk[n]? = some p → Ξ'.tk[n]? = some p

theorem ChanLE.refl (Ξ : ChanTy) : ChanLE Ξ Ξ := ⟨fun _ _ h => h, fun _ _ h => h, fun _ _ h => h⟩

/-- 空のチャネル環境からはどこへでも行ける（関数本体の型付け Ξ = ∅ を呼び出し先の世界へ） -/
theorem chanLE_nil (Ξ : ChanTy) : ChanLE ∅ Ξ :=
  ⟨fun _ _ h => by simp at h, fun _ _ h => by simp at h, fun _ _ h => by simp at h⟩

theorem ChanLE.trans {Ξ₁ Ξ₂ Ξ₃ : ChanTy} (h1 : ChanLE Ξ₁ Ξ₂) (h2 : ChanLE Ξ₂ Ξ₃) : ChanLE Ξ₁ Ξ₃ :=
  ⟨fun c p h => h2.ch c p (h1.ch c p h), fun k t h => h2.ep k t (h1.ep k t h), fun n p h => h2.tk n p (h1.tk n p h)⟩

theorem chanLE_addCh (Ξ : ChanTy) (p : StoreTy × Ty) : ChanLE Ξ (Ξ.addCh p) := by
  refine ⟨?_, fun _ _ h => h, fun _ _ h => h⟩
  intro c q h
  have hc : c < Ξ.ch.length := (List.getElem?_eq_some_iff.mp h).1
  simp only [ChanTy.addCh]
  rw [List.getElem?_append_left hc]
  exact h

/-- rc ≤ f のとき、take f のプレフィクス一致は take rc の一致に落ちる
（chanV のスナップショット等式の transport） -/
theorem take_eq_of_take_floor {Ψ Ψ' : StoreTy} {f rc : Nat}
    (hpre : Ψ'.take f = Ψ.take f) (hrc : rc ≤ f) : Ψ'.take rc = Ψ.take rc := by
  have h1 : Ψ'.take rc = (Ψ'.take f).take rc := by
    rw [List.take_take, Nat.min_eq_left hrc]
  have h2 : Ψ.take rc = (Ψ.take f).take rc := by
    rw [List.take_take, Nat.min_eq_left hrc]
  rw [h1, h2, hpre]

/-- store_mono のプレフィクス条件: 床 f 以下かつ元ストアの長さ以下の take が一致する。
長さ条件が要るのは、セル型付け（store Ψ.take (r+1)）を全体へ運ぶとき
f = b がストア長を超え得るため — chanV のスナップショットは元ストアに収まる長さしかない -/
def StorePre (f : Nat) (Ψ Ψ' : StoreTy) : Prop :=
  ∀ n, n ≤ f → n ≤ Ψ.length → Ψ'.take n = Ψ.take n

/-- take f の等式から StorePre を作る（ストア遷移の標準供給口） -/
theorem storePre_of_take_eq {Ψ Ψ' : StoreTy} {f : Nat} (h : Ψ'.take f = Ψ.take f) :
    StorePre f Ψ Ψ' :=
  fun _ hn _ => take_eq_of_take_floor h hn

/-- take d の部分ストアから全体へは常に StorePre（プレフィクスの取り出しなので） -/
theorem storePre_take_self (Ψ : StoreTy) (d f : Nat) : StorePre f (Ψ.take d) Ψ := by
  intro n _ hn
  simp only [List.length_take] at hn
  rw [List.take_take, Nat.min_eq_left (by omega)]

namespace HasType

/-- ストア単調性: lookup を保存し、床 f 以下のプレフィクスを変えない Ψ の取り替えで
型付けは保たれる。プレフィクス条件（StorePre）は chanV のスナップショット等式のため -/
theorem store_mono {e : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ Ψ' : StoreTy} {f b d : Nat} {Γ : Ctx} {t : Ty}
    (hle : StoreLE Ψ Ψ') (hpre : StorePre f Ψ Ψ')
    (he : HasType Δ Ξ Ψ f b d Γ Λ e t) : HasType Δ Ξ Ψ' f b d Γ Λ e t := by
  induction e generalizing b d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i => cases he with | var h => exact .var h
  | letE e b ihe ihb => cases he with | letE h1 h2 => exact .letE (ihe h1) (ihb h2)
  | add a b iha ihb => cases he with | add h1 h2 => exact .add (iha h1) (ihb h2)
  | lt a b iha ihb => cases he with | lt h1 h2 => exact .lt (iha h1) (ihb h2)
  | arith op a b iha ihb => cases he with | arith h1 h2 => exact .arith (iha h1) (ihb h2)
  | farith op a b iha ihb => cases he with | farith h1 h2 => exact .farith (iha h1) (ihb h2)
  | cmp op a b iha ihb => cases he with | cmp h1 h2 => exact .cmp (iha h1) (ihb h2)
  | fcmp op a b iha ihb => cases he with | fcmp h1 h2 => exact .fcmp (iha h1) (ihb h2)
  | ite c th el ihc iht ihe =>
    cases he with | ite h1 h2 h3 => exact .ite (ihc h1) (iht h2) (ihe h3)
  | nil t => cases he; exact .nil
  | some e ihe => cases he with | some h => exact .some (ihe h)
  | pair a b iha ihb => cases he with | pair h1 h2 => exact .pair (iha h1) (ihb h2)
  | fst e ihe => cases he with | fst h => exact .fst (ihe h)
  | ann e t ihe => cases he with | ann h hs => exact .ann (ihe h) hs
  | snd e ihe => cases he with | snd h => exact .snd (ihe h)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    cases he with | callv hf h hsub hbd => exact .callv (ihf hf) (ihe h) hsub hbd
  | call fn ts e ihe => cases he with | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe h) hsub hbd
  | callM fn ts e ihe => cases he with | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe h) hanc hsub hbd had
  | ifnil e n s ihe ihn ihs =>
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe h1) (ihn h2) (ihs h3)
  | inl r e ihe => cases he with | inl h => exact .inl (ihe h)
  | inr l e ihe => cases he with | inr h => exact .inr (ihe h)
  | case e bl br ihe ihl ihr =>
    cases he with | case h1 h2 h3 => exact .case (ihe h1) (ihl h2) (ihr h3)
  | block e ihe => cases he with | block h hb => exact .block (ihe h) hb
  | blockR t e ihe => cases he with | blockR h hr hb => exact .blockR (ihe h) hr hb
  | copyTo k t e ihe => cases he with | copyTo h hk hr hb hc => exact .copyTo (ihe h) hk hr hb hc
  | label t e ihe => cases he with | label h hb => exact .label (ihe h) hb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe => cases he with | jump hn h hr => exact .jump hn (ihe h) hr
  | alloc m e ihe =>
    cases he with | alloc h hb hbd hmf => exact .alloc (ihe h) hb hbd hmf
  | deref e ihe => cases he with | deref h => exact .deref (ihe h)
  | assign l e ihl ihe => cases he with | assign h1 h2 => exact .assign (ihl h1) (ihe h2)
  | whileE c b ihc ihb => cases he with | whileE h1 h2 => exact .whileE (ihc h1) (ihb h2)
  | freeze e ihe =>
    cases he with
    | freeze h hm => exact .freeze (ihe h) hm
    | freezes h hm => exact .freezes (ihe h) hm
    | freezem h hm => exact .freezem (ihe h) hm
  | par e1 e2 ih1 ih2 =>
    cases he with | par h1 h2 hΓ => exact .par (ih1 h1) (ih2 h2) hΓ
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf => exact .parch (ih1 h1) (ih2 h2) hΓ hrb hmf
  | newchan rc t => cases he with | newchan hf hl hm => exact .newchan hf hl hm
  | send c e ihc ihe => cases he with
    | send h1 h2 => exact .send (ihc h1) (ihe h2)
    | sendE h1 h2 hp => exact .sendE (ihc h1) (ihe h2) hp
  | recv c ihc => cases he with
    | recv h => exact .recv (ihc h)
    | recvE h hm hc => exact .recvE (ihc h) hm hc
  | close c ihc => cases he with
    | closeE h => exact .closeE (ihc h)
  | mkslice m t => cases he with | mkslice h1 h2 h3 => exact .mkslice h1 h2 h3
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 h2 h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 h2 h3 h4 h5
  | index e i ot ihe ihi => cases he with | index h1 h2 hrd => exact .index (ihe h1) (ihi h2) hrd
  | lenE e ihe => cases he with | lenE h => exact .lenE (ihe h)
  | tobyte e ihe => cases he with | tobyte h => exact .tobyte (ihe h)
  | fconv op e ihe => cases he with | fconv h => exact .fconv (ihe h)
  | toint e ihe => cases he with | toint h => exact .toint (ihe h)
  | append e v ihe ihv =>
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe h1) (ihv h2) h3
    | appendI h1 h2 h3 h4 => exact .appendI (ihe h1) (ihv h2) h3 h4
  | setidx e i v ihe ihi ihv =>
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe h1) (ihi h2) (ihv h3)
  | subslice e sa sb ihe iha ihb =>
    cases he with | subslice h1 h2 h3 => exact .subslice (ihe h1) (iha h2) (ihb h3)
  | eqs e1 e2 ih1 ih2 =>
    cases he with | eqs h1 h2 => exact .eqs (ih1 h1) (ih2 h2)
  | concat e1 e2 ih1 ih2 =>
    cases he with | concat h1 h2 h3 => exact .concat (ih1 h1) (ih2 h2) h3
  | slicev mt r base len =>
    cases he with
    | slicev hk h3 h4 h5 h6 h7 h8 =>
      refine .slicev (fun k hkl => ?_) h3 h4 h5 h6 h7 h8
      obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, hex⟩ := hk k hkl
      obtain ⟨ρ', mk', hΨ', hρ', hmm'⟩ := hle r (base + k) _ _ ⟨_, hΨ, hρ⟩
      exact ⟨ρ', mk', tc, hΨ', hρ', fun hm => hmm' (hmm hm), hsc, hex⟩
  | mkmap m t => cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 h2 h3
  | getm t e k ihe ihk => cases he with | getm h1 h2 hkc hsub => exact .getm (ihe h1) (ihk h2) hkc hsub
  | setm e k v ihe ihk ihv =>
    cases he with | setm h1 h2 h3 => exact .setm (ihe h1) (ihk h2) (ihv h3)
  | delm t e k ihe ihk => cases he with | delm h1 h2 hkc => exact .delm (ihe h1) (ihk h2) hkc
  | lenm e ihe => cases he with | lenm h => exact .lenm (ihe h)
  | keysm e ihe => cases he with | keysm h h1 h2 h3 => exact .keysm (ihe h) h1 h2 h3
  | mapv mt r base len =>
    cases he with
    | mapv hk h3 h4 h5 h6 h7 h8 =>
      refine .mapv (fun k hkl => ?_) h3 h4 h5 h6 h7 h8
      obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, hex⟩ := hk k hkl
      obtain ⟨ρ', mk', hΨ', hρ', hmm'⟩ := hle r (base + k) _ _ ⟨_, hΨ, hρ⟩
      exact ⟨ρ', mk', tc, hΨ', hρ', fun hm => hmm' (hmm hm), hsc, hex⟩
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 =>
      obtain ⟨ρ', m'', hΨ', hρ', hmm⟩ := hle r a _ _ ⟨_, h1, h2⟩
      exact .loc hΨ' hρ' h3 h4 h5 (fun hm => hmm (h6 hm))
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 =>
      rename_i Ψc t'
      have hrc : Ψc.length ≤ Ψ.length := by
        have h := congrArg List.length h2
        simp only [List.length_take] at h
        omega
      exact .chanV h1 (by rw [hpre _ h3 hrc]; exact h2) h3
  | scope t ε e ihe => cases he with | scope h hr hb hem hec hbd => exact .scope (ihe h) hr hb hem hec hbd
  | spawn sc a e ihsc iha ihe => cases he with | spawn h1 ha hg h2 hrb hcf hε => exact .spawn (ihsc h1) (iha ha) hg (ihe h2) hrb hcf hε
  | join tj h ihh => cases he with | join h1 => exact .join (ihh h1)
  | tryJ t h ihh => cases he with | tryJ h1 => exact .tryJ (ihh h1)
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 h3
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch h1 h2 h3 h4 h5 h6
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 h3
    | epRx h1 h2 h3 => exact .epRx h1 h2 h3

/-- チャネル環境の単調性: Ξ が伸びても型付けは保たれる -/
theorem chan_mono {e : Expr} {Ξ Ξ' : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {t : Ty}
    (hle : ChanLE Ξ Ξ') (he : HasType Δ Ξ Ψ f b d Γ Λ e t) : HasType Δ Ξ' Ψ f b d Γ Λ e t := by
  induction e generalizing b d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i => cases he with | var h => exact .var h
  | letE e b ihe ihb => cases he with | letE h1 h2 => exact .letE (ihe h1) (ihb h2)
  | add a b iha ihb => cases he with | add h1 h2 => exact .add (iha h1) (ihb h2)
  | lt a b iha ihb => cases he with | lt h1 h2 => exact .lt (iha h1) (ihb h2)
  | arith op a b iha ihb => cases he with | arith h1 h2 => exact .arith (iha h1) (ihb h2)
  | farith op a b iha ihb => cases he with | farith h1 h2 => exact .farith (iha h1) (ihb h2)
  | cmp op a b iha ihb => cases he with | cmp h1 h2 => exact .cmp (iha h1) (ihb h2)
  | fcmp op a b iha ihb => cases he with | fcmp h1 h2 => exact .fcmp (iha h1) (ihb h2)
  | ite c th el ihc iht ihe =>
    cases he with | ite h1 h2 h3 => exact .ite (ihc h1) (iht h2) (ihe h3)
  | nil t => cases he; exact .nil
  | some e ihe => cases he with | some h => exact .some (ihe h)
  | pair a b iha ihb => cases he with | pair h1 h2 => exact .pair (iha h1) (ihb h2)
  | fst e ihe => cases he with | fst h => exact .fst (ihe h)
  | ann e t ihe => cases he with | ann h hs => exact .ann (ihe h) hs
  | snd e ihe => cases he with | snd h => exact .snd (ihe h)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    cases he with | callv hf h hsub hbd => exact .callv (ihf hf) (ihe h) hsub hbd
  | call fn ts e ihe => cases he with | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe h) hsub hbd
  | callM fn ts e ihe => cases he with | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe h) hanc hsub hbd had
  | ifnil e n s ihe ihn ihs =>
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe h1) (ihn h2) (ihs h3)
  | inl r e ihe => cases he with | inl h => exact .inl (ihe h)
  | inr l e ihe => cases he with | inr h => exact .inr (ihe h)
  | case e bl br ihe ihl ihr =>
    cases he with | case h1 h2 h3 => exact .case (ihe h1) (ihl h2) (ihr h3)
  | block e ihe => cases he with | block h hb => exact .block (ihe h) hb
  | blockR t e ihe => cases he with | blockR h hr hb => exact .blockR (ihe h) hr hb
  | copyTo k t e ihe => cases he with | copyTo h hk hr hb hc => exact .copyTo (ihe h) hk hr hb hc
  | label t e ihe => cases he with | label h hb => exact .label (ihe h) hb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe => cases he with | jump hn h hr => exact .jump hn (ihe h) hr
  | alloc m e ihe =>
    cases he with | alloc h hb hbd hmf => exact .alloc (ihe h) hb hbd hmf
  | deref e ihe => cases he with | deref h => exact .deref (ihe h)
  | assign l e ihl ihe => cases he with | assign h1 h2 => exact .assign (ihl h1) (ihe h2)
  | whileE c b ihc ihb => cases he with | whileE h1 h2 => exact .whileE (ihc h1) (ihb h2)
  | freeze e ihe =>
    cases he with
    | freeze h hm => exact .freeze (ihe h) hm
    | freezes h hm => exact .freezes (ihe h) hm
    | freezem h hm => exact .freezem (ihe h) hm
  | par e1 e2 ih1 ih2 =>
    cases he with | par h1 h2 hΓ => exact .par (ih1 h1) (ih2 h2) hΓ
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf => exact .parch (ih1 h1) (ih2 h2) hΓ hrb hmf
  | newchan rc t => cases he with | newchan hf hl hm => exact .newchan hf hl hm
  | send c e ihc ihe => cases he with
    | send h1 h2 => exact .send (ihc h1) (ihe h2)
    | sendE h1 h2 hp => exact .sendE (ihc h1) (ihe h2) hp
  | recv c ihc => cases he with
    | recv h => exact .recv (ihc h)
    | recvE h hm hc => exact .recvE (ihc h) hm hc
  | close c ihc => cases he with
    | closeE h => exact .closeE (ihc h)
  | mkslice m t => cases he with | mkslice h1 h2 h3 => exact .mkslice h1 h2 h3
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 h2 h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 h2 h3 h4 h5
  | index e i ot ihe ihi => cases he with | index h1 h2 hrd => exact .index (ihe h1) (ihi h2) hrd
  | lenE e ihe => cases he with | lenE h => exact .lenE (ihe h)
  | tobyte e ihe => cases he with | tobyte h => exact .tobyte (ihe h)
  | fconv op e ihe => cases he with | fconv h => exact .fconv (ihe h)
  | toint e ihe => cases he with | toint h => exact .toint (ihe h)
  | append e v ihe ihv =>
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe h1) (ihv h2) h3
    | appendI h1 h2 h3 h4 => exact .appendI (ihe h1) (ihv h2) h3 h4
  | setidx e i v ihe ihi ihv =>
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe h1) (ihi h2) (ihv h3)
  | subslice e sa sb ihe iha ihb =>
    cases he with | subslice h1 h2 h3 => exact .subslice (ihe h1) (iha h2) (ihb h3)
  | eqs e1 e2 ih1 ih2 =>
    cases he with | eqs h1 h2 => exact .eqs (ih1 h1) (ih2 h2)
  | concat e1 e2 ih1 ih2 =>
    cases he with | concat h1 h2 h3 => exact .concat (ih1 h1) (ih2 h2) h3
  | slicev mt r base len =>
    cases he with | slicev hk h3 h4 h5a h5b h6 h7 => exact .slicev hk h3 h4 h5a h5b h6 h7
  | mkmap m t => cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 h2 h3
  | getm t e k ihe ihk => cases he with | getm h1 h2 hkc hsub => exact .getm (ihe h1) (ihk h2) hkc hsub
  | setm e k v ihe ihk ihv =>
    cases he with | setm h1 h2 h3 => exact .setm (ihe h1) (ihk h2) (ihv h3)
  | delm t e k ihe ihk => cases he with | delm h1 h2 hkc => exact .delm (ihe h1) (ihk h2) hkc
  | lenm e ihe => cases he with | lenm h => exact .lenm (ihe h)
  | keysm e ihe => cases he with | keysm h h1 h2 h3 => exact .keysm (ihe h) h1 h2 h3
  | mapv mt r base len =>
    cases he with | mapv hk h3 h4 h5a h5b h6 h7 => exact .mapv hk h3 h4 h5a h5b h6 h7
  | loc r a =>
    cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | chanV c =>
    cases he with | chanV h1 h2 h3 => exact .chanV (hle.ch _ _ h1) h2 h3
  | scope t ε e ihe => cases he with | scope h hr hb hem hec hbd => exact .scope (ihe h) hr hb hem hec hbd
  | spawn sc a e ihsc iha ihe => cases he with | spawn h1 ha hg h2 hrb hcf hε => exact .spawn (ihsc h1) (iha ha) hg (ihe h2) hrb hcf hε
  | join tj h ihh => cases he with | join h1 => exact .join (ihh h1)
  | tryJ t h ihh => cases he with | tryJ h1 => exact .tryJ (ihh h1)
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 (hle.tk _ _ h3)
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch h1 h2 h3 h4 h5 h6
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 (hle.ep _ _ h3)
    | epRx h1 h2 h3 => exact .epRx h1 h2 (hle.ep _ _ h3)

/-- 床の単調性: f は chanV / newchan の `rc ≤ f` にしか現れないので、上げても保たれる。
spawn（f を b = d へ引き上げ）と recv（キューの世界 f = rc から受け手の f へ）で使う -/
theorem f_mono {e : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f f' b d : Nat} {Γ : Ctx} {t : Ty}
    (hf : f ≤ f') (he : HasType Δ Ξ Ψ f b d Γ Λ e t) : HasType Δ Ξ Ψ f' b d Γ Λ e t := by
  induction e generalizing b d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i => cases he with | var h => exact .var h
  | letE e b ihe ihb => cases he with | letE h1 h2 => exact .letE (ihe h1) (ihb h2)
  | add a b iha ihb => cases he with | add h1 h2 => exact .add (iha h1) (ihb h2)
  | lt a b iha ihb => cases he with | lt h1 h2 => exact .lt (iha h1) (ihb h2)
  | arith op a b iha ihb => cases he with | arith h1 h2 => exact .arith (iha h1) (ihb h2)
  | farith op a b iha ihb => cases he with | farith h1 h2 => exact .farith (iha h1) (ihb h2)
  | cmp op a b iha ihb => cases he with | cmp h1 h2 => exact .cmp (iha h1) (ihb h2)
  | fcmp op a b iha ihb => cases he with | fcmp h1 h2 => exact .fcmp (iha h1) (ihb h2)
  | ite c th el ihc iht ihe =>
    cases he with | ite h1 h2 h3 => exact .ite (ihc h1) (iht h2) (ihe h3)
  | nil t => cases he; exact .nil
  | some e ihe => cases he with | some h => exact .some (ihe h)
  | pair a b iha ihb => cases he with | pair h1 h2 => exact .pair (iha h1) (ihb h2)
  | fst e ihe => cases he with | fst h => exact .fst (ihe h)
  | ann e t ihe => cases he with | ann h hs => exact .ann (ihe h) hs
  | snd e ihe => cases he with | snd h => exact .snd (ihe h)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    cases he with | callv hf h hsub hbd => exact .callv (ihf hf) (ihe h) hsub hbd
  | call fn ts e ihe => cases he with | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe h) hsub hbd
  | callM fn ts e ihe => cases he with | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe h) hanc hsub hbd had
  | ifnil e n s ihe ihn ihs =>
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe h1) (ihn h2) (ihs h3)
  | inl r e ihe => cases he with | inl h => exact .inl (ihe h)
  | inr l e ihe => cases he with | inr h => exact .inr (ihe h)
  | case e bl br ihe ihl ihr =>
    cases he with | case h1 h2 h3 => exact .case (ihe h1) (ihl h2) (ihr h3)
  | block e ihe => cases he with | block h hb => exact .block (ihe h) hb
  | blockR t e ihe => cases he with | blockR h hr hb => exact .blockR (ihe h) hr hb
  | copyTo k t e ihe => cases he with | copyTo h hk hr hb hc => exact .copyTo (ihe h) hk hr hb hc
  | label t e ihe => cases he with | label h hb => exact .label (ihe h) hb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe => cases he with | jump hn h hr => exact .jump hn (ihe h) hr
  | alloc m e ihe =>
    cases he with | alloc h hb hbd hmf => exact .alloc (ihe h) hb hbd hmf
  | deref e ihe => cases he with | deref h => exact .deref (ihe h)
  | assign l e ihl ihe => cases he with | assign h1 h2 => exact .assign (ihl h1) (ihe h2)
  | whileE c b ihc ihb => cases he with | whileE h1 h2 => exact .whileE (ihc h1) (ihb h2)
  | freeze e ihe =>
    cases he with
    | freeze h hm => exact .freeze (ihe h) hm
    | freezes h hm => exact .freezes (ihe h) hm
    | freezem h hm => exact .freezem (ihe h) hm
  | par e1 e2 ih1 ih2 =>
    cases he with | par h1 h2 hΓ => exact .par (ih1 h1) (ih2 h2) hΓ
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf => exact .parch (ih1 h1) (ih2 h2) hΓ hrb hmf
  | newchan rc t =>
    cases he with | newchan hrf hl hm => exact .newchan (Nat.le_trans hrf hf) hl hm
  | send c e ihc ihe => cases he with
    | send h1 h2 => exact .send (ihc h1) (ihe h2)
    | sendE h1 h2 hp => exact .sendE (ihc h1) (ihe h2) hp
  | recv c ihc => cases he with
    | recv h => exact .recv (ihc h)
    | recvE h hm hc => exact .recvE (ihc h) hm hc
  | close c ihc => cases he with
    | closeE h => exact .closeE (ihc h)
  | mkslice m t => cases he with | mkslice h1 h2 h3 => exact .mkslice h1 h2 h3
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 h2 h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 h2 h3 h4 h5
  | index e i ot ihe ihi => cases he with | index h1 h2 hrd => exact .index (ihe h1) (ihi h2) hrd
  | lenE e ihe => cases he with | lenE h => exact .lenE (ihe h)
  | tobyte e ihe => cases he with | tobyte h => exact .tobyte (ihe h)
  | fconv op e ihe => cases he with | fconv h => exact .fconv (ihe h)
  | toint e ihe => cases he with | toint h => exact .toint (ihe h)
  | append e v ihe ihv =>
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe h1) (ihv h2) h3
    | appendI h1 h2 h3 h4 => exact .appendI (ihe h1) (ihv h2) h3 h4
  | setidx e i v ihe ihi ihv =>
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe h1) (ihi h2) (ihv h3)
  | subslice e sa sb ihe iha ihb =>
    cases he with | subslice h1 h2 h3 => exact .subslice (ihe h1) (iha h2) (ihb h3)
  | eqs e1 e2 ih1 ih2 =>
    cases he with | eqs h1 h2 => exact .eqs (ih1 h1) (ih2 h2)
  | concat e1 e2 ih1 ih2 =>
    cases he with | concat h1 h2 h3 => exact .concat (ih1 h1) (ih2 h2) h3
  | slicev mt r base len =>
    cases he with | slicev hk h3 h4 h5a h5b h6 h7 => exact .slicev hk h3 h4 h5a h5b h6 h7
  | mkmap m t => cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 h2 h3
  | getm t e k ihe ihk => cases he with | getm h1 h2 hkc hsub => exact .getm (ihe h1) (ihk h2) hkc hsub
  | setm e k v ihe ihk ihv =>
    cases he with | setm h1 h2 h3 => exact .setm (ihe h1) (ihk h2) (ihv h3)
  | delm t e k ihe ihk => cases he with | delm h1 h2 hkc => exact .delm (ihe h1) (ihk h2) hkc
  | lenm e ihe => cases he with | lenm h => exact .lenm (ihe h)
  | keysm e ihe => cases he with | keysm h h1 h2 h3 => exact .keysm (ihe h) h1 h2 h3
  | mapv mt r base len =>
    cases he with | mapv hk h3 h4 h5a h5b h6 h7 => exact .mapv hk h3 h4 h5a h5b h6 h7
  | loc r a =>
    cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | chanV c =>
    cases he with | chanV h1 h2 h3 => exact .chanV h1 h2 (Nat.le_trans h3 hf)
  | scope t ε e ihe => cases he with | scope h hr hb hem hec hbd => exact .scope (ihe h) hr hb hem hec hbd
  | spawn sc a e ihsc iha ihe => cases he with | spawn h1 ha hg h2 hrb hcf hε => exact .spawn (ihsc h1) (iha ha) hg (ihe h2) hrb hcf hε
  | join tj h ihh => cases he with | join h1 => exact .join (ihh h1)
  | tryJ t h ihh => cases he with | tryJ h1 => exact .tryJ (ihh h1)
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 h3
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch h1 h2 h3 h4 h5 h6
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 h3
    | epRx h1 h2 h3 => exact .epRx h1 h2 h3

/-- 値の深さ weakening: 値は alloc / block を含まないので深さを上げてよい -/
theorem value_depth_weaken {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d d' : Nat} {Γ : Ctx}
    {t : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) (hd : d ≤ d') :
    HasType Δ Ξ Ψ f b d' Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih => cases he with | some h => exact .some (ih h)
  | pair _ _ iha ihb => cases he with | pair h1 h2 => exact .pair (iha h1) (ihb h2)
  | inl r _ ih => cases he with | inl h => exact .inl (ih h)
  | inr l _ ih => cases he with | inr h => exact .inr (ih h)
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4 h5 h6 h7 =>
      exact .slicev hk (Nat.lt_of_lt_of_le h2 hd) h3 h4 h5 h6 h7
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4 h5 h6 h7 =>
      exact .mapv hk (Nat.lt_of_lt_of_le h2 hd) h3 h4 h5 h6 h7
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 (Nat.lt_of_lt_of_le h3 hd) h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c => cases he with | chanV h1 h2 h3 => exact .chanV h1 h2 h3
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 (by omega)
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 (by omega) h3
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 (by omega) h3
    | epRx h1 h2 h3 => exact .epRx h1 (by omega) h3

/-- 値の strengthening: 型が region < d しか言及しないなら、
値は任意の元深さから深さ d・先頭 d region のストア型で型付けし直せる
（pop と、代入で古い region のセルに書くときの要）。共有境界 b と床 f は素通し
（chanV のスナップショット等式は rc ≤ d — 型の regionsBelow から — で take が縮む） -/
theorem value_strengthen {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b D d : Nat} {Γ : Ctx}
    {t : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b D Γ Λ v t) (hb : t.regionsBelow d) :
    HasType Δ Ξ (Ψ.take d) f b d Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih =>
    cases he with
    | some h => exact .some (ih h (by simpa [Ty.regionsBelow] using hb))
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .pair (iha h1 hb.1) (ihb h2 hb.2)
  | inl r _ ih =>
    cases he with
    | inl h =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .inl (ih h hb.1)
  | inr l _ ih =>
    cases he with
    | inr h =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .inr (ih h hb.2)
  | slicev mt r base len =>
    cases he with
    | slicev hk _ h3 h4 h5 h6 h7 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb
      -- 型 region rt の床（hb.1 : rt < d）から実 region の床（r ≤ rt）を経由する
      refine .slicev (fun k hkl => ?_) (Nat.lt_of_le_of_lt h3 hb.1) h3 h4 h5 h6 h7
      obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, hex⟩ := hk k hkl
      exact ⟨ρ, mk, tc, by rw [List.getElem?_take_of_lt (Nat.lt_of_le_of_lt h3 hb.1)]; exact hΨ,
        hρ, hmm, hsc, hex⟩
  | mapv mt r base len =>
    cases he with
    | mapv hk _ h3 h4 h5 h6 h7 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb
      refine .mapv (fun k hkl => ?_) (Nat.lt_of_le_of_lt h3 hb.1) h3 h4 h5 h6 h7
      obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, hex⟩ := hk k hkl
      exact ⟨ρ, mk, tc, by rw [List.getElem?_take_of_lt (Nat.lt_of_le_of_lt h3 hb.1)]; exact hΨ,
        hρ, hmm, hsc, hex⟩
  | loc r a =>
    cases he with
    | loc h1 h2 _ h4 h5 h6 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb
      exact .loc (by rw [List.getElem?_take_of_lt (Nat.lt_of_le_of_lt h4 hb.1)]; exact h1) h2
        (Nat.lt_of_le_of_lt h4 hb.1) h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb
      refine .chanV h1 ?_ h3
      rw [List.take_take, Nat.min_eq_left hb.1]
      exact h2
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 (by simp [Ty.regionsBelow] at hb; omega)
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 (by simp [Ty.regionsBelow] at hb; omega) h3
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 (by simp [Ty.regionsBelow] at hb; omega) h3
    | epRx h1 h2 h3 => exact .epRx h1 (by simp [Ty.regionsBelow] at hb; omega) h3

/-- 値の共有境界の付け替え: mutFree 型の値の loc はすべて immutable セルを指すので、
loc 規則の条件が `m = false` 側で立ち、b を任意に取り替えられる（par の置換の要）。
chanV は b に依存しない -/
theorem value_sb {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b b' d : Nat} {Γ : Ctx} {t : Ty}
    (hv : Value v) (hm : t.mutFree) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) :
    HasType Δ Ξ Ψ f b' d Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih =>
    cases he with
    | some h => exact .some (ih (by simpa [Ty.mutFree] using hm) h)
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .pair (iha hm.1 h1) (ihb hm.2 h2)
  | inl r _ ih =>
    cases he with
    | inl h =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .inl (ih hm.1 h)
  | inr l _ ih =>
    cases he with
    | inr h =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .inr (ih hm.2 h)
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4 _ h6 h7 =>
      simp only [Ty.mutFree, Bool.and_eq_true, Bool.not_eq_true'] at hm
      exact .slicev hk h2 h3 h4 (fun h => by simp [hm.1] at h) h6 h7
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4 _ h6 h7 =>
      simp only [Ty.mutFree, Bool.and_eq_true, Bool.not_eq_true'] at hm
      exact .mapv hk h2 h3 h4 (fun h => by simp [hm.1] at h) h6 h7
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 _ h6 =>
      simp only [Ty.mutFree, Bool.and_eq_true, Bool.not_eq_true'] at hm
      -- m = false なので b の条件（m = true → rt = r ∧ b ≤ r）が空に立ち、b を自由に替えられる
      exact .loc h1 h2 h3 h4 (fun h => by simp [hm.1] at h) h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c => cases he with | chanV h1 h2 h3 => exact .chanV h1 h2 h3
  | scopeV rs ε => cases he; simp [Ty.mutFree] at hm
  | taskV rs n => cases he; simp [Ty.mutFree] at hm
  | epV p k b r => cases he <;> simp [Ty.mutFree] at hm

/-- 値の世界の付け替え（段 6 P1）: mutFree な値の型付けは世界ごとの部分（子の表 tk）を引かない — handle（taskV）は
mutFree でないので現れない。共有の部分（旧 chan の表 ch）が同じなら別の task の世界へ移せる -/
theorem value_world {v : Expr} {Δ : Defs} {Ξ Ξ' : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {t : Ty}
    (hv : Value v) (hm : t.mutFree) (hch : Ξ'.ch = Ξ.ch) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) :
    HasType Δ Ξ' Ψ f b d Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih =>
    cases he with
    | some h => exact .some (ih (by simpa [Ty.mutFree] using hm) h)
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .pair (iha hm.1 h1) (ihb hm.2 h2)
  | inl r _ ih =>
    cases he with
    | inl h =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .inl (ih hm.1 h)
  | inr l _ ih =>
    cases he with
    | inr h =>
      simp only [Ty.mutFree, Bool.and_eq_true] at hm
      exact .inr (ih hm.2 h)
  | slicev mt r base len => cases he with | slicev hk h2 h3 h4 h5 h6 h7 => exact .slicev hk h2 h3 h4 h5 h6 h7
  | mapv mt r base len => cases he with | mapv hk h2 h3 h4 h5 h6 h7 => exact .mapv hk h2 h3 h4 h5 h6 h7
  | loc r a => cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c => cases he with | chanV h1 h2 h3 => exact .chanV (by rw [hch]; exact h1) h2 h3
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he; simp [Ty.mutFree] at hm
  | epV p k b r => cases he <;> simp [Ty.mutFree] at hm

/-- 値の型環境の付け替え（段 6 P1 — 端点のペイロード）: mutFree で chan なしの値の型付けは型環境 Ξ をどこも引かない
（chanV は chan なしで、handle・端点・札は mutFree でないので現れない）。任意の Ξ' へ移せる -/
theorem value_anyΞ {v : Expr} {Δ : Defs} {Ξ Ξ' : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {t : Ty}
    (hv : Value v) (hm : t.mutFree) (hc : t.chanFree) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) :
    HasType Δ Ξ' Ψ f b d Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih =>
    cases he with
    | some h => exact .some (ih (by simpa [Ty.mutFree] using hm) (by simpa [Ty.chanFree] using hc) h)
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
      exact .pair (iha hm.1 hc.1 h1) (ihb hm.2 hc.2 h2)
  | inl r _ ih =>
    cases he with
    | inl h =>
      simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
      exact .inl (ih hm.1 hc.1 h)
  | inr l _ ih =>
    cases he with
    | inr h =>
      simp only [Ty.mutFree, Ty.chanFree, Bool.and_eq_true] at hm hc
      exact .inr (ih hm.2 hc.2 h)
  | slicev mt r base len => cases he with | slicev hk h2 h3 h4 h5 h6 h7 => exact .slicev hk h2 h3 h4 h5 h6 h7
  | mapv mt r base len => cases he with | mapv hk h2 h3 h4 h5 h6 h7 => exact .mapv hk h2 h3 h4 h5 h6 h7
  | loc r a => cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c => cases he; simp [Ty.chanFree] at hc
  | scopeV rs ε => cases he; simp [Ty.mutFree] at hm
  | taskV rs n => cases he; simp [Ty.mutFree] at hm
  | epV p k b r => cases he <;> simp [Ty.mutFree] at hm

/-- 値の床の付け替え: 型の regionsBelow n から値の全 chanV の rc ≤ n が出るので、
f を n に取り替えられる（send がペイロードをキューの世界 f = rc へ落とすときの要）。
loc / newchan なし（値）なので f の他の利用者はいない -/
theorem value_f_set {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f n b d : Nat} {Γ : Ctx} {t : Ty}
    (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) (hb : t.regionsBelow n) :
    HasType Δ Ξ Ψ n b d Γ Λ v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih =>
    cases he with
    | some h => exact .some (ih h (by simpa [Ty.regionsBelow] using hb))
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .pair (iha h1 hb.1) (ihb h2 hb.2)
  | inl r _ ih =>
    cases he with
    | inl h =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .inl (ih h hb.1)
  | inr l _ ih =>
    cases he with
    | inr h =>
      simp only [Ty.regionsBelow, Bool.and_eq_true] at hb
      exact .inr (ih h hb.2)
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4a h4b h5 h6 => exact .slicev hk h2 h3 h4a h4b h5 h6
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4a h4b h5 h6 => exact .mapv hk h2 h3 h4a h4b h5 h6
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 =>
      simp only [Ty.regionsBelow, Bool.and_eq_true, decide_eq_true_eq] at hb
      exact .chanV h1 h2 hb.1
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 h3
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 h3
    | epRx h1 h2 h3 => exact .epRx h1 h2 h3

/-- 値は自由変数を含まないので、どの文脈でも型が付く（一般の weakening は par の
「Γ は全部 mutFree」条件と両立しないため、値に限る。使用箇所は置換補題の値のみ） -/
theorem value_ctx {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ Γ' : Ctx} {Λ Λ' : LCtx} {t : Ty}
    (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) : HasType Δ Ξ Ψ f b d Γ' Λ' v t := by
  induction hv generalizing t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | nil t => cases he; exact .nil
  | some _ ih => cases he with | some h => exact .some (ih h)
  | pair _ _ iha ihb => cases he with | pair h1 h2 => exact .pair (iha h1) (ihb h2)
  | inl r _ ih => cases he with | inl h => exact .inl (ih h)
  | inr l _ ih => cases he with | inr h => exact .inr (ih h)
  | slicev mt r base len =>
    cases he with | slicev hk h2 h3 h4a h4b h5 h6 => exact .slicev hk h2 h3 h4a h4b h5 h6
  | mapv mt r base len =>
    cases he with | mapv hk h2 h3 h4a h4b h5 h6 => exact .mapv hk h2 h3 h4a h4b h5 h6
  | loc r a => cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | chanV c => cases he with | chanV h1 h2 h3 => exact .chanV h1 h2 h3
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 h3
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 h3
    | epRx h1 h2 h3 => exact .epRx h1 h2 h3

/-- value_ctx の shift 版（置換補題が束縛を潜るときの形） -/
theorem value_shift_ctx {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ Γ' : Ctx}
    {t : Ty} {c : Nat} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t) :
    HasType Δ Ξ Ψ f b d Γ' Λ (v.shift c) t := by
  rw [hv.shift_eq]
  exact value_ctx hv he

/-- 置換補題: `Γ₁ ++ t' :: Γ₂` で e が t、`Γ₁ ++ Γ₂` で値 v が t' なら、
`var Γ₁.length` を v で置き換えた e は `Γ₁ ++ Γ₂` で t。
v の値性は block（深さ +1）と par / parch（共有境界の付け替え）を潜るときに要る -/
theorem subst_preserve {e : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ₁ Γ₂ : Ctx}
    {v : Expr} {t t' : Ty}
    (he : HasType Δ Ξ Ψ f b d (Γ₁ ++ t' :: Γ₂) Λ e t) (hvv : Value v)
    (hv : HasType Δ Ξ Ψ f b d (Γ₁ ++ Γ₂) Λ v t') :
    HasType Δ Ξ Ψ f b d (Γ₁ ++ Γ₂) Λ (Expr.subst Γ₁.length v e) t := by
  induction e generalizing Ξ Ψ Γ₁ Λ b d v t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i =>
    cases he with
    | var hget =>
      simp only [Expr.subst]
      split
      case isTrue heq =>
        subst heq
        rw [List.getElem?_append_right (Nat.le_refl _), Nat.sub_self,
          List.getElem?_cons_zero] at hget
        cases hget
        exact hv
      case isFalse hne =>
        split
        case isTrue hgt =>
          refine .var ?_
          have hle : Γ₁.length ≤ i := Nat.le_of_lt hgt
          rw [List.getElem?_append_right hle] at hget
          have hidx : i - Γ₁.length = (i - 1 - Γ₁.length) + 1 := by omega
          rw [hidx, List.getElem?_cons_succ] at hget
          rw [List.getElem?_append_right (by omega)]
          exact hget
        case isFalse hngt =>
          have hlt : i < Γ₁.length := by omega
          refine .var ?_
          rw [List.getElem?_append_left hlt] at hget ⊢
          exact hget
  | letE e b ihe ihb =>
    cases he with
    | letE h1 h2 =>
      exact .letE (ihe h1 hvv hv)
        (ihb (Γ₁ := _ :: Γ₁) h2 (hvv.shift 0) (value_shift_ctx hvv hv))
  | add a b iha ihb =>
    cases he with
    | add h1 h2 => exact .add (iha h1 hvv hv) (ihb h2 hvv hv)
  | lt a b iha ihb =>
    cases he with
    | lt h1 h2 => exact .lt (iha h1 hvv hv) (ihb h2 hvv hv)
  | arith op a b iha ihb =>
    cases he with
    | arith h1 h2 => exact .arith (iha h1 hvv hv) (ihb h2 hvv hv)
  | farith op a b iha ihb =>
    cases he with
    | farith h1 h2 => exact .farith (iha h1 hvv hv) (ihb h2 hvv hv)
  | cmp op a b iha ihb =>
    cases he with
    | cmp h1 h2 => exact .cmp (iha h1 hvv hv) (ihb h2 hvv hv)
  | fcmp op a b iha ihb =>
    cases he with
    | fcmp h1 h2 => exact .fcmp (iha h1 hvv hv) (ihb h2 hvv hv)
  | pair a b iha ihb =>
    cases he with
    | pair h1 h2 => exact .pair (iha h1 hvv hv) (ihb h2 hvv hv)
  | fst e ihe => cases he with | fst h => exact .fst (ihe h hvv hv)
  | ann e t ihe => cases he with | ann h hs => exact .ann (ihe h hvv hv) hs
  | snd e ihe => cases he with | snd h => exact .snd (ihe h hvv hv)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    cases he with | callv hf h hsub hbd => exact .callv (ihf hf hvv hv) (ihe h hvv hv) hsub hbd
  | call fn ts e ihe => cases he with | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe h hvv hv) hsub hbd
  | callM fn ts e ihe => cases he with | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe h hvv hv) hanc hsub hbd had
  | ite c th el ihc iht ihe =>
    cases he with
    | ite h1 h2 h3 => exact .ite (ihc h1 hvv hv) (iht h2 hvv hv) (ihe h3 hvv hv)
  | nil t => cases he; exact .nil
  | some e ihe =>
    cases he with
    | some h => exact .some (ihe h hvv hv)
  | ifnil e n s ihe ihn ihs =>
    cases he with
    | ifnil h1 h2 h3 =>
      exact .ifnil (ihe h1 hvv hv) (ihn h2 hvv hv)
        (ihs (Γ₁ := _ :: Γ₁) h3 (hvv.shift 0) (value_shift_ctx hvv hv))
  | inl r e ihe =>
    cases he with
    | inl h => exact .inl (ihe h hvv hv)
  | inr l e ihe =>
    cases he with
    | inr h => exact .inr (ihe h hvv hv)
  | case e bl br ihe ihl ihr =>
    cases he with
    | case h1 h2 h3 =>
      exact .case (ihe h1 hvv hv) (ihl (Γ₁ := _ :: Γ₁) h2 (hvv.shift 0) (value_shift_ctx hvv hv))
        (ihr (Γ₁ := _ :: Γ₁) h3 (hvv.shift 0) (value_shift_ctx hvv hv))
  | block e ihe =>
    cases he with
    | block h hb =>
      exact .block (ihe h hvv (value_depth_weaken hvv hv (Nat.le_succ d))) hb
  | blockR t₀ e ihe =>
    cases he with
    | blockR h hr hb =>
      exact .blockR (ihe h hvv (value_depth_weaken hvv hv (Nat.le_succ d))) hr hb
  | copyTo k₀ t₀ e ihe =>
    cases he with
    | copyTo h hk hr hb hc => exact .copyTo (ihe h hvv hv) hk hr hb hc
  | label t e ihe =>
    cases he with
    | label h hb => exact .label (ihe h hvv (value_ctx hvv hv)) hb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe =>
    cases he with
    | jump hn h hr => exact .jump hn (ihe h hvv hv) hr
  | alloc m e ihe =>
    cases he with
    | alloc h hb hbd hmf => exact .alloc (ihe h hvv hv) hb hbd hmf
  | deref e ihe =>
    cases he with
    | deref h => exact .deref (ihe h hvv hv)
  | assign l e ihl ihe =>
    cases he with
    | assign h1 h2 => exact .assign (ihl h1 hvv hv) (ihe h2 hvv hv)
  | whileE c b ihc ihb =>
    cases he with
    | whileE h1 h2 => exact .whileE (ihc h1 hvv hv) (ihb h2 hvv hv)
  | freeze e ihe =>
    cases he with
    | freeze h hm => exact .freeze (ihe h hvv hv) hm
    | freezes h hm => exact .freezes (ihe h hvv hv) hm
    | freezem h hm => exact .freezem (ihe h hvv hv) hm
  | mkslice m t =>
    cases he with | mkslice h1 h2 h3 => exact .mkslice h1 h2 h3
  | strlit bs r =>
    cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 h2 h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 h2 h3 h4 h5
  | index e i ot ihe ihi =>
    cases he with | index h1 h2 hrd => exact .index (ihe h1 hvv hv) (ihi h2 hvv hv) hrd
  | lenE e ihe =>
    cases he with | lenE h => exact .lenE (ihe h hvv hv)
  | tobyte e ihe =>
    cases he with | tobyte h => exact .tobyte (ihe h hvv hv)
  | fconv op e ihe =>
    cases he with | fconv h => exact .fconv (ihe h hvv hv)
  | toint e ihe =>
    cases he with | toint h => exact .toint (ihe h hvv hv)
  | append e w ihe ihw =>
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe h1 hvv hv) (ihw h2 hvv hv) h3
    | appendI h1 h2 h3 h4 => exact .appendI (ihe h1 hvv hv) (ihw h2 hvv hv) h3 h4
  | setidx e i w ihe ihi ihw =>
    cases he with
    | setidx h1 h2 h3 => exact .setidx (ihe h1 hvv hv) (ihi h2 hvv hv) (ihw h3 hvv hv)
  | subslice e sa sb ihe iha ihb =>
    cases he with
    | subslice h1 h2 h3 => exact .subslice (ihe h1 hvv hv) (iha h2 hvv hv) (ihb h3 hvv hv)
  | eqs e1 e2 ih1 ih2 =>
    cases he with
    | eqs h1 h2 => exact .eqs (ih1 h1 hvv hv) (ih2 h2 hvv hv)
  | concat e1 e2 ih1 ih2 =>
    cases he with
    | concat h1 h2 h3 => exact .concat (ih1 h1 hvv hv) (ih2 h2 hvv hv) h3
  | slicev mt r base len =>
    cases he with | slicev hk h2 h3 h4a h4b h5 h6 => exact .slicev hk h2 h3 h4a h4b h5 h6
  | mkmap m t =>
    cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 h2 h3
  | getm t e k ihe ihk =>
    cases he with | getm h1 h2 hkc hsub => exact .getm (ihe h1 hvv hv) (ihk h2 hvv hv) hkc hsub
  | setm e k w ihe ihk ihw =>
    cases he with
    | setm h1 h2 h3 => exact .setm (ihe h1 hvv hv) (ihk h2 hvv hv) (ihw h3 hvv hv)
  | delm t e k ihe ihk =>
    cases he with | delm h1 h2 hkc => exact .delm (ihe h1 hvv hv) (ihk h2 hvv hv) hkc
  | lenm e ihe =>
    cases he with | lenm h => exact .lenm (ihe h hvv hv)
  | keysm e ihe =>
    cases he with | keysm h h1 h2 h3 => exact .keysm (ihe h hvv hv) h1 h2 h3
  | mapv mt r base len =>
    cases he with | mapv hk h2 h3 h4a h4b h5 h6 => exact .mapv hk h2 h3 h4a h4b h5 h6
  | par e1 e2 ih1 ih2 =>
    cases he with
    | par h1 h2 hΓ =>
      -- v の型 t' は Γ にいたので mutFree。共有境界を b → d に付け替えて本体へ代入
      have hm : t'.mutFree := hΓ t' (by simp)
      have hvd : HasType Δ Ξ Ψ f d d (Γ₁ ++ Γ₂) [] v t' := value_ctx hvv (value_sb hvv hm hv)
      refine .par (ih1 h1 hvv hvd) (ih2 h2 hvv hvd) ?_
      intro t ht
      exact hΓ t (by
        rcases List.mem_append.mp ht with h | h
        · exact List.mem_append.mpr (.inl h)
        · exact List.mem_append.mpr (.inr (List.mem_cons_of_mem _ h)))
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf =>
      have hm : t'.mutFree := hΓ t' (by simp)
      have hvd : HasType Δ Ξ Ψ f d d (Γ₁ ++ Γ₂) [] v t' := value_ctx hvv (value_sb hvv hm hv)
      refine .parch
        (ih1 (Γ₁ := _ :: Γ₁) h1 (hvv.shift 0) (value_shift_ctx hvv hvd))
        (ih2 (Γ₁ := _ :: Γ₁) h2 (hvv.shift 0) (value_shift_ctx hvv hvd)) ?_ hrb hmf
      intro τ hτ
      exact hΓ τ (by
        rcases List.mem_append.mp hτ with h | h
        · exact List.mem_append.mpr (.inl h)
        · exact List.mem_append.mpr (.inr (List.mem_cons_of_mem _ h)))
  | newchan rc t => cases he with | newchan hf hl hm => exact .newchan hf hl hm
  | send c e ihc ihe =>
    cases he with
    | send h1 h2 => exact .send (ihc h1 hvv hv) (ihe h2 hvv hv)
    | sendE h1 h2 hp => exact .sendE (ihc h1 hvv hv) (ihe h2 hvv hv) hp
  | recv c ihc =>
    cases he with
    | recv h => exact .recv (ihc h hvv hv)
    | recvE h hm hc => exact .recvE (ihc h hvv hv) hm hc
  | close c ihc =>
    cases he with
    | closeE h => exact .closeE (ihc h hvv hv)
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 => exact .chanV h1 h2 h3
  | scope t₀ εs e ihe =>
    cases he with
    | scope h hr hb hem hec hbd =>
      have hv1 := value_depth_weaken hvv hv (Nat.le_succ d)
      have hv2 : HasType Δ Ξ Ψ f b (d + 1) (.own .scope d εs :: (Γ₁ ++ Γ₂)) [] (v.shift 0) t' := by
        rw [hvv.shift_eq]; exact value_ctx hvv hv1
      exact .scope (ihe (Γ₁ := _ :: Γ₁) h (hvv.shift 0) hv2) hr hb hem hec hbd
  | spawn sc a e ihsc iha ihe =>
    -- 子の本体は閉じている（文脈 [ta]）ので代入は札と渡す値にだけ入る
    cases he with
    | spawn h1 ha hg h2 hrb hcf hε =>
      exact .spawn (ihsc h1 hvv hv) (iha ha hvv hv) hg h2 hrb hcf hε
  | join tj h ihh => cases he with | join h1 => exact .join (ihh h1 hvv hv)
  | tryJ t₀ h ihh => cases he with | tryJ h1 => exact .tryJ (ihh h1 hvv hv)
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV h1 h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV h1 h2 h3
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch h1 h2 h3 h4 h5 h6
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx h1 h2 h3
    | epRx h1 h2 h3 => exact .epRx h1 h2 h3

/-- 置換補題の使い口: 先頭束縛の消費（機械の letK / ifnilK / caseK / parch の spawn） -/
theorem subst0 {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx} {body v : Expr} {t t' : Ty}
    (hb : HasType Δ Ξ Ψ f b d (t' :: Γ) Λ body t) (hvv : Value v)
    (hv : HasType Δ Ξ Ψ f b d Γ Λ v t') :
    HasType Δ Ξ Ψ f b d Γ Λ (Expr.subst 0 v body) t :=
  subst_preserve (Γ₁ := []) hb hvv hv

/-- loc-free 値の輸出: 任意の世界から空世界（Ξ は保持、Ψ = []・f = b = d = 0・Γ = []）へ。
call の引数を入れ子世界に持ち込むときの口（チャネルペイロードの purify と同じはしご） -/
theorem value_export {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx}
    {v : Expr} {t : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v t)
    (hb : t.regionsBelow 0 = true) :
    HasType Δ Ξ [] 0 0 0 [] Λ v t := by
  have h1 := HasType.value_strengthen (d := 0) hv he hb
  rw [List.take_zero] at h1
  have h2 := HasType.value_f_set (n := 0) hv h1 hb
  have h3 := HasType.value_sb (b' := 0) hv (Ty.mutFree_of_locFree hb) h2
  exact HasType.value_ctx (Γ' := []) hv h3

/-- loc-free 値の輸入: 空世界から任意の世界へ（call の戻り値をメインの世界で読む口） -/
theorem value_import {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx}
    {v : Expr} {t : Ty} (hv : Value v) (he : HasType Δ Ξ [] 0 0 0 [] Λ v t)
    (hb : t.regionsBelow 0 = true) :
    HasType Δ Ξ Ψ f b d Γ Λ v t := by
  have h1 : HasType Δ Ξ Ψ 0 0 0 [] Λ v t :=
    HasType.store_mono (storeLE_nil Ψ) (fun n hn _ => by
      cases Nat.le_zero.mp hn; simp) he
  have h2 := HasType.value_depth_weaken hv h1 (Nat.zero_le d)
  have h3 := HasType.value_sb (b' := b) hv (Ty.mutFree_of_locFree hb) h2
  have h4 := HasType.f_mono (Nat.zero_le f) h3
  exact HasType.value_ctx hv h4

/-- 共有境界の引き下げ: b は常に `b ≤ X` の形でしか使われないので、下げても保たれる
（round4: シフトで b = 呼び手フレームに上がった本体の型付けを、実行時のタスク境界へ）。
par / parch の premise は b := d 固定なので外側の b に依らない -/
theorem b_lower {e : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b b' d : Nat} {Γ : Ctx}
    {t : Ty} (hb : b' ≤ b) (he : HasType Δ Ξ Ψ f b d Γ Λ e t) :
    HasType Δ Ξ Ψ f b' d Γ Λ e t := by
  induction e generalizing b b' d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i => cases he with | var h => exact .var h
  | letE e b ihe ihb => cases he with | letE h1 h2 => exact .letE (ihe hb h1) (ihb hb h2)
  | add a b iha ihb => cases he with | add h1 h2 => exact .add (iha hb h1) (ihb hb h2)
  | lt a b iha ihb => cases he with | lt h1 h2 => exact .lt (iha hb h1) (ihb hb h2)
  | arith op a b iha ihb =>
    cases he with | arith h1 h2 => exact .arith (iha hb h1) (ihb hb h2)
  | farith op a b iha ihb =>
    cases he with | farith h1 h2 => exact .farith (iha hb h1) (ihb hb h2)
  | cmp op a b iha ihb => cases he with | cmp h1 h2 => exact .cmp (iha hb h1) (ihb hb h2)
  | fcmp op a b iha ihb => cases he with | fcmp h1 h2 => exact .fcmp (iha hb h1) (ihb hb h2)
  | ite c th el ihc iht ihe =>
    cases he with | ite h1 h2 h3 => exact .ite (ihc hb h1) (iht hb h2) (ihe hb h3)
  | nil t => cases he; exact .nil
  | some e ihe => cases he with | some h => exact .some (ihe hb h)
  | ifnil e n s ihe ihn ihs =>
    cases he with | ifnil h1 h2 h3 => exact .ifnil (ihe hb h1) (ihn hb h2) (ihs hb h3)
  | inl r e ihe => cases he with | inl h => exact .inl (ihe hb h)
  | inr l e ihe => cases he with | inr h => exact .inr (ihe hb h)
  | case e bl br ihe ihl ihr =>
    cases he with | case h1 h2 h3 => exact .case (ihe hb h1) (ihl hb h2) (ihr hb h3)
  | pair a b iha ihb => cases he with | pair h1 h2 => exact .pair (iha hb h1) (ihb hb h2)
  | fst e ihe => cases he with | fst h => exact .fst (ihe hb h)
  | ann e t ihe => cases he with | ann h hs => exact .ann (ihe hb h) hs
  | snd e ihe => cases he with | snd h => exact .snd (ihe hb h)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    cases he with
    | callv hf h hsub hbd => exact .callv (ihf hb hf) (ihe hb h) hsub (by omega)
  | call fn ts e ihe =>
    cases he with
    | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe hb h) hsub (by omega)
  | callM fn ts e ihe =>
    cases he with
    | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe hb h) hanc hsub (by omega) had
  | block e ihe => cases he with | block h hrb => exact .block (ihe hb h) hrb
  | blockR t e ihe => cases he with | blockR h hr hrb => exact .blockR (ihe hb h) (Ty.jumpRel_lower hb hr) hrb
  | copyTo k t e ihe => cases he with | copyTo h hk hr hrb hc => exact .copyTo (ihe hb h) hk (Ty.jumpRel_lower hb hr) hrb hc
  | label t e ihe => cases he with | label h hrb => exact .label (ihe hb h) hrb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe => cases he with | jump hn h hr => exact .jump hn (ihe hb h) (Ty.jumpRel_lower hb hr)
  | alloc m e ihe =>
    cases he with | alloc h hrb hbd hmf => exact .alloc (ihe hb h) hrb (by omega) hmf
  | deref e ihe => cases he with | deref h => exact .deref (ihe hb h)
  | assign l e ihl ihe =>
    cases he with | assign h1 h2 => exact .assign (ihl hb h1) (ihe hb h2)
  | whileE c b ihc ihb =>
    cases he with | whileE h1 h2 => exact .whileE (ihc hb h1) (ihb hb h2)
  | freeze e ihe =>
    cases he with
    | freeze h hm => exact .freeze (ihe hb h) hm
    | freezes h hm => exact .freezes (ihe hb h) hm
    | freezem h hm => exact .freezem (ihe hb h) hm
  | mkslice m t => cases he with | mkslice h1 h2 h3 => exact .mkslice h1 (by omega) h3
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit (by omega) h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 (by omega) h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 (by omega) h3 h4 h5
  | index e i ot ihe ihi => cases he with | index h1 h2 hrd => exact .index (ihe hb h1) (ihi hb h2) hrd
  | lenE e ihe => cases he with | lenE h => exact .lenE (ihe hb h)
  | tobyte e ihe => cases he with | tobyte h => exact .tobyte (ihe hb h)
  | fconv op e ihe => cases he with | fconv h => exact .fconv (ihe hb h)
  | toint e ihe => cases he with | toint h => exact .toint (ihe hb h)
  | append e v ihe ihv =>
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe hb h1) (ihv hb h2) (by omega)
    | appendI h1 h2 h3 h4 => exact .appendI (ihe hb h1) (ihv hb h2) (by omega) h4
  | setidx e i v ihe ihi ihv =>
    cases he with | setidx h1 h2 h3 => exact .setidx (ihe hb h1) (ihi hb h2) (ihv hb h3)
  | subslice e sa sb ihe iha ihb =>
    cases he with | subslice h1 h2 h3 => exact .subslice (ihe hb h1) (iha hb h2) (ihb hb h3)
  | eqs e1 e2 ih1 ih2 =>
    cases he with | eqs h1 h2 => exact .eqs (ih1 hb h1) (ih2 hb h2)
  | concat e1 e2 ih1 ih2 =>
    cases he with | concat h1 h2 h3 => exact .concat (ih1 hb h1) (ih2 hb h2) (by omega)
  | mkmap m t => cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 (by omega) h3
  | getm t e k ihe ihk => cases he with | getm h1 h2 hkc hsub => exact .getm (ihe hb h1) (ihk hb h2) hkc hsub
  | setm e k v ihe ihk ihv =>
    cases he with | setm h1 h2 h3 => exact .setm (ihe hb h1) (ihk hb h2) (ihv hb h3)
  | delm t e k ihe ihk => cases he with | delm h1 h2 hkc => exact .delm (ihe hb h1) (ihk hb h2) hkc
  | lenm e ihe => cases he with | lenm h => exact .lenm (ihe hb h)
  | keysm e ihe => cases he with | keysm h h1 h2 h3 => exact .keysm (ihe hb h) h1 h2 (by omega)
  | par e1 e2 ih1 ih2 =>
    cases he with | par h1 h2 hΓ => exact .par h1 h2 hΓ
  | parch t e1 e2 ih1 ih2 =>
    cases he with
    | parch h1 h2 hΓ hrb hmf => exact .parch h1 h2 hΓ hrb hmf
  | newchan rc t => cases he with | newchan hf hl hm => exact .newchan hf hl hm
  | send c e ihc ihe => cases he with
    | send h1 h2 => exact .send (ihc hb h1) (ihe hb h2)
    | sendE h1 h2 hp => exact .sendE (ihc hb h1) (ihe hb h2) hp
  | recv c ihc => cases he with
    | recv h => exact .recv (ihc hb h)
    | recvE h hm hc => exact .recvE (ihc hb h) hm hc
  | close c ihc => cases he with
    | closeE h => exact .closeE (ihc hb h)
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 =>
      exact .loc h1 h2 h3 h4 (fun hm => ⟨(h5 hm).1, by have := (h5 hm).2; omega⟩) h6
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4 h5 h6 h7 =>
      exact .slicev hk h2 h3 h4 (fun hm => ⟨(h5 hm).1, by have := (h5 hm).2; omega⟩) h6 h7
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4 h5 h6 h7 =>
      exact .mapv hk h2 h3 h4 (fun hm => ⟨(h5 hm).1, by have := (h5 hm).2; omega⟩) h6 h7
  | chanV c =>
    cases he with | chanV h1 h2 h3 => exact .chanV h1 h2 h3
  | scope t εs e ihe => cases he with | scope h hr hrb hem hec hbd => exact .scope (ihe hb h) (Ty.jumpRel_lower hb hr) hrb hem hec (by omega)
  | spawn sc a e ihsc iha ihe => cases he with | spawn h1 ha hg h2 hrb hcf hε => exact .spawn (ihsc hb h1) (iha hb ha) hg h2 hrb hcf hε
  | join tj h ihh => cases he with | join h1 => exact .join (ihh hb h1)
  | tryJ t h ihh => cases he with | tryJ h1 => exact .tryJ (ihh hb h1)
  | scopeV rs ε => cases he with | scopeV h1 h2 => exact .scopeV (by omega) h2
  | taskV rs n => cases he with | taskV h1 h2 h3 => exact .taskV (by omega) h2 h3
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch (by omega) h2 h3 h4 h5 h6
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 => exact .epTx (by omega) h2 h3
    | epRx h1 h2 h3 => exact .epRx (by omega) h2 h3

/-- 床の引き下げ: f は newchan / chanV の `rc ≤ f` にしか現れないので、
これらを含まない項（noNewchan）なら下げられる（round4: 本体の f = フレームを
実行時のタスク床へ）。f_mono の逆向き・条件つき版 -/
theorem f_lower {e : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f f' b d : Nat} {Γ : Ctx}
    {t : Ty} (hnc : e.noNewchan = true) (he : HasType Δ Ξ Ψ f b d Γ Λ e t) :
    HasType Δ Ξ Ψ f' b d Γ Λ e t := by
  induction e generalizing b d Γ Λ t with
  | lit n => cases he; exact .lit
  | blit n => cases he with | blit h1 h2 => exact .blit h1 h2
  | flit n => cases he; exact .flit
  | tt => cases he; exact .tt
  | ff => cases he; exact .ff
  | triv => cases he; exact .triv
  | var i => cases he with | var h => exact .var h
  | letE e b ihe ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | letE h1 h2 => exact .letE (ihe hnc.1 h1) (ihb hnc.2 h2)
  | add a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | add h1 h2 => exact .add (iha hnc.1 h1) (ihb hnc.2 h2)
  | lt a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | lt h1 h2 => exact .lt (iha hnc.1 h1) (ihb hnc.2 h2)
  | arith op a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | arith h1 h2 => exact .arith (iha hnc.1 h1) (ihb hnc.2 h2)
  | farith op a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | farith h1 h2 => exact .farith (iha hnc.1 h1) (ihb hnc.2 h2)
  | cmp op a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | cmp h1 h2 => exact .cmp (iha hnc.1 h1) (ihb hnc.2 h2)
  | fcmp op a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | fcmp h1 h2 => exact .fcmp (iha hnc.1 h1) (ihb hnc.2 h2)
  | ite c th el ihc iht ihe =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | ite h1 h2 h3 => exact .ite (ihc hnc.1.1 h1) (iht hnc.1.2 h2) (ihe hnc.2 h3)
  | nil t => cases he; exact .nil
  | some e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | some h => exact .some (ihe hnc h)
  | ifnil e n s ihe ihn ihs =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | ifnil h1 h2 h3 => exact .ifnil (ihe hnc.1.1 h1) (ihn hnc.1.2 h2) (ihs hnc.2 h3)
  | inl r e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | inl h => exact .inl (ihe hnc h)
  | inr l e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | inr h => exact .inr (ihe hnc h)
  | case e bl br ihe ihl ihr =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | case h1 h2 h3 => exact .case (ihe hnc.1.1 h1) (ihl hnc.1.2 h2) (ihr hnc.2 h3)
  | pair a b iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | pair h1 h2 => exact .pair (iha hnc.1 h1) (ihb hnc.2 h2)
  | fst e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | fst h => exact .fst (ihe hnc h)
  | ann e t ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | ann h hs => exact .ann (ihe hnc h) hs
  | snd e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | snd h => exact .snd (ihe hnc h)
  | fnref fn ts => cases he with | fnref h hl ha => exact .fnref h hl ha
  | callv ef e ihf ihe =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | callv hf h hsub hbd => exact .callv (ihf hnc.1 hf) (ihe hnc.2 h) hsub hbd
  | call fn ts e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with
    | call hfn hlen hargs h hsub hbd => exact .call hfn hlen hargs (ihe hnc h) hsub hbd
  | callM fn ts e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with
    | callM hfn hlen hargs h hanc hsub hbd had => exact .callM hfn hlen hargs (ihe hnc h) hanc hsub hbd had
  | block e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | block h hrb => exact .block (ihe hnc h) hrb
  | blockR t e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | blockR h hr hrb => exact .blockR (ihe hnc h) hr hrb
  | copyTo k t e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | copyTo h hk hr hrb hc => exact .copyTo (ihe hnc h) hk hr hrb hc
  | label t e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | label h hrb => exact .label (ihe hnc h) hrb
  | unreach t => cases he; exact .unreach
  | jump n t e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | jump hn h hr => exact .jump hn (ihe hnc h) hr
  | alloc m e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | alloc h hrb hbd hmf => exact .alloc (ihe hnc h) hrb hbd hmf
  | deref e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | deref h => exact .deref (ihe hnc h)
  | assign l e ihl ihe =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | assign h1 h2 => exact .assign (ihl hnc.1 h1) (ihe hnc.2 h2)
  | whileE c b ihc ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | whileE h1 h2 => exact .whileE (ihc hnc.1 h1) (ihb hnc.2 h2)
  | freeze e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with
    | freeze h hm => exact .freeze (ihe hnc h) hm
    | freezes h hm => exact .freezes (ihe hnc h) hm
    | freezem h hm => exact .freezem (ihe hnc h) hm
  | mkslice m t => cases he with | mkslice h1 h2 h3 => exact .mkslice h1 h2 h3
  | strlit bs r => cases he with | strlit h1 h2 => exact .strlit h1 h2
  | mksliceAt m t r => cases he with | mksliceAt h1 h2 h3 h4 h5 => exact .mksliceAt h1 h2 h3 h4 h5
  | mkmapAt m t r => cases he with | mkmapAt h0 h1 h2 h3 h4 h5 => exact .mkmapAt h0 h1 h2 h3 h4 h5
  | index e i ot ihe ihi =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | index h1 h2 hrd => exact .index (ihe hnc.1 h1) (ihi hnc.2 h2) hrd
  | lenE e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | lenE h => exact .lenE (ihe hnc h)
  | tobyte e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | tobyte h => exact .tobyte (ihe hnc h)
  | fconv op e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | fconv h => exact .fconv (ihe hnc h)
  | toint e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | toint h => exact .toint (ihe hnc h)
  | append e v ihe ihv =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | appendM h1 h2 h3 => exact .appendM (ihe hnc.1 h1) (ihv hnc.2 h2) h3
    | appendI h1 h2 h3 h4 => exact .appendI (ihe hnc.1 h1) (ihv hnc.2 h2) h3 h4
  | setidx e i v ihe ihi ihv =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | setidx h1 h2 h3 => exact .setidx (ihe hnc.1.1 h1) (ihi hnc.1.2 h2) (ihv hnc.2 h3)
  | subslice e sa sb ihe iha ihb =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | subslice h1 h2 h3 => exact .subslice (ihe hnc.1.1 h1) (iha hnc.1.2 h2) (ihb hnc.2 h3)
  | eqs e1 e2 ih1 ih2 =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | eqs h1 h2 => exact .eqs (ih1 hnc.1 h1) (ih2 hnc.2 h2)
  | concat e1 e2 ih1 ih2 =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | concat h1 h2 h3 => exact .concat (ih1 hnc.1 h1) (ih2 hnc.2 h2) h3
  | mkmap m t => cases he with | mkmap h0 h1 h2 h3 => exact .mkmap h0 h1 h2 h3
  | getm t e k ihe ihk =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | getm h1 h2 hkc hsub => exact .getm (ihe hnc.1 h1) (ihk hnc.2 h2) hkc hsub
  | setm e k v ihe ihk ihv =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | setm h1 h2 h3 => exact .setm (ihe hnc.1.1 h1) (ihk hnc.1.2 h2) (ihv hnc.2 h3)
  | delm t e k ihe ihk =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | delm h1 h2 hkc => exact .delm (ihe hnc.1 h1) (ihk hnc.2 h2) hkc
  | lenm e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | lenm h => exact .lenm (ihe hnc h)
  | keysm e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | keysm h h1 h2 h3 => exact .keysm (ihe hnc h) h1 h2 h3
  | par e1 e2 ih1 ih2 =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | par h1 h2 hΓ => exact .par (ih1 hnc.1 h1) (ih2 hnc.2 h2) hΓ
  | parch t e1 e2 ih1 ih2 =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | parch h1 h2 hΓ hrb hmf => exact .parch (ih1 hnc.1 h1) (ih2 hnc.2 h2) hΓ hrb hmf
  | newchan rc t => simp [Expr.noNewchan] at hnc
  | send c e ihc ihe =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with
    | send h1 h2 => exact .send (ihc hnc.1 h1) (ihe hnc.2 h2)
    | sendE h1 h2 hp => exact .sendE (ihc hnc.1 h1) (ihe hnc.2 h2) hp
  | recv c ihc =>
    simp only [Expr.noNewchan] at hnc
    cases he with
    | recv h => exact .recv (ihc hnc h)
    | recvE h hm hc => exact .recvE (ihc hnc h) hm hc
  | close c ihc =>
    simp only [Expr.noNewchan] at hnc
    cases he with
    | closeE h => exact .closeE (ihc hnc h)
  | loc r a =>
    cases he with | loc h1 h2 h3 h4 h5 h6 => exact .loc h1 h2 h3 h4 h5 h6
  | slicev mt r base len =>
    cases he with | slicev hk h2 h3 h4 h5 h6 h7 => exact .slicev hk h2 h3 h4 h5 h6 h7
  | mapv mt r base len =>
    cases he with | mapv hk h2 h3 h4 h5 h6 h7 => exact .mapv hk h2 h3 h4 h5 h6 h7
  | chanV c => simp [Expr.noNewchan] at hnc
  | scope t εs e ihe =>
    simp only [Expr.noNewchan] at hnc
    cases he with | scope h1 hj hrb hem hec hbd => exact .scope (ihe hnc h1) hj hrb hem hec hbd
  | spawn sc a e ihsc iha ihe =>
    simp only [Expr.noNewchan, Bool.and_eq_true] at hnc
    cases he with | spawn h1 h2 hg h3 hrb hcf hε => exact .spawn (ihsc hnc.1.1 h1) (iha hnc.1.2 h2) hg (ihe hnc.2 h3) hrb hcf hε
  | join tj h ihh =>
    simp only [Expr.noNewchan] at hnc
    cases he with | join h1 => exact .join (ihh hnc h1)
  | tryJ t h ihh =>
    simp only [Expr.noNewchan] at hnc
    cases he with | tryJ h1 => exact .tryJ (ihh hnc h1)
  | scopeV rs ε => simp [Expr.noNewchan] at hnc
  | taskV rs n => simp [Expr.noNewchan] at hnc
  | newch r cap t => cases he with | newch h1 h2 h3 h4 h5 h6 => exact .newch h1 h2 h3 h4 h5 h6
  | epV p k b r => simp [Expr.noNewchan] at hnc

/-- 値の coerce（round4）: sub で緩めた型に、注釈を書き換えた値が型付く。
ヘッダ / loc は imm 上界の slack でそのまま緩み、注釈値（nil / inl / inr）だけが
coerceTo で書き換わる。call が引数を param.shiftR d へ渡す境界の要 -/
theorem value_coerce {v : Expr} {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx}
    {ta tb : Ty} (hv : Value v) (he : HasType Δ Ξ Ψ f b d Γ Λ v ta) (hs : Ty.sub ta tb = true) :
    Value (Expr.coerceTo tb v) ∧ HasType Δ Ξ Ψ f b d Γ Λ (Expr.coerceTo tb v) tb := by
  induction hv generalizing ta tb with
  | lit n =>
    cases he
    obtain rfl := Ty.sub_int_inv hs
    exact ⟨.lit n, .lit⟩
  | blit n =>
    cases he with
    | blit h1 h2 =>
      obtain rfl := Ty.sub_byte_inv hs
      exact ⟨.blit h1 h2, .blit h1 h2⟩
  | flit n =>
    cases he
    obtain rfl := Ty.sub_f64_inv hs
    exact ⟨.flit n, .flit⟩
  | tt =>
    cases he
    obtain rfl := Ty.sub_bool_inv hs
    exact ⟨.tt, .tt⟩
  | ff =>
    cases he
    obtain rfl := Ty.sub_bool_inv hs
    exact ⟨.ff, .ff⟩
  | triv =>
    cases he
    obtain rfl := Ty.sub_unit_inv hs
    exact ⟨.triv, .triv⟩
  | nil t =>
    cases he
    obtain ⟨t', rfl, -⟩ := Ty.sub_opt_inv hs
    exact ⟨.nil t', .nil⟩
  | some _ ih =>
    cases he with
    | some h =>
      obtain ⟨t', rfl, hs'⟩ := Ty.sub_opt_inv hs
      obtain ⟨hv', ht'⟩ := ih h hs'
      exact ⟨.some hv', .some ht'⟩
  | pair _ _ iha ihb =>
    cases he with
    | pair h1 h2 =>
      obtain ⟨l', r', rfl, hsl, hsr⟩ := Ty.sub_prod_inv hs
      obtain ⟨hva, hta⟩ := iha h1 hsl
      obtain ⟨hvb, htb⟩ := ihb h2 hsr
      exact ⟨.pair hva hvb, .pair hta htb⟩
  | inl r _ ih =>
    cases he with
    | inl h =>
      obtain ⟨l', r', rfl, hsl, -⟩ := Ty.sub_union_inv hs
      obtain ⟨hv', ht'⟩ := ih h hsl
      exact ⟨.inl _ hv', .inl ht'⟩
  | inr l _ ih =>
    cases he with
    | inr h =>
      obtain ⟨l', r', rfl, -, hsr⟩ := Ty.sub_union_inv hs
      obtain ⟨hv', ht'⟩ := ih h hsr
      exact ⟨.inr _ hv', .inr ht'⟩
  | loc r a =>
    cases he with
    | loc h1 h2 h3 h4 h5 h6 =>
      rename_i rt ρ m m' t
      cases m with
      | true =>
        obtain rfl := Ty.sub_refT_inv hs
        exact ⟨.loc r a, .loc h1 h2 h3 h4 h5 h6⟩
      | false =>
        obtain ⟨rt', rfl, hle⟩ := Ty.sub_refF_inv hs
        exact ⟨.loc r a, .loc h1 h2 h3 (Nat.le_trans h4 hle)
          (fun h => nomatch h) h6⟩
  | slicev mt r base len =>
    cases he with
    | slicev hk h2 h3 h4 h5 h6 h7 =>
      subst h4
      cases mt with
      | true =>
        obtain rfl := Ty.sub_sliceT_inv hs
        exact ⟨.slicev true r base len, .slicev hk h2 h3 rfl h5 h6 h7⟩
      | false =>
        obtain ⟨rt', t'', rfl, hle, hst⟩ := Ty.sub_sliceF_inv hs
        refine ⟨.slicev false r base len, .slicev (fun j hj => ?_) h2 (Nat.le_trans h3 hle) rfl
          (fun h => nomatch h) (fun _ => (Ty.sub_mutFree hst) ▸ h6 rfl) (fun h => nomatch h)⟩
        obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, -⟩ := hk j hj
        exact ⟨ρ, mk, tc, hΨ, hρ, hmm, Ty.sub_trans hsc hst, fun h => nomatch h⟩
  | mapv mt r base len =>
    cases he with
    | mapv hk h2 h3 h4 h5 h6 h7 =>
      subst h4
      cases mt with
      | true =>
        obtain rfl := Ty.sub_mapT_inv hs
        exact ⟨.mapv true r base len, .mapv hk h2 h3 rfl h5 h6 h7⟩
      | false =>
        obtain ⟨rt', t'', rfl, hle, hst⟩ := Ty.sub_mapF_inv hs
        refine ⟨.mapv false r base len, .mapv (fun j hj => ?_) h2 (Nat.le_trans h3 hle) rfl
          (fun h => nomatch h) (fun _ => (Ty.sub_mutFree hst) ▸ h6 rfl) (fun h => nomatch h)⟩
        obtain ⟨ρ, mk, tc, hΨ, hρ, hmm, hsc, -⟩ := hk j hj
        exact ⟨ρ, mk, tc, hΨ, hρ, hmm, Ty.sub_trans hsc hst, fun h => nomatch h⟩
  | fnref fn ts =>
    cases he with
    | fnref h hl ha =>
      obtain rfl := Ty.sub_fn_inv hs
      exact ⟨.fnref fn ts, .fnref h hl ha⟩
  | chanV c =>
    cases he with
    | chanV h1 h2 h3 =>
      obtain rfl := Ty.sub_chan_inv hs
      exact ⟨.chanV c, .chanV h1 h2 h3⟩
  | scopeV rs ε =>
    cases he with
    | scopeV h1 h2 =>
      obtain rfl := Ty.sub_own_inv hs
      exact ⟨.scopeV rs ε, .scopeV h1 h2⟩
  | taskV rs n =>
    cases he with
    | taskV h1 h2 h3 =>
      obtain rfl := Ty.sub_own_inv hs
      exact ⟨.taskV rs n, .taskV h1 h2 h3⟩
  | epV p k b r =>
    cases he with
    | epTx h1 h2 h3 =>
      obtain rfl := Ty.sub_own_inv hs
      exact ⟨.epV p k true r, .epTx h1 h2 h3⟩
    | epRx h1 h2 h3 =>
      obtain rfl := Ty.sub_own_inv hs
      exact ⟨.epV p k false r, .epRx h1 h2 h3⟩

end HasType

end FS
