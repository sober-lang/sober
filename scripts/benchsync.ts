// benchsync: ベンチの数字の正 = bench/data/official.tsv（公式計測の raw を整形した 1 本）。README{,.ja}.md と bench/README.md の
// 数字の行・表をここから生成する（docsync と同型 — 文書の写しがずれたら鳴る）。生成するのはマーカーの中だけ:
//   行の印  `… <!-- benchsync:NAME -->`（行末）— その行を丸ごと生成し直す
//   塊の印  `<!-- benchsync:begin NAME -->` 〜 `<!-- benchsync:end NAME -->` — 間の行を生成し直す
// グラフ: docs/assets/bench-{speed,rss}-{light,dark}.svg の 4 枚はファイルごと生成物（scripts/benchchart.ts の seqCharts — 同じ tsv から）
// 勝敗の物差し: cycles:u の最小の比を小数 2 桁に丸め、0.95 未満 = 勝ち・1.05 超 = 負け・その間 = 互角（表に見える数字と分類を一致させる）
//   node --experimental-strip-types scripts/benchsync.ts           文書を書き換える
//   node --experimental-strip-types scripts/benchsync.ts --check   生成結果と現物が違えば差を出して exit 1（gates）
//   node --experimental-strip-types scripts/benchsync.ts --import <seqperf.tsv> <webrust.tsv> <extsort.tsv> <日付> <木のコミット>
//       公式計測の raw から official.tsv を作り直す（seqperf = bench/seqperf.sh --rust・webrust = Web 3 本の交互〔列 = 題材 実装 wall cycles 命令 task-clock-ms RSS-KB〕・
//       extsort = bench/extsort.sh）。wall は中央値（EPOCHREALTIME の差は WSL2 で壊れた値を含むことがある — report-632）
import { readFileSync, writeFileSync } from "node:fs";
import { seqCharts } from "./benchchart.ts";

const TSV = "bench/data/official.tsv";
const COLS = ["run", "bench", "impl", "cycles_min", "insts", "wall_med", "rss_kb", "taskclock_med_ms", "n", "date", "commit", "raw"] as const;
type Row = Record<(typeof COLS)[number], string>;

const median = (xs: number[]) => { const s = [...xs].sort((a, b) => a - b); return s[Math.floor((s.length - 1) / 2)]; };
const lines = (f: string) => readFileSync(f, "utf8").split("\n").filter((l) => l.trim() !== "" && !l.startsWith("#"));

function importRaw(seq: string, web: string, ext: string, date: string, commit: string) {
  const out: string[] = [];
  const emit = (run: string, bench: string, impl: string, rs: number[][], f: { c: number; i: number; w: number; m: number; t?: number }, raw: string) => {
    const t = f.t === undefined ? "-" : String(Math.round(median(rs.map((r) => r[f.t!]))));
    out.push([run, bench, impl, Math.min(...rs.map((r) => r[f.c])), rs[rs.length - 1][f.i], median(rs.map((r) => r[f.w])).toFixed(3),
      Math.max(...rs.map((r) => r[f.m])), t, rs.length, date, commit, raw].join("\t"));
  };
  const group = (ls: string[][], key: (r: string[]) => string) => {
    const m = new Map<string, string[][]>();
    for (const r of ls) { const k = key(r); if (!m.has(k)) m.set(k, []); m.get(k)!.push(r); }
    return m;
  };
  // seqperf: 名前-実装 wall user rssKB cycles insts load
  const implOf = (s: string) => ({ sober: "sober", go: "go", rust: "rust", ropt: "rust-opt" } as Record<string, string>)[s];
  for (const [k, rs] of group(lines(seq).map((l) => l.split(/\s+/)), (r) => r[0])) {
    const i = k.lastIndexOf("-");
    emit("seqperf", k.slice(0, i), implOf(k.slice(i + 1)), rs.map((r) => r.slice(1).map(Number)), { w: 0, m: 2, c: 3, i: 4 }, seq);
  }
  // webrust: 題材 実装 wall cycles insts task-clock-ms rssKB
  for (const [k, rs] of group(lines(web).filter((l) => !l.startsWith("MISMATCH")).map((l) => l.split(/\s+/)), (r) => `${r[0]} ${r[1]}`)) {
    const [b, im] = k.split(" ");
    emit("webrust", b, im, rs.map((r) => r.slice(2).map(Number)), { w: 0, c: 1, i: 2, t: 3, m: 4 }, web);
  }
  // extsort: 実装 大きさ wall user rssKB cycles insts task-clock-ms
  for (const [k, rs] of group(lines(ext).map((l) => l.split(/\s+/)), (r) => `${r[0]} ${r[1]}`)) {
    const [im, size] = k.split(" ");
    emit("extsort", `extsort-${Math.round(Number(size) / 1048576)}m`, im, rs.map((r) => r.slice(2).map(Number)), { w: 0, m: 2, c: 3, i: 4, t: 5 }, ext);
  }
  const head = ["# ベンチの数字の正（scripts/benchsync.ts が README{,.ja}.md・bench/README.md の印の中を生成する）。作り直しは benchsync.ts --import",
    "# cycles_min = cycles:u の最小・insts = instructions:u（決定的）・wall_med = wall の中央（s）・rss_kb = 最大 RSS・taskclock_med_ms = task-clock の中央（無ければ -）・n = 回数",
    COLS.join("\t")];
  writeFileSync(TSV, [...head, ...out.sort()].join("\n") + "\n");
  console.log(`benchsync: wrote ${TSV} (${out.length} rows)`);
}

