// std/table の差分オラクル — Go の slice を真実として期待値を作る（docs/oracles.md）。
//
// 1 つのケース表から 2 本を生成する:
//   - examples/table_std.sober … Sober 側（`import "std/table"` の Table に Push / Set / Get / Len）
//   - Go の双子プログラム     … 同じ操作列を Go の slice で。その出力が examples/table_std.out
// 操作列は両言語で同じ LCG（x ← (x · 1103515245 + 12345) mod 2^31）から作る。n は chunk の境目（CHUNK = 8192）の前後を踏む。
//
// 再生成手順（リポジトリルートで。要件: node 22.6+、go 1.21+）:
//   node scripts/table_oracle.ts examples/table_std.sober /tmp/table_oracle.go
//   go run /tmp/table_oracle.go > examples/table_std.out
// 突き合わせは scripts/obs.sh（.out と実行出力の一致）と `sober check examples/table_std.sober` が担う。
import { writeFileSync } from "node:fs";

// [n（積む個数）, sets（Set の回数）, seed]
type Case = [n: number, sets: number, seed: number];
const cases: Case[] = [
  [0, 0, 1], [1, 3, 7], [8191, 100, 42], [8192, 100, 43], [8193, 5000, 44], [20000, 20000, 45], [40000, 1000, 46],
];
// struct の要素の表（[n, sets, seed]）
const pcases: Case[] = [[3, 2, 9], [16385, 3000, 10]];

const sober = `package main

// Go の slice との突き合わせ（std/table）。生成物 — scripts/table_oracle.ts から再生成する

import "std/table"

type P struct {
    a int
    b int
}

func next(x int) int {
    return (x * 1103515245 + 12345) % 2147483648
}

func run(n int, sets int, seed int) {
    mut t := table.Table[int]{}
    mut x := seed
    mut i := 0
    while i < n {
        table.Push(mut t, x % 1000)
        x = next(x)
        i += 1
    }
    i = 0
    while i < sets && n > 0 {
        j := x % n
        table.Set(mut t, j, table.Get(mut t, j) + i)
        x = next(x)
        i += 1
    }
    mut sum := 0
    i = 0
    while i < table.Len(mut t) {
        sum = (sum * 31 + table.Get(mut t, i)) % 1000000007
        i += 1
    }
    println("\${n} \${table.Len(mut t)} \${sum}")
    if n > 0 {
        println("\${table.Get(mut t, 0)} \${table.Get(mut t, n - 1)}")
    }
}

// getP は非ジェネリックの包み（ジェネリックな Get の結果の struct は欄の型が脱糖器に見えない — selfhost-drafts F-10）
func getP(t mut table.Table[P], i int) P {
    return table.Get(mut t, i)
}

func runP(n int, sets int, seed int) {
    mut t := table.Table[P]{}
    mut x := seed
    mut i := 0
    while i < n {
        table.Push(mut t, P{a: x % 100, b: i})
        x = next(x)
        i += 1
    }
    i = 0
    while i < sets {
        j := x % n
        p := getP(mut t, j)
        table.Set(mut t, j, P{a: p.b % 7, b: p.a + i})
        x = next(x)
        i += 1
    }
    mut sum := 0
    i = 0
    while i < table.Len(mut t) {
        p := getP(mut t, i)
        sum = (sum * 31 + p.a * 3 + p.b) % 1000000007
        i += 1
    }
    println("P \${n} \${sum}")
}

func main() {
${cases.map(([n, s, d]) => `    run(${n}, ${s}, ${d})`).join("\n")}
${pcases.map(([n, s, d]) => `    runP(${n}, ${s}, ${d})`).join("\n")}
}
`;

const go = `package main

import "fmt"

type P struct{ a, b int }

func next(x int) int { return (x*1103515245 + 12345) % 2147483648 }

func run(n, sets, seed int) {
	t := []int{}
	x := seed
	for i := 0; i < n; i++ {
		t = append(t, x%1000)
		x = next(x)
	}
	for i := 0; i < sets && n > 0; i++ {
		j := x % n
		t[j] = t[j] + i
		x = next(x)
	}
	sum := 0
	for i := 0; i < len(t); i++ {
		sum = (sum*31 + t[i]) % 1000000007
	}
	fmt.Printf("%d %d %d\\n", n, len(t), sum)
	if n > 0 {
		fmt.Printf("%d %d\\n", t[0], t[n-1])
	}
}

func runP(n, sets, seed int) {
	t := []P{}
	x := seed
	for i := 0; i < n; i++ {
		t = append(t, P{x % 100, i})
		x = next(x)
	}
	for i := 0; i < sets; i++ {
		j := x % n
		p := t[j]
		t[j] = P{p.b % 7, p.a + i}
		x = next(x)
	}
	sum := 0
	for i := 0; i < len(t); i++ {
		sum = (sum*31 + t[i].a*3 + t[i].b) % 1000000007
	}
	fmt.Printf("P %d %d\\n", n, sum)
}

func main() {
${cases.map(([n, s, d]) => `\trun(${n}, ${s}, ${d})`).join("\n")}
${pcases.map(([n, s, d]) => `\trunP(${n}, ${s}, ${d})`).join("\n")}
}
`;

const [soberPath, goPath] = process.argv.slice(2);
if (!soberPath || !goPath) {
  console.error("usage: node scripts/table_oracle.ts <out.sober> <out.go>");
  process.exit(1);
}
writeFileSync(soberPath, sober);
writeFileSync(goPath, go);
console.log(`${cases.length + pcases.length} cases`);
