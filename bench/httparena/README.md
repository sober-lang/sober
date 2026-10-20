# bench/httparena — HttpArena の Sober のエントリ（net 4c）

[HttpArena](https://github.com/MDA2AV/HttpArena)（TechEmpower の後継のコミュニティのベンチ）の HTTP/1.1 の種目のうち、std/http の範囲で出られるもの（`meta.json` の `tests` — baseline・pipelined・limited-conn・latency-1m / latency-10k・async・json-comp〔応答の gzip は std/http の組み込み — `http.ServeConn(c, route, compress: http.Gzip{})`・report-714〕）のエントリ。HttpArena の `frameworks/<名前>/` の慣例の形（meta.json + Dockerfile + ソース）に合わせてある。

| ファイル | 役 |
|---|---|
| `main.sober` | サーバ（`/baseline11`・`/pipeline`・`/delay/{ms}` を 0.0.0.0:8080 で — 引数で番号を上書き） |
| `meta.json` | HttpArena のエントリの宣言 |
| `Dockerfile` | 本家の形（リリースの tarball から建てる）— **0.6.0（std/http を含む公開リリース）の後の TODO**。今の v0.5.x には std/http が無い |
| `Dockerfile.local` | 手元・自前の fork の形（手元で建てた静的 ELF を `server` に置いて COPY — FROM scratch） |
| `go/` | Go の対照（HttpArena の go-stdlib のハンドラの写し — 標準ライブラリだけ） |
| `local.sh` / `summary.ts` | 素のプロセスで Sober と Go を交互に回して比を出す（負荷 = HttpArena と同じ gcannon と要求のファイル。latency-1m / latency-10k は本家と同じ zrk〔レート固定・v2.3.0 の pin を自動で取る〕・async は 32000 接続の GET /delay/10 — 種目 7 つ全部に対応。json = /json/{count}?m= を Accept-Encoding なしで〔本家に素の json 種目は無い — json-comp / json-tls / json-h2c の端点。手元の直列化の比だけ・meta.json には載せない〕・json-comp = 同じ巡回を Accept-Encoding: gzip, br で 4096 接続〔json-comp-16k = 16384〕・要約の末尾に応答 1 件のバイトと本家の採点の係数 (min Bpr / Bpr)²・latency はウォームアップ周つき・report-703） |

計測:

```sh
GCANNON=/path/to/gcannon bench/httparena/local.sh -n 3 -d 5     # 手元（値は参考 — seccomp の下では時間が歪む）
```

公式の数字は GitHub Actions（`.github/workflows/httparena.yml` — 手動トリガ・同じジョブの中の交互計測の比の中央値）。検証は `scripts/httpcheck.sh`（HttpArena の validate.sh / validate-frag.py を模した網）。
