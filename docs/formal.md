# Soberの形式化（Featherweight Sober）

定理証明系（Lean 4）でSoberのコンパイラ層の健全性を機械検証する計画。
design-dev.md「層の線引き」のうち コンパイラ層（健全必須）だけが対象。analyzer層は設計上best effortなので対象外、パーサー・codegenの正しさも対象外（CompCert級の別仕事）。

## なぜSoberは題材として都合がよいか

- 証明すべき場所が層分けで既に切り出されている。証明対象を選ぶ議論が要らない
- 寿命がスコープの木に一致する。Rust（RustBelt）の困難は借用の任意グラフから来ており、Soberはそれを構成的に持たない。証明のサイズが桁違いに小さいはず
- 主張が少数で新規性がある。下記3定理
- 仕様ドリフトの検出器になる。設計変更（例: escapeの自動化）で証明が壊れ、壊れた箇所が「この規則を変えると何が言えなくなるか」を教える。sqlshapeのPG、analyzer-platformのオラクルと同じ位置にproverを置く
- LLM協働の形が合う。人間は定理の言明（何を保証したいか）と設計の決定だけ、証明の穴埋めはLLM。「境界の宣言と決定だけ人間」の作法そのまま

## 証明したい3定理

1. 領域安全（memory safety） — 親regionの値は子regionの値を参照しない（escape規則）+ スコープ終了で子regionを一括解放、のもとで、well-typedなプログラムは解放済みregionへのderefに到達しない
2. データ競合自由（data race freedom） — 並列スコープに渡せるのは不変値かチャネルのみ、mutな値は単一スコープが所有、のもとで、2つの並列タスクが同じ場所に対して少なくとも一方が書き込みとなるアクセスを同時に行わない
3. 型健全性（progress + preservation） — `T?` のflow typing、sum type（`union`）のswitch網羅、多値の分解点規則を含む型付けが、評価で壊れない。特に「`nil` は `T?` にしか住めない」が保たれる

段階6の計画（2026-10-05）: 定理2を ① DRF（今の段階3b〜3dの中身 — コピー意味論 + 共有プレフィクスの不変 — を言明の形に整える）と ② スケジュール非依存（Kahn — チャネルの端点を単一所有にしたSPSCのもとで、異なるtaskの1歩ずつがKを触っても可換なone-step diamondから合流性へ。デッドロックの有無まで決定的）の2本に分ける。今の `chan` はMPMCなので ② は偽で、端点2型の導入が前提（language.md 11節「チャネル」）。

段階6 P1の完了（2026-10-05 — 切れ目 ①②）: コアにtaskの木を入れた。
- 型: `Ty.own (k : scope | task | tx | rx) (r : Nat) (t : Ty)` — 単一taskが所有する能力（家のregion r・mutFreeでない = 捕獲できない・chanFreeでない = コピーできない・部分型は不変）。型環境 Ξ は構造体 {ch（旧chan）・ep（端点）— 全task共有、tk（自分の子の (scopeのregion, 結果型)）— 世界ごと}
- 式: `scope t e`（regionを1つ開き、本体はvar 0 = 札 `scopeV d`・ラベルを越えない・出口はblockRと同じコピー）・`spawn sc a e`（札・子へ渡す値a〔mutFree・chanなし・scopeのregion以下 — give: の受け渡しのデータ版 = コピーする〕・閉じた子の本体e〔文脈 [ta]〕。結果はloc-free・chanなし）・`join h`・`tryJ t h`（完了 = some v・死 = nil — 死を吸収しない）・実行時の `taskV rs n`
- 機械: `State.fam id o n main kids`（StateとKidsの相互帰納 — stepは構造的再帰のまま）。id = 親のid ++ [子の番号]（決定的）・o = 親から引き継いだ子の表の長さ（子iのhandle = o + i）・n = 局所の通し番号。mainのspawn / join / try / scopeの出口はfamが子の表を見て扱い（famMain）、それ以外はmain自身の歩。scopeの出口は「そのscopeの子が全部 完了 か 死」を待ち、死があれば親が死ぬ。死んだtaskの子孫は走り切る（打ち切らない）。taskの外（旧loadの根・旧parの子）でのspawn / join / tryは到達しない形としてpanicで閉じる
- 定理: preservation（結論に「葉の歩は自分の子の表tkを変えない」を足した）・progress（葉）・progressT（task込みの四択 = 完了・panicの葉・待機〔Blockedにtaskの待ち6形〕・次の1歩）・soundnessT（根のtask `loadT` から）・step_shared_stable（task込み）。補助: step_isFam（葉の歩は葉のまま）・value_world（mutFreeな値は世界ごとの部分に依らない）・reloc_exit（regionKRとscopeの出口の共通部）。公理はpropext・Quot.soundのみ（soundnessT・soundness・step_shared_stable・typecheck_sound / complete）
- P1の制限（後続のタスク）: Defの本体に並列の構成子を置かない（noNewchan）・結果と渡す値はloc-free / mutFree（子のregionで作った値を返す・送るにはheapをまたぐコピーが要る）
- Defの本体の解禁（2026-10-06 — P3a）: noNewchanをscope / spawn / join / tryについて子の論理和に（newchan / 実行時の値はfalseのまま。newchもP3b-2で解禁 — 家のregion rはshiftTy / renTy / rmapで既にずらされていて〔見立ての「相対化」は不要だった〕、型規則にfの制約が無いのでf_lowerに1つの分岐を足しただけで閉じた。ExamplesのchDefΔ）。f_lowerに4分岐を足しただけでpreservation（callK / callMKの分岐を含む）・soundnessT・Kahn・typecheckのsound / completeはそのまま通った — 4構成子の型規則はfを使わないので、Shift / TSubst / Renのsrcの分岐（P1で書き済み）と合わせて写像の補題が全部揃っていた。taskの外（旧loadの根）から呼ぶとspawnは定義されたpanic（ExamplesのparDefΔ）

段階6 P1切れ目 ③（2026-10-05 — 端点のチャネル）: `newch r cap t`（送り端と受け端の組 `prod (own tx r t) (own rx r t)`・家のregion rはこの世界のもの・容量 ≥ 1・ペイロードはloc-freeでchanなし〔P1 — キューの値は空の世界で型が付く〕）・実行時の端点 `epV p k tx r`（鍵 (p, k) = 生成元のtask id + 局所の通し番号・型付けはmutのlocと同じb ≤ r < d — 子の世界では型が付かないので実行時の捕獲も構造で閉じる）・send / recvの端点版。機械のKは構造体 {leg（旧chan）・ep（鍵 → {q, cap, otx, orx}）}— otx / orx = 持ち主のtask id（決定A = β）。spawnの渡す値は `givable`（端点〔移す〕・コピーできるデータ・その組）で、giveVが持ち主を子へ書き換え家を子のregionへ付け替える（持ち主でなければpanic — 失効した別名）。満杯のsend・空のrecvは待機（Blocked famSnd / famRcv）。preservation / progressT / soundnessT / step_shared_stableを端点込みで更新（補題giveV_ok・chanOk_epNew / epSet・value_toEmpty / fromEmpty）。反証探索 = 乱択の反例探索spscfuzz（MPMCの48本の反例の形をSPSCで掛け直し — 3 seed × 2,000本で不一致0）

段階6 P1切れ目 ④a（2026-10-06 — Kahnの下ごしらえ）: famMainがtaskのmainの旧構成子のredex（`eval (par …)`・`eval (parch …)`・`eval (newchan …)`・旧chanのsend / recv）を横取りして定義されたpanicにする（相談D = (a)）— taskの外のspawn / join / tryをpanicで閉じる柵の鏡像。Blocked.famMはmainの旧recvの待ちを除く（横取りで1歩進むので）。Leaf.lean: 旧構成子のredexでない葉（eval / ret / panic）の1歩は π を見ずKを読まず変えず、結果も葉 — `step Δ π' s K2 = (step Δ π s K).map (fun p => (p.1.fixLeaf, K2))` の1本の等式に畳み、stepの分岐の全数の場合分け（frameごとの定理に分けて並列elaborate — 約2分）で示す

段階6 P1切れ目 ④（2026-10-06 — Kahn.lean・定理2の ②）: taskの木の機械は合流的 — 整形された木（`TaskOk`: mainは葉・子jのid = 親のid ++ [j]）の2つの1歩は、同じ結果か1歩ずつで合流する（`kahn_diamond`）。ここから `kahn`（正規形vにn歩で着く実行があれば、どのk歩の実行もk ≤ nでn − k歩で同じvへ）・`kahn_unique`（正規形と歩数の一意性）・`kahn_schedule`（loadTの全プログラム: 止まった2つのスケジュールの最終状態は一致 — 完了の値・panic・待機〔デッドロック〕の区別まで決定的）・`kahn_schedule_bounded`（どれかのスケジュールで止まれば全スケジュールが同じ上界で止まる）。型付けは使わない機械の性質で、前提は旧par / 旧chanの横取り（④a）だけ。骨格: Kのエフェクトを操作Opに分け独立な操作の可換性（`op_comm` — 持ち主の札が違えば片方は失敗、送りと受けはqの両端）→ famMain = 操作 + Kに依らない続き（`famMain_spec`）→ 部分木の1歩の分解と再生（`step_dec`）→ 子の1歩の下でのmainの続きの安定性（`mainCont_set` — join / try / scopeの出口が読む子の決着は動かない）→ 木の帰納。DRFの系 = kahn_diamondそのもの（違うtaskの1歩はチャネルに触れても可換 — par_step_commute〔Kを変えない歩だけ〕のSPSC版）。公理はpropext / Quot.soundのみ。反証探索 = 乱択の反例探索diamondfuzz（約4.6万対で不一致0・対照の旧MPMCは196件の不一致）

段階6 P3a A1 (X) — 死を値にするscope（2026-10-06・決定 = language.md 11節「死の扱いの3通り」）: `scope t e` の型を `union t unit` に。出口で子が全部決着し死がいれば最内のregionをpopして `inr t triv`（コピーしない）・死が無ければblockRと同じコピーの後 `inl unit v'`（taskの外の出口も `inl`）。joinが死んだ子を見たら親が死ぬ（不変 — Join = 「この子の死は私の死」）・tryはnil（不変）。死を値にしたscopeの後もmainは完走しうるので、完了形を `kidsDone` = 子が全部 完了 か 死んで静止（`deadDone` = mainがpanicで子孫も全部決着 — キャンセルなしなので死んだtaskの子孫は走り切ってから静止）に広げた。補題: `dead_exit`（死の出口のpopの型付け）・`reloc_exit` を下のスタックの型について一般化・`famMain_panic` / `deadDone_false_of_step` / `step_deadDone_none`（静止は1歩も踏めない — 完了形と同じ）。preservation / progressT / soundnessT / step_shared_stable / Kahn（kahn_diamond・kahn_scheduleほか）は証明の構造を変えずに通った。抽出: TcStepのscopeの分岐を `kScope`（kBlockRの結果を `union t unit` に）へ・tc_genの差分はkScopeの1関数と呼び出し1行。Genはscopeを `case (scope t e) (var 0) (unreach t)` でtへ戻す（乱数を消費しない包み）・corevecのゴールデンは再生成。反証探索 = 乱択の反例探索diamondfuzz（2 seed × 400本・約5.2万対で不一致0）・spscfuzz（3 seed × 2,000本で不一致0）。公理はpropext / Quot.soundのみ

段階6 P3b-4 — taskの結果の境界コピー（2026-10-06 — 決定 = language.md 11節P3b ⑦「regionを持つ結果の境界コピーのLeanのタスクを先に」）: spawnの結果の条件をloc-freeからimm（mutFree）でchanなしへ緩めた。handleの型 = `own task rs (t.relocR rs)`（子の結果型のimmのregionを全部scopeのregion rsへ）。joinに結果型の注釈 `join t h`（tryJと同じ形 — コピーするときに歩く型）。機械: 子のtaskの底を `taskK`（値が戻ったらそこで止まる — 自前のregionをpopしない。StackTy.taskKは共有境界 ≥ 1の世界だけ — 根はtaskKで止まらない `not_taskK_root`）・完了形にヒープを添えた `taskRes`（taskDoneのコピー）・join / tryは `xfer rs t Hk H v`（子のヒープHkの値を型tに沿って歩き、immのコンテナをregionに依らず全部、親のヒープHのregion rsの末尾へ中身ごと割り当て直す — relocToの2ヒープ版。共有のregion〔親のコピー〕を指す値もコピーする — immなので観測は同じで、実装はコピーせずに済ませてよい）。型付けの不変: famの子iは自分の結果型 `tcs i`（imm・chanなし）で型付き、子の表の型 = `(tcs i).relocR rs`。補題: `xfer_ok`（コピーの保存 — relocTo_okの2ヒープ版: コピーする元は子のHeapOkだけを読み、コピーする先はregion rsだけがlookup保存で伸びる〔RelocJ〕・値はtake (rs + 1) の世界で型付く。値の葉は空の世界を経由して Ξ を付け替える〔value_export / value_anyΞ / value_import〕）・`xfer_join`・`taskRes_typed`・`join_xfer_some`（progress — 型付きならコピーは失敗しない・共有プレフィクスは不変）・型の補題 `Ty.relocR_{mutFree,chanFree,regionsBelow}_of`・`Ty.relocR_mono_mf`・`Ty.relocR_sub_*`・`Ty.renR_relocR_mf`（shift / ren / tsubstのspawnの分岐）。Kahn.leanは言明・証明の構造とも無変更（join / tryのコピーは親の局所の歩 — mainContのjoin / tryの分岐をtaskRes + xferにし、mainCont_setにtaskDone → taskResの2行を足しただけ）。公理はpropext / Quot.soundのみ

段階6 P3b-4b — チャネルのペイロードの境界コピー（2026-10-06）: ペイロードの条件をloc-freeからimm・chanなしへ（newchは加えて注釈が今の世界で整形 `t.regionsBelow d`）。端点の型のペイロードのregionは意味を持たない — 型の表 Ξ.epはregionを全部0へクランプした形（`t.relocR 0`）を持ち、epTx / epRxはそれと引く。sendE = 送る値の型teとペイロード型tがregionを除いて一致（`Ty.payOk` — どちらもimm・chanなしでrelocR 0が等しい）・recvEの型 = `t.relocR (d - 1)`（受けた値は今の最内のregionへ）。機械: 項目EpEntにペイロード型（注釈のrelocR 0）を持たせ、キューの要素を 梱包 `Pkt`（値・1 regionの小さなヒープのセル列・歩いた型）に。send = `packV`（`xfer 0` で送り手のヒープから小さなヒープへ）・recv = 梱包を `xfer (H.length - 1)` で受け手の最内へ。どちらも失敗はnone（型付きなら起きない — progressがpack_ok / unpack_okで示す）。ChanOk.eptyped = 型はrelocR 0で不動・imm・chanなし・項目の型と一致・待機中の梱包は `PktOk`（小さなヒープが共有境界0・空の型環境で型付き、値は深さ1で型付く）。補題: `pack_ok`・`unpack_ok`・`xfer_take`（コピーはregion kより下に触れない — 共有プレフィクスの不変の受けの分岐）・`Ty.payOk_renR` ほか。Kahn.leanは言明・証明の骨格とも無変更（Op.runの結果を梱包Pktに・sendは送り手のヒープを運びpackV・recvの展開はmainCont〔Kに依らない続き〕へ — 葉の局所の歩）。公理propext / Quot.soundのみ。反証探索 = 乱択の反例探索strchanfuzz（spscfuzzのstring版 — 3 seed × 1,500本・不一致0）

段階6 P3b-4 ③ — closeと `T?` の受け（2026-10-06 — 決定 = language.md 11節P3bの仮採用 ③「Close / `T?` nil / for-Recvはコア拡張 — P3b-4のLeanのタスクに同梱」）: 式 `close c`（`c : own tx r t` → unit）を足し、recvEの型を `.opt (t.relocR (d - 1))` に（表層のRecvは最初から `T?` — 脱糖は `some (recv c)` をやめて `recv c` をそのまま出す）。機械: 項目EpEntに `closed : Bool`・フレーム `closeK`。close = 持ち主で開いていれば `closed := true`・それ以外（持ち主違い・二度目）は定義されたpanic。send = 持ち主の確認の後、閉じていればpanic・梱包は `some v` を型 `.opt ent.ty` で（キューの要素は `T?` の値 — 受けは一様にxferでコピーして `some v'`）。recv = キューが空で閉じていれば `nil (ent.ty.relocR (H.length - 1))`（何度受けてもnil・Kは不変）・空で開いていれば待つ。taskの外のcloseKはpanic（recvKと同じ柵）。型付けの不変: ChanOk.eptypedの待機中の梱包は `PktOk Δ (.opt t) w`・BlockedのfamSnd / famRcvに `ent.closed = false`（閉じた送りは待たずに死ぬ・閉じて空の受けは待たない）。補題: `pack_ok_opt`（pack_okを `.opt` / `some v` で呼ぶだけ — payOkはoptで保たれる）。unpack_okは `.opt t0` で呼ぶ（relocRはoptと可換）。Kahn.leanは言明・骨格とも無変更（Op / Miniにcloseの操作・sendのclosed検査・recvの閉じた空 = 空の小さなヒープの梱包 `⟨nil ty, [], .opt ty⟩` を返しmainContのxferがnilへコピーする — famMainと一致・mainOp / mainContにcloseKの分岐。closeは同じ鍵の送りと同じ持ち主の操作なので、閉じた後の送りの有無はプログラム順で決まり、閉じて空の受けは閉じる前の送りが全部キューに入った後でしか起きない — 1鍵の可換の議論〔Mini.f〕に乗る）。公理propext / Quot.soundのみ・sorryなし。反証探索 = 乱択の反例探索closefuzz（strchanfuzzにcloseとnilの受けを混ぜた版 — 3 seed × 1,500本・不一致0。規律の逸脱: 証明の後に回した）。for-Recv（`for l <- task.Recv(rx) { … }`）はコアに足さない — loaderが生成元の呼び先をstd/taskの `RecvAll(rx, k)`（普通のSoberのwhile + ifnil — 呼び出し形の生成元）へ付け替える

段階6 P3b-4 1b' — errorを返すtask・未回収の失敗の集約（2026-10-06 — 決定 = p3b-draft揉みどころ7 + 決定 (A)〔コアでは全taskをfallibleに一様化〕）: 式 `scope t ε e`（ε = errの型の注釈）・札 `scopeV rs ε : own scope rs ε`。scopeの型 = `union t (union unit (ε.relocR (d - 1)))`（inr (inl triv) = 子の死・inr (inr e) = 未回収の失敗）・前提に ε はimm・chanなし・b < d（失敗のerrをコピーする親の最内d - 1が共有境界より上 — taskの本体と関数の本体は常に満たす。根のscopeはblockの中に置く）。spawnの本体の型は常に組 `prod t (opt ε0)`・`Ty.payOk ε0 ε`（札の ε とregionを除いて一致）。機械: 子の表Kidsの各子に札 `(ε.relocR 0, 回収済み)`（spawnが札の値scopeVの ε から立てる・join / tryが結果を受けたら `Kids.mark` で回収済みに — 親のプログラム順だけで決まる）。scopeの出口: 子が全部決着したら、死があれば死・無ければ `Kids.failAt`（生んだ順で最初の「region rsの子・未回収・結果 = pair v (some e)」）のerrを子のヒープから親の最内へ `xfer (H.length - 2) (ε.relocR …)` でコピーしてpop。札のerrの型が注釈と食い違えば定義されたpanic（型付きなら起きない — preservationはpanicで閉じるので、札とframeを結ぶ大域の不変条件を足さずに済む）。型付けの不変: famに `∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = prod t (opt ε0) ∧ ε0.relocR 0 = tg.1`。補題: `fail_exit`（reloc_exitのxfer版）・`Kids.failAt_spec` / `failAt_typed`・`famTy_rebase_mark`・Kidsのmark / tag? の補題（Fam）。Kahn.leanは言明・骨格とも無変更（mainContのjoin / tryが `ks.mark`・scopeの出口にfailAtの分岐・`Kids.failAt_set`〔歩ける子の置き換えの下で決着したscopeのfailAtは不変〕・`KidsOk.mark`）。公理propext / Quot.soundのみ・sorryなし。反証探索 = 乱択の反例探索failfuzz（子は送ってから成功 / 失敗 / 死を乱択・親はJoin / Try / 放置を乱択 — 3 seed × 1,500本・不一致0・ok / died / failed / deadが全部出る — 言明の前に実施）

段階6 P4 — 約束の範囲とstdoutの順（非形式・2026-10-06）: コア（LeanのMachine）にprintlnは無く、kahn_scheduleが約束するのはscopeの値・panic・デッドロックの有無まで（言明は無変更）。stdoutの順は実装の約束でコアの外: P4の実装は出力をspawnの木の先行順で合流させる（language.md 11節P4 (O1)）ので、stdoutもスケジュール・ワーカー数に依らない — これは定理でなく実装の検査（seq ≡ parのバイト一致・schedfuzz）が見る。同じくscopeのerrの死因（ChildDiedのcause — コアのdiedはunitでcauseは実行時の値）・未回収の失敗の選び方は正準順（spawnの順で最小）を実装が守る（コアのfailAtは元から生んだ順で最初 — 実装をそれに揃える）。キャンセルはコアに無い（死んだtaskの子孫も走り切る意味論のまま — 実装の打ち切りはscopeの値を変えない最適化）。物理共有・原子のop（ir.md 4.7）の正しさ = rtの点の列がコアの1歩を原子的に実現していること — 模倣定理はE4（Machine参照実行器）で扱うものとして保留し、P4はseq ≡ par + schedfuzz（+ ミューテーションの自己検査）で見る

Handleは動的検査なので定理1の対象外。Handleについての主張は「`get(h)` はUBではなく `nil` を返す」で、これはランタイムの世代比較の正しさとして別に小さく述べる。

## Featherweight Soberの範囲

小さく始める。最初の体系に入れるもの:

| 構文 | 役割 |
|---|---|
| ブロック `{ e }` | regionの生成と解放。値を持つ（式） |
| `x := e; e` | 束縛（const） |
| `alloc e` | 現在のregionへの割り当て。参照を返す |
| `!r` / `r := e`（mut参照のみ） | deref / 書き込み |
| `if` / `switch` on 2バリアントunion | 分岐の式化と網羅 |
| `T?` と `nil`、flow typing | 定理3 |
| `parallel { spawn e; spawn e }` | 定理2。タスクはスコープ終了でjoin |
| チャネル `send` / `recv` | 並列スコープをまたぐ唯一の可変通信 |

入れないもの（後回し）: 関数と再帰（まず一階で。ラムダ・inlineラムダ・非局所returnは第2段階）、多値、`|>`（脱糖で消える）、コルーチンと中断（意味論が膨らむ。structured concurrencyのjoinはspawnの同期的完了として先にモデル化）、PoolとHandle（stdなので体系外）、エフェクト・エラーラベル（analyzer層）。

意味論はsmall-step。ヒープはregionの木（region id → 割り当て集合、親id）。ブロック終了でregionとその子孫を除去。参照は (region id, location) の組で、型は割り当てregionを持つ `Ref ρ T`。

### 段階1の断片（2026-09-18着手。`lean/`）

定理3だけを対象にした最初の体系。region・parallel・チャネルは段階2以降で足す。Phase 1で意味論が固まった構文のうち、regionに触れないものを入れた。

| Sober | コア（`lean/FeatherweightSober/Syntax.lean`） | 脱糖（Zig側の仕事） |
|---|---|---|
| `x := e; body`、ブロック `{ ... }` | `letE e body`（de Bruijn。bodyでxは `var 0`） | ブロックはletのチェーン。文位置の値なし式は無い |
| `if c { a } else { b }` | `ite c a b` | `else` 無しは段階1に無い（値を持たないブロックが要る） |
| `T?`、`nil`、`if v != nil { .. } else { .. }` | `opt t`、`nil t`、`ifnil e nilCase someCase`（someCaseで中身が `var 0`） | flow typingは `ifnil` への脱糖で表す。`nil` の型注釈は双方向推論が埋める |
| 2バリアント `union`、`switch` の型パターン | `union l r`、`inl r e` / `inr l e`、`case e l r`（各分岐で中身が `var 0`） | variant名と多フィールドは名前 → 位置、struct → 段階2で足す。網羅は `case` が両方の分岐必須で表す |
| `int`、`bool`、`+`、`<` | `lit`、`tt` / `ff`、`add`、`lt` | 他の演算子は同型なので省く |

入れなかったもの: 関数（一階から。ラムダ・展開・非局所returnは段階2）、struct（フィールドは段階2でunionと一緒にn項化）、多値、`|>`（脱糖で消える）、`defer`（regionと一緒。出口で式を評価する意味論はregion解放と同じ場所に置く）、`while` / `mut`（ストアが要る。段階2の参照と一緒）。

進め方: 構文・型付け・small-stepを書き、`Examples.lean` に手で項を置いて `lake build` を通す（型付け例は明示の項、実行例は `Steps`）。次にprogress / preservation。置換補題（`subst` と `shift` の型保存）が最初の壁になる。

結果（2026-09-18）: 型健全性（progress + preservation + soundness）が通った。sorryなし。置換補題は文脈 `Γ₁ ++ Γ₂` 分割の一般形、帰納は導出でなく式に対して（型付けが構文主導でinversionが一意なので、文脈をindexに持つ述語の帰納を避けられる）。

### 段階2aの断片（region、immutable参照のみ。2026-09-18着手）

定理1の最初の形。段階1に `block`（region境界）/ `alloc` / `deref` と実行時形 `loc r a`（regionレベルr、アドレスa）、型 `ref r t` を足す。`mut` 参照・代入・`while` はストア更新が要るので段階2b。

決定（棄てた案と理由）:

- regionはde Bruijn indexでなく絶対レベル（regionスタック底から0） — indexだとblockを潜るたびに型内のregionをshiftする補題群が要る。レベルなら型は不変で、段階1の置換補題の構造がそのまま伸びる。棄てた案: de Bruijn index（型shiftの補題が倍増）、fresh id + 死亡マーク（Tofte–Talpin式。region pushで型へのregion代入が要る）
- 意味論はフレームスタック機械（CK風）に置換 — congruence式small-stepだとredex規則（alloc / pop）が「現在の深さ」を知れず、「評価スパイン上のregionマーカー数 = ヒープ長」という大域不変条件を別の述語で持ち回る必要がある。機械ならスタック型付けが深さを局所的に運び、popはdropLastになる。段階3のparallelでもタスク = スタックの形で機械が素直。棄てた案: 項内regionマーカー + スパイン述語、評価文脈の一意分解
- 型付けは `HasType Ψ d Γ e t`（Ψ = ストア型 = level → address → 型、d = 深さ）。`loc r a` の規則が `r < d` を要求する — 「region rに住む値はregion ≤ rしか参照しない」という不変条件が型付け規則そのもの。escape検査はblockの規則（結果型のregion < 自分の深さ）
- 深さdの部品はストア型の先頭d region（`Ψ.take d`）だけで型付けする — フレームとヒープ格納値をこの形で持つと、pop（`Ψ.dropLast`）で型付けが変化せず、strengthening補題が値の場合だけで済む
- 定理1の言明はprogressに吸収する — 解放済みregionへのderefは Ψ に無いので型が付かず、well-typedな機械状態は詰まらない（derefが失敗する状態に到達しない）

### 段階2bの断片（mut参照・代入・while。2026-09-18完了）

段階2aに `unit` 型（Soberのnone。コアでは `triv`）、`assign l e`（unitを返す）、`whileE c b`（unitを返す、本体の値は捨てる）を足した。sorryなし、公理はpropext / Quot.soundのみ。

決定（棄てた案と理由）:

- allocの型付けに `t.regionsBelow (r + 1)` を追加 — 段階2bの発見。immutableだけの段階2aでは「深いregionに言及する型」のスロット（例: `alloc (nil (ref 5 int))`）を浅いregionに置いても健全だった（格納値がnilやwrapperなら任意の Ψ で型が付く）が、代入を足すと後から若いregionの `loc` をそのセルに書き込めて、region解放後にdanglingが読める（preservationが壊れる = 型系が不健全）。Tofte–Talpin / Cycloneと同じ「セルの型は自分のregion以下しか言及しない」をallocの規則に置いた。定理1の非形式的言明「親regionの値は子regionの値を参照しない」の型付け規則化そのもの。HeapOkに不変条件 `tyBelow` として持ち、代入のpreservationは「書く値を `Ψ.take (r+1)`・深さr+1にstrengthening」で通る（value_strengthenを深さ +1からでなく任意の深さから落とせる形に一般化）。Examplesに非型付けの反例あり
- 全参照をmutとして扱う — immutableとの区別は段階3（parallel）で「region間で共有できるのはimmutableのみ」が要る時に導入。棄てた案: mutフラグを今足す（段階2bの定理には効かず、規則と補題が全部1引数太る）
- 代入とwhileはunitを返す — Phase 1 codegenの `none` 型に対応する `Ty.unit` を追加。棄てた案: 代入が書いた値を返す（C風。Soberの代入は文で値を持たない）

### 段階3aの断片（parallel、共有なし。2026-09-18完了）

定理2の最初の形。`par e1 e2`（`parallel scope { spawn e1; spawn e2 }` の最小形。両方走らせてjoin、unitを返す）を追加。sorryなし。

決定（棄てた案と理由）:

- タスク = 独立した機械状態の入れ子 — `State.par H S s1 s2` でs1 / s2は自前のヒープ・スタックを持つ完全な機械状態。spawnは `.eval [] [] e` で立ち上げ、両方が完了形（空スタックの値）になったらjoin。タスクが自前のregionスタックを持てる（本体のblock / allocは自分のヒープに閉じる）のはSoberの「タスクはワーカーに固定」と同型。棄てた案: タスク専用の縮小状態型（step・型付け・補題が全部複製になる）
- parの型付け: 本体は空ストア・深さ0・「Γ は全部loc-free」で型付け — loc-freeは `regionsBelow 0` の再利用（refを一切含まない型）。外のmut参照は型レベルでタスクに入らない = 不変値だけが渡る。強すぎる制約（refの束縛が1つでも見えるとparが書けない）だが3bでimmutable参照の共有として緩める。棄てた案: Γ のフィルタリング（de Bruijnのindex付け替え補題群が要る）
- スケジュールはパス（`List Bool`）のオラクル — `step π s` はparを潜るたびに π の先頭で側を選ぶ。stepが関数のままなので実行例がrflで書ける。progressは「∃ π」、preservationは「∀ π」。棄てた案: step関係（inductive）への置き換え（実行例がrflでなくなる）
- 一般のweakening補題を「値は文脈非依存」に置き換え — parの「Γ は全部loc-free」条件は任意型の挿入と両立せず、一般形は偽になる。使用箇所は置換補題の値のみで、値は自由変数を含まないので `value_ctx`（+ shift恒等）で足りる
- 定理2の核は可換性 — `par_step_commute`: 両タスクが1歩踏めるとき、どちらを先に進めても同じ状態に着く（タスクは互いの状態・ヒープに干渉しない）。共有なし断片では競合の不在 = この菱形。スケジュール全体の決定性（合流性）への持ち上げと、共有ありでの非自明なDRFは3b / 3c

### 段階3bの断片（immutable参照の共有。2026-09-18完了）

読み共有ありのDRF。`ref` にmutフラグ復活（`ref m r t`、`alloc m e`、`assign` は
`ref true` のみ）、parの Γ 制約をloc-free（`regionsBelow 0`）からmutFree
（mut参照をどこにも含まない）へ緩和。タスクは親regionのimmutableセルを読める。
sorryなし、公理はpropext / Quot.soundのみ。

決定（棄てた案と理由）:

- mutフラグはストア型 Ψ のセルに記録（`StoreTy` のセル = `Bool × Ty`）し、loc規則が
  セルのmをそのまま返す — locからmutを偽造できない。棄てた案: ref型だけに持つ
  （loc規則が任意のmを選べてしまい、共有locをmutに付け替えて書ける）
