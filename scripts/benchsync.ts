// benchsync: ベンチの数字の正 = bench/data/official.tsv（公式計測の raw を整形した 1 本）。README{,.ja}.md と bench/README.md の
// 数字の行・表をここから生成する（docsync と同型 — 文書の写しがずれたら鳴る）。生成するのはマーカーの中だけ:
//   行の印  `… <!-- benchsync:NAME -->`（行末）— その行を丸ごと生成し直す（同じ印を何か所に置いてもよい）
//   塊の印  `<!-- benchsync:begin NAME -->` 〜 `<!-- benchsync:end NAME -->` — 間の行を生成し直す
// グラフ: docs/assets/bench-{speed,rss}-{light,dark}.svg の 4 枚はファイルごと生成物（scripts/benchchart.ts の seqChartsFrom — 同じ tsv から）
// 物差しの 2 つのレジーム（official.tsv の中身で決まる）:
//   task-clock（GitHub Actions — .github/workflows/bench-official.yml・report-922）: seqperf の行に tc_rounds_ns（周ごとの task-clock）がある。
//     比 = 同じ周の交互の対（Sober の周 i / 相手の周 i）の比を全周とって中央（周ごとに全実装に乗る箱の揺れを打ち消す）。
//     VM はハードウェアのカウンタを出さない（report-921）ので cycles / 命令は NA
//   cycles（手元 WSL2 — 2026-10-19 まで）: cycles:u の最小の比
// 勝敗: 比を小数 2 桁に丸め、0.95 未満 = 勝ち・1.05 超 = 負け・その間 = 互角（表に見える数字と分類を一致させる）
// 計測環境: official.tsv の `# env: k=v; k=v` の行（--import が bench-env.txt から書く）→ bench-env の印。無ければ手元の旧環境の記述
//   node --experimental-strip-types scripts/benchsync.ts           文書を書き換える
//   node --experimental-strip-types scripts/benchsync.ts --check   生成結果と現物が違えば差を出して exit 1（gates）
//   node --experimental-strip-types scripts/benchsync.ts --import <seqperf.tsv> <extsort.tsv> <日付> <木のコミット> [--env <bench-env.txt>]
//       公式計測の raw から official.tsv を作り直す（seqperf = bench/seqperf.sh -n 5 --rust・extsort = bench/extsort.sh）。
//       Web 3 本（jsonapi・routing・logagg）は seqperf の行がそのまま正（旧 webrust の別計測は 2026-10-20 に廃止 — report-920 の W2）。
//       旧形 `--import <seqperf> <webrust> <extsort> <日付> <木>` も読む（webrust の行を足す — 生成には使わない）
//   環境変数 BENCHSYNC_TSV = official.tsv の代わりに読む tsv・BENCHSYNC_OUT = 書き出しの根（dry — 文書は元の場所から読み、OUT/<同じパス> へ書く）
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname } from "node:path";
import { seqChartsFrom } from "./benchchart.ts";

const TSV = process.env.BENCHSYNC_TSV ?? "bench/data/official.tsv";
const OUT = process.env.BENCHSYNC_OUT ?? "";
const COLS = ["run", "bench", "impl", "cycles_min", "insts", "wall_med", "rss_kb", "taskclock_med_ns", "tc_rounds_ns", "n", "date", "commit", "raw"] as const;
type Row = Record<(typeof COLS)[number], string>;
// 命令数の列（ナビ裁定 2026-10-20 — GitHub Actions では取れず、手元の値との併記は出所が 2 つになるので落とす。命令数の規律は gates / ratchet の別系統）。
// 戻すときは true に（cycles のレジームの表にだけ出る）
const SHOW_INSTS = false;

const median = (xs: number[]) => { const s = [...xs].sort((a, b) => a - b); return s[Math.floor((s.length - 1) / 2)]; };
const lines = (f: string) => readFileSync(f, "utf8").split("\n").filter((l) => l.trim() !== "" && !l.startsWith("#"));
const num = (s: string) => (s === "NA" || s === "-" || s === undefined ? NaN : Number(s));

function readEnv(f: string): Record<string, string> {
  const env: Record<string, string> = {};
  for (const l of readFileSync(f, "utf8").split("\n")) { const i = l.indexOf("="); if (i > 0) env[l.slice(0, i).trim()] = l.slice(i + 1).trim(); }
  return env;
}

