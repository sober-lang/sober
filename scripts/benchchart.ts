// benchchart: README のグラフ（SVG）を作る。依存なし（自前の SVG の組み立て — 将来の Sober 化の候補）。
// 速度・RSS の 4 枚の正は bench/data/official.tsv（seqperf の行）で、scripts/benchsync.sh が生成と --check（gates）をする（seqChartsFrom をここから読む）。
//   node --experimental-strip-types scripts/benchchart.ts [--seq <seqperf の raw TSV>] [--budget <budget の時系列 TSV>] [-o docs/assets]
//   （--seq は旧来の口 — 公式の図は benchsync.sh で。budget の図は official.tsv に無いデータなので benchsync の網の外）
// 出力（各ライト / ダークの 2 枚 — README は <picture> で出し分ける）:
//   bench-speed-{light,dark}.svg   9 題材の相対の実行時間（cycles:u・Rust素 = 1.0・短いほど速い）— Sober / Go の横棒と 1.0 の基準線
//   bench-rss-{light,dark}.svg     9 題材の最大 RSS（Rust = 1.0 の相対・線形の軸 — 速度のグラフと同じ文法）— Sober / Go の横棒。ラベルは絶対値の MB と比
//                                  （0.4 MB 級の床の小ささは比だけだと消える。対数の絶対値の軸は 3 桁の幅で差が小さく見えたので棄てた — 2026-10-10）
//   bench-budget-{light,dark}.svg  メモリの天井（budget）の時系列 — 天井の線・天井ありの RSS・天井なしの RSS（--budget を渡したとき）
// 集計は bench/seqperf.sh の表と同じ: cycles は回の最小・RSS は回の最大。題材の順は名前の順で固定（回ごとに並びが動かない）
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { fileURLToPath } from "node:url";

type Theme = { name: string; fg: string; sub: string; grid: string; base: string; sober: string; go: string; rust: string; cap: string; nocap: string };
const THEMES: Theme[] = [
  { name: "light", fg: "#1f2328", sub: "#59636e", grid: "#d1d9e0", base: "#1f2328", sober: "#0969da", go: "#8c959f", rust: "#bc4c00", cap: "#cf222e", nocap: "#8c959f" },
  { name: "dark", fg: "#f0f6fc", sub: "#9198a1", grid: "#3d444d", base: "#f0f6fc", sober: "#4493f8", go: "#768390", rust: "#f0883e", cap: "#ff7b72", nocap: "#768390" },
];
const SUBJECTS: [string, string][] = [
  ["1brc", "1BRC"], ["binarytrees", "binary-trees"], ["fannkuch", "fannkuch-redux"], ["fasta", "fasta"], ["knucleotide", "k-nucleotide"],
  ["mandelbrot", "mandelbrot"], ["nbody", "n-body"], ["revcomp", "reverse-complement"], ["spectralnorm", "spectral-norm"],
];
const FONT = `font-family="-apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif"`;

function args(): Record<string, string> {
  const a = process.argv.slice(2); const o: Record<string, string> = {};
  for (let i = 0; i < a.length; i += 2) o[a[i].replace(/^-+/, "")] = a[i + 1];
  return o;
}

// seqperf の raw: 名前 wall user 最大RSS(KB) cycles 命令 loadavg
function readSeq(path: string): Map<string, { cyc: number; rss: number }> {
  const m = new Map<string, { cyc: number; rss: number }>();
  for (const line of readFileSync(path, "utf8").split("\n")) {
    const f = line.trim().split(/\s+/); if (f.length < 6) continue;
    const k = f[0]; const cyc = Number(f[4]); const rss = Number(f[3]) / 1024;
    const v = m.get(k);
    if (!v) m.set(k, { cyc, rss }); else { v.cyc = Math.min(v.cyc, cyc); v.rss = Math.max(v.rss, rss); }
  }
  return m;
}

// seqChartsFrom は速度・RSS の 4 枚（ファイル名 → 中身）— benchsync.ts が official.tsv から比を作って渡し、生成と照合に使う。
// m = 題材-実装 → { cyc: 対 Rust の比〔rust = 1〕・rss: MB }（比の取り方 — cycles の最小 / task-clock の周の対 — は benchsync が決める）・axis = 速度の図の軸の文
export function seqChartsFrom(m: Map<string, { cyc: number; rss: number }>, axis: string, dir = "docs/assets"): Record<string, string> {
  const o: Record<string, string> = {};
  for (const t of THEMES) {
    o[`${dir}/bench-speed-${t.name}.svg`] = speed(t, m, axis);
    o[`${dir}/bench-rss-${t.name}.svg`] = rss(t, m);
  }
  return o;
}

const esc = (s: string) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;");
const txt = (x: number, y: number, s: string, fill: string, size = 12, anchor = "start", extra = "") =>
  `<text x="${x.toFixed(1)}" y="${y.toFixed(1)}" fill="${fill}" font-size="${size}" text-anchor="${anchor}" ${extra}>${esc(s)}</text>`;

