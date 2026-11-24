// clidoc の照合の後半（scripts/clidoc.sh が呼ぶ）。引数 = `sober --cli-spec` の JSON（stage2 の表）
//   ② src/compiler の "SOBER_…" の綴りの全数 ⊆ 表の環境変数の宣言（App と全コマンド・dev 込み）・src/std の綴り（Sober のプログラムが読む層）
//      ⊆ docs/guide/env.ja.md の表（ランタイムが rt の中で字句でなく読む名前は "…" の照合に掛からない — 表の側の全数は見ていない）
//   ③ bin/sober と scripts/ が sober に渡すフラグの綴り ⊆ そのコマンドの表の宣言（dev 込み）+ 予約の綴り + bin/sober だけが解くフラグ
//      （行の中の `"$S2" <command> …` 等の呼び出しの形と、bin/soberのcmd_<command> のcaseの分岐を読む — 検査は粗く「表に無い綴り」だけを赤にする）
//   ④ build --rt-mutant の許可の列 ≡ src/compiler/lower が分岐に使う変異の番号（`rtMut` / `mut0` と数・名前つきの定数の == / != と、
//      `rtMut >= a && st.rtMut <= b` の範囲を読む）。欠番は VACANT に理由つきで書き、列にも実装にも無いことを見る
import { readFileSync, readdirSync } from "node:fs";

const spec = JSON.parse(readFileSync(process.argv[2], "utf8"));
let bad = 0;
const red = (msg: string) => { console.log(`FAIL ${msg}`); bad++; };

// ②
const declared = new Set<string>();
for (const e of spec.env) declared.add(e.name);
for (const c of spec.commands) for (const e of c.env) declared.add(e.name);
const walk = (dir: string): string[] => readdirSync(dir, { withFileTypes: true }).flatMap(d =>
    d.isDirectory() ? walk(`${dir}/${d.name}`) : d.name.endsWith(".sober") ? [`${dir}/${d.name}`] : []);
const seen = new Map<string, string>();
for (const f of walk("src/compiler")) {
    readFileSync(f, "utf8").split("\n").forEach((l, i) => {
        for (const m of l.matchAll(/"(SOBER_[A-Z0-9_]+)"/g)) if (!seen.has(m[1])) seen.set(m[1], `${f}:${i + 1}`);
    });
}
for (const [v, at] of seen) if (!declared.has(v)) red(`env ${v} (${at}) is not declared in the std/cli table of src/compiler/app`);
const guide = new Set([...readFileSync("docs/guide/env.ja.md", "utf8").matchAll(/`(SOBER_[A-Z0-9_]+)`/g)].map(m => m[1]));
const stdSeen = new Map<string, string>();
for (const f of walk("src/std")) {
    readFileSync(f, "utf8").split("\n").forEach((l, i) => {
        for (const m of l.matchAll(/"(SOBER_[A-Z0-9_]+)"/g)) if (!stdSeen.has(m[1])) stdSeen.set(m[1], `${f}:${i + 1}`);
    });
}
for (const [v, at] of stdSeen) if (!guide.has(v)) red(`env ${v} (${at}) is not in the table of docs/guide/env.ja.md`);

