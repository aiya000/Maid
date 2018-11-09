# ちょっと寄り道 :eyes:

<aside class="notes">
半群・モノイド・群の全部に関わる話をします。
</aside>

- - - - -

### 代数の素朴な定義
# 可換な代数
## (Abelian)

<aside class="notes">
可換である代数とはなんぞや？
というものです。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

交換法則  
**可換**半群・**可換**モノイド・**可換**群

`x <> y` = `y <> x`

<aside class="notes">
交換法則はこのように、
二項演算の左右を入れ替えても同じ結果になるというものです。  
この性質を「可換である」と言います。  
　  
これを満たす代数を  
可換半群、もしくはAbelian Semigroup。  
可換モノイド、もしくはAbelian Monoid。  
可換群、もしくはAbelian Groupと言います。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

```haskell
commutativeLaw :: (Abelian a, Eq a) =>
                  a -> a -> Bool
commutativeLaw x y =
  x <> y == y <> x
```

<aside class="notes">
交換法則をHaskellで書くと、
このようになります。  
では可換半群の例を見てみます。
->
</aside>

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

<aside class="notes">
足し算と掛け算。  
各Bool演算。  
そしてUnitは可換です。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

応用例

ユニフィケーションの解法として

```hs
-- この型付けは妥当か？
1 : ['a', 'b', 'c']
```

出典: [ユニフィケーション - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%A6%E3%83%8B%E3%83%95%E3%82%A3%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3)

<aside class="notes">
一番興味深い応用として、
ユニフィケーションの解法として使われていたのを見たことがあります。
ここでユニフィケーションについて語るとまた時間が必要なので、
割愛させていただきますが、
例えばこんな項の型推論の補助に使われたりします。
</aside>

- - - - -

### 代数の素朴な定義 - 可換な代数

- 半群であって可換半群**でない**例
    - `[a]`
    - :point_up: `[x, y] ++ [z]`等は可換ではない :eyes:

<aside class="notes">
リストが可換でないのは、
わかりやすいんじゃないかと思います。
</aside>
