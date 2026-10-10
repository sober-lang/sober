# Sober の形式化（Featherweight Sober）

定理証明系（Lean 4）で Sober のコンパイラ層の健全性を機械検証する計画。
design-dev.md「層の線引き」のうち コンパイラ層（健全必須）だけが対象。analyzer 層は設計上 best effort なので対象外、パーサー・codegen の正しさも対象外（CompCert 級の別仕事）。

## なぜ Sober は題材として都合がよいか

- 証明すべき場所が層分けで既に切り出されている。証明対象を選ぶ議論が要らない
- 寿命がスコープの木に一致する。Rust（RustBelt）の困難は借用の任意グラフから来ており、Sober はそれを構成的に持たない。証明のサイズが桁違いに小さいはず
- 主張が少数で新規性がある。下記 3 定理
- 仕様ドリフトの検出器になる。設計変更（例: escape の自動化）で証明が壊れ、壊れた箇所が「この規則を変えると何が言えなくなるか」を教える。sqlshape の PG、analyzer-platform のオラクルと同じ位置に prover を置く
- LLM 協働の形が合う。人間は定理の言明（何を保証したいか）と設計の裁定だけ、証明の穴埋めは LLM。「境界の宣言と裁定だけ人間」の作法そのまま

## 証明したい 3 定理

1. 領域安全（memory safety） — 親 region の値は子 region の値を参照しない（escape 規則）+ スコープ終了で子 region を一括解放、のもとで、well-typed なプログラムは解放済み region への deref に到達しない
2. データ競合自由（data race freedom） — 並列スコープに渡せるのは不変値かチャネルのみ、mut な値は単一スコープが所有、のもとで、2 つの並列タスクが同じ場所に対して少なくとも一方が書き込みとなるアクセスを同時に行わない
3. 型健全性（progress + preservation） — `T?` の flow typing、sum type（`union`）の switch 網羅、多値の分解点規則を含む型付けが、評価で壊れない。特に「`nil` は `T?` にしか住めない」が保たれる

段 6 の計画（2026-10-05）: 定理 2 を ① DRF（今の段 3b〜3d の中身 — コピー意味論 + 共有プレフィクスの不変 — を言明の形に整える）と ② スケジュール非依存（Kahn — チャネルの端点を単一所有にした SPSC のもとで、異なる task の 1 歩ずつが K を触っても可換な one-step diamond から合流性へ。デッドロックの有無まで決定的）の 2 本に分ける。今の `chan` は MPMC なので ② は偽で、端点 2 型の導入が前提（language.md 11 節「チャネル」）。

段 6 P1 の着地（2026-10-05 — 切れ目 ①②）: コアに task の木を入れた。
- 型: `Ty.own (k : scope | task | tx | rx) (r : Nat) (t : Ty)` — 単一 task が所有する能力（家の region r・mutFree でない = 捕獲できない・chanFree でない = 写せない・部分型は不変）。型環境 Ξ は構造体 {ch（旧 chan）・ep（端点）— 全 task 共有、tk（自分の子の (scope の region, 結果型)）— 世界ごと}
- 式: `scope t e`（region を 1 段開き、本体は var 0 = 札 `scopeV d`・ラベルを越えない・出口は blockR と同じ写し）・`spawn sc a e`（札・子へ渡す値 a〔mutFree・chan なし・scope の region 以下 — give: の口のデータ版 = 写す〕・閉じた子の本体 e〔文脈 [ta]〕。結果は loc-free・chan なし）・`join h`・`tryJ t h`（完了 = some v・死 = nil — 死を吸収しない）・実行時の `taskV rs n`
- 機械: `State.fam id o n main kids`（State と Kids の相互帰納 — step は構造的再帰のまま）。id = 親の id ++ [子の番号]（決定的）・o = 親から引き継いだ子の表の長さ（子 i の handle = o + i）・n = 局所の通し番号。main の spawn / join / try / scope の出口は fam が子の表を見て扱い（famMain）、それ以外は main 自身の歩。scope の出口は「その scope の子が全部 完了 か 死」を待ち、死があれば親が死ぬ。死んだ task の子孫は走り切る（打ち切らない）。task の外（旧 load の根・旧 par の子）での spawn / join / try は到達しない形として panic で閉じる
- 定理: preservation（結論に「葉の歩は自分の子の表 tk を変えない」を足した）・progress（葉）・progressT（task 込みの四択 = 完了・panic の葉・待機〔Blocked に task の待ち 6 形〕・次の 1 歩）・soundnessT（根の task `loadT` から）・step_shared_stable（task 込み）。補助: step_isFam（葉の歩は葉のまま）・value_world（mutFree な値は世界ごとの部分に依らない）・reloc_exit（regionKR と scope の出口の共通部）。公理は propext・Quot.sound のみ（soundnessT・soundness・step_shared_stable・typecheck_sound / complete）
- P1 の制限（後便）: Def の本体に並列の構成子を置かない（noNewchan）・結果と渡す値は loc-free / mutFree（子の region で作った値を返す・送るには heap をまたぐ写しが要る）
- Def の本体の解禁（2026-10-06 — P3a）: noNewchan を scope / spawn / join / try について子の論理和に（newchan / 実行時の値は false のまま。newch も P3b-2 で解禁 — 家の region r は shiftTy / renTy / rmap で既にずらされていて〔見立ての「相対化」は不要だった〕、型規則に f の制約が無いので f_lower に 1 腕を足しただけで閉じた。Examples の chDefΔ）。f_lower に 4 腕を足しただけで preservation（callK / callMK の腕を含む）・soundnessT・Kahn・typecheck の sound / complete はそのまま通った — 4 構成子の型規則は f を使わないので、Shift / TSubst / Ren の src の腕（P1 で書き済み）と合わせて写像の補題が全部揃っていた。task の外（旧 load の根）から呼ぶと spawn は定義された panic（Examples の parDefΔ）

段 6 P1 切れ目 ③（2026-10-05 — 端点のチャネル）: `newch r cap t`（送り端と受け端の組 `prod (own tx r t) (own rx r t)`・家の region r はこの世界のもの・容量 ≥ 1・ペイロードは loc-free で chan なし〔P1 — キューの値は空の世界で型が付く〕）・実行時の端点 `epV p k tx r`（鍵 (p, k) = 生成元の task id + 局所の通し番号・型付けは mut の loc と同じ b ≤ r < d — 子の世界では型が付かないので実行時の捕獲も構造で閉じる）・send / recv の端点版。機械の K は構造体 {leg（旧 chan）・ep（鍵 → {q, cap, otx, orx}）}— otx / orx = 持ち主の task id（裁定 A = β）。spawn の渡す値は `givable`（端点〔移す〕・写せるデータ・その組）で、giveV が持ち主を子へ書き換え家を子の region へ付け替える（持ち主でなければ panic — 失効した別名）。満杯の send・空の recv は待機（Blocked famSnd / famRcv）。preservation / progressT / soundnessT / step_shared_stable を端点込みで更新（補題 giveV_ok・chanOk_epNew / epSet・value_toEmpty / fromEmpty）。反証探索 = 乱択の反例探索 spscfuzz（MPMC の 48 本の反例の形を SPSC で掛け直し — 3 seed × 2,000 本で割れ 0）

段 6 P1 切れ目 ④a（2026-10-06 — Kahn の下ごしらえ）: famMain が task の main の旧構成子の redex（`eval (par …)`・`eval (parch …)`・`eval (newchan …)`・旧 chan の send / recv）を横取りして定義された panic にする（相談 D = (a)）— task の外の spawn / join / try を panic で閉じる柵の鏡像。Blocked.famM は main の旧 recv の待ちを除く（横取りで 1 歩進むので）。Leaf.lean: 旧構成子の redex でない葉（eval / ret / panic）の 1 歩は π を見ず K を読まず変えず、結果も葉 — `step Δ π' s K2 = (step Δ π s K).map (fun p => (p.1.fixLeaf, K2))` の 1 本の等式に畳み、step の腕の全数の場合分け（frame ごとの定理に分けて並列 elaborate — 約 2 分）で示す

段 6 P1 切れ目 ④（2026-10-06 — Kahn.lean・定理 2 の ②）: task の木の機械は合流的 — 整形された木（`TaskOk`: main は葉・子 j の id = 親の id ++ [j]）の 2 つの 1 歩は、同じ結果か 1 歩ずつで合流する（`kahn_diamond`）。ここから `kahn`（正規形 v に n 歩で着く実行があれば、どの k 歩の実行も k ≤ n で n − k 歩で同じ v へ）・`kahn_unique`（正規形と歩数の一意性）・`kahn_schedule`（loadT の全プログラム: 止まった 2 つのスケジュールの最終状態は一致 — 完了の値・panic・待機〔デッドロック〕の区別まで決定的）・`kahn_schedule_bounded`（どれかのスケジュールで止まれば全スケジュールが同じ上界で止まる）。型付けは使わない機械の性質で、前提は旧 par / 旧 chan の横取り（④a）だけ。骨格: K の効果を操作 Op に分け独立な操作の可換性（`op_comm` — 持ち主の札が違えば片方は失敗、送りと受けは q の両端）→ famMain = 操作 + K に依らない続き（`famMain_spec`）→ 部分木の 1 歩の分解と再生（`step_dec`）→ 子の 1 歩の下での main の続きの安定性（`mainCont_set` — join / try / scope の出口が読む子の決着は動かない）→ 木の帰納。DRF の系 = kahn_diamond そのもの（違う task の 1 歩はチャネルに触れても可換 — par_step_commute〔K を変えない歩だけ〕の SPSC 版）。公理は propext / Quot.sound のみ。反証探索 = 乱択の反例探索 diamondfuzz（約 4.6 万対で割れ 0・対照の旧 MPMC は 196 割れ）

段 6 P3a A1 (X) — 死を値にする scope（2026-10-06・裁定 = language.md 11 節「死の扱いの 3 通り」）: `scope t e` の型を `union t unit` に。出口で子が全部決着し死がいれば最内の region を pop して `inr t triv`（写さない）・死が無ければ blockR と同じ写しの後 `inl unit v'`（task の外の出口も `inl`）。join が死んだ子を見たら親が死ぬ（不変 — Join = 「この子の死は私の死」）・try は nil（不変）。死を値にした scope の後も main は完走しうるので、完了形を `kidsDone` = 子が全部 完了 か 死んで静止（`deadDone` = main が panic で子孫も全部決着 — キャンセルなしなので死んだ task の子孫は走り切ってから静止）に広げた。補題: `dead_exit`（死の出口の pop の型付け）・`reloc_exit` を下のスタックの型について一般化・`famMain_panic` / `deadDone_false_of_step` / `step_deadDone_none`（静止は 1 歩も踏めない — 完了形と同じ）。preservation / progressT / soundnessT / step_shared_stable / Kahn（kahn_diamond・kahn_schedule ほか）は証明の構造を変えずに通った。抽出: TcStep の scope の腕を `kScope`（kBlockR の結果を `union t unit` に）へ・tc_gen の差分は kScope の 1 関数と呼び出し 1 行。Gen は scope を `case (scope t e) (var 0) (unreach t)` で t へ戻す（乱数を消費しない包み）・corevec 黄金は再生成。反証探索 = 乱択の反例探索 diamondfuzz（2 seed × 400 本・約 5.2 万対で割れ 0）・spscfuzz（3 seed × 2,000 本で split 0）。公理は propext / Quot.sound のみ

段 6 P3b-4 — task の結果の境界コピー（2026-10-06 — 裁定 = language.md 11 節 P3b ⑦「region を持つ結果の境界コピーの Lean 便を先に」）: spawn の結果の条件を loc-free から imm（mutFree）で chan なしへ緩めた。handle の型 = `own task rs (t.relocR rs)`（子の結果型の imm の region を全部 scope の region rs へ）。join に結果型の注釈 `join t h`（tryJ と同じ形 — 写すときに歩く型）。機械: 子の task の底を `taskK`（値が戻ったらそこで止まる — 自前の region を pop しない。StackTy.taskK は共有境界 ≥ 1 の世界だけ — 根は taskK で止まらない `not_taskK_root`）・完了形にヒープを添えた `taskRes`（taskDone の写し）・join / try は `xfer rs t Hk H v`（子のヒープ Hk の値を型 t に沿って歩き、imm のコンテナを region に依らず全部、親のヒープ H の region rs の末尾へ中身ごと積み直す — relocTo の 2 ヒープ版。共有の region〔親のコピー〕を指す値も写す — imm なので観測は同じで、実装は写さずに済ませてよい）。型付けの不変: fam の子 i は自分の結果型 `tcs i`（imm・chan なし）で型付き、子の表の型 = `(tcs i).relocR rs`。補題: `xfer_ok`（写しの保存 — relocTo_ok の 2 ヒープ版: 写す元は子の HeapOk だけを読み、写す先は region rs だけが lookup 保存で伸びる〔RelocJ〕・値は take (rs + 1) の世界で型付く。値の葉は空の世界を経由して Ξ を付け替える〔value_export / value_anyΞ / value_import〕）・`xfer_join`・`taskRes_typed`・`join_xfer_some`（progress — 型付きなら写しは失敗しない・共有プレフィクスは不変）・型の補題 `Ty.relocR_{mutFree,chanFree,regionsBelow}_of`・`Ty.relocR_mono_mf`・`Ty.relocR_sub_*`・`Ty.renR_relocR_mf`（shift / ren / tsubst の spawn の腕）。Kahn.lean は言明・証明の構造とも無変更（join / try の写しは親の局所の歩 — mainCont の join / try の腕を taskRes + xfer にし、mainCont_set に taskDone → taskRes の 2 行を足しただけ）。公理は propext / Quot.sound のみ

段 6 P3b-4b — チャネルのペイロードの境界コピー（2026-10-06）: ペイロードの条件を loc-free から imm・chan なしへ（newch は加えて注釈が今の世界で整形 `t.regionsBelow d`）。端点の型のペイロードの region は意味を持たない — 型の表 Ξ.ep は region を全部 0 へ締めた形（`t.relocR 0`）を持ち、epTx / epRx はそれと引く。sendE = 送る値の型 te とペイロード型 t が region を除いて一致（`Ty.payOk` — どちらも imm・chan なしで relocR 0 が等しい）・recvE の型 = `t.relocR (d - 1)`（受けた値は今の最内の region へ）。機械: 項目 EpEnt にペイロード型（注釈の relocR 0）を持たせ、キューの要素を 梱包 `Pkt`（値・1 region の小さなヒープのセル列・歩いた型）に。send = `packV`（`xfer 0` で送り手のヒープから小さなヒープへ）・recv = 梱包を `xfer (H.length - 1)` で受け手の最内へ。どちらも失敗は none（型付きなら起きない — progress が pack_ok / unpack_ok で示す）。ChanOk.eptyped = 型は relocR 0 で不動・imm・chan なし・項目の型と一致・待機中の梱包は `PktOk`（小さなヒープが共有境界 0・空の型環境で型付き、値は深さ 1 で型付く）。補題: `pack_ok`・`unpack_ok`・`xfer_take`（写しは region k より下に触れない — 共有プレフィクスの不変の受けの腕）・`Ty.payOk_renR` ほか。Kahn.lean は言明・証明の骨格とも無変更（Op.run の結果を梱包 Pkt に・send は送り手のヒープを運び packV・recv の展開は mainCont〔K に依らない続き〕へ — 葉の局所の歩）。公理 propext / Quot.sound のみ。反証探索 = 乱択の反例探索 strchanfuzz（spscfuzz の string 版 — 3 seed × 1,500 本・割れ 0）

段 6 P3b-4 ③ — close と `T?` の受け（2026-10-06 — 裁定 = language.md 11 節 P3b の仮採用 ③「Close / `T?` nil / for-Recv はコア拡張 — P3b-4 の Lean 便に同梱」）: 式 `close c`（`c : own tx r t` → unit）を足し、recvE の型を `.opt (t.relocR (d - 1))` に（表層の Recv は最初から `T?` — 脱糖は `some (recv c)` をやめて `recv c` をそのまま出す）。機械: 項目 EpEnt に `closed : Bool`・フレーム `closeK`。close = 持ち主で開いていれば `closed := true`・それ以外（持ち主違い・二度目）は定義された panic。send = 持ち主の確認の後、閉じていれば panic・梱包は `some v` を型 `.opt ent.ty` で（キューの要素は `T?` の値 — 受けは一様に xfer で写して `some v'`）。recv = キューが空で閉じていれば `nil (ent.ty.relocR (H.length - 1))`（何度受けても nil・K は不変）・空で開いていれば待つ。task の外の closeK は panic（recvK と同じ柵）。型付けの不変: ChanOk.eptyped の待機中の梱包は `PktOk Δ (.opt t) w`・Blocked の famSnd / famRcv に `ent.closed = false`（閉じた送りは待たずに死ぬ・閉じて空の受けは待たない）。補題: `pack_ok_opt`（pack_ok を `.opt` / `some v` で呼ぶだけ — payOk は opt で保たれる）。unpack_ok は `.opt t0` で呼ぶ（relocR は opt と可換）。Kahn.lean は言明・骨格とも無変更（Op / Mini に close の操作・send の closed 検査・recv の閉じた空 = 空の小さなヒープの梱包 `⟨nil ty, [], .opt ty⟩` を返し mainCont の xfer が nil へ写す — famMain と一致・mainOp / mainCont に closeK の腕。close は同じ鍵の送りと同じ持ち主の操作なので、閉じた後の送りの有無はプログラム順で決まり、閉じて空の受けは閉じる前の送りが全部キューに入った後でしか起きない — 1 鍵の可換の議論〔Mini.f〕に乗る）。公理 propext / Quot.sound のみ・sorry なし。反証探索 = 乱択の反例探索 closefuzz（strchanfuzz に close と nil の受けを混ぜた版 — 3 seed × 1,500 本・割れ 0。規律の逸脱: 証明の後に回した）。for-Recv（`for l <- par.Recv(rx) { … }`）はコアに足さない — loader が生成元の呼び先を std/par の `RecvAll(rx, k)`（普通の Sober の while + ifnil — 呼び出し形の生成元）へ付け替える

段 6 P3b-4 1b' — error を返す task・未回収の失敗の集約（2026-10-06 — 裁定 = p3b-draft 揉みどころ 7 + 決定 (A)〔コアでは全 task を fallible に一様化〕）: 式 `scope t ε e`（ε = err の型の注釈）・札 `scopeV rs ε : own scope rs ε`。scope の型 = `union t (union unit (ε.relocR (d - 1)))`（inr (inl triv) = 子の死・inr (inr e) = 未回収の失敗）・前提に ε は imm・chan なし・b < d（失敗の err を写す親の最内 d - 1 が共有境界より上 — task の本体と関数の本体は常に満たす。根の scope は block の中に置く）。spawn の本体の型は常に組 `prod t (opt ε0)`・`Ty.payOk ε0 ε`（札の ε と region を除いて一致）。機械: 子の表 Kids の各子に札 `(ε.relocR 0, 回収済み)`（spawn が札の値 scopeV の ε から立てる・join / try が結果を受けたら `Kids.mark` で回収済みに — 親のプログラム順だけで決まる）。scope の出口: 子が全部決着したら、死があれば死・無ければ `Kids.failAt`（生んだ順で最初の「region rs の子・未回収・結果 = pair v (some e)」）の err を子のヒープから親の最内へ `xfer (H.length - 2) (ε.relocR …)` で写して pop。札の err の型が注釈と食い違えば定義された panic（型付きなら起きない — preservation は panic で閉じるので、札と frame を結ぶ大域の不変条件を足さずに済む）。型付けの不変: fam に `∀ i tg, ks.tag? i = some tg → ∃ t ε0, tcs i = prod t (opt ε0) ∧ ε0.relocR 0 = tg.1`。補題: `fail_exit`（reloc_exit の xfer 版）・`Kids.failAt_spec` / `failAt_typed`・`famTy_rebase_mark`・Kids の mark / tag? の補題（Fam）。Kahn.lean は言明・骨格とも無変更（mainCont の join / try が `ks.mark`・scope の出口に failAt の腕・`Kids.failAt_set`〔歩ける子の置き換えの下で決着した scope の failAt は不変〕・`KidsOk.mark`）。公理 propext / Quot.sound のみ・sorry なし。反証探索 = 乱択の反例探索 failfuzz（子は送ってから成功 / 失敗 / 死を乱択・親は Join / Try / 放置を乱択 — 3 seed × 1,500 本・割れ 0・ok / died / failed / dead が全部出る — 言明の前に実施）

段 6 P4 — 約束の範囲と stdout の順（非形式・2026-10-06）: コア（Lean の Machine）に println は無く、kahn_schedule が約束するのは scope の値・panic・デッドロックの有無まで（言明は無変更）。stdout の順は実装の約束でコアの外: P4 の実装は出力を spawn の木の先行順で合流させる（language.md 11 節 P4 (O1)）ので、stdout もスケジュール・ワーカー数に依らない — これは定理でなく実装の網（seq ≡ par のバイト一致・schedfuzz）が見る。同じく scope の err の死因（TaskDied の cause — コアの died は unit で cause は実行時の値）・未回収の失敗の選び方は正準順（spawn の順で最小）を実装が守る（コアの failAt は元から生んだ順で最初 — 実装をそれに揃える）。キャンセルはコアに無い（死んだ task の子孫も走り切る意味論のまま — 実装の打ち切りは scope の値を変えない最適化）。物理共有・原子の op（ir.md 4.7）の正しさ = rt の点の列がコアの 1 歩を原子的に実現していること — 模倣定理は E4（Machine 参照実行器）の席に積み、P4 は seq ≡ par + schedfuzz（+ 変異の自己検査）で見る

Handle は動的検査なので定理 1 の対象外。Handle についての主張は「`get(h)` は UB ではなく `nil` を返す」で、これはランタイムの世代比較の正しさとして別に小さく述べる。

## Featherweight Sober の範囲

小さく始める。最初の体系に入れるもの:

| 構文 | 役割 |
|---|---|
| ブロック `{ e }` | region の生成と解放。値を持つ（式） |
| `x := e; e` | 束縛（const） |
| `alloc e` | 現在の region への割り当て。参照を返す |
| `!r` / `r := e`（mut 参照のみ） | deref / 書き込み |
| `if` / `switch` on 2 バリアント union | 分岐の式化と網羅 |
| `T?` と `nil`、flow typing | 定理 3 |
| `parallel { spawn e; spawn e }` | 定理 2。タスクはスコープ終了で join |
| チャネル `send` / `recv` | 並列スコープをまたぐ唯一の可変通信 |

入れないもの（後回し）: 関数と再帰（まず一階で。ラムダ・inline ラムダ・非局所 return は第 2 段）、多値、`|>`（脱糖で消える）、コルーチンと中断（意味論が膨らむ。structured concurrency の join は spawn の同期的完了として先にモデル化）、Pool と Handle（std なので体系外）、効果・エラーラベル（analyzer 層）。

意味論は small-step。ヒープは region の木（region id → 割り当て集合、親 id）。ブロック終了で region とその子孫を除去。参照は (region id, location) の組で、型は割り当て region を持つ `Ref ρ T`。

### 段 1 の断片（2026-09-18 着手。`lean/`）

定理 3 だけを対象にした最初の体系。region・parallel・チャネルは段 2 以降で足す。Phase 1 で意味論が固まった構文のうち、region に触れないものを入れた。

| Sober | コア（`lean/FeatherweightSober/Syntax.lean`） | 脱糖（Zig 側の仕事） |
|---|---|---|
| `x := e; body`、ブロック `{ ... }` | `letE e body`（de Bruijn。body で x は `var 0`） | ブロックは let の鎖。文位置の値なし式は無い |
| `if c { a } else { b }` | `ite c a b` | `else` 無しは段 1 に無い（値を持たないブロックが要る） |
| `T?`、`nil`、`if v != nil { .. } else { .. }` | `opt t`、`nil t`、`ifnil e nilCase someCase`（someCase で中身が `var 0`） | flow typing は `ifnil` への脱糖で表す。`nil` の型注釈は双方向推論が埋める |
| 2 バリアント `union`、`switch` の型パターン | `union l r`、`inl r e` / `inr l e`、`case e l r`（各腕で中身が `var 0`） | variant 名と多フィールドは名前 → 位置、struct → 段 2 で足す。網羅は `case` が両腕必須で表す |
| `int`、`bool`、`+`、`<` | `lit`、`tt` / `ff`、`add`、`lt` | 他の演算子は同型なので省く |

入れなかったもの: 関数（一階から。ラムダ・展開・非局所 return は段 2）、struct（フィールドは段 2 で union と一緒に n 項化）、多値、`|>`（脱糖で消える）、`defer`（region と一緒。出口で式を評価する意味論は region 解放と同じ場所に置く）、`while` / `mut`（ストアが要る。段 2 の参照と一緒）。

進め方: 構文・型付け・small-step を書き、`Examples.lean` に手で項を置いて `lake build` を通す（型付け例は明示の項、実行例は `Steps`）。次に progress / preservation。置換補題（`subst` と `shift` の型保存）が最初の壁になる。

結果（2026-09-18）: 型健全性（progress + preservation + soundness）が通った。sorry なし。置換補題は文脈 `Γ₁ ++ Γ₂` 分割の一般形、帰納は導出でなく式に対して（型付けが構文主導で inversion が一意なので、文脈を index に持つ述語の帰納を避けられる）。

### 段 2a の断片（region、immutable 参照のみ。2026-09-18 着手）

定理 1 の最初の形。段 1 に `block`（region 境界）/ `alloc` / `deref` と実行時形 `loc r a`（region レベル r、アドレス a）、型 `ref r t` を足す。`mut` 参照・代入・`while` はストア更新が要るので段 2b。

裁定（棄てた案と理由）:

- region は de Bruijn index でなく絶対レベル（region スタック底から 0） — index だと block を潜るたびに型内の region を shift する補題群が要る。レベルなら型は不変で、段 1 の置換補題の構造がそのまま伸びる。棄てた案: de Bruijn index（型 shift の補題が倍増）、fresh id + 死亡マーク（Tofte–Talpin 式。region push で型への region 代入が要る）
- 意味論はフレームスタック機械（CK 風）に置換 — congruence 式 small-step だと redex 規則（alloc / pop）が「現在の深さ」を知れず、「評価スパイン上の region マーカー数 = ヒープ長」という大域不変条件を別の述語で持ち回る必要がある。機械ならスタック型付けが深さを局所的に運び、pop は dropLast になる。段 3 の parallel でもタスク = スタックの形で機械が素直。棄てた案: 項内 region マーカー + スパイン述語、評価文脈の一意分解
- 型付けは `HasType Ψ d Γ e t`（Ψ = ストア型 = level → address → 型、d = 深さ）。`loc r a` の規則が `r < d` を要求する — 「region r に住む値は region ≤ r しか参照しない」という不変条件が型付け規則そのもの。escape 検査は block の規則（結果型の region < 自分の深さ）
- 深さ d の部品はストア型の先頭 d region（`Ψ.take d`）だけで型付けする — フレームとヒープ格納値をこの形で持つと、pop（`Ψ.dropLast`）で型付けが変化せず、strengthening 補題が値の場合だけで済む
- 定理 1 の言明は progress に吸収する — 解放済み region への deref は Ψ に無いので型が付かず、well-typed な機械状態は詰まらない（deref が失敗する状態に到達しない）

### 段 2b の断片（mut 参照・代入・while。2026-09-18 完了）

段 2a に `unit` 型（Sober の none。コアでは `triv`）、`assign l e`（unit を返す）、`whileE c b`（unit を返す、本体の値は捨てる）を足した。sorry なし、公理は propext / Quot.sound のみ。

裁定（棄てた案と理由）:

