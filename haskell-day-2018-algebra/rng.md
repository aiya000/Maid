### 代数の素朴な定義
# 擬環
## (Rng)

- - - - -

### 代数の素朴な定義 - 擬環

（加法）**可換群** + （乗法）**可換半群**

- - -

分配法則

`x (y <> z)` = `xy <> xz`  
`(x <> y) z` = `xz <> yz`

<aside class="notes">
擬環は可換群と可換半群の組み合わせです。
足し算と掛け算の両方ができるってことですね。  
かつ「分配」ができます。
この分配の法則をHaskellのコードで表すと ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
distributiveLaw :: (Rng a, Eq a) =>
                   a -> a -> a -> Bool
distributiveLaw x y z =
  x >< (y <> z) == x >< y <> x >< z
    &&
  (x <> y) >< z == x >< z <> y >< z
```

加法: `<>`, 乗法: `><`

<aside class="notes">
こうなります。  
この先っぽが内側に向いている方の二項演算子大なり小なりを加法。
今までもでてきてた先っぽが外側に向いている二項演算を乗法って言います。
乗法は加法よりも結合優先度が高いことに注意です。  
そしたら擬環の定義を見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

- 加法群`(a, <>, emptyA, inverseA)`
- 乗法半群`(a, ><)`

```haskell
class Rng a where
    (<>)     :: a -> a -> a
    emptyA   :: a
    inverseA :: a -> a
    (><)     :: a -> a -> a
infixl 6 <>
infixl 7 ><
```

<aside class="notes">
ここで「型aとその加法の二項演算><・emptyA・inverseA」の組み合わせを加法群、
「型aとその乗法の二項演算<>」を乗法って言います。  
加法群は群なので ->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

加法単位元（**零元**） と 各値に対する加法逆元

```hs
emptyA   :: a
inverseA :: a -> a
```

<aside class="notes">
単位元と、
aの全ての値に応じた逆元を持ちます。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

擬環は……

**分配**をするために  
必要なものを定めたプロトコル :point_left: 🤓

`2 * (5 + 2)` = `2*5 + 2*2`

<aside class="notes">
つまるところ擬環は、
分配を十分に行うための代数です。  
分配とは(5 + 2)に対して2を掛けると、
足し算に区切られた各値に2が掛けられるものです。  
インスタンスを見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
-- 2 * (5 + 2)  =  2*5 + 2*2
--              =  10 + 4
--              =  14
instance Rng Integer where
    (<>)     = (+)
    emptyA   = 0
    inverseA = negate
    (><)     = (*)
```

<aside class="notes">
まずはInteger。  
足し算についての群が加法、
掛け算についての半群が乗法なので、
加法・乗法という言い回しがストンとくるんじゃないでしょうか。  
ちなみに足し算と掛け算を分ける必要がなくなったので、
newtypeは使う必要もなくなりました。
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
instance Rng Rational where
    (<>)     = (+)
    emptyA   = 0 % 1
    inverseA = negate
    (><)     = (*)
```

<aside class="notes">
Rationalも同じく、
足し算と掛け算の擬環を定義できます。
あとはBoolの擬環です。
->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

```haskell
-- True && (False `xor` True)
--      = (True&&False) `xor` (True&&True)
--      = True
instance Rng Bool where
    (<>)     = xor
    emptyA   = False
    inverseA = id
    (><)     = (&&)
```

<!--

```haskell
xor :: Bool -> Bool -> Bool
xor True False = True
xor False True = True
xor _ _ = False
```

-->

<aside class="notes">
Boolはxorとandで擬環を定義できます。  
最後にもう一つインスタンスを見て、
擬環を終わります。
->
</aside>

- - - - -

### 代数の素朴な定義 - 擬環

い　つ　も　の

```haskell
instance Rng () where
    () <> ()    = ()
    emptyA      = ()
    inverseA () = ()
    () >< ()    = ()
```

<aside class="notes">
はい、
いつものですね。
</aside>
