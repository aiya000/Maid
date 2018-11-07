### 代数の素朴な定義
# 体
## (Field)

- - - - -

### 代数の素朴な定義 - 体

加法**可換群** + 乗法**可換群（※）**

:arrow_up_down:

環 + `0 ≠ 1` + **乗法逆元**

`x <> y`, `x <> inv y`  
`x >< y`, `x >< inv y`

- - -

※ **0を除く**

- - - - -

### 代数の素朴な定義 - 体

## :point_right: 四則演算ができる

- - - - -

### 代数の素朴な定義 - 体

```haskell
class Ring a => Field a where
  inverseM :: a -> a
```

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

- - - - -

### 代数の素朴な定義 - 体

乗法可換群（※0を除く）

e.g. Rational なら 群`(R', *, 1/1)` のこと

```
R' = { ..., -2/3, ...
     , -1/3, ..., 1/3
     , ..., 2/3, ...
     }
```

R'に `0/1` (`0`, `emptyA`) がないことに注意

- - - - -

### 代数の素朴な定義 - 体

**四則演算**ができる

|        |              |
|--------|--------------|
| 足し算 | `x <> y`     |
| 引き算 | `x <> inv y` |
| 掛け算 | `x >< y`     |
| 割り算 | `x >< inv y` |

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

- - - - -

### 代数の素朴な定義 - 体

「0を除く」

これをやらないと`0 = 1`になり全てが`0`になる

![](Where_Dreams_Are_Born_by_titiavanbeugen.jpg)
