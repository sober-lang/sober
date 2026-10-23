# std/crypto

日本語

`import "std/crypto"`

暗号プリミティブの集約パッケージ。この package は定数時間の部品と乱数の 1 か所で、各方式は std/crypto/\<方式> に置く。

定数時間の規律（std/crypto の中だけで守る — 言語の検査ではない）:   1. 秘密に依存する if / switch / && / || / 比較演算子を書かない — 選択は Select、0 の判定は NonZero の mask   2. 秘密に依存する添字を書かない（表引きなし — ソフトの AES を書かない理由）  3. 秘密を / と % に渡さない（x86 の DIV は可変時間）  4. ループの回数は公開の値だけで決める網: scripts/ctcheck.sh（ct の関数の機械語の条件分岐の数を黄金で照合）

## Equal

```sober
@secret(a, b)
@bless
@effects(!io, !block, !nondet)
func Equal(a []byte, b []byte) bool
```

a と b のバイト列が等しいか。長さは公開の値として扱う（長さが違えばすぐ false）。中身は全バイトの xor を OR で畳み、最後に 1 回だけ判定する（どこで食い違ったかが時間に出ない — MAC の tag の比較に使う関数）

## NonZero

```sober
@secret(x)
@effects(!io, !block, !nondet)
func NonZero(x int) int
```

x が 0 なら 0、それ以外なら -1（全ビット 1）の mask（x | -x の最上位のビットを算術シフトで広げる — 分岐なし）

## Select

```sober
@secret(m, a, b)
@effects(!io, !block, !nondet)
func Select(m int, a int, b int) int
```

m が -1 なら a、0 なら b（m は NonZero などで作った mask だけ — 他の値は契約違反で結果は不定）

## Wipe

```sober
@secret(b)
@effects(!io, !block, !nondet)
func Wipe(b mut []byte)
```

b の全バイトを 0 にする（用済みの鍵の後始末）

## NoEntropy

```sober
type NoEntropy panic {
    errno int
}
```

getrandom が乱数を返せない（カーネル 3.17 未満 = ENOSYS など — 乱数なしで鍵を作らないための panic ラベル。[language.md 27 節](../language.md)）

## Rand

```sober
func Rand(n int) []byte
```

OS の暗号論的な乱数 n バイト（getrandom — 呼ぶのはこの 1 か所だけ。flags 0 = 初期化前は待つ）。EINTR はやり直す。失敗は panic(NoEntropy{errno})
