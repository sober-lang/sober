// 署名の列の検査（scripts/slowcheck.sh）の相手。TLSのサーバー（ワーカー2・握手のheadWaitを短く）に対して、2つの段階を順に回す。
// 繋ぐ側は素のTCPで、繋がったらClientHello（node自身のTLSのクライアントが最初に送るrecordを写したもの）を1回だけ送る。
// サーバーは1本ごとに非対称の計算（X25519と署名）をする。繋ぐ側の計算は無い。繋ぐ側は子のプロセス4本に分ける
// （probeの応答の時間に、繋ぐ側のイベントループの詰まりを入れない）。
// 1. loop: k本の繋ぎ手が、返事（サーバーのflight）の最初のバイトを受けるか閉じられるたびに閉じて繋ぎ直す（攻撃の形。サーバーの速さで回る）。
//    その最中に、確立済みのTLSの接続1本（probe）で GET / を前の応答の後20 msごとに送り、応答までの時間の最大を測る
// 2. burst: n本を一度に繋ぎ、返事が来た数と、何も届かずに閉じられた数（署名の列で待つ間に期限が過ぎた接続）を数える
// 出力: "probe max=<ms> n=<回数> loop=<loopで返事が来た数>"・"burst flights=<返事が来た数> empty=<何も届かずに閉じた数> probe=<その間のprobeの最大 ms>"・"ledger <サーバーの/ledgerの1行>"
//   node signflood.ts <port> <k> <n> [loop ms] [burst ms]
import net from "node:net";
import tls from "node:tls";
import { spawn } from "node:child_process";

// node のクライアントが最初に送るrecord（ClientHello）を写す
const hello: Buffer = await new Promise((res) => {
  const srv = net.createServer((s) => s.once("data", (d) => { res(d); s.destroy(); srv.close(); }));
  srv.listen(0, "127.0.0.1", () => {
    const c = tls.connect({ port: (srv.address() as net.AddressInfo).port, host: "127.0.0.1", rejectUnauthorized: false });
    c.on("error", () => {});
  });
});

// 子: <loop|burst> <port> <本数> <ms>。"<返事が来た数> <何も届かずに閉じた数>" を出す
if (process.argv[2] === "loop" || process.argv[2] === "burst") {
  const [, , mode, fp, fn, fw] = process.argv;
  const end = performance.now() + +fw;
  let flights = 0;
  let empty = 0;
  const one = () => {
    const s = net.connect(+fp, "127.0.0.1");
    let sent = false;
    let got = false;
    s.on("connect", () => { sent = true; s.write(hello); });
    s.once("data", () => { got = true; flights++; if (mode === "loop") s.destroy(); });
    s.on("close", () => {
      if (!got && sent) empty++;
      if (mode === "loop" && performance.now() < end) one();
    });
    s.on("error", () => {});
  };
  for (let i = 0; i < +fn; i++) one();
  await new Promise((r) => setTimeout(r, +fw));
  console.log(`${flights} ${empty}`);
  process.exit(0);
}

const [port, k, n] = [+process.argv[2], +process.argv[3], +process.argv[4]];
const [loopMs, burstMs] = [+(process.argv[5] ?? 4000), +(process.argv[6] ?? 6000)];
const kids = (mode: string, total: number, ms: number) => {
  const ps = [0, 1, 2, 3].map(() => spawn(process.execPath, [...process.execArgv, process.argv[1], mode, String(port), String(Math.ceil(total / 4)), String(ms)], { stdio: ["ignore", "pipe", "inherit"] }));
  return Promise.all(ps.map((p) => new Promise<number[]>((r) => { let o = ""; p.stdout!.on("data", (d) => (o += d)); p.on("close", () => r(o.trim().split(" ").map(Number))); })))
    .then((rs) => rs.reduce((a, b) => [a[0] + b[0], a[1] + b[1]], [0, 0]));
};

// probe: 確立済みの接続のリクエスト
const probe = tls.connect({ port, host: "127.0.0.1", rejectUnauthorized: false });
probe.on("error", () => {});
await new Promise((r) => probe.once("secureConnect", r));
let buf = "";
let pending: ((v: string) => void) | null = null;
probe.on("data", (d) => {
  buf += d.toString("latin1");
  const i = buf.indexOf("\r\n\r\n");
  if (i < 0 || !pending) return;
  const m = /content-length: *(\d+)/i.exec(buf.slice(0, i));
  const need = i + 4 + (m ? +m[1] : 0);
  if (buf.length < need) return;
  const body = buf.slice(i + 4, need);
  buf = buf.slice(need);
  const p = pending;
  pending = null;
  p(body);
});
const get = (path: string) => new Promise<string>((r) => { pending = r; probe.write(`GET ${path} HTTP/1.1\r\nHost: x\r\n\r\n`); });
for (let i = 0; i < 3; i++) await get("/");

// 1. loop と probe（繋ぎ手が揃うまでの1秒は測らない。一斉に繋いだ直後の受け付けの山を入れない）
const lp = kids("loop", k, loopMs);
await new Promise((r) => setTimeout(r, 1000));
const end = performance.now() + loopMs - 1500;
let pmax = 0;
let pn = 0;
while (performance.now() < end) {
  const t0 = performance.now();
  await get("/");
  const dt = performance.now() - t0;
  pn++;
  if (dt > pmax) pmax = dt;
  await new Promise((r) => setTimeout(r, 20));
}
const [lf] = await lp;
console.log(`probe max=${pmax.toFixed(0)} n=${pn} loop=${lf}`);

// 2. burst（probeの接続は保つ — 20 msごとのリクエストを続ける。応答の時間は記録だけ）
const bp = kids("burst", n, burstMs);
let bdone = false;
let bmax = 0;
void bp.then(() => (bdone = true));
while (!bdone) {
  const t0 = performance.now();
  await get("/");
  bmax = Math.max(bmax, performance.now() - t0);
  await new Promise((r) => setTimeout(r, 20));
}
const [bf, be] = await bp;
console.log(`burst flights=${bf} empty=${be} probe=${bmax.toFixed(0)}`);
console.log(`ledger ${(await get("/ledger")).trim()}`);
process.exit(0);
