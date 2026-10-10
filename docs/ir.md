# 独自 SSA IR

Sober の唯一の中間表現。`sober build` は AST → IR → 正規バックエンド（x86_64 ELF）で、LLVM テキスト経路は開発時専用のオラクル。
実装は lower（AST → IR）が src/compiler/lower（Sober — 主役交代 2026-09-28 以降の主）、ELF までの正規バックエンドも src/compiler/lower（x86.sober・m2r.sober・verify.sober + src/compiler/x86・src/compiler/elf — B-1〜B-4、2026-10-02。9.5 節）が主で、凍結した src/ir*.zig（ir_parse・パス・rtlower・ir_x86）は `--via=stage1` の逃げ道と照合（elfeq）の役（`--emit=ll` の rtlower + LLVM 印字も src/compiler/lower に写しがある。src/lower*.zig は凍結した stage1 の lower）。規約の正はそれぞれの冒頭コメントで、この文書はその要約と裁定の記録。

## 1. 位置づけ

- 入力は AST（B-0 入口裁定 2026-09-27）。lowering（src/lower*.zig）は AST 直吐きだった codegen.zig の後継。codegen と並走させ、正規経路が全例で観測等価に達した段で退役させた（B-9b、2026-09-27）。意味解析の重複は移行期間だけの負債だった
  - 棄てた案: コア AST（check の JSON）から下ろす。コアは型の射影であって実行の写しではない（println → unit と同じ姿勢）。忠実にすると desugar の出力と Lean のスキーマが変わる
  - 棄てた案: codegen をその場で IR 発行器に書き換える。並走中の V5 と衝突し、移行中に比べる列が消える
  - 本命の収束先: 解決済み AST 層を desugar と共有する案。段 1（表層型の解決表と nominal の規則 — language.md 32 節）を 2026-09-29 に導入。
    式の表層型の求め方は当面 desugar と lower に 2 本（lower は値の型に表層型の参照を持ち、照合点で desugar の規則を呼ぶ）— 段 2 で共有して lower 側を消す。名前解決の共有は段 3
- 下ろす範囲 = main から届く関数だけ（Q1 裁定 2026-09-28、主役交代）。未到達の関数は lower も lower 段の拒否もしない — build の受理の境界は「check（脱糖器 + Lean）の外では、到達した関数の lower」。
  - 棄てた案: Zig 版の checkUnreached（B-9a — 未到達関数も捨てモジュールに下ろして検査）。全関数を下ろしていた codegen と受理範囲を揃えるための移行期の器で、codegen の退役で動機が消えた。黄金は Sober の挙動を正として regen（examples/union.sober が受理側へ）
- 出力は 2 つ: 正規バックエンド（ir_x86 — 線形スキャン + 自前エンコーダ + ELF）と LLVM テキスト（ir_llvm — 開発時専用、`zig cc` で下ろす）
- テキスト形式: print が正で、ir_parse が読み戻す。往復は不動点になる（`print(parse(t)) == t`、scripts/ir_roundtrip.sh が gate で照合）。selfhost のコンポーネント境界として使う（Sober 製 lowering → IR テキスト → Zig 製バックエンド）

## 2. 形

- -O0 形: スカラー（int / bool / タグ / 深度 / 関数値）は SSA 値、アグリゲート（struct / union / T? / slice・map のヘッダ）はフレームスロット（語数つき）。φ はブロック引数
- mem2reg（ir_mem2reg、B-7）は IR パスで、1 語のスカラースロットをブロック引数へ持ち上げる。ELF では既定で有効（`--no-opt` で外す）、`--emit=ir|ll` では `--opt` で有効
- 型は i64 と ptr の 2 つだけ。ptr を分けるのは LLVM テキストが要求するからで、x86 ではどちらも語。bool は 0 / 1 の i64、関数値は i64（funcaddr）
- 規則（ir_verify が検査する）:
  - 値は一度だけ定義される（関数引数・ブロック引数・命令の結果）
  - 入口ブロックは前任も引数も持たない
  - 終端は 1 ブロックに 1 つ
  - condbr の 2 辺が同じ先でもよい（バックエンドが中継で割る）
  - パスを足したら、そのパスの後で必ず verify する

