# 独自SSA IR

Soberの唯一の中間表現。`sober build` はAST → IR → 正規バックエンド（x86_64 ELF）で、LLVMテキスト経路は開発時専用のオラクル。
実装はlower（AST → IR）がsrc/compiler/lower（Sober — 主役交代2026-09-28以降の主）、ELFまでの正規バックエンドもsrc/compiler/lower（x86.sober・m2r.sober・verify.sober + src/compiler/x86・src/compiler/elf — B-1〜B-4、2026-10-02。9.5節）が主で、凍結したsrc/ir*.zig（ir_parse・パス・rtlower・ir_x86）は `--via=stage1` の代替経路と照合（elfeq）の役（`--emit=ll` のrtlower + LLVM印字もsrc/compiler/lowerに移植がある。src/lower*.zigは凍結したstage1のlower）。規約の正はそれぞれの冒頭コメントで、この文書はその要約と決定の記録。

## 1. 位置づけ

- 入力はAST（B-0入口決定2026-09-27）。lowering（src/lower*.zig）はAST直吐きだったcodegen.zigの後継。codegenと並走させ、正規経路が全例で観測等価に達した段階で退役させた（B-9b、2026-09-27）。意味解析の重複は移行期間だけの負債だった
  - 棄てた案: コアAST（checkのJSON）から下ろす。コアは型の射影であって実行の複製ではない（println → unitと同じ姿勢）。忠実にするとdesugarの出力とLeanのスキーマが変わる
  - 棄てた案: codegenをその場でIR発行器に書き換える。並走中のV5と衝突し、移行中に比べる列が消える
  - 本命の収束先: 解決済みAST層をdesugarと共有する案。フェーズ1（表層型の解決表とnominalの規則 — language.md 32節）を2026-09-29に導入。
    式の表層型の求め方は当面desugarとlowerに2本（lowerは値の型に表層型の参照を持ち、照合点でdesugarの規則を呼ぶ）— フェーズ2で共有してlower側を消す。名前解決の共有はフェーズ3
- 下ろす範囲 = mainから届く関数だけ（Q1決定2026-09-28、主役交代）。未到達の関数はlowerもlowerの段階の拒否もしない — buildの受理の境界は「check（脱糖器 + Lean）の外では、到達した関数のlower」。
  - 棄てた案: Zig版のcheckUnreached（B-9a — 未到達関数も捨てモジュールに下ろして検査）。全関数を下ろしていたcodegenと受理範囲を揃えるための移行期の器で、codegenの退役で動機が消えた。ゴールデンはSoberの挙動を正としてregen（examples/union.soberが受理側へ）
- 出力は2つ: 正規バックエンド（ir_x86 — 線形スキャン + 自前エンコーダ + ELF）とLLVMテキスト（ir_llvm — 開発時専用、`zig cc` で下ろす）
- テキスト形式: printが正で、ir_parseが読み戻す。往復は不動点になる（`print(parse(t)) == t`、scripts/ir_roundtrip.shがgateで照合）。selfhostのコンポーネント境界として使う（Sober製lowering → IRテキスト → Zig製バックエンド）

## 2. 形

- -O0形: スカラー（int / bool / タグ / 深度 / 関数値）はSSA値、アグリゲート（struct / union / T? / slice・mapのヘッダ）はフレームスロット（ワード数つき）。φ はブロック引数。スロットは入口で0（IRの約束 — x86の最適化のバックエンドは0を観測できるワードだけを0にする〔docs/regalloc.mdのフレーム〕。開発用の毒のオプションSOBER_SLOT_POISONは他のワードを0x5a… で埋める）
- mem2reg（ir_mem2reg、B-7）はIRパスで、1ワードのスカラースロットをブロック引数へ持ち上げる。ELFでは既定で有効（`--no-opt` で外す）、`--emit=ir|ll` では `--opt` で有効
- 型はi64とptrの2つだけ。ptrを分けるのはLLVMテキストが要求するからで、x86ではどちらもワード。boolは0 / 1のi64、関数値はi64（funcaddr）
- 規則（ir_verifyが検査する）:
  - 値は一度だけ定義される（関数引数・ブロック引数・命令の結果）
  - 入口ブロックは前任も引数も持たない
  - 終端は1ブロックに1つ
  - condbrの2辺が同じ先でもよい（バックエンドが中継で分ける）
  - パスを足したら、そのパスの後で必ずverifyする

## 3. op

- 値: iconst / bin（add sub mul div rem and or xor shl sar）/ cmp（eq ne lt le gt ge ult uge — 結果は0 / 1）
  - iconstの札（2026-10-26 — インクリメンタルのフェーズ2・docs/incremental.md）: 発見順の番号（panic / spawnの点）を運ぶ定数は記録のフィールドbに札を持つ（テキスト形式には出ない — `const n` のまま）。札つきは札なしとGVNで併合されず、正規バックエンドはimm32を後埋めにする
- メモリ: load・store（ワード、ptr + ワードオフセット）/ load8・store8（[]byte・stringのセルとioのバイトバッファ — byteのフェーズ）/ load16・store16・load32・store32（pool.Scratchの狭いワードのAPI — ptr + バイトの変位・読み込みは0拡張・書きは値の下位だけ。stage1の語彙の外 — gatelibのbeyond_stage1）/ gep（ワード・バイト）/ ptoi・itop / slotaddr / globaladdr / funcaddr
- 呼び出し: call / call_indirect / syscall
  - syscallの札のop（x86の正規バックエンドのELFのパスだけ命令 — 他の出力では値0か無発行）: vcall・aesの手書きの本体・montmul・cycles / tsc・`prefetch(%a)`（2026-11-01 — rt専用のprefetcht0。値も副作用も無い・番地が不正でも落ちない — 走れるスタックの次の候補の先読み）
- region: region.enter / depth / setdepth / alloc / bump / relocate
- 終端: br / condbr / ret / exit(code)
- taskの罠（フェーズ6 P3a-2a — 下の4.5節）: `%r = trap %callee(%arg)` / `unwind`

### 4.5 罠（task境界の死 — フェーズ6 P3a-2a）

- `%r = trap %callee(%arg)`（OpTrapI）: 罠を張って関数値calleeを1ワードの実引数で呼ぶ。結果 = 0（calleeが戻った）/ 1（calleeの中で死んで罠へ巻き戻った）。
  最適化器・割り当て器からは結果を返す普通の間接呼び出し（call.indirectと同じ扱い — 展開しない・メモリを書きうる）
