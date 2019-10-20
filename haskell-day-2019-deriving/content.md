　
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
では自己紹介はここまでにして、次にいきましょう。
このセッションで最初に学べることは…… ->
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
## derivingテクノロジーの全体像

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

### そもそもderivingとは - GHCの提供するderivingテクノロジーの...

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

### GHCの提供するderivingテクノロジーの全体像

- stock (Haskell標準のderiving)
- anyclass (`DeriveAnyClass`)
- newtype (`GeneralizedNewtypeDeriving`)
- via (`DerivingVia`)

＞＞＞ 多い ＜＜＜

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
