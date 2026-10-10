// 小さいプログラム側の M4 の裁定材料（3'' 第 2 段 C3）: examples の 1 ファイルの entry（一括の check が受理するもの）ごとに
//   whole = 一括の check・cold = 小分け（空の置き場）・editWarm = 小分け（同じ entry で温めた置き場 + main を編集 — 依存は当たり・main は外れ）
// を測り、package 数・利用者のソースの行数と並べて TSV で出す。最後に fuzz 相当（全 entry の main を少しずつ変えて、1 つの置き場で順に流す — 最初の数本で
// std が温まる）の合計を一括と比べる。
// 使い方: node --experimental-strip-types scripts/m4small.ts > out.tsv（cwd = リポジトリルート・stage2 を直に叩く）
import { execFileSync, spawnSync } from "node:child_process";
import { mkdtempSync, readFileSync, writeFileSync, readdirSync, rmSync, appendFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";

const S2 = process.env.STAGE2 ?? "out/stage2/sober2";
const SELF = readFileSync("out/stage2/.key", "utf8").trim();
const W = mkdtempSync(join(tmpdir(), "m4small-"));

function run(args: string[], cache: string): { ms: number; ok: boolean; stderr: string } {
  const t0 = process.hrtime.bigint();
  const r = spawnSync(S2, args, { env: { ...process.env, SOBER_CACHE: cache, SOBER_SELF_KEY: SELF }, encoding: "utf8" });
  const ms = Number(process.hrtime.bigint() - t0) / 1e6;
  return { ms, ok: r.status === 0, stderr: r.stderr ?? "" };
}

const entries = readdirSync("examples").filter((f) => f.endsWith(".sober")).map((f) => `examples/${f}`).sort();
const rows: string[] = ["entry\tpkgs\tlines\twhole_ms\tcold_ms\teditwarm_ms"];
const fuzzList: string[] = [];
for (const e of entries) {
  if (!run(["check", e], "").ok) continue;
  const src = readFileSync(e, "utf8");
  const f = join(W, e.replace(/\//g, "_"));
  writeFileSync(f, src);
  // package 数（trace の行数）
  const tr = run(["check", f, "--split", "--cache-trace"], "");
  const pkgs = tr.stderr.split("\n").filter((l) => l.startsWith("cache: ")).length;
  const lines = src.split("\n").length;
  // 3 回の中央値
  const med = (xs: number[]) => xs.sort((a, b) => a - b)[Math.floor(xs.length / 2)];
  const whole: number[] = [], cold: number[] = [], warm: number[] = [];
  for (let k = 0; k < 3; k++) {
    whole.push(run(["check", f], "").ms);
    const c = join(W, `c-${k}`);
    rmSync(c, { recursive: true, force: true });
    cold.push(run(["check", f, "--split"], c).ms);
    appendFileSync(f, `// edit ${k}\n`);
    warm.push(run(["check", f, "--split"], c).ms);
  }
  rows.push(`${e}\t${pkgs}\t${lines}\t${med(whole).toFixed(0)}\t${med(cold).toFixed(0)}\t${med(warm).toFixed(0)}`);
  fuzzList.push(f);
}
console.log(rows.join("\n"));
// fuzz 相当: main を少し変えた全 entry を 1 つの置き場で順に
const fc = join(W, "fuzz-cache");
let tw = 0, ts = 0;
for (const f of fuzzList) {
  appendFileSync(f, "// fuzz\n");
  tw += run(["check", f], "").ms;
  ts += run(["check", f, "--split"], fc).ms;
}
console.log(`# fuzz-like sequence over ${fuzzList.length} distinct mains: whole ${tw.toFixed(0)} ms, split (one shared cache, cold start) ${ts.toFixed(0)} ms`);
rmSync(W, { recursive: true, force: true });
