// 逐次の符号器の照合（scripts/flatecheck.sh — 0.7.0 便 8 の段 8-4b）: std/internal/deflate の deflate_test.sober の TestStreamDump が DEFLATE_DUMP に書いた
// 例（s<k>.in = 入力・s<k>.gz = Feed の返りを繋いで End まで — gzip の 1 メンバ・s<k>.idx = Feed ごとの「出力の終わり 入力の終わり」の行）ごとに
//   ① gunzipSync で解いて入力とバイト一致
//   ② 各 Feed の返りまでの接頭辞（頭 10 バイトの後）を inflateRawSync（finishFlush = Z_SYNC_FLUSH）で解くと、そこまでの入力とバイト一致（sync flush の約束）
//   ③ 逐次の createGunzip に Feed の返りを 1 つずつ書いて flush し、出てきた分がそこまでの入力とバイト一致（受け手の逐次の読み — compress + stream の到着の形）
//   node --experimental-strip-types stream.ts <dir>
import { readFileSync, readdirSync } from "node:fs";
import { constants, createGunzip, gunzipSync, inflateRawSync } from "node:zlib";

const dir = process.argv[2];
let fail = 0;
let pieces = 0;
const bad = (m: string) => { fail++; if (fail <= 10) console.log("FAIL stream " + m); };
const names = readdirSync(dir).filter((f) => f.endsWith(".idx")).map((f) => f.slice(0, -4)).sort();
for (const n of names) {
    const inp = readFileSync(`${dir}/${n}.in`);
    const gz = readFileSync(`${dir}/${n}.gz`);
    const idx = readFileSync(`${dir}/${n}.idx`, "utf8").split("\n").filter((l) => l !== "").map((l) => l.split(" ").map(Number));
    if (!gunzipSync(gz).equals(inp)) bad(`${n}: gunzipSync differs from the input`);
    for (const [oe, ie] of idx) {
        const got = inflateRawSync(gz.subarray(10, oe), { finishFlush: constants.Z_SYNC_FLUSH });
        if (!got.equals(inp.subarray(0, ie))) { bad(`${n}: prefix up to ${oe} does not decode to the input up to ${ie}`); break; }
    }
    const g = createGunzip();
    const chunks: Buffer[] = [];
    g.on("data", (c: Buffer) => chunks.push(c));
    let prev = 0;
    for (const [oe, ie] of idx) {
        await new Promise<void>((r) => g.write(gz.subarray(prev, oe), () => g.flush(constants.Z_SYNC_FLUSH, () => r())));
        prev = oe;
        pieces++;
        if (!Buffer.concat(chunks).equals(inp.subarray(0, ie))) { bad(`${n}: createGunzip after the emit ending at ${oe} has not produced the input up to ${ie}`); break; }
    }
    g.end(gz.subarray(prev));
}
if (names.length === 0) bad("no dumped stream");
console.log(`stream: ${names.length} streams · ${pieces} emits — gunzipSync / sync-flushed prefixes / createGunzip ≡ the input, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
