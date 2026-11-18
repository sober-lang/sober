// goldtab: テキストのゴールデン（IRテキスト・LLVMテキスト・コアJSON）の全文を、関数ごとのハッシュの表にする。表はgitに入れ、全文は out/gold/ に置く。
//   node scripts/goldtab.ts tab <種類> <全文のdir> <表のdir> [<ファイル名>…]   全文の各ファイル <k>.<拡張子> から表 <k>.<種類>h を書く（名前を渡せばそれだけ）
//   node scripts/goldtab.ts diff <種類> <旧の全文> <新の全文>     表の行が変わった関数だけ、全文の差分（diff -u）を出す
// 種類 = ir（全文 .ir）・ll（.ll）・core（コアJSON .json）・ast（表層ASTのJSON .json。題材の名前は入れ子のパス）
//
// 表の形（1行 = 名前・ハッシュ・行数・バイト数をタブで区切る）:
//   1行目 = `@@full`: 全文のハッシュ。正規化しない（全文が1バイトでも変われば必ずこの行が変わる。`sha256sum <全文> | cut -c1-16` と同じ値）
//   2行目から = 関数ごとの行（名前の辞書順）と、関数の外の行をまとめた `@globals`。どこが変わったかを読むためのもの
// 関数ごとの行は、通し番号を正規化してからハッシュを取る（番号のずれだけでは行が変わらない）:
//   文字列の定数 `str.N` は中身のハッシュに置き換える
//   合成名（`lambda#N`・`kid#N`・`rt.rec_relocate#N`・`…$json…_N_N`）は「元の名前 + `~` + 本体のハッシュの先頭8桁」に置き換える
//   （本体の中の合成名を伏せてからハッシュを取る。本体が同じ合成の関数は同じ名前になり、行が重複する）
//   panicの点の番号（`rt.panic` の引数の定数 — 点の表 `rt.psites` の添字）は `PSITE` に伏せる（点を1つ足すと後ろの全部の番号がずれる）。
//   点の表の中身の変化は `@globals`（ll）と `@@full` の行に出る
// コアJSONは関数（defs の要素）が名前を持たず、番号（call・fnref の f）で参照し合う。関数の行の名前は「def~ + 本体のハッシュの先頭8桁」
//   （本体の中の f を伏せてハッシュを取る）。行のハッシュは、f を参照先の名前に置き換えた本体から取る。入口の式は `@main`。
//   差分では、名前が片方にしかない関数を番号の順に組にして見せる
// 表層ASTのJSONは宣言ごとに `type 名前`・`func 名前`・`const 名前` の行、ほか（package・imports など）を `@head` の行にする。
//   位置のフィールド（tok・span・sig_end）は行のハッシュから外す（上に1行足すと後ろの全部の位置がずれる）。位置の変化は `@@full` の行に出る
// ハッシュはsha256の先頭64ビット（16桁の16進）。
import { readFileSync, readdirSync, writeFileSync, mkdtempSync, rmSync, mkdirSync } from "node:fs";
import { dirname } from "node:path";
import { createHash } from "node:crypto";
import { spawnSync } from "node:child_process";
import { tmpdir } from "node:os";

type Kind = "ir" | "ll" | "core" | "ast";
type Row = { name: string; norm: string; show: string; lines: number; idx: number };
const EXT: Record<Kind, string> = { ir: "ir", ll: "ll", core: "json", ast: "json" };
type Fn = { name: string; raw: string };
type Parsed = { full: string; fullLines: number; fullBytes: number; globals: string[]; fns: Fn[] };

