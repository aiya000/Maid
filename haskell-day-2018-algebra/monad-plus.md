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

MonadPlus = **Monad** + **Monoid**

（ Alternative = **Applicative** + **Monoid** ）

:arrow_down:

MonadPlusは**高階**な**モノイド**

<aside class="notes">
MonadPlusは実は、高階なモノイドです。  
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
じゃあ「MonadPlusは高階なMonoid」っていうのはどういうことかというと……
まずは定義を見てみましょう ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

```
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
- `mzero`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'>empty</code>
- `mplus`
    - :point_up: <code class='no-border'>m</code>に由来する<code class='no-border'><></code>

<aside class="notes">
まずmはこのように高階です。  
次にmzeroとmplusはMonoidのemptyとその二項演算に対応しています。  
例えばMaybeインスタンスなら ->
</aside>

- - - - -

### 閑話休題 - MonadPlus

擬似的に書くなら……

- `Monoid (m :: * -> *)`
    - :arrow_right: <code class='no-border'>instance Monoid Maybe</code>
- `mzero :: m`
    - :arrow_right: <code class='no-border'>Nothing :: Maybe</code>
- `mplus :: m -> m -> m`
    - :arrow_right: <code class='no-border'>Nothing mplus Just = Nothing</code>
    - :arrow_right: <code class='no-border'>Just mplus Just = Just</code>

<aside class="notes">
Type -> Typeへの擬似記法として、このように書けます。
mの任意の型引数aに対してのモノイドという感じ。
</aside>

- - - - -

### 閑話休題 - MonadPlus
## MonadPlusは高階なモノイド

- - - - -

### 閑話休題 - MonadPlus
# こんなところにもモノイドが！！

<aside class="notes">
こんなところにもモノイドは応用されているんだよ、
という例でした。
</aside>