- alloc の型付けに `t.regionsBelow (r + 1)` を追加 — 段 2b の発見。immutable だけの段 2a では「深い region に言及する型」のスロット（例: `alloc (nil (ref 5 int))`）を浅い region に置いても健全だった（格納値が nil や wrapper なら任意の Ψ で型が付く）が、代入を足すと後から若い region の `loc` をそのセルに書き込めて、region 解放後に dangling が読める（preservation が壊れる = 型系が不健全）。Tofte–Talpin / Cyclone と同じ「セルの型は自分の region 以下しか言及しない」を alloc の規則に置いた。定理 1 の非形式的言明「親 region の値は子 region の値を参照しない」の型付け規則化そのもの。HeapOk に不変条件 `tyBelow` として持ち、代入の preservation は「書く値を `Ψ.take (r+1)`・深さ r+1 に strengthening」で通る（value_strengthen を深さ +1 からでなく任意の深さから落とせる形に一般化）。Examples に非型付けの反例あり
- 全参照を mut として扱う — immutable との区別は段 3（parallel）で「region 間で共有できるのは immutable のみ」が要る時に導入。棄てた案: mut フラグを今足す（段 2b の定理には効かず、規則と補題が全部 1 引数太る）
- 代入と while は unit を返す — Phase 1 codegen の `none` 型に対応する `Ty.unit` を追加。棄てた案: 代入が書いた値を返す（C 風。Sober の代入は文で値を持たない）

### 段 3a の断片（parallel、共有なし。2026-09-18 完了）

定理 2 の最初の形。`par e1 e2`（`parallel scope { spawn e1; spawn e2 }` の最小形。両方走らせて join、unit を返す）を追加。sorry なし。

裁定（棄てた案と理由）:

- タスク = 独立した機械状態の入れ子 — `State.par H S s1 s2` で s1 / s2 は自前のヒープ・スタックを持つ完全な機械状態。spawn は `.eval [] [] e` で立ち上げ、両方が完了形（空スタックの値）になったら join。タスクが自前の region スタックを持てる（本体の block / alloc は自分のヒープに閉じる）のは Sober の「タスクはワーカーに固定」と同型。棄てた案: タスク専用の縮小状態型（step・型付け・補題が全部複製になる）
- par の型付け: 本体は空ストア・深さ 0・「Γ は全部 loc-free」で型付け — loc-free は `regionsBelow 0` の再利用（ref を一切含まない型）。外の mut 参照は型レベルでタスクに入らない = 不変値だけが渡る。強すぎる制約（ref の束縛が 1 つでも見えると par が書けない）だが 3b で immutable 参照の共有として緩める。棄てた案: Γ のフィルタリング（de Bruijn の index 付け替え補題群が要る）
- スケジュールはパス（`List Bool`）のオラクル — `step π s` は par を潜るたびに π の先頭で側を選ぶ。step が関数のままなので実行例が rfl で書ける。progress は「∃ π」、preservation は「∀ π」。棄てた案: step 関係（inductive）への置き換え（実行例が rfl でなくなる）
- 一般の weakening 補題を「値は文脈非依存」に置き換え — par の「Γ は全部 loc-free」条件は任意型の挿入と両立せず、一般形は偽になる。使用箇所は置換補題の値のみで、値は自由変数を含まないので `value_ctx`（+ shift 恒等）で足りる
- 定理 2 の核は可換性 — `par_step_commute`: 両タスクが 1 歩踏めるとき、どちらを先に進めても同じ状態に着く（タスクは互いの状態・ヒープに干渉しない）。共有なし断片では競合の不在 = この菱形。スケジュール全体の決定性（合流性）への持ち上げと、共有ありでの非自明な DRF は 3b / 3c

### 段 3b の断片（immutable 参照の共有。2026-09-18 完了）

読み共有ありの DRF。`ref` に mut フラグ復活（`ref m r t`、`alloc m e`、`assign` は
`ref true` のみ）、par の Γ 制約を loc-free（`regionsBelow 0`）から mutFree
（mut 参照をどこにも含まない）へ緩和。タスクは親 region の immutable セルを読める。
sorry なし、公理は propext / Quot.sound のみ。

裁定（棄てた案と理由）:

- mut フラグはストア型 Ψ のセルに記録（`StoreTy` のセル = `Bool × Ty`）し、loc 規則が
  セルの m をそのまま返す — loc から mut を偽造できない。棄てた案: ref 型だけに持つ
  （loc 規則が任意の m を選べてしまい、共有 loc を mut に付け替えて書ける）
- 共有境界 b（share boundary）を型付けに追加: `HasType Ψ b d Γ e t`。
  loc 規則が `b ≤ r ∨ m = false` を要求 — 「共有 region（r < b）の mut セルには
  この世界から触れない」が型付けそのもの。メインは b = 0（無制約）、par 本体は b = d。
  alloc は `b ≤ d`（共有 region への割り当て禁止 = タスクは自分の block を開いてから alloc）、
  StackTy の底（nil）は深さ b。棄てた案: frozen store 写像（mut セルを imm に写す）—
  mut セル経由の deref で格納値の再型付けが壊れる穴。Γ フィルタリング（3a と同じ理由で却下）
- immutable セルの格納型は深く mutFree（`alloc false` の規則 premise、HeapOk の
  不変条件 `immMutFree`）— imm セルに mut 参照を入れて共有する抜け道を alloc で塞ぐ。
  Verona の「region 間で共有できるのは deeply immutable のみ」と同型。
  これが無いと spawn 時の型付けの引き継ぎ（value_sb transport）が成立しない
- spawn は親ヒープをコピーで渡す（機械上）。物理共有との一致は定理
  `step_shared_stable` — well-typed な世界の 1 歩は共有プレフィクス `H.take b` を
  変えない（assign は loc 型付けの `b ≤ r`、alloc は規則の `b ≤ d`、pop は StackTy の
  底 b が守る）。これと `par_step_commute`（3a から不変）の 2 つが定理 2 の核。
  物理共有ヒープ機械との bisimulation は形式化していない（言明だけ。3c で必要なら）
- HeapOk は「imm セルか自世界のセル（b ≤ r）」だけ格納値の型付けを要求 —
  共有 mut セルは型が付かないので deref され得ず、型付けを持たなくてよい。
  spawn（`heapOk_spawn`: b を Ψ.length へ引き上げ）で mut セルの型付けは落とし、
  imm セルは immMutFree + `value_sb`（mutFree 値の b 付け替え）で引き継ぐ
- タスクの最終形はヒープ空とは限らないため progress の言明を
  「`ret H [] v`（空スタック）か 1 歩」に変更。トップレベル（b = 0）の H = [] は
  soundness 側で `final_heap_empty`（StackTy の底 = 深さ 0 = Ψ 空）として回収

### freeze の断片（2026-09-18 完了）

段 3b の「共有は深く mutFree のみ + 構築後の不変化の術がない」が実用の最大の性能アッパー
（mut で構築 → 共有、が O(n) コピー強制）だったので、freeze（mut → imm の一方向セルタグ
遷移）を足した。言語側の裁定は region-domain-pool.md 1c 節。sorry なし、
公理は propext / Quot.sound のみ（par_step_commute は propext のみ）。

裁定（棄てた案と理由）:

- loc 規則で ref のタグ m とセルのタグ m' を分離: 条件は
  `(m = true → b ≤ r)` と `(m = false → m' = false)` の 2 本。
  mut loc は型のみに結ぶ（セルタグ不問） — freeze 後も古い mut エイリアスの型付けは
  壊れない（preservation に必須）。imm loc はタグ false のセルにだけ結ぶ。
  （改定 2026-10-10 — F-al: 実装は実行時タグを持たない。受理の側で一意でない freeze と freeze の後の書きを拒否し〔language.md 17 節 U1〜U3〕、
  機械のタグと panic は「受理された範囲では倒れたセルに書かない」の観測点として残す。照合 = Lean の述語 uniqFreeze ⊇ analyzer の受理・定理は積み）
  帰結: 「凍結済みセルを指す mut loc」に型が付く — その書き込みは実行時タグ検査（panic）
  が受ける。動的検査が健全性の底、は見積もりどおり
- StoreLE を「型は保存、タグは mut → imm の一方向順序」に再定義
  （`∃ ρ' m', … ∧ (m = false → m' = false)`）。既存補題（take_self / append / set_concat /
  take_take）は m' = m でそのまま通り、freeze の `storeLE_set_freeze` だけが真に一方向を使う
- 機械のヒープをタグ付きセル（`Bool × Expr`）に実体化し、`State.panic H` を追加
  （terminal、ヒープ保持）。assign はタグ検査（true → 書き込み、false → panic）、
  freezeK はセルのタグを倒して同じ loc を返す。HeapOk に `tags`（H と Ψ のタグ一致）を追加 —
  機械のタグ検査と型のタグが同じものを見ていることの source
- par の panic 伝播は「スケジューラが panic 側を選んだとき」（`true :: π'` で s1 が
  panic なら親へ伝播）。棄てた案: join 検査の直後の無条件チェック —
  par_step_commute が壊れる（左を 1 歩進めた結果が panic のとき、右を先に進める自由が
  消える）。スケジューラ側チェックなら `notPanic_of_step`（1 歩踏める状態は panic でない）
  だけで可換性が構造不変。panic は sibling をキャンセルしない（この断片にキャンセルは無い）
- step_shared_stable は維持: freeze の書き替えは mut loc の型付けの `b ≤ r` が
  `take b` の外を保証（共有セルを凍結し直す経路は型が付かない）。panic 遷移はヒープ不変
- progress / soundness の言明は「値 / panic / 1 歩」の三択に。
  Examples: ex9（mut で構築 → freeze → par 共有 → 42。構築の mut 束縛を freeze の引数の
  let 鎖に閉じて par の Γ を mutFree に保つ — このパターン自体が発見）、
  ex10（freeze 後の古い mut エイリアスへの assign: 型は付くが実行で panic）

発見:

- 段 3b の loc 規則 `b ≤ r ∨ m = false` は分離形 `(m = true → b ≤ r)` の特殊形だった。
  分離してもすべての利用箇所は「m を cases してどちらかを取る」だけで通る
- par の Γ に mut 束縛が残ると par に型が付かない（mutFree 検査）ので、
  「構築 → freeze」は let 鎖を freeze の引数側に押し込む形が Featherweight の書き方。
  実言語ではスコープ制御（ブロック式の値に freeze を掛ける）が同じ役割
- Lean の罠追加: `cases hS with | freezeK …` の rename_i は fresh 変数 3 つ
  （S, r, t — d と tf は unification で消える）。`if c then` （c : Bool）を含む match を
  仮説内で潰すときは `by_cases hp : c = true` + `simp [hp] at hs` が安定
  （`split at hs` は Decidable.rec の依存消去で落ちることがある）

### 段 3c の断片（チャネル。2026-09-18 完了）

タスク間通信。`chan t` / `newchan` / `send` / `recv`（無限バッファ: send は常に enqueue、
recv だけが空キューで待つ）。sorry なし、公理は propext / Quot.sound のみ
（par_step_commute / blocked_no_step は propext のみ）。

裁定（棄てた案と理由。ペイロード範囲とバッファ意味論は 2026-09-18 に決定）:

- ペイロードは loc-free（`regionsBelow 0`）限定: タスクのヒープは spawn コピーで
  独立なので、loc を含む値は受け手の世界で読めない。参照を含む値の transport
  （深いコピー = flatten。ヒープの非循環性不変条件が要る）は次の段として独立に積む。
  3c は「チャネルという同期機構そのもの」に絞る（裁定 A/A）
- 無限バッファ: 待機形が recv の 1 つで済む。容量制限・ランデブーは後からバッファ
  上限として足す方が定理を再利用できる。この裁定はチャネルのバッファリングの
  言語側の初期決定を兼ねる（docs に既存の決定なし）
- チャネルストア K は全タスク共有のグローバル（step が K を編んで通す
  `step π s K : Option (State × ChanSt)`）。タスクの入れ子（par の独立機械状態）とは
  別レイヤ — 「チャネルは並列スコープをまたぐ唯一の可変通信」の機械化そのもの。
  棄てた案: par ノードにチャネルを置く（子タスクの操作を親が仲介する形。
  入れ子越しの配達機構が要り大きい）
- チャネル型環境 Ξ を HasType の新 index に追加（`HasType Ξ Ψ b d Γ e t`）。
  実行時チャネル参照 `chanV c` の型は Ξ が与える（K と同様グローバル）。
  newchan で Ξ が伸びるので preservation の結論が `∃ Ξ', ChanLE Ξ Ξ' ∧ …` の存在形に。
  ChanLE（append 単調性）の transport（chan_mono）が HasType / StackTy / HeapOk /
  StateTy の全部に走る — あるタスクの newchan が兄弟の型付けを壊さないことの中身
- `chan t` は mutFree = true（Sharable の最小形）: region-domain-pool.md の
  「第 3 のクラス Sharable」の方向づけを、型述語の白リスト 1 行として実装。
  par の Γ 検査（mutFree）をチャネルが通ることが「不変値かチャネルのみ」の型付け化
- ChanOk がキューの値を世界非依存（`HasType Ξ [] 0 0 []`）で型付け。
  送信側は value_purify（loc-free 値は Ψ / b / d / Γ に依存しない）で世界から抜き、
  受信側は value_unpurify で任意の世界に入れる。mutFree_of_locFree（loc-free → mutFree）
  で共有境界 b も自由に付け替わる — 「純値は世界を選ばない」が補題 2 本で閉じた
- progress は四択に: 値 / panic / Blocked（recv 待ち） / 1 歩。
  Blocked は帰納的（recv 待ちの ret、待機と完了の組の par）で、
  `blocked_no_step`（待機 = どのスケジュールでも進めない）が待機の意味を固定する。
  デッドロック自由は主張しない（型の性質ではない。ex12 が実演）
- par_step_commute は「K を変えない歩」に弱めた: チャネル操作は同期点なので
  可換性を主張しない — DRF は決定性ではなく「ヒープアクセスは可換、非決定性は
  チャネルに封じる」。K を変えずに成功する歩は K を読みもしない（send / newchan /
  成功する recv はすべて K を変える）ので、「K 不変」が「チャネルに触れない」の
  特徴づけとして正確

発見:

- 「子世界 → 親世界の値 transport」の壁は、ペイロードを loc-free に絞ると
  purify / unpurify の補題 2 本に縮む。壁の本体は参照つき値（次の段の flatten）にあり、
  同期機構と transport は直交に分離できた
- チャネルの同期が結果を決める実行例（ex11）: 受信側を先に走らせて待たせても、
  送信後に再開して同じ 42 — スケジュール非依存が「同期を通した値の一意性」として見える
- Lean の罠追加: `Option.map f o = some x` を simp すると ∃ が `∃ a b,`（Prod.exists）に
  割れる — pair の obtain パターンは `⟨s', K', h, rfl, rfl⟩`（⟨⟨s', K'⟩, …⟩ だと
  State の cases に化ける）。仮説内の map は `cases hstep : step …` で先に割る方が安定。
  ∀ π を含む帰納（blocked_no_step）は π を引数に置くと IH が同じ π に固定される —
  結論を `∀ π,` にして intro する

### 段 3d の断片（チャネルの参照つきペイロード = 共有 region 参照。2026-09-18 完了）

ペイロードを loc-free から「mutFree かつ共有 region への imm 参照を含んでよい」へ緩和。
sorry なし、公理は propext / Quot.sound のみ（par_step_commute / blocked_no_step は propext のみ）。
言語側の裁定は language.md 18 節（シャローコピー + 共有 region 参照 = 案 C'。
flatten = 深いコピーは棄却: 消去型は再帰型で recv の型が書けず、構造保存は box 型 +
ヒープ非循環性が要り最重量。明示 deep-copy は std の仕事で体系外。
積んでいた「flatten + 非循環性」の壁は、この裁定で消えた —
非循環性の発見「freeze の順序が imm 参照グラフの位相順序」は std の deep-copy 検証用に残る）。

裁定（機械化の設計）:

- `chan` 型が共有上界 rc を持つ: `Ty.chan (rc : Nat) (t : Ty)`。
  `regionsBelow d = (rc ≤ d) && t.regionsBelow rc` — ペイロードの参照は region < rc 限定で、
  チャネル自体が rc より下へ escape できないことが「参照先はチャネルより長生き」の型付け化。
  mutFree は true のまま（Sharable）。rc は脱糖器が計算するコア AST の注釈
- Ξ のエントリが共有プレフィクスのスナップショットを持つ: `ChanTy := List (StoreTy × Ty)`、
  エントリ (Ψc, t) の Ψc は生成時の `Ψ.take rc`（長さ = rc）。queue 値の型付けは
  `HasType Ξ Ψc rc rc rc [] v t`（世界非依存 → スナップショット世界依存へ。
  rc = 0・Ψc = [] が段 3c の loc-free チャネルの特殊形で、purify / unpurify は一般機構に吸収）
- chanV の型付けにスナップショット等式を焼き込む: `Ξ[c]? = some (Ψc, t)` に加えて
  `Ψ.take rc = Ψc` と `rc ≤ f`。「chanV に型が付く世界はペイロードの参照先を
  スナップショットと同じ内容で持つ」が局所的に読め、send と recv がこの等式で出会う
- 書き込み床 f を HasType の新 index に（`HasType Ξ Ψ f b d Γ e t`。機械状態では f = b）:
  等式の保存には「この世界線の書き込み（alloc / freeze）は region ≥ f ≥ rc」が要るが、
  par が b を d に引き上げるため b では表現できない — par 本体の中の chanV に
  「rc ≤ 内側の b」だけ課すと、実行では到達しない導出（rc > 実世界の境界）が
  preservation を壊す（幽霊導出）。f は par を素通しし、spawn 時に f_mono で引き上げる。
  f は chanV / newchan の `rc ≤ f` にしか現れないので f の引き上げは自明に単調
- newchan の premise: `rc ≤ f ∧ t.regionsBelow rc ∧ t.mutFree`。
  rc ≤ f が生成後のスナップショット不変を構成的に保証する
- チャネルつき並列スコープ parch を追加（`parch t e1 e2`: rc = spawn 深度 d の
  チャネルを作り var 0 として両本体に渡して spawn）: フラッグシップの
  「親が深さ d でデータとチャネルを作り、子 2 つが共有」は、親（b < rc）の単独 newchan では
  作れない — 生成から spawn までの間に親が region < rc へ alloc / freeze できて
  スナップショットが揺れる。生成と spawn を融合すると、生成の瞬間に全保持者の床が
  rc 以上になり、揺れる窓がゼロになる。親の続きにチャネルは残らない（子だけが束縛）
- store_mono のプレフィクス条件は ∀ 形（StorePre）: 「take f の等式」では足りない —
  deref がセル型付け（store `Ψ.take (r+1)`）を全体へ運ぶとき f = b > r+1 があり得る。
  「n ≤ f かつ n ≤ 元ストア長なら take n が一致」に一般化（スナップショットは
  元ストアに収まる長さしかないので chanV の必要分を正確に覆う）

発見:

- 「参照つき値の transport」の壁の本体は flatten ではなく世界間のヒープ内容の合意だった。
  タスクごとの Ψ は StateTy の存在量化に隠れて互いに関係を持てないので、
  合意はグローバルな Ξ に置いたスナップショットとの等式としてしか述べられない。
  等式が安定する条件を探ると rc ≤ f（書き込み床）と parch（生成 = spawn）に行き着く —
  設計が証明の側から一意に決まった
- 実行例 ex13: imm 参照を parch チャネルで送り、受け手が deref して結果を返す。
  参照は一度もコピーされない（キューを通るのは loc そのもの）。
  受信側を先に待たせても同じ 42 — 参照の transport でも同期が値を決める
- send / recv の transport は補題 4 本の合成に分解された:
  send = value_strengthen（深さ・ストアを rc へ）∘ value_sb（b → rc）∘
  value_f_set（型の regionsBelow rc から f → rc）、
  recv = store_mono（スナップショット等式がプレフィクスを供給）∘ value_depth_weaken ∘
  value_sb ∘ f_mono（rc ≤ 受け手の b）

### Sharable の断片（Pool = chan の派生形。2026-09-18 完了）

region-domain-pool.md「第 3 のクラス Sharable」の拡張を、新しい型規則ゼロで確認した。
Pool の骨格（acquire / release / 排他 / 待機 / 資源の再利用）は既存のチャネル規則だけで
書ける — Sharable の白リストは `chan` 1 行のまま、Pool は派生形。
定義の変更なし（Examples の追加のみ）、`lake build` 緑。

確認した対応（ex14 / ex15）:

- free-list チャネルが Pool の骨格: acquire = recv、release = send、
  空きスロットの集合 = キュー。排他は「キューの値は一度しか取り出せない」という
  チャネルの意味論そのもので、ロックも atomics も体系に現れない
- 共有可変状態は「値の循環」で書ける（ex14）: 状態はセルに置かず、
  acquire で取り出し release で戻す値そのもの。mut 参照ゼロで
  「両タスクの更新がどちらの順でも直列化され、失われない」が実行例で見える
- 資源の再利用（ex15）: imm 参照を循環させると、release 後の再 acquire が
  同じ loc を返す — Pool の本質「作り直さず回す」が、キューを往復する参照として
  そのまま機械化される。acquire の待機は recv の Blocked（専用機構なし）
- mut スロットの循環は型が付かない: newchan / parch の mutFree 検査が拒否
  （段 3d の否定例そのまま）。実 Pool の可変スロット（acquire が返すピン済み `*T`）は
  体系外で、region-domain-pool.md 4b「動的検査のはしご」（世代検査が底）が受ける。
  ここで白リストに `pool` を足したくなったら穴の信号 — 足さずに済んだことが
  「Pool のスレッド安全性は (a) 単一書き手 + 共有 Pool」（同 未決）の裏づけ

位置づけ:

- 言語側の裁定は変わらない: Sharable の確定は Phase 3 のアトミック設計と同時
  （language.md 未決）。この断片が言うのは「Pool は白リストの新エントリを要求しない」
  という消極的事実と、Phase 3 で書く「チャネル版 Pool 参照実装」（実 Pool との
  観測等価を差分テストで見る計画、region-domain-pool.md 164 行）の形が体系内に
  既にあることの 2 つ
- 実 Pool の性能形（atomics・フリーリスト・世代タグ）の正しさは TLA+ と
  差分テストの守備範囲（design-dev.md Phase 5b）。体系はその参照実装側だけを持つ

### 型検査器の断片（Phase 2 の一手目。2026-09-18 完了）

`Checker.lean`: 実行可能な型検査器 `typecheck` と、宣言的規則 `HasType` への
健全性・完全性の証明。「証明済みの型付け規則と型検査器のコードを同じ定義から出す」
（実装との照合 3 → 2 の 3）の核。sorry なし、公理は propext / Quot.sound のみ。

- typecheck_sound: `typecheck = some t → HasType … t`（全項で成立）
- typecheck_complete: ソース項（`Expr.src` = loc / chanV を含まない）なら
  `HasType … t → typecheck = some t`。2 つ合わせて hasType_iff_typecheck
  （ソース項の型付けは typecheck が決定する）と hasType_unique（ソース項の型は一意）
- loc / chanV は検査器の対象外（none を返す）: 実行時にのみ現れ、型付けに自由度が
  ある（loc の m は条件次第で両方選べる）ため。ソース項に絞ることで完全性が言えた —
  「脱糖器が Lean に渡すコア AST の範囲 = Expr.src」が境界の仕様になる
- Examples に ex1〜ex15 全部 + 否定例 3 本の突き合わせ（rfl で照合）

Lean の書き方の発見:

- 検査器の本体は do 記法でなく明示 match で書く: `split at` は Bind.bind を
  割れない（match 式でないため）。明示 match なら等式補題 → `split at h` の 2 手で
  健全性の各ケースが機械的に落ちる（`split at h <;> try cases h` — 失敗アームは
  constructor 衝突で閉じ、成功アームは some 単射で代入される）
- `exact nomatch h` の罠: 反駁できない h に使うと「Missing cases」がログ型エラーに
  なって sorry でゴールが閉じ、後続タクティクが「No goals」で壊れる。
  `try` で包んでも守れない（例外でなくログのため）。反駁は `cases h` を使う

JSON 境界とバイナリ（同日 完了）: コア AST の形は最小案で裁定—
「Phase 1 で codegen が内部でやっている脱糖をそのまま JSON 化する」（inline 展開込み・
パターン済み）。脱糖を浅くして Lean の Expr を広げる案は棄却（広げた分が未証明の
参照実装になる。「正直に見ておく点」）。

- `Json.lean`: toJson / fromJson が境界スキーマの正（"k" が種別タグ。ファイル冒頭に
  全形を列挙）。fromJson は燃料つき再帰 — partial にせず計算可能に保ち、
  parse ∘ print の不動点を rfl で照合（Zig printer の不動点オラクルと同じ形式）。
  loc / chanV は境界の語彙に無い = パースが拒否（Expr.src の機械化）
- `Main.lean` + `lake exe sober-check`: stdin にコア AST JSON、stdout に判定
  `{"ok":true,"ty":…}` / `{"ok":false,"errors":[…]}`（診断が育つ余地のリスト形）。
  終了コード 0 = 受理、1 = 拒否。実行はコンパイル済みで検査器の証明はそのまま乗る
- スモークテスト: ex14 受理（int）、escape 拒否（type error）、非 JSON 拒否（parse error）

Zig 側の脱糖器と `sober check`（同日 完了）: `src/stage1/desugar.zig`（AST → コア AST → JSON）と
CLI サブコマンド `sober check <file> [--core-json]`（脱糖 → sober-check を子プロセスで起動 →
判定を relay。検査器は `$SOBER_CHECK` → PATH → `lean/.lake/build/bin/sober-check` の順で探索）。
テストは `src/stage1/desugar.test.zig`（対応の JSON 照合 + 断片外の拒否 + sober-check があれば統合）。
裁定と対応の決めごと:

- 検査単位は `main` の本体 1 つ（コアに関数が無い）。inline 関数（expands）とラムダは
  呼び出し点に AST レベルで展開して消す（値引数は letE、可視範囲は codegen の View と同じ規律:
  inline 本体は自分の引数のみ、ラムダは定義時 env + 引数。名前 → de Bruijn は束縛の絶対
  レベルで解決）。非 inline 関数の呼び出しは断片外として拒否。全関数個別検査案は Γ の与え方が
  無いので棄却
- main 本体は `block` で包む — alloc 規則が深さ 1 以上を要求するため（mut が深さ 0 で
  型付け不能）
- mut は段 2b の対応そのまま ref に: `mut x := e` → `alloc true`、読み → `deref`、
  `x = v` → `assign`、`x += v` → `assign` + `add`
- region 境界になるのは式位置の `{ }`・関数の本体・ループ本体（while の本体 — 文形 for は生成元の while の本体に展開される）
  （ループ本体は宛先構築レーン M4 2026-10-05 — `while c (block body)`・外への格納は copyTo / mksliceAt。language.md の「ループ本体はスコープ」。
  lower が反復の region を開くのは M5 — それまでは脱糖器だけが多く囲む向きで、これは健全〔lower は値を長く生かすだけ〕。regionbound は while の本体の block を引いて数える）。
  それ以外の `{ }` — if / switch の腕・閉包の本体 — は透過（letE の鎖 / scope だけ）。文位置の値は匿名束縛（letE）で流し、文列の終端は `triv`。
  脱糖器・codegen・lower はこの列挙で揃える（揃っていないと check が受理したプログラムを宙吊りに下ろす — 健全性の穴）。前例:
  - codegen（2026-09-27）: 腕ごとに region を開いており、腕の中で作って外へ積んだ値が死んだ region に残って後の周回で上書きされていた
  - lower（2026-09-29、c04ffd4）: 閉包の本体を式位置の `{ }`（blockValue）として region で囲んでいた — 文形 for の本体で確保して外の可変 slice へ
    書き戻すと反復ごとに畳まれて上書き（examples/lambda_region — 修正前 38980、正 19980）。凍結した Zig 版も同じ穴を持つので lower 側の Zig ≡ Sober から 5 本を退役
    （scripts/frozen/lower-retired.list）。黄金の例外 3 件目（irtext / lltext 7 本 — scripts/regiondrop.ts で「region 操作の除去と番号の振り直しだけ」を機械照合）
  - 積み（再発防止の機械検査の案 — 未実装）: 「コアの block の数 = IR の region.enter の数（関数の入口を除く）」を差分オラクルで照合し、脱糖器と lower の region 境界の一致を見る
  - 周回ごとの回収は意味論（ループ本体はスコープ — language.md）。旧記述「最適化器の仕事」は 2026-10-04 の裁定 (a) で置き換え
