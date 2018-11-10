　
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
->
</aside>

- - - - -

# このスライドで
# 学べること

<aside class="notes">
今日の発表の内容では ->
</aside>

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
　  
ここで応用例等の紹介は重視しませんが、
軽く紹介はします。
->
</aside>

- - - - -

### このスライドで学べること

初心者フレンドリーな表現

<ul class='no-signs'>
    <li>~~精密さ・厳密さ~~</li>
    <li>**わかりやすい表現** :point_left: :relaxed:</li>
</ul>

<aside class="notes">
今回はわかりやすい表現のために、
用語の厳密さや一般的な名称・用法を削っています。
->
</aside>

- - - - -

### このスライドで学べること

今回の話で登場する**型クラス等**  
　  
:point_up: not equal :point_down:  
　  
実在する**標準ライブラリ**

<aside class="notes">
今回の話で登場する型クラス等は、
断りがない限り標準ライブラリにあるものとは定義が異なっていたり、
標準ライブラリに存在するとは限らないことにご留意ください。  
　  
あとはこのスライドに登場するコードの大部分は、
実際にコンパイルが通ることを確認されています。
ご安心ください。
</aside>

- - - - -

# 代数の素朴な定義

<aside class="notes">
では本編の方を、
始めさせていただきます。
</aside>

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
最初は代数って何？ というところから、
一番制約が緩いマグマという代数までを説明します。
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
ある制約を満たす関数を持つ構造です。
Haskellでの定義を見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
class Magma a where
    (<>) :: a -> a -> a
```

<aside class="notes">
Magmaはこの形の関数を持ちます。
次にいくつかの、
マグマのインスタンスを見てみます。
->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
instance Magma Integer where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`10 + 20`, `[x, y] ++ [z]`

<aside class="notes">
Integerとリスト。
あと ->
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

<aside class="notes">
BoolやFloat、Unitなどなどがマグマになれます。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

- `<>` <- <code class='no-border'>a</code>に閉じた二項演算
- `++` <- <code class='no-border'>[a]</code>に閉じた二項演算
- `+` <- <code class='no-border'>Integer</code>に閉じた二項演算

**閉じた**（**上の**）、**二項演算**？ 🤔

<aside class="notes">
これらの関数は「aに閉じた、二項演算」または
「aの上の、二項演算」と呼ばれます。  
「閉じた」「二項演算」とは何かと言うと ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

<code class='no-border'>a</code>に閉じた（<code class='no-border'>a</code>の上の）演算とは:

:point_down: このような演算

- `a`の**値だけを受け取って**
- `a`の**値を返す**

```hs
(+) :: Integer -> Integer -> Integer
id  :: Rational -> Rational
```

<aside class="notes">
まずaに閉じた演算とは、このようなものです。  
　  
ここで誤解を恐れず言えば、
Haskellで「演算」とは主に関数のことです。  
　  
+はIntegerに閉じた演算、
このidはRationalに閉じた演算です。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

二項演算とは: **2引数の演算**

```hs
(+)       :: Integer -> Integer -> Integer
(:)       :: a -> [a] -> [a]
fromMaybe :: a -> Maybe a -> a
```

<aside class="notes">
二項演算についてはまあ単純で、
2引数の関数のことです。
ということで ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

:ok:
Integer上の二項演算
:ok_woman:

```hs
(+) :: Integer -> Integer -> Integer
```

- - -

:no_good:
二項演算ではない
:ng:

```hs
id :: Rational -> Rational
```

:no_good:
aにも[a]にも閉じていない
:ng:

```hs
(:) :: a -> [a] -> [a]
```

<aside class="notes">
まとめます。
マグマが必要とするのは、
閉じた二項演算です。  
+はIntegerに閉じた二項演算です。  
このidはRationalに閉じていますが、
二項演算ではありません。
(:)は二項演算ですが、
閉じた演算ではありません。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```hs
class Magma a where
    (<>) :: a -> a -> a

instance Magma Integer where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`10 + 20 + ...`
`[x, y] ++ [z] ++ ...`

`True && False && ...`
`1.0 + 2.0 + ...`

<aside class="notes">
マグマ全体のまとめです。
マグマとはこのような、
aに閉じた二項演算というものを持つ構造でした。  
つまり何度も値を足し合わせることができるということです。  
　  
例えばIntegerはそのような+によってマグマになります。
リストは++を以てマグマになります。
</aside>

- - - - -

## ある型の複数の
## マグマインスタンスについて

- - - - -

