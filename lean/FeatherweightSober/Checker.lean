import FeatherweightSober.Typing

/-!
# 型検査器（Phase 2 の本番。formal.md「実装との照合」）

`HasType` は宣言的な型付け規則、`typecheck` はその実行可能形。
「証明済みの型付け規則と型検査器のコードを同じ定義から出す」の核:

- **健全性**（typecheck_sound）: typecheck が some t を返せば HasType の導出がある
- **完全性**（typecheck_complete）: ソース項（loc / chanV を含まない）の HasType 導出が
  あれば typecheck が同じ t を返す

2 つ合わせて「ソース項の型付けは typecheck が決定する」（hasType_iff_typecheck）。
loc / chanV は実行時にのみ現れ、型付けに自由度がある（loc の m は条件次第で両方選べる）
ので検査器の対象外 — 検査器は none を返す。ソース項に限れば型は一意（hasType_unique）。

実装メモ: 本体は do 記法でなく明示 match で書く（`split at` が Bind.bind を割れないため。
等式補題 → `split at h` の 2 手で健全性の各ケースが機械的に落ちる）。
-/
namespace FS

/-- 型検査（型推論）。構文主導なので型注釈は nil / inl / inr / parch / newchan の分だけ。
Ξ / Ψ はソース項の検査では常に []（実行時の型付けの器）だが、
健全性・完全性を機械状態の型付けと同じ土俵で言うため一般形で書く -/
def typecheck (Δ : Defs) (Ξ : ChanTy) (Ψ : StoreTy) (f : Nat) : Nat → Nat → Ctx → LCtx → Expr → Option Ty
  | _, _, _, _, .lit _ => some .int
  | _, _, _, _, .flit _ => some .f64
  | _, _, _, _, .tt => some .bool
  | _, _, _, _, .ff => some .bool
  | _, _, _, _, .triv => some .unit
  | _, _, Γ, _, .var i => Γ[i]?
  | b, d, Γ, Λ, .letE e body =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some t₁ => typecheck Δ Ξ Ψ f b d (t₁ :: Γ) Λ body
      | none => none
  | b, d, Γ, Λ, .add a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .int, some .int => some .int
      | _, _ => none
  | b, d, Γ, Λ, .lt a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .int, some .int => some .bool
      | _, _ => none
  | b, d, Γ, Λ, .arith _ a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .int, some .int => some .int
      | _, _ => none
  | b, d, Γ, Λ, .cmp _ a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .int, some .int => some .bool
      | _, _ => none
  | b, d, Γ, Λ, .ite c t e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ c, typecheck Δ Ξ Ψ f b d Γ Λ t, typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some .bool, some τ₁, some τ₂ => if τ₁ = τ₂ then some τ₁ else none
      | _, _, _ => none
  | _, _, _, _, .nil t => some (.opt t)
  | b, d, Γ, Λ, .some e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some t => some (.opt t)
      | none => none
  | b, d, Γ, Λ, .ifnil e n s =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.opt t) =>
          match typecheck Δ Ξ Ψ f b d Γ Λ n, typecheck Δ Ξ Ψ f b d (t :: Γ) Λ s with
          | some τ₁, some τ₂ => if τ₁ = τ₂ then some τ₁ else none
          | _, _ => none
      | _ => none
  | b, d, Γ, Λ, .inl r e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some l => some (.union l r)
      | none => none
  | b, d, Γ, Λ, .inr l e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some r => some (.union l r)
      | none => none
  | b, d, Γ, Λ, .case e bl br =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.union l r) =>
          match typecheck Δ Ξ Ψ f b d (l :: Γ) Λ bl, typecheck Δ Ξ Ψ f b d (r :: Γ) Λ br with
          | some τ₁, some τ₂ => if τ₁ = τ₂ then some τ₁ else none
          | _, _ => none
      | _ => none
  | b, d, Γ, Λ, .pair a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some l, some r => some (.prod l r)
      | _, _ => none
  | b, d, Γ, Λ, .fst e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.prod l _) => some l
      | _ => none
  | b, d, Γ, Λ, .snd e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.prod _ r) => some r
      | _ => none
  | b, d, Γ, Λ, .call fn ts e =>
      -- round4: 呼び手深さ d = d' + 1、ρ = d'。引数は浅い imm 共変で param.shiftR d' へ
      match d with
      | 0 => none
      | d' + 1 =>
          match Δ[fn]? with
          | some dfn =>
              match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ e with
              | some t =>
                  if decide (ts.length = dfn.tparams) && Ty.tyArgsOk ts &&
                      Ty.sub t ((dfn.inst ts).param.shiftR d') && decide (b ≤ d') then
                    some ((dfn.inst ts).ret.relocR d')
                  else none
              | none => none
          | none => none
  | b, d, Γ, Λ, .callM fn ts e =>
      -- R2: call と同じ形。anchor a は引数の型の mut 位置から読み、region 0 を a へ写す
      match d with
      | 0 => none
      | d' + 1 =>
          match Δ[fn]? with
          | some dfn =>
              match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ e with
              | some t =>
                  match Ty.anchorOf (dfn.inst ts).param t with
                  | some a =>
                      if decide (ts.length = dfn.tparams) && Ty.tyArgsOk ts &&
                          Ty.sub t ((dfn.inst ts).param.renR a d') && decide (b ≤ a) && decide (a ≤ d') then
                        some ((dfn.inst ts).ret.relocA a d')
                      else none
                  | none => none
              | none => none
          | none => none
  | _, _, _, _, .fnref fn ts =>
      match Δ[fn]? with
      | some dfn =>
          if decide (ts.length = dfn.tparams) && Ty.tyArgsOk ts then
            some (.fn (dfn.inst ts).param (dfn.inst ts).ret)
          else none
      | none => none
  | b, d, Γ, Λ, .ann e t =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some ta => if Ty.sub ta t then some t else none
      | none => none
  | b, d, Γ, Λ, .callv ef e =>
      -- call と同じ形。シグネチャは関数値の型（base 座標の型スキーム）から取る
      match d with
      | 0 => none
      | d' + 1 =>
          match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ ef with
          | some (.fn p r) =>
              match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ e with
              | some t =>
                  if Ty.sub t (p.shiftR d') && decide (b ≤ d') then
                    some (r.relocR d')
                  else none
              | none => none
          | _ => none
  | b, d, Γ, Λ, .callMv a ef e =>
      -- callv の anchor 版（L1）: anchor a は構文の注釈。前提は callM と同じ形でシグネチャを関数値の型から取る
      match d with
      | 0 => none
      | d' + 1 =>
          match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ ef with
          | some (.fn p r) =>
              match typecheck Δ Ξ Ψ f b (d' + 1) Γ Λ e with
              | some t =>
                  if Ty.sub t (p.renR a d') && decide (b ≤ a) && decide (a ≤ d') then
                    some (r.relocA a d')
                  else none
              | none => none
          | _ => none
  | b, d, Γ, Λ, .label t e =>
      match typecheck Δ Ξ Ψ f b d Γ ((t, d - 1) :: Λ) e with
      | some t' => if t' = t && t.regionsBelow d then some t else none
      | none => none
  | _, _, _, _, .unreach t => some t
  | b, d, Γ, Λ, .jump n t e =>
      match Λ[n]?, typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (tL, k), some t' => if Ty.jumpRel b k t' tL then some t else none
      | _, _ => none
  | b, d, Γ, Λ, .block e =>
      match typecheck Δ Ξ Ψ f b (d + 1) Γ Λ e with
      | some t => if t.regionsBelow d then some t else none
      | none => none
  | b, d, Γ, Λ, .blockR t e =>
      match typecheck Δ Ξ Ψ f b (d + 1) Γ Λ e with
      | some tB => if Ty.jumpRel b (d - 1) tB t && t.regionsBelow d then some t else none
      | none => none
  | b, d, Γ, Λ, .copyTo k t e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some tE => if decide (k < d) && Ty.jumpRel b k tE t && t.regionsBelow (k + 1) && t.chanFree then some t else none
      | none => none
  | _, 0, _, _, .alloc _ _ => none
  | b, d + 1, Γ, Λ, .alloc m e =>
      match typecheck Δ Ξ Ψ f b (d + 1) Γ Λ e with
      | some t =>
          if t.regionsBelow (d + 1) && decide (b ≤ d) && (m || t.mutFree) then
            some (.ref m d t)
          else none
      | none => none
  | b, d, Γ, Λ, .deref e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.ref _ _ t) => some t
      | _ => none
  | b, d, Γ, Λ, .assign l e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ l, typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.ref true _ t), some t' => if t' = t then some .unit else none
      | _, _ => none
  | b, d, Γ, Λ, .whileE c body =>
      match typecheck Δ Ξ Ψ f b d Γ Λ c, typecheck Δ Ξ Ψ f b d Γ Λ body with
      | some .bool, some _ => some .unit
      | _, _ => none
  | b, d, Γ, Λ, .freeze e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.ref true r t) => if t.mutFree then some (.ref false r t) else none
      | some (.slice true r t) => if t.mutFree then some (.slice false r t) else none
      | some (.map true r t) => if t.mutFree then some (.map false r t) else none
      | _ => none
  | _, 0, _, _, .mkslice _ _ => none
  | b, d + 1, _, _, .mkslice m t =>
      if t.regionsBelow (d + 1) && decide (b ≤ d) && (m || t.mutFree) then
        some (.slice m d t)
      else none
  | b, d, _, _, .strlit _ r =>
      if decide (b ≤ r) && decide (r < d) then some (.slice false r .byte) else none
  | b, d, _, _, .mksliceAt m t r =>
      if t.regionsBelow (r + 1) && decide (b ≤ r) && decide (r < d) && (m || t.mutFree) && t.chanFree then
        some (.slice m r t)
      else none
  | b, d, _, _, .mkmapAt m (.prod k (.opt t)) r =>
      if k.keyOk && (Ty.prod k (.opt t)).regionsBelow (r + 1) && decide (b ≤ r) && decide (r < d) &&
          (m || (Ty.prod k (.opt t)).mutFree) && (Ty.prod k (.opt t)).chanFree then
        some (.map m r (.prod k (.opt t)))
      else none
  | _, _, _, _, .mkmapAt _ _ _ => none
  | b, d, Γ, Λ, .index e i ot =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ i with
      | some (.slice m _ t), some .int => Ty.readAs m ot t
      | _, _ => none
  | b, d, Γ, Λ, .lenE e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.slice _ _ _) => some .int
      | _ => none
  | b, d, Γ, Λ, .tobyte e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some .int => some .byte
      | _ => none
  | b, d, Γ, Λ, .toint e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some .byte => some .int
      | _ => none
  | b, d, Γ, Λ, .farith _ a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .f64, some .f64 => some .f64
      | _, _ => none
  | b, d, Γ, Λ, .fcmp _ a c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ a, typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some .f64, some .f64 => some .bool
      | _, _ => none
  | b, d, Γ, Λ, .fconv op e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some t => if t = op.dom then some op.cod else none
      | none => none
  | b, d, Γ, Λ, .append e v =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ v with
      | some (.slice true r t), some t' =>
          if t' = t && decide (b ≤ r) then some (.slice true r t) else none
      | some (.slice false _ t), some t' =>
          -- imm append は現在の最内 region へ書く（round4）。深さ 0 では書き先がない
          match d with
          | 0 => none
          | d' + 1 => if t' = t && decide (b ≤ d') && t.regionsBelow (d' + 1) then some (.slice false d' t) else none
      | _, _ => none
  | b, d, Γ, Λ, .setidx e i v =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ i,
            typecheck Δ Ξ Ψ f b d Γ Λ v with
      | some (.slice true _ t), some .int, some t' => if t' = t then some .unit else none
      | _, _, _ => none
  | b, d, Γ, Λ, .subslice e sa sb =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ sa,
            typecheck Δ Ξ Ψ f b d Γ Λ sb with
      | some (.slice false r t), some .int, some .int => some (.slice false r t)
      | _, _, _ => none
  | b, d, Γ, Λ, .eqs e1 e2 =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e1, typecheck Δ Ξ Ψ f b d Γ Λ e2 with
      | some (.slice false _ .byte), some (.slice false _ .byte) => some .bool
      | _, _ => none
  | b, d, Γ, Λ, .concat e1 e2 =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e1, typecheck Δ Ξ Ψ f b d Γ Λ e2 with
      | some (.slice false _ t1), some (.slice false _ t2) =>
          -- 最内 region へ書く（appendI と同じ床）。深さ 0 では書き先がない
          match d with
          | 0 => none
          | d' + 1 => if t2 = t1 && decide (b ≤ d') then some (.slice false d' t1) else none
      | _, _ => none
  | _, _, _, _, .slicev _ _ _ _ => none
  | _, 0, _, _, .mkmap _ _ => none
  | b, d + 1, _, _, .mkmap m (.prod k (.opt t)) =>
      if k.keyOk && (Ty.prod k (.opt t)).regionsBelow (d + 1) && decide (b ≤ d) &&
          (m || (Ty.prod k (.opt t)).mutFree) then
        some (.map m d (.prod k (.opt t)))
      else none
  | _, _ + 1, _, _, .mkmap _ _ => none
  | b, d, Γ, Λ, .getm t e k =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ k with
      | some (.map _ _ (.prod kt (.opt t'))), some kq =>
          if Ty.sub t' t && kq.keyCompat kt then some (.opt t) else none
      | _, _ => none
  | b, d, Γ, Λ, .setm e k v =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ k,
            typecheck Δ Ξ Ψ f b d Γ Λ v with
      | some (.map true r (.prod kt (.opt t))), some k', some t' =>
          if k' = kt && t' = t then some (.map true r (.prod kt (.opt t))) else none
      | _, _, _ => none
  | b, d, Γ, Λ, .delm t e k =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e, typecheck Δ Ξ Ψ f b d Γ Λ k with
      | some (.map true _ (.prod kt (.opt t'))), some kq =>
          if t' = t && kq.keyCompat kt then some .unit else none
      | _, _ => none
  | b, d, Γ, Λ, .lenm e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.map _ _ _) => some .int
      | _ => none
  | b, d, Γ, Λ, .keysm e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.map _ _ (.prod kt (.opt _))) =>
          -- 最内 region へ書く（concat と同じ床）。深さ 0 では書き先がない
          match d with
          | 0 => none
          | d' + 1 =>
              if kt.keyOk && kt.regionsBelow (d' + 1) && decide (b ≤ d') then some (.slice false d' kt)
              else none
      | _ => none
  | b, d, Γ, Λ, .clone ot e =>
      -- 最内 region へ mut のセルとして写す（keysm と同じ床）。読み出しは index と同じ readAs。深さ 0 では書き先がない
      match typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.slice m _ t') =>
          match d with
          | 0 => none
          | d' + 1 =>
              match Ty.readAs m ot t' with
              | some t => if t.regionsBelow (d' + 1) && decide (b ≤ d') then some (.slice true d' t) else none
              | none => none
      | some (.map m _ c') =>
          match d with
          | 0 => none
          | d' + 1 =>
              match Ty.readAs m ot c' with
              | some c => if c.regionsBelow (d' + 1) && decide (b ≤ d') then some (.map true d' c) else none
              | none => none
      | _ => none
  | _, _, _, _, .mapv _ _ _ _ => none
  | _, d, Γ, _, .par e1 e2 =>
      match typecheck Δ Ξ Ψ f d d Γ [] e1, typecheck Δ Ξ Ψ f d d Γ [] e2 with
      | some _, some _ => if Γ.all Ty.mutFree then some .unit else none
      | _, _ => none
  | _, d, Γ, _, .parch t e1 e2 =>
      match typecheck Δ Ξ Ψ f d d ((.chan d t) :: Γ) [] e1,
            typecheck Δ Ξ Ψ f d d ((.chan d t) :: Γ) [] e2 with
      | some _, some _ =>
          if Γ.all Ty.mutFree && t.regionsBelow d && t.mutFree then some .unit else none
      | _, _ => none
  | _, _, _, _, .newchan rc t =>
      if decide (rc ≤ f) && t.regionsBelow rc && t.mutFree then some (.chan rc t) else none
  | b, d, Γ, Λ, .send c e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ c, typecheck Δ Ξ Ψ f b d Γ Λ e with
      | some (.chan _ t), some t' => if t' = t then some .unit else none
      | some (.own .tx _ t), some t' => if Ty.payOk t' t then some .unit else none
      | _, _ => none
  | b, d, Γ, Λ, .recv c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some (.chan _ t) => some t
      | some (.own .rx _ t) => if t.mutFree && t.chanFree then some (.opt (t.relocR (d - 1))) else none
      | _ => none
  | b, d, Γ, Λ, .close c =>
      match typecheck Δ Ξ Ψ f b d Γ Λ c with
      | some (.own .tx _ _) => some .unit
      | _ => none
  -- 実行時の形はソースに現れない。型付けに自由度がある（loc の m）ので検査器の対象外
  | _, _, _, _, .loc _ _ => none
  | _, _, _, _, .blit _ => none
  | _, _, _, _, .chanV _ => none
  -- 段 6 P1: 構造化スコープ・spawn・join・try（札・handle の値は実行時だけ）
  | b, d, Γ, _, .scope t ε e =>
      match typecheck Δ Ξ Ψ f b (d + 1) (.own .scope d ε :: Γ) [] e with
      | some tB =>
          if Ty.jumpRel b (d - 1) tB t && t.regionsBelow d && ε.mutFree && ε.chanFree && decide (b < d) then
            some (.union t (.union .unit (ε.relocR (d - 1))))
          else none
      | none => none
  | b, d, Γ, Λ, .spawn sc a e =>
      match typecheck Δ Ξ Ψ f b d Γ Λ sc, typecheck Δ Ξ Ψ f b d Γ Λ a with
      | some (.own .scope rs ε), some ta =>
          match typecheck Δ Ξ Ψ f d (d + 1) [ta.rehome d] [] e with
          | some (.prod t (.opt ε0)) =>
              if ta.givable rs && (Ty.prod t (.opt ε0)).mutFree && (Ty.prod t (.opt ε0)).chanFree && Ty.payOk ε0 ε then
                some (.own .task rs ((Ty.prod t (.opt ε0)).relocR rs))
              else none
          | _ => none
      | _, _ => none
  | b, d, _, _, .newch r cap t =>
      if decide (b ≤ r) && decide (r < d) && decide (1 ≤ cap) && t.mutFree && t.chanFree && t.regionsBelow d then
        some (.prod (.own .tx r t) (.own .rx r t))
      else none
  | _, _, _, _, .epV _ _ _ _ => none
  | b, d, Γ, Λ, .join t h =>
      match typecheck Δ Ξ Ψ f b d Γ Λ h with
      | some (.own .task _ t') => if t' = t then some t else none
      | _ => none
  | b, d, Γ, Λ, .tryJ t h =>
      match typecheck Δ Ξ Ψ f b d Γ Λ h with
      | some (.own .task _ t') => if t' = t then some (.opt t) else none
      | _ => none
  | _, _, _, _, .scopeV _ _ => none
  | _, _, _, _, .taskV _ _ => none

/-- 健全性: typecheck が受理すれば型付け導出がある -/
theorem typecheck_sound {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f : Nat} :
    ∀ {e : Expr} {b d : Nat} {Γ : Ctx} {Λ : LCtx} {t : Ty},
      typecheck Δ Ξ Ψ f b d Γ Λ e = some t → HasType Δ Ξ Ψ f b d Γ Λ e t := by
  intro e
  induction e with
  | lit n => intro _ _ _ _ _ h; cases h; exact .lit
  | flit n => intro _ _ _ _ _ h; cases h; exact .flit
  | tt => intro _ _ _ _ _ h; cases h; exact .tt
  | ff => intro _ _ _ _ _ h; cases h; exact .ff
  | triv => intro _ _ _ _ _ h; cases h; exact .triv
  | var i => intro _ _ _ _ _ h; exact .var (by simpa [typecheck] using h)
  | letE e body ihe ihb =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h
    · exact .letE (ihe ‹_›) (ihb h)
    · cases h
  | add a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .add (iha ‹_›) (ihc ‹_›)
  | lt a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .lt (iha ‹_›) (ihc ‹_›)
  | arith op a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .arith (iha ‹_›) (ihc ‹_›)
  | cmp op a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .cmp (iha ‹_›) (ihc ‹_›)
  | ite c t e ihc iht ihe =>
    intro b d Γ Λ τ h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i heq
    cases heq
    exact .ite (ihc ‹_›) (iht ‹_›) (ihe ‹_›)
  | nil t => intro _ _ _ _ _ h; cases h; exact .nil
  | some e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .some (ih ‹_›)
  | ifnil e n s ihe ihn ihs =>
    intro b d Γ Λ τ h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i heq
    cases heq
    exact .ifnil (ihe ‹_›) (ihn ‹_›) (ihs ‹_›)
  | inl r e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .inl (ih ‹_›)
  | inr l e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .inr (ih ‹_›)
  | case e bl br ihe ihl ihr =>
    intro b d Γ Λ τ h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i heq
    cases heq
    exact .case (ihe ‹_›) (ihl ‹_›) (ihr ‹_›)
  | pair a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .pair (iha ‹_›) (ihc ‹_›)
  | fst e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .fst (ih ‹_›)
  | snd e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .snd (ih ‹_›)
  | call fn ts e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq, and_assoc] at hcond
    obtain ⟨h1, h2, h3, h4⟩ := hcond
    exact .call ‹_› h1 h2 (ih ‹_›) h3 h4
  | callM fn ts e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hanc hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq, and_assoc] at hcond
    obtain ⟨h1, h2, h3, h4, h5⟩ := hcond
    exact .callM ‹_› h1 h2 (ih ‹_›) hanc h3 h4 h5
  | fnref fn ts =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .fnref ‹_› hcond.1 hcond.2
  | ann e t ih =>
    intro b d Γ Λ t' h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    exact .ann (ih ‹_›) ‹_›
  | callv ef e ihf ihe =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .callv (ihf ‹_›) (ihe ‹_›) hcond.1 hcond.2
  | callMv a ef e ihf ihe =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .callMv (ihf ‹_›) (ihe ‹_›) hcond.1.1 hcond.1.2 hcond.2
  | label t₀ e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    obtain ⟨rfl, hrb⟩ := hcond
    exact .label (ih ‹_›) hrb
  | unreach t₀ =>
    intro b d Γ Λ t h
    simp only [typecheck, Option.some.injEq] at h
    subst h
    exact .unreach
  | jump n t₀ e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    exact .jump ‹_› (ih ‹_›) hcond
  | block e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hrb
    exact .block (ih ‹_›) hrb
  | blockR t₀ e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true] at hcond
    exact .blockR (ih ‹_›) hcond.1 hcond.2
  | copyTo k₀ t₀ e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .copyTo (ih ‹_›) hcond.1.1.1 hcond.1.1.2 hcond.1.2 hcond.2
  | alloc m e ih =>
    intro b d Γ Λ t h
    cases d with
    | zero => simp [typecheck] at h
    | succ d' =>
      simp only [typecheck] at h
      split at h <;> try cases h
      split at h <;> try cases h
      rename_i hcond
      simp only [Bool.and_eq_true, decide_eq_true_eq, Bool.or_eq_true] at hcond
      refine .alloc (ih ‹_›) hcond.1.1 hcond.1.2 ?_
      intro hm
      rcases hcond.2 with hm' | hmf
      · rw [hm] at hm'; cases hm'
      · exact hmf
  | deref e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .deref (ih ‹_›)
  | assign l e ihl ihe =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i heq
    cases heq
    exact .assign (ihl ‹_›) (ihe ‹_›)
  | whileE c body ihc ihb =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .whileE (ihc ‹_›) (ihb ‹_›)
  | freeze e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h
    · -- ref
      split at h <;> cases h
      rename_i hmf
      exact .freeze (ih ‹_›) hmf
    · -- slice
      split at h <;> cases h
      rename_i hmf
      exact .freezes (ih ‹_›) hmf
    · -- map
      split at h <;> cases h
      rename_i hmf
      exact .freezem (ih ‹_›) hmf
    · cases h
  | mkslice m t₀ =>
    intro b d Γ Λ t h
    cases d with
    | zero => simp [typecheck] at h
    | succ d' =>
      simp only [typecheck] at h
      split at h <;> cases h
      rename_i hcond
      simp only [Bool.and_eq_true, decide_eq_true_eq, Bool.or_eq_true] at hcond
      refine .mkslice hcond.1.1 hcond.1.2 ?_
      intro hm
      rcases hcond.2 with hm' | hmf
      · rw [hm] at hm'; cases hm'
      · exact hmf
  | strlit bs r =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .strlit hcond.1 hcond.2
  | mksliceAt m t₀ r =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq, Bool.or_eq_true] at hcond
    obtain ⟨⟨⟨⟨h1, h2⟩, h3⟩, h4⟩, h5⟩ := hcond
    refine .mksliceAt h1 h2 h3 ?_ h5
    intro hm
    rcases h4 with hm' | hmf
    · rw [hm] at hm'; cases hm'
    · exact hmf
  | mkmapAt m t₀ r =>
    intro b d Γ Λ t h
    cases t₀ <;> try (simp [typecheck] at h; done)
    rename_i k c
    cases c <;> try (simp [typecheck] at h; done)
    simp only [typecheck] at h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq, Bool.or_eq_true] at hcond
    obtain ⟨⟨⟨⟨⟨h0, h1⟩, h2⟩, h3⟩, h4⟩, h5⟩ := hcond
    refine .mkmapAt h0 h1 h2 h3 ?_ h5
    intro hm
    rcases h4 with hm' | hmf
    · rw [hm] at hm'; cases hm'
    · exact hmf
  | index e i ot ihe ihi =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .index (ihe ‹_›) (ihi ‹_›) h
  | lenE e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .lenE (ih ‹_›)
  | tobyte e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .tobyte (ih ‹_›)
  | toint e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .toint (ih ‹_›)
  | farith op a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .farith (iha ‹_›) (ihc ‹_›)
  | fcmp op a c iha ihc =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .fcmp (iha ‹_›) (ihc ‹_›)
  | fconv op e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h
    · rename_i t0 ht0
      by_cases hd : t0 = op.dom
      · simp only [hd, if_true, Option.some.injEq] at h
        subst h; subst hd
        exact .fconv (ih ht0)
      · simp [hd] at h
    · cases h
  | append e v ihe ihv =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    · -- mut: region r（正確）へ
      split at h <;> cases h
      rename_i hcond
      simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
      cases hcond.1
      exact .appendM (ihe ‹_›) (ihv ‹_›) hcond.2
    · -- imm: 現在の最内 region へ（深さ 0 では書き先がない）
      split at h <;> try cases h
      split at h <;> cases h
      rename_i hcond
      simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
      cases hcond.1.1
      exact .appendI (ihe ‹_›) (ihv ‹_›) hcond.1.2 hcond.2
  | setidx e i v ihe ihi ihv =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i heq
    cases heq
    exact .setidx (ihe ‹_›) (ihi ‹_›) (ihv ‹_›)
  | subslice e sa sb ihe iha ihb =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .subslice (ihe ‹_›) (iha ‹_›) (ihb ‹_›)
  | eqs e1 e2 ih1 ih2 =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .eqs (ih1 ‹_›) (ih2 ‹_›)
  | concat e1 e2 ih1 ih2 =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    cases hcond.1
    exact .concat (ih1 ‹_›) (ih2 ‹_›) hcond.2
  | slicev mt r base len =>
    intro b d Γ Λ t h
    simp [typecheck] at h
  | mkmap m t₀ =>
    intro b d Γ Λ t h
    cases d with
    | zero => simp [typecheck] at h
    | succ d' =>
      cases t₀ <;> try (simp [typecheck] at h; done)
      rename_i k c
      cases c <;> try (simp [typecheck] at h; done)
      simp only [typecheck] at h
      split at h <;> cases h
      rename_i hcond
      simp only [Bool.and_eq_true, decide_eq_true_eq, Bool.or_eq_true] at hcond
      refine .mkmap hcond.1.1.1 hcond.1.1.2 hcond.1.2 ?_
      intro hm
      rcases hcond.2 with hm' | hmf
      · rw [hm] at hm'; cases hm'
      · exact hmf
  | getm t₀ e k ihe ihk =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    obtain ⟨hsub, hkc⟩ := hcond
    exact .getm (ihe ‹_›) (ihk ‹_›) hkc hsub
  | setm e k v ihe ihk ihv =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    obtain ⟨rfl, rfl⟩ := hcond
    exact .setm (ihe ‹_›) (ihk ‹_›) (ihv ‹_›)
  | delm t₀ e k ihe ihk =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    obtain ⟨rfl, hkc⟩ := hcond
    exact .delm (ihe ‹_›) (ihk ‹_›) hkc
  | lenm e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> cases h
    exact .lenm (ih ‹_›)
  | keysm e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .keysm (ih ‹_›) hcond.1.1 hcond.1.2 hcond.2
  | clone ot e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h
    · split at h
      · cases h
      · split at h
        · split at h
          · cases h
            rename_i hrd hcond
            simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
            exact .clones (ih ‹_›) hrd hcond.1 hcond.2
          · cases h
        · cases h
    · split at h
      · cases h
      · split at h
        · split at h
          · cases h
            rename_i hrd hcond
            simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
            exact .clonem (ih ‹_›) hrd hcond.1 hcond.2
          · cases h
        · cases h
    · cases h
  | mapv mt r base len =>
    intro b d Γ Λ t h
    simp [typecheck] at h
  | par e1 e2 ih1 ih2 =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hΓ
    exact .par (ih1 ‹_›) (ih2 ‹_›)
      (fun τ hτ => by have := List.all_eq_true.mp hΓ τ hτ; simpa using this)
  | parch t e1 e2 ih1 ih2 =>
    intro b d Γ Λ τ h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true] at hcond
    exact .parch (ih1 ‹_›) (ih2 ‹_›)
      (fun τ' hτ => by have := List.all_eq_true.mp hcond.1.1 τ' hτ; simpa using this)
      hcond.1.2 hcond.2
  | newchan rc t =>
    intro b d Γ Λ τ h
    simp only [typecheck] at h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .newchan hcond.1.1 hcond.1.2 hcond.2
  | send c e ihc ihe =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h
    · split at h
      · cases h; rename_i heq; subst heq; exact .send (ihc ‹_›) (ihe ‹_›)
      · cases h
    · split at h
      · cases h; rename_i heq; exact .sendE (ihc ‹_›) (ihe ‹_›) heq
      · cases h
    · cases h
  | recv c ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    · exact .recv (ih ‹_›)
    · split at h <;> try cases h
      rename_i hcond
      simp only [Bool.and_eq_true] at hcond
      exact .recvE (ih ‹_›) hcond.1 hcond.2
  | close c ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    exact .closeE (ih ‹_›)
  | loc r a => intro _ _ _ _ _ h; simp [typecheck] at h
  | blit n => intro _ _ _ _ _ h; simp [typecheck] at h
  | chanV c => intro _ _ _ _ _ h; simp [typecheck] at h
  | scope t₀ ε₀ e ih =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true] at hcond
    simp only [decide_eq_true_eq] at hcond
    exact .scope (ih ‹_›) hcond.1.1.1.1 hcond.1.1.1.2 hcond.1.1.2 hcond.1.2 hcond.2
  | spawn sc a e ihsc iha ihe =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    split at h <;> try cases h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true] at hcond
    exact .spawn (ihsc ‹_›) (iha ‹_›) hcond.1.1.1 (ihe ‹_›) hcond.1.1.2 hcond.1.2 hcond.2
  | newch r cap t₀ =>
    intro b d Γ Λ t h
    simp only [typecheck] at h
    split at h <;> try cases h
    rename_i hcond
    simp only [Bool.and_eq_true, decide_eq_true_eq] at hcond
    exact .newch hcond.1.1.1.1.1 hcond.1.1.1.1.2 hcond.1.1.1.2 hcond.1.1.2 hcond.1.2 hcond.2
  | epV p k b r => intro _ _ _ _ _ h; simp [typecheck] at h
  | join t₀ h ih =>
    intro b d Γ Λ t hh
    simp only [typecheck] at hh
    split at hh <;> try cases hh
    split at hh <;> try cases hh
    rename_i heq
    cases heq
    exact .join (ih ‹_›)
  | tryJ t₀ h ih =>
    intro b d Γ Λ t hh
    simp only [typecheck] at hh
    split at hh <;> try cases hh
    split at hh <;> try cases hh
    rename_i heq
    cases heq
    exact .tryJ (ih ‹_›)
  | scopeV rs => intro _ _ _ _ _ h; simp [typecheck] at h
  | taskV rs n => intro _ _ _ _ _ h; simp [typecheck] at h

/-- 完全性: ソース項の型付け導出があれば typecheck が同じ型を返す -/
theorem typecheck_complete {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f : Nat} :
    ∀ {e : Expr} {b d : Nat} {Γ : Ctx} {t : Ty},
      HasType Δ Ξ Ψ f b d Γ Λ e t → e.src = true → typecheck Δ Ξ Ψ f b d Γ Λ e = some t := by
  intro e b d Γ t h
  induction h with
  | lit => intro _; rfl
  | flit => intro _; rfl
  | tt => intro _; rfl
  | ff => intro _; rfl
  | triv => intro _; rfl
  | var hget => intro _; simpa [typecheck]
  | letE h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | add h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | lt h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | arith h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | cmp h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | ite h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | nil => intro _; rfl
  | some h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | ifnil h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | inl h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | inr h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | case h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | pair h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | fst h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | snd h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | call hfn hlen hargs harg hsub hbd ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, hfn, ih hs, hsub, hbd, hlen, hargs]
  | callM hfn hlen hargs harg hanc hsub hbd had ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, hfn, ih hs, hanc, hsub, hbd, had, hlen, hargs]
  | fnref hfn hlen hargs => intro _; simp [typecheck, hfn, hlen, hargs]
  | ann h1 hs ih =>
    intro hsrc
    simp only [Expr.src] at hsrc
    simp [typecheck, ih hsrc, hs]
  | callv hf harg hsub hbd ihf ihe =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ihf hs.1, ihe hs.2, hsub, hbd]
  | callMv hf harg hsub hbd had ihf ihe =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ihf hs.1, ihe hs.2, hsub, hbd, had]
  | label h1 hrb ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrb]
  | unreach =>
    intro _
    simp [typecheck]
  | jump hn h1 hrel ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hn, hrel]
  | block h1 hrb ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrb]
  | blockR h1 hrel hrb ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrel, hrb]
  | copyTo h1 hk hrel hrb hcf ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hk, hrel, hrb, hcf]
  | alloc h1 hrb hbd hmf ih =>
    intro hs
    simp only [Expr.src] at hs
    rename_i m _ _
    cases m with
    | false => simp [typecheck, ih hs, hrb, hbd, hmf rfl]
    | true => simp [typecheck, ih hs, hrb, hbd]
  | deref h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | assign h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | whileE h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | freeze h1 hmf ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hmf]
  | freezes h1 hmf ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hmf]
  | freezem h1 hmf ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hmf]
  | mkslice hrb hbd hmf =>
    intro _
    rename_i m _ _
    cases m with
    | false => simp [typecheck, hrb, hbd, hmf rfl]
    | true => simp [typecheck, hrb, hbd]
  | strlit hbr hrd =>
    intro _
    simp [typecheck, hbr, hrd]
  | mksliceAt hrb hbr hrd hmf hcf =>
    intro _
    rename_i m _ _ _
    cases m with
    | false => simp [typecheck, hrb, hbr, hrd, hmf rfl, hcf]
    | true => simp [typecheck, hrb, hbr, hrd, hcf]
  | mkmapAt hko hrb hbr hrd hmf hcf =>
    intro _
    rename_i m _ _ _ _
    cases m with
    | false => simp [typecheck, hko, hrb, hbr, hrd, hmf rfl, hcf]
    | true => simp [typecheck, hko, hrb, hbr, hrd, hcf]
  | index h1 h2 hrd ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hrd]
  | lenE h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | tobyte h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | toint h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | farith h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | fcmp h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | fconv h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | blit => intro hs; simp [Expr.src] at hs
  | appendM h1 h2 hbr ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hbr]
  | appendI h1 h2 hbd hbt ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hbd, hbt]
  | setidx h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | subslice h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | eqs h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | concat h1 h2 hbd ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hbd]
  | slicev hk h2 h3 h4 h5 h6 h7 =>
    intro hs
    simp [Expr.src] at hs
  | mkmap hko hrb hbd hmf =>
    intro _
    rename_i m _ _ _
    cases m with
    | false => simp [typecheck, hko, hrb, hbd, hmf rfl]
    | true => simp [typecheck, hko, hrb, hbd]
  | getm h1 h2 hkc hsub ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hkc, hsub]
  | setm h1 h2 h3 ih1 ih2 ih3 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1.1, ih2 hs.1.2, ih3 hs.2]
  | delm h1 h2 hkc ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hkc]
  | lenm h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | keysm h hko hrb hbd ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hko, hrb, hbd]
  | clones h hrd hrb hbd ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrd, hrb, hbd]
  | clonem h hrd hrb hbd ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrd, hrb, hbd]
  | mapv hk h2 h3 h4a h4b h5 =>
    intro hs
    simp [Expr.src] at hs
  | par h1 h2 hΓ ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, List.all_eq_true.mpr fun τ hτ => hΓ τ hτ]
  | parch h1 h2 hΓ hrb hmf ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hrb, hmf,
      List.all_eq_true.mpr fun τ hτ => hΓ τ hτ]
  | newchan hf hrb hmf =>
    intro _
    simp [typecheck, hf, hrb, hmf]
  | send h1 h2 ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2]
  | recv h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | sendE h1 h2 hp ih1 ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp [typecheck, ih1 hs.1, ih2 hs.2, hp]
  | recvE h hm hc ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hm, hc]
  | closeE h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | newch h1 h2 h3 h4 h5 h6 =>
    intro _
    simp only [typecheck, h1, h2, h3, h4, h5, h6, decide_true, Bool.and_self, if_true]
  | epTx _ _ _ => intro hs; simp [Expr.src] at hs
  | epRx _ _ _ => intro hs; simp [Expr.src] at hs
  | loc _ _ _ _ _ => intro hs; simp [Expr.src] at hs
  | chanV _ _ _ => intro hs; simp [Expr.src] at hs
  | scope h1 hrel hrb hem hec hbd ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs, hrel, hrb, hem, hec, hbd]
  | spawn h1 ha hg h2 hrb hcf hε ih1 iha ih2 =>
    intro hs
    simp only [Expr.src, Bool.and_eq_true] at hs
    simp only [typecheck, ih1 hs.1.1, iha hs.1.2, ih2 hs.2, hg, hrb, hcf, hε, Bool.and_self, if_true]
  | join h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | tryJ h ih =>
    intro hs
    simp only [Expr.src] at hs
    simp [typecheck, ih hs]
  | scopeV _ _ => intro hs; simp [Expr.src] at hs
  | taskV _ _ _ => intro hs; simp [Expr.src] at hs

