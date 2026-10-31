// clidoc の照合の後半（scripts/clidoc.sh が呼ぶ）。引数 = `sober --cli-spec` の JSON（stage2 の表）
//   ② src/compiler の "SOBER_…" の綴りの全数 ⊆ 表の環境変数の宣言（App と全コマンド・dev 込み）・src/std の綴り（Sober のプログラムが読む層）
//      ⊆ docs/guide/env.ja.md の表（ランタイムが rt の中で字句でなく読む名前は "…" の照合に掛からない — 表の側の全数は見ていない）
//   ③ bin/sober と scripts/ が sober に渡すフラグの綴り ⊆ そのコマンドの表の宣言（dev 込み）+ 予約の綴り + bin/sober だけが解くフラグ
//      （行の中の `"$S2" <command> …` 等の呼び出しの形と、bin/sober の cmd_<command> の case の腕を読む — 網は粗く「表に無い綴り」だけを赤にする）
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
if (bad > 0) process.exit(1);
console.log(`clidoc: env ${seen.size} ⊆ declared ${declared.size} · std env ${stdSeen.size} ⊆ guide ${guide.size} · flags ok`);
