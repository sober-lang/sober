// flatecheck の照合（scripts/flatecheck.sh — report-712）: testdata/flatecheck/main.sober の出力の行ごとに
//   ① <名前>.<level>.z を外の zlib（node:zlib の inflateRawSync）で解いて <名前>.in とバイト一致
//   ② Sober の crc32.Sum（入力・出力）が zlib.crc32 と一致
//   ③ 大きさの黄金（名前 level 出力の長さ 出力の CRC-32 — 決定的な符号器: 同じ入力で同じバイト）と一致
//   ④ <名前>.<level>.gz（gzip）を gunzipSync で解いて一致・形が「頭 10 バイト（1f 8b 08 00・MTIME 0・XFL・OS 255）+ 同じ level の .z + CRC-32 + 長さ」
// を見て、level ごとの Sober / zlib（deflateRawSync の同じ level）の大きさの比と、json-comp の巡回（json25 / 40 / 50）の gzip の平均の大きさ
// （Sober と zlib の gzipSync — report-704 A.2 の物差し）を要約に出す。
//   ⑤ 率の線（734 — 4 バイトハッシュの裁定・ユーザー 2026-10-16 (A) で「1 形も悪化しない」から読み替え）: 形 × level ごとの Sober / zlib が
//      実戦形（json25 / 40 / 50・dataset）≤ 1.004（既知の最大 = dataset:5 の 1.0028 — 旧符号器は 1.0089 で、4 バイト化で改善した上の値）・
//      人工形 ≤ 1.026（記帳: rnd2:2 の 1.0253 が既知の最大 — 4 バイト鎖は同じ chain 予算で
//      深く探して一致が伸び、greedy の内部挿入の門〔ml ≤ maxIns〕が閉じて表が疎になる、zlib の level 表との共進化のずれ。
//      dataset:8/9 は +1〜2 バイト〔長さ 3 の一致はハッシュが見ない — lv8/9 のみ・採点経路の lv6 は無関係〕）、
//      全形の合算 Sober / zlib ≤ 1.0（zlib より縮むこと）
//      → 2026-10-24 ユーザー裁定（report-1116 — Go / zlib を錨にした線を廃し、lv4〜6 で一致の中の挿入の省略〔B3〕を採る）: lv4〜6 の線は
//      実測の最大 × 1.005（lv4 実戦 1.039〔json40 1.0332〕/ 人工 1.115〔noisy 1.1087〕・lv5 1.012〔dataset 1.0069〕/ 1.115〔noisy 1.1086〕・
//      lv6 1.018〔json50 1.0128〕/ 1.118〔noisy 1.1120〕）。lv1〜3・7〜9 は上の値のまま。全形の合算は ≤ 1.006（実測 1.0007 × 1.005 — zlib より縮む約束は廃止）
//   ⑥ 復号の双子（report-1021）: 「twin <i> 長さ CRC-32」の行ごとに、index（twin.ts — node:zlib と Go の符号化）の i 番目の列を node:zlib で解いた結果と
//      <dir>/twin<i>.out（Sober の flate.Decode / gzip.Decode）がバイト一致・index の全部の列に twin の行がある（Sober の自分の符号化の往復と maxSize の境目は main.sober が FAIL の行で出す）
//   node --experimental-strip-types check.ts <list> <dir> <golden> <index> [--regen]
import { readFileSync, writeFileSync } from "node:fs";
import { crc32, deflateRawSync, gunzipSync, gzipSync, inflateRawSync } from "node:zlib";