- 共有境界b（share boundary）を型付けに追加: `HasType Ψ b d Γ e t`。
  loc規則が `b ≤ r ∨ m = false` を要求 — 「共有region（r < b）のmutセルには
  この世界から触れない」が型付けそのもの。メインはb = 0（無制約）、par本体はb = d。
  allocは `b ≤ d`（共有regionへの割り当て禁止 = タスクは自分のblockを開いてからalloc）、
  StackTyの底（nil）は深さb。棄てた案: frozen store写像（mutセルをimmにコピーする）—
  mutセル経由のderefで格納値の再型付けが壊れる穴。Γ フィルタリング（3aと同じ理由で却下）
- immutableセルの格納型は深くmutFree（`alloc false` の規則premise、HeapOkの
  不変条件 `immMutFree`）— immセルにmut参照を入れて共有する抜け道をallocで塞ぐ。
  Veronaの「region間で共有できるのはdeeply immutableのみ」と同型。
  これが無いとspawn時の型付けの引き継ぎ（value_sb transport）が成立しない
- spawnは親ヒープをコピーで渡す（機械上）。物理共有との一致は定理
  `step_shared_stable` — well-typedな世界の1歩は共有プレフィクス `H.take b` を
  変えない（assignはloc型付けの `b ≤ r`、allocは規則の `b ≤ d`、popはStackTyの
  底bが守る）。これと `par_step_commute`（3aから不変）の2つが定理2の核。
  物理共有ヒープ機械とのbisimulationは形式化していない（言明だけ。3cで必要なら）
- HeapOkは「immセルか自世界のセル（b ≤ r）」だけ格納値の型付けを要求 —
  共有mutセルは型が付かないのでderefされ得ず、型付けを持たなくてよい。
  spawn（`heapOk_spawn`: bを Ψ.lengthへ引き上げ）でmutセルの型付けは落とし、
  immセルはimmMutFree + `value_sb`（mutFree値のb付け替え）で引き継ぐ
- タスクの最終形はヒープ空とは限らないためprogressの言明を
  「`ret H [] v`（空スタック）か1歩」に変更。トップレベル（b = 0）のH = [] は
  soundness側で `final_heap_empty`（StackTyの底 = 深さ0 = Ψ 空）として回収

### freezeの断片（2026-09-18完了）

段階3bの「共有は深くmutFreeのみ + 構築後の不変化の術がない」が実用の最大の性能アッパー
（mutで構築 → 共有、がO(n) コピー強制）だったので、freeze（mut → immの一方向セルタグ
遷移）を足した。言語側の決定はregion-domain-pool.md 1c節。sorryなし、
公理はpropext / Quot.soundのみ（par_step_commuteはpropextのみ）。

決定（棄てた案と理由）:

- loc規則でrefのタグmとセルのタグm' を分離: 条件は
  `(m = true → b ≤ r)` と `(m = false → m' = false)` の2本。
  mut locは型のみに結ぶ（セルタグ不問） — freeze後も古いmutエイリアスの型付けは
  壊れない（preservationに必須）。imm locはタグfalseのセルにだけ結ぶ。
  （改定2026-10-10 — F-al: 実装は実行時タグを持たない。受理の側で一意でないfreezeとfreezeの後の書きを拒否し〔language.md 17節U1〜U3〕、
  機械のタグとpanicは「受理された範囲ではタグを切り替えたセルに書かない」の観測点として残す。照合 = Leanの述語uniqFreeze ⊇ analyzerの受理・定理は保留）
  帰結: 「凍結済みセルを指すmut loc」に型が付く — その書き込みは実行時タグ検査（panic）
  が受ける。動的検査が健全性の底、は見積もりどおり
- StoreLEを「型は保存、タグはmut → immの一方向順序」に再定義
  （`∃ ρ' m', … ∧ (m = false → m' = false)`）。既存補題（take_self / append / set_concat /
  take_take）はm' = mでそのまま通り、freezeの `storeLE_set_freeze` だけが真に一方向を使う
- 機械のヒープをタグ付きセル（`Bool × Expr`）に実体化し、`State.panic H` を追加
  （terminal、ヒープ保持）。assignはタグ検査（true → 書き込み、false → panic）、
  freezeKはセルのタグを切り替えて同じlocを返す。HeapOkに `tags`（Hと Ψ のタグ一致）を追加 —
  機械のタグ検査と型のタグが同じものを見ていることのsource
- parのpanic伝播は「スケジューラがpanic側を選んだとき」（`true :: π'` でs1が
  panicなら親へ伝播）。棄てた案: join検査の直後の無条件チェック —
  par_step_commuteが壊れる（左を1歩進めた結果がpanicのとき、右を先に進める自由が
  消える）。スケジューラ側チェックなら `notPanic_of_step`（1歩踏める状態はpanicでない）
  だけで可換性が構造不変。panicはsiblingをキャンセルしない（この断片にキャンセルは無い）
- step_shared_stableは維持: freezeの書き替えはmut locの型付けの `b ≤ r` が
  `take b` の外を保証（共有セルを凍結し直す経路は型が付かない）。panic遷移はヒープ不変
- progress / soundnessの言明は「値 / panic / 1歩」の三択に。
  Examples: ex9（mutで構築 → freeze → par共有 → 42。構築のmut束縛をfreezeの引数の
  letのチェーンに閉じてparの Γ をmutFreeに保つ — このパターン自体が発見）、
  ex10（freeze後の古いmutエイリアスへのassign: 型は付くが実行でpanic）

発見:

- 段階3bのloc規則 `b ≤ r ∨ m = false` は分離形 `(m = true → b ≤ r)` の特殊形だった。
  分離してもすべての利用箇所は「mをcasesしてどちらかを取る」だけで通る
- parの Γ にmut束縛が残るとparに型が付かない（mutFree検査）ので、
  「構築 → freeze」はletのチェーンをfreezeの引数側に押し込む形がFeatherweightの書き方。
  実言語ではスコープ制御（ブロック式の値にfreezeを掛ける）が同じ役割
- Leanの罠追加: `cases hS with | freezeK …` のrename_iはfresh変数3つ
  （S, r, t — dとtfはunificationで消える）。`if c then` （c : Bool）を含むmatchを
  仮説内で潰すときは `by_cases hp : c = true` + `simp [hp] at hs` が安定
  （`split at hs` はDecidable.recの依存消去で落ちることがある）

### 段階3cの断片（チャネル。2026-09-18完了）

タスク間通信。`chan t` / `newchan` / `send` / `recv`（無限バッファ: sendは常にenqueue、
recvだけが空キューで待つ）。sorryなし、公理はpropext / Quot.soundのみ
（par_step_commute / blocked_no_stepはpropextのみ）。

決定（棄てた案と理由。ペイロード範囲とバッファ意味論は2026-09-18に決定）:

- ペイロードはloc-free（`regionsBelow 0`）限定: タスクのヒープはspawnコピーで
  独立なので、locを含む値は受け手の世界で読めない。参照を含む値のtransport
  （深いコピー = flatten。ヒープの非循環性不変条件が要る）は次の段階として独立に積む。
  3cは「チャネルという同期機構そのもの」に絞る（決定A/A）
- 無限バッファ: 待機形がrecvの1つで済む。容量制限・ランデブーは後からバッファ
  上限として足す方が定理を再利用できる。この決定はチャネルのバッファリングの
  言語側の初期決定を兼ねる（docsに既存の決定なし）
- チャネルストアKは全タスク共有のグローバル（stepがKを編んで通す
  `step π s K : Option (State × ChanSt)`）。タスクの入れ子（parの独立機械状態）とは
  別レイヤ — 「チャネルは並列スコープをまたぐ唯一の可変通信」の機械化そのもの。
  棄てた案: parノードにチャネルを置く（子タスクの操作を親が仲介する形。
  入れ子越しの配達機構が要り大きい）
- チャネル型環境 Ξ をHasTypeの新indexに追加（`HasType Ξ Ψ b d Γ e t`）。
  実行時チャネル参照 `chanV c` の型は Ξ が与える（Kと同様グローバル）。
  newchanで Ξ が伸びるのでpreservationの結論が `∃ Ξ', ChanLE Ξ Ξ' ∧ …` の存在形に。
  ChanLE（append単調性）のtransport（chan_mono）がHasType / StackTy / HeapOk /
  StateTyの全部に走る — あるタスクのnewchanが兄弟の型付けを壊さないことの中身
- `chan t` はmutFree = true（Sharableの最小形）: region-domain-pool.mdの
  「第3のクラスSharable」の方向づけを、型述語の白リスト1行として実装。
  parの Γ 検査（mutFree）をチャネルが通ることが「不変値かチャネルのみ」の型付け化
- ChanOkがキューの値を世界非依存（`HasType Ξ [] 0 0 []`）で型付け。
  送信側はvalue_purify（loc-free値は Ψ / b / d / Γ に依存しない）で世界から抜き、
  受信側はvalue_unpurifyで任意の世界に入れる。mutFree_of_locFree（loc-free → mutFree）
  で共有境界bも自由に付け替わる — 「純値は世界を選ばない」が補題2本で閉じた
- progressは四択に: 値 / panic / Blocked（recv待ち） / 1歩。
  Blockedは帰納的（recv待ちのret、待機と完了の組のpar）で、
  `blocked_no_step`（待機 = どのスケジュールでも進めない）が待機の意味を固定する。
  デッドロック自由は主張しない（型の性質ではない。ex12が実演）
- par_step_commuteは「Kを変えない歩」に弱めた: チャネル操作は同期点なので
  可換性を主張しない — DRFは決定性ではなく「ヒープアクセスは可換、非決定性は
  チャネルに封じる」。Kを変えずに成功する歩はKを読みもしない（send / newchan /
  成功するrecvはすべてKを変える）ので、「K不変」が「チャネルに触れない」の
  特徴づけとして正確

発見:

- 「子世界 → 親世界の値transport」の壁は、ペイロードをloc-freeに絞ると
  purify / unpurifyの補題2本に縮む。壁の本体は参照つき値（次の段階のflatten）にあり、
  同期機構とtransportは直交に分離できた
- チャネルの同期が結果を決める実行例（ex11）: 受信側を先に走らせて待たせても、
  送信後に再開して同じ42 — スケジュール非依存が「同期を通した値の一意性」として見える
- Leanの罠追加: `Option.map f o = some x` をsimpすると ∃ が `∃ a b,`（Prod.exists）に
  割れる — pairのobtainパターンは `⟨s', K', h, rfl, rfl⟩`（⟨⟨s', K'⟩, …⟩ だと
  Stateのcasesに化ける）。仮説内のmapは `cases hstep : step …` で先に場合分けする方が安定。
  ∀ π を含む帰納（blocked_no_step）は π を引数に置くとIHが同じ π に固定される —
  結論を `∀ π,` にしてintroする

### 段階3dの断片（チャネルの参照つきペイロード = 共有region参照。2026-09-18完了）

ペイロードをloc-freeから「mutFreeかつ共有regionへのimm参照を含んでよい」へ緩和。
sorryなし、公理はpropext / Quot.soundのみ（par_step_commute / blocked_no_stepはpropextのみ）。
言語側の決定はlanguage.md 18節（シャローコピー + 共有region参照 = 案C'。
flatten = 深いコピーは棄却: 消去型は再帰型でrecvの型が書けず、構造保存はbox型 +
ヒープ非循環性が要り最重量。明示deep-copyはstdの仕事で体系外。
積んでいた「flatten + 非循環性」の壁は、この決定で消えた —
非循環性の発見「freezeの順序がimm参照グラフの位相順序」はstdのdeep-copy検証用に残る）。

決定（機械化の設計）:

- `chan` 型が共有上界rcを持つ: `Ty.chan (rc : Nat) (t : Ty)`。
  `regionsBelow d = (rc ≤ d) && t.regionsBelow rc` — ペイロードの参照はregion < rc限定で、
  チャネル自体がrcより下へescapeできないことが「参照先はチャネルより長生き」の型付け化。
  mutFreeはtrueのまま（Sharable）。rcは脱糖器が計算するコアASTの注釈
- Ξ のエントリが共有プレフィクスのスナップショットを持つ: `ChanTy := List (StoreTy × Ty)`、
  エントリ (Ψc, t) の Ψcは生成時の `Ψ.take rc`（長さ = rc）。queue値の型付けは
  `HasType Ξ Ψc rc rc rc [] v t`（世界非依存 → スナップショット世界依存へ。
  rc = 0・Ψc = [] が段階3cのloc-freeチャネルの特殊形で、purify / unpurifyは一般機構に吸収）
- chanVの型付けにスナップショット等式を焼き込む: `Ξ[c]? = some (Ψc, t)` に加えて
  `Ψ.take rc = Ψc` と `rc ≤ f`。「chanVに型が付く世界はペイロードの参照先を
  スナップショットと同じ内容で持つ」が局所的に読め、sendとrecvがこの等式で出会う
- 書き込みの下限fをHasTypeの新indexに（`HasType Ξ Ψ f b d Γ e t`。機械状態ではf = b）:
  等式の保存には「この世界線の書き込み（alloc / freeze）はregion ≥ f ≥ rc」が要るが、
  parがbをdに引き上げるためbでは表現できない — par本体の中のchanVに
  「rc ≤ 内側のb」だけ課すと、実行では到達しない導出（rc > 実世界の境界）が
  preservationを壊す（幽霊導出）。fはparを素通しし、spawn時にf_monoで引き上げる。
  fはchanV / newchanの `rc ≤ f` にしか現れないのでfの引き上げは自明に単調
- newchanのpremise: `rc ≤ f ∧ t.regionsBelow rc ∧ t.mutFree`。
  rc ≤ fが生成後のスナップショット不変を構成的に保証する
- チャネルつき並列スコープparchを追加（`parch t e1 e2`: rc = spawn深度dの
  チャネルを作りvar 0として両本体に渡してspawn）: フラッグシップの
  「親が深さdでデータとチャネルを作り、子2つが共有」は、親（b < rc）の単独newchanでは
  作れない — 生成からspawnまでの間に親がregion < rcへalloc / freezeできて
  スナップショットが揺れる。生成とspawnを融合すると、生成の瞬間に全保持者の下限が
  rc以上になり、揺れるウィンドウがゼロになる。親の続きにチャネルは残らない（子だけが束縛）
- store_monoのプレフィクス条件は ∀ 形（StorePre）: 「take fの等式」では足りない —
  derefがセル型付け（store `Ψ.take (r+1)`）を全体へ運ぶときf = b > r+1があり得る。
  「n ≤ fかつn ≤ 元ストア長ならtake nが一致」に一般化（スナップショットは
  元ストアに収まる長さしかないのでchanVの必要分を正確に覆う）

発見:

- 「参照つき値のtransport」の壁の本体はflattenではなく世界間のヒープ内容の合意だった。
  タスクごとの Ψ はStateTyの存在量化に隠れて互いに関係を持てないので、
  合意はグローバルな Ξ に置いたスナップショットとの等式としてしか述べられない。
  等式が安定する条件を探るとrc ≤ f（書き込みの下限）とparch（生成 = spawn）に行き着く —
  設計が証明の側から一意に決まった
- 実行例ex13: imm参照をparchチャネルで送り、受け手がderefして結果を返す。
  参照は一度もコピーされない（キューを通るのはlocそのもの）。
  受信側を先に待たせても同じ42 — 参照のtransportでも同期が値を決める
- send / recvのtransportは補題4本の合成に分解された:
  send = value_strengthen（深さ・ストアをrcへ）∘ value_sb（b → rc）∘
  value_f_set（型のregionsBelow rcからf → rc）、
  recv = store_mono（スナップショット等式がプレフィクスを供給）∘ value_depth_weaken ∘
  value_sb ∘ f_mono（rc ≤ 受け手のb）

### Sharableの断片（Pool = chanの派生形。2026-09-18完了）

region-domain-pool.md「第3のクラスSharable」の拡張を、新しい型規則ゼロで確認した。
Poolの骨格（acquire / release / 排他 / 待機 / 資源の再利用）は既存のチャネル規則だけで
書ける — Sharableの白リストは `chan` 1行のまま、Poolは派生形。
定義の変更なし（Examplesの追加のみ）、`lake build` 緑。

確認した対応（ex14 / ex15）:

- free-listチャネルがPoolの骨格: acquire = recv、release = send、
  空きスロットの集合 = キュー。排他は「キューの値は一度しか取り出せない」という
  チャネルの意味論そのもので、ロックもatomicsも体系に現れない
- 共有可変状態は「値の循環」で書ける（ex14）: 状態はセルに置かず、
  acquireで取り出しreleaseで戻す値そのもの。mut参照ゼロで
  「両タスクの更新がどちらの順でも直列化され、失われない」が実行例で見える
- 資源の再利用（ex15）: imm参照を循環させると、release後の再acquireが
  同じlocを返す — Poolの本質「作り直さず回す」が、キューを往復する参照として
  そのまま機械化される。acquireの待機はrecvのBlocked（専用機構なし）
- mutスロットの循環は型が付かない: newchan / parchのmutFree検査が拒否
  （段階3dの否定例そのまま）。実Poolの可変スロット（acquireが返すピン済み `*T`）は
  体系外で、region-domain-pool.md 4b「動的検査のはしご」（世代検査が底）が受ける。
  ここで白リストに `pool` を足したくなったら穴の信号 — 足さずに済んだことが
  「Poolのスレッド安全性は (a) 単一書き手 + 共有Pool」（同 未決）の裏づけ

位置づけ:

- 言語側の決定は変わらない: Sharableの確定はPhase 3のアトミック設計と同時
  （language.md未決）。この断片が言うのは「Poolは白リストの新エントリを要求しない」
  という消極的事実と、Phase 3で書く「チャネル版Pool参照実装」（実Poolとの
  観測等価を差分テストで見る計画、region-domain-pool.md 164行）の形が体系内に
  既にあることの2つ
- 実Poolの性能形（atomics・フリーリスト・世代タグ）の正しさはTLA+ と
  差分テストの守備範囲（design-dev.md Phase 5b）。体系はその参照実装側だけを持つ

### 型検査器の断片（Phase 2の一手目。2026-09-18完了）

（2026-10-28追記: Soberのコピーの拒否の位置〔`sober: type error at …` — language.md 38節〕は判定の意味の外で、証明の対象に入らない。判定JSONはLeanと同じバイト列のまま）

`Checker.lean`: 実行可能な型検査器 `typecheck` と、宣言的規則 `HasType` への
健全性・完全性の証明。「証明済みの型付け規則と型検査器のコードを同じ定義から出す」
（実装との照合3 → 2の3）の核。sorryなし、公理はpropext / Quot.soundのみ。

- typecheck_sound: `typecheck = some t → HasType … t`（全項で成立）
- typecheck_complete: ソース項（`Expr.src` = loc / chanVを含まない）なら
  `HasType … t → typecheck = some t`。2つ合わせてhasType_iff_typecheck
  （ソース項の型付けはtypecheckが決定する）とhasType_unique（ソース項の型は一意）
- loc / chanVは検査器の対象外（noneを返す）: 実行時にのみ現れ、型付けに自由度が
  ある（locのmは条件次第で両方選べる）ため。ソース項に絞ることで完全性が言えた —
  「脱糖器がLeanに渡すコアASTの範囲 = Expr.src」が境界の仕様になる
- Examplesにex1〜ex15全部 + 否定例3本の突き合わせ（rflで照合）

Leanの書き方の発見:

- 検査器の本体はdo記法でなく明示matchで書く: `split at` はBind.bindで
  場合分けできない（match式でないため）。明示matchなら等式補題 → `split at h` の2手で
  健全性の各ケースが機械的に落ちる（`split at h <;> try cases h` — 失敗の分岐は
  constructor衝突で閉じ、成功の分岐はsome単射で代入される）
- `exact nomatch h` の罠: 反駁できないhに使うと「Missing cases」がログ型エラーに
  なってsorryでゴールが閉じ、後続タクティクが「No goals」で壊れる。
  `try` で包んでも守れない（例外でなくログのため）。反駁は `cases h` を使う

JSON境界とバイナリ（同日 完了）: コアASTの形は最小案で決定—
「Phase 1でcodegenが内部でやっている脱糖をそのままJSON化する」（inline展開込み・
パターン済み）。脱糖を浅くしてLeanのExprを広げる案は棄却（広げた分が未証明の
参照実装になる。「正直に見ておく点」）。

- `Json.lean`: toJson / fromJsonが境界スキーマの正（"k" が種別タグ。ファイル冒頭に
  全形を列挙）。fromJsonは燃料つき再帰 — partialにせず計算可能に保ち、
  parse ∘ printの不動点をrflで照合（Zig printerの不動点オラクルと同じ形式）。
  loc / chanVは境界の語彙に無い = パースが拒否（Expr.srcの機械化）
- `Main.lean` + `lake exe sober-check`: stdinにコアAST JSON、stdoutに判定
  `{"ok":true,"ty":…}` / `{"ok":false,"errors":[…]}`（診断が育つ余地のリスト形）。
  終了コード0 = 受理、1 = 拒否。実行はコンパイル済みで検査器の証明はそのまま乗る
- スモークテスト: ex14受理（int）、escape拒否（type error）、非JSON拒否（parse error）

Zig側の脱糖器と `sober check`（同日 完了）: `src/stage1/desugar.zig`（AST → コアAST → JSON）と
CLIサブコマンド `sober check <file> [--core-json]`（脱糖 → sober-checkを子プロセスで起動 →
判定をrelay。検査器は `$SOBER_CHECK` → PATH → `lean/.lake/build/bin/sober-check` の順で探索）。
テストは `src/stage1/desugar.test.zig`（対応のJSON照合 + 断片外の拒否 + sober-checkがあれば統合）。
決定と対応の決めごと:

- 検査単位は `main` の本体1つ（コアに関数が無い）。inline関数（expands）とラムダは
  呼び出し点にASTレベルで展開して消す（値引数はletE、可視範囲はcodegenのViewと同じ規律:
  inline本体は自分の引数のみ、ラムダは定義時env + 引数。名前 → de Bruijnは束縛の絶対
  レベルで解決）。非inline関数の呼び出しは断片外として拒否。全関数個別検査案は Γ の与え方が
  無いので棄却
- main本体は `block` で包む — alloc規則が深さ1以上を要求するため（mutが深さ0で
  型付け不能）
- mutは段階2bの対応そのままrefに: `mut x := e` → `alloc true`、読み → `deref`、
  `x = v` → `assign`、`x += v` → `assign` + `add`
- region境界になるのは式位置の `{ }`・関数の本体・ループ本体（whileの本体 — 文形forは生成元のwhileの本体に展開される）
  （ループ本体は宛先構築レーンM4 2026-10-05 — `while c (block body)`・外への格納はcopyTo / mksliceAt。language.mdの「ループ本体はスコープ」。
  lowerが反復のregionを開くのはM5 — それまでは脱糖器だけが多く囲む向きで、これは健全〔lowerは値を長く生かすだけ〕。regionboundはwhileの本体のblockを引いて数える）。
  それ以外の `{ }` — if / switchの分岐・クロージャの本体 — は透過（letEのチェーン / scopeだけ）。文位置の値は匿名束縛（letE）で流し、文列の終端は `triv`。
  脱糖器・codegen・lowerはこの列挙で揃える（揃っていないとcheckが受理したプログラムを宙吊りに下ろす — 健全性の穴）。前例:
  - codegen（2026-09-27）: 分岐ごとにregionを開いており、分岐の中で作って外へ積んだ値が死んだregionに残って後の周回で上書きされていた
  - lower（2026-09-29、c04ffd4）: クロージャの本体を式位置の `{ }`（blockValue）としてregionで囲んでいた — 文形forの本体で確保して外の可変sliceへ
    書き戻すと反復ごとに畳まれて上書き（examples/lambda_region — 修正前38980、正19980）。凍結したZig版も同じ穴を持つのでlower側のZig ≡ Soberから5本を退役
    （scripts/frozen/lower-retired.list）。ゴールデンの例外3件目（irtext / lltext 7本 — scripts/regiondrop.tsで「region操作の除去と番号の振り直しだけ」を機械照合）
  - 保留（再発防止の機械検査の案 — 未実装）: 「コアのblockの数 = IRのregion.enterの数（関数の入口を除く）」を差分オラクルで照合し、脱糖器とlowerのregion境界の一致を見る
  - 周回ごとの回収は意味論（ループ本体はスコープ — language.md）。旧記述「最適化器の仕事」は2026-10-04の決定 (a) で置き換え
- 演算子は `+` と `<` のみ（Lean側が代表2つに絞っているため）。`a > b` → `lt b a` の
  正規化は評価順が変わるので棄却。定数パターン・break / continue / defer・多値・非tailの
  returnも断片外
- 2バリアントunion: 構築は `inl` / `inr`（注釈 = 他方のペイロード型。0フィールドvariantは
  `unit` / `triv`）、型パターンswitchは `case`（defaultは残りvariantの分岐に共有）

応答時間ベンチ（同日）: `bench/check_bench.sh`（end-to-endの `sober check`、「順序」5の
再実装トリガー計測）。基ベースライン2026-09-18: 約130ms/run（大半はLeanバイナリのプロセス起動。
遅くなったらまずLean 4のC出力リンク案を試す — 条件2）。

段階2の差分テスト基盤（同日 完了）: `lean/FeatherweightSober/Gen.lean` +
`lake exe sober-gen <seed> <count>` — JSONL（各行 `{"e": コア AST, "v": 判定}`）を吐く。
goldenセットは `testdata/corevec.jsonl`（seed 42・300本、accept 204 / reject 96）、
照合は `scripts/corevec.sh`（再生成diff。`--binary` でsober-checkバイナリ経路も照合、
`--regen` で意図した変更後の更新）。将来のZig再実装（「順序」5）はこのベクタで
Leanをオラクルにする。

- ジェネレータは2本立て: 型指向 `genTyped`（typecheckの規則に沿ってwell-typedな項を組む。
  let / ite / case / ifnil / block / alloc / deref / assign / while / freeze / newchan /
  send / recv / par / parchを踏む）+ chaos `genChaos`（語彙全体からランダム。reject側）
- 決定: plausibleでなくLean coreのStdGen。当初「依存追加が要るから」としたのは
  不正確で、正しい理由は「plausibleの提供物（derive / shrinking / `#test`）が今回の
  成果物に効かない」— 核の型指向ジェネレータは型規則を知らないと書けずどのみち手書き、
  乱数はcoreの `mkStdGen` / `randNat` で決定的に足りる（toolchain固定で再現可能）。
  Lean内PBT（preservationの `#test` 等）をやる時期になったらplausibleを入れる
- 型指向ジェネレータの不変条件: ターゲット型は常にloc-free（ref / chanは Γ にだけ現れる —
  alloc / newchan / parchの束縛経由）。これでblockのescape検査に常に通り生成が
  行き詰まらない。共有境界bをスレッドし、par / parchの分岐はb = dで生成
  （allocはD ≥ b + 1までblockを開いてから置く）
- ジェネレータのバグ2件を判定側（typecheck）が検出して直した実績: parの分岐のbを無視した
  alloc、recv束縛の Γ ズレ。「ジェネレータがgoldenを汚してもtypecheckが正」の構図が効いた
- 検証: 2シード × 200本の型指向ベクタが全accept、chaos込み300本でaccept/reject混在、
  バイナリ経路（sober-check）とin-process判定の一致を先頭30本で照合

### Phase 2第一弾のスコープ（決定2026-09-18）

- 範囲: 関数（一階）+ n-ary struct/union + 多値 — Phase 1でcodegenが動く全構文が
  `sober check` に通る状態が第一弾のゴール（fib / shape / multi）。string / slice / mapの
  region意味論（language.md未決）は第二弾に切り離す。T? flow typing先行案も棄却
  （ifnilはコアに証明済みだが、関数が無いままではcheckの適用範囲が狭すぎる）
- 証明ごと広げる: Featherweightの新しい段階としてHasType / typecheck /
  progress / preservationまで揃えて進める。別型FullExpr + 未証明参照実装の二層案は
  棄却（JSON境界・ベクタ・検査器が未証明側に移り、断片を育てるとき同じ定義を二度書く）
- 段階の構成: 演算子 → n項化 → 関数（決定2回目2026-09-18: 当初の 関数 → n項化 から
  入れ替え）。多値はコアに入れず脱糖器がstructに落とす（決定19「実体化しない」は
  codegenの仕事で型検査には見えない）
- Listをコアに入れない（nested inductiveは全帰納証明で標準inductionを壊す）:
  - structは二項直積の右結合入れ子: `Ty.prod l r` + `pair` / `fst` / `snd`。
    フィールド名 → 位置とネスト展開は脱糖器の仕事（段階1の「名前 → 位置」の延長）。
    n = 0はunit、n = 1は素の型（prodを作らない）
  - n-ary unionは既存の二項unionの入れ子（コアの変更ゼロ。variant i → inl/inrのチェーン、
    switch → caseの入れ子）
  - callは引数1個固定 `call f e` が永久設計: 多引数はstruct（pairのチェーン）に脱糖
    （「多値 = struct」と対称。評価順はフィールド順で保存）。`call (args : List Expr)` 案は
    nested inductiveのため棄却
  - 順序入れ替えの理由: structが先に入れば関数の段階が最初から完全体（1引数 = struct）で
    書ける。fibのcheckは両段階完了後
- 演算子は2ファミリに畳む: `arith op a b : int`（sub / mul / div / mod）と
  `cmp op a b : bool`（eq / ne / le / gt / ge）。1演算子1コンストラクタは証明の場合分けが
  演算子数に比例するので棄却。既存のadd / ltはそのまま残して追加のみにする
  （置き換えは証明・Examples・JSON・Zigの全リネームが波及するため棄却。非対称は美的問題）。
  div / modは `Int.tdiv` / `Int.tmod`（x86 idivの切り捨てと一致: -7÷2 = -3余 -1）、
  ゼロ除算はpanic（既存機構）。`a > b` → `lt b a` の正規化は評価順が変わるので引き続き棄却。
  `&&` / `||` / `!` はiteへの脱糖（短絡がそのまま出る）
- ビット演算（`&` / `|` / `^`）は見送り — 対応タイミング: 第二弾の頭。理由: Lean coreに
  Intのビット演算が無く、自前の2の補数実装はx86との一致検証がもう一仕事になる
  （演算子の段階の本旨でない）。第二弾で入れるときの作法: Int上の2の補数land / lor / lxorを
  Leanで定義し、Zig側の命令エンコーダオラクルと同じ形でLean実装 ↔ 実行結果の突き合わせ
  ケースを差分テストベクタに足してからarithファミリにopを追加する（ファミリ設計なので
  追加はop 1つ + 意味論1行 + 証明の場合分けは増えない）。それまで `&` / `|` / `^` は
  断片外（CoreFragment）として明示的に拒否される
- 関数境界はloc-free・呼び出しは新しい世界: 引数・戻り値はloc-free限定、callは
  parのspawnと同じ「自前ヒープの入れ子世界」で実行（段階3aの隔離を流用。関数本体の
  型付けは「空ストア・深さ0・Γ = params（loc-free）」でparのタスクと同型）。
  関数本体を深さ多相で型付けする案はregion絶対レベルの単純さを壊すので棄却。
  refを関数境界で渡すのは後段（region escape規則の関数版）へ
- 名前解決の最小形（packageの形）は第一弾では保留 — 単一ファイル・package mainのみで
  package横断が無いため。第二弾の入口で決める

### 演算子の段階（2026-09-18完了）

第一弾の段階1。`lake build` 緑、sorryなし、公理propext / Quot.soundのみ。

- Exprに `arith op a b`（sub / mul / div / mod、int → int）と `cmp op a b`
  （eq / ne / le / gt / ge、int → bool）の2コンストラクタ。add / ltは既存のまま併存
