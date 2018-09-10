# Haskellで定理証明
## 🤘😋🤘

- - - - -

## このスライドについて

<!-- このスライドを見ると何が理解できるのか？ -->

- - - - -

## 僕
![profile-image](profile.png)

- 名前: aiya000
- Twitter: [pubilc\_ai000ya](https://twitter.com/public_ai000ya)
- GitHub: [aiya000](https://github.com/aiya000)

- - - - -

## 技術書典5

<!-- 「当選しました、よろしくお願いします！」サークルカットと一緒に -->

- - - - -

## Haskellで定理証明をする方法
依存型でガリガリする

## Haskellで依存型を使う方法

GHCと共に↓を使う

1. [GHC.TypeLits (base)](http://hackage.haskell.org/package/base-4.11.1.0/docs/GHC-TypeLits.html)
1. [Data.Singletons (singletons)](http://hackage.haskell.org/package/singletons-2.4.1/docs/Data-Singletons.html)

### GHC.TypeLits
### Data.Singletons
#### 例えばこんなことができる

- [オレオレLisp処理系 - hs-zuramaru](https://github.com/aiya000/hs-zuramaru)
    - [Maru.QQ](https://github.com/aiya000/hs-zuramaru/blob/master/src/Maru/QQ.hs)
    - [Maru.Type.TypeLevel](https://github.com/aiya000/hs-zuramaru/blob/master/src/Maru/Type/TypeLevel.hs)

```haskell
>>> fromSing (sing :: Sing [parse|10|])
AtomInt 10

>>> fromSing (sing :: Sing [parse|(1 2 3)|])
Cons (AtomInt 1) (Cons (AtomInt 2) (Cons (AtomInt 3) Nil))
```

#### 例えばこんなことができる

これと同じ

```haskell
>>> fromSing (sing :: Sing ('HAtomicInt 10))
AtomInt 10

>>> fromSing (sing :: Sing ('HCons ('HAtomicInt 1) ('HCons ('HAtomicInt 2) ('HCons ('HAtomicInt 3) 'HNil))))
Cons (AtomInt 1) (Cons (AtomInt 2) (Cons (AtomInt 3) Nil))
```

## 本題
### Data.Singletonsで証明してみる
<!-- reverse (reverse xs) ~ xs -->
