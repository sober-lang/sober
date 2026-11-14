// docsync: 文書のコードのチャンクとexamples/ の実物の一致（READMEとガイドと仕様の例は検査〔obsほか〕がビルドして走らせる実物 — 文書のコピーがずれたら鳴る）。
// 対象 = README{,.ja}.mdとdocs/value-oriented{,.ja}.mdとdocs/guide/*.md・docs/spec/*.md（英語版と日本語版） の ```sober のチャンクのうち、1 行目が `// examples/<名前>.sober` のもの。2行目以降がexamples/<名前>.soberの中身と同じこと。
// 「出力:」/「Output:」の直後の ``` のチャンクがあればexamples/<名前>.outとも照合する。「拒否:」/「Rejected:」の直後のチャンクはcheckの拒否の診断
// （testdata/checkverdict/examples_<名前>.sober.txt から終了コードの行を除いたもの）と照合する。
// 仕様（docs/spec/）の規則の段落（`X-N. ` — 規則番号とピリオドで始まる段落）は、さらに次を照合する:
//   - `例:` / `拒否:` のexamples/ の参照が1本以上・ファイルが実在・`例:` はcheckが受理（ゴールデンのexit=0）・`拒否:` はcheckが拒否（exit≠0）
//   - `決定:` の行のリンクの `language.md N 節` が language.md の `### N.` に・`syntax.md 決定 N` が syntax.md の `N. ` の行に実在する
//   - 規則の番号が章の中で重複しない・接頭辞が章で 1 つ・参照の行（例 / 拒否 / 決定）を持つ段落は規則番号で始まる
// テスティングガイドのpackageの題材と `$ sober …` の出力の照合は下の節（検査guidetestのゴールデンと）
//   node --experimental-strip-types scripts/docsync.ts
import { readFileSync, readdirSync, existsSync } from "node:fs";
const md = (dir: string) => (existsSync(dir) ? readdirSync(dir).filter((f) => f.endsWith(".md")).sort().map((f) => `${dir}/${f}`) : []);
const specs = md("docs/spec");
const docs = [...["README.md", "README.ja.md", "docs/value-oriented.md", "docs/value-oriented.ja.md"].filter((f) => existsSync(f)), ...md("docs/guide"), ...specs];
let n = 0, fail = 0;
const bad = (msg: string) => { console.log(`FAIL: ${msg}`); fail++; };
// checkの判定のゴールデン（受理 = exit=0・本文 = 終了コードの行を除いた診断）
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
// packageの題材（examples/guide/<package>/<ファイル>.sober — テスティングガイド・examples/mod/<モジュール>/… — 最初のガイド）とexamples/<名前>.sober: 1行目の末尾が `（抜粋）` / ` (excerpt)` のチャンクはファイルの連続した行の抜粋
// （抜粋のチャンクは出力の照合を持たない）、examples/guide/ の他のチャンクはファイルの全体と一致。`$ sober …` の1行だけの ```shのチャンクの直後の「出力:」/「Output:」のチャンクは、testdata/guide/testing.cmdsの同じコマンドのゴールデン
// （testdata/guide/testing/<名前>.out — 検査guidetestが走らせた実物）から終了コードの行を除いたものと一致。一覧に無いコマンドは明示する
// コマンドの一覧は2本: testing.cmds（examples/guideが起点 — ゴールデンtestdata/guide/testing/）・modules.cmds（examples/mod/helloが起点 — ゴールデンtestdata/guide/modules/）
const cmds = new Map<string, string>();
for (const k of ["testing", "modules"]) {
  const f = `testdata/guide/${k}.cmds`;
  if (!existsSync(f)) continue;
  for (const l of readFileSync(f, "utf8").split("\n")) {
    if (l === "" || l.startsWith("#")) continue;
    cmds.set(l.slice(l.indexOf(" ") + 1), `${k}/${l.slice(0, l.indexOf(" "))}`);
  }
}
for (const d of docs) {
  const s = readFileSync(d, "utf8");
  for (const m of s.matchAll(/```sober\n\/\/ (examples\/(?:(?:guide|mod)\/[A-Za-z0-9_\/]+(?:\.sober|\/sober\.mod)|[A-Za-z0-9_]+\.sober))(（抜粋）| \(excerpt\))?\n([\s\S]*?)\n```/g)) {
    // examples/ の直下の全文のチャンクは上の節が照合する（ここは抜粋だけ）。examples/mod/ はモジュールの題材（sober.modのチャンクも — 最初のガイドの「モジュールと依存」）
    if (!/^examples\/(guide|mod)\//.test(m[1]) && m[2] === undefined) continue;
    n++;
    if (!existsSync(m[1])) { bad(`${d}: ${m[1]} does not exist`); continue; }
    const src = readFileSync(m[1], "utf8").replace(/\n$/, "");
    if (m[2] === undefined ? src !== m[3] : !`\n${src}\n`.includes(`\n${m[3]}\n`)) bad(`${d}: the code block for ${m[1]} ${m[2] === undefined ? "differs from the file" : "is not an excerpt of the file"}`);
  }
  for (const m of s.matchAll(/```sh\n\$ (sober [^\n]+)\n```(?:\n\n(出力|Output):\n\n```\n([\s\S]*?)\n```)?/g)) {
    const name = cmds.get(m[1]);
    if (name === undefined) { bad(`${d}: \`${m[1]}\` is not in testdata/guide/{testing,modules}.cmds`); continue; }
    n++;
    if (m[2] === undefined) continue;
    const g = `testdata/guide/${name}.out`;
    const out = existsSync(g) ? readFileSync(g, "utf8").replace(/\n$/, "").replace(/\n?\(exit \d+\)$/, "") : "";
    if (out !== m[3]) bad(`${d}: the output block for \`${m[1]}\` differs from ${g}`);
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
        // モジュールの題材（testdata/mod/<題材>/ — 起点ごとのディレクトリ。判定は検査modcheckのゴールデンtestdata/mod/<題材>.expectのcheckの終了コード）
        for (const r of line.matchAll(/`testdata\/mod\/([A-Za-z0-9_]+)\/`/g)) {
          refs++;
          const g = `testdata/mod/${r[1]}.expect`;
          if (!existsSync(g)) { bad(`${d}: ${id}: ${g} does not exist`); continue; }
          const ok = readFileSync(g, "utf8").includes("(check exit 0)");
          if (ok !== want) bad(`${d}: ${id}: testdata/mod/${r[1]}/ is listed as ${want ? "accepted" : "rejected"} but check ${ok ? "accepts" : "rejects"} it`);
        }
      }
      if (/^(決定|Decided):/.test(line)) {
        // リンクの文面ごとに: `language.md N 節・M 節` は language.md の `### N.`、`syntax.md 決定 N・M` は syntax.md 7 節の `N. ` の行
        let k = 0;
        for (const l of line.matchAll(/\[([^\]]+)\]\(([^)]+)\)/g)) {
          if (l[1].startsWith("language.md")) {
            for (const m of l[1].matchAll(/(\d+) ?(?:節|§)/g)) { k++; if (!sections.has(m[1])) bad(`${d}: ${id}: language.md has no section ${m[1]}`); }
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