## ある型に対してマグマの実装は必ずしも**唯一じゃない**

<aside class="notes">
「ある型に対してマグマの実装は必ずしも唯一じゃない」
んですよね。
どういう意味かというと ->
</aside>

- - - - -

```hs
instance Magma Integer where
    (<>) = (+)

instance Magma Integer where
    (<>) = (*)
```

🤔

<aside class="notes">
Integerの足し算も掛け算はどちらもIntegerについて閉じており、
二項演算でもあります。
これだとどっちをインスタンスにすればいいか困りますね。
->
</aside>

- - - - -

```hs
instance Magma Bool where
    (<>) = (||)

instance Magma Bool where
    (<>) = (&&)
```

🤔

<aside class="notes">
Boolについても同様です。  
つまり「代数は必ずしも型に対して1つだけ定まるわけじゃない」
ということです。
この解決策として ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
-- 和 ↓
newtype Sum a = Sum
    { unSum :: a
    } deriving (Show, Eq, Enum)
-- 積 ↓
newtype Product a = Product
    { unProduct :: a
    } deriving (Show, Eq, Enum)
```

<aside class="notes">
性質にそぐうnewtypeを定義してあげましょう。
性質にそぐったnewtypeを定義してあげるっていうのは、
Haskellでは時々やりますね。
そして ->
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
IntegerやFloatの新しいインスタンスで ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
newtype And = And Bool deriving (Show, Eq)
newtype Or = Or Bool deriving (Show, Eq)

instance Magma And where
    And x <> And y = And $ x && y
instance Magma Or where
    Or x <> Or y = Or $ x || y
```

<aside class="notes">
Boolについても各々のnewtypeを追加していきます。  
BoolのAndとOrはこう。
同様にXorについて ->
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
こうです。  
Unitについてはインスタンスが唯一つなので、
新しく定義はしません。  
　  
というところで、
代数の導入は完了です。  
次の代数にいきましょう。
->
</aside>

- - - - -

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

- - - - -

### 代数の素朴な定義
# モノイド
## (Monoid)

<aside class="notes">
モノイドって皆さん結構聞いたことあるんじゃないでしょうか。
というのも色んなところに表れる自然な構造だからですね。  
これも同じ意味のものが、標準ライブラリのData.Monoidにあります。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

半群 + **単位元** e

`e <> x` = `x` = `x <> e`

<aside class="notes">
モノイドというのは半群の概念に加えて、
単位元というものを導入したものです。  
この等式は単位元の法則と言って ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

半群 + **単位元** empty

```haskell
emptyLaw :: (Monoid a, Eq a) => a -> Bool
emptyLaw x =
  (empty <> x == x) && (x == x <> empty)
```

- - -

`e <> x` = `x` = `x <> e`

<aside class="notes">
Haskellで書くとこうなります。
二項演算に単位元を左もしくは右から与えても、
他方は変わらない、
というものです。  
また半群と同じくEq制約はモノイドに課されるものではありません。
</aside>

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

<aside class="notes">
定義はこのようになります。  
これも標準ライブラリのものとは便宜上改変をしていますが、
概念上は同じものです。  
　  
Integerと足し算については0、
BoolとAndについてはTrueです。  
例えばこのIntegerについて ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

- Sum Integer
    - `0 + 3` = `3` = `3 + 0`
    - `0 + 5` = `5` = `5 + 0`
    - `0 + 7` = `7` = `7 + 0`

<aside class="notes">
単位元0はこのように、
他方を変えません。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

:new: 応用例

```haskell
mconcat :: Monoid a => [a] -> a
mconcat = foldl (<>) empty
```

:point_down: さっきまでのやつ

```hs
concat :: Semigroup a => a -> [a] -> a
concat = foldl (<>)
```

<aside class="notes">
モノイドはこのようにemptyを適用することで、
自明な初期値を自動で適用します。
例えば ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

例えば

```haskell
sum :: [Sum Integer] -> Sum Integer
sum = mconcat
```

```hs
>>> sum  []
Sum {unSum = 0}

>>> sum [1..9]
Sum {unSum = 45}
```

<aside class="notes">
足し算の総和の初期値は1とか2とかだと異なるので、
0です。
もしくはAndでは ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

例えば

```haskell
all :: [And] -> And
all = mconcat
```

```hs
>>> all []
And {unAnd = True}

>>> all [And True, And True, And True]
And {unAnd = True}
>>> all [And True, And False, And True]
And {unAnd = False}
```