## 3. op

- 値: iconst / bin（add sub mul div rem and or xor shl sar）/ cmp（eq ne lt le gt ge ult uge — 結果は 0 / 1）
- メモリ: load・store（語、ptr + 語オフセット）/ load8・store8（[]byte・string のセルと io のバイトバッファ — byte の段）/ gep（語・バイト）/ ptoi・itop / slotaddr / globaladdr / funcaddr
- 呼び出し: call / call_indirect / syscall
- region: region.enter / depth / setdepth / alloc / bump / relocate
- 終端: br / condbr / ret / exit(code)
- task の罠（段 6 P3a-2a — 下の 4.5 節）: `%r = trap %callee(%arg)` / `unwind`

### 4.5 罠（task 境界の死 — 段 6 P3a-2a）

- `%r = trap %callee(%arg)`（OpTrapI）: 罠を張って関数値 callee を 1 語の実引数で呼ぶ。結果 = 0（callee が戻った）/ 1（callee の中で死んで罠へ巻き戻った）。
  最適化器・割り当て器からは結果を返す普通の間接呼び出し（call.indirect と同じ扱い — 展開しない・メモリを書きうる）
- `unwind`（OpUnwind）: 罠が張られていれば最内の罠へ巻き戻る（戻らない）。張られていなければ何もしない
- 死（exit 101 / 102）の意味の拡張: 罠を使うモジュール（@rt.trap を持つ — 罠を使わないプログラムの IR は不変）では、rt.panic / rt.panic_mem の入口が
  罠を見て、張られていれば死因（@rt.trap[1] = 101 / 102・[2] = 点 / 種類）を書いて unwind する（印字しない — 死を受けるのは罠を張った側）。
  x86 の死の口（ゼロ除算）も同じ（点 = -1）。罠が無ければ今までどおり印字して exit
- 機械語（src/compiler/lower/x86.sober の xTrap / xUnwind）: 記録は機械のスタックに [前の罠, 再開番地, xmm2〜15, 呼び手の callee-saved 11 本 = rbp + 割り当ての 10 本]。
  @rt.trap[0] = 最内の記録の番地。巻き戻し = rsp を記録へ戻して前の罠を戻し、再開番地へ ret（callee-saved は記録から戻す — 子の epilogue は飛ばされる）
- 巻き戻しは region の深度・宛先 / anchor のレジスタ・rtgrow の水位・madvise の高水位を戻さない（罠を張る側の後始末）。
  罠を張る側 = std/par の Spawn（src/compiler/lower/par.sober — P3a-2b）: 罠の前に読んだ深度・W_DEST・W_ANCHOR を罠の後で書き戻す。rtgrow の水位と madvise の高水位は
  書き戻さない — どちらも enter の側で無効化される（世代 rt.rgen・前の命の高水位）ので、深度を戻せば普通の leave と同じ状態（P3a-2c の確認）。
  最適化器は trap を「深度を変えない呼び出し」として扱わない（depth.sober / opt.sober の深度の流れ — 罠の後の setdepth を消すと 102 の子の後の子が全部死ぬ。網 = examples/par_depth）。
  `panic(L{…})` は点で `panic: L{…}` を印字してから rt.panic を呼ぶが、罠が張られていれば印字を飛ばす（印字すると fd が標準エラーへ切り替わったまま巻き戻る）
- 使い手 = std/par の即時形（src/compiler/lower/par.sober）: Spawn = 子の本体を持ち上げた関数 kid#N（実引数 = scope の region に置いた handle の枠の結果の置き場・
  捕獲は枠の結果の後ろ）を trap で呼ぶ。Join の死 = 呼び手の死（PK_TASKDIED）・Try = Outcome・Scope = 死んだ子がいれば (ゼロ値, TaskDied)
