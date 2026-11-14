// pgcap: 実のPostgreSQLと平文・trustで決まった台本を往復し、両向きのバイト列を記録する（std/internal/pgwireのゴールデン — testdata/pg/trace-<版>.hex）。
//   使い方: node --experimental-strip-types --no-warnings scripts/pgcap.ts <host:port> <user> > testdata/pg/trace-<版>.hex
//   std/internal/pgwireと独立の符号化（ここ）で書いたリクエストをstd/internal/pgwireの符号化器がバイト一致で作れること・レスポンスを同じ復号器が読めることを
//   std/internal/pgwire/wire_test.sober が照合する。記録は手で取り直すだけ（gates は読むだけ — 実 PG を要らない）
//   形: `# <場面>` の行の後に `C <hex>`（送ったもの 1 回分）と `S <hex>`（ReadyForQuery か切断まで受けたもの）の行が交互に続く
import * as net from "node:net";

const [addr, user] = process.argv.slice(2);
if (!addr || !user) {
    console.error("usage: pgcap.ts <host:port> <user>");
    process.exit(2);
}
const [host, port] = addr.split(":");

const be32 = (n: number) => { const b = Buffer.alloc(4); b.writeInt32BE(n); return b; };
const be16 = (n: number) => { const b = Buffer.alloc(2); b.writeInt16BE(n); return b; };
const cstr = (s: string) => Buffer.concat([Buffer.from(s, "utf8"), Buffer.from([0])]);
const msg = (tag: string, ...parts: Buffer[]) => {
    const body = Buffer.concat(parts);
    return Buffer.concat([Buffer.from(tag, "latin1"), be32(body.length + 4), body]);
};
const startup = (u: string, db: string) => {
    const body = Buffer.concat([be32(196608), cstr("user"), cstr(u), cstr("database"), cstr(db), Buffer.from([0])]);
    return Buffer.concat([be32(body.length + 4), body]);
};
const parse = (name: string, sql: string, oids: number[]) => msg("P", cstr(name), cstr(sql), be16(oids.length), ...oids.map(be32));
const describe = (kind: string, name: string) => msg("D", Buffer.from(kind, "latin1"), cstr(name));
// 引数は全部 binary（null は長さ -1）・結果の形式は fmts（空 = 全部 text・1 つ = 全列に）
const bind = (portal: string, stmt: string, params: (Buffer | null)[], fmts: number[]) => msg("B",
    cstr(portal), cstr(stmt), be16(params.length), ...params.map(() => be16(1)), be16(params.length),
    ...params.flatMap((p) => p === null ? [be32(-1)] : [be32(p.length), p]), be16(fmts.length), ...fmts.map(be16));
const execute = (portal: string, max: number) => msg("E", cstr(portal), be32(max));
const sync = () => msg("S");
const query = (sql: string) => msg("Q", cstr(sql));
const close = (kind: string, name: string) => msg("C", Buffer.from(kind, "latin1"), cstr(name));
const terminate = () => msg("X");
const i8 = (n: bigint) => { const b = Buffer.alloc(8); b.writeBigInt64BE(n); return b; };

const sock = net.connect(Number(port), host);
let inbuf = Buffer.alloc(0);
let waiter: (() => void) | null = null;
sock.on("data", (d) => { inbuf = Buffer.concat([inbuf, d]); waiter?.(); });
sock.on("close", () => { waiter?.(); });
await new Promise<void>((r) => sock.on("connect", () => r()));

// ReadyForQuery（'Z'）の数 n まで受ける（end = 切断まで）
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

async function step(name: string, c: Buffer, zs: number, end = false) {
    console.log(`# ${name}`);
    console.log(`C ${c.toString("hex")}`);
    if (end) sock.end(c); else sock.write(c);
    console.log(`S ${(await recvUntil(zs, end)).toString("hex")}`);
}

await step("startup", startup(user, "postgres"), 1);
await step("types", Buffer.concat([
    parse("", "select $1::int8 + 1 as n, $2::text as s, null::int4 as z, 1.5::numeric as d, '\\x78'::bytea as b, true as t, " +
        "2.5::float8 as f, '2026-11-08 12:34:56.789+00'::timestamptz as ts, '11111111-2222-3333-4444-555555555555'::uuid as u, " +
        "'-12345.678900'::numeric as d2, 0::numeric as d0, 'NaN'::numeric as dn", [20, 25]),
    describe("S", ""),
    bind("", "", [i8(41n), Buffer.from("héllo", "utf8")], [1]),
    execute("", 0),
    sync(),
]), 1);
await step("named-prepare", Buffer.concat([
    parse("s1", "select generate_series(1, $1::int4) as i", [23]),
    describe("S", "s1"),
    sync(),
]), 1);
await step("named-execute", Buffer.concat([
    bind("", "s1", [be32(3)], [1]),
    execute("", 0),
    sync(),
]), 1);
await step("null-param", Buffer.concat([
    parse("", "select $1::text is null as isnull", [25]),
    bind("", "", [null], [1]),
    execute("", 0),
    sync(),
]), 1);
await step("exec-error", Buffer.concat([
    parse("", "select 1 / $1::int4", [23]),
    bind("", "", [be32(0)], [1]),
    execute("", 0),
    sync(),
]), 1);
await step("parse-error", Buffer.concat([parse("", "selec 1", []), sync()]), 1);
await step("no-data", Buffer.concat([
    parse("", "create temp table t (x int primary key)", []),
    describe("S", ""),
    bind("", "", [], []),
    execute("", 0),
    sync(),
]), 1);
await step("insert", Buffer.concat([
    parse("", "insert into t values ($1::int4), ($1::int4 + 1)", [23]),
    bind("", "", [be32(7)], []),
    execute("", 0),
    sync(),
]), 1);
await step("unique-violation", Buffer.concat([
    parse("", "insert into t values ($1::int4)", [23]),
    bind("", "", [be32(7)], []),
    execute("", 0),
    sync(),
]), 1);
await step("tx", query("begin; insert into t values (100); savepoint a; rollback to savepoint a; commit"), 1);
await step("tx-failed", Buffer.concat([
    query("begin"),
    parse("", "select 1 / 0", []), bind("", "", [], []), execute("", 0), sync(),
    query("rollback"),
]), 3);
await step("empty-query", Buffer.concat([parse("", "", []), bind("", "", [], []), execute("", 0), sync()]), 1);
await step("async", query("set application_name = 'pgcap'; do $$ begin raise notice 'n1'; end $$; listen ch; notify ch, 'hi'"), 1);
await step("close", Buffer.concat([close("S", "s1"), sync()]), 1);
await step("terminate", terminate(), 0, true);