- `unwind`（OpUnwind）: 罠が張られていれば最内の罠へ巻き戻る（戻らない）。張られていなければ何もしない
- 死（exit 101 / 102）の意味の拡張: 罠を使うモジュール（@rt.trapを持つ — 罠を使わないプログラムのIRは不変）では、rt.panic / rt.panic_memの入口が
  罠を見て、張られていれば死因（@rt.trap[1] = 101 / 102・[2] = 点 / 種類）を書いてunwindする（印字しない — 死を受けるのは罠を張った側）。
  x86の死ぬ箇所（ゼロ除算）も同じ（点 = -1）。罠が無ければ今までどおり印字してexit
- 機械語（src/compiler/lower/x86.soberのxTrap / xUnwind）: 記録は機械のスタックに [前の罠, 再開番地, xmm2〜15, 呼び手のcallee-saved 11本 = rbp + 割り当ての10本]。
  @rt.trap[0] = 最内の記録の番地。巻き戻し = rspを記録へ戻して前の罠を戻し、再開番地へret（callee-savedは記録から戻す — 子のepilogueは飛ばされる）
- 巻き戻しはregionの深度・宛先 / anchorのレジスタ・rtgrowの水位・madviseの高水位を戻さない（罠を張る側の後始末）。
  罠を張る側 = std/taskのSpawn（src/compiler/lower/task.sober — P3a-2b）: 罠の前に読んだ深度・W_DEST・W_ANCHORを罠の後で書き戻す。rtgrowの水位とmadviseの高水位は
  書き戻さない — どちらもenterの側で無効化される（世代rt.rgen・前の命の高水位）ので、深度を戻せば普通のleaveと同じ状態（P3a-2cの確認）。
  最適化器はtrapを「深度を変えない呼び出し」として扱わない（depth.sober / opt.soberの深度の流れ — 罠の後のsetdepthを消すと102の子の後の子が全部死ぬ。テスト = examples/task_depth）。
  `panic(L{…})` は点で `panic: L{…}` を印字してからrt.panicを呼ぶが、罠が張られていれば印字を飛ばす（印字するとfdが標準エラーへ切り替わったまま巻き戻る）
- 使い手 = std/taskの即時形（src/compiler/lower/task.sober）: Spawn = 子の本体を持ち上げた関数kid#N（実引数 = scopeのregionに置いたhandleの枠の結果の格納場所・
  捕獲は枠の結果の後ろ）をtrapで呼ぶ。Joinの死 = 呼び手の死（PK_TASKDIED）・Try = Outcome・Scope = 死んだ子がいれば (ゼロ値, ChildDied)
- stage1（凍結したZig）の語彙の外: IRテキストにtrap / unwindを含むentryはstage1との照合を飛ばす（scripts/gatelib.shのbeyond_stage1 — floatのフェーズの前例どおり）。
  .llの経路（--via=ll）は罠を持たない（trap = ただの呼び出しで結果0・unwind = 何もしない — 罠のモジュールは .llの照合をしない）
- テスト = scripts/trapprobe.sh（`sober build --trap-probe` — 入口がtrap.probeを呼ぶ単体の例: 戻る / 101 / 102 / ゼロ除算 / 入れ子 / 深い再帰の中の死 /
  罠を跨いでcallee-savedに乗る値 / 罠の外の死。3経路〔--passes + 段階ごとの検証器・既定・--no-opt〕の観測一致 + IRテキストのゴールデン）。
  x86の命令の形は既存のx86encの行列（全レジスタ × disp — push / pop / mov rsp / movsd [rsp+d] / call reg / ret）に含まれる

### 4.6 taskの切替（フェーズ6 P3b-1）

- `tswitch %save(%other)`（OpTSwitch）: 今のtaskの機械の文脈（呼び手のcallee-saved 11本・xmm2〜15・再開番地）を今のスタックに積み、rspを `*save` へ書いて
  `*other` のrspへ移りret（相手の再開番地へ）。誰かが `*save` へ切り替えて戻すと続く — 最適化器・割り当て器からは戻ってくる不透明な呼び出し
  （trapと同じ扱い + 深度は不明 — depth.sober / opt.sober。結果は無い）
- `tstart %save(%sp, %fn, %arg)`（OpTStart）: tswitchと同じく今の文脈を `*save` に積み、rspを `%sp`（新しいスタックの頂上）へ付け替えてfn(arg) を呼ぶ（fnは戻らない）
- 機械語 = xTrapの積み方のコピー（src/compiler/lower/x86.soberのxTSave / xTRestore）。.llの経路は切替を持たない（tstart = fn(arg) をそのまま呼ぶ・tswitch = 何もしない — 子を先に走らせる既定の1本の経路だけが動く）。stage1の語彙の外（beyond_stage1）
- 使い手 = std/taskのtaskの器（src/compiler/lower/task.sober）: 子は自前の機械スタック（[ガードページ | 1 MiB | ページ: スタックの頂上 + TCB | TC_SAVEの続き] のチャンク — NORESERVE・プールで再利用・TCBはページの途中で、スタックはその直下から下へ）で走る。
  切替（rt.task_switch / rt.task_go）は今のtaskの深度・W_DEST・W_ANCHOR・最内の罠をTCBへ退避し、相手のを戻す。ガードページに触れたSIGSEGVは代替スタックのrt.segvが受け、
  罠へ巻き戻る（死因 = 102・種類3 — `StackExceeded{}`）。スタックは1 MiB（regionの深度1023まで再帰しても溢れない — 102の境目をP3aと同じに保つ）

### 4.7 原子のopとワーカーの記録（フェーズ6 P4 — 決定2026-10-06）

- `atomic.xadd %p[off], %v` → 旧値・`atomic.cas %p[off], %old, %new` → 旧値（一致したら書く）・`atomic.xchg %p[off], %v` → 旧値・`fence`（全順序の障壁）: x86では `lock xadd` / `lock cmpxchg` / `xchg` / `mfence`。
  x86-TSOの上なので公開（release）と取得（acquire）は素のstore / loadで足り、原子のopは数え上げ・待ち手の格納場所・受信箱・pull列・プールの補充だけに使う（6節の表）
