### 代数の素朴な定義
# 擬環
## (Rng)

- - - - -

### 代数の素朴な定義 - 擬環

（加法）**可換群** + （乗法）**可換半群**

`x (y <> z)` = `xy <> xz`  
`(x <> y) z` = `xz <> yz`

<aside class="notes">
このような法則を分配法則っていいます。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
distributiveLaw :: (Rng a, Eq a) => a -> a -> a -> Bool
distributiveLaw x y z =
  x >< (y <> z) == x >< y <> x >< z
    &&
  (y <> z) >< x == y >< x <> z >< x
```

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
class Rng a where
    (<>)     :: a -> a -> a
    emptyA   :: a
    inverseA :: a -> a
    (><)     :: a -> a -> a

infixl 6 <>
infixl 7 ><
```

- 加法 :point_right: `<>, emptyA, inverseA`  
- 乗法 :point_right: `><`

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
-- 10 * (20 + 30)  =  (10*20) + (10*30)
--                 =  500
instance Rng Integer where
    (<>)     = (+)
    emptyA   = 0
    inverseA = negate
    (><)     = (*)
```

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
instance Rng Rational where
    (<>)       = (+)
    emptyA     = 0 % 1
    inverseA x = denominator x % numerator x
    (><)       = (*)
```

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
-- True && (False `xor` True)
--      = (True&&False) `xor` (True&&True)
--      = True
instance Rng Bool where
    (<>)     = xor
    emptyA   = False
    inverseA = id
    (><)     = (&&)
```

<!--

```haskell
xor :: Bool -> Bool -> Bool
xor True False = True
xor False True = True
xor _ _ = False
```

-->

- - - - -

### 代数の素朴な定義 - 擬環

い　つ　も　の

```haskell
instance Rng () where
    () <> ()    = ()
    emptyA      = ()
    inverseA () = ()
    () >< ()    = ()
```

- - - - -

### 代数の素朴な定義 - 擬環

- 擬環でない例
    - ''