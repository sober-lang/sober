import Extract

/-!
# sober-extract: Lean → Sober 抽出器（E1）

`lake exe sober-extract`        生成物（Extract/Config.lean の targets を Sober へ）を stdout に
`lake exe sober-extract --tc`   typecheck の 1 フレームの遷移（Config.lean の tcTargets — 段 6 P2b）を stdout に
`lake exe sober-extract --neg`  負例（Extract/Neg.lean）が全部止まることを確かめる（1 つでも写せたら終了コード 1）
-/

open Lean Meta

def runMeta {α : Type} (env : Environment) (x : MetaM α) : IO α := do
  let ctx : Core.Context := { fileName := "<sober-extract>", fileMap := default, maxHeartbeats := 0, options := {} }
  let st : Core.State := { env := env }
  let (a, _) ← (x.run' {} {}).toIO ctx st
  return a

def main (args : List String) : IO UInt32 := do
  initSearchPath (← findSysroot)
  let env ← importModules #[{ module := `Extract }] {} (loadExts := true)
  if args == ["--neg"] then
    let ok ← runMeta env do
      let env' : Extract.Env := { sigs := ← Extract.targets.mapM Extract.fnSig, alls := ← IO.mkRef [] }
      let mut ok := true
      for (n, act) in Extract.Neg.cases env' do
        try
          let _ ← act
          IO.println s!"FAIL: {n}: 写せてしまった（止まるべき）"
          ok := false
        catch e =>
          IO.println s!"ok: {n}: 止まった — {← e.toMessageData.toString}"
      return ok
    return if ok then 0 else 1
  if args == ["--tc"] then
    IO.print (← runMeta env Extract.genTcFile)
    return 0
  let out ← runMeta env Extract.genFile
  IO.print out
  return 0