- `fsaddr @表` → 今のワーカーのそのrtの表の番地。ワーカーの記録 = 表の番地の列で、表kの番地は `fs:[8k]`（機械語は0x64のセグメント接頭辞つきのload 1つ — `globaladdr` の `mov r, imm32` と同じ1命令）。記録は入口（ワーカーのスレッドの最初）でarch_prctl(ARCH_SET_FS) が置く（ワーカー0 = mainのスレッド — `rt.worker_init` が各表の大域の番地を並べる。P4-4のワーカーは自分の表を確保して同じ形の記録を作る）。
  std/taskを使うプログラムのrtの表（@rt.meta・@rt.trap・@rt.task・@rt.slots・@rt.sched・@rt.iobuf / iobuf2 / statbuf・@rt.rgen / gcache / btip）は `globaladdr` の代わりに `fsaddr` で引く。std/taskを使わないプログラムのIRは不変（taskUseの前例）。値はスレッドの中で変わらない（taskはワーカーに固定）ので、最適化器からは `globaladdr` と同じ純粋な値（CSE・巻き上げ可）。
  棄てた案: `fsaddr off` = %fsの基底 + off（記録に表を連続で置く — 基底の読み込み + 加算の2命令。spawnのラチェットの余裕が3命令しか無く、表ごとに1命令増えると越える — P4-3の実測）
- rtの中だけで使う（ユーザーの式からは生成しない — 表層に原子の型は入れない。DRFはimm / mut + chanの型規則で立つ）。最適化器・割り当て器からは任意のメモリに触れうる不透明な呼び出し（trap / tswitchと同じ行 — 棚卸しの表に足す。前後へload / storeを動かさない・CSEしない・消さない）
- .llの経路は持たない（罠・切替と同じ — 原子のopを持つモジュールは .llの照合をしない）。stage1の語彙の外（beyond_stage1 — float・罠・tswitchに続く凍結以来4度目の語彙拡張）
- 実装の形（P4-4）: 原子の4つは1つのop `OpAtomic`（種類とワードのオフセットをcに — IRテキストは `atomic.xadd %p[off](%v)` / `atomic.cas %p[off](%old, %new)` / `atomic.xchg %p[off](%v)` / `fence`）。
  x86は番地 → rcx・値 → rax（casは期待 → rax・新 → rdx）で `lock xadd` / `lock cmpxchg` / `xchg` / `mfence`（x86encの行列 = 16レジスタ × base 16 × disp 6 × 3形 + mfence / pause）。
  P4-6で5つ目の種類 `pause`（スピンの待ちの1回 — fenceと同じく番地・値・結果を持たない。rtのスピンの鍵とスリープ前の空回しが使う）
- `clone %sp(%fn, %arg, %tls)` → 子のtid（P4-4 — `OpClone`。ワーカーのスレッドを起動するop・rtの中だけ）: CLONE_VM | FS | FILES | SIGHAND | THREAD | SYSVSEM | SETTLSのclone(2)。
  子のスタックの頂上の下に [fn, arg] を置き、子のパスはsyscallの直後にfnをpopしてcallする（引数はスタック — tstartと同じ自前の規約）。IRの中のsyscall + 分岐では書けないのでopにした:
  生のcloneの子は親と同じ命令列を別のrspで続けるため、割り当て器の退避の読み戻し（rbp相対）が親のスタックを読む。fnは戻らない（戻ったらスレッドだけexit 60）。棄てた案: syscallのopの後ろに子のパスをIRで書く（上の理由）・tstartの変種（切替の文脈を新しいスレッドで再開 — 同じ理由でsyscallの直後の短いパスが要る）
- std/taskを使うプログラムのプロセスの終わりはexit_group（231 — 全ワーカーを終える）。罠の表（xTrap / xUnwind）もfs:[8k] で引く（P4-3の残り — x86の罠の生成だけ大域の番地のままだった・rtlowerのmetaの番地も同じ — P4-4で直した）

## 4. 全域で定義された意味 — IRにUBを持ち込まない

- div / rem: ゼロ除算はpanic（exit 101）、最小値 / -1はGoと同じ結果（divはwrap、remは0）
- shl / sar: 量の下位6 bitを使う（x86のカウントマスク）。言語のシフトの場合分け（負の量はpanic・64以上の畳み込み）は、loweringが明示の分岐で吐く
- add / sub / mulはwrapする
- ガードは各バックエンドが吐く。bが0でも -1でもない定数なら省く

## 5. regionをopのまま残す理由

- 「制約の利点」系の最適化（regionの上界 → scopeのスタック降格、region融合）は、enter / alloc / leaveの対をこの層で見る
- 展開は、両バックエンドの手前の共有パスir_rtlowerが行う（enter / alloc / relocate → ランタイム関数のcall、depth / setdepth / bump → メタ領域のload / store）。`--emit=ir` には掛けない
- 深度の上限は実装の限界であって意味ではない（language.md 27節）
- 不変条件: lowerがregion.enterを出すのは関数の入口と式位置の `{ }` だけ（formal.mdのregion境界の列挙と同じ — 分岐・while本体・クロージャの本体・文形forの本体では出さない）。
  `--passes` のP0はregionを使わない関数の入口の対も消す

## 6. メモリ形と呼び出し規約

- union / T?: ワード0がタグ、ペイロードはワード1から
- slice / string: 3ワードのヘッダ（ptr, len, 深度）。map: 4ワード（ptr, len, 深度, 索引の番地 — 0 = 無し。性能投資M0 2026-10-03: 長さ8以上のmapはrt.map_findが開番地法の索引をセル列と同じ深度のregionに作って引く。索引の持ち主〔セル列の番地〕が違えば作り直し・relocateでセル列が動けば外す。挿入列と順序は不変 — language.md 22節）。mapのセルは [key][tag][value]（tag 0 = 墓石）。[]byteとstringのセルは1バイト（rodataは8バイトを1ワードにリトルエンディアンで詰める — byteのフェーズB / C、language.md 21 / 33節）
- 組み込みerror: (先頭ラベルのタグ, ラベルの列) の4ワードのstruct（K1'' — errsz 2026-11-10に改訂）。列はimmの []ラベル（セル = 全ラベルのunion・regionの中）で、空なら先頭はフィールドなしでcauseなし（確保ゼロ）、空でなければ末尾のセルが先頭・その前が包み替えで積んだチェーン。frameのerrorの大きさは閉世界のラベルに依らない。フィールドを持つラベルのセルは、return文の値なら戻りのコピー先の深度（retFloor — 呼び手の深度）に `rt.err_alloc` で作り（宛先構築 — 作る関数のregionに確保が載らない）、他は今の深度に `rt.region_alloc` で作る。`rt.err_alloc` はllightのマーク: 呼んだパスは非nilのerrorを返すパスなので、呼び手の反復のregionの判定（rlightのllAllocContinues）はその呼び先の確保を結果のerror? のタグが非nilの辺からだけ辿る（失敗をcatchしてループを続ければ頭へ戻るので数えられる — 負例examples/iter_region_errcont）。llightの後で `rt.region_alloc` に書き換え、上界の解析とrtlowerはふつうの確保として見る。境界コピーは補助1本 `rt.err_relocate(p, floor)`（本体 = 列のコピー — セルのunionのvariantごとのコピー・lower/cont.sober buildErrReloc）を呼ぶ: セルは閉世界の全ラベルのunionなので、その場に並べると点ごとの費用が「stringを持つラベルのフィールドの数」に比例し、ラベルを1つ足すだけで全部のerrorの境界コピーが膨らむ（自己build +35%の実発 — report-1285。検査 = stagesのerrnonint）。nilの判定は呼び手に残る。棄てた案: 先頭ラベルを全ラベルのunionとしてinlineに置く旧形（どこかのpackageの大きいラベルが全関数のerrorのスロットを広げた — pg.Serverでkid#2 +528 B）・関数ごとの @errorsの集合で幅を決める形（関数値の型1つに表現1つが要り大域に戻る）・小さいpayloadだけinline（しきい値が条件付きの規則になる）
  - 包み替え `f()? W{…}` は (W{…}, append(チェーン, 先頭)) を作る
  - `case L{…, cause}` のcauseは (チェーンの末尾, チェーン[0 : len-1])（空ならnil）
