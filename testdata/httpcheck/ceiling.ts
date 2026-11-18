// 天井の検査の相手（scripts/httpcheck.sh — サーバーは testdata/httpcheck/ceiling.sober・conns: 256）:
// ① GET /grow（予約を越えて32 MiBを積む）: 接続は何も受けずに閉じられる
// ② 1本ずつ順に、120,000バイトの本文のPOSTを送って応答を受け、keep-aliveのまま待たせる（1本あたりLedgerで約390 KiB・実際の常駐で約300 KB —
//    受けのバッファが残る）。使い捨ての接続32本で温めた後、8本と40本の2点で、サーバーのRSSの傾きとLedgerの傾き（used + borrowed = 予約 + 借り）を測り、
//    RSS ≤ Ledger ≤ 1.5 × RSS（固定費 + 計上済みの上限の和が、実際の常駐を下回らず、離れすぎない）
// ③ 待っている接続40本を残したまま、新しい接続16本で GET / が全部応答する ④ /ledger が died=1 cut=1
// ⑤ 待っている接続を全部閉じた後: 温めた後からのRSSの増え ≤ 根の計上（返したスロットに残す常駐の定数 ワーカー数 × R を含む）。大きい本文を受けた接続が
//    終わった後に残る常駐が、計上の外へ出ていないこと（W1だけ — W8はワーカーの間の配り方とtaskのチャンクの列で余白が0.2〜1 MBに揺れる）
//   node ceiling.ts <port> <サーバーのpid> [slope]  — slope があるときだけ②の傾きを照合する（W1。W8の傾きはワーカーの間の配り方で346〜458 KBに揺れる）
import net from "node:net";
import { readFileSync } from "node:fs";
const [port, pid, slope = ""] = process.argv.slice(2);
const fail = (m: string) => { console.log(`FAIL ceiling: ${m}`); process.exit(1); };
const rss = () => +(readFileSync(`/proc/${pid}/status`, "utf8").match(/VmRSS:\s+(\d+)/)![1]) * 1024;
// 1回のリクエストを送り、応答（ヘッダと本文）を1つ受けるか、閉じられるまで待つ
function ask(s: net.Socket, req: string): Promise<string> {
  return new Promise((res) => {
    let got = "";
    const done = (v: string) => { s.removeAllListeners("data"); s.removeAllListeners("close"); res(v); };
    s.on("data", (d) => {
      got += d.toString("latin1");
      const h = got.indexOf("\r\n\r\n");
      const m = got.match(/content-length:\s*(\d+)/i);
      if (h >= 0 && m && got.length >= h + 4 + +m[1]) done(got.slice(0, 12) + " " + got.slice(h + 4));
    });
    s.on("close", () => done(got === "" ? "closed" : `partial ${got.slice(0, 40)}`));
    s.write(req);
  });
}
const open = () => new Promise<net.Socket>((res, rej) => { const s = net.connect(+port, "127.0.0.1", () => res(s)); s.on("error", rej); });
const get = (p: string) => `GET ${p} HTTP/1.1\r\nHost: x\r\n\r\n`;
// /ledgerの欄（接続1本で聞いて閉じる — 聞いた接続の予約は数えない: 閉じた後の値ではないので、2点の差で消える）
async function ledger(): Promise<Record<string, number>> {
  const s = await open();
  const l = await ask(s, get("/ledger"));
  s.destroy();
  return Object.fromEntries(l.slice(13).split(" ").map((kv) => kv.split("=")).map(([k, v]) => [k, +v]));
}
const g = await ask(await open(), get("/grow"));
if (g !== "closed") fail(`/grow: want the connection closed with nothing sent, got [${g.slice(0, 60)}]`);
const body = "a".repeat(120000);
const idle: net.Socket[] = [];
// 温める: 使い捨ての接続32本で大きい本文を受けて閉じる（ワーカーごとに初めて大きい本文を受けたときの確保を、2点の差に入れない）
for (let i = 0; i < 32; i++) {
  const s = await open();
  const r = await ask(s, `POST /u HTTP/1.1\r\nHost: x\r\nContent-Length: ${body.length}\r\n\r\n${body}`);
  if (r !== "HTTP/1.1 200 120000") fail(`warm-up body ${i}: got [${r.slice(0, 60)}]`);
  s.destroy();
}
const warm = rss();
const points: { n: number; rss: number; led: number }[] = [];
for (const upto of [8, 40]) {
  while (idle.length < upto) {
    const s = await open();
    s.on("error", () => {});
    const r = await ask(s, `POST /u HTTP/1.1\r\nHost: x\r\nContent-Length: ${body.length}\r\n\r\n${body}`);
    if (r !== "HTTP/1.1 200 120000") fail(`big body ${idle.length}: got [${r.slice(0, 60)}]`);
    idle.push(s);
  }
  await new Promise((r) => setTimeout(r, 200));
  const v = await ledger();
  points.push({ n: upto, rss: rss(), led: v.used + v.borrowed });
}
const per = (k: "rss" | "led") => (points[1][k] - points[0][k]) / (points[1].n - points[0].n);
const pr = per("rss"), pl = per("led");
if (slope !== "" && !(pr <= pl && pl <= 1.5 * pr)) fail(`per idle connection: RSS ${pr.toFixed(0)} B, ledger (reserve + borrowed) ${pl.toFixed(0)} B — want RSS ≤ ledger ≤ 1.5 × RSS`);
const fresh = await Promise.all(Array.from({ length: 16 }, async () => { const s = await open(); const r = await ask(s, get("/")); s.destroy(); return r; }));
const bad = fresh.filter((r) => r !== "HTTP/1.1 200 0");
if (bad.length > 0) fail(`${bad.length} of 16 new connections with ${idle.length} idle: [${bad[0].slice(0, 60)}]`);
const v = await ledger();
for (const s of idle) s.destroy();
if (v.died !== 1 || v.cut !== 1) fail(`/ledger: died=${v.died} cut=${v.cut}, want 1 1`);
await new Promise((r) => setTimeout(r, 500));
const ve = await ledger();
const left = rss() - warm;
if (slope !== "" && left > ve.root) fail(`after the idle connections closed: RSS grew ${left} B since the warm-up, root ledger ${ve.root} B — want RSS growth ≤ ledger`);
console.log(`ok ceiling: /grow closed, ${idle.length} idle after a 120000-byte body (per connection: RSS ${pr.toFixed(0)} B, ledger ${pl.toFixed(0)} B), 16 new connections answered, died=1 cut=1, after closing: RSS +${left} B since the warm-up ≤ root ledger ${ve.root} B`);
