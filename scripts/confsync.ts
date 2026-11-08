// confsync: 準拠文書（docs/conformance/*.md）の印の中 ≡ テストの実物からの生成。
//   源 = ① `sober test -v` の出力の conf の行（テストが通った後の言明 — 再生の当たりなら一瞬）② examples の Wycheproof の黄金（.out）
//        ③ 手で回す相互接続の網の記録（testdata/conformance/interop/*.txt — scripts/confrecord.sh が書く）④ 主張の表（testdata/conformance/claims.tsv）
//   conf の行の形: `conf: <鍵> <数>`・`conf-item: <鍵> <値…>`・`conf-why: <鍵> <理由（ja）>`・`conf-kind: <鍵> intentional|planned`
//   規律: テストの出す鍵は全部どこかの塊が使う（使われない言明は赤）・主張の証拠は全部今の出力に在る（無い証拠は赤）・理由の英訳は
//   testdata/conformance/en.tsv（ja → en — 無い訳・使われない訳は赤）
//   印: `<!-- confsync:begin NAME -->` 〜 `<!-- confsync:end NAME -->` の間を生成し直す（言語はファイル名の .ja.md で決まる）
//   node --experimental-strip-types scripts/confsync.ts [--check]
import * as fs from "node:fs";
import * as path from "node:path";
import { spawnSync } from "node:child_process";

const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const check = process.argv.includes("--check");
const SOBER = process.env.SOBER ?? path.join(ROOT, "bin/sober");

// conf の行を出す（か主張の証拠になる）テストの package
const PKGS = [
  "std/internal/ec", "std/internal/x509", "std/crypto/password", "std/internal/sha512", "std/internal/record", "std/tls",
  "std/internal/hsc", "std/http/server", "std/http/client", "std/net", "testdata/stdtest/stdurl",
];
const EXAMPLES = ["crypto_wycheproof_aead", "crypto_wycheproof_aesgcm", "crypto_wycheproof_mac", "crypto_wycheproof_pss", "crypto_wycheproof_x25519"];
const INTEROP = ["tls", "http", "dns"];

const errors: string[] = [];
const fail = (m: string) => errors.push(m);

// ── 事実の収集
const nums = new Map<string, number>();
const items = new Map<string, string[]>();
const whys = new Map<string, string>();
const kinds = new Map<string, string>();
const passed = new Set<string>();
const used = new Set<string>();
const interopMeta = new Map<string, { commit: string; date: string }>();

function take(line: string) {
  let m = line.match(/^conf: (\S+) (\d+)$/);
  if (m) {
    if (nums.has(m[1])) fail(`conf: ${m[1]} が 2 回`);
    nums.set(m[1], Number(m[2]));
    return;
  }
  m = line.match(/^conf-item: (\S+) (.+)$/);
  if (m) {
    const l = items.get(m[1]) ?? [];
    l.push(m[2]);
    items.set(m[1], l);
    return;
  }
  m = line.match(/^conf-why: (\S+) (.+)$/);
  if (m) {
    whys.set(m[1], m[2]);
    return;
  }
  m = line.match(/^conf-kind: (\S+) (intentional|planned)$/);
  if (m) {
    kinds.set(m[1], m[2]);
    return;
  }
  if (line.startsWith("conf")) fail(`読めない conf の行: ${line}`);
}