<aside class="notes">
全てがTrueであることを確認する関数allでは、
初期値がFalseだと常にFalseを返すことになってしまうので、
Trueです。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

モノイドは……**自明な初期値**が定まった代数

- empty = 自明な初期値

<aside class="notes">
つまりモノイドは明らかな初期値が定まった代数です。  
……  
では他のインスタンスも見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

```haskell
instance Monoid (Product Integer) where
  empty = Product 1

instance Monoid (Product Rational) where
  empty = Product $ 1 % 1

instance Monoid [a] where
  empty = []
```

<aside class="notes">
掛け算では初期値は1、
リストの連結では空リスト。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

```haskell
instance Monoid (Sum Rational) where
  empty = Sum $ 0 % 1

instance Monoid Or where
  empty = Or False

instance Monoid Xor where
  empty = Xor False
```

<aside class="notes">
Rationalの足し算では初期値は0、
これは0/1とは0のことです。
OrとXorではFalseです。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

その他インスタンス

```haskell
instance Monoid () where
  empty = ()
```

<aside class="notes">
UnitではUnitです。
インスタンスになれない型としては ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

- 半群であってモノイド**でない**例
    - `NonEmpty a` (<code class='no-border'>Data.List.NonEmpty</code>)
    - :point_up: 空リストのような単位元がない
    - `First a`, `Last a` (<code class='no-border'>Data.Monoid</code>)
        - <code class='no-border'>First (Just 10)</code>, <code class='no-border'>Last Nothing</code>

<aside class="notes">
NonEmpty aはモノイドにはなれません。
また、
与えられた値のうち最初のものを返すFirstや、
与えられた値のうち最後のものを返すLastも初期値がありません。
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

```hs
class Semigroup a => Monoid a where
  empty :: a

instance Monoid (Sum Integer) where
  empty = Sum 0

instance Monoid And where
  empty = And True

instance Monoid [a] where
  empty = []
```

`0 + 10`, `10 + 0`

`[] ++ [x, y]`, `[x, y] ++ []`

<aside class="notes">
モノイドについてのまとめです。  
モノイドは二項演算によって他方を変えない値として、
単位元というものが備わる代数した。  
インスタンスにはIntegerの足し算と掛け算、
Rationalの足し算と掛け算、
Boolのandとorとxor、
リストなどがあります。  
じゃあ次の代数にいきます。
->
</aside>

- - - - -

### 代数の素朴な定義
# 群
## (Group)

<aside class="notes">
群という、
けっこう制約が強い代数があります。
群では ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `x^-1`

`x^-1 <> x` = `e` = `x <> x^-1`

<aside class="notes">
その全ての値xについてその逆元、
xのマイナスイチ乗という値が定まります。
この逆元の法則をHaskellで書くと ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `inverse x`

```haskell
inverseLaw :: (Group a, Eq a) => a -> Bool
inverseLaw x =
  (x <> inverse x == empty) &&
  (inverse x <> x == empty)
```

<aside class="notes">
こんな感じ。
xとその逆元を合わせると、
単位元になります。
ということで群の定義は ->
</aside>

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

<aside class="notes">
こうなります。
Monoidにinverseという関数生えてます。  
例えばこのIntegerの足し算は ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `3 + (-3)` = `0`
- `5 + (-5)` = `0`
- `7 + (-7)` = `0`

<aside class="notes">
このように逆元の法則を満たします。
これはけっこう直感的で、
群の性質を理解するのにいいんじゃないかと思います。
Xorインスタンスは ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `True xor True` = `False`
- `False xor False` = `False`

<aside class="notes">
単位元がFalseなので、
このように法則を満たします。
->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- モノイドであって群**でない**例
    - `And`
    - `Or`
    - `Product Integer`
    - `Product Rational`
    - `[a]`

<aside class="notes">
群の要請する「逆元の存在」っていうのは結構厳しい制約で、
これを満たせない構造は多いです。  
これらが群になれない原因を見てみます。
->
</aside>

- - - - -

### 代数の素朴な定義 - 群

これらは以下がないので群になれない

- `And`: `False && inverse False == True`な  
  　　　:point_right: `inverse False`

- `Or`: `True || inverse True == False`な  
  　　　:point_right: `inverse True`

<aside class="notes">
Andの単位元はTrueですが、
片方がFalseだとどうあがいてもFalseに写ってしまうので、
Falseの逆元がありません。  
Orも同様に、
片方がTrueだとどうあがいてもTrueになってしまうので、
Falseには写れません。
</aside>

- - - - -

### 代数の素朴な定義 - 群

