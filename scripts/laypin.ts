// scripts/laypin.shの2の判定: 基準の表ta・固定したビルドの表tb・2つのELF（SOBER_NUMNOPATCH=1）・変えた関数のキー（の前置き）。
// 両方の表にあるキーの関数のうち、変えた関数のほかは、同じ番地・同じ大きさ・ELFの同じバイト列であること。
// 動いた関数の数と理由（大きさがスロットを超えた・大きさが変わった・バイト列だけ違う・動いた関数へのcallだけ違う〔許す〕・キーが消えた・新しいキー）を印字する
import { readFileSync } from "node:fs";

const [ta, tb, ea, eb, edited, mode] = process.argv.slice(2);
// mode = "addr": 番地と大きさだけを見る（グローバルを固定しないと、コードの終わりが動いたときに種類2の再配置の中身が変わる）
const BYTES = mode !== "addr";
const CODE_OFFSET = 0xb0;
type F = { beg: number; size: number; slot: number };
const read = (p: string) => {
    const m = new Map<string, F>();
    for (const l of readFileSync(p, "utf8").split("\n")) {
        if (!l.startsWith("f ")) continue;
        const [, beg, size, slot, ...k] = l.split(" ");
        m.set(k.join(" "), { beg: +beg, size: +size, slot: +slot });
    }
    return m;
};
const A = read(ta), Bt = read(tb);
const ba = readFileSync(ea), bb = readFileSync(eb);
const isEdited = (k: string) => k === edited || k.startsWith(edited + "/") || k.startsWith(edited + "$") || k.startsWith(edited + "#");
const why = new Map<string, string[]>();
const add = (r: string, k: string) => why.set(r, [...(why.get(r) ?? []), k]);
// 動いた関数（両方の表にあり番地が違う・新しいキー）の範囲（Bの表の番地）
const moved: [number, number][] = [];
for (const [k, b] of Bt) { const a = A.get(k); if (!a || a.beg !== b.beg) moved.push([b.beg, b.beg + b.size]); }
// 違いが全部、動いた関数へのcall（e8 rel32）のrel32だけか
const callsMoved = (beg: number, x: Buffer, y: Buffer) => {
    let p = 0;
    while (p < x.length) {
        if (x[p] === y[p]) { p++; continue; }
        const q = [p - 3, p - 2, p - 1, p].find(o => o >= 1 && o + 4 <= y.length && y[o - 1] === 0xe8);
        if (q === undefined) return false;
        const t = beg + q + 4 + y.readInt32LE(q);
        if (!moved.some(([lo, hi]) => t >= lo && t < hi)) return false;
        p = q + 4;
    }
    return true;
};
const STRICT = new Set(["bytes", "outgrew-slot", "moved", "resized", "gone", "new"]);
let same = 0;
for (const [k, a] of A) {
    const b = Bt.get(k);
    if (!b) { add("gone", k); continue; }
    if (a.beg === b.beg && a.size === b.size) {
        const x = ba.subarray(CODE_OFFSET + a.beg, CODE_OFFSET + a.beg + a.size);
        const y = bb.subarray(CODE_OFFSET + b.beg, CODE_OFFSET + b.beg + b.size);
        if (x.equals(y) || !BYTES) same++;
        else add(callsMoved(a.beg, x, y) ? "calls-moved" : "bytes", k);
    } else if (b.size > a.slot) add("outgrew-slot", k);
    else add(a.size === b.size ? "moved" : "resized", k);
}
for (const k of Bt.keys()) if (!A.has(k)) add("new", k);
const stray = [...why.entries()].filter(([r]) => STRICT.has(r)).flatMap(([r, ks]) => ks.filter(k => !isEdited(k)).map(k => `${r}:${k}`));
const tally = [...why.entries()].map(([r, ks]) => `${r}=${ks.length}`).join(" ");
console.log(`laypin cold-edit: fns=${A.size} same=${same} ${tally} stray=${stray.length}` + (stray.length ? ": " + stray.slice(0, 12).join(" ") : ""));
process.exit(stray.length ? 1 : 0);
