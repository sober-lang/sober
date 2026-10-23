// flatecheck の復号の双子（report-1021）: node:zlib の符号化の形を広く作って <dir> に書き、<dir>/index に「パス 種類（z / gz）」を並べる。
// testdata/flatecheck/go/（Go の compress/flate・gzip の固定の資料）も index に足す。main.sober の第 3 引数がこの index を解き、check.ts が
// node:zlib で解いた結果と照合する。形: level 0〜9 × 戦略（既定・FILTERED・HUFFMAN_ONLY・RLE・FIXED）× 窓の大きさ（9〜15）× memLevel（1・9）・
// gzip の頭の欄（FNAME・FCOMMENT・FEXTRA・FHCRC・FTEXT）を手で組んだメンバ・複数メンバ・空の入力
//   node --experimental-strip-types twin.ts <dir> <dataset.json> <go-dir>
import { readFileSync, readdirSync, writeFileSync } from "node:fs";
import { constants, crc32, deflateRawSync, gzipSync } from "node:zlib";

const [dir, dataset, goDir] = process.argv.slice(2);
const index: string[] = [];
let n = 0;
const put = (b: Buffer, kind: "z" | "gz") => {
    const p = `${dir}/t${n++}.${kind}`;
    writeFileSync(p, b);
    index.push(`${p} ${kind}`);
};

const words = (len: number, seed: number) => {
    const vocab = "the of and to in is was that for on are with as his they be at one have this from or had by word sober region".split(" ");
    let x = seed >>> 0 || 1;
    const out: string[] = [];
    let total = 0;
    while (total < len) {
        x ^= x << 13; x >>>= 0; x ^= x >>> 17; x ^= x << 5; x >>>= 0;
        const w = vocab[x % vocab.length] + (x % 9 === 0 ? "\n" : " ");
        out.push(w);
        total += w.length;
    }
    return Buffer.from(out.join("")).subarray(0, len);
};
const rnd = (len: number, k: number, seed: number) => {
    const b = Buffer.alloc(len);
    let x = seed >>> 0 || 1;
    for (let i = 0; i < len; i++) { x ^= x << 13; x >>>= 0; x ^= x >>> 17; x ^= x << 5; x >>>= 0; b[i] = x % k; }
    return b;
};

const inputs = [
    readFileSync(dataset),
    words(40000, 7),
    rnd(20000, 256, 3),
    rnd(30000, 4, 5),
    Buffer.alloc(70000),
    Buffer.alloc(0),
    Buffer.from("a"),
    Buffer.concat([words(3000, 9), rnd(70000, 256, 11), words(3000, 13)]),  // stored の切れ（65535）を跨ぐ
];
const strategies = [constants.Z_DEFAULT_STRATEGY, constants.Z_FILTERED, constants.Z_HUFFMAN_ONLY, constants.Z_RLE, constants.Z_FIXED];
for (const src of inputs) {
    for (let level = 0; level <= 9; level++) put(deflateRawSync(src, { level }), "z");
    for (const strategy of strategies) put(deflateRawSync(src, { level: 6, strategy }), "z");
    for (let windowBits = 9; windowBits <= 15; windowBits += 3) put(deflateRawSync(src, { level: 9, windowBits }), "z");
    put(deflateRawSync(src, { level: 9, memLevel: 1 }), "z");
    put(gzipSync(src, { level: 6 }), "gz");
}

// gzip のメンバを頭の欄つきで手で組む（RFC 1952 2.3 — FLG の bit 0 FTEXT・1 FHCRC・2 FEXTRA・3 FNAME・4 FCOMMENT）
const member = (src: Buffer, flg: number) => {
    const parts: Buffer[] = [Buffer.from([0x1f, 0x8b, 8, flg, 0x78, 0x56, 0x34, 0x12, 0, 3])];
    if (flg & 4) parts.push(Buffer.from([5, 0, 65, 66, 1, 0, 0]));
    if (flg & 8) parts.push(Buffer.from("name.txt\0"));
    if (flg & 16) parts.push(Buffer.from("a comment\0"));
    if (flg & 2) {
        const h = Buffer.concat(parts);
        const c = Buffer.alloc(2);
        c.writeUInt16LE(crc32(h) & 0xffff, 0);
        parts.push(c);
    }
    parts.push(deflateRawSync(src, { level: 6 }));
    const t = Buffer.alloc(8);
    t.writeUInt32LE(crc32(src), 0);
    t.writeUInt32LE(src.length % 2 ** 32, 4);
    parts.push(t);
    return Buffer.concat(parts);
};
const s1 = words(5000, 17), s2 = rnd(700, 256, 19);
for (const flg of [0, 1, 2, 4, 8, 16, 31 - 2, 31]) put(member(s1, flg), "gz");
put(Buffer.concat([member(s1, 8), member(s2, 0), member(Buffer.alloc(0), 2)]), "gz");
put(Buffer.concat([gzipSync(s2), gzipSync(s1, { level: 1 })]), "gz");

for (const f of readdirSync(goDir).sort()) {
    if (f.endsWith(".z")) index.push(`${goDir}/${f} z`);
    else if (f.endsWith(".gz")) index.push(`${goDir}/${f} gz`);
}
writeFileSync(`${dir}/index`, index.join("\n") + "\n");