const r = spawnSync(SOBER, ["test", "-v", ...PKGS], { cwd: ROOT, encoding: "utf8", maxBuffer: 1 << 28 });
const out = (r.stdout ?? "") + (r.stderr ?? "");
if (r.status !== 0) {
  process.stdout.write(out.split("\n").filter((l) => /FAIL|error/.test(l)).slice(0, 30).join("\n") + "\n");
  console.error("confsync: テストが通らない — 言明の源が無い");
  process.exit(1);
}
for (const l of out.split("\n")) {
  const t = l.match(/^ok +(\S+\.Test\w+)$/);
  if (t) passed.add(t[1]);
  take(l);
}
for (const e of EXAMPLES) {
  for (const l of fs.readFileSync(path.join(ROOT, "examples", e + ".out"), "utf8").split("\n")) {
    const m = l.match(/^([\w-]+): (\d+) tests(?: \((\d+) AES-128 \/ 96-bit nonce\))?, 0 failed(?: \(all-zero shared (\d+)\))?$/);
    if (!m) continue;
    nums.set(`wycheproof/${m[1]}`, Number(m[2]));
    if (m[3]) nums.set(`wycheproof/${m[1]}/aes128-iv96`, Number(m[3]));
    if (m[4]) nums.set(`wycheproof/${m[1]}/all-zero`, Number(m[4]));
  }
}
for (const n of INTEROP) {
  const f = path.join(ROOT, "testdata/conformance/interop", n + ".txt");
  if (!fs.existsSync(f)) {
    fail(`記録が無い: ${f}（scripts/${n}interop.sh を回す）`);
    continue;
  }
  const ls = fs.readFileSync(f, "utf8").trim().split("\n");
  const commit = ls.find((l) => l.startsWith("commit "))?.slice(7);
  const date = ls.find((l) => l.startsWith("date "))?.slice(5);
  if (!commit || !date || !/^[0-9a-f]{7,40}( \(dirty\))?$/.test(commit) || !/^\d{4}-\d{2}-\d{2}$/.test(date)) fail(`記録の形が違う: ${f}`);
  interopMeta.set(n, { commit: commit ?? "?", date: date ?? "?" });
  for (const l of ls) if (l.startsWith("conf")) take(l);
}

// ── 訳
const en = new Map<string, string>();
const enUsed = new Set<string>();
for (const l of fs.readFileSync(path.join(ROOT, "testdata/conformance/en.tsv"), "utf8").split("\n")) {
  if (l === "" || l.startsWith("#")) continue;
  const [ja, e] = l.split("\t");
  if (!e) fail(`en.tsv の行の形: ${l}`);
  en.set(ja, e);
}
function tr(ja: string, lang: Lang): string {
  if (lang === "ja") return ja;
  const e = en.get(ja);
  enUsed.add(ja);
  if (!e) {
    fail(`訳が無い（testdata/conformance/en.tsv）: ${ja}`);
    return ja;
  }
  return e;
}

// ── 読み出し（使った印を付ける）
function num(k: string): number {
  used.add(k);
  const v = nums.get(k);
  if (v === undefined) {
    fail(`conf の数が無い: ${k}`);
    return -1;
  }
  return v;
}
function list(k: string): string[] {
  used.add(k);
  const v = items.get(k);
  if (!v) {
    fail(`conf-item が無い: ${k}`);
    return [];
  }
  return v;
}
function why(k: string): string {
  used.add("why:" + k);
  const v = whys.get(k);
  if (!v) fail(`conf-why が無い: ${k}`);
  return v ?? "?";
}
function kind(k: string): string {
  used.add("kind:" + k);
  const v = kinds.get(k);
  if (!v) fail(`conf-kind が無い: ${k}`);
  return v ?? "?";
}
const fmt = (n: number) => n.toLocaleString("en-US");

type Lang = "ja" | "en";
const L = (lang: Lang, ja: string, e: string) => (lang === "ja" ? ja : e);

