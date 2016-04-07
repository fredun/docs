## V1

```
(variable "a")

(constant ...)
(constant (numeric 42))
(constant (char 'a'))
(constant (boolean false))
(constant (string "foo"))

(abstraction (variable "x") (variable "x"))
(application (abstraction ...) (constant 42))

(operation (binary "+" (constant ...) (constant ...)))
(operation (unary "-" (constant ...)))

(tuple (variable "a") (variable "b"))

(type ...)
(type (variable "A"))
(type (tuple (variable "A") (variable "B")))

(type-annotation (variable "a") "Int")
```

## V2

```
(type-abstraction ...)
(type-application ...)
```
