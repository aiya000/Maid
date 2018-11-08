### 代数の素朴な定義
# マグマ
## (Magma)

<aside class="notes">
一番制約が緩い代数、マグマ。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

**足し算**（あるいは**掛け算**）  
ができる構造

```
x <> y <> z
```

`<>` ← 足し算（あるいは掛け算）

<aside class="notes">
マグマは足し算あるいは掛け算のような、
いわゆる「構造に閉じた」「二項演算」が行えるものです。  
Haskellで書くと…… ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
class Magma a where
    (<>) :: a -> a -> a

instance Magma Int where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`<>` ← aに閉じた（aの上の）二項演算

<aside class="notes">
こんな感じ。
例えばIntやリストがマグマとして挙げられます。
あとは ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
instance Magma Bool where
    (<>) = (&&)

instance Magma Float where
    (<>) = (+)

instance Magma () where
    () <> () = ()
```

`<>` ← aに閉じた（aの上の）二項演算

<aside class="notes">
BoolやFloat、Unitなどなど。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

**閉じた**（**上の**）、**二項演算**？ 🤔

- - - - -

### 代数の素朴な定義 - マグマ

aに閉じた（aの上の）演算とは:

:point_down: このような演算

- `a`の値だけを受け取って
- `a`の値を返す

```hs
(+) :: Int -> Int -> Int
id  :: Rational -> Rational
```

<aside class="notes">
ここで誤解を恐れず言えば、
Haskellで「演算」とは主に関数のことです。  
なのでaに閉じた演算、aの上の演算とは、
このような関数のことです。  
Intの上の演算+、
Rationalの上の演算idですね。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

二項演算とは: **2引数の演算**

```hs
(+)       :: Int -> Int -> Int
(:)       :: a -> [a] -> [a]
fromMaybe :: a -> Maybe a -> a
```

<aside class="notes">
二項演算とは。
これはまあ単純で、
2引数の演算のことです。  
これらは二項演算です。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

:ok:
Int上の二項演算
:ok_woman:

```hs
(+) :: Int -> Int -> Int
```

- - -

:no_good:
二項演算ではない
:ng:

```hs
id :: Rational -> Rational
```

:no_good:
aにも[a]にも閉じていない
:ng:

```hs
(:) :: a -> [a] -> [a]
```

<aside class="notes">
ということでまとめです。  
Magma aとはa上の、aに閉じた二項演算を持つ構造です。  
Intはそのような+を持つので、
マグマになれます。  
また、下記の2つは閉じた二項演算ではありません。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

応用例: concatL, concatR

```haskell
concatL :: Magma a => a -> [a] -> a
concatL = foldl (<>)

concatR :: Magma a => a -> [a] -> a
concatR = foldr (<>)
```

その `Magma a` に沿った性質の集約を行う関数 :point_up:

<aside class="notes">
簡素ではありますが、
応用例としてはこのような関数が考えられます。  
例えば先程挙げたIntやFloatなら数の総和を、
Boolなら「全てがTrueであるか否か」を求めます。  
各々の型に対して適宜そのような関数を定義するよりも、
こちらを使った方がわかりやすいですね。
</aside>