// ── 生成 ──
function load(): Row[] {
  const ls = lines(TSV);
  const h = ls[0].split("\t");
  return ls.slice(1).map((l) => { const v = l.split("\t"); return Object.fromEntries(h.map((k, i) => [k, v[i]])) as Row; });
}
const SEQ = ["1brc", "binarytrees", "fannkuch", "fasta", "revcomp", "knucleotide", "nbody", "spectralnorm", "mandelbrot"];
const NAME: Record<string, string> = { "1brc": "1BRC", binarytrees: "binary-trees", fannkuch: "fannkuch-redux", fasta: "fasta", revcomp: "reverse-complement",
  knucleotide: "k-nucleotide", nbody: "n-body", spectralnorm: "spectral-norm", mandelbrot: "mandelbrot" };
const SCALE: Record<string, string> = { "1brc": "（1,000 万行）※", binarytrees: "（18）", fannkuch: "（11）", fasta: "（250 万）", nbody: "（500 万）", spectralnorm: "（2000）", mandelbrot: "（4000）" };
const EXT_IMPL: Record<string, string> = { sober: "Sober", go: "Go", rust: "Rust素", gnu: "GNU sort" };

function build(rows: Row[]) {
  const get = (run: string, bench: string, impl: string) => {
    const r = rows.find((x) => x.run === run && x.bench === bench && x.impl === impl);
    if (!r) throw new Error(`benchsync: ${TSV} に ${run} ${bench} ${impl} が無い`);
    return r;
  };
  const num = (r: Row, k: keyof Row) => Number(r[k]);
  const cyc = (b: string, im: string) => num(get("seqperf", b, im), "cycles_min");
  const rss = (b: string, im: string) => num(get("seqperf", b, im), "rss_kb") / 1024;
  const ratio = (a: number, b: number) => Math.round((a / b) * 100) / 100;
  const x = (v: number) => `${v.toFixed(2)}×`;
  // RSS の比は桁が小さい（0.4 MB 対 240 MB）— 0.01 未満は 3 桁で
  const rx = (a: number, b: number) => (a / b < 0.01 ? `${(a / b).toFixed(3)}×` : x(ratio(a, b)));
  const g = (v: number) => (v / 1e9).toFixed(2);
  const mb = (kb: number) => { const m = kb / 1024; return m < 10 ? m.toFixed(1) : m.toFixed(0); };
  const cls = (r: number) => (r < 0.95 ? "win" : r > 1.05 ? "loss" : "tie");
  // 対 impl の勝敗（cycles）: 分類ごとの [名前, 比] — 負けは比の大きい順・勝ちは小さい順
  const tally = (me: string, vs: string) => {
    const t: Record<string, [string, number][]> = { win: [], tie: [], loss: [] };
    for (const b of SEQ) { const r = ratio(cyc(b, me), cyc(b, vs)); t[cls(r)].push([b, r]); }
    t.loss.sort((a, b) => b[1] - a[1]); t.win.sort((a, b) => a[1] - b[1]); t.tie.sort((a, b) => a[1] - b[1]);
    return t;
  };
  const tr = tally("sober", "rust"), tg = tally("sober", "go"), gr = tally("go", "rust");
  const s0 = get("seqperf", "1brc", "sober");
  const date = s0.date, commit = s0.commit, raw = s0.raw.replace(/^.*\/out\//, "out/");
  const list = (xs: [string, number][], sep: string) => xs.map(([b, r]) => `${NAME[b]} ${x(r)}`).join(sep);
  const plural = (n: number, w: string, ws: string) => `${n} ${n === 1 ? w : ws}`;
  const enTally = (t: typeof tr) => [plural(t.win.length, "win", "wins"), plural(t.tie.length, "tie", "ties"), t.loss.length === 0 ? "no losses" : plural(t.loss.length, "loss", "losses")].join(", ");
  const enAnd = (xs: string[]) => (xs.length <= 1 ? xs.join("") : xs.length === 2 ? `${xs[0]} and ${xs[1]}` : `${xs.slice(0, -1).join(", ")}, and ${xs[xs.length - 1]}`);
  const rssOver = SEQ.filter((b) => rss(b, "sober") > rss(b, "rust"));
  const gen: Record<string, string> = {};

  // README（英日）— 速さと RSS の行
  gen["readme-speed-en"] = `- Runtime speed on par with Rust. Against straightforward Rust using the same algorithms, across 9 sequential benchmarks: ${enTally(tr)}` +
    (tr.loss.length ? ` (the ${tr.loss.length === 1 ? "loss is" : "losses are"} ${enAnd(tr.loss.map(([b, r]) => `${NAME[b]} ${x(r)}`))})` : "") + `. Against Go: ${enTally(tg)}.`;
  gen["readme-speed-ja"] = `- Rust に匹敵する実行速度。同じアルゴリズムの素直な Rust と比べて、逐次 9 題材で勝ち ${tr.win.length}・互角 ${tr.tie.length}・負け ${tr.loss.length}` +
    (tr.loss.length ? `（負けは ${list(tr.loss, "・")}）` : "") + `。Go には ${tg.win.length} 勝 ${tg.tie.length} 互角${tg.loss.length === 0 ? "（負けなし）" : ` ${tg.loss.length} 敗`}です。`;
  gen["readme-rss-en"] = `- A memory footprint on par with Rust. There is no GC. Peak RSS is at or below Rust's in ${SEQ.length - rssOver.length} of the 9 benchmarks` +
    (rssOver.length ? ` (the ${rssOver.length === 1 ? "exception is" : "exceptions are"} ${enAnd(rssOver.map((b) => NAME[b]))})` : "") + ".";
  gen["readme-rss-ja"] = `- Rust 並みのメモリフットプリント。GC はありません。最大 RSS は 9 題材中 ${SEQ.length - rssOver.length} 題材で Rust 以下です` +
    (rssOver.length ? `（上回るのは ${rssOver.map((b) => NAME[b]).join(" と ")}）` : "") + "。";

  // bench/README — 冒頭の要約の行
  const goRssOver = SEQ.filter((b) => rss(b, "sober") > rss(b, "go"));
  const goRssUnder = SEQ.filter((b) => rss(b, "sober") <= rss(b, "go")).map((b) => rss(b, "sober") / rss(b, "go"));
  gen["bench-go"] = `- 逐次 9 題材（対 Go・cycles・±5% を互角）: 勝ち ${tg.win.length}・互角 ${tg.tie.length}` + (tg.tie.length ? `（${list(tg.tie, "・")}）` : "") +
    `・負け ${tg.loss.length}` + (tg.loss.length ? `（${list(tg.loss, "・")}）` : "") + `。最も差が大きいのは ${list(tg.win.slice(0, 1), "")}`;
  gen["bench-rss-go"] = `- RSS は 9 題材中 ${goRssUnder.length} 題材で Go 以下（${rx(Math.min(...goRssUnder), 1)}〜${rx(Math.max(...goRssUnder), 1)}）。` +
    (goRssOver.length ? `上回るのは ${goRssOver.map((b) => `${NAME[b]}（${x(ratio(rss(b, "sober"), rss(b, "go")))}）`).join("・")}` : "上回る題材は無い");
  gen["bench-rust"] = `- 対 Rust の双子（逐次 9 題材・${date}）: Sober の ${tr.win.length} 勝・${tr.tie.length} 互角・${tr.loss.length} 敗` +
    (tr.loss.length ? `（負けは ${list(tr.loss, "・")} — 下の「Rust の双子との比較」）` : "");
  gen["bench-updated"] = `最終更新 ${date}（逐次 = 木 ${commit} — \`bench/seqperf.sh -n 5 --rust\`・raw = ${raw}・数字の正 = [data/official.tsv](data/official.tsv)。` +
    "並列 = 2026-10-08〜10 の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。";

  // bench/README — 逐次の表（対 Go）
  const seqGo = ["| 題材（規模） | cycles:u G Sober / Go | 比 | wall 中央 s Sober / Go | 比 | 命令 比 | 最大 RSS MB Sober / Go | 比 |", "|---|---|---|---|---|---|---|---|"];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go");
    seqGo.push(`| ${NAME[b]}${SCALE[b] ?? ""} | ${g(num(s, "cycles_min"))} / ${g(num(o, "cycles_min"))} | ${x(ratio(num(s, "cycles_min"), num(o, "cycles_min")))} | ` +
      `${num(s, "wall_med").toFixed(2)} / ${num(o, "wall_med").toFixed(2)} | ${x(ratio(num(s, "wall_med"), num(o, "wall_med")))} | ${x(ratio(num(s, "insts"), num(o, "insts")))} | ` +
      `${mb(num(s, "rss_kb"))} / ${mb(num(o, "rss_kb"))} | ${rx(num(s, "rss_kb"), num(o, "rss_kb"))} |`);
  }
  gen["bench-seq"] = seqGo.join("\n");

  // bench/README — Rust の双子の表 + 勝敗の行
  const rt = [`### Rust の双子との比較（${date} — 木 ${commit}）`, "",
    "| 題材 | cycles:u G Sober / Go / Rust | Sober / Rust | Go / Rust | 命令 Sober / Rust | wall 中央 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |", "|---|---|---|---|---|---|---|"];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go"), r = get("seqperf", b, "rust");
    rt.push(`| ${NAME[b]}${b === "1brc" ? " ※" : ""} | ${g(num(s, "cycles_min"))} / ${g(num(o, "cycles_min"))} / ${g(num(r, "cycles_min"))} | ${x(ratio(num(s, "cycles_min"), num(r, "cycles_min")))} | ` +
      `${x(ratio(num(o, "cycles_min"), num(r, "cycles_min")))} | ${x(ratio(num(s, "insts"), num(r, "insts")))} | ` +
      `${num(s, "wall_med").toFixed(2)} / ${num(o, "wall_med").toFixed(2)} / ${num(r, "wall_med").toFixed(2)} | ${mb(num(s, "rss_kb"))} / ${mb(num(o, "rss_kb"))} / ${mb(num(r, "rss_kb"))} |`);
  }
  gen["bench-rust-table"] = rt.join("\n");
  const names = (xs: [string, number][]) => xs.map(([b]) => NAME[b]).join("・");
  gen["bench-rust-tally"] = `- 対 Rust（cycles・小数 2 桁で 0.95〜1.05× を互角）: Sober の ${tr.win.length} 勝（${names(tr.win)}）・${tr.tie.length} 互角（${names(tr.tie)}）・` +
    `${tr.loss.length} 敗（${list(tr.loss, "・")}）。Go は Rust に対して ${gr.win.length} 勝` + (gr.win.length ? `（${names(gr.win)}）` : "") +
    `・${gr.tie.length} 互角` + (gr.tie.length ? `（${names(gr.tie)}）` : "") + `・${gr.loss.length} 敗`;

  // bench/README — 外部ソートの表
  const e0 = get("extsort", "extsort-1024m", "sober");
  const er = get("extsort", "extsort-1024m", "rust");
  const et = [`### 外部ソート（${e0.date} — 木 ${e0.commit}・\`bench/extsort.sh -n ${e0.n}\`・入力 1 GiB・窓 64 MiB・W1・warm・交互 ${e0.n} 回）`, "",
    "| 実装 | wall 中央 s | task-clock 中央 s | cycles:u G | 命令 G | 最大 RSS MB | wall 対 Rust素 |", "|---|---|---|---|---|---|---|"];
  for (const im of ["sober", "go", "rust", "gnu"]) {
    const r = get("extsort", "extsort-1024m", im);
    et.push(`| ${EXT_IMPL[im]} | ${num(r, "wall_med").toFixed(1)} | ${(num(r, "taskclock_med_ms") / 1000).toFixed(1)} | ${(num(r, "cycles_min") / 1e9).toFixed(1)} | ` +
      `${(num(r, "insts") / 1e9).toFixed(1)} | ${(num(r, "rss_kb") / 1024).toFixed(1)} | ${x(ratio(num(r, "wall_med"), num(er, "wall_med")))} |`);
  }
  gen["bench-extsort"] = et.join("\n");

  // bench/README — 逐次の生データ
  const rw = [`### 逐次の生データ（${date} — 木 ${commit}）`, "", `bench/seqperf.sh -n 5 --rust（raw = ${raw}・RSS は最大・wall は中央）:`, "",
    "| 題材 | wall 中央 s Sober / Go | cycles:u G Sober / Go | 命令 G Sober / Go | 最大 RSS MB Sober / Go |", "|---|---|---|---|---|"];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go");
    rw.push(`| ${b} | ${num(s, "wall_med").toFixed(3)} / ${num(o, "wall_med").toFixed(3)} | ${g(num(s, "cycles_min"))} / ${g(num(o, "cycles_min"))} | ` +
      `${g(num(s, "insts"))} / ${g(num(o, "insts"))} | ${(num(s, "rss_kb") / 1024).toFixed(1)} / ${(num(o, "rss_kb") / 1024).toFixed(1)} |`);
  }
  gen["bench-raw"] = rw.join("\n");
  return gen;
}

