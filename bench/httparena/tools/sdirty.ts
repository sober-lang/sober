// sdirty.ts <pid> [ms=500] — clear_refs 4 → ms 待つ → 書かれた頁（soft-dirty）と常駐の頁を種類ごとに。スロットの帯は 512 MiB ごとの頭 64 頁だけ読む（速い）
// 接続ごとの常駐（report-1053: baseline = task の塊 2 頁 + スロットの頭 4 個 × 1 頁）と、それが毎要求書かれているかを見る。スロットの帯を丸ごと読むと 13 秒かかり負荷が終わるので頭だけ。node --experimental-strip-types で
import { readFileSync, writeFileSync, openSync, readSync } from "node:fs";
const pid = process.argv[2]; const ms = +(process.argv[3] ?? 500);
const maps = readFileSync(`/proc/${pid}/maps`, "utf8").split("\n").map(l => /^([0-9a-f]+)-([0-9a-f]+) (\S+) \S+ \S+ (\d+)\s*(.*)$/.exec(l)).filter(Boolean).map(m => ({ a: BigInt("0x" + m![1]), b: BigInt("0x" + m![2]), perm: m![3], nm: m![5] }));
writeFileSync(`/proc/${pid}/clear_refs`, "4");
const t0 = Date.now(); while (Date.now() - t0 < ms) {}
const fd = openSync(`/proc/${pid}/pagemap`, "r");
const by = new Map<string, number[]>(); const hist = new Map<number, number>(); const tbHist = new Map<number, number>();
const rd = (pg: bigint, n: number) => { const buf = Buffer.alloc(n * 8); readSync(fd, buf, 0, n * 8, Number(pg * 8n)); let p = 0, d = 0; for (let i = 0; i < n; i++) { if (buf[i * 8 + 7] & 0x80) { p++; if (buf[i * 8 + 6] & 0x80) d++; } } return [p, d]; };
const add = (k: string, p: number, d: number, units = 0) => { const c = by.get(k) ?? [0, 0, 0]; c[0] += p; c[1] += d; c[2] += units; by.set(k, c); };
const t1 = Date.now();
for (const v of maps) {
  const sz = v.b - v.a, pa = v.a >> 12n;
  if (v.nm.startsWith("/") || v.nm.startsWith("[v")) continue;
  if (v.perm === "---p") continue;
  if (sz >= 1n << 40n) { for (let o = 0n; o < sz; o += 4096n << 20n) { const [p, d] = rd(pa + (o >> 12n), 64); add("main-arena(heads)", p, d); } continue; }
  if (sz >= 512n << 20n) { for (let o = 0n; o < sz; o += 512n << 20n) { const [p, d] = rd(pa + (o >> 12n), 64); add("slot-heads(64p/512M)", p, d, p > 0 ? 1 : 0); if (d > 0) hist.set(d, (hist.get(d) ?? 0) + 1); } continue; }
  if (sz === 1073152n || sz === 1069056n) { const n = Number(sz >> 12n); const [p, d] = rd(pa, n); add("taskblock", p, d, 1); tbHist.set(d, (tbHist.get(d) ?? 0) + 1); continue; }
  const [p, d] = rd(pa, Number(sz >> 12n)); add(v.nm || "anon-other", p, d);
}
for (const [k, [p, d, u]] of [...by].sort((x, y) => y[1][0] - x[1][0])) console.log(`${String(p * 4).padStart(8)} kB present ${String(d * 4).padStart(8)} kB written  units=${u}  ${k}`);
console.log("slot heads: written pages → count", [...hist].sort((a, b) => a[0] - b[0]).map(([k, v]) => `${k}:${v}`).join(" "));
console.log("taskblock: written pages → count", [...tbHist].sort((a, b) => a[0] - b[0]).map(([k, v]) => `${k}:${v}`).join(" "));
console.log(`scan ${Date.now() - t1} ms`);