- 結果: int / bool / 関数値1個ならret、それ以外（多値・アグリゲート）はsret（呼び手が全結果のワード数のスロットを取り、第0引数で渡す）
- 引数: ワードに展開したスカラーの列。ただし次の2種類は番地1ワードで渡す
  - mut仮引数（再帰するmut引数の関数 = mut_def — R2）は、呼び手のセルのアドレス1ワード
  - 参照で渡す仮引数（P7 — 2026-11-13）: 型のワード数がK = 8を超えるimmのstruct・union・T?で、mapを含まない型（lower.sober refParamTy）。
    判定は型だけで決まるので、直接の呼び出しと関数値の呼び出し（call_indirect）で同じ規約になる。呼び手は、呼び出しの間に書かれないと分かる番地を
    そのまま渡す — immの束縛のスロット・参照で受けた仮引数・その呼び出し点だけの受け皿・展開の実引数とクロージャの捕捉のコピーと、そこから定数の
    gepでたどった番地（privMark）、および書かれえない形のmutの束縛のセル（expr.sober cellRefOk — 同じ呼び出しにmut実引数が無く、他の実引数が
    名前・リテラル・フィールド・演算だけ。クロージャはmutの束縛を捕捉できない〔spec 5章F-16〕ので、関数型の実引数や格納したクロージャを経由して
    セルが書かれる経路は無い）。それ以外（sliceの要素・パターンの束縛・合流の値・条件を満たさないmutの束縛）は呼び出しの前に一時のスロットへ
    コピーしてから番地を渡す。呼ばれる側はフィールドを番地から読み、番地の先を書かない。値を外へ出す点（格納・戻り値・taskへの受け渡し・捕捉）では
    その点でコピーする。境界コピー（relocateTo）は参照で渡した値を書き換えない（中身は呼び手の深度以下にあり、呼ばれる側のどの床よりも深くない）。
    展開の実引数のうち参照で渡す型の値は、元が長寿命の書かれない番地（束縛のスロット・参照で受けた仮引数・使い回さない受け皿・クロージャの捕捉の
    スロット）ならコピーせずに同じ番地を使う（lower.sober copyPriv — 展開の仮引数の束縛は呼び出しの式の中で終わるので、元の寿命が覆う）。
    mapを含む型を除くのはバックエンドの条件で、言語の規則ではない（mapの遅延の索引の作成が呼び手の実体に書く形を作らない — language.md 22節
    「凍ったmapの封」の棄てた案(B)には触れない）
  - mut仮引数・参照で渡す仮引数を転送するときは、受け取ったアドレスをそのまま渡す
  - 関数の記録のマーク: mut仮引数はF_MUTP、参照で渡す仮引数はF_REFP（ビットk = 引数k）。F_MUTPを読む別名の事実（hloop・ldhoist・hdr）と
    rflowの出口の判定は参照で渡す仮引数を対象にしない。slotcolorはF_REFPの引数へ渡したスロットを呼び出しの点の読み書きとして数える（保守側）。
    関数値の呼び出しのマーク（CALLI_MSH — 下の項）は、参照で渡す仮引数の位置にも立てる（slotcolorにとって同じ意味）
  - 費用（report-fq-3）: 番地を渡す値はスロットに残り（SSAへ昇格できない）、全ワードが書かれたと示せない道があれば入口の零初期化の対象になる
    （httparenaのserveTlsConnのフレーム +144 B・命令は −484 / リクエスト）
  - 棄てた案: 全部の集成値を参照で渡す（数ワードのstructは番地の読みの分だけ遅く、コピーがSSAへ昇格して消える利点も失う）・mapを含む型も参照で
    渡す（索引の作成がimmの値の実体に書く形になる）・F_MUTPのビットを参照で渡す仮引数にも使う（別名の事実とrflowの判定の意味が変わる）・
    結果の受け皿をimmの束縛にそのまま使う（受け皿の転送 — 呼び出し点ごとの受け皿が束縛の寿命の間生き、彩色で重ねられずフレームが太る）・
    小さな集成値の展開の実引数でもコピーを省く（コピーがSSAへ昇格して消える方が安く、メモリの上限の解析もコピーの値から読む）
  - 呼ばれた関数はmut仮引数の番地を呼び出しの間だけ使う（格納・taskへの受け渡し・retの語彙は無い）。バックエンドのスロットの彩色（slotcolor.sober — F-1のフェーズ2）はこれを前提に、mut仮引数へ渡したスロットの番地を呼び出しの点の読み書きとして数える（マークの無い引数へ渡した番地は逃げ — 専用の格納場所）
  - 関数値の呼び出し（call_indirect）の関数型のmut仮引数（`func(out mut Out, …)` — language.md 25・26節）も同じ約束。呼び先の記録が無いので、マークは命令の結果の型のフィールドの上位ビットに持つ（ir.sober CALLI_MSH — 結果の型 + マーク << 8・マークのビットj = 引数の列のj番目。IRテキストには出ない — iconstの札と同じ・展開のコピーはフィールドをそのまま運ぶ）。slotcolorはその実引数の番地を直接呼び出しのmut仮引数と同じ読み書きの事象として数える（2026-11-07 — 棄てた案: 命令 → マークの横の表〔展開のコピーでマークが落ちる〕・引数の列の頭にマークのワード〔被演算子の番号が全部ずれる〕）