- stage1（凍結した Zig）の語彙の外: IR テキストに trap / unwind を含む entry は stage1 との照合を飛ばす（scripts/gatelib.sh の beyond_stage1 — float の段の前例どおり）。
  .ll の経路（--via=ll）は罠を持たない（trap = ただの呼び出しで結果 0・unwind = 何もしない — 罠のモジュールは .ll の照合をしない）
- 網 = scripts/trapprobe.sh（`sober build --trap-probe` — 入口が trap.probe を呼ぶ単体の例: 戻る / 101 / 102 / ゼロ除算 / 入れ子 / 深い再帰の中の死 /
  罠を跨いで callee-saved に乗る値 / 罠の外の死。3 経路〔--passes + 段ごとの検証器・既定・--no-opt〕の観測一致 + IR テキストの黄金）。
  x86 の命令の形は既存の x86enc の行列（全レジスタ × disp — push / pop / mov rsp / movsd [rsp+d] / call reg / ret）に含まれる

### 4.6 task の切替（段 6 P3b-1）

- `tswitch %save(%other)`（OpTSwitch）: 今の task の機械の文脈（呼び手の callee-saved 11 本・xmm2〜15・再開番地）を今のスタックに積み、rsp を `*save` へ書いて
  `*other` の rsp へ移り ret（相手の再開番地へ）。誰かが `*save` へ切り替えて戻すと続く — 最適化器・割り当て器からは戻ってくる不透明な呼び出し
  （trap と同じ扱い + 深度は不明 — depth.sober / opt.sober。結果は無い）
- `tstart %save(%sp, %fn, %arg)`（OpTStart）: tswitch と同じく今の文脈を `*save` に積み、rsp を `%sp`（新しいスタックの頂上）へ付け替えて fn(arg) を呼ぶ（fn は戻らない）
- 機械語 = xTrap の積み方の写し（src/compiler/lower/x86.sober の xTSave / xTRestore）。.ll の経路は切替を持たない（tstart = fn(arg) をそのまま呼ぶ・tswitch = 何もしない — 子を先に走らせる既定の 1 本道だけが動く）。stage1 の語彙の外（beyond_stage1）
- 使い手 = std/par の task の器（src/compiler/lower/task.sober）: 子は自前の機械スタック（[TCB の頁 | ガードページ | 1 MiB] の塊 — NORESERVE・プールで再利用）で走る。
  切替（rt.task_switch / rt.task_go）は今の task の深度・W_DEST・W_ANCHOR・最内の罠を TCB へ退避し、相手のを戻す。ガードページに触れた SIGSEGV は代替スタックの rt.segv が受け、
  罠へ巻き戻る（死因 = 102・種類 3 — `StackExceeded{}`）。スタックは 1 MiB（region の深度 1023 まで再帰しても溢れない — 102 の境目を P3a と同じに保つ）

### 4.7 原子の op とワーカーの記録（段 6 P4 — 裁定 2026-10-06）

- `atomic.xadd %p[off], %v` → 旧値・`atomic.cas %p[off], %old, %new` → 旧値（一致したら書く）・`atomic.xchg %p[off], %v` → 旧値・`fence`（全順序の障壁）: x86 では `lock xadd` / `lock cmpxchg` / `xchg` / `mfence`。
  x86-TSO の上なので公開（release）と取得（acquire）は素の store / load で足り、原子の op は数え上げ・待ち手の置き場・受け箱・pull 列・プールの補充だけに使う（6 節の表）
