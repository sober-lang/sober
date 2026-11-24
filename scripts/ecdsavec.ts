// ecdsavec: P-256 / SHA-256 の決定的な ECDSA の署名（RFC 6979）のベクタを openssl で作る（std/internal/p256 と独立の実装）。
//   使い方: node --experimental-strip-types --no-warnings scripts/ecdsavec.ts > testdata/crypto/ecdsa_p256_det.txt
//   形: 1 行 1 組 `d h r s`（どれも 32 バイトの大きい端の hex）。d は端の値と SHA-256 から導いた決定的な値・h は端の値（0・n − 1・n・n + 1・2^256 − 1 —
//   n 以上の h は bits2octets の簡約を通る）と SHA-256 の値。openssl の pkeyutl -pkeyopt nonce-type:1（RFC 6979）で署名する
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";

const n = BigInt("0xffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551");
const hex32 = (x: bigint) => x.toString(16).padStart(64, "0");
const sha = (s: string) => BigInt("0x" + createHash("sha256").update(s).digest("hex"));
const ds: bigint[] = [1n, 2n, 3n, n - 1n, n - 2n, 1n << 255n, n >> 1n, BigInt("0xc9afa9d845ba75166b5c215767b1d6934e50c3db36e89b127b8a622b120f6721")];
for (let i = 0; i < 8; i++) ds.push((sha(`ecdsavec d ${i}`) % (n - 1n)) + 1n);
const hs: bigint[] = [0n, 1n, n - 1n, n, n + 1n, (1n << 256n) - 1n, sha("sample"), sha("test")];

const w = mkdtempSync(join(tmpdir(), "ecdsavec-"));
try {
    ds.forEach((d, i) => {
        // SEC1 の ECPrivateKey（version 1・d・parameters = prime256v1）
        writeFileSync(join(w, "k.der"), Buffer.from(`30310201010420${hex32(d)}a00a06082a8648ce3d030107`, "hex"));
        execFileSync("openssl", ["ec", "-inform", "DER", "-in", join(w, "k.der"), "-out", join(w, "k.pem")], { stdio: "ignore" });
        // 鍵ごとに 3 つの h（端の値を巡回 + SHA-256 の値）
        const mine = [hs[i % hs.length], hs[(i + 3) % hs.length], sha(`ecdsavec h ${i}`)];
        for (const h of mine) {
            writeFileSync(join(w, "h.bin"), Buffer.from(hex32(h), "hex"));
            execFileSync("openssl", ["pkeyutl", "-sign", "-inkey", join(w, "k.pem"), "-in", join(w, "h.bin"), "-pkeyopt", "nonce-type:1", "-pkeyopt", "digest:sha256", "-out", join(w, "sig.der")]);
            const ints = execFileSync("openssl", ["asn1parse", "-inform", "DER", "-in", join(w, "sig.der")], { encoding: "utf8" })
                .split("\n").filter((l) => l.includes("INTEGER")).map((l) => BigInt("0x" + l.split(":").pop()!.trim()));
            if (ints.length !== 2) throw new Error("asn1parse");
            console.log(`${hex32(d)} ${hex32(h)} ${hex32(ints[0])} ${hex32(ints[1])}`);
        }
    });
} finally {
    rmSync(w, { recursive: true, force: true });
}