const [list, dir, golden, index, flag] = process.argv.slice(2);
const twinIndex = readFileSync(index, "utf8").split("\n").filter((l) => l !== "").map((l) => l.split(" "));
let twins = 0;
const lines = readFileSync(list, "utf8").split("\n").filter((l) => l !== "");
let fail = 0;
const bad = (m: string) => { fail++; if (fail <= 10) console.log("FAIL " + m); };
const gold: string[] = [];
const sober = new Array(10).fill(0), zl = new Array(10).fill(0), jgz = new Array(10).fill(0), jzl = new Array(10).fill(0);
for (const l of lines) {
    if (l.startsWith("FAIL")) { bad(l); continue; }
    if (l.startsWith("twin ")) {
        const [, is, len] = l.split(" ");
        const [path, kind] = twinIndex[Number(is)];
        const src = readFileSync(path);
        const want = kind === "gz" ? gunzipSync(src) : inflateRawSync(src);
        const got = readFileSync(`${dir}/twin${is}.out`);
        if (!got.equals(want) || got.length !== Number(len)) bad(`twin ${is} ${path}: Sober ${got.length} bytes != zlib ${want.length} bytes`);
        twins++;
        continue;
    }
    const [name, lvs, inlen, incrc, outlen, outcrc] = l.split(" ");
    const lv = Number(lvs);
    const src = readFileSync(`${dir}/${name}.in`);
    const z = readFileSync(`${dir}/${name}.${lv}.z`);
    if (src.length !== Number(inlen)) bad(`${name} ${lv}: input length ${src.length} != ${inlen}`);
    if (z.length !== Number(outlen)) bad(`${name} ${lv}: output length ${z.length} != ${outlen}`);
    if (crc32(src) !== Number(incrc)) bad(`${name} ${lv}: crc32(input) ${incrc} != zlib ${crc32(src)}`);
    if (crc32(z) !== Number(outcrc)) bad(`${name} ${lv}: crc32(output) ${outcrc} != zlib ${crc32(z)}`);
    let back: Buffer | null = null;
    try { back = inflateRawSync(z); } catch (e) { bad(`${name} ${lv}: inflate: ${(e as Error).message}`); }
    if (back !== null && !back.equals(src)) bad(`${name} ${lv}: round trip differs (${back.length} vs ${src.length} bytes)`);
    if (lv === 0 && z.length > src.length + 5 * Math.max(1, Math.ceil(src.length / 65535))) bad(`${name} 0: stored ${z.length} > bound`);
    const gz = readFileSync(`${dir}/${name}.${lv}.gz`);
    let gback: Buffer | null = null;
    try { gback = gunzipSync(gz); } catch (e) { bad(`${name} ${lv}: gunzip: ${(e as Error).message}`); }
    if (gback !== null && !gback.equals(src)) bad(`${name} ${lv}: gzip round trip differs`);
    const xfl = lv === 9 ? 2 : lv === 1 ? 4 : 0;
    const head = Buffer.from([0x1f, 0x8b, 8, 0, 0, 0, 0, 0, xfl, 255]);
    const tail = Buffer.alloc(8);
    tail.writeUInt32LE(crc32(src), 0);
    tail.writeUInt32LE(src.length % 2 ** 32, 4);
    if (!gz.equals(Buffer.concat([head, z, tail]))) bad(`${name} ${lv}: gzip bytes are not head + deflate + crc32 + isize`);
    if (/^json(25|40|50)$/.test(name)) { jgz[lv] += gz.length; jzl[lv] += gzipSync(src, { level: lv }).length; }
    gold.push(`${name} ${lv} ${outlen} ${outcrc}`);
    sober[lv] += z.length;
    const zlen = deflateRawSync(src, { level: lv }).length;
    zl[lv] += zlen;
    // ⑤ 率の線（level 0 の stored は ① の bound が見る）
    if (lv > 0) {
        const real = /^(json(25|40|50)|dataset)$/.test(name);
        const lim = lv === 4 ? (real ? 1.039 : 1.115) : lv === 5 ? (real ? 1.012 : 1.115) : lv === 6 ? (real ? 1.018 : 1.118) : real ? 1.004 : 1.026;
        if (z.length > zlen * lim) bad(`${name} ${lv}: size ${z.length} > zlib ${zlen} × ${lim}（率の線 — check.ts ⑤）`);
    }
}
if (lines.length === 0) bad("no output");
if (twins !== twinIndex.length) bad(`twins: ${twins} decoded of ${twinIndex.length}`);
const g = gold.join("\n") + "\n";
if (flag === "--regen") {
    writeFileSync(golden, g);
} else {
    const want = readFileSync(golden, "utf8");
    if (want !== g) {
        const w = want.split("\n");
        const got = g.split("\n");
        for (let i = 0; i < Math.max(w.length, got.length); i++) {
            if (w[i] !== got[i]) { bad(`golden line ${i + 1}: want "${w[i] ?? ""}" got "${got[i] ?? ""}"`); }
        }
    }
}
const stot = sober.slice(1).reduce((a, b) => a + b, 0), ztot = zl.slice(1).reduce((a, b) => a + b, 0);
if (stot > ztot * 1.006) bad(`total size ${stot} > zlib ${ztot} × 1.006（全形の合算の線 — check.ts ⑤）`);
const ratio = sober.map((s, i) => `${i}:${(s / zl[i]).toFixed(4)}`).join(" ");
const json = [1, 6, 9].map((l) => `gzip ${l} ${(jgz[l] / 3).toFixed(1)} vs zlib ${(jzl[l] / 3).toFixed(1)}`).join(" / ");
console.log(`flatecheck: ${lines.length - twins} encodings (deflate + gzip) round-trip through zlib and Sober's Decode · ${twins} zlib / Go streams decoded ≡ zlib · size vs zlib (same level) ${ratio} · json-comp mean ${json} · fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
