// schedvec（段 6 P3b-3 — par-draft 8 節）: 小さい並列のプログラムの全スケジュールを列挙し、観測（stdout・終了コード・`#sched` 以外の stderr）の集合が
// 1 要素であること（Kahn の定理の実装側の網 — ランタイムのスケジューラ・切替・region の付け替えが到着順に依る値を漏らしていないか）。
//   node --experimental-strip-types scripts/schedvec.ts <ELF>... [--depth K] [--budget N]
// 列挙 = 状態なしのモデル検査の素朴形: 接頭の選択の列 prefix で走らせ、`#sched n v` の選択点の列を読み、prefix より後ろの各点 i（深さ K まで）の
// 0 以外の選択 v を prefix + [0…] + [v] で掘る（各走行は prefix の後ろを既定 0 で走る）。走行数が budget を超えたら打ち切る（打ち切りは報告に出す）
import { spawnSync } from 'node:child_process';
const args = process.argv.slice(2);
const opt = (k: string, d: number) => { const i = args.indexOf(k); return i >= 0 ? Number(args[i + 1]) : d; };
const depth = opt('--depth', 12), budget = opt('--budget', 400);
const bins = args.filter((a, i) => !a.startsWith('--') && !(i > 0 && args[i - 1].startsWith('--')));
let fail = 0;
for (const bin of bins) {
  const seen = new Map<string, string>();
  let runs = 0, cut = false;
  const run = (prefix: number[]) => {
    if (runs >= budget) { cut = true; return; }
    runs++;
    const r = spawnSync(bin, [], { encoding: 'utf8', timeout: 20000, env: { ...process.env, SOBER_SCHED: prefix.join(','), SOBER_SCHED_TRACE: '1' } });
    if (r.error || r.status === null || r.status === 126 || r.status === 127) { console.log(`FAIL ${bin}: did not run (${r.error ?? r.signal})`); fail++; return; }
    const pts: number[] = [];
    const errLines: string[] = [];
    for (const l of (r.stderr ?? '').split('\n')) {
      const m = l.match(/^#sched (\d+) (\d+)$/);
      if (m) pts.push(Number(m[1])); else if (l !== '') errLines.push(l);
    }
    const obs = `exit=${r.status}\n${r.stdout}\n--\n${errLines.join('\n')}`;
    if (!seen.has(obs)) seen.set(obs, prefix.join(','));
    for (let i = prefix.length; i < Math.min(pts.length, depth); i++) {
      for (let v = 1; v < pts[i]; v++) {
        run([...prefix, ...Array(i - prefix.length).fill(0), v]);
      }
    }
  };
  run([]);
  const ok = seen.size === 1;
  if (!ok) fail++;
  console.log(`${ok ? 'ok' : 'FAIL'} ${bin.split('/').pop()}: runs=${runs}${cut ? ' (budget cut)' : ''} observations=${seen.size}`);
  if (!ok) for (const [o, p] of seen) console.log(`  SOBER_SCHED=${p}\n    ${o.replace(/\n/g, '\n    ')}`);
}
console.log(`schedvec: ${bins.length} programs, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
