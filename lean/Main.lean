import FeatherweightSober.Json
import FeatherweightSober.UniqFreeze

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

def main (args : List String) : IO UInt32 := do
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
