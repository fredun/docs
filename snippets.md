# Snippets

## Type System

### Primitive Types
 - Unit
 - Boolean
 - [U]Int[8, 16, 32, 64]
 - Float, Double (or Float[32, 64]? or Double[32, 64]?)
 - Array<primitive type> ?
 - Char ?
 - String ?

### Simple product types (tuples)

```
type XY = (Int32, Int32)
```

### Tagged product types (records)

```
type Point2D = {x: Int32, y: Int32}
type Point3D = {x: Int32, y: Int32, z: Int32}
```

### Tagged unions (enums)

```
type Points = {
  case D2: Point2D
  case D3: Point3D
}
```

### Function Types

```
let addXAndY = (p: Point32): Int32 => p.x + p.y
```

```
let sum = (list: List[Int32]): Int32 => match (list) {
  case List.Nil: 0
  case List.Cons(x, xs): x + sum(xs) 
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

alternative:

```
interface Sum32 {
  sum(): Int32
}

interface Magic32 {
  magic(): Int32
}

let point2DWithSum = (p: {x: Int32, y: Int32}): Sum32 => {
  sum: () => x + y
}

let point2DWithMagic = (p: {x: Int32, y: Int32}): Sum32 = {
  magic: () => x * 2 + y * 2
}

func main() {
  let lala = {42, 18};
  let theSum = point2DWithSum(lala).sum();
  let theMagic = point2DWithMagic(lala).magic();
}
```
