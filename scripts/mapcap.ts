// mapcap.ts <port> [hold <n>]: hold なら n 本を張って1回ずつ GET し、"held <n>" を出して標準入力が閉じるまで待つ（写像の数を数える側が読む）。
// 無ければ: 接続を1本ずつ足し（keep-alive で GET を1回）、応答の無い接続（閉じられた・2秒で応答なし）が20本出るか4,000本で止める。
// その後、応答のあった接続の全部へ同時に GET をもう1回送り、全部が 200 で答えるかを数える。出力 = "held <H> shed <S> recheck <R>"
import net from "node:net";
const port = Number(process.argv[2]);
const req = "GET /t HTTP/1.1\r\nHost: x\r\n\r\n";
function ask(s: net.Socket): Promise<boolean> {
  return new Promise((res) => {
    let done = false;
    const fin = (v: boolean) => { if (!done) { done = true; clearTimeout(t); s.off("data", onData); s.off("close", onClose); res(v); } };
    const onData = (b: Buffer) => fin(b.toString().startsWith("HTTP/1.1 200"));
    const onClose = () => fin(false);
    const t = setTimeout(() => fin(false), 2000);
    s.on("data", onData); s.on("close", onClose);
    s.write(req);
  });
}
function open(): Promise<net.Socket | null> {
  return new Promise((res) => {
    const s = net.connect(port, "127.0.0.1");
    s.on("error", () => res(null));
    s.once("connect", async () => res((await ask(s)) ? s : (s.destroy(), null)));
  });
}
if (process.argv[3] === "hold") {
  const n = Number(process.argv[4]);
  const hs: (net.Socket | null)[] = [];
  for (let i = 0; i < n; i += 100) hs.push(...(await Promise.all(Array.from({ length: Math.min(100, n - i) }, () => open()))));
  console.log(`held ${hs.filter((x) => x).length}`);
  process.stdin.resume();
  await new Promise((r) => process.stdin.once("end", r));
  process.exit(0);
}
const held: net.Socket[] = [];
let shed = 0;
for (let i = 0; i < 4000 && shed < 20; i++) {
  const s = await open();
  if (s) held.push(s); else shed++;
}
const ok = (await Promise.all(held.map((s) => ask(s)))).filter((v) => v).length;
console.log(`held ${held.length} shed ${shed} recheck ${ok}`);
for (const s of held) s.destroy();
process.exit(0);