- `fsaddr @表` → 今のワーカーのその rt の表の番地。ワーカーの記録 = 表の番地の列で、表 k の番地は `fs:[8k]`（機械語は 0x64 のセグメント接頭辞つきの load 1 つ — `globaladdr` の `mov r, imm32` と同じ 1 命令）。記録は入口（ワーカーのスレッドの最初）で arch_prctl(ARCH_SET_FS) が置く（ワーカー 0 = main のスレッド — `rt.worker_init` が各表の大域の番地を並べる。P4-4 のワーカーは自分の表を確保して同じ形の記録を作る）。
  std/par を使うプログラムの rt の表（@rt.meta・@rt.trap・@rt.task・@rt.slots・@rt.sched・@rt.iobuf / iobuf2 / statbuf・@rt.rgen / gcache / btip）は `globaladdr` の代わりに `fsaddr` で引く。std/par を使わないプログラムの IR は不変（taskUse の前例）。値はスレッドの中で変わらない（task はワーカーに固定）ので、最適化器からは `globaladdr` と同じ純粋な値（CSE・巻き上げ可）。
  棄てた案: `fsaddr off` = %fs の基底 + off（記録に表を連続で置く — 基底の読み + 加算の 2 命令。spawn のラチェットの余裕が 3 命令しか無く、表ごとに 1 命令増えると越える — P4-3 の実測）
- rt の中だけで使う（ユーザーの式からは生成しない — 表層に原子の型は入れない。DRF は imm / mut + chan の型規則で立つ）。最適化器・割り当て器からは任意のメモリに触れうる不透明な呼び出し（trap / tswitch と同じ行 — 棚卸しの表に足す。前後へ load / store を動かさない・CSE しない・消さない）
- .ll の経路は持たない（罠・切替と同じ — 原子の op を持つモジュールは .ll の照合をしない）。stage1 の語彙の外（beyond_stage1 — float・罠・tswitch に続く凍結以来 4 度目の語彙拡張）
- 実装の形（P4-4）: 原子の 4 つは 1 つの op `OpAtomic`（種類と語のオフセットを c に — IR テキストは `atomic.xadd %p[off](%v)` / `atomic.cas %p[off](%old, %new)` / `atomic.xchg %p[off](%v)` / `fence`）。
  x86 は番地 → rcx・値 → rax（cas は期待 → rax・新 → rdx）で `lock xadd` / `lock cmpxchg` / `xchg` / `mfence`（x86enc の行列 = 16 レジスタ × base 16 × disp 6 × 3 形 + mfence / pause）。
  P4-6 で 5 つ目の種類 `pause`（スピンの待ちの 1 回 — fence と同じく番地・値・結果を持たない。rt のスピンの鍵と眠る前の空回しが使う）
- `clone %sp(%fn, %arg, %tls)` → 子の tid（P4-4 — `OpClone`。ワーカーのスレッドを起こす口・rt の中だけ）: CLONE_VM | FS | FILES | SIGHAND | THREAD | SYSVSEM | SETTLS の clone(2)。
  子のスタックの頂上の下に [fn, arg] を置き、子の道は syscall の直後に fn を pop して call する（引数はスタック — tstart と同じ自前の規約）。IR の中の syscall + 分岐では書けないので op にした:
  生の clone の子は親と同じ命令列を別の rsp で続けるため、割り当て器の退避の読み戻し（rbp 相対）が親のスタックを読む。fn は戻らない（戻ったらスレッドだけ exit 60）。棄てた案: syscall の op の後ろに子の道を IR で書く（上の理由）・tstart の変種（切替の文脈を新しいスレッドで再開 — 同じ理由で syscall の直後の短い道が要る）
- std/par を使うプログラムのプロセスの終わりは exit_group（231 — 全ワーカーを終える）。罠の表（xTrap / xUnwind）も fs:[8k] で引く（P4-3 の残り — x86 の罠の生成だけ大域の番地のままだった・rtlower の meta の番地も同じ — P4-4 で直した）

## 4. 全域で定義された意味 — IR に UB を持ち込まない

- div / rem: ゼロ除算は panic（exit 101）、最小値 / -1 は Go と同じ結果（div は wrap、rem は 0）
- shl / sar: 量の下位 6 bit を使う（x86 のカウントマスク）。言語のシフトの場合分け（負の量は panic・64 以上の畳み込み）は、lowering が明示の分岐で吐く
- add / sub / mul は wrap する
- ガードは各バックエンドが吐く。b が 0 でも -1 でもない定数なら省く

