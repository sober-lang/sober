// alpha16 — 起点の木（boot_src）の局所名 `keys` を α 改名する（決定 16 = 組み込みの名前の再束縛不可の導入のため。意味は不変）。
// 起点のコミットは keysm の段（2026-09-28 — `keys` が組み込みになった）より前で、当時合法だった局所名 `keys` を使っている。
// 今の Sober は決定 16 でそれを拒否し、凍結 Zig は受理するので、Zig ≡ Sober の照合は gates が展開した木にこの改名を掛けてから両方に渡す
// （両者に同じ入力 — 照合の意味は変えない。決定 2026-09-30）。
// 規則（機械的）: 文字列リテラルとコメントの外の識別子 `keys` のうち、直後が `(` でないもの（= 組み込みの呼び出しでないもの）を `keys_a16` にする。
// 改名先が木に既に現れていれば止まる（捕獲の回避）。
// 使い方: node --experimental-strip-types scripts/alpha16.ts <dir>   — dir 以下の *.sober をその場で書き換え、変えたファイルの数を出す
import { readdirSync, readFileSync, statSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const FROM = "keys";
const TO = "keys_a16";

const files = (d: string): string[] =>
  readdirSync(d).flatMap((n) => {
    const p = join(d, n);
    return statSync(p).isDirectory() ? files(p) : n.endsWith(".sober") ? [p] : [];
  });

const isId = (c: string) => /[A-Za-z0-9_]/.test(c);

const rename = (src: string): string => {
  let out = "";
  let i = 0;
  while (i < src.length) {
    const c = src[i];
    if (c === "/" && src[i + 1] === "/") {
      const j = src.indexOf("\n", i);
      const e = j < 0 ? src.length : j;
      out += src.slice(i, e);
      i = e;
    } else if (c === '"') {
      let j = i + 1;
      while (j < src.length && src[j] !== '"') j += src[j] === "\\" ? 2 : 1;
      out += src.slice(i, j + 1);
      i = j + 1;
    } else if (isId(c)) {
      let j = i;
      while (j < src.length && isId(src[j])) j++;
      const w = src.slice(i, j);
      let k = j;
      while (src[k] === " ") k++;
      out += w === FROM && src[k] !== "(" ? TO : w;
      i = j;
    } else {
      out += c;
      i++;
    }
  }
  return out;
};

const dir = process.argv[2];
const all = files(dir);
if (all.some((f) => new RegExp(`\\b${TO}\\b`).test(readFileSync(f, "utf8")))) {
  console.error(`alpha16: ${TO} already occurs under ${dir}`);
  process.exit(1);
}
let n = 0;
for (const f of all) {
  const s = readFileSync(f, "utf8");
  const r = rename(s);
  if (r !== s) {
    writeFileSync(f, r);
    n++;
  }
}
console.log(`alpha16: ${n} files renamed under ${dir}`);
