// x509-limbo（C2SP — Apache-2.0）の limbo.json から std/internal/x509 の網に載せる題材だけを抜き出す（testdata/x509/limbo/limbo.json）。
// 採る名前空間 = rfc5280・webpki・pathlen・cve・invalid・pathological（bettertls 9572 本と online は採らない）。
// 外す機能 = has-crl（失効は見ない）・name-constraint-dn（DNS / IP 以外の制約）・has-policy-constraints（ポリシーは処理しない）・has-mldsa（対象外の署名）・
// max-chain-depth（深さの上限は固定）・CLIENT の検証。欄は検証に要るものだけ残す
//   node --experimental-strip-types scripts/limbo.ts <limbo.json> <x509-limbo のコミット> > testdata/x509/limbo/limbo.json
import * as fs from "node:fs";

const [file, commit] = process.argv.slice(2);
const l = JSON.parse(fs.readFileSync(file, "utf8"));
const spaces = new Set(["rfc5280", "webpki", "pathlen", "cve", "invalid", "pathological"]);
const drop = new Set(["has-crl", "name-constraint-dn", "has-policy-constraints", "has-mldsa", "max-chain-depth"]);
const out = [];
for (const t of l.testcases) {
  if (!spaces.has(t.id.split("::")[0]) || t.validation_kind !== "SERVER") continue;
  if ((t.features ?? []).some((f: string) => drop.has(f))) continue;
  const name = t.expected_peer_name;
  out.push({
    id: t.id,
    trusted: t.trusted_certs,
    inters: t.untrusted_intermediates,
    peer: t.peer_certificate,
    time: t.validation_time ? Math.floor(Date.parse(t.validation_time) / 1000) : 0,
    nameKind: name ? name.kind : "",
    name: name ? name.value : "",
    eku: (t.extended_key_usage ?? []).join(","),
    want: t.expected_result,
  });
}
process.stdout.write(JSON.stringify({ source: `github.com/C2SP/x509-limbo ${commit}`, cases: out }, null, 0) + "\n");
