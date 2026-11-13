// 代役の照合: 本物の PG から録った往復（scripts/pgcap.ts / bench/pgstub/cap.ts の形）の C 行を代役へ順に流し、代役の応答を記録の S 行と比べる。
//   node --experimental-strip-types --no-warnings bench/pgstub/replay.ts <port> <trace.hex> <場面>…
// 比べ方: startup は型の印の並び・AuthenticationOk・BackendKeyData の長さ・ReadyForQuery をバイトで（ParameterStatus は値が版と設定で違う — 印と名前の集合で）。
// items-narrow（既定より狭い price の範囲）は、代役の DataRow の列が記録の DataRow の列の先頭に一致すること（代役の表は既定の引数の 50 行だけを持つ —
// 狭い範囲の本物の答えのうち、その 50 行に入る行 = 本物の答えの先頭）。他の場面はバイト一致（代役の表は本物と同じ表の OID・列・行を持つ）。1 場面でも違えば終了 1
import * as net from "node:net";
import { readFileSync } from "node:fs";

const [port, file, ...want] = process.argv.slice(2);
type Step = { name: string; c: Buffer; s: Buffer };
const steps: Step[] = [];
let name = "";
let c: Buffer | null = null;
for (const l of readFileSync(file, "utf8").split("\n")) {
    if (l.startsWith("# ")) name = l.slice(2);
    else if (l.startsWith("C ")) c = Buffer.from(l.slice(2), "hex");
    else if (l.startsWith("S ") && c) { steps.push({ name, c, s: Buffer.from(l.slice(2), "hex") }); c = null; }
}

type Msg = { t: string; body: Buffer };
function msgs(b: Buffer): Msg[] {
    const out: Msg[] = [];
    for (let at = 0; at + 5 <= b.length; at += 1 + b.readInt32BE(at + 1)) out.push({ t: String.fromCharCode(b[at]), body: b.subarray(at + 5, at + 1 + b.readInt32BE(at + 1)) });
    return out;
}
const zs = (b: Buffer) => msgs(b).filter((m) => m.t === "Z").length;

const sock = net.connect(Number(port), "127.0.0.1");
let inbuf = Buffer.alloc(0);
let waiter: (() => void) | null = null;
sock.on("data", (d) => { inbuf = Buffer.concat([inbuf, d]); waiter?.(); });
sock.on("close", () => { waiter?.(); });
await new Promise<void>((r) => sock.on("connect", () => r()));
async function recv(n: number, end: boolean): Promise<Buffer> {
    for (;;) {
        let at = 0, z = 0;
        while (inbuf.length - at >= 5 && inbuf.length - at >= 1 + inbuf.readInt32BE(at + 1)) {
            if (inbuf[at] === 0x5a) z++;
            at += 1 + inbuf.readInt32BE(at + 1);
        }
        if (!end && z >= n) { const o = inbuf.subarray(0, at); inbuf = inbuf.subarray(at); return o; }
        if (end && sock.destroyed) { const o = inbuf; inbuf = Buffer.alloc(0); return o; }
        await new Promise<void>((r) => { waiter = r; });
        waiter = null;
    }
}

function startupDiff(got: Buffer, rec: Buffer): string | null {
    const g = msgs(got), r = msgs(rec);
    const tags = (ms: Msg[]) => ms.map((m) => m.t).join("");
    if (tags(g) !== tags(r)) return `印の並び ${tags(g)} ≠ ${tags(r)}`;
    const names = (ms: Msg[]) => ms.filter((m) => m.t === "S").map((m) => m.body.toString("latin1").split("\0")[0]).sort().join(",");
    const rn = names(r).split(",").filter((n) => n !== "search_path").join(",");
    if (names(g) !== rn) return `ParameterStatus の名前 ${names(g)} ≠ ${rn}`;
    for (const t of ["R", "Z"]) {
        const a = g.find((m) => m.t === t)!.body, b = r.find((m) => m.t === t)!.body;
        if (!a.equals(b)) return `${t} ${a.toString("hex")} ≠ ${b.toString("hex")}`;
    }
    if (g.find((m) => m.t === "K")!.body.length !== r.find((m) => m.t === "K")!.body.length) return "BackendKeyData の長さ";
    return null;
}

let bad = 0;
for (const st of steps) {
    if (!want.includes(st.name)) continue;
    const end = st.name === "terminate";
    if (end) sock.end(st.c); else sock.write(st.c);
    const got = await recv(zs(st.s), end);
    let diff: string | null;
    if (st.name === "startup") {
        // 記録の startup は ParameterStatus から search_path を除いた集合で比べる（代役は search_path を送らない — std/pg は読まない）
        diff = startupDiff(got, Buffer.concat(msgs(st.s).filter((m) => !(m.t === "S" && m.body.toString("latin1").startsWith("search_path\0"))).map((m) => {
            const h = Buffer.alloc(5); h[0] = m.t.charCodeAt(0); h.writeInt32BE(m.body.length + 4, 1); return Buffer.concat([h, m.body]);
        })));
    } else if (st.name === "items-narrow") {
        const g = msgs(got), r = msgs(st.s);
        const gd = g.filter((m) => m.t === "D"), rd = r.filter((m) => m.t === "D");
        const prefix = gd.length > 0 && gd.length <= rd.length && gd.every((m, i) => m.body.equals(rd[i].body));
        const tags = g.map((m) => m.t).join("");
        diff = prefix && tags === `2${"D".repeat(gd.length)}CZ` && g[g.length - 2].body.toString("latin1") === `SELECT ${gd.length}\0`
            ? null : `先頭の一致でない（代役 ${gd.length} 行・記録 ${rd.length} 行）`;
        if (diff === null) console.log(`  (items-narrow: 代役 ${gd.length} 行 = 記録 ${rd.length} 行の先頭)`);
    } else diff = got.equals(st.s) ? null : `バイト列が違う\n  代役 ${got.toString("hex").slice(0, 400)}\n  記録 ${st.s.toString("hex").slice(0, 400)}`;
    console.log(diff === null ? `ok: ${st.name} (${got.length} B)` : `FAIL ${st.name}: ${diff}`);
    if (diff !== null) bad++;
}
if (!sock.destroyed) sock.end();
process.exit(bad === 0 ? 0 : 1);
