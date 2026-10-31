// stagewall.ts — 自己 build の段ごとの wall と CPU（report-1183 段 0 — 783 の計器の常設版）。コンパイラの段の印（SOBER_STAGES=1 の
// `@<名前>` — loader/stage.sober）の到着時刻と全スレッドの schedstat の和を区間ごとに取り、W ごとの中央値の表にする。
//   node scripts/stagewall.ts [-w 1,8,12] [-n 3] [-c <コンパイラ>] [-t <木>] [-o <生データの TSV>]
// 既定: コンパイラ = out/stage2/sober2・木 = src/compiler + src/std の写し（一時ディレクトリ）。W ごとに交互に回す（同じ時間帯の交互計測）。
// 表の列 = 段（前の印 -> この印）・W ごとの wall の中央値（ms）と並列度（CPU / wall）
import { spawn } from "node:child_process";
import { cpSync, mkdtempSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join, dirname, resolve } from "node:path";

const root = resolve(dirname(new URL(import.meta.url).pathname), "..");
const args = process.argv.slice(2);
const opt = (k: string, d: string) => { const i = args.indexOf(k); return i >= 0 ? args[i + 1] : d; };
const Ws = opt("-w", "1,8,12").split(",");
const runs = Number(opt("-n", "3"));
const comp = resolve(opt("-c", join(root, "out/stage2/sober2")));
const work = mkdtempSync(join(tmpdir(), "stagewall-"));
let tree = opt("-t", "");
if (tree === "") {
  tree = join(work, "tree");
  cpSync(join(root, "src/compiler"), tree, { recursive: true });
  cpSync(join(root, "src/std"), join(tree, "std"), { recursive: true });
}
const now = () => Number(process.hrtime.bigint()) / 1e6;

function cpuMs(pid: number): number {
  let s = 0;
  try {
    for (const t of readdirSync(`/proc/${pid}/task`)) {
      try { s += Number(readFileSync(`/proc/${pid}/task/${t}/schedstat`, "utf8").split(" ")[0]); } catch {}
    }
  } catch {}
  return s / 1e6;
}

// 1 回の build の区間の列 [段, wall, cpu]（終わったスレッドの CPU は schedstat から消えるので単調な最大値で追う）
async function one(W: string): Promise<[string, number, number][]> {
  const t0 = now();
  const ch = spawn(comp, ["build", "app", "--emit=elf", "--passes", "-o", join(work, `o-${W}`)], {
    cwd: tree,
    env: { ...process.env, SOBER_HASH_SEED: "0", SOBER_WORKERS: W, SOBER_STAGES: "1", SOBER_BUILD_CACHE: process.env.SOBER_BUILD_CACHE ?? "0" }, // キャッシュ（既定 on）は明示しなければ切の道
    stdio: ["ignore", "ignore", "pipe"],
  });
  const rows: [string, number, number][] = [];
  let prevW = t0, prevC = 0, prev = "exec", maxC = 0, buf = "";
  ch.stderr!.on("data", (d: Buffer) => {
    const t = now();
    maxC = Math.max(maxC, cpuMs(ch.pid!));
    buf += d.toString();
    let i;
    while ((i = buf.indexOf("\n")) >= 0) {
      const line = buf.slice(0, i);
      buf = buf.slice(i + 1);
      if (!line.startsWith("@")) { process.stderr.write(line + "\n"); continue; }
      const name = line.slice(1);
      rows.push([`${prev}->${name}`, t - prevW, maxC - prevC]);
      prevW = t; prevC = maxC; prev = name;
    }
  });
  const code = await new Promise<number>((res) => ch.on("exit", (c) => res(c ?? 1)));
  if (code !== 0) throw new Error(`stagewall: build failed (W${W}, exit ${code})`);
  const t = now();
  rows.push([`${prev}->exit`, t - prevW, NaN]);
  rows.push(["TOTAL", t - t0, maxC]);
  return rows;
}

const raw: string[] = [];
const m = new Map<string, Map<string, { w: number[]; c: number[] }>>();
const order: string[] = [];
for (let r = 0; r < runs; r++) {
  for (const W of Ws) {
    for (const [st, w, c] of await one(W)) {
      raw.push(`${r}\t${W}\t${st}\t${w.toFixed(1)}\t${isNaN(c) ? "?" : c.toFixed(1)}`);
      if (!order.includes(st)) order.push(st);
      if (!m.has(st)) m.set(st, new Map());
      const e = m.get(st)!;
      if (!e.has(W)) e.set(W, { w: [], c: [] });
      e.get(W)!.w.push(w);
      if (!isNaN(c)) e.get(W)!.c.push(c);
    }
  }
}
const out = opt("-o", "");
if (out !== "") writeFileSync(out, raw.join("\n") + "\n");
const med = (a: number[]) => { const s = [...a].sort((x, y) => x - y); return s[Math.floor(s.length / 2)]; };
console.log(["stage", ...Ws.flatMap((W) => [`w${W}`, `par${W}`])].join("\t"));
for (const k of order) {
  const e = m.get(k)!;
  console.log([k, ...Ws.flatMap((W) => {
    const x = e.get(W);
    if (!x) return ["-", "-"];
    const w = med(x.w);
    const c = x.c.length ? med(x.c) : NaN;
    return [w.toFixed(0), isNaN(c) || w < 5 ? "" : (c / w).toFixed(1)];
  })].join("\t"));
}
rmSync(work, { recursive: true, force: true });