// ③
const RESERVED = ["--help", "-h", "--version", "--cli-spec"];
const WRAPPER: Record<string, string[]> = { build: ["--via", "--mem-trace"], check: ["--lean"], iface: ["-o"] }; // bin/sober が解いて stage2 に渡さない
const flags = new Map<string, Set<string>>();
for (const c of spec.commands) {
    const top = c.name.split(" ")[0];
    const s = flags.get(top) ?? new Set<string>([...RESERVED, ...(WRAPPER[top] ?? [])]);
    for (const f of c.flags) s.add(f.name.length === 1 ? `-${f.name}` : `--${f.name}`);
    flags.set(top, s);
}
const CMDS = [...flags.keys()].join("|");
const call = new RegExp(`(?:\\$\\{?(?:S2|SOBER|STAGE2|S2ABS)\\}?"?|bin/sober|sober2"?)\\s+(${CMDS})\\b([^|;&\\n)]*)`, "g");
const files = ["bin/sober", ...readdirSync("scripts").filter(f => /\.(sh|ts)$/.test(f) && f !== "clidoc.ts").map(f => `scripts/${f}`)];
const look = (cmd: string, w: string, at: string) => {
    if (!flags.get(cmd)!.has(w)) red(`flag ${cmd} ${w} (${at}) is not declared in the std/cli table`);
};
for (const f of files) {
    const lines = readFileSync(f, "utf8").split("\n");
    let fn = "";
    lines.forEach((l, i) => {
        for (const m of l.matchAll(call)) {
            for (const t of m[2].matchAll(/(?<![\w-])(--?[a-z][a-z0-9-]*)/g)) look(m[1], t[1], `${f}:${i + 1}`);
        }
        if (f !== "bin/sober") return;
        const h = l.match(/^cmd_([a-z]+)\(\)/);
        if (h) fn = flags.has(h[1]) ? h[1] : "";
        if (/^}/.test(l)) fn = "";
        const arm = l.match(/^\s*((?:--?[a-z][a-z0-9=|-]*)+)\)/);
        if (fn && arm) for (const a of arm[1].split("|")) {
            if (a !== "-*") look(fn, a.replace(/=.*$/, ""), `${f}:${i + 1}`);
        }
    });
}
// ④
const VACANT: Record<number, string> = {
    18: "どの版のCLIにも無かった番号",
    19: "廃止（slot_newの深度の検査を既定のrtに常設した — a266b5288）",
    23: "廃止（実行待ちの列をFIFOだけにした — 085cb9fd5）",
    24: "廃止（同上 — 085cb9fd5）",
    82: "使われなかった番号（並走の作業の予約 — 09b1259e4は84から足した）",
    83: "使われなかった番号（同上）",
    104: "使われなかった番号（並走の作業の予約 — c3dc9b9d0は105から足した）",
};
const allow = new Set<number>(spec.commands.find((c: any) => c.name === "build").flags.find((f: any) => f.name === "rt-mutant").allow);
const lowerFiles = walk("src/compiler/lower");
const consts = new Map<string, number>();
for (const f of lowerFiles) for (const m of readFileSync(f, "utf8").matchAll(/^const ([A-Z][A-Z0-9_]*) = (\d+)\b/gm)) consts.set(m[1], +m[2]);
const num = (t: string, at: string) => {
    const v = /^\d/.test(t) ? +t : consts.get(t);
    if (v === undefined) red(`rt mutant constant ${t} (${at}) is not a numeric const of src/compiler/lower`);
    return v;
};
const impl = new Map<number, string>();
for (const f of lowerFiles) readFileSync(f, "utf8").split("\n").forEach((l, i) => {
    const at = `${f}:${i + 1}`;
    const add = (v: number | undefined) => { if (v !== undefined && !impl.has(v)) impl.set(v, at); };
    for (const m of l.matchAll(/\b(?:rtMut|mut0) *(?:==|!=) *([A-Z][A-Z0-9_]*|\d+)\b/g)) add(num(m[1], at));
    for (const m of l.matchAll(/\brtMut *>= *([A-Z][A-Z0-9_]*|\d+) *&& *st\.rtMut *<= *([A-Z][A-Z0-9_]*|\d+)/g)) {
        const a = num(m[1], at), b = num(m[2], at);
        if (a !== undefined && b !== undefined) for (let k = a; k <= b; k++) add(k);
    }
});
for (const n of allow) if (!impl.has(n)) red(`rt mutant ${n} is allowed by build --rt-mutant but src/compiler/lower has no branch on it`);
for (const [n, at] of impl) if (!allow.has(n)) red(`rt mutant ${n} (${at}) is not in the allow list of build --rt-mutant (src/compiler/app/main.sober)`);
for (const k of Object.keys(VACANT)) if (allow.has(+k) || impl.has(+k)) red(`rt mutant ${k} is listed as vacant in scripts/clidoc.ts but is in use`);
const top = Math.max(...impl.keys());
for (let k = 1; k <= top; k++) if (!allow.has(k) && !(k in VACANT)) red(`rt mutant ${k} is missing from the allow list without a reason in VACANT (scripts/clidoc.ts)`);
if (bad > 0) process.exit(1);
console.log(`clidoc: env ${seen.size} ⊆ declared ${declared.size} · std env ${stdSeen.size} ⊆ guide ${guide.size} · flags ok · rt mutants ${allow.size} ≡ lower (vacant ${Object.keys(VACANT).length})`);
