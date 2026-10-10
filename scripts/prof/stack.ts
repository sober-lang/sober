// stack.ts — atexit の 1 行（または samp の任意の 1 行）を nm で関数名に直し、連続する同じ関数を「N x 名前」に畳む（使い方は atexit.c の冒頭）
// usage: node --experimental-strip-types stack.ts <binary> <stack.txt> [行番号（既定 1）]
import { execSync } from "child_process";
import { readFileSync } from "fs";
const [bin, file, lineS] = process.argv.slice(2);
const syms = execSync(`nm -n ${bin}`, { maxBuffer: 1 << 28 }).toString().split("\n")
  .map(l => l.split(" ")).filter(p => p.length === 3 && /[tT]/.test(p[1]))
  .map(p => ({ a: BigInt("0x" + p[0]), n: p[2] }));
if (syms.length === 0) { console.error(`${bin}: シンボルが無い（sober build の ELF は落としている — out/stage2/sober2 build x --emit=ll --passes -o x.ll && zig cc -O0 … で建てる）`); process.exit(1); }
const find = (x: bigint) => { let lo = 0, hi = syms.length - 1; if (x < syms[0].a) return "?"; while (lo < hi) { const m = (lo + hi + 1) >> 1; if (syms[m].a <= x) lo = m; else hi = m - 1; } return syms[lo].n; };
const line = readFileSync(file, "utf8").trim().split("\n")[Number(lineS ?? 1) - 1];
const fs = line.split(" ").filter(h => h).map(h => find(BigInt("0x" + h)));
let prev = "", c = 0;
for (const f of [...fs, ""]) { if (f === prev) { c++; continue; } if (prev) console.log(`${String(c).padStart(5)}x ${prev}`); prev = f; c = 1; }