type Series = { label: string; color: (t: Theme) => string; values: number[]; labels?: string[] };

// 横棒（題材 × 系列）。scale: 値 → 0..1。refs: 縦の基準線
function hbars(t: Theme, title: string, axis: string, series: Series[], scale: (v: number) => number, ticks: [number, string][], fmt: (v: number) => string,
  refs: [number, string][]): string {
  const W = 760, L = 150, R = 70, top = 58, rowH = 14 * series.length + 14, H = top + rowH * SUBJECTS.length + 44;
  const pw = W - L - R; const X = (v: number) => L + pw * Math.max(0, Math.min(1, scale(v)));
  const o: string[] = [];
  o.push(`<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}" ${FONT}>`);
  o.push(txt(L, 22, title, t.fg, 15, "start", `font-weight="600"`));
  // 凡例
  let lx = L;
  for (const s of series) { o.push(`<rect x="${lx}" y="34" width="12" height="12" rx="2" fill="${s.color(t)}"/>`); o.push(txt(lx + 17, 44, s.label, t.sub, 12)); lx += 34 + s.label.length * 7; }
  // 目盛り
  for (const [v, l] of ticks) {
    const x = X(v); o.push(`<line x1="${x.toFixed(1)}" y1="${top - 4}" x2="${x.toFixed(1)}" y2="${H - 34}" stroke="${t.grid}" stroke-width="1"/>`);
    o.push(txt(x, H - 20, l, t.sub, 11, "middle"));
  }
  o.push(txt(L + pw / 2, H - 4, axis, t.sub, 11, "middle"));
  for (const [v, l] of refs) {
    const x = X(v); o.push(`<line x1="${x.toFixed(1)}" y1="${top - 6}" x2="${x.toFixed(1)}" y2="${H - 34}" stroke="${t.base}" stroke-width="1.5" stroke-dasharray="4 3"/>`);
    o.push(txt(x + 4, top - 8, l, t.fg, 11));
  }
  SUBJECTS.forEach(([, name], i) => {
    const y0 = top + i * rowH;
    o.push(txt(L - 10, y0 + rowH / 2 + 2, name, t.fg, 12, "end"));
    series.forEach((s, j) => {
      const v = s.values[i]; const y = y0 + 6 + j * 14;
      o.push(`<rect x="${L}" y="${y}" width="${(X(v) - L).toFixed(1)}" height="11" rx="2" fill="${s.color(t)}"/>`);
      o.push(txt(X(v) + 5, y + 9.5, s.labels?.[i] ?? fmt(v), t.sub, 11));
    });
  });
  o.push(`</svg>`);
  return o.join("\n") + "\n";
}

function speed(t: Theme, m: Map<string, { cyc: number; rss: number }>, axis = "CPU cycles relative to the straightforward Rust twin (same algorithm)"): string {
  const get = (p: string, k: string) => { const v = m.get(`${p}-${k}`); if (!v) throw new Error(`missing ${p}-${k}`); return v; };
  const rel = (k: string) => SUBJECTS.map(([p]) => get(p, k).cyc / get(p, "rust").cyc);
  const s: Series[] = [{ label: "Sober", color: (t) => t.sober, values: rel("sober") }, { label: "Go", color: (t) => t.go, values: rel("go") }];
  const mx = Math.ceil(Math.max(...s.flatMap((x) => x.values)) * 2) / 2;
  const ticks: [number, string][] = []; for (let v = 0; v <= mx + 1e-9; v += 0.5) ticks.push([v, v.toFixed(1)]);
  return hbars(t, "Relative CPU time — Rust = 1.0 (lower is faster)", axis, s, (v) => v / mx, ticks,
    (v) => `${v.toFixed(2)}×`, [[1, "Rust = 1.0"]]);
}

function rss(t: Theme, m: Map<string, { cyc: number; rss: number }>): string {
  const get = (p: string, k: string) => { const v = m.get(`${p}-${k}`); if (!v) throw new Error(`missing ${p}-${k}`); return v.rss; };
  const mb = (v: number) => (v < 1 ? v.toFixed(2) : v < 10 ? v.toFixed(1) : v.toFixed(0)) + " MB";
  const ser = (label: string, color: (t: Theme) => string, k: string): Series => {
    const rel = SUBJECTS.map(([p]) => get(p, k) / get(p, "rust"));
    return { label, color, values: rel, labels: SUBJECTS.map(([p], i) => `${mb(get(p, k))} (${rel[i].toFixed(rel[i] < 0.01 ? 3 : 2)}×)`) };
  };
  const s: Series[] = [ser("Sober", (t) => t.sober, "sober"), ser("Go", (t) => t.go, "go")];
  const mx = Math.ceil(Math.max(...s.flatMap((x) => x.values)) * 2) / 2;
  const ticks: [number, string][] = []; for (let v = 0; v <= mx + 1e-9; v += 0.5) ticks.push([v, v.toFixed(1)]);
  return hbars(t, "Relative peak memory — Rust = 1.0 (lower is smaller)", "max RSS relative to the straightforward Rust twin (labels: absolute MB)", s, (v) => v / mx, ticks,
    (v) => `${v.toFixed(2)}×`, [[1, "Rust = 1.0"]]);
}

