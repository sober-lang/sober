// HTTP/2の攻撃の照合（scripts/h2spec.shのh2floodの段）: testdata/h2flood/srv.sober（proto: H2・頭2秒・送りの間隔1秒）に、
// HttpArenaのResilienceのHTTP/2の8つの攻撃を小さい規模（接続4本・各1.5秒まで）で掛け、種目ごとに守りの形を見る。
// どの種目も、攻撃の最中に別の接続の普通の要求が200で返ること（生存）と、サーバーが死なないことを見る。メモリの量は見ない（量はローカルの表の役）
//   node check.ts <port> [tls | tls12]（tls = TLSで繋ぐ — ALPNでh2を申し出る・証明書は検査しない。tls12 = TLS 1.2まで申し出る）
import net from "node:net";
import tls from "node:tls";

const port = +process.argv[2];
const useTls = process.argv[3] === "tls" || process.argv[3] === "tls12";
const tls12 = process.argv[3] === "tls12";
const host = "127.0.0.1";
const CONNS = 4;
const RUN = 1500;
// ENHANCE_YOUR_CALM（RFC 9113 7）
const CALM = 11;
// 送りの間隔（1秒）+ 期限の粗さの遅れ（最大約2.1秒）
const STALL = 3600;
let failed = 0;
let passed = 0;

const sleep = (ms: number) => new Promise<void>((r) => setTimeout(r, ms));
const PREFACE = Buffer.from("PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n");

function frame(type: number, flags: number, sid: number, payload: Buffer): Buffer {
  const h = Buffer.alloc(9);
  h.writeUIntBE(payload.length, 0, 3);
  h[3] = type;
  h[4] = flags;
  h.writeUInt32BE(sid, 5);
  return Buffer.concat([h, payload]);
}

function hstr(s: string | Buffer): Buffer {
  const b = typeof s === "string" ? Buffer.from(s) : s;
  if (b.length < 127) {
    return Buffer.concat([Buffer.from([b.length]), b]);
  }
  // 7ビットの前置の整数（RFC 7541 5.1）
  const out = [127];
  let v = b.length - 127;
  while (v >= 128) {
    out.push((v % 128) + 128);
    v = Math.floor(v / 128);
  }
  out.push(v);
  return Buffer.concat([Buffer.from(out), b]);
}

// GET <path>（:method GET・:scheme http・:path・:authority — 動的表に入れない字面）
function getBlock(path: string): Buffer {
  const p = path === "/" ? Buffer.from([0x84]) : Buffer.concat([Buffer.from([0x04]), hstr(path)]);
  return Buffer.concat([Buffer.from([0x82, 0x86]), p, Buffer.from([0x01]), hstr(host)]);
}

const SETTINGS = frame(4, 0, 0, Buffer.alloc(0));
const END_STREAM = 1;
const END_HEADERS = 4;

// 1本の接続: 受けたフレームを見て、GOAWAYの符号・閉じた時刻・ストリームごとのHEADERSの最初のバイト（:status 200 = 0x88）を控える
type Sess = { s: net.Socket; goaway: number; closed: number; heads: Map<number, number>; body: Buffer; t0: number };

function open(extra: Buffer = SETTINGS): Promise<Sess> {
  return new Promise((res, rej) => {
    const ready = () => {
      s.write(Buffer.concat([PREFACE, extra]));
      res(ss);
    };
    const s: net.Socket = useTls
      ? tls.connect({ port, host, servername: "localhost", ALPNProtocols: ["h2"], rejectUnauthorized: false, ...(tls12 ? { maxVersion: "TLSv1.2" as const } : {}) }, ready)
      : net.connect(port, host, ready);
    const ss: Sess = { s, goaway: -1, closed: 0, heads: new Map(), body: Buffer.alloc(0), t0: Date.now() };
    let buf = Buffer.alloc(0);
    s.on("data", (d: Buffer) => {
      buf = Buffer.concat([buf, d]);
      while (buf.length >= 9) {
        const n = buf.readUIntBE(0, 3);
        if (buf.length < 9 + n) {
          break;
        }
        const type = buf[3];
        const sid = buf.readUInt32BE(5) & 0x7fffffff;
        const p = buf.subarray(9, 9 + n);
        if (type === 7 && n >= 8) {
          ss.goaway = p.readUInt32BE(4);
        } else if (type === 1 && !ss.heads.has(sid)) {
          ss.heads.set(sid, n > 0 ? p[0] : -1);
        } else if (type === 0 && sid === 1) {
          ss.body = Buffer.concat([ss.body, p]);
          if (buf[4] & END_STREAM) {
            (ss as any).done = true;
          }
        }
        buf = buf.subarray(9 + n);
      }
    });
    s.on("close", () => {
      if (ss.closed === 0) {
        ss.closed = Date.now();
      }
    });
    s.on("error", (e: Error) => {
      if (process.env.H2F_DEBUG) {
        console.log(`#err ${e.message}`);
      }
    });
    s.on("timeout", () => rej(new Error("connect timeout")));
  });
}

