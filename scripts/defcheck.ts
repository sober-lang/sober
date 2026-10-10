// sober-check の `def error`（どの Def かを言わない）を Def 単位に割る。
//
//   sober check <file.sober> --core-json > core.json
//   node --experimental-strip-types scripts/defcheck.ts core.json [i,j,...]
//
// Def を 1 つずつ本体つき・残りを署名だけにした部分検査の封筒（{"parts":true} — Json.lean の checkPartsToJson）を作り、
// 検査器に掛けて落ちる Def の番号を出す。検査器は $SOBER_CHECK（無ければ lean/.lake/build/bin/sober-check）。
// 番号は core.json の defs の添字（名前は `sober check --core-json-pkg` の記号名と突き合わせる）
import { readFileSync, writeFileSync, mkdtempSync } from "fs";
import { spawnSync } from "child_process";
import { tmpdir } from "os";
import { join } from "path";

const chk = process.env.SOBER_CHECK ?? join(import.meta.dirname, "../lean/.lake/build/bin/sober-check");
const j = JSON.parse(readFileSync(process.argv[2], "utf8"));
const dir = mkdtempSync(join(tmpdir(), "defcheck-"));
const only: number[] = process.argv[3] ? process.argv[3].split(",").map(Number) : j.defs.map((_: unknown, i: number) => i);
const bad: number[] = [];
for (const i of only) {
  const defs = j.defs.map((d: any, k: number) =>
    k === i ? d : { ...(d.tparams ? { tparams: d.tparams } : {}), param: d.param, ret: d.ret });
  const p = join(dir, `${i}.json`);
  writeFileSync(p, JSON.stringify({ parts: true, defs }));
  const out = spawnSync(chk, [], { input: readFileSync(p), encoding: "utf8" }).stdout.trim();
  if (!out.includes('"ok":true')) {
    bad.push(i);
    console.log(i, out);
  }
}
console.log(`defcheck: ${only.length} defs, bad: ${bad.join(",") || "none"}`);