## 5. region を op のまま残す理由

- 「制約の配当」系の最適化（region の上界 → scope のスタック降格、region 融合）は、enter / alloc / leave の対をこの層で見る
- 展開は、両バックエンドの手前の共有パス ir_rtlower が行う（enter / alloc / relocate → ランタイム関数の call、depth / setdepth / bump → メタ領域の load / store）。`--emit=ir` には掛けない
- 深度の上限は実装の限界であって意味ではない（language.md 27 節）
- 不変条件: lower が region.enter を出すのは関数の入口と式位置の `{ }` だけ（formal.md の region 境界の列挙と同じ — 腕・while 本体・閉包の本体・文形 for の本体では出さない）。
  `--passes` の P0 は region を使わない関数の入口の対も消す

## 6. メモリ形と呼び出し規約

- union / T?: 語 0 がタグ、ペイロードは語 1 から
- slice / string: 3 語のヘッダ（ptr, len, 深度）。map: 4 語（ptr, len, 深度, 索引の番地 — 0 = 無し。性能投資 M0 2026-10-03: 長さ 8 以上の map は rt.map_find が開番地法の索引をセル列と同じ深度の region に作って引く。索引の持ち主〔セル列の番地〕が違えば作り直し・relocate でセル列が動けば外す。挿入列と順序は不変 — language.md 22 節）。map のセルは [key][tag][value]（tag 0 = 墓石）。[]byte と string のセルは 1 バイト（rodata は 8 バイトを 1 語にリトルエンディアンで詰める — byte の段 B / C、language.md 21 / 33 節）
- 組み込み error: (先頭ラベル, 鎖) の struct（K1''）。先頭は全ラベルの union、鎖は内側の error を外側から積んだ imm の []ラベル
  - 包み替え `f()? W{…}` は (W{…}, append(鎖, 先頭)) を作る
  - `case L{…, cause}` の cause は (鎖の末尾, 鎖[0 : len-1])（空なら nil）
- 結果: int / bool / 関数値 1 個なら ret、それ以外（多値・アグリゲート）は sret（呼び手が全結果の語数のスロットを取り、第 0 引数で渡す）
- 引数: 語に展開したスカラーの列
  - mut 仮引数（再帰する mut 引数の関数 = mut_def — R2）は、呼び手のセルのアドレス 1 語
  - mut 仮引数を転送するときは、受け取ったアドレスをそのまま渡す
- region 透過の実体関数（language.md 26 節 — mut 引数だけが展開の理由の非再帰関数を `--passes` で実体にしたもの）: 規約は mut_def と同じ（mut 仮引数は
  呼び手のセルのアドレス 1 語）で、違いは本体の入口だけ — `region.depth` を読んで退避するが `region.enter` しない。出口は退避した深度へ `region.setdepth`、
  戻りの境界コピーの floor = 入口の深度（= 呼び手の最内 region — 展開の呼び出し点の深度と同じ値）。既定の `--emit=ir|ll`（黄金・Zig ≡ Sober の照合の相手）は
  展開の形のまま、`--passes` のときだけ（ELF の build・自己ビルド）
- 呼び出し規約はバックエンドごとに決める（ABI は揃えない — オラクルは観測等価であってバイナリ一致ではない）
  - ir_x86: 引数は全部スタック、戻りは rax、割り当て可能レジスタ 10 本はすべて callee-saved
  - LLVM: 普通の関数
- 境界コピー（region 多相の裁定 — language.md 31 節、Lean の relocT / relocTo / regionKR）は 1 つの規則 lower_cont.relocateTo(値, 型, floor) に集めてある
  - 対象は、ヘッダの深度が floor より深いコンテナだけ。中身を先に再帰で写してから、外側のセル列を floor の region の先端へ連続に積む
  - 同じ規則を使う出口: 関数の戻りと `?`（floor = 入口の深度）、inline 展開の return と `?`（floor = 呼び出し点の深度）、式ブロックの普通の出口（floor = ブロックの入口の深度）

