// rsssample: コマンドを走らせ、その RSS（/proc/<pid>/status の VmRSS — スレッドを含むプロセス全体）を定周期で読んで TSV に追記する。
//   node --experimental-strip-types scripts/rsssample.ts <系列名> <出力 TSV> [周期 ms] -- <コマンド> [引数…]
// 行 = 系列名 経過ms RSS(KB)。コマンドの標準出力は <出力 TSV>.<系列名>.out に（出力の照合用）。終了コードをそのまま返す
import { spawn } from "node:child_process";
import { appendFileSync, readFileSync, openSync } from "node:fs";
const a = process.argv.slice(2);
const sep = a.indexOf("--");
const [label, out, per] = a.slice(0, sep);
const cmd = a.slice(sep + 1);
const period = Number(per ?? 5);
const fd = openSync(`${out}.${label}.out`, "w");
const t0 = performance.now();
const child = spawn(cmd[0], cmd.slice(1), { stdio: ["ignore", fd, "inherit"] });
const rows: string[] = [];
const read = () => {
  try {
    const m = /VmRSS:\s+(\d+)/.exec(readFileSync(`/proc/${child.pid}/status`, "utf8"));
    if (m) rows.push(`${label}\t${(performance.now() - t0).toFixed(1)}\t${m[1]}`);
  } catch { /* 終わった後の読みは捨てる */ }
};
const timer = setInterval(read, period);
read();
child.on("exit", (code) => { clearInterval(timer); appendFileSync(out, rows.join("\n") + "\n"); process.exit(code ?? 1); });
