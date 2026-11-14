// gatememo（ゲートの高速化便 R1 — report-1219 / 1221）: ゲートの結果の記録。鍵(g) = 共通の成分 ‖ 宣言(g)（scripts/gatedeps.txt）の内容ハッシュ。
// 鍵が前回の PASS の記録と一致すれば HIT（scripts/gates.sh --memo が走らせずに飛ばす）。鍵は静的な宣言だけから導く — 実行時の観測（strace 等）は
// 宣言の監査の道具で、鍵の経路には入れない（ナビ決定2026-10-27: openatがio_uringに載るとsyscallの観測は黙って欠ける）。
//
//   node scripts/gatememo.ts check <gate>…        鍵を計算してHIT / MISSを1行ずつ（MISSは最初にずれた成分を特定）。計算した成分はpendingへ
//   node scripts/gatememo.ts record <gate> <秒> <ログ>  PASS の後に呼ぶ: pending を記録へ（ログに環境の SKIP があれば記録しない）
//   node scripts/gatememo.ts lint                  宣言の古び: スクリプトの本文から抽出したパスが宣言に覆われていなければ特定（静的・実行しない）
//   node scripts/gatememo.ts selftest              M1 鍵の感度: 宣言・共通の各成分の中の 1 ファイルを 1 バイト変えた上書きで成分のハッシュが変わること + lint
//                                                  + 木をまたぐ鍵（別の場所のコピーで同じ鍵・@localは違う鍵・コピーの1バイトの変更で違う鍵）
//   node scripts/gatememo.ts keys [gate…]         鍵を 1 行ずつ（pending に書かない）
//   node scripts/gatememo.ts extract [gate…]       宣言の下書き（抽出 + ディレクトリ単位の丸め）
//
// 成分のハッシュはファイルの中身（sha256）から。stat の表（パス → size・mtime・ino・ctime → sha256）で、変わっていないファイルは読まない。
// ディレクトリは配下の全ファイル（相対パス + 中身）を並べたハッシュ。無いパスは「absent」の値で鍵に入る。
// 格納場所 = 記録 <gate>/<鍵>.jsonとverified.jsonは <gitの共通ディレクトリ>/gatememo/（worktreeの間で共有）・pending/<gate>.jsonとstatの表hstat.jsonは
// scripts/.gatecache/memo/（木ごと）。書きは tmp + rename
import { createHash } from "node:crypto";
import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as os from "node:os";
import * as path from "node:path";

const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
// 木ごとの格納場所（pending — checkとrecordの受け渡し・statの表 — inoを含む）。同時に走る2つのworktreeの間で混ざらないように共有しない
const MEMO = path.join(ROOT, "scripts/.gatecache/memo");
// 記録の格納場所（記録・抜き打ちの日時）: gitの共通ディレクトリの下 = worktreeの間で共有（branchの上で通した記録がfast-forwardの後のmainで当たる）。
// gitの外（gatemutのコピーの木など）では木ごとの格納場所。GATEMEMO_SHAREDで差し替え
const SHARED = process.env.GATEMEMO_SHARED || sharedDir() || MEMO;
function sharedDir(): string | null {
    try {
        const d = execFileSync("git", ["-C", ROOT, "rev-parse", "--path-format=absolute", "--git-common-dir"], { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] }).trim();
        return d ? path.join(d, "gatememo") : null;
    } catch { return null; }
}
const DEPS = path.join(ROOT, "scripts/gatedeps.txt");
// ディレクトリの再帰で降りない名前（ビルドの出力・ゲートの格納場所・Leanのビルド — sober-checkは共通の成分で見る）。
// out = 実行の残り（例を examples/ を cwd に実行したときの examples/out など — ルートの .gitignore の out/）。木ごとに違い、入力ではない
const SKIPDIR = new Set([".git", ".gatecache", ".lake", "zig-out", ".zig-cache", "node_modules", "out"]);
// 宣言のないゲートの既定（保守 — 宣言の無さが偽緑に倒れない向き）
const DEFAULT_DEPS = ["examples", "testdata", "bench", "lean", "docs", "scripts", "README.md", "README.ja.md", "bootstrap"];
// 入口のスクリプト（既定は scripts/<gate>.sh — gates.sh の run_gate の case と揃える）
const ENTRY: Record<string, string[]> = {
    zigtest: [],
    toolcheck: [],
    checksplit: ["scripts/checkverdict.sh"],
    hermetic_zig: ["scripts/hermetic.sh"],
    obs_zig: ["scripts/obs.sh"],
    fnhash: ["scripts/rebuildbench.sh"],
    tyhash: ["scripts/rebuildbench.sh"],
    incrcheck_self: ["scripts/incrcheck.sh"],
    incrcheck_ex: ["scripts/incrcheck.sh"],
};
const entryOf = (g: string): string[] => ENTRY[g] ?? [`scripts/${g}.sh`];

// ── ハッシュ ──

type Stat = [number, number, number, number, string]; // size・mtimeMs・ino・ctimeMs・sha256
let hstat: Record<string, Stat> = {};
let hstatDirty = false;
const hstatFile = path.join(MEMO, "hstat.json");
function loadHstat() {
    try { hstat = JSON.parse(fs.readFileSync(hstatFile, "utf8")); } catch { hstat = {}; }
}
function saveHstat() {
    if (!hstatDirty) return;
    writeAtomic(hstatFile, JSON.stringify(hstat));
}
function writeAtomic(f: string, s: string) {
    fs.mkdirSync(path.dirname(f), { recursive: true });
    const t = `${f}.tmp${process.pid}`;
    fs.writeFileSync(t, s);
    fs.renameSync(t, f);
}
const sha = (b: Buffer | string) => createHash("sha256").update(b).digest("hex");