これは以下がないので群になれない

- `[a]`: `[x, y] ++ inverse [x, y] == []`な  
  　　　:point_right: `inverse [x, y]`

<aside class="notes">
リストには「逆」という概念が全くないので、
まさに群でない例としてわかりやすいんじゃないかと思います。
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `Product Integer`:   
  　　例えば`10 * 1/10 == 1`だけど  
  　　:point_right: `1/10`はIntegerではない

　

- `Product Rational`:   
  　　一般に`x/y * y/x == 1/1`っぽいけど  
  　　:point_right: `0/10 * 10/0`がゼロ除算

<aside class="notes">
これらは一見、
群になりそうなのですが、
1/10がIntegerから溢れてしまったり、
ゼロ除算が発生してしまったりします。  
ゼロ除算、怖いですね。  
というところで反例については以上です。
</aside>

- - - - -

### 代数の素朴な定義 - 群

応用例

- [ElGamal暗号](https://ja.wikipedia.org/wiki/ElGamal%E6%9A%97%E5%8F%B7)
- [楕円曲線暗号](https://ja.wikipedia.org/wiki/%E6%A5%95%E5%86%86%E6%9B%B2%E7%B7%9A%E6%9A%97%E5%8F%B7)

<aside class="notes">
群やそれ以降の代数は数学的分野で応用されています。  
プログラミングで直に触れることは少ないんじゃないかと思います。
</aside>

- - - - -

### 代数の素朴な定義 - 群

```haskell
instance Group (Sum Rational) where
  inverse = negate

instance Group () where
  inverse () = ()
```

<aside class="notes">
他のインスタンスはこれらがあります。
Unitはいつものやつですね。
</aside>

- - - - -

### 代数の素朴な定義 - 群

```hs
class Monoid a => Group a where
  inverse :: a -> a

instance Group (Sum Integer) where
  inverse = negate

instance Group Xor where
  inverse = id
```

`10 + -10` = `-10 + 10` = `0`

`True xor True` = `False`,
`False xor False` = `False`

<aside class="notes">
群についてのまとめです。  
群aはaの全ての値に対して、
その逆元というものが定まるものでした。  
インスタンスはIntegerとRationalの足し算、
BoolのXor、
Unitがあります。  
逆元の要請はけっこう厳しくて、
インスタンスになれる構造がそう多くありません。  
というところで ->
</aside>

- - - - -

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

- - - - -

### 代数の素朴な定義 - 可換な代数

```hs
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

`10 + 20` = `20 + 10`,
`10 * 20` = `20 * 10`

`True && False` = `False && True`


<aside class="notes">
まとめです。  
二項演算の左右の値を入れ替えても同じ結果を得られるのが、
交換法則、可換というものです。  
多くのインスタンスがありますが、
リストなどはこれを満たしません。
</aside>

- - - - -

# ここで前半戦
# 終わり！

<aside class="notes">
というところで、
代数の基礎のうち基礎の部分は終了です。
まとめてみます。
->
</aside>

- - - - -

### 代数の素朴な定義
# ここまでのまとめ

<aside class="notes">
ここまでのまとめ。
->
</aside>

- - - - -

### 代数の素朴な定義

| マグマ   | 半群　　　　　　 | モノイド | 群　　　　　 |
|----------|------------------|----------|--------------|
| 　`<>`　 | `(x <> y) <> z`  | `e`　    | `x <> inv x` |
|          | `x <> (y <> z)`  |          | `inv x <> x` |

<aside class="notes">
マグマは二項演算を持ち、  
半群は結合法則を持っていました。  
またモノイドは単位元を持ち、  
群は逆元を持っていました。
</aside>

- - - - -

### 代数の素朴な定義

- より強い代数 =
    - より弱い代数 + 何か
- e.g. モノイド =
    - 半群 + 単位元

<aside class="notes">
今まではより弱い代数に、
次々と概念が足されていました。
</aside>

- - - - -

# というところで :point_right:

<aside class="notes">
というところで後半戦、
やっていきましょう。
->
</aside>

- - - - -

<!--

```haskell
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeApplications #-}

module LastHalf where

import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))
import Test.SmallCheck (smallCheck)

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

- - -

分配法則

`x (y <> z)` = `xy <> xz`  
`(x <> y) z` = `xz <> yz`

<aside class="notes">
擬環は可換群と可換半群の組み合わせです。
足し算と掛け算の両方ができるってことですね。  
かつ「分配」ができます。
この分配の法則をHaskellのコードで表すと ->
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

