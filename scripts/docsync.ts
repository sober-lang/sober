// docsync: 文書のコードの塊と examples/ の実物の一致（README とガイドと仕様の例は網〔obs ほか〕が建てて走らせる実物 — 文書の写しがずれたら鳴る）。
// 対象 = README{,.ja}.md と docs/guide/*.md・docs/spec/*.md（英語版と日本語版） の ```sober の塊のうち、1 行目が `// examples/<名前>.sober` のもの。2 行目以降が examples/<名前>.sober の中身と同じこと。
// 「出力:」/「Output:」の直後の ``` の塊があれば examples/<名前>.out とも照合する。「拒否:」/「Rejected:」の直後の塊は check の拒否の診断
// （testdata/checkverdict/examples_<名前>.sober.txt から終了コードの行を除いたもの）と照合する。
// 仕様（docs/spec/）の規則の段落（`X-N. ` — 規則番号とピリオドで始まる段落）は、さらに次を照合する:
//   - `例:` / `拒否:` の examples/ の参照が 1 本以上・ファイルが実在・`例:` は check が受理（黄金の exit=0）・`拒否:` は check が拒否（exit≠0）
//   - `決定:` の行のリンクの `language.md N 節` が language.md の `### N.` に・`syntax.md 決定 N` が syntax.md の `N. ` の行に実在する
//   - 規則の番号が章の中で重複しない・接頭辞が章で 1 つ・参照の行（例 / 拒否 / 決定）を持つ段落は規則番号で始まる
//   node --experimental-strip-types scripts/docsync.ts
import { readFileSync, readdirSync, existsSync } from "node:fs";
const md = (dir: string) => (existsSync(dir) ? readdirSync(dir).filter((f) => f.endsWith(".md")).sort().map((f) => `${dir}/${f}`) : []);
const specs = md("docs/spec");
const docs = [...["README.md", "README.ja.md"].filter((f) => existsSync(f)), ...md("docs/guide"), ...specs];
let n = 0, fail = 0;
const bad = (msg: string) => { console.log(`FAIL: ${msg}`); fail++; };
// check の判定の黄金（受理 = exit=0・本文 = 終了コードの行を除いた診断）
const verdict = (name: string) => {
  const g = `testdata/checkverdict/examples_${name}.sober.txt`;
  if (!existsSync(g)) return undefined;
  const lines = readFileSync(g, "utf8").replace(/\n$/, "").split("\n");
  const ec = lines.pop() ?? "";
  return { ok: ec === "exit=0", text: lines.join("\n") };
};
for (const d of docs) {
  const s = readFileSync(d, "utf8");
  const re = /```sober\n\/\/ (examples\/[A-Za-z0-9_]+)\.sober\n([\s\S]*?)\n```(?:\n\n(出力|Output|拒否|Rejected):\n\n```\n([\s\S]*?)\n```)?/g;
  for (const m of s.matchAll(re)) {
    n++;
    const src = readFileSync(`${m[1]}.sober`, "utf8").replace(/\n$/, "");
    if (src !== m[2]) bad(`${d}: the code block for ${m[1]}.sober differs from the file`);
    if (m[3] === "出力" || m[3] === "Output") {
      const out = existsSync(`${m[1]}.out`) ? readFileSync(`${m[1]}.out`, "utf8").replace(/\n$/, "") : "";
      if (out !== m[4]) bad(`${d}: the output block for ${m[1]} differs from ${m[1]}.out`);
    } else if (m[3] !== undefined) {
      const v = verdict(m[1].slice("examples/".length));
      if (v === undefined || v.ok || v.text !== m[4]) bad(`${d}: the rejection block for ${m[1]} differs from its checkverdict golden`);
    }
  }
}
// 仕様の規則の段落
const sections = new Set([...readFileSync("docs/language.md", "utf8").matchAll(/^### (\d+)\. /gm)].map((m) => m[1]));
const decisions = new Set([...readFileSync("docs/syntax.md", "utf8").matchAll(/^(\d+)\. /gm)].map((m) => m[1]));
let rules = 0;
for (const d of specs) {
  const seen = new Set<string>();
  let prefix: string | undefined;
  for (const para of readFileSync(d, "utf8").split(/\n\s*\n/)) {
    const id = para.match(/^([A-Z]+-\d+)\. /)?.[1];
    if (id === undefined) {
      // 規則番号の崩れ（`T1.`・`T-1 `・太字の残り等）で段落が規則として数えられず照合を素通りする形を塞ぐ — 参照の行を持つ段落は規則番号で始まる
      if (/^(例|Example|拒否|Rejected|決定|Decided): *\S/m.test(para)) bad(`${d}: a paragraph has 例: / 拒否: / 決定: lines but does not start with a rule number (X-N. ): ${para.split("\n")[0].slice(0, 40)}`);
      continue;
    }
    const pre = id.split("-")[0];
    if (prefix === undefined) prefix = pre;
    else if (pre !== prefix) bad(`${d}: rule ${id} has a different prefix from the chapter's (${prefix}-)`);
    rules++;
    if (seen.has(id)) bad(`${d}: rule ${id} appears more than once`);
    seen.add(id);
    let refs = 0;
    for (const line of para.split("\n")) {
      const kind = line.match(/^(例|Example|拒否|Rejected):/)?.[1];
      if (kind !== undefined) {
        const want = kind === "例" || kind === "Example";
        for (const r of line.matchAll(/`examples\/([A-Za-z0-9_]+)\.sober`/g)) {
          refs++;
          if (!existsSync(`examples/${r[1]}.sober`)) { bad(`${d}: ${id}: examples/${r[1]}.sober does not exist`); continue; }
          const v = verdict(r[1]);
          if (v === undefined) bad(`${d}: ${id}: examples/${r[1]}.sober has no checkverdict golden`);
          else if (v.ok !== want) bad(`${d}: ${id}: examples/${r[1]}.sober is listed as ${want ? "accepted" : "rejected"} but check ${v.ok ? "accepts" : "rejects"} it`);
        }
      }
      if (/^(決定|Decided):/.test(line)) {
        // リンクの文面ごとに: `language.md N 節・M 節` は language.md の `### N.`、`syntax.md 決定 N・M` は syntax.md 7 節の `N. ` の行
        let k = 0;
        for (const l of line.matchAll(/\[([^\]]+)\]\(([^)]+)\)/g)) {
          if (l[1].startsWith("language.md")) {
            for (const m of l[1].matchAll(/(\d+) (?:節|§)/g)) { k++; if (!sections.has(m[1])) bad(`${d}: ${id}: language.md has no section ${m[1]}`); }
          } else if (l[1].startsWith("syntax.md")) {
            for (const m of l[1].matchAll(/(\d+)/g)) { k++; if (!decisions.has(m[1])) bad(`${d}: ${id}: syntax.md has no decision ${m[1]}`); }
          }
        }
        if (k === 0) bad(`${d}: ${id}: the decision line names no section`);
      }
    }
    if (refs === 0) bad(`${d}: ${id}: no example (例: / 拒否:) is linked`);
    if (!/^(決定|Decided):/m.test(para)) bad(`${d}: ${id}: no decision line (決定: language.md N 節)`);
  }
}
console.log(`docsync: ${n} code blocks match examples/, ${rules} spec rules checked, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
