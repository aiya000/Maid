### 代数の素朴な定義
# モノイド
## (Monoid - Data.Monoid)

<aside class="notes">
モノイドって皆さん結構聞いたことあるんじゃないでしょうか。
というのも色んなところに表れる自然な構造だからですね。
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

その他インスタンス

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

その他インスタンス

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
というところで ->
</aside>

- - - - -

### 代数の素朴な定義 - モノイド

- 半群であってモノイド**でない**例
    - `Data.List.NonEmpty.NonEmpty a`
    - :point_up: 空リストのような単位元がない
    - `Data.Monoid.First a`, `Data.Monoid.Last a`

<aside class="notes">
NonEmpty aはモノイドにはなれません。
また、
与えられた値のうち最初のものを返すFirstや、
与えられた値のうち最後のものを返すLastも初期値がありません。
</aside>
