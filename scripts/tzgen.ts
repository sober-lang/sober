// std/time の地域の規則の生成（scripts/tzstore.sh が呼ぶ）。
//   node --experimental-strip-types scripts/tzgen.ts zones <slim の TZif の束> <別名の表> <tz の版> <取得日> <tzdata の SHA-256> <zic の版> > src/std/time/zones.sober
//   node --experimental-strip-types scripts/tzgen.ts samples <fat の TZif の束> <別名の表> > testdata/tz/samples.txt
// zones: TZif（RFC 9636）の 64 bit の節の遷移と種類と末尾の規則（POSIX TZ の文字列）を、ゾーンごとに 1 行に詰める。別名（tz のソースの Link の行 —
// 別名の表 = `別名 正の名前` の行・scripts/tzstore.sh が置く）は行を作らず別名の表に出す。行 = `名前 種類 遷移 規則` — 種類 = `オフセット秒:夏時間 0/1:略称` の , 区切り・
// 遷移 = 最初は `UNIX 秒:種類` で 2 つ目からは `前との差:種類`（数は 36 進・負は先頭に -）の , 区切り（無ければ -）・規則 = 末尾の規則（無ければ -）。
// samples: 照合の表（fat = zic -b fat -r 1900〜2100 で全部の遷移を展開した束を正とする）— ゾーンごとに、決めた時刻と 2020〜2100 の遷移の前後の
// `名前 UNIX 秒 オフセット秒 夏時間 略称`（slim の遷移 + 規則の評価が fat の展開と一致することを std/time のテストが確かめる）
import * as fs from "node:fs";
import * as path from "node:path";

function walk(dir: string, base = ""): string[] {
  const out: string[] = [];
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const rel = base ? `${base}/${e.name}` : e.name;
    if (e.isDirectory()) out.push(...walk(path.join(dir, e.name), rel));
    else out.push(rel);
  }
  return out.sort();
}

type Tz = { types: { off: number; dst: number; abbr: string }[]; times: bigint[]; idx: number[]; footer: string };

function parse(b: Buffer): Tz {
  if (b.toString("latin1", 0, 4) !== "TZif") throw new Error("not TZif");
  const hdr = (off: number) => {
    const n = (i: number) => b.readUInt32BE(off + 20 + 4 * i);
    return { isutc: n(0), isstd: n(1), leap: n(2), time: n(3), type: n(4), char: n(5) };
  };
  const h1 = hdr(0);
  const v1len = 44 + h1.time * 5 + h1.type * 6 + h1.char + h1.leap * 8 + h1.isstd + h1.isutc;
  const h = hdr(v1len);
  let p = v1len + 44;
  const times: bigint[] = [];
  for (let i = 0; i < h.time; i++, p += 8) times.push(b.readBigInt64BE(p));
  const idx: number[] = [];
  for (let i = 0; i < h.time; i++, p += 1) idx.push(b[p]);
  const raw: { off: number; dst: number; ai: number }[] = [];
  for (let i = 0; i < h.type; i++, p += 6) raw.push({ off: b.readInt32BE(p), dst: b[p + 4], ai: b[p + 5] });
  const chars = b.toString("latin1", p, p + h.char);
  p += h.char + h.leap * 12 + h.isstd + h.isutc;
  const footer = b.toString("latin1", p + 1, b.length - 1);
  return { types: raw.map((t) => ({ off: t.off, dst: t.dst, abbr: chars.slice(t.ai, chars.indexOf("\0", t.ai)) })), times, idx, footer };
}

// 時刻 t（UNIX 秒）の種類（fat の束 — 最初の遷移より前は種類 0）
function typeAt(z: Tz, t: bigint) {
  let k = -1;
  for (let i = 0; i < z.times.length && z.times[i] <= t; i++) k = i;
  return z.types[k < 0 ? 0 : z.idx[k]];
}

const b36 = (n: bigint) => (n < 0n ? "-" + (-n).toString(36) : n.toString(36));

const [mode, dir, linkFile, ...rest] = process.argv.slice(2);
const linkOf = new Map<string, string>();
for (const l of fs.readFileSync(linkFile, "utf8").split("\n")) {
  const [a, b] = l.trim().split(/\s+/);
  if (a && b) linkOf.set(a, b);
}
const files = walk(dir).filter((f) => !f.startsWith("posix") && !f.startsWith("right") && f !== "posixrules" && f !== "Factory");
const canon: { name: string; tz: Tz }[] = [];
const links: string[] = [];
const have = new Set(files);
for (const f of files) {
  const target = linkOf.get(f);
  if (target !== undefined) {
    // 鎖の別名（別名 → 別名 → 正）は正まで辿る
    let t = target;
    for (let i = 0; i < 8 && linkOf.has(t); i++) t = linkOf.get(t)!;
    if (have.has(t)) links.push(`${f} ${t}`);
    continue;
  }
  canon.push({ name: f, tz: parse(fs.readFileSync(path.join(dir, f))) });
}

if (mode === "samples") {
  const fixed = [-2208988800n, -1577923200n, 0n, 946684800n, 1767225600n, 1782864000n, 2524608000n, 4070908800n];
  const out: string[] = [];
  for (const { name, tz } of canon) {
    const ts = new Set<bigint>(fixed);
    let n = 0;
    for (const t of tz.times) {
      if (t >= 1577836800n && t < 4102444800n && n < 6) {
        ts.add(t - 1n);
        ts.add(t);
        n++;
      }
    }
    for (const t of [...ts].sort((a, b) => (a < b ? -1 : 1))) {
      const ty = typeAt(tz, t);
      out.push(`${name} ${t} ${ty.off} ${ty.dst} ${ty.abbr}`);
    }
  }
  process.stdout.write(out.join("\n") + "\n");
} else {
  const [tag, date, sha, zic] = rest;
  const zones = canon.map(({ name, tz }) => {
    const types = tz.types.map((t) => `${t.off}:${t.dst}:${t.abbr}`).join(",");
    const trans = tz.times.length === 0 ? "-" : tz.times.map((t, i) => `${b36(i === 0 ? t : t - tz.times[i - 1])}:${tz.idx[i].toString(36)}`).join(",");
    return `        "${name} ${types} ${trans} ${tz.footer === "" ? "-" : tz.footer}",`;
  });
  process.stdout.write(`package time

// 生成物 — scripts/tzstore.sh --regen（scripts/tzgen.ts）が IANA の tz の正式リリース（data.iana.org の tzdata）を zic -b slim で組んだ TZif から作る。手で直さない（bump = scripts/tzstore.sh --regen <タグ>）。
// 出所の銘: tzdata${tag}.tar.gz・取得 ${date}・SHA-256 ${sha}・${zic}。ゾーン ${zones.length} 本・別名 ${links.length} 本。
// 行の形 = \`名前 種類 遷移 規則\`（種類 = \`オフセット秒:夏時間:略称\` の , 区切り・遷移 = 最初は \`UNIX 秒:種類\`・2 つ目からは \`差:種類\`〔36 進〕の , 区切り・規則 = 末尾の POSIX TZ の規則 — 無ければ -）

func zoneLines() []string {
    return []string{
${zones.join("\n")}
    }
}

// 別名（\`別名 正の名前\` — 中身が同じゾーン）
func zoneLinks() []string {
    return []string{
${links.map((l) => `        "${l}",`).join("\n")}
    }
}
`);
}