// budget の時系列 TSV: 列 = 系列名 経過ms RSS(KB)。系列 "cap" は天井ありの RSS、"nocap" は天井なし。#cap=<MB> の行で天井の値
function budget(t: Theme, path: string): string {
  const pts = new Map<string, [number, number][]>(); let cap = 0;
  for (const line of readFileSync(path, "utf8").split("\n")) {
    const c = /^#cap=(\d+(?:\.\d+)?)/.exec(line); if (c) { cap = Number(c[1]); continue; }
    const f = line.trim().split(/\s+/); if (f.length < 3 || line.startsWith("#")) continue;
    if (!pts.has(f[0])) pts.set(f[0], []); pts.get(f[0])!.push([Number(f[1]) / 1000, Number(f[2]) / 1024]);
  }
  const W = 760, L = 70, R = 30, top = 58, H = 330, pw = W - L - R, ph = H - top - 50;
  const all = [...pts.values()].flat(); const tmax = Math.max(...all.map((p) => p[0])); const ymax = Math.max(cap * 1.25, ...all.map((p) => p[1])) * 1.05;
  const X = (s: number) => L + (pw * s) / tmax; const Y = (mb: number) => top + ph - (ph * mb) / ymax;
  const o: string[] = [];
  o.push(`<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}" ${FONT}>`);
  o.push(txt(L, 22, `Memory budget at work — RSS over time (budget: ${cap} MB)`, t.fg, 15, "start", `font-weight="600"`));
  const leg: [string, string][] = [["with budget", t.sober], ["without budget", t.nocap], ["budget", t.cap]];
  let lx = L; for (const [l, c] of leg) { o.push(`<rect x="${lx}" y="34" width="12" height="12" rx="2" fill="${c}"/>`); o.push(txt(lx + 17, 44, l, t.sub, 12)); lx += 40 + l.length * 7; }
  const step = Math.pow(10, Math.floor(Math.log10(ymax / 4))); const ys = [1, 2, 5].map((k) => k * step).find((s) => ymax / s <= 6) ?? step * 10;
  for (let v = 0; v <= ymax; v += ys) { o.push(`<line x1="${L}" y1="${Y(v).toFixed(1)}" x2="${W - R}" y2="${Y(v).toFixed(1)}" stroke="${t.grid}"/>`); o.push(txt(L - 6, Y(v) + 4, `${v}`, t.sub, 11, "end")); }
  const ts = tmax / 5; for (let i = 0; i <= 5; i++) o.push(txt(X(i * ts), H - 30, `${(i * ts).toFixed(tmax < 5 ? 1 : 0)}`, t.sub, 11, "middle"));
  o.push(txt(L + pw / 2, H - 12, "elapsed seconds", t.sub, 11, "middle"));
  o.push(txt(16, top + ph / 2, "RSS MB", t.sub, 11, "middle", `transform="rotate(-90 16 ${top + ph / 2})"`));
  const line = (p: [number, number][], c: string, w: number) =>
    `<polyline fill="none" stroke="${c}" stroke-width="${w}" stroke-linejoin="round" points="${p.map(([s, mb]) => `${X(s).toFixed(1)},${Y(mb).toFixed(1)}`).join(" ")}"/>`;
  if (pts.has("nocap")) o.push(line(pts.get("nocap")!, t.nocap, 1.5));
  if (pts.has("cap")) o.push(line(pts.get("cap")!, t.sober, 2.2));
  o.push(`<line x1="${L}" y1="${Y(cap).toFixed(1)}" x2="${W - R}" y2="${Y(cap).toFixed(1)}" stroke="${t.cap}" stroke-width="1.5" stroke-dasharray="6 4"/>`);
  o.push(`</svg>`);
  return o.join("\n") + "\n";
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const a = args();
  const out = a.o ?? "docs/assets";
  mkdirSync(out, { recursive: true });
  if (a.seq) {
    const m = readSeq(a.seq);
    for (const t of THEMES) {
      writeFileSync(`${out}/bench-speed-${t.name}.svg`, speed(t, m));
      writeFileSync(`${out}/bench-rss-${t.name}.svg`, rss(t, m));
    }
  }
  if (a.budget) for (const t of THEMES) writeFileSync(`${out}/bench-budget-${t.name}.svg`, budget(t, a.budget));
  console.log(`benchchart: wrote ${out}/bench-*.svg`);
}
