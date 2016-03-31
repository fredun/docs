# Snippets

## Type System

Structural types (records):

```
type Point2D = {x: Int32, y: Int32}
type Point3D = {x: Int32, y: Int32, z: Int32}
```

```
addXAndY : Point2D => Int32
addXAndY = (p) => p.x + p.y
```
or:
```
addXAndY : Point32 => Int32 = (p) => p.x + p.y
```

```
sum : List[Int32] => Int32
sum = (list) => match(list) {
  case List.Nil: 0
  case List.Cons(x, xs): x + sum(xs) 
}
```
