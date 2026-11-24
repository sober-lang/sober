// logcheckの本体（scripts/logcheck.shから — 引数 = 題材をビルドしたディレクトリ）。環境 LOGCHECK_PID1=1 ならPID 1の照合もする
import { spawn } from "node:child_process";
import { closeSync, mkdtempSync, openSync, readFileSync } from "node:fs";
import { tmpdir } from "node:os";

const dir = process.argv[2];
const pid1 = process.env.LOGCHECK_PID1 === "1";
let fail = 0;
let n = 0;
function check(name: string, ok: boolean, detail: string) {
    n++;
    if (!ok) {
        fail++;
        console.log(`FAIL: ${name} — ${detail}`);
    }
}
const tmp = mkdtempSync(`${tmpdir()}/logcheck-`);

type Run = { out: string; err: string; code: number | null; signal: string | null; ms: number };
// 標準エラー（ログ）の読み方: file = ファイルへ（読み手が詰まらない）・pipe = パイプをすぐ読む・stall = 1.5秒読まない・slow = 塊ごとに2 ms止まる
function run(bin: string, args: string[], env: Record<string, string>, mode: "file" | "pipe" | "stall" | "slow" = "pipe", kill?: { sig: NodeJS.Signals; after: number; pid1: boolean }): Promise<Run> {
    return new Promise((resolve) => {
        const t0 = Date.now();
        const cmd = kill?.pid1 ? "unshare" : bin;
        const argv = kill?.pid1 ? ["-rpf", "--kill-child", bin, ...args] : args;
        const ef = mode === "file" ? `${tmp}/err${n}` : "";
        const fd = mode === "file" ? openSync(ef, "w") : -1;
        const p = spawn(cmd, argv, { env: { ...process.env, ...env }, stdio: ["ignore", "pipe", mode === "file" ? fd : "pipe"] });
        let out = "";
        let err = "";
        let ms = 0;
        let left = mode === "file" ? 1 : 2;
        const fin = (code: number | null, signal: string | null) => {
            if (--left > 0) return;
            if (mode === "file") err = readFileSync(ef, "utf8");
            resolve({ out, err, code, signal, ms });
        };
        let st: { code: number | null; signal: string | null } = { code: null, signal: null };
        p.stdout.on("data", (d) => (out += d));
        if (p.stderr) {
            p.stderr.setEncoding("utf8");
            if (mode === "stall") {
                p.stderr.pause();
                setTimeout(() => p.stderr!.resume(), 1500);
            }
            p.stderr.on("data", (d) => {
                err += d;
                if (mode === "slow") {
                    p.stderr!.pause();
                    setTimeout(() => p.stderr!.resume(), 2);
                }
            });
            p.stderr.on("end", () => fin(st.code, st.signal));
        }
        if (kill) {
            setTimeout(() => {
                if (kill.pid1) {
                    const kids = readFileSync(`/proc/${p.pid}/task/${p.pid}/children`, "utf8").trim().split(/\s+/);
                    process.kill(Number(kids[0]), kill.sig);
                } else p.kill(kill.sig);
            }, kill.after);
        }
        const guard = setTimeout(() => p.kill("SIGKILL"), 10000);
        p.on("exit", (code, signal) => {
            ms = Date.now() - t0;
            clearTimeout(guard);
            if (fd >= 0) closeSync(fd);
            st = { code, signal };
            fin(code, signal);
        });
    });
}
// 行の列: 全部JSONか・記録の数・印の行のnの和
function parse(text: string) {
    const lines = text.split("\n").filter((l) => l !== "");
    let bad = 0;
    let recs = 0;
    let gap = 0;
    for (const l of lines) {
        try {
            const j = JSON.parse(l);
            if (typeof j.ts !== "string" || j.ts.length !== 24) bad++;
            if (j["$dropped"]) gap += j["$dropped"].n;
            else recs++;
        } catch {
            bad++;
        }
    }
    return { lines, bad, recs, gap };
}