- 意味論: `ArithOp.eval : Option Int`（none = ゼロ除算）。ゼロ除算はstepがpanicに
  落とす（既存機構。language.md未決「panicの適用範囲」が決まったらここが変わる、と
  Machineにコメントで紐づけ）。div / modはInt.tdiv / tmod（x86 idivと一致）
- 証明の追加は全て機械的（フレームarithL/R・cmpL/Rをadd/ltと同型に、preservationの
  arithRだけ `split at hs` でpanic分岐が増える）。Examplesにex16（演算混合）・
  ex17（ゼロ除算panic）とroundtrip
- JSONはフラットな種別タグ（"sub" … "ge"）でarith / cmpに落とす。fromJsonの
  分岐はヘルパーに切らず展開（mutualにするとwell-foundedコンパイルでroundtripの
  rfl照合が壊れる — Leanの罠）
- Zig脱糖器: 演算子マップ + `&&` / `||` / `!` → ite（短絡がそのまま出る）+
  単項 `-e` → `sub (lit 0) e` + 複合代入（-= *= /= %=）。ビット演算はCoreFragmentで
  明示拒否（第二弾の頭）
- ジェネレータ: genTypedのint / boolターゲットとchaosに演算子を追加。golden再生成
  （300本、typed側全acceptを維持）

### n項化の段階（2026-09-18完了）

第一弾の段階2。`lake build` 緑、sorryなし、公理propext / Quot.soundのみ。

- コアはprod / pair / fst / sndの4つだけ: structは右結合のprodのチェーン、n-ary unionは
  既存の二項unionの入れ子（コアのunionは変更ゼロ）。証明の追加は全て機械的
  （canonical_prod + 各帰納のpair / fst / sndケース。新しい壁なし）
- Zig脱糖器が名前 → 位置とネスト展開を全部持つ:
  - structリテラル → pairのチェーン（名前つきは位置に並べ替え、評価はフィールド順）、
    selector → 射影（i < n-1は `fst (snd^i)`、末尾は `snd^(n-1)`）
  - n-ary unionのvariant i → inl / inrのチェーン（注釈は残り部分木の型）、switch → caseの
    入れ子（各レベルの右の分岐がvar 0で残りを再分解。パターンのフィールド名は射影のletEで
    束縛。1フィールドは射影が恒等なのでcase束縛に直接名前を付ける）
  - フィールド代入は再構築: `p.y = v` → `assign p (pair (fst (deref p)) v)`（パスは
    再帰的に組み直し。複合代入はフィールドパスでは断片外）
  - 多値の同時束縛・同時代入: `x, y = y, x % y` は全値をletEで評価してから代入
    （多値呼び出しの分解は関数の段階で）
  - selector / フィールド代入の解決のためBindingに型宣言（decl）を持たせた —
    脱糖器が最小の型追跡を始めた点は関数の段階（戻り値型）でも使う
- 統合例: 入れ子struct（Tagged{id, s Shape}）・3-variant switch・フィールド代入・
  gcdの同時代入が1本のmainでcheckに通る

### 関数の段階（2026-09-18完了）— 第一弾のゴール: fibがcheckに通る

`lake build` 緑、sorryなし、soundness / preservationの公理はpropext / Quot.soundのみ
（Examplesのfib実行とJSON roundtripだけnative_decide = ofReduceBool）。

- 関数表 Δ : Defs（`Def = {param, ret, body}`、引数1つ）をHasType / StackTy / HeapOk /
  ChanOk / StateTy / typecheck / stepの先頭パラメータにスレッド（意味変更ゼロの下準備
  コミットを分離）。`call fn e` はコアの新コンストラクタ、フレームcallK、状態callst
- call = parのspawnと同型の入れ子世界（単騎）: 引数・戻り値はloc-free（DefsOkが
  運ぶ）、本体は空ヒープ・空スタック・Ξ 共有で走り、完了で値がメインへ返る。
  値の世界渡りは `value_export` / `value_import`（strengthen → f_set → sb → ctx /
  store_mono → depth_weaken → sb → f_monoのはしご。チャネルペイロードの輸送と同じ理屈）。
  再帰は Δ 経由なので停止性不要のまま型健全性が立つ
- DefsOk（各本体が空世界 `Ξ=Ψ=[]、f=b=d=0、Γ=[param]` で型付く）はpreservation /
  run_preserve / soundnessの新しい仮定。checker版 `checkDefs` と
  `defsOk_of_check`（typecheck_sound経由、src制約不要）でバイナリの入口も証明済み側に乗る
- JSONは `{"defs":[{"param","ret","body"}...],"e":E}` の封筒（素の式も後方互換で受ける）。
  sober-checkはcheckDefsを先に通す（拒否は "def error"）
- Examples: fibΔ で `checkDefs = true`・`call 0 (lit 10) : int` がrfl、fib 7 = 13の実行が
  native_decide、引数型違い・未定義indexの拒否
- Zig脱糖器: 非inline関数（main以外）を宣言順に関数表化。多引数はpairのチェーンにまとめて
  1引数（多値returnもpairのチェーン — 「多値 = struct」と対称の「多引数 = struct」）。
  本体はblockで包み（mutに深さが要る — mainと同じ）、2引数以上は射影のletEで
  名前付け。`x, y := g(...)` の分解も射影のletE。printlnは「引数を評価してunit」に
  脱糖（出力のエフェクトはanalyzer層の領分 — これでexamples/fib.sober・multi.soberが
  そのままcheckに通る）
- Leanの罠追記: `e.subst k v` のドット記法の罠を機械のcall規則で再踏。
  StateにDecidableEqをderiveするとnative_decideで機械実行例が書ける

第一弾ここまでのcheck対象: fib / multi / gcd系 / union・struct混在のmain。
残りの断片外: break / continue（regionの出口と一緒 = deferと同じグループ）、定数パターンと
多subject switch（eqが入ったので脱糖可能になった — 第二弾候補）、部分フィールドリテラル。

残るPhase 2の作業: 第二弾（ビット演算、string / slice / map、名前解決の最小形、
`ifnil` / `T?` のソース構文のcst_to_ast対応、定数パターン・多subject switchの脱糖）。

### ビット演算の段階（2026-09-19完了）— 第二弾の段階1

第一弾で見送った `&` / `|` / `^` を、決定済みの作法（突き合わせを先に用意してから
arithファミリにopを追加）どおりに入れた。`lake build` 緑、公理はpropext / Quot.sound
（突き合わせExamplesのみnative_decide = ofReduceBool — fib実行と同じ扱い）。

- Lean実装: Machine.leanに `intLand` / `intLor` / `intLxor`（無限桁の2の補数。
  `negSucc n` のビット列 = nの補元、mathlibのInt.landと同形。負×負は
  `~(~a op ~b)` の双対で閉じる）。補助の `natLdiff (a &&& ~b)` はcoreに無いので
  `Nat.bitwise` で定義。ArithOpにland / lor / lxorを追加 — ファミリ設計の回収:
  意味論3行 + evalの3分岐だけで、Typing / Checker / Soundness / Substitutionは
  1行も変わらない（opはファミリ内で不透明）
- 突き合わせの対: examples/bits.sober（実行 = x86のand/or/xor/not、examples/bits.outが
  期待値）とExamples.leanの `ArithOp.eval` 突き合わせが同じケース・同じ期待値を持つ。
  片側だけ変えるとどちらかが食い違う（エンコーダオラクルと同じ役割）。負数含む12ケース。
  値が64bitに収まる限り一致 — addと同じ約束（unbounded Int）
- `decide` は使えない: `Nat.bitwise` はWF再帰でkernel簡約が
  `natLdiff` で止まる。突き合わせはnative_decide（Examples限定の既存方針）
- Zig: エンコーダに `notReg`（F7 /2、negRegと同系統）+ オラクルケース。codegenの
  単項 `^` は `not rax`。脱糖器は `&`/`|`/`^` → and/or/xor、`&=`/`|=`/`^=` を
  複合代入ファミリに追加、単項 `^x` → `xor x (-1)`（notと同値）
- ~~シフト（`<<` / `>>`）は断片外のまま~~ → 回収（下の「シフトの段階」、2026-09-27）
- JSONタグは "and" / "or" / "xor"（`&&`/`||` はiteに脱糖済みなので衝突しない）。
  golden 300本を再生成（ビット演算29件混入、typed側accept維持、バイナリ照合OK）

### シフトの段階（2026-09-27完了）— 随時回収R2

決定 = Go準拠: `x << n` はn ≥ 64で0、`x >> n` は算術右シフト（floor）でn ≥ 64は0 / -1、
負のnはpanic（ArithOp.evalがnone → ゼロ除算と同じ受け皿。Goの実行時panicと一致）。
棄てた案: x86の6bitマスクをそのまま意味にする（`1 << 64 = 1` — unbounded Intと突き合わせられず、
CのUB由来の挙動を言語に持ち込む）。

- Lean: ArithOpにshl / shrの2 op（Intの `<<<` / `>>>`）。shlだけ `64 ≤ b → 0` を明示
  （64bit切り詰めの帰結）、shrはfloorなのでunboundedのままで0 / -1が出る。
  Typing / Checker / Soundness / Substitutionは無変更（ファミリ設計の2度目の回収）。
  Genにshl / shrを追加しgolden 300本を再生成（シフト11件混入、判定の分布は不変）
- 突き合わせの対: examples/shift.sober(.out) ↔ Examples.leanのシフト節（同ケース・同期待値、
  n = 0 / 63 / 64 / 100と負数の被演算子）+ 負の量のpanic（exShlNeg）
- Zig: エンコーダに `shl r, cl` / `sar r, cl`（D3 /4・/7、GNU asオラクル込み）。
  codegenはcmpで負 → rt_panic（exit 101）、> 63 → shlは0・sarは量を63に畳んでからx86シフト。
  脱糖は `<<` / `>>` / `<<=` / `>>=` → shl / shr。loaderのconst畳み込みも同じ場合分け
  （負の量はconstの段階でロードエラー — Goのコンパイルエラーと同じ）
- 約束はaddと同じ「値が64bitに収まる限り一致」: `1 << 63` はx86でminInt、Leanは2^63（突き合わせ外）

### 定数パターン・多subject switchの脱糖（2026-09-19完了）— 第二弾の段階2

コア・証明・JSONは一切変更なし — eqが入ったのでZig脱糖器（constSwitch）だけで
落ちる段階。examples/switch.sober（subject無し / 単値 / 複数subject・`1 | 2`・`_`・
裸識別子束縛）が実行とcheckの両方に通る。

- 脱糖の形: subjectを宣言順にletEで1回ずつ評価 → caseを後ろからiteに畳む。
  caseの条件は「位置ごとの選択肢or連鎖（ite脱糖 = 左から短絡）」のand連鎖。
  codegenの評価順（subject先行・選択肢は一致するまで逐次評価）と一致
- `_` は条件なし（常に一致）、裸の未知の識別子はsubjectの値の束縛（syntax.md 9節。
  束縛だけのcase以降は不到達で消える）。subject無しは条件式をそのままiteの条件に
- default無しで全caseが外れたらunit: 値として使うと分岐の型が食い違って検査で落ちる
  （codegenはdefault無しの値switchで不定値を返し得るPhase 1の穴 — 検査側で拒否する形。
  実行と検査で受理がsplitする初のケースだが、拒否方向なので健全）
- 多値呼び出しを単一subjectに置く形（`switch g() { case 1, 2: … }`）を回収（2026-09-27、随時回収R4）:
  subjectが結果2個以上の名前付き関数の呼び出し（`g(...)` / `x |> g(...)`）なら、アリティを関数表の
  結果型から引き、呼び出しをletEで1回だけ評価 → 各成分を射影（fst / sndのチェーン）でsubjectに並べる。
  分解bind `x, y := g()` と同じ形で、codegenのevalMulti + spillと評価順が一致（呼び出し1回）。
  コア・証明・JSONは変更ゼロ。caseの項数 ≠ 結果の個数はdesugar（CoreFragment）/ codegen
  （PatternCountMismatch）の両方で拒否。名前付き関数以外（クロージャ・ラムダの多値呼び出し）は断片外のまま
- 型パターンswitch（unionSwitchに改名）は従来どおり。型パターンと定数パターンの
  混在はMalformed
- 裸識別子の判定はdesugar / codegenが同じ規則（isBindingPattern → ast.Pkg.hasTopName）。
  衝突禁止はloaderが先に保証する（2026-09-27、随時回収R1 — syntax.md決定13）

### ifnil / `T?` のソース対応（2026-09-19完了）— 第二弾の段階3

コア（ifnil / some / nil / Ty.opt）は段階1から証明済み — この段階はソース構文
`T?`・`nil`・`if x != nil` を実行（codegen）と検査（脱糖器）の両方に通す配管。
examples/opt.soberが実行とcheckの両方に通る。

- AST: TypeExprに `opt`、Exprに `nil` リテラル（識別子 `nil` はAST層で
  リテラル判定 — syntax.md 9節の裸識別子と同じ扱い）
- codegen（Phase 1型表の拡張）: `opt` = unionと同じ「ワード0 = タグ（0 nil / 1 some）、
  以降ペイロード」のアグリゲート。`nil` は値を出さない仮の型 `nil_` で流れ、期待型のある
  sink（return / 引数 / 代入 / フィールド値）のcoerceが実体化する。ペイロード型の値も
  同じcoerceがタグ1で包む（暗黙some — language.md 15節）。`x == nil` / `x != nil` は
  タグ検査。`if x != nil` は値のある分岐でxをペイロードのコピーに再束縛（flow typing。
  シャドーイング検査は意図的に迂回 — mutの絞り込みも再束縛はimmなので分岐内の再代入は
  Immutableで落ちる）
- 脱糖器の最小の型追跡を拡張: Bindingに核Ty（paramsは宣言から、`x := e` は
  computeTy — lit / var / call / composite / selector / 演算子 / block末尾のbottom-up。
  分からなければnull）。期待型がT? のsinkでnil → 注釈つき `nil t`、ペイロード型 →
  `some`、静的に決められないときはCoreFragmentで正直に拒否（型を静的に知る責務は
  Lean側 — 脱糖器はwrapの判定に必要な最小限だけ持つ）
- 双方向の最小形 = ifの分岐への期待型の押し込み: `return if c { 42 } else { nil }` の
  ため、期待型がT? のif式は分岐ごとにcoerce（codegenのexprExpecting / 脱糖器の
  coerceArm。分岐は単一式のみ — それ以外は静的計算に任せて決められなければ拒否）。
  switchの分岐への押し込みは必要になったら
- `if v != nil { return v }` の早期returnは依然断片外（returnは末尾のみ —
  break / continueと同じグループ）。idiomは `return if v != nil { v } else { 0 }` で書く。
  早期returnの脱糖（継続のCPS化or iteの入れ子への正規化）はregion出口の段階で一緒に
  （→ 2026-09-27回収: コアのlabel / jumpで — 「label / jumpの段階」V4-3）
- Lean / JSON / 証明は一切変更なし（opt / ifnil / some / nilは段階1の語彙のまま）

### slice / stringの段階（2026-09-19完了）— 第二弾の段階5

language.md 21節の決定（slice + string先行・`xs[i]` はpanic（当時は暫定、2026-09-27にlanguage.md 27節で確定）・appendは
「bump先端一致ならin-place、他はregion先端へ全コピー」・cap廃止・stringリテラルは
rodata = 最外region）の実装。`lake build` 緑、sorryなし、公理はpropext / Quot.soundのみ。
examples/slice.soberが実行とcheckの両方に通る。

- Lean（コミット「sliceの段階（Lean側）」）: `Ty.slice m r t` はrefの一般化
  （regionsBelow / mutFree同型）。式はmkslice / index / lenE / append / setidx +
  freezeのslice規則（freezes）。実行時値 `slicev mt r base len` はタグ持ちヘッダで、
  型付けはloc規則の範囲版（per-cell量化 — 空sliceのbaseは無意味な値でよい、
  これでStoreLEの強化なしにstore_monoが通る）。
  - 発見1: slicevには `(mt = false → t.mutFree)` がmと独立に要る。
    m = trueのsliceが凍結済みのコピー（mt = false）を持ち得て、そのappendが
    immタグのセルを書く — immMutFree不変条件の下限はヘッダ側のタグに掛かる
  - 発見2: `omega` で矛盾から任意ゴールを閉じるとClassical.choiceが公理に混ざる
    （False経由の導出）。`exact absurd h (Nat.not_lt_zero _)` で回避
  - heapOkの新補題: heapOk_append1（任意regionの末尾1セル — heapOk_allocの一般化）、
    heapOk_append_copy（コピーのプレフィクスを1セル版の帰納で畳む）、
    heapOk_freezeRange（単セルfreezeの帰納）。appendの前提 `b ≤ r` が
    step_shared_stable（共有プレフィクス安定）をそのまま延ばす
- codegen: regionアリーナ = mmap（MAP_FIXED | NORESERVEの遅延ページ）に
  深度ごとの固定スロット。METAに現在深度と深度別bump。関数プロローグ / ブロック式が
  regionを開閉し、break / continue / returnの飛び越えは深度スロットの退避・復元で受ける
  （whileはループ頭と出口で復元）。sliceヘッダは (ptr, len, depth) の3ワードのアグリゲート。
  appendはLeanと同じ「先端1セル / 全コピー」の分岐（エイリアス経由の観測が一致）。
  境界検査は符号なし比較1回（負の添字も範囲外もjae → panic = exit(101)）。
  stringリテラルはコード末尾の8 byte/文字セル列（rodata相当）を指すimmヘッダ、
  depth 0 = 最外region。println(string) はセルごとにprint_char（→ 2026-09-27 io-4で行バッファに積む形。
  スロットは1MB → 64MB → 実行時可変（既定4GiB — 2026-09-28）、bumpの前進に上限検査 = exit 102 — language.md 27節・io-0）。
  mmapの命令列（r10/r8/r9は生エンコード）はオラクルにケース追加
- 脱糖器: `[]T{…}` → mkslice + append連鎖、文字列リテラル → freeze(append連鎖)
  （「mutで構築して不変化」のコア形 — codegenのrodataと観測同値）、`xs[i]` → index、
  `xs[i] = v` → setidx、len / appendは組み込み呼び出しの横取り。
  slice型は関数境界を渡れない（loc-free — 第一弾の決定のまま。`[]T` のregion添字は
  使用文脈依存なので型注釈としても断片外。stringはr = 0で注釈可能）
- 断片外・残課題: structフィールドのslice（region添字が宣言に書けない — 検査側のみ拒否、
  codegenは通る）、`<<` / `>>` と同じくスライス式 `xs[a:b]`、stringの比較・連結演算子、
  map（第三弾）。panicの正式な決定（`T?` 返しへの置き換え）はlanguage.md未決のまま

### 名前解決の最小形（2026-09-19完了）— 第二弾の段階4

language.md 20節の決定（単一モジュール・ルート相対import・package名 = ディレクトリ名・
公開 = 大文字・循環禁止・全ソース一括）の実装。Lean / JSON / 証明は一切変更なし —
名前解決は脱糖で消え、コアは関数indexとde Bruijnの世界のまま。testdata/pkgdemoが
実行とcheckの両方に通る（横断の関数・型・const・修飾composite / パターン・alias）。

- loader.zig（新設）: ディスクIO（load）と結合（link）を分離 — テストはlinkに
  ソースを直接渡す。import収集はASTが要るので「linkが返す未ロードimportを読み足しては
  linkし直す」反復。package名 = ディレクトリ名検査・循環検出（DFS）・トップレベルconstの
  畳み込み（決定14のconst式: intリテラル・算術・ビット・const参照。ここで値に確定し、
  下流は `.lit` を見るだけ）
- 参照はフラットキー "pkg_path.Name": desugar / codegenとも宣言を修飾キーで登録し、
  「現在package（cur_pkg）+ import表」で解決する。修飾名はAST上ドット付き文字列
  （TypeExprのswitchを増やさない）。可視性（大文字）は修飾参照の解決点で検査
- 本体の名前解決の文脈は「書かれた場所」: 関数本体は自分のpackage、inline展開の本体は
  calleeのpackage、ラムダは定義時のpackage（Closureにpkgを凍結 — Viewのチェーンの凍結と
  同じ規律のpackage版）。フィールド型の解決は宣言側package（DeclRef = decl + pkgを
  Binding / declOf* にスレッド）
- 断片外のまま: main packageをimportする形（キー "main.*" は到達不能）、
  修飾名の型引数・メソッド類。~~診断はファイル横断でtok番号のみに退化~~ → 回収（2026-09-27、随時回収R5）:
  座標はPos = 全ソース通しのトークン番号1ワード（src/stage1/srcpos.zigが唯一の定義）。loaderがparse順に
  各ファイルへbase（それまでの総トークン数）を割り当て、cst_to_astがASTのtokにbaseを焼き込む。
  Program.srcmap（ファイル表 = path・source・base・トークン開始バイト）がPos → path:line:colを解決し、
  loader / desugar / codegenのDiagはPosだけを運ぶ。表示は `path:line:col: error: what (Err)`。
  棄てた案: ノードごとに {file id, tok} の組（ASTのtokフィールド35箇所と全層の受け渡しが倍になり、
  V4のerror値に載せる座標も2ワードになる）。構文エラーはPEGの最遠失敗トークンを位置にする

### mapの段階（2026-09-19完了）— 第三弾

language.md 22節の決定（`m[k] : V?`・immデフォルト + `mut` 前置・`freeze(x)` builtin・
全コピー成長・値ヘッダ・挿入順）の実装。`lake build` 緑、sorryなし、公理は
propext / Quot.soundのみ。examples/map.soberが実行とcheckの両方に通る。
ベンチ92ms/run維持、corevec golden 300本一致。

- Lean: `Ty.map m r t` はsliceと同型の値ヘッダ（`mapv mt r base len`）、セルは
  `prod int (opt t)`（none = 墓石 — deleteの実体）。意味論は挿入列の連想モデル:
  findKey（先頭一致。entryKeyを分離すると証明可能な形になる — 入れ子パターンの
  matchを仮説でsplitすると場合が分かれる）+ countLive（lenm = 生きた数）。
  setは既存キーin-place（タグ検査 → 凍結済みpanic）、新規キーはappendと同じ
  「先端1セル / 全コピー」。getm / delmは不在・墓石のnil構築のためt注釈持ち。
  証明はsliceの完全な鏡 — セル型prod int (opt t) のmutFree / regionsBelowが
  tのそれと同値なので、canonical_map / StackTy 9フレーム / preservation / progress /
  step_shared_stable / heapOk補題（append1 / append_copy / freezeRange）が
  そのまま流用できた。Checker（freezem込み）+ JSON（"mkmap"/"getm"/"setm"/"delm"/
  "lenm"、Ty "map"）+ Examples ex25-27
- 極性反転（Zig）: `[]T` / `map[K]V` = imm、`mut` 前置が可変。リテラルは
  mut構築 + freeze（stringと同じコア形）。grammarはtype / composite_litに
  'mut'?、非コンテナへのmutはAST層で拒否。`freeze(x)` は脱糖 = CExpr.freeze、
  codegen = 型レベルの不変化のみ（実行時タグの物理表現は未決のまま）
- 脱糖: maplit → mkmap + setm連鎖（重複キーは後勝ち）、`m[k]` → getm（V? が
  ifnilにそのまま乗る — 第二弾の段階3の回収）、`m[k] = v` → mut束縛への再代入
  `m = setm(m, k, v)`（成長でヘッダが変わるため）、delete → delm、len → lenm。
  ルーティングはcomputeTyのmap判定（maplit / index / freezeの型を追加）
- codegen: ヘッダ3ワード（sliceと同型）、セル [key][tag][value]。findは先頭一致の
  線形走査、setはin-place / 先端 / 全コピーの3分岐、lenはtagの合計 —
  Leanのopと同じアルゴリズムを構成的に踏む（脱糖器の規律の帰結。ハッシュ化は
  観測同値な最適化として将来 — 性能は最適化器へ）
- 断片外・残課題: mapの関数境界越え（loc-freeのまま）、~~int以外のキー~~（stringは回収 —
  下の「stringキーのmap」。他の構造的等価キーはshapeの設計と絡む）、イテレーション（Phase 3のIterと一緒。
  挿入順の意味論は22節で予約済み）、実行時タグの物理表現（凍結後書き込みpanicの
  動的検査 — codegenは静的型のみで拒否、check側はLeanが受ける）

### stringキーのmap（2026-09-27完了）— 随時回収R3

決定 = B': キー型はsliceの要素型と同じく具体的なregion添字を持つ普通の型（`map[string]V` ≅
`[]string` と同型の形）。region多相は先食いしない。キーの制限（int | imm string）はmkmapの型規則だけ。
棄てた案: (A) キーregion = mapのregionに固定（relocRでmapのrをクランプするとキーも動き `[]string` と非対称）、
挿入時にキーをmap regionへコピー（キーのバイトがセル列の先端を塞ぎ毎回全コピー = O(n²)）、
(C) 別コンストラクタsmap（mapの証明の鏡の複製）。

- 表現: `Ty.map m r c` のcをセル型に読み替えた（mkmapが作るのは `prod k (opt v)`）。
  B' の意味（キー型index）をセル型に畳んだ形で、SyntaxのTy上の再帰関数（regionsBelow / mutFree /
  shiftR / relocR / sub / tsubst …）は1行も変わらない — mapvはslicevと完全に同型になった。
  JSONは `{"k":"map","m","r","key":K,"t":V}`（セル型がprod K (opt V) 以外のときだけ "cell"）
- 型規則: mkmapに `k.keyOk`（int | `slice false _ int`）。getm / delmの探索キーは
  `kq.keyCompat kt`（同種ならregionを問わない — 探索は格納しないのでescapeが無い、eqsと同じ方針）。
  setmの格納キーはキー型そのもの（脱糖器がannで上界へ緩める）— 内側scopeで作ったキーを外側の
  mapに積むとsubが通らず拒否（`[]string` へのappendと同じ制約。了承済みの帰結）
- 機械: `keyEq H`（litは値、slicevは長さ + eqCellsでバイト列比較 — eqsの1 step比較と同形）、
  `findKey H ρ base k`（H依存化）、`entryKey` は `Option Expr`。getm / setm / delmは任意のキー値で発火し、
  progressからcanonical_intが消えた。findKey_someは「セルはpair ke w形」を返す
- 証明: 想定外の場合分けなし。セル型の置換（prod int (opt t) → prod kt (opt t)）と、新規キーセルの型付けに
  value_strengthenを1本足しただけ（vと同じ扱い）。keyOk / keyCompatのshiftR・tsubst保存補題4本
- Zig: desugarのTy.mapにk、mapKeyTy（int | string以外はCoreFragment）、mapKey（stringキーはann）。
  codegenのセルは `[key(1 or 3 語)][tag][value]`、探索はstringなら長さ + ワードごとの比較ループ
  （LeanのkeyEqと同じ比較を構成的に踏む）。キーのバイト列は共有（コピーしない — Goと同じ）
- 突き合わせ: examples/map_str.sober(.out) ↔ Examples ex25s（同じ綴りの別リテラルで命中・不在nil・len、
  boolキーのmkmap拒否、intでstringキーを引く拒否）。corevecはジェネレータがmapを作らないので不変
- 既知のsplit（拒否方向で健全）: 内側scopeのキーを外側mapに格納する形はcheckが落とすがcodegenは通す
  （escape検査はcheckの仕事 — `[]string` のappendと同じ現状）

### keysmの段階（2026-09-28完了）— mapのキー列挙

language.md 22節の列挙の決定（`keys(m)`・挿入順 = 初回挿入の順・最内region・スナップショット — 決定2026-09-28）の実装。
`lake build` 緑、sorryなし、公理はpropext / Quot.soundのみ。examples/map_keys.soberが実行（正規・LLVMの両経路）とcheckの両方に通る。
corevec golden 300本一致（Genは据え置き — 回収点はparallel形式化の直前の総追いつき）。

- Lean: `Expr.keysm e` 1つ。型規則はconcatのコピー: 深さd + 1で `e : map m r (prod kt (opt t))`・`kt.keyOk`・`kt.regionsBelow (d + 1)`・`b ≤ d` ⇒
  `slice false d kt`（最内regionのimm slice）。機械はlenmの隣に `liveKeys ρ base len`（countLiveと同じ走査で `pair ke (some _)` のキーを集める — 墓石スキップ）を足し、
  `H.set (H.length - 1) (ρi ++ ks.map (false, ·))` + `slicev false (H.length - 1) ρi.length ks.length`（concatと同じ最内regionへの追加）。
  スナップショット性は構成から出る（キーの値を新しいセルへコピーする — 以後のsetm / delmはmapのregionのセルだけを書く）
- 証明: 新しい補題は `mem_liveKeys`（列の要素は覆う範囲の生きたセルのキー）・`liveKeys_typed`（そのキーはtake (rr + 1) でktに型付く:
  HeapOk.typed → sub_prod_invR → canonical_prod → value_coerce。keyOk ⇒ annFreeでcoerceToが恒等になるので機械は型注釈を持たない）・`keyOk_mutFree` / `keyOk_annFree` だけ。
  セルの追加は既存の `heapOk_append_list`（深いrelocateの部品 — 全セルimm・同型t）がそのまま使え、preservationのkeysmKはconcatのcatRの半分ほどで閉じた。
  progress・step_shared_stable（take b不変）はconcatと同形。Ren / TSubst / Substitution / Splitはlenmとmkmapの前提（keyOk / regionsBelow / b ≤ d）の組み合わせで機械的。
  想定外の場合分けなし。keyOkを型規則に置いた理由: mapvの型付けはkeyOkを運ばない（課すのはmkmapだけ）ので、新しいセルのimmMutFreeと注釈不要性をkeysm側で要求する
- Checker / JSON: typecheckはconcatと同じ「深さ0はnone・d' + 1でkeyOk && regionsBelow && b ≤ d'」。JSON `{"k":"keysm","e":E}`。
  突き合わせ: examples/map_keys.sober(.out) ↔ Examples ex27k（挿入3・1・2 → delete 1 → 再挿入1 → 4 → keys → delete 3の重みつき和 = 43124 —
  再挿入の位置とスナップショットをrflで固定）
- 脱糖（Zig + Sober）: `keys(m)` → keysm（computeTy = 最内regionのimm slice、要素 = キー型）。`for k <- m` はforexpandの生成元の種類（slice / map / closure）で
  `iter#.Slice(keys(src), k)` へ — 脱糖器はループを合成しない（std/iter.Sliceが添字ループ — 脱糖器の規律・F1のまま）。forの型推論（forIterTy）もmapの生成元でキー型を束縛
- lower（Zig + Sober）: keysはLeanのliveKeysを構成的に踏む — mapLenで生きた数を数え、現在の深度にn × キーのワード数を取り、セル列を走査してtag ≠ 0のキーのワードをコピー。
  ランタイム関数は足さない（既存の全 .ll / .irのゴールデンのrt部分を動かさない — ゴールデンの差分は新規のmap_keys 4本だけ）。forの生成元の型は試し生成 + rollbackで取る（forIterTypeと同じ方式）
- @embedの一覧（selfhostのR35-2の回収）: loaderのLoadFsはstdのpackageのファイル一覧を `keys(sm)`（焼き込みの表のキー）から引く（dirname一致 + `.sober`、バイト順の挿入ソート）。
  暫定のReadDirを撤去 — stage2はcwdのstd/ に依存しない（stages.shのhermeticの行: std/ の無いcwdでstdをimportするプログラムをbuild / check、.llはZig版と一致）
- 断片外・保留: `for k, v <- m`（多名束縛 + `V?` の剥がしの約束）、Genのkeysm（総追いつき）、再束縛不可の機械的な強制（len / freezeも含めて名前の照合だけ — 実装の穴）

### call同世界化の段階（round4 = selfhost検証V1。着手2026-09-19、設計下書き）

