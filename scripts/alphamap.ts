// alphamap: 改名の写像の照合（scripts/alphacheck.sh の V2〜V4 — report-884）。
//   node --experimental-strip-types scripts/alphamap.ts [--cols] [--ir] [--ll] [--core] (<old> <new> | --pair old=new …) <before> <after>
// --cols: `<file>.sober:<行>:<列>` の列・panic の点の表（@rt.psites）の列・診断の high_water を伏せて比べる（改名で同じ行の後ろの列がずれる）
// before と after が「before の old の出現（ASCII の語境界）の一部を new に替えたもの」と行ごとに一致すれば 0。
// 一部 = 同綴りの別物（std/testing.Fail と std/task.MarkFailed 等）は替わらなくてよい — 替わった出現は 1 つ以上要る（全く替わらないなら写像の意味がない —
// それは差分が無いだけなので 0 で返し、呼び手が「差が無い」として扱う）。行の数が違う・写像で説明できない行がある → 1（最初の 10 行を出す）
import { readFileSync } from "node:fs";

const args0 = process.argv.slice(2);
// `--pair 旧=新` は何組でも（package の改名 = パスと参照名の 2 組）。無ければ位置引数の <old> <new>
const pairs: [string, string][] = [];
const rest: string[] = [];
for (let i = 0; i < args0.length; i++) {
    if (args0[i] === "--pair" && i + 1 < args0.length) {
        const [o, n] = args0[++i].split("=");
        pairs.push([o, n]);
    } else {
        rest.push(args0[i]);
    }
}
const flags = new Set(rest.filter((x) => x.startsWith("--")));
const args = rest.filter((x) => !x.startsWith("--"));
const cols = flags.has("--cols");
const ir = flags.has("--ir");
const core = flags.has("--core");
const ll = flags.has("--ll");
if (pairs.length === 0 && args.length === 4) pairs.push([args.shift()!, args.shift()!]);
const [fa, fb] = args;
if (pairs.length === 0 || !fa || !fb) {
    console.error("usage: alphamap.ts [--cols] [--ir] [--core] (<old> <new> | --pair old=new ...) <before> <after>");
    process.exit(2);
}
// 診断の確保量（region の high_water）も伏せる — 名前の長さで文字列のバイト数が変わる（region の上限で落ちる既存の entry の診断 — report-884）
// 文字列の中の名前（panic の文面のラベル名・json のキー）も写像で比べるため、文字列の定数を復号して文字列として並べる:
// --ir: `global @str.N [k] = {語…}`（LE に詰めたバイト）→ `global @str.N = "…"`・直後の `globaladdr @str.N` に続く `const L`（長さ）→ `const <len>`
// --core: core-json の `"bs":[バイト…]` → `"bs":"…"` にしてから `,` で行に割る（1 行の JSON を要素ごとに比べる）
const show = (bs: number[]) => JSON.stringify(Buffer.from(bs).toString("latin1"));
const decodeIr = (t: string) => {
    const lines = t.split("\n");
    for (let i = 0; i < lines.length; i++) {
        const m = lines[i].match(/^(\s*global @str\.\d+) \[\d+\] = \{([^}]*)\}$/);
        if (m) {
            const bytes: number[] = [];
            for (const w of m[2].split(",").map((x) => BigInt.asUintN(64, BigInt(x.trim())))) {
                for (let k = 0n; k < 8n; k++) bytes.push(Number((w >> (8n * k)) & 255n));
            }
            while (bytes.length > 0 && bytes[bytes.length - 1] === 0) bytes.pop();
            lines[i] = `${m[1]} = ${show(bytes)}`;
        }
        if (/= globaladdr @str\.\d+$/.test(lines[i]) && i + 1 < lines.length) {
            lines[i + 1] = lines[i + 1].replace(/^(\s*%\d+ = const )\d+$/, "$1<len>");
        }
    }
    return lines.join("\n");
};
const decodeCore = (t: string) =>
    t.replace(/"bs":\[([0-9,]*)\]/g, (_, xs: string) => `"bs":${show(xs === "" ? [] : xs.split(",").map(Number))}`).split(",").join("\n");