// ── 主張の表（claims.tsv: 塊 \t 状態 \t 時期 \t ja \t en \t 証拠…）
type Claim = { block: string; status: string; when: string; ja: string; en: string; ev: string[] };
const claims: Claim[] = [];
for (const [i, l] of fs.readFileSync(path.join(ROOT, "testdata/conformance/claims.tsv"), "utf8").split("\n").entries()) {
  if (l === "" || l.startsWith("#")) continue;
  const f = l.split("\t");
  if (f.length !== 6) {
    fail(`claims.tsv ${i + 1}: 欄が 6 でない`);
    continue;
  }
  const c = { block: f[0], status: f[1], when: f[2], ja: f[3], en: f[4], ev: f[5] === "-" ? [] : f[5].split(" ") };
  if (!["yes", "partial", "intentional", "planned"].includes(c.status)) fail(`claims.tsv ${i + 1}: 状態 ${c.status}`);
  if ((c.status === "yes" || c.status === "partial") && c.ev.length === 0) fail(`claims.tsv ${i + 1}: 対応の主張に証拠が無い — ${c.ja}`);
  if (c.status === "planned" && !/^\d+\.\d+$/.test(c.when)) fail(`claims.tsv ${i + 1}: 未実装の主張に時期が無い — ${c.ja}`);
  if (c.status !== "planned" && c.when !== "-") fail(`claims.tsv ${i + 1}: 時期は未実装の主張だけ — ${c.ja}`);
  claims.push(c);
}

function evidence(t: string, lang: Lang): string {
  let m = t.match(/^test:(\S+\.Test\w+)$/);
  if (m) {
    if (!passed.has(m[1])) fail(`証拠のテストが通っていない（か無い）: ${m[1]}`);
    return "`" + m[1] + "`";
  }
  m = t.match(/^conf:(\S+)$/);
  if (m) return `${m[1]} = ${fmt(num(m[1]))}`;
  m = t.match(/^item:(\S+?):(.+)$/);
  if (m) {
    const want = m[2].replace(/_/g, " ");
    if (!list(m[1]).some((x) => x === want || x.startsWith(want + " "))) fail(`証拠の conf-item が無い: ${m[1]} ${want}`);
    return `${m[1]}: ${want}`;
  }
  m = t.match(/^interop:(\w+):(\S+)$/);
  if (m) {
    const k = `interop/${m[1]}`;
    const want = m[2].replace(/_/g, " ");
    const ok = (items.get(k) ?? []).some((x) => x === want || x.startsWith(want + " ")) || nums.has(`${k}`);
    used.add(k);
    if (!ok) fail(`証拠の相互接続の記録が無い: ${k} ${want}`);
    const meta = interopMeta.get(m[1]);
    return L(lang, `相互接続 ${m[1]}: ${want}（${meta?.date}）`, `interop ${m[1]}: ${want} (${meta?.date})`);
  }
  m = t.match(/^gold:([^:]+):(.+)$/);
  if (m) {
    const s = fs.readFileSync(path.join(ROOT, m[1]), "utf8");
    const want = m[2].replace(/_/g, " ");
    if (!s.includes(want)) fail(`証拠の黄金に無い: ${m[1]} に「${want}」`);
    return "`" + m[1] + "`: " + want.replace(/\|/g, "\\|");
  }
  fail(`証拠の形が読めない: ${t}`);
  return t;
}

function statusText(c: Claim, lang: Lang): string {
  switch (c.status) {
    case "yes": return L(lang, "対応", "Supported");
    case "partial": return L(lang, "一部", "Partial");
    case "intentional": return L(lang, "意図して非対応", "Not supported (by design)");
    default: return L(lang, `未実装（${c.when} 圏）`, `Not yet (planned: ${c.when})`);
  }
}

const rendered = new Map<string, number>(); // `${lang}\t${行の番号}` → 書いた回数（どの行も言語ごとにちょうど 1 回）
function claimTable(block: string, statuses: string[], lang: Lang): string[] {
  const cs = claims.map((c, i) => [c, i] as const).filter(([c]) => c.block === block && statuses.includes(c.status));
  if (cs.length === 0) fail(`主張の塊が空: ${block} ${statuses.join(",")}`);
  const planned = statuses.includes("planned");
  const o = planned
    ? [L(lang, "| 項目 | 時期 | 今の挙動の証拠 |", "| Item | Planned | Evidence of today's behavior |"), "|---|---|---|"]
    : [L(lang, "| 項目 | 状態 | 証拠 |", "| Item | Status | Evidence |"), "|---|---|---|"];
  for (const [c, i] of cs) {
    const k = `${lang}\t${i}`;
    rendered.set(k, (rendered.get(k) ?? 0) + 1);
    const ev = c.ev.map((e) => evidence(e, lang)).join("<br>") || "—";
    o.push(`| ${lang === "ja" ? c.ja : c.en} | ${planned ? L(lang, `${c.when} 圏`, c.when) : statusText(c, lang)} | ${ev} |`);
  }
  return o;
}

