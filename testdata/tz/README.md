# testdata/tz

std/time の地域の規則の取り込み元と網（scripts/tzstore.sh が置く — 手で直さない）。

- `SOURCE`: 出所の銘（IANA の tzdata の版・取得日・tzdata<版>.tar.gz の SHA-256・zic の版）
- `tzif.tar.gz`: tzdata を zic -b slim で組んだ TZif の束（決定的な tar — gate tzsync はこれから src/std/time/zones.sober を作り直して照合する。ネットにも zic にも依らない）
- `links.txt`: 別名の表（tz のソースの Link の行 — `別名 正の名前`）
- `samples.txt`: 照合の表（同じソースを zic -b fat -r 1900〜2100 で全部の遷移に展開した束の、ゾーンごとの抜き取りの時刻のオフセット・夏時間・略称 — std/time の zone_test が読む）
- ライセンス: tz のデータはパブリックドメイン
