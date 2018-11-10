## ある型の複数の
## マグマインスタンスについて

- - - - -

## ある型に対してマグマの実装は必ずしも**唯一じゃない**

<aside class="notes">
「ある型に対してマグマの実装は必ずしも唯一じゃない」
んですよね。
どういう意味かというと ->
</aside>

- - - - -

```hs
instance Magma Integer where
    (<>) = (+)

instance Magma Integer where
    (<>) = (*)
```

🤔

<aside class="notes">
Integerの足し算も掛け算はどちらもIntegerについて閉じており、
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
この解決策として ->
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
IntegerやFloatの新しいインスタンスで ->
</aside>

- - - - -

### 代数の素朴な定義

```haskell
newtype And = And Bool deriving (Show, Eq)
newtype Or = Or Bool deriving (Show, Eq)

instance Magma And where
    And x <> And y = And $ x && y
instance Magma Or where
    Or x <> Or y = Or $ x || y
```

<aside class="notes">
Boolについても各々のnewtypeを追加していきます。  
BoolのAndとOrはこう。
同様にXorについて ->
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
こうです。  
Unitについてはインスタンスが唯一つなので、
新しく定義はしません。  
　  
というところで、
代数の導入は完了です。  
次の代数にいきましょう。
->
</aside>
