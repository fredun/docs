# Feature Wishlist

General ideas:

- Don't try to be the most cutting-edge function programming language, focus on features that work well together
- Aim to be easily approachable by beginners, but provide enough headroom for "advanced" users
- Rather be explicit about operator (and general syntactic) precendence by requiring grouping (parenthesis) than to have a lot of precedence rules (also avoids having to have an ambiguous grammar, due to the "dangling else problem")

## Compilation

- Great, understandable error messages (see Elm)

## Type System

- Strong, sane type system
- Awesome type inference
- Mandate type annotations on top-level functions?
- Support structural and nominal types (Elm and PureScript as examples)
- Parametric Polymorphism
- Higher-Kinded Types (Bonus item!)

## Syntax

- Everything (most things, anyway) are expressions:
  - Switch/Pattern matching is an expression
  - If/Then/Else is an expression

- Can opt for block-based or expression-based functions:
  - Block-based uses {} and explicit return
  - Expression-based uses = and implicit return (think parameterised values instead of "functions")

## Data

- Immutability (by default)
- Algebraic Data Types (sum and product types)
