# ちょっと寄り道 :eyes:

- - - - -

### 代数の素朴な定義
# 可換な代数
## (Abelian)

- - - - -

### 代数の素朴な定義 - 可換な代数

交換法則  
**可換**半群・**可換**モノイド・**可換**群

`x <> y` = `y <> x`

<aside class="notes">
この交換法則を満たす代数を……  
可換半群、あるいはAbelian Semigroup。  
可換モノイド、あるいはAbelian Monoid。  
可換群、あるいはAbelian Groupと言います。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

```haskell
commutativeLaw :: (Abelian a, Eq a) =>
                  a -> a -> Bool
commutativeLaw x y =
  x <> y == y <> x
```

- - - - -

### 代数の素朴な定義 - 可換な代数

```haskell
class Semigroup a => Abelian a

instance Abelian (Sum Integer)
instance Abelian (Product Integer)
instance Abelian (Sum Rational)
instance Abelian (Product Rational)
instance Abelian And
instance Abelian Or
instance Abelian Xor
instance Abelian ()
```

- - - - -

### 代数の素朴な定義 - 可換な代数

応用例

- ユニフィケーションの解法として

```
-- この型付けは妥当か？
1 : ['a', 'b', 'c']
```

出典: [ユニフィケーション - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%A6%E3%83%8B%E3%83%95%E3%82%A3%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)

<aside class="notes">
ユニフィケーションの解法として使われていたのを見たことがあります。
ここでユニフィケーションについて語るとまた時間が必要なので、
割愛させていただきますが、
例えばこんな項の型推論の補助に使われたりします。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

- 半群であって可換半群**でない**例
    - `[a]`
    - :point_up: `[x, y] ++ [z]`等は可換ではないね :eyes:
