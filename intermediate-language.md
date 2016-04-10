## V1

```
(file "foo.fn"
  (package "foo")
  (object "Foo"
    (type "Bar" (type-variable "Int32"))
    (val "thing" (constant (string "random")))
    (fun "hihihoho" "x" (variable "x"))
  )
)

(variable "a")

(constant ...)
(constant (numeric (integer 32 -1)))
(constant (char 'a'))
(constant (boolean false))
(constant (string "foo"))

(abstraction (variable "x") (variable "x"))
(application (abstraction ...) (constant 42))

(operation (binary "+" (constant ...) (constant ...)))
(operation (unary "-" (constant ...)))

(tuple (variable "a") (variable "b"))

(type ...)
(type (type-variable "A"))
(type (tuple (type-variable "A") (type-variable "B")))

(type-annotation (variable "a") "Int")
```

## V2

```
(type-abstraction ...)
(type-application ...)
```
