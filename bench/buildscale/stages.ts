// Soberのbuildの段ごとの時刻とメモリを取る。SOBER_STAGES=1 で出る `@名前` の行を受けた時点で、
// /proc/<pid>/status の VmRSS（今の常駐）と VmHWM（それまでの最大）を読む。
// 使い方: node bench/buildscale/stages.ts --dir <gen.tsの出力> [--cores N] [--sober <sober2>] [--region-mb N] [--scene cold|leaf|root]
// 出力（標準出力・TSV）: 段の名前・開始からの秒・VmRSS MB・VmHWM MB。最後の行に終了コード
// cold = 置き場を空にしてから。leaf / root = 温めた置き場で、run.tsと同じ1行の変更をしてから（測った後に戻す）
// SOBER_PAR_STATS=1 も付ける（分割のパスの証人 #… の行を標準エラーへ）
import { spawn, spawnSync } from "node:child_process";
import { readFileSync, readdirSync, rmSync, writeFileSync } from "node:fs";
import { join, resolve } from "node:path";

const args = new Map<string, string>();
for (let i = 2; i < process.argv.length; i += 2) args.set(process.argv[i].replace(/^--/, ""), process.argv[i + 1]);
const DIR = resolve(args.get("dir") ?? "");
const SOBER = resolve(args.get("sober") ?? "out/stage2/sober2");
const SCENE = args.get("scene") ?? "cold";
const cache = join(DIR, ".work", "stages-cache");
rmSync(cache, { recursive: true, force: true });
const env: Record<string, string> = { ...(process.env as Record<string, string>), SOBER_STAGES: "1", SOBER_CACHE: cache, XDG_CACHE_HOME: join(DIR, ".work", "stages-xdg") };
if (args.has("cores")) env.SOBER_WORKERS = args.get("cores")!;
if (args.has("region-mb")) env.SOBER_REGION_MB = args.get("region-mb")!;
const argv = ["build", "app/main.sober", "--emit=elf", "--passes", "-o", "app.bin"];
let restore = () => {};
if (SCENE !== "cold") {
  // 温める（測らない）→ leaf = 番号が最大のmodule・root = m000 の最初の定数を+1
  spawnSync(SOBER, argv, { cwd: join(DIR, "sober"), env: { ...env, SOBER_STAGES: "0" } });
  const nm = JSON.parse(readFileSync(join(DIR, "stats.json"), "utf8")).modules;
  const md = join(DIR, "sober", `m${String(SCENE === "leaf" ? nm - 1 : 0).padStart(3, "0")}`);
  for (const f of readdirSync(md).filter((f) => /^f\d+\.sober$/.test(f)).sort()) {
    const p = join(md, f);
    const src = readFileSync(p, "utf8");
    const m = src.match(/31 \+ n \+ (\d+)\)/);
    if (!m) continue;
    writeFileSync(p, src.replace(m[0], `31 + n + ${Number(m[1]) + 1})`));
    restore = () => writeFileSync(p, src);
    break;
  }
}
env.SOBER_PAR_STATS = "1";

const mb = (s: string, key: string) => {
  const m = s.match(new RegExp(`${key}:\\s+(\\d+) kB`));
  return m ? (Number(m[1]) / 1024).toFixed(0) : "?";
};
const t0 = process.hrtime.bigint();
const p = spawn(SOBER, argv, { cwd: join(DIR, "sober"), env, stdio: ["ignore", "ignore", "pipe"] });
console.log("stage\tsec\trss_mb\thwm_mb");
let buf = "";
p.stderr.on("data", (d: Buffer) => {
  buf += d.toString();
  let i: number;
  while ((i = buf.indexOf("\n")) >= 0) {
    const line = buf.slice(0, i);
    buf = buf.slice(i + 1);
    if (!line.startsWith("@")) {
      process.stderr.write(line + "\n");
      continue;
    }
    let st = "";
    try { st = readFileSync(`/proc/${p.pid}/status`, "utf8"); } catch { /* 終わった後 */ }
    const sec = (Number(process.hrtime.bigint() - t0) / 1e9).toFixed(3);
    console.log(`${line.slice(1)}\t${sec}\t${mb(st, "VmRSS")}\t${mb(st, "VmHWM")}`);
  }
});
p.on("exit", (code) => {
  restore();
  console.log(`exit\t${(Number(process.hrtime.bigint() - t0) / 1e9).toFixed(3)}\t${code}\t`);
});
