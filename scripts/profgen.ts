// scripts/profgen.sh の変換: ブロックの番地の表（`sober build --blkmap` の出力）・関数の先頭番地の表（--emit=syms — 番地の照合）・
// 題材ごとのcallgrind（--dump-instr）2本から、熱さのプロファイル（lower/profile.sober の形）を標準出力へ。
//   node scripts/profgen.ts <blkmap> <syms> <しきい値> <cg少>:<cg多>:<要求の差> …
// ブロックの実行の回数 = ブロックの最初の命令の自己の回数（2本の差 ÷ 要求の差 = 1要求あたり）。
// 関数はどれかのブロックがどれかの題材で1要求あたりしきい値以上なら対象。対象の関数で、どの題材でも回数がしきい値未満のブロックを冷たいとする
// （入口のブロックと、長さ0のブロック〔落ちるだけの空のブロック — 最初の命令は次のブロックのもの〕は冷たいにしない）。
// 行は関数の鍵の昇順。同じ鍵の関数が2つ以上あれば、その鍵の行は出さない（コンパイラもその鍵を使わない）
import { readFileSync } from "node:fs";

const [mapP, symsP, thS, ...subs] = process.argv.slice(2);
const TH = Number(thS);

// callgrind の番地ごとの自己の命令数（scripts/reqinst.ts の selfCost と同じ読み方）
function selfCost(path: string): Map<number, number> {
  const self = new Map<number, number>();
  let last = 0, skipNext = false;
  const pos = (t: string): number => {
    if (t === "*") return last;
    const sign = t[0] === "+" ? 1 : t[0] === "-" ? -1 : 0;
    const u = sign === 0 ? t : t.slice(1);
    const v = parseInt(u, u.startsWith("0x") ? 16 : 10);
    return sign === 0 ? v : last + sign * v;
  };
  for (const line of readFileSync(path, "utf8").split("\n")) {
    const c0 = line[0];
    if (c0 === "0" || c0 === "+" || c0 === "-" || c0 === "*") {
      const f = line.split(" ");
      last = pos(f[0]);
      if (skipNext) { skipNext = false; continue; }
      self.set(last, (self.get(last) ?? 0) + Number(f[f.length - 1]));
    } else if (line.startsWith("calls=")) skipNext = true;
  }
  return self;
}

type Fn = { fp1: string; fp2: string; key: string; blks: [number, number][]; end: number; at: number };
const fns = new Map<number, Fn>();
for (const l of readFileSync(mapP, "utf8").split("\n")) {
  const p = l.split(" ");
  if (p[0] === "blkfn") fns.set(+p[1], { fp1: p[2], fp2: p[3], key: p.slice(4).join(" "), blks: [], end: -1, at: -1 });
}
for (const l of readFileSync(mapP, "utf8").split("\n")) {
  const p = l.split(" ");
  const f = fns.get(+p[1]);
  if (!f) continue;
  if (p[0] === "blk") f.blks.push([+p[2], +p[3]]);
  else if (p[0] === "blkend") f.end = +p[2];
  else if (p[0] === "blkat") f.at = +p[2];
}
// 関数の入口の番地は blkat の行（--emit=syms と同じ番地。symsは表示の名前で、kid・lambdaは鍵と違う — 照合だけに使う）
const symAt = new Set(readFileSync(symsP, "utf8").trim().split("\n").map((l) => parseInt(l.split(" ")[0], 16)));
const rates = subs.map((s) => {
  const [a, b, n] = s.split(":");
  const sa = selfCost(a), sb = selfCost(b);
  return (ad: number) => ((sb.get(ad) ?? 0) - (sa.get(ad) ?? 0)) / Number(n);
});

const keyCount = new Map<string, number>();
for (const f of fns.values()) keyCount.set(f.key, (keyCount.get(f.key) ?? 0) + 1);
const out: string[] = [];
let nFn = 0, nCold = 0;
for (const f of fns.values()) {
  if (keyCount.get(f.key) !== 1) continue;
  if (f.at < 0 || !symAt.has(f.at)) continue;
  const base = f.at;
  const byOff = [...f.blks].sort((x, y) => x[1] - y[1]);
  // 対象 = どれかのブロックがどれかの題材でしきい値以上（接続のtaskの本体のように、入口は接続ごとに1回でも中のループが熱い関数を含める）
  const hot = byOff.some(([, off]) => rates.some((r) => r(base + off) >= TH));
  if (!hot) continue;
  const cold: number[] = [];
  for (let k = 0; k < byOff.length; k++) {
    const [id, off] = byOff[k];
    const next = k + 1 < byOff.length ? byOff[k + 1][1] : f.end;
    if (off === 0 || next <= off) continue;
    if (rates.every((r) => r(base + off) < TH)) cold.push(id);
  }
  nFn++;
  nCold += cold.length;
  if (cold.length === 0) continue;
  cold.sort((x, y) => x - y);
  out.push(`f ${f.fp1} ${f.fp2} ${cold.length} ${cold.join(" ")} ${f.key}`);
}
const keyOf = (l: string) => l.split(" ").slice(5 + Number(l.split(" ")[3])).join(" ");
out.sort((x, y) => (keyOf(x) < keyOf(y) ? -1 : keyOf(x) > keyOf(y) ? 1 : 0));
console.log("sober-profile 1");
for (const l of out) console.log(l);
console.error(`profgen: 対象の関数 ${nFn}・行 ${out.length}・冷たいブロック ${nCold}`);
