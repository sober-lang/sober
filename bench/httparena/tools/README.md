# bench/httparena/tools — rt / std/net の手元の計器（偵察 671〜681 — .pair/tools/http から移設）

local.sh / perf.sh（Sober / Go の比・カーネルの内訳）と違い、1 つの Sober サーバの実行ファイルを固定の CPU 割り（サーバ 0-11・
SOBER_WORKERS=12 / 負荷 12-23 — 24 論理 CPU の手元の機械の形）で叩き、版どうしの前後比較をする道具。サーバは何でもよい
（`bin/sober build bench/httparena/main.sober -o …` 等）。版の切り替え（ring / epoll）は末尾の env で渡す（SOBER_NET=1 = epoll）。

- env.sh: 共通の置き場 — `HTTP_TOOLS`（gcannon = gc/gcannon/gcannon・raw = req/）か `GCANNON` / `ARENA_REQ`。無ければ分かるエラーで exit 2。作業ファイルは `HTTP_WORK`（既定 mktemp -d）
- wave.sh `<srv> [rounds] [conns] [env…]`: 4096 接続の波の後に 64 接続 — ring で眠り直したワーカーが起こされない形の検査（report-672）。rt の眠りと起こし（mn / uring / netring）を触ったら回す。STRACE=1 で印の syscall の数（計測用パッチの印 — 素の rt では 0）
- dlserve.sh `[runs] [conns]`（+ dlsrv.sober）: 期限の scope の中の Serve に負荷の最中に期限を迎えさせ、終わるかを runs 回（report-700 — SQ の満杯を越えた積みが未提出の SEND を上書きして待ち手が起こされない形）。ring の SQ の積み・期限の走査・眠り / 起こしを触ったら回す
- kstat.sh `[conns] [secs] [env…]`: rt の数え口（`--rt-mutant=4` — report-699 / 701。dlsrv.sober を変異 4 で建て、期限で正常終了させて `#w` の 16 語を集計）— 盗み / 接続・子の起動遅れ・ring / futex の眠り・CQE / enter・提出の溜め・accept を取り込んだワーカーの分布を 1 行に。待ちの道の切り分けと ring の束ね・acceptor の置き場を変える便の前後比較（STAGE2=<sober2> で建てる側を差し替えて交互に）
- kstat.sh の `KA=1`: keep-alive の形（-r を外す — 接続の起動の配置が生涯固定される側・report-706）。`PER=1` でワーカーごとの行（start = 走り始めさせた task の数 = 持ち分・spawn・steal・run・眠り・cqe）。1 行の要約の末尾 `start: max / min / ratio` が配置の均等さ（acceptor のワーカーは accept で忙しく少なめに出る）。**accept / 盗み / 起動の置き場を触る便は KA=1 と既定（churn）の両方で**
- lc.sh `<srv…>`: churn（limited-conn の形 — -r 10・get / post_cl / post_chunked）を版どうし交互に ROUNDS 周（既定 5）回して周ごとの行と中央値（report-709 — churn は周ごとの揺れが大きい: 5 周以上の中央値で読む）。列 = resp・p99 / p99.9・stall（客側のソケットの SYN-SENT の割合 — report-698 の公平さの物差し）・aq（listen ソケットの accept キューの深さ 平均 / 最大）・ovf（ListenOverflows の増分）。KA=1 で keep-alive の形（get だけ）。サーバの env は SRVENV
- async.sh `<srv> [conns] [secs] [env…]`: async の形（GET /delay/10 を保持 — 既定 4096 接続 × 8 秒）を 1 回 — req/s・p50 / p99・CPU µs / 要求（report-691 / 703。眠りの器〔rt.sleep・期限・タイマー〕を触ったら前後を交互に。port は 18000 番台 — ephemeral の範囲に当たると起動できない穴の直し。要求は `$R/async-delay.raw`）
- layer.sh `<srv> <raw,…> [conns] [secs] [p] [env…]`: 要求あたりの instructions:u・user / sys の CPU µs（report-673）
- layer4.sh `<srv> <raw> [conns] [secs] [p] [env…]`: perf の事象（既定 cycles / instructions / cache-misses / dTLB — :u・EV で上書き）を要求あたり + p99（report-675〜680 — 接続数の掃引はこれを 256 / 1024 / 4096 で回す）
- depth.sh `<srv> <raw> [conns] [secs] [p] [env…]`: サーバの中の溜まりと公平さ（report-683 / 684）— 負荷の途中で ss を取り、サーバ側 / クライアント側のソケットで未読の接続の数（srvq / cliq）と、1 秒間に応答が 0 だった接続の割合・上位 25% の接続が運んだ割合（zero / top25 — 公平な一巡なら ≈ 0% / 25〜35%）を cycles / 要求と並べる。gcannon の遅延 × req/s（little）は参考 — 不公平な道では飢えている要求の待ちが入らない
- starve.sh `<srv> [conns] [env…]`: 飢えの持続（report-685）— 1 秒 / 2 秒の 2 つの窓で応答 0 の接続と、両方で 0（持続 — 独立なら A × B）・飢えている接続の segs_out の絶対値（1 = 一度も応答していない）
- layer4.sh の `EV_ALL=1`: EV の全事象を名前つきで要求あたりに（フィル元: `EV=cycles:u,ls_dmnd_fills_from_sys.dram_io_all:u,dTLB-load-misses:u EV_ALL=1` — DRAM からの行 / 要求が公平な一巡の冷えの物差し。WSL のゲストでは :k の事象は 0）

計器の置き場の建て方（揮発する scratchpad に — 例 `export HTTP_TOOLS=<dir>`）: gcannon = `.github/workflows/httparena.yml` の「Build gcannon (liburing 2.9)」を `$HTTP_TOOLS/gc` で（`git clone --branch liburing-2.9 …` → configure --prefix=$HTTP_TOOLS/gc/usr → make → gcannon を CFLAGS / LDFLAGS つきで make）・要求の raw = `curl -o $HTTP_TOOLS/req/<f> https://raw.githubusercontent.com/MDA2AV/HttpArena/main/requests/<f>`（get.raw post_cl.raw post_chunked.raw pipeline.raw）。
測り方の注意: 版どうしは交互に（同じ時間帯）・4096 接続は揺れが大きい（±10% — 3〜7 周の中央値で読む・1 点で白黒つけない）・cycles は :u（ユーザ空間だけ）・公平さ（depth.sh の zero / top25）を必ず添える（不公平な道の数字は速く見える — report-684）。
