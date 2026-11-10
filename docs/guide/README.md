# User guide

English | [日本語](README.ja.md)

A path for people using Sober for the first time. Read from top to bottom and you will go from installation to writing parallel programs.

1. [Install](install.md) — build the compiler from Zig and source alone
2. [Your first program](first-program.md) — read input and count, split into packages, write tests
3. [Language tour](tour.md) — expressions, functions, collections, types, errors, mut and parallelism, in short working examples
4. [Abstraction — instead of interfaces](abstraction.md) — rewrite other languages' interfaces with function types, structs of functions and unions
5. [Concurrency — tasks, channels and domains](concurrency.md) — scopes and child tasks, passing immutable values, channels, failure and death, one state updated from many tasks (domains), and what is promised to be deterministic
6. [Writing tests](testing.md) — add tests to a small package step by step: unit tests, property-based testing, coverage, mutation testing, fuzzing
7. [Standard library guide](std.md) — a map by package
8. [Web client](web-client.md) — calling HTTP APIs with `std/http/client`: one-shot requests, failure labels, carrying cookies as values, streamed bodies and keep-alive sessions
9. [Web server](web-server.md) — serving HTTP with `std/http/server`: routing, where state lives, streaming and SSE, safe cookies, login sessions, TLS, running in production
10. [PostgreSQL](postgres.md) — using a database with `std/pg`: connecting with TLS and SCRAM, statements with the SQL text in a const slot, reading rows, failure labels, transactions, a connection pool
11. [Security guide](security.md) — threat by threat: what Sober removes, how, and what it leaves to you
12. [Environment variables](env.md) — the variables a Sober program reads at run time (the runtime and the standard library)

Every code example in the guide is a real file in `examples/`; the compiler's verification net (`scripts/gates.sh`) builds and runs each one every time and checks the output (only the PostgreSQL examples are built and checked without running, since the net has no database; `scripts/pgoracle.sh` runs them and checks their output).

The "why" of the design is in the [design notes](../design-notes/), the exact definition of the language is in the [language specification](../spec/README.ja.md) (rules only), and the history of each decision is in the [decision record](../language.md) (for developers). All are in Japanese.
