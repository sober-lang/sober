// std/internal/x509 の信頼ストアの生成（Mozilla NSS の certdata.txt → src/std/internal/x509/roots.sober）。
// 採るのは CKO_NSS_TRUST の CKA_TRUST_SERVER_AUTH が CKT_NSS_TRUSTED_DELEGATOR の証明書だけ（発行者とシリアルで CKO_CERTIFICATE と突き合わせる）。
// CKA_NSS_SERVER_DISTRUST_AFTER（UTCTime の文字 — この日時より後に notBefore を持つ証明書は信頼しない）は UNIX 秒に（無ければ 0）。
//   node --experimental-strip-types scripts/nssroots.ts <certdata.txt> <NSS のタグ> <取得日> <certdata.txt の SHA-256> > src/std/internal/x509/roots.sober
// 呼ぶのは scripts/rootstore.sh（取得・銘・照合）
import * as fs from "node:fs";

type Obj = Map<string, string | Buffer>;

function parse(text: string): Obj[] {
  const lines = text.split("\n");
  const objs: Obj[] = [];
  let cur: Obj | null = null;
  for (let i = 0; i < lines.length; i++) {
    const l = lines[i];
    if (l.startsWith("#") || l.trim() === "") continue;
    const m = l.match(/^(\S+)\s+(\S+)(?:\s+(.*))?$/);
    if (!m) continue;
    const [, attr, type, rest] = m;
    if (attr === "CKA_CLASS") {
      cur = new Map();
      objs.push(cur);
    }
    if (!cur) continue;
    if (type === "MULTILINE_OCTAL") {
      const bytes: number[] = [];
      for (i++; lines[i] !== "END"; i++) {
        for (const o of lines[i].split("\\").slice(1)) bytes.push(parseInt(o, 8));
      }
      cur.set(attr, Buffer.from(bytes));
    } else {
      cur.set(attr, rest ?? type);
    }
  }
  return objs;
}

// "YYMMDDHHMMSSZ"（UTCTime の文字）→ UNIX 秒
function utc(b: Buffer): number {
  const s = b.toString("latin1");
  const m = s.match(/^(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)Z$/);
  if (!m) throw new Error(`distrust-after: ${s}`);
  const yy = Number(m[1]);
  return Date.UTC(yy < 50 ? 2000 + yy : 1900 + yy, Number(m[2]) - 1, Number(m[3]), Number(m[4]), Number(m[5]), Number(m[6])) / 1000;
}

const [file, tag, date, sha] = process.argv.slice(2);
const objs = parse(fs.readFileSync(file, "utf8"));
const key = (o: Obj) => (o.get("CKA_ISSUER") as Buffer).toString("hex") + "/" + (o.get("CKA_SERIAL_NUMBER") as Buffer).toString("hex");
const trusted = new Set<string>();
for (const o of objs) {
  if (o.get("CKA_CLASS") === "CKO_NSS_TRUST" && o.get("CKA_TRUST_SERVER_AUTH") === "CKT_NSS_TRUSTED_DELEGATOR") trusted.add(key(o));
}
const rows: string[] = [];
for (const o of objs) {
  if (o.get("CKA_CLASS") !== "CKO_CERTIFICATE" || !trusted.has(key(o))) continue;
  const d = o.get("CKA_NSS_SERVER_DISTRUST_AFTER");
  const da = d instanceof Buffer ? utc(d) : 0;
  const label = String(o.get("CKA_LABEL")).replace(/^"|"$/g, "").replace(/[^ -~]/g, "?").replace(/["\\]/g, "?");
  rows.push(`        "${da} ${(o.get("CKA_VALUE") as Buffer).toString("base64")} ${label}",`);
}
process.stdout.write(`package x509

// 生成物 — scripts/rootstore.sh --regen（scripts/nssroots.ts）が Mozilla NSS の certdata.txt から作る。手で直さない（bump = scripts/rootstore.sh --regen <タグ>）。
// 出所の銘: NSS ${tag}・取得 ${date}・certdata.txt SHA-256 ${sha}
// 採るのはサーバ認証の信頼の起点（CKT_NSS_TRUSTED_DELEGATOR）の ${rows.length} 本。1 行 = \`distrust-after の UNIX 秒〔無ければ 0〕 DER の base64 名前\`

func rootLines() []string {
    return []string{
${rows.join("\n")}
    }
}
`);
