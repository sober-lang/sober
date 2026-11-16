// client.ts <port>: TLSで繋ぎ、サーバの最初の1行を受けたら1行送り、100 ms後にRSTで切る（SO_LINGER 0。net.Socket.resetAndDestroy）
import * as net from "node:net";
import * as tls from "node:tls";
const port = +process.argv[2];
const raw = net.connect(port, "127.0.0.1");
const s = tls.connect({ socket: raw, rejectUnauthorized: false });
let sent = false;
s.on("data", () => {
  if (sent) return;
  sent = true;
  s.write("x\n");
  setTimeout(() => { raw.resetAndDestroy(); }, 100);
});
s.on("error", () => {});
raw.on("error", () => {});
setTimeout(() => { if (!sent) { console.log("client: no greeting"); process.exit(1); } }, 3000);