// ── 生成の塊
const ALERTS: Record<string, string> = {
  "10": "unexpected_message", "20": "bad_record_mac", "22": "record_overflow", "40": "handshake_failure", "47": "illegal_parameter",
  "50": "decode_error", "51": "decrypt_error", "70": "protocol_version", "120": "no_application_protocol",
};

type Row = [string, string, string, string]; // 規格 / 出所 / 鍵 / 備考の鍵（無ければ ""）
const VECTORS: [string, Row[]][] = [
  ["AES-128-GCM", [["NIST SP 800-38D", "Wycheproof aes_gcm_test.json", "wycheproof/aes-gcm", "wycheproof/aes-gcm/aes128-iv96"]]],
  ["ChaCha20-Poly1305", [["RFC 8439", "Wycheproof chacha20_poly1305_test.json", "wycheproof/chacha20-poly1305", ""]]],
  ["HMAC-SHA256", [["RFC 2104", "Wycheproof hmac_sha256_test.json", "wycheproof/hmac-sha256", ""]]],
  ["HKDF-SHA256", [["RFC 5869", "Wycheproof hkdf_sha256_test.json", "wycheproof/hkdf-sha256", ""]]],
  ["X25519", [["RFC 7748", "Wycheproof x25519_test.json", "wycheproof/x25519", "wycheproof/x25519/all-zero"]]],
  ["RSA-PSS 2048 (verify)", [
    ["RFC 8017", "Wycheproof rsa_pss_2048_sha256_mgf1_32_test.json", "wycheproof/rsa-pss-2048-sha256-mgf1-32", ""],
    ["RFC 8017", "Wycheproof rsa_pss_2048_sha256_mgf1_0_test.json", "wycheproof/rsa-pss-2048-sha256-mgf1-0", ""],
    ["RFC 8017", "Go crypto/rsa (SHA-256/384/512)", "go/rsa-pss", ""],
  ]],
  ["ECDSA P-256 (verify)", [
    ["FIPS 186-5", "Wycheproof ecdsa_secp256r1_sha256_test.json (DER)", "wycheproof/ecdsa_secp256r1_sha256_test.json", ""],
    ["FIPS 186-5", "Wycheproof ecdsa_secp256r1_sha256_p1363_test.json", "wycheproof/ecdsa_secp256r1_sha256_p1363_test.json", ""],
  ]],
  ["ECDSA P-384 (verify)", [
    ["FIPS 186-5", "Wycheproof ecdsa_secp384r1_sha384_test.json (DER)", "wycheproof/ecdsa_secp384r1_sha384_test.json", ""],
    ["FIPS 186-5", "Wycheproof ecdsa_secp384r1_sha384_p1363_test.json", "wycheproof/ecdsa_secp384r1_sha384_p1363_test.json", ""],
  ]],
  ["ECDSA P-256 / P-384 (verify)", [["FIPS 186-5", "NIST CAVP SigVer", "cavp/ecdsa-sigver", ""]]],
  ["SHA-512 / SHA-384", [
    ["FIPS 180-4", "FIPS 180-4 (\"abc\")", "fips180-4/sha512", "fips180-4/sha384"],
    ["FIPS 180-4", "Python hashlib", "hashlib/sha512", "hashlib/sha384"],
  ]],
  ["BLAKE2b", [["RFC 7693", "RFC 7693 Appendix A", "rfc7693/blake2b", ""], ["RFC 7693", "golang.org/x/crypto", "xcrypto/blake2b", ""]]],
  ["Argon2id", [["RFC 9106", "RFC 9106 5.3", "rfc9106/argon2id", ""], ["RFC 9106", "golang.org/x/crypto", "xcrypto/argon2id", ""]]],
  ["bcrypt", [["—", "golang.org/x/crypto", "xcrypto/bcrypt", ""], ["—", "golang.org/x/crypto (known answer)", "xcrypto-known/bcrypt", ""]]],
  ["PBKDF2-HMAC-SHA256", [["RFC 8018", "RFC 7914 11", "rfc7914/pbkdf2-sha256", ""], ["RFC 8018", "Go crypto/pbkdf2", "go/pbkdf2-sha256", ""]]],
  ["TLS 1.3 record (AES-128-GCM / ChaCha20-Poly1305)", [["RFC 8446", "Go crypto/tls record layer (twin)", "go/tls-record", ""]]],
];

