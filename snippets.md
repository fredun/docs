# Snippets

## Type System

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
