// check ≟ build の差分オラクル（desugar 規律スイープ ③）: fuzz/progen の生成したプログラムを `sober check` と `sober build`（+ 実行）に通し、
// 受理 / 拒否の食い違いを拾う。食い違いは行の単位（1 行の文か、{ … } の塊）を消す縮小で最小化して out/fuzz/ に置く。
//   node --experimental-strip-types scripts/fuzz_cb.ts [--from N] [--count M] [--size S] [--keep] [--both] [--par]（--both = both-reject も縮めて残す・
//   --par = progen に std/par の文を混ぜる〔段 6 P3a — 捕獲の 2 実装の網〕+ 既定と --no-opt の実行の観測〔stdout・終了コード〕を照合して食い違いを opt-diff に）
// 分類: ok = 両方受理 / both-reject = 両方拒否（生成器が型の合わないものを作った — 一致）/ check-only = check だけ受理（build が拒否 — check ⊃ build）/
//       build-only = build だけ受理（check が拒否 — check ⊂ build。F 台帳の主な型）/ run-crash = 両方受理したが実行が 0 / 101 以外で終わった
// 縮小した結果は既知族（F 台帳）の署名で振り分け、ファイル名に族を付ける（`build-only-Ff-s7-z3.sober` / 署名に当たらなければ `-new-`）。
//   node --experimental-strip-types scripts/fuzz_cb.ts --sig <file>...   手元のファイルの振り分けだけを見る（署名の確かめ用）
import { execFileSync, spawnSync } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), '..');
const SOBER = path.join(ROOT, 'bin/sober');
const args = process.argv.slice(2);
const opt = (k: string, d: number) => { const i = args.indexOf(k); return i >= 0 ? Number(args[i + 1]) : d; };
const from = opt('--from', 1), count = opt('--count', 50), size = opt('--size', 4);

