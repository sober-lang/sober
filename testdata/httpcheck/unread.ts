// 読まない相手への常駐の検査: n本の接続で GET /big（256 KiB）をk本ずつパイプラインで送り、受けずに止める。
// サーバー（pid）のRSSの増えが上限（MiB）以下なら0で終わる。正しい形では、接続1本の常駐はレスポンスの列の上限（64 KiB）と、カーネルの送信バッファが
// 受け取った分のレスポンスまで（GET /bigで1本あたり約3 MiB）。列に上限が無い形では、切片1つ分のレスポンス（1本あたり約35 MiB）
//   node unread.ts <port> <pid> <上限 MiB> [n] [k]
import net from "node:net";
import { readFileSync } from "node:fs";
const [port, pid, lim, n = "8", k = "400"] = process.argv.slice(2);
const rss = () => +(readFileSync(`/proc/${pid}/status`, "utf8").match(/VmRSS:\s+(\d+)/)![1]) / 1024;
const ok = (s: net.Socket) => new Promise<void>((res) => { s.write("GET / HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n"); s.on("data", () => {}); s.on("close", () => res()); });
// 温める（スロットとページの初回の確保を数えない）
await ok(net.connect(+port, "127.0.0.1"));
const r0 = rss();
const req = "GET /big HTTP/1.1\r\nHost: x\r\n\r\n".repeat(+k);
const socks: net.Socket[] = [];
for (let i = 0; i < +n; i++) {
  const s = net.connect(+port, "127.0.0.1", () => { s.write(req); s.pause(); });
  s.on("error", () => {});
  socks.push(s);
}
let peak = 0;
for (let t = 0; t < 20; t++) { await new Promise((r) => setTimeout(r, 100)); peak = Math.max(peak, rss() - r0); }
for (const s of socks) s.destroy();
const v = `unread: ${n} conns × ${k} pipelined GET /big, server RSS +${peak.toFixed(1)} MiB (limit ${lim} MiB)`;
if (peak > +lim) { console.log(`FAIL ${v}`); process.exit(1); }
console.log(`ok ${v}`);
