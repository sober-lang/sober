// thp.ts <pid> — THP=always の模擬（report-1053 — 手元の THP は madvise なので、always の箱〔GHA〕の RSS を手元で見積もる）: nh（NOHUGEPAGE）でない匿名の写像について、2 MiB 境界に揃い写像の内に収まる窓で 1 頁でも
// 常駐していれば 2 MiB と数える（pagemap の present bit）。出力 = 今の Rss と模擬の Rss（kB）・写像の大きさごと
import { readFileSync, openSync, readSync } from "node:fs";
const pid = process.argv[2];
const sm = readFileSync(`/proc/${pid}/smaps`, "utf8").split("\n");
type V = { a: bigint; b: bigint; name: string; rss: number; nh: boolean; anon: boolean };
const vs: V[] = []; let cur: V | null = null;
for (const l of sm) {
  const m = /^([0-9a-f]+)-([0-9a-f]+) (\S+) \S+ \S+ (\d+)\s*(.*)$/.exec(l);
  if (m) { cur = { a: BigInt("0x" + m[1]), b: BigInt("0x" + m[2]), name: m[5], rss: 0, nh: false, anon: m[4] === "0" && !m[5].startsWith("/") && !m[5].startsWith("anon_inode") && !m[5].startsWith("[v") }; vs.push(cur); continue; }
  const r = /^Rss:\s+(\d+) kB/.exec(l); if (r && cur) cur.rss = +r[1];
  const f = /^VmFlags:(.*)$/.exec(l); if (f && cur) cur.nh = / nh\b/.test(f[1]);
}
const fd = openSync(`/proc/${pid}/pagemap`, "r");
const H = 2n * 1048576n, P = 4096n;
let now = 0, sim = 0; const by = new Map<string, [number, number, number]>();
for (const v of vs) {
  now += v.rss;
  let s = v.rss;
  if (v.anon && !v.nh && v.rss > 0 && v.b - v.a >= H) {
    const lo = (v.a + H - 1n) / H * H, hi = v.b / H * H;
    for (let w = lo; w < hi; w += H) {
      const buf = Buffer.alloc(512 * 8); readSync(fd, buf, 0, buf.length, Number(w / P * 8n));
      let n = 0; for (let i = 0; i < 512; i++) if (buf.readBigUInt64LE(i * 8) >> 63n) n++;
      if (n > 0) s += 2048 - n * 4;
    }
  }
  sim += s;
  const k = (v.anon ? (v.nh ? "anon-nh " : "anon ") : "") + (v.name || String((v.b - v.a) / 1024n) + "K");
  const c = by.get(k) ?? [0, 0, 0]; c[0] += v.rss; c[1] += s; c[2]++; by.set(k, c);
}
for (const [k, [r, s, n]] of [...by].sort((x, y) => y[1][1] - x[1][1]).slice(0, 14)) console.log(`${String(r).padStart(8)} → ${String(s).padStart(8)} kB  n=${n}  ${k}`);
console.log(`total now ${now} kB → THP-always sim ${sim} kB`);
