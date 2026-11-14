// pgscramvec: SCRAM-SHA-256 / SCRAM-SHA-256-PLUS（tls-server-end-point）の決定的なベクタを node:crypto で作る（std の SCRAM と独立の実装）。
//   使い方: node --experimental-strip-types --no-warnings scripts/pgscramvec.ts cert-sha1.pem cert-sha256.pem cert-sha384.pem cert-sha512.pem > testdata/pg/scram.txt
//   （証明書は名前を cert-<署名のハッシュ>.pem に — sha256 は testdata/crypto/httparena-server.crt・他は openssl req -x509 -sha1 / -sha384〔P-384〕/ -sha512 の自己署名。DER は出力に hex で入る）
//   形: 空行で区切った場面ごとに `鍵 値` の行。値は印字可能な ASCII（SCRAM のメッセージ）か hex（cbind・DER のハッシュ）
//   場面 = RFC 7677 3 節の例（照合のため — 期待のproof / ServerSignatureもRFCの値と一致することをここで確認する）+
//          与えた証明書ごとの PLUS（署名のハッシュに応じた束縛のハッシュ — RFC 5929 4.1）+ 平文の `y,,`（束縛できるがサーバが出さなかった）
import { createHash, createHmac, pbkdf2Sync, X509Certificate } from "node:crypto";
import { readFileSync } from "node:fs";

const hmac = (k: Buffer, m: string | Buffer) => createHmac("sha256", k).update(m).digest();
const sha = (alg: string, m: Buffer) => createHash(alg).update(m).digest();
const xor = (a: Buffer, b: Buffer) => Buffer.from(a.map((x, i) => x ^ b[i]));

type Case = { name: string; user: string; password: string; cnonce: string; snonce: string; salt: Buffer; iters: number; gs2: string; cbind: Buffer; mech: string };

function run(c: Case): string[] {
    const bare = `n=${c.user},r=${c.cnonce}`;
    const first = `${c.gs2}${bare}`;
    const nonce = c.cnonce + c.snonce;
    const sfirst = `r=${nonce},s=${c.salt.toString("base64")},i=${c.iters}`;
    const cbindMsg = Buffer.concat([Buffer.from(c.gs2, "latin1"), c.cbind]).toString("base64");
    const noProof = `c=${cbindMsg},r=${nonce}`;
    const am = `${bare},${sfirst},${noProof}`;
    const sp = pbkdf2Sync(c.password, c.salt, c.iters, 32, "sha256");
    const ck = hmac(sp, "Client Key");
    const proof = xor(ck, hmac(sha("sha256", ck), am));
    const sfinal = `v=${hmac(hmac(sp, "Server Key"), am).toString("base64")}`;
    return [`case ${c.name}`, `mech ${c.mech}`, `user ${c.user}`, `password ${c.password}`, `cnonce ${c.cnonce}`, `gs2 ${c.gs2}`,
        `cbind ${c.cbind.toString("hex")}`, `client-first ${first}`, `server-first ${sfirst}`, `client-final ${noProof},p=${proof.toString("base64")}`,
        `server-final ${sfinal}`];
}

// RFC 7677 3 節（user / pencil）
const rfc = run({ name: "rfc7677", mech: "SCRAM-SHA-256", user: "user", password: "pencil", cnonce: "rOprNGfwEbeRWgbNEkqO",
    snonce: "%hvYDpWUa2RaTCAfuxFIlj)hNlF$k0", salt: Buffer.from("W22ZaJ0SNY7soEsUEjb6gQ==", "base64"), iters: 4096, gs2: "n,,", cbind: Buffer.alloc(0) });
const want = ["client-final c=biws,r=rOprNGfwEbeRWgbNEkqO%hvYDpWUa2RaTCAfuxFIlj)hNlF$k0,p=dHzbZapWIk4jUhN+Ute9ytag9zjfMHgsqmmiz7AndVQ=",
    "server-final v=6rriTRBi23WpRR/wtup+mMhUZUn/dB5nLTJRsjl95G4="];
for (const w of want) if (!rfc.includes(w)) { console.error(`RFC 7677 mismatch: ${w}`); process.exit(1); }
const out: string[][] = [rfc];

// PG の形（user は空 — PG はスタートアップの user を使い SCRAM の n= を読まない）
const base = { user: "", password: "pencil", cnonce: "fyko+d2lbbFgONRv9qkxdawL", snonce: "3rfcNHYJY1ZVvWVs7j", salt: Buffer.from("QSXCR+Q6sek8bf92", "base64"), iters: 4096 };
out.push(run({ ...base, name: "plain", mech: "SCRAM-SHA-256", gs2: "n,,", cbind: Buffer.alloc(0) }));
out.push(run({ ...base, name: "plain-y", mech: "SCRAM-SHA-256", gs2: "y,,", cbind: Buffer.alloc(0) }));
for (const path of process.argv.slice(2)) {
    const pem = readFileSync(path, "utf8");
    const cert = new X509Certificate(pem);
    const der = cert.raw;
    // 署名のアルゴリズムは OpenSSL の印字から（node は公開しない）— 呼び手が名前に入れる: cert-<hash>.pem
    const m = /cert-(sha1|sha256|sha384|sha512)\.pem$/.exec(path);
    if (!m) { console.error(`name the file cert-<hash>.pem: ${path}`); process.exit(2); }
    const h = m[1] === "sha384" ? "sha384" : m[1] === "sha512" ? "sha512" : "sha256";
    const lines = run({ ...base, name: `plus-${m[1]}`, mech: "SCRAM-SHA-256-PLUS", gs2: "p=tls-server-end-point,,", cbind: sha(h, der) });
    lines.splice(1, 0, `cert ${der.toString("hex")}`);
    out.push(lines);
}
console.log(out.map((c) => c.join("\n")).join("\n\n"));