const BLOCKS: Record<string, (lang: Lang) => string[]> = {
  "crypto-vectors": (lang) => {
    const o = [L(lang, "| プリミティブ | 規格 | ベクタの出所 | 通った数 |", "| Primitive | Standard | Vector source | Passed |"), "|---|---|---|---:|"];
    for (const [p, rows] of VECTORS) {
      for (const [std, src, k, note] of rows) {
        let n = fmt(num(k));
        if (note === "wycheproof/aes-gcm/aes128-iv96") n += L(lang, `（うち AES-128 / 96-bit nonce ${num(note)} — 他は拒否を確認）`, ` (${num(note)} AES-128 / 96-bit nonce — the rest checked to be rejected)`);
        else if (note === "wycheproof/x25519/all-zero") n += L(lang, `（全 0 の共有 ${num(note)} を拒否）`, ` (rejects ${num(note)} all-zero shared secrets)`);
        else if (note) n += ` / ${fmt(num(note))}`;
        o.push(`| ${p} | ${std} | ${src} | ${n} |`);
      }
    }
    return o;
  },
  "password-defaults": (lang) => {
    const o = [L(lang, "| 方式 | 省いた費用の既定（std が実際に作った値の頭） |", "| Scheme | Default cost when omitted (the head of a value std actually produced) |"), "|---|---|"];
    for (const x of list("password/default")) {
      const [s, ...rest] = x.split(" ");
      o.push(`| ${s} | \`${rest.join(" ")}\` |`);
    }
    return o;
  },
  "x509-evidence": (lang) => [
    L(lang, "| 網 | 出所 | 数 |", "| Suite | Source | Count |"), "|---|---|---:|",
    L(lang, `| PKITS の経路 | NIST PKITS | 範囲内 ${num("pkits/in-scope")} / 全 ${num("pkits/paths")}（範囲外の内訳は下） |`, `| PKITS paths | NIST PKITS | ${num("pkits/in-scope")} in scope / ${num("pkits/paths")} total (out of scope: below) |`),
    L(lang, `| x509-limbo | C2SP x509-limbo | 一致 ${num("limbo/agree")} / ${num("limbo/cases")}（既知の差は下） |`, `| x509-limbo | C2SP x509-limbo | ${num("limbo/agree")} agree / ${num("limbo/cases")} (known deviations: below) |`),
    L(lang, `| 証明書の欄の読み | Go crypto/x509（Go の題材 + PKITS の証明書） | ${num("go-x509/fields")}（Go が拒否する ${num("go-x509/go-rejects")} 本は下） |`, `| Certificate field parsing | Go crypto/x509 (Go's fixtures + PKITS certificates) | ${num("go-x509/fields")} (the ${num("go-x509/go-rejects")} Go rejects: below) |`),
    L(lang, `| 鎖の検証の題材 | Go verify_test.go | ${num("go-x509/verify")} |`, `| Chain verification cases | Go verify_test.go | ${num("go-x509/verify")} |`),
    L(lang, `| 信頼ストア | Mozilla NSS certdata.txt | 起点 ${num("nss/anchors")}（distrust-after つき ${num("nss/distrust-after")}） |`, `| Trust store | Mozilla NSS certdata.txt | ${num("nss/anchors")} anchors (${num("nss/distrust-after")} with distrust-after) |`),
  ],
  "x509-limbo-known": (lang) => {
    const o = [L(lang, "| 分類 | 種別 | 数 | 理由 | 題材 |", "| Class | Kind | Count | Reason | Cases |"), "|---|---|---:|---|---|"];
    for (const k of [...whys.keys()].filter((k) => k.startsWith("limbo/known/"))) {
      const kd = kind(k);
      o.push(`| ${k.slice(12)} | ${kindText(kd, lang)} | ${num(k)} | ${tr(why(k), lang)} | ${list(k).map((x) => "`" + x + "`").join(" ")} |`);
    }
    return o;
  },
  "x509-pkits-out": (lang) => {
    const o = [L(lang, "| 分類 | 種別 | 経路の数 | 理由 |", "| Class | Kind | Paths | Reason |"), "|---|---|---:|---|"];
    for (const k of [...whys.keys()].filter((k) => k.startsWith("pkits/out/"))) o.push(`| ${k.slice(10)} | ${kindText(kind(k), lang)} | ${num(k)} | ${tr(why(k), lang)} |`);
    return o;
  },
  "x509-go-diff": (lang) => {
    const o = [L(lang, "| 証明書 | Go | Sober |", "| Certificate | Go | Sober |"), "|---|---|---|"];
    for (const ours of ["accepts", "rejects"]) {
      const k = `go-x509/go-rejects/${ours}`;
      for (const x of items.get(k) ?? []) o.push(`| \`${x}\` | ${L(lang, "拒否", "rejects")} | ${ours === "accepts" ? L(lang, "読む", "parses") : L(lang, "拒否", "rejects")} |`);
      used.add(k);
    }
    return o;
  },
  "tls-reject": (lang) => {
    const o = [L(lang, "| 題材 | 返す alert |", "| Case | Alert sent |"), "|---|---|"];
    for (const x of list("tls/reject")) {
      const [n, a] = x.split(" ");
      o.push(`| ${n} | ${a} ${ALERTS[a] ?? "?"} |`);
    }
    if (num("tls/reject") !== list("tls/reject").length) fail("tls/reject の数と題材の数が違う");
    return o;
  },
  "interop-tls": (lang) => {
    const m = interopMeta.get("tls");
    const o = [L(lang, `最終確認: ${m?.date}（木 ${m?.commit} — scripts/tlsinterop.sh）`, `Last run: ${m?.date} (tree ${m?.commit} — scripts/tlsinterop.sh)`), "",
      L(lang, "| Go のサーバ | 繋がった版 |", "| Go server | Negotiated version |"), "|---|---|"];
    for (const x of list("interop/tls")) {
      const [n, v] = x.split(" ");
      o.push(`| ${n} | TLS ${v} |`);
    }
    num("interop/tls");
    return o;
  },
  "interop-http": (lang) => {
    const m = interopMeta.get("http");
    return [L(lang, `最終確認: ${m?.date}（木 ${m?.commit} — scripts/httpinterop.sh・相手 = Go net/http）`, `Last run: ${m?.date} (tree ${m?.commit} — scripts/httpinterop.sh; peer = Go net/http)`), "",
      list("interop/http").map((x) => "`" + x + "`").join(" · ")];
  },
  "interop-dns": (lang) => {
    const m = interopMeta.get("dns");
    return [L(lang, `最終確認: ${m?.date}（木 ${m?.commit} — scripts/dnsinterop.sh・偽の DNS サーバ ${num("interop/dns")} 題材: CNAME の鎖・TC → TCP・txid の偽装・search・NXDOMAIN・期限切れ）`,
      `Last run: ${m?.date} (tree ${m?.commit} — scripts/dnsinterop.sh; fake DNS server, ${num("interop/dns")} cases: CNAME chain, TC → TCP, spoofed txid, search, NXDOMAIN, timeout)`)];
  },
  summary: (lang) => {
    const o = [L(lang, "| 章 | 対応 | 一部 | 意図して非対応 | 未実装 |", "| Chapter | Supported | Partial | By design | Not yet |"), "|---|---:|---:|---:|---:|"];
    for (const ch of ["tls", "x509", "crypto", "http", "dns"]) {
      const cs = claims.filter((c) => c.block.startsWith(ch + "-"));
      const n = (s: string) => cs.filter((c) => c.status === s).length;
      o.push(`| [${ch}](${ch}${lang === "ja" ? ".ja" : ""}.md) | ${n("yes")} | ${n("partial")} | ${n("intentional")} | ${n("planned")} |`);
    }
    return o;
  },
};