- 演算子は `+` と `<` のみ（Lean 側が代表 2 つに絞っているため）。`a > b` → `lt b a` の
  正規化は評価順が変わるので棄却。定数パターン・break / continue / defer・多値・非 tail の
  return も断片外
- 2 バリアント union: 構築は `inl` / `inr`（注釈 = 他方のペイロード型。0 フィールド variant は
  `unit` / `triv`）、型パターン switch は `case`（default は残り variant の腕に共有）

応答時間ベンチ（同日）: `bench/check_bench.sh`（end-to-end の `sober check`、「順序」5 の
再実装トリガー計測）。基線 2026-09-18: 約 130ms/run（大半は Lean バイナリのプロセス起動。
遅くなったらまず Lean 4 の C 出力リンク案を試す — 条件 2）。

段 2 の差分テスト基盤（同日 完了）: `lean/FeatherweightSober/Gen.lean` +
`lake exe sober-gen <seed> <count>` — JSONL（各行 `{"e": コア AST, "v": 判定}`）を吐く。
golden セットは `testdata/corevec.jsonl`（seed 42・300 本、accept 204 / reject 96）、
照合は `scripts/corevec.sh`（再生成 diff。`--binary` で sober-check バイナリ経路も照合、
`--regen` で意図した変更後の更新）。将来の Zig 再実装（「順序」5）はこのベクタで
Lean をオラクルにする。

- 生成器は 2 本立て: 型指向 `genTyped`（typecheck の規則に沿って well-typed な項を組む。
  let / ite / case / ifnil / block / alloc / deref / assign / while / freeze / newchan /
  send / recv / par / parch を踏む）+ chaos `genChaos`（語彙全体からランダム。reject 側）
- 裁定: plausible でなく Lean core の StdGen。当初「依存追加が要るから」としたのは
  不正確で、正しい理由は「plausible の提供物（derive / shrinking / `#test`）が今回の
  成果物に効かない」— 核の型指向生成器は型規則を知らないと書けずどのみち手書き、
  乱数は core の `mkStdGen` / `randNat` で決定的に足りる（toolchain 固定で再現可能）。
  Lean 内 PBT（preservation の `#test` 等）をやる段になったら plausible を入れる
- 型指向生成器の不変条件: ターゲット型は常に loc-free（ref / chan は Γ にだけ現れる —
  alloc / newchan / parch の束縛経由）。これで block の escape 検査に常に通り生成が
  行き詰まらない。共有境界 b をスレッドし、par / parch の腕は b = d で生成
  （alloc は D ≥ b + 1 まで block を開いてから置く）
- 生成器のバグ 2 件を判定側（typecheck）が検出して直した実績: par の腕の b を無視した
  alloc、recv 束縛の Γ ズレ。「生成器が golden を汚しても typecheck が正」の構図が効いた
- 検証: 2 シード × 200 本の型指向ベクタが全 accept、chaos 込み 300 本で accept/reject 混在、
  バイナリ経路（sober-check）と in-process 判定の一致を先頭 30 本で照合

### Phase 2 第一弾のスコープ（裁定 2026-09-18）

- 範囲: 関数（一階）+ n-ary struct/union + 多値 — Phase 1 で codegen が動く全構文が
  `sober check` に通る状態が第一弾のゴール（fib / shape / multi）。string / slice / map の
  region 意味論（language.md 未決）は第二弾に切り離す。T? flow typing 先行案も棄却
  （ifnil はコアに証明済みだが、関数が無いままでは check の適用範囲が狭すぎる）
- 証明ごと広げる: Featherweight の新しい段として HasType / typecheck /
  progress / preservation まで揃えて進める。別型 FullExpr + 未証明参照実装の二層案は
  棄却（JSON 境界・ベクタ・検査器が未証明側に移り、断片を育てるとき同じ定義を二度書く）
- 段構成: 演算子 → n 項化 → 関数（裁定 2 回目 2026-09-18: 当初の 関数 → n 項化 から
  入れ替え）。多値はコアに入れず脱糖器が struct に落とす（決定 19「実体化しない」は
  codegen の仕事で型検査には見えない）
- List をコアに入れない（nested inductive は全帰納証明で標準 induction を壊す）:
  - struct は二項直積の右結合入れ子: `Ty.prod l r` + `pair` / `fst` / `snd`。
    フィールド名 → 位置とネスト展開は脱糖器の仕事（段 1 の「名前 → 位置」の延長）。
    n = 0 は unit、n = 1 は素の型（prod を作らない）
  - n-ary union は既存の二項 union の入れ子（コアの変更ゼロ。variant i → inl/inr 鎖、
    switch → case の入れ子）
  - call は引数 1 個固定 `call f e` が永久設計: 多引数は struct（pair 鎖）に脱糖
    （「多値 = struct」と対称。評価順はフィールド順で保存）。`call (args : List Expr)` 案は
    nested inductive のため棄却
  - 順序入れ替えの理由: struct が先に入れば関数の段が最初から完全体（1 引数 = struct）で
    書ける。fib の check は両段完了後
- 演算子は 2 ファミリに畳む: `arith op a b : int`（sub / mul / div / mod）と
  `cmp op a b : bool`（eq / ne / le / gt / ge）。1 演算子 1 コンストラクタは証明の場合分けが
  演算子数に比例するので棄却。既存の add / lt はそのまま残して追加のみにする
  （置き換えは証明・Examples・JSON・Zig の全リネームが波及するため棄却。非対称は美的問題）。
  div / mod は `Int.tdiv` / `Int.tmod`（x86 idiv の切り捨てと一致: -7÷2 = -3 余 -1）、
  ゼロ除算は panic（既存機構）。`a > b` → `lt b a` の正規化は評価順が変わるので引き続き棄却。
  `&&` / `||` / `!` は ite への脱糖（短絡がそのまま出る）
- ビット演算（`&` / `|` / `^`）は見送り — 対応タイミング: 第二弾の頭。理由: Lean core に
  Int のビット演算が無く、自前の 2 の補数実装は x86 との一致検証がもう一仕事になる
  （演算子の段の本旨でない）。第二弾で入れるときの作法: Int 上の 2 の補数 land / lor / lxor を
  Lean で定義し、Zig 側の命令エンコーダオラクルと同じ形で Lean 実装 ↔ 実行結果の突き合わせ
  ケースを差分テストベクタに足してから arith ファミリに op を追加する（ファミリ設計なので
  追加は op 1 つ + 意味論 1 行 + 証明の場合分けは増えない）。それまで `&` / `|` / `^` は
  断片外（CoreFragment）として明示的に拒否される
- 関数境界は loc-free・呼び出しは新しい世界: 引数・戻り値は loc-free 限定、call は
  par の spawn と同じ「自前ヒープの入れ子世界」で実行（段 3a の隔離を流用。関数本体の
  型付けは「空ストア・深さ 0・Γ = params（loc-free）」で par のタスクと同型）。
  関数本体を深さ多相で型付けする案は region 絶対レベルの単純さを壊すので棄却。
  ref を関数境界で渡すのは後段（region escape 規則の関数版）へ
- 名前解決の最小形（package の形）は第一弾では保留 — 単一ファイル・package main のみで
  package 横断が無いため。第二弾の入口で決める

### 演算子の段（2026-09-18 完了）

第一弾の 1 段目。`lake build` 緑、sorry なし、公理 propext / Quot.sound のみ。

- Expr に `arith op a b`（sub / mul / div / mod、int → int）と `cmp op a b`
  （eq / ne / le / gt / ge、int → bool）の 2 コンストラクタ。add / lt は既存のまま併存
- 意味論: `ArithOp.eval : Option Int`（none = ゼロ除算）。ゼロ除算は step が panic に
  落とす（既存機構。language.md 未決「panic の適用範囲」が決まったらここが変わる、と
  Machine にコメントで紐づけ）。div / mod は Int.tdiv / tmod（x86 idiv と一致）
- 証明の追加は全て機械的（フレーム arithL/R・cmpL/R を add/lt と同型に、preservation の
  arithR だけ `split at hs` で panic 分岐が増える）。Examples に ex16（演算混合）・
  ex17（ゼロ除算 panic）と roundtrip
- JSON はフラットな種別タグ（"sub" … "ge"）で arith / cmp に落とす。fromJson の
  アームはヘルパーに切らず展開（mutual にすると well-founded コンパイルで roundtrip の
  rfl 照合が壊れる — Lean の罠）
- Zig 脱糖器: 演算子マップ + `&&` / `||` / `!` → ite（短絡がそのまま出る）+
  単項 `-e` → `sub (lit 0) e` + 複合代入（-= *= /= %=）。ビット演算は CoreFragment で
  明示拒否（第二弾の頭）
- 生成器: genTyped の int / bool ターゲットと chaos に演算子を追加。golden 再生成
  （300 本、typed 側全 accept を維持）

### n 項化の段（2026-09-18 完了）

第一弾の 2 段目。`lake build` 緑、sorry なし、公理 propext / Quot.sound のみ。

- コアは prod / pair / fst / snd の 4 つだけ: struct は右結合の prod 鎖、n-ary union は
  既存の二項 union の入れ子（コアの union は変更ゼロ）。証明の追加は全て機械的
  （canonical_prod + 各帰納の pair / fst / snd ケース。新しい壁なし）
- Zig 脱糖器が名前 → 位置とネスト展開を全部持つ:
  - struct リテラル → pair 鎖（名前つきは位置に並べ替え、評価はフィールド順）、
    selector → 射影（i < n-1 は `fst (snd^i)`、末尾は `snd^(n-1)`）
  - n-ary union の variant i → inl / inr 鎖（注釈は残り部分木の型）、switch → case の
    入れ子（各段の右腕が var 0 で残りを再分解。パターンのフィールド名は射影の letE で
    束縛。1 フィールドは射影が恒等なので case 束縛に直接名前を付ける）
  - フィールド代入は再構築: `p.y = v` → `assign p (pair (fst (deref p)) v)`（パスは
    再帰的に組み直し。複合代入はフィールドパスでは断片外）
  - 多値の同時束縛・同時代入: `x, y = y, x % y` は全値を letE で評価してから代入
    （多値呼び出しの分解は関数の段で）
  - selector / フィールド代入の解決のため Binding に型宣言（decl）を持たせた —
    脱糖器が最小の型追跡を始めた点は関数の段（戻り値型）でも使う
- 統合例: 入れ子 struct（Tagged{id, s Shape}）・3-variant switch・フィールド代入・
  gcd の同時代入が 1 本の main で check に通る

### 関数の段（2026-09-18 完了）— 第一弾のゴール: fib が check に通る

`lake build` 緑、sorry なし、soundness / preservation の公理は propext / Quot.sound のみ
（Examples の fib 実行と JSON roundtrip だけ native_decide = ofReduceBool）。

- 関数表 Δ : Defs（`Def = {param, ret, body}`、引数 1 つ）を HasType / StackTy / HeapOk /
  ChanOk / StateTy / typecheck / step の先頭パラメータにスレッド（意味変更ゼロの下準備
  コミットを分離）。`call fn e` はコアの新コンストラクタ、フレーム callK、状態 callst
- call = par の spawn と同型の入れ子世界（単騎）: 引数・戻り値は loc-free（DefsOk が
  運ぶ）、本体は空ヒープ・空スタック・Ξ 共有で走り、完了で値がメインへ返る。
  値の世界渡りは `value_export` / `value_import`（strengthen → f_set → sb → ctx /
  store_mono → depth_weaken → sb → f_mono のはしご。チャネルペイロードの輸送と同じ理屈）。
  再帰は Δ 経由なので停止性不要のまま型健全性が立つ
- DefsOk（各本体が空世界 `Ξ=Ψ=[]、f=b=d=0、Γ=[param]` で型付く）は preservation /
  run_preserve / soundness の新しい仮定。checker 版 `checkDefs` と
  `defsOk_of_check`（typecheck_sound 経由、src 制約不要）でバイナリの入口も証明済み側に乗る
- JSON は `{"defs":[{"param","ret","body"}...],"e":E}` の封筒（素の式も後方互換で受ける）。
  sober-check は checkDefs を先に通す（拒否は "def error"）
- Examples: fibΔ で `checkDefs = true`・`call 0 (lit 10) : int` が rfl、fib 7 = 13 の実行が
  native_decide、引数型違い・未定義 index の拒否
- Zig 脱糖器: 非 inline 関数（main 以外）を宣言順に関数表化。多引数は pair 鎖に束ねて
  1 引数（多値 return も pair 鎖 — 「多値 = struct」と対称の「多引数 = struct」）。
  本体は block で包み（mut に深さが要る — main と同じ）、2 引数以上は射影の letE で
  名前付け。`x, y := g(...)` の分解も射影の letE。println は「引数を評価して unit」に
  脱糖（出力の効果は analyzer 層の領分 — これで examples/fib.sober・multi.sober が
  そのまま check に通る）
- Lean の罠追記: `e.subst k v` のドット記法の罠を機械の call 規則で再踏。
  State に DecidableEq を derive すると native_decide で機械実行例が書ける

第一弾ここまでの check 対象: fib / multi / gcd 系 / union・struct 混在の main。
残りの断片外: break / continue（region の出口と一緒 = defer と同じ束）、定数パターンと
多 subject switch（eq が入ったので脱糖可能になった — 第二弾候補）、部分フィールドリテラル。

残る Phase 2 の作業: 第二弾（ビット演算、string / slice / map、名前解決の最小形、
`ifnil` / `T?` のソース構文の cst_to_ast 対応、定数パターン・多 subject switch の脱糖）。

### ビット演算の段（2026-09-19 完了）— 第二弾の 1 段目

第一弾で見送った `&` / `|` / `^` を、裁定済みの作法（突き合わせを先に用意してから
arith ファミリに op を追加）どおりに入れた。`lake build` 緑、公理は propext / Quot.sound
（突き合わせ Examples のみ native_decide = ofReduceBool — fib 実行と同じ扱い）。

- Lean 実装: Machine.lean に `intLand` / `intLor` / `intLxor`（無限桁の 2 の補数。
  `negSucc n` のビット列 = n の補元、mathlib の Int.land と同形。負×負は
  `~(~a op ~b)` の双対で閉じる）。補助の `natLdiff (a &&& ~b)` は core に無いので
  `Nat.bitwise` で定義。ArithOp に land / lor / lxor を追加 — ファミリ設計の回収:
  意味論 3 行 + eval の 3 アームだけで、Typing / Checker / Soundness / Substitution は
  1 行も変わらない（op はファミリ内で不透明）
- 突き合わせの対: examples/bits.sober（実行 = x86 の and/or/xor/not、examples/bits.out が
  期待値）と Examples.lean の `ArithOp.eval` 突き合わせが同じケース・同じ期待値を持つ。
  片側だけ変えるとどちらかが割れる（エンコーダオラクルと同じ役割）。負数含む 12 ケース。
  値が 64bit に収まる限り一致 — add と同じ約束（unbounded Int）
- `decide` は使えない: `Nat.bitwise` は WF 再帰で kernel 簡約が
  `natLdiff` で止まる。突き合わせは native_decide（Examples 限定の既存方針）
- Zig: エンコーダに `notReg`（F7 /2、negReg と同族）+ オラクルケース。codegen の
  単項 `^` は `not rax`。脱糖器は `&`/`|`/`^` → and/or/xor、`&=`/`|=`/`^=` を
  複合代入ファミリに追加、単項 `^x` → `xor x (-1)`（not と同値）
- ~~シフト（`<<` / `>>`）は断片外のまま~~ → 回収（下の「シフトの段」、2026-09-27）
- JSON タグは "and" / "or" / "xor"（`&&`/`||` は ite に脱糖済みなので衝突しない）。
  golden 300 本を再生成（ビット演算 29 件混入、typed 側 accept 維持、バイナリ照合 OK）

### シフトの段（2026-09-27 完了）— 随時回収 R2

裁定 = Go 準拠: `x << n` は n ≥ 64 で 0、`x >> n` は算術右シフト（floor）で n ≥ 64 は 0 / -1、
負の n は panic（ArithOp.eval が none → ゼロ除算と同じ受け皿。Go の実行時 panic と一致）。
棄てた案: x86 の 6bit マスクをそのまま意味にする（`1 << 64 = 1` — unbounded Int と突き合わせられず、
C の UB 由来の挙動を言語に持ち込む）。

- Lean: ArithOp に shl / shr の 2 op（Int の `<<<` / `>>>`）。shl だけ `64 ≤ b → 0` を明示
  （64bit 切り詰めの帰結）、shr は floor なので unbounded のままで 0 / -1 が出る。
  Typing / Checker / Soundness / Substitution は無変更（ファミリ設計の 2 度目の回収）。
  Gen に shl / shr を追加し golden 300 本を再生成（シフト 11 件混入、判定の分布は不変）
- 突き合わせの対: examples/shift.sober(.out) ↔ Examples.lean のシフト節（同ケース・同期待値、
  n = 0 / 63 / 64 / 100 と負数の被演算子）+ 負の量の panic（exShlNeg）
- Zig: エンコーダに `shl r, cl` / `sar r, cl`（D3 /4・/7、GNU as オラクル込み）。
  codegen は cmp で負 → rt_panic（exit 101）、> 63 → shl は 0・sar は量を 63 に畳んでから x86 シフト。
  脱糖は `<<` / `>>` / `<<=` / `>>=` → shl / shr。loader の const 畳み込みも同じ場合分け
  （負の量は const の段でロードエラー — Go のコンパイルエラーと同じ）
- 約束は add と同じ「値が 64bit に収まる限り一致」: `1 << 63` は x86 で minInt、Lean は 2^63（突き合わせ外）

### 定数パターン・多 subject switch の脱糖（2026-09-19 完了）— 第二弾の 2 段目

コア・証明・JSON は一切変更なし — eq が入ったので Zig 脱糖器（constSwitch）だけで
落ちる段。examples/switch.sober（subject 無し / 単値 / 複数 subject・`1 | 2`・`_`・
裸識別子束縛）が実行と check の両方に通る。

- 脱糖の形: subject を宣言順に letE で 1 回ずつ評価 → case を後ろから ite に畳む。
  case の条件は「位置ごとの選択肢 or 連鎖（ite 脱糖 = 左から短絡）」の and 連鎖。
  codegen の評価順（subject 先行・選択肢は一致するまで逐次評価）と一致
- `_` は条件なし（常に一致）、裸の未知の識別子は subject の値の束縛（syntax.md 9 節。
  束縛だけの case 以降は不到達で消える）。subject 無しは条件式をそのまま ite の条件に
- default 無しで全 case が外れたら unit: 値として使うと腕の型が割れて検査で落ちる
  （codegen は default 無しの値 switch で不定値を返し得る Phase 1 の穴 — 検査側が締める形。
  実行と検査で受理が split する初のケースだが、拒否方向なので健全）
- 多値呼び出しを単一 subject に置く形（`switch g() { case 1, 2: … }`）を回収（2026-09-27、随時回収 R4）:
  subject が結果 2 個以上の名前付き関数の呼び出し（`g(...)` / `x |> g(...)`）なら、アリティを関数表の
  結果型から引き、呼び出しを letE で 1 回だけ評価 → 各成分を射影（fst / snd 鎖）で subject に並べる。
  分解 bind `x, y := g()` と同じ形で、codegen の evalMulti + spill と評価順が一致（呼び出し 1 回）。
  コア・証明・JSON は変更ゼロ。case の項数 ≠ 結果の個数は desugar（CoreFragment）/ codegen
  （PatternCountMismatch）の両方で拒否。名前付き関数以外（閉包・ラムダの多値呼び出し）は断片外のまま
- 型パターン switch（unionSwitch に改名）は従来どおり。型パターンと定数パターンの
  混在は Malformed
- 裸識別子の判定は desugar / codegen が同じ規則（isBindingPattern → ast.Pkg.hasTopName）。
  衝突禁止は loader が先に保証する（2026-09-27、随時回収 R1 — syntax.md 決定 13）

### ifnil / `T?` のソース対応（2026-09-19 完了）— 第二弾の 3 段目

コア（ifnil / some / nil / Ty.opt）は段 1 から証明済み — この段はソース構文
`T?`・`nil`・`if x != nil` を実行（codegen）と検査（脱糖器）の両方に通す配管。
examples/opt.sober が実行と check の両方に通る。

- AST: TypeExpr に `opt`、Expr に `nil` リテラル（識別子 `nil` は AST 層で
  リテラル判定 — syntax.md 9 節の裸識別子と同じ扱い）
- codegen（Phase 1 型表の拡張）: `opt` = union と同じ「語 0 = タグ（0 nil / 1 some）、
  以降ペイロード」のアグリゲート。`nil` は値を出さない仮の型 `nil_` で流れ、期待型のある
  sink（return / 引数 / 代入 / フィールド値）の coerce が実体化する。ペイロード型の値も
  同じ coerce がタグ 1 で包む（暗黙 some — language.md 15 節）。`x == nil` / `x != nil` は
  タグ検査。`if x != nil` は値のある腕で x をペイロードのコピーに再束縛（flow typing。
  シャドーイング検査は意図的に迂回 — mut の絞り込みも再束縛は imm なので腕内の再代入は
  Immutable で落ちる）
- 脱糖器の最小の型追跡を拡張: Binding に核 Ty（params は宣言から、`x := e` は
  computeTy — lit / var / call / composite / selector / 演算子 / block 末尾の bottom-up。
  分からなければ null）。期待型が T? の sink で nil → 注釈つき `nil t`、ペイロード型 →
  `some`、静的に決められないときは CoreFragment で正直に拒否（型を静的に知る責務は
  Lean 側 — 脱糖器は wrap の判定に必要な最小限だけ持つ）
- 双方向の最小形 = if の腕への期待型の押し込み: `return if c { 42 } else { nil }` の
  ため、期待型が T? の if 式は腕ごとに coerce（codegen の exprExpecting / 脱糖器の
  coerceArm。腕は単一式のみ — それ以外は静的計算に任せて決められなければ拒否）。
  switch の腕への押し込みは必要になったら
- `if v != nil { return v }` の早期 return は依然断片外（return は末尾のみ —
  break / continue と同じ束）。idiom は `return if v != nil { v } else { 0 }` で書く。
  早期 return の脱糖（継続の CPS 化 or ite の入れ子への正規化）は region 出口の段で一緒に
  （→ 2026-09-27 回収: コアの label / jump で — 「label / jump の段」V4-3）
- Lean / JSON / 証明は一切変更なし（opt / ifnil / some / nil は段 1 の語彙のまま）

### slice / string の段（2026-09-19 完了）— 第二弾の 5 段目

language.md 21 節の裁定（slice + string 先行・`xs[i]` は panic（当時は暫定、2026-09-27 に language.md 27 節で確定）・append は
「bump 先端一致なら in-place、他は region 先端へ全コピー」・cap 廃止・string リテラルは
rodata = 最外 region）の実装。`lake build` 緑、sorry なし、公理は propext / Quot.sound のみ。
examples/slice.sober が実行と check の両方に通る。

- Lean（コミット「slice の段（Lean 側）」）: `Ty.slice m r t` は ref の一般化
  （regionsBelow / mutFree 同型）。式は mkslice / index / lenE / append / setidx +
  freeze の slice 規則（freezes）。実行時値 `slicev mt r base len` はタグ持ちヘッダで、
  型付けは loc 規則の範囲版（per-cell 量化 — 空 slice の base は無意味な値でよい、
  これで StoreLE の強化なしに store_mono が通る）。
  - 発見 1: slicev には `(mt = false → t.mutFree)` が m と独立に要る。
    m = true の slice が凍結済みの写し（mt = false）を持ち得て、その append が
    imm タグのセルを書く — immMutFree 不変条件の床はヘッダ側のタグに掛かる
  - 発見 2: `omega` で矛盾から任意ゴールを閉じると Classical.choice が公理に混ざる
    （False 経由の導出）。`exact absurd h (Nat.not_lt_zero _)` で回避
  - heapOk の新補題: heapOk_append1（任意 region の末尾 1 セル — heapOk_alloc の一般化）、
    heapOk_append_copy（コピーのプレフィクスを 1 セル版の帰納で畳む）、
    heapOk_freezeRange（単セル freeze の帰納）。append の前提 `b ≤ r` が
    step_shared_stable（共有プレフィクス安定）をそのまま延ばす
- codegen: region アリーナ = mmap（MAP_FIXED | NORESERVE の遅延ページ）に
  深度ごとの固定スロット。META に現在深度と深度別 bump。関数プロローグ / ブロック式が
  region を開閉し、break / continue / return の飛び越えは深度スロットの退避・復元で受ける
  （while はループ頭と出口で復元）。slice ヘッダは (ptr, len, depth) の 3 語のアグリゲート。
  append は Lean と同じ「先端 1 セル / 全コピー」の分岐（エイリアス経由の観測が一致）。
  境界検査は符号なし比較 1 回（負の添字も範囲外も jae → panic = exit(101)）。
  string リテラルはコード末尾の 8 byte/文字セル列（rodata 相当）を指す imm ヘッダ、
  depth 0 = 最外 region。println(string) はセルごとに print_char（→ 2026-09-27 io-4 で行バッファに積む形。
  スロットは 1MB → 64MB → 実行時可変（既定 4GiB — 2026-09-28）、bump の前進に上限検査 = exit 102 — language.md 27 節・io-0）。
  mmap の命令列（r10/r8/r9 は生エンコード）はオラクルにケース追加
- 脱糖器: `[]T{…}` → mkslice + append 連鎖、文字列リテラル → freeze(append 連鎖)
  （「mut で構築して不変化」のコア形 — codegen の rodata と観測同値）、`xs[i]` → index、
  `xs[i] = v` → setidx、len / append は組み込み呼び出しの横取り。
  slice 型は関数境界を渡れない（loc-free — 第一弾の裁定のまま。`[]T` の region 添字は
  使用文脈依存なので型注釈としても断片外。string は r = 0 で注釈可能）
- 断片外・積み残し: struct フィールドの slice（region 添字が宣言に書けない — 検査側のみ拒否、
  codegen は通る）、`<<` / `>>` と同じくスライス式 `xs[a:b]`、string の比較・連結演算子、
  map（第三弾）。panic の本裁定（`T?` 返しへの置き換え）は language.md 未決のまま

### 名前解決の最小形（2026-09-19 完了）— 第二弾の 4 段目

language.md 20 節の裁定（単一モジュール・ルート相対 import・package 名 = ディレクトリ名・
公開 = 大文字・循環禁止・全ソース一括）の実装。Lean / JSON / 証明は一切変更なし —
名前解決は脱糖で消え、コアは関数 index と de Bruijn の世界のまま。testdata/pkgdemo が
実行と check の両方に通る（横断の関数・型・const・修飾 composite / パターン・alias）。

- loader.zig（新設）: ディスク IO（load）と結合（link）を分離 — テストは link に
  ソースを直接渡す。import 収集は AST が要るので「link が返す未ロード import を読み足しては
  link し直す」反復。package 名 = ディレクトリ名検査・循環検出（DFS）・トップレベル const の
  畳み込み（決定 14 の const 式: int リテラル・算術・ビット・const 参照。ここで値に確定し、
  下流は `.lit` を見るだけ）
- 参照はフラットキー "pkg_path.Name": desugar / codegen とも宣言を修飾キーで登録し、
  「現在 package（cur_pkg）+ import 表」で解決する。修飾名は AST 上ドット付き文字列
  （TypeExpr の switch を増やさない）。可視性（大文字）は修飾参照の解決点で検査
