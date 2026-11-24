// 線（上限値の表 bench/ratchet.txt・scripts/framestat.list）の取り直し。いまの木の鍵に当たるゲートの記録の実測（gatememo.ts meas）から、
// 越えた線を標準の規則で引き直す。ゲートを走らせた後に、ゲートの外で明示に呼ぶ（ゲートの実行中は木を書き換えない）。
//
//   node scripts/ratchet.ts retake [--approve] [--dry-run] [ゲート…]   （ゲートの指定なし = scripts/gatedeps.txt の @lines の全部）
//
// 規則（線の種類ごと — 各ゲートの冒頭の注と同じ）:
//   bench/ratchet.txt の srv/* と ring/* の ireq = 実測 + 2・srv/* の hot64 = 実測・ほかの行 = 実測 × 1.005
//   scripts/framestat.list = 実測 × 1.01
//   どれも線の小数の桁に切り上げる
// 越えが2%を超える線（実測 > 上限 × 1.02）は書き換えず「要承認」として出し、終了1。--approve のときだけ書き換える（人間の承認を得た後）。
// 取り直した行の直前に、決まった形のコメントを1行足す。標準出力の終わりに、コミットメッセージの内訳の下書きを出す。
// 下がった線の締め直しはしない（ゲートの note を見て人間が決める）。
import { execFileSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const NUM = /^-?\d+(\.\d+)?$/;
const APPROVE_OVER = 0.02;

type Meas = { gate: string; commit: string; ec: number; file: string; item: string; col: string; v: number; vs: string };

function rule(file: string, item: string, col: string): { name: string; f: (v: number) => number } {
    if (file === "scripts/framestat.list") return { name: "実測 × 1.01", f: (v) => v * 1.01 };
    if (/^(srv|ring)\//.test(item) && col === "ireq") return { name: "実測 + 2", f: (v) => v + 2 };
    if (/^srv\//.test(item) && col === "hot64") return { name: "実測", f: (v) => v };
    return { name: "実測 × 1.005", f: (v) => v * 1.005 };
}
const decimals = (s: string) => (s.includes(".") ? s.split(".")[1].length : 0);
function ceilTo(x: number, d: number): string {
    const p = 10 ** d;
    return (Math.ceil(x * p - 1e-9) / p).toFixed(d);
}

function readMeas(gates: string[]): Meas[] {
    const out = execFileSync("node", ["--experimental-strip-types", path.join(ROOT, "scripts/gatememo.ts"), "meas", ...gates], {
        encoding: "utf8", env: { ...process.env, NODE_NO_WARNINGS: "1" }, stdio: ["ignore", "pipe", "inherit"], maxBuffer: 1 << 26,
    });
    return out.split("\n").filter(Boolean).map((l) => {
        const [gate, commit, ec, file, item, col, vs] = l.split(" ");
        return { gate, commit, ec: Number(ec), file, item, col, v: Number(vs), vs };
    });
}

function retake(args: string[]): number {
    const approve = args.includes("--approve"), dry = args.includes("--dry-run");
    const gates = args.filter((a) => !a.startsWith("--"));
    const meas = readMeas(gates);
    const date = new Date().toLocaleString("sv").slice(0, 10);
    const files = new Map<string, string[]>();
    const lines = (f: string) => {
        if (!files.has(f)) files.set(f, fs.readFileSync(path.join(ROOT, f), "utf8").split("\n"));
        return files.get(f)!;
    };
    const done: string[] = [], held: string[] = [];
    const seen = new Set<string>();
    for (const m of meas) {
        const k = `${m.file} ${m.item} ${m.col}`;
        if (seen.has(k)) continue;
        seen.add(k);
        const ls = lines(m.file);
        // ratchet_cmp と同じ行 = 項目と欄が一致する最初のコメントでない行
        const i = ls.findIndex((l) => { const r = l.trim().split(/\s+/); return !l.trim().startsWith("#") && r[0] === m.item && r[1] === m.col; });
        if (i < 0) { held.push(`${k}: 線の行が無い（実測 ${m.vs} — 行を足すのは人間が決める）`); continue; }
        const r = ls[i].trim().split(/\s+/);
        const old = r[2];
        if (!NUM.test(old)) { held.push(`${k}: 上限が数でない（${old}）`); continue; }
        if (!(m.v > Number(old))) continue;
        const over = m.v / Number(old) - 1;
        const ru = rule(m.file, m.item, m.col);
        const nw = ceilTo(ru.f(m.v), decimals(old));
        const pct = (over * 100).toFixed(2);
        const what = `${m.file} ${m.item} ${m.col} ${old} → ${nw}（実測 ${m.vs}・超え +${pct}%・${ru.name}・${m.gate} の ${m.commit.slice(0, 9)} の記録）`;
        if (over > APPROVE_OVER && !approve) { held.push(`要承認 ${what}`); continue; }
        // 値の列だけを置き換える（行の残りの空白・ref の印はそのまま）
        let n = 0;
        ls[i] = ls[i].replace(/(\S+)/g, (t) => (n++ === 2 ? nw : t));
        ls.splice(i, 0, `# ${date} 取り直し（scripts/ratchet.ts retake・${ru.name}・${over > APPROVE_OVER ? "承認済み" : "事後承認"}）: ${m.item} ${m.col} ${old} → ${nw}（実測 ${m.vs}・+${pct}%）`);
        done.push(what);
    }
    if (!dry) for (const [f, ls] of files) if (done.some((d) => d.startsWith(`${f} `))) fs.writeFileSync(path.join(ROOT, f), ls.join("\n"));
    console.log(`ratchet retake: ${meas.length} measurements, ${done.length} lines retaken${dry ? " (dry run — not written)" : ""}, ${held.length} held`);
    for (const h of held) console.log(`  held: ${h}`);
    if (done.length) {
        console.log("\n-- commit message draft --");
        console.log(`上限値の取り直し（scripts/ratchet.ts retake・${over2(done) ? "2%超を含む — 承認済み" : "事後承認を求める"}）:`);
        for (const d of done) console.log(`- ${d}`);
    }
    return held.some((h) => h.startsWith("要承認")) ? 1 : 0;
}
const over2 = (done: string[]) => done.some((d) => { const m = d.match(/超え \+([\d.]+)%/); return m !== null && Number(m[1]) > APPROVE_OVER * 100; });

const [cmd, ...rest] = process.argv.slice(2);
switch (cmd) {
    case "retake": process.exit(retake(rest));
    default: console.error("usage: ratchet.ts retake [--approve] [--dry-run] [gate…]"); process.exit(2);
}
