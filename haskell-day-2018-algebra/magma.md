### 代数の素朴な定義
# マグマ
## (Magma)

<aside class="notes">
最初は代数って何？ というところから、
一番制約が緩いマグマという代数までを説明します。
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
ある制約を満たす関数を持つ構造です。
Haskellでの定義を見てみましょう。
->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
class Magma a where
    (<>) :: a -> a -> a
```

<aside class="notes">
Magmaはこの形の関数を持ちます。
次にいくつかの、
マグマのインスタンスを見てみます。
->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```haskell
instance Magma Integer where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`10 + 20`, `[x, y] ++ [z]`

<aside class="notes">
Integerとリスト。
あと ->
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

<aside class="notes">
BoolやFloat、Unitなどなどがマグマになれます。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

- `<>` <- <code class='no-border'>a</code>に閉じた二項演算
- `++` <- <code class='no-border'>[a]</code>に閉じた二項演算
- `+` <- <code class='no-border'>Integer</code>に閉じた二項演算

**閉じた**（**上の**）、**二項演算**？ 🤔

<aside class="notes">
これらの関数は「aに閉じた、二項演算」または
「aの上の、二項演算」と呼ばれます。  
「閉じた」「二項演算」とは何かと言うと ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

<code class='no-border'>a</code>に閉じた（<code class='no-border'>a</code>の上の）演算とは:

:point_down: このような演算

- `a`の**値だけを受け取って**
- `a`の**値を返す**

```hs
(+) :: Integer -> Integer -> Integer
id  :: Rational -> Rational
```

<aside class="notes">
まずaに閉じた演算とは、このようなものです。  
　  
ここで誤解を恐れず言えば、
Haskellで「演算」とは主に関数のことです。  
　  
+はIntegerに閉じた演算、
このidはRationalに閉じた演算です。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

二項演算とは: **2引数の演算**

```hs
(+)       :: Integer -> Integer -> Integer
(:)       :: a -> [a] -> [a]
fromMaybe :: a -> Maybe a -> a
```

<aside class="notes">
二項演算についてはまあ単純で、
2引数の関数のことです。
ということで ->
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

:ok:
Integer上の二項演算
:ok_woman:

```hs
(+) :: Integer -> Integer -> Integer
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
まとめます。
マグマが必要とするのは、
閉じた二項演算です。  
+はIntegerに閉じた二項演算です。  
このidはRationalに閉じていますが、
二項演算ではありません。
(:)は二項演算ですが、
閉じた演算ではありません。
</aside>

- - - - -

### 代数の素朴な定義 - マグマ

```hs
class Magma a where
    (<>) :: a -> a -> a

instance Magma Integer where
    (<>) = (+)

instance Magma [a] where
    (<>) = (++)
```

`10 + 20 + ...`
`[x, y] ++ [z] ++ ...`

`True && False && ...`
`1.0 + 2.0 + ...`

<aside class="notes">
マグマ全体のまとめです。
マグマとはこのような、
aに閉じた二項演算というものを持つ構造でした。  
つまり何度も値を足し合わせることができるということです。  
　  
例えばIntegerはそのような+によってマグマになります。
リストは++を以てマグマになります。
</aside>