- 本体の名前解決の文脈は「書かれた場所」: 関数本体は自分の package、inline 展開の本体は
  callee の package、ラムダは定義時の package（Closure に pkg を凍結 — View の鎖の凍結と
  同じ規律の package 版）。フィールド型の解決は宣言側 package（DeclRef = decl + pkg を
  Binding / declOf* にスレッド）
- 断片外のまま: main package を import する形（キー "main.*" は到達不能）、
  修飾名の型引数・メソッド類。~~診断はファイル横断で tok 番号のみに退化~~ → 回収（2026-09-27、随時回収 R5）:
  座標は Pos = 全ソース通しのトークン番号 1 語（src/stage1/srcpos.zig が唯一の定義）。loader が parse 順に
  各ファイルへ base（それまでの総トークン数）を割り当て、cst_to_ast が AST の tok に base を焼き込む。
  Program.srcmap（ファイル表 = path・source・base・トークン開始バイト）が Pos → path:line:col を解決し、
  loader / desugar / codegen の Diag は Pos だけを運ぶ。表示は `path:line:col: error: what (Err)`。
  棄てた案: ノードごとに {file id, tok} の組（AST の tok フィールド 35 箇所と全層の受け渡しが倍になり、
  V4 の error 値に載せる座標も 2 語になる）。構文エラーは PEG の最遠失敗トークンを位置にする

### map の段（2026-09-19 完了）— 第三弾

language.md 22 節の裁定（`m[k] : V?`・imm デフォルト + `mut` 前置・`freeze(x)` builtin・
全コピー成長・値ヘッダ・挿入順）の実装。`lake build` 緑、sorry なし、公理は
propext / Quot.sound のみ。examples/map.sober が実行と check の両方に通る。
ベンチ 92ms/run 維持、corevec golden 300 本一致。

- Lean: `Ty.map m r t` は slice と同型の値ヘッダ（`mapv mt r base len`）、セルは
  `prod int (opt t)`（none = 墓石 — delete の実体）。意味論は挿入列の連想モデル:
  findKey（先頭一致。entryKey を分離すると証明可能な形になる — 入れ子パターンの
  match を仮説で split すると割れる）+ countLive（lenm = 生きた数）。
  set は既存キー in-place（タグ検査 → 凍結済み panic）、新規キーは append と同じ
  「先端 1 セル / 全コピー」。getm / delm は不在・墓石の nil 構築のため t 注釈持ち。
  証明は slice の完全な鏡 — セル型 prod int (opt t) の mutFree / regionsBelow が
  t のそれと同値なので、canonical_map / StackTy 9 フレーム / preservation / progress /
  step_shared_stable / heapOk 補題（append1 / append_copy / freezeRange）が
  そのまま流用できた。Checker（freezem 込み）+ JSON（"mkmap"/"getm"/"setm"/"delm"/
  "lenm"、Ty "map"）+ Examples ex25-27
- 極性反転（Zig）: `[]T` / `map[K]V` = imm、`mut` 前置が可変。リテラルは
  mut 構築 + freeze（string と同じコア形）。grammar は type / composite_lit に
  'mut'?、非コンテナへの mut は AST 層で拒否。`freeze(x)` は脱糖 = CExpr.freeze、
  codegen = 型レベルの不変化のみ（実行時タグの物理表現は未決のまま）
- 脱糖: maplit → mkmap + setm 連鎖（重複キーは後勝ち）、`m[k]` → getm（V? が
  ifnil にそのまま乗る — 第二弾 3 段目の回収）、`m[k] = v` → mut 束縛への再代入
  `m = setm(m, k, v)`（成長でヘッダが変わるため）、delete → delm、len → lenm。
  ルーティングは computeTy の map 判定（maplit / index / freeze の型を追加）
- codegen: ヘッダ 3 語（slice と同型）、セル [key][tag][value]。find は先頭一致の
  線形走査、set は in-place / 先端 / 全コピーの 3 分岐、len は tag の合計 —
  Lean の op と同じアルゴリズムを構成的に踏む（脱糖器の規律の帰結。ハッシュ化は
  観測同値な最適化として将来 — 性能は最適化器へ）
- 断片外・積み残し: map の関数境界越え（loc-free のまま）、~~int 以外のキー~~（string は回収 —
  下の「string キーの map」。他の構造的等価キーは shape の設計と絡む）、イテレーション（Phase 3 の Iter と一緒。
  挿入順の意味論は 22 節で予約済み）、実行時タグの物理表現（凍結後書き込み panic の
  動的検査 — codegen は静的型のみで拒否、check 側は Lean が受ける）

### string キーの map（2026-09-27 完了）— 随時回収 R3

裁定 = B': キー型は slice の要素型と同じく具体的な region 添字を持つ普通の型（`map[string]V` ≅
`[]string` と同型の形）。region 多相は先食いしない。キーの制限（int | imm string）は mkmap の型規則だけ。
棄てた案: (A) キー region = map の region に固定（relocR で map の r を締めるとキーも動き `[]string` と非対称）、
挿入時にキーを map region へコピー（キーのバイトがセル列の先端を塞ぎ毎回全コピー = O(n²)）、
(C) 別コンストラクタ smap（map の証明の鏡の複製）。

- 表現: `Ty.map m r c` の c をセル型に読み替えた（mkmap が作るのは `prod k (opt v)`）。
  B' の意味（キー型 index）をセル型に畳んだ形で、Syntax の Ty 上の再帰関数（regionsBelow / mutFree /
  shiftR / relocR / sub / tsubst …）は 1 行も変わらない — mapv は slicev と完全に同型になった。
  JSON は `{"k":"map","m","r","key":K,"t":V}`（セル型が prod K (opt V) 以外のときだけ "cell"）
- 型規則: mkmap に `k.keyOk`（int | `slice false _ int`）。getm / delm の探索キーは
  `kq.keyCompat kt`（同種なら region を問わない — 探索は格納しないので escape が無い、eqs と同じ線）。
  setm の格納キーはキー型そのもの（脱糖器が ann で上界へ緩める）— 内側 scope で作ったキーを外側の
  map に積むと sub が通らず拒否（`[]string` への append と同じ制約。了承済みの帰結）
- 機械: `keyEq H`（lit は値、slicev は長さ + eqCells でバイト列比較 — eqs の 1 step 比較と同形）、
  `findKey H ρ base k`（H 依存化）、`entryKey` は `Option Expr`。getm / setm / delm は任意のキー値で発火し、
  progress から canonical_int が消えた。findKey_some は「セルは pair ke w 形」を返す
- 証明: 想定外の割れなし。セル型の置換（prod int (opt t) → prod kt (opt t)）と、新規キーセルの型付けに
  value_strengthen を 1 本足しただけ（v と同じ扱い）。keyOk / keyCompat の shiftR・tsubst 保存補題 4 本
- Zig: desugar の Ty.map に k、mapKeyTy（int | string 以外は CoreFragment）、mapKey（string キーは ann）。
  codegen のセルは `[key(1 or 3 語)][tag][value]`、探索は string なら長さ + 語ごとの比較ループ
  （Lean の keyEq と同じ比較を構成的に踏む）。キーのバイト列は共有（コピーしない — Go と同じ）
- 突き合わせ: examples/map_str.sober(.out) ↔ Examples ex25s（同じ綴りの別リテラルで命中・不在 nil・len、
  bool キーの mkmap 拒否、int で string キーを引く拒否）。corevec は生成器が map を作らないので不変
- 既知の split（拒否方向で健全）: 内側 scope のキーを外側 map に格納する形は check が落とすが codegen は通す
  （escape 検査は check の仕事 — `[]string` の append と同じ現状）

### keysm の段（2026-09-28 完了）— map のキー列挙

language.md 22 節の列挙の裁定（`keys(m)`・挿入順 = 初回挿入の順・最内 region・スナップショット — 決定 2026-09-28）の実装。
`lake build` 緑、sorry なし、公理は propext / Quot.sound のみ。examples/map_keys.sober が実行（正規・LLVM の両経路）と check の両方に通る。
corevec golden 300 本一致（Gen は据え置き — 回収点は parallel 形式化の直前の総追いつき）。

- Lean: `Expr.keysm e` 1 つ。型規則は concat の写し: 深さ d + 1 で `e : map m r (prod kt (opt t))`・`kt.keyOk`・`kt.regionsBelow (d + 1)`・`b ≤ d` ⇒
  `slice false d kt`（最内 region の imm slice）。機械は lenm の隣に `liveKeys ρ base len`（countLive と同じ走査で `pair ke (some _)` のキーを集める — 墓石スキップ）を足し、
  `H.set (H.length - 1) (ρi ++ ks.map (false, ·))` + `slicev false (H.length - 1) ρi.length ks.length`（concat と同じ最内 region への積み）。
  スナップショット性は構成から出る（キーの値を新しいセルへ写す — 以後の setm / delm は map の region のセルだけを書く）
- 証明: 新しい補題は `mem_liveKeys`（列の要素は覆う範囲の生きたセルのキー）・`liveKeys_typed`（そのキーは take (rr + 1) で kt に型付く:
  HeapOk.typed → sub_prod_invR → canonical_prod → value_coerce。keyOk ⇒ annFree で coerceTo が恒等になるので機械は型注釈を持たない）・`keyOk_mutFree` / `keyOk_annFree` だけ。
  セルの積みは既存の `heapOk_append_list`（深い relocate の部品 — 全セル imm・同型 t）がそのまま使え、preservation の keysmK は concat の catR の半分ほどで閉じた。
  progress・step_shared_stable（take b 不変）は concat と同形。Ren / TSubst / Substitution / Split は lenm と mkmap の前提（keyOk / regionsBelow / b ≤ d）の組み合わせで機械的。
  想定外の割れなし。keyOk を型規則に置いた理由: mapv の型付けは keyOk を運ばない（課すのは mkmap だけ）ので、新しいセルの immMutFree と注釈不要性を keysm 側で要求する
- Checker / JSON: typecheck は concat と同じ「深さ 0 は none・d' + 1 で keyOk && regionsBelow && b ≤ d'」。JSON `{"k":"keysm","e":E}`。
  突き合わせ: examples/map_keys.sober(.out) ↔ Examples ex27k（挿入 3・1・2 → delete 1 → 再挿入 1 → 4 → keys → delete 3 の重みつき和 = 43124 —
  再挿入の位置とスナップショットを rfl で固定）
- 脱糖（Zig + Sober）: `keys(m)` → keysm（computeTy = 最内 region の imm slice、要素 = キー型）。`for k <- m` は forexpand の生成元の種類（slice / map / closure）で
  `iter#.Slice(keys(src), k)` へ — 脱糖器はループを合成しない（std/iter.Slice が添字ループ — 脱糖器の規律・F1 のまま）。for の型推論（forIterTy）も map の生成元でキー型を束縛
- lower（Zig + Sober）: keys は Lean の liveKeys を構成的に踏む — mapLen で生きた数を数え、現在の深度に n × キー語数を取り、セル列を走査して tag ≠ 0 のキーの語をコピー。
  ランタイム関数は足さない（既存の全 .ll / .ir 黄金の rt 部分を動かさない — 黄金の差分は新規の map_keys 4 本だけ）。for の生成元の型は試し生成 + rollback で取る（forIterType と同じ方式）
- @embed の一覧（selfhost の R35-2 の回収）: loader の LoadFs は std の package のファイル一覧を `keys(sm)`（焼き込みの表のキー）から引く（dirname 一致 + `.sober`、バイト順の挿入ソート）。
  暫定の ReadDir を撤去 — stage2 は cwd の std/ に依存しない（stages.sh の hermetic の行: std/ の無い cwd で std を import するプログラムを build / check、.ll は Zig 版と一致）
- 断片外・積み: `for k, v <- m`（多名束縛 + `V?` の剥がしの約束）、Gen の keysm（総追いつき）、再束縛不可の機械的な強制（len / freeze も含めて名前の照合だけ — 実装の穴）

### call 同世界化の段（round4 = selfhost 検証 V1。着手 2026-09-19、設計下書き）

裁定（2026-09-19、ユーザー）: call の入れ子世界（par 同型の単騎）は同世界化で置き換える。
棄てた案: 併存（入れ子 call を残し段 3d の snapshot 機構を call に流用）— 引数は
value_export/import が延びるが、戻り値の新規割り当て（ミニ lexer のトークン slice）が
入れ子ヒープごと死ぬ。持ち帰り = ヒープ融合 + region 再番号付け = 世界間で同世界化を
やる羽目になり、最初から同世界の方が軽い。rc（共有上界）も呼び出し深度依存で、chan が
parch（生成 = spawn 融合)で逃げた問題を call は逃げられない。codegen は既に同世界
（単一 region スタック、関数プロローグが region 開閉）なので機械と形式化のズレ解消でもある。
移行は新旧併存で例を移してから旧 call を消す段取り（証明資産の保険）。

設計の核（実装前の下書き。証明が反証したら本節を更新）:

1. imm 参照の region 添字を「正確な位置」から「上界」に読み替える
   （`ref false r t` / `slice false r t` / `map false r t` = 「actual ≤ r のどこか」。
   loc 規則の imm 側が存在形 `∃ r' ≤ r` になり、緩める向きのサブタイピングが挿入で入る。
   mut は正確なまま — assign / append の書き込み先は揺らせない）。
   regionsBelow（escape 検査）・alloc の格納床・block 出口は上界に対してそのまま健全
   （actual ≤ 上界 < d が effect を含意）。これが本段の一枚目の壁の解:
   - 棄てた案 (a) region 消去型 ◇（新コンストラクタ「呼び手空間のどこか」）—
     セル格納で破綻: ◇ 内容のセルは HeapOk の「セルは Ψ.take (r+1) で型付く」に乗らず、
     トークンが入力 string の部分 slice を持つ形（V1 の必須ケース）が書けない
   - 棄てた案 (b) region 多相（シグネチャに region 変数 + call で instantiate）—
     上界の緩みがスラックを吸収するので変数 1 本すら不要。重い置換機構が丸ごと浮く
     （2026-09-27 訂正: imm に限った議論で、mut の不変性には当てはまらなかった — R2 の anchor が「変数 1 本」を暗黙のまま
     呼び手に選ばせる形。language.md 31 節）
2. Def は基底 1 で一度だけ型付けし、call が一様シフトで instantiate:
   DefsOk' = param / ret の上界 regionsBelow 1（従来の loc-free「0」が「1」になるだけ）+
   本体を base 1・Γ = [param] で型付け。呼び出し（呼び手深さ d）は全 region 添字を
   +d シフト — 上界だから rodata@0 → @d も健全（0 ≤ d、緩めるだけ）。二クラス問題
   （固定 rodata と呼び手空間の混在）が消える。ソース項は型注釈（nil / mkslice / getm /
   delm / inl / inr / newchan）に region を含むため、シフトは型だけでなく
   本体項の注釈にも掛かる（`Expr.shiftTy ρ` — 機械が callst 生成時に適用。純機械的）。
   証明の山 = シフト定理「base 1 で型付く本体は +ρ シフトで base ρ+1 でも型付く」
   （ソース項 = loc/slicev/mapv/chanV を含まない項に限定。par を含む本体で成立するかが核）
3. call = 同世界の region push + 戻り値の境界コピー: 引数評価 → 呼び手と同じ H・S 上で
   region を push（深さ d+1）してシフト済み本体を評価 → 戻り値のヘッダが自フレーム
   （region d+1）なら呼び手 region d へ最上段セルだけ浅コピーして pop。
   床は「中身の上界 ≤ d」= ret.regionsBelow 1 のシフトが構成的に保証（トークンの
   string フィールドは引数空間 ≤ d なのでヘッダごとコピーで生きる。[][]int の全 callee
   構築は弾かれる — 深いコピーは std / 後続）。block 出口は従来どおりコピーなし
   （21 節「境界コピー = 明示イディオム」と整合。自動コピーは関数境界のみ）
   → 2026-09-27 改訂: 深いコピー（R4a）・脱出（R4b α）・ブロックの出口（R5）の全部で境界コピーする —
   「region を持つ型の境界越えの段」
4. V1 の断片外: mut 引数（imm デフォルトの極性と整合）、戻り値の深い持ち帰り、
   region 注釈つきシグネチャ。検証例 = ミニ lexer（string → トークン slice・struct
   トークン・関数分割 — 呼び手フレームで構築した slice を次の関数へ渡す形を含む）

攻める順: (1) imm 上界化（loc 規則と挿入補題 — 単独で既存全証明を回す）→
(2) シフト定理 → (3) 機械の call 差し替え + 境界コピー（heapOk_append_copy が原型）→
(4) preservation / progress の組み直し → (5) 脱糖器・codegen（関数境界の slice 解禁）。

(1) imm 上界化 done（2026-09-19）: `lake build` 緑、sorry なし、公理は
propext / Quot.sound のみ（par_step_commute は propext のみ）。zig build test 全緑、
corevec golden 300 本一致、examples/slice.sober・map.sober は実行と check の両方に通る。

- loc / slicev / mapv の型 region rt は上界（`r ≤ rt`、mut は `rt = r ∧ b ≤ r` の
  連言で正確なまま）。canonical form は「∃ 実 region r ≤ rt」の存在形に
- slicev / mapv のタグを `mt = m` に強化（旧: m = false → mt = false の片向き）。
  機械の append が mt で mut / imm を判別して書き込み先を選ぶため、型の m と実行時タグが
  一致していないと書き込み先と型がズレる。発見 1（m=true ∧ mt=false）の premise は
  mt = m に吸収されて消えた
- append の型規則を appendM / appendI に分割: mut はヘッダ region r（正確、b ≤ r）の
  先端一致 in-place / コピー（従来どおり）。imm は現在の最内 region へ常に全コピー
  （b ≤ d。上界型では実 region に b ≤ r を静的に言えないため、書き込み先を自フレームに
  固定して健全化 — 21 節「現在の region へコピー」の字義どおり化。imm はセル不変なので
  コピーは観測不能）。typecheck は subject の m で分岐（構文主導のまま）。
  棄てた案: append mut 限定 — slice.sober の `append(xs, 4)`（xs は imm デフォルト）が
  ソースレベルで壊れる
- 新補助: `Ty.regionsBelow_mono`（上界緩めは常に健全）、`storeLE_take_le` /
  `storePre_take_le`（プレフィクス同士の輸送）、`heapOk_append_copy_cross`
  （跨 region コピー — imm append の source ≠ target 用。セル値の型付けは
  take (rs+1) → take (k+1) をプレフィクス包含で運ぶ）。StackTy の appL / appR は
  結果 region rr 持ち（mut: rr = r、imm: d = rr + 1 ∧ b ≤ rr）
- 積み残し（(5) で回収）: Zig codegen の imm append はまだヘッダ region 先端に書く
  （Lean は最内 region）。現行言語では観測不能（imm セルは不変・region 寿命の観測手段が
  ない）だが、call 同世界化で region が pop し始めると placement が寿命に効く —
  脱糖器の規律どおり codegen を Lean に揃えること
(2) 下準備 done（2026-09-19）— シフト・部分型・coerce の土台（`lake build` 緑）:

- `Ty.shiftR ρ`（全 region 添字 +ρ）+ zero / comp / regionsBelow / mutFree の可換補題。
  `Expr.shiftTy ρ` は項の型注釈（nil / inl / inr / mkslice / getm / delm / mkmap /
  newchan / parch）と実行時項の region 添字に掛かる
- `Ty.sub`（V1 = 浅い imm 共変）: imm コンテナ / 参照の region 上界だけ緩め、
  要素型は正確なまま。値ラッパ（opt / union / prod）へは分配、mut / chan は不変。
  棄てた案: 深い共変 — セル型付けが要素型を正確に固定するため「セル sub」が要る
  （後続の梯子）。実用上は「callee が注釈を緩い型で書けば、値は (1) の slack で
  緩い型に正確に型付く」ので、深い共変が要るのは値が別の緩さで再輸出されるときだけ
- 注釈値の座標問題と coerceTo: nil / inl / inr は型注釈を持つ値なので、緩めた型では
  型が付かない（規則を緩めると型の一意性 = checker の完全性が壊れる）。
  解: 機械が call 時に引数へ `Expr.coerceTo`（注釈だけの構造ウォーク）を掛け、
  `value_coerce`（v : ta ∧ sub ta tb → coerceTo tb v : tb）が境界を渡す。
  注釈は実行時表現を持たないので codegen ではゼロコスト（恒等）
- 確定した call の形（実装は次）: DefsOk' = 本体を base（region 0 = 圧縮された呼び手
  空間、1 = 自フレーム）で `f = b = 1, d = 2, Γ = [param]` により一度型付け。
  param.regionsBelow 1 ∧ mutFree（V1 = imm 引数）、ret は最上段のみ自フレーム可。
  call 規則は alloc 同型の (d+1) 形で ρ = d:
  `Δ[fn] = dfn → e : ta → sub ta (param.shiftR d) → call fn e : ret.shiftR d`。
  機械は callK → region push + coerceTo + 本体 shiftTy ρ + subst → fretK（返りの
  境界コピー = 構造 relocate + region pop）

(2)(3)(4) done（2026-09-19 同日）— シフト定理・call 差し替え・機械・全証明:
`lake build` 全緑、sorry なし、公理は propext / Quot.sound のみ（soundness / progress /
shift_typing / relocate_ok とも）。zig test 全緑、corevec 300 本一致、
fib / multi / slice / map の check が脱糖器変更ゼロで通る（本体の block 包みが
新 base（f = b = 1, d = 2）にそのまま適合し、main の block 包みが「call は深さ 1 以上」を
満たすため）。ベンチ 155ms/run（Lean バイナリ肥大分。大半は起動）。

- シフト定理（Shift.lean）: 空 Ξ・空 Ψ で型付くソース項は、世界（f / b / d / Γ /
  型 / 項注釈）を同じ ρ でずらしても型付く。空ストアでも「空 slice ヘッダ」には型が
  付く（セル premise が空虚）ので、実行時項のケースは反証でなく再構築
- call 規則: `Δ[fn] = dfn → e : ta → sub ta (param.shiftR d) → b ≤ d →
  call fn e : ret.shiftR d`（conclusion は d + 1 の alloc 同型）。
  `b ≤ d` は証明が要求した追加の裁定 — 戻りの relocate が呼び手フレーム
  （region d）に書くため、共有 region の直上では呼べない（タスクは block を開いてから）
- DefsOk': paramOk（regionsBelow 1 ∧ mutFree ∧ chanFree）・retOk（最上段 imm
  コンテナは自フレーム可・中身は呼び手空間・mut / chan 不可）・noNewchan・
  本体は f = b = 1, d = 2 で一度型付け
- f / b の引き下げが非対称（発見）: 本体はシフトで b = f = フレームの世界に立つが、
  実行時のタスク境界はそれより低い。b は常に `b ≤ X` でしか使われないので無条件に
  下げられる（b_lower）。f は newchan / chanV の `rc ≤ f` が壊れるので、bare newchan を
  含まない項に限って下げる（f_lower + noNewchan）。parch は f 制約を持たないので
  関数内の並列は断片内に残る — 生成 = spawn 融合（段 3d）の配当がここでも効いた
- 機械: callst（入れ子世界）を全削除。call = region push + coerceTo（引数の注釈
  書き換え）+ 本体 shiftTy + subst、fretK = relocate（境界コピー: ヘッダ / loc の
  frame セルを呼び手最内へ写す構造ウォーク、値ラッパへ分配）+ region pop。
  shiftTy / coerceTo / relocate の型注釈操作は codegen ではゼロコスト（実行時表現なし）
- relocate_ok（境界コピーの保存）: retOk な t0 の shiftR d の値は relocate が必ず
  成功し、region d だけが伸び（take d 不変）、pop 後の世界で同じ型に型付く —
  「imm の上界だから写しても型が変わらない」が (1) の回収。跨 region コピーは
  heapOk_reloc_copy（source が target より上でも、内容型の床を premise で受ければ通る）
- 積み残し → (5): 脱糖器の loc-free 制限解除（slice / string 引数・戻り値の型注釈）、
  codegen の呼び出し規約（フレーム region + 境界コピー + imm append の最内化）、
  検証例 = ミニ lexer

(5) 実地 done（2026-09-19）— 脱糖器の境界解禁・codegen の relocate・ミニ lexer:
zig build test 全緑、corevec 300 本一致、ベンチ 82ms/run。
examples/lexer.sober（string → トークン slice・struct トークン・関数分割）が実行と
check の両方に通る。既存 examples（fib / multi / slice / map / opt / switch / bits）も
実行・check とも回帰なし。

- 脱糖器の座標規約（V1 の裁定）: 署名の `[]T` / `map[K]V` は r = 0（呼び手空間の
  上界）、戻り値の最上段の slice / map だけ r = 1（自フレーム） に付け替える。
  checkDefs は `typecheck body == ret` の厳密一致（sub は call 引数のみ）なので、
  最上段 = 「本体で新規構築して返す形」（mkslice → freeze が r = 1 を合成）、
  フィールド・入れ子 = 「引数由来のデータの持ち場」（r = 0 のまま）と役割を固定した。
  帰結の断片外: 呼び手空間の値をそのまま返す転送（`return s`）、call 結果の再転送
  （`return g()` の slice 版 — ret.shiftR が r ≥ 2 を合成する）、fresh 構築の slice を
  フィールドに持つ struct の return。V1 のミニ lexer はどれも要らない
- def 本体の block 包みを廃止: 本体は base d = 2 で直に型付ける。自フレーム =
  call が push する region 1 に mkslice / alloc が乗り、retOk（最上段 r < 2）と
  fretK の relocate に揃う。block で包むと構築が region 2 に落ち regionsBelow 2 で
  返せない。alloc は d = 2 で直に型が付くので包みは不要だった
- codegen の relocate（epilogue の深度復元より前）: 結果スロット内の slice / map
  ヘッダの depth が「呼び手最内（fn_depth_slot の退避値）より深い」なら、セルを
  呼び手最内の bump 先端へ写しヘッダを付け替える。struct は静的オフセットで分配、
  opt / union の中の slice / map は Unsupported（タグ依存レイアウトは V1 断片外）。
  罠: fn_depth_slot は region enter 前の深度 = フレーム深度 - 1 — 比較は
  `hdr.depth ≤ 退避値 → そのまま`、書き先も退避値の region（初版は 1 段ズレて segfault）
- imm append の最内化: codegen の appendCall を mt で分岐 — mut = ヘッダ region で
  先端伸長 or 全コピー（従来）、imm = 現在の最内 region へ常に全コピー（(1) の積み残し
  回収。Lean の appendI と同型、新ヘッダの depth は META[0]）
- 運用の罠: sober-check バイナリが lean/ ソースより古いと全 def が "def error" になる
  （round4 で defs の base が変わったため）。手計算が合うのに落ちたらまず `lake build`

積み残し → 後続: ~~早期 return の脱糖~~（done 2026-09-27、「label / jump の段」V4-3）、~~mut 引数~~（V3-5・R2）・~~戻り値の
深い持ち帰り~~（R4a）・region 注釈つきシグネチャ（V1 断片外の本丸 — region 多相は採用しない裁定、language.md 31 節）、~~opt / union 内の
コンテナ relocate（タグ分岐の relocate）~~（R0）、計算列の computeTy が call 結果の region を
呼び手座標（ret.shiftR d）にしていない件（opt coerce の判定にしか使っていないので
現状無害 — 触るとき注意）。

- Lean の罠追記: `subst h`（h : a = b、両辺 fvar）の消える側は一意でない —
  連鎖 subst の生き残り変数は当てにせず、エラーで確かめて本文の変数名を合わせる。
  `split at hs` が Decidable.rec で落ちる ite は `by_cases + simp only [if_pos/if_neg]`。
  `fun h => nomatch h` を implicit Bool の premise に渡すと unification が
  h : false = false 側に倒れて "Missing cases: Eq.refl" — 補題側の m を `(m := true)` で
  明示してから nomatch

