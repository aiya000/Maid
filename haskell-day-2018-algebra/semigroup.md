### 代数の素朴な定義
# 半群
## (Semigroup)

<aside class="notes">
半群という、
もっと扱いやすい代数を導入します。  
半群については標準ライブラリのData.Semigroupに、
意味的に同じものが定義されています。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

マグマ + **左右どちらから演算して変わらない**

`(x <> y) <> z` = `x <> (y <> z)`

<aside class="notes">
半群はこの性質を満たします。
この性質を満たすことを「結合法則を満たす」と言います。  
結合法則は「左から先に計算しても、右から先に計算しても同じ結果になる」
という意味を持ちます。  
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
半群の定義を見てみます。
->
</aside>

- - - - -

### 代数の素朴な定義 - 半群

```haskell
class Magma a => Semigroup a

instance Semigroup (Sum Integer)
instance Semigroup (Product Integer)
instance Semigroup (Sum Rational)
instance Semigroup (Product Rational)
instance Semigroup [a]
instance Semigroup And
```

<!--

```haskell
instance Semigroup Or
instance Semigroup Xor
instance Semigroup ()
```

-->

<aside class="notes">
マグマと比べ、
特に関数が追加されたりとはないですが、
結合法則を満たすことのマーキングになります。  
Numについては残念ながらFloatやDoubleは丸め誤差によってインスタンスにならないので、
ここでIntegerとRationalに限定にしておきます。  
その他OrとXorやUnitが半群になります。
</aside>

- - - - -

### 代数の素朴な定義 - 半群

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
残念ながらコンピューターの浮動小数点数は実数ではないということです。  
</aside>

- - - - -

### 代数の素朴な定義 - 半群

```hs
class Magma a => Semigroup a

instance Semigroup (Sum Integer)
instance Semigroup [a]
instance Semigroup And
```

`10 + 20 + ...`, `... + 10 + 20`

`[x, y] ++ [z] ++ ...`
`True && False && ...`

<aside class="notes">
半群についてのまとめです。
半群は、
二項演算の左右どちらから演算してもいい、
という代数でした。  
インスタンスはIntegerの足し算と掛け算、
Rationalの足し算と掛け算、
リスト、Andなどがあります。  
では次の代数に移ります。
->
</aside>
