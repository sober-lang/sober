# std/layout

日本語

`import "std/layout"`

@layout（[language.md 36 節](../language.md)）の裏方: 利用者は `layout.Decode[T](b, off)`・`layout.DecodeAt[T](b, off, i)`・`layout.Encode[T](mut out, v)`・`layout.Size[T]` を書き、loader の固定テンプレート（compiler/loader/layout.sober）が @layout の struct ごとの写しの関数（普通の Sober）を合成してその呼び出しに写す。ここに置くのは写しの関数が呼ぶ失敗の関数だけ（panic ラベル WidthOverflow / LengthMismatch — exit 101・死亡時に欄が標準エラーへ。[language.md 27 節](../language.md)の panic の契約）

## Decode

```sober
func Decode[T](b []byte, off int) T?
```

b の off バイト目から T を 1 つ読む。バイトが足りなければ nil。符号つきの幅は符号拡張して読む

例:

```sober
// examples/layout_elf.sober
package main

// @layout の最小形（language.md 36 節）: ELF64 のヘッダとプログラムヘッダを書いて読み戻す — B-1〜B-5（正規バックエンドの Sober 化）の ELF の書き出しの先取り

import "std/builder"
import "std/iter"
import "std/layout"

@layout
type Elf64Header struct {
    ident [16]u8
    kind u16le
    machine u16le
    version u32le
    entry u64le
    phoff u64le
    shoff u64le
    flags u32le
    ehsize u16le
    phentsize u16le
    phnum u16le
    shentsize u16le
    shnum u16le
    shstrndx u16le
}

@layout
type Elf64Phdr struct {
    kind u32le
    flags u32le
    offset u64le
    vaddr u64le
    paddr u64le
    filesz u64le
    memsz u64le
    align u64le
}

// elfIdent は e_ident（ELFCLASS64・ELFDATA2LSB・EV_CURRENT・残りは 0）
func elfIdent() []byte {
    mut b := builder.Builder[byte]{}
    builder.Push(mut b, 127)
    builder.Push(mut b, 'E')
    builder.Push(mut b, 'L')
    builder.Push(mut b, 'F')
    builder.Push(mut b, 2)
    builder.Push(mut b, 1)
    builder.Push(mut b, 1)
    for i <- iter.Range(0, 9) {
        builder.Push(mut b, 0)
    }
    return builder.Build(mut b)
}

func segment(i int) Elf64Phdr {
    return Elf64Phdr{kind: 1, flags: 5 - i, offset: i * 4096, vaddr: 4194304 + i * 4096, paddr: 4194304 + i * 4096, filesz: 100 + i, memsz: 200 + i, align: 4096}
}

func main() {
    h := Elf64Header{ident: elfIdent(), kind: 2, machine: 62, version: 1, entry: 4198400, phoff: layout.Size[Elf64Header], shoff: 0, flags: 0,
        ehsize: layout.Size[Elf64Header], phentsize: layout.Size[Elf64Phdr], phnum: 2, shentsize: 64, shnum: 0, shstrndx: 0}
    mut out := builder.Builder[byte]{}
    layout.Encode[Elf64Header](mut out, h)
    for i <- iter.Range(0, 2) {
        layout.Encode[Elf64Phdr](mut out, segment(i))
    }
    b := builder.Build(mut out)
    println(len(b))
    println(layout.Size[Elf64Header])
    println(layout.Size[Elf64Phdr])
    // 先頭 4 バイトはマジック
    println(int(b[0]))
    println(b[1] == 'E' && b[2] == 'L' && b[3] == 'F')
    r := layout.Decode[Elf64Header](b, 0)
    if r != nil {
        println(r.kind == h.kind && r.machine == h.machine && r.version == h.version && r.entry == h.entry)
        println(r.phoff == h.phoff && r.ehsize == h.ehsize && r.phentsize == h.phentsize && r.phnum == h.phnum && r.shentsize == h.shentsize)
        println(len(r.ident))
        println(int(r.ident[4]))
        println(r.entry)
        for i <- iter.Range(0, r.phnum) {
            p := layout.DecodeAt[Elf64Phdr](b, r.phoff, i)
            if p != nil {
                s := segment(i)
                println(p.kind == s.kind && p.flags == s.flags && p.offset == s.offset && p.vaddr == s.vaddr && p.paddr == s.paddr)
                println(p.filesz == s.filesz && p.memsz == s.memsz && p.align == s.align)
                println(p.vaddr)
            }
        }
    }
    // 3 つ目のプログラムヘッダは無い・ヘッダの途中で切れたバイト列は足りない — どちらも nil
    println(layout.DecodeAt[Elf64Phdr](b, h.phoff, 2) == nil)
    println(layout.Decode[Elf64Header](elfIdent(), 0) == nil)
}
```