### call 結果の再転送（2026-09-19 完了）— round5 の入口で回収した V1 積み残し

round5 の検証例（ミニ parser）が最初に踏んだ穴: `nodes, kids, root := parse(...)` の
結果を `eval(nodes, kids, root)` に渡すと check が落ちる（実行は通る）。原因は call
規則の結果型 `ret.shiftR d` — fretK の relocate は最上段を呼び手最内（region d）へ
写すのに、型は r = 1 + d（既に pop された region）を上界に持ち、引数位置の
Ty.sub（r ≤ param 上界）を満たせない。既存例は call 結果を len / index でしか
使わなかったため潜伏していた（「例が仕様を反証する」の実例）。

裁定: `Ty.relocR ρ` を新設し、call の結果型を `ret.relocR d` に差し替え。
relocR は shiftR と同じ一様シフトだが、最上段の imm コンテナ / 参照の上界だけ ρ に
締める（中身は shiftR のまま = セル型は relocate で動かない。opt / union の中身も
shiftR のまま — nil / inl / inr の型注釈は機械が書き換えないため。round4 積み残し
「opt / union 内コンテナの relocate」と同じ梯子に積む — R0 で回収、「region を持つ型の境界越えの段」）。mut / chan は retOk が禁じるので
call 結果には現れない（定義は shiftR と同じにして全域性だけ確保）。

- 核の補題 2 本、既存証明はほぼ無傷:
  - `Ty.relocR_shiftR_comp : (t.relocR ρ₁).shiftR ρ₂ = t.relocR (ρ₁ + ρ₂)` —
    シフト定理の call ケースがこれで閉じる（shiftR_comp の置き換え 1 行）
  - `value_reloc_tighten`（Soundness）: 深さ d + 1 の世界で shiftR d t0 に型付く値は
    relocR d t0 にも型付く — 深さ制約（loc / slicev / mapv の r < 判定深さ）が
    実 region ≤ d を既に保証しているのが証明の全て。canonical で割って rt を d に
    差し替えて組み立て直すだけ（prod は再帰、値ラッパは relocR = shiftR で恒等）
- relocate_ok は無傷（結論は shiftR のまま）— preservation の fretK ケースで
  tighten を 1 行挟む。StackTy は callK の継続と fretK の出口を relocR に
- 棄てた案: (a) relocate_ok の結論を relocR に強化 — opt の nil ケースで注釈型
  （機械が書き換えない）と衝突し、巨大証明の書き直しも発生。外付け補題が正。
  (b) relocR を深い変換（中身も ρ に）— セル型が Ψ の記録と一致しなくなり slicev の
  型付けが壊れる。浅い relocate には浅い relocR
- 変更ファイル: Syntax（relocR + comp 補題）、Typing / Checker（call の結果型）、
  MachineTy（callK / fretK）、Shift（1 行）、Soundness（tighten 新設 + fret 1 行）。
  機械（Machine.lean）と JSON 境界は変更ゼロ、脱糖器・codegen も変更ゼロ
- 副産物の修正: Gen.lean の genBase に map ケースが欠けていた（第三弾で Ty に map を
  足したときの置き去り — corevec.sh は古いバイナリで通っていた）。corevec は golden
  不変で 300 本一致 + --binary 照合 OK
- ベンチ: 121〜141ms/run とばらつき大（前回記録 82ms）。環境ノイズか relocR 起因かは
  未切り分け — 次に触るとき再計測

### string / slice の演算 3 点（2026-09-19 完了）— 随時回収の 1 本目、std/strings の下回り

裁定は language.md 21 節（比較 / 連結は `==` `!=` `+` の型分岐・[a:b] は imm 限定）。
コアに 3 op を証明ごと追加: `subslice e a b`（同セル列の新ヘッダ・割り当てゼロ・範囲violation
panic）、`eqs e1 e2`（int セル限定の長さ + 全セル等値 → bool。構造的等価の一般化は
Eq[T] 辞書の領分）、`concat e1 e2`（最内 region へ両セル列コピー — appendI と同じ床 b ≤ d）。

- 証明の要点: subslice / eqs はヒープ不変で軽い（subslice の per-cell は範囲サブセットの
  添字算術、eqs は eqCells が全域 Bool なので stuck しない — 等値の「意味」は証明対象外で
  Examples の rfl が突き合わせる）。concat は appendI の 2 段コピー版 —
  heapOk_append_copy(_cross) を 2 回適用し、同一 region ソースでは prefix の drop-take
  安定補題（drop_take_append_left、新設）で 1 段目の伸長を越えてセル条件を運ぶ
- 機械: K フレーム 7 種（subL/M/R・eqsL/R・catL/R）。eqs はセル列比較を 1 step で
  やる（findKey と同じ「型付き状態では形が保証される」パターン）
- Zig: grammar `index <- '[' expression (':' expression)? ']'`、AST に Slice3、
  脱糖は subslice 直行 + binary の string 型分岐（computeTy が string と分かるときだけ
  eqs / concat へ。`!=` は ite で反転）。codegen は slice3 = ヘッダ演算のみ、
  string == = バイト比較ループ、+ = 最内 region へ 2 連コピー
- 発見: computeTy に .slice3 / binary `+` の string 伝播が要る（無いと `t == u` が
  int cmp に脱糖されて Lean で落ちる — 型分岐は脱糖器の型追跡の精度に律速される）。
  mut [a:b] は codegen が Immutable で拒否 + Lean は subslice 規則が slice false 限定
- 突き合わせの対: examples/strings_ops.sober(.out) ↔ Examples ex28〜32（範囲違反 panic・
  mut 拒否 = typecheck none 込み）。corevec 300 一致 + --binary 照合、公理 propext/Quot.sound のみ

### bool のソース対応（2026-09-26 完了）— マイルストーン 1.5（std/strings の前提）

裁定は language.md 23 節。コア・証明・JSON・Gen は変更ゼロ — `Ty.bool` / `tt` / `ff`、
cmp / lt / eqs → bool、ite / while の条件 bool は形式化の初期から入っていた。
穴は Zig のソース層だけ（codegen が比較を int として型付けし、check と実行の受理が
割れていた — `func f() int { return a == b }` は実行が通り check で落ちていた）。

- Zig codegen: 型表に `bool_`（1 語、0 / 1 — int と同じ置き方だが型は交わらない）。
  比較・nil 判定・string 比較・`&&` `||` `!` の結果を bool、条件は `requireBool`。
  定数パターンは int / bool subject を受け、パターン型 = subject 型を検査。
  println の bool は `true` / `false`
- 脱糖器: `true` / `false` → tt / ff、型名 `bool`。bool の `==` / `!=` はコアの cmp
  （int × int）に無いので ite の形に落とす: `a == b` ⇒ `if a { b } else { !b }`、
  `!=` は腕を入れ替え（a → b の評価順を保つ）。bool subject の switch も同じ形。
  形の変換のみで「脱糖器の規律」の範囲内。棄てた案: コアに bool cmp を追加 —
  ite 形で表せるものに op を足すと証明の面積だけ増える
- 発見: パターン位置の `true` は裸識別子規則（syntax.md 9 節）で束縛として読まれていた
  （`switch b { case true: … }` が常に最初の腕に入る）。codegen / 脱糖器の両方で除外。
  同じ規則でトップレベル const（`case Local:`）も束縛になる穴は別タスクに積んだ
- 突き合わせの対: examples/bool.sober(.out) ↔ Examples ex33（bool 等値の ite 形）・
  ex34（`!` / `&&` の ite 脱糖）+ 否定例 5 本（bool + int・int 条件 if / while・
  `cmp eq tt ff`・bool / int の腕混在 = typecheck none）。
  corevec 300 一致（再生成なし）、公理 propext / Quot.sound のみ

### string の不透明化（2026-09-26 完了）— 表面の改訂、コアは無変更

裁定は language.md 24 節（21 節の演算 3 点を改訂）。コア・証明・JSON・Gen・Examples は
変更ゼロ — 不透明性はソース層の型の区別で、脱糖で消える。

- 型の区別: Zig codegen の `SliceInfo.str` / 脱糖器の `Ty.slice.str`。string リテラルと
  型名 `string` が印を持ち、freeze・戻り値座標（retTy）・computeTy で伝播する。
  JSON では印を消して `slice false r int` として出す（コアから見て改訂前と同一の項）
- `bytes(s)`: 脱糖は恒等（形の変換のみ — 脱糖器の規律の範囲内）、codegen はヘッダを
  そのまま渡して型だけ imm `[]int`（ゼロコスト。現ランタイムは 1 文字 = 1 語のセルで、
  ビューと表現が一致している — バイト詰めにしたら要再考）
- 拒否: string の len / 添字 / `[a:b]` / append は codegen（TypeMismatch）と
  脱糖器（Malformed）の両方で。`==` `!=` `+` / println の文字列扱いは str 印で判定
  （改訂前は「imm かつ要素 int」で判定しており `[]int{1} == []int{1}` が eqs として
  通っていた — この穴も同時に塞がった）
- 段割り: (1) 型の区別 → (2) `bytes` 導入 + examples 書き換え → (3) 表面から外す。
  拒否を先にすると既存 examples が壊れた期間ができるので、この順にした
- 突き合わせ: examples/bytes_view.sober（slice 引数の def にビューを渡す形 — round4 の
  座標規約 r0 に既存の lexer と同じ経路で乗る）が実行と check の両方に通る。
  lexer / parser_x / parser_y / slice / strings_ops は bytes ビュー経由に書き換え、
  `.out` は不変（parser の `--mem-trace` 数値を含む）。
  strings_ops は部分列同士の比較（ビューに `==` が無い）を string 全体同士の比較に
  置き換えた — Examples ex28〜32 はコア項の例なので無変更で有効

### 閉じた関数値の段（2026-09-26 完了）— V3 の 1 段目

裁定は D2（コアに閉じた関数値 + Def の型パラメータ）。捕捉クロージャ（D3）は入れない。

- 型 `Ty.fn p r`: p / r は Def の base 座標（region 0 = 呼び手空間、1 = 自フレーム）のまま
  持つ型スキーム。現在の世界の region に言及しないので loc-free・シフト不動（shiftR / relocR は
  恒等、regionsBelow / mutFree / chanFree / paramOk / retOk は true、sub は等値）
- 値 `fnref i`: Def 参照（環境なし）。`Δ[i]? = some dfn → fnref i : fn dfn.param dfn.ret`。
  shift / subst / relocate で不動
- callv: call と同形の規則（深さ d+1、`sub ta (p.shiftR d)`、`b ≤ d` → `r.relocR d`）。
  機械はフレーム callvL / callvR で ef → e の順に値にし、`callv (fnref i) v ⟶ call i v` の 1 歩で
  既存の call に委譲（世界の機構は新設しない）
- 証明: `canonical_fn` を新設。preservation / progress / shift_typing / relocate_ok / value_* /
  typecheck_sound・complete の各ケースは call の相似形か loc-free の自明ケースで閉じた
  （範囲裁定 = 閉じた関数値のみ の配当）
- JSON: `{"k":"fn","p":T,"r":T}` / `{"k":"fnref","f":Nat}` / `{"k":"callv","f":E,"e":E}`
- 突き合わせ: Examples ex35（直接呼び出し）・ex36（辞書 = 関数値の pair 鎖）・ex37（高階 Def）+
  否定例 6 本。Gen にベクタ共通の関数表（incr / isPos / apply）を足して corevec を再生成

### 型パラメータの段（2026-09-26 完了）— V3 の 2 段目

- `Ty.tvar i`（Def の型パラメータへの添字）、`Def.tparams`（既定 0）。
  `call fn ts e` / `fnref fn ts`（Expr が List Ty を持つのは nested inductive ではないので、
  「call は 1 引数」の永久設計と衝突しない）。規則は `ts.length = tparams` と `Ty.tyArgsOk ts`
- 型引数の制限 = loc-free かつ chan-free（`tyArgOk = regionsBelow 0 && chanFree`。当初案の
  loc-free だけでは `chan 0 t` が通ってしまうことに気づいて chanFree を足した）。
  型代入が region 座標に触れないので、shiftR / relocR と可換、regionsBelow / mutFree / chanFree /
  sub / paramOk / retOk を保存する
- インスタンス化 = 仮想 Def `dfn.inst ts`（param / ret / body に型代入）。call の規則・StackTy の
  callK・機械の callK はこの単相の Def を通る。Soundness の callK は DefsOk の代わりに
  `defsOk_inst` を使うだけで閉じた
- 型代入定理（TSubst.lean）`tsubst_typing`: Ξ = Ψ = [] の型付けは型代入で保たれる
  （shift_typing と同じ土俵 — 手本にして一発で通った）。入れ子の型適用は代入の合成（`tsubst_comp`）で
  閉じ、そのため DefsOk / checkDefs に param / ret の `tvarsBelow tparams` を追加した
- パラメトリシティ: tvar に対する消去形は無い。tvar 型の値は存在しない（relocate_ok の tvar ケースは空虚）
- JSON: `{"k":"tvar","i":Nat}`、call / fnref の `"ts":[T...]` と Def の `"tparams"` は省略可
  （単相の出力と互換）
- 突き合わせ: Examples ex38（単一定義を 2 型で呼ぶ）・ex39（入れ子の型適用）・ex40（辞書渡しを 2 型で）+
  否定例 6 本（個数違い・型不一致・region を持つ型引数・結果型の誤用・パラメトリシティ違反の本体・
  範囲外 tvar）。Gen に id[T] と型適用の生成を足して corevec を再生成

### ジェネリクスの Zig 側の段（2026-09-26 完了）— V3 の 3 段目

コア・証明・JSON スキーマは変更ゼロ（V3-1 / V3-2 で用意済みの語彙に Zig が乗る）。

- 3a 関数値の土台: エンコーダに `call r64`（FF /2。GNU as オラクルに 8 レジスタ分）。codegen の
  関数値は 1 語のコードアドレス（`fnv`）で、名前付き関数の参照はリンク時に絶対アドレスを埋める。
  フィールド / ローカルの関数値の呼び出しは、既存の呼び出し規約のまま `call rax`。
  脱糖器は関数名 → fnref、関数値の呼び出し → callv（引数は pair 鎖）
- 3b ジェネリクス: 脱糖器はジェネリック Def を1 本だけ出す（型環境 `T ↦ tvar i`）—
  Lean が tvar のまま一度だけ検査する。呼び出しの型引数は、プレースホルダ tvar を使った Ty 同士の
  構造的な単一化で推論する（region 添字は無視 — 型引数は region を持たない）。
  ジェネリック struct は使用点で型引数を束縛してフィールド列の prod 鎖へ。
  codegen はインスタンス化ごとの単相コピー（引数を先に評価して型を得る → 単一化 → `f[キー]` を
  登録し本体を遅延コンパイル）。ジェネリック struct もインスタンスごとにレイアウト
- 3c 辞書のラムダ: 関数値が期待される位置のラムダを匿名 Def（脱糖器 = 関数表の末尾、
  codegen = 匿名関数の遅延コンパイル）へ持ち上げる。外側の束縛を参照したら拒否。
  ジェネリック本体の中のラムダは型パラメータを引き継ぎ、fnref に同じ tvar を型引数として渡す
- 脱糖器の規律の自己点検: 型の具体化（ジェネリック struct → prod 鎖）とラムダの持ち上げは、
  どちらも入力データに依存しない固定の変換（形の変換）。ジェネリック本体を型ごとに複製する形は
  脱糖器に持たせず、codegen（特化 = 最適化の先取り）に置いた — 判定基準「テンプレートの多段化は
  コアへ」に沿って、検査はコアの型パラメータで一度だけ
- 発見: (1) 単相コピーの登録で funcs のハッシュマップがリハッシュされ、コンパイル中の FuncInfo へのポインタが
  無効化された。余裕を先に確保する形にした（上限 4096 は実装上の制限）
  (2) 脱糖器の診断文字列が arena の解放後に参照されていた。codegen と同じく固定バッファへコピーする形にした
  (3) 呼び出し結果（単値）の decl 追跡が無く、struct を返す呼び出しの `.field` が断片外だった。
  ジェネリックの束縛にも型引数の struct 宣言を運ばせて、`sort(ts, …)[0].kind` まで追えるようにした
- 突き合わせ: examples/fnvalue.sober（単相の辞書）・generic.sober（Pair[T] を 2 型で）・
  sort.sober（sort[T] + Ord[int] の閉じたラムダ 2 種 + Ord[Tok] の名前付き関数 +
  ジェネリック本体の中のラムダ）が実行と check の両方に通る

### 辞書 const の段（2026-09-26 完了）— A2

コア・証明・JSON は変更ゼロ（辞書 const は参照点の struct リテラルに消える）。
- loader: ConstDecl を int | 辞書に分ける。辞書は要素を検査する（int const 式・閉じたラムダ・単相非 inline の関数参照・
  他の辞書 const・入れ子の struct リテラル）。関数呼び出しは拒否する（language.md 25 節の線 ①）
- desugar / codegen: 参照点で宣言側の文脈（package・空の可視範囲・空の型環境）のまま展開する。
  辞書 const のラムダは AST ポインタで 1 本の匿名 Def に寄せる（参照が何箇所でも関数表は太らない）
- 脱糖器の規律の自己点検: 参照点での展開は、loader が確定させた式を文脈ごと差し込むだけで、入力に依存する生成は無い
  （int const の畳み込みと同じ「同じコードを共有する」側）
- 道中の回収: ジェネリック struct リテラルの declOfExpr が型引数の束縛を運んでいなかった。
  持ち上げたラムダの引数に struct 宣言が付いていなかった（関数型フィールドの宣言から付ける）
- 突き合わせ: examples/constdict・testdata/pkgdemo（package をまたぐ公開辞書 const）

### for-yield の段（2026-09-26 完了）— V3-4

コア・証明・JSON は変更ゼロ（for 式は inline 展開の中に消える）。
- 書き換え（src/stage1/forexpand.zig、desugar と codegen が同じ関数を呼ぶ）:
  `for x <- src if g yield e` → `(yield) => { iter#.Slice(src, (x) => { if g { yield(e) } }) }`。
  生成元が閉包（Iter 型の関数型引数）なら `src((x) => …)`。ブロック形の yield 文は束縛 yield の呼び出し
- 高階 inline の土台: ジェネリック × 関数型引数（型環境を差し替えて展開）、閉包の転送、関数型の引数を持つラムダ。
  閉包は定義時の型環境と inline 展開の列を凍結する（転送で定義より浅い位置から呼ばれるため）
- Iter[T] の推論: codegen は試し生成（yield を番兵の閉包に束縛して本体を 1 回生成し、yield の値の型を取り、
  コードとパッチ列を巻き戻す）、desugar は computeTy。両層とも生成元が閉包なら推論に寄与しない。一致テスト 12 ケースで固定
- 脱糖器の規律の自己点検: 書き換えは固定テンプレート 1 段（形の変換）。走査ループは std/iter.Slice（check の対象）。
  例外は inline ラムダの引数型照合（language.md 25 節の過渡措置）— 型検査を脱糖器に置く唯一の箇所で、ann で解消する
- 道中の回収: `|> pkg.F()` の修飾パイプ段、inline の値引数の elem_decl、codegen の pipe で for を左辺に置く形
- 突き合わせ: examples/lexer_iter（V1 lexer のトークン列を Count / Each / Sum で消費）

### 型 × region 座標の段（2026-09-27 完了）— V3-5

- 型注釈 ann（コア op、Lean 約 110 行）: `HasType e ta → Ty.sub ta t → HasType (ann e t) t`。整形条件なし
  （value_coerce が任意の sub 先で値を型付ける）。機械はフレーム annK、`ret v ⟶ ret (coerceTo t v)`。
  証明は各ケースが fst / call の相似形（shift = sub_shiftR、tsubst = sub_tsubst、preservation = value_coerce）。
  canonical の新設なし — call 同世界化で value_coerce を用意済みだった配当。JSON `{"k":"ann","e":E,"t":T}`、
  Examples ex41〜43 + 否定例 4 本、Gen に ann、corevec 再生成
- 点座標: desugar に region 深さ rdepth（main 1・Def 2・式位置ブロック +1）。本体の型式は最内 region で注釈
- 検査の返還: inline 展開で消える型（callee の値の仮引数・ラムダの引数・結果型）を ann で包む。
  desugar の照合を削除。1 フィールドの struct は core で素の型と同型なので、型違いの検査は構造で効く
- mut 引数: ref を letE で別名に渡し `ann (var) (ref true r T)`。Lean・JSON 変更ゼロ
- ゼロ値リテラル: フィールドごとのゼロの固定テンプレート（形の変換）
- 脱糖器の規律の自己点検: ann は注釈埋めのみ（ifnil の nil 注釈と同じ側）、ゼロ値は入力に依存しない固定テンプレート
- 突き合わせ: examples/nested・mutparam・zero・parser_b（--mem-trace 20 / 40 / 80 項 = 5056 / 9344 / 17920B）

### label / jump の段（2026-09-27 完了）— V4-1〜V4-3・V4-4d

エラー・診断経路（selfhost 検証 V4）の土台。脱出（return / break / continue / `?`）をコアの label / jump に一本化する
（裁定 B2）。`lake build` 緑、sorry なし、公理は propext / Quot.sound のみ。

- V4-1 下準備（cbbdf03、意味変更ゼロ）: HasType にラベル環境 Λ : Ctx（de Bruijn、先頭が最内ラベルの型）を
  index で追加し、StackTy も穴から見える Λ を運ぶ。全規則は素通しで、[] から始まるのは
  par / parch の子タスク・Def の本体（DefsOk）・fretK の穴・スタックの底（nil）— タスク境界・関数境界を越える脱出は無い。
  値の補題 value_ctx は Γ と Λ の両方を付け替えられる形に一般化（値は jump を含まない）。
  ヒープ（HeapOk.typed）とチャネル（ChanOk）の格納値は Λ = [] で型付け、格納する補題（heapOk_append1 等）は
  任意の Λ で受けて内部で value_ctx を掛ける。Checker の typecheck は Λ を持たない（label / jump が入る V4-2 で足す）。
  Δ スレッド（関数の段の下準備）との違い: Δ は固定パラメータだったが Λ は label が伸ばす index なので、
  `induction e generalizing … Γ Λ …` と StackTy の構成子の暗黙引数（rename_i / @ パターンに Λ が 1 つ増える）に波及した
- V4-2 label / jump（コア + 証明 + JSON + Gen）: `label t e`（本体を Λ' = t :: Λ で型付け、正常完了も t、
  `t.regionsBelow d`）/ `jump n t e : t`（`Λ[n]? = some tL`、e : tL）。jump の t は結果型の注釈（裁定 J1:
  検査器は構文主導の推論器で型の一意性・完全性を持つので、「任意の型」は nil t / inl r と同じく注釈で決める。
  棄てた案: ann で外付けし裸の jump を検査器が拒否（ann の意味に相乗り・src に形の例外）、検査器の双方向化（作り直し））。
  機械は labelK / jumpK フレーム + 補助関数 `unwind`（labelK を n 個越えた下を返す。途中の regionK は H.dropLast、
  fretK / 空スタックは none — 1 歩で終わるので step は関数のまま）。中核補題 `unwind_ok`: Ψ はスタックの型付けに固定し、
  ヒープを `Ψ.take d` で型付ける形で StackTy を帰納（regionK で heapOk_pop、到達した labelK が値を降ろす床
  `tL.regionsBelow d'` を与える、nil / fretK は穴の Λ = [] で矛盾 — V4-1 の [] 配置が効く）。結論のヒープを
  `H.take d'` と言うので step_shared_stable も同じ補題で閉じる。par_step_commute は無変更（K を変えない）。
  Shift / TSubst の言明は Λ にもシフト / 代入を掛ける形（jump の tL が動くため。呼び出しは Λ = [] で無影響）。
  JSON: `{"k":"label","t":T,"e":E}` / `{"k":"jump","n":N,"t":T,"e":E}`
- ビルド基盤: lakefile の lean_lib に `--tstack=131072`（非決定的な Stack overflow = Lean ワーカースレッドの
  ネイティブスタック不足。どのスレッドに重いエラボレーションが載るかで揺れる）。preservation は eval / ret 腕を
  独立補題（preservation_eval / preservation_ret）に分けた（IH を使わない腕。将来のケース追加で 1 定理が肥大しない）
- V4-3 脱糖: 関数本体（Def / main / inline 展開）は `label`、while は `label brk (while c (label cont body))`、
  return（関数本体の最上段の末尾以外）/ break / continue は `jump`。ラベルは脱糖中の id で作り、JSON 印字が
  de Bruijn 添字に直す — jump に使われないラベルは印字しないので、脱出の無いプログラムのコア AST は不変
  （棄てた案: 常にラベルを置く = 既存の全コア AST が変わる / 事前走査で要否を決める = inline とラムダの
  非局所 return で走査が脱糖の再実装になる）。ラベルの型: Def = 戻り値型、main = unit（本体の値は捨てる）、
  inline 展開 = 結果型の展開点座標（本体とペイロードを ann で揃える。結果無しは unit で値を捨てる）。
  ラムダ本体の return は定義時の関数ラベルへ（閉包が ret 先を凍結 — language.md 8 節の非局所 return）、
  持ち上げたラムダ（Def）の return は断片外のまま。break / continue はラムダ・inline 本体の床を越えない。
  defer は出口展開: 文列のブロック 1 つ = 1 スコープ（codegen の pushScope と同じ単位）、出口
  （ブロック末尾・jump）ごとに越えるスコープの defer を内側から・登録の逆順に、登録時の名前 / package /
  型環境で出口の深さに脱糖し直して差し込む（`let v = 値 in (d…; v)` → jump。codegen の runDefers と同じ
  テンプレート = 値確定 → defer → 脱出）。jump の注釈（裁定 J1 の t）: 位置の期待型 — 続きがある・値を
  捨てる位置は unit、値を使う末尾は Tail.want（関数本体 = ラベルの型、if / switch の腕 = 式の期待型か、
  無ければ他の腕の末尾の型: 式なら computeTy、値を持たない文なら unit）。決まらなければ断片外。
  突き合わせの対: examples/early_return_pure.sober（codegen の値）↔ Examples の v43（脱糖 JSON を機械で実行）
- V4-4d 腕の脱出（受理方向 split の解消、裁定 (a)）: 値位置の if / switch の腕に脱出（`x := if c { return 1 } else { 2 }`）を
  check は受理・codegen は拒否していた split を、codegen を追いつかせて閉じた。codegen の Type に `never`（到達しない）を足し、
  return / break / continue の文は never、腕の合流（if・switch の joinArm）は never と T → T、coerce は never を期待型として通す、
  束縛は never を値なしとして拒否。desugar 側も coerceArm（期待型つきの if の腕）で脱出で終わる腕を受ける（末尾の jump の注釈 =
  期待型。以前は "cannot decide whether to wrap in some"）。例: examples/exit_arms（build + check）

### error 値と ? の段（2026-09-27 完了）— V4-4a〜V4-4c・V4-4e

language.md 13 節（V4 スコープ = 値と伝播まで）の実装。コア・JSON・証明の変更ゼロ — error 値は既存の多値 + `T?` + union の
合成、`?` と包み替えは label / jump の段の部品で書ける固定テンプレート。Gen / corevec も無変更。

- V4-4a error 値（コア変更ゼロ）: `type L error { … }` はラベル宣言（ast.TypeDecl.body.error_）、`@errors(…)` は
  受理して読み捨て（強制は Phase 4）。loader.collectErrors が全 package のラベルをロード順 × 宣言順に並べ、組み込み
  `error` = その閉じた union（Program.errors、各 Variant.pkg が宣言側 = フィールド型の解決先）。desugar は unionTreeTy /
  encodeVariant / caseTree に n = 0（unit）/ 1（ペイロードそのもの・switch は let）の特例、findVariant がラベルを
  error の variant として返す。codegen は合成 UnionInfo（タグ = 列の添字、layoutUnion がラベルごとに cur_pkg を宣言側へ）。
  例: examples/errval（build + check）、testdata/errpkg（package 越えのラベル・修飾パターン）
