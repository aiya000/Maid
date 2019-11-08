　
## 「しんさんきぼう」
## GHCのderivingテクノロジー
　
### 🤟🙄🤟 aiya000
### https://bit.ly/2MuMofR

<aside class="notes">
『「しんさんきぼう」GHCのderivingテクノロジー』という発表をさせていただきます。
よろしくお願いします！
</aside>

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

<aside class="notes">
では本編に移りましょう。
</aside>

- - - - -

## GHCの提供する
## deriving機能の全体像

- - - - -

### GHCの提供するderivingテクノロジーの全体像 - 今回の内容

標準 +『3種類』の各deriving機構の紹介 + α

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

    >>> maxBound :: Direction
    Down

    >>> minBound :: Direction
    Left
</div>

<aside class="notes">
- 比較演算子はEqから  
- てんてんリストはEnumから  
- maxBound・minBoundはBoundedから導出されたもの
</aside>

- - - - -

:point_down: 今回の主題

## GHC拡張のderiving

- - - - -

### GHC拡張のderiving - 今回の主題

新しい3つのderiving方法

- `GeneralizedNewtypeDeriving`
- `DeriveAnyClass`
- `DerivingVia`

<aside class="notes">
- これらがderiving系のGHC拡張の中で、比較的メジャーなもの  
- この順番で説明していきます  
</aside>

- - - - -

## GeneralizedNewtypeDeriving

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

「どういう意味？」

- Generalized
    - 「一般化された」（汎用的な）
- NewtypeDeriving
    - 「`newtype`用の`deriving`」

<aside class="notes">
言葉としては『……』っていう意味を持ちます。
</aside>

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
どんなものか？  
- 標準ではこの、自前で定義したNumericクラスというのはderivingできません  
- GNDのおかげでderivingできるようになっています  
- 「Numeric Nat」インスタンスを「Numeric NonNegative」インスタンスにコピーするイメージ  
- Natは0と1以上の数（自然数）を表す型です  
</aside>

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

Nat（GNDされた型）

```
>>> toNumber Zero
0
>>> toNumber $ Succ (Succ Zero)
2
```

**NonNegative**（GNDした型）

```
>>> toNumber $ NonNegative Zero
0
>>> toNumber $ NonNegative (Succ (Succ Zero))
2
```

<aside class="notes">
- このようにNumericインスタンスの挙動は同じになります  
</aside>

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
```

<div class="unimportant">
**ここは詳しく理解できなくてよい**けど、めっちゃ「便利」
</div>

<aside class="notes">
- 例えばこんな感じ  
- 何やら難しいことやってますが、これもGND  
- 主題と離れるので理解できなくてよいけど、GNDはすごく便利です！  
</aside>

- - - - -

## DeriveAnyClass

<aside class="notes">
GNDが便利なのを感じられたところで、次にいきましょう。
</aside>

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

<aside class="notes">
例えばこんなVisibleクラスのように、
実装しなければいけない関数がないクラスがあると、
instance宣言のwhere句なしに、
インスタンス定義ができます。
</aside>

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

<aside class="notes">
そのときにDeriveAnyClassを使うと、instance宣言しないでderivingで、同じことができます。  
という地味に便利なものでした。
</aside>

- - - - -

### DeriveAnyClass - GHC拡張のderiving

「どのようなクラスでもderivingできるようにする最強のやべーやつ」
**ではない**

<aside class="notes">
こういう「やべーやつ」ではないです。
残念！
</aside>

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

<!-- {{{

```haskell
data Nat = Zero | Succ Nat
  deriving (Show)

class Numeric a where
  toNumber :: a -> Int

instance Numeric Nat where
  toNumber Zero     = 0
  toNumber (Succ x) = 1 + toNumber x