function importRaw(seq: string, web: string | null, ext: string, date: string, commit: string, envFile: string | null) {
  const out: string[] = [];
  // rs = 周の順の行（数の列）・f = 列の位置（t = task-clock〔ns〕— 無い raw は undefined）
  const emit = (run: string, bench: string, impl: string, rs: number[][], f: { c: number; i: number; w: number; m: number; t?: number }, raw: string) => {
    const cyc = rs.map((r) => r[f.c]);
    const ts = f.t === undefined ? [] : rs.map((r) => r[f.t!]);
    const tsOk = ts.length > 0 && ts.every((v) => Number.isFinite(v));
    out.push([run, bench, impl, cyc.every(Number.isFinite) ? Math.min(...cyc) : "NA", Number.isFinite(rs[rs.length - 1][f.i]) ? rs[rs.length - 1][f.i] : "NA",
      median(rs.map((r) => r[f.w])).toFixed(3), Math.max(...rs.map((r) => r[f.m])), tsOk ? String(Math.round(median(ts))) : "-",
      tsOk ? ts.map((v) => String(Math.round(v))).join(",") : "-", rs.length, date, commit, raw].join("\t"));
  };
  const group = (ls: string[][], key: (r: string[]) => string) => {
    const m = new Map<string, string[][]>();
    for (const r of ls) { const k = key(r); if (!m.has(k)) m.set(k, []); m.get(k)!.push(r); }
    return m;
  };
  // seqperf: 名前-実装 wall user rssKB cycles insts load [task-clock]（周の順に並ぶ — 1 周 = 全題材 × 全実装の交互）
  const implOf = (s: string) => ({ sober: "sober", go: "go", rust: "rust", ropt: "rust-opt" } as Record<string, string>)[s];
  for (const [k, rs] of group(lines(seq).map((l) => l.split(/\s+/)), (r) => r[0])) {
    const i = k.lastIndexOf("-");
    emit("seqperf", k.slice(0, i), implOf(k.slice(i + 1)), rs.map((r) => r.slice(1).map(num)), { w: 0, m: 2, c: 3, i: 4, t: rs[0].length > 7 ? 6 : undefined }, seq);
  }
  // webrust（旧形のみ）: 題材 実装 wall cycles insts task-clock rssKB
  if (web) for (const [k, rs] of group(lines(web).filter((l) => !l.startsWith("MISMATCH")).map((l) => l.split(/\s+/)), (r) => `${r[0]} ${r[1]}`)) {
    const [b, im] = k.split(" ");
    emit("webrust", b, im, rs.map((r) => r.slice(2).map(num)), { w: 0, c: 1, i: 2, t: 3, m: 4 }, web);
  }
  // extsort: 実装 大きさ wall user rssKB cycles insts task-clock
  for (const [k, rs] of group(lines(ext).map((l) => l.split(/\s+/)), (r) => `${r[0]} ${r[1]}`)) {
    const [im, size] = k.split(" ");
    emit("extsort", `extsort-${Math.round(Number(size) / 1048576)}m`, im, rs.map((r) => r.slice(2).map(num)), { w: 0, m: 2, c: 3, i: 4, t: 5 }, ext);
  }
  const head = ["# ベンチの数字の正（scripts/benchsync.ts が README{,.ja}.md・bench/README.md の印の中を生成する）。作り直しは benchsync.ts --import",
    "# cycles_min = cycles:u の最小・insts = instructions:u（決定的）・wall_med = wall の中央（s）・rss_kb = 最大 RSS・taskclock_med_ns = task-clock の中央・" +
    "tc_rounds_ns = 周ごとの task-clock（周の順 — 比は同じ周の対で取る）・NA / - = 取れない（PMU の無い VM の cycles / 命令）・n = 回数"];
  if (envFile) { const e = readEnv(envFile); head.push(`# env: ${Object.entries(e).map(([k, v]) => `${k}=${v.replace(/;/g, ",")}`).join("; ")}`); }
  head.push(COLS.join("\t"));
  writeFileSync(TSV, [...head, ...out.sort()].join("\n") + "\n");
  console.log(`benchsync: wrote ${TSV} (${out.length} rows)`);
}

