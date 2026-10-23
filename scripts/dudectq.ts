// dudect の生の記録（scripts/dudect.sh の DUDECT_RAW — 「<名前> <クラス> <cycles>」の gzip）を分位点ごとに読む（report-1026）。
// 題材ごとに、各分位点のクラス 0 / 1 の cycles・差（1 − 0）・比（1 / 0）と、両クラスを合わせた分位点で区切った帯ごとのクラス別の平均を並べる。差が分位点を通して一定なら「命令の形」（足し算の段差）・
// 比が一定なら「周波数の形」（TSC で測った時間の掛け算のずれ）の読みの材料。
//   node --experimental-strip-types scripts/dudectq.ts <raw.txt.gz> [名前の接頭辞]
import * as fs from "node:fs";
import * as readline from "node:readline";
import * as zlib from "node:zlib";

const QS = [0.05, 0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99];
const [file, prefix = ""] = process.argv.slice(2);
if (!file) {
  console.error("usage: dudectq.ts <raw.txt.gz> [名前の接頭辞]");
  process.exit(2);
}
const data = new Map<string, number[][]>();
const rl = readline.createInterface({ input: fs.createReadStream(file).pipe(zlib.createGunzip()) });
rl.on("line", (line) => {
  const f = line.split(" ");
  if (f.length !== 3 || !f[0].startsWith(prefix)) return;
  if (!data.has(f[0])) data.set(f[0], [[], []]);
  data.get(f[0])![Number(f[1])].push(Number(f[2]));
});
rl.on("close", () => {
  for (const [name, cls] of data) {
    const [a, b] = cls.map((x) => Float64Array.from(x).sort());
    console.log(`${name}: n=${a.length}+${b.length}`);
    console.log("  q        c0        c1      diff     ratio");
    for (const q of QS) {
      const x = at(a, q), y = at(b, q);
      console.log(`  ${q.toFixed(2).padEnd(5)} ${x.toFixed(0).padStart(8)} ${y.toFixed(0).padStart(9)} ${(y - x).toFixed(0).padStart(9)} ${(y / x).toFixed(5).padStart(9)}`);
    }
    // 帯ごとの平均（両クラスを合わせた分位点で区切る — 計時の刻みが粗い箱でも、帯の中の平均の差で小さなずれを読む）
    const all = Float64Array.from([...a, ...b]).sort();
    const cuts = [0, ...QS, 1].map((q) => at(all, q));
    console.log("  band          lo      hi   n0+n1         m0         m1    diff");
    for (let k = 0; k + 1 < cuts.length; k++) {
      const lo = cuts[k], hi = cuts[k + 1];
      const inb = (v: number) => (k === 0 ? v >= lo : v > lo) && v <= hi;
      const x = a.filter(inb), y = b.filter(inb);
      if (x.length === 0 || y.length === 0) continue;
      const m0 = mean(x), m1 = mean(y);
      console.log(`  ${String(k).padEnd(5)} ${lo.toFixed(0).padStart(9)} ${hi.toFixed(0).padStart(7)} ${(x.length + "+" + y.length).padStart(15)} ${m0.toFixed(2).padStart(10)} ${m1.toFixed(2).padStart(10)} ${(m1 - m0).toFixed(2).padStart(7)}`);
    }
  }
});

function mean(x: Float64Array): number {
  let t = 0;
  for (const v of x) t += v;
  return t / Math.max(1, x.length);
}

function at(s: Float64Array, q: number): number {
  return s.length === 0 ? NaN : s[Math.min(s.length - 1, Math.floor(q * (s.length - 1)))];
}
