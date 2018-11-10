### 代数の素朴な定義
# 群
## (Group)

<aside class="notes">
群という、
けっこう制約が強い代数があります。
群では ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `x^-1`

`x^-1 <> x` = `e` = `x <> x^-1`

<aside class="notes">
その全ての値xについてその逆元、
xのマイナスイチ乗という値が定まります。
この逆元の法則をHaskellで書くと ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `inverse x`

```haskell
inverseLaw :: (Group a, Eq a) => a -> Bool
inverseLaw x =
  (x <> inverse x == empty) &&
  (inverse x <> x == empty)
```

<aside class="notes">
こんな感じ。
xとその逆元を合わせると、
単位元になります。
ということで群の定義は ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

```haskell
class Monoid a => Group a where
  inverse :: a -> a

instance Group (Sum Integer) where
  inverse = negate

instance Group Xor where
  inverse = id
```

<aside class="notes">
こうなります。
Monoidにinverseという関数生えてます。  
例えばこのIntegerの足し算は ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `3 + (-3)` = `0`
- `5 + (-5)` = `0`
- `7 + (-7)` = `0`

<aside class="notes">
このように逆元の法則を満たします。
これはけっこう直感的で、
群の性質を理解するのにいいんじゃないかと思います。
Xorインスタンスは ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `True xor True` = `False`
- `False xor False` = `False`

<aside class="notes">
単位元がFalseなので、
このように法則を満たします。
->
</aside>

- - - - -

### 代数の素朴な定義 - 群

- モノイドであって群**でない**例
    - `And`
    - `Or`
    - `Product Integer`
    - `Product Rational`
    - `[a]`

<aside class="notes">
群の要請する「逆元の存在」っていうのは結構厳しい制約で、
これを満たせない構造は多いです。  
これらが群になれない原因を見てみます。
->
</aside>

- - - - -

### 代数の素朴な定義 - 群

これらは以下がないので群になれない

- `And`: `False && inverse False == True`な  
  　　　:point_right: `inverse False`

- `Or`: `True || inverse True == False`な  
  　　　:point_right: `inverse True`

<aside class="notes">
Andの単位元はTrueですが、
片方がFalseだとどうあがいてもFalseに写ってしまうので、
Falseの逆元がありません。  
Orも同様に、
片方がTrueだとどうあがいてもTrueになってしまうので、
Falseには写れません。
</aside>

- - - - -

### 代数の素朴な定義 - 群

これは以下がないので群になれない

- `[a]`: `[x, y] ++ inverse [x, y] == []`な  
  　　　:point_right: `inverse [x, y]`

<aside class="notes">
リストには「逆」という概念が全くないので、
まさに群でない例としてわかりやすいんじゃないかと思います。
</aside>

- - - - -

### 代数の素朴な定義 - 群

- `Product Integer`:   
  　　例えば`10 * 1/10 == 1`だけど  
  　　:point_right: `1/10`はIntegerではない

　

- `Product Rational`:   
  　　一般に`x/y * y/x == 1/1`っぽいけど  
  　　:point_right: `0/10 * 10/0`がゼロ除算

<aside class="notes">
これらは一見、
群になりそうなのですが、
1/10がIntegerから溢れてしまったり、
ゼロ除算が発生してしまったりします。  
ゼロ除算、怖いですね。  
というところで反例については以上です。
</aside>

- - - - -

### 代数の素朴な定義 - 群

応用例

- [ElGamal暗号](https://ja.wikipedia.org/wiki/ElGamal%E6%9A%97%E5%8F%B7)
- [楕円曲線暗号](https://ja.wikipedia.org/wiki/%E6%A5%95%E5%86%86%E6%9B%B2%E7%B7%9A%E6%9A%97%E5%8F%B7)

<aside class="notes">
群やそれ以降の代数は数学的分野で応用されています。  
プログラミングで直に触れることは少ないんじゃないかと思います。
</aside>

- - - - -

### 代数の素朴な定義 - 群

```haskell
instance Group (Sum Rational) where
  inverse = negate

instance Group () where
  inverse () = ()
```

<aside class="notes">
他のインスタンスはこれらがあります。
Unitはいつものやつですね。
</aside>

- - - - -

### 代数の素朴な定義 - 群

```hs
class Monoid a => Group a where
  inverse :: a -> a

instance Group (Sum Integer) where
  inverse = negate

instance Group Xor where
  inverse = id
```

`10 + -10` = `-10 + 10` = `0`

`True xor True` = `False`,
`False xor False` = `False`

<aside class="notes">
群についてのまとめです。  
群aはaの全ての値に対して、
その逆元というものが定まるものでした。  
インスタンスはIntegerとRationalの足し算、
BoolのXor、
Unitがあります。  
逆元の要請はけっこう厳しくて、
インスタンスになれる構造がそう多くありません。  
というところで ->
</aside>