## 7. ランタイムは IR で書く

- ir_rt.zig・ir_rt_io.zig: 入口 `sober_entry(sp)`（アリーナの mmap 予約・深度 0）、region の enter / alloc / relocate、行バッファの印字、map の探索・文字列比較、io（cstr / read_file / write_file / write_all / read_args / read_dir / write_fd — 2026-09-28 の io の器、language.md 28 節）、`--mem-trace`（深度ごとの割り当て総量を exit 時に stderr へ）
- 両バックエンドが普通の関数として下ろす
- アリーナのスロット（2026-09-28）: 大きさは実行時の値で、メタ領域の SLOT_SIZE に置く（enter / alloc / memtrace はそこから読む）。既定 4GiB × 1024 深度 = 4TiB の MAP_NORESERVE 予約、環境変数 `SOBER_REGION_MB`（MiB の 10 進、1〜65536。それ以外は無視）で上書き、予約が断られたら半分にして 1MiB まで再試行（language.md 27 節）
- huge page を使わない（2026-10-05、RSS 回収便）: 入口が予約したアリーナに madvise(MADV_NOHUGEPAGE) を掛ける（失敗は無視）。透過的 huge page では深度のスロットに 1 バイト触るだけで 2 MB が RSS に乗り、小さいプログラムでも 4〜6 MB・コンパイラ自身の自己 build で 540 MB だった（→ 226 MB）。代価 = TLB の利得（自己 build の cycles +1.5〜3%・題材は揺れの範囲）
- slice の幾何成長（2026-10-05、データ構造便 — src/compiler/lower/rtgrow.sober）: append が先端でないときは rt.slice_grow / rt.slice_grow8（ヘッダの値を受け取り新しい列の先頭を返す）。初回の全コピーは長さちょうど（先端に戻る）・rt の側の表（rt.gcache — 直接写像 64 項 × [番地, 深度, 世代, 水位, 容量の終わり]）に載った列がもう一度全コピーになるとき（2 本が先端を奪い合う）は余剰容量つき（2 × (長さ + 1)）。表の項の番地・深度・世代が一致しヘッダの終わり == 水位で容量に空きがあればその場で水位を進める — 同じ割り当てを共有するヘッダのうち伸ばせるのは先に伸ばした方だけ（先端の判定と同じ排他）なので値の意味論は不変（容量・水位は観測不能 — Lean 無変更）。世代（rt.rgen — 深度ごと）は full の enter とループの反復の軽い enter（rt.region_enter_lloop）が進める（関数の入口の軽い enter は自分の深度に確保しないので進めない）
- 深度の計測口（2026-10-05、宛先構築レーン M5c）: 環境変数 `SOBER_DEPTH_REPORT`（1 以上の 10 進）が立っていれば、main の正常終了で `rt.depth_report` が `region_depth{max: d}` を stderr へ書く（d = 一度でも入った最深の深度 — 深度ごとの bump は enter〔full・軽い〕でだけ初期化され出ても 0 に戻らないので、熱い経路に計測の命令を足さずに読める）。旗はメタ領域の末尾の W_DREP（入口が置く）。panic（101 / 102）の経路は書かない（102 は死亡ダンプが深度を出す）。用途 = 深度の契約（language.md 27 節 — 1023 段）の消費の実測
- 入口の引数: `_start` は初期 rsp（argc の位置 — `[argc, argv…, 0, envp…, 0]`）を sober_entry の引数 0 として渡す（ir_x86: `mov rax, rsp; and rsp, -16; sub rsp, 8; push rax; call`、LLVM: `movq %rsp, %rdi` の後に整列して call）。環境変数を読むのと、argv の置き場としてメタ領域の W_ARGV（末尾に足した 1 語 — 既存の語の番地は動かさない）に保存するのに使う（rt.read_args が読む）。引数を宣言しない sober_entry（テストの IR テキスト）は読まないだけで動く
- 終了コード（2026-09-28）: `func main() int` なら入口が戻り値を受け、0〜255 の外は exit 101、内なら `syscall(231, code)`（exit_group）。後ろは到達しない定数の exit 0 — IR の exit 終端子は定数 code のままで、op は増やしていない（language.md 27 節）
- ランタイムは Zig 版と Sober 版（src/compiler/lower/rt.sober — ir_rt / ir_rt_io の写し。同じ命令列を同じ順で組む）の二重化。IR テキスト / .ll 黄金とのバイト一致が見張る（selfhost_lower / selfhost_ll）
- 棄てた案: .ll の手書きプレリュード（LLVM 専用になる）、Zig 製オブジェクトのリンク（実装言語が増える）

