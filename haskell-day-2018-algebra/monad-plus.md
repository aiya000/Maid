# 閑話休題

- - - - -

# 皆さん

- - - - -

# Monadは
# お好きですか？

- - - - -

# MonadPlus
#### Control.Monad.MonadPlus

- - - - -

### 閑話休題 - MonadPlus

MonadPlus = **Monad** + **Monoid**

（ Alternative = **Applicative** + **Monoid** ）

:arrow_down:

MonadPlusは**高階**な**モノイド**

- - -

`MonadPlus m`が全ての`a`に対して`Monoid (m a)`

<aside class="notes">
MonadPlusって実はモノイドです。  
MonadPlusってなんだっけ……？ っていうと ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

リスト内包記（双子素数）

```haskell
twinPrimes :: [(Int, Int)]
twinPrimes = do
    (x, y) <- zip primes (tail primes)
    guard $ y - x == 2
    return (x, y)
-- [(3,5),(5,7),(11,13),(17,19),(29,31),(41,43), ...]
```

<aside class="notes">
こんな感じのものでした。  
じゃあ「MonadPlusはMonoid」っていうのはどういうことかというと……
まずは定義を見てみましょう ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

```hs
class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a
```

<aside class="notes">
これがどのような意味かというと ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

- `MonadPlus (m :: * -> *)`
    - :point_up: 高階 (<code class='no-border'>\* -> \*</code>)
- `mzero :: m a`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'>empty</code>
- `mplus :: m a -> m a -> m a`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'><></code>

<aside class="notes">
まずmはこのように高階です。  
次にmzeroとmplusはMonoidのemptyとその二項演算に対応しています。
mplusはちゃんとm aに閉じてますね。  
例えばmの例としてMaybeを挙げると ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

- `Monoid (m a)`
    - :arrow_right: <code class='no-border'>Monoid (Maybe a)</code>
- `empty :: m a`
    - :arrow_right: <code class='no-border'>Nothing :: Maybe a</code>
- `(<>) :: m a -> m a -> m a`
    - :arrow_right: <code class='no-border'>Nothing <> Just y = Nothing</code>
    - :arrow_right: <code class='no-border'>Just x <> Just y = Just x</code>

<aside class="notes">
このように書けます。
mの型引数がaであれbであれ、
m aはモノイド……
という感じ。
</aside>

- - - - -

## MonadPlusは高階なモノイド

#### (`MonadPlus m`が全ての`a`に対して`Monoid (m a)`)

- - - - -

# こんなところにもモノイドが！！

<aside class="notes">
こんなところにもモノイドは応用されているんだよ、
という話でした。
では素朴な代数の話に戻りまして ->
</aside>