// ── 生成 ──
function load(): { rows: Row[]; env: Record<string, string> } {
  const all = readFileSync(TSV, "utf8").split("\n");
  const env: Record<string, string> = {};
  for (const l of all) {
    const m = l.match(/^# env: (.*)$/);
    if (m) for (const kv of m[1].split("; ")) { const i = kv.indexOf("="); if (i > 0) env[kv.slice(0, i)] = kv.slice(i + 1); }
  }
  const ls = lines(TSV);
  // 旧形の列名 taskclock_med_ms は中身が ns だった（perf -x, の task-clock は ns — 2026-10-20 に名前を直した）
  const h = ls[0].split("\t").map((k) => (k === "taskclock_med_ms" ? "taskclock_med_ns" : k));
  const rows = ls.slice(1).map((l) => { const v = l.split("\t"); return Object.fromEntries(COLS.map((k) => [k, v[h.indexOf(k)] ?? "-"])) as Row; });
  return { rows, env };
}
const SEQ = ["1brc", "binarytrees", "fannkuch", "fasta", "revcomp", "knucleotide", "nbody", "spectralnorm", "mandelbrot"];
const NAME: Record<string, string> = { "1brc": "1BRC", binarytrees: "binary-trees", fannkuch: "fannkuch-redux", fasta: "fasta", revcomp: "reverse-complement",
  knucleotide: "k-nucleotide", nbody: "n-body", spectralnorm: "spectral-norm", mandelbrot: "mandelbrot" };
const SCALE: Record<string, string> = { "1brc": "（1,000 万行）※", binarytrees: "（18）", fannkuch: "（11）", fasta: "（250 万）", nbody: "（500 万）", spectralnorm: "（2000）", mandelbrot: "（4000）" };
const EXT_IMPL: Record<string, string> = { sober: "Sober", go: "Go", rust: "Rust素", gnu: "GNU sort" };
// 手元の機械（official.tsv に env の行が無い旧レジームの逐次・並列の節・コンパイラ自身の節）
const LOCAL_MACHINE = "AMD Ryzen AI MAX PRO 390（12 物理コア × SMT 2）・32 GB・WSL2";
const LOCAL_SEQ_ENV = `${LOCAL_MACHINE}（kernel 6.18）・Go 1.26.1・Rust 1.89.0・perf 7.2.6`;
const LOCAL_PAR_ENV = `${LOCAL_MACHINE}（kernel 5.15 — 2026-10-08〜10 の取り直しの当時）・Go 1.26.1・perf 7.2.6`;

function build(rows: Row[], env: Record<string, string>) {
  const get = (run: string, bench: string, impl: string) => {
    const r = rows.find((x) => x.run === run && x.bench === bench && x.impl === impl);
    if (!r) throw new Error(`benchsync: ${TSV} に ${run} ${bench} ${impl} が無い`);
    return r;
  };
  const n = (r: Row, k: keyof Row) => Number(r[k]);
  const TC = rows.some((r) => r.run === "seqperf" && r.tc_rounds_ns !== "-");
  const rounds = (r: Row) => r.tc_rounds_ns.split(",").map(Number);
  // 比 a / b: task-clock = 同じ周の対の比の中央・cycles = cycles の最小の比（extsort の cycles のレジームは wall の中央の比 — 旧の表の流儀）
  const rel = (run: string, bench: string, a: string, b: string) => {
    const x = get(run, bench, a), y = get(run, bench, b);
    if (TC) { const xs = rounds(x), ys = rounds(y); if (xs.length !== ys.length) throw new Error(`benchsync: ${run} ${bench} ${a}/${b} の周の数が違う`); return median(xs.map((v, i) => v / ys[i])); }
    return run === "extsort" ? n(x, "wall_med") / n(y, "wall_med") : n(x, "cycles_min") / n(y, "cycles_min");
  };
  const rss = (b: string, im: string) => n(get("seqperf", b, im), "rss_kb") / 1024;
  const ratio = (v: number) => Math.round(v * 100) / 100;
  const x = (v: number) => `${v.toFixed(2)}×`;
  // RSS の比は桁が小さい（0.4 MB 対 240 MB）— 0.01 未満は 3 桁で
  const rx = (a: number, b: number) => (a / b < 0.01 ? `${(a / b).toFixed(3)}×` : x(ratio(a / b)));
  const g = (v: number) => (v / 1e9).toFixed(2);
  const s3 = (ns: number) => (ns / 1e9).toFixed(3);
  const mb = (kb: number) => { const m = kb / 1024; return m < 10 ? m.toFixed(1) : m.toFixed(0); };
  const cls = (r: number) => (r < 0.95 ? "win" : r > 1.05 ? "loss" : "tie");
  // 対 impl の勝敗: 分類ごとの [名前, 比] — 負けは比の大きい順・勝ちは小さい順
  const tally = (me: string, vs: string) => {
    const t: Record<string, [string, number][]> = { win: [], tie: [], loss: [] };
    for (const b of SEQ) { const r = ratio(rel("seqperf", b, me, vs)); t[cls(r)].push([b, r]); }
    t.loss.sort((a, b) => b[1] - a[1]); t.win.sort((a, b) => a[1] - b[1]); t.tie.sort((a, b) => a[1] - b[1]);
    return t;
  };
  const tr = tally("sober", "rust"), tg = tally("sober", "go"), gr = tally("go", "rust");
  const s0 = get("seqperf", "1brc", "sober");
  const date = s0.date, commit = s0.commit, raw = s0.raw.replace(/^.*\/(out|bench\/data)\//, "$1/");
  const list = (xs: [string, number][], sep: string) => xs.map(([b, r]) => `${NAME[b]} ${x(r)}`).join(sep);
  const plural = (k: number, w: string, ws: string) => `${k} ${k === 1 ? w : ws}`;
  const enTally = (t: typeof tr) => [plural(t.win.length, "win", "wins"), plural(t.tie.length, "tie", "ties"), t.loss.length === 0 ? "no losses" : plural(t.loss.length, "loss", "losses")].join(", ");
  const enAnd = (xs: string[]) => (xs.length <= 1 ? xs.join("") : xs.length === 2 ? `${xs[0]} and ${xs[1]}` : `${xs.slice(0, -1).join(", ")}, and ${xs[xs.length - 1]}`);
  const rssOver = SEQ.filter((b) => rss(b, "sober") > rss(b, "rust"));
  const M = TC ? "CPU 時間〔task-clock〕" : "cycles";
  const ghaEnv = `GitHub Actions ${env.runner ?? "?"}（${env.cpu ?? "?"}・kernel ${env.kernel ?? "?"}・run ${env.run_id ?? "?"}）`;
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
  // 設計ノート（fast.md）— 対 Rust の負けの題材の行
  gen["notes-fast-loss"] = tr.loss.length
    ? `答え: 素直な Rust に対して、${list(tr.loss, "・")} で負けています（逐次 9 題材・${date} の公式計測の CPU 時間）。`
    : `答え: 素直な Rust に負けている題材はありません（逐次 9 題材・${date} の公式計測の CPU 時間）。`;
  // README（英日）— グラフの出所と再現の行
  gen["readme-repro-en"] = "The speed and memory charts are generated by `scripts/benchsync.sh` from [bench/data/official.tsv](bench/data/official.tsv), the single source of the benchmark numbers on this page (a gate checks that the charts and numbers match it). " +
    (TC ? `The numbers are CPU time (task-clock) measured on GitHub Actions (${env.cpu ?? "?"}) by \`.github/workflows/bench-official.yml\`; to reproduce locally: \`scripts/bench.sh -n 3\` → \`bench/seqperf.sh -n 5 --rust\`. `
      : "To reproduce: `scripts/bench.sh -n 3` → `bench/seqperf.sh -n 5 --rust`. ") +
    "The Go and Rust twins of each benchmark live in `bench/<benchmark>/go` and `bench/<benchmark>/rust`. Measurement conditions and rules are in [docs/bench.md](docs/bench.md) (in Japanese).";
  gen["readme-repro-ja"] = "速度とメモリのグラフは、[bench/data/official.tsv](bench/data/official.tsv) から `scripts/benchsync.sh` で生成しています。このページのベンチの数字はすべてこのファイルが出どころで、グラフと数字がこのファイルと一致することを gate が確かめます。" +
    (TC ? `数字は GitHub Actions（${env.cpu ?? "?"}）で \`.github/workflows/bench-official.yml\` が測った CPU 時間（task-clock）です。手元での再現: \`scripts/bench.sh -n 3\` → \`bench/seqperf.sh -n 5 --rust\`。`
      : "再現: `scripts/bench.sh -n 3` → `bench/seqperf.sh -n 5 --rust`。") +
    "各題材の Go と Rust の双子は `bench/<題材>/go`・`bench/<題材>/rust` にあります。計測の条件と規律は [docs/bench.md](docs/bench.md) に書いています。";

  // bench/README — 冒頭の要約の行
  const goRssOver = SEQ.filter((b) => rss(b, "sober") > rss(b, "go"));
  const goRssUnder = SEQ.filter((b) => rss(b, "sober") <= rss(b, "go")).map((b) => rss(b, "sober") / rss(b, "go"));
  gen["bench-go"] = `- 逐次 9 題材（対 Go・${M}・±5% を互角）: 勝ち ${tg.win.length}・互角 ${tg.tie.length}` + (tg.tie.length ? `（${list(tg.tie, "・")}）` : "") +
    `・負け ${tg.loss.length}` + (tg.loss.length ? `（${list(tg.loss, "・")}）` : "") + `。最も差が大きいのは ${list(tg.win.slice(0, 1), "")}`;
  gen["bench-rss-go"] = `- RSS は 9 題材中 ${goRssUnder.length} 題材で Go 以下（${rx(Math.min(...goRssUnder), 1)}〜${rx(Math.max(...goRssUnder), 1)}）。` +
    (goRssOver.length ? `上回るのは ${goRssOver.map((b) => `${NAME[b]}（${x(ratio(rss(b, "sober") / rss(b, "go")))}）`).join("・")}` : "上回る題材は無い");
  gen["bench-rust"] = `- 対 Rust の双子（逐次 9 題材・${date}）: Sober の ${tr.win.length} 勝・${tr.tie.length} 互角・${tr.loss.length} 敗` +
    (tr.loss.length ? `（負けは ${list(tr.loss, "・")} — 下の「Rust の双子との比較」）` : "");
  gen["bench-updated"] = TC
    ? `最終更新 ${date}（逐次 = 木 ${commit} — ${ghaEnv} で \`bench/seqperf.sh -n 5 --rust\`・raw = ${raw}・数字の正 = [data/official.tsv](data/official.tsv)。` +
      "並列 = 2026-10-08〜10 の手元の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。"
    : `最終更新 ${date}（逐次 = 木 ${commit} — \`bench/seqperf.sh -n 5 --rust\`・raw = ${raw}・数字の正 = [data/official.tsv](data/official.tsv)。` +
      "並列 = 2026-10-08〜10 の取り直しのまま — 日付は [par/README.md](par/README.md) の各節）。生データと測り方は [par/README.md](par/README.md)（並列）と本ファイルの末尾（逐次）。";

  // bench/README — 逐次の表（対 Go）
  const seqGo = TC
    ? ["| 題材（規模） | CPU 時間 中央 s Sober / Go | 比 | wall 中央 s Sober / Go | 比 | 最大 RSS MB Sober / Go | 比 |", "|---|---|---|---|---|---|---|"]
    : [`| 題材（規模） | cycles:u G Sober / Go | 比 | wall 中央 s Sober / Go | 比 |${SHOW_INSTS ? " 命令 比 |" : ""} 最大 RSS MB Sober / Go | 比 |`, `|---|---|---|---|---|${SHOW_INSTS ? "---|" : ""}---|---|`];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go");
    const speed = TC ? `${s3(n(s, "taskclock_med_ns"))} / ${s3(n(o, "taskclock_med_ns"))}` : `${g(n(s, "cycles_min"))} / ${g(n(o, "cycles_min"))}`;
    seqGo.push(`| ${NAME[b]}${SCALE[b] ?? ""} | ${speed} | ${x(ratio(rel("seqperf", b, "sober", "go")))} | ` +
      `${n(s, "wall_med").toFixed(2)} / ${n(o, "wall_med").toFixed(2)} | ${x(ratio(n(s, "wall_med") / n(o, "wall_med")))} | ` +
      (!TC && SHOW_INSTS ? `${x(ratio(n(s, "insts") / n(o, "insts")))} | ` : "") +
      `${mb(n(s, "rss_kb"))} / ${mb(n(o, "rss_kb"))} | ${rx(n(s, "rss_kb"), n(o, "rss_kb"))} |`);
  }
  gen["bench-seq"] = seqGo.join("\n");
  gen["bench-method"] = TC
    ? `${ghaEnv} の 1 つの vCPU（最後の vCPU）に固定し、Sober → Go → Rust の交互で 5 周測った（準備の後に loadavg が 1.5 を割るまで待ってから）。` +
      "物差しは CPU 時間（task-clock — カーネルの時間を含む）で、比は同じ周の対（Sober の周 i / 相手の周 i）の比の 5 周の中央をとる（周ごとに全実装に同時に乗る箱の揺れが打ち消される — 同じ箱で 3 run の比の幅は最大 3.7%・report-922）。" +
      "表の CPU 時間と wall は中央、RSS は最大。GitHub Actions の VM はハードウェアのカウンタを出さないので cycles と命令数は無い（命令数の規律は gates のラチェットが見る）。" +
      "数字の正は [data/official.tsv](data/official.tsv) で、表と要約の行は `scripts/benchsync.sh` が生成する（gates の benchsync が文書との一致を見る）。" +
      "出力は毎回 Sober ≡ Go ≡ Rust で、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrot は benchmarks game の公式の期待出力とも一致する。" +
      "公式の再現: `.github/workflows/bench-official.yml`（workflow_dispatch）→ `scripts/benchfetch.sh <run-id>`。手元: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。"
    : "1 つの論理 CPU に固定し、Sober → Go → Rust の交互で 5 回測った。cycles は最小、wall は中央、RSS は最大をとり、命令数は決定的な値（wall を中央にするのは、EPOCHREALTIME の差が WSL2 で壊れた値〔0.1 s 級の飛び〕を含むことがあるため — 2026-10-14）。" +
      "数字の正は [data/official.tsv](data/official.tsv) で、表と要約の行は `scripts/benchsync.sh` が生成する（gates の benchsync が文書との一致を見る）。" +
      "出力は毎回 Sober ≡ Go で、fasta / revcomp / k-nucleotide / n-body / spectral-norm / mandelbrot は benchmarks game の公式の期待出力とも一致する。" +
      "再現: `scripts/bench.sh -n 5`（実行ファイルと入力を置く）→ `bench/seqperf.sh -n 5 --rust`。";
  gen["bench-metric-note"] = TC
    ? "- 物差しは CPU 時間（task-clock）。2026-10-19 までの手元（WSL2）の cycles:u は利用者の空間だけを数えたが、task-clock はカーネルの時間（ファイルの読み・ページフォールト）も含む — 入力を読む題材（1BRC・Web 3 本）は比が動く。wall は参考"
    : "- 物差しは cycles。命令数は 3 題材で Sober の方が多いが、cycles では互角かそれ以下に収まる（1 命令あたりの仕事が軽い — 依存の鎖・メモリ待ちで律速する形）。wall は同居の負荷（今回の loadavg 1.2〜1.9）で揺れるので参考";

  // bench/README — Rust の双子の表 + 勝敗の行
  const rt = TC
    ? [`### Rust の双子との比較（${date} — 木 ${commit}）`, "",
      "| 題材 | CPU 時間 中央 s Sober / Go / Rust | Sober / Rust | Go / Rust | wall 中央 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |", "|---|---|---|---|---|---|"]
    : [`### Rust の双子との比較（${date} — 木 ${commit}）`, "",
      `| 題材 | cycles:u G Sober / Go / Rust | Sober / Rust | Go / Rust |${SHOW_INSTS ? " 命令 Sober / Rust |" : ""} wall 中央 s Sober / Go / Rust | 最大 RSS MB Sober / Go / Rust |`, `|---|---|---|---|${SHOW_INSTS ? "---|" : ""}---|---|`];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go"), r = get("seqperf", b, "rust");
    const speed = TC ? [s, o, r].map((y) => s3(n(y, "taskclock_med_ns"))).join(" / ") : [s, o, r].map((y) => g(n(y, "cycles_min"))).join(" / ");
    rt.push(`| ${NAME[b]}${b === "1brc" ? " ※" : ""} | ${speed} | ${x(ratio(rel("seqperf", b, "sober", "rust")))} | ${x(ratio(rel("seqperf", b, "go", "rust")))} | ` +
      (!TC && SHOW_INSTS ? `${x(ratio(n(s, "insts") / n(r, "insts")))} | ` : "") +
      `${n(s, "wall_med").toFixed(2)} / ${n(o, "wall_med").toFixed(2)} / ${n(r, "wall_med").toFixed(2)} | ${mb(n(s, "rss_kb"))} / ${mb(n(o, "rss_kb"))} / ${mb(n(r, "rss_kb"))} |`);
  }
  gen["bench-rust-table"] = rt.join("\n");
  const names = (xs: [string, number][]) => xs.map(([b]) => NAME[b]).join("・");
  gen["bench-rust-tally"] = `- 対 Rust（${M}・小数 2 桁で 0.95〜1.05× を互角）: Sober の ${tr.win.length} 勝（${names(tr.win)}）・${tr.tie.length} 互角（${names(tr.tie)}）・` +
    `${tr.loss.length} 敗（${list(tr.loss, "・")}）。Go は Rust に対して ${gr.win.length} 勝` + (gr.win.length ? `（${names(gr.win)}）` : "") +
    `・${gr.tie.length} 互角` + (gr.tie.length ? `（${names(gr.tie)}）` : "") + `・${gr.loss.length} 敗`;

  // bench/README — 外部ソートの表
  const e0 = get("extsort", "extsort-1024m", "sober");
  const et = [`### 外部ソート（${e0.date} — 木 ${e0.commit}・\`bench/extsort.sh -n ${e0.n}\`・入力 1 GiB・窓 64 MiB・W1・warm・交互 ${e0.n} 回）`, "",
    TC ? "| 実装 | wall 中央 s | CPU 時間 中央 s | 最大 RSS MB | CPU 時間 対 Rust素 |" : `| 実装 | wall 中央 s | task-clock 中央 s | cycles:u G |${SHOW_INSTS ? " 命令 G |" : ""} 最大 RSS MB | wall 対 Rust素 |`,
    TC ? "|---|---|---|---|---|" : `|---|---|---|---|${SHOW_INSTS ? "---|" : ""}---|---|`];
  for (const im of ["sober", "go", "rust", "gnu"]) {
    const r = get("extsort", "extsort-1024m", im);
    et.push(`| ${EXT_IMPL[im]} | ${n(r, "wall_med").toFixed(1)} | ${(n(r, "taskclock_med_ns") / 1e9).toFixed(1)} | ` +
      (TC ? "" : `${(n(r, "cycles_min") / 1e9).toFixed(1)} | ${SHOW_INSTS ? `${(n(r, "insts") / 1e9).toFixed(1)} | ` : ""}`) +
      `${(n(r, "rss_kb") / 1024).toFixed(1)} | ${x(ratio(rel("extsort", "extsort-1024m", im, "rust")))} |`);
  }
  gen["bench-extsort"] = et.join("\n");

  // bench/README — 逐次の生データ
  const rw = TC
    ? [`### 逐次の生データ（${date} — 木 ${commit}・${ghaEnv}）`, "", `bench/seqperf.sh -n 5 --rust（raw = ${raw}・CPU 時間は task-clock の中央・RSS は最大・wall は中央）:`, "",
      "| 題材 | wall 中央 s Sober / Go | CPU 時間 中央 s Sober / Go | 最大 RSS MB Sober / Go |", "|---|---|---|---|"]
    : [`### 逐次の生データ（${date} — 木 ${commit}）`, "", `bench/seqperf.sh -n 5 --rust（raw = ${raw}・RSS は最大・wall は中央）:`, "",
      `| 題材 | wall 中央 s Sober / Go | cycles:u G Sober / Go |${SHOW_INSTS ? " 命令 G Sober / Go |" : ""} 最大 RSS MB Sober / Go |`, `|---|---|---|${SHOW_INSTS ? "---|" : ""}---|`];
  for (const b of SEQ) {
    const s = get("seqperf", b, "sober"), o = get("seqperf", b, "go");
    rw.push(`| ${b} | ${n(s, "wall_med").toFixed(3)} / ${n(o, "wall_med").toFixed(3)} | ` +
      (TC ? `${s3(n(s, "taskclock_med_ns"))} / ${s3(n(o, "taskclock_med_ns"))} | `
        : `${g(n(s, "cycles_min"))} / ${g(n(o, "cycles_min"))} | ${SHOW_INSTS ? `${g(n(s, "insts"))} / ${g(n(o, "insts"))} | ` : ""}`) +
      `${(n(s, "rss_kb") / 1024).toFixed(1)} / ${(n(o, "rss_kb") / 1024).toFixed(1)} |`);
  }
  gen["bench-raw"] = rw.join("\n");
  gen["bench-raw-note"] = TC
    ? "物差しは CPU 時間（task-clock）の、同じ周の対の比の 5 周の中央。wall は 5 回の中央（参考）。cycles と命令数は GitHub Actions の VM では取れない（命令数の規律は gates のラチェット〔bench/ratchet.txt〕が見る）。"
    : "主の物差しは cycles（命令数は決定的な値だが表からは外した — 命令数の規律は gates のラチェット〔bench/ratchet.txt〕が見る）。wall は 5 回の中央（EPOCHREALTIME の差 — 同居の負荷で揺れ、壊れた値を含むことがある）。";

  // bench/README — 計測環境（2 つのレジームの同居を明示する — 逐次の公式と手元の節）
  gen["bench-env"] = [
    TC ? `- 逐次・外部ソート（[data/official.tsv](data/official.tsv)）: ${ghaEnv}・Go ${(env.go ?? "?").replace(/^go/, "")}・Rust ${env.rust ?? "?"}・perf ${env.perf ?? "?"}。` +
        "1 つの vCPU（最後の vCPU）に固定。同じラベルでも箱の CPU の型番が run で変わるので、公式に取り込むのは基線と同じ型番の run だけ（`scripts/benchfetch.sh` が照合）"
      : `- 逐次・外部ソート（[data/official.tsv](data/official.tsv) — ${date}）: 手元 ${LOCAL_SEQ_ENV}。1 つの論理 CPU（最後のコア）に固定。loadavg は 2〜5 で同居の負荷があり、wall は ±50% 揺れるので主の物差しは cycles:u とした`,
    `- 並列・コンパイラ自身・イディオムギャップ（[par/README.md](par/README.md)・本ファイルの 2・3・5 節）: 手元 ${LOCAL_PAR_ENV}。並列は物理コアごとに 1 論理 CPU の 8 つに固定した`,
    "- 逐次の表は `SOBER_WORKERS=1` で走らせる（std の内側の並列 — 大きい入力の utf8.Check の区間割り — を逐次の列に混ぜない。並列の配当は [par/README.md](par/README.md) の W 軸で見る）",
  ].join("\n");
  gen["bench-env-local"] = `計測環境: 手元（${LOCAL_PAR_ENV}）${TC ? " — 逐次の表〔GitHub Actions〕とは別の機械" : ""}。詳細は 6 節`;

  // グラフ: 題材-実装 → 対 Rust の比（rust = 1）と RSS MB
  const chart = new Map<string, { cyc: number; rss: number }>();
  for (const b of SEQ) for (const im of ["sober", "go", "rust"]) chart.set(`${b}-${im}`, { cyc: im === "rust" ? 1 : rel("seqperf", b, im, "rust"), rss: rss(b, im) });
  const axis = TC ? "CPU time (task-clock) relative to the straightforward Rust twin (same algorithm)" : "CPU cycles relative to the straightforward Rust twin (same algorithm)";
  return { gen, charts: seqChartsFrom(chart, axis) };
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

const write = (f: string, s: string) => { const p = OUT ? `${OUT}/${f}` : f; mkdirSync(dirname(p), { recursive: true }); writeFileSync(p, s); console.log(`benchsync: updated ${p}`); };
const argv = process.argv.slice(2);
if (argv[0] === "--import") {
  const ei = argv.indexOf("--env");
  const envFile = ei >= 0 ? argv[ei + 1] : null;
  const pos = argv.slice(1).filter((_, i, a) => a[i] !== "--env" && a[i - 1] !== "--env");
  if (pos.length === 4) importRaw(pos[0], null, pos[1], pos[2], pos[3], envFile);
  else if (pos.length === 5) importRaw(pos[0], pos[1], pos[2], pos[3], pos[4], envFile);
  else { console.error("benchsync: --import <seqperf.tsv> <extsort.tsv> <日付> <木> [--env <bench-env.txt>]（旧形 <seqperf> <webrust> <extsort> <日付> <木>）"); process.exit(2); }
  process.exit(0);
}
const check = argv[0] === "--check";
const { rows, env } = load();
const { gen, charts } = build(rows, env);
const used = new Set<string>();
let fail = 0;
for (const f of ["README.md", "README.ja.md", "bench/README.md", "docs/design-notes/fast.md"]) {
  const cur = readFileSync(f, "utf8");
  const next = apply(cur, gen, used, f);
  if (next === cur && !OUT) continue;
  if (check) {
    const a = cur.split("\n"), b = next.split("\n");
    for (let i = 0; i < Math.max(a.length, b.length); i++) if (a[i] !== b[i]) { console.log(`FAIL: ${f}:${i + 1}\n  - ${a[i] ?? ""}\n  + ${b[i] ?? ""}`); fail++; break; }
  } else write(f, next);
}
for (const [f, next] of Object.entries(charts)) {
  let cur = "";
  try { cur = readFileSync(f, "utf8"); } catch { /* 無ければ作る */ }
  if (next === cur && !OUT) continue;
  if (check) { if (next !== cur) { console.log(`FAIL: ${f} differs from the chart generated from ${TSV}`); fail++; } }
  else write(f, next);
}
const unused = Object.keys(gen).filter((k) => !used.has(k));
if (unused.length) { console.log(`FAIL: benchsync: 文書に印が無い生成物: ${unused.join(" ")}`); fail++; }
console.log(`benchsync: ${used.size} generated regions in README.md / README.ja.md / bench/README.md / docs/design-notes/fast.md + 4 charts in docs/assets checked against ${TSV}, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
