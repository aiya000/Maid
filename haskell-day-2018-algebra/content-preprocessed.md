<!--

```haskell
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

module HaskellDay where

import Prelude hiding (Semigroup(..))
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
この発表では代数の素朴な定義を紹介、
説明していきます。
またこれらの定義はHaskellで記述していきます。  
ここで詳しくは述べませんが、
通常の代数とは集合に乗せて考えるものです。  
ただし型に乗せても、集合に乗せても、
同様に考えられます。  
今回はHaskellとその型で説明します。  
　  
まず前半は
「マグマ・半群・モノイド・群」
という4つの代数を、
後半は
「擬環・環・体」
という3つの代数を説明します。  
ここで応用例等の紹介は重視しませんが、
軽く紹介します。  
というのも代数って非常に広く応用されているので、
わざわざ紹介するよりも自身で調べて頂いた方が面白いかな〜
と思いますので……
ってところですね。
じゃあ…… ->
</aside>

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
instance Magma (Sum Bool) where
    (<>) = (||)

instance Magma (Product Bool) where
    (<>) = (&&)
```

<aside class="notes">
Boolはこんな感じです。  
Unitについてはインスタンスが唯一つなので、
新しく定義はしません。
</aside>

- - - - -

### 代数の素朴な定義
# 半群
## (Semigroup)

- - - - -

### 代数の素朴な定義 - 半群

定義

- - - - -

### 代数の素朴な定義 - 半群

つまり

- - - - -

### 代数の素朴な定義 - 半群

応用例

- - - - -

### 代数の素朴な定義 - 半群

- マグマであって半群でない例
    - Double, Float（浮動小数点数）

<!-- 結合法則の最適化 -->
<!-- http://www.kmonos.net/wlog/121.html -->

- - - - -

### 代数の素朴な定義
# モノイド

- - - - -

### 代数の素朴な定義 - モノイド

定義

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

- - - - -

<!-- NOTE: 閑話休題のときは高橋メソッドに切り替えてる。 -->
<!-- （そっちのが皆さん、使う頭が変わって休めるかなと思うので） -->

# 閑話休題

- - - - -

# 皆さん

- - - - -

# Monadはお好きですか？

- - - - -

# MonadPlus

- - - - -

### 余談 - MonadPlus

MonadPlus = Monad + **Monoid**

（ Alternative = Applicative + **Monoid** ）

- - - - -

### 余談 - MonadPlus

TODO: なんかリスト内包記とか (guardとか) の例

- - - - -

### 余談 - MonadPlus

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