加法: `<>`, 乗法: `><`

<aside class="notes">
こうなります。  
この先っぽが内側に向いている方の二項演算子大なり小なりを加法。
今までもでてきてた先っぽが外側に向いている二項演算を乗法って言います。
乗法は加法よりも結合優先度が高いことに注意です。  
そしたら擬環の定義を見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

- 加法群`(a, <>, emptyA, inverseA)`
- 乗法半群`(a, ><)`

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
ここで「型aとその加法の二項演算><・emptyA・inverseA」の組み合わせを加法群、
「型aとその乗法の二項演算<>」を乗法って言います。  
加法群は群なので ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

加法単位元（**零元**） と 各値に対する加法逆元

```hs
emptyA   :: a
inverseA :: a -> a
```

<aside class="notes">
単位元と、
aの全ての値に応じた逆元を持ちます。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

擬環は……

**分配**をするために  
必要なものを定めたプロトコル :point_left: 🤓

`2 * (5 + 2)` = `2*5 + 2*2`

<aside class="notes">
つまるところ擬環は、
分配を十分に行うための代数です。  
分配とは(5 + 2)に対して2を掛けると、
足し算に区切られた各値に2が掛けられるものです。  
インスタンスを見てみましょう。
->
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
まずはInteger。  
足し算についての群が加法、
掛け算についての半群が乗法なので、
加法・乗法という言い回しがストンとくるんじゃないでしょうか。  
ちなみに足し算と掛け算を分ける必要がなくなったので、
newtypeは使う必要もなくなりました。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
instance Rng Rational where
    (<>)     = (+)
    emptyA   = 0 % 1
    inverseA = negate
    (><)     = (*)
```

<aside class="notes">
Rationalも同じく、
足し算と掛け算の擬環を定義できます。
あとはBoolの擬環です。
->
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

<aside class="notes">
Boolはxorとandで擬環を定義できます。
あとは ->
</aside>

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

<aside class="notes">
はい、
いつものですね。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```hs
class Rng a where
    (<>)     :: a -> a -> a
    emptyA   :: a
    inverseA :: a -> a
    (><)     :: a -> a -> a
```

`x >< (y <> z)` = `(x >< y) <> (x >< z)`

<aside class="notes">
擬環のまとめです。  
擬環は群と半群を合体させた代数であって ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```hs
instance Rng Integer where
    ... -- +, 0, negate, *

instance Rng Rational where
    ... -- +, 0/1, negate, *

instance Rng Bool where
    ... -- xor, False, id, &&
```

<aside class="notes">
擬環はこのように分配を行うことができる代数です。
インスタンスにはIntegerとRational、Bool。
あとはUnitがあります。
</aside>

- - - - -

### 代数の素朴な定義
# 環
## (Ring)

<aside class="notes">
次は擬環に少しの概念を加えた代数である環を、
軽く説明します。
</aside>

- - - - -

### 代数の素朴な定義 - 環

加法**可換群** + 乗法**可換モノイド**

:arrow_up_down:

擬環 + 乗法**単位元** 1

`1 (x <> y) z` = `(x <> y) z`  
`x (y <> z) 1` = `x (y <> z)`

<aside class="notes">
環は擬環に対して乗法の単位元を加えたものです。  
つまり加法可換群と乗法可換モノイドの組み合わせです。
定義は ->
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
class Rng a => Ring a where
    emptyM :: a
```

<aside class="notes">
こうなります。
インスタンスを見てみると ->
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
instance Ring Integer where
    emptyM = 1

instance Ring Rational where
    emptyM = 1 % 1
```

<aside class="notes">
いつもと同じく掛け算に対して1です。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
instance Ring Bool where
    emptyM = True

instance Ring () where -- 🤓
    emptyM = ()
```

<aside class="notes">
Bool環の乗法単位元は、
Andの単位元と同じものです。  
あとはいつもの。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```hs
class Rng a => Ring a where
    emptyM :: a
```

`1 >< x` = `x >< 1` = `x`

<aside class="notes">
というところでまとめます。  
環は擬環に加え、
乗法単位元を備えた代数です。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```hs
instance Ring Integer where
    emptyM = 1

instance Ring Rational where
    emptyM = 1 % 1

instance Ring Bool where
    emptyM = True
```

`1 * 10` = `10 * 1`,
`2/3 * 1/1` = `1/1 * 2/3`

`False && True` = `True && False`

<aside class="notes">
インスタンスには環と同じくIntegerとRational、
BoolとUnitがあります。
</aside>

- - - - -