決定（2026-09-19、ユーザー）: callの入れ子世界（par同型の単騎）は同世界化で置き換える。
棄てた案: 併存（入れ子callを残し段階3dのsnapshot機構をcallに流用）— 引数は
value_export/importが延びるが、戻り値の新規割り当て（ミニlexerのトークンslice）が
入れ子ヒープごと死ぬ。持ち帰り = ヒープ融合 + region再番号付け = 世界間で同世界化を
やる羽目になり、最初から同世界の方が軽い。rc（共有上界）も呼び出し深度依存で、chanが
parch（生成 = spawn融合)で逃げた問題をcallは逃げられない。codegenは既に同世界
（単一regionスタック、関数プロローグがregion開閉）なので機械と形式化のズレ解消でもある。
移行は新旧併存で例を移してから旧callを消す段取り（証明資産の保険）。

設計の核（実装前の下書き。証明が反証したら本節を更新）:

1. imm参照のregion添字を「正確な位置」から「上界」に読み替える
   （`ref false r t` / `slice false r t` / `map false r t` = 「actual ≤ rのどこか」。
   loc規則のimm側が存在形 `∃ r' ≤ r` になり、緩める向きのサブタイピングが挿入で入る。
   mutは正確なまま — assign / appendの書き込み先は揺らせない）。
   regionsBelow（escape検査）・allocの格納の下限・block出口は上界に対してそのまま健全
   （actual ≤ 上界 < dがeffectを含意）。これがこの段階の一枚目の壁の解:
   - 棄てた案 (a) region消去型 ◇（新コンストラクタ「呼び手空間のどこか」）—
     セル格納で破綻: ◇ 内容のセルはHeapOkの「セルは Ψ.take (r+1) で型付く」に乗らず、
     トークンが入力stringの部分sliceを持つ形（V1の必須ケース）が書けない
   - 棄てた案 (b) region多相（シグネチャにregion変数 + callでinstantiate）—
     上界の緩みがスラックを吸収するので変数1本すら不要。重い置換機構が丸ごと浮く
     （2026-09-27訂正: immに限った議論で、mutの不変性には当てはまらなかった — R2のanchorが「変数1本」を暗黙のまま
     呼び手に選ばせる形。language.md 31節）
2. Defは基底1で一度だけ型付けし、callが一様シフトでinstantiate:
   DefsOk' = param / retの上界regionsBelow 1（従来のloc-free「0」が「1」になるだけ）+
   本体をbase 1・Γ = [param] で型付け。呼び出し（呼び手深さd）は全region添字を
   +dシフト — 上界だからrodata@0 → @dも健全（0 ≤ d、緩めるだけ）。二クラス問題
   （固定rodataと呼び手空間の混在）が消える。ソース項は型注釈（nil / mkslice / getm /
   delm / inl / inr / newchan）にregionを含むため、シフトは型だけでなく
   本体項の注釈にも掛かる（`Expr.shiftTy ρ` — 機械がcallst生成時に適用。純機械的）。
   証明の山 = シフト定理「base 1で型付く本体は +ρ シフトでbase ρ+1でも型付く」
   （ソース項 = loc/slicev/mapv/chanVを含まない項に限定。parを含む本体で成立するかが核）
3. call = 同世界のregion push + 戻り値の境界コピー: 引数評価 → 呼び手と同じH・S上で
   regionをpush（深さd+1）してシフト済み本体を評価 → 戻り値のヘッダが自フレーム
   （region d+1）なら呼び手region dへ最上位セルだけ浅コピーしてpop。
   下限は「中身の上界 ≤ d」= ret.regionsBelow 1のシフトが構成的に保証（トークンの
   stringフィールドは引数空間 ≤ dなのでヘッダごとコピーで生きる。[][]intの全callee
   構築は弾かれる — 深いコピーはstd / 後続）。block出口は従来どおりコピーなし
   （21節「境界コピー = 明示イディオム」と整合。自動コピーは関数境界のみ）
   → 2026-09-27改訂: 深いコピー（R4a）・脱出（R4b α）・ブロックの出口（R5）の全部で境界コピーする —
   「regionを持つ型の境界越えの段階」
4. V1の断片外: mut引数（immデフォルトの極性と整合）、戻り値の深い持ち帰り、
   region注釈つきシグネチャ。検証例 = ミニlexer（string → トークンslice・struct
   トークン・関数分割 — 呼び手フレームで構築したsliceを次の関数へ渡す形を含む）

攻める順: (1) imm上界化（loc規則と挿入補題 — 単独で既存全証明を回す）→
(2) シフト定理 → (3) 機械のcall差し替え + 境界コピー（heapOk_append_copyが原型）→
(4) preservation / progressの組み直し → (5) 脱糖器・codegen（関数境界のslice解禁）。

(1) imm上界化done（2026-09-19）: `lake build` 緑、sorryなし、公理は
propext / Quot.soundのみ（par_step_commuteはpropextのみ）。zig build test全緑、
corevec golden 300本一致、examples/slice.sober・map.soberは実行とcheckの両方に通る。

- loc / slicev / mapvの型region rtは上界（`r ≤ rt`、mutは `rt = r ∧ b ≤ r` の
  連言で正確なまま）。canonical formは「∃ 実region r ≤ rt」の存在形に
- slicev / mapvのタグを `mt = m` に強化（旧: m = false → mt = falseの片向き）。
  機械のappendがmtでmut / immを判別して書き込み先を選ぶため、型のmと実行時タグが
  一致していないと書き込み先と型がズレる。発見1（m=true ∧ mt=false）のpremiseは
  mt = mに吸収されて消えた
- appendの型規則をappendM / appendIに分割: mutはヘッダregion r（正確、b ≤ r）の
  先端一致in-place / コピー（従来どおり）。immは現在の最内regionへ常に全コピー
  （b ≤ d。上界型では実regionにb ≤ rを静的に言えないため、書き込み先を自フレームに
  固定して健全化 — 21節「現在のregionへコピー」の字義どおり化。immはセル不変なので
  コピーは観測不能）。typecheckはsubjectのmで分岐（構文主導のまま）。
  棄てた案: append mut限定 — slice.soberの `append(xs, 4)`（xsはimmデフォルト）が
  ソースレベルで壊れる
- 新補助: `Ty.regionsBelow_mono`（上界緩めは常に健全）、`storeLE_take_le` /
  `storePre_take_le`（プレフィクス同士の輸送）、`heapOk_append_copy_cross`
  （跨regionコピー — imm appendのsource ≠ target用。セル値の型付けは
  take (rs+1) → take (k+1) をプレフィクス包含で運ぶ）。StackTyのappL / appRは
  結果region rr持ち（mut: rr = r、imm: d = rr + 1 ∧ b ≤ rr）
- 残課題（(5) で回収）: Zig codegenのimm appendはまだヘッダregion先端に書く
  （Leanは最内region）。現行言語では観測不能（immセルは不変・region寿命の観測手段が
  ない）だが、call同世界化でregionがpopし始めるとplacementが寿命に効く —
  脱糖器の規律どおりcodegenをLeanに揃えること
(2) 下準備done（2026-09-19）— シフト・部分型・coerceの土台（`lake build` 緑）:

- `Ty.shiftR ρ`（全region添字 +ρ）+ zero / comp / regionsBelow / mutFreeの可換補題。
  `Expr.shiftTy ρ` は項の型注釈（nil / inl / inr / mkslice / getm / delm / mkmap /
  newchan / parch）と実行時項のregion添字に掛かる
- `Ty.sub`（V1 = 浅いimm共変）: immコンテナ / 参照のregion上界だけ緩め、
  要素型は正確なまま。値ラッパ（opt / union / prod）へは分配、mut / chanは不変。
  棄てた案: 深い共変 — セル型付けが要素型を正確に固定するため「セルsub」が要る
  （後続の梯子）。実用上は「calleeが注釈を緩い型で書けば、値は (1) のslackで
  緩い型に正確に型付く」ので、深い共変が要るのは値が別の緩さで再輸出されるときだけ
- 注釈値の座標問題とcoerceTo: nil / inl / inrは型注釈を持つ値なので、緩めた型では
  型が付かない（規則を緩めると型の一意性 = checkerの完全性が壊れる）。
  解: 機械がcall時に引数へ `Expr.coerceTo`（注釈だけの構造ウォーク）を掛け、
  `value_coerce`（v : ta ∧ sub ta tb → coerceTo tb v : tb）が境界を渡す。
  注釈は実行時表現を持たないのでcodegenではゼロコスト（恒等）
- 確定したcallの形（実装は次）: DefsOk' = 本体をbase（region 0 = 圧縮された呼び手
  空間、1 = 自フレーム）で `f = b = 1, d = 2, Γ = [param]` により一度型付け。
  param.regionsBelow 1 ∧ mutFree（V1 = imm引数）、retは最上位のみ自フレーム可。
  call規則はalloc同型の (d+1) 形で ρ = d:
  `Δ[fn] = dfn → e : ta → sub ta (param.shiftR d) → call fn e : ret.shiftR d`。
  機械はcallK → region push + coerceTo + 本体shiftTy ρ + subst → fretK（返りの
  境界コピー = 構造relocate + region pop）

(2)(3)(4) done（2026-09-19同日）— シフト定理・call差し替え・機械・全証明:
`lake build` 全緑、sorryなし、公理はpropext / Quot.soundのみ（soundness / progress /
shift_typing / relocate_okとも）。zig test全緑、corevec 300本一致、
fib / multi / slice / mapのcheckが脱糖器変更ゼロで通る（本体のblock包みが
新base（f = b = 1, d = 2）にそのまま適合し、mainのblock包みが「callは深さ1以上」を
満たすため）。ベンチ155ms/run（Leanバイナリ肥大分。大半は起動）。

- シフト定理（Shift.lean）: 空 Ξ・空 Ψ で型付くソース項は、世界（f / b / d / Γ /
  型 / 項注釈）を同じ ρ でずらしても型付く。空ストアでも「空sliceヘッダ」には型が
  付く（セルpremiseが空虚）ので、実行時項のケースは反証でなく再構築
- call規則: `Δ[fn] = dfn → e : ta → sub ta (param.shiftR d) → b ≤ d →
  call fn e : ret.shiftR d`（conclusionはd + 1のalloc同型）。
  `b ≤ d` は証明が要求した追加の決定 — 戻りのrelocateが呼び手フレーム
  （region d）に書くため、共有regionの直上では呼べない（タスクはblockを開いてから）
- DefsOk': paramOk（regionsBelow 1 ∧ mutFree ∧ chanFree — 2026-11-10以降のchanFreeはargFree〔domainを通す〕）・retOk（最上位imm
  コンテナは自フレーム可・中身は呼び手空間・mut / chan不可）・noNewchan・
  本体はf = b = 1, d = 2で一度型付け
- f / bの引き下げが非対称（発見）: 本体はシフトでb = f = フレームの世界に立つが、
  実行時のタスク境界はそれより低い。bは常に `b ≤ X` でしか使われないので無条件に
  下げられる（b_lower）。fはnewchan / chanVの `rc ≤ f` が壊れるので、bare newchanを
  含まない項に限って下げる（f_lower + noNewchan）。parchはf制約を持たないので
  関数内の並列は断片内に残る — 生成 = spawn融合（段階3d）の利点がここでも生きた
- 機械: callst（入れ子世界）を全削除。call = region push + coerceTo（引数の注釈
  書き換え）+ 本体shiftTy + subst、fretK = relocate（境界コピー: ヘッダ / locの
  frameセルを呼び手最内へコピーする構造ウォーク、値ラッパへ分配）+ region pop。
  shiftTy / coerceTo / relocateの型注釈操作はcodegenではゼロコスト（実行時表現なし）
- relocate_ok（境界コピーの保存）: retOkなt0のshiftR dの値はrelocateが必ず
  成功し、region dだけが伸び（take d不変）、pop後の世界で同じ型に型付く —
  「immの上界だからコピーしても型が変わらない」が (1) の回収。跨regionコピーは
  heapOk_reloc_copy（sourceがtargetより上でも、内容型の下限をpremiseで受ければ通る）
- 残課題 → (5): 脱糖器のloc-free制限解除（slice / string引数・戻り値の型注釈）、
  codegenの呼び出し規約（フレームregion + 境界コピー + imm appendの最内化）、
  検証例 = ミニlexer

(5) 実地done（2026-09-19）— 脱糖器の境界解禁・codegenのrelocate・ミニlexer:
zig build test全緑、corevec 300本一致、ベンチ82ms/run。
examples/lexer.sober（string → トークンslice・structトークン・関数分割）が実行と
checkの両方に通る。既存examples（fib / multi / slice / map / opt / switch / bits）も
実行・checkとも回帰なし。

- 脱糖器の座標規約（V1の決定）: 署名の `[]T` / `map[K]V` はr = 0（呼び手空間の
  上界）、戻り値の最上位のslice / mapだけr = 1（自フレーム） に付け替える。
  checkDefsは `typecheck body == ret` の厳密一致（subはcall引数のみ）なので、
  最上位 = 「本体で新規構築して返す形」（mkslice → freezeがr = 1を合成）、
  フィールド・入れ子 = 「引数由来のデータの持ち場」（r = 0のまま）と役割を固定した。
  帰結の断片外: 呼び手空間の値をそのまま返す転送（`return s`）、call結果の再転送
  （`return g()` のslice版 — ret.shiftRがr ≥ 2を合成する）、fresh構築のsliceを
  フィールドに持つstructのreturn。V1のミニlexerはどれも要らない
- def本体のblock包みを廃止: 本体はbase d = 2で直に型付ける。自フレーム =
  callがpushするregion 1にmkslice / allocが乗り、retOk（最上位r < 2）と
  fretKのrelocateに揃う。blockで包むと構築がregion 2に落ちregionsBelow 2で
  返せない。allocはd = 2で直に型が付くので包みは不要だった
- codegenのrelocate（epilogueの深度復元より前）: 結果スロット内のslice / map
  ヘッダのdepthが「呼び手最内（fn_depth_slotの退避値）より深い」なら、セルを
  呼び手最内のbump先端へコピーし、ヘッダを付け替える。structは静的オフセットで分配、
  opt / unionの中のslice / mapはUnsupported（タグ依存レイアウトはV1断片外）。
  罠: fn_depth_slotはregion enter前の深度 = フレーム深度 - 1 — 比較は
  `hdr.depth ≤ 退避値 → そのまま`、書き先も退避値のregion（初版は1レベルズレてsegfault）
- imm appendの最内化: codegenのappendCallをmtで分岐 — mut = ヘッダregionで
  先端伸長or全コピー（従来）、imm = 現在の最内regionへ常に全コピー（(1) の残課題
  回収。LeanのappendIと同型、新ヘッダのdepthはMETA[0]）
- 運用の罠: sober-checkバイナリがlean/ ソースより古いと全defが "def error" になる
  （round4でdefsのbaseが変わったため）。手計算が合うのに落ちたらまず `lake build`

残課題 → 後続: ~~早期returnの脱糖~~（done 2026-09-27、「label / jumpの段階」V4-3）、~~mut引数~~（V3-5・R2）・~~戻り値の
深い持ち帰り~~（R4a）・region注釈つきシグネチャ（V1断片外の主要な対象 — region多相は採用しない決定、language.md 31節）、~~opt / union内の
コンテナrelocate（タグ分岐のrelocate）~~（R0）、計算列のcomputeTyがcall結果のregionを
呼び手座標（ret.shiftR d）にしていない件（opt coerceの判定にしか使っていないので
現状無害 — 触るとき注意）。

- Leanの罠追記: `subst h`（h : a = b、両辺fvar）の消える側は一意でない —
  連鎖substの生き残り変数は当てにせず、エラーで確認して本文の変数名を合わせる。
  `split at hs` がDecidable.recで落ちるiteは `by_cases + simp only [if_pos/if_neg]`。
  `fun h => nomatch h` をimplicit Boolのpremiseに渡すとunificationが
  h : false = false側になって "Missing cases: Eq.refl" — 補題側のmを `(m := true)` で
  明示してからnomatch

### call結果の再転送（2026-09-19完了）— round5の入口で回収したV1残課題

round5の検証例（ミニparser）が最初に遭遇した穴: `nodes, kids, root := parse(...)` の
結果を `eval(nodes, kids, root)` に渡すとcheckが落ちる（実行は通る）。原因はcall
規則の結果型 `ret.shiftR d` — fretKのrelocateは最上位を呼び手最内（region d）へ
コピーするのに、型はr = 1 + d（既にpopされたregion）を上界に持ち、引数位置の
Ty.sub（r ≤ param上界）を満たせない。既存例はcall結果をlen / indexでしか
使わなかったため潜伏していた（「例が仕様を反証する」の実例）。

決定: `Ty.relocR ρ` を新設し、callの結果型を `ret.relocR d` に差し替え。
relocRはshiftRと同じ一様シフトだが、最上位のimmコンテナ / 参照の上界だけ ρ に
クランプする（中身はshiftRのまま = セル型はrelocateで動かない。opt / unionの中身も
shiftRのまま — nil / inl / inrの型注釈は機械が書き換えないため。round4残課題
「opt / union内コンテナのrelocate」と同じ梯子に積む — R0で回収、「regionを持つ型の境界越えの段階」）。mut / chanはretOkが禁じるので
call結果には現れない（定義はshiftRと同じにして全域性だけ確保）。

- 核の補題2本、既存証明はほぼ無傷:
  - `Ty.relocR_shiftR_comp : (t.relocR ρ₁).shiftR ρ₂ = t.relocR (ρ₁ + ρ₂)` —
    シフト定理のcallケースがこれで閉じる（shiftR_compの置き換え1行）
  - `value_reloc_tighten`（Soundness）: 深さd + 1の世界でshiftR d t0に型付く値は
    relocR d t0にも型付く — 深さ制約（loc / slicev / mapvのr < 判定深さ）が
    実region ≤ dを既に保証しているのが証明の全て。canonicalで場合分けしてrtをdに
    差し替えて組み立て直すだけ（prodは再帰、値ラッパはrelocR = shiftRで恒等）
- relocate_okは無傷（結論はshiftRのまま）— preservationのfretKケースで
  tightenを1行挟む。StackTyはcallKの継続とfretKの出口をrelocRに
- 棄てた案: (a) relocate_okの結論をrelocRに強化 — optのnilケースで注釈型
  （機械が書き換えない）と衝突し、巨大証明の書き直しも発生。外付け補題が正。
  (b) relocRを深い変換（中身も ρ に）— セル型が Ψ の記録と一致しなくなりslicevの
  型付けが壊れる。浅いrelocateには浅いrelocR
- 変更ファイル: Syntax（relocR + comp補題）、Typing / Checker（callの結果型）、
  MachineTy（callK / fretK）、Shift（1行）、Soundness（tighten新設 + fret 1行）。
  機械（Machine.lean）とJSON境界は変更ゼロ、脱糖器・codegenも変更ゼロ
- 副産物の修正: Gen.leanのgenBaseにmapケースが欠けていた（第三弾でTyにmapを
  足したときの置き去り — corevec.shは古いバイナリで通っていた）。corevecはgolden
  不変で300本一致 + --binary照合OK
- ベンチ: 121〜141ms/runとばらつき大（前回記録82ms）。環境ノイズかrelocR起因かは
  未切り分け — 次に触るとき再計測

### string / sliceの演算3点（2026-09-19完了）— 随時回収の1本目、std/stringsの下回り

決定はlanguage.md 21節（比較 / 連結は `==` `!=` `+` の型分岐・[a:b] はimm限定）。
コアに3 opを証明ごと追加: `subslice e a b`（同セル列の新ヘッダ・割り当てゼロ・範囲violation
panic）、`eqs e1 e2`（intセル限定の長さ + 全セル等値 → bool。構造的等価の一般化は
Eq[T] 辞書の領分）、`concat e1 e2`（最内regionへ両セル列コピー — appendIと同じ下限b ≤ d）。

- 証明の要点: subslice / eqsはヒープ不変で軽い（subsliceのper-cellは範囲サブセットの
  添字算術、eqsはeqCellsが全域Boolなのでstuckしない — 等値の「意味」は証明対象外で
  Examplesのrflが突き合わせる）。concatはappendIの2段階のコピー版 —
  heapOk_append_copy(_cross) を2回適用し、同一regionソースではprefixのdrop-take
  安定補題（drop_take_append_left、新設）で1回目の伸長を越えてセル条件を運ぶ
- 機械: Kフレーム7種（subL/M/R・eqsL/R・catL/R）。eqsはセル列比較を1 stepで
  やる（findKeyと同じ「型付き状態では形が保証される」パターン）
- Zig: grammar `index <- '[' expression (':' expression)? ']'`、ASTにSlice3、
  脱糖はsubslice直行 + binaryのstring型分岐（computeTyがstringと分かるときだけ
  eqs / concatへ。`!=` はiteで反転）。codegenはslice3 = ヘッダ演算のみ、
  string == = バイト比較ループ、+ = 最内regionへ2連コピー
- 発見: computeTyに .slice3 / binary `+` のstring伝播が要る（無いと `t == u` が
  int cmpに脱糖されてLeanで落ちる — 型分岐は脱糖器の型追跡の精度に律速される）。
  mut [a:b] はcodegenがImmutableで拒否 + Leanはsubslice規則がslice false限定
- 突き合わせの対: examples/strings_ops.sober(.out) ↔ Examples ex28〜32（範囲違反panic・
  mut拒否 = typecheck none込み）。corevec 300一致 + --binary照合、公理propext/Quot.soundのみ

### boolのソース対応（2026-09-26完了）— マイルストーン1.5（std/stringsの前提）

決定はlanguage.md 23節。コア・証明・JSON・Genは変更ゼロ — `Ty.bool` / `tt` / `ff`、
cmp / lt / eqs → bool、ite / whileの条件boolは形式化の初期から入っていた。
穴はZigのソース層だけ（codegenが比較をintとして型付けし、checkと実行の受理が
食い違っていた — `func f() int { return a == b }` は実行が通りcheckで落ちていた）。

- Zig codegen: 型表に `bool_`（1ワード、0 / 1 — intと同じ置き方だが型は交わらない）。
  比較・nil判定・string比較・`&&` `||` `!` の結果をbool、条件は `requireBool`。
  定数パターンはint / bool subjectを受け、パターン型 = subject型を検査。
  printlnのboolは `true` / `false`
- 脱糖器: `true` / `false` → tt / ff、型名 `bool`。boolの `==` / `!=` はコアのcmp
  （int × int）に無いのでiteの形に落とす: `a == b` ⇒ `if a { b } else { !b }`、
  `!=` は分岐を入れ替え（a → bの評価順を保つ）。bool subjectのswitchも同じ形。
  形の変換のみで「脱糖器の規律」の範囲内。棄てた案: コアにbool cmpを追加 —
  ite形で表せるものにopを足すと証明の面積だけ増える
- 発見: パターン位置の `true` は裸識別子規則（syntax.md 9節）で束縛として読まれていた
  （`switch b { case true: … }` が常に最初の分岐に入る）。codegen / 脱糖器の両方で除外。
  同じ規則でトップレベルconst（`case Local:`）も束縛になる穴は別タスクに積んだ
- 突き合わせの対: examples/bool.sober(.out) ↔ Examples ex33（bool等値のite形）・
  ex34（`!` / `&&` のite脱糖）+ 否定例5本（bool + int・int条件if / while・
  `cmp eq tt ff`・bool / intの分岐混在 = typecheck none）。
  corevec 300一致（再生成なし）、公理propext / Quot.soundのみ

### stringの不透明化（2026-09-26完了）— 表面の改訂、コアは無変更

決定はlanguage.md 24節（21節の演算3点を改訂）。コア・証明・JSON・Gen・Examplesは
変更ゼロ — 不透明性はソース層の型の区別で、脱糖で消える。

- 型の区別: Zig codegenの `SliceInfo.str` / 脱糖器の `Ty.slice.str`。stringリテラルと
  型名 `string` がマークを持ち、freeze・戻り値座標（retTy）・computeTyで伝播する。
  JSONではマークを消して `slice false r int` として出す（コアから見て改訂前と同一の項）
- `bytes(s)`: 脱糖は恒等（形の変換のみ — 脱糖器の規律の範囲内）、codegenはヘッダを
  そのまま渡して型だけimm `[]int`（ゼロコスト。現ランタイムは1文字 = 1ワードのセルで、
  ビューと表現が一致している — バイト詰めにしたら要再考）
- 拒否: stringのlen / 添字 / `[a:b]` / appendはcodegen（TypeMismatch）と
  脱糖器（Malformed）の両方で。`==` `!=` `+` / printlnの文字列扱いはstrマークで判定
  （改訂前は「immかつ要素int」で判定しており `[]int{1} == []int{1}` がeqsとして
  通っていた — この穴も同時に塞がった）
- 段階分け: (1) 型の区別 → (2) `bytes` 導入 + examples書き換え → (3) 表面から外す。
  拒否を先にすると既存examplesが壊れた期間ができるので、この順にした
- 突き合わせ: examples/bytes_view.sober（slice引数のdefにビューを渡す形 — round4の
  座標規約r0に既存のlexerと同じ経路で乗る）が実行とcheckの両方に通る。
  lexer / parser_x / parser_y / slice / strings_opsはbytesビュー経由に書き換え、
  `.out` は不変（parserの `--mem-trace` 数値を含む）。
  strings_opsは部分列同士の比較（ビューに `==` が無い）をstring全体同士の比較に
  置き換えた — Examples ex28〜32はコア項の例なので無変更で有効

### 閉じた関数値の段階（2026-09-26完了）— V3の段階1

決定はD2（コアに閉じた関数値 + Defの型パラメータ）。捕捉クロージャ（D3）は入れない。

- 型 `Ty.fn p r`: p / rはDefのbase座標（region 0 = 呼び手空間、1 = 自フレーム）のまま
  持つ型スキーム。現在の世界のregionに言及しないのでloc-free・シフト不動（shiftR / relocRは
  恒等、regionsBelow / mutFree / chanFree / paramOk / retOkはtrue、subは等値）
- 値 `fnref i`: Def参照（環境なし）。`Δ[i]? = some dfn → fnref i : fn dfn.param dfn.ret`。
  shift / subst / relocateで不動
- callv: callと同形の規則（深さd+1、`sub ta (p.shiftR d)`、`b ≤ d` → `r.relocR d`）。
  機械はフレームcallvL / callvRでef → eの順に値にし、`callv (fnref i) v ⟶ call i v` の1歩で
  既存のcallに委譲（世界の機構は新設しない）
- 証明: `canonical_fn` を新設。preservation / progress / shift_typing / relocate_ok / value_* /
  typecheck_sound・completeの各ケースはcallの相似形かloc-freeの自明ケースで閉じた
  （範囲の決定 = 閉じた関数値のみ の利点）
- JSON: `{"k":"fn","p":T,"r":T}` / `{"k":"fnref","f":Nat}` / `{"k":"callv","f":E,"e":E}`
- 突き合わせ: Examples ex35（直接呼び出し）・ex36（辞書 = 関数値のpairのチェーン）・ex37（高階Def）+
  否定例6本。Genにベクタ共通の関数表（incr / isPos / apply）を足してcorevecを再生成

### 型パラメータの段階（2026-09-26完了）— V3の段階2

- `Ty.tvar i`（Defの型パラメータへの添字）、`Def.tparams`（既定0）。
  `call fn ts e` / `fnref fn ts`（ExprがList Tyを持つのはnested inductiveではないので、
  「callは1引数」の永久設計と衝突しない）。規則は `ts.length = tparams` と `Ty.tyArgsOk ts`
- 型引数の制限 = loc-freeかつchan-free（`tyArgOk = regionsBelow 0 && chanFree`。当初案の
  loc-freeだけでは `chan 0 t` が通ってしまうことに気づいてchanFreeを足した）。
  型代入がregion座標に触れないので、shiftR / relocRと可換、regionsBelow / mutFree / chanFree /
  sub / paramOk / retOkを保存する
- インスタンス化 = 仮想Def `dfn.inst ts`（param / ret / bodyに型代入）。callの規則・StackTyの
  callK・機械のcallKはこの単相のDefを通る。SoundnessのcallKはDefsOkの代わりに
  `defsOk_inst` を使うだけで閉じた
- 型代入定理（TSubst.lean）`tsubst_typing`: Ξ = Ψ = [] の型付けは型代入で保たれる
  （shift_typingと同じ土俵 — 手本にして1回で通った）。入れ子の型適用は代入の合成（`tsubst_comp`）で
  閉じ、そのためDefsOk / checkDefsにparam / retの `tvarsBelow tparams` を追加した
- パラメトリシティ: tvarに対する消去形は無い。tvar型の値は存在しない（relocate_okのtvarケースは空虚）
- JSON: `{"k":"tvar","i":Nat}`、call / fnrefの `"ts":[T...]` とDefの `"tparams"` は省略可
  （単相の出力と互換）
- 突き合わせ: Examples ex38（単一定義を2型で呼ぶ）・ex39（入れ子の型適用）・ex40（辞書渡しを2型で）+
  否定例6本（個数違い・型不一致・regionを持つ型引数・結果型の誤用・パラメトリシティ違反の本体・
  範囲外tvar）。Genにid[T] と型適用の生成を足してcorevecを再生成

### ジェネリクスのZig側の段階（2026-09-26完了）— V3の段階3

コア・証明・JSONスキーマは変更ゼロ（V3-1 / V3-2で用意済みの語彙にZigが乗る）。

- 3a関数値の土台: エンコーダに `call r64`（FF /2。GNU asオラクルに8レジスタ分）。codegenの
  関数値は1ワードのコードアドレス（`fnv`）で、名前付き関数の参照はリンク時に絶対アドレスを埋める。
  フィールド / ローカルの関数値の呼び出しは、既存の呼び出し規約のまま `call rax`。
  脱糖器は関数名 → fnref、関数値の呼び出し → callv（引数はpairのチェーン）
- 3bジェネリクス: 脱糖器はジェネリックDefを1本だけ出す（型環境 `T ↦ tvar i`）—
  Leanがtvarのまま一度だけ検査する。呼び出しの型引数は、プレースホルダtvarを使ったTy同士の
  構造的な単一化で推論する（region添字は無視 — 型引数はregionを持たない）。
  ジェネリックstructは使用点で型引数を束縛してフィールド列のprodのチェーンへ。
  codegenはインスタンス化ごとの単相コピー（引数を先に評価して型を得る → 単一化 → `f[キー]` を
  登録し本体を遅延コンパイル）。ジェネリックstructもインスタンスごとにレイアウト
- 3c辞書のラムダ: 関数値が期待される位置のラムダを匿名Def（脱糖器 = 関数表の末尾、
  codegen = 匿名関数の遅延コンパイル）へ持ち上げる。外側の束縛を参照したら拒否。
  ジェネリック本体の中のラムダは型パラメータを引き継ぎ、fnrefに同じtvarを型引数として渡す
- 脱糖器の規律の自己点検: 型の具体化（ジェネリックstruct → prodのチェーン）とラムダの持ち上げは、
  どちらも入力データに依存しない固定の変換（形の変換）。ジェネリック本体を型ごとに複製する形は
  脱糖器に持たせず、codegen（特化 = 最適化の先取り）に置いた — 判定基準「テンプレートの多段化は
  コアへ」に沿って、検査はコアの型パラメータで一度だけ
- 発見: (1) 単相コピーの登録でfuncsのハッシュマップがリハッシュされ、コンパイル中のFuncInfoへのポインタが
  無効化された。余裕を先に確保する形にした（上限4096は実装上の制限）
  (2) 脱糖器の診断文字列がarenaの解放後に参照されていた。codegenと同じく固定バッファへコピーする形にした
  (3) 呼び出し結果（単値）のdecl追跡が無く、structを返す呼び出しの `.field` が断片外だった。
  ジェネリックの束縛にも型引数のstruct宣言を運ばせて、`sort(ts, …)[0].kind` まで追えるようにした
