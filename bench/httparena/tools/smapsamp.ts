// smapsamp.ts <pid> <out> [ms] — /proc/<pid>/smaps を ms ごとに読み、スロットの帯（512 MiB 以上の匿名の写像）の Rss の和と写像の数を
// CLOCK_MONOTONIC（ns — rt の数え口の時刻と同じ時計）つきで 1 行ずつ（report-1016）
import { readFileSync, appendFileSync } from "node:fs";
const [pid, out, msS] = process.argv.slice(2); const ms = +(msS ?? 250);
const tick = () => {
  let txt: string; try { txt = readFileSync(`/proc/${pid}/smaps`, "utf8"); } catch { process.exit(0); }
  const t = process.hrtime.bigint();
  let rss = 0, n = 0, big = false, total = 0;
  for (const l of txt.split("\n")) {
    const m = /^([0-9a-f]+)-([0-9a-f]+) \S+ \S+ \S+ (\d+)\s*(.*)$/.exec(l);
    if (m) { const sz = Number(BigInt("0x" + m[2]) - BigInt("0x" + m[1])); big = sz >= 512 * 1048576 && m[4] === ""; if (big) n++; continue; }
    const r = /^Rss:\s+(\d+) kB/.exec(l); if (r) { total += +r[1]; if (big) rss += +r[1]; }
  }
  appendFileSync(out, `${t} ${rss} ${n} ${total}\n`);
};
setInterval(tick, ms); tick();