# ちょっと
# 脱線 :sleeping:

<aside class="notes">
ここでちょっとだけ脱線してみましょう。
</aside>

- - - - -

# 皆さん

- - - - -

# 写像は
# 好きですか？

- - - - -

# Q. 写像ってなに？

<aside class="notes">
写像が何かと言うと ->
</aside>

- - - - -

## A. こういうの

![](morphism.png)

<aside class="notes">
こういうのがあります。  
ここでちょっと新しい概念として ->
</aside>

- - - - -

## 半群準同型写像

![](semigroup-homomorphism.png)

<aside class="notes">
半群準同型写像というものを導入します。
半群準同型写像とは ->
</aside>

- - - - -

### 脱線 - 半群準同型写像

**半群準同型**`f : a -> b`とは

:arrow_down:

`Semigroup a`, `<!> :: a -> a -> a`

`Semigroup b`, `<?> :: b -> b -> b`

があるときに

<aside class="notes">
まず2つの半群について考えるので、二項演算を!と?で区別します。  
そして半群a,bがあったときに ->
</aside>

- - - - -

### 脱線 - 半群準同型写像

:arrow_down:

<code class='no-border'>a</code>の全ての値
<code class='no-border'>x :: a</code>,
<code class='no-border'>y :: a</code>を

`f (x <!> y)` = `f x <?> f y`
にする  
<code class='no-border'>f</code> のことである :relieved:

<aside class="notes">
各値をこのように保存するfです。  
なんのこっちゃって感じだと思うので、
そういうときはHaskellで書いてみましょう。
</aside>

- - - - -

### 脱線 - 半群準同型写像

<!--

```haskell
class Magma a where
    (<+>) :: a -> a -> a

class Magma a => Semigroup a

instance Magma [a] where
    (<+>) = (++)

instance Semigroup [a]

instance Magma Int where
    (<+>) = (+)

instance Semigroup Int

(<!>) :: Semigroup b => b -> b -> b
(<!>) = (<!>)

(<?>) :: Semigroup b => b -> b -> b
(<?>) = (<!>)
```

-->

2つのSemigroup `a`, `b` の区別 :eyes:

```hs
(<!>) :: Semigroup a => a -> a -> a
(<!>) = (<>)

(<?>) :: Semigroup b => b -> b -> b
(<?>) = (<>)
```

<aside class="notes">
まず前述の通り、
ある半群aとbを区別して ->
</aside>

- - - - -

### 脱線 - 半群準同型写像

```haskell
newtype Homo a b = Homo
    { runHomo :: a -> b
    }

listAToInt :: Homo [a] Int
listAToInt = Homo length
```

:point_up: `Semigroup [a]` と `Semigroup Int` は準同型

<aside class="notes">
半群準同型写像を表すnewtypeとしてHomoというものを定義します。  
そしてリストの半群からIntの半群への準同型写像、
listAToIntも定義します。  
このlistAToIntは ->
</aside>

- - - - -

### 脱線 - 半群準同型写像

```haskell
homoLaw :: ( Semigroup a, Eq a
           , Semigroup b, Eq b
           ) => Homo a b -> a -> a -> Bool
homoLaw (Homo f) x y =
    f (x <!> y) == f x <?> f y
```

<!--

```haskell
checkListAToInt :: IO ()
checkListAToInt = smallCheck 5 . homoLaw $ listAToInt @ [()]
```

-->

<aside class="notes">
この法則を満たします。
……
というのが半群準同型写像でした。  
ここでこれをモノイドや群に拡張した準同型写像も存在します。
->
</aside>

- - - - -

## モノイド準同型写像

![](monoid-homomorphism.png)

- - - - -

## 群準同型写像

![](group-homomorphism.png)

<aside class="notes">
というところで実は……
</aside>

- - - - -

# 実は……

- - - - -

# 自己準同型写像と
# その合成は
# **モノイドになる**

<aside class="notes">
自己準同型写像とその合成はまたモノイドになります。
自己準同型写像とは ->
</aside>

- - - - -

### 脱線 - 自己準同型写像と合成はモノイドになる

<!--

```haskell
class Semigroup a => Monoid a where
  empty :: a

instance Magma (Homo a a) where
    (Homo f) <+> (Homo g) = Homo $ f . g

instance Semigroup (Homo a a)

instance Monoid (Homo a a) where
    empty = Homo id
```

-->

```hs
instance Magma (Homo a a) where
    (Homo f) <> (Homo g) = Homo $ f . g

instance Semigroup (Homo a a)

instance Monoid (Homo a a) where
    empty = Homo id
```

