//! Sober v0 の PEG 文法（docs/syntax.md 5 節・8 節から起こす）。
//! ルール名は小文字 snake_case（PEG エンジンは大文字始まりをターミナルと解釈する）。
//! syntax.md の production 名 → ここでの名前は CamelCase → snake_case の機械的対応。
//!
//! 範囲: 8 節「fib 部分集合」+ 同節「次に足す順」を 1 コミットずつ。

const decls =
    \\// ── 5.1 ソースファイル・宣言 ──
    \\source_file     <- package_clause ';' (import_decl ';')* top_level_decl* EOF
    \\package_clause  <- 'package' IDENT
    \\import_decl     <- 'import' (import_spec / '(' (import_spec (';' / &')'))* ')')
    \\// 別名のみ。"_" と "." は無い（決定 14）
    \\import_spec     <- IDENT? STR
    \\top_level_decl  <- (annotation ';'?)* (const_decl / func_decl / type_decl / bind_decl) ';'
    \\// 注釈は自分の行に書けるよう、直後の自動挿入 ';' を許す（`@pure` の pure は識別子なので行末で ';' が入る）
    \\annotation      <- '@' IDENT ('(' argument_list? ')')?
    \\// Go の ( ) グループ形は持たない
    \\const_decl      <- 'const' identifier_list '=' expression_list
    \\// トップレベルの束縛は右辺 const 式のみ・mut 不可（決定 14）— パーサでは同じ形、Phase 2 で拒否
    \\bind_decl       <- 'mut'? identifier_list ':=' expression_list
    \\
    \\type_decl       <- 'type' IDENT type_params? type_spec_body
    \\type_params     <- '[' IDENT (',' IDENT)* ']'
    \\// 最後の type は Go の定義型。エイリアス '=' は無い（決定 15）
    \\type_spec_body  <- struct_type / union_type / error_type / func_type annotation* / type
    \\struct_type     <- 'struct' '{' field_list '}'
    \\field_list      <- (field_decl (';' / &'}'))*
    \\// タグなし。注釈は後置
    \\field_decl      <- identifier_list type annotation*
    \\// 閉じた variant。本体はフィールド列のみ、ペイロード無しは `Null {}`（決定 2）
    \\union_type      <- 'union' '{' (variant (';' / &'}'))* '}'
    \\variant         <- IDENT '{' field_list '}'
    \\// 開いた variant（エラーラベル）。`type NotFound error { id int }` / `type Timeout error`
    \\error_type      <- 'error' ('{' field_list '}')?
    \\
    \\func_decl       <- 'func' IDENT type_params? signature block?
    \\signature       <- parameters result?
    \\parameters      <- '(' (parameter_decl (',' parameter_decl)* ','?)? ')'
    \\parameter_decl  <- identifier_list '...'? type / '...'? type
    \\identifier_list <- IDENT (',' IDENT)*
    \\result          <- '(' type (',' type)* ')' / type
    \\
    \\// ── 5.2 型 ──
    \\// 'mut' はコンテナ型（slice / map）の可変マーカー（language.md 22 節 — imm がデフォルト）。
    \\// 他の型に付く 'mut' は AST 層で拒否
    \\type            <- 'mut'? (type_name type_args? / type_lit / '(' type ')') '?'?
    \\// 'error' はキーワードだが型名としても使う（syntax.md 1 節）
    \\type_name       <- IDENT ('.' IDENT)? / 'error'
    \\type_args       <- '[' type (',' type)* ']'
    \\type_lit        <- array_type / slice_type / map_type / func_type / pinned_type
    \\array_type      <- '[' expression ']' type
    \\slice_type      <- '[' ']' type
    \\map_type        <- 'map' '[' type ']' type
    \\func_type       <- 'func' signature
    \\// acquire / get の戻りにのみ現れる
    \\pinned_type     <- '*' type
    \\
;

