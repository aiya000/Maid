　
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
    - 「一般化された」
- NewtypeDeriving
    - 「`newtype`用の`deriving`」

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

- - - - -

### GeneralizedNewtypeDeriving - GHC拡張のderiving

Nat

```
>>> toNumber Zero
0
>>> toNumber (Succ (Succ Zero))
2
```

NonNegative

```
>>> toNumber $ NonNegative Zero
0
>>> toNumber $ NonNegative (Succ (Succ Zero))
2
```

- - - - -

## DeriveAnyClass

- - - - -

### DeriveAnyClass - GHC拡張のderiving

TODO

- - - - -

## DerivingVia

- - - - -

:point_down: 僕のめちゃ推しGHC拡張

## DerivingVia

- - - - -

### DerivingVia - GHC拡張のderiving

TODO

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

# ＞＞＞ 多い ＜＜＜

- - - - -

### GHC拡張のderiving - おまけ

ある実装データ型`Two`の実装

```haskell
class Numeric a where
  toNumber :: a -> Int
  toNumber = const 10  -- デフォルト実装
```

```haskell
data One = One
instance Numeric One where
  toNumber One = 1  -- オーバーライド実装
```

```haskell
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Two = Two { pred :: One }
  deriving (Numeric)  -- デフォルト実装とオーバーライド実装どっち？？
```

- - - - -

Haskell「`deriving (Numeric)`、デフォルト実装とオーバーライド実装どっち？？」

GHC「　　　　　わからん　　　　　」　　　

```markdown
warning:
    • Both DeriveAnyClass and GeneralizedNewtypeDeriving are enabled
      Defaulting to the DeriveAnyClass strategy for instantiating Numeric
    • In the newtype declaration for ‘Two’
```

<div class="unimportant">
意訳: `DeriveAnyClass`・`GeneralizedNewtypeDeriving`  
どっちも適用できるけど？  
とりあえず `DeriveAnyClass` しておくね。
</div>

- - - - -

DerivingStrategies「
こいつらアカン。
ワイがまとめなきゃ。」

- - - - -

## DerivingStrategies - GHCの提供するderivingテクノロジーの...

DerivingStrategies「名前をつけました」

- stock
    - Haskell標準のderiving
- anyclass
    - `DeriveAnyClass`
- newtype
    - `GeneralizedNewtypeDeriving`
- via
    - `DerivingVia`

- - - - -

## おまけ（その２）

- - - - -

## StandaloneDeriving

[GHC User's Guide - StandaloneDeriving](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/glasgow_exts.html?highlight=deriveanyclass#extension-StandaloneDeriving)

- - - - -

## おまけ（その３）

- - - - -

## ApplyingVia

- - - - -

### ApplyingVia - おまけ（その３）

- - - - -

# おわり
