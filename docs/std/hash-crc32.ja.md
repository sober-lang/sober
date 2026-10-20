# std/hash/crc32

日本語

`import "std/hash/crc32"`

CRC-32（IEEE 802.3 の多項式）の検査和

## Sum

```sober
func Sum(data []byte) int
```

data の CRC-32（IEEE 802.3 の多項式 — 反転形 0xedb88320・初期値と終わりの反転 0xffffffff。gzip・zlib・PNG と同じ値）。値は [0, 2^32) の int:

```sober
c := crc32.Sum(bytes("123456789"))   // 0xcbf43926（RFC 1952 の照合値）
```

64 バイト以上で機械が PCLMULQDQ を持てば、16 の倍数の先頭を繰り上がりのない積で畳む（cpuclmul / crcfold。端数は 1 バイトずつ）。倒れ先（PCLMULQDQ の無い機械・x86 の最適化のバックエンド以外の出力）: 256 バイト以上は slicing-by-8（8 バイトの語を 1 回で読み、8 つの表を独立に引いて xor — 表引きの依存の鎖が 1 / 8 に。表 8 × 256 語は呼び出しごとに table() から作る ≈ 1,800 項目）。短い入力と端の 7 バイトまでは1 バイトずつの表引き