// override: 相対パス → 中身（M1 の「1 バイト変えた」上書き）
function fileHash(rel: string, override?: Map<string, Buffer>): string {
    const o = override?.get(rel);
    if (o) return sha(o);
    const abs = path.join(ROOT, rel);
    const st = fs.statSync(abs);
    const k: Stat = [st.size, st.mtimeMs, st.ino, st.ctimeMs, ""];
    const c = hstat[rel];
    if (c && c[0] === k[0] && c[1] === k[1] && c[2] === k[2] && c[3] === k[3]) return c[4];
    k[4] = sha(fs.readFileSync(abs));
    hstat[rel] = k;
    hstatDirty = true;
    return k[4];
}

// 成分（ファイルかディレクトリ）の配下のファイルの相対パス（並べた順）
// パスの並び = 区切りごとの名前の順（下の walk と同じ順 — git のモードと走査のモードで同じ並びにする）
function segCmp(a: string, b: string): number {
    const x = a.split("/"), y = b.split("/");
    for (let i = 0; i < Math.min(x.length, y.length); i++) if (x[i] !== y[i]) return x[i] < y[i] ? -1 : 1;
    return x.length - y.length;
}
// 木の中で数えるファイル = git が追跡しているファイル + まだ add していない新しいファイル（.gitignore で無視されたものを除く）。
// 無視された生成物（stage2・Lean の道具など）は、宣言や共通の成分にファイルとして明示したものだけを数える（filesOf のファイルの枝）。
// gitの外（gatemutのコピーなど）ではnull — ディレクトリの走査に戻る。GATEMEMO_GIT_DIR = 別の場所の木に元の木のgitを使うオプション（selftestのコピー）
let gitFiles: string[] | null | undefined;
function gitList(): string[] | null {
    if (gitFiles !== undefined) return gitFiles;
    try {
        const gd = process.env.GATEMEMO_GIT_DIR;
        const args = gd ? ["--git-dir", gd, "--work-tree", ROOT] : ["-C", ROOT];
        const out = execFileSync("git", [...args, "ls-files", "-z", "--cached", "--others", "--exclude-standard"], { cwd: ROOT, maxBuffer: 1 << 28, stdio: ["ignore", "pipe", "ignore"] });
        gitFiles = out.toString("utf8").split("\0").filter(Boolean).sort(segCmp);
    } catch { gitFiles = null; }
    return gitFiles;
}

function filesOf(rel: string): string[] | null {
    const abs = path.join(ROOT, rel);
    let st: fs.Stats;
    try { st = fs.lstatSync(abs); } catch { return null; }
    if (st.isSymbolicLink()) return [rel];
    if (!st.isDirectory()) return [rel];
    const gl = gitList();
    if (gl) {
        // 追跡しているのに消したファイル（--cached に残る）は数えない（無い = 鍵から消える）
        const pre = `${rel}/`;
        return gl.filter((f) => f.startsWith(pre) && (() => { try { fs.lstatSync(path.join(ROOT, f)); return true; } catch { return false; } })());
    }
    const out: string[] = [];
    const walk = (r: string) => {
        for (const e of fs.readdirSync(path.join(ROOT, r), { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0))) {
            const c = `${r}/${e.name}`;
            if (e.isDirectory()) { if (!SKIPDIR.has(e.name)) walk(c); }
            else out.push(c);
        }
    };
    walk(rel);
    return out;
}

const compMemo = new Map<string, string>(); // 1 回の実行の中の成分のハッシュ（上書きなしのときだけ — 共通の成分はゲートごとに数え直さない）
function compHash(rel: string, override?: Map<string, Buffer>): string {
    if (!override) {
        let v = compMemo.get(rel);
        if (v === undefined) { v = compHash1(rel); compMemo.set(rel, v); }
        return v;
    }
    return compHash1(rel, override);
}
function compHash1(rel: string, override?: Map<string, Buffer>): string {
    const fl = filesOf(rel);
    if (fl === null) return "absent";
    const h = createHash("sha256");
    for (const f of fl) {
        let v: string;
        const abs = path.join(ROOT, f);
        const ls = fs.lstatSync(abs);
        v = ls.isSymbolicLink() ? `link:${fs.readlinkSync(abs)}` : fileHash(f, override);
        h.update(`${f}\0${v}\n`);
    }
    return h.digest("hex");
}

// ── 宣言 ──

