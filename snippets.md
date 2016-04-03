# Snippets

## Comments

- Using Markdown / ASCIIDoc or similar

```
// Single line comment
/* Multiline comment */
/** Doc multiline comment */
```

## Module System

- Module names based on file hierarchy? E.g. src/foo/bar/baz.fn is module {projectName}.foo.bar.baz
- Modules as first-class values?
  - Similar to OCaml's functors, C++ templates
  - needs support in the type system
  - we can have functions that consume/return/transform modules (think dependency injection!)

```
module MyModule {
  type MyThing = MyInternalThing
  let myFunc = myInternalFunc
}

type MyInternalThing = {}

let myInternalFunc = () => ...
```

## Type System

### Primitive Types
 - Unit (can be modelled as nullary tuple)
 - Boolean
 - [U]Int[8, 16, 32, 64]
 - Float, Double (or Float[32, 64]? or Double[32, 64]?)
 - Array<primitive type> ?
 - Char ?
 - String ?

### Simple product types (tuples)

```
type XY = (Int32, Int32)

let xy = (1, 2)
let (x: Int32, y: Int32) = xy
```

### Tagged product types (records)

```
struct Point2D {
  x: Int32,
  y: Int32
}

struct Point3D[X] {
  x: X,
  y: X,
  z: X
}

let p = {x: 1, y: 2}
let {x: Int32, y: Int32} = p

struct AtLeast2D {x: Int32, y: Int32, ...z}

let p2 = {x: 1, y: 2, a: 'foo', b: 'bar'}
let {x: Int32, y: Int32, ...z} = p2
let {a: Int32 = x, b: Int32 = y, ...z} = p2
```

(row polymorphism syntax oriented on https://github.com/sebmarkbage/ecmascript-rest-spread)

*TODO:* Biggest problem at the moment, ambiguity between `:` as both a value-type separator and a key-value separator. Elm for instance has `:` as a value-type separator and `=` as a key-value separator. PureScipt has `::` as a value-type separator and `:` as a key-value separator.

### Tagged unions (enums)

```
enum Points {
  case D2(Point2D)
  case D3({x: Int32, y: Int32, z: Int32})
}
```

(inspired by Swift's enumerations: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)

### Function Types

```
let addXAndY = (p: Point2D): Int32 => p.x + p.y
```

```
let sum = (list: List[Int32]): Int32 => match (list) {
  case Nil: 0
  case Cons(x, xs): x + sum(xs) 
}
```

### Type Functions

```
let emptyList[X] = new List[X]()
let emptyList[X: Type] = new List[X]()
```

### Fancy name

```
class Point2DWithSum(val x:Int32, val y:Int32) {
  func sum() = x + y
}

class Point2DWithMagic(val x:Int32, val y:Int32) {
  func magic() = x * 2 + y * 2
}

func main() {
  let lala = Point2DWithSum(42, 18);
  let theMagic = (lala as Point2DWithMagic).magic();
}
```

something similar to Kotlin's extensions? (https://kotlinlang.org/docs/reference/extensions.html)

alternative:

```
behaviour Sum32[X] {
  sum: (x: X) => Int32
}

behaviour Magic32[X] {
  magic: (x: X) => Int32
}

let point2DWithSum: Sum32[Point2D] = {
  sum: (p: Point2D) => p.x + p.y
}

let point2DWithMagic = Magic32[Point2D] = {
  magic: (p: Point2D) => p.x * 2 + p.y * 2
}

// this checks that there are no overlapping behaviours in scope
// for instance, a Sum32[{x: Int32, y: Int32, ...z}] may not co-exist
// with a Sum32[{x: Int32, y: Int32}] or a Sum32[{x: Int32, y: Int32, z: Int32}].
use point2DWithSum as Sum32[Point2D]
use point2DWithMagic as Magic32[Point2D]

func main() {
  let lala = {x:42, y:18};
  let theSum = Sum32.sum(lala);
  let theMagic = Magic32.magic(lala);
}
```
