# Snippets

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
type Point2D = {x: Int32, y: Int32}
type Point3D = {x: Int32, y: Int32, z: Int32}

let p = {x: 1, y: 2}
let {x: Int32, y: Int32} = p

type AtLeast2D = {x: Int32, y: Int32, ...z}

let p2 = {x: 1, y: 2, a: 'foo', b: 'bar'}
let {x: Int32, y: Int32, ...z} = p2
```

(row polymorphism syntax oriented on https://github.com/sebmarkbage/ecmascript-rest-spread)

*TODO:* Biggest problem at the moment, ambiguity between `:` as both a value-type separator and a key-value separator. Elm for instance has `:` as a value-type separator and `=` as a key-value separator. PureScipt has `::` as a value-type separator and `:` as a key-value separator.

### Tagged unions (enums)

```
type Points = {
  case D2: Point2D
  case D3: {x: Int32, y: Int32, z: Int32}
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
  case Cons (x, xs): x + sum(xs) 
}
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
type Sum32 = {
  sum: () => Int32
}

type Magic32 = {
  magic: () => Int32
}

let point2DWithSum = (p: {x: Int32, y: Int32}): Sum32 => {
  sum: () => x + y
}

let point2DWithMagic = (p: {x: Int32, y: Int32}): Magic32 = {
  magic: () => x * 2 + y * 2
}

func main() {
  let lala = {42, 18};
  let theSum = point2DWithSum(lala).sum();
  let theMagic = point2DWithMagic(lala).magic();
}
```
