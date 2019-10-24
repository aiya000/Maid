　
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

`DerivingStrategies`拡張が提供する  
各deriving機構の紹介

- stock
- anyclass
- newtype
- via

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
        <div>　</div>
        <div>　</div>
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

### GHC拡張のderiving - そもそもderivingとは

新しい3つのderiving方法

- `DeriveAnyClass`
- `GeneralizedNewtypeDeriving`
- `DerivingVia`

- - - - -

### GHC拡張のderiving - そもそもderivingとは

ある実装データ型`Two`の実装

```haskell
class Number a where
  number :: a -> Int
  number = const 10  -- デフォルト実装
```

```haskell
data One = One
instance Number One where
  number One = 1  -- オーバーライド実装
```

```haskell
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
newtype Two = Two { pred :: One }
  deriving (Number)  -- デフォルト実装とオーバーライド実装どっち？？
```

- - - - -

<!-- TODO: leftにアライン -->

<div>
Haskell「`deriving (Number)`、デフォルト実装とオーバーライド実装どっち？？」
</div>

<div>
GHC「わからん」
</div>

```markdown
warning:
    • Both DeriveAnyClass and GeneralizedNewtypeDeriving are enabled
      Defaulting to the DeriveAnyClass strategy for instantiating Number
    • In the newtype declaration for ‘Two’
```

- - - - -

## まとめると - そもそもderivingとは

型クラスをderivingする方法が「4種類」ある

- stock
    - Haskell標準のderiving
- anyclass
    - `DeriveAnyClass`
- newtype
    - `GeneralizedNewtypeDeriving`
- via
    - `DerivingVia`

- - - - -

# ＞＞＞ 多い ＜＜＜

- - - - -

DerivingStrategies「
こいつらアカン。

」

- - - - -

## DerivingStrategies - GHCの提供するderivingテクノロジーの...

DerivingStrategies

- - - - -

## stock
## StandaloneDeriving

[GHC User's Guide - StandaloneDeriving](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/glasgow_exts.html?highlight=deriveanyclass#extension-StandaloneDeriving)

## DeriveAnyClass
## GeneralizedNewtypeDeriving
## DerivingVia

- - - - -

## おまけ

- - - - -

## ApplyingVia

- - - - -

### ApplyingVia - おまけ