- 突き合わせ: examples/fnvalue.sober（単相の辞書）・generic.sober（Pair[T] を2型で）・
  sort.sober（sort[T] + Ord[int] の閉じたラムダ2種 + Ord[Tok] の名前付き関数 +
  ジェネリック本体の中のラムダ）が実行とcheckの両方に通る

### 辞書constの段階（2026-09-26完了）— A2

コア・証明・JSONは変更ゼロ（辞書constは参照点のstructリテラルに消える）。
- loader: ConstDeclをint | 辞書に分ける。辞書は要素を検査する（int const式・閉じたラムダ・単相非inlineの関数参照・
  他の辞書const・入れ子のstructリテラル）。関数呼び出しは拒否する（language.md 25節の方針 ①）
- desugar / codegen: 参照点で宣言側の文脈（package・空の可視範囲・空の型環境）のまま展開する。
  辞書constのラムダはASTポインタで1本の匿名Defに寄せる（参照が何箇所でも関数表は太らない）
- 脱糖器の規律の自己点検: 参照点での展開は、loaderが確定させた式を文脈ごと差し込むだけで、入力に依存する生成は無い
  （int constの畳み込みと同じ「同じコードを共有する」側）
- 道中の回収: ジェネリックstructリテラルのdeclOfExprが型引数の束縛を運んでいなかった。
  持ち上げたラムダの引数にstruct宣言が付いていなかった（関数型フィールドの宣言から付ける）
- 突き合わせ: examples/constdict・testdata/pkgdemo（packageをまたぐ公開辞書const）
- 組み立てのconstへの拡張（2026-10-29 — language.md 25節）も**コア・証明・JSONは変更ゼロ**: 広げたのはloaderのconstの検査
  （string / float / bool / immのsliceのリテラル）だけで、参照点の展開の後は既存のコアの形（文字列リテラル・tt / ff・sliceのリテラル）に消える。
  脱糖器はsliceの要素の宣言の辿り（elemDeclOfExpr）にconstの分岐を足しただけ（declOfExprと同じ形）。
  突き合わせ: examples/const_lit・const_table・testdata/constlit（packageをまたぐstring / sliceのconst）

### for-yieldの段階（2026-09-26完了）— V3-4

コア・証明・JSONは変更ゼロ（for式はinline展開の中に消える）。
- 書き換え（src/stage1/forexpand.zig、desugarとcodegenが同じ関数を呼ぶ）:
  `for x <- src if g yield e` → `(yield) => { iter#.Slice(src, (x) => { if g { yield(e) } }) }`。
  生成元がクロージャ（Iter型の関数型引数）なら `src((x) => …)`。ブロック形のyield文は束縛yieldの呼び出し
- 高階inlineの土台: ジェネリック × 関数型引数（型環境を差し替えて展開）、クロージャの転送、関数型の引数を持つラムダ。
  クロージャは定義時の型環境とinline展開の列を凍結する（転送で定義より浅い位置から呼ばれるため）
- Iter[T] の推論: codegenは試し生成（yieldを番兵のクロージャに束縛して本体を1回生成し、yieldの値の型を取り、
  コードとパッチ列を巻き戻す）、desugarはcomputeTy。両層とも生成元がクロージャなら推論に寄与しない。一致テスト12ケースで固定
- 脱糖器の規律の自己点検: 書き換えは固定テンプレート1階層（形の変換）。走査ループはstd/iter.Slice（checkの対象）。
  例外はinlineラムダの引数型照合（language.md 25節の過渡措置）— 型検査を脱糖器に置く唯一の箇所で、annで解消する
- 道中の回収: `|> pkg.F()` の修飾つきの `|>` の右辺、inlineの値引数のelem_decl、codegenのpipeでforを左辺に置く形
- 突き合わせ: examples/lexer_iter（V1 lexerのトークン列をCount / Each / Sumで消費）

### 型 × region座標の段階（2026-09-27完了）— V3-5

- 型注釈ann（コアop、Lean約110行）: `HasType e ta → Ty.sub ta t → HasType (ann e t) t`。整形条件なし
  （value_coerceが任意のsub先で値を型付ける）。機械はフレームannK、`ret v ⟶ ret (coerceTo t v)`。
  証明は各ケースがfst / callの相似形（shift = sub_shiftR、tsubst = sub_tsubst、preservation = value_coerce）。
  canonicalの新設なし — call同世界化でvalue_coerceを用意済みだった利点。JSON `{"k":"ann","e":E,"t":T}`、
  Examples ex41〜43 + 否定例4本、Genにann、corevec再生成
- 点座標: desugarにregion深さrdepth（main 1・Def 2・式位置ブロック +1）。本体の型式は最内regionで注釈
- 検査の返還: inline展開で消える型（calleeの値の仮引数・ラムダの引数・結果型）をannで包む。
  desugarの照合を削除。1フィールドのstructはcoreで素の型と同型なので、型違いの検査は構造で効く
- mut引数: refをletEで別名に渡し `ann (var) (ref true r T)`。Lean・JSON変更ゼロ
- ゼロ値リテラル: フィールドごとのゼロの固定テンプレート（形の変換）
- 脱糖器の規律の自己点検: annは注釈埋めのみ（ifnilのnil注釈と同じ側）、ゼロ値は入力に依存しない固定テンプレート
- 突き合わせ: examples/nested・mutparam・zero・parser_b（--mem-trace 20 / 40 / 80項 = 5056 / 9344 / 17920B）

### label / jumpの段階（2026-09-27完了）— V4-1〜V4-3・V4-4d

エラー・診断経路（selfhost検証V4）の土台。脱出（return / break / continue / `?`）をコアのlabel / jumpに一本化する
（決定B2）。`lake build` 緑、sorryなし、公理はpropext / Quot.soundのみ。

- V4-1下準備（cbbdf03、意味変更ゼロ）: HasTypeにラベル環境 Λ : Ctx（de Bruijn、先頭が最内ラベルの型）を
  indexで追加し、StackTyも穴から見える Λ を運ぶ。全規則は素通しで、[] から始まるのは
  par / parchの子タスク・Defの本体（DefsOk）・fretKの穴・スタックの底（nil）— タスク境界・関数境界を越える脱出は無い。
  値の補題value_ctxは Γ と Λ の両方を付け替えられる形に一般化（値はjumpを含まない）。
  ヒープ（HeapOk.typed）とチャネル（ChanOk）の格納値は Λ = [] で型付け、格納する補題（heapOk_append1等）は
  任意の Λ で受けて内部でvalue_ctxを掛ける。Checkerのtypecheckは Λ を持たない（label / jumpが入るV4-2で足す）。
  Δ スレッド（関数の段階の下準備）との違い: Δ は固定パラメータだったが Λ はlabelが伸ばすindexなので、
  `induction e generalizing … Γ Λ …` とStackTyの構成子の暗黙引数（rename_i / @ パターンに Λ が1つ増える）に波及した
- V4-2 label / jump（コア + 証明 + JSON + Gen）: `label t e`（本体を Λ' = t :: Λ で型付け、正常完了もt、
  `t.regionsBelow d`）/ `jump n t e : t`（`Λ[n]? = some tL`、e : tL）。jumpのtは結果型の注釈（決定J1:
  検査器は構文主導の推論器で型の一意性・完全性を持つので、「任意の型」はnil t / inl rと同じく注釈で決める。
  棄てた案: annで外付けし裸のjumpを検査器が拒否（annの意味に相乗り・srcに形の例外）、検査器の双方向化（作り直し））。
  機械はlabelK / jumpKフレーム + 補助関数 `unwind`（labelKをn個越えた下を返す。途中のregionKはH.dropLast、
  fretK / 空スタックはnone — 1歩で終わるのでstepは関数のまま）。中核補題 `unwind_ok`: Ψ はスタックの型付けに固定し、
  ヒープを `Ψ.take d` で型付ける形でStackTyを帰納（regionKでheapOk_pop、到達したlabelKが値を降ろす下限
  `tL.regionsBelow d'` を与える、nil / fretKは穴の Λ = [] で矛盾 — V4-1の [] 配置が効く）。結論のヒープを
  `H.take d'` と言うのでstep_shared_stableも同じ補題で閉じる。par_step_commuteは無変更（Kを変えない）。
  Shift / TSubstの言明は Λ にもシフト / 代入を掛ける形（jumpのtLが動くため。呼び出しは Λ = [] で無影響）。
  JSON: `{"k":"label","t":T,"e":E}` / `{"k":"jump","n":N,"t":T,"e":E}`
- ビルド基盤: lakefileのlean_libに `--tstack=131072`（非決定的なStack overflow = Leanワーカースレッドの
  ネイティブスタック不足。どのスレッドに重いエラボレーションが載るかで揺れる）。preservationはeval / ret分岐を
  独立補題（preservation_eval / preservation_ret）に分けた（IHを使わない分岐。将来のケース追加で1定理が肥大しない）
- V4-3脱糖: 関数本体（Def / main / inline展開）は `label`、whileは `label brk (while c (label cont body))`、
  return（関数本体の最上位の末尾以外）/ break / continueは `jump`。ラベルは脱糖中のidで作り、JSON印字が
  de Bruijn添字に直す — jumpに使われないラベルは印字しないので、脱出の無いプログラムのコアASTは不変
  （棄てた案: 常にラベルを置く = 既存の全コアASTが変わる / 事前走査で要否を決める = inlineとラムダの
  非局所returnで走査が脱糖の再実装になる）。ラベルの型: Def = 戻り値型、main = unit（本体の値は捨てる）、
  inline展開 = 結果型の展開点座標（本体とペイロードをannで揃える。結果無しはunitで値を捨てる）。
  ラムダ本体のreturnは定義時の関数ラベルへ（クロージャがret先を凍結 — language.md 8節の非局所return）、
  持ち上げたラムダ（Def）のreturnは断片外のまま。break / continueはラムダ・inline本体の下限を越えない。
  deferは出口展開: 文列のブロック1つ = 1スコープ（codegenのpushScopeと同じ単位）、出口
  （ブロック末尾・jump）ごとに越えるスコープのdeferを内側から・登録の逆順に、登録時の名前 / package /
  型環境で出口の深さに脱糖し直して差し込む（`let v = 値 in (d…; v)` → jump。codegenのrunDefersと同じ
  テンプレート = 値確定 → defer → 脱出）。jumpの注釈（決定J1のt）: 位置の期待型 — 続きがある・値を
  捨てる位置はunit、値を使う末尾はTail.want（関数本体 = ラベルの型、if / switchの分岐 = 式の期待型か、
  無ければ他の分岐の末尾の型: 式ならcomputeTy、値を持たない文ならunit）。決まらなければ断片外。
  突き合わせの対: examples/early_return_pure.sober（codegenの値）↔ Examplesのv43（脱糖JSONを機械で実行）
- V4-4d分岐の脱出（受理方向splitの解消、決定 (a)）: 値位置のif / switchの分岐に脱出（`x := if c { return 1 } else { 2 }`）を
  checkは受理・codegenは拒否していたsplitを、codegenを追いつかせて閉じた。codegenのTypeに `never`（到達しない）を足し、
  return / break / continueの文はnever、分岐の合流（if・switchのjoinArm）はneverとT → T、coerceはneverを期待型として通す、
  束縛はneverを値なしとして拒否。desugar側もcoerceArm（期待型つきのifの分岐）で脱出で終わる分岐を受ける（末尾のjumpの注釈 =
  期待型。以前は "cannot decide whether to wrap in some"）。例: examples/exit_arms（build + check）

### error値と ? の段階（2026-09-27完了）— V4-4a〜V4-4c・V4-4e

language.md 13節（V4スコープ = 値と伝播まで）の実装。コア・JSON・証明の変更ゼロ — error値は既存の多値 + `T?` + unionの
合成、`?` と包み替えはlabel / jumpの段階の部品で書ける固定テンプレート。Gen / corevecも無変更。

- V4-4a error値（コア変更ゼロ）: `type L error { … }` はラベル宣言（ast.TypeDecl.body.error_）、`@errors(…)` は
  受理して読み捨て（強制はPhase 4）。loader.collectErrorsが全packageのラベルをロード順 × 宣言順に並べ、組み込み
  `error` = その閉じたunion（Program.errors、各Variant.pkgが宣言側 = フィールド型の解決先）。desugarはunionTreeTy /
  encodeVariant / caseTreeにn = 0（unit）/ 1（ペイロードそのもの・switchはlet）の特例、findVariantがラベルを
  errorのvariantとして返す。codegenは合成UnionInfo（タグ = 列の添字、layoutUnionがラベルごとにcur_pkgを宣言側へ）。
  例: examples/errval（build + check）、testdata/errpkg（package越えのラベル・修飾パターン）
- V4-4b後置 `?`（コア変更ゼロ）: `f()?` = `let p = f() in (ifnil (last p) triv (jump k unit (zeros…, some err)); init p)`
  （決定S1: jumpを文の位置 = ifnilの両方の分岐unitに置き、注釈は常にunit — 成功値の型をcomputeTyに頼らない。棄てた案S2
  `ifnil (last p) (init p) (jump k T …)` はTの座標がcomputeTyのcall結果region（呼び手座標に未変換）に律速される）。
  行き先はreturnと同じ（ret_target — 関数本体・inline展開は自分、ラムダは定義時の関数 = 非局所）、越えるdeferはwithDefers。
  成功値: 残り0成分 = unit（`(error?)` 単値の `?` は値として使えない — 確認2は規則を足さず型から従う）、1成分 = その値、
  2成分以上 = 多値のまま分解点へ（`a, b := f()?`）。拒否: 行き先の最後の結果がerror? でない（main含む）・呼び出しの最後の結果が
  error? でない・行き先の他の結果にゼロ値が無い（関数値 / union / tvar — 15節）。
  ゼロ値はその場で組む（Z1は撤去 — 2026-09-28）: `?` がjumpのペイロードに積む他の結果のゼロ値（int / bool / nil / 空のimm slice・map、
  それらのstruct）は `?` の位置で組む。深い位置の空のimmコンテナは最内regionに乗るが、jumpの型規則jumpRel（R4b）がペイロードを
  ラベルの最内region kへclampRでクランプしてから浅い共変で比べるので、ラベル型（戻り値の座標）に合う。クランプの側条件b ≤ kはDef本体・mainでは
  b = 0で常に立ち、bを上げるpar / parchは Λ = [] なのでラベルを越えるjumpが無い。ゼロ値は戻り値型の値なのでmut / chanを含まない（retOk）。
  棄てた案Z1（V4-4bの当初の決定）: regionを持つゼロ値を関数本体の先頭（labelの外 = 戻り値の座標）でlet束縛し、ペイロードはそれを参照する —
  jumpがペイロードをラベル型へそのままsubで比べていた当時の規則では必要だったが、R4bのclampRが吸収した。撤去の裏取り: 無効化したビルドで
  第3のゴールデン82 entryの判定が全一致・狙い撃ちの3構成（ループと分岐の奥・展開されるラムダの非局所 `?`・展開されるmut引数の関数の `?`）が
  有効・無効とも受理。撤去で第3のゴールデンはZ1束縛を使う9本だけが変わり、全部受理のまま。
  棄てた案Z2（任意のregion ≤ dに空sliceを作るコアop — 証明の変更）はZ1の代案として棄てたまま。codegenは元から入口束縛を持たない
  （その場で空ヘッダを作る）。FuncDecl.has_tryは脱糖器の読み手を失い、loaderのゴールデンのフィールドとしてだけ残る。型追跡: `x := f()?` のcomputeTy / declOfExpr / elemDeclOfExprはtry_skip（次のcallの結果を最後のerror? を
  落とした1個として読む）、多値分解の束縛はregionを持たない結果型だけBinding.tyに載せる（T? のsinkのsome包み判定用）。
  codegenのtryResults: 結果をフレームのスロットへ移し、最後のerror? のタグが非0なら結果スロットへゼロ値 + err →
  retの後半（runDefers → epilogue / inlineのend_jumps）。突き合わせの対: examples/try_prop_pure ↔ Examplesのv44
- V4-4c包み替え: `f()? L{…}` はS1のjumpペイロードのerr成分を `some (L{…})` に替えるだけ（K3: 内側のerrは捨てる —
  causeは期限つき未決）。Lのフィールドはsome分岐 = エラーの経路でだけ評価される（map_errと同じ遅延。codegenも判定後に評価）。
  Lはerrorラベルに限る（struct / unionのvariantはMalformed）。grammarは既存のまま: `?` はendsStatementなので改行後の
  リテラルは別の文、条件位置はc_try（包み替えを読まない — 括弧で書く）。突き合わせの対: examples/try_wrap_pure ↔ Examplesのv45
- V4-4e検証例errparse（V4完了）: examples/errparseはミニlexer（`lex(text string) ([]Token, error?)` — ループ内の `?`・
  slice結果成分のゼロ値の入口束縛）+ 再帰下降parser（`(int, int, error?)` の相互再帰の中の `?`・多値の分解）+ トップの
  包み替え（`run(a)? BadInput{which: 1}`）+ バイトオフセット → line:colの解決（Soberでbytesを走査）。位置は1ワードで運び
  表示時に解決する（R5と同じ設計を例の中で踏む）。道中の回収: switchパターンで束縛したフィールドに型（Binding.ty）が
  載らず補間がCoreFragmentになっていた（union共通の既存の穴）— 多値分解と同じくregionを持たない型だけ載せる。
  突き合わせの対: examples/errparse_pure（9入力の結果を1ワードに畳み込む）↔ Examplesのv46
- ラベルのフィールドはloc-freeに限る（io-1）: stringフィールドのラベルが宣言されているだけで、intフィールドの
  ラベルしか返さない関数もbuildが "slice inside an optional / union result" で止まった（errorの閉じたunionにsliceが入り、
  codegenのrelocateValueがopt / unionの中を歩けない）。規則はloader.collectErrorsのlocFreeTE（名前は宣言まで辿る・
  型パラメータは通す）。解除はlanguage.md 13節の暫定制約の条件どおり

### ioの段階（2026-09-27完了）— 随時回収のioシム（io-0〜io-5）

language.md 27節（アリーナの溢れ・string(b)）と28節（io）の実装。コア・証明の変更ゼロ。
- io-0アリーナの上限検査: bumpの前進5経路（relocate / sliceリテラル / concat / map set / append）を共通のemitBumpStore
  （スロット末尾 = SLOTS + (bumpアドレス − META) × (SLOT_SIZE / 8) を符号なし比較）に寄せ、region enterの深度・起動時の
  mmapの戻り値も検査する（exit 102）。スロット64MB × 1024 = 64GBのNORESERVE予約はWSL2（overcommit 0）で実測して採用。
  → スロットは実行時可変に（2026-09-28）: 大きさはmetaのSLOT_SIZE（旧定数SLOT_SIZEを置き換え）、既定4GiB × 1024 = 4TiB、
  `SOBER_REGION_MB` で上書き、予約の失敗は半減して1MiBまで再試行（language.md 27節）。overcommit 2ではNORESERVEが無視されて予約が全額
  CommitLimitに計上される — 旧64GiB固定はこの機械（CommitLimit約50GB）で全プログラムが起動時にexit 102になるという仮説（sysctlを変えられず、
  ulimit -vの模擬で半減の経路を確認した）
- io-2 `string(b)` の道中の回収: ①仮引数のimm slice / mapをそのまま返す転送return（round4からの断片外 — 仮引数はr0、
  戻り値の最上位はr1、checkDefsは厳密一致）を結果型でannして通す（Ty.subのimm上界の緩め）。条件は「返す式が名前で、
  束縛の型がregionだけ結果型より緩められる」とき — 式一般のcomputeTyはregionが実体とずれる経路（リテラルをr0と読む）が
  あるので名前に限る（v43〜v46のコアJSONは不変）。②多値分解 `s, err := f()` の束縛型に、結果の最上位のimm slice / map
  （要素はregionを持たない）を呼び手の最内regionで載せる（call結果型ret.relocR dと同じ上界）。
  突き合わせ: examples/utf8_pure ↔ Examples v47、Goオラクルexamples/utf8_std（scripts/utf8_oracle.ts）
- io-3 check側の姿勢（決定C1）: sys* builtinは型どおりの固定の代役に脱糖する — sysReadFile(p) = `let p in freeze(mkslice int)`、
  sysWriteFile(p, b) / sysErrno() = 0。脱糖器の規律（固定テンプレート）の内側で、println → unitと同じく外界を型だけで扱う。
  代償はLeanの突き合わせがioの中身を観測できないこと — ioはcodegenの実行テストで検証する
- io-4 println: 評価 → 出力の順（全引数をスロットへ）と行バッファ。Leanは出力をモデル化しないので突き合わせ外
- 検証例: examples/io_basic（読み・書き戻し10000バイト・NotFound / Denied / EISDIR・不正UTF-8・空ファイル）、
  examples/errparse_file（ファイル → 行 → lexer / parser → path:line:col、トップは行番号への包み替え）

### V5足場の段階（2026-09-27完了）— selfhost検証V5（V5-1〜V5-5・V5-7）

コア・証明の変更はV5-6（次節）だけ。ここはオラクルと足場の記録。
- V5-1固定点オラクルの足場: stageの番号づけ = stage0 Zigツールチェーン・stage1 Zig製sober（信頼の根・恒久維持）・
  stage2 Sober製コンパイラをstage1でbuild・stage3同じソースをstage2でbuild。固定点 = stage2 ≡ stage3（バイト一致・正規バックエンド）、
  LLVM経路は観測等価のみ、stage1(X) ≡ stage2(X) は要求しない。器はscripts/stages.sh（骨格C3 — 実装2026-09-28、selfhostのR35: 暫定形の固定点
  stage3.ll ≡ stage4.llが成立、gate `stages` に常備。実測と形はdesign-dev.md最終オラクル項）
  - hermeticityは固定点の前提（scripts/hermetic.sh — C1、gate常備）: 出力 = f(ソース, コンパイラ)。2回・別pathのコピー・絶対path・
    env -i / TZ / LANG / umask / SOURCE_DATE_EPOCHを変えてELFとコアJSONをバイト比較。stage1の出力は着手時点で満たしていた（退行の門番）。
    対象外: stage1バイナリ自身（Zigのデバッグ情報が絶対pathを持つ）
  - 観測 = (stdout, exit code)（scripts/obs.sh — C2、backendを引数に取る差分オラクルの器）。examplesの規約に `<name>.exit`（無ければ0）、
    複数packageの例は `<dir>.out` / `<dir>.exit`。panic 101 / 102も観測値 — UB遮断規約（明示チェックを吐く）の検証面はexit code
  - 発見（V5-1aで回収）: ゼロ除算がSIGFPE（exit 136）だった — Leanはpanic、codegenはidiv直行。旧gateはexit codeを捨てていて
    見えなかった（観測できない値は検証されていない）。最小値 / -1はGo準拠（商 = 被除数・余り0）
- V5-2 / V5-3 std/poolとanalyzer 1本目（language.md 30節）: PoolはSoberで書いたstdでコアopを増やしていない。analyzerは
  ZigのAST 1パスで証明の対象を持たない — 答え合わせはT1（Poolの未返却カウンタ）とミューテーション（scripts/pool_oracle.sh）
- V5-5 interface視点のローダと一致検証（language.md 29節）: 比較専用の記号名正規化出力 `--core-json-pkg`。Leanに渡すコアJSONは不変
- V5-7検証例minic（testdata/minic/{app,lex,parse,diag,emit}）: io → utf8 → 字句（Builder）→ 演算子順位法の木（[]Node + 添字・後置順）→
  スタックVM → 値かpath:line:col（ゼロ除算はVMの実行時ラベル）。行ごとの作業記録をPoolから借りて直後にdeferで返す。
  3条件（analyzer受理・ミュータントの拒否・未返却0 / 全packageの `.sobi` 視点一致 + 部分検査 / hermetic + obs）を満たす。
  道中の回収（脱糖器をcodegenに揃えたsplit 3件）: flow typing後の `.field`（`T?` の型宣言 → ペイロードの宣言。ジェネリック呼び出し結果
  `pool.Get` を含む）・structのsliceフィールドの要素宣言・型パターンswitchの `case _:` = default。文位置のifは次の「脱糖器の規律」に一行。
  発見: mut引数の関数は展開されるので再帰に持ち込めない（language.md未決「region多相の決定」のB3にまとめた）
  → R2（anchorつき呼び出し）で回収 — 「regionを持つ型の境界越えの段階」

### package単位の検査の段階（2026-09-27完了）— V5-6（I-3）

分割コンパイル（language.md 29節）の検査を、packageごとの部分検査の合成として証明する。lean/FeatherweightSober/Split.lean、
sorryなし・公理propext / Quot.soundのみ。
- `hasType_sigEq`: 型付けは関数表の署名（param / ret / tparams）しか見ない（HasTypeが Δ を読むのはcall / fnrefの `Δ[fn]?` だけ）
- `hasType_rename`: 関数indexの付け替え ρ（`Expr.renameFn` — call / fnrefの添字だけを付け替える構造写像）で型付けが移る
  （署名が保たれる限り — `SigMap`）。sigEqの一般化
- `checkDefsAt Δ S`: Sの立つ添字のDefだけをcheckDefsと同じ条件で検査する部分検査（他は署名だけの枠）
- `defsOk_of_parts`（添字の揃った分割）/ `defsOk_of_linked`: 各視点の部分検査の受理（hchk）+ 署名の写像（hmap）+
  被覆（hcover — 全体の各Def = ある視点の検査済みDefの本体を ρ で付け替えたもの）⇒ 全体のDefsOk
- 発見（食い違ったところ）: 最初の形defsOk_of_partsは実装に当たらなかった — 視点の表は全体の表より短い（`.sobi` が非公開の非展開関数を
  落とし、他packageの持ち上げも無い）ので添字が揃わない。リンカの再配置 ρ を仮定に入れた形が要る（リンカの仕事を定理の仮定として明示した形）。
  記号名（29節）が ρ そのもの
- JSON: 部分検査の封筒 `{"parts":true,"defs":[…],"e":E?}`。bodyの無いDef = 署名だけ（trivを置き検査しない）。eはmainの視点だけ。
  従来の封筒・parseProgram・ExamplesのvNNスナップショットは無変更
- Zig: `sober check E --pkg P [--iface DIR]`（部分検査）/ `--pkg P --core-json`（名前付き関数の署名表）

| 定理の仮定 | 見ている検査（gate常備） |
|---|---|
| hchk | scripts/pkgcheck.sh 1（sober-checkが部分検査を受理） |
| hmap | pkgcheck 2（視点の名前付き関数の署名 ⊆ 全体）+ sobi.shのG-d（Sober版 — 今の例の全packageの視点の署名表 ⊆ 全体の表・改竄mutant）。stage1のiface.sh（Pの持ち上げの署名の正規化比較）は3'' M5で退役 — 凍結コーパスの照合はsobi.shのG-cが後継 |
| hcover | sobi.shのG-c（凍結コーパスでstage1と判定一致）+ checksplit（G-e — 小分けの判定 ≡ 一括の判定・全entry）。記号名正規化のバイト一致（旧iface.sh）はM5で退役 |
| 仮定の外 | ρ の単射性・全Defがどれかのpackageに帰属すること — スクリプトの名前の一致で見ているだけ。リンカ（backend I-4）の実装時の検査項目 |

- 自己検査: 署名を偽った `.sobi` は部分検査を通ってしまうが署名表の包含で必ず落ちる — 部分検査の受理だけでは合成は成り立たず、
  hmapは別に検査する必要がある

### regionを持つ型の境界越えの段階（2026-09-27完了）— region多相の決定R0〜R5

language.md 31節の決定の形式化。全段階で `lake build` 全緑・sorryなし・主要定理の公理はpropext / Quot.soundのみ。


- R0値ラッパ越しの境界コピー: relocRがopt / unionの中の最上位コンテナも呼び手最内へクランプする（旧: 中身はshiftRのまま —
  nil / inl / inrの注釈をrelocateが書き換えないため）。fretKが結果型tを持ち、境界コピーが注釈もtに書き換える（codegenでは恒等）。
  round4の保留「opt / union内コンテナのrelocate」を回収
- R2 anchorつき呼び出し（決定K-a）: region 0は暗黙のregion変数で、callは常に呼び手最内dでinstantiateしていた。
  新しい構成子 `callM` はanchor a（仮引数型のmut位置に対応する実引数のregion — `Ty.anchorOf`、構文主導のまま）で
  写像 `rmap a d`（0 ↦ a、k+1 ↦ k+1+d）を掛ける。規則: `sub ta (param.renR a d)`・`b ≤ a ≤ d`・結果 `relocA a d`。
  DefsOkのbaseはb = 0（region 0 = mut引数へ書ける）・本体はsrc。証明の要: 写像定理ren_typing（シフト定理の一般化 —
  狭義単調性だけで運ぶ。ρ0 = dで一様シフトに一致 = 保存拡大rmap_top / renR_top / renTy_top — (a) を再訪するときの退路）、
  anchorV_eq（実行時のanchor = 型のanchor — mutは正確region）。既存のcallはanchor = dの特殊形として据え置き。
  機械はcallMKフレーム、JSON `{"k":"callm"}`。棄てた案: callにanchorを足す（既存のcallの証明を動かす）、
  Exprにanchorのフィールドを足す（型から読めるので要らない）
- R4a深いrelocate: 境界コピーを型主導にし、コピーするコンテナのセルの中身も再帰でコピーしてから（入れ子のコンテナも呼び手最内へ）、
  セル列を呼び手最内の末尾へ連続に積む。retOkは中身へ再帰（どの深さでもr < 2、mut / chan不可）、relocR / relocAは深いクランプ。
  戻り値の中身の座標はr1（自フレーム）に統一。round4以来の保留「戻り値の深い持ち帰り」を回収
- R4b α 脱出の境界コピー: ラベル環境は (型, ラベルの最内region k) の組（labelは深さdで (t, d - 1) を積む）。jumpの規則は
  `Ty.jumpRel b k tJ tL` = ペイロード型をkへクランプして（`clampR` — immのregionをmin r k、中身へ再帰）から浅い共変で緩める。
  クランプが要る（noClampでない）ならb ≤ k（コピー先へ書ける）かつchanを持たない（chanVのスナップショット等式がregion kの伸長で壊れる）。
  機械は `relocTo k`（コピーする元 = kより深い全region、コピー先 = k）、unwindがラベルの型を返し、jumpKはコピーしてからラベルの深さへ切り詰める。
  証明: relocTo_ok（値の型Tと歩く型W = ラベルの型を分け、`sub (clampR k T) W` で帰納 — 葉はクランプで不変、immコンテナはk < rなら
  コピーする・でなければ中身の下限からクランプが恒等）+ jumpK_step（preservation / progress / 共有プレフィクス安定性が同じグループ）。
  shift_typingはren_typingのanchor = dの系に置換。棄てた案 β（呼び出しの結果の置き先を脱糖器が選ぶ — 座標の自由度が増える）
- R4b-cov immセルの深い共変: `Ty.sub` をimm slice / mapのセル型へ再帰させる（mutとrefは正確一致のまま）。slicev / mapvのセル型は
  要素型の部分型（mutは正確）。静的な要素型の下限 `t.regionsBelow (r + 1)` はmutだけに残し（mut appendがregion rに書く）、
  imm appendの規則が新しいセルの下限 `t.regionsBelow (d + 1)` を持つ。読み出しは型注釈で閉じる（A-2）: `index e i ot`（注釈は省略可 —
  省略は要素型がannFree = opt / union / 型変数を含まないかmutに限る。JSONの `"t"` は任意）とgetmの既存注釈で、読んだ値をcoerceToで
  書き換える — 値の型付けは注釈に正確なまま動かさない（annと同じ注釈書き換え）。棄てた案A-1（値の型付けを注釈に寛容にする —
  型付けの一意性とcheckerの完全性の言明が崩れる）。fretKの境界コピーはrelocTo（k = 呼び手最内）の特殊形に統合し
  （relocA = clampR ∘ renR — retOkの下でregionは0か1だけ）、R4aのrelocT_okはrelocTo_okの系relocRet_okに置き換わった。
  証明の要: sub_trans・clampR_mono・sub_chanFree、read_ok（annFreeの型へのcoerceToは恒等 — Expr.coerceTo_annFree）、
  relocTo_okの帰納はセルごとに型を量化（RelocIH — 深い共変でセルごとに型が違う）、copy補題はセルごとの型をそのままコピーする
