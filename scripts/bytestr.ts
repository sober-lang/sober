// bytestr: 2 本のコア AST JSON（corejson の黄金）の差が「imm slice の要素型 int → byte の置き換えだけ」かを照合する
// （黄金の例外 4 件目 — byte の段 S4: string = imm []byte。草案 §4 の機械照合 ②）。
//
//   node scripts/bytestr.ts OLD NEW     exit 0 = 一致（置き換えた箇所の数を stdout に 1 行）、1 = 不一致（最初の食い違いの場所を stderr に 1 行）
//
// 照合: 2 つの JSON の木を同時に歩き、構造（キーの並び・配列の長さ・葉の値）が同じことを見る。許す食い違いは 1 種類だけ —
// OLD が {"k":"int"}・NEW が {"k":"byte"} で、その親が slice の型（{"k":"slice", "t": …}）か mkslice（{"k":"mkslice", "t": …}）の "t" の位置。
// string の型（slice false r int → byte）・std の sys* 組み込みの戻り（mkslice int → byte）・bytes(s) のビューがこの形。
// もう 1 種類: NEW だけにある変換の包み {"k":"toint","e":X} / {"k":"tobyte","e":X}（中の X は OLD の同じ位置と照合を続ける）— std/ と例の追従の書き換え
// （`int(b[i])` / `byte(…)` — 互換破壊の追従で足したもの）がこの形で出る。
// どの置き換えが string 由来かまでは見ない（[]int のまま残るべき slice が byte に化けていないかは obs の実行一致 ① と Lean の型付けが担保する）
import { readFileSync } from "node:fs";

const [oldPath, newPath] = process.argv.slice(2);
const a = JSON.parse(readFileSync(oldPath, "utf8"));
const b = JSON.parse(readFileSync(newPath, "utf8"));
let swaps = 0;
let wraps = 0;

function fail(path: string, why: string): never {
  process.stderr.write(`bytestr: ${oldPath}: ${path}: ${why}\n`);
  process.exit(1);
}

function isKind(x: unknown, k: string): boolean {
  return typeof x === "object" && x !== null && !Array.isArray(x) && (x as Record<string, unknown>).k === k && Object.keys(x as object).length === 1;
}

function isKindOf(x: unknown, k: string): boolean {
  return typeof x === "object" && x !== null && !Array.isArray(x) && (x as Record<string, unknown>).k === k;
}

function walk(x: unknown, y: unknown, path: string, parentKind: string | null, key: string | null): void {
  if (key === "t" && (parentKind === "slice" || parentKind === "mkslice") && isKind(x, "int") && isKind(y, "byte")) {
    swaps += 1;
    return;
  }
  if (typeof y === "object" && y !== null && !Array.isArray(y)) {
    const yo = y as Record<string, unknown>;
    if ((yo.k === "toint" || yo.k === "tobyte") && Object.keys(yo).length === 2 && "e" in yo && !isKindOf(x, yo.k as string)) {
      wraps += 1;
      walk(x, yo.e, `${path}<${yo.k}>`, parentKind, key);
      return;
    }
  }
  if (typeof x !== typeof y || Array.isArray(x) !== Array.isArray(y) || (x === null) !== (y === null)) fail(path, "shape differs");
  if (Array.isArray(x)) {
    const ys = y as unknown[];
    if (x.length !== ys.length) fail(path, `array length ${x.length} ≠ ${ys.length}`);
    x.forEach((v, i) => walk(v, ys[i], `${path}[${i}]`, null, null));
    return;
  }
  if (typeof x === "object" && x !== null) {
    const xo = x as Record<string, unknown>, yo = y as Record<string, unknown>;
    const xk = Object.keys(xo), yk = Object.keys(yo);
    if (xk.join(",") !== yk.join(",")) fail(path, `keys ${xk.join(",")} ≠ ${yk.join(",")}`);
    const kind = typeof xo.k === "string" ? (xo.k as string) : null;
    for (const k of xk) walk(xo[k], yo[k], `${path}.${k}`, kind, k);
    return;
  }
  if (x !== y) fail(path, `${JSON.stringify(x)} ≠ ${JSON.stringify(y)}`);
}

walk(a, b, "$", null, null);
console.log(`bytestr: ok (${swaps} slice element types int → byte, ${wraps} int(…) / byte(…) wraps)`);
