### 代数の素朴な定義
# 環
## (Ring)

<aside class="notes">
次は擬環に少しの概念を加えた代数である環を、
軽く説明します。
</aside>

- - - - -

### 代数の素朴な定義 - 環

加法**可換群** + 乗法**可換モノイド**

:arrow_up_down:

擬環 + 乗法**単位元** 1

`1 (x <> y) z` = `(x <> y) z`  
`x (y <> z) 1` = `x (y <> z)`

<aside class="notes">
環は擬環に対して乗法の単位元を加えたものです。  
つまり加法可換群と乗法可換モノイドの組み合わせです。
定義は ->
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
class Rng a => Ring a where
    emptyM :: a
```

<aside class="notes">
こうなります。
インスタンスを見てみると ->
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
instance Ring Integer where
    emptyM = 1

instance Ring Rational where
    emptyM = 1 % 1
```

<aside class="notes">
いつもと同じく掛け算に対して1です。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```haskell
instance Ring Bool where
    emptyM = True

instance Ring () where -- 🤓
    emptyM = ()
```

<aside class="notes">
Bool環の乗法単位元は、
Andの単位元と同じものです。  
あとはいつもの。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```hs
class Rng a => Ring a where
    emptyM :: a
```

`1 >< x` = `x >< 1` = `x`

<aside class="notes">
というところでまとめます。  
環は擬環に加え、
乗法単位元を備えた代数です。
</aside>

- - - - -

### 代数の素朴な定義 - 環

```hs
instance Ring Integer where
    emptyM = 1

instance Ring Rational where
    emptyM = 1 % 1

instance Ring Bool where
    emptyM = True
```

`1 * 10` = `10 * 1`,
`2/3 * 1/1` = `1/1 * 2/3`

`False && True` = `True && False`

<aside class="notes">
インスタンスには環と同じくIntegerとRational、
BoolとUnitがあります。
</aside>
