// p256vec: P-256 の基点のスカラー倍 d·G の決定的なベクタを node:crypto で作る（std/internal/p256 と独立の実装）。
//   使い方: node --experimental-strip-types --no-warnings scripts/p256vec.ts > testdata/crypto/p256_base.txt
//   形: 1 行 1 組 `d Q`（d = 32 バイトの大きい端の hex・Q = 非圧縮 0x04 ‖ X ‖ Y の hex）。d は端の値（1・2・3・n − 1・n − 2・2^255・2^256 − 2^224 の近く）と
//   SHA-256 から導いた 16 個（決定的 — 乱数に依らない）
import { createECDH, createHash } from "node:crypto";

const n = BigInt("0xffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551");
const hex32 = (x: bigint) => x.toString(16).padStart(64, "0");
const ds: bigint[] = [1n, 2n, 3n, 4n, 15n, 16n, 17n, n - 1n, n - 2n, n - 3n, 1n << 255n, (1n << 128n) + 1n, n >> 1n, (n >> 1n) + 1n];
for (let i = 0; i < 16; i++) {
    const h = BigInt("0x" + createHash("sha256").update(`p256vec ${i}`).digest("hex"));
    ds.push((h % (n - 1n)) + 1n);
}
for (const d of ds) {
    const e = createECDH("prime256v1");
    e.setPrivateKey(Buffer.from(hex32(d), "hex"));
    console.log(`${hex32(d)} ${e.getPublicKey("hex", "uncompressed")}`);
}
