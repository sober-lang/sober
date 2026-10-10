// corevec_cov: 差分テストベクタ（testdata/corevec.jsonl）の被覆ラチェットと生成器の自己検査（corevec v2）。
//
//   node scripts/corevec_cov.ts [corevec.jsonl]     exit 0 = 合格、1 = 不合格（理由を出す）
//
// - 構成子の一覧は機械で取る: lean/FeatherweightSober/Json.lean の exprToJson の腕（`  | .ctor …`）から
//   構成子 → JSON の kind・欄（どの欄が子の式か）を読み、Syntax.lean の Expr の doc に「ソースには現れない / ソース項でない」と
//   書かれた構成子（実行時専用）を外す。同じ kind を持つ構成子（block / blockR、mkslice / mksliceAt、mkmap / mkmapAt）は欄の有無で見分ける
// - 被覆: ソースの構成子ごとに「その構成子を含む accept のベクタ数 ≥ MIN_ACC」「reject のベクタ数 ≥ MIN_REJ」（関数表の本体は数えない）。
//   コアに op を足して Gen を追いつかせないと、ここが鳴る（Gen 総追いつき — 据え置きが黙って積もった再発防止）
// - 自己検査: 出自 g = "typed" のベクタが reject なら生成器のバグとして不合格。g = "mut:*" の accept は等価な変異として数えるだけ
// - 分布表（構成子 × accept / reject、出自 × accept / reject）を毎回出す
import { readFileSync } from "node:fs";

const MIN_ACC = 3;
const MIN_REJ = 3;
// accept 側の被覆から外す構成子（型指向がまだ出さない — Gen 総追いつき段 B で region を持つターゲットを入れたら外す）
const EXEMPT_ACC = new Set(["blockR", "copyTo"]);
// 被覆を丸ごと外す構成子（今は無し — 段 6 P1 の並列の構成子 scope / spawn / join / tryJ / newch は P2aで compiler/checker と Gen が追いついて解除）
const EXEMPT_ALL = new Set<string>([]);

const root = new URL("..", import.meta.url).pathname;
const golden = process.argv[2] ?? `${root}testdata/corevec.jsonl`;

type Case = { ctor: string; kinds: Set<string>; fields: Set<string>; exprFields: Set<string> };

function readCases(): Map<string, Case> {
  const src = readFileSync(`${root}lean/FeatherweightSober/Json.lean`, "utf8");
  const start = src.indexOf("def exprToJson");
  const end = src.indexOf("\ndef ", start + 1);
  const body = src.slice(start, end).split("\n");
  const cases = new Map<string, Case>();
  let cur: Case | null = null;
  for (const line of body) {
    const m = /^  \| \.(\w+)/.exec(line);
    if (m) {
      cur = cases.get(m[1]) ?? { ctor: m[1], kinds: new Set(), fields: new Set(), exprFields: new Set() };
      cases.set(m[1], cur);
    }
    if (!cur) continue;
    for (const k of line.matchAll(/\("k", "([^"]+)"\)/g)) cur.kinds.add(k[1]);
    for (const k of line.matchAll(/=> "([a-z]+)"/g)) cur.kinds.add(k[1]);
    for (const f of line.matchAll(/\("(\w+)", (exprToJson)?/g)) {
      if (f[1] === "k") continue;
      cur.fields.add(f[1]);
      if (f[2]) cur.exprFields.add(f[1]);
    }
  }
  return cases;
}

function runtimeOnly(): Set<string> {
  const src = readFileSync(`${root}lean/FeatherweightSober/Syntax.lean`, "utf8");
  const start = src.indexOf("inductive Expr");
  const end = src.indexOf("deriving", start);
  const out = new Set<string>();
  for (const m of src.slice(start, end).matchAll(/\/--([^]*?)-\/\s*\| (\w+)/g)) {
    if (/ソースには現れない|ソース項でない/.test(m[1])) out.add(m[2]);
  }
  return out;
}

const cases = readCases();
const runtime = runtimeOnly();
const byKind = new Map<string, Case[]>();
for (const c of cases.values()) for (const k of c.kinds) byKind.set(k, [...(byKind.get(k) ?? []), c]);
const source = [...cases.keys()].filter((c) => !runtime.has(c));

function ctorOf(node: Record<string, unknown>): Case | undefined {
  const keys = Object.keys(node).filter((k) => k !== "k");
  const cands = (byKind.get(node.k as string) ?? []).filter((c) => keys.every((k) => c.fields.has(k)));
  cands.sort((a, b) => a.fields.size - b.fields.size);
  return cands[0];
}

let unknown = 0;
function walk(node: unknown, seen: Set<string>) {
  if (!node || typeof node !== "object") return;
  const n = node as Record<string, unknown>;
  const c = ctorOf(n);
  if (!c) { unknown++; return; }
  seen.add(c.ctor);
  for (const f of c.exprFields) walk(n[f], seen);
}

const lines = readFileSync(golden, "utf8").trim().split("\n");
const acc = new Map<string, number>(), rej = new Map<string, number>();
const byG = new Map<string, [number, number]>();
const fails: string[] = [];
lines.forEach((l, i) => {
  const j = JSON.parse(l);
  const ok = j.v.ok === true;
  const g: string = j.g ?? "?";
  const t = byG.get(g) ?? [0, 0];
  t[ok ? 0 : 1]++;
  byG.set(g, t);
  if (g === "typed" && !ok) fails.push(`vector ${i + 1}: 型指向の出自なのに reject（生成器のバグ）`);
  const seen = new Set<string>();
  walk(j.e.e, seen);
  for (const c of seen) (ok ? acc : rej).set(c, ((ok ? acc : rej).get(c) ?? 0) + 1);
});
if (unknown > 0) fails.push(`構成子を見分けられない節が ${unknown} 個（Json.lean の読みが古い）`);

for (const c of source) {
  const a = acc.get(c) ?? 0, r = rej.get(c) ?? 0;
  if (EXEMPT_ALL.has(c)) continue;
  if (a < MIN_ACC && !EXEMPT_ACC.has(c)) fails.push(`${c}: accept ${a} < ${MIN_ACC}`);
  if (r < MIN_REJ) fails.push(`${c}: reject ${r} < ${MIN_REJ}`);
}
for (const c of EXEMPT_ACC) if (!cases.has(c)) fails.push(`EXEMPT_ACC の ${c} が Json.lean に無い`);
for (const c of EXEMPT_ALL) if (!cases.has(c)) fails.push(`EXEMPT_ALL の ${c} が Json.lean に無い`);

const sorted = [...source].sort((a, b) => (acc.get(b) ?? 0) - (acc.get(a) ?? 0));
console.log(`corevec_cov: ${lines.length} vectors, ${source.length} source constructors (runtime-only excluded: ${[...runtime].join(" ")})`);
console.log("  constructor acc/rej: " + sorted.map((c) => `${c} ${acc.get(c) ?? 0}/${rej.get(c) ?? 0}`).join("  "));
console.log("  origin acc/rej: " + [...byG.entries()].sort().map(([g, [a, r]]) => `${g} ${a}/${r}`).join("  "));
if (fails.length > 0) {
  for (const f of fails) console.log(`FAIL: ${f}`);
  process.exit(1);
}
console.log(`OK: every source constructor has accept ≥ ${MIN_ACC} (exempt: ${[...EXEMPT_ACC].join(" ")}) and reject ≥ ${MIN_REJ} (exempt both: ${[...EXEMPT_ALL].join(" ")}); typed vectors all accepted`);
