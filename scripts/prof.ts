// プロファイルの口（性能投資 M0）: Sober の実行ファイルを perf でサンプリングし、関数ごと（と熱い番地）の比率を出す。
// Sober の ELF はシンボルを持たないので、`sober build --emit=syms`（既定の build と同じ形の関数の先頭番地の表）でサンプルを関数へ振る。
//   node --experimental-strip-types scripts/prof.ts <entry.sober> [--top N] [--hot N] -- <実行の引数…>
// perf は環境変数 PERF（既定 `perf`）。cpu-clock 2 kHz のサンプリング（WSL でも取れる）。命令数だけ見たいなら `perf stat -e instructions:u`
import { execFileSync, spawnSync } from "node:child_process";
import { mkdtempSync, readFileSync, rmSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";

const argv = process.argv.slice(2);
const dd = argv.indexOf("--");
const own = dd >= 0 ? argv.slice(0, dd) : argv;
const runArgs = dd >= 0 ? argv.slice(dd + 1) : [];
const entry = own.find((a, i) => !a.startsWith("--") && !/^--(top|hot)$/.test(own[i - 1] ?? ""));
if (!entry) {
  console.error("usage: prof.ts <entry.sober> [--top N] [--hot N] -- <args…>");
  process.exit(2);
}
const opt = (name: string, d: number) => {
  const i = own.indexOf(name);
  return i >= 0 ? Number(own[i + 1]) : d;
};
const top = opt("--top", 15);
const hot = opt("--hot", 0);
const perf = process.env.PERF ?? "perf";
const root = join(import.meta.dirname, "..");
const sober = join(root, "bin/sober");
const w = mkdtempSync(join(tmpdir(), "sober-prof-"));
try {
  const exe = join(w, "a.out");
  const symf = join(w, "syms.txt");
  execFileSync(sober, ["build", entry, "-o", exe], { stdio: "inherit" });
  execFileSync(sober, ["build", entry, "--emit=syms", "-o", symf], { stdio: "inherit" });
  const data = join(w, "perf.data");
  const rec = spawnSync(perf, ["record", "-q", "-e", "cpu-clock", "-F", "2000", "-o", data, exe, ...runArgs], { stdio: ["ignore", "ignore", "inherit"] });
  if (rec.status !== 0 && rec.status !== 101) {
    console.error(`prof: perf record failed (${rec.status})`);
    process.exit(1);
  }
  const ips = execFileSync(perf, ["script", "-i", data, "-F", "ip"], { encoding: "utf8", maxBuffer: 1 << 30 })
    .split("\n").map((l) => l.trim()).filter((l) => l !== "").map((l) => BigInt("0x" + l));
  const syms = readFileSync(symf, "utf8").split("\n").filter((l) => l !== "")
    .map((l) => { const s = l.indexOf(" "); return { at: BigInt("0x" + l.slice(0, s)), name: l.slice(s + 1) }; });
  const fnOf = (ip: bigint) => {
    let lo = 0, hi = syms.length - 1, r = -1;
    while (lo <= hi) {
      const m = (lo + hi) >> 1;
      if (syms[m].at <= ip) { r = m; lo = m + 1; } else { hi = m - 1; }
    }
    return r >= 0 ? syms[r].name : "?";
  };
  const byFn = new Map<string, number>();
  const byIp = new Map<bigint, number>();
  for (const ip of ips) {
    const f = fnOf(ip);
    byFn.set(f, (byFn.get(f) ?? 0) + 1);
    byIp.set(ip, (byIp.get(ip) ?? 0) + 1);
  }
  const pct = (n: number) => (100 * n / ips.length).toFixed(1).padStart(5) + "%";
  console.log(`${ips.length} samples`);
  for (const [f, n] of [...byFn].sort((a, b) => b[1] - a[1]).slice(0, top)) console.log(`${pct(n)} ${f}`);
  if (hot > 0) {
    console.log("-- hot addresses (objdump -D -b binary -m i386:x86-64 --adjust-vma=0x400000 で読む)");
    for (const [ip, n] of [...byIp].sort((a, b) => b[1] - a[1]).slice(0, hot)) console.log(`${pct(n)} ${ip.toString(16)} ${fnOf(ip)}`);
  }
} finally {
  rmSync(w, { recursive: true, force: true });
}
