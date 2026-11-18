// 実験3の題材の生成: 型ごとに3つの形（json = json.Encode[T]・straight = 手書きの直線・walk = 定数の表を歩く再帰）
// 実行: node --experimental-strip-types gen.ts（出力 = このディレクトリの <題材>/<形>/main.sober）
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

type Node = { k: "int" } | { k: "str" } | { k: "struct"; ty: string; fields: { name: string; node: Node }[] };

const flat = (ty: string, n: number): Node => ({
  k: "struct",
  ty,
  fields: Array.from({ length: n }, (_, i) => ({ name: `a${i}`, node: i % 2 === 0 ? { k: "int" } : { k: "str" } })),
});

const leaf4: Node = { k: "struct", ty: "Leaf", fields: [
  { name: "z0", node: { k: "int" } }, { name: "z1", node: { k: "str" } },
  { name: "z2", node: { k: "int" } }, { name: "z3", node: { k: "str" } }] };
const mid: Node = { k: "struct", ty: "Mid", fields: [
  { name: "y0", node: { k: "int" } }, { name: "y1", node: { k: "str" } },
  { name: "y2", node: leaf4 }, { name: "y3", node: { k: "int" } }] };
const nest2: Node = { k: "struct", ty: "R", fields: [
  { name: "x0", node: { k: "int" } }, { name: "x1", node: { k: "str" } },
  { name: "x2", node: mid }, { name: "x3", node: { k: "str" } }] };

const subjects: [string, Node][] = [["f4", flat("R", 4)], ["f16", flat("R", 16)], ["f32", flat("R", 32)], ["nest2", nest2]];
const N = 200000;

function structs(n: Node, out: Map<string, Node>) {
  if (n.k !== "struct") return;
  for (const f of n.fields) structs(f.node, out);
  out.set(n.ty, n);
}

function types(root: Node): string {
  const m = new Map<string, Node>();
  structs(root, m);
  let s = "";
  for (const [ty, n] of m) {
    if (n.k !== "struct") continue;
    s += `type ${ty} struct {\n`;
    for (const f of n.fields) s += `    ${f.name} ${f.node.k === "int" ? "int" : f.node.k === "str" ? "string" : f.node.ty}\n`;
    s += "}\n\n";
  }
  return s;
}

// 値の式（i から作る）
function mkExpr(n: Node, salt: number): string {
  if (n.k === "int") return `i + ${salt}`;
  if (n.k === "str") return `"s${salt}_\${i % 100}"`;
  return `${n.ty}{${n.fields.map((f, j) => `${f.name}: ${mkExpr(f.node, salt * 10 + j)}`).join(", ")}}`;
}

// 葉の一覧（パス・種類）
function leaves(n: Node, path: string, out: { path: string; k: "int" | "str" }[]) {
  if (n.k === "int" || n.k === "str") { out.push({ path, k: n.k }); return; }
  for (const f of n.fields) leaves(f.node, `${path}.${f.name}`, out);
}

function straight(n: Node, path: string): string {
  if (n.k === "int") return `    json.PutInt(mut o, ${path})\n`;
  if (n.k === "str") return `    json.PutString(mut o, ${path})\n`;
  let s = "    builder.Push(mut o, '{')\n";
  n.fields.forEach((f, j) => {
    s += `    json.PutKey(mut o, "${f.name}", ${j === 0})\n`;
    s += straight(f.node, `${path}.${f.name}`);
  });
  return s + "    builder.Push(mut o, '}')\n";
}

// 表: 葉 = [kind(0 int・1 str), 葉の番号]・struct = [3, n, (名前の番号, 子の節の位置) × n]
function table(root: Node) {
  const sh: number[] = [];
  const names: string[] = [];
  const lv: { path: string; k: "int" | "str" }[] = [];
  function emit(n: Node, path: string): number {
    const at = sh.length;
    if (n.k === "int" || n.k === "str") {
      sh.push(n.k === "int" ? 0 : 1, lv.length);
      lv.push({ path, k: n.k });
      return at;
    }
    sh.push(3, n.fields.length);
    const slots = n.fields.map(() => { const p = sh.length; sh.push(0, 0); return p; });
    n.fields.forEach((f, j) => {
      names.push(f.name);
      sh[slots[j]] = names.length - 1;
      sh[slots[j] + 1] = emit(f.node, `${path}.${f.name}`);
    });
    return at;
  }
  emit(root, "v");
  return { sh, names, lv };
}

