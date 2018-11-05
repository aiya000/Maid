### 代数の素朴な定義
# 擬環
## (Rng)

- - - - -

### 代数の素朴な定義 - 擬環

（加法）**可換群** + （乗法）**可換半群**

`x (y <> z)` = `xy <> xz`  
`(x <> y) z` = `xz <> yz`

<aside class="notes">
擬環は可換群と可換半群の組み合わせです。
この2つの式は「分配法則」っていいます。
分配法則をHaskellのコードで表すと ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
distributiveLaw :: (Rng a, Eq a) =>
                   a -> a -> a -> Bool
distributiveLaw x y z =
  x >< (y <> z) == x >< y <> x >< z
    &&
  (x <> y) >< z == x >< z <> y >< z
```

<aside class="notes">
こんな感じです。
この先っぽが内側に向いている方の二項演算子大なり小なりは、
小なり大なりよりも結合優先度が高いことに注意です。  
改めて擬環の定義をしてみましょう ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

- 加法 :point_right: 群　`(a, <>, emptyA, inverseA)`
- 乗法 :point_right: 半群`(a, ><)`

```haskell
class Rng a where
    (<>)     :: a -> a -> a
    emptyA   :: a
    inverseA :: a -> a
    (><)     :: a -> a -> a

infixl 6 <>
infixl 7 ><
```

<aside class="notes">
ここで「二項演算><・emptyA・inverseA」の組み合わせを加法、
二項演算<>を乗法って言います。
あとは ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

- 加法単位元（**零元**）

```
emptyA :: a
```

- - - - -

### 代数の素朴な定義 - 擬環

つまるところ擬環は……

**分配**をするために  
必要なものを定めたプロトコル🤓

```
2(5 + 2) = 2*5 + 2*2
```

<aside class="notes">
にこにー　にこににー、
になる。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
-- 2 * (5 + 2)  =  2*5 + 2*2
--              =  10 + 4
--              =  14
instance Rng Integer where
    (<>)     = (+)
    emptyA   = 0
    inverseA = negate
    (><)     = (*)
```

<aside class="notes">
足し算についての群が加法、
掛け算についての半群が乗法なので、
加法・乗法という言い回しがストンとくるんじゃないでしょうか。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
instance Rng Rational where
    (<>)       = (+)
    emptyA     = 0 % 1
    inverseA x = denominator x % numerator x
    (><)       = (*)
```

<aside class="notes">
Integerと同じように、
Rationalの定義ができます。
</aside>

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
