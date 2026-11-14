// letorder: 2本のコアJSON（corejsonのゴールデン）の差が「名前つきリテラルを書いた順のletに束縛した形」だけかを照合する
// （ゴールデンの例外 — compositeの値の評価順を書いた順にした修正。language.md 27 節、2026-09-30の決定 (a)）。
//
//   node scripts/letorder.ts OLD NEW    exit 0 = 一致、1 = 不一致（理由を stderr に 1 行）
//
// 照合: NEWの中の「k個（k ≥ 2）のletのチェーンで、一番内側が組（pairのチェーン — inl / inrで包まれてもよい）の葉がちょうどvar 0 … var k-1の並べ替え」を、
// 葉の var に let の値を戻して（j 番目の値は j 個の let の内側で作られたので、自由な添字を j 下げる）畳み、OLD とバイト一致することを見る。
// 畳むのは OLD と違う箇所だけではなく該当する形すべて（元から該当する形は無い — 旧の脱糖器は名前つきリテラルに let を作らない）
import { readFileSync } from "node:fs";

type J = any;
const [oldPath, newPath] = process.argv.slice(2);

// binderを持つフィールド（LeanのExpr.substと同じ: letのbody・ifnilのsome・caseのl / r・parchのe1 / e2）
const binders: Record<string, string[]> = { let: ["body"], ifnil: ["some"], case: ["l", "r"], parch: ["e1", "e2"] };

// shift は e の自由な添字（cutoff 以上）を d だけずらす（負なら下げる — 下げた先が cutoff 未満になれば畳めない形）
function shift(e: J, d: number, cutoff: number): J {
  if (Array.isArray(e)) return e.map((x) => shift(x, d, cutoff));
  if (e === null || typeof e !== "object") return e;
  if (e.k === "var" && typeof e.i === "number") {
    if (e.i < cutoff) return e;
    if (e.i + d < cutoff) throw new Error("free index escapes the removed lets");
    return { ...e, i: e.i + d };
  }
  const out: J = {};
  const bs = typeof e.k === "string" ? binders[e.k] ?? [] : [];
  for (const [key, v] of Object.entries(e)) out[key] = shift(v, d, bs.includes(key) ? cutoff + 1 : cutoff);
  return out;
}

// leavesは組（pairのチェーン）の葉のvarの添字（組でない・varでない葉があればnull）。inl / inrの包みは剥がす
function leaves(e: J, acc: number[]): boolean {
  if (e?.k === "inl" || e?.k === "inr") return leaves(e.e, acc);
  if (e?.k === "pair") return leaves(e.a, acc) && leaves(e.b, acc);
  if (e?.k === "var") { acc.push(e.i); return true; }
  return false;
}

function fill(e: J, vals: J[]): J {
  if (e?.k === "inl" || e?.k === "inr") return { ...e, e: fill(e.e, vals) };
  if (e?.k === "pair") return { ...e, a: fill(e.a, vals), b: fill(e.b, vals) };
  return vals[e.i];
}

function fold(e: J): J {
  if (Array.isArray(e)) return e.map(fold);
  if (e === null || typeof e !== "object") return e;
  if (e.k === "let") {
    const vs: J[] = [];
    let cur = e;
    while (cur?.k === "let") { vs.push(cur.e); cur = cur.body; }
    const k = vs.length;
    const ls: number[] = [];
    // 書いた順がフィールドの順と同じ（葉がvar k-1 … var 0の順）なら脱糖器はletを作らないので、並べ替えのある形だけを畳む
    if (k >= 2 && leaves(cur, ls) && ls.length === k && [...ls].sort((a, b) => a - b).every((x, i) => x === i) && !ls.every((x, i) => x === k - 1 - i)) {
      // var i は j = k-1-i 番目の let の値。その値は j 個の let の内側 — 自由な添字を j 下げると let の外（組の位置）の添字になる
      const vals: J[] = [];
      for (let i = 0; i < k; i++) { const j = k - 1 - i; vals[i] = shift(fold(vs[j]), -j, 0); }
      return fill(cur, vals);
    }
  }
  const out: J = {};
  for (const [key, v] of Object.entries(e)) out[key] = fold(v);
  return out;
}

const oldJ = JSON.parse(readFileSync(oldPath, "utf8"));
const newJ = JSON.parse(readFileSync(newPath, "utf8"));
if (JSON.stringify(fold(newJ)) !== JSON.stringify(oldJ)) {
  console.error(`letorder: ${newPath}: folding the written-order lets does not give ${oldPath}`);
  process.exit(1);
}
