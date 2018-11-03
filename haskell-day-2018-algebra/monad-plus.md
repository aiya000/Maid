<!-- NOTE: 閑話休題のときは高橋メソッドに切り替えてる。 -->
<!-- （そっちのが皆さん、使う頭が変わって休めるかなと思うので） -->

<!--
TODO: 「MonadPlusは高階なモノイド」という主張の妥当性を確認してもらう。
-->

# 閑話休題

- - - - -

# 皆さん

- - - - -

# Monadは
# お好きですか？

- - - - -

# MonadPlus

- - - - -

### 閑話休題 - MonadPlus

MonadPlus = Monad + **Monoid**

（ Alternative = Applicative + **Monoid** ）

- - - - -

### 閑話休題 - MonadPlus

```
class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a
```

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```haskell
twinPrimes :: [(Int, Int)]
twinPrimes =
    [ (x, y) | (x, y) <- zip primes (tail primes)
             , y - x == 2 ]
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

:point_up: 双子素数

<aside class="notes">
MonadPlusが何かって言うと、
わかりやすいのがこれですね。
</aside>

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```
[ 略 | 略, y - x == 2 ]
           ^^^^^^^^^^
```
ここ :point_up: めっちゃMonadPlus

<aside class="notes">
実はここ、めっちゃMonadPlusなんです。
</aside>

- - - - -

### 閑話休題 - MonadPlus

- `MonadPlus (m :: * -> *)`
    - :point_up: 高階なモノイド (`* -> *`)
- `mzero`
    - :point_up: mに由来するempty
- `mplus`
    - :point_up: mに由来する<>

<aside class="notes">
mzeroも高階なemptyで、
mに由来しているものです。
</aside>

- - - - -

### 閑話休題 - MonadPlus

擬似的に書くなら……

- `Monoid (m :: * -> *)`
    - :point_up: `instance Monoid Maybe`
- `mzero :: m`
    - :point_up: `Nothing :: Maybe`
- `mplus :: m -> m -> m`
    - :point_up: `Nothing mplus Just = Nothing`
    - :point_up: `Just mplus Just = Just`

<aside class="notes">
mの任意の型引数aに対してのモノイドという感じ。
</aside>

- - - - -

### 閑話休題 - MonadPlus

例: MonadPlusのモノイドしぐさ

```haskell
listMonadPlus :: [Int]
listMonadPlus = [10, 20] `mplus` mzero `mplus` [30]
-- [10,20,30]
```

<aside class="notes">
これを見ても、なんだかモノイドな感じがしますよね。
</aside>

- - - - -

### 閑話休題 - MonadPlus

リスト内包記

```
twinPrimes :: [(Int, Int)]
twinPrimes =
    [ (x, y) | (x, y) <- zip primes (tail primes)
             , y - x == 2 ]
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

- - - - -

### 閑話休題 - MonadPlus

リスト内包記と**同値なdo式**

```haskell
twinPrimes' :: [(Int, Int)]
twinPrimes' = do
    (x, y) <- zip primes (tail primes)
    guard $ y - x == 2
    return (x, y)
```

- - -

#### 同値についての出典:
#### すごいHaskell楽しく学ぼう！（モナドがいっぱい・リストモナドの章）

- - - - -

### 閑話休題 - MonadPlus

```
guard :: Alternative f => Bool -> f ()
guard :: MonadPlus m => Bool -> m ()
```

もし引数が真なら、（高階な）単位元を返す。

```
guard False >> pure 10  =  mzero >> pure 10
                        =  [] >> pure 10
                        =  []
```

- - - - -

### 閑話休題 - MonadPlus
## つまりMonadPlusは高階なモノイド

- - - - -

### 閑話休題 - MonadPlus
# こんなところにもモノイドが！！