```

}}} -->

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
- ここでNat型を元に、0と負数を表す型を作る  
</aside>

- - - - -

ちょっと考えてみる

<div class="unimportant">　</div>

:thinking_face: oO( さらにNegativeをベースにして、  
                    　　　　　`instance Numeric Nat`と同じ挙動の  
                    　　　　`newtype Positive`を作れないかな  
                    　　　　　　　　　　……？ )

<div class="unimportant">　</div>

- - -

<div class="unimportant">
    <ul>
        ここでの言葉「BarがFooをベースにする」とは 👇
        <li>`newtype Bar = Bar Foo`のこと。さらに</li>
        <li>`newtype Baz = Baz Bar`としたときに「BazはBarとFooをベースとしている」とも。</li>
    </ul>
</div>

<aside class="notes">
- この「ベースにする」っていうのは公な言葉じゃない  
- ここでの用法として定義しておく  
</aside>

- - - - -

やってみる

```haskell
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Positive' = Positive' Negative
  deriving (Numeric)
-- ☝ 誤ったPositive
```

<div class="small">
結果として「2」が欲しかったのだけど……
</div>

```haskell
>>> toNumber . Positive' . Negative $ Succ (Succ Zero)
-2
```

<div class="unimportant">　</div>

うん、これ、  
`instance Numeric Negative`の挙動やね。
<div class="unimportant">
（それはそう）
</div>

<aside class="notes">
なんでかっていうと、GNDは直近のベースのインスタンスを使うからです。  
- ここで「直近のベース」とはNegativeのこと  
- でも本当はNatのNumericインスタンスを使いたかった  
</aside>

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

<aside class="notes">
ちゃんと「Succ (Succ Zero)」が「2」を表してる！
</aside>

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
 Nat                      -- 👈
 |- NonNegative Nat       --
 |- Negative Nat          -- 👈
    |- Positive Negative  --
```

Positiveのベースには**Negative**と**Nat**が存在し、  
それらはどちらも**Numericインスタンス**である。

- - - - -

### DerivingVia - GHC拡張のderiving

<div class="twin">
    <div>==></div>
    <div class="primary">
        ならPositiveは、　　　　　　　　　　  
        どちらのインスタンスも　　　　　　  
        `deriving`できそう……？ 👇　　　　
    </div>
</div>

<div class="unimportant">　</div>

- `instance Numeric Nat`
- `instance Numeric Negative`

- - -

```
 Nat                      -- 👈
 |- NonNegative Nat       --
 |- Negative Nat          -- 👈
    |- Positive Negative  --
```

<aside class="notes">
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

GND「どっちをderivingしてもよいなら、  
　　　　**直近の**Negativeのインスタンスを選ぶね」

<div class="unimportant">　</div>

Positive'「よろしゃす」　　　　　　　　　  

Positive' oO（ん、GND、今なにか言ってた？  
　　　　まあいっか）

<aside class="notes">
NatとNegativeのNumericインスタンスの、
どちらでもderivingできる状況に対して、
GNDは直近の方を選びます。
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

Positive'「できてないやん！！！」

```haskell
>>> toNumber . Positive' . Negative  $ Succ (Succ Zero)
-2
```

GND「そう言ったやん！！！」

<aside class="notes">
- Positiveプライムの直近のベースはNegative  
- だからNegativeのインスタンスを使う  
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

<div class="small">
DerivingVia「ドーモ、デリビングビアです。  
　　　　　　どちらもderivingできますが、  
　　　どちらにしますか？」
</div>

<div class="unimportant">　</div>

- `via Nat`
- `via Negative`

<div class="unimportant">　</div>

<div class="small">
Positive「ドーモ、ポジティヴです。　　  
　　　　　　`via Nat`でお願いします」　　　　
</div>

<aside class="notes">
一方DerivingViaは  
- どちらかを指定することができる  
</aside>

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

<aside class="notes">
ちゃんと、Natのインスタンスと同じ挙動になりました。  
ユウジョウ！
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

小まとめ

<aside class="notes">
まだ途中ですが、ここまでの内容をまとめます。
</aside>

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

ここでちょっとひと呼吸。

<aside class="notes">
GNDに対して、DerivingViaは、ベースのいずれかのインスタンスを選ぶことができました。
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

それだけ？

- - - - -

### DerivingVia - GHC拡張のderiving

まだあるよ

<aside class="notes">
実はDerivingViaは「ベースになっていないけど、同じnewtypeな型」のインスタンスもderivingできます。  
どういうことかというと……
</aside>

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
？？「やっぱりNegativeがPositiveのベースに　　　　  
　　　　なっているのはおかしい。Natが適切っぽい」
</div>

