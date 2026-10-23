// slotts.ts <srv.err> [smaps.txt] — rt のスロットの数え口（--rt-mutant=4 の @rt.mn の延長 16 語 — src/compiler/lower/mn.sober の MK0 の注）の時系列（report-1016）。
// 列: t（最初の写しからの秒）・live（生きている子）・owned（子が持つスロット = pop + take − give）・local（ワーカーの手元のプール）・sres（共有の予備）・
// mapped（写したスロット = 16 × refill − drop）・refill / drop / pop / give（前の行からの増分）・carry（give 1 回の min(used, W_MADV) の平均 KB）・
// inhKB（pop 1 回で受け継いだ常駐 = 先頭 1 MiB の mincore の頁 × 4 KB の平均）・smaps の帯の Rss（MB）と写像の数・Rss / mapped（KB / スロット）
import { readFileSync, existsSync } from "node:fs";
const [errF, smF] = process.argv.slice(2);
const NW = 20; const buf = readFileSync(errF); const MAG = Buffer.from("SOBERSLT");
type R = bigint[]; const recs: R[] = [];
for (let i = buf.indexOf(MAG); i >= 0 && i + 8 * NW <= buf.length; i = buf.indexOf(MAG, i + 8)) {
  const r: R = []; for (let k = 0; k < NW; k++) r.push(buf.readBigInt64LE(i + 8 * k)); recs.push(r);
}
const sm = smF && existsSync(smF) ? readFileSync(smF, "utf8").trim().split("\n").map((l) => l.split(" ").map((x) => BigInt(x))) : [];
const near = (t: bigint) => { let b: bigint[] | null = null; for (const s of sm) if (s[0] <= t + 150000000n && (!b || s[0] > b[0])) b = s; return b; };
const t0 = recs.length ? recs[0][1] : 0n; let p: R | null = null;
console.log("t\tlive\towned\tlocal\tsres\tmapped\td.refill\td.drop\td.pop\td.give\tcarryKB\tusedKB\tinhKB\tslotRssMB\tvmas\tKB/slot");
for (const r of recs) {
  const N = (k: number) => Number(r[k]); const D = (k: number) => (p ? Number(r[k] - p[k]) : Number(r[k]));
  const owned = N(2) + N(13) - N(3), sres = N(11), mapped = 16 * N(4) - N(5), local = mapped - owned - sres;
  const dg = D(3); const s = near(r[1]);
  console.log([((Number(r[1] - t0)) / 1e9).toFixed(2), N(10), owned, local, sres, mapped, D(4), D(5), D(2), dg,
    dg ? (D(8) / dg / 1024).toFixed(1) : "-", dg ? (D(9) / dg / 1024).toFixed(1) : "-", D(17) ? (D(16) * 4 / D(17)).toFixed(1) : "-",
    s ? (Number(s[1]) / 1024).toFixed(0) : "-", s ? Number(s[2]) : "-", s && mapped ? (Number(s[1]) / mapped).toFixed(0) : "-"].join("\t"));
  p = r;
}