- R4b K1''（脱糖器のみ）: error = `prod L []L`（L = 全ラベルの閉じたunion、チェーンはimm slice・外側が末尾）。包み替えは内側の先頭を
  チェーンの末尾へ積む（imm append）、`case L{..., cause}` のcauseは `ite (len chain == 0) nil (some (index chain (len - 1), chain[0:len-1]))`
  （チェーンの読み出しはLの注釈つきindex）。コア・証明は変更なし — 形の変換だけ（脱糖器の規律）
- R5普通の出口の対称化: 新しい構成子 `blockR t e`（出口でコピーするブロック）と機械フレーム `regionKR t`。型付けはjumpと同じjumpRel
  （本体の型を親の最内d - 1へクランプして浅い共変で緩める）+ 結果型の下限 `t.regionsBelow d`。機械は出口でrelocTo（親の最内）してからpop。
  証明はregionKR_step（jumpK_stepと同型 — 巻き戻しの代わりに1レベルだけ降りる）。既存のblock（コピーしない）は据え置き — blockRは保存拡大。
  JSONはblockに任意の `"t"`。脱糖器は末尾値の型がブロックのregionを指すときだけblockRを出す
- 突き合わせ（Examples.lean）: exR0a〜c・v48（R0）、r2Δ（R2 — anchor < 呼び手最内の再帰・callでは拒否・parへmut不可）、
  r4Δ / exR4a（R4a — 入れ子のsliceを2レベルの呼び出し越しに返す）、exR4b（α — 式ブロックの入れ子のsliceを外のラベルへjumpで持ち出す）、
  covΔ / exCov（cov — 入れ子のimm sliceの仮引数の転送・注釈つき読み出し）、exR5（R5）。GenはDef 4〜7とcallMを生成
  （golden 300本にcallMの受理ベクタは出ない）
- 実行系（lower）はbackendレーンが同じ規則で実装する: R2（mut_defのアドレス渡し）・R4a（深いrelocate、B-10）・α（inlineの脱出）は
  実装済み、K1''（errorのチェーンとcause）とR5（ブロックの出口のコピー）は中継済み

### byteの段階 — 段階A（2026-10-01完了。決定はlanguage.md 33節、実装順は同節の段階A → B → C）

段階A（スカラー）のLean。段階B（`[]byte` の詰め）と段階C（stringの切り替え）はlowerの表現の変更で、コアの項・証明は段階Aだけ
（詰めはセル = 値の意味論のまま観測不能 — 健全性の前提「byteのセルの値は0〜255」は段階Aの型付けが保つ = `canonical_byte`）。

- `Ty.byte`: 区域系の述語（regionsBelow / mutFree / chanFree / シフト / TSubst / renR）・sub・retOkはintと同じ扱いの分岐（boolの分岐の複製 — 14ファイル）
- 項は3つ: `tobyte e`（int → byte。範囲外はpanic）/ `toint e`（byte → int）/ `blit n`（byteの値 — 実行時にのみ現れる項。`Expr.src = false`・JSONの語彙に無い）。
  型付け `blit n : byte` は0 ≤ n < 256のときだけ。`canonical_byte`: byteの値は範囲内のblit
- 決定B7からの訂正（実装で判明）: 草案B7は「値は既存の `lit n` をbyteにも型付ける」だったが、それだとソース項の `lit n` がintとbyteの2つの型を持ち、
  検査器の一意性（hasType_unique）と完全性（typecheck_complete — ソース項の導出があればtypecheckが同じ型を返す）が崩れる。
  そこでbyteの値は実行時専用の `blit n`（loc / slicevと同じ非ソース項）にし、ソースのbyteは常に `tobyte` で作る。表面の意味論は同じ
  （`byte(n)` の範囲検査・値の範囲の保証）。B7の「評価器は無変更」も成り立たない — どちらの形でもtobyte / tointの継続（tobyteK / tointK）は要る
- 比較はコアに足さない: byteの `==` `<` 等は脱糖器が `cmp op (toint a) (toint b)` にコピーする（形の変換のみ — boolの `==` をite形にしたのと同じ理由:
  表せるものにopを足すと証明の面積だけ増える）。コアのcmp / ltはint × intのまま
- Machine: 継続 `tobyteK`（`ret (lit n)` → 範囲内なら `ret (blit n)`、外ならpanic）/ `tointK`（`ret (blit n)` → `ret (lit n)`）。
  retの分岐はmatchの末尾（`.ret _ _ _` の前）に置く — 値で場合分けする分岐を前に置くと後ろの分岐の等式の生成（補集合の条件）が重くなる
- Leanの罠（新）: Exprのコンストラクタを3つ足しただけで、Soundnessの `simp only [step]`（stepの等式の生成）が既定のheartbeats（200000）を超えた。
  `set_option maxHeartbeats … in` を定理にもstepの定義にも付けても効かない（等式は別の文脈で作られる）→ lakefileの `-DmaxHeartbeats=1000000`（全体）で通した。
  lake buildは約3分（Soundnessが主）
- Checker / Json: typecheckにtobyte / toint（blitはnone — ソース項でない）、JSONに型 `{"k":"byte"}` とop `tobyte` / `toint`
- Genは追いつかせない: genBaseに網羅のためだけの分岐（乱数を引かない — genTyはbyteを作らない）。corevec 300本は一致のまま
- 突き合わせ: ExamplesのexByte1〜5（比較・境界値255・範囲外256 / −1のpanic・`[]byte` の要素の読み）+ 実行時の値の型付け（blit 255は付く・256は付かない）+
  否定例6本（byteの算術・byteのcmp直・tobyteの入れ子・toint (lit)・byteの条件・blitはソース項でない）+ JSONの往復。
  公理propext / Quot.soundのみ（soundness・preservation・progress・step_shared_stable・typecheck_sound / complete）、sorryなし。規模 +336行

### 再帰型の段階（2026-11-03決定。S = 完了・D = 完了〔型の層 + 型規則 + 燃料つきのコピー + 燃料切れの到達不能〕・同時の μ = 完了〔R3e — 最終形はS・Dとも同時の μ 1本ずつ〕。決定はlanguage.md 1節の「再帰の型宣言」）

S（関数型の中を通る再帰）とD（slice / mapの要素の位置を通る再帰・ジェネリックの再帰unionを含む）を同じ段階で開く。I（直の自己フィールド・`T?`・`[N]T`）は入れない。
契約（全段階）: isoに徹する（Ty.subは同一の μ だけ — 余帰納・展開の等価にしない）・再帰の変数は束縛と同じregion（跨ぎは書けない）・Leanとcheckerは
同じ段階で完了して照合ベクタ（tyvec / corevec / checkverdict）に μ の場合を足す・region × μ に条件付きの制約か特例が要りそうなら入れずに決定へ戻す。

- **最終形（R3e-3以降）**: 符号化 = 構造的な同時の μ — `Ty.mus (n i : Nat) (bs : Ty)`（S）/ `Ty.muRs (r n i : Nat) (bs : Ty)`（D）/ `Ty.rvar (i : Nat)`（平らなde Bruijn）・
  自己再帰は幅1の組（`Ty.mu1 b = mus 1 0 (b × unit)`・`Ty.muR1 r b = muRs r 1 0 (b × unit)` — 略記のabbrev）・項 `fold t e` / `unfold e`・値 `fold t v`・
  fold / unfoldが扱う μ = `Ty.foldOk`（musOkかmuRsOk）・型規則foldS / unfoldS / foldRs / unfoldRs。下のS / Dの段階の記述は1束縛の μ（`Ty.mu` / `Ty.muR`）で
  組み立てた経緯で、R3eで組の形へ持ち上げてから1束縛の構成子と分岐・専用の補題を撤去した（同じ定理がn = 1の組で成り立つ）。
  棄てた案 = 名前の表（コアのTyは名前を持たない構造型で、同じ名前が関数型の外と中で座標違いに現れる — regionの引数 + 表の引き回し + 宣言の旗が要る）
- Sの段階（完了）: fold / unfoldが扱う μ は `Ty.muOk`（本体が関数型・閉じている・型変数を持たない）に限る。μ は関数型と同じくbase座標の型スキームで
  regionを持たないので、区域系の述語（regionsBelow / mutFree / chanFree / annFree / retOk）は真・シフト / 写像（shiftR / relocR / renR / relocA）は恒等の分岐で閉じ、
  中へ入るのはtsubst / tvarsBelow / rsubst / rfreeだけ。型規則は結論の型を構文で `μ (fn p r)` に固定（canonical formsの場合分けが構文で閉じる）:
  `foldE : muOk T → e : T.unfold → fold T e : T`・`unfoldE : muOk T → e : T → unfold e : T.unfold`。機械 = 枠foldK t / unfoldK・
  `unfold (fold t v) ⟶ v`・canonical_mu。preservation / progress / step_shared_stable・写像定理ren_typing・tsubst_typing（muOkの型は型変数を持たないので
  型代入で不変）・Checkerの健全性 / 完全性・TcStep / TcEq（kFold / kUnfold）・Leaf・UniqFreeze・Split・Json（`{"k":"mu","b":T}` / `{"k":"rvar","i":n}` /
  `{"k":"fold","t":T,"e":E}` / `{"k":"unfold","e":E}`）。sorryなし。証人（Examples）= next形のミドルウェア（Mw = μM. fn (int × ([]M × int)) int・
  チェーン [log, plus] を5で走らせて106）+ 否定例4本（foldなしでsliceに入れる・unfoldなしで呼ぶ・本体が関数型でない μ・展開と違う型の関数値）。
  照合: 抽出（ty_genにrsubst / rfree / isFn / unfold / muOk・tc_genにkFold / kUnfold）・tyvec 33関数 × 8000（μ を含む型の乱択）・
  Genに μ の題材3つ（自己適用・状態関数・next形）とchaos / 近傍ミューテーションの分岐 → corevecのゴールデンを再生成（Soberの検査器 ≡ Lean）
- Dの段階（R3a = 型の層 完了）: `Ty.muR (r : Nat) (b : Ty)` — μ 自体がregion座標rを持つコンテナで、本体bは局所座標（関数型の外のregionは全部0 = `Ty.localOnly`）。
  シフト・写像・クランプ・relocR / relocAはrだけに掛かり本体を見ない（sliceの分岐の持ち上げ — imm / mutは本体のmutFreeで場合分けする）。
  部分型 = `b = b' ∧ (r = r' ∨ (r ≤ r' ∧ b.covOk))`（`Ty.covOk` = 深く共変な本体: immのコンテナと値ラッパだけ・immのrefの中身はloc-free）— μ の中へ潜らない。
  展開 = `(b.rsubst 0 (muR 0 b)).shiftR r`（局所座標のまま μ 自身を代入してから本体ごとrへ置く — 素直な「置いてから代入」は相互再帰で壊れる: 有限列挙C1の反例12）。
  整形 = `Ty.recOk`（Dの本体は局所座標・再帰の変数はslice / mapの要素の下にだけ〔`Ty.rguard`〕で関数型を跨がない・Sの本体は関数型）+ 閉じている = `Ty.muROk`。
  補題: 展開とシフト / 写像 / 型代入の可換・regionの上界の保存・**部分型が展開へ下りる（sub_unfold_muR — 余帰納なし: 本体の構造的帰納で、変数の位置は外の座標の部分型そのもの）**。
  型引数に「閉じている」を足した（tyArgOk = loc-free ∧ chan-free ∧ rfree 0）ので型代入と展開が可換になり、SのmuOkの「型変数なし」を外した（Sのジェネリックも開く）。
  `Ty.sub_tsubst` / `readAs_tsubst` は型引数の条件を前提に取る（Dの部分型のcovOkを型代入で保つため）。
  反証探索 = `.pair/rec/r3a-enum.lean`（本番のTyに対する有限列挙の #eval — 閉じて整形なDの μ 6,526本で11本の言明が反例0）。
  R3aではまだmuRの値を作れない（foldはSの μ だけ）— 境界コピーのmuRの分岐は空（R3bでcanonical_muRに置き換える）
- Dの段階（R3b+c = 型規則・値・燃料つきのコピー 完了）: 型規則 `foldR : muROk (muR r b) → e : (muR r b).unfold → fold (muR r b) e : muR r b`・`unfoldR`（逆）。
  結論の型を構文で `.muR r b` に固定（SのfoldEと同じ — canonical formsの場合分けが構文で閉じる）。fold / unfoldが扱う μ = `Ty.foldOk`（muOkかmuROk）— 検査器・TcStepもこれで判定。
  値の補題は展開の補題で閉じる（value_strengthen = unfold_rb_muR・value_sb / value_world = unfold_mf_muR・value_anyΞ = unfold_cf_muR・value_coerce = sub_unfold_muR — 余帰納なし）。
  `Expr.coerceTo` にfoldの分岐（`coerceTo (muR r b) (fold _ e) = fold (muR r b) (coerceTo (muR r b).unfold e)` — 値の上の構造的再帰。部分型で座標を上げた木の注釈を中まで書き換える）。
  型代入・写像・シフトの型付けはunfold_tsubst_muR / unfold_renR_muRとmuROkの保存（muROk_tsubst・muROk_r — muROkは外の座標に依らない）。
  **型引数の条件に「整形」を足した**（`tyArgOk = loc-free ∧ chan-free ∧ rfree 0 ∧ recOk` — 型代入がmuROkを保つため。脱糖器の出す型引数は整形なので受理集合は不変。
  棄てた案 = muROkから入れ子のrecOkを外す — R3aの整形の定義を崩す）。
  **境界コピーは燃料つき（T-a）**: コピーを `relocW k rec`（従来の歩き + muRの分岐だけrecで展開の型を歩く）と `relocN k n`（燃料nでrecを畳む — μ を開くたびに1減る・
  0でnone）に場合分けし、`relocTo k t H v = relocN k (relocFuel H v) t H v`（燃料 = 値の大きさ + ヒープの全セルの値の大きさの和 + 1 — 大きさは値の構成子の節の数 `Expr.vsize`）。
  xferも同じ形（xferW / xferN）。棄てた案 = 燃料 =（セル数 + 1）×（型のmuRの数 + 1）— 入れ子の μ を展開した型の上界の証明が重い（展開で型が大きくなる）。
  機械はコピーのnoneをpanicにする（返り境界・blockR・scopeの出口・copyTo・jump・join / try・失敗の値・送りの梱包・受けの展開 — 受けは取り出した後の端点でpanic）。
  **燃料切れは到達しない（T-b — T-aの乖離は解消済み）**: HeapOkに不変条件 `acyc : HeapAcyc H`（凍結セルの値が指す凍結セルは順位が真に小さい — `∃ rank`。
  機械は凍結の時刻を持たないので順位は存在で言う。位置の順では言えない: 書ける間のセルは後から積んだセルを指せる〔append → setidx → freeze〕）。
  保存は汎用3本で閉じる: 凍結集合が縮む（push / pop / take / write — 書くのはタグtrueのセル）・`HeapOk.acyc_set`（前の凍結セルは値ごと残り、新しく凍結したセルの値は
  前のヒープの凍結セルだけを指す — 新しいセルに前の全順位より大きい順位: alloc / append1 / freeze。値の参照先が凍結なのはmutFreeの型の値の型付けから — `HasType.refs_frozen`）・
  同じヒープ（spawn / chan_mono）。append_copy系・freezeRange・append_list・境界コピーの割り当て直しは基底の合成で無変更。
  燃料の十分性: コピーの失敗の条件を値に依存させた（`PN lo rank N W H v` = WがDの μ を含み、region ≥ loの順位が整ったヒープではN < need）。
  `need = vsize v + pot(refBound)`（pot R = region ≥ loの凍結セルで順位 < Rのものの値の大きさの和・refBound = 値の参照先の順位 + 1の最大）。
  伝播: 包む値はneedが単調・pairの後ろは前のコピーの後のヒープでneed不変（RelocJに「kより上のregionは不変」の枠を足した — コピーはregion kだけに書く）・
  セルへ降りるとneedが下がる（`need_cell` — そのセル自身がpotに入り、セルの値の参照は順位がより小さい）・foldを開くとneedが1下がる（`need_fold`）。
  `need < relocFuel` なのでrelocTo_ok / xfer_okの燃料切れの分岐はFalse（`relocTo_ne_none` / `xfer_ne_none` — 機械のコピーのpanicの分岐は型付きの状態では到達しない）。
  relocToはlo = k + 1（読むのはkより上のregion）・xferはlo = 0（読み元の子のヒープは固定）。
  証人（Examples）= 木Tree = μX. []Xを組んで数える3 Def（buildが深さnの完全二分木を自フレームで組んで返す — 返り境界のコピーが燃料つきで μ を開く）で
  深さ3 → 15 + 否定例4本（展開と違う中身のfold・ガードのない再帰〔I〕・局所座標でない本体・unfoldせずにsliceとして使う）+ 燃料0のコピーはnone・μ なしは成功。
  照合: 抽出（ty_genにfoldOk・tyArgOkのrecOk・tc_genのkFold / kUnfoldがfoldOk）・tyvec 39関数 × 8000 = 312,000（foldOkを追加）・
  GenにDの題材（21〜23 = 同じ木の3 Def・分岐recD = 組んで数える / 呼び出しの結果を開く / その場でfoldした葉）→ corevecのゴールデンを再生成（Soberの検査器 ≡ Lean）
- 同時の μ の段階（R3e — 相互再帰の正準形）: `Ty.mus (n i) (bs)`（S）/ `Ty.muRs (r n i) (bs)`（D）— bsはn個の本体のprodのチェーン（unit終端）・型は組のi番目・
  組の変数は平らなde Bruijnでn個（本体のrvar jはj < nなら組のj番目・j ≥ nなら外へj − n — 束縛の下の持ち上げは +1が +nになるだけ）。
  **幅nを構成子に持つ**（チェーンの長さで数えると、尾が型変数の組で型代入がprodを入れたとき幅が変わり外の変数を捕獲する — rsubstとtsubstの可換が偽になる）。
  展開 = `((bs.comp i).substG d n bs 0 n).shiftR r`（substG = 組の変数jを組の成分の型〔Dは局所座標のmuRs 0 n j bs・Sはmus n j bs〕に1つずつ置き換える多重代入 —
  代入する型は閉じているので逐次 = 同時。素直な「rへ置いてから外の座標の成分を代入」は列挙で57件の可換の破れ — report-rec-9）。
  補題は1回の代入の補題を `substG_pres`（1回の代入が保つ性質は多重代入も保つ）で持ち上げる: unfold_rb / shiftR / renR / clampR / relocR / noClamp / tsubstの _muRs・
  sub_unfold_muRs（部分型が展開へ下りる — 同じ組・同じ成分で外の座標だけ）・musOk_fn（Sの展開は関数型）。
  整形 = `recOk` の分岐（D: チェーン・i < n・局所座標・`groupOk`・入れ子の整形 / S: 関数型のチェーン・i < n）。`groupOk` = 組の変数が関数型を跨がない（rguardN）∧
  ガードの無い参照の辺に閉路が無い（沈みの代入〔ガードなしの組の変数を持たない成分の変数をintに〕をn周して全成分が沈み — 抽出できる形: Tyの構造的再帰とNatだけ）。
  n = 1で1束縛の μ の整形（変数はガードの下だけ・関数型を跨がない）と同じ。健全性の証明はgroupOkを使わない（型代入で保たれること〔groupOk_tsubst〕だけ — 型引数の整形のため）。
  ガード = slice / mapの要素と **optの中身**（2026-11-04 — reprのタスクB0・ユーザー決定U6: 値のI系統〔`next L?` のチェーン・`l T?; r T?` の木〕。optを通る組の値も
  有限の項で、型規則・値の型付け・コピーの燃料は変わらない — 証明の変更なし。実装は組の成分を中身に持つoptを1セルのボックスで表す〔lowerの表現の選択〕）。
  証人 = consのチェーン（consΔ — 組んで和 = 6）・`A { b B? } / B { a A? }` は整形・`A { b B } / B { a A }`（住人のいない型）は整形の外。
- 絞りの消滅（2026-11-04 — W1-b・language.md 15節）: コアの規則は無変更（絞りは脱糖の再束縛 — ifnilのsomeの分岐のvar 0。代入の対象は外のT? のセル）。証人 = Examplesのwalk1（チェーンの歩き `while c != nil { s += c.v; c = c.next }` の脱糖後の形 — 型int・実行で6）・否定例walkStale（代入の後ろで外のセルを中身として読む形は型が付かない）。照合 = testdata/corevec_narrow（examples/narrow_* の脱糖後のコア — Lean ≡ Soberの検査器）
  型規則foldS / unfoldS / foldRs / unfoldRs（結論の型を構文で固定 — canonical_mus / canonical_muRs）・StackTyの4本・コピーのmuRsの分岐（relocW / xferW — 燃料は値のfoldの節で数えるので組でも同じ）。
  証人（Examples）= A ↔ B（A { as []A; bs []B } / B { bs []B; as []A } — 1束縛の μ では正準でない形）を組んで数える6 Def（深さ3 → 15・返り境界のコピーが組の μ を開く）+
  `a.bs[0]` の型 = Bの型（展開の等式）+ 否定例4本 + Sの組（F ↔ G）。
  照合: 本番のTyへの列挙（.pair/rec/r3e-real-enum.lean — 59,112本E1〜E12反例0）・抽出（ty_genに組の関数14本・記録に4つ目のフィールドd〔TMuRs〕）・tyvec 53関数 × 8000 = 424,000・
  Genに組の題材（24〜29 = 同じA ↔ Bの6 Def・分岐recDに組の3形）→ corevecのゴールデンを再生成
- 撤去の段階（R3e-3 — 置き換えの完了）: `Ty.mu` / `Ty.muR` の構成子と全分岐・型規則foldE / unfoldE / foldR / unfoldR・StackTyの4本・専用の補題
  （muOk / muROk / rguardと *_muR・canonical_mu / canonical_muR・clampR_sub_muR / relocR_sub_muR）を撤去し、証人（Mw・Tree）とGen / TyVecの題材を
  幅1の組（mu1 / muR1）へ書き換えた。checkerのTMu / TMuR・JSONの語mu / muRも撤去（tagとワードの番号を詰めた）・tyvec 50関数 × 8000 = 400,000・corevecのゴールデンを再生成。
  棄てた案 = 1束縛の μ を残して組と併存（μ の形が4種残り、今後のTy関数ごとに4分岐・脱糖器もn = 1とそれ以外で出し分け）/
  1束縛の μ だけで相互再帰を符号化（帰還頂点集合 ≥ 2のSCC — 例A { as []A; bs []B } / B { bs []B; as []A } — で宣言の型が展開の文脈で別の項になり正準形が無い — report-rec-7）
- 照合: 実装のネイティブの表現と、値ごとに自己完結の表へ書き換えた模型（language.md 1節の棄てた案A1 — 今の言語で書ける）の出力を差分で照合する

### domainの段階（2026-11-08 — コアとLean。決定はlanguage.md 11節「domain」）

K（ChanSt）にdomainの表（項目 = 状態の梱包・持ち手・入り終えた数・状態の型）と、入るtaskの列（オラクル — 鍵ごと。走りの入力で、機械は読むだけ）を足し、
式に `dnew r i t`（家のregion rに初期値iを梱包して作る）・`denter t d`（入る — 状態を今の最内のregionへコピーして受ける）・`dexit d v`（出る — 新しい状態を梱包して差し替える）・
実行時の値 `domV p k r` を足した。鍵は端点と同じ形（作ったtaskのid + 局所の通し番号 — 端点と数えを共有）。

- 機械: 入るのは「空き ∧ オラクルの次の番 = 自分」のときだけ・出るのは持ち手だけ（持ち手でなければ定義されたpanic）・まだ作られていないdomainへの入り / 出は待ち
  （失敗にすると作る前後で結果が食い違う — 作る前の鍵を他のtaskが知る方法は無いので、型付きのプログラムでは通らない）。taskの外では3つともpanic（端点と同じ）
- Kahn（`kahn_schedule` は言明の形のまま）: Opにdnew / denter / dexit・1鍵の小操作DMini（domainのフィールドだけを読み書き）。端点の操作とは別のフィールドなので常に可換、
  同じ鍵の違う行為者は両方が状態を変えて進むことがない（入るは持ち手の空きとオラクルの番が1本に決め、作るのは鍵の持ち主だけ）— 場合分けは `dmini_f_comm` の全数。
  オラクルはKの初期値（入力）なので、定理は「どのオラクルを固定しても、どのスケジュールでも同じ結果」になる
- 型（Typing）: `Ty.dom r s`（r = 家のregion — 端点と同じくregionsBelowはr < d）。dnewE（b ≤ r < d・初期値は状態の型とpayOk）・domVT（r < d・状態の型は共有の表 Ξ.dom）・
  denterE（結果はsを今の最内へコピーした型・b < d — 受ける最内が自分の世界）・dexitE（新しい状態はpayOk）。givableにdomainの行（家 ≤ scopeのregion・
  共有して渡す — 持ち主の札は無い）。ChanOkに表の対応と状態の梱包の型付き（domdom / domtyped）・StateTy.famの子の世界はdomの表を共有
- 進行: 入れない形・まだ無いdomainから出る形をBlockedに足した（famDen / famDex）。本体で死んだ持ち手はdomainを握ったままpanicの葉になり、他のtaskは待つ
  （コアのBlocked — 実装はこれを毒 → 死に解く。デッドロックをエラーに変える方向だけの精密化）
- 白リストの2行目（`dom r s` はmutFree）: 「Sharableの断片」は「Poolの可変スロットのために白リストを足したくなったら穴の信号」とした。警告の対象は、可変スロットへの参照を共有し、
  正しさを型の外の動的検査に頼る形だった。domainは (a) 状態へのmutが本体の中にしか現れず、外へはコピーした値しか出ない (b) 状態の更新が機械の1歩（denter … dexitの間は
  持ち手が排他）として体系の中に入る — 型の外に逃がす部分がない。1行目の `chan rc t` は旧MPMCチャネル（taskの中では凍結）なので、taskの木の中で生きる共有の型はdomainが最初
- 照合: Examples.lean（オラクル2通り × スケジュール2通りで結果がオラクルだけに依る・番でないtaskのBlocked・出ないまま終わった持ち手・本体で死んだ持ち手・
  持ち手でない出口のpanic・型の拒否）・corevec（Genのtaskの分岐にdomainの形・chaosと近傍ミューテーション — 被覆の除外を解除）・corevec_parの手書き7本
- 関数の実引数（2026-11-10 — language.md 11節「dの値」の改訂）: domVTの家のregionをimmの参照（loc）と同じ上界にした（値 `domV p k r` はr ≤ rtの `dom rt s` に型が付く）・
  Ty.subにdomの分岐（r ≤ r' かつ状態の型は等しい）・paramOkのchanFreeをargFree（chanFreeのうちdomだけ通す — 状態はchanFree）に。retOkはdomを拒否したまま。
  Defの本体は Ξ = ∅ の世界で型付くが、domainの値は仮引数の変数としてしか本体に現れず、呼び出しの後の置換は呼び手の Ξ で型が付く（locと同じパス）。
  追従したのはdomVTの逆転の補題（canonical_domがr0 ≤ rを返す）・subの逆転（sub_dom_invが上界を返す）・subの保存の系統（shiftR / renR / tsubst / clampR / relocR）・relocW_okのdomの葉。
  照合 = corevec_parのpos_dom_arg（同じ深さ）/ pos_dom_arg_inner（1レベル深い呼び出し — subの上界の分岐）/ neg_dom_ret（retOk）/ neg_dom_arg_chanstate（argFree）
- 棄てた案: 型のrcをchanと同じ「regionの数」で持つ（regionの写像rmapの0の境で家のregionの対応が崩れ、givableが写像で保てない）・
  オラクルを項目にコピーして先頭を消費する形（作る操作がオラクルの表を読むことになり、1鍵の小操作の可換性の場合分けが表をまたぐ — 入り終えた数で引く形にした）

## 借りるもの

| 前例 | 借りる点 | 借りない点 |
|---|---|---|
| Tofte–Talpinのregion calculus（`letregion ρ in e`） | regionを型に持つ参照 `Ref ρ T`、regionのLIFO解放、型付け規則でescapeを禁じる形 | region推論（Soberは構文 = ブロックでregionが決まるので推論不要）、effectによるregion多相 |
| Cyclone | region変数のスコープ規則、「外側のregionへの参照は内側から持てる、逆は不可」の型付け | 動的region、unique pointer |
| Verona（region ownership） | regionを並行性の単位にする発想、region間で共有できるのはimmutableのみ | 任意所有グラフ、regionの動的な受け渡し |
| RustBelt / Oxide | 「借用の任意グラフだと何が難しいか」の反面教師 | ほぼ全部 |
| Featherweight Java / Goの形式化（Featherweight Go） | 最小体系の切り方、progress / preservationの証明構成 | — |

## 進め方

1. 体系の定義（構文・型付け・意味論）をLean 4で書く。最初は定理3だけ（regionなし）で進め、preservationが通ったらregionを足して定理1、最後にparallelを足して定理2
2. 各段階で「定義がSoberのdocs/language.md / region-domain-pool.mdと食い違ったらdocs側を直すか体系を直すか」を決定として記録する。体系と紙の仕様の差を放置しない
3. 証明が壊れる設計変更は、壊れた補題をdocsの当該節に一行で書く（「この規則は定理1の補題Xが依存」）
4. 型検査器そのものをLeanで書き、Phase 2の本番にする（下記「実装との照合」）。証明済みの型付け規則と型検査器のコードを同じ定義から出す

## 脱糖器の規律 — 形の変換だけを許し、意味の実装を禁じる（決定2026-09-19）

第三弾の入口でmapを「slice + 探索ループへの脱糖」で済ませる案が出て棄却された。
表現は可能だが、checkされる線形探索プログラムとcodegenのハッシュテーブルが構造的に
別物になり、観測同値の義務がop単位からプログラム単位へ太る — しかも未検証のまま
脱糖器に溜まる。以後この方針を規律として固定する。判定テストは2つ:

1. ソースに無いデータ依存の制御フローを合成しない。switch → eq + ite連鎖は
   ソースが書いた分岐の変形で可。stringリテラル → append連鎖はリテラル長で有界な
   展開で可。mapのget → 探索whileループはソースに無いループの発明で不可
2. codegenとの一致が構成的に出るものだけ。同じ評価順の局所テンプレートを両者が
   独立に踏む（switch・inline展開）か、同じコードを共有する（loaderのconst畳み込み）か。
   「別アルゴリズムだが観測同値」の主張が要るなら、それは脱糖でなくコアop
   （証明で担保）かstd（Soberで書いてcheckに掛ける）の仕事

判定基準（追記2026-09-26、ユーザーの注意喚起による）: 1ノードが入力データに
依存しない固定テンプレートのコア項に変換されるなら形の変換（`&&` / `||` / `!`・bool `==` の
ite化はこちら）、入力に応じてループ・走査・状態を生成するなら意味の実装（mapの
slice + ループ脱糖の棄却はこちら）。テンプレートが2階層以上ネストし始めたら、脱糖に
足すのでなくコアにopを証明ごと足す側に寄せる。迷ったら実装せず決定に上げる。

