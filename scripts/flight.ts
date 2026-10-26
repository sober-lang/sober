// flight.ts — rt の飛行記録（SOBER_FLIGHT=<path> — lower/flight.sober・report-1176）の読み手。1 イベント 1 行の構造化テキスト。
//   node --experimental-strip-types scripts/flight.ts <file> [--conn <相手の port>] [--around <CLOCK_MONOTONIC ns> [--window <ms>]] [--anomaly] [--summary]
// - 既定 = 全イベントを時刻順に
// - --conn P: ACCEPT の相手の port = P の接続（undici の cause.socket.localPort — check.ts の lport=）の列: ACCEPT → その fd の RECV / SEND / PARK / CLOSE と、
//   ACCEPT の直後の SPAWN の子・PARK の待ち手の TCB の RUN / WAKE / END（fd の使い回しは ACCEPT 〜 CLOSE で切る）
// - --around T: [T − window, T + 50 ms] のイベント（window 既定 1000 ms — check.ts の t= と同じ時計）
// - --anomaly: 起こしの取りこぼし（epoll が返した待ち手〔READY〕に対の WAKE が無い）・起こされない PARK（同じ TCB の WAKE / 後の RUN が無い — listener の待ちは除く）・
//   短い SEND（結果 < 頼んだ長さ）を並べる
// 時刻: TSC → CLOCK_MONOTONIC は頭の組と CLOCK のイベント（眠りの前）の区間ごとの線形の補い
import { readFileSync } from "node:fs";

const KIND = ["?", "ACCEPT", "SPAWN", "RUN", "PARK", "WAKE", "SEND", "RECV", "CLOSE", "ENTER", "EPWAIT", "CLOCK", "END", "PANIC", "READY"];
const MAGIC = 6074307316579192659n;

type Ev = { w: number; seq: number; kind: string; tsc: bigint; a: bigint; b: bigint; t: number };

const args = process.argv.slice(2);
const opt = (k: string) => (args.includes(k) ? args[args.indexOf(k) + 1] : undefined);
const file = args[0];
if (!file) {
    console.error("usage: flight.ts <file> [--conn P] [--around T [--window ms]] [--anomaly] [--summary]");
    process.exit(2);
}
const buf = readFileSync(file);
const v = new BigInt64Array(buf.buffer, buf.byteOffset, Math.floor(buf.length / 8));
if (v[0] !== MAGIC) {
    console.error(`flight: ${file}: not a flight record`);
    process.exit(2);
}
const nw = Number(v[2]);
const lg = Number(v[3]);
const ne = 1 << lg;
const pid = Number(v[6]);
const lo32 = (x: bigint) => Number(BigInt.asIntN(32, x));
const hi32 = (x: bigint) => Number(BigInt.asIntN(32, x >> 32n));

const evs: Ev[] = [];
for (let w = 0; w < nw; w++) {
    const base = 512 + w * ne * 4;
    const ring: Ev[] = [];
    for (let i = 0; i < ne; i++) {
        const o = base + i * 4;
        if (o + 3 >= v.length) break;
        const h = v[o + 1];
        if (h === 0n) continue;
        const k = Number(h & 255n);
        ring.push({ w, seq: Number(h >> 8n), kind: KIND[k] ?? `K${k}`, tsc: BigInt.asUintN(64, v[o]), a: v[o + 2], b: v[o + 3], t: 0 });
    }
    ring.sort((x, y) => x.seq - y.seq);
    // 折り返し: 番号が最新から ne 以内のものだけ（書きの途中で止まった古い番号を落とす）
    const top = ring.length ? ring[ring.length - 1].seq : 0;
    for (const e of ring) if (e.seq > top - ne) evs.push(e);
}

// TSC → ns の補いの点（頭の組 + CLOCK）
const pts: [bigint, number][] = [[BigInt.asUintN(64, v[4]), Number(v[5])]];
for (const e of evs) if (e.kind === "CLOCK") pts.push([e.tsc, Number(e.a)]);
pts.sort((x, y) => (x[0] < y[0] ? -1 : x[0] > y[0] ? 1 : 0));
// 傾き（ns / TSC）: 点が 2 つ以上なら端の 2 点・1 つなら 1/3（3 GHz の仮定 — 出力の頭に注記）
const slopeAll = pts.length >= 2 ? (pts[pts.length - 1][1] - pts[0][1]) / Number(pts[pts.length - 1][0] - pts[0][0]) : 1 / 3;
function toNs(tsc: bigint): number {
    let i = 0;
    while (i + 1 < pts.length && pts[i + 1][0] <= tsc) i++;
    const [t0, n0] = pts[i];
    const nx = pts[i + 1];
    const sl = nx && nx[0] > t0 ? (nx[1] - n0) / Number(nx[0] - t0) : slopeAll;
    return n0 + Number(tsc - t0) * sl;
}
for (const e of evs) e.t = toNs(e.tsc);
evs.sort((x, y) => x.t - y.t || x.w - y.w || x.seq - y.seq);