<aside class="notes">
同一の半群、
aからaへの準同型写像です。  
そしてそれはMonoidのインスタンスになります。
確認してみましょう。
->
</aside>

- - - - -

### 脱線 - 自己準同型写像と合成はモノイドになる

```haskell
reverseHomo :: Homo [a] [a]
reverseHomo = Homo reverse
-- >>> runHomo listATolistA' [1..5]
-- [1,2,2,3,3,4,4,5]
duplicateHomo :: Homo [a] [a]
duplicateHomo = Homo $ \xs ->
    zip xs (tail xs) >>= \(t, u) -> [t, u]
-- ... and more `Homo [a] [a]` values ...
```

<aside class="notes">
リストの自己準同型写像を2つ定義してみます。  
この内容は理解しないで大丈夫です。
これらが準同型写像として型付けられてることに注視してください。  
そしてこれらは ->
</aside>

- - - - -

### 脱線 - 自己準同型写像と合成はモノイドになる

<!--

```haskell
reverseHomo' :: Homo [a] [a]
reverseHomo' = empty <+> reverseHomo

reverseHomo'' :: Homo [a] [a]
reverseHomo'' = reverseHomo <+> empty

alsoHomo :: Homo [a] [a]
alsoHomo = reverseHomo <+> duplicateHomo
```

-->

```hs
reverseHomo' :: Homo [a] [a]
reverseHomo' = empty <> reverseHomo
reverseHomo'' :: Homo [a] [a]
reverseHomo'' = reverseHomo <> empty

alsoHomo :: Homo [a] [a]
alsoHomo = reverseHomo <> duplicateHomo
-- ... and forall `Homo [a] [a]` ...
```

<aside class="notes">
このように、
結合法則と単位元の法則を満たした、
新しい自己準同型写像を作ることができます。
イメージは ->
</aside>

- - - - -

### 脱線 - 自己準同型写像と合成はモノイドになる

![](homomorphism-monoid.png)

<aside class="notes">
こんな感じです。  
reverseはリストの自己準同型写像で、
それはつまりリスト自己準同型写像モノイドの値ということです。  
ここで大事な言葉意があります。
->
</aside>

- - - - -

# **全ての道は**
# **モノイドに通ず**

<aside class="notes">
皆さん是非、
この言葉をおみやげに持ち帰ってください。
</aside>

- - - - -

### 代数の素朴な定義
# 体
## (Field)

<aside class="notes">
皆さんここまでついてきて頂いてありがとうございます。
これが今回の、
最後の代数になります。
</aside>

- - - - -

### 代数の素朴な定義 - 体

加法**可換群** + 乗法**可換群（※）**

:arrow_up_down:

環 + `0 ≠ 1` + **乗法逆元**

`x <> y`, `x <> inv y`  
`x >< y`, `x >< inv y`

- - -

※ **0を除く**

<aside class="notes">
体は加法と乗法の両方が群になっていて、
0 not equal 1です。  
これは実は ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

## :point_right: 四則演算ができる

<aside class="notes">
四則演算ができるということを表しています。  
まずはHaskellで定義してみましょう。
</aside>

- - - - -

### 代数の素朴な定義 - 体

```haskell
class Ring a => Field a where
  inverseM :: a -> a

instance Field Rational where
  inverseM x = denominator x % numerator x
```

<aside class="notes">
環に乗法逆元の存在を加えると、
体になります。  
ここでIntegerの掛け算と、
Boolのandは逆元を持たないので、
このインスタンスにはなれません。
Unitもある条件によって消えます。  
体の要請する法則を見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 体

- `0 ≠ 1`
    - 加法単位元`0`　　 ≠ 乗法単位元`1`
    - 加法単位元`emptyA` ≠ 乗法単位元`emptyM`

```haskell
emptyDifferenceLaw :: forall a.
                      (Field a, Eq a) => Bool
emptyDifferenceLaw =
    (emptyM :: a) /= (emptyA :: a)
```

<aside class="notes">
まずは加法と乗法の単位元が異なるということです。  
有りていに言うと0と1が異なる、
ということですね。  
ここであの、
いつものUnitは消えます。
Unitありがとう。  
あともう一つは ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

乗法逆元

```haskell
inverseLawForMulti :: (Field a, Eq a) => a -> Bool
inverseLawForMulti x
  | x == emptyA = True -- 「0を除く」
  | otherwise =
        (x >< inverseM x == emptyM) &&
        (inverseM x >< x == emptyM)
```

