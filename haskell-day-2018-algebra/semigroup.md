### 代数の素朴な定義
# 半群
## (Semigroup)

<aside class="notes">
半群という、
もう少し便利な代数に入りたいと思います。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

マグマ + **左右どちらから演算して変わらない**

`(x <> y) <> z` = `x <> (y <> z)`

<aside class="notes">
この性質を満たすことを「結合法則を満たす」と言います。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

マグマ + **左右どちらから演算して変わらない**

```haskell
associativeLaw :: (Semigroup a, Eq a) =>
                  a -> a -> a -> Bool
associativeLaw x y z =
  (x <> y) <> z == x <> (y <> z)
```

- - - - -

### 代数の素朴な定義 - 半群

```haskell
class Magma a => Semigroup a

-- 10 + 20   ,   10 * 20
instance Semigroup (Sum Integer)
instance Semigroup (Product Integer)
-- (10%20) + (30%40)   ,   (10%20) * (30%40)
instance Semigroup (Sum Rational)
instance Semigroup (Product Rational)
```

<aside class="notes">
残念ながらFloatやDoubleは丸め誤差によってインスタンスにならないので、
ここでIntegerとRationalに限定にしておきます。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

さっきconcatLとconcatRに分かれてたのが……

```haskell
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
```

<aside class="notes">
結合法則を満たすということは、
左右どちらから演算しても結果が同じということなので、
concatLとRが同じものになります。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

- 応用例:
    - 末尾再帰最適化
    - プログラミング (`Data.Semigroup`)

<!-- TODO: 末尾最適化について詳しく？ -->

- - - - -

### 代数の素朴な定義 - 半群

- マグマであって半群でない例
    - Double, Float（浮動小数点数）
    - 丸め誤差による制約

<aside class="notes">
コンピューター上の実数の近似である浮動小数点数は半群ではありませんが、
実数は半群になります。
まあコンピューターには真の実数はないので、
ここではインスタンスとして書けませんでした。
</aside>

<!-- 結合法則の最適化 -->
<!-- http://www.kmonos.net/wlog/121.html -->
