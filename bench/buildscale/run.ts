// gen.tsの出力を、言語・コア数・場面ごとにビルドして測る。1回の呼び出しで1つの(言語, コア数, 場面)をreps回測る。
// 使い方: node run.ts --dir <gen.tsの出力> --lang sober|go|rust|rustdebug --cores N --scene cold|leaf|root
//                     [--reps 3] [--sober <sober2のパス>] [--tsv <追記する先>] [--label <規模の名前>]
// 場面: cold = 置き場（Sober）・GOCACHE（Go）・target（Rust）を空にしてからビルド
//       coldapp = coldと同じく空にした後、標準ライブラリだけを使う小さいプログラム（同じ置き場）を測らずにビルドしてから測る
//                 （GoはGOCACHEを空にすると標準ライブラリもビルドし直す。Rustの標準ライブラリはビルド済みで配られるので、Rustでは cold と同じ）
//       leaf = 誰からもimportされないmodule（最上位の層）の関数の本体の定数を1つ変えてビルド
//       root = 層0のmodule（m000 — 多くのmoduleが依存する）で同じことをする
// 記録（TSVの1行 = 1回）: wall秒・user秒・sys秒・peak RSS（KB。GNU timeの%M = 子孫のうち最大の1プロセス）・出力のバイナリのバイト・終了コード
// 時間に依る計測なので、.pair/tools/gq.sh --excl <名前> node run.ts … で起動する
import { execFileSync, spawnSync } from "node:child_process";
import { appendFileSync, existsSync, mkdirSync, readFileSync, readdirSync, rmSync, statSync, writeFileSync } from "node:fs";
import { join, resolve } from "node:path";

const args = new Map<string, string>();
for (let i = 2; i < process.argv.length; i += 2) args.set(process.argv[i].replace(/^--/, ""), process.argv[i + 1]);
const DIR = resolve(args.get("dir") ?? "");
const LANG = args.get("lang") ?? "sober";
const CORES = Number(args.get("cores") ?? "1");
const SCENE = args.get("scene") ?? "cold";
const REPS = Number(args.get("reps") ?? "3");
const SOBER = resolve(args.get("sober") ?? "out/stage2/sober2");
const TSV = args.get("tsv");
const LABEL = args.get("label") ?? DIR.split("/").pop()!;
const WORK = join(DIR, ".work"); // キャッシュの置き場（Sober・Go）
mkdirSync(WORK, { recursive: true });

const langDir = join(DIR, LANG === "rustdebug" ? "rust" : LANG);
const stats = JSON.parse(readFileSync(join(DIR, "stats.json"), "utf8"));
const nmods: number = stats.modules;
const mname = (m: number) => `m${String(m).padStart(3, "0")}`;

// 変える関数のmodule: leaf = 番号が最大のmodule（最上位の層 — 誰もimportしない）・root = m000（層0）
const target = SCENE === "leaf" ? mname(nmods - 1) : mname(0);
const ext = { sober: ".sober", go: ".go", rust: ".rs", rustdebug: ".rs" }[LANG]!;
const srcDir = LANG.startsWith("rust") ? join(langDir, target, "src") : join(langDir, target);

// 本体の定数を1つ変える: module の f0 から順に、最初の `acc*31 + n + C` の C を +1 / -1（交互）する
function mutate(rep: number): () => void {
  const files = readdirSync(srcDir).filter((f) => /^f\d+/.test(f) && f.endsWith(ext)).sort();
  for (const f of files) {
    const p = join(srcDir, f);
    const s = readFileSync(p, "utf8");
    const m = s.match(/31 \+ n \+ (\d+)\)/);
    if (!m) continue;
    const c = Number(m[1]);
    writeFileSync(p, s.replace(m[0], `31 + n + ${rep % 2 === 0 ? c + 1 : c - 1})`));
    return () => writeFileSync(p, s);
  }
  throw new Error(`no constant to change in ${srcDir}`);
}

function cmd(): { argv: string[]; env: Record<string, string>; cwd: string; bin: string } {
  const env: Record<string, string> = { ...(process.env as Record<string, string>) };
  switch (LANG) {
    case "sober":
      Object.assign(env, { SOBER_CACHE: join(WORK, "sober-cache"), XDG_CACHE_HOME: join(WORK, "xdg"), SOBER_WORKERS: String(CORES) });
      return { argv: [SOBER, "build", "app/main.sober", "--emit=elf", "--passes", "-o", "app.bin"], env, cwd: langDir, bin: join(langDir, "app.bin") };
    case "go":
      Object.assign(env, { GOCACHE: join(WORK, "gocache"), GOMAXPROCS: String(CORES), GOFLAGS: "-mod=mod", GOTOOLCHAIN: "local" });
      return { argv: ["go", "build", "-p", String(CORES), "-o", "app.bin", "./app"], env, cwd: langDir, bin: join(langDir, "app.bin") };
    default: {
      const rel = LANG === "rust";
      Object.assign(env, { CARGO_TARGET_DIR: join(langDir, rel ? "target" : "target-debug") });
      return { argv: ["cargo", "build", "--offline", "-q", "-j", String(CORES), ...(rel ? ["--release"] : [])], env, cwd: langDir, bin: join(langDir, rel ? "target" : "target-debug", rel ? "release" : "debug", "app") };
    }
  }
}

function clean() {
  if (LANG === "sober") for (const d of ["sober-cache", "xdg"]) rmSync(join(WORK, d), { recursive: true, force: true });
  else if (LANG === "go") {
    // GOCACHEは書き込み禁止のファイルを含むので go clean で消す
    const c = join(WORK, "gocache");
    if (existsSync(c)) spawnSync("go", ["clean", "-cache"], { env: { ...process.env, GOCACHE: c } });
    rmSync(c, { recursive: true, force: true });
  } else rmSync(join(langDir, LANG === "rust" ? "target" : "target-debug"), { recursive: true, force: true });
}

// 標準ライブラリだけを使う小さいプログラムを同じ置き場でビルドする（coldappの前置き。Rustでは何もしない）
function primeStd() {
  const c = cmd();
  const h = join(WORK, "hello");
  mkdirSync(h, { recursive: true });
  if (LANG === "sober") {
    writeFileSync(join(h, "main.sober"), 'package main\n\nimport "std/iter"\n\nfunc main() int {\n    mut m := mut map[int]int{}\n    mut xs := mut []int{}\n    for i <- iter.Range(0, 3) {\n        m[i] = i\n        xs = append(xs, i)\n    }\n    println(len(xs))\n    return 0\n}\n');
    spawnSync(c.argv[0], ["build", "main.sober", "--emit=elf", "--passes", "-o", "hello.bin"], { cwd: h, env: c.env });
  } else if (LANG === "go") {
    writeFileSync(join(h, "go.mod"), "module hello\n\ngo 1.23\n");
    writeFileSync(join(h, "main.go"), 'package main\n\nimport "fmt"\n\nfunc main() {\n\tm := map[int]int{1: 2}\n\tfmt.Println(len(m))\n}\n');
    spawnSync("go", ["build", "-p", String(CORES), "-o", "hello.bin", "."], { cwd: h, env: c.env });
  }
}

function run(): { wall: number; user: number; sys: number; rss: number; code: number } {
  const c = cmd();
  const tf = join(WORK, "time.txt");
  const t0 = process.hrtime.bigint();
  const r = spawnSync("/usr/bin/time", ["-f", "%U %S %M", "-o", tf, ...c.argv], { cwd: c.cwd, env: c.env, stdio: ["ignore", "inherit", "inherit"] });
  const wall = Number(process.hrtime.bigint() - t0) / 1e9;
  const [user, sys, rss] = readFileSync(tf, "utf8").trim().split("\n").pop()!.split(" ").map(Number);
  return { wall, user, sys, rss, code: r.status ?? -1 };
}

const version = (() => {
  try {
    if (LANG === "sober") return `sober ${execFileSync("git", ["-C", resolve(SOBER, "../../.."), "rev-parse", "--short=9", "HEAD"]).toString().trim()}`;
    if (LANG === "go") return execFileSync("go", ["version"]).toString().trim().split(" ")[2];
    return execFileSync("rustc", ["--version"]).toString().trim().split(" ").slice(0, 2).join(" ");
  } catch { return "?"; }
})();

// 1行の変更の場面は、温まった状態（変更の前の木をビルド済み）から始める
if (SCENE === "leaf" || SCENE === "root") {
  const r = run();
  if (r.code !== 0) throw new Error("warm-up build failed");
}
const rows: string[] = [];
for (let rep = 0; rep < REPS; rep++) {
  let restore = () => {};
  if (SCENE === "cold") clean();
  else if (SCENE === "coldapp") { clean(); primeStd(); }
  else if (SCENE === "leaf" || SCENE === "root") restore = mutate(rep);
  else throw new Error(`unknown scene ${SCENE}`);
  const r = run();
  restore();
  const c = cmd();
  const size = existsSync(c.bin) ? statSync(c.bin).size : -1;
  const row = [LABEL, stats.fns, stats.lines[LANG.startsWith("rust") ? "rust" : LANG], LANG, CORES, SCENE, rep, r.wall.toFixed(3), r.user.toFixed(2), r.sys.toFixed(2), r.rss, size, r.code, version].join("\t");
  rows.push(row);
  console.log(row);
}
// 変更を戻した木で温め直しておく（次の場面のため）
if (SCENE === "leaf" || SCENE === "root") run();
if (TSV) {
  if (!existsSync(TSV)) appendFileSync(TSV, "size\tfns\tlines\tlang\tcores\tscene\trep\twall\tuser\tsys\trss_kb\tbin_bytes\tcode\tversion\n");
  appendFileSync(TSV, rows.join("\n") + "\n");
}
