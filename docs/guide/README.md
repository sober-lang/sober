# User guide

English | [日本語](README.ja.md)

A path for people using Sober for the first time. Read from top to bottom and you will go from installation to writing parallel programs.

1. [Install](install.md) — build the compiler from Zig and source alone
2. [Your first program](first-program.md) — read input and count, split into packages, write tests
3. [Language tour](tour.md) — expressions, functions, collections, types, errors, mut and parallelism, in short working examples
4. [Abstraction — instead of interfaces](abstraction.md) — rewrite other languages' interfaces with function types, structs of functions and unions
5. [Writing tests](testing.md) — add tests to a small package step by step: unit tests, property-based testing, coverage, mutation testing, fuzzing
6. [Standard library guide](std.md) — a map by package
7. [Security guide](security.md) — threat by threat: what Sober removes, how, and what it leaves to you
8. [Environment variables](env.md) — the variables a Sober program reads at run time (the runtime and the standard library)

Every code example in the guide is a real file in `examples/`; the compiler's verification net (`scripts/gates.sh`) builds and runs each one every time and checks the output.

The "why" of the design is in the [design notes](../design-notes/), the exact definition of the language is in the [language specification](../spec/README.ja.md) (rules only), and the history of each decision is in the [decision record](../language.md) (for developers). All are in Japanese.