/-- ソース項の型付けは typecheck が決定する -/
theorem hasType_iff_typecheck {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx}
    {e : Expr} {t : Ty} (hs : e.src = true) :
    HasType Δ Ξ Ψ f b d Γ Λ e t ↔ typecheck Δ Ξ Ψ f b d Γ Λ e = some t :=
  ⟨fun h => typecheck_complete h hs, typecheck_sound⟩

/-- 関数表の実行可能な検査（DefsOk の checker 版）。境界の loc-free と本体の型付けを見る -/
def checkDefs (Δ : Defs) : Bool :=
  Δ.all fun dfn => Ty.paramOk dfn.param && Ty.retOk dfn.ret &&
    dfn.body.noNewchan &&
    dfn.param.tvarsBelow dfn.tparams && dfn.ret.tvarsBelow dfn.tparams && dfn.body.src &&
    (typecheck Δ ∅ [] 1 0 2 [dfn.param] [] dfn.body == some dfn.ret)

/-- checkDefs が受理すれば DefsOk（typecheck_sound 経由。ソース制約は不要 — sound は全項） -/
theorem defsOk_of_check {Δ : Defs} (h : checkDefs Δ = true) : DefsOk Δ := by
  intro fn dfn hfn
  have hmem : dfn ∈ Δ := by
    obtain ⟨hlt, heq⟩ := List.getElem?_eq_some_iff.mp hfn
    exact heq ▸ Δ.getElem_mem hlt
  have := List.all_eq_true.mp h dfn hmem
  simp only [Bool.and_eq_true, beq_iff_eq, and_assoc] at this
  obtain ⟨h1, h2, h3, h4, h5, h6, h7⟩ := this
  exact ⟨h1, h2, h3, h4, h5, h6, typecheck_sound h7⟩

/-- ソース項の型は一意 -/
theorem hasType_unique {Δ : Defs} {Ξ : ChanTy} {Ψ : StoreTy} {f b d : Nat} {Γ : Ctx}
    {e : Expr} {t₁ t₂ : Ty} (hs : e.src = true)
    (h₁ : HasType Δ Ξ Ψ f b d Γ Λ e t₁) (h₂ : HasType Δ Ξ Ψ f b d Γ Λ e t₂) : t₁ = t₂ :=
  Option.some.inj ((typecheck_complete h₁ hs).symm.trans (typecheck_complete h₂ hs))

end FS