点検項目（追記2026-10-02 — 3' の脱糖テンプレート監査より）: 上の「形の変換か」の判定に加えて、ann・期待型を伴うテンプレートは、
対になる経路を全部洗う — 初期化 / 代入・if / switch / ifnil・通常 / byte文脈。監査（2026-10-02）で「意味が混ざる」テンプレートは0件だったが、
check ⊂ buildの穴6つ（F-f / F-l / F-m / F-n / F-o / F-p）は全部「緩める道具（ann・computeTyの型の読み取り）が一部の経路にだけ配線されていて、
対になる経路に無い」適用漏れだった（例: F-gのifの分岐の合流がswitch・ifnilに無い・mutの初期化のannが代入に無い・computeTyのifがswitchに無い）。
ann・型の読み取りを1つの経路に足すときは、同じ表に並ぶ経路を同じ変更で揃えるか、揃えない理由を書く

- 文字列補間 `${}`（2026-09-27、随時回収R7）: 固定テンプレート — テンプレート正規形（定数部n+1 + 穴n）を
  左から `+` の連鎖に畳み、穴は型で包む（stringはそのまま、intは `strings.Itoa(e)`（2026-10-01にstd命名規則で `strings.FormatInt` へ改名・2026-10-20に `convert.FormatInt` へ移動）、boolは
  `if e { "true" } else { "false" }`、他は拒否）。型判定だけが各層の持ち物で、組み立てはsrc/stage1/interp.zig 1箇所
  （desugarはcomputeTy + struct判定、codegenは穴を合成名のローカルへ束縛して型を得てから同じ関数を呼ぶ —
  Itoaは純粋なので変換の位置の違いは観測されない）。コア・証明・JSONは変更ゼロ。
  int → stringはbuiltinでなくstd/stringsのItoaをSoberで書いた（digitのswitch + 連結、最小値は綴りで返す）—
  判定テスト2の「std（Soberで書いてcheckに掛ける）」側。補間を含むファイルにはcst_to_astが予約参照名
  `$strings` でstd/stringsを暗黙importする（for式のstd/iterと同じ機構）。棄てた案: int→stringのbuiltin
  （コアとLeanにopが増える。stdで書ける）、利用者に `import "std/strings"` を要求（書いていない名前に依存する）。
  突き合わせ: examples/interp.sober(.out)（入れ子・エスケープ・最小値 / 最大値・評価順）、src/stage1/interp.test.zig

- 文位置のifの分岐（2026-09-27、V5-7）: 値を捨てるif文（`.expr` 文・else ifのチェーン・ifnilを含む）は分岐をdiscardで脱糖する —
  分岐の末尾の値を `let _ = v in triv` に包む固定テンプレートで、codegen（文位置の値は捨てる）と揃える。既存3例のコアJSONが
  let 1つぶん変わった（受理は不変）。捨ててよいのは呼び出しの結果だけ（決定C 2026-09-27 — 純粋な式の式文はloaderの
  src/stage1/exprstmt.zigが脱糖の前に拒否するので、分岐の末尾に届くのは呼び出しか入れ子の文位置のif / switch / ブロックだけ）

但し書き: 値表現の同値はLean世界で論証済みなら可（stringリテラルの
「rodata = mut構築 + freezeと観測同値」— 制御フローなしの値構築に限る）。
アルゴリズムの同値は不可。

帰結の線引き: 組み込みコンテナ（slice / map）= コアop、それ以外のデータ構造
（HashMap等）= std（Sober製、check対象）。既存脱糖の監査（2026-09-19）は全項目
規律内 — pair/prodのチェーンは型レベル符号化（評価順保存）、ifnilは注釈埋めのみ、
mut → refは局所テンプレート。ann（V3-5）は注釈埋めのみで、注釈の誤りはLeanの誤拒否にしかならない。

### 脱糖器の座標精度の段階（2026-09-27〜28回収 — selfhostの実地、F-11 / F-14 / F-24 / F-25 / F-34）

selfhost（compiler/ をSoberで書く）で、手で書けば通る形が脱糖器の座標の読み違いでdef errorになる例が続いた。
どれも言語の決定ではなく脱糖器の精度の不具合として直した（正式承認2026-09-28）。Lean・コアのopは無変更 — 足したのはann（注釈埋め）と
型追跡の精度だけで、annはTy.subの範囲なので誤りはLeanの誤拒否にしかならない（上の但し書きの内側）。共通の規律:
緩めるのは行き先の型が確定している所だけ、緩める向きだけ、型が一致・不明・形違いなら付けない。

- 展開の値引数の正確な型（F-11 — Binding.core_ty）: 展開（inline / ラムダ）の値引数は展開点の点座標でannされる（V3-5 ③）ので、
  Def本体では仮引数のimm slice（署名のr0）が `[r1]` に緩み、展開先からanchorつきのmut Def（R2）へ渡すと31節のanchor 1 slotの制約で落ちた。
  実引数が名前で、束縛がコア上の正確な型（新設のcore_ty — Defの値仮引数 = 署名の型、展開の値引数 = annした型）を持ち、それが点座標より
  締まっているときだけその型でannする。棄てた案: Binding.tyでクランプする（入れ子の展開でtyがcalleeのbase座標のまま残り、逆にクランプしすぎた）・
  展開の値引数のannをやめる（V3-5 ③ を崩す）。回帰例examples/inline_anchor
- 名前でない式のreturn（F-14 (1) — retValue / retExprTy）: 式の型（computeTy。if式は両方の分岐が単一式で型が一致すればその型）が結果型より
  締まっているときだけ結果型へann。Defの本体のreturnに限る — 展開の中のreturnに付けると、strings.Keepの結果（Arenaのregion — 浅い）を
  展開点の座標へ緩めて、その先のブロック脱出が要る精度を失った（pool_string）。回帰例examples/param_slice_ann（(1)(2) 共通）
- appendの値（F-14 (2) — appendValueAnn）: subjectが名前のmut束縛のmut sliceで、値の型が要素型（束縛点の点座標 — mut束縛のセル型の不変条件）
  より締まっているときだけ要素型へann。回帰例examples/param_slice_ann（(1)(2) 共通の回帰例）
- mut structのフィールド代入の値（F-14 (3) — fieldValueAnn）: `s.a = p`・入れ子 `o.box.a = p` の値に、フィールドの宣言型を束縛点の点座標へ
  コピーした型へのann（(2) と同じ規律）。同時代入には付けていない。回帰例examples/field_param_ann
- 戻り値のmapのキーの座標（F-24 — retTy）: 戻り値の座標の付け替え（R0 / R4a — 最上位とimmコンテナの中身はr1）をmapの値型にだけ分配し、
  キー型に分配していなかった。LeanのretOkはキーのr1も許すので、既存の規約の分配漏れとして直した
- callの結果の座標（F-25 — computeTy・callResultTop）: computeTyがcallの結果型を署名の座標（r0）のまま返していた（round4の保留
  「現状無害」）。素のDef呼び出し（展開されない・mut引数なし・mut_defでない）の結果を呼び手の最内regionに読む（Leanのret.relocR d′ と一致）。
  展開される関数とcallMは結果の座標が別の規則なので従来どおり — 最初は適用したがArenaのregionの精度を落とした。F-24と合わせた回帰例examples/ret_coords
- mapの添字の値の座標（F-34 — mapValueAt、2026-09-28）: `m[k]` のgetmの注釈 `t`（とcomputeTyの `m[k] : V?`）が宣言の型式から作った型（stringはr0固定）のままで、
  関数のframe（r1〜）で組んだmapの値型より締まり、Leanのgetmの `Ty.sub t' t` で落ちていた（mainの中では偶然通る・値がintなら無関係）。
  セルが実際に組まれた点の座標で読む: 名前の束縛はコア上の正確な型（core_ty — Defの値仮引数・展開の値引数）があればそれ、無ければ束縛点
  （F-26のmapCellAtと同じ解釈 — mapリテラル・呼び出しの結果・mut束縛はそこで組まれるかコピーされる）、辞書constの参照は参照点で展開される（language.md 25節）ので現在の点、
  他（フィールド・式）は宣言の型のまま。既存のゴールデンはバイト不変（既存の例のgetmは値がintかmainの中）。回帰例examples/map_value_coords
  （仮引数のmap・局所のmapをreturn・辞書const（@embed）を関数の中で直接 / 束縛して引く — 修正前はdef error）。sliceの添字（index）は型の注釈を持たないので同形は無い
- 残り（直さない）: 分岐のregionが違うif式（`f(if c { cat(a, b) } else { p })`）は、分岐の型の合流（上界のjoin）が新しい型規則の側なので直さない —
  分岐ごとに呼ぶ / returnすれば書ける。同枠（F-35）: `string(if c { bytes(".") } else { dir })` — 分岐が「リテラル由来のview（最内regionのimmセル）」と
  「仮引数のslice（r0）」で違い、コアのiteは分岐の型の一致を要る。片方をannで揃えるには行き先の型（上界のjoin）を脱糖器が決めることになり、
  「行き先の型が確定している所だけを緩める」規律の外。書き方: 分岐ごとにreturnする小さい関数（src/compiler/loader/embed.soberのorDot）— 回避を本来の形として残した
- 名前への代入の値（F-36 = F-o — 2026-10-02回収）: mut束縛への単純な代入 `mut entry := ""; entry = args[i]`（仮引数の []string）がdef errorだった — 束縛のセル型は初期値の座標、
  代入する値はr0で締まっている。(3) のfieldValueAnnをパスの無い名前にも通す（束縛点の点座標へ緩める — 同じ解釈）。回帰例examples/assign_param。
  対の初期化側（F-q — 2026-10-02）: 仮引数のフィールドで初期化したmut局所（`mut x := p.f`）はセルがr0のままで後の代入が入らなかった — mutInitAnnを名前だけでなく
  フィールドの読み出しの初期値にも通す（値の型はcomputeTy）。既存のゴールデンは不変。回帰例examples/mut_init_field
- 分岐のregionの合流の横展開（F-m・F-l — 2026-10-02）: F-g（b685ad1 — 値位置のifの両方の分岐を最内のregionへ上げた型が一致すればannで緩める）と同じ判定を、
  値位置の定数switchの全分岐（defaultを含む — 分岐の型が1つでも分からなければ付けない）とflow typingのif（ifnil）の両方の分岐にも掛ける。回帰例examples/switch_region_join・
  examples/ifnil_region_join。型switch（unionSwitch）の分岐はまだ
- switch式の値の型（F-n・F-p・ifの分岐の中のswitch — 2026-10-02）: computeTy・declOfExpr・retExprTy・exprSty0が
  if式と同じくswitch式の分岐の末尾を辿る（computeTy = switchTy〔case → defaultの順に分かる方〕・declOfExprは同じ順で最初に分かる宣言・
  retExprTyは全分岐が単一式で型が一致すればその型・exprSty0は型なしの定数でない最初の分岐）。switchを返す本体に結果型のannが付く —
  既存のコアのゴールデン40本が変わり、差分はannの包みだけ（両側からannを剥がした木が40本すべてで一致・他の差分0・ann +56・EXCLUDED不変）。回帰例examples/switch_value_ty
- 値の配置先の座標で読む（F-f・F-h — 2026-10-02）: computeTyが、文字列リテラルを宣言の座標（tString = r0）で、structリテラル・フィールドの読み出しを
  宣言の型のまま、if / switchを合流前の分岐の型で読んでいたので、ブロックの出口の付け替え（R5）が「regionが上にない」と見て発火しなかった
  （`x := { "a" }` のtype error・`return { "a" }` のdef error・ブロックの中からのreturn）。解釈を「値が実際に置かれた座標」に揃えた:
  文字列リテラル = コアのstrlitと同じ `rdepth - 1`・structリテラル（litStructTy）= フィールドごとに値の式の型（regionだけ違う同じ形のときだけ）・
  フィールドの読み出し（selectorTy）= 土台の値の型の成分（同じ条件）・ifTy / switchTy = 合流（upJoin2 / upJoinN）が掛かるなら合流した型。あわせてR5の宛先を
  `upRegion(want, kk)`（期待型が兄弟の分岐の仮引数のr0のとき、Defの中で書けない呼び手のregionを宛先にしない）。tStringそのものは変えない
  （型式 `string` の解決 = 宣言の座標でも使う — 変えると受理済み148本中64本が拒否に戻ることをスパイクで確認）。
  残る食い違いは1か所: Def呼び出しの実引数に直接書いた文字列リテラルはコアがregion 0（call.sober — F-6）だが、その節のcomputeTyを引く経路が無い
  （呼び出しの型は署名から・型引数はregionを持てない）ので観測されない。ゴールデン: コア54本が変わり、差分はannの包みだけ（54本すべてでannが減る —
  882 → 677・EXCLUDED不変・全entryでstage2のcheckとLeanの判定が一致150/150）。回帰例examples/block_region_value・examples/block_return

- 同系統の3項（F-ba・F-bb・F-bc — 2026-10-17・report-746 / 767）: どれも既存の規則の書き漏らしで、checkが誤拒否・buildは正しく走っていた。
  Lean無変更（手で直したコアをsober-checkが受理することを3件とも確認 — report-767 2節）。
  - mut束縛の初期値がstructリテラル（F-ba）: mutInitAnn（F-q / F-af）の形の門が名前・フィールドの読み出し・添字だけで、`mut w := W{xs: xs}`（仮引数のsliceのフィールド）の
    セルがr0のまま残り、callMの呼び出し点でanchor（= 束縛点）のコピーと不変の位置で合わなかった（下の「checkのcallMの段階」の (ii)）。門にstructリテラルを足す。
    棄てた案: 形を問わず全ての初期値に掛ける（前例の無い形にもannが付く — 要るまで入れない）・callMに渡るmut局所だけクランプする（mutInitAnnは要るときだけ付くので不要）
  - 外の場所へ代入されるstructリテラル（F-bb）: M4の行き先構築（language.md 21節 — 新しいmutのコンテナは行き先のregionに作る）が素のslice / mapリテラルにしか
    届かず、ループの中の `w.in = In{}`・`w = W{…}`・`w.eh = builder.Builder[int]{}`（省いたフィールドのゼロ値のmut slice）が反復のregionに作られていた。
    行き先をstructリテラルのフィールド（入れ子のリテラル・省いたフィールドのゼロ値）へ引き継ぎ、行き先より深いimmのフィールドの値はコピーする（sliceリテラルの要素と同じ）
  - 関数型の仮引数の呼び出しの結果の座標（F-bc）: 展開されたラムダの結果は呼び出し点の最内に作られるが、computeTyがその座標で読めず、ループの中から
    外のmut束縛への代入に境界コピー（storeCopy）が付かなかった。展開される関数の結果（F-ayのplainResult）と同じく最内で読む
- F-baの残り2項（2026-11-01）: 同じく書き漏らし・Lean無変更（直したコアをsober-checkが受理）。
  - mutの成分を持つstructの初期値: mutInitAnnの門の比較（脱糖器のtyLooser — Ty.subの鏡）がmutの成分で常に偽（Ty.subは等しい型を通す）で、
    `mut w := W{cx: c}`（`sc mut []int` のフィールドを持つ）にannが付かず、セルのimmのフィールドがr0のままcallMの呼び出し点で合わなかった。tyLooserのmutの分岐を
    Ty.subに揃え（等しいときだけ真）、structリテラルの型（litStructTy）は書かないフィールドのゼロ値を点座標で読む（ゼロ値はその点で作られる）
  - フィールド・添字の連鎖へのappend（`w.sc = append(w.sc, ts[0])`）: appendValueAnnのフィールドの分岐は境界コピーだけで、コピーしない外のimmの値を要素型の座標へ緩めるannが
    無かった（名前の分岐にはある）。名前の分岐と同じannを付ける。回帰例examples/mut_field_outer

### mut structのフィールドごとのセルの段階（2026-09-28、reaudit round 5 — F-17案2α）

問題（F-17）: mut structのフィールド代入は丸ごと再構築（「n項化の段階」— `p.y = v` → `assign p (pair (fst (deref p)) v)`）で、
書くフィールドの位置に依らず残りのフィールドを全部射影し直すので、1回の代入のコアがフィールドの数の2乗（nフィールドで ≈ 8.8·n² バイト。全フィールドを1回ずつ書くDefはn³）。
selfhostのcompiler/ はこれを避けて状態をintヒープ1本に畳んでいた（selfhost品質の保留 ①）。加えて、フィールドをmut実引数にできない
（refがセル単位 — language.md 26節の旧記述）ことが、structの状態へ戻したときの `Push(mut st.nodes, x)` を塞いでいた。

形（脱糖器だけ — コア / Leanの変更ゼロ）: 宣言の型がstruct（型パラメータ・`T?` でない）のmutの場所（mut束縛・mut仮引数）を
フィールドごとのセルに分割する。束縛の変数はrefのprodのチェーンを持ち、struct型のフィールドは同じ形に再帰的に分割する（木。フィールド1つならref 1つ、0ならtriv）。
- 生成 `mut x := e` → `let t = e in CELLS(t)`（葉ごとに `alloc mut (proj t i)`）。読み `x.f` → `deref (proj x f)`、値としての `x`（immで渡す・
  返す・コピー）→ 葉をderefしてpairのチェーンに組み直す。代入 `x.f = v` → `assign (proj x f) v`、`x = e` / `x.s = e`（structの場所）→
  値を束縛して葉ごとにassign。複合代入 `x.f op= v` も葉なら書ける（旧: フィールドパスは断片外）
- mut実引数 `mut x` / `mut x.f` → 場所のref（の木）をそのまま渡す（展開は場所の型 — 葉 = `ref true r t`、木 = refの木 — でann）。
  Def（R2のcallm）のmut仮引数の型はstructならrefの木（`Ty.paramOk` は構造的なので受ける）。フィールドのセルは全部束縛点のregionにalloc
  されるので、31節の「複数のmut引数は同じregionの束縛」にそのまま収まる
- 入れ子を再帰的に分割する理由: mut仮引数の表現を「structの場所 = refの木」に揃えないと、フィールドがstructの `Push(mut st.nodes, x)`
  （Builderはstruct）の別名渡しが型で合わない（1レベルだけ分割するとst.nodesはBuilder全体を持つ1セルで、Pushの仮引数は分割した木を期待する）。
  型パラメータで宣言したフィールドは葉 — 呼び手（インスタンス化済み）とDefの本体（型パラメータのまま）で分割の仕方が揃う規則にするため

規律の判定2（codegenとの一致が構成的に出る）の非形式の論証（観測同値で通す）: lowerは連続した1つのアグリゲート + 内部
ポインタ（フィールドのアドレス）で、checkのモデルはフィールドごとのセル。両者が観測で一致する理由:
1. フィールドを指す別名はmut実引数でしか作れず、どちらの側も「同じフィールド」を指す（lower = フィールドのアドレス、check = フィールドのセルのref）。束縛全体の別名
   （`mut x`）も、lower = アグリゲートの先頭、check = refの木で、以降の読み書きはフィールド単位で対応する
2. アグリゲート全体を一度に読む・書く操作（値としての `x`・`x = e`）は、フィールドごとの読み書きの列と同じ結果になる — フィールドどうしは重ならず、
   その列の途中で他の文は走らない（組み直し・書き込みの式は制御フローを持たない固定テンプレート — 判定1も満たす）
3. structのセルはfreezeされない（freezeはslice / mapだけ — 17節）ので、実行時のタグ検査（assignのpanic）の出方もフィールド単位と
   全体で変わらない。region: フィールドのセルは束縛点でallocし、アグリゲートも同じregionのフレームに置く — 寿命が同じ
Leanでの値表現の同値の証明は置かない（決定 — 非形式の論証で通す）。

効果（実測）: 全フィールドを1回ずつ書いて読むDefのコア — n = 16で53 KB → 12.7 KB、n = 64で2.38 MB → 123 KB。
棄てた案: 案1 = コアに浅いフィールド更新op（Lean 150〜250行 — 書き込みは定数になるが、mut実引数の問題は別の手当てが要る）、
案2β = letで背骨を共有する再構築（Lean 0行・1/8 — 同じくmut実引数の問題が残る）。

帰結: 凍結コーパスのdesugarのZig ≡ Sober照合（scripts/selfhost_desugar.shのentry列）は退役（mut structの束縛を持つentryのコアの形が
変わり、型も変わるので正規化でも戻せない）。コアASTのゴールデン（第3のゴールデン）はSober生成で作り直す。

### region透過の実体関数の段階（2026-09-29、stack-audit — 決定 δ）

問題: mut引数を持つ非再帰の関数は全部呼び出し点に展開していた（language.md 26節の旧実装）。-O0では展開の入れ子が掛け算になり
（src/compiler/appのIR 217万行・inline展開 約5.3万回）、コード7倍・CPU 2〜5倍を実測した。R2のDef（自分のregionを開くanchorつき呼び出し）に
一般化するとanchor 1 slotの制約でcheckがcompiler/ の28本を拒否する。

形（lowerだけ — Lean・脱糖器・検査器の変更ゼロ。checkは今どおり展開として型付けする — 2026-10-02以降は下の「checkのcallMの段階」で一部をcallMのDefとして型付ける）: 関数型の引数を持たない・mut引数を持つ・
非再帰（loaderのexpandsのうち関数型の引数の無いもの）の関数を、`--passes` のbuildでは実体の関数として呼ぶ。本体の入口で深度を読んで
退避するが `region.enter` しない。出口（普通の出口・return・`?`）は退避した深度へ戻し、戻り値の境界コピーのfloor = 入口の深度。
mut仮引数は呼び手のセルのアドレス（R2のmut_defと同じ呼び出し規約）。ジェネリックはlowerのインスタンス化で単相コピー
（型引数の制約は展開と同じ — 値を持つ型ならstring / slice / mapを含んでよい）。

展開 ≡ 透過関数の非形式の論証（観測同値で通す）: 同じ呼び出しを展開で下ろしたIRと透過関数で下ろしたIRは
- (a) 本体の命令列が同じ: 仮引数の束縛 = 実引数の値（アグリゲートは自分のスロットへコピーする — 展開の束縛もコピー。immなのでコピーと元は
  観測で区別できない）、mut仮引数 = 呼び手のセルのアドレス（展開でも同じセルの別名）
- (b) regionの出入りが同じ: どちらも入口の深度を読むだけで `region.enter` しない — 本体の確保は呼び手の最内regionに積まれ、本体の中の
  ブロックが開くregionはどちらでも同じ深さから数える。出口はどちらも入口の深度へ戻す。戻り値のrelocateのfloorは、展開 = 呼び出し点の深度、
  透過 = 入口の深度で、同じ値（呼び出し命令は深度を変えない）
- (c) 違いはフレーム（ネイティブのスタックとスロット）と制御の移り方（call / retとbr）だけで、どちらもソースの観測（出力・終了コード・
  panicの種別）に現れない。非再帰なのでフレームの深さは有界で、regionの深度の上限（27節の1023レベル）も消費しない
→ 8節「展開は生成方式、意味には触れない」の3例目（関数型引数の展開・ジェネリクスの特化に続く）。checkが展開として型付けした意味を
そのまま実行するので、受理の集合は変わらない（anchor 1 slotも掛からない）。

Defで下ろしてはいけない理由（健全性）: 自分のregionを開くと、呼ばれた側で組んだ値（string等）をmut仮引数のフィールドへ格納する書き方が、
戻りでregionごと消えて宙吊りになりうる — 展開の型付けはその値を呼び出し点のregionのものとして受理している。透過（regionを開かない）なら
値は呼び手の最内regionに置かれ、呼び手の束縛より長くは生きないが短くもない（展開と同じ）。

適用箇所: lowerの全部のパス（ELFのbuild・自己ビルド・rawの `--emit=ir|ll` / `build --no-opt` — rawへの拡張2026-10-29・report-1278 —
展開の形は呼び出し点の数 × 葉の深さで太り、@std/cli.Specが1関数110万行になった）。旧の展開の形は開発用のオプション `SOBER_RAW_EXPAND=1`（rawだけ）に残し、
「展開 ≡ 透過」はoptdiffのexpxが期待値を介した実行の照合で見張る（展開のオプションでビルドできないentry — scripts/noopt-excluded.list — は検査の限界として外れる）。
ゴールデン（irtext / lltext）とZig ≡ SoberのELFの照合（elfeq）は透過の形が相手（stage1も同じIRを食べる）。
棄てた案: α 全部Def（上の拒否28本 — frameで作ったimmを渡す / regionの違うmut実引数2本 / R3）、α' 全部Def + Leanで制約を撤去
（証明の波及が大きい）、β 呼び出し点ごとにDef / 展開を選ぶ（判定が型と構文に依る実装規則 — 脱糖器とlowerの二重実装）、`@noinline` の個別指定
（利用者に回避を要求する）。


### checkのcallMの段階（E2-S — 2026-10-02、決定 = night-adjudications 12〜15）

問題: δ（上の段階）はbuildだけの生成方式で、checkはmut引数の非再帰関数を今も呼び出し点ごとに展開して型付けする。自己適用の
コアの95.5%が展開（std/tableのGet / Push / Set / Lenだけで49%）で、checkの時間の約2/3・RSSの約半分が展開の再脱糖だった
。

形（Lean・コアの規則・lowerは無変更）: 脱糖器が、δ の対象（関数型の引数が無くmut引数だけが展開の理由の非再帰関数）のうち
次を満たす関数を、展開でなく既存のcallM（R2のanchorつき呼び出し — Typingの `callM`）のDefとして出す（実装src/compiler/desugar/e2s.sober・逃げの周回src/compiler/checker/e2s.sober）。

1. mut仮引数がちょうど1つ（anchorが1 slotで足りる）
2. 他の仮引数はregionを持たない型（int / bool / byte / named scalar / それらのstruct）— imm実引数の「anchor以下」の条件が呼び出し点に依らない
3. （呼び出し点ごと — 2026-10-03改訂D'）型引数がregionを持つ呼び出し点（R3の門 — tyArgOkでない）は、その呼び出し点だけ展開する。関数は上げたまま
4. （呼び出し点ごと — 同上）フィールドの経路のmut実引数 `mut x.f` を渡す呼び出し点は、その呼び出し点だけ展開する。関数は上げたまま
5. 本体の中でcallMで呼ぶ関数（再帰するmut関数・@noinline・上げる候補）へmut実引数を2つ以上渡さない（anchor 1 slot — 2つのmut実引数が
   別のregionから来るとcallMの規則が落ちる。保守的に「2つ以上」で外す — 逃げの周回を予防する静的な判定。S0の残り1本checkerのverdictは
   再帰するtyJsonへ `mut st`〔呼び手空間〕と `mut out`〔自分のフレーム〕を渡す形でこれに当たっていた）
6. 本体がDefとして型付く（検査器の判定。落ちた関数は展開へ戻す — 逃げ。展開に戻すのは型付けを緩めるだけなので単調に収束）。
   S0スパイクでは自己適用で10本が落ちたが9本はF-e（戻り値の無い関数の末尾の式文を値にしていた脱糖器の穴 — 686fb0bで修理）が原因で、修理後は1本（checkerのverdict）

上げる判定は条件1・2・5・6（関数の署名と本体）だけで決まり、packageの中で閉じる（3'' のcheckの小分けの前提 — 依存する側は呼び先の
.sobiのマーク〔逃げ = `@expand`〕を読む）。条件3・4は呼び出し点の形の門で、合わない呼び出し点を展開へフォールバックするのは下の論証の向き（callMで型付く ⇒
展開でも型付く）に沿うので受理集合を変えない。棄てた案（2026-10-02〜03の形）: 条件3・4を関数のマークにしてプログラム全体の呼び出し点の
走査で決める — 1か所の `mut x.f` で全呼び出し点が展開に落ち（自己適用で呼び先71本・822件がpackageをまたいでいた）、
依存する側の呼び出し点が呼び先の判定を変えるのでpackageの中で閉じない。改訂でコア98万 → 79万節。

buildは今どおり δ（regionを開かない実体関数）で下ろす。checkが型付けする形（callM — 自前のregionを開く）とbuildが走らせる形が
別になるので、両者を繋ぐのが次の論証。

callMで型が付く ⇒ 展開でも型が付く（非形式の論証 — inlineの許容性）

呼び出し `callM f ts e`（深さd、anchor a、`b ≤ a ≤ d − 1`）が型付くとする。前提はTypingのcallMの規則: 実引数e : ta、
`ta ≤ (f.param.inst ts).renR a d`、結果の型 `(f.ret.inst ts).relocA a d`。fの本体BはDefの世界（深さ2 — region 0 = 呼び手空間・
region 1 = 自分のフレーム、Γ = [param]）で型付いている（defsOk）。

展開の形は、脱糖器のinlineCallが作るもの: 仮引数を実引数に束縛し（annで仮引数の型へ緩める — `ta ≤ σ(param)` なのでannが付く）、
本体を呼び手の深さのまま（blockで包まない）、戻りのラベルで受ける。ここで写像

  σ: 0 ↦ a、1 ↦ d − 1（呼び手の最内）、k + 1 ↦ k + d − 1（本体の中のblockが開くregion — 呼び手の最内の上に積む）

を考えると、展開した本体の型付けの導出は、Bの導出の全てのregion添字・深さを σ で写像したものになる。根拠:

- (a) 型付けのregionの条件は σ で保たれる: HasTypeの前提に現れるregionの比較は全部 `≤` 型（`b ≤ r`・`r ≤ rt`・`regionsBelow`・
  `b ≤ d`・callMの `b ≤ a ≤ d`・jumpの `clampR` / `jumpRel`）か、深さとの `r < d`（regionが今の世界にある）。σ は単調（a ≤ d − 1 ≤ k + d − 1）
  なので `≤` は保たれ、深さはDefの世界の2 + jが呼び手のd + jに変換されるので `r < d` も保たれる。2つのregionの狭義の比較は前提に無い
  — σ がregion 0と1を同じregionに潰す場合（anchorが呼び手の最内 = a = d − 1）でも崩れない
- (b) 既存の写像定理との関係: Ren.leanの `ren_typing`（callMのpreservationの根拠）は `rmap ρ0 δ`（0 ↦ ρ0、k + 1 ↦ k + 1 + δ）で、
  `ρ0 ≤ δ` の狭義単調な写像に限っている — フレームを呼び手の最内の上の新しいregion（d）へ対応させる形（= callMの実行: 自前のregionを開く）。
  展開はフレームを呼び手の最内そのものへ対応させる（σ は1 ↦ d − 1）ので、`ren_typing` を「単調（狭義でなくてよい）な写像」へ一般化したものが
  この論証の形式版になる。狭義単調を使っている箇所は (a) の通り比較の向きの保存だけの見込み — Leanの補題（後追いの別の段階）で確認する
- (c) 実引数: 展開は仮引数を `ann e σ(param)` に束縛する。callMの前提 `ta ≤ param.renR a d` は σ(param) と同じ型（region 1は仮引数に
  現れない — 仮引数は呼び手空間のregion 0かregionを持たない型だけ。retOk / paramOk）なので、annの `Ty.sub ta σ(param)` がそのまま成り立つ
- (d) 戻り値: callMの結果の型 `relocA a d` は、本体の値の型のregion 0由来をaへ・フレーム由来を呼び手最内へクランプしたもの = σ(ret)
  （relocAの定義 — 自フレーム由来の最上位はdへ。展開ではフレームの値は最初から呼び手の最内にある）。展開の戻りのラベルの型と一致する
- (e) 型引数: 条件3によりinst tsはregionを持たない型の置換なので σ と可換（`tyArgsOk`）
- (f) 非再帰: fは自分を呼ばない（δ の対象）ので展開は有限。本体の中の呼び出し（他のDefへのcall / callM）は、深さの一様な写像の下で
  規則がそのまま閉じる（Ren.leanの `Ty.shiftR_renR` / `Ty.relocR_renR` と同じ形）

