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
package com.fredun.foo;

object Fooish {
  func myInternalFunc() {
    ...
  }
}
```

The `Builtin` object contains the builtins for the language
```
object Builtin {
  /**
   * This is magic!
   */
  foreign func divMod(Int, Int): (Int, Int)
}
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
type XY alias (Int32, Int32)

let xy = (1, 2)
let (x, y) = xy
```

### Tagged product types (records)

```
type Point2D struct {
  x: Int32,
  y: Int32
}

type Point3D[X] struct {
  x: X,
  y: X,
  z: X
}

let p = {x: 1, y: 2}
let {x: Int32, y: Int32} = p

type AtLeast2D[Z] struct {x: Int32, y: Int32, ...Z}

let p2 = {x: 1, y: 2, a: 'foo', b: 'bar'}
let {x: Int32, y: Int32, ...z} = p2
```

(row polymorphism syntax oriented on https://github.com/sebmarkbage/ecmascript-rest-spread)


### Tagged unions (enums)

```
type Points enum {
  case Dim2(Point2D)
  case Dim3({x: Int32, y: Int32, z: Int32})
}
```

(inspired by Swift's enumerations: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)

### Function Types

```
let addXAndY = func(p: Point2D): Int32 = p.x + p.y
```

```
let list = [1,2,3]

func sum(list: List[Int32]): Int32 = match list {
  case Nil: 0
  case Cons(x, xs): x + sum(xs)
}
```

### Type Functions

```
let emptyList[X]: List[X] = new List[X]()
// can be explictly called like this:
emptyList[Int32]
```

```
func head[X](list: List[X]): Option[X] = match list {
  case Nil: Option.none()
  case Cons(x, xs): Option.some(x) 
}
```

### Objects

```
object Foo {
  val bar: Fooish = 42
  
  type Fooish alias Int32
  
  func boozle(x: Fooish): Fooish = bamboozle(x)
  
  private func bamboozle(x: Fooish): Fooish = x + bar
}
```

### Mutability/Side-effects

#### Impure Functions

Impure functions are of type `func!` instead of `func`.
If they are given a name (e.g. in function declarations),
they need to be invoked using the `!` as a suffix.

#### References

```
// works like AtomicReference in Java
// all operations on the ref are impure!
// the function passed to `update` _must_ be pure!

let myMutableNumber: Ref[Int32] = mkRef!(42)

func incrAndGet!(ref: Ref[Int32]): Int32 {
  myMutableNumber.update!(func(x) => x + 1)

  let number = myMutableNumber.read!()
  return number
}
```

#### Channels

```
let myChannel = Channel[Int32].open!()

myChannel.send!(42)
```

### Fancy name

```
class Point2DWithSum(val x: Int32, val y: Int32) {
  func sum() = x + y
}

class Point2DWithMagic(val x: Int32, val y: Int32) {
  func magic() = x * 2 + y * 2
}

func main() {
  let lala = Point2DWithSum(42, 18)
  let theMagic = (lala as Point2DWithMagic).magic()
}
```

something similar to Kotlin's extensions? (https://kotlinlang.org/docs/reference/extensions.html)

alternative:

```
type Sum32[X] interface {
  func sum(x: X): Int32
}

type Magic32[X] interface {
  func magic(x: X): Int32
}

let point2DWithSum: Sum32[Point2D] = {
  func sum(p: Point2D) = p.x + p.y
}

let point2DWithMagic = Magic32[Point2D] = {
  func magic(p: Point2D) = p.x * 2 + p.y * 2
}

// this checks that there are no overlapping behaviours in scope
// for instance, a Sum32[{x: Int32, y: Int32, ...z}] may not co-exist
// with a Sum32[{x: Int32, y: Int32}] or a Sum32[{x: Int32, y: Int32, z: Int32}].
use point2DWithSum as Sum32[Point2D]
use point2DWithMagic as Magic32[Point2D]

func main() {
  let lala = {x:42, y:18}
  let theSum = Sum32.sum(lala)
  let theMagic = Magic32.magic(lala)
}
```
