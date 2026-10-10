# 凍結コーパスの写し（Zig ≡ Sober の照合の入力を凍結時点のまま保つ）

scripts/frozen/*.list の entry のうち、元の例（examples/ 等）を言語の変化に合わせて書き換えたものの、書き換える前の写し。
凍結した Zig 版（stage1）と主の sober の照合は、ここの同じ入力で続ける（照合を弱めない — 決定 16 の α 改名と同じ「同一入力の照合を保つ」原則）。

- examples/errparse・errparse_pure・errparse_file・utf8_pure（2026-10-01、error 網羅 analyzer の E4-d (ii) — ユーザー裁定）:
  元の例は error の switch がリンク集合の全ラベルを覆う形（凍結した Zig 版の規則）で、導出集合の外のラベルの腕を持つ。
  主の sober の analyzer は到達しない腕を拒否するので examples/ の側は腕を消した。ここの写しは消す前の形 — 脱糖・Lean・lower・署名表の照合
  （selfhost_e2e・selfhost_lower・pkgcheck・selfhost_cli の build 側）は凍結前と同じ入力で続く。analyzer を通る selfhost_cli の check の照合だけは
  Zig の受理・主の sober の拒否が正しい意味論の差なので退役（scripts/frozen/cli-check-retired.list）
- testdata/minic・minic_rd（2026-10-02 写し直し — 掃除枠 B G1 の発見・ユーザー裁定）: 350d3cd が写したのは byte の段 S4（08916e1）の後の形だった（凍結時点の形ではない）。
  08916e1^ の形で写し直し、package の import を写しの中（testdata/frozen_src/testdata/minic{,_rd}/…）へ向け直した — 元の import は生きた
  testdata/minic を指し、写しの app だけが凍結時点の形でも依存先が今の言語になっていた。主の sober は旧名の pool を呼ぶので check / lower 側は従来どおり退役
