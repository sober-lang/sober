// reqinst の道具（scripts/reqinst.sh が呼ぶ）。
//   node scripts/reqinst.ts cli <port> <バッチの数> <題材> [<バッチの大きさ>]   1接続で題材のリクエストを16本（既定）ずつバッチで送り、バッチのレスポンスを受けてから次のバッチ（pipelined -p 16の形・1ならkeep-aliveのリクエスト1本ずつ）
//   node scripts/reqinst.ts acct <cg少> <cg多> <バッチの差>  callgrind（--dump-instr=yes）2本の差から「命令/リクエスト 熱い 64 B 行の数」を1行で
// 題材 = 下のSUBJの鍵（asyncdbだけは別のサーバ〔bench/asyncdb〕と代役のPG〔bench/pgstub〕を相手に測る — scripts/reqinst.sh）。足すときはSUBJにリクエストを1本・bench/ratchet.txtに `srv/<鍵> ireq` と `srv/<鍵> hot64` の2行（bench/httparena/README.mdのreqinstの節）
import * as net from "node:net";
import { readFileSync } from "node:fs";

const SUBJ: Record<string, string> = {
  // ヘッダ1行の最小のリクエスト（HttpArenaのpipelinedの種目の形）
  pipeline: "GET /pipeline HTTP/1.1\r\nHost: localhost\r\n\r\n",
  // ヘッダ8行のリクエスト（ブラウザの頭の形）— 頭の行ごとの費用はこちらでしか見えない
  hdr: "GET /baseline11?a=1&b=2 HTTP/1.1\r\nHost: localhost:8080\r\nUser-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0\r\n" +
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: identity\r\n" +
    "Connection: keep-alive\r\nCache-Control: no-cache\r\nPragma: no-cache\r\n\r\n",
  // async-db の 20 行（std/pg のプールから準備済みの文で読み、行を JSON に — 相手は代役の PG）
  asyncdb: "GET /async-db?min=10&max=50&limit=20 HTTP/1.1\r\nHost: localhost\r\n\r\n",
};
const BATCH = 16;

function cli(port: number, batches: number, subj: string, bsz: number): void {
  const one = SUBJ[subj];
  if (one === undefined) { console.error(`reqinst: 題材 ${subj} が無い（${Object.keys(SUBJ).join(" ")}）`); process.exit(2); }
  const batch = one.repeat(bsz);
  const s = net.connect(port, "127.0.0.1");
  let left = batches, got = 0, buf = "";
  s.on("connect", () => s.write(batch));
  s.on("data", (d) => {
    buf += d.toString("latin1");
    let i;
    while ((i = buf.indexOf("\r\n\r\n")) >= 0) {
      const head = buf.slice(0, i);
      if (!/^HTTP\/1\.1 200 /.test(head)) { console.error(`reqinst: 200 でない応答: ${head.split("\r\n")[0]}`); process.exit(1); }
      const m = /content-length:\s*(\d+)/i.exec(head);
      const cl = m ? +m[1] : 0;
      if (buf.length < i + 4 + cl) break;
      buf = buf.slice(i + 4 + cl);
      got++;
      if (got === bsz) { got = 0; left--; if (left === 0) { s.end(); return; } s.write(batch); }
    }
  });
  s.on("close", () => { if (left !== 0) console.error(`reqinst: 残り ${left} 束で切れた`); process.exit(left === 0 ? 0 : 1); });
  s.on("error", (e) => { console.error(e); process.exit(2); });
}

// callgrind の番地ごとの自己の命令数（.pair/tools/cgacct.ts の parse と同じ読み方 — calls= の次の行は呼び先の包括の費用なので数えない）
function selfCost(path: string): Map<number, number> {
  const self = new Map<number, number>();
  let last = 0, skipNext = false;
  const pos = (t: string): number => {
    if (t === "*") return last;
    const sign = t[0] === "+" ? 1 : t[0] === "-" ? -1 : 0;
    const u = sign === 0 ? t : t.slice(1);
    const v = parseInt(u, u.startsWith("0x") ? 16 : 10);
    return sign === 0 ? v : last + sign * v;
  };
  for (const line of readFileSync(path, "utf8").split("\n")) {
    const c0 = line[0];
    if (c0 === "0" || c0 === "+" || c0 === "-" || c0 === "*") {
      const f = line.split(" ");
      last = pos(f[0]);
      if (skipNext) { skipNext = false; continue; }
      self.set(last, (self.get(last) ?? 0) + Number(f[f.length - 1]));
    } else if (line.startsWith("calls=")) skipNext = true;
  }
  return self;
}

function acct(a: string, b: string, k: number): void {
  const sa = selfCost(a), sb = selfCost(b);
  const n = k * BATCH;
  let ta = 0, tb = 0;
  for (const v of sa.values()) ta += v;
  for (const v of sb.values()) tb += v;
  // 熱い64 B行 = リクエストあたり0.45回以上実行された命令を含む行。回数は16本のバッチの刻み（1/16）で並ぶので、境目を刻みの間に置く
  // （0.5ちょうど〔バッチの半分のリクエストで通る行〕を境目にすると、計測の揺れで0.495 / 0.500を往復して数が出入りする）
  const hot = new Set<number>();
  for (const [ad, v] of sb) if ((v - (sa.get(ad) ?? 0)) / n >= 0.45) hot.add(Math.floor(ad / 64));
  console.log(`ireq ${((tb - ta) / n).toFixed(1)} hot64 ${hot.size}`);
}

const [mode, ...rest] = process.argv.slice(2);
if (mode === "cli") cli(+rest[0], +rest[1], rest[2], rest[3] === undefined ? BATCH : +rest[3]);
else if (mode === "acct") acct(rest[0], rest[1], +rest[2]);
else { console.error("reqinst.ts cli <port> <束> <題材> | acct <cg少> <cg多> <束の差>"); process.exit(2); }