function kindText(k: string, lang: Lang): string {
  return k === "intentional" ? L(lang, "意図して", "by design") : L(lang, "未実装", "not yet");
}

function gen(name: string, lang: Lang): string[] | null {
  const cm = name.match(/^claims (\S+) (\S+)$/);
  if (cm) return claimTable(cm[1], cm[2].split(","), lang);
  const f = BLOCKS[name];
  return f ? f(lang) : null;
}

// ── 文書の書き換え
const DIR = path.join(ROOT, "docs/conformance");
const changed: string[] = [];
const seenBlocks = new Set<string>();
for (const file of fs.readdirSync(DIR).filter((f) => f.endsWith(".md")).sort()) {
  const p = path.join(DIR, file);
  const lang: Lang = file.endsWith(".ja.md") ? "ja" : "en";
  const ls = fs.readFileSync(p, "utf8").split("\n");
  const o: string[] = [];
  for (let i = 0; i < ls.length; i++) {
    const b = ls[i].match(/^<!-- confsync:begin (.+) -->$/);
    if (!b) {
      o.push(ls[i]);
      continue;
    }
    const end = ls.findIndex((x, j) => j > i && x === `<!-- confsync:end ${b[1]} -->`);
    if (end < 0) {
      fail(`${file}: ${b[1]} の終わりの印が無い`);
      o.push(ls[i]);
      continue;
    }
    const g = gen(b[1], lang);
    if (!g) fail(`${file}: 知らない塊 ${b[1]}`);
    seenBlocks.add(b[1]);
    o.push(ls[i], ...(g ?? ls.slice(i + 1, end)), ls[end]);
    i = end;
  }
  const s = o.join("\n");
  if (s !== ls.join("\n")) {
    changed.push(file);
    if (!check) fs.writeFileSync(p, s);
  }
}