- region透過の実体関数（language.md 26節 — mut引数だけが展開の理由の非再帰関数を `--passes` で実体にしたもの）: 規約はmut_defと同じ（mut仮引数は
  呼び手のセルのアドレス1ワード）で、違いは本体の入口だけ — `region.depth` を読んで退避するが `region.enter` しない。出口は退避した深度へ `region.setdepth`、
  戻りの境界コピーのfloor = 入口の深度（= 呼び手の最内region — 展開の呼び出し点の深度と同じ値）。既定の `--emit=ir|ll`（ゴールデン・Zig ≡ Soberの照合の相手）は
  展開の形のまま、`--passes` のときだけ（ELFのbuild・自己ビルド）
- 呼び出し規約はバックエンドごとに決める（ABIは揃えない — オラクルは観測等価であってバイナリ一致ではない）
  - ir_x86: 引数は全部スタック、戻りはrax、割り当て可能レジスタ10本はすべてcallee-saved
  - LLVM: 普通の関数
- 境界コピー（region多相の決定 — language.md 31節、LeanのrelocT / relocTo / regionKR）は1つの規則lower_cont.relocateTo(値, 型, floor) に集めてある
  - 対象は、ヘッダの深度がfloorより深いコンテナだけ。中身を先に再帰でコピーしてから、外側のセル列をfloorのregionの先端へ連続に積む
  - 同じ規則を使う出口: 関数の戻りと `?`（floor = 入口の深度）、inline展開のreturnと `?`（floor = 呼び出し点の深度）、式ブロックの普通の出口（floor = ブロックの入口の深度）
  - 再帰型（slice / mapの要素を通って自分を含むstruct / union — language.md 1節のD）はその場に並べると止まらないので、互いに含み合う型の組ごとに
    補助 `rt.rec_relocate#n(p, floor, 成分)` を1本生成して呼ぶ（lower/recreloc.sober）。補助は明示の作業スタックで歩き（深い木でネイティブのスタックも
    regionの深度も使わない — 中身をコピーし終えてから外側をコピーする順は、外側の後始末の項を積んでから中身の項を積むことで保つ）、コピーした先の表（元のセル列の番地 →
    コピーした番地）で共有したセル列を1回だけコピーする（immの共有は観測できない）。作業スタックと表は今の深度のregionに置く。開発用 --rt-mutant=38は表を引かない。
    lowerの分割（席A）の子は補助を組めない（型は子の外へ出ない）ので、補助が要る関数があれば拒否して直のパスで下ろす
- 最適化が使う別名の事実（ヘッダのループ昇格 — src/compiler/lower/hloop.sober・2026-10-12決定）: mutのマークのあるptr仮引数P（呼び手のヘッダのセル）は、
  次の番地の書き込みと重ならない — ①確保した番地（region.allocの結果・rt.region_alloc / region_alloc8 / slice_grow / slice_grow8の結果とそのgep —
  確保したばかりのセルは入口で既にあったPの指す先に属さない）②rtの大域・ワーカーの表（globaladdr / fsaddr）とこの関数のスロット ③P自身のデータ
  （`itop(load P[0])` からgepした番地 — sliceは自分自身を要素に含められない）。rt.slice_grow / slice_grow8はPのセルを読み書きしない（ヘッダの値を
  引数で受け、古い列のデータを読んで新しい列とrtの表を書く）。regionのop（enter / depth / setdepth / bump / alloc）はrtの状態だけを触る。
  ループの中のPのメモリの読み書きが全部 `P[k]`（kは定数）で、ほかの書き込み・呼び出しが ①〜③ と上のrtの呼び出しだけなら、P[k] をループの間
  レジスタに置いてよい（前置きで読み込み、出口の辺で書き戻す）。mut実引数の排他（language.md — 同じ呼び出しのmut実引数は重ならない）には依らない
  （ほかの仮引数を直に読み書きするループは昇格しない）
  - 同じ型の論証で、展開後の上限の巻き上げ（src/compiler/lower/rlim.sober — stdのworkの対象箇所のフェーズ2・2026-10-12決定）: rt.metaのW_SLOTS / W_SLOT_SIZEを書くのは
    rtの起動だけで、上のrtの呼び出し（slice_grow / slice_grow8・region_alloc / region_alloc8 — 書くのは新しい列とW_BUMPのワード・panic / panic_mem — 戻らない）も
    この2ワードを書かない。番地が `globaladdr @rt.meta` 直の `load [W_SLOTS | W_SLOT_SIZE]` は、ループの中の呼び出しがこれらのrtだけ（間接呼び出し・syscall・
    原子・罠・taskのop・relocate・この2ワードへのstoreが無い）ならループ不変（taskUseのスロットの先頭はワーカーの記録から来るので、gepを挟み種にならない）
  - 同じ型の論証で、展開後のフィールドの読み込みの巻き上げ（src/compiler/lower/ldhoist.sober — deflate v2のマイルストーン・2026-11-07）: 展開の後、mutのマークのあるptr仮引数Pから
    定数のgep.wordのチェーンで届くワード（展開した小関数のmut仮引数が呼び手のstructのフィールドを指す形 — Scratchやsliceのフィールドのヘッダ）のloadは、ループの中にそのワードを
    書きうるものが無ければ前置きの1本にしてよい。書かない番地の根はhdr.soberのhdrRootの一般化: メモリから読んだ番地（`itop(load …)` を経る根 — 値は
    セルの番地を持たない）・別のmut仮引数（同じ呼び出しのmut実引数は排他）・スロット・大域・確保するrtの結果。ループの中で許す呼び出しはPのセルを
    書かないrt（panic / panic_mem・matchlen / str_eq / jclean・反復の軽いenter・region_alloc / alloc8・slice_grow / grow8）で、実引数にPのチェーンを渡さないもの。
    関数の中でPのチェーンの値がメモリへの書きの値・ブロックの実引数・算術に出たらPは対象外（展開の内部の形の保険）。掛けるのは狭いワードのop
    （pool.Scratchの表のAPI）を含むループの関数だけ（全関数に掛ける形は自己buildの判定の仕事 +0.6%に対しコンパイラ自身の効き +0.06%で棄却）
  - 同じ型の論証で、コピーの転送（src/compiler/lower/cpfwd.sober — Gタスク・2026-10-12決定）: rt.str_eqは引数の指す先（文字列のワード0 / 1とそのバイト）を読むだけで、
    書かず・番地を残さない。番地Aからのワードごとのコピーで書かれたスロットSの使い道がloadとstr_eqの引数だけで、コピーから使い道までのパスにAの指す先かSを
    書きうるもの（根がほかのスロットでないstore・str_eq / panic以外の呼び出し・regionの入り / 深度の書き換え ほか）が無いなら、使い道はSでなくAを読んでよい
  - 同じ型の論証の適用先（貸出 — region-domain-pool.md 4c節の前提の1文・IOのタスクのフェーズ2 (c) 2026-10-13。**表に載せるだけ — 最適化はまだ読まない**。開くのは別の作業）:
    ioの関数の呼び出しが書きうるのは、貸出中のpoolのスロットと、その関数の戻りの値だけ。実装のrtではrt.chunk_open / chunk_next / chunk_close（と内側の
    chunk_submit・死の出口のchunk_drain）が書くのは、ストリームの記録（chunk_openが呼んだ深度のregionに取ったワード — 組の結果はrt.uring_pollも書く）・
    スロット（ワーカーのアリーナか記録と同じregionの列 — カーネルがREAD / READ_FIXEDで書く）・ワーカーのringの記録（アリーナの空きのビット）・
    戻りの値の格納場所（outのヘッダ）・W_ERRNOと、taskのチェーン（TCBのTC_CHS）だけ。chunk_next / chunk_closeは待ちでtaskを切り替えうる（rt.task_wait）が、
    ほかのtaskが書けるのはそのtaskの持ち物だけ（mutはtaskをまたいで共有できない — 11節）なので、呼び手の関数の別名の事実は変わらない