// 書けるだけ書く（相手が閉じるか、期限が来るまで）。書く側の待ちは'drain'で受ける
async function flood(ss: Sess, chunk: () => Buffer, until: number) {
  while (Date.now() < until && ss.closed === 0 && !ss.s.destroyed) {
    if (!ss.s.write(chunk())) {
      await new Promise<void>((r) => {
        const t = setTimeout(r, 50);
        ss.s.once("drain", () => {
          clearTimeout(t);
          r();
        });
      });
    }
  }
}

// 普通の要求（別の接続でGET /）が200で返るか
async function alive(): Promise<boolean> {
  const ss = await open(Buffer.concat([SETTINGS, frame(1, END_STREAM | END_HEADERS, 1, getBlock("/"))]));
  const until = Date.now() + 2000;
  while (Date.now() < until && !ss.heads.has(1) && ss.closed === 0) {
    await sleep(20);
  }
  const ok = ss.heads.get(1) === 0x88;
  ss.s.destroy();
  return ok;
}

// サーバーのプールのshedの和（GET /shed）
async function shed(): Promise<number> {
  const ss = await open(Buffer.concat([SETTINGS, frame(1, END_STREAM | END_HEADERS, 1, getBlock("/shed"))]));
  const until = Date.now() + 2000;
  while (Date.now() < until && !(ss as any).done && ss.closed === 0) {
    await sleep(20);
  }
  ss.s.destroy();
  return parseInt(ss.body.toString(), 10);
}

function check(name: string, ok: boolean, why: string) {
  if (ok) {
    passed++;
    console.log(`ok   ${name}`);
  } else {
    failed++;
    console.log(`FAIL ${name}: ${why}`);
  }
}

// 攻撃をCONNS本で掛け、最中に生存を見る。結果 = 各接続のSess
async function attack(name: string, setup: (ss: Sess) => Promise<void>, extra?: Buffer): Promise<Sess[]> {
  const ss = await Promise.all(Array.from({ length: CONNS }, () => open(extra)));
  const runs = Promise.all(ss.map((x) => setup(x)));
  await sleep(300);
  const live = await alive();
  await runs;
  await sleep(200);
  check(`${name}: a normal request on another connection during the attack`, live, "no 200");
  if (process.env.H2F_DEBUG) {
    console.log(`#dbg ${name}: ${ss.map((x) => `goaway=${x.goaway} closed=${x.closed ? x.closed - x.t0 : 0}`).join(" | ")}`);
  }
  return ss;
}

// 攻撃の接続がサーバーに閉じられた（受けたGOAWAYはENHANCE_YOUR_CALMだけ）。sh0があれば、閉じた接続がshedに数えられた。
// GOAWAYは届かないことがある（未読のデータを持ったまま閉じるとカーネルがRSTを送り、相手は届いたバイトを捨てる）ので、数えはサーバーの側で見る
async function calm(name: string, ss: Sess[], sh0?: number) {
  const bad = ss.filter((x) => x.closed === 0 || (x.goaway !== -1 && x.goaway !== CALM));
  check(`${name}: the server closed every attacking connection`, bad.length === 0, bad.map((x) => `goaway=${x.goaway} closed=${x.closed !== 0}`).join(", "));
  if (process.env.H2F_DEBUG) {
    console.log(`  ${name}: closed after ${ss.map((x) => (x.closed ? x.closed - x.t0 : -1)).join(" ")} ms`);
  }
  if (sh0 !== undefined) {
    const d = (await shed()) - sh0;
    check(`${name}: counted in shed (GOAWAY ENHANCE_YOUR_CALM)`, d >= ss.length, `shed +${d}`);
  }
}

