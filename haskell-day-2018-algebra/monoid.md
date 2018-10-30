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
- Product Integer
    - `1 * __5` = `__5` = `__5 * 1`
    - `1 * _38` = `_38` = `_38 * 1`
    - `1 * 113` = `113` = `113 * 1`

- - - - -

### 代数の素朴な定義 - モノイド

つまり……何？ 🤔

<aside class="notes">
って感じだけど、
ちょっとだけ我慢して応用例を見てみましょう。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

:point_down: 今回の応用例

```haskell
mconcat :: Monoid a => [a] -> a
mconcat = foldl (<>) mempty
```

:point_down: さっきまでのやつ

```
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
```

- - - - -

### 代数の素朴な定義 - モノイド

例えば

```haskell
sum :: [Integer] -> Integer
sum = mconcat
```

- - - - -

### 代数の素朴な定義 - モノイド

つまり

- - - - -

### 代数の素朴な定義 - モノイド

応用例

- - - - -

### 代数の素朴な定義 - モノイド

- 半群であってモノイドでない例
    - ''
