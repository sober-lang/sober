// pid1stop の本体（scripts/pid1stop.sh から — 引数 = 建てた実行ファイルの列）: 各実行ファイルに SIGTERM / SIGINT を送り、
// ① 非 PID 1: シグナルの死のまま（signalCode = SIGTERM / SIGINT — rt はハンドラを張らない・振る舞いは既定どおり）
// ② PID 1（unshare -rpf — 利用者の名前空間の pid ns の init）: 終了コード 143 / 130 で 2 秒以内に止まる（rt の入口が getpid() = 1 のときだけ張るハンドラ）
import { spawn } from "node:child_process";
import { readFileSync } from "node:fs";

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
let fail = 0;
let n = 0;
function done(name: string, ok: boolean, detail: string) {
    n++;
    if (!ok) {
        fail++;
        console.log(`FAIL: ${name} — ${detail}`);
    }
}
function waitExit(p: ReturnType<typeof spawn>, ms: number): Promise<{ code: number | null; signal: string | null } | null> {
    return new Promise((resolve) => {
        const t = setTimeout(() => resolve(null), ms);
        p.on("exit", (code, signal) => {
            clearTimeout(t);
            resolve({ code, signal });
        });
    });
}
const env = { ...process.env, SOBER_WORKERS: "8" };
for (const bin of process.argv.slice(2)) {
    for (const [sig, code] of [["SIGTERM", 143], ["SIGINT", 130]] as [NodeJS.Signals, number][]) {
        const a = spawn(bin, [], { stdio: "ignore", env });
        await sleep(300);
        a.kill(sig);
        const ra = await waitExit(a, 2000);
        if (!ra) a.kill("SIGKILL");
        done(`${bin} non-pid1 ${sig}`, ra?.signal === sig && ra.code === null, JSON.stringify(ra));
        const b = spawn("unshare", ["-rpf", "--kill-child", bin], { stdio: "ignore", env });
        await sleep(400);
        const kids = readFileSync(`/proc/${b.pid}/task/${b.pid}/children`, "utf8").trim().split(/\s+/);
        process.kill(Number(kids[0]), sig);
        const rb = await waitExit(b, 2000);
        if (!rb) b.kill("SIGKILL");
        done(`${bin} pid1 ${sig}`, rb?.code === code, JSON.stringify(rb));
    }
}
console.log(`pid1stop: ${n} checks, fail=${fail}`);
process.exit(fail ? 1 : 0);