const statements =
    \\// ── 5.3 文 ──
    \\// Go 仕様: 閉じ '}' の直前ではセミコロンを省ける（&'}' 先読み）
    \\block           <- '{' statement_list '}'
    \\statement_list  <- (statement (';' / &'}'))*
    \\statement       <- declaration / return_stmt / break_stmt / continue_stmt / while_stmt / yield_stmt / defer_stmt / annotated_block / simple_stmt
    \\// @noblock { ... }
    \\annotated_block <- annotation block
    \\// 呼び出し / shield ブロック。式全体をブロック出口で評価（決定 17）
    \\defer_stmt      <- 'defer' expression
    \\// for 本体の字句的内側のみ。単値（決定 4）— 位置の検査は AST 層
    \\yield_stmt      <- 'yield' expression
    \\declaration     <- const_decl / type_decl / bind_decl
    \\return_stmt     <- 'return' expression_list?
    \\break_stmt      <- 'break'
    \\continue_stmt   <- 'continue'
    \\while_stmt      <- 'while' c_expression block
    \\// 代入を先に試す: 左辺を式として読んだ後 assign_op が無ければ式文に落ちる
    \\simple_stmt     <- assignment / expression_stmt
    \\assignment      <- expression_list assign_op expression_list
    \\assign_op       <- '=' / '+=' / '-=' / '*=' / '/=' / '%=' / '&=' / '|=' / '^=' / '<<=' / '>>='
    \\expression_stmt <- expression
    \\expression_list <- expression (',' expression)*
    \\
;

/// 二項階層（Go と同じ。優先順位低 → 高）。
/// 2 系統を生成する: 通常の `expression` と、if / while / switch の条件位置で使う `c_expression`。
/// 条件位置では裸の composite literal `T{...}` を読まない（Go の「条件中の composite literal は
/// 括弧が要る」規則。決定 5）。括弧の中では通常の expression に戻る。
fn exprChain(comptime p: []const u8, comptime primary_alts: []const u8) []const u8 {
    return p ++ "expression   <- lambda / " ++ p ++ "pipe_expr\n" ++
        p ++ "pipe_expr    <- " ++ p ++ "or_expr ('|>' " ++ p ++ "pipe_stage)*\n" ++
        p ++ "pipe_stage   <- " ++ p ++ "postfix_expr\n" ++
        p ++ "or_expr      <- " ++ p ++ "and_expr ('||' " ++ p ++ "and_expr)*\n" ++
        p ++ "and_expr     <- " ++ p ++ "rel_expr ('&&' " ++ p ++ "rel_expr)*\n" ++
        p ++ "rel_expr     <- " ++ p ++ "add_expr (rel_op " ++ p ++ "add_expr)*\n" ++
        p ++ "add_expr     <- " ++ p ++ "mul_expr (add_op " ++ p ++ "mul_expr)*\n" ++
        p ++ "mul_expr     <- " ++ p ++ "unary_expr (mul_op " ++ p ++ "unary_expr)*\n" ++
        p ++ "unary_expr   <- unary_op " ++ p ++ "unary_expr / " ++ p ++ "postfix_expr\n" ++
        p ++ "postfix_expr <- " ++ p ++ "primary_expr " ++ p ++ "postfix*\n" ++
        p ++ "postfix      <- call / selector / index / " ++ p ++ "try\n" ++
        p ++ "primary_expr <- " ++ primary_alts ++ "\n";
}

