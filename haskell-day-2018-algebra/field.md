### 代数の素朴な定義
# 体
## (Field)

<aside class="notes">
皆さんここまでついてきて頂いてありがとうございます。
これが今回の、
最後の代数になります。
</aside>

- - - - -

### 代数の素朴な定義 - 体

加法**可換群** + 乗法**可換群（※）**

:arrow_up_down:

環 + `0 ≠ 1` + **乗法逆元**

`x <> y`, `x <> inv y`  
`x >< y`, `x >< inv y`

- - -

※ **0を除く**

<aside class="notes">
体は加法と乗法の両方が群になっていて、
0 not equal 1です。  
これは実は ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

## :point_right: 四則演算ができる

<aside class="notes">
四則演算ができるということを表しています。  
Haskellで定義してみましょう。
</aside>

- - - - -

### 代数の素朴な定義 - 体

```haskell
class Ring a => Field a where
  inverseM :: a -> a
```

<aside class="notes">
環に乗法逆元の存在を加えると、
体になります。
ここで体はいくつかの制約を持ちます。
->
</aside>

- - - - -

### 代数の素朴な定義 - 体

- `0 ≠ 1`
    - 加法単位元`0`　　 ≠ 乗法単位元`1`
    - 加法単位元`emptyA` ≠ 乗法単位元`emptyM`

```haskell
emptyDifferenceLaw :: forall a.
                      (Field a, Eq a) => Bool
emptyDifferenceLaw =
    (emptyM :: a) /= (emptyA :: a)
```

<aside class="notes">
まずは加法と乗法の単位元が異なるということです。  
有りていに言うと0と1が異なる、
ということですね。  
ここであの、
いつものUnitは消えます。
Unitありがとう。  
あともう一つは ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

乗法逆元

```haskell
inverseLawForMulti :: (Field a, Eq a) => a -> Bool
inverseLawForMulti x
  | x == emptyA = True -- 「0を除く」
  | otherwise =
        (x >< inverseM x == emptyM) &&
        (inverseM x >< x == emptyM)
```

<aside class="notes">
型aの全ての値のうち、
0を除いたものが逆元を持ちます。  
例えばRationalでは ->
</aside>

- - - - -

### 代数の素朴な定義 - 体

乗法可換群（※**0を除く**）

e.g. Rational なら 群`(R', *, 1/1)` のこと

```
R' = { ..., -2/3, ...
     , -1/3, ..., 1/3
     , ..., 2/3, ...
     }
```

R'に `0/1` (`0`, `emptyA`) がないことに注意

<aside class="notes">
このように0を抜いたものになります。
</aside>

- - - - -

### 代数の素朴な定義 - 体

**四則演算**ができる

|        |              |
|--------|--------------|
| 足し算 | `x <> y`     |
| 引き算 | `x <> inv y` |
| 掛け算 | `x >< y`     |
| 割り算 | `x >< inv y` |

<aside class="notes">
体は四則演算を扱うことができます。  
引き算は足し算のうち、後側を逆元に差し替えたもの。
割り算は掛け算のうち、後側を逆元に差し替えたものとして定義できます。  
確認してみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - 体

| 　　　　　　　　                                  | 　　　　　　　  | 　　　　　　  |
|---------------------------------------------------|-----------------|---------------|
| 足し算 = <code class='no-border'>x + y</code>     | `3/2 + 1/2`     | = `4/2`       |
| 引き算 = <code class='no-border'>x + -y</code>    | `3/2 + -1/2`    | = `2/2`       |
| 掛け算 = <code class='no-border'>x \* w/v</code>  | `3/2 * 1/2`     | = `3/4`       |
| 割り算 = 　:arrow_down:                           | `3/2 * inv 1/2` | = `3/2 * 2/1` |
| 　　　<code class='no-border'>x \* inv w/v</code> |                 | = `6/2`       |

- - -

:point_up: Field Rational :point_up_2:

<aside class="notes">
Rationalを例に挙げると……  
x + -yはちゃんと引き算です。
割り算はちょっと複雑なんですけど、
掛け算の後ろの分数の、
分子と分母を入れ替えるとちゃんと割り算になりますね。
</aside>

- - - - -

### 代数の素朴な定義 - 体

「0を除く」

これをやらないと`0 = 1`になり全てが`0`になる

![](Where_Dreams_Are_Born_by_titiavanbeugen.jpg)

<aside class="notes">
0を除くというのは一見、
不自然に思えるかもしれませんが、
自然で合理的なものです。  
是非、0を除きましょう。
</aside>
