### 代数の素朴な定義
# モノイド

- - - - -

### 代数の素朴な定義 - モノイド

半群 + **単位元** e

`e <> x` = `x` = `x <> e`

- - - - -

### 代数の素朴な定義 - モノイド

半群 + **単位元** empty

```haskell
emptyLaw :: (Monoid a, Eq a) => a -> Bool
emptyLaw x =
  (empty <> x == x) && (x == x <> empty)
```

- - - - -

### 代数の素朴な定義 - モノイド

```haskell
class Semigroup a => Monoid a where
  empty :: a

instance Monoid (Sum Integer) where
  empty = Sum 0

instance Monoid And where
  empty = And True
```

- - - - -

### 代数の素朴な定義 - モノイド

- Sum Integer
    - `0 + _5` = `_5` = `_5 + 0`
    - `0 + _7` = `_7` = `_7 + 0`
    - `0 + 11` = `11` = `11 + 0`

- - - - -

### 代数の素朴な定義 - モノイド

つまり……何？ 🤔

<aside class="notes">
って感じだけど、
ちょっとだけ我慢して応用例を見てみましょう。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

:new: 今回の応用例 :point_down:

```haskell
mconcat :: Monoid a => [a] -> a
mconcat = foldl (<>) empty
```

さっきまでのやつ :point_down:

```
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
```

- - - - -

### 代数の素朴な定義 - モノイド

例えば

```haskell
sum :: [Sum Integer] -> Sum Integer
sum = mconcat
```

- - - - -

### 代数の素朴な定義 - モノイド

例えば

```haskell
all :: [And] -> And
all = mconcat
```

- - - - -

### 代数の素朴な定義 - モノイド

つまりモノイドは……  
**自明な初期値が定まった構造**

- empty = 自明な初期値

- - - - -

### 代数の素朴な定義 - モノイド

その他インスタンス

```haskell
instance Monoid (Product Integer) where
  empty = Product 1

instance Monoid (Product Rational) where
  empty = Product $ 1 % 1

instance Monoid [a] where
  empty = []
```

- - - - -

### 代数の素朴な定義 - モノイド

その他インスタンス

```haskell
instance Monoid (Sum Rational) where
  empty = Sum $ 0 % 1

instance Monoid Or where
  empty = Or False

instance Monoid Xor where
  empty = Xor False
```

- - - - -

### 代数の素朴な定義 - モノイド

その他インスタンス

```haskell
instance Monoid () where
  empty = ()
```

- - - - -

### 代数の素朴な定義 - モノイド

- 半群であってモノイド**でない**例
    - `NonEmpty a`
    - :point_up: 空リストのような単位元がない