// 1. ファイルへ（読み手が詰まらない）: 落ちない・全行がJSON・Ledgerのwritten = 24000・dropped = 0（ワーカー1 / 2 / 8）
for (const w of ["1", "2", "8"]) {
    const r = await run(`${dir}/many`, [], { SOBER_WORKERS: w }, "file");
    const p = parse(r.err);
    check(`many W${w} json`, p.bad === 0, `bad=${p.bad}`);
    check(`many W${w} records`, p.recs === 24000 && p.gap === 0, `recs=${p.recs} gap=${p.gap}`);
    check(`many W${w} ledger`, r.out.trim() === "24000 0", `ledger=${r.out.trim()}`);
}
// 2. 止まった読み手: 書き手は塞がらずに読み手より先に終わる・出た行は全部JSON・落とした分を数える
{
    const r = await run(`${dir}/many`, [], { SOBER_WORKERS: "8" }, "stall");
    const p = parse(r.err);
    check("stall not blocked", r.ms < 1400, `exit after ${r.ms} ms (the reader starts at 1500 ms)`);
    check("stall json", p.bad === 0, `bad=${p.bad}`);
    const [wr, dr] = r.out.trim().split(" ").map(Number);
    check("stall dropped", dr > 0 && wr + dr <= 24000 && p.recs <= 24000, `ledger=${r.out.trim()} recs=${p.recs}`);
}
// 3. 少しずつ読む読み手 × 8ワーカー: 行が割れない（3回）
for (let k = 0; k < 3; k++) {
    const r = await run(`${dir}/many`, [], { SOBER_WORKERS: "8" }, "slow");
    const p = parse(r.err);
    check(`slow json #${k}`, p.bad === 0, `bad=${p.bad} of ${p.lines.length}`);
}
// 4. 大きい記録: 5,000バイトの記録は1行・40,000バイトの記録は落ちて印の行・続く記録は出る
{
    const r = await run(`${dir}/big`, [], {}, "file");
    const p = parse(r.err);
    const keys = p.lines.map((l) => { try { return Object.keys(JSON.parse(l))[1]; } catch { return "?"; } });
    check("big lines", p.bad === 0 && keys.join(",") === "Blob,$dropped,Blob" && p.gap === 1, `keys=${keys.join(",")} bad=${p.bad} lengths=${p.lines.map((l) => l.length).join(",")}`);
}
// 5. written + dropped = 呼んだ数
{
    const r = await run(`${dir}/acct`, [], { SOBER_WORKERS: "2" }, "file");
    const [wr, dr] = r.out.trim().split(" ").map(Number);
    check("acct ledger", wr + dr === 30 && dr === 10, `ledger=${r.out.trim()}`);
}
// 6. 書き出す点: 正常終了・panic（死因の前）・SIGTERM / SIGINT
{
    const r = await run(`${dir}/exit`, ["ok"], {});
    check("exit ok", parse(r.err).recs === 2 && r.code === 0, `recs=${parse(r.err).recs} code=${r.code}`);
    const q = await run(`${dir}/exit`, ["panic"], {});
    const ql = q.err.split("\n");
    check("exit panic", ql.length >= 3 && ql[0].includes("\"Step\"") && ql[1].includes("\"Step\"") && ql[2].startsWith("panic:") && q.code === 101, `stderr=${JSON.stringify(q.err.slice(0, 200))} code=${q.code}`);
    for (const [sig, code] of [["SIGTERM", 143], ["SIGINT", 130]] as [NodeJS.Signals, number][]) {
        const s = await run(`${dir}/exit`, ["sleep"], {}, "pipe", { sig, after: 300, pid1: false });
        check(`exit ${sig}`, parse(s.err).recs === 2 && s.signal === sig && s.code === null, `recs=${parse(s.err).recs} code=${s.code} signal=${s.signal}`);
        if (pid1) {
            const t = await run(`${dir}/exit`, ["sleep"], {}, "pipe", { sig, after: 400, pid1: true });
            check(`exit ${sig} pid1`, parse(t.err).recs === 2 && t.code === code, `recs=${parse(t.err).recs} code=${t.code} signal=${t.signal}`);
        }
    }
}
console.log(`logcheck: ${n} checks${pid1 ? "" : " (PID 1 skipped: unshare)"}, fail=${fail}`);
process.exit(fail === 0 ? 0 : 1);
