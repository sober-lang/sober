// コマンドのプロセスの木（子孫すべて）の VmRSS の合計を、20 msごとに標本化して最大を出す。
// GNU timeの %M は子孫のうち最大の1プロセスの値なので、プロセスを並べるビルド（go build・cargo）の合計のメモリを過小に出す。その補い
// 使い方: node bench/buildscale/treerss.ts <コマンド> [引数…]（cwdと環境はそのまま）
// 出力（標準エラーの最後の行）: treerss peak_sum_mb=<MB> peak_procs=<最大の同時プロセス数> wall=<秒> exit=<終了コード>
import { spawn } from "node:child_process";
import { readFileSync, readdirSync } from "node:fs";

const [cmd, ...rest] = process.argv.slice(2);
const t0 = process.hrtime.bigint();
const root = spawn(cmd, rest, { stdio: "inherit" });

function children(): Map<number, number[]> {
  const m = new Map<number, number[]>();
  for (const d of readdirSync("/proc")) {
    if (!/^\d+$/.test(d)) continue;
    try {
      const st = readFileSync(`/proc/${d}/stat`, "utf8");
      const ppid = Number(st.slice(st.lastIndexOf(")") + 2).split(" ")[1]);
      (m.get(ppid) ?? m.set(ppid, []).get(ppid)!).push(Number(d));
    } catch { /* 消えた */ }
  }
  return m;
}
function rssKb(pid: number): number {
  try {
    const m = readFileSync(`/proc/${pid}/status`, "utf8").match(/VmRSS:\s+(\d+) kB/);
    return m ? Number(m[1]) : 0;
  } catch { return 0; }
}
let peak = 0, peakProcs = 0;
const tick = setInterval(() => {
  const ch = children();
  const stack = [root.pid!];
  let sum = 0, n = 0;
  while (stack.length > 0) {
    const p = stack.pop()!;
    sum += rssKb(p); n++;
    stack.push(...(ch.get(p) ?? []));
  }
  if (sum > peak) peak = sum;
  if (n > peakProcs) peakProcs = n;
}, 20);
root.on("exit", (code) => {
  clearInterval(tick);
  const wall = Number(process.hrtime.bigint() - t0) / 1e9;
  console.error(`treerss peak_sum_mb=${(peak / 1024).toFixed(0)} peak_procs=${peakProcs} wall=${wall.toFixed(2)} exit=${code}`);
  process.exit(code ?? 1);
});
