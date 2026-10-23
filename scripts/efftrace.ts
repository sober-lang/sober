// 関数の効果の動的オラクルの判定（scripts/efftrace.sh から — effect の波 段 5a）: 計装つきの実行の出力（`#effin <fi>` / `#effout <fi>` / `#effleaf <ビット>`）から
// 呼び出しの積みを組み直し、葉のビットを積みの上の全部の関数に数えた観測が、導出（`check --effects-dump` の `fi=<添字> bits=<語の列>`）に含まれるかを見る。
// 積みは task ごと（行の末尾 = 今の task の TCB の番地）。出口の無い関数（panic・死で終わる）は積みに残るだけ — 次の `#effout` で上から外し、panic の葉の後は
// その task の積みを捨てる（TCB は使い回される）。子の task の葉は子の積みにだけ数える（親の枠には数えない — 導出は親にも数えるので観測が狭いだけ）
//
//   node --experimental-strip-types scripts/efftrace.ts <dump> <trace> <名前>
import { readFileSync } from "node:fs";

const [dumpPath, tracePath, name] = process.argv.slice(2);
const WORDS: Record<string, number> = { block: 1, io: 2, panic: 4, nondet: 8 };
const derived = new Map<number, number>();
for (const line of readFileSync(dumpPath, "utf8").split("\n")) {
    const m = / effects (\S+) fi=(\d+) bits=([a-z, ]+?)( declared)?$/.exec(line);
    if (!m) continue;
    const bits = m[3] === "none" ? 0 : m[3].split(", ").reduce((a, w) => a | (WORDS[w] ?? 0), 0);
    derived.set(Number(m[2]), bits);
}
const names = new Map<number, string>();
for (const line of readFileSync(dumpPath, "utf8").split("\n")) {
    const m = / effects (\S+) fi=(\d+) /.exec(line);
    if (m) names.set(Number(m[2]), m[1]);
}
const observed = new Map<number, number>();
const stacks = new Map<string, number[]>();
let leaves = 0;
for (const line of readFileSync(tracePath, "latin1").split("\n")) {
    if (!line.startsWith("#eff")) continue;
    const [tag, v, tk] = line.split(" ");
    const n = Number(v);
    const stack = stacks.get(tk) ?? [];
    stacks.set(tk, stack);
    if (tag === "#effnew") {
        stack.length = 0;
    } else if (tag === "#effin") {
        stack.push(n);
    } else if (tag === "#effout") {
        const i = stack.lastIndexOf(n);
        if (i >= 0) stack.length = i;
    } else if (tag === "#effleaf") {
        leaves++;
        for (const f of stack) observed.set(f, (observed.get(f) ?? 0) | n);
        // panic は task を終わらせる（子なら死 — 出口の印は来ない。TCB の番地は使い回されるので積みを捨てる）
        if ((n & 4) !== 0) stack.length = 0;
    }
}
const str = (b: number) => Object.entries(WORDS).filter(([, x]) => (b & x) !== 0).map(([w]) => w).join(",") || "none";
let fail = 0;
let nofn = 0;
for (const [f, b] of observed) {
    const d = derived.get(f);
    if (d === undefined) { nofn++; continue; }
    if ((b & ~d) !== 0) {
        console.log(`VIOLATION ${name}: ${names.get(f) ?? f} (fi=${f}) observed ${str(b)} — derived ${str(d)}`);
        fail = 1;
    }
}
console.log(`efftrace ${name}: functions ${observed.size} leaves ${leaves} unmatched ${nofn}`);
process.exit(fail);