## 8. LLVM への対応（開発時専用の経路）

- sober は .ll のテキストを吐くだけ（`sober build --emit=ll`）。子プロセスは起動しない
- 下ろすのは `zig cc -target x86_64-linux-none -nostdlib -static`（Zig 同梱の LLVM — clang は立てない。新しい依存はゼロで、ツールチェーンは build と同じ zig 1 本）。呼ぶのは scripts とテストだけ
- 対応:
  - i64 / ptr はそのまま
  - スロットは入口でゼロ初期化した `alloca [n x i64]`（未初期化読みの poison を塞ぐ — mem2reg の「定義前の読みは 0」もこれに依存する）
  - アグリゲートは first-class にしない（gep i64）
  - nsw / nuw を付けない
  - `unreachable` は exit syscall の直後だけに置く
  - mustprogress を付けない（無限ループを UB にしない）
  - 全関数に no-builtins を付ける
  - エントリは module asm の `_start`
- -O0 / -O2 の 2 列を UB 検出器にする: 同じ .ll を両方のレベルで下ろして観測等価を照合する。食い違えば UB 漏れの兆候。LLVM 自身をタダの UB 検出器として使う形

## 9. 観測の列（scripts/obs.sh）

| 列 | 経路 | 食い違いが示すもの |
|---|---|---|
| default | `sober build`（IR パス + ir_x86） | 期待値 `.out` からのずれ |
| ir-x86raw | `--no-opt` | IR パス（mem2reg）か割り当て器のバグ |
| sober | `--no-opt`（ir-x86raw と同じ形 — B-1d の名残の綴り）。scripts/elfeq.sh が stage1 との ELF のバイト一致（3 形）と合わせて回す | 移植のずれ（バイト一致が先に鳴る — 観測が同じでも割り当ての違いを拾う） |
| stage1 | `--via=stage1`（凍結した Zig の正規バックエンド — B-4 までの既定） | 逃げ道（新しい IR op を Sober 側が拒否したとき等） |
| llvm / llvm2 | `--emit=ll` → `zig cc -O0 / -O2` | 正規バックエンドのバグ / UB 漏れ |
| opt / opt2 | `--emit=ll --opt` | IR パスのバグ |
| [ReleaseSafe] default | ReleaseSafe でビルドしたコンパイラ | Debug では偶然読めてしまう死んだスタックの読み（B-9b で mem2reg の UseIter に実発） |

- 移行期間には direct（AST 直吐き）列があり、独立な 2 フロントエンドの差分でバグを拾っていた（inline の return 深度など）
- 退役でこのオラクルは失った。代わりの守りは次のとおり:
  - 新しい例の `.out` は手で導出する（実行結果を貼らない）
  - 拒否の表 src/stage1/diag_cases.zig を lower と check の両方に通す（`check_ok` = check が受理する既知の差）
  - IR 列同士の差分と ReleaseSafe 列

## 9.5 正規バックエンドの Sober 化（B-1〜B-5 — 2026-10-02〜）

- src/compiler/lower/x86.sober（命令選択・linear scan・生存区間・cfg）・src/compiler/x86（エンコーダ）・src/compiler/elf（ELF — @layout）は src/ir_x86*.zig・ir_live.zig・ir_cfg.zig・arch/x86_64.zig・format/elf.zig の写し。
  正しさの根拠は stage1 が同じ IR テキストから建てた ELF とのバイト一致（scripts/elfeq.sh）と、エンコーダの GNU as との全行列の照合（scripts/x86enc.sh）
