// acceptretry の客（scripts/acceptretry.sh）: check.ts <port> <n> <k>
// n 本を同時に張ってそれぞれ GET を1回送り、3秒の間に答えた本数（answered）と、答えのない本数（pending — サーバーの fd が尽きて受けられず、
// カーネルの待ち行列に残った接続）を数える。答えた接続のうち k 本を閉じ、5秒の間に pending のうち答えた本数（late）を数える。
// 最後に全部を閉じ、新しい接続の GET が 5 秒以内に 200 で答えるか（fresh = 1 / 0）。出力 = "answered A pending P late L fresh F"
import net from "node:net";
const [port, n, k] = [Number(process.argv[2]), Number(process.argv[3]), Number(process.argv[4])];
const req = "GET /t HTTP/1.1\r\nHost: x\r\n\r\n";
type C = { s: net.Socket; ok: boolean };
const cs: C[] = [];
for (let i = 0; i < n; i++) {
  const c: C = { s: net.connect(port, "127.0.0.1"), ok: false };
  c.s.on("error", () => {});
  c.s.on("connect", () => c.s.write(req));
  c.s.on("data", (b) => { if (b.toString().startsWith("HTTP/1.1 200")) c.ok = true; });
  cs.push(c);
}
const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
await sleep(3000);
const answered = cs.filter((c) => c.ok);
const pending = cs.filter((c) => !c.ok && !c.s.destroyed);
for (const c of answered.slice(0, k)) c.s.destroy();
await sleep(5000);
const late = pending.filter((c) => c.ok).length;
for (const c of cs) c.s.destroy();
const fresh = await new Promise<number>((res) => {
  const t = setTimeout(() => res(0), 5000);
  const s = net.connect(port, "127.0.0.1");
  s.on("error", () => { clearTimeout(t); res(0); });
  s.on("connect", () => s.write(req));
  s.on("data", (b) => { clearTimeout(t); s.destroy(); res(b.toString().startsWith("HTTP/1.1 200") ? 1 : 0); });
});
console.log(`answered ${answered.length} pending ${pending.length} late ${late} fresh ${fresh}`);
process.exit(0);