- V4-4b 後置 `?`（コア変更ゼロ）: `f()?` = `let p = f() in (ifnil (last p) triv (jump k unit (zeros…, some err)); init p)`
  （裁定 S1: jump を文の位置 = ifnil の両腕 unit に置き、注釈は常に unit — 成功値の型を computeTy に頼らない。棄てた案 S2
  `ifnil (last p) (init p) (jump k T …)` は T の座標が computeTy の call 結果 region（呼び手座標に未変換）に律速される）。
  行き先は return と同じ（ret_target — 関数本体・inline 展開は自分、ラムダは定義時の関数 = 非局所）、越える defer は withDefers。
  成功値: 残り 0 成分 = unit（`(error?)` 単値の `?` は値として使えない — 確認 2 は規則を足さず型から従う）、1 成分 = その値、
  2 成分以上 = 多値のまま分解点へ（`a, b := f()?`）。拒否: 行き先の最後の結果が error? でない（main 含む）・呼び出しの最後の結果が
  error? でない・行き先の他の結果にゼロ値が無い（関数値 / union / tvar — 15 節）。
  ゼロ値はその場で組む（Z1 は撤去 — 2026-09-28）: `?` が jump のペイロードに積む他の結果のゼロ値（int / bool / nil / 空の imm slice・map、
  それらの struct）は `?` の位置で組む。深い位置の空の imm コンテナは最内 region に乗るが、jump の型規則 jumpRel（R4b）がペイロードを
  ラベルの最内 region k へ clampR で締めてから浅い共変で比べるので、ラベル型（戻り値の座標）に合う。締めの側条件 b ≤ k は Def 本体・main では
  b = 0 で常に立ち、b を上げる par / parch は Λ = [] なのでラベルを越える jump が無い。ゼロ値は戻り値型の値なので mut / chan を含まない（retOk）。
  棄てた案 Z1（V4-4b の当初の裁定）: region を持つゼロ値を関数本体の先頭（label の外 = 戻り値の座標）で let 束縛し、ペイロードはそれを参照する —
  jump がペイロードをラベル型へそのまま sub で比べていた当時の規則では必要だったが、R4b の clampR が吸収した。撤去の裏取り: 無効化したビルドで
  第 3 黄金 82 entry の判定が全一致・狙い撃ちの 3 構成（ループと分岐の奥・展開されるラムダの非局所 `?`・展開される mut 引数の関数の `?`）が
  有効・無効とも受理。撤去で第 3 黄金は Z1 束縛を使う 9 本だけが変わり、全部受理のまま。
  棄てた案 Z2（任意の region ≤ d に空 slice を作るコア op — 証明の変更）は Z1 の代案として棄てたまま。codegen は元から入口束縛を持たない
  （その場で空ヘッダを作る）。FuncDecl.has_try は脱糖器の読み手を失い、loader 黄金の欄としてだけ残る。型追跡: `x := f()?` の computeTy / declOfExpr / elemDeclOfExpr は try_skip（次の call の結果を最後の error? を
  落とした 1 個として読む）、多値分解の束縛は region を持たない結果型だけ Binding.ty に載せる（T? の sink の some 包み判定用）。
  codegen の tryResults: 結果をフレームのスロットへ移し、最後の error? のタグが非 0 なら結果スロットへゼロ値 + err →
  ret の後半（runDefers → epilogue / inline の end_jumps）。突き合わせの対: examples/try_prop_pure ↔ Examples の v44
- V4-4c 包み替え: `f()? L{…}` は S1 の jump ペイロードの err 成分を `some (L{…})` に替えるだけ（K3: 内側の err は捨てる —
  cause は期限つき未決）。L のフィールドは some 腕 = エラーの経路でだけ評価される（map_err と同じ遅延。codegen も判定後に評価）。
  L は error ラベルに限る（struct / union の variant は Malformed）。grammar は既存のまま: `?` は endsStatement なので改行後の
  リテラルは別の文、条件位置は c_try（包み替えを読まない — 括弧で書く）。突き合わせの対: examples/try_wrap_pure ↔ Examples の v45
- V4-4e 検証例 errparse（V4 完了）: examples/errparse はミニ lexer（`lex(text string) ([]Token, error?)` — ループ内の `?`・
  slice 結果成分のゼロ値の入口束縛）+ 再帰下降 parser（`(int, int, error?)` の相互再帰の中の `?`・多値の分解）+ トップの
  包み替え（`run(a)? BadInput{which: 1}`）+ バイトオフセット → line:col の解決（Sober で bytes を走査）。位置は 1 語で運び
  表示時に解決する（R5 と同じ設計を例の中で踏む）。道中の回収: switch パターンで束縛したフィールドに型（Binding.ty）が
  載らず補間が CoreFragment になっていた（union 共通の既存の穴）— 多値分解と同じく region を持たない型だけ載せる。
  突き合わせの対: examples/errparse_pure（9 入力の結果を 1 語に畳み込む）↔ Examples の v46
- ラベルのフィールドは loc-free に限る（io-1）: string フィールドのラベルが宣言されているだけで、int フィールドの
  ラベルしか返さない関数も build が "slice inside an optional / union result" で止まった（error の閉じた union に slice が入り、
  codegen の relocateValue が opt / union の中を歩けない）。規則は loader.collectErrors の locFreeTE（名前は宣言まで辿る・
  型パラメータは通す）。解除は language.md 13 節の暫定制約の条件どおり

### io の段（2026-09-27 完了）— 随時回収の io シム（io-0〜io-5）

language.md 27 節（アリーナの溢れ・string(b)）と 28 節（io）の実装。コア・証明の変更ゼロ。
- io-0 アリーナの上限検査: bump の前進 5 経路（relocate / slice リテラル / concat / map set / append）を共通の emitBumpStore
  （スロット末尾 = SLOTS + (bump アドレス − META) × (SLOT_SIZE / 8) を符号なし比較）に寄せ、region enter の深度・起動時の
  mmap の戻り値も検査する（exit 102）。スロット 64MB × 1024 = 64GB の NORESERVE 予約は WSL2（overcommit 0）で実測して採用。
  → スロットは実行時可変に（2026-09-28）: 大きさは meta の SLOT_SIZE（旧定数 SLOT_SIZE を置き換え）、既定 4GiB × 1024 = 4TiB、
  `SOBER_REGION_MB` で上書き、予約の失敗は半減して 1MiB まで再試行（language.md 27 節）。overcommit 2 では NORESERVE が無視されて予約が全額
  CommitLimit に計上される — 旧 64GiB 固定はこの機械（CommitLimit 約 50GB）で全プログラムが起動時に exit 102 になる読み（sysctl を変えられず、
  ulimit -v の模擬で半減の経路を確かめた）
- io-2 `string(b)` の道中の回収: ①仮引数の imm slice / map をそのまま返す転送 return（round4 からの断片外 — 仮引数は r0、
  戻り値の最上段は r1、checkDefs は厳密一致）を結果型で ann して通す（Ty.sub の imm 上界の緩め）。条件は「返す式が名前で、
  束縛の型が region だけ結果型より緩められる」とき — 式一般の computeTy は region が実体とずれる経路（リテラルを r0 と読む）が
  あるので名前に限る（v43〜v46 のコア JSON は不変）。②多値分解 `s, err := f()` の束縛型に、結果の最上段の imm slice / map
  （要素は region を持たない）を呼び手の最内 region で載せる（call 結果型 ret.relocR d と同じ上界）。
  突き合わせ: examples/utf8_pure ↔ Examples v47、Go オラクル examples/utf8_std（scripts/utf8_oracle.ts）
- io-3 check 側の姿勢（裁定 C1）: sys* builtin は型どおりの固定の代役に脱糖する — sysReadFile(p) = `let p in freeze(mkslice int)`、
  sysWriteFile(p, b) / sysErrno() = 0。脱糖器の規律（固定テンプレート）の内側で、println → unit と同じく外界を型だけで扱う。
  代償は Lean の突き合わせが io の中身を観測できないこと — io は codegen の実行テストで検証する
- io-4 println: 評価 → 出力の順（全引数をスロットへ）と行バッファ。Lean は出力をモデル化しないので突き合わせ外
- 検証例: examples/io_basic（読み・書き戻し 10000 バイト・NotFound / Denied / EISDIR・不正 UTF-8・空ファイル）、
  examples/errparse_file（ファイル → 行 → lexer / parser → path:line:col、トップは行番号への包み替え）

### V5 足場の段（2026-09-27 完了）— selfhost 検証 V5（V5-1〜V5-5・V5-7）

コア・証明の変更は V5-6（次節）だけ。ここはオラクルと足場の記録。
- V5-1 固定点オラクルの足場: stage の番号づけ = stage0 Zig ツールチェーン・stage1 Zig 製 sober（信頼の根・恒久維持）・
  stage2 Sober 製コンパイラを stage1 で build・stage3 同じソースを stage2 で build。固定点 = stage2 ≡ stage3（バイト一致・正規バックエンド）、
  LLVM 経路は観測等価のみ、stage1(X) ≡ stage2(X) は要求しない。器は scripts/stages.sh（骨格 C3 — 実装 2026-09-28、selfhost の R35: 暫定形の固定点
  stage3.ll ≡ stage4.ll が成立、gate `stages` に常備。実測と形は design-dev.md 最終オラクル項）
  - hermeticity は固定点の前提（scripts/hermetic.sh — C1、gate 常備）: 出力 = f(ソース, コンパイラ)。2 回・別 path のコピー・絶対 path・
    env -i / TZ / LANG / umask / SOURCE_DATE_EPOCH を変えて ELF とコア JSON をバイト比較。stage1 の出力は着手時点で満たしていた（退行の門番）。
    対象外: stage1 バイナリ自身（Zig のデバッグ情報が絶対 path を持つ）
  - 観測 = (stdout, exit code)（scripts/obs.sh — C2、backend を引数に取る差分オラクルの器）。examples の規約に `<name>.exit`（無ければ 0）、
    複数 package の例は `<dir>.out` / `<dir>.exit`。panic 101 / 102 も観測値 — UB 遮断規約（明示チェックを吐く）の検証面は exit code
  - 発見（V5-1a で回収）: ゼロ除算が SIGFPE（exit 136）だった — Lean は panic、codegen は idiv 直行。旧 gate は exit code を捨てていて
    見えなかった（観測できない値は検証されていない）。最小値 / -1 は Go 準拠（商 = 被除数・余り 0）
- V5-2 / V5-3 std/pool と analyzer 1 本目（language.md 30 節）: Pool は Sober で書いた std でコア op を増やしていない。analyzer は
  Zig の AST 1 パスで証明の対象を持たない — 答え合わせは T1（Pool の未返却カウンタ）と変異（scripts/pool_oracle.sh）
- V5-5 interface 視点のローダと一致検証（language.md 29 節）: 比較専用の記号名正規化出力 `--core-json-pkg`。Lean に渡すコア JSON は不変
- V5-7 検証例 minic（testdata/minic/{app,lex,parse,diag,emit}）: io → utf8 → 字句（Builder）→ 演算子順位法の木（[]Node + 添字・後置順）→
  スタック VM → 値か path:line:col（ゼロ除算は VM の実行時ラベル）。行ごとの作業記録を Pool から借りて直後に defer で返す。
  3 条件（analyzer 受理・変異拒否・未返却 0 / 全 package の `.sobi` 視点一致 + 部分検査 / hermetic + obs）を満たす。
  道中の回収（脱糖器を codegen に揃えた split 3 件）: flow typing 後の `.field`（`T?` の型宣言 → ペイロードの宣言。ジェネリック呼び出し結果
  `pool.Get` を含む）・struct の slice フィールドの要素宣言・型パターン switch の `case _:` = default。文位置の if は次の「脱糖器の規律」に一行。
  発見: mut 引数の関数は展開されるので再帰に持ち込めない（language.md 未決「region 多相の裁定」の B3 に束ねた）
  → R2（anchor つき呼び出し）で回収 — 「region を持つ型の境界越えの段」

### package 単位の検査の段（2026-09-27 完了）— V5-6（I-3）

分割コンパイル（language.md 29 節）の検査を、package ごとの部分検査の合成として証明する。lean/FeatherweightSober/Split.lean、
sorry なし・公理 propext / Quot.sound のみ。
- `hasType_sigEq`: 型付けは関数表の署名（param / ret / tparams）しか見ない（HasType が Δ を読むのは call / fnref の `Δ[fn]?` だけ）
- `hasType_rename`: 関数 index の付け替え ρ（`Expr.renameFn` — call / fnref の添字だけを写す構造写像）で型付けが移る
  （署名が保たれる限り — `SigMap`）。sigEq の一般化
- `checkDefsAt Δ S`: S の立つ添字の Def だけを checkDefs と同じ条件で検査する部分検査（他は署名だけの枠）
- `defsOk_of_parts`（添字の揃った分割）/ `defsOk_of_linked`: 各視点の部分検査の受理（hchk）+ 署名の写像（hmap）+
  被覆（hcover — 全体の各 Def = ある視点の検査済み Def の本体を ρ で付け替えたもの）⇒ 全体の DefsOk
- 発見（割れたところ）: 最初の形 defsOk_of_parts は実装に当たらなかった — 視点の表は全体の表より短い（`.sobi` が非公開の非展開関数を
  落とし、他 package の持ち上げも無い）ので添字が揃わない。リンカの再配置 ρ を仮定に入れた形が要る（リンカの仕事を定理の仮定として名指しした形）。
  記号名（29 節）が ρ そのもの
- JSON: 部分検査の封筒 `{"parts":true,"defs":[…],"e":E?}`。body の無い Def = 署名だけ（triv を置き検査しない）。e は main の視点だけ。
  従来の封筒・parseProgram・Examples の vNN スナップショットは無変更
- Zig: `sober check E --pkg P [--iface DIR]`（部分検査）/ `--pkg P --core-json`（名前付き関数の署名表）

| 定理の仮定 | 見ている検査（gate 常備） |
|---|---|
| hchk | scripts/pkgcheck.sh 1（sober-check が部分検査を受理） |
| hmap | pkgcheck 2（視点の名前付き関数の署名 ⊆ 全体）+ sobi.sh の G-d（Sober 版 — 今の例の全 package の視点の署名表 ⊆ 全体の表・改竄 mutant）。stage1 の iface.sh（P の持ち上げの署名の正規化比較）は 3'' M5 で退役 — 凍結コーパスの照合は sobi.sh の G-c が後継 |
| hcover | sobi.sh の G-c（凍結コーパスで stage1 と判定一致）+ checksplit（G-e — 小分けの判定 ≡ 一括の判定・全 entry）。記号名正規化のバイト一致（旧 iface.sh）は M5 で退役 |
| 仮定の外 | ρ の単射性・全 Def がどれかの package に帰属すること — スクリプトの名前の一致で見ているだけ。リンカ（backend I-4）の実装時の検査項目 |

- 自己検査: 署名を偽った `.sobi` は部分検査を通ってしまうが署名表の包含で必ず落ちる — 部分検査の受理だけでは合成は成り立たず、
  hmap は別に検査する必要がある

### region を持つ型の境界越えの段（2026-09-27 完了）— region 多相の裁定 R0〜R5

language.md 31 節の裁定の形式化。全段で `lake build` 全緑・sorry なし・主要定理の公理は propext / Quot.sound のみ。


- R0 値ラッパ越しの境界コピー: relocR が opt / union の中の最上段コンテナも呼び手最内へ締める（旧: 中身は shiftR のまま —
  nil / inl / inr の注釈を relocate が書き換えないため）。fretK が結果型 t を持ち、境界コピーが注釈も t に書き換える（codegen では恒等）。
  round4 の積み「opt / union 内コンテナの relocate」を回収
- R2 anchor つき呼び出し（裁定 K-a）: region 0 は暗黙の region 変数で、call は常に呼び手最内 d で instantiate していた。
  新しい構成子 `callM` は anchor a（仮引数型の mut 位置に対応する実引数の region — `Ty.anchorOf`、構文主導のまま）で
  写像 `rmap a d`（0 ↦ a、k+1 ↦ k+1+d）を掛ける。規則: `sub ta (param.renR a d)`・`b ≤ a ≤ d`・結果 `relocA a d`。
  DefsOk の base は b = 0（region 0 = mut 引数へ書ける）・本体は src。証明の要: 写像定理 ren_typing（シフト定理の一般化 —
  狭義単調性だけで運ぶ。ρ0 = d で一様シフトに一致 = 保存拡大 rmap_top / renR_top / renTy_top — (a) を再訪するときの退路）、
  anchorV_eq（実行時の anchor = 型の anchor — mut は正確 region）。既存の call は anchor = d の特殊形として据え置き。
  機械は callMK フレーム、JSON `{"k":"callm"}`。棄てた案: call に anchor を足す（既存の call の証明を動かす）、
  Expr に anchor の欄を足す（型から読めるので要らない）
- R4a 深い relocate: 境界コピーを型主導にし、写すコンテナのセルの中身も再帰で写してから（入れ子のコンテナも呼び手最内へ）、
  セル列を呼び手最内の末尾へ連続に積む。retOk は中身へ再帰（どの深さでも r < 2、mut / chan 不可）、relocR / relocA は深い締め。
  戻り値の中身の座標は r1（自フレーム）に統一。round4 以来の積み「戻り値の深い持ち帰り」を回収
- R4b α 脱出の境界コピー: ラベル環境は (型, ラベルの最内 region k) の組（label は深さ d で (t, d - 1) を積む）。jump の規則は
  `Ty.jumpRel b k tJ tL` = ペイロード型を k へ締めて（`clampR` — imm の region を min r k、中身へ再帰）から浅い共変で緩める。
  締めが要る（noClamp でない）なら b ≤ k（写し先へ書ける）かつ chan を持たない（chanV のスナップショット等式が region k の伸長で壊れる）。
  機械は `relocTo k`（写す元 = k より深い全 region、写し先 = k）、unwind がラベルの型を返し、jumpK は写してからラベルの深さへ切り詰める。
  証明: relocTo_ok（値の型 T と歩く型 W = ラベルの型を分け、`sub (clampR k T) W` で帰納 — 葉は締めで不変、imm コンテナは k < r なら
  写す・でなければ中身の床から締めが恒等）+ jumpK_step（preservation / progress / 共有プレフィクス安定性が同じ束）。
  shift_typing は ren_typing の anchor = d の系に置換。棄てた案 β（呼び出しの結果の置き先を脱糖器が選ぶ — 座標の自由度が増える）
- R4b-cov imm セルの深い共変: `Ty.sub` を imm slice / map のセル型へ再帰させる（mut と ref は正確一致のまま）。slicev / mapv のセル型は
  要素型の部分型（mut は正確）。静的な要素型の床 `t.regionsBelow (r + 1)` は mut だけに残し（mut append が region r に書く）、
  imm append の規則が新しいセルの床 `t.regionsBelow (d + 1)` を持つ。読み出しは型注釈で閉じる（A-2）: `index e i ot`（注釈は省略可 —
  省略は要素型が annFree = opt / union / 型変数を含まないか mut に限る。JSON の `"t"` は任意）と getm の既存注釈で、読んだ値を coerceTo で
  書き換える — 値の型付けは注釈に正確なまま動かさない（ann と同じ注釈書き換え）。棄てた案 A-1（値の型付けを注釈に寛容にする —
  型付けの一意性と checker の完全性の言明が崩れる）。fretK の境界コピーは relocTo（k = 呼び手最内）の特殊形に統合し
  （relocA = clampR ∘ renR — retOk の下で region は 0 か 1 だけ）、R4a の relocT_ok は relocTo_ok の系 relocRet_ok に置き換わった。
  証明の要: sub_trans・clampR_mono・sub_chanFree、read_ok（annFree の型への coerceTo は恒等 — Expr.coerceTo_annFree）、
  relocTo_ok の帰納はセルごとに型を量化（RelocIH — 深い共変でセルごとに型が違う）、copy 補題はセルごとの型をそのまま写す
- R4b K1''（脱糖器のみ）: error = `prod L []L`（L = 全ラベルの閉じた union、鎖は imm slice・外側が末尾）。包み替えは内側の先頭を
  鎖の末尾へ積む（imm append）、`case L{..., cause}` の cause は `ite (len chain == 0) nil (some (index chain (len - 1), chain[0:len-1]))`
  （鎖の読み出しは L の注釈つき index）。コア・証明は変更なし — 形の変換だけ（脱糖器の規律）
- R5 普通の出口の対称化: 新しい構成子 `blockR t e`（出口で写すブロック）と機械フレーム `regionKR t`。型付けは jump と同じ jumpRel
  （本体の型を親の最内 d - 1 へ締めて浅い共変で緩める）+ 結果型の床 `t.regionsBelow d`。機械は出口で relocTo（親の最内）してから pop。
  証明は regionKR_step（jumpK_step と同型 — 巻き戻しの代わりに 1 段だけ降りる）。既存の block（写さない）は据え置き — blockR は保存拡大。
  JSON は block に任意の `"t"`。脱糖器は末尾値の型がブロックの region を指すときだけ blockR を出す
- 突き合わせ（Examples.lean）: exR0a〜c・v48（R0）、r2Δ（R2 — anchor < 呼び手最内の再帰・call では拒否・par へ mut 不可）、
  r4Δ / exR4a（R4a — 入れ子の slice を 2 段の呼び出し越しに返す）、exR4b（α — 式ブロックの入れ子の slice を外のラベルへ jump で持ち出す）、
  covΔ / exCov（cov — 入れ子の imm slice の仮引数の転送・注釈つき読み出し）、exR5（R5）。Gen は Def 4〜7 と callM を生成
  （golden 300 本に callM の受理ベクタは出ない）
- 実行系（lower）は backend レーンが同じ規則で実装する: R2（mut_def のアドレス渡し）・R4a（深い relocate、B-10）・α（inline の脱出）は
  実装済み、K1''（error の鎖と cause）と R5（ブロックの出口の写し）は中継済み

### byte の段 — 段 A（2026-10-01 完了。裁定は language.md 33 節、実装順は同節の段 A → B → C）

段 A（スカラー）の Lean。段 B（`[]byte` の詰め）と段 C（string の切り替え）は lower の表現の変更で、コアの項・証明は段 A だけ
（詰めはセル = 値の意味論のまま観測不能 — 健全性の前提「byte のセルの値は 0〜255」は段 A の型付けが保つ = `canonical_byte`）。

- `Ty.byte`: 区域系の述語（regionsBelow / mutFree / chanFree / シフト / TSubst / renR）・sub・retOk は int と同じ扱いの腕（bool の腕の複製 — 14 ファイル）
- 項は 3 つ: `tobyte e`（int → byte。範囲外は panic）/ `toint e`（byte → int）/ `blit n`（byte の値 — 実行時にのみ現れる項。`Expr.src = false`・JSON の語彙に無い）。
  型付け `blit n : byte` は 0 ≤ n < 256 のときだけ。`canonical_byte`: byte の値は範囲内の blit
- 裁定 B7 からの訂正（実装で判明）: 草案 B7 は「値は既存の `lit n` を byte にも型付ける」だったが、それだとソース項の `lit n` が int と byte の 2 つの型を持ち、
  検査器の一意性（hasType_unique）と完全性（typecheck_complete — ソース項の導出があれば typecheck が同じ型を返す）が崩れる。
  そこで byte の値は実行時専用の `blit n`（loc / slicev と同じ非ソース項）にし、ソースの byte は常に `tobyte` で作る。表面の意味論は同じ
  （`byte(n)` の範囲検査・値の範囲の保証）。B7 の「評価器は無変更」も成り立たない — どちらの形でも tobyte / toint の継続（tobyteK / tointK）は要る
- 比較はコアに足さない: byte の `==` `<` 等は脱糖器が `cmp op (toint a) (toint b)` に写す（形の変換のみ — bool の `==` を ite 形にしたのと同じ理由:
  表せるものに op を足すと証明の面積だけ増える）。コアの cmp / lt は int × int のまま
- Machine: 継続 `tobyteK`（`ret (lit n)` → 範囲内なら `ret (blit n)`、外なら panic）/ `tointK`（`ret (blit n)` → `ret (lit n)`）。
  ret の腕は match の末尾（`.ret _ _ _` の前）に置く — 値で場合分けする腕を前に置くと後ろの腕の等式の生成（補集合の条件）が重くなる
- Lean の罠（新）: Expr のコンストラクタを 3 つ足しただけで、Soundness の `simp only [step]`（step の等式の生成）が既定の heartbeats（200000）を超えた。
  `set_option maxHeartbeats … in` を定理にも step の定義にも付けても効かない（等式は別の文脈で作られる）→ lakefile の `-DmaxHeartbeats=1000000`（全体）で通した。
  lake build は約 3 分（Soundness が主）
- Checker / Json: typecheck に tobyte / toint（blit は none — ソース項でない）、JSON に型 `{"k":"byte"}` と op `tobyte` / `toint`
- Gen は追いつかせない: genBase に網羅のためだけの腕（乱数を引かない — genTy は byte を作らない）。corevec 300 本は一致のまま
- 突き合わせ: Examples の exByte1〜5（比較・境界値 255・範囲外 256 / −1 の panic・`[]byte` の要素の読み）+ 実行時の値の型付け（blit 255 は付く・256 は付かない）+
  否定例 6 本（byte の算術・byte の cmp 直・tobyte の入れ子・toint (lit)・byte の条件・blit はソース項でない）+ JSON の往復。
  公理 propext / Quot.sound のみ（soundness・preservation・progress・step_shared_stable・typecheck_sound / complete）、sorry なし。規模 +336 行

## 借りるもの

| 前例 | 借りる点 | 借りない点 |
|---|---|---|
| Tofte–Talpin の region calculus（`letregion ρ in e`） | region を型に持つ参照 `Ref ρ T`、region の LIFO 解放、型付け規則で escape を禁じる形 | region 推論（Sober は構文 = ブロックで region が決まるので推論不要）、effect による region 多相 |
| Cyclone | region 変数のスコープ規則、「外側の region への参照は内側から持てる、逆は不可」の型付け | 動的 region、unique pointer |
| Verona（region ownership） | region を並行性の単位にする発想、region 間で共有できるのは immutable のみ | 任意所有グラフ、region の動的な受け渡し |
| RustBelt / Oxide | 「借用の任意グラフだと何が難しいか」の反面教師 | ほぼ全部 |
| Featherweight Java / Go の形式化（Featherweight Go） | 最小体系の切り方、progress / preservation の証明構成 | — |

## 進め方

1. 体系の定義（構文・型付け・意味論）を Lean 4 で書く。最初は定理 3 だけ（region なし）で進め、preservation が通ったら region を足して定理 1、最後に parallel を足して定理 2
2. 各段で「定義が Sober の docs/language.md / region-domain-pool.md と食い違ったら docs 側を直すか体系を直すか」を裁定として記録する。体系と紙の仕様の差を放置しない
3. 証明が壊れる設計変更は、壊れた補題を docs の当該節に一行で書く（「この規則は定理 1 の補題 X が依存」）
4. 型検査器そのものを Lean で書き、Phase 2 の本番にする（下記「実装との照合」）。証明済みの型付け規則と型検査器のコードを同じ定義から出す

## 脱糖器の規律 — 形の変換だけを許し、意味の実装を禁じる（裁定 2026-09-19）

第三弾の入口で map を「slice + 探索ループへの脱糖」で済ませる案が出て棄却された。
表現は可能だが、check される線形探索プログラムと codegen のハッシュテーブルが構造的に
別物になり、観測同値の義務が op 単位からプログラム単位へ太る — しかも未検証のまま
脱糖器に溜まる。以後この線を規律として固定する。判定テストは 2 つ:

1. ソースに無いデータ依存の制御フローを合成しない。switch → eq + ite 連鎖は
   ソースが書いた分岐の変形で可。string リテラル → append 連鎖はリテラル長で有界な
   展開で可。map の get → 探索 while ループはソースに無いループの発明で不可
2. codegen との一致が構成的に出るものだけ。同じ評価順の局所テンプレートを両者が
   独立に踏む（switch・inline 展開）か、同じコードを共有する（loader の const 畳み込み）か。
   「別アルゴリズムだが観測同値」の主張が要るなら、それは脱糖でなくコア op
   （証明で担保）か std（Sober で書いて check に掛ける）の仕事

判定基準（追記 2026-09-26、ユーザーの注意喚起による）: 1 ノードが入力データに
依存しない固定テンプレートのコア項に写るなら形の変換（`&&` / `||` / `!`・bool `==` の
ite 化はこちら）、入力に応じてループ・走査・状態を生成するなら意味の実装（map の
slice + ループ脱糖の棄却はこちら）。テンプレートが 2 段以上ネストし始めたら、脱糖に
足すのでなくコアに op を証明ごと足す側に倒す。迷ったら実装せず裁定に上げる。

点検項目（追記 2026-10-02 — 3' の脱糖テンプレート監査より）: 上の「形の変換か」の判定に加えて、ann・期待型を伴うテンプレートは、
対になる経路を全部洗う — 初期化 / 代入・if / switch / ifnil・通常 / byte 文脈。監査（2026-10-02）で「意味が混ざる」テンプレートは 0 件だったが、
check ⊂ build の穴 6 つ（F-f / F-l / F-m / F-n / F-o / F-p）は全部「緩める道具（ann・computeTy の型の読み）が一部の経路にだけ配線されていて、
対になる経路に無い」適用漏れだった（例: F-g の if の腕の合流が switch・ifnil に無い・mut の初期化の ann が代入に無い・computeTy の if が switch に無い）。
ann・型の読みを 1 つの経路に足すときは、同じ表に並ぶ経路を同じ変更で揃えるか、揃えない理由を書く

- 文字列補間 `${}`（2026-09-27、随時回収 R7）: 固定テンプレート — テンプレート正規形（定数部 n+1 + 穴 n）を
  左から `+` の連鎖に畳み、穴は型で包む（string はそのまま、int は `strings.Itoa(e)`（2026-10-01 に std 命名規則で `strings.FormatInt` へ改名）、bool は
  `if e { "true" } else { "false" }`、他は拒否）。型判定だけが各層の持ち物で、組み立ては src/stage1/interp.zig 1 箇所
  （desugar は computeTy + struct 判定、codegen は穴を合成名のローカルへ束縛して型を得てから同じ関数を呼ぶ —
  Itoa は純粋なので変換の位置の違いは観測されない）。コア・証明・JSON は変更ゼロ。
  int → string は builtin でなく std/strings の Itoa を Sober で書いた（digit の switch + 連結、最小値は綴りで返す）—
  判定テスト 2 の「std（Sober で書いて check に掛ける）」側。補間を含むファイルには cst_to_ast が予約参照名
  `$strings` で std/strings を暗黙 import する（for 式の std/iter と同じ機構）。棄てた案: int→string の builtin
  （コアと Lean に op が増える。std で書ける）、利用者に `import "std/strings"` を要求（書いていない名前に依存する）。
  突き合わせ: examples/interp.sober(.out)（入れ子・エスケープ・最小値 / 最大値・評価順）、src/stage1/interp.test.zig

- 文位置の if の腕（2026-09-27、V5-7）: 値を捨てる if 文（`.expr` 文・else if の鎖・ifnil を含む）は腕を discard で脱糖する —
  腕の末尾の値を `let _ = v in triv` に包む固定テンプレートで、codegen（文位置の値は捨てる）と揃える。既存 3 例のコア JSON が
  let 1 段ぶん変わった（受理は不変）。捨ててよいのは呼び出しの結果だけ（裁定 C 2026-09-27 — 純粋な式の式文は loader の
  src/stage1/exprstmt.zig が脱糖の前に拒否するので、腕の末尾に届くのは呼び出しか入れ子の文位置の if / switch / ブロックだけ）

但し書き: 値表現の同値は Lean 世界で論証済みなら可（string リテラルの
「rodata = mut 構築 + freeze と観測同値」— 制御フローなしの値構築に限る）。
アルゴリズムの同値は不可。

帰結の線引き: 組み込みコンテナ（slice / map）= コア op、それ以外のデータ構造
（HashMap 等）= std（Sober 製、check 対象）。既存脱糖の監査（2026-09-19）は全項目
規律内 — pair/prod 鎖は型レベル符号化（評価順保存）、ifnil は注釈埋めのみ、
mut → ref は局所テンプレート。ann（V3-5）は注釈埋めのみで、注釈の誤りは Lean の誤拒否にしかならない。

### 脱糖器の座標精度の段（2026-09-27〜28 回収 — selfhost の実地、F-11 / F-14 / F-24 / F-25 / F-34）

selfhost（compiler/ を Sober で書く）で、手で書けば通る形が脱糖器の座標の読み違いで def error になる例が続いた。
どれも言語の裁定ではなく脱糖器の精度の不具合として直した（正式承認 2026-09-28）。Lean・コアの op は無変更 — 足したのは ann（注釈埋め）と
型追跡の精度だけで、ann は Ty.sub の範囲なので誤りは Lean の誤拒否にしかならない（上の但し書きの内側）。共通の規律:
緩めるのは行き先の型が確定している所だけ、緩める向きだけ、型が一致・不明・形違いなら付けない。

- 展開の値引数の正確な型（F-11 — Binding.core_ty）: 展開（inline / ラムダ）の値引数は展開点の点座標で ann される（V3-5 ③）ので、
  Def 本体では仮引数の imm slice（署名の r0）が `[r1]` に緩み、展開先から anchor つきの mut Def（R2）へ渡すと 31 節の anchor 1 slot の制約で落ちた。
  実引数が名前で、束縛がコア上の正確な型（新設の core_ty — Def の値仮引数 = 署名の型、展開の値引数 = ann した型）を持ち、それが点座標より
  締まっているときだけその型で ann する。棄てた案: Binding.ty で締める（入れ子の展開で ty が callee の base 座標のまま残り、逆に締めすぎた）・
  展開の値引数の ann をやめる（V3-5 ③ を崩す）。回帰例 examples/inline_anchor
- 名前でない式の return（F-14 (1) — retValue / retExprTy）: 式の型（computeTy。if 式は両腕が単一式で型が一致すればその型）が結果型より
  締まっているときだけ結果型へ ann。Def の本体の return に限る — 展開の中の return に付けると、strings.Keep の結果（Arena の region — 浅い）を
  展開点の座標へ緩めて、その先のブロック脱出が要る精度を失った（pool_string）。回帰例 examples/param_slice_ann（(1)(2) 共通）
- append の値（F-14 (2) — appendValueAnn）: subject が名前の mut 束縛の mut slice で、値の型が要素型（束縛点の点座標 — mut 束縛のセル型の不変条件）
  より締まっているときだけ要素型へ ann。回帰例 examples/param_slice_ann（(1)(2) 共通の回帰例）
- mut struct のフィールド代入の値（F-14 (3) — fieldValueAnn）: `s.a = p`・入れ子 `o.box.a = p` の値に、フィールドの宣言型を束縛点の点座標へ
  写した型への ann（(2) と同じ規律）。同時代入には付けていない。回帰例 examples/field_param_ann
- 戻り値の map のキーの座標（F-24 — retTy）: 戻り値の座標の付け替え（R0 / R4a — 最上段と imm コンテナの中身は r1）を map の値型にだけ分配し、
  キー型に分配していなかった。Lean の retOk はキーの r1 も許すので、既存の規約の分配漏れとして直した
- call の結果の座標（F-25 — computeTy・callResultTop）: computeTy が call の結果型を署名の座標（r0）のまま返していた（round4 の積み
  「現状無害」）。素の Def 呼び出し（展開されない・mut 引数なし・mut_def でない）の結果を呼び手の最内 region に読む（Lean の ret.relocR d′ と一致）。
  展開される関数と callM は結果の座標が別の規則なので従来どおり — 最初は当てたが Arena の region の精度を落とした。F-24 と合わせた回帰例 examples/ret_coords
- map の添字の値の座標（F-34 — mapValueAt、2026-09-28）: `m[k]` の getm の注釈 `t`（と computeTy の `m[k] : V?`）が宣言の型式から作った型（string は r0 固定）のままで、
  関数の frame（r1〜）で組んだ map の値型より締まり、Lean の getm の `Ty.sub t' t` で落ちていた（main の中では偶然通る・値が int なら無関係）。
  セルが実際に組まれた点の座標で読む: 名前の束縛はコア上の正確な型（core_ty — Def の値仮引数・展開の値引数）があればそれ、無ければ束縛点
  （F-26 の mapCellAt と同じ読み — map リテラル・呼び出しの結果・mut 束縛はそこで組まれるか写される）、辞書 const の参照は参照点で展開される（language.md 25 節）ので現在の点、
  他（フィールド・式）は宣言の型のまま。既存の黄金はバイト不変（既存の例の getm は値が int か main の中）。回帰例 examples/map_value_coords
  （仮引数の map・局所の map を return・辞書 const（@embed）を関数の中で直接 / 束縛して引く — 修正前は def error）。slice の添字（index）は型の注釈を持たないので同形は無い
- 残り（直さない）: 腕の region が違う if 式（`f(if c { cat(a, b) } else { p })`）は、腕の型の合流（上界の join）が新しい型規則の側なので直さない —
  腕ごとに呼ぶ / return すれば書ける。同枠（F-35）: `string(if c { bytes(".") } else { dir })` — 腕が「リテラル由来の view（最内 region の imm セル）」と
  「仮引数の slice（r0）」で違い、コアの ite は腕の型の一致を要る。片方を ann で揃えるには行き先の型（上界の join）を脱糖器が決めることになり、
  「行き先の型が確定している所だけを緩める」規律の外。書き方: 腕ごとに return する小さい関数（src/compiler/loader/embed.sober の orDot）— 回避を本来の形として残した
- 名前への代入の値（F-36 = F-o — 2026-10-02 回収）: mut 束縛への単純な代入 `mut entry := ""; entry = args[i]`（仮引数の []string）が def error だった — 束縛のセル型は初期値の座標、
  代入する値は r0 で締まっている。(3) の fieldValueAnn をパスの無い名前にも通す（束縛点の点座標へ緩める — 同じ読み）。回帰例 examples/assign_param。
  対の初期化側（F-q — 2026-10-02）: 仮引数の欄で初期化した mut 局所（`mut x := p.f`）はセルが r0 のままで後の代入が入らなかった — mutInitAnn を名前だけでなく
  欄読みの初期値にも通す（値の型は computeTy）。既存の黄金は不変。回帰例 examples/mut_init_field
- 腕の region の合流の横展開（F-m・F-l — 2026-10-02）: F-g（b685ad1 — 値位置の if の両腕を最内の region へ上げた型が一致すれば ann で緩める）と同じ判定を、
  値位置の定数 switch の全腕（default を含む — 腕の型が 1 つでも分からなければ付けない）と flow typing の if（ifnil）の両腕にも掛ける。回帰例 examples/switch_region_join・
  examples/ifnil_region_join。型 switch（unionSwitch）の腕はまだ
- switch 式の値の型（F-n・F-p・if の腕の中の switch — 2026-10-02）: computeTy・declOfExpr・retExprTy・exprSty0 が
  if 式と同じく switch 式の腕の末尾を辿る（computeTy = switchTy〔case → default の順に分かる方〕・declOfExpr は同じ順で最初に分かる宣言・
  retExprTy は全腕が単一式で型が一致すればその型・exprSty0 は型なしの定数でない最初の腕）。switch を返す本体に結果型の ann が付く —
  既存のコア黄金 40 本が変わり、差分は ann の包みだけ（両側から ann を剥がした木が 40 本すべてで一致・他の差分 0・ann +56・EXCLUDED 不変）。回帰例 examples/switch_value_ty
- 値の置き場の座標で読む（F-f・F-h — 2026-10-02）: computeTy が、文字列リテラルを宣言の座標（tString = r0）で、struct リテラル・欄読みを
  宣言の型のまま、if / switch を合流前の腕の型で読んでいたので、ブロックの出口の付け替え（R5）が「region が上にない」と見て発火しなかった
  （`x := { "a" }` の type error・`return { "a" }` の def error・ブロックの中からの return）。読みを「値が実際に置かれた座標」に揃えた:
  文字列リテラル = コアの strlit と同じ `rdepth - 1`・struct リテラル（litStructTy）= 欄ごとに値の式の型（region だけ違う同じ形のときだけ）・
  欄読み（selectorTy）= 土台の値の型の成分（同じ条件）・ifTy / switchTy = 合流（upJoin2 / upJoinN）が掛かるなら合流した型。あわせて R5 の宛先を
  `upRegion(want, kk)`（期待型が兄弟の腕の仮引数の r0 のとき、Def の中で書けない呼び手の region を宛先にしない）。tString そのものは変えない
  （型式 `string` の解決 = 宣言の座標でも使う — 変えると受理済み 148 本中 64 本が拒否に戻ることをスパイクで確認）。
  残る食い違いは 1 か所: Def 呼び出しの実引数に直接書いた文字列リテラルはコアが region 0（call.sober — F-6）だが、その節の computeTy を引く経路が無い
  （呼び出しの型は署名から・型引数は region を持てない）ので観測されない。黄金: コア 54 本が変わり、差分は ann の包みだけ（54 本すべてで ann が減る —
  882 → 677・EXCLUDED 不変・全 entry で stage2 の check と Lean の判定が一致 150/150）。回帰例 examples/block_region_value・examples/block_return

### mut struct の欄ごとのセルの段（2026-09-28、reaudit round 5 — F-17 案 2α）

問題（F-17）: mut struct のフィールド代入は丸ごと再構築（「n 項化の段」— `p.y = v` → `assign p (pair (fst (deref p)) v)`）で、
書く欄の位置に依らず残りの欄を全部射影し直すので、1 回の代入のコアが欄の数の 2 乗（n 欄で ≈ 8.8·n² バイト。全欄を 1 回ずつ書く Def は n³）。
selfhost の compiler/ はこれを避けて状態を int ヒープ 1 本に畳んでいた（selfhost 品質の積み ①）。加えて、フィールドを mut 実引数にできない
（ref がセル単位 — language.md 26 節の旧記述）ことが、struct の状態へ戻したときの `Push(mut st.nodes, x)` を塞いでいた。

形（脱糖器だけ — コア / Lean の変更ゼロ）: 宣言の型が struct（型パラメータ・`T?` でない）の mut の場所（mut 束縛・mut 仮引数）を
欄ごとのセルに割る。束縛の変数は ref の prod 鎖を持ち、struct 型の欄は同じ形に再帰的に割る（木。欄 1 つなら ref 1 つ、0 なら triv）。
- 生成 `mut x := e` → `let t = e in CELLS(t)`（葉ごとに `alloc mut (proj t i)`）。読み `x.f` → `deref (proj x f)`、値としての `x`（imm で渡す・
  返す・コピー）→ 葉を deref して pair 鎖に組み直す。代入 `x.f = v` → `assign (proj x f) v`、`x = e` / `x.s = e`（struct の場所）→
  値を束縛して葉ごとに assign。複合代入 `x.f op= v` も葉なら書ける（旧: フィールドパスは断片外）
- mut 実引数 `mut x` / `mut x.f` → 場所の ref（の木）をそのまま渡す（展開は場所の型 — 葉 = `ref true r t`、木 = ref の木 — で ann）。
  Def（R2 の callm）の mut 仮引数の型は struct なら ref の木（`Ty.paramOk` は構造的なので受ける）。欄のセルは全部束縛点の region に alloc
  されるので、31 節の「複数の mut 引数は同じ region の束縛」にそのまま収まる
- 入れ子を再帰的に割る理由: mut 仮引数の表現を「struct の場所 = ref の木」に揃えないと、欄が struct の `Push(mut st.nodes, x)`
  （Builder は struct）の別名渡しが型で合わない（1 段だけ割ると st.nodes は Builder 全体を持つ 1 セルで、Push の仮引数は割った木を期待する）。
  型パラメータで宣言した欄は葉 — 呼び手（インスタンス化済み）と Def の本体（型パラメータのまま）で割り方が揃う規則にするため

規律の判定 2（codegen との一致が構成的に出る）の非形式の論証（観測同値で通す）: lower は連続した 1 つのアグリゲート + 内部
ポインタ（欄のアドレス）で、check のモデルは欄ごとのセル。両者が観測で一致する理由:
1. 欄を指す別名は mut 実引数でしか作れず、どちらの側も「同じ欄」を指す（lower = 欄のアドレス、check = 欄のセルの ref）。束縛全体の別名
   （`mut x`）も、lower = アグリゲートの先頭、check = ref の木で、以降の読み書きは欄単位で対応する
2. アグリゲート全体を一度に読む・書く操作（値としての `x`・`x = e`）は、欄ごとの読み書きの列と同じ結果になる — 欄どうしは重ならず、
   その列の途中で他の文は走らない（組み直し・書き込みの式は制御フローを持たない固定テンプレート — 判定 1 も満たす）
3. struct のセルは freeze されない（freeze は slice / map だけ — 17 節）ので、実行時のタグ検査（assign の panic）の出方も欄単位と
   全体で変わらない。region: 欄のセルは束縛点で alloc し、アグリゲートも同じ region のフレームに置く — 寿命が同じ
Lean での値表現の同値の証明は置かない（裁定 — 非形式の論証で通す）。

効果（実測）: 全欄を 1 回ずつ書いて読む Def のコア — n = 16 で 53 KB → 12.7 KB、n = 64 で 2.38 MB → 123 KB。
棄てた案: 案 1 = コアに浅いフィールド更新 op（Lean 150〜250 行 — 書き込みは定数になるが、mut 実引数の問題は別の手当てが要る）、
案 2β = let で背骨を共有する再構築（Lean 0 行・1/8 — 同じく mut 実引数の問題が残る）。

帰結: 凍結コーパスの desugar の Zig ≡ Sober 照合（scripts/selfhost_desugar.sh の entry 列）は退役（mut struct の束縛を持つ entry のコアの形が
変わり、型も変わるので正規化でも戻せない）。コア AST の黄金（第 3 黄金）は Sober 生成で作り直す。

### region 透過の実体関数の段（2026-09-29、stack-audit — 決定 δ）

問題: mut 引数を持つ非再帰の関数は全部呼び出し点に展開していた（language.md 26 節の旧実装）。-O0 では展開の入れ子が掛け算になり
（src/compiler/app の IR 217 万行・inline 展開 約 5.3 万回）、コード 7 倍・CPU 2〜5 倍を実測した。R2 の Def（自分の region を開く anchor つき呼び出し）に
一般化すると anchor 1 slot の制約で check が compiler/ の 28 本を拒否する。

形（lower だけ — Lean・脱糖器・検査器の変更ゼロ。check は今どおり展開として型付けする — 2026-10-02 以降は下の「check の callM の段」で一部を callM の Def として型付ける）: 関数型の引数を持たない・mut 引数を持つ・
非再帰（loader の expands のうち関数型の引数の無いもの）の関数を、`--passes` の build では実体の関数として呼ぶ。本体の入口で深度を読んで
退避するが `region.enter` しない。出口（普通の出口・return・`?`）は退避した深度へ戻し、戻り値の境界コピーの floor = 入口の深度。
mut 仮引数は呼び手のセルのアドレス（R2 の mut_def と同じ呼び出し規約）。ジェネリックは lower のインスタンス化で単相コピー
（型引数の制約は展開と同じ — 値を持つ型なら string / slice / map を含んでよい）。

展開 ≡ 透過関数の非形式の論証（観測同値で通す）: 同じ呼び出しを展開で下ろした IR と透過関数で下ろした IR は
- (a) 本体の命令列が同じ: 仮引数の束縛 = 実引数の値（アグリゲートは自分のスロットへ写す — 展開の束縛もコピー。imm なので写しと元は
  観測で区別できない）、mut 仮引数 = 呼び手のセルのアドレス（展開でも同じセルの別名）
- (b) region の出入りが同じ: どちらも入口の深度を読むだけで `region.enter` しない — 本体の確保は呼び手の最内 region に積まれ、本体の中の
  ブロックが開く region はどちらでも同じ深さから数える。出口はどちらも入口の深度へ戻す。戻り値の relocate の floor は、展開 = 呼び出し点の深度、
  透過 = 入口の深度で、同じ値（呼び出し命令は深度を変えない）
- (c) 違いはフレーム（ネイティブのスタックとスロット）と制御の移り方（call / ret と br）だけで、どちらもソースの観測（出力・終了コード・
  panic の種別）に現れない。非再帰なのでフレームの深さは有界で、region の深度の上限（27 節の 1023 段）も消費しない
→ 8 節「展開は生成方式、意味には触れない」の 3 例目（関数型引数の展開・ジェネリクスの特化に続く）。check が展開として型付けした意味を
そのまま実行するので、受理の集合は変わらない（anchor 1 slot も掛からない）。

Def で下ろしてはいけない理由（健全性）: 自分の region を開くと、呼ばれた側で組んだ値（string 等）を mut 仮引数の欄へ格納する書き方が、
戻りで region ごと消えて宙吊りになりうる — 展開の型付けはその値を呼び出し点の region のものとして受理している。透過（region を開かない）なら
値は呼び手の最内 region に置かれ、呼び手の束縛より長くは生きないが短くもない（展開と同じ）。

適用の置き場: `--passes` の側（ELF の build と自己ビルド）。既定の `--emit=ir|ll` は展開の形のまま — 黄金（irtext / lltext）と Zig ≡ Sober の
照合の相手はそちらで、透過の側は実行照合（passes.sh・obs・stages の固定点）が見張る。
棄てた案: α 全部 Def（上の拒否 28 本 — frame で作った imm を渡す / region の違う mut 実引数 2 本 / R3）、α' 全部 Def + Lean で制約を撤去
（証明の波及が大きい）、β 呼び出し点ごとに Def / 展開を選ぶ（判定が型と構文に依る実装規則 — 脱糖器と lower の二重実装）、`@noinline` の個別指定
（利用者に回避を要求する）。


### check の callM の段（E2-S — 2026-10-02、決定 = night-adjudications 12〜15）

問題: δ（上の段）は build だけの生成方式で、check は mut 引数の非再帰関数を今も呼び出し点ごとに展開して型付けする。自己適用の
コアの 95.5% が展開（std/table の Get / Push / Set / Len だけで 49%）で、check の時間の約 2/3・RSS の約半分が展開の再脱糖だった
。

形（Lean・コアの規則・lower は無変更）: 脱糖器が、δ の対象（関数型の引数が無く mut 引数だけが展開の理由の非再帰関数）のうち
次を満たす関数を、展開でなく既存の callM（R2 の anchor つき呼び出し — Typing の `callM`）の Def として出す（実装 src/compiler/desugar/e2s.sober・逃げの周回 src/compiler/checker/e2s.sober）。

1. mut 仮引数がちょうど 1 つ（anchor が 1 slot で足りる）
2. 他の仮引数は region を持たない型（int / bool / byte / named scalar / それらの struct）— imm 実引数の「anchor 以下」の条件が呼び出し点に依らない
3. （呼び出し点ごと — 2026-10-03 改訂 D'）型引数が region を持つ呼び出し点（R3 の門 — tyArgOk でない）は、その呼び出し点だけ展開する。関数は上げたまま
4. （呼び出し点ごと — 同上）欄の経路の mut 実引数 `mut x.f` を渡す呼び出し点は、その呼び出し点だけ展開する。関数は上げたまま
5. 本体の中で callM で呼ぶ関数（再帰する mut 関数・@noinline・上げる候補）へ mut 実引数を 2 つ以上渡さない（anchor 1 slot — 2 つの mut 実引数が
   別の region から来ると callM の規則が落ちる。保守的に「2 つ以上」で外す — 逃げの周回を予防する静的な判定。S0 の残り 1 本 checker の verdict は
   再帰する tyJson へ `mut st`〔呼び手空間〕と `mut out`〔自分のフレーム〕を渡す形でこれに当たっていた）
6. 本体が Def として型付く（検査器の判定。落ちた関数は展開へ戻す — 逃げ。展開に戻すのは型付けを緩めるだけなので単調に収束）。
   S0 スパイクでは自己適用で 10 本が落ちたが 9 本は F-e（戻り値の無い関数の末尾の式文を値にしていた脱糖器の穴 — 686fb0b で修理）が原因で、修理後は 1 本（checker の verdict）

上げる判定は条件 1・2・5・6（関数の署名と本体）だけで決まり、package の中で閉じる（3'' の check の小分けの前提 — 依存する側は呼び先の
.sobi の印〔逃げ = `@expand`〕を読む）。条件 3・4 は呼び出し点の形の門で、合わない呼び出し点を展開へ倒すのは下の論証の向き（callM で型付く ⇒
展開でも型付く）に沿うので受理集合を変えない。棄てた案（2026-10-02〜03 の形）: 条件 3・4 を関数の印にしてプログラム全体の呼び出し点の
走査で決める — 1 か所の `mut x.f` で全呼び出し点が展開に落ち（自己適用で呼び先 71 本・822 件が package をまたいでいた）、
依存する側の呼び出し点が呼び先の判定を変えるので package の中で閉じない。改訂でコア 98 万 → 79 万節。

build は今どおり δ（region を開かない実体関数）で下ろす。check が型付けする形（callM — 自前の region を開く）と build が走らせる形が
別になるので、両者を繋ぐのが次の論証。

callM で型が付く ⇒ 展開でも型が付く（非形式の論証 — inline の許容性）

呼び出し `callM f ts e`（深さ d、anchor a、`b ≤ a ≤ d − 1`）が型付くとする。前提は Typing の callM の規則: 実引数 e : ta、
`ta ≤ (f.param.inst ts).renR a d`、結果の型 `(f.ret.inst ts).relocA a d`。f の本体 B は Def の世界（深さ 2 — region 0 = 呼び手空間・
region 1 = 自分のフレーム、Γ = [param]）で型付いている（defsOk）。

展開の形は、脱糖器の inlineCall が作るもの: 仮引数を実引数に束縛し（ann で仮引数の型へ緩める — `ta ≤ σ(param)` なので ann が付く）、
本体を呼び手の深さのまま（block で包まない）、戻りのラベルで受ける。ここで写像

  σ: 0 ↦ a、1 ↦ d − 1（呼び手の最内）、k + 1 ↦ k + d − 1（本体の中の block が開く region — 呼び手の最内の上に積む）

を考えると、展開した本体の型付けの導出は、B の導出の全ての region 添字・深さを σ で写したものになる。根拠:

- (a) 型付けの region の条件は σ で保たれる: HasType の前提に現れる region の比較は全部 `≤` 型（`b ≤ r`・`r ≤ rt`・`regionsBelow`・
  `b ≤ d`・callM の `b ≤ a ≤ d`・jump の `clampR` / `jumpRel`）か、深さとの `r < d`（region が今の世界にある）。σ は単調（a ≤ d − 1 ≤ k + d − 1）
  なので `≤` は保たれ、深さは Def の世界の 2 + j が呼び手の d + j に写るので `r < d` も保たれる。2 つの region の狭義の比較は前提に無い
  — σ が region 0 と 1 を同じ region に潰す場合（anchor が呼び手の最内 = a = d − 1）でも崩れない
- (b) 既存の写像定理との関係: Ren.lean の `ren_typing`（callM の preservation の根拠）は `rmap ρ0 δ`（0 ↦ ρ0、k + 1 ↦ k + 1 + δ）で、
  `ρ0 ≤ δ` の狭義単調な写像に限っている — フレームを呼び手の最内の上の新しい region（d）へ写す形（= callM の実行: 自前の region を開く）。
  展開はフレームを呼び手の最内そのものへ写す（σ は 1 ↦ d − 1）ので、`ren_typing` を「単調（狭義でなくてよい）な写像」へ一般化したものが
  この論証の形式版になる。狭義単調を使っている箇所は (a) の通り比較の向きの保存だけの見込み — Lean の補題（後追いの別段）で確かめる
