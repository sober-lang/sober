import FeatherweightSober.Json

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

def main (args : List String) : IO UInt32 := do
  if args == ["--batch"] then
    batchLoop (← IO.getStdin) (← IO.getStdout)
    return 0
  let input ← (← IO.getStdin).readToEnd
  let result := FS.JsonBoundary.checkInput input
  IO.println result.compress
  match result.getObjVal? "ok" with
  | .ok (.bool true) => return 0
  | _ => return 1
