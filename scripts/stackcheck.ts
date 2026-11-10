// stackcheck の客: keep-alive の baseline の 3 形（GET・POST Content-Length・POST chunked — bench の get / post_cl / post_chunked と同じ形）を conns 本の接続で n 往復ずつ
import { connect } from "node:net";
const [port, conns, n] = process.argv.slice(2).map(Number);
const reqs = [
  "GET /baseline11?a=13&b=42 HTTP/1.1\r\nHost: x\r\n\r\n",
  "POST /baseline11?a=13&b=42 HTTP/1.1\r\nHost: x\r\nContent-Length: 2\r\n\r\n20",
  "POST /baseline11?a=13&b=42 HTTP/1.1\r\nHost: x\r\nTransfer-Encoding: chunked\r\n\r\n2\r\n20\r\n0\r\n\r\n",
];
let done = 0, ok = 0;
for (let c = 0; c < conns; c++) {
  const s = connect(port, "127.0.0.1");
  let i = 0, buf = "";
  const next = () => { if (i >= n) { s.end(); return; } s.write(reqs[i % 3]); i++; };
  s.on("connect", next);
  s.on("data", d => { buf += d.toString(); const k = buf.indexOf("\r\n\r\n"); if (k >= 0) { const m = /Content-Length: (\d+)/i.exec(buf); const len = m ? +m[1] : 0; if (buf.length >= k + 4 + len) { buf = buf.slice(k + 4 + len); ok++; next(); } } });
  s.on("close", () => { if (++done === conns) console.log(`ok ${ok}`); });
  s.on("error", () => {});
}
