　
# **Semigroupとは？ Monoid？ 環？**
　
### Haskell Day 2018 🤟🙄🤟 aiya000
### https://aiya000.github.io/Maid/haskell-day-2018-algebra

<aside class="notes">
今日は「Semigroupとは？ Monoid？ 環？」ということで、
Haskellでの、
代数という概念についての紹介をさせていただきます。
よろしくお願いします！
</aside>

- - - - -

## 僕
![profile-image](profile.png)

- 名前: aiya000 (あいや)
- Twitter: [pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- GitHub: [aiya000](https://github.com/aiya000)

<aside class="notes">
まずは少しの自己紹介をさせていただきます。
名前は「あいや」と申します。
TwitterとGitHubやらやらで活動をしています。  
じゃあ今日の発表の内容は……
ということで ->
</aside>

- - - - -

# このスライドで
# 学べること

- - - - -

### このスライドで学べること

- 代数の素朴な定義
    - マグマ・**半群**・**モノイド**・**群**
    - 擬環・**環**・**体**

<aside class="notes">
代数の素朴な定義を紹介していきます。  
代数の定義は、
Haskellの型とロジックで記述していきます。  
　  
まず前半はこれらについて、
後半はこれらについて話します。
->
</aside>

- - - - -

### このスライドで学べること

初心者フレンドリーな表現 :relaxed:

<aside class="notes">
今回は精密さ・厳密さよりも、
代数の初心者がわかりやすいような表現を用います。
　  
ここで応用例等の紹介は重視しませんが、
軽く紹介します。  
代数って非常に広く応用されているので、
わざわざ紹介するよりも自身で調べて頂いた方が面白いかな〜と。
->
</aside>

- - - - -

# 本編を始める前に一言

<aside class="notes">
本編を始める前に、最後に一言
</aside>

- - - - -

# 皆さん、安心してください
# この発表中のコードは……

- - - - -

# well-compiledです :sunglasses:

- - - - -

# ここから本編 :point_right:

- - - - -

# 代数の素朴な定義

- - - - -

<!--

```haskell

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module FirstHalf where

import Control.Monad (MonadPlus(..), guard)
import Data.Numbers.Primes (primes)
import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))

```

-->

### 代数の素朴な定義
# マグマ
## (Magma)

<aside class="notes">
一番制約が緩い代数、マグマ。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

**足し算**（あるいは**掛け算**）  
ができる構造

```
x <> y <> z
```

`<>` ← 足し算（あるいは掛け算）

<aside class="notes">
マグマは足し算あるいは掛け算のような、
いわゆる「構造に閉じた」「二項演算」が行えるものです。  
Haskellで書くと…… ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
class Magma a where
    (<>) :: a -> a -> a

instance Magma Int where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`<>` ← aに閉じた（aの上の）二項演算

<aside class="notes">
こんな感じ。
例えばIntやリストがマグマとして挙げられます。
あとは ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
instance Magma Bool where
    (<>) = (&&)

instance Magma Float where
    (<>) = (+)

instance Magma () where
    () <> () = ()
```

`<>` ← aに閉じた（aの上の）二項演算

<aside class="notes">
BoolやFloat、Unitなどなど。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

**閉じた**（**上の**）、**二項演算**？ 🤔

- - - - -

### 代数の素朴な定義 - マグマ

aに閉じた（aの上の）演算とは:

:point_down: このような演算

- `a`の値だけを受け取って
- `a`の値を返す

```
(+) :: Int -> Int -> Int
id  :: Rational -> Rational
```

<aside class="notes">
ここで誤解を恐れず言えば、
Haskellで「演算」とは主に関数のことです。  
なのでaに閉じた演算、aの上の演算とは、
このような関数のことです。  
Intの上の演算+、
Rationalの上の演算idですね。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

二項演算とは: **2引数の演算**

```
(+)       :: Int -> Int -> Int
(:)       :: a -> [a] -> [a]
fromMaybe :: a -> Maybe a -> a
```

<aside class="notes">
二項演算とは。
これはまあ単純で、
2引数の演算のことです。  
これらは二項演算です。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

:ok:
Int上の二項演算
:ok_woman:

```
(+) :: Int -> Int -> Int
```

- - -

:no_good:
二項演算ではない
:ng:

```
id :: Rational -> Rational
```

:no_good:
aにも[a]にも閉じていない
:ng:

```
(:) :: a -> [a] -> [a]
```

<aside class="notes">
ということでまとめです。  
Magma aとはa上の、aに閉じた二項演算を持つ構造です。  
Intはそのような+を持つので、
マグマになれます。  
また、下記の2つは閉じた二項演算ではありません。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

応用例: concatL, concatR

```haskell
concatL :: Magma a => a -> [a] -> a
concatL = foldl (<>)

concatR :: Magma a => a -> [a] -> a
concatR = foldr (<>)
```

その `Magma a` に沿った性質の集約を行う関数 :point_up:

<aside class="notes">
簡素ではありますが、
応用例としてはこのような関数が考えられます。  
例えば先程挙げたIntやFloatなら数の総和を、
Boolなら「全てがTrueであるか否か」を求めます。  
各々の型に対して適宜そのような関数を定義するよりも、
こちらを使った方がわかりやすいですね。
</aside>

- - - - -

# ところで……

- - - - -

## ある型に対してマグマの実装は必ずしも**唯一じゃない**

<aside class="notes">
「ある型に対してマグマの実装は必ずしも唯一じゃない」
んですよね。
例えば ->
</aside>

- - - - -

```
instance Magma Int where
    (<>) = (+)

instance Magma Int where
    (<>) = (*)
```

🤔

<aside class="notes">
Intの足し算も掛け算はどちらもIntについて閉じており、
二項演算でもある。
また ->
</aside>

- - - - -

```
instance Magma Bool where
    (<>) = (||)

instance Magma Bool where
    (<>) = (&&)
```

🤔

<aside class="notes">
Boolについても同様です。  
この「代数は必ずしも型に対して1つだけ定まるわけじゃない」
っていうのは大事なことですね。
ということで ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
-- 和 ↓
newtype Sum a = Sum
    { unSum :: a
    } deriving (Show, Eq)
-- 積 ↓
newtype Product a = Product
    { unProduct :: a
    } deriving (Show, Eq)
```

<aside class="notes">
適宜newtypeを定義してあげて ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
deriving instance Num a => Num (Sum a)
deriving instance Num a => Num (Product a)

instance Num a => Magma (Sum a) where
    (<>) = (+)

instance Num a => Magma (Product a) where
    (<>) = (*)
```

<aside class="notes">
それに対してインスタンスを定義してあげましょう。  
これはGeneralizedNewtypeDerivingとStandaloneDerivingを使った、
IntやFloatの新しいインスタンスで ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
newtype And = And
    { unAnd :: Bool
    } deriving (Show, Eq)

instance Magma And where
    And x <> And y = And $ x && y
```

<aside class="notes">
Boolについても各々のnewtypeを追加していきます。  
Andはこんな感じで、
Orはというと ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
newtype Or = Or
    { unOr :: Bool
    } deriving (Show, Eq)

instance Magma Or where
    Or x <> Or y = Or $ x || y
```

<aside class="notes">
同様にこんな感じ。
Xorも同じく ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
newtype Xor = Xor
    { unXor :: Bool
    } deriving (Show, Eq)

instance Magma Xor where
    Xor True  <> Xor False = Xor True
    Xor False <> Xor True  = Xor True
    _ <> _ = Xor False
```

<aside class="notes">
こうですね。  
Unitについてはインスタンスが唯一つなので、
新しく定義はしません。  
……
ってとこで、まず代数の入りは終了です。  
次は ->
</aside>

- - - - -

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

- マグマであって半群**でない**例
    - Double, Float（浮動小数点数）
    - :point_up: 丸め誤差による制約

<aside class="notes">
コンピューター上の実数の近似である浮動小数点数は半群ではありませんが、
実数は半群になります。
まあコンピューターには真の実数はないので、
ここではインスタンスとして書けませんでした。
</aside>

<!-- 結合法則の最適化 -->
<!-- http://www.kmonos.net/wlog/121.html -->

- - - - -

### 代数の素朴な定義
# モノイド
## (Monoid)

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

- - - - -

<!-- NOTE: 閑話休題のときは高橋メソッドに切り替えてる。 -->
<!-- （そっちのが皆さん、使う頭が変わって休めるかなと思うので） -->

<!--
TODO: 「MonadPlusは高階なモノイド」という主張の妥当性を確認してもらう。
-->

# 閑話休題

- - - - -

# 皆さん

- - - - -

# Monadは
# お好きですか？

- - - - -

# MonadPlus

- - - - -

### 閑話休題 - MonadPlus

MonadPlus = **Monad** + **Monoid**

（ Alternative = **Applicative** + **Monoid** ）

:arrow_down:

MonadPlusは**高階**な**モノイド**

<aside class="notes">
MonadPlusは実は、高階なモノイドです。  
MonadPlusってなんだっけ……？ っていうと ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

リスト内包記（双子素数）

```haskell
twinPrimes :: [(Int, Int)]
twinPrimes = do
    (x, y) <- zip primes (tail primes)
    guard $ y - x == 2
    return (x, y)
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

<aside class="notes">
こんな感じのものでした。  
じゃあ「MonadPlusは高階なMonoid」っていうのはどういうことかというと……
まずは定義を見てみましょう ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

```
class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a
```

<aside class="notes">
これがどのような意味かというと ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

- `MonadPlus (m :: * -> *)`
    - :point_up: 高階 (<code class='no-border'>\* -> \*</code>)
- `mzero`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'>empty</code>
- `mplus`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'><></code>

<aside class="notes">
まずmはこのように高階です。  
次にmzeroとmplusはMonoidのemptyとその二項演算に対応しています。  
例えばMaybeインスタンスなら ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

擬似的に書くなら……

- `Monoid (m :: * -> *)`
    - :arrow_right: <code class='no-border'>instance Monoid Maybe</code>
- `mzero :: m`
    - :arrow_right: <code class='no-border'>Nothing :: Maybe</code>
- `mplus :: m -> m -> m`
    - :arrow_right: <code class='no-border'>Nothing mplus Just = Nothing</code>
    - :arrow_right: <code class='no-border'>Just mplus Just = Just</code>

<aside class="notes">
Type -> Typeへの擬似記法として、このように書けます。
mの任意の型引数aに対してのモノイドという感じ。
</aside>

- - - - -

### 閑話休題 - MonadPlus
## MonadPlusは高階なモノイド

- - - - -

### 閑話休題 - MonadPlus
# こんなところにもモノイドが！！

<aside class="notes">
こんなところにもモノイドは応用されているんだよ、
という例でした。
</aside>

- - - - -

### 代数の素朴な定義
# 群
## (Group)

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `x^-1`

`x^-1 <> x` = `e` = `x <> x^-1`

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `inverse x`

```haskell
inverseLaw :: (Group a, Eq a) => a -> Bool
inverseLaw x =
  (x <> inverse x == empty) && (empty == inverse x <> x)
```

- - - - -

### 代数の素朴な定義 - 群

```haskell
class Monoid a => Group a where
  inverse :: a -> a

instance Group (Sum Integer) where
  inverse = negate

instance Group Xor where
  inverse = id
```

- - - - -

## ん、Xor……？
## さっきまでいた
## Andはどこいった……？

- - - - -

# Andはねぇ
# シンじゃったヨォ
# …… 🤓

- - - - -

### 代数の素朴な定義 - 群

- モノイドであって群**でない**例
    - `And`
    - `Or`
    - `Product Integer`
    - `Product Rational`
    - `[a]`

<aside class="notes">
ってことで。
群の要請する「逆元の存在」っていうのは結構厳しい制約で、
これを満たせない構造は多いです。  
これらが群になれない原因を見てみましょう ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

これらは以下がないので群になれない

- `And`: `False && inverse False == True`な  
  　　　:point_right: `inverse False`

　

- `Or`: `True || inverse True == False`な  
  　　　:point_right: `inverse True`

- - - - -

### 代数の素朴な定義 - 群

これは以下がないので群になれない

- `[a]`: `[x, y] ++ inverse [x, y] == []`な  
  　　　:point_right: `inverse [x, y]`

- - - - -

### 代数の素朴な定義 - 群

- `Product Integer`:   
  　　例えば`10 * 1/10 == 1`だけど  
  　　:point_right: `1/10`はIntegerではない

　

- `Product Rational`:   
  　　一般に`x/y * y/x == 1/1`っぽいけど  
  　　:point_right: `0/10 * 10/0`がゼロ除算

- - - - -

### 代数の素朴な定義 - 群

応用例

- [ElGamal暗号](https://ja.wikipedia.org/wiki/ElGamal%E6%9A%97%E5%8F%B7)
- [楕円曲線暗号](https://ja.wikipedia.org/wiki/%E6%A5%95%E5%86%86%E6%9B%B2%E7%B7%9A%E6%9A%97%E5%8F%B7)

- - - - -

### 代数の素朴な定義 - 群

その他インスタンス

```haskell
instance Group (Sum Rational) where
  inverse = negate

instance Group () where
  inverse () = ()
```

- - - - -

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

- - - - -

# ここで前半戦終わり！

- - - - -

### 代数の素朴な定義
# ここまでのまとめ

- - - - -

### 代数の素朴な定義

| マグマ   | 半群　　　　　　 | モノイド | 群　　　　　 |
|----------|------------------|----------|--------------|
| 　`<>`　 | `(x <> y) <> z`  | `e`　    | `x <> inv x` |
|          | `x <> (y <> z)`  |          | `inv x <> x` |

- - - - -

### 代数の素朴な定義

これまでの形 :point_down:

- より強い代数 = より弱い代数 + 何か  
    - e.g. モノイド = 半群 + 単位元

- - - - -

### 代数の素朴な定義

これからの形 :point_down:

- より強い代数 =
    - より弱い代数 + より弱い代数 + 何か

- - - - -

# というところで
# 早速…… :point_right:

- - - - -

<!--

```haskell
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}

module LastHalf where

import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..))

