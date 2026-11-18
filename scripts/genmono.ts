// genmono の照合: 総称関数の版（<名前>.g.sober）と、型引数を手で代入した単相の版（<名前>.m.sober）の IR（`build --emit=ir`・パスなし）を比べる。
//   node --experimental-strip-types scripts/genmono.ts <g.ir> <m.ir> <m.sober>
// m.sober の `// genmono: <単相の関数> = <総称の単相コピーの名前>` で、単相の版の関数名を総称の版の名前へ置き換えてから比べる。
// - 関数の本体は一字一句同じか、総称の呼び出し（展開する呼び出しも）が実引数と戻り値をスロットへ写す分だけ違う。
//   単相コピーそのものは、中に総称の呼び出しを持たなければ一字一句同じ
//   違う関数は、slot・slotaddr・load・store の行を除いた命令の列（レジスタの番号を除き、副作用の間の純粋な命令は順を問わない）が同じであることを見る
//   （ヘッダのコピーだけが増え、region の命令と呼び出しの列は同じ）
import * as fs from "node:fs";

const [gPath, mPath, mSrc] = process.argv.slice(2);
const pairs = fs.readFileSync(mSrc, "utf8").split("\n")
  .map((l) => l.match(/^\/\/ genmono: (\S+) = (\S+)$/))
  .filter((m): m is RegExpMatchArray => m !== null)
  .map((m) => [`main.${m[1]}`, `main.${m[2]}`] as const);

// 関数名 → 本体の行（`func @名前(` から `}` まで）。名前は引用符を外した形
function funcs(text: string): Map<string, string[]> {
  const out = new Map<string, string[]>();
  let cur: string | null = null;
  let body: string[] = [];
  for (const line of text.split("\n")) {
    const h = line.match(/^func @("([^"]*)"|[^(\s]*)\(/);
    if (h) {
      cur = h[2] ?? h[1];
      body = [line];
      continue;
    }
    if (cur === null) continue;
    body.push(line);
    if (line === "}") {
      out.set(cur, panicIds(body));
      cur = null;
    }
  }
  return out;
}

// panic の札（`%r = const N` の直後の `call @rt.panic(%r)`）の番号は、lower が関数を下ろす順で振るので、総称の版と単相の版で違う。番号を消す
function panicIds(body: string[]): string[] {
  return body.map((l, i) => {
    const c = l.match(/^(\s+(%\d+) = const )\d+$/);
    return c && (body[i + 1] ?? "").trim() === `call @rt.panic(${c[2]})` ? `${c[1]}#` : l;
  });
}

const quote = (n: string) => (/^[A-Za-z0-9_.$]+$/.test(n) ? `@${n}` : `@"${n}"`);
let mText = fs.readFileSync(mPath, "utf8");
for (const [mono, inst] of pairs) {
  mText = mText.split(quote(mono) + "(").join(quote(inst) + "(");
}
const g = funcs(fs.readFileSync(gPath, "utf8"));
const m = funcs(mText);
const insts = new Set(pairs.map((p) => p[1]));
// ヘッダのコピー（slot の宣言・slotaddr・load・store）を除いた命令の列。レジスタの番号は消す。
// 副作用のある命令（呼び出し・region の命令・分岐・ラベル）の間の純粋な命令（const・算術）は、実引数を評価する順が総称の呼び出しと違うので、区間ごとに並べ替えて比べる
const shape = (body: string[]) => {
  const out: string[] = [];
  let seg: string[] = [];
  for (const l0 of body.slice(1)) {
    if (/^\s+(slot |%\d+ = slotaddr |%\d+ = load\.|store )/.test(l0)) continue;
    const l = l0.replace(/%\d+/g, "%");
    if (/^\s+% = (const|add|sub|mul|and|or|xor|shl|shr|ptoi|itop|gep\.\w+) /.test(l)) {
      seg.push(l);
      continue;
    }
    out.push(...seg.sort(), l);
    seg = [];
  }
  return [...out, ...seg.sort()];
};

let fail = 0;
let exact = 0;
let callers = 0;
for (const n of new Set([...g.keys(), ...m.keys()])) {
  const a = g.get(n);
  const b = m.get(n);
  if (!a || !b) {
    console.log(`FAIL ${n}: only in the ${a ? "generic" : "monomorphic"} version`);
    fail++;
    continue;
  }
  if (a.join("\n") === b.join("\n")) {
    exact++;
    continue;
  }
  // 単相コピーの本体は、自分の中に総称の呼び出しを持つとき（再帰など）だけ、ヘッダのコピーの差を許す
  const callsInst = a.slice(1).some((l) => [...insts].some((x) => l.includes(quote(x) + "(")));
  if (insts.has(n) && !callsInst) {
    console.log(`FAIL ${n}: the instance differs from the hand-written monomorphic function`);
    fail++;
    continue;
  }
  if (shape(a).join("\n") === shape(b).join("\n")) {
    callers++;
    continue;
  }
  console.log(`FAIL ${n}: the bodies differ`);
  const sa = shape(a);
  const sb = shape(b);
  const k = sa.findIndex((l, i) => l !== sb[i]);
  console.log(`  first difference outside the header copies: generic "${sa[k]}" / monomorphic "${sb[k]}"`);
  fail++;
}
for (const n of insts) {
  if (!g.has(n)) {
    console.log(`FAIL ${n}: no such instance in the generic version (the genmono header is stale)`);
    fail++;
  }
}
console.log(`${exact} identical, ${callers} differ only in header copies and the order of pure instructions, ${insts.size} instances, fail=${fail}`);
process.exit(fail ? 1 : 0);