→ check（callM）が受理するプログラムは、展開でも受理される。展開で型付いたプログラムのbuild（δ）が展開と観測同値に走ることは
上の段階の論証（展開 ≡ 透過関数）が与えるので、E2-Sのcheckの受理はbuildの実行の健全性に繋がる。逆向き（展開で型付くがcallMで
落ちる）には2つの場所がある。(i) 上げた関数自身の本体が落ちる（例: フレームで組んだ値をmut仮引数のフィールドへ入れる）— 条件6の逃げが展開へ戻す
（検査 = 受理集合の照合ゲート）。(ii) 呼び手のDefがcallMの呼び出し点で落ちる — callMはmut実引数のセル型を仮引数型のanchorへの写像
（renR a d — 仮引数のregionは全部aへ）と不変の位置で合わせるので、セルの中にaより古いregionが残ると合わない。(ii) は逃げでは拾えない
（逃げは呼び先の本体だけを見る — F-ba・2026-10-17）。(ii) を閉じるのは「mut束縛のセル型は束縛点の点座標」の不変条件（上の脱糖器の座標精度の段階 —
mutInitAnn・fieldValueAnn・M4の行き先構築）: anchor = セルのregion = 束縛点で、セルの中のimmのregionも全部束縛点へ緩めてあるので、仮引数型のコピーと
セル型が一致する（書かないフィールドのゼロ値・その場の空リテラルのmutの成分は束縛点で作られるので一致 — F-baの残り2項・2026-11-01）。残るのはセルの中のmutの成分（mutは緩められない）が束縛点より古い形だけ（ループの中で `mut w := W{buf: s}`〔s = 外のmut slice〕を
callMへ）で、language.md 21節の但し書き (β)（anchor 1 slot）と同じ根 — 拒否のまま記帳（実需なし・決定2026-10-17）。
棄てた案: 呼び手の落ちも逃げの周回で拾う（再帰の呼び先は展開できず救えない）・呼び出し点の静的な門で展開へフォールバックする（残りに実需が出たら再訪）。

残る義務（後追い — 別の段階）: (a)(b) のLeanの補題（`ren_typing` の単調な写像への一般化 + 展開の形の型付け）。それまでは上の非形式の論証と
受理集合の照合ゲートで検査する。

棄てた案: E2-M（anchorを列に — 残り1.4%のためにLeanの写像とcallMの証明を一般化）・E2-T（regionを開かないDefをLeanに —
α' と同じ大きさ）・E2-D（DAG + メモつき検査器 — 展開の再脱糖が残る。関数型の引数の展開の残り6.8%向きとして後で）。
（S0スパイク — コア −85%）

### callMvの段階（借りのクロージャのmut捕捉 — L1・2026-10-22、決定 = report-1034）

問題: 借りの位置のラムダがmutの束縛を捕捉すると（language.md 25節 (α-L1)）、クロージャのenvにref trueが入る。値の呼び出しcallvはcallに委譲し、
Defのregion 0を呼び手の最内dへずらす（`p.shiftR d`）。mutは正確一致なので、envのrefのregion（捕捉した束縛のregion）がdでなければ型が付かない
— streamのDefの中でemitを呼ぶ点では、捕捉した束縛はregion 0（呼び手空間）で呼び出しは深さ ≥ 2なので必ず食い違う。
（paramOkはR2以降 `regionsBelow 1 ∧ chanFree` でmutを許す — 落ちる理由はparamOkではない。旧記述の訂正）

形（Lean・コアの規則1本）: `callMv (a : Nat) (f e : Expr)` — callvのanchorつき版。aは構文のregionの注釈（copyTo kと同じくshiftTy / renTy / tsubstTyで変換される）。

- 型付け: `ef : fn p r`・`e : ta`・`Ty.sub ta (p.renR a d)`・`b ≤ a`・`a ≤ d` ⇒ `callMv a ef e : r.relocA a d`（深さd + 1）。
  callMから Δ の参照とanchorOfの前提を抜き、シグネチャを関数値の型から取る形（callvがcallから作られたのと同じ作り方）
- 機械: `callMv a f e` はf → eの順に値にし（枠callMvL / callMvR）、`fnref fn ts` ならcallMの本体の入口へaをそのまま渡して委譲する
  （callMKはanchorを実引数の値から `anchorV` で読むが、callMvは注釈のaを使う — envのunion〔借りの位置の関数型の構造ごと〕の片方のvariantの中のmutは
  anchorV / anchorOf〔prodだけを辿る〕に見えないため）
- preservation: callMの分岐はanchor aについて一様で、`anchorOf = some a`（hanc）は実行時のanchorが型のanchorと一致することにだけ使う。
  注釈で持てばhancは要らず、callvRのcanonical_fn + callMKの分岐のコピーで閉じる。progress / 決定性はcallvの分岐のコピー
- 脱糖器の使い方: 関数型の仮引数が（閉じた世界のenvのunionを通して）mutを含む値の呼び出しだけcallMv、それ以外はcallv（既存の出力不変）。
  a = 捕捉した束縛のregion（作成点）・実引数の型のmutのregion（借りの値を呼ぶ点 — Defの中では0）。immの成分がaより深ければcopyTo a（M4 (a)）

棄てた案: anchorOf / anchorVをunionへ広げる（inl / inrの注釈から反対側の型のmutTopを読む — 既存のcallMのhancの補題〔anchorV_eq〕を一般化する仕事になりcallMの証明の分岐に触る）・
2 slotのanchor（language.md 31節の保留のまま — 深いimmは形式コピーで足りる）。

### 省略可の匿名関数型の段階（Z — 2026-10-25、決定 = report-1156の決定・実装report-1157）— Leanは該当なし

language.md 25節Zの `put (func(b []byte) error?)?`。CLAUDE.mdの順序（docs → Lean → 検査器）のLeanの段階は**該当なし**として通す:

- コアにoptionの関数は届かない。loader（optfn.sober — namedargsの後・η の前）が有無の組ごとに関数を書き分け、有無の決まった `p != nil` のifを
  選んだ分岐に畳む。無い組ではpの仮引数もpへの分岐も消え、有る組ではpは普通の匿名の関数型の仮引数（既存の展開 + annのパス — V3-5）
- 上の「脱糖器の規律」の判定: (1) ソースに無い制御フローを合成しない — 消すだけ（静的に決まった条件の分岐を落とす）で、コピーは関数の特化
  （ジェネリクスの単相コピー〔25節〕と同じ「意味は1つ・実装は組ごとのコピー」）(2) codegenとの一致は構成的 — checkとbuildはloaderの同じコピーの木を読む
  （const畳み込みと同じ「同じコードを共有する」型）
- 参照の意味論（「無い / 借りの関数」のoptionと実行時の `!= nil`）に対して、畳みは展開時に既知の値の定数伝播 — 8節「生成方式は意味に触れない」の7例目。
  照合はLeanでなく受理 / 拒否の例の対（examples/optfn*）とcheck ≡ build（同じ木）で取る
- Leanに触れるのは棄てたZ-B（実行時のoptionの借り — 借りのクロージャの値の型付けにoptionの分岐）を採るとき

## 実装との照合（決定: Lean製型検査器を最初の本番にする）

「証明した性質が実装でも成り立つか」を機械化する方法は3段階ある。3 → 2の順で使う。

| 段階 | 方法 | 強さ |
|---|---|---|
| 1. トレース | Leanの定理名をmetaprogrammingで列挙し、Zigテスト名に埋めた定理名と差分を取る（dandori-gateの全行トレースと同型） | 存在の照合のみ。単独では弱い |
| 2. 差分テスト | Leanの型検査器・評価器は証明対象であると同時に実行可能な参照実装。ジェネレータ（`plausible` のジェネレータをJSONテストベクタとして吐く）でSoberコアの小プログラムを大量に作り、LeanとZigのaccept / rejectと診断を比較 | 同じ入力で同じ判定を保証。bdd-pbt-formal-ladderのPBT ↔ 形式手法の接合がここ |
| 3. gapを消す | 型検査器をLeanで書き、それを本番の型検査器として使う | 型検査器についてはテスト不要 |

### 到達しない項の段階（2026-10-01 — error網羅analyzer A5、決定E4-U = U-a）

errorのswitchの網羅を「リンク集合の全ラベル」から「analyzerの導出集合（公開の呼び先は宣言）」へ移す（language.md 13節 — F-33の解決）。
覆っていないラベルの分岐を埋める項がコアに要る — 今までは脱糖器が全variantの分岐を要求していた（覆わなければMalformed）。

- 構文 `Expr.unreach (t : Ty)`。子を持たず、型は注釈tで構文主導に決める（jump・nilと同じ — V4-2決定J1）。JSON `{"k":"unreach","t":T}`
- 型規則 `HasType … (.unreach t) t` — 前提なし。値を作らないのでregionの座標の約束（regionsBelow・jumpRel）が生じない（jumpの結果型に条件が無いのと同じ理由）
- 機械 `.eval H S (unreach _) ↦ .panic H`（ゼロ除算・タグ検査と同じ終端 — 27節の「到達 = バグ」、実行系はexit 101）
- 定理への効き方: progressは1歩でpanicの枝・preservationはpanicが終端で型の義務なし（StateTy.panic）・canonical formsは値でないので無関係・
  step_shared_stableはヒープを変えない。構造再帰（shift / subst / shiftTy / tsubstTy / renR / renameFn / noNewchan / srcと
  その補題の帰納）は葉の1行ずつ。typecheckは `some t`（sound / completeの枝も1行）
- 検証: lake build緑・sorryなし・`#print axioms` = soundness / preservation / progress / typecheck_sound / typecheck_complete /
  hasType_iff_typecheck / defsOk_of_check / defsOk_of_linked / step_shared_stableはpropext・Quot.sound、par_step_commuteはpropextのみ・
  corevec 300本はバイト一致のまま（unreachを含まない）・Examplesに型は付くが実行でpanic（exUnreach1）と覆っていない分岐（exUnreach2 / 3 — 通る分岐は値、
  外れればpanic）とJSONの往復・ミュータント2本（機械のstepをpanicでなく `lit 0` に → preservationが落ちる、typecheckを `some .unit` に → sound / completeが落ちる）
- 下ろし方: 脱糖器はerrorのswitch（decl = ERRS）に限って覆っていないvariantの分岐を `unreach 結果型` にする（sum typeのswitchは今までどおり全variantが要る —
  網羅はコンパイラの担当、13節の線引き）。lowerはerrorのswitchだけ網羅を要求せず、外れたtagはexit 101（決定E4-B — buildはanalyzerを走らせない）
- 棄てた案: 既存の項で作る（ゼロ除算でpanicさせてから型が任意のjump — 意味の実装を脱糖器へ持ち込む）/ ゼロ値で埋める
  （analyzerの導出が誤ると黙った誤値 — 「音を立てる」に反する。ゼロ値を持たない型もある）/ 欠けた分岐をdefaultに寄せる（意味が変わる）
- Gen（corevecのジェネレータ）への追加はGen総追いつき（parallelの形式化の直前）の回に回す

### Gen総追いつき 段階A（2026-10-05 — 3点セットの1本目）

据え置いてきたコアの語彙（slice / map / string / byte / float / mksliceAt / mkmapAt / unreach / add / lt …）にcorevecのジェネレータを追いつかせた。
コア・証明・JSONは変更ゼロ（Gen.leanとgoldenだけ）。不変条件「型指向のターゲット型はloc-free」は保つ — regionを持つ値は Γ にだけ現れる（段階Bで緩める）。

- 型指向: 分岐を一様の15択から「その状態で使える分岐だけの重み表」（pickW）へ。Γ にmut ref / コンテナがあれば使う分岐を厚く、最内に書けない（d < b + 1）なら
  alloc / コンテナ作成を外す。genTyにbyte / f64。スカラーの分岐にadd / lt / toint / tobyte / fconv / farith / fcmp / eqs、低重みでunreach（裸とiteの片分岐）
- コンテナ: 作る（mkslice / mksliceAt / mkmap / mkmapAt — キーはintかregion rk ≤ rのstring / strlit）→ Γ に束縛し、半々で直後に1回使う。
  使うopは再帰しない関数（useSlice / useMap / useRef — 部分項は Γ の変数か底の値）に切り出した（fuel 4のままで消費opの到達率を上げるため）。
  14 op（lenE / index〔注釈つき / なし〕/ setidx / append / subslice / concat / eqs / freeze / getm / setm / delm / lenm / keysm / freeze〔map〕）と
  関数表の新しいDefへの呼び出し。要素がloc-freeでないslice（keysmのstringキーの列）には値を作るopと型引数を使わない（ジェネレータのバグ1件 — 型指向がrejectした4本の原因）
- 関数表: 8〜14を追加（string仮引数・f64・region 0へのmksliceAt + freezeでstringを返す・copyTo 0で自フレームの連結を呼び手空間へ・
  総称のslice〔tparams = 1〕・mut slice / mut mapのanchorのcallM）。全ベクタのcheckDefsがこれらの本体を毎回検査する（copyToはここで踏まれる）
- ベクタ: 型指向の半分は最外のblockの中から（深さ1で始めると最内へ書く分岐が最初から使える）。chaosに欠けていた22構成子 + ff、genChaosTyにbyte / f64 / slice / map / tvar
- golden全面再生成（seed 42・300本 — 乱数列が全部ずれるので連続性は無い。ユーザー了承済み）: accept 204 / reject 96。
  型指向の出自20,000本（10シード × 2,000）でreject 0。compiler/ のcheck（checkdump）との照合はgolden（selfhost_check (i)）と追加の63,000本（21シード × 3,000）で食い違い0
- 段階Bに残すもの: regionを持つターゲット（blockR / copyToを型指向が出す・ラベルの型にslice）・関数呼び出しの戻りのregion座標をtyで照合する形

### corevec v2（2026-10-05）

検査としてのcorevecを1段階強くした（コア・証明・JSONは無変更）。

- 近傍ミューテーション（near-miss）: 型指向の1本に1か所だけミューテーションを適用する（Gen.leanのmutate — seed決定的）。種別 = flag（mutフラグ反転）/ region（strlit・mksliceAt・mkmapAt・copyTo・newchanの
  region ±1）/ key（mapのキー型をkeyOkの外へ）/ var（de Bruijn ±1）/ annty（ann・nil・inl・inr・label・jump・unreach・getm・delm・copyToの型注釈の差し替え）/ jump（ラベル添字 ±1）/
  fn（関数表の添字・型引数の数）/ op（lit ↔ flit・tobyte ↔ toint・add → fadd等）/ idx（indexの読み出し注釈）。種別を先に一様に選ぶ（litの多さでopに偏らない）。
  chaosの拒否が根で落ちる浅いものなのに対し、ミューテーションは「1規則だけ破る」拒否 — compiler/ のcheckの規則ごとの食い違いを狙う
- 内訳: 1000本 = 型指向70% / ミューテーション20% / chaos 10%（各行に出自 `"g"` — 消費者はe / vだけ読む）。golden（seed 42）: accept 741 / reject 259、ミュータント200本のうちreject 162・accept 38（等価ミュータント — 数えるだけ）
- 被覆ラチェット + 自己検査（scripts/corevec_cov.ts — corevec.shが毎回通す）: Json.leanのexprToJsonの分岐から構成子・kind・子のフィールドを機械で読み、Syntax.leanで「ソースには現れない」と
  書かれた構成子を外した64個それぞれにaccept ≥ 3・reject ≥ 3を要求（accept側はblockR / copyToを免除 — 段階Bで外す）。型指向の出自がrejectならジェネレータのバグとして不合格。
  わざとGenからdelmを抜くと `delm: accept 0 < 3` で鳴ることを確認
- 照合の拡張: corevec.sh --binaryは全数をlean_batchで（gatesのcorevecゲートは --binary）・selfhost_checkの (i') 追加シードはgates --allで常設（seed 1..2 × 1000本 — 3本で +90 sを計測して2に）
- 収穫: ミュータントを含む30,000本（10シード × 3,000）をcompiler/ のcheckdumpと照合して食い違い0

### Lean → Sober抽出器E1（2026-10-05）

「証明はLeanで書く・検査と実行はSober」の抽出器。第一顧客 = src/compiler/checker/ty.sober（Syntax.lean / Typing.leanの `Ty.*` の手書きの移植）。
E1は抽出器と検査ツールまで — 生成物はまだどこからも参照されない（差し替えはE2）。コア・証明は無変更。

- 形 = 精緻化後の定義の方程式（getEqnsFor?）経由（lean/Extract/ — `lake exe sober-extract`）。方程式1本 = 1つの分岐。重なりのあるパターン（`Ty.sub` の落ち穴・`Ty.keyOk`）は、
  方程式の仮定が「先行の方程式の左辺のパターンの否定」の形であることを機械で照合してから順のif連鎖に並べる（対応しなければ止まる）。
  仮定が無い（重なりが無い）関数は1つの仮引数の構成子でswitchにまとめ、同じ構成子の中は残りの条件のif連鎖（relocRのmut / imm等）
- 変換できる範囲（これ以外は止まる — 黙って近似しない）: 方程式がある定義（partial / unsafeは不可）・パターン = 構成子 / 変数 / Bool・Natのリテラル / Natのsucc / Option・
  右辺 = Boolの演算・`decide` の比較（Nat / Bool / Tyの等しさ）・if・Natの + / -（前奏のnatSub — LeanのNatは0で止まる）/ min・Optionのnone / some / or / getD・Listの添字・
  `List.all` に捕捉のない関数参照（関数ごとに特殊化）・対応表のある構成子の生成・抽出対象の関数の呼び出し。型 = Bool / Nat / Ty / Option Nat / Option Ty / List Ty
- 設定（lean/Extract/Config.lean 1ファイル）: 抽出する定義25本・構成子の対応表（Tyの構成子 → タグ定数とフィールドの読み出し — inductiveの構成子が表から欠けると止まる）・前奏・
  `List.all` の特殊化の雛形。`deriving DecidableEq` の構造の等しさ（tyEq）はinductiveの定義から生成
- 負例（lean/Extract/Neg.lean — `sober-extract --neg`）: partial def・String・ユーザーの型クラス・右辺のmatch・仮定が先行の否定に対応しない人工的な方程式の5本が全部止まる
- 生成物 = lean/Extract/sober/ty_gen.sober（26関数・1174行）。src/compiler/checkerに置くとpackageに入ってビルドされ、testdata/ に置くとゴールデンのゲート（astjsonがtestdata//*.soberを拾う）に入るので、E1ではlean/Extract/sober/ に置く（E2でsrc/compiler/checkerへ移した）。tyvecdump・shimはlean/Extract/sober/ のまま
- 検査ツール: `scripts/extract.sh --check`（gatesのextractゲート — lean / checkタグ）= ①抽出器の結果 ≡ コミット済みの生成物 ②負例が全部止まる
  ③tyvec（`sober-gen --tyvec` — FeatherweightSober/TyVec.leanが26関数を巡回して引数を乱択しLeanの評価そのものを結果に吐く → lean/Extract/sober/tyvecdump.soberが
  生成物で計算し直して全行バイト比較・20.8万行）。`--hand` は同じtyvecを手書きの移植（ty.sober）に掛ける — 移行期の旧 ≡ 新（20.8万行一致）。
  感度: 生成物の手直しは①で、意味のミューテーション（subの `<=` → `<`）は③で403行が鳴る

### Lean → Sober抽出器E2 — Ty層の差し替え（2026-10-05）

src/compiler/checkerの型の関数は抽出器の生成物（src/compiler/checker/ty_gen.sober — 26関数 + tyEq + 前奏）。手書きの移植は退役し、
ty.soberは型の表現（Ty・定数・tyAt / tg / tA / tB / tC / mk / tOpt / isCont）+ LeanのTyに無い補助2本（isImmStr・tsLen — check.soberが使う）+ 型の印字（tyJson）に縮んだ（525 → 149行）。
readAsのmはLeanどおりbool（呼び手check.soberは `tA(…) != 0` を渡す）。b2iは生成物の前奏が持つ（state.soberの同じ関数は撤去）。コア・証明は無変更。

- 移行期の照合: 差し替えの直前にtyvec（20.8万行）で手書き ≡ Lean・生成物 ≡ Leanを確認してから差し替え（--handは役目を終えて撤去）
- 性能の手当て（抽出器の観測等価な変換の仕方 — 生成物の素の形は自己適用checkで命令 +44%・RSS 1.0 → 2.3 GBだった）:
  ①共有: 右辺が左辺の仮引数のパターンと同じ項なら仮引数をそのまま返す（葉の型・tsubstの範囲外のtvar）・左辺と同じ構成子を作る場所は
  前奏のmkLike（フィールドが全部元と同じなら元の記録を返す — 子が変わらなかった型を作り直さない。記録は作ったら変えない・等しさは構造で見る）
  ②近道 = 定理の分岐（Config.shortcuts）: 抽出する関数についての証明つきの等式（`Extract.tsubst_nil : t.tsubst [] = t`）を方程式の分岐の前に置く。
  定理なので先に適用しても値は同じ。無条件の定理（方程式を全部覆う）は止まる（負例）
  ③`Option.or` の短絡: 右辺の最上位の `a.or b` は文に変換する（aがsomeならbを計算しない — anchorOfの残りの退行9 Gはこれ。前奏のoptOrは両方を先に計算する）
  ④記録の仮引数の最上位のタグは先頭で1回だけ読む・1回だけ使うフィールドの読み出しは使う場所へ畳む（`&&` の短絡で読まずに済むフィールドを先に読まない）
- 結果（自己適用check — stage2でsrc/compiler/appの一括check・同じ木）: 命令81.5 → 82.9 G（+1.7%）・peak RSS 1009 → 464 MB（−54% — 手書きの移植も子が変わらない型をrelocR / tsubst … で毎回作り直していた。その分がmkLikeで消えた）・wallは揺れの範囲で同等。
  自己buildは +0.1 G（生成物のソースが380 → 946行）
- 検査ツール: extract.sh --check（①生成物 ≡ 抽出器 ②負例6本 ③tyvec）+ end-to-endの検査（corevec --binary・selfhost_check・checkverdict・leanbatch）。
  感度: tsubstの近道のミュータント（空のtsでintを返す）でtyvecが2,501行鳴る
- 3点セットのレーン総括（Gen段階A 6b6b0b4c → corevec v2 93379cd6 → 抽出器E1 657e6869 → E2 55c2392d — before/afterの表・残穴）: 残りはGen段階B（regionを持つターゲット — ty比較がregion座標を照合する主な利点）・E3 typecheck（段階6と並走・(γ) 規則の表 + 同値定理を推奨）・E4以降（Machineの参照実行器・補題からのPBT生成）

### 段階6 P2a — 新構成子の検査の解除（2026-10-06）

P1でLeanのコアに入ったscope / spawn / join / tryJ / newchとsend / recvの端点版を、src/compiler/checkerが検査しGenが出す状態にした（被覆ラチェットのEXEMPT_ALLを解除）。
- 入口の決定（決定 (A) — 朝にユーザー承認）: E3（typecheckの抽出）は2段階。typecheckの分岐82のうち56が右辺で再帰の結果にmatchする（MatcherApp）のでE1の抽出器はそのままでは1つの分岐も変換できない。
  P2a = 新構成子の規則だけ手で移植する（移行期の照合相手 — E2の旧ty.soberと同じ立場）→ P2b = (γ') 1フレームの遷移関数tcStepをLeanに書き（再帰しない — 子の結果を引数で受けるので「計算結果へのmatch」が「引数へのmatch」になりE1の方程式経由がそのまま効く）+ `typecheck = evalRule` の同値定理 + Sober側の汎用の駆動部。
  検査が先・置換が後（新構成子の検査が無いまま新構成子込みの全面置換を踏まない）。P2bの完了条件にcheck.soberの手書きの移植の退役を含める・同値定理が分岐ごとの場合分けの見込みを越えたら停止。
  棄てた案: (β) 抽出器がCPS / 非関数化で明示スタックへ機械変換（抽出器にMatcherAppの復元と継続の非関数化の2機構 — 正しさの保証が検査だけ）
- Ty層: Ty.givable / Ty.rehomeを抽出の対象に（生成物28関数）。抽出器に列挙のinductive（フィールドを持たない構成子 → 整数 — OwnK = 0 scope / 1 task / 2 tx / 3 rx。Config.enumTable）のパターンと値を足した。tyvecは28関数 × 8000 = 22.4万行
- 境界（json.sober — 手書きのまま検査で守る）: 式scope / spawn / join / try / newchと型own（oの綴り → 種類）のparse。nc（noNewchanの否定）はscope / spawn / join / tryは子の論理和・newchは0（P3b-2）（P3aのDefの本体の解禁 — core.soberの直結も同じ）
- 検査（check.sober — 移行期の手書きの移植・P2bで退役）: 5構成子の分岐 + send / recvのown tx / own rxの分岐（P1でLeanに入ったのに移植に無かった — Genが端点を出さないので検査が鳴らなかったドリフト。P2aで閉じた）
- Gen: 型指向の分岐task（重み3・tがregionsBelow 0 && chanFreeのとき）= scopeの中でspawn → join / spawn → try（死んだら続きの値）/ newch → txをspawnに渡してsend → join → recv。chaosに5構成子・近傍ミューテーションにnewchのregion / cap 0・scope / tryJの注釈・kids / setKidsに4構成子

### 段階6 P2b — typecheckの抽出（E3 — (γ')・2026-10-06）

src/compiler/checkerの型検査の本体（check.soberの約650行のswitch + P2aの手書きの移植）を、Leanから抽出した1フレームの遷移関数と手書きの汎用の駆動部に置き換えた。型検査の判定の移植は手書きが0行に（残る手書き = 駆動部・表現の読み取り関数・JSON境界）。
- Lean（TcStep.lean・TcEq.lean）: `tcStep Δ f b d Γ Λ r1 r2 r3 : Expr → Nat → Act` — フレーム = (式・ステップ・文脈・評価し終えた子の結果r1〜r3) から「次に降りる子と文脈（`Act.sub`）」か「結果（`Act.ret`）」。
  書き方の規律 = tcStep自身のパターンは (構成子, ステップ0 / 1 / 2 / n+k — 重なりなし) だけ・結果の型の入れ子のパターンは全部1つの分岐1つの小さな関数（`k…` 組み立て / `s…` 次の子と文脈）の引数のパターン・右辺に計算へのmatchを書かない（`Δ[fn]?`・`Λ[n]?`・`anchorOf` は引数に持ち上げる）・文脈と関数表の読み取り関数は小さな定義（`ctxGet` / `lctxTy` / `defGet` …）。
  `evalRule`（燃料つき — ステップ0〜3を回し子は燃料 − 1）と定理 `typecheck_eq_evalRule`: `typecheck … e = evalRule … (sizeOf e + 1) … e`。分岐ごとの補題77本（雛形を機械生成し、依存する文脈の分岐 — ifnil / case / callv / spawn / call系 — だけ手で場合分け）+ 帰納法。sorryなし・公理propext / Quot.sound（full simpがClassical.choiceを引く分岐はsimp only）
- 抽出器: 方程式経由（E1）のまま。足したもの = 節（Expr — st.hの [kind, nc, a, b, c]。Config.nodeTable = 構成子 → kindの判定・caseの札・フィールドの読み出し。札の無い構成子 = 実行時だけの形は変換せずswitchの外れ）・捨てる仮引数の型（Defs — stが持つ）・手書きの読み取り関数の表（shimTable — Actの構成子も）・`n + k` のパターン・列挙の値を式に（FConvOp → 式の語の番号）・フィールドの無い型の作り置き（`st.tInt` 等）・非再帰の定義（展開の等式1本）。生成物 = src/compiler/checker/tc_gen.sober（65関数）。MatcherAppの復元器は作らない（(γ') の眼目）
- Sober: check.sober = evalRuleの燃料なし版の駆動部（tcRun — フレーム9ワード・ステップ3のAct.subはnone）+ 読み取り関数。Leanのtypecheckは部分項がnoneでも兄弟を評価してからnoneを返す形があり（d = 0のcall等）、駆動部も同じ（旧移植の「最初のnoneで打ち切り」はしない — 結果は同じnone）
- 移行期の照合: 旧checkdump ≡ 新checkdumpをcorevec 1000本 + 手書き（byte / float / copyto / parの14本）+ 第3のゴールデンで1261本食い違い0 → 差し替え → selfhost_check全面fail 0・extract（tc_gen ≡ 抽出器）・gates --full
- 性能: 自己適用check（src/compiler/appの一括）は旧stage2比でwall −12〜25%・RSS +0.1%（perfの無い環境で交互3回 — 出力はバイト一致）

### 順序

1. Phase 1（fib、Zig）
2. Featherweight Sober（Lean、本文書）
3. Phase 2 = Lean製型検査器を本番として接続。Zigは脱糖までを担い、脱糖後のコアASTをLean側に渡す
4. Phase 3以降はこの構成で進める
5. Zig（またはセルフホスティング時のSober）で型検査器を再実装し、Lean実装を段階2のゴールデンオラクルとしてCIに残す。実装が3つになっても正は1つ。Leanはコンパイル経路からは退くがオラクルとしては恒久
   - 着手のトリガー（2026-09-17追記。「落ち着いた頃」では決まらないので）: LSPの編集応答が目に見えて遅い、またはセルフホスティングを始める、のどちらか早い方。前者を測るためPhase 2で接続した時点で応答時間のベンチを1本置く
   - 着手の前提: 段階2の差分テスト基盤（ジェネレータ + Lean / Zigのaccept / reject比較）が先に回っていること。無い状態で再実装するとLeanをオラクルにできず、証明された型検査器の価値を捨てることになる
   - 再実装より先に試すこと: Lean 4のC出力をリンクする案（下記条件2）。プロセス分離の起動コストだけが問題ならこれで済む

### 守る2条件（入れ替えを機械作業にするため）

1. 境界はデータだけ。Zig → Leanは脱糖後のコアAST（JSON）、Lean → Zigは診断のリスト。共有メモリもコールバックもなし
2. 最初はリンクせずプロセス分離。Lean製型検査器は別バイナリ、stdin / stdoutで接続。ZigコンパイラにLeanランタイム（libc）を混ぜず、`lake build` とZigビルドを独立させる。性能が問題になったらLean 4のC出力をリンクする選択肢が残る。Leanの依存はStdのみ（Mathlibは入れない）

### 正直に見ておく点

- Lean製型検査器は脱糖後のSoberコア全部を扱うので、Featherweight Sober（証明済み断片）より大きい。証明されているのは部分、残りは「Leanで書いてあるが未証明の参照実装」。断片を育てて証明済み領域を広げる運用
- 脱糖器はZig側に残り未証明。ただし境界がコアASTなので「脱糖結果が体系の項か」はLean側のパースで毎回検査される
- 定理1・2（領域安全・競合自由）を段階2で検査するには、Zig側にもregion木を追跡する計装付き評価器が要る。Lean側の意味論を移植する

## 実装計画との位置

design-dev.mdのPhase 1（fib）には寄与しない。Phase 1 → Featherweight Sober → Phase 2（Lean製型検査器を接続） の順。Phase 1と並行して始めてもよい（触るファイルが重ならない）。

## 想定するリスク

- 証明工学のコストが本体を食う。時間を区切る: 定理3が2セッションで通らなければ体系を削る
- 体系と実装のgap。型検査器をLeanで書いて本番にすることで型検査器については消す（上記）。脱糖器とcodegenには残る
- コルーチンを足した瞬間に意味論が膨らむ。stackful + 協調的スケジューリングは「中断点でのみ切り替わる」のでインターリーブは有限に抑えられるはずだが、定理2の証明を作り直す覚悟がいる
- 「証明した」が過信を生む。証明したのはFeatherweight Soberの性質で、Soberコンパイラの性質ではない。design-dev.mdにその一文を置く
- 定理2は逐次一貫（SC）なメモリモデルを仮定する。x86 TSOでは実用上問題ないが、ARM等の弱いメモリモデルでチャネル実装のオーダリングが正しいかは別問題（Iris / herd7の領域）。体系には入れず、ランタイム側（design-dev.md Phase 5b）の検証項目に置く
- ランタイム（スケジューラ・チャネル・region解放）の正しさはLeanの対象外。5aではLeanの意味論をオラクルにした差分実行、5bではチャネルとjoinをTLA+ でモデル検査し、実装トレースを仕様に照合する。SMTソルバはanalyzerやSoberSQLの個別判断で使うことがあっても、メタ理論には使わない