## DecodeAt

```sober
func DecodeAt[T](b []byte, off int, i int) T?
```

b の off バイト目から並ぶ T の i 番目を読む（間隔 = Size[T]）。バイトが足りなければ nil

## Encode

```sober
func Encode[T](out mut builder.Builder[byte], v T)
```

v を out の末尾に書く。欄の値が幅に収まらなければ panic(WidthOverflow)・固定長配列の長さが違えば panic(LengthMismatch)

例:

```sober
// examples/layout_widths.sober
package main

// @layout の幅の語の網羅（language.md 36 節 Y1・Y2・Y7）: LE / BE・符号つきは符号拡張・u64le は int の全域（上位ビットはそのまま負の int）・
// [N]u8 は []byte・[N]幅は []int。書いたバイト列を 1 バイトずつ印字して読み戻す

import "std/builder"
import "std/iter"
import "std/layout"

@layout
type W struct {
    a u8
    b i8
    c u16le
    d u16be
    e i16le
    f i16be
    g u32le
    h u32be
    i i32le
    j i32be
    k u64le
    l u64be
    m i64le
    n i64be
    tag [3]u8
    xs [2]i16be
}

func main() {
    v := W{a: 255, b: -128, c: 258, d: 258, e: -2, f: -2, g: 16909060, h: 16909060, i: -2147483648, j: 2147483647,
        k: 1 << 63, l: 1, m: -1, n: 72623859790382856, tag: bytes("abc"), xs: []int{-32768, 32767}}
    mut out := builder.Builder[byte]{}
    layout.Encode[W](mut out, v)
    b := builder.Build(mut out)
    println(len(b))
    println(layout.Size[W])
    for i <- iter.Range(0, len(b)) {
        println(int(b[i]))
    }
    r := layout.Decode[W](b, 0)
    if r != nil {
        println(r.a)
        println(r.b)
        println(r.c)
        println(r.d)
        println(r.e)
        println(r.f)
        println(r.g)
        println(r.h)
        println(r.i)
        println(r.j)
        println(r.k)
        println(r.l)
        println(r.m)
        println(r.n)
        println(int(r.tag[2]))
        println(r.xs[0])
        println(r.xs[1])
    }
    // 1 バイト足りない → nil・負の off → nil
    println(layout.Decode[W](b[0:len(b) - 1], 0) == nil)
    println(layout.Decode[W](b, -1) == nil)
}
```

## Size

```sober
const Size[T] int
```

T の静的な大きさ（バイト — 欄の幅の和）。呼ばずに定数として書く: `layout.Size[T]`

## WidthOverflow

```sober
type WidthOverflow panic {
    field string
    value int
    width string
}
```

書き込みの幅あふれ: 欄 field の値 value が幅 width に収まらない

## LengthMismatch

```sober
type LengthMismatch panic {
    field string
    want int
    got int
}
```

固定長配列の長さ違い: 欄 field の長さが want でなく got

## FailWidth

```sober
func FailWidth(field string, width string, v int)
```

書き込みの幅あふれ: 欄 field の値 v が幅 width に収まらない

## FailLength

```sober
func FailLength(field string, want int, got int)
```

固定長配列の長さ違い: 欄 field の長さが want でなく got