const h = (s: string | Buffer) => createHash("sha256").update(s).digest("hex").slice(0, 16);
const TOKEN = /@"[^"]*"|@[A-Za-z_$.][\w.$#/]*/g;
const inner = (t: string) => (t.startsWith('@"') ? t.slice(2, -1) : t.slice(1));
const isStr = (n: string) => /^str\.\d+$/.test(n);
const isSyn = (n: string) => /^(lambda|kid|rt\.rec_relocate)#\d+$/.test(n) || /\$json\w*?_\d+(?:_\d+)*$/.test(n);
const stem = (n: string) => n.replace(/#\d+$|_\d+(?:_\d+)*$/, "");
const FN_HEAD: Record<string, RegExp> = {
  ir: /^(?:export )?func (@"[^"]*"|@[^\s(]+)\(/,
  ll: /^define [^@]*(@"[^"]*"|@[^\s(]+)\(/,
};
// 文字列の定数の宣言: ir = `global @str.N <中身>`・ll = `@"str.N" = <中身>`
const STR_DECL: Record<string, RegExp> = {
  ir: /^global (@str\.\d+) (.*)$/,
  ll: /^(@"str\.\d+") = (.*)$/,
};

function parse(kind: Kind, buf: Buffer): Parsed & { strs: Map<string, string> } {
  const text = buf.toString("utf8");
  const lines = text.split("\n");
  if (lines[lines.length - 1] === "") lines.pop();
  const strs = new Map<string, string>();
  const globals: string[] = [];
  const fns: Fn[] = [];
  let cur: { name: string; lines: string[] } | null = null;
  for (const l of lines) {
    if (cur) {
      cur.lines.push(l);
      if (l === "}") { const raw = cur.lines.join("\n") + "\n"; fns.push({ name: cur.name, raw }); cur = null; }
      continue;
    }
    const m = l.match(FN_HEAD[kind]);
    if (m) { cur = { name: m[1], lines: [l] }; continue; }
    const s = l.match(STR_DECL[kind]);
    if (s) { strs.set(inner(s[1]), "str:" + h(s[2])); continue; }
    globals.push(l);
  }
  if (cur) throw new Error(`unterminated function ${cur.name}`);
  return { full: text, fullLines: lines.length, fullBytes: buf.length, globals, fns, strs };
}

// 通し番号を正規化した名前と本体を返す
const PSITE: Record<string, RegExp> = {
  ir: /^(  (%\d+) = const )\d+\n(  call @rt\.panic\(\2\))$/gm,
  ll: /^(  (%v\d+) = add i64 0, )\d+\n(  call void @"rt\.panic"\(i64 \2\))$/gm,
};
const unsite = (kind: Kind, s: string) => s.replace(PSITE[kind], "$1PSITE\n$3");

function normalize(kind: Kind, p: ReturnType<typeof parse>) {
  const strOf = (n: string) => p.strs.get(n) ?? n;
  const masked = (s: string) => unsite(kind, s).replace(TOKEN, (t) => { const n = inner(t); return isStr(n) ? "@" + strOf(n) : isSyn(n) ? "@SYN" : t; });
  const rename = new Map<string, string>();
  for (const f of p.fns) {
    const n = inner(f.name);
    if (isSyn(n)) rename.set(n, stem(n) + "~" + h(masked(f.raw)).slice(0, 8));
  }
  const fix = (s: string) => unsite(kind, s).replace(TOKEN, (t) => { const n = inner(t); return isStr(n) ? "@" + strOf(n) : rename.has(n) ? "@" + rename.get(n)! : t; });
  const fnName = (f: Fn) => { const n = inner(f.name); return rename.get(n) ?? n; };
  return { fix, fnName };
}

function textRows(kind: Kind, buf: Buffer): Row[] {
  const p = parse(kind, buf);
  const { fix, fnName } = normalize(kind, p);
  const rows: Row[] = p.fns.map((f, i) => ({ name: fnName(f), norm: fix(f.raw), show: f.raw, lines: f.raw.split("\n").length - 1, idx: i }));
  const g = p.globals.join("\n") + "\n";
  rows.push({ name: "@globals", norm: fix(g), show: g, lines: p.globals.length, idx: -1 });
  return rows;
}

function coreRows(buf: Buffer): Row[] {
  const j = JSON.parse(buf.toString("utf8"));
  const defs: unknown[] = j.defs ?? [];
  const withF = (o: unknown, f: (n: number) => string) => JSON.stringify(o, (_k, v) =>
    v && typeof v === "object" && !Array.isArray(v) && (v.k === "call" || v.k === "fnref") && typeof v.f === "number" ? { ...v, f: f(v.f) } : v);
  const names = defs.map((d) => "def~" + h(withF(d, () => "F")).slice(0, 8));
  const ref = (n: number) => names[n] ?? `?${n}`;
  const row = (name: string, o: unknown, idx: number): Row => {
    const norm = withF(o, ref);
    return { name, norm, show: JSON.stringify(JSON.parse(norm), null, 1) + "\n", lines: norm.split('"k":').length - 1, idx };
  };
  const rows = defs.map((d, i) => row(names[i], d, i));
  rows.push(row("@main", j.e, -1));
  const rest = Object.fromEntries(Object.entries(j).filter(([k]) => k !== "defs" && k !== "e"));
  if (Object.keys(rest).length) rows.push(row("@globals", rest, -1));
  return rows;
}

function astRows(buf: Buffer): Row[] {
  const j = JSON.parse(buf.toString("utf8"));
  const POS = new Set(["tok", "span", "sig_end"]);
  const row = (name: string, o: unknown, idx: number): Row => {
    const norm = JSON.stringify(o, (k, v) => (POS.has(k) ? undefined : v));
    return { name, norm, show: JSON.stringify(o, null, 1) + "\n", lines: norm.split('"k":').length - 1, idx };
  };
  const rows: Row[] = [];
  const head: Record<string, unknown> = {};
  for (const [k, v] of Object.entries(j)) {
    const tag = ({ types: "type", funcs: "func", consts: "const" } as Record<string, string>)[k];
    if (tag && Array.isArray(v)) v.forEach((d: any, i: number) => rows.push(row(`${tag} ${d?.name ?? "?"}`, d, i)));
    else head[k] = v;
  }
  rows.push(row("@head", head, -1));
  return rows;
}

const rowsOf = (kind: Kind, buf: Buffer) => (kind === "core" ? coreRows(buf) : kind === "ast" ? astRows(buf) : textRows(kind, buf));

function table(kind: Kind, buf: Buffer): string {
  const lines = buf.toString("utf8").split("\n");
  if (lines[lines.length - 1] === "") lines.pop();
  const rows = rowsOf(kind, buf).map((r) => `${r.name}\t${h(r.norm)}\t${r.lines}\t${Buffer.byteLength(r.norm)}`);
  rows.sort((a, b) => (a < b ? -1 : a > b ? 1 : 0));
  return `@@full\t${h(buf)}\t${lines.length}\t${buf.length}\n` + rows.join("\n") + "\n";
}

function diffFiles(kind: Kind, a: Buffer, b: Buffer): number {
  type E = { hash: string; show: string; lines: number; idx: number };
  const side = (buf: Buffer) => {
    const m = new Map<string, E[]>();
    for (const r of rowsOf(kind, buf)) {
      if (!m.has(r.name)) m.set(r.name, []);
      m.get(r.name)!.push({ hash: h(r.norm), show: r.show, lines: r.lines, idx: r.idx });
    }
    for (const v of m.values()) v.sort((x, y) => (x.hash < y.hash ? -1 : 1));
    return m;
  };
  const A = side(a), B = side(b);
  const names = [...new Set([...A.keys(), ...B.keys()])].sort();
  const tmp = mkdtempSync(`${tmpdir()}/goldtab-`);
  let changed = 0;
  const udiff = (na: string, nb: string, x: string, y: string) => {
    writeFileSync(`${tmp}/old`, x);
    writeFileSync(`${tmp}/new`, y);
    const r = spawnSync("diff", ["-u", "--label", `old/${na}`, "--label", `new/${nb}`, `${tmp}/old`, `${tmp}/new`], { encoding: "utf8", maxBuffer: 1 << 30 });
    process.stdout.write(r.stdout);
  };
  const onlyA: [string, E][] = [], onlyB: [string, E][] = [];
  try {
    for (const n of names) {
      const x = A.get(n) ?? [], y = B.get(n) ?? [];
      const xs = new Set(x.map((e) => e.hash)), ys = new Set(y.map((e) => e.hash));
      const gone = x.filter((e) => !ys.has(e.hash)), come = y.filter((e) => !xs.has(e.hash));
      if (gone.length === 0 && come.length === 0) continue;
      changed++;
      if (gone.length === 0 || come.length === 0) {
        // 名前が内容から決まる種類（core）は、片方にしかない行を後で番号の順に組にする
        if (kind === "core") { for (const e of gone) onlyA.push([n, e]); for (const e of come) onlyB.push([n, e]); continue; }
        const what = gone.length === 0 ? "added" : "removed";
        console.log(`== ${n}: ${what} (${(gone.length ? gone : come).map((e) => e.lines).join(", ")} lines)`);
        continue;
      }
      console.log(`== ${n}: changed`);
      for (let i = 0; i < Math.max(gone.length, come.length); i++) udiff(n, n, gone[i]?.show ?? "", come[i]?.show ?? "");
    }
    onlyA.sort((p, q) => p[1].idx - q[1].idx);
    onlyB.sort((p, q) => p[1].idx - q[1].idx);
    for (let i = 0; i < Math.max(onlyA.length, onlyB.length); i++) {
      const p = onlyA[i], q = onlyB[i];
      if (p && q) { console.log(`== ${p[0]} (def ${p[1].idx}) → ${q[0]} (def ${q[1].idx}): changed`); udiff(p[0], q[0], p[1].show, q[1].show); }
      else if (p) console.log(`== ${p[0]} (def ${p[1].idx}): removed (${p[1].lines} nodes)`);
      else console.log(`== ${q[0]} (def ${q[1].idx}): added (${q[1].lines} nodes)`);
    }
  } finally {
    rmSync(tmp, { recursive: true, force: true });
  }
  return changed;
}

const [mode, kind, x, y, ...only] = process.argv.slice(2) as [string, Kind, string, string, ...string[]];
if (!(kind in EXT) || !x || !y) {
  console.error("usage: goldtab.ts tab <ir|ll|core|ast> <全文のdir> <表のdir> [<ファイル名>…] | diff <ir|ll|core|ast> <旧の全文> <新の全文>");
  process.exit(2);
}
if (mode === "tab") {
  let n = 0;
  for (const f of (only.length ? only : readdirSync(x)).filter((f) => f.endsWith("." + EXT[kind])).sort()) {
    const out = `${y}/${f.slice(0, -EXT[kind].length)}${kind}h`;
    mkdirSync(dirname(out), { recursive: true });
    writeFileSync(out, table(kind, readFileSync(`${x}/${f}`)));
    n++;
  }
  console.log(`goldtab: ${n} tables`);
} else if (mode === "diff") {
  const n = diffFiles(kind, readFileSync(x), readFileSync(y));
  console.log(`goldtab: ${n} rows differ`);
} else {
  console.error(`goldtab: unknown mode ${mode}`);
  process.exit(2);
}
