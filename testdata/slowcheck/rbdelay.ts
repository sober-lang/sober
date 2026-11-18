// 受信バッファの固定の試し（scripts/slowcheck.sh — epoll の経路・遅延つき）: 1本の接続で pipelined の GET を total バイト送り、
// 応答を全部読む間（50 ms ごと）と後のサーバーの側の rb（ss）の最大と終わりの値を出す。RTT が ms の網では自動調整が受信バッファを広げる
// （loopback の数十 µs の RTT では、epoll の経路の読み方では広がらない）
//   node rbdelay.ts <port> [total]
import net from "node:net";
import { execFileSync } from "node:child_process";
const port = +process.argv[2];
const total = +(process.argv[3] ?? 4194304);
const one = "GET / HTTP/1.1\r\nHost: x\r\n\r\n";
const n = Math.ceil(total / one.length);
const s = net.connect(port, "127.0.0.1");
await new Promise((r) => s.on("connect", r));
let got = 0, buf = "", maxRb = 0;
const t0 = Date.now();
const tick = setInterval(() => {
  const out = execFileSync("ss", ["-tmnH", "state", "established", `( sport = :${port} )`]).toString();
  for (const m of out.matchAll(/rb(\d+)/g)) maxRb = Math.max(maxRb, +m[1]);
}, 50);
const done = new Promise<void>((res) => s.on("data", (d: Buffer) => {
  buf += d.toString("latin1");
  let i; while ((i = buf.indexOf("ok\n")) >= 0) { got++; buf = buf.slice(i + 3); }
  if (got >= n) res();
}));
for (let k = 0; k < n; k += 256) s.write(one.repeat(Math.min(256, n - k)));
await done;
clearInterval(tick);
const out = execFileSync("ss", ["-tmnH", "state", "established", `( sport = :${port} )`]).toString();
console.log(`bytes=${total} ms=${Date.now() - t0} rb_end=${[...out.matchAll(/rb(\d+)/g)].map((m) => m[1]).join(",")} rb_max=${maxRb}`);
s.destroy();