// 既知族の署名（縮小後のプログラムの字面 + check の診断）。progen の名前の規約 = 仮引数は v0、局所は v1 以降。字面の当て推量なので、当たった族は
// 「その形を含む」であって「その形だけが原因」ではない（縮小は分類を保つだけ）— 新族の候補は -new- のものだけ手で見る
function families(src: string, check: string): string[] {
  const body = src.split('\n').filter(l => !l.trim().startsWith('//')).join('\n');
  const out: string[] = [];
  // 生成器の誤り: mut 実引数の排他（diag.MutAlias — 1 つの呼び出しの mut 実引数は根を重ねない — progen の varOther）を生成器が破った
  if (check.includes('mut arguments overlap')) out.push('GenMutAlias');
  // F-f: region を持つ値のブロック式（値の位置の `{ … }` — 代入・return・実引数・演算子の右・括弧の中・if / switch の腕の中・if の条件）
  if (/(:=|=|return|if|\(|,|\+|\{|:)\s*\{ /.test(body)) out.push('Ff');
  // F-n: struct 値の switch 式（の欄読み）で desugar CoreFragment
  if (check.includes('CoreFragment') && /switch [^\n]*\{[^\n]*case [^\n]*: [A-Z]\w*\{/.test(body)) out.push('Fn');
  // F-p: string 値の switch 式を bytes(…) に通すと desugar Malformed（束縛を挟んでも同じ）
  if (check.includes('Malformed') && /switch /.test(body) && /bytes\(/.test(body)) out.push('Fp');
  // F-m: switch 式の腕が仮引数 v0 を値に持つ（struct の欄の中も含む）
  if (check.includes('def error') && /switch [^\n]*(case [^;}\n]*|default): [^;}\n]*\bv0\b/.test(body)) out.push('Fm');
  // F-o: 局所へ仮引数 v0 をそのまま（または struct の欄に入れて）代入
  if (check.includes('def error') && /^\s*v[1-9]\d* = ([^\n]*[{,:] )?v0\b(?! \+)/m.test(body)) out.push('Fo');
  return out;
}
if (args[0] === '--sig') {
  for (const f of args.slice(1)) {
    const src = fs.readFileSync(f, 'utf8');
    const check = src.split('\n')[0];
    console.log(`${path.basename(f)}: ${families(src, check).join('+') || 'new'}`);
  }
  process.exit(0);
}
const work = fs.mkdtempSync('/tmp/claude-1000/fuzzcb-');
const progen = path.join(work, 'progen');
execFileSync(SOBER, ['build', path.join(ROOT, 'fuzz/progen/main.sober'), '-o', progen], { stdio: 'inherit' });

type Cls = 'ok' | 'both-reject' | 'check-only' | 'build-only' | 'run-crash' | 'opt-diff';
const usePar = args.includes('--par');
function classify(src: string): { cls: Cls; check: string; build: string } {
  const f = path.join(work, 'p.sober');
  fs.writeFileSync(f, src);
  const c = spawnSync(SOBER, ['check', f], { encoding: 'utf8', timeout: 120000 });
  const checkOk = c.status === 0 && c.stdout.includes('"ok":true');
  const exe = path.join(work, 'p.exe');
  const b = spawnSync(SOBER, ['build', f, '-o', exe], { encoding: 'utf8', timeout: 120000 });
  const buildOk = b.status === 0;
  const check = (c.stdout + c.stderr).trim().split('\n').pop() ?? '';
  const build = (b.stdout + b.stderr).trim().split('\n').pop() ?? '';
  if (checkOk && buildOk) {
    const r = spawnSync(exe, [], { encoding: 'utf8', timeout: 10000 });
    if (r.status !== 0 && r.status !== 101) return { cls: 'run-crash', check, build: `run exit=${r.status}` };
    if (usePar) {
      // 罠（trap）を跨ぐ最適化の網: --no-opt と観測が割れたら opt-diff（depth の穴の同族）
      const exe2 = path.join(work, 'p0.exe');
      const b2 = spawnSync(SOBER, ['build', f, '--no-opt', '-o', exe2], { encoding: 'utf8', timeout: 120000 });
      const r2 = b2.status === 0 ? spawnSync(exe2, [], { encoding: 'utf8', timeout: 10000 }) : null;
      if (!r2 || r2.status !== r.status || r2.stdout !== r.stdout) return { cls: 'opt-diff', check, build: `run exit=${r.status} / no-opt exit=${r2 ? r2.status : 'build failed'}` };
    }
    return { cls: 'ok', check, build: `run exit=${r.status}` };
  }
  return { cls: checkOk ? 'check-only' : buildOk ? 'build-only' : 'both-reject', check, build };
}

// 縮小: 消せる単位 = 1 行の文か { で終わる行から対応する } までの塊（} else { の続きを含む）。消しても分類が変わらなければ残す（不動点まで）
function units(lines: string[]): [number, number][] {
  const out: [number, number][] = [];
  for (let i = 0; i < lines.length; i++) {
    const t = lines[i].trim();
    // 型宣言・return・構造体の欄は消さない（消すと両方が拒否する形か、build が検査しない形〔未定義の型を持つ未使用の関数・return の無い本体〕に
    // 縮んで偽の食い違いになる）
    if (t === '' || t === '}' || t.startsWith('} else') || t.startsWith('package ') || t.startsWith('//') || t.startsWith('type ') ||
        t.startsWith('return ') || /^[a-z]\w* (int|string)$/.test(t)) continue;
    if (t.endsWith('{')) {
      let d = 0, j = i;
      for (; j < lines.length; j++) {
        const u = lines[j].trim();
        if (u.startsWith('}')) d--;
        if (u.endsWith('{')) d++;
        if (d === 0) break;
      }
      out.push([i, j]);
    } else out.push([i, i]);
  }
  return out;
}
// reachable は残った関数 f<N> が全部どこかから呼ばれているか（build は呼ばれない関数を下ろさない — 検査もしない — ので、未使用の関数の中の
// check の拒否は食い違いに見えるだけで意味が無い）
function reachable(lines: string[]): boolean {
  const text = lines.join('\n');
  for (const m of text.matchAll(/^func (f\d+)\(/gm)) {
    const uses = text.split(m[1] + '(').length - 1;
    if (uses < 2) return false;
  }
  // 呼ぶ関数・使う変数が宣言されていること（縮小が宣言ごと消して「未定義の名前」へ崩れる偽の形を作らない — both-reject の縮小で要る）
  for (const m of text.matchAll(/\b(f\d+)\(/g)) if (!text.includes(`func ${m[1]}(`)) return false;
  for (const m of new Set([...text.matchAll(/\b([ve]\d+)\b/g)].map(x => x[1]))) {
    if (!new RegExp(`(\\b${m} :=|\\b${m}, [ve]\\d+ :=|, ${m} :=|\\(${m} )`).test(text)) return false;
  }
  return true;
}
// 式の縮小: 行の中の釣り合った ( … ) / { … } を中身に置き換える（括弧を外す・ブロック式を式にする）。if 式 `if C { A } else { B }` は A か B に
function exprMoves(line: string): string[] {
  const out: string[] = [];
  const pairs: [number, number][] = [];
  const st: number[] = [];
  let q = false;
  for (let i = 0; i < line.length; i++) {
    const c = line[i];
    if (c === '"' && line[i - 1] !== '\\') q = !q;
    if (q) continue;
    if (c === '(' || c === '{') st.push(i);
    if ((c === ')' || c === '}') && st.length) pairs.push([st.pop()!, i]);
  }
  for (const [a, b] of pairs) {
    if (line[a] === '{' && line.trimEnd().endsWith('{') && b === line.length - 1) continue;
    // 呼び出しの括弧・struct リテラル / switch の本体の波括弧は外さない（名前とくっついて別の名前になる・構文が壊れる）
    const prev = line.slice(0, a).trimEnd();
    if (line[a] === '(' && /[\w\]]$/.test(line.slice(0, a))) continue;
    if (line[a] === '{' && (/[\w}]$/.test(prev) && !/(^|[^\w])(if|else)$/.test(prev) || line.slice(a + 1, b).includes('case '))) continue;
    out.push(line.slice(0, a) + line.slice(a + 1, b).trim() + line.slice(b + 1));
  }
  for (const m of line.matchAll(/if [^{}]+ \{ ([^{}]+) \} else \{ ([^{}]+) \}/g)) {
    out.push(line.replace(m[0], m[1]));
    out.push(line.replace(m[0], m[2]));
  }
  return out;
}
// kindOf は check の診断の種類（both-reject の縮小で保つ — 宣言を消して未定義の名前に崩れる等の偽の形へ縮まないように）
function kindOf(check: string): string {
  const m = check.match(/\((\w+)\)/) ?? check.match(/"msg":"([^"]+)"/);
  if (m) return m[1];
  const l = check.match(/load error(?: at [^:]+:\d+:\d+)?: (.*)$/);
  return l ? l[1] : check;
}
function same(r: { cls: Cls; check: string }, cls: Cls, kind: string): boolean {
  return r.cls === cls && (cls !== 'both-reject' || kindOf(r.check) === kind);
}
function shrink(src: string, cls: Cls, kind = ''): string {
  let lines = src.split('\n');
  let progress = true;
  while (progress) {
    progress = false;
    const us = units(lines).sort((a, b) => (b[1] - b[0]) - (a[1] - a[0]));
    for (const [a, b] of us) {
      const cand = [...lines.slice(0, a), ...lines.slice(b + 1)];
      if (!reachable(cand)) continue;
      if (same(classify(cand.join('\n')), cls, kind)) { lines = cand; progress = true; break; }
    }
    if (progress) continue;
    // 行が消せなくなったら式を縮める
    outer: for (let i = 0; i < lines.length; i++) {
      for (const nl of exprMoves(lines[i])) {
        const cand = [...lines.slice(0, i), nl, ...lines.slice(i + 1)];
        // 式の縮小でも到達性を保つ（`println(f0(…))` を `println(1)` に縮めて f0 を未使用にすると、build が f0 を検査しない偽の食い違いになる）
        if (!reachable(cand)) continue;
        if (same(classify(cand.join('\n')), cls, kind)) { lines = cand; progress = true; break outer; }
      }
    }
  }
  return lines.filter((l, i, a) => !(l.trim() === '' && (a[i - 1] ?? '').trim() === '')).join('\n');
}

fs.mkdirSync(path.join(ROOT, 'out/fuzz'), { recursive: true });
const tally: Record<string, number> = {};
for (let seed = from; seed < from + count; seed++) {
  const src = execFileSync(progen, usePar ? [String(seed), String(size), 'par'] : [String(seed), String(size)], { encoding: 'utf8' });
  const r = classify(src);
  tally[r.cls] = (tally[r.cls] ?? 0) + 1;
  // --both: 拡張した文法（掃除枠 C 段 3）は型の合うプログラムを狙うので、both-reject も誤拒否（書けてよい形）の候補として縮めて残す
  if (r.cls === 'ok' || (r.cls === 'both-reject' && !args.includes('--both'))) continue;
  const min = shrink(src, r.cls, kindOf(r.check));
  const fin = classify(min);
  const fam = families(min, fin.check).join('+') || 'new';
  tally[fam] = (tally[fam] ?? 0) + 1;
  const out = path.join(ROOT, 'out/fuzz', `${r.cls}-${fam}-s${seed}-z${size}.sober`);
  fs.writeFileSync(out, `// ${r.cls}: check: ${fin.check} / build: ${fin.build}\n` + min + '\n');
  console.log(`${r.cls} [${fam}] seed=${seed} size=${size} → ${path.relative(ROOT, out)} (${min.split('\n').length} lines)`);
}
console.log('fuzz_cb:', JSON.stringify(tally));
if (!args.includes('--keep')) fs.rmSync(work, { recursive: true, force: true });