// ── 使われない言明・訳・主張
for (const k of nums.keys()) if (!used.has(k)) fail(`どの塊も使わない conf の数: ${k}`);
for (const k of items.keys()) if (!used.has(k)) fail(`どの塊も使わない conf-item: ${k}`);
for (const k of whys.keys()) if (!used.has("why:" + k)) fail(`どの塊も使わない conf-why: ${k}`);
for (const k of kinds.keys()) if (!used.has("kind:" + k)) fail(`どの塊も使わない conf-kind: ${k}`);
for (const k of en.keys()) if (!enUsed.has(k)) fail(`使われない訳: ${k}`);
for (const [i, c] of claims.entries()) {
  for (const lang of ["ja", "en"]) {
    const n = rendered.get(`${lang}\t${i}`) ?? 0;
    if (n !== 1) fail(`主張が ${lang} の文書に ${n} 回（ちょうど 1 回のこと）: ${c.ja}`);
  }
}
for (const n of Object.keys(BLOCKS)) if (!seenBlocks.has(n)) fail(`どの文書にも無い塊: ${n}`);

if (errors.length) {
  for (const e of [...new Set(errors)]) console.log("confsync: " + e);
  process.exit(1);
}
if (check && changed.length) {
  console.log(`confsync: 生成と現物が違う — ${changed.join(" ")}（scripts/confsync.sh で作り直す）`);
  process.exit(1);
}
console.log(`confsync: ${check ? "ok" : "written"} — ${nums.size} counts · ${items.size} lists · ${claims.length} claims${changed.length && !check ? ` · changed ${changed.join(" ")}` : ""}`);
