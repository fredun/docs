# Snippets

## Type System

### Structural types (records)

```
type Point2D = {x: Int32, y: Int32}
type Point3D = {x: Int32, y: Int32, z: Int32}
```

### Tagged Unions (enums)

```
enum Points = {
  case D2(Point2D),
  case D3(Point3D)
}
```

### Function Types

```
addXAndY : Point2D -> Int32
addXAndY = (p) => p.x + p.y
```
or:
```
addXAndY = (p: Point32): Int32 => p.x + p.y
```

```
sum = (list: List[Int32]): Int32 => match (list) {
  case List.Nil: 0
  case List.Cons(x, xs): x + sum(xs) 
}
```
