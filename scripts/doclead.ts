// doclead の判定: `sober outline --format=json` の出力（ファイルの列）を読み、doc コメントが宣言自身の名前で始まる宣言を名指しする。
// 名前は冗長なので doc は中身から書く（「// buildRoundtrip は …」でなく「// …」）。違反の数を終了コードに（0 = 緑）
//   node --experimental-strip-types scripts/doclead.ts <outline.json>…
import { readFileSync } from "node:fs";
type Decl = { kind: string; name: string; lines: [number, number]; doc: string };
type File = { file: string; decls: Decl[] };
// 名前（型引数 [..]・引数 (..)・`・` や `.` で続く名前の並びを含む）の直後が「は」— std の docgen の namedLead と同じ形
function leadsWith(doc: string, name: string): boolean {
  const esc = name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return new RegExp("^" + esc + "(\\[[^\\]]*\\]|\\([^)]*\\)|(・|\\.)[A-Za-z_][\\w.・]*)*\\s*は").test(doc);
}
let bad = 0, n = 0;
for (const path of process.argv.slice(2)) {
  const files: File[] = JSON.parse(readFileSync(path, "utf8"));
  for (const f of files) {
    for (const d of f.decls) {
      n++;
      if (leadsWith(d.doc, d.name)) {
        console.log(`FAIL ${f.file}:${d.lines[0]}: the doc comment of ${d.name} starts with its own name — start from what it does`);
        bad++;
      }
    }
  }
}
console.log(`doclead: ${n} declarations, ${bad} start with their own name`);
process.exit(bad === 0 ? 0 : 1);
