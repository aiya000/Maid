<!-- NOTE: 閑話休題のときは高橋メソッドに切り替えてる。 -->
<!-- （そっちのが皆さん、使う頭が変わって休めるかなと思うので） -->

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

MonadPlusのモノイドしぐさ

```haskell
listMonadPlus :: [Int]
listMonadPlus = [10, 20] `mplus` mzero `mplus` [30]
-- [10,20,30]
```

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

<aside class="notes">
同値についての出典: すごいHaskell楽しく学ぼう！（モナドがいっぱい・リストモナドの章）
</aside>

- - - - -

### 閑話休題 - MonadPlus

```
guard :: Alternative f => Bool -> f ()
guard :: MonadPlus m => Bool -> m ()
```

- - - - -

### 閑話休題 - MonadPlus
# こんなところにもモノイドが！！