- 写しの規律の逸脱 1 点: 生存解析。Zig 版は「ブロック数 × 値の数」のビット集合で live-in / live-out の不動点を反復するが、Sober 版は上向きに露出した使用
  （定義のブロックの外の使用）から前任へ辿る経路探索（SSA の path exploration）。到達するブロックの live-in / live-out は最小不動点と一致するので区間は同じ —
  elfeq のバイト一致（src/compiler/app 自身の 47.6 MB を含む）がそれを示す。メモリは使用の総数に比例し、stage1 が巨大な関数で踏む爆発（src/compiler/app の
  `build x.ir --no-opt` が 589 s / 29 GB — Sober 版は 31.5 s / 1.6 GB）を構造的に持たない

- B-4（2026-10-02）: `bin/sober build` の既定が Sober の正規バックエンド（stage2 の `--emit=elf --passes` — 設計整合パス + mem2reg）。default / ir-x86raw の列・hermetic（stage2 の ELF も比べる）・io_args・gates の道具は Sober 正規で建つ。
  実行の bit は stage2 が付ける（std/os.WriteMode — language.md 28 節）。`sober test` のランナーもテストのビルドを Sober の正規バックエンドで in-process に建てる（stage1 の呼び出しは無い）
- B-5（2026-10-02）: stages の固定点をバイナリ一致へ昇格（上の 10 節・design-dev.md 最終オラクル項）。続けて stage2 自身も最後の boot の `--emit=elf` で建てる（scripts/stage2.sh —
  .ll → zig cc は SOBER_O1 の列と、正規バックエンドを持たない鎖の古い段だけ）
- B-3: mem2reg（src/compiler/lower/m2r.sober — ir_mem2reg.zig の写し）と検証器（src/compiler/lower/verify.sober — ir_verify.zig の写し）。経路は
  build → [設計整合パス] → mem2reg → rtlower → 正規バックエンド、各段の後に検証（違反は内部エラー）。mem2reg の支配境界と置いた引数の表は数えてから詰めて
  持つ（CSR）が、ブロックに置く引数の並び（スロットの通し番号の順）と詰め直しの番号は Zig 版と同じ — elfeq の 3 形（IR パスなし・mem2reg・設計整合パス + mem2reg）が見る。
  検証器は値の型を記録から導く（Sober の IR は値の型の表を持たない）ので、結果の型の検査は Zig 版より弱い。
  設計整合パスの P4（空ブロックの短絡）は出口でその関数の前任数（B_PREDS）を辺から数え直す — 各段の後の IR が正しい（3 つの経路 Elf / Ir / Ll で揃う）。
  棄てた案: パスの後にモジュール全体で数え直す（2026-10-02 まで — P4 の後の IR が一時的に不整合）・付け替えごとに増減で保つ（誤りやすく、読む者がいない）

## 10. 実装の現在地（2026-10-02）

- 正規バックエンドの Sober 化 done（B-1〜B-5 — 9.5 節）: `sober build` の既定は Sober の正規バックエンド。固定点はバイナリ一致（stage3 の ELF ≡ stage4 の ELF + stage1 との交差照合 —
  design-dev.md 最終オラクル項）。凍結した Zig の正規バックエンドは `--via=stage1` と照合（elfeq・stages の交差照合）の役

### 2026-09-27 の時点

- B-1〜B-10 + region 多相の還流（R0〜R5・K1''）まで done。全例（obs 63 本）が全列で一致する
- 正規バックエンドの最初の配当: direct 比で約 2 倍速（design-dev.md「バックエンド戦略」の条件つきの数字）
- コンパイル速度の最初の値: ReleaseFast のコンパイラで obs の 60 例を 0.20s（1 例あたり約 3ms。比較相手はまだ無い）