const tcb = (x: bigint) => `0x${BigInt.asUintN(64, x).toString(16)}`;
function fmt(e: Ev): string {
    const a = e.a, b = e.b;
    let f = "";
    switch (e.kind) {
        case "ACCEPT": f = `lfd=${lo32(a)} fd=${hi32(a)} peer=${b}`; break;
        case "SPAWN": f = `child=${tcb(a)} parent=${tcb(b)}`; break;
        case "RUN": f = `tcb=${tcb(a)}`; break;
        case "PARK": f = `fd=${lo32(a)} dir=${hi32(a) === 4 ? "out" : "in"} tcb=${tcb(b)}`; break;
        case "WAKE": f = `tcb=${tcb(a)} res=${b}`; break;
        case "SEND": case "RECV": f = `fd=${lo32(a)} want=${hi32(a)} res=${b}`; break;
        case "CLOSE": f = `fd=${a} exit=${b}`; break;
        case "ENTER": f = `sub=${lo32(a)} wait=${hi32(a)} res=${b}`; break;
        case "EPWAIT": f = `n=${a} tmo=${b}`; break;
        case "CLOCK": f = `mono=${a}`; break;
        case "END": f = `tcb=${tcb(a)} trap=${b}`; break;
        case "PANIC": f = `site=${a} tcb=${tcb(b)}`; break;
        case "READY": f = `tcb=${tcb(a)} pending=${b}`; break;
        default: f = `a=${a} b=${b}`;
    }
    return `t=${Math.round(e.t)} w=${e.w} #${e.seq} ${e.kind} ${f}`;
}

let out = evs;
const conn = opt("--conn");
if (conn !== undefined) {
    const port = BigInt(conn);
    const acc = evs.find((e) => e.kind === "ACCEPT" && e.b === port && hi32(e.a) >= 0);
    if (!acc) {
        console.log(`flight: no ACCEPT with peer=${conn}`);
        out = [];
    } else {
        const fd = hi32(acc.a);
        const i0 = evs.indexOf(acc);
        let i1 = evs.findIndex((e, i) => i > i0 && e.kind === "CLOSE" && Number(e.a) === fd);
        if (i1 < 0) i1 = evs.length - 1;
        const tcbs = new Set<bigint>();
        const sp = evs.find((e, i) => i > i0 && e.kind === "SPAWN" && e.w === acc.w);
        if (sp) tcbs.add(sp.a);
        for (let i = i0; i <= i1; i++) if (evs[i].kind === "PARK" && lo32(evs[i].a) === fd) tcbs.add(evs[i].b);
        out = evs.slice(i0, i1 + 1).filter((e) =>
            e === acc || e === sp ||
            ((e.kind === "SEND" || e.kind === "RECV" || e.kind === "PARK") && lo32(e.a) === fd) ||
            (e.kind === "CLOSE" && Number(e.a) === fd) ||
            ((e.kind === "RUN" || e.kind === "WAKE" || e.kind === "END") && tcbs.has(e.a)));
    }
}
const around = opt("--around");
if (around !== undefined) {
    const t = Number(around);
    const win = Number(opt("--window") ?? 1000) * 1e6;
    out = out.filter((e) => e.t >= t - win && e.t <= t + 50e6);
}

console.log(`# flight pid=${pid} workers=${nw} ring=${ne} events=${evs.length} clock-points=${pts.length}${pts.length < 2 ? " (TSC slope assumed 3 GHz)" : ""}`);
if (args.includes("--summary")) {
    const c = new Map<string, number>();
    for (const e of out) c.set(e.kind, (c.get(e.kind) ?? 0) + 1);
    console.log([...c].map(([k, n]) => `${k}=${n}`).join(" "));
} else if (args.includes("--anomaly")) {
    // 起こされない PARK: その TCB の後の WAKE も RUN も無い（listener の fd〔ACCEPT の lfd〕の待ちは除く — 止められたサーバの最後の待ち）
    const lfds = new Set<number>();
    for (const e of evs) if (e.kind === "ACCEPT") lfds.add(lo32(e.a));
    for (let i = 0; i < out.length; i++) {
        const e = out[i];
        if (e.kind === "PARK" && !lfds.has(lo32(e.a)) && !out.slice(i + 1).some((x) => (x.kind === "WAKE" || x.kind === "RUN") && x.a === e.b)) console.log(`stuck-park ${fmt(e)}`);
        // 起こしの取りこぼし: epoll が返した待ち中の待ち手（READY pending=1）に対の WAKE が無い（次の PARK までに）
        if (e.kind === "READY" && e.b === 1n) {
            let woke = false;
            for (const x of out.slice(i + 1)) {
                if (x.kind === "WAKE" && x.a === e.a) { woke = true; break; }
                if (x.kind === "PARK" && x.b === e.a) break;
            }
            if (!woke) console.log(`lost-wake ${fmt(e)}`);
        }
        if (e.kind === "SEND" && e.b >= 0n && Number(e.b) < hi32(e.a)) console.log(`short-send ${fmt(e)}`);
    }
} else {
    for (const e of out) console.log(fmt(e));
}
