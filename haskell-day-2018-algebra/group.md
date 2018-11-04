### 代数の素朴な定義
# 群
## (Group)

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `x^-1`

`x^-1 <> x` = `e` = `x <> x^-1`

- - - - -

### 代数の素朴な定義 - 群

モノイド + **任意の元に対する逆元** `inverse x`

```haskell
inverseLaw :: (Group a, Eq a) => a -> Bool
inverseLaw x =
  (x <> inverse x == empty) && (empty == inverse x <> x)
```

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

- - - - -

## ん、Xor……？
## さっきまでいた
## Andはどこいった……？

- - - - -

# Andはねぇ
# シンじゃったヨォ
# …… 🤓

- - - - -

### 代数の素朴な定義 - 群

- モノイドであって群**でない**例
    - `And`
    - `Or`
    - `Product Integer`
    - `Product Rational`
    - `[a]`

<aside class="notes">
ってことで。
群の要請する「逆元の存在」っていうのは結構厳しい制約で、
これを満たせない構造は多いです。  
これらが群になれない原因を見てみましょう ->
</aside>

- - - - -

### 代数の素朴な定義 - 群

これらは以下がないので群になれない

- `And`: `False && inverse False == True`な  
  　　　:point_right: `inverse False`

　

- `Or`: `True || inverse True == False`な  
  　　　:point_right: `inverse True`

- - - - -

### 代数の素朴な定義 - 群

これは以下がないので群になれない

- `[a]`: `[x, y] ++ inverse [x, y] == []`な  
  　　　:point_right: `inverse [x, y]`

- - - - -

### 代数の素朴な定義 - 群

- `Product Integer`:   
  　　例えば`10 * 1/10 == 1`だけど  
  　　:point_right: `1/10`はIntegerではない

　

- `Product Rational`:   
  　　一般に`x/y * y/x == 1/1`っぽいけど  
  　　:point_right: `0/10 * 10/0`がゼロ除算

- - - - -

### 代数の素朴な定義 - 群

応用例

- [ElGamal暗号](https://ja.wikipedia.org/wiki/ElGamal%E6%9A%97%E5%8F%B7)
- [楕円曲線暗号](https://ja.wikipedia.org/wiki/%E6%A5%95%E5%86%86%E6%9B%B2%E7%B7%9A%E6%9A%97%E5%8F%B7)

- - - - -

### 代数の素朴な定義 - 群

その他インスタンス

```haskell
instance Group (Sum Rational) where
  inverse = negate

instance Group () where
  inverse () = ()
```
