// 実の PostgreSQL（平文・trust）と async-db の文の往復を記録する — 代役（bench/pgstub）の応答を照合する黄金（bench/pgstub/trace-items.hex）。
//   node --experimental-strip-types --no-warnings bench/pgstub/cap.ts <host:port> <user> <db> > bench/pgstub/trace-items.hex
// 相手は bench/httparena の seed（data/pgdb-seed.sql の items）を入れた PG。形は scripts/pgcap.ts と同じ
// （`# <場面>` の後に `C <hex>`〔送ったもの〕と `S <hex>`〔ReadyForQuery か切断まで受けたもの〕）。
// 引数の符号化は ParameterDescription の oid に従い、結果の書式は std/pg と同じく列ごとに binary（9 列 × 1）
import * as net from "node:net";

const [addr, user, db] = process.argv.slice(2);
if (!addr || !user || !db) {
    console.error("usage: cap.ts <host:port> <user> <db>");
    process.exit(2);
}
const [host, port] = addr.split(":");

export const itemsSql = "SELECT id, name, category, price, quantity, active, tags, rating_score, rating_count FROM items WHERE price BETWEEN $1 AND $2 LIMIT $3";

const be32 = (n: number) => { const b = Buffer.alloc(4); b.writeInt32BE(n); return b; };
const be16 = (n: number) => { const b = Buffer.alloc(2); b.writeInt16BE(n); return b; };
const cstr = (s: string) => Buffer.concat([Buffer.from(s, "utf8"), Buffer.from([0])]);
const msg = (tag: string, ...parts: Buffer[]) => {
    const body = Buffer.concat(parts);
    return Buffer.concat([Buffer.from(tag, "latin1"), be32(body.length + 4), body]);
};
const startup = (u: string, d: string) => {
    const body = Buffer.concat([be32(196608), cstr("user"), cstr(u), cstr("database"), cstr(d), cstr("application_name"), cstr("pgstub"), Buffer.from([0])]);
    return Buffer.concat([be32(body.length + 4), body]);
};
const parse = (name: string, sql: string) => msg("P", cstr(name), cstr(sql), be16(0));
const describe = (kind: string, name: string) => msg("D", Buffer.from(kind, "latin1"), cstr(name));
const bind = (stmt: string, params: Buffer[], fmts: number[]) => msg("B",
    cstr(""), cstr(stmt), be16(params.length), ...params.map(() => be16(1)), be16(params.length),
    ...params.flatMap((p) => [be32(p.length), p]), be16(fmts.length), ...fmts.map(be16));
const execute = () => msg("E", cstr(""), be32(0));
const sync = () => msg("S");
const terminate = () => msg("X");

const sock = net.connect(Number(port), host);
let inbuf = Buffer.alloc(0);
let waiter: (() => void) | null = null;
sock.on("data", (d) => { inbuf = Buffer.concat([inbuf, d]); waiter?.(); });
sock.on("close", () => { waiter?.(); });
await new Promise<void>((r) => sock.on("connect", () => r()));

async function recvUntil(n: number, end = false): Promise<Buffer> {
    for (;;) {
        let at = 0, zs = 0;
        while (inbuf.length - at >= 5 && inbuf.length - at >= 1 + inbuf.readInt32BE(at + 1)) {
            if (inbuf[at] === 0x5a) zs++;
            at += 1 + inbuf.readInt32BE(at + 1);
        }
        if (!end && zs >= n) {
            const out = inbuf.subarray(0, at);
            inbuf = inbuf.subarray(at);
            return out;
        }
        if (end && sock.destroyed) {
            const out = inbuf;
            inbuf = Buffer.alloc(0);
            return out;
        }
        await new Promise<void>((r) => { waiter = r; });
        waiter = null;
    }
}

async function step(name: string, c: Buffer, zs: number, end = false): Promise<Buffer> {
    console.log(`# ${name}`);
    console.log(`C ${c.toString("hex")}`);
    if (end) sock.end(c); else sock.write(c);
    const s = await recvUntil(zs, end);
    console.log(`S ${s.toString("hex")}`);
    return s;
}

// ParameterDescription（'t'）の oid の並び
function paramOids(s: Buffer): number[] {
    for (let at = 0; at < s.length; at += 1 + s.readInt32BE(at + 1)) {
        if (s[at] === 0x74) {
            const n = s.readInt16BE(at + 5);
            return Array.from({ length: n }, (_, i) => s.readInt32BE(at + 7 + 4 * i));
        }
    }
    throw new Error("no ParameterDescription");
}
const intArg = (oid: number, v: number) => {
    if (oid === 20) { const b = Buffer.alloc(8); b.writeBigInt64BE(BigInt(v)); return b; }
    if (oid === 23) return be32(v);
    if (oid === 21) return be16(v);
    throw new Error(`oid ${oid}`);
};

await step("startup", startup(user, db), 1);
const oids = paramOids(await step("items-prepare", Buffer.concat([parse("s1", itemsSql), describe("S", "s1"), sync()]), 1));
const run = (name: string, lo: number, hi: number, lim: number) =>
    step(name, Buffer.concat([bind("s1", [intArg(oids[0], lo), intArg(oids[1], hi), intArg(oids[2], lim)], Array(9).fill(1)), execute(), sync()]), 1);
await run("items-50", 10, 50, 50);
await run("items-20", 10, 50, 20);
await run("items-narrow", 20, 30, 50);
await run("items-none", 60, 50, 50);
await step("terminate", terminate(), 0, true);
