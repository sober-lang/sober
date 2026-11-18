// writeform: 同じ意味の書き方は同じ判定になることの検査。
// testdata/writeform/<family>/family.in の @BODY@ に forms/*.body を入れ、型引数ごとに、総称の関数（`f[T]`）と、型引数を代入した単相の関数の
// 2 通りで `sober check` する。family はどれも意味として正しいプログラムだけを作るので、書き方と総称 / 単相のすべてで受理になることを見る
// （同じ意味の書き方は同じ判定になる）。拒否のある組は、既知の不具合として testdata/writeform/known.txt に理由つきで置く（置いた組が全部受理に
// なったら、行を消すよう FAIL にする）。単相で書けない型（`T?` の T が slice のもの。`[]int?` は int? の slice と読む）は単相を作らない。
//   scripts/writeform.sh [--show]（--show = 全部の組の判定を印字）
import { execFile } from "node:child_process"
import { existsSync, mkdtempSync, readFileSync, readdirSync, rmSync, writeFileSync } from "node:fs"
import { tmpdir } from "node:os"
import { join } from "node:path"

const ROOT = join(import.meta.dirname, "..")
const SOBER = process.env.STAGE2 ?? join(ROOT, "out/stage2/sober2")
const D = process.env.WRITEFORM_DIR ?? join(ROOT, "testdata/writeform")
const show = process.argv.includes("--show")
const jobs = Number(process.env.JOBS ?? 8)

// 型引数: 名前・型・値・2 つ目の値・印字の式（$x が値）
type Arg = { name: string; ty: string; v: string; w: string; show: string }
const args: Arg[] = [
    { name: "int", ty: "int", v: "3", w: "4", show: "$x" },
    { name: "string", ty: "string", v: `"ab"`, w: `"cd"`, show: "len(bytes($x))" },
    { name: "slice", ty: "[]int", v: "[]int{1, 2}", w: "[]int{3}", show: "len($x)" },
    { name: "struct-str", ty: "Rt", v: `Rt{path: "/a", tags: []string{"x"}}`, w: `Rt{path: "/b", tags: []string{}}`, show: "len(bytes($x.path))" },
    // 名前の関数だけを実引数にすると型引数は匿名の関数型に推論されて拒否される（型引数に匿名の関数型は置けない）ので、2つ目の値でHを示す
    { name: "fn-named", ty: "H", v: "incr", w: "H(incr)", show: "$x(1)" },
    { name: "fn-capture", ty: "H", v: `mkH("ab")`, w: `mkH("cd")`, show: "$x(1)" },
    { name: "struct-fn", ty: "Box", v: `Box{h: mkH("ab")}`, w: `Box{h: incr}`, show: "$x.h(1)" },
]

function fill(t: string, a: Arg, gen: boolean): string {
    return t
        .replaceAll("$TP", gen ? "[T]" : "")
        .replaceAll("$U", gen ? "[T]" : "")
        .replaceAll("$A", gen ? `[${a.ty}]` : "")
        .replaceAll("$T", gen ? "T" : a.ty)
        .replaceAll("$C", a.ty)
        .replaceAll("$V", a.v)
        .replaceAll("$W", a.w)
        .replace(/\$S\(([^)]*)\)/g, (_, e) => a.show.replaceAll("$x", e))
}

function check(f: string): Promise<string> {
    return new Promise((res) => {
        execFile(SOBER, ["check", f], { encoding: "utf8" }, (err, out, errOut) => {
            const ok = !err && out.includes('"ok":true')
            const first = (errOut + out).split("\n").find((l) => l.startsWith("sober:")) ?? ""
            res(ok ? "ok" : `rejected: ${first.replace(/ at [^ ]*:[0-9]+:[0-9]+/, "")}`)
        })
    })
}

const known = new Map<string, string>()
for (const l of readFileSync(join(D, "known.txt"), "utf8").split("\n")) {
    if (l && !l.startsWith("#")) {
        const [fam, arg] = l.split(" ")
        known.set(`${fam} ${arg}`, l)
    }
}
const common = readFileSync(join(D, "common.in"), "utf8")
const tmp = mkdtempSync(join(tmpdir(), "writeform-"))
type Job = { key: string; label: string; file: string }
const work: Job[] = []
let skipped = 0
const fams = readdirSync(D, { withFileTypes: true }).filter((e) => e.isDirectory() && existsSync(join(D, e.name, "family.in"))).map((e) => e.name).sort()
for (const fam of fams) {
    const tpl = readFileSync(join(D, fam, "family.in"), "utf8")
    const forms = readdirSync(join(D, fam, "forms")).filter((n) => n.endsWith(".body")).sort()
    for (const a of args) {
        for (const form of forms) {
            const body = readFileSync(join(D, fam, "forms", form), "utf8").replace(/\n$/, "")
            for (const gen of [true, false]) {
                if (!gen && tpl.includes("$T?") && a.ty.startsWith("[")) {
                    skipped++
                    continue
                }
                const src = `package main\n\n${common}\n${fill(tpl.replace("@BODY@", body), a, gen)}`
                const label = `${form.replace(/\.body$/, "")}/${gen ? "generic" : "mono"}`
                const file = join(tmp, `${fam}__${a.name}__${label.replace("/", "__")}.sober`)
                writeFileSync(file, src)
                work.push({ key: `${fam} ${a.name}`, label, file })
            }
        }
    }
}
const verdicts = new Array<string>(work.length)
let next = 0
await Promise.all(Array.from({ length: jobs }, async () => {
    while (next < work.length) {
        const i = next++
        verdicts[i] = await check(work[i].file)
    }
}))
const groups = new Map<string, { label: string; v: string }[]>()
work.forEach((w, i) => {
    if (!groups.has(w.key)) groups.set(w.key, [])
    groups.get(w.key)!.push({ label: w.label, v: verdicts[i] })
})
let fail = 0
let split = 0
for (const [key, rs] of groups) {
    const rejected = rs.some((r) => r.v !== "ok")
    if (rejected) split++
    if (show || (rejected && !known.has(key))) {
        for (const r of rs) console.log(`  ${key} ${r.label}: ${r.v}`)
    }
    if (rejected && !known.has(key)) {
        console.log(`FAIL ${key}: a form of a valid function is rejected (add to testdata/writeform/known.txt with the reason if it is a known bug)`)
        fail++
    }
    if (!rejected && known.has(key)) {
        console.log(`FAIL ${key}: listed in known.txt but every form is now accepted`)
        fail++
    }
}
for (const k of known.keys()) {
    if (!groups.has(k)) {
        console.log(`FAIL ${k}: listed in known.txt but no such family and type argument`)
        fail++
    }
}
rmSync(tmp, { recursive: true, force: true })
console.log(`writeform: ${fams.length} families, ${groups.size} family x type argument groups, ${work.length} programs (${skipped} not writable as a monomorphic function), ${split} groups with a rejection, fail=${fail}`)
process.exit(fail ? 1 : 0)
