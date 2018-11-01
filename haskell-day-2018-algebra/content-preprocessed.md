<!--

```haskell

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module HaskellDay where

import Control.Monad (MonadPlus(..), guard)
import Data.Numbers.Primes (primes)
import Data.Ratio (Rational, (%), numerator, denominator)
import Prelude hiding (Semigroup(..), Monoid(..))

```

-->

　
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

-- 10 + 20   ,   10 * 20
instance Semigroup (Sum Integer)
instance Semigroup (Product Integer)
-- (10%20) + (30%40)   ,   (10%20) * (30%40)
instance Semigroup (Sum Rational)
instance Semigroup (Product Rational)
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

MonadPlus = Monad + **Monoid**

（ Alternative = Applicative + **Monoid** ）

- - - - -

### 閑話休題 - MonadPlus

```
class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a
```

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```haskell
twinPrimes :: [(Int, Int)]
twinPrimes =
    [ (x, y) | (x, y) <- zip primes (tail primes)
             , y - x == 2 ]
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

:point_up: 双子素数

<aside class="notes">
MonadPlusが何かって言うと、
わかりやすいのがこれですね。
</aside>

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```
[ 略 | 略, y - x == 2 ]
           ^^^^^^^^^^
```
ここ :point_up: めっちゃMonadPlus

- - - - -

### 閑話休題 - MonadPlus

- `MonadPlus (m :: * -> *)`
    - :point_up: 高階なモノイド (`* -> *`)
- `mzero`
    - :point_up: mに由来するempty
- `mplus`
    - :point_up: mに由来する<>

<aside class="notes">
mzeroも高階なemptyで、
mに由来しているものです。
</aside>

- - - - -

### 閑話休題 - MonadPlus

MonadPlusのモノイドしぐさ

```haskell
listMonadPlus :: [Int]
listMonadPlus = [10, 20] `mplus` mzero `mplus` [30]
-- [10,20,30]
```

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```
twinPrimes :: [(Int, Int)]
twinPrimes =
    [ (x, y) | (x, y) <- zip primes (tail primes)
             , y - x == 2 ]
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

- - - - -

### 閑話休題 - MonadPlus

リスト内包記と**同値なdo式**

```haskell
twinPrimes' :: [(Int, Int)]
twinPrimes' = do
    (x, y) <- zip primes (tail primes)
    guard $ y - x == 2
    return (x, y)
```

<aside class="notes">
同値についての出典: すごいHaskell楽しく学ぼう！（モナドがいっぱい・リストモナドの章）
</aside>

- - - - -

### 閑話休題 - MonadPlus

```
guard :: Alternative f => Bool -> f ()
guard :: MonadPlus m => Bool -> m ()
```

- - - - -

### 閑話休題 - MonadPlus
# こんなところにもモノイドが！！

- - - - -

### 代数の素朴な定義
# 群

- - - - -

### 代数の素朴な定義 - 群

定義

- - - - -

### 代数の素朴な定義 - 群

つまり

- - - - -

### 代数の素朴な定義 - 群

応用例

- - - - -

### 代数の素朴な定義 - 群

- モノイドであって群でない例
    - ''

- - - - -

### 代数の素朴な定義
# ここまでのまとめ

マグマ・半群・モノイド・群のわかりやすい図

- - - - -

### 代数の素朴な定義
# 擬環

- - - - -

### 代数の素朴な定義 - 擬環

定義

- - - - -

### 代数の素朴な定義 - 擬環

つまり

- - - - -

### 代数の素朴な定義 - 擬環

応用例

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
