# Feature Wishlist

General ideas:

- Don't try to be the most cutting-edge function programming language, focus on features that work well together
- Aim to be easily approachable by beginners, but provide enough headroom for "advanced" users
- Rather be explicit about operator (and general syntactic) precendence by requiring grouping (parenthesis) than to have a lot of precedence rules (also avoids having to have an ambiguous grammar, due to the "dangling else problem")
- Identifiers (Unicode XID_Start & XID_Continue)
- Force naming rules? (i.e. enums are all UPPERCASE, function names start with lowercase, class names start with Uppercase...).
  - Crystal does this, but it gets completely broken when using the FFI.
  - It might not even be possible. According to the Unicode site, most scripts don't have case. Testing will be needed to find out if those inside the XID range have case.
- String templating? This means there needs to be a way of converting types to Strings, like the `toString()` Java convention, which might not be desirable (the less conventions, the better?). We can also forcve every type inside the template to be a String.
- Java system of packaging? (i.e. directory structure needs to match the defined package on source files)

## Compilation

- Great, understandable error messages (see Elm)

## Type System

- Strong, sane type system
- Awesome type inference
- Mandate type annotations on top-level functions?
- Support structural and nominal types (Elm and PureScript as examples)
- Parametric Polymorphism (aka Generics)
- Row-type Polymorphism (is not subtyping!)
- Higher-Kinded Types (Bonus item!)
- No type coercion, not even in simple cases like `5 + 1.0`

For inspiration and reference:
- https://github.com/puffnfresh/roy
- https://brianmckenna.org/blog/row_polymorphism_isnt_subtyping
- https://github.com/KMahoney/StrictScript
- https://github.com/sinelaw/infernu/blob/master/docs/type-system.md

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
  - Non-exhaustive matches are a compile error