newtype Sum a = Sum
    { unSum :: a
    } deriving (Show, Eq)

newtype Product a = Product
    { unProduct :: a
    } deriving (Show, Eq)

deriving instance Num a => Num (Sum a)
deriving instance Num a => Num (Product a)

newtype And = And
    { unAnd :: Bool
    } deriving (Show, Eq)

newtype Or = Or
    { unOr :: Bool
    } deriving (Show, Eq)

newtype Xor = Xor
    { unXor :: Bool
    } deriving (Show, Eq)
```

-->

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

- - - - -

<!-- 高橋メソッドで -->

# 閑話休題

- - - - -

# 皆さん

- - - - -

# 写像は好きですか？

- - - - -

# Q. 写像ってなに？

- - - - -

# A. こういうの

<!-- TODO: 集合の写像のイメージを簡単なもので -->

- - - - -

# 半群準同型写像

- - - - -

# モノイド準同型写像

- - - - -

# 群準同型写像

- - - - -

# ところで……

- - - - -

# 自己準同型写像と合成はモノイドになる

- - - - -

# 自己準同型写像と合成はモノイドになる

- 半群A・モノイドA・群Aの準同型写像のうち
- `A -> A` になるようなもの

- - - - -

# 自己準同型写像と合成はモノイドになる

<!-- TODO: 自己準同型写像の簡単なイメージ -->

- - - - -

# 自己準同型写像と合成はモノイドになる

再びモノイドへ……

- - - - -

### 代数の素朴な定義
# 環
## (Ring)

- - - - -

### 代数の素朴な定義 - 環

定義

- - - - -

### 代数の素朴な定義 - 環

つまり

- - - - -

### 代数の素朴な定義 - 環

応用例

- - - - -

### 代数の素朴な定義 - 環

- 擬環であって環でない例
    - ''

- - - - -

### 代数の素朴な定義
# 体
## (Field)

- - - - -

### 代数の素朴な定義 - 体

定義

- - - - -

### 代数の素朴な定義 - 体

つまり

- - - - -

### 代数の素朴な定義 - 体

応用例

- - - - -

### 代数の素朴な定義 - 体

- 環であって体でない例
    - ''

- - - - -

# 今日の内容は
# ここまで！

- - - - -

# お疲れ様でした
# ✋😊

- - - - -

# まとめ

- - - - -

## このスライドで学んだこと

- 代数の素朴な定義
    - マグマ・半群・モノイド・群
    - 擬環・環・体

- - - - -

## このスライドで学んだこと

- プログラミングで応用が盛んな代数
    - マグマ・半群・モノイド

- その他数学で応用が盛んな代数
    - 群・擬環・環・体

（必ずしもこの限りではない🤔）

- - - - -

# おわり

- - - - -

## 宣伝

「今回話したこと + もうちょっとわかりやすい説明」を教えてくれる本
🤟🙄🤟

<!-- TODO: ここにURL -->