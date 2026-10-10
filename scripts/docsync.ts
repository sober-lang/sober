// docsync: 文書のコードの塊と examples/ の実物の一致（README とガイドの例は網〔obs ほか〕が建てて走らせる実物 — 文書の写しがずれたら鳴る）。
// 対象 = README{,.ja}.md と docs/guide/*.md（英語版と日本語版） の ```sober の塊のうち、1 行目が `// examples/<名前>.sober` のもの。2 行目以降が examples/<名前>.sober の中身と同じこと。
// 「出力:」/「Output:」の直後の ``` の塊があれば examples/<名前>.out とも照合する
//   node --experimental-strip-types scripts/docsync.ts
import { readFileSync, readdirSync, existsSync } from "node:fs";
const docs = [...["README.md", "README.ja.md"].filter((f) => existsSync(f)), ...readdirSync("docs/guide").filter((f) => f.endsWith(".md")).map((f) => `docs/guide/${f}`)];
let n = 0, fail = 0;
for (const d of docs) {
  const s = readFileSync(d, "utf8");
  const re = /```sober\n\/\/ (examples\/[A-Za-z0-9_]+)\.sober\n([\s\S]*?)\n```(?:\n\n(?:出力|Output):\n\n```\n([\s\S]*?)\n```)?/g;
  for (const m of s.matchAll(re)) {
    n++;
    const src = readFileSync(`${m[1]}.sober`, "utf8").replace(/\n$/, "");
    if (src !== m[2]) { console.log(`FAIL: ${d}: the code block for ${m[1]}.sober differs from the file`); fail++; }
    if (m[3] !== undefined) {
      const out = existsSync(`${m[1]}.out`) ? readFileSync(`${m[1]}.out`, "utf8").replace(/\n$/, "") : "";
      if (out !== m[3]) { console.log(`FAIL: ${d}: the output block for ${m[1]} differs from ${m[1]}.out`); fail++; }
    }
  }
}
console.log(`docsync: ${n} code blocks in README.md and docs/guide/ match examples/, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
