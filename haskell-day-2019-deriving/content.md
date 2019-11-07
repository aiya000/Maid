　
## 「しんさんきぼう」
## GHCのderivingテクノロジー
　
### 🤟🙄🤟 aiya000
### https://bit.ly/2MuMofR

- - - - -

## 僕

<div class="profile">
    <div class="left">
        ![profile-image](profile.png)
    </div>
    <div class="right">
        <ul>
            <li>名前: aiya000 (あいや)</li>
            <li>圏論をちょっとだけ</li>
            <li>推しエディタ: Vim</li>
        </ul>
    </div>
</div>

<aside class="notes">
名前を「あいやぜろぜろぜろ」と申します。
普段はプログラミングとか、あとは少しだけ圏論をやっていて、数学圏論入門本みたいなのを頒布したりしてます。

僕のちょっとした近況なのですが……

もともと、いわゆる地声が出せなくて、普段からこの裏声で話してるんですよ。

それで最近はVTuberになりたくて、
ボイスチェンジャーに頼らないで、
単なる裏声じゃなくて可愛い女の子の声を出せるようになりたいな〜〜と思って、
練習してたんです。

そしたらこんな、地声が出るようになりました。

……では自己紹介はここまでにして、次にいきましょう。

まずこのセッションで最初に学ぶことは…… ->
</aside>

- - - - -

しんさん-きぼう【神算鬼謀】

　

人知の及ばないような、  
すぐれた巧みな策略のこと。

<aside class="notes">
これです。

皆さん「しんさんきぼうって何？」って感じだと思うので、気になるところをはっきりさせておきましょう！

神算鬼謀とは
「人知の及ばないような、すぐれた巧みな策略のこと。」
です。

それだけGHC Haskellのderivingは、すごく賢くなっているということです。
</aside>

- - - - -

## 今回の内容

- - - - -

## GHCの提供する
## deriving機能の全体像

- - - - -

### GHCの提供するderivingテクノロジーの全体像 - 今回の内容

『4種類』の各deriving機構の紹介 + α

- Haskell標準のderiving
- `GeneralizedNewtypeDeriving`
- `DeriveAnyClass`
- `DerivingVia`

- - - - -

## そもそもderivingとは

- - - - -

## Haskell標準

- - - - -

### Haskell標準 - そもそもderivingとは

```haskell
data Direction = Left | Right | Up | Down
  deriving (Eq, Show, Enum, Bounded)
```

<div class="twin">
    <div class="pane vertical-center">
        <div>関数を自動で</div>
        <div>定義してくれるやつ</div>
        <div>　</div>
        <div>特定の型クラスのみに対して</div>
        <div>しか使えない</div>
        <div>Eq・Show・Enum・...・~~Read~~</div>
    </div>

    >>> Left == Left
    True

    >>> [Right .. Down]
    [Right,Up,Down]

    >>> maxBound  :: Direction
    Down

    >>> minBound :: Direction
    Left
</div>

- - - - -

## GHC拡張のderiving

- - - - -

:point_down: 今回の主題

## GHC拡張のderiving

- - - - -

### GHC拡張のderiving - 今回の主題

新しい3つのderiving方法

- `GeneralizedNewtypeDeriving`
- `DeriveAnyClass`
- `DerivingVia`

- - - - -

## GeneralizedNewtypeDeriving

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

「どういう意味？」

- Generalized
    - 「一般化された」（汎用的な）
- NewtypeDeriving
    - 「`newtype`用の`deriving`」

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

「どういうもの？」

newtypeの元になる型のインスタンスを、そのnewtypeで利用する機能。

たまに「GND」とか略される。

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x
```

```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

newtype NonNegative = NonNegative Nat
  deriving (Numeric)  -- GeneralizedNewtypeDerivingの機能
```

<aside class="notes">
- 標準ではこの、自前で定義したNumericクラスというのはderivingできません  
- GeneralizedNewtypeDerivingのおかげでderivingできるようになっています  
-  NatクラスのNumericインスタンスを、NonNegativeにコピーしてそのまま使うイメージ  
</aside>

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

Nat

```
>>> toNumber Zero
0
>>> toNumber $ Succ (Succ Zero)
2
```

**NonNegative**

```
>>> toNumber $ NonNegative Zero
0
>>> toNumber $ NonNegative (Succ (Succ Zero))
2
```

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

MonadTransの構築によく使われる

```haskell
-- レキサーのための型。
-- エラー報告ができて、現在処理中のトークン位置を状態に持っている。
newtype Processor a = Processor
  { unProcessor :: ExceptT Failure (State TokenPos) a
  } deriving ( Functor, Applicative, Monad
             , MonadState TokenPos
             , MonadError Failure
             )
