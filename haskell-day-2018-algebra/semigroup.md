### 代数の素朴な定義
# 半群
## (Semigroup - Data.Semigroup)

<aside class="notes">
半群という、
もう少し扱いやすくて便利な代数を導入します。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

マグマ + **左右どちらから演算して変わらない**

`(x <> y) <> z` = `x <> (y <> z)`

<aside class="notes">
半群はこの性質を満たします。
この性質を満たすことを「結合法則を満たす」と言います。
Haskellのコードで表すと ->
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

- - -

`(x <> y) <> z` = `x <> (y <> z)`

<aside class="notes">
こうなります。
Eqは便宜上追加してますが、
半群一般に求められるわけではありません。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

```haskell
class Magma a => Semigroup a

instance Semigroup (Sum Integer)     -- 10 + 20
instance Semigroup (Product Integer) -- 10 * 20
instance Semigroup (Sum Rational)
instance Semigroup (Product Rational)
 -- (10%20) + (30%40)
 -- (10%20) * (30%40)
```

<!--

```haskell
instance Semigroup [a]
instance Semigroup And
instance Semigroup Or
instance Semigroup Xor
instance Semigroup ()
```

-->

<aside class="notes">
半群自体の定義はこうなります。  
標準ライブラリのData.Semigroupにあるものを、
便宜上改変をしていますが、
概念上は同じものです。  
　  
マグマと比べ、
特に関数が追加されたりとはないですが、
結合法則を満たすことのマーキングになります。  
Numについては残念ながらFloatやDoubleは丸め誤差によってインスタンスにならないので、
ここでIntegerとRationalに限定にしておきます。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

さっきconcatLとconcatRに分かれてたのが……

```haskell
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
```

```hs
first :: First a -> [First a] -> First a
max   :: max a -> [Max a] -> Max a
```

<aside class="notes">
結合法則を満たすということは、
左右どちらから演算しても結果が同じということなので、
concatLとRが同じものになります。  
このconcatとはつまり、
与えれた要素のうち最初の有効値を返すfirst関数や、
与えれた要素のうち最初の最大値を返すmax関数のことです。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

- 応用例:
    - プログラミング
        - `first :: NonEmpty (First a) -> First a`
        - `max :: NonEmpty (Max a) -> Max a`
        - `(++) :: [a] -> [a] -> [a]`
        - `(&&) :: Bool -> Bool -> Bool`
        - ...etc

<aside class="notes">
結合法則の存在はプログラミングで半群を使うにあたって、
かなり大きいです。  
それによって半群は、
プログラミング自体で扱いやすいインターフェースになっています。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

- マグマであって半群**でない**例
    - Double, Float（浮動小数点数）
    - :point_up: 丸め誤差による制約

<aside class="notes">
コンピューター上の実数の近似である浮動小数点数は半群ではありません。
本物の実数は半群になりますが、
残念ながらコンピューターの浮動小数点数は実数ではないので……。  
というところで、次の代数に移ります。
->
</aside>
