// carry（検証の増分化の柱2 R1）: 列車の先端（HEAD）で、枝の全件の結果を持ち越せるゲートの一覧を出す（gates.sh --level 2 が呼ぶ）。
//   node scripts/carry.ts <基点>:<枝の先端>[,<枝の先端>…]
// 出力: 持ち越せるなら `CARRY <ゲート>` を1行ずつ（終了0）。持ち越せないなら `NOCARRY <理由>` を1行以上（終了1）。引数の誤りは終了2。経過は stderr。
// 条件（全部を満たすときだけ持ち越す）:
//   1. 各枝の先端が HEAD に含まれる。枝は古い main-new から分かれていてよい（分かれ目から基点までの変更と枝の変更の合成は、枝の間の合成と同じく夜の冷が見る。
//      分かれ目からの距離は stderr に出す）
//   2. 各枝の先端に、clean な木の枝の契約の ALL PASS の記録がある（gates-runs.tsv — 割らないレベル1（組の欄 lv=1・旧名 full）の1行か、同じ N の --part 1/N〜N/N の全部。part ごとに最後の行で決める）。
//      同じコミットの行は同じ gates.sh で回したものなので、割り方のハッシュはここでは見ない（contractok.sh は今の木の gates.sh で見る）
//   3. 基点 → HEAD の first-parent の列が、枝の先端の merge（第2の親が枝の先端）と、@regen の中だけを変えるコミットからなり、全部の枝の先端が merge されている
//   4. merge の衝突の解決（git show --remerge-diff）が変えたパスが @regen の外なら、そのパスを鍵に含むゲート（gatememo.ts cover）を持ち越さない。
//      共通の成分（src/compiler・src/std・gates.sh など全ゲートの鍵）に当たれば、持ち越すゲートは無い
//   5. 持ち越すゲート = 今の枝の組（gates.sh --level 1 --list）のうち、全部の枝の先端の gates.sh の ORDER にあるもの − @always − @lines − 4で外したゲート
//      （@always は記録しない毎回のゲート — 木の全体の lint など、列車の木で値が決まる。@lines は線〔bench/ratchet.txt・scripts/framestat.list〕と実測を
//      比べるゲートで、線の値は鍵に入らない — 枝の PASS は枝の線で判定した結果なので、列車で線が変わると持ち越した判定がいまの線を見ない）
//      （枝で足されたゲートは、ほかの枝の変更の上で確かめられていないので持ち越さない）
// 札（scripts/gatedeps.txt — gatememo.ts place が読む）: `@place train / nightly`・`@regen: <パス…>`
import { execFileSync, spawnSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const git = (...a: string[]) => execFileSync("git", ["-C", ROOT, ...a], { encoding: "utf8", maxBuffer: 1 << 28 }).trim();
const ok = (...a: string[]) => spawnSync("git", ["-C", ROOT, ...a], { stdio: "ignore" }).status === 0;
const lines = (s: string) => s.split("\n").filter((l) => l.length > 0);
const node = (...a: string[]) => lines(execFileSync("node", ["--experimental-strip-types", ...a], { cwd: ROOT, encoding: "utf8", env: { ...process.env, NODE_NO_WARNINGS: "1" } }));

const arg = process.argv[2] ?? "";
const m = /^([^:]+):(.+)$/.exec(arg);
if (!m) { console.error("使い方: node scripts/carry.ts <基点>:<枝の先端>[,<枝の先端>…]"); process.exit(2); }
const rev = (r: string) => { try { return git("rev-parse", "--verify", `${r}^{commit}`); } catch { console.error(`carry: コミットが見つからない: ${r}`); process.exit(2); } };
const base = rev(m[1]);
const tips = [...new Set(m[2].split(",").map(rev))];
const head = rev("HEAD");
const regen = node(path.join(ROOT, "scripts/gatememo.ts"), "place", "regen");
const under = (p: string, q: string) => p === q || p.startsWith(q.endsWith("/") ? q : `${q}/`);
const inRegen = (p: string) => regen.some((q) => under(p, q));
const short = (c: string) => c.slice(0, 12);

const no: string[] = [];
// 1
for (const t of tips) {
  if (!ok("merge-base", "--is-ancestor", t, head)) { no.push(`枝の先端 ${short(t)} が HEAD に含まれない`); continue; }
  try {
    const mb = git("merge-base", t, base);
    console.error(`carry: 枝 ${short(t)} の分かれ目 ${short(mb)} は基点の ${git("rev-list", "--count", `${mb}..${base}`)} コミット前`);
  } catch { no.push(`枝の先端 ${short(t)} と基点に共通の祖先が無い`); }
}
// 2
const runsFile = process.env.GATES_RUNS || path.join(git("rev-parse", "--path-format=absolute", "--git-common-dir"), "gates-runs.tsv");
const rows = fs.existsSync(runsFile) ? lines(fs.readFileSync(runsFile, "utf8")).map((l) => l.split("\t")) : [];
function contract(t: string): string | null {
  const mine = rows.filter((r) => r[1] === t && r[2] === "clean" && (r[4] === "cache" || r[4] === "cold")).map((r) => [r[0], r[1], r[2], r[3].replace(/^full/, "lv=1"), ...r.slice(4)]);
  const whole = mine.filter((r) => r[3] === "lv=1").at(-1);
  if (whole && whole[5] === "ALL PASS") return `レベル1の1本（${whole[0]}）`;
  const ns = new Set(mine.map((r) => /^lv=1:\d+\/(\d+)$/.exec(r[3])?.[1]).filter((x): x is string => !!x));
  for (const n of ns) {
    const last = Array.from({ length: +n }, (_, i) => mine.filter((r) => r[3] === `lv=1:${i + 1}/${n}`).at(-1));
    if (last.every((r) => r && r[5] === "ALL PASS")) return `レベル1の ${n} part（${last.at(-1)![0]}）`;
  }
  return null;
}
for (const t of tips) {
  const c = contract(t);
  if (c) console.error(`carry: 枝 ${short(t)} の契約 = ${c}`);
  else no.push(`枝の先端 ${short(t)} に、clean な木の枝の契約の ALL PASS の記録が無い（gates-runs.tsv）`);
}
// 3・4
const merged = new Set<string>();
const conflict = new Set<string>();
if (no.length === 0) {
  for (const c of lines(git("rev-list", "--first-parent", `${base}..${head}`))) {
    const ps = git("rev-list", "--parents", "-n", "1", c).split(" ").slice(1);
    if (ps.length > 2) { no.push(`${short(c)} は3つ以上の親を持つ merge`); continue; }
    if (ps.length === 2) {
      if (!tips.includes(ps[1])) { no.push(`${short(c)} は枝の先端でないコミット ${short(ps[1])} を merge している`); continue; }
      merged.add(ps[1]);
      for (const p of lines(git("show", "--remerge-diff", "--format=", "--name-only", c))) if (!inRegen(p)) conflict.add(p);
      continue;
    }
    const out = lines(git("diff-tree", "--no-commit-id", "--name-only", "-r", c)).filter((p) => !inRegen(p));
    if (out.length) no.push(`${short(c)} は merge でなく、@regen の外を変える: ${out.slice(0, 5).join(" ")}${out.length > 5 ? " …" : ""}`);
  }
  for (const t of tips) if (!merged.has(t)) no.push(`枝の先端 ${short(t)} が first-parent の列で merge されていない`);
}
if (no.length) { for (const r of no) console.log(`NOCARRY ${r}`); process.exit(1); }

// 5
const orderOf = (t: string) => {
  const o = /^ORDER=\(([^)]*)\)/m.exec(git("show", `${t}:scripts/gates.sh`));
  return new Set(o ? o[1].trim().split(/\s+/) : []);
};
const orders = tips.map(orderOf);
const branchSet = lines(execFileSync(path.join(ROOT, "scripts/gates.sh"), ["--level", "1", "--list"], { cwd: ROOT, encoding: "utf8" }));
const always = new Set([...node(path.join(ROOT, "scripts/gatememo.ts"), "place", "always"), ...node(path.join(ROOT, "scripts/gatememo.ts"), "place", "lines")]);
let gates = branchSet.filter((g) => orders.every((o) => o.has(g)) && !always.has(g));
for (const g of branchSet) if (!gates.includes(g)) console.error(`carry: ${g} は持ち越さない（ゲートの無い枝がある）`);
if (conflict.size) {
  const cs = [...conflict];
  console.error(`carry: merge の衝突の解決が @regen の外を変えた: ${cs.join(" ")}`);
  const kept: string[] = [];
  for (const g of gates) {
    const cov = node(path.join(ROOT, "scripts/gatememo.ts"), "cover", g);
    const p = cs.find((c) => cov.some((q) => under(c, q)));
    if (p) console.error(`carry: ${g} は持ち越さない（衝突の解決 ${p} が鍵に入る）`); else kept.push(g);
    // 共通の成分に当たれば全部外れるので、最初のゲートで分かる
    if (p && kept.length === 0 && cov.some((q) => ["src/compiler", "src/std", "scripts/gates.sh"].includes(q) && under(p, q))) {
      console.log(`NOCARRY merge の衝突の解決が全ゲートの鍵（共通の成分）に当たる: ${p}`);
      process.exit(1);
    }
  }
  if (kept.length === 0) { console.log(`NOCARRY merge の衝突の解決が全ゲートの鍵に当たる: ${cs.slice(0, 5).join(" ")}`); process.exit(1); }
  gates = kept;
}
for (const g of gates) console.log(`CARRY ${g}`);