function walk(root: Node): string {
  const { sh, names, lv } = table(root);
  let s = `const Sh = []int{${sh.join(", ")}}\n\n`;
  s += "func name(id int) string {\n    return switch id {\n";
  names.forEach((nm, j) => { s += `    case ${j}: "${nm}"\n`; });
  s += `    default: ""\n    }\n}\n\n`;
  s += "func leafInt(v R, id int) int {\n    return switch id {\n";
  lv.forEach((l, j) => { if (l.k === "int") s += `    case ${j}: ${l.path}\n`; });
  s += "    default: 0\n    }\n}\n\n";
  s += "func leafStr(v R, id int) string {\n    return switch id {\n";
  lv.forEach((l, j) => { if (l.k === "str") s += `    case ${j}: ${l.path}\n`; });
  s += `    default: ""\n    }\n}\n\n`;
  s += `// 定数の表 sh の節 node に従って v を書く（kind と葉の番号で読みを選ぶ — 実験2の dyn の読みの代用）
func walk(o mut builder.Builder[byte], v R, sh []int, node int) {
    k := sh[node]
    if k == 0 {
        json.PutInt(mut o, leafInt(v, sh[node + 1]))
    } else if k == 1 {
        json.PutString(mut o, leafStr(v, sh[node + 1]))
    } else {
        n := sh[node + 1]
        builder.Push(mut o, '{')
        for i <- iter.Range(0, n) {
            json.PutKey(mut o, name(sh[node + 2 + 2 * i]), i == 0)
            walk(mut o, v, sh, sh[node + 3 + 2 * i])
        }
        builder.Push(mut o, '}')
    }
}

func enc(v R) string {
    mut o := builder.Builder[byte]{}
    walk(mut o, v, Sh, 0)
    return json.Done(mut o)
}
`;
  return s;
}

const here = dirname(fileURLToPath(import.meta.url));
for (const [name, root] of subjects) {
  const head = (form: string, imports: string[]) =>
    `package main\n\n// 実験3（shape-m0）の題材 ${name}・形 ${form}。gen.ts の生成物\n\n` +
    imports.map((m) => `import "${m}"\n`).join("") + "\n" + types(root) +
    `func mk(i int) R {\n    return ${mkExpr(root, 1)}\n}\n\n`;
  const main = `func main() {
    println(enc(mk(7)))
    mut total := 0
    for i <- iter.Range(0, ${N}) {
        total += len(bytes(enc(mk(i))))
    }
    println(total)
}
`;
  const forms: [string, string, string[]][] = [
    ["json", `func enc(v R) string {\n    return json.Encode[R](v)\n}\n\n`, ["std/iter", "std/json"]],
    ["straight", `func enc(v R) string {\n    mut o := builder.Builder[byte]{}\n${straight(root, "v")}    return json.Done(mut o)\n}\n\n`, ["std/builder", "std/iter", "std/json"]],
    ["walk", walk(root) + "\n", ["std/builder", "std/iter", "std/json"]],
    // 基準: 値を作るだけ（enc の費用を引くため。長さは文字列のフィールド1つ）
    ["base", `func enc(v R) string {\n    return ${root.k === "struct" ? `v.${root.fields[1].name}` : '""'}\n}\n\n`, ["std/iter"]],
  ];
  for (const [form, body, imports] of forms) {
    const p = join(here, name, form, "main.sober");
    mkdirSync(dirname(p), { recursive: true });
    writeFileSync(p, head(form, imports) + body + main);
  }
}