// ── 印の中を差し替える ──
function apply(text: string, gen: Record<string, string>, used: Set<string>, file: string): string {
  const out: string[] = [];
  const ls = text.split("\n");
  for (let i = 0; i < ls.length; i++) {
    const l = ls[i];
    const blk = l.match(/^<!-- benchsync:begin ([a-z0-9-]+) -->$/);
    if (blk) {
      const k = blk[1];
      const end = ls.findIndex((x, j) => j > i && x === `<!-- benchsync:end ${k} -->`);
      if (end < 0) throw new Error(`benchsync: ${file}: ${k} の end が無い`);
      if (!(k in gen)) throw new Error(`benchsync: ${file}: 知らない印 ${k}`);
      used.add(k);
      out.push(l, gen[k], ls[end]);
      i = end;
      continue;
    }
    const tag = l.match(/ <!-- benchsync:([a-z0-9-]+) -->$/);
    if (tag) {
      const k = tag[1];
      if (!(k in gen)) throw new Error(`benchsync: ${file}: 知らない印 ${k}`);
      used.add(k);
      out.push(`${gen[k]} <!-- benchsync:${k} -->`);
      continue;
    }
    out.push(l);
  }
  return out.join("\n");
}

const argv = process.argv.slice(2);
if (argv[0] === "--import") {
  importRaw(argv[1], argv[2], argv[3], argv[4], argv[5]);
  process.exit(0);
}
const check = argv[0] === "--check";
const gen = build(load());
const used = new Set<string>();
let fail = 0;
for (const f of ["README.md", "README.ja.md", "bench/README.md"]) {
  const cur = readFileSync(f, "utf8");
  const next = apply(cur, gen, used, f);
  if (next === cur) continue;
  if (check) {
    const a = cur.split("\n"), b = next.split("\n");
    for (let i = 0; i < Math.max(a.length, b.length); i++) if (a[i] !== b[i]) { console.log(`FAIL: ${f}:${i + 1}\n  - ${a[i] ?? ""}\n  + ${b[i] ?? ""}`); fail++; break; }
  } else {
    writeFileSync(f, next);
    console.log(`benchsync: updated ${f}`);
  }
}
for (const [f, next] of Object.entries(seqCharts(TSV))) {
  let cur = "";
  try { cur = readFileSync(f, "utf8"); } catch { /* 無ければ作る */ }
  if (next === cur) continue;
  if (check) { console.log(`FAIL: ${f} differs from the chart generated from ${TSV}`); fail++; }
  else { writeFileSync(f, next); console.log(`benchsync: updated ${f}`); }
}
const unused = Object.keys(gen).filter((k) => !used.has(k));
if (unused.length) { console.log(`FAIL: benchsync: 文書に印が無い生成物: ${unused.join(" ")}`); fail++; }
console.log(`benchsync: ${used.size} generated regions in README.md / README.ja.md / bench/README.md + 4 charts in docs/assets checked against ${TSV}, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
