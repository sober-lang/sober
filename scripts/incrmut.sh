#!/usr/bin/env bash
# 後段の関数キャッシュの鍵のミューテーションの検査（段階3 R3-c — report-1194 6 節3・report-1202）: 鍵の成分を1つずつ落とした壊したコンパイラを木のコピーから
# stage2でビルドし、検査が特定して鳴ること（鳴らなければFAIL）。
#   m1 = 呼び先の記録の事実（ckFact — 戻りの型・mut仮引数のフラグ・ワーカーの大域か）を落とす（ckOpnd）
#   m2 = cfg を落とす（ckTab の c1 / c2）
#   m3 = cutInsert の 2 bit を落とす（ckBeta）
#   m4 = 番地を取られる bit を落とす（ckBeta — 自分と呼び先）
#   m5 = 番号の定数の点の鍵から序数を落とす（ckTab — 持ち主の中の点が全部同じ鍵）
#   m6 = コンパイラの鍵（世代）を落とす（app の buildCacheGen — 定数の世代）
#   m27 = 焼き込みのコンパイラの鍵（app の bakedKey）を、仮のファイル（空 — 手順の外で建てたコンパイラ）でも定数の鍵にする: m6 と同じく compiler-swap で捕まる
# cfg のうち全関数の鍵に混ぜないワード（ckDrop。必要になったときだけ宣言する rt の記録。本体が参照すれば正準形に入る）:
#   m24 = ckCfg が外すワードも混ぜる（std の関数の鍵がプログラムごとに変わる形へ戻る）: 検証 =2 の `cache: key depends on a cfg word left out`
#   m25 = 印のついた読み（UB_MARK）のある関数の鍵に std/utf8.boundary の有無を入れない: 検証 =2 の感度の検査（kind 43）
#   m26 = 印の無い関数の鍵にも std/utf8.boundary の有無を入れる: 同（kind 44。依らない関数が外れる）
# 切り口 γ（TypeAllのpackageの区画 — 段階5 R3・report-1228 4.5の5本 + 1）:
#   m7 = 鍵K1から推移的に依存する宣言の要約を落とす（tyK1）           — 鳴らす編集dep-decl（依存の宣言の相の記録の序数がずれる）
#   m8 = 鍵 K1 からソースの要約（tcSrc）を落とす（tyK1）        — listat-sem（本体の編集）・optfn-site（ソースの変わらない package の脱糖後の木）
#   （m9 = 合成の節の引き直しを落とす〔trNode — PRSYNのlo〕は同値のミュータントで外した: γ の値の合成の節の参照は当たりのパスで引かれない —
#    参照されるのは総称の名前付き関数型の展開〔関数宣言・仮引数〕だけで、例題 142 本の計測・lo = 12 の題材でも出力 / 検証が不変〔report-1242 1 節〕）
#   m10 = 当たりの nimpl の足し込みを落とす（tyRead）            — none（全部当たり — 暗黙の freeze の点が消える）
#   m11 = 検査の飛ばしでDeadlineUseを足さない（ParCheckTyped）— 例題task_sleep_deadline / net_deadline_spawnの温（題材だけのオプション）
#   m12 = 検査の飛ばしを外れにも掛ける（CheckSkip）             — 拒否のステージ（rej-par / rej-freeze — 温が受理する）
# 切り口P（parseのファイル単位の木 — 段階5 R4・loader/pcache.sober）:
#   m13 = 鍵からソースの中身を落とす（pcKey — 長さだけの鍵）     — listat-sem（長さの同じ本体の編集 — 古い木が当たる）
#   m14 = 符号からフィールドcを落とす（pcEnc / pcDecの両方 — 自分とは整合する欠けた符号）— noneの検証（読み戻しの照合 `cache: parse readback mismatch`）
# γ / Pのミューテーションはcheckのパス（タスク2 R4 — analyzerの全部の型付けが γ を読む・checkがparseの木を読み書きする）でもincrcheckの自己のチェーンで鳴らす:
#   m7 = dep-decl（検証 =1 — `cache: stale entry gamma`）・m8 = optfn-def / optfn-site（読み戻しの食い違い）・m12 = frz（freeze の違反の指摘が落ちる）・
#   m13 = listat-sem（検証 =1 — `cache: stale entry parse`）・m14 = none（検証 — `cache: parse readback mismatch`）。m10 / m11はcheckのパスでは同値
#   （nimplとDeadlineUseはbuildの検査の歩きだけが読む — m10は base bld aerr bld frz none のチェーンで鳴らないことを確認した）
# 切り口D（checkの関数単位の判定 — タスク2 R2・checker/defcache.sober）— 鳴らす検査はscripts/incrcheck.shの自己のチェーン（短い列・温のcheckの出力の割れ）:
#   m15 = インスタンスの memo の当たりで使いの辺を積まない（luEdge）        — inst inst-drop（作り手が離れて当たりの使い手が落ちを運ばない）
#   （m16 = 鍵の推移的な依存からジェネリックの本体を落とす〔dkGraphの辺 ②〕は同値のミュータントで外した: インスタンス化する呼び出しは呼び先の仮引数に型パラメータの
#    値を渡すので、辺 ④〔mut の Def でない呼び先へ mut を含みうる値 — 型パラメータは張る側〕が同じ本体へ必ず張る。mut 仮引数のジェネリック
#    〔incrcheckのinst2〕でも ④ が張られることを --def-graph で確認した — report-1263）
#   m17 = 鍵の推移的な依存から展開される関数の本体を落とす（dkGraph）                — exp exp-rej（スカラーのmut仮引数2つの展開される関数 — ④ が張られない形）
#   m18 = 落ちの位置を項目の頭からの相対でなく絶対の字句で持つ（CkRel / CkAbs）— body rej rej-pad（前に字句を足すと古い位置。コメントだけの行は字句を動かさない）
#   m19 = 鍵から参照の辺（署名・const・型）を落とす（dkGraph）               — callee callee-sig（呼び先の署名の編集で呼び手が古い受理のまま当たる）
#   m20 = 当たりの脱糖の拒否の値を再生しない（受理扱い — タスク2 R3）            — dlen dlen-pad（拒否のDefが当たりのとき受理を出す）
#   m21 = 拒否の 2 つ目の位置（NonExhaustive の missing）を値に書かない        — dnex dnex-pad（再生の文面から `(missing: …)` が落ちる）
#   （m22 = constの初期化式のラムダでもcapLiveがmainReachを遅延で作る〔report-1271〕はm23のタスクで同値のミュータントになったので外した: 区間の子は
#   親の届くフラグを受けるのでcapLiveの近道を外してもmainReachを作らない。遅延で作るパスの検出はm23が持つ）
#   m23 = 区間の子が親の届くフラグ（PlanDefsのrok / reach）を使わずcapLiveがmainReachを遅延で作る（report-1272 — 関数の中の値の位置のラムダ）
#         — 扉の監査（=2）の examples/closure_field_def.sober が `cache: door outside` で落ちる
# 切り口BC_PKG（工程Bの束 — lower/bundle.sober）:
#   m29 = 境の要約の呼び出しの辺をB2の後の記録でなくx86の前のIRから取る（β1の当たりの関数はB2の入力のまま — 要約が格納場所の当たり方に依る）
#         — 鳴らす編集none（温のビルドのSOBER_SUM_CHECK=1が `cache: summary depends on the cache state` — incrbuildの warm=SUMDEP）
#   m30 = 束の仮定から置く関数ごとの上からのビット（番地を取られるか・入口か・強連結成分の中か・cutInsertのフラグ・B2の呼び先の番地取り）を落とす
#         — 鳴らす編集fnval（strings.HasPrefixの番地取り — std/stringsのK0と仮定が同じまま中身が変わり、漏れの見張りが `FAIL k0leak std/strings`）
#   m35 = 束の仮定から間接呼び出しの相手の事実と展開したrtの関数の鍵を落とす — 例題の組 http_delayed_cut → http_wait（展開したrtの本体が違う —
#         std/io の束が古いまま当たり、検証モードが `cache: stale bundle of package std/io`）
#   m36 = 束の仮定からプログラム全体の値（cfgの正準形・番地を取られるrtの関数・deadline: の有無）を落とす — 例題の組 task_print_indirect →
#         task_sleep_deadline（deadline: の有無で時計の読み方が変わる — 検証モードが `cache: stale bundle of package std/os`）
#   m31 = K0からpが届く関数の事実（境の要約の根の関数ごとのハッシュ）を落とす — 鳴らす編集fact-add → fact-flip（elfの再帰の葉が印字する。elfの宣言の要約とlowerへ写る
#         宣言は変わらず、呼び先から伝わる「純でないか・stdoutに書くか」だけが変わる）の温のSOBER_SUM_CHECK=1が
#         `cache: summary depends on the cache state: lower`（incrbuildの warm=SUMDEP）
#   m28 = K0からpのソースの要約（γ）を落とす — 鳴らす編集tokshift（関数の前にconstを1つ足し、panicの点の字句の位置だけがずれる）でlowerのK0が
#         同じまま中身（事象の列）が変わり、incrbuildの漏れの見張りが `FAIL k0leak lower`
#   m32 = 束の格納場所の鍵から照合の値（束の仮定）を落とす — 鳴らす編集fnval（strings.HasPrefixの番地取りでstd/stringsの機械語が変わるが
#         K0は同じ — 漏れの見張りが `FAIL k0leak std/strings`）
#   m34 = K0の届く関数の辿りで、本体の中の呼び先を辿らない（pの直の参照だけ — mB14の形）— 鳴らす編集chain-add → chain-edit（app → lower.ChainMid →
#         elf.ChainLeaf。葉の本体の定数だけを変える — ChainMidの要約は変わらず、appのK0が同じまま中身が変わり、漏れの見張りが
#         `FAIL k0leak main`）
#   m33 = K0からpへ写る別のpackageの宣言の要約（desugar.PkgCopyKeys）を落とす — 鳴らす編集cconst-add → cconst-edit（astの文字列と列のconstの中身
#         だけを変える。appが使う側で下ろす — appのK0が同じまま中身が変わり、漏れの見張りが `FAIL k0leak main`）
# 事実の定数化の照合（SOBER_SUM_CONST=check — lower/sumconst.sober。incrbuildの温が FAIL const で落とす）:
#   m38 = やり直しの周で、外れの集合の package も事前の候補を引く（周の数の有界性の前提を壊す）— 鳴らす編集addr-add（上からの事実の仮定が外れた
#         束を毎周同じ枠で引き直して外れに足し、周の数の上限の panic — warm=EXIT）
#   m39 = やり直しで外れの集合を足さない — 鳴らす編集addr-add（上からの事実の仮定が外れた束を毎周同じ枠で引き、周の数の上限の panic — warm=EXIT）
#   m40 = 模擬用の列（bxSim）に相手の名前の代わりに記録の番号を書く — 鳴らす編集listat-sem（下のpackageの本体の編集で、当たった束の関数の
#         記録の番号がずれる。正準形は安定な鍵なので漏れの見張りは鳴らず、模擬用の列の照合が `FAIL replay`）
#   m41 = 束の綴りの表に大域の安定な鍵の代わりに記録の番号を書く — 鳴らす編集listat-sem（同上 — 綴りの表の照合が `FAIL replay`）
#   m37 = regionFlowの読む道が、要約の事実の「呼び手の深度で確保しうるか」を違うビットから読む — 鳴らす編集none（全部の束が当たり、読んだ値が本体から求めた値と違う）
#   m42 = regionLightの前の事実の読む道（bxCRlent）が「入口でregionに入るか」と「戻りうるか」を取り違える — 鳴らす編集none（同上）
#   m43 = optPreの後の事実の読む道（bxCOpre）がP0'の形を常に偽と読む — 鳴らす編集none（同上 — 自己のP0'の対象の関数で食い違う）
# 要約の値を使うモード（束を使うビルドの既定 — 照合しない。incrbuildの use のビルド〔温の照合のビルドの前の格納場所の写しで回す〕が基準のELFと
# 違うか、当たった package が照合のビルドより少なければ FAIL use）。当たった package の関数は本体を下ろさないので、読み違えが出力に出るのは
# 外れの呼び手だけ — 鳴らす編集は外れの package を作る dead（lower だけが外れる）か、読む呼び手のある編集:
#   m44 = regionLightの呼び手が読む要約の値（rlOpenRet）の「入口でregionに入るか」を逆に読む — 鳴らす編集lambda-add（dead では読み違えで判定が変わる呼び手が無い）
#   m45 = P0の種（rfSeed）がregionを使わないかの値の代わりにP0'の形を置く — 鳴らす編集dead
#   m46 = 終端化の種（noret）が「戻らないか」の代わりに「戻りのブロックがあるか」を読む — 鳴らす編集none
#   m47 = 番地を取られるフラグ（bcAddr）が要約の番地取りの相手を印に付けない — 鳴らす編集none（束の仮定の番地取りのビットに落ちてやり直すので
#         ELF は同じ。use のビルドが照合のビルドでやり直さない package を束の仮定でやり直す — FAIL use の REDO）
#   m48 = regionFlowの種（rfSumSeed）が要約の「呼び手の深度で確保しうるか」を逆に読む — 鳴らす編集dead
#   m49 = regionElideの静かかの種（reQuietOpen）が要約の値を逆に読む — 鳴らす編集dead
#   m50 = anchorPruneの種が要約の「anchorを読むか」を逆に読む — 鳴らす編集dead
#   m51 = loopLightの種がmaの代わりにmxを読む — 鳴らす編集dead
#   m52 = 特化の種（spSumVals）が使い道のマークの代わりに引き金のマークを読む — 鳴らす編集dead（引き金のマークの周ごとの値の読み違えは、
#         例題を含む全件でELFに出ない — 周ごとの値の読む道は m56 が照合で見る）
#   m56 = 特化の引き金のマークの周ごとの値の読む道（bxCSprnd）が1周目の値の代わりに中継の前の値を読む — 鳴らす編集none（FAIL const）
#   m59 = 軽い enter の書き換え（rlRewrite）が、rt.region_enter_light を宣言させた事実（BX_RTNEED）を積まない — 鳴らす題材は例題の列（4 本に 1 本・
#         c1_view_keep まで — 格納場所を共有）
#         （本体を捨てた関数が宣言させるはずだった rt の関数が出力から欠ける — FAIL examples/… use）
#   m60 = 純な子の判定（cutPatch）が、本体を捨てた関数の「Serve のプログラム」の旗（rt.netop 5）を束から立てない — 鳴らす題材は例題の列
#         （net_region_mix の1本 — sober_entry の即値が変わる — FAIL examples/net_region_mix.sober use）
#   m61 = 捨てない関数を含む再帰の組でも捨てる — 鳴らす編集none（組の中の不動点が本体と要約の混ざりで変わり、束の仮定に落ちる — FAIL use の REDO）
#   m62 = spec の候補の呼び出しを持つ関数も捨てる — 鳴らす編集none（同上 — 複製の枠の割り当てが変わる）
#   m63 = 模擬の need が、need の中で呼ぶ need の事象も積む（列に別にあるので二重になる）— 鳴らす編集none（束の事象の列が食い違い、捨てた関数の
#         β2 を読めずにやり直す — FAIL use の REDO）
#   m64 = 下ろす実体を要求する関数も捨てる（捨てる単位の規則 (b)）— 鳴らす編集dead（置き場に外れの package がある実体を要求する関数が捨てられ、
#         言語の型の埋まらない仮の記録を下ろそうとする — FAIL use。none では下ろす実体がほかの規則で要求する関数ごと下ろされ、鳴らない）
#   m65 = 記録した置き場を見ない（置き場に外れの package がある実体も捨てる）— 鳴らす編集dead（下ろした後に置き場の増えを見つけてやり直す —
#         FAIL use の REDO）
#   m66 = 再帰型の境界コピーの補助を宣言する関数も捨てる — 鳴らす題材は例題 type_recursive_fnret（補助の記録が欠け、特化が要約の本体を
#         復元できずに panic — FAIL examples/… use）
#   m67 = 組2の葉の極小関数も捨てる — 鳴らす編集dead（葉の一巡が処理の前の本体をコピーし、B2 の呼び先が変わって束の仮定に落ちる — FAIL use の REDO）
#   m68 = 検証モードでも捨てる（bxCSkip が検証モードを見ない）— 鳴らす編集none の検証（検証モードは全部を下ろして比べる — `vfy=DROP`）
#   m69 = 照合のビルド（SOBER_SUM_CONST=check）でも要約の値を使い、捨てる — 鳴らす編集none（照合は捨てずに比べる — `FAIL drop`）
# 切り口 F（package の仕上げの値 — D1・loader/fastload.sober）: incrbuild を SOBER_PKG_FIN=1（速い経路）で回す:
#   m75 = 値のソースの鍵（flKey）からファイルの中身のハッシュを落とす — 鳴らす編集listat-sem（ast の本体の編集で古い値が当たる）
#   m76 = 依存の要約から依存の宣言の木のハッシュを落とす（速い経路と全体の経路の両方）— 鳴らす編集alias-flip（ast の別名の向き先が変わっても loader の古い値が当たる）
#   m77 = 組み立て（asmProgram）で dest の下流の旗を足さない — 鳴らす編集fnval（下流が新しく値に使う std/strings の関数の旗が落ちる）
#   m78 = 下流からの optfn の要る組を値の鍵に入れない（flZKey）— 鳴らす編集optfn-site（組なしの値と組ありの値が同じ鍵に書かれる — 検証モードの stale）
# 切り口 panic の行・列の控え（lower/panic.sober の siteLineColsC — BC_PKG）:
#   m79 = 控えの鍵からファイルの中身を落とす — 鳴らす編集shift（字句が同じで行がずれたファイルに古い行・列が当たる — ELF の不一致と検証モードの stale）
# 束の単位の規則 (b) の緩め（展開の組1の実体は要求する関数を1つだけ下ろす — lower/bxsim.sober）:
#   m80 = 型の埋まらない仮の記録を後回しにせず、その場で下ろす（program）— 題材 testdata/incrm80（型の無い記録の下ろしで落ちる — use の失敗）
#   m72 = 投機の package の変わった関数を求めない（bxCSrcChanged が何もしない）— 鳴らす編集listat-sem（ast の上の package が投機の外れで
#         2周目に入る — FAIL use の ROUNDS）
#   m73 = 番地取りの変化を見積もらない（bxCAddrNew を呼ばない）— 鳴らす編集fnval（std/strings の上からの事実が外れて2周目に入る — FAIL use の ROUNDS）
#   m74 = regionFlow の「確保を返しうるか」（rfFreshOf）で、積んだだけでまだ計算していない呼び先を計算の途中（輪）と同じに扱う — 鳴らす題材は
#         http_client_session → web_server_hello（照合のビルドで BX_RFLOW の食い違い — FAIL examples/web_server_hello.sober const）
#   m71 = 展開の組の判定（ilFirst）が、捨てた関数の「処理の前の本体に戻らない利用者の呼び出しがあるか」を要約の展開の事実（ビット3）から読まず、
#         無い本体から求める — 鳴らす題材は testdata/incrm71 の2本の列（std の deflate の写しの package だけが外れて下ろされ、当たった
#         std/binary の MatchLen は捨てる。写しの greedy が longest を展開しなくなり、ELF が変わる — FAIL testdata/incrm71/viacopy cold）
#   m70 = 束に書く β2 の値のバイトを壊す（捨てた関数は β2 の鍵を照合せずに束から取る）— 鳴らす編集none（use の ELF が変わる — FAIL use。
#         検証モードも `cache: stale bundle`）
#   m57 = 束の仮定の自分の分（bxSelfAll）の辺の種類を全部 0（呼び出し）と書く — 鳴らす編集none（本体を下ろさなかった関数の番地取りの辺が落ち、
#         regionFlow の番地を取られるビットが変わる。束の仮定に落ちてやり直すか ELF が変わる — FAIL use）
#   m53 = 純な子の判定の種（cutPatch）が要約の「stdoutに書くか」を逆に読む — 鳴らす編集dead
#   m54 = 展開の種（ilSumSeed）が熱い命令の数の代わりにコピーする時点の大きさを読む — 鳴らす編集dead
#   m55 = 展開の種（ilSumSeed）が展開の入力の本体の代わりに特化の入力の本体（BX_SPPRE）を読む — 鳴らす編集dead
# 鳴らす検査: m1 / m2 = 扉の監査の鍵の感度の検査（SOBER_CACHE_VERIFY=2のckSens — `cache: insensitive key …`）。呼び手のIRは呼び先の署名と
# cfg に追従して変わる（呼び先の戻りの型・mut 仮引数が変われば呼び手の呼び出しの形が変わる）ので、編集の列では鍵の冗長に隠れて鳴らない —
# 成分が鍵に混ざっていることを直に見る。m3〜m6 = incrbuildの自己のチェーン（scripts/incrbuild.sh — 当てる編集だけの短い列・温のELFの割れか
# 検証モードの `cache: stale entry … @<関数>`）
# 使い方: scripts/incrmut.sh [m1 … m6]（既定は全部）・INCR_PAR = 同時に回すミュータントの数（既定5）
#   scripts/incrmut.sh --memo-selftest   ミュータント単位の記録の鍵の感度の検査（数秒 — 下の「ミュータント単位の記録」）
# ミュータント単位の記録（柱3 R1）: INCRMUT_MEMO_DIR があれば（gates.sh が記録の再利用の有効な回 = レベル1・2・--gate にだけ渡す。冷のレベル3・4と
# --no-cache では渡さない）、caught の判定をミュータントごとの鍵で記録し、同じ鍵のミュータントは検査を走らせずに記録の判定を出す。
# 鍵 = 焼くコンパイラのビルドの入力（変異を当てた木の中身 + stage2 のハッシュ）‖ 題材の木（src/compiler + src/std の中身）‖ 道具（この本文からミュータントの定義の行を除いた残り・
# incrbuild.sh・incrcheck.sh と、それらが使う scripts）‖ そのミュータントの定義の行（case の札にその名前がある行）‖ 定義の行が言及する
# examples / testdata の中身 ‖ SOBER_* と INCR_* の環境。検査の道具と題材がコンパイラ全体なので、コンパイラか std が変われば全部が外れる
set -uo pipefail
# 答えの再生は切る（この検査は関数単位キャッシュの当否を見る）
export SOBER_CHECK_REPLAY=0
cd "$(dirname "$0")/.."
ROOT=$PWD
scripts/stage2.sh --quiet || exit 1
S2=$ROOT/out/stage2/sober2
# 作業の置き場は木のout/tmp（ディスク）に置く。木と格納場所が1回で数GBになり、/tmp（tmpfs）ではメモリを使う。out/はリポジトリの管理の外
mkdir -p "$ROOT/out/tmp"
W=$(mktemp -d "$ROOT/out/tmp/incrmut.XXXXXX")
trap 'rm -rf "$W"' EXIT
ulimit -s unlimited
# gatesのSOBER_VERIFY=each（ステージごとのIRの検証器）はキャッシュのパスに入らない — 検査はキャッシュのパスそのものを見るので外す
unset SOBER_SELF_KEY SOBER_VERIFY
MS=("$@")
selftest=0
[ "${1:-}" = --memo-selftest ] && { selftest=1; MS=(); }
[ "${#MS[@]}" = 0 ] && MS=(m1 m2 m3 m4 m5 m6 m27 m24 m25 m26 m7 m8 m10 m11 m12 m13 m14 m15 m17 m18 m19 m20 m21 m23 m28 m29 m30 m31 m32 m33 m35 m36 m37 m38 m39 m40 m41 m42 m43 m44 m45 m46 m47 m48 m49 m50 m51 m52 m53 m54 m55 m56 m57 m59 m60 m61 m62 m63 m64 m65 m66 m67 m68 m69 m70 m71 m72 m73 m74 m75 m76 m77 m78 m79 m80)
fail=0
# ミュータントを当てる（$1 = ミュータント・$2 = 木のcompiler/）。当たらなければ1
mutate() {
    local T=$2 f
    case "$1" in
        m1) f=$T/lower/ckey.sober; sed -i 's|^        rt := st.ckt.rs\[i\]$|        rt := 0|' "$f" ;;
        m2) f=$T/lower/ckey.sober; sed -i 's|c1: h\[0\], c2: h\[1\]|c1: 0, c2: 0|' "$f" ;;
        m3) f=$T/lower/ckey.sober; sed -i 's|^            cb := ckIdx(cuts, fr\[k\]) + 1$|            cb := 0|' "$f" ;;
        m4) f=$T/lower/ckey.sober; sed -i 's|, cb), st.xAddr\[k\]), r|, cb), 0), r|; s|^                bit := st.xAddr\[xIndex(fr, table.Get(mut st.ckk, j))\]$|                bit := 0|' "$f" ;;
        m5) f=$T/lower/ckey.sober; sed -i 's|, pass), xs\[k + 1\]))$|, pass), 0))|' "$f" ;;
        m24) f=$T/lower/ckey.sober; sed -i 's|^        if drop\[k\] {$|        if false \&\& drop[k] {|' "$f" ;;
        m25) f=$T/lower/ckey.sober; sed -i 's|^    if stage == 1 \&\& ubm {$|    if false \&\& ubm {|' "$f" ;;
        m26) f=$T/lower/ckey.sober; sed -i 's|^    if stage == 1 \&\& ubm {$|    if stage == 1 {|' "$f" ;;
        m6) f=$T/app/main.sober; sed -i 's|^    gen := string(k\[0:16\]) catch return ""$|    gen := "0000000000000000"|' "$f" ;;
        m28) f=$T/lower/bundle.sober; sed -i 's|ky\[2\]), ky\[3\]), xs\[2 \* q\])|0), 0), xs[2 * q])|' "$f" ;;
        m29) f=$T/lower/bundle.sober; sed -i 's|^            cs := if st.bcCl\[fr\[i\]\] != nil { cs0 } else { bxCallsIr(mut st, f) }$|            cs := bxCallsIr(mut st, f)|' "$f" ;;
        m30) f=$T/lower/bundle.sober; sed -i 's|^        ws := \[\]int{sh\[2 \* i\], sh\[2 \* i + 1\], st.xAddr\[i\], tp.td\[i\], cb, |        ws := []int{sh[2 * i], sh[2 * i + 1], 0, 0, 0, |; /^func bxTop(/,/^}$/s|^                bit := st.xAddr\[xIndex(fr, table.Get(mut st.ckk, j))\]$|                bit := 0|' "$f" ;;
        m35) f=$T/lower/bundle.sober; sed -i 's|, cb, tp.ic\[2 \* i\], tp.ic\[2 \* i + 1\]}$|, cb, 0, 0}|' "$f" ;;
        m36) f=$T/lower/bundle.sober; sed -i 's|^    mut h1 := ckM1(ckM1(CK_S1, BX_TOPTAG), tp.ra\[0\])$|    mut h1 := ckM1(ckM1(CK_S1, BX_TOPTAG), 0)|; s|^    mut h2 := ckM2(ckM2(CK_S2, BX_TOPTAG), tp.ra\[1\])$|    mut h2 := ckM2(ckM2(CK_S2, BX_TOPTAG), 0)|' "$f" ;;
        m31) f=$T/lower/bundle.sober; sed -i 's|xs\[2 \* q + 1\]), r1), d1)|xs[2 * q + 1]), 0), d1)|; s|xs\[2 \* q + 1\]), r2), d2)|xs[2 * q + 1]), 0), d2)|' "$f" ;;
        m34) f=$T/lower/bundle.sober; sed -i 's|^                            if walk {$|                            if false {|' "$f" ;;
        m33) f=$T/lower/bundle.sober; sed -i 's|xs\[2 \* q\]), xs\[2 \* q + 1\])|0), 0)|' "$f" ;;
        m38) f=$T/lower/bundle.sober; sed -i "s|^                        if !s6 \&\& kok \&\& len(ky) == 6 {$|                        if kok \&\& len(ky) == 6 {|" "$f" ;;
        m39) f=$T/lower/lower.sober; sed -i "s|^    for q <- r.add {$|    for q <- ms {|" "$f" ;;
        m40) f=$T/lower/bundle.sober; sed -i 's|^    bxSimBytes(mut sb, nms\[k\])$|    bxSimInt(mut sb, r)|' "$f" ;;
        m41) f=$T/lower/bundle.sober; sed -i 's|^                bxRef(mut h, t, g)$|                h = append(h, g)\n                h = append(h, 0)|' "$f" ;;
        m37) f=$T/lower/sumconst.sober; sed -i 's|^    return \[\]int{v\[0\] \& 1, (v\[0\] >> 1) \& 1, |    return []int{v[0] \& 1, (v[0] >> 2) \& 1, |' "$f" ;;
        m42) f=$T/lower/sumconst.sober; sed -i '/^func bxCRlent(/,/^}$/s|{ \[\]int{v\[0\], v\[1\]} }|{ []int{v[1], v[0]} }|' "$f" ;;
        m43) f=$T/lower/sumconst.sober; sed -i '/^func bxCOpre(/,/^}$/s|{ \[\]int{v\[0\], v\[1\]} }|{ []int{v[0], 0} }|' "$f" ;;
        m44) f=$T/lower/rlight.sober; sed -i '/^func rlOpenRet(/,/^}$/s|return v\[0\] == 0 \&\& v\[1\] == 1|return v[0] == 1 \&\& v[1] == 1|' "$f" ;;
        m45) f=$T/lower/opt.sober; sed -i '/^func rfSeed(/,/^}$/s|rec4(mut st, v\[0\], listN(mut st, 0), v\[1\], 0)|rec4(mut st, v[1], listN(mut st, 0), v[1], 0)|' "$f" ;;
        m46) f=$T/lower/noret.sober; sed -i 's|^        unr = append(unr, len(v) > 0 \&\& v\[0\] == 1)$|        unr = append(unr, len(v) > 0 \&\& v[1] == 1)|' "$f" ;;
        m48) f=$T/lower/rflow.sober; sed -i 's|^            atCaller\[kx\] = (v\[0\] >> 1) \& 1 == 1$|            atCaller[kx] = (v[0] >> 1) \& 1 == 0|' "$f" ;;
        m49) f=$T/lower/rlight.sober; sed -i 's|^            qm\[int(g)\] = if v\[0\] == 1 { 1 } else { 2 }$|            qm[int(g)] = if v[0] == 1 { 2 } else { 1 }|' "$f" ;;
        m50) f=$T/lower/rlight.sober; sed -i '/^func anchorPruneModule(/,/^}$/s|^            if v\[0\] == 1 {$|            if v[0] == 0 {|' "$f" ;;
        m51) f=$T/lower/rlight.sober; sed -i 's|^            va\[k\] = sv\[k\] \& 1 == 1$|            va[k] = (sv[k] >> 1) \& 1 == 1|' "$f" ;;
        m52) f=$T/lower/spec.sober; sed -i 's|^    return \[\]int{v\[0\], r\[0\], r\[1\], r\[2\], v\[1\]}$|    return []int{v[1], r[0], r[1], r[2], v[1]}|' "$f" ;;
        m56) f=$T/lower/sumconst.sober; sed -i '/^func bxCSprnd(/,/^}$/s|\[\]int{v\[0\], v\[1\], v\[2\]}|[]int{v[0], v[0], v[2]}|' "$f" ;;
        m59) f=$T/lower/rlight.sober; sed -i 's|^    bxFact(mut st, f, BX_RTNEED, int(st.rtRenterL), 0, 0)$|    _ = 0|' "$f" ;;
        m60) f=$T/lower/cancel.sober; sed -i 's|^        if !place \&\& irFnBHead(mut st, f) == -1 \&\& bxCSelfHasRt(|        if false \&\& irFnBHead(mut st, f) == -1 \&\& bxCSelfHasRt(|' "$f" ;;
        m61) f=$T/lower/bxsim.sober; sed -i 's|^            if !kept\[u\] \&\& kc\[sc\[u\]\] != nil {$|            if false {|' "$f" ;;
        m62) f=$T/lower/bxsim.sober; sed -i 's|^        if w == 0 \&\& bxCSelfPart(mut st, p, 5)\[1\] > 0 {$|        if false {|' "$f" ;;
        m63) f=$T/lower/bxsim.sober; sed -i 's|^            st.bx.mute = true$|            st.bx.mute = false|' "$f" ;;
        m64) f=$T/lower/bxsim.sober; sed -i 's|^            if kept\[v\] \&\& !kept\[rq\[p\]\] \&\& (why\[v\] != 4 \|\| rqk\[v\] == nil) {$|            if false {|' "$f" ;;
        m65) f=$T/lower/bxsim.sober; sed -i -e 's|^        if hr\[1\] <= 0 \|\| uc\[u\] != hr\[1\] {$|        if false {|' -e 's|^            if q != nil \&\& ph\[q\] == bxCG(mut st, hr\[0\] + 2 + 2 \* j) \&\& bxCState(mut st, q) == 1 {$|            if true {|' "$f" ;;
        m66) f=$T/lower/bxsim.sober; sed -i 's|^                    why\[u\] = 9$|                    why[u] = 0|' "$f" ;;
        m67) f=$T/lower/bxsim.sober; sed -i 's|^                    if (z \& 3) == 1 \|\| ((z >> 2) \& 1 == 1 \&\& (z \& 3) == 0) {$|                    if (z \& 3) == 1 {|' "$f" ;;
        m68) f=$T/lower/sumconst.sober; sed -i 's|^    return bxCUse(mut st) \&\& !st.bcv.vfy$|    return bxCUse(mut st)|' "$f" ;;
        m69) f=$T/lower/sumconst.sober; sed -i 's|^    return table.Len(mut st.bx.c) > 0 \&\& (table.Get(mut st.bx.c, 0) \& 3) == 2$|    return table.Len(mut st.bx.c) > 0 \&\& (table.Get(mut st.bx.c, 0) \& 2) == 2|' "$f" ;;
        m70) f=$T/lower/bundle.sober; sed -i '/^                for x <- v {$/{n;s|^                    out = append(out, x)$|                    out = append(out, byte(int(x) ^ 1))|}' "$f" ;;
        m72) f=$T/lower/sumconst.sober; sed -i "/^func bxCSrcChanged(/,/^}\$/s|^    w := bxCIdxLast(mut st, q, fg)\$|    if q >= 0 {\\n        return\\n    }\\n    w := bxCIdxLast(mut st, q, fg)|" "$f" ;;
        m73) f=$T/lower/sumconst.sober; sed -i 's|^                if vok \&\& bxCAddrNew(v, va, mut gch) {$|                if false \&\& vok \&\& bxCAddrNew(v, va, mut gch) {|' "$f" ;;
        m75) f=$T/loader/fastload.sober; sed -i 's|^        s = s + "${files\[i\]} ${ka\[i\]} ${kb\[i\]}\\n"$|        s = s + "${files[i]}\\n"|' "$f" ;;
        m76) f=$T/loader/fastload.sober; sed -i 's| ${vals\[l\].stubA} ${vals\[l\].stubB}\\n"$|\\n"|' "$f"; [ "$(grep -c 'stubA} ${vals\[l\].stubB}' "$f")" = 0 ] || return 1 ;;
        m77) f=$T/loader/pkgasm.sober; sed -i 's|^        tp = append(tp, destPatchByName(t, rq))$|        tp = append(tp, t)|' "$f" ;;
        m78) f=$T/loader/fastload.sober; sed -i 's|^        s = s + "${zr\[i\]} ${zm\[i\]}\\n"$|        s = s + ""|' "$f" ;;
        m79) f=$T/lower/panic.sober; sed -i 's|^        n := len(src)$|        n := 0|' "$f" ;;
        m80) f=$T/lower/lower.sober; sed -i 's|^                later = append(later, fi)$|                funcBody(mut st, fi)?|' "$f" ;;
        m74) f=$T/lower/rflow.sober; sed -i 's|^                        if cj != nil \&\& !isRtF\[cj\] \&\& (frs\[cj\] == -9 \|\| frs\[cj\] == -2) {$|                        if cj != nil \&\& !isRtF[cj] \&\& frs[cj] == -9 {|' "$f" ;;
        m71) f=$T/lower/irinl.sober; sed -i 's|^        v := if len(sv\[i\]) > 0 \&\& irFnBHead(mut st, FnRef(fr\[i\])) == -1 { (sv\[i\]\[2\] >> 3) \& 1 } else if|        v := if false { 0 } else if|' "$f" ;;
        m57) f=$T/lower/bundle.sober; sed -i '/^func bxSelfAll(/,/^}$/{/^                        if code == BX_RFE {$/{n;s|^                            sec = append(sec, table.Get(mut st.bx.ev, at + 4))$|                            sec = append(sec, 0)|}}' "$f" ;;
        m53) f=$T/lower/cancel.sober; sed -i 's|^                us\[cs\[at\]\] = 1 + v\[1\]$|                us[cs[at]] = 2 - v[1]|' "$f" ;;
        m54) f=$T/lower/irinl.sober; sed -i 's|^        hot\[i\] = h\[1\]$|        hot[i] = h[0]|' "$f" ;;
        m55) f=$T/lower/irinl.sober; sed -i 's|^    v := bxCPeek(mut st, g, BX_ILBODY, 0)$|    v := bxCPeek(mut st, g, BX_SPPRE, 0)|' "$f" ;;
        m47) f=$T/lower/bcache.sober; sed -i 's|^                out\[x\] = 1$|                out[x] = 0|' "$f" ;;
        m32) f=$T/lower/bundle.sober; sed -i 's|^                            c2 := ckM2(ckM2(k2, g1), g2)$|                            c2 := k2|' "$f" ;;
        m27) f=$T/app/main.sober; sed -i 's|^    return bytes(v)$|    return bytes("0000000000000000-baked")|' "$f" ;;
        m7) f=$T/desugar/tycanon.sober; sed -i '/^func tyK1(/,/^}$/{s|^            tcW(mut st, hget(mut st, dl + 1 + d \* 2))$|            tcW(mut st, 0)|; s|^            tcW(mut st, hget(mut st, dl + 2 + d \* 2))$|            tcW(mut st, 0)|}' "$f" ;;
        m8) f=$T/desugar/tycanon.sober; sed -i '/^func tyK1(/,/^}$/{s|^    tcW(mut st, s1)$|    tcW(mut st, 0)|; s|^    tcW(mut st, s2)$|    tcW(mut st, 0)|}' "$f" ;;
        m10) f=$T/desugar/tycache.sober; sed -i 's|^    st.nimpl += dnimpl$|    st.nimpl += 0|' "$f" ;;
        m11) f=$T/desugar/parcheck.sober; sed -i 's|^    if gcDlAny(mut st) {$|    if false \&\& gcDlAny(mut st) {|' "$f" ;;
        m12) f=$T/desugar/tycache.sober; sed -i 's|^    return st.ty.kst != 0 \&\& ksAt(mut st, KSGC, pk) \& (GC_SKIP \| GC_AUD) == GC_SKIP$|    return st.ty.kst != 0|' "$f" ;;
        m13) f=$T/loader/pcache.sober; sed -i '/^func pcKey(/,/^}$/{s|^        w := binary.Load64(src, i)$|        w := 0|; s|^        w := int(src\[i\])$|        w := 0|}' "$f" ;;
        m14) f=$T/loader/pcache.sober; sed -i 's|^        ws\[q + 4\] = x.c - p.c$|        ws[q + 4] = 0|; s|p.c + ws\[q + 4\]|0 + ws[q + 4]|' "$f" ;;
        m15) f=$T/desugar/call.sober; sed -i 's|^                luEdge(mut st, hget(mut st, r + 2) - st.ndef)$|                _ = 0|' "$f" ;;
        m17) f=$T/desugar/defkey.sober; sed -i 's/(fnExpands(mut st, g) || lenL(mut st, fnTParams(mut st, g)) > 0)/(false || lenL(mut st, fnTParams(mut st, g)) > 0)/' "$f" ;;
        m18) f=$T/desugar/defcache.sober; sed -i 's|c.ih2\[e\], p.tok - c.slo\[e\]}|c.ih2[e], p.tok}|; s|c.slo\[e\] + off < c.shi\[e\]|off >= 0|; s|tok: c.slo\[e\] + off}|tok: off}|' "$f" ;;
        m20) f=$T/checker/defcache.sober; sed -i 's/if stt\[i\] == 1 \&\& (fl\[i\] \& CF_REJ) != 0 { 2 } else { 1 }/if stt[i] == 1 \&\& (fl[i] \& CF_REJ) != 0 { 1 } else { 1 }/' "$f" ;;
        m23) f=$T/desugar/core_out.sober; sed -i 's|^    if rng.plan.rok != 0 {$|    if false {|' "$f" ;;
        m21) f=$T/checker/defcache.sober; sed -i 's/fl\[rd\] = CF_REJ | (if o.recs\[4\] != 0 { CF_RMISS } else { 0 })/fl[rd] = CF_REJ/' "$f" ;;
        m19) f=$T/desugar/defkey.sober; sed -i '/^                if g >= 0 \&\& g != o {$/{n;n;s|^                    dst = append(dst, g)$|                    dst = append(dst, o)|}' "$f" ;;
    esac
    ! cmp -s "$f" "$W/orig/${f#"$T"/}"
}
# ── ミュータント単位の記録の鍵 ──
MLABEL='^[[:space:]]*(m[0-9]+[|])*m[0-9]+([|]m[0-9]+)*[)]'
# 共通の成分（1回だけ）: 題材の木・道具・環境。$1 = この本文（selftest が差し替える）・$2 = 題材の木の根（既定 = 木）
mcommon() {
    local body=$1 r=${2:-$ROOT}
    {
        echo "incrmut-memo v1"
        ( cd "$r" && find src/compiler src/std -type f -not -path '*/out/*' | LC_ALL=C sort | xargs -d '\n' sha256sum ) | sha256sum
        grep -vE "$MLABEL" "$body" | grep -v '^\[ "${#MS\[@\]}" = 0 \] && MS=(' | sha256sum
        # 共通の本体（札の行の下の検査の行）が言及する examples / testdata の中身（例: m24〜m26 の examples/utf8_bound.sober）
        mfiles "$r" "$(mbody "$body")"
        ( cd "$ROOT" && sha256sum scripts/incrbuild.sh scripts/incrcheck.sh scripts/gatelib.sh scripts/stage2.sh scripts/stagelib.sh scripts/checkverdict.sh scripts/irtext.sh scripts/omit/incrbuild.list )
        env | grep -E '^(SOBER|INCR)_' | grep -v '^INCRMUT_' | LC_ALL=C sort
    } | sha256sum | cut -c1-64
}
# $2 の本文が言及する examples / testdata の題材の中身と、その題材が import・@embed で引く examples / testdata の閉包（$1 = 木の根）。
# testdata は1段目のディレクトリの単位（package の兄弟を引く形を覆う）・examples はファイルかディレクトリのまま。std は題材の木（src/std）で覆う
mnorm() { case "$1" in testdata/*/*) echo "testdata/$(cut -d/ -f2 <<< "$1")" ;; *) echo "${1%/.}" ;; esac; }
mfiles() {
    local r=$1 p q f
    local -A seen=()
    local todo=()
    for p in $(grep -oE '(examples|testdata)/[A-Za-z0-9_./-]*[A-Za-z0-9_-]' <<< "$2" | LC_ALL=C sort -u); do todo+=("$(mnorm "$p")"); done
    while [ "${#todo[@]}" -gt 0 ]; do
        p=${todo[0]}; todo=("${todo[@]:1}")
        [ -n "${seen[$p]:-}" ] && continue
        seen[$p]=1
        echo "$p"
        for f in $(cd "$r" && find "$p" -type f 2> /dev/null | LC_ALL=C sort); do
            ( cd "$r" && sha256sum "$f" )
            case "$f" in *.sober) for q in $(grep -oE '"(examples|testdata)/[^"]+"' "$r/$f" | tr -d '"' | LC_ALL=C sort -u); do todo+=("$(mnorm "$q")"); done ;; esac
        done
    done
}
# 本文から、題材を探す行（ミュータントの札の行・コメント・この下の selftest の関数の中）を除いた行
mbody() { grep -vE "$MLABEL" "$1" | grep -vE '^[[:space:]]*#' | awk '/^memo_selftest\(\) \{$/ { skip = 1 } !skip { print } skip && /^}$/ { skip = 0 }'; }
# ミュータントの鍵: $1 = 共通・$2 = ミュータント・$3 = 焼くコンパイラのビルドの入力のハッシュを書いたファイル・$4 = この本文。MUTMEMO_DROP = 鍵の成分を1つ落とす（selftest の変異 — elf / def / files / common）
mkey() {
    local c=$1 m=$2 elf=$3 body=$4 def p
    def=$(grep -E "$MLABEL" "$body" | grep -E "^[[:space:]]*(m[0-9]+[|])*$m([|]m[0-9]+)*[)]")
    {
        [ "${MUTMEMO_DROP:-}" = common ] || echo "$c"
        echo "$m"
        [ "${MUTMEMO_DROP:-}" = def ] || echo "$def"
        [ "${MUTMEMO_DROP:-}" = elf ] || sha256sum < "$elf"
        [ "${MUTMEMO_DROP:-}" = files ] || mfiles "$ROOT" "$def"
    } | sha256sum | cut -c1-64
}
# 鍵の感度（selftest）: 定義の行・ビルドの入力・言及する題材のファイル・共通の成分のどれを変えても鍵が変わること。MUTMEMO_DROP で成分を落とした鍵の関数では、
# 落とした成分の変更で鍵が変わらない（= 検査が赤になる）ことも確かめる（検査そのものの変異）
memo_selftest() {
    local T=$W/st bad=0 k0 k1 d c0 c1
    mkdir -p "$T"
    cp scripts/incrmut.sh "$T/body"
    printf 'elf-a' > "$T/e1"; printf 'elf-b' > "$T/e2"
    c0=$(mcommon "$T/body")
    # 題材の木の1バイト（写しの木 — 同じ中身なら同じ鍵・src/compiler の1か所で変わる）
    mkdir -p "$T/r/src" "$T/r/examples" "$T/r/testdata"; cp -r src/compiler src/std "$T/r/src/"; cp -r examples/. "$T/r/examples/"; cp -r testdata/. "$T/r/testdata/"
    c1=$(mcommon "$T/body" "$T/r"); [ "$c0" = "$c1" ] || { echo "incrmut memo-selftest: FAIL the same tree in another place gives another common key"; bad=1; }
    cp "$T/r/src/compiler/lower/ckey.sober" "$T/ckey.bak"; printf '\n// x\n' >> "$T/r/src/compiler/lower/ckey.sober"
    c1=$(mcommon "$T/body" "$T/r"); [ "$c0" != "$c1" ] || { echo "incrmut memo-selftest: FAIL a change in src/compiler does not change the common key"; bad=1; }
    cp "$T/ckey.bak" "$T/r/src/compiler/lower/ckey.sober"
    check() { # $1 = 名前・$2 = 変えた側の鍵の計算（eval）— 変わらなければ 1
        local a b
        a=$(mkey "$c0" m24 "$T/e1" "$T/body"); b=$(eval "$2")
        [ "$a" != "$b" ]
    }
    sed 's|^        m24) f=$T/lower/ckey.sober; |        m24) f=$T/lower/ckey.sober; : ; |' "$T/body" > "$T/body2"
    cmp -s "$T/body" "$T/body2" && { echo "incrmut memo-selftest: FAIL the m24 definition line was not found"; bad=1; }
    sed 's|examples/utf8_bound.sober|examples/utf8_bound.sober |' "$T/body" > "$T/body3"
    local cases=("def|mkey \"\$c0\" m24 \"\$T/e1\" \"\$T/body2\"" "elf|mkey \"\$c0\" m24 \"\$T/e2\" \"\$T/body\"" "common|mkey \"\$c1\" m24 \"\$T/e1\" \"\$T/body\"")
    local x nm ex
    for x in "${cases[@]}"; do
        nm=${x%%|*}; ex=${x#*|}
        check "$nm" "$ex" || { echo "incrmut memo-selftest: FAIL a change in the $nm component does not change the key of m24"; bad=1; }
        MUTMEMO_DROP=$nm check "$nm" "$ex" && { echo "incrmut memo-selftest: FAIL dropping the $nm component from the key is not caught"; bad=1; }
    done
    # 共通の本体が言及する題材（m24〜m26 の examples/utf8_bound.sober）: 写しの木で中身を変えると共通の鍵が変わる
    printf '\n// x\n' >> "$T/r/examples/utf8_bound.sober"
    c1=$(mcommon "$T/body" "$T/r"); [ "$c0" != "$c1" ] || { echo "incrmut memo-selftest: FAIL a change in examples/utf8_bound.sober (used by m24) does not change the key"; bad=1; }
    # 定義の行が言及する題材（m71 の testdata/incrm71）: 中身を変えると m71 の鍵が変わり、files を落とした鍵では変わらない
    local R0=$ROOT a b
    a=$(mkey "$c0" m71 "$T/e1" "$T/body")
    f71=$(cd "$T/r" && find testdata/incrm71 -type f | LC_ALL=C sort | head -1); printf '\n// x\n' >> "$T/r/$f71"
    ROOT=$T/r; b=$(mkey "$c0" m71 "$T/e1" "$T/body"); ROOT=$R0
    [ "$a" != "$b" ] || { echo "incrmut memo-selftest: FAIL a change in $f71 does not change the key of m71"; bad=1; }
    ROOT=$T/r; b=$(MUTMEMO_DROP=files mkey "$c0" m71 "$T/e1" "$T/body"); ROOT=$R0
    [ "$b" != "$(MUTMEMO_DROP=files mkey "$c0" m71 "$T/e1" "$T/body")" ] && { echo "incrmut memo-selftest: FAIL dropping the files component from the key is not caught"; bad=1; }
    # ほかのミュータントの定義の行は鍵に入らない（1本の定義を直した回し直しで、ほかが当たる）
    [ "$(mkey "$c0" m25 "$T/e1" "$T/body")" = "$(mkey "$c0" m25 "$T/e1" "$T/body2")" ] || { echo "incrmut memo-selftest: FAIL changing the m24 line changes the key of m25"; bad=1; }
    echo "incrmut memo-selftest: def / elf / common / files each change the key, each dropped component is caught, another mutant's line does not, fail=$bad"
    return $bad
}
if [ "$selftest" = 1 ]; then memo_selftest; exit $?; fi
# 鍵の感度の検査は毎回走らせる（1秒 — 記録を使わない冷の回でも、鍵の関数の退行を日中の回より先に見る）
memo_selftest > "$W/memo-selftest" || { cat "$W/memo-selftest"; echo "incrmut: FAIL the key of the mutant records is not sensitive (scripts/incrmut.sh --memo-selftest)"; exit 1; }
MEMO=${INCRMUT_MEMO_DIR:-}
MCOMMON=""
[ -n "$MEMO" ] && MCOMMON=$(mcommon scripts/incrmut.sh)
mkdir -p "$W/orig"
cp -r src/compiler/. "$W/orig/"
# ミュータント1本（$1）を $W/<ミュータント>/ の中だけで回して判定の行を $W/<ミュータント>.outへ・FAILなら $W/<ミュータント>.failを置く（ミュータントどうしは互いに独立 —
# INCR_PAR 本ずつ並べて回す。既定 5: --full の臨界路の札〔ORDER の先頭〕を縮める — 1 本の山 ≈ 2 GB）
one() {
    local m=$1 D=$W/$1 ec n hit st1 ed vf
    mkdir -p "$D/t"
    cp -r src/compiler/. "$D/t/"
    cp -r src/std "$D/t/std"
    if ! mutate "$m" "$D/t"; then echo "incrmut: FAIL $m: the mutation did not apply (update scripts/incrmut.sh)"; return 1; fi
    # ミュータント単位の記録: 同じ鍵の caught の記録があれば、ビルドも検査も走らせずにその判定を出す。鍵のビルドの成分 = 変異を当てた木の中身 + stage2 の
    # ハッシュ（焼いたコンパイラはこの2つで決まる — ビルドの決定性は stages の固定点と elfeq が見る）
    if [ -n "$MEMO" ]; then
        local key
        { ( cd "$D/t" && find . -type f | LC_ALL=C sort | xargs -d '\n' sha256sum ) | sha256sum; sha256sum < "$S2"; } > "$D/bin.key"
        key=$(mkey "$MCOMMON" "$m" "$D/bin.key" scripts/incrmut.sh)
        echo "$key" > "$W/$m.key"
        if [ -s "$MEMO/$m/$key.out" ]; then
            touch "$MEMO/$m/$key.out" "$W/$m.hit"
            sed "s/$/ [record ${key:0:8}]/" "$MEMO/$m/$key.out"
            rm -rf "$D"
            return 0
        fi
    fi
    ( cd "$D/t" && SOBER_WORKERS=8 "$S2" build app --emit=elf --passes -o "$D/$m" > /dev/null 2> "$D/b.err" ) || { echo "incrmut: FAIL $m: build: $(head -c 300 "$D/b.err")"; return 1; }
    # ビルドした直後の実行ファイルは別のinodeにコピーしてから走らせる（並列のstage2が書いた直後の同じパスのexecがETXTBSYで126になることがある）
    chmod +x "$D/$m" && cp "$D/$m" "$D/$m.x" && mv -f "$D/$m.x" "$D/$m"
    case "$m" in
        m1|m2)
            ( cd "$D/t" && SOBER_CACHE=$D/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=2 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$D/$m" build app --emit=elf --passes -o "$D/o.elf" > /dev/null 2> "$D/r.err" )
            ec=$?
            n=$(grep -c 'cache: insensitive key' "$D/r.err")
            if [ "$ec" != 0 ] && [ "$n" != 0 ]; then echo "incrmut: $m caught — $(grep -m1 'cache: insensitive key' "$D/r.err") (+$((n - 1)) more lines)"
            else echo "incrmut: FAIL $m was not caught (exit $ec, insensitive lines $n)"; return 1; fi
            ;;
        m24|m25|m26)
            # 例題 utf8_bound（印のついた読みを畳む関数がある）を検証 =2 で。x86 の読み出しの計装は無いので終了コードは見ない（特定の行だけを見る）
            local want
            case "$m" in
                m24) want='cache: key depends on a cfg word left out' ;;
                m25) want='does not change the key of a function with marked reads' ;;
                m26) want='changes the key of a function without marked reads' ;;
            esac
            SOBER_CACHE=$D/c SOBER_BUILD_CACHE=1 SOBER_CACHE_VERIFY=2 SOBER_WORKERS=1 SOBER_HASH_SEED=0 "$D/$m" build examples/utf8_bound.sober -o "$D/o.elf" > /dev/null 2> "$D/r.err"
            if grep -q "$want" "$D/r.err"; then echo "incrmut: $m caught: $(grep -m1 "$want" "$D/r.err")"
            else echo "incrmut: FAIL $m was not caught: $(head -c 300 "$D/r.err")"; return 1; fi
            ;;
        m23)
            rm -rf "$D/c"
            SOBER_CACHE=$D/c SOBER_CHECK_CACHE=1 SOBER_CACHE_VERIFY=2 "$D/$m" check examples/closure_field_def.sober > /dev/null 2> "$D/r.err"
            ec=$?
            n=$(grep -c 'cache: door outside' "$D/r.err")
            if [ "$ec" != 0 ] && [ "$n" != 0 ]; then echo "incrmut: $m caught — $(grep -m1 'cache: door outside' "$D/r.err") (+$((n - 1)) more lines)"
            else echo "incrmut: FAIL $m was not caught (exit $ec, door lines $n)"; return 1; fi
            ;;
        m15|m17|m18|m19|m20|m21)
            case "$m" in
                m15) ed="base inst inst-drop" ;;
                m17) ed="base exp exp-rej" ;;
                m18) ed="base body rej rej-pad" ;;
                m19) ed="base callee callee-sig" ;;
                m20) ed="base dlen dlen-pad" ;;
                m21) ed="base dnex dnex-pad" ;;
            esac
            INCR_COMPILER=$D/$m INCR_EDITS="$ed" INCR_VFY="" INCR_SELF_ONLY=1 scripts/incrcheck.sh > "$D/r.out" 2>&1
            ec=$?
            hit=$(grep -E 'warm=DIFF|cache: stale entry' "$D/r.out" | head -2 | tr '\n' ' ')
            if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught — $hit"
            else echo "incrmut: FAIL $m was not caught (exit $ec)"; sed 's/^/  /' "$D/r.out" | head -20; return 1; fi
            ;;
        *)
            local rj="" fs=""
            case "$m" in
                m3) ed="lambda-add pure-flip"; vf="pure-flip" ;;
                m4) ed="addr-add fnval"; vf="fnval" ;;
                m5) ed="panic-add none"; vf="none" ;;
                m6|m27) ed=""; vf="" ;;
                m7) ed="dep-decl"; vf="dep-decl" ;;
                m8) ed="listat-sem optfn-def optfn-site"; vf="listat-sem optfn-site" ;;
                m10) ed="none"; vf="none" ;;
                m11) ed=""; vf=""; fs="examples/task_sleep_deadline.sober examples/net_deadline_spawn.sober" ;;
                m12) ed="none"; vf=""; rj="rej-par rej-freeze" ;;
                m13) ed="listat-sem"; vf="listat-sem" ;;
                m14) ed="none"; vf="none" ;;
                m28) ed="tokshift"; vf="tokshift" ;;
                m29) ed="none"; vf="" ;;
                m30) ed="fnval"; vf="" ;;
                m35) ed=""; vf=""; fs="examples/http_delayed_cut.sober examples/http_wait.sober" ;;
                m36) ed=""; vf=""; fs="examples/task_print_indirect.sober examples/task_sleep_deadline.sober" ;;
                m31) ed="fact-add fact-flip"; vf="" ;;
                m32) ed="fnval"; vf="" ;;
                m33) ed="cconst-add cconst-edit"; vf="" ;;
                m34) ed="chain-add chain-edit"; vf="" ;;
                m37) ed="none"; vf="" ;;
                m38) ed="addr-add"; vf="" ;;
                m39) ed="addr-add"; vf="" ;;
                m40) ed="listat-sem"; vf="" ;;
                m41) ed="listat-sem"; vf="" ;;
                m42|m43|m46) ed="none"; vf="" ;;
                m47) ed="none"; vf="" ;;
                m44) ed="lambda-add"; vf="" ;;
                m45|m48|m49|m50|m51|m52|m53|m54|m55) ed="dead"; vf="" ;;
                m56|m57|m61|m62|m63|m69|m70) ed="none"; vf="" ;;
                m68) ed="none"; vf="none" ;;
                m72) ed="listat-sem"; vf="" ;;
                m73) ed="fnval"; vf="" ;;
                m74) ed=""; vf=""; fs="examples/http_client_session.sober examples/web_server_hello.sober" ;;
                m71) ed=""; vf=""; fs="testdata/incrm71/viastd testdata/incrm71/viacopy" ;;
                m75) ed="listat-sem"; vf="listat-sem" ;;
                m76) ed="alias-def alias-flip"; vf="alias-flip" ;;
                m77) ed="fnval"; vf="" ;;
                m78) ed="optfn-def optfn-site"; vf="optfn-site" ;;
                m79) ed="shift"; vf="shift" ;;
                m80) ed=""; vf=""; fs="testdata/incrm80/main.sober" ;;
                m64|m65|m67) ed="dead"; vf="" ;;
                m66) ed=""; vf=""; fs="examples/type_recursive_fnret.sober" ;;
                m59) ed=""; vf=""; fs="examples/abstraction_dict.sober examples/alias_expanded.sober examples/alias_neg_dup.sober examples/alias_neg_shadow.sober examples/alias_pkg.sober examples/annot.sober examples/assert_outside.sober examples/binary_load64_oob.sober examples/bits.sober examples/block_return.sober examples/borrow_cross_f.sober examples/borrow_mut_count.sober examples/borrow_mut_neg_frozen.sober examples/borrow_mut_store.sober examples/borrow_neg_spawn.sober examples/borrow_pend.sober examples/build_diag_other_decl.sober examples/builder_string.sober examples/builtin_rebind_fn.sober examples/byte_cond.sober examples/byte_mapkey.sober examples/byte_range.sober examples/bytes_scalar.sober examples/c1_view_keep.sober" ;;
                m60) ed=""; vf=""; fs="examples/net_region_mix.sober" ;;
            esac
            SOBER_PKG_FIN=$(case "$m" in m75|m76|m77|m78) echo 1 ;; *) echo 0 ;; esac) INCR_COMPILER=$D/$m INCR_SRC=$D/t INCR_EDITS="$ed" INCR_VFY="$vf" INCR_REJECTS="$rj" INCR_ONLY_FILES="$fs" INCR_SWAP=$([ "$m" = m6 ] || [ "$m" = m27 ] && echo 1 || echo 0) INCR_SELF_ONLY=1 \
                scripts/incrbuild.sh > "$D/r.out" 2>&1
            ec=$?
            hit=$(grep -E 'warm=DIFF|warm=EXIT|warm=SUMDEP|vfy=DIFF|vfy=DROP|FAIL drop|stale=[1-9]|cache: stale entry|cache: bad gamma|cache: parse readback|diag=DIFF|warm=exit0|FAIL examples/|FAIL testdata/|FAIL k0leak|FAIL const|FAIL replay|FAIL use' "$D/r.out" | head -2 | tr '\n' ' ')
            st1=$(grep -m1 'cache: stale entry' "$D/r.out" | sed 's/^ *//')
            if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught — $hit${st1:+ | $st1}"
            else echo "incrmut: FAIL $m was not caught (exit $ec)"; sed 's/^/  /' "$D/r.out" | head -20; return 1; fi
            # checkのパス（タスク2 R4 — analyzerの全部の型付けが γ を読む・checkがparseの木を読み書きする）でも鳴ること: incrcheckの自己のチェーン
            # （bld = 格納場所へbuildして γ を書く）。m10 / m11はcheckのパスでは同値（nimplとDeadlineUseはbuildの検査の歩きだけが読む）
            ed=""
            case "$m" in
                m7) ed="base bld dep-decl"; vf="dep-decl" ;;
                m8) ed="base bld optfn-def bld optfn-site"; vf="optfn-site" ;;
                m12) ed="base bld frz"; vf="base" ;;
                m13) ed="base listat-sem"; vf="listat-sem" ;;
                m14) ed="base none"; vf="none" ;;
            esac
            if [ -n "$ed" ]; then
                INCR_COMPILER=$D/$m INCR_EDITS="$ed" INCR_VFY="$vf" INCR_AUD=- INCR_SELF_ONLY=1 scripts/incrcheck.sh > "$D/c.out" 2>&1
                ec=$?
                hit=$(grep -E 'warm=DIFF|cache: stale entry|readback' "$D/c.out" | head -2 | tr '\n' ' ')
                if [ "$ec" != 0 ] && [ -n "$hit" ]; then echo "incrmut: $m caught on check — $hit"
                else echo "incrmut: FAIL $m was not caught on check (exit $ec)"; sed 's/^/  /' "$D/c.out" | head -20; return 1; fi
            fi
            ;;
    esac
    rm -rf "$D"
}
PAR=${INCR_PAR:-5}
# 空いた幅を借りる（柱3 R2）: gates.sh の中（GATES_WIDTH_FILE がある回）では、ほかのゲートが空けた幅（CPU のスレッドの数）を1本 MUT_W ずつ借りて
# 並びを PAR より増やす。上限 = 空きメモリ（1本 約 2 GB — 床 8 GB を残す）と PAR_MAX。借りた幅は $GATES_WIDTH_FILE.incrmut に書き、gates.sh は
# ほかのゲートを始める判定に足す。並びの数は判定に効かない（ミュータントごとに独立）
MUT_W=2
PAR_MAX=${INCR_PAR_MAX:-16}
par_now() {
    local f a x=0 m
    if [ -n "${GATES_WIDTH_FILE:-}" ] && read -r f _ < "$GATES_WIDTH_FILE" 2> /dev/null; then
        # 空いた幅には自分が借りている分が引かれている — 足し戻してから割る
        x=$(( (f + $(cat "$GATES_WIDTH_FILE.incrmut" 2> /dev/null || echo 0)) / MUT_W ))
        a=$(awk '/^MemAvailable:/ { print int($2 / 1024) }' /proc/meminfo)
        m=$(( (a - 8192) / 2500 + $(jobs -rp | wc -l) - PAR ))
        [ "$x" -gt "$m" ] && x=$m
        [ "$x" -lt 0 ] && x=0
    fi
    [ $((PAR + x)) -gt "$PAR_MAX" ] && x=$((PAR_MAX - PAR))
    [ "$x" -lt 0 ] && x=0
    echo "$x"
}
borrow() { [ -n "${GATES_WIDTH_FILE:-}" ] && echo "$1" > "$GATES_WIDTH_FILE.incrmut"; return 0; }
trap '[ -n "${GATES_WIDTH_FILE:-}" ] && echo 0 > "$GATES_WIDTH_FILE.incrmut"; rm -rf "$W"' EXIT
maxpar=$PAR
for m in "${MS[@]}"; do
    while :; do
        x=$(par_now); n=$(jobs -rp | wc -l)
        [ "$n" -lt $((PAR + x)) ] && break
        wait -n || true
    done
    # 借りている幅 = 並びの PAR を越えた分（始める1本を含めて数える）
    n=$(( $(jobs -rp | wc -l) + 1 )); borrow $(( n > PAR ? (n - PAR) * MUT_W : 0 )); [ "$n" -gt "$maxpar" ] && maxpar=$n
    {
        if one "$m" > "$W/$m.out" 2>&1; then
            # 走らせて caught になったミュータントの判定を記録する（鍵ごとに1ファイル・tmp + rename）
            if [ -n "$MEMO" ] && [ -s "$W/$m.key" ] && [ ! -e "$W/$m.hit" ]; then
                k=$(cat "$W/$m.key"); mkdir -p "$MEMO/$m"
                grep '^incrmut: ' "$W/$m.out" > "$MEMO/$m/.$k.$$" && mv -f "$MEMO/$m/.$k.$$" "$MEMO/$m/$k.out"
            fi
        else
            touch "$W/$m.fail"
        fi
    } &
done
while [ "$(jobs -rp | wc -l)" -gt 0 ]; do wait -n || true; n=$(jobs -rp | wc -l); borrow $(( n > PAR ? (n - PAR) * MUT_W : 0 )); done
borrow 0
for m in "${MS[@]}"; do
    cat "$W/$m.out"
    [ -e "$W/$m.fail" ] && fail=1
done
nhit=$(ls "$W"/*.hit 2> /dev/null | wc -l)
echo "incrmut: ${#MS[@]} mutants, fail=$fail$([ -n "$MEMO" ] && echo " (run $(( ${#MS[@]} - nhit )), from records $nhit)")$([ "$maxpar" -gt "$PAR" ] && echo " (up to $maxpar in parallel with borrowed width)")"
exit $fail
