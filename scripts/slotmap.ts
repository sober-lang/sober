// slotmap: 2 本の IR テキスト（.ir）または LLVM テキスト（.ll）が「スロットの宣言と番号を除いて一致」するかを照合する（S-1 — スロット彩色）。
//
//   node scripts/slotmap.ts A B      exit 0 = 一致（A → B のスロットの対応が関数になり、語数が収まる）、1 = 不一致（理由を stderr に 1 行）
//
// A は使い回し前（Zig 版 stage1・旧黄金）、B は使い回し後（Sober 版）。関数ごとに:
//   - スロットの宣言（.ir: `  slot sN [w]`、.ll: `  %sN = alloca [w x i64], align 8` とそのゼロ初期化 `%sN.zK = …` / `store i64 0, ptr %sN.zK`）を外す
//   - 残りのテキストのスロット参照（.ir: `slotaddr sN`、.ll: `%sN`）を印に置き換え、出現順の番号の列を取る
//   - 印に置き換えたテキストが一致し、A の番号 → B の番号が一貫した写像（同じ A のスロットは常に同じ B のスロット）で、
//     B のスロットの語数 ≥ A のスロットの語数であること
// 写像が単射でないこと（A の複数のスロットが B の 1 つに畳まれること）が使い回しそのもの。生存区間の重なりの安全はここでは見ない（実行の照合が見る）
import { readFileSync } from "node:fs";

type Fn = { name: string; body: string; refs: number[]; words: Map<number, number> };

function parse(text: string): Fn[] {
  const ll = /^define /m.test(text);
  const fns: Fn[] = [];
  let cur: Fn = { name: "(top)", body: "", refs: [], words: new Map() };
  fns.push(cur);
  const decl = ll ? /^  %s(\d+) = alloca \[(\d+) x i64\], align 8$/ : /^  slot s(\d+) \[(\d+)\]$/;
  const zinit = /^  (%s\d+\.z\d+ = getelementptr i64, ptr %s\d+, i64 \d+|store i64 0, ptr %s\d+\.z\d+)$/;
  const ref = ll ? /%s(\d+)\b(?!\.z)/g : /\bslotaddr s(\d+)\b/g;
  for (const line of text.split("\n")) {
    if (/^(func|define) /.test(line)) {
      cur = { name: line, body: "", refs: [], words: new Map() };
      fns.push(cur);
    }
    const d = decl.exec(line);
    if (d) {
      cur.words.set(Number(d[1]), Number(d[2]));
      continue;
    }
    if (ll && zinit.test(line)) continue;
    cur.body += line.replace(ref, (m, n) => {
      cur.refs.push(Number(n));
      return ll ? "%s?" : "slotaddr s?";
    }) + "\n";
  }
  return fns;
}

function check(a: string, b: string): string | null {
  const fa = parse(a);
  const fb = parse(b);
  if (fa.length !== fb.length) return `function count ${fa.length} ≠ ${fb.length}`;
  for (let i = 0; i < fa.length; i++) {
    const x = fa[i];
    const y = fb[i];
    if (x.body !== y.body) {
      const lx = x.body.split("\n");
      const ly = y.body.split("\n");
      let k = 0;
      while (k < lx.length && lx[k] === ly[k]) k++;
      return `${x.name.slice(0, 60)}: text differs outside slots at line ${k + 1}: ${JSON.stringify(lx[k] ?? "")} vs ${JSON.stringify(ly[k] ?? "")}`;
    }
    const map = new Map<number, number>();
    for (let k = 0; k < x.refs.length; k++) {
      const s = x.refs[k];
      const t = y.refs[k];
      const prev = map.get(s);
      if (prev === undefined) map.set(s, t);
      else if (prev !== t) return `${x.name.slice(0, 60)}: slot s${s} maps to both s${prev} and s${t}`;
    }
    for (const [s, t] of map) {
      const ws = x.words.get(s);
      const wt = y.words.get(t);
      if (ws === undefined || wt === undefined) return `${x.name.slice(0, 60)}: undeclared slot s${s} / s${t}`;
      if (wt < ws) return `${x.name.slice(0, 60)}: slot s${s} [${ws}] → s${t} [${wt}] too small`;
    }
    // 宣言だけあって参照の無いスロットは双方で数だけ見る（B は使い回しで減るだけ）
    if (y.words.size > x.words.size) return `${x.name.slice(0, 60)}: more slots after coloring (${x.words.size} → ${y.words.size})`;
  }
  return null;
}

const [pa, pb] = process.argv.slice(2);
if (!pa || !pb) {
  console.error("usage: node scripts/slotmap.ts A B");
  process.exit(2);
}
const why = check(readFileSync(pa, "utf8"), readFileSync(pb, "utf8"));
if (why !== null) {
  console.error(`slotmap: ${why}`);
  process.exit(1);
}