<div class="small">
？？「あとPositiveはNonNegativeの　　　　　　　　  
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

<aside class="notes">
ここで誰かは考えました。  
- 負数が正の数のベースになっているのは、おかしくない？  
- PositiveってNonNegativeと同じ意味だし、同じインスタンス使ってもよさそう  
と。  
　  
というわけで、やってみました。
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

```
>>> toNumber . Positive $ Succ (Succ Zero)
2
>>> toNumber . Positive $ Zero
0
```

ちゃんとNonNegativeのNumberインスタンスと同じ動きをしている

<aside class="notes">
挙動を確認してみても、ちゃんと正しくなったままです。
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

あれ、でも、PositiveのベースにNonNegativeはないよ？？

いいの？

```haskell
Nat
|- NonNegative Nat
|- Negative Nat
|- Positive Nat
```

<div class="small">
☝ 現在のツリー
</div>

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

<aside class="notes">
あとは、こんな機能もあります。
</aside>

- - - - -

### DerivingVia - GHC拡張のderiving

DerivingViaまとめ

- <span class="small">newtypeじゃなくて、dataのderivingでも使える</span>
- <span class="small">representationが同じ、別の型のインスタンスをderivingできる</span>
    - <span class="small">例えば 👇</span>

<div class="twin">
<div class="aaaaaaaaa">
<pre><code class="lang-haskell hljs">newtype Z = Z A
  deriving (Foo) via A
  --             via X
  --             via Y
  --             via V
  -- いずれもできる ☝
</code></pre>
</div>

<div class="uooooooo">
<pre><code>data A
|- newtype X = X A
|- newtype Y = Y A
   |- newtype V = V Y

全てFooインスタンスとする
</code></pre>
</div>
</div>

- - - - -

ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ ｖ

＞　　DerivingVia「　　♥🤗♥　　」　　＜

＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾ ＾

<aside class="notes">
DerivingVia強い！！
</aside>

- - - - -

# おまけ

<aside class="notes">
と、ここまでが本題でした。  
あとはペース落として、最後のプラスアルファを見ていきましょう。  
ちょっと重要度がおちますので、楽に聞いていてください。
</aside>

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

<aside class="notes">
- ここに、さっきまでのNumericっぽいクラスがあります。  
- これにはtoNumberプライムのデフォルト実装がついてます  
- Oneでは明示的にtoNumberプライムを実装します  
　  
このとき皆さん、Twoのderiving Numericプライムが、どちらの実装を使うか、わかりますか？
</aside>

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

<aside class="notes">
- これはGHCもわかりません  
- とりあえず、DeriveAnyClassを使っておいてはくれました  
</aside>

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
  deriving          (Show)                -- 標準
  deriving stock    (Eq)                  -- 標準
  deriving anyclass (Visible)             -- DeriveAnyClass
  deriving newtype  (Enum)                -- GeneralizedNewtypeDeriving
  deriving          (Bounded) via Person  -- DerivingVia
```

```haskell
data Person = Eta | Mu
  deriving (Show, Eq, Enum, Bounded)
```

<div class="setulab-icons">
    ![](mu-icon.png)
    ![](eta-icon.png)
</div>

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

<aside class="notes">
「さっきの問題」っていうのは、
このような場合に、
どちらの実装を使えばいいのかわからない、
というもののことでした。
</aside>

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

デフォルト実装を使うなら

```haskell
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DeriveAnyClass #-}

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
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

newtype Two' = Two' { pred' :: One }
  deriving newtype (Numeric')
```

```haskell
>>> toNumber' $ Two' One
1
```

<aside class="notes">
オーバーライド実装を使いたいなら、
このようにGNDを使うこともできますし
</aside>

- - - - -

### DerivingStrategies - GHCの提供するderivingテクノロジーの...

オーバーライド実装を使うなら（`DerivingVia`）

```haskell
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DerivingVia #-}

newtype Two'' = Two'' { pred'' :: One }
  deriving (Numeric') via One
```

```haskell
>>> toNumber' $ Two'' One
1
```

<aside class="notes">
DerivingViaを使うこともできます。
</aside>

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
deriving newtype  (Numeric')
deriving (Numeric') via One
```

- - - - -

これが **newtype** のチカラだ！！！！

- - - - -

# おわり