type Deps = { paths: Map<string, string[]>; nondet: Set<string>; always: Set<string>; local: Set<string>; optional: Set<string> };
function loadDeps(): Deps {
    const d: Deps = { paths: new Map(), nondet: new Set(), always: new Set(), local: new Set(), optional: new Set() };
    for (const raw of fs.readFileSync(DEPS, "utf8").split("\n")) {
        const line = raw.replace(/#.*/, "").trim();
        if (!line) continue;
        const i = line.indexOf(":");
        if (i < 0) throw new Error(`gatedeps.txt: no colon: ${raw}`);
        const k = line.slice(0, i).trim();
        const v = line.slice(i + 1).trim().split(/\s+/).filter(Boolean);
        if (k === "@nondet") v.forEach((g) => d.nondet.add(g));
        else if (k === "@always") v.forEach((g) => d.always.add(g));
        else if (k === "@local") v.forEach((g) => d.local.add(g));
        // ?<パス> = 無くてもよい生成物（木によって有無が違う — out/bench の入力のデータなど）: 有れば中身、無ければ absent で鍵に入る。lint の存在の検査をしない
        else { v.filter((p) => p.startsWith("?")).forEach((p) => d.optional.add(p.slice(1))); d.paths.set(k, v.map((p) => p.replace(/^\?/, ""))); }
    }
    return d;
}

// 共通の成分（全ゲート）: 名前 → [種類, 値]。種類 f = パスの内容・s = 文字列
let commonMemo: [string, string][] | undefined;
function commonComps(): [string, string][] {
    if (!commonMemo) commonMemo = commonComps1();
    return commonMemo;
}
function commonComps1(): [string, string][] {
    const c: [string, string][] = [];
    for (const p of ["scripts/gates.sh", "scripts/gatememo.ts", "scripts/gatedeps.txt"]) c.push([p, compHash(p)]);
    for (const p of gatelibClosure()) c.push([p, compHash(p)]);
    // stage2 = コンパイラと std のソース（中身）+ コンパイラの ELF の中身。out/stage2/.key は使わない — stage2.sh は入力の stat が変わらなければ
    // キーを計算し直さないので、キーの形式を変えた後も古い形式（絶対パス入り）のまま残る。ELF は木が違っても同じ入力ならバイト一致
    for (const p of ["src/compiler", "src/std", "out/stage2/sober2", "bin/sober", "src/stage1/zig-out/bin/sober", "lean/.lake/build/bin/sober-check"]) c.push([p, compHash(p)]);
    c.push(["#tools", process.env.GATEMEMO_TKEY ?? "none"]);
    const env = Object.keys(process.env).filter((k) => /^(SOBER|GATES|STAGES|SELFHOST)_/.test(k) || k === "PERF" || k === "STAGE1" || k === "STAGE2").sort();
    // 値の中の木のルートは <root> に置き換える（SOBER・STAGE1 などは木の中の絶対パス — worktree が違っても同じ内容なら同じ鍵）
    const unroot = (v: string) => v.split(`${ROOT}/`).join("<root>/");
    c.push(["#env", sha(env.map((k) => `${k}=${unroot(process.env[k] ?? "")}`).join("\n"))]);
    c.push(["#versions", versions()]);
    return c;
}
let versionsMemo: string | undefined;
function versions(): string {
    if (versionsMemo) return versionsMemo;
    const run = (cmd: string, args: string[]) => {
        try { return execFileSync(cmd, args, { encoding: "utf8", timeout: 10000, stdio: ["ignore", "pipe", "ignore"] }).trim(); } catch { return "none"; }
    };
    versionsMemo = sha([process.version, run("zig", ["version"]), run("go", ["version"]), run("uname", ["-r"])].join("\n"));
    return versionsMemo;
}

// gatelib.shとそのインターフェースが読むファイル（scripts/frozen・ブートストラップチェーン・α 改名・スロットの照合）— 全ゲートがsourceするので共通
// gatelib.shが読むデータ（frozenの一覧が指すexamples / testdata）は共通にせず、APIを呼ぶゲートの宣言へ（extractedのHELPERS）
function gatelibClosure(): string[] {
    return closure(["scripts/gatelib.sh"]).filter((p) => p === "scripts/gatelib.sh" || p.startsWith("scripts/") || p === "bootstrap");
}
// gatelibのAPI → そのAPIが読む一覧（一覧の本文が指すデータのパスはゲートの宣言に入る）
const HELPERS: Record<string, string[]> = {
    frozen_list: ["scripts/frozen"], frozen_lower: ["scripts/frozen"], obs_frozen: ["scripts/frozen"], zig_frozen: ["scripts/frozen"],
    check_retired: ["scripts/frozen"], tool_retired: ["scripts/frozen"],
};

function gateComps(g: string, d: Deps): [string, string][] {
    const decl = (d.paths.get(g) ?? DEFAULT_DEPS).filter((p) => !p.startsWith("~"));
    const own = [...new Set([...entryOf(g), ...decl])];
    const c = commonComps().concat(own.map((p) => [p, compHash(p)] as [string, string]));
    // @local = 結果が木の場所に依るゲート（実行時の命令数・RSS を上限値と比べる — パスの長さで値が動く）: 鍵に木のルートを入れて、記録をその木でだけ当てる
    if (d.local.has(g)) c.push(["#root", ROOT]);
    return c;
}
const keyOf = (comps: [string, string][]) => sha(comps.map(([k, v]) => `${k}=${v}`).join("\n"));

// ── 静的抽出（スクリプトの本文 → パス）──

const PATHRE = /(?:^|[^A-Za-z0-9_.-])((?:examples|testdata|bench|lean|docs|bootstrap|scripts|src\/stage1|\.pair)(?:\/[A-Za-z0-9_.-]+)*\/?|README(?:\.ja)?\.md)/g;
const exists = (rel: string) => fs.existsSync(path.join(ROOT, rel));
const isFile = (rel: string) => { try { return fs.statSync(path.join(ROOT, rel)).isFile(); } catch { return false; } };

// 1 つの言及をディレクトリ単位に丸める（examples・lean・bootstrap・src/stage1 は丸ごと・testdata / bench / docs は 1 段目・scripts はファイル）
function coarsen(m: string): string | null {
    m = m.replace(/\/+$/, "");
    const s = m.split("/");
    switch (s[0]) {
        case "examples": case "lean": case "bootstrap": return s[0];
        case "src": return "src/stage1";
        case "testdata": case "bench": case "docs": {
            if (s.length === 1) return s[0];
            const one = `${s[0]}/${s[1]}`;
            return exists(one) ? one : s[0];
        }
        case ".pair": return s.length > 1 && exists(`${s[0]}/${s[1]}`) ? `${s[0]}/${s[1]}` : null;
        case "scripts": {
            if (s[1] === ".gatecache") return null;
            // 存在する最長の前置
            for (let k = s.length; k >= 2; k--) { const p = s.slice(0, k).join("/"); if (exists(p)) return p; }
            return "scripts";
        }
        default: return m; // README
    }
}

// 本文の言及（コメントの行を除く）→ 丸めたパス
function mentions(rel: string): string[] {
    let txt: string;
    try { txt = fs.readFileSync(path.join(ROOT, rel), "utf8"); } catch { return []; }
    const out = new Set<string>();
    for (const line of txt.split("\n")) {
        const t = line.trimStart();
        if (t.startsWith("#") || t.startsWith("//")) continue;
        for (const m of line.matchAll(PATHRE)) { const c = coarsen(m[1]); if (c) out.add(c); }
        // TS の相対 import（scripts/ の中）
        for (const m of line.matchAll(/from\s+["']\.\/([A-Za-z0-9_.-]+\.ts)["']/g)) out.add(`scripts/${m[1]}`);
    }
    return [...out];
}

// 入口からscripts/ の中のファイル（.sh・.ts・.list・.txt）を辿った言及の推移的な依存。gatelib.shは共通なので辿らない（selfscan以外）
function closure(entry: string[]): string[] {
    const seen = new Set<string>();
    const todo = [...entry];
    while (todo.length) {
        const p = todo.pop()!;
        if (seen.has(p)) continue;
        seen.add(p);
        if (p.startsWith("scripts/") && !isFile(p) && exists(p)) { (filesOf(p) ?? []).forEach((f) => todo.push(f)); continue; }
        if (!p.startsWith("scripts/") || !isFile(p) || !/\.(sh|ts|list|txt)$/.test(p)) continue;
        if (p === "scripts/gatelib.sh" && !entry.includes(p)) continue;
        for (const m of mentions(p)) if (!seen.has(m)) todo.push(m);
    }
    for (const e of entry) if (!isFile(e)) seen.delete(e);
    return [...seen].filter((p) => p !== "scripts/gates.sh" && p !== "scripts/gatelib.sh" || entry.includes(p)).sort();
}

const covered = (p: string, decl: string[]) => decl.some((d) => p === d || p.startsWith(`${d}/`));

function extracted(g: string): string[] {
    const common = new Set(gatelibClosure());
    const cl = closure(entryOf(g));
    const extra = new Set<string>();
    for (const f of cl.filter(isFile)) {
        let txt = "";
        try { txt = fs.readFileSync(path.join(ROOT, f), "utf8"); } catch {}
        for (const [h, lists] of Object.entries(HELPERS)) if (new RegExp(`\\b${h}\\b`).test(txt)) lists.forEach((l) => extra.add(l));
    }
    const all = new Set([...cl, ...closure([...extra])]);
    return [...all].filter((p) => !common.has(p) && !entryOf(g).includes(p)).sort();
}

// ── ゲートの一覧（gates.sh の ORDER）──

function allGates(): string[] {
    const m = fs.readFileSync(path.join(ROOT, "scripts/gates.sh"), "utf8").match(/^ORDER=\((.*)\)$/m);
    if (!m) throw new Error("gates.sh: ORDER not found");
    return m[1].split(/\s+/).filter(Boolean);
}

// ── 記録 ──

type Rec = { key: string; comps: [string, string][]; commit: string; time: string; secs: number; last: string; root?: string };
// 記録は鍵ごとに 1 ファイル（memo/<gate>/<鍵>.json）・ゲートごとに直近 KEEP 本（mtime で LRU — 当たった記録は mtime を更新）。
// 編集を戻した木・ブランチや worktree の切り替えでも前の記録に当たる（R2 ①）
const KEEP = 16; // 共有の格納場所で2つの木の分
const recDir = (g: string) => path.join(SHARED, g);
const recFile = (g: string, key: string) => path.join(recDir(g), `${key}.json`);
const pendFile = (g: string) => path.join(MEMO, "pending", `${g}.json`);
function readRec(g: string, key: string): Rec | null {
    try { return JSON.parse(fs.readFileSync(recFile(g, key), "utf8")); } catch { return null; }
}
function recs(g: string): string[] { // 新しい順の記録のファイル
    let fl: string[] = [];
    try { fl = fs.readdirSync(recDir(g)).filter((f) => f.endsWith(".json")).map((f) => path.join(recDir(g), f)); } catch {}
    return fl.map((f) => [f, fs.statSync(f).mtimeMs] as [string, number]).sort((a, b) => b[1] - a[1]).map(([f]) => f);
}

function lint(d: Deps): string[] {
    const bad: string[] = [];
    for (const g of allGates()) {
        const decl = d.paths.get(g);
        if (!decl) { bad.push(`${g}: no declaration (default = conservative)`); continue; }
        for (const p of decl) if (!d.optional.has(p) && !exists(p.replace(/^~/, ""))) bad.push(`${g}: declared path does not exist: ${p}`);
        if (d.always.has(g)) continue; // 記録しない札は宣言を鍵に使わない
        // ~<パス> = 免除（配下の言及も）: 本文はそのパスを言及するが、読むのはその一部だけ（監査で採りM2で確認した）— 鍵には入れない
        const ex = extracted(g);
        for (const p of ex) if (!covered(p, decl) && !covered(p, decl.filter((x) => x.startsWith("~")).map((x) => x.slice(1)))) bad.push(`${g}: mentioned but not declared: ${p}`);
        // 上限値の表（bench/ratchet.txt）と比べるゲートは実行時の値を測る — 木の場所で値が動くので @local（記録を木の間で共有しない）。
        // 見るのは入口のスクリプトの本文の言及だけ（推移的な依存はscripts/ の言及で広がりすぎる）
        if (entryOf(g).some((e) => mentions(e).includes(RATCHET)) && !d.local.has(g)) bad.push(`${g}: reads ${RATCHET} but is not @local (its result can depend on the tree's location)`);
    }
    for (const g of d.paths.keys()) if (!allGates().includes(g)) bad.push(`${g}: declared but not a gate`);
    return bad;
}

const RATCHET = "bench/ratchet.txt";

// 全ゲートの鍵（pendingに書かない — 木をまたぐ鍵の照合のインターフェース）
function cmdKeys(gates: string[]) {
    const d = loadDeps();
    for (const g of gates.length ? gates : allGates()) console.log(`${g} ${keyOf(gateComps(g, d))}`);
    saveHstat();
}

// 木をまたぐ鍵の照合: 木を別の場所にコピーし（ハードリンク）、コピーで計算した鍵が、@local以外は元の木と同じ・@localは違うこと。
// コピーで宣言の中の1ファイルを1バイト変えると、そのゲートの鍵が変わること。環境の値の中の木のルートはコピーのルートに読み替えて渡す（木ごとの環境と同じ形）
function crossTree(d: Deps): number {
    let fail = 0;
    const t = fs.mkdtempSync(path.join(os.tmpdir(), "gatememo-xtree-"));
    let gitDir = "";
    try { gitDir = execFileSync("git", ["-C", ROOT, "rev-parse", "--absolute-git-dir"], { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] }).trim(); } catch {}
    const keysIn = (root: string, gates: string[]): Map<string, string> => {
        const env: Record<string, string> = {};
        for (const [k, v] of Object.entries(process.env)) if (v !== undefined) env[k] = v.split(`${ROOT}/`).join(`${root}/`);
        env.GATEMEMO_SHARED = path.join(t, ".shared");
        // コピーには .gitが無い — 元の木のgitで、コピーの作業ツリーを数える（追跡しているファイルの一覧は元の木と同じ・addしていないファイルはコピーで探す）
        if (root !== ROOT && gitDir) env.GATEMEMO_GIT_DIR = gitDir;
        const out = execFileSync("node", ["--experimental-strip-types", path.join(root, "scripts/gatememo.ts"), "keys", ...gates], { encoding: "utf8", env: { ...env, NODE_NO_WARNINGS: "1" }, maxBuffer: 1 << 26 });
        return new Map(out.trim().split("\n").map((l) => l.split(" ") as [string, string]));
    };
    try {
        const c = path.join(t, "tree");
        execFileSync("rsync", ["-a", `--link-dest=${ROOT}/`, "--exclude", "/.git", "--exclude", "/.pair", "--exclude", "/out/bench", "--exclude", "/out/inst",
            "--exclude", "/out/rust", "--exclude", "/out/skym", "--exclude", "/scripts/.gatecache", `${ROOT}/`, `${c}/`]);
        // 無くてもよい生成物（宣言の ?<パス>）は、有るか無いかでキーが変わる。元の木に有るものはコピーにも置き、同じ中身の木として比べる
        for (const p of d.optional) {
            const src = path.join(ROOT, p), dst = path.join(c, p);
            if (!fs.existsSync(src) || fs.existsSync(dst)) continue;
            fs.mkdirSync(path.dirname(dst), { recursive: true });
            try { fs.linkSync(src, dst); } catch { fs.copyFileSync(src, dst); }
        }
        // 木ごとに違ってよいもの（2026-11-14の検証で記録が当たらなかった2つの原因）をコピーの側だけ変える: 実行の残り（.gitignoreのout/ —
        // examples/out）を足す・stage2 の .key を別の中身にする（キーの形式を変えた後に作り直されない .key）。どちらも鍵を変えてはいけない
        fs.mkdirSync(path.join(c, "examples/out"), { recursive: true });
        fs.writeFileSync(path.join(c, "examples/out/gatememo-xtree.tmp"), "leftover of a run\n");
        // .gitignore で無視された生成物（ディレクトリの名前では除けないもの — bench/httparena/server）も数えない
        if (gitDir && fs.existsSync(path.join(c, "bench/httparena"))) {
            const sv = path.join(c, "bench/httparena/server");
            if (fs.existsSync(sv)) fs.unlinkSync(sv);
            fs.writeFileSync(sv, "an ignored build output\n");
        }
        const kf = path.join(c, "out/stage2/.key");
        if (fs.existsSync(kf)) fs.unlinkSync(kf);
        fs.writeFileSync(kf, "a key file in another format\n");
        const gates = allGates().filter((g) => !d.always.has(g));
        const a = keysIn(ROOT, gates), b = keysIn(c, gates);
        let same = 0;
        for (const g of gates) {
            const eq = a.get(g) === b.get(g);
            if (d.local.has(g) ? eq : !eq) { console.log(`FAIL: cross-tree key of ${g} is ${eq ? "the same (but @local)" : "different (same content)"}`); fail++; }
            else if (eq) same++;
        }
        // 1バイトの変更: @localでない最初のゲートの宣言の最初の成分の真ん中のファイル（コピーはハードリンク — 消してから書き、元の木を変えない）
        const g = gates.find((x) => !d.local.has(x))!;
        const comp = (d.paths.get(g) ?? DEFAULT_DEPS).filter((p) => !p.startsWith("~"))[0];
        const fl = (filesOf(comp) ?? []).filter((f) => !fs.lstatSync(path.join(ROOT, f)).isSymbolicLink());
        const f = fl[Math.floor(fl.length / 2)];
        const buf = Buffer.from(fs.readFileSync(path.join(c, f)));
        if (buf.length > 0) buf[buf.length >> 1] ^= 1;
        fs.unlinkSync(path.join(c, f));
        fs.writeFileSync(path.join(c, f), buf.length > 0 ? buf : Buffer.from([1]));
        const m = keysIn(c, [g]);
        if (m.get(g) === b.get(g)) { console.log(`FAIL: cross-tree: a 1-byte change in ${f} does not change the key of ${g}`); fail++; }
        // add していない新しいファイル（.gitignore に当たらない）は数える: examples を宣言するゲートの鍵が変わること
        let added = "";
        if (gitDir) {
            const ge = gates.find((x) => !d.local.has(x) && (d.paths.get(x) ?? DEFAULT_DEPS).includes("examples"));
            if (ge) {
                const before = keysIn(c, [ge]).get(ge);
                fs.writeFileSync(path.join(c, "examples/gatememo-xtree-new.sober"), "package main\n");
                const after = keysIn(c, [ge]).get(ge);
                if (before === after) { console.log(`FAIL: cross-tree: a new file not yet added (examples/gatememo-xtree-new.sober) does not change the key of ${ge}`); fail++; }
                added = `, a new file not yet added changes ${ge}`;
            }
        }
        console.log(`gatememo: cross-tree keys — ${same} gates same in a copy at another path (with ignored files examples/out/… and bench/httparena/server, and another .key), ${gates.filter((x) => d.local.has(x)).length} @local differ, 1-byte change in ${f} changes ${g}${added}`);
    } finally {
        fs.rmSync(t, { recursive: true, force: true });
    }
    return fail;
}

function cmdCheck(gates: string[]) {
    const d = loadDeps();
    const stale = new Set(lint(d).map((l) => l.split(":")[0]));
    for (const g of gates) {
        let comps: [string, string][];
        try { comps = gateComps(g, d); } catch (e) { console.log(`MISS ${g} key error: ${(e as Error).message}`); continue; }
        const key = keyOf(comps);
        writeAtomic(pendFile(g), JSON.stringify({ key, comps }));
        const nd = d.nondet.has(g) ? " [非決定の札]" : "";
        if (d.always.has(g)) { console.log(`MISS ${g} always (@always)`); continue; }
        if (stale.has(g)) { console.log(`MISS ${g} declaration is stale (gatememo lint)`); continue; }
        const h = readRec(g, key);
        if (h) {
            const t = new Date();
            fs.utimesSync(recFile(g, key), t, t);
            console.log(`HIT ${g} ${key.slice(0, 8)} ${h.commit.slice(0, 8)} ${h.time}${nd} | ${h.last}`);
            continue;
        }
        const newest = recs(g)[0];
        if (!newest) { console.log(`MISS ${g} no record`); continue; }
        const r: Rec = JSON.parse(fs.readFileSync(newest, "utf8"));
        const old = new Map(r.comps);
        const now = new Map(comps);
        const diff = [...new Set([...old.keys(), ...now.keys()])].filter((k) => old.get(k) !== now.get(k));
        console.log(`MISS ${g} changed: ${diff.slice(0, 3).join(" ")}${diff.length > 3 ? ` (+${diff.length - 3})` : ""}`);
    }
    saveHstat();
}

function cmdRecord(g: string, secs: string, log: string) {
    const txt = fs.readFileSync(log, "utf8");
    // ゲート自身の環境の SKIP（unshare なし・perf なし 等）は記録しない。中の差分スキップ（inputs unchanged）は記録してよい
    const envSkip = txt.split("\n").some((l) => /\bSKIP\b/.test(l) && !/SKIP: inputs unchanged since the last pass/.test(l));
    if (envSkip) { console.log(`gatememo: ${g} not recorded (environment SKIP in the log)`); return; }
    const p = JSON.parse(fs.readFileSync(pendFile(g), "utf8"));
    let commit = "none";
    try { commit = execFileSync("git", ["-C", ROOT, "--no-optional-locks", "rev-parse", "HEAD"], { encoding: "utf8" }).trim(); } catch {}
    const last = txt.split("\n").filter((l) => l.trim() && !l.startsWith("ok")).pop()?.slice(0, 110) ?? "";
    const rec: Rec = { key: p.key, comps: p.comps, commit, time: new Date().toLocaleString("sv").slice(0, 16), secs: Number(secs), last, root: ROOT };
    writeAtomic(recFile(g, p.key), JSON.stringify(rec));
    for (const f of recs(g).slice(KEEP)) fs.rmSync(f, { force: true });
}

// M1: 各成分（パスの成分）の中の 1 ファイルを 1 バイト変えた上書きで、成分のハッシュが変わること
function cmdSelftest(): number {
    const d = loadDeps();
    let fail = 0, n = 0;
    const bad = lint(d);
    for (const b of bad) console.log(`FAIL: lint: ${b}`);
    fail += bad.length;
    const comps = new Set<string>();
    for (const g of allGates()) for (const p of [...entryOf(g), ...(d.paths.get(g) ?? DEFAULT_DEPS)]) if (!p.startsWith("~") && !(d.optional.has(p) && !exists(p))) comps.add(p);
    for (const p of commonComps().map(([k]) => k)) if (!p.startsWith("#")) comps.add(p);
    for (const p of [...comps].sort()) {
        const fl = filesOf(p);
        if (fl === null) { console.log(`FAIL: component ${p} does not exist`); fail++; continue; }
        if (fl.length === 0) { console.log(`FAIL: component ${p} has no file`); fail++; continue; }
        // 選ぶファイル = 真ん中（決定的）・位置 = 真ん中のバイト
        const f = fl[Math.floor(fl.length / 2)];
        const abs = path.join(ROOT, f);
        if (fs.lstatSync(abs).isSymbolicLink()) continue;
        const buf = Buffer.from(fs.readFileSync(abs));
        const mut = buf.length === 0 ? Buffer.from([1]) : Buffer.from(buf); // 空のファイルは 1 バイト足した形
        if (buf.length > 0) mut[buf.length >> 1] ^= 1;
        const h0 = compHash(p);
        const h1 = compHash(p, new Map([[f, mut]]));
        n++;
        if (h0 === h1) { console.log(`FAIL: 1-byte change in ${f} does not change the component ${p}`); fail++; }
    }
    // 鍵の感度: 成分が変われば鍵が変わる（共通の成分 1 つを変えた形）
    const g0 = allGates()[0];
    const c0 = gateComps(g0, d);
    const c1 = c0.map(([k, v], i) => [k, i === 0 ? `${v}x` : v] as [string, string]);
    if (keyOf(c0) === keyOf(c1)) { console.log("FAIL: a component change does not change the key"); fail++; }
    if (process.env.GATEMEMO_NO_XTREE !== "1") fail += crossTree(d);
    saveHstat();
    console.log(`gatememo: ${n} components × 1-byte change, ${allGates().length} gates linted, fail=${fail}`);
    return fail;
}

// 鍵が覆うパス（共通の成分 + 入口 + 宣言）
function coverOf(g: string): string[] {
    const d = loadDeps();
    return [...new Set([...commonComps().map(([k]) => k).filter((k) => !k.startsWith("#")), ...entryOf(g), ...(d.paths.get(g) ?? DEFAULT_DEPS).filter((p) => !p.startsWith("~"))])];
}
// M2 の母集団（鍵が覆わない入力の候補）: これらのディレクトリの下のファイルのうち、coverOf の外
const POOL = ["examples", "testdata", "bench", "lean", "docs", "scripts", "README.md", "README.ja.md"];
const MARK = "\n@@gatememo-M2@@\n";
// M2: コピーした木 <root> で、ゲートgの鍵の外のファイル全部の末尾にマークを足す（1回の走りで「鍵の外の全部が壊れても判定が変わらない」を見る）
// + 並びのミューテーション（report-1223）: 鍵の外に置かれることになる各ディレクトリに新しいファイルを足す — glob / lsで拾う形（例題の *.sober・testdata/*/app）が
// 増えたファイルに反応すれば赤になる。置くのは `<dir>/gatememo-M2.sober` と `<dir>/gatememo-M2/app/main.sober` の2種類（中身はマーク）
const ADDED = ["gatememo-M2.sober", "gatememo-M2/app/main.sober"];
function cmdMutate(g: string, root: string) {
    const cov = coverOf(g);
    let n = 0;
    const dirs = new Set<string>();
    for (const top of POOL) for (const f of filesOf(top) ?? []) {
        if (f.startsWith("scripts/.gatecache/")) continue;
        for (let d = path.dirname(f); d !== "."; d = path.dirname(d)) dirs.add(d);
        if (covered(f, cov)) continue;
        const abs = path.join(root, f);
        try { if (fs.lstatSync(abs).isFile()) { fs.appendFileSync(abs, MARK); n++; } } catch {}
    }
    let m = 0;
    for (const d of [...dirs].sort()) for (const a of ADDED) {
        const f = `${d}/${a}`;
        if (covered(f, cov)) continue;
        const abs = path.join(root, f);
        fs.mkdirSync(path.dirname(abs), { recursive: true });
        fs.writeFileSync(abs, MARK);
        m++;
    }
    console.log(`gatemut: ${g}: ${n} files outside the key mutated, ${m} files added`);
}
// 監査（開発時だけ — 鍵には使わない）: strace -y の出力からROOTの中の読みを拾い、鍵が覆わないものを特定する + testdataの1段目の読みの一覧
const AUDIT_IGNORE = ["out/", "scripts/.gatecache/", "lean/.lake/", "src/compiler/", "src/std/", "src/stage1/", ".git/", "bin/", "node_modules/"];
function cmdAudit(g: string, traces: string[]) {
    const cov = coverOf(g);
    const reads = new Set<string>();
    for (const t of traces) for (const line of fs.readFileSync(t, "utf8").split("\n")) {
        const m = line.match(/^\d+\s+(\w+)\((?:(?:AT_FDCWD|\d+)<([^>]*)>, )?"([^"]*)"(.*)$/);
        if (!m) continue;
        const [, call, dir, p0, rest] = m;
        if (call === "openat" && /O_WRONLY|O_CREAT|O_TRUNC/.test(rest)) continue;
        if (/= -1 /.test(rest) && call !== "openat" && call !== "newfstatat" && call !== "access" && call !== "faccessat2") continue;
        const abs = p0.startsWith("/") ? p0 : dir ? path.join(dir, p0) : path.join(ROOT, p0);
        if (!abs.startsWith(ROOT + "/")) continue;
        const rel = path.relative(ROOT, path.normalize(abs));
        if (!rel || AUDIT_IGNORE.some((x) => rel.startsWith(x) || rel === x.slice(0, -1))) continue;
        reads.add(rel);
    }
    const unc = [...reads].filter((r) => !covered(r, cov)).sort();
    const td = [...new Set([...reads].filter((r) => r.startsWith("testdata/")).map((r) => r.split("/").slice(0, 2).join("/")))].sort();
    console.log(`audit ${g}: ${reads.size} reads in the tree, ${unc.length} outside the key`);
    for (const u of unc.slice(0, 40)) console.log(`  outside: ${u}`);
    console.log(`  testdata units read: ${td.join(" ")}`);
}

// 抜き打ち（R2 ③ — ナビ決定3）: HITのゲートから1本 — 記録の秒が予算以内・@nondetでない・最も長く検証されていないもの。
// 別の木で作られた記録に当たったゲートを先に選ぶ（記録の共有で起きうる偽の HIT — 木ごとの状態に依るゲート — に早く気づく）
// 検証した日時 = memo/verified.json（gates.shが走らせた後に `verified <gate>` で付ける）
const verFile = path.join(SHARED, "verified.json");
function cmdPick(budget: number, hits: string[]) {
    const d = loadDeps();
    let ver: Record<string, number> = {};
    try { ver = JSON.parse(fs.readFileSync(verFile, "utf8")); } catch {}
    const c = hits.filter((g) => !d.nondet.has(g)).map((g) => {
        // 当たった記録（check が pending に残した鍵）— 無ければ最新の記録
        let r: Rec | null = null;
        try { r = readRec(g, JSON.parse(fs.readFileSync(pendFile(g), "utf8")).key); } catch {}
        if (!r) { const f = recs(g)[0]; r = f ? JSON.parse(fs.readFileSync(f, "utf8")) : null; }
        return { g, secs: r ? r.secs : Infinity, at: ver[g] ?? 0, other: r?.root !== undefined && r.root !== ROOT ? 0 : 1 };
    }).filter((x) => x.secs <= budget).sort((a, b) => a.other - b.other || a.at - b.at || (a.g < b.g ? -1 : 1));
    if (c.length) console.log(c[0].g);
}
// 前回の記録の秒（gates.shのsummaryのwallの前回比 — 宣言なき軸のしきい値のタスク・report-1282）: ゲートごとに最新の記録の「秒 コミット」
function cmdLast(gates: string[]) {
    for (const g of gates) {
        const f = recs(g)[0];
        if (!f) continue;
        const r: Rec = JSON.parse(fs.readFileSync(f, "utf8"));
        console.log(`${g} ${r.secs} ${r.commit.slice(0, 8)}`);
    }
}
function cmdVerified(g: string) {
    let ver: Record<string, number> = {};
    try { ver = JSON.parse(fs.readFileSync(verFile, "utf8")); } catch {}
    ver[g] = Date.now();
    writeAtomic(verFile, JSON.stringify(ver));
}

function cmdExtract(gates: string[]) {
    for (const g of gates.length ? gates : allGates()) console.log(`${g}: ${extracted(g).join(" ")}`);
}

loadHstat();
const [cmd, ...rest] = process.argv.slice(2);
switch (cmd) {
    case "check": cmdCheck(rest); break;
    case "record": cmdRecord(rest[0], rest[1], rest[2]); saveHstat(); break;
    case "lint": { const b = lint(loadDeps()); b.forEach((l) => console.log(l)); process.exit(b.length ? 1 : 0); }
    case "selftest": process.exit(cmdSelftest() ? 1 : 0);
    case "extract": cmdExtract(rest); break;
    case "mutate": cmdMutate(rest[0], rest[1]); saveHstat(); break;
    case "audit": cmdAudit(rest[0], rest.slice(1)); break;
    case "pick": cmdPick(Number(rest[0]), rest.slice(1)); break;
    case "verified": cmdVerified(rest[0]); break;
    case "last": cmdLast(rest); break;
    case "keys": cmdKeys(rest); break;
    case "cover": console.log(coverOf(rest[0]).join("\n")); break;
    default: console.error("usage: gatememo.ts check|record|lint|selftest|extract …"); process.exit(2);
}