const expressions =
    \\// ── 5.4 式 ──
    \\// ラムダ（右結合。本体は右へ最大延長）。型は省略可、戻り値型の明示は無い（決定 1）。
    \\// `(a, b) => e` は parameters が「型 a と型 b」とも読める（Go の func(a, b) と同じ）— AST 層で解決
    \\// 本体はブロック優先: `x => { ...; v }` はブロック式（最後の式が値。中の return は囲みの関数から戻る。決定 10）
    \\lambda          <- lambda_params '=>' (block / expression)
    \\lambda_params   <- IDENT / parameters
    \\// パイプ段: PostfixExpr ['?' [CompositeLit]]。'?' は postfix の try として同じ木になり、段の結果に掛かる（決定 5）
    \\// 穴 '_' は識別子として字句解析される（段の呼び出し直下引数に限る規則は AST 層）
    \\rel_op          <- '==' / '!=' / '<' / '<=' / '>' / '>='
    \\add_op          <- '+' / '-' / '|' / '^'
    \\mul_op          <- '*' / '/' / '%' / '<<' / '>>' / '&'
    \\unary_op        <- '-' / '!' / '^'
    \\// 後置 '?': 伝播 `f()?`、包み替え `f()? BadLine{line: n}`（ラベルは必ず { } 付き。決定 5）
    \\// 条件位置では包み替えを読まない（`if x? Label { body }` の Label{ body } を literal にしない。括弧で書く）
    \\try             <- '?' composite_lit?
    \\c_try           <- '?'
    \\// Call の [TypeArgs] は index と同形なので構文では区別しない（f[int](x) は index + call。Go と同じく型検査で解決）
    \\call            <- '(' argument_list? ')'
    \\argument_list   <- argument (',' argument)* ','?
    \\// 名前付き引数は位置引数の後にのみ（決定 7。並びの検査は AST 層）
    \\// `mut x` は mut 引数への参照渡しの印（V3-5: 呼び手の mut ローカル限定）。
    \\// 後続が ',' / ')' のときだけ読む — `mut []T{...}` の composite literal と区別する
    \\argument        <- (IDENT ':')? (mut_arg / expression) '...'?
    \\mut_arg         <- 'mut' IDENT &(',' / ')')
    \\selector        <- '.' IDENT
    \\// スライシング xs[a:b]（imm 限定 — language.md 21 節）。index と同じ後置形
    \\index           <- '[' expression (':' expression)? ']'
    \\operand         <- INT / STR / RAWSTR / IDENT / '(' expression ')'
    \\if_expr         <- 'if' c_expression block ('else' (if_expr / block))?
    \\
    \\// for ジェネレータ式。ジェネレータ間は ';'、ガードは各ジェネレータ直後に任意個（決定 4）
    \\// 束縛の右辺と if ガードは block が続くので条件位置（c_expression）。
    \\// yield の値は '|>' より下の階層で止める: `for ... yield e |> f` の '|>' は for 式全体に掛かる
    \\// （ブロック形 `for ... { } |> f` と同じ結合。yield の中でパイプするなら括弧 — language.md 7 節）
    \\for_expr        <- 'for' generators ('yield' or_expr / block)
    \\generators      <- generator (';' generator)*
    \\generator       <- identifier_list '<-' c_expression ('if' c_expression)*
    \\
    \\// structured concurrency（language.md 11 節）
    \\scope_expr      <- 'parallel'? 'scope' ('(' argument_list ')')? block
    \\spawn_expr      <- 'spawn' expression
    \\shield_expr     <- 'shield' block
    \\// await は std 関数（syntax.md 9 節の裁定）。`await(t)?` は通常の呼び出しとして読まれる
    \\
    \\// switch 式。subject 無しは bool case の if-else 連鎖。初期化文は無い（決定 12）
    \\switch_expr     <- 'switch' c_expression_list? '{' case_clause* '}'
    \\c_expression_list <- c_expression (',' c_expression)*
    \\case_clause     <- ('case' pattern_list / 'default') ':' statement_list
    \\// 多値 subject は 1 値 1 パターン（決定 3）
    \\pattern_list    <- pattern (',' pattern)*
    \\// '_' は識別子として字句解析される（束縛位置の破棄は AST 層で判定）
    \\// `e NotFound{}` 値全体の束縛 + 型パターン（決定 3）→ `NotFound{id}` → 定数（`1 | 2` は選択。決定 3）
    \\pattern         <- IDENT type_pattern / type_pattern / const_pattern
    \\type_pattern    <- type_name '{' (field_pattern (',' field_pattern)* ','?)? '}'
    \\field_pattern   <- IDENT (':' pattern)?
    \\// 定数パターン。subject 無し switch の bool case もここ（`case a > 0:`）。
    \\// `case 1 | 2:` の選択は二項演算の '|' と同じ木になる: AST 層でパターン最上位の '|' 連鎖を
    \\// 選択と解釈する。ビットマスク値として使いたければ括弧 `case (A | B):`
    \\const_pattern   <- c_expression
    \\
    \\// composite literal（Go と同じ。名前付き / 位置フィールド、要素は入れ子の { } 可）。
    \\// 'mut' は可変コンテナの構築（`mut []int{...}` / `mut map[int]int{...}`。language.md 22 節）
    \\composite_lit   <- 'mut'? literal_type literal_value
    \\literal_type    <- type_name type_args? / slice_type / array_type / map_type
    \\literal_value   <- '{' (element_list ','?)? '}'
    \\element_list    <- keyed_element (',' keyed_element)*
    \\keyed_element   <- (key ':')? element
    \\key             <- expression
    \\element         <- literal_value / expression
    \\
;

pub const v0 = decls ++ statements ++ expressions ++
    exprChain("", "if_expr / switch_expr / for_expr / scope_expr / spawn_expr / shield_expr / block / composite_lit / operand") ++
    exprChain("c_", "if_expr / switch_expr / for_expr / scope_expr / spawn_expr / shield_expr / block / operand");

const peg = @import("peg.zig");
pub const compiled = peg.compile(v0);
pub const Matcher = peg.Matcher(compiled);

/// ルール ID → 名前（CST のダンプ・printer 用）
pub fn ruleName(rule_id: u16) []const u8 {
    return compiled.rules[rule_id].name;
}