async function main() {
  // SETTINGS・PINGの洪水: 返すだけの制御フレームの数の上限（1万）でGOAWAY
  let sh0 = await shed();
  await calm("settings-flood", await attack("settings-flood", (x) => flood(x, () => Buffer.concat(Array(64).fill(SETTINGS)), Date.now() + RUN)), sh0);
  const PING = frame(6, 0, 0, Buffer.alloc(8));
  sh0 = await shed();
  await calm("ping-flood", await attack("ping-flood", (x) => flood(x, () => Buffer.concat(Array(64).fill(PING)), Date.now() + RUN)), sh0);

  // 長さ0のDATAの洪水: 進まないフレームの続き（1つを越える）でGOAWAY
  const EMPTY = frame(0, 0, 1, Buffer.alloc(0));
  sh0 = await shed();
  await calm("empty-frame-flood", await attack("empty-frame-flood", async (x) => {
    x.s.write(frame(1, END_HEADERS, 1, getBlock("/")));
    await flood(x, () => Buffer.concat(Array(64).fill(EMPTY)), Date.now() + RUN);
  }), sh0);

  // CONTINUATIONの洪水: ヘッダのブロックの上限でGOAWAY（shedに数える — 上限が無ければregionの上限で死ぬ形になり、shedに数えられない）
  const FILL = frame(9, 0, 1, Buffer.alloc(16384, 0x40));
  sh0 = await shed();
  await calm("continuation-flood", await attack("continuation-flood", async (x) => {
    x.s.write(frame(1, END_STREAM, 1, getBlock("/")));
    await flood(x, () => FILL, Date.now() + RUN);
  }), sh0);

  // HPACKの爆弾: 動的表の大きい項目を1バイトの参照で何度も呼ぶ。ヘッダのブロックの上限でGOAWAY
  const big = Buffer.concat([Buffer.from([0x40]), hstr("x-b"), hstr("a".repeat(3900))]);
  const REFS = frame(9, 0, 1, Buffer.alloc(16384, 0xbe));
  sh0 = await shed();
  await calm("hpack-bomb", await attack("hpack-bomb", async (x) => {
    x.s.write(frame(1, END_STREAM, 1, Buffer.concat([getBlock("/"), big])));
    await flood(x, () => REFS, Date.now() + RUN);
  }), sh0);

  // Rapid Reset: 開いてすぐRST_STREAM（CANCEL）。攻撃の後、同じ接続の普通の要求が200で返る（取り消したストリームの枠が返っている）
  const hdr = getBlock("/");
  const rr = await attack("rapid-reset", async (x) => {
    let sid = 1;
    await flood(x, () => {
      const b = Buffer.concat([frame(1, END_STREAM | END_HEADERS, sid, hdr), frame(3, 0, sid, Buffer.from([0, 0, 0, 8]))]);
      sid += 2;
      (x as any).next = sid;
      return b;
    }, Date.now() + RUN);
  });
  {
    const x = rr.find((y) => y.closed === 0);
    let ok = false;
    if (x) {
      const sid = (x as any).next as number;
      x.s.write(frame(1, END_STREAM | END_HEADERS, sid, hdr));
      const until = Date.now() + 3000;
      while (Date.now() < until && !x.heads.has(sid) && x.closed === 0) {
        await sleep(20);
      }
      ok = x.heads.get(sid) === 0x88;
    }
    check("rapid-reset: a normal request on the attacking connection after the burst", ok, x ? "no 200" : "every attacking connection was closed");
    rr.forEach((y) => y.s.destroy());
  }

  // MadeYouReset: 開いてすぐWINDOW_UPDATE(0)（サーバーにRST_STREAMを送らせる）。こちらが送るRST_STREAMも返すだけの制御フレームに数えてGOAWAY
  sh0 = await shed();
  await calm("madeyoureset", await attack("madeyoureset", async (x) => {
    let sid = 1;
    await flood(x, () => {
      const b = Buffer.concat([frame(1, END_STREAM | END_HEADERS, sid, hdr), frame(8, 0, sid, Buffer.alloc(4))]);
      sid += 2;
      return b;
    }, Date.now() + RUN);
  }), sh0);

  // window-stall: 初期の窓を0にして/bigを8本頼み、WINDOW_UPDATEを送らない。HEADERSは届き、送りの間隔（1秒）の後で閉じられる
  const W0 = frame(4, 0, 0, Buffer.from([0, 4, 0, 0, 0, 0]));
  const ws = await attack("window-stall", async (x) => {
    for (let i = 0; i < 8; i++) {
      x.s.write(frame(1, END_STREAM | END_HEADERS, 1 + 2 * i, getBlock("/big")));
    }
    const until = x.t0 + STALL + 1000;
    while (Date.now() < until && x.closed === 0) {
      await sleep(50);
    }
  }, W0);
  const late = ws.filter((x) => x.closed === 0 || x.closed - x.t0 > STALL || x.heads.size === 0);
  check("window-stall: HEADERS arrive and the stalled connection is closed within sendWait", late.length === 0, late.map((x) => `closed=${x.closed ? x.closed - x.t0 : "no"} heads=${x.heads.size}`).join(", "));

  check("the server still answers after all attacks", await alive(), "no 200");
  console.log(`h2flood: ${passed} passed, ${failed} failed`);
  process.exit(failed === 0 ? 0 : 1);
}

main().catch((e) => {
  console.log(`FAIL h2flood: ${e}`);
  process.exit(1);
});