## 7. ランタイムはIRで書く

- ir_rt.zig・ir_rt_io.zig: 入口 `sober_entry(sp)`（アリーナのmmap予約・深度0）、regionのenter / alloc / relocate、行バッファの印字、mapの探索・文字列比較、io（cstr / read_file / write_file / write_all / read_args / read_dir / write_fd — 2026-09-28のioの器、language.md 28節）、`--mem-trace`（深度ごとの割り当て総量をexit時にstderrへ）
- 両バックエンドが普通の関数として下ろす
- アリーナのスロット（2026-09-28）: 大きさは実行時の値で、メタ領域のSLOT_SIZEに置く（enter / alloc / memtraceはそこから読む）。既定4GiB × 1024深度 = 4TiBのMAP_NORESERVE予約、環境変数 `SOBER_REGION_MB`（MiBの10進、1〜65536。それ以外は無視）で上書き、予約が断られたら半分にして1MiBまで再試行（language.md 27節）
- 実行可能メモリの放棄（2026-11-07）: 入口がアリーナのmadviseの直後に `prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT)` を1回（結果は見ない）。Linux 6.6+ でW+Xのページと実行の昇格を恒久に禁じ、forkの子には引き継がない（os.Runの子のJITを壊さない）。NO_INHERITを知らないカーネル（6.3〜6.5）・MDWEの無いカーネルはEINVALで何も掛からない（継承する形では掛けない）。`SOBER_MDWE=0`（起動時の環境変数）のときだけ掛けない（valgrind等の動的計装のため — 起動前にenvを操れる者は別のバイナリを走らせられるので脅威モデルは削れない）。確認のオプション = `SOBER_MDWE_REPORT`（mainの正常終了でrt.depth_reportが `mdwe <PR_GET_MDWE>` をstderrへ — 旗はW_DREPのビットDREP_MDWE）・検査 = scripts/mdwecheck.sh
- huge pageを使わない（2026-10-05、RSS回収のタスク）: 入口が予約したアリーナにmadvise(MADV_NOHUGEPAGE) を掛ける（失敗は無視）。透過的huge pageでは深度のスロットに1バイト触るだけで2 MBがRSSに乗り、小さいプログラムでも4〜6 MB・コンパイラ自身の自己buildで540 MBだった（→ 226 MB）。代価 = TLBの利得（自己buildのcycles +1.5〜3%・題材は揺れの範囲）
- sliceの幾何成長（2026-10-05、データ構造のタスク — src/compiler/lower/rtgrow.sober）: appendが先端でないときはrt.slice_grow / rt.slice_grow8（ヘッダの値を受け取り新しい列の先頭を返す）。初回の全コピーは長さちょうど（先端に戻る）・rtの側の表（rt.gcache — 直接写像64項 × [番地, 深度, 世代, 水位, 容量の終わり]）に載った列がもう一度全コピーになるとき（2本が先端を奪い合う）は余剰容量つき（2 × (長さ + 1)）。表の項の番地・深度・世代が一致しヘッダの終わり == 水位で容量に空きがあればその場で水位を進める — 同じ割り当てを共有するヘッダのうち伸ばせるのは先に伸ばした方だけ（先端の判定と同じ排他）なので値の意味論は不変（容量・水位は観測不能 — Lean無変更）。世代（rt.rgen — 深度ごと）はfullのenterとループの反復の軽いenter（rt.region_enter_lloop）が進める（関数の入口の軽いenterは自分の深度に確保しないので進めない）
- 深度の計測のオプション（2026-10-05、宛先構築レーンM5c）: 環境変数 `SOBER_DEPTH_REPORT`（1以上の10進）が立っていれば、mainの正常終了で `rt.depth_report` が `region_depth{max: d}` をstderrへ書く（d = 一度でも入った最深の深度 — 深度ごとのbumpはenter〔full・軽い〕でだけ初期化され出ても0に戻らないので、熱い経路に計測の命令を足さずに読める）。旗はメタ領域の末尾のW_DREP（入口が置く）。panic（101 / 102）の経路は書かない（102は死亡ダンプが深度を出す）。用途 = 深度の契約（language.md 27節 — 1023段）の消費の実測
- メモリの上界の実測のオプション（2026-11-04 — memレーンR1c・開発用 `--rt-mutant=39`・既定のパスに命令なし）: rtlowerがregionを捨てる点（setdepth・反復の軽いenterの呼び出し）の手前に `rt.mem_sample` を挟み、Σ_{深度1..今} (bump − スロットの先頭) の最大をメタの末尾に持つ。入口はmainを呼ぶ直前に `rt.stack_paint`（自分のスロットの下1 MiBを模様で塗る — スロットを持つ関数は展開されないので呼び手のフレームを踏まない）、mainが返った直後に最も低く書き換わったワードを数える。exit・panic 101 / 102のパスで `memhw <最大> <main の入口の Σ> <スタック（数えていない道は -1）>` をstderrへ。照合 = scripts/memcheck.sh（`--mem-report` のmain.mainのH / Sと）。棄てた案: 確保の点ごとの数え（ホットパスの全部に乗る — 捨てる直前の標本で高水位は取りこぼさない）
- 入口の引数: `_start` は初期rsp（argcの位置 — `[argc, argv…, 0, envp…, 0]`）をsober_entryの引数0として渡す（ir_x86: `mov rax, rsp; and rsp, -16; sub rsp, 8; push rax; call`、LLVM: `movq %rsp, %rdi` の後に整列してcall）。環境変数を読むのと、argvの格納場所としてメタ領域のW_ARGV（末尾に足した1ワード — 既存のワードの番地は動かさない）に保存するのに使う（rt.read_argsが読む）。引数を宣言しないsober_entry（テストのIRテキスト）は読まないだけで動く
- 終了コード（2026-09-28）: `func main() int` なら入口が戻り値を受け、0〜255の外はexit 101、内なら `syscall(231, code)`（exit_group）。後ろは到達しない定数のexit 0 — IRのexit終端子は定数codeのままで、opは増やしていない（language.md 27節）
- errnoのワードはワーカーごと（2026-10-14 — net 4b・fc93eee5）: rtの中でtaskが待つ関数（ringの読み取り・netの受け等）は、待ちの後でerrnoのワードを置き直す — 待つ間に同じワーカーの他のtaskが書く
- 手書きの本体への置き換え（最適化のバックエンドだけ — rt.copy8〔d-3〕とrt.matchlen〔SIMDの核 フェーズ1 — 2026-10-25〕・rt.jclean〔フェーズ2 — 2026-10-26〕）: IRの本体が意味の正で、x86の最適化のバックエンド
  （x86.soberのxCopy8Body / xMatchLenBody）は同じ意味の手書きの本体を吐き、呼び出しを「作業用のレジスタだけを壊すcall」として扱う（xIsCallOpの外 — 割り当ての組を
  壊さない）。約束は3つ: ① 意味はIRの本体と同じ（optdiff・elfeqが照合）② **壊すのはrax / rcx / rdx / xmm0 / xmm1 / フラグだけ**（rsi / rdiが要るパスは積んで戻す・
  r11は割り当てに使う関数がある〔xUsesR11〕ので触らない・xmm2以上はfloatの割り当ての組〔scanbを含まない関数の広い組〕なので触らない）③ rtを呼ばない・syscallなし
  （taskの切替・罠を跨がない）。rt.matchlen(p, q, n) はp[0:n] とq[0:n] の一致の長さ — **区間の外を読まない**（16バイトのチャンクは区間の中だけ・端数は区間の終わりに
  揃えた重ねた読み込み〔n ≥ 16のときだけ — 重なった分は比べ済みで等しい〕・n < 16は8バイト / 1バイト）。開発用 --rt-mutant=13 / 14が手書きの本体の2つの誤り
  （食い違いの位置 +1・端数の重ねた読み込みの省略）を入れる — testdata/matchlenとoptdiffのテストが鳴ることの確認用
  rt.jclean(p, n) はp[0:n] の中で最初にJSONのエスケープが要るバイト（`"`・`\`・0x20未満）の位置かn — 区間の外を読まない（n ≥ 16は16バイトずつ +
  終わりに揃えた重ねた読み込み・8〜15は始めと終わりの8バイト〔movq × 2〕・4〜7は始めと終わりの4バイト〔movd × 2〕・3以下は1バイトずつ）。--rt-mutant=25 / 26 / 27
  （`\` の判定の省略・端数の重ねた読み込みの省略・8〜15の後ろのワードの位置の誤り）— testdata/jclean（scripts/jcleancheck.sh）が鳴ることの確認用
- 手書きのSIMDのコード（scanb・UTF-8の検査器・数え上げ・crcfold — x86.soberのxScanB / xUtf8Pre / xCountB / xCrcFold）のウィンドウの検査（2026-11-12）: 開発用
  `sober build --vec-check`（= --rt-mutant=56）は16バイトずつの読み込みのたびに、ウィンドウが列の内側（[p + 0, p + 上限) かcrcfoldの [p, p + 残り)）にあることを確認し、
  外ならexit 103で止まる（既定のbuildには何も足さない）。57 / 58 = 検査 + scanb / UTF-8の検査器の端数のウィンドウを1後ろ・59 = 検査 + scanbの入口の符号の検査を外す —
  scripts/vecchk.shがテストの例をこの形で走らせる。列の直後1バイトの範囲外の読み込みは出力を変えないことがあり、ページの端に列を置く手段も無い（アリーナの深度のスロットは
  隣のスロットに接する・stdにmmapが無い・valgrindはアリーナの中を丸ごと読める領域と見る）ので、範囲はSIMDの本体の側で確認する
- ランタイムはZig版とSober版（src/compiler/lower/rt.sober — ir_rt / ir_rt_ioの移植。同じ命令列を同じ順で組む）の二重化。IRテキスト / .llゴールデンとのバイト一致が見張る（selfhost_lower / selfhost_ll）
- 棄てた案: .llの手書きプレリュード（LLVM専用になる）、Zig製オブジェクトのリンク（実装言語が増える）

## 8. LLVMへの対応（開発時専用の経路）

- soberは .llのテキストを吐くだけ（`sober build --emit=ll`）。子プロセスは起動しない
- 下ろすのは `zig cc -target x86_64-linux-none -nostdlib -static`（Zig同梱のLLVM — clangは立てない。新しい依存はゼロで、ツールチェーンはbuildと同じzig 1本）。呼ぶのはscriptsとテストだけ
- 対応:
  - i64 / ptrはそのまま
  - スロットは入口でゼロ初期化した `alloca [n x i64]`（未初期化の読み出しのpoisonを塞ぐ — mem2regの「定義前の読み出しは0」もこれに依存する）
  - アグリゲートはfirst-classにしない（gep i64）
  - nsw / nuwを付けない
  - `unreachable` はexit syscallの直後だけに置く
  - mustprogressを付けない（無限ループをUBにしない）
  - 全関数にno-builtinsを付ける
  - エントリはmodule asmの `_start`
- -O0 / -O2の2列をUB検出器にする: 同じ .llを両方のレベルで下ろして観測等価を照合する。食い違えばUB漏れの兆候。LLVM自身をタダのUB検出器として使う形

## 9. 観測の列（scripts/obs.sh）

| 列 | 経路 | 食い違いが示すもの |
|---|---|---|
| default | `sober build`（IRパス + ir_x86） | 期待値 `.out` からのずれ |
| ir-x86raw | `--no-opt` | IRパス（mem2reg）か割り当て器のバグ |
| sober | `--no-opt`（ir-x86rawと同じ形 — B-1dの名残の綴り）。scripts/elfeq.shがstage1とのELFのバイト一致（3形）と合わせて回す | 移植のずれ（バイト一致が先に鳴る — 観測が同じでも割り当ての違いを拾う） |
| stage1 | `--via=stage1`（凍結したZigの正規バックエンド — B-4までの既定） | 代替経路（新しいIR opをSober側が拒否したとき等） |
| llvm / llvm2 | `--emit=ll` → `zig cc -O0 / -O2` | 正規バックエンドのバグ / UB漏れ |
| opt / opt2 | `--emit=ll --opt` | IRパスのバグ |
| [ReleaseSafe] default | ReleaseSafeでビルドしたコンパイラ | Debugでは偶然読めてしまう死んだスタックの読み出し（B-9bでmem2regのUseIterに実発） |

- IRを目で見る手段（3つは別の形 — 取り違えると読み違える。report-497）: `build --emit=ir --passes` = 設計整合パス + optimizeSsaまで（展開・cfgclean・展開後のSROA + mem2reg〔B2〕の前）・
  `build --emit=elf --passes --stop-after=inline --dump-ir` = x86の直前（B2の後 — 割り当て器が見るIR）・`--emit` なしの `--stop-after=… --dump-ir` は .llの経路（最適化のバックエンドの経路を通らない）
- SROAは2回走り、形が違う（2026-10-11格納場所の往復レーンのフェーズ3）: 展開後のSROA（B2）だけが `gep.word スロット, 定数` 越しのload / storeをワード 定数 + kの読み書きとして透かす
  （値渡しのstructの入口の丸ごとのコピー〔std/jsonのDoc 21ワード〕を仮引数へ持ち上げる）。最初のSROA（optimizeSsa）は透かさない — elfeqがstage1とバイトで照合するpasses形だから。
  `--emit=ir --passes` には透かした形は出ない（B2の前の出力点）
- 移行期間にはdirect（AST直吐き）列があり、独立な2フロントエンドの差分でバグを拾っていた（inlineのreturn深度など）
- 退役でこのオラクルは失った。代わりの守りは次のとおり:
  - 新しい例の `.out` は手で導出する（実行結果を貼らない）
  - 拒否の表src/stage1/diag_cases.zigをlowerとcheckの両方に通す（`check_ok` = checkが受理する既知の差）
  - IR列同士の差分とReleaseSafe列

## 9.5 正規バックエンドのSober化（B-1〜B-5 — 2026-10-02〜）

- src/compiler/lower/x86.sober（命令選択・linear scan・生存区間・cfg）・src/compiler/x86（エンコーダ）・src/compiler/elf（ELF — @layout）はsrc/ir_x86*.zig・ir_live.zig・ir_cfg.zig・arch/x86_64.zig・format/elf.zigの移植。
  正しさの根拠はstage1が同じIRテキストからビルドしたELFとのバイト一致（scripts/elfeq.sh）と、エンコーダのGNU asとの全行列の照合（scripts/x86enc.sh）
- 移植の規律の逸脱1点: 生存解析。Zig版は「ブロック数 × 値の数」のビット集合でlive-in / live-outの不動点を反復するが、Sober版は上向きに露出した使用
  （定義のブロックの外の使用）から前任へ辿る経路探索（SSAのpath exploration）。到達するブロックのlive-in / live-outは最小不動点と一致するので区間は同じ —
  elfeqのバイト一致（src/compiler/app自身の47.6 MBを含む）がそれを示す。メモリは使用の総数に比例し、stage1が巨大な関数で踏む爆発（src/compiler/appの
  `build x.ir --no-opt` が589 s / 29 GB — Sober版は31.5 s / 1.6 GB）を構造的に持たない

- B-4（2026-10-02）: `bin/sober build` の既定がSoberの正規バックエンド（stage2の `--emit=elf --passes` — 設計整合パス + mem2reg）。default / ir-x86rawの列・hermetic（stage2のELFも比べる）・io_args・gatesの道具はSober正規でビルドできる。
  実行のbitはstage2が付ける（std/os.WriteMode — language.md 28節）。`sober test` のランナーもテストのビルドをSoberの正規バックエンドでin-processにビルドする（stage1の呼び出しは無い）
- B-5（2026-10-02）: stagesの固定点をバイナリ一致へ昇格（上の10節・design-dev.md最終オラクル項）。続けてstage2自身も最後のbootの `--emit=elf` でビルドする（scripts/stage2.sh —
  .ll → zig ccはSOBER_O1の列と、正規バックエンドを持たないブートストラップチェーンの古いステージだけ）
- B-3: mem2reg（src/compiler/lower/m2r.sober — ir_mem2reg.zigの移植）と検証器（src/compiler/lower/verify.sober — ir_verify.zigの移植）。経路は
  build → [設計整合パス] → mem2reg → rtlower → 正規バックエンド、各段階の後に検証（違反は内部エラー）。mem2regの支配境界と置いた引数の表は数えてから詰めて
  持つ（CSR）が、ブロックに置く引数の並び（スロットの通し番号の順）と詰め直しの番号はZig版と同じ — elfeqの3形（IRパスなし・mem2reg・設計整合パス + mem2reg）が見る。
  検証器は値の型を記録から導く（SoberのIRは値の型の表を持たない）ので、結果の型の検査はZig版より弱い。
  設計整合パスのP4（空ブロックの短絡）は出口でその関数の前任数（B_PREDS）を辺から数え直す — 各段階の後のIRが正しい（3つの経路Elf / Ir / Llで揃う）。
  棄てた案: パスの後にモジュール全体で数え直す（2026-10-02まで — P4の後のIRが一時的に不整合）・付け替えごとに増減で保つ（誤りやすく、読む者がいない）

## 10. 実装の現在地（2026-10-02）

- 正規バックエンドのSober化done（B-1〜B-5 — 9.5節）: `sober build` の既定はSoberの正規バックエンド。固定点はバイナリ一致（stage3のELF ≡ stage4のELF + stage1との交差照合 —
  design-dev.md最終オラクル項）。凍結したZigの正規バックエンドは `--via=stage1` と照合（elfeq・stagesの交差照合）の役

### 2026-09-27の時点

- B-1〜B-10 + region多相の還流（R0〜R5・K1''）までdone。全例（obs 63本）が全列で一致する
- 正規バックエンドの最初の効果: direct比で約2倍速（design-dev.md「バックエンド戦略」の条件つきの数字）
- コンパイル速度の最初の値: ReleaseFastのコンパイラでobsの60例を0.20s（1例あたり約3ms。比較相手はまだ無い）