- (c) 実引数: 展開は仮引数を `ann e σ(param)` に束縛する。callM の前提 `ta ≤ param.renR a d` は σ(param) と同じ型（region 1 は仮引数に
  現れない — 仮引数は呼び手空間の region 0 か region を持たない型だけ。retOk / paramOk）なので、ann の `Ty.sub ta σ(param)` がそのまま成り立つ
- (d) 戻り値: callM の結果の型 `relocA a d` は、本体の値の型の region 0 由来を a へ・フレーム由来を呼び手最内へ締めたもの = σ(ret)
  （relocA の定義 — 自フレーム由来の最上段は d へ。展開ではフレームの値は最初から呼び手の最内にある）。展開の戻りのラベルの型と一致する
- (e) 型引数: 条件 3 により inst ts は region を持たない型の置換なので σ と可換（`tyArgsOk`）
- (f) 非再帰: f は自分を呼ばない（δ の対象）ので展開は有限。本体の中の呼び出し（他の Def への call / callM）は、深さの一様な写像の下で
  規則がそのまま閉じる（Ren.lean の `Ty.shiftR_renR` / `Ty.relocR_renR` と同じ形）

→ check（callM）が受理するプログラムは、展開でも受理される。展開で型付いたプログラムの build（δ）が展開と観測同値に走ることは
上の段の論証（展開 ≡ 透過関数）が与えるので、E2-S の check の受理は build の実行の健全性に繋がる。逆向き（展開で型付くが callM で
落ちる — 例: フレームで組んだ値を mut 仮引数の欄へ入れる）は条件 6 の逃げが展開へ戻すので、受理集合は E2 の前と同じ（網 = 受理集合の
照合ゲート）。

残る義務（後追い — 別段）: (a)(b) の Lean の補題（`ren_typing` の単調な写像への一般化 + 展開の形の型付け）。それまでは上の非形式の論証と
受理集合の照合ゲートが網。

棄てた案: E2-M（anchor を列に — 残り 1.4% のために Lean の写像と callM の証明を一般化）・E2-T（region を開かない Def を Lean に —
α' と同じ大きさ）・E2-D（DAG + メモつき検査器 — 展開の再脱糖が残る。関数型の引数の展開の残り 6.8% 向きとして後で）。
（S0 スパイク — コア −85%）

## 実装との照合（決定: Lean 製型検査器を最初の本番にする）

「証明した性質が実装でも成り立つか」を機械化する方法は 3 段ある。3 → 2 の順で使う。

| 段 | 方法 | 強さ |
|---|---|---|
| 1. トレース | Lean の定理名を metaprogramming で列挙し、Zig テスト名に埋めた定理名と差分を取る（dandori-gate の全行トレースと同型） | 存在の照合のみ。単独では弱い |
| 2. 差分テスト | Lean の型検査器・評価器は証明対象であると同時に実行可能な参照実装。生成器（`plausible` の生成器を JSON テストベクタとして吐く）で Sober コアの小プログラムを大量に作り、Lean と Zig の accept / reject と診断を比較 | 同じ入力で同じ判定を保証。bdd-pbt-formal-ladder の PBT ↔ 形式手法の接合がここ |
| 3. gap を消す | 型検査器を Lean で書き、それを本番の型検査器として使う | 型検査器についてはテスト不要 |

### 到達しない項の段（2026-10-01 — error 網羅 analyzer A5、決定 E4-U = U-a）

error の switch の網羅を「リンク集合の全ラベル」から「analyzer の導出集合（公開の呼び先は宣言）」へ移す（language.md 13 節 — F-33 の解決）。
覆っていないラベルの腕を埋める項がコアに要る — 今までは脱糖器が全 variant の腕を要求していた（覆わなければ Malformed）。

- 構文 `Expr.unreach (t : Ty)`。子を持たず、型は注釈 t で構文主導に決める（jump・nil と同じ — V4-2 裁定 J1）。JSON `{"k":"unreach","t":T}`
- 型規則 `HasType … (.unreach t) t` — 前提なし。値を作らないので region の座標の約束（regionsBelow・jumpRel）が生じない（jump の結果型に条件が無いのと同じ理由）
- 機械 `.eval H S (unreach _) ↦ .panic H`（ゼロ除算・タグ検査と同じ終端 — 27 節の「到達 = バグ」、実行系は exit 101）
- 定理への効き方: progress は 1 歩で panic の枝・preservation は panic が終端で型の義務なし（StateTy.panic）・canonical forms は値でないので無関係・
  step_shared_stable はヒープを変えない。構造再帰（shift / subst / shiftTy / tsubstTy / renR / renameFn / noNewchan / src と
  その補題の帰納）は葉の 1 行ずつ。typecheck は `some t`（sound / complete の枝も 1 行）
- 検証: lake build 緑・sorry なし・`#print axioms` = soundness / preservation / progress / typecheck_sound / typecheck_complete /
  hasType_iff_typecheck / defsOk_of_check / defsOk_of_linked / step_shared_stable は propext・Quot.sound、par_step_commute は propext のみ・
  corevec 300 本はバイト一致のまま（unreach を含まない）・Examples に型は付くが実行で panic（exUnreach1）と覆っていない腕（exUnreach2 / 3 — 通る腕は値、
  外れれば panic）と JSON の往復・変異 2 本（機械の step を panic でなく `lit 0` に → preservation が落ちる、typecheck を `some .unit` に → sound / complete が落ちる）
- 下ろし方: 脱糖器は error の switch（decl = ERRS）に限って覆っていない variant の腕を `unreach 結果型` にする（sum type の switch は今までどおり全 variant が要る —
  網羅はコンパイラの担当、13 節の線引き）。lower は error の switch だけ網羅を要求せず、外れた tag は exit 101（裁定 E4-B — build は analyzer を走らせない）
- 棄てた案: 既存の項で作る（ゼロ除算で panic させてから型が任意の jump — 意味の実装を脱糖器へ持ち込む）/ ゼロ値で埋める
  （analyzer の導出が誤ると黙った誤値 — 「音を立てる」に反する。ゼロ値を持たない型もある）/ 欠けた腕を default に寄せる（意味が変わる）
- Gen（corevec の生成器）への追加は Gen 総追いつき（parallel の形式化の直前）の回に回す

### Gen 総追いつき 段 A（2026-10-05 — 3 点セットの 1 本目）

据え置いてきたコアの語彙（slice / map / string / byte / float / mksliceAt / mkmapAt / unreach / add / lt …）に corevec の生成器を追いつかせた。
コア・証明・JSON は変更ゼロ（Gen.lean と golden だけ）。不変条件「型指向のターゲット型は loc-free」は保つ — region を持つ値は Γ にだけ現れる（段 B で緩める）。

- 型指向: 腕を一様の 15 択から「その状態で使える腕だけの重み表」（pickW）へ。Γ に mut ref / コンテナがあれば使う腕を厚く、最内に書けない（d < b + 1）なら
  alloc / コンテナ作成を外す。genTy に byte / f64。スカラーの腕に add / lt / toint / tobyte / fconv / farith / fcmp / eqs、低重みで unreach（裸と ite の片腕）
- コンテナ: 作る（mkslice / mksliceAt / mkmap / mkmapAt — キーは int か region rk ≤ r の string / strlit）→ Γ に束縛し、半々で直後に 1 回使う。
  使う op は再帰しない関数（useSlice / useMap / useRef — 部分項は Γ の変数か底の値）に切り出した（fuel 4 のままで消費 op の到達率を上げるため）。
  14 op（lenE / index〔注釈つき / なし〕/ setidx / append / subslice / concat / eqs / freeze / getm / setm / delm / lenm / keysm / freeze〔map〕）と
  関数表の新しい Def への呼び出し。要素が loc-free でない slice（keysm の string キーの列）には値を作る op と型引数を使わない（生成器のバグ 1 件 — 型指向が reject した 4 本の原因）
- 関数表: 8〜14 を追加（string 仮引数・f64・region 0 への mksliceAt + freeze で string を返す・copyTo 0 で自フレームの連結を呼び手空間へ・
  総称の slice〔tparams = 1〕・mut slice / mut map の anchor の callM）。全ベクタの checkDefs がこれらの本体を毎回検査する（copyTo はここで踏まれる）
- ベクタ: 型指向の半分は最外の block の中から（深さ 1 で始めると最内へ書く腕が最初から使える）。chaos に欠けていた 22 構成子 + ff、genChaosTy に byte / f64 / slice / map / tvar
- golden 全面再生成（seed 42・300 本 — 乱数列が全部ずれるので連続性は無い。ユーザー了承済み）: accept 204 / reject 96。
  型指向の出自 20,000 本（10 シード × 2,000）で reject 0。compiler/ の check（checkdump）との照合は golden（selfhost_check (i)）と追加の 63,000 本（21 シード × 3,000）で食い違い 0
- 段 B に残すもの: region を持つターゲット（blockR / copyTo を型指向が出す・ラベルの型に slice）・関数呼び出しの戻りの region 座標を ty で照合する形

### corevec v2（2026-10-05）

網としての corevec を一段強くした（コア・証明・JSON は無変更）。

- 近傍変異（near-miss）: 型指向の 1 本に 1 か所だけ変異を当てる（Gen.lean の mutate — seed 決定的）。種別 = flag（mut フラグ反転）/ region（strlit・mksliceAt・mkmapAt・copyTo・newchan の
  region ±1）/ key（map のキー型を keyOk の外へ）/ var（de Bruijn ±1）/ annty（ann・nil・inl・inr・label・jump・unreach・getm・delm・copyTo の型注釈の差し替え）/ jump（ラベル添字 ±1）/
  fn（関数表の添字・型引数の数）/ op（lit ↔ flit・tobyte ↔ toint・add → fadd 等）/ idx（index の読み出し注釈）。種別を先に一様に選ぶ（lit の多さで op に偏らない）。
  chaos の拒否が根で落ちる浅いものなのに対し、変異は「1 規則だけ破る」拒否 — compiler/ の check の規則ごとの食い違いを狙う
- 内訳: 1000 本 = 型指向 70% / 変異 20% / chaos 10%（各行に出自 `"g"` — 消費者は e / v だけ読む）。golden（seed 42）: accept 741 / reject 259、変異 200 本のうち reject 162・accept 38（等価な変異 — 数えるだけ）
- 被覆ラチェット + 自己検査（scripts/corevec_cov.ts — corevec.sh が毎回通す）: Json.lean の exprToJson の腕から構成子・kind・子の欄を機械で読み、Syntax.lean で「ソースには現れない」と
  書かれた構成子を外した 64 個それぞれに accept ≥ 3・reject ≥ 3 を要求（accept 側は blockR / copyTo を免除 — 段 B で外す）。型指向の出自が reject なら生成器のバグとして不合格。
  わざと Gen から delm を抜くと `delm: accept 0 < 3` で鳴ることを確認
- 照合の拡張: corevec.sh --binary は全数を lean_batch で（gates の corevec ゲートは --binary）・selfhost_check の (i') 追加シードは gates --all で常設（seed 1..2 × 1000 本 — 3 本で +90 s を計測して 2 に）
- 収穫: 変異を含む 30,000 本（10 シード × 3,000）を compiler/ の checkdump と照合して食い違い 0

### Lean → Sober 抽出器 E1（2026-10-05）

「証明は Lean で書く・検査と実行は Sober」の抽出器。第一顧客 = src/compiler/checker/ty.sober（Syntax.lean / Typing.lean の `Ty.*` の手書きの写し）。
E1 は抽出器と計器まで — 生成物はまだどこからも参照されない（差し替えは E2）。コア・証明は無変更。

- 形 = 精緻化後の定義の方程式（getEqnsFor?）経由（lean/Extract/ — `lake exe sober-extract`）。方程式 1 本 = 1 腕。重なりのあるパターン（`Ty.sub` の落ち穴・`Ty.keyOk`）は、
  方程式の仮定が「先行の方程式の左辺のパターンの否定」の形であることを機械で照合してから順の if 連鎖に並べる（対応しなければ止まる）。
  仮定が無い（重なりが無い）関数は 1 つの仮引数の構成子で switch にまとめ、同じ構成子の中は残りの条件の if 連鎖（relocR の mut / imm 等）
- 写せる範囲（これ以外は止まる — 黙って近似しない）: 方程式がある定義（partial / unsafe は不可）・パターン = 構成子 / 変数 / Bool・Nat のリテラル / Nat の succ / Option・
  右辺 = Bool の演算・`decide` の比較（Nat / Bool / Ty の等しさ）・if・Nat の + / -（前奏の natSub — Lean の Nat は 0 で止まる）/ min・Option の none / some / or / getD・List の添字・
  `List.all` に捕捉のない関数参照（関数ごとに特殊化）・対応表のある構成子の生成・抽出対象の関数の呼び出し。型 = Bool / Nat / Ty / Option Nat / Option Ty / List Ty
- 設定（lean/Extract/Config.lean 1 ファイル）: 抽出する定義 25 本・構成子の対応表（Ty の構成子 → タグ定数と欄の読み出し — inductive の構成子が表から欠けると止まる）・前奏・
  `List.all` の特殊化の雛形。`deriving DecidableEq` の構造の等しさ（tyEq）は inductive の定義から生成
- 負例（lean/Extract/Neg.lean — `sober-extract --neg`）: partial def・String・ユーザーの型クラス・右辺の match・仮定が先行の否定に対応しない人工的な方程式の 5 本が全部止まる
- 生成物 = lean/Extract/sober/ty_gen.sober（26 関数・1174 行）。src/compiler/checker に置くと package に入って建ち、testdata/ に置くと黄金のゲート（astjson が testdata//*.sober を拾う）に入るので、E1 では lean/Extract/sober/ に置く（E2 で src/compiler/checker へ移した）。tyvecdump・shim は lean/Extract/sober/ のまま
- 計器: `scripts/extract.sh --check`（gates の extract ゲート — lean / check タグ）= ①抽出器の結果 ≡ コミット済みの生成物 ②負例が全部止まる
  ③tyvec（`sober-gen --tyvec` — FeatherweightSober/TyVec.lean が 26 関数を巡回して引数を乱択し Lean の評価そのものを結果に吐く → lean/Extract/sober/tyvecdump.sober が
  生成物で計算し直して全行バイト比較・20.8 万行）。`--hand` は同じ tyvec を手書きの写し（ty.sober）に掛ける — 移行期の旧 ≡ 新（20.8 万行一致）。
  感度: 生成物の手直しは①で、意味の変異（sub の `<=` → `<`）は③で 403 行が鳴る

### Lean → Sober 抽出器 E2 — Ty 層の差し替え（2026-10-05）

src/compiler/checker の型の関数は抽出器の生成物（src/compiler/checker/ty_gen.sober — 26 関数 + tyEq + 前奏）。手書きの写しは退役し、
ty.sober は型の表現（Ty・定数・tyAt / tg / tA / tB / tC / mk / tOpt / isCont）+ Lean の Ty に無い補助 2 本（isImmStr・tsLen — check.sober が使う）+ 型の印字（tyJson）に縮んだ（525 → 149 行）。
readAs の m は Lean どおり bool（呼び手 check.sober は `tA(…) != 0` を渡す）。b2i は生成物の前奏が持つ（state.sober の同じ関数は撤去）。コア・証明は無変更。

- 移行期の照合: 差し替えの直前に tyvec（20.8 万行）で手書き ≡ Lean・生成物 ≡ Lean を確かめてから差し替え（--hand は役目を終えて撤去）
- 性能の手当て（抽出器の観測等価な写し方 — 生成物の素の形は自己適用 check で命令 +44%・RSS 1.0 → 2.3 GB だった）:
  ①共有: 右辺が左辺の仮引数のパターンと同じ項なら仮引数をそのまま返す（葉の型・tsubst の範囲外の tvar）・左辺と同じ構成子を作る場所は
  前奏の mkLike（欄が全部元と同じなら元の記録を返す — 子が変わらなかった型を作り直さない。記録は作ったら変えない・等しさは構造で見る）
  ②近道 = 定理の腕（Config.shortcuts）: 抽出する関数についての証明つきの等式（`Extract.tsubst_nil : t.tsubst [] = t`）を方程式の腕の前に置く。
  定理なので先に当てても値は同じ。無条件の定理（方程式を全部覆う）は止まる（負例）
  ③`Option.or` の短絡: 右辺の最上段の `a.or b` は文で写す（a が some なら b を計算しない — anchorOf の残りの退行 9 G はこれ。前奏の optOr は両方を先に計算する）
  ④記録の仮引数の最上段のタグは先頭で 1 回だけ読む・1 回だけ使う欄の読み出しは使う場所へ畳む（`&&` の短絡で読まずに済む欄を先に読まない）
- 結果（自己適用 check — stage2 で src/compiler/app の一括 check・同じ木）: 命令 81.5 → 82.9 G（+1.7%）・peak RSS 1009 → 464 MB（−54% — 手書きの写しも子が変わらない型を relocR / tsubst … で毎回作り直していた。その分が mkLike で消えた）・wall は揺れの範囲で同等。
  自己 build は +0.1 G（生成物のソースが 380 → 946 行）
- 計器: extract.sh --check（①生成物 ≡ 抽出器 ②負例 6 本 ③tyvec）+ end-to-end の網（corevec --binary・selfhost_check・checkverdict・leanbatch）。
  感度: tsubst の近道の変異（空の ts で int を返す）で tyvec が 2,501 行鳴る
- 3 点セットのレーン総括（Gen 段 A 6b6b0b4c → corevec v2 93379cd6 → 抽出器 E1 657e6869 → E2 55c2392d — before/after の表・残穴）: 残りは Gen 段 B（region を持つターゲット — ty 比較が region 座標を照合する主配当）・E3 typecheck（段 6 と並走・(γ) 規則の表 + 同値定理を推奨）・E4 以降（Machine の参照実行器・補題からの PBT 生成）

### 段 6 P2a — 新構成子の網の解除（2026-10-06）

P1 で Lean のコアに入った scope / spawn / join / tryJ / newch と send / recv の端点版を、src/compiler/checker が検査し Gen が出す状態にした（被覆ラチェットの EXEMPT_ALL を解除）。
- 入口の裁定（決定 (A) — 朝にユーザー追認）: E3（typecheck の抽出）は 2 段。typecheck の腕 82 のうち 56 が右辺で再帰の結果に match する（MatcherApp）ので E1 の抽出器はそのままでは 1 腕も写せない。
  P2a = 新構成子の規則だけ手で写す（移行期の照合相手 — E2 の旧 ty.sober と同じ立場）→ P2b = (γ') 1 フレームの遷移関数 tcStep を Lean に書き（再帰しない — 子の結果を引数で受けるので「計算結果への match」が「引数への match」になり E1 の方程式経由がそのまま効く）+ `typecheck = evalRule` の同値定理 + Sober 側の汎用の駆動部。
  網が先・置換が後（新構成子の網が無いまま新構成子込みの全面置換を踏まない）。P2b の完了条件に check.sober の手の写しの退役を含める・同値定理が腕ごとの場合分けの見込みを越えたら停止。
  棄てた案: (β) 抽出器が CPS / 非関数化で明示スタックへ機械変換（抽出器に MatcherApp の復元と継続の非関数化の 2 機構 — 正しさが網だけ）
- Ty 層: Ty.givable / Ty.rehome を抽出の対象に（生成物 28 関数）。抽出器に列挙の inductive（欄を持たない構成子 → 整数 — OwnK = 0 scope / 1 task / 2 tx / 3 rx。Config.enumTable）のパターンと値を足した。tyvec は 28 関数 × 8000 = 22.4 万行
- 境界（json.sober — 手書きのまま網で守る）: 式 scope / spawn / join / try / newch と型 own（o の綴り → 種類）の parse。nc（noNewchan の否定）は scope / spawn / join / try は子の論理和・newch は 0（P3b-2）（P3a の Def の本体の解禁 — core.sober の直結も同じ）
- 検査（check.sober — 移行期の手の写し・P2b で退役）: 5 構成子の腕 + send / recv の own tx / own rx の腕（P1 で Lean に入ったのに写しに無かった — Gen が端点を出さないので網が鳴らなかったドリフト。P2a で閉じた）
- Gen: 型指向の腕 task（重み 3・t が regionsBelow 0 && chanFree のとき）= scope の中で spawn → join / spawn → try（死んだら続きの値）/ newch → tx を spawn に渡して send → join → recv。chaos に 5 構成子・近傍変異に newch の region / cap 0・scope / tryJ の注釈・kids / setKids に 4 構成子

### 段 6 P2b — typecheck の抽出（E3 — (γ')・2026-10-06）

src/compiler/checker の型検査の本体（check.sober の約 650 行の switch + P2a の手の写し）を、Lean から抽出した 1 フレームの遷移関数と手書きの汎用の駆動部に置き換えた。型検査の判定の写しは手書きが 0 行に（残る手書き = 駆動部・表現の読み口・JSON 境界）。
- Lean（TcStep.lean・TcEq.lean）: `tcStep Δ f b d Γ Λ r1 r2 r3 : Expr → Nat → Act` — フレーム = (式・段・文脈・評価し終えた子の結果 r1〜r3) から「次に降りる子と文脈（`Act.sub`）」か「結果（`Act.ret`）」。
  書き方の規律 = tcStep 自身のパターンは (構成子, 段 0 / 1 / 2 / n+k — 重なりなし) だけ・結果の型の入れ子のパターンは全部 1 腕 1 つの小さな関数（`k…` 組み立て / `s…` 次の子と文脈）の引数のパターン・右辺に計算への match を書かない（`Δ[fn]?`・`Λ[n]?`・`anchorOf` は引数に持ち上げる）・文脈と関数表の読み口は小さな定義（`ctxGet` / `lctxTy` / `defGet` …）。
  `evalRule`（燃料つき — 段 0〜3 を回し子は燃料 − 1）と定理 `typecheck_eq_evalRule`: `typecheck … e = evalRule … (sizeOf e + 1) … e`。腕ごとの補題 77 本（雛形を機械生成し、依存する文脈の腕 — ifnil / case / callv / spawn / call 系 — だけ手で場合分け）+ 帰納法。sorry なし・公理 propext / Quot.sound（full simp が Classical.choice を引く腕は simp only）
- 抽出器: 方程式経由（E1）のまま。足したもの = 節（Expr — st.h の [kind, nc, a, b, c]。Config.nodeTable = 構成子 → kind の判定・case の札・欄の読み出し。札の無い構成子 = 実行時だけの形は写さず switch の外れ）・捨てる仮引数の型（Defs — st が持つ）・手書きの読み口の表（shimTable — Act の構成子も）・`n + k` のパターン・列挙の値を式に（FConvOp → 式の語の番号）・欄の無い型の作り置き（`st.tInt` 等）・非再帰の定義（展開の等式 1 本）。生成物 = src/compiler/checker/tc_gen.sober（65 関数）。MatcherApp の復元器は作らない（(γ') の眼目）
- Sober: check.sober = evalRule の燃料なし版の駆動部（tcRun — フレーム 9 語・段 3 の Act.sub は none）+ 読み口。Lean の typecheck は部分項が none でも兄弟を評価してから none を返す形があり（d = 0 の call 等）、駆動部も同じ（旧写しの「最初の none で打ち切り」はしない — 結果は同じ none）
- 移行期の照合: 旧 checkdump ≡ 新 checkdump を corevec 1000 本 + 手書き（byte / float / copyto / par の 14 本）+ 第 3 黄金で 1261 本食い違い 0 → 差し替え → selfhost_check 全面 fail 0・extract（tc_gen ≡ 抽出器）・gates --full
- 性能: 自己適用 check（src/compiler/app の一括）は旧 stage2 比で wall −12〜25%・RSS +0.1%（perf の無い環境で交互 3 回 — 出力はバイト一致）

### 順序

1. Phase 1（fib、Zig）
2. Featherweight Sober（Lean、本文書）
3. Phase 2 = Lean 製型検査器を本番として接続。Zig は脱糖までを担い、脱糖後のコア AST を Lean 側に渡す
4. Phase 3 以降はこの構成で進める
5. Zig（またはセルフホスティング時の Sober）で型検査器を再実装し、Lean 実装を段 2 の黄金オラクルとして CI に残す。実装が 3 つになっても正は 1 つ。Lean はコンパイル経路からは退くがオラクルとしては恒久
   - 着手のトリガー（2026-09-17 追記。「落ち着いた頃」では決まらないので）: LSP の編集応答が目に見えて遅い、またはセルフホスティングを始める、のどちらか早い方。前者を測るため Phase 2 で接続した時点で応答時間のベンチを 1 本置く
   - 着手の前提: 段 2 の差分テスト基盤（生成器 + Lean / Zig の accept / reject 比較）が先に回っていること。無い状態で再実装すると Lean をオラクルにできず、証明された型検査器の価値を捨てることになる
   - 再実装より先に試すこと: Lean 4 の C 出力をリンクする案（下記条件 2）。プロセス分離の起動コストだけが問題ならこれで済む

### 守る 2 条件（入れ替えを機械作業にするため）

1. 境界はデータだけ。Zig → Lean は脱糖後のコア AST（JSON）、Lean → Zig は診断のリスト。共有メモリもコールバックもなし
2. 最初はリンクせずプロセス分離。Lean 製型検査器は別バイナリ、stdin / stdout で接続。Zig コンパイラに Lean ランタイム（libc）を混ぜず、`lake build` と Zig ビルドを独立させる。性能が問題になったら Lean 4 の C 出力をリンクする選択肢が残る。Lean の依存は Std のみ（Mathlib は入れない）

### 正直に見ておく点

- Lean 製型検査器は脱糖後の Sober コア全部を扱うので、Featherweight Sober（証明済み断片）より大きい。証明されているのは部分、残りは「Lean で書いてあるが未証明の参照実装」。断片を育てて証明済み領域を広げる運用
- 脱糖器は Zig 側に残り未証明。ただし境界がコア AST なので「脱糖結果が体系の項か」は Lean 側のパースで毎回検査される
- 定理 1・2（領域安全・競合自由）を段 2 で検査するには、Zig 側にも region 木を追跡する計装付き評価器が要る。Lean 側の意味論を写す

## 実装計画との位置

design-dev.md の Phase 1（fib）には寄与しない。Phase 1 → Featherweight Sober → Phase 2（Lean 製型検査器を接続） の順。Phase 1 と並行して始めてもよい（触るファイルが重ならない）。

## 想定するリスク

- 証明工学のコストが本体を食う。時間を区切る: 定理 3 が 2 セッションで通らなければ体系を削る
- 体系と実装の gap。型検査器を Lean で書いて本番にすることで型検査器については消す（上記）。脱糖器と codegen には残る
- コルーチンを足した瞬間に意味論が膨らむ。stackful + 協調的スケジューリングは「中断点でのみ切り替わる」のでインターリーブは有限に抑えられるはずだが、定理 2 の証明を作り直す覚悟がいる
- 「証明した」が過信を生む。証明したのは Featherweight Sober の性質で、Sober コンパイラの性質ではない。design-dev.md にその一文を置く
- 定理 2 は逐次一貫（SC）なメモリモデルを仮定する。x86 TSO では実用上問題ないが、ARM 等の弱いメモリモデルでチャネル実装のオーダリングが正しいかは別問題（Iris / herd7 の領域）。体系には入れず、ランタイム側（design-dev.md Phase 5b）の検証項目に置く
- ランタイム（スケジューラ・チャネル・region 解放）の正しさは Lean の対象外。5a では Lean の意味論をオラクルにした差分実行、5b ではチャネルと join を TLA+ でモデル検査し、実装トレースを仕様に照合する。SMT ソルバは analyzer や SoberSQL の個別判断で使うことがあっても、メタ理論には使わない
