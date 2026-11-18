// 一斉の到着の試し（scripts/slowcheck.sh）の相手: mode hs = n 本の TLS の握手を一度に始める（サーバーのワーカーが握手で埋まり、
// 受け付けのループの番が減る — 握手の受けと送りのたびに ring に入るので ACCEPT の完了は進む）・raw = n 本の素の TCP を一度に繋ぐ（何も送らない）。
// hold ms 保ってから閉じる
//   node tlsflood.ts <hs|raw> <port> <n> [hold]
import net from "node:net";
import tls from "node:tls";
const [mode, port, n, hold] = [process.argv[2], +process.argv[3], +process.argv[4], +(process.argv[5] ?? 3000)];
const ss: net.Socket[] = [];
let ok = 0;
for (let i = 0; i < n; i++) {
  const s = mode === "hs" ? tls.connect({ port, host: "127.0.0.1", rejectUnauthorized: false }, () => { ok++; s.end(); }) : net.connect(port, "127.0.0.1");
  s.on("error", () => {});
  ss.push(s);
}
await new Promise((r) => setTimeout(r, hold));
console.log(`${mode} ${n} done ${ok}`);
for (const s of ss) s.destroy();
process.exit(0);
