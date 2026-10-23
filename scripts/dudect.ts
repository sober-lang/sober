// dudect の集計（scripts/dudect.sh — report-985）: 標準入力の「dudect <名前> <クラス> <cycles>」を名前ごとに Welch の t で比べる。
// 前処理 = 上位の切り（dudect の cropping — 割り込み・移動の外れ値）: 全体の分位点の閾値 CROPS ごとに閾値以下の値だけで t を計算し、|t| の最大値で判定する。
// 名前が neg_ の題材は負例（漏れと出なければ失敗）・exp_ の題材は対照実験（判定は印字するが失敗にしない — report-1026）
import * as fs from "node:fs";
import * as readline from "node:readline";

const CROPS = [1.0, 0.999, 0.99, 0.95, 0.9, 0.8, 0.7, 0.6, 0.5];
const LIMIT = Number(process.env.DUDECT_T ?? "4.5");
// 記録（bench/data/dudect.tsv の形 — 1 題材 1 行を追記）: DUDECT_TSV = 書く先・DUDECT_ENV = 箱の名（wsl2 / gha-<runner>）・DUDECT_DATE / DUDECT_COMMIT
const TSV = process.env.DUDECT_TSV ?? "";
const HEAD = "# dudect の記録（scripts/dudect.sh — 1 題材 1 行・追記）。max_t = 上位の切りの段ごとの Welch の |t| の最大値・crop = その段（全体の分位点）・verdict = ok / LEAK（閾値 4.5）\nenv\tname\tn0\tn1\tmax_t\tcrop\tmean0\tmean1\tverdict\tdate\tcommit\n";

const data = new Map<string, number[][]>();
const rl = readline.createInterface({ input: process.stdin });
rl.on("line", (line) => {
  const f = line.split(" ");
  if (f[0] !== "dudect" || f.length !== 4) return;
  const [name, cls, t] = [f[1], Number(f[2]), Number(f[3])];
  if (!data.has(name)) data.set(name, [[], []]);
  data.get(name)![cls].push(t);
});
rl.on("close", () => {
  let fail = false;
  for (const [name, [a, b]] of data) {
    const all = [...a, ...b].sort((x, y) => x - y);
    let best = { t: 0, crop: 1.0 };
    for (const p of CROPS) {
      const thr = all[Math.min(all.length - 1, Math.floor(p * (all.length - 1)))];
      const t = welch(a.filter((x) => x <= thr), b.filter((x) => x <= thr));
      if (Math.abs(t) > Math.abs(best.t)) best = { t, crop: p };
    }
    const leak = Math.abs(best.t) > LIMIT;
    // exp_ の題材は対照実験（report-1026）: 判定は印字するが失敗にしない
    const exp = name.startsWith("exp_");
    console.log(`${name}: n=${a.length}+${b.length} max|t|=${Math.abs(best.t).toFixed(2)} (crop ${best.crop}) mean ${mean(a).toFixed(1)} / ${mean(b).toFixed(1)} cycles → ${leak ? "LEAK" : "ok"}${exp ? " (exp — informational)" : ""}`);
    if (TSV !== "") {
      if (!fs.existsSync(TSV)) fs.writeFileSync(TSV, HEAD);
      fs.appendFileSync(TSV, [process.env.DUDECT_ENV ?? "-", name, a.length, b.length, Math.abs(best.t).toFixed(2), best.crop, mean(a).toFixed(1), mean(b).toFixed(1), leak ? "LEAK" : "ok", process.env.DUDECT_DATE ?? "-", process.env.DUDECT_COMMIT ?? "-"].join("\t") + "\n");
    }
    if (exp) continue;
    if (leak && !name.startsWith("neg_")) fail = true;
    if (!leak && name.startsWith("neg_")) fail = true;
  }
  process.exit(fail ? 1 : 0);
});

function mean(x: number[]): number {
  return x.reduce((s, v) => s + v, 0) / Math.max(1, x.length);
}

function welch(a: number[], b: number[]): number {
  if (a.length < 2 || b.length < 2) return 0;
  const ma = mean(a), mb = mean(b);
  const va = a.reduce((s, v) => s + (v - ma) ** 2, 0) / (a.length - 1);
  const vb = b.reduce((s, v) => s + (v - mb) ** 2, 0) / (b.length - 1);
  const d = Math.sqrt(va / a.length + vb / b.length);
  return d === 0 ? 0 : (ma - mb) / d;
}