-- これら全部、GeneralizedNewtypeDerivingによる
-- Monad m => ExceptT e mのインスタンス
```

<div class="unimportant">
主題と関係ないので、詳しくは理解できなくてよい！
とりあえず「便利」。
</div>

- - - - -

## DeriveAnyClass

- - - - -

### DeriveAnyClass - GHC拡張のderiving

'minimal implementation'が空集合であるクラスをderiving指定できるようにする機能。

```haskell
-- 実装する必要がある関数がない
--      = 'minimal implementation'が空集合
class Visible a where
  visualize :: a -> String
  visualize = const "not specified"  -- デフォルト実装

data Anonymous = Anonymous

-- visualize を実装しなくても instance 宣言できる
--      ==> DeriveAnyClass が使える！
instance Visible Anonymous
```

```
>>> visualize Anonymous
"not specified"
```

- - - - -

### DeriveAnyClass - GHC拡張のderiving

`DeriveAnyClass`を使うと

```haskell
{-# LANGUAGE DeriveAnyClass #-}

data Anonymous = Anonymous
  deriving (Visible)  -- こう書ける
```

```
>>> visualize Anonymous
"not specified"
```

- - - - -

### DeriveAnyClass - GHC拡張のderiving

「どのようなクラスでもderivingできるようにする最強のやべーやつ」
**ではない**

- - - - -

## DerivingVia

- - - - -

:point_down: 僕のめちゃ推しGHC拡張

## DerivingVia

- - - - -

### DerivingVia - GHC拡張のderiving

「なにそれ？」

<div class="unimportant">　</div>

`GeneralizedNewtypeDeriving` を  
**もっと一般化した**、すげーやつ！

- - - - -

### DerivingVia - GHC拡張のderiving

<!--

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x
```

-->

Negative: 0 と 負数

```haskell
-- Numeric, Nat, instance Numeric Nat
--    ↑ さっきでてきたやつ

newtype Negative = Negative Nat

instance Numeric Negative where
  toNumber (Negative x) = negate $ toNumber x
```

```
>>> toNumber . Negative $ Succ (Succ Zero)
-2
>>> toNumber . Negative $ Zero
0
```

<aside class="notes">
- もうちょっと、数の種類を増やしてみる
</aside>

- - - - -

ちょっと考えてみる

　

:thinking_face: oO( Negativeをベースにして、  
                    　　　`instance Numeric Nat`な  
                    　　　　　newtypeを作れないかな……？ )

<div class="unimportant">
※ ここで「ベースにする」とは、 TODO
</div>

- - - - -

やってみる

```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- ？？？
newtype Positive' = Positive' Negative
  deriving (Numeric)
```

```haskell
-- 結果「2」が欲しかったのだけど……
>>> toNumber . Positive' . Negative  $ Succ (Succ Zero)
-2
```

　

うん、これ、`instance Numeric Negative`やね。
<div class="unimportant">
（それはそう）
</div>

- - - - -

### DerivingVia - GHC拡張のderiving

<!-- {{{

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x

newtype Negative = Negative Nat

instance Numeric Negative where
  toNumber (Negative x) = negate $ toNumber x
```

}}} -->

:point_right: そこで `DerivingVia`

```haskell
newtype Positive = Positive Negative
  deriving (Numeric) via Nat
```

```
>>> toNumber . Positive . Negative $ Succ (Succ Zero)
2
>>> toNumber . Positive . Negative $ Zero
0
```

オーケー！！！

- - - - -

### DerivingVia - GHC拡張のderiving

```haskell
newtype Positive = Positive Negative
  deriving (Numeric) via Nat
```

`via Nat`？

- - - - -

### DerivingVia - GHC拡張のderiving

ベースのツリー :point_down:

```
Nat                      -- `instance Numeric Nat`
|- NonNegative Nat       -- `deriving Numeric` (GND)
|- Negative Nat          -- `instance Numeric Negative`
   |- Positive Negative  -- `deriving Numeric via Nat` (via)
```

Positiveのベースには**Negative**と**Nat**が存在し、  
それらはどちらも**Numericインスタンス**である。

- - - - -

### DerivingVia - GHC拡張のderiving

==> Positiveは :point_down: のどちらもインスタンスも`deriving`することができる

- `instance Numeric Nat`
- `instance Numeric Negative`

- - - - -

### DerivingVia - GHC拡張のderiving

GND「どっちをderivingしてもよいなら、  
　　　　**直近の**Negativeのインスタンスを選ぶね」

<div class="unimportant">　</div>

Positive'「よろしゃす」　　　　　　　　　  

Positive' oO（ん、GND、今なにか言ってた？  
　　　　まあいっか）

- - - - -

### DerivingVia - GHC拡張のderiving

Positive'「できてないやん！！！」

```haskell
>>> toNumber . Positive' . Negative  $ Succ (Succ Zero)
-2
```

GND「そう言ったやん！！！」

- - - - -

### DerivingVia - GHC拡張のderiving

<div class="small">
一方DerivingViaとPositiveは……
</div>

<div class="unimportant">　</div>

DerivingVia「どちらもderivingできますが、  
　　どちらにしますか？」

- `via Nat`
- `via Negative`

<div class="unimportant">　</div>

Positive「`via Nat`でお願いします」　　

- - - - -

### DerivingVia - GHC拡張のderiving

```
>>> toNumber . Positive . Negative $ Succ (Succ Zero)
2
>>> toNumber . Positive . Negative $ Zero
0
```

DerivingVia「 👍 」

Positive「 👍 」　

- - - - -

### DerivingVia - GHC拡張のderiving

まとめると

- - - - -

### DerivingVia - GHC拡張のderiving

Positiveの**GND**が選べるNumericインスタンス

```
Nat                      --
|- NonNegative Nat       --
|- Negative Nat          -- 👈 ここだけ
   |- Positive Negative  --
```

**直近のみ**

- - - - -

### DerivingVia - GHC拡張のderiving

Positiveの**DerivingVia**が選べるNumericインスタンス

```
Nat                      -- 👈
|- NonNegative Nat       --
|- Negative Nat          -- 👈
   |- Positive Negative  --
```

ベースになっているインスタンスを**どれでも**

- - - - -

### DerivingVia - GHC拡張のderiving

それだけ？

- - - - -

### DerivingVia - GHC拡張のderiving

まだあるよ

- - - - -

### DerivingVia - GHC拡張のderiving

<!-- {{{

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x

newtype Negative = Negative Nat

instance Numeric Negative where
  toNumber (Negative x) = negate $ toNumber x

newtype NonNegative = NonNegative Nat
  deriving newtype (Numeric)
```

}}} -->

<div class="small">
僕「やっぱりNegativeがPositiveのベースに　　　　  
　　　　なっているのはおかしい。Natが適切っぽい」
</div>

<div class="small">
僕「あとPositiveはNonNegativeの　　　　　　　　  
　　　　Numericインスタンスを使うとよさそう」
</div>

<div class="small">　</div>

```haskell
newtype Positive = Positive Negative
  deriving (Numeric) via Nat
```

👇 ベースとvia元を変更

```haskell
newtype Positive = Positive Nat
  deriving (Numeric) via NonNegative
```

- - - - -

### DerivingVia - GHC拡張のderiving

```
>>> toNumber . Positive $ Succ (Succ Zero)
2
>>> toNumber . Positive $ Zero
0
```

ちゃんとNonNegativeのNumberインスタンスと同じ動きをしている

- - - - -

### DerivingVia - GHC拡張のderiving

あれ、でも、PositiveのベースにNonNegativeはないよ？？

```haskell
Nat
|- NonNegative Nat
|- Negative Nat
|- Positive Nat
```

いいの？

- - - - -

DerivingVia「いいよ」

- - - - -

### DerivingVia - GHC拡張のderiving

- <span class="small">GNDではベースの関係になっていないとderivingできなかった</span>
- <span class="small">DerivingViaでは同じ型をベースにしていればオーケー</span> **※**

```haskell
Nat
|- NonNegative Nat
|- Negative Nat
|- Positive Nat
```

<div class="unimportant">
**※** 「representationが同じであればオーケー」の意
</div>

<aside class="notes">
- 「representationとは？」っていうのはこの発表の範囲を超えてしまうので、やりません
- 大まかに言って「同じ型をベースにしていればオーケー」とは言えます
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

- その他機能
    - newtype以外に、dataに対しても使える

- - - - -

ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ

＞　　DerivingVia「　　♥🤗♥　　」　　＜

＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾

- - - - -

# おまけ

- - - - -

### deriving方法（全種類） - おまけ

型クラスをderivingする方法が「4種類」ある

- Haskell標準のderiving
- `DeriveAnyClass`
- `GeneralizedNewtypeDeriving`
- `DerivingVia`

- - - - -

# 多い

- - - - -

### GHC拡張のderiving - おまけ

ある実装データ型`Two`の実装

```haskell
class Numeric' a where
  toNumber' :: a -> Int
  toNumber' = const 10  -- デフォルト実装
```

```haskell
data One = One
instance Numeric' One where
  toNumber' One = 1  -- オーバーライド実装
```

```haskell
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Two = Two { pred :: One }
  deriving (Numeric')  -- デフォルト実装とオーバーライド実装どっち？？
```

- - - - -

Haskell「この`deriving (Numeric')`、　　　　  
　　　　デフォルト実装とオーバーライド実装、  
どっち使えばいい？？」

GHC「　　　　　わからん　　　　　」　　　

<div class="unimportant">　</div>

```markdown
warning:
    • Both DeriveAnyClass and GeneralizedNewtypeDeriving are enabled
      Defaulting to the DeriveAnyClass strategy for instantiating Numeric'
    • In the newtype declaration for ‘Two’
```

<div class="unimportant">　</div>

<div class="unimportant">
意訳: `DeriveAnyClass`・`GeneralizedNewtypeDeriving`  
どっちも適用できるけど？  
とりあえず `DeriveAnyClass` しておくね。
</div>

- - - - -

DerivingStrategies　　　　　　　　  
「こいつらアカン。  
　　　　ワイがまとめなきゃ。」

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

DerivingStrategies「まずは各deriving**戦略**に  
　　　　　　　　　名前をつけよう」

- stock: <span class="small">Haskell標準のderiving</span>
- anyclass: <span class="small">`DeriveAnyClass`</span>
- newtype: <span class="small">`GeneralizedNewtypeDeriving`</span>
- via: <span class="small">`DerivingVia`</span>

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

<!-- {{{

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x

newtype Negative = Negative Nat

instance Numeric Negative where
  toNumber (Negative x) = negate $ toNumber x

newtype NonNegative = NonNegative Nat
  deriving newtype (Numeric)

class Visible a where
  visualize :: a -> String
  visualize = const "not specified"

data Anonymous = Anonymous
  deriving anyclass (Visible)
```

}}} -->

DerivingStrategies「構文をつけてみよう」

```haskell
{-# LANGUAGE DerivingStrategies #-}
newtype SomeBody = SomeBody Person
  deriving       (Show)          -- 標準
  deriving stock (Eq)            -- 標準
  deriving anyclass (Visible)    -- DeriveAnyClass
  deriving newtype (Enum)        -- GeneralizedNewtypeDeriving
  deriving (Bounded) via Person  -- DerivingVia
```

```haskell
data Person = Eta | Mu
  deriving (Show, Eq, Enum, Bounded)
```

- - - - -

DerivingStrategies「うん、できてそう」

```haskell
>>> eta = SomeBody Eta
>>> mu = SomeBody Mu

>>> show eta
"SomeBody Eta"
>>> eta /= mu
True
>>> visualize mu
"not specified"
>>> succ eta
SomeBody Mu
>>> maxBound :: SomeBody
SomeBody Mu
```

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

<!-- {{{

```haskell
class Numeric' a where
  toNumber' :: a -> Int
  toNumber' = const 10

data One = One

instance Numeric' One where
  toNumber' One = 1
```

}}} -->

DerivingStrategies「さっきの問題を　　　　  
　　　　　　　　　　解決してみよう」　　　　

- - - - -

「デフォルト実装とオーバーライド実装  
　　　　どっち？？」

```haskell
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Two = Two { pred :: One }
  deriving (Numeric')  -- 「どっち？？」
```

```haskell
class Numeric' a where
  toNumber' :: a -> Int
  toNumber' = const 10  -- デフォルト実装
```

```haskell
data One = One
instance Numeric' One where
  toNumber' One = 1  -- オーバーライド実装
```

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

デフォルト実装を使うなら

```haskell
newtype Two = Two { pred :: One }
  deriving anyclass (Numeric')
```

```haskell
>>> toNumber' $ Two One
10
```

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

オーバーライド実装を使うなら（`GND`）

```haskell
newtype Two' = Two' { pred' :: One }
  deriving newtype (Numeric')
```

```haskell
>>> toNumber' $ Two' One
1
```

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

オーバーライド実装を使うなら（`DerivingVia`）

```haskell
newtype Two'' = Two'' { pred'' :: One }
  deriving (Numeric') via One
```

```haskell
>>> toNumber' $ Two'' One
1
```

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

いずれもデータ定義句は変わらない

```haskell
newtype Two   = Two   { pred   :: One }
newtype Two'  = Two'  { pred'  :: One }
newtype Two'' = Two'' { pred'' :: One }
```

変わったのは**deriving句**だけ

```haskell
deriving anyclass (Numeric')
deriving newtype (Numeric')
deriving (Numeric') via One
```

- - - - -

これが **newtype** のチカラだ！！！！

- - - - -

# おわり
