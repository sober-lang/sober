// termlint: 新しく書く文言（コミットメッセージ・コミットで足された行）の用語と表記を検査する。
//   node --experimental-strip-types scripts/termlint.ts --msg <file>
//   node --experimental-strip-types scripts/termlint.ts --range <A>..<B>
// 元 = scripts/termlint.txt（禁止する語の一覧）+ 日本語と英数字の境界のスペースの判定
// （.pair/tools/term/despace.tsの規則を写した。.pairはgitの管理外なのでimportせずに必要な部分をここに置く）。
// 除外: コードブロックの中・インラインコードの中・docs/terms.md自身・scripts/termlint.txt自身・
// ゴールデンや生成物（testdata/・docs/std/・docs/cli/・bench/data/）・ブートストラップのステージのスナップショット（bootstrap/）。
// 出力: ファイル:行\t当たった語\t直す先 を1行ずつ。1件でもあれば終了コード1。
import { readFileSync } from "node:fs";
import { execFileSync } from "node:child_process";

const ROOT = new URL("..", import.meta.url).pathname.replace(/\/$/, "");
const RULES_PATH = `${ROOT}/scripts/termlint.txt`;

// --- 禁止語の一覧（scripts/termlint.txt） ---------------------------------

type Rule = { re: RegExp; to: string; raw: string };

function loadRules(path: string): Rule[] {
  const text = readFileSync(path, "utf8");
  const rules: Rule[] = [];
  for (const line of text.split("\n")) {
    const t = line.trim();
    if (!t || t.startsWith("#")) continue;
    const tab = t.indexOf("\t");
    if (tab < 0) continue;
    const pat = t.slice(0, tab);
    const to = t.slice(tab + 1).trim();
    rules.push({ re: new RegExp(pat, "gu"), to, raw: pat });
  }
  return rules;
}

// --- インラインコード・フェンスの保護（.pair/tools/term/termscan.tsのcodeSpansを写した） ---

function inlineCodeSpans(text: string): [number, number][] {
  const spans: [number, number][] = [];
  let i = 0;
  while (i < text.length) {
    if (text[i] !== "`") { i++; continue; }
    let n = 0;
    while (text[i + n] === "`") n++;
    const fence = "`".repeat(n);
    const end = text.indexOf(fence, i + n);
    if (end < 0) break;
    spans.push([i, end + n]);
    i = end + n;
  }
  return spans;
}

function inSpan(col: number, spans: [number, number][]): boolean {
  return spans.some(([a, b]) => col >= a && col < b);
}

// --- 日本語と英数字の境界のスペース（.pair/tools/term/despace.tsのreA/reB/PROTを写した） ---