// --ll: `@"str.N" = internal constant [k x i64] [i64 …]` → `@"str.N" = "…"`（長さの定数は使う場所の近くに出ない — 下の行ごとの照合で
// `add i64 0, N` の差が旧名と新名の長さの差〔の最大公約数〕の倍数なら説明がつくとみなす）
const decodeLl = (t: string) =>
    t.replace(/^(@"str\.\d+") = internal constant \[\d+ x i64\] \[([^\]]*)\]$/gm, (_, g: string, ws: string) => {
        const bytes: number[] = [];
        for (const w of ws.split(",").map((x) => BigInt.asUintN(64, BigInt(x.trim().replace(/^i64 /, ""))))) {
            for (let k = 0n; k < 8n; k++) bytes.push(Number((w >> (8n * k)) & 255n));
        }
        while (bytes.length > 0 && bytes[bytes.length - 1] === 0) bytes.pop();
        return `${g} = ${show(bytes)}`;
    });
const gcd = (a: number, b: number): number => (b === 0 ? Math.abs(a) : gcd(b, a % b));
const lenDelta = pairs.reduce((g, [o, n]) => gcd(g, n.length - o.length), 0);
const norm = (t0: string) => {
    let t = t0;
    if (ll) t = decodeLl(t);
    if (ir) t = decodeIr(t);
    if (core) t = decodeCore(t);
    if (!cols) return t;
    // panic の点の表（@rt.psites — 1 点 1 語 = 種類 | ファイル << 8 | 行 << 24 | 列 << 48 — lower/panic.sober）の列も伏せる
    const mask = (ws: string, pre: string) =>
        ws.split(",").map((w) => pre + (BigInt.asUintN(64, BigInt(w.trim().replace(/^i64 /, ""))) & ((1n << 48n) - 1n)).toString()).join(", ");
    t = t
        .replace(/^(\s*global @rt\.psites \[\d+\] = \{)([^}]*)\}$/gm, (_, h: string, ws: string) => `${h}${mask(ws, "")}}`)
        .replace(/^(@"rt\.psites" = internal constant \[\d+ x i64\] \[)([^\]]*)\]$/gm, (_, h: string, ws: string) => `${h}${mask(ws, "i64 ")}]`);
    return t.replace(/(\.sober:\d+:)\d+/g, "$1C").replace(/high_water: \d+/g, "high_water: N");
};
const a = norm(readFileSync(fa, "latin1")).split("\n");
const b = norm(readFileSync(fb, "latin1")).split("\n");
const esc = (s: string) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
// 旧の綴りの選言（長い方を先に — パスの中の参照名より先にパス全体が当たる）。分割の捕捉で、出現ごとにどの組の旧かが分かる
const olds = [...pairs].sort((x, y) => y[0].length - x[0].length);
const newOf = new Map(pairs);
const word = new RegExp(`(?<![A-Za-z0-9_])(${olds.map((p) => esc(p[0])).join("|")})(?![A-Za-z0-9_])`, "g");
if (a.length !== b.length) {
    console.log(`alphamap: ${fb}: 行の数が違う（${a.length} → ${b.length}）`);
    process.exit(1);
}
let bad = 0;
let mapped = 0;
for (let i = 0; i < a.length; i++) {
    if (a[i] === b[i]) continue;
    // a の行の old の出現をそれぞれ (old|new) にした正規表現で b の行を照合
    const parts = a[i].split(word);
    const re = new RegExp("^" + parts.map((x, j) => (j % 2 === 0 ? esc(x) : `(?:${esc(x)}|${esc(newOf.get(x)!)})`)).join("") + "$");
    if (parts.length > 1 && re.test(b[i])) {
        mapped++;
        continue;
    }
    if (ll && lenDelta !== 0) {
        const ma = a[i].match(/^(\s*%v\d+ = add i64 0, )(\d+)$/);
        const mb = b[i].match(/^(\s*%v\d+ = add i64 0, )(\d+)$/);
        if (ma && mb && ma[1] === mb[1] && (Number(mb[2]) - Number(ma[2])) % lenDelta === 0) {
            mapped++;
            continue;
        }
    }
    if (bad < 10) {
        console.log(`alphamap: ${fb}:${i + 1}: 写像で説明できない差`);
        console.log(`  - ${a[i].slice(0, 200)}`);
        console.log(`  + ${b[i].slice(0, 200)}`);
    }
    bad++;
}
if (bad > 0) {
    console.log(`alphamap: ${fb}: 説明できない行 ${bad}（写像で説明できた行 ${mapped}）`);
    process.exit(1);
}
process.exit(0);