<aside class="notes">
型aの全ての値のうち、
0を除いたものが逆元を持ちます。  
例えばRationalでは ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

乗法可換群（※**0を除く**）

e.g. Rational なら 群`(R', *, 1/1)` のこと

```
R' = { ..., -2/3, ...
     , -1/3, ..., 1/3
     , ..., 2/3, ...
     }
```

R'に `0/1` (`0`, `emptyA`) がないことに注意

<aside class="notes">
このように0を抜いたものになります。
</aside>

- - - - -

### 代数の素朴な定義 - 体

「0を除く」

これをやらないと`0 = 1`になり全てが`0`になる

![](Where_Dreams_Are_Born_by_titiavanbeugen.jpg)

<aside class="notes">
0を除くというのは一見、
不自然に思えるかもしれませんが、
自然で合理的なものです。  
是非、0を除きましょう。
</aside>

- - - - -

### 代数の素朴な定義 - 体

**四則演算**ができる

|        |              |
|--------|--------------|
| 足し算 | `x <> y`     |
| 引き算 | `x <> inv y` |
| 掛け算 | `x >< y`     |
| 割り算 | `x >< inv y` |

<aside class="notes">
体は四則演算を扱うことができます。  
引き算は足し算のうち、後側を逆元に差し替えたもの。
割り算は掛け算のうち、後側を逆元に差し替えたものとして定義できます。  
確認してみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 体

| 　　　　　　　　                                  | 　　　　　　　  | 　　　　　　  |
|---------------------------------------------------|-----------------|---------------|
| 足し算 = <code class='no-border'>x + y</code>     | `3/2 + 1/2`     | = `4/2`       |
| 引き算 = <code class='no-border'>x + -y</code>    | `3/2 + -1/2`    | = `2/2`       |
| 掛け算 = <code class='no-border'>x \* w/v</code>  | `3/2 * 1/2`     | = `3/4`       |
| 割り算 = 　:arrow_down:                           | `3/2 * inv 1/2` | = `3/2 * 2/1` |
| 　　　<code class='no-border'>x \* inv w/v</code> |                 | = `6/2`       |

- - -

:point_up: Field Rational :point_up_2:

<aside class="notes">
Rationalを例に挙げると……  
x + -yはちゃんと引き算です。
割り算はちょっと複雑なんですけど、
掛け算の後ろの分数の、
分子と分母を入れ替えるとちゃんと割り算になりますね。
</aside>

- - - - -

### 代数の素朴な定義 - 体

```hs
class Ring a => Field a where
  inverseM :: a -> a

instance Field Rational where
  inverseM x = denominator x % numerator x
```

<aside class="notes">
まとめです。
体は加法群と乗法群を合体させた、
四則演算のできる代数です。  
その制約はかなり強いので、
基本的な型ではRationalくらいしかインスタンスになれません。
</aside>

- - - - -

# 今日の内容は
# ここまで！

<aside class="notes">
これで今日の内容はここまでです。
</aside>

- - - - -

# お疲れ様でした
# ✋😊

<aside class="notes">
皆さんついてきて頂いて、
本当にありがとうございます。
</aside>

- - - - -

# まとめ

<aside class="notes">
最後にまとめ。
</aside>

- - - - -

### このスライドで学んだこと

- 代数の素朴な定義
    - マグマ・**半群**・**モノイド**・**群**
    - 擬環・**環**・**体**

<aside class="notes">
このスライドでは、
各々のレベルで制約を満たす、
代数という構造について学びました。  
そしてそれぞれは ->
</aside>

- - - - -

### このスライドで学んだこと

- マグマ: `<>`
- **半群**: 結合法則
- **モノイド**: 単位元
- **群**: 逆元
- 擬環: 分配
- **環**: 分配 + 単位元
- **体**: 全部

<aside class="notes">
これらを実現することができました。
以上です。
最後に宣伝。
->
</aside>

- - - - -

[https://aiya000.booth.pm/items/1040121](https://aiya000.booth.pm/items/1040121)

「今回話したこと + もうちょっとわかりやすい説明」を教えてくれる本
🤟🙄🤟

<aside class="notes">
今回話したことと同じようなことを、
わかりやすく説明した本をデジタル販売しているので、
もしよければお求めください。
</aside>

- - - - -

# おわり

![](Where_Dreams_Are_Born_by_titiavanbeugen.jpg)

<aside class="notes">
以上で発表を終わります。
ご清聴ありがとうございました。
</aside>