const JP = "[\\u3000-\\u303F\\u3040-\\u30FF\\u3400-\\u4DBF\\u4E00-\\u9FFF\\uF900-\\uFAFF\\uFF00-\\uFFEF]";
const ALNUM = "[A-Za-z0-9]";
const spaceReA = new RegExp(`(${JP}) (?=${ALNUM})`, "gu");
const spaceReB = new RegExp(`(${ALNUM}|%) (?=${JP})`, "gu");
// 保護する範囲: インラインコード・URL・リンク先・HTMLタグ（despace.tsのPROTと同じ）
const PROT = /(`+)(?:(?!\1)[^])*?\1|https?:\/\/[^\s)）」』\]]+|\]\([^)\n]*\)|<[A-Za-z\/!][^>\n]*>/g;
const PREFIX = /^(\s*(?:#{1,6} |(?:[-*+] |\d+[.)] |> )(?:\[[ xX]\] )?)*)/;

type SpaceHit = { col: number; text: string };

function spacingHits(line: string): SpaceHit[] {
  const prefixMatch = line.match(PREFIX)!;
  let prefix = prefixMatch[0];
  const num = line.slice(prefix.length).match(/^\d+(?:\.\d+)+ /);
  if (num) prefix += num[0];
  const body = line.slice(prefix.length);
  const hits: SpaceHit[] = [];
  let last = 0;
  const segs: { text: string; start: number; protected: boolean }[] = [];
  for (const m of body.matchAll(PROT)) {
    segs.push({ text: body.slice(last, m.index!), start: last, protected: false });
    segs.push({ text: m[0], start: m.index!, protected: true });
    last = m.index! + m[0].length;
  }
  segs.push({ text: body.slice(last), start: last, protected: false });
  for (const seg of segs) {
    if (seg.protected) continue;
    for (const re of [spaceReA, spaceReB]) {
      for (const m of seg.text.matchAll(re)) {
        const at = prefix.length + seg.start + m.index!;
        hits.push({ col: at + 1, text: line.slice(Math.max(0, at - 12), at + 14) });
      }
    }
  }
  return hits;
}

// --- 本文の検査 -------------------------------------------------------------

type Hit = { line: number; term: string; to: string };

// コードフェンス（``` / ~~~）とインラインコードを飛ばしながら、禁止語と表記ルールを当てる。
// gitのdiffの足された行（文脈行を含まない）にも、コミットメッセージ本文にも同じ関数を使う。
function scanLines(lines: string[], rules: Rule[], opts: { checkSpacing: boolean }): Hit[] {
  const hits: Hit[] = [];
  let fence: string | null = null;
  lines.forEach((text, idx) => {
    const fm = /^\s*(```+|~~~+)/.exec(text);
    if (fm) {
      if (fence === null) fence = fm[1][0];
      else if (fm[1][0] === fence) fence = null;
      return;
    }
    if (fence !== null) return;
    const spans = inlineCodeSpans(text);
    for (const rule of rules) {
      rule.re.lastIndex = 0;
      for (const m of text.matchAll(rule.re)) {
        if (inSpan(m.index!, spans)) continue;
        hits.push({ line: idx + 1, term: m[0], to: rule.to });
      }
    }
    if (opts.checkSpacing) {
      for (const sh of spacingHits(text)) {
        if (inSpan(sh.col - 1, spans)) continue;
        hits.push({ line: idx + 1, term: `(スペース) ${sh.text}`, to: "日本語と半角英数字の境界にスペースを入れない" });
      }
    }
  });
  return hits;
}

// --- マージ・revert・fixup! のコミットメッセージは検査しない ---------------

function isAutoMessage(msg: string): boolean {
  const first = msg.split("\n")[0] ?? "";
  return /^Merge /.test(first) || /^Revert "/.test(first) || /^fixup! /.test(first) || /^squash! /.test(first);
}

// --- ファイルパスの除外（ゴールデン・生成物・このツール自身） --------------

const EXCLUDE_PATH = /^(testdata\/|docs\/std\/|docs\/cli\/|bench\/data\/)|^docs\/terms\.md$|^scripts\/termlint\.txt$/;

function report(hits: { file: string; line: number; term: string; to: string }[]): number {
  for (const h of hits) console.log(`${h.file}:${h.line}\t${h.term}\t${h.to}`);
  if (hits.length) {
    console.error(`termlint: ${hits.length} 件`);
    return 1;
  }
  return 0;
}

// --- --msg ------------------------------------------------------------------

function runMsg(path: string): number {
  const rules = loadRules(RULES_PATH);
  const msg = readFileSync(path, "utf8");
  if (isAutoMessage(msg)) return 0;
  const hits = scanLines(msg.split("\n"), rules, { checkSpacing: true });
  return report(hits.map((h) => ({ file: path, line: h.line, term: h.term, to: h.to })));
}

// --- --range ------------------------------------------------------------------

const DIFF_PATHSPECS = [
  "*.md",
  "*.sober",
  "scripts/**",
  ":!testdata/**",
  ":!docs/std/**",
  ":!docs/cli/**",
  ":!bench/data/**",
  ":!docs/terms.md",
  ":!scripts/termlint.txt",
  // ブートストラップのステージのスナップショットは、過去のソースの複製なので書き換えない
  ":!bootstrap/**",
];

function git(args: string[]): string {
  return execFileSync("git", ["--no-optional-locks", ...args], { cwd: ROOT, encoding: "utf8", maxBuffer: 1 << 28 });
}

// 1コミットの差分の「足された行」だけを、ファイルごとに分けて返す（--unified=0で文脈行を除く）。
function addedLinesByFile(commit: string): Map<string, string[]> {
  const out = git(["show", "--format=", "--unified=0", commit, "--", ...DIFF_PATHSPECS]);
  const byFile = new Map<string, string[]>();
  let cur: string | null = null;
  for (const line of out.split("\n")) {
    const m = /^\+\+\+ b\/(.*)$/.exec(line);
    if (m) { cur = m[1]; continue; }
    if (/^diff --git /.test(line)) { cur = null; continue; }
    if (cur === null) continue;
    if (EXCLUDE_PATH.test(cur)) continue;
    if (line.startsWith("+++") || line.startsWith("---")) continue;
    if (line.startsWith("+")) {
      byFile.set(cur, [...(byFile.get(cur) ?? []), line.slice(1)]);
    }
  }
  return byFile;
}

function runRange(range: string): number {
  const rules = loadRules(RULES_PATH);
  const commits = git(["log", "--format=%H", range]).split("\n").filter((l) => l.trim());
  const hits: { file: string; line: number; term: string; to: string }[] = [];
  for (const commit of commits) {
    const msg = git(["log", "-1", "--format=%B", commit]);
    if (isAutoMessage(msg)) continue;
    const short = commit.slice(0, 9);
    for (const h of scanLines(msg.split("\n"), rules, { checkSpacing: true })) {
      hits.push({ file: `${short} (commit-msg)`, line: h.line, term: h.term, to: h.to });
    }
    const byFile = addedLinesByFile(commit);
    for (const [file, lines] of byFile) {
      // 足された行だけの列なので行番号はdiff内の通し番号（元のファイルの行番号ではない）。
      for (const h of scanLines(lines, rules, { checkSpacing: true })) {
        hits.push({ file: `${short}:${file}`, line: h.line, term: h.term, to: h.to });
      }
    }
  }
  return report(hits);
}

// --- エントリポイント ---------------------------------------------------------

const args = process.argv.slice(2);
if (args[0] === "--msg" && args[1]) {
  process.exit(runMsg(args[1]));
} else if (args[0] === "--range" && args[1]) {
  process.exit(runRange(args[1]));
} else {
  console.error("usage: termlint.ts --msg <file> | --range <A>..<B>");
  process.exit(2);
}
