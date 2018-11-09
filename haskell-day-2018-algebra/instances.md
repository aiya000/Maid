# ところで……

<aside class="notes">
ところでですね ->
</aside>

- - - - -

## ある型に対してマグマの実装は必ずしも**唯一じゃない**

<aside class="notes">
「ある型に対してマグマの実装は必ずしも唯一じゃない」
んですよね。
どういう意味かというと ->
</aside>

- - - - -

```hs
instance Magma Int where
    (<>) = (+)

instance Magma Int where
    (<>) = (*)
```

🤔

<aside class="notes">
Intの足し算も掛け算はどちらもIntについて閉じており、
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
というところで解決策として ->
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
Xorも同じく。
->
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
というところで、
まず代数とは何かというところは完了です。  
次にいきましょう。
次は ->
</aside>
